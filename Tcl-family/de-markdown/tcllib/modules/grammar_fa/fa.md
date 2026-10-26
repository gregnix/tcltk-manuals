---
CommandName: grammar::fa
title: grammar::fa
ManualSection: n
Version: 0.6
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
 - Copyright (c) 2004-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

grammar::fa – Erstellen und Bearbeiten endlicher Automaten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.3]{.lit}
[package]{.cmd} [require]{.sub} [struct::list]{.lit}
[package]{.cmd} [require]{.sub} [struct::set]{.lit}
[package]{.cmd} [require]{.sub} [grammar::fa::op]{.lit} [0.3]{.optlit}
[package]{.cmd} [require]{.sub} [grammar::fa]{.lit} [0.6]{.optlit}
[::grammar::fa]{.cmd} [faName]{.arg} [[=|:=|<--|as|deserialize]{.lit} [src|fromRegex]{.arg} [re]{.arg} [over]{.optarg}]{.optarg}
[faName]{.cmd} [option]{.arg} [arg arg]{.optdot}
[faName]{.ins} [destroy]{.sub}
[faName]{.ins} [clear]{.sub}
[faName]{.ins} [=]{.sub} [srcFA]{.arg}
[faName]{.ins} [-->]{.sub} [dstFA]{.arg}
[faName]{.ins} [serialize]{.sub}
[faName]{.ins} [deserialize]{.sub} [serialization]{.arg}
[faName]{.ins} [states]{.sub}
[faName]{.ins} [state]{.sub} [add]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [state]{.sub} [delete]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [state]{.sub} [exists]{.lit} [s]{.arg}
[faName]{.ins} [state]{.sub} [rename]{.lit} [s]{.arg} [snew]{.arg}
[faName]{.ins} [startstates]{.sub}
[faName]{.ins} [start]{.sub} [add]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [start]{.sub} [remove]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [start?]{.sub} [s]{.arg}
[faName]{.ins} [start?set]{.sub} [stateset]{.arg}
[faName]{.ins} [finalstates]{.sub}
[faName]{.ins} [final]{.sub} [add]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [final]{.sub} [remove]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [final?]{.sub} [s]{.arg}
[faName]{.ins} [final?set]{.sub} [stateset]{.arg}
[faName]{.ins} [symbols]{.sub}
[faName]{.ins} [symbols@]{.sub} [s]{.arg} [d]{.optarg}
[faName]{.ins} [symbols@set]{.sub} [stateset]{.arg}
[faName]{.ins} [symbol]{.sub} [add]{.lit} [sym1]{.arg} [sym2]{.optdot}
[faName]{.ins} [symbol]{.sub} [delete]{.lit} [sym1]{.arg} [sym2]{.optdot}
[faName]{.ins} [symbol]{.sub} [rename]{.lit} [sym]{.arg} [newsym]{.arg}
[faName]{.ins} [symbol]{.sub} [exists]{.lit} [sym]{.arg}
[faName]{.ins} [next]{.sub} [s]{.arg} [sym]{.arg} [[-->]{.lit} [next]{.arg}]{.optarg}
[faName]{.ins} [!next]{.sub} [s]{.arg} [sym]{.arg} [[-->]{.lit} [next]{.arg}]{.optarg}
[faName]{.ins} [nextset]{.sub} [stateset]{.arg} [sym]{.arg}
[faName]{.ins} [is]{.sub} [deterministic]{.lit}
[faName]{.ins} [is]{.sub} [complete]{.lit}
[faName]{.ins} [is]{.sub} [useful]{.lit}
[faName]{.ins} [is]{.sub} [epsilon-free]{.lit}
[faName]{.ins} [reachable\_states]{.sub}
[faName]{.ins} [unreachable\_states]{.sub}
[faName]{.ins} [reachable]{.sub} [s]{.arg}
[faName]{.ins} [useful\_states]{.sub}
[faName]{.ins} [unuseful\_states]{.sub}
[faName]{.ins} [useful]{.sub} [s]{.arg}
[faName]{.ins} [epsilon\_closure]{.sub} [s]{.arg}
[faName]{.ins} [reverse]{.sub}
[faName]{.ins} [complete]{.sub}
[faName]{.ins} [remove\_eps]{.sub}
[faName]{.ins} [trim]{.sub} [what]{.optarg}
[faName]{.ins} [determinize]{.sub} [mapvar]{.optarg}
[faName]{.ins} [minimize]{.sub} [mapvar]{.optarg}
[faName]{.ins} [complement]{.sub}
[faName]{.ins} [kleene]{.sub}
[faName]{.ins} [optional]{.sub}
[faName]{.ins} [union]{.sub} [fa]{.arg} [mapvar]{.optarg}
[faName]{.ins} [intersect]{.sub} [fa]{.arg} [mapvar]{.optarg}
[faName]{.ins} [difference]{.sub} [fa]{.arg} [mapvar]{.optarg}
[faName]{.ins} [concatenate]{.sub} [fa]{.arg} [mapvar]{.optarg}
[faName]{.ins} [fromRegex]{.sub} [regex]{.arg} [over]{.optarg}
:::

