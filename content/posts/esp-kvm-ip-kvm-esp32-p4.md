---
title: "ESP-KVM: un IP-KVM open source con un solo ESP32-P4, alternativa economica a PiKVM e JetKVM"
date: 2026-08-01
draft: false
tags: ["arduino", "esp32", "elettronica", "homelab"]
categories: ["Arduino"]
description: "ESPKVM è un progetto open source che trasforma un ESP32-P4 in un IP-KVM completo: cattura video HDMI, emulazione tastiera/mouse, streaming e wake-on-LAN."
cover:
  image: "/images/posts/esp-kvm-ip-kvm-esp32-p4.png"
  alt: "Scheda ESP32-P4 collegata a un bridge HDMI come IP-KVM open source"
---

{{< affiliate-disclosure >}}

Ogni volta che un server headless in homelab si pianta durante il boot e non risponde più via SSH, il problema è sempre lo stesso: senza schermo e tastiera attaccati fisicamente non vedi cosa sta succedendo. Un IP-KVM risolve proprio questo problema, ma le soluzioni commerciali serie (PiKVM, JetKVM) partono da un Raspberry Pi o da una scheda dedicata, con un prezzo che per un homelab domestico è spesso sproporzionato rispetto all'uso reale che se ne fa. ESPKVM prova a colmare proprio questo divario.

ESPKVM, ripreso da Hackaday il 30 luglio, fa la stessa cosa con un solo [ESP32-P4](https://www.amazon.it/dp/B0F2MP483W?tag=16120s-21). L'autore, Evgenij Spitsyn, si è ispirato a un build KVM già pubblicato su Hackaday in passato e ha rifatto tutto attorno a un microcontrollore invece che a un Raspberry Pi: non serve una scheda SD con un sistema operativo da flashare, né un Linux da mantenere: solo firmware su un SoC.

## Come cattura il video senza un Raspberry Pi

Il pezzo tecnicamente interessante è il bridge [Toshiba TC358743](https://www.amazon.it/dp/B09H2N99VL?tag=16120s-21), che converte l'HDMI in ingresso in CSI, l'interfaccia video che normalmente vediamo usata per collegare una telecamera a una scheda embedded. L'ESP32-P4 legge quel flusso CSI e lo ricomprime in streaming MJPEG o H.264 verso il client remoto. Sulla stessa scheda, il microcontrollore si presenta al computer target come tastiera e mouse USB standard: dal punto di vista del sistema operativo collegato non c'è differenza rispetto a periferiche vere, quindi funziona anche nel BIOS o UEFI, prima che carichi qualunque driver.

In più ESPKVM gestisce l'emulazione di una chiavetta USB di storage (da microSD o dalla flash interna, utile per montare un'ISO al volo), il controllo di power/reset via relè o optoisolatore, e il wake-on-LAN. È il pacchetto completo che serve davvero per amministrare un server da remoto senza mettere piede in cantina o in garage, dove tengo io il rack.

## Il vantaggio pratico: zero saldature

La parte che mi ha convinto a segnarmelo per un weekend è che il progetto si flasha direttamente dal browser, via WebUSB, dal sito ufficiale di ESPKVM: si collega la scheda, si tiene premuto il pulsante di boot per farla entrare in modalità download, e in pochi secondi il firmware è scritto, senza installare esptool o driver a riga di comando (serve solo Chrome o Edge, WebUSB su Firefox e Safari non c'è ancora). Non serve saldare niente se si parte da moduli ESP32-P4 e breakout TC358743 già assemblati, cosa che abbassa parecchio la barriera d'ingresso rispetto ai progetti KVM DIY che ho visto negli anni scorsi, quasi sempre pensati per chi mastica elettronica seriamente.

Il confronto onesto con PiKVM resta comunque a favore di quest'ultimo su un punto: maturità del software e una community più ampia alle spalle. ESPKVM è giovane, un singolo sviluppatore, e lo stesso autore lo dice chiaro: il progetto non è ancora stato revisionato per la sicurezza, nonostante ci sia già un'autenticazione di base. Tradotto: perfetto per la rete locale, da non esporre su internet finché qualcuno non ci fa un audit serio. Chi lo facesse comunque dovrebbe almeno metterlo dietro un tunnel WireGuard o un reverse proxy con la sua brava autenticazione a monte, non fidarsi del solo login integrato.

## Quanto costa davvero, in pratica

Il conto lo faccio sempre con i numeri reali. Un JetKVM già assemblato parte da circa 69 dollari, a cui si sommano spedizione e dazi verso l'Italia. Un kit PiKVM completo di case e adattatore HDMI-to-CSI si avvicina facilmente ai 100-120 euro, a meno che tu non abbia già un Raspberry Pi libero da riciclare. Con ESPKVM il conto cambia: una scheda ESP32-P4 costa 10-15 euro, un breakout con il TC358743 altri 10-15 euro, e con un cavo HDMI corto si resta sotto i 30 euro totali, senza comprare né Raspberry Pi né case ufficiale. Il compromesso è chiaro: PiKVM offre virtual media più maturo e un'interfaccia collaudata da anni, mentre qui ci si affida a un progetto nato da poche settimane e a una community ancora minuscola.

## Perché mi interessa

Ho un paio di macchine in homelab che tengo headless apposta per risparmiare uno slot HDMI e un cavo in più, e uno switch KVM hardware tradizionale a più porte costa più di quanto valga per l'uso che ne farei (qualche accesso al mese, di solito quando qualcosa va storto durante un aggiornamento). Il caso concreto che mi capita più spesso è il NAS che resta bloccato in fase di boot dopo un update del kernel: senza monitor collegato l'unica soluzione è staccare tutto e portarlo alla scrivania, scomodo con un NAS a 4 dischi. Un ESP32-P4 da poche decine di euro con TC358743 attaccato copre lo stesso caso d'uso a una frazione del prezzo di un JetKVM, e il fatto che sia open source significa poter aggiustare o estendere il firmware invece di aspettare un fix ufficiale che magari non arriva mai. Non è la prima volta che un chip di questa famiglia finisce sotto i riflettori per l'homelab: ne avevo parlato anche a proposito dell'[ESP32-S31 con Ethernet Gigabit nativo](/posts/esp32-s31-ethernet-gigabit-rgmii-nativo/), altro esempio di quanto questi microcontrollori si stiano avvicinando a compiti finora riservati a schede più costose.

Non l'ho ancora provato sulle mie macchine, quindi non posso garantire quanto sia stabile lo streaming H.264 sotto carico reale o quanto lag ci sia sulla tastiera durante l'uso nel BIOS, dove ogni millisecondo di ritardo si sente. Ma è esattamente il tipo di progetto che finisce nella lista "da montare appena trovo mezz'ora libera".

Fonte: [Hackaday](https://hackaday.com/2026/07/30/a-capable-kvm-built-with-the-esp32/)
