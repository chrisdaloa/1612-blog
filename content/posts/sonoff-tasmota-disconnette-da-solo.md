---
title: "Sonoff Tasmota: risolvere il comportamento anomalo alla riconnessione MQTT"
date: 2019-01-04
draft: false
tags: ["sonoff", "tasmota", "mqtt", "home-assistant", "mosquitto", "domotica"]
categories: ["Domotica"]
description: "Se il tuo Sonoff con firmware Tasmota si comporta in modo anomalo dopo una riconnessione MQTT, la causa è quasi sempre il RETAIN. Ecco come risolverlo."
cover:
    image: "/images/sonoff-tasmota-mqtt.png"
    alt: "Sonoff Tasmota MQTT retain"
    caption: "Come risolvere il comportamento anomalo alla riconnessione MQTT con Sonoff e Tasmota"
    relative: false
aliases:
    - /wp/sonoff-tasmota-connessione-attiva-da-solo/

---

Se avete un dispositivo Sonoff flashato con il firmware Tasmota, vi sarà probabilmente capitato di notare un comportamento anomalo dopo una riconnessione alla rete Wi-Fi o al server MQTT. Nel mio caso, il Sonoff collegato alla stampante 3D si accendeva ad ogni perdita e riacquisizione della connessione.

Per risolvere il problema bisogna prima capirne la causa.

## La causa: il RETAIN di MQTT

Il problema è quasi sempre causato dal **RETAIN**, un'opzione configurabile sui topic MQTT che permette al broker di memorizzare l'ultimo stato di un topic e di reinviarlo al device nel momento in cui si riconnette. Probabilmente durante le prime configurazioni di prova è stato attivato un topic che è rimasto memorizzato nel broker.

Se vogliamo che alla riconnessione del Sonoff non venga eseguita nessuna operazione (cioè che il dispositivo mantenga lo stato attuale), è necessario:

1. Impostare `retain: false` nella configurazione
2. Cancellare i topic retain già memorizzati nel broker MQTT

Vediamo come fare in entrambi i casi: **via terminale** (per chi ha Hassbian + Mosquitto) e **via client grafico** (per chi ha HASSIO con MQTT embedded).

---

## Metodo 1 – Via terminale (Hassbian + Mosquitto)

### Passo 1 – Imposta retain: false su Home Assistant

Per prima cosa riconfigura gli switch MQTT su Home Assistant impostando `retain: false`.

[IMMAGINE – Screenshot configurazione retain: false in Home Assistant]

### Passo 2 – Visualizza i topic attivi

Accedi via terminale al Raspberry e digita il comando seguente per visualizzare tutti i topic Tasmota attivi:

```bash
sudo mosquitto_sub -t stat/# -t tele/# -t cmnd/#  -v -u iltuoutente -P latuapassword
```

Il risultato sarà qualcosa di simile a questo:

[IMMAGINE – Screenshot output mosquitto_sub con topic attivi]

Il topic da eliminare è quello che inizia per `cmnd`, ovvero il comando che arriva da Home Assistant per accendere/spegnere il dispositivo.

### Passo 3 – Cancella il topic incriminato

Una volta trovato il topic, puoi cancellarlo inviando un payload vuoto con questo comando:

```bash
sudo mosquitto_pub -t cmnd/stampante3d/POWER -r -n -u iltuoutente -P latuapassword
```

Le opzioni del comando:

- `-r` — assegna il RETAIN al topic
- `-n` — passa un payload `null` (vuoto)
- `-u` — nome utente di Mosquitto
- `-P` — password di Mosquitto

> Se non hai impostato utente e password in Mosquitto, puoi omettere `-u` e `-P`.

### Passo 4 – Verifica

Ripeti il comando di sottoscrizione per verificare che il topic `cmnd` non sia più presente:

```bash
sudo mosquitto_sub -t stat/# -t tele/# -t cmnd/#  -v -u iltuoutente -P latuapassword
```

[IMMAGINE – Screenshot output mosquitto_sub senza topic cmnd]

Se provi ora a far perdere la connessione al Sonoff, alla riconnessione non verrà eseguita nessuna operazione.

---

## Metodo 2 – Via MQTT Lens (HASSIO con MQTT embedded)

Chi ha HASSIO con il broker MQTT embedded e non ha accesso al terminale del Raspberry non può usare i comandi di Mosquitto. In questo caso è possibile cancellare i topic tramite un client MQTT grafico.

Io ho usato **MQTT Lens**, un'app per Chrome disponibile sul [Chrome Web Store](https://chrome.google.com/webstore/detail/mqttlens/hemojaaeigabkbcookmlgmdigohjobjm?hl=it).

### Passo 1 – Configura la connessione

Installa MQTT Lens, clicca sul "+" accanto a CONNECTIONS e configura la connessione al tuo broker MQTT.

[IMMAGINE – Screenshot configurazione connessione in MQTT Lens]

### Passo 2 – Sottoscrivi il topic cmnd/#

Effettua la sottoscrizione al topic `cmnd/#`.

[IMMAGINE – Screenshot sottoscrizione topic cmnd/# in MQTT Lens]

In basso verranno visualizzati tutti i topic `cmnd` attivi nel tuo broker MQTT.

[IMMAGINE – Screenshot lista topic cmnd attivi]

### Passo 3 – Cancella i topic

Cancellali uno per uno inviando un payload vuoto (null) e selezionando la casella **retain**.

[IMMAGINE – Screenshot invio payload null con retain selezionato]

### Passo 4 – Verifica

Ripeti la sottoscrizione al topic `cmnd/#`. I topic cancellati non dovrebbero più comparire.

[IMMAGINE – Screenshot verifica topic rimossi]

---

## Conclusioni

I topic `cmnd/#` memorizzati con il RETAIN attivo vengono richiamati ad ogni riconnessione del Tasmota, causando operazioni indesiderate. Cancellarli e impostare `retain: false` risolve definitivamente il problema.

Se usi altri software come Node-RED o dashboard MQTT per inviare comandi al Sonoff, assicurati che anche lì il retain sia impostato su `false`.

---

*Hai trovato utile questa guida? Condividila con altri appassionati di domotica!* 🚀