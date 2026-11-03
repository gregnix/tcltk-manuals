---
CommandName: return
title: return
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
---

# Name

return - Kehrt aus einer Prozedur zurück oder setzt den Rückgabecode eines Skripts

# Übersicht

::: {.synopsis} :::
[return]{.cmd} [result]{.optarg}
[return]{.cmd} [[-code]{.lit} [code]{.arg}]{.optarg} [result]{.optarg}
[return]{.cmd} [option value]{.optdot} [result]{.optarg}
:::

# Beschreibung

In der einfachsten Verwendung steht der Befehl **return** ohne Optionen im Rumpf einer Prozedur und gibt die Kontrolle sofort an den Aufrufer der Prozedur zurück. Ist ein Argument *result* angegeben, wird sein Wert zum Ergebnis der Prozedur, das an den Aufrufer zurückgegeben wird. Ist *result* nicht angegeben, wird dem Aufrufer eine leere Zeichenkette als Ergebnis der Prozedur zurückgegeben.

In Skriptdateien, die mit dem Befehl [source] ausgewertet werden, erfüllt der Befehl **return** eine ähnliche Aufgabe. Wenn [source] den Inhalt einer Datei als Skript auswertet, beendet ein Aufruf des Befehls **return** die Skriptauswertung sofort, und der Wert *result* (oder eine leere Zeichenkette) wird als Ergebnis des Befehls [source] zurückgegeben.

# Ausnahmerückgabecodes

Neben dem Ergebnis einer Prozedur kann **return** über die Option **-code** auch den Rückgabecode der Prozedur festlegen. Im üblichen Fall, wenn die Option **-code** nicht angegeben ist, kehrt die Prozedur normal zurück. Mit der Option **-code** lässt sich jedoch eine außergewöhnliche Rückkehr aus der Prozedur erzeugen. *Code* kann einen der folgenden Werte haben:

**ok** (oder **0**)
: Normale Rückkehr: wie wenn die Option weggelassen wird. Der Rückgabecode der Prozedur ist 0 ([TCL\_OK][catch]).

[error] (oder **1**)
: Rückkehr mit Fehler: Der Rückgabecode der Prozedur ist 1 ([TCL\_ERROR][catch]). Der Prozeduraufruf verhält sich in seinem Aufrufkontext so, als wäre er der Befehl [error] *result*. Weitere Optionen siehe unten.

**return** (oder **2**)
: Der Rückgabecode der Prozedur ist 2 ([TCL\_RETURN][catch]). Der Prozeduraufruf verhält sich in seinem Aufrufkontext so, als wäre er der Befehl **return** (ohne Argumente).

[break] (oder **3**)
: Der Rückgabecode der Prozedur ist 3 ([TCL\_BREAK][catch]). Der Prozeduraufruf verhält sich in seinem Aufrufkontext so, als wäre er der Befehl [break].

[continue] (oder **4**)
: Der Rückgabecode der Prozedur ist 4 ([TCL\_CONTINUE][catch]). Der Prozeduraufruf verhält sich in seinem Aufrufkontext so, als wäre er der Befehl [continue].

*value*
: *Value* muss eine Ganzzahl sein; sie wird als Rückgabecode der aktuellen Prozedur zurückgegeben.


Will eine Prozedur melden, dass sie von ihrem Aufrufer ungültige Argumente erhalten hat, kann sie **return -code error** verwenden und *result* auf eine passende Fehlermeldung setzen. Ansonsten beschränkt sich die Verwendung der Option **return -code** meist auf Prozeduren, die eine neue Kontrollstruktur implementieren.

In Skriptdateien, die mit dem Befehl [source] ausgewertet werden, wirkt der Befehl **return -code** ähnlich. Während [source] den Inhalt einer Datei als Skript auswertet, bewirkt ein Aufruf des Befehls **return -code** *code*, dass der Rückgabecode von [source] *code* ist.

# Rückgabeoptionen

Neben einem Ergebnis und einem Rückgabecode erzeugt die Auswertung eines Befehls in Tcl auch ein Dictionary von Rückgabeoptionen. Im Allgemeinen werden alle *option value*-Paare, die **return** als Argumente erhält, zu Einträgen im Dictionary der Rückgabeoptionen, und jeder beliebige Wert ist zulässig, mit den unten genannten Ausnahmen. Mit dem Befehl [catch] lassen sich alle diese Informationen erfassen, die bei der Auswertung eines Skripts entstehen: der Rückgabecode, das Ergebnis und das Dictionary der Rückgabeoptionen.

Wie oben beschrieben, behandelt Tcl den Eintrag **-code** im Dictionary der Rückgabeoptionen besonders. Tcl erkennt und behandelt noch weitere Rückgabeoptionen besonders. Diese sind:

[-errorcode]{.lit} [list]{.arg}
: Die Option **-errorcode** wird nur besonders behandelt, wenn der Wert der Option **-code** [TCL\_ERROR][catch] ist. Dann ist der Wert *list* als zusätzliche Information über den Fehler gedacht, dargestellt als Tcl-Liste zur weiteren Verarbeitung durch Programme. Wird **return** die Option **-code error** übergeben, aber keine Option **-errorcode**, setzt Tcl den Wert des Eintrags **-errorcode** im Dictionary der Rückgabeoptionen auf den Vorgabewert **NONE**. Die Rückgabeoption **-errorcode** wird außerdem in der globalen Variablen [errorCode][tclvars] gespeichert.

[-errorinfo]{.lit} [info]{.arg}
: Die Option **-errorinfo** wird nur besonders behandelt, wenn der Wert der Option **-code** [TCL\_ERROR][catch] ist. Dann ist *info* der anfängliche Stack-Trace, der einem menschlichen Leser zusätzliche Informationen über den Kontext liefern soll, in dem der Fehler aufgetreten ist. Der Stack-Trace wird außerdem in der globalen Variablen [errorInfo][tclvars] gespeichert. Wird **return** die Option **-code error** übergeben, aber keine Option **-errorinfo**, trägt Tcl einen eigenen anfänglichen Stack-Trace in den Eintrag **-errorinfo** ein. Dieser enthält nur den Aufruf der Prozedur; beim Abbau des Stacks werden Informationen über höhere Stack-Ebenen angehängt, aber es gibt keine Informationen über den Kontext des Fehlers innerhalb der Prozedur. Üblicherweise stammt der Wert *info* aus dem Wert von **-errorinfo** in einem Dictionary von Rückgabeoptionen, das der Befehl [catch] erfasst hat (oder aus der Kopie dieser Information in der globalen Variablen [errorInfo][tclvars]).

[-errorstack]{.lit} [list]{.arg}
: [Die Option **-errorstack** wird nur besonders behandelt, wenn der Wert der Option **-code** [TCL\_ERROR][catch] ist. Dann ist *list* der anfängliche Fehler-Stack, der die tatsächlichen Argumentwerte festhält, die an jede Prozedurebene übergeben wurden. Der Fehler-Stack ist außerdem über [info errorstack][info] erreichbar. Wird **return** die Option **-code error** übergeben, aber keine Option **-errorstack**, trägt Tcl einen eigenen anfänglichen Fehler-Stack in den Eintrag **-errorstack** ein. Dieser enthält nur den Aufruf der Prozedur; beim Abbau des Stacks werden Informationen über höhere Stack-Ebenen angehängt, aber es gibt keine Informationen über den Kontext des Fehlers innerhalb der Prozedur. Üblicherweise stammt der Wert *list* aus dem Wert von **-errorstack** in einem Dictionary von Rückgabeoptionen, das der Befehl [catch] erfasst hat (oder aus der Kopie dieser Information, die [info errorstack][info] liefert).]{version="8.6"}

[-level]{.lit} [level]{.arg}
: Die Optionen **-level** und **-code** legen zusammen den Rückgabecode fest, den einer der gerade ausgewerteten Befehle zurückgibt. Der Wert *level* muss eine nicht-negative Ganzzahl sein, die eine Anzahl von Ebenen auf dem Aufrufstack angibt. Er legt fest, wie viele Ebenen weiter oben auf dem Stack der Rückgabecode eines gerade ausgewerteten Befehls *code* sein soll. Ist keine Option **-level** angegeben, ist der Vorgabewert von *level* 1. Dann legt **return** den Rückgabecode fest, den die aktuelle Prozedur an ihren Aufrufer zurückgibt, eine Ebene höher auf dem Aufrufstack. Wie diese Optionen zusammenwirken, wird unten ausführlicher beschrieben.

[-options]{.lit} [options]{.arg}
: Der Wert *options* muss ein gültiges Dictionary sein. Seine Einträge werden als zusätzliche *option value*-Paare für den Befehl **return** behandelt.


# Rückgabecode-Behandlung

Rückgabecodes steuern in Tcl den Programmablauf. Ein Tcl-Skript ist eine Folge von Tcl-Befehlen. Solange jede Befehlsauswertung den Rückgabecode [TCL\_OK][catch] liefert, wird die Auswertung mit dem nächsten Befehl im Skript fortgesetzt. Jeder außergewöhnliche Rückgabecode (ungleich [TCL\_OK][catch]), den eine Befehlsauswertung liefert, unterbricht den Übergang zum nächsten Befehl. Die Skriptauswertung endet, und der außergewöhnliche Rückgabecode des Befehls wird zum Rückgabecode der gesamten Skriptauswertung. Über diesen Mechanismus führen Fehler während der Skriptauswertung zu einer Unterbrechung und zum Abbau des Aufrufstacks. Über denselben Mechanismus bewirken Befehle wie [break], [continue] und **return**, dass die Skriptauswertung endet, ohne alle Befehle der Reihe nach auszuwerten.

