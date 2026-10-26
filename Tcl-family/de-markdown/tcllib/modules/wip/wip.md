---
CommandName: wip
ManualSection: n
Version: 2.3
TclPart: tcllib
TclDescription: Word Interpreter
Keywords:
 - interpreter
 - list
 - word
Copyright:
 - Copyright (c) 2007-2010 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

wip – Wort-Interpreter

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [wip]{.lit} [2.3]{.optlit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.4]{.optlit} 
[package]{.cmd} [require]{.sub} [struct::set]{.lit} 
[::wip]{.cmd} [wipName]{.arg} [engine]{.arg} [arg...]{.arg} 
[def]{.cmd} [name]{.arg} 
[def]{.cmd} [name]{.arg} [method_prefix]{.arg} 
[wipName]{.cmd} [option]{.arg} [arg arg]{.optdot} 
[wip::dsl]{.cmd} [suffix]{.optarg} 
[wipName]{.ins} [def]{.sub} [name]{.arg} [method_prefix]{.optarg} 
[wipName]{.ins} [defl]{.sub} [names]{.arg} 
[wipName]{.ins} [defd]{.sub} [dict]{.arg} 
[wipName]{.ins} [deflva]{.sub} [name...]{.arg} 
[wipName]{.ins} [defdva]{.sub} (name [method_prefix)...]{.arg} 
[wipName]{.ins} [undefl]{.sub} [names]{.arg} 
[wipName]{.ins} [undefva]{.sub} [name...]{.arg} 
[wipName]{.ins} [unknown]{.sub} [cmdprefix]{.arg} 
[wipName]{.ins} [runl]{.sub} [wordlist]{.arg} 
[wipName]{.ins} [run]{.sub} [word...]{.arg} 
[wipName]{.ins} [run_next]{.sub} 
[wipName]{.ins} [run_next_while]{.sub} [acceptable]{.arg} 
[wipName]{.ins} [run_next_until]{.sub} [rejected]{.arg} 
[wipName]{.ins} [run_next_if]{.sub} [acceptable]{.arg} 
[wipName]{.ins} [run_next_ifnot]{.sub} [rejected]{.arg} 
[wipName]{.ins} [next]{.sub} 
[wipName]{.ins} [peek]{.sub} 
[wipName]{.ins} [peekall]{.sub} 
[wipName]{.ins} [insertl]{.sub} [at]{.arg} [wordlist]{.arg} 
[wipName]{.ins} [replacel]{.sub} [wordlist]{.arg} 
[wipName]{.ins} [pushl]{.sub} [wordlist]{.arg} 
[wipName]{.ins} [addl]{.sub} [wordlist]{.arg} 
[wipName]{.ins} [insert]{.sub} [at]{.arg} [word...]{.arg} 
[wipName]{.ins} [replace]{.sub} [word...]{.arg} 
[wipName]{.ins} [push]{.sub} [word...]{.arg} 
[wipName]{.ins} [add]{.sub} [word...]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt einen Mikro-Interpreter für Listen von Wörtern bereit. Darauf aufbauende domänenspezifische Sprachen haben ein wenig ein Forth-Gefühl, wobei der Eingabestrom in Wörter zerlegt wird und jede weitere Strukturierung der jeweiligen Sprache überlassen bleibt. Im Wesentlichen liegt hier nur die zentrale Dispatch-Schleife vor und keinerlei tatsächliche Befehle, sodass es sich nur um ein Forth-Gefühl handelt und nicht um ein echtes Forth.

Die Idee basiert auf dem Prozessor „**treeql**“ von Colin McCormack, der so modifiziert wurde, dass er weniger Standardcode in den Implementierungen der Befehle erfordert – was jedoch wahrscheinlich zu Lasten der Ausführungsgeschwindigkeit geht. Zudem ist auch die Schnittstelle zwischen Prozessorkern und Befehlen komplexer.

# ALLGEMEINES VERHALTEN

Wortinterpreter verfügen über eine Zuordnung zwischen den Namen der Sprachbefehle, die sie erkennen sollen, und den Methoden in der engine, die dafür aufgerufen werden sollen, sowie gegebenenfalls über feste Argumente für diese Methoden. Diese Zuordnung ist weitgehend statisch; es ist jedoch möglich, sie während der Ausführung einer Wortliste (= Programm) zu ändern.

