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

Die unten beschriebenen Optionen werden für alle Kanäle unterstützt. Zusätzlich kann jeder Kanaltyp Optionen hinzufügen, die nur er unterstützt. Welche Optionen ein bestimmter Kanaltyp unterstützt, entnehmen Sie der Manpage des Befehls, der Kanäle dieses Typs erzeugt. Zusätzliche Optionen für Sockets finden Sie zum Beispiel in der Manpage des Befehls [socket], zusätzliche Optionen für serielle Geräte in der Manpage des Befehls [open].

**-blocking** *boolean*
: Die Option **-blocking** legt fest, ob E/A-Operationen auf dem Kanal den Prozess unbegrenzt blockieren können. Der Wert der Option muss ein gültiger boolescher Wert sein. Kanäle sind normalerweise im blockierenden Modus. Wird ein Kanal in den nicht-blockierenden Modus versetzt, wirkt sich das auf die Befehle [gets], [read], [puts], [flush] und [close] aus: Sie können dann asynchron arbeiten. Einzelheiten finden Sie in der Dokumentation dieser Befehle. Damit der nicht-blockierende Modus korrekt funktioniert, muss die Anwendung die Tcl-Ereignisschleife verwenden (z. B. durch Aufruf von [Tcl\_DoOneEvent][DoOneEvent] oder des Befehls [vwait]).

**-buffering** *newValue*
: Ist *newValue* **full**, puffert das E/A-System die Ausgabe, bis sein interner Puffer voll ist oder der Befehl [flush] aufgerufen wird. Ist *newValue* **line**, leert das E/A-System die Ausgabe für den Kanal automatisch, sobald ein Zeilenumbruchzeichen ausgegeben wird. Ist *newValue* **none**, leert das E/A-System nach jeder Ausgabeoperation automatisch. Standardmäßig ist **-buffering** auf **full** gesetzt, außer bei Kanälen, die mit terminalähnlichen Geräten verbunden sind; für diese Kanäle ist die Anfangseinstellung **line**. Zusätzlich sind **stdin** und **stdout** anfangs auf **line** gesetzt und **stderr** auf **none**.

**-buffersize** *newSize*
: *Newvalue* muss eine Ganzzahl sein; ihr Wert legt die Größe der Puffer in Bytes fest, die für diesen Kanal anschließend zum Speichern von Ein- oder Ausgaben angelegt werden. *Newvalue* muss zwischen eins und einer Million liegen, sodass Puffer von einem bis zu einer Million Bytes Größe möglich sind.

**-encoding** *name*
: Mit dieser Option legen Sie die Kodierung des Kanals fest, damit die Daten für die Verwendung in Tcl nach Unicode und aus Unicode umgewandelt werden können. Damit Tcl beispielsweise Zeichen aus einer japanischen Datei in **shiftjis** lesen und den Inhalt korrekt verarbeiten und anzeigen kann, würde die Kodierung auf **shiftjis** gesetzt. Danach werden beim Lesen vom Kanal die Bytes der japanischen Datei bereits beim Einlesen nach Unicode umgewandelt. Schreiben wird ebenfalls unterstützt: Tcl-Zeichenketten, die auf den Kanal geschrieben werden, werden bei der Ausgabe automatisch in die angegebene Kodierung umgewandelt.

    Enthält eine Datei reine Binärdaten (z. B. ein JPEG-Bild), sollte die Kodierung des Kanals auf [binary] eingestellt werden. Tcl interpretiert die Daten in der Datei dann nicht, sondern liest oder schreibt einfach rohe Bytes. Mit dem Tcl-Befehl [binary] lassen sich diese byteorientierten Daten bearbeiten. Wenn Sie Binärdaten übertragen wollen, ist es in der Regel besser, die Option **-translation** auf [binary] zu setzen, da damit auch die anderen automatischen Interpretationen der Bytes im Strom abgeschaltet werden.

    Die Standardkodierung für neu geöffnete Kanäle ist dieselbe plattform- und localeabhängige Systemkodierung, die für die Schnittstelle zum Betriebssystem verwendet wird und die [encoding system][encoding] zurückgibt.

**-eofchar** *char*
: siehe unten ...

**-eofchar** **{***inChar outChar***}**
: Diese Option unterstützt DOS-Dateisysteme, die Control-z (\\x1A) als Dateiende-Markierung verwenden. Ist *char* keine leere Zeichenkette, signalisiert dieses Zeichen das Dateiende, wenn es bei der Eingabe auftritt. Bei der Ausgabe wird das Dateiende-Zeichen ausgegeben, wenn der Kanal geschlossen wird. Ist *char* die leere Zeichenkette, gibt es keine besondere Dateiende-Markierung. Bei Lese-Schreib-Kanälen gibt eine Liste mit zwei Elementen die Dateiende-Markierung für die Eingabe bzw. für die Ausgabe an. Der Einfachheit halber können Sie beim Setzen des Dateiende-Zeichens für einen Lese-Schreib-Kanal einen einzelnen Wert angeben, der für Lesen und Schreiben gilt. Beim Abfragen des Dateiende-Zeichens eines Lese-Schreib-Kanals wird immer eine Liste mit zwei Elementen zurückgegeben. Der Standardwert für **-eofchar** ist in allen Fällen die leere Zeichenkette, außer bei Dateien unter Windows. Dort ist **-eofchar** beim Lesen Control-z (\\x1A) und beim Schreiben die leere Zeichenkette. Der zulässige Bereich für **-eofchar**-Werte ist \\x01 - \\x7F; der Versuch, **-eofchar** auf einen Wert außerhalb dieses Bereichs zu setzen, erzeugt einen Fehler.

**-translation** *mode*
: siehe unten ...

**-translation** **{***inMode outMode***}**
: In Tcl-Skripten wird das Ende einer Zeile immer durch ein einzelnes Newline-Zeichen (\\n) dargestellt. In tatsächlichen Dateien und Geräten kann das Zeilenende jedoch auf verschiedenen Plattformen oder sogar für verschiedene Geräte auf derselben Plattform unterschiedlich dargestellt sein. Unter UNIX werden in Dateien beispielsweise Newlines verwendet, während in Netzwerkverbindungen normalerweise Wagenrücklauf-Zeilenvorschub-Sequenzen verwendet werden. Bei der Eingabe (d. h. mit [gets] und [read]) übersetzt das Tcl-E/A-System die externe Zeilenende-Darstellung automatisch in Newline-Zeichen. Bei der Ausgabe (d. h. mit [puts]) übersetzt das E/A-System Newlines in die externe Zeilenende-Darstellung. Der Standardübersetzungsmodus **auto** behandelt alle gängigen Fälle automatisch, aber die Option **-translation** bietet explizite Kontrolle über die Zeilenende-Übersetzungen.

    Der mit **-translation** verknüpfte Wert ist ein einzelnes Element für Nur-Lese- und Nur-Schreib-Kanäle. Für Lese-Schreib-Kanäle ist der Wert eine Liste mit zwei Elementen; der Leseübersetzungsmodus ist das erste Element der Liste, der Schreibübersetzungsmodus das zweite. Der Einfachheit halber können Sie beim Setzen des Übersetzungsmodus für einen Lese-Schreib-Kanal einen einzelnen Wert angeben, der für Lesen und Schreiben gilt. Beim Abfragen des Übersetzungsmodus eines Lese-Schreib-Kanals wird immer eine Liste mit zwei Elementen zurückgegeben. Derzeit werden folgende Werte unterstützt:

    **auto**
    : Als Eingabeübersetzungsmodus behandelt **auto** jedes von Newline (**lf**), Wagenrücklauf (**cr**) oder Wagenrücklauf gefolgt von einem Zeilenvorschub (**crlf**) als Zeilenende-Darstellung. Die Zeilenende-Darstellung kann sogar von Zeile zu Zeile wechseln; alle Fälle werden in ein Newline übersetzt. Als Ausgabeübersetzungsmodus wählt **auto** eine plattformspezifische Darstellung; für Sockets auf allen Plattformen wählt Tcl **crlf**, für alle Unix-Varianten **lf** und für die verschiedenen Windows-Varianten **crlf**. Die Standardeinstellung für **-translation** ist **auto** sowohl für Eingabe als auch Ausgabe.

    [binary]
    : Es werden keine Zeilenende-Übersetzungen durchgeführt. Das ist nahezu identisch mit dem Modus **lf**, außer dass der Modus [binary] zusätzlich das Dateiende-Zeichen auf die leere Zeichenkette setzt (wodurch es deaktiviert wird) und die Kodierung auf [binary] setzt (wodurch die Kodierungsfilterung deaktiviert wird). Weitere Informationen finden Sie in der Beschreibung von **-eofchar** und **-encoding**.

        Intern, d. h. was das tatsächliche Verhalten des Übersetzers betrifft, **ist** dieser Wert identisch mit **lf** und wird deshalb beim Abfragen auch als solcher gemeldet, selbst wenn die Übersetzung mit [binary] gesetzt wurde.

    **cr**
    : Das Ende einer Zeile in der zugrunde liegenden Datei oder dem Gerät wird durch ein einzelnes Wagenrücklauf-Zeichen dargestellt. Als Eingabeübersetzungsmodus wandelt der Modus **cr** Wagenrückläufe in Newline-Zeichen um. Als Ausgabeübersetzungsmodus übersetzt der Modus **cr** Newline-Zeichen in Wagenrückläufe.

    **crlf**
    : Das Ende einer Zeile in der zugrunde liegenden Datei oder dem Gerät wird durch ein Wagenrücklauf-Zeichen gefolgt von einem Zeilenvorschub-Zeichen dargestellt. Als Eingabeübersetzungsmodus wandelt der Modus **crlf** Wagenrücklauf-Zeilenvorschub-Sequenzen in Newline-Zeichen um. Als Ausgabeübersetzungsmodus übersetzt der Modus **crlf** Newline-Zeichen in Wagenrücklauf-Zeilenvorschub-Sequenzen. Dieser Modus wird typischerweise auf Windows-Plattformen und für Netzwerkverbindungen verwendet.

    **lf**
    : Das Ende einer Zeile in der zugrunde liegenden Datei oder dem Gerät wird durch ein einzelnes Newline- (Zeilenvorschub-)Zeichen dargestellt. In diesem Modus erfolgen weder bei der Eingabe noch bei der Ausgabe Übersetzungen. Dieser Modus wird typischerweise auf UNIX-Plattformen verwendet.



# Standardkanäle

Die Tcl-Standardkanäle (**stdin**, **stdout** und **stderr**) lassen sich wie jeder andere von der Tcl-Bibliothek geöffnete Kanal über diesen Befehl konfigurieren. Neben den oben beschriebenen Standardoptionen unterstützen sie je nach aktuellem Typ auch spezielle Optionen. Wird eine Tcl-Anwendung z. B. vom unter Unix üblichen **inet**-Superserver gestartet, sind die Tcl-Standardkanäle Sockets und unterstützen damit die Socket-Optionen.

# Beispiele

Tcl anweisen, Ausgaben auf **stdout** immer sofort zu senden, unabhängig davon, ob sie an ein Terminal gehen:

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
