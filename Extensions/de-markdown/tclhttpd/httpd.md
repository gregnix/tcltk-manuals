---
CommandName: tclhttpd
ManualSection: 1
Version: unknown
TclPart: TclPro
TclDescription: TclPro Applications
Keywords:
 - Web Server
 - HTTP
 - TclHttpd
Copyright:
 - Copyright (c) 1998-2000 by Ajuba Solutions
 - All rights reserved.
---

# NAME

tclhttpd - Tcl-Webserver

# ÜBERSICHT

::: {.synopsis} :::
[tclsh]{.cmd} [httpd.tcl]{.sub} [options]{.optarg} 
:::

# OPTIONEN

**-help**
: Zeigt die Aufrufhilfe an und beendet sich, ohne etwas zu tun.

**-config** *filename*
: Name der Konfigurationsdatei (zum Beispiel tclpro/bin/tclhttpd.rc).

**-main** *filename*
: Name des Haupt-Skripts je Thread (zum Beispiel tclpro/bin/httpdthread.tcl).

**-docRoot** *directory*
: Wurzelverzeichnis der Webseiten (zum Beispiel tclpro/tclhttpd/htdocs).

**-port** *value*
: HTTP-Port, an dem der Server lauscht. Voreingestellt 8015.

**-host** *value*
: Rechnername des HTTP-Sockets, an dem der Server lauscht.

**-ipaddr** *value*
: Schnittstelle, an die der Server bindet.

**-webmaster** *email*
: E-Mail-Adresse des Webmasters.

**-uid** *userid*
: Benutzername oder Kennung für die Benutzerkennung des Serverprozesses.

**-gid** *groupid*
: Gruppenname oder Kennung für die Gruppenkennung des Serverprozesses.

**-threads** *num*
: Läuft mit *num* Arbeits-Threads. Dafür ist eine thread-sichere Tcl-Shell nötig.

**-library** *directory*
: Verzeichnis, das an den auto_path angehängt wird.

**-verbose**
: Gibt beim Start zusätzliche Meldungen aus.


# BESCHREIBUNG

TclHttpd ist ein einfacher, erweiterbarer Webserver, der sich einbetten lässt. Die ausführliche Dokumentation liegt als HTML beim Server.

Zum Starten wird das Skript httpd.tcl mit *tclsh* oder *wish* ausgeführt. Das folgende Beispiel startet den Server auf dem üblichen Webserver-Port 80: tclsh \<installdir>/bin/httpd.tcl -port 80. Auf UNIX-Systemen muss der Server als root starten, wenn die Portnummer kleiner als 1024 ist. Soll der Prozess danach unter einem anderen Benutzer als root laufen, was dringend zu empfehlen ist, dienen die Optionen **-uid** und **-gid**. So startet der Server als root, öffnet den Socket und wechselt dann auf ein Konto mit weniger Rechten.

# KONFIGURATION UND ANPASSUNG

Das Haupt-Skript hängt von einem Tcl-Skript je Thread, httpdthread.tcl, und von einer Konfigurationsdatei tclhttpd.rc ab. Darin stehen die Einstellungen und der Startcode des Webservers.

Die Konfigurationsdatei setzt Port, Benutzerkennung und die übrigen Werte aus der Optionsliste oben. Weitere Merkmale, etwa der Ort der Protokolldatei, stehen in derselben Datei. Zu jeder Option gibt es eine Erklärung. Eine Kopie der Datei nimmt neue Einstellungen auf.

```
tclsh httpd.tcl -config myserver.rc
```

Wer Tcl Httpd mit eigenem Code erweitert, ergänzt den Initialisierungscode in bin/httpd.tcl und bin/httpdthread.tcl. Das ist in der Regel ein "package require" des Moduls und ein oder zwei Aufrufe, die es initialisieren. Der folgende Code in httpdthread.tcl schaltet zum Beispiel eine URL /debug frei, über die sich der Zustand des Servers ansehen lässt.

```
package require httpd::debug
Debug_Url /debug Debug
```

Der Webserver erreicht jedes Tcl-Paket, das mit der Tcl-Installation liegt. Die mitgelieferte HTML-Dokumentation beschreibt das Programmieren des Servers ausführlicher.

# SEITENVORLAGEN

TclHttpd hat ein Vorlagensystem, das Tcl-Code in die HTML-Seiten einbettet. Der Webserver wertet das Tcl aus. Es erzeugt in der Regel Teile der HTML-Seite, und das Ergebnis geht unverändert an den Client. Die Ergebnisse der Vorlagen lassen sich zwischenspeichern, oder die Seiten werden bei jedem Zugriff neu verarbeitet.

Jede Seite, die auf ".tml" endet, gilt als HTML+Tcl-Vorlage. Der Webserver ersetzt mit dem Tcl-Befehl **subst** Befehle in Klammern, \[ und \], und Variablenverweise wie \$Phone durch ihren Wert. Auch der Backslash wird verarbeitet. Wörtliche Dollarbeträge in den Vorlagen brauchen einen Backslash vor dem \$:

```
The price is \$10.00.
```

Die ".tml"-Dateien in der Beispielstruktur unter htdocs sind die Vorlagen zum Weiterarbeiten.

Der Tcl-Code in den Seiten bleibt am besten bei einfachen Prozeduraufrufen. Die Prozedurdefinitionen stehen in Dateien je Verzeichnis mit dem Namen ".tml". Der Name verwirrt: jedes Verzeichnis kann eine Datei "dot-t-m-l" (.tml) enthalten, und die enthält Tcl-Code. Diese Dateien werden geladen, bevor eine Vorlage in diesem Verzeichnis oder in Unterverzeichnissen verarbeitet wird.

Zuerst entsteht zum Beispiel ein neues Verzeichnis unter dem htdocs-Verzeichnis von TclHttpd.

```
mkdir htdocs/mystuff
```

Danach kommt Folgendes in die Datei htdocs/mystuff/.tml.

```
package require htmlutils

# A procedure to format the date the way you like it
proc MyDate {{seconds {}}} {
    if {[string length $seconds] == 0} {
	set seconds [clock seconds]
    }
    return [clock format $seconds -format "%B %m, %Y"]
}
# Some page settings
set bgcolor pink
```

Danach kann jede Seite im Verzeichnis htdocs/mystuff die Prozedur **MyDate** in einer Vorlage verwenden. Zum Schluss kommt Folgendes in die Datei htdocs/mystuff/index.tml.

```
<title>My Stuff</title>
<body text=black bgcolor=$bgcolor>
<h2>My Stuff</h2>
[MyDate]
<br>
Page content here.
<p>
Send email to [Mailto [Doc_Webmaster]].
```

Die Variable **bgcolor** wird in der Datei .tml gesetzt und im BODY-Tag verwendet. **Mailto** gehört zum Paket **htmlutils**, das die Datei .tml anfordert. Die Prozedur **Doc_Webmaster** ist in TclHttpd eingebaut. Die Prozedur MyDate kommt dazu und gilt für jede Seite in htdocs/mystuff und darunter.
