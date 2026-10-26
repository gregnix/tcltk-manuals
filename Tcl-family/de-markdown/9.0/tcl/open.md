---
CommandName: open
ManualSection: n
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - close(n)
 - filename(n)
 - fconfigure(n)
 - gets(n)
 - read(n)
 - puts(n)
 - exec(n)
 - pid(n)
 - fopen(3)
Keywords:
 - access mode
 - append
 - create
 - file
 - non-blocking
 - open
 - permissions
 - pipeline
 - process
 - serial
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

open - Öffnet einen dateibasierten Kanal oder einen Befehlspipeline-Kanal

# ÜBERSICHT

::: {.synopsis} :::
[open]{.cmd} [fileName]{.arg} 
[open]{.cmd} [fileName]{.arg} [access]{.arg} 
[open]{.cmd} [fileName]{.arg} [access]{.arg} [permissions]{.arg} 
:::

# BESCHREIBUNG

Dieser Befehl öffnet eine Datei, einen seriellen Port oder eine Befehlspipeline und gibt einen Kanalbezeichner zurück, der in späteren Aufrufen von Befehlen wie **read**, **puts** und **close** verwendet werden kann. Ist das erste Zeichen von *fileName* nicht **|**, öffnet der Befehl eine Datei: *fileName* gibt den Namen der zu öffnenden Datei an, und er muss den in der Manpage **filename** beschriebenen Konventionen entsprechen.

Das Argument *access*, falls angegeben, gibt an, wie auf die Datei (oder Befehlspipeline) zugegriffen werden soll. In der ersten Form kann *access* einen der folgenden Werte haben:

**r**
: Die Datei nur zum Lesen öffnen; die Datei muss bereits existieren. Dies ist der Standardwert, wenn *access* nicht angegeben wird.

**r+**
: Die Datei zum Lesen und Schreiben öffnen; die Datei muss bereits existieren.

**w**
: Die Datei nur zum Schreiben öffnen. Existiert sie, wird sie gekürzt. Existiert sie nicht, wird eine neue Datei erstellt.

**w+**
: Die Datei zum Lesen und Schreiben öffnen. Existiert sie, wird sie gekürzt. Existiert sie nicht, wird eine neue Datei erstellt.

**a**
: Die Datei nur zum Schreiben öffnen. Existiert die Datei nicht, wird eine neue leere Datei erstellt. Der Dateizeiger wird vor jedem Schreibvorgang ans Dateiende gesetzt.

**a+**
: Die Datei zum Lesen und Schreiben öffnen. Existiert die Datei nicht, wird eine neue leere Datei erstellt. Die anfängliche Zugriffsposition wird auf das Dateiende gesetzt.


Alle oben genannten zulässigen *access*-Werte können das Zeichen **b** als zweites oder drittes Zeichen im Wert erhalten, um anzugeben, dass der geöffnete Kanal so konfiguriert werden soll, als wäre die Option **fconfigure** **-translation binary** gesetzt, sodass der Kanal zum Lesen oder Schreiben binärer Daten geeignet ist.

In der zweiten Form besteht *access* aus einer Liste beliebiger der folgenden Flags, von denen die meisten die übliche POSIX-Bedeutung haben. Eines der Flags muss **RDONLY**, **WRONLY** oder **RDWR** sein.

**RDONLY**
: Die Datei nur zum Lesen öffnen.

**WRONLY**
: Die Datei nur zum Schreiben öffnen.

**RDWR**
: Die Datei zum Lesen und Schreiben öffnen.

**APPEND**
: Den Dateizeiger vor jedem Schreibvorgang ans Dateiende setzen.

**BINARY**
: Den geöffneten Kanal mit der Option **-translation binary** konfigurieren.

**CREAT**
: Die Datei erstellen, falls sie noch nicht existiert (ohne dieses Flag ist es ein Fehler, wenn die Datei nicht existiert).

**EXCL**
: Ist **CREAT** ebenfalls angegeben, wird ein Fehler zurückgegeben, wenn die Datei bereits existiert.

