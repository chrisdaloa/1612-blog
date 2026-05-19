---
title: "Mini PC usati come NAS: il mio setup con due OptiPlex e Proxmox"
date: 2026-05-19
draft: true

tags: ["nas", "mini-pc", "proxmox", "self-hosting", "linux", "home-server", "jellyfin", "xpenology"]
categories: ["Linux", "Tech"]

description: "Due OptiPlex usati, Proxmox, XPenology, Jellyfin e due vecchi Synology DS112j come storage aggiuntivo. Quanto costa, cosa funziona e cosa no."

cover:
    image: "/images/ilmoproxmox.png"
    alt: "Optiplex e DS112j nel mio soggiorno"
    caption: "Optiplex e DS112j nel mio soggiorno"
    relative: false
---

Non ho un NAS Synology nuovo. Ho due OptiPlex recuperati, due vecchi Synology DS112j comprati usati anni fa e un setup che nel tempo si è un po' stratificato. Non è la soluzione più pulita del mondo, ma funziona e mi è costata una frazione di quello che avrei speso comprando tutto nuovo.

Vale la pena raccontarlo, anche perché secondo me il mercato dei PC aziendali usati è ancora sottovalutato per questo tipo di utilizzo.

## Le macchine

Ho un **OptiPlex 3070 Micro** e un **OptiPlex 3050 Micro**, entrambi con 16 GB di RAM DDR4 e un [SSD da 1 TB](https://www.amazon.it/dp/B08T1SMTF9/?tag=16120s-21). Li ho presi su eBay e Subito.it, spendendo tra i 70 e i 90€ ciascuno. Erano macchine d'ufficio, con qualche graffio sul case e Windows 10 Pro installato — che ho subito rimpiazzato.

Il formato Micro di Dell è una di quelle cose che sembrano un giocattolo la prima volta che le vedi: 18x18x3 cm circa, un alimentatore esterno come quello di un laptop, silenziosi quasi al punto da dimenticarsi che ci sono. Per un server domestico che deve stare acceso sempre, silenzio e consumi bassi contano parecchio.

![I due OptiPlex Micro affiancati — il 3070 a sinistra, il 3050 a destra](/images/optiplex-3070-3050-micro.jpg)

## Proxmox su entrambi

Su entrambe le macchine gira **Proxmox VE**. La scelta di un hypervisor invece di installare i servizi direttamente era quasi obbligata: voglio poter tenere separati i vari servizi, fare snapshot prima di aggiornare qualcosa, e in generale non avere tutto che dipende da tutto.

Proxmox gira bene anche su hardware modesto. Con 16 GB di RAM si stanno comodi — tengo un paio di VM leggere più diversi container LXC, e non ho mai visto la RAM saturare sul serio.

## XPenology: la parte discutibile ma comoda

Sul 3070 ho una VM con **XPenology**, ovvero DSM di Synology che gira su hardware non-Synology. È una zona grigia, non lo nego — non è software open source e Synology non lo approva. Detto questo, per il mio uso domestico ho deciso che ci stavo bene.

Il motivo pratico è che DSM funziona molto bene come interfaccia NAS: gestione share, utenti, Synology Photos per i backup dei telefoni di famiglia, e una certa stabilità nel tempo. Avendo già i vecchi DS112j in casa, l'ecosistema delle app DSM lo conoscevo già.

Il disco da 1 TB del 3070 fa da storage principale per i dati di casa — documenti, foto, backup. Niente RAID interno per ora, mi affido agli snapshot di Proxmox e ai backup sui DS112j.

## Portainer e Jellyfin

Sul 3050 invece ho un approccio diverso: container Docker gestiti con **Portainer**. Ci gira **Jellyfin** per il media server, qualche altro servizio minore e alcune automazioni. Tenere i container separati dalla VM XPenology mi permette di riavviare o aggiornare un servizio senza toccare lo storage.

Jellyfin con hardware transcoding funziona benissimo grazie all'Intel Quick Sync integrato nei processori di 9a generazione di questi OptiPlex. Anche streaming simultaneo a più dispositivi non ha mai dato problemi.

## I vecchi DS112j: storage aggiuntivo dal nulla

I due **Synology DS112j** sono NAS single-bay del 2012 circa — lenti, con poco RAM, processori Marvell che fanno quasi tenerezza. Nuovi non li compererei, ma li ho recuperati e ci stanno dentro due [HDD da 4 TB](https://www.amazon.it/dp/B09RMRKC9P/?tag=16120s-21) ciascuno.

![Il setup completo: i due DS112j sul ripiano in basso, i due OptiPlex sopra](/images/setup-nas-optiplex-ds112j.jpg)

Li uso come destinazione per i backup: lo script di backup del 3070 scarica ogni notte una copia dei dati importanti su entrambi i DS112j. Non sono veloci e DSM su quel hardware non riceve più aggiornamenti da tempo, ma per fare da target di backup su rete locale fanno il loro lavoro senza problemi.

È l'uso più sensato che potessi fare di hardware altrimenti destinato al cassetto. Il disco da 4 TB costa più del NAS che lo contiene, ma il NAS è già lì.

## Cosa ho speso in totale

OptiPlex 3070: ~90€. OptiPlex 3050: ~75€. I DS112j li avevo già. Gli SSD da 1 TB li ho comprati nuovi, circa 55€ ciascuno. Gli HDD da 4 TB nei DS112j li avevo da prima in giro.

Difficile fare un confronto preciso perché il setup si è costruito nel tempo, ma orientativamente: meno di 400€ compresi i dischi nuovi, con capacità e flessibilità che un NAS entry-level da 500€ non avrebbe mai.

## Le cose che non funzionano benissimo

La versione Micro degli OptiPlex ha un solo slot SATA interno. Per espandere lo storage si passa da dischi USB — non ideale, ma funzionale per backup — o si cambia forma factor. Non ho ancora trovato una soluzione elegante per avere più storage interno senza cambiare case.

XPenology richiede attenzione agli aggiornamenti: non si aggiorna come un sistema normale e ogni salto di versione DSM va valutato. Non è roba per chi vuole premere "aggiorna" senza pensarci.

Proxmox ha una curva di apprendimento che non è banale. Non è complicato, ma richiede di capire cosa si sta facendo.

## Alla fine

Questo setup non è per tutti. Se si vuole qualcosa che funzioni senza pensarci, un [Synology DS223](https://www.amazon.it/dp/B0BRNBVTJK/?tag=16120s-21) nuovo con garanzia e aggiornamenti automatici è probabilmente la scelta giusta.

Ma se si ha voglia di metterci un po' di tempo, l'hardware aziendale usato offre qualcosa che i NAS commerciali entry-level non danno: potenza reale, RAM espandibile, flessibilità totale sul software. E spesso a un prezzo che lascia i soldi per i dischi, che sono la parte che conta davvero.

---

*Alcuni link in questo articolo sono link di affiliazione Amazon. Se acquisti tramite questi link ricevo una piccola commissione, senza alcun costo aggiuntivo per te.*
