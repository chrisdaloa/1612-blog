---
title: "Periferiche per emulazione in autunno: cosa comprare oltre al controller"
date: 2026-10-25
draft: false
tags: ["retro-gaming", "guida-acquisto", "emulazione"]
categories: ["Retrogaming"]
description: "Adattatori wireless, encoder arcade, microSD e raffreddamento: le periferiche per emulazione che comprerei davvero, dopo aver già scelto il controller."
cover:
  image: "/images/posts/periferiche-emulazione-autunno-oltre-controller.png"
  alt: "Periferiche per emulazione retrogaming: adattatori, microSD e raffreddamento per Raspberry Pi"
---

Quando a luglio ho scritto la [guida ai controller per l'emulazione](/posts/controller-emulazione-retrogaming-quale-comprare/), mi sono arrivati più messaggi su tutto il resto che sui pad in sé. "Ho preso l'8BitDo, ma ogni tanto si disconnette." "La microSD che avevo in casa va a scatti." "Il Raspberry Pi si scalda e il frame rate crolla." Il controller è solo la parte visibile del setup. Le periferiche attorno decidono se la serata col retrogaming è fluida o una sessione di debug.

Questa è la guida di aggiornamento autunnale: niente ripetizioni di quella di luglio, solo gli accessori che nel mio cabinet Batocera e nei miei handheld hanno fatto una differenza reale. Gli oggetti sono pochi, perché una lista da venti voci non serve a nessuno.

## Adattatore wireless: il dongle batte il Bluetooth

Parto da qui perché è il problema che mi segnalano di più. Il Bluetooth su Linux embedded, cioè Batocera e RetroPie su Raspberry Pi, funziona finché funziona. Poi dopo un riavvio il pad non si riaggancia, o si disconnette a metà partita di Metal Slug, che è esattamente il momento in cui non vuoi che succeda.

La soluzione che uso io è un ricevitore dedicato. Lo **8BitDo Wireless USB Adapter 2** si infila in una porta USB e fa da ponte per i pad 8BitDo, ma anche per i controller Switch, PS4, PS5 e Xbox compatibili. Per il sistema operativo è un controller cablato: niente pairing, niente scherzi dopo il reboot. Costa pochi euro e, sinceramente, è l'acquisto con il miglior rapporto tra spesa e problemi risolti di tutta questa lista.

Un limite: se il pad usa già un dongle suo (come l'Ultimate 2.4G), questo adattatore non serve. Controlla prima cosa hai in casa.

## Encoder USB per l'arcade: il cuore di un cabinato DIY

Se la tua strada è la leva arcade vera e il cabinato fatto in casa, il pezzo chiave è l'encoder, cioè la scheda che traduce leve e pulsanti in un dispositivo USB. Il nome che gira da anni è lo Zero Delay: una piccola scheda con morsetti a vite o connettori faston a cui colleghi microswitch, e che il sistema vede come un gamepad generico.

Non è un componente elegante. Spesso arriva senza istruzioni utili e le versioni in vendita sono tante. Però funziona, ha una latenza trascurabile e MAME la riconosce senza storie. Il mio consiglio pratico: prendi un kit completo con leva, pulsanti e encoder già cablati se è il tuo primo cabinato, e imparerai a crimpare i cavi al secondo progetto. Se invece vuoi partire da qualcosa di finito, ti rimando al discorso dell'Arcade Stick 8BitDo nella guida di luglio.

Per chi vuole spingersi oltre, i pulsanti Sanwa e le leve Seimitsu restano il riferimento: costano di più dei cloni, e si sente al tatto e nella durata. Se spendessi soldi in una sola parte di un cabinato, sarebbero i pulsanti.

## La microSD: il collo di bottiglia che nessuno guarda

Questo è il punto dove vedo più errori. Si compra il Raspberry Pi 5, il pad da 60 euro, la cassa, e poi si infila la microSD più economica trovata sul fondo di un cassetto. Il risultato è un menu di Batocera che impiega secondi a scorrere le copertine dei giochi, e salvataggi che ogni tanto si corrompono.

Per Batocera su Pi ti serve una scheda di classe A2 o almeno A1, di marca nota. Io mi fido delle **SanDisk Extreme microSDXC**: non le più economiche, ma nel cabinet acceso a lungo non mi hanno mai tradito. Come taglia, 128 GB bastano per un archivio ben curato di console fino alla PS1 e un po' di arcade. Se vuoi mettere tutto, compreso il Saturn e la PSP, passa a un SSD USB, che è l'altra mossa che consiglio ai Pi 5 con tanta libreria.

Una nota di onestà: le schede false esistono, soprattutto su marketplace dove vende chiunque. Compra da venditori affidabili e, appena arrivata, controllala con un tool come F3 o H2testw. Se la capacità dichiarata non è quella reale, rimandala indietro.

## Raffreddamento: il Pi 5 non perdona

Il Raspberry Pi 5 scalda molto più del 4. Con la CPU sotto carico, tipico dell'emulazione di PSP o Dreamcast, il thermal throttling arriva presto e i frame calano proprio quando la scena si fa complessa. Con il case di plastica chiuso che regalavano nei kit, la situazione peggiora.

L'Active Cooler ufficiale è la soluzione più semplice: si aggancia sopra il SoC, con ventola e dissipatore, e costa pochissimo rispetto a tutto il resto. Se invece vuoi un setup silenzioso per il salotto, un case con dissipazione passiva funziona bene per i sistemi leggeri, ma sui sistemi pesanti non pretenderei miracoli. In generale, io prendo la ventola e vivo tranquillo: un fruscio basso vale più di un frame rate instabile.

## Cavi e alimentazione: la noia che salva il setup

Due righe su una cosa poco affascinante. Il Pi 5 vuole un alimentatore da 27 W USB-C PD per dare il meglio, soprattutto se alimenti dischi o pad via USB. Con un caricatore da telefono qualsiasi, il sistema ti avvisa di un'alimentazione insufficiente e limita la corrente sulle porte USB. Risultato: il pad wireless si comporta in modo strano e non capisci perché.

Stesso discorso per l'HDMI: un cavo decente evita lo sfarfallio e i problemi di handshake con alcune TV. Non serve il cavo dorato da 40 euro, serve un cavo certificato che non si rompa al primo piegamento.

## Se emuli su handheld: tre piccole cose

Per gli handheld Android e Linux, come i vari Retroid, Anbernic e il famoso R36S di cui ho parlato nella [recensione dopo due mesi](/posts/recensione-r36s-dopo-due-mesi-pregi-difetti/), le periferiche utili sono altre.

Una microSD veloce di scorta, già carica con la libreria: quando una scheda muore, riparti in dieci minuti. Una custodia rigida, perché se lo porti nello zaino lo schermo ringrazia. Un cavo USB-C corto con dati veri, perché metà di quelli in giro sono solo di ricarica.

Non è roba eccitante, ma sono le cose che mi hanno salvato in treno e in vacanza.

## Cosa comprerei, in ordine di priorità

Se hai già un controller decente e vuoi migliorare il setup, partirei così. Prima la microSD di qualità (o un SSD per il Pi 5): è l'upgrade che si nota di più, a ogni avvio. Poi il raffreddamento attivo per il Pi 5, poco costoso e risolve un sacco di grattacapi. Terzo, l'adattatore wireless dedicato, se usi pad via Bluetooth e hai disconnessioni. Per ultimo encoder e kit arcade, solo se hai davvero in mente un cabinato.

Il resto lo comprerei quando ne senti la necessità, non prima. Con l'emulazione è facile cadere nella trappola dell'accessorio: ho in un cassetto tre schede e due adattatori che non uso, e non voglio che succeda anche a te.

Se hai un setup particolare e non sai da dove partire, scrivimi: di solito il problema si risolve cambiando una sola cosa, e raramente è quella che pensi.
