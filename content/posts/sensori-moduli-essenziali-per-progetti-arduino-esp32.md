---
title: "Sensori e moduli essenziali per progetti Arduino ed ESP32"
date: 2026-08-27
draft: false
tags: ["arduino", "esp32", "elettronica", "guida-acquisto"]
categories: ["Arduino"]
description: "DHT22, BME280, AHT20, HC-SR04 e gli altri moduli che uso nei progetti Arduino ed ESP32: cosa comprare, quanto costa e quando scegliere l'uno o l'altro."
cover:
  image: "/images/posts/sensori-moduli-essenziali-per-progetti-arduino-esp32.png"
  alt: "Sensori e moduli elettronici per Arduino ed ESP32 su una scrivania"
---

{{< affiliate-disclosure >}}

Dopo il [kit Arduino per principianti](/posts/kit-arduino-per-principianti-quale-comprare-nel-2026/) arriva sempre la stessa fase: hai fatto lampeggiare il LED, hai capito come funziona il breadboard, e ora vuoi costruire qualcosa che serva davvero a qualcosa. Una stazione meteo, un sistema di irrigazione che controlla l'umidità del terreno, un allarme che si accorge se qualcuno entra in garage. A quel punto il kit base non basta più, e la domanda cambia: quali sensori valgono i pochi euro che costano, e quali invece sono solo scartoffie da bancarella cinese che sembrano fare tutto e non fanno bene niente?

Ho una scatola intera di moduli comprati negli anni, buona parte finiti in un cassetto dopo un solo progetto. Questi qui sotto, invece, li ricompro ogni volta che parte un nuovo progetto, sia su Arduino che su ESP32: sono quelli che uso per davvero, non quelli che sembrano fighi nella lista dei bestseller.

## DHT22: il sensore temperatura/umidità con cui ho iniziato

Il [**DHT22**](https://www.amazon.it/dp/B078SVZB1X?tag=16120s-21) (a volte venduto come AM2302, con il modulo già saldato su una piccola scheda a tre pin) è probabilmente il primo sensore ambientale che chiunque compra dopo lo starter kit. Legge temperatura e umidità con una precisione discreta (±0.5°C, ±2-5% di umidità relativa) e comunica su un solo pin digitale con un protocollo proprietario, gestito benissimo dalla libreria DHT di Adafruit che trovi nel Library Manager dell'IDE Arduino senza dover cercare nulla altrove.

Il limite vero è la velocità: il DHT22 dà una lettura ogni due secondi al massimo, quindi se ti serve un campionamento veloce non è lo strumento giusto. Per una stazione meteo domestica o un controllo umidità in cantina va benissimo così, e costa pochi euro. C'è anche il fratello minore, il DHT11, più economico ma meno preciso: se il budget è tirato al centesimo va bene, ma la differenza di prezzo tra i due è minima e il DHT22 la vale tutta.

## BME280: quando serve anche la pressione barometrica

Il [**BME280**](https://www.amazon.it/dp/B07Z99FDLW?tag=16120s-21) di Bosch è un salto di qualità netto rispetto al DHT22: stesso pacchetto di temperatura e umidità, ma con precisione superiore, comunicazione I2C o SPI (quindi più moduli sullo stesso bus senza sprecare pin) e, soprattutto, un sensore di pressione barometrica in più. Con la pressione puoi fare due cose interessanti: stimare l'altitudine con una precisione ragionevole, oppure usarla come indicatore grezzo per prevedere il cambio di tempo nelle ore successive, cosa che il DHT22 semplicemente non può fare.

Il modulo si trova quasi sempre su una breakout board minuscola, spesso venduta insieme al cugino BMP280 (che è lo stesso chip ma senza il sensore di umidità, e costa un po' meno se ti serve solo temperatura e pressione). Lo uso in ogni progetto di monitoraggio ambientale su ESP32 dove ho già altri sensori I2C collegati: bus condiviso, quattro fili in tutto, zero drammi di cablaggio.

## AHT20: preciso, economico, sottovalutato

L'[**AHT20**](https://www.amazon.it/dp/B0CVHWWF34?tag=16120s-21) è il sensore che consiglio quando il BME280 è troppo per quello che devi fare. È solo temperatura e umidità (niente pressione), ma con una precisione che in alcuni casi batte anche il BME280 sull'umidità, un consumo energetico bassissimo (importante se il progetto gira a batteria) e un prezzo che di solito è la metà del BME280. Comunica anche lui via I2C, e lo trovi spesso in coppia con un modulo BMP280 sulla stessa breakout, venduto come "AHT20+BMP280", che di fatto ti dà l'equivalente funzionale di un BME280 spendendo meno.

Se il progetto è una centralina per il balcone o una sonda per l'armadio dove tieni il filamento della stampante 3D lontano dall'umidità (ne ho parlato nella [guida sulla conservazione dei filamenti](/posts/guida-conservazione-documenti-umidita/)), l'AHT20 fa tutto quello che serve senza spendere di più per una funzione, la pressione, che in quel contesto non ti interessa.

## HC-SR04: distanza a ultrasuoni, il classico che funziona sempre

L'[**HC-SR04**](https://www.amazon.it/dp/B01COSN7O6?tag=16120s-21) è probabilmente il sensore più fotografato di tutto il mondo Arduino, quello con i due "occhi" cilindrici che emettono e ricevono l'impulso a ultrasuoni. Misura distanze da circa 2 cm a 4 metri con un errore di pochi millimetri, costa meno di due euro e funziona su qualsiasi progetto: livello dell'acqua in una cisterna, parcheggio assistito fai-da-te, robot che evita ostacoli, contapersone rudimentale su una porta.

L'unica accortezza reale riguarda il pin Echo: lavora a 5V, e se lo colleghi direttamente a un ESP32 (che ha i pin GPIO a 3.3V) rischi di danneggiare la scheda nel tempo. Serve un partitore di tensione con due resistenze, oppure comprare direttamente una versione a 3.3V pensata per microcontrollori moderni. È il classico errore da principiante che si fa una volta sola, ma vale la pena saperlo prima e non dopo aver fritto un pin.

## HC-SR501: il sensore di movimento PIR che apre le porte alla domotica

Il [**modulo PIR HC-SR501**](https://www.amazon.it/dp/B07Z67PWXH?tag=16120s-21) rileva movimento tramite radiazione infrarossa emessa dal corpo umano, esattamente come i sensori antifurto commerciali. Ha due trimmer regolabili a bordo scheda: uno per la sensibilità (quindi la distanza massima di rilevamento, fino a circa 7 metri) e uno per il tempo di attivazione dell'uscita dopo il rilevamento. È il sensore con cui ho fatto il mio primo vero progetto di domotica DIY, prima ancora di scoprire Home Assistant: una luce che si accende da sola quando entro in garage, alimentata da un relè collegato a un ESP32.

Se il progetto finale deve dialogare con [Home Assistant](/posts/notifica-telegram-login-fallito-home-assistant/), un ESP32 con HC-SR501 e firmware ESPHome è probabilmente la strada più veloce per aggiungere un sensore di presenza custom in una stanza dove non vuoi comprare un sensore commerciale Zigbee.

## DS3231: l'orologio in tempo reale che risolve un problema reale

Se il progetto deve sapere che ore sono anche dopo un riavvio o un blackout, ti serve un modulo RTC (real time clock), e il [**DS3231**](https://www.amazon.it/dp/B01CAOG8IG?tag=16120s-21) è quello giusto da comprare, non l'alternativa più economica DS1307. La differenza non è cosmetica: il DS3231 ha un oscillatore compensato in temperatura che mantiene una precisione di pochi secondi al mese, contro i minuti di deriva del DS1307 nel tempo. Ha anche una batteria a bottone CR2032 a bordo che mantiene l'orario anche a scheda spenta, e comunica via I2C con la solita libreria RTClib di Adafruit.

Lo uso in ogni progetto che deve loggare eventi con timestamp reale (una centralina meteo che scrive su SD card, un irrigatore programmato) invece di affidarsi solo al millis() di Arduino, che si azzera a ogni riavvio e non sa che giorno è oggi.

## Sensore di umidità del terreno capacitivo: meglio del modello resistivo

Per progetti di irrigazione fai-da-te la scelta corretta oggi è il [**sensore capacitivo di umidità del terreno v1.2**](https://www.amazon.it/dp/B07Z6DJMJL?tag=16120s-21), non il vecchio modello resistivo a due piastre metalliche nude che si trova ancora in giro a un euro in meno. Il sensore resistivo corrode letteralmente nel terreno umido nel giro di poche settimane, per via dell'elettrolisi tra le due piastre metalliche a contatto diretto con acqua e sali minerali: l'ho verificato di persona, un sensore comprato per un vaso di basilico si è ossidato visibilmente in meno di un mese. Il capacitivo, con il circuito protetto da uno strato di resina epossidica, non ha questo problema e dura anni.

Uscita analogica, quindi un solo pin ADC su Arduino o ESP32, e una calibrazione manuale da fare una volta sola (valore a secco, valore in acqua) per tarare le soglie nel codice.

## MQ-135: qualità dell'aria, con un avvertimento

L'[**MQ-135**](https://www.amazon.it/dp/B0816PQRMB?tag=16120s-21) è il sensore di gas generico più venduto per Arduino, sensibile a una combinazione di ammoniaca, benzene, CO2 e altri composti organici volatili. È utile per un indicatore approssimativo della qualità dell'aria in una stanza, non per una misura scientifica: i sensori della famiglia MQ sono economici perché usano un elemento resistivo (biossido di stagno) che cambia resistenza in presenza di gas, con una risposta che varia da esemplare a esemplare e richiede riscaldamento per alcuni minuti prima di stabilizzarsi.

Se ti basta un "sta peggiorando o migliorando rispetto a un'ora fa" per attivare una ventola o mandare una notifica, va benissimo. Se ti serve un dato di concentrazione CO2 affidabile in ppm, serve altro (un sensore NDIR tipo SCD40, che costa molto di più ma è un'altra categoria di precisione).

## Servo SG90: l'attuatore che compare in metà dei progetti Arduino

Chiudo con l'unico attuatore di questa lista: il [**micro servo SG90**](https://www.amazon.it/dp/B07CZ42862?tag=16120s-21). Nove grammi di peso, coppia modesta ma sufficiente per aprire una valvola, muovere una tendina di un pannello solare, azionare un mangime automatico per il gatto. Si pilota con un solo pin PWM e la libreria Servo integrata nell'IDE Arduino, senza driver esterni per progetti semplici. Non aspettarti robustezza da uso intensivo continuo: gli ingranaggi sono in plastica e con carichi ripetuti nel tempo si consumano, ma per un progetto hobbistico che aziona qualcosa poche volte al giorno dura tranquillamente anni.

## Cosa comprerei io per iniziare

Se stai partendo da zero con un ESP32 e vuoi coprire i casi d'uso più comuni senza spendere una fortuna: DHT22 o AHT20 per temperatura e umidità, HC-SR04 per le distanze, HC-SR501 per il movimento, e un DS3231 se il progetto deve tenere il tempo sul serio. Messi insieme costano meno di una singola bobina di filamento di marca, e coprono la maggior parte dei progetti da homelab e domotica DIY che si trovano online.

Una cosa che vale per tutti i moduli elencati qui: prima di saldare qualcosa in modo definitivo, monta sempre il progetto su breadboard e testalo per bene. I sensori economici hanno una percentuale di pezzi difettosi più alta di quanto ci si aspetti, e scoprirlo dopo aver saldato è molto più fastidioso che scoprirlo prima.