# Beschreibung

Dieses Paket stellt eine Containerklasse für *endliche Automaten* (kurz: FA) bereit. Es ermöglicht die schrittweise Definition des Automaten, dessen Bearbeitung sowie die Abfrage der Definition. Das Paket bietet zwar komplexe Operationen auf dem Automaten (über das Paket **grammar::fa::op**), verfügt jedoch nicht über die Möglichkeit, eine Definition für einen Symbolstrom auszuführen. Verwenden Sie hierfür die Pakete **grammar::fa::dacceptor** und **grammar::fa::dexec**. Ein weiteres damit verbundenes Paket ist **grammar::fa::compiler**. Es wandelt eine endliche Automatik (FA) in eine Ausführungsklasse um, in die die Definition der FA fest integriert ist. Die Ausgabe dieses Pakets lässt sich so konfigurieren, dass sie einer Vielzahl unterschiedlicher Implementierungssprachen und Paradigmen gerecht wird.

Weitere Informationen darüber, was ein endlicher Automat ist, finden Sie im Abschnitt [Endliche Automaten].

# API

Das Paket exportiert die hier beschriebene API.

**::grammar::fa** *faName* ?**=**|**:=**|**<--**|**as**|**deserialize** *src*|**fromRegex** *re* ?*over*??
: Erstellt einen neuen endlichen Automaten mit einem zugehörigen globalen Tcl-Befehl, dessen Name *faName* lautet. Mit diesem Befehl lassen sich verschiedene Operationen auf dem Automaten ausführen. Er hat die folgende allgemeine Form:

    **faName** *option* ?*arg arg ...*?
    : *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Weitere Erläuterungen finden Sie im Abschnitt [FA-Methoden]. Der neue Automat ist leer, wenn kein *src* angegeben wird. Andernfalls enthält er eine Kopie der in *src* enthaltenen Definition. *src* muss bei allen Operatoren mit Ausnahme von **deserialize** und **fromRegex** eine FA-Objektreferenz sein. Der Operator **deserialize** erfordert stattdessen, dass *src* die Serialisierung eines FA ist, und **fromRegex** erwartet einen regulären Ausdruck in Form eines Syntaxbaums. Weitere Einzelheiten hierzu finden Sie unter [::grammar::fa::op::fromRegex][faop].



# FA-Methoden

Alle Automaten stellen die folgenden Methoden zu ihrer Steuerung bereit:

*faName* **destroy**
: Löscht den Automaten einschließlich seines Speicherplatzes und des zugehörigen Befehls.

*faName* **clear**
: Löscht die in *faName* enthaltene Definition des Automaten, zerstört das Objekt jedoch *nicht*.

*faName* **=** *srcFA*
: Weist *faName* den Inhalt des in *srcFA* enthaltenen Automaten zu und überschreibt dabei etwaige bereits vorhandene Definitionen. Dies ist der Zuweisungsoperator für Automaten. Er kopiert den im FA-Objekt *srcFA* enthaltenen Automaten über die Automaten-Definition in *faName*. Der bisherige Inhalt von *faName* wird durch diesen Vorgang gelöscht.

    Dieser Vorgang entspricht im Wesentlichen

    ```
        faName deserialize [srcFA serialize]
    ```

*faName* **-->** *dstFA*
: Dies ist der umgekehrte Zuweisungsoperator für Automaten. Er kopiert die im Objekt *faName* enthaltene Automatisierung in die Automatendefinition des Objekts *dstFA*. Der bisherige Inhalt von *dstFA* wird durch diesen Vorgang gelöscht.

    Dieser Vorgang entspricht im Wesentlichen

    ```
        dstFA deserialize [faName serialize]
    ```

*faName* **serialize**
: Diese Methode serialisiert den in *faName* gespeicherten Automaten. Mit anderen Worten: Sie gibt einen Tcl-*Wert* zurück, der diesen Automaten vollständig beschreibt. Dies ermöglicht beispielsweise die Übertragung von Automaten über beliebige Kanäle, Persistenz usw. Diese Methode bildet zudem die Grundlage sowohl für den Kopier-Konstruktor als auch für den Zuweisungsoperator.

    Das Ergebnis dieser Methode muss über alle Implementierungen der Schnittstelle **grammar::fa** hinweg semantisch identisch sein. Dies ermöglicht es uns, Automaten zwischen verschiedenen Implementierungen derselben Schnittstelle zu kopieren.

    Das Ergebnis ist eine Liste mit drei Elementen, die folgende Struktur aufweist:

    1. Die Konstante „**grammar::fa**“.

    2. Eine Liste, die die Namen aller bekannten Eingabesymbole enthält. Die Reihenfolge der Elemente in dieser Liste spielt keine Rolle.

    3. Der letzte Eintrag in der Liste ist ein Dictionary, wobei jedoch auch die Reihenfolge der Schlüssel von Bedeutung ist. Die Schlüssel sind die Zustände der serialisierten FA, und ihre Reihenfolge entspricht der Reihenfolge, in der die Zustände bei der Deserialisierung erstellt werden sollen. Dies ist wichtig, um die Reihenfolgebeziehung zwischen den Zuständen beizubehalten.

        Der Wert jedes Wörterbucheintrags ist eine Liste aus drei Elementen, die den Zustand detaillierter beschreiben.

        1. Ein boolescher Flag. Wenn sein Wert **true** lautet, handelt es sich um einen Startzustand; andernfalls ist dies nicht der Fall.

        2. Ein boolescher Flag. Wenn sein Wert „**true**“ lautet, handelt es sich um einen Endzustand; andernfalls ist dies nicht der Fall.

        3. Das letzte Element ist ein Dictionary, das die Übergänge für den Zustand beschreibt. Die Schlüssel sind Symbole (oder die leere Zeichenkette), und die Werte sind Mengen von Nachfolgezuständen.



    Angenommen, es handelt sich um die folgende FA (die das Leben eines Lkw-Treibers auf sehr einfache Weise beschreibt :)

    ```
        Drive -- yellow --> Brake -- red --> (Stop) -- red/yellow --> Attention -- green --> Drive
        (...) is the start state.
    ```

    Eine mögliche Serialisierung lautet

    ```
        grammar::fa \
        {yellow red green red/yellow} \
        {Drive     {0 0 {yellow     Brake}} \
         Brake     {0 0 {red        Stop}} \
         Stop      {1 0 {red/yellow Attention}} \
         Attention {0 0 {green      Drive}}}
    ```

    Eine mögliche Variante, da mir die Reihenfolge der Erstellung hier nicht wichtig war

*faName* **deserialize** *serialization*
: Dies ist die Ergänzung zu **serialize**. Sie ersetzt die Automatdefinition in *faName* durch den durch den Wert *serialization* beschriebenen Automaten. Der bisherige Inhalt von *faName* wird durch diesen Vorgang gelöscht.

*faName* **states**
: Gibt die Menge aller Zustände zurück, die *faName* bekannt sind.

*faName* **state** **add** *s1* ?*s2* ...?
: Fügt die Zustände *s1*, *s2* usw. zur FA-Definition in *faName* hinzu. Der Vorgang schlägt fehl, wenn einer der neuen Zustände bereits deklariert ist.

*faName* **state** **delete** *s1* ?*s2* ...?
: Löscht die Zustände *s1*, *s2* usw. sowie alle zugehörigen Informationen aus der FA-Definition in *faName*. Letzteres bedeutet, dass auch die Informationen zu eingehenden und ausgehenden Übergängen gelöscht werden. Wenn es sich bei dem gelöschten Zustand um einen Start- oder Endzustand handelt, werden diese Informationen ebenfalls ungültig gemacht. Der Vorgang schlägt fehl, wenn der Zustand *s* der FA nicht bekannt ist.

