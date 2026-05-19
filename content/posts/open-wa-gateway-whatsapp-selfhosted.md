---
title: "open-wa: un gateway WhatsApp self-hosted e open source"
date: 2026-05-19
draft: false

tags: ["whatsapp", "self-hosting", "docker", "automazione", "open-source", "api"]
categories: ["Linux", "Tech"]

description: "open-wa è un gateway HTTP per WhatsApp da installare in casa propria. Niente vendor lock-in, niente abbonamenti, dati che restano tuoi."

cover:
    image: "/images/open-wa.png"
    alt: "open-wa gateway WhatsApp self-hosted"
    caption: "open-wa: gateway WhatsApp open source da installare con Docker"
    relative: false
---

Se hai mai voluto mandare un messaggio WhatsApp da uno script, da Home Assistant o da un qualsiasi servizio self-hosted, sai già che le opzioni ufficiali sono poche e costose. WhatsApp Business API passa da provider certificati con prezzi che partono da decine di euro al mese, e i servizi intermedi non fanno meglio.

[open-wa](https://www.open-wa.org/) è una strada diversa: un gateway HTTP che gira in casa tua, espone una REST API, e ti permette di mandare e ricevere messaggi WhatsApp da qualsiasi cosa sappia fare una chiamata HTTP. È open source, licenza MIT, gratuito.

## Come funziona

Si installa sul proprio server — o su un container Docker, che è il modo più sensato — e si connette al proprio account WhatsApp. Una volta avviato espone due porte: la REST API su `2785` e una dashboard web su `2886`. Da lì in poi, mandare un messaggio è una chiamata POST.

Lo stack è Node.js 20, NestJS, TypeScript. Per lo storage supporta SQLite (per chi vuole tenerlo semplice) o PostgreSQL, con Redis per la cache. Multi-sessione, webhook in tempo reale, autenticazione via chiave API.

## Setup con Docker

Il modo più veloce per provarlo:

```bash
git clone https://github.com/open-wa/open-wa.git
cd open-wa
docker compose up -d
```

Dopo di che si apre la dashboard su `http://localhost:2886`, si esegue il collegamento con WhatsApp — di solito tramite QR code da scansionare con il telefono — e il gateway è operativo. L'API è documentata via Swagger su `http://localhost:2785/api/docs`.

Per chi ha già Proxmox in casa, un container LXC leggero è più che sufficiente per farlo girare stabilmente.

## Casi d'uso concreti

La cosa più immediata è usarlo come canale di notifiche. Home Assistant può chiamare un webhook, il gateway manda un messaggio WhatsApp. Stesso discorso per Grafana, per script di monitoraggio, per qualsiasi cosa generi un alert.

Più in generale: qualsiasi automazione che oggi usi email o Telegram perché WhatsApp non aveva un'API accessibile, ora ha un'alternativa praticabile.

## La questione ToS

Vale la pena dirlo chiaramente: questo tipo di integrazione non usa le API ufficiali di WhatsApp. Usa un client non ufficiale che simula l'app. WhatsApp vieta esplicitamente questo utilizzo nei propri termini di servizio, e in passato ha bannato account che usavano client alternativi.

Il rischio nella pratica dipende molto dall'uso: un account dedicato che manda qualche decina di notifiche al giorno ha un profilo di rischio diverso da uno che fa invii massivi. Ma il rischio esiste, e usare un account secondario — non quello principale — è una precauzione sensata.

Non è un problema nuovo: esiste da quando esistono i client WhatsApp non ufficiali. Chi ha già usato soluzioni simili sa già come si sta.

## Perché è interessante

I servizi commerciali equivalenti partono da 30-50€ al mese, con limiti di messaggi e dati che transitano su infrastrutture esterne. open-wa non costa nulla, gira su hardware che probabilmente hai già, e i messaggi non escono dalla tua rete finché non li mandi tu.

Per un uso domestico o di piccola automazione si tratta di un'ottima alternativa. La ToS è l'unica variabile seria da tenere in considerazione.
