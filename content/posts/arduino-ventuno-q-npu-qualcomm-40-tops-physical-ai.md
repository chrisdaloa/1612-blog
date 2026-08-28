---
title: "Arduino VENTUNO Q: la scheda \"Physical AI\" con NPU Qualcomm da 40 TOPS, preordini a 299 dollari"
date: 2026-08-28
draft: false
tags: ["arduino", "ai", "robotica", "elettronica"]
categories: ["Arduino"]
description: "Arduino apre i preordini della VENTUNO Q: SoC Qualcomm Dragonwing IQ8 con NPU fino a 40 TOPS e STM32H5 per il controllo motori in tempo reale, 299 dollari."
cover:
  image: "/images/posts/arduino-ventuno-q-npu-qualcomm-40-tops-physical-ai.png"
  alt: "Scheda Arduino VENTUNO Q con NPU Qualcomm per robotica physical AI"
---

{{< affiliate-disclosure >}}

VENTUNO in italiano vuol dire ventuno, e non è un caso: Arduino compie 21 anni proprio quest'anno, e per l'occasione ha tirato fuori quella che chiama la sua prima scheda "physical AI". Il nome bilingue è un dettaglio simpatico, ma quello che c'è dentro la scheda è tutt'altro che un gadget celebrativo: la VENTUNO Q è appena entrata in preordine a 299 dollari, e le specifiche raccontano una scheda pensata per un problema molto concreto, quello di far ragionare un robot e farlo muovere con la stessa latenza a cui siamo abituati con un microcontrollore puro.

## Due cervelli su una scheda sola

Il punto centrale della VENTUNO Q è l'architettura a due processori. Da un lato c'è un SoC Qualcomm Dragonwing IQ8, con una NPU che arriva fino a 40 TOPS, 16GB di RAM e 64GB di storage espandibile: è la parte che gira Linux, esegue i modelli AI ed elabora visione, sensori e decisioni ad alto livello. Dall'altro lato c'è un microcontrollore STM32H5, che gira su Zephyr con l'Arduino Core sopra, e si occupa del controllo motori e attuatori in tempo reale, dove i millisecondi contano davvero e un sistema operativo general purpose come Linux non è mai la scelta giusta.

È lo schema che chi fa robotica seria conosce bene: un cervello "lento" ma potente per la percezione e il ragionamento, un cervello "veloce" e deterministico per muovere davvero le cose senza jitter. Di solito questo si ottiene mettendo insieme due schede separate, tipo un [Jetson Orin Nano](https://www.amazon.it/dp/B0BZJTQ5YP?tag=16120s-21) accoppiato a un microcontrollore esterno via seriale o CAN bus, con tutto il casino di cablaggio e sincronizzazione che ne consegue. Arduino ha deciso di metterlo tutto su una board sola, e da progettista di piccoli robot in homelab è esattamente il tipo di scorciatoia che apprezzo: meno connettori tra i due mondi, meno punti di guasto, un solo pezzo da alimentare.

## Cosa significa "physical AI" in pratica

Il termine è diventato di moda negli ultimi mesi, ma qui ha un senso preciso: modelli AI che non si limitano a generare testo o immagini, ma prendono decisioni che si traducono in movimento fisico, in tempo reale, senza dover passare per il cloud. È lo stesso genere di controllo in tempo reale che serve a un [robot umanoide che fa capriole in diretta](/posts/capodanno-cinese-2026-robot-ai/), solo qui compresso su una scheda da 299 dollari invece che su una piattaforma robotica industriale. La VENTUNO Q arriva con modelli precaricati tramite Qualcomm AI Hub ed Edge Impulse, pensati per compiti tipici della robotica edge: riconoscimento oggetti, navigazione, controllo di bracci robotici o rover, il genere di cosa che fino a poco tempo fa richiedeva mandare i frame a un server remoto e aspettare la risposta.

Il vantaggio di tenere tutto offline non è solo la latenza. È anche non dover dipendere da una connessione internet stabile per far funzionare un robot in cantina, in un capannone o in un campo, e non dover mandare in giro video e sensori verso servizi terzi. Per chi fa robotica hobbistica seria, o per chi la porta in produzione su piccola scala, è un argomento che pesa più della cifra sui TOPS.

## Il confronto onesto con le alternative

A 299 dollari la VENTUNO Q si piazza in una fascia dove la concorrenza non manca. Il paragone più immediato è con un Jetson Orin Nano Super Developer Kit di NVIDIA, che parte da un prezzo simile e offre potenza di calcolo AI superiore sulla carta, ma senza un microcontrollore per il controllo motori integrato: lì il real-time te lo devi costruire da solo con un secondo dispositivo. L'altra alternativa comune è un [Raspberry Pi 5](https://www.amazon.it/dp/B0CK2FCG1K?tag=16120s-21) abbinato a un HAT AI (Hailo o simili), soluzione più economica pezzo per pezzo ma altrettanto frammentata, con il problema in più che il Pi non è mai stato pensato per controllo motori a bassa latenza.

Il vero valore della VENTUNO Q, se le premesse tengono, è l'integrazione: un solo firmware, un solo alimentatore, un solo pezzo di hardware da programmare con l'Arduino Core che già conosci, invece di dover far parlare tra loro due schede con protocolli diversi. Resta da vedere quanto sia solido in pratica il bridge tra il lato Linux e il lato Zephyr, perché è lì che di solito nascono i mal di testa in questo genere di architetture ibride: se la comunicazione tra i due processori introduce latenza o instabilità, tutto il vantaggio del controllo real-time va a farsi benedire.

## Prezzo, preordini e cosa c'è nella scatola

I preordini sono aperti a 299 dollari, e fino al 30 settembre Arduino ci mette dentro gratis anche alimentatore e cavo USB-C, che di solito sono voci che si pagano a parte su questo tipo di schede. Non c'è ancora una data di spedizione precisa nell'annuncio, quindi chi preordina oggi mette giù i soldi con un po' di fiducia, come capita spesso con l'hardware appena annunciato.

## Perché mi interessa

Non faccio robotica per lavoro, ma ho un paio di piccoli progetti con [motori e sensori](/posts/sensori-moduli-essenziali-per-progetti-arduino-esp32/) che gestisco con Arduino classico più un Raspberry Pi appoggiato accanto per la parte "intelligente", con tutto il fastidio di farli comunicare bene. Una scheda che mette i due mondi sotto lo stesso case, con lo stesso strumento di sviluppo, è il tipo di semplificazione che aspettavo da un pezzo. Non la comprerò al lancio, aspetto le prime recensioni vere su quanto sia stabile il bridge Linux-Zephyr e quanto siano maturi i modelli precaricati, ma la tengo d'occhio: se Arduino ha davvero risolto l'integrazione tra percezione AI e controllo real-time su una scheda sola, è un pezzo che cambia parecchio cosa si può montare in un weekend in garage.

Fonte: [Arduino Blog](https://blog.arduino.cc/2026/08/25/the-age-of-physical-ai-is-here-and-it-runs-on-the-arduino-ventuno-q-board/)
