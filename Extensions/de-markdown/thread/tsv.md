---
CommandName: tsv
title: tsv
ManualSection: n
Version: 3.0
TclPart: Tcl Threading
TclDescription:
Links:
 - thread
 - tpool
 - ttrace
Keywords:
 - locking
 - synchronization
 - thread shared data
 - threads
Copyright:
---

# Name

tsv - Teil der Tcl-Threading-Erweiterung für Daten, die Threads gemeinsam sind

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [9.0]{.lit}
[package]{.cmd} [require]{.sub} [thread]{.lit} [3.0]{.optlit}
[tsv::names]{.cmd} [pattern]{.optarg}
[tsv::object]{.cmd} [varname]{.arg} [element]{.arg}
[tsv::set]{.cmd} [varname]{.arg} [element]{.arg} [value]{.optarg}
[tsv::get]{.cmd} [varname]{.arg} [element]{.arg} [namedvar]{.optarg}
[tsv::unset]{.cmd} [varname]{.arg} [element]{.optarg}
[tsv::exists]{.cmd} [varname]{.arg} [element]{.arg}
[tsv::pop]{.cmd} [varname]{.arg} [element]{.arg}
[tsv::move]{.cmd} [varname]{.arg} [oldname]{.arg} [newname]{.arg}
[tsv::incr]{.cmd} [varname]{.arg} [element]{.arg} [count]{.optarg}
[tsv::append]{.cmd} [varname]{.arg} [element]{.arg} [value]{.arg} [value]{.optdot}
[tsv::lock]{.cmd} [varname]{.arg} [arg]{.arg} [arg]{.optdot}
[tsv::handlers]{.cmd}
[tsv::lappend]{.cmd} [varname]{.arg} [element]{.arg} [value]{.arg} [value]{.optdot}
[tsv::linsert]{.cmd} [varname]{.arg} [element]{.arg} [index]{.arg} [value]{.arg} [value]{.optdot}
[tsv::lreplace]{.cmd} [varname]{.arg} [element]{.arg} [first]{.arg} [last]{.arg} [value]{.optdot}
[tsv::llength]{.cmd} [varname]{.arg} [element]{.arg}
[tsv::lindex]{.cmd} [varname]{.arg} [element]{.arg} [index]{.optarg}
[tsv::lrange]{.cmd} [varname]{.arg} [element]{.arg} [from]{.arg} [to]{.arg}
[tsv::lsearch]{.cmd} [varname]{.arg} [element]{.arg} [options]{.optarg} [pattern]{.arg}
[tsv::lset]{.cmd} [varname]{.arg} [element]{.arg} [index]{.arg} [index]{.optdot} [value]{.arg}
[tsv::lpop]{.cmd} [varname]{.arg} [element]{.arg} [index]{.optarg}
[tsv::lpush]{.cmd} [varname]{.arg} [element]{.arg} [index]{.optarg}
[tsv::array]{.cmd} [set]{.sub} [varname]{.arg} [list]{.arg}
[tsv::array]{.cmd} [get]{.sub} [varname]{.arg} [pattern]{.optarg}
[tsv::array]{.cmd} [names]{.sub} [varname]{.arg} [pattern]{.optarg}
[tsv::array]{.cmd} [size]{.sub} [varname]{.arg}
[tsv::array]{.cmd} [reset]{.sub} [varname]{.arg} [list]{.arg}
[tsv::array]{.cmd} [bind]{.sub} [varname]{.arg} [handle]{.arg}
[tsv::array]{.cmd} [unbind]{.sub} [varname]{.arg}
[tsv::array]{.cmd} [isbound]{.sub} [varname]{.arg}
[tsv::keyldel]{.cmd} [varname]{.arg} [keylist]{.arg} [key]{.arg}
[tsv::keylget]{.cmd} [varname]{.arg} [keylist]{.arg} [key]{.arg} [retvar]{.optarg}
[tsv::keylkeys]{.cmd} [varname]{.arg} [keylist]{.arg} [key]{.optarg}
[tsv::keylset]{.cmd} [varname]{.arg} [keylist]{.arg} [key]{.arg} [value]{.arg} [key value..]{.optarg}
:::

# Beschreibung

Dieser Abschnitt beschreibt Befehle, die gemeinsame Thread-Variablen umsetzen. Eine gemeinsame Thread-Variable ähnelt einem Tcl-Array sehr, entsteht aber im Gegensatz zu einem Tcl-Array im gemeinsamen Speicher und kann von vielen Threads gleichzeitig verwendet werden. Eine wichtige Eigenschaft der gemeinsamen Thread-Variable ist, dass jeder Zugriff auf die Variable intern durch einen Mutex geschützt ist, sodass der Skriptautor die Variable nicht selbst sperren muss.

Gemeinsame Thread-Variablen sind an keinen Thread ausdrücklich gebunden. Das heißt: Beendet sich ein Thread, der gemeinsame Thread-Variablen erzeugt hat, werden die Variable und der zugehörige Speicher nicht gelöscht und nicht zurückgewonnen. Der Benutzer muss die Variable ausdrücklich löschen, um den von der Variable verbrauchten Speicher zurückzugewinnen.

# Elementbefehle

**tsv::names** ?pattern?
: Gibt die Namen gemeinsamer Variablen zurück, die auf das optionale ?pattern? passen, oder alle bekannten Variablen, wenn das Muster entfällt.

**tsv::object** *varname* *element*
: Erzeugt einen Objektzugriffsbefehl für das *element* in der gemeinsamen Variable *varname*. Mit diesem Befehl lassen sich die meisten anderen Befehle für gemeinsame Variablen als Methoden des Element-Objektbefehls anwenden. Der Objektbefehl wird automatisch gelöscht, wenn das Element, auf das dieser Befehl zeigt, gelöscht wird.

    ```
        % tsv::set foo bar "A shared string"
        % set string [tsv::object foo bar]
        % $string append " appended"
        => A shared string appended
    ```

**tsv::set** *varname* *element* ?value?
: Setzt den Wert des *element* in der gemeinsamen Variable *varname* auf *value* und gibt den Wert an den Aufrufer zurück. *value* darf entfallen; dann gibt der Befehl den aktuellen Wert des Elements zurück. Kann das Element nicht gefunden werden, wird ein Fehler ausgelöst.

**tsv::get** *varname* *element* ?namedvar?
: Holt den Wert des *element* aus der gemeinsamen Variable *varname*. Ist das optionale Argument *namedvar* angegeben, wird der Wert in der benannten Variable gespeichert. Der Rückgabewert des Befehls hängt vom Vorhandensein des optionalen Arguments *namedvar* ab. Entfällt das Argument und kann das angeforderte Element im gemeinsamen Array nicht gefunden werden, löst der Befehl einen Fehler aus. Ist das optionale Argument jedoch auf der Befehlszeile angegeben, gibt der Befehl wahr (1) zurück, wenn das Element gefunden wird, oder falsch (0), wenn das Element nicht gefunden wird.

**tsv::unset** *varname* ?element?
: Löscht das *element* aus der gemeinsamen Variable *varname*. Ist das optionale Element nicht angegeben, löscht der Befehl die Variable.

**tsv::exists** *varname* *element*
: Prüft, ob das *element* in der gemeinsamen Variable *varname* besteht, und gibt wahr (1) zurück, wenn ja, oder falsch (0), wenn nicht.

**tsv::pop** *varname* *element*
: Gibt den Wert des *element* in der gemeinsamen Variable *varname* zurück und löscht das Element, alles in einer atomaren Operation.

**tsv::move** *varname* *oldname* *newname*
: Benennt das Element *oldname* in *newname* in der gemeinsamen Variable *varname* um. Das führt wirksam eine Folge von Holen, Löschen und Setzen aus, aber alles in einem atomaren Schritt.

**tsv::incr** *varname* *element* ?count?
: Ähnlich dem üblichen Tcl-Befehl **incr**, erhöht aber den Wert des *element* in der gemeinsamen Variable *varname* statt den der Tcl-Variable.

**tsv::append** *varname* *element* *value* ?value ...?
: Ähnlich dem üblichen Tcl-Befehl **append**, hängt aber einen oder mehrere Werte an das *element* in der gemeinsamen Variable *varname* an statt an die Tcl-Variable.

**tsv::lock** *varname* *arg* ?arg ...?
: Dieser Befehl reiht die übergebenen Argumente aneinander und wertet das entstehende Skript unter dem Schutz des internen Mutex aus. Während der Auswertung des Skripts ist die gesamte gemeinsame Variable gesperrt. Für Befehle auf der gemeinsamen Variable innerhalb des Skripts ist die interne Sperre abgeschaltet, sodass keine Verklemmung entstehen kann. Es ist auch erlaubt, die gemeinsame Variable aus dem Skript heraus zu löschen. Die gemeinsame Variable wird automatisch erzeugt, wenn sie beim ersten Sperren nicht bestand.

    ```
        % tsv::lock foo {
            tsv::lappend foo bar 1
            tsv::lappend foo bar 2
            puts stderr [tsv::set foo bar]
            tsv::unset foo
        }
    ```

**tsv::handlers**
: Gibt die Namen aller Handler für dauerhaften Speicher zurück, die zur Übersetzungszeit eingeschaltet waren. Einzelheiten stehen bei [Arraybefehle].


# Listenbefehle

Diese Befehle ähneln dem gleichnamigen Tcl-Befehl. Der Unterschied ist, dass sie auf Elementen gemeinsamer Arrays arbeiten.

