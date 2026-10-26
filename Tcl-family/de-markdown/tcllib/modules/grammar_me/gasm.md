---
CommandName: grammar::me::cpu::gasm
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - assembler
 - grammar
 - graph
 - parsing
 - tree
 - virtual machine
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

grammar::me::cpu::gasm – ME-Assembler

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [grammar::me::cpu::gasm]{.lit} [0.2]{.optlit} 
[::grammar::me::cpu::gasm::begin]{.cmd} [g]{.arg} [n]{.arg} [mode]{.optarg} [note]{.optarg} 
[::grammar::me::cpu::gasm::done]{.cmd} [-->]{.sub} [t]{.arg} 
[::grammar::me::cpu::gasm::state]{.cmd} 
[::grammar::me::cpu::gasm::state!]{.cmd} [s]{.arg} 
[::grammar::me::cpu::gasm::lift]{.cmd} [t]{.arg} [dst]{.arg} [=]{.lit} [src]{.arg} 
[::grammar::me::cpu::gasm::Inline]{.cmd} [t]{.arg} [node]{.arg} [label]{.arg} 
[::grammar::me::cpu::gasm::Cmd]{.cmd} [cmd]{.arg} [arg]{.optdot} 
[::grammar::me::cpu::gasm::Bra]{.cmd} 
[::grammar::me::cpu::gasm::Nop]{.cmd} [text]{.arg} 
[::grammar::me::cpu::gasm::Note]{.cmd} [text]{.arg} 
[::grammar::me::cpu::gasm::Jmp]{.cmd} [label]{.arg} 
[::grammar::me::cpu::gasm::Exit]{.cmd} 
[::grammar::me::cpu::gasm::Who]{.cmd} [label]{.arg} 
[::grammar::me::cpu::gasm::/Label]{.cmd} [name]{.arg} 
[::grammar::me::cpu::gasm::/Clear]{.cmd} 
[::grammar::me::cpu::gasm::/Ok]{.cmd} 
[::grammar::me::cpu::gasm::/Fail]{.cmd} 
[::grammar::me::cpu::gasm::/At]{.cmd} [name]{.arg} 
[::grammar::me::cpu::gasm::/CloseLoop]{.cmd} 
:::

# BESCHREIBUNG

Dieses Paket stellt einen einfachen In-Memory-Assembler bereit. Es entstand ursprünglich als Unterstützungspaket für Pakete, die PEG- und andere Grammatiken in einen entsprechenden Matcher auf Basis der virtuellen ME-Maschine konvertieren, wie beispielsweise **page::compiler::peg::mecpu**. Obwohl es hinsichtlich der Befehle weitgehend agnostisch ist, können Anwender jeden beliebigen Befehlssatz wählen.

Das in der Erstellung befindliche Programm wird während der Assemblierung und der anschließenden Bearbeitung in einer Graphstruktur gespeichert (siehe Paket **struct::graph**), wobei Anweisungen durch Knoten dargestellt werden und der Ausführungsablauf zwischen den Anweisungen explizit in den Kanten zwischen diesen kodiert ist.

In diesem Modell erfolgt die Kodierung von Sprüngen nicht explizit, sondern sie ist implizit in den Bögen enthalten. Die Generierung expliziter Sprünge wird einem beliebigen Code überlassen, der die Graphstruktur in eine konventionellere Darstellung umwandelt. Das Gleiche gilt für Verzweigungen. Sie werden implizit durch alle Anweisungen kodiert, die zwei ausgehende Bögen aufweisen, während alle anderen Anweisungen nur einen ausgehenden Bogen haben. Ihre Bedingtheit wird dadurch gewährleistet, dass ihre ausgehenden Bögen mit Tags über die Bedingungen versehen werden, unter denen sie ausgeführt werden.

Zwar wird die Grafik, auf der der Assembler arbeitet, von außen bereitgestellt, d. h. sie ist extern, doch verwaltet er einen gewissen internen Zustand, und zwar:

**\[1\]**
: Der Handle des Graphenknotens, auf den die meisten Assembler-Operationen angewendet werden können: der *anchor*.

**\[2\]**
: Eine Zuordnung beliebiger Zeichenketten auf Befehle. Ein Befehl lässt sich während der Assemblierung *label* und später über dieses Label wieder abrufen.

**\[3\]**
: Der beim Erstellen von Sprüngen zwischen Anweisungen zu verwendende Statuscode, der einer der folgenden Werte sein kann: **always**, **ok** oder **fail**.

**\[4\]**
: Der aktuelle Betriebsmodus: entweder **halt**, **okfail** oder **!okfail**.

