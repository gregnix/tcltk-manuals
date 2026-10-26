---
CommandName: struct::disjointset
title: struct::disjointset
ManualSection: n
Version: 1.2
TclPart: tcllib
TclDescription: Tcl Data Structures
Links:
 - http://en.wikipedia.org/wiki/Disjoint_set_data_structure
Keywords:
 - disjoint set
 - equivalence class
 - find
 - merge find
 - partition
 - partitioned set
 - union
Copyright:
---

# Name

struct::disjointset – Datenstruktur „Disjunkte Menge“

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::disjointset]{.lit} [1.2]{.optlit}
[::struct::disjointset]{.cmd} [aDisjointSet]{.arg}
[aDisjointSet]{.ins} [add-element]{.sub} [element]{.arg}
[aDisjointSet]{.ins} [add-partition]{.sub} [elements]{.arg}
[aDisjointSet]{.ins} [partitions]{.sub}
[aDisjointSet]{.ins} [num-partitions]{.sub}
[aDisjointSet]{.ins} [equal]{.sub} [a]{.arg} [b]{.arg}
[aDisjointSet]{.ins} [merge]{.sub} [a]{.arg} [b]{.arg}
[aDisjointSet]{.ins} [find]{.sub} [element]{.arg}
[aDisjointSet]{.ins} [exemplars]{.sub}
[aDisjointSet]{.ins} [find-exemplar]{.sub} [element]{.arg}
[aDisjointSet]{.ins} [destroy]{.sub}
:::

# Beschreibung

