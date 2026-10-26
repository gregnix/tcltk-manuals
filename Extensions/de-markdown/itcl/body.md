---
CommandName: body
ManualSection: n
Version: 3.0
TclPart: itcl
TclDescription: "[incr\\ Tcl]"
Keywords:
 - class
 - object
 - procedure
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# NAME

itcl::body - den Rumpf einer Klassenmethode oder eines Klassen-proc ändern

# ÜBERSICHT

::: {.synopsis} :::
[itcl::body]{.cmd} [className::function]{.arg} [args]{.arg} [body]{.arg} 
:::

# BESCHREIBUNG

Der Befehl **body** wird außerhalb einer Klassendefinition von **\[incr**\\ **Tcl\]** verwendet, um den Rumpf einer Klassenmethode oder eines proc zu definieren oder neu zu definieren. Diese Einrichtung erlaubt einer Klassendefinition getrennte Teile für Schnittstelle und Umsetzung. Der Teil der Schnittstelle ist ein Befehl **class** mit Deklarationen für methods, procs, Instanzvariablen und common-Variablen. Der Teil der Umsetzung ist eine Folge der Befehle **body** und **configbody**. Wenn der Teil der Umsetzung in einer eigenen Datei liegt, lässt sie sich immer wieder einlesen, während Fehler behoben werden, um die interaktive Entwicklung zu unterstützen. Im Modus „tcl“ des Editors **emacs** können Schnittstelle und Umsetzung in derselben Datei liegen; während Fehler behoben werden, lassen sich einzelne Rümpfe markieren und an die Testanwendung schicken.

Der Name „*className*__::__*function*“ bezeichnet die Methode oder das proc, das geändert wird.

Wenn bei der Definition der *function* in der Klassendefinition eine Liste *args* angegeben wurde, muss die Liste *args* des Befehls **body** in der Bedeutung übereinstimmen. Variablennamen dürfen sich ändern, die Argumentlisten müssen aber dieselben Pflichtargumente und dieselben Vorgabewerte für optionale Argumente haben. Das besondere Argument **args** wirkt als Platzhalter, wenn es in der Liste *args* der Klassendefinition steht; es passt auf null oder mehr Argumente beliebigen Typs, wenn der Rumpf neu definiert wird.

Wenn die Zeichenkette *body* mit „**@**“ beginnt, wird sie als symbolischer Name einer C-Prozedur behandelt. Die Liste *args* hat für die C-Prozedur wenig Bedeutung, außer die erwartete Verwendung zu dokumentieren. (Es ist nicht garantiert, dass die C-Prozedur die Argumente auf diese Weise verwendet.) Wenn *body* nicht mit „**@**“ beginnt, wird es als Tcl-Befehlsskript behandelt. Wenn die Funktion aufgerufen wird, werden die Argumente der Befehlszeile mit der Liste *args* abgeglichen, und für jedes Argument werden lokale Variablen erzeugt. Das ist das übliche Verhalten einer Prozedur im Tcl-Stil.

Symbolische Namen für C-Prozeduren werden festgelegt, indem Prozeduren über **Itcl_RegisterObjC()** registriert werden. Das geschieht gewöhnlich in der Prozedur **Tcl_AppInit()**, die automatisch aufgerufen wird, wenn der Interpreter startet. Im folgenden Beispiel wird die Prozedur \\ffCMy_FooObjCmd() unter dem symbolischen Namen „foo“ registriert. Im Befehl **body** lässt sich diese Prozedur als "\\ffC@foo" ansprechen.

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

# BEISPIEL

Im folgenden Beispiel wird eine Klasse „File“ definiert, die offene Dateien darstellt. Die Methodenrümpfe stehen unter der Klassendefinition, über den Befehl **body**. Die Rümpfe von Konstruktor und Destruktor müssen in der Klassendefinition stehen, sie lassen sich aber ebenfalls über den Befehl **body** neu definieren.

```
itcl::class File {
    private variable fid ""
    constructor {name access} {
        set fid [open $name $access]
    }
    destructor {
        close $fid
    }

    method get {}
    method put {line}
    method eof {}
}

itcl::body File::get {} {
    return [gets $fid]
}
itcl::body File::put {line} {
    puts $fid $line
}
itcl::body File::eof {} {
    return [::eof $fid]
}

#
# Die Klasse File in Aktion:
#
File x /etc/passwd "r"
while {![x eof]} {
    puts "=> [x get]"
}
itcl::delete object x
```