**NOCTTY**
: Ist die Datei ein Terminalgerät, verhindert dieses Flag, dass die Datei zum steuernden Terminal des Prozesses wird.

**NONBLOCK**
: Verhindert, dass der Prozess beim Öffnen der Datei und möglicherweise bei nachfolgenden E/A-Operationen blockiert. Das genaue Verhalten dieses Flags ist system- und geräteabhängig; seine Verwendung wird nicht empfohlen (besser ist es, den Befehl **fconfigure** zu verwenden, um eine Datei in den nicht blockierenden Modus zu versetzen). Einzelheiten finden sich in der Systemdokumentation zum Flag **O_NONBLOCK** des Systemaufrufs **open**.

**TRUNC**
: Existiert die Datei, wird sie auf die Länge null gekürzt.


Wird beim Öffnen eine neue Datei erstellt, wird *permissions* (eine Ganzzahl) zusammen mit der Dateimodus-Erstellungsmaske des Prozesses verwendet, um die Berechtigungen für die neue Datei festzulegen. *Permissions* hat standardmäßig den Wert 0666.

::: {.info -version="TIP603"}
Wenn die geöffnete Datei eine normale Festplattendatei ist, können die Befehle **chan configure** und **fconfigure** verwendet werden, um diese zusätzliche Konfigurationsoption abzufragen:
:::

**-stat**
: Beim Lesen dieser Option wird ein Wörterbuch mit Werten zurückgegeben, wie es der Befehl **file stat** liefert, wobei sich die Stat-Informationen auf die tatsächlich geöffnete Datei beziehen. Schlüssel im Wörterbuch können unter anderem **atime**, **ctime**, **dev**, **gid**, **ino**, **mode**, **mtime**, **nlink**, **size**, **type** und **uid** sein; die Felder **mtime**, **size** und **type** sind auf allen Plattformen garantiert vorhanden und aussagekräftig; weitere Schlüssel können ebenfalls vorhanden sein.
    *Implementierungshinweis:* Diese Option wird auf POSIX-Plattformen auf einen Aufruf von **fstat()** abgebildet und unter Windows auf einen Aufruf von **GetFileInformationByHandle()**; die gemeldeten Informationen entsprechen dem, was diese Systemaufrufe liefern.


# BEFEHLSPIPELINES

Ist das erste Zeichen von *fileName* „**|**“, werden die übrigen Zeichen von *fileName* als Liste von Argumenten behandelt, die eine Befehlspipeline beschreiben, im gleichen Stil wie die Argumente für **exec**. In diesem Fall kann der von **open** zurückgegebene Kanalbezeichner verwendet werden, um in die Eingabepipeline des Befehls zu schreiben oder aus seiner Ausgabepipeline zu lesen, abhängig vom Wert von *access*. Wird nur Schreibzugriff verwendet (z. B. *access* ist „**w**“), wird die Standardausgabe der Pipeline auf die aktuelle Standardausgabe geleitet, sofern der Befehl nichts anderes vorgibt. Wird nur Lesezugriff verwendet (z. B. *access* ist „**r**“), stammt die Standardeingabe der Pipeline von der aktuellen Standardeingabe, sofern der Befehl nichts anderes vorgibt. Die ID des gestarteten Prozesses ist über den Befehl **pid** zugänglich, wobei der von **open** zurückgegebene Kanalbezeichner als Argument verwendet wird.

Gibt der Befehl (oder einer der Befehle) in der Befehlspipeline einen Fehler zurück (gemäß der Definition in **exec**), wird beim Aufruf von **close** auf dem Kanal ein Tcl-Fehler erzeugt, es sei denn, die Pipeline befindet sich im nicht blockierenden Modus; dann wird kein Exit-Status zurückgegeben (ein stilles **close** mit -blocking 0).

Es ist oft sinnvoll, den Befehl **fileevent** mit Pipelines zu verwenden, damit andere Verarbeitung parallel zum Ausführen des Befehls im Hintergrund ablaufen kann.

# SERIELLE KOMMUNIKATION

