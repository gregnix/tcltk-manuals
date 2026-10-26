---
CommandName: extendedclass
ManualSection: n
Version: 4.0
TclPart: itcl
TclDescription: "[incr\\ Tcl]"
Keywords:
 - extendedclass
 - object
 - object-oriented
Copyright:
 - Copyright (c) 2008 Arnulf Wiedemann
---

# NAME

itcl::extendedclass - eine Extendedclass von Objekten erzeugen

# WARNUNG

Das ist neue Funktionalität in \[incr Tcl\], bei der sich die API noch ändern kann!!

# ÜBERSICHT

::: {.synopsis} :::
[itcl::extendedclass]{.cmd} [extendedclassName]{.arg} { 
[inherit]{.cmd} [baseExtendedclass]{.arg} [baseExtendedclass]{.optdot} 
[constructor]{.cmd} [args]{.arg} [init]{.optarg} [body]{.arg} 
[destructor]{.cmd} [body]{.arg} 
[public]{.cmd} [method]{.sub} [name]{.arg} [args]{.optarg} [body]{.optarg} 
[protected]{.cmd} [method]{.sub} [name]{.arg} [args]{.optarg} [body]{.optarg} 
[private]{.cmd} [method]{.sub} [name]{.arg} [args]{.optarg} [body]{.optarg} 
[public]{.cmd} [proc]{.sub} [name]{.arg} [args]{.optarg} [body]{.optarg} 
[protected]{.cmd} [proc]{.sub} [name]{.arg} [args]{.optarg} [body]{.optarg} 
[private]{.cmd} [proc]{.sub} [name]{.arg} [args]{.optarg} [body]{.optarg} 
[public]{.cmd} [variable]{.sub} [varName]{.arg} [init]{.optarg} [config]{.optarg} 
[protected]{.cmd} [variable]{.sub} [varName]{.arg} [init]{.optarg} [config]{.optarg} 
[private]{.cmd} [variable]{.sub} [varName]{.arg} [init]{.optarg} [config]{.optarg} 
[public]{.cmd} [common]{.sub} [varName]{.arg} [init]{.optarg} 
[protected]{.cmd} [common]{.sub} [varName]{.arg} [init]{.optarg} 
[private]{.cmd} [common]{.sub} [varName]{.arg} [init]{.optarg} 

[public]{.cmd} [command]{.arg} [arg arg]{.optdot} 
[protected]{.cmd} [command]{.arg} [arg arg]{.optdot} 
[private]{.cmd} [command]{.arg} [arg arg]{.optdot} 

[\<delegation]{.cmd} [info>]{.sub} see delegation page 

[\<option]{.cmd} [info>]{.sub} see option page 

[set]{.cmd} [varName]{.arg} [value]{.optarg} 
[array]{.cmd} [option]{.arg} [arg arg]{.optdot} 
}

*extendedclassName objName* ?*arg arg ...*?

*objName method* ?*arg arg ...*?

*extendedclassName::proc* ?*arg arg ...*?
:::

# BESCHREIBUNG

Das grundlegende Konstrukt in **\[incr**\\ **Tcl\]** ist die Extendedclass-Definition. Jede Extendedclass dient als Vorlage für tatsächliche Objekte, die erzeugt werden können. Die Extendedclass selbst ist ein Namespace, der enthält, was allen Objekten gemeinsam ist. Jedes Objekt hat sein eigenes Datenbündel, das Instanzen der in der Extendedclass-Definition festgelegten „variables“ enthält. Jedes Objekt hat außerdem eine eingebaute Variable namens „this“, die den Namen des Objekts enthält. Extendedclasses können auch „common“-Datenelemente haben, die allen Objekten einer Extendedclass gemeinsam sind.

In die Extendedclass-Definition können zwei Arten von Funktionen aufgenommen werden. „Methods“ sind Funktionen, die auf ein bestimmtes Objekt wirken und deshalb Zugriff auf „variables“ und auf „common“-Datenelemente haben. „Procs“ sind gewöhnliche Prozeduren im Namespace der Extendedclass und haben nur Zugriff auf „common“-Datenelemente.

Wenn der Rumpf einer Methode oder eines proc mit „**@**“ beginnt, wird er als symbolischer Name einer C-Prozedur behandelt. Sonst wird er als Tcl-Codeskript behandelt. Unten steht, wie C-Prozeduren registriert und verwendet werden.

Eine Extendedclass kann nur einmal definiert werden, die Rümpfe von Extendedclass-Methoden und procs lassen sich zur interaktiven Fehlersuche aber immer wieder definieren. Einzelheiten stehen bei den Befehlen **body** und **configbody**.

Jeder Namespace kann seine eigene Sammlung von Objekten und Extendedclasses haben. Die Liste der im aktuellen Kontext verfügbaren Extendedclasses lässt sich mit dem Befehl „**itcl::find extendedclasses**“ abfragen, die Liste der Objekte mit dem Befehl „**itcl::find objects**“.

Eine Extendedclass lässt sich mit dem Befehl „**delete extendedclass**“ löschen. Einzelne Objekte lassen sich mit dem Befehl „**delete object**“ löschen.

# EXTENDEDCLASS-DEFINITIONEN

**extendedclass** *extendedclassName definition*
: Liefert die Definition für eine Extendedclass namens *extendedclassName*. Wenn die Extendedclass *extendedclassName* bereits existiert oder im aktuellen Namespace-Kontext ein Befehl namens *extendedclassName* existiert, gibt dieser Befehl einen Fehler zurück. Wenn die Extendedclass-Definition erfolgreich zerlegt wird, wird *extendedclassName* ein Befehl im aktuellen Kontext und übernimmt das Erzeugen von Objekten dieser Extendedclass. Die *definition* der Extendedclass wird als Folge von Tcl-Anweisungen ausgewertet, die Elemente innerhalb der Extendedclass definieren. Die folgenden Befehle zur Extendedclass-Definition werden erkannt:


**inherit** *baseExtendedclass* ?*baseExtendedclass*...?
: Bewirkt, dass die aktuelle Extendedclass Eigenschaften von einer oder mehreren Basis-Extendedclasses erbt. Die Extendedclasses müssen durch einen vorherigen Befehl **extendedclass** definiert worden sein oder der Einrichtung zum automatischen Laden zur Verfügung stehen (siehe unten **AUTOMATISCHES LADEN**). Eine einzelne Extendedclass-Definition darf höchstens einen Befehl **inherit** enthalten.


Die Reihenfolge der Namen *baseExtendedclass* in der Liste **inherit** beeinflusst die Namensauflösung für Extendedclass-Mitglieder. Wenn derselbe Mitgliedsname in zwei oder mehr Basis-Extendedclasses vorkommt, hat die Basis-Extendedclass Vorrang, die in der Liste **inherit** zuerst steht. Wenn die Extendedclasses „Foo“ und „Bar“ zum Beispiel beide das Mitglied „x“ enthalten und eine andere Extendedclass die Anweisung „**inherit**“ hat:

```
inherit Foo Bar
```

dann bedeutet der Name „x“ „Foo::x“. Andere geerbte Mitglieder namens „x“ müssen mit ihrem ausdrücklichen Namen angesprochen werden, wie „Bar::x“.

**constructor** *args* ?*init*? *body*
: Deklariert die Argumentliste *args* und den *body*, die für den Konstruktor verwendet werden. Er wird automatisch aufgerufen, sobald ein Objekt erzeugt wird.


Bevor der *body* ausgeführt wird, dient die optionale Anweisung *init* dazu, Basis-Extendedclass-Konstruktoren aufzurufen, die Argumente verlangen. Variablen in der Angabe *args* sind im Codefragment *init* zugänglich und können an Basis-Extendedclass-Konstruktoren übergeben werden. Nach der Auswertung der Anweisung *init* werden alle noch nicht ausgeführten Basis-Extendedclass-Konstruktoren automatisch ohne Argumente aufgerufen. So sind alle Basis-Extendedclasses vollständig konstruiert, bevor der *body* des Konstruktors ausgeführt wird. Voreingestellt bewirkt dieses Schema, dass Konstruktoren der Reihe nach vom allgemeinsten zum spezifischsten aufgerufen werden. Das ist genau die umgekehrte Reihenfolge, in der der Befehl **info heritage** die Extendedclasses meldet.

Wenn die Konstruktion erfolgreich ist, gibt der Konstruktor immer den Objektnamen zurück, unabhängig davon, wie der *body* definiert ist, und der Objektname wird ein Befehl im aktuellen Namespace-Kontext. Wenn die Konstruktion scheitert, wird eine Fehlermeldung zurückgegeben.

**destructor** *body*
: Deklariert den *body* für den Destruktor, der automatisch aufgerufen wird, wenn ein Objekt gelöscht wird. Wenn der Destruktor erfolgreich ist, werden die Objektdaten zerstört und der Objektname als Befehl aus dem Interpreter entfernt. Wenn die Zerstörung scheitert, wird eine Fehlermeldung zurückgegeben und das Objekt bleibt bestehen. Wenn ein Objekt zerstört wird, werden alle Destruktoren seiner Extendedclass-Hierarchie der Reihe nach vom spezifischsten zum allgemeinsten aufgerufen. Das ist die Reihenfolge, in der der Befehl „**info heritage**“ die Extendedclasses meldet, und genau die Umkehrung der voreingestellten Konstruktorreihenfolge.

**method** *name* ?*args*? ?*body*?
: Deklariert eine Methode namens *name*. Wenn der *body* der Methode ausgeführt wird, hat er automatischen Zugriff auf objektspezifische Variablen und gemeinsame Datenelemente.


Wenn die Liste *args* angegeben ist, legt sie die Verwendungsangabe für diese Methode fest. Mit dem Befehl **body** lässt sich der Methodenrumpf neu definieren, die Liste *args* muss aber zu dieser Angabe passen.

Innerhalb des Rumpfes einer anderen Extendedclass-Methode lässt sich eine Methode wie jeder andere Befehl aufrufen, einfach über ihren Namen. Außerhalb des Extendedclass-Kontexts muss dem Methodennamen ein Objektname vorangestellt werden, der den Kontext für die Daten liefert, die sie bearbeitet. Methoden einer Basis-Extendedclass, die in der aktuellen Extendedclass neu definiert oder von einer anderen Basis-Extendedclass verdeckt sind, lassen sich mit der Syntax „*extendedclassName*::*method*“ qualifizieren.

**proc** *name* ?*args*? ?*body*?
: Deklariert ein proc namens *name*. Ein proc ist eine gewöhnliche Prozedur im Namespace der Extendedclass. Anders als eine Methode wird ein proc aufgerufen, ohne sich auf ein bestimmtes Objekt zu beziehen. Wenn der *body* des proc ausgeführt wird, hat er automatischen Zugriff nur auf gemeinsame Datenelemente.


Wenn die Liste *args* angegeben ist, legt sie die Verwendungsangabe für dieses proc fest. Mit dem Befehl **body** lässt sich der Rumpf des proc neu definieren, die Liste *args* muss aber zu dieser Angabe passen.

Innerhalb des Rumpfes einer anderen Extendedclass-Methode oder eines proc lässt sich ein proc wie jeder andere Befehl aufrufen, einfach über seinen Namen. In jedem anderen Namespace-Kontext wird das proc mit einem qualifizierten Namen wie „*extendedclassName*__::__*proc*“ aufgerufen. Procs einer Basis-Extendedclass, die in der aktuellen Extendedclass neu definiert oder von einer anderen Basis-Extendedclass verdeckt sind, sind ebenfalls über ihren qualifizierten Namen zugänglich.

**variable** *varName* ?*init*? ?*config*?
: Definiert eine objektspezifische Variable namens *varName*. Alle objektspezifischen Variablen stehen in Extendedclass-Methoden automatisch zur Verfügung. Sie müssen nicht mit etwas wie dem Befehl **global** deklariert werden.


Wenn die optionale Zeichenkette *init* angegeben ist, dient sie als Anfangswert der Variablen, wenn ein neues Objekt erzeugt wird. Die Initialisierung erzwingt, dass die Variable ein einfacher skalarer Wert ist; nicht initialisierte Variablen lassen sich dagegen im Konstruktor setzen und als Arrays verwenden.

Das optionale Skript *config* ist nur für öffentliche Variablen erlaubt. Wenn es angegeben ist, wird dieses Codefragment jedes Mal ausgeführt, wenn eine öffentliche Variable durch die eingebaute Methode „configure“ geändert wird. Das Skript *config* lässt sich auch außerhalb der Extendedclass-Definition mit dem Befehl **configbody** angeben.

**common** *varName* ?*init*?
: Deklariert eine common-Variable namens *varName*. Common-Variablen liegen im Namespace der Extendedclass und werden von allen Objekten geteilt, die zur Extendedclass gehören. Sie sind wie globale Variablen, nur dass sie nicht mit dem gewöhnlichen Befehl **global** deklariert werden müssen. Sie sind in allen Extendedclass-Methoden und procs automatisch sichtbar.


Wenn die optionale Zeichenkette *init* angegeben ist, dient sie als Anfangswert der Variablen. Die Initialisierung erzwingt, dass die Variable ein einfacher skalarer Wert ist; nicht initialisierte Variablen lassen sich dagegen mit nachfolgenden Befehlen **set** und **array** setzen und als Arrays verwenden.

Sobald ein gemeinsames Datenelement definiert ist, lässt es sich mit den Befehlen **set** und **array** innerhalb der Extendedclass-Definition setzen. Dadurch lassen sich gemeinsame Datenelemente als Arrays initialisieren. Zum Beispiel:

```
itcl::extendedclass Foo {
    common boolean
    set boolean(true) 1
    set boolean(false) 0
}
```

Wenn gemeinsame Datenelemente im Konstruktor initialisiert werden, werden sie jedes Mal erneut initialisiert, wenn neue Objekte erzeugt werden.

**public** *command* ?*arg arg ...*?
: ...siehe nächstes...

**protected** *command* ?*arg arg ...*?
: ...siehe nächstes...

**private** *command* ?*arg arg ...*?
: Diese Befehle setzen die Schutzstufe für Extendedclass-Mitglieder, die erzeugt werden, wenn *command* ausgewertet wird. Das *command* ist gewöhnlich **method**, **proc**, **variable** oder **common**, und die übrigen *arg* vervollständigen die Mitgliedsdefinition. *command* kann aber auch ein Skript mit vielen verschiedenen Mitgliedsdefinitionen sein, und die Schutzstufe gilt dann für alle erzeugten Mitglieder.


# VERWENDUNG DER EXTENDEDCLASS

Sobald eine Extendedclass definiert ist, kann der Extendedclass-Name als Befehl verwendet werden, um neue Objekte zu erzeugen, die zur Extendedclass gehören.

*extendedclassName objName* ?*args...*?
: Erzeugt ein neues Objekt der Extendedclass *extendedclassName* mit dem Namen *objName*. Die übrigen Argumente werden an den Konstruktor der spezifischsten Extendedclass übergeben. Der gibt seinerseits Argumente an die Konstruktoren der Basis-Extendedclasses weiter, bevor er seinen eigenen Befehlsumpf aufruft. Wenn die Konstruktion erfolgreich ist, wird im aktuellen Namespace-Kontext ein Befehl namens *objName* erzeugt, und *objName* wird als Ergebnis dieser Operation zurückgegeben. Wenn während der Konstruktion ein Fehler auftritt, werden die Destruktoren automatisch aufgerufen, um belegte Ressourcen freizugeben, das Objekt wird gelöscht, und ein Fehler wird zurückgegeben.


