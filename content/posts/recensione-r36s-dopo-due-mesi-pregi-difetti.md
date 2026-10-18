---
title: "Recensione R36S dopo due mesi: pregi e difetti (35 euro)"
date: 2026-10-18
draft: false
tags: ["retro-gaming", "handheld", "emulazione"]
categories: ["Retrogaming"]
description: "Recensione dell'R36S originale pagata 35 euro: schermo, stick, batteria, SD da cambiare subito, firmware dArkOSen e come evitare i cloni."
cover:
  image: "/images/posts/r36s-recensione-copertina.jpg"
  alt: "R36S con guscio nero trasparente tenuta in mano con Bubble Bobble sullo schermo"
---

{{< affiliate-disclosure >}}

Ho una R36S originale e la uso da due mesi soprattutto in due momenti molto precisi: la pausa in bagno e la mezz'ora prima di dormire. Non sono le condizioni ideali per giudicare un handheld, ma sono esattamente quelle in cui la maggior parte di noi gioca davvero. Quindi niente benchmark, solo com'è andata nell'uso reale.

Per chi cerca un confronto con altre console e una guida su come riconoscere i cloni c'è già [l'articolo di settembre](/posts/r36s-handheld-retrogaming-cloni-guida-onesta/). Qui parlo dell'oggetto che ho in mano.

## Quanto l'ho pagata e dove

35 euro spedita, approfittando di uno sconto che ogni tanto AliExpress concede. L'ho presa dal listing che ho linkato anche nella sezione acquisti di PixelPocket, il mio sito con le guide sulla R36S. Lo dico perché con questa console il venditore conta più del modello: [qui trovi il listing](https://s.click.aliexpress.com/e/_c2v1sjZV) (link di affiliazione) e [qui la pagina "Dove acquistare"](https://pixelpocket.1612.it/it/r36s/in-vendita) che tengo aggiornata, perché nel tempo le offerte cambiano.

La ragione è che in giro ci sono molti cloni con lo stesso nome e dentro hardware diverso, spesso peggiore. Nella [guida all'acquisto](https://pixelpocket.1612.it/it/r36s/guida-acquisto) ho raccolto i segnali per riconoscerli: nomi di negozio generici, pochissime recensioni, prezzi troppo bassi. A scanso di equivoci, la mia è un'unità originale con chip Rockchip RK3326 e 1 GB di RAM. Nell'articolo di settembre avevo scritto Allwinner H700 per errore: l'ho corretto.

## Schermo

È un IPS da 3,5 pollici a 640x480. Ed è piccolo, soprattutto se come me gli occhi non sono più quelli di vent'anni fa. Per la pausa lampo o per una partita a letto è comunque perfettamente fruibile, i giochi 4:3 ci stanno bene e i colori sono buoni per il prezzo. Se pensate di fare sessioni lunghe su titoli con testo minuscolo, mettete in conto la fatica.

## Stick e comandi

La sorpresa positiva. Gli stick sono fluidi e rispondono bene, e comunque tutti i comandi si possono rimappare a piacere. I tasti dorsali sono un po' rigidi e L3/R3 non sono comodissimi da premere, ma niente che rovini l'esperienza.

## La SD di fabbrica da buttare

La prima cosa da fare, ancora prima di accenderla per giocare: cambiare la microSD. Quella in dotazione è di scarsa qualità e tende a corrompersi, quindi fate il backup dei giochi che ci trovate sopra e copiateli sulla nuova scheda. Io ho montato una SanDisk Pro che avevo già in casa, e la differenza si sente: più la scheda è buona, più la console è reattiva, sia nei caricamenti sia nell'uso generale.

Occhio anche alle SD contraffatte che dichiarano una capienza che non hanno. Sono comunissime, su AliExpress e non solo.

## Firmware: dArkOSen con un installer fatto da me

Il firmware di fabbrica è una versione di ArkOS, che oggi non è più mantenuto né aggiornato. Cambiarlo non è obbligatorio, perché funziona comunque, ma io lo consiglio. Io ho installato [dArkOSen](https://pixelpocket.1612.it/it/r36s/setup-firmware), erede di ArkOS basato su Debian. Sotto c'è quindi Linux, con RetroArch come motore degli emulatori ed EmulationStation come frontend: strumenti che conosce chiunque si sia già avvicinato al mondo degli emulatori, quindi niente di strano da imparare. Il problema semmai è che ogni scheda madre R36S ha un pannello (file DTB) leggermente diverso e va trovato quello giusto, spesso per tentativi.

Per non rifare tutto a mano ogni volta ho scritto [R36S Auto-Installer](https://pixelpocket.1612.it/it/r36s/r36s-autoinstaller), un programma per Windows gratuito che scarica il firmware, lo scrive sulla SD e ti accompagna nella ricerca del pannello giusto.

 Non scarica né installa giochi, quindi il backup resta a carico vostro. Se vi si blocca lo schermo al primo avvio, non è per forza un guasto: prima di tutto leggete la pagina di [troubleshooting](https://pixelpocket.1612.it/it/r36s/troubleshooting).

## Cosa gira bene (e cosa no)

Fino alla PS1 va tutto bene, e questo copre la stragrande maggioranza di quello che si cerca su una console così. I titoli più pesanti possono faticare. Per orientarsi, nella [pagina di compatibilità](https://pixelpocket.1612.it/it/r36s/compatibilita) ci sono le percentuali per sistema raccolte dalla community, con PSP, N64 e Dreamcast a livello discreto, mentre GameCube, PS2 e Wii sono fuori portata con questo chip.

Per quanto riguarda come organizzare ROM e BIOS ho scritto due guide pratiche: [gestione dei giochi](https://pixelpocket.1612.it/it/r36s/9-R36S-Guida-ai-giochi) e [guida ai BIOS](https://pixelpocket.1612.it/it/r36s/8-r36s-guida-ai-bios).

## Batteria e WiFi

Con i giochi arcade la batteria mi dura 5-6 ore, e scende un po' con i titoli che chiedono più prestazioni. Con il WiFi attivo, che io uso per lo scraper, l'autonomia cala a 2-3 ore. Il WiFi, tra l'altro, non è integrato: serve un adattatore USB esterno (i modelli compatibili sono elencati nella pagina di compatibilità). Se non vi serve online, spegnetelo e l'autonomia ne guadagna.

## Verdetto

A 35 euro la R36S è difficile da battere se la prendete da una fonte affidabile, ne conoscete i limiti e siete disposti a dedicare un pomeriggio al firmware. Schermo piccolo, SD da cambiare subito, un po' di smanettamento iniziale: sono i compromessi. In cambio avete stick ottimi, un'emulazione solida fino alla PS1 e una community enorme. Per chi parte da zero e non vuole smanettare, un [Miyoo Mini Plus](/posts/mini-console-e-handheld-retrogaming-quale-comprare-nel-2026/) è più semplice. Per tutti gli altri, questa è un'ottima compagna "da bagno".

Se avete dubbi o problemi di installazione, c'è un [gruppo Facebook dedicato alla R36S](https://www.facebook.com/groups/1112846354444421) dove ci aiutiamo a vicenda, e un [server Discord](https://discord.gg/Ew6rQvCRn) per il supporto. Passate pure, anche solo per curiosare.
