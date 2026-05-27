---
title: "Stampante FDM che non estrude all'inizio della stampa: cause e soluzioni"
date: 2026-05-26
draft: false

tags: ["stampa-3d", "fdm", "troubleshooting", "estrusione", "primo-layer"]
categories: ["Stampa 3D"]

description: "La stampante scalda, si posiziona, parte — e non esce niente. Quasi sempre c'è una causa precisa. Ecco come trovarla e risolverla."

cover:
    image: "/images/fdm_cover_noestrude_16x9.svg"
    alt: "Stampante FDM non estrude all'inizio della stampa"
    caption: "Nessun filamento al via: le cause più comuni e come risolverle"
    relative: false
---

La stampante scalda il nozzle, porta il piatto in posizione, parte con il primo movimento — e non esce niente. O esce pochissimo, e il primo layer è pieno di buchi. È uno dei problemi più frustranti perché non è sempre ovvio da dove venga.

Le cause più comuni sono due o tre, e quasi sempre la soluzione è semplice una volta capito da dove arriva il problema.

## Causa 1: il filamento è rimasto retratto

Questa è la causa più frequente. Durante il riscaldamento iniziale, lo slicer esegue spesso una retrazione per evitare che il filamento coli mentre il nozzle si sposta alla posizione di partenza. Se il G-code di avvio non include una purgatura prima di iniziare il primo layer, la stampa parte con il filamento ancora indietro di qualche millimetro.

Il risultato è che i primi centimetri — o i primi layer — non hanno materiale, perché l'estrusore sta prima recuperando la retrazione e solo dopo spinge filamento nuovo.

**Soluzione:** aggiungere una linea di purgatura nel G-code di avvio. La maggior parte degli slicer ha questa opzione, o si può aggiungere manualmente. Una linea sul bordo del piatto di 80-100mm è sufficiente per scaricare la retrazione e portare filamento fresco al nozzle prima che parta il pezzo vero.

In Cura si chiama "prime line", in PrusaSlicer è sotto le impostazioni della stampante → G-code di avvio.

## Causa 2: il nozzle è troppo vicino al piatto

Se lo Z-offset è troppo basso, il nozzle è talmente a contatto con il piatto che il filamento non ha spazio per uscire. La pressione si accumula nell'hotend, l'estrusore inizia a skippare, e quando finalmente il nozzle si alza un po' — tra il primo e il secondo layer — arriva tutto insieme.

Si riconosce facilmente: niente al primo layer, poi improvvisamente troppo materiale al secondo.

**Soluzione:** alzare lo Z-offset di 0.05mm alla volta fino a che il primo layer non appare uniforme. Se si usa il livellamento manuale, fare un babystep durante la stampa è il modo più rapido per trovare la quota giusta.

## Causa 3: otturazione parziale

Un'otturazione parziale non ferma l'estrusione completamente, ma la rallenta abbastanza da rendere il primo layer quasi invisibile. Si distingue dalle altre cause perché il problema persiste anche dopo il secondo e il terzo layer — non si risolve da solo.

**Soluzione:** cold pull. Portare il nozzle a temperatura, spingere manualmente del filamento finché non scorre, poi abbassare la temperatura a 90°C (per PLA) e tirare fuori il filamento con un movimento deciso. Ripetere due o tre volte. Se il problema persiste, smontare il nozzle e pulirlo o sostituirlo — [un kit da 20 nozzle in ottone in varie misure](https://www.amazon.it/dp/B0CSG1W23N/?tag=16120s-21) costa meno di 10€ e dura anni.

## Causa 4: temperatura troppo bassa all'avvio

Alcuni profili aspettano che il nozzle raggiunga la temperatura target prima di partire, ma alcuni firmware considerano "raggiunta" la temperatura anche con qualche grado di scarto. Se il filamento non è ancora completamente fuso, l'estrusore fa fatica e nei primi millimetri l'output è irregolare.

**Soluzione:** aggiungere un `M109 S[temperature]` nel G-code di avvio per aspettare che la temperatura sia stabile prima di partire, oppure alzare la temperatura di stampa di 5°C per i primi layer.

## Come capire velocemente quale è il problema

- Il primo layer è vuoto ma il secondo è normale → quasi certamente retrazione non recuperata o Z-offset
- Il problema continua per tutta la stampa → otturazione parziale
- L'estrusore fa click durante i primi movimenti → Z-offset troppo basso o otturazione, l'estrusore skippale passi
- Il filamento arriva a metà del primo layer → retrazione non recuperata, poi il flusso si normalizza

Nella maggior parte dei casi vale la pena iniziare da una buona linea di purgatura nel G-code di avvio: risolve il problema della retrazione e dà anche modo di vedere il flusso prima che parta il pezzo vero.

---

*Alcuni link in questo articolo sono link di affiliazione Amazon. Se acquisti tramite questi link ricevo una piccola commissione, senza alcun costo aggiuntivo per te.*
