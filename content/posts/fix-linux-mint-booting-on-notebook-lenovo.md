---
title: "Risolvere il blocco di avvio boot di linux Mint sui notebook lenovo datati"
date: 2026-07-20
draft: false
tags: ["linux", "boot"]
categories: ["Linux"]
description: "Linux Mint su Lenovo: risolvere il blocco all'avvio del boot in 2 minuti. Tutti i passaggi"
cover:
    image: "/images/linux-lenovo.jpg"
    alt: "Linux Mint su Lenovo"
    caption: "Risolvere i problemi di boot"
    relative: false
---

# Linux su Lenovo IdeaPad 330S-15ARR: risolvere il blocco all'avvio con "Booting a command list"

Installando Linux su un **Lenovo IdeaPad 330S-15ARR** con processore AMD Ryzen può capitare che il sistema non riesca ad avviarsi correttamente.

Nel mio caso, dopo aver selezionato Linux dal menu di GRUB, l'avvio rimaneva bloccato su una schermata nera con il messaggio:

```text
Booting a command list
```

Il problema può essere legato alla gestione di **IOMMU e IOAPIC** e alle informazioni fornite dal BIOS al kernel Linux.

La soluzione che ha funzionato nel mio caso è stata aggiungere il seguente parametro al kernel:

```text
ivrs_ioapic[32]=00:14.0
```

## Testare la modifica da GRUB

Prima di modificare permanentemente la configurazione è possibile verificare il funzionamento direttamente dal menu di GRUB.

1. Avviare il computer e visualizzare il menu **GRUB**.
2. Selezionare la voce relativa a Linux.
3. Premere il tasto `e` per modificare temporaneamente i parametri di avvio.
4. Individuare la riga contenente i parametri del kernel, generalmente con:

```text
quiet splash
```

5. Aggiungere:

```text
ivrs_ioapic[32]=00:14.0
```

La configurazione diventerà quindi:

```text
quiet splash ivrs_ioapic[32]=00:14.0
```

Avviare il sistema premendo:

```text
Ctrl + X
```

oppure:

```text
F10
```

Se Linux si avvia correttamente, è possibile rendere permanente la modifica.

## Rendere permanente la modifica

Aprire il file di configurazione di GRUB:

```bash
sudo nano /etc/default/grub
```

Individuare la variabile:

```text
GRUB_CMDLINE_LINUX_DEFAULT
```

e configurarla nel seguente modo:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash ivrs_ioapic[32]=00:14.0"
```

Salvare il file e aggiornare la configurazione di GRUB:

```bash
sudo update-grub
```

A questo punto riavviare il sistema:

```bash
sudo reboot
```

Linux dovrebbe ora avviarsi normalmente senza dover modificare manualmente i parametri di GRUB ad ogni avvio.

## Messaggio "No irq handler for vector"

Dopo aver applicato questa modifica, durante l'avvio potrebbero comparire per alcuni secondi messaggi simili a:

```text
No irq handler for vector
```

Nel mio caso questi messaggi vengono visualizzati brevemente, dopodiché il sistema completa normalmente l'avvio.

Se il computer funziona correttamente e non si verificano problemi con periferiche USB, audio, rete o altri dispositivi, questi warning non sembrano avere conseguenze pratiche sul funzionamento del sistema.

## Soluzione alternativa con `iommu=soft`

Se il parametro:

```text
ivrs_ioapic[32]=00:14.0
```

non dovesse risolvere il problema, un'altra soluzione da provare è:

```text
iommu=soft
```

Ad esempio:

```text
quiet splash iommu=soft
```

Questo parametro forza Linux a utilizzare una gestione software dell'IOMMU invece dell'implementazione hardware.

È possibile testarlo temporaneamente modificando i parametri direttamente da GRUB, seguendo la stessa procedura descritta in precedenza.

## Configurazione utilizzata

Nel mio caso, sul **Lenovo IdeaPad 330S-15ARR**, la configurazione che ha risolto il problema è:

```text
quiet splash ivrs_ioapic[32]=00:14.0
```

Dopo averla resa permanente nella configurazione di GRUB, Linux riesce ad avviarsi correttamente.
