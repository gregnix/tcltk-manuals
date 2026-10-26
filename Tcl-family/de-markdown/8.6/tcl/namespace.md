---
CommandName: namespace
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

# NAME

namespace - Kontexte für Befehle und Variablen erstellen und verwalten

# ÜBERSICHT

::: {.synopsis} :::
[namespace]{.cmd} [subcommand]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **namespace** ermöglicht das Erstellen, den Zugriff auf und das Löschen getrennter Kontexte für Befehle und Variablen. Eine kurze Einführung zu Namespaces finden Sie im Abschnitt **WAS IST EIN NAMESPACE?** unten. Die zulässigen Werte von *subcommand* sind unten aufgeführt. Beachten Sie, dass Sie die *subcommand*s abkürzen können.

**namespace children** ?*namespace*? ?*pattern*?
: Gibt eine Liste aller Kind-Namespaces zurück, die zum Namespace *namespace* gehören. Ist *namespace* nicht angegeben, werden die Kinder des aktuellen Namespace zurückgegeben. Dieser Befehl liefert vollqualifizierte Namen, die mit einem doppelten Doppelpunkt (**::**) beginnen. Wird das optionale *pattern* angegeben, werden nur Namen zurückgegeben, die dem Glob-Muster entsprechen. Das tatsächlich verwendete Muster wird wie folgt bestimmt: Ein Muster, das mit einem doppelten Doppelpunkt (**::**) beginnt, wird direkt verwendet, andernfalls wird der Namespace *namespace* (oder der vollqualifizierte Name des aktuellen Namespace) dem Muster vorangestellt.

**namespace code** *script*
: Erfasst den aktuellen Namespace-Kontext für die spätere Ausführung des Skripts *script*. Er gibt ein neues Skript zurück, in dem *script* in einen Befehl **namespace inscope** eingebettet ist. Das neue Skript hat zwei wichtige Eigenschaften. Erstens kann es in jedem Namespace ausgewertet werden und bewirkt, dass *script* im aktuellen Namespace (dem, in dem **namespace code** aufgerufen wurde) ausgewertet wird. Zweitens können dem resultierenden Skript weitere Argumente angehängt werden; sie werden *script* als zusätzliche Argumente übergeben. Wird beispielsweise der Befehl **set script [namespace code {foo bar}]** im Namespace **::a::b** aufgerufen, kann **eval $script [list x y]** in jedem Namespace ausgeführt werden (vorausgesetzt, der Wert von **script** wurde korrekt übergeben) und hat dieselbe Wirkung wie **::namespace eval ::a::b {foo bar x y}**. Der Befehl ist nötig, weil Erweiterungen wie Tk Callback-Skripte üblicherweise im globalen Namespace ausführen. Ein bereichsgebundener Befehl erfasst einen Befehl zusammen mit seinem Namespace-Kontext so, dass er später korrekt ausgeführt werden kann. Siehe den Abschnitt **BEREICHSGEBUNDENE SKRIPTE** für Beispiele zur Erstellung von Callback-Skripten.

**namespace current**
: Gibt den vollqualifizierten Namen des aktuellen Namespace zurück. Der tatsächliche Name des globalen Namespace ist **{}** (d. h. eine leere Zeichenkette); der Befehl gibt jedoch der Einfachheit halber **::** für den globalen Namespace zurück.

**namespace delete** ?*namespace namespace ...*?
: Jeder Namespace *namespace* wird gelöscht; alle Variablen, Prozeduren und Kind-Namespaces in diesem Namespace werden ebenfalls gelöscht. Führt gerade eine Prozedur innerhalb des Namespace aus, bleibt der Namespace bis zur Rückkehr der Prozedur erhalten; er wird jedoch markiert, damit anderer Code ihn nicht mehr per Namen findet. Existiert ein Namespace nicht, liefert dieser Befehl einen Fehler. Werden keine Namespaces angegeben, tut der Befehl nichts.

**namespace ensemble** *subcommand* ?*arg ...*?
: Erstellt und manipuliert einen Befehl, der aus einem Ensemble von Unterbefehlen gebildet ist. Siehe den Abschnitt **ENSEMBLES** unten.

**namespace eval** *namespace arg* ?*arg ...*?
: Aktiviert einen Namespace *namespace* und wertet Code in diesem Kontext aus. Existiert der Namespace noch nicht, wird er erstellt. Sind mehrere *arg*-Argumente angegeben, werden sie wie beim Befehl **eval** mit Leerzeichen dazwischen verkettet und das Ergebnis ausgewertet.
    Hat *namespace* führende Namespace-Qualifizierer und existieren führende Namespaces nicht, werden sie automatisch angelegt.

**namespace exists** *namespace*
: Gibt **1** zurück, wenn *namespace* im aktuellen Kontext ein gültiger Namespace ist, sonst **0**.

**namespace export** ?**-clear**? ?*pattern pattern ...*?
: Legt fest, welche Befehle aus einem Namespace exportiert werden. Exportierte Befehle können später mit **namespace import** in einen anderen Namespace importiert werden. Sowohl im Namespace definierte Befehle als auch zuvor importierte Befehle können exportiert werden. Die Befehle müssen zum Zeitpunkt von **namespace export** noch nicht definiert sein. Jedes *pattern* darf Glob-Sonderzeichen enthalten, aber keine Namespace-Qualifizierer; das Muster kann nur Befehle im aktuellen (exportierenden) Namespace angeben. Jedes *pattern* wird an die Export-Musterliste des Namespace angehängt. Mit der Option **-clear** wird die Export-Musterliste vor dem Anhängen geleert. Ohne *pattern* und ohne **-clear** gibt der Befehl die aktuelle Exportliste des Namespace zurück.

**namespace forget** ?*pattern pattern ...*?
: Entfernt zuvor importierte Befehle aus einem Namespace. Jedes *pattern* ist ein einfacher oder qualifizierter Name wie **x**, **foo::x** oder **a::b::p**_. Qualifizierte Namen enthalten **::** und qualifizieren einen Namen mit einem oder mehreren Namespaces. Jedes „qualifizierte Muster“ ist mit dem Namen eines exportierenden Namespace qualifiziert und darf am Ende des qualifizierten Namens Glob-Sonderzeichen im Befehlsnamen enthalten. Glob-Zeichen dürfen nicht in einem Namespace-Namen vorkommen. Für jedes „einfache Muster“ löscht der Befehl passende Befehle des aktuellen Namespace, die aus einem anderen Namespace importiert wurden. Bei „qualifizierten Mustern“ sucht der Befehl zuerst passende exportierte Befehle und prüft, ob der aktuelle Namespace sie importiert hat; falls ja, werden die entsprechenden importierten Befehle gelöscht. Damit macht er **namespace import** rückgängig.

**namespace import** ?**-force**? ?*pattern* *pattern ...*?
: Importiert Befehle in einen Namespace oder fragt die Menge importierter Befehle ab. Ohne Argumente gibt **namespace import** die Liste der Befehle im aktuellen Namespace zurück, die aus anderen Namespaces importiert wurden. Die Einträge sind einfache Namen ohne Namespace-Qualifizierer — geeignet zur Verwendung mit **namespace forget** (siehe **BEISPIELE** unten).
    Mit *pattern*-Argumenten ist jedes *pattern* ein qualifizierter Name wie **foo::x** oder **a::p***; er enthält den exportierenden Namespace und darf am Ende Glob-Sonderzeichen im Befehlsnamen haben. Glob-Zeichen dürfen nicht im Namespace-Namen stehen. Ist der Namespace-Name nicht vollqualifiziert (beginnt nicht mit einem Namespace-Trenner), wird er wie im Abschnitt **NAMENSAUFLÖSUNG** beschrieben aufgelöst; fehlt der Namespace, ist das ein Fehler.
    Alle Befehle, die einem *pattern* entsprechen und aus ihrem Namespace exportiert sind, werden dem aktuellen Namespace hinzugefügt, indem im aktuellen Namespace ein neuer Befehl angelegt wird, der auf den exportierten Befehl im Ursprungs-Namespace zeigt; beim Aufruf des importierten Befehls wird der exportierte Befehl ausgeführt. Normalerweise meldet der Befehl einen Fehler, wenn ein importierter Befehl mit einem bestehenden kollidiert. Mit **-force** ersetzen importierte Befehle bestehende stillschweigend. **namespace import** hat Snapshot-Semantik: importiert werden nur die zum Ausführungszeitpunkt im exportierenden Namespace definierten, angeforderten Befehle. Später definierte und exportierte Befehle werden nicht importiert.

**namespace inscope** *namespace* *script* ?*arg ...*?
: Führt ein Skript im Kontext des angegebenen *namespace* aus. Der Befehl ist nicht für direkte Nutzung durch Programmierer gedacht; Aufrufe entstehen implizit, wenn Anwendungen mit **namespace code** Callback-Skripte erzeugen und z. B. bei Tk-Widgets registrieren. **namespace inscope** ähnelt **namespace eval**, aber *namespace* muss bereits existieren, und zusätzliche *arg*s werden als korrekte Listenelemente angehängt.

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
: Gibt den Befehlsauflösungspfad des aktuellen Namespace zurück. Ist *namespaceList* eine Liste von Namespace-Namen, wird der Pfad darauf gesetzt und eine leere Liste zurückgegeben. Standard ist ein leerer Pfad. Siehe **NAMENSAUFLÖSUNG** für die Auflösungsregeln.

**namespace qualifiers** *string*
: Gibt führende Namespace-Qualifizierer von *string* zurück (Namespaces getrennt durch **::**). Für **::foo::bar::x** liefert der Befehl **::foo::bar**, für **::** eine leere Zeichenkette. Ergänzung zu **namespace tail**. Es wird nicht geprüft, ob die Namespace-Namen existieren.

**namespace tail** *string*
: Gibt den einfachen Namen am Ende einer qualifizierten Zeichenkette zurück. Für **::foo::bar::x** liefert der Befehl **x**, für **::** eine leere Zeichenkette. Ergänzung zu **namespace qualifiers**. Es wird nicht geprüft, ob die Namespace-Namen existieren.

**namespace upvar** *namespace* ?*otherVar myVar* ...?
: Richtet null oder mehr lokale Variablen der aktuellen Prozedur so ein, dass sie auf Variablen in *namespace* verweisen. Der Namespace-Name wird wie in **NAMENSAUFLÖSUNG** beschrieben aufgelöst. **namespace upvar $ns a b** verhält sich wie **upvar 0 ${ns}::a b**, mit der Ausnahme der Auflösungsregeln für qualifizierte Namespace- oder Variablennamen. Gibt eine leere Zeichenkette zurück.

**namespace unknown** ?*script*?
: Setzt oder liefert den Unknown-Befehlshandler des aktuellen Namespace. Der Handler wird aufgerufen, wenn ein aus dem Namespace aufgerufener Befehl weder im aktuellen Namespace, noch auf dessen Pfad noch im globalen Namespace gefunden wird. Ist *script* angegeben, soll es eine wohlgeformte Liste mit Befehlsname und optionalen Argumenten sein. Beim Aufruf wird die vollständige Aufrufzeile angehängt und im Namespace-Kontext ausgewertet. Standard für alle Namespaces ist **::unknown**. Ohne Argument liefert der Befehl den Handler des aktuellen Namespace.

**namespace which** ?**-command**? ?**-variable**? *name*
: Sucht *name* als Befehl oder Variable und gibt den vollqualifizierten Namen zurück. Existiert *name* nicht im aktuellen, aber im globalen Namespace, liefert der Befehl einen vollqualifizierten Namen im globalen Namespace. Existiert Befehl oder Variable nicht, wird eine leere Zeichenkette zurückgegeben. Wurde die Variable erzeugt, aber nicht definiert (z. B. mit **variable** oder per **trace**), liefert der Befehl den vollqualifizierten Variablennamen. Ohne Flag wird *name* als Befehlsname behandelt. Siehe **NAMENSAUFLÖSUNG**.


