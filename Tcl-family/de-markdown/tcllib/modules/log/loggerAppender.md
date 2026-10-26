---
CommandName: logger::appender
ManualSection: n
Version: 1.4
TclPart: tcllib
TclDescription: Object Oriented logging facility
Keywords:
 - appender
 - logger
Copyright:
 - Copyright (c) 2005 Aamer Akhter <aakhter@cisco.com>
---

# NAME

logger::appender – Sammlung vordefinierter Appender für den Logger

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [logger::appender]{.lit} [1.4]{.optlit} 
[::logger::appender::console]{.cmd} [-level]{.sub} [level]{.arg} [-service]{.lit} [service]{.arg} [options]{.optdot} 
[::logger::appender::colorConsole]{.cmd} [-level]{.sub} [level]{.arg} [-service]{.lit} [service]{.arg} [options]{.optdot} 
:::

# BESCHREIBUNG

Dieses Paket enthält eine vordefinierte Sammlung von Logger-Vorlagen.

**::logger::appender::console** **-level** *level* **-service** *service* ?*options*...?
: 


**-level**-Stufe
: Name der Ebene, der in der Prozedur zur Protokollierung als „Priorität“ einzutragen ist.

**-service**-Dienst
: Name des Dienstes, der in der Prozedur der Protokollierung als „Kategorie“ anzugeben ist.

**-appenderArgs** appenderArgs
: Alle weiteren Argumente für die Log-Prozedur in Listenform

**-conversionPattern** Konvertierungsmuster
: Das zu verwendende Protokollmuster (siehe **logger::utils::createLogProc** für die zulässigen Ersetzungen).

**-procName** procName
: Legt den Namen der erstellten Prozedur explizit fest.

**-procNameVar** procNameVar
: Name der Variablen, die im aufrufenden Kontext gesetzt werden soll. Diese Variable enthält den Namen der Prozedur.


**::logger::appender::colorConsole** **-level** *level* **-service** *service* ?*options*...?
: Eine Beschreibung der verfügbaren Optionen finden Sie unter **::logger::appender::colorConsole**.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *logger* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge

# COPYRIGHT

```
Copyright (c) 2005 Aamer Akhter <aakhter@cisco.com>
```
