---
title: "Riscaldatore DIY per stampanti a resina"
date: 2024-01-15  # Usa la data originale
draft: false
tags: ["stampa-3d", "tutorial"]  # I tag originali
categories: ["Stampa 3D"]  # La categoria originale
description: "Guida completa per costruire un riscaldatore DIY per stampanti a resina. Schema collegamenti, lista materiali e configurazione termostato per stampare a temperature ottimali."
---
Oggi voglio presentarvi questo progetto che ho trovato in rete e che ho realizzato per la mia stampante a resina [Voxelab Proxima 6.0](https://amzn.to/3oeusZs)

A causa dell'odore della resina, ho preferito mettere la stampante in un garage, dove però in questo periodo (novembre) ci sono circa 10° mentre la resina necessità di una temperatura di 25-30° per essere stampata.

Come potete vedere da questa immagine, in garage ho 12° mentre all'interno della cupola della stampante la temperatura è intorno ai 28°.

![Alt text](/images/PXL_20211128_231435379.jpg)

La realizzazione è abbastanza semplice, servono il box stampato (qualcuno lo stampa in resina, io ho stampato in PETG, forse l'ABS sarebbe ideale), un riscaldatore da 12V e 100W e un termostato con sonda che permetta di mantenere la temperatura.

# Cosa serve
Potete prendere un riscaldatore 12V e 100W come questo in foto da [Amazon](https://amzn.to/3ofZErr) o da [Aliexpress](https://s.click.aliexpress.com/e/_9A7WUi)

![Alt text](/images/61WCcFX8LsL._AC_SL1001_.jpg)

Un termostato 12V W1209WK regolabile con sonda esterna e interruttore come questo in foto da [Amazon](https://amzn.to/3G8u2tO) o [Aliexpress](https://s.click.aliexpress.com/e/_ATUyQO)

![Alt text](/images/71iu6hZFR-S._AC_SL1500_-1024x1024.jpg)

I files STL da stampare scaricabili da [Thingiverse](https://www.thingiverse.com/thing:3442165)

Un alimentatore 12V e 10A da [Amazon](https://amzn.to/2ZKbwsb) o [Aliexpress](https://s.click.aliexpress.com/e/_AtjRMA)


![Alt text](/images/71FRWXcGyFL._AC_SL1200_.jpg)

Connettori maschio/femmina per l'alimentazione da [Amazon](https://amzn.to/3EbKKIh) o [Aliexpress](https://s.click.aliexpress.com/e/_AcYxNs) (io non li ho usati, ho collegato con i capicorda)
![Alt text](/images/61-9PT-wCRL._AC_SL1500_-1024x810.jpg)

# Assemblaggio
L'assemblaggio è relativamente semplice:
1. nel primo connettore del termostato va il cavo positivo (rosso) dell'alimentatore
2. nel secondo e terzo connettore del termostato va il negativo dell'alimentatore, io ho ponticellato con un cavo, non fate l'errore di usare un puntalino a U perchè sfregando sul connettore alla lunga lo scioglie.
3. nel quarto connettore va uno dei due cavi del riscladatore (è una resistenza quindi non ha positivo e negativo), l'altro cavo del riscaldatore va insieme al positivo dell'alimentatore
4. i due cavi della ventola vanno collegati all'alimentatore in modo che la ventola sia sempre accesa
5. quando montate la vendola sul box, ricordatevi che il lato con l'adesivo va verso il riscaldatore, in pratica una volta montato voi vedete il lato senza adesivo della ventol

Mi raccomando, fate attenzione ai collegamenti, devono essere ben serrati e non "ballare".
![Alt text](/images/image-1024x481-1.png" alt="" class="wp-image-476)

# Configurazione termostato
Una volta effettuati i collegamenti possiamo passare alla configurazione del termostato.  
Come prima cosa impostate i gradi Celsius o Fahrenheit premendo il pulsante basso del termostato °C/°F.  
Quindi dobbiamo calibrare la temperatura usando come riferimento un normale termometro:

1. Leggete la temperatura sul normale termometro, la chiameremo T12. Leggete la temperatura sul termostato (il valore più alto), la chiameremo T23. Ora fate T2 - T1 e otteniamo T3, memorizzatevi questo valore
2. Tenete premuto il pulsante SET del termostato per entrare in modalità programmazione fino a quando sentite un BEEP e vedete comparire P0 sul display (tente a mente questa procedura perchè dovremmo ripeterla per entrare in modalità programmazione)
3. Premete SET di seguito finchè sul display non compare P4, quindi premete contemporaneamente entrambi i pulsanti del termostato, inizierà a lampeggiare il secondo valore del termostato. Attenzione: quando siete in modalità programmazione nel termostato, se non fate niente per 5 secondi la modalità torna normale e dovete ripetere i passaggi.
4. Premendo i due tasti del termostato impostate il secondo valore del display con la temperatura T3 che avete memorizzato prima
5. Rientrate in modalità programmazione tenendo premuto SET, quando compare P0 premete SET 2 volte fino ad arrivare a P2, quindi premete entrambi i pulsanti contemporaneamente e impostate la temperatura di sicurezza oltre il quale il termostato non riscalderà, io nel mio ho messo 37. Aspettate 5 secondi per uscire dalla modalità programmazione.
6. Rientrate in modalità programmazione tenendo premuto SET, quando compare P0 premete SET 1 volte fino ad arrivare a P1, questo indicherà la differenza tra valore impostato e valore reale che farà attivare o meno il riscaldatore, di default è impostato a 2, io ho impostato 1. Solita procedura, premete entrambi i pulsanti contemporaneamente per poter modificare il valore. Attendete 5 secondi per uscire dalla modalità programmazione.
7. Rientrate in modalità programmazione tenendo premuto SET, premete una volta SET per arrivare a P1, premete entrambi i pulsanti e imposate il valore su H per far funzionare il termostato come un riscaldatore (su C funziona come un raffreddatore). Attendete 5 secondi per uscire dalla modalità di programmazione.

A questo punto il vostro riscaldatore è pronto e dovete solo trovare il modo di adattarlo alla vostra stampante. Se siete fortunati potete usare delle calamite da 5mm di diametro altimenti dovete trovare un supporto per la vostra stampante (io ho il supporto per la Proxima se vi serve chiedetelo nei commenti, a breve sarà su Thingiverse) o ingegnarvi un pochettino.

Personalmente sto usando questo riscaldatore da un mese e non ho avuto grossi problemi, sono arrivato a lasciarlo acceso 12h. La temperatura della cupola sul lato dove è più vicina al riscaldatore non supera i 55°. Prima del PETG ho provato il PLA e ha resistito bene, sono passato al PETG per sicurezza. 
![Alt text](/images/PXL_20211129_195206812-1024x834.jpg)

# Piccoli accorgimenti
1. Vi consiglio comunque prima di inserirlo nella stampante, di lasciarlo accesso diverse ore in un posto "sicuro" in modo da verificare che tutto funzioni a dovere.
2. Dopo aver inserito la resina nella VAT, accendete il riscaldatore, mettete la cupola e lasciate riscaldare per circa 30 minuti
3. Trovate la vostra temperatura migliore in base alle specifiche della resina, qualcuno consiglia in questi casi di stare 3-4° più alto.

Infine vi lascio un video (non mio) dove potete vedere il montaggio e la calibrazione

## Links al materiale che ho utilizzato
Riscaldatore - PTC Heater 12V 100W. [Aliexpress](https://s.click.aliexpress.com/e/_9A7WUi) [Amazon](https://amzn.to/3ofZErr)
Termostato W1209WK 12V con sonda e interruttore [Aliexpress](https://s.click.aliexpress.com/e/_ATUyQO) [Amazon](https://amzn.to/3G8u2tO)  
Alimentatore 12V 10A - [Aliexpress](https://s.click.aliexpress.com/e/_AtjRMA) - [Amazon](https://amzn.to/2ZKbwsb") (in genere conviene su Amazon)  
Connettori maschio/femmina 12V - [Aliexpress](https://s.click.aliexpress.com/e/_AcYxNs) - [Amazon](https://amzn.to/3EbKKIh) (io non li ho utilizzati)  
Calamite 5x2mm [Aliexpress](https://s.click.aliexpress.com/e/_9AAzm2) - [Amazon](https://amzn.to/3DhD5ab)(se avete la struttura in metallo, sulla mia di alluminio non attaccano)  

Files STL su [Thingiverse](https://www.thingiverse.com/thing:3442165)

Se avete trovato questa pagina utile commentate e condividete.
