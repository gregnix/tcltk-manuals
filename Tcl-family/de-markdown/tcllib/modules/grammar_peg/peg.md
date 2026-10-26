---
CommandName: grammar::peg
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - LL(k)
 - TDPL
 - context-free languages
 - expression
 - grammar
 - parsing
 - parsing expression
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - state
 - top-down parsing languages
 - transducer
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

grammar::peg – Erstellen und Bearbeiten von Parsing Expression Grammars

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [grammar::peg]{.lit} [0.3]{.optlit} 
[::grammar::peg]{.cmd} [pegName]{.arg} [=|:=|<--|as|deserialize src]{.optarg} 
[pegName]{.ins} [destroy]{.sub} 
[pegName]{.ins} [clear]{.sub} 
[pegName]{.ins} [=]{.sub} [srcPEG]{.arg} 
[pegName]{.ins} [-->]{.sub} [dstPEG]{.arg} 
[pegName]{.ins} [serialize]{.sub} 
[pegName]{.ins} [deserialize]{.sub} [serialization]{.arg} 
[pegName]{.ins} [is]{.sub} [valid]{.lit} 
[pegName]{.ins} [start]{.sub} [pe]{.optarg} 
[pegName]{.ins} [nonterminals]{.sub} 
[pegName]{.ins} [nonterminal]{.sub} [add]{.lit} [nt]{.arg} [pe]{.arg} 
[pegName]{.ins} [nonterminal]{.sub} [delete]{.lit} [nt1]{.arg} [nt2]{.optdot} 
[pegName]{.ins} [nonterminal]{.sub} [exists]{.lit} [nt]{.arg} 
[pegName]{.ins} [nonterminal]{.sub} [rename]{.lit} [nt]{.arg} [ntnew]{.arg} 
[pegName]{.ins} [nonterminal]{.sub} [mode]{.lit} [nt]{.arg} [mode]{.optarg} 
[pegName]{.ins} [nonterminal]{.sub} [rule]{.lit} [nt]{.arg} 
[pegName]{.ins} [unknown]{.sub} [nonterminals]{.lit} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine Containerklasse für *Parsing Expression Grammars* (kurz: PEG) bereit. Es ermöglicht die schrittweise Definition der Grammatik, deren Bearbeitung sowie die Abfrage der Definition. Das Paket bietet weder komplexe Operationen auf der Grammatik an, noch verfügt es über die Fähigkeit, eine Grammatikdefinition für einen Symbolstrom auszuführen. Zwei mit diesem Paket verwandte Pakete sind **grammar::mengine** und **grammar::peg::interpreter**. Das erste davon definiert eine allgemeine virtuelle Maschine für das Abgleichen eines Zeichenstroms, und das zweite implementiert auf Basis dieser virtuellen Maschine einen Interpreter für Parsing-Ausdrücke.

## Begriffe und Konzepte

PEGs ähneln kontextfreien Grammatiken, sind jedoch nicht mit diesen gleichzusetzen; in einigen Fällen sind PEGs strikt mächtiger als kontextfreie Grammatiken (es gibt PEGs für einige nicht-kontextfreie Sprachen). Die formale mathematische Definition von Parsing-Ausdrücken und Parsing Expression Grammars steht im Abschnitt **PARSING-EXPRESSION-GRAMMATIKEN**.

Kurz gesagt gibt es *terminale Symbole*, die die grundlegendsten Bausteine für *Sätze* darstellen, sowie *nichtterminale Symbole* mit zugehörigen *Parsing-Ausdrücken*, die die grammatikalische Struktur der Sätze definieren. Die beiden Symbolmengen unterscheiden sich voneinander und überschneiden sich nicht. Wenn von Symbolen die Rede ist, wird das Wort „Symbol“ oft weggelassen. Die Vereinigung der Mengen der terminalen und nichtterminalen Symbole wird als Menge der *Symbole* bezeichnet.

Hier wird die Menge der *Terminalsymbole* nicht explizit verwaltet, sondern implizit als die Menge aller Zeichen definiert. Zu beachten ist, dass dies bedeutet, dass wir von Tcl die Fähigkeit übernehmen, den gesamten Unicode-Zeichensatz zu verarbeiten.

Ein Paar aus einem *Nichtterminal* und einem *Parsing-Ausdruck* wird auch als *grammatikalische Regel* oder kurz als *Regel* bezeichnet. Im Zusammenhang mit einer Regel wird das Nichtterminal häufig als linke Seite (LHS) und der Parsing-Ausdruck als rechte Seite (RHS) bezeichnet.

