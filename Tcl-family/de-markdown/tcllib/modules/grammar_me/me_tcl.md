---
CommandName: grammar::me::tcl
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - grammar
 - parsing
 - virtual machine
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

grammar::me::tcl – Implementierung virtueller Maschinen I zur Analyse von Token-Strömen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [grammar::me::tcl]{.lit} [0.2]{.optlit} 
[::grammar::me::tcl]{.cmd} [cmd]{.sub} [...]{.arg} 
[::grammar::me::tcl]{.cmd} [init]{.sub} [nextcmd]{.arg} [tokmap]{.optarg} 
[::grammar::me::tcl]{.cmd} [lc]{.sub} [location]{.arg} 
[::grammar::me::tcl]{.cmd} [tok]{.sub} [from]{.arg} [to]{.optarg} 
[::grammar::me::tcl]{.cmd} [tokens]{.sub} 
[::grammar::me::tcl]{.cmd} [sv]{.sub} 
[::grammar::me::tcl]{.cmd} [ast]{.sub} 
[::grammar::me::tcl]{.cmd} [astall]{.sub} 
[::grammar::me::tcl]{.cmd} [ctok]{.sub} 
[::grammar::me::tcl]{.cmd} [nc]{.sub} 
[::grammar::me::tcl]{.cmd} [next]{.sub} 
[::grammar::me::tcl]{.cmd} [ord]{.sub} 
[::grammar::me::tcl::ict_advance]{.cmd} [message]{.arg} 
[::grammar::me::tcl::ict_match_token]{.cmd} [tok]{.arg} [message]{.arg} 
[::grammar::me::tcl::ict_match_tokrange]{.cmd} [tokbegin]{.arg} [tokend]{.arg} [message]{.arg} 
[::grammar::me::tcl::ict_match_tokclass]{.cmd} [code]{.arg} [message]{.arg} 
[::grammar::me::tcl::inc_restore]{.cmd} [nt]{.arg} 
[::grammar::me::tcl::inc_save]{.cmd} [nt]{.arg} [startlocation]{.arg} 
[::grammar::me::tcl::iok_ok]{.cmd} 
[::grammar::me::tcl::iok_fail]{.cmd} 
[::grammar::me::tcl::iok_negate]{.cmd} 
[::grammar::me::tcl::icl_get]{.cmd} 
[::grammar::me::tcl::icl_rewind]{.cmd} [oldlocation]{.arg} 
[::grammar::me::tcl::ier_get]{.cmd} 
[::grammar::me::tcl::ier_clear]{.cmd} 
[::grammar::me::tcl::ier_nonterminal]{.cmd} [message]{.arg} [location]{.arg} 
[::grammar::me::tcl::ier_merge]{.cmd} [olderror]{.arg} 
[::grammar::me::tcl::isv_clear]{.cmd} 
[::grammar::me::tcl::isv_terminal]{.cmd} 
[::grammar::me::tcl::isv_nonterminal_leaf]{.cmd} [nt]{.arg} [startlocation]{.arg} 
[::grammar::me::tcl::isv_nonterminal_range]{.cmd} [nt]{.arg} [startlocation]{.arg} 
[::grammar::me::tcl::isv_nonterminal_reduce]{.cmd} [nt]{.arg} [startlocation]{.arg} [marker]{.optarg} 
[::grammar::me::tcl::ias_push]{.cmd} 
[::grammar::me::tcl::ias_mark]{.cmd} 
[::grammar::me::tcl::ias_pop2mark]{.cmd} [marker]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält eine Implementierung der virtuellen ME-Maschine. Bitte lesen Sie zunächst das Dokument **grammar::me_intro**, falls Sie nicht wissen, was eine virtuelle ME-Maschine ist.

Diese Implementierung ist sehr stark an Tcl gebunden. Alle Stacks im Maschinenzustand werden über den Tcl-Stack verwaltet, der gesamte Kontrollfluss wird durch Tcl-Befehle gesteuert, und die übrigen Maschinenbefehle werden direkt auf Tcl-Befehle abgebildet. Insbesondere die Abgleichung von Nichtterminalsymbolen erfolgt ebenfalls über Tcl-Prozeduren, wodurch die Maschinenimplementierung im Wesentlichen um benutzerdefinierte Befehle erweitert wird.

Darüber hinaus verarbeitet die Implementierung nur eine einzige Maschine, die während der Ausführung nicht unterbrochen werden kann und fest auf den Pull-Betrieb ausgelegt ist. Das heißt, sie fordert jedes neue Token explizit über eine Rückruffunktion an und zieht es in ihren Zustand ein.

