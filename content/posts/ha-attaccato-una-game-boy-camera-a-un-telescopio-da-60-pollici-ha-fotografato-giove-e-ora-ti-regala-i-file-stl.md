---
title: "Ha attaccato una Game Boy Camera a un telescopio da 60 pollici, ha fotografato Giove, e ora ti regala i file STL"
date: 2026-07-18
draft: false
tags: ["retro-gaming", "game-boy", "stampa-3d", "astronomia", "open-source", "arduino", "nintendo"]
categories: ["Stampa 3D"]
description: "Chris Graue ha collegato una Game Boy Camera al telescopio Hooker da 60 pollici di Mount Wilson con un adattatore C-Mount stampato in 3D, fotografando Giove con quello che chiama l'obiettivo più lungo mai usato con l'accessorio Nintendo. Ora gli schemi sono open source."
cover:
  image: "/images/posts/ha-attaccato-una-game-boy-camera-a-un-telescopio-da-60-pollici-ha-fotografato-giove-e-ora-ti-regala-i-file-stl.png"
---

{{< affiliate-disclosure >}}

Ho una [Game Boy Camera](https://www.amazon.it/dp/B00002ST2O?tag=16120s-21) in un cassetto da anni, presa più per nostalgia che per uso reale: 128x112 pixel, 4 tonalità di grigio, sensore che nel 1998 era già considerato scarso. Poi leggo che qualcuno l'ha puntata su Giove attraverso un telescopio da 60 pollici e mi tocca rivalutare tutto.

La storia, riportata da [Technology.org](https://www.technology.org/2026/07/10/game-boy-camera-jupiter-telescope-adapter-diy/), è quella di Chris Graue, musicista e regista che nel tempo libero fa esperimenti con hardware retro. Ha collegato la sua Game Boy Camera al telescopio Hooker da 60 pollici dell'osservatorio di Mount Wilson, in California — uno strumento storico, quello con cui Edwin Hubble dimostrò che l'universo si sta espandendo — e ci ha fotografato Giove. Il risultato è quello che lui stesso rivendica come l'obiettivo più lungo mai accoppiato a un accessorio Nintendo. Detto così sembra una barzelletta, ma il punto tecnico dietro c'è davvero.

## Il problema vero non è la Game Boy, è l'adattatore

La Game Boy Camera monta un obiettivo fisso pensato per stare a trenta centimetri dalla faccia di chi gioca. Il sensore, per quanto rudimentale, comunica tramite un connettore proprietario che non ha nulla a che vedere con gli standard ottici usati in astronomia amatoriale o in ambito industriale. Il problema che Graue doveva risolvere non era "come faccio a fotografare Giove", ma "come faccio a far parlare un sensore del 1998 con un focatore da telescopio professionale".

La soluzione è un adattatore stampato in 3D che porta il sensore della Game Boy Camera su un attacco C-Mount, lo standard usato da un sacco di ottiche industriali, telecamere di sorveglianza e — non a caso — parecchi setup di astrofotografia amatoriale con webcam modificate. Una volta che il sensore parla C-Mount, si apre la porta per montarlo su praticamente qualunque telescopio dotato dell'adattatore giusto, incluso un pezzo di storia dell'astronomia come lo Hooker.

Quello che apprezzo di questo progetto è la sequenza logica: non ha comprato un adattatore commerciale che probabilmente non esiste per questa combinazione assurda di hardware, l'ha progettato e stampato lui. È lo stesso ragionamento che faccio io ogni volta che in homelab mi serve un pezzo meccanico introvabile sul mercato: se non esiste, lo disegni in CAD e lo stampi, anche se il risultato serve a un solo scopo molto specifico.

## Perché mi interessa più dell'adattatore che di Giove

Le foto di Giove scattate con 128x112 pixel a 4 livelli di grigio non batteranno mai un sensore CMOS moderno raffreddato, e non è questo il punto. Il punto è che Graue ha rilasciato gratuitamente gli schemi dell'adattatore, permettendo a chiunque abbia una stampante 3D e una Game Boy Camera di replicare l'esperimento senza dover reinventare la parte meccanica più difficile.

Questo è esattamente il tipo di apertura che rende un progetto DIY utile oltre l'aneddoto simpatico. Un file STL open source trasforma "un tizio ha fatto una cosa strana" in "questa cosa strana ora la può fare chiunque abbia accesso a una stampante FDM economica". Cambia la scala del progetto senza cambiarne la difficoltà tecnica per chi lo riusa: il lavoro duro di prototipazione, tolleranze e allineamento ottico è già stato fatto una volta, da lui.

C'è anche un aspetto che trovo sottovalutato in questo genere di hack: la Game Boy Camera resta uno dei pochi accessori retro con un formato di sensore documentato abbastanza bene da permettere questo tipo di riuso trent'anni dopo. Non è un caso che la scena del modding Game Boy sia ancora viva — c'è una community intera dietro reverse engineering di questi sensori, moduli di sostituzione, firmware alternativi. Un progetto come questo si appoggia su quella base di conoscenza condivisa, e la restituisce con l'adattatore open source.

## Cosa mi porto a casa

Non ho un telescopio da 60 pollici in giardino, ovviamente, ma il principio è replicabile su scala molto più modesta: adattatore C-Mount stampato in 3D più webcam o sensore economico più un telescopio amatoriale è una combinazione che gira da anni nell'astrofotografia DIY, proprio perché il C-Mount è uno standard aperto e ben documentato. Quello che Graue ha aggiunto è la variabile nostalgia-hardware, dimostrando che anche un sensore considerato spazzatura tecnologica può ancora fare qualcosa di interessante se lo metti nel posto giusto.

Se hai una stampante 3D che prende polvere e una Game Boy Camera in un cassetto come la mia, gli schemi sono lì, gratuiti. Non ti aspettare foto da rivista scientifica, ma il gusto di vedere un accessorio Nintendo del secolo scorso fare qualcosa che nessuno aveva progettato per farci quello resta il vero motivo per cui vale la pena provarci.
