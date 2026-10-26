---
CommandName: snit
title: snit
ManualSection: n
Version: 2.3.4
TclPart: tcllib
TclDescription: Snit's Not Incr Tcl, OO system
Keywords:
 - BWidget
 - C++
 - Incr Tcl
 - Snit
 - adaptors
 - class
 - mega widget
 - object
 - object oriented
 - type
 - widget
 - widget adaptors
Copyright:
 - Copyright (c) 2003-2009, by William H. Duquette
---

# Name

snit – Snit ist kein Incr Tcl

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [2.3.4]{.optlit}
[snit::type]{.cmd} [name]{.arg} [definition]{.arg}
[typevariable]{.cmd} [name]{.arg} [-array]{.optlit} [value]{.optarg}
[typemethod]{.cmd} [name]{.arg} [arglist]{.arg} [body]{.arg}
[typeconstructor]{.cmd} [body]{.arg}
[variable]{.cmd} [name]{.arg} [-array]{.optlit} [value]{.optarg}
[method]{.cmd} [name]{.arg} [arglist]{.arg} [body]{.arg}
[option]{.cmd} [namespec]{.arg} [defaultValue]{.optarg}
[option]{.cmd} [namespec]{.arg} [options...]{.optarg}
[constructor]{.cmd} [arglist]{.arg} [body]{.arg}
[destructor]{.cmd} [body]{.arg}
[proc]{.cmd} [name]{.arg} [args]{.arg} [body]{.arg}
[delegate]{.cmd} [method]{.lit} [name]{.arg} [to]{.lit} [comp]{.arg} [[as]{.lit} [target]{.arg}]{.optarg}
[delegate]{.cmd} [method]{.lit} [name]{.arg} [[to]{.lit} [comp]{.arg}]{.optarg} [using]{.lit} [pattern]{.arg}
[delegate]{.cmd} [method]{.lit} [\*]{.lit} [[to]{.lit} [comp]{.arg}]{.optarg} [[using]{.lit} [pattern]{.arg}]{.optarg} [[except]{.lit} [exceptions]{.arg}]{.optarg}
[delegate]{.cmd} [option]{.lit} [namespec]{.arg} [to]{.lit} [comp]{.arg}
[delegate]{.cmd} [option]{.lit} [namespec]{.arg} [to]{.lit} [comp]{.arg} [as]{.lit} [target]{.arg}
[delegate]{.cmd} [option]{.lit} [\*]{.lit} [to]{.lit} [comp]{.arg}
[delegate]{.cmd} [option]{.lit} [\*]{.lit} [to]{.lit} [comp]{.arg} [except]{.lit} [exceptions]{.arg}
[component]{.cmd} [comp]{.arg} [[-public]{.lit} [method]{.arg}]{.optarg} [[-inherit]{.lit} [flag]{.arg}]{.optarg}
[delegate]{.cmd} [typemethod]{.lit} [name]{.arg} [to]{.lit} [comp]{.arg} [[as]{.lit} [target]{.arg}]{.optarg}
[delegate]{.cmd} [typemethod]{.lit} [name]{.arg} [[to]{.lit} [comp]{.arg}]{.optarg} [using]{.lit} [pattern]{.arg}
[delegate]{.cmd} [typemethod]{.lit} [\*]{.lit} [[to]{.lit} [comp]{.arg}]{.optarg} [[using]{.lit} [pattern]{.arg}]{.optarg} [[except]{.lit} [exceptions]{.arg}]{.optarg}
[typecomponent]{.cmd} [comp]{.arg} [[-public]{.lit} [typemethod]{.arg}]{.optarg} [[-inherit]{.lit} [flag]{.arg}]{.optarg}
[pragma]{.cmd} [options...]{.optarg}
[expose]{.cmd} [comp]{.arg}
[expose]{.cmd} [comp]{.arg} [as]{.lit} [method]{.arg}
[onconfigure]{.cmd} [name]{.arg} [arglist]{.arg} [body]{.arg}
[oncget]{.cmd} [name]{.arg} [body]{.arg}
[snit::widget]{.cmd} [name]{.arg} [definition]{.arg}
[widgetclass]{.cmd} [name]{.arg}
[hulltype]{.cmd} [type]{.arg}
[snit::widgetadaptor]{.cmd} [name]{.arg} [definition]{.arg}
[snit::typemethod]{.cmd} [type]{.arg} [name]{.arg} [arglist]{.arg} [body]{.arg}
[snit::method]{.cmd} [type]{.arg} [name]{.arg} [arglist]{.arg} [body]{.arg}
[snit::macro]{.cmd} [name]{.arg} [arglist]{.arg} [body]{.arg}
[snit::compile]{.cmd} [which]{.arg} [type]{.arg} [body]{.arg}
[$type]{.cmd} [typemethod]{.arg} [args...]{.arg}
[$type]{.cmd} [create]{.lit} [name]{.arg} [option value]{.optdot}
[$type]{.cmd} [info]{.lit} [typevars]{.lit} [pattern]{.optarg}
[$type]{.cmd} [info]{.lit} [typemethods]{.lit} [pattern]{.optarg}
[$type]{.cmd} [info]{.lit} [args]{.lit} [method]{.arg}
[$type]{.cmd} [info]{.lit} [body]{.lit} [method]{.arg}
[$type]{.cmd} [info]{.lit} [default]{.lit} [method]{.arg} [aname]{.arg} [varname]{.arg}
[$type]{.cmd} [info]{.lit} [instances]{.lit} [pattern]{.optarg}
[$type]{.cmd} [destroy]{.lit}
[$object]{.cmd} [method]{.arg} [args...]{.arg}
[$object]{.cmd} [configure]{.lit} [option]{.optarg} [value]{.optarg} ...
[$object]{.cmd} [configurelist]{.lit} [optionlist]{.arg}
[$object]{.cmd} [cget]{.lit} [option]{.arg}
[$object]{.cmd} [destroy]{.lit}
[$object]{.cmd} [info]{.lit} [type]{.lit}
[$object]{.cmd} [info]{.lit} [vars]{.lit} [pattern]{.optarg}
[$object]{.cmd} [info]{.lit} [typevars]{.lit} [pattern]{.optarg}
[$object]{.cmd} [info]{.lit} [typemethods]{.lit} [pattern]{.optarg}
[$object]{.cmd} [info]{.lit} [options]{.lit} [pattern]{.optarg}
[$object]{.cmd} [info]{.lit} [methods]{.lit} [pattern]{.optarg}
[$object]{.cmd} [info]{.lit} [args]{.lit} [method]{.arg}
[$object]{.cmd} [info]{.lit} [body]{.lit} [method]{.arg}
[$object]{.cmd} [info]{.lit} [default]{.lit} [method]{.arg} [aname]{.arg} [varname]{.arg}
[mymethod]{.cmd} [name]{.arg} [args...]{.optarg}
[mytypemethod]{.cmd} [name]{.arg} [args...]{.optarg}
[myproc]{.cmd} [name]{.arg} [args...]{.optarg}
[myvar]{.cmd} [name]{.arg}
[mytypevar]{.cmd} [name]{.arg}
[from]{.cmd} [argvName]{.arg} [option]{.arg} [defvalue]{.optarg}
[install]{.cmd} [compName]{.arg} [using]{.lit} [objType]{.arg} [objName]{.arg} [args...]{.arg}
[installhull]{.cmd} [using]{.lit} [widgetType]{.arg} [args...]{.arg}
[installhull]{.cmd} [name]{.arg}
[variable]{.cmd} [name]{.arg}
[typevariable]{.cmd} [name]{.arg}
[varname]{.cmd} [name]{.arg}
[typevarname]{.cmd} [name]{.arg}
[codename]{.cmd} [name]{.arg}
[snit::boolean]{.cmd} [validate]{.lit} [value]{.optarg}
[snit::boolean]{.cmd} [name]{.arg}
[snit::double]{.cmd} [validate]{.lit} [value]{.optarg}
[snit::double]{.cmd} [name]{.arg} [option value...]{.optarg}
[snit::enum]{.cmd} [validate]{.lit} [value]{.optarg}
[snit::enum]{.cmd} [name]{.arg} [option value...]{.optarg}
[snit::fpixels]{.cmd} [validate]{.lit} [value]{.optarg}
[snit::fpixels]{.cmd} [name]{.arg} [option value...]{.optarg}
[snit::integer]{.cmd} [validate]{.lit} [value]{.optarg}
[snit::integer]{.cmd} [name]{.arg} [option value...]{.optarg}
[snit::listtype]{.cmd} [validate]{.lit} [value]{.optarg}
[snit::listtype]{.cmd} [name]{.arg} [option value...]{.optarg}
[snit::pixels]{.cmd} [validate]{.lit} [value]{.optarg}
[snit::pixels]{.cmd} [name]{.arg} [option value...]{.optarg}
[snit::stringtype]{.cmd} [validate]{.lit} [value]{.optarg}
[snit::stringtype]{.cmd} [name]{.arg} [option value...]{.optarg}
[snit::window]{.cmd} [validate]{.lit} [value]{.optarg}
[snit::window]{.cmd} [name]{.arg}
:::

# Beschreibung

Snit ist ein reines Tcl-Objekt- und Megawidget-System. Es zeichnet sich unter den Tcl-Objektsystemen dadurch aus, dass es nicht auf Vererbung, sondern auf Weiterleitung basiert. Objektsysteme, die auf Vererbung basieren, erlauben es Ihnen lediglich, von Klassen zu erben, die mit demselben System definiert wurden, was einschränkend ist.  In Tcl ist ein Objekt alles, was sich wie ein Objekt verhält; es sollte keine Rolle spielen, wie das Objekt implementiert wurde.  Snit soll Ihnen dabei helfen, Anwendungen aus den vorhandenen Bausteinen zu erstellen; daher ist Snit so konzipiert, dass es jedes Objekt einbinden und darauf aufbauen kann, sei es ein handcodiertes Objekt, ein **Tk**-Widget, ein **Incr Tcl**-Objekt, ein **BWidget** oder fast alles andere.

Diese Manpage dient lediglich als Nachschlagewerk; eine leichter verständliche, eher als Tutorial gestaltete Einführung in die Konzepte von Snit finden Sie im beiliegenden Dokument [snitfaq].

# Snit-Versionen

Diese Manpage behandelt sowohl Snit 2.2 als auch Snit 1.3.  Der wesentliche Unterschied zwischen den beiden Versionen besteht lediglich darin, dass Snit 2.2 Geschwindigkeitsoptimierungen enthält, die auf neuen Funktionen von Tcl 8.5 basieren; Snit 1.3 unterstützt Tcl 8.3, 8.4 und Tcl 8.5.  Es gibt einige geringfügige Abweichungen; diese sind im Text der Manpage mit dem Vermerk „Inkompatibilität mit Snit 1.x“ gekennzeichnet; sie werden zudem im [snitfaq] behandelt.

# Referenz

## Typ- und Widget-Definitionen

Snit stellt die folgenden Befehle zur Definition neuer Typen bereit:

**snit::type** *name* *definition*
: Definiert einen neuen abstrakten Datentyp namens *name*. Ist *name* kein vollständig qualifizierter Befehlsname, wird davon ausgegangen, dass es sich um einen Namen in dem Namespace handelt, in dem der Befehl **snit::type** aufgerufen wurde (in der Regel der globale Namespace).  Der Befehl gibt den vollqualifizierten Namen des neuen Typs zurück.

    Der Typname ist dann ein Befehl, der unter anderem zum Anlegen von Objekten des neuen Typs dient.

    Der *definition*-Block von **snit::type** ist ein Skript, das die folgenden Definitionen enthalten kann:

    **typevariable** *name* ?**-array**? ?*value*?
    : Definiert eine Typvariable namens *name* und optional mit dem Wert *value*.  Typvariablen werden von allen Instanzen des Typs gemeinsam genutzt.  Wenn die Option **-array** angegeben wird, sollte *value* ein Dictionary sein; er wird der Variablen mithilfe von **array set** zugewiesen.

    **typemethod** *name* *arglist* *body*
    : Definiert eine Typmethode – einen Unterbefehl des neuen Typbefehls – mit dem angegebenen Namen, der angegebenen Argumentliste und dem angegebenen Rumpf.  Die *arglist* ist eine normale Tcl-Argumentliste und darf Standardargumente sowie das Argument **args** enthalten; sie darf jedoch nicht die Argumentnamen **type**, **self**, **selfns** oder **win** enthalten.

        Die Variable **type** wird im *body* automatisch auf den vollqualifizierten Namen des Typs gesetzt.  Darüber hinaus sind Typvariablen im *body* jeder Typmethode automatisch sichtbar.

        Wenn *name* aus zwei oder mehr Tokens besteht, behandelt Snit ihn auf besondere Weise:

        ```
            typemethod {a b} {arg} { puts "Got $arg" }
        ```

        Diese Anweisung definiert implizit eine Typmethode namens **a**, die einen Unterbefehl **b** enthält. **b** wird wie folgt aufgerufen:

        ```
            $type a b "Hello, world!"
        ```

        **a** kann eine beliebige Anzahl von Unterbefehlen enthalten. Dadurch lässt sich eine hierarchische Befehlsstruktur definieren; weitere Beispiele finden Sie weiter unten unter **method**.

        Typmethoden können Befehle aus dem Namespace aufrufen, in dem der Typ definiert ist, ohne diese importieren zu müssen; wenn der Typname beispielsweise **::parentns::typename** lautet, dann können die Typmethoden dieses Typs **::parentns::someproc** genauso aufrufen wie **someproc**. *Inkompatibilität mit Snit 1.x:* Dies funktioniert in Snit 1.x nicht, da es von **namespace path** abhängt, einem neuen Befehl in Tcl 8.5.

        *Inkompatibilität mit Snit 1.x:* In Snit 1.x sind die folgenden beiden Aufrufe dieser Typmethode gleichwertig:

        ```
            $type a b "Hello, world!"
            $type {a b} "Hello, world!"
        ```

        In Snit 2.2 ist die zweite Form ungültig.

    **typeconstructor** *body*
    : Der Rumpf *body* des Typkonstruktors wird einmalig ausgeführt, wenn der Typ zum ersten Mal definiert wird; er wird in der Regel dazu verwendet, Typvariablen mit Array-Werten zu initialisieren und Einträge zur [Tk-Optionsdatenbank] hinzuzufügen.

        Die Variable **type** wird automatisch im *body* definiert und enthält den vollqualifizierten Namen des Typs. Darüber hinaus sind Typvariablen im *body* des Typkonstruktors automatisch sichtbar.

        Ein Typ darf höchstens einen Typkonstruktor definieren.

        Der Typkonstruktor kann Befehle aus dem Namespace aufrufen, in dem der Typ definiert ist, ohne diese importieren zu müssen; wenn der Typname beispielsweise **::parentns::typename** lautet, dann kann der Typkonstruktor **::parentns::someproc** ebenso aufrufen wie **someproc**. *Inkompatibilität mit Snit 1.x:* Dies funktioniert nicht in Snit 1.x, da es von **namespace path** abhängt, einem neuen Befehl in Tcl 8.5.

    **variable** *name* ?**-array**? ?*value*?
    : Definiert eine Instanzvariable, d. h. eine private Variable, die jeder Instanz dieses Typs zugeordnet ist, sowie optional deren Anfangswert. Wenn die Option **-array** angegeben wird, sollte *value* ein Dictionary sein; dieses wird der Variablen mithilfe von **array set** zugewiesen.

    **method** *name* *arglist* *body*
    : Definiert eine Instanzmethode, d. h. einen Unterbefehl jeder Instanz dieses Typs, mit dem angegebenen Namen, der Argumentliste und dem Rumpf. Die *arglist* ist eine normale Tcl-Argumentliste und kann Standardargumente sowie das Argument **args** enthalten.

        Der Methode werden implizit außerdem die folgenden Argumente übergeben: **type**, das den vollqualifizierten Typnamen enthält; **self**, das den Namen des aktuellen Instanzbefehls enthält; **selfns**, das den Namen des privaten Namespaces der Instanz enthält; und **win**, das den ursprünglichen Instanznamen enthält. Folglich darf die *arglist* die Argumentnamen **type**, **self**, **selfns** oder **win** nicht enthalten.

        Eine auf diese Weise definierte Instanzmethode wird als *lokal definiert* bezeichnet.

        Typ- und Instanzvariablen sind automatisch in allen Instanzmethoden sichtbar.  Verfügt der Typ über lokal definierte Optionen, ist auch das Array **options** sichtbar.

        Wenn *name* aus zwei oder mehr Tokens besteht, behandelt Snit ihn auf besondere Weise:

        ```
            method {a b} {} { ... }
        ```

        Diese Anweisung definiert implizit eine Methode namens **a**, die einen Unterbefehl namens **b** enthält. **b** wird wie folgt aufgerufen:

        ```
            $self a b "Hello, world!"
        ```

        **a** kann eine beliebige Anzahl von Unterbefehlen enthalten. Dadurch lässt sich eine hierarchische Befehlsstruktur definieren:

        ```
        % snit::type dog {
            method {tail wag}   {} {return "Wag, wag"}
            method {tail droop} {} {return "Droop, droop"}
        }
        ::dog
        % dog spot
        ::spot
        % spot tail wag
        Wag, wag
        % spot tail droop
        Droop, droop
        %
        ```

        Wir haben implizit eine Methode „tail“ mit den Unterbefehlen „wag“ und „droop“ definiert.  Folglich ist es ein Fehler, „tail“ explizit zu definieren.

        Methoden können Befehle aus dem Namespace aufrufen, in dem der Typ definiert ist, ohne diese importieren zu müssen; wenn der Typname beispielsweise **::parentns::typename** lautet, dann können die Methoden des Typs **::parentns::someproc** ebenso aufrufen wie **someproc**. *Inkompatibilität mit Snit 1.x:* Dies funktioniert in Snit 1.x nicht, da es von **namespace path** abhängt, einem neuen Befehl in Tcl 8.5.

        *Inkompatibilität mit Snit 1.x:* In Snit 1.x sind die folgenden beiden Aufrufe dieser Methode gleichbedeutend:

        ```
            $self a b "Hello, world!"
            $self {a b} "Hello, world!"
        ```

        In Snit 2.2 ist die zweite Form ungültig.

    **option** *namespec* ?*defaultValue*?
    : siehe unten ...

    **option** *namespec* ?*options...*?
    : Definiert eine Option für Instanzen dieses Typs und weist ihr optional einen Anfangswert zu. Der Anfangswert ist standardmäßig die leere Zeichenkette, wenn kein *defaultValue* festgelegt wird.

        Eine auf diese Weise definierte Option wird als *lokal definiert* bezeichnet.

        Der *namespec* ist eine Liste, die den Namen der Option, den Ressourcennamen und den Namen der Klasse definiert, z. B.:

        ```
            option {-font font Font} {Courier 12}
        ```

        Der Name der Option muss mit einem Bindestrich beginnen und darf keine Großbuchstaben enthalten. Der Ressourcenname und der Klassenname sind optional; werden sie nicht angegeben, wird als Ressourcenname standardmäßig der Name der Option ohne Bindestrich verwendet, und als Klassenname standardmäßig der Ressourcenname mit großem Anfangsbuchstaben. Somit entspricht die folgende Anweisung dem vorherigen Beispiel:

        ```
            option -font {Courier 12}
        ```

        Weitere Informationen zu Ressourcen- und Klassennamen finden Sie im Abschnitt [Tk-Optionsdatenbank].

        Optionen werden normalerweise mithilfe der Standard-Instanzmethoden **configure** und **cget** gesetzt und abgerufen; innerhalb des Instanzcodes (Methodenrümpfe usw.) stehen die Werte der Optionen über das Array **options** zur Verfügung:

        ```
            set myfont $options(-font)
        ```

        Wenn der Typ Optionshandler definiert (z. B. **-configuremethod**), sollte er wahrscheinlich **configure** und **cget** verwenden, um auf seine Optionen zuzugreifen, damit subtile Fehler vermieden werden.

        Die Anweisung **option** kann die folgenden Optionen enthalten:

        **-default** *defvalue*
        : Legt den Vorgabewert der Option fest; sonst ist der Vorgabewert der Option "".

        **-readonly** *flag*
        : *flag* kann ein beliebiger boolescher Wert sein, der von Tcl erkannt wird. Wenn *flag* wahr ist, ist die Option schreibgeschützt – sie kann nur bei der Erstellung mithilfe von **configure** oder **configurelist** gesetzt werden, d. h. im Konstruktor des Typs.

        **-type** *type*
        : Jede lokal definierte Option kann ihren Validierungstyp festlegen; dabei kann es sich entweder um den Namen eines Validierungstyps oder um eine Spezifikation für einen Validierungsuntertyp handeln.

            Beispielsweise kann eine Option festlegen, dass ihr Wert eine ganze Zahl sein muss, indem sie **snit::integer** als Validierungstyp angibt:

            ```
                option -number -type snit::integer
            ```

            Sie kann auch festlegen, dass ihr Wert eine ganze Zahl zwischen 1 und 10 ist, indem sie einen Validierungsuntertyp angibt:

            ```
                option -number -type {snit::integer -min 1 -max 10}
            ```

            Wenn für eine Option ein Validierungstyp oder -untertyp definiert wird, so wird dieser zur Validierung des Werts der Option herangezogen, sobald dieser durch die Methoden **configure** oder **configurelist** des Objekts geändert wird.  Darüber hinaus werden die Werte aller dieser Optionen unmittelbar nach der Ausführung des Konstruktors automatisch validiert.

            Snit definiert eine Reihe von Validierungstypen und -untertypen, und es ist recht einfach, neue zu definieren.  Eine vollständige Liste finden Sie im Abschnitt [Validierungstypen], und im Abschnitt [Validierungstypen definieren] erfahren Sie, wie Sie eigene Typen definieren können.

        **-cgetmethod** *methodName*
        : Jede lokal definierte Option kann eine **-cgetmethod** definieren; diese wird aufgerufen, wenn der Wert der Option mithilfe der Methode **cget** abgerufen wird.  Was auch immer der Rumpf *body* der Methode zurückgibt, ist der Rückgabewert des Aufrufs von **cget**.

            Die benannte Methode muss ein Argument entgegennehmen, nämlich den Namen der Option. Dieser Code entspricht beispielsweise der Standardbehandlung von **cget** durch Snit (ist jedoch langsamer):

            ```
                option -font -cgetmethod GetOption
                method GetOption {option} {
                    return $options($option)
                }
            ```

            Beliebig viele Optionen können sich eine **-cgetmethod** teilen.

        **-configuremethod** *methodName*
        : Jede lokal definierte Option kann eine **-configuremethod** definieren; diese wird aufgerufen, wenn der Wert der Option mithilfe der Methoden **configure** oder **configurelist** festgelegt wird.  Es obliegt der benannten Methode, den Wert der Option zu speichern; mit anderen Worten: Der Wert wird nur dann im Array **options()** gespeichert, wenn die Methode ihn dort ablegt.

            Die benannte Methode muss zwei Argumente entgegennehmen: den Namen der Option und ihren neuen Wert.  Beispielsweise entspricht dieser Code der standardmäßigen Behandlung von **configure** durch Snit (ist jedoch langsamer als diese):

            ```
                option -font -configuremethod SetOption
                method SetOption {option value} {
                    set options($option) $value
                }
            ```

            Beliebig viele Optionen können sich eine einzelne **-configuremethod** teilen.

        **-validatemethod** *methodName*
        : Jede lokal definierte Option kann eine **-validatemethod** definieren; diese wird aufgerufen, wenn der Wert der Option mithilfe der Methoden **configure** oder **configurelist** gesetzt wird, unmittelbar vor der Methode **-configuremethod** (sofern vorhanden).  Es ist Aufgabe der benannten Methode, den neuen Wert der Option zu validieren und einen Fehler auszulösen, falls der Wert ungültig ist.

            Die benannte Methode muss zwei Argumente entgegennehmen: den Namen der Option und deren neuen Wert.  Dieser Code überprüft beispielsweise, ob der Wert von **-flag** ein gültiger boolescher Wert ist:

            ```
                option -font -validatemethod CheckBoolean
                method CheckBoolean {option value} {
                    if {![string is boolean -strict $value]} {
                        error "option $option must have a boolean value."
                    }
                }
            ```

            Beliebig viele Optionen können sich eine einzelne **-validatemethod** teilen.


    **constructor** *arglist* *body*
    : Die Konstruktordefinition legt den Code *body* fest, der bei der Erstellung einer neuen Instanz ausgeführt werden soll. Die *arglist* ist eine normale Tcl-Argumentliste und kann Standardargumente sowie das Argument **args** enthalten.

        Wie bei Methoden werden die Argumente **type**, **self**, **selfns** und **win** implizit definiert, und alle Typ- und Instanzvariablen sind in seinem *body* automatisch sichtbar.

        Wenn *definition* den Konstruktor nicht explizit definiert, definiert Snit implizit einen.  Wenn der Typ mindestens eine Option deklariert (sei es lokal oder durch Weiterleitung), wird der Standardkonstruktor wie folgt definiert:

        ```
            constructor {args} {
                $self configurelist $args
            }
        ```

        Für das Standardverhalten eines Tk-Widgets sollte die Argumentliste, wie dargestellt, aus dem einzelnen Namen **args** bestehen.

        Wenn *definition* weder einen Konstruktor noch Optionen definiert, wird der Standardkonstruktor wie folgt definiert:

        ```
            constructor {} {}
        ```

        Wie bei Methoden kann der Konstruktor Befehle aus dem Namespace aufrufen, in dem der Typ definiert ist, ohne diese importieren zu müssen; wenn der Typname beispielsweise **::parentns::typename** lautet, dann kann der Konstruktor **::parentns::someproc** genauso aufrufen wie **someproc**. *Inkompatibilität mit Snit 1.x:* Dies funktioniert nicht in Snit 1.x, da es von **namespace path** abhängt, einem neuen Befehl in Tcl 8.5.

    **destructor** *body*
    : Der Destruktor dient dazu, alle Aktionen zu programmieren, die bei der Zerstörung einer Instanz des Typs ausgeführt werden müssen: typischerweise die Zerstörung aller im Konstruktor erzeugten Elemente.

        Der Destruktor nimmt keine expliziten Argumente entgegen; wie bei den Methoden werden die Argumente **type**, **self**, **selfns** und **win** implizit definiert, und alle Typ- und Instanzvariablen sind in seinem *body* automatisch sichtbar. Wie bei Methoden kann der Destruktor Befehle aus dem Namespace aufrufen, in dem der Typ definiert ist, ohne diese importieren zu müssen; wenn der Typname beispielsweise **::parentns::typename** lautet, dann kann der Destruktor **::parentns::someproc** genauso aufrufen wie **someproc**. *Inkompatibilität mit Snit 1.x:* Dies funktioniert nicht in Snit 1.x, da es von **namespace path** abhängt, einem neuen Befehl in Tcl 8.5.

    **proc** *name* *args* *body*
    : Definiert eine neue Tcl-Prozedur im Namespace des Typs.

        Die definierte Prozedur unterscheidet sich von einer normalen Tcl-Prozedur dadurch, dass alle Typvariablen automatisch sichtbar sind. Die Prozedur kann zudem auf Instanzvariablen zugreifen, sofern ihr **selfns** (mit genau diesem Namen) als eines ihrer Argumente übergeben wird.

        Obwohl sie für Prozeduren nicht implizit definiert sind, sollten die Argumentnamen **type**, **self** und **win** vermieden werden.

        Wie bei Methoden und Typmethoden können Prozeduren Befehle aus dem Namespace aufrufen, in dem der Typ definiert ist, ohne diese importieren zu müssen; wenn der Typname beispielsweise **::parentns::typename** lautet, dann kann die Prozedur **::parentns::someproc** genauso aufrufen wie **someproc**. *Inkompatibilität mit Snit 1.x:* Dies funktioniert nicht in Snit 1.x, da es von **namespace path** abhängt, einem neuen Befehl in Tcl 8.5.

    **delegate** **method** *name* **to** *comp* ?**as** *target*?
    : Die Methode *name* wird an die Komponente *comp* weitergeleitet. Das heißt, wenn die Methode *name* für eine Instanz dieses Typs aufgerufen wird, werden die Methode und ihre Argumente stattdessen an den Befehl der angegebenen Komponente übergeben. Das heißt, die folgende Anweisung

        ```
            delegate method wag to tail
        ```

        ist ungefähr gleichwertig zu dieser ausdrücklich definierten Methode:

        ```
            method wag {args} {
                uplevel $tail wag $args
            }
        ```

        Wie bei Methoden kann *name* aus mehreren Tokens bestehen; in diesem Fall wird davon ausgegangen, dass das letzte Token des Namens der Name der Methode der Komponente ist.

        Mit der optionalen Klausel **as** können Sie den Namen der weitergeleiteten Methode angeben und gegebenenfalls einige Argumente hinzufügen:

        ```
            delegate method wagtail to tail as "wag briskly"
        ```

        Eine Methode kann nicht zugleich lokal definiert und weitergeleitet sein.

        **Hinweis:** Alle Formen von **delegate method** können sowohl an Instanzkomponenten als auch an Typkomponenten weitergeleitet werden.

    **delegate** **method** *name* ?**to** *comp*? **using** *pattern*
    : In dieser Form der Anweisung **delegate** wird die Klausel **using** verwendet, um die genaue Form des Befehls festzulegen, an den die Methode *name* weitergeleitet wird.  In dieser Form ist die **to**-Klausel optional, da der gewählte Befehl möglicherweise keine bestimmte Komponente beinhaltet.

        Der Wert der Klausel **using** ist eine Liste, die einen oder alle der folgenden Ersetzungscodes enthalten kann; diese Codes werden durch den beschriebenen Wert ersetzt, um das Präfix des weitergeleiteten Befehls zu bilden. Hinweis: Die folgenden beiden Anweisungen sind gleichwertig:

        ```
            delegate method wag to tail
            delegate method wag to tail using "%c %m"
        ```

        Jedes Element der Liste wird zu einem einzelnen Element des weitergeleiteten Befehls – es wird niemals erneut als Zeichenkette geparst.

        Ersetzungen:

        **%%**
        : Dies wird durch ein einzelnes „%“ ersetzt. Um also die Zeichenfolge „%c“ als Argument an den Befehl zu übergeben, würden Sie „%%c“ schreiben.

        **%c**
        : Das wird durch den Befehl der genannten Komponente ersetzt.

        **%m**
        : Dies wird durch das letzte Token der Methode *name* ersetzt; wenn die Methode *name* aus einem Token besteht, entspricht dies **%M**.

        **%M**
        : Dies wird durch die Methode *name* ersetzt; wenn *name* aus mehreren Tokens besteht, werden diese durch Leerzeichen verbunden.

        **%j**
        : An deren Stelle tritt die Methode *name*; wenn *name* aus mehreren Tokens besteht, werden diese durch Unterstriche („\_“) verbunden.

        **%t**
        : Das wird durch den voll qualifizierten Typnamen ersetzt.

        **%n**
        : Das wird durch den Namen des privaten Namespace der Instanz ersetzt.

        **%s**
        : Das wird durch den Namen des Instanzbefehls ersetzt.

        **%w**
        : Dies wird durch den ursprünglichen Namen des Instanzbefehls ersetzt; bei Snit-Widgets und Widget-Adaptern ist dies der Name des Tk-Fensters. Er bleibt unverändert, auch wenn der Instanzbefehl umbenannt wird.


    **delegate** **method** **\*** ?**to** *comp*? ?**using** *pattern*? ?**except** *exceptions*?
    : Die Form **delegate method \*** leitet alle unbekannten Methodennamen an die angegebene Komponente *comp* weiter. Mit der Klausel **except** kann eine Liste von Ausnahmen *exceptions* festgelegt werden, d. h. Namen von Methoden, die nicht auf diese Weise weitergeleitet werden. Die Klausel **using** ist wie oben angegeben definiert. In dieser Form muss die Anweisung entweder die Klausel **to**, die Klausel **using** oder beide enthalten.

        Tatsächlich kann das „\*“ eine Liste aus zwei oder mehr Tokens sein, deren letztes Element „\*“ ist, wie im folgenden Beispiel:

        ```
            delegate method {tail *} to tail
        ```

        Dadurch wird implizit die Methode **tail** definiert, deren Unterbefehle an die Komponente **tail** weitergeleitet werden.

    **delegate** **option** *namespec* **to** *comp*
    : siehe unten ...

    **delegate** **option** *namespec* **to** *comp* **as** *target*
    : siehe unten ...

    **delegate** **option** **\*** **to** *comp*
    : siehe unten ...

    **delegate** **option** **\*** **to** *comp* **except** *exceptions*
    : Definiert eine weitergeleitete Option; *namespec* ist wie bei der Anweisung **option** definiert. Wenn die Instanzmethode **configure**, **configurelist** oder **cget** zum Setzen oder Abrufen des Werts der Option verwendet wird, wird der entsprechende Befehl **configure** oder **cget** auf die Komponente angewendet, als ob die Option mit der folgenden **-configuremethod** und **-cgetmethod** definiert worden wäre:

        ```
            method ConfigureMethod {option value} {
                $comp configure $option $value
            }

            method CgetMethod {option} {
                return [$comp cget $option]
            }
        ```

        Hinweis: Weitergeleitete Optionen erscheinen niemals im Array **options**.

        Wenn die Klausel **as** angegeben ist, wird anstelle von *name* der Optionsname *target* verwendet.

        Die Form **delegate option \*** leitet alle unbekannten Optionen an die angegebene Komponente *comp* weiter. Mit der Klausel **except** kann eine Liste von Ausnahmen *exceptions* festgelegt werden, d. h. Namen von Optionen, die nicht auf diese Weise weitergeleitet werden.

        Warnung: Optionen können nur an eine Komponente weitergeleitet werden, wenn diese die Instanzmethoden **configure** und **cget** unterstützt.

        Eine Option kann nicht gleichzeitig lokal definiert und weitergeleitet werden. TBD: Hier fortsetzen.

    **component** *comp* ?**-public** *method*? ?**-inherit** *flag*?
    : Deklariert explizit eine Komponente namens *comp* und definiert automatisch die Instanzvariable der Komponente.

        Wenn die Option **-public** angegeben wird, wird die Komponente durch die Definition einer *method* öffentlich gemacht, deren Unterbefehle an die Komponente weitergeleitet werden. So entspricht beispielsweise die Angabe von **-public mycomp** Folgendem:

        ```
            component mycomp
            delegate method {mymethod *} to mycomp
        ```

        Wenn die Option **-inherit** festgelegt wird, muss *flag* ein boolescher Wert sein; ist *flag* wahr, werden alle unbekannten Methoden und Optionen an diese Komponente weitergeleitet.  Der Name **-inherit** impliziert, dass Instanzen dieses neuen Typs in gewisser Weise die Methoden und Optionen der Komponente erben. Das heißt, **-inherit yes** entspricht:

        ```
            component mycomp
            delegate option * to mycomp
            delegate method * to mycomp
        ```

    **delegate** **typemethod** *name* **to** *comp* ?**as** *target*?
    : Leitet die Typmethode *name* an die Typkomponente *comp* weiter. Das heißt, wenn die Typmethode *name* für diesen Typ aufgerufen wird, werden die Typmethode und ihre Argumente stattdessen an den Befehl der angegebenen Typkomponente übergeben. Das heißt, die folgende Anweisung

        ```
            delegate typemethod lostdogs to pound
        ```

        ist ungefähr gleichwertig zu dieser ausdrücklich definierten Methode:

        ```
            typemethod lostdogs {args} {
                uplevel $pound lostdogs $args
            }
        ```

        Wie bei Typmethoden kann *name* aus mehreren Tokens bestehen; in diesem Fall wird davon ausgegangen, dass das letzte Token des Namens der Name der Methode der Komponente ist.

        Mit der optionalen Klausel **as** können Sie den Namen der weitergeleiteten Methode angeben und gegebenenfalls einige Argumente hinzufügen:

        ```
            delegate typemethod lostdogs to pound as "get lostdogs"
        ```

        Eine Typmethode kann nicht gleichzeitig lokal definiert und weitergeleitet werden.

    **delegate** **typemethod** *name* ?**to** *comp*? **using** *pattern*
    : In dieser Form der Anweisung **delegate** wird die Klausel **using** verwendet, um die genaue Form des Befehls festzulegen, an den die Typmethode *name* weitergeleitet wird.  In dieser Form ist die **to**-Klausel optional, da der gewählte Befehl möglicherweise keine bestimmte Typkomponente beinhaltet.

        Der Wert der Klausel **using** ist eine Liste, die einen oder alle der folgenden Ersetzungscodes enthalten kann; diese Codes werden durch den beschriebenen Wert ersetzt, um das Präfix des weitergeleiteten Befehls zu bilden. Hinweis: Die folgenden beiden Anweisungen sind gleichbedeutend:

        ```
            delegate typemethod lostdogs to pound
            delegate typemethod lostdogs to pound using "%c %m"
        ```

        Jedes Element der Liste wird zu einem einzelnen Element des weitergeleiteten Befehls – es wird niemals erneut als Zeichenkette geparst.

        Ersetzungen:

        **%%**
        : Dies wird durch ein einzelnes „%“ ersetzt. Um also die Zeichenfolge „%c“ als Argument an den Befehl zu übergeben, würden Sie „%%c“ schreiben.

        **%c**
        : Dies wird durch den Befehl der benannten Typkomponente ersetzt.

        **%m**
        : Dies wird durch das letzte Token der Typmethode *name* ersetzt; wenn die Typmethode *name* aus einem Token besteht, entspricht dies **%M**.

        **%M**
        : An deren Stelle tritt die Typmethode *name*; wenn *name* aus mehreren Tokens besteht, werden diese durch Leerzeichen verbunden.

        **%j**
        : An deren Stelle tritt die Typmethode *name*; wenn *name* aus mehreren Tokens besteht, werden diese durch Unterstriche („\_“) verbunden.

        **%t**
        : Das wird durch den voll qualifizierten Typnamen ersetzt.


    **delegate** **typemethod** **\*** ?**to** *comp*? ?**using** *pattern*? ?**except** *exceptions*?
    : Die Form **delegate typemethod \*** leitet alle unbekannten Typmethodennamen an die angegebene Typkomponente weiter. Mit der Klausel **except** kann eine Liste von Ausnahmen *exceptions* festgelegt werden, d. h. Namen von Typmethoden, die nicht auf diese Weise weitergeleitet werden. Die Klausel **using** ist wie oben angegeben definiert. In dieser Form muss die Anweisung entweder die Klausel **to**, die Klausel **using** oder beide enthalten.

        **Hinweis:** Standardmäßig interpretiert Snit **$type foo** – wobei **foo** keine definierte Typmethode ist – als gleichbedeutend mit **$type create foo**, wobei **foo** der Name einer neuen Instanz des Typs ist.  Wenn Sie **delegate typemethod \*** verwenden, muss die Typmethode **create** stets explizit verwendet werden.

        Das „\*“ kann eine Liste aus zwei oder mehr Tokens sein, deren letztes Element „\*“ ist, wie im folgenden Beispiel:

        ```
            delegate typemethod {tail *} to tail
        ```

        Hiermit wird implizit die Typmethode **tail** definiert, deren Unterbefehle an die Typkomponente **tail** weitergeleitet werden.

    **typecomponent** *comp* ?**-public** *typemethod*? ?**-inherit** *flag*?
    : Deklariert explizit eine Typkomponente namens *comp* und definiert automatisch die Typvariable der Komponente. Eine Typkomponente ist ein beliebiger Befehl, an den Typmethoden und Instanzmethoden weitergeleitet werden können; der Name des Befehls wird in einer Typvariablen gespeichert.

        Wenn die Option **-public** angegeben wird, wird die Typkomponente durch die Definition einer *typemethod* öffentlich gemacht, deren Unterbefehle an die Typkomponente weitergeleitet werden; die Angabe von **-public mytypemethod** entspricht beispielsweise Folgendem:

        ```
            typecomponent mycomp
            delegate typemethod {mytypemethod *} to mycomp
        ```

        Wenn die Option **-inherit** festgelegt wird, muss *flag* ein boolescher Wert sein; ist *flag* wahr, werden alle unbekannten Typmethoden an diese Typkomponente weitergeleitet. (Siehe den Hinweis zu „delegate typemethod \*“ weiter oben.) Der Name **-inherit** impliziert, dass dieser Typ in gewisser Weise das Verhalten der Typkomponente erbt. Das heißt, **-inherit yes** entspricht:

        ```
            typecomponent mycomp
            delegate typemethod * to mycomp
        ```

    **pragma** ?*options...*?
    : Die Anweisung **pragma** ermöglicht die Steuerung der Art und Weise, wie Snit einen Typ generiert.  Sie akzeptiert die folgenden Optionen; in jedem Fall muss *flag* ein von Tcl erkannter boolescher Wert sein, z. B. **0**, **1**, **yes**, **no** usw.

        Indem Sie die Pragmas **-hastypeinfo**, **-hastypedestroy** und **-hasinstances** auf „false“ setzen und entsprechende Typmethoden definieren, können Sie einen Ensemble-Befehl ohne jegliches unerwünschtes Verhalten erstellen.

        **-canreplace** *flag*
        : Wenn der Wert „false“ (Standard) eingestellt ist, erstellt Snit keine Instanz eines **snit::type**, deren Name mit dem eines bereits vorhandenen Befehls übereinstimmt; dadurch werden subtile Fehler vermieden. Durch Setzen dieses Pragmas auf „true“ wird das Verhalten von Snit V0.93 und früheren Versionen wiederhergestellt.

        **-hastypeinfo** *flag*
        : Ist dieser Wert auf „true“ gesetzt (Standardeinstellung), verfügt der generierte Typ über eine Typmethode namens **info**, die zur Typintrospektion verwendet wird; die Typmethode **info** wird im Folgenden beschrieben. Ist dieser Wert auf „false“ gesetzt, ist dies nicht der Fall.

        **-hastypedestroy** *flag*
        : Ist dieser Wert auf „true“ gesetzt (Standardeinstellung), verfügt der generierte Typ über eine Typmethode namens **destroy**, die dazu dient, den Typ und alle seine Instanzen zu löschen. Die Typmethode **destroy** wird im Folgenden beschrieben. Wenn dieser Wert auf „false“ gesetzt ist, ist dies nicht der Fall.

        **-hastypemethods** *flag*
        : Ist dieser Wert auf „true“ gesetzt (Standardeinstellung), verfügt der Typbefehl des generierten Typs wie üblich über Unterbefehle (Typmethoden).  Wenn der Wert „false“ ist, dient der Typbefehl ausschließlich dazu, Instanzen des Typs zu erstellen; das erste Argument ist der Name der Instanz.

            Dieses Pragma und **-hasinstances** können nicht beide auf „false“ gesetzt werden.

        **-hasinstances** *flag*
        : Wenn dieser Wert auf „true“ gesetzt (Standardeinstellung) ist, verfügt der generierte Typ über eine Typmethode namens **create**, die zum Erstellen von Instanzen des Typs sowie für eine Reihe von instanzbezogenen Funktionen verwendet wird. Wenn der Wert auf „false“ gesetzt ist, ist dies nicht der Fall.

            Dieses Pragma und **-hastypemethods** können nicht beide auf „false“ gesetzt werden.

        **-hasinfo** *flag*
        : Ist dieser Wert auf „true“ gesetzt (Standardeinstellung), verfügen Instanzen des generierten Typs über eine Instanzmethode namens **info**, die zur Instanzintrospektion dient; die Methode **info** wird weiter unten beschrieben. Wenn der Wert auf „false“ gesetzt ist, ist dies nicht der Fall.

        **-simpledispatch** *flag*
        : Dieses Pragma soll einfache, häufig verwendete abstrakte Datentypen (z. B. Stacks und Warteschlangen) effizienter machen.

            Ist der Wert „false“ (Standard), werden Instanzmethoden wie gewohnt aufgerufen. Ist er „true“, wird stattdessen ein schnelleres Aufrufschema verwendet. Diese Geschwindigkeitssteigerung hat jedoch ihren Preis; bei **-simpledispatch yes** gelten folgende Einschränkungen:

            - Methoden können nicht weitergeleitet werden.

            - **uplevel** und **upvar** funktionieren nicht wie erwartet: Der Geltungsbereich des Aufrufers liegt zwei Ebenen höher statt einer.

            - Die Methoden zur Behandlung von Optionen (**cget**, **configure** und **configurelist**) sind geringfügig langsamer.



    **expose** *comp*
    : siehe unten ...

    **expose** *comp* **as** *method*
    : **Veraltet.**  Um die Komponente *comp* öffentlich zugänglich zu machen, verwenden Sie die Option **-public** von **component**.

    **onconfigure** *name* *arglist* *body*
    : **Veraltet.** Definieren Sie stattdessen die Option **-configuremethod** von **option**.

        Ab Version 0.95 werden die folgenden Definitionen,

        ```
            option -myoption
            onconfigure -myoption {value} {
                # Code to save the option's value
            }
        ```

        wie folgt umgesetzt:

        ```
            option -myoption -configuremethod _configure-myoption
            method _configure-myoption {_option value} {
                # Code to save the option's value
            }
        ```

    **oncget** *name* *body*
    : **Veraltet.** Definieren Sie stattdessen die Option **-cgetmethod** von **option**.

        Ab Version 0.95 werden die folgenden Definitionen,

        ```
            option -myoption
            oncget -myoption {
                # Code to return the option's value
            }
        ```

        wie folgt umgesetzt:

        ```
            option -myoption -cgetmethod _cget-myoption
            method _cget-myoption {_option} {
                # Code to return the option's value
            }
        ```


**snit::widget** *name* *definition*
: Dieser Befehl definiert einen Snit-Megawidget-Typ mit dem angegebenen Namen *name*. *definition* wird wie bei **snit::type** angegeben. Ein **snit::widget** unterscheidet sich in folgenden Punkten von einem **snit::type**:

    - Jede Instanz von **snit::widget** verfügt über eine automatisch erstellte Komponente namens **hull**, bei der es sich in der Regel um ein Tk-Frame-Widget handelt. Andere Widgets, die als Teil des Megawidgets erstellt werden, werden innerhalb dieses Widgets angelegt.

        Die Hull-Komponente wird zunächst mit dem angeforderten Widget-Namen erstellt; anschließend vollbringt Snit ein kleines Wunder, indem es die Hull-Komponente umbenennt und an ihrer Stelle einen eigenen Instanzbefehl einfügt. Der neue Name der Hull-Komponente wird in einer Instanzvariablen namens **hull** gespeichert.

    - Der Name einer Instanz muss ein gültiger Tk-Fenstername sein, und das übergeordnete Fenster muss vorhanden sein.


    Eine **snit::widget**-Definition kann alle Anweisungen enthalten, die in einer **snit::type**-Definition zulässig sind, und kann darüber hinaus Folgendes umfassen:

    **widgetclass** *name*
    : Legt die Widget-Klasse des **snit::widget** auf *name* fest und überschreibt damit die Standardeinstellung. Weitere Informationen finden Sie im Abschnitt [Tk-Optionsdatenbank].

    **hulltype** *type*
    : Legt fest, welche Art von Widget als Hull des **snit::widget** verwendet wird. *type* kann **frame** (Standard), **toplevel** oder **labelframe** sein; die qualifizierten Entsprechungen davon, **tk::frame**, **tk::toplevel** und **tk::labelframe**; oder, wenn verfügbar, die entsprechenden Tile-Widgets: **ttk::frame**, **ttk::toplevel** und **ttk::labelframe**.  In der Praxis kann jedes Widget, das die Option **-class** unterstützt, als Hull-Widget verwendet werden, indem sein Name mit **lappend** an die Variable **snit::hulltypes** angehängt wird.


