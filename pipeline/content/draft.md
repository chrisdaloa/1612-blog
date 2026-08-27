---
title: "Ubiquiti corregge tre vulnerabilità UniFi OS di gravità massima, una sfruttabile senza autenticazione"
date: 2026-08-27
draft: false
tags: ["sicurezza", "homelab", "networking", "unifi"]
categories: ["Sicurezza"]
description: "Ubiquiti ha rilasciato 22 patch di sicurezza per UniFi, tre a gravità massima CVSS 10.0. Una, su UniFi Protect, è sfruttabile senza login. Aggiorna subito."
cover:
  image: "/images/posts/ubiquiti-vulnerabilita-critiche-unifi-os.png"
  alt: "Dispositivo di rete UniFi con simbolo di allerta per vulnerabilità di sicurezza"
---

Se hai un access point, uno switch o una telecamera UniFi in casa o in homelab, il punto è semplice: c'è una falla che permette a chiunque, senza nessuna credenziale, di eseguire comandi arbitrari su UniFi Protect se non hai ancora aggiornato. Non serve che tu ci abbia mai messo mano dall'esterno, basta che il dispositivo sia raggiungibile. Chi ha in casa una console UniFi OS o l'app Protect per le telecamere deve aggiornare oggi, non alla prossima manutenzione programmata. Sotto trovi il dettaglio tecnico per chi vuole capire cosa è successo davvero.

Il 26 agosto 2026 Ubiquiti ha pubblicato il Security Advisory Bulletin 067, che corregge 22 vulnerabilità sull'intera linea UniFi: 21 classificate come critiche, una come alta. Tre di queste toccano il punteggio massimo possibile, CVSS 10.0, il livello riservato ai bug che un attaccante può sfruttare da remoto, senza privilegi, con impatto totale sul sistema. Non è un bollettino di routine. È uno dei batch più pesanti che UniFi abbia mai rilasciato in un colpo solo, con la stessa urgenza di reazione che si è vista di recente con [il worm npm Shai-Hulud](/posts/shai-hulud-worm-npm-supply-chain/), dove la velocità di risposta ha fatto la differenza tra un incidente contenuto e uno esteso.

## Le tre vulnerabilità a punteggio massimo

CVE-2026-77537 è quella che fa più rumore, ed è quella citata anche nel titolo di BleepingComputer che ha ripreso la notizia. Colpisce l'applicazione UniFi Protect, quella che gestisce le telecamere di videosorveglianza, ed è dovuta a una validazione dell'input scorretta che permette command injection: un attaccante non autenticato può far eseguire comandi arbitrari direttamente sul dispositivo, senza login, senza nemmeno un account valido. È corretta nella versione 7.2.105 di Protect.

Le altre due a CVSS 10.0 sono altrettanto serie, anche se hanno avuto meno risalto mediatico. CVE-2026-77550 è un authentication bypass su UniFi OS, ottenuto tramite CRLF injection: in pratica un attaccante riesce a bypassare completamente il login del sistema operativo che gira su console, switch e gateway UniFi. È corretta nelle versioni 5.1.37, 5.1.31 e 5.1.32 di UniFi OS, a seconda della linea di prodotto. CVE-2026-77554 è invece un altro command injection, stavolta su UniFi Talk (il sistema VoIP di Ubiquiti), corretto nella versione 5.3.2.

A completare il quadro ci sono altre falle poco sotto il massimo, come CVE-2026-77533 e CVE-2026-77534 a 9.9, legate rispettivamente a validazione input scorretta e controllo accessi improprio su UniFi Network Application e UniFi OS. Il filo comune di tutto il bollettino è la stessa classe di errore che si ripete: input non validato che finisce eseguito come comando di sistema, oppure controlli di accesso che si aggirano con un payload malformato. Non un singolo bug isolato, ma un problema sistemico nel modo in cui alcune componenti UniFi gestiscono le richieste in ingresso.

La buona notizia, per ora, è che Ubiquiti non segnala sfruttamento attivo di nessuna di queste falle, e al momento della pubblicazione del bollettino non risultano proof-of-concept pubblici in giro. Ma con un CVSS 10.0 e zero autenticazione richiesta, è solo questione di tempo prima che qualcuno reverse-engineeri la patch (confrontando il codice prima e dopo il fix, tecnica standard per chi cerca exploit) e tiri fuori un proof-of-concept funzionante. Aspettare non conviene.

## Perché riguarda proprio chi ha un homelab

UniFi è probabilmente il brand di rete più diffuso tra chi si è costruito un homelab in Italia negli ultimi anni: access point, switch gestiti, gateway, telecamere Protect, tutto sotto lo stesso ecosistema con un'unica console di gestione. È comodo, l'interfaccia è curata, e proprio per questo tanta gente lo espone più di quanto pensi: c'è chi apre la porta di management verso internet per gestire la rete da remoto senza VPN, chi lascia UniFi Protect raggiungibile per vedere le telecamere dal telefono senza passare da un tunnel, chi semplicemente non si ricorda più quali porte ha aperto sul router due anni fa. Su un dispositivo aziendale gestito da un reparto IT la finestra tra la pubblicazione della patch e l'installazione è di solito breve. Su un homelab domestico, dove l'aggiornamento firmware capita quando capita, quella finestra può restare aperta per settimane, ed è esattamente lì che un CVSS 10.0 senza autenticazione diventa pericoloso davvero.

Non serve nemmeno essere un bersaglio scelto apposta. Basta uno scan automatico su Shodan o Censys che individua console UniFi esposte con la porta di management raggiungibile, e la falla fa il resto da sola. Se gestisci telecamere di videosorveglianza tramite UniFi Protect, il rischio non è solo l'accesso al feed video: con command injection sul dispositivo, un attaccante ha di fatto una shell sul sistema che le gestisce, con tutto quello che ne consegue in termini di pivot verso il resto della rete.

## Cosa fare, in ordine

Prima cosa: controlla la versione installata su ogni componente UniFi che hai, dalla console del sistema operativo UniFi OS fino alle singole app (Protect, Network, Talk, Access, Connect). Aggiorna tutto alle versioni corrette indicate nel bollettino: UniFi Protect alla 7.2.105, UniFi OS alla 5.1.37 (o alla release equivalente della tua linea di prodotto), UniFi Talk alla 5.3.2, UniFi Network Application alla 10.5.67. L'app UniFi permette l'aggiornamento centralizzato da console, ma se hai dispositivi standalone verificali uno per uno, perché è facile che qualcosa resti indietro.

Seconda cosa, e questa vale a prescindere da questo specifico bollettino: se hai una porta di management UniFi esposta direttamente su internet, chiudila. Metti la console dietro una VPN (WireGuard va benissimo, ne parlo spesso qui) o quantomeno dietro un firewall che limiti l'accesso al solo IP di casa o dell'ufficio. Non è una misura che sostituisce la patch, ma riduce drasticamente la superficie d'attacco se in futuro esce un'altra falla di questo tipo prima che tu faccia in tempo ad aggiornare. Vale lo stesso discorso per qualunque altro servizio self-hosted esposto in casa: se non riesci a eliminare del tutto l'esposizione, almeno [sappi subito quando qualcuno prova a entrarci](/posts/notifica-telegram-login-fallito-home-assistant/).

Terza cosa: se gestisci dispositivi UniFi per conto di altri, tipo qualche vicino di casa a cui hai messo su una rete o un piccolo studio professionale, questo è il momento di controllare anche i loro impianti, non solo il tuo. Un bollettino con tre CVSS 10.0 non è il tipo di notizia da rimandare a "quando ho tempo".

Io ho un paio di switch e un access point UniFi in rack, non esposti verso internet per fortuna, ma l'aggiornamento firmware l'ho lanciato appena letto il bollettino, prima ancora di finire di scrivere questo pezzo. È il tipo di notizia dove conviene fidarsi poco della propria memoria su "cosa avevo aperto sul router" e controllare di persona, con calma, ogni singola regola del firewall che riguarda quei dispositivi.

Fonte: [BleepingComputer](https://www.bleepingcomputer.com/news/security/ubiquiti-patches-three-max-severity-security-vulnerabilities/)
