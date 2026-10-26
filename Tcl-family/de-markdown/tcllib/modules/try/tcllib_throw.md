---
CommandName: throw
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Forward compatibility implementation of [throw]
Links:
 - error(n)
Keywords:
 - error
 - return
 - throw
Copyright:
 - Copyright (c) 2015 Miguel Martínez López, BSD licensed
---

# NAME

throw - throw - Löst eine Fehlerausnahme mit einer Meldung aus

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [throw]{.lit} [1.1]{.optlit} 
[::throw]{.cmd} [error_code]{.arg} [error_message]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket bietet eine Paket-Implementierung des Befehls **throw** aus Tcl 8.6 (TIP 329) für Tcl 8.5. Der Code wurde direkt aus der Revision ? von Tcl 8.6 übernommen, als „try/finally“ noch als Tcl-Prozedur statt in C implementiert war.

**::throw** *error_code* *error_message*
: „throw“ dient lediglich dazu, die Reihenfolge der Argumente des Befehls „error“ neu zu ordnen. Es löst einen Fehler mit dem angegebenen Fehlercode und der angegebenen Fehlermeldung aus.


# BEISPIELE

```
throw {MYERROR CODE} "My error message"
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *try* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hilfsprogramme

# COPYRIGHT

```
Copyright (c) 2015 Miguel Martínez López, BSD licensed
```
