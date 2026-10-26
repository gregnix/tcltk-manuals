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

Der Befehl **namespace** ermöglicht das Erstellen, den Zugriff auf und das Löschen getrennter Kontexte für Befehle und Variablen. Eine kurze Einführung zu Namespaces finden Sie im Abschnitt [Was ist ein Namespace?] unten. Die zulässigen Werte von *subcommand* sind unten aufgeführt. Beachten Sie, dass Sie die *subcommand*s abkürzen können.

**namespace children** ?*namespace*? ?*pattern*?
: Gibt eine Liste aller Kind-Namespaces zurück, die zum Namespace *namespace* gehören. Ist *namespace* nicht angegeben, werden die Kinder des aktuellen Namespace zurückgegeben. Dieser Befehl liefert vollqualifizierte Namen, die mit einem doppelten Doppelpunkt (**::**) beginnen. Wird das optionale *pattern* angegeben, werden nur Namen zurückgegeben, die dem Glob-Muster entsprechen. Das tatsächlich verwendete Muster wird wie folgt bestimmt: Ein Muster, das mit einem doppelten Doppelpunkt (**::**) beginnt, wird direkt verwendet, andernfalls wird der Namespace *namespace* (oder der vollqualifizierte Name des aktuellen Namespace) dem Muster vorangestellt.

**namespace code** *script*
: Erfasst den aktuellen Namespace-Kontext für die spätere Ausführung des Skripts *script*. Er gibt ein neues Skript zurück, in dem *script* in einen Befehl **namespace inscope** eingebettet wurde. Das neue Skript hat zwei wichtige Eigenschaften. Erstens kann es in jedem Namespace ausgewertet werden und bewirkt, dass *script* im aktuellen Namespace (dem, in dem **namespace code** aufgerufen wurde) ausgewertet wird. Zweitens können dem resultierenden Skript weitere Argumente angehängt werden; diese werden *script* als zusätzliche Argumente übergeben. Angenommen, der Befehl **set script \[namespace code {foo bar}\]** wird im Namespace **::a::b** aufgerufen. Dann kann **eval $script \[list x y\]** in jedem Namespace ausgeführt werden (vorausgesetzt, der Wert von **script** wurde korrekt übergeben) und hat dieselbe Wirkung wie **::namespace eval ::a::b {foo bar x y}**. Dieser Befehl ist nötig, weil Erweiterungen wie Tk Callback-Skripte normalerweise im globalen Namespace ausführen. Ein Befehl mit Gültigkeitsbereich erfasst einen Befehl zusammen mit seinem Namespace-Kontext so, dass er später korrekt ausgeführt werden kann. Siehe den Abschnitt [Gültigkeitsbereiche für Skripte] für Beispiele zur Erstellung von Callback-Skripten.

**namespace current**
: Gibt den vollqualifizierten Namen des aktuellen Namespace zurück. Der tatsächliche Name des globalen Namespace ist **{}** (d. h. eine leere Zeichenkette), dieser Befehl gibt jedoch aus Gründen der Programmiererfreundlichkeit **::** für den globalen Namespace zurück.

**namespace delete** ?*namespace namespace ...*?
: Jeder Namespace *namespace* wird gelöscht; alle Variablen, Prozeduren und Kind-Namespaces in diesem Namespace werden ebenfalls gelöscht. Führt gerade eine Prozedur innerhalb des Namespace aus, bleibt der Namespace bis zur Rückkehr der Prozedur erhalten; er wird jedoch markiert, damit anderer Code ihn nicht mehr per Namen findet. Existiert ein Namespace nicht, liefert dieser Befehl einen Fehler. Werden keine Namespaces angegeben, tut der Befehl nichts.

**namespace ensemble** *subcommand* ?*arg ...*?
: Erstellt und manipuliert einen Befehl, der aus einem Ensemble von Unterbefehlen gebildet ist. Siehe den Abschnitt [Ensembles] unten.

**namespace eval** *namespace arg* ?*arg ...*?
: Aktiviert einen Namespace namens *namespace* und wertet Code in diesem Kontext aus. Existiert der Namespace noch nicht, wird er erstellt. Sind mehrere *arg*-Argumente angegeben, werden die Argumente wie beim Befehl [eval] mit Leerzeichen dazwischen verkettet und das Ergebnis ausgewertet.

    Hat *namespace* führende Namespace-Qualifizierer und existieren führende Namespaces nicht, werden sie automatisch erstellt.

