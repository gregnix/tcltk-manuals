---
CommandName: tclsh
title: tclsh
ManualSection: 1
Version: unknown
TclPart: Tcl
TclDescription: Tcl Applications
Links:
 - auto_path(n)
 - encoding(n)
 - env(n)
 - fconfigure(n)
Keywords:
 - application
 - argument
 - interpreter
 - prompt
 - script file
 - shell
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

tclsh - Einfache Shell mit Tcl-Interpreter

# Übersicht

::: {.synopsis} :::
[tclsh]{.cmd} [[-encoding]{.lit} [name]{.arg}]{.optarg} [fileName arg arg]{.optdot}
:::

# Beschreibung

**Tclsh** ist eine shell-artige Anwendung, die Tcl-Befehle von der Standardeingabe oder aus einer Datei liest und auswertet. Ohne Argumente läuft sie interaktiv, liest Tcl-Befehle von der Standardeingabe und schreibt Ergebnisse und Fehlermeldungen auf die Standardausgabe. Sie läuft, bis der Befehl [exit] aufgerufen wird oder die Standardeingabe das Dateiende erreicht. Liegt im Home-Verzeichnis des Benutzers eine Datei **.tclshrc** (unter Windows **tclshrc.tcl**), wertet interaktives **tclsh** diese Datei als Tcl-Skript aus, unmittelbar bevor der erste Befehl von der Standardeingabe gelesen wird.

# Skriptdateien

Wird **tclsh** mit Argumenten aufgerufen, nennen die ersten Argumente den Namen einer Skriptdatei und optional die Kodierung der darin gespeicherten Textdaten. Weitere Argumente stehen dem Skript als Variablen zur Verfügung (siehe unten). Statt von der Standardeingabe liest **tclsh** die Tcl-Befehle aus der genannten Datei und beendet sich an ihrem Ende. Das Ende der Datei ist das physische Ende des Mediums oder das Zeichen „\\032“ („\\u001a“, Strg-Z). Steht dieses Zeichen in der Datei, liest **tclsh** den Text bis unmittelbar vor dieses Zeichen. Eine Anwendung, die das Zeichen in der Datei braucht, kann es gefahrlos als „\\032“, „\\x1A“ oder „\\u001a“ kodieren oder mit Befehlen wie [format] oder [binary] erzeugen. Eine automatische Auswertung von **.tclshrc** findet nicht statt, wenn auf der Befehlszeile von **tclsh** ein Skriptdateiname steht; die Skriptdatei kann die Datei bei Bedarf mit [source] laden.

Steht in der ersten Zeile eines Tcl-Skripts

```
#!/usr/local/bin/tclsh
```

lässt sich die Datei direkt aus der Shell aufrufen, sobald sie als ausführbar gekennzeichnet ist. Das setzt voraus, dass **tclsh** am üblichen Ort /usr/local/bin installiert ist; sonst muss die Zeile angepasst werden. Viele UNIX-Systeme lassen die Zeile **#!** nur etwa 30 Zeichen lang werden. Die ausführbare Datei **tclsh** muss daher über einen kurzen Dateinamen erreichbar sein.

Besser beginnen Skriptdateien mit diesen drei Zeilen:

```
#!/bin/sh
# the next line restarts using tclsh \
exec tclsh "$0" ${1+"$@"}
```

Das hat gegenüber dem vorigen Absatz drei Vorteile. Erstens muss der Ort der **tclsh**-Binärdatei nicht fest im Skript stehen: sie darf irgendwo im Suchpfad der Shell liegen. Zweitens entfällt die Grenze von etwa 30 Zeichen für den Dateinamen. Drittens funktioniert das auch, wenn **tclsh** selbst ein Shell-Skript ist (auf manchen Systemen wählt das **tclsh**-Skript eine von mehreren Binärdateien, um mehrere Architekturen oder Betriebssysteme zu bedienen). Die drei Zeilen lassen sowohl **sh** als auch **tclsh** das Skript verarbeiten, [exec] führt aber nur **sh** aus. **sh** verarbeitet das Skript zuerst, behandelt die zweite Zeile als Kommentar und führt die dritte aus. [exec] beendet die Verarbeitung durch die Shell und startet **tclsh**, das das ganze Skript erneut verarbeitet. Beim Start von **tclsh** gelten alle drei Zeilen als Kommentar, weil der Backslash am Ende der zweiten Zeile die dritte Zeile zum Kommentar der zweiten macht.

Häufig wird tclsh mit der Versionsnummer im Namen installiert. Das erlaubt mehrere Tcl-Versionen auf demselben System, macht es aber schwerer, Skripte zu schreiben, die über verschiedene Tcl-Versionen einheitlich starten.

# Variablen

**Tclsh** setzt zusätzlich zu den Variablen der Tcl-Bibliothek (etwa [env][tclvars], das Umgebungsvariablen wie **PATH** nach Tcl abbildet) diese globalen Tcl-Variablen:

[argc][tclvars]
: Anzahl der *arg*-Argumente (0, wenn keine), ohne den Namen der Skriptdatei.

[argv][tclvars]
: Tcl-Liste der *arg*-Argumente in derselben Reihenfolge, oder eine leere Zeichenkette, wenn keine *arg*-Argumente da sind.

[argv0][tclvars]
: *fileName*, wenn er angegeben wurde. Sonst der Name, mit dem **tclsh** aufgerufen wurde.

[tcl\_interactive][tclvars]
: 1, wenn **tclsh** interaktiv läuft (kein *fileName* und die Standardeingabe ist ein terminalartiges Gerät), sonst 0.


# Eingabeaufforderung

Interaktives **tclsh** fordert jeden Befehl mit „**%** “ an. Die globalen Variablen **tcl\_prompt1** und **tcl\_prompt2** ändern die Aufforderung. Existiert **tcl\_prompt1**, muss sie ein Tcl-Skript sein, das die Aufforderung ausgibt; statt selbst eine Aufforderung zu schreiben, wertet **tclsh** das Skript in **tcl\_prompt1** aus. **tcl\_prompt2** gilt entsprechend, wenn ein Zeilenumbruch kommt, der aktuelle Befehl aber noch nicht vollständig ist. Ist **tcl\_prompt2** nicht gesetzt, gibt es für unvollständige Befehle keine Aufforderung.

# Standardkanäle

Weitere Erläuterungen zum Standardkanal stehen bei [Tcl\_StandardChannels][StdChannels].


[binary]: binary.md
[exec]: exec.md
[exit]: exit.md
[format]: format.md
[source]: source.md
[StdChannels]: ../tcl-c/StdChannels.md
[tclvars]: tclvars.md