**snit::widgetadaptor** *name* *definition*
: Dieser Befehl definiert einen Snit-Megawidget-Typ mit dem angegebenen Namen. Er unterscheidet sich von **snit::widget** dadurch, dass die Komponente **hull** der Instanz nicht automatisch erstellt wird, sondern im Konstruktor angelegt und mithilfe des Befehls **installhull** installiert wird.  Sobald der Hull installiert ist, wird sein Instanzbefehl wie bei normalen **snit::widget**-Instanzen umbenannt und ersetzt. Der ursprüngliche Befehl ist wiederum über die Instanzvariable **hull** zugänglich.

    Hinweis: Es ist im Allgemeinen nicht möglich, die *Widget-Klasse* des Hull-Widgets eines **snit::widgetadaptor** zu ändern.

    Informationen darüber, wie **snit::widgetadaptor**s mit der Optionsdatenbank interagieren, finden Sie im Abschnitt [Tk-Optionsdatenbank].

**snit::typemethod** *type* *name* *arglist* *body*
: Definiert eine neue Typmethode (oder definiert eine bestehende Typmethode neu) für einen bereits vorhandenen Typ *type*.

**snit::method** *type* *name* *arglist* *body*
: Definiert eine neue Instanzmethode (oder definiert eine vorhandene Instanzmethode neu) für einen bereits vorhandenen Typ *type*. Hinweis: Weitergeleitete Instanzmethoden können nicht neu definiert werden.

**snit::macro** *name* *arglist* *body*
: Definiert ein Snit-Makro mit den angegebenen Werten *name*, *arglist* und *body*. Makros dienen dazu, neue Anweisungen für Typ- und Widget-Definitionen auf der Grundlage der in dieser Manpage definierten Anweisungen zu definieren.

    Ein Makro ist lediglich eine Tcl-Prozedur, die im Slave-Interpreter definiert ist, der zum Kompilieren von Typ- und Widget-Definitionen verwendet wird. Somit haben Makros Zugriff auf alle Anweisungen zur Typ- und Widget-Definition. Weitere Einzelheiten finden Sie unter [Makros und Metaprogrammierung].

    Der Makroname *name* darf nicht mit einem Standard-Tcl-Befehl oder einer Snit-Typ- bzw. Widget-Definitionsanweisung übereinstimmen; so können Sie beispielsweise die Anweisungen **method** oder **delegate** nicht neu definieren, noch die Standard-Befehle **set**, **list** oder **string**.

**snit::compile** *which* *type* *body*
: Snit definiert einen Typ, ein Widget oder einen Widgetadaptor, indem es die Definition in ein Tcl-Skript „kompiliert“; dieses Skript wird anschließend im Tcl-Interpreter ausgewertet, wodurch der neue Typ tatsächlich definiert wird.

    Dieser Befehl macht den „Compiler“ zugänglich.  Für eine Definition *body* des benannten Typs *type*, wobei *which* **type**, **widget** oder **widgetadaptor** ist, gibt **snit::compile** eine Liste mit zwei Elementen zurück. Das erste Element ist der vollqualifizierte Typname; das zweite Element ist das Skript für die Definitionen.

    **snit::compile** ist nützlich, wenn der von Snit generierte Code zusätzlich bearbeitet werden muss – etwa wenn er instrumentiert oder durch den TclDevKit-Compiler verarbeitet werden soll.  Darüber hinaus könnte das zurückgegebene Skript in einer „.tcl“-Datei gespeichert und zur Definition des Typs als Teil einer Anwendung oder Bibliothek verwendet werden, wodurch der Kompilierungsaufwand beim Start der Anwendung eingespart wird.  Hinweis: Zur Laufzeit muss dieselbe Version von Snit verwendet werden wie zur Kompilierungszeit.


## Der Typbefehl

Eine Typ- oder Widget-Definition erzeugt einen Typbefehl, der zum Erstellen von Instanzen des Typs verwendet wird. Der Typbefehl hat folgende Form:

**$type** *typemethod* *args*...
: Die *typemethod* kann eine beliebige der [Standard-Typmethoden] (z. B. **create**) oder eine beliebige in der Typdefinition definierte Typmethode sein. Die nachfolgenden *args* hängen von der jeweils gewählten *typemethod* ab.

    Der Typbefehl wird meist zum Erstellen neuer Instanzen des Typs verwendet; daher wird die Methode **create** angenommen, wenn das erste Argument des Typbefehls keine gültige Typmethode angibt, es sei denn, die Typdefinition enthält **delegate typemethod \*** oder das Pragma **-hasinstances** auf „false“ gesetzt ist.

    Wenn das Pragma **-hastypemethods** zudem auf „false“ gesetzt ist, können Snit-Typbefehle auch ganz ohne Argumente aufgerufen werden; in diesem Fall erstellt der Typbefehl eine Instanz mit einem automatisch generierten Namen.  Mit anderen Worten: Sofern das Pragma **-hastypemethods** auf „false“ gesetzt ist und der Typ Instanzen besitzt, sind die folgenden Befehle gleichbedeutend:

    ```
    snit::type dog { ... }

    set mydog [dog create %AUTO%]
    set mydog [dog %AUTO%]
    set mydog [dog]
    ```

    Bei Snit-Widgets funktioniert dies aus offensichtlichen Gründen nicht.

    *Inkompatibilität mit Snit 1.x:* In Snit 1.x ist das oben beschriebene Verhalten unabhängig davon verfügbar, ob **-hastypemethods** auf „true“ (Standard) oder „false“ gesetzt ist.


## Standard-Typmethoden

Zusätzlich zu den Typmethoden in der Definition des Typs verfügen alle Typ- und Widget-Befehle in der Regel über mindestens die folgenden Unterbefehle:

**$type** **create** *name* ?*option* *value* ...?
: Erzeugt eine neue Instanz des Typs mit dem angegebenen *name* und ruft den Konstruktor des Typs auf.

    Ist *name* bei **snit::type**s kein vollqualifizierter Befehlsname, gilt er als Name im Namespace, in dem der Aufruf von **snit::type** steht.  Die Methode gibt den vollqualifizierten Instanznamen zurück.

    Bei **snit::widget**s und **snit::widgetadaptor**s muss *name* ein gültiger Widget-Name sein; die Methode gibt den Widget-Namen zurück.

    Solange *name* nicht mit dem Namen einer definierten Typmethode kollidiert, kann das Schlüsselwort **create** entfallen, es sei denn, die Typdefinition enthält **delegate typemethod \*** oder das Pragma **-hasinstances** ist auf false gesetzt.

    Enthält *name* die Zeichenkette **%AUTO%**, wird sie durch die Zeichenkette **$type$counter** ersetzt; dabei ist **$type** der Typname und **$counter** ein Zähler, der bei jeder Verwendung von **%AUTO%** für diesen Typ hochgezählt wird.

    Standardmäßig sind die Argumente nach *name* eine Liste von *option*-Namen und ihren *value*s; der Konstruktor eines Typs kann jedoch eine andere Argumentliste festlegen.

    Seit Snit V0.95 löst **create** einen Fehler aus, wenn *name* gleich dem Namen eines bestehenden Befehls ist; für **snit::widget**s und **snit::widgetadaptor**s galt das schon immer.  Das frühere Verhalten lässt sich mit dem Pragma **-canreplace** wiederherstellen.

**$type** **info typevars** ?*pattern*?
: Gibt eine Liste der Typvariablen des Typs zurück (mit Ausnahme der Snit-internen Variablen); alle Variablennamen sind vollständig qualifiziert.

    Wenn *pattern* angegeben wird, wird es als **string match**-Muster verwendet; es werden nur Namen zurückgegeben, die mit dem Muster übereinstimmen.

**$type** **info typemethods** ?*pattern*?
: Gibt eine Liste der Namen der Typmethoden des Typs zurück. Wenn der Typ über hierarchische Typmethoden verfügt – unabhängig davon, ob diese lokal definiert oder weitergeleitet werden –, wird jeweils nur das erste Wort in die Liste aufgenommen.

    Wenn die Typdefinition **delegate typemethod \*** enthält, umfasst die Liste nur die Namen jener implizit weitergeleiteten Typmethoden, die mindestens einmal aufgerufen wurden und sich noch im Typmethoden-Cache befinden.

    Wenn *pattern* angegeben wird, wird es als **string match**-Muster verwendet; es werden nur Namen zurückgegeben, die diesem Muster entsprechen.