*faName* **state** **exists** *s*
: Ein Prädikat. Es prüft, ob der Zustand *s* der FA in *faName* bekannt ist. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn der Zustand *s* bekannt ist, andernfalls auf **false**.

*faName* **state** **rename** *s* *snew*
: Benennt den Zustand *s* in *snew* um. Der Vorgang schlägt fehl, wenn *s* kein bekannter Zustand ist. Der Vorgang schlägt ebenfalls fehl, wenn *snew* bereits als Zustand bekannt ist.

*faName* **startstates**
: Gibt die Menge der Zustände zurück, die als *start*-Zustände gekennzeichnet sind, auch als *initial*-Zustände bezeichnet. Was das bedeutet, steht unter [Endliche Automaten].

*faName* **start** **add** *s1* ?*s2* ...?
: Kennzeichnet die Zustände *s1*, *s2* usw. im FA *faName* als *start* (auch *initial*).

*faName* **start** **remove** *s1* ?*s2* ...?
: Kennzeichnet die Zustände *s1*, *s2* usw. in der FA *faName* als *not start* (auch *not accepting*).

*faName* **start?** *s*
: Ein Prädikat. Es testet, ob der Zustand *s* in der Finiten Automat *faName* den Wert *start* hat oder nicht. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn der Zustand *s* *start* ist, andernfalls auf **false**.

*faName* **start?set** *stateset*
: Ein Prädikat. Es prüft, ob die Menge der Zustände *stateset* mindestens einen Startzustand enthält. Die Operation schlägt fehl, wenn die Menge ein Element enthält, das kein bekannter Zustand ist. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn in *stateset* ein Startzustand vorhanden ist, andernfalls auf **false**.

*faName* **finalstates**
: Gibt die Menge der Zustände zurück, die als *final*-Zustände gekennzeichnet sind, auch als *accepting*-Zustände bezeichnet. Was das bedeutet, steht unter [Endliche Automaten].

*faName* **final** **add** *s1* ?*s2* ...?
: Kennzeichnet die Zustände *s1*, *s2* usw. im FA *faName* als *final* (auch *accepting*).

*faName* **final** **remove** *s1* ?*s2* ...?
: Kennzeichnet die Zustände *s1*, *s2* usw. in der FA *faName* als *not final* (auch *not accepting*).

*faName* **final?** *s*
: Ein Prädikat. Es testet, ob der Zustand *s* in der FA *faName* *final* ist oder nicht. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn der Zustand *s* *final* ist, andernfalls auf **false**.

*faName* **final?set** *stateset*
: Ein Prädikat. Es prüft, ob die Menge der Zustände *stateset* mindestens einen Endzustand enthält. Die Operation schlägt fehl, wenn die Menge ein Element enthält, das kein bekannter Zustand ist. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn in *stateset* ein Endzustand vorhanden ist, andernfalls auf **false**.

*faName* **symbols**
: Gibt die Menge aller Symbole zurück, die der FA *faName* bekannt sind.

*faName* **symbols@** *s* ?*d*?
: Gibt die Menge aller Symbole zurück, für die der Zustand *s* Übergänge aufweist. Wenn das leere Symbol vorhanden ist, so weist *s* Epsilon-Übergänge auf. Wenn zwei Zustände festgelegt werden, so ist das Ergebnis die Menge der Symbole, für die Übergänge von *s* nach *t* bestehen. Diese Menge kann leer sein, wenn zwischen den beiden festgelegten Zuständen keine Übergänge bestehen.

*faName* **symbols@set** *stateset*
: Gibt die Menge aller Symbole zurück, für die mindestens ein Zustand in der Zustandsmenge *stateset* Übergänge aufweist. Mit anderen Worten: die Vereinigung von \[*faName* **symbols@** **s**\] für alle Zustände **s** in *stateset*. Wenn das leere Symbol vorhanden ist, so weist mindestens ein in *stateset* enthaltener Zustand Epsilon-Übergänge auf.

