---
title: "llm 0.32: il CLI di Simon Willison ora parla anche il linguaggio del reasoning"
date: 2026-08-27
draft: false
tags: ["ai", "llm", "open-source", "homelab"]
categories: ["Intelligenza Artificiale"]
description: "Simon Willison ha aggiornato llm, il CLI per modelli AI locali e remoti: reasoning trace, OpenAI Responses API, nuovo schema di log e patch urgente."
cover:
  image: "/images/posts/llm-032-cli-simon-willison-reasoning.png"
  alt: "Schermata di terminale con il comando CLI llm in esecuzione"
---

Se orchestrate modelli AI da terminale, prima o poi siete finiti su `llm` di Simon Willison. Io lo uso praticamente ogni giorno: è il collante tra i modelli che giro in locale su un [mini PC per homelab AI](/posts/mini-pc-homelab-ai-quale-comprare/) in cantina e le API remote quando serve qualcosa di più muscoloso, tutto dalla stessa riga di comando, con lo stesso log SQLite sotto. Negli ultimi giorni è uscita la versione 0.32, con dietro un aggiornamento davvero corposo, seguita a stretto giro dalla 0.32.1, una patch minuscola ma da installare subito se avete fatto un setup pulito di recente.

## Cosa cambia davvero con la 0.32

La 0.32 non è un aggiornamento cosmetico. Willison ha riscritto il modo in cui prompt, risposte, tool call e log vengono rappresentati internamente, passando a messaggi strutturati con "parti" tipizzate per testo, ragionamento, chiamate a strumenti e allegati. Se usate solo il CLI base la cosa passa quasi inosservata, ma se scrivete plugin o automatizzate `llm` via Python API, cambia parecchio: ora avete accesso a `response.stream_events()` per leggere in tempo reale un flusso misto di testo, reasoning e tool call, invece di dover ricostruire tutto a mano dal testo grezzo.

La parte che trovo più interessante è l'adozione dell'OpenAI Responses API per i modelli capaci di reasoning. In pratica `llm` ora usa di default l'endpoint `/v1/responses` per i modelli OpenAI che ragionano, e questo abilita il reasoning interleaved tra una tool call e l'altra, cosa che con la vecchia Chat Completions API non era possibile in modo pulito. Chi preferisce comunque il vecchio percorso può forzarlo con `-o chat_completions 1`, quindi nessuno resta bloccato.

Insieme a questo arrivano due strumenti server-side molto comodi: `WebSearch` e `CodeInterpreter`, richiamabili direttamente dal CLI con `-T WebSearch` o `-T 'CodeInterpreter(memory_limit="4g")'`. Non serve più costruirsi un tool custom per far cercare qualcosa sul web al modello o fargli eseguire codice: è OpenAI stesso a gestirlo lato server, e `llm` si limita a esporlo con un'interfaccia sensata.

## Reasoning trace: finalmente si vede cosa pensa il modello

Questa è la funzione che uso di più da quando ho aggiornato. Per i modelli che supportano il reasoning, `llm prompt` e `llm chat` ora streammano il riassunto del ragionamento su standard error mentre il modello lavora. Prima era tutto un buco nero: il modello "pensava" per qualche secondo e poi sputava fuori la risposta, senza nessuna visibilità su cosa stesse effettivamente considerando. Ora con `-R` potete nasconderlo se vi dà fastidio, ma di default lo vedete, ed è un cambio di prospettiva non da poco quando dovete capire perché un modello ha preso una strada assurda su un task agentico.

Per chi fa debugging di prompt complessi o pipeline multi-step, avere il reasoning summary a schermo mentre il tool gira è la differenza tra intuire cosa sia andato storto e saperlo con certezza. I metadati di reasoning cifrati vengono comunque preservati per i turni successivi della conversazione, quindi non perdete continuità se usate `llm -c` per proseguire una chat.

## Tool loop più controllabili e log riscritti

