---
CommandName: bitmap
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - bitmap
 - image
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

bitmap - Bilder mit zwei Farben

# ÜBERSICHT

::: {.synopsis} :::
[image]{.cmd} [create]{.sub} [bitmap]{.lit} [name]{.optarg} [options]{.optarg} 

[imageName]{.ins} [cget]{.sub} [option]{.arg} 
[imageName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot} 
:::

# BESCHREIBUNG

Ein Bitmap ist ein Bild, dessen Pixel entweder eine von zwei Farben anzeigen oder transparent sein können. Ein Bitmap-Bild wird durch vier Dinge definiert: eine Hintergrundfarbe, eine Vordergrundfarbe und zwei Bitmaps, *source* und *mask* genannt. Jedes Bitmap gibt 0/1-Werte für ein rechteckiges Pixelraster an; beide Bitmaps müssen dieselben Abmessungen haben. Ist die Maske an einer Pixelposition null, zeigt das Bild nichts und wirkt transparent. An allen anderen Pixeln zeigt das Bild die Vordergrundfarbe, wenn die Quelldaten eins sind, und die Hintergrundfarbe, wenn die Quelldaten null sind.

# ERSTELLEN VON BITMAPS

Wie alle Bilder werden Bitmaps mit dem Befehl **image create** erzeugt. Bitmaps unterstützen folgende *Optionen*:

**-background** *color*
: Legt eine Hintergrundfarbe für das Bild auf eine der von Tk akzeptierten Standardarten fest. Ist diese Option auf eine leere Zeichenkette gesetzt, sind die Hintergrundpixel transparent. Der Effekt entsteht, indem das Quell-Bitmap als Masken-Bitmap verwendet wird; Optionen **-maskdata** und **-maskfile** werden ignoriert.

**-data** *string*
: Legt den Inhalt des Quell-Bitmaps als Zeichenkette fest. Die Zeichenkette muss dem X11-Bitmap-Format entsprechen (z. B. wie vom Programm **bitmap** erzeugt). Sind **-data** und **-file** gesetzt, hat **-data** Vorrang.

**-file** *name*
: *name* ist der Name einer Datei, deren Inhalt das Quell-Bitmap definiert. Die Datei muss dem X11-Bitmap-Format entsprechen (z. B. wie vom Programm **bitmap** erzeugt).

**-foreground** *color*
: Legt eine Vordergrundfarbe für das Bild auf eine der von Tk akzeptierten Standardarten fest.

**-maskdata** *string*
: Legt den Inhalt der Maske als Zeichenkette fest. Die Zeichenkette muss dem X11-Bitmap-Format entsprechen (z. B. wie vom Programm **bitmap** erzeugt). Sind **-maskdata** und **-maskfile** gesetzt, hat **-maskdata** Vorrang.

**-maskfile** *name*
: *name* ist der Name einer Datei, deren Inhalt die Maske definiert. Die Datei muss dem X11-Bitmap-Format entsprechen (z. B. wie vom Programm **bitmap** erzeugt).


# BILD-BEFEHL

Wird ein Bitmap-Bild erzeugt, legt Tk auch einen neuen Befehl an, dessen Name mit dem des Bildes übereinstimmt. Mit diesem Befehl können verschiedene Operationen auf dem Bild ausgeführt werden. Er hat die allgemeine Form:

```
imageName option ?arg arg ...?
```

*Option* und die *arg*-Argumente bestimmen das genaue Verhalten des Befehls. Für Bitmap-Bilder sind folgende Befehle möglich:

*imageName* **cget** *option*
: Gibt den aktuellen Wert der Konfigurationsoption *option* zurück. *Option* kann einen der von **image create** **bitmap** akzeptierten Werte haben.

*imageName* **configure** ?*option*? ?*value option value ...*?
: Fragt die Konfigurationsoptionen des Bildes ab oder ändert sie. Ist keine *option* angegeben, gibt der Befehl eine Liste aller verfügbaren Optionen für *imageName* zurück (Format siehe **Tk_ConfigureInfo**). Ist *option* ohne *value* angegeben, liefert der Befehl eine Liste zur benannten Option (identisch mit der entsprechenden Teilliste ohne *option*). Sind eine oder mehrere *option-value*-Paare angegeben, setzt der Befehl die Option(en) auf die angegebenen Werte und gibt eine leere Zeichenkette zurück. *Option* kann einen der von **image create** **bitmap** akzeptierten Werte haben.