Ein zugehöriges Paket ist **grammar::peg::interp**, das einen generischen Interpreter/Parser für Parsing Expression Grammars (PEGs) bereitstellt, der auf dieser Implementierung der virtuellen ME-Maschine aufbaut.

# API

Die in diesem Abschnitt dokumentierten Befehle implementieren keinen der Befehle der virtuellen ME-Maschine. Sie bieten Funktionen zur Initialisierung der Maschine und zum Abrufen wichtiger Informationen.

**::grammar::me::tcl** **cmd** *...*
: Dies ist ein Ensemble-Befehl, der Zugriff auf die in diesem Abschnitt aufgeführten Befehle gewährt. Detaillierte Angaben finden Sie in den jeweiligen Methoden.

**::grammar::me::tcl** **init** *nextcmd* ?*tokmap*?
: Dieser Befehl (re)initialisiert die Maschine. Er gibt die leere Zeichenkette zurück. Dieser Befehl muss vor jedem anderen Befehl dieses Pakets aufgerufen werden. Das Befehlspräfix *nextcmd* steht für den Eingabestrom von Zeichen und wird von der Maschine aufgerufen, sobald ein neues Zeichen aus dem Strom benötigt wird. Die Anweisung zur Handhabung hierfür lautet *ict_advance*. Die Rückruffunktion muss entweder die leere Liste oder eine Liste mit vier Elementen zurückgeben, die das Token, dessen Lexem-Attribut sowie dessen Position als Zeilennummer und Index der Spalte in dieser Reihenfolge enthalten. Die leere Liste signalisiert, dass das Ende des Eingabestroms erreicht wurde. Das Lexem-Attribut wird im Terminal-Cache gespeichert, aber ansonsten von der Maschine nicht verwendet. Das optionale Dictionary *tokmap* ordnet Token ganzzahligen Werten zu. Sofern vorhanden, legen die Zahlen eine Reihenfolge für die Token fest, die anschließend von *ict_match_tokrange* verwendet wird, um zu bestimmen, ob sich ein Token im angegebenen Bereich befindet oder nicht. Wird keine Token-Zuordnung festgelegt, wird stattdessen die lexikografische Reihenfolge der Tokennamen verwendet. Diese Wahl ist insbesondere dann sinnvoll, wenn Zeichen als Token verwendet werden.

**::grammar::me::tcl** **lc** *location*
: Dieser Befehl wandelt die Position eines Tokens, das als Offset im Eingabestrom angegeben wird, in die zugehörige Zeilennummer und den Spaltenindex um. Das Ergebnis des Befehls ist eine Liste mit zwei Elementen, die diese beiden Werte in der im vorigen Satz genannten Reihenfolge enthält. Dies ermöglicht es übergeordneten Ebenen, die im Fehlerstatus und im generierten AST enthaltenen Positionsinformationen in besser lesbare Daten umzuwandeln. *Hinweis*: Der Befehl kann keine Positionen umwandeln, die von der Maschine noch nicht erreicht wurden. Mit anderen Worten: Wenn die Maschine 7 Token gelesen hat, kann der Befehl die Offsets **0** bis **6** umwandeln, jedoch nichts darüber hinaus. Dies zeigt auch, dass es nicht möglich ist, Offsets zu konvertieren, die sich auf Positionen vor dem Beginn des Datenstroms beziehen. Nach einem Aufruf von **init** wird der für die Konvertierung verwendete Zustand gelöscht, wodurch weitere Konvertierungen unmöglich werden, bis die Maschine erneut Token gelesen hat.

**::grammar::me::tcl** **tok** *from* ?*to*?
: Dieser Befehl gibt eine Tcl-Liste zurück, die den Teil des Eingabestroms zwischen den Positionen *from* und *to* (beide inklusive) enthält. Wenn *to* nicht festgelegt ist, wird standardmäßig der Wert von *from* verwendet. Jedes Element der zurückgegebenen Liste ist eine Liste aus vier Elementen: dem Token, dem zugehörigen Lexem, der Zeilennummer und dem Spaltenindex, in dieser Reihenfolge. Mit anderen Worten: Jedes Element hat dieselbe Struktur wie das Ergebnis der *nextcmd*-Rückruffunktion, die an **::grammar::me::tcl::init** übergeben wird. Dieser Befehl unterwirft seine Positionsargumente denselben Einschränkungen wie **::grammar::me::tcl::lc**.

