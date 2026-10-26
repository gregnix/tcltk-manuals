---
CommandName: pt_peg_op
ManualSection: i
Version: 1.2.0
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

pt_peg_op – Parser-Tools: Operationen des PE-Grammatik-Dienstprogramms

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pt::peg::op]{.lit} [1.2.0]{.optlit} 
[::peg::peg::op]{.cmd} [called]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [dechain]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [drop]{.sub} [unreachable]{.lit} [container]{.arg} 
[::peg::peg::op]{.cmd} [drop]{.sub} [unrealizable]{.lit} [container]{.arg} 
[::peg::peg::op]{.cmd} [flatten]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [minimize]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [modeopt]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [reachable]{.sub} [container]{.arg} 
[::peg::peg::op]{.cmd} [realizable]{.sub} [container]{.arg} 
:::

# BESCHREIBUNG

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket enthält eine Reihe von Dienstprogrammen, mit denen sich eine PE-Grammatik (Container) auf verschiedene Weise bearbeiten lässt.

# API

**::peg::peg::op** **called** *container*
: Dieser Befehl ermittelt die statische Aufrufstruktur für die nichtterminalen Symbole der im *container* gespeicherten Grammatik. Das Ergebnis des Befehls ist ein Dictionary, das jedes Symbol den von ihm aufgerufenen Symbolen zuordnet. Die leere Zeichenkette dient als Schlüssel zur Darstellung des Startausdrucks der Grammatik. Die Grammatik im Container wird nicht verändert. Die *container*-Instanz muss eine Methoden-API bereitstellen, wie sie vom Paket **pt::peg::container** bereitgestellt wird.

**::peg::peg::op** **dechain** *container*
: Dieser Befehl vereinfacht alle Symbole, die lediglich auf ein anderes Symbol verweisen, indem er die rechte Seite des aufgerufenen Symbols in dessen Aufrufer einfügt. Dies funktioniert genau dann, wenn die Modi gemäß der nachstehenden Entscheidungstabelle korrekt übereinstimmen.


```
caller called | dechain | notes
--------------+---------+-----------------------
value  value  |  yes    |  value is passed
value  leaf   |  yes    |  value is passed
value  void   |  yes    |  caller is implied void
leaf   value  |  no     |  generated value was discarded, inlined would not. called may be implied void.
leaf   leaf   |  no     |  s.a.
leaf   void   |  no     |  s.a.
void   value  |  no     |  caller drops value, inlined would not.
void   leaf   |  no     |  s.a.
void   void   |  yes    |
```

Das Ergebnis des Befehls ist die leere Zeichenkette.

Die Grammatik im Container wird direkt geändert. Wenn dies nicht gewünscht ist, muss eine Kopie des ursprünglichen Containers verwendet werden.

Die *container*-Instanz muss eine Methoden-API bereitstellen, wie sie vom Paket **pt::peg::container** bereitgestellt wird.

**::peg::peg::op** **drop unreachable** *container*
: Dieser Befehl entfernt alle Symbole aus der Grammatik, die nicht **reachable** sind. Das Ergebnis des Befehls ist die leere Zeichenkette. Die Grammatik im Container wird direkt geändert. Ist dies nicht erwünscht, muss eine Kopie des ursprünglichen Containers verwendet werden. Die *container*-Instanz muss eine Methoden-API bereitstellen, wie sie vom Paket **pt::peg::container** bereitgestellt wird.

**::peg::peg::op** **drop unrealizable** *container*
: Dieser Befehl entfernt alle Symbole aus der Grammatik, die nicht **realizable** sind. Das Ergebnis des Befehls ist die leere Zeichenkette. Die Grammatik im Container wird direkt geändert. Ist dies nicht erwünscht, muss eine Kopie des ursprünglichen Containers verwendet werden. Die *container*-Instanz muss eine Methoden-API bereitstellen, wie sie vom Paket **pt::peg::container** bereitgestellt wird.