*faName* **symbol** **add** *sym1* ?*sym2* ...?
: Fügt die Symbole *sym1*, *sym2* usw. zur FA-Definition in *faName* hinzu. Der Vorgang schlägt fehl, wenn eines der Symbole bereits deklariert ist. Die leere Zeichenkette ist als Wert für die Symbole nicht zulässig.

*faName* **symbol** **delete** *sym1* ?*sym2* ...?
: Löscht die Symbole *sym1*, *sym2* usw. sowie alle zugehörigen Informationen aus der FA-Definition in *faName*. Letzteres bedeutet, dass auch alle Übergänge, die diese Symbole verwenden, gelöscht werden. Der Vorgang schlägt fehl, wenn eines der Symbole der FA nicht bekannt ist.

*faName* **symbol** **rename** *sym* *newsym*
: Benennt das Symbol *sym* in *newsym* um. Der Vorgang schlägt fehl, wenn *sym* kein bekanntes Symbol ist. Der Vorgang schlägt ebenfalls fehl, wenn *newsym* bereits als Symbol bekannt ist.

*faName* **symbol** **exists** *sym*
: Ein Prädikat. Es prüft, ob das Symbol *sym* der FA in *faName* bekannt ist. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn das Symbol *sym* bekannt ist, andernfalls auf **false**.

*faName* **next** *s* *sym* ?**-->** *next*?
: Definiert Übergangsinformationen oder fragt sie ab.

    Wenn *next* angegeben wird, fügt die Methode dem in *faName* enthaltenen FA einen Übergang vom Zustand *s* zum *successor*-Zustand *next* hinzu, der mit dem Symbol *sym* beschriftet ist. Der Vorgang schlägt fehl, wenn *s* oder *next* keine bekannten Zustände sind oder wenn *sym* kein bekanntes Symbol ist. Eine Ausnahme von Letzterem besteht darin, dass *sym* die leere Zeichenkette sein darf. In diesem Fall handelt es sich bei dem neuen Übergang um einen *Epsilon-Übergang*, der beim Durchlaufen keine Eingabe verbraucht. Die Operation schlägt ebenfalls fehl, wenn die Kombination aus (*s*, *sym* und *next*) bereits in der FA vorhanden ist.

    Wurde *next* nicht angegeben, gibt die Methode die Menge der Zustände zurück, die von *s* aus über einen einzigen, mit dem Symbol *sym* beschrifteten Übergang erreicht werden können.

*faName* **!next** *s* *sym* ?**-->** *next*?
: Entfernt einen oder mehrere Übergänge aus der FA in *faName*.

    Wenn *next* angegeben wurde, wird der einzelne Übergang vom Zustand *s* zum Zustand *next*, der mit dem Symbol *sym* beschriftet ist, aus der FA entfernt. Andernfalls werden *all* Übergänge entfernt, die vom Zustand *s* ausgehen und mit dem Symbol *sym* beschriftet sind.

    Die Operation schlägt fehl, wenn *s* und/oder *next* nicht als Zustände bekannt sind. Sie schlägt ebenfalls fehl, wenn ein nicht leerer Wert für *sym* nicht als Symbol bekannt ist. Die leere Zeichenkette ist zulässig und ermöglicht das Entfernen von Epsilon-Übergängen.

*faName* **nextset** *stateset* *sym*
: Gibt die Menge der Zustände zurück, die durch einen einzelnen Übergang erreicht werden können, der von einem Zustand aus der Menge *stateset* ausgeht und mit dem Symbol *sym* beschriftet ist.

    Mit anderen Worten: Dies ist die Vereinigung von \[*faName* next **s** *symbol*\] für alle Zustände **s** in *stateset*.

*faName* **is** **deterministic**
: Ein Prädikat. Es prüft, ob es sich bei der FA in *faName* um eine deterministische FA handelt oder nicht. Der Wert ist boolesch. Er wird auf **true** gesetzt, wenn die FA deterministisch ist, andernfalls auf **false**.

