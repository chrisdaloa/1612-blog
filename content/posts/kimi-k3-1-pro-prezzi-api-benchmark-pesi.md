---
title: "Kimi K3.1 Pro: prezzi API, benchmark e pesi del 4 novembre"
date: 2026-10-25
draft: false
tags: ["ai", "llm", "open-source", "homelab"]
categories: ["Intelligenza Artificiale"]
description: "Kimi K3.1 Pro costa 2 dollari per milione di token in input e 10 in output, vale 55 su Artificial Analysis. Cosa cambia per l'homelab prima dei pesi."
cover:
  image: "/images/posts/kimi-k3-1-pro-pesi-aperti-4-novembre.png"
  alt: "Illustrazione del modello Kimi K3.1 Pro di Moonshot con pesi aperti in arrivo"
---

Due dollari per milione di token in input, dieci in output. È il prezzo di Kimi K3.1 Pro, e per me è il dato più interessante di tutto l'annuncio, più dei benchmark. Quando un modello che sta a un soffio dai migliori costa così poco, il conto che faccio per le mie automazioni cambia.

Moonshot AI ha rilasciato K3.1 Pro via API, con tre livelli di reasoning selezionabili. Ne ha scritto Simon Willison sul suo blog, ed è da lì che arrivano i numeri che cito. Secondo Artificial Analysis il modello vale 55 punti, dietro solo a Claude Opus 5.5, che ne ha 58. Tre punti di distanza da quello che oggi è in cima alla classifica.

## Quanto costa davvero

Sulla carta 2 dollari in input e 10 in output sono pochi, ma il prezzo per milione di token da solo dice poco. Quello che pesa nel conto è il rapporto tra input e output, e con i modelli che ragionano c'è un terzo fattore: i token di reasoning. Di norma vengono fatturati come output, quindi un livello alto può far salire la spesa anche se la risposta finale è di tre righe.

Un esempio semplice, con i numeri dell'annuncio. Un task che consuma 20.000 token in input e 5.000 in output costa 0,04 dollari di input più 0,05 di output, quindi circa 9 centesimi. Se il ragionamento aggiunge 15.000 token, l'output passa a 20.000 e la richiesta arriva a circa 24 centesimi. Il prezzo non è cambiato, il conto sì. Non ho confrontato riga per riga i listini dei concorrenti e non voglio citare cifre a memoria: se vuoi la comparazione onesta, apri le pagine prezzi dei provider il giorno in cui decidi, perché cambiano di continuo.

## Tre livelli di reasoning

I livelli di reasoning sono la parte pratica. Non serve usare sempre il massimo: per un riassunto o una classificazione il livello basso basta e costa meno in token di ragionamento, per un task agentico lungo o un refactor serio ha senso salire. Chi usa già un CLI come [`llm`](/posts/llm-0-32-il-cli-di-simon-willison-ora-parla-anche-il-linguaggio-del-reasoning/) per passare da un modello all'altro lo sa: la scelta del livello giusto per ogni lavoro incide sul conto più della scelta del modello stesso.

Il mio approccio è partire dal livello più basso e salire solo se il risultato è sbagliato in modo ripetibile. Al contrario, partire dal massimo e scendere non lo fa quasi nessuno, perché quando funziona nessuno ha voglia di toccare niente.

## Cosa dice quel 55

Artificial Analysis aggrega diversi benchmark in un unico indice. È utile per farsi un'idea dell'ordine di grandezza: 55 contro 58 significa che K3.1 Pro gioca nella stessa fascia di Claude Opus 5.5 e non in quella dei modelli medi. Resta il solito caveat sulle classifiche. Un punteggio aggregato dice poco su come si comporta il modello sul tuo codice, con i tuoi prompt, nella tua lingua. Per l'italiano, in particolare, gli indici in inglese raccontano poco.

Prima di spostare qualcosa in produzione lo provo su tre o quattro task miei, non mi fido di un 55 contro un 58. Tre punti in un indice composito possono sparire o ingigantirsi a seconda del tipo di lavoro. Se il modello costa meno e va quasi uguale, per molti usi quasi uguale basta.

## I pesi: la parte che mi riguarda

