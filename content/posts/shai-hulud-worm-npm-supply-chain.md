---
title: "Il worm npm Shai-Hulud torna: oltre 440 pacchetti infetti tra keyv, cacheable e flat-cache"
date: 2026-08-07
draft: false
tags: ["sicurezza", "npm", "supply-chain", "homelab"]
categories: ["Sicurezza"]
description: "Il 4 agosto 2026 il worm Shai-Hulud è tornato su npm, compromettendo keyv, cacheable e oltre 440 pacchetti a cascata: cosa fare se sei stato colpito."
cover:
  image: "/images/posts/shai-hulud-worm-npm-supply-chain.png"
  alt: "Illustrazione simbolica di un worm digitale che infetta pacchetti npm a catena"
---

Se usi Node.js e hai anche solo indirettamente keyv o cacheable tra le dipendenze, la cosa da sapere subito è questa: il 4 agosto 2026 il worm Shai-Hulud ha preso il controllo dell'account del maintainer di quei due pacchetti e ha pubblicato versioni malevole che nel giro di un'ora si sono propagate a oltre 440 pacchetti npm collegati. Chi ha installato una di quelle versioni, specialmente su una macchina CI/CD o su un server self-hosted, deve trattare quell'host come compromesso, non basta disinstallare il pacchetto. Sotto trovo la cronologia, come funziona a livello concettuale (senza dettagli che aiutino a replicarlo) e la lista di cose concrete da fare, valida anche se non ti risulta di essere stato colpito ma gestisci progetti Node.

Si chiama Shai-Hulud, lo stesso nome (il verme delle sabbie di Dune, per chi ha letto il libro) usato in una campagna simile scoperta a novembre 2025. Questa è una nuova ondata, con un payload riscritto e offuscato in modo diverso, ma con lo stesso obiettivo di fondo: rubare credenziali e usarle per propagarsi da solo ad altri pacchetti.

## Cosa è successo

JFrog Security Research ha pubblicato l'analisi il 4 agosto: il punto di ingresso sono state versioni malevole di keyv 6.0.0 e cacheable 2.5.1, due librerie di caching molto diffuse (keyv in particolare è una dipendenza transitiva di un numero enorme di altri pacchetti, cosa che spiega la velocità di diffusione). Da lì il worm ha raggiunto in poche ore oltre 400 pacchetti su più di 1700 versioni pubblicate, tra cui flat-cache e file-entry-cache, entrambi con centinaia di milioni di download settimanali cumulati nell'ecosistema npm. Non è un elenco chiuso: JFrog aggiorna la lista mano a mano che ne trova altri, perché il worm non lavora su un target fisso, infetta qualunque pacchetto scrivibile con le credenziali che riesce a rubare.

## Come si propaga, in sintesi (senza fare da manuale)