**\[5\]**
: Der Name eines Knotens in einem Baum. Dieser sowie der oben genannte Betriebsmodus sind die Komponenten, die am stärksten von den Anforderungen eines Grammatik-Compilers beeinflusst werden, da sie bestimmte grundlegende Programmstrukturen voraussetzen (die über den Betriebsmodus ausgewählt werden) und den Graphen mit einem Baum verknüpfen, wie beispielsweise dem AST für die zu kompilierende Grammatik.


# DEFINITIONEN

Da sowohl der Graph, auf dem der Assembler arbeitet, als auch der Baum, mit dem er verflochten ist, dem Assembler von außen bereitgestellt werden, ist es erforderlich, die von ihnen erwartete API festzulegen und die Strukturen zu beschreiben, die der Assembler in beiden Fällen erwartet und/oder erzeugt.

**\[1\]**
: Jeder vom Assembler verwendete Objektbefehl muss die API bereitstellen, wie sie in der Dokumentation zum Paket **struct::graph** angegeben ist.

**\[2\]**
: Jeder vom Assembler verwendete Objektbefehl für Baumobjekte muss die API bereitstellen, wie sie in der Dokumentation zum Paket **struct::tree** angegeben ist.

**\[3\]**
: Jede vom Assembler in einem Graphen erzeugte Anweisung (Knoten) verfügt über mindestens zwei und höchstens drei Attribute:


**instruction**
: Der Wert dieses Attributs ist der Name des Befehls. Die einzigen Namen, die derzeit vom Assembler definiert sind, sind die drei Pseudobefehle


**NOP**
: Diese Anweisung hat keine Auswirkung. Nützlich für feste Rahmen-Knoten, unveränderliche Sprungziele und Ähnliches. Keine Argumente.

**C**
: Ein .NOP, der das Einfügen beliebiger Kommentare in den Befehlsstrom ermöglicht, d. h. ein Kommentarknoten. Ein Argument: der Text des Kommentars.

**BRA**
: Ein .NOP, der als explizit codierter bedingter Sprung dient. Keine Argumente.


: Wir behalten uns jedoch den Speicherplatz aller Befehle vor, deren Namen mit einem „.“ (Punkt) beginnen, für eine zukünftige Verwendung durch den Assembler.


**arguments**
: Der Wert dieses Attributs ist eine Liste von Zeichenketten, bei denen es sich um die Argumente des Befehls handelt. Der Inhalt hängt vom jeweiligen Befehl ab, und der Assembler kennt diese Argumente nicht und berücksichtigt sie auch nicht. Das bedeutet beispielsweise, dass er kein integriertes Wissen darüber besitzt, welcher Befehl welche Argumente benötigt, und daher keinerlei Überprüfung durchführt.

**expr**
: Dieses Attribut ist optional. Wenn es vorhanden ist, entspricht sein Wert dem Namen eines Knotens in der Baumstruktur, die mit dem Graphen verflochten ist.


**\[4\]**
: Jeder Bogen zwischen zwei Befehlen weist ein Attribut auf:


**condition**
: Der Wert dieses Attributs legt fest, unter welcher Bedingung die Ausführung diesen Bogen nimmt. Mögliche Werte sind **always**, **ok** und **fail**. Die erste Bedingung gilt für alle Bögen, die den einzigen ausgehenden Bogen einer Anweisung bilden. Die beiden anderen gelten für die beiden ausgehenden Bögen einer Anweisung, die implizit eine Verzweigung kodieren.


**\[5\]**
: Ein Baumknoten, der dem Assembler zur Querverweisung übergeben wird, wird beschrieben und erhält die folgenden Attribute, von denen einige fest vorgegeben sind, andere hingegen vom Betriebsmodus abhängen. Alle Werte stellen Verweise auf Knoten im Befehlsgraphen dar. Einige Befehle erwarten bestimmte oder spezifische Kombinationen dieser Attribute.


**gas::entry**
: Immer geschrieben.

**gas::exit**
: Gilt für alle Modi mit Ausnahme von **okfail**.

**gas::exit::ok**
: Verfasst für den Modus **okfail**.

**gas::exit::fail**
: Verfasst für den Modus **okfail**.


# API

**::grammar::me::cpu::gasm::begin** *g* *n* ?*mode*? ?*note*?
: Dieser Befehl startet die Assemblierung einer Befehlsfolge und (re-)initialisiert den Zustand des Assemblers. Nach Abschluss der Befehlsfolge verwenden Sie bitte **::grammar::me::cpu::gasm::done**, um den Assembler abzuschließen. Er arbeitet mit dem Graphen *g* im angegebenen *Modus* (Standard ist **okfail**). Im Rahmen der Initialisierung wird stets ein Standard-NOP-Befehl erstellt und mit dem Label „entry“ versehen. Die Erstellung der übrigen Standardbefehle erfolgt gemäß *mode*-dependent:


**halt**
: Eine „icf_halt“-Anweisung mit der Bezeichnung „exit/return“.

**!okfail**
: Ein „icf_ntreturn“-Befehl mit der Bezeichnung „exit/return“.

**okfail**
: Zwei .NOP-Befehle mit den Bezeichnungen „exit/ok“ bzw. „exit/fail“.


: Die *note*, wenn sie festgelegt wird (Standard ist „nicht“), wird dem „entry“-Befehl .NOP zugewiesen. Die Knotenreferenz *n* wird lediglich zur Verwendung durch **::grammar::me::cpu::gasm::done** gespeichert. Sie muss sich auf einen Knoten im Baum *t*-Argument dieses Befehls beziehen. Nach Abschluss der Initialisierung wird der Befehl „entry“ zum *anchor* und der Bedingungscode wird auf **always** gesetzt. Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.


**::grammar::me::cpu::gasm::done** **-->** *t*
: Dieser Befehl schließt die Erstellung einer Befehlsfolge ab und löscht anschließend den Status des Assemblers. *Hinweis*: Dadurch werden die erstellten Befehle *nicht* gelöscht. Sie stehen für zukünftige „begin/done“-Zyklen weiterhin zur Verfügung. Eine weitere Assemblierung ist erst nach einer Neuinitialisierung des Systems über **::grammar::me::cpu::gasm::begin** möglich. Bevor der Zustand gelöscht wird, werden ausgewählte Verweise auf ausgewählte Befehle in die Attribute des Knotens *n* im Baum *t* geschrieben. Welche Befehle gespeichert werden, hängt vom *mode* ab. Sowohl *mode* als auch der Zielknoten *n* wurden beim Aufruf von **::grammar::me::cpu::gasm::begin** festgelegt. Unabhängig vom Modus wird ein Verweis auf die Anweisung mit der Bezeichnung „entry“ im Attribut **gas::entry** von *n* gespeichert. Der Verweis auf den Knoten *n* wird zudem im Attribut „expr“ der Anweisung „entry“ gespeichert. Darüber hinaus


**halt**
: Ein Verweis auf die Anweisung mit der Bezeichnung „exit/return“ wird im Attribut **gas::exit** von *n* gespeichert.

**okfail**
: Siehe **halt**.

**!okfail**
: Der Verweis auf die beiden Anweisungen mit den Bezeichnungen „exit/ok“ und „exit/fail“ wird jeweils in den Attributen **gas::exit::ok** und **gas::exit::fail** von *n* gespeichert.


Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.

**::grammar::me::cpu::gasm::state**
: Dieser Befehl gibt den aktuellen Status des Assemblers zurück. Sein Format ist nicht dokumentiert und gilt als paketintern.

**::grammar::me::cpu::gasm::state!** *s*
: Dieser Befehl übernimmt einen serialisierten Assembler-Zustand *s*, wie er von **::grammar::me::cpu::gasm::state** gegeben wird, und macht ihn zum aktuellen Zustand des Assemblers. *Hinweis*: Dadurch können Label-Definitionen überschrieben werden. Alle nicht in Konflikt stehenden Label-Definitionen aus dem vorherigen Zustand bleiben jedoch unberührt und werden mit *s* zusammengeführt. Der Befehl gibt die leere Zeichenkette als Ergebnis zurück.

**::grammar::me::cpu::gasm::lift** *t* *dst* **=** *src*
: Dieser Befehl wirkt auf den Baum *t* ein. Er kopiert den Inhalt der Attribute **gas::entry**, **gas::exit::ok** und **gas::exit::fail** vom Knoten *src* in den Knoten *dst*. Als Ergebnis gibt es die leere Zeichenkette zurück.

**::grammar::me::cpu::gasm::Inline** *t* *node* *label*
: Dieser Befehl verknüpft eine durch ein zuvor eingegebenes „begin/done“-Paar erstellte Befehlsfolge mit der aktuellen Befehlsfolge. Zu diesem Zweck


**\[1\]**
: liest die Befehlsverweise aus den Attributen **gas::entry**, **gas::exit::ok** und **gas::exit::fail** aus dem Knoten *n* des Baums *t* aus und stellt sie dem Assembler unter den Labels *label*/entry, *label*/exit::ok bzw. *label*/exit::fail zur Verfügung.

