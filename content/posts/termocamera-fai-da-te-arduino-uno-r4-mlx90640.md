---
title: "Una termocamera fai-da-te con Arduino UNO R4 e sensore Seeed MLX90640"
date: 2026-09-04
draft: false
tags: ["arduino", "elettronica", "diy", "homelab"]
categories: ["Arduino"]
description: "Katie Dumont ha costruito una termocamera portatile con Arduino UNO R4, sensore Seeed MLX90640 e case stampato in 3D: come funziona e cosa serve."
cover:
  image: "/images/posts/termocamera-fai-da-te-arduino-uno-r4-mlx90640.png"
  alt: "Termocamera fai-da-te con Arduino UNO R4 e sensore infrarossi MLX90640"
---

{{< affiliate-disclosure >}}

Una termocamera vera costa da 300 euro in su per i modelli decenti, e quelle economiche da 60-80 euro hanno risoluzioni talmente basse (spesso 8x8 pixel) da essere quasi inutili per capire davvero dove sta scappando il calore da un infisso o dove si sta scaldando troppo un componente. Su element14 Presents ho letto il progetto di Katie Dumont, che ha risolto il problema costruendosela da sé con pezzi che si comprano singolarmente online: [Arduino UNO R4](https://www.amazon.it/dp/B0C78K4CD4?tag=16120s-21), sensore a infrarossi Seeed Studio MLX90640 e un touchscreen capacitivo DFRobot Fermion, il tutto chiuso in un case disegnato in FreeCAD e stampato in 3D.

## Cosa c'è dentro

Il cuore del progetto è l'**Arduino UNO R4** (nella variante Minima), che rispetto alla vecchia UNO R3 porta un processore Renesas RA4M1 decisamente più capace, memoria sufficiente per gestire un flusso video in tempo reale dal sensore e, soprattutto, comunicazione I2C affidabile per dialogare con il modulo termico. Non serve la potenza di un Raspberry Pi qui: il lavoro è leggere una griglia di pixel termici e disegnarla a schermo, non fare inferenza AI, e un microcontrollore fa benissimo il suo mestiere. Se stai valutando quale scheda comprare per iniziare, nella mia guida ai [kit Arduino per principianti](/posts/kit-arduino-per-principianti-quale-comprare-nel-2026/) trovi anche la UNO R4 tra le opzioni a confronto.

Il sensore è un **Seeed Studio MLX90640**, basato sul chip Melexis MLX90640 con risoluzione 32x24 pixel e campo visivo di 110° nella versione wide. Non è il top di gamma dei sensori termici (quelli con risoluzione 160x120 costano dieci volte tanto e finiscono su termocamere professionali), ma per un progetto hobbistico 32x24 è più che sufficiente: bastano per vedere una dispersione termica su una parete, un cavo che scalda più del dovuto, o dove il gatto si è appisolato sul divano un'ora prima. Comunica via I2C, quindi il collegamento con l'Arduino UNO R4 è essenzialmente quattro fili.

Per l'output visivo Dumont ha usato un touchscreen capacitivo DFRobot Fermion, che mostra la mappa termica a colori in tempo reale e gestisce anche l'interazione touch per i menu, invece del solito display TFT con pulsanti fisici che si vede in tanti progetti simili più vecchi. Il case che tiene insieme tutto è stato disegnato in FreeCAD e stampato in 3D, la strada più sensata quando devi impacchettare una scheda, un sensore e uno schermo in qualcosa che stia comodo in una mano e non sembri un accrocchio da banco.

## A cosa serve davvero

Le termocamere fai-da-te di questo tipo non sono un giocattolo. Il caso d'uso più concreto è la diagnostica HVAC e degli impianti elettrici: individuare perdite di calore in un impianto di riscaldamento, trovare un punto dove l'isolamento di una casa fa cilecca, controllare se un morsetto elettrico o un componente su una scheda sta scaldando più del previsto prima che diventi un problema serio. Nel mio piccolo, l'ho fatto con termocamere a noleggio per capire dove un radiatore in casa non scaldava uniformemente, e uno strumento del genere sempre a portata di cassetto degli attrezzi avrebbe accorciato parecchio la caccia.

C'è anche il lato ricreativo, che non va sottovalutato: vedere il mondo in falsi colori termici è uno di quei progetti che fa venire voglia di puntarla su tutto quello che c'è in casa solo per curiosità, dal frigorifero al gatto. Ma è proprio la combinazione delle due cose, utilità pratica e divertimento puro, che rende questo genere di build interessante rispetto a comprare un accessorio termico per lo smartphone (tipo i moduli FLIR One) che fa più o meno la stessa cosa ma ti lega a un telefono specifico e a un'app chiusa.

## Perché mi piace come progetto

Quello che apprezzo di questo build è che usa tre componenti comprabili separatamente, ognuno dei quali fa un lavoro ben preciso, invece di affidarsi a una scheda tuttofare che costa il triplo. L'Arduino UNO R4 gestisce logica e I2C, il sensore MLX90640 fa la parte termica, il display Fermion fa da interfaccia. Se domani il sensore si guasta, lo sostituisci senza rifare tutto il progetto, e se vuoi passare a una risoluzione più alta basta cambiare quel pezzo. È un approccio modulare che mi piace molto più delle scatole chiuse, e che ricorda da vicino il modo in cui ho messo insieme i [sensori per i miei progetti Arduino ed ESP32](/posts/sensori-moduli-essenziali-per-progetti-arduino-esp32/): componenti singoli, ognuno sostituibile, invece di una board monolitica.

Il costo totale si aggira sui 60-80 euro per Arduino UNO R4 e sensore MLX90640 messi insieme, più il display e il filamento per il case, quindi resta comunque una frazione di quello che costa una termocamera commerciale di livello base con risoluzione paragonabile. Non ho ancora stampato il mio, ma il progetto è già nella lista delle cose da rifare in un weekend, magari abbinandolo a un ESP32 al posto dell'UNO R4 se voglio anche il wifi per salvare gli screenshot termici direttamente su Home Assistant.

Fonte: [element14 Presents / Arduino Blog](http://blog.arduino.cc/2026/09/03/building-a-diy-thermal-camera-for-work-and-play/)
