---
CommandName: namespace
title: namespace
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - interp(n)
 - upvar(n)
 - variable(n)
Keywords:
 - command
 - ensemble
 - exported
 - internal
 - variable
Copyright:
 - Copyright (c) 1993-1997 Bell Labs Innovations for Lucent Technologies
 - Copyright (c) 1997 Sun Microsystems, Inc.
 - Copyright (c) 2000 Scriptics Corporation.
 - Copyright (c) 2004-2005 Donal K. Fellows.
---

# Name

namespace - Erstellt und manipuliert Kontexte für Befehle und Variablen

# Übersicht

::: {.synopsis} :::
[namespace]{.cmd} [subcommand]{.arg} [arg]{.optdot}
:::

# Beschreibung

Der Befehl **namespace** ermöglicht es Ihnen, getrennte Kontexte für Befehle und Variablen zu erstellen, auf sie zuzugreifen und sie zu löschen. Eine kurze Einführung in Namespaces finden Sie im Abschnitt [Was ist ein Namespace?] unten. Die zulässigen Werte von *subcommand* sind unten aufgeführt. Beachten Sie, dass Sie die *subcommand*-Argumente abkürzen können.

**namespace children** ?*namespace*? ?*pattern*?
: Gibt eine Liste aller Kind-Namespaces zurück, die zum Namespace *namespace* gehören. Ist *namespace* nicht angegeben, werden die Kinder des aktuellen Namespace zurückgegeben. Dieser Befehl gibt vollqualifizierte Namen zurück, die mit einem doppelten Doppelpunkt (**::**) beginnen. Ist das optionale *pattern* angegeben, gibt dieser Befehl nur die Namen zurück, die dem Muster im Glob-Stil entsprechen. Das tatsächlich verwendete Muster wird wie folgt bestimmt: Ein Muster, das mit einem doppelten Doppelpunkt (**::**) beginnt, wird direkt verwendet; andernfalls wird der Namespace *namespace* (oder der vollqualifizierte Name des aktuellen Namespace) dem Muster vorangestellt.

**namespace code** *script*
: Erfasst den aktuellen Namespace-Kontext für die spätere Ausführung des Skripts *script*. Der Befehl gibt ein neues Skript zurück, in dem *script* in einen Befehl **namespace inscope** eingebettet ist. Das neue Skript hat zwei wichtige Eigenschaften. Erstens kann es in jedem Namespace ausgewertet werden und bewirkt, dass *script* im aktuellen Namespace ausgewertet wird (in dem Namespace, in dem der Befehl **namespace code** aufgerufen wurde). Zweitens können an das entstandene Skript weitere Argumente angehängt werden, die *script* als zusätzliche Argumente übergeben werden. Angenommen, der Befehl **set script \[namespace code {foo bar}\]** wird zum Beispiel im Namespace **::a::b** aufgerufen. Dann kann **eval $script \[list x y\]** in jedem beliebigen Namespace ausgeführt werden (vorausgesetzt, der Wert von **script** wurde korrekt übergeben) und hat dieselbe Wirkung wie der Befehl **::namespace eval ::a::b {foo bar x y}**. Dieser Befehl wird benötigt, weil Erweiterungen wie Tk Callback-Skripte normalerweise im globalen Namespace ausführen. Ein Befehl mit Gültigkeitsbereich erfasst einen Befehl zusammen mit seinem Namespace-Kontext so, dass er später korrekt ausgeführt werden kann. Im Abschnitt [Gültigkeitsbereiche für Skripte] finden Sie einige Beispiele dafür, wie damit Callback-Skripte erstellt werden.

**namespace current**
: Gibt den vollqualifizierten Namen des aktuellen Namespace zurück. Der tatsächliche Name des globalen Namespace ist **{}** (d. h. eine leere Zeichenkette), aber dieser Befehl gibt für den globalen Namespace der Bequemlichkeit von Programmierern halber **::** zurück.

**namespace delete** ?*namespace namespace ...*?
: Jeder Namespace *namespace* wird gelöscht, und alle Variablen, Prozeduren und Kind-Namespaces, die der Namespace enthält, werden ebenfalls gelöscht. Wird gerade eine Prozedur innerhalb des Namespace ausgeführt, bleibt der Namespace erhalten, bis die Prozedur zurückkehrt; der Namespace wird jedoch markiert, damit anderer Code ihn nicht mehr über seinen Namen finden kann. Existiert ein Namespace nicht, gibt dieser Befehl einen Fehler zurück. Werden keine Namespacenamen angegeben, bewirkt dieser Befehl nichts.

**namespace ensemble** *subcommand* ?*arg ...*?
: Erstellt und manipuliert einen Befehl, der aus einem Ensemble von Unterbefehlen gebildet wird. Weitere Einzelheiten finden Sie im Abschnitt [Ensembles] unten.

**namespace eval** *namespace arg* ?*arg ...*?
: Aktiviert einen Namespace namens *namespace* und wertet in diesem Kontext Code aus. Existiert der Namespace noch nicht, wird er erstellt. Ist mehr als ein *arg*-Argument angegeben, werden die Argumente auf dieselbe Weise wie beim Befehl [eval] verkettet, mit je einem Leerzeichen dazwischen, und das Ergebnis wird ausgewertet.

    Hat *namespace* führende Namespace-Qualifizierer und existieren einige der führenden Namespaces nicht, werden sie automatisch erstellt.

**namespace exists** *namespace*
: Gibt **1** zurück, wenn *namespace* ein gültiger Namespace im aktuellen Kontext ist, und andernfalls **0**.

**namespace export** ?**-clear**? ?*pattern pattern ...*?
: Legt fest, welche Befehle aus einem Namespace exportiert werden. Exportiert werden die Befehle, die später mit einem Befehl **namespace import** in einen anderen Namespace importiert werden können. Ein Namespace kann sowohl Befehle exportieren, die in ihm definiert sind, als auch Befehle, die er zuvor importiert hat. Die Befehle müssen zu dem Zeitpunkt, an dem der Befehl **namespace export** ausgeführt wird, noch nicht definiert sein. Jedes *pattern* darf Sonderzeichen im Glob-Stil enthalten, aber keine Namespace-Qualifizierer. Das heißt, das Muster kann nur Befehle im aktuellen (exportierenden) Namespace angeben. Jedes *pattern* wird an die Liste der Exportmuster des Namespace angehängt. Ist der Schalter **-clear** angegeben, wird die Exportmusterliste des Namespace geleert, bevor *pattern*-Argumente angehängt werden. Sind weder *pattern*-Argumente noch der Schalter **-clear** angegeben, gibt dieser Befehl die aktuelle Exportliste des Namespace zurück.

**namespace forget** ?*pattern pattern ...*?
: Entfernt zuvor importierte Befehle aus einem Namespace. Jedes *pattern* ist ein einfacher oder qualifizierter Name wie **x**, **foo::x** oder **a::b::p\***. Qualifizierte Namen enthalten doppelte Doppelpunkte (**::**) und qualifizieren einen Namen mit dem Namen eines oder mehrerer Namespaces. Jedes „qualifizierte Muster“ ist mit dem Namen eines exportierenden Namespace qualifiziert und darf im Befehlsnamen am Ende des qualifizierten Namens Sonderzeichen im Glob-Stil enthalten. Glob-Zeichen dürfen nicht in einem Namespacenamen vorkommen. Für jedes „einfache Muster“ löscht dieser Befehl die passenden Befehle des aktuellen Namespace, die aus einem anderen Namespace importiert wurden. Bei „qualifizierten Mustern“ sucht dieser Befehl zuerst die passenden exportierten Befehle. Dann prüft er, ob einige dieser Befehle zuvor vom aktuellen Namespace importiert wurden. Ist das der Fall, löscht dieser Befehl die entsprechenden importierten Befehle. Im Ergebnis macht dies die Wirkung eines Befehls **namespace import** rückgängig.

**namespace import** ?**-force**? ?*pattern* *pattern ...*?
: Importiert Befehle in einen Namespace oder fragt die Menge der importierten Befehle eines Namespace ab. Sind keine Argumente angegeben, gibt **namespace import** die Liste der Befehle im aktuellen Namespace zurück, die aus anderen Namespaces importiert wurden. Die Befehle in der zurückgegebenen Liste haben die Form einfacher Namen, ganz ohne Namespace-Qualifizierer. Diese Form eignet sich zur Kombination mit **namespace forget** (siehe [Beispiele] unten).

    Sind *pattern*-Argumente angegeben, ist jedes *pattern* ein qualifizierter Name wie **foo::x** oder **a::p\***. Das heißt, es enthält den Namen eines exportierenden Namespace und darf im Befehlsnamen am Ende des qualifizierten Namens Sonderzeichen im Glob-Stil enthalten. Glob-Zeichen dürfen nicht in einem Namespacenamen vorkommen. Ist der Namespacename nicht vollqualifiziert (d. h. beginnt er nicht mit einem Namespace-Trennzeichen), wird er als Namespacename so aufgelöst, wie im Abschnitt [Namensauflösung] beschrieben; wird kein Namespace mit diesem Namen gefunden, ist das ein Fehler.

    Alle Befehle, die einer *pattern*-Zeichenkette entsprechen und derzeit aus ihrem Namespace exportiert sind, werden dem aktuellen Namespace hinzugefügt. Dazu wird im aktuellen Namespace ein neuer Befehl erzeugt, der auf den exportierten Befehl in seinem ursprünglichen Namespace verweist; wird der neue importierte Befehl aufgerufen, ruft er den exportierten Befehl auf. Normalerweise gibt dieser Befehl einen Fehler zurück, wenn ein importierter Befehl mit einem bestehenden Befehl kollidiert. Ist jedoch die Option **-force** angegeben, ersetzen importierte Befehle bestehende Befehle stillschweigend. Der Befehl **namespace import** hat Snapshot-Semantik: Es werden nur angeforderte Befehle importiert, die derzeit im exportierenden Namespace definiert sind. Mit anderen Worten: Sie können nur die Befehle importieren, die sich zu dem Zeitpunkt im Namespace befinden, an dem der Befehl **namespace import** ausgeführt wird. Wird später ein weiterer Befehl in diesem Namespace definiert und exportiert, wird er nicht importiert.

