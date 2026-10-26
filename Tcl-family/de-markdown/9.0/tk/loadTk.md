---
CommandName: Safe Tk
ManualSection: n
Version: 8.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - safe(n)
 - interp(n)
 - library(n)
 - load(n)
 - package(n)
 - source(n)
 - unknown(n)
Keywords:
 - alias
 - auto-loading
 - auto_mkindex
 - load
 - parent interpreter
 - safe interpreter
 - child interpreter
 - source
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# NAME

safe::loadTk - Tk in einen sicheren Interpreter laden

# ÜBERSICHT

::: {.synopsis} :::
[safe::loadTk]{.cmd} [child]{.arg} [-use windowId]{.optarg} [-display displayName]{.optarg} 
:::

# BESCHREIBUNG

Safe Tk baut auf Safe Tcl auf. Safe Tcl erlaubt eingeschränkten und vermittelten Zugriff auf automatisches Laden und auf Pakete für sichere Interpreter. Safe Tk ergänzt die Möglichkeit, den Interpreter für sichere Tk-Operationen einzurichten und Tk in sichere Interpreter zu laden.

Der Befehl **safe::loadTk** initialisiert die nötigen Datenstrukturen im genannten sicheren Interpreter und lädt dann Tk hinein. Der Interpreter muss mit **safe::interpCreate** erzeugt oder mit **safe::interpInit** initialisiert worden sein. Der Befehl gibt den Namen des sicheren Interpreters zurück. Ist **-use** angegeben, enthält das Fenster mit der genannten, systemabhängigen Kennung *windowId* das Fenster „.“ des sicheren Interpreters; jede gültige Kennung ist zulässig, auch eine, die auf ein Fenster einer anderen Anwendung zeigt. Gehört das vorgesehene Fenster zur eigenen Anwendung und ist ein Tk-Fenster, kann statt der Fensterkennung (etwa aus **winfo id** *.x.y*) der Fenstername stehen (etwa **.x.y**). Ohne **-use** wird für das Fenster „.“ des sicheren Interpreters ein neues Toplevel-Fenster erzeugt. Unter X11 legt **-display** ein anderes Display als das voreingestellte fest, wenn das eingebettete Fenster es nutzen soll. Einzelheiten zur Umsetzung stehen im Abschnitt **SICHERHEITSHINWEISE**.

# SICHERHEITSHINWEISE

Die Handbuchseite **safe** zu Tcl beschreibt die grundlegenden Sicherheitsüberlegungen für Safe Tcl.

**safe::loadTk** hängt den Wert von **tk_library** aus dem Eltern-Interpreter an den virtuellen Zugriffspfad des sicheren Interpreters, damit automatisches Laden im sicheren Interpreter funktioniert.

Die Tk-Initialisierung vertraut beim Start nicht mehr dem Zustand des Kind-Interpreters. **safe::loadTk** registriert den Namen des Kindes. Ruft die Tk-Initialisierung (**Tk_SafeInit**) dann **safe::InitTk** des Eltern-Interpreters auf, liefert das das gewünschte Gegenstück zu **argv** (**-use** *windowId*, das passende **-display** und so weiter).

Ohne **-use** wird das neue Toplevel besonders dekoriert, damit der Benutzer stets sieht, dass die Oberfläche von möglicherweise unsicherem Code stammt, und den zugehörigen Interpreter leicht löschen kann.

Unter X11 erzeugen widersprüchliche Angaben von **-use** und **-display** wahrscheinlich einen fatalen X-Fehler.