**namespace exists** *namespace*
: Gibt **1** zurück, wenn *namespace* im aktuellen Kontext ein gültiger Namespace ist, sonst **0**.

**namespace export** ?**-clear**? ?*pattern pattern ...*?
: Legt fest, welche Befehle aus einem Namespace exportiert werden. Exportierte Befehle können später mit **namespace import** in einen anderen Namespace importiert werden. Sowohl im Namespace definierte Befehle als auch zuvor importierte Befehle können exportiert werden. Die Befehle müssen zum Zeitpunkt von **namespace export** noch nicht definiert sein. Jedes *pattern* darf Glob-Sonderzeichen enthalten, aber keine Namespace-Qualifizierer — das Muster kann nur Befehle im aktuellen (exportierenden) Namespace angeben. Jedes *pattern* wird an die Exportmusterliste des Namespace angehängt. Mit der Option **-clear** wird die Exportmusterliste vor dem Anhängen der *pattern*-Argumente geleert. Ohne *pattern* und ohne **-clear** gibt der Befehl die aktuelle Exportliste des Namespace zurück.

**namespace forget** ?*pattern pattern ...*?
: Entfernt zuvor importierte Befehle aus einem Namespace. Jedes *pattern* ist ein einfacher oder qualifizierter Name wie **x**, **foo::x** oder **a::b::p\***. Qualifizierte Namen enthalten doppelte Doppelpunkte (**::**) und qualifizieren einen Namen mit einem oder mehreren Namespaces. Jedes „qualifizierte Muster“ ist mit dem Namen eines exportierenden Namespace qualifiziert und darf am Ende des qualifizierten Namens Glob-Sonderzeichen im Befehlsnamen enthalten. Glob-Zeichen dürfen nicht in einem Namespacenamen vorkommen. Für jedes „einfache Muster“ löscht der Befehl passende Befehle des aktuellen Namespace, die aus einem anderen Namespace importiert wurden. Bei „qualifizierten Mustern“ findet der Befehl zuerst die passenden exportierten Befehle und prüft, ob der aktuelle Namespace sie zuvor importiert hat; falls ja, werden die entsprechenden importierten Befehle gelöscht. Damit macht er die Wirkung von **namespace import** rückgängig.

**namespace import** ?**-force**? ?*pattern* *pattern ...*?
: Importiert Befehle in einen Namespace oder liefert die Menge importierter Befehle. Ohne Argumente gibt **namespace import** die Liste der Befehle im aktuellen Namespace zurück, die aus anderen Namespaces importiert wurden. Die Befehle in der Liste haben einfache Namen ohne Namespace-Qualifizierer — geeignet zur Verwendung mit **namespace forget** (siehe [Beispiele] unten).

    Mit *pattern*-Argumenten ist jedes *pattern* ein qualifizierter Name wie **foo::x** oder **a::p\*** — Name des exportierenden Namespace plus optional Glob-Sonderzeichen am Ende des Befehlsnamens. Glob-Zeichen dürfen nicht im Namespacenamen stehen. Ist der Namespacename nicht vollqualifiziert (beginnt nicht mit einem Namespace-Trennzeichen), wird er wie im Abschnitt [Namensauflösung] beschrieben aufgelöst; existiert kein passender Namespace, tritt ein Fehler auf.

    Alle Befehle, die einem *pattern* entsprechen und aus ihrem Namespace exportiert sind, werden dem aktuellen Namespace hinzugefügt: ein neuer Befehl im aktuellen Namespace verweist auf den exportierten Befehl im Ursprungs-Namespace; beim Aufruf des importierten Befehls wird der exportierte Befehl ausgeführt. Normalerweise liefert der Befehl einen Fehler, wenn ein importierter Befehl mit einem bestehenden kollidiert. Mit **-force** ersetzen importierte Befehle bestehende stillschweigend. **namespace import** hat Snapshot-Semantik: importiert werden nur die zum Ausführungszeitpunkt im exportierenden Namespace definierten, angeforderten Befehle. Später definierte und exportierte Befehle werden nicht importiert.