**namespace inscope** *namespace* *script* ?*arg ...*?
: Führt ein Skript im Kontext des angegebenen *namespace* aus. Es ist nicht vorgesehen, dass Programmierer diesen Befehl direkt verwenden; Aufrufe dieses Befehls werden implizit erzeugt, wenn Anwendungen mit Befehlen **namespace code** Callback-Skripte erstellen, die sie dann z. B. bei Tk-Widgets registrieren. Der Befehl **namespace inscope** ähnelt dem Befehl **namespace eval** sehr, außer dass *namespace* bereits existieren muss und **namespace inscope** zusätzliche *arg*-Argumente als korrekte Listenelemente anhängt.

    ```
    namespace inscope ::foo $script $x $y $z
    ```

    ist gleichbedeutend mit

    ```
    namespace eval ::foo [concat $script [list $x $y $z]]
    ```

    zusätzliche Argumente durchlaufen also keine zweite Ersetzungsrunde, wie es bei **namespace eval** der Fall ist.

**namespace origin** *command*
: Gibt den vollqualifizierten Namen des ursprünglichen Befehls zurück, auf den der importierte Befehl *command* verweist. Wird ein Befehl in einen Namespace importiert, wird in diesem Namespace ein neuer Befehl erzeugt, der auf den eigentlichen Befehl im exportierenden Namespace verweist. Wird ein Befehl in eine Folge von Namespaces *a, b, …, n* importiert, wobei jeder folgende Namespace den Befehl einfach aus dem vorherigen importiert, gibt dieser Befehl den vollqualifizierten Namen des ursprünglichen Befehls im ersten Namespace *a* zurück. Verweist *command* nicht auf einen importierten Befehl, wird der eigene vollqualifizierte Name des Befehls zurückgegeben.

**namespace parent** ?*namespace*?
: Gibt den vollqualifizierten Namen des übergeordneten Namespace des Namespace *namespace* zurück. Ist *namespace* nicht angegeben, wird der vollqualifizierte Name des übergeordneten Namespace des aktuellen Namespace zurückgegeben.

**namespace path** ?*namespaceList*?
: Gibt den Befehlsauflösungspfad des aktuellen Namespace zurück. Ist *namespaceList* als Liste benannter Namespaces angegeben, wird der Befehlsauflösungspfad des aktuellen Namespace auf diese Namespaces gesetzt, und der Befehl gibt die leere Liste zurück. Der vorgegebene Befehlsauflösungspfad ist immer leer. Eine Erklärung der Regeln zur Namensauflösung finden Sie im Abschnitt [Namensauflösung] unten.

**namespace qualifiers** *string*
: Gibt alle führenden Namespace-Qualifizierer von *string* zurück. Qualifizierer sind Namespacenamen, die durch doppelte Doppelpunkte (**::**) getrennt sind. Für den *string* **::foo::bar::x** gibt dieser Befehl **::foo::bar** zurück, für **::** eine leere Zeichenkette. Dieser Befehl ist das Gegenstück zum Befehl **namespace tail**. Beachten Sie, dass er nicht prüft, ob die Namespacenamen tatsächlich Namen derzeit definierter Namespaces sind.

**namespace tail** *string*
: Gibt den einfachen Namen am Ende einer qualifizierten Zeichenkette zurück. Qualifizierer sind Namespacenamen, die durch doppelte Doppelpunkte (**::**) getrennt sind. Für den *string* **::foo::bar::x** gibt dieser Befehl **x** zurück, für **::** eine leere Zeichenkette. Dieser Befehl ist das Gegenstück zum Befehl **namespace qualifiers**. Er prüft nicht, ob die Namespacenamen tatsächlich Namen derzeit definierter Namespaces sind.

**namespace upvar** *namespace* ?*otherVar myVar* ...?
: Dieser Befehl sorgt dafür, dass null oder mehr lokale Variablen der aktuellen Prozedur auf Variablen in *namespace* verweisen. Der Namespacename wird wie im Abschnitt [Namensauflösung] beschrieben aufgelöst. Der Befehl **namespace upvar $ns a b** verhält sich genauso wie **upvar 0 ${ns}::a b**, mit der einzigen Ausnahme der Auflösungsregeln für qualifizierte Namespace- oder Variablennamen. **namespace upvar** gibt eine leere Zeichenkette zurück.

**namespace unknown** ?*script*?
: Setzt den Unknown-Befehlshandler des aktuellen Namespace oder gibt ihn zurück. Der Handler wird aufgerufen, wenn ein Befehl, der innerhalb des Namespace aufgerufen wird, weder im aktuellen Namespace noch auf dem Pfad des Namespace noch im globalen Namespace gefunden wird. Das Argument *script* sollte, falls angegeben, eine wohlgeformte Liste sein, die einen Befehlsnamen und optionale Argumente darstellt. Wird der Handler aufgerufen, wird die vollständige Aufrufzeile an das Skript angehängt und das Ergebnis im Kontext des Namespace ausgewertet. Der vorgegebene Handler für alle Namespaces ist **::unknown**. Ist kein Argument angegeben, gibt der Befehl den Handler des aktuellen Namespace zurück.

**namespace which** ?**-command**? ?**-variable**? *name*
: Sucht *name* entweder als Befehl oder als Variable und gibt den vollqualifizierten Namen zurück. Existiert *name* zum Beispiel nicht im aktuellen Namespace, aber im globalen Namespace, gibt dieser Befehl einen vollqualifizierten Namen im globalen Namespace zurück. Existiert der Befehl bzw. die Variable nicht, gibt dieser Befehl eine leere Zeichenkette zurück. Wurde die Variable erzeugt, aber nicht definiert, etwa mit dem Befehl [variable] oder durch einen [trace] auf die Variable, gibt dieser Befehl den vollqualifizierten Namen der Variable zurück. Ist kein Schalter angegeben, wird *name* als Befehlsname behandelt. Eine Erklärung der Regeln zur Namensauflösung finden Sie im Abschnitt [Namensauflösung] unten.


