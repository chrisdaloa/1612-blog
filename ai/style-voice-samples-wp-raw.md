# Sample di scrittura autentica di cbor — vecchio blog WordPress (1612.it)

Estratti grezzi (puliti solo da shortcode/HTML WordPress, NON riscritti) dai post pubblicati sul vecchio sito, dal 2018 al 2021. Servono come campione di voce autentica per l'humanizer — NON come contenuto da ripubblicare così com'è (sono datati, tecnicamente superati in alcuni punti, e vanno usati solo per calibrare tono/ritmo/lessico).

Esclusi volutamente: i post puramente promozionali (Black Friday, coupon) e un articolo sulle stampanti in resina che ha un tono/lessico chiaramente diverso dagli altri (probabile traduzione/contenuto non originale — frasi come "vibrant", elenchi pro/contro standardizzati, tono da recensione affiliata generica), per non inquinare il campione.

## Note stilistiche osservate (per calibrazione rapida)

- **Apertura diretta**: nessun preambolo. Si parte dal fatto tecnico, dal problema, o da un aneddoto personale ("Qualche giorno fa mi arriva un'email da Google...", "Durante l'offerta lancio ho acquistato un Echo Plus...").
- **Seconda persona/imperativo verso il lettore**: "vediamo come", "se avete un dispositivo sonoff...", "editate il file...". Tono da persona che ti sta spiegando una cosa de visu, non da manuale.
- **Esperienza personale dichiarata esplicitamente**: "nel mio caso", "personalmente uso", "questa è la stampante che possiedo", "io ho impostato 1". Non parla mai in astratto quando ha provato la cosa lui stesso.
- **Frasi brevi alternate a periodi tecnici più lunghi** quando deve spiegare un meccanismo (es. il funzionamento del RETAIN in MQTT, o del sensore rifiuti) — lì il periodo si allunga per necessità tecnica, non per gonfiare.
- **Punteggiatura/typo tipici**: refusi occasionali ("perchè" senza accento, "qual'è" con apostrofo errato, doppie spaziature, "server" per "serve"), non li corregge quasi mai — segno di scrittura vera, non editata a fondo.
- **Sign-off e chiusure informali, mai generiche**: "Buon divertimento!", "Buona flashata.", "BUON DIVERTIMENTO ;)", "Non esistate a commentare". Mai chiusure tipo "in conclusione" o riepiloghi da comunicato.
- **Umorismo secco, spesso autoironico**: "il malintenzionato (che poi ho scoperto essere IO :P)". Uso occasionale di faccine testuali (":P", ";)") più che emoji.
- **Opinioni nette e personali sui prodotti**, mai neutre: "a mio parere le MAXCIO... sono un buon compromesso", "preferisco andare sul sicuro con Amazon", con pro/contro reali anche quando l'articolo è a scopo affiliato (vedi Fire TV Stick: elenca esplicitamente cosa non gli piace prima di dire cosa compra).
- **Ringraziamenti/attribuzioni concrete a persone reali**: "Con il mio amico Carlo che ringrazio...", non fonti vaghe.
- **Niente struttura rigida a schema fisso**: alcuni post sono tre righe (un link e via), altri sono guide step-by-step numerate, altri recensioni con sezioni (unboxing, pro/contro). La lunghezza segue il contenuto, non un template.
- **Comandi/codice inseriti inline nel flusso del discorso**, spiegati riga per riga subito dopo ("L'opzione -r serve per...").

---

## Come ottenere software gratis
*(2018-04-08)*

https://www.1612.it/wp/wp-content/uploads/2018/04/gratis-software-e1359055386530-300x120.jpg
Oggi voglio suggerire il sito Sharewareonsales.com   che pubblica offerte di software sia gratis (completamente gratuite) che in offerta a prezzi bassissimi.
Il sito è sicuro, io stesso lo utilizzo. Non ci sono costi nascosti e non c'è pericolo di virus.
Una volta scelta l'offerta,  è sufficiente inserire l'indirizzo email (dove ricevere il codice di attivazione) e alcune info generiche come l'età e la professione.
Ecco il link: http://www.sharewareonsales.com

---

## Windows in bianco e nero?
*(2018-04-19)*

Windows 10 ha una funzione di filtro del colore integrata. Si rivolge agli utenti che soffrono di daltonismo, ma ha anche un'opzione in scala di grigi che può trasformare il tuo schermo in bianco e nero.
Apri l'app Impostazioni (tasti WIN+I) e cerca "Colore e contrasto elevato".
A ttiva l'opzione "Applica filtro colore".
Dal menu a discesa "Scegli un filtro", seleziona "Scala di grigi".
https://www.1612.it/wp/wp-content/uploads/2018/04/contrasto-windows-300x283.png
Il filtro viene applicato immediatamente e non è necessario riavviare il sistema o uscire e riconnettersi. Può essere disattivato altrettanto facilmente.
Se volte potete usare i tasti rapidi  CTRL+WIN+C.

---

## REDIRECT CON APAHCE E HTACCESS
*(2018-04-24)*

