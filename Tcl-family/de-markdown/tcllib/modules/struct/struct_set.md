---
CommandName: struct::set
title: struct::set
ManualSection: n
Version: 2.2.5
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - cardinality
 - difference
 - emptiness
 - exclusion
 - inclusion
 - intersection
 - membership
 - set
 - symmetric difference
 - union
Copyright:
 - Copyright (c) 2004-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

struct::set – Befehle zur Bearbeitung von Mengen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::set]{.lit} [2.2.4]{.optlit}
[::struct::set]{.cmd} [empty]{.lit} [set]{.arg}
[::struct::set]{.cmd} [size]{.lit} [set]{.arg}
[::struct::set]{.cmd} [contains]{.lit} [set]{.arg} [value]{.arg}
[::struct::set]{.cmd} [union]{.lit} [set1...]{.optarg}
[::struct::set]{.cmd} [intersect]{.lit} [set1...]{.optarg}
[::struct::set]{.cmd} [difference]{.lit} [set1]{.arg} [set2]{.arg}
[::struct::set]{.cmd} [symdiff]{.lit} [set1]{.arg} [set2]{.arg}
[::struct::set]{.cmd} [intersect3]{.lit} [set1]{.arg} [set2]{.arg}
[::struct::set]{.cmd} [equal]{.lit} [set1]{.arg} [set2]{.arg}
[::struct::set]{.cmd} [include]{.lit} [setVar]{.arg} [value]{.arg}
[::struct::set]{.cmd} [exclude]{.lit} [setVar]{.arg} [value]{.arg}
[::struct::set]{.cmd} [add]{.lit} [setVar]{.arg} [set]{.arg}
[::struct::set]{.cmd} [subtract]{.lit} [setVar]{.arg} [set]{.arg}
[::struct::set]{.cmd} [subsetof]{.lit} [A]{.arg} [B]{.arg}
:::

# Beschreibung

Der Namespace **::struct::set** enthält mehrere nützliche Befehle zur Verarbeitung endlicher Mengen.

Er exportiert nur einen einzigen Befehl: **struct::set**. Der gesamte Funktionsumfang ist über die Unterbefehle dieses Befehls verfügbar.

Eine neue leere Menge kann mit dem Befehl **::struct::set add** *setVar {}* erstellt werden.

*Hinweis:* Ab Version 2.2 dieses Pakets wird, sofern verfügbar, eine auf critcl basierende C-Implementierung verwendet, und zwar mit Tcl 8.4 oder höher.

# Befehle

Im Folgenden sind *set*, *set1* und *set2* **set**-Werte, und *setVar* ist der Name einer Variablen, die ein **set** enthält.

**::struct::set** **empty** *set*
: Gibt **1** (wahr) zurück, wenn *set* leer ist, sonst **0** (falsch).

**::struct::set** **size** *set*
: Gibt die Kardinalität von *set* zurück, d. h. die Anzahl der Elemente in *set*. Sie kann null sein.

**::struct::set** **contains** *set* *value*
: Gibt **1** (wahr) zurück, wenn *set* das Element *value* enthält, sonst **0** (falsch).

**::struct::set** **union** ?*set1*...?
: Gibt ein **set** zurück, das die Vereinigung der angegebenen **set**s ist, d. h. *set1* ∪ *set2* ∪ …. Das resultierende **set** enthält jeden Wert aus jedem angegebenen **set**, ohne Duplikate.

**::struct::set** **intersect** ?*set1*...?
: Gibt ein **set** zurück, das die Schnittmenge der angegebenen **set**s ist, d. h. *set1* ∩ *set2* ∩ …. Das resultierende **set** enthält jeden Wert, den *alle* angegebenen **set**s gemeinsam haben, ohne Duplikate.

**::struct::set** **difference** *set1* *set2*
: Gibt ein **set** zurück, das die Differenz von *set1* und *set2* ist, d. h. *set1* – *set2*. Das resultierende **set** enthält jeden Wert, der in *set1* enthalten ist, aber *nicht* in *set2* vorkommt.

**::struct::set** **symdiff** *set1* *set2*
: Gibt ein **set** zurück, das die symmetrische Differenz von *set1* und *set2* ist, d. h. *set1* Δ *set2*. Das resultierende **set** enthält jeden Wert, der in *set1* *oder* in *set2* enthalten ist, jedoch *nicht* in beiden.

**::struct::set** **intersect3** *set1* *set2*
: Liefert eine Kombination der Methoden **intersect** und **difference**.

    Der Rückgabewert ist eine Liste mit drei Elementen, die in dieser Reihenfolge „*set1* ∩ *set2*“, „*set1* – *set2*“ und „*set2* – *set1*“ enthält. Mit anderen Worten: die Schnittmenge von *set1* und *set2* sowie deren Differenzen.

**::struct::set** **equal** *set1* *set2*
: Gibt **1** (wahr) zurück, wenn die beiden **set**s genau dieselben Werte enthalten, sonst **0** (falsch).

**::struct::set** **include** *setVar* *value*
: Fügt das Element *value* zum **set** mit dem Namen *setVar* hinzu und legt *setVar* an, falls es noch nicht existiert. Ist *value* bereits im **set** *setVar*, geschieht nichts, und das ist kein Fehler. Gibt nichts zurück. Dieser Befehl kann zum Erstellen neuer **set**s verwendet werden.

**::struct::set** **exclude** *setVar* *value*
: Entfernt das Element *value* aus dem **set** mit dem Namen *setVar*. Ist *value* nicht in *setVar* enthalten, tut der Befehl nichts, und das ist kein Fehler. Gibt nichts zurück.

**::struct::set** **add** *setVar* *set*
: Fügt jedes Element aus dem **set**-Wert *set* zum **set** namens *setVar* hinzu, ohne Duplikate. Das **set** *setVar* wird angelegt, falls es noch nicht existiert. Gibt nichts zurück.

    Verwenden Sie **::struct::set add** *setVar {}*, um eine neue leere Menge zu erstellen. Verwenden Sie **::struct::set include**, um einzelne Werte hinzuzufügen.

**::struct::set** **subtract** *setVar* *set*
: Entfernt jedes Element des **set**-Werts *set* aus dem **set** namens *setVar*. Gibt nichts zurück. Verwenden Sie **::struct::set exclude**, um einzelne Werte zu entfernen.

**::struct::set** **subsetof** *A* *B*
: Gibt **1** (wahr) zurück, wenn *A* ⊆ *B* gilt, d. h., wenn **set** *A* eine echte Teilmenge von **set** *B* oder gleich **set** *B* ist, sonst **0** (falsch).


# Beispiele

Ein neues **set** von Grund auf anlegen und füllen. Das **set** **earth\_metals** wird im ersten Schleifendurchlauf angelegt und in den folgenden Durchläufen ergänzt.

```
foreach element {Be Mg Ca Sr Ba Ra} {
    struct::set include earth_metals $element
}
```

Ein **set** als Vereinigung einiger vorhandener **set**s bilden.

```
set metals [struct::set union $alkali_metals $earth_metals]
```

Die Eigenschaften eines **set** abfragen.

```
if {[struct::set empty $metals]} {
    puts "empty"
} else {
    puts "[struct::set size $metals] elements"
}
```

# Literatur

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: set* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen

# Copyright

```
Copyright (c) 2004-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
