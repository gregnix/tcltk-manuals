---
CommandName: rcs
title: rcs
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: RCS low level utilities
Links:
 - struct
 - textutil
Keywords:
 - CVS
 - RCS
 - RCS patch
 - SCCS
 - diff -n format
 - patching
 - text conversion
 - text differences
Copyright:
 - Copyright (c) 2005, Andreas Kupries <andreas_kupries@users.sourceforge.net>
 - Copyright (c) 2005, Colin McCormack <coldstore@users.sourceforge.net>
---

# Name

rcs – RCS-Dienstprogramme auf niedriger Ebene

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [rcs]{.lit} [0.2]{.optlit}
[::rcs::text2dict]{.cmd} [text]{.arg}
[::rcs::dict2text]{.cmd} [dict]{.arg}
[::rcs::file2dict]{.cmd} [filename]{.arg}
[::rcs::dict2file]{.cmd} [filename]{.arg} [dict]{.arg}
[::rcs::decodeRcsPatch]{.cmd} [text]{.arg}
[::rcs::encodeRcsPatch]{.cmd} [pcmds]{.arg}
[::rcs::applyRcsPatch]{.cmd} [text]{.arg} [pcmds]{.arg}
:::

# Beschreibung

Das *Revision Control System*, kurz *RCS*, ist eine Sammlung von Anwendungen und zugehörigen Datenformaten, die es einem System ermöglichen, die Geschichte der Änderungen an einem Text dauerhaft zu speichern. Es bildet zusammen mit seinem Verwandten SCCS die Grundlage für viele andere Systeme dieser Art, wie beispielsweise *CVS* usw.

Dieses Paket implementiert *kein* RCS.

Es stellt lediglich eine Reihe von Befehlen auf niedriger Ebene bereit, die bei der Implementierung eines beliebigen Versionsverwaltungssystems nützlich sein dürften, nämlich:

1. Die Umwandlung von Texten in Datenstrukturen und zurück. Diese Strukturen erlauben, solche Texte leicht durch *Patches* zu ändern, also durch Folgen von Anweisungen, die einen Text in einen anderen umwandeln.

2. Sowie die Umwandlung eines bestimmten Patch-Formats, der sogenannten *RCS-Patches*, in Datenstrukturen und zurück, die ihre einfache Anwendung auf Texte erlauben.


# Befehle

**::rcs::text2dict** *text*
: Wandelt das Argument *text* in ein Dictionary um, das denselben Text in indexierter Form enthält und darstellt, und gibt dieses Dictionary als Ergebnis zurück. Das Format des Ergebnisses beschreibt der Abschnitt [Datenstruktur Text-Dict]. Dieser Befehl gibt die *kanonische* Darstellung der Eingabe zurück.

**::rcs::dict2text** *dict*
: Dieser Befehl ist die ergänzende Operation zu **::rcs::text2dict**. Er wandelt ein Dictionary in der im Abschnitt [Datenstruktur Text-Dict] beschriebenen Form wieder in einen Text um und gibt diesen Text als Ergebnis zurück. Der Befehl akzeptiert auch nicht-kanonische Darstellungen des Textes als Eingabe.

**::rcs::file2dict** *filename*
: Dieser Befehl entspricht **::rcs::text2dict**, liest den umzuwandelnden Text aber aus der Datei mit dem Pfad *filename*. Die Datei muss vorhanden und lesbar sein.

**::rcs::dict2file** *filename* *dict*
: Dieser Befehl entspricht **::rcs::2dict2text**, speichert den entstehenden Text aber in der Datei mit dem Pfad *filename*. Die Datei wird angelegt, wenn sie noch nicht existiert, und muss beschreibbar sein. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::rcs::decodeRcsPatch** *text*
: Wandelt das Argument *text* in eine Patch-Befehlsliste (PCL) um, wie im Abschnitt [Liste der RCS-Patch-Befehle] beschrieben, und gibt diese Liste als Ergebnis zurück. Der Eingabetext wird im *diff -n format* angenommen, auch als *RCS-Patch* bekannt, wie im Abschnitt [RCS-Patch-Format] beschrieben. Der Befehl ignoriert No-ops in der Eingabe; die entstehende PCL enthält also nur Anweisungen, die etwas bewirken.

