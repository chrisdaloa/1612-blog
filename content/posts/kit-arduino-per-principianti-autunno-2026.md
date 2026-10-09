---
title: "Kit Arduino per principianti: quale comprare (autunno 2026)"
date: 2026-10-09
draft: false
tags: ["arduino", "elettronica", "guida-acquisto", "diy"]
categories: ["Arduino"]
description: "Aggiornamento autunno 2026 sui kit Arduino per principianti: ELEGOO, Freenove, kit ufficiale con UNO R4 WiFi e dove si colloca la nuova UNO Q."
cover:
  image: "/images/posts/kit-arduino-per-principianti-autunno-2026.png"
  alt: "Tre kit Arduino per principianti con schede, breadboard e componenti su un tavolo"
---

A luglio ho scritto la [guida ai kit Arduino per principianti](/posts/kit-arduino-per-principianti-quale-comprare-nel-2026/). Da allora la domanda che torna è un'altra: "ma con la UNO Q in giro, ha ancora senso prendere un kit con la UNO classica?". Risposta breve: sì, quasi sempre. Qui spiego perché e come sceglierei oggi, partendo da chi sei e non dal catalogo.

## Cos'è la UNO Q e perché confonde i principianti

La UNO Q ha il formato della UNO, ma dentro è un'altra bestia: un SoC Qualcomm che gira Linux affiancato da un microcontrollore STM32 per la parte real-time. Due cervelli su una scheda, la stessa idea che Arduino ha spinto ancora più in alto con la [VENTUNO Q](/posts/arduino-ventuno-q-npu-qualcomm-40-tops-physical-ai/) di cui ho parlato qualche settimana fa.

Sulla carta è affascinante. Per chi parte da zero è però il punto di partenza sbagliato, e te lo dico con un'opinione netta: se non hai mai acceso un LED con un pin digitale, non ti serve un computer Linux su una scheda. Ti serve capire cosa succede quando colleghi un pulsante senza resistenza di pull-down. Con una scheda più complessa le cose che possono andare storte raddoppiano, e i tutorial pensati per principianti sono ancora quasi tutti scritti per la UNO classica o la R4.

La UNO Q ha senso come secondo acquisto, quando hai già fatto qualche progetto e vuoi mettere insieme sensori, visione e un po' di AI locale. Prima no.

## ELEGOO UNO R3 Super Starter Kit: se il budget conta

Resta la mia scelta di default per chi vuole solo provare. Dentro c'è una scheda compatibile UNO R3, breadboard, LED, resistenze, sensori di base, un LCD 1602, servo e motorino, più un PDF con una trentina di progetti. Costa poco e ti lascia fare un mese di esperimenti senza ordinare altro.

Il difetto è noto: la scheda è un clone con chip USB CH340, quindi sul PC può servire il driver prima che venga riconosciuta. Capita, si risolve in due minuti, ma sapere in anticipo che esiste evita l'idea che il kit sia difettoso. La documentazione è sufficiente, non brillante.

## Freenove Ultimate Starter Kit V4: se vuoi capire, non solo copiare

Qui paghi un po' di più e ottieni un manuale molto più curato: schemi chiari, codice commentato, spiegazioni sul perché di ogni componente. I moduli sono anche più interessanti (RFID, joystick, relè, OLED), quindi il kit non si esaurisce dopo le prime settimane.

Se il principiante in questione sei tu e hai pazienza per leggere, o se lo regali a un ragazzo che non avrà nessuno a spiegargli le cose, il Freenove è quello che mi sembra più onesto. La differenza non sta nel numero di pezzi ma nella qualità del percorso.

## Kit ufficiale Arduino con UNO R4 WiFi: se vuoi l'originale

Il kit Arduino ufficiale resta il più caro dei tre e ha meno componenti. Quello che compri è la scheda originale, il manuale cartaceo con un approccio graduale e un percorso didattico usato anche nelle scuole. Con la UNO R4 WiFi hai un processore a 32 bit, WiFi e Bluetooth integrati e la matrice LED 12x8 sulla scheda, utili se prima o poi vuoi mandare dati in rete senza comprare moduli esterni.

È anche la scelta più sensata se vuoi un ponte verso schede più recenti: l'ambiente di sviluppo e la logica sono quelli, e passare in seguito a una UNO Q o a una scheda ESP32 è meno traumatico di quanto sembri.

## Come sceglierei oggi

- **Voglio solo provare, spendendo poco**: ELEGOO UNO R3 Super Starter Kit.
- **Voglio imparare davvero, o lo regalo a un ragazzo**: Freenove Ultimate Starter Kit V4.
- **Voglio l'originale e il WiFi integrato**: kit ufficiale Arduino con UNO R4 WiFi.
- **Ho già le basi e voglio AI e Linux sulla scheda**: lascia perdere i kit, guarda la UNO Q come secondo passo.

Prima di ordinare, controlla il prezzo del giorno: su questi kit oscilla parecchio tra offerte e periodi senza sconto, e non ho modo di fissarlo qui in modo affidabile.

Un consiglio che vale per tutti: accanto al kit, leggi la guida ai [sensori e moduli essenziali per Arduino ed ESP32](/posts/sensori-moduli-essenziali-per-progetti-arduino-esp32/). Quando finisci i progetti del manuale, è lì che capisci cosa comprare dopo, invece di riempire il cassetto di moduli che non userai.

La scheda conta meno di quanto sembri. Quello che fa la differenza è sbagliare cablaggi, bruciare qualche componente da due euro e riprovare. Qualunque kit scegli, il percorso passa da lì.
