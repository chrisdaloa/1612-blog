---
title: "Stencil per saldatura SMD stampati in 3D: Stenchill trasforma i tuoi Gerber in PLA o PETG"
date: 2026-07-24
draft: false
tags: ["stampa-3d", "elettronica", "diy", "fdm"]
categories: ["Stampa 3D"]
description: "Stenchill è un tool online che converte i file Gerber di un PCB in un file stampabile in 3D per creare stencil per pasta saldante in PLA o PETG, alternativa economica e veloce agli stencil metallici per prototipazione SMD."
cover:
  image: "/images/posts/stencil-saldatura-smd-stampati-3d-stenchill.png"
---

Ogni volta che ho dovuto ordinare uno stencil metallico per un PCB SMD ho fatto lo stesso conto in testa: dieci-quindici euro di stencil, più spedizione, più giorni di attesa, per applicare pasta saldante su una board che magari cambierà ancora prima che lo stencil arrivi. Per prototipi veloci è un attrito che scoraggia, e la stragrande maggioranza delle volte finisco a spalmare pasta con una siringa a mano, componente per componente, bestemmiando sui QFN.

Su Hackaday ho letto di un progetto che attacca esattamente questo problema: **Stenchill**, un tool che prende i file Gerber del tuo PCB e genera un file stampabile in 3D per produrre lo stencil direttamente con una stampante FDM, in PLA o PETG invece che in acciaio inox o nichel.

## Come funziona, in pratica

Il flusso è quello che ti aspetti da qualunque tool "da Gerber a qualcos'altro": esporti i Gerber dal tuo software di progettazione PCB (KiCad, Eagle, quello che usi), li carichi sul sito di Stenchill, e il tool genera il modello 3D dello stencil, con le aperture ritagliate esattamente sui pad SMD del tuo design. Se lavori già in KiCad c'è anche un plugin dedicato, che ti evita il giro sul sito e ti tiene tutto dentro il tool che stai già usando per disegnare la board.

Da lì in poi la palla passa allo slicer. E qui, da chi ha fatto girare stampanti FDM per anni, il punto delicato non è la stampante ma la configurazione: uno stencil funzionante ha bisogno di spessori sottili e costanti, tipicamente sui 0,1-0,15 mm, cioè l'ordine di grandezza di un primo strato ben calibrato. Serve un piano di stampa livellato con cura maniacale, un first layer squish giusto, e idealmente un ugello con foro piccolo per non perdere dettaglio sulle aperture più fitte. Non è una stampa "premi start e vai", è una di quelle in cui la qualità del setup della macchina si vede tutta nel risultato.

## PLA o PETG, e perché non aspettarti miracoli sui passi fini

L'articolo originale segnala PLA e PETG come materiali validi. Nella mia esperienza con altri accessori funzionali stampati in FDM, andrei più deciso sul PETG: è più tenace e flette meno sotto la pressione della racla quando spalmi la pasta, e uno stencil che si flette o si crepa a metà lavoro è più fastidioso di uno che costa qualche euro in più. Il PLA stampa più facile e con più definizione, ma è più fragile su geometrie sottili e ripetute come quelle di uno stencil.

Il limite vero, però, non è il materiale: è la fisica della stampa FDM confrontata con l'incisione chimica o il taglio laser con cui si fanno gli stencil metallici professionali. Un ugello standard da 0,4 mm ha una risoluzione che semplicemente non regge il passo di componenti come QFN o BGA a 0,4-0,5 mm di pitch, dove la precisione dello stencil metallico resta l'unica opzione sensata. Per resistenze e condensatori 0402/0603, SOIC, e in generale componenti a passo largo, invece, uno stencil stampato in 3D può essere del tutto sufficiente, ed è lì che questo approccio ha senso.

## Dove lo userei davvero

Non sostituirei mai uno stencil metallico su una produzione, anche piccola, dove ogni board deve uscire identica alla precedente e non hai tempo di rifare tentativi. Ma per prototipazione, per una singola board di test, per quel progetto Arduino/ESP32 su cui stai ancora iterando il layout ogni settimana, spendere zero euro extra e zero giorni di attesa stampando lo stencil in casa cambia completamente il calcolo costi-benefici. Se la board cambia ancora, ristampi lo stencil in dieci minuti invece di buttare quello metallico appena arrivato.

C'è anche un aspetto che apprezzo a livello più ampio: Stenchill abbassa ulteriormente la soglia d'ingresso per fare elettronica SMD in homelab. Fino a qualche anno fa il salto da THT a SMD comportava anche l'investimento, piccolo ma reale, in stencil, forno di rework, pasta saldante di qualità. Ogni pezzo di quella catena che diventa "lo stampo io con quello che ho già sul tavolo" è un pezzo in meno di attrito tra un'idea e il primo prototipo funzionante. Nell'articolo originale si accenna anche al fatto che chi possiede un taglierino laser ha un'opzione ulteriore per produrre stencil in mylar o kapton, ancora più sottile e preciso di uno FDM, ma richiede appunto una macchina che in homelab è molto meno diffusa di una stampante 3D.

## Cosa mi porto a casa

Se hai già una stampante FDM decente e ti capita di saldare SMD con una certa frequenza, vale la pena tenere Stenchill tra i preferiti: è gratis, veloce, e per la maggior parte dei prototipi con componenti non troppo fini fa esattamente il lavoro per cui altrimenti aspetteresti giorni e spenderesti soldi. Per i progetti seri con passo fine, lo stencil metallico resta il riferimento, ma non è più l'unica strada per iniziare.

Fonte: [Hackaday](https://hackaday.com/2026/07/23/saving-some-coin-with-3d-printed-stencils/)