*faName* **is** **complete**
: Ein Prädikat. Es prüft, ob die FA in *faName* eine vollständige FA ist oder nicht. Eine FA ist vollständig, wenn sie mindestens einen Übergang pro Zustand und Symbol aufweist. Dies bedeutet auch, dass eine FA ohne Symbole oder Zustände ebenfalls vollständig ist. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn die FA vollständig ist, und andernfalls auf **false**.

    Hinweis: Wenn eine FA Epsilon-Übergänge aufweist, können Übergänge über ein Symbol für einen Zustand S indirekt sein, d. h. nicht direkt an S, sondern an einen Zustand in der Epsilon-Hülle von S gekoppelt sein. Die Symbole für solche indirekten Übergänge werden bei der Berechnung der Vollständigkeit berücksichtigt.

*faName* **is** **useful**
: Ein Prädikat. Es testet, ob die FA in *faName* eine nützliche FA ist oder nicht. Eine FA gilt als nützlich, wenn alle Zustände *reachable* und *useful* sind. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn die FA nützlich ist, andernfalls auf **false**.

*faName* **is** **epsilon-free**
: Ein Prädikat. Es führt Tests durch, um zu prüfen, ob die FA in *faName* eine epsilonfreie FA ist oder nicht. Ein FA ist epsilonfrei, wenn es keine Epsilon-Übergänge aufweist. Diese Definition bedeutet, dass alle deterministischen FAs ebenfalls epsilonfrei sind und dass Epsilonfreiheit eine notwendige Voraussetzung für Deterministik ist. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn die FA epsilonfrei ist, und andernfalls auf **false**.

*faName* **reachable\_states**
: Gibt die Menge der Zustände zurück, die von einem Startzustand aus über einen oder mehrere Übergänge erreichbar sind.

*faName* **unreachable\_states**
: Gibt die Menge der Zustände zurück, die von keinem Startzustand aus durch eine beliebige Anzahl von Übergängen erreichbar sind. Dies ist

    ```
    	 [faName states] - [faName reachable_states]
    ```

*faName* **reachable** *s*
: Ein Prädikat. Es führt Tests durch, um zu prüfen, ob der Zustand *s* in der endlichen Automat *faName* von einem Startzustand aus über einen oder mehrere Übergänge erreicht werden kann. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn der Zustand erreichbar ist, und andernfalls auf **false**.

*faName* **useful\_states**
: Gibt die Menge der Zustände zurück, die einen Endzustand über einen oder mehrere Übergänge erreichen können.

*faName* **unuseful\_states**
: Gibt die Menge der Zustände zurück, die durch keine beliebige Anzahl von Übergängen einen Endzustand erreichen können. Dies ist

    ```
    	 [faName states] - [faName useful_states]
    ```

*faName* **useful** *s*
: Ein Prädikat. Es führt Tests durch, um zu prüfen, ob der Zustand *s* im endlichen Automaten *faName* über eine oder mehrere Übergänge einen Endzustand erreichen kann. Das Ergebnis ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn der Zustand brauchbar ist, andernfalls auf **false**.

*faName* **epsilon\_closure** *s*
: Gibt die Menge der Zustände zurück, die vom Zustand *s* im FA *faName* über einen oder mehrere Epsilon-Übergänge erreichbar sind, d. h. Übergänge über das leere Symbol, also Übergänge, bei denen keine Eingabe verbraucht wird. Dies wird als *Epsilon-Abschluss* von *s* bezeichnet.

*faName* **reverse**
: siehe unten ...

*faName* **complete**
: siehe unten ...

*faName* **remove\_eps**
: siehe unten ...

*faName* **trim** ?*what*?
: siehe unten ...

*faName* **determinize** ?*mapvar*?
: siehe unten ...

*faName* **minimize** ?*mapvar*?
: siehe unten ...

*faName* **complement**
: siehe unten ...

*faName* **kleene**
: siehe unten ...

*faName* **optional**
: siehe unten ...

*faName* **union** *fa* ?*mapvar*?
: siehe unten ...

*faName* **intersect** *fa* ?*mapvar*?
: siehe unten ...

*faName* **difference** *fa* ?*mapvar*?
: siehe unten ...

*faName* **concatenate** *fa* ?*mapvar*?
: siehe unten ...

*faName* **fromRegex** *regex* ?*over*?
: Diese Methoden ermöglichen komplexere Operationen mit der FA. Eine Beschreibung ihrer Funktionsweise finden Sie unter den gleichnamigen Befehlen im Paket **grammar::fa::op**.


# Beispiele

# Endliche Automaten