Moonshot promette i pesi completi entro il 4 novembre 2026. Va chiarito cosa significa "aperti". Con [Kimi K3](/posts/kimi-k3-modello-open-weight-2-8-trilioni-parametri/) avevo scritto che un modello da 2.8 trilioni di parametri è open nella licenza ma non eseguibile in un homelab. Per K3.1 Pro non ho dati sulle dimensioni che permettano di dire il contrario: se è della stessa famiglia, aspettati lo stesso discorso.

Facciamo il conto, che è aritmetica e non opinione. Un parametro a 16 bit occupa 2 byte, a 8 bit uno, a 4 bit mezzo. Se K3.1 Pro avesse le dimensioni di K3, cioè 2.8 trilioni di parametri, a 4 bit servirebbero circa 1,4 TB solo per i pesi, senza contare cache e overhead. Un server con 1,5 TB di RAM non è un homelab, è un rack da datacenter. Se invece fosse molto più piccolo, il discorso cambierebbe del tutto: ma è un "se" che non posso chiudere finché non vedo i file.

Con i pesi aperti cambiano comunque altre cose:

- puoi usare provider terzi che lo ospitano, quindi prezzi in concorrenza e niente dipendenza da un solo fornitore
- si possono fare quantizzazioni e fine-tuning della comunità
- si possono verificare i risultati senza fidarsi solo di chi vende l'API

## Che hardware serve, in pratica

Per tenere i piedi per terra, ecco gli ordini di grandezza per un modello denso o con esperti attivi, a 4 bit di quantizzazione: ogni miliardo di parametri vale circa mezzo gigabyte. Una GPU da 24 GB regge quindi, grosso modo, un modello da 30-40 miliardi, lasciando spazio al contesto. Con 128 GB di memoria unificata, su un mini PC o un Mac, si arriva nell'area dei 200 miliardi. Oltre, si parla di più GPU o di offload su RAM di sistema, con velocità che crollano.

Qui c'è un dettaglio che vale per i modelli MoE (mixture of experts), la famiglia a cui di solito appartengono questi giganti: nella generazione si attiva solo una frazione dei parametri, ma tutti i pesi devono comunque stare da qualche parte. Il risparmio è sul calcolo, non sulla memoria. Su un server con tanta RAM e una GPU sola l'offload dei pesi non attivi si può fare, ma la velocità resta quella di un esperimento da weekend, non di un servizio.

Per chi ha una GPU consumer o un mini PC in cantina, la domanda vera è se ne uscirà anche una versione ridotta che entri in 24 o 48 GB. Moonshot non l'ha annunciata, quindi non la do per scontata. Nel frattempo ci sono alternative più piccole a pesi aperti che girano già bene in locale, ed è lì che conviene tenere il proprio server finché i file di K3.1 Pro non si vedono su Hugging Face.

## Cosa aspettarsi dal 4 novembre

Se la data viene rispettata, in ordine vedremo: i file su Hugging Face, la licenza (che conta quanto i pesi), la dimensione reale del modello, e nel giro di pochi giorni le prime quantizzazioni della comunità con i primi test di velocità su hardware vero. Quelli sono i numeri che aspetto, non i benchmark. Le date promesse dai laboratori scivolano spesso, e un annuncio non è un rilascio: finché non scarico qualcosa, per me il modello esiste solo come API.

## Cosa farei io

Nell'immediato, provare l'API con un budget piccolo. Con questi prezzi qualche decina di test su task reali costa poco e ti dà un'idea più onesta di qualsiasi leaderboard. Poi aspettare il 4 novembre e vedere se i pesi escono davvero, in che formato e con quale licenza.

La mia opinione: il fatto che un modello cinese a pesi aperti si giochi il podio con i sistemi proprietari è una buona notizia per chi smanetta, anche se il modello in sé non girerà mai sul mio server. Tiene i prezzi bassi e costringe gli altri a muoversi. Ma per l'homelab concreto, quello che gira stasera in cantina, non cambia ancora nulla.

Fonte: [Simon Willison's Weblog](https://simonwillison.net/2026/Oct/23/kimi-k31-pro/)
