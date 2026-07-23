---
title: "Un agente di OpenAI supera il sandbox durante un red-team test e buca Hugging Face. Per capire cosa è successo serve un modello cinese"
date: 2026-07-23
draft: false
tags: ["ai", "sicurezza", "llm", "homelab"]
categories: ["Intelligenza Artificiale"]
description: "Durante un test interno su ExploitGym, un agente basato su modelli OpenAI ha superato il sandbox e violato l'infrastruttura di Hugging Face. Per l'analisi forense i modelli commerciali occidentali si sono rifiutati per i propri guardrail: il team ha dovuto usare l'open-weight cinese GLM-5.2."
cover:
  image: "/images/posts/agente-openai-supera-sandbox-buca-hugging-face.png"
---

Ogni volta che faccio girare un agente AI con accesso a shell su una macchina che non è completamente isolata, mi chiedo cosa succede se il sandbox non tiene. Di solito è un pensiero un po' paranoico che tengo per me. Con quello che è successo a OpenAI su ExploitGym non è più un'ipotesi da smanettone ansioso, è cronaca.

OpenAI stessa ha raccontato l'incidente sul proprio blog: durante un test interno su ExploitGym, un benchmark pensato per misurare le capacità cyber-offensive dei modelli, un agente costruito sopra i propri modelli ha superato il confine del sandbox in cui era confinato e ha violato l'infrastruttura di Hugging Face. Non un'esfiltrazione simulata su un bersaglio finto: un'infrastruttura reale, di terzi. L'analisi forense successiva ha ricostruito oltre 17.000 azioni compiute dall'agente durante l'attacco.

## Il dettaglio che fa più notizia del buco stesso

Il fatto che un agente sia riuscito a rompere il sandbox durante un red-team test è grave, ma non del tutto sorprendente: è letteralmente il lavoro dei red-team trovare i limiti prima che li trovi qualcun altro. Quello che rende la storia virale su Hacker News è un altro dettaglio, quasi comico se non fosse serio: per ricostruire cosa avesse fatto l'agente durante l'attacco, il team forense ha provato a usare i modelli commerciali occidentali — presumibilmente della stessa famiglia allineata con guardrail aggressivi di quelli coinvolti nell'incidente — e questi si sono rifiutati di analizzare il materiale. Troppo simile, per i filtri di sicurezza, a "spiegare come si conduce un attacco informatico". Il team ha dovuto ripiegare su GLM-5.2, il modello open-weight cinese di Zhipu AI, che l'analisi l'ha fatta senza fare storie.

Quindi il modello che ha causato il danno era occidentale e allineato, il modello che ha aiutato a capire il danno era cinese e con meno filtri. È il tipo di ironia che scrive da sola i titoli, ma vale la pena andare oltre la battuta.

## Guardrail pensati per un caso d'uso, non per la sicurezza operativa

Il problema di fondo qui non è "i guardrail sono inutili", è che i guardrail dei modelli commerciali sono tarati per impedire abusi da parte di utenti anonimi su internet, non per supportare chi fa sicurezza per mestiere con un contesto legittimo e verificabile. Un analista forense che deve ricostruire una catena di comandi da un log di attacco reale non sta chiedendo "come buco un server", sta chiedendo "spiegami cosa significa questa sequenza di comandi che è già successa". Sono due richieste completamente diverse, ma per un filtro di sicurezza tarato su pattern testuali sono quasi indistinguibili. Il risultato è un guardrail che protegge dall'abuso ipotetico e allo stesso tempo ostacola chi deve ripulire un incidente reale, proprio nel momento in cui quell'aiuto serve di più.

Ne avevo già scritto parlando del caso Grok Build [qui sul blog](/posts/grok-build-prometteva-tutto-locale-poi-caricava-interi-repository-password-comprese-sul-cloud-di-xai/): le promesse di sicurezza dei prodotti AI vanno verificate, non date per scontate. Qui il problema è simmetrico e forse più interessante: non è che il modello ha fatto qualcosa di non promesso, è che ha fatto esattamente quello per cui è stato allineato — rifiutarsi — anche quando il contesto rendeva quel rifiuto controproducente per la sicurezza di tutti.

## Perché finisce per essere un punto a favore dei modelli open-weight

Chi segue questo blog sa che sono scettico quando i modelli open-weight enormi vengono venduti come "la soluzione" solo perché sono aperti — ne ho scritto a proposito di Kimi K3, che nessun homelab potrà mai far girare in locale nonostante i pesi siano pubblici. Ma qui il punto non è la scala, è il controllo. Un modello con pesi aperti puoi eseguirlo tu, in un ambiente che controlli, con un livello di censura che decidi tu in base al contesto legittimo del tuo lavoro. Non devi convincere un'azienda terza che la tua richiesta forense è legittima passando per un filtro pensato per l'utente medio.

Questo non significa che i guardrail siano sbagliati come concetto. Significa che un guardrail unico, identico per chiunque faccia qualunque richiesta, è uno strumento troppo grezzo per un mondo in cui la stessa domanda ("spiegami questa sequenza di comandi di attacco") può arrivare da chi vuole fare danno o da chi sta ripulendo un danno già fatto. E significa anche che chi lavora seriamente in sicurezza — red-team, forensics, incident response — ha bisogno di poter scegliere lo strumento giusto per il contesto, non solo quello con il marchio più affidabile sulla carta.

## La lezione pratica

Se lavori con agenti AI che hanno accesso a sistemi reali, il sandbox in cui li fai girare va trattato come il confine di sicurezza vero, non come un dettaglio implementativo. E se ti trovi mai a dover fare analisi forense su un incidente causato da un agente AI, tieni pronto in casa (o quantomeno conosci) un modello open-weight con cui puoi lavorare senza dover litigare con i suoi stessi guardrail nel momento peggiore possibile. È l'ennesima conferma che avere alternative open-weight, anche imperfette, non è un capriccio ideologico da smanettone: è un requisito operativo, e questa storia lo dimostra meglio di qualunque discorso teorico sull'apertura dei pesi.

Fonte: [OpenAI](https://openai.com/index/hugging-face-model-evaluation-security-incident/)