L'altro pezzo grosso riguarda i tool loop: ora ogni tool call ha un `tool_call_id` univoco, e un tool può sollevare `llm.PauseChain` per fermare l'esecuzione in attesa di un'approvazione umana o di un evento esterno, con la possibilità di riprendere in seguito senza rieseguire le chiamate già completate. Per chi fa vibe coding con agenti che toccano il filesystem o eseguono comandi, è esattamente il tipo di freno a mano che serve prima di lasciare un agente libero di fare cose potenzialmente distruttive.

Sul fronte log, `llm` passa a un nuovo schema SQLite basato su thread, turni e uno storage dei messaggi content-addressed: i messaggi vengono salvati una sola volta e referenziati per hash, invece di duplicare l'intera cronologia a ogni turno. I log vecchi restano intatti e vengono comunque mostrati insieme ai nuovi da `llm logs`. Prima di aggiornare, se avete uno storico di log a cui tenete, fate un backup con `llm logs backup logs-backup.db`: non è obbligatorio, ma è la classica precauzione che costa dieci secondi e vi risparmia un pomeriggio di recupero dati.

## La 0.32.1: una patch nata da una dipendenza che si è mossa sotto i piedi

Qui arriva la parte pratica per cui vale la pena aggiornare subito. Nei giorni successivi alla 0.32, le installazioni pulite di `llm` hanno smesso di funzionare perché la libreria Python `openai` ha eliminato la propria dipendenza diretta da `httpx`, e `llm` si appoggiava a quella dipendenza transitiva senza dichiararla esplicitamente. Risultato: chi installava `llm` da zero si trovava un tool rotto al primo avvio, senza un motivo evidente nel proprio codice, solo per un pacchetto a monte che aveva cambiato le carte in tavola.

La 0.32.1 è la classica patch tampone: pin a `openai<3` per tenere tutto stabile per il momento. Willison ha già annunciato che la 0.33 farà il salto vero, sostituendo `httpx` con `httpx2`. È un promemoria utile su quanto sia fragile l'ecosistema di dipendenze Python quando un progetto a monte cambia comportamento senza preavviso enorme: se gestite servizi che dipendono da `llm` in produzione o in automazioni cron, meglio pinnare le versioni piuttosto che affidarsi a un `pip install -U` alla cieca in un ambiente che deve restare stabile.

## Perché mi interessa, da homelabber

Non uso `llm` per stupire nessuno: lo uso perché è l'unico strumento che mi permette di trattare allo stesso modo un modello che gira su una GPU in cantina e un modello dietro un'API a pagamento, con la stessa sintassi, lo stesso storico, gli stessi plugin. Ogni volta che Willison aggiunge una funzionalità come il reasoning trace o l'integrazione con endpoint OpenAI-compatibili arbitrari (`llm openai endpoint`, altra chicca di questa release, utile per chi punta `llm` verso provider come OpenRouter, dove trovate anche modelli open-weight enormi come [Kimi K3](/posts/kimi-k3-modello-open-weight-2-8-trilioni-parametri/), o un server locale che espone un'API compatibile), il tool diventa un po' più il centro di controllo unico che dovrebbe essere per chiunque orchestri modelli misti.

Se lo usate già, aggiornate: `pip install -U llm` oppure `uv tool upgrade llm` se lo gestite con uv, come faccio io. Se non lo conoscete e avete un homelab con qualche modello locale e magari una chiave API di riserva per quando serve più potenza, è uno degli strumenti che consiglio di provare per primi: la curva di apprendimento è bassa, la documentazione di Willison è tra le più chiare che si trovino in giro per un progetto open-source, e il fatto che il progetto venga aggiornato con questa cadenza e questa cura è di per sé un buon segnale.

Fonte: [Simon Willison's Weblog](https://simonwillison.net/2026/Aug/21/llm/) e [changelog ufficiale del progetto llm](https://github.com/simonw/llm/releases/tag/0.32).