Con Apache è possibile comunicare agli spider dei motori di ricerca che una url è stata modificata, in questo modo la ricerca verrà automaticamente reindirizzata vesro la nuova url.
La tecnica descritta definita definita come"Redirect 301" e funziona su server Apache e si basa sul file .htaccess .
Il vantaggio di questo metodo è quello di poter redirigere un'intera cartella (directory) verso un nuovo indirizzo url.
Esempio 1
Redirigere da www.miosito.com a www.miosito.com/new
Abbiamo il seguente sito www.miosito.com attivo e funzionante. Volgiamo creare il nuovo sito, per esempio con Drupal, senza eliminare il vecchio in modo da preparare le nuove pagine assieme al cliente.
Durante questa fase supponiamo che il nuovo sito venga creato e caricato in www.miosito.com/new.
Al termine della creazione, si ha l'esigenza di rendere visibile unicamente il nuovo sito. Per fare questo si può utilizzare su un server apache la tecnica del redirect.
Creazione del file .htaccess
Creiamo il file .htaccess nella cartella principale di www.miosito.com e all'interno inseriamo il seguente codice
RewriteEngine on
RewriteCond %{HTTP_HOST} ^.*$
RewriteRule ^(.*)$ http://www.miosito.com/new [R=301,L]
In questo modo diciamo al mod_Rewrite di Apache che qualsiasi richiesta al dominio www.miosito.com viene rigirata tramite redirect 301 direttamente l sito www.miosito.com/new
Il Redirect 301 (Moved Permanently) e permanente a differenza del redirect 302 (Moved Temporarily) che è solo temporaneo.
Esempio 2
Redirigere da www.vecchiosito.com a www.nuovosito.com
Abbiamo creato il nuovo sito con dominio www.nuovosito.com.
Vogliamo redirigere gli accessi da www.vecchiosito.com sul nuovo.
Creazione del file .htaccess
Nella cartella principale di www.vecchiosito.com creiamo il file .htaccess e all'interno inseriamo il seguente codice
Options +FollowSymLinks
RewriteEngine on
RewriteRule (.*) http://www.nuovosito.com/$1 [R=301,L]
In questo modo diciamo al mod_Rewrite di Apache che qualsiasi richiesta al dominio www.vecchiosito.com viene rigirata tramite redirect 301 direttamente al nuovo sito www.nuovosito.com.
Esempio3
Redirigere da www.vecchiosito.com/foto a www.nuovosito.com/foto
Abbiamo creato sul sito www.nuovosito.com la cartella foto che contiene un'applicazione (ad esempio la galleria fotografica)
Vogliamo redirigere gli accessi alla galleria fotografica da www.vecchiosito.com/foto sul nuovo.
Creazione del file .htaccess
Nella cartella www.vecchiosito.com/foto creiamo il file .htaccess e all'interno inseriamo il seguente codice
Options +FollowSymLinks
RewriteEngine on
RewriteRule (.*) http://www.nuovosito.com/foto/$1 [R=301,L]
In questo modo diciamo al mod_Rewrite di Apache che qualsiasi richiesta al dominio www.vecchiosito.com/foto viene rigirata tramite redirect 301 direttamente al nuovo sito www.nuovosito.com/foto

---

## Onepaa x2000 NTK96660 Action Camera sport DV 2 K Ultra HD FPV camera built in Gyro Sensor
*(2018-08-30)*

http://www.1612.it/wp/wp-content/uploads/2018/08/417gagCBwyL-300x300.jpg Qualità dell'immagine davvero notevole ed ottimo lavoro della stabilizzazione giroscopica che compensa, nei limiti del possibile, gli ondeggiamenti dei droni senza gimbal, specie quelli con gps soggetti ai continui ondeggiamenti da correzione satellitare. Il montaggio a silent block in dotazione isola efficacemente da vibrazioni ed "effetto jello" e si può anche adattare a fpv camera (tutto l'occorrente è contenuto nella confezione). Settaggio solo via Wi-Fi e app dopo aver collegato l'antennina in dotazione. Provata, per ora, solo in 1080p 60fps con risultati davvero notevoli.
Ho notato che è disponibile presso altri retailer a prezzi sensibilmente più bassi ma preferisco andare sul sicuro con Amazon perché diversamente sarei ancora lì ad aspettare e con parecchie meno garanzie in caso di problemi.
Compralo QUI

---

## Installare Hassbian - Home Assistant
*(2018-11-08)*

In questo tutorial vedremo come installare Home Assistant , in particolare Hassbian , su un Raspberry.
Io utilizzo un vecchio Raspberry Pi B+ (la prima versione) e sebbene non sia il modello più veloce risponde bene ai comandi. Se avete un modello più recente usate quello.
Hassbian è una versione si Home Assistant pre-installata in una distribuzione raspbian. Rispetto ad Hassio fornisce da subito pieno accesso al raspberry tramite shell.
La guida è liberamente tradotta dalla versione ufficiale in inglese .
I passaggi sono:
Scaricare l'immagine di hassbian
Usare Etcher per caricare l'immagine sulla micro-sd (si consiglia una micro-sd da 32GB anche se io sto usando una 16GB e per il momento ho abbastana spazio libero)
Assicurarsi che il raspberry sia collegato a internet tramite rete lan. In caso contrario potete usare il wifi seguendo queste istruzioni (per il momento in inglese, magari farò una guida in italiano più avanti)
Inserire la micro-sd nel raspberry e accenderlo. Si avvierà l'installazione, il sito ufficiale dice che ci vorranno circa 10 minuti, in realtà ce ne potrebbero volere fino a 50 (esperienza personale sul raspberry pi1).
Assicuratevi che il vostro Raspberry sia alimentato in modo appropriato , non collegate il raspberry a prese USB di monitor, tv,computer o modem. Alcuni carica batterie potrebbero non fornire la potenza necessaria. Verificate le caratteristiche tecniche dell'alimentatore.
Dopo il boot iniziale si avvierà automaticamente l'installazione della versione di home-assistant più aggiornata di hassbian-config e di Home Assistant, l'installazione potrebbe richiedere anche 10/15 minuti. Al termine nel terminale del raspberry verrà chiesto di inserire nome utente e password, quelli di default sono nome utente pi e password raspberry .
A questo punto potete avviare il browser e aprire il link http://hassbian.local:8123/ e si aprirà la schermata iniziale di Home Assistant.
Hassbian comprende già:
GPIO pins pronti all'uso
Supporto bluetooth pronto all'uso (non supporta bluetooth LE)
SSH Server già abilitato (con utente e password di default, si consiglia di cambiare la password)
Un tool chiamato hassbian-config
Hassbian rispetto ad Hassio non ha la gestione "grafica" degli addons, che vanno installati a mano tramite il comando hassbian-config. Ad esempio per installare SAMBA basta digitare il comando
$ sudo hassbian-config install samba
Per configurare il wi-fi seguite la guida ufficiale in inglese, magari poi la tradurrò in italiano.
Dettagli Tecnici
Home assistant è installato in un ambiente virutale python in /srv/homeassistant/
Home assistant verrà avviato come un servizio dall'utente homeassistant
La configurazione si trova in /home/homeassistant/.homeassistant
Concludo con il comando per avviare/fermare il servizio di home assistant da terminale:
$ sudo systemctl stop home-assistant@homeassistant.service
potete sostituire la parola stop (che ovviamente ferma il servizio) con:
start per avviare
restart per avviare
status per vedere se il servizio è attivo o meno
Buon divertimento!

---

## Installare Samba su Home Assistant
*(2018-11-08)*

Hassbian, al contrario di Hassio, non ha pre-installato "Samba" pertanto è possibile editare il configurator.yaml solamente dall'editor del terminale di raspberry ( nano o vi ).
Se però volete utilizzare un editor più intuitivo (io ad esempio uso Visual Studio Code), potete installare samba in modo da condividere la cartella.
Per installare samba useremo uno script di installazione
sudo hassbian-config install samba
Lo script ha condiviso, con chiunque in rete, la cartella /home/homeassistant/.homeassistant che contiene i files di configurazione di Home Assitant.
Se vogliamo rendere più sicura la cartella possiamo dare i diritti solo ad un utente. Per farlo dobbiamo editare il file di configurazione di samba
sudo nano /etc/samba/smb.conf
La sezione sarà all fine del file e potete modificarla così:
path = /home/homeassistant/.homeassistant
valid users = homeassistant
read only = no
Abbiamo quindi creato un utente homeassistant che ha accesso alla nostra cartella condivisa
Possiamo quindi impostare una password una per l'utente homeassistant con il comando
sudo smbpasswd -a homeassistant
Ora l'accesso alle cartelle di condivisione sarà possibile solo usando utente e password.

---

## Installare MQTT e Node-red su Hassbian
*(2018-11-09)*

Come installare MQTT su Hassbian
MQTT è un protocollo di connessione IOT su TCP/IP e permette uno scambio di messaggi estremamente veloce e leggero.
Il server MQTT è quello che si definisce un broker sul quale possono essere pubblicati e/o letti quelli che si definiscono topic .
Il primo passo da fare è scegliere quale broker vogliamo utilizzare. La via più semplice e veloce è quella di utilizzare il broker integrato in Home Assistant modificando il configurator.yaml come segue
mqtt:
password: mqttpwd
Così facendo sarete abilitati alla connessione al broker mqtt con username homeassistant e password mqttpwd
In alternativa potete collegare Home Assistant ad un broker MQTT esterno con una configurazione simile alla seguente
mqtt:
broker: IP_ADDRESS_BROKER
Per ulteriori informazioni potete fare riferimento alla guida ufficiale
Come installare NODE-RED su Hassbian
Per installare NODE-RED su Hassbian è sufficiente scrivere questo comando da terminale:
bash
Al termine dell'installazione potrete accedere a node-red dal link http://ip_raspberry:1880
Per ulteriori informazioni potete fare riferimento alla guida ufficiale
http://www.1612.it/wp/wp-content/uploads/2018/11/node-red2-300x118.png

---

## Confronto lampadine smart wi-fi
*(2018-11-12)*

Ho voluto mettere a confronto alcune lampadine smart wifi che utilizzo in casa.
Le lampadine sono queste:
Ho quindi usato il misuratore di consumi Tacklife EM03 e ho testato i consumi.
Questi sono stati i valori rilevati a luce spenta, quindi in condizioni di "riposo".
LOFTER RGB 7W E27
MAXCIO RGB 7W E27
PHILIPS BIANCO 9W
Consumo
0.5 W
0.6 W
0.2 W
Tensione
231.8 V
230.7 V
230.00 V
Corrente
0.008 A
0.009 A
0.006A
Queste invece sono le misurazioni a luce accesa alle maggiori luminosità e "freddezza" concesse dalle lampadine.
LOFTER RGB 7W E27
MAXCIO RGB 7W E27
PHILIPS BIANCO 9W
Consumo
5.2 W
6.6 W
10W
Tensione
231.8 V
230.7 V
231.7 V
Corrente
0.036 A
0.064 A
0.052 A
Luminosità
935 lx
1136 lx
1314 lx
Come ho fatto il test
La luminosità l'ho misurata a parità di condizioni ovvero nello stesso ambiente completamente al buio, lampadina perpendicolare a 40 cm dal telefono che leggeva la luminosità.
Conclusioni
Il consumo da spente è pressochè simile nelle lampadine wifi mentre è nettaente inferiore nella hue.
Da accese invece le LOFTER RGB 7W E27 sono meno luminose ma arrivano ad una "freddezza" di luce superiore, le MAXCIO RGB 7W E27 sono più potenti ma emettono una luce nettamente più calda, le hue PHILIPS BIANCO 9W sono le più potenti delle tre e hanno una luce fredda che non raggiunge la luce "calda" delle altre due.
Le Philips Hue però non sono RGB quindi non possono emettere luce colorata a differenza delle altre due.
Lascio a voi fare i calcoli su quale sia più conveniente, a mi parere le MAXCIO RGB 7W E27 sono un buon compromesso soprattutto se come me le trovate in offerta a 23€ la coppia.

---

## Installare tasmota su un wemos d1 mini
*(2018-11-12)*

In questo articolo vedremo come installare il firmware Tasmota in un Wemos D1 Mini utilizzando l'IDE di Arduino
Download del firmware
Aprite la pagina  https://github.com/arendst/Sonoff-Tasmota/releases  e scaricate il source code (zip) e decomprimete il file zip in una cartella.
Copiate il contenuto della cartella libraries nella cartella libraries di Arudino.
Preparazione dell' IDE di Arduino
Aprite il file sonoff.ino presente nella sotto-cartella Sonoff di Tasmota
Editate il file my_user_config.h indicando i dati di accesso alla vostra rete wifi SSID1 e PASS1 . Tutti gli altri parametri potrete metterli successivamente tramite il pannello web di Tasmota.
Aprite le impostazioni dell' IDE di arduino e aggiungete l'url seguente alle Url aggiuntive per il Gestore schede
http://arduino.esp8266.com/stable/package_esp8266com_index.json
Entrate nel menù Strumenti dell'IDE di Arduino ed impostate la scheda come indicato da questa immagine (al posto di COM4 impostate ovviamente porta COM del vostro Wemos D1 Mini)
Upload del firmware
Dal menù Sketch selezionate Verifica / Compila per verificare il codice e compilare.
Se tutto va bene potete sempre dal menù Sketch selezionare Carica per effettuare l'upload del firmware.
Al termine dell'upload riavviate il Wemos D1 Mini e se avete fatto tutto giusto potete raggiungere il pannello web digitando nel browser l'indirizzo ip del Wemos.
Per sapere qual'è l'indirizzo ip che ha acquisito potete guardare nel pannello di aministrazione del vostro modem oppure da pc usando Advanced IP Scanner oppure dal telefono utilizzando Fing entrambi gratuiti.
Nell'immagine del post trovate la corrispondenza tra i pin del Wemos D1 mini e l'ESP8266.
Buona "flashata".

---

## Fire TV Stick di Amazon: Recensione
*(2018-12-03)*

Se stai cercando un dispositivo di streaming per centralizzare i tuoi media e sta i considerando un Amazon Fire TV Stick tra le opzioni, allora questa pagina fa per te.
Qualche giorno fa ho comprato un Amazon Fire TV Stick.
Sono abbonato a diversi servizi di streaming e ho un NAS Sinology che uso per archiviare i miei film in locale.
Cercavo qualcosa che potesse rendere tutti i miei contenuto disponibili sul tv attraverso un singolo strumento.
Stavo valutando anche l'acquisto di un Chromecast ma volevo qualcosa che non mi facesse dipendere dal mio telefono come avviene con il Chromecast .
L' Amazon Fire TV Stick infatti è uno strumento che centralizza i tuoi servizi di streaming (Netflix, Hulu, Amazon Prime Video, Plex, etc..) e li rende disponibili sul tuo tv attraverso un'unica interfaccia.
Dopo averlo usato per alcuni giorni, ho pensato che potesse essere interessante pubblicare una recensione del Fire TV Stick di Amazon.
In questa recensione vedremo:
L'unboxing
L'installazione
L'interfaccia utente e remota
Le cose che non mi piacciono
Le cose che mi piacciono
Considerazioni finali
Prima di entrare nel dettaglio devo dirti che L'Amazon Fire TV Stick non arriva al 4K , se quello che cerchi è uno strumento 4k allora dovresti valutare la versione 4K Ultra HD (che però in Italia non è disponibile al momento in cui scrivo)
UNBOXING
Il pacco arriva a casa velocemente secondo gli standard di Amazon. La confezione è ben curata e una volta aperta troviamo al suo interno:
Il Fire TV Stick (ovviamente)
Un telecomando bluetooth
Un cavo USB con presa a muro (non alimentate dall'USB del TV)
Prolunga HDMI
3 batterie AAA per il telecomando
Le pile sono sempre molto apprezzate in questi acquisti perchè permettono di usare subito il dispositivo, odio quando arrivano oggetti elettronici privi di batterie.
Tutti i compomnenti appaiono di alta qualità, tutto sembra robusto ma solo il tempo potrà dirlo. Eventualmente aggiornerò questa recensione in futuro man mano che utilizzerò il Fire TV Stick.
INSTALLAZIONE
L' installazione è semplice e non richiede particolari spiegazioni, venite guidati passo passo dal momento in cui avvierete la TV sulla sorgente HDMI in cui avete collegato lo stick.
La vostra rete wifi viene riconosciuta immediatamente, se avete una password lunga e complicata armatevi di pazienza perchè dovrete usare una tastiera virtuale sullo schermo.
Dopo aver collegato il wifi lo stick si aggiornerà e vi chiederà i dati con cui siete registrati ad Amazon.
Ona cosa interessante è che il Fire TV Stick arriva preconfigurato con il tuo account Amazon così i passaggi di configurazione sono più veloci e facili.
Dopo aver configurato il dispositivo passiamo all'installazione delle app e dei servizi di streaming.
INTERFACCIA UTENTE E REMOTA
Il telecomando è davvero semplice , ha i pulsanti necessari a spostarsi tra le voci, selezionare, tornare indietro ed entrare nelle opzioni. E' molto semplice da usare, di contro però diventa un po' lunga la procedura di scrittura nei campi di ricerca.
Per ovviare questo motivo potete usare una tastiera bluetooth
Nella schermata iniziale potete trovare tutti i servizi che offre la Fire TV Stick anche se per i miei gusti c'è troppa roba, avrei semplificato un pochino. Ovviamente i contenuti di Amazon sono messi un po' in risalto, ma non troppo.
COSE CHE NON MI PIACCIONO
Premesso che il Fire TV Stick mi ha entusiasmato non poco, sono poche le cose che non mi piacciono particolarmente e vorrei iniziare con queste.
La prima è che non puoi controllare il volume dal telecomando del Fire TV Stick, dovrai per forza usare il telecomando del tv. In questo Amazon dovrebbe prendere esempio da Roku e Chromecast che hanno questa possibilità.
Un' altra cosa che non mi entusiasma molto è la schermata principale dove vengono messi in evidenza i contenuti di Amazon (questo era prevedibile) ma soprattutto vengono mostrati anche contenuti a servizi ai quali non sei abbonato.
Avrei preferito una schermata più pulita.
Un'altra cosa spiacevole è dovuta alla "battaglia" che si stanno combattendo Amazon e Google: Youtube non sarà più tra le app disponibili per il Fire Stick TV, quindi se volete usare youtube dovete usare un browser (ad esempio Firefox) che non è il massimo della praticità (oppure installare l'app non ufficiale).
COSE CHE MI PIACCIONO
Dopo le cose "brutte" veniamo alle piacevoli!
Il primo vantaggio è che il Fire TV Stick di Amazon girà su android, quindi è possibile installare i propri APK abilitando le sorgenti sconosciute (come si fa sul cellulare). Attenzione però che le app devono essere compatibil i.
L'hardware sul Fire TV è abbastanza valido da far girare KODI con i suoi addon.
I films sono fluidi, anche quelli con codec H265 .
L'ultima cosa positiva è la possibilità di collegare direttamente al Fire TV  Stick auricolari o cuffie bluetooth così potete avere guardare i vostri film anche se in casa qualcuno dorme.
CONCLUSIONI
Secondo me vale i soldi spesi, soprattutto se come me lo prendete quando è in offerta (io l'ho pagato 29,99€ durante il black friday).
A conti fatti però solo tu puoi sapere se è utile oppure no per te.
Qui sotto trovi un riassunto dei pro e dei contro.
PRO
CONTRO
Android OS
Controllo volume (dal telecomando non è possibile)
Un buon hardware (Kodi gira buono)
Pagina Home un po' confusionaria
Possibilità di connettere altoparlanti bluetooth
Youtube, non esiste un'app nativa
Sicuramente comprare un Fire TV Stick non sarà un errore, ha un rapporto qualità prezzo davvero ottimo.
Inoltre se hai già un ecosistema Alexa ti sarà molto comodo avere un dispositivo in più con cui impartire ordini.
Se alla fine di tutte queste considerazioni pensi che il Fire TV Stick possa fare al caso tuo puoi acquistarlo direttamente da Amazon.
Se invece non ti interessa puoi valutare l'acquisto del suo miglior concorrente Roku.
Spero che questa recensione ti sia stata utile e ti invito a lasciare commenti e feedback qui sotto.

---

## Come resettare le lampadine Philips Hue
*(2018-12-06)*

Durante l'offerta lancio ho acquistato un Echo Plus (quindi con Hub Zigbee integrato) insieme alle lampadine Philips Hue che si sono accoppiate perfettamente.
Avevo però il problema di non poter comandare le lampadine direttamente da Home Assistant. Mi sono così procurato una di quelle chiavette USB che se programmate a dovere fanno da gateway zigbee (a breve pubblicherò una guida) con l'intento di collegarle direttamente in Home Assistant.
Mi sono scontrato però con il problema di doverle scollegare da Alexa per poterle accoppiare con il mio nuovo HUB Zigbee. Siccome non hanno un pulsante di reset vediamo come si possono resettare le lampadine Philips Hue in modo da poterle accoppiare con un altro dispositivo.
Al momento ci sono due modi per resettare le lampadine Philips Hue: usando un dimmer switch oppure,  utilizzando l'app di Alexa se non avete e non volete comprare il dimmer switch.
Ecco le istruzioni fornitemi direttamente dalla Philips:
Resettare con dimmer switch:
vicino alla lampadina 5cm di distanza schiacci allo stesso tempo 1-0;
la lampadina lampeggierà 3 volte.
aspetti un momento e associ le lampadine con il dimmer switch (5 cm dalla lampadine ) schiacci 1 .
Reset con l'applicazione Alexa:
Aprite l'app Alexa
Cliccate sull'icona Home in basso a destra
Cliccate sul simbolo "+" e poi su Aggiungi dispositivo
Cliccate sull'icona con il logo Philips Hue
Cliccate sul simbolo "?" in alto a destra
Sfogliate la guida fino alla voce "RESETTA LAMPADINA PHILIPS HUE"
Cliccate ora su "RESETTA LAMPADINA PHILIPS HUE"
Nel campo in alto inserite il numero seriale di 6 cifre presente sull'adesivo nella base della lampadina e premete "CONTINUA"
La lampadina inizierà a spegnersi ed accendersi per poi rimanere accesa, a questo punto sarà nuovamente rilevabile e associabile ad Echo Plus tramite app Alexa o con altro Hub Zigbee.

---

## Soluzione al problema del sonoff che si attiva alla connessione
*(2019-01-02)*

Se avete un dispositivo sonoff e lo avete "flashato" con il firmware tasmota, vi sarà probabilmente capitato di avere un comportamento anomalo in caso di riconnessione alla rete wifi piuttosto che al server MQTT.
Per capire come risolvere il problema bisogna capire prima qual'è la causa.
La causa principale è il RETAIN, ovvero l'opzione configurabile per i topic di MQTT che permette di mantenere in memoria l'ultimo stato del topic e di richiamarlo nel momento in cui un device si riconnette, magari inseguito ad un riavvio. Probabilmente durante le prime configurazioni di prova è stato attivato il topic che poi è rimasto attivo all'interno del broker MQTT.
Se vogliamo che al momento della riconnessione del SONOFF, non venga effettuata nessuna operazione (quindi che il dispositivo mantenga lo stato attuale), è necessario configurare il retain: false ma è assolutamente necessario andare a cancellare i topic che sono memorizzati in MQTT.
Vediamo come fare, questo esempio si basa su un'installazione di HASSBIAN e MOSQUITTO ma su altre installazioni la logica è la stessa. Se avete HASSIO o non avete accesso al terminale del raspberry andate alla seconda parte dell'articolo per vedere come fare
Nel mio caso il sonoff con tasmota collegato alla stampante 3d si accendeva ad ogni perdita di connessione e riconnessione.
Per prima cosa bisogna riconfigurare gli switch MQTT su Home Assistant impostando retain: false .
Accedete via terminale al raspberry e digitate il comando seguente, server per visualizzare quali sono i topic attivi inerenti Tasmota.
sudo mosquitto_sub -t stat/# -t tele/# -t cmnd/# -v -u iltuoutente -P latuapassword
Il risultato sarà qualcosa di simile al seguente:
Il topic incriminato è quello che inizia per "cmnd" ovvero il comando che arriva da Home Assistant per accendere/spegnere il dispositivo.
Una volta trovato il topic incriminato potete cancellarlo semplicemente inviando un payload "vuoto" ovvero senza valori. Per farlo potete usare questo comando:
sudo mosquitto_pub -t cmnd/stampante3d/POWER -r -n -u iltuoutente -P latuapassword
Analizziamo il comando:
L'opzione -r server per assegnare il RETAIN al topic
L'opzione -n server per passare il payload null cioè vuoto
L'opzione -u serve per passare il nome utente di Mosquitto
L'opzione -P serve per passare la password di Mosquitto
Ovviamente se non avete impostato utente e password in Mosquitto potete omettere le opzioni -u e -P
A questo punto scrivete di nuovo il comando per visualizzare i topic attivi
sudo mosquitto_sub -t stat/# -t tele/# -t cmnd/# -v -u iltuoutente -P latuapassword
Il risultato questa volta sarà simile al seguente, senza il topic cmnd .
Se provate ora a far perdere connessione al vostro sonoff vedrete che alla riconnessione non farà nessuna operazione.
Se per caso richiamate il topic cmnd da altri software (mqtt dasboard, node-red, etc..) assicuratevi che il retain sia false .
Aggiornamento del 04/01/2019: aggiungo questa parte per chi ha HASSIO con l'MQTT embedded.
Chi ha installato Hassio e ha il broker MQTT embedded e magari non ha nemmeno accesso al terminale del Raspberry, ovviamente on può usare i comandi di Mosquitto.
E' possibile comunque cancellare i topic utilizzando un client MQTT che lo consenta, io ho usato un' app di Chrome che si chiama MQTT LENS .
Installatelo, cliccate sul "+" accanto a CONNECTIONS e configurate la connessione al vostro broker MQTT
Effettuate la sottoscrizione al topic cmnd/#
In basso vi visualizzerà i topic cmnd attivi nel vostro broker MQTT
Cancellateli uno per uno inviando un payload null (vuoto) e selezionando la casella "retain"
Dopo che li avete cancellati tutti, ripetete la sottoscrizione al topic cmnd/# come avete fatto prima. Io ho cancellato solo il primo e rifacendo la sottoscrizione non lo vedo più
Dovreste così riuscire a cancellare i topic cmnd/# che se rimangono attivi vengono richiamati ad ogni riconnessione del Tasmota.

---

## Home Assistant - Sensore raccolta rifiuti
*(2019-05-27)*

Con il mio amico Carlo che ringrazio ci siamo domandati come poteva Home Assistant aiutarci a ricordare quale tipologia di rifiuti è in raccolta quindi fondamentalmente quale bidone dobbiamo preparare per la raccolta.
Noi abbiamo optato per sfruttare quello che già ci mette a disposizione Home Assistant senza andare ad installare componenti customs.
Il risultato che otterremo è questo:
Le cose da fare sono solamente 3:
Creare un'immagine per ogni tipologia di rifiuto da ritirare, ad esempio un bidone giallo per la plastica, un bidone nero per l'indifferenziata etc. Noi vi forniremo alcune immagini ma voi siete liberi di crearvi le vostre. Se invece volete usare le nostre e vi manca qualche colore o qualche abbinamento di colori fateci richiesta qui sotto che provvediamo a realizzarle.
Creare un sensore "template" che viene valorizzato con il numero del giorno della settimana, noi lo abbiamo chiamato "Rifiuti"
Creare una card che mostra le informazioni relative al giorno del sensore "Rifiuti"
1. Le immagini che abbiamo creato le trovate qui , scaricate lo zip, estraete il contenuto e mettete la cartella "rifiuti" nella cartella corrispondente al percorso "local" della vostra installazione di Home Assistant, nel mio caso è \\indirizzo_ip_raspberry\homeassistant\www\rifiuti
2. Creiamo il sensore "Rifiuti" nella sezione sensor: del file configuration.yaml (purtroppo qui va a capo, cliccate il "+" nel blocco di codice in alto a destra per espandere)
sensor:
- platform: template
sensors:
rifiuti:
friendly_name: "Rifiuti"
icon_template: mdi:delete-restore
value_template: "
{% if (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '1' %} Indifferenziato
{% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '2' %} Plastica e umido
{% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '3' %} Indifferenziato
{% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '4' %} IUmido
{% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '5' %} Umido
{% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '6' %} Niente
{% elif (now().timestamp() | int - (11*60*60)) | timestamp_custom('%w') == '0' %} Carta e umido
{% endif %}
"
entity_id: sensor.date_time
3. Creiamo nel file ui-lovelace.yaml una card di tipo picture-entity , posizionatela dove ritenete opportuno stando attenti a rispettare l'indentatura
- type: picture-entity
entity: sensor.rifiuti
name: "Rifiuti da mettere fuori"
aspect_ratio: 16x10
tap_action: none
state_image:
"Niente": /local/rifiuti/niente.svg
"Plastica e umido": /local/rifiuti/giallomarrone.svg
"Indifferenziato": /local/rifiuti/nero.svg
"Carta e umido": /local/rifiuti/biancomarrone.svg
"Umido": /local/rifiuti/marrone.svg
Questo è quanto per creare il sensore e mostrarlo nella vostra UI.
Cerchiamo di capire cosa fa il codice del value_template in modo che possiate personalizzarlo secondo le vostre esigenze
Tutto è incentrato su questa riga
(now().strftime('%s') | int - (11*60*60)) | timestamp_custom('%w') == '1'
In pratica leggiamo l'orario attuale in secondi con l'istruzione
(now().strftime('%s')
Togliamo 11 ore (calcolate in secondi) con l'istruzione
int - (11*60*60))
Questo mi permette di far "cambiare" il valore del sensore alle 11:00 del mattino.
Questo perchè nella mia città il ritiro dei rifiuti è previsto al mattino in un orario variabile che va dalle 06:00 alle 11:00 e il sensore impostato in questo modo mi permette di sapere cosa devo predisporre per il conferimento se mi trovo tra le 11:01 del giorno precedente al conferimento alle 10:59 del giorno del conferimento.
L'ultima istruzione invece trasforma in numero del giorno della settimana, la data in secondi derivata dal calcolo precedente.
timestamp_custom('%w')
L'ultima parola di ogni singola istruzione, ad esempio "Indifferenziato" o "Plastica e umido" è il valore che verrà visualizzato nella UI e quello che comanda l'immagine da visualizzare.
L'ultima riga del sensore template invece indica al sensore che si deve aggiornare ad ogni aggiornamento de sensore date_time quindi ad ogni cambio di orario.
entity_id: sensor.date_time
Passiamo ora ad analizzare la UI. Le prime 5 righe credo non abbiano bisogno di spiegazione.
Nello state_image invece stiamo dicendo alla card quale immagine visualizzare in base allo stato del sensore, ovvero
niente.svg se il sensore è uguale a "Niente",  giallomarrone.svg se "Plastica e umido" e così via.
state_image:
"Niente": /local/rifiuti/niente.svg
"Plastica e umido": /local/rifiuti/giallomarrone.svg
"Indifferenziato": /local/rifiuti/nero.svg
"Carta e umido": /local/rifiuti/biancomarrone.svg
"Umido": /local/rifiuti/marrone.svg
Questo è quanto, spero vi sia utile. Non esistate a commentare o a chiedere ulteriori info.

---

## [SICUREZZA] Tentativo login fallito, sei tu?
*(2020-02-20)*

Qualche giorno fa mi arriva un email da Google dicendomi che qualcuno aveva provato ad accedere alla mia email, nella stessa comparivano le informazioni del malintenzionato (che poi ho scoperto essere IO :P ), a quel punto mi sono chiesto se fosse stato possibile implementare qualcosa di simile per il nostro caro Home Assistant e la risposta è SI.
Prerequisiti: Integrazione Telegram
Ora vedremo come farci inviare una notifica tramite Telegram con tanto di informazioni del malintenzionato.
Aggiungiamo questo codice nel file: “automations.yaml”
- id: "notifytelegramLoginFail"
alias: "Login fallito"
trigger:
platform: state
entity_id: persistent_notification.http_login
condition:
- condition: template
value_template: "{{ trigger.to_state.state != 'None' }}"
action:
- service: notify.telegram
data:
title: "*LOGIN FALLITA*"
message: "\U000026A0 {{as_timestamp(now()) | timestamp_custom('%d/%m/%Y - %T', True) }} | Tentativo di login fallito, sei tu? https://www.1612.it/haic/?ip={{ states.persistent_notification.http_login.attributes.message.split('from ') [1]}}"
- service: persistent_notification.dismiss
data:
notification_id: http_login
Ora basterà riavviare le automazioni ed il gioco è fatto. Se proverete a loggarvi con delle credenziali errate vi arriverà una notifica su Telegram come questa.
Premendo sul link della notifica vi si aprirà una pagina come questa:
dove compariranno tutte le informazioni relative al malintenzionato che ha provato a loggarsi al vostro Home Assistant.
BUON DIVERTIMENTO ;)

---

## Ricambi e Upgrades Flying Bear Ghost 5
*(2021-03-26)*

Ecco qui di seguito un elenco dei ricambi e upgrades testati per la Flying Bear Ghost 5
Prima di procedere voglio offrirti uno sconto del 10% sui prodotti Eryone con spedizione gratuita a partire da 22€. Clicca sul logo a sinistra e inserisci il coupon SCONTO10 nel carrello.
Iscrivi al canale telegram per ottonere i migliori sconti sulla stampa 3D https://t.me/best3ditalia

---

## FlyingBear Ghost 4 e 5: capire gli errori
*(2021-11-17)*

Qui di seguito trovate l'interpretazione degli errori che possono comparire sul display delle Flying Bear Ghost 4 e 5:
Err1 : il letto termico supera il limite massimo di temperatura. Verificare se l'interfaccia termica è in corto.
Err2 : la testina di stampa supera il limite massimo di temperatura. Verificare se l'interfaccia termica è in corto.
Err3 : il letto caldo supera il limite minimo di temperatura. Verificare se l'interfaccia termica è disconnessa.
Err4 : la testina di stampa supera il limite di temperatura minima. Verificare se l'interfaccia termica è disconnessa.
Err5 : il riscaldamento dell'ugello non riesce, se l'ugello non raggiunge la differenza di temperatura impostata entro il tempo impostato, viene segnalato un errore; controllare le impostazioni del file di configurazione o verificare che l'alimentazione sia sufficiente
Err6 : il letto di riscaldamento non riesce a riscaldarsi. Se il letto di riscaldamento raggiunge la differenza di temperatura impostata entro il tempo impostato, viene segnalato un errore; controllare le impostazioni del file di configurazione o verificare che l'alimentazione sia sufficiente
Err7 : fuga termica; quando la temperatura sale alla temperatura target, la temperatura corrente è inferiore alla temperatura target e supera la temperatura impostata entro il tempo impostato, viene segnalato un errore; si prega di verificare se la sensibilità termica è normale o se il valore PID è appropriato.

---

## Riscaldatore per stampanti a resina
*(2021-12-02)*

Oggi voglio presentarvi questo progetto che ho trovato in rete e che ho realizzato per la mia stampante a resina Voxelab Proxima 6.0
A causa dell'odore della resina, ho preferito mettere la stampante in un garage, dove però in questo periodo (novembre) ci sono circa 10° mentre la resina necessità di una temperatura di 25-30° per essere stampata.
Come potete vedere da questa immagine, in garage ho 12° mentre all'interno della cupola della stampante la temperatura è intorno ai 28°.
La realizzazione è abbastanza semplice, servono il box stampato (qualcuno lo stampa in resina, io ho stampato in PETG, forse l'ABS sarebbe ideale), un riscaldatore da 12V e 100W e un termostato con sonda che permetta di mantenere la temperatura.
Cosa serve
Potete prendere un riscaldatore 12V e 100W come questo in foto da Amazon o da Aliexpress
Un termostato 12V W1209WK regolabile con sonda esterna e interruttore come questo in foto da Amazon o da Aliexpress
I files STL da stampare scaricabili da Thingiverse
Un alimentatore 12V e 10A da Amazon o da Aliexpress
Connettori maschio/femmina per l'alimentazione da Amazon o Aliexpress (io non li ho usati, ho collegato con i capicorda)
Assemblaggio
L'assemblaggio è relativamente semplice:
nel primo connettore del termostato va il cavo positivo (rosso) dell'alimentatore nel secondo e terzo connettore del termostato va il negativo dell'alimentatore, io ho ponticellato con un cavo, non fate l'errore di usare un puntalino a U perchè sfregando sul connettore alla lunga lo scioglie. nel quarto connettore va uno dei due cavi del riscladatore (è una resistenza quindi non ha positivo e negativo), l'altro cavo del riscaldatore va insieme al positivo dell'alimentatore i due cavi della ventola vanno collegati all'alimentatore in modo che la ventola sia sempre accesa quando montate la vendola sul box, ricordatevi che il lato con l'adesivo va verso il riscaldatore, in pratica una volta montato voi vedete il lato senza adesivo della ventol
Mi raccomando, fate attenzione ai collegamenti, devono essere ben serrati e non "ballare".
Configurazione termostato
Una volta effettuati i collegamenti possiamo passare alla configurazione del termostato.
Come prima cosa impostate i gradi Celsius o Fahrenheit premendo il pulsante basso del termostato °C/°F
Quindi dobbiamo calibrare la temperatura usando come riferimento un normale termometro:
Leggete la temperatura sul normale termometro, la chiameremo T1 Leggete la temperatura sul termostato (il valore più alto), la chiameremo T2 Ora fate T2 - T1 e otteniamo T3, memorizzatevi questo valore Tenete premuto il pulsante SET del termostato per entrare in modalità programmazione fino a quando sentite un BEEP e vedete comparire P0 sul display (tente a mente questa procedura perchè dovremmo ripeterla per entrare in modalità programmazione) Premete SET di seguito finchè sul display non compare P4, quindi premete contemporaneamente entrambi i pulsanti del termostato, inizierà a lampeggiare il secondo valore del termostato. Attenzione: quando siete in modalità programmazione nel termostato, se non fate niente per 5 secondi la modalità torna normale e dovete ripetere i passaggi. Premendo i due tasti del termostato impostate il secondo valore del display con la temperatura T3 che avete memorizzato prima Rientrate in modalità programmazione tenendo premuto SET, quando compare P0 premete SET 2 volte fino ad arrivare a P2, quindi premete entrambi i pulsanti contemporaneamente e impostate la temperatura di sicurezza oltre il quale il termostato non riscalderà, io nel mio ho messo 37. Aspettate 5 secondi per uscire dalla modalità programmazione. Rientrate in modalità programmazione tenendo premuto SET, quando compare P0 premete SET 1 volte fino ad arrivare a P1, questo indicherà la differenza tra valore impostato e valore reale che farà attivare o meno il riscaldatore, di default è impostato a 2, io ho impostato 1. Solita procedura, premete entrambi i pulsanti contemporaneamente per poter modificare il valore. Attendete 5 secondi per uscire dalla modalità programmazione. Rientrate in modalità programmazione tenendo premuto SET, premete una volta SET per arrivare a P1, premete entrambi i pulsanti e imposate il valore su H per far funzionare il termostato come un riscaldatore (su C funziona come un raffreddatore). Attendete 5 secondi per uscire dalla modalità di programmazione.
A questo punto il vostro riscaldatore è pronto e dovete solo trovare il modo di adattarlo alla vostra stampante. Se siete fortunati potete usare delle calamite da 5mm di diametro altimenti dovete trovare un supporto per la vostra stampante (io ho il supporto per la Proxima se vi serve chiedetelo nei commenti, a breve sarà su Thingiverse) o ingegnarvi un pochettino.
Personalmente sto usando questo riscaldatore da un mese e non ho avuto grossi problemi, sono arrivato a lasciarlo acceso 12h. La temperatura della cupola sul lato dove è più vicina al riscaldatore non supera i 55°. Prima del PETG ho provato il PLA e ha resistito bene, sono passato al PETG per sicurezza.
Piccoli accorgimenti
Vi consiglio comunque prima di inserirlo nella stampante, di lasciarlo accesso diverse ore in un posto "sicuro" in modo da verificare che tutto funzioni a dovere. Dopo aver inserito la resina nella VAT, accendete il riscaldatore, mettete la cupola e lasciate riscaldare per circa 30 minuti Trovate la vostra temperatura migliore in base alle specifiche della resina, qualcuno consiglia in questi casi di stare 3-4° più alto,
Infine vi lascio un video (non mio) dove potete vedere il montaggio e la calibrazione
Links al materiale che ho utilizzato
Riscaldatore - PTC Heater 12V 100W - Aliexpress - Amazon Termostato W1209WK 12V con sonda e interruttore - Aliexpress - Amazon Alimentatore 12V 10A - Aliexpress - Amazon (in genere conviene su Amazon) Connettori maschio/femmina 12V - Aliexpress - Amazon (io non li ho utilizzati) Calamite 5x2mm - Aliexpress - Amazon (se avete la struttura in metallo, sulla mia di alluminio non attaccano Files STL su Thingiverse
Se avete trovato questa pagina utile commentate e condividete.

---

## Non estrude a inizio stampa
*(2021-12-02)*

Questo problema è molto comune per i nuovi proprietari di stampanti 3D, ma per fortuna è anche molto facile da risolvere! Se il tuo estrusore non estrude plastica all'inizio della stampa, ci sono quattro possibili cause che analizzeremo qui di seguito e spiegheremo quali impostazioni possono essere utilizzate per risolvere il problema.
L'hotend non è stato innescato prima di iniziare la stampa
La maggior parte degli hotend tende a far scivolare fuori la plastica quando sono inattivi a temperature elevate. La plastica calda all'interno dell'ugello tende a fuoriuscire dalla punta creando un vuoto all'interno dell'ugello. Questo può accadare sia all'inizio di una stampa durante il riscaldamento che a fine stampa durante il raffreddamento. Quando questo accade, è probabile che alla stampa successiva ci vorrà un po' di tempo prima che la plastica fuoriesca perchè il filamento deve prima riempire quel vuoto, quindi l'estrusione viene ritardata. Per risolvere questo problema è bene inserire nello "Start g-code" uno script che estrude il filamento di 2-3 cm prima di stampare. Anche l'utilizzo dello skirt è utile per far spurgare bene l'ugello prima di iniziare a stampare il pezzo. Sarebbe buona norma inoltre, evitare di spegnere subito la stampante appena finito di stampare perchè questo può provocare il riscaldamento eccessivo del tubo ptfe all'interno della gola, tubo che potrebbe quindi "stringersi" andando a provocare una mancata estrusione. Altra buona norma è quella di inserire nell' "End g-code" uno script che ritrae il filamento di 2cm in modo da farlo uscire dalla zona calda. Personalmente a fine stampa ritraggo di 2cm e a inizio stampa spingo di 3cm (2 per recuperare la ritrazione della stampa precedente, 1 per spurgare nozzle.
Il nozzle inizia la stampa troppo vicino al piatto
Se il nozzle è troppo vicino alla superficie del piatto, non ci sarà spazio sufficiente per la fuoriuscita del piatto. Un modo semplice per riconoscere questo problema è verificare se la stampa non estrude filamento per i primi 1-2 strati e inizia da quelli successivi dopo che il nozzle si è allontanato dal piatto. Per ovviare a questo problema è necessario ricalibrare bene il piatto e nel caso utilizzare gli Z-Offset dello slicer o impostarli nel G-Code
Il filamento si è rovinato all'interno dell'estrusore
All'interno dell'estrusore ci sono due ingranaggi che spingono avanti e indietro il filamento, se il filamento viene consumato in modo eccessivo, gli ingranaggi non riusciranno più a spingerlo provocando una mancata estrusione. Per risolvere questo problema consultare la pagina del problema relativo al "Filamento rovinato".
Hotend intasato
Se non si sono prese le dovute accortezze o l'hotend non si è montato per bene, è possibile che questo sia intasato provocando la mancata fuoriuscita del filamento. Per sistemare l'hotend occorre smontarlo in ogni sua parte (blocco, nozzle, gola, e radiatore) e ripulirlo per bene, aiutandovi se l'avete con una pistola ad aria calda. Poi rimontate il tutto facendo bene attenzione e soprattutto ricordatevi che il tubo in ptfe va spinto sempre bene fino in fondo, e il nozzle va stretto per mezzo giro a hotend caldo.

---
