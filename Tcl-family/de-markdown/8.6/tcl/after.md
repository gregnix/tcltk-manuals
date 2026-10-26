---
CommandName: after
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - concat(n)
 - interp(n)
 - update(n)
 - vwait(n)
Keywords:
 - cancel
 - delay
 - idle callback
 - sleep
 - time
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

after - Führt einen Befehl nach einer Zeitverzögerung aus

# ÜBERSICHT

::: {.synopsis} :::
[after]{.cmd} [ms]{.arg} 
[after]{.cmd} [ms]{.arg} [script script script]{.optdot} 
[after]{.cmd} [cancel]{.sub} [id]{.arg} 
[after]{.cmd} [cancel]{.sub} [script]{.arg} [script]{.arg} [script]{.arg} [...]{.arg} 
[after]{.cmd} [idle]{.sub} [script script script]{.optdot} 
[after]{.cmd} [info]{.sub} [id]{.optarg} 
:::

# BESCHREIBUNG

Dieser Befehl verzögert die Programmausführung oder führt einen Befehl zu einem späteren Zeitpunkt im Hintergrund aus. Er verwendet eine monotone Uhr, sofern verfügbar. Die Form hängt vom ersten Argument ab:

**after** *ms*
: *ms* muss eine Ganzzahl in Millisekunden sein; negative Werte gelten als 0. Der Befehl schläft *ms* Millisekunden und kehrt dann zurück. Während des Schlafens reagiert die Anwendung nicht auf Events.

**after** *ms* ?*script script script ...*?
: In dieser Form kehrt der Befehl sofort zurück, plant aber die Ausführung eines Tcl-Befehls *ms* Millisekunden später als Event-Handler. Der Befehl wird genau einmal zur angegebenen Zeit ausgeführt. Der verzögerte Befehl entsteht durch Verkettung aller *script*-Argumente wie bei **concat**. Die Ausführung erfolgt auf globaler Ebene (außerhalb jeder Tcl-Prozedur). Tritt beim Ausführen des verzögerten Befehls ein Fehler auf, meldet ihn der mit **interp bgerror** registrierte Handler. **after** gibt eine Kennung zurück, mit der der verzögerte Befehl per **after cancel** abgebrochen werden kann. *ms* von 0 (oder negativ) reiht das Event sofort mit Vorrang vor anderen Event-Typen ein (sofern nicht mit einem Event-Proc installiert, der auf die nächste Event-Runde wartet).

**after cancel** *id*
: Bricht die Ausführung eines zuvor geplanten verzögerten Befehls ab. *id* muss der Rückgabewert eines früheren **after**- oder **timer**-Befehls sein. Wurde der Befehl bereits ausgeführt, hat **after cancel** keine Wirkung.

**after cancel** *script script ...*
: Bricht ebenfalls einen verzögerten Befehl ab. Die *script*-Argumente werden mit Leerzeichen verkettet (wie **concat**). Gibt es einen passenden ausstehenden Befehl, wird er abgebrochen und nie ausgeführt; sonst keine Wirkung.

**after idle** *script* ?*script script ...*?
: Verkettet die *script*-Argumente mit Leerzeichen (wie **concat**) und plant die Auswertung als Idle-Callback. Das Skript läuft genau einmal, wenn die Event-Schleife das nächste Mal ohne zu verarbeitende Events betreten wird. Der Befehl gibt eine Kennung für **after cancel** zurück. Fehler werden über **interp bgerror** gemeldet.

**after info** ?*id*?
: Liefert Informationen über vorhandene Event-Handler. Ohne *id*: Liste der Kennungen aller von **after** für diesen Interpreter erzeugten Handler. Mit *id*: ein bestehender Handler (Rückgabewert eines früheren **after**, noch nicht ausgelöst oder abgebrochen). Dann eine Liste mit zwei Elementen: das zu *id* gehörige Skript und entweder **idle** oder **timer** als Handler-Typ. Monotone und Wall-Clock-Events haben den Typ **timer**; **timer info** unterscheidet die Uhren und liefert die geplante Zeit.

Die Formen **after** *ms* und **after idle** setzen eine event-getriebene Anwendung voraus: verzögerte Befehle laufen nur, wenn die Event-Schleife betreten wird. In nicht event-getriebenen Anwendungen wie **tclsh** kann das mit **vwait** und **update** geschehen.

## Maximaler Zeitwert

Das Argument *delay* ist an einen 63-Bit-Wert der monotonen Uhr gebunden (Einheit Mikrosekunden). Größere Werte (nach dem Jahr 294441) führen zum Fehler „time to far“.

## Kompatibilität

Der Befehl verwendet eine monotone Uhr, sofern verfügbar. Alle Versionen vor 9.1 nutzten für **after** eine Wall-Clock. Der neue Befehl **timer** bietet Optionen mit Wall-Clock.

# BEISPIELE

Befehl, der Tcl *N* Sekunden lang nichts tun lässt:

```
proc sleep {N} {
    after [expr {int($N * 1000)}]
}
```

Plant die Ausführung von *wake_up* in acht Stunden (wenn die Event-Schleife dann aktiv ist):

```
after [expr {1000 * 60 * 60 * 8}] wake_up
```

Schrittweise lange Berechnungen (*::my_calc::one_step* liefert, ob ein weiterer Schritt nötig ist), ohne die Event-Schleife zu verhungern — nützlich, damit eine Tk-GUI bei langsamen Aufgaben reagiert:

```
proc doOneStep {} {
    if {[::my_calc::one_step]} {
        after idle [list after 0 doOneStep]
    }
}
doOneStep
```
