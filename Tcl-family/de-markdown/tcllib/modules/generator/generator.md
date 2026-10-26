---
CommandName: generator
title: generator
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Tcl Generator Commands
Keywords:
 - control structure
 - coroutine
 - filter
 - foldl
 - foldr
 - foreach
 - generator
 - iterator
 - map
 - reduce
 - scanl
Copyright:
---

# Name

generator – Prozeduren zum Erstellen und Verwenden von Generatoren.

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [generator]{.lit} [0.3]{.optlit}
[generator]{.cmd} [define]{.lit} [name]{.arg} [params]{.arg} [body]{.arg}
[generator]{.cmd} [yield]{.lit} [arg]{.arg} [args..]{.optarg}
[generator]{.cmd} [foreach]{.lit} [varList]{.arg} [generator]{.arg} [varList]{.arg} [generator]{.arg} [...]{.optarg} [body]{.arg}
[generator]{.cmd} [next]{.lit} [generator]{.arg} [varName..]{.optarg}
[generator]{.cmd} [exists]{.lit} [generator]{.arg}
[generator]{.cmd} [names]{.lit}
[generator]{.cmd} [destroy]{.lit} [generator..]{.optarg}
[generator]{.cmd} [finally]{.lit} [cmd]{.arg} [arg..]{.optarg}
[generator]{.cmd} [from]{.lit} [format]{.arg} [value]{.arg}
[generator]{.cmd} [to]{.lit} [format]{.arg} [generator]{.arg}
[generator]{.cmd} [map]{.lit} [function]{.arg} [generator]{.arg}
[generator]{.cmd} [filter]{.lit} [predicate]{.arg} [generator]{.arg}
[generator]{.cmd} [reduce]{.lit} [function]{.arg} [zero]{.arg} [generator]{.arg}
[generator]{.cmd} [foldl]{.lit} [function]{.arg} [zero]{.arg} [generator]{.arg}
[generator]{.cmd} [foldr]{.lit} [function]{.arg} [zero]{.arg} [generator]{.arg}
[generator]{.cmd} [all]{.lit} [predicate]{.arg} [generator]{.arg}
[generator]{.cmd} [and]{.lit} [generator]{.arg}
[generator]{.cmd} [any]{.lit} [generator]{.arg}
[generator]{.cmd} [concat]{.lit} [generator]{.arg} [generator..]{.optarg}
[generator]{.cmd} [concatMap]{.lit} [function]{.arg} [generator]{.arg}
[generator]{.cmd} [drop]{.lit} [n]{.arg} [generator]{.arg}
[generator]{.cmd} [dropWhile]{.lit} [predicate]{.arg} [generator]{.arg}
[generator]{.cmd} [contains]{.lit} [element]{.arg} [generator]{.arg}
[generator]{.cmd} [foldl1]{.lit} [function]{.arg} [generator]{.arg}
[generator]{.cmd} [foldli]{.lit} [function]{.arg} [zero]{.arg} [generator]{.arg}
[generator]{.cmd} [foldri]{.lit} [function]{.arg} [zero]{.arg} [generator]{.arg}
[generator]{.cmd} [head]{.lit} [generator]{.arg}
[generator]{.cmd} [tail]{.lit} [generator]{.arg}
[generator]{.cmd} [init]{.lit} [generator]{.arg}
[generator]{.cmd} [takeList]{.lit} [n]{.arg} [generator]{.arg}
[generator]{.cmd} [take]{.lit} [n]{.arg} [generator]{.arg}
[generator]{.cmd} [iterate]{.lit} [function]{.arg} [init]{.arg}
[generator]{.cmd} [last]{.lit} [generator]{.arg}
[generator]{.cmd} [length]{.lit} [generator]{.arg}
[generator]{.cmd} [or]{.lit} [predicate]{.arg} [generator]{.arg}
[generator]{.cmd} [product]{.lit} [generator]{.arg}
[generator]{.cmd} [repeat]{.lit} [n]{.arg} [value..]{.arg}
[generator]{.cmd} [sum]{.lit} [generator]{.arg}
[generator]{.cmd} [takeWhile]{.lit} [predicate]{.arg} [generator]{.arg}
[generator]{.cmd} [splitWhen]{.lit} [predicate]{.arg} [generator]{.arg}
[generator]{.cmd} [scanl]{.lit} [function]{.arg} [zero]{.arg} [generator]{.arg}
:::

# Beschreibung

Das Paket **generator** stellt Befehle zur Definition und Durchlaufung von Generatorausdrücken bereit. Ein *Generator* ist ein Befehl, der eine Folge von Werten gibt. Im Gegensatz zu einem gewöhnlichen Befehl, der eine Liste gibt, *gibt* ein Generator jedoch jeden Wert einzeln aus und wird anschließend unterbrochen, sodass nachfolgende Werte bei Bedarf abgerufen werden können. Auf diese Weise lassen sich Generatoren nutzen, um eine Reihe von Werten effizient zu durchlaufen, ohne alle Ergebnisse im Arbeitsspeicher generieren zu müssen. Generatoren können verwendet werden, um Elemente einer Datenstruktur oder Zeilen in der Ergebnismenge einer Datenbankabfrage zu durchlaufen, um Produzenten- und Konsumenten-Softwareentwürfe wie Parser und Tokenizer voneinander zu entkoppeln oder um ausgefeilte benutzerdefinierte Steuerungsstrategien wie die Backtracking-Suche zu implementieren. Generatoren verringern die Notwendigkeit, benutzerdefinierte Kontrollstrukturen zu implementieren, da viele dieser Strukturen als Generatoren umgestaltet werden können, was sowohl zu einer einfacheren Implementierung als auch zu einer standardisierteren Schnittstelle führt. Der Generatormechanismus baut auf dem Coroutinen-Mechanismus von Tcl 8.6 auf.

Das Paket exportiert einen einzigen Ensemble-Befehl: **generator**. Alle Funktionen werden als Unterbefehle dieses Befehls bereitgestellt. Die zentralen Unterbefehle des Pakets sind **define**, **yield** und **foreach**. Der Befehl **define** funktioniert wie der Tcl-Befehl **proc**, erstellt jedoch eine Generator-Prozedur, d. h. eine Prozedur, die bei Aufruf einen Generator gibt. Der Generator selbst ist ein Befehl, der mehrfach aufgerufen werden kann: Bei jedem Aufruf gibt er den nächsten Wert der generierten Folge zurück. Wenn die Folge erschöpft ist, gibt der Generatorbefehl eine leere Liste zurück und löscht sich anschließend selbst. Anstatt einen Generator manuell aufzurufen, bietet das Paket jedoch auch einen flexiblen Befehl **foreach**, der die Werte eines oder mehrerer Generatoren durchläuft. Diese Schleifenkonstruktion ahmt die Funktionalität des integrierten Tcl-Befehls **foreach** nach, einschließlich der Verarbeitung mehrerer Werte und der gleichzeitigen Durchlaufung mehrerer Generatoren. Das Schreiben eines Generators ist ebenfalls eine einfache Aufgabe, ähnlich wie das Schreiben einer normalen Prozedur: Verwenden Sie einfach den Befehl **define**, um den Generator zu definieren, und rufen Sie anschließend **yield** anstelle von **return** auf. Beispielsweise können wir einen Generator definieren, der die ganzen Zahlen in einem bestimmten Bereich durchläuft:

```
    generator define range {n m} {
        for {set i $n} {$i <= $m} {incr i} { generator yield $i }
    }
    generator foreach x [range 1 10] {
        puts "x = $x"
    }
```

Das obige Beispiel gibt, wie zu erwarten, die Zahlen von 1 bis 10 der Reihe nach aus. Der Unterschied zu einer normalen Schleife über eine Liste besteht darin, dass die Zahlen erst dann generiert werden, wenn sie benötigt werden. Wenn wir eine „break“-Anweisung in die Schleife einfügen, würden die verbleibenden Zahlen der Folge niemals generiert werden. Zur Veranschaulichung können wir einen Generator definieren, der die Folge der natürlichen Zahlen erzeugt: eine unendliche Reihe. Eine normale Prozedur würde beim Versuch, diese Reihe als Liste zu erzeugen, niemals zurückgeben. Durch die Verwendung eines Generators müssen wir nur jene Werte generieren, die tatsächlich verwendet werden:

```
    generator define nats {} {
        while 1 { generator yield [incr nat] }
    }
    generator foreach n [nats] {
        if {$n > 100} { break }
    }
```

# Befehle

**generator** **define** *name* *params* *body*
: Erstellt eine neue Generatorprozedur. Die Argumente des Befehls entsprechen denen von **proc**: ein *name*, eine Liste von Parametern und ein Hauptteil. Das Format der Parameterliste entspricht dem einer Prozedur. Insbesondere können Standardwerte und die „?args“-Syntax wie gewohnt verwendet werden. Bei jedem Aufruf der resultierenden Generator-Prozedur wird ein neuer Generator-Befehl (Koroutine) erstellt, der bei jedem Aufruf eine Liste von Werten liefert. Jedes Ergebnis eines Generators ist garantiert eine nicht leere Liste von Werten. Wenn ein Generator erschöpft ist, gibt er eine leere Liste zurück und löscht sich anschließend selbst, um Ressourcen freizugeben. Der Versuch, einen erschöpften Generator aufzurufen, führt zu einem Fehler, da der Befehl nicht mehr existiert.

**generator** **yield** *arg* ?*args..*?
: Wird dieser Befehl bei der Definition eines Generators verwendet, gibt er die nächste Wertemenge an den Verbraucher zurück. Sobald der Befehl **yield** aufgerufen wurde, unterbricht der Generator seine Ausführung, damit der Verbraucher diesen Wert verarbeiten kann. Wenn der nächste Wert angefordert wird, setzt der Generator die Ausführung fort, als ob der Befehl „yield“ gerade zurückgekehrt wäre, und kann die Verarbeitung fortsetzen, um das nächste Ergebnis auszugeben. Der Befehl **yield** muss mit mindestens einem Argument aufgerufen werden, kann jedoch auch mit mehreren Argumenten aufgerufen werden; in diesem Fall entspricht dies einem einmaligen Aufruf von **yield** für jedes Argument.

**generator** **foreach** *varList* *generator* *varList* *generator* ?...? *body*
: Durchläuft einen oder mehrere Generatoren, weist den Variablen die nächsten Werte zu und führt anschließend den Schleifenkörper aus. Funktioniert ähnlich wie der integrierte Befehl **foreach**, arbeitet jedoch mit Generatoren anstelle von Listen. Es können mehrere Generatoren parallel durchlaufen werden, und von einem einzelnen Generator können mehrere Ergebnisse gleichzeitig abgerufen werden. Wie beim integrierten Befehl **foreach** wird die Schleife so lange fortgesetzt, bis alle Generatoren durchlaufen wurden: Variablen für Generatoren, die vorzeitig erschöpft sind, werden auf die leere Zeichenkette gesetzt.

    Der Befehl **foreach** bereinigt am Ende der Schleife automatisch alle Generatoren, unabhängig davon, ob die Schleife vorzeitig beendet wurde oder nicht. Dieses Verhalten dient der Benutzerfreundlichkeit, um in den üblichen Fällen eine explizite Bereinigung eines Generators zu vermeiden. Generatoren können jedoch vor dem Ende der Schleife zerstört werden; in diesem Fall läuft die Schleife wie gewohnt weiter, bis alle anderen Generatoren zerstört oder erschöpft sind.

    Der Befehl **foreach** erstellt keinen Snapshot des Generators. Jegliche Änderungen am Zustand des Generators, die innerhalb der Schleife oder durch anderen Code vorgenommen werden, wirken sich auf den Zustand der Schleife aus. Insbesondere wenn der Code in der Schleife den Generator aufruft, um das nächste Element manuell abzurufen, wird dieses Element aus der Schleife ausgeschlossen, und die nächste Iteration setzt sich mit dem darauf folgenden Element fort. Es ist darauf zu achten, dass gleichzeitige Aktualisierungen von Generatoren vermieden werden, es sei denn, dieses Verhalten ist erforderlich (z. B. bei der Argumentverarbeitung).

**generator** **next** *generator* ?*varName..*?
: Ruft die nächsten Werte manuell aus einem Generator ab. Für jede übergebene Variable wird ein Wert abgerufen und der entsprechenden Variablen zugewiesen. Wenn der Generator zu irgendeinem Zeitpunkt erschöpft ist, werden alle verbleibenden Variablen auf die leere Zeichenkette gesetzt.

**generator** **exists** *generator*
: Gibt 1 zurück, wenn der Generator (noch) vorhanden ist, andernfalls 0.

**generator** **names**
: Gibt eine Liste aller derzeit vorhandenen Generatorbefehle zurück.

**generator** **destroy** ?*generator..*?
: Zerstört einen oder mehrere Generatoren und gibt alle damit verbundenen Ressourcen frei.

**generator** **finally** *cmd* ?*arg..*?
: Wird dieser Befehl in der Definition einer Generator-Prozedur verwendet, sorgt er dafür, dass eine Ressource freigegeben wird, wenn der Generator zerstört wird – entweder explizit oder implizit, wenn der Generator erschöpft ist. Dieser Befehl kann wie ein **finally**-Block im Befehl **try** verwendet werden, mit dem Unterschied, dass er an den Lebenszyklus des Generators gebunden ist und nicht an einen bestimmten Geltungsbereich. Wenn wir beispielsweise einen Generator erstellen, um die Zeilen einer Textdatei zu durchlaufen, können wir mit **finally** sicherstellen, dass die Datei geschlossen wird, sobald der Generator zerstört wird:

    ```
        generator define lines file {
            set in [open $file]
            # Ensure file is always closed
            generator finally close $in
            while {[gets $in line] >= 0} {
                generator yield $line
            }
        }
        generator foreach line [lines /etc/passwd] {
            puts "[incr count]: $line"
            if {$count > 10} { break }
        }
        # File will be closed even on early exit
    ```

    Wenn Sie einen Generator erstellen, der einen anderen Generator nutzt (wie beispielsweise die später definierten Standards **map** und **filter**), sollten Sie den Befehl **finally** verwenden, um sicherzustellen, dass dieser Generator zusammen mit seinem übergeordneten Generator zerstört wird. Der Generator **map** ist beispielsweise wie folgt definiert:

    ```
        generator define map {f xs} {
            generator finally generator destroy $xs
            generator foreach x $xs { generator yield [{*}$f $x] }
        }
    ```

**generator** **from** *format* *value*
: Erstellt einen Generator aus einer Datenstruktur. Derzeit werden die Formate **list**, **dict** oder **string** unterstützt. Das Listenformat gibt jedes Element nacheinander zurück. Bei Dictionarys werden jeder Schlüssel und jeder Wert separat zurückgegeben. Schließlich werden Zeichenfolgen Zeichen für Zeichen zurückgegeben.

**generator** **to** *format* *generator*
: Wandelt einen Generator in eine Datenstruktur um. Dies ist die umgekehrte Operation des Befehls **from** und unterstützt dieselben Datenstrukturen. Die beiden Operationen erfüllen die folgenden Identitätsgesetze (wobei **=** entsprechend interpretiert wird):

    ```
        [generator to $fmt [generator from $fmt $value]] = $value
        [generator from $fmt [generator to $fmt $gen]]   = $gen
    ```


# Präludium

Die folgenden Befehle werden als Standardbibliothek mit Generator-Kombinatoren und Funktionen bereitgestellt, die praktische Operationen auf Generatoren ausführen. Die Funktionen in diesem Abschnitt orientieren sich lose an den entsprechenden Funktionen aus dem Haskell-Prelude. *Fehlersicht:* Die meisten Funktionen in diesem Prelude zerstören als Nebeneffekt alle ihnen übergebenen Generator-Argumente. Wenn Sie persistente Generatoren verwenden möchten, sehen Sie sich bitte die Streams-Bibliothek an.

**generator** **map** *function* *generator*
: Wendet eine Funktion auf jedes Element eines Generators an und gibt einen neuen Generator mit den Ergebnissen zurück. Dies ist die klassische „map“-Funktion aus der funktionalen Programmierung, die hier auf Generatoren angewendet wird. So können wir beispielsweise mit dem folgenden Code alle Quadratzahlen generieren (wobei **nats** wie zuvor definiert ist):

    ```
        proc square x { expr {$x * $x} }
        generator foreach n [generator map square [nats]] {
            puts "n = $n"
            if {$n > 1000} { break }
        }
    ```

**generator** **filter** *predicate* *generator*
: Ein weiteres Juwel der funktionalen Programmierung. Dieser Befehl gibt einen Generator zurück, der nur jene Elemente aus dem Argumentgenerator liefert, die das Prädikat (eine boolesche Funktion) erfüllen. Hätten wir beispielsweise einen Generator namens **employees**, der einen Strom von Dictionarys gibt, die Personen darstellen, könnten wir mit einem einfachen Filter alle Personen herausfiltern, deren Gehalt über 100.000 Dollar (oder einer Währung Ihrer Wahl) liegt:

    ```
        proc salary> {amount person} { expr {[dict get $person salary] > $amount} }
        set fat-cats [generator filter {salary> 100000} $employees]
    ```