**$type** **info args** *method*
: Gibt eine Liste zurück, die die Namen der Argumente der Typmethode *method* in der Reihenfolge ihrer Angabe enthält. Diese Methode kann nicht auf weitergeleitete Typmethoden angewendet werden.

**$type** **info body** *method*
: Gibt den Rumpf der Typmethode *method* zurück. Diese Methode kann nicht auf weitergeleitete Typmethoden angewendet werden.

**$type** **info default** *method* *aname* *varname*
: Gibt einen booleschen Wert zurück, der angibt, ob das Argument *aname* der Typmethode *method* einen Standardwert hat (**true**) oder nicht (**false**). Wenn das Argument über einen Standardwert verfügt, wird dessen Wert in der Variablen *varname* abgelegt.

**$type** **info instances** ?*pattern*?
: Gibt eine Liste der Instanzen des Typs zurück. Bei **snit::type** handelt es sich um eine Liste vollständig qualifizierter Instanznamen; bei **snit::widget** um eine Liste von Tk-Widget-Namen.

    Wenn *pattern* angegeben wird, wird es als **string match**-Muster verwendet; es werden nur Namen zurückgegeben, die mit dem Muster übereinstimmen.

    *Inkompatibilität mit Snit 1.x:* In Snit 1.x sind die vollständigen, aus mehreren Wörtern bestehenden Namen der hierarchischen Typmethoden im Rückgabewert enthalten.

**$type** **destroy**
: Löscht die Instanzen des Typs, den Namespace des Typs und den Typbefehl selbst.


## Der Instanzbefehl

Die Typmethode **create** eines Snit-Typs oder -Widgets erstellt Objekte dieses Typs; jedes Objekt verfügt über einen eindeutigen Namen, der zugleich ein Tcl-Befehl ist. Dieser Befehl dient dem Zugriff auf die Methoden und Daten des Objekts und hat folgende Form:

**$object** *method* *args...*
: *method* kann eine beliebige der [Standard-Instanzmethoden] oder eine in der Typdefinition definierte Instanzmethode sein. Die nachfolgenden *args* hängen von der jeweils gewählten *method* ab.


## Standard-Instanzmethoden

Zusätzlich zu etwaigen weitergeleiteten oder lokal definierten Instanzmethoden in der Typdefinition verfügen alle Snit-Objekte mindestens über die folgenden Unterbefehle:

**$object** **configure** ?*option*? ?*value*? ...
: Weist einer oder mehreren Optionen neue Werte zu. Wird die Methode mit einem Argument – einem Optionsnamen *option* – aufgerufen, gibt sie eine Liste zurück, die die Option beschreibt, wie es auch bei Tk-Widgets der Fall ist; wird sie ohne Argumente aufgerufen, gibt sie eine Liste von Listen zurück, die alle Optionen beschreiben, wie es auch bei Tk-Widgets der Fall ist.

    Warnung: Diese Informationen stehen für weitergeleitete Optionen nur dann zur Verfügung, wenn die Komponente, an die sie weitergeleitet werden, über eine Methode **configure** verfügt, die genau diese Art von Informationen zurückgibt.

    Hinweis: Snit definiert diese Methode nur, wenn der Typ über mindestens eine Option verfügt.

**$object** **configurelist** *optionlist*
: Ähnlich wie **configure**, nimmt jedoch ein Argument entgegen: eine Liste von Optionen und deren Werte. Sie ist vor allem im Konstruktor des Typs nützlich, kann jedoch überall verwendet werden.

    Hinweis: Snit definiert diese Methode nur, wenn der Typ mindestens eine Option aufweist.

**$object** **cget** *option*
: Gibt den Wert der Option zurück.

    Hinweis: Snit definiert diese Methode nur, wenn der Typ über mindestens eine Option verfügt.

**$object** **destroy**
: Löscht das Objekt, ruft dabei den **destructor** auf und gibt den gesamten zugehörigen Speicher frei.

    *Hinweis:* Die Methode **destroy** ist für **snit::widget**- oder **snit::widgetadaptor**-Objekte nicht definiert; deren Instanzen werden durch den Aufruf des Befehls **destroy** von **Tk** zerstört, genau wie normale Widgets.

**$object** **info type**
: Gibt den Typ der Instanz zurück.

**$object** **info vars** ?*pattern*?
: Gibt eine Liste der Instanzvariablen des Objekts zurück (mit Ausnahme der Snit-internen Variablen). Die Namen sind vollständig qualifiziert.

    Wird *pattern* angegeben, wird es als **string match**-Muster verwendet; es werden nur Namen zurückgegeben, die mit dem Muster übereinstimmen.

**$object** **info typevars** ?*pattern*?
: Gibt eine Liste der Typvariablen des Objekttyps zurück (mit Ausnahme der Snit-internen Variablen). Die Namen sind vollständig qualifiziert.

    Wird *pattern* angegeben, wird es als **string match**-Muster verwendet; es werden nur Namen zurückgegeben, die mit dem Muster übereinstimmen.

**$object** **info typemethods** ?*pattern*?
: Gibt eine Liste der Namen der Typmethoden des Typs zurück. Wenn der Typ über hierarchische Typmethoden verfügt – unabhängig davon, ob diese lokal definiert oder weitergeleitet werden –, wird jeweils nur das erste Wort in die Liste aufgenommen.

    Wenn die Typdefinition **delegate typemethod \*** enthält, umfasst die Liste nur die Namen jener implizit weitergeleiteten Typmethoden, die mindestens einmal aufgerufen wurden und sich noch im Typmethoden-Cache befinden.

    Wenn *pattern* angegeben wird, wird es als **string match**-Muster verwendet; es werden nur Namen zurückgegeben, die mit dem Muster übereinstimmen.

    *Inkompatibilität mit Snit 1.x:* In Snit 1.x sind die vollständigen, aus mehreren Wörtern bestehenden Namen hierarchischer Typmethoden im Rückgabewert enthalten.

**$object** **info options** ?*pattern*?
: Gibt eine Liste der Namen der Optionen des Objekts zurück. Diese umfasst stets lokale Optionen sowie explizit weitergeleitete Optionen.  Wenn unbekannte Optionen weitergeleitet werden und die Komponente, an die sie weitergeleitet werden, wie Tk-Widgets auf **$object configure** reagiert, so umfasst das Ergebnis alle möglichen unbekannten Optionen, die an die Komponente weitergeleitet werden können.

    Wenn *pattern* angegeben wird, wird es als **string match**-Muster verwendet; es werden nur Namen zurückgegeben, die mit dem Muster übereinstimmen.

    Beachten Sie, dass der Wert für verschiedene Instanzen desselben Typs unterschiedlich sein kann, wenn die Objekttypen der Komponenten von Instanz zu Instanz variieren können.

**$object** **info methods** ?*pattern*?
: Gibt eine Liste der Namen der Methoden der Instanz zurück. Wenn der Typ über hierarchische Methoden verfügt – unabhängig davon, ob diese lokal definiert oder weitergeleitet werden –, wird jeweils nur das erste Wort jeder Methode in die Liste aufgenommen.

    Wenn die Typdefinition **delegate method \*** enthält, umfasst die Liste nur die Namen jener implizit weitergeleiteten Methoden, die mindestens einmal aufgerufen wurden und sich noch im Methodencache befinden.

    Wenn *pattern* angegeben wird, wird es als **string match**-Muster verwendet; es werden nur Namen zurückgegeben, die mit dem Muster übereinstimmen.

    *Inkompatibilität mit Snit 1.x:* In Snit 1.x sind die vollständigen, aus mehreren Wörtern bestehenden Namen hierarchischer Methoden im Rückgabewert enthalten.

**$object** **info args** *method*
: Gibt eine Liste zurück, die die Namen der Argumente der Methode *method* der Instanz in der Reihenfolge ihrer Angabe enthält. Diese Methode kann nicht auf weitergeleitete Methoden angewendet werden.

**$object** **info body** *method*
: Gibt den Rumpf der Methode *method* der Instanz zurück. Diese Methode kann nicht auf weitergeleitete Methoden angewendet werden.

**$object** **info default** *method* *aname* *varname*
: Gibt einen booleschen Wert zurück, der angibt, ob das Argument *aname* der Methode *method* der Instanz einen Standardwert hat (**true**) oder nicht (**false**). Wenn das Argument über einen Standardwert verfügt, wird dessen Wert in der Variablen *varname* abgelegt.


## Befehle zur Verwendung im Objektcode

Snit definiert die folgenden Befehle zur Verwendung in Ihrem Objektcode: Das heißt, zur Verwendung in Typmethoden, Instanzmethoden, Konstruktoren, Destruktoren, onconfigure-Handlern, oncget-Handlern und Prozeduren. Sie befinden sich nicht im Namespace ::snit::; stattdessen werden sie zusammen mit dem Typ erstellt und können ohne Qualifizierung verwendet werden.

**mymethod** *name* ?*args...*?
: Der Befehl **mymethod** dient zum Formatieren von Befehlen, die als Rückruffunktion an andere Objekte übergeben werden sollen. Er gibt einen Befehl zurück, der bei seiner Ausführung die Methode *name* mit den angegebenen Argumenten sowie natürlich allen vom Aufrufer hinzugefügten Argumenten aufruft.  Mit anderen Worten: Beide der folgenden Befehle bewirken, dass die Methode **dosomething** des Objekts aufgerufen wird, wenn die Schaltfläche **$button** gedrückt wird:

    ```
        $button configure -command [list $self dosomething myargument]

        $button configure -command [mymethod dosomething myargument]
    ```

    Der wesentliche Unterschied zwischen den beiden besteht darin, dass die letztere Form auch dann noch funktioniert, wenn der Befehl des Objekts umbenannt wird.

**mytypemethod** *name* ?*args...*?
: Der Befehl **mytypemethod** dient zum Formatieren von Befehlen, die als Rückruffunktion an andere Objekte übergeben werden sollen. Er gibt einen Befehl zurück, der bei seiner Ausführung die Typmethode *name* mit den angegebenen Argumenten aufruft – natürlich zusätzlich zu allen vom Aufrufer hinzugefügten Argumenten.  Mit anderen Worten: Beide der folgenden Befehle bewirken, dass die Typmethode **dosomething** des Objekts aufgerufen wird, wenn **$button** gedrückt wird:

    ```
        $button configure -command [list $type dosomething myargument]

        $button configure -command [mytypemethod dosomething myargument]
    ```

    Typbefehle können nicht umbenannt werden, sodass es in der Praxis kaum einen Unterschied zwischen den beiden Formen gibt. **mytypemethod** wird aus Gründen der Parallelität zu **mymethod** bereitgestellt.

**myproc** *name* ?*args...*?
: Der Befehl **myproc** dient zum Formatieren von Befehlen, die als Rückruffunktion an andere Objekte übergeben werden sollen. Er gibt einen Befehl zurück, der bei seiner Ausführung die Typprozedur *name* mit den angegebenen Argumenten aufruft – natürlich zusätzlich zu allen vom Aufrufer hinzugefügten Argumenten.  Mit anderen Worten: Beide der folgenden Befehle bewirken, dass die Prozedur **dosomething** des Objekts aufgerufen wird, wenn **$button** gedrückt wird:

    ```
        $button configure -command [list ${type}::dosomething myargument]

        $button configure -command [myproc dosomething myargument]
    ```

**myvar** *name*
: Gibt bei Angabe eines Namens einer Instanzvariablen den vollqualifizierten Namen zurück. Verwenden Sie diesen Befehl, wenn Sie die Variable an ein anderes Objekt übergeben, z. B. als **-textvariable** an ein Tk-Label-Widget.

**mytypevar** *name*
: Gibt bei Angabe eines Namens einer Typvariablen den vollständig qualifizierten Namen zurück. Verwenden Sie diesen Befehl, wenn Sie die Variable an ein anderes Objekt übergeben, z. B. als **-textvariable** an ein Tk-Label-Widget.

**from** *argvName* *option* ?*defvalue*?
: Der Befehl **from** entnimmt einen Optionswert aus einer Liste von Optionen und deren Werten, wie sie beispielsweise an den **constructor** eines Typs übergeben wird. *argvName* muss der Name einer Variablen sein, die eine solche Liste enthält; *option* ist der Name der jeweiligen Option.

    **from** sucht in der Optionsliste nach *option*. Wird sie gefunden, werden sie und ihr Wert aus der Liste entfernt, und der Wert wird zurückgegeben. Wenn *option* nicht in der Liste vorkommt, wird *defvalue* zurückgegeben. Handelt es sich um eine lokal definierte Option und ist *defvalue* nicht angegeben, wird stattdessen der in der Typdefinition festgelegte Standardwert der Option zurückgegeben.

**install** *compName* **using** *objType* *objName* *args...*
: Erstellt ein neues Objekt vom Typ *objType* mit dem Namen *objName* und installiert es als Komponente *compName*, wie unter [Komponenten und Weiterleitung] beschrieben.  Alle zusätzlichen *args...* werden zusammen mit dem Namen an den Befehl *objType* übergeben. Handelt es sich hierbei um einen **snit::type**, sind die folgenden beiden Befehle gleichbedeutend:

    ```
        install myComp using myObjType $self.myComp args...

        set myComp [myObjType $self.myComp args...]
    ```

    Hinweis: Unabhängig davon, welche Methode verwendet wird, muss *compName* weiterhin in der Typdefinition unter Verwendung von **component** deklariert werden oder in mindestens einer **delegate**-Anweisung referenziert werden.

    Handelt es sich um ein **snit::widget** oder einen **snit::widgetadaptor** und wurden Optionen an die Komponente *compName* weitergeleitet, so erhalten diese Optionen Standardwerte aus der Tk-Optionsdatenbank.  Beachten Sie, dass es keine Rolle spielt, ob es sich bei der zu installierenden Komponente um ein Widget handelt oder nicht. Weitere Informationen finden Sie im Abschnitt [Tk-Optionsdatenbank].

    **install** kann nicht zur Installation von Typkomponenten verwendet werden; weisen Sie stattdessen der Variablen der Typkomponente einfach den Befehlsnamen der Typkomponente zu.

**installhull** **using** *widgetType* *args...*
: siehe unten ...

