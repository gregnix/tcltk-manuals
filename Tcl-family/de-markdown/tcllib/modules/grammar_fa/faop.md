---
CommandName: grammar::fa::op
title: grammar::fa::op
ManualSection: n
Version: 0.4
TclPart: tcllib
TclDescription: Finite automaton operations and usage
Keywords:
 - automaton
 - finite automaton
 - grammar
 - parsing
 - regular expression
 - regular grammar
 - regular languages
 - state
 - transducer
Copyright:
 - Copyright (c) 2004-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

grammar::fa::op – Operationen an endlichen Automaten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [struct::list]{.lit}
[package]{.cmd} [require]{.sub} [struct::set]{.lit}
[package]{.cmd} [require]{.sub} [grammar::fa::op]{.lit} [0.4.2]{.optlit}
[::grammar::fa::op::constructor]{.cmd} [cmd]{.arg}
[::grammar::fa::op::reverse]{.cmd} [fa]{.arg}
[::grammar::fa::op::complete]{.cmd} [fa]{.arg} [sink]{.optarg}
[::grammar::fa::op::remove\_eps]{.cmd} [fa]{.arg}
[::grammar::fa::op::trim]{.cmd} [fa]{.arg} [what]{.optarg}
[::grammar::fa::op::determinize]{.cmd} [fa]{.arg} [mapvar]{.optarg}
[::grammar::fa::op::minimize]{.cmd} [fa]{.arg} [mapvar]{.optarg}
[::grammar::fa::op::complement]{.cmd} [fa]{.arg}
[::grammar::fa::op::kleene]{.cmd} [fa]{.arg}
[::grammar::fa::op::optional]{.cmd} [fa]{.arg}
[::grammar::fa::op::union]{.cmd} [fa]{.arg} [fb]{.arg} [mapvar]{.optarg}
[::grammar::fa::op::intersect]{.cmd} [fa]{.arg} [fb]{.arg} [mapvar]{.optarg}
[::grammar::fa::op::difference]{.cmd} [fa]{.arg} [fb]{.arg} [mapvar]{.optarg}
[::grammar::fa::op::concatenate]{.cmd} [fa]{.arg} [fb]{.arg} [mapvar]{.optarg}
[::grammar::fa::op::fromRegex]{.cmd} [fa]{.arg} [regex]{.arg} [over]{.optarg}
[::grammar::fa::op::toRegexp]{.cmd} [fa]{.arg}
[::grammar::fa::op::toRegexp2]{.cmd} [fa]{.arg}
[::grammar::fa::op::toTclRegexp]{.cmd} [regexp]{.arg} [symdict]{.arg}
[::grammar::fa::op::simplifyRegexp]{.cmd} [regexp]{.arg}
:::

# Beschreibung

Dieses Paket bietet eine Reihe komplexer Operationen für endliche Automaten (kurz: FA), wie sie vom Paket **grammar::fa** bereitgestellt werden. Das Paket bietet weder die Möglichkeit, solche FAs zu erstellen und/oder zu bearbeiten, noch die Möglichkeit, einen FA für einen Symbolstrom auszuführen. Verwenden Sie hierfür die Pakete **grammar::fa** und **grammar::fa::interpreter**. Ein weiteres damit zusammenhängendes Paket ist **grammar::fa::compiler**, das einen FA in eine Executor-Klasse umwandelt, in die die Definitionen des FA fest integriert sind.

Weitere Informationen darüber, was ein endlicher Automat ist, finden Sie im Abschnitt *ENDLICHE AUTOMATEN* im Paket **grammar::fa**.

# API

