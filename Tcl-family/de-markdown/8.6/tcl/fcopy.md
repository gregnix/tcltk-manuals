---
CommandName: fcopy
title: fcopy
ManualSection: n
Version: 8.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - eof(n)
 - fblocked(n)
 - fconfigure(n)
 - file(n)
Keywords:
 - blocking
 - channel
 - end of line
 - end of file
 - nonblocking
 - read
 - translation
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

fcopy - Daten von einem Kanal in einen anderen kopieren

# Übersicht

::: {.synopsis} :::
[fcopy]{.cmd} [inchan]{.arg} [outchan]{.arg} [[-size]{.lit} [size]{.arg}]{.optarg} [[-command]{.lit} [callback]{.arg}]{.optarg}
:::

# Beschreibung

Der Befehl **fcopy** kopiert Daten von einem Ein-/Ausgabekanal *inchan* auf einen anderen Ein-/Ausgabekanal *outchan*. **fcopy** nutzt die Pufferung des Tcl-Ein-/Ausgabesystems, damit keine zusätzlichen Kopien entstehen und beim Kopieren großer Dateien auf langsame Ziele wie Netzwerksockets nicht zu viele Daten im Hauptspeicher liegen.

**fcopy** überträgt Daten von *inchan*, bis Dateiende erreicht ist oder *size* Bytes oder Zeichen übertragen wurden. *size* gilt in Bytes, wenn beide Kanäle dieselbe Kodierung verwenden, sonst in Zeichen. Fehlt **-size**, läuft die Kopie bis zum Dateiende. Alle von *inchan* gelesenen Daten werden nach *outchan* kopiert. Ohne **-command** blockiert **fcopy**, bis die Kopie fertig ist, und gibt die Anzahl der nach *outchan* geschriebenen Bytes oder Zeichen zurück (dieselben Regeln wie bei **-size**).

Das Argument **-command** lässt **fcopy** im Hintergrund arbeiten. Der Befehl kehrt dann sofort zurück, und *callback* wird später aufgerufen, wenn die Kopie fertig ist. *callback* erhält ein oder zwei zusätzliche Argumente, die angeben, wie viele Bytes nach *outchan* geschrieben wurden. Trat beim Kopieren im Hintergrund ein Fehler auf, ist das zweite Argument die zum Fehler gehörende Fehlermeldung. Bei einer Hintergrundkopie müssen *inchan* und *outchan* nicht in den nicht-blockierenden Modus gesetzt werden; **fcopy** erledigt das. Die Ereignisschleife muss aber mit [vwait] oder mit Tk betreten werden.

Während eines **fcopy** im Hintergrund sind andere Eingabeoperationen auf *inchan* und Ausgabeoperationen auf *outchan* nicht zulässig. Die Gegenrichtung ist zulässig, wie das bidirektionale Beispiel unten zeigt.

Wird *inchan* oder *outchan* geschlossen, während die Kopie läuft, stoppt die aktuelle Kopie, und der Rückruf wird *nicht* ausgeführt. Wird *inchan* geschlossen, werden alle für *outchan* schon eingereihten Daten noch geschrieben.

*inchan* kann während einer Hintergrundkopie lesbar werden. [fileevent]-Handler sollten während einer Hintergrundkopie abgeschaltet werden, damit sie die Kopie nicht stören. Ein-/Ausgabe auf der falschen Seite (durch einen [fileevent]-Handler oder sonst) ergibt den Fehler „channel busy“.

**fcopy** übersetzt Zeilenende-Folgen in *inchan* und *outchan* gemäß der Option **-translation** dieser Kanäle. Einzelheiten stehen in der Handbuchseite [fconfigure]. Durch die Übersetzung kann die Zahl der von *inchan* gelesenen Bytes von der Zahl der nach *outchan* geschriebenen Bytes abweichen. Gemeldet wird nur die nach *outchan* geschriebene Bytezahl, entweder als Rückgabewert eines synchronen **fcopy** oder als Argument des Rückrufs eines asynchronen **fcopy**.

**fcopy** beachtet die für die Kanäle eingestellten Kodierungen und Zeichenübersetzungen. Eingehende Zeichen werden intern zuerst nach UTF-8 und dann in die Kodierung des Kanals umgewandelt, in den **fcopy** schreibt. Einzelheiten zu **-encoding** und **-translation** stehen in der Handbuchseite [fconfigure]. Stehen beide Kanäle auf der Kodierung „binary“ und passen die Übersetzungen zusammen, findet keine Umwandlung statt. Steht nur der Ausgabekanal auf „binary“, schreibt das System die interne UTF-8-Darstellung der eingehenden Zeichen. Steht nur der Eingabekanal auf „binary“, nimmt das System an, dass die eingehenden Bytes gültige UTF-8-Zeichen sind, und wandelt sie gemäß der Ausgabekodierung um. Das Verhalten bei Bytes, die keine gültigen UTF-8-Zeichen sind, ist in diesem Fall undefiniert.

# Beispiele

Das erste Beispiel überträgt den Inhalt eines Kanals exakt auf einen anderen. Beim Kopieren einer Datei auf eine andere ist [file copy][file] besser geeignet, da dabei auch Dateimetadaten (z. B. Zugriffsrechte) kopiert werden, wo möglich.

```
fconfigure $in -translation binary
fconfigure $out -translation binary
fcopy $in $out
```

Das zweite Beispiel zeigt, wie der Rückruf die Zahl der übertragenen Bytes erhält. Es verwendet vwait, damit die Anwendung in die Ereignisschleife geht. Dieses vereinfachte Beispiel käme auch ohne den Befehlsrückruf aus.

```
proc Cleanup {in out bytes {error {}}} {
    global total
    set total $bytes
    close $in
    close $out
    if {[string length $error] != 0} {
        # Fehler während der Kopie
    }
}
set in [open $file1]
set out [socket $server $port]
fcopy $in $out -command [list Cleanup $in $out]
vwait total
```

Das dritte Beispiel kopiert in Stücken und prüft im Befehlsrückruf auf Dateiende.

```
proc CopyMore {in out chunk bytes {error {}}} {
    global total done
    incr total $bytes
    if {([string length $error] != 0) || [eof $in]} {
        set done $total
        close $in
        close $out
    } else {
        fcopy $in $out -size $chunk \
                -command [list CopyMore $in $out $chunk]
    }
}
set in [open $file1]
set out [socket $server $port]
set chunk 1024
set total 0
fcopy $in $out -size $chunk \
        -command [list CopyMore $in $out $chunk]
vwait done
```

Das vierte Beispiel startet ein asynchrones, bidirektionales fcopy zwischen zwei Sockets. Das können auch Pipes aus zwei \[open "|hal 9000" r+\] sein (ihr Gespräch bliebe dem Skript verborgen, weil alle vier fileevent-Plätze belegt sind).

```
set flows 2
proc Done {dir args} {
     global flows done
     puts "$dir is over."
     incr flows -1
     if {$flows<=0} {set done 1}
}
fcopy $sok1 $sok2 -command [list Done UP]
fcopy $sok2 $sok1 -command [list Done DOWN]
vwait done
```


[fconfigure]: fconfigure.md
[file]: file.md
[fileevent]: fileevent.md
[vwait]: vwait.md