Der *Startausdruck* einer Grammatik ist ein Parsing-Ausdruck, aus dem alle Sätze, die in der durch die Grammatik festgelegten Sprache enthalten sind, *abgeleitet* werden. Um das Verständnis dieses Begriffs zu erleichtern, nehmen wir für einen Moment an, dass die rechte Seite jeder Regel sowie der Startausdruck entweder eine Folge von Symbolen oder eine Reihe alternativer Parsing-Ausdrücke sind. Im letzteren Fall kann die Regel als eine Menge von Regeln betrachtet werden, von denen jede eine Alternative für das Nichtterminal bereitstellt. Ein Parsing-Ausdruck A’ ist nun eine Ableitung eines Parsing-Ausdrucks A, wenn wir eines der Nichtterminale N im Ausdruck und eine der alternativen Regeln R für N auswählen und dann das Nichtterminal in A durch die rechte Seite der ausgewählten Regel ersetzen. Hier wird deutlich, warum die Terminalsymbole so genannt werden. Sie lassen sich nicht weiter auflösen und beenden somit den Prozess der Ableitung neuer Ausdrücke. Ein Beispiel

```
    Rules
      (1)  A <- a B c
      (2a) B <- d B
      (2b) B <- e

    Some derivations, using starting expression A.

      A -/1/-> a B c -/2a/-> a d B c -/2b/-> a d e c
```

Ein abgeleiteter Ausdruck, der nur Terminale enthält, ist ein *Satz*. Die Menge aller Sätze, die aus dem Startausdruck abgeleitet werden können, ist die *Sprache* der Grammatik.

Einige Definitionen für Nichtterminale und Ausdrücke:

**\[1\]**
: Ein Nichtterminal A heißt *reachable*, wenn sich aus dem Startausdruck ein Parsing-Ausdruck ableiten lässt, der A enthält.

**\[2\]**
: Ein Nichtterminal A wird als *nützlich* bezeichnet, wenn es möglich ist, daraus einen Satz abzuleiten.

**\[3\]**
: Ein Nichtterminal A wird als *rekursiv* bezeichnet, wenn es möglich ist, daraus einen Parsing-Ausdruck abzuleiten, der wiederum A enthält.

**\[4\]**
: Die *FIRST-Menge* eines Nichtterminals A enthält alle Symbole, die als das Symbol ganz links in einem von A abgeleiteten Parsing-Ausdruck vorkommen können. Wenn die FIRST-Menge A selbst enthält, so wird dieses Nichtterminal als *linksrekursiv* bezeichnet.

**\[5\]**
: Die *LAST-Menge* eines Nichtterminals A enthält alle Symbole, die als das Symbol ganz rechts in einem von A abgeleiteten Parsing-Ausdruck vorkommen können. Wenn die LAST-Menge A selbst enthält, so wird dieses Nichtterminal als *rechtsrekursiv* bezeichnet.

**\[6\]**
: Die *FOLLOW-Menge* eines Nichtterminals A enthält alle Symbole, die in einem aus dem Startausdruck abgeleiteten Parsing-Ausdruck nach A auftreten können.

**\[7\]**
: Ein Nichtterminal (oder ein Parsing-Ausdruck) wird als *nullfähig* bezeichnet, wenn sich daraus der leere Satz ableiten lässt. Und auf der Grundlage der obigen Definitionen für Grammatiken gilt:

**\[1\]**
: Eine Grammatik G ist genau dann *rekursiv*, wenn sie ein nichtterminales Symbol A enthält, das rekursiv ist. Die Begriffe *links-* und *rechtsrekursiv* sowie *nützlich* sind analog definiert.

**\[2\]**
: Eine Grammatik ist *minimal*, wenn sie ausschließlich *erreichbare* und *nützliche* Nichtterminale enthält.

**\[3\]**
: Eine Grammatik ist *wohlgeformt*, wenn sie nicht linksrekursiv ist. Solche Grammatiken sind zudem *vollständig*, was bedeutet, dass sie bei allen Eingabesätzen entweder erfolgreich sind oder fehlschlagen. Bei einer unvollständigen Grammatik hingegen gibt es Eingabesätze, bei denen der Versuch, diese mit der Grammatik abzugleichen, nicht beendet wird.

