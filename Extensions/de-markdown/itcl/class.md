---
CommandName: class
title: class
ManualSection: n
Version: unknown
TclPart: itcl
TclDescription: "[incr Tcl]"
Keywords:
 - class
 - object
 - object-oriented
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

itcl::class - eine Klasse von Objekten erzeugen

# Übersicht

::: {.synopsis} :::
[itcl::class]{.cmd} [className]{.arg} [{]{.lit}
[inherit]{.cmd} [baseClass]{.arg} [baseClass...]{.optarg}
[constructor]{.cmd} [args]{.arg} [init]{.optarg} [body]{.arg}
[destructor]{.cmd} [body]{.arg}
[method]{.cmd} [name]{.arg} [args]{.optarg} [body]{.optarg}
[proc]{.cmd} [name]{.arg} [args]{.optarg} [body]{.optarg}
[variable]{.cmd} [varName]{.arg} [init]{.optarg} [config]{.optarg}
[common]{.cmd} [varName]{.arg} [init]{.optarg}

[public]{.cmd} [command]{.arg} [arg arg]{.optdot}
[protected]{.cmd} [command]{.arg} [arg arg]{.optdot}
[private]{.cmd} [command]{.arg} [arg arg]{.optdot}

[set]{.cmd} [varName]{.arg} [value]{.optarg}
[array]{.cmd} [option]{.arg} [arg arg]{.optdot}
[}]{.cmd}

[className]{.ins} [objName]{.arg} [arg arg]{.optdot}

[objName]{.ins} [method]{.arg} [arg arg]{.optdot}

[className::proc]{.ins} [arg arg]{.optdot}
:::

# Beschreibung

Das grundlegende Konstrukt in **\[incr Tcl\]** ist die Klassendefinition. Jede Klasse dient als Vorlage für tatsächliche Objekte, die erzeugt werden können. Die Klasse selbst ist ein Namespace, der enthält, was allen Objekten gemeinsam ist. Jedes Objekt hat sein eigenes Datenbündel, das Instanzen der in der Klassendefinition festgelegten „variables“ enthält. Jedes Objekt hat außerdem eine eingebaute Variable namens „this“, die den Namen des Objekts enthält. Klassen können auch „common“-Datenelemente haben, die allen Objekten einer Klasse gemeinsam sind.

In die Klassendefinition können zwei Arten von Funktionen aufgenommen werden. „Methods“ sind Funktionen, die auf ein bestimmtes Objekt wirken und deshalb Zugriff auf „variables“ und auf „common“-Datenelemente haben. „Procs“ sind gewöhnliche Prozeduren im Namespace der Klasse und haben nur Zugriff auf „common“-Datenelemente.

Wenn der Rumpf einer Methode oder eines proc mit „**@**“ beginnt, wird er als symbolischer Name einer C-Prozedur behandelt. Sonst wird er als Tcl-Codeskript behandelt. Unten steht, wie C-Prozeduren registriert und verwendet werden.

Eine Klasse kann nur einmal definiert werden, die Rümpfe von Klassenmethoden und procs lassen sich zur interaktiven Fehlersuche aber immer wieder definieren. Einzelheiten stehen bei den Befehlen **body** und **configbody**.

Jeder Namespace kann seine eigene Sammlung von Objekten und Klassen haben. Die Liste der im aktuellen Kontext verfügbaren Klassen lässt sich mit dem Befehl „[itcl::find classes][find]“ abfragen, die Liste der Objekte mit dem Befehl „[itcl::find objects][find]“.

Eine Klasse lässt sich mit dem Befehl „**delete class**“ löschen. Einzelne Objekte lassen sich mit dem Befehl „**delete object**“ löschen.

# Klassendefinitionen

**class** *className definition*
: Liefert die Definition für eine Klasse namens *className*. Wenn die Klasse *className* bereits existiert oder im aktuellen Namespace-Kontext ein Befehl namens *className* existiert, gibt dieser Befehl einen Fehler zurück. Wenn die Klassendefinition erfolgreich zerlegt wird, wird *className* ein Befehl im aktuellen Kontext und übernimmt das Erzeugen von Objekten dieser Klasse.


Die Klassen*definition* wird als Folge von Tcl-Anweisungen ausgewertet, die Elemente innerhalb der Klasse definieren. Die folgenden Befehle zur Klassendefinition werden erkannt:

**inherit** *baseClass* ?*baseClass*...?
: Bewirkt, dass die aktuelle Klasse Eigenschaften von einer oder mehreren Basisklassen erbt. Die Klassen müssen durch einen vorherigen Befehl **class** definiert worden sein oder der Einrichtung zum automatischen Laden zur Verfügung stehen (siehe unten **AUTOMATISCHES LADEN**). Eine einzelne Klassendefinition darf höchstens einen Befehl **inherit** enthalten.

    Die Reihenfolge der Namen *baseClass* in der Liste **inherit** beeinflusst die Namensauflösung für Klassenmitglieder. Wenn derselbe Mitgliedsname in zwei oder mehr Basisklassen vorkommt, hat die Basisklasse Vorrang, die in der Liste **inherit** zuerst steht. Wenn die Klassen „Foo“ und „Bar“ zum Beispiel beide das Mitglied „x“ enthalten und eine andere Klasse die Anweisung „**inherit**“ hat:

    ```
    inherit Foo Bar
    ```

    dann bedeutet der Name „x“ „Foo::x“. Andere geerbte Mitglieder namens „x“ müssen mit ihrem ausdrücklichen Namen angesprochen werden, wie „Bar::x“.

**constructor** *args* ?*init*? *body*
: Deklariert die Argumentliste *args* und den *body*, die für den Konstruktor verwendet werden. Er wird automatisch aufgerufen, sobald ein Objekt erzeugt wird.

    Bevor der *body* ausgeführt wird, dient die optionale Anweisung *init* dazu, Basisklassen-Konstruktoren aufzurufen, die Argumente verlangen. Variablen in der Angabe *args* sind im Codefragment *init* zugänglich und können an Basisklassen-Konstruktoren übergeben werden. Nach der Auswertung der Anweisung *init* werden alle noch nicht ausgeführten Basisklassen-Konstruktoren automatisch ohne Argumente aufgerufen. So sind alle Basisklassen vollständig konstruiert, bevor der *body* des Konstruktors ausgeführt wird. Voreingestellt bewirkt dieses Schema, dass Konstruktoren der Reihe nach vom allgemeinsten zum spezifischsten aufgerufen werden. Das ist genau die umgekehrte Reihenfolge, in der der Befehl **info heritage** die Klassen meldet.

    Wenn die Konstruktion erfolgreich ist, gibt der Konstruktor immer den Objektnamen zurück, unabhängig davon, wie der *body* definiert ist, und der Objektname wird ein Befehl im aktuellen Namespace-Kontext. Wenn die Konstruktion scheitert, wird eine Fehlermeldung zurückgegeben.

**destructor** *body*
: Deklariert den *body* für den Destruktor, der automatisch aufgerufen wird, wenn ein Objekt gelöscht wird. Wenn der Destruktor erfolgreich ist, werden die Objektdaten zerstört und der Objektname als Befehl aus dem Interpreter entfernt. Wenn die Zerstörung scheitert, wird eine Fehlermeldung zurückgegeben und das Objekt bleibt bestehen.

    Wenn ein Objekt zerstört wird, werden alle Destruktoren seiner Klassenhierarchie der Reihe nach vom spezifischsten zum allgemeinsten aufgerufen. Das ist die Reihenfolge, in der der Befehl „**info heritage**“ die Klassen meldet, und genau die Umkehrung der voreingestellten Konstruktorreihenfolge.

**method** *name* ?*args*? ?*body*?
: Deklariert eine Methode namens *name*. Wenn der *body* der Methode ausgeführt wird, hat er automatischen Zugriff auf objektspezifische Variablen und gemeinsame Datenelemente.

    Wenn die Liste *args* angegeben ist, legt sie die Verwendungsangabe für diese Methode fest. Mit dem Befehl **body** lässt sich der Methodenrumpf neu definieren, die Liste *args* muss aber zu dieser Angabe passen.

    Innerhalb des Rumpfes einer anderen Klassenmethode lässt sich eine Methode wie jeder andere Befehl aufrufen, einfach über ihren Namen. Außerhalb des Klassenkontexts muss dem Methodennamen ein Objektname vorangestellt werden, der den Kontext für die Daten liefert, die sie bearbeitet. Methoden einer Basisklasse, die in der aktuellen Klasse neu definiert oder von einer anderen Basisklasse verdeckt sind, lassen sich mit der Syntax „*className*::*method*“ qualifizieren.

**proc** *name* ?*args*? ?*body*?
: Deklariert ein proc namens *name*. Ein proc ist eine gewöhnliche Prozedur im Namespace der Klasse. Anders als eine Methode wird ein proc aufgerufen, ohne sich auf ein bestimmtes Objekt zu beziehen. Wenn der *body* des proc ausgeführt wird, hat er automatischen Zugriff nur auf gemeinsame Datenelemente.

    Wenn die Liste *args* angegeben ist, legt sie die Verwendungsangabe für dieses proc fest. Mit dem Befehl **body** lässt sich der Rumpf des proc neu definieren, die Liste *args* muss aber zu dieser Angabe passen.

    Innerhalb des Rumpfes einer anderen Klassenmethode oder eines proc lässt sich ein proc wie jeder andere Befehl aufrufen, einfach über seinen Namen. In jedem anderen Namespace-Kontext wird das proc mit einem qualifizierten Namen wie „*className*__::__*proc*“ aufgerufen. Procs einer Basisklasse, die in der aktuellen Klasse neu definiert oder von einer anderen Basisklasse verdeckt sind, sind ebenfalls über ihren qualifizierten Namen zugänglich.

**variable** *varName* ?*init*? ?*config*?
: Definiert eine objektspezifische Variable namens *varName*. Alle objektspezifischen Variablen stehen in Klassenmethoden automatisch zur Verfügung. Sie müssen nicht mit etwas wie dem Befehl **global** deklariert werden.

    Wenn die optionale Zeichenkette *init* angegeben ist, dient sie als Anfangswert der Variablen, wenn ein neues Objekt erzeugt wird. Die Initialisierung erzwingt, dass die Variable ein einfacher skalarer Wert ist; nicht initialisierte Variablen lassen sich dagegen im Konstruktor setzen und als Arrays verwenden.

    Das optionale Skript *config* ist nur für öffentliche Variablen erlaubt. Wenn es angegeben ist, wird dieses Codefragment jedes Mal ausgeführt, wenn eine öffentliche Variable durch die eingebaute Methode „configure“ geändert wird. Das Skript *config* lässt sich auch außerhalb der Klassendefinition mit dem Befehl **configbody** angeben.

**common** *varName* ?*init*?
: Deklariert eine common-Variable namens *varName*. Common-Variablen liegen im Namespace der Klasse und werden von allen Objekten geteilt, die zur Klasse gehören. Sie sind wie globale Variablen, nur dass sie nicht mit dem gewöhnlichen Befehl **global** deklariert werden müssen. Sie sind in allen Klassenmethoden und procs automatisch sichtbar.

    Wenn die optionale Zeichenkette *init* angegeben ist, dient sie als Anfangswert der Variablen. Die Initialisierung erzwingt, dass die Variable ein einfacher skalarer Wert ist; nicht initialisierte Variablen lassen sich dagegen mit nachfolgenden Befehlen **set** und **array** setzen und als Arrays verwenden.

    Sobald ein gemeinsames Datenelement definiert ist, lässt es sich mit den Befehlen **set** und **array** innerhalb der Klassendefinition setzen. Dadurch lassen sich gemeinsame Datenelemente als Arrays initialisieren. Zum Beispiel:

    ```
    itcl::class Foo {
        common boolean
        set boolean(true) 1
        set boolean(false) 0
    }
    ```

    Wenn gemeinsame Datenelemente im Konstruktor initialisiert werden, werden sie jedes Mal erneut initialisiert, wenn neue Objekte erzeugt werden.

[public][itclcomponent] *command* ?*arg arg ...*?
: siehe unten ...

[protected][itclcomponent] *command* ?*arg arg ...*?
: siehe unten ...

[private][itclcomponent] *command* ?*arg arg ...*?
: Diese Befehle setzen die Schutzstufe für Klassenmitglieder, die erzeugt werden, wenn *command* ausgewertet wird. Das *command* ist gewöhnlich **method**, **proc**, **variable** oder **common**, und die übrigen *arg* vervollständigen die Mitgliedsdefinition. *command* kann aber auch ein Skript mit vielen verschiedenen Mitgliedsdefinitionen sein, und die Schutzstufe gilt dann für alle erzeugten Mitglieder.