**installhull** *name*
: Der Konstruktor eines **snit::widgetadaptor** muss ein Widget erstellen, das als Hull-Komponente des Objekts dient; das Widget wird mithilfe dieses Befehls als Hull-Komponente installiert. Beachten Sie, dass der Name des installierten Widgets **$win** lauten muss. Dieser Befehl hat zwei Formen.

    Die erste Form legt den *widgetType* und die *args...* (d. h. die fest codierte Liste der Optionen) fest, die bei der Erstellung des Hulls verwendet werden sollen. In dieser Form erstellt **installhull** das Hull-Widget und initialisiert alle an den Hull weitergeleiteten Optionen aus der Tk-Optionsdatenbank.

    In der zweiten Form wurde das Hull-Widget bereits erstellt; beachten Sie, dass dessen Name „$win“ lauten muss.  In diesem Fall wird die Tk-Optionsdatenbank *nicht* nach Optionen abgefragt, die an den Hull weitergeleitet wurden. Die längere Form wird bevorzugt; die kürzere Form ermöglicht es dem Programmierer jedoch, ein an anderer Stelle erstelltes Widget anzupassen, was mitunter nützlich ist.  Beispielsweise kann sie verwendet werden, um ein „page“-Widget anzupassen, das von einem **BWidgets**-Notebook mit Registerkarten oder einem Seitenmanager-Widget erstellt wurde.

    Weitere Informationen zu **snit::widgetadaptor**s und der Tk-Optionsdatenbank finden Sie unter [Tk-Optionsdatenbank].

**variable** *name*
: Normalerweise werden Instanzvariablen zusammen mit den Optionen, Methoden usw. in der Typdefinition definiert; solche Instanzvariablen sind automatisch in sämtlichem Instanzcode (z. B. in Methodenkörpern) sichtbar.  Instanzcode kann jedoch den Befehl **variable** verwenden, um Instanzvariablen zu deklarieren, die nicht in der Typdefinition erscheinen, und um Variablen aus anderen Namespaces auf die übliche Weise in den Gültigkeitsbereich zu bringen.

    Im Allgemeinen ist es am übersichtlichsten, alle Instanzvariablen in der Typdefinition zu definieren und auf deren Deklaration in Methoden usw. zu verzichten.

    Hinweis: Es handelt sich hierbei um eine instanzspezifische Version des Standard-Tcl-Befehls **::variable**.

**typevariable** *name*
: Normalerweise werden Typvariablen zusammen mit den Instanzvariablen in der Typdefinition definiert; solche Typvariablen sind automatisch im gesamten Code des Typs sichtbar. Typmethoden, Instanzmethoden und dergleichen können jedoch mit **typevariable** Typvariablen deklarieren, die nicht in der Typdefinition erscheinen.

    Im Allgemeinen ist es am übersichtlichsten, alle Typvariablen in der Typdefinition zu deklarieren und auf deren Deklaration in Methoden, Typmethoden usw. zu verzichten.

**varname** *name*
: **Veraltet.**  Verwenden Sie stattdessen **myvar**.

    Gibt bei Angabe eines Namens einer Instanzvariablen den vollqualifizierten Namen zurück. Verwenden Sie diesen Befehl, wenn Sie die Variable an ein anderes Objekt übergeben, z. B. als **-textvariable** an ein Tk-Label-Widget.

**typevarname** *name*
: **Veraltet.** Verwenden Sie stattdessen **mytypevar**.

    Gibt bei Angabe eines Typvariablennamens den vollqualifizierten Namen zurück.  Verwenden Sie diesen Befehl, wenn Sie die Typvariable an ein anderes Objekt übergeben, z. B. als **-textvariable** an ein Tk-Label-Widget.

**codename** *name*
: **Veraltet.** Verwenden Sie stattdessen **myproc**. Bei Angabe des Namens einer Prozedur (jedoch nicht einer Typ- oder Instanzmethode) gibt er den vollqualifizierten Befehlsnamen zurück, der sich zur Übergabe als Rückruffunktion eignet.


## Komponenten und Weiterleitung

Wenn ein Objekt andere Objekte enthält – beispielsweise wenn eine Symbolleiste Schaltflächen enthält oder ein GUI-Objekt ein Objekt enthält, das auf eine Datenbank verweist –, wird das enthaltene Objekt als Komponente bezeichnet. Die übliche Vorgehensweise beim Umgang mit Komponentenobjekten, die zu einem Snit-Objekt gehören, besteht darin, diese mithilfe von **component** zu deklarieren, wodurch eine Komponenten-Instanzvariable erstellt wird. Im folgenden Beispiel enthält ein **dog**-Objekt ein **tail**-Objekt:

```
    snit::type dog {
        component mytail

        constructor {args} {
            set mytail [tail %AUTO% -partof $self]
            $self configurelist $args
        }

        method wag {} {
            $mytail wag
        }
    }

    snit::type tail {
        option -length 5
        option -partof
        method wag {} { return "Wag, wag, wag."}
    }
```

Da der Name des Objekts **tail** in einer Instanzvariablen gespeichert ist, ist er in jeder Methode leicht zugänglich.

Der Befehl **install** bietet eine alternative Möglichkeit, die Komponente zu erstellen und zu installieren:

```
    snit::type dog {
        component mytail

        constructor {args} {
            install mytail using tail %AUTO% -partof $self
            $self configurelist $args
        }

        method wag {} {
            $mytail wag
        }
    }
```

Bei **snit::type**s sind die beiden Methoden gleichwertig; bei den Typen **snit::widget** und **snit::widgetadaptor** initialisiert der Befehl **install** die Optionen des Widgets ordnungsgemäß, indem er die [Tk-Optionsdatenbank] abfragt.

In den obigen Beispielen ruft die Methode **wag** des Objekts **dog** lediglich die Methode **wag** der Komponente **tail** auf.  In der OO-Fachsprache wird dies als Weiterleitung bezeichnet. Snit bietet eine einfachere Möglichkeit, dies zu bewerkstelligen:

```
    snit::type dog {
        delegate method wag to mytail

        constructor {args} {
            install mytail using tail %AUTO% -partof $self
            $self configurelist $args
        }
    }
```

Die Anweisung **delegate** in der Typdefinition definiert implizit die Instanzvariable **mytail**, die den Namen der Komponente enthält (obwohl es empfehlenswert ist, **component** zu verwenden, um sie explizit zu deklarieren); außerdem definiert sie die Methode **wag** des Objekts **dog** und leitet diese an die Komponente **mytail** weiter.

Auf Wunsch können alle ansonsten unbekannten Methoden an eine bestimmte Komponente weitergeleitet werden:

```
    snit::type dog {
	delegate method * to mytail

	constructor {args} {
	    set mytail [tail %AUTO% -partof $self]
	    $self configurelist $args
	}

	method bark { return "Bark, bark, bark!" }
    }
```

In diesem Fall wird ein **dog**-Objekt seine eigene **bark**-Methode verarbeiten; **wag** wird jedoch an **mytail** weitergeleitet.  Jede andere Methode, die weder von **dog** noch von **tail** erkannt wird, löst einfach einen Fehler aus.

Die Optionsweiterleitung ähnelt der Weiterleitung der Methoden, mit Ausnahme der Interaktionen mit der Tk-Optionsdatenbank; dies wird im Abschnitt [Tk-Optionsdatenbank] beschrieben.

## Typkomponenten und Weiterleitung

Die Beziehung zwischen Typkomponenten und Instanzkomponenten entspricht derjenigen zwischen Typvariablen und Instanzvariablen sowie derjenigen zwischen Typmethoden und Instanzmethoden.  So wie eine Instanzkomponente eine Instanzvariable ist, die den Namen eines Befehls enthält, so ist eine Typkomponente eine Typvariable, die den Namen eines Befehls enthält. Im Wesentlichen ist eine Typkomponente eine Komponente, die von jeder Instanz des Typs gemeinsam genutzt wird.

So wie **delegate method** dazu verwendet werden kann, Methoden an Instanzkomponenten weiterzuleiten, wie unter [Komponenten und Weiterleitung] beschrieben, so kann **delegate typemethod** dazu verwendet werden, Typmethoden an Typkomponenten weiterzuleiten.

Hinweis: **delegate method** kann ab Snit 0.95 Methoden sowohl an Instanzkomponenten als auch an Typkomponenten weiterleiten.

## Tk-Optionsdatenbank

In diesem Abschnitt wird beschrieben, wie Snit mit der Tk-Optionsdatenbank interagiert, wobei davon ausgegangen wird, dass der Leser über praktische Kenntnisse der Optionsdatenbank und ihrer Anwendungsmöglichkeiten verfügt. Das Buch *Practical Programming in Tcl and Tk* von Welch et al. bietet eine gute Einführung in die Optionsdatenbank, ebenso wie *Effective Tcl/Tk Programming*.

Snit ist so implementiert, dass es in den meisten Fällen im Hinblick auf die Optionsdatenbank einfach das Richtige tut, vorausgesetzt, der Widget-Entwickler hält sich an die Vorgaben von Snit. Im Hauptteil dieses Abschnitts wird ausführlich darauf eingegangen, welche Anforderungen Snit stellt. Im Folgenden finden Sie zur Orientierung eine kurze Zusammenfassung dieser Anforderungen.

- Wenn die Standard-Widget-Klasse des **snit::widget** nicht Ihren Vorstellungen entspricht, legen Sie sie explizit mithilfe von **widgetclass** in der Widget-Definition fest.

- Wenn Sie Optionen definieren oder weiterleiten, legen Sie die Namen der Ressourcen und Klassen ausdrücklich fest, wenn die Standardwerte nicht Ihren Vorstellungen entsprechen.

- Verwenden Sie **installhull using**, um den Hull von **snit::widgetadaptor**s zu installieren.

- Verwenden Sie **install**, um alle anderen Komponenten zu installieren.


Das Zusammenspiel von Tk-Widgets mit der Optionsdatenbank ist eine komplexe Angelegenheit; das Zusammenspiel von Snit mit der Optionsdatenbank ist dies in noch stärkerem Maße, und es lohnt sich, auf die Einzelheiten zu achten.

**Festlegen der Widget-Klasse:** Jedes Tk-Widget verfügt über eine Widget-Klasse. Bei Tk-Widgets entspricht der Name der Widget-Klasse lediglich dem Namen des Widget-Typs mit einem Großbuchstaben am Anfang, z. B. lautet die Widget-Klasse für **button**-Widgets „Button“.

Ebenso ist die Widget-Klasse eines **snit::widget** standardmäßig der unqualifizierte Typname mit Großbuchstaben am Anfang.  Beispielsweise lautet die Widget-Klasse von

```
    snit::widget ::mylibrary::scrolledText { ... }
```

„ScrolledText“. Die Widget-Klasse kann zudem explizit mithilfe der Anweisung **widgetclass** innerhalb der Definition **snit::widget** festgelegt werden.

Jedes Widget kann als **hulltype** verwendet werden, sofern es die Option **-class** zum Ändern seines Widget-Klassennamens unterstützt.  Siehe dazu die Erläuterung zum Befehl **hulltype** weiter oben.  Der Benutzer kann dem Widget bei der Instanziierung die Option **-class** übergeben.

Die Widget-Klasse eines **snit::widgetadaptor** entspricht lediglich der Widget-Klasse seines Hull-Widgets; dies lässt sich nicht ändern, es sei denn, das Hull-Widget unterstützt **-class**; in diesem Fall ist es in der Regel sinnvoller, **snit::widget** anstelle von **snit::widgetadaptor** zu verwenden.

**Festlegen der Ressourcen- und Klassennamen von Optionen:** In Tk verfügt jede Option über drei Namen: den Namen der Option, den Namen der Ressource und den Namen der Klasse.  Der Optionsname beginnt mit einem Bindestrich und besteht ausschließlich aus Kleinbuchstaben; er wird beim Erstellen von Widgets sowie bei den Befehlen **configure** und **cget** verwendet.

Die Ressourcen- und Klassennamen werden verwendet, um Standardwerte für Optionen durch Abfrage der Tk-Optionsdatenbank zu initialisieren. Der Ressourcenname besteht in der Regel lediglich aus dem Optionsnamen ohne Bindestrich, kann jedoch an Wortgrenzen Großbuchstaben enthalten; der Klassenname besteht in der Regel lediglich aus dem Ressourcennamen mit einem Großbuchstaben am Anfang, was jedoch nicht immer der Fall ist.  Hier sind beispielsweise die Options-, Ressourcen- und Klassennamen für einige Optionen des **text**-Widgets:

```
    -background         background         Background
    -borderwidth        borderWidth        BorderWidth
    -insertborderwidth  insertBorderWidth  BorderWidth
    -padx               padX               Pad
```

Wie leicht zu erkennen ist, lassen sich die Namen der Ressourcen und Klassen manchmal aus dem Namen der Option ableiten, jedoch nicht immer.

Snit-Optionen verfügen ebenfalls über einen Ressourcennamen und einen Klassennamen. Standardmäßig folgen diese Namen der oben genannten Regel: Der Ressourcenname entspricht dem Optionsnamen ohne Bindestrich, und der Klassenname entspricht dem Ressourcennamen mit einem Großbuchstaben am Anfang. Dies gilt sowohl für lokal definierte Optionen als auch für explizit weitergeleitete Optionen:

```
    snit::widget mywidget {
        option -background
        delegate option -borderwidth to hull
        delegate option * to text
	# ...
    }
```

In diesem Fall lautet der Name der Widget-Klasse „Mywidget“. Das Widget verfügt über die folgenden Optionen: **-background**, die lokal definiert ist, und **-borderwidth**, die explizit weitergeleitet wird; alle anderen Optionen werden an eine Komponente namens „text“ weitergeleitet, bei der es sich wahrscheinlich um ein Tk-**text**-Widget handelt.  Wenn dies der Fall ist, verfügt **mywidget** über dieselben Optionen wie ein **text**-Widget. Die Namen der Optionen, Ressourcen und Klassen lauten wie folgt:

```
    -background  background  Background
    -borderwidth borderwidth Borderwidth
    -padx        padX        Pad
```