**::peg::peg::op** **flatten** *container*
: Dieser Befehl ebnet (siehe **pt::pe::op**) alle Ausdrücke in der Grammatik ein, d. h. den Startausdruck und die rechten Seiten aller nichtterminalen Symbole. Das Ergebnis des Befehls ist die leere Zeichenkette. Die Grammatik im Container wird direkt geändert. Wenn dies nicht erwünscht ist, muss eine Kopie des ursprünglichen Containers verwendet werden. Die *container*-Instanz muss eine Methoden-API bereitstellen, wie sie vom Paket **pt::peg::container** bereitgestellt wird.

**::peg::peg::op** **minimize** *container*
: Dieser Befehl reduziert die bereitgestellte Grammatik, indem er die meisten anderen Methoden dieses Pakets anwendet. Nach dem Einebnen der Ausdrücke entfernt er nicht erreichbare und nicht realisierbare Symbole, ebnet die Ausdrücke erneut ein und optimiert anschließend die Symbolmodi, bevor er Symbolketten so weit wie möglich zusammenfasst. Das Ergebnis des Befehls ist die leere Zeichenkette. Die Grammatik im Container wird direkt verändert. Ist dies nicht erwünscht, muss eine Kopie des ursprünglichen Containers verwendet werden. Die *container*-Instanz muss eine Methoden-API bereitstellen, wie sie vom Paket **pt::peg::container** bereitgestellt wird.

**::peg::peg::op** **modeopt** *container*
: Dieser Befehl optimiert die semantischen Modi von nichtterminalen Symbolen gemäß den beiden nachstehenden Regeln.


**\[1\]**
: Wenn ein Symbol X mit dem Modus **value** keine anderen Symbole aufruft, d. h. ausschließlich Terminalsymbole in beliebiger Kombination verwendet, lässt sich dies durch Verwendung des Modus **leaf** einfacher darstellen.

**\[2\]**
: Wenn ein Symbol X ausschließlich von Symbolen mit den Modi **leaf** oder **void** aufgerufen wird, sollte dieses Symbol ebenfalls den Modus **void** aufweisen, da jeder von ihm erzeugte AST ohnehin verworfen wird.


Das Ergebnis des Befehls ist die leere Zeichenkette.

Die Grammatik im Container wird direkt geändert. Wenn dies nicht gewünscht ist, muss eine Kopie des ursprünglichen Containers verwendet werden.

Die *container*-Instanz muss eine Methoden-API bereitstellen, wie sie vom Paket **pt::peg::container** bereitgestellt wird.

**::peg::peg::op** **reachable** *container*
: Dieser Befehl ermittelt die Menge aller nichtterminalen Symbole, die vom Startausdruck der Grammatik aus erreichbar sind. Dabei handelt es sich im Wesentlichen um die transitive Hülle über **called** und die rechten Seiten der Symbole, beginnend mit dem Startausdruck. Das Ergebnis des Befehls ist die Liste der erreichbaren Symbole. Die Grammatik im Container wird nicht verändert. Die *container*-Instanz muss eine Methoden-API bereitstellen, wie sie vom Paket **pt::peg::container** bereitgestellt wird.

**::peg::peg::op** **realizable** *container*
: Dieser Befehl berechnet die Menge aller nichtterminalen Symbole, die realisierbar sind, d. h. reine terminale Phrasen ableiten können. Dies geschieht iterativ, wobei zunächst für alle Symbole der Zustand „nicht realisierbar“ gesetzt wird und anschließend alle realisierbaren Symbole aktualisiert sowie die Änderungen weiterverbreitet werden, bis sich nichts mehr ändert. Das Ergebnis des Befehls ist die Liste der realisierbaren Symbole. Die Grammatik im Container wird nicht verändert. Die *container*-Instanz muss eine Methoden-API bereitstellen, wie sie vom Paket **pt::peg::container** bereitgestellt wird.


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