Einige eingebaute Befehle von Tcl werten im Rahmen ihrer Arbeit Skripte aus. Diese Befehle können außergewöhnliche Rückgabecodes nutzen, um besondere Funktionen zu ermöglichen. So werten zum Beispiel die eingebauten Schleifenbefehle von Tcl, etwa [while], [for] und [foreach], ein Skript aus, das den Rumpf der Schleife bildet. Liefert die Auswertung des Schleifenrumpfs den Rückgabecode [TCL\_BREAK][catch] oder [TCL\_CONTINUE][catch], kann der Schleifenbefehl so reagieren, dass die Befehle [break] und [continue] in Schleifen ihre dokumentierte Bedeutung erhalten.

Auch der Aufruf einer Prozedur umfasst die Auswertung eines Skripts, nämlich des Prozedurrumpfs. Liefert die Auswertung des Prozedurrumpfs den Rückgabecode [TCL\_RETURN][catch], wird dies beim Prozeduraufruf besonders behandelt. In diesem Fall wird der Eintrag **-level** im Dictionary der Rückgabeoptionen um eins verringert. Ist der Wert des Eintrags **-level** danach 0, wird der Wert des Eintrags **-code** zum Rückgabecode der Prozedur. Ist der Wert des Eintrags **-level** danach größer als null, ist der Rückgabecode der Prozedur [TCL\_RETURN][catch]. Fand der Prozeduraufruf während der Auswertung des Rumpfs einer anderen Prozedur statt, wiederholt sich der Vorgang aufwärts im Aufrufstack, wobei der Wert des Eintrags **-level** auf jeder Ebene verringert wird. So wird *code* zum Rückgabecode des aktuellen Befehls *level* Ebenen weiter oben auf dem Aufrufstack. Der Befehl [source] behandelt den Rückgabecode [TCL\_RETURN][catch] auf dieselbe Weise. Das erklärt, warum sich ein Aufruf von **return** während [source] ähnlich verhält wie ein Aufruf von **return** in einer Prozedur.

Der Rückgabecode des Befehls **return** selbst löst diese Sonderbehandlung beim Prozeduraufruf aus. Erhält **return** die Option **-level 0**, ist der Rückgabecode des Befehls **return** selbst der Wert *code* der Option **-code** (oder als Vorgabe [TCL\_OK][catch]). Jeder andere Wert der Option **-level** (einschließlich des Vorgabewerts 1) bewirkt, dass der Rückgabecode des Befehls **return** selbst [TCL\_RETURN][catch] ist; das löst eine Rückkehr aus der umgebenden Prozedur aus.

# Beispiele

Zunächst ein einfaches Beispiel, in dem **return** aus einer Prozedur zurückkehrt und dabei den Prozedurrumpf unterbricht.

```
proc printOneLine {} {
    puts "line 1"    ;# wird ausgegeben
    return
    puts "line 2"    ;# wird nicht ausgegeben
}
```

Als Nächstes ein Beispiel, in dem **return** den Wert festlegt, den die Prozedur zurückgibt.

```
proc returnX {} {return X}
puts [returnX]    ;# gibt X aus
```

Als Nächstes ein vollständigeres Beispiel, in dem **return -code error** ungültige Argumente meldet.

```
proc factorial {n} {
    if {![string is integer $n] || ($n < 0)} {
        return -code error \
                "expected non-negative integer,\
                but got \"$n\""
    }
    if {$n < 2} {
        return 1
    }
    set factor [factorial [expr {$n - 1}]]
    set product [expr {$n * $factor}]
    return $product
}
```

Als Nächstes eine Prozedur als Ersatz für [break].

```
proc myBreak {} {
    return -code break
}
```

Mit der Option **-level 0** kann **return** selbst mit Hilfe von [interp alias][interp] als Ersatz für [break] dienen.

```
interp alias {} Break {} return -level 0 -code break
```

Ein Beispiel, in dem [catch] und **return -options** einen abgefangenen Fehler erneut auslösen:

```
proc doSomething {} {
    set resource [allocate]
    catch {
        # Long script of operations
        # that might raise an error
    } result options
    deallocate $resource
    return -options $options $result
}
```

Zum Schluss ein Beispiel für eine fortgeschrittene Verwendung der Optionen von **return**, um eine Prozedur als Ersatz für **return** selbst zu erstellen:

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


[break]: break.md
[catch]: catch.md
[continue]: continue.md
[error]: error.md
[for]: for.md
[foreach]: foreach.md
[info]: info.md
[interp]: interp.md
[source]: source.md
[tclvars]: tclvars.md
[while]: while.md
