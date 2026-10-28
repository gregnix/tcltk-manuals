---
CommandName: itclvars
title: itclvars
ManualSection: n
Version: 3.0
TclPart: itcl
TclDescription: "[incr Tcl]"
Keywords:
 - itcl
 - variables
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

itclvars - Variablen, die \[incr\\ Tcl\] verwendet

# Beschreibung

Die folgenden globalen Variablen werden von der Bibliothek **\[incr Tcl\]** automatisch erzeugt und verwaltet. Soweit unten nichts anderes vermerkt ist, sollten anwendungsspezifischer Code und Benutzer diese Variablen gewöhnlich als nur lesbar behandeln.

**itcl::library**
: Wenn ein Interpreter erzeugt wird, initialisiert **\[incr Tcl\]** diese Variable mit dem Namen eines Verzeichnisses, das die Systembibliothek der Skripte von **\[incr Tcl\]** enthält. Der Anfangswert von **itcl::library** wird aus der Umgebungsvariable ITCL\_LIBRARY gesetzt, falls sie existiert, sonst aus einem einkompilierten Wert.

**itcl::patchLevel**
: Wenn ein Interpreter erzeugt wird, initialisiert **\[incr Tcl\]** diese Variable mit dem aktuellen Patch-Stand von **\[incr Tcl\]**. Der Wert „**2.0p1**“ steht zum Beispiel für Version 2.0 von **\[incr Tcl\]** mit dem ersten Satz angewendeter Patches.

**itcl::purist**
: Wenn ein Interpreter erzeugt wird, der Tcl/Tk und die Namespace-Einrichtung von **\[incr Tcl\]** enthält, steuert diese Variable einen Modus der „Rückwärtskompatibilität“ für den Widget-Zugriff.

    Im gewöhnlichen Tcl/Tk gibt es einen einzigen Vorrat von Befehlen, sodass der Zugriffsbefehl eines Widgets derselbe ist wie der Fenstername. Wenn ein Widget jedoch innerhalb eines Namespace erzeugt wird, wird sein Zugriffsbefehl in diesem Namespace installiert und sollte außerhalb des Namespace über einen qualifizierten Namen angesprochen werden. Zum Beispiel

    ```
    namespace foo {
        namespace bar {
            button .b -text "Testing"
        }
    }
    foo::bar::.b configure -background red
    pack .b
    ```

    Der Fenstername "**.b**" wird weiterhin zusammen mit Befehlen wie **pack** und **destroy** verwendet. Der Zugriffsbefehl des Widgets (also der Name, der als *erstes* Argument auf einer Befehlszeile erscheint) muss jedoch genauer sein.

    Mit dem Befehl „**winfo command**“ lässt sich der voll qualifizierte Zugriffsbefehl jedes Widgets abfragen, sodass sich schreiben lässt:

    ```
    [winfo command .b] configure -background red
    ```

    und das ist gute Praxis beim Schreiben von Bibliotheksprozeduren. Zusammen mit dem Befehl **bind** kann das Feld „%q“ anstelle von „%W“ als Zugriffsbefehl verwendet werden:

    ```
    bind Button <Key-Return> {%q flash; %q invoke}
    ```

    Dieses Verhalten ist aus Sicht der Kapselung sinnvoll, verursacht aber Probleme mit vorhandenen Tcl/Tk-Anwendungen. Viele vorhandene Anwendungen sind mit Bindungen geschrieben, die „%W“ verwenden. Viele Bibliotheksprozeduren nehmen an, dass der Fenstername der Zugriffsbefehl ist.

    Die Variable **itcl::purist** steuert einen Modus der Rückwärtskompatibilität. Voreingestellt ist diese Variable „0“, und der Fenstername lässt sich in jedem Kontext als Zugriffsbefehl verwenden. Immer wenn die Prozedur **unknown** auf einen Widgetnamen stößt, verwendet sie einfach „**winfo command**“, um den passenden Befehlsnamen zu ermitteln. Wenn diese Variable auf „1“ gesetzt ist, ist dieser Modus der Rückwärtskompatibilität abgeschaltet. Das ergibt eine bessere Kapselung, die Verwendung des Fensternamens als Zugriffsbefehl kann aber zu Fehlern „invalid command“ führen.

**itcl::version**
: Wenn ein Interpreter erzeugt wird, initialisiert **\[incr Tcl\]** diese Variable mit der Versionsnummer der Form *x.y*. Änderungen an *x* stehen für große Änderungen mit wahrscheinlichen Inkompatibilitäten, Änderungen an *y* stehen für kleine Erweiterungen und Fehlerbehebungen, die die Rückwärtskompatibilität bewahren.