Für mathematisch Interessierte: Eine FA ist ein 5-Tupel (S, Sy, St, Fi, T), wobei

- S ist eine Menge von *states*,

- Sy ist eine Menge von *input symbols*,

- St ist eine Teilmenge von S, die Menge der *start*-Zustände, auch *initial*-Zustände genannt.

- Fi ist eine Teilmenge von S, die Menge der *final*-Zustände, auch *accepting* genannt.

- T ist eine Funktion von S x (Sy + epsilon) nach {S}, die *Übergangsfunktion*. Hier bezeichnet **epsilon** das leere Eingabesymbol und unterscheidet sich von allen Symbolen in Sy; und {S} ist die Menge der Teilmengen von S. Mit anderen Worten: T bildet eine Kombination aus Zustand und Eingabe (die leer sein kann) auf eine Menge von *successor states* ab.


In der Informatik wird ein FA meist als Graph dargestellt, in dem die Knoten die Zustände repräsentieren und die Kanten zwischen den Knoten die Übergangsfunktion kodieren: Für alle n in S' = T (s, sy) gibt es je eine Kante zwischen den Knoten, die s bzw. n darstellen, beschriftet mit sy. Die Start- und Akzeptanzzustände werden durch unterschiedliche visuelle Markierungen kodiert, das heißt, sie sind Attribute der Knoten.

FAs verarbeiten Symbolströme über Sy.

Von einem bestimmten FA sagt man, er *accept* einen endlichen Strom sy\_1 sy\_2 ... sy\_n, wenn es im Graphen des FA einen Pfad gibt, der in einem Zustand in St beginnt und in einem Zustand in Fi endet und dessen Kanten die Beschriftungen sy\_1, sy\_2 usw. bis sy\_n tragen. Die Menge aller von der FA akzeptierten Zeichenketten ist die *language* der FA. Eine wichtige Äquivalenz ist, dass die Menge der Sprachen, die ein FA akzeptieren kann, die Menge der *regular languages* ist.

Ein weiteres wichtiges Konzept sind deterministische FAs. Ein FA heißt *deterministic*, wenn es für jede Zeichenkette aus Eingabesymbolen genau einen Pfad im Graphen des FA gibt, der im Startzustand beginnt und dessen Kanten mit den Symbolen der Zeichenkette beschriftet sind. Auch wenn es so scheinen mag, dass nichtdeterministische FAs mehr Erkennungskraft haben, ist das nicht der Fall. Zu jedem nichtdeterministischen FA lässt sich ein deterministischer FA konstruieren, der dieselbe Sprache akzeptiert (--> Thompson's subset construction).

Eine der wichtigsten Anwendungen von FAs liegt im *parsing*, besonders in der *lexer*-Stufe (wo Symbole == Zeichen sind), aber das ist bei weitem nicht die einzige.

Zahlreiche Prozesse lassen sich als FA modellieren, wenn auch mit einer möglicherweise großen Menge von Zuständen. Für diese ist der Begriff der Akzeptanzzustände oft weniger oder gar nicht relevant. Stattdessen ist die Fähigkeit erforderlich, auf Zustandsänderungen in der FA zu reagieren, d. h. als Reaktion auf die Eingabe eine Ausgabe zu erzeugen. Das macht aus einem FA einen *finite transducer*, der eine zusätzliche Menge OSy von *output symbols* und eine zusätzliche *output function* O hat, die von "S x (Sy + epsilon)" auf "(Osy + epsilon)" abbildet, d. h. von einer Kombination aus Zustand und Eingabe – die möglicherweise leer ist – auf ein Ausgabesymbol oder nichts.

Für die Graphdarstellung bedeutet dies, dass Kanten zusätzlich mit dem Ausgabesymbol beschriftet werden, das geschrieben werden soll, wenn diese Kante beim Abgleichen der Eingabe durchlaufen wird. Hinweis: In einer Anwendung bedeutet das „Schreiben eines Ausgabesymbols“ auch das „Ausführen von Code“.

Transducer werden von diesem Paket nicht behandelt. Sie werden in Zukunft ein eigenes Paket erhalten.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *grammar\_fa* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Grammatiken und endliche Automaten

# Copyright

```
Copyright (c) 2004-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[faop]: faop.md