Il meccanismo concettuale, senza entrare nei dettagli tecnici che servirebbero solo a chi vuole replicarlo, è questo: una volta eseguito su una macchina (tipicamente durante l'installazione del pacchetto), il payload cerca sul filesystem token e credenziali salvate: npm, GitHub, provider cloud, Kubernetes, gestori di secret, chiavi SSH, persino credenziali di strumenti AI come le API key di provider LLM. Se trova un token npm con permessi di scrittura, lo usa per pubblicare automaticamente una versione malevola di ogni pacchetto che quell'account può modificare, incrementando semplicemente la versione patch. Se trova un token GitHub, lo usa per committare file di configurazione in repository raggiungibili, pensati per eseguirsi da soli quando qualcuno apre il progetto in VS Code o avvia una sessione con strumenti come Claude Code. È questo il dettaglio che mi ha colpito di più leggendo il report: il worm non si limita più a npm, prova ad annidarsi anche negli hook di avvio degli editor e degli assistenti AI che ormai usiamo tutti i giorni. Non è la prima volta che uno strumento pensato per restare "in locale" finisce per esporre credenziali verso l'esterno: successe qualcosa di concettualmente simile con [Grok Build](/posts/grok-build-prometteva-tutto-locale-poi-caricava-interi-repository-password-comprese-sul-cloud-di-xai/), il CLI di coding di xAI.

Un dettaglio tecnico utile da sapere, in positivo: da npm 12 in poi gli script `preinstall` non partono più in automatico durante l'installazione. Chi usa una versione recente di npm ha uno strato di protezione in più rispetto a chi è rimasto su versioni vecchie, anche se non è una garanzia assoluta, perché il worm ha comunque altri percorsi per eseguirsi (per esempio proprio tramite gli hook di editor e CI descritti sopra).

## Perché riguarda proprio chi ha un homelab

Qui il post normalmente parlerebbe di "aziende" e "team di sviluppo", ma il pubblico di questo blog gestisce spesso pipeline CI/CD personali, runner self-hosted per progetti su GitHub, container Node.js su un NAS o su una VM in homelab. Sono esattamente gli ambienti più esposti: una macchina di build che non guardi tutti i giorni, con `npm install` lanciato in automatico a ogni push, è il bersaglio ideale per un worm che punta a restare invisibile il più a lungo possibile. Il report segnala anche che il payload, fuori da un ambiente CI, si stacca dal processo padre e cerca di restare silenzioso, quindi non aspettarti errori vistosi nei log come primo segnale.

## Cosa fare se hai installato una versione compromessa

Prima di tutto verifica: apri `package-lock.json` (o l'output di `npm ls keyv cacheable`) e controlla se compaiono keyv 6.0.0, cacheable 2.5.1 o versioni successive pubblicate il 4 agosto 2026 o dopo. JFrog aggiorna in continuazione l'elenco completo dei pacchetti coinvolti sul proprio sito, vale la pena ricontrollarlo invece di fidarsi solo dei due nomi principali. Se trovi un riscontro su una macchina, specialmente un runner CI o un server sempre acceso, la sequenza è questa, in ordine:

Isola la macchina dalla rete prima di fare qualunque altra cosa, per limitare l'esfiltrazione in corso. Poi revoca tutti i token npm e GitHub raggiungibili da quell'host, in particolare quelli con permessi di scrittura o con il bypass della 2FA attivo. È proprio quel tipo di token che il worm cerca per propagarsi ulteriormente. Da lì ruota ogni altra credenziale presente sulla macchina: chiavi SSH, credenziali cloud (AWS, GCP, Azure), secret di Kubernetes o Vault, API key di servizi AI. Il criterio è semplice: se il collector poteva leggerla, considerala compromessa.

Poi ricostruisci l'host da un'immagine pulita. Non basta fare `npm uninstall` del pacchetto incriminato e ripartire: il worm, una volta eseguito, ha già potuto scrivere altrove sul sistema o committare configurazioni malevole nei tuoi repository. Controlla, su tutti i branch e non solo su quello principale, la presenza di commit sospetti o di file di configurazione che non hai scritto tu negli hook di editor o CI.

## Cosa fare comunque, anche se non risulti colpito

Anche se non hai keyv o cacheable tra le dipendenze dirette, vale la pena approfittarne per rivedere qualche abitudine, perché la prossima ondata (e ce ne sarà una, con questo modello di attacco) potrebbe colpire pacchetti diversi:

Usa il lockfile (`package-lock.json` o equivalente) e committalo sempre: previene che un `npm install` prenda silenziosamente una patch appena pubblicata, magari malevola, senza che tu te ne accorga. Attiva `npm audit` nella pipeline CI, sapendo che copre le vulnerabilità note ma non un worm zero-day come questo al momento della pubblicazione. Sui token npm che usi in CI, disattiva il bypass della 2FA se non ti serve davvero, e limita i permessi di scrittura solo ai pacchetti che effettivamente pubblichi da quella pipeline, non a tutto l'account. Considera l'uso di `npm ci` invece di `npm install` nei build, che installa esattamente quanto scritto nel lockfile senza margine di deriva.

Sulle macchine dove esegui build Node.js, evita di tenere credenziali cloud o chiavi SSH ad ampio raggio se non strettamente necessario: un runner CI dedicato, isolato, con permessi minimi, limita i danni anche quando qualcosa va storto a monte, come in questo caso.

Non ho una soluzione elegante per il problema di fondo: npm è un ecosistema costruito sulla fiducia verso migliaia di maintainer che nessuno audita davvero, e un solo account compromesso può propagarsi a pacchetti con miliardi di download aggregati. È la stessa fiducia mal riposta che sfrutta [ClickFix](/posts/clickfix-truffa-falso-captcha/), solo che lì a fare il lavoro sporco sei tu davanti al terminale invece di un maintainer con permessi di pubblicazione. È lo stesso motivo per cui, quando posso, preferisco tenere il numero di dipendenze transitive più basso possibile nei miei progetti, anche a costo di scrivere qualche riga in più a mano invece di tirare dentro una libreria per una funzione banale. Non elimina il rischio, ma lo riduce, ed è comunque meglio che scoprirlo da un alert a worm già eseguito.

Fonte: [JFrog Security Research](https://research.jfrog.com/post/shai-hulud-is-back-august/)