**generator** **reduce** *function* *zero* *generator*
: Dies ist die klassische „Left-Fold“-Operation. Dieser Befehl erwartet eine Funktion, einen Anfangswert und einen Generator von Werten. Für jedes Element im Generator wendet er die Funktion auf den aktuellen Akkumulatorwert (anfänglich das *zero*-Argument) und dieses Element an und verwendet anschließend das Ergebnis als neuen Akkumulatorwert. Dieser Prozess wird über den gesamten Generator hinweg (eager) wiederholt, und der endgültige Akkumulatorwert wird dann zurückgegeben. Betrachtet man die Funktion als binären Operator und das Null-Argument als das linke Identitätselement dieser Operation, so kann man den Befehl **reduce** als eine Art *Faltung* des Operators zwischen jedem aufeinanderfolgenden Wert-Paar im Generator in linksassoziativer Weise betrachten. Beispielsweise lässt sich die Summe einer Zahlenfolge berechnen, indem der Operator **+** zwischen den Zahlen angewendet wird, wobei 0 als Identitätselement dient:

    ```
        # sum xs          = reduce + 0 xs
        # sum [range 1 5] = reduce + 0 [range 1 5]
        #                 = reduce + [+ 0 1] [range 2 5]
        #                 = reduce + [+ 1 2] [range 3 5]
        #                 = ...
        #                 = reduce + [+ 10 5] <empty>
        #                 = ((((0+1)+2)+3)+4)+5
        #                 = 15
        proc + {a b} { expr {$a + $b} }
        proc sum gen { generator reduce + 0 $gen }
        puts [sum [range 1 10]]
    ```

    Die Operation **reduce** ist äußerst nützlich, und mit ihrer Hilfe lassen sich viele unterschiedliche Operationen definieren. So können wir beispielsweise mithilfe von Generatoren eine Fakultätsfunktion als Produkt eines Bereichs definieren. Diese Definition ist sowohl sehr übersichtlich als auch recht effizient (sowohl hinsichtlich des Speicherbedarfs als auch der Laufzeit):

    ```
        proc * {x y} { expr {$x * $y} }
        proc prod gen { generator reduce * 0 $gen }
        proc fac n { prod [range 1 $n] }
    ```

    Obwohl die Operation **reduce** bei endlichen Generatoren effizient ist, sollte darauf geachtet werden, sie nicht auf einen unendlichen Generator anzuwenden, da dies zu einer Endlosschleife führen würde:

    ```
        sum [nats]; # Never returns
    ```

**generator** **foldl** *function* *zero* *generator*
: Dies ist ein Alias für den Befehl **reduce**.

**generator** **foldr** *function* *zero* *generator*
: Dies ist die rechtsassoziative Version von **reduce**. Diese Operation ist im Allgemeinen ineffizient, da der gesamte Generator zunächst (als Liste) im Speicher ausgewertet werden muss, bevor die Reduktion beginnen kann. In einer Sprache mit sofortiger Auswertung wie Tcl ist diese Operation nur von begrenztem Nutzen und sollte nach Möglichkeit vermieden werden.

**generator** **all** *predicate* *generator*
: Gibt „true“ zurück, wenn alle Elemente des Generators das angegebene Prädikat erfüllen.

**generator** **and** *generator*
: Gibt „true“ zurück, wenn alle Elemente des Generators „true“ sind (d. h., es wird die logische Konjunktion der Elemente gebildet).

**generator** **any** *generator*
: Gibt „true“ zurück, wenn eines der Elemente des Generators „true“ ist (d. h. logische Disjunktion).

**generator** **concat** *generator* ?*generator..*?
: Gibt einen Generator zurück, der aus der Verkettung aller Argument-Generatoren besteht.

**generator** **concatMap** *function* *generator*
: Bei einer Funktion, die einen Wert auf eine Reihe von Werten abbildet, und einem Generator für Werte dieses Typs gibt die Funktion einen Generator zurück, der alle Ergebnisse in einer einzigen flachen Reihe enthält. Dies entspricht der Anwendung von **concat** auf das Ergebnis von **map**.

**generator** **drop** *n* *generator*
: Entfernt die angegebene Anzahl von Elementen vom Anfang des Generators und gibt den resultierenden Generator zurück, aus dem diese Elemente entfernt wurden.