Bezieht sich *fileName* auf einen seriellen Port, wird der angegebene serielle Port plattformabhängig geöffnet und initialisiert. Zulässige Werte für *fileName* zum Öffnen eines seriellen Ports sind im Abschnitt **PORTABILITÄTSFRAGEN** beschrieben.

Die Befehle **chan configure** und **fconfigure** können verwendet werden, um zusätzliche, serielle Ports betreffende Konfigurationsoptionen abzufragen und zu setzen (wo unterstützt):

**-mode** *baud*__,__*parity*__,__*data*__,__*stop*
: Diese Option ist ein Satz aus vier durch Kommas getrennten Werten: Baudrate, Parität, Anzahl der Datenbits und Anzahl der Stoppbits für diesen seriellen Port. Die *baud*-Rate ist eine einfache Ganzzahl, die die Verbindungsgeschwindigkeit angibt. *Parity* ist einer der Buchstaben **n**, **o**, **e**, **m**, **s**; sie stehen für die Paritätsoptionen „none“, „odd“, „even“, „mark“ bzw. „space“. *Data* ist die Anzahl der Datenbits und sollte eine Ganzzahl von 5 bis 8 sein, *stop* ist die Anzahl der Stoppbits und sollte die Ganzzahl 1 oder 2 sein.

**-handshake** *type*
: (Windows und Unix). Diese Option dient zur Einrichtung der automatischen Handshake-Steuerung. Beachten Sie, dass nicht alle Handshake-Typen von Ihrem Betriebssystem unterstützt werden. Der Parameter *type* ist unabhängig von der Groß-/Kleinschreibung.
    Ist *type* **none**, ist jeder Handshake ausgeschaltet. **rtscts** aktiviert den Hardware-Handshake. Die Hardware-Handshake-Signale sind unten beschrieben. Für den Software-Handshake **xonxoff** können die Handshake-Zeichen mit **-xchar** neu definiert werden. Ein zusätzlicher Hardware-Handshake **dtrdsr** ist nur unter Windows verfügbar. Es gibt keine Standard-Handshake-Konfiguration; der Anfangswert hängt von den Betriebssystemeinstellungen ab. Die Option **-handshake** kann nicht abgefragt werden.

**-queue**
: (Windows und Unix). Die Option **-queue** kann nur abgefragt werden. Sie gibt eine Liste aus zwei Ganzzahlen zurück, die die aktuelle Anzahl der Bytes in der Eingabe- bzw. Ausgabewarteschlange darstellen.

**-timeout** *msec*
: (Windows und Unix). Diese Option legt das Timeout für blockierende Leseoperationen fest. Sie gibt das maximale Intervall zwischen dem Empfang zweier Bytes in Millisekunden an. Unter Unix-Systemen beträgt die Granularität 100 Millisekunden. Die Option **-timeout** beeinflusst Schreiboperationen oder nicht blockierende Lesezugriffe nicht. Diese Option kann nicht abgefragt werden.

**-ttycontrol** *{signal boolean signal boolean ...}*
: (Windows und Unix). Diese Option dient zur dauerhaften Einrichtung der Handshake-Ausgangsleitungen (siehe unten) oder zum Senden eines BREAK über die serielle Leitung. Die *signal*-Namen sind unabhängig von der Groß-/Kleinschreibung. **{RTS 1 DTR 0}** setzt die RTS-Ausgabe auf high und die DTR-Ausgabe auf low. Die BREAK-Bedingung (siehe unten) wird mit **{BREAK 1}** bzw. **{BREAK 0}** aktiviert und deaktiviert. Es ist keine gute Idee, das Signal **RTS** (oder **DTR**) bei aktivem Hardware-Handshake **rtscts** (oder **dtrdsr**) zu ändern. Das Ergebnis ist unvorhersehbar. Die Option **-ttycontrol** kann nicht abgefragt werden.

**-ttystatus**
: (Windows und Unix). Die Option **-ttystatus** kann nur abgefragt werden. Sie liefert den aktuellen Modemstatus und die Handshake-Eingangssignale (siehe unten). Das Ergebnis ist eine Liste von Signal-Wert-Paaren in fester Reihenfolge, z. B. **{CTS 1 DSR 0 RING 1 DCD 0}**. Die *signal*-Namen werden in Großbuchstaben zurückgegeben.

