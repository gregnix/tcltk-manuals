---
CommandName: wish
title: wish
ManualSection: 1
Version: 8.0
TclPart: Tk
TclDescription: Tk Applications
Links:
 - tclsh(1)
 - toplevel(n)
 - Tk_Main(3)
 - Tk_MainLoop(3)
 - Tk_MainWindow(3)
Keywords:
 - application
 - argument
 - interpreter
 - prompt
 - script file
 - shell
 - toolkit
 - toplevel
Copyright:
 - Copyright (c) 1991-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

wish - Einfache Fenster-Shell

# Übersicht

::: {.synopsis} :::
[wish]{.cmd} [options]{.optlit} [fileName arg]{.optdot}
:::

# Optionen

**-encoding** *name*
: Legt die Kodierung des in *fileName* gespeicherten Textes fest. Die Option wird nur vor dem Argument *fileName* erkannt.

**-colormap** *new*
: Legt fest, dass das Fenster eine eigene private Farbkarte erhält statt der Standardfarbkarte des Bildschirms.

**-display** *display*
: Display (und Bildschirm), auf dem das Fenster erscheint.

**-geometry** *geometry*
: Anfangsgeometrie des Fensters. Ist die Option gesetzt, landet ihr Wert in der globalen Variable [geometry][tkvars] des Tcl-Interpreters der Anwendung.

**-name** *name*
: *name* wird der Fenstertitel und der Name des Interpreters für [send]-Befehle.

**-sync**
: Alle Befehle an den X-Server laufen synchron, Fehler werden sofort gemeldet. Die Ausführung wird deutlich langsamer, das hilft beim Debuggen.

**-use** *id*
: Legt fest, dass das Hauptfenster der Anwendung in das Fenster mit der Kennung *id* eingebettet wird und nicht als eigenständiges Toplevel-Fenster entsteht. *Id* hat dieselbe Form wie der Wert der Option **-use** bei Toplevel-Widgets, also die Form, die [winfo id][winfo] liefert. Auf manchen Plattformen funktioniert das nur, wenn *id* einen Tk-[frame] oder ein [toplevel] mit gesetzter Option **-container** bezeichnet.

**-visual** *visual*
: Legt das Visual für das Fenster fest. *Visual* darf jede Form haben, die die Prozedur [Tk\_GetVisual][GetVisual] unterstützt.

**--**
: Alle übrigen Argumente gehen unbearbeitet in die Variable [argv][tclvars] des Skripts. So lässt sich etwa **-name** an das Skript durchreichen, ohne dass **wish** es auswertet.


# Beschreibung

**Wish** besteht aus der Tcl-Befehlssprache, dem Tk-Toolkit und einem Hauptprogramm, das Befehle von der Standardeingabe oder aus einer Datei liest. Es erzeugt ein Hauptfenster und verarbeitet dann Tcl-Befehle. Wird **wish** mit Argumenten aufgerufen, nennen die ersten Argumente ?**-encoding** *name*? ?*fileName*? den Namen einer Skriptdatei und optional die Kodierung der darin gespeicherten Textdaten. Ein Wert für *fileName* wird erkannt, wenn das betreffende Argument nicht mit „-“ beginnt.

Gibt es keine Argumente oder nennen sie kein *fileName*, liest wish Tcl-Befehle interaktiv von der Standardeingabe. Die Verarbeitung läuft, bis alle Fenster gelöscht sind oder die Standardeingabe das Dateiende erreicht. Liegt im Home-Verzeichnis des Benutzers eine Datei „**.wishrc**“, wertet **wish** sie als Tcl-Skript aus, unmittelbar bevor der erste Befehl von der Standardeingabe gelesen wird.

Nennen die Argumente von **wish** ein *fileName*, gilt *fileName* als Name einer Skriptdatei. **Wish** wertet das Skript in *fileName* aus (das in der Regel eine Oberfläche aufbaut) und reagiert danach auf Ereignisse, bis alle Fenster gelöscht sind. Von der Standardeingabe werden keine Befehle gelesen. Eine automatische Auswertung von „**.wishrc**“ findet nicht statt, wenn auf der Befehlszeile von **wish** ein Skriptdateiname steht; die Skriptdatei kann die Datei bei Bedarf mit [source] laden.

Unter Windows unterscheidet sich das Programm **wish***version***.exe** in einem weiteren Punkt von [tclsh]*version***.exe**: es verbindet sich nicht mit einer Windows-Konsole, sondern ist ein Fensterprogramm. Deshalb stellt es zusätzlich seinen eigenen Befehl [console] bereit.

# Verarbeitung der Optionen

**Wish** verarbeitet alle Befehlszeilenoptionen aus der Übersicht [Optionen] selbst. Alle übrigen Befehlszeilenargumente gehen über die später beschriebenen Variablen [argc][tclvars] und [argv][tclvars] an die Anwendung.

# Anwendungsname und Klasse

Der Name der Anwendung, etwa für [send]-Befehle, kommt aus der Option **-name**, falls sie gesetzt ist. Sonst aus *fileName*, falls angegeben, oder aus dem Befehlsnamen, mit dem **wish** aufgerufen wurde. Enthält der Name in den letzten beiden Fällen ein „/“, zählen nur die Zeichen nach dem letzten Schrägstrich als Anwendungsname.