**namespace inscope** *namespace* *script* ?*arg ...*?
: Führt ein Skript im Kontext des angegebenen *namespace* aus. Programmierer rufen diesen Befehl nicht direkt auf; Aufrufe entstehen implizit, wenn Anwendungen mit **namespace code** Callback-Skripte erzeugen und z. B. bei Tk-Widgets registrieren. **namespace inscope** ähnelt **namespace eval**, aber *namespace* muss bereits existieren, und **namespace inscope** hängt zusätzliche *arg*s als korrekte Listenelemente an.

    ```
    namespace inscope ::foo $script $x $y $z
    ```

    entspricht

    ```
    namespace eval ::foo [concat $script [list $x $y $z]]
    ```

    zusätzliche Argumente durchlaufen also keine zweite Substitutionsrunde wie bei **namespace eval**.

**namespace origin** *command*
: Gibt den vollqualifizierten Namen des ursprünglichen Befehls zurück, auf den der importierte Befehl *command* verweist. Beim Import in einen Namespace wird dort ein neuer Befehl erzeugt, der auf den Befehl im exportierenden Namespace zeigt. Wurde ein Befehl in eine Kette von Namespaces *a, b, …, n* importiert (jeder importiert nur aus dem vorherigen), liefert dieser Befehl den vollqualifizierten Namen des ursprünglichen Befehls im ersten Namespace *a*. Verweist *command* nicht auf einen importierten Befehl, wird der eigene vollqualifizierte Name des Befehls zurückgegeben.

**namespace parent** ?*namespace*?
: Gibt den vollqualifizierten Namen des übergeordneten Namespace von *namespace* zurück. Ohne *namespace* der des übergeordneten Namespace des aktuellen Namespace.

**namespace path** ?*namespaceList*?
: Gibt den Befehlsauflösungspfad des aktuellen Namespace zurück. Wird *namespaceList* als Liste benannter Namespaces angegeben, wird der Pfad auf diese Namespaces gesetzt und die leere Liste zurückgegeben. Standardmäßig ist der Pfad immer leer. Siehe [Namensauflösung] für die Auflösungsregeln.

**namespace qualifiers** *string*
: Gibt führende Namespace-Qualifizierer von *string* zurück. Qualifizierer sind durch **::** getrennte Namespacenamen. Für **::foo::bar::x** liefert der Befehl **::foo::bar**, für **::** eine leere Zeichenkette. Ergänzung zu **namespace tail**. Es wird nicht geprüft, ob die Namespaces tatsächlich existieren.

**namespace tail** *string*
: Gibt den einfachen Namen am Ende einer qualifizierten Zeichenkette zurück. Für **::foo::bar::x** liefert der Befehl **x**, für **::** eine leere Zeichenkette. Ergänzung zu **namespace qualifiers**. Es wird nicht geprüft, ob die Namespaces existieren.

**namespace upvar** *namespace* ?*otherVar myVar* ...?
: Verknüpft null oder mehr lokale Variablen der aktuellen Prozedur mit Variablen in *namespace*. Der Namespacename wird wie in [Namensauflösung] beschrieben aufgelöst. **namespace upvar $ns a b** verhält sich wie **upvar 0 ${ns}::a b**, außer bei den Auflösungsregeln für qualifizierte Namespace- oder Variablennamen. **namespace upvar** gibt eine leere Zeichenkette zurück.

**namespace unknown** ?*script*?
: Setzt oder liefert den Unknown-Befehlshandler des aktuellen Namespace. Der Handler wird aufgerufen, wenn ein aus dem Namespace aufgerufener Befehl weder im aktuellen Namespace, noch auf dessen Pfad noch im globalen Namespace gefunden wird. Ist *script* angegeben, soll es eine wohlgeformte Liste mit Befehlsname und optionalen Argumenten sein. Beim Aufruf wird die vollständige Aufrufzeile angehängt und im Namespace-Kontext ausgewertet. Standard für alle Namespaces ist **::unknown**. Ohne Argument liefert der Befehl den Handler des aktuellen Namespace.