**::rcs::encodeRcsPatch** *pcmds*
: Dieser Befehl ist die ergänzende Operation zu **::rcs::decodeRcsPatch**. Er wandelt eine Patch-Befehlsliste (PCL), wie im Abschnitt [Liste der RCS-Patch-Befehle] beschrieben, in einen Text im [RCS-Patch-Format] zurück und gibt diesen Text als Ergebnis zurück.

    Dieser Befehl und **::rcs::decodeRcsPatch** sind nicht genau komplementär, weil letzterer No-ops aus seiner Eingabe entfernt, die der Kodierer nicht wieder in den erzeugten RCS-Patch einsetzen kann. Das Ergebnis eines Dekodier-/Kodierschritts stimmt auf Zeichenebene daher möglicherweise nicht mit der ursprünglichen Eingabe überein, auf der funktionalen Ebene aber schon.

**::rcs::applyRcsPatch** *text* *pcmds*
: Wendet einen Patch in Form einer PCL auf einen als Dictionary gegebenen Text an und gibt den geänderten Text, wieder als Dictionary, als Ergebnis zurück.

    Für tatsächlichen Text wandeln **::rcs::text2dict** (oder ein gleichwertiger Befehl) und **::rcs::decodeRcsPatch** die Eingaben in Datenstrukturen um, die dieser Befehl annimmt. Analog wandelt **::rcs::dict2text** (oder ein gleichwertiger Befehl) das Ergebnis dieses Befehls in tatsächlichen Text um.


# Datenstruktur Text-Dict

Ein Text-Dictionary ist ein Dictionary, dessen Schlüssel ganze Zahlen und dessen Werte die zugehörigen Zeichenketten sind. Die Schlüssel sind die Zeilennummern eines Textes, die Werte der Text der jeweiligen Zeile. Ein Text kann viele Darstellungen als Dictionary haben, weil die Indexwerte für den Wiederaufbau nur richtig geordnet sein müssen; ihre genauen Werte spielen keine Rolle. Ebenso können die Zeichenketten mehrere physische Zeilen umfassen.

Der Text

```
Hello World,
how are you ?
Fine, and you ?
```

kann beispielsweise wie folgt dargestellt werden:

```
{{1 {Hello World,}} {2 {how are you ?}} {3 {Fine, and you ?}}}
```

oder

```
{{5 {Hello World,}} {8 {how are you ?}} {9 {Fine, and you ?}}}
```

oder

```
{{-1 {Hello World,
how are you ?}} {4 {Fine, and you ?}}}
```

Das erste Dictionary stellt die *kanonische* Darstellung des Textes dar, wobei die Zeilennummern bei **1** beginnen, in Schritten von **1** ansteigen und keine Lücken aufweisen, wobei jeder Wert genau einer physischen Zeile entspricht.

Alle Befehle, die aus Text ein Dictionary erzeugen, geben die kanonische Darstellung ihres Eingabetextes zurück. Die Befehle, die ein Dictionary annehmen und Text zurückgeben, akzeptieren in der Regel jede Darstellung, kanonisch oder nicht.

Die Anwendung eines Patches auf ein Text-Dictionary führt in der Regel dazu, dass das Dictionary nicht mehr kanonisch ist.

# RCS-Patch-Format

Ein *Patch* ist im Allgemeinen eine Folge von Anweisungen, wie ein Eingabetext T in einen anderen Text T' umgewandelt wird, und ebenfalls in Textform kodiert.

Das von diesem Paket verstandene Textformat für Patches ist sehr einfach und unter den Namen *RCS-Patch* oder *diff -n format* bekannt.

Patches in diesem Format enthalten lediglich zwei verschiedene Befehle: zum Löschen von altem Text und zum Hinzufügen von neuem Text. Das Ersetzen eines Textes durch einen anderen wird als Kombination aus einer Löschung, gefolgt von einer Hinzufügung, behandelt.

