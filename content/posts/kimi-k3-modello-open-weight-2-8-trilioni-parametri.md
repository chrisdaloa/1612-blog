---
title: "Kimi K3: il modello open-weight da 2.8 trilioni di parametri che nessuno di noi farà mai girare in locale"
date: 2026-07-18
draft: false
tags: ["ai", "llm", "open-source", "homelab"]
categories: ["Intelligenza Artificiale"]
description: "Moonshot AI ha rilasciato Kimi K3, il modello open-weight più grande mai pubblicato: 2.8 trilioni di parametri, 1 milione di token di contesto, pesi completi promessi per fine luglio. Cosa significa davvero per chi ha un homelab, e cosa no."
cover:
  image: "/images/posts/kimi-k3-modello-open-weight-2-8-trilioni-parametri.png"
---

Ogni volta che esce un modello open-weight la prima domanda che mi faccio non è "quanto è bravo", ma "quanta RAM mi serve per farlo girare qui in cantina". Con Kimi K3 la risposta è talmente assurda che vale la pena parlarne, anche solo per sfatare l'illusione che "open" voglia dire "eseguibile in locale".

Il laboratorio cinese Moonshot AI ha rilasciato Kimi K3 nei giorni scorsi: 2.8 trilioni di parametri, finestra di contesto da 1 milione di token, già disponibile via API e app. I pesi completi sono promessi in rilascio aperto per il 27 luglio. Ne ha scritto Simon Willison sul suo blog, che come al solito è la fonte più lucida per capire cosa conta davvero in questi annunci senza il rumore di fondo del marketing. È, per numero di parametri dichiarati, il modello open-weight più grande mai pubblicato, e secondo i benchmark citati se la gioca alla pari con i migliori sistemi proprietari occidentali.

## 2.8 trilioni non significano quello che pensi

La cifra fa notizia, ma va letta con un minimo di contesto tecnico. Un modello di quella taglia è quasi certamente una Mixture-of-Experts, come DeepSeek V3/R1 prima di lui: i parametri totali sono enormi, ma per ogni token generato ne vengono attivati solo una frazione, tipicamente qualche decina di miliardi. È quello che rende il modello addestrabile ed eseguibile su cluster enormi ma dedicati, non un mostro che devi caricare tutto insieme in memoria per ogni singola inferenza.

Detto questo, anche "solo" gli expert attivi più il resto dell'architettura da tenere in memoria per servire il modello richiedono hardware che nessun homelab serio possiede, a meno di non avere una sala server con più GPU datacenter in casa. Anche in versione quantizzata aggressiva, parliamo di centinaia di GB di VRAM/RAM unificata solo per caricare i pesi. Chi mi segue sa che ho un debole per spremere modelli grandi su hardware di consumo, ma qui il divario è di un ordine di grandezza superiore a quello che si vedeva già con DeepSeek R1 671B, che già faceva soffrire chi provava a girarlo su un singolo nodo con GPU consumer.

## Il vero punto: cosa cambia per chi usa questi modelli, non per chi li ospita

Dove Kimi K3 diventa interessante per uso pratico non è "posso farlo girare a casa", ma "posso usarlo via API senza dipendere da un solo fornitore occidentale, e con licenza aperta posso anche farlo ospitare da terzi a un prezzo competitivo". La finestra di contesto da 1 milione di token è la parte che mi interessa di più: significa poter buttare dentro un repository intero, o una base di codice complessa, senza dover fare retrieval o chunking artificiale. Per chi fa vibe coding seriamente, come ho raccontato in altri articoli, il contesto lungo pesa quanto la qualità del ragionamento, a volte di più.

E qui arriva il punto che secondo me viene sempre sottovalutato in questi annunci: "open-weight" per un modello di questa scala non è una garanzia di indipendenza, è una garanzia di *possibilità* di indipendenza. I pesi apribili permettono a provider terzi di ospitarlo, di fare fine-tuning specializzati, di evitare il lock-in su un'unica azienda. Ma il "posso farlo girare io" resta riservato a chi ha budget da data center, non al maker con un homelab in garage. È la stessa distinzione che ho fatto altre volte parlando di modelli grandi: l'apertura del peso è un bene collettivo per l'ecosistema, non un regalo diretto a chi smanetta in casa.

## Il paragone con il "momento DeepSeek"

La narrativa che si sta costruendo attorno a Kimi K3 è la stessa che accompagnò DeepSeek a inizio 2025: un laboratorio cinese rilascia un modello open-weight che rivaleggia con i migliori modelli chiusi americani, a una frazione del costo dichiarato di training. Vale la pena essere cauti su questo parallelo. DeepSeek fece scalpore soprattutto per l'efficienza di addestramento dichiarata rispetto alla scala, non solo per le performance assolute. Con Kimi K3 il dato che manca ancora, al momento del rilascio API, è una valutazione indipendente solida sui benchmark che contano per l'uso reale — coding agentico, ragionamento multi-step, affidabilità su task lunghi — più che sui numeri da leaderboard che ogni lab ottimizza a tavolino prima del lancio. Aspetto i pesi completi del 27 luglio e i primi test indipendenti prima di sbilanciarmi oltre.

Nel frattempo, la lezione pratica per chi ha un homelab resta la stessa di sempre: i modelli enormi, aperti o meno, sono per chi ha il budget cloud per farli girare o l'azienda che glieli offre in API. Il valore per noi che smanettiamo in locale sta più in basso nella scala — nei modelli da 7B, 14B, 32B che davvero entrano in una GPU consumer o in un Mac con RAM unificata generosa. Kimi K3 è una notizia importante per l'ecosistema, ma non cambia di una virgola quello che gira sul mio server in cantina stasera.

Fonte: [Simon Willison's Weblog](https://simonwillison.net/2026/Jul/16/kimi-k3/)
