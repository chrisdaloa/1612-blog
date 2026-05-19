---
title: "RapidRAW: un editor RAW open source che vale la pena tenere d'occhio"
date: 2026-05-19
draft: true

tags: ["fotografia", "open-source", "linux", "raw", "strumenti", "alternativa-lightroom"]
categories: ["Linux", "Tech"]

description: "RapidRAW è un editor RAW open source, scritto in Rust, che pesa 20 MB e gira su Linux, Mac e Windows. Sviluppato da un 18enne durante un apprendistato."

cover:
    image: "/images/rapidraw.png"
    alt: "RapidRAW editor RAW open source"
    caption: "RapidRAW: editor RAW non-distruttivo, GPU-accelerato e open source"
    relative: false
---

Lightroom costa circa 11€ al mese nell'abbonamento base, le foto passano per i server Adobe se usi la sync, e l'app pesa centinaia di megabyte. Non è una novità, ma ogni volta che lo installo su una macchina nuova mi chiedo se non esista qualcosa di più ragionevole.

[RapidRAW](https://www.getrapidraw.com/) non è la risposta definitiva, ma è il progetto più interessante che ho incontrato di recente in questo spazio.

## Cos'è

Un editor RAW non-distruttivo, accelerato via GPU, open source con licenza AGPL-3. Gira su Windows, macOS e Linux. Pesa 20-30 MB. Le modifiche si salvano in file sidecar, gli originali non vengono mai toccati.

Lo stack è Rust, Tauri e React. Non è un'app Electron con un browser intero impacchettato dentro — Tauri usa il webview nativo del sistema operativo, e la parte pesante del processing è scritta in Rust con shader WGSL che girano direttamente sulla GPU. Il risultato è che gli aggiustamenti sono in tempo reale anche su file RAW grandi, senza il lag a cui ci si abitua con altri software.

## Le funzioni principali

Ha quello che ci si aspetta da un editor RAW moderno: curve tonali, mixer HSL, dettagli, correzione lente tramite Lensfun, geometria, analisi dell'immagine con waveform e scopi. Niente di rivoluzionario nel set di strumenti base, ma tutto quello che serve per un workflow normale c'è.

La parte più interessante sono le maschere AI: rilevamento automatico di soggetto, cielo e primo piano. Funzionano direttamente nell'app senza connessione a servizi esterni. C'è anche l'integrazione con ComfyUI per chi vuole strumenti generativi più avanzati — rimozione oggetti, aggiunta elementi via prompt — con tre opzioni: strumenti base inclusi gratis, ComfyUI self-hosted su GPU propria, oppure abbonamento cloud per chi non vuole configurare niente.

L'opzione self-hosted con ComfyUI è quella che trovo più coerente con il resto del progetto.

## Chi lo sviluppa

Timon Käch, 18 anni, lo sviluppa parallelamente a un apprendistato. Il repository GitHub è attivo, le release sono frequenti e lo sviluppatore risponde alle issue. La licenza AGPL-3 è stata scelta esplicitamente per garantire che il progetto e i suoi derivati rimangano sempre open source.

Al momento c'è una campagna donazioni aperta — circa 5.700 CHF su 10.000 CHF di obiettivo — per supportare lo sviluppo continuato. Non è un prodotto commerciale con un business model consolidato, e questo è sia il suo punto di forza che l'unica incertezza sul lungo periodo.

## Confronto con Darktable

Darktable è l'altra alternativa open source seria in questo spazio. È gratuito, maturo, potente, ma ha una curva di apprendimento ripida e un'interfaccia che non si è mai particolarmente preoccupata di essere intuitiva. Funziona bene per chi ci investe tempo.

RapidRAW punta su qualcosa di diverso: un'interfaccia più vicina all'esperienza Lightroom, più immediata. È un progetto molto più giovane e manca ancora di alcune funzionalità — la lista dei formati RAW supportati non è ancora documentata in modo esaustivo — ma per chi trova Darktable ostico è un'alternativa da valutare.

## Vale la pena provarlo

Se si usa Linux e si vuole evitare Lightroom, sì. Se si usa Windows o Mac e si vuole qualcosa di leggero e veloce senza abbonamento, anche. È abbastanza maturo per un uso quotidiano su foto non critiche, e lo sviluppo è abbastanza attivo da far pensare che migliori rapidamente.

Per lavoro professionale dove la compatibilità con tutti i formati RAW è fondamentale, vale la pena verificare prima se la propria fotocamera è supportata. Ma per uso personale è già una proposta seria.