# WAS IST EIN NAMESPACE?

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

Namespace-Variablen ähneln globalen Variablen in Tcl. Sie existieren außerhalb der Prozeduren im Namespace, sind in Prozeduren aber über **variable** erreichbar (siehe oben).

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

Die Prozedur **test** wird dem Namespace **Counter** hinzugefügt und später per **rename** entfernt.

Namespaces können weitere Namespaces enthalten und verschachteln sich hierarchisch. Ein verschachtelter Namespace liegt im übergeordneten Namespace und interferiert nicht mit anderen.

# QUALIFIZIERTE NAMEN

Jeder Namespace hat einen Textnamen wie **history** oder **::safe::interp**. Da Namespaces verschachtelt sein können, werden qualifizierte Namen verwendet, um Befehle, Variablen und Kind-Namespaces zu bezeichnen. Qualifizierte Namen ähneln hierarchischen Pfadnamen bei Unix-Dateien oder Tk-Widgets; als Trenner dient **::** statt **/** oder **.**. Der oberste bzw. globale Namespace heißt **{}** (leere Zeichenkette); **::** ist ein Synonym. Beispiel: **::safe::interp::create** bezeichnet den Befehl **create** im Namespace **interp**, Kind von **::safe**, Kind des globalen Namespace **::**.

Zum Zugriff auf Befehle und Variablen aus anderen Namespaces ist zusätzliche Syntax nötig; Namen müssen durch den enthaltenden Namespace qualifiziert sein. Aus dem globalen Namespace:

```
Counter::bump 5
Counter::Reset
```

Der aktuelle Zählerstand:

```
puts "count = $Counter::num"
```

Enthält ein Namespace **Foo** den Namespace **Counter**, kann **bump** aus dem globalen Namespace so aufgerufen werden:

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

# NAMENSAUFLÖSUNG

Im Allgemeinen unterstützen Tcl-Befehle, die Variablen- und Befehlsnamen entgegennehmen, qualifizierte Namen (**set**, **proc**, **rename**, **interp alias** usw.). Beginnt ein vollqualifizierter Name mit **::**, ist der Bezug eindeutig. Beginnt er nicht mit **::** (*relativ*), gilt:

- **Variablennamen** werden zuerst im aktuellen Namespace, dann im globalen Namespace gesucht.

- **Befehlsnamen** werden zuerst im aktuellen Namespace gesucht. Fehlen sie dort, in jedem Namespace auf dem Befehlsauflösungspfad des aktuellen Namespace (standardmäßig leer). Fehlen sie auch dort, im globalen Namespace (oder Bearbeitung durch den passenden **namespace unknown**-Handler).

- **Namespace-Namen** werden nur im aktuellen Namespace gesucht.


Im folgenden Beispiel

```
set traceLevel 0
namespace eval Debug {
    printTrace $traceLevel
}
```

sucht Tcl **traceLevel** im Namespace **Debug** und dann im globalen Namespace; **printTrace** analog. Fehlt ein Name in beiden Kontexten, ist er undefiniert. Zur Verdeutlichung:

```
set traceLevel 0
namespace eval Foo {
    variable traceLevel 3

    namespace eval Debug {
        printTrace $traceLevel
    }
}
```

sucht Tcl **traceLevel** zuerst in **Foo::Debug**, dann im globalen Namespace. **Foo::traceLevel** wird bei der Auflösung ignoriert.

Mit **namespace which** lassen sich Fragen zur Namensauflösung klären:

```
namespace eval Foo::Debug {namespace which \-variable traceLevel}
```

liefert **::traceLevel**. Dagegen

```
namespace eval Foo {namespace which \-variable traceLevel}
```

liefert **::Foo::traceLevel**.

Namespace-Namen werden anders aufgelöst als Variablen- und Befehlsnamen: immer im aktuellen Namespace. Ein **namespace eval**, der einen neuen Namespace anlegt, erzeugt daher standardmäßig ein Kind des aktuellen Namespace, sofern der neue Name nicht mit **::** beginnt.

Tcl hat keinen Zugriffsschutz: Liefert ein qualifizierter Name nach den obigen Regeln ein Element, ist der Zugriff möglich.

Auf Namespace-Variablen aus einer Prozedur im selben Namespace greift man mit **variable** zu — analog zu **global**, mit lokaler Verknüpfung zur Namespace-Variable; bei Bedarf wird die Variable im aktuellen Namespace angelegt und initialisiert. **global** verknüpft nur mit dem globalen Namespace. Bei konsequent qualifizierten Namen ist **variable** nicht nötig.

# IMPORTIEREN VON BEFEHLEN

Namespaces repräsentieren oft Bibliotheken. Häufig genutzte Befehle mit qualifiziertem Namen zu tippen ist lästig. Enthält ein Paket wie BLT alle Befehle im Namespace **Blt**, nutzt man sie so:

```
Blt::graph .g \-background red
Blt::table . .g 0,0
```

Ohne das Präfix **Blt::** importiert man die Befehle in den aktuellen Namespace:

```
namespace import Blt::*
```

Damit stehen alle aus **Blt** exportierten Befehle im aktuellen Kontext zur Verfügung:

```
graph .g \-background red
table . .g 0,0
```

**namespace import** importiert nur Befehle, die der Namespace mit **namespace export** exportiert hat.

Alle Befehle eines Namespace zu importieren ist meist ungünstig. Besser sind gezielte Importe:

```
namespace import Blt::graph Blt::table
```

importiert nur **graph** und **table**.

Existiert der Befehl bereits, meldet der Import einen Fehler. Mit **-force** werden bestehende Befehle still überschrieben:

```
namespace import \-force Blt::graph Blt::table
```

Zum Entfernen importierter Befehle:

```
namespace forget Blt::*
```

Der Befehl sucht im aktuellen Namespace nach aus **Blt** importierten Befehlen und entfernt sie; danach ist wieder das Präfix **Blt::** nötig.

Wird ein Befehl im exportierenden Namespace gelöscht, z. B.

```
rename Blt::graph ""
```

entfernt er sich automatisch aus allen Namespaces, die ihn importiert haben.

# EXPORTIEREN VON BEFEHLEN

Export aus einem Namespace:

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

**bump** und **reset** sind exportiert und werden beim Import aus **Counter** mit einbezogen:

```
namespace import Counter::*
```

**Check** ist nicht exportiert und wird beim Import ignoriert.

**namespace import** importiert nur mit **namespace export** deklarierte Befehle. Fordert **namespace import** einen nicht exportierten Befehl an, wird er nicht importiert.

# BEREICHSGEBUNDENE SKRIPTE

**namespace code** verpackt ein Skript zur Auswertung in einem anderen Namespace als dem der Erstellung — häufig für Event-Handler, Tk-Bindings und Traces im globalen Kontext. Beispiel für einen **trace**-Callback im aktuellen Namespace:

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

Ausgabe:

```
the value of a::b has changed to c
```

# ENSEMBLES

**namespace ensemble** erstellt und verwaltet Ensemble-Befehle — Befehle aus gruppierten Unterbefehlen, typischerweise aus dem Namespace bei der Erstellung (konfigurierbar). Pro Namespace können beliebig viele Ensembles existieren (standardmäßig keines); sie werden mit dem Namespace gelöscht. Die Verknüpfung zum Namespace bleibt beim Umbenennen des Ensembles erhalten.

Drei Unterbefehle von **namespace ensemble** sind definiert:

**namespace ensemble create** ?*option value ...*?
: Erstellt einen neuen Ensemble-Befehl, verknüpft mit dem aktuellen Namespace, und gibt dessen vollqualifizierten Namen zurück. Die Argumente konfigurieren den Befehl wie bei **namespace ensemble configure**. Ohne **-command** trägt das Ensemble standardmäßig denselben Namen wie der verknüpfte Namespace. Siehe **ENSEMBLE-OPTIONEN** für alle Optionen.

**namespace ensemble configure** *command* ?*option*? ?*value ...*?
: Liest eine Option des Ensemble-Befehls *command* oder setzt Optionen. Siehe **ENSEMBLE-OPTIONEN**.

**namespace ensemble exists** *command*
: Gibt einen booleschen Wert zurück, ob *command* existiert und ein Ensemble-Befehl ist. Fehler nur bei falscher Argumentanzahl.


Beim Aufruf nimmt ein Ensemble-Befehl das erste Argument und ermittelt (nach den unten beschriebenen Regeln) eine Wortliste, die Ensemble-Befehl und Unterbefehl ersetzt. Die Liste wird ohne weitere Substitution ausgewertet (als ob so eingegeben — über **Tcl_EvalObjv**), und das Ergebnis zurückgegeben. Das Ziel eines Ensemble-Rewrite darf ein anderes (oder dasselbe) Ensemble sein. Der Ensemble-Befehl ist über **uplevel** oder **info level** nicht sichtbar.

## ENSEMBLE-OPTIONEN

Die folgenden Optionen von **namespace ensemble create** und **namespace ensemble configure** steuern das Verhalten:

**-map**
: Ist die Option nicht leer, liefert ein Dictionary die Zuordnung von Unterbefehlsnamen zu einer Präfix-Wortliste, die Ensemble-Befehl und Unterbefehl ersetzt (ähnlich einem Alias mit **interp alias**; keine erneute Auswertung nach der Substitution). Ist das erste Wort eines Ziels beim Setzen nicht vollqualifiziert, gilt es als relativ zum *aktuellen* Namespace und wird beim Lesen vollqualifiziert. Ist die Option leer, wird vom lokalen Unterbefehlsnamen auf den vollqualifizierten Namen abgebildet. Ist **-map** gesetzt und **-subcommands** leer, sind die Unterbefehlsnamen genau die Schlüssel des Dictionary.

**-parameters**
: Liste benannter Argumente (Namen für Fehlermeldungen), die der Aufrufer zwischen Ensemble-Namen und Unterbefehl übergibt. Standard: leere Liste.

**-prefixes**
: Standardmäßig aktiv: unzweideutige Präfixe von Unterbefehlsnamen werden erkannt. Ausgeschaltet sind exakte Unterbefehlsnamen nötig.

**-subcommands**
: Ist die Option nicht leer, listet sie exakt die Unterbefehle des Ensembles. Die Abbildung kommt aus **-map** oder vom gleichnamigen Befehl im verknüpften Namespace. Ist die Option leer, sind die Unterbefehle die Schlüssel von **-map** oder die zum Aufrufzeitpunkt exportierten Befehle des verknüpften Namespace.

**-unknown**
: Ist die Option nicht leer, gibt sie einen partiellen Befehl an (alle Argumente des Ensemble-Aufrufs, einschließlich des vollqualifizierten Ensemble-Namens, werden angehängt), wenn ein Unterbefehl nicht erkannt wird und sonst ein Fehler entstünde. Ist die Option leer (Standard), entsteht ein Fehler im Stil von **Tcl_GetIndexFromObj**, wenn das Ensemble den Unterbefehl nicht zuordnen kann. Siehe **VERHALTEN DES UNKNOWN-HANDLERS**.


Zusätzliche Option nur bei **namespace ensemble create**:

**-command**
: Schreibbare Option: beliebiger Name des Ensembles in einem bestehenden Namespace. Standard: vollqualifizierter Name des Namespace, in dem **namespace ensemble create** aufgerufen wurde.


Zusätzliche Option nur bei **namespace ensemble configure**:

**-namespace**
: Nur lesbar: vollqualifizierter Name des Namespace, in dem das Ensemble erstellt wurde.


## VERHALTEN DES UNKNOWN-HANDLERS

Ist ein Unknown-Handler für ein Ensemble gesetzt, wird er aufgerufen, wenn der Ensemble-Befehl sonst wegen unklarer Unterbefehlswahl einen Fehler zurückgeben würde. Die genauen Bedingungen steuern **-subcommands**, **-map** und **-prefixes** (siehe oben).

Zur Ausführung hängt der Mechanismus an die **-unknown**-Option jedes Argument des fehlgeschlagenen Ensemble-Aufrufs (einschließlich des Ensemble-Befehls als vollqualifiziertem Namen) an und wertet den resultierenden Befehl im Kontext des Versuchs aus. Endet die Ausführung normal, parst die Ensemble-Engine den Unterbefehl erneut und dispatcht erneut — geeignet, wenn der Handler die Ensemble-Konfiguration aktualisiert hat. Jede andere Beendigung gilt als Fehler.

Das Ergebnis des Unknown-Handlers muss eine Liste sein (sonst Fehler). Ist die Liste leer, sucht der Ensemble-Befehl den ursprünglichen Unterbefehl erneut; bleibt er unbekannt, entsteht derselbe Fehler wie ohne Handler (der Unknown-Handler wird pro Aufruf höchstens einmal aufgerufen). So kann der Handler das Ensemble oder den Namespace aktualisieren und erneut parsen lassen.

Ist die Liste nicht leer, ersetzen ihre Wörter Ensemble-Befehl und Unterbefehl wie bei **-map**. Der Handler muss alle Namespace-Qualifizierer liefern, wenn der implementierende Unterbefehl nicht im Namespace des Ensemble-Aufrufers liegt. Bei verketteten Ensembles (z. B. ein Implementierungsbefehl ist selbst ein Ensemble, analog zu **text**-Tag- und Mark-Unterbefehlen) erfolgt das Rewrite im Kontext des Aufrufers des äußersten Ensembles — Ensembles setzen selbst keinen Namespace-Kontext auf den Tcl-Aufrufstack.

Ohne **-unknown**-Handler (Standard) erzeugt der Ensemble-Befehl eine Fehlermeldung aus der Liste definierter Befehle (Format wie **Tcl_GetIndexFromObj**). Das ist der Fehler, wenn der Unterbefehl beim erneuten Parsen noch unbekannt ist. Es ist auch ein Fehler, wenn ein **-unknown**-Handler seinen eigenen Namespace löscht.

# BEISPIELE

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

Aufruf des Befehls auf verschiedene Weise:

```
# Direkter Aufruf
::foo::grill

# Befehlsauflösungspfad nutzen
namespace eval boo {
    namespace path ::foo
    grill
}

# In aktuellen Namespace importieren, dann lokalen Alias aufrufen
namespace import foo::grill
grill

# Zwei Ensembles: Standardname und expliziter Name; Aufruf über Ensembles
namespace eval foo {
    namespace ensemble create
    namespace ensemble create -command ::foobar
}
foo grill
foobar grill
```

Herkunft des importierten Befehls:

```
puts "grill came from [namespace origin grill]"
```

Alle importierten Befehle aus dem aktuellen Namespace entfernen:

```
namespace forget {*}[namespace import]
```

::: {.info -version="8.6"}
Erstellt ein Ensemble für einfache Arbeit mit Zahlen und nutzt die Option **-parameters**, damit der Operator zwischen dem ersten und dem zweiten Argument stehen kann.
:::

```
namespace eval do {
    namespace export *
    namespace ensemble create -parameters x
    proc plus  {x y} {expr { $x + $y }}
    proc minus {x y} {expr { $x - $y }}
}

# In der Anwendung arbeitet das Ensemble so:
puts [do 1 plus [do 9 minus 7]]
```
