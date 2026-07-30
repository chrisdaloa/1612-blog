---
title: "ESP32-S31: il primo ESP32 con Ethernet Gigabit nativo (RGMII) entra in produzione"
date: 2026-07-30
draft: false
tags: ["arduino", "esp32", "elettronica", "homelab"]
categories: ["Arduino"]
description: "Espressif ha messo in produzione l'ESP32-S31, la prima variante con controller RGMII per Ethernet Gigabit nativa, oltre a ESP-NOW v2, preferenze RTC-backed e supporto touch/e-paper integrato. ESPHome 2026.7.0 lo supporta già."
cover:
  image: "/images/posts/esp32-s31-ethernet-gigabit-rgmii-nativo.png"
---

Ogni progetto ESPHome che ho cablato invece che lasciare su WiFi ha avuto lo stesso destino: un modulo W5500 su SPI appiccicato accanto all'ESP32 con un pugno di jumper, un secondo alimentatore da gestire, e la CPU del microcontrollore che si spacca in due tra gestire i sensori e fare da postino tra bus SPI e stack TCP/IP. Funziona, ma è un compromesso che porti avanti perché non c'è alternativa migliore. Con l'ESP32-S31 quel compromesso inizia a sparire.

Lo segnala Adafruit sul proprio blog: Espressif ha messo in produzione di massa l'ESP32-S31, la prima variante della famiglia con un controller RGMII integrato per collegarsi direttamente a un PHY Ethernet Gigabit, senza passare da un chip Ethernet esterno collegato via SPI. È una differenza che sembra un dettaglio da datasheet e invece cambia parecchio l'equazione per chi fa domotica o monitoraggio cablato sul serio.

## RGMII, non RMII: la differenza che conta

Alcuni ESP32 più vecchi (l'ESP32 originale, per dire) hanno già un'interfaccia MAC Ethernet integrata, ma parliamo di RMII, limitata a 100 Mbit e comunque bisognosa di un PHY esterno via pochi pin dedicati. Per chi voleva qualcosa di più veloce o più affidabile, la strada obbligata restava il modulo W5500 (o il vecchio ENC28J60, ancora più lento) su SPI: un chip Ethernet completo, MAC e PHY inclusi, che parla con l'ESP32 come se fosse una periferica qualsiasi. Funziona bene, l'ho usato in diversi progetti, ma la banda SPI diventa il collo di bottiglia e la CPU deve gestire l'interrupt di ogni pacchetto in arrivo.

RGMII è un'altra categoria di interfaccia: un bus parallelo pensato apposta per collegare un MAC a un PHY Gigabit con un overhead molto più basso sulla CPU, lo stesso approccio che trovi su router e switch gestiti veri. Mettere un controller RGMII dentro un SoC da poco più di un dollaro in volume è la parte tecnicamente interessante di questo annuncio: Espressif porta silicio da apparato di rete dentro un microcontrollore pensato per un termostato intelligente o un sensore da giardino.

## Le altre novità della S31

Secondo quanto riporta Adafruit, insieme all'Ethernet Gigabit la S31 porta:

- **ESP-NOW v2** con payload più ampio, utile se usi questo protocollo peer-to-peer per far parlare tra loro sensori a batteria senza passare da un router;
- **preferenze RTC-backed**, cioè impostazioni che sopravvivono a reset e cali di alimentazione senza dover scrivere su flash a ogni cambio di stato: un dettaglio piccolo ma che allunga la vita dei moduli che salvano configurazione spesso, visto che la flash ha un numero finito di cicli di scrittura;
- **supporto nativo per controller touch capacitivi e pannelli e-paper**, che finora richiedeva quasi sempre un chip driver dedicato e level shifter a parte sulla scheda.

E la conferma che più mi interessa in ottica pratica: **ESPHome 2026.7.0** ha già il supporto per la S31. Non è scontato: spesso un nuovo SoC Espressif resta "solo Arduino/ESP-IDF" per mesi prima che arrivi in ESPHome, e per chi usa Home Assistant è ESPHome che fa davvero la differenza tra "posso usarlo nel weekend" e "aspetto ancora".

## Perché mi interessa, in concreto

Uso Ethernet cablata invece del WiFi ogni volta che un sensore o un attuatore sta in un punto dove il segnale fa i capricci: un quadro elettrico metallico, una cantina con muri spessi, un armadio rack dove il rumore RF di altri apparati rende il WiFi inaffidabile proprio quando serve continuità. In quei casi il cavo Ethernet non è un vezzo da smanettone, è l'unica cosa che garantisce che il dispositivo resti raggiungibile senza retry infiniti e drop di connessione nei log di Home Assistant.

Fino a oggi la ricetta era sempre la stessa: ESP32 più modulo W5500 su una piccola breakout, magari con un modulo PoE separato per alimentare tutto dallo stesso cavo. Funziona, ma significa due chip, due datasheet da conciliare, e uno spazio scheda che cresce. Con RGMII nativo nella S31 basta il SoC e un PHY Gigabit esterno (che comunque serve sempre, l'interfaccia fisica va gestita da un chip dedicato), ma sparisce tutto il livello SPI di mezzo: meno componenti, meno punti di guasto, meno CPU sprecata a fare da traduttore tra due bus.

## Le domande che mi restano aperte

Non ho ancora messo le mani su una scheda con questa S31, quindi vado con cautela su un paio di punti. Il primo è il package: un controller RGMII richiede più pin dedicati rispetto a una semplice interfaccia SPI, quindi immagino un package con più pad e passo più fine, meno amichevole per chi fa prototipazione con moduli da saldare a mano (la stessa distinzione che vediamo già tra le board hobbistiche facili da montare e i chip pensati per essere integrati direttamente su PCB industriali). Il secondo è il prezzo delle prime schede breakout: sul silicio nudo Espressif è aggressiva, ma le prime board di terze parti con PHY Gigabit, regolatore di alimentazione e connettore RJ45 integrato di solito costano più della somma delle parti finché il volume non sale.

Detto questo, la direzione è quella giusta. Il WiFi resta comodo per l'80% dei progetti hobbistici, ma per chi fa domotica sul serio (non solo un sensore di temperatura in salotto, ma un impianto con decine di nodi dove l'affidabilità della connessione conta quanto la logica applicativa) avere Ethernet Gigabit vera, senza il balletto SPI, su un chip da homelab è esattamente il tipo di upgrade silenzioso che nei prossimi anni finisce in un sacco di progetti senza che nessuno ci faccia più caso. Che è probabilmente il miglior indicatore che una tecnologia ha vinto: quando smetti di parlarne perché funziona e basta.

Fonte: [Adafruit](https://blog.adafruit.com/2026/07/27/esp32-s31-now-in-mass-production-and-available-for-purchase/)
