---
title: "ClickFix: la truffa del falso CAPTCHA che ti convince a infettarti da solo"
date: 2026-07-31
draft: false
tags: ["sicurezza", "phishing", "malware", "truffe-online"]
categories: ["Sicurezza"]
description: "ClickFix è la tecnica di social engineering che sta infettando centinaia di siti: una finta verifica CAPTCHA ti convince ad aprire Esegui su Windows o il Terminale su macOS e incollare un comando. Come funziona, perché è così efficace e come riconoscerla."
cover:
  image: "/images/posts/clickfix-truffa-falso-captcha.png"
---

Se hai un minuto solo: ClickFix è una truffa che ti fa credere di star superando un normale controllo anti-bot, ma in realtà ti guida a incollare ed eseguire tu stesso un comando malevolo su Esegui (Windows) o sul Terminale (macOS). Riguarda chiunque navighi, non solo chi gestisce server o servizi esposti. La difesa sta tutta in una regola: nessuna verifica CAPTCHA vera ti chiede di aprire uno strumento di sistema e incollarci dentro qualcosa, se succede chiudi la pagina e basta. Sotto trovi come riconoscerla nel dettaglio.

Con questo articolo apro anche una nuova categoria del blog, Sicurezza: alert pratici su falle e truffe che vale la pena conoscere, dal punto di vista di chi passa le giornate davanti a un terminale e sa quanto sia facile abbassare la guardia proprio per quello. Si comincia con ClickFix, perché se giri per internet da un po' probabilmente l'hai già visto senza saperlo, o peggio, l'hai quasi cliccato.

ClickFix non è un malware. È un metodo di distribuzione, una tecnica di ingegneria sociale che negli ultimi mesi è diventata una delle più usate in assoluto per far eseguire codice malevolo direttamente dalla vittima. Il meccanismo è quasi imbarazzante nella sua semplicità: funziona perché non attacca il tuo browser, attacca il tuo istinto di risolvere un fastidio nel modo più veloce possibile.

## Come funziona

Finisci su una pagina compromessa (un sito legittimo violato, non necessariamente un dominio sospetto) e ti compare una schermata che imita alla perfezione una verifica anti-bot: un Cloudflare Turnstile, un Google reCAPTCHA, oppure un finto messaggio di errore di Chrome o di Word che ti dice che manca un componente per visualizzare il contenuto. La pagina ti chiede di "verificare di non essere un robot" seguendo tre passaggi apparentemente innocui.

Su Windows, i passaggi sono: premi Win+R per aprire Esegui, poi Ctrl+V per incollare, poi Invio per confermare. Quello che non ti dicono è che un JavaScript sulla pagina ha già copiato negli appunti, silenziosamente, un comando PowerShell malevolo. Tu non lo vedi, non lo scrivi, non lo leggi: lo incolli e basta, fidandoti del fatto che è la pagina stessa a guidarti passo passo. Il comando scarica ed esegue il payload, tipicamente un infostealer o un RAT, e da lì in poi il danno è fatto.

Su macOS il canovaccio è identico ma il bersaglio è il Terminale: stessa finta verifica, stesso invito a incollare un comando copiato in automatico. Le varianti più recenti, per aggirare gli avvisi che macOS mostra quando apri il Terminale da un contesto sospetto, sfruttano invece lo Script Editor tramite un link `applescript://`, che apre uno script AppleScript pronto per essere eseguito con un solo clic, scavalcando di fatto il passaggio dal Terminale.

## Perché funziona così bene

ClickFix è diventato uno dei metodi di distribuzione più diffusi non per la sofisticazione tecnica. Il punto è che aggira completamente le protezioni del browser. Antivirus, filtri anti-phishing, sandboxing del browser: tutta questa infrastruttura di difesa è pensata per bloccare download automatici o script eseguiti dalla pagina stessa. Qui non scarichi niente cliccando un link, non c'è un eseguibile che il browser possa flaggare come sospetto. Sei tu, con le tue mani, ad aprire un'applicazione di sistema fidata e a eseguire un comando. Dal punto di vista del sistema operativo è un'azione legittima dell'utente, non un attacco.

E c'è un motivo per cui funziona particolarmente bene proprio su un pubblico tecnico, quello che legge questo blog compreso: siamo abituati a incollare comandi da terminale prese da posti che non abbiamo verificato fino in fondo. Una riga da un tutorial, un `curl | bash` da un README su GitHub, uno snippet da uno stack trace su un forum. È un riflesso che ci portiamo dietro dal lavoro quotidiano, e ClickFix lo sfrutta esattamente allo stesso modo in cui un attacco di phishing sfrutta l'abitudine a cliccare "accetta" su un popup di cookie senza leggerlo.

## La scala del fenomeno

Non è un fenomeno di nicchia. Malwarebytes ha riportato a maggio 2026 oltre 700 siti, soprattutto nei settori education e tech, compromessi con questa tecnica. Non parliamo di siti costruiti apposta dagli attaccanti per l'occasione: parliamo di siti legittimi, magari con un CMS non aggiornato o un plugin vulnerabile, in cui è stato iniettato lo script che genera la finta verifica. Il fatto che il dominio sia riconoscibile e ti dia fiducia è parte del meccanismo, non un dettaglio secondario.

## Le contromisure che stanno arrivando

Apple si è mossa concretamente su questo fronte: a partire da macOS Tahoe 26.4 (e nella corrispondente patch di Sequoia) il Terminale mostra un avviso nativo quando rileva che stai per incollare un comando proveniente da una fonte non affidabile, dandoti la possibilità di fermarti prima di eseguire qualcosa a occhi chiusi. È un passo utile, ma da solo non basta, perché conta anche l'attenzione dell'utente nel momento in cui compare quell'avviso e non lo liquida come l'ennesimo popup fastidioso.

## La regola pratica

Non serve ricordarsi dettagli tecnici per difendersi da ClickFix. Basta una regola sola, semplice e senza eccezioni: nessuna verifica CAPTCHA legittima, mai, ti chiede di aprire Esegui, il Terminale o lo Script Editor e incollare un comando. Un CAPTCHA vero si risolve cliccando una casella o selezionando immagini dentro il browser, punto. Se una pagina ti guida fuori dal browser verso uno strumento di sistema per "verificare" qualcosa, quella pagina ti sta attaccando, non aiutando. Chiudi la scheda e basta, anche se il sito sembra quello giusto e anche se la scritta "verifica di non essere un robot" ti sembra del tutto familiare.