**namespace which** ?**-command**? ?**-variable**? *name*
: Sucht *name* als Befehl oder Variable und gibt den vollqualifizierten Namen zurück. Existiert *name* nicht im aktuellen, aber im globalen Namespace, liefert der Befehl einen vollqualifizierten Namen im globalen Namespace. Existiert Befehl oder Variable nicht, wird eine leere Zeichenkette zurückgegeben. Wurde die Variable erzeugt, aber nicht definiert (z. B. mit [variable] oder per [trace]), liefert der Befehl den vollqualifizierten Variablennamen. Ohne Flag wird *name* als Befehlsname behandelt. Siehe [Namensauflösung].


# Was ist ein Namespace?

Ein Namespace ist eine Sammlung von Befehlen und Variablen. Er kapselt Befehle und Variablen, damit sie nicht mit denen anderer Namespaces interferieren. Tcl hatte stets eine solche Sammlung — den *globalen Namespace*. Der globale Namespace enthält alle globalen Variablen und Befehle. Mit **namespace eval** legen Sie neue Namespaces an. Beispiel:

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

erzeugt einen neuen Namespace mit der Variable **num** und der Prozedur **bump**. Befehle und Variablen in diesem Namespace sind von anderen im selben Programm getrennt. Gibt es im globalen Namespace einen Befehl **bump**, unterscheidet er sich vom **bump** im Namespace **Counter**.

Namespace-Variablen ähneln globalen Variablen in Tcl. Sie existieren außerhalb der Prozeduren im Namespace, sind in Prozeduren aber über [variable] erreichbar (siehe oben).

Namespaces sind dynamisch. Befehle und Variablen können jederzeit hinzugefügt oder entfernt werden; der Inhalt kann mit mehreren **namespace eval**-Aufrufen aufgebaut werden. Die folgende Folge hat dieselbe Wirkung wie die Namespace-Definition oben:

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

Die Prozedur **test** wird dem Namespace **Counter** hinzugefügt und später per [rename] entfernt.

Namespaces können weitere Namespaces enthalten und verschachteln sich hierarchisch. Ein verschachtelter Namespace liegt im übergeordneten Namespace und interferiert nicht mit anderen.

# Qualifizierte Namen

