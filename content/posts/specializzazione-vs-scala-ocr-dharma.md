---
title: "Un modello da 3 miliardi di parametri che batte GPT e Claude sull'OCR"
date: 2026-05-25
draft: false

tags: ["ai", "intelligenza-artificiale", "ocr", "llm", "machine-learning"]
categories: ["Intelligenza Artificiale"]

description: "Dharma-AI ha testato un modello specializzato da 3B parametri contro Claude Opus, Gemini e GPT su un task OCR. Il modello piccolo ha vinto, a 52 volte il costo in meno."

cover:
    image: "/images/specializzazione-vs-scala-ocr-dharma.png"
    alt: "Modello AI specializzato OCR supera modelli frontier"
    caption: "Specializzazione vs scala: un esperimento di Dharma-AI su HuggingFace"
    relative: false
---

Il ragionamento implicito di chi sceglie un modello AI per un'azienda è quasi sempre lo stesso: prendo il modello più capace disponibile, così sono coperto. GPT-5, Claude Opus, Gemini Pro. Grandi, costosi, presumibilmente i migliori.

Un articolo pubblicato questa settimana da Dharma-AI su Hugging Face mette in discussione questa logica, almeno per i task specifici. Il risultato è abbastanza netto da valere una lettura.

## L'esperimento

Il team ha costruito un sistema OCR per documenti in portoghese brasiliano — un dominio preciso, non un test generico — e ha confrontato un modello specializzato da 3 miliardi di parametri contro i principali modelli commerciali e open-source disponibili.

Il benchmark usato è DharmaOCR, costruito internamente su documenti stampati, testi manoscritti e record legali e amministrativi. Le metriche principali sono edit-distance similarity, n-gram overlap e un tasso di "text degeneration" — cioè quanto spesso il modello produce output corrotto o incoerente.

## I numeri

| Modello | Score | Degeneration |
|---|---|---|
| **Dharma-OCR-3B specializzato** | **0.921** | **0.20%** |
| Claude Opus 4.6 | 0.833 | — |
| Gemini 3.1 Pro | 0.820 | — |
| GPT-5.4 | 0.750 | — |
| Google Vision | 0.686 | — |
| Google Document AI | 0.640 | — |
| GPT-4o | 0.635 | — |
| Amazon Textract | 0.618 | — |
| Mistral OCR 3 | 0.574 | — |

*Il degeneration rate non è stato misurato sui modelli commerciali — la metrica è stata raccolta solo sui modelli open-source eseguiti direttamente dal team.*

Otto punti percentuali sopra Claude Opus, che è il modello più capace di Anthropic. Il tasso di degenerazione è praticamente zero. E il costo per milione di pagine elaborate è circa 52 volte inferiore rispetto alle API commerciali.

## Come ci sono arrivati

La specializzazione non è stata fatta in un passaggio solo. Il processo segue tre livelli: si parte da un modello general-purpose (nel caso specifico Qwen2.5-VL-3B), si fa fine-tuning su un modello già specializzato in OCR in senso lato (olmOCR-2), e poi si fa un secondo fine-tuning sul dominio target. Ogni livello aggiunge qualcosa che il livello precedente non aveva.

La tesi che difendono è quella dell'"allineamento distribuzionale": quello che conta non è il numero di parametri, ma quanto la storia di training del modello sia vicina al task di deployment. Un modello gigante addestrato su tutto non è necessariamente il migliore su qualcosa di specifico.

## Cosa va tenuto a mente

I limiti sono dichiarati esplicitamente nell'articolo, e questo è uno dei motivi per cui vale la pena leggerlo: i risultati riguardano un solo dominio, testato su due scale di parametri (3B e 7B). Non è una dimostrazione che i modelli frontier siano sopravvalutati in generale — sono strumenti diversi per usi diversi.

Per task generativi, conversazionali o che richiedono ragionamento su domini multipli, un modello grande ha ancora senso. Il punto è che per task ben definiti e ripetitivi — OCR, classificazione, estrazione strutturata — la specializzazione compensa la differenza di scala, spesso ampiamente.

## La cosa concreta

Il modello Dharma-OCR-LITE è disponibile su Hugging Face. Chi lavora su automazione documentale o ha pipeline OCR che oggi usano API costose ha qualcosa di concreto da valutare.

Più in generale, l'idea che costruire un ecosistema di modelli piccoli e specializzati possa essere più efficiente di affidarsi a un unico modello universale è qualcosa che il mercato sta cominciando a dimostrare con i numeri, non solo con la teoria.