Zum Zeitpunkt der Definition eines Sprachbefehls nutzt der Wort-Interpreter die Introspektionsfunktionen von **snit**, um die Anzahl der Argumente zu ermitteln, die von der Methode der *engine* erwartet werden, und zusammen mit der Anzahl der festen Argumente, die im Methodenpräfix der Zuordnung angegeben sind, ist dann bekannt, wie viele Argumente der Sprachbefehl erwartet. Dies ist die *Arität* des Befehls. Methoden mit variabler Argumentanzahl (d. h. mit dem letzten Argument namens *args*) sind *nicht* zulässig und führen dazu, dass der Wort-Interpreter bereits bei der Definition einen Fehler auslöst.

Die Fähigkeiten von **snit** wurden genannt; das *engine*-Objekt kann jedoch auf beliebige Weise geschrieben sein, solange es die Methode **info args** versteht, die einen Methodennamen entgegennimmt und die Liste der Argumente dieser Methode zurückgibt.

Bei der Ausführung einer Wortliste (auch Programm genannt) wird das erste Wort stets als Name eines Sprachbefehls genommen, die folgenden Wörter als dessen Argumente, entsprechend der *Arität* des Befehls. Befehls- und Argumentwörter werden aus der Liste entfernt, und anschließend wird die zugehörige Methode der *engine* mit den Argumentwörtern ausgeführt. Der Vorgang wiederholt sich danach mit dem dann ersten Wort der Liste.

Die Methoden, die die Sprachbefehle implementieren, haben möglicherweise uneingeschränkten Zugriff auf die Wortliste und dürfen sie nach eigenem Ermessen bearbeiten.

**\[1\]**
: Das bedeutet beispielsweise, dass wir Methoden mit variabler Argumentanzahl zwar nicht direkt spezifizieren können, diese jedoch nach ihren festen Argumenten weitere Wörter verarbeiten können, bevor sie zur Ausführungsschleife zurückkehren. Dies kann durch ihre festen Argumente gesteuert werden.

**\[2\]**
: Eine weitere Möglichkeit besteht darin, die Methode **run_next** und ihre Varianten zu verwenden, um Befehle auszuführen, die auf den aktuellen Befehl folgen, und so die Ausführungsreihenfolge zu ändern.

**\[3\]**
: Die Ausführung lässt sich durch die Verwendung der Zugriffsmethoden des Programms weiter anpassen; diese ermöglichen es einer Befehlsimplementierung, die verbleibende Liste von Wörtern zu ändern (Wörter einfügen, ersetzen, voranstellen oder anhängen), ohne diese sofort auszuführen.

**\[4\]**
: Zuletzt speichern und stellen die grundlegenden **run**-Methoden bei ihrer Verwendung eine vorhandene Wortliste wieder her und ermöglichen so die rekursive Verwendung innerhalb von Befehlsimplementierungen.


# API FÜR KLASSEN

Der Hauptbefehl des Pakets lautet:

**::wip** *wipName* *engine* *arg*...
: Der Befehl erstellt ein neues Wort-Interpreter-Objekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *wipName* lautet. Wurde jedoch die Zeichenfolge **%AUTO%** als Objektname verwendet, erzeugt das Paket einen eigenen eindeutigen Namen für das Objekt. Die *engine* ist das Objekt, an das der Wort-Interpreter alle erkannten Befehle weiterleitet, und die *arg*umente sind eine Wortliste, die eine anfängliche Zuordnung von Sprachwörtern zu Methoden der *engine* definiert. Die erkannte Sprache dieser Wortliste ist


**def** *name*
: Definiert *name* als Befehl der Sprache, der einer gleichnamigen Methode der *engine* zugeordnet wird.

**def** *name* *method_prefix*
: Definiert *name* als Befehl der Sprache, der der im *method_prefix* genannten Methode der *engine* zugeordnet wird.


Der zurückgegebene Befehl kann verwendet werden, um verschiedene Operationen auf dem Objekt auszuführen. Er hat die folgende allgemeine Form:

**wipName** *option* ?*arg arg ...*?
: *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls.


Das Paket exportiert darüber hinaus den Befehl:

**wip::dsl** ?*suffix*?
: Dieser Befehl ist für die Verwendung innerhalb von snit-Typen vorgesehen, die einen oder mehrere wip-Interpreter als Komponente nutzen. Die Verwendung innerhalb der Typdefinition installiert den Großteil des Standardcodes, der zum Einrichten und Nutzen eines Wort-Interpreters nötig ist. Es wird eine Komponente namens *wip* sowie eine Methode **wip_setup** zu deren Initialisierung installiert. Diese Methode muss innerhalb des Konstruktors des Typs aufgerufen werden, der den Wort-Interpreter verwendet. Darüber hinaus wird eine Reihe von Prozeduren installiert, die die Objekt-API des Wort-Interpreters den Methoden des Typs direkt zur Verfügung stellen, ohne dass die Komponente angegeben werden muss. *Hinweis*: Dadurch wird die zu interpretierende Sprache nicht installiert und kann auch nicht installiert werden, d. h. die Zuordnung von Wörtern zu Methoden der *engine*. Es ist möglich, mehrere Wort-Interpreter-Komponenten innerhalb eines Typs zu instanziieren, indem unterschiedliche Suffixe als Argumente für den Befehl verwendet werden. In diesem Fall ändert sich der Name der Komponente zu \\'wip\_**\$suffix**', der Einrichtungsbefehl lautet \\'wip\_**\$suffix**\_setup' und alle Prozeduren erhalten ebenfalls das Suffix \\'\_**\$suffix**'.


# OBJEKT-API

Für Wortinterpreter-Objekte sind folgende Befehle möglich:

*wipName* **def** *name* ?*method_prefix*?
: Definiert einen Sprachbefehl *name* und ordnet ihn der Methode zu, die im *method_prefix* der *engine* genannt ist. Wenn der Name des *method_prefix* nicht angegeben ist, ist er einfach der Name des Sprachbefehls.

*wipName* **defl** *names*
: Definiert eine Reihe von Sprachbefehlen, die über die Liste der *names* festgelegt werden und die alle den gleichnamigen Methoden der *engine* zugeordnet sind.

*wipName* **defd** *dict*
: Definiert eine Reihe von Sprachbefehlen, die über das Dictionary *dict* mit Namen und Methodenpräfixen festgelegt werden.

*wipName* **deflva** *name*...
: Wie die Methode **defl**, die Liste der Namen wird jedoch über mehrere Argumente angegeben.

*wipName* **defdva** (*name* *method_prefix*)...
: Wie die Methode **defd**, das Dictionary der Namen und Methodenpräfixe wird jedoch über mehrere Argumente angegeben.

*wipName* **undefl** *names*
: Entfernt die angegebene Reihe von Sprachbefehlen aus der Zuordnung.

*wipName* **undefva** *name*...
: Wie die Methode **undefl**, die Liste der Namen wird jedoch über mehrere Argumente angegeben.

*wipName* **unknown** *cmdprefix*
: Legt den Handler für unbekannte Wörter auf *cmdprefix* fest. Dieses Befehlspräfix nimmt ein Argument entgegen, das aktuelle Wort, und löst entweder einen Fehler aus oder gibt das Ergebnis der Ausführung des Wortes zurück, wie es der Handler definiert. Der Standard-Handler löst lediglich einen Fehler aus.

*wipName* **runl** *wordlist*
: Behandelt die Wortliste in *wordlist* als Programm und führt die enthaltenen Befehle nacheinander aus. Das Ergebnis des zuletzt ausgeführten Befehls wird als Ergebnis dieses Befehls zurückgegeben. Die *wordlist* wird im Objekt gespeichert, damit die anderen *run*-Methoden sowie die allgemeinen Programm-Zugriffsmethoden (siehe unten) darauf zugreifen können. Eine zuvor gespeicherte Wortliste wird während der Ausführung dieser Methode gesichert und vor der Rückgabe wiederhergestellt. Das ermöglicht die rekursive Ausführung von Wortlisten innerhalb von Wortlisten.

*wipName* **run** *word*...
: Wie die Methode **runl**, die Liste der auszuführenden Wörter wird jedoch über mehrere Argumente angegeben.

