---
CommandName: pt::tclparam::configuration::nx
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
 - LL(k)
 - PEG
 - TDPL
 - context-free languages
 - expression
 - grammar
 - matching
 - parser
 - parsing expression
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - state
 - top-down parsing languages
 - transducer
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

pt::tclparam::configuration::nx – Tcl/PARAM, Vorgefertigte Konfiguration, NX

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pt::tclparam::configuration::nx]{.lit} [1.0.2]{.optlit} 
[::pt::tclparam::configuration::nx]{.cmd} [def]{.sub} [name]{.arg} [pkg]{.arg} [version]{.arg} [cmdprefix]{.arg} 
:::

# BESCHREIBUNG

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket dient als Ergänzung zu **pt::peg::to::tclparam** und soll die Verwendung dieses in hohem Maße konfigurierbaren Pakets durch die Bereitstellung einer vorgefertigten Konfiguration vereinfachen. Wenn diese Konfiguration angewendet wird, generiert das Paket **pt::peg::to::tclparam** Pakete mit Parsern, die auf **NX** basieren.

Es handelt sich um ein unterstützendes Paket in der Kernschicht der Parser-Tools.

Bild: arch_core_support

# API

**::pt::tclparam::configuration::nx** **def** *name* *pkg* *version* *cmdprefix*
: Der Befehl wendet die in diesem Paket bereitgestellte Konfiguration auf *cmdprefix* an, wodurch Parser auf Basis von **NX** erstellt werden, deren Klasse *name* lautet, im Paket *pkg* mit *version*. Die Verwendung eines Befehlspräfixes als API ermöglicht die Anwendung der Konfiguration nicht nur auf **pt::peg::to::tclparam** (**pt::peg::to::tclparam configure**), sondern auch auf Export-Manager-Instanzen und PEG-Container (**\$export configuration set** bzw. **\[\$container exporter\] configuration set**). Oder auf jedes andere Befehlspräfix, das zwei Argumente – Option und Wert – akzeptiert.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pt* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Parser und Grammatiken

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
