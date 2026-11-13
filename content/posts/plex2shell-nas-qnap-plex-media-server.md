---
title: "Plex2Shell: NAS QNAP violati tramite Plex Media Server, come controllare e rimediare"
date: 2026-11-13
draft: false
tags: ["sicurezza", "homelab", "self-hosting"]
categories: ["Sicurezza"]
description: "Plex2Shell è una catena di quattro falle di Plex Media Server sfruttata per violare NAS QNAP. Aggiornare non basta: ecco come controllare e rimediare."
cover:
  image: "/images/posts/plex2shell-nas-qnap-plex-media-server.png"
  alt: "NAS scuro in un rack homelab con alloggiamento disco rosso e lucchetto incrinato"
---

Se hai Plex Media Server su un NAS QNAP e la porta 32400 raggiungibile da internet, il tuo NAS potrebbe essere già stato violato. Una catena di quattro vulnerabilità chiamata Plex2Shell è sfruttata attivamente, e aggiornare Plex alla versione 1.43.3.10861 chiude la falla ma non toglie quello che un attaccante ha già installato. Se eri esposto, la scelta più sicura è reinstallare il sistema e cambiare tutte le credenziali. Sotto i dettagli per chi vuole capire.

## Cosa è successo

Secondo BleepingComputer, QNAP ha ricevuto segnalazioni da utenti il cui Plex Media Server risulta compromesso tramite Plex2Shell. Si tratta di quattro CVE collegati tra loro: CVE-2026-96652, CVE-2026-96654, CVE-2026-96655 e CVE-2026-96656.

La cronologia è breve:

- 27 luglio: il ricercatore Zach Main segnala le falle a Plex.
- 16 ottobre: vengono pubblicati i dettagli tecnici completi. Gli attacchi partono poco dopo.
- 20 ottobre: CISA aggiunge tutti e quattro i CVE al catalogo KEV e chiede alle agenzie federali di passare a Plex 1.43.3.10861 o successiva entro tre giorni.
- 6 novembre: QNAP pubblica l'advisory sui NAS compromessi.

QNAP precisa che il difetto è solo in Plex Media Server. QTS, QuTS hero e gli altri sistemi QNAP non sono vulnerabili di per sé. Il problema è che Plex è l'app che quasi tutti installano sul NAS, e il NAS è dove stanno backup e documenti. Un bug in un'app di streaming diventa accesso a tutto il resto.

## Perché riguarda chi ha un homelab

Plex più NAS è forse la combinazione più comune in casa: la libreria multimediale sul disco, il server sempre acceso, l'accesso da fuori per guardare i film in viaggio. Per far funzionare quel "da fuori" molti hanno aperto la porta 32400 sul router, e quella porta aperta è la superficie di attacco.

Non è un problema solo di QNAP. Il bug sta in Plex, quindi vale anche per Synology, per un mini PC con Docker, per un vecchio PC con Linux o per il Raspberry. QNAP è semplicemente il caso in cui sono state documentate violazioni reali. Se vuoi un'idea di cosa si può usare al posto di un NAS commerciale, ne ho parlato nel post sui [mini PC usati come NAS](/posts/mini-pc-usati-nas-commerciali/).

## Cosa fare

1. Aggiorna Plex Media Server alla 1.43.3.10861 o successiva. Su QNAP si fa dall'App Center, dove la versione attuale è proprio questa.
2. Controlla i segnali di compromissione elencati nel bollettino di sicurezza QNAP. Non li riporto qui uno per uno: usa la fonte ufficiale, che viene aggiornata.
3. Se il server era esposto su internet, QNAP dice di considerare NAS e contenuti come compromessi. La procedura consigliata è la reinstallazione pulita di QTS o QuTS hero, poi reset di tutte le credenziali di Plex e del NAS.
4. Se non ti serve l'accesso remoto, disattivalo nelle impostazioni di Plex e togli il port forwarding della 32400 dal router.
5. Se ti serve, raggiungi il server via VPN invece di esporre la porta. WireGuard su router o su un piccolo host fa il lavoro senza complicazioni.
6. Se sospetti una violazione, QNAP offre di analizzare i log che mandi tramite il portale di supporto tecnico, e ha pubblicato una guida passo passo alla bonifica.

Prima di reinstallare, fai una copia dei dati che ti servono. Ma copiali con attenzione: se c'è un payload sul sistema, non portarti dietro script o file eseguibili, solo i documenti.

## La mia opinione

La reinstallazione completa può sembrare eccessiva per "un'app di film". Non lo è. Chi ha eseguito codice sul NAS ha avuto accesso a tutto quello che c'è sopra, e una pulizia a mano difficilmente ti dà la certezza di aver tolto ogni persistenza. Meglio mezza giornata persa che un backdoor che resta lì per mesi.

Mi pesa anche un'altra cosa. Per le falle uscite il 16 ottobre, il 20 era già nel catalogo KEV. Quattro giorni. Chi aggiorna "quando ha tempo" a questo punto è in ritardo per definizione, e per i servizi esposti su internet l'aggiornamento automatico, o almeno un controllo settimanale, non è più un optional, come mostra anche lo [zero-day sugli switch Zyxel](/posts/zyxel-gs1900-zero-day-switch-patch/). Il consiglio più utile resta però quello vecchio: non aprire porte sul router per un media server, se puoi evitarlo.

Fonte: [BleepingComputer](https://www.bleepingcomputer.com/news/security/qnap-says-hackers-breaching-nas-devices-in-plex2shell-attacks/), che riporta l'advisory di QNAP e l'avviso CISA.