**tsv::lappend** *varname* *element* *value* ?value ...?
: Ähnlich dem üblichen Tcl-Befehl **lappend**, hängt aber einen oder mehrere Werte an das *element* in der gemeinsamen Variable *varname* an statt an die Tcl-Variable.

**tsv::linsert** *varname* *element* *index* *value* ?value ...?
: Ähnlich dem üblichen Tcl-Befehl **linsert**, fügt aber einen oder mehrere Werte an der Listenposition *index* in das *element* der gemeinsamen Variable *varname* ein statt in die Tcl-Variable.

**tsv::lreplace** *varname* *element* *first* *last* ?value ...?
: Ähnlich dem üblichen Tcl-Befehl **lreplace**, ersetzt aber einen oder mehrere Werte zwischen den Positionen *first* und *last* im *element* der gemeinsamen Variable *varname* statt in der Tcl-Variable.

**tsv::llength** *varname* *element*
: Ähnlich dem üblichen Tcl-Befehl **llength**, gibt aber die Länge des *element* in der gemeinsamen Variable *varname* zurück statt die der Tcl-Variable.

**tsv::lindex** *varname* *element* ?index?
: Ähnlich dem üblichen Tcl-Befehl **lindex**, gibt aber den Wert an der Listenposition *index* des *element* aus der gemeinsamen Variable *varname* zurück statt aus der Tcl-Variable.

**tsv::lrange** *varname* *element* *from* *to*
: Ähnlich dem üblichen Tcl-Befehl **lrange**, gibt aber die Werte zwischen den Listenpositionen *from* und *to* aus dem *element* in der gemeinsamen Variable *varname* zurück statt aus der Tcl-Variable.

**tsv::lsearch** *varname* *element* ?options? *pattern*
: Ähnlich dem üblichen Tcl-Befehl **lsearch**, durchsucht aber das *element* in der gemeinsamen Variable *varname* statt die Tcl-Variable.

**tsv::lset** *varname* *element* *index* ?index ...? *value*
: Ähnlich dem üblichen Tcl-Befehl **lset**, setzt aber das *element* in der gemeinsamen Variable *varname* statt die Tcl-Variable.

**tsv::lpop** *varname* *element* ?index?
: Ähnlich dem üblichen Tcl-Befehl **lindex**, schneidet aber zusätzlich zum Zurückgeben den Wert in einer atomaren Operation aus dem *element* der gemeinsamen Variable *varname* heraus. Im Gegensatz zum Tcl-Befehl **lindex** gibt dieser Befehl dem Aufrufer keinen Wert zurück.

**tsv::lpush** *varname* *element* ?index?
: Dieser Befehl tut das Gegenteil des Befehls **tsv::lpop**. Wie sein Gegenstück gibt er dem Aufrufer keinen Wert zurück.


# Arraybefehle

Dieser Befehl unterstützt die meisten Optionen des üblichen Tcl-Befehls **array**. Zusätzlich erlaubt er die Bindung einer gemeinsamen Variable an Datenbanken für dauerhaften Speicher. Derzeit unterstützt werden als dauerhafte Optionen das bekannte GNU Gdbm und LMDB. Diese Optionen müssen zur Übersetzungszeit des Pakets ausgewählt werden. Die Umsetzung bietet Einhängpunkte, um bei Bedarf weitere Schichten für die Dauerhaftigkeit zu definieren.

**tsv::array set** *varname* *list*
: Tut dasselbe wie der übliche Tcl-Befehl **array set**.

**tsv::array get** *varname* ?pattern?
: Tut dasselbe wie der übliche Tcl-Befehl **array get**.

**tsv::array names** *varname* ?pattern?
: Tut dasselbe wie der übliche Tcl-Befehl **array names**.

**tsv::array size** *varname*
: Tut dasselbe wie der übliche Tcl-Befehl **array size**.

**tsv::array reset** *varname* *list*
: Tut dasselbe wie der übliche Tcl-Befehl **array set**, leert aber *varname* und setzt die neuen Werte aus der Liste atomar.

**tsv::array bind** *varname* *handle*
: Bindet *varname* an den dauerhaften Speicher *handle*. Das Format von *handle* ist <handler>:<address>, wobei <handler> „gdbm“ für GNU Gdbm und „lmdb“ für LMDB ist und <address> der Pfad zur Datenbankdatei.

**tsv::array unbind** *varname*
: Löst das gemeinsame *array* von seinem gebundenen dauerhaften Speicher.

**tsv::array isbound** *varname*
: Gibt wahr (1) zurück, wenn das gemeinsame *varname* an einen dauerhaften Speicher gebunden ist, oder null (0), wenn nicht.


# Befehle für Schlüssellisten

Die Befehle für Schlüssellisten sind dem Paket TclX entlehnt. Schlüssellisten bieten einen strukturierten Datentyp, der auf üblichen Tcl-Listen aufbaut. Das ist eine Funktionalität ähnlich den Structs in der Programmiersprache C.

