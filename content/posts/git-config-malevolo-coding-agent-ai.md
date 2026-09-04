---
title: "Un .git/config malevolo può far eseguire codice a Claude Code, Cursor e Codex prima ancora che se ne accorgano"
date: 2026-09-04
draft: false
tags: ["sicurezza", "ai", "homelab"]
categories: ["Sicurezza"]
description: "Manifold Security ha scoperto che Claude Code, Cursor e Codex eseguono un comando nascosto nel .git/config prima dei controlli di sicurezza dell'agente."
cover:
  image: "/images/posts/git-config-malevolo-coding-agent-ai.png"
  alt: "Illustrazione di un file .git/config compromesso che attacca un coding agent AI"
---

Se cloni repository di terzi e ci lavori dentro con un coding agent AI, la cosa da sapere subito è questa: un file `.git/config` può contenere un comando che parte da solo, appena l'agente tocca quel repository, prima ancora che i suoi filtri di sicurezza entrino in gioco. Non serve eseguire nessun prompt sospetto, non serve dare il permesso a niente: basta aprire la cartella. Riguarda chiunque usi Claude Code, Cursor, Codex o strumenti simili su codice scaricato da GitHub, da un archivio zip, da una chiavetta USB o da una cartella sincronizzata con qualcun altro. La mitigazione richiede letteralmente un comando e trenta secondi, la spiego più sotto.

I ricercatori di Manifold Security hanno pubblicato la scoperta il 2 settembre 2026, e riguarda sette agenti di coding AI: Claude Code, Codex, Cursor, Hermes Agent, Qwen Code, Grok Build e goose. Il problema sta in un parametro di configurazione git legittimo, `core.fsmonitor`, che questi strumenti eseguono in automatico non appena interagiscono con il repository, senza chiedere conferma.

## Cosa fa davvero core.fsmonitor

`core.fsmonitor` è una feature reale di Git, pensata per velocizzare `git status` su repository enormi: invece di scansionare l'intero filesystem a ogni comando, Git delega il monitoraggio dei file cambiati a un processo esterno (di solito Watchman) e si fida del risultato. Il parametro nel `.git/config` può puntare a un eseguibile qualunque, e Git lo invoca da solo, silenziosamente, ogni volta che serve sapere cosa è cambiato nel working tree.

Il problema è che "un eseguibile qualunque" include qualunque comando di sistema, senza eccezioni. Metti dentro `.git/config` un `core.fsmonitor` che punta a uno script che scarica ed esegue un payload, e hai un innesco automatico che scatta al primo comando git eseguito dentro quella cartella. Fin qui è un problema di Git in generale, noto da anni a chi si occupa di supply chain security: non a caso GitHub disabilita `core.fsmonitor` sui repository clonati dai propri Codespaces.

Quello che Manifold ha scoperto di nuovo è che i coding agent AI se lo portano dietro senza saperlo. Quando apri un progetto con Claude Code o Cursor, questi strumenti lanciano comandi git internamente per orientarsi nel repository (stato, branch, log), ed è lì che il comando malevolo nel `.git/config` parte, con i privilegi dell'utente che ha avviato l'agente. Il punto critico è il timing: scatta prima che i controlli di sicurezza dell'agente, quelli pensati per bloccare comandi sospetti proposti dall'AI, abbiano anche solo la possibilità di intervenire. Non è l'agente a decidere di eseguire quel comando, è Git stesso a farlo come effetto collaterale di un'operazione che sembra innocua.

## Perché non serve nessuna interazione da parte tua

La parte che trovo più fastidiosa di questa storia è quanto poco serva per essere colpiti. Non devi incollare un prompt malevolo, non devi dare il via libera a un tool che l'agente ti propone, non devi cliccare "conferma" su nessun popup. Ti basta clonare un repository malevolo, o scaricare uno zip e scompattarlo, oppure copiare una cartella da una chiavetta USB o da un drive condiviso, e poi aprirla con Claude Code, Cursor o uno degli altri agenti coinvolti, come faresti con qualunque progetto su cui vuoi farti aiutare a lavorare.

Il repository malevolo non ha bisogno di avere niente di strano nel codice sorgente, che potrebbe anche sembrare del tutto pulito a un occhio umano o a una scansione antivirus superficiale. Il payload sta in un file che normalmente nessuno guarda, dentro `.git/`, una cartella che i tool di revisione del codice e persino molti editor tendono a nascondere di default.

È esattamente lo scenario che un ricercatore, uno studente che collabora su un progetto universitario, o chiunque riceva "dai prova questo repo" da uno sconosciuto su Discord o Reddit, incontra regolarmente. E oggi sempre più persone aprono quei repository direttamente con un coding agent, invece che con un semplice editor di testo, proprio per farsi spiegare cosa fa il codice prima di fidarsene.

## La mitigazione: due comandi, non uno

Per fortuna qui non c'è bisogno di aspettare una patch dai vendor degli agenti. La difesa è lato Git e la applichi tu, subito:

```
git config --global core.fsmonitor false
```

Questo disattiva `fsmonitor` a livello globale su tutte le tue repository, non solo su quella che stai aprendo in questo momento. È l'unica impostazione che conta davvero, perché agisce a monte, indipendentemente da quale coding agent (o anche solo terminale) tu stia usando per interagire col repository.

Il secondo passo è un'abitudine, non un comando: prima di aprire con un agente AI un repository che non hai scritto tu o di cui non ti fidi al cento per cento, dai un'occhiata a `.git/config`. È un file di testo, si legge in cinque secondi, e se vedi un parametro `fsmonitor` che punta a uno script o a un binario che non ti aspetti, hai la tua risposta. Vale lo stesso discorso per gli hook in `.git/hooks/`, altro punto classico dove nascondere codice che parte da solo su comandi git comuni come `commit` o `checkout`.

## Perché mi tocca da vicino, e forse anche te

Uso Claude Code tutti i giorni, anche su repository che non ho scritto io: progetti open source che voglio capire, PR di contributor esterni su cose mie, codice di esempio linkato da un post o da un video. È esattamente il flusso di lavoro che questa vulnerabilità sfrutta, e il motivo per cui l'ho presa sul serio appena l'ho letta invece di archiviarla come l'ennesimo CVE che non mi riguarda.

Non è la prima volta che uno strumento pensato per restare "sotto il tuo controllo" in locale nasconde un modo per eseguire codice senza che tu lo voglia: capitò qualcosa di concettualmente simile con [Grok Build](/posts/grok-build-prometteva-tutto-locale-poi-caricava-interi-repository-password-comprese-sul-cloud-di-xai/), e più di recente il worm [Shai-Hulud su npm](/posts/shai-hulud-worm-npm-supply-chain/) ha mostrato come proprio gli hook di editor e agenti AI siano diventati un bersaglio ricorrente per chi scrive malware, non un dettaglio marginale.

La lezione di fondo, per me, è che i coding agent AI ereditano tutta la superficie di attacco di Git, oltre a quella propria. I loro guardrail proteggono da comandi che l'AI stessa propone di eseguire, ma non da un comportamento di Git che parte in automatico prima che l'agente entri in scena. È un tipo di rischio diverso da quello a cui questi strumenti ci hanno abituato a pensare, e vale la pena disattivare `fsmonitor` oggi stesso, anche se non hai in programma di aprire repository sospetti nel breve termine: è gratis, non toglie nulla in termini di funzionalità per l'uso quotidiano, e ti mette al riparo da un vettore che nessun antivirus intercetta.

Fonte: [The Hacker News](https://thehackernews.com/2026/09/malicious-git-configs-can-make-claude.html)
