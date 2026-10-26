---
CommandName: grammar::me::cpu
title: grammar::me::cpu
ManualSection: n
Version: 0.3
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

grammar::me::cpu – Implementierung einer virtuellen Maschine II zur Analyse von Token-Strömen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [grammar::me::cpu]{.lit} [0.3]{.optlit}
[::grammar::me::cpu]{.cmd} [meName]{.arg} [matchcode]{.arg}
[meName]{.cmd} [option]{.lit} [arg arg]{.optdot}
[meName]{.ins} [lc]{.sub} [location]{.arg}
[meName]{.ins} [tok]{.sub} [from ?to]{.optarg}
[meName]{.ins} [pc]{.sub} [state]{.arg}
[meName]{.ins} [iseof]{.sub} [state]{.arg}
[meName]{.ins} [at]{.sub} [state]{.arg}
[meName]{.ins} [cc]{.sub} [state]{.arg}
[meName]{.ins} [sv]{.sub}
[meName]{.ins} [ok]{.sub}
[meName]{.ins} [error]{.sub}
[meName]{.ins} [lstk]{.sub} [state]{.arg}
[meName]{.ins} [astk]{.sub} [state]{.arg}
[meName]{.ins} [mstk]{.sub} [state]{.arg}
[meName]{.ins} [estk]{.sub} [state]{.arg}
[meName]{.ins} [rstk]{.sub} [state]{.arg}
[meName]{.ins} [nc]{.sub} [state]{.arg}
[meName]{.ins} [ast]{.sub}
[meName]{.ins} [halted]{.sub}
[meName]{.ins} [code]{.sub}
[meName]{.ins} [eof]{.sub}
[meName]{.ins} [put]{.sub} [tok]{.arg} [lex]{.arg} [line]{.arg} [col]{.arg}
[meName]{.ins} [putstring]{.sub} [string]{.arg} [lvar]{.arg} [cvar]{.arg}
[meName]{.ins} [run]{.sub} [n]{.optarg}
[meName]{.ins} [pull]{.sub} [nextcmd]{.arg}
[meName]{.ins} [reset]{.sub}
[meName]{.ins} [destroy]{.sub}
:::

# Beschreibung

Dieses Paket enthält eine Implementierung der virtuellen ME-Maschine. Bitte lesen Sie zunächst das Dokument **grammar::me\_intro**, falls Sie nicht wissen, was eine virtuelle ME-Maschine ist.

Diese Implementierung bietet eine objektbasierte API, und die Maschinen sind nicht wirklich an Tcl gebunden. Eine C-Implementierung derselben API ist durchaus möglich.

Intern nutzt das Paket zur Erfüllung seiner Aufgaben tatsächlich die wertbasierten Befehle zur Maschinenmanipulation, wie sie vom Paket **grammar::me::cpu::core** bereitgestellt werden.

# API

## API für Klassen

Das Paket stellt direkt nur einen einzigen Befehl für die Erstellung von virtuellen ME-Maschinen bereit.

**::grammar::me::cpu** *meName* *matchcode*
: Der Befehl erstellt ein neues ME-Maschinenobjekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *meName* lautet. Mit diesem Befehl können verschiedene Operationen auf der Maschine aufgerufen werden. Er hat die folgende allgemeine Form:

    **meName** **option** ?*arg arg ...*?
    : *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls.


    Das Argument *matchcode* enthält die Abgleichanweisungen, die die Maschine beim Parsen des Eingabestroms ausführen muss. Bitte lesen Sie den Abschnitt **Darstellung des Match-Programms** der Dokumentation zum Paket **grammar::me::cpu::core**, um die Struktur dieses Werts zu erfahren.

    Das Argument *tokmap*, das von der durch das Paket **grammar::me::tcl** bereitgestellten Implementierung verwendet wird, ist hier in den Match-Anweisungen verborgen und wird daher nicht benötigt.


## Objekt-API

Alle Objekte virtueller Maschinen vom Typ „ME“, die mit dem im Abschnitt [API für Klassen] angegebenen Klassenbefehl erstellt wurden, unterstützen die unten aufgeführten Methoden.

