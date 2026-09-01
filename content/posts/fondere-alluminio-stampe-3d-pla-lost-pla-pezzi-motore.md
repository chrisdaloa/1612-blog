---
title: "Fondere alluminio partendo da stampe 3D in PLA: la tecnica lost-PLA per pezzi motore"
date: 2026-09-01
draft: false
tags: ["stampa-3d", "diy", "fdm", "materiali"]
categories: ["Stampa 3D"]
description: "Camden Bowen fonde alluminio da cerchioni di scarto per colare cilindri motore con la tecnica lost-PLA: stampo 3D, gesso e sabbia, forno."
cover:
  image: "/images/posts/fondere-alluminio-stampe-3d-pla-lost-pla-pezzi-motore.png"
  alt: "Stampo in PLA stampato in 3D per fondere un cilindro motore"
---

Ho fresato pezzi da un blocco pieno di alluminio esattamente una volta, per un supporto motore su un progetto RC, e ricordo ancora il mucchio di trucioli che è finito nel secchio della raccolta metalli. Quel materiale l'ho pagato, l'ho lavorato per ore, e la maggior parte è tornata in forma di polvere e ricciolini inutilizzabili. Camden Bowen, un maker che costruisce motori a combustione interna da zero, si è fatto la stessa domanda dopo l'ennesimo blocco sprecato in fresatura: perché non fondere direttamente la forma che mi serve, invece di partire da un pieno e togliere tutto quello che avanza?

La risposta, raccontata da [Hackaday](https://hackaday.com/2026/08/28/casting-engine-parts-from-3d-prints/), è la tecnica lost-PLA: si stampa in 3D la forma del pezzo finale in PLA normale, si annega lo stampo in una miscela di gesso e sabbia, si scalda tutto finché il PLA non sparisce, e nella cavità che resta si cola alluminio fuso. È la stessa logica della fusione a cera persa che si usa da secoli in oreficeria e fonderia artistica, solo che al posto della cera c'è un filamento da tre euro al rocchetto e uno slicer al posto dello scultore.

## Il forno prima dello stampo

Prima ancora di arrivare alla parte di stampa 3D, Bowen si è costruito da solo l'attrezzatura per fondere: un forno fatto con cemento refrattario e perlite, alimentato da un bruciatore a propano. Niente forno da fonderia comprato, tutto assemblato in casa con materiali che si trovano in ferramenta. Per il metallo da fondere ha usato un lotto di cerchioni in lega di alluminio: le leghe usate per i cerchi auto sono adatte alla fusione (a differenza di molte leghe da lavorazione meccanica, che contengono elementi che rendono il getto fragile o poroso), quindi li ha tagliati e rifusi in lingotti come primo passaggio. Rifondere prima in lingotti non è solo comodità logistica: aiuta anche a purificare il metallo, separando le impurità che affiorano in superficie durante la prima fusione.

È il tipo di lavoro preliminare che in genere viene saltato quando si legge solo il titolo "ha fuso alluminio con una stampante 3D": il grosso della fatica, prima ancora di toccare lo slicer, è stato costruirsi un forno funzionante e procurarsi materiale della lega giusta.

## Lo stampo: gesso, sabbia e uno stampo che deve sparire

Con il metallo pronto, la parte che riguarda più da vicino chi stampa in 3D. Il pezzo (nel caso specifico un cilindro motore) viene disegnato in CAD e stampato in PLA normale, lo stesso filamento economico [che ho già messo a confronto con PETG e ABS](/posts/pla-petg-abs-quale-filamento-scegliere-stampa-3d/) e che probabilmente avete già sulla bobina in stampante. Lo stampo in PLA viene poi annegato in una miscela di gesso di Parigi e sabbia: il gesso da solo si sbriciolerebbe con lo shock termico della colata, la sabbia aggiunge la resistenza al calore che serve a reggere l'alluminio fuso senza crepare.

A questo punto il blocco di gesso-sabbia con dentro lo stampo in PLA va in forno: prima una fase a temperatura più bassa per far colare via il PLA fuso (da cui il nome "lost PLA", PLA perso), poi il passaggio nel kiln vero e proprio per bruciare i residui organici rimasti nella cavità. È qui che il progetto ha avuto più intoppi: bruciare via completamente il PLA non è banale come sembra, e Bowen ha dovuto ripetere il processo più volte prima di ottenere uno stampo davvero pulito, senza residui carboniosi che avrebbero rovinato la superficie del getto finale.

## Il risultato, con i limiti onesti

Dopo i tentativi falliti, la colata buona ha prodotto un cilindro motore in alluminio funzionale, con solo qualche piccola imperfezione superficiale. Considerando quanto sarebbe stato complicato ricavare la stessa geometria interna partendo da un blocco pieno e una fresa, il paragone regge da solo: pensate a un condotto interno curvo o a una camera di forma irregolare, roba che in fresatura richiede attrezzi speciali o più operazioni di setup, mentre in fusione basta che lo stampo abbia la forma giusta.

Detto questo, non è un processo gratis in termini di tempo e attrezzatura: serve un forno funzionante (quindi un investimento iniziale e uno spazio dove usarlo in sicurezza, propano e alluminio fuso non sono un gioco da salotto), serve fare pratica con le proporzioni gesso-sabbia, e serve mettere in conto scarti prima di azzeccare il ciclo di bruciatura giusto. Non è un tutorial plug-and-play, è artigianato che richiede iterazione.

## Perché mi interessa, anche senza un forno in garage

Non ho intenzione di costruirmi un kiln a propano nel giardino di casa, ma il principio mi resta in testa per un motivo preciso: la stampante 3D FDM che ho sul tavolo, quella che uso per staffe e supporti in PLA o PETG, può diventare uno strumento di prototipazione per pezzi in metallo senza toccare direttamente il metallo fino all'ultimo passaggio. È un salto concettuale diverso dallo stampare direttamente in metallo (che richiede stampanti SLM da decine di migliaia di euro) o dal fresare da pieno: usi quello che hai già, per fare da stampo a un materiale che quello che hai già non potrebbe mai lavorare da solo.

C'è anche un limite pratico che vale la pena dire chiaro: questa tecnica ha senso per pezzi singoli o piccole serie, prototipi, ricambi introvabili per un motore d'epoca, componenti one-off. Per la produzione in serie la fonderia industriale resta comunque più efficiente e prevedibile, ed è per questo che i produttori commerciali continuano a colare pezzi del genere invece di fresarli da pieno: lo stesso ragionamento di risparmio materiale che ha spinto Bowen a smettere di fresare blocchi interi vale, su scala molto più grande, anche per chi produce motori veri.

Se vi interessa vedere il processo passo passo, incluse le fasi di fusione dei cerchioni e i primi tentativi falliti di bruciatura, Bowen ha documentato tutto in [un video su YouTube](https://youtu.be/F59uIEqeOzE), linkato dallo stesso articolo di Hackaday scritto da Maya Posch.
