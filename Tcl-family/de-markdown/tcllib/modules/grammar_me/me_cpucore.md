---
CommandName: grammar::me::cpu::core
title: grammar::me::cpu::core
ManualSection: n
Version: 0.4
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - grammar
 - parsing
 - virtual machine
Copyright:
 - Copyright (c) 2005-2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

grammar::me::cpu::core – Manipulation des Zustands einer virtuellen ME-Maschine

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [grammar::me::cpu::core]{.lit} [0.4]{.optlit}
[::grammar::me::cpu::core]{.cmd} [disasm]{.lit} [asm]{.arg}
[::grammar::me::cpu::core]{.cmd} [asm]{.lit} [asm]{.arg}
[::grammar::me::cpu::core]{.cmd} [new]{.lit} [asm]{.arg}
[::grammar::me::cpu::core]{.cmd} [lc]{.lit} [state]{.arg} [location]{.arg}
[::grammar::me::cpu::core]{.cmd} [tok]{.lit} [state]{.arg} [from ?to]{.optarg}
[::grammar::me::cpu::core]{.cmd} [pc]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [iseof]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [at]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [cc]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [sv]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [ok]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [error]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [lstk]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [astk]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [mstk]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [estk]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [rstk]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [nc]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [ast]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [halted]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [code]{.lit} [state]{.arg}
[::grammar::me::cpu::core]{.cmd} [eof]{.lit} [statevar]{.arg}
[::grammar::me::cpu::core]{.cmd} [put]{.lit} [statevar]{.arg} [tok]{.arg} [lex]{.arg} [line]{.arg} [col]{.arg}
[::grammar::me::cpu::core]{.cmd} [run]{.lit} [statevar]{.arg} [n]{.optarg}
:::

# Beschreibung

Dieses Paket enthält eine Implementierung der virtuellen ME-Maschine. Bitte lesen Sie zunächst das Dokument **grammar::me\_intro**, falls Sie nicht wissen, was eine virtuelle ME-Maschine ist.

Diese Implementierung stellt jede virtuelle ME-Maschine als Tcl-Wert dar und bietet Befehle zur Bearbeitung und Abfrage solcher Werte, um die Auswirkungen der Ausführung von Anweisungen, des Hinzufügens von Tokens, des Abrufens des Zustands usw. zu veranschaulichen.

Die Werte folgen vollständig dem Tcl-Paradigma, wonach jeder Wert eine Zeichenkette ist, ermöglichen jedoch gleichzeitig C-Implementierungen für einen geeigneten Tcl\_ObjType, um alle wichtigen Daten in nativen Datenstrukturen zu speichern. Aus diesem Grund wird empfohlen, auf die Zustandswerte *ausschließlich* über die Befehle dieses Pakets zuzugreifen, um sicherzustellen, dass die interne Darstellung nicht verfälscht wird.

Die tatsächliche Struktur, die von allen Werten verwendet wird, wird im Abschnitt [CPU-Zustand] beschrieben.

# API

Das Paket stellt direkt nur einen einzigen Befehl bereit, und der gesamte Funktionsumfang wird über dessen Methoden zur Verfügung gestellt.

**::grammar::me::cpu::core** **disasm** *asm*
: Diese Methode gibt eine Liste zurück, die eine Disassemblierung der Match-Anweisungen im Format *asm* enthält. Das Format von *asm* ist im Abschnitt [Darstellung des Match-Programms] festgelegt.

    Jedes Element des Ergebnisses enthält in dieser Reihenfolge das Befehlslabel, den Befehlsnamen und die Befehlsargumente. Das Label kann eine leere Zeichenkette sein. Sprungziele werden als Labels, Zeichenketten und Tokens ohne Kodierung dargestellt. Tokennamen werden mit ihrer numerischen ID vorangestellt, genau dann, wenn eine Token-Zuordnung definiert ist. Die beiden Komponenten werden durch einen Doppelpunkt getrennt.

**::grammar::me::cpu::core** **asm** *asm*
: Diese Methode gibt Code in dem im Abschnitt [Darstellung des Match-Programms] angegebenen Format zurück, der aus dem ME-Assemblercode *asm* generiert wurde, der wiederum in dem Format vorliegt, wie er von der Methode **disasm** zurückgegeben wird.