Die in diesem Paket enthaltenen Maschinen bieten Methoden für den Betrieb sowohl im Push- als auch im Pull-Style. „Push“-Modus bedeutet, dass Tokens bei ihrem Eintreffen in den Maschinenzustand geschoben werden und dort die weitere Ausführung auslösen, bis sie verbraucht sind. Mit anderen Worten: Dies ermöglicht es, die Maschine nach Belieben und beliebig oft anzuhalten und wieder aufzunehmen, den quasi-parallelen Betrieb mehrerer Maschinen sowie den Betrieb als Teil der Ereignisschleife.

*meName* **lc** *location*
: Diese Methode wandelt die Position eines Tokens, das als Offset im Eingabestrom angegeben wird, in die zugehörige Zeilennummer und den Spaltenindex um. Das Ergebnis des Befehls ist eine Liste mit zwei Elementen, die diese beiden Werte in der im vorigen Satz genannten Reihenfolge enthält. Dies ermöglicht es übergeordneten Ebenen, die im Fehlerstatus und im generierten AST enthaltenen Positionsinformationen in besser lesbare Daten umzuwandeln.

    *Hinweis*: Der Befehl kann keine Positionen umwandeln, die von der Maschine noch nicht erreicht wurden. Mit anderen Worten: Wenn die Maschine 7 Token gelesen hat, kann der Befehl die Offsets **0** bis **6** umwandeln, jedoch nichts darüber hinaus. Dies zeigt auch, dass es nicht möglich ist, Offsets zu konvertieren, die sich auf Positionen vor dem Beginn des Stroms beziehen.

*meName* **tok** ?*from* ?*to*??
: Diese Methode gibt eine Tcl-Liste zurück, die den Teil des Eingabestroms zwischen den Positionen *from* und *to* (beide inklusive) enthält. Wenn *to* nicht festgelegt wird, wird standardmäßig der Wert von *from* verwendet. Wenn *from* ebenfalls nicht festgelegt wird, wird der gesamte Eingabestrom zurückgegeben.

    Jedes Element der zurückgegebenen Liste ist eine Liste aus vier Elementen: dem Token, dem zugehörigen Lexem, der Zeilennummer und dem Spaltenindex, in dieser Reihenfolge. Dieser Befehl unterliegt hinsichtlich seiner Positionsargumente denselben Einschränkungen wie die Methode **lc**.

*meName* **pc** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den aktuellen Wert des gespeicherten Programmzählers zurück.

*meName* **iseof** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den aktuellen Wert des gespeicherten EOF-Flags zurück.

*meName* **at** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt die aktuelle Position im Eingabestrom zurück.

*meName* **cc** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt das aktuelle Token zurück.

*meName* **sv**
: Dieser Befehl gibt den aktuellen semantischen Wert *SV* zurück, der in der Maschine gespeichert ist. Dabei handelt es sich um einen abstrakten Syntaxbaum, wie er im Dokument **grammar::me\_ast**, Abschnitt **AST-WERTE**, beschrieben ist.

*meName* **ok**
: Diese Methode gibt den aktuellen Match-Status *OK* zurück.

*meName* **error**
: Diese Methode gibt den aktuellen Fehlerstatus *ER* zurück.

*meName* **lstk** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den Positionsstapel zurück.

*meName* **astk** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den AST-Stack zurück.

*meName* **mstk** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den AST-Marker-Stack zurück.

*meName* **estk** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den Fehlerstapel zurück.

*meName* **rstk** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den Rückgabestapel der Unterroutine zurück.

*meName* **nc** *state*
: Diese Methode nimmt den Statuswert einer virtuellen ME-Maschine entgegen und gibt den Cache für Nichtterminal-Übereinstimmungen als Dictionary zurück.

*meName* **ast**
: Diese Methode gibt den aktuellen obersten Eintrag des AST-Stapels *AS* zurück. Dabei handelt es sich um einen abstrakten Syntaxbaum, wie er im Dokument **grammar::me\_ast**, Abschnitt **AST-WERTE**, festgelegt ist.

