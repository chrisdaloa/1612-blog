---
title: "Guida rapida: creare un sito con Hugo e il tema PaperMod (SEO)"
date: 2025-11-25
draft: false
tags: ["hugo","papermod","static-site","seo","tutorial"]
categories: ["Web","Hugo"]
description: "Istruzioni passo-passo per creare, configurare e ottimizzare SEO un sito Hugo usando il tema PaperMod. Comandi Windows, configurazione, deploy su Netlify/GitHub Pages."
cover:
  image: "/images/hugo_papermod.png"
  alt: "Hugo + PaperMod"
  caption: "Sito statico veloce con Hugo e PaperMod"
  relative: false
---

Obiettivo: creare un sito statico con Hugo e il tema PaperMod, configurarlo per SEO e distribuirlo (Windows). Istruzioni precise, comandi e configurazione minima ottimizzata per motori di ricerca.

## 1) Prerequisiti
- Windows (PowerShell) con Git installato.
- Hugo (extended) installato. Suggerito: Chocolatey o Scoop.
- Account GitHub (per deploy) e/o Netlify.

## 2) Installare Hugo (Windows)
- Con Chocolatey (PowerShell amministratore):
    Copy-Item -Path "choco install hugo-extended -y" -Destination . -Force
- Con Scoop:
    Copy-Item -Path "scoop install hugo" -Destination . -Force
(Se preferisci scarica l'installer da https://gohugo.io/)

Nota: verifica con:
    hugo version

## 3) Creare il sito Hugo (cartella di lavoro)
Se partendo da zero:
    cd C:\app
    hugo new site 1612-blog

Se la cartella esiste e vuoi sovrascrivere i template vuoti (attenzione):
    cd C:\app\1612-blog
    hugo new site . --force

Inizializza Git:
    cd C:\app\1612-blog
    git init
    git checkout -b main

## 4) Aggiungere PaperMod (tema) come submodule
    git submodule add https://github.com/adityatelange/hugo-PaperMod themes/PaperMod
    git submodule update --init --recursive

Copia l'esempio del tema (Windows PowerShell):
    Copy-Item -Path ".\themes\PaperMod\exampleSite\*" -Destination . -Recurse -Force

## 5) Configurazione minima (SEO-ready)
Crea o edita config.toml nella root del sito. Esempio minimo ottimizzato SEO:

    baseURL = "https://tuosito.it/"
    languageCode = "it-it"
    title = "Titolo Sito - Nome"
    theme = "PaperMod"
    disableKinds = ["taxonomy", "taxonomyTerm"]
    paginate = 10
    enableRobotsTXT = true
    canonifyURLs = true

    [params]
      description = "Breve descrizione SEO-friendly del sito (max 155 char)."
      author = "Tuo Nome"
      showReadingTime = true
      mainSections = ["posts"]
      # PaperMod SEO helpers
      tags = true
      highlight = true

    [params.seo]
      enable = true
      # meta social
      twitter = "tuo_twitter"
      twitter_site = "tuo_twitter"
      # google analytics (se usi)
      googleAnalytics = "UA-XXXXXXXX-X"

    [outputs]
      home = ["HTML", "RSS", "JSON"]

Salva config.toml e modifica baseURL e description con i tuoi dati.

## 6) Creare contenuti
Esempio post:
    hugo new posts/benvenuto.md

Modifica il front matter del post: titolo, description (meta), keywords (tags) e immagine con alt text. Usa H1-H3, URL puliti e link interni.

## 7) Avvia server locale per test
    hugo server -D --bind 127.0.0.1 --port 1313

Apri http://localhost:1313 e verifica mobile/desktop. Controlla:
- title e meta description
- tag og:title, og:description e og:image
- sitemap.xml (Hugo lo genera automaticamente)
- robots.txt (se enableRobotsTXT = true)

## 8) Best practice SEO rapide
- Meta description univoca per ogni pagina (≈120–155 char).
- URL brevi e leggibili (slug).
- Titoli (H1) unici e gerarchia H2/H3.
- Immagini ottimizzate (dimensione, alt text).
- Schema.org/JSON-LD per articoli (PaperMod può esporre output JSON).
- Sitemap (hugo genera sitemap.xml) e robots.txt.
- Page speed: minimizza CSS/JS, usa immagini WebP, CDN.
- Mobile-first: verifica con Lighthouse.

## 9) Build e deploy (Netlify)
1. Commit & push su GitHub:
    git add .
    git commit -m "Init Hugo + PaperMod"
    git branch -M main
    git remote add origin https://github.com/tuo-username/tuo-repo.git
    git push -u origin main

2. Netlify:
- Crea nuovo sito dal repository GitHub.
- Build command: `hugo`
- Publish directory: `public`
- Set environment variable: HUGO_VERSION (opzionale), HUGO_ENV=production
- Abilita deploy automatici.

Alternativa: GitHub Pages (usa azioni con peaceiris/actions-hugo) o Vercel.

## 10) Controlli finali SEO prima del lancio
- Verifica sitemap.xml e invio a Google Search Console.
- Aggiungi file robots.txt (se serve regole custom).
- Controlla meta canonical per pagine duplicate.
- Testa rich snippets (structured data).
- Misura performance e correggi problemi segnalati da Lighthouse.

## 11) Risorse utili
- Hugo docs: https://gohugo.io/
- PaperMod repo & docs: https://github.com/adityatelange/hugo-PaperMod
- Deploy Netlify: https://www.netlify.com/