# Verwendung der Klasse

Sobald eine Klasse definiert ist, kann der Klassenname als Befehl verwendet werden, um neue Objekte zu erzeugen, die zur Klasse gehören.

*className objName* ?*args...*?
: Erzeugt ein neues Objekt der Klasse *className* mit dem Namen *objName*. Die übrigen Argumente werden an den Konstruktor der spezifischsten Klasse übergeben. Der gibt seinerseits Argumente an die Konstruktoren der Basisklassen weiter, bevor er seinen eigenen Befehlsumpf aufruft. Wenn die Konstruktion erfolgreich ist, wird im aktuellen Namespace-Kontext ein Befehl namens *objName* erzeugt, und *objName* wird als Ergebnis dieser Operation zurückgegeben. Wenn während der Konstruktion ein Fehler auftritt, werden die Destruktoren automatisch aufgerufen, um belegte Ressourcen freizugeben, das Objekt wird gelöscht, und ein Fehler wird zurückgegeben.

    Wenn *objName* die Zeichenkette „**#auto**“ enthält, wird diese Zeichenkette durch einen automatisch erzeugten Namen ersetzt. Namen haben die Form *className<number>*, wobei der Teil *className* so geändert wird, dass er mit einem Kleinbuchstaben beginnt. In der Klasse „Toaster“ würde die Angabe „**#auto**“ zum Beispiel Namen wie toaster0, toaster1 und so weiter erzeugen. „**#auto**“ kann auch mitten in einem Objektnamen stehen:

    ```
    fileselectiondialog .foo.bar.#auto -background red
    ```

    Das würde ein Objekt namens „.foo.bar.fileselectiondialog0“ erzeugen.


# Verwendung des Objekts

Sobald ein Objekt erzeugt ist, kann der Objektname als Befehl verwendet werden, um Methoden aufzurufen, die auf das Objekt wirken.

*objName method* ?*args...*?
: Ruft eine Methode namens *method* auf einem Objekt namens *objName* auf. Die übrigen Argumente werden an die Argumentliste der Methode übergeben. Der Methodenname kann „constructor“, „destructor“, jeder Methodenname aus der Klassendefinition oder eine der folgenden eingebauten Methoden sein.


# Eingebaute Methoden

*objName* **cget option**
: Erlaubt den Zugriff auf öffentliche Variablen als Konfigurationsoptionen. Das ahmt das Verhalten der gewöhnlichen Operation „cget“ für Tk-Widgets nach. Das Argument *option* ist eine Zeichenkette der Form „**-**_varName_“, und diese Methode gibt den aktuellen Wert der öffentlichen Variablen *varName* zurück.