**-xchar** *{xonChar xoffChar}*
: (Windows und Unix). Diese Option dient zum Abfragen oder Ändern der Software-Handshake-Zeichen. Normalerweise sollten die Betriebssystem-Standardwerte DC1 (0x11) und DC3 (0x13) sein, die den ASCII-Standardzeichen XON und XOFF entsprechen.

**-closemode** *closeMode*
: (Windows und Unix). Diese Option dient zum Abfragen oder Ändern des Schließmodus des seriellen Kanals; sie legt fest, wie mit ausstehender Ausgabe in Betriebssystempuffern beim Schließen des Kanals verfahren wird. Folgende Werte für *closeMode* werden unterstützt:

**default**
: bedeutet, dass eine systemseitige Standardoperation verwendet werden soll; alle seriellen Kanäle verwenden standardmäßig diesen Wert.

**discard**
: bedeutet, dass der Inhalt der Betriebssystempuffer verworfen werden soll. Beachten Sie, dass dies beim Schreiben auf ein POSIX-Terminal *nicht empfohlen* ist, da es unerwartet mit der Behandlung von **stderr** interagieren kann.

**drain**
: bedeutet, dass Tcl beim Schließen des Kanals wartet, bis die gesamte Ausgabe verarbeitet wurde. Das kann **close** spürbar verlangsamen.


**-inputmode** *inputMode*
: (nur Unix; Windows hat die gleichwertige Option bei Konsolenkanälen). Diese Option dient zum Abfragen oder Ändern des Eingabemodus des seriellen Kanals unter der Annahme, dass mit einem Terminal kommuniziert wird; sie steuert, wie interaktive Benutzereingabe behandelt wird. Folgende Werte für *inputMode* werden unterstützt:

**normal**
: bedeutet, dass normale zeilenorientierte Eingabe mit den üblichen Terminal-Bearbeitungsfunktionen verwendet werden soll.

**password**
: bedeutet, dass nicht echoende Eingabe mit den üblichen Terminal-Bearbeitungsfunktionen verwendet werden soll, aber ohne Ausgabe getippter Zeichen auf das Terminal (außer Zeilenumbrüchen). Einige Terminals können dies besonders kennzeichnen.

**raw**
: bedeutet, dass die gesamte Tastatureingabe unverarbeitet an Tcl weitergegeben werden soll, ohne dass das Terminal etwas verarbeitet. Die Tasten werden nicht echoiert; die Interpretation obliegt dem Tcl-Skript.

**reset** (nur setzen)
: bedeutet, dass das Terminal auf den Zustand zurückgesetzt werden soll, in dem es sich beim Öffnen befand.

    Beachten Sie, dass das Setzen dieser Option (technisch gesehen alles, was den Terminalzustand über diese Option vom Anfangswert abweicht) bewirkt, dass der Kanal beim Schließen automatisch das Terminal zurücksetzt.

**-winsize**
: (nur Unix; Windows hat die gleichwertige Option bei Konsolenkanälen). Diese Option ist nur abfragbar. Sie liefert eine zweielementige Liste mit der aktuellen Breite und Höhe des Terminals.

**-pollinterval** *msec*
: (nur Windows). Diese Option legt die maximale Zeit zwischen Abfragen auf Datei-Events fest. Das betrifft das Intervall zwischen Ereignisprüfungen im gesamten Tcl-Interpreter (der kleinste Wert gewinnt immer). Verwenden Sie diese Option nur, wenn Sie den seriellen Port häufiger oder seltener als alle 10 ms (Standard) abfragen möchten.

**-sysbuffer** *inSize*
: ...siehe nächstes...

**-sysbuffer** *{inSize outSize}*
: (nur Windows). Diese Option dient zur Änderung der Größe der Windows-Systempuffer für einen seriellen Kanal. Besonders bei höheren Übertragungsraten kann der Standard-Eingabepuffer von 4096 Bytes auf trägen Systemen überlaufen. Die erste Form legt nur die Größe des Eingabepuffers fest, in der zweiten Form werden Eingabe- und Ausgabepuffer definiert.

**-lasterror**
: (nur Windows). Diese Option ist nur abfragbar. Tritt bei der seriellen Kommunikation ein Fehler auf, liefern **read** oder **puts** einen allgemeinen Tcl-Datei-E/A-Fehler. **fconfigure** **-lasterror** kann aufgerufen werden, um eine Liste mit Fehlerdetails zu erhalten. Die verschiedenen Fehlercodes werden unten erläutert.


## Signale der seriellen Schnittstelle

RS-232 ist die am häufigsten verwendete standardisierte elektrische Schnittstelle für serielle Kommunikation. Eine negative Spannung (−3 V bis −12 V) definiert ein Mark-Bit (on=1), eine positive Spannung (+3 V bis +12 V) ein Space-Bit (off=0) (RS-232C). Für eingehende und ausgehende Daten, Statusleitungen und Handshake gelten die folgenden Signale. Hier verwenden wir die Begriffe *Workstation* für Ihren Computer und *Modem* für das externe Gerät, weil einige Signalnamen (DCD, RI) von Modems stammen. Natürlich kann Ihr externes Gerät diese Signalleitungen auch für andere Zwecke nutzen.

**TXD** (output)
: **Transmitted Data (gesendete Daten):** Ausgehende serielle Daten.

**RXD** (input)
: **Received Data (empfangene Daten):** Eingehende serielle Daten.

**RTS** (output)
: **Request To Send:** Diese Hardware-Handshake-Leitung teilt dem Modem mit, dass Ihre Workstation bereit ist, Daten zu empfangen. Ihre Workstation kann dieses Signal automatisch zurücksetzen, um anzuzeigen, dass der Eingabepuffer voll ist.

**CTS** (input)
: **Clear To Send:** Das Gegenstück zu RTS. Zeigt an, dass das Modem bereit ist, Daten zu empfangen.

**DTR** (output)
: **Data Terminal Ready:** Dieses Signal teilt dem Modem mit, dass die Workstation bereit ist, eine Verbindung aufzubauen. DTR wird oft automatisch aktiviert, sobald ein serieller Port geöffnet wird.

**DSR** (input)
: **Data Set Ready:** Das Gegenstück zu DTR. Teilt der Workstation mit, dass das Modem bereit ist, eine Verbindung aufzubauen.

**DCD** (input)
: **Data Carrier Detect:** Diese Leitung wird aktiv, wenn ein Modem ein „Carrier“-Signal erkennt.

**RI** (input)
: **Ring Indicator:** Wird aktiv, wenn das Modem einen eingehenden Anruf erkennt.

**BREAK**
: Eine BREAK-Bedingung ist keine Hardware-Signalleitung, sondern logische Null auf den Leitungen TXD oder RXD über einen längeren Zeitraum, üblicherweise 250 bis 500 Millisekunden. Normalerweise bleibt ein Empfangs- oder Sende-Datensignal bis zur Übertragung des nächsten Zeichens auf Mark-Spannung (on=1). Ein BREAK wird manchmal verwendet, um die Kommunikationsleitung zurückzusetzen oder den Betriebsmodus der Kommunikationshardware zu ändern.


## Fehlercodes (nur Windows)

Bei seriellen Leseoperationen oder bei der Ereignisabfrage im Hintergrund können viele verschiedene Fehler auftreten. Das externe Gerät kann ausgeschaltet sein, die Datenleitungen können verrauscht sein, Systempuffer können überlaufen oder Ihre Moduseinstellungen können falsch sein. Deshalb sollte zuverlässige Software serielle Leseoperationen immer **catch**en. Im Fehlerfall gibt Tcl einen allgemeinen Datei-E/A-Fehler zurück. Dann kann **fconfigure** **-lasterror** helfen, das Problem einzugrenzen. Folgende Fehlercodes können zurückgegeben werden.

**RXOVER**
: Überlauf des Windows-Eingabepuffers. Die Daten kommen schneller an, als Ihr Skript sie liest, oder Ihr System ist überlastet. Verwenden Sie **fconfigure** **-sysbuffer**, um einen temporären Engpass zu vermeiden und/oder beschleunigen Sie Ihr Skript.

**TXFULL**
: Überlauf des Windows-Ausgabepuffers. Gegenstück zu RXOVER. Dieser Fehler sollte praktisch nicht auftreten, weil Tcl den Status des Ausgabepuffers überwacht.

**OVERRUN**
: UART-Pufferüberlauf (Hardware) mit Datenverlust. Die Daten kommen schneller an, als der Systemtreiber sie empfängt. Prüfen Sie die erweiterten seriellen Port-Einstellungen, um den FIFO-Puffer (16550) zu aktivieren und/oder einen niedrigeren(1) Interrupt-Schwellenwert zu setzen.

**RXPARITY**
: Ihr UART hat einen Paritätsfehler erkannt. Falsche Paritätseinstellungen mit **fconfigure** **-mode** oder eine verrauschte Datenleitung (RXD) können diesen Fehler verursachen.

**FRAME**
: Ihr UART hat einen Stoppbit-Fehler erkannt. Falsche Moduseinstellungen mit **fconfigure** **-mode** oder eine verrauschte Datenleitung (RXD) können diesen Fehler verursachen.

**BREAK**
: Ihr UART hat eine BREAK-Bedingung erkannt (siehe oben).


## Portabilitätsfragen

**Windows** 
: Zulässige Werte für *fileName* zum Öffnen eines seriellen Ports haben die Form **com**_X_, wobei *X* eine Zahl ist, in der Regel von 1 bis 9. Eine ältere, ebenfalls akzeptierte Form ist **com**_X_**:**. Diese Notation funktioniert nur für serielle Ports von 1 bis 9. Der Versuch, einen nicht existierenden seriellen Port oder einen mit einer Nummer größer als 9 zu öffnen, schlägt fehl. Eine alternative Form zum Öffnen serieller Ports ist der Dateiname **//./comX**, wobei *X* eine beliebige Nummer ist, die einem seriellen Port entspricht.


Wird Tcl interaktiv ausgeführt, kann es zu seltsamen Wechselwirkungen zwischen der echten Konsole, falls vorhanden, und einer Befehlspipeline kommen, die Standardeingabe oder -ausgabe nutzt. Wird eine Befehlspipeline zum Lesen geöffnet, gehen einige an der Konsole eingegebene Zeilen in die Befehlspipeline, andere an den Tcl-Interpreter. Wird eine Befehlspipeline zum Schreiben geöffnet, sind Tastatureingaben an der Konsole erst sichtbar, wenn die Pipeline geschlossen wird. Diese Probleme treten nur auf, weil Tcl und die Kindanwendung gleichzeitig um die Konsole konkurrieren. Wird die Befehlspipeline aus einem Skript gestartet, sodass Tcl die Konsole nicht nutzt, oder verwendet die Befehlspipeline weder Standardeingabe noch -ausgabe, sondern ist von einer Datei umgeleitet oder dorthin umgeleitet, treten die genannten Probleme nicht auf.

Dateien, die im Modus „**a**“ oder mit gesetztem Flag **APPEND** geöffnet werden, werden implementiert, indem unmittelbar vor jedem Schreibvorgang gesucht wird; das ist keine atomare Operation und bietet nicht die auf POSIX-Plattformen vorhandene Garantie des strikten Anhängens.

**Unix** 
: Zulässige Werte für *fileName* zum Öffnen eines seriellen Ports haben in der Regel die Form **/dev/tty***X*, wobei *X* **a** oder **b** ist; es kann jedoch jeder Pseudodateiname verwendet werden, der einem seriellen Port zugeordnet ist. Erweiterte Konfigurationsoptionen werden für serielle Ports nur unterstützt, wenn Tcl mit der POSIX-Schnittstelle für serielle Ports gebaut wurde.
    Wird Tcl interaktiv ausgeführt, kann es zu seltsamen Wechselwirkungen zwischen der Konsole, falls vorhanden, und einer Befehlspipeline kommen, die die Standardeingabe nutzt. Wird eine Befehlspipeline zum Lesen geöffnet, gehen einige an der Konsole eingegebene Zeilen in die Befehlspipeline, andere an den Tcl-Interpreter. Dieses Problem tritt nur auf, weil Tcl und die Kindanwendung gleichzeitig um die Konsole konkurrieren. Wird die Befehlspipeline aus einem Skript gestartet, sodass Tcl die Konsole nicht nutzt, oder verwendet die Befehlspipeline keine Standardeingabe, sondern ist von einer Datei umgeleitet, tritt das genannte Problem nicht auf.


