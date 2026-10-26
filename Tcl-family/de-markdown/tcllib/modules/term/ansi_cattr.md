---
CommandName: term::ansi::code::attr
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - ansi
 - attribute control
 - color control
 - control
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

term::ansi::code::attr – ANSI-Attributsequenzen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [term::ansi::code]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [term::ansi::code::attr]{.lit} [0.2]{.optlit} 
[::term::ansi::code::attr::names]{.cmd} 
[::term::ansi::code::attr::import]{.cmd} [ns]{.optarg} [arg]{.optdot} 
[::term::ansi::code::attr::fgblack]{.cmd} 
[::term::ansi::code::attr::fgred]{.cmd} 
[::term::ansi::code::attr::fggreen]{.cmd} 
[::term::ansi::code::attr::fgyellow]{.cmd} 
[::term::ansi::code::attr::fgblue]{.cmd} 
[::term::ansi::code::attr::fgmagenta]{.cmd} 
[::term::ansi::code::attr::fgcyan]{.cmd} 
[::term::ansi::code::attr::fgwhite]{.cmd} 
[::term::ansi::code::attr::fgdefault]{.cmd} 
[::term::ansi::code::attr::bgblack]{.cmd} 
[::term::ansi::code::attr::bgred]{.cmd} 
[::term::ansi::code::attr::bggreen]{.cmd} 
[::term::ansi::code::attr::bgyellow]{.cmd} 
[::term::ansi::code::attr::bgblue]{.cmd} 
[::term::ansi::code::attr::bgmagenta]{.cmd} 
[::term::ansi::code::attr::bgcyan]{.cmd} 
[::term::ansi::code::attr::bgwhite]{.cmd} 
[::term::ansi::code::attr::bgdefault]{.cmd} 
[::term::ansi::code::attr::bold]{.cmd} 
[::term::ansi::code::attr::dim]{.cmd} 
[::term::ansi::code::attr::italic]{.cmd} 
[::term::ansi::code::attr::underline]{.cmd} 
[::term::ansi::code::attr::blink]{.cmd} 
[::term::ansi::code::attr::revers]{.cmd} 
[::term::ansi::code::attr::hidden]{.cmd} 
[::term::ansi::code::attr::strike]{.cmd} 
[::term::ansi::code::attr::nobold]{.cmd} 
[::term::ansi::code::attr::noitalic]{.cmd} 
[::term::ansi::code::attr::nounderline]{.cmd} 
[::term::ansi::code::attr::noblink]{.cmd} 
[::term::ansi::code::attr::norevers]{.cmd} 
[::term::ansi::code::attr::nohidden]{.cmd} 
[::term::ansi::code::attr::nostrike]{.cmd} 
[::term::ansi::code::attr::reset]{.cmd} 
:::

# BESCHREIBUNG

Dieses Paket stellt symbolische Namen für die ANSI-Attribut-Steuercodes bereit. Für jeden Steuercode wird ein einzelner Befehl bereitgestellt, der diesen Code als Ergebnis zurückgibt. Keiner der Befehle dieses Pakets schreibt in einen Kanal; dies wird von Paketen höherer Ebene übernommen, wie beispielsweise **term::ansi::send**.

# API

## Introspektion

**::term::ansi::code::attr::names**
: Dieser Befehl dient der Introspektion. Er gibt als Ergebnis eine Liste zurück, die die Namen aller Attributbefehle enthält.

**::term::ansi::code::attr::import** ?*ns*? ?*arg*...?
: Dieser Befehl importiert einige oder alle Attributbefehle in den Namespace *ns*. Standardmäßig ist dies der Namespace *attr*. Beachten Sie, dass es sich hierbei um einen relativen Namespace handelt, wodurch der importierte Befehl in einem Unternamespace des aktuellen Namespaces abgelegt wird. Standardmäßig werden alle Befehle importiert; dies kann jedoch eingeschränkt werden, indem die Namen der gewünschten Befehle nach dem Namespace-Argument aufgeführt werden.


## Attribute

**::term::ansi::code::attr::fgblack**
: Setzt die Textfarbe auf *Black*.

**::term::ansi::code::attr::fgred**
: Setzt die Textfarbe auf *Red*.

**::term::ansi::code::attr::fggreen**
: Setzt die Textfarbe auf *Green*.

**::term::ansi::code::attr::fgyellow**
: Setzt die Textfarbe auf *Yellow*.

**::term::ansi::code::attr::fgblue**
: Setzt die Textfarbe auf *Blue*.

**::term::ansi::code::attr::fgmagenta**
: Setzt die Textfarbe auf *Magenta*.

**::term::ansi::code::attr::fgcyan**
: Setzt die Textfarbe auf *Cyan*.

**::term::ansi::code::attr::fgwhite**
: Setzt die Textfarbe auf *White*.

**::term::ansi::code::attr::fgdefault**
: Setzt die Standardtextfarbe (*Black*).

**::term::ansi::code::attr::bgblack**
: Setzt den Hintergrund auf *Black*.

**::term::ansi::code::attr::bgred**
: Setzt den Hintergrund auf *Red*.

**::term::ansi::code::attr::bggreen**
: Setzt den Hintergrund auf *Green*.

**::term::ansi::code::attr::bgyellow**
: Setzt den Hintergrund auf *Yellow*.

**::term::ansi::code::attr::bgblue**
: Setzt den Hintergrund auf *Blue*.

**::term::ansi::code::attr::bgmagenta**
: Setzt den Hintergrund auf *Magenta*.

**::term::ansi::code::attr::bgcyan**
: Setzt den Hintergrund auf *Cyan*.

**::term::ansi::code::attr::bgwhite**
: Setzt den Hintergrund auf *White*.

**::term::ansi::code::attr::bgdefault**
: Standardhintergrund festlegen (transparent).

**::term::ansi::code::attr::bold**
: Weiter so!

**::term::ansi::code::attr::dim**
: Schaltet die abgeschwächte Darstellung ein.

**::term::ansi::code::attr::italic**
: Kursivschrift aktivieren.

**::term::ansi::code::attr::underline**
: Unterstrich aktivieren.

**::term::ansi::code::attr::blink**
: Bitte blinken Sie weiter.

**::term::ansi::code::attr::revers**
: Rückwärtsgang einlegen.

**::term::ansi::code::attr::hidden**
: Ausgeblendet.

**::term::ansi::code::attr::strike**
: Durchstreichen aktiviert.

**::term::ansi::code::attr::nobold**
: Fettdruck deaktivieren.

**::term::ansi::code::attr::noitalic**
: Kursivschrift beenden.

**::term::ansi::code::attr::nounderline**
: Unterstrich aus.

**::term::ansi::code::attr::noblink**
: Blinken ausschalten.

**::term::ansi::code::attr::norevers**
: Bitte fahren Sie rückwärts weg.

**::term::ansi::code::attr::nohidden**
: Ausgeblendet.

**::term::ansi::code::attr::nostrike**
: Durchstreichung deaktivieren.

**::term::ansi::code::attr::reset**
: Setzt alle Attribute auf ihre Standardwerte zurück.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *term* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Terminalsteuerung

# COPYRIGHT

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