*objName* **configure** ?*option*? ?*value option value ...*?
: Erlaubt den Zugriff auf öffentliche Variablen als Konfigurationsoptionen. Das ahmt das Verhalten der gewöhnlichen Operation „configure“ für Tk-Widgets nach. Ohne Argumente gibt diese Methode eine Liste von Listen zurück, die alle öffentlichen Variablen beschreibt. Jede Liste hat drei Elemente: den Variablennamen, seinen Anfangswert und seinen aktuellen Wert.

    Wenn eine einzelne *option* der Form „**-**_varName_“ angegeben ist, gibt diese Methode die Angaben für diese eine Variable zurück.

    Sonst werden die Argumente als Paare *option*/*value* behandelt, die öffentlichen Variablen neue Werte zuweisen. Jede Variable erhält ihren neuen Wert, und wenn ihr „config“-Code zugeordnet ist, wird er im Kontext der Klasse ausgeführt, in der sie definiert wurde. Wenn der „config“-Code einen Fehler erzeugt, wird die Variable auf ihren vorherigen Wert zurückgesetzt, und die Methode **configure** gibt einen Fehler zurück.

*objName* **isa** *className*
: Gibt einen Wert ungleich null zurück, wenn der gegebene *className* in der Abstammung des Objekts zu finden ist, und sonst null.

*objName* **info** *option* ?*args...*?
: Gibt Angaben zu einem bestimmten Objekt namens *objName* oder zu seiner Klassendefinition zurück. Der Parameter *option* umfasst die folgenden Dinge sowie die Optionen, die der gewöhnliche Tcl-Befehl „info“ erkennt:

    *objName* **info class**
    : Gibt den Namen der spezifischsten Klasse des Objekts *objName* zurück.

    *objName* **info inherit**
    : Gibt die Liste der Basisklassen zurück, wie sie im Befehl „**inherit**“ definiert wurden, oder eine leere Zeichenkette, wenn diese Klasse keine Basisklassen hat.

    *objName* **info heritage**
    : Gibt den aktuellen Klassennamen und die gesamte Liste der Basisklassen in der Reihenfolge zurück, in der sie bei der Mitgliedersuche und bei der Objektzerstörung durchlaufen werden.

    *objName* **info function** ?*cmdName*? ?**-protection**? ?**-type**? ?**-name**? ?**-args**? ?**-body**?
    : Ohne Argumente gibt dieser Befehl eine Liste aller Klassenmethoden und procs zurück. Wenn *cmdName* angegeben ist, gibt er Angaben zu einer bestimmten Methode oder einem bestimmten proc zurück. Wenn keine Flags angegeben sind, gibt dieser Befehl eine Liste mit den folgenden Elementen zurück: der Schutzstufe, dem Typ (method/proc), dem qualifizierten Namen, der Argumentliste und dem Rumpf. Mit Flags lassen sich bestimmte Elemente aus dieser Liste anfordern.

    *objName* **info variable** ?*varName*? ?**-protection**? ?**-type**? ?**-name**? ?**-init**? ?**-value**? ?**-config**? ?**-scope**?
    : Ohne Argumente gibt dieser Befehl eine Liste aller objektspezifischen Variablen und gemeinsamen Datenelemente zurück. Wenn *varName* angegeben ist, gibt er Angaben zu einem bestimmten Datenelement zurück. Flags können zusammen mit *varName* in beliebiger Reihenfolge angegeben werden. Das Ergebnis ist eine Liste der genannten Angaben in genau der Reihenfolge der Flags.

        Wenn keine Flags angegeben sind, gibt dieser Befehl eine Liste zurück, als wären die folgenden Flags angegeben worden:

        **-protection** **-type** **-name** **-init** **-value** ?**-config**?

        Das Ergebnis **-config** ist nur vorhanden, wenn *varName* eine öffentliche Variable ist. Es enthält den Code, der bei der Initialisierung von *varName* ausgeführt wird. Das Flag **-scope** gibt den Namespace-Kontext von *varName*. Damit lässt sich die Variable von außerhalb des Objekts wie jede andere Variable ansprechen. Es ähnelt dem Ergebnis des Befehls [itcl::scope][scope].



# Verketten von Methoden und Procs

Manchmal hat eine Basisklasse eine Methode oder ein proc, das in einer abgeleiteten Klasse unter demselben Namen neu definiert wird. So kann die abgeleitete Klasse dieselben Operationen wie die Basisklasse behandeln, aber mit ihrem eigenen spezialisierten Verhalten. Angenommen, eine Klasse Toaster sieht so aus:

```
itcl::class Toaster {
    variable crumbs 0
    method toast {nslices} {
        if {$crumbs > 50} {
            error "== FIRE! FIRE! =="
        }
        set crumbs [expr {$crumbs+4*$nslices}]
    }
    method clean {} {
        set crumbs 0
    }
}
```

Eine weitere Klasse wie SmartToaster könnte die Methode „toast“ neu definieren. Wenn die Methode der Basisklasse zugänglich sein soll, lässt sie sich mit dem Namen der Basisklasse qualifizieren, um Mehrdeutigkeit zu vermeiden:

```
itcl::class SmartToaster {
    inherit Toaster
    method toast {nslices} {
        if {$crumbs > 40} {
            clean
        }
        return [Toaster::toast $nslices]
    }
}
```

Statt den Namen der Basisklasse fest einzutragen, lässt sich der Befehl „chain“ so verwenden:

```
itcl::class SmartToaster {
    inherit Toaster
    method toast {nslices} {
        if {$crumbs > 40} {
            clean
        }
        return [chain $nslices]
    }
}
```

Der Befehl chain sucht in der Klassenhierarchie nach einer etwas allgemeineren Umsetzung (Basisklasse) einer Methode oder eines proc und ruft sie mit den angegebenen Argumenten auf. Er beginnt beim aktuellen Klassenkontext und durchsucht die Basisklassen in der Reihenfolge, die der Befehl „info heritage“ meldet. Wenn keine andere Umsetzung gefunden wird, tut dieser Befehl nichts und gibt die leere Zeichenkette zurück.

# Automatisches Laden

Klassendefinitionen müssen nicht ausdrücklich geladen werden; sie können bei Bedarf von der gewöhnlichen Tcl-Einrichtung zum automatischen Laden geladen werden. Jedes Verzeichnis mit Dateien von Klassendefinitionen sollte eine begleitende Datei „tclIndex“ haben. Jede Zeile dieser Datei nennt eine Tcl-Prozedur oder eine Klassendefinition von **\[incr Tcl\]** und die Datei, in der die Definition zu finden ist.

Angenommen, ein Verzeichnis enthält die Definitionen der Klassen „Toaster“ und „SmartToaster“. Dann sähe die Datei „tclIndex“ für dieses Verzeichnis so aus:

```
# Tcl autoload index file, version 2.0 for [incr Tcl]
# This file is generated by the "auto_mkindex" command
# and sourced to set up indexing information for one or
# more commands.  Typically each line is a command that
# sets an element in the auto_index array, where the
# element name is the name of a command and the value is
# a script that loads the command.

set auto_index(::Toaster) "source $dir/Toaster.itcl"
set auto_index(::SmartToaster) "source $dir/SmartToaster.itcl"
```

Der Befehl **auto\_mkindex** erzeugt Dateien „tclIndex“ automatisch.

Der automatische Lader muss dieses Verzeichnis kennen, indem der Verzeichnisname an die Variable „auto\_path“ angehängt wird. Wenn das eingerichtet ist, werden Klassen bei der Verwendung in einer Anwendung bei Bedarf automatisch geladen.

# C-Prozeduren

C-Prozeduren lassen sich in eine Klassendefinition von **\[incr Tcl\]** einbinden, um Methoden, procs und den „config“-Code öffentlicher Variablen umzusetzen. Jeder Rumpf, der mit „**@**“ beginnt, wird als symbolischer Name einer C-Prozedur behandelt.

Symbolische Namen werden festgelegt, indem Prozeduren über **Itcl\_RegisterObjC()** registriert werden. Das geschieht gewöhnlich in der Prozedur **Tcl\_AppInit()**, die automatisch aufgerufen wird, wenn der Interpreter startet. Im folgenden Beispiel wird die Prozedur **My\_FooObjCmd()** unter dem symbolischen Namen „foo“ registriert. Im Befehl **body** lässt sich diese Prozedur als "**@foo**" ansprechen.

```
int
Tcl_AppInit(interp)
    Tcl_Interp *interp;     /* Interpreter for application. */
{
    if (Itcl_Init(interp) == TCL_ERROR) {
        return TCL_ERROR;
    }

    if (Itcl_RegisterObjC(interp, "foo", My_FooObjCmd) != TCL_OK) {
        return TCL_ERROR;
    }
}
```

C-Prozeduren werden genau wie gewöhnliche Tcl-Befehle umgesetzt. Einzelheiten stehen auf der Handbuchseite von **CrtCommand**. Innerhalb der Prozedur sind Klassendatenelemente wie gewöhnliche Variablen über **Tcl\_SetVar()**, **Tcl\_GetVar()**, **Tcl\_TraceVar()** und so weiter zugänglich. Klassenmethoden und procs lassen sich wie gewöhnliche Befehle über **Tcl\_Eval()** ausführen. **\[incr Tcl\]** macht das möglich, indem es den Kontext automatisch einrichtet, bevor die C-Prozedur ausgeführt wird.

Dieses Schema bietet einen natürlichen Weg, den Code weiterzuentwickeln. Klassen lassen sich schnell entwickeln, indem die Rümpfe in Tcl-Code umgesetzt werden. Eine ganze Anwendung lässt sich bauen und prüfen. Wenn nötig, lassen sich einzelne Rümpfe in C-Code umsetzen, um die Leistung zu verbessern.


[find]: find.md
[itclcomponent]: itclcomponent.md
[scope]: scope.md
