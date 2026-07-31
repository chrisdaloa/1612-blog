---
title: "Come resettare le lampadine Philips Hue nel 2026"
date: 2026-07-31
draft: false
tags: ["philips-hue", "domotica", "zigbee", "tutorial"]
categories: ["Domotica"]
description: "Guida aggiornata al reset delle lampadine Philips Hue: da app con bridge, via Bluetooth senza bridge, con il Dimmer Switch e tramite hub di terze parti come Alexa o Google Home."
cover:
  image: "/images/posts/come-resettare-lampadine-philips-hue-2026.png"
---

{{< affiliate-disclosure >}}
Ho scritto un articolo su questo argomento otto anni fa, quando avevo appena messo in piedi il primo impianto Hue di casa. All'epoca l'unico modo pratico che conoscevo per resettare una lampadina era il [Dimmer Switch](https://www.amazon.it/dp/B08PKMT2DV?tag=16120s-21) o, in mancanza di bridge, l'Echo Plus con lo Zigbee integrato. Da allora Philips Hue (oggi il brand è di Signify, ma continuiamo tutti a chiamarlo Hue) ha cambiato parecchio: l'app è diversa, il bridge è diventato quasi un accessorio opzionale per chi vuole solo accendere e spegnere due luci, e il Bluetooth è entrato ufficialmente nel protocollo delle lampadine. Vale la pena riscrivere la guida da zero.

Il motivo per cui si resetta una lampadina Hue è quasi sempre uno di questi tre: l'hai comprata usata e risulta ancora agganciata all'account Hue di qualcun altro, hai cambiato bridge (magari sei passato dal vecchio bridge quadrato al modello rotondo attuale) oppure vuoi staccarla da un ecosistema per portarla su un altro, tipo Home Assistant con un coordinatore Zigbee dedicato.

## Metodo 1: dall'app Hue con il bridge (il più comune)

Se hai il [Bridge Hue](https://www.amazon.it/dp/B09CV9F3KR?tag=16120s-21) collegato, questa è la strada che uso quasi sempre. Apri l'app Hue, vai su **Impostazioni > Configurazione luci**, seleziona la lampadina interessata e cerca la voce per eliminarla o resettarla. Se la lampadina è già associata al tuo account e la vedi regolarmente nell'app, la rimozione è immediata: la elimini e torna disponibile per una nuova configurazione.

Il caso più interessante è quando la lampadina non è tua, tipo un bulbo comprato di seconda mano che risulta ancora agganciato a un altro bridge. In questo scenario, durante la ricerca di nuove luci, l'app la segnala come "già configurata" o irraggiungibile e ti propone un reset via Touchlink: devi avvicinare fisicamente la lampadina al bridge, a pochi centimetri di distanza, e confermare il reset dall'app. Il bridge invia un comando Zigbee diretto che azzera la configurazione di rete della lampadina, indipendentemente da dove fosse agganciata prima.

## Metodo 2: power cycle manuale (funziona quasi sempre, anche senza bridge)

Questo è il metodo che salva la giornata quando l'app non trova la lampadina o non hai un bridge a disposizione. Consiste nell'accendere e spegnere la lampadina dall'interruttore a muro (o dalla presa) diverse volte di seguito, con un ritmo abbastanza rapido, finché non la vedi lampeggiare in un modo diverso dal solito: quel lampeggio è la conferma che ha resettato la propria configurazione di rete Zigbee o Bluetooth e sta aspettando un nuovo abbinamento. Il numero esatto di cicli e i tempi possono variare leggermente tra i modelli, per cui conviene seguire la sequenza indicata nel manuale della lampadina o nell'app Hue quando propone questa opzione: di solito è nell'ordine di 5-6 accensioni ravvicinate.

È un metodo un po' rozzo ma affidabile, e funziona sia sui bulbi Zigbee classici sia su quelli con Bluetooth. L'unico requisito è avere un interruttore fisico che tagli davvero l'alimentazione: se la lampadina è su una linea sempre accesa e comandata solo via app, questa strada non è praticabile.

## Metodo 3: Bluetooth diretto, senza bridge

Dal 2018 in poi Philips ha aggiunto il Bluetooth a buona parte delle lampadine Hue, proprio per permettere un ingresso "leggero" nell'ecosistema: si compra una lampadina, si scarica l'app Hue, la si accoppia via Bluetooth e la si controlla direttamente dal telefono, senza bridge. È il modo in cui molte persone iniziano oggi, magari con un singolo bulbo comprato per prova.

Per resettare in questa modalità l'app non offre un vero e proprio comando di reset da remoto come con il bridge: la via più affidabile resta il power cycle manuale descritto sopra. Dopodiché puoi eliminare la lampadina "fantasma" dall'app (se compare ancora come irraggiungibile) e rifare l'accoppiamento Bluetooth da zero.

## Metodo 4: Dimmer Switch o Tap Dial Switch

Il Dimmer Switch Hue si può usare come "telecomando di reset" da tenere vicino alla lampadina, sfruttando lo stesso principio del Touchlink: tenendo l'interruttore molto vicino al bulbo (pochi centimetri) e premendo insieme una combinazione specifica di tasti per qualche secondo, la lampadina si resetta e torna disponibile per un nuovo abbinamento.

Qui vado volutamente sul vago sulla combinazione esatta di tasti perché Philips ha cambiato il layout dei suoi telecomandi negli anni: il vecchio Dimmer Switch a quattro tasti (On, +, -, Off) non è identico al [Tap Dial Switch](https://www.amazon.it/dp/B0B2PSDNV1?tag=16120s-21) più recente, e la sequenza corretta è indicata nel manualetto che accompagna ogni switch o nella sezione di aiuto dell'app Hue quando avvii la procedura di reset assistito. Se hai ancora la confezione, controlla lì prima di tentare a memoria: sbagliare combinazione non rompe nulla, semplicemente non succede niente.

## Metodo 5: hub di terze parti (Alexa/Echo Plus, Google Home, SmartThings)

Se non hai un bridge Hue dedicato ma controlli le lampadine tramite un hub con Zigbee integrato, come un Echo con hub Zigbee built-in, uno smart speaker Google con supporto Matter, o un hub SmartThings, la procedura cambia leggermente. Questi hub in genere non hanno un comando di "reset" vero e proprio per il bulbo: rimuovi il dispositivo dall'app dell'hub (Alexa, Google Home, SmartThings), poi esegui comunque il power cycle manuale sulla lampadina per staccarla davvero dalla vecchia rete Zigbee, e infine avvii una nuova ricerca dispositivi dall'app dell'hub.

Lo stesso discorso vale se stai portando la lampadina su Home Assistant con un coordinatore Zigbee dedicato (Zigbee2MQTT o ZHA, per dire): prima il reset fisico del bulbo, poi l'inclusione nella nuova rete.

## Qual è il metodo giusto per te

Se hai un Bridge Hue, usa sempre prima l'app: è il metodo più pulito e, quando riconosce la lampadina come "già vista altrove", ti risolve il reset in automatico senza dover contare lampeggi. Se non hai il bridge o l'app non trova nulla, il power cycle manuale è la rete di sicurezza che funziona quasi sempre, a costo di essere un po' meno elegante.

Il Dimmer Switch lo trovo comodo soprattutto per chi installa Hue in casa di altri (parenti, amici) e non vuole portarsi dietro il bridge solo per fare un reset al volo. Per tutto il resto, tra configurazioni miste con Home Assistant o hub di terze parti, il power cycle resta l'unica cosa che funziona sempre, indipendentemente da app e account.

Una nota finale su un dettaglio che spesso si dimentica: se hai comprato una lampadina Hue usata e il precedente proprietario l'aveva collegata anche ad Apple HomeKit, il codice di abbinamento HomeKit è legato alla lampadina fisica e a volte resta "sporco" anche dopo un reset Zigbee completo. In quel caso, oltre al reset standard, potrebbe servire rimuovere manualmente l'accessorio anche dall'app Casa di Apple prima di riprovare l'abbinamento.

---

*L'articolo originale su questo argomento, scritto nel 2018 su questo blog, copriva solo il reset via Dimmer Switch ed Echo Plus. Questa versione aggiorna la guida allo scenario attuale, con bridge e app Hue come metodo principale.*
