---
title: "Notifica Telegram su tentativo di login fallito in Home Assistant"
date: 2026-07-31
draft: false
tags: ["home-assistant", "domotica", "sicurezza", "tutorial"]
categories: ["Domotica"]
description: "Come impostare un'automazione in Home Assistant che avvisa su Telegram ad ogni tentativo di login fallito, utile per chi espone l'istanza su internet via Nabu Casa, reverse proxy o port forwarding."
cover:
  image: "/images/posts/notifica-telegram-login-fallito-home-assistant.png"
---

Sei anni fa avevo scritto un post veloce su questo argomento: un'automazione striminzita che ascoltava l'entity `persistent_notification.http_login` e mandava un messaggio Telegram con un link a una paginetta del mio vecchio sito dove mostravo i dettagli dell'IP. Quella pagina non esiste più da tempo, l'integrazione Telegram di Home Assistant nel frattempo è cambiata, e il vecchio articolo dava per scontate un sacco di cose (tipo che tu abbia già un bot Telegram funzionante). Riscrivo tutto da zero, aggiornato a come funziona oggi.

Il motivo per cui vale la pena impostarla è semplice: se esponi Home Assistant su internet, prima o poi qualcuno prova a entrarci. Non serve essere un bersaglio interessante, basta girare le porte giuste con Shodan. Che tu ci arrivi tramite Nabu Casa, un reverse proxy come Nginx Proxy Manager o Caddy, o un port forwarding diretto sul router, sapere in tempo reale che qualcuno sta provando password a caso è il minimo sindacale.

## Prima cosa: il bot Telegram

Se hai già un bot Telegram configurato su Home Assistant, salta questa parte. Se no, i passaggi sono sempre gli stessi:

1. Apri una chat con **@BotFather** su Telegram, digita `/newbot` e segui le istruzioni. Alla fine ti dà un token API, tienilo da parte.
2. Recupera il tuo `chat_id`: il modo più rapido è scrivere un messaggio al tuo bot appena creato e poi chiamare l'endpoint `https://api.telegram.org/bot<TOKEN>/getUpdates` da browser, oppure usare un bot di supporto come **@userinfobot** che ti restituisce direttamente il tuo ID numerico.
3. In `configuration.yaml` configura l'integrazione **Telegram Bot**:

```yaml
telegram_bot:
  - platform: polling
    api_key: "IL_TUO_TOKEN"
    allowed_chat_ids:
      - 123456789
```

L'integrazione Telegram Bot non ha (ancora, almeno alla data in cui scrivo) un vero config flow da interfaccia grafica come tante altre integrazioni recenti, quindi resta configurazione YAML. Se nella tua versione trovi invece la voce in **Impostazioni > Dispositivi e servizi**, usa pure quella: il risultato è lo stesso, cambia solo dove metti i parametri.