Das Paket exportiert die hier beschriebene API. Alle Befehle ändern ihr erstes Argument. Das heißt, welcher FA auch immer von ihnen berechnet wird, wird wieder darin gespeichert. Einige der Operationen konstruieren einen Automaten, dessen Zustände alle neu sind, jedoch mit den Zuständen des/der Quellautomaten in Beziehung stehen. Diese Operationen nehmen Namen von Variablen als optionale Argumente entgegen, in denen sie Zuordnungen speichern, die die Beziehung(en) beschreiben. Die Operationen lassen sich grob in Struktur- und Sprachoperationen unterteilen. Letztere werden anhand der Sprache definiert, die der/die Automat(en) akzeptiert/akzeptieren, während erstere anhand der strukturellen Eigenschaften des/der beteiligten Automaten definiert werden. Einige Operationen sind beides. *Strukturoperationen*

**::grammar::fa::op::constructor** *cmd*
: Dieser Befehl muss vom Benutzer des Pakets aufgerufen werden, bevor andere Operationen ausgeführt werden, um einen Befehl zu definieren, mit dem ein FA-Container-Objekt erstellt werden kann. Wird dies nicht getan, schlagen mehrere Operationen fehl, da sie keine internen und temporären Container erstellen können, um den Zustand und/oder Teilergebnisse zu speichern.

    Jede Containerklasse, die dieses Paket für komplexe Operationen verwendet, sollte ihren eigenen Klassenbefehl als Konstruktor festlegen. Beispiele finden Sie im Paket **grammar::fa**.

**::grammar::fa::op::reverse** *fa*
: Kehrt den *fa* um. Dazu wird die Richtung aller Übergänge umgekehrt und die Mengen der *start*- und *final*-Zustände werden vertauscht. Die Sprache von *fa* verändert sich auf unvorhersehbare Weise.

**::grammar::fa::op::complete** *fa* ?*sink*?
: Vervollständigt den *fa*, tut aber nichts, wenn der *fa* bereits *complete* ist. Dies bedeutet, dass nur die erste einer Reihe mehrerer aufeinanderfolgender *complete*-Operationen auf *fa* eine Aktion ausführt. Die übrigen Operationen sind Nulloperationen.

    Die Sprache von *fa* bleibt durch diese Operation unverändert.

    Dies wird erreicht, indem ein einziger neuer Zustand, der *sink*, hinzugefügt wird, sowie Übergänge von allen anderen Zuständen zu diesem *sink* für alle Symbole, für die keine Übergänge vorhanden sind. Der *sink* selbst wird vollständig gemacht, indem Schleifenübergänge für alle Symbole hinzugefügt werden.

    Zu beachten: Wenn ein FA über Epsilon-Übergänge verfügt, können Übergänge über ein Symbol für einen Zustand S indirekt sein, d. h. nicht direkt an S, sondern an einen Zustand in der Epsilon-Hülle von S gekoppelt. Die Symbole für solche indirekten Übergänge werden bei der Berechnung der Vollständigkeit eines Zustands berücksichtigt. Mit anderen Worten: Diese indirekt erreichbaren Symbole fehlen *nicht*.

    Das Argument *sink* liefert den Namen für den neuen Zustand und darf, wenn angegeben, nicht bereits in der *fa* vorhanden sein. Wenn der Name nicht angegeben wird, benennt der Befehl den Zustand „sink**n**“, wobei **n** so festgelegt wird, dass keine Kollisionen mit bestehenden Zuständen auftreten.

    Hinweis: Der Sink-Zustand ist per Definition *nicht nützlich*. Mit anderen Worten: Zwar wird der FA dadurch vollständig, doch ist er im strengen Sinne *nicht nützlich*, da sie einen Zustand enthält, von dem aus kein Endzustand erreicht werden kann.

**::grammar::fa::op::remove\_eps** *fa*
: Entfernt alle Epsilon-Übergänge aus *fa* in einer Weise, dass die Sprache von *fa* unverändert bleibt. Es erfolgt jedoch keine Änderung, wenn *fa* bereits *epsilon-frei* ist. Dies bedeutet, dass nur die erste einer Reihe mehrerer aufeinanderfolgender remove_eps-Operationen auf *fa* eine Änderung bewirkt. Die übrigen Operationen sind Nulloperationen.

    *Hinweis:* Diese Operation kann Zustände unerreichbar oder unbrauchbar machen. Diese Zustände entfernt die Operation nicht. Dafür ist **::grammar::fa::op::trim** zuständig.

