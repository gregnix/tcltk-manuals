---
CommandName: multiplexer
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: One-to-many communication with sockets.
Keywords:
 - chat
 - multiplexer
Copyright:
---

# NAME

multiplexer – Eins-zu-Viele-Kommunikation mit Sockets.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[package]{.cmd} [require]{.sub} [multiplexer]{.lit} [0.3]{.optlit} 
[::multiplexer::create]{.cmd} 
[\$]{.cmd} { [multiplexer_instance]{.lit} } [::Init]{.lit} [port]{.arg} 
[\$]{.cmd} { [multiplexer_instance]{.lit} } [::Config]{.lit} [key]{.arg} [value]{.arg} 
[\$]{.cmd} { [multiplexer_instance]{.lit} } [::AddFilter]{.lit} [cmdprefix]{.arg} 
[cmdprefix]{.cmd} [data]{.arg} [chan]{.arg} [clientaddress]{.arg} [clientport]{.arg} 
[\$]{.cmd} { [multiplexer_instance]{.lit} } [::AddAccessFilter]{.lit} [cmdprefix]{.arg} 
[cmdprefix]{.cmd} [chan]{.arg} [clientaddress]{.arg} [clientport]{.arg} 
[\$]{.cmd} { [multiplexer_instance]{.lit} } [::AddExitFilter]{.lit} [cmdprefix]{.arg} 
[cmdprefix]{.cmd} [chan]{.arg} [clientaddress]{.arg} [clientport]{.arg} 
:::

# BESCHREIBUNG

Das Paket **multiplexer** bietet ein generisches System für die Eins-zu-Viele-Kommunikation unter Verwendung von Sockets. Stellen Sie sich beispielsweise ein Chat-System vor, bei dem ein Benutzer eine Nachricht sendet, die anschließend an alle anderen verbundenen Benutzer weitergeleitet wird.

Es ist möglich, dass verschiedene Multiplexer gleichzeitig laufen.

**::multiplexer::create**
: Der Befehl **create** erstellt eine neue Multiplexer-„Instanz“.  Beispiele:


```
set mp [::multiplexer::create]
```

: Diese Instanz lässt sich dann wie folgt bearbeiten:


```
${mp}::Init 35100
```

**\${multiplexer_instance}::Init** *port*
: Dadurch wird der Multiplexer gestartet, der auf dem angegebenen Port auf eingehende Daten wartet.

**\${multiplexer_instance}::Config** *key* *value*
: Verwenden Sie „**Config**“, um die Multiplexer-Instanz zu konfigurieren. Zu den derzeit verfügbaren Konfigurationsoptionen gehören:


**sendtoorigin**
: Ein boolescher Schalter. Wenn der Wert „**true**“ ist, erhält der Absender eine Kopie der gesendeten Nachricht. Der Standardwert ist „**false**“.

**debuglevel**
: Legt die für die Multiplexer-Instanz zu verwendende Debug-Stufe fest, entsprechend den im Paket **logger** angegebenen Stufen (debug, info, notice, warn, error, critical).


**\${multiplexer_instance}::AddFilter** *cmdprefix*
: Befehl zum Hinzufügen eines Filters für Daten, die die Multiplexer-Instanz durchlaufen. Das registrierte *cmdprefix* wird aufgerufen, sobald Daten bei einer Multiplexer-Instanz eintreffen. Sind bei der Instanz mehrere Filter-Befehle registriert, werden diese in der Reihenfolge ihrer Registrierung aufgerufen, wobei jeder Filter das Ergebnis des vorhergehenden Filters als Argument erhält. Der erste Filter erhält die eingehenden Daten als Argument. Das vom letzten Filter zurückgegebene Ergebnis sind die Daten, die an alle Clients der Multiplexer-Instanz gesendet werden. Der Befehl wird wie folgt aufgerufen:


**cmdprefix** *data* *chan* *clientaddress* *clientport*
: Nimmt die eingehenden *data* entgegen, verändert sie und gibt das Ergebnis zurück. Die letzten drei Argumente enthalten Informationen über den Client, der die Daten an den Filter gesendet hat: den Kanal, über den die Verbindung zum Client besteht, dessen IP-Adresse und dessen IP-Port.


**\${multiplexer_instance}::AddAccessFilter** *cmdprefix*
: Befehl zum Hinzufügen eines Zugriffsfilters. Das registrierte *cmdprefix* wird aufgerufen, wenn ein neuer Client-Socket versucht, eine Verbindung zur Multiplexer-Instanz herzustellen. Sind bei der Instanz mehrere Zugriffsfilter-Befehle registriert, werden diese in der Reihenfolge ihrer Registrierung aufgerufen. Gibt einer der aufgerufenen Befehle den Wert **-1** zurück, wird der Zugriff auf die Multiplexer-Instanz verweigert und der Client-Kanal sofort geschlossen. Bei jedem anderen Ergebnis wird dem Client der Zugriff auf die Multiplexer-Instanz gewährt. Das Befehlspräfix wird wie folgt aufgerufen:


**cmdprefix** *chan* *clientaddress* *clientport*
: Die Argumente enthalten Informationen über den Client, der versucht, eine Verbindung zur Instanz herzustellen: den Kanal, über den wir mit dem Client verbunden sind, dessen IP-Adresse und dessen IP-Port.


**\${multiplexer_instance}::AddExitFilter** *cmdprefix*
: Fügt einen Filter hinzu, der ausgeführt wird, wenn ein Client-Socket einen EOF-Zustand erzeugt. Das registrierte *cmdprefix* wird aufgerufen, wenn ein Client-Socket des Multixers EOF signalisiert. Sind bei der Instanz mehrere Exit-Filter-Befehle registriert, werden diese in der Reihenfolge ihrer Registrierung aufgerufen. Von einem Exit-Filter ausgelöste Fehler werden ignoriert, jedoch protokolliert. Alle Ergebnisse, die von einem Exit-Filter gegeben werden, werden ignoriert. Der Befehlsvorhang wird wie folgt aufgerufen:


**cmdprefix** *chan* *clientaddress* *clientport*
: Die Argumente enthalten Informationen über den Client, der das EOF signalisiert hat: den Kanal, über den wir mit dem Client verbunden sind, dessen IP-Adresse und dessen IP-Port.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *multiplexer* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge
