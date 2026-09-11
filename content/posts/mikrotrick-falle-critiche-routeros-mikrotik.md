---
title: "MikroTrick: due falle critiche in RouterOS usate per prendere il controllo dei router MikroTik"
date: 2026-09-11
draft: false
tags: ["sicurezza", "homelab", "networking"]
categories: ["Sicurezza"]
description: "CERT Polska ha scoperto MikroTrick: due bug critici in RouterOS che permettono di controllare router MikroTik esposti via SSH senza credenziali."
cover:
  image: "/images/posts/mikrotrick-falle-critiche-routeros-mikrotik.png"
  alt: "Router MikroTik con simbolo di allerta per vulnerabilità RouterOS critica"
---

Se hai un router MikroTik con SSH raggiungibile da internet, il punto è questo: c'è una catena di attacco, soprannominata MikroTrick, che permette di prendere il controllo completo del dispositivo senza conoscere nessuna password, e chi ci riesce lascia dietro di sé un utente SSH nascosto che gli garantisce di rientrare quando vuole, anche dopo un riavvio o un cambio password. Non serve che tu abbia mai esposto niente di sensibile su quel router: basta che la gestione remota via SSH sia aperta verso il mondo. La correzione c'è già, è nell'ultima versione di RouterOS, e va installata subito. Sotto trovo lo spazio per il dettaglio tecnico, per chi vuole capire cosa sta succedendo prima di aggiornare al buio.

CERT Polska ha battezzato la catena d'attacco "MikroTrick" e l'ha resa pubblica nei giorni scorsi, con ripresa immediata da BleepingComputer. Sfrutta due vulnerabilità critiche in RouterOS, con punteggio CVSS 9.2, che combinate insieme permettono a un attaccante remoto di ottenere il controllo completo del router senza autenticarsi, a condizione che il servizio SSH sia raggiungibile da internet. Le versioni corrette sono 7.25 beta 3, 7.24.2, 7.23.4 e 6.49.21, a seconda del ramo che stai usando.

## Come funziona la catena d'attacco

Il dettaglio che rende MikroTrick diverso dal solito bollettino "ennesima CVE su un firmware di rete" è la firma che lascia. Dopo aver sfruttato le due falle in sequenza, gli attaccanti creano sul router un account SSH con nome utente `-2`. Non è un typo né un nome a caso: è pensato per confondersi tra i log e le liste utenti di sistema, dove un carattere in più o in meno passa facilmente inosservato a un occhio poco attento. Quell'utente diventa la backdoor persistente: anche se scopri l'intrusione e cambi tutte le password amministrative, quell'account resta lì, con accesso SSH pieno, finché non lo trovi e lo elimini manualmente.

Il fatto che serva SSH esposto e nessun'altra condizione particolare è quello che alza il livello di rischio. Non c'è bisogno di ingegneria sociale, non c'è bisogno che qualcuno in casa clicchi su niente: è un attacco che uno scanner automatico su Shodan o Censys può individuare e sfruttare senza intervento umano, esattamente come succede regolarmente con altri dispositivi di rete esposti male. Con un CVSS di 9.2 e zero autenticazione richiesta, è il tipo di combinazione che finisce rapidamente negli script degli attaccanti opportunisti, quelli che non prendono di mira te in particolare ma scansionano intere fasce di IP a caccia di dispositivi vulnerabili.

## Perché MikroTik nel homelab è quasi la norma

MikroTik è uno dei brand più diffusi tra chi in Italia si è messo a fare homelab sul serio, insieme a Ubiquiti di cui [ho parlato qui poche settimane fa per un bollettino altrettanto pesante](/posts/ubiquiti-vulnerabilita-critiche-unifi-os/) con tre CVSS 10.0 su UniFi OS. Il motivo è semplice: un hEX o un RB750 costano poco, RouterOS fa girare firewall, VPN, VLAN e QoS avanzati su hardware economico, e la community è enorme, con guide per praticamente ogni configurazione possibile. È anche il router che tanti usano per accedere da remoto alla propria rete di casa via SSH, magari per debug rapido o per gestire il resto dell'infrastruttura homelab senza passare ogni volta da un client VPN.

Ed è proprio questo il problema. L'SSH raggiungibile da internet, su MikroTik, è una configurazione comune quanto pericolosa quando esce una falla come questa. A differenza di un servizio aziendale gestito da un reparto IT con patch automatiche, un router MikroTik domestico spesso resta con il firmware di quando l'hai configurato la prima volta, magari anni fa, finché non succede qualcosa che ti costringe a guardarci di nuovo. E "qualcosa" a volte vuol dire un utente `-2` che scopri per caso mentre controlli la lista utenti per un motivo del tutto diverso.

## Cosa fare, in ordine

Prima cosa: aggiorna RouterOS. Dalla Winbox o dalla dashboard web vai su System > Packages > Check for Updates, e installa almeno la 7.24.2 se sei sul ramo stable, la 7.23.4 se sei sul ramo long-term, o la 6.49.21 se sei ancora fermo sulla serie 6.x (che a questo punto vale la pena valutare seriamente di lasciarsi alle spalle, visto quanto tempo è passato dall'ultima major).

Seconda cosa, e la faccio prima ancora di scrivere il resto di questo pezzo se ho un MikroTik in produzione: controlla la lista utenti SSH con `/user print` dal terminale RouterOS, e cerca qualunque account che non riconosci, non solo quello con nome `-2`. Se lo trovi, rimuovilo con `/user remove`, poi cambia tutte le password amministrative del dispositivo, non solo quella dell'utente compromesso.

Terza cosa, quella che conta di più a lungo termine: se non hai un motivo reale per tenere SSH aperto verso internet su un router di frontiera, chiudilo. Metti l'accesso remoto dietro WireGuard (RouterOS lo supporta nativamente dalla versione 7, e ne ho parlato spesso qui) o quantomeno limita l'accesso SSH con una regola firewall che accetta connessioni solo dagli IP che usi davvero tu, non dall'intero internet. È la stessa lezione che si ripete a ogni bollettino di questo tipo: la superficie d'attacco che non esiste non può essere sfruttata, a prescindere da quante CVE escano in futuro.

Io i miei dispositivi MikroTik li tengo dietro VPN da tempo, proprio per questo genere di scenario, ma l'aggiornamento firmware l'ho lanciato comunque appena letto il bollettino di CERT Polska: non conviene fidarsi della propria memoria su "quali regole firewall avevo messo" quando la posta in gioco è il controllo completo del router che regge tutta la rete di casa.

Fonte: [BleepingComputer](https://www.bleepingcomputer.com/news/security/hackers-exploit-new-mikrotik-routeros-flaws-to-hijack-routers/)
