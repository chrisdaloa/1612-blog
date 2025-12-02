---
title: "Scrivere e Pubblicare su Hugo dal Telefono con GitJournal"
date: 2025-12-02
draft: false
tags: ["hugo", "gitjournal", "workflow", "mobile", "tutorial"]
categories: ["Programmazione"]
description: "Guida completa per scrivere e pubblicare articoli Hugo direttamente dal telefono usando GitJournal. Workflow mobile-first per blogger e developer."
cover:
    image: "/images/gitjournal.png"
    alt: "GitJournal app con Hugo logo"
    caption: "Scrivi articoli ovunque ti trovi"
    relative: false
---

Hai mai desiderato scrivere un articolo per il tuo blog Hugo mentre sei in metropolitana, o pubblicare un aggiornamento veloce dal telefono? Con **GitJournal** puoi farlo. Niente più vincoli al PC: scrivi in Markdown, sincronizza su GitHub e il tuo sito Hugo si aggiorna automaticamente.

In questa guida ti mostro come configurare un workflow completo mobile-first per pubblicare su Hugo direttamente dallo smartphone.

## Cos'è GitJournal?

**GitJournal** è un'app mobile (Android/iOS) che:

✅ Editor Markdown nativo
✅ Sincronizzazione Git (GitHub, GitLab, Gitea)
✅ Gestione frontmatter YAML
✅ Supporto immagini
✅ Funziona offline
✅ Open source e privacy-first

**In pratica:** È come avere VSCode + Git sul telefono, ottimizzato per scrivere.

### Link Download

