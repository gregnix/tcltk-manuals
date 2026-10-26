---
CommandName: label
title: label
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - labelframe(n)
 - button(n)
 - ttk::label(n)
Keywords:
 - label
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

label - Erstellt und manipuliert 'Label'-Widgets für nicht-interaktiven Text oder Bilder

# Übersicht

::: {.synopsis} :::
[label]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standardoptionen

**-activebackground**, **-disabledforeground**, **-padx**, **-activeforeground**, **-font**, **-pady**, **-anchor**, **-foreground**, **-relief**, **-background**, **-highlightbackground**, **-takefocus**, **-bitmap**, **-highlightcolor**, **-text**, **-borderwidth**, **-highlightthickness**, **-textvariable**, **-compound**, **-image**, **-underline**, **-cursor**, **-justify**, **-wraplength**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-height** (**height**/**Height**)
: Legt eine gewünschte Höhe für das Label fest. Wenn ein Bild oder Bitmap im Label angezeigt wird, ist der Wert in Bildschirmeinheiten (d.h. alle von [Tk\_GetPixels][GetPixels] akzeptierten Formen); für Text ist es in Textzeilen. Wenn diese Option nicht angegeben ist, wird die gewünschte Höhe des Labels aus der Größe des angezeigten Bildes, Bitmaps oder Textes berechnet.

**-state** (**state**/**State**)
: Legt einen von drei Zuständen für das Label fest: **normal**, **active** oder **disabled**. Im normalen Zustand wird das Label mit den Optionen **-foreground** und **-background** angezeigt. Im aktiven Zustand wird das Label mit den Optionen **-activeforeground** und **-activebackground** angezeigt. Im deaktivierten Zustand bestimmen die Optionen **-disabledforeground** und **-background**, wie das Label angezeigt wird.

**-width** (**width**/**Width**)
: Legt eine gewünschte Breite für das Label fest. Wenn ein Bild oder Bitmap im Label angezeigt wird, ist der Wert in Bildschirmeinheiten (d.h. alle von [Tk\_GetPixels][GetPixels] akzeptierten Formen); für Text ist es in Zeichen. Wenn diese Option nicht angegeben ist, wird die gewünschte Breite des Labels aus der Größe des angezeigten Bildes, Bitmaps oder Textes berechnet.


# Beschreibung

Der Befehl **label** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Label-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des Labels wie Farben, Schriftart, Text und anfängliches Relief zu konfigurieren. Der Befehl **label** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Ein Label ist ein Widget, das einen Text-String, ein Bitmap oder ein Bild anzeigt. Wenn Text angezeigt wird, muss er in einer einzigen Schriftart sein, kann aber mehrere Zeilen auf dem Bildschirm einnehmen (wenn er Zeilenumbrüche enthält oder wenn ein Umbruch wegen der Option **-wraplength** erfolgt), und eines der Zeichen kann optional mit der Option **-underline** unterstrichen werden. Das Label kann auf einige einfache Arten manipuliert werden, wie z.B. das Ändern seines Reliefs oder Textes, unter Verwendung der unten beschriebenen Befehle.

# Widget-Befehl

Der Befehl **label** erstellt einen neuen Tcl-Befehl, dessen Name *pathName* ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Die folgenden Befehle sind für Label-Widgets möglich:

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **label** akzeptierten Werte haben.

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe [Tk\_ConfigureInfo][ConfigWidg] für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **label** akzeptierten Werte haben.


# Bindings

Wenn ein neues Label erstellt wird, hat es keine Standard-Event-Bindings: Labels sind nicht für Interaktion gedacht.

# Beispiel

```
# Erstelle die Widgets
label .t -text "This widget is at the top"    -bg red
label .b -text "This widget is at the bottom" -bg green
label .l -text "Left\nHand\nSide"
label .r -text "Right\nHand\nSide"
text .mid
.mid insert end "This layout is like Java's BorderLayout"
# Ordne sie an
pack .t   -side top    -fill x
pack .b   -side bottom -fill x
pack .l   -side left   -fill y
pack .r   -side right  -fill y
pack .mid -expand 1    -fill both
```


[ConfigWidg]: ../tk-c/ConfigWidg.md
[GetPixels]: ../tk-c/GetPixels.md
[options]: options.md
