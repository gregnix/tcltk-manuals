---
CommandName: Archetype
title: Archetype
ManualSection: n
Version: 3.0
TclPart: itk
TclDescription: "[incr Tk]"
Keywords:
 - itk
 - Widget
 - Toplevel
 - mega-widget
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

Archetype - Basisklasse für alle Megawidgets von \[incr\\ Tk\]

# Vererbung

keine

# Widget-spezifische Optionen

**-clientdata** (**clientData**/**ClientData**)
: Das beeinflusst den Betrieb des Widgets in keiner Weise. Es ist lediglich ein Haken, über den Aufrufer bei jedem Widget ein paar Daten ablegen können. Das ist praktisch, wenn mit Widgets Anwendungen gebaut werden.


# Beschreibung

Die Klasse **Archetype** ist die Grundlage aller Megawidgets von **\[incr Tk\]**. Sie verfolgt Komponenten-Widgets und stellt Methoden wie „configure“ und „cget“ bereit, mit denen auf die zusammengesetzten Konfigurationsoptionen zugegriffen wird. Jedes Komponenten-Widget muss mit der Methode „**itk\_component add**“ bei der Basisklasse **Archetype** registriert werden. Wenn die Komponente registriert wird, gehen ihre Konfigurationsoptionen in die zusammengesetzte Optionsliste ein. Das Konfigurieren einer zusammengesetzten Option wie „-background“ bewirkt, dass alle internen Komponenten ihre Hintergrundfarbe ändern.

Sie wird nicht selbst als Widget verwendet, sondern als Basisklasse für stärker spezialisierte Widgets. Die Basisklasse [Widget] erbt von **Archetype** und fügt einen Tk-Frame hinzu, der als „hull“ des Megawidgets dient. Die Basisklasse [Toplevel] erbt von **Archetype**, fügt aber ein Toplevel-Fenster von Tk hinzu, das als „hull“ dient.

*Jede abgeleitete Klasse muss die Methode* **itk\_initialize** in ihrem Konstruktor aufrufen, damit alle Optionen richtig in die zusammengesetzte Liste eingehen und initialisiert werden.

# Öffentliche Methoden

Die folgenden Methoden unterstützen die öffentliche Schnittstelle des Megawidgets.

*pathName* **cget** *option*
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück.

    *option* bezeichnet hier eine zusammengesetzte Konfigurationsoption des Megawidgets. Einzelne Komponenten nehmen ihre eigenen Konfigurationsoptionen in die zusammengesetzte Liste auf, wenn sie mit der Methode „**itk\_component add**“ registriert werden.

*pathName* **component** ?*name*? ?*command arg arg ...*?
: Dient dazu, Komponenten-Widgets innerhalb eines Megawidgets abzufragen oder anzusprechen. Ohne Argumente gibt die Methode eine Liste der symbolischen Namen der Komponenten-Widgets zurück, die im aktuellen Geltungsbereich zugänglich sind. Der symbolische Name einer Komponente wird festgelegt, wenn sie mit der Methode „**itk\_component add**“ registriert wird. Komponenten-Widgets gehorchen jeder Zugriffseinschränkung public/protected/private, die beim Erzeugen der Komponente gilt.

    Wenn ein symbolischer *name* angegeben ist, gibt diese Methode den Fensterpfadnamen dieser Komponente zurück.

    Andernfalls werden *command* und die übrigen Argumente *arg* als Methode der Komponente mit dem symbolischen Namen *name* aufgerufen. Das bietet einen festgelegten Weg, interne Komponenten anzusprechen, ohne sich auf bestimmte Fensterpfadnamen zu stützen, die eigentlich Einzelheiten der Umsetzung sind.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle für *pathName* verfügbaren Optionen beschreibt (das Format dieser Liste steht bei **Tk\_ConfigureInfo**). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine genannte Option beschreibt (diese Liste ist mit der entsprechenden Teilliste des Wertes identisch, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare *option-value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück.

    Die *options* bezeichnen hier zusammengesetzte Konfigurationsoptionen des Megawidgets. Einzelne Komponenten nehmen ihre eigenen Konfigurationsoptionen in die zusammengesetzte Liste auf, wenn sie mit der Methode „**itk\_component add**“ registriert werden.


# Geschützte Methoden

Die folgenden Methoden werden in abgeleiteten Klassen als Teil der Umsetzung eines Megawidgets verwendet.

**itk\_component add** ?**-protected**? ?**-private**? ?**--**? *name createCmds* ?*optionCmds*?
: Erzeugt ein Komponenten-Widget, indem das Argument *createCmds* ausgeführt wird, und registriert die neue Komponente unter dem symbolischen Namen *name*. Die Optionen **-protected** und **-private** halten die Komponente vor der Außenwelt verborgen. Diese Optionen wirken auf die Sichtbarkeit einer Komponente ähnlich wie auf Klassenmitglieder.

    Der Code *createCmds* kann beliebig viele Befehle enthalten, muss aber den Fensterpfadnamen des neuen Komponenten-Widgets zurückgeben.

    Das Skript *optionCmds* enthält Befehle, die beschreiben, wie die Konfigurationsoptionen der neuen Komponente in die zusammengesetzte Liste des Megawidgets eingehen sollen. Es kann jeden der folgenden Befehle enthalten:

    **ignore** *option* ?*option option ...*?
    : Entfernt eine oder mehrere Konfigurationsoptionen aus der zusammengesetzten Liste. Alle Optionen werden voreingestellt ignoriert, der Befehl **ignore** hebt also nur die Wirkung eines vorherigen Befehls **keep** oder **rename** auf. Das ist zum Beispiel nützlich, wenn einige der vom Befehl [usual] hinzugefügten Optionen auf eine bestimmte Komponente nicht zutreffen sollen und ignoriert werden müssen.

    **keep** *option* ?*option option ...*?
    : Nimmt eine oder mehrere Konfigurationsoptionen in die zusammengesetzte Liste auf und behält den Namen bei. Immer wenn die Option des Megawidgets konfiguriert wird, wird der neue Wert auch auf die aktuelle Komponente angewendet. Optionen wie „-background“ und „-cursor“ stehen häufig auf der Liste **keep**.

    **rename** *option switchName resourceName resourceClass*
    : Nimmt die Konfigurationsoption unter einem anderen Namen in die zusammengesetzte Liste auf. Die Option heißt auf der zusammengesetzten Liste *switchName*. Sie lässt sich außerdem ändern, indem Werte für *resourceName* und *resourceClass* in der X11-Ressourcendatenbank gesetzt werden. Die Option „-highlightbackground“ wird häufig in „-background“ umbenannt, damit sich beim Ändern des Hintergrunds des Megawidgets auch der Hintergrund des Fokusrahmens ändert.

    [usual] ?*tag*?
    : Sucht die üblichen Befehle zur Optionsbehandlung für den angegebenen Namen *tag* und führt sie aus. Wenn der *tag* nicht angegeben ist, wird der Name der Widget-Klasse als Name *tag* verwendet. Die üblichen Befehle zur Optionsbehandlung werden über den Befehl [usual] registriert.


    Wenn das Skript *optionCmds* nicht angegeben ist, werden voreingestellt die üblichen Befehle zur Optionsbehandlung verwendet, die der Klasse des Komponenten-Widgets zugeordnet sind.

**itk\_component delete** *name* ?*name name ...*?
: Entfernt das Komponenten-Widget mit dem symbolischen Namen *name* aus dem Megawidget. Das Komponenten-Widget existiert weiter, ist aber nicht mehr als Komponente des Megawidgets zugänglich. Außerdem werden alle der Komponente zugeordneten Optionen aus der zusammengesetzten Optionsliste entfernt.

    Eine Komponente lässt sich mit dem Befehl **destroy** zerstören, genau wie jedes andere Tk-Widget. Komponenten lösen sich beim Zerstören automatisch von ihrem übergeordneten Megawidget, deshalb wird „**itk\_component delete**“ selten verwendet.

**itk\_initialize** ?*option value option value...*?
: *Diese Methode muss im Konstruktor jeder Klasse einer Megawidget-Hierarchie aufgerufen werden.* Sie stellt sicher, dass alle Optionen richtig in die zusammengesetzte Optionsliste eingehen, und gleicht alle Komponenten mit den Anfangswerten der Optionen ab. Sie wird gewöhnlich nahe am Ende des Konstruktors aufgerufen, nachdem alle Komponenten-Widgets hinzugefügt wurden.

    Wenn Paare *option*/*value* angegeben sind, überschreiben sie Einstellungen aus der X11-Ressourcendatenbank. Die Argumente des Konstruktors werden gewöhnlich so an diese Methode weitergereicht:

    ```
    itcl::class MyWidget {
        inherit Widget

        constructor {args} {
            eval itk_initialize $args
        }
    }
    ```

**itk\_option add** *optName* ?*optName optName ...*?
: Fügt der zusammengesetzten Optionsliste eines Megawidgets eine oder mehrere Optionen hinzu. *optName* kann hier eine der folgenden Formen haben:

    *component*.*option*
    : Greift auf eine *option* zu, die zu einer Komponente mit dem symbolischen Namen *component* gehört. Der Name der *option* wird ohne führendes Zeichen „**-**“ angegeben.

    *className*::*option*
    : Greift auf eine *option* zu, die der Befehl „**itk\_option define**“ in der Klasse *className* definiert. Der Name der *option* wird ohne führendes Zeichen „**-**“ angegeben.



Optionen gehen gewöhnlich in die zusammengesetzte Optionsliste ein, wenn ein Komponenten-Widget zuerst erzeugt wird. Mit dieser Methode lassen sich Optionen zu einem späteren Zeitpunkt hinzufügen. Die Basisklassen [Widget] und [Toplevel] behalten zum Beispiel für ihre Komponente „hull“ nur das Nötigste: -background und -cursor. Eine abgeleitete Klasse kann diese Entscheidung aufheben und zusätzlich Optionen hinzufügen, die den Rahmen der Komponente „hull“ steuern:

```
itcl::class MyWidget {
    inherit Widget

    constructor {args} {
        itk_option add hull.borderwidth hull.relief

        itk_component add label {
            label $itk_interior.l1 -text "Hello World!"
        }
        pack $itk_component(label)

        eval itk_initialize $args
    }
}
```

**itk\_option define** *switchName resourceName resourceClass init* ?*config*?
: Dieser Befehl wird auf der Ebene der Klassendefinition verwendet, um eine synthetische Option des Megawidgets zu definieren. Innerhalb der Methoden **configure** und **cget** wird diese Option über *switchName* angesprochen, das mit einem Zeichen „**-**“ beginnen muss. Sie lässt sich außerdem ändern, indem Werte für *resourceName* und *resourceClass* in der X11-Ressourcendatenbank gesetzt werden. Die Zeichenkette *init* dient als letzter Ausweg, die Option zu initialisieren, wenn kein anderer Wert aus einer vorhandenen Option verwendet oder aus der X11-Ressourcendatenbank abgefragt werden kann. Wenn Code *config* angegeben ist, wird er ausgeführt, sobald die Option über die Methode **configure** geändert wird. Der Code *config* lässt sich auch außerhalb der Klassendefinition über den Befehl **configbody** angeben.

    Im folgenden Beispiel wird der Klasse eine synthetische Option „-background“ hinzugefügt, sodass bei jeder Änderung des Hintergrunds der neue Wert auf die Standardausgabe gemeldet wird. Diese synthetische Option wird mit den übrigen Optionen „-background“ zusammengeführt, die von Komponenten-Widgets behalten wurden:

    ```
    itcl::class MyWidget {
        inherit Widget
        constructor {args} {
            itk_component add label {
                label $itk_interior.l1 -text "Hello World!"
            }
            pack $itk_component(label)

            eval itk_initialize $args
        }
        itk_option define -background background Background #d9d9d9 {
            puts "new background: $itk_option(-background)"
        }
    }
    ```

**itk\_option remove** *optName* ?*optName optName ...*?
: Entfernt eine oder mehrere Optionen aus der zusammengesetzten Optionsliste eines Megawidgets. *optName* kann eine der Formen haben, die oben beim Befehl „**itk\_option add**“ beschrieben sind.

    Optionen gehen gewöhnlich in die zusammengesetzte Optionsliste ein, wenn ein Komponenten-Widget zuerst erzeugt wird. Mit dieser Methode lassen sich Optionen zu einem späteren Zeitpunkt entfernen. Eine abgeleitete Klasse kann zum Beispiel eine in einer Basisklasse definierte Option aufheben, indem sie die Option entfernt und neu definiert:

    ```
    itcl::class Base {
        inherit itk::Widget
        constructor {args} {
            eval itk_initialize $args
        }

        itk_option define -foo foo Foo "" {
            puts "Base: $itk_option(-foo)"
        }
    }

    itcl::class Derived {
        inherit Base

        constructor {args} {
            itk_option remove Base::foo
            eval itk_initialize $args
        }
        itk_option define -foo foo Foo "" {
            puts "Derived: $itk_option(-foo)"
        }
    }
    ```

    Ohne den Befehl „**itk\_option remove**“ würden die Codefragmente beider Optionen „-foo“ jedes Mal ausgeführt, wenn die zusammengesetzte Option „-foo“ konfiguriert wird. Im Beispiel oben wird die Option **Base::foo** in allen Widgets der Klasse Derived unterdrückt, sodass nur die Option **Derived::foo** bleibt.


# Geschützte Variablen

Abgeleitete Klassen finden in den folgenden geschützten Variablen nützliche Angaben.

itk\_component(*name*)
: Das Array „itk\_component“ gibt den echten Fensterpfadnamen eines Komponenten-Widgets mit dem symbolischen Namen *name* zurück. Dieselbe Angabe lässt sich mit der Methode **component** abfragen, der Zugriff auf dieses Array ist aber schneller und bequemer.

itk\_interior
: Diese Variable enthält den Namen des Fensters, das als Elternfenster für interne Komponenten dient. Sie wird mit dem Namen der Komponente „hull“ initialisiert, den die Klassen [Widget] und [Toplevel] bereitstellen. Abgeleitete Klassen können die Anfangseinstellung überschreiben und auf ein anderes inneres Fenster zeigen, das für weiter abgeleitete Klassen verwendet werden soll.

itk\_option(*option*)
: Das Array „itk\_option“ gibt den aktuellen Optionswert der zusammengesetzten Widget-Option namens *option* zurück. Der Name *option* soll hier ein führendes Zeichen „**-**“ enthalten. Dieselbe Angabe lässt sich mit der Methode **cget** abfragen, der Zugriff auf dieses Array ist aber schneller und bequemer.


[Toplevel]: Toplevel.md
[usual]: usual.md
[Widget]: Widget.md