**\[4\]**
: Da wir uns die Möglichkeit offenhalten möchten, eine Grammatik schrittweise in einem Container-Objekt aufzubauen, werden wir auf Phasen stoßen, in denen die rechte Seite einer oder mehrerer Regeln auf Symbole verweist, die dem Container noch nicht bekannt sind. Eine solche Grammatik bezeichnen wir als *ungültig*. Wir können den Begriff *unvollständig* nicht verwenden, da dieser Begriff bereits vergeben ist; siehe den letzten Punkt.


## API der Container-Klasse

Das Paket exportiert die hier beschriebene API.

**::grammar::peg** *pegName* ?**=**|**:=**|**<--**|**as**|**deserialize** *src*?
: Der Befehl erstellt ein neues Containerobjekt für eine Parsing-Ausdrucksgrammatik und gibt den vollqualifizierten Namen des Objektbefehls als Ergebnis zurück. Die API, der der zurückgegebene Befehl folgt, wird im Abschnitt **API für Container-Objekte** beschrieben. Sie kann verwendet werden, um verschiedene Operationen auf den Container und die darin enthaltene Grammatik anzuwenden. Der neue Container, d. h. die Grammatik, ist leer, wenn kein *src* angegeben wird. Andernfalls enthält er eine Kopie der in *src* enthaltenen Grammatik. *src* muss bei allen Operatoren mit Ausnahme von **deserialize** eine Referenz auf ein Container-Objekt sein. Der Operator **deserialize** verlangt stattdessen, dass *src* die Serialisierung einer Parsing Expression Grammar ist. Eine leere Grammatik hat keine Nichtterminale, und der Startausdruck ist der leere Ausdruck, also Epsilon. Sie ist *gültig*, aber nicht *nützlich*.


## API für Container-Objekte

Alle Grammatik-Container-Objekte stellen die folgenden Methoden zur Bearbeitung ihres Inhalts bereit:

*pegName* **destroy**
: Löscht die Grammatik, einschließlich ihres Speicherplatzes und des zugehörigen Befehls.

*pegName* **clear**
: Löscht die in *pegName* enthaltenen Definitionen der Grammatik, zerstört das Objekt jedoch *nicht*.

*pegName* **=** *srcPEG*
: Weist *pegName* den Inhalt der in *srcPEG* enthaltenen Grammatik zu und überschreibt dabei etwaige bereits vorhandene Definitionen. Dies ist der Zuweisungsoperator für Grammatiken. Er kopiert die im Grammatikobjekt *srcPEG* enthaltene Grammatik über die Grammatikdefinition in *pegName*. Der bisherige Inhalt von *pegName* wird durch diesen Vorgang gelöscht. Dieser Vorgang entspricht im Wesentlichen


```
    pegName deserialize [srcPEG serialize]
```

*pegName* **-->** *dstPEG*
: Dies ist der Umkehrzuweisungsoperator für Grammatiken. Er kopiert die im Objekt *pegName* enthaltene Grammatik in die Grammatikdefinition des Objekts *dstPEG*. Der bisherige Inhalt von *dstPEG* wird durch diesen Vorgang gelöscht. Dieser Vorgang entspricht im Wesentlichen


```
    dstPEG deserialize [pegName serialize]
```

*pegName* **serialize**
: Diese Methode serialisiert die in *pegName* gespeicherte Grammatik. Mit anderen Worten: Sie gibt einen Tcl-*value* zurück, der diese Grammatik vollständig beschreibt. Dies ermöglicht beispielsweise die Übertragung von Grammatiken über beliebige Kanäle, die Persistenz usw. Diese Methode bildet zudem die Grundlage sowohl für den Kopier-Konstruktor als auch für den Zuweisungsoperator. Das Ergebnis dieser Methode muss über alle Implementierungen der Schnittstelle **grammar::peg** hinweg semantisch identisch sein. Dies ermöglicht es uns, Grammatiken zwischen verschiedenen Implementierungen derselben Schnittstelle zu kopieren. Das Ergebnis ist eine Liste mit vier Elementen, die folgende Struktur aufweist:


**\[1\]**
: Die Konstante „**grammar::peg**“.

**\[2\]**
: Ein Dictionary. Seine Schlüssel sind die Namen aller bekannten nichtterminalen Symbole, und die ihnen zugeordneten Werte sind die Parsing-Ausdrücke, die deren Satzstruktur beschreiben.

**\[3\]**
: Ein Dictionary. Seine Schlüssel sind die Namen aller bekannten nichtterminalen Symbole, und die ihnen zugeordneten Werte liefern einem Matcher Hinweise auf die semantischen Werte, die durch das Symbol erzeugt werden.

