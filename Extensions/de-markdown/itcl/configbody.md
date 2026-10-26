---
CommandName: configbody
ManualSection: n
Version: 3.0
TclPart: itcl
TclDescription: "[incr\\ Tcl]"
Keywords:
 - class
 - object
 - variable
 - configure
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# NAME

itcl::configbody - den „config“-Code einer öffentlichen Variablen ändern

# ÜBERSICHT

::: {.synopsis} :::
[itcl::configbody]{.cmd} [className::varName]{.arg} [body]{.arg} 
:::

# BESCHREIBUNG

Der Befehl **configbody** wird außerhalb einer Klassendefinition von **\[incr**\\ **Tcl\]** verwendet, um den Konfigurationscode zu definieren oder neu zu definieren, der einer öffentlichen Variablen zugeordnet ist. Öffentliche Variablen wirken wie Konfigurationsoptionen eines Objekts. Sie lassen sich außerhalb des Klassengeltungsbereichs mit der eingebauten Methode **configure** ändern. Jede Variable kann ein Stück „config“-Code haben, der automatisch ausgeführt wird, wenn die Variable konfiguriert wird. Mit dem Befehl **configbody** lässt sich dieser Coderumpf definieren oder neu definieren.

Wie der Befehl **body** erlaubt diese Einrichtung einer Klassendefinition getrennte Teile für Schnittstelle und Umsetzung. Der Teil der Schnittstelle ist ein Befehl **class** mit Deklarationen für methods, procs, Instanzvariablen und common-Variablen. Der Teil der Umsetzung ist eine Folge der Befehle **body** und **configbody**. Wenn der Teil der Umsetzung in einer eigenen Datei liegt, lässt sie sich immer wieder einlesen, während Fehler behoben werden, um die interaktive Entwicklung zu unterstützen. Im Modus „tcl“ des Editors **emacs** können Schnittstelle und Umsetzung in derselben Datei liegen; während Fehler behoben werden, lassen sich einzelne Rümpfe markieren und an die Testanwendung schicken.

Der Name „*className*__::__*varName*“ bezeichnet die öffentliche Variable, die aktualisiert wird. Wenn die Zeichenkette *body* mit „**@**“ beginnt, wird sie als symbolischer Name einer C-Prozedur behandelt. Sonst wird sie als Tcl-Befehlsskript behandelt.

Symbolische Namen für C-Prozeduren werden festgelegt, indem Prozeduren über **Itcl_RegisterObjC()** registriert werden. Das geschieht gewöhnlich in der Prozedur **Tcl_AppInit()**, die automatisch aufgerufen wird, wenn der Interpreter startet. Im folgenden Beispiel wird die Prozedur \\ffCMy_FooObjCmd() unter dem symbolischen Namen „foo“ registriert. Im Befehl **configbody** lässt sich diese Prozedur als "\\ffC@foo" ansprechen.

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

Im folgenden Beispiel wird eine Klasse „File“ definiert, die offene Dateien darstellt. Immer wenn die Option „-name“ konfiguriert wird, wird die vorhandene Datei geschlossen und eine neue Datei geöffnet. Der „config“-Code einer öffentlichen Variablen ist optional. Die Option „-access“ hat ihn zum Beispiel nicht.

```
itcl::class File {
    private variable fid ""

    public variable name ""
    public variable access "r"

    constructor {args} {
        eval configure $args
    }
    destructor {
        if {$fid != ""} {
            close $fid
        }
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

itcl::configbody File::name {
    if {$fid != ""} {
        close $fid
    }
    set fid [open $name $access]
}

#
# Die Klasse File in Aktion:
#
File x

x configure -name /etc/passwd
while {![x eof]} {
    puts "=> [x get]"
}
itcl::delete object x
```
