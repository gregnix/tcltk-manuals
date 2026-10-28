---
CommandName: xpathFunc
title: xpathFunc
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription:
Keywords:
 - XPath
Copyright:
---

# Name

::dom::xpathFunc - XPath-Funktionen in Tcl

# Übersicht

::: {.synopsis} :::
::dom::xpathFunc::funcName [ctxNode]{.arg} [pos]{.arg} [nodeListType]{.arg} [nodeList]{.arg} [type arg type arg...]{.optarg}
::dom::xpathFunc::namespaceURL::funcName [ctxNode]{.arg} [pos]{.arg} [nodeListType]{.arg} [nodeList]{.arg} [type arg type arg...]{.optarg}
:::

# Beschreibung

Die XPath-Maschine von tDOM unterstützt eigene XPath-Funktionen, die Tcl-Befehle ausführen. Trifft sie auf einen Funktionsaufruf mit unbekanntem Funktionsnamen ohne Namensraum-Qualifikator, sucht die XPath-Maschine im Namensraum **::dom::xpathFunc** einen Tcl-Befehl desselben Namens. Trifft sie auf einen unbekannten Funktionsaufruf mit Namensraum, sucht sie innerhalb von **::dom::xpathFunc** einen Tcl-Namensraum, dessen Name dem vollen Namensraum-URI der Funktion gleicht, und darin einen Tcl-Befehl, der nach dem lokalen Teil des Funktionsnamens benannt ist. Findet sie einen solchen Tcl-Befehl, wird er mit mindestens den folgenden Argumenten ausgeführt, die den aktuellen XPath-Kontext beschreiben:

ctxNode
: Der Objektbefehl [domNode] des XPath-Kontextknotens.

pos
: Die XPath-Kontextposition, nullbasiert. Der Rückgabewert der üblichen XPath-Funktion **position()** im Kontext wäre demnach **$pos - 1**.

nodeListType
: Der Typname für *nodeList*, wie bei *typeVar* der Methode **selectNodes**.

nodeList
: Die Liste des gerade bearbeiteten Ergebnisses des XPath-Schritts, in Dokumentreihenfolge, wie **selectNodes** sie zurückgäbe. *ctxNode* ist gleich **\[lindex $nodeList $pos\]**.


Enthält der Funktionsaufruf Argumente, werden der Argumentliste des Befehls für jedes Argument zwei Argumente angehängt:

type
: Der Typname des Arguments, wie bei *typeVar* von **selectNodes**.

val
: Der Wert des Arguments, wie **selectNodes** ihn in der Ergebnismenge eines XPath-Ausdrucks zurückgäbe.


Der Befehl muss eine Tcl-Liste mit einem oder zwei Elementen zurückgeben, die das Ergebnis des XPath-Funktionsaufrufs liefert. Hat die Ergebnisliste zwei Elemente, ist das erste der XPath-Typname des Ergebnisses und das zweite ein passend kodierter Wert. Der Typname *attrnodes* wird nicht unterstützt:

bool
: Tcl-Wahrheitswert, den **Tcl\_GetBooleanFromObj** annimmt.

number
: Tcl-Zahlenwert, den **Tcl\_GetSizeIntFromObj** oder **Tcl\_GetDoubleFromObj** annimmt.

string
: Einfache Zeichenkette.

nodes
: Tcl-Liste von Objektbefehlen [domNode].

attrvalues
: Alias für *string*.


Hat die Ergebnisliste nur ein Element, gilt es als einfache Zeichenkette. Eine Ergebnisliste mit null Elementen, mit mehr als zwei Elementen oder eine ungültige Tcl-Liste ist ein Fehler, und es ist ein Fehler, wenn der *val* eines zweiteiligen Ergebnisses nicht den oben für seinen *type* beschriebenen Anforderungen entspricht.

# Beispiele

Ein einfacher Nachbau der XPath-2/3-Funktion **fn:matches()**, die in einer XPath-1.0-Maschine wie der von tDOM sonst nicht zur Verfügung steht:

```
proc ::dom::xpathFunc::regmatch {
    ctxNode pos nodeListType nodeList
    inputType inputVal patternType patternVal
} {
    set input [::dom::xpathFuncHelper::coerce2string $inputType $inputVal]
    set pattern [::dom::xpathFuncHelper::coerce2string $patternType $patternVal]
    return [list bool [regexp -- $pattern $input]]
}
```

# Hilfsprozeduren

Der Namensraum **::dom::xpathFuncHelper** enthält Hilfsprozeduren für XPath-Funktionen in Tcl:

**coerce2number** *type* *val*
:  Aus einem *type* und einem *val*, wie sie XPath-Funktionen in Tcl in ihrer Argumentliste bekommen, wird *val* auf eine für seinen *type* passende Weise in eine Zahl umgewandelt:

    empty
    : Immer null.

    number
    : Unverändert.

    string
    : Unverändert. Es wird kein Fehler ausgelöst, wenn *val* nicht numerisch ist.

    attrvalues
    : Das erste Element von *value*.

    nodes
    : Das Ergebnis der XPath-Funktion **number()**, aufgerufen für den ersten Knoten der Liste.

    attrnodes
    : Der Wert des einen Attributs, das in *value* angenommen wird. Es wird kein Fehler ausgelöst, wenn dieser Wert nicht numerisch ist.


**coerce2string** *type* *val*
:  Wie bei **coerce2number**, aber *val* wird in eine reine Zeichenkette umgewandelt:

    empty
    : Die leere Zeichenkette.

    number
    : Unverändert.

    string
    : Unverändert.

    attrvalues
    : Das erste Element von *value*.

    nodes
    : Das Ergebnis der XPath-Funktion **string()**, aufgerufen für den ersten Knoten der Liste.

    attrnodes
    : Der Wert des einen Attributs, das in *value* angenommen wird.



# Grenzen

Namen eigener XPath-Funktionen sind auf 200 Zeichen begrenzt, einschließlich eines Namensraum-URI und des Tcl-Namensraumtrenners **::** zwischen ihm und dem lokalen Teil. Funktionsaufrufe dürfen höchstens 22 Argumente haben. Die Argumentwerte selbst dürfen große Knotenmengen sein. Werden mehr gebraucht, lassen sich diese Grenzen zur Bauzeit über Defines anpassen. Tcl-Befehle, die mit der veralteten Schnittstelle **Tcl\_CreateCommand** angelegt wurden, lassen sich nicht als XPath-Funktionen in Tcl verwenden.

Die DOM-Bäume, aus denen Knoten einer XPath-Funktion in Tcl als Argument übergeben werden, dürfen **nicht** verändert werden. Das gilt für das Argument ctxNode und für die Knoten im Argument nodeList. Sie werden streng nur gelesen. Wird das missachtet, sind beliebige unvorhersehbare Folgen möglich, einschließlich Speicherzugriffsfehlern oder Sicherheitsproblemen.


[domNode]: domNode.md
