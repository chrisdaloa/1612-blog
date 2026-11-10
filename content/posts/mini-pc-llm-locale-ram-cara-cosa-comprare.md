---
title: "Mini PC per LLM in locale con la RAM alle stelle: cosa conviene comprare adesso"
date: 2026-11-06
draft: false
tags: ["ai", "llm", "homelab", "mini-pc", "guida-acquisto"]
categories: ["Intelligenza Artificiale"]
description: "La crisi della RAM ha cambiato i conti dell'homelab AI: Ryzen AI Max+ 395, Framework Desktop, Beelink EQ14 e GPU usate a confronto."
cover:
  image: "/images/posts/mini-pc-llm-locale-ram-cara-cosa-comprare.png"
  alt: "Mini PC compatto accanto a moduli di memoria RAM per far girare LLM in locale"
---

A luglio ho scritto [una guida su quale mini PC comprare per far girare LLM in locale](/posts/mini-pc-homelab-ai-quale-comprare/). Da allora il mercato della memoria è andato nella direzione opposta a quella che speravo: DRAM e LPDDR5X costano molto di più, e le macchine che vivono di RAM, cioè esattamente quelle che servono a noi, se ne sono accorte per prime. Questo non è un rifacimento di quella guida. È la domanda che mi fanno adesso: con questi prezzi, ha ancora senso comprare?

Non ti do cifre precise per modello, perché cambiano da una settimana all'altra e un numero scritto qui sarebbe sbagliato prima che tu finisca di leggere. Controlla sempre il prezzo del giorno sullo store. Ti do invece il ragionamento, che invecchia meglio.

## Perché la crisi RAM colpisce proprio l'AI locale

Un mini PC normale con 16GB di RAM costa un po' di più e pazienza. Per un LLM il discorso è diverso: la memoria è quasi tutto il prezzo della macchina. Le piattaforme a memoria unificata come il Ryzen AI Max+ 395 (quella del GMKtec EVO-X2 e del Framework Desktop) hanno la LPDDR5X saldata, quindi non puoi comprare la macchina base e aggiungere i 128GB dopo, a prezzi migliori. O paghi la configurazione piena adesso, o ti accontenti di meno.

È la parte che mi dà più fastidio. Il vantaggio di questi sistemi era la capacità di caricare modelli enormi senza impazzire, e proprio quella capacità è diventata la voce più cara.

## Quanta memoria ti serve davvero

Prima di guardare i listini, fai due conti sul modello che vuoi usare. Un modello quantizzato a 4 bit occupa grosso modo mezzo gigabyte per miliardo di parametri, più la cache del contesto, che con contesti lunghi pesa parecchio.

- 7-14B parametri: 16GB bastano, 32GB stanno comodi.
- 30-35B: servono 32GB abbondanti, meglio 64GB.
- 70B in su: da 64GB in su, e 128GB se vuoi contesti lunghi o più modelli caricati insieme.

Molti comprano la configurazione da 128GB "per sicurezza" e poi usano modelli da 14B. Con i prezzi di oggi quella sicurezza costa parecchio, e secondo me è il primo errore da evitare.

## Le opzioni, con i prezzi di memoria di oggi

**Beelink EQ14.** Con l'Intel N100 e 16GB resta il modo meno doloroso per iniziare. Il costo era già basso e anche con il rincaro resta una spesa piccola. Non è veloce, fa girare un 7-8B quantizzato, e come nodo sempre acceso per task semplici (tagging, classificazione, un chatbot di casa) è ancora perfetto. Se non sai se l'AI locale ti serve davvero, parti da qui e non pensarci più.

**GMKtec EVO-X2.** Il Ryzen AI Max+ 395 con memoria unificata è sempre la risposta più interessante per i modelli grandi. Ma con la RAM cara il divario tra la versione da 64GB e quella da 128GB si è fatto pesante. Se il tuo uso è un 30B in contesti normali, la 64GB è la scelta più ragionevole; i 128GB li prendi solo se sai già di averne bisogno.

**Framework Desktop.** Stessa piattaforma, ma con l'approccio Framework: più modulare, più curato, più documentato. Per me è la scelta da fare se tieni alla riparabilità e agli aggiornamenti futuri, e paghi qualcosa in più per questo. La memoria però resta saldata, quindi l'argomento "lo espando dopo" non vale nemmeno qui.

**GPU usata da 24GB.** Una RTX 3090 sul mercato dell'usato rimane, per i modelli fino a 30B circa, più veloce di qualsiasi mini PC a memoria unificata, grazie alla banda della GDDR6X. Il prezzo è un case, un alimentatore adeguato e consumi da condizionatore. Non è elegante, ma se hai già un PC desktop dove infilarla è spesso la spesa più sensata, e la RAM di sistema non entra nemmeno nel conto.

**NVIDIA Jetson Orin Nano.** Resta un'altra categoria: visione artificiale e robotica on-device, non chatbot. Se ti serve quello, la crisi RAM cambia poco il quadro. Se cerchi un LLM generalista, non è la scheda giusta, né ora né prima.

## Cosa farei io

Se stai ancora esplorando, compra il Beelink e rimanda tutto il resto. Con 16GB impari come funzionano Ollama, la quantizzazione e il RAG sui tuoi documenti, e scopri se ti serve di più prima di spendere cifre importanti.

Se invece sai già di voler girare un 30-70B tutti i giorni, un EVO-X2 o un Framework Desktop restano la soluzione più compatta ed ordinata. Scegli la taglia di memoria in base al modello che userai davvero, non a quello che potresti provare una volta.

Se hai un desktop con un alimentatore decente, valuta una GPU usata da 24GB prima di qualunque mini PC. È meno bella da vedere, ma in questo momento è dove il rapporto tra prezzo e token al secondo regge meglio.

E se i prezzi ti sembrano folli, aspettare è una scelta legittima. Un modello da 8B oggi risponde meglio di un 30B di due anni fa, quindi per molti casi d'uso l'hardware modesto che hai già basta più di quanto pensi.
