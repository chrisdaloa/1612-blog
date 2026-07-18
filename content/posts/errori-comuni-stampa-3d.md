---
title: "10 Errori Comuni nella Stampa 3D (e Come Risolverli)"
date: 2024-10-22
draft: false
tags: ["stampa-3d", "tutorial", "troubleshooting", "guida"]
categories: ["Stampa 3D"]
description: "Guida completa ai 10 errori più comuni nella stampa 3D FDM: dalle bolle al warping, scopri cause e soluzioni pratiche per stampe perfette."
cover:
    image: "/images/errori_ghost5.png"
    alt: "Gli errori più comuni nella stampa 3d"
    caption: "Una guida completa per i tuoi errori più comunie nella stampa 3D FDM"
    relative: false
aliases:
    - /wp/flyingbear-ghost-4-e-5-capire-gli-errori/
---

Hai appena lanciato una stampa e dopo ore di attesa il risultato è... un disastro? Non preoccuparti, succede a tutti! In questa guida completa vedremo i 10 errori più comuni nella stampa 3D FDM e, soprattutto, come risolverli definitivamente.

## 1. Warping (Distacco agli Angoli)

### Il Problema
Gli angoli della stampa si sollevano dal piatto durante la stampa, causando deformazioni e possibile fallimento della stampa.

### Cause Principali
- Piatto non livellato correttamente
- Temperatura del piatto troppo bassa
- Mancanza di adesione
- Correnti d'aria nella stanza
- Differenza termica tra base e strati superiori

### Soluzioni
1. **Livella accuratamente il piatto** - Usa il metodo del foglio di carta su tutti e 4 gli angoli
2. **Aumenta temperatura del piatto**:
   - PLA: 60-65°C
   - PETG: 70-80°C
   - ABS: 90-110°C
3. **Usa adesivi**: lacca per capelli, colla stick, nastro Kapton
4. **Aggiungi brim o raft** nello slicer (8-10mm di brim sono ideali)
5. **Chiudi la stampante** in un box se stampi ABS
6. **Pulisci il piatto** con alcool isopropilico prima di ogni stampa

### Prodotti Consigliati
- [Lacca 3DLAC](https://amzn.to/3dlac) - specifica per stampa 3D
- [Piatto PEI magnetico](https://amzn.to/peibed) - adesione ottimale
- [Box per stampante](https://amzn.to/3dbox) - se stampi materiali tecnici

---

## 2. Stringing (Filamenti Volanti)

### Il Problema
Sottili filamenti di plastica tra le parti della stampa, come ragnatele.

### Cause Principali
- Retraction non configurata correttamente
- Temperatura di estrusione troppo alta
- Velocità di travel troppo bassa
- Filamento umido

### Soluzioni
1. **Aumenta retraction**:
   - Direct drive: 1-3mm a 40mm/s
   - Bowden: 4-7mm a 40-60mm/s
2. **Abbassa temperatura** di 5-10°C
3. **Aumenta velocità di travel** a 150-200mm/s
4. **Abilita "combing mode"** nello slicer
5. **Asciuga il filamento** (60°C per 4-6 ore per PLA)
6. **Abilita "Z-hop"** di 0.2-0.5mm

### Test Rapido
Stampa un modello di test per retraction (es. "retraction tower") per trovare i valori ottimali.

---

## 3. Layer Shifting (Spostamento Strati)

### Il Problema
Gli strati si spostano improvvisamente durante la stampa, creando uno "scalino" nel modello.

### Cause Principali
- Cinghie allentate
- Pulegge allentate sull'albero motore
- Corrente motori troppo bassa
- Collisione della testina con la stampa
- Velocità troppo elevata

### Soluzioni
1. **Tensiona le cinghie** - devono essere tese come una corda di chitarra
2. **Controlla le pulegge** - serrare le viti di fissaggio
3. **Regola Vref** dei driver dei motori (solo se sai cosa fai!)
4. **Riduci velocità di stampa** del 20%
5. **Abilita "Avoid crossing perimeters"** nello slicer
6. **Controlla Z-seam** per evitare accumuli

### Prevenzione
Fai manutenzione regolare ogni 6 mesi controllando cinghie e pulegge.

---

## 4. Under-Extrusion (Sotto-Estrusione)

### Il Problema
La stampante estude meno filamento del necessario, creando strati deboli e buchi nelle pareti.

### Cause Principali
- Estrusore che salta passi
- Nozzle parzialmente intasato
- Flow rate troppo basso
- Filamento di diametro non costante
- Temperatura troppo bassa

### Soluzioni
1. **Pulisci/sostituisci il nozzle** - usa un ago da 0.4mm o cold pull
2. **Calibra E-steps**:
   - Marca 120mm di filamento
   - Estrudi 100mm
   - Misura quanto rimane
   - Ricalcola: `nuovo_e-step = vecchio_e-step × (100 / effettivo)`
3. **Aumenta temperatura** di 5-10°C
4. **Aumenta flow rate** del 2-5% nello slicer
5. **Controlla tensione estrusore** - deve afferrare senza schiacciare
6. **Verifica filamento** - deve essere 1.75mm ±0.05mm

### Tool Utili
- [Kit aghi pulizia nozzle](https://amzn.to/needles) 
- [Calibro digitale](https://amzn.to/caliper) per misurare filamento

---

## 5. Over-Extrusion (Sovra-Estrusione)

### Il Problema
Troppo materiale estruso, con blob, superfici ruvide e layer troppo spessi.

### Cause Principali
- Flow rate troppo alto
- E-steps non calibrati
- Temperatura troppo alta

### Soluzioni
1. **Riduci flow rate** del 2-5% nello slicer
2. **Calibra E-steps** (vedi punto 4)
3. **Abbassa temperatura** di 5-10°C
4. **Riduci layer height** se stampi troppo veloce
5. **Stampa test cubo** 20x20x20mm per verificare dimensioni

---

## 6. Elephant Foot (Piede d'Elefante)

### Il Problema
Il primo strato è più largo del resto, creando un "piede" alla base.

### Cause Principali
- Nozzle troppo vicino al piatto
- Primo strato troppo caldo
- Primo strato sovra-estruso

### Soluzioni
1. **Aumenta Z-offset** di 0.05-0.1mm
2. **Riduci temperatura primo strato** di 5°C
3. **Abilita "Elephant foot compensation"** nello slicer (0.1-0.2mm)
4. **Riduci flow primo strato** al 95%
5. **Aggiungi chamfer** di 0.2-0.4mm nel modello (se possibile)

---

## 7. Layer Separation (Delaminazione)

### Il Problema
Gli strati si separano verticalmente, la stampa è debole e si rompe facilmente.

### Cause Principali
- Temperatura troppo bassa
- Scarsa adesione tra layer
- Cooling eccessivo
- Correnti d'aria

### Soluzioni
1. **Aumenta temperatura** di 10-15°C
2. **Riduci cooling** al 30-50% (specialmente per PETG/ABS)
3. **Aumenta layer height** (0.2-0.3mm hanno più adesione di 0.1mm)
4. **Riduci velocità di stampa** del 20%
5. **Chiudi stampante** per evitare correnti

---

## 8. Pillowing (Cuscini sulla Superficie Superiore)

### Il Problema
La superficie superiore presenta bolle o "cuscini" invece di essere piatta.

### Cause Principali
- Infill troppo basso
- Top layer insufficienti
- Cooling inadeguato
- Over-extrusion

### Soluzioni
1. **Aumenta infill** al 20-25% minimo
2. **Aumenta top layers** a 4-6 layer (0.8-1.2mm)
3. **Aumenta cooling** al 100% per gli ultimi layer
4. **Riduci flow** del 2-3%
5. **Abilita ironing** per superfici perfette (opzionale)

---

## 9. Zits e Blobs (Imperfezioni Puntuali)

### Il Problema
Piccole protuberanze casuali sulla superficie esterna.

### Cause Principali
- Z-seam visibile
- Retraction non ottimizzata
- Velocità non uniforme

### Soluzioni
1. **Imposta Z-seam alignment**:
   - "Sharpest corner" per nasconderlo
   - "Random" per distribuirlo
2. **Abilita "Coasting"** (0.2-0.5mm³)
3. **Abilita "Wipe"** (1-2mm)
4. **Aumenta retraction** leggermente
5. **Linear advance / Pressure advance** se hai Marlin 2.0 o Klipper

---

## 10. Clogging (Intasamento Nozzle)

### Il Problema
L'hotend si intasa, il filamento non esce più o esce in modo irregolare.

### Cause Principali
- Filamento umido o di bassa qualità
- Heat creep (calore che risale)
- Nozzle usurato
- Temperatura troppo bassa

### Soluzioni Immediate
1. **Cold pull**:
   - Scalda a 220°C
   - Inserisci nylon o PLA
   - Raffredda a 90°C
   - Tira con forza
2. **Atomic pull** (variante del cold pull)
3. **Pulizia meccanica** con ago

### Soluzioni Preventive
1. **Asciuga filamenti** prima dell'uso
2. **Conserva filamenti** in box ermetico con silica gel
3. **Controlla ventola hotend** - deve essere sempre attiva
4. **Sostituisci nozzle** ogni 500-800h di stampa
5. **Upgrade all-metal hotend** per materiali ad alta temperatura

### Prodotti per Manutenzione
- Essiccatore filamenti
- Box ermetico con igrometro
- Set nozzle di ricambio

---

## Bonus: Checklist Manutenzione Preventiva

Per evitare molti di questi problemi, segui questa routine:

### Ogni Stampa
- ✅ Pulisci piatto con alcool
- ✅ Verifica livellamento (se non hai ABL)
- ✅ Controlla che il filamento scorra liberamente

### Settimanale
- ✅ Pulisci nozzle esternamente
- ✅ Lubrifica assi (solo se necessario)
- ✅ Controlla tensione cinghie

### Mensile
- ✅ Verifica serraggio viti
- ✅ Pulisci ventole
- ✅ Controlla usura nozzle

### Ogni 6 Mesi
- ✅ Sostituisci nozzle
- ✅ Lubrificazione completa
- ✅ Verifica cablaggio

---

## Conclusioni

La stampa 3D richiede pazienza e pratica. Questi 10 errori sono normalissimi, anche per chi stampa da anni! La chiave è:

1. **Osservare** attentamente le stampe
2. **Capire** la causa del problema
3. **Intervenire** con calma, un parametro alla volta
4. **Documentare** cosa funziona per te

Ricorda: ogni stampante è diversa, quindi prendi questi consigli come punto di partenza e adattali al tuo setup!

---

## Hai Altri Problemi?

Lascia un commento descrivendo il tuo problema, magari con foto, e cercherò di aiutarti! La community maker è qui per questo.

**Link utili:**
- [Guida completa allo slicing con Cura](/posts/guida-cura-slicer)
- [I migliori filamenti PLA del 2025](/posts/migliori-filamenti-pla)
- [Upgrade essenziali per la tua stampante](/posts/upgrade-stampante-3d)

---

*Hai trovato utile questa guida? Condividila con altri maker!* 🚀