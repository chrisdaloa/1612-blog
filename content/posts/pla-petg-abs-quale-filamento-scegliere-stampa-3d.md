---
title: "PLA, PETG o ABS: quale filamento scegliere per la stampa 3D"
date: 2026-08-14
draft: false
tags: ["stampa-3d", "materiali", "guida-acquisto", "fdm"]
categories: ["Stampa 3D"]
description: "PLA, PETG o ABS: confronto pratico tra i tre filamenti più usati nella stampa 3D FDM, con pro, contro e quando scegliere l'uno o l'altro."
cover:
  image: "/images/posts/pla-petg-abs-quale-filamento-scegliere-stampa-3d.png"
  alt: "Bobine di filamento PLA, PETG e ABS a confronto per stampa 3D"
---

{{< affiliate-disclosure >}}

"Che filamento uso?" è la domanda che ricevo più spesso da chi ha appena tolto la stampante dalla scatola, più ancora di "quale stampante comprare". E in parte è colpa mia: nella [guida sulle stampanti economiche](/posts/stampanti-3d-economiche-per-iniziare/) do per scontato che si parta dal PLA, ma poi arriva il momento in cui serve un pezzo che regga davvero un carico, o che stia fuori sotto il sole, e lì PLA, PETG e ABS smettono di essere sinonimi intercambiabili di "plastica per stampante".

Ho stampato tonnellate di ognuno dei tre sulla mia Flying Bear Ghost 5, tra pezzi buttati via e pezzi che uso ancora oggi in casa e in garage. Non c'è un vincitore assoluto: c'è il materiale giusto per quello che devi fare, e la scelta sbagliata te la paghi in stampe fallite, warping e ore perse a ricalibrare temperature che non dovevano nemmeno essere un problema.

## PLA: il punto di partenza, non un ripiego

Il PLA (acido polilattico) è il filamento con cui iniziano quasi tutti, e c'è un motivo tecnico oltre a quello di abitudine: stampa bene su qualsiasi macchina, anche la più economica senza piano riscaldato ad alte temperature né enclosure. Temperature di estrusione intorno ai 190-210°C, piatto a 50-60°C, adesione facile su qualsiasi superficie PEI testurizzata. Se hai appena iniziato, il PLA ti lascia concentrarti sul capire lo slicer e la macchina, invece di combattere contemporaneamente anche col materiale.

Il limite vero è la resistenza termica: un pezzo in PLA lasciato in auto d'estate, o vicino a una fonte di calore, si deforma. Ho perso così un portaoggetti per lo specchietto retrovisore, il classico errore da principiante che non rifarei una seconda volta. È anche più fragile del PETG sotto shock e carichi ripetuti: bello per prototipi, decorazioni, miniature, pezzi che non devono sopportare stress meccanico. Per tutto il resto, comincia a stare stretto.

Detto questo, il PLA di oggi non è quello di dieci anni fa. Le versioni "+", tipo PLA Silk o PLA Matte di marchi come Sunlu o eSUN, hanno formulazioni leggermente più tenaci e superfici estetiche notevoli, ma restano PLA nella sostanza: bassa resistenza al calore, fragilità sotto urto. Non aspettarti miracoli solo perché sulla confezione c'è scritto "pro" o "tough".

## PETG: il compromesso che uso di più

Se dovessi tenere una sola bobina sempre pronta sulla stampante, sarebbe PETG. È il materiale che consiglio per qualsiasi pezzo funzionale che non richieda temperature estreme: supporti, staffe, contenitori che stanno all'esterno, pezzi che devono resistere a un urto occasionale senza spaccarsi come farebbe il PLA. Temperature di stampa più alte, 220-250°C, piatto a 70-80°C, ma niente enclosure obbligatoria: lo stampi tranquillamente anche su una macchina a telaio aperto come una [Ender-3](https://www.amazon.it/dp/B07Q7FVZ3C?tag=16120s-21).

Il vantaggio grosso rispetto al PLA è la combinazione di resistenza meccanica e resistenza all'umidità: il PETG è praticamente lo stesso materiale delle bottiglie di plastica (polietilene tereftalato glicolato), quindi tollera bene il contatto con acqua e ambienti umidi, cosa che lo rende la scelta giusta per vasi da esterno, componenti per l'irrigazione, contenitori da garage. Ho un supporto per l'antenna Wi-Fi esterno stampato in PETG che è lì da due anni, sole e pioggia comprese, e non ha ceduto di un millimetro.

Il rovescio della medaglia: il PETG fa più stringing (i filini sottili tra un pezzo e l'altro) se non calibri bene retrazione e temperatura, ed è più difficile da levigare o carteggiare rispetto al PLA per chi fa finiture estetiche. Niente di che, ma va messo in conto se vieni dal PLA e ti aspetti lo stesso comportamento a scatola chiusa.

## ABS: la resistenza vera, ma con qualche pretesa in più

L'ABS è il materiale con cui è stampato mezzo mondo degli oggetti in plastica che hai in casa, dai mattoncini Lego alle cover elettroniche, e da stampante 3D si comporta di conseguenza: resistenza meccanica e termica superiori sia al PLA che al PETG, ottima lavorabilità con acetone per chi vuole levigare le superfici a specchio, temperature di esercizio fino a 90-100°C senza deformarsi. Se il pezzo deve stare vicino a un motore, sotto il cofano di un'auto, o semplicemente in un box esterno che d'estate scalda parecchio, è il caso di puntare sull'ABS.

Il problema è tutto nel processo di stampa. L'ABS ha un warping (il sollevamento e la deformazione degli angoli mentre si raffredda) molto più marcato del PETG, e su una stampante a telaio aperto senza enclosure i pezzi grandi si staccano dal piano a metà stampa con una frequenza che scoraggia. Serve piano riscaldato a 100-110°C, meglio ancora una camera chiusa che mantenga una temperatura ambiente costante, e in più l'ABS in stampa rilascia fumi non proprio piacevoli da respirare: se stampi in un ambiente chiuso senza ventilazione, è un problema reale, non un dettaglio da ignorare.

Chi ha una stampante con enclosure di serie, tipo una [Bambu Lab X1 Carbon](https://www.amazon.it/dp/B0DMPXXSZX?tag=16120s-21) o una [Creality K1](https://www.amazon.it/dp/B0BPSCT7G5?tag=16120s-21), stampa ABS senza troppi drammi. Chi ha un frame aperto come una Ender-3 o una Kobra deve mettere in conto un box di cartone o plexiglass fai-da-te, minimo, oppure passare al fratello più gestibile: l'ASA, che ha proprietà simili ma tollera meglio gli sbalzi termici ed è pensato per resistere meglio ai raggi UV se il pezzo sta all'aperto.

## Il confronto in pratica

Per chi vuole i numeri in un colpo d'occhio:

| | PLA | PETG | ABS |
|---|---|---|---|
| Temperatura ugello | 190-210°C | 220-250°C | 230-250°C |
| Temperatura piatto | 50-60°C | 70-80°C | 100-110°C |
| Enclosure | non serve | non serve | consigliata/necessaria |
| Resistenza agli urti | bassa | media-alta | alta |
| Resistenza al calore | bassa (~60°C) | media (~80°C) | alta (~100°C) |
| Resistenza UV/esterno | scarsa | buona | media (meglio ASA) |
| Facilità di stampa | alta | media | media-bassa |

Se sei alle prime armi e devi solo capire come funziona la stampante, parti dal PLA. Se il pezzo deve funzionare davvero, stare all'esterno o sopportare un uso quotidiano, vai di PETG: è quello che consiglierei come "secondo materiale" a chiunque, prima ancora dell'ABS. Riservo l'ABS ai casi in cui serve davvero la resistenza termica alta e ho una macchina attrezzata per gestirlo bene, altrimenti il rapporto tra fatica e risultato non conviene.

## Un consiglio che vale per tutti e tre

Qualunque materiale tu scelga, la variabile che rovina più stampe non è la temperatura giusta ma l'umidità del filamento. Il PLA la tollera abbastanza bene, ma il PETG e ancora di più il nylon (fuori dal confronto di oggi, ma vale la pena saperlo) assorbono acqua dall'aria e la cosa si vede subito: superfici opache, scoppiettii durante l'estrusione, stringing fuori controllo. Una bobina di PETG lasciata aperta in una cantina umida per un mese stampa visibilmente peggio della stessa bobina appena aperta, a parità di ogni altro parametro. Ho scritto una guida a parte su come riconoscere e risolvere il problema, con tempi e temperature di asciugatura per ogni materiale, nella [guida alla conservazione dei filamenti contro l'umidità](/posts/guida-conservazione-documenti-umidita/), e ne avevo già accennato anche nella guida sugli [accessori essenziali per la prima stampante 3D](/posts/accessori-essenziali-prima-stampante-3d/): una cassetta essiccante con silica gel costa poco e allunga la vita utile di ogni bobina che compri, qualunque sia il materiale.

Se poi ti scontri con problemi di adesione o pezzi che si staccano a metà stampa indipendentemente dal filamento usato, ho scritto anche una guida sugli [errori più comuni nella stampa 3D](/posts/errori-comuni-stampa-3d/) che copre i casi più frequenti al di là della scelta del materiale.