# Was ist ein Namespace?

Ein Namespace ist eine Sammlung von Befehlen und Variablen. Er kapselt die Befehle und Variablen, damit sie die Befehle und Variablen anderer Namespaces nicht beeinträchtigen. Tcl hatte schon immer eine solche Sammlung, die wir als *globalen Namespace* bezeichnen. Der globale Namespace enthält alle globalen Variablen und Befehle. Mit dem Befehl **namespace eval** können Sie neue Namespaces erstellen. Zum Beispiel:

```
namespace eval Counter {
    namespace export bump
    variable num 0

    proc bump {} {
        variable num
        incr num
    }
}
```

erzeugt einen neuen Namespace, der die Variable **num** und die Prozedur **bump** enthält. Die Befehle und Variablen in diesem Namespace sind von anderen Befehlen und Variablen im selben Programm getrennt. Gibt es zum Beispiel im globalen Namespace einen Befehl namens **bump**, ist er ein anderer Befehl als **bump** im Namespace **Counter**.

Namespace-Variablen ähneln globalen Variablen in Tcl. Sie existieren außerhalb der Prozeduren eines Namespace, können in einer Prozedur aber über den Befehl [variable] angesprochen werden, wie im Beispiel oben gezeigt.

Namespaces sind dynamisch. Sie können jederzeit Befehle und Variablen hinzufügen und löschen und so den Inhalt eines Namespace mit einer Reihe von Befehlen **namespace eval** nach und nach aufbauen. Zum Beispiel hat die folgende Befehlsfolge dieselbe Wirkung wie die oben gezeigte Namespace-Definition:

```
namespace eval Counter {
    variable num 0
    proc bump {} {
        variable num
        return [incr num]
    }
}
namespace eval Counter {
    proc test {args} {
        return $args
    }
}
namespace eval Counter {
     rename test ""
}
```

Beachten Sie, dass die Prozedur **test** dem Namespace **Counter** hinzugefügt und später mit dem Befehl [rename] wieder entfernt wird.

Namespaces können andere Namespaces enthalten und sind daher hierarchisch verschachtelt. Ein verschachtelter Namespace ist in seinem übergeordneten Namespace gekapselt und kann andere Namespaces nicht beeinträchtigen.

# Qualifizierte Namen

