---
title: "Mini PC e schede per homelab AI: quale comprare per far girare LLM in locale"
date: 2026-07-30
draft: false
tags: ["ai", "llm", "homelab", "mini-pc", "guida-acquisto"]
categories: ["Intelligenza Artificiale"]
description: "Beelink EQ14, GMKtec EVO-X2 con Ryzen AI Max+ 395 e NVIDIA Jetson Orin Nano a confronto: quale hardware comprare per far girare modelli LLM in locale nel proprio homelab, dalla fascia budget fino ai 128GB di memoria unificata."
cover:
  image: "/images/posts/mini-pc-homelab-ai-quale-comprare.png"
---

{{< affiliate-disclosure >}}

Mi chiedono spesso quale mini PC comprare per far girare un LLM in casa, e la risposta onesta è "dipende da cosa intendi per far girare un LLM", perché tra un modello 7B che risponde in due secondi e uno che ci mette dieci minuti a produrre un paragrafo c'è un abisso di aspettative deluse. Ho messo mano, tra acquisti diretti e prove su hardware di amici, a tre categorie molto diverse di macchine per l'inferenza locale, e vale la pena capire prima di comprare in quale fascia ti trovi davvero, perché il salto di prezzo tra una e l'altra è enorme e non sempre giustificato dal tuo caso d'uso.

Il problema di fondo, per chi fa homelab AI, è la memoria, non la potenza di calcolo pura. Un LLM quantizzato deve stare tutto in RAM (o VRAM) per essere veloce, e la banda di memoria disponibile decide quanti token al secondo ottieni molto più della frequenza della CPU. È la lente giusta con cui guardare ogni scheda tecnica qui sotto.

## Fascia budget: Beelink EQ14, per chi vuole solo provare

Il [Beelink EQ14](https://www.amazon.it/dp/B0F3D7Y6X8?tag=16120s-21) monta un Intel N100, quattro core Alder Lake-N pensati per consumare pochissimo, non certo per macinare matematica. Costa meno di una cena buona per due, è fanless o quasi silenzioso, e con 16GB di RAM riesce a far girare in locale via Ollama o llama.cpp un modello quantizzato da 7B parametri (tipo Llama 3.1 8B o Mistral 7B in GGUF Q4_K_M) senza sbattere in swap.

La resa è quella che è: pochi token al secondo, tutto su CPU perché la GPU integrata è troppo debole per contare davvero nell'inferenza. Per chiedere due domande e avere una risposta ragionevole in dieci-quindici secondi va bene. Per un assistente che deve rispondere in tempo reale mentre lavori, o per fare summarization di documenti lunghi, la pazienza finisce prima della risposta.

Dove lo trovo comunque sensato: come nodo dedicato per un piccolo task ripetitivo (classificazione di email, tagging automatico di note in Obsidian, un chatbot casalingo che non deve essere brillante, solo disponibile), non come workstation per uso quotidiano intensivo. Consuma pochissimo, sta acceso 24/7 senza pesare sulla bolletta, e questo per un homelab conta più della velocità bruta in molti scenari.

## Fascia alta: GMKtec EVO-X2, il vero salto di categoria

Qui cambia completamente la storia. Il [GMKtec EVO-X2](https://www.amazon.it/dp/B0F6X332N6?tag=16120s-21) monta l'AMD Ryzen AI Max+ 395, la piattaforma che AMD chiama internamente Strix Halo, con GPU integrata Radeon 8060S e soprattutto fino a 128GB di memoria unificata LPDDR5X condivisa tra CPU e GPU. È lo stesso principio che rende interessanti i Mac con chip Apple Silicon per l'AI locale: niente VRAM separata da riempire, la memoria di sistema fa entrambi i lavori, e con 128GB puoi caricare modelli quantizzati che su una GPU consumer con 24GB di VRAM semplicemente non entrano.

Con questa macchina un modello 70B quantizzato Q4 gira, e gira a una velocità utilizzabile, non solo "tecnicamente possibile". È la differenza tra Beelink e GMKtec: sul primo alcuni modelli non li carichi proprio, sul secondo scegli tra "carico anche mostri enormi" e "quanto sono disposto a spendere per averlo". Il prezzo di un EVO-X2 configurato con 128GB si aggira sui duemila euro, che è tanto per un mini PC ma pochissimo rispetto a una workstation con più GPU datacenter, ed è comunque l'opzione più equilibrata oggi sul mercato consumer per chi vuole modelli grandi in locale senza costruire un rig con schede video usate.

Il limite reale è la banda, non la capacità di memoria. La LPDDR5X unificata è più lenta di una VRAM GDDR6X dedicata, quindi anche se il modello ci sta, i token al secondo restano inferiori a quello che otterresti con una GPU discreta di fascia alta (tipo una RTX 4090 o una 3090 usata) sugli stessi parametri attivi. Per chi bada solo alla velocità pura su modelli piccoli e medi, una GPU usata da 24GB resta più conveniente. Per chi vuole la capacità di caricare modelli enormi senza fare i salti mortali con offload CPU/GPU o quantizzazioni estreme, l'EVO-X2 vince a mani basse.

## Fascia edge: NVIDIA Jetson Orin Nano, un altro sport

Il [Jetson Orin Nano](https://www.amazon.it/dp/B0BZJTQ5YP?tag=16120s-21) va inquadrato diversamente dagli altri due: non è un PC generalista con un sistema operativo desktop, è una scheda per progetti embedded e robotica dove l'inferenza AI deve girare a bordo, con consumi bassissimi e senza connessione a un server remoto. Con 8GB di memoria condivisa e fino a 67 TOPS nella versione Super, è pensato per computer vision, riconoscimento oggetti in tempo reale su un robot o una telecamera, non per fare da assistente conversazionale con un LLM generalista.

Ci ho messo le mani per un progetto di visione artificiale su un piccolo rover, e lì il Jetson brilla: il supporto CUDA nativo di NVIDIA, TensorRT per ottimizzare i modelli, e un ecosistema di modelli di visione già pronti per questa architettura lo rendono la scelta quasi obbligata se il tuo progetto è embedded e deve fare inferenza on-device, con Arduino o microcontrollori a fare da contorno per sensori e attuatori. Come chatbot locale generico è invece uno spreco: hai poca memoria, e l'obiettivo del chip non è quello.

## Cosa comprerei io, secondo il caso d'uso

Se vuoi solo capire come funziona Ollama, giocare con RAG su documenti tuoi, o avere un piccolo assistente domestico che risponde a comandi semplici, il Beelink EQ14 è il punto di ingresso più sensato: costa poco, consuma pochissimo, e ti fa toccare con mano i limiti reali dell'inferenza locale prima di spendere di più.

Se vuoi un homelab AI serio, con modelli grandi che rispondono con qualità vicina a quella dei servizi cloud, e sei disposto a investire duemila euro in hardware dedicato, il GMKtec EVO-X2 con 128GB è oggi la scelta più equilibrata sul mercato consumer, meglio di rincorrere GPU datacenter usate introvabili o di costruire un rig con più schede video che consuma come un condizionatore acceso tutto il giorno.

Se il tuo progetto non è "voglio un chatbot" ma "voglio un robot o una telecamera che capisce cosa vede senza mandare tutto al cloud", il Jetson Orin Nano è nella categoria giusta. Lì la concorrenza reale sono altre schede embedded, non i mini PC x86, e NVIDIA resta avanti per maturità del software.

Una cosa vale per tutti e tre: prima di comprare, guarda la memoria disponibile e la sua banda, non il numero di core o i TFLOPS pubblicizzati. È quello che decide davvero se il modello che vuoi far girare ci sta, e a che velocità.