**generator** **dropWhile** *predicate* *generator*
: Entfernt alle Elemente aus dem vorderen Teil des Generators, die das Prädikat erfüllen.

**generator** **contains** *element* *generator*
: Gibt „true“ zurück, wenn der Generator das angegebene Element enthält. Hinweis: Der Generator wird dadurch zerstört!

**generator** **foldl1** *function* *generator*
: Eine Version von **foldl**, die das Argument *zero* aus dem ersten Element des Generators entnimmt. Daher ist diese Funktion nur für nicht leere Generatoren gültig.

**generator** **foldli** *function* *zero* *generator*
: Eine Version von **foldl**, die den ganzzahligen Index jedes Elements als erstes Argument an die Funktion übergibt. Das erste Element im Generator erhält an dieser Stelle den Index 0.

**generator** **foldri** *function* *zero* *generator*
: Rechtsassoziative Version von **foldli**.

**generator** **head** *generator*
: Gibt das erste Element des Generators zurück.

**generator** **tail** *generator*
: Entfernt das erste Element des Generators und gibt den Rest zurück.

**generator** **init** *generator*
: Gibt einen neuen Generator zurück, der aus allen Elementen des als Argument übergebenen Generators mit Ausnahme des letzten Elements besteht.

**generator** **takeList** *n* *generator*
: Gibt die nächsten *n* Elemente des Generators als Liste zurück. Wenn im Generator nicht mehr genügend Elemente vorhanden sind, werden lediglich die verbleibenden Elemente zurückgegeben.

**generator** **take** *n* *generator*
: Gibt die nächsten *n* Elemente des Generators als neuen Generator zurück. Der alte Generator wird gelöscht.

**generator** **iterate** *function* *init*
: Gibt einen unendlichen Generator zurück, der durch wiederholte Anwendung der Funktion auf das Ausgangsargument gebildet wird. So lassen sich beispielsweise die Fibonacci-Zahlen wie folgt definieren:

    ```
        proc fst pair { lindex $pair 0 }
        proc snd pair { lindex $pair 1 }
        proc nextFib ab { list [snd $ab] [expr {[fst $ab] + [snd $ab]}] }
        proc fibs {} { generator map fst [generator iterate nextFib {0 1}] }
    ```

**generator** **last** *generator*
: Gibt das letzte Element des Generators zurück (sofern vorhanden).

**generator** **length** *generator*
: Gibt die Länge des Generators zurück und löscht ihn dabei im Prozess.

**generator** **or** *predicate* *generator*
: Gibt den Wert 1 zurück, wenn eines der Elemente des Generators das Prädikat erfüllt.

**generator** **product** *generator*
: Gibt das Produkt der Zahlen in einem Generator zurück.

**generator** **repeat** *n* *value..*
: Gibt einen Generator zurück, der aus *n* Kopien der angegebenen Elemente besteht. Mit dem Sonderwert *Inf* lässt sich eine unendliche Folge erzeugen.

**generator** **sum** *generator*
: Gibt die Summe der Werte im Generator zurück.

**generator** **takeWhile** *predicate* *generator*
: Gibt einen Generator der ersten Elemente des Argumentgenerators zurück, die das Prädikat erfüllen.

**generator** **splitWhen** *predicate* *generator*
: Teilt den Generator mithilfe des Prädikats zur Erkennung von Trennzeichen in Listen von Elementen auf. Die resultierenden Listen werden als Generator zurückgegeben. Elemente, die dem Trennzeichen-Prädikat entsprechen, werden verworfen. Um beispielsweise einen Generator unter Verwendung des Zeichenstrings „|“ als Trennzeichen aufzuteilen:

    ```
        set xs [generator from list {a | b | c}]
        generator split {string equal "|"} $xs ;# returns a then b then c
    ```

**generator** **scanl** *function* *zero* *generator*
: Ähnlich wie **foldl**, gibt jedoch einen Generator zurück, der alle Werte für das Argument „accumulator“ enthält. Das letzte Element dieses Generators entspricht der Funktion **foldl**, die mit denselben Argumenten aufgerufen wurde.


# Fehler, Ideen, Rückmeldungen

Bitte melden Sie Fehler in diesem Dokument oder im beschriebenen Paket an [Neil Madden](mailto:nem@cs.nott.ac.uk).