Siehe den Abschnitt **PORTABILITÄTSFRAGEN** des Befehls **exec** für weitere Informationen zum Ausführen von Anwendungen auf den verschiedenen Plattformen, die nicht spezifisch für Befehlspipelines sind.

# KONSOLENKANÄLE

::: {.info -version="TIP160"}
Nur unter Windows unterstützen Konsolenkanäle (üblicherweise **stdin** oder **stdout**) die folgenden Optionen:
:::

**-inputmode** *inputMode*
: Diese Option dient zum Abfragen oder Ändern des Eingabemodus des Konsolenkanals; sie steuert, wie interaktive Benutzereingabe behandelt wird. Folgende Werte für *inputMode* werden unterstützt:

**normal**
: bedeutet, dass normale zeilenorientierte Eingabe mit den üblichen Konsolen-Bearbeitungsfunktionen verwendet werden soll.

**password**
: bedeutet, dass nicht echoende Eingabe mit den üblichen Konsolen-Bearbeitungsfunktionen verwendet werden soll, aber ohne Ausgabe getippter Zeichen auf das Terminal (außer Zeilenumbrüchen).

**raw**
: bedeutet, dass die gesamte Tastatureingabe unverarbeitet an Tcl weitergegeben werden soll, ohne dass die Konsole etwas verarbeitet. Die Tasten werden nicht echoiert; die Interpretation obliegt dem Tcl-Skript.

**reset** (nur setzen)
: bedeutet, dass die Konsole auf den Zustand zurückgesetzt werden soll, in dem sie sich beim Öffnen des Konsolenkanals befand.

    Beachten Sie, dass das Setzen dieser Option (technisch gesehen alles, was den Konsolenzustand über diese Option vom Standard abweicht) bewirkt, dass der Kanal beim Schließen automatisch die Konsole zurücksetzt.

**-winsize**
: Diese Option ist nur abfragbar. Sie liefert eine zweielementige Liste mit der aktuellen Breite und Höhe der Konsole, mit der dieser Kanal kommuniziert.


Beachten Sie, dass gleichwertige Optionen unter Unix existieren, aber beim Kanaltyp „serieller Port“ angeboten werden.

# BEISPIELE

Eine Datei zum Schreiben öffnen, Erstellung erzwingen und einen Fehler auslösen, falls sie bereits existiert.

```
set myNewFile [open filename.txt {WRONLY CREAT EXCL}]
```

Eine Datei zum Schreiben als Protokolldatei öffnen.

```
set myLogFile [open filename.log "a"]
fconfigure $myLogFile -buffering line
```

Eine Befehlspipeline öffnen und Fehler abfangen:

```
set fl [open "| ls this_file_does_not_exist"]
set data [read $fl]
if {[catch {close $fl} err]} {
    puts "ls command failed: $err"
}
```

Eine Befehlspipeline öffnen und binäre Daten daraus lesen. Beachten Sie die ungewöhnliche Form mit „|[list“, die nicht triviale Randfälle mit Argumenten behandelt, die möglicherweise Leerzeichen enthalten.

```
set fl [open |[list create_image_data $input] "rb"]
set binData [read $fl]
close $fl
```

::: {.info -version="TIP160"}
Ein Passwort sicher vom Benutzer lesen (vorausgesetzt, das Skript wird interaktiv ausgeführt):
:::

```
chan configure stdin -inputmode password
try {
    chan puts -nonewline "Password: "
    chan flush stdout
    set thePassword [chan gets stdin]
} finally {
    chan configure stdin -inputmode reset
}
```