**::grammar::fa::op::trim** *fa* ?*what*?
: Entfernt unerwünschten Ballast aus *fa*. Die zulässigen Werte für *what* sind unten aufgeführt. Der Befehl verwendet standardmäßig den Wert **!reachable|!useful**, sofern kein spezifisches Argument angegeben wurde.

    **!reachable**
    : Entfernt alle Zustände, die von einem Startzustand aus nicht erreichbar sind.

    **!useful**
    : Entfernt alle Zustände, die nicht zu einem Endzustand führen können.

    **!reachable&!useful**
    : siehe unten ...

    **!(reachable|useful)**
    : Entfernt alle Zustände, die von einem Startzustand aus nicht erreichbar sind und von denen aus kein Endzustand erreicht werden kann.

    **!reachable|!useful**
    : siehe unten ...

    **!(reachable&useful)**
    : Entfernt alle Zustände, die von einem Startzustand aus nicht erreichbar sind oder von denen aus kein Endzustand erreicht werden kann.


**::grammar::fa::op::determinize** *fa* ?*mapvar*?
: Macht den *fa* deterministisch, ohne die von dem *fa* akzeptierte Sprache zu ändern. Es erfolgt jedoch keine Aktion, wenn der *fa* bereits *deterministisch* ist. Dies bedeutet, dass nur die erste einer Reihe mehrerer aufeinanderfolgender determinize-Operationen am *fa* eine Aktion ausführt. Die übrigen Operationen sind Nulloperationen.

    Der Befehl speichert ein Dictionary, das die Beziehung zwischen den neuen Zuständen der resultierenden DFA und den Zuständen der Eingabe-NFA beschreibt, in *mapvar*, wenn dieses festgelegt wurde. Die Schlüssel des Dictionary sind die Handles für die Zustände der resultierenden DFA, die Werte sind Mengen von Zuständen aus der Eingabe-NFA.

    *Hinweis*: Ein leeres Dictionary signalisiert, dass der Befehl den *fa* deterministisch machen konnte, ohne eine vollständige Teilmengenkonstruktion durchzuführen, sondern lediglich durch das Entfernen von Zuständen und das Umordnen von Übergängen (als Teil der Epsilon-Freiheit des FA).

    *Hinweis*: Der Algorithmus kann die FA im technischen Sinne nicht deterministisch machen, wenn der FA keine Startzustände besitzt, da Determinismus erfordert, dass der FA genau einen Startzustand aufweist. In diesem Fall bemühen wir uns nach besten Kräften; der fehlende Startzustand ist dann die einzige Bedingung, die verhindert, dass das erzeugte Ergebnis *deterministisch* ist. Zu beachten ist außerdem, dass in diesem Fall die Möglichkeiten zum Entfernen von Zuständen aus dem FA ebenfalls stark eingeschränkt sind, da wir keine Zustände als unerreichbar deklarieren können.

**::grammar::fa::op::minimize** *fa* ?*mapvar*?
: Erzeugt einen FA, der dieselbe Sprache wie *fa* akzeptiert, jedoch eine minimale Anzahl von Zuständen aufweist. Dazu wird die Methode von Brzozowski verwendet.

    Der Befehl speichert ein Dictionary, das die Beziehung zwischen den neuen Zuständen der resultierenden minimalen FA und den Zuständen der Eingabe-FA beschreibt, in *mapvar*, wenn dies festgelegt wurde. Schlüssel des Dictionary sind die Handles für die Zustände der resultierenden minimalen FA, Werte sind Mengen von Zuständen aus der Eingabe-FA.

    *Hinweis*: Ein leeres Dictionary signalisiert, dass der Befehl den *fa* minimieren konnte, ohne neue Zustände berechnen zu müssen. Dies sollte genau dann der Fall sein, wenn die Eingabe-FA bereits minimal war.

    *Hinweis*: Wenn der Algorithmus keine Start- oder Endzustände hat, mit denen er arbeiten kann, ist das Ergebnis zwar technisch minimal, weist jedoch möglicherweise eine sehr unerwartete Struktur auf. Es ist zudem zu beachten, dass in diesem Fall die Möglichkeiten zum Entfernen von Zuständen aus dem FA erheblich eingeschränkt sind, da wir keine Zustände als unerreichbar deklarieren können.


*Sprachoperationen* Alle Operationen in diesem Abschnitt setzen voraus, dass alle Eingabe-FAs mindestens einen Start- und mindestens einen Endzustand aufweisen. Andernfalls ist die Sprache des FA nicht definiert, wodurch die Operation sinnlos wird (da sie auf definierte Weise auf den Sprachen der FAs operiert).

**::grammar::fa::op::complement** *fa*
: Bildet das Komplement von *fa*. Das ist genau dann möglich, wenn *fa* *complete* und *deterministic* ist. Die resultierende FA akzeptiert die komplementäre Sprache von *fa*. Mit anderen Worten: Alle Eingaben, die von *fa* nicht akzeptiert werden, werden von der resultierenden FA akzeptiert, und umgekehrt.

    Der resultierende Automat verfügt über alle Zustände und Übergänge des Eingabeautomaten sowie über andere Endzustände.

**::grammar::fa::op::kleene** *fa*
: Wendet den Kleene-Abschluss auf *fa* an. Der resultierende FA akzeptiert alle Zeichenfolgen **S**, für die wir eine natürliche Zahl **n** (einschließlich 0) und Zeichenfolgen **A1** … **An** in der Sprache von *fa* finden können, sodass **S** die Verkettung von **A1** … **An** ist. Mit anderen Worten: Die Sprache des Ergebnisses ist die unendliche Vereinigung aller Verkettungen endlicher Länge über der Sprache von *fa*.

    Das Ergebnis enthält alle Zustände und Übergänge der Eingabe sowie neue Start- und Endzustände.

**::grammar::fa::op::optional** *fa*
: Macht *fa* optional. Mit anderen Worten: Es berechnet den FA, der sowohl die Sprache von *fa* als auch das leere Wort (Epsilon) akzeptiert.

    Das Ergebnis enthält alle Zustände und Übergänge der Eingabe sowie neue Start- und Endzustände.

**::grammar::fa::op::union** *fa* *fb* ?*mapvar*?
: Kombiniert die endlichen Automaten *fa* und *fb* so, dass der resultierende endliche Automat die Vereinigung der Sprachen der beiden endlichen Automaten akzeptiert.

    Das Ergebnis enthält alle Zustände und Übergänge der beiden Eingabe-Automaten sowie neue Start- und Endzustände. Alle Zustände von *fb*, die auch in *fa* vorhanden sind, werden umbenannt, und die *mapvar* enthält eine Zuordnung von den alten Zuständen von *fb* zu den neuen, sofern vorhanden.

    Zu beachten ist, dass das Ergebnis nichtdeterministisch ist, selbst wenn die Eingaben deterministisch sind.

