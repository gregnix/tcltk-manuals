---
CommandName: pt::rde
ManualSection: n
Version: 1.2
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

pt::rde – Laufzeitunterstützung für das Parsing, auf PARAM beruhend

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pt::rde]{.lit} [1.2]{.optlit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [struct::stack]{.lit} [1.6]{.lit} 
[package]{.cmd} [require]{.sub} [pt::ast]{.lit} [1.2]{.lit} 
[::pt::rde]{.cmd} [objectName]{.arg} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [reset]{.sub} [chan]{.arg} 
[objectName]{.ins} [complete]{.sub} 
[objectName]{.ins} [chan]{.sub} 
[objectName]{.ins} [line]{.sub} 
[objectName]{.ins} [column]{.sub} 
[objectName]{.ins} [current]{.sub} 
[objectName]{.ins} [location]{.sub} 
[objectName]{.ins} [locations]{.sub} 
[objectName]{.ins} [ok]{.sub} 
[objectName]{.ins} [value]{.sub} 
[objectName]{.ins} [error]{.sub} 
[objectName]{.ins} [errors]{.sub} 
[objectName]{.ins} [tokens]{.sub} [from ?to]{.optarg} 
[objectName]{.ins} [symbols]{.sub} 
[objectName]{.ins} [known]{.sub} 
[objectName]{.ins} [reducible]{.sub} 
[objectName]{.ins} [asts]{.sub} 
[objectName]{.ins} [ast]{.sub} 
[objectName]{.ins} [position]{.sub} [loc]{.arg} 
[objectName]{.ins} [i_input_next]{.sub} [msg]{.arg} 
[objectName]{.ins} [i_test_alnum]{.sub} 
[objectName]{.ins} [i_test_alpha]{.sub} 
[objectName]{.ins} [i_test_ascii]{.sub} 
[objectName]{.ins} [i_test_char]{.sub} [char]{.arg} 
[objectName]{.ins} [i_test_ddigit]{.sub} 
[objectName]{.ins} [i_test_digit]{.sub} 
[objectName]{.ins} [i_test_graph]{.sub} 
[objectName]{.ins} [i_test_lower]{.sub} 
[objectName]{.ins} [i_test_print]{.sub} 
[objectName]{.ins} [i_test_punct]{.sub} 
[objectName]{.ins} [i_test_range]{.sub} [chars]{.arg} [chare]{.arg} 
[objectName]{.ins} [i_test_space]{.sub} 
[objectName]{.ins} [i_test_upper]{.sub} 
[objectName]{.ins} [i_test_wordchar]{.sub} 
[objectName]{.ins} [i_test_xdigit]{.sub} 
[objectName]{.ins} [i_error_clear]{.sub} 
[objectName]{.ins} [i_error_push]{.sub} 
[objectName]{.ins} [i_error_pop_merge]{.sub} 
[objectName]{.ins} [i_error_nonterminal]{.sub} [symbol]{.arg} 
[objectName]{.ins} [i_status_ok]{.sub} 
[objectName]{.ins} [i_status_fail]{.sub} 
[objectName]{.ins} [i_status_negate]{.sub} 
[objectName]{.ins} [i_loc_push]{.sub} 
[objectName]{.ins} [i_loc_pop_discard]{.sub} 
[objectName]{.ins} [i_loc_pop_rewind]{.sub} 
[objectName]{.ins} [i:ok_loc_pop_rewind]{.sub} 
[objectName]{.ins} [i_loc_pop_rewind/discard]{.sub} 
[objectName]{.ins} [i_symbol_restore]{.sub} [symbol]{.arg} 
[objectName]{.ins} [i_symbol_save]{.sub} [symbol]{.arg} 
[objectName]{.ins} [i_value_clear]{.sub} 
[objectName]{.ins} [i_value_clear/leaf]{.sub} 
[objectName]{.ins} [i_value_clear/reduce]{.sub} 
[objectName]{.ins} [i:ok_ast_value_push]{.sub} 
[objectName]{.ins} [i_ast_push]{.sub} 
[objectName]{.ins} [i_ast_pop_rewind]{.sub} 
[objectName]{.ins} [i:fail_ast_pop_rewind]{.sub} 
[objectName]{.ins} [i_ast_pop_rewind/discard]{.sub} 
[objectName]{.ins} [i_ast_pop_discard]{.sub} 
[objectName]{.ins} [i_ast_pop_discard/rewind]{.sub} 
[objectName]{.ins} [i:ok_continue]{.sub} 
[objectName]{.ins} [i:fail_continue]{.sub} 
[objectName]{.ins} [i:fail_return]{.sub} 
[objectName]{.ins} [i:ok_return]{.sub} 
[objectName]{.ins} [si:void_state_push]{.sub} 
[objectName]{.ins} [si:void2_state_push]{.sub} 
[objectName]{.ins} [si:value_state_push]{.sub} 
[objectName]{.ins} [si:void_state_merge]{.sub} 
[objectName]{.ins} [si:void_state_merge_ok]{.sub} 
[objectName]{.ins} [si:value_state_merge]{.sub} 
[objectName]{.ins} [si:value_notahead_start]{.sub} 
[objectName]{.ins} [si:void_notahead_exit]{.sub} 
[objectName]{.ins} [si:value_notahead_exit]{.sub} 
[objectName]{.ins} [si:kleene_abort]{.sub} 
[objectName]{.ins} [si:kleene_close]{.sub} 
[objectName]{.ins} [si:voidvoid_branch]{.sub} 
[objectName]{.ins} [si:voidvalue_branch]{.sub} 
[objectName]{.ins} [si:valuevoid_branch]{.sub} 
[objectName]{.ins} [si:valuevalue_branch]{.sub} 
[objectName]{.ins} [si:voidvoid_part]{.sub} 
[objectName]{.ins} [si:voidvalue_part]{.sub} 
[objectName]{.ins} [si:valuevalue_part]{.sub} 
[objectName]{.ins} [si:value_symbol_start]{.sub} [symbol]{.arg} 
[objectName]{.ins} [si:value_void_symbol_start]{.sub} [symbol]{.arg} 
[objectName]{.ins} [si:void_symbol_start]{.sub} [symbol]{.arg} 
[objectName]{.ins} [si:void_void_symbol_start]{.sub} [symbol]{.arg} 
[objectName]{.ins} [si:reduce_symbol_end]{.sub} [symbol]{.arg} 
[objectName]{.ins} [si:void_leaf_symbol_end]{.sub} [symbol]{.arg} 
[objectName]{.ins} [si:value_leaf_symbol_end]{.sub} [symbol]{.arg} 
[objectName]{.ins} [si:value_clear_symbol_end]{.sub} [symbol]{.arg} 
[objectName]{.ins} [si:void_clear_symbol_end]{.sub} [symbol]{.arg} 
[objectName]{.ins} [si:next_char]{.sub} [tok]{.arg} 
[objectName]{.ins} [si:next_range]{.sub} [toks]{.arg} [toke]{.arg} 
[objectName]{.ins} [si:next_alnum]{.sub} 
[objectName]{.ins} [si:next_alpha]{.sub} 
[objectName]{.ins} [si:next_ascii]{.sub} 
[objectName]{.ins} [si:next_ddigit]{.sub} 
[objectName]{.ins} [si:next_digit]{.sub} 
[objectName]{.ins} [si:next_graph]{.sub} 
[objectName]{.ins} [si:next_lower]{.sub} 
[objectName]{.ins} [si:next_print]{.sub} 
[objectName]{.ins} [si:next_punct]{.sub} 
[objectName]{.ins} [si:next_space]{.sub} 
[objectName]{.ins} [si:next_upper]{.sub} 
[objectName]{.ins} [si:next_wordchar]{.sub} 
[objectName]{.ins} [si:next_xdigit]{.sub} 
:::

# BESCHREIBUNG

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket enthält eine Klasse, deren Instanzen die Laufzeitunterstützung für rekursive Abstiegsparser mit Backtracking bereitstellen, wie sie beispielsweise für die Ausführung von Parsing Expression Grammars erforderlich ist. Es implementiert die *PackRat Machine Specification*; daher ist die Lektüre dieses Dokuments *unabdingbar*, um sowohl diese Manpage als auch das Paket selbst zu verstehen. Die nachstehende Beschreibung enthält zahlreiche verkürzte Verweise auf die Anweisungen der PARAM und die verschiedenen Teile ihres architektonischen Zustands.

Das Paket befindet sich im Abschnitt „Ausführung“ der Kernschicht der Parser-Tools.

Bild: arch_core_transform

Hinweis: Dieses Paket enthält nicht nur die Standard-Tcl-Implementierung, sondern auch einen Beschleuniger, d. h. eine auf Critcl basierende C-Implementierung.

## API für Klassen

Das Paket exportiert die hier beschriebene API.

**::pt::rde** *objectName*
: Der Befehl erstellt ein neues Laufzeitobjekt für einen rekursiven Abwärtsparser mit Backtracking und gibt den vollqualifizierten Namen des Objektbefehls als Ergebnis zurück. Die API dieses Objektbefehls wird im Abschnitt **Objekt-API** beschrieben. Sie kann verwendet werden, um verschiedene Operationen auf dem Objekt auszuführen.


## Objekt-API

Alle von diesem Paket erstellten Objekte stellen die folgenden 63 Methoden zur Bearbeitung und Abfrage ihres Zustands bereit, bei dem es sich im Wesentlichen um den architektonischen Zustand eines PARAM handelt.

Zuerst einige allgemeine Methoden und die Zugriffe auf den Zustand.

*objectName* **destroy**
: Diese Methode zerstört das Objekt, gibt den gesamten belegten Speicher frei und löscht den zugehörigen Objektbefehl.

*objectName* **reset** *chan*
: Diese Methode setzt den Zustand der Laufzeitumgebung auf die Standardwerte zurück und bereitet sie so auf das Parsen der Zeichen im Kanal *chan* vor, der nun als IN dient. Die Parser-Tools beruhen auf Tcl 8.5+. Mit anderen Worten: Das Kanal-Argument ist nicht auf Dateien, Sockets usw. beschränkt. Uns steht die volle Leistungsfähigkeit von *reflektierten Kanälen* zur Verfügung. Es sei außerdem darauf hingewiesen, dass der Parser die Zeichen nach Bedarf aus dem Eingabestrom abruft. Wenn ein durch dieses Paket erstellter Parser im Push-Modus, d. h. ereignisgesteuert betrieben werden soll, ist es erforderlich, auf Tcl 8.6+ umzusteigen und **coroutine::auto** zu verwenden, um ihn in eine Coroutine zu verpacken, wobei **read** für den Push-Betrieb entsprechend angepasst werden muss.

*objectName* **complete**
: Diese Methode schließt die Analyse ab und gibt entweder den aus den Elementen von ARS erstellten AST zurück oder löst einen Fehler aus, der den aktuellen ER enthält.

*objectName* **chan**
: Diese Methode gibt das Handle des Kanals zurück, der IN ist.

*objectName* **line**
: Diese Methode gibt die Zeilennummer der Position zurück, an der sich IN derzeit befindet. Diese Zeilennummer muss aufgrund von Backtracking nicht mit der Zeilennummer von CL übereinstimmen.

*objectName* **column**
: Diese Methode gibt die Spalte zurück, an der sich IN derzeit befindet. Diese Spalte muss aufgrund von Backtracking nicht mit der Spalte von CL übereinstimmen.

*objectName* **current**
: Diese Methode gibt CC zurück.

*objectName* **location**
: Diese Methode gibt CL zurück.

*objectName* **locations**
: Diese Methode gibt die LS zurück. Der oberste Eintrag des Stapels ist das erste Element der zurückgegebenen Liste.

*objectName* **ok**
: Diese Methode gibt ST zurück.

*objectName* **value**
: Diese Methode gibt SV zurück.

*objectName* **error**
: Diese Methode gibt ER zurück. Dabei handelt es sich entweder um die leere Zeichenkette bei einem leeren ER oder um eine Liste mit zwei Elementen: die Stelle, auf die sich der Fehler bezieht, sowie eine Menge von Meldungen, die angeben, welche Symbole an dieser Stelle erwartet wurden. Die Meldungen sind als einer der möglichen atomaren Parsing-Ausdrücke kodiert (Spezialoperatoren, Terminale, Bereichsoperatoren und Nichtterminale).

*objectName* **errors**
: Diese Methode gibt ES zurück. Der oberste Eintrag des Stapels ist das erste Element der zurückgegebenen Liste. Jeder Eintrag wird wie unter **error** beschrieben kodiert.

*objectName* **tokens** ?*from* ?*to*??
: Diese Methode gibt den Teil von TC zurück, der den Bereich der Positionen von IN abdeckt, beginnend bei *from* und endend bei *to*. Wenn *to* nicht festgelegt wird, wird es als identisch mit *from* angesehen. Wenn keines der beiden Argumente festgelegt wird, wird TC vollständig zurückgegeben. Jedes Element in der zurückgegebenen Liste ist selbst eine Liste aus drei Elementen, die in dieser Reihenfolge das Zeichen an der angegebenen Position sowie die zugehörigen Zeilen- und Spaltennummern enthält.

*objectName* **symbols**
: Diese Methode gibt ein Dictionary zurück, das NC enthält. Die Schlüssel sind Listen mit zwei Elementen, die in dieser Reihenfolge das nichtterminale Symbol und die Position enthalten. Die Werte sind 4-Tupel, die in dieser Reihenfolge CL, ST, ER und SV enthalten. ER wird wie für die Methode **error** festgelegt kodiert.

*objectName* **known**
: Diese Methode gibt eine Liste zurück, die die Schlüssel von SC enthält. Diese werden auf dieselbe Weise kodiert wie bei der Methode **symbols**.

*objectName* **reducible**
: Diese Methode gibt ARS zurück. Der oberste Eintrag des Stapels ist das erste Element der zurückgegebenen Liste.

*objectName* **asts**
: Diese Methode gibt AS zurück. Der oberste Eintrag des Stapels ist das erste Element der zurückgegebenen Liste.

*objectName* **ast**
: Dies ist eine Hilfsmethode, die das oberste Element von ARS zurückgibt.

*objectName* **position** *loc*
: Diese Methode gibt die Zeilen- und Spaltennummern für die angegebene Position von IN zurück, vorausgesetzt, diese Position wurde bereits während des Parsing-Prozesses erreicht. Die folgenden Methoden implementieren alle PARAM-Anweisungen. Sie tragen alle das Präfix „i\_“. Die Ablaufsteuerung erfolgt hauptsächlich über die in Tcl integrierten Befehle wie **if**, **while** usw. sowie über einige bedingte Varianten von PARAM-Anweisungen und Tcl-Befehlen. Das bedeutet, dass diese Befehlsvarianten nichts bewirken, wenn ihre Schutzbedingung nicht erfüllt ist. Sie sind an den Präfixen „i:ok\_“ und „i:fail\_“ zu erkennen, die den Wert angeben, den ST haben muss, damit der Befehl ausgeführt wird. Die Befehle sind in derselben Reihenfolge aufgeführt, in der sie in der *PackRat Machine Specification* vorkommen, wobei die bedingten Varianten gegebenenfalls nach ihrer regulären Implementierung oder an deren Stelle aufgeführt sind.

*objectName* **i_input_next** *msg*
: Diese Methode implementiert den PARAM-Befehl **input_next**.

*objectName* **i_test_alnum**
: Diese Methode implementiert den PARAM-Befehl **test_alnum**.

*objectName* **i_test_alpha**
: Diese Methode implementiert den PARAM-Befehl **test_alpha**.

*objectName* **i_test_ascii**
: Diese Methode implementiert den PARAM-Befehl **test_ascii**.

*objectName* **i_test_char** *char*
: Diese Methode implementiert den PARAM-Befehl **test_char**.

*objectName* **i_test_ddigit**
: Diese Methode implementiert den PARAM-Befehl **test_ddigit**.

*objectName* **i_test_digit**
: Diese Methode implementiert den PARAM-Befehl **test_digit**.

*objectName* **i_test_graph**
: Diese Methode implementiert den PARAM-Befehl **test_graph**.

*objectName* **i_test_lower**
: Diese Methode implementiert den PARAM-Befehl **test_lower**.

*objectName* **i_test_print**
: Diese Methode implementiert den PARAM-Befehl **test_print**.

*objectName* **i_test_punct**
: Diese Methode implementiert den PARAM-Befehl **test_punct**.

*objectName* **i_test_range** *chars* *chare*
: Diese Methode implementiert den PARAM-Befehl **test_range**.

*objectName* **i_test_space**
: Diese Methode implementiert den PARAM-Befehl **test_space**.

*objectName* **i_test_upper**
: Diese Methode implementiert den PARAM-Befehl **test_upper**.

*objectName* **i_test_wordchar**
: Diese Methode implementiert den PARAM-Befehl **test_wordchar**.

*objectName* **i_test_xdigit**
: Diese Methode implementiert den PARAM-Befehl **test_xdigit**.

*objectName* **i_error_clear**
: Diese Methode implementiert den PARAM-Befehl **error_clear**.

*objectName* **i_error_push**
: Diese Methode implementiert den PARAM-Befehl **error_push**.

*objectName* **i_error_pop_merge**
: Diese Methode implementiert den PARAM-Befehl **error_pop_merge**.

*objectName* **i_error_nonterminal** *symbol*
: Diese Methode implementiert den PARAM-Befehl **error_nonterminal**.

*objectName* **i_status_ok**
: Diese Methode implementiert den PARAM-Befehl **status_ok**.

*objectName* **i_status_fail**
: Diese Methode implementiert den PARAM-Befehl **status_fail**.

*objectName* **i_status_negate**
: Diese Methode implementiert den PARAM-Befehl **status_negate**.

*objectName* **i_loc_push**
: Diese Methode implementiert den PARAM-Befehl **loc_push**.

*objectName* **i_loc_pop_discard**
: Diese Methode implementiert den PARAM-Befehl **loc_pop_discard**.

*objectName* **i_loc_pop_rewind**
: Diese Methode implementiert den PARAM-Befehl **loc_pop_rewind**.

*objectName* **i:ok_loc_pop_rewind**
: Diese geschützte Methode, eine Variante von **i_loc_pop_rewind**, wird nur ausgeführt, wenn „ST == ok“ gilt.

*objectName* **i_loc_pop_rewind/discard**
: Diese Methode stellt eine praktische Kombination aus Ablaufsteuerung und den beiden PARAM-Anweisungen **loc_pop_rewind** und **loc_pop_discard** dar. Die erstgenannte wird bei „ST == fail“ ausgeführt, die letztgenannte bei „ST == ok“.

*objectName* **i_symbol_restore** *symbol*
: Diese Methode implementiert den PARAM-Befehl **symbol_restore**. Das boolesche Ergebnis der Prüfung wird als Ergebnis der Methode zurückgegeben und kann mit den üblichen Tcl-Befehlen zur Ablaufsteuerung verwendet werden.

*objectName* **i_symbol_save** *symbol*
: Diese Methode implementiert den PARAM-Befehl **symbol_save**.

*objectName* **i_value_clear**
: Diese Methode implementiert den PARAM-Befehl **value_clear**.

*objectName* **i_value_clear/leaf**
: Diese Methode stellt eine praktische Kombination aus Ablaufsteuerung und den beiden PARAM-Anweisungen **value_clear** und **value_leaf** dar. Die erstgenannte wird bei „ST == fail“ ausgeführt, die letztgenannte bei „ST == ok“.

*objectName* **i_value_clear/reduce**
: Diese Methode stellt eine praktische Kombination aus Ablaufsteuerung und den beiden PARAM-Anweisungen **value_clear** und **value_reduce** dar. Die erstgenannte wird bei „ST == fail“ ausgeführt, die letztgenannte bei „ST == ok“.

*objectName* **i:ok_ast_value_push**
: Diese Methode implementiert eine geschützte Variante des PARAM-Befehls **ast_value_push**, die nur ausgeführt wird, wenn „ST == ok“ gilt.

*objectName* **i_ast_push**
: Diese Methode implementiert den PARAM-Befehl **ast_push**.

*objectName* **i_ast_pop_rewind**
: Diese Methode implementiert den PARAM-Befehl **ast_pop_rewind**.

*objectName* **i:fail_ast_pop_rewind**
: Diese geschützte Methode, eine Variante von **i_ast_pop_rewind**, wird nur ausgeführt, wenn „ST == fail“ gilt.

*objectName* **i_ast_pop_rewind/discard**
: Diese Methode stellt eine praktische Kombination aus Ablaufsteuerung und den beiden PARAM-Anweisungen **ast_pop_rewind** und **ast_pop_discard** dar. Die erstgenannte wird bei „ST == fail“ ausgeführt, die letztgenannte bei „ST == ok“.

*objectName* **i_ast_pop_discard**
: Diese Methode implementiert den PARAM-Befehl **ast_pop_discard**.

*objectName* **i_ast_pop_discard/rewind**
: Diese Methode stellt eine praktische Kombination aus Ablaufsteuerung und den beiden PARAM-Anweisungen **ast_pop_discard** und **ast_pop_rewind** dar. Erstere wird bei „ST == fail“ ausgeführt, letztere bei „ST == ok“.

*objectName* **i:ok_continue**
: Diese geschützte Methode wird nur ausgeführt, wenn „ST == ok“ gilt. Anschließend bricht sie die aktuelle Iteration der innersten Schleife in der aufrufenden Tcl-Prozedur ab.

*objectName* **i:fail_continue**
: Diese geschützte Methode wird nur ausgeführt, wenn „ST == fail“ gilt. Anschließend bricht sie die aktuelle Iteration der innersten Schleife in der aufrufenden Tcl-Prozedur ab.

*objectName* **i:fail_return**
: Diese geschützte Methode wird nur ausgeführt, wenn „ST == fail“ gilt. Anschließend bricht sie die aufrufende Tcl-Prozedur ab.

*objectName* **i:ok_return**
: Diese geschützte Methode wird nur ausgeführt, wenn „ST == ok“ gilt. Anschließend bricht sie die aufrufende Tcl-Prozedur ab. Die nächste Gruppe von Methoden sind *Superbefehle*, was bedeutet, dass jede von ihnen eine längere Folge von Befehlen implementiert, die üblicherweise in Parsern verwendet werden. Die kombinierten Befehle der vorherigen Gruppe, d. h. jene, deren Namen dem Muster „i\_\*/\*“ entsprechen, sind ebenfalls Superbefehle, wenn auch mit begrenztem Geltungsbereich, da sie zwei Befehle mit ihrem Kontrollfluss verarbeiten. Die folgende Gruppe hat einen wesentlich breiteren Anwendungsbereich und fasst bis zu sechs oder mehr PARAM-Befehle in einer einzigen Methode zusammen. Hier lässt sich die Begründung für ihre Verwendung gut nachvollziehen:


**\[1\]**
: Durch die Verwendung von weniger Anweisungen werden die generierten Parser kleiner, da die gemeinsamen Teile nun tatsächlich Teil der gemeinsamen Laufzeitumgebung sind und nicht mehr immer wieder explizit in den Code des Parsers geschrieben werden müssen.

**\[2\]**
: Durch die Verwendung von weniger Befehlen wird zudem der mit Aufrufen an die Laufzeitumgebung verbundene Overhead reduziert, d. h. der Aufwand für die Vermittlung der Methodenaufrufe und die Einrichtung des Kontexts für Variablen.

**\[3\]**
: Ein weiterer Effekt der Superbefehle besteht darin, dass auch deren interne Abläufe optimiert werden können, insbesondere hinsichtlich des Kontrollflusses und der Stapelnutzung, da die internen Abläufe der Laufzeitumgebung für alle in die Sequenz zusammengefassten Befehle zugänglich sind.


*objectName* **si:void_state_push**
: Diese Methode kombiniert


```
i_loc_push
i_error_clear
i_error_push
```

: Parser verwenden es am Anfang von *void*-Sequenzen und bei Auswahlmöglichkeiten mit einem *void*-Anfangszweig.


*objectName* **si:void2_state_push**
: Diese Methode kombiniert


```
i_loc_push
i_error_clear
i_error_push
```

: Parser verwenden es am Anfang von optionalen und wiederholten Ausdrücken.


*objectName* **si:value_state_push**
: Diese Methode kombiniert


```
i_ast_push
i_loc_push
i_error_clear
i_error_push
```

: Parser verwenden ihn am Anfang von Sequenzen, die einen AST erzeugen, und bei Auswahlen mit einem Anfangszweig, der einen AST erzeugt.


*objectName* **si:void_state_merge**
: Diese Methode kombiniert


```
i_error_pop_merge
i_loc_pop_rewind/discard
```

: Parser verwenden ihn am Ende von *void*-Sequenzen und Auswahlen, deren letzter Zweig *void* ist.


*objectName* **si:void_state_merge_ok**
: Diese Methode kombiniert


```
i_error_pop_merge
i_loc_pop_rewind/discard
i_status_ok
```

: Parser verwenden es am Ende optionaler Ausdrücke


*objectName* **si:value_state_merge**
: Diese Methode kombiniert


```
i_error_pop_merge
i_ast_pop_rewind/discard
i_loc_pop_rewind/discard
```

: Parser verwenden ihn am Ende von Sequenzen, die ASTs erzeugen, und von Auswahlen, deren letzter Zweig einen AST erzeugt.


*objectName* **si:value_notahead_start**
: Diese Methode kombiniert


```
i_loc_push
i_ast_push
```

: Parser verwenden ihn am Anfang von Prädikaten mit negativer Vorausschau, die ASTs erzeugen.


*objectName* **si:void_notahead_exit**
: Diese Methode kombiniert


```
i_loc_pop_rewind
i_status_negate
```

: Parser verwenden ihn am Ende von *void*-Prädikaten mit negativer Vorausschau.


*objectName* **si:value_notahead_exit**
: Diese Methode kombiniert


```
i_ast_pop_discard/rewind
i_loc_pop_rewind
i_status_negate
```

: Parser verwenden ihn am Ende von Prädikaten mit negativer Vorausschau, die ASTs erzeugen.


*objectName* **si:kleene_abort**
: Diese Methode kombiniert


```
i_loc_pop_rewind/discard
i:fail_return
```

: Parser verwenden dies, um eine positive Wiederholung zu beenden, wenn der erste, erforderliche Ausdruck fehlschlägt.


*objectName* **si:kleene_close**
: Diese Methode kombiniert


```
i_error_pop_merge
i_loc_pop_rewind/discard
i:fail_status_ok
i:fail_return
```

: Parser verwenden es am Ende von Wiederholungen.


*objectName* **si:voidvoid_branch**
: Diese Methode kombiniert


```
i_error_pop_merge
i:ok_loc_pop_discard
i:ok_return
i_loc_rewind
i_error_push
```

: Parser verwenden ihn beim Übergang zwischen den Zweigen einer Auswahl, wenn beide *void* sind.


*objectName* **si:voidvalue_branch**
: Diese Methode kombiniert


```
i_error_pop_merge
i:ok_loc_pop_discard
i:ok_return
i_ast_push
i_loc_rewind
i_error_push
```

: Parser verwenden ihn beim Übergang zwischen den Zweigen einer Auswahl, wenn der fehlgeschlagene Zweig *void* ist und der als Nächstes zu prüfende Zweig einen AST erzeugt.


*objectName* **si:valuevoid_branch**
: Diese Methode kombiniert


```
i_error_pop_merge
i_ast_pop_rewind/discard
i:ok_loc_pop_discard
i:ok_return
i_loc_rewind
i_error_push
```

: Parser verwenden ihn beim Übergang zwischen den Zweigen einer Auswahl, wenn der fehlgeschlagene Zweig einen AST erzeugt und der als Nächstes zu prüfende Zweig *void* ist.


*objectName* **si:valuevalue_branch**
: Diese Methode kombiniert


```
i_error_pop_merge
i_ast_pop_discard
i:ok_loc_pop_discard
i:ok_return
i_ast_rewind
i_loc_rewind
i_error_push
```

: Parser verwenden ihn beim Übergang zwischen den Zweigen einer Auswahl, wenn beide ASTs erzeugen.


*objectName* **si:voidvoid_part**
: Diese Methode kombiniert


```
i_error_pop_merge
i:fail_loc_pop_rewind
i:fail_return
i_error_push
```

: Parser verwenden ihn beim Übergang zwischen Teilen einer Sequenz, wenn beide *void* sind.


*objectName* **si:voidvalue_part**
: Diese Methode kombiniert


```
i_error_pop_merge
i:fail_loc_pop_rewind
i:fail_return
i_ast_push
i_error_push
```

: Parser verwenden ihn beim Übergang zwischen Teilen einer Sequenz, wenn der erfolgreich erkannte Teil *void* ist und danach ein AST erzeugt wird.


*objectName* **si:valuevalue_part**
: Diese Methode kombiniert


```
i_error_pop_merge
i:fail_ast_pop_rewind
i:fail_loc_pop_rewind
i:fail_return
i_error_push
```

: Parser verwenden dies beim Übergang zwischen Teilen einer Sequenz, wenn beide Teile ASTs erzeugen.


*objectName* **si:value_symbol_start** *symbol*
: Diese Methode kombiniert


```
if/found? i_symbol_restore $symbol
i:found:ok_ast_value_push
i:found_return
i_loc_push
i_ast_push
```

: Parser verwenden es am Anfang eines nichtterminalen Symbols, das einen AST erzeugt, dessen rechte Seite möglicherweise ebenfalls einen AST erzeugt hat.


*objectName* **si:value_void_symbol_start** *symbol*
: Diese Methode kombiniert


```
if/found? i_symbol_restore $symbol
i:found:ok_ast_value_push
i:found_return
i_loc_push
i_ast_push
```

: Parser verwenden ihn am Anfang eines *void*-Nichtterminals, dessen rechte Seite einen AST erzeugen kann.


*objectName* **si:void_symbol_start** *symbol*
: Diese Methode kombiniert


```
if/found? i_symbol_restore $symbol
i:found_return
i_loc_push
i_ast_push
```

: Parser verwenden ihn am Anfang eines Nichtterminals, das einen AST erzeugt und dessen rechte Seite *void* ist.


*objectName* **si:void_void_symbol_start** *symbol*
: Diese Methode kombiniert


```
if/found? i_symbol_restore $symbol
i:found_return
i_loc_push
```

: Parser verwenden ihn am Anfang eines *void*-Nichtterminals, dessen rechte Seite ebenfalls *void* ist.


*objectName* **si:reduce_symbol_end** *symbol*
: Diese Methode kombiniert


```
i_value_clear/reduce $symbol
i_symbol_save        $symbol
i_error_nonterminal  $symbol
i_ast_pop_rewind
i_loc_pop_discard
i:ok_ast_value_push
```

: Parser verwenden ihn am Ende eines Nichtterminals, das einen AST erzeugt und den von der rechten Seite erzeugten AST als Kindknoten verwendet.


*objectName* **si:void_leaf_symbol_end** *symbol*
: Diese Methode kombiniert


```
i_value_clear/leaf  $symbol
i_symbol_save       $symbol
i_error_nonterminal $symbol
i_loc_pop_discard
i:ok_ast_value_push
```

: Parser verwenden ihn am Ende eines Nichtterminals, das einen AST erzeugt und dessen rechte Seite *void* ist.


*objectName* **si:value_leaf_symbol_end** *symbol*
: Diese Methode kombiniert


```
i_value_clear/leaf  $symbol
i_symbol_save       $symbol
i_error_nonterminal $symbol
i_loc_pop_discard
i_ast_pop_rewind
i:ok_ast_value_push
```

: Parser verwenden es am Ende eines nichtterminalen Symbols, das einen AST erzeugt, wobei der von der rechten Seite erzeugte AST verworfen wird.


*objectName* **si:value_clear_symbol_end** *symbol*
: Diese Methode kombiniert


```
i_value_clear
i_symbol_save       $symbol
i_error_nonterminal $symbol
i_loc_pop_discard
i_ast_pop_rewind
```

: Parser verwenden ihn am Ende eines *void*-Nichtterminals und verwerfen den von der rechten Seite erzeugten AST.


*objectName* **si:void_clear_symbol_end** *symbol*
: Diese Methode kombiniert


```
i_value_clear
i_symbol_save       $symbol
i_error_nonterminal $symbol
i_loc_pop_discard
```

: Parser verwenden ihn am Ende eines *void*-Nichtterminals, dessen rechte Seite ebenfalls *void* ist.


*objectName* **si:next_char** *tok*
: ...siehe nächstes...

*objectName* **si:next_range** *toks* *toke*
: ...siehe nächstes...

*objectName* **si:next_alnum**
: ...siehe nächstes...

*objectName* **si:next_alpha**
: ...siehe nächstes...

*objectName* **si:next_ascii**
: ...siehe nächstes...

*objectName* **si:next_ddigit**
: ...siehe nächstes...

*objectName* **si:next_digit**
: ...siehe nächstes...

*objectName* **si:next_graph**
: ...siehe nächstes...

*objectName* **si:next_lower**
: ...siehe nächstes...

*objectName* **si:next_print**
: ...siehe nächstes...

*objectName* **si:next_punct**
: ...siehe nächstes...

*objectName* **si:next_space**
: ...siehe nächstes...

*objectName* **si:next_upper**
: ...siehe nächstes...

*objectName* **si:next_wordchar**
: ...siehe nächstes...

*objectName* **si:next_xdigit**
: Diese Methoden vereinen alle


```
i_input_next $msg
i:fail_return
```

: mit der entsprechenden Anweisung **i_test_xxx**. Parser verwenden diese zur Verarbeitung atomarer Ausdrücke.


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