Wenn *objName* die Zeichenkette „**#auto**“ enthält, wird diese Zeichenkette durch einen automatisch erzeugten Namen ersetzt. Namen haben die Form *extendedclassName\<number>*, wobei der Teil *extendedclassName* so geändert wird, dass er mit einem Kleinbuchstaben beginnt. In der Extendedclass „Toaster“ würde die Angabe „**#auto**“ zum Beispiel Namen wie toaster0, toaster1 und so weiter erzeugen. „**#auto**“ kann auch mitten in einem Objektnamen stehen:

```
fileselectiondialog .foo.bar.#auto -background red
```

Das würde ein Objekt namens „.foo.bar.fileselectiondialog0“ erzeugen.

# VERWENDUNG DES OBJEKTS

Sobald ein Objekt erzeugt ist, kann der Objektname als Befehl verwendet werden, um Methoden aufzurufen, die auf das Objekt wirken.

*objName method* ?*args...*?
: Ruft eine Methode namens *method* auf einem Objekt namens *objName* auf. Die übrigen Argumente werden an die Argumentliste der Methode übergeben. Der Methodenname kann „constructor“, „destructor“, jeder Methodenname aus der Extendedclass-Definition oder eine der folgenden eingebauten Methoden sein.


# EINGEBAUTE METHODEN

*objName* **cget option**
: Erlaubt den Zugriff auf öffentliche Variablen als Konfigurationsoptionen. Das ahmt das Verhalten der gewöhnlichen Operation „cget“ für Tk-Widgets nach. Das Argument *option* ist eine Zeichenkette der Form „**-**_varName_“, und diese Methode gibt den aktuellen Wert der öffentlichen Variablen *varName* zurück.

*objName* **configure** ?*option*? ?*value option value ...*?
: Erlaubt den Zugriff auf öffentliche Variablen als Konfigurationsoptionen. Das ahmt das Verhalten der gewöhnlichen Operation „configure“ für Tk-Widgets nach. Ohne Argumente gibt diese Methode eine Liste von Listen zurück, die alle öffentlichen Variablen beschreibt. Jede Liste hat drei Elemente: den Variablennamen, seinen Anfangswert und seinen aktuellen Wert.


Wenn eine einzelne *option* der Form „**-**_varName_“ angegeben ist, gibt diese Methode die Angaben für diese eine Variable zurück.