**::grammar::fa::op::intersect** *fa* *fb* ?*mapvar*?
: Kombiniert die endlichen Automaten *fa* und *fb* so, dass der resultierende endliche Automat die Schnittmenge der Sprachen der beiden endlichen Automaten akzeptiert. Mit anderen Worten: Das Ergebnis akzeptiert ein Wort genau dann, wenn es sowohl von *fa* als auch von *fb* akzeptiert wird. Das Ergebnis ist nützlich, jedoch nicht zwangsläufig deterministisch oder minimal.

    Der Befehl speichert ein Dictionary, das die Beziehung zwischen den neuen Zuständen der resultierenden FA und den Zustandspaaren der Eingabe-FAs beschreibt, in *mapvar*, wenn dieses festgelegt wurde. Schlüssel des Dictionary sind die Handles für die Zustände der resultierenden FA, Werte sind Zustandspaare aus den Eingabe-FAs. Paare werden durch Listen dargestellt. Das erste Element jedes Paares ist ein Zustand in *fa*, das zweite Element stammt aus *fb*.

**::grammar::fa::op::difference** *fa* *fb* ?*mapvar*?
: Kombiniert die endlichen Automaten *fa* und *fb* derart, dass der resultierende endliche Automat die Differenz der Sprachen der beiden endlichen Automaten akzeptiert. Mit anderen Worten: Das Ergebnis akzeptiert ein Wort genau dann, wenn das Wort von *fa* akzeptiert, von *fb* jedoch nicht akzeptiert wird. Dies lässt sich auch als Schnittmenge von *fa* mit dem Komplement von *fb* ausdrücken. Das Ergebnis ist zwar nützlich, aber nicht zwangsläufig deterministisch oder minimal.

    Der Befehl speichert ein Dictionary, das die Beziehung zwischen den neuen Zuständen der resultierenden FA und den Zustandspaaren der Eingabe-FAs beschreibt, in *mapvar*, wenn dies festgelegt wurde. Schlüssel des Dictionary sind die Handles für die Zustände der resultierenden FA, Werte sind Zustands-Paare aus den Eingabe-FAs. Paare werden durch Listen dargestellt. Das erste Element jedes Paares ist ein Zustand in *fa*, das zweite Element stammt aus *fb*.

**::grammar::fa::op::concatenate** *fa* *fb* ?*mapvar*?
: Kombiniert die endlichen Automaten *fa* und *fb* derart, dass der resultierende endliche Automat die Verkettung der Sprachen der beiden endlichen Automaten akzeptiert. Das heißt, ein Wort W wird von der resultierenden FA akzeptiert, wenn es zwei Wörter A und B gibt, die jeweils von *fa* bzw. *fb* akzeptiert werden, und W die Verkettung von A und B ist.

    Die resultierende FA ist nichtdeterministisch.

**::grammar::fa::op::fromRegex** *fa* *regex* ?*over*?
: Erzeugt einen nichtdeterministischen endlichen Automaten (FA), der dieselbe Sprache akzeptiert wie der reguläre Ausdruck *regex*. Wenn *over* festgelegt wird, wird dieser als die Menge der Symbole behandelt, über die der reguläre Ausdruck und der Automat definiert sind. Der Befehl berechnet die Menge aus den „S“-Konstruktoren in *regex*, wenn *over* nicht angegeben wurde. Diese Menge ist genau dann von Bedeutung, wenn der Komplementoperator „!“ in *regex* verwendet wird, da sich die Komplementsprache eines FA je nach Symbolmenge erheblich unterscheidet.

    Der reguläre Ausdruck wird durch eine verschachtelte Liste dargestellt, die einen Syntaxbaum bildet. Folgende Strukturen sind zulässig:

    {S x}
    : Atomare reguläre Ausdrücke. Alle anderen Ausdrücke werden daraus gebildet. Akzeptiert das **S**ymbol „x“.

    {. A1 A2 ...}
    : Verkettungsoperator. Akzeptiert die Verkettung der regulären Ausdrücke **A1**, **A2** usw.

        *Hinweis*: Dieser Operator akzeptiert null oder mehr Argumente. Bei null Argumenten ist die dargestellte Sprache *epsilon*, das leere Wort.

    {| A1 A2 ...}
    : Auswahloperator, auch „Alternative“ genannt. Akzeptiert alle Eingaben, die von mindestens einem der regulären Ausdrücke **A1**, **A2** usw. akzeptiert werden. Mit anderen Worten: die Vereinigung von **A1** und **A2**.

        *Hinweis*: Dieser Operator akzeptiert null oder mehr Argumente. Bei null Argumenten ist die dargestellte Sprache die Sprache *empty*, die Sprache ohne Wörter.

    {& A1 A2 ...}
    : Schnittoperator, logisches und. Akzeptiert alle Eingaben, die von allen regulären Ausdrücken **A1**, **A2** usw. akzeptiert werden. Mit anderen Worten: die Schnittmenge von **A1** und **A2**.

    {? A}
    : Optionalitätsoperator. Akzeptiert das leere Wort sowie alle Elemente aus dem regulären Ausdruck **A**.

    {\* A}
    : Kleene-Abschluss. Akzeptiert das leere Wort sowie jede endliche Verkettung von Wörtern, die vom regulären Ausdruck **A** akzeptiert werden.

    {+ A}
    : Positiver Kleene-Abschluss. Akzeptiert jede endliche Verkettung von Wörtern, die vom regulären Ausdruck **A** akzeptiert werden, jedoch nicht das leere Wort.

    {! A}
    : Komplement-Operator. Akzeptiert jedes Wort, das vom regulären Ausdruck **A** nicht akzeptiert wird. Beachten Sie, dass das Komplement von der Symbolmenge abhängt, über die das Ergebnis laufen soll. Siehe dazu die Erläuterung zum Argument *over* weiter oben.