**::grammar::me::tcl** **tokens**
: Dieser Befehl gibt die Anzahl der Token zurück, die der virtuellen ME-Maschine derzeit bekannt sind.

**::grammar::me::tcl** **sv**
: Dieser Befehl gibt den aktuellen semantischen Wert *SV* zurück, der in der Maschine gespeichert ist. Dabei handelt es sich um einen abstrakten Syntaxbaum, wie er im Dokument **grammar::me_ast**, Abschnitt **AST-WERTE**, beschrieben ist.

**::grammar::me::tcl** **ast**
: Diese Methode gibt den abstrakten Syntaxbaum zurück, der sich derzeit an der Spitze des AST-Stapels der virtuellen ME-Maschine befindet. Es handelt sich hierbei um einen abstrakten Syntaxbaum gemäß der Spezifikation im Dokument **grammar::me_ast**, Abschnitt **AST-WERTE**.

**::grammar::me::tcl** **astall**
: Diese Methode gibt den gesamten Stapel der abstrakten Syntaxbäume zurück, die der virtuellen ME-Maschine derzeit bekannt sind. Jedes Element der zurückgegebenen Liste ist ein abstrakter Syntaxbaum, wie im Dokument **grammar::me_ast**, Abschnitt **AST-WERTE**, festgelegt. Das oberste Element des Stacks befindet sich am Ende der Liste.

**::grammar::me::tcl** **ctok**
: Diese Methode gibt das aktuelle Token zurück, das von der virtuellen ME-Maschine verarbeitet wird.

**::grammar::me::tcl** **nc**
: Diese Methode gibt den Inhalt des Nichtterminal-Caches als Dictionary zurück, das von „**symbol**,**location**“ auf Übereinstimmungsinformationen abbildet.

**::grammar::me::tcl** **next**
: Diese Methode gibt die Rückruffunktion für das nächste Token zurück, wie sie bei der Initialisierung der virtuellen ME-Maschine festgelegt wurde.

**::grammar::me::tcl** **ord**
: Diese Methode gibt ein Dictionary zurück, das die bei der Initialisierung der virtuellen ME-Maschine festgelegte *tokmap* enthält. **::grammar::me::tcl::ok** Diese Variable enthält den aktuellen Übereinstimmungsstatus *OK*. Sie wird als Variable anstelle eines Befehls bereitgestellt, da dies den Zugriff auf diese Informationen beschleunigt; die Zugriffsgeschwindigkeit wird hier als sehr wichtig erachtet, da diese Informationen ständig zur Bestimmung des Kontrollflusses herangezogen werden.


# MASCHINENSTATUS

Bitte lesen Sie zunächst das Dokument **grammar::me_vm**, um sich über die Spezifikationen der virtuellen ME-Maschine und deren Zustand zu informieren.

Diese Implementierung verwaltet den in jenem Dokument beschriebenen Zustand, mit Ausnahme der Stacks – abgesehen vom AST-Stack. Mit anderen Worten: Der Positionsstack, der Fehlerstack, der Rückgabestack und der AST-Marker-Stack werden implizit über den Standard-Tcl-Gültigkeitsbereich verwaltet, d. h. über Tcl-Variablen in Prozeduren außerhalb dieser Implementierung.

# MASCHINENBEFEHLE

Bitte lesen Sie zunächst das Dokument **grammar::me_vm**, um sich über die Spezifikationen der virtuellen ME-Maschine und ihres Befehlssatzes zu informieren.

Diese Implementierung ordnet alle Anweisungen Tcl-Befehlen im Namespace „::grammar::me::tcl“ zu, mit Ausnahme der stapelbezogenen Befehle, der nichtterminalen Symbole und der Kontrollflussanweisungen. Hier werden lediglich die Befehle aufgelistet und gegebenenfalls die Unterschiede zu den angegebenen Befehlen erläutert. Informationen zu ihrer Semantik finden Sie in der oben genannten Spezifikation. Die Maschinenbefehle sind über den Ensemble-Befehl **::grammar::me::tcl** *nicht* erreichbar.

**::grammar::me::tcl::ict_advance** *message*
: Keine Änderungen.

**::grammar::me::tcl::ict_match_token** *tok* *message*
: Keine Änderungen.

**::grammar::me::tcl::ict_match_tokrange** *tokbegin* *tokend* *message*
: Genau dann, wenn bei der Initialisierung eine Token-Zuordnung festgelegt wurde, sind die Argumente die numerischen Darstellungen des kleinsten und des größten Tokens im Bereich. Andernfalls handelt es sich um die betreffenden Token selbst, und es wird ein lexikografischer Vergleich herangezogen.