Hinweis: Die lokal definierte Option **-background** hat zufällig dieselben drei Namen wie die Standard-Tk-Option **-background**; und **-pad**, die implizit an die Komponente **text** weitergeleitet wird, weist für **mywidget** dieselben drei Namen auf wie für das Widget **text**.  **-borderwidth** hingegen weist andere Namen für Ressourcen und Klassen auf, da das interne Wort „width“ nicht großgeschrieben wird. Aus Gründen der Konsistenz sollte dies jedoch geschehen; dies wird wie folgt umgesetzt:

```
    snit::widget mywidget {
	option -background
	delegate option {-borderwidth borderWidth} to hull
	delegate option * to text
	# ...
    }
```

Der Name der Klasse lautet standardmäßig „BorderWidth“, wie zu erwarten.

Nehmen wir jedoch an, dass **mywidget** auch **-padx** und **-pady** an den Hull weiterleitet. In diesem Fall müssen sowohl der Name der Ressource als auch der Name der Klasse explizit festgelegt werden:

```
    snit::widget mywidget {
	option -background
	delegate option {-borderwidth borderWidth} to hull
	delegate option {-padx padX Pad} to hull
	delegate option {-pady padY Pad} to hull
	delegate option * to text
	# ...
    }
```

**Abfrage der Optionsdatenbank:** Wenn Sie Ihre Widget-Klasse und Namen der Optionen wie oben beschrieben festlegen, fragt Snit bei der Erstellung jeder Instanz die Optionsdatenbank ab und verhält sich dabei in der Regel korrekt. Im weiteren Verlauf dieses Abschnitts werden die technischen Details näher erläutert.

**Initialisierung lokal definierter Optionen:** Wenn eine Instanz von snit::widget erstellt wird, werden ihre lokal definierten Optionen wie folgt initialisiert: Die Namen der Ressourcen und Klassen der einzelnen Optionen werden verwendet, um die Tk-Optionsdatenbank abzufragen.  Wenn das Ergebnis nicht leer ist, wird es als Standardwert der Option verwendet; andernfalls kommt der in der Typdefinition fest codierte Standardwert zum Einsatz. In beiden Fällen kann der Standardwert vom Aufrufer überschrieben werden. Ein Beispiel:

```
    option add *Mywidget.texture pebbled

    snit::widget mywidget {
	option -texture smooth
	# ...
    }

    mywidget .mywidget -texture greasy
```

Hier würde **-texture** normalerweise standardmäßig auf „smooth“ gesetzt werden, doch aufgrund des Eintrags, der der Optionsdatenbank hinzugefügt wurde, ist die Standardeinstellung „pebbled“. Der Aufrufer hat die Standardeinstellung jedoch ausdrücklich überschrieben, sodass das neue Widget „greasy“ sein wird.

**Initialisierung von Optionen, die an den Hull weitergeleitet werden:** Der Hull eines **snit::widget** ist ein Widget, und da seine Klasse festgelegt wurde, wird erwartet, dass er die Optionsdatenbank für sich selbst abfragt. Die einzige Ausnahme bilden Optionen, die unter einem anderen Namen an ihn weitergeleitet werden.  Betrachten Sie den folgenden Code:

```
    option add *Mywidget.borderWidth 5
    option add *Mywidget.relief sunken
    option add *Mywidget.hullbackground red
    option add *Mywidget.background green

    snit::widget mywidget {
	delegate option -borderwidth to hull
	delegate option -hullbackground to hull as -background
	delegate option * to hull
	# ...
    }

    mywidget .mywidget

    set A [.mywidget cget -relief]
    set B [.mywidget cget -hullbackground]
    set C [.mywidget cget -background]
    set D [.mywidget cget -borderwidth]
```

Die Frage lautet: Welche Werte haben die Variablen A, B, C und D?

Der Wert von A ist „sunken“.  Der Hull ist ein Tk-Frame, dem die Widget-Klasse „Mywidget“ zugewiesen wurde; er fragt automatisch die Optionsdatenbank ab und übernimmt diesen Wert. Da die Option **-relief** implizit an den Hull weitergeleitet wird, unternimmt Snit nichts.

Der Wert von B lautet „red“. Der Hull übernimmt automatisch den Wert „green“ für seine Option **-background**, genau wie er zuvor den Wert für **-relief** übernommen hat.  Snit weiß jedoch, dass **-hullbackground** der Option **-background** des Hulls zugeordnet ist; daher fragt es die Optionsdatenbank nach **-hullbackground** ab, erhält den Wert „red“ und aktualisiert den Hull entsprechend.

Der Wert von C ist ebenfalls „red“, da **-background** implizit an den Hull weitergeleitet wird; daher entspricht das Abrufen dieses Werts dem Abrufen von **-hullbackground**.  Beachten Sie, dass dieser Fall ungewöhnlich ist; in der Praxis würde **-background** wahrscheinlich explizit an eine andere Komponente weitergeleitet werden.

Der Wert von D beträgt „5“, jedoch nicht aus dem Grund, den Sie vermuten. Beachten Sie, dass gemäß der obigen Definition der Ressourcenname für **-borderwidth** standardmäßig „borderwidth“ lautet, während der Eintrag in der Optionsdatenbank „borderWidth“ lautet.  Wie bei **-relief** übernimmt der Hull seine eigene Option **-borderwidth**, bevor Snit irgendetwas unternimmt. Da die Option unter ihrem eigenen Namen weitergeleitet wird, geht Snit davon aus, dass alles korrekt abgelaufen ist, und befasst sich nicht weiter damit.

Bei **snit::widgetadaptor**s stellt sich die Situation etwas anders dar.  Widget-Adapter behalten die Widget-Klasse ihres Hulls bei, und der Hull wird nicht automatisch von Snit erstellt. Stattdessen muss **snit::widgetadaptor** in seinem Konstruktor **installhull** aufrufen. Dies geschieht üblicherweise wie folgt:

```
    snit::widgetadaptor mywidget {
	# ...
	constructor {args} {
	    # ...
	    installhull using text -foreground white
	    #
	}
	#...
    }
```

In diesem Fall erstellt der Befehl **installhull** den Hull mithilfe eines Befehls wie dem folgenden:

```
    set hull [text $win -foreground white]
```

Der Hull ist ein **text**-Widget, daher lautet seine Widget-Klasse „Text“.  Genau wie bei **snit::widget**-Hulls geht Snit davon aus, dass er alle seine normalen Optionswerte automatisch übernimmt; Optionen, die unter einem anderen Namen weitergeleitet werden, werden auf dieselbe Weise aus der Optionsdatenbank initialisiert.

**Initialisierung von Optionen, die an andere Komponenten weitergeleitet wurden:** Nicht-Hull-Komponenten werden auf zwei Arten mit der Optionsdatenbank abgeglichen. Erstens bleibt ein Komponenten-Widget weiterhin ein Widget und wird daher wie gewohnt aus der Optionsdatenbank initialisiert. Zweitens wird die Optionsdatenbank nach allen an die Komponente weitergeleiteten Optionen abgefragt, und die Komponente wird entsprechend initialisiert – vorausgesetzt, sie wird mit dem Befehl **install** erstellt.

Bevor die Unterstützung für die Optionsdatenbank in Snit integriert wurde, bestand die übliche Vorgehensweise beim Erstellen einer Komponente darin, diese einfach im Konstruktor zu erstellen und ihren Befehlsnamen der Komponentenvariablen zuzuweisen:

```
    snit::widget mywidget {
	delegate option -background to myComp

	constructor {args} {
	    set myComp [text $win.text -foreground black]
	}
    }
```

Der Nachteil dieser Methode besteht darin, dass Snit keine Möglichkeit hat, die Komponente ordnungsgemäß zu initialisieren. Daher wird nun folgender Ansatz verwendet:

```
    snit::widget mywidget {
	delegate option -background to myComp

	constructor {args} {
	    install myComp using text $win.text -foreground black
	}
    }
```

Der Befehl **install** führt Folgendes aus:

- Erstellt eine Liste der Optionen, die explizit im Befehl **install** enthalten sind – in diesem Fall **-foreground**.

- Fragt die Optionsdatenbank nach allen Optionen, die explizit an die genannte Komponente weitergeleitet wurden.

- Erstellt die Komponente mithilfe des angegebenen Befehls, nachdem zuvor eine Liste von Optionen und Werten, die aus der Optionsdatenbank ausgelesen wurden, in den Befehl eingefügt wurde. Somit haben die explizit angegebenen Optionen (**-foreground**) Vorrang vor allen aus der Optionsdatenbank ausgelesenen Werten.

- Wenn die Widget-Definition Optionen implizit mithilfe von **delegate option \*** an die Komponente weiterleitet, ruft Snit die Methode **configure** der neu erstellten Komponente auf, um eine Liste aller Optionen der Komponente zu erhalten.  Daraus erstellt Snit eine Liste der Optionen, die implizit an die Komponente weitergeleitet wurden, jedoch nicht explizit im Befehl **install** enthalten waren. Für alle diese Optionen fragt Snit die Optionsdatenbank ab und konfiguriert die Komponente entsprechend.


**Nicht-Widget-Komponenten:** Die Optionsdatenbank wird für **snit::type**s niemals abgefragt, da eine Abfrage nur unter Angabe eines Tk-Widget-Namens möglich ist. **snit::widget**s können jedoch Nicht-Widget-Komponenten enthalten.  Und wenn Optionen an diese Komponenten weitergeleitet werden und der Befehl **install** zur Installation dieser Komponenten verwendet wird, werden sie ebenso wie Widget-Komponenten anhand der Optionsdatenbank initialisiert.

## Makros und Metaprogrammierung

Der Befehl **snit::macro** ermöglicht ein gewisses Maß an Metaprogrammierung mit Snit-Klassen. Nehmen wir beispielsweise an, Sie möchten Eigenschaften definieren: Instanzvariablen, die über Set- und Get-Methoden verfügen. Ihr Code könnte dann wie folgt aussehen:

```
    snit::type dog {
        variable mood happy

        method getmood {} {
            return $mood
        }

        method setmood {newmood} {
            set mood $newmood
        }
    }
```

Das sind neun Zeilen Text pro Eigenschaft. Oder Sie definieren das folgende **snit::macro**:

```
    snit::macro property {name initValue} {
        variable $name $initValue

        method get$name {} "return $name"

        method set$name {value} "set $name \$value"
    }
```

Hinweis: Es handelt sich bei einem **snit::macro** lediglich um eine normale Tcl-Prozedur, die im Slave-Interpreter definiert ist, der zum Kompilieren von Typ- und Widget-Definitionen dient; folglich hat sie Zugriff auf alle Befehle, die zur Definition von Typen und Widgets dienen.

Mit diesem neuen Makro können Sie eine Eigenschaft in einer einzigen Codezeile definieren:

```
    snit::type dog {
        property mood happy
    }
```

Innerhalb eines Makros beziehen sich die Befehle **variable** und **proc** auf die Snit-Typdefinitionsbefehle und nicht auf die Standard-Tcl-Befehle.  Um die Standard-Tcl-Befehle zu erhalten, verwenden Sie **\_variable** und **\_proc**.

Da für die Kompilierung aller Snit-Typen und -Widgets in der Anwendung ein einziger Slave-Interpreter verwendet wird, besteht die Möglichkeit von Namenskonflikten bei Makros. Wenn Sie ein wiederverwendbares Paket mit Snit erstellen und dabei **snit::macro**s verwenden, definieren Sie diese bitte in Ihrem Paket-Namespace:

```
    snit::macro mypkg::property {name initValue} { ... }

    snit::type dog {
        mypkg::property mood happy
    }
```

Dadurch bleibt der globale Namespace für die Autoren von Anwendungen frei.

## Validierungstypen

Ein Validierungstyp ist ein Objekt, mit dem Tcl-Werte einer bestimmten Art überprüft werden können. So wird beispielsweise **snit::integer** verwendet, um zu überprüfen, ob ein Tcl-Wert eine Ganzzahl ist.

Jeder Validierungstyp verfügt über eine Methode namens **validate**, die zur Durchführung der Validierung dient. Diese Methode muss ein einziges Argument entgegennehmen, nämlich den zu validierenden Wert; außerdem darf sie nichts unternehmen, wenn der Wert gültig ist, muss jedoch einen Fehler auslösen, wenn der Wert ungültig ist:

```
    snit::integer validate 5     ;# Does nothing
    snit::integer validate 5.0   ;# Throws an error (not an integer!)
```

Die Methode **validate** gibt im Erfolgsfall stets den validierten Wert zurück und löst im Fehlerfall einen Fehler mit **-errorcode** INVALID aus.

Snit definiert eine Familie von Validierungstypen, die alle als **snit::type** implementiert sind. Sie können unverändert verwendet werden; darüber hinaus dienen ihre Instanzen als parametrisierte Untertypen. Beispielsweise ist eine Wahrscheinlichkeit eine Zahl zwischen 0,0 und 1,0 (einschließlich):

```
    snit::double probability -min 0.0 -max 1.0
```

Das obige Beispiel erstellt eine Instanz von **snit::double** – einen Validierungsuntertyp – namens **probability**, die zur Validierung von Wahrscheinlichkeitswerten verwendet werden kann:

```
    probability validate 0.5   ;# Does nothing
    probability validate 7.9   ;# Throws an error
```

Validierungsuntertypen können explizit definiert werden, wie im obigen Beispiel gezeigt; wenn bei einer lokal definierten Option **-type** angegeben wird, können sie auch dynamisch erstellt werden:

```
    snit::enum ::dog::breed -values {mutt retriever sheepdog}

    snit::type dog {
        # Define subtypes on the fly...
        option -breed -type {
            snit::enum -values {mutt retriever sheepdog}
        }

        # Or use predefined subtypes...
        option -breed -type ::dog::breed
    }
```

Jedes Objekt, das über eine Methode **validate** mit der oben beschriebenen Semantik verfügt, kann als Validierungstyp verwendet werden; Informationen zur Definition neuer Validierungstypen finden Sie im Abschnitt [Validierungstypen definieren].

Snit definiert die folgenden Validierungstypen:

**snit::boolean** **validate** ?*value*?
: siehe unten ...

**snit::boolean** *name*
: Validiert boolesche Tcl-Werte: 1, 0, **on**, **off**, **yes**, **no**, **true**, **false**. Es ist möglich, Untertypen – also Instanzen – von **snit::boolean** zu definieren, doch da der Typ keine Optionen hat, gibt es dafür keinen Grund.