Jeder Namespace hat einen Textnamen wie [history] oder **::safe::interp**. Da Namespaces verschachtelt sein können, werden qualifizierte Namen verwendet, um Befehle, Variablen und Kind-Namespaces zu bezeichnen. Qualifizierte Namen ähneln hierarchischen Pfaden bei Unix-Dateien oder Tk-Widgets, nur ist **::** das Trennzeichen statt **/** oder **.**. Der oberste bzw. globale Namespace heißt **{}** (leere Zeichenkette); **::** ist ein Synonym. Beispiel: **::safe::interp::create** bezeichnet den Befehl **create** im Namespace [interp], Kind von **::safe**, Kind des globalen Namespace **::**.

Um Befehle und Variablen aus einem anderen Namespace zu nutzen, ist zusätzliche Syntax nötig. Namen müssen durch den enthaltenden Namespace qualifiziert sein. Aus dem globalen Namespace könnte man die **Counter**-Prozeduren so aufrufen:

```
Counter::bump 5
Counter::Reset
```

Den aktuellen Zählerstand liest man so:

```
puts "count = $Counter::num"
```

Enthält ein Namespace einen anderen, können mehrere Qualifizierer nötig sein. Enthält **Foo** den Namespace **Counter**, lässt sich **bump** aus dem globalen Namespace so aufrufen:

```
Foo::Counter::bump 3
```

Qualifizierte Namen gelten auch beim Erzeugen und Umbenennen von Befehlen:

```
proc Foo::Test {args} {return $args}
```

Verschieben in einen anderen Namespace:

```
rename Foo::Test Bar::Test
```

Weitere Punkte zu qualifizierten Namen: Namespaces haben nichtleere Namen, außer dem globalen. **::** ist in einfachen Befehls-, Variablen- und Namespacenamen außer als Trennzeichen unzulässig. Zusätzliche Doppelpunkte in einem Trennteil werden ignoriert; zwei oder mehr Doppelpunkte gelten als ein Trennzeichen. Ein abschließendes **::** in einem qualifizierten Variablen- oder Befehlsnamen bezeichnet die Variable bzw. den Befehl mit dem Namen {}. Ein abschließendes **::** in einem qualifizierten Namespacenamen wird ignoriert.

# Namensauflösung

Im Allgemeinen unterstützen Tcl-Befehle, die Variablen- und Befehlsnamen erwarten, qualifizierte Namen — z. B. [set], [proc], [rename], [interp alias][interp]. Beginnt ein vollqualifizierter Name mit **::**, ist der Bezug eindeutig. Beginnt der Name nicht mit **::** (ist *relativ*), gelten folgende Regeln:

- **Variablennamen** werden stets zuerst im aktuellen Namespace und dann im globalen Namespace gesucht.

- **Befehlsnamen** werden zuerst im aktuellen Namespace gesucht, dann in jedem Namespace auf dem Befehlsauflösungspfad des aktuellen Namespace (standardmäßig leer), dann im globalen Namespace (oder der passende **namespace unknown**-Handler).

- **Namespacenamen** werden nur im aktuellen Namespace gesucht.


Im folgenden Beispiel

```
set traceLevel 0
namespace eval Debug {
    printTrace $traceLevel
}
```

sucht Tcl **traceLevel** im Namespace **Debug** und dann im globalen Namespace. **printTrace** wird gleichermaßen aufgelöst. Wird ein Variablen- oder Befehlsname in keinem der beiden Kontexte gefunden, ist er undefiniert. Zur Verdeutlichung folgendes Beispiel:

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

Mit **namespace which** klären Sie Auflösungsfragen. Beispiel:

```
namespace eval Foo::Debug {namespace which -variable traceLevel}
```

liefert **::traceLevel**. Dagegen liefert der Befehl

```
namespace eval Foo {namespace which -variable traceLevel}
```

liefert **::Foo::traceLevel**.

Wie oben erwähnt, werden Namespacenamen anders aufgelöst als Variablen- und Befehlsnamen — stets im aktuellen Namespace. Ein **namespace eval**, der einen neuen Namespace erzeugt, legt daher immer ein Kind des aktuellen Namespace an, sofern der neue Name nicht mit **::** beginnt.

Tcl hat keine Zugriffskontrolle: Mit einem qualifizierten Namen, der nach obigen Regeln aufgelöst wird, ist das Element erreichbar.

Eine Namespace-Variable in einer Prozedur desselben Namespace erreicht man mit [variable] — analog [global], mit lokaler Verknüpfung. Bei Bedarf wird die Variable im aktuellen Namespace angelegt und initialisiert. [global] verknüpft nur mit dem globalen Namespace. [variable] ist entbehrlich, wenn Sie stets den qualifizierten Namen verwenden.

# Import von Befehlen

Namespaces repräsentieren oft Bibliotheken. Häufig genutzte Befehle mit qualifiziertem Namen zu tippen ist lästig. Enthält ein Paket wie BLT alle Befehle im Namespace **Blt**, nutzt man sie so:

```
Blt::graph .g -background red
Blt::table . .g 0,0
```

Nutzen Sie **graph** und **table** oft, können Sie sie ohne Präfix **Blt::** importieren:

```
namespace import Blt::*
```

Damit landen alle exportierten Befehle aus **Blt** im aktuellen Namespace-Kontext:

```
graph .g -background red
table . .g 0,0
```

**namespace import** importiert nur Befehle, die der Namespace mit **namespace export** exportiert hat.

*Alle* Befehle eines Namespace zu importieren ist meist schlecht, weil unklar ist, was ankommt. Besser nur benötigte Befehle:

```
namespace import Blt::graph Blt::table
```

importiert nur **graph** und **table**.

Existiert der Befehl bereits, gibt es einen Fehler — Schutz vor doppeltem Import aus verschiedenen Paketen. Beim Debuggen kann **namespace import** erneut ausgeführt werden, um neue Befehle zu holen; mit **-force** werden bestehende Befehle still überschrieben:

```
namespace import -force Blt::graph Blt::table
```

Importierte Befehle entfernt **namespace forget**:

```
namespace forget Blt::*
```

Sucht im aktuellen Namespace importierte Befehle aus **Blt** und entfernt sie; sonst keine Wirkung. Danach sind **Blt**-Befehle wieder nur mit **Blt::** erreichbar.

Löschen Sie einen Befehl im exportierenden Namespace:

```
rename Blt::graph ""
```

wird er automatisch aus allen Namespaces entfernt, die ihn importiert haben.

# Export von Befehlen

Befehle exportieren Sie so:

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

**bump** und **reset** sind exportiert und werden beim Import aus **Counter** einbezogen:

```
namespace import Counter::*
```

**Check** ist nicht exportiert und wird beim Import ignoriert.

**namespace import** importiert nur als exportiert deklarierte Befehle. **namespace export** legt fest, was andere Namespaces importieren dürfen. Ist ein in **namespace import** genannter Befehl nicht exportiert, wird er nicht importiert.

# Gültigkeitsbereiche für Skripte

**namespace code** verpackt ein Skript zur Auswertung in einem anderen Namespace als dem der Erstellung — häufig für Event-Handler, Tk-Bindings und Traces im globalen Kontext. Beispiel: [trace]-Callback im aktuellen Namespace:

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

Ausgabe bei Ausführung:

```
the value of a::b has changed to c
```

# Ensembles

**namespace ensemble** erstellt und manipuliert Ensemble-Befehle — Befehle aus gruppierten Unterbefehlen. Die Befehle stammen typischerweise aus dem aktuellen Namespace bei der Erstellung (konfigurierbar). Pro Namespace können beliebig viele Ensembles existieren (standardmäßig keines); alle Ensembles eines Namespace werden mit diesem gelöscht. Die Verbindung zum Namespace bleibt beim Umbenennen des Ensembles erhalten.

Drei Unterbefehle von **namespace ensemble** sind definiert:

**namespace ensemble create** ?*option value ...*?
: Erstellt einen neuen Ensemble-Befehl, verknüpft mit dem aktuellen Namespace, und gibt dessen vollqualifizierten Namen zurück. Die Argumente konfigurieren den Befehl wie bei **namespace ensemble configure**. Ohne **-command** hat das Ensemble denselben Namen wie der verknüpfte Namespace. Siehe [Ensemble-Optionen] für alle Optionen.

**namespace ensemble configure** *command* ?*option*? ?*value ...*?
: Liest eine Option des Ensemble-Befehls *command* oder setzt Optionen. Siehe [Ensemble-Optionen].

**namespace ensemble exists** *command*
: Gibt einen booleschen Wert zurück, ob *command* existiert und ein Ensemble-Befehl ist. Fehler nur bei falscher Argumentanzahl.


Beim Aufruf nimmt ein Ensemble-Befehl das erste Argument und ermittelt (nach den Regeln unten) eine Wortliste, die Ensemble-Befehl und Unterbefehl ersetzt. Die Wortliste wird ohne weitere Substitution ausgewertet (als ob so eingegeben — über [Tcl\_EvalObjv][Eval]), und das Ergebnis zurückgegeben. Das Ziel einer Ensemble-Umschreibung darf ein anderes (oder dasselbe) Ensemble sein. Der Ensemble-Befehl ist über [uplevel] oder [info level][info] nicht sichtbar.

## Ensemble-Optionen

Die Optionen von **namespace ensemble create** und **namespace ensemble configure** steuern das Verhalten:

**-map**
: Ist die Option nicht leer, liefert sie ein Dictionary, das Unterbefehlsnamen auf eine Präfix-Wortliste abbildet, die Ensemble-Befehl und Unterbefehl ersetzt (ähnlich [interp alias][interp]; keine erneute Auswertung nach Substitution). Ist das erste Zielwort beim Setzen nicht vollqualifiziert, gilt es relativ zum *aktuellen* Namespace und wird beim Lesen vollqualifiziert. Ist die Option leer, mappt der lokale Unterbefehlsname auf den vollqualifizierten Namen. Ist **-map** nicht leer und **-subcommands** leer, sind die Unterbefehlsnamen genau die Schlüssel des Dictionary.

**-parameters**
: [Liste benannter Argumente (Namen für Fehlermeldungen), die der Aufrufer zwischen Ensemble-Namen und Unterbefehl übergibt. Standard: leere Liste.]{version="8.6"}

**-prefixes**
: Standardmäßig aktiv: erkennt eindeutige Präfixe der Unterbefehle. Ausgeschaltet: exakte Übereinstimmung der Unterbefehlsnamen.

**-subcommands**
: Ist die Option nicht leer, listet sie exakt die Unterbefehle des Ensembles. Die Abbildung kommt aus **-map** oder dem gleichnamigen Befehl im verknüpften Namespace. Ist die Option leer, sind die Unterbefehle die Schlüssel von **-map** oder die zum Aufrufzeitpunkt exportierten Befehle des verknüpften Namespace.

**-unknown**
: Ist die Option nicht leer, liefert sie einen partiellen Befehl (an den alle Argumente des Ensemble-Aufrufs inkl. vollqualifiziertem Ensemble-Namen angehängt werden), wenn ein Unterbefehl nicht erkannt wird und sonst ein Fehler entstünde. Ist die Option leer (Standard), entsteht ein Fehler im Stil von [Tcl\_GetIndexFromObj][GetIndex], wenn das Ensemble den Unterbefehl nicht zuordnen kann. Siehe [Verhalten des Unknown-Handlers].


Zusätzliche Option nur bei **namespace ensemble create**:

**-command**
: Schreibgeschützte Option: Name des Ensembles beliebig in einem bestehenden Namespace. Standard: vollqualifizierter Name des Namespace, in dem **namespace ensemble create** aufgerufen wurde.


Zusätzliche Option nur bei **namespace ensemble configure**:

**-namespace**
: Leseoption: vollqualifizierter Name des Namespace, in dem das Ensemble erzeugt wurde.


## Verhalten des Unknown-Handlers

Ist ein Unknown-Handler für ein Ensemble gesetzt, wird er aufgerufen, wenn der Ensemble-Befehl sonst wegen unklarer Unterbefehlswahl einen Fehler zurückgeben würde. Die genauen Bedingungen steuern **-subcommands**, **-map** und **-prefixes** (siehe oben).

Zur Ausführung nimmt der Ensemble-Mechanismus die **-unknown**-Option und hängt jedes Argument des fehlgeschlagenen Ensemble-Aufrufs an (inkl. des Ensemble-Befehls als vollqualifiziertem Namen) und wertet den resultierenden Befehl im Gültigkeitsbereich des Versuchs aus. Endet der Handler normal, parst die Ensemble-Engine den Unterbefehl erneut und dispatcht noch einmal — ideal, wenn der Handler die Ensemble-Konfiguration aktualisiert hat. Jede andere Beendigung gilt als Fehler.

Das Ergebnis des Unknown-Handlers muss eine Liste sein (sonst Fehler). Ist die Liste leer, sucht der Ensemble-Befehl den ursprünglichen Unterbefehl erneut; wird er dann nicht gefunden, entsteht ein Fehler wie ohne **-unknown**-Handler (der Unknown-Handler wird pro Ensemble-Aufruf höchstens einmal aufgerufen). So kann der Handler Ensemble oder Namespace aktualisieren und erneut parsen lassen.

Ist die Liste nicht leer, ersetzen ihre Wörter Ensemble-Befehl und Unterbefehl wie bei einem Treffer in **-map**. Der Unknown-Handler muss alle Namespace-Qualifizierer liefern, wenn der implementierende Unterbefehl nicht im Namespace des Ensemble-Aufrufers liegt. Bei verketteten Ensembles (z. B. ein Unterbefehl-Implementierer ist selbst ein Ensemble, analog zu **text**-Tags und -Marken) erfolgt die Umschreibung im Kontext des Aufrufers des äußersten Ensembles — Ensembles legen selbst keinen Namespace-Kontext auf den Tcl-Aufrufstack.

Ohne **-unknown**-Handler (Standard) erzeugt der Ensemble-Befehl eine Fehlermeldung aus der Liste definierter Befehle (Format wie [Tcl\_GetIndexFromObj][GetIndex]). Das ist der Fehler, wenn der Unterbefehl beim erneuten Parsen noch unbekannt ist. Es ist auch ein Fehler, wenn ein **-unknown**-Handler seinen eigenen Namespace löscht.

# Beispiele

Namespace mit Variable und exportiertem Befehl anlegen:

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

Herkunft des importierten Befehls ermitteln:

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