**::grammar::fa::op::toRegexp** *fa*
: Dieser Befehl generiert und gibt einen regulären Ausdruck zurück, der dieselbe Sprache akzeptiert wie der endliche Automat *fa*. Der reguläre Ausdruck hat das oben beschriebene Format, wie es für **::grammar::fa::op::fromRegex** gilt.

**::grammar::fa::op::toRegexp2** *fa*
: Dieser Befehl verfügt über dieselbe Funktionalität wie **::grammar::fa::op::toRegexp**, verwendet jedoch einen anderen Algorithmus, um die generierten regulären Ausdrücke zu vereinfachen.

**::grammar::fa::op::toTclRegexp** *regexp* *symdict*
: Dieser Befehl generiert und gibt einen regulären Ausdruck in Tcl-Syntax für den regulären Ausdruck *regexp* zurück, sofern dies möglich ist. *regexp* hat dasselbe Format, wie es von **::grammar::fa::op::fromRegex** erwartet wird.

    Der Befehl schlägt fehl und löst einen Fehler aus, wenn *regexp* Komplementierungs- und Schnittoperationen enthält.

    Das Argument *symdict* ist ein Dictionary, das Symbolnamen Paaren aus *syntaktischem Typ* und Tcl-Regexp zuordnet. Wenn ein in *regexp* vorkommendes Symbol nicht in diesem Dictionary aufgeführt ist, werden Ein-Zeichen-Symbole so interpretiert, dass sie sich selbst bezeichnen, während Mehrzeichen-Symbole als Name einer Zeichenklasse betrachtet werden.

**::grammar::fa::op::simplifyRegexp** *regexp*
: Dieser Befehl vereinfacht einen regulären Ausdruck, indem er den folgenden Algorithmus zunächst auf den Hauptausdruck und anschließend rekursiv auf alle Teilausdrücke anwendet:

    1. Wandeln Sie den Ausdruck in einen endlichen Automaten um.

    2. Minimieren Sie den Automaten.

    3. Wandeln Sie den Automaten wieder in einen regulären Ausdruck um.

    4. Wählen Sie den kürzeren der beiden Ausdrücke aus: den ursprünglichen Ausdruck oder den Ausdruck aus dem vorherigen Schritt.



# Beispiele

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *grammar\_fa* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Grammatiken und endliche Automaten

# Copyright

```
Copyright (c) 2004-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
