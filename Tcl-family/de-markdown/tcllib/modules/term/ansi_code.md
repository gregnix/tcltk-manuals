---
CommandName: term::ansi::code
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - control
 - declare
 - define
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

term::ansi::code – Hilfsmittel für Steuersequenzen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [term::ansi::code]{.lit} [0.2]{.optlit} 
[::term::ansi::code::esc]{.cmd} [str]{.arg} 
[::term::ansi::code::escb]{.cmd} [str]{.arg} 
[::term::ansi::code::define]{.cmd} [name]{.arg} [escape]{.arg} [code]{.arg} 
[::term::ansi::code::const]{.cmd} [name]{.arg} [code]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Befehle, mit denen sich Steuersequenzen auf einfache Weise definieren lassen.

**::term::ansi::code::esc** *str*
: Dieser Befehl gibt die Argumentzeichenfolge zurück, der das ANSI-Escape-Zeichen „\\033“ vorangestellt ist.

**::term::ansi::code::escb** *str*
: Dieser Befehl gibt die Argumentzeichenfolge zurück, der eine gängige ANSI-Escape-Sequenz, nämlich „\\033\[“, vorangestellt ist.

**::term::ansi::code::define** *name* *escape* *code*
: Dieser Befehl definiert eine Prozedur *name*, die die Steuersequenz *code* zurückgibt, beginnend mit der angegebenen Escape-Sequenz, entweder **esc** oder **escb**.

**::term::ansi::code::const** *name* *code*
: Dieser Befehl definiert eine Prozedur *name*, die die Steuersequenz *code* zurückgibt.


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
