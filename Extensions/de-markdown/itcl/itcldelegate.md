---
CommandName: delegation
title: delegation
ManualSection: n
Version: 4.0
TclPart: itcl
TclDescription: "[incr Tcl]"
Keywords:
 - delegation
 - option
 - method
 - proc
Copyright:
 - Copyright (c) 2008 Arnulf Wiedemann
---

# Name

itcl::delegation - Methoden, procs oder Optionen an andere Objekte weiterleiten

Teile dieser Beschreibung sind von der Tcl-Erweiterung \[snit\] „entliehen“, weil die Funktion weitgehend gleich ist.

# Warnung

Das ist neue Funktionalität in \[incr Tcl\], bei der sich die API noch ändern kann!!

# Übersicht

::: {.synopsis} :::
[delegate]{.cmd} [method]{.sub} [methodName]{.arg} [to]{.lit} [componentName]{.arg} [[as]{.lit} [targetName]{.arg}]{.optarg}
[delegate]{.cmd} [method]{.sub} [methodName]{.arg} [[to]{.lit} [componentName]{.arg}]{.optarg} [using]{.lit} [pattern]{.arg}
[delegate]{.cmd} [method]{.sub} [\*]{.arg} [[to]{.lit} [componentName]{.arg}]{.optarg} [[using]{.lit} [pattern]{.arg}]{.optarg} [[except]{.lit} [methodName]{.arg} [methodName]{.arg}]{.optdot}

[delegate]{.cmd} [proc]{.sub} [procName]{.arg} [to]{.lit} [componentName]{.arg} [[as]{.lit} [targetName]{.arg}]{.optarg}
[delegate]{.cmd} [proc]{.sub} [procName]{.arg} [[to]{.lit} [componentName]{.arg}]{.optarg} [using]{.lit} [pattern]{.arg}
[delegate]{.cmd} [proc]{.sub} [\*]{.arg} [[to]{.lit} [componentName]{.arg}]{.optarg} [[using]{.lit} [pattern]{.arg}]{.optarg} [[except]{.lit} [procName]{.arg} [procName]{.arg}]{.optdot}

[delegate]{.cmd} [option]{.sub} [optionSpec]{.arg} [to]{.lit} [componentName]{.arg}
[delegate]{.cmd} [option]{.sub} [optionSpec]{.arg} [to]{.lit} [componentName]{.arg} [as]{.lit} [targetname?]{.arg}
[delegate]{.cmd} [option]{.sub} [\*]{.arg} [to]{.lit} [componentName]{.arg}
[delegate]{.cmd} [option]{.sub} [\*]{.arg} [to]{.lit} [componentName]{.arg} [except]{.lit} [optionName]{.arg} [optionname]{.arg} [...]{.arg}
:::

# Beschreibung

Der Befehl **delegate** wird innerhalb einer Definition extendedclass/widget/widgetadaptor von **\[incr Tcl\]** verwendet, um Methoden, procs oder Optionen zur Behandlung an andere Objekte weiterzuleiten.

**delegate method** *methodName* **to** *componentName* ?**as** *targetName*?
: Diese Form von delegate method leitet die Methode methodName an die Komponente componentName weiter. Wenn also die Methode methodName auf einer Instanz dieses Typs aufgerufen wird, werden die Methode und ihre Argumente stattdessen an den Befehl der genannten Komponente übergeben. Die folgende Anweisung

    ```
    delegate method wag to tail
    ```

    ist ungefähr gleichwertig zu dieser ausdrücklich definierten Methode:

    ```
    method wag {args} {
        uplevel $tail wag $args
    }
    ```

    Die optionale Klausel **as** erlaubt es, den Namen der weitergeleiteten Methode anzugeben und möglicherweise einige Argumente hinzuzufügen:

    ```
    delegate method wagtail to tail as "wag briskly"
    ```

    Eine Methode kann nicht zugleich lokal definiert und weitergeleitet sein.

**delegate method** *methodName* ?**to** *componentName*? **using** *pattern*
: In dieser Form der Anweisung delegate gibt die Klausel **using** die genaue Form des Befehls an, an den der Methodenname weitergeleitet wird. Die Klausel **to** ist optional, weil der gewählte Befehl keine bestimmte Komponente betreffen muss.

    Der Wert der Klausel using ist eine Liste, die einige oder alle der folgenden Ersetzungscodes enthalten darf; diese Codes werden durch den beschriebenen Wert ersetzt, um das Präfix des weitergeleiteten Befehls zu bauen. Die folgenden beiden Anweisungen sind gleichwertig:

    ```
    delegate method wag to tail
    delegate method wag to tail using "%c %m"
    ```

    Jedes Element der Liste wird ein einzelnes Element des weitergeleiteten Befehls; es wird nie erneut als Zeichenkette zerlegt.

    Ersetzungen:

    **%%**
    : Das wird durch ein einzelnes „%“ ersetzt. Um die Zeichenkette „%c“ als Argument an den Befehl zu geben, steht hier „%%c“.

    **%c**
    : Das wird durch den Befehl der genannten Komponente ersetzt.

    **%j**
    : Das wird durch den Methodennamen ersetzt; besteht der Name aus mehreren Token, werden sie durch Unterstriche verbunden ("\").

    **%m**
    : Das wird durch das letzte Token des Methodennamens ersetzt; hat der Methodenname ein Token, ist das identisch mit **%M**.

    **%M**
    : Das wird durch den Methodennamen ersetzt; besteht der Name aus mehreren Token, werden sie durch Leerzeichen verbunden.

    **%n**
    : Das wird durch den Namen des privaten Namespace der Instanz ersetzt.

    **%s**
    : Das wird durch den Namen des Instanzbefehls ersetzt.

    **%t**
    : Das wird durch den voll qualifizierten Typnamen ersetzt.

    **%w**
    : Das wird durch den ursprünglichen Namen des Instanzbefehls ersetzt; bei Itcl-Widgets und Widget-Adaptoren ist das der Tk-Fenstername. Er bleibt gleich, auch wenn der Instanzbefehl umbenannt wird.


**delegate method** *\** ?**to** *componentName*? ?**using** *pattern*? ?**except** *methodName methodName ...*?
: In dieser Form werden alle unbekannten Methodennamen an die angegebene Komponente weitergeleitet. Die Klausel except kann eine Liste von Ausnahmen angeben, also Methodennamen, die nicht so weitergeleitet werden. Die Klausel using ist wie oben definiert. In dieser Form muss die Anweisung die Klausel to, die Klausel using oder beide enthalten.

    Tatsächlich kann das „\“ eine Liste aus zwei oder mehr Token sein, deren letztes Element „\“ ist, wie im folgenden Beispiel:

    ```
    delegate method {tail *} to tail
    ```

    Das definiert implizit die Methode tail, deren Unterbefehle an die Komponente tail weitergeleitet werden.

    Die Definitionen für **delegate proc** ... sind dieselben wie für method, der einzige Unterschied ist, dass es hier um procs geht.

**delegate option** *namespec* **to** *comp*
: siehe unten ...

**delegate option namespec to comp as target**
: siehe unten ...

**delegate option \* to** *comp*
: siehe unten ...

**delegate option \* to** *comp* **except** *exceptions*
: Definiert eine weitergeleitete Option; die namespec ist wie bei der Anweisung option definiert. Wenn die Instanzmethode configure, configurelist oder cget den Wert der Option setzt oder abfragt, wird der gleichwertige Befehl configure oder cget auf die Komponente angewendet, als wäre die Option mit der folgenden **-configuremethod** und **-cgetmethod** definiert worden:

    ```
    method ConfigureMethod {option value} {
        $comp configure $option $value
    }

    method CgetMethod {option} {
        return [$comp cget $option]
    }
    ```

    Weitergeleitete Optionen erscheinen nie im Array **itcl\_options**. Wenn die Klausel as angegeben ist, wird der Zieloptionsname anstelle von name verwendet.

**delegate** *option* **\*** ?**except** *optionName optionName ...*?
: Diese Form leitet alle unbekannten Optionen an die angegebene Komponente weiter. Die Klausel except kann eine Liste von Ausnahmen angeben, also Optionsnamen, die nicht so weitergeleitet werden.

    **Warnung:** Optionen lassen sich nur dann an eine Komponente weiterleiten, wenn sie die Instanzmethoden **configure** und **cget** unterstützt.

    Eine Option kann nicht zugleich lokal definiert und weitergeleitet sein. Offen: hier weitermachen.