Das Format ist zeilenorientiert, wobei jede Zeile entweder einen Befehl oder Textdaten enthält, die dem vorangehenden Befehl zugeordnet sind. Die erste Zeile eines *RCS-Patches* ist stets eine Befehlszeile.

Die Befehle lauten:

""
: Die Leerzeile ist ein Befehl, der keine Aktion auslöst.

"a**start** **n**"
: Eine Zeile, die mit dem Zeichen **a** beginnt, fügt Text zur Ausgabe hinzu. Darauf folgen **n** Zeilen Textdaten. Beim Anwenden des Patches werden die Daten genau zwischen den Zeilen **start** und **start**+1 eingefügt. Denselben Effekt hat das Anhängen der Daten an den vorhandenen Text der Zeile **start**. Eine nicht vorhandene Zeile **start** wird angelegt.

"d**start** **n**"
: Eine Zeile, die mit dem Zeichen **d** beginnt, löscht Text aus der Ausgabe. Angewendet löscht sie **n** Zeilen Text; die erste gelöschte Zeile hat den Index **start**.


Die Zeilenindizes **start** beziehen sich immer auf den umzuwandelnden Text in seinem ursprünglichen Zustand, ohne die vorhergehenden Änderungen.

Die Anweisungen sind in der Reihenfolge anzuwenden, in der sie im Patch stehen, oder so, dass dasselbe Ergebnis entsteht wie bei der Anwendung in dieser Reihenfolge.

Dies ist das Format der Ergebnisse, die **::rcs::decodeRcsPatch** zurückgibt und die **::rcs::encodeRcsPatch** beziehungsweise **::rcs::appplyRcsPatch** annehmen. Der Dekodierer entfernt jedoch No-op-Befehle, und der Kodierer erzeugt keine No-ops; auf der Textebene sind sie daher nicht vollständig komplementär, nur auf der funktionalen Ebene.

Ein Beispiel für einen RCS-Patch ist

```
d1 2
d4 1
a4 2
The named is the mother of all things.

a11 3
They both may be called deep and profound.
Deeper and more profound,
The door of all subtleties!
```

# Liste der RCS-Patch-Befehle

Patch-Befehlslisten (kurz: PCLs) sind die Datenstrukturen, die der Patch-Dekodierer erzeugt und die der Patch-Kodierer sowie der Befehl zum Anwenden des Patches annehmen. Sie stellen RCS-Patches als Tcl-Datenstrukturen dar.

Eine PCL ist eine Liste, in der jedes Element einen einzelnen Patch-Befehl darstellt, entweder eine Hinzufügung oder eine Löschung. Die Elemente sind selbst Listen, wobei das erste Element den Befehl festlegt und die übrigen Elemente die Argumente des Befehls darstellen.

a
: Dies ist die Anweisung zum Einfügen von Text. Sie hat zwei Argumente: den Index der Zeile, in die der Text eingefügt werden soll, und den einzufügenden Text – in dieser Reihenfolge.

d
: Dies ist die Anweisung zum Löschen von Text. Sie hat zwei Argumente, den Index der Zeile, an der das Löschen beginnt, und die Anzahl der zu löschenden Zeilen, in dieser Reihenfolge.


Dies ist das Format, das der Patch-Dekodierer zurückgibt und das der Patch-Kodierer und der Befehl zum Anwenden als Eingabe annehmen.

Unten steht ein Beispiel für einen Patch-Befehl; es stellt den RCS-Patch aus dem Abschnitt [RCS-Patch-Format] dar.

```
{{d 1 2} {d 4 1} {a 4 {The named is the mother of all things.

}} {a 11 {They both may be called deep and profound.
Deeper and more profound,
The door of all subtleties!}}}
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *rcs* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung

# Copyright

```
Copyright (c) 2005, Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2005, Colin McCormack <coldstore@users.sourceforge.net>
```
