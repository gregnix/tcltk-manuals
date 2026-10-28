# Tcl-Webdienste

## Zusammenfassung

Die Distribution bietet sowohl den Zugriff auf Webdienste von der Client-Seite als auch das Erzeugen von Webdiensten auf der Server-Seite. Derzeit werden auf der Client-Seite nur document/literal und rpc/encoded mit HTTP-Soap-Transport unterstützt. Die Server-Seite arbeitet derzeit nur mit TclHttpd oder eingebettet in eine Anwendung. Die Server-Seite stellt alle Dienste als document/literal über HTTP-Soap-Transport bereit. Die Dokumentation des Pakets einschließlich der Beispiele steht hier.

-  [Einen Webdienst aus Tcl aufrufen](Calling_a_Web_Service.md)
-  [Einen Tcl-Webdienst erzeugen](Creating_a_Tcl_Web_Service.md)
-  [Einen Webdienst-Typ erzeugen](Creating_a_Web_Service_Type.md)
-  [Antwort im REST-Stil](Rest_flavor_service_response.md)
-  [Dictionary-Darstellung von XML-Arrays](Dictionary_Representation_of_XML_Arrays.md)
-  [Optionen eines Webdienstes verwenden](Using_Options.md)
-  [Einen Webdienst in eine Anwendung einbetten](Embedded_Web_Service.md)
-  [Beispiel eines Tcl-Webdienstes](Tcl_Web_Service_Example.md)
-  [Mathematikbeispiel eines Tcl-Webdienstes](Tcl_Web_Service_Math_Example.md)

Der Client arbeitet nachweislich mit Webdiensten auf der Basis von #C und Java (das Ergebnis kann abweichen).

## Lizenz

Standard-BSD.

# Webserver

Die Server-Seite arbeitet mit den folgenden Webservern:

-  [TclHttpd](https://core.tcl-lang.org/tclhttpd)
-  [Rivet](http://tcl.apache.org/rivet)
-  [AOLserver](http://www.aolserver.com/)
-  [WUB](http://code.google.com/p/wub/)
-  [wibble](http://wiki.tcl-lang.org/23626)
-  Eingebetteter Modus (siehe [Einbetten](Embedded_Web_Service.md))

## Benötigte Pakete

Die folgenden Pakete werden verwendet:

-  [Tcl 8.6](http://www.tcl-lang.org/)
-  [tdom 0.8.1](http://www.tdom.org/)
-  [tcltls](http://core.tcl-lang.org/tcltls/) oder [TWAPI 4.4.0](https://www.magicsplat.com/tcl-docs/doctoc_twapi.html) für TLS-Unterstützung von Client und eingebettetem Server
-  log aus [TclLib](https://core.tcl-lang.org/tcllib)
-  uri aus [TclLib](https://core.tcl-lang.org/tcllib)
-  struct::set aus [TclLib](https://core.tcl-lang.org/tcllib)
-  http aus [Tcl](http://www.tcl-lang.org/) selbst
-  yajl-tcl von [flightaware github](https://github.com/flightaware/yajl-tcl) (nur für Anforderungen im Rest-Geschmack)

Wenn TclHttpd unter Windows läuft, ist die Erweiterung iocpsock sehr zu empfehlen.

Im Modus des eingebetteten Servers werden zusätzlich die folgenden Pakete verwendet:

-  base64 aus [TclLib](https://core.tcl-lang.org/tcllib) (auch Channel-Server)
-  html aus [TclLib](https://core.tcl-lang.org/tcllib) (auch Channel-Server)
-  ncgi aus [TclLib](https://core.tcl-lang.org/tcllib)
-  fileutil aus [TclLib](https://core.tcl-lang.org/tcllib)
