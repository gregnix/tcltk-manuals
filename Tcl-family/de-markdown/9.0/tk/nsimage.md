---
CommandName: nsimage
title: nsimage
ManualSection: n
Version: 9.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - image(n)
 - options(n)
 - photo(n)
Keywords:
 - height
 - image
 - types of images
 - width
Copyright:
 - Copyright (c) 2022 Marc Culler
---

# Name

nsimage - Tk-Bildtyp für macOS auf Basis der NSImage-Klasse

# Beschreibung

**nsimage** ist als Tk-Bildtyp implementiert. Der Befehl [image] erstellt, löscht und fragt alle Bilder ab, einschließlich Bilder vom Typ **nsimage**. Die verfügbaren Optionen sind spezifisch für den Typ **nsimage** und werden unten beschrieben.

Zum Erstellen eines **nsimage**:

**image create nsimage** ?*name*? ?*option value ...*?
: siehe unten ...


Erstellt ein neues **nsimage** und einen Befehl gleichen Namens; gibt dessen Namen zurück.

# Optionen

Gültige *options* sind:

[-source]{.lit} [string]{.arg}
: siehe unten ...


Der Wert der Option **-source** ist eine Zeichenkette, die ein NSImage beschreibt. Es gibt mehrere Interpretationsmöglichkeiten; die Interpretation wird durch den Wert der Option **-as** bestimmt. Diese Option ist erforderlich.

[-as]{.lit} [type]{.arg}
: siehe unten ...


Es gibt vier mögliche Werte für die Option **-as**, die festlegen, wie die Quellzeichenkette interpretiert werden soll. Die zulässigen Werte und ihre Bedeutungen sind:

**name**
: Die Quelle wird als Name eines vom System bereitgestellten benannten NSImage interpretiert. Dies ist der Standard, wenn die Option **-as** nicht angegeben ist.

[file]
: Die Quelle wird als Pfad zu einer Bilddatei in einem von der NSImage-Klasse unterstützten Format interpretiert.

**path**
: Die Quelle wird als Pfad zu einer beliebigen Datei interpretiert. Der Dateityp wird ermittelt; das resultierende Bild ist das Systemsymbol für Dateien dieses Typs.

**filetype**
: Die Quelle wird als Zeichenkette interpretiert, die einen bestimmten Dateityp identifiziert. Das kann eine Dateinamenserweiterung, ein Apple Uniform Type Identifier oder ein 4-Zeichen-OSType-Wert wie im HFS-Dateisystem sein.

[-width]{.lit} [pixels]{.arg}
: siehe unten ...


Der Wert der Option *width* ist eine Ganzzahl und gibt die Breite des **nsimage** in Pixeln an. Wenn die Breite nicht angegeben ist, wird sie aus der Höhe berechnet, um das Seitenverhältnis beizubehalten. Wenn weder Breite noch Höhe angegeben sind, werden Breite und Höhe des zugrunde liegenden NSImage verwendet.

[-height]{.lit} [pixels]{.arg}
: siehe unten ...


Der Wert der Option *height* ist eine Ganzzahl und gibt die Höhe des **nsimage** in Pixeln an. Wenn die Höhe nicht angegeben ist, wird sie aus der Breite berechnet, um das Seitenverhältnis beizubehalten. Wenn weder Breite noch Höhe angegeben sind, werden Breite und Höhe des zugrunde liegenden NSImage verwendet.

[-radius]{.lit} [pixels]{.arg}
: siehe unten ...


Der Wert der Option *radius* ist eine Ganzzahl. Ist er ungleich null, wird das Bild auf ein abgerundetes Rechteck mit derselben Breite und Höhe wie das Bild zugeschnitten; die Ecken werden durch Kreisbögen des angegebenen Radius abgeschnitten.

[-ring]{.lit} [pixels]{.arg}
: siehe unten ...


Der Wert der Option *ring* ist eine Ganzzahl. Ist er ungleich null, gibt er die Dicke eines Fokusrahmens an, der um das Bild mit der in den Systemeinstellungen festgelegten Akzentfarbe der Steuerelemente gezeichnet wird. Das Bild wird verkleinert, sodass Breite und Höhe jeweils um das Doppelte der Ringdicke reduziert werden. Das kann eine geringe Verzerrung verursachen. Das Seitenverhältnis eines nicht quadratischen Bildes ändert sich leicht.

[-alpha]{.lit} [float]{.arg}
: siehe unten ...


Der Wert der Option *alpha* sollte eine Gleitkommazahl zwischen 0,0 und 1,0 sein. Dieser Alpha-Wert wird auf jeden Pixel des **nsimage** angewendet und erzeugt ein teilweise transparentes Bild. Der Standardwert ist 1,0 (undurchsichtig).

[-pressed]{.lit} [boolean]{.arg}
: siehe unten ...


Die Option *pressed* nimmt einen booleschen Wert an. Ist der Wert true oder 1, wird das Bild algorithmisch im Hellmodus dunkler bzw. im Dunkelmodus heller dargestellt. Der Standard ist false. Für einen Bild-Button sollte das Hauptbild false verwenden; das gedrückte Bild sollte dasselbe Bild sein, aber mit der Option *pressed* auf true.

[-template]{.lit} [boolean]{.arg}
: siehe unten ...


Die Option *template* nimmt einen booleschen Wert an. Ist der Wert true oder 1, wird das Bild als Vorlagenbild markiert. Das System wandelt das Bild dann algorithmisch im Dunkelmodus in ein hellfarbiges Bild um. Damit der Algorithmus korrekt arbeitet, darf das Bild nur aus schwarzen Pixeln mit Alpha-Werten bestehen.


[file]: ../tcl/file.md
[image]: image.md