Die Klasse der Anwendung, etwa für Optionen über eine **RESOURCE\_MANAGER**-Eigenschaft oder eine .Xdefaults-Datei, ist derselbe Name mit großem Anfangsbuchstaben.

# Variablen

**Wish** setzt diese globalen Tcl-Variablen:

[argc][tclvars]
: Anzahl der *arg*-Argumente (0, wenn keine), ohne die oben beschriebenen Optionen.

[argv][tclvars]
: Tcl-Liste der *arg*-Argumente, die auf eine Option **--** folgen oder auf keine der unter [Optionen] beschriebenen Optionen passen, in derselben Reihenfolge, oder eine leere Zeichenkette, wenn es keine solchen Argumente gibt.

[argv0][tclvars]
: *fileName*, wenn er angegeben wurde. Sonst der Name, mit dem **wish** aufgerufen wurde.

[geometry][tkvars]
: Ist **-geometry** gesetzt, kopiert **wish** den Wert in diese Variable. Existiert die Variable noch, nachdem *fileName* ausgewertet wurde, setzt **wish** mit [wm geometry][wm] die Geometrie des Hauptfensters auf diesen Wert.

[tcl\_interactive][tclvars]
: 1, wenn **wish** Befehle interaktiv liest (kein *fileName* und die Standardeingabe ist ein terminalartiges Gerät), sonst 0.


# Skriptdateien

Steht in der ersten Zeile eines Tcl-Skripts

```
#!/usr/local/bin/wish
```

lässt sich die Datei direkt aus der Shell aufrufen, sobald sie als ausführbar gekennzeichnet ist. Das setzt voraus, dass **wish** am üblichen Ort /usr/local/bin installiert ist; sonst muss die Zeile angepasst werden. Viele UNIX-Systeme lassen die Zeile **#!** nur etwa 30 Zeichen lang werden. Die ausführbare Datei **wish** muss daher über einen kurzen Dateinamen erreichbar sein.

Besser beginnen Skriptdateien mit diesen drei Zeilen:

```
#!/bin/sh
# the next line restarts using wish \
exec wish "$0" ${1+"$@"}
```

Das hat gegenüber dem vorigen Absatz drei Vorteile. Erstens muss der Ort der **wish**-Binärdatei nicht fest im Skript stehen: sie darf irgendwo im Suchpfad der Shell liegen. Zweitens entfällt die Grenze von etwa 30 Zeichen für den Dateinamen. Drittens funktioniert das auch, wenn **wish** selbst ein Shell-Skript ist (auf manchen Systemen wählt das **wish**-Skript eine von mehreren Binärdateien, um mehrere Architekturen oder Betriebssysteme zu bedienen). Die drei Zeilen lassen sowohl **sh** als auch **wish** das Skript verarbeiten, [exec] führt aber nur **sh** aus. **sh** verarbeitet das Skript zuerst, behandelt die zweite Zeile als Kommentar und führt die dritte aus. [exec] beendet die Verarbeitung durch die Shell und startet **wish**, das das ganze Skript erneut verarbeitet. Beim Start von **wish** gelten alle drei Zeilen als Kommentar, weil der Backslash am Ende der zweiten Zeile die dritte Zeile zum Kommentar der zweiten macht.

Das Ende einer Skriptdatei ist das physische Ende des Mediums oder das Zeichen „\\032“ („\\u001a“, Strg-Z). Steht dieses Zeichen in der Datei, liest **wish** den Text bis unmittelbar vor dieses Zeichen. Eine Anwendung, die das Zeichen in der Datei braucht, kann es als „\\032“, „\\x1a“ oder „\\u001a“ kodieren oder mit Befehlen wie [format] oder [binary] erzeugen.

# Eingabeaufforderung

Interaktives **wish** fordert jeden Befehl mit „**%** “ an. Die Variablen **tcl\_prompt1** und **tcl\_prompt2** ändern die Aufforderung. Existiert **tcl\_prompt1**, muss sie ein Tcl-Skript sein, das die Aufforderung ausgibt; statt selbst eine Aufforderung zu schreiben, wertet **wish** das Skript in **tcl\_prompt1** aus. **tcl\_prompt2** gilt entsprechend, wenn ein Zeilenumbruch kommt, der aktuelle Befehl aber noch nicht vollständig ist. Ist **tcl\_prompt2** nicht gesetzt, gibt es für unvollständige Befehle keine Aufforderung.


[binary]: ../tcl/binary.md
[console]: console.md
[exec]: ../tcl/exec.md
[format]: ../tcl/format.md
[frame]: frame.md
[GetVisual]: ../tk-c/GetVisual.md
[send]: send.md
[source]: ../tcl/source.md
[tclsh]: ../tcl/tclsh.md
[tclvars]: ../tcl/tclvars.md
[tkvars]: tkvars.md
[toplevel]: toplevel.md
[winfo]: winfo.md
[wm]: wm.md
