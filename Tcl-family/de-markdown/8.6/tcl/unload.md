---
CommandName: unload
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - info sharedlibextension
 - load(n)
 - safe(n)
Keywords:
 - binary code
 - unloading
 - safe interpreter
 - shared library
Copyright:
 - Copyright (c) 2003 George Petasis <petasis@iit.demokritos.gr>.
---

# NAME

unload - Entlädt Maschinencode

# ÜBERSICHT

::: {.synopsis} :::
[unload]{.cmd} [switches]{.optarg} [fileName]{.arg} 
[unload]{.cmd} [switches]{.optarg} [fileName]{.arg} [prefix]{.arg} 
[unload]{.cmd} [switches]{.optarg} [fileName]{.arg} [prefix]{.arg} [interp]{.arg} 
:::

# BESCHREIBUNG

Dieser Befehl versucht, Shared Libraries, die zuvor mit **load** geladen wurden, aus dem Adressraum der Anwendung zu entladen. *fileName* ist der Name der Datei mit der zu entladenden Bibliothek; er muss derselbe Dateiname sein, der **load** beim Laden übergeben wurde. Das Argument *prefix* ist das Präfix (wie von **load** ermittelt oder übergeben) und wird verwendet, um den Namen der Entladeprozedur zu berechnen; fehlt es, wird es aus *fileName* auf dieselbe Weise wie bei **load** berechnet. Das Argument *interp* ist der Pfadname des Interpreters, aus dem das Paket entladen werden soll (Details siehe Manpage **interp**); fehlt *interp*, wird standardmäßig der Interpreter verwendet, in dem der Befehl **unload** aufgerufen wurde.

Beginnen die ersten Argumente von **unload** mit **-**, werden sie als Schalter behandelt. Folgende Schalter werden derzeit unterstützt:

**-nocomplain**
: Unterdrückt alle Fehlermeldungen. Mit diesem Schalter meldet **unload** niemals einen Fehler.

**-keeplibrary**
: Verhindert, dass **unload** den Systemaufruf ausführt, der die Bibliothek aus dem Prozess entlädt.

**-\|-**
: Markiert das Ende der Schalter. Das folgende Argument wird als *fileName* behandelt, auch wenn es mit **-** beginnt.


## Entladevorgang

Wird eine Datei mit einer Shared Library über den Befehl **load** geladen, führt Tcl zwei Referenzzähler für die Bibliotheksdatei. Der erste zählt, wie oft die Bibliothek in normale (vertrauenswürdige) Interpreter geladen wurde, der zweite, wie oft sie in Safe-Interpreter geladen wurde. Da eine Datei mit einer Shared Library von Tcl nur einmal geladen werden kann (beim ersten **load**-Aufruf für die Datei), verfolgen diese Zähler, wie viele Interpreter die Bibliothek nutzen. Jeder weitere **load**-Aufruf nach dem ersten erhöht nur den jeweiligen Referenzzähler.

**unload** arbeitet in die entgegengesetzte Richtung. Zunächst prüft **unload**, ob die Bibliothek entladbar ist: eine entladbare Bibliothek exportiert eine spezielle Entladeprozedur. Der Name der Entladeprozedur wird durch *prefix* und davon abhängig, ob der Zielinterpreter ein Safe-Interpreter ist, bestimmt. Für normale Interpreter hat die Initialisierungsprozedur die Form *pfx*__\_Unload__, wobei *pfx* dasselbe wie *prefix* ist, außer dass der erste Buchstabe groß und alle übrigen klein geschrieben werden. Ist *prefix* beispielsweise **foo** oder **FOo**, lautet der Name der Initialisierungsprozedur **Foo_Unload**. Ist der Zielinterpreter ein Safe-Interpreter, lautet der Name der Initialisierungsprozedur *pkg*__\_SafeUnload__ statt *pkg*__\_Unload__.

Stellt **unload** fest, dass eine Bibliothek nicht entladbar ist (oder die Entladefunktionalität bei der Kompilierung deaktiviert wurde), wird ein Fehler zurückgegeben. Ist die Bibliothek entladbar, ruft **unload** die Entladeprozedur auf. Gibt die Entladeprozedur **TCL_OK** zurück, setzt **unload** fort und verringert den jeweiligen Referenzzähler (je nach Zielinterpreter-Typ). Haben beide Referenzzähler 0 erreicht, wird die Bibliothek vom Prozess getrennt.

## Prototyp der Entlade-Hook-Funktion

Die Entladeprozedur muss folgendem Prototyp entsprechen:

```
typedef int Tcl_PackageUnloadProc(
        Tcl_Interp *interp,
        int flags);
```

Das Argument *interp* bezeichnet den Interpreter, aus dem die Bibliothek entladen werden soll. Die Entladeprozedur muss **TCL_OK** oder **TCL_ERROR** zurückgeben, um anzuzeigen, ob sie erfolgreich abgeschlossen wurde; bei einem Fehler soll sie das Ergebnis des Interpreters auf eine Fehlermeldung setzen. Das Ergebnis des Befehls **unload** ist dann das von der Entladeprozedur zurückgegebene Ergebnis.

Das Argument *flags* kann entweder **TCL_UNLOAD_DETACH_FROM_INTERPRETER** oder **TCL_UNLOAD_DETACH_FROM_PROCESS** sein. Bleibt die Bibliothek nach Rückkehr der Entladeprozedur am Prozess hängen (weil sie von anderen Interpretern genutzt wird), ist **TCL_UNLOAD_DETACH_FROM_INTERPRETER** gesetzt. Wird die Bibliothek jedoch nur vom Zielinterpreter genutzt und beim Rückkehren der Entladeprozedur vom Prozess getrennt, ist *flags* auf **TCL_UNLOAD_DETACH_FROM_PROCESS** gesetzt.

## Hinweise

Der Befehl **unload** kann Bibliotheken nicht entladen, die statisch mit der Anwendung verlinkt sind. Ist *fileName* eine leere Zeichenkette, muss das Argument *prefix* angegeben werden.

Fehlt *prefix* oder ist es eine leere Zeichenkette, versucht Tcl das Präfix zu erraten; das kann je nach Plattform unterschiedlich erfolgen. Die Standardannahme auf den meisten UNIX-Plattformen nimmt das letzte Element von *fileName*, entfernt die ersten drei Zeichen, falls sie **lib** lauten, und verwendet alle folgenden alphabetischen Zeichen und Unterstriche, in Titlecase konvertiert, als Präfix. Beispielsweise verwendet **unload libxyz4.2.so** das Präfix **Xyz** und **unload bin/last.so {}** das Präfix **Last**.

# PORTABILITÄTSFRAGEN

**Unix**
: Nicht alle Unix-Betriebssysteme unterstützen das Entladen von Bibliotheken. Unter einem solchen System gibt **unload** einen Fehler zurück (sofern **-nocomplain** nicht angegeben wurde).


# BUGS

Wird dieselbe Datei mit verschiedenen *fileName*s mit **load** geladen, wird sie mehrfach in den Adressraum des Prozesses geladen. Das Verhalten variiert je nach System (manche Systeme erkennen redundante Ladungen, andere nicht). Wurde eine Bibliothek vom Betriebssystem still entladen (und Tcl hält sie daher noch für geladen), kann **unload** auf einer solchen Bibliothek gefährlich sein (die Bibliothek wird vollständig vom Prozess getrennt, während einige Interpreter sie weiter nutzen).

# BEISPIELE

Wurde ein entladbares Modul in der Datei **foobar.dll** unter Windows so mit **load** geladen:

```
load c:/some/dir/foobar.dll
```

wird es so entladen:

```
unload c:/some/dir/foobar.dll
```

Damit kann ein C-Code-Modul vorübergehend in ein lang laufendes Tcl-Programm eingebunden und später wieder entfernt werden (weil es nicht mehr benötigt wird oder weil eine neue Version installiert wird), ohne den gesamten Tcl-Prozess beenden zu müssen.
