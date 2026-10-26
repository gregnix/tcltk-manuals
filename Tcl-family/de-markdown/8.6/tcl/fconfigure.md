---
CommandName: fconfigure
title: fconfigure
ManualSection: n
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - close(n)
 - flush(n)
 - gets(n)
 - open(n)
 - puts(n)
 - read(n)
 - socket(n)
 - Tcl_StandardChannels(3)
Keywords:
 - blocking
 - buffering
 - carriage return
 - end of line
 - flushing
 - linemode
 - newline
 - nonblocking
 - platform
 - translation
 - encoding
 - filter
 - byte array
 - binary
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

fconfigure - Legt Kanaloptionen fest und gibt sie zurück

# Übersicht

::: {.synopsis} :::
[fconfigure]{.cmd} [channelId]{.arg}
[fconfigure]{.cmd} [channelId]{.arg} [name]{.arg}
[fconfigure]{.cmd} [channelId]{.arg} [name]{.arg} [value]{.arg} [name value]{.optdot}
:::

# Beschreibung

Der Befehl **fconfigure** legt Kanaloptionen fest und gibt sie zurück.

*ChannelId* bezeichnet den Kanal, für den eine Option gesetzt oder abgefragt werden soll, und muss auf einen geöffneten Kanal verweisen — z. B. einen Tcl-Standardkanal (**stdin**, **stdout** oder **stderr**), den Rückgabewert eines Aufrufs von [open] oder [socket] oder das Ergebnis eines Kanalerzeugungsbefehls einer Tcl-Erweiterung.

Werden keine Argumente *name* oder *value* übergeben, gibt der Befehl eine Liste mit abwechselnd Optionsnamen und Werten für den Kanal zurück. Ist *name* angegeben, aber kein *value*, liefert der Befehl den aktuellen Wert der genannten Option. Werden ein oder mehrere Paare *name* und *value* übergeben, setzt der Befehl jede genannte Option auf den zugehörigen *value*; der Rückgabewert ist dann eine leere Zeichenkette.

Die unten beschriebenen Optionen werden für alle Kanäle unterstützt. Zusätzlich kann jeder Kanaltyp eigene Optionen anbieten. Siehe die Manpage des Befehls, der den jeweiligen Kanaltyp erzeugt; z. B. die Manpage von [socket] für Socket-Optionen und [open] für serielle Geräte.

**-blocking** *boolean*
: Die Option **-blocking** legt fest, ob E/A-Operationen auf dem Kanal den Prozess unbegrenzt blockieren können. Der Wert muss ein gültiger boolescher Wert sein. Kanäle sind normalerweise blockierend; im nicht-blockierenden Modus ändern sich [gets], [read], [puts], [flush] und [close] — sie können asynchron arbeiten; siehe deren Dokumentation. Damit der nicht-blockierende Modus korrekt funktioniert, muss die Anwendung die Tcl-Ereignisschleife nutzen (z. B. durch Aufruf von [Tcl\_DoOneEvent][DoOneEvent] oder [vwait]).

**-buffering** *newValue*
: Ist *newValue* **full**, puffert das E/A-System die Ausgabe, bis der interne Puffer voll ist oder [flush] aufgerufen wird. Ist *newValue* **line**, wird die Ausgabe automatisch geschrieben, sobald ein Zeilenumbruch ausgegeben wird. Ist *newValue* **none**, wird nach jeder Ausgabeoperation geschrieben. Standard ist **full**, außer bei Kanälen zu terminalähnlichen Geräten; dort ist der Anfangswert **line**. Zusätzlich sind **stdin** und **stdout** anfangs **line**, **stderr** ist **none**.

**-buffersize** *newSize*
: *Newvalue* muss eine Ganzzahl sein; sie legt die Größe in Bytes der für diesen Kanal angelegten Ein-/Ausgabepuffer fest. *Newvalue* muss zwischen eins und einer Million liegen (Puffer von einem Byte bis einer Million Bytes).

**-encoding** *name*
: Diese Option legt die Kanal-Kodierung fest, damit Daten für Tcl in Unicode umgewandelt werden können. Soll Tcl z. B. Zeichen aus einer japanischen Datei in **shiftjis** lesen und verarbeiten, wird die Kodierung auf **shiftjis** gesetzt; beim Lesen werden die Bytes in Unicode umgewandelt. Beim Schreiben werden Tcl-Zeichenketten beim Ausgeben in die gewählte Kodierung umgewandelt.

    Enthält eine Datei reine Binärdaten (z. B. ein JPEG), sollte die Kodierung [binary] sein. Tcl interpretiert die Daten dann nicht und liest oder schreibt rohe Bytes. Der Befehl [binary] kann diese byteorientierten Daten bearbeiten. Oft ist **-translation** [binary] beim Übertragen von Binärdaten besser, weil damit weitere automatische Interpretationen der Bytes im Strom abgeschaltet werden.

    Die Standard-Kodierung neu geöffneter Kanäle ist die plattform- und locale-abhängige Systemkodierung von [encoding system][encoding].

**-eofchar** *char*
: siehe unten ...

**-eofchar** **{***inChar outChar***}**
: Diese Option unterstützt DOS-Dateisysteme, die Control-z (\\x1A) als Dateiende-Marker verwenden. Ist *char* nicht die leere Zeichenkette, signalisiert dieses Zeichen beim Lesen Dateiende. Beim Schreiben wird das Dateiende-Zeichen beim Schließen des Kanals ausgegeben. Ist *char* leer, gibt es keinen speziellen Dateiende-Marker. Bei Lese-Schreib-Kanälen legt eine zweielementige Liste getrennte Marker für Eingabe und Ausgabe fest. Beim Setzen für Lese-Schreib-Kanäle kann ein einzelner Wert für beide Richtungen angegeben werden. Beim Abfragen wird stets eine zweielementige Liste zurückgegeben. Standard für **-eofchar** ist die leere Zeichenkette, außer unter Windows: dort ist **-eofchar** beim Lesen Control-z (\\x1A) und beim Schreiben leer. Zulässig sind Werte von \\x01 - \\x7F; Werte außerhalb dieses Bereichs erzeugen einen Fehler.

**-translation** *mode*
: siehe unten ...

**-translation** **{***inMode outMode***}**
: In Tcl-Skripten steht das Zeilenende stets als ein einzelnes Newline (\\n). In Dateien und Geräten kann es je nach Plattform oder Gerät unterschiedlich dargestellt sein (z. B. unter UNIX Newlines in Dateien, in Netzwerkverbindungen oft Wagenrücklauf-Zeilenvorschub). Beim Lesen ([gets], [read]) wandelt das Tcl-E/A-System die externe Darstellung in Newlines um; beim Schreiben ([puts]) umgekehrt. Der Standardmodus **auto** behandelt die üblichen Fälle; **-translation** erlaubt explizite Steuerung.

    Der Wert von **-translation** ist bei Nur-Lese- und Nur-Schreib-Kanälen ein einzelnes Element, bei Lese-Schreib-Kanälen eine zweielementige Liste (Lesen, dann Schreiben). Beim Setzen für Lese-Schreib-Kanäle kann ein Wert für beide Richtungen gelten; beim Abfragen wird stets eine Liste zurückgegeben. Unterstützt werden derzeit:

    **auto**
    : Als Eingabeübersetzungsmodus behandelt **auto** jedes von Newline (**lf**), Wagenrücklauf (**cr**) oder Wagenrücklauf gefolgt von einem Zeilenvorschub (**crlf**) als Zeilenende-Darstellung. Die Zeilenende-Darstellung kann sogar von Zeile zu Zeile wechseln; alle Fälle werden in ein Newline übersetzt. Als Ausgabeübersetzungsmodus wählt **auto** eine plattformspezifische Darstellung; für Sockets auf allen Plattformen wählt Tcl **crlf**, für alle Unix-Varianten **lf** und für die verschiedenen Windows-Varianten **crlf**. Die Standardeinstellung für **-translation** ist **auto** sowohl für Eingabe als auch Ausgabe.

    [binary]
    : Es erfolgen keine Zeilenende-Übersetzungen. Das entspricht fast dem Modus **lf**, setzt zusätzlich aber **-eofchar** auf die leere Zeichenkette (deaktiviert) und **-encoding** auf [binary] (deaktiviert Kodierungsfilter). Siehe **-eofchar** und **-encoding**.

        Intern verhält sich dieser Wert beim Übersetzer **wie** **lf** und wird deshalb beim Abfragen als solcher gemeldet — auch wenn die Übersetzung mit [binary] gesetzt wurde.

    **cr**
    : Das Zeilenende in der zugrunde liegenden Datei oder dem Gerät ist ein Wagenrücklauf. Im Eingabemodus **cr** werden Wagenrückläufe in Newlines umgewandelt; im Ausgabemodus werden Newlines in Wagenrückläufe umgewandelt.

    **crlf**
    : Das Zeilenende ist Wagenrücklauf gefolgt von Zeilenvorschub. Im Eingabemodus **crlf** werden solche Sequenzen in Newlines umgewandelt; im Ausgabemodus werden Newlines in Wagenrücklauf-Zeilenvorschub umgewandelt. Typisch unter Windows und in Netzwerkverbindungen.

    **lf**
    : Das Zeilenende ist ein einzelnes Newline (Zeilenvorschub). Es erfolgt keine Übersetzung bei Eingabe oder Ausgabe. Typisch unter UNIX.



# Standardkanäle

Die Tcl-Standardkanäle (**stdin**, **stdout** und **stderr**) lassen sich wie jeder andere von der Tcl-Bibliothek geöffnete Kanal über diesen Befehl konfigurieren. Neben den oben beschriebenen Standardoptionen unterstützen sie je nach aktuellem Typ auch spezielle Optionen. Wird eine Tcl-Anwendung z. B. vom unter Unix üblichen **inet**-Superserver gestartet, sind die Tcl-Standardkanäle Sockets und unterstützen damit die Socket-Optionen.

# Beispiele

Weisen Sie Tcl an, Ausgabe auf **stdout** sofort zu senden, unabhängig davon, ob es an ein Terminal geht:

```
fconfigure stdout -buffering none
```

Einen Socket öffnen und Zeilen daraus lesen, ohne jemals die Verarbeitung anderer Ereignisse zu blockieren:

```
set s [socket some.where.com 12345]
fconfigure $s -blocking 0
fileevent $s readable "readMe $s"
proc readMe chan {
    if {[gets $chan line] < 0} {
        if {[eof $chan]} {
            close $chan
            return
        }
        # Could not read a complete line this time; Tcl's
        # internal buffering will hold the partial line for us
        # until some more data is available over the socket.
    } else {
        puts stdout $line
    }
}
```

Ein PPM-Bild aus einer Datei lesen:

```
# Open the file and put it into Unix ASCII mode
set f [open teapot.ppm]
fconfigure $f -encoding ascii -translation lf

# Get the header
if {[gets $f] ne "P6"} {
    error "not a raw-bits PPM"
}

# Read lines until we have got non-comment lines
# that supply us with three decimal values.
set words {}
while {[llength $words] < 3} {
    gets $f line
    if {[string match "#*" $line]} continue
    lappend words {*}[join [scan $line %d%d%d]]
}

# Those words supply the size of the image and its
# overall depth per channel. Assign to variables.
lassign $words xSize ySize depth

# Now switch to binary mode to pull in the data,
# one byte per channel (red,green,blue) per pixel.
fconfigure $f -translation binary
set numDataBytes [expr {3 * $xSize * $ySize}]
set data [read $f $numDataBytes]

close $f
```


[binary]: binary.md
[close]: close.md
[DoOneEvent]: ../tcl-c/DoOneEvent.md
[encoding]: encoding.md
[flush]: flush.md
[gets]: gets.md
[open]: open.md
[puts]: puts.md
[read]: read.md
[socket]: socket.md
[vwait]: vwait.md