**::grammar::me::tcl::ict_match_tokclass** *code* *message*
: Keine Änderungen.

**::grammar::me::tcl::inc_restore** *nt*
: Anstatt ein Verzweigungslabel entgegenzunehmen, gibt der Befehl einen booleschen Wert zurück. Das Ergebnis lautet **true** genau dann, wenn zwischengespeicherte Informationen gefunden wurden. Der Aufrufer muss die entsprechende Verzweigung vornehmen.

**::grammar::me::tcl::inc_save** *nt* *startlocation*
: Der Befehl nimmt die Startposition als zusätzliches Argument entgegen, da diese auf dem Tcl-Stack verwaltet wird und nicht im Maschinenzustand.

**icf_ntcall** *branchlabel*
: ...siehe nächstes...

**icf_ntreturn**
: Diese beiden Anweisungen sind keinen Befehlen zugeordnet. Es handelt sich um Anweisungen zur Ablaufsteuerung, die in Tcl verarbeitet werden.

**::grammar::me::tcl::iok_ok**
: Keine Änderungen.

**::grammar::me::tcl::iok_fail**
: Keine Änderungen.

**::grammar::me::tcl::iok_negate**
: Keine Änderungen.

**icf_jalways** *branchlabel*
: ...siehe nächstes...

**icf_jok** *branchlabel*
: ...siehe nächstes...

**icf_jfail** *branchlabel*
: ...siehe nächstes...

**icf_halt**
: Diese vier Anweisungen sind keinen Befehlen zugeordnet. Es handelt sich um Anweisungen zur Steuerung des Programmablaufs, die in Tcl verarbeitet werden.

**::grammar::me::tcl::icl_get**
: Dieser Befehl gibt die aktuelle Position *CL* in der Eingabe zurück. Er ersetzt *icl_push*.

**::grammar::me::tcl::icl_rewind** *oldlocation*
: Der Befehl nimmt die Position als Argument entgegen, da diese aus dem Tcl-Stack stammt und nicht aus dem Maschinenzustand.

**icl_pop**
: Da sie nicht zugeordnet sind, werden die Stacks nicht vom Paket verwaltet.

**::grammar::me::tcl::ier_get**
: Dieser Befehl gibt den aktuellen Fehlerstatus *ER* zurück. Er ersetzt *ier_push*.

**::grammar::me::tcl::ier_clear**
: Keine Änderungen.

**::grammar::me::tcl::ier_nonterminal** *message* *location*
: Der Befehl nimmt die Position als Argument entgegen, da diese aus dem Tcl-Stack stammt und nicht aus dem Maschinenzustand.

**::grammar::me::tcl::ier_merge** *olderror*
: Der Befehl nimmt den zweiten Fehlerstatus, der zusammengeführt werden soll, als Argument entgegen, da dieser aus dem Tcl-Stack stammt und nicht aus dem Maschinenzustand.

**::grammar::me::tcl::isv_clear**
: Keine Änderungen.

**::grammar::me::tcl::isv_terminal**
: Keine Änderungen.

**::grammar::me::tcl::isv_nonterminal_leaf** *nt* *startlocation*
: Der Befehl nimmt die Startposition als Argument entgegen, da diese aus dem Tcl-Stack stammt und nicht aus dem Maschinenzustand.

**::grammar::me::tcl::isv_nonterminal_range** *nt* *startlocation*
: Der Befehl nimmt die Startposition als Argument entgegen, da diese aus dem Tcl-Stack stammt und nicht aus dem Maschinenzustand.

**::grammar::me::tcl::isv_nonterminal_reduce** *nt* *startlocation* ?*marker*?
: Der Befehl nimmt die Startposition und den Marker als Argumente entgegen, da diese aus dem Tcl-Stack stammen und nicht aus dem Maschinenzustand.

**::grammar::me::tcl::ias_push**
: Keine Änderungen.

**::grammar::me::tcl::ias_mark**
: Dieser Befehl gibt einen Marker für den aktuellen Zustand des AST-Stapels *AS* zurück. Der Marker-Stapel wird nicht von der Maschine verwaltet.

**::grammar::me::tcl::ias_pop2mark** *marker*
: Der Befehl übernimmt den Marker als Argument, da dieser aus dem Tcl-Stack stammt und nicht aus dem Maschinenzustand. Er ersetzt *ias_mpop*.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *grammar_me* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Grammatiken und endliche Automaten

# COPYRIGHT

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
