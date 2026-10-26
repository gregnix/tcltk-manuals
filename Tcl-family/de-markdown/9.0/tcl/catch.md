---
CommandName: catch
title: catch
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - break(n)
 - continue(n)
 - dict(n)
 - error(n)
 - errorCode(n)
 - errorInfo(n)
 - info(n)
 - return(n)
Keywords:
 - catch
 - error
 - exception
Copyright:
 - Copyright (c) 1993-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

catch - Wertet ein Skript aus und fängt außergewöhnliche Rückgaben ab

# Übersicht

::: {.synopsis} :::
[catch]{.cmd} [script]{.arg} [resultVarName]{.optarg} [optionsVarName]{.optarg}
:::

# Beschreibung

Der Befehl **catch** verhindert, dass Fehler die Befehlsauswertung abbrechen. **catch** ruft den Tcl-Interpreter rekursiv auf, um *script* auszuführen, und kehrt stets ohne Fehler zurück — unabhängig davon, ob bei der Ausführung von *script* Fehler auftreten.

Löst *script* einen Fehler aus, gibt **catch** eine von Null verschiedene Ganzzahl zurück, die dem außergewöhnlichen Rückgabecode der Skriptauswertung entspricht. Tcl definiert den normalen Rückgabecode als Null (0) bzw. **TCL\_OK**. Vier außergewöhnliche Rückgabecodes sind: 1 (**TCL\_ERROR**), 2 (**TCL\_RETURN**), 3 (**TCL\_BREAK**) und 4 (**TCL\_CONTINUE**). Fehler während der Skriptauswertung entsprechen **TCL\_ERROR**. Die anderen außergewöhnlichen Codes liefern [return], [break] und [continue] sowie in der Dokumentation beschriebene Sonderfälle. Neue Befehle aus Tcl-Paketen und Skripte mit [return -code][return] können andere Ganzzahlen zurückgeben; diese müssen außerhalb des für Tcl reservierten Bereichs liegen (siehe [return]).

Ist *resultVarName* angegeben, wird die benannte Variable auf das Ergebnis der Skriptauswertung gesetzt. Ist der Rückgabecode 1 (**TCL\_ERROR**), enthält *resultVarName* eine Fehlermeldung. Ist der Rückgabecode 0 (**TCL\_OK**), enthält *resultVarName* den von *script* zurückgegebenen Wert.

Ist *optionsVarName* angegeben, wird die benannte Variable auf ein Dictionary der Rückgabeoptionen gesetzt. Tcl definiert stets die Einträge **-code** und **-level**. Ist der Rückgabecode nicht **TCL\_RETURN**, ist **-level** 0 und **-code** entspricht dem Rückgabecode. Nur bei **TCL\_RETURN** können **-level** und **-code** andere Werte annehmen (siehe [return]).

Bei **TCL\_ERROR** enthält das Dictionary vier weitere Einträge: **-errorinfo**, **-errorcode**, **-errorline** und **-errorstack**. **-errorinfo** ist ein formatierter Stack-Trace für Menschen. **-errorcode** ist zusätzliche Fehlerinformation als Liste für Programme. **-errorline** ist die Zeilennummer in *script*, in der der Fehler auftrat. **-errorstack** ist eine Liste gerader Länge aus Token-Parameter-Paaren beim Stack-Unwinden: Token **CALL** mit Prozedurname und Argumenten der Ebene, oder **UP** mit relativer Ebene (wie bei [uplevel]) zur vorherigen **CALL**. Unterschiede zu **-errorinfo**:

1. maschinenlesbare Form, geeignet für \[[foreach] {tok prm} …\],

2. echte (substituierte) Argumentwerte statt statischem Aufruftext,

3. gröbere Granularität: ein Element pro Stack-Frame (keine separaten Elemente für [foreach]-Konstrukte).


Die Werte von **-errorinfo** und **-errorcode** des letzten Fehlers stehen auch in **::errorInfo** und **::errorCode**. **-errorstack** entspricht [info errorstack][info].

Tcl-Pakete können weitere Dictionary-Einträge setzen; Skripte können mit [return] zusätzliche Rückgabeoptionen setzen.

# Beispiele

**catch** eignet sich in [if], um nach Erfolg eines Skripts zu verzweigen:

```
if { [catch {open $someFile w} fid] } {
    puts stderr "Could not open $someFile for writing\n$fid"
    exit 1
}
```

Weitere **catch**-Beispiele stehen in der Dokumentation zu [return].


[break]: break.md
[continue]: continue.md
[foreach]: foreach.md
[if]: if.md
[info]: info.md
[return]: return.md
[uplevel]: uplevel.md