*meName* **halted**
: Diese Methode gibt einen booleschen Wert zurück, der dem Aufrufer mitteilt, ob die Engine die Ausführung angehalten hat oder nicht. „Halt“ bedeutet, dass kein weiterer Abgleich mehr möglich ist und die über die andere Methode abgerufenen Informationen endgültig sind. Versuche, die Maschine mit **run** auszuführen, werden ignoriert, bis ein **reset** erfolgt.

*meName* **code**
: Diese Methode gibt die *code*-Information zurück, mit der das Objekt erzeugt wurde. Mit anderen Worten das Match-Programm, das die Maschine ausführt.

*meName* **eof**
: Diese Methode fügt am Ende des Eingabestroms eine Dateiende-Markierung ein. Dies signalisiert der Maschine, dass der aktuelle Inhalt der Eingabewarteschlange den letzten Teil der Eingabe darstellt und nichts mehr folgen wird. Versuche, weitere Zeichen in die Warteschlange einzufügen, schlagen fehl.

*meName* **put** *tok* *lex* *line* *col*
: Diese Methode fügt das Token *tok* am Ende des Eingabestroms hinzu, zusammen mit den zugehörigen Lexemdaten *lex* und den Zeilen- und Spaltenangaben *line* und *col*.

*meName* **putstring** *string* *lvar* *cvar*
: Bei dieser Methode wird jedes einzelne Zeichen der *string* als Token vom ersten bis zum letzten Zeichen an das Ende des Eingabestroms angehängt. Die Lexeme sind leer, und die Zeilen- und Spaltenangaben werden auf der Grundlage der gefundenen Zeichen sowie der Daten in den Variablen *lvar* und *cvar* berechnet.

*meName* **run** ?*n*?
: Diese Methode bewirkt, dass die Maschine Abgleichanweisungen ausführt, bis entweder

    - *n* Anweisungen wurden ausgeführt, oder

    - ein Haltebefehl ausgeführt wurde oder

    - Die Eingabewarteschlange ist leer und der Code fordert weitere Token zur Verarbeitung an.


    Wenn kein Grenzwert *n* festgelegt wurde, werden nur die letzten beiden Bedingungen geprüft.

*meName* **pull** *nextcmd*
: Diese Methode implementiert den Pull-Betrieb der Maschine. Sie bewirkt, dass die Maschine Match-Anweisungen ausführt, bis entweder eine Stoppanweisung erreicht wird oder das Befehlspräfix *nextcmd* keine weiteren Token mehr liefert.

    Das Befehlspräfix *nextcmd* repräsentiert den Eingabestrom aus Zeichen und wird von der Maschine immer dann aufgerufen, wenn ein neues Zeichen aus dem Strom benötigt wird. Die Anweisung zur Handhabung hierfür lautet *ict\_advance*. Die Rückruffunktion muss entweder die leere Liste oder eine Liste mit vier Elementen zurückgeben, die das Token, dessen Lexem-Attribut sowie dessen Position als Zeilennummer und Spalten-Index in dieser Reihenfolge enthalten. Die leere Liste signalisiert, dass das Ende des Eingabestroms erreicht wurde. Das Lexem-Attribut wird im Terminal-Cache gespeichert, von der Maschine jedoch ansonsten nicht verwendet.

    Das Ende des Eingabestroms für diese Methode bedeutet nicht, dass die Methode **eof** für die Maschine als Ganzes aufgerufen wird. Indem dies vermieden wird und dennoch ein expliziter Aufruf der Methode verlangt wird, ist es möglich, während der Lebensdauer der Maschine Operationen im Push- und Pull-Stil zu kombinieren.

*meName* **reset**
: Diese Methode setzt die Maschine in ihren Ausgangszustand zurück und löscht dabei jeglichen bisherigen Zustand.

*meName* **destroy**
: Diese Methode löscht das Objekt und gibt alle von ihm belegten Ressourcen frei.


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