Sonst werden die Argumente als Paare *option*/*value* behandelt, die öffentlichen Variablen neue Werte zuweisen. Jede Variable erhält ihren neuen Wert, und wenn ihr „config“-Code zugeordnet ist, wird er im Kontext der Extendedclass ausgeführt, in der sie definiert wurde. Wenn der „config“-Code einen Fehler erzeugt, wird die Variable auf ihren vorherigen Wert zurückgesetzt, und die Methode **configure** gibt einen Fehler zurück.

*objName* **isa** *extendedclassName*
: Gibt einen Wert ungleich null zurück, wenn der gegebene *extendedclassName* in der Abstammung des Objekts zu finden ist, und sonst null.

*objName* **info** *option* ?*args...*?
: Gibt Angaben zu einem bestimmten Objekt namens *objName* oder zu seiner Extendedclass-Definition zurück. Der Parameter *option* umfasst die folgenden Dinge sowie die Optionen, die der gewöhnliche Tcl-Befehl „info“ erkennt:


*objName* **info extendedclass**
: Gibt den Namen der spezifischsten Extendedclass des Objekts *objName* zurück.

*objName* **info inherit**
: Gibt die Liste der Basis-Extendedclasses zurück, wie sie im Befehl „**inherit**“ definiert wurden, oder eine leere Zeichenkette, wenn diese Extendedclass keine Basis-Extendedclasses hat.

*objName* **info heritage**
: Gibt den aktuellen Extendedclass-Namen und die gesamte Liste der Basis-Extendedclasses in der Reihenfolge zurück, in der sie bei der Mitgliedersuche und bei der Objektzerstörung durchlaufen werden.

*objName* **info function** ?*cmdName*? ?**-protection**? ?**-type**? ?**-name**? ?**-args**? ?**-body**?
: Ohne Argumente gibt dieser Befehl eine Liste aller Extendedclass-Methoden und procs zurück. Wenn *cmdName* angegeben ist, gibt er Angaben zu einer bestimmten Methode oder einem bestimmten proc zurück. Wenn keine Flags angegeben sind, gibt dieser Befehl eine Liste mit den folgenden Elementen zurück: der Schutzstufe, dem Typ (method/proc), dem qualifizierten Namen, der Argumentliste und dem Rumpf. Mit Flags lassen sich bestimmte Elemente aus dieser Liste anfordern.

*objName* **info variable** ?*varName*? ?**-protection**? ?**-type**? ?**-name**? ?**-init**? ?**-value**? ?**-config**?
: Ohne Argumente gibt dieser Befehl eine Liste aller objektspezifischen Variablen und gemeinsamen Datenelemente zurück. Wenn *varName* angegeben ist, gibt er Angaben zu einem bestimmten Datenelement zurück. Wenn keine Flags angegeben sind, gibt dieser Befehl eine Liste mit den folgenden Elementen zurück: der Schutzstufe, dem Typ (variable/common), dem qualifizierten Namen, dem Anfangswert und dem aktuellen Wert. Wenn *varName* eine öffentliche Variable ist, steht der „config“-Code auf dieser Liste. Mit Flags lassen sich bestimmte Elemente aus dieser Liste anfordern.


# VERKETTEN VON METHODEN UND PROCS

Manchmal hat eine Basis-Extendedclass eine Methode oder ein proc, das in einer abgeleiteten Extendedclass unter demselben Namen neu definiert wird. So kann die abgeleitete Extendedclass dieselben Operationen wie die Basis-Extendedclass behandeln, aber mit ihrem eigenen spezialisierten Verhalten. Angenommen, eine Extendedclass Toaster sieht so aus:

```
itcl::extendedclass Toaster {
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

Eine weitere Extendedclass wie SmartToaster könnte die Methode „toast“ neu definieren. Wenn die Methode der Basis-Extendedclass zugänglich sein soll, lässt sie sich mit dem Namen der Basis-Extendedclass qualifizieren, um Mehrdeutigkeit zu vermeiden:

```
itcl::extendedclass SmartToaster {
    inherit Toaster
    method toast {nslices} {
        if {$crumbs > 40} {
            clean
        }
        return [Toaster::toast $nslices]
    }
}
```

Statt den Namen der Basis-Extendedclass fest einzutragen, lässt sich der Befehl „chain“ so verwenden:

```
itcl::extendedclass SmartToaster {
    inherit Toaster
    method toast {nslices} {
        if {$crumbs > 40} {
            clean
        }
        return [chain $nslices]
    }
}
```

Der Befehl chain sucht in der Extendedclass-Hierarchie nach einer etwas allgemeineren Umsetzung (Basis-Extendedclass) einer Methode oder eines proc und ruft sie mit den angegebenen Argumenten auf. Er beginnt beim aktuellen Extendedclass-Kontext und durchsucht die Basis-Extendedclasses in der Reihenfolge, die der Befehl „info heritage“ meldet. Wenn keine andere Umsetzung gefunden wird, tut dieser Befehl nichts und gibt die leere Zeichenkette zurück.

# AUTOMATISCHES LADEN

Extendedclass-Definitionen müssen nicht ausdrücklich geladen werden; sie können bei Bedarf von der gewöhnlichen Tcl-Einrichtung zum automatischen Laden geladen werden. Jedes Verzeichnis mit Dateien von Extendedclass-Definitionen sollte eine begleitende Datei „tclIndex“ haben. Jede Zeile dieser Datei nennt eine Tcl-Prozedur oder eine Extendedclass-Definition von **\[incr**\\ **Tcl\]** und die Datei, in der die Definition zu finden ist.

Angenommen, ein Verzeichnis enthält die Definitionen der Extendedclasses „Toaster“ und „SmartToaster“. Dann sähe die Datei „tclIndex“ für dieses Verzeichnis so aus:

```
# Tcl-Autoload-Indexdatei, Version 2.0 für [incr Tcl]
# Diese Datei wird vom Befehl „auto_mkindex“ erzeugt
# und eingelesen, um Indexangaben für einen oder
# mehrere Befehle einzurichten. Gewöhnlich ist jede Zeile ein Befehl,
# der ein Element im Array auto_index setzt, wobei der
# Elementname der Name eines Befehls ist und der Wert
# ein Skript ist, das den Befehl lädt.

set auto_index(::Toaster) "source $dir/Toaster.itcl"
set auto_index(::SmartToaster) "source $dir/SmartToaster.itcl"
```

Der Befehl **auto_mkindex** erzeugt Dateien „tclIndex“ automatisch.

Der automatische Lader muss dieses Verzeichnis kennen, indem der Verzeichnisname an die Variable „auto_path“ angehängt wird. Wenn das eingerichtet ist, werden Extendedclasses bei der Verwendung in einer Anwendung bei Bedarf automatisch geladen.

# C-PROZEDUREN

C-Prozeduren lassen sich in eine Extendedclass-Definition von **\[incr**\\ **Tcl\]** einbinden, um Methoden, procs und den „config“-Code öffentlicher Variablen umzusetzen. Jeder Rumpf, der mit „**@**“ beginnt, wird als symbolischer Name einer C-Prozedur behandelt.

Symbolische Namen werden festgelegt, indem Prozeduren über **Itcl_RegisterObjC()** registriert werden. Das geschieht gewöhnlich in der Prozedur **Tcl_AppInit()**, die automatisch aufgerufen wird, wenn der Interpreter startet. Im folgenden Beispiel wird die Prozedur \\ffCMy_FooObjCmd() unter dem symbolischen Namen „foo“ registriert. Im Befehl **body** lässt sich diese Prozedur als "\\ffC@foo" ansprechen.

```
int
Tcl_AppInit(interp)
    Tcl_Interp *interp;     /* Interpreter für die Anwendung. */
{
    if (Itcl_Init(interp) == TCL_ERROR) {
        return TCL_ERROR;
    }

    if (Itcl_RegisterObjC(interp, "foo", My_FooObjCmd) != TCL_OK) {
        return TCL_ERROR;
    }
}
```

C-Prozeduren werden genau wie gewöhnliche Tcl-Befehle umgesetzt. Einzelheiten stehen auf der Handbuchseite von **CrtCommand**. Innerhalb der Prozedur sind Extendedclass-Datenelemente wie gewöhnliche Variablen über **Tcl_SetVar()**, **Tcl_GetVar()**, **Tcl_TraceVar()** und so weiter zugänglich. Extendedclass-Methoden und procs lassen sich wie gewöhnliche Befehle über **Tcl_Eval()** ausführen. **\[incr**\\ **Tcl\]** macht das möglich, indem es den Kontext automatisch einrichtet, bevor die C-Prozedur ausgeführt wird.

Dieses Schema bietet einen natürlichen Weg, den Code weiterzuentwickeln. Extendedclasses lassen sich schnell entwickeln, indem die Rümpfe in Tcl-Code umgesetzt werden. Eine ganze Anwendung lässt sich bauen und prüfen. Wenn nötig, lassen sich einzelne Rümpfe in C-Code umsetzen, um die Leistung zu verbessern.
