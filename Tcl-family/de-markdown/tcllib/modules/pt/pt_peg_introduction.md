---
CommandName: pt::pegrammar
title: pt::pegrammar
ManualSection: n
Version: 1.1
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

# Name

pt::pegrammar – Einleitung in Parsing Expression Grammars

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
:::

# Beschreibung

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Willkommen zur Einleitung in die *Parsing Expression Grammar*s (kurz: *PEG*), den von den Parser-Tools verwendeten Formalismus. Es wird vorausgesetzt, dass der Leser über Grundkenntnisse der Parsing-Theorie verfügt, d. h. über *kontextfreie Grammatiken* (kurz: *CFG*), *Sprachen* und zugehörige Begriffe wie *LL(k)*, *LR(k)*, *terminale* und *nichtterminale* *Symbole* usw. Es ist nicht unsere Absicht, solche grundlegenden Definitionen oder Begriffe wie *nützlich*, *erreichbar*, (links-/rechts-)*rekursiv*, *nullfähig*, First-/Last-/Follow-Mengen usw. noch einmal zusammenzufassen. Die [Literatur] am Ende nennt Quellen und Bücher, die diese Hintergründe liefern.

PEGs sind formal den CFGs sehr ähnlich, mit terminalen und nichtterminalen Symbolen, einem Startsymbol sowie Regeln, die die Struktur jedes nichtterminalen Symbols definieren. Der Hauptunterschied liegt in der Wahl (sic!) der *Auswahl*-Operatoren. Während CFGs eine *ungeordnete Auswahl* verwenden, um Alternativen darzustellen, nutzen PEGs eine *priorisierte Auswahl*. Das ist eine ausgefallene Art zu sagen, dass ein Parser zunächst die erste Alternative ausprobieren muss und die anderen Alternativen erst dann ausprobieren darf, wenn die erste fehlschlägt, und so weiter.

Auf der CFG-Seite ergeben sich daraus LL(k) und LR(k), um die Auswahl *deterministisch* mit begrenzter *Vorausschau* von k Terminalsymbolen zu gestalten, wobei LL im Wesentlichen eine *Top-Down*-Analyse, auch bekannt als *rekursiver Abstieg*, ist, und LR ein *Bottom-up*-Parsing, auch bekannt als *Shift-Reduce*-Parsing.

Auf der PEG-Seite können wir die Eingabe mittels rekursiver Abwärtsanalyse und *Backtracking* bei fehlgeschlagenen Auswahlen analysieren, wobei Letzteres unbegrenzter Vorausschau entspricht. Indem wir zusätzlich den Erfolg oder Misserfolg von Nichtterminalen an den jeweiligen Stellen, an denen sie geprüft wurden, protokollieren und diese Informationen nach dem Backtracking wiederverwenden, können wir den exponentiellen Anstieg der Laufzeit vermeiden, der üblicherweise mit Backtracking einhergeht, und die Analyse linear halten. Die Speicheranforderungen sind aufgrund dieses Caches natürlich höher, da wir Speicherplatz gegen Zeit eintauschen.

Dies ist das Grundkonzept hinter *Packrat-Parsern*.

Eine Einschränkung, die reine PEGs mit LL(k)-CFGs gemeinsam haben, besteht darin, dass *linksrekursive* Grammatiken nicht geparst werden können, da der zugehörige rekursive Abstiegsparser in eine unendliche Rekursion gerät. Diese Einschränkung wird in der Regel dadurch überwunden, dass reine PEGs um explizite Operatoren erweitert werden, um Wiederholungen – null oder mehr sowie eine oder mehr – festzulegen, oder, formal ausgedrückt, für den *Kleene-Abschluss* und den *positiven Kleene-Abschluss*. Genau dies leisten die Parser-Tools.

Eine weitere, speziell auf Parser Tools zugeschnittene Erweiterung ist eine Reihe von Operatoren, die mehr oder weniger direkt verschiedenen in Tcl integrierten Zeichenklassen zugeordnet sind, d. h. den Klassen, auf die über **string is** zugegriffen werden kann.

Der weitere Teil dieses Dokuments umfasst die formale Definition von PEGs für mathematisch Interessierte sowie einen Anhang mit Literaturverweisen auf Stellen, die weitere Informationen speziell zu PEGs und zur Syntaxanalyse im Allgemeinen enthalten.

# Formale Definition

Für mathematisch Interessierte: Eine Parsing Expression Grammar ist ein 4-Tupel (VN, VT, R, eS), wobei

- VN ist eine Menge von *nichtterminalen Symbolen*,

- VT ist eine Menge von *Terminalsymbolen*,

- R ist eine endliche Menge von Regeln, wobei jede Regel ein Paar (A, e) ist, wobei A in VN liegt und *e* ein *Parsing-Ausdruck* ist.

- eS ist ein Parsing-Ausdruck, der *Startausdruck*.


Weitere Bedingungen sind

- Die Schnittmenge von VN und VT ist leer.

- Für jedes A in VN gibt es genau ein Paar (A, e) in R. Mit anderen Worten: R ist eine Funktion von nichtterminalen Symbolen auf Parsing-Ausdrücke.


Parsing-Ausdrücke werden induktiv definiert über

- Die leere Zeichenkette (Epsilon) ist ein Parsing-Ausdruck.

- Ein Terminalsymbol *a* ist ein Parsing-Ausdruck.

- Ein nichtterminales Symbol *A* ist ein Parsing-Ausdruck.

- *e1e2* ist ein Parsing-Ausdruck für die Parsing-Ausdrücke *e1* und *e2*. Das heißt *Sequenz*.

- *e1*/*e2* ist ein Parsing-Ausdruck für die Parsing-Ausdrücke *e1* und *e2*. Dies wird als *geordnete Auswahl* bezeichnet.

- *e*\* ist ein Parsing-Ausdruck für den Parsing-Ausdruck *e*. Dies wird als *Null-oder-mehr-Wiederholungen* bezeichnet, auch bekannt als *Kleene-Abschluss*.

- *e*+ ist ein Parsing-Ausdruck für den Parsing-Ausdruck *e*. Dies wird als *eine oder mehrere Wiederholungen* bezeichnet, auch bekannt als *positiver Kleene-Abschluss*.

- !*e* ist ein Parsing-Ausdruck für den Parsing-Ausdruck *e*. Das ist ein *Nicht-Vorausschau-Prädikat*.

- &*e* ist ein Parsing-Ausdruck für den Parsing-Ausdruck *e1*. Das ist ein *Und-Vorausschau-Prädikat*.


PEGs definieren eine grammatische Struktur für Symbolströme über VT. Sie sind eine moderne Formulierung älterer Formalismen, die Alexander Birham eingeführt hat. Diese Formalismen wurden als TS (TMG-Erkennungsschema) und gTS (verallgemeinertes TS) bezeichnet. Später wurden sie in TPDL (Top-Down-Parsing-Sprachen) und gTPDL (verallgemeinertes TPDL) umbenannt.

Sie lassen sich leicht durch rekursive Abstiegsparser mit Backtracking implementieren. Damit stehen sie in Verwandtschaft zu den kontextfreien LL(k)-Grammatiken.

# Literatur

1. [The Packrat Parsing and Parsing Expression Grammars Page](http://www.pdos.lcs.mit.edu/~baford/packrat/), von Bryan Ford, Massachusetts Institute of Technology. Das ist die Haupteinstiegsseite zu PEGs und ihrer Umsetzung durch Packrat-Parser.

2. <http://en.wikipedia.org/wiki/Parsing_expression_grammar> Der Wikipedia-Eintrag zu Parsing Expression Grammars.

3. *Parsing Techniques - A Practical Guide*  <http://www.cs.vu.nl/~dick/PTAPG.html>, ein Online-Buch, das eine klare, leicht verständliche und umfassende Darstellung zahlreicher verschiedener Parsing-Techniken mit ihren Zusammenhängen und Anwendungsmöglichkeiten bietet, einschließlich Techniken zur Fehlerbehebung.

4. [Compilers and Compiler Generators](http://scifac.ru.ac.za/compilers/), ein Online-Buch, das CoCo/R verwendet, einen Generator für rekursive Abstiegsparser.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pt* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Parser und Grammatiken

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