**\[4\]**
: Das letzte Element ist ein Parsing-Ausdruck, der *Startausdruck* der Grammatik.


Unter der Annahme der folgenden PEG für einfache mathematische Ausdrücke

```
    Digit      <- '0'/'1'/'2'/'3'/'4'/'5'/'6'/'7'/'8'/'9'
    Sign       <- '+' / '-'
    Number     <- Sign? Digit+
    Expression <- '(' Expression ')' / (Factor (MulOp Factor)*)
    MulOp      <- '*' / '/'
    Factor     <- Term (AddOp Term)*
    AddOp      <- '+'/'-'
    Term       <- Number
```

Eine mögliche Serialisierung lautet

```
    grammar::peg \
    {Expression {/ {x ( Expression )} {x Factor {* {x MulOp Factor}}}} \
     Factor     {x Term {* {x AddOp Term}}} \
     Term       Number \
     MulOp      {/ * /} \
     AddOp      {/ + -} \
     Number     {x {? Sign} {+ Digit}} \
     Sign       {/ + -} \
     Digit      {/ 0 1 2 3 4 5 6 7 8 9} \
    } \
    {Expression value     Factor     value \
     Term       value     MulOp      value \
     AddOp      value     Number     value \
     Sign       value     Digit      value \
    }
    Expression
```

Eine mögliche Variante, da die Reihenfolge der Nichtterminale im Dictionary keine Rolle spielt.

*pegName* **deserialize** *serialization*
: Dies ist die Ergänzung zu **serialize**. Sie ersetzt die Grammatikdefinition in *pegName* durch die durch den Wert *serialization* beschriebene Grammatik. Der bisherige Inhalt von *pegName* wird durch diesen Vorgang gelöscht.

*pegName* **is valid**
: Ein Prädikat. Es prüft, ob die PEG in *pegName* *gültig* ist. Die Definition dieser Grammatikeigenschaft finden Sie im Abschnitt **Begriffe und Konzepte**. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn die PEG die geprüfte Eigenschaft aufweist, andernfalls auf **false**.

*pegName* **start** ?*pe*?
: Diese Methode definiert den *Startausdruck* der Grammatik. Sie ersetzt den zuvor definierten Startausdruck durch den Parsing-Ausdruck *pe*. Die Methode schlägt fehl und löst einen Fehler aus, wenn *pe* keinen gültigen Parsing-Ausdruck enthält, wie im Abschnitt **Parsing-Ausdrücke** festgelegt. In diesem Fall wird der bestehende Startausdruck nicht geändert. Die Methode gibt als Ergebnis die leere Zeichenkette zurück. Wenn die Methode ohne Argument aufgerufen wird, gibt sie den aktuell definierten Startausdruck zurück.

*pegName* **nonterminals**
: Gibt die Menge aller der Grammatik bekannten nichtterminalen Symbole zurück.

*pegName* **nonterminal add** *nt* *pe*
: Diese Methode fügt das Nichtterminal *nt* und den dazugehörigen Parsing-Ausdruck *pe* zur Menge der Nichtterminal-Symbole und Regeln der PEG hinzu, die im Objekt *pegName* enthalten sind. Die Methode schlägt fehl und löst einen Fehler aus, wenn entweder die Zeichenkette *nt* bereits als Symbol der Grammatik bekannt ist oder wenn *pe* keinen gültigen Parsing-Ausdruck enthält, wie im Abschnitt **Parsing-Ausdrücke** festgelegt. In diesem Fall wird die aktuelle Menge der nichtterminalen Symbole und Regeln nicht verändert. Die Methode gibt die leere Zeichenkette als Ergebnis zurück.

*pegName* **nonterminal delete** *nt1* ?*nt2* ...?
: Diese Methode entfernt die genannten Symbole *nt1* und *nt2* aus der Menge der nichtterminalen Symbole der PEG, die im Objekt *pegName* enthalten ist. Die Methode schlägt fehl und löst einen Fehler aus, wenn eine der Zeichenfolgen nicht als nichtterminales Symbol bekannt ist. In diesem Fall wird die aktuelle Menge der nichtterminalen Symbole nicht verändert. Die Methode gibt als Ergebnis die leere Zeichenkette zurück. Die gespeicherte Grammatik wird ungültig, wenn die gelöschten Nichtterminale von der rechten Seite (RHS) noch bekannter Regeln referenziert werden.