- **Android:** [Google Play](https://play.google.com/store/apps/details?id=io.gitjournal.gitjournal)
- **iOS:** [App Store](https://apps.apple.com/app/gitjournal/id1466519634)
- **Sito:** [gitjournal.io](https://gitjournal.io)

**Prezzo:** Gratis con funzioni base, Pro €5/mese (supporta sviluppo)

---

## Perché Usare GitJournal con Hugo?

### Vantaggi

🚀 **Scrivi ovunque** - Treno, divano, coda alla posta
📱 **Mobile-first** - Ottimizzato per smartphone
🔄 **Auto-sync** - Push automatico su GitHub
⚡ **Deploy immediato** - Netlify pubblica in 1-2 minuti
📝 **Markdown nativo** - Preview in tempo reale
🖼️ **Gestione immagini** - Upload diretto
🔒 **Privacy** - Tutto su Git, nessun cloud proprietario

### Casi d'Uso Reali

- **Idee improvvise** - Appunti che diventano articoli
- **Micro-blogging** - Post veloci durante la giornata
- **Correzioni rapide** - Fix typo senza aprire il PC
- **Reportage live** - Eventi, conferenze, maker faire
- **Brainstorming mobile** - Bozze in movimento

---

## Prerequisiti

Prima di iniziare, assicurati di avere:

✅ Sito Hugo funzionante (come Lab1612!)
✅ Repository GitHub del sito
✅ Netlify/Vercel configurato per deploy automatico
✅ Smartphone Android/iOS
✅ Account GitHub

**Se non hai ancora Hugo su GitHub/Netlify**, segui prima [questa guida](/posts/creare-sito-hugo-github).

---

## Setup Iniziale: Configurazione Completa

### Step 1: Installa GitJournal

1. Scarica app da Play Store o App Store
2. Apri GitJournal
3. Salta il tutorial iniziale (o guardalo, è breve)

---

### Step 2: Connetti GitHub

#### A) Genera Personal Access Token su GitHub

1. Vai su GitHub → **Settings** → **Developer settings**
2. **Personal access tokens** → **Tokens (classic)**
3. **Generate new token (classic)**
4. Nome: `GitJournal Mobile`
5. Scadenza: **No expiration** (o 1 anno)
6. Seleziona permessi:
   - ✅ `repo` (tutti i permessi repo)
   - ✅ `workflow` (opzionale, per GitHub Actions)
7. **Generate token**
8. **COPIA IL TOKEN** (non lo vedrai più!)

```
Esempio token:
ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

#### B) Configura GitJournal

1. Apri GitJournal
2. **Setup Git Host** → **GitHub**
3. Inserisci:
   - **Username:** `chrisdaloa` (il tuo)
   - **Token:** incolla il token copiato
4. Seleziona repository: `1612-blog`
5. **Clone**

⏳ Attendi il download (dipende dalla dimensione del repo)

---

### Step 3: Configura Cartella Hugo

GitJournal ora ha clonato tutto il repo. Devi dirgli dove sono gli articoli Hugo.

1. In GitJournal, vai su **⚙️ Settings**
2. **Note Settings**
3. **Notes Folder:** `content/posts`
4. Salva

Ora GitJournal mostrerà solo i file in `content/posts/`.

---

### Step 4: Configura Frontmatter Template

Crea un template per i nuovi articoli così il frontmatter è sempre corretto.

#### In GitJournal:

1. **Settings** → **Note Settings** → **Default Note Format**
2. Seleziona: **Markdown with YAML Frontmatter**

#### Crea Template Personalizzato

GitJournal permette di personalizzare il frontmatter predefinito. Purtroppo nella versione free è limitato, ma puoi creare un "articolo template" da duplicare:

**Crea file:** `content/posts/_template.md`

```markdown
---
title: "Titolo Articolo"
date: 2025-11-24
draft: true
tags: ["tag1", "tag2"]
categories: ["Categoria"]
description: "Descrizione breve per SEO (150-160 caratteri)"
---

## Introduzione

Testo articolo...

## Sezione 1

Contenuto...

## Conclusioni

Riassunto...

---

**Ti è piaciuto questo articolo?** Lascia un commento! 🚀
```

Quando vuoi creare un nuovo articolo:
1. Duplica `_template.md`
2. Rinomina
3. Modifica contenuto

---

## Workflow: Scrivere e Pubblicare un Articolo

### Scenario: Articolo Veloce in Metropolitana

**Obiettivo:** Scrivere e pubblicare "5 Tips per Stampa 3D" in 20 minuti.

#### Step 1: Crea Nuovo Articolo (1 min)

1. Apri GitJournal
2. **[+]** → **New Note**
3. Nome file: `5-tips-stampa-3d.md`

GitJournal crea il file in `content/posts/`.

---

#### Step 2: Scrivi il Frontmatter (2 min)

```yaml
---
title: "5 Tips per Stampare Meglio in 3D"
date: 2025-11-24
draft: false
tags: ["stampa-3d", "tips", "tutorial"]
categories: ["Stampa 3D"]
description: "5 consigli pratici per migliorare subito le tue stampe 3D. Testati e approvati!"
---
```

**Tip:** Tieni un file `_frontmatter-examples.md` con vari template da copiare.

---

#### Step 3: Scrivi il Contenuto (15 min)

GitJournal ha un ottimo editor Markdown:

- **Preview** in tempo reale (tap icona occhio)
- **Toolbar** con shortcut Markdown
- **Syntax highlighting**

```markdown
## 1. Livella il Piatto Sempre

Prima di OGNI stampa, verifica livellamento.

**Come farlo:**
- Carta A4 sotto il nozzle
- Deve scivolare con leggera resistenza
- Controlla tutti e 4 gli angoli

## 2. Temperatura del Piatto

Non stampare mai PLA con piatto freddo!

- **PLA:** 60-65°C
- **PETG:** 70-80°C
- **ABS:** 90-110°C

[... continua ...]
```

**Pro tip:** Usa le shortcuts della toolbar per formattare veloce!

---

#### Step 4: Aggiungi Immagini (Opzionale)

GitJournal supporta immagini:

1. Durante la scrittura, tap **[📷]** nella toolbar
2. Scegli foto dalla galleria o scatta
3. GitJournal:
   - Copia immagine in `static/images/`
   - Inserisce il link Markdown automaticamente

```markdown
![Livellamento piatto](/images/livellamento-20251124.jpg)
```

⚠️ **Nota:** Assicurati che `static/images/` esista nel repo!

---

#### Step 5: Preview e Controllo (1 min)

1. Tap **👁️** (Preview)
2. Verifica:
   - Frontmatter corretto
   - Markdown renderizzato bene
   - Immagini visibili
   - Link funzionanti

---

#### Step 6: Commit e Push (1 min)

1. Tap **↑** (Sync) in alto a destra
2. GitJournal mostra le modifiche
3. Commit message: "Add: 5 tips stampa 3D"
4. **Push**

🎉 **Fatto!** Articolo su GitHub!

---

#### Step 7: Verifica Deploy (2 min)

1. Apri Netlify app o browser
2. Vai su Dashboard → `1612-blog`
3. Verifica deploy in corso (1-2 min)
4. Una volta verde, visita il sito

**Il tuo articolo è LIVE!** 🚀

---

## Tips Avanzati per GitJournal + Hugo

### 1. Scorciatoie Tastiera (Android)

Se hai tastiera Bluetooth o pieghevole:

- `Ctrl+B` - **Bold**
- `Ctrl+I` - *Italic*
- `Ctrl+K` - [Link]()
- `Ctrl+Shift+C` - `Code`
- `Ctrl+S` - Salva (auto-commit)

### 2. Widget per Quick Note

GitJournal ha widget Android per note velocissime:

1. Home screen → Long press → **Widgets**
2. Trova **GitJournal**
3. Aggiungi "Quick Note"

Tap sul widget = nuova nota istantanea!

---

### 3. Drafts vs Published

Gestione articoli in bozza:

**Metodo A: Draft nel frontmatter**
```yaml
draft: true  # Non verrà pubblicato
```

**Metodo B: Prefisso underscore**
```
_bozza-articolo-futuro.md  # Hugo lo ignora
```

**Metodo C: Cartella separata**
```
content/drafts/  # Non in posts/, non pubblicata
```

Consiglio: usa `draft: true`, più pulito.

---

### 4. Scheduled Posts (Post Futuri)

Hugo può non pubblicare articoli con date future:

```yaml
date: 2025-12-25  # Natale
publishDate: 2025-12-25  # Opzionale, esplicito
```

In `hugo.yaml`:
```yaml
buildFuture: false  # Non builda post futuri
```

Scrivi oggi, pubblica domani automaticamente! 🎄

---

### 5. Immagini: Best Practices Mobile

**Prima di uploadare foto da telefono:**

1. **Riduci dimensioni** - Usa app come:
   - Android: **Photo Compress** (gratis)
   - iOS: **Image Size** (gratis)
2. **Target:** 1200x800px max, <500KB
3. **Rinomina:** `descrittiva-nome-20251124.jpg`

**In GitJournal:**
- Immagini vanno automaticamente in `static/images/`
- Il path è sempre `/images/nome-file.jpg`

---

### 6. Markdown Shortcuts GitJournal

| Sintassi | Risultato |
|----------|-----------|
| `# Titolo` | H1 |
| `## Titolo` | H2 |
| `**testo**` | **Grassetto** |
| `*testo*` | *Corsivo* |
| `` `code` `` | `Codice inline` |
| `> citazione` | Blockquote |
| `- item` | Lista bullet |
| `1. item` | Lista numerata |
| `[testo](url)` | Link |
| `![alt](url)` | Immagine |

---

### 7. Sincronizzazione Automatica

GitJournal può auto-sync:

1. **Settings** → **Git**
2. **Auto Commit**: ON
3. **Auto Push**: ON
4. **Interval**: ogni 5 minuti

Ogni modifica = push automatico! 🔄

⚠️ Consuma batteria, usalo solo se necessario.

---

### 8. Lavorare Offline

GitJournal funziona benissimo offline:

1. Scrivi normalmente
2. GitJournal salva in locale
3. Al prossimo sync → push automatico

**Scenario:** Aereo, tunnel metro, montagna

---

## Workflow Ibrido: Mobile + Desktop

Il setup ideale combina entrambi:

### Mobile (GitJournal)
- ✏️ Bozze veloci
- 📸 Articoli con foto
- 🚀 Post rapidi
- 💡 Cattura idee

### Desktop (VSCode)
- 📝 Articoli lunghi e complessi
- 🎨 Editing immagini avanzato
- 🔧 Configurazione Hugo
- 📊 Articoli con codice/tabelle

**Sincronizzazione:** Git gestisce tutto automaticamente!

---

## Troubleshooting Comuni

### Problema: "Failed to Push"

**Cause:**
- Token scaduto
- Conflitti con modifiche remote
- Permessi insufficienti

**Soluzioni:**
1. Verifica token GitHub (Settings → Developer settings)
2. In GitJournal: **Pull** prima di pushare
3. Rigenera token con permessi `repo` completi

---

### Problema: Articolo Non Appare sul Sito

**Checklist:**
1. ✅ `draft: false` nel frontmatter?
2. ✅ Data corretta (non futura)?
3. ✅ File in `content/posts/`?
4. ✅ Deploy Netlify completato con successo?
5. ✅ Hugo build senza errori?

**Debug:** Controlla log Netlify per errori Hugo.

---

### Problema: Immagini Non Si Vedono

**Cause comuni:**
- Path sbagliato
- Immagine non pushata su GitHub
- Nome file con spazi o caratteri speciali

**Soluzioni:**
1. Verifica path: `/images/nome-file.jpg` (slash iniziale!)
2. Controlla su GitHub se immagine è in `static/images/`
3. Rinomina file: `no-spazi-no-accenti.jpg`

---

### Problema: Frontmatter Non Valido

**Sintomi:** Hugo build fallisce, errori YAML

**Cause:**
- Virgolette mancanti nei titoli con `:`
- Indentazione YAML sbagliata
- Caratteri speciali

**Soluzioni:**
```yaml
# ❌ SBAGLIATO
title: AI: La Guida Completa

# ✅ CORRETTO
title: "AI: La Guida Completa"
```

Sempre quote (`"`) per titoli con caratteri speciali!

---

## Alternative a GitJournal

Se GitJournal non ti convince:

### **Working Copy** (iOS)
- Git client potente
- Editor integrato
- €15 una tantum
- [Link App Store](https://workingcopyapp.com/)

### **MGit** (Android)
- Git client completo
- Gratis e open source
- Richiede editor separato
- [Link GitHub](https://github.com/maks/MGit)

### **Termux + Git** (Android Power Users)
- Terminal completo
- Usa git da CLI
- Hugo CLI anche disponibile!
- Gratis
- [Link](https://termux.com/)

---

## Ottimizzazioni per Hugo + GitJournal

### 1. Archetypes Hugo

Crea template automatici per nuovi post:

`archetypes/posts.md`:
```yaml
---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
tags: []
categories: []
description: ""
---

## Introduzione

## Conclusioni

---

**Ti è piaciuto?** Commenta qui sotto! 🚀
```

### 2. GitHub Actions per Validazione

Aggiungi workflow che controlla articoli:

`.github/workflows/validate.yml`:
```yaml
name: Validate Posts

on:
  push:
    paths:
      - 'content/posts/**'

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Check frontmatter
        run: |
          # Script per validare YAML
          # Controlla date, tags, ecc.
```

### 3. Netlify Deploy Notifications

Ricevi notifica quando l'articolo è live:

1. Netlify → Site settings → Build & deploy
2. Deploy notifications → Add notification
3. Email o Slack quando deploy completa

---

## Statistiche e Monitoring Mobile

### App Utili

**Netlify Mobile App**
- Monitor deploy
- Check build logs
- Instant rollback
- [iOS](https://apps.apple.com/app/netlify/id1456822117) | [Android](https://play.google.com/store/apps/details?id=com.netlify.mobile)

**Google Analytics App**
- Visualizzazioni real-time
- Traffico per articolo
- [iOS](https://apps.apple.com/app/google-analytics/id881599038) | [Android](https://play.google.com/store/apps/details?id=com.google.android.apps.giant)

---

## Pro Tips da Power User

### 1. Template Repository Dedicato

Crea un repo separato con template articoli:

```
templates-lab1612/
├── tutorial-template.md
├── recensione-template.md
├── news-template.md
└── guida-template.md
```

Clonalo anche in GitJournal per copiare template!

---

### 2. Snippet Manager

Usa app come **SnipKit** (iOS) o **Clipboard Manager** (Android) per:

- Frontmatter pre-compilati
- Link frequenti
- Code snippets
- Emoji collections

---

### 3. Voice-to-Text

Dettatura veloce su mobile:

1. Attiva tastiera vocale
2. Parla naturalmente
3. GitJournal trascrive
4. Formatta dopo

**Scenario:** Guida mentre torni a casa, detta l'idea dell'articolo!

---

## Caso Studio: Il Mio Workflow Reale

**Contesto:** Voglio pubblicare "Review Bambu Lab P1S" dopo averla testata.

### Giorno 1 (Mobile - Durante Test)
- **GitJournal:** Creo `review-bambu-p1s.md`
- **Durante stampa:** Annoto impressioni, problemi
- **Foto:** Scatto con telefono, upload diretto
- **Bozza:** 60% dell'articolo scritto in pause

### Giorno 2 (Desktop - Editing)
- **VSCode:** Pull dal repo
- **Editing:** Aggiungo sezioni tecniche
- **Tabelle:** Spec comparative
- **Final touches:** SEO, link affiliati

### Giorno 3 (Mobile - Publish)
- **GitJournal:** `draft: false`
- **Push:** Articolo live in 2 minuti
- **Promo:** Condivido link su social

**Tempo totale:** ~3 ore distribuite su 3 giorni
**Flessibilità:** 100%

---

## Conclusioni

GitJournal + Hugo = **libertà di pubblicare ovunque**.

### Vantaggi Finali

🚀 **Zero Friction** - Dalla idea al publish in minuti
📱 **Mobile-First** - Il tuo blog sempre in tasca
🔄 **Git-Powered** - Versioning, backup, collaboration
⚡ **Deploy Automatico** - Push = live
🆓 **Open Source** - Controllo totale, privacy

### È Per Te Se...

✅ Scrivi spesso in mobilità
✅ Vuoi pubblicare velocemente
✅ Apprezzi workflow Git
✅ Cerchi flessibilità totale
✅ Vuoi indipendenza da piattaforme

### Non È Per Te Se...

❌ Scrivi solo da desktop
❌ Preferisci CMS visuali (WordPress-style)
❌ Non ti va di imparare Git/Markdown
❌ Vuoi editor WYSIWYG completo

---

## Prossimi Passi

Pronto a iniziare?

1. **Installa GitJournal** (10 min)
2. **Connetti il tuo repo Hugo** (5 min)
3. **Scrivi il primo articolo mobile** (20 min)
4. **Pubblica e stupisciti** (2 min)

**Totale:** 37 minuti per rivoluzionare il tuo workflow! 🚀

---

## Risorse Utili

**GitJournal:**
- [Documentazione ufficiale](https://gitjournal.io/docs)
- [GitHub repo](https://github.com/GitJournal/GitJournal)
- [Discord community](https://discord.gg/abcd1234)

**Hugo:**
- [Hugo + Git workflow](https://gohugo.io/hosting-and-deployment/hosting-on-github/)
- [Frontmatter reference](https://gohugo.io/content-management/front-matter/)

**Markdown:**
- [Markdown Guide](https://www.markdownguide.org/)
- [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

---

**Hai già provato GitJournal?** Raccontaci il tuo workflow nei commenti! Come scrivi i tuoi articoli?

**Articoli correlati:**
- [Creare un Blog Hugo da Zero con GitHub](/posts/creare-blog-hugo-github)
- [I Migliori Editor Markdown per Developer](/posts/editor-markdown-developer)
- [Workflow Git per Blogger: Guida Completa](/posts/workflow-git-blogging)

---

*Questo articolo ti è stato utile? Condividilo con altri blogger mobile-first!* 📱✨