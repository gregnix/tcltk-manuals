---
CommandName: option
title: option
ManualSection: n
Version: unknown
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - options(n)
 - wish(1)
Keywords:
 - database
 - option
 - priority
 - retrieve
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

option - Fensteroptionen zur/von der Optionsdatenbank hinzufügen/abfragen

# Übersicht

::: {.synopsis} :::
[option]{.cmd} [add]{.sub} [pattern]{.arg} [value]{.arg} [priority]{.optarg}
[option]{.cmd} [clear]{.sub}
[option]{.cmd} [get]{.sub} [window]{.arg} [name]{.arg} [class]{.arg}
[option]{.cmd} [readfile]{.sub} [fileName]{.arg} [priority]{.optarg}
:::

# Beschreibung

Der Befehl **option** ermöglicht es, Einträge zur Tk-Optionsdatenbank hinzuzufügen oder Optionen aus der Datenbank abzufragen. Die Form **add** des Befehls fügt der Datenbank eine neue Option hinzu. *Pattern* enthält die anzugebende Option und besteht aus Namen und/oder Klassen, getrennt durch Sternchen oder Punkte, im üblichen X-Format (siehe [Musterformat]). *Value* enthält eine Textzeichenkette, die mit *pattern* verknüpft wird; dies ist der Wert, der bei Aufrufen von [Tk\_GetOption][GetOption] oder durch Aufrufe des Befehls **option get** zurückgegeben wird. Wenn *priority* angegeben ist, gibt sie die Prioritätsstufe für diese Option an (siehe unten für zulässige Werte); der Standardwert ist **interactive**. Dieser Befehl gibt immer einen leeren String zurück.

Der Befehl **option clear** leert die Optionsdatenbank. Standardoptionen (aus der Eigenschaft **RESOURCE\_MANAGER** oder der Datei **.Xdefaults**) werden automatisch neu geladen, sobald das nächste Mal eine Option zur Datenbank hinzugefügt oder daraus entfernt wird. Dieser Befehl gibt immer einen leeren String zurück.

Der Befehl **option get** gibt den Wert der für *window* unter *name* und *class* angegebenen Option zurück. Wenn mehrere Einträge in der Optionsdatenbank zu *window*, *name* und *class* passen, gibt der Befehl denjenigen zurück, der mit der höchsten *priority*-Stufe erstellt wurde. Wenn es mehrere passende Einträge auf derselben Prioritätsstufe gibt, gibt er denjenigen zurück, der zuletzt in die Optionsdatenbank eingetragen wurde. Wenn es keine passenden Einträge gibt, wird der leere String zurückgegeben.

Die Form **readfile** des Befehls liest *fileName*, das das Standardformat für eine X-Ressourcendatenbank wie **.Xdefaults** haben sollte, und fügt alle in dieser Datei angegebenen Optionen zur Optionsdatenbank hinzu. Wenn *priority* angegeben ist, gibt sie die Prioritätsstufe an, mit der die Optionen eingetragen werden; *priority* hat standardmäßig den Wert **interactive**.

Die Datei wird über einen Kanal gelesen, der in der Kodierung „utf-8" ist; ungültige Bytefolgen werden automatisch in gültige umgewandelt. Das bedeutet, dass Kodierungen wie ISO 8859-1 oder cp1252 mit hoher Wahrscheinlichkeit ebenfalls funktionieren, dies kann jedoch nicht garantiert werden. Dies kann nicht geändert werden; das Setzen von \[encoding system\] hat keine Wirkung.

Die *priority*-Argumente des Befehls **option** werden normalerweise symbolisch mit einem der folgenden Werte angegeben:

**widgetDefault**
: Stufe 20. Wird für Standardwerte verwendet, die fest in Widgets codiert sind.

**startupFile**
: Stufe 40. Wird für Optionen verwendet, die in anwendungsspezifischen Startdateien angegeben sind.

**userDefault**
: Stufe 60. Wird für Optionen verwendet, die in benutzerspezifischen Standarddateien angegeben sind, wie **.Xdefaults**, in den X-Server geladene Ressourcendatenbanken oder benutzerspezifische Startdateien.

**interactive**
: Stufe 80. Wird für Optionen verwendet, die interaktiv angegeben werden, nachdem die Anwendung gestartet wurde. Wenn *priority* nicht angegeben ist, ist dies der Standardwert.


Jedes der obigen Schlüsselwörter darf abgekürzt werden. Zusätzlich können Prioritäten numerisch mit Ganzzahlen zwischen 0 und 100 (einschließlich) angegeben werden. Die numerische Form ist wahrscheinlich eine schlechte Idee, außer für neue Prioritätsstufen, die nicht zu den oben genannten gehören.

# Musterformat

Muster bestehen aus einer Folge von Wörtern, getrennt durch entweder Punkte „." oder Sternchen „\*". Das gesamte Muster kann optional auch von einem Sternchen vorangestellt werden.

Jedes Wort im Muster beginnt üblicherweise entweder mit einem Großbuchstaben (in diesem Fall bezeichnet es die Klasse eines Widgets oder einer Option) oder mit einem anderen Zeichen, wenn es den Namen eines Widgets oder einer Option bezeichnet. Das letzte Wort im Muster gibt immer die Option an; die vorhergehenden schränken ein, in welchen Widgets nach dieser Option gesucht wird.

Wenn zwei Wörter durch einen Punkt getrennt sind, muss das letztere Widget ein direktes Kind des ersteren sein (oder die Option muss nur für die angegebenen Widgets gelten). Wenn zwei Wörter durch ein Sternchen getrennt sind, kann zwischen den beiden Widgets eine beliebige Tiefe liegen (und die Option gilt für alle Widgets, die Kinder des ersteren Widgets sind).

Wenn dem gesamten Muster ein Sternchen vorangestellt ist, gilt das gesamte Muster überall dort in der gesamten Widget-Hierarchie, wo es passt. Andernfalls wird das erste Wort des Musters mit dem Namen und der Klasse des „**.**"-[toplevel] abgeglichen, die üblicherweise durch Optionen zu [wish] gesetzt werden.

# Beispiele

Weisen Sie jedem Button in der Anwendung roten Text zu, sofern nicht ausdrücklich überschrieben, indem Sie **foreground** für die Klasse **Button** setzen (beachten Sie, dass die Option auf einigen Plattformen ignoriert wird):

```
option add *Button.foreground red startupFile
```

Ermöglichen Sie Benutzern, das Verhalten in einem Entry-Widget beim Drücken der Return-Taste zu steuern, indem Sie ein Skript in der Optionsdatenbank angeben, und fügen Sie eine Standardoption hinzu, die die Glocke läutet:

```
entry .e
bind .e <Return> [option get .e returnCommand Command]
option add *.e.returnCommand bell widgetDefault
```


[GetOption]: ../tk-c/GetOption.md
[toplevel]: toplevel.md
[wish]: wish.md