**\[2\]**
: Erstellt einen Bogen vom *anchor* zum Knoten mit der Bezeichnung *label*/entry und versieht ihn mit dem aktuellen Bedingungscode.

**\[3\]**
: Macht den Knoten mit der Bezeichnung *label*/exit/ok zum neuen *anchor*.


: Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.


**::grammar::me::cpu::gasm::Cmd** *cmd* ?*arg*...?
: Dies ist der grundlegende Befehl zum Hinzufügen von Anweisungen zum Diagramm. Er erstellt eine neue Anweisung vom Typ *cmd* mit den angegebenen Argumenten *arg*... Wenn *anchor* definiert wurde, wird zudem unter Verwendung des aktuellen Bedingungscodes ein Bogen vom *anchor* zur neuen Anweisung erstellt. Nach dem Aufruf wird die neue Anweisung zum *anchor* und der aktuelle Bedingungscode wird auf **always** gesetzt. Der Befehl gibt die leere Zeichenkette als Ergebnis zurück.

**::grammar::me::cpu::gasm::Bra**
: Dieser Befehl dient zum Erstellen einer .BRA-Pseudo-Anweisung. Er nutzt **::grammar::me::cpu::gasm::Cmd**, um die Anweisung tatsächlich zu erstellen, und übernimmt deren Verhalten.

**::grammar::me::cpu::gasm::Nop** *text*
: Dies ist ein Komfort-Befehl zum Erstellen einer .NOP-Pseudo-Anweisung. Er nutzt **::grammar::me::cpu::gasm::Cmd**, um die Anweisung tatsächlich zu erstellen, und übernimmt deren Verhalten. Der *text* wird als erstes und einziges Argument der neuen Anweisung gespeichert.

**::grammar::me::cpu::gasm::Note** *text*
: Dies ist ein Komfort-Befehl zum Erstellen einer .C-Pseudo-Anweisung, d. h. eines Kommentars. Er nutzt **::grammar::me::cpu::gasm::Cmd**, um die Anweisung tatsächlich zu erstellen, und übernimmt deren Verhalten. Der *text* wird als erstes und einziges Argument der neuen Anweisung gespeichert.

**::grammar::me::cpu::gasm::Jmp** *label*
: Dieser Befehl erstellt einen Bogen vom *anchor* zur mit *label* gekennzeichneten Anweisung und versieht diese mit dem aktuellen Bedingungscode. Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.

**::grammar::me::cpu::gasm::Exit**
: Dieser Befehl erstellt je nach Betriebsmodus (siehe **::grammar::me::cpu::gasm::begin**) einen Bogen vom *anchor* zu einer der Exit-Anweisungen und versieht diesen mit dem aktuellen Bedingungscode. Im Modus **okfail** wird je nach aktuellem Bedingungscode eine Verknüpfung zu der Anweisung „exit/ok“ oder „exit/fail“ hergestellt und diese mit dem aktuellen Bedingungscode versehen. In den beiden anderen Modi wird eine Verknüpfung zu der Anweisung „exit/return“ hergestellt, und versieht diesen Befehl **always** mit dem Bedingungscode, unabhängig vom aktuellen Bedingungscode. Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.

**::grammar::me::cpu::gasm::Who** *label*
: Dieser Befehl gibt eine Referenz auf die mit *label* gekennzeichnete Anweisung zurück.

**::grammar::me::cpu::gasm::/Label** *name*
: Dieser Befehl versieht den *anchor* mit der Bezeichnung *name*. *Hinweis*: Eine Anweisung kann mehr als eine Bezeichnung haben. Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.

**::grammar::me::cpu::gasm::/Clear**
: Dieser Befehl löscht den *anchor*, sodass dieser nicht mehr definiert ist, und setzt zudem den aktuellen Bedingungscode auf **always** zurück. Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.

**::grammar::me::cpu::gasm::/Ok**
: Dieser Befehl setzt den aktuellen Bedingungscode auf **ok**. Der Befehl gibt als Ergebnis eine leere Zeichenkette zurück.

**::grammar::me::cpu::gasm::/Fail**
: Dieser Befehl setzt den aktuellen Bedingungscode auf **fail**. Der Befehl gibt als Ergebnis eine leere Zeichenkette zurück.

**::grammar::me::cpu::gasm::/At** *name*
: Dieser Befehl setzt den *anchor* auf die mit *name* bezeichnete Anweisung und setzt zudem den aktuellen Bedingungscode auf **always** zurück. Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.

**::grammar::me::cpu::gasm::/CloseLoop**
: Dieser Befehl kennzeichnet den *anchor* als letzte Anweisung im Schleifenrumpf, indem er das Attribut **LOOP** erstellt. Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.


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
