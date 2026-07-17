---
title: "Grok Build prometteva 'tutto locale'. Poi caricava interi repository (password comprese) sul cloud di xAI"
date: 2026-07-18
draft: false
tags: ["ai", "sicurezza", "xai", "grok", "cli-tools", "privacy", "homelab"]
categories: ["Intelligenza Artificiale"]
description: "Il CLI di coding di xAI, Grok Build, mandava silenziosamente interi repository Git (segreti in chiaro inclusi) su un bucket Google Cloud gestito da xAI, nonostante promettesse elaborazione locale. Cosa insegna a chi usa CLI AI sul proprio codice."
cover:
  image: "/images/posts/grok-build-prometteva-tutto-locale-poi-caricava-interi-repository-password-comprese-sul-cloud-di-xai.png"
---

Ogni volta che installo un CLI AI sul mio homelab la prima cosa che faccio è aprire Wireshark, o quantomeno dare un'occhiata a `netstat` mentre lavora. Sembra paranoia, ma la storia di Grok Build di questa settimana dimostra che non lo è affatto.

Il caso, riportato da [The Register](https://www.theregister.com/ai-and-ml/2026/07/14/musk-promises-purge-after-grok-build-caught-sending-entire-repos-to-the-cloud/5271123), è di quelli che fanno male perché confermano il sospetto peggiore: un ricercatore ha scoperto che Grok Build, il CLI di coding assistito da AI di xAI, caricava silenziosamente interi repository Git su un bucket Google Cloud gestito da xAI. Non file selezionati, non snippet, non il contesto minimo necessario per il completamento del codice. Repository interi, con dentro tutto quello che normalmente sta in un progetto: chiavi API, password in chiaro dimenticate in un `.env` non ignorato, credenziali di test lasciate lì "tanto è solo in locale".

Il punto che brucia di più è che Grok Build veniva venduto proprio sulla promessa opposta: elaborazione locale, il codice resta sulla tua macchina. È lo stesso argomento di vendita che usano quasi tutti i CLI AI oggi, il mio incluso quando valuto quale usare per lavoro: "non ti preoccupare, gira in locale, mandiamo solo il minimo indispensabile". Qui il minimo indispensabile era, a quanto pare, tutto.

## Perché non è un dettaglio da nerd paranoici

Chi lavora con Claude Code, Cursor, Copilot Workspace o qualunque altro agente da terminale sa che questi strumenti hanno accesso al file system per definizione: devono leggere il codice per essere utili. Il problema non è l'accesso in sé, è cosa succede a quei dati dopo. Un conto è che il modello legga un file per generare un suggerimento e lo scarti subito dopo. Un altro conto è che l'intero repository finisca su uno storage bucket di terze parti (in questo caso non proprio terze parti, ma xAI stessa) senza che tu l'abbia mai autorizzato esplicitamente né te ne sia accorto.

E qui casca l'asino di tanti homelab e piccoli team: i repository privati sono pieni di segreti perché nessuno ha tempo di fare le cose per bene tutte le volte. `.env` che finisce nel commit per sbaglio, credenziali AWS lasciate in un file di config "temporaneo" che poi resta lì per mesi, token di accesso hardcoded in uno script di test. Lo so perché l'ho fatto anch'io, e probabilmente l'hai fatto anche tu. Finché quei segreti restano sul tuo disco il rischio è contenuto. Nel momento in cui un tool li carica su un bucket cloud gestito da un'azienda terza, quel rischio diventa un incidente di sicurezza vero, con superficie d'attacco che non controlli più.

## La reazione: cancellazione promessa, codice open

La storia è finita in prima pagina su Hacker News, cosa che raramente fa bene alla reputazione di un prodotto lanciato da poco. Musk ha promesso la cancellazione dei dati caricati. xAI ha disabilitato la funzione di upload e, mossa quasi obbligata a questo punto, ha rilasciato il codice di Grok Build come Apache 2.0.

Apprezzo la trasparenza forzata — meglio open source dopo un incidente che nessuna trasparenza — ma non mi basta come rassicurazione. "Promettiamo di cancellare i dati" è una frase che si può dire, non verificare. Se i tuoi segreti sono già finiti su un bucket che non controlli, la cancellazione lato loro non ti restituisce la certezza che nessuno li abbia già copiati, loggati o indicizzati nel frattempo. Il danno, se c'è stato, è già fatto nel momento dell'upload, non nel momento della cancellazione promessa.

## Cosa faccio io prima di far girare un CLI AI su un mio repo

Non serve diventare paranoici al punto da rinunciare a questi strumenti, che restano utili. Ma qualche accorgimento pratico lo applico sempre:

Prima cosa, controllo il traffico di rete del tool almeno una volta, con un firewall applicativo o anche solo `lsof -i` mentre gira. Se un CLI che promette "solo locale" apre connessioni verso storage bucket esterni, voglio saperlo prima che lo scopra un ricercatore su Hacker News.

Seconda cosa, tratto ogni repository come se prima o poi qualcosa dovesse uscire da lì. `.gitignore` curato, secret scanning attivo (anche solo `gitleaks` gira in due minuti), variabili sensibili in un secret manager e non in file di progetto, rotazione delle chiavi non appena sospetti una fuga anche minima.

Terza cosa, e questa è la più semplice: se un tool AI promette "elaborazione locale" come argomento di vendita principale, quella è proprio la prima affermazione che vale la pena verificare, non quella da dare per scontata. Le promesse di privacy nei prodotti AI in questa fase del mercato vanno trattate come feature da testare, non come garanzie da fonte autorevole.