*pegName* **nonterminal exists** *nt*
: Ein Prädikat. Es führt Tests durch, um zu prüfen, ob das nichtterminale Symbol *nt* dem PEG in *pegName* bekannt ist. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn das Symbol *nt* bekannt ist, andernfalls auf **false**.

*pegName* **nonterminal rename** *nt* *ntnew*
: Diese Methode benennt das nichtterminale Symbol *nt* in *ntnew* um. Die Methode schlägt fehl und löst einen Fehler aus, wenn entweder *nt* nicht als nichtterminales Symbol bekannt ist oder wenn *ntnew* ein bekanntes Symbol ist. Die Methode gibt als Ergebnis die leere Zeichenkette zurück.

*pegName* **nonterminal mode** *nt* ?*mode*?
: Diese Methode gibt den mit dem Nichtterminal-Symbol *nt* verknüpften semantischen Modus zurück oder legt ihn fest. Wird kein *mode* angegeben, wird der aktuelle Modus des Nichtterminals zurückgegeben. Andernfalls wird der aktuelle Modus auf *mode* gesetzt. Die Methode schlägt fehl und löst einen Fehler aus, wenn *nt* nicht als Nichtterminal bekannt ist. Der vom Paket **grammar::peg::interpreter** implementierte Grammatik-Interpreter erkennt die folgenden Modi:


**value**
: Der semantische Wert des Nichtterminals ist der abstrakte Syntaxbaum, der aus den ASTs der rechten Seite und einem Knoten für das Nichtterminal selbst gebildet wird.

**match**
: Der semantische Wert des Nichtterminals ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für die von der rechten Seite (RHS) abgeglichene Zeichenkette besteht. Die von der rechten Seite (RHS) generierten ASTs werden verworfen.

**leaf**
: Der semantische Wert des Nichtterminals ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminal selbst besteht. Die von der rechten Seite (RHS) erzeugten ASTs werden verworfen.

**discard**
: Das Nichtterminal hat keinen semantischen Wert. Die von der rechten Seite (RHS) generierten ASTs werden (ebenfalls) verworfen.


*pegName* **nonterminal rule** *nt*
: Diese Methode gibt den Parsing-Ausdruck zurück, der dem Nichtterminal *nt* zugeordnet ist. Die Methode schlägt fehl und löst einen Fehler aus, wenn *nt* nicht als Nichtterminal bekannt ist.

*pegName* **unknown nonterminals**
: Diese Methode gibt eine Liste zurück, die die Namen aller nichtterminalen Symbole enthält, auf die auf der rechten Seite einer grammatikalischen Regel Bezug genommen wird, für deren Struktur jedoch keine Regel definiert ist. Mit anderen Worten: eine Liste der nichtterminalen Symbole, die die Grammatik ungültig machen. Die Grammatik ist gültig, wenn diese Liste leer ist.


## Parsing-Ausdrücke

Verschiedene Methoden von PEG-Container-Objekten erwarten einen Parsing-Ausdruck als Argument oder geben einen solchen zurück. In diesem Abschnitt wird das Format solcher Parsing-Ausdrücke festgelegt.

**\[1\]**
: Die Zeichenfolge **epsilon** ist ein atomarer Parsing-Ausdruck. Sie passt auf die leere Zeichenfolge.

**\[2\]**
: Die Zeichenfolge „**alnum**“ ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes alphanumerische Zeichen.

**\[3\]**
: Die Zeichenfolge „**alpha**“ ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes alphabetische Zeichen.

**\[4\]**
: Die Zeichenfolge **dot** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Zeichen.

**\[5\]**
: Der Ausdruck \[list t **x**\] ist ein atomarer Parsing-Ausdruck. Er passt auf die Terminalzeichenkette **x**.

**\[6\]**
: Der Ausdruck \[list n **A**\] ist ein atomarer Parsing-Ausdruck. Er passt auf das Nichtterminal **A**.

**\[7\]**
: Für die Parsing-Ausdrücke **e1**, **e2**, ... ist das Ergebnis von \[list / **e1** **e2** ... \] ebenfalls ein Parsing-Ausdruck. Das ist die *ordered choice*, auch *prioritized choice*.

**\[8\]**
: Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list x **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Dies ist die *Sequenz*.