*wipName* **run_next**
: Low-Level-Methode. Ermittelt das nächste Wort in der Wortliste sowie dessen Argumente und führt es anschließend aus. Das Ergebnis des ausgeführten Worts ist das Ergebnis dieser Methode. Sie steht zur Verwendung innerhalb von Befehlsimplementierungen zur Verfügung. Die Methoden **run** und **runl** nutzen sie, um Wörter so lange auszuführen, bis ihre Wortliste erschöpft ist.

*wipName* **run_next_while** *acceptable*
: Low-Level-Methode. Ruft die Methode **run_next** auf, solange das nächste Wort zur Menge der *acceptable* Wörter gehört und das Programm nicht leer ist. Das Ergebnis des zuletzt ausgeführten Befehls wird als Ergebnis dieses Befehls zurückgegeben. Diese Methode steht zur Verwendung innerhalb von Befehlsimplementierungen zur Verfügung, um die Ausführungsreihenfolge zu ändern.

*wipName* **run_next_until** *rejected*
: Low-Level-Methode. Ruft die Methode **run_next** auf, bis das nächste Wort zur Menge der *rejected* Wörter gehört und das Programm nicht leer ist. Das Ergebnis des zuletzt ausgeführten Befehls wird als Ergebnis dieses Befehls zurückgegeben. Diese Methode steht zur Verwendung innerhalb von Befehlsimplementierungen zur Verfügung, um die Ausführungsreihenfolge zu ändern.

*wipName* **run_next_if** *acceptable*
: Low-Level-Methode. Ruft die Methode **run_next** auf, wenn das nächste Wort zur Menge der *acceptable* Wörter gehört und das Programm nicht leer ist. Das Ergebnis des zuletzt ausgeführten Befehls wird als Ergebnis dieses Befehls zurückgegeben. Diese Methode steht zur Verwendung innerhalb von Befehlsimplementierungen zur Verfügung, um die Ausführungsreihenfolge zu ändern.

*wipName* **run_next_ifnot** *rejected*
: Low-Level-Methode. Ruft die Methode **run_next** auf, wenn das nächste Wort nicht zur Menge der *rejected* Wörter gehört und das Programm nicht leer ist. Das Ergebnis des zuletzt ausgeführten Befehls wird als Ergebnis dieses Befehls zurückgegeben. Diese Methode steht zur Verwendung innerhalb von Befehlsimplementierungen zur Verfügung, um die Ausführungsreihenfolge zu ändern.

*wipName* **next**
: Gibt das nächste Wort im Programm zurück. Das Wort wird dabei ebenfalls entfernt.

*wipName* **peek**
: Gibt das nächste Wort im Programm zurück, ohne es zu entfernen.

*wipName* **peekall**
: Gibt das verbleibende Programm vollständig zurück.

*wipName* **insertl** *at* *wordlist*
: Grundlegende Programm-Zugriffsmethode. Fügt die angegebene *wordlist* in das Programm ein, unmittelbar vor dem Wort an der Position *at*. Die Positionen werden ab **zero** gezählt.

*wipName* **replacel** *wordlist*
: Grundlegende Programm-Zugriffsmethode. Ersetzt das gesamte gespeicherte Programm durch die angegebene *wordlist*.

*wipName* **pushl** *wordlist*
: Programm-Zugriffsmethode. Die angegebene *wordlist* wird an den Anfang des verbleibenden Programms gesetzt. Entspricht


```
$wip insertl 0 $wordlist
```

*wipName* **addl** *wordlist*
: Programm-Zugriffsmethode. Die angegebene *wordlist* wird an das Ende des verbleibenden Programms angehängt. Entspricht


```
$wip insertl end $wordlist
```

*wipName* **insert** *at* *word*...
: Ähnlich wie bei der Methode **insertl**, mit dem Unterschied, dass die Wörter über mehrere Argumente festgelegt werden.

*wipName* **replace** *word*...
: Wie die Methode **setl**, die Wörter werden jedoch über mehrere Argumente angegeben.

*wipName* **push** *word*...
: Ähnlich wie bei der Methode **pushl**, mit dem Unterschied, dass die Wörter über mehrere Argumente festgelegt werden.

*wipName* **add** *word*...
: Ähnlich wie bei der Methode **addl**, mit dem Unterschied, dass die Wörter über mehrere Argumente festgelegt werden.


# BEISPIELE

Noch keine Beispiele.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *wip* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge

# COPYRIGHT

```
Copyright (c) 2007-2010 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
