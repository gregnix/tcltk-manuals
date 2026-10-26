---
CommandName: term::ansi::ctrl::unix
ManualSection: n
Version: 0.1.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - ansi
 - columns
 - control
 - cooked
 - input mode
 - lines
 - raw
 - rows
 - terminal
Copyright:
 - Copyright (c) 2006-2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

term::ansi::ctrl::unix – Steuerungsvorgänge und Abfragen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [term::ansi::ctrl::unix]{.lit} [0.1.2]{.optlit} 
[::term::ansi::ctrl::unix::import]{.cmd} [ns]{.optarg} [arg]{.optdot} 
[::term::ansi::ctrl::unix::raw]{.cmd} 
[::term::ansi::ctrl::unix::cooked]{.cmd} 
[::term::ansi::ctrl::unix::columns]{.cmd} 
[::term::ansi::ctrl::unix::rows]{.cmd} 
:::

# BESCHREIBUNG

*WARNUNG*: Dieses Paket ist Unix-spezifisch und hängt von der Verfügbarkeit zweier Unix-Systembefehle zur Terminalsteuerung ab, nämlich **stty** und **tput**, die beide im **\$PATH** zu finden sein müssen. Fehlt einer dieser beiden Befehle, schlägt das Laden des Pakets fehl.

Das Paket stellt Befehle bereit, mit denen die Standardeingabe des aktuellen Prozesses zwischen den Eingabemodi *raw* und *cooked* umgeschaltet werden kann und mit denen die Größe von Terminals, d. h. die Anzahl der verfügbaren Spalten und Zeilen, abgefragt werden kann.

# API

## Introspektion

**::term::ansi::ctrl::unix::import** ?*ns*? ?*arg*...?
: Dieser Befehl importiert einige oder alle Attributbefehle in den Namespace *ns*. Standardmäßig ist dies der Namespace *ctrl*. Beachten Sie, dass es sich hierbei um einen relativen Namensraumnamen handelt, wodurch der importierte Befehl in einen Unternamensraum des aktuellen Namensraums eingefügt wird. Standardmäßig werden alle Befehle importiert; dies kann jedoch eingeschränkt werden, indem die Namen der gewünschten Befehle nach dem Namensraum-Argument aufgeführt werden.


## Operationen

**::term::ansi::ctrl::unix::raw**
: Dieser Befehl schaltet die Standardeingabe des aktuellen Prozesses in den *raw*-Eingabemodus um. Das bedeutet, dass fortan alle vom Benutzer eingegebenen Zeichen sofort an die Anwendung gemeldet werden, anstatt im Betriebssystempuffer zu verbleiben, bis die Enter-/Return-Taste gedrückt wird.

**::term::ansi::ctrl::unix::cooked**
: Dieser Befehl schaltet die Standardeingabe des aktuellen Prozesses in den *cooked*-Eingabemodus um. Das bedeutet, dass fortan alle vom Benutzer eingegebenen Zeichen zur Bearbeitung in den Betriebssystem-Puffern gespeichert werden, bis die Enter-/Return-Taste gedrückt wird.

**::term::ansi::ctrl::unix::columns**
: Dieser Befehl fragt das an die Standardeingabe angeschlossene Terminal ab, wie viele Spalten für die Anzeige zur Verfügung stehen.

**::term::ansi::ctrl::unix::rows**
: Dieser Befehl fragt das an die Standardeingabe angeschlossene Terminal nach der Anzahl der Zeilen, die zur Anzeige zur Verfügung stehen.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *term* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Terminalsteuerung

# COPYRIGHT

```
Copyright (c) 2006-2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