**::grammar::me::cpu::core** **new** *asm*
: Diese Methode erzeugt einen Wert für den Zustand einer virtuellen ME-Maschine in ihrem Ausgangszustand und gibt diesen als Ergebnis zurück.

    Das Argument *matchcode* enthält eine Tcl-Darstellung der Match-Anweisungen, die die Maschine beim Parsen des Eingabestroms ausführen muss. Das Format ist im Abschnitt [Darstellung des Match-Programms] festgelegt.

    Das Argument *tokmap*, das von der durch das Paket **grammar::me::tcl** bereitgestellten Implementierung verwendet wird, ist hier in den Match-Anweisungen verborgen und wird daher nicht benötigt.

**::grammar::me::cpu::core** **lc** *state* *location*
: Diese Methode übernimmt den Wert des Status einer virtuellen ME-Maschine und wandelt damit eine Position im Eingabestrom (als Offset) in eine Zeilennummer und einen Index für die Spalten um. Das Ergebnis der Methode ist eine Liste mit zwei Elementen, die diese beiden Werte in der im vorigen Satz genannten Reihenfolge enthalten.

    *Hinweis*: Die Methode kann keine Positionen umwandeln, die die Maschine noch nicht aus dem Eingabestrom gelesen hat. Mit anderen Worten: Wenn die Maschine bisher 7 Zeichen gelesen hat, ist es möglich, die Offsets **0** bis **6** umzuwandeln, jedoch nichts darüber hinaus. Dies zeigt auch, dass es nicht möglich ist, Offsets zu konvertieren, die sich auf Stellen vor dem Beginn des Datenstroms beziehen.

    Dieses Dienstprogramm ermöglicht es übergeordneten Ebenen, die im Fehlerstatus und im AST gefundenen Positions-Offsets in besser lesbare Daten umzuwandeln.

**::grammar::me::cpu::core** **tok** *state* ?*from* ?*to*??
: Diese Methode übernimmt den Wert des Status einer virtuellen ME-Maschine und gibt eine Tcl-Liste zurück, die den Teil des Eingabestroms zwischen den Positionen *from* und *to* (beide inklusive) enthält. Wird *to* nicht festgelegt, wird standardmäßig der Wert von *from* verwendet. Wird *from* ebenfalls nicht festgelegt, wird der gesamte Eingabestrom zurückgegeben.

    Diese Methode unterliegt hinsichtlich ihrer Positionsargumente denselben Einschränkungen wie die Methode **lc**.

**::grammar::me::cpu::core** **pc** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den aktuellen Wert des gespeicherten Programmzählers zurück.

**::grammar::me::cpu::core** **iseof** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den aktuellen Wert des gespeicherten EOF-Flags zurück.

**::grammar::me::cpu::core** **at** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt die aktuelle Position im Eingabestrom zurück.

**::grammar::me::cpu::core** **cc** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt das aktuelle Token zurück.

**::grammar::me::cpu::core** **sv** *state*
: Diese Methode ruft den Statuswert einer virtuellen ME-Maschine ab und gibt den darin gespeicherten aktuellen semantischen Wert zurück. Dabei handelt es sich um einen abstrakten Syntaxbaum, wie er im Dokument **grammar::me\_ast**, Abschnitt **AST-WERTE**, festgelegt ist.

**::grammar::me::cpu::core** **ok** *state*
: Diese Methode ruft den Wert einer virtuellen ME-Maschine ab und gibt den darin gespeicherten Abgleichstatus zurück.

**::grammar::me::cpu::core** **error** *state*
: Diese Methode ruft den Wert der virtuellen ME-Maschine ab und gibt den darin gespeicherten aktuellen Fehlerstatus zurück.

**::grammar::me::cpu::core** **lstk** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den Positionsstapel zurück.

**::grammar::me::cpu::core** **astk** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den AST-Stack zurück.

**::grammar::me::cpu::core** **mstk** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den AST-Marker-Stack zurück.

**::grammar::me::cpu::core** **estk** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den Fehlerstapel zurück.

**::grammar::me::cpu::core** **rstk** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den Rückgabestapel der Unterroutine zurück.

**::grammar::me::cpu::core** **nc** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den Cache für Nichtterminal-Übereinstimmungen als Dictionary zurück.

