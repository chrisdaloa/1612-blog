---
title: "Ricambi e upgrade per la Flying Bear Ghost 5"
date: 2021-11-15
draft: false
tags: ["stampa-3d", "flying-bear", "manutenzione"]
categories: ["Stampa 3D"]
description: "I ricambi e gli upgrade che ho effettivamente montato sulla mia Flying Bear Ghost 5, con le note su quando conviene sostituirli e perché."
cover:
    image: "/images/ghost5.jpg"
    alt: "I ricambi per la Flying Bear Ghost 5"
    caption: "Tutti i ricambi e gli update utili per la stampante 3d Ghost 5"
    relative: false
aliases:
    - /wp/vecchio-titolo-articolo-wordpress/
    - /pagina-cortesia-temporanea/
---

La Ghost 5 è una stampante solida, ma dopo un po' di ore di stampa qualche pezzo va sostituito, e alcuni upgrade economici cambiano davvero come si comporta la macchina. Questa è la lista dei ricambi e componenti che ho comprato io, con qualche nota su quando ha senso prenderli.

## Hotend ed estrusore

L'hotend è il primo punto da controllare quando iniziano stampe con difetti strani: gocciolamenti, intasamenti, filo che non estrude più in modo costante. Tenerne uno di scorta (completo o a pezzi) evita di fermare una stampa importante per giorni in attesa della spedizione. I nozzle in ottone si consumano più in fretta di quanto si pensi, soprattutto con filamenti abrasivi, quindi un set da 10 costa poco e dura mesi.

- **Hotend completo o a pezzi** - [AliExpress](https://s.click.aliexpress.com/e/_c3QigETT)
- **Nozzle in ottone 0.4mm** (set 10pz) - [Amazon](https://amzn.to/3LXzWX5) | [AliExpress](https://s.click.aliexpress.com/e/_c34nqqHr)

L'estrusore BMG Dual Drive è l'upgrade che consiglio più spesso: la doppia trazione sul filamento riduce gli skip e migliora la costanza dell'estrusione rispetto all'estrusore singolo di serie, soprattutto con filamenti flessibili o particolarmente rigidi.

- **Estrusore BMG Dual Drive** - [Amazon](https://amzn.to/3LPKg3p) | [AliExpress](https://s.click.aliexpress.com/e/_c3Hywh25)

## Parti meccaniche

Cinghie e cuscinetti lineari sono i classici ricambi da tenere pronti: le cinghie si allungano con l'uso e iniziano a dare artefatti sui layer (il classico "ghosting" sulle superfici), i cuscinetti LM8UU con la polvere e i residui di filamento perdono scorrevolezza e rendono i movimenti meno precisi.

- **Cinghie GT2** (set ricambio) - [Amazon](https://amzn.to/4oggimz) | [AliExpress](https://s.click.aliexpress.com/e/_c3xyWZrP)
- **Cuscinetti lineari LM8UU** - [Amazon](https://amzn.to/4p8fUaX) | [AliExpress](https://s.click.aliexpress.com/e/_c3uJrN7n)

Le molle del bed leveling di serie tendono ad ammorbidirsi col tempo, e a quel punto il piatto non tiene più la calibrazione da una stampa all'altra. Sostituirle con molle più rigide è un upgrade da pochi euro che risolve il problema alla radice.

- **Molle bed leveling** (upgrade) - [Amazon](https://amzn.to/48gv9r2) | [AliExpress](https://s.click.aliexpress.com/e/_c4k3Daav)

## Elettronica

Le ventole sono componenti che si guastano senza troppi preavvisi, e quando succede i sintomi sono diversi a seconda di quale si rompe: se cede quella dell'hotend rischi il surriscaldamento della zona calda, se cede quella di layer cooling perdi qualità sugli overhang e sui dettagli fini. Tenerne una di scorta per tipo evita brutte sorprese a stampante già iniziata.

- **Ventola hotend 4010 24V** - [Amazon](https://amzn.to/47YcMbB) | [AliExpress](https://s.click.aliexpress.com/e/_c4VdZBWl)
- **Ventola layer cooling 5015 24V** - [Amazon](https://amzn.to/3JVXbjI) | [AliExpress](https://s.click.aliexpress.com/e/_c3jFL5hL)

Il termistore è quello che segnala alla scheda la temperatura reale dell'hotend: se legge male, la stampante può scaldare troppo o troppo poco senza che te ne accorgi finché non vedi il danno sulla stampa. Costa poco e vale la pena averne uno pronto.

- **Termistor NTC 100K** - [Amazon](https://amzn.to/4ie03Vy) | [AliExpress](https://s.click.aliexpress.com/e/_c39njYNB)

## Piatto di stampa

Sulla superficie di stampa di serie la prima adesione dopo qualche mese di uso intenso peggiora sempre. Una superficie PEI magnetica risolve due problemi insieme: adesione migliore a caldo e rimozione dei pezzi molto più facile una volta raffreddato il piatto.

- **Superficie PEI** (magnetica) - [Amazon](https://amzn.to/3M41LNf) | [AliExpress](https://s.click.aliexpress.com/e/_c411HoM5)

Il vetro borosilicato è l'alternativa per chi cerca una superficie perfettamente piatta e più semplice da pulire, soprattutto con materiali che sul PEI tendono ad attaccarsi troppo.

- **Vetro borosilicato** 220x220mm - [Amazon](https://amzn.to/4ohzwZ3) | [AliExpress](https://s.click.aliexpress.com/e/_c2JnRGgN)

## Upgrade consigliati

Questi due non sono ricambi ma upgrade veri e propri, e sono quelli che consiglierei per primi a chi ha una Ghost 5 stock. Il BLTouch (o il clone CRTouch) automatizza il livellamento del piatto: niente più foglio di carta sotto il nozzle a ogni print, il sensore mappa la superficie e compensa in automatico le imperfezioni.

- **BLTouch / CRTouch** (autolivellamento) - [Amazon](https://amzn.to/449HTif) | [AliExpress](https://s.click.aliexpress.com/e/_c3iA8soV)

La scheda silenziosa con driver TMC2208 sostituisce i driver stepper originali, molto più rumorosi. La differenza di rumore si sente subito, utile se la stampante è in casa e non in un locale a parte.

- **Silent board TMC2208** - [Amazon](https://amzn.to/4ptyN7R) | [AliExpress](https://s.click.aliexpress.com/e/_c3qixSKD)
