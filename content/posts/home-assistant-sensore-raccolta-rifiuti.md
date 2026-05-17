---
title: "Home Assistant: un sensore per ricordarti quale bidone mettere fuori"
date: 2019-05-01
draft: false
tags: ["home-assistant", "domotica", "template", "lovelace", "rifiuti"]
categories: ["Domotica"]
description: "Come creare un sensore template in Home Assistant per ricordare quale tipologia di rifiuti raccogliere ogni giorno, senza installare componenti custom."
cover:
    image: "/images/sensore_rifiuti.png"
    alt: "Sensore rifiuti Home Assistant"
    caption: "Un sensore template per non dimenticare mai quale bidone mettere fuori"
    relative: false
aliases:
    - /wp/home-assistant-sensore-raccolta-rifiuti/
---

Con il mio amico Carlo ci siamo chiesti come poteva Home Assistant aiutarci a ricordare quale tipologia di rifiuti è in raccolta — fondamentalmente quale bidone dobbiamo preparare. Abbiamo scelto di sfruttare quello che Home Assistant mette già a disposizione, senza installare componenti custom.

Il risultato finale è questo:

[IMMAGINE – Screenshot della card rifiuti in Home Assistant]

Le cose da fare sono solo 3:

1. Creare un'immagine per ogni tipologia di rifiuto (bidone giallo per la plastica, nero per l'indifferenziata, ecc.)
2. Creare un sensore **template** che restituisce il tipo di raccolta in base al giorno della settimana
3. Creare una card in Lovelace che mostra l'immagine corrispondente

---

## Passo 1 – Le immagini

Le immagini che abbiamo creato le trovate [qui](/downloads/rifiuti.zip). Scaricate lo zip, estraete il contenuto e copiate la cartella `rifiuti` nella cartella `www` della vostra installazione di Home Assistant:

```
\\indirizzo_ip_raspberry\homeassistant\www\rifiuti
```

Se vi manca qualche colore o combinazione, lasciate un commento qui sotto e la aggiungiamo.

---

## Passo 2 – Il sensore template

Aggiungete questo blocco nella sezione `sensor:` del file `configuration.yaml`:

```yaml
sensor:
  - platform: template
    sensors:
      rifiuti:
        friendly_name: "Rifiuti"
        icon_template: mdi:delete-restore
        value_template: "
        {% if (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '1' %} Indifferenziato
        {% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '2' %} Plastica e umido
        {% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '3' %} Indifferenziato
        {% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '4' %} Umido
        {% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '5' %} Umido
        {% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '6' %} Niente
        {% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '0' %} Carta e umido
        {% endif %}
        "
        entity_id: sensor.date_time
```

---

## Passo 3 – La card Lovelace

Aggiungete questa card nel file `ui-lovelace.yaml`, rispettando l'indentatura:

```yaml
- type: picture-entity
  entity: sensor.rifiuti
  name: "Rifiuti da mettere fuori"
  aspect_ratio: 16x10
  tap_action: none
  state_image:
    "Niente": /local/rifiuti/niente.svg
    "Plastica e umido": /local/rifiuti/giallomarrone.svg
    "Indifferenziato": /local/rifiuti/nero.svg
    "Carta e umido": /local/rifiuti/biancomarrone.svg
    "Umido": /local/rifiuti/marrone.svg
```

---

## Come funziona il sensore

Tutto ruota attorno a questa riga del `value_template`:

```
(now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '1'
```

Vediamola pezzo per pezzo.

**Leggiamo l'orario attuale in secondi:**
```
now().timestamp()
```

**Sottraiamo 11 ore (in secondi):**
```
int - (11*60*60)
```

Questo fa "scattare" il sensore al giorno successivo alle ore 11:00 del mattino. Nel mio caso il ritiro dei rifiuti avviene tra le 06:00 e le 11:00, quindi il sensore mi indica cosa preparare dalla sera prima (dalle 11:01 del giorno precedente) fino al momento del ritiro (alle 10:59 del giorno del conferimento).

**Convertiamo in numero del giorno della settimana:**
```
timestamp_custom('%w')
```

Dove `0` = domenica, `1` = lunedì, e così via fino a `6` = sabato.

L'ultima parola di ogni istruzione (`Indifferenziato`, `Plastica e umido`, ecc.) è il valore che viene visualizzato nella UI e che determina quale immagine mostrare.

**L'ultima riga del sensore:**
```yaml
entity_id: sensor.date_time
```

Indica al sensore di aggiornarsi ad ogni cambio di orario, seguendo il sensore `date_time` di Home Assistant.

---

## Come funziona la card

Nello `state_image` stiamo dicendo alla card quale immagine mostrare in base allo stato del sensore:

```yaml
state_image:
  "Niente": /local/rifiuti/niente.svg
  "Plastica e umido": /local/rifiuti/giallomarrone.svg
  "Indifferenziato": /local/rifiuti/nero.svg
  "Carta e umido": /local/rifiuti/biancomarrone.svg
  "Umido": /local/rifiuti/marrone.svg
```

Ogni valore del sensore corrisponde a un file SVG nella cartella `rifiuti` che avete copiato nel passo 1.

---

## Personalizzazione

Per adattare il sensore al calendario di raccolta della vostra città è sufficiente modificare il valore testuale alla fine di ogni riga `{% if %}` e `{% elif %}`, abbinandolo al giorno della settimana corrispondente. Ricordatevi poi di aggiornare anche lo `state_image` nella card con gli stessi valori.

---

*Hai trovato utile questa guida? Condividila con altri appassionati di domotica!* 🚀