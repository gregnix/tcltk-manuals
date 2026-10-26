---
CommandName: return
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - break(n)
 - catch(n)
 - continue(n)
 - dict(n)
 - error(n)
 - errorCode(n)
 - errorInfo(n)
 - proc(n)
 - source(n)
 - throw(n)
 - try(n)
Keywords:
 - break
 - catch
 - continue
 - error
 - exception
 - procedure
 - result
 - return
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Contributions from Don Porter, NIST, 2003. (not subject to US copyright)
---

# NAME

return - Kehrt aus einer Prozedur zurück oder setzt den Rückgabecode eines Skripts

# ÜBERSICHT

::: {.synopsis} :::
[return]{.cmd} [result]{.optarg} 
[return]{.cmd} [-code code]{.optarg} [result]{.optarg} 
[return]{.cmd} [option value]{.optdot} [result]{.optarg} 
:::

# BESCHREIBUNG

In der einfachsten Form beendet **return** ohne Optionen im Prozedurrumpf sofort die Ausführung und gibt die Kontrolle an den Aufrufer zurück. Mit *result* wird dieser Wert zum Ergebnis der Prozedur; ohne *result* eine leere Zeichenkette.

In von **source** ausgewerteten Skriptdateien beendet **return** die Skriptauswertung; *result* (oder eine leere Zeichenkette) wird Ergebnis von **source**.

## Ausnahmerückgabecodes

Mit **-code** kann die Prozedur außergewöhnlich zurückkehren. *code* kann sein:

**ok** (oder **0**)
: Normaler Return; Rückgabecode 0 (**TCL_OK**).

**error** (oder **1**)
: Fehler-Return; Rückgabecode 1 (**TCL_ERROR**). Der Prozedurbefehl verhält sich im Aufrufkontext wie **error** *result*. Weitere Optionen siehe unten.

**return** (oder **2**)
: Rückgabecode 2 (**TCL_RETURN**); Verhalten wie **return** ohne Argumente.

**break** (oder **3**)
: Rückgabecode 3 (**TCL_BREAK**); Verhalten wie **break**.

**continue** (oder **4**)
: Rückgabecode 4 (**TCL_CONTINUE**); Verhalten wie **continue**.

*value*
: Ganzzahl als Rückgabecode (Anwendungen/Pakete: 5–1073741823; außerhalb reserviert für Tcl).

Ungültige Argumente vom Aufrufer melden mit **return -code error** und passender Meldung in *result*. **return -code** dient sonst vor allem neuen Kontrollstrukturen.

**return -code** in von **source** ausgewerteten Dateien setzt den Rückgabecode von **source** auf *code*.

## Rückgabeoptionen

Neben Ergebnis und Rückgabecode liefert jede Befehlsauswertung ein Dictionary von Rückgabeoptionen. Alle *option value*-Paare von **return** werden Einträge (mit Ausnahmen unten). **catch** kann Rückgabecode, Ergebnis und Dictionary erfassen.

**-code** wird von Tcl speziell behandelt. Weitere spezielle Optionen:

**-errorcode** *list*
: Nur bei **-code** **TCL_ERROR**. Zusatzinformation als Tcl-Liste für Programme. Ohne Angabe bei **-code error**: Standard **NONE**; auch in **errorCode**.

**-errorinfo** *info*
: Nur bei **TCL_ERROR**. Dann ist *info* der anfängliche Stack-Trace mit Zusatzinformationen zum Fehlerkontext für Menschen; er wird auch in **errorInfo** gespeichert. Ohne **-errorinfo** bei **-code error** setzt Tcl einen eigenen anfänglichen Stack-Trace: nur der Prozeduraufruf; beim Unwinden kommen höhere Ebenen hinzu, nicht der Kontext innerhalb der Prozedur. Typisch stammt *info* aus **-errorinfo** eines von **catch** erfassten Rückgabeoptionen-Dictionarys (oder aus **errorInfo**).

**-errorstack** *list*
: Nur bei **TCL_ERROR**. Dann ist *list* der anfängliche Fehler-Stack mit den tatsächlich übergebenen Argumentwerten je Prozedurebene; erreichbar auch über **info errorstack**. Ohne **-errorstack** bei **-code error** liefert Tcl einen eigenen anfänglichen Fehler-Stack (nur Prozeduraufruf; Unwinden ergänzt höhere Ebenen). Typisch stammt *list* aus **-errorstack** eines von **catch** erfassten Dictionarys (oder von **info errorstack**).

