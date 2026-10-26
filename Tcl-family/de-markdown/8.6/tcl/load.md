---
CommandName: load
title: load
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - info sharedlibextension
 - package(n)
 - Tcl_StaticPackage(3)
 - safe(n)
Keywords:
 - binary code
 - dynamic library
 - load
 - safe interpreter
 - shared library
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

load - Lädt Maschinencode und initialisiert neue Befehle

# Übersicht

::: {.synopsis} :::
[load]{.cmd} [-global]{.optlit} [-lazy]{.optlit} [--]{.optlit} [fileName]{.arg}
[load]{.cmd} [-global]{.optlit} [-lazy]{.optlit} [--]{.optlit} [fileName]{.arg} [prefix]{.arg}
[load]{.cmd} [-global]{.optlit} [-lazy]{.optlit} [--]{.optlit} [fileName]{.arg} [prefix]{.arg} [interp]{.arg}
:::

# Beschreibung

Dieser Befehl lädt Binärcode aus einer Datei in den Adressraum der Anwendung und ruft eine Initialisierungsprozedur in der Bibliothek auf, um sie in einen Interpreter einzubinden. *fileName* ist der Name der Datei mit dem Code; die genaue Form variiert von System zu System, auf den meisten Systemen handelt es sich jedoch um eine Shared Library, etwa eine **.so**-Datei unter Solaris oder eine DLL unter Windows. *prefix* wird verwendet, um den Namen einer Initialisierungsprozedur zu berechnen. *interp* ist der Pfadname des Interpreters, in den die Bibliothek geladen werden soll (Details siehe Manpage [interp]); fehlt *interp*, wird standardmäßig der Interpreter verwendet, in dem der Befehl **load** aufgerufen wurde.

Sobald die Datei in den Adressraum der Anwendung geladen wurde, wird im neuen Code eine von zwei Initialisierungsprozeduren aufgerufen. Typischerweise fügt die Initialisierungsprozedur neue Befehle zu einem Tcl-Interpreter hinzu. Der Name der Initialisierungsprozedur wird durch *prefix* und davon abhängig, ob der Zielinterpreter ein Safe-Interpreter ist, bestimmt. Für normale Interpreter hat die Initialisierungsprozedur die Form *pfx***\_Init**, wobei *pfx* wie *prefix* ist, außer dass der erste Buchstabe groß und alle übrigen klein geschrieben werden. Ist *prefix* beispielsweise **foo** oder **FOo**, lautet der Name der Initialisierungsprozedur **Foo\_Init**.

Ist der Zielinterpreter ein Safe-Interpreter, heißt die Initialisierungsprozedur *pfx***\_SafeInit** statt *pfx***\_Init**. Die Funktion *pfx***\_SafeInit** sollte sorgfältig geschrieben werden, damit der Safe-Interpreter nur mit der Teilfunktionalität der Bibliothek initialisiert wird, die für nicht vertrauenswürdigen Code sicher ist. Weitere Informationen zu Safe-Tcl siehe die Manpage [safe].

Die Initialisierungsprozedur muss folgendem Prototyp entsprechen:

```
typedef int Tcl_PackageInitProc(
        Tcl_Interp *interp);
```

Das Argument *interp* bezeichnet den Interpreter, in den die Bibliothek geladen werden soll. Die Initialisierungsprozedur muss [TCL\_OK][catch] oder [TCL\_ERROR][catch] zurückgeben, um anzuzeigen, ob sie erfolgreich abgeschlossen wurde; bei einem Fehler soll sie das Ergebnis des Interpreters auf eine Fehlermeldung setzen. Das Ergebnis des Befehls **load** ist das von der Initialisierungsprozedur zurückgegebene Ergebnis.

Das eigentliche Laden einer Datei erfolgt pro *fileName* in einer Anwendung nur einmal. Wird ein bestimmter *fileName* in mehrere Interpreter geladen, lädt der erste **load** den Code und ruft die Initialisierungsprozedur auf; nachfolgende **load**-Aufrufe rufen die Initialisierungsprozedur auf, ohne den Code erneut zu laden. Bei Tcl-Versionen unter 8.5 ist das Entladen oder erneute Laden einer Bibliothek nicht möglich. Ab Version 8.5 erlaubt der Befehl [unload] das Entladen mit **load** geladener Bibliotheken, sofern diese Tcl-Entlademechanismus unterstützen.

Der Befehl **load** unterstützt auch Bibliotheken, die statisch mit der Anwendung verlinkt sind, wenn diese durch Aufruf von [Tcl\_StaticPackage][StaticPkg] registriert wurden. Ist *fileName* ein leerer String, muss *prefix* angegeben werden.