Jeder Namespace hat einen Textnamen wie [history] oder **::safe::interp**. Da Namespaces verschachtelt sein können, werden qualifizierte Namen verwendet, um auf Befehle, Variablen und Kind-Namespaces zu verweisen, die in Namespaces enthalten sind. Qualifizierte Namen ähneln den hierarchischen Pfadnamen von Unix-Dateien oder Tk-Widgets, nur dass **::** statt **/** oder **.** als Trennzeichen verwendet wird. Der oberste oder globale Namespace hat den Namen **{}** (d. h. eine leere Zeichenkette), wobei **::** ein Synonym dafür ist. Zum Beispiel verweist der Name **::safe::interp::create** auf den Befehl **create** im Namespace [interp], der ein Kind des Namespace **::safe** ist, der wiederum ein Kind des globalen Namespace **::** ist.

Wenn Sie auf Befehle und Variablen aus einem anderen Namespace zugreifen wollen, müssen Sie zusätzliche Syntax verwenden. Namen müssen mit dem Namespace qualifiziert werden, der sie enthält. Aus dem globalen Namespace könnten wir die Prozeduren von **Counter** etwa so ansprechen:

```
Counter::bump 5
Counter::Reset
```

Auf den aktuellen Zählerstand könnten wir so zugreifen:

```
puts "count = $Counter::num"
```

Enthält ein Namespace einen anderen, brauchen Sie unter Umständen mehr als einen Qualifizierer, um dessen Elemente zu erreichen. Hätten wir einen Namespace **Foo**, der den Namespace **Counter** enthält, könnten Sie dessen Prozedur **bump** aus dem globalen Namespace so aufrufen:

```
Foo::Counter::bump 3
```

Sie können qualifizierte Namen auch beim Erstellen und Umbenennen von Befehlen verwenden. Zum Beispiel könnten Sie dem Namespace **Foo** so eine Prozedur hinzufügen:

```
proc Foo::Test {args} {return $args}
```

Und Sie könnten dieselbe Prozedur so in einen anderen Namespace verschieben:

```
rename Foo::Test Bar::Test
```

Einige weitere Punkte zu qualifizierten Namen sollten wir noch behandeln. Namespaces haben nichtleere Namen, mit Ausnahme des globalen Namespace. **::** ist in einfachen Befehls-, Variablen- und Namespacenamen nicht erlaubt, außer als Namespace-Trennzeichen. Zusätzliche Doppelpunkte in einem Trennzeichenteil eines qualifizierten Namens werden ignoriert, d. h. zwei oder mehr Doppelpunkte werden als ein Namespace-Trennzeichen behandelt. Ein abschließendes **::** in einem qualifizierten Variablen- oder Befehlsnamen verweist auf die Variable bzw. den Befehl mit dem Namen {}. Ein abschließendes **::** in einem qualifizierten Namespacenamen wird dagegen ignoriert.

# Namensauflösung

Im Allgemeinen unterstützen alle Tcl-Befehle, die Variablen- und Befehlsnamen entgegennehmen, qualifizierte Namen. Das bedeutet, dass Sie Befehlen wie [set], [proc], [rename] und [interp alias][interp] qualifizierte Namen übergeben können. Geben Sie einen vollqualifizierten Namen an, der mit **::** beginnt, ist eindeutig, welchen Befehl, welche Variable oder welchen Namespace Sie meinen. Beginnt der Name jedoch nicht mit **::** (ist er also *relativ*), folgt Tcl einigen grundlegenden Regeln, um ihn nachzuschlagen:

- **Variablennamen** werden stets zuerst im aktuellen Namespace und dann im globalen Namespace gesucht.

- **Befehlsnamen** werden immer zuerst im aktuellen Namespace gesucht. Werden sie dort nicht gefunden, werden sie in jedem Namespace auf dem Befehlspfad des aktuellen Namespace gesucht (der standardmäßig leer ist). Werden sie auch dort nicht gefunden, werden Befehlsnamen im globalen Namespace gesucht (oder, falls auch das scheitert, vom zuständigen Handler **namespace unknown** verarbeitet).

- **Namespacenamen** werden immer ausschließlich im aktuellen Namespace gesucht.


Im folgenden Beispiel

```
set traceLevel 0
namespace eval Debug {
    printTrace $traceLevel
}
```

sucht Tcl **traceLevel** im Namespace **Debug** und dann im globalen Namespace. Den Befehl **printTrace** sucht es auf dieselbe Weise. Wird ein Variablen- oder Befehlsname in keinem der beiden Kontexte gefunden, ist der Name undefiniert. Um diesen Punkt ganz deutlich zu machen, betrachten Sie das folgende Beispiel:

```
set traceLevel 0
namespace eval Foo {
    variable traceLevel 3

    namespace eval Debug {
        printTrace $traceLevel
    }
}
```

sucht Tcl **traceLevel** zuerst im Namespace **Foo::Debug**. Da die Variable dort nicht gefunden wird, sucht Tcl anschließend im globalen Namespace. Die Variable **Foo::traceLevel** wird bei der Namensauflösung völlig ignoriert.

Mit dem Befehl **namespace which** können Sie jede Frage zur Namensauflösung klären. Zum Beispiel gibt der Befehl

```
namespace eval Foo::Debug {namespace which -variable traceLevel}
```

liefert **::traceLevel**. Dagegen liefert der Befehl

```
namespace eval Foo {namespace which -variable traceLevel}
```

liefert **::Foo::traceLevel**.

Wie oben erwähnt, werden Namespacenamen anders nachgeschlagen als die Namen von Variablen und Befehlen. Namespacenamen werden immer im aktuellen Namespace aufgelöst. Das bedeutet zum Beispiel, dass ein Befehl **namespace eval**, der einen neuen Namespace erzeugt, immer ein Kind des aktuellen Namespace erzeugt, es sei denn, der Name des neuen Namespace beginnt mit **::**.

Tcl hat keine Zugriffskontrolle, die einschränkt, welche Variablen, Befehle oder Namespaces Sie ansprechen können. Geben Sie einen qualifizierten Namen an, der nach der obigen Regel zur Namensauflösung zu einem Element aufgelöst wird, können Sie auf dieses Element zugreifen.

Mit dem Befehl [variable] können Sie aus einer Prozedur auf eine Namespace-Variable im selben Namespace zugreifen. Ähnlich wie der Befehl [global] erzeugt er eine lokale Verknüpfung mit der Namespace-Variable. Falls nötig, erzeugt er die Variable außerdem im aktuellen Namespace und initialisiert sie. Beachten Sie, dass der Befehl [global] nur Verknüpfungen mit Variablen im globalen Namespace erzeugt. Der Befehl [variable] ist nicht nötig, wenn Sie die Namespace-Variable stets über einen passenden qualifizierten Namen ansprechen.

# Import von Befehlen

Namespaces werden oft verwendet, um Bibliotheken darzustellen. Manche Bibliotheksbefehle werden so häufig verwendet, dass es lästig ist, ihre qualifizierten Namen einzutippen. Angenommen, alle Befehle eines Pakets wie BLT befinden sich in einem Namespace namens **Blt**. Dann könnten Sie diese Befehle so aufrufen:

```
Blt::graph .g -background red
Blt::table . .g 0,0
```

Wenn Sie die Befehle **graph** und **table** häufig verwenden, möchten Sie sie vielleicht ohne das Präfix **Blt::** ansprechen. Das erreichen Sie, indem Sie die Befehle wie folgt in den aktuellen Namespace importieren:

```
namespace import Blt::*
```

Damit werden alle exportierten Befehle aus dem Namespace **Blt** in den aktuellen Namespace-Kontext übernommen, sodass Sie Code wie diesen schreiben können:

```
graph .g -background red
table . .g 0,0
```

Der Befehl **namespace import** importiert aus einem Namespace nur die Befehle, die dieser Namespace mit einem Befehl **namespace export** exportiert hat.

*Jeden* Befehl eines Namespace zu importieren ist im Allgemeinen keine gute Idee, da Sie nicht wissen, was Sie bekommen. Besser ist es, nur die Befehle zu importieren, die Sie tatsächlich benötigen. Zum Beispiel importiert der Befehl

```
namespace import Blt::graph Blt::table
```

nur die Befehle **graph** und **table** in den aktuellen Kontext.

Wenn Sie versuchen, einen bereits existierenden Befehl zu importieren, erhalten Sie einen Fehler. Das verhindert, dass Sie denselben Befehl aus zwei verschiedenen Paketen importieren. Gelegentlich (etwa bei der Fehlersuche) möchten Sie diese Einschränkung aber vielleicht umgehen. Vielleicht möchten Sie den Befehl **namespace import** erneut ausführen, um neue Befehle zu übernehmen, die in einem Namespace hinzugekommen sind. In diesem Fall können Sie die Option **-force** verwenden, und bestehende Befehle werden stillschweigend überschrieben:

```
namespace import -force Blt::graph Blt::table
```

Wenn Sie die importierten Befehle aus irgendeinem Grund nicht mehr verwenden möchten, können Sie sie mit einem Befehl **namespace forget** wie folgt entfernen:

```
namespace forget Blt::*
```

Der Befehl durchsucht den aktuellen Namespace nach Befehlen, die aus **Blt** importiert wurden. Findet er welche, entfernt er sie. Andernfalls bewirkt er nichts. Danach müssen die **Blt**-Befehle mit dem Präfix **Blt::** angesprochen werden.

Wenn Sie einen Befehl wie folgt aus dem exportierenden Namespace löschen:

```
rename Blt::graph ""
```

wird der Befehl automatisch aus allen Namespaces entfernt, die ihn importieren.

# Export von Befehlen

Sie können Befehle wie folgt aus einem Namespace exportieren:

```
namespace eval Counter {
    namespace export bump reset
    variable Num 0
    variable Max 100

    proc bump {{by 1}} {
        variable Num
        incr Num $by
        Check
        return $Num
    }
    proc reset {} {
        variable Num
        set Num 0
    }
    proc Check {} {
        variable Num
        variable Max
        if {$Num > $Max} {
            error "too high!"
        }
    }
}
```

Die Prozeduren **bump** und **reset** sind exportiert und werden daher einbezogen, wenn Sie wie folgt aus dem Namespace **Counter** importieren:

```
namespace import Counter::*
```

Die Prozedur **Check** ist dagegen nicht exportiert und wird deshalb beim Import ignoriert.

Der Befehl **namespace import** importiert nur Befehle, die von ihrem Namespace als exportiert deklariert wurden. Der Befehl **namespace export** legt fest, welche Befehle von anderen Namespaces importiert werden dürfen. Nennt ein Befehl **namespace import** einen Befehl, der nicht exportiert ist, wird dieser Befehl nicht importiert.

# Gültigkeitsbereiche für Skripte

Der Befehl **namespace code** ist das Mittel, mit dem ein Skript für die Auswertung in einem anderen Namespace als dem, in dem es erstellt wurde, verpackt werden kann. Am häufigsten wird er verwendet, um Ereignisbehandler, Tk-Bindungen und Traces zur Auswertung im globalen Kontext zu erstellen. Der folgende Code zeigt zum Beispiel, wie eine Rückruffunktion für einen [trace] auf eine Variable in den aktuellen Namespace gelenkt wird:

```
namespace eval a {
    variable b
    proc theTraceCallback { n1 n2 op } {
        upvar 1 $n1 var
        puts "the value of $n1 has changed to $var"
        return
    }
    trace add variable b write [namespace code theTraceCallback]
}
set a::b c
```

Bei der Ausführung gibt er folgende Meldung aus:

```
the value of a::b has changed to c
```

# Ensembles

Mit **namespace ensemble** werden Ensemble-Befehle erstellt und manipuliert, also Befehle, die durch das Zusammenfassen von Unterbefehlen gebildet werden. Die Befehle stammen typischerweise aus dem Namespace, der beim Erstellen des Ensembles der aktuelle war, doch das ist konfigurierbar. Beachten Sie, dass einem Namespace beliebig viele Ensembles zugeordnet sein können (auch keines, was standardmäßig für alle Namespaces gilt); alle einem Namespace zugeordneten Ensembles werden jedoch gelöscht, wenn dieser Namespace gelöscht wird. Die Verbindung zwischen einem Ensemble-Befehl und seinem Namespace bleibt erhalten, wie auch immer das Ensemble umbenannt wird.

Für den Befehl **namespace ensemble** sind drei Unterbefehle definiert:

**namespace ensemble create** ?*option value ...*?
: Erstellt einen neuen Ensemble-Befehl, der mit dem aktuellen Namespace verknüpft ist, und gibt den vollqualifizierten Namen des erstellten Befehls zurück. Mit den Argumenten von **namespace ensemble create** lässt sich der Befehl so konfigurieren wie mit dem Befehl **namespace ensemble configure**. Wird der Name nicht mit der Option **-command** überschrieben, erstellt dieser Befehl ein Ensemble mit genau demselben Namen wie der verknüpfte Namespace. Eine vollständige Liste der unterstützten Optionen und ihrer Wirkung finden Sie im Abschnitt [Ensemble-Optionen] unten.

**namespace ensemble configure** *command* ?*option*? ?*value ...*?
: Liest den Wert einer Option des Ensemble-Befehls namens *command* oder ändert einige Optionen dieses Ensemble-Befehls. Eine vollständige Liste der unterstützten Optionen und ihrer Wirkung finden Sie im Abschnitt [Ensemble-Optionen] unten.

**namespace ensemble exists** *command*
: Gibt einen booleschen Wert zurück, der angibt, ob der Befehl *command* existiert und ein Ensemble-Befehl ist. Dieser Befehl gibt nur dann einen Fehler zurück, wenn die Zahl der Argumente des Befehls falsch ist.


Beim Aufruf nimmt ein Ensemble-Befehl sein erstes Argument und schlägt es (nach den unten beschriebenen Regeln) nach, um eine Liste von Wörtern zu ermitteln, durch die der Ensemble-Befehl und der Unterbefehl ersetzt werden. Die entstandene Wortliste wird dann (ohne weitere Ersetzungen) so ausgewertet, als wäre sie ursprünglich so eingegeben worden (d. h., indem die Wortliste an [Tcl\_EvalObjv][Eval] übergeben wird), und das Ergebnis des Befehls wird zurückgegeben. Beachten Sie, dass das Ziel einer Ensemble-Umschreibung durchaus ein anderer (oder sogar derselbe) Ensemble-Befehl sein darf. Der Ensemble-Befehl ist über die Befehle [uplevel] oder [info level][info] nicht sichtbar.

## Ensemble-Optionen

Die folgenden Optionen, die von den Befehlen **namespace ensemble create** und **namespace ensemble configure** unterstützt werden, steuern das Verhalten eines Ensemble-Befehls:

**-map**
: Ist diese Option nicht leer, liefert sie ein Dictionary, das Unterbefehlsnamen auf eine Liste von Präfixwörtern abbildet, die anstelle der Wörter für Ensemble-Befehl und Unterbefehl eingesetzt werden (ähnlich wie bei einem mit [interp alias][interp] erzeugten Alias; die Wörter werden nach der Ersetzung nicht erneut geparst). Ist das erste Wort eines Ziels beim Setzen nicht vollqualifiziert, wird angenommen, dass es relativ zum *aktuellen* Namespace ist, und es wird entsprechend umgewandelt (d. h., beim Lesen ist es immer vollqualifiziert). Ist diese Option leer, wird vom lokalen Namen des Unterbefehls auf seinen vollqualifizierten Namen abgebildet. Beachten Sie, dass die Unterbefehlsnamen des Ensembles genau die Wörter sind, für die im Dictionary eine Abbildung existiert, wenn diese Option nicht leer und die Option **-subcommands** leer ist.

**-parameters**
: [Diese Option gibt eine Liste benannter Argumente an (die Namen werden beim Erzeugen von Fehlermeldungen verwendet), die der Aufrufer des Ensembles zwischen dem Namen des Ensembles und dem Unterbefehlsargument übergibt. Standardmäßig ist sie die leere Liste.]{version="8.6"}

**-prefixes**
: Diese Option (die standardmäßig eingeschaltet ist) steuert, ob der Ensemble-Befehl eindeutige Präfixe seiner Unterbefehle erkennt. Ist sie ausgeschaltet, verlangt der Ensemble-Befehl eine exakte Übereinstimmung der Unterbefehlsnamen.

**-subcommands**
: Ist diese Option nicht leer, listet sie genau auf, welche Unterbefehle zum Ensemble gehören. Die Abbildung jedes dieser Befehle ist entweder das, was in der Option **-map** festgelegt ist, oder der gleichnamige Befehl im mit dem Ensemble verknüpften Namespace. Ist diese Option leer, sind die Unterbefehle des Namespace entweder die Schlüssel des in der Option **-map** angegebenen Dictionary oder die zum Zeitpunkt des Aufrufs des Ensemble-Befehls exportierten Befehle des verknüpften Namespace.

**-unknown**
: Ist diese Option nicht leer, liefert sie einen partiellen Befehl (an den alle Wörter angehängt werden, die Argumente des Ensemble-Befehls sind, einschließlich des vollqualifizierten Namens des Ensembles), der den Fall behandelt, dass ein Unterbefehl des Ensembles nicht erkannt wird und sonst einen Fehler erzeugen würde. Ist die Option leer (Standard), wird immer dann ein Fehler (im Stil von [Tcl\_GetIndexFromObj][GetIndex]) erzeugt, wenn das Ensemble nicht ermitteln kann, wie ein bestimmter Unterbefehl zu implementieren ist. Weitere Einzelheiten finden Sie unter [Verhalten des Unknown-Handlers].


Die folgende zusätzliche Option ist bei **namespace ensemble create** erlaubt:

**-command**
: Mit dieser Option, die nur geschrieben werden kann, darf der Name des von **namespace ensemble create** erstellten Ensembles ein beliebiger Name in einem beliebigen bestehenden Namespace sein. Der Vorgabewert dieser Option ist der vollqualifizierte Name des Namespace, in dem der Befehl **namespace ensemble create** aufgerufen wird.


Die folgende zusätzliche Option ist bei **namespace ensemble configure** erlaubt:

**-namespace**
: Mit dieser Option, die nur gelesen werden kann, lässt sich der vollqualifizierte Name des Namespace abfragen, in dem das Ensemble erstellt wurde.


## Verhalten des Unknown-Handlers

Ist für ein Ensemble ein Unknown-Handler angegeben, wird dieser Handler aufgerufen, wenn der Ensemble-Befehl sonst einen Fehler zurückgeben würde, weil er nicht entscheiden kann, welcher Unterbefehl aufzurufen ist. Unter welchen Bedingungen genau das eintritt, steuern die Optionen **-subcommands**, **-map** und **-prefixes**, wie oben beschrieben.

Um den Unknown-Handler auszuführen, nimmt der Ensemble-Mechanismus die angegebene Option **-unknown** und hängt jedes Argument des versuchten Ensemble-Aufrufs an (einschließlich des Ensemble-Befehls selbst, ausgedrückt als vollqualifizierter Name). Er ruft den entstandenen Befehl im Gültigkeitsbereich des versuchten Aufrufs auf. Endet die Ausführung des Unknown-Handlers normal, parst die Ensemble-Engine den Unterbefehl erneut (wie unten beschrieben) und versucht noch einmal, ihn zuzustellen; das ist ideal für den Fall, dass der Unknown-Handler die Konfiguration des Ensembles aktualisiert hat. Jede andere Art der Beendigung des Unknown-Handlers wird als Fehler behandelt.

Vom Ergebnis des Unknown-Handlers wird erwartet, dass es eine Liste ist (ist es keine, ist das ein Fehler). Ist die Liste leer, versucht der Ensemble-Befehl erneut, den ursprünglichen Unterbefehl nachzuschlagen; wird er auch diesmal nicht gefunden, wird ein Fehler erzeugt, genau so, als gäbe es keinen **-unknown**-Handler (d. h., bei jedem einzelnen Aufruf eines Ensembles wird sein Unknown-Handler höchstens einmal aufgerufen). Dadurch kann der Unknown-Handler das Ensemble oder seinen zugrunde liegenden Namespace leicht so aktualisieren, dass eine Implementierung des gewünschten Unterbefehls bereitsteht, und das erneute Parsen veranlassen.

Ist das Ergebnis eine nicht leere Liste, ersetzen die Wörter dieser Liste den Ensemble-Befehl und den Unterbefehl, genau so, als wären sie in **-map** nachgeschlagen worden. Es ist Sache des Unknown-Handlers, alle Namespace-Qualifizierer zu liefern, wenn der implementierende Unterbefehl nicht im Namespace des Aufrufers des Ensemble-Befehls liegt. Beachten Sie außerdem: Wenn Ensemble-Befehle verkettet sind (z. B. wenn Sie einen der Befehle, die einen Ensemble-Unterbefehl implementieren, selbst zu einem Ensemble machen, ähnlich wie die Unterbefehle tag und mark des Widgets **text**), erfolgt die Umschreibung im Kontext des Aufrufers des äußersten Ensembles. Das heißt, Ensembles legen selbst keine Namespace-Kontexte auf den Tcl-Aufrufstack.

Ist ein leerer **-unknown**-Handler angegeben (Standard), erzeugt der Ensemble-Befehl eine Fehlermeldung auf Grundlage der Liste der Befehle, die das Ensemble definiert hat (ähnlich formatiert wie die Fehlermeldung von [Tcl\_GetIndexFromObj][GetIndex]). Dies ist der Fehler, der ausgelöst wird, wenn der Unterbefehl auch beim erneuten Parsen nicht erkannt wird. Es ist außerdem ein Fehler, wenn ein **-unknown**-Handler seinen Namespace löscht.

# Beispiele

Einen Namespace erstellen, der eine Variable und einen exportierten Befehl enthält:

```
namespace eval foo {
    variable bar 0
    proc grill {} {
        variable bar
        puts "called [incr bar] times"
    }
    namespace export grill
}
```

Den Befehl aus dem vorherigen Beispiel auf verschiedene Weise aufrufen:

```
# Direct call
::foo::grill

# Use the command resolution path to find the name
namespace eval boo {
    namespace path ::foo
    grill
}

# Import into current namespace, then call local alias
namespace import foo::grill
grill

# Create two ensembles, one with the default name and one with a
# specified name.  Then call through the ensembles.
namespace eval foo {
    namespace ensemble create
    namespace ensemble create -command ::foobar
}
foo grill
foobar grill
```

Nachschlagen, woher der im vorherigen Beispiel importierte Befehl stammt:

```
puts "grill came from [namespace origin grill]"
```

Alle importierten Befehle aus dem aktuellen Namespace entfernen:

```
namespace forget {*}[namespace import]
```

[Erstellt ein Ensemble für einfache Arbeit mit Zahlen und nutzt die Option **-parameters**, damit der Operator zwischen dem ersten und dem zweiten Argument stehen kann.]{version="8.6"}

```
namespace eval do {
    namespace export *
    namespace ensemble create -parameters x
    proc plus  {x y} {expr { $x + $y }}
    proc minus {x y} {expr { $x - $y }}
}

# Verwendung des Ensembles:
puts [do 1 plus [do 9 minus 7]]
```


[Eval]: ../tcl-c/Eval.md
[eval]: eval.md
[GetIndex]: ../tcl-c/GetIndex.md
[global]: global.md
[history]: history.md
[info]: info.md
[interp]: interp.md
[proc]: proc.md
[rename]: rename.md
[set]: set.md
[trace]: trace.md
[uplevel]: uplevel.md
[variable]: variable.md
