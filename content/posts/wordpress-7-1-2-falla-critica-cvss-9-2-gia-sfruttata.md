---
title: "WordPress 7.1.2 corregge una falla critica (CVSS 9.2) già sfruttata il giorno stesso del rilascio"
date: 2026-09-25
draft: false
tags: ["sicurezza", "wordpress", "self-hosting", "homelab"]
categories: ["Sicurezza"]
description: "WordPress 7.1.2 corregge CVE-2026-87902, path traversal critico (CVSS 9.2) già sfruttato il giorno del rilascio: cosa rischi e come aggiornare subito."
cover:
  image: "/images/posts/wordpress-7-1-2-falla-critica-cvss-9-2-gia-sfruttata.png"
  alt: "Lucchetto aperto su una tastiera con codice sorgente sullo schermo"
---

Se hai un sito WordPress in giro da qualche parte, anche uno vecchio che tieni acceso solo perché "prima o poi lo sistemo", questa è una di quelle notizie da non rimandare: c'è una falla critica nel modo in cui WordPress risolve i template di pagina, un attaccante può sfruttarla da remoto senza credenziali, e la correzione è già uscita insieme a conferme di exploit attivo lo stesso giorno del rilascio. Riguarda chiunque gestisca un sito WordPress, non solo grandi portali: gli scanner automatici che girano su internet non fanno distinzione tra un blog aziendale e l'installazione lasciata lì da anni su un VPS da quattro euro al mese. Il rimedio è aggiornare a 7.1.2 adesso, prima di leggere il resto se vuoi, poi torna qui per il dettaglio.

La segnalazione arriva dal bollettino Self-Hosted Weekly di elest.io, che raccoglie ogni settimana le novità più rilevanti per chi si autogestisce servizi in homelab o su server propri. WordPress ha rilasciato la 7.1.2 il 22 settembre per correggere CVE-2026-87902, un path traversal nella risoluzione dei template di pagina con punteggio CVSS 9.2, e secondo i report circolava già un exploit funzionante lo stesso giorno della release. Pochi giorni prima, la 7.1.1 aveva chiuso altre 11 falle di sicurezza, tra cui una chiamata Click2Shell, il che significa che chi era rimasto fermo sulla 7.1.0 aveva già due motivi per aggiornare prima ancora che uscisse questa terza.

## Cosa significa "path traversal nei template di pagina"

Un path traversal è, in sostanza, un modo per far leggere o eseguire a un'applicazione un file diverso da quello che dovrebbe, manipolando il percorso che le passi. Nel caso di WordPress, il meccanismo coinvolto è quello che decide quale file di template usare per mostrare una pagina, una parte del core che normalmente si fida della struttura di cartelle del tema attivo. Se quella risoluzione non valida correttamente il percorso richiesto, un attaccante può forzarla a puntare altrove: nella peggiore delle ipotesi, fuori dalla cartella del tema, verso file che non dovrebbero mai essere raggiungibili da una richiesta HTTP qualunque, incluso potenzialmente `wp-config.php`, dove vivono le credenziali del database.

Un CVSS 9.2 su questo tipo di bug si spiega da solo: non serve autenticazione, non serve che l'amministratore clicchi niente, basta che il sito sia raggiungibile. È lo stesso profilo di rischio che rende certe vulnerabilità appetibili per chi scansiona interi blocchi di IP a caccia di installazioni vulnerabili, senza prendere di mira nessuno in particolare, semplicemente perché il bersaglio si fa trovare da solo. È lo stesso schema visto di recente con [le due falle critiche in RouterOS dietro MikroTrick](/posts/mikrotrick-falle-critiche-routeros-mikrotik/) o con [il bollettino massiccio di patch UniFi](/posts/ubiquiti-vulnerabilita-critiche-unifi-os/): punteggio CVSS altissimo, nessuna credenziale richiesta, finestra di rischio che si apre appena la falla diventa pubblica.

## Perché l'exploit già attivo cambia le priorità

In questa storia mi preoccupa soprattutto la velocità con cui la falla è stata armata. Un CVE critico che resta "solo teorico" per settimane ti dà il tempo di programmare l'aggiornamento con calma. Un CVE con exploit già in circolazione il giorno stesso della patch ti toglie quel margine: significa che qualcuno aveva già capito come sfruttarla prima ancora che il bollettino ufficiale finisse di essere pubblicato, probabilmente facendo reverse engineering della patch stessa o lavorando su una segnalazione trapelata in anticipo. In pratica, ogni giorno che passa tra il rilascio e il tuo aggiornamento è un giorno in cui il tuo sito è nella finestra di tiro di chi ha già lo script pronto.

## Cosa fare se gestisci un sito WordPress

Aggiorna a 7.1.2. Se usi l'aggiornamento automatico dei minor release, che WordPress abilita di default per le patch di sicurezza, probabilmente è già partito da solo, ma vale la pena controllarlo comunque da Bacheca > Aggiornamenti, perché non tutte le installazioni gestite o con plugin di caching aggressivo applicano gli auto-update senza intoppi. Se gestisci più siti su un solo hosting, o hai installazioni WordPress dimenticate dentro un container in homelab che tieni online "tanto chi va a guardare quello", controllale una per una: sono proprio quelle a restare indietro più a lungo, e quelle che uno scanner trova comunque.

Se aggiorni WordPress via WP-CLI, il comando è semplice:

```
wp core update
wp core version
```

Conviene anche controllare i log di accesso delle ultime settimane per richieste anomale verso URL con sequenze tipo `../` o percorsi di template fuori dal solito, anche se a questo punto, con l'exploit già diffuso, distinguere un tentativo fallito da uno riuscito richiede più attenzione del solito grep sui log.

Io non gestisco più siti WordPress in prima persona da quando questo blog è passato a Hugo, ma continuo a mantenerne un paio per amici e parenti che non vogliono saperne di gestirsi da soli un sito statico, e quelli li ho aggiornati appena letto il bollettino, senza aspettare la finestra di manutenzione che avevo in programma per il weekend. Con un CVSS 9.2 e un exploit già attivo, non è il tipo di aggiornamento che vale la pena rimandare per comodità.

Fonte: [Self-Hosted Weekly, elest.io](https://blog.elest.io/self-hosted-weekly-week-39-2026-wordpress-exploited-portainer-ce-frozen-ubuntu-escape/)