**snit::double** **validate** ?*value*?
: siehe unten ...

**snit::double** *name* ?*option* *value*...?
: Validiert Gleitkommawerte. Mit den folgenden Optionen können Untertypen erstellt werden:

    **-min** *min*
    : Legt eine untere Grenze für Gleitkommazahlen fest; ein Wert ist ungültig, wenn er streng kleiner als *min* ist.

    **-max** *max*
    : Legt eine obere Grenze für Gleitkommazahlen fest; ein Wert ist ungültig, wenn er streng größer als *max* ist.


**snit::enum** **validate** ?*value*?
: siehe unten ...

**snit::enum** *name* ?*option* *value*...?
: Überprüft, ob ein Wert aus einer Aufzählungsliste stammt. Der Basistyp ist für sich genommen kaum von Nutzen, da nur Untertypen tatsächlich über eine Aufzählungsliste verfügen, anhand derer eine Validierung erfolgen kann. Untertypen können mit den folgenden Optionen erstellt werden:

    **-values** *list*
    : Legt fest, welche Werte gültig sind. Ein Wert ist genau dann gültig, wenn er in der Liste enthalten ist.


**snit::fpixels** **validate** ?*value*?
: siehe unten ...

**snit::fpixels** *name* ?*option* *value*...?
: *Nur für Tk-Programme.* Validiert Bildschirmabstände in jeder der von **winfo fpixels** akzeptierten Formen. Untertypen können mit den folgenden Optionen erstellt werden:

    **-min** *min*
    : Legt eine Untergrenze fest; ein Wert ist ungültig, wenn er streng kleiner als *min* ist. Die Grenze kann in jeder der von **winfo fpixels** akzeptierten Formen angegeben werden.

    **-max** *max*
    : Legt eine Obergrenze fest; ein Wert ist ungültig, wenn er streng größer als *max* ist. Die Obergrenze kann in jeder der von **winfo fpixels** akzeptierten Formen angegeben werden.


**snit::integer** **validate** ?*value*?
: siehe unten ...

**snit::integer** *name* ?*option* *value*...?
: Validiert ganzzahlige Werte. Untertypen können mit den folgenden Optionen erstellt werden:

    **-min** *min*
    : Legt eine ganzzahlige Untergrenze fest; ein Wert ist ungültig, wenn er streng kleiner als *min* ist.

    **-max** *max*
    : Legt eine ganzzahlige Obergrenze fest; ein Wert ist ungültig, wenn er streng größer als *max* ist.


**snit::listtype** **validate** ?*value*?
: siehe unten ...

**snit::listtype** *name* ?*option* *value*...?
: Validiert Tcl-Listen. Mit den folgenden Optionen können Untertypen erstellt werden:

    **-minlen** *min*
    : Legt eine Mindestlänge der Liste fest; der Wert ist ungültig, wenn die Liste weniger als *min* Elemente enthält. Der Standardwert ist 0.

    **-maxlen** *max*
    : Legt eine maximale Listenlänge fest; der Wert ist ungültig, wenn die Liste mehr als *max* Elemente enthält.

    **-type** *type*
    : Legt den Typ der Listenelemente fest; *type* muss der Name eines Validierungstyps oder -untertyps sein. Im folgenden Beispiel muss der Wert von **-numbers** eine Liste von Ganzzahlen sein.

        ```
            option -numbers -type {snit::listtype -type snit::integer}
        ```

        Beachten Sie, dass diese Option die dynamische Definition neuer Validierungsuntertypen nicht unterstützt; das heißt, der folgende Code funktioniert (jedenfalls noch) nicht:

        ```
            option -numbers -type {
                snit::listtype -type {snit::integer -min 5}
            }
        ```

        Definieren Sie den Untertyp stattdessen explizit:

        ```
            snit::integer gt4 -min 5

            snit::type mytype {
                option -numbers -type {snit::listtype -type gt4}
            }
        ```


**snit::pixels** **validate** ?*value*?
: siehe unten ...

**snit::pixels** *name* ?*option* *value*...?
: *Nur für Tk-Programme.* Validiert Bildschirmabstände in jeder der von **winfo pixels** akzeptierten Formen. Untertypen können mit den folgenden Optionen erstellt werden:

    **-min** *min*
    : Legt eine Untergrenze fest; ein Wert ist ungültig, wenn er streng kleiner als *min* ist. Die Grenze kann in jeder der von **winfo pixels** akzeptierten Formen angegeben werden.

    **-max** *max*
    : Legt eine Obergrenze fest; ein Wert ist ungültig, wenn er streng größer als *max* ist. Die Obergrenze kann in jeder der von **winfo pixels** akzeptierten Formen angegeben werden.


**snit::stringtype** **validate** ?*value*?
: siehe unten ...

**snit::stringtype** *name* ?*option* *value*...?
: Überprüft Tcl-Zeichenketten auf Gültigkeit. Der Basistyp ist für sich genommen kaum von Nutzen, da jeder Tcl-Wert gleichzeitig eine gültige Zeichenkette ist. Mit den folgenden Optionen können Untertypen erstellt werden:

    **-minlen** *min*
    : Legt eine Mindestlänge für die Zeichenfolge fest; der Wert ist ungültig, wenn er weniger als *min* Zeichen enthält. Der Standardwert ist 0.

    **-maxlen** *max*
    : Legt eine maximale Zeichenfolgenlänge fest; der Wert ist ungültig, wenn er mehr als *max* Zeichen enthält.

    **-glob** *pattern*
    : Legt ein **string match**-Muster fest; der Wert ist ungültig, wenn er nicht mit dem Muster übereinstimmt.

    **-regexp** *regexp*
    : Legt einen regulären Ausdruck fest; der Wert ist ungültig, wenn er nicht mit dem regulären Ausdruck übereinstimmt.

    **-nocase** *flag*
    : Standardmäßig wird bei den Übereinstimmungen mit **-glob** und **-regexp** die Groß-/Kleinschreibung berücksichtigt.  Wenn **-nocase** auf „true“ gesetzt ist, erfolgt die Übereinstimmung sowohl bei **-glob** als auch bei **-regexp** ohne Berücksichtigung der Groß-/Kleinschreibung.


**snit::window** **validate** ?*value*?
: siehe unten ...

**snit::window** *name*
: *Nur für Tk-Programme.* Validiert Tk-Fensternamen. Der Wert muss dazu führen, dass **winfo exists** „true“ zurückgibt; andernfalls ist der Wert ungültig.  Es ist möglich, Untertypen – also Instanzen – von **snit::window** zu definieren, doch da der Typ derzeit keine Optionen hat, gibt es dafür keinen Grund.


## Validierungstypen definieren

Es gibt drei Möglichkeiten, einen neuen Validierungstyp zu definieren: als Untertyp eines der Validierungstypen von Snit, als Validierungstyp-Befehl und als vollwertiger Validierungstyp, ähnlich den von Snit bereitgestellten. Die Definition von Untertypen der Validierungstypen von Snit wird weiter oben im Abschnitt [Validierungstypen] beschrieben.

Die nächsteinfachste Möglichkeit, einen neuen Validierungstyp zu erstellen, ist die Verwendung eines Validierungstyp-Befehls. Ein Validierungstyp ist lediglich ein Objekt, das über eine Methode namens **validate** verfügt; die Methode **validate** muss ein Argument – einen Wert – entgegennehmen, den Wert zurückgeben, wenn er gültig ist, und bei einem ungültigen Wert einen Fehler mit dem Code **-errorcode** INVALID auslösen.  Dies lässt sich mit einem einfachen **proc** bewerkstelligen.  So hätte beispielsweise der Validierungstyp **snit::boolean** auch wie folgt implementiert werden können:

```
    proc ::snit::boolean {"validate" value} {
        if {![string is boolean -strict $value]} {
            return -code error -errorcode INVALID  "invalid boolean \"$value\", should be one of: 1, 0, ..."
        }

        return $value
    }
```

Ein auf diese Weise definierter Validierungstyp kann natürlich keine Untertypen haben; für viele Anwendungen wird dies jedoch ausreichen.

Schließlich lässt sich ein vollwertiger Validierungstyp, der Untertypen haben kann, als **snit::type** definieren. Hier finden Sie ein Grundgerüst für den Einstieg:

```
    snit::type myinteger {
        # First, define any options you'd like to use to define
        # subtypes.  Give them defaults such that they won't take
        # effect if they aren't used, and marked them "read-only".
        # After all, you shouldn't be changing their values after
        # a subtype is defined.
        #
        # For example:

        option -min -default "" -readonly 1
        option -max -default "" -readonly 1

        # Next, define a "validate" type method which should do the
        # validation in the basic case.  This will allow the
        # type command to be used as a validation type.

        typemethod validate {value} {
            if {![string is integer -strict $value]} {
                return -code error -errorcode INVALID  "invalid value \"$value\", expected integer"
            }

            return $value
        }

        # Next, the constructor should validate the subtype options,
        # if any.  Since they are all readonly, we don't need to worry
        # about validating the options on change.

        constructor {args} {
            # FIRST, get the options
            $self configurelist $args

            # NEXT, validate them.

            # I'll leave this to your imagination.
        }

        # Next, define a "validate" instance method; its job is to
        # validate values for subtypes.

        method validate {value} {
            # First, call the type method to do the basic validation.
            $type validate $value

            # Now we know it's a valid integer.

            if {("" != $options(-min) && $value < $options(-min))  ||
                ("" != $options(-max) && $value > $options(-max))} {
                # It's out of range; format a detailed message about
                # the error, and throw it.

                set msg "...."

                return -code error -errorcode INVALID $msg
            }

            # Otherwise, if it's valid just return it.
            return $valid
        }
    }
```

Und nun verfügen Sie über einen Typ, der Untertypen haben kann.

Die Datei „validate.tcl“ im Snit-Paket definiert alle Validierungstypen von Snit; dort finden Sie die vollständige Implementierung für **snit::integer** und die anderen Typen, die Sie als Beispiele für Ihre eigenen Typen verwenden können.

# Einschränkungen

Sollten Sie Probleme haben, Fehler entdecken oder neue Ideen haben, sind Sie hiermit herzlich eingeladen, einen Bericht über Ihr Problem, Ihren Fehler oder Ihre Idee einzureichen, wie im Abschnitt [Fehler, Ideen, Rückmeldungen] weiter unten beschrieben.

Darüber hinaus möchten Sie sich vielleicht in die Snit-Mailingliste eintragen; weitere Informationen finden Sie unter <http://www.wjduquette.com/snit>.

Ein Bereich, den Sie besonders im Auge behalten sollten, ist die Verwendung von **snit::widgetadaptor** zur Anpassung von Megawidgets, die von anderen Megawidget-Paketen erstellt wurden; die korrekte Zerstörung der Widgets hängt von der Reihenfolge der <Destroy>-Bindings ab. Am sinnvollsten ist es, dies einfach zu unterlassen.

# Bekannte Fehler

- Die von Snit 1.x zurückgegebenen Fehler-Stack-Traces sind äußerst unübersichtlich und enthalten in der Regel viel zu viele Informationen über die internen Abläufe von Snit. In Snit 2.2 wurden die Fehlermeldungen deutlich verbessert.

- Beachten Sie bitte auch die Projekt-Tracker, wie sie im Abschnitt [Fehler, Ideen, Rückmeldungen] weiter unten erläutert werden.


# Geschichte

Im Zuge der Entwicklung von „Notebook“ (siehe <http://www.wjduquette.com/notebook>), meiner auf Tcl basierenden persönlichen Notizbuchanwendung, stellte ich fest, dass ich diese als eine Sammlung von Objekten programmierte.  Ich verwendete keinen bestimmten objektorientierten Rahmen; ich schrieb lediglich Objekte in reinem Tcl, wobei ich mich an die Richtlinien in meinem „Guide to Object Commands“ (siehe <http://www.wjduquette.com/tcl/objects.html>) hielt und einige weitere Tricks anwandte, die ich mir seitdem angeeignet hatte.  Und obwohl es gut funktionierte, wurde es aufgrund der Menge an Boilerplate-Code, die mit jedem neuen Objekt verbunden war, schnell mühsam.

Das war also der eine Punkt – Langeweile ist ein starker Motivationsfaktor. Der andere Punkt, der mir auffiel, war, dass ich Vererbung überhaupt nicht nutzte und sie mir auch nicht fehlte. Stattdessen setzte ich auf Weiterleitung: Objekte, die andere Objekte erzeugten und Methoden an diese weiterleiteten.

Und ich sagte mir: „Das wird langsam langweilig … es muss doch einen besseren Weg geben.“  Und eines Nachmittags begann ich aus einer Laune heraus, an Snit zu arbeiten, einem Objektsystem, das so funktioniert wie Tcl. Snit unterstützt zwar keine Vererbung, eignet sich jedoch hervorragend für die Weiterleitung und erleichtert die Erstellung von Megawidgets.

Wenn Sie Anmerkungen oder Vorschläge (oder Fehlermeldungen!) haben, zögern Sie bitte nicht, mir eine E-Mail an *will@wjduquette.com* zu senden.  Darüber hinaus gibt es eine Snit-Mailingliste; weitere Informationen dazu finden Sie auf der Snit-Homepage (siehe <http://www.wjduquette.com/snit>).

# Danksagungen

Snit wurde von Anfang an von William H. Duquette konzipiert und umgesetzt.  Großer Dank gebührt jedoch den folgenden Personen, die Snit genutzt und mir wertvolles Feedback gegeben haben: Rolf Ade, Colin McCormack, Jose Nazario, Jeff Godfrey, Maurice Diamanti, Egon Pasztor, David S. Cargo, Tom Krehbiel, Michael Cleverly, Andreas Kupries, Marty Backe, Andy Goth, Jeff Hobbs, Brian Griffin, Donal Fellows, Miguel Sofer, Kenneth Green und Anton Kovalenko. Sollte ich jemanden vergessen haben, bitte ich um Entschuldigung; lassen Sie es mich wissen, und ich werde Ihren Namen der Liste hinzufügen.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *snit* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge

# Copyright

```
Copyright (c) 2003-2009, by William H. Duquette
```


[snitfaq]: snitfaq.md
