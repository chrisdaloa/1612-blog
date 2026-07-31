---
title: "NoMachine su Linux Mint: guida all'installazione e quando conviene usarlo"
date: 2026-04-21
draft: false
tags: ["linux", "linux-mint", "tutorial"]
categories: ["Tech"]
description: "NoMachine su Linux Mint: come si installa, come si configura il firewall e perché lo preferisco a VNC per il desktop remoto in casa."
cover:
  image: "/images/nomachine.png"
  alt: "NoMachine su Linux Mint"
  caption: "Controllo remoto facile su linux "
  relative: false
---

Se come me avete diversi computer in casa, magari in stanze o piani diversi, prima o poi vi serve un modo per collegarvi da uno all'altro senza alzarvi dalla sedia. Ho provato diverse soluzioni di desktop remoto su Linux Mint e quella che uso più spesso è NoMachine.

## Cos'è e perché non è come VNC

NoMachine è un software di desktop remoto proprietario, non open source come VNC, che punta tutto sulla fluidità: trasmette anche l'audio del sistema remoto, ha una latenza più bassa della maggior parte delle alternative gratuite e restituisce una sensazione più vicina a un desktop locale che a una sessione remota compressa e sgranata. Funziona su Linux, Windows e macOS, quindi va bene anche se in casa avete un mix di sistemi operativi.

Il rovescio della medaglia è che essendo proprietario avete meno controllo rispetto a soluzioni come SSH con X forwarding, e consuma più risorse di un client VNC minimale. Per un utilizzo occasionale non è un problema, ma per amministrare un server headless con risorse limitate SSH resta la scelta più sensata.

## Installazione su Linux Mint

Si scarica il pacchetto `.deb` dal sito ufficiale di NoMachine e si installa con:

```bash
sudo dpkg -i nomachine_*.deb
```

Se mancano dipendenze:

```bash
sudo apt --fix-broken install
```

Il servizio di solito parte da solo dopo l'installazione, ma se dovete avviarlo o controllarne lo stato manualmente:

```bash
sudo /usr/NX/bin/nxserver --start
sudo /usr/NX/bin/nxserver --status
```

A questo punto basta installare il client NoMachine sull'altro computer, inserire l'IP del PC con Linux Mint e fare login con le stesse credenziali che usate in locale.

## Firewall

Se avete UFW attivo dovete aprire la porta che NoMachine usa di default:

```bash
sudo ufw allow 4000/tcp
sudo ufw reload
```

Se il firewall non è ancora attivo, tanto vale attivarlo prima di esporre un servizio di accesso remoto:

```bash
sudo ufw enable
```

## Vale la pena installarlo?

Per raggiungere il proprio PC Linux da un'altra stanza senza perdere tempo a configurare protocolli grafici, sì. Non è la soluzione più leggera né la più aperta, ma è quella che richiede meno sbattimento per iniziare a funzionare bene.