Dieses Paket enthält einen Befehl zur Verarbeitung von [disjunkten Mengen](http://en.wikipedia.org/wiki/Disjoint_set_data_structure). Alternative Namen für diese Art von Datenstruktur sind *union-find* und *merge-find*.

Ein häufiger Anwendungsfall für gewöhnliche Mengen ist die Beantwortung der Frage: „Enthält die Menge S das Element E?“. Die Antwort ist ein einfacher Boolescher Wert.

Ein häufiger Anwendungsfall für disjunkte Mengen ist die Beantwortung der Frage: „Welche der Mengen S₁, S₂, …, Sₙ enthält das Element E?“. Die Antwort ist eine Menge – oder nichts, falls keine der Mengen E enthält.

Ein weiterer häufiger Anwendungsfall für disjunkte Mengen ist die Möglichkeit, zwei Mengen schnell zu einer einzigen zusammenzuführen, wobei die resultierende Menge weiterhin eine schnelle Suche nach Elementen ermöglicht. Daher der Begriff *Merge-Find*.

Der Grund, warum diese Datenstruktur als *disjunkte Menge* bezeichnet wird, liegt darin, dass sie als *eine einzige* Menge mit *Partitionen* betrachtet werden kann. Mit anderen Worten: Eine disjunkte Menge ist:

- eine endliche *Menge* S, die enthält

- eine Reihe von *Elementen* E₁, E₂, …, Eₙ, gruppiert in

- eine Menge von *Partitionen* P₁, P₂, …, Pₙ. Der letztgenannte Begriff trifft zu, da die Schnittmenge jedes Paares Pᵢ, Pⱼ von Partitionen leer ist, d. h.,  ∅ = Pᵢ ∩ Pⱼ, wobei die Menge selbst der Vereinigung aller Partitionen entspricht, d. h., S = P₁ ∪ P₂ ∪ … ∪ Pₙ.


Ein alternativer Name für die *Partitionen* wäre *Äquivalenzklassen*, wobei alle Elemente derselben Klasse als gleich angesehen werden. Hier ist eine grafische Darstellung der oben aufgeführten Konzepte:

```
	+-----------------+ The outer lines are the boundaries of the set S.
	|           /     | The inner regions delineated by the diagonal
	|  *       /   *  | lines are the partitions P₁, P₂, …, Pₙ.
	|      *  / \     | The *’s denote the elements E₁, E₂, …, Eₙ in
	|*       /   \    | the set, each in a single partition, their
	|       /  *  \   | equivalence class.
	|      / *   /    |
	| *   /\  * /     |
	|    /  \  /      |
	|   /    \/  *    |
	|  / *    \       |
	| /     *  \      |
	+-----------------+
```

# API

Das Paket stellt einen einzigen Befehl bereit, **::struct::disjointset**, der alle seine Funktionen über Methoden bereitstellt.

**::struct::disjointset** *aDisjointSet*
: Erstellt ein neues Objekt vom Typ „disjoint set“ mit einem zugehörigen globalen Tcl-Befehl namens *aDisjointSet*. Dieser Befehl kann verwendet werden, um Methoden für disjunkte Mengen aufzurufen, die alle die folgende allgemeine Form haben:

    *aDisjointSet* *method* ?*arg ...*?

    Die *Methode* und die *Argumente* legen fest, welche Operation ausgeführt werden soll.


## Methoden

*aDisjointSet* **add-element** *element*
: Erstellt eine neue Partition im *aDisjointSet* und fügt das einzelne *Element* zur neuen Partition hinzu. Der Befehl gewährleistet die Integrität der disjunkten Menge, d. h., wenn *element* bereits in der disjunkten Menge enthalten ist – unabhängig davon, in welcher Partition –, löst diese Methode einen Fehler aus.

    Diese Methode gibt die leere Zeichenkette zurück.

    Diese Methode läuft in konstanter Zeit, *O(1)*.

*aDisjointSet* **add-partition** *elements*
: Erstellt eine neue Partition im *aDisjointSet* und fügt alle angegebenen *Elemente* zur neuen Partition hinzu. Der Befehl gewährleistet die Integrität der disjunkten Menge, d. h., wenn eines der Elemente in *Elemente* bereits in der disjunkten Menge enthalten ist – unabhängig davon, in welcher Partition –, löst diese Methode einen Fehler aus.

    Diese Methode gibt die leere Zeichenkette zurück.

    Die Laufzeit dieser Methode ist proportional zur Größe von *Elementen*, *O(N)*, wobei *N* die Anzahl der *Elemente* ist.

*aDisjointSet* **partitions**
: Gibt die Partitionen des *aDisjointSet* als Liste von Listen zurück. Die äußeren Listen sind die Partitionen, die inneren Listen enthalten die Elemente der jeweiligen Partition.

    Diese Methode läuft in *O(N × α(N))* Zeit, wobei *N* die Anzahl der Elemente in der disjunkten Menge ist und die Funktion *α* die inverse Ackermann-Funktion ist.

*aDisjointSet* **num-partitions**
: Gibt die Anzahl der Partitionen im *aDisjointSet* zurück.

    Diese Methode läuft in konstanter Zeit.

*aDisjointSet* **equal** *a* *b*
: Gibt **1** (wahr) zurück, wenn die Elemente *a* und *b* in der *aDisjointSet* in derselben Partition liegen; andernfalls gibt es **0** (falsch) zurück.

    Wenn eines oder beide Argumente überhaupt nicht in der disjunkten Menge enthalten sind, löst diese Methode einen Fehler aus.

    Diese Methode läuft in amortisierter Zeit *O(α(N))*, wobei *N* die Anzahl der Elemente in der größeren Partition ist und die Funktion *α* die inverse Ackermann-Funktion ist.

*aDisjointSet* **merge** *a* *b*
: Ermittelt die Partitionen im *aDisjointSet*, in denen die Elemente *a* und *b* enthalten sind, und führt diese Partitionen zu einer einzigen Partition zusammen. Wenn die beiden Elemente bereits in derselben Partition enthalten waren, bleibt die disjunkte Menge unverändert.

    Wenn eines oder beide Argumente überhaupt nicht in der disjunkten Menge sind, löst diese Methode einen Fehler aus.

    Diese Methode gibt die leere Zeichenkette zurück.

    Diese Methode läuft in amortisierter Zeit *O(α(N))*, wobei *N* die Anzahl der Elemente in der größeren der zusammenzuführenden Partitionen ist und die *α*-Funktion die inverse Ackermann-Funktion ist. Die Laufzeit im schlimmsten Fall beträgt *O(N)*.

*aDisjointSet* **find** *element*
: Gibt eine Liste der Elemente der Partition des *aDisjointSet* zurück, die das angegebene *element* enthält; oder eine leere Zeichenkette, wenn *element* nicht in der disjunkten Menge enthalten ist.

    Diese Methode läuft in *O(N × α(N))* Zeit, wobei *N* die Gesamtzahl der Elemente in der disjunkten Menge ist und die Funktion *α* die inverse Ackermann-Funktion ist. Siehe **find-exemplar** für eine schnellere Methode, wenn lediglich eine eindeutige Partitionskennung benötigt wird und keine Liste ihrer Elemente.

*aDisjointSet* **exemplars**
: Gibt eine Liste zurück, die für jede Partition in *aDisjointSet* ein Exemplar – ein beliebig ausgewähltes Element – enthält.

    Hinweis: Die einzige Operation, die das für eine bestimmte Partition ausgewählte Exemplar ändert, ist **merge**.

    Diese Methode läuft in *O(N × α(N))* Zeit, wobei *N* die Gesamtzahl der Elemente in der disjunkten Menge ist und die Funktion *α* die inverse Ackermann-Funktion ist.

*aDisjointSet* **find-exemplar** *element*
: Gibt ein Exemplar – ein beliebig ausgewähltes Element – der Partition des *aDisjointSet* zurück, die das angegebene *element* enthält.

    Befindet sich *element* überhaupt nicht in der disjunkten Menge, löst diese Methode einen Fehler aus.

    Hinweis: Die einzige Operation, die das für eine bestimmte Partition ausgewählte Exemplar verändert, ist **merge**.

    Diese Methode läuft in *O(α(N))* Zeit, wobei *N* die Anzahl der Elemente in der Partition ist, die *element* enthält, und die *α*-Funktion die inverse Ackermann-Funktion ist.

*aDisjointSet* **destroy**
: Löscht das *aDisjointSet*-Objekt, einschließlich des globalen Befehls *aDisjointSet*, sowie den gesamten damit verbundenen Speicher.


# Beispiele

In den Beispielen werden die Ergebnisse mithilfe der folgenden **proc**-Prozedur dargestellt:

```
proc dump_disjointset name {
    puts "$name:"
    foreach partition [$name partitions] {
        puts -nonewline "  partition "
        set sep "{"
        foreach element $partition {
            puts -nonewline $sep$element
            set sep " "
        }
        puts "}"
    }
}
```

In diesen Beispielen wird eine neue disjunkte Menge namens *colors* erstellt und es werden eine Partition mit dem einzigen Element *black* sowie eine weitere Partition mit den Elementen *cyan*, *magenta* und *yellow* hinzugefügt.

```
struct::disjointset colors
colors add-element black
puts "colors num-partitions=[colors num-partitions]"
colors add-partition {cyan magenta yellow}
puts "colors num-partitions=[colors num-partitions]"
dump_disjointset colors
=>
colors num-partitions=1
colors num-partitions=2
colors:
  partition {black}
  partition {cyan magenta yellow}
```

In diesen Beispielen werden einige Funktionen der Disjoint-Set-API anhand des oben erstellten Disjoint-Sets *colors* vorgestellt.

```
puts "colors equal black yellow=[colors equal black yellow]"
puts "colors equal cyan yellow=[colors equal cyan yellow]"
puts "colors equal cyan magenta=[colors equal cyan magenta]"
colors merge black cyan
puts "colors equal black yellow=[colors equal black yellow]"
dump_disjointset colors
=>
colors equal black yellow=0
colors equal cyan yellow=1
colors equal cyan magenta=1
colors merge black cyan
colors equal black yellow=1
colors:
  partition {black cyan magenta yellow}
```

In diesem Beispiel werden einige Funktionen der Disjoint-Set-API anhand des oben erstellten Disjoint-Sets *colors* weiter untersucht.

```
colors add-partition {red green blue}
dump_disjointset colors
puts "[colors find-exemplar blue] [colors find-exemplar yellow]"
colors destroy
=>
colors:
  partition {black cyan magenta yellow}
  partition {red green blue}
red cyan
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: disjointset* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen
