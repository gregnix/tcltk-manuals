---
CommandName: console
title: console
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - destroy(n)
 - fconfigure(n)
 - history(n)
 - interp(n)
 - puts(n)
 - text(n)
 - wm(n)
Keywords:
 - console
 - interpreter
 - window
 - interactive
 - output channels
Copyright:
 - Copyright (c) 2001 Donal K. Fellows
---

# Name

console - Steuert die Konsole auf Systemen ohne echte Konsole

# Übersicht

::: {.synopsis} :::
[console]{.cmd} [subcommand]{.arg} [arg]{.optdot}
:::

# Beschreibung

Das Konsolenfenster ersetzt eine echte Konsole, um Ein- und Ausgabe auf den Standard-I/O-Kanälen auf Plattformen ohne echte Konsole zu ermöglichen. Es ist als separater Interpreter mit geladenem Tk-Toolkit implementiert; die Steuerung erfolgt über den Befehl **console**. Das Verhalten des Konsolenfensters wird vor allem durch den Inhalt der Datei *console.tcl* in der Tk-Bibliothek definiert. Außer bei TkAqua ist dieser Befehl nicht verfügbar, wenn Tk mit „**package require Tk**“ in einen tclsh-Interpreter geladen wird, da dort ein herkömmliches Terminal erwartet wird. Unter TkAqua ist der Befehl deaktiviert, wenn ein Startskript vorliegt und stdin **/dev/null** ist (wie z. B. wenn eine gebündelte Tk-Anwendung vom macOS Launcher gestartet wird). Um den Befehl in diesem Fall zu aktivieren, definieren Sie die Umgebungsvariable **TK\_CONSOLE**. Dies kann durch Anpassen der Info.plist erfolgen: Schlüssel LSEnvironment zum Haupt-dict hinzufügen und als Wert ein dict mit dem Schlüssel **TK\_CONSOLE** setzen.

**console eval** *script*
: Wertet das Argument *script* als Tcl-Skript im Konsolen-Interpreter aus. Auf den normalen Interpreter wird im Konsolen-Interpreter über den Befehl **consoleinterp** zugegriffen.

**console hide**
: Blendet das Konsolenfenster aus. Entspricht genau dem Zurückziehen des Fensters **.** im Konsolen-Interpreter.

**console show**
: Zeigt das Konsolenfenster an. Entspricht genau dem Deiconify des Fensters **.** im Konsolen-Interpreter.

**console title** ?*string*?
: Fragt den Titel des Konsolenfensters ab oder ändert ihn. Ist *string* nicht angegeben, wird der Titel abgefragt; andernfalls auf *string* gesetzt. Entspricht genau dem Befehl [wm title][wm] im Konsolen-Interpreter.


# Zugriff auf den Haupt-Interpreter

Der Befehl **consoleinterp** im Konsolen-Interpreter erlaubt die Auswertung von Skripten im Haupt-Interpreter. Er unterstützt zwei Unterbefehle: **eval** und **record**.

**consoleinterp eval** *script*
: Wertet *script* als Tcl-Skript auf globaler Ebene im Haupt-Interpreter aus.

**consoleinterp record** *script*
: Zeichnet *script* auf und wertet es auf globaler Ebene im Haupt-Interpreter aus, als ob *script* an der Konsole eingegeben worden wäre.


# Zusätzliche Trap-Aufrufe

Im Konsolen-Interpreter gibt es mehrere zusätzliche Befehle, die als Reaktion auf Aktivität im Haupt-Interpreter aufgerufen werden. *Sie sind hier nur der Vollständigkeit halber dokumentiert; sie gehören zur internen Implementierung der Konsole und können ohne Vorwarnung geändert werden.*

Ausgaben des Haupt-Interpreters an die Konsole über die Kanäle stdout und stderr werden durch Aufruf des Befehls **tk::ConsoleOutput** im Konsolen-Interpreter mit zwei Argumenten behandelt. Das erste Argument ist der Name des beschriebenen Kanals, das zweite der String, der in den Kanal geschrieben wird (nach Kodierungs- und Zeilenend-Verarbeitung).

Wenn das Fenster **.** des Haupt-Interpreters zerstört wird, wird der Befehl **tk::ConsoleExit** im Konsolen-Interpreter aufgerufen (sofern der Konsolen-Interpreter nicht bereits selbst gelöscht wurde).

# Standard-Bindings

Das Standardskript erzeugt ein Konsolenfenster (implementiert mit einem Text-Widget) mit folgendem Verhalten:

1. Tab-Taste fügt ein TAB-Zeichen ein (wie durch das Tcl-Escape \\t definiert).

2. Return-Taste übergibt die aktuelle Zeile (wenn sie nach den Regeln von [info complete][info] vollständig ist) zur Auswertung an den Haupt-Interpreter.

3. Delete-Taste löscht den ausgewählten Text (falls vorhanden) oder das Zeichen rechts vom Cursor (wenn nicht am Zeilenende).

4. Backspace-Taste löscht den ausgewählten Text (falls vorhanden) oder das Zeichen links vom Cursor (wenn nicht am Zeilenanfang).

5. Control+A oder Home-Taste setzt den Cursor an den Zeilenanfang (aber nach der Eingabeaufforderung, falls eine auf der Zeile steht).

6. Control+E oder End-Taste setzt den Cursor ans Zeilenende.

7. Control+P oder Pfeil-hoch wählt den vorherigen Eintrag in der Befehlshistorie.

8. Control+N oder Pfeil-runter wählt den nächsten Eintrag in der Befehlshistorie.

9. Control+B oder Pfeil-links bewegt den Cursor ein Zeichen zurück, solange der Cursor nicht bei der Eingabeaufforderung steht.

10. Control+F oder Pfeil-rechts bewegt den Cursor ein Zeichen vorwärts.

11. F9 baut das Konsolenfenster neu auf, indem alle Kinder zerstört und das Tcl-Skript neu geladen wird, das das Konsolenverhalten definiert.


Das übrige Verhalten entspricht einem herkömmlichen Text-Widget, außer dass das Ereignis *<<Cut>>* identisch zu *<<Copy>>* behandelt wird.

# Beispiel

Nicht alle Plattformen haben den Befehl **console**; Debug-Code enthält daher oft folgendes Fragment, damit Ausgabe von [puts] während der Entwicklung sichtbar ist:

```
catch {console show}
```


[info]: ../tcl/info.md
[puts]: ../tcl/puts.md
[wm]: wm.md
