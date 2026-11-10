---
title: "Zyxel GS1900: zero-day sfruttato su quasi 1.000 switch, e la prima patch non bastava"
date: 2026-11-06
draft: false
tags: ["sicurezza", "homelab", "networking"]
categories: ["Sicurezza"]
description: "Zyxel ha corretto uno zero-day sugli switch GS1900, usato su 996 dispositivi. La patch di giugno non bastava: serve il firmware del 22 ottobre."
cover:
  image: "/images/posts/zyxel-gs1900-zero-day-switch-patch.png"
  alt: "Switch di rete Zyxel GS1900 in un rack con porte Ethernet illuminate"
---

Se hai uno switch Zyxel della serie GS1900, anche già aggiornato questa estate, probabilmente il firmware che hai non basta. C'è una falla nell'interfaccia web che permette a chi raggiunge lo switch in rete di eseguire comandi senza login, ed è stata usata per rubare file di configurazione e credenziali. Serve il firmware rilasciato il 22 ottobre, e conviene anche togliere la gestione web da qualunque rete non fidata. Sotto il dettaglio per chi vuole capire come si è arrivati qui.

## Cosa è successo

Secondo BleepingComputer, la vulnerabilità è tracciata come CVE-2026-107441. È un out-of-bounds write nell'interfaccia di gestione web degli switch GS1900: un attaccante non autenticato, con accesso di rete al dispositivo, manda richieste HTTP costruite apposta e ottiene esecuzione di comandi sul sistema operativo. Colpisce dieci modelli della serie.

La parte interessante è la cronologia, perché è un po' un pasticcio.

- 16 giugno: Zyxel rilascia patch per CVE-2026-7273, un buffer overflow pre-autenticazione sugli stessi switch.
- Dal 17 agosto circa: GreyNoise osserva un gruppo sospettato di lingua cinese, tracciato come Kapibala, che attacca switch Zyxel. Il bilancio finale è 996 dispositivi compromessi in 48 paesi.
- 21 settembre: GreyNoise rende pubblica la campagna e la attribuisce a CVE-2026-7273. Lo stesso giorno CISA aggiunge quel CVE al catalogo KEV delle vulnerabilità sfruttate.
- 28 settembre: i ricercatori di Binarly, partendo dall'infrastruttura legata al backdoor JITTERLY e al rootkit SIXZUT, trovano un archivio esposto con un exploit Python offuscato. L'exploit controlla proprio che il firmware sia quello già patchato per CVE-2026-7273, e funziona su tutte e dieci le release corrette.
- 29 settembre: Binarly avvisa Zyxel. L'11 ottobre il vendor conferma il nuovo bug.
- 22 ottobre: arrivano i firmware nuovi, advisory pubblicato il 3 novembre.

In pratica chi ha seguito le indicazioni di settembre, "ho installato la patch di giugno, sono a posto", era ancora esposto. La correzione del 22 ottobre limita la dimensione dei parametri HTTP e controlla il loro numero prima di copiare i dati in memoria.

Una precisazione onesta: dalla fonte non è chiaro se l'exploit sia stato sviluppato apposta per aggirare la patch di giugno o se sfrutti un bug imparentato che quella patch non copriva. Zyxel lo classifica come falla separata, perché abusa della mancata validazione della lunghezza dei parametri HTTP. Per chi ha lo switch in casa, la distinzione conta poco. Il firmware vecchio è bucato in entrambi i casi.

## Perché riguarda chi ha un homelab

Gli switch GS1900 sono tra gli smart switch economici più diffusi: otto, sedici, ventiquattro porte, VLAN, un po' di gestione web, prezzo basso. Esattamente il tipo di apparecchio che finisce in un rack casalingo e che poi nessuno aggiorna più, perché "fa solo da switch".

Qui il problema è doppio. Lo switch vede tutto il traffico che ci passa, quindi comprometterlo significa un ottimo punto di appoggio dentro la rete. E il bottino degli attaccanti qui erano proprio configurazioni e credenziali, che spesso vengono riusate altrove. Non è la prima volta che l'hardware di rete di un homelab finisce nel mirino: ne avevamo parlato con le [falle critiche di RouterOS su MikroTik](/posts/mikrotrick-falle-critiche-routeros-mikrotik/) e con le [vulnerabilità di UniFi OS](/posts/ubiquiti-vulnerabilita-critiche-unifi-os/).

Il rischio concreto dipende da quanto è raggiungibile la pagina di gestione. Se è esposta su internet, per esempio con un port forward lasciato aperto anni fa, sei il bersaglio più facile. Se è solo sulla LAN, serve prima un altro punto d'ingresso, ma la VLAN di gestione con dentro tutto, dai telefoni agli IoT cinesi, non è una grande barriera.

## Cosa fare

1. Identifica il modello esatto e la versione del firmware installata. Guarda l'advisory Zyxel per la tua revisione hardware e scarica la release uscita il 22 ottobre o successiva.
2. Aggiorna. Se lo switch è in produzione, fai prima un backup della configurazione e pianifica il riavvio.
3. Verifica che la gestione web non sia raggiungibile da internet. Un controllo veloce da fuori casa, o una scansione della tua IP pubblica, ti dice se c'è qualcosa in ascolto.
4. Sposta l'interfaccia di gestione su una VLAN dedicata, raggiungibile solo dal tuo PC o da una VPN. Con gli smart switch di questa fascia si può fare, e conviene.
5. Se avevi lo switch esposto o non aggiornato da agosto, cambia le password che stavano nella configurazione e controlla che non ci siano account o regole che non riconosci.

## La mia opinione

Il bug in sé mi preoccupa poco, sono cose che capitano. Mi lascia perplesso come è andata la catena degli avvisi. Per settimane il mondo ha creduto che la patch di giugno bastasse, CISA compresa, e nel frattempo l'exploit girava su firmware "aggiornati". È un buon promemoria: "ho patchato" è vero solo finché non esce un'altra analisi. E per gli switch economici, che non hanno un sistema di avvisi decente, la verifica la devi fare tu, a mano, ogni tanto.

Fonte: [BleepingComputer](https://www.bleepingcomputer.com/news/security/zyxel-fixes-zero-day-exploited-to-hack-nearly-1-000-network-switches/), con i dettagli della ricerca di Binarly e della campagna osservata da GreyNoise.