**::grammar::me::cpu::core** **ast** *state*
: Diese Methode ruft den Wert einer virtuellen ME-Maschine ab und gibt den abstrakten Syntaxbaum zurück, der sich derzeit an der Spitze des darin gespeicherten AST-Stapels befindet. Dabei handelt es sich um einen abstrakten Syntaxbaum gemäß der Spezifikation im Dokument **grammar::me\_ast**, Abschnitt **AST-WERTE**.

**::grammar::me::cpu::core** **halted** *state*
: Diese Methode ruft den Wert einer virtuellen ME-Maschine ab und gibt den darin gespeicherten aktuellen Haltezustand zurück, d. h., ob die Maschine angehalten wurde oder nicht.

**::grammar::me::cpu::core** **code** *state*
: Diese Methode übernimmt den Wert der Status-Eigenschaft einer virtuellen ME-Maschine und gibt den darin gespeicherten Code zurück, d. h. die von der Maschine ausgeführten Befehle.

**::grammar::me::cpu::core** **eof** *statevar*
: Diese Methode übernimmt den Wert des Status einer virtuellen ME-Maschine, wie er in der durch *statevar* bezeichneten Variable gespeichert ist, und ändert ihn so, dass das darin enthaltene EOF-Flag gesetzt wird. Dies signalisiert der Maschine, dass die in der Eingabewarteschlange befindlichen Token die letzten sind, die verarbeitet werden. Es werden keine weiteren mehr folgen.