Eine Schlüsselliste ist eine Liste, in der jedes Element ein Paar aus Schlüssel und Wert enthält. Diese Elementpaare werden selbst als Listen gespeichert, wobei der Schlüssel das erste Element der Liste ist und der Wert das zweite. Die Schlüssel-Wert-Paare heißen Felder. Das ist ein Beispiel einer Schlüsselliste:

```
    {{NAME  {Frank  Zappa}} {JOB {musician and composer}}}
```

Felder dürfen Unterfelder enthalten; das Trennzeichen ist `.' . Unterfelder sind tatsächlich Felder, deren Wert eine weitere Schlüsselliste ist. Die folgende Liste hat also die Felder der obersten Ebene ID und NAME und die Unterfelder NAME.FIRST und NAME.LAST:

```
    {ID 106} {NAME {{FIRST Frank} {LAST Zappa}}}
```

Die Rekursionstiefe der Unterfelder ist nicht begrenzt, sodass sich komplexe Datenstrukturen bauen lassen. Schlüssellisten werden über eine Reihe von Befehlen aufgebaut und verwendet. Alle Befehle zur Verwaltung von Schlüssellisten nehmen den Namen der Variable, die die Schlüsselliste enthält, als Argument (das heißt, als Verweis übergeben), statt die Liste unmittelbar zu übergeben.

**tsv::keyldel** *varname* *keylist* *key*
: Löscht das durch *key* angegebene Feld aus der Schlüsselliste *keylist* in der gemeinsamen Variable *varname*. Das entfernt sowohl den Schlüssel als auch den Wert aus der Schlüsselliste.

**tsv::keylget** *varname* *keylist* *key* ?retvar?
: Gibt den *key* zugeordneten Wert aus der Schlüsselliste *keylist* in der gemeinsamen Variable *varname* zurück. Ist das optionale *retvar* nicht angegeben, wird der Wert als Ergebnis des Befehls zurückgegeben. In diesem Fall entsteht ein Fehler, wenn der Schlüssel in der Liste nicht gefunden wird.

    Ist *retvar* angegeben und steht *key* in der Liste, wird der Wert in der Variable *retvar* zurückgegeben, und der Befehl gibt 1 zurück, wenn der Schlüssel in der Liste vorhanden war. Steht *key* nicht in der Liste, gibt der Befehl 0 zurück, und *retvar* bleibt unverändert. Ist {} für *retvar* angegeben, wird der Wert nicht zurückgegeben, sodass der Tcl-Programmierer feststellen kann, ob ein *key* in einer Schlüsselliste vorhanden ist, ohne als Nebenwirkung eine Variable zu setzen.

**tsv::keylkeys** *varname* *keylist* ?key?
: Gibt die Liste der Schlüssel in der Schlüsselliste *keylist* in der gemeinsamen Variable *varname* zurück. Ist *key* angegeben, ist es der Name eines Schlüsselfelds, dessen Unterfeldschlüssel geholt werden sollen.

**tsv::keylset** *varname* *keylist* *key* *value* ?key value..?
: Setzt den *key* zugeordneten Wert in der Schlüsselliste *keylist* auf *value*. Besteht die *keylist* nicht, wird sie erzeugt. Steht *key* derzeit nicht in der Liste, wird es hinzugefügt. Besteht es bereits, ersetzt *value* den bestehenden Wert. Mehrere Schlüsselwörter und Werte dürfen angegeben werden, falls gewünscht.


# Diskussion

Die aktuelle Umsetzung gemeinsamer Thread-Variablen erlaubt den leichten und bequemen Zugang zu Daten, die verschiedene Threads gemeinsam haben. Intern werden die Daten in Tcl-Objekten gespeichert, und alle Befehle des Pakets arbeiten auf der internen Datendarstellung, wodurch das Shimmering verringert und die Leistung verbessert wird. Besondere Sorgfalt galt der Zusicherung, dass alle Objektdaten richtig gesperrt und tief kopiert werden, wenn Objekte zwischen Threads verschoben werden.

Wegen des internen Entwurfs des Tcl-Kerns gibt es leider keine Möglichkeit, gemeinsame Variablen vollständig in die Tcl-Syntax einzubinden. Jeder Zugriff auf gemeinsame Daten muss mit den mitgelieferten Paketbefehlen erfolgen. Auch Variablen-Traces werden nicht unterstützt. Trotzdem überwiegen die Vorteile der leichten, einfachen und sicheren Bearbeitung gemeinsamer Daten die auferlegten Grenzen.

# Danksagungen

Gemeinsame Thread-Variablen sind von der Schnittstelle nsv im AOLserver angeregt, einem hoch skalierbaren Webserver von America Online.