Fehlt *prefix* oder ist er ein leerer String, versucht Tcl das Präfix zu erraten. Das kann plattformabhängig unterschiedlich erfolgen. Die Standardannahme auf den meisten UNIX-Plattformen nimmt das letzte Element von *fileName*, entfernt die ersten drei Zeichen, falls sie **lib** lauten, und verwendet alle folgenden alphabetischen Zeichen und Unterstriche in Titlecase als Präfix. Beispielsweise verwendet **load libxyz4.2.so** das Präfix **Xyz** und **load bin/last.so {}** das Präfix **Last**.

Ist *fileName* ein leerer String, muss *prefix* angegeben werden. Der Befehl **load** sucht zuerst nach einer statisch geladenen Bibliothek (registriert durch [Tcl\_StaticPackage][StaticPkg]) mit diesem Namen; wird eine gefunden, wird sie verwendet. Andernfalls sucht **load** nach einer dynamisch geladenen Bibliothek mit diesem Namen und verwendet sie, falls vorhanden. Wurden mehrere verschiedene Dateien mit unterschiedlichen Versionen der Bibliothek mit **load** geladen, wählt Tcl die zuerst geladene Datei.

Wird **-global** vor dem Dateinamen angegeben, werden alle Symbole der Shared Library für die globale Nutzung durch andere Bibliotheken exportiert. Die Option **-lazy** verzögert das tatsächliche Laden von Symbolen bis zu deren erster Verwendung. Die Optionen dürfen abgekürzt werden. Die Option **--** markiert das Ende der Optionen und sollte verwendet werden, wenn der Dateiname mit **-** beginnt und ein Präfix für **load** angegeben wird.

Auf Plattformen ohne Unterstützung für **-global** oder **-lazy** existieren die Optionen weiterhin, haben aber keine Wirkung. Die Verwendung von **-global** oder **-lazy** kann später zu Abstürzen der Anwendung führen (bei Symbolkonflikten bzw. fehlenden Symbolen), die während **load** nicht erkannt werden. Verwenden Sie diese Optionen daher nur, wenn Sie wissen, was Sie tun — bei Problemen mit der geladenen Bibliothek erhalten Sie keine aussagekräftige Fehlermeldung.

# Portabilitätsfragen

**Windows**
: Schlägt ein Laden mit der Fehlermeldung „library not found“ fehl, kann auch eine abhängige Bibliothek fehlen. Um abhängige Bibliotheken anzuzeigen, geben Sie in einer DOS-Konsole „dumpbin -imports <dllname>“ ein, um die Importe der Bibliothek zu sehen. Beim Laden einer DLL im aktuellen Verzeichnis ignoriert Windows „./“ als Pfadangabe und verwendet stattdessen eine Suchheuristik. Um das zu vermeiden, laden Sie die DLL mit:

    ```
    load [file join [pwd] mylib.DLL]
    ```


# Bugs

Wird dieselbe Datei mit verschiedenen *fileName*s mit **load** geladen, wird sie mehrfach in den Adressraum des Prozesses geladen. Das Verhalten variiert je nach System (manche Systeme erkennen redundante Ladungen, andere nicht).

# Beispiele

Im Folgenden eine minimale Erweiterung:

```
#include <tcl.h>
#include <stdio.h>
static int fooCmd(void *clientData,
        Tcl_Interp *interp, int objc, Tcl_Obj *const objv[]) {
    printf("called with %d arguments\n", objc);
    return TCL_OK;
}
int Foo_Init(Tcl_Interp *interp) {
    if (Tcl_InitStubs(interp, "8.1", 0) == NULL) {
	return TCL_ERROR;
    }
    printf("creating foo command");
    Tcl_CreateObjCommand(interp, "foo", fooCmd, NULL, NULL);
    return TCL_OK;
}
```

Wird sie als Shared-/Dynamic Library mit passendem Namen gebaut (z. B. **foo.dll** unter Windows, **libfoo.so** unter Solaris und Linux), kann sie in Tcl wie folgt geladen werden:

```
# Erweiterung laden
switch $tcl_platform(platform) {
    windows {
        load [file join [pwd] foo.dll]
    }
    unix {
        load [file join [pwd] libfoo[info sharedlibextension]]
    }
}

# Befehl der Erweiterung ausführen
foo
```


[catch]: catch.md
[interp]: interp.md
[safe]: safe.md
[StaticPkg]: ../tcl-c/StaticPkg.md
[unload]: unload.md