**::grammar::me::cpu::core** **put** *statevar* *tok* *lex* *line* *col*
: Diese Methode übernimmt den Wert einer virtuellen ME-Maschine, wie er in der durch *statevar* benannten Variable gespeichert ist, und modifiziert ihn so, dass das Token *tok* am Ende der Eingabewarteschlange angehängt wird, zusammen mit den zugehörigen Lexemdaten *lex* und den Zeilen- und Spaltenangaben *line*/*col*umn.

    Der Vorgang schlägt mit einer Fehlermeldung fehl, wenn das EOF-Flag der Maschine über die Methode **eof** gesetzt wurde.

**::grammar::me::cpu::core** **run** *statevar* ?*n*?
: Bei dieser Methode wird der Wert des Zustands einer virtuellen ME-Maschine, wie er in der durch *statevar* bezeichneten Variable gespeichert ist, übernommen, es wird eine Reihe von Befehlen ausgeführt und der durch diese Änderungen entstandene Zustand wird wieder in der Variable gespeichert.

    Die Ausführungsschleife läuft so lange, bis entweder

    - *n* Anweisungen wurden ausgeführt, oder

    - ein Haltebefehl ausgeführt wurde oder

    - Die Eingabewarteschlange ist leer und der Code fordert weitere Token zur Verarbeitung an.


    Wenn kein Grenzwert *n* festgelegt wurde, werden nur die letzten beiden Bedingungen geprüft.


## Darstellung des Match-Programms

Ein Match-Programm wird durch eine verschachtelte Tcl-Liste dargestellt. Das erste Element, *asm*, ist eine Liste von Ganzzahlen, die die auszuführenden Befehle und deren Argumente enthalten. Das zweite Element, *pool*, ist eine Liste von Zeichenketten, auf die in den Befehlen verwiesen wird und die Fehlermeldungen, Token-Namen usw. enthalten. Das dritte Element, *tokmap*, enthält Informationen zur Reihenfolge der Token und ordnet deren Namen ihren numerischen Rängen zu. Dieses Element kann leer sein, wodurch beim Abgleich von Bereichen ein lexikografischer Vergleich erzwungen wird.

Alle ME-Befehle werden als Ganzzahlen kodiert, wobei die Zuordnung wie unten angegeben erfolgt. Einigen Befehlen – nämlich jenen, die Fehlermeldungen verarbeiten – wurde ein zusätzliches Argument zugewiesen, um diese Meldung explizit anzugeben, anstatt sie aus Token-Namen usw. zu konstruieren. Dadurch kann der Maschinenzustand statt der vollständigen Zeichenfolgen lediglich die Meldungs-IDs speichern.

Argumente für Sprungziele sind absolute Indizes innerhalb des *asm*-Elements, die sich auf den Befehl beziehen, zu dem gesprungen werden soll. Alle Zeichenfolgenargumente sind absolute Indizes innerhalb des *pool*-Elements. Zu suchende Token, Zeichen, Meldungen und Token- (bzw. Zeichen-)Klassen werden ebenfalls als Verweise auf das *pool*-Element kodiert.

1. "**ict\_advance** *message*"

2. "**ict\_match\_token** *tok* *message*"

3. "**ict\_match\_tokrange** *tokbegin* *tokend* *message*"

4. "**ict\_match\_tokclass** *code* *message*"

5. "**inc\_restore** *branchlabel* *nt*"

6. "**inc\_save** *nt*"

7. "**icf\_ntcall** *branchlabel*"

8. "**icf\_ntreturn**"

9. "**iok\_ok**"

10. "**iok\_fail**"

11. "**iok\_negate**"

12. "**icf\_jalways** *branchlabel*"

13. "**icf\_jok** *branchlabel*"

14. "**icf\_jfail** *branchlabel*"

15. "**icf\_halt**"

16. "**icl\_push**"

17. "**icl\_rewind**"

18. "**icl\_pop**"

19. "**ier\_push**"

20. "**ier\_clear**"

21. "**ier\_nonterminal** *message*"

22. "**ier\_merge**"

23. "**isv\_clear**"

24. "**isv\_terminal**"

25. "**isv\_nonterminal\_leaf** *nt*"

26. "**isv\_nonterminal\_range** *nt*"

27. "**isv\_nonterminal\_reduce** *nt*"

28. "**ias\_push**"

29. "**ias\_mark**"

30. "**ias\_mrewind**"

31. "**ias\_mpop**"


# CPU-Zustand

Ein Wert ist eine Liste, die die folgenden Elemente in der unten angegebenen Reihenfolge enthält:

1. *code*: Match-Anweisungen, siehe [Darstellung des Match-Programms].

2. *pc*:   Programmzähler, *int*.

3. *halt*: Halte-Flag, *boolean*.

4. *eof*: Eof-Flag, *boolean*

5. *tc*:   Terminal-Cache und Eingabewarteschlange. Aufbau siehe unten.

6. *cl*:   Aktuelle Position, *int*.

7. *ct*:   Aktuelles Token, *string*.

8. *ok*:   Übereinstimmungsstatus, *boolean*.

9. *sv*:   Semantischer Wert, *list*.

10. *er*: Fehler-Status, *list*.

11. *ls*:   Positionsstapel, *list*.

12. *as*:   AST-Stack, *list*.

13. *ms*:   AST-Marker-Stack, *list*.

14. *es*:   Fehlerstapel, *list*.

15. *rs*:   Rückgabestapel, *list*.

16. *nc*: Nichtterminal-Cache, *dictionary*.


*tc*, die Eingabewarteschlange mit den zur Verarbeitung anstehenden Tokens und der terminale Cache, der die bereits verarbeiteten Tokens enthält, bilden eine einheitliche Datenstruktur, die lediglich alle Tokens und deren Informationen enthält, wobei die aktuelle Position die bereits verarbeiteten Elemente von den noch anstehenden trennt. Jedes Element der Warteschlange/des Caches ist eine Liste, die das Token, dessen Lexem-Informationen, die Zeilennummer und den Index der Spalten in dieser Reihenfolge enthält.

Bei allen Stacks befindet sich das oberste Element am Ende; das Einfügen eines Elements entspricht also dem Anhängen an die Liste, die den Stack darstellt, und das Entfernen eines Elements entfernt das letzte Element.

*er*: Der Fehlerstatus ist entweder leer oder eine Liste mit zwei Elementen – einer Position in der Eingabe und einer Liste von Meldungen, die als Verweise auf das *pool*-Element des *code* kodiert sind.

*nc*: Der Nichtterminal-Cache ist nach Nichtterminal-Name und Position indiziert; jeder Wert ist eine Liste mit vier Elementen, die die aktuelle Position, den Übereinstimmungsstatus, den semantischen Wert und den Fehlerstatus in dieser Reihenfolge enthält.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *grammar\_me* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Grammatiken und endliche Automaten

# Copyright

```
Copyright (c) 2005-2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[me_ast]: me_ast.md
[me_intro]: me_intro.md