Dopo il riavvio hai a disposizione l'azione `telegram_bot.send_message`, che è quella che useremo nell'automazione (più flessibile del vecchio `notify.telegram`, perché ti dà accesso a parametri come `parse_mode` o `disable_notification` senza passare per l'astrazione generica di `notify`).

## L'automazione: ascoltare i tentativi falliti

Home Assistant, nel componente HTTP, tiene traccia dei tentativi di login e (quando l'IP ban è attivo) genera un evento a ogni tentativo fallito. Il nome storico di questo evento è `login_attempt_failed`, con dentro `username`, `ip_address` e `user_agent` nel payload. È lo stesso meccanismo che alimenta il ban automatico degli IP, quindi è affidabile ed esiste da parecchie versioni di HA.

Un consiglio pratico prima di scrivere qualsiasi automazione che si basa su un evento poco documentato: vai in **Impostazioni > Dispositivi e servizi > Strumenti per sviluppatori > Eventi**, sottoscrivi `login_attempt_failed` (o anche solo `*` per un minuto se vuoi essere sicuro del nome esatto sulla tua versione) e prova a sbagliare una password di proposito in un'altra scheda. Vedrai subito se e come arriva l'evento, e con quali campi. Due minuti persi che ti evitano un'automazione che sembra funzionare ma in realtà non scatta mai.

Fatta questa verifica, l'automazione è breve:

```yaml
automation:
  - alias: "Notifica login fallito su Home Assistant"
    triggers:
      - trigger: event
        event_type: login_attempt_failed
    actions:
      - action: telegram_bot.send_message
        data:
          message: >
            Tentativo di accesso fallito a Home Assistant

            Utente: {{ trigger.event.data.username }}
            IP: {{ trigger.event.data.ip_address }}
            User agent: {{ trigger.event.data.user_agent }}
            Orario: {{ now().strftime('%d/%m/%Y %H:%M:%S') }}
```

(Se hai una versione di HA più vecchia o preferisci la sintassi storica, `trigger:` al posto di `triggers:` e `service:` al posto di `action:` funzionano ancora esattamente allo stesso modo: HA ha solo rinominato le chiavi per allinearle al lessico "azioni" usato ormai anche nell'interfaccia, ma la retrocompatibilità c'è.)

Qui sta la differenza vera rispetto al 2020: invece di rimandare a una pagina esterna per vedere i dettagli, li metto direttamente nel messaggio. IP, user agent e orario ti bastano quasi sempre per capire se sei stato tu che hai sbagliato password dal telefono con connessione dati (IP che riconosci, user agent del tuo browser) o se è un bot che sta tentando credenziali a caso da un IP a caso con uno user agent generico tipo `python-requests` o simili.

Se preferisci un approccio meno legato a un evento specifico (nel caso sparisse o cambiasse nome in una versione futura), l'alternativa più robusta è ascoltare lo stato dell'entity `persistent_notification.http_login`, che Home Assistant crea quando rileva un tentativo fallito, e fare parsing del testo della notifica dentro un template. È il meccanismo su cui si basava il post originale del 2020, funziona ancora, ma è più fragile: il contenuto è pensato per essere letto da un umano nell'interfaccia, non per essere estratto in modo affidabile da un'automazione. Io preferisco l'evento perché arriva già strutturato in campi, senza dover fare regex sul testo di una frase italiana o inglese a seconda della lingua configurata.

## Un passo oltre: bloccare, non solo notificare

La notifica è un buon primo livello, ma se hai accesso diretto al sistema operativo (Docker, VM, Raspberry con installazione classica) puoi fare un passo in più. Nel blocco `http:` di `configuration.yaml` puoi attivare il ban automatico degli IP:

```yaml
http:
  ip_ban_enabled: true
  login_attempts_threshold: 5
```

Dopo il numero di tentativi falliti configurato, Home Assistant banna l'IP da solo e lo salva in `ip_bans.yaml`. È un blocco a livello applicativo, quindi funziona indipendentemente da come esponi l'istanza. Se invece hai accesso alla macchina che fa da reverse proxy (Nginx, Caddy, Traefik) e vuoi un blocco a livello di rete più aggressivo, **fail2ban** con una jail personalizzata che legge i log di accesso HTTP resta la strada più solida: banna a livello di firewall, prima ancora che il pacchetto arrivi a Home Assistant.

Chi usa **Nabu Casa** ha già un livello di protezione in più perché il traffico passa dal loro Cloudflare prima di arrivare a casa, ma questo non significa che i tentativi di login smettano di arrivare: semplicemente arrivano tramite il tunnel Nabu Casa invece che dal tuo IP pubblico diretto. L'automazione Telegram funziona identica in entrambi gli scenari, perché lavora a livello di autenticazione di Home Assistant, non di trasporto.

## Cosa uso io

Sulla mia istanza tengo entrambe le cose attive: notifica Telegram per sapere subito quando succede qualcosa, e `ip_ban_enabled` per non dover fare niente manualmente quando è chiaramente un bot e non un errore mio di battitura. La notifica da sola, senza ban, ti dà solo ansia dopo il terzo tentativo random della giornata. Il ban da solo, senza notifica, ti nasconde un problema più serio se qualcuno sta insistendo parecchio con un dizionario di password: in quel caso vale la pena guardare se l'esposizione che hai scelto (porta diretta vs reverse proxy vs Nabu Casa) è ancora quella giusta per te.