**\[9\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list \* **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist der *Kleene-Abschluss*, der null oder mehr Wiederholungen beschreibt.

**\[10\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list + **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist der *positive Kleene-Abschluss*, der eine oder mehrere Wiederholungen beschreibt.

**\[11\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list & **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist das *„and lookahead“-Prädikat*.

**\[12\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list ! **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist das *Not-Lookahead-Prädikat*.

**\[13\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list ? **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist die *optionale Eingabe*. Beispiele für Parsing-Ausdrücke wurden bereits in der Beschreibung der Methode **serialize** aufgeführt.


# PARSING-EXPRESSION-GRAMMATIKEN

Für mathematisch Interessierte: Ein PEG ist ein 4-Tupel (VN, VT, R, eS), wobei

**•**
: VN ist eine Menge von *nichtterminalen Symbolen*,

**•**
: VT ist eine Menge von *Terminalsymbolen*,

**•**
: R ist eine endliche Menge von Regeln, wobei jede Regel ein Paar (A, e) ist, wobei A in VN liegt und *e* ein *Parsing-Ausdruck* ist.

**•**
: eS ist ein Parsing-Ausdruck, der *Startausdruck*. Weitere Bedingungen sind

**•**
: Die Schnittmenge von VN und VT ist leer.

**•**
: Für jedes A in VN gibt es genau ein Paar (A, e) in R. Mit anderen Worten: R ist eine Funktion von nichtterminalen Symbolen zu Parsing-Ausdrücken. Parsing-Ausdrücke werden induktiv definiert über

**•**
: Die leere Zeichenkette (Epsilon) ist ein Parsing-Ausdruck.

**•**
: Ein Terminalsymbol *a* ist ein Parsing-Ausdruck.

**•**
: Ein nichtterminales Symbol *A* ist ein Parsing-Ausdruck.

**•**
: *e1e2* ist ein Parsing-Ausdruck für die Parsing-Ausdrücke *e1* und *e2*. Das heißt *Sequenz*.

**•**
: *e1*/*e2* ist ein Parsing-Ausdruck für die Parsing-Ausdrücke *e1* und *e2*. Dies wird als *geordnete Auswahl* bezeichnet.

**•**
: *e*\* ist ein Parsing-Ausdruck für den Parsing-Ausdruck *e*. Dies wird als *Null-oder-mehr-Wiederholungen* bezeichnet, auch bekannt als *Kleene-Abschluss*.

**•**
: *e*+ ist ein Parsing-Ausdruck für den Parsing-Ausdruck *e*. Dies wird als *eine oder mehrere Wiederholungen* bezeichnet, auch bekannt als *positiver Kleene-Abschluss*.

**•**
: !*e* ist ein Parsing-Ausdruck für den Parsing-Ausdruck *e*. Dies wird als *Prädikat ohne Vorausschau* bezeichnet.

**•**
: &*e* ist ein Parsing-Ausdruck für den Parsing-Ausdruck *e*. Dies wird als *„And-Lookahead-Prädikat“* bezeichnet. PEGs werden verwendet, um eine grammatikalische Struktur für Symbolströme über VT zu definieren. Sie stellen eine moderne Weiterentwicklung älterer Formalismen dar, die von Alexander Birham entwickelt wurden. Diese Formalismen wurden als TS (TMG-Erkennungsschema) und gTS (verallgemeinertes TS) bezeichnet. Später wurden sie in TPDL (Top-Down-Parsing-Sprachen) und gTPDL (verallgemeinertes TPDL) umbenannt. Sie lassen sich leicht durch rekursive Abstiegsparser mit Backtracking implementieren. Damit stehen sie in Verwandtschaft zu den kontextfreien LL(k)-Grammatiken.


# LITERATUR

**\[1\]**
: [The Packrat Parsing and Parsing Expression Grammars Page](http://www.pdos.lcs.mit.edu/~baford/packrat/), von Bryan Ford, Massachusetts Institute of Technology. Das ist die Haupteinstiegsseite zu PEGs und ihrer Umsetzung durch Packrat-Parser.

**\[2\]**
: *Parsing Techniques - A Practical Guide*  <http://www.cs.vu.nl/~dick/PTAPG.html>, ein Online-Buch, das eine klare, leicht verständliche und umfassende Darstellung zahlreicher verschiedener Parsing-Techniken mit ihren Zusammenhängen und Anwendungsmöglichkeiten bietet, einschließlich Techniken zur Fehlerbehebung.

**\[3\]**
: [Compilers and Compiler Generators](http://scifac.ru.ac.za/compilers/), ein Online-Buch, das CoCo/R verwendet, einen Generator für rekursive Abstiegsparser.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *grammar_peg* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Grammatiken und endliche Automaten

# COPYRIGHT

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