**-level** *level*
: **-level** und **-code** setzen gemeinsam den Rückgabecode eines der gerade ausgewerteten Befehle. *level* ist eine nicht-negative Ganzzahl: Anzahl Ebenen auf dem Aufrufstack, auf denen der Rückgabecode *code* gelten soll. Ohne **-level** ist der Standard 1 — **return** setzt den Code, den die aktuelle Prozedur an ihren Aufrufer zurückgibt. Details siehe unten.

**-options** *options*
: Gültiges Dictionary; Einträge werden zusätzliche *option value*-Paare für **return**.

## Rückgabecode-Behandlung

Rückgabecodes steuern den Programmfluss in Tcl. Ein Skript ist eine Folge von Befehlen. Liefert jede Auswertung **TCL_OK**, geht es zum nächsten Befehl. Jeder außergewöhnliche Code (ungleich **TCL_OK**) unterbricht den weiteren Ablauf: die Skriptauswertung endet, und der Code wird Ergebnis der gesamten Auswertung. So führen Fehler zum Unterbrechen und Unwinden des Aufrufstapels; so bewirken **break**, **continue** und **return**, dass nicht alle Befehle nacheinander laufen.

Einige eingebaute Befehle werten Skripte aus und nutzen außergewöhnliche Codes für Sonderfunktionen. Schleifenbefehle wie **while**, **for** und **foreach** werten den Schleifenrumpf aus; liefert der Rumpf **TCL_BREAK** oder **TCL_CONTINUE**, reagieren sie so, dass **break** und **continue** in Schleifen ihre dokumentierte Wirkung haben.

Prozeduraufrufe werten den Prozedurrumpf aus. Liefert der Rumpf **TCL_RETURN**, wird der Eintrag **-level** im Rückgabeoptionen-Dictionary dekrementiert. Ist **-level** danach 0, wird **-code** zum Rückgabecode der Prozedur. Ist **-level** danach größer als 0, bleibt der Prozedur-Rückgabecode **TCL_RETURN**. Erfolgte der Aufruf während der Auswertung einer anderen Prozedur, wiederholt sich der Vorgang aufwärts: **-level** wird je Ebene dekrementiert, bis *code* der Rückgabecode des Befehls *level* Ebenen höher ist. **source** behandelt **TCL_RETURN** analog — daher ähnelt **return** in **source** dem **return** in einer Prozedur.

Der Rückgabecode des **return**-Befehls selbst löst dieselbe Sonderbehandlung aus. Mit **return -level 0** ist der Rückgabecode des **return**-Befehls *code* aus **-code** (Standard **TCL_OK**). Jeder andere **-level**-Wert (einschließlich Standard 1) macht den Rückgabecode des **return**-Befehls zu **TCL_RETURN** und löst Return aus der umgebenden Prozedur aus.

# BEISPIELE

Vorzeitiger Return aus einer Prozedur:

```
proc printOneLine {} {
    puts "line 1"    ;# wird ausgegeben
    return
    puts "line 2"    ;# wird nicht ausgegeben
}
```

Rückgabewert setzen:

```
proc returnX {} {return X}
puts [returnX]    ;# gibt X aus
```

Ungültige Argumente mit **return -code error**:

```
proc factorial {n} {
    if {![string is integer $n] || ($n < 0)} {
        return -code error \
                "expected non-negative integer, but got \"$n\""
    }
    if {$n < 2} {
        return 1
    }
    set factor [factorial [expr {$n - 1}]]
    set product [expr {$n * $factor}]
    return $product
}
```

Ersatz für **break**:

```
proc myBreak {} {
    return -code break
}
```

Mit **return -level 0** und **interp alias** als **break**-Ersatz:

```
interp alias {} Break {} return -level 0 -code break
```

Fehler mit **catch** und **return -options** erneut auslösen:

```
proc doSomething {} {
    set resource [allocate]
    catch {
        # langes Skript, das einen Fehler auslösen kann
    } result options
    deallocate $resource
    return -options $options $result
}
```

Erweitert: Prozedur-Ersatz für **return** selbst:

```
proc myReturn {args} {
    set result ""
    if {[llength $args] % 2} {
        set result [lindex $args end]
        set args [lrange $args 0 end-1]
    }
    set options [dict merge {-level 1} $args]
    dict incr options -level
    return -options $options $result
}
```
