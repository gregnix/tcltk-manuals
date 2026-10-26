---
CommandName: button
title: button
ManualSection: n
Version: 4.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - ttk::button(n)
Keywords:
 - button
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

button - Erstellt und manipuliert 'Button'-Action-Widgets

# Übersicht

::: {.synopsis} :::
[button]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standardoptionen

**-activebackground**, **-font**, **-relief**, **-activeforeground**, **-foreground**, **-repeatdelay**, **-anchor**, **-highlightbackground**, **-repeatinterval**, **-background**, **-highlightcolor**, **-takefocus**, **-bitmap**, **-highlightthickness**, **-text**, **-borderwidth**, **-image**, **-textvariable**, **-compound**, **-justify**, **-underline**, **-cursor**, **-padx**, **-wraplength**, **-disabledforeground**, **-pady**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-command** (**command**/**Command**)
: Legt einen Tcl-Befehl fest, der mit dem Button verknüpft wird. Dieser Befehl wird typischerweise aufgerufen, wenn Maustaste 1 über dem Button-Fenster losgelassen wird.

**-default** (**default**/**Default**)
: Legt einen von drei Zuständen für den Standard-Ring fest: **normal**, **active** oder **disabled**. Im aktiven Zustand wird der Button mit der plattformspezifischen Darstellung für einen Standard-Button gezeichnet. Im normalen Zustand wird der Button mit der plattformspezifischen Darstellung für einen Nicht-Standard-Button gezeichnet, wobei genug Platz für die Standard-Button-Darstellung gelassen wird. Die normalen und aktiven Zustände ergeben Buttons der gleichen Größe. Im deaktivierten Zustand wird der Button mit der Nicht-Standard-Button-Darstellung ohne Platz für die Standard-Darstellung gezeichnet. Der deaktivierte Zustand kann zu einem kleineren Button als der aktive Zustand führen.

**-height** (**height**/**Height**)
: Legt eine gewünschte Höhe für den Button fest. Wenn ein Bild oder Bitmap im Button angezeigt wird, ist der Wert in Bildschirmeinheiten (d.h. alle von [Tk\_GetPixels][GetPixels] akzeptierten Formen); für Text ist es in Textzeilen. Wenn diese Option nicht angegeben ist, wird die gewünschte Höhe des Buttons aus der Größe des angezeigten Bildes, Bitmaps oder Textes berechnet.

**-overrelief** (**overRelief**/**OverRelief**)
: Legt ein alternatives Relief für den Button fest, das verwendet wird, wenn der Mauszeiger über dem Widget ist. Diese Option kann verwendet werden, um Toolbar-Buttons zu erstellen, indem **-relief flat -overrelief raised** konfiguriert wird. Wenn der Wert dieser Option der leere String ist, wird kein alternatives Relief verwendet, wenn der Mauszeiger über dem Button ist. Der leere String ist der Standardwert.

**-state** (**state**/**State**)
: Legt einen von drei Zuständen für den Button fest: **normal**, **active** oder **disabled**. Im normalen Zustand wird der Button mit den Optionen **-foreground** und **-background** angezeigt. Der aktive Zustand wird typischerweise verwendet, wenn der Zeiger über dem Button ist. Im aktiven Zustand wird der Button mit den Optionen **-activeforeground** und **-activebackground** angezeigt. Der deaktivierte Zustand bedeutet, dass der Button unempfindlich sein sollte: Die Standard-Bindings weigern sich, das Widget zu aktivieren und ignorieren Mausklicks. In diesem Zustand bestimmen die Optionen **-disabledforeground** und **-background**, wie der Button angezeigt wird.

**-width** (**width**/**Width**)
: Legt eine gewünschte Breite für den Button fest. Wenn ein Bild oder Bitmap im Button angezeigt wird, ist der Wert in Bildschirmeinheiten (d.h. alle von [Tk\_GetPixels][GetPixels] akzeptierten Formen). Für einen Text-Button (kein Bild oder mit **-compound none**) gibt die Breite an, wie viel Platz in Zeichen für das Text-Label reserviert werden soll. Wenn die Breite negativ ist, wird eine Mindestbreite angegeben. Wenn diese Option nicht angegeben ist, wird die gewünschte Breite des Buttons aus der Größe des angezeigten Bildes, Bitmaps oder Textes berechnet.


# Beschreibung

Der Befehl **button** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Button-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des Buttons wie Farben, Schriftart, Text und anfängliches Relief zu konfigurieren. Der Befehl **button** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Ein Button ist ein Widget, das einen Text-String, ein Bitmap oder ein Bild anzeigt. Wenn Text angezeigt wird, muss er in einer einzigen Schriftart sein, kann aber mehrere Zeilen auf dem Bildschirm einnehmen (wenn er Zeilenumbrüche enthält oder wenn ein Umbruch wegen der Option **-wraplength** erfolgt), und eines der Zeichen kann optional mit der Option **-underline** unterstrichen werden. Er kann sich auf drei verschiedene Arten darstellen, je nach Option **-state**; er kann erhaben, eingesenkt oder flach dargestellt werden; und er kann blinken. Wenn ein Benutzer den Button aufruft (durch Drücken von Maustaste 1 mit dem Cursor über dem Button), wird der in der Option **-command** angegebene Tcl-Befehl aufgerufen.

# Widget-Befehl

Der Befehl **button** erstellt einen neuen Tcl-Befehl, dessen Name *pathName* ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Die folgenden Befehle sind für Button-Widgets möglich:

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **button** akzeptierten Werte haben.

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe [Tk\_ConfigureInfo][ConfigWidg] für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **button** akzeptierten Werte haben.

[pathName]{.ins} [flash]{.sub}
: Lässt den Button blinken. Dies wird erreicht, indem der Button mehrmals neu angezeigt wird und dabei zwischen den konfigurierten Farben activebackground und background wechselt. Am Ende des Blinkens bleibt der Button im gleichen normal/aktiven Zustand wie beim Aufruf des Befehls. Dieser Befehl wird ignoriert, wenn der Zustand des Buttons **disabled** ist.

[pathName]{.ins} [invoke]{.sub}
: Ruft den mit dem Button verknüpften Tcl-Befehl auf, falls einer vorhanden ist. Der Rückgabewert ist der Rückgabewert des Tcl-Befehls oder ein leerer String, wenn kein Befehl mit dem Button verknüpft ist. Dieser Befehl wird ignoriert, wenn der Zustand des Buttons **disabled** ist.


# Standard-Bindings

Tk erstellt automatisch Klassen-Bindings für Buttons, die ihnen Standardverhalten geben:

1. Ein Button wird aktiviert, wenn die Maus über ihn fährt, und deaktiviert, wenn die Maus ihn verlässt. Unter Windows ist dieses Binding nur aktiv, wenn Maustaste 1 über dem Button gedrückt wurde.

2. Das Relief eines Buttons wird auf eingesenkt geändert, wenn Maustaste 1 über dem Button gedrückt wird, und das Relief wird auf seinen ursprünglichen Wert wiederhergestellt, wenn Maustaste 1 später losgelassen wird.

3. Wenn Maustaste 1 über einem Button gedrückt und später über dem Button losgelassen wird, wird der Button aufgerufen. Wenn sich die Maus jedoch nicht über dem Button befindet, wenn Maustaste 1 losgelassen wird, erfolgt kein Aufruf.

4. Wenn ein Button den Eingabefokus hat, bewirkt die Leertaste, dass der Button aufgerufen wird.


Wenn der Zustand des Buttons **disabled** ist, tritt keine der obigen Aktionen auf: Der Button reagiert überhaupt nicht.

Das Verhalten von Buttons kann geändert werden, indem neue Bindings für einzelne Widgets definiert werden oder indem die Klassen-Bindings neu definiert werden.

# Plattform-Hinweise

Unter Aqua/macOS werden einige Konfigurationsoptionen zum Zweck des Zeichnens des Widgets ignoriert, da sie andernfalls mit Plattform-Richtlinien in Konflikt stehen würden. Die Unterbefehle **configure** und **cget** können die Werte weiterhin manipulieren, verursachen jedoch keine Variation im Aussehen des Widgets. Die betroffenen Optionen umfassen insbesondere **-background** und **-relief**.

# Beispiele

Dies ist die klassische Tk "Hello, World!"-Demonstration:

```
button .b -text "Hello, World!" -command exit
pack .b
```

Dieses Beispiel demonstriert, wie Button-Beschleuniger behandelt werden:

```
button .b1 -text Hello -underline 0
button .b2 -text World -underline 0
bind . <Key-h> {.b1 flash; .b1 invoke}
bind . <Key-w> {.b2 flash; .b2 invoke}
pack .b1 .b2
```


[ConfigWidg]: ../tk-c/ConfigWidg.md
[GetPixels]: ../tk-c/GetPixels.md
[options]: options.md
