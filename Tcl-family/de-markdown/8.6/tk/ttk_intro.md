---
CommandName: ttk::intro
title: ttk::intro
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - ttk::style(n)
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

ttk::intro - Einführung in die Tk-Theme-Engine

# Einleitung

Das Tk-Widget-Set mit Themes basiert auf einer überarbeiteten und erweiterten Version der in TIP #48 (https://tip.tcl-lang.org/48) spezifizierten Style-Engine. Die wichtigsten Konzepte werden unten beschrieben. Die Grundidee ist, soweit möglich den Code für das Verhalten eines Widgets vom Code für sein Erscheinungsbild zu trennen. Widget-Klassen-Bindungen sind vor allem dafür zuständig, den Widget-Zustand zu pflegen und Rückruffunktionen aufzurufen; alle Aspekte des Erscheinungsbilds werden über den Style des Widgets gesteuert (d. h. den Style der Elemente des Widgets).

# Themes

Ein *Theme* ist eine Sammlung von Elementen und Styles, die Look-and-Feel des Widget-Sets bestimmen. Themes können genutzt werden, um:

- Plattformunterschiede auszugleichen (X11 vs. klassisches Windows vs. XP vs. Aqua …)

- sich an Anzeigebeschränkungen anzupassen (wenige Farben, Graustufen, Monochrom, kleine Bildschirme)

- Barrierefreiheit (hoher Kontrast, große Schrift)

- Corporate Design einer Anwendungssuite

- sich in die restliche Desktop-Umgebung einzufügen (Gnome, KDE, Java)

- und natürlich: optische Aufwertung.


# Elemente

Ein *Element* stellt einen einzelnen Teil eines Widgets dar. Ein vertikales Scrollbar-Widget enthält z. B. die Elemente **uparrow**, **downarrow**, **trough** und **slider**.

Elementnamen verwenden eine rekursive Punktnotation. **uparrow** bezeichnet z. B. ein generisches Pfeil-Element; **Scrollbar.uparrow** und **Combobox.uparrow** bezeichnen widgetspezifische Elemente. Bei der Elementsuche prüft die Style-Engine zuerst den spezifischen Namen; wird kein Element dieses Namens gefunden, sucht sie nach generischen Elementen, indem sie nacheinander führende Komponenten des Elementnamens entfernt.

Wie Widgets haben Elemente *Optionen*, die festlegen, was und wie angezeigt wird. Das **text**-Element (zeigt eine Textzeichenkette) hat z. B. die Optionen **-text**, **-font**, **-foreground**, **-background**, **-underline** und **-width**. Der Wert einer Elementoption wird übernommen (in dieser Reihenfolge):

- einer gleichnamigen Option gleichen Typs im Widget, das das Element enthält;

- einer dynamischen Einstellung über **style map** und den aktuellen Zustand;

- der Standardeinstellung über **style configure**; oder

- dem eingebauten Standardwert des Elements für die Option.


# Layouts

Ein *Layout* legt fest, welche Elemente ein Widget bilden und wie sie angeordnet sind. Die Layout-Engine nutzt eine vereinfachte Variante des [pack]-Algorithmus: Ausgehend von einer anfänglichen Höhlung in Widgetgröße werden Elemente entlang der mit **-side** angegebenen Seite ein Parzelle in der Höhlung zugewiesen und gemäß **-sticky** darin platziert. Das Layout einer horizontalen Scrollbar ist z. B.:

```
ttk::style layout Horizontal.TScrollbar {
    Scrollbar.trough -children {
	Scrollbar.leftarrow -side left -sticky w
	Scrollbar.rightarrow -side right -sticky e
	Scrollbar.thumb -sticky ew
    }
}
```

Standardmäßig entspricht das Layout eines Widgets seinem Klassennamen. Manche Widgets überschreiben das (z. B. wählt [ttk::scrollbar][ttk_scrollbar] je nach Option **-orient** unterschiedliche Layouts).

# Zustände

In Standard-Tk haben viele Widgets eine Option **-state**, die (meist) **normal** oder **disabled** ist. Manche Widgets unterstützen weitere Zustände, z. B. [entry] mit **readonly** oder die verschiedenen Button-Varianten mit **active**.

Die Tk-Widgets mit Themes verallgemeinern diese Idee: Jedes Widget hat eine Bitmap unabhängiger Zustandsflags. Dazu gehören **active**, **disabled**, **pressed**, **focus** usw. (vollständige Liste der Zustandsflags in *ttk::widget(n)*).

Statt einer Option **-state** hat jedes Widget nun den Widget-Befehl **state** zum Setzen oder Abfragen des Zustands. Eine *Zustandsspezifikation* ist eine Liste symbolischer Zustandsnamen, die angibt, welche Bits gesetzt sind; optional mit vorangestelltem Ausrufezeichen, um ein Bit zu löschen.

Die Klassen-Bindungen für [ttk::button][ttk_button] sind z. B.:

```
bind TButton <Enter>		{ %W state active }
bind TButton <Leave>		{ %W state !active }
bind TButton <ButtonPress-1>	{ %W state pressed }
bind TButton <Button1-Leave>	{ %W state !pressed }
bind TButton <Button1-Enter>	{ %W state pressed }
bind TButton <ButtonRelease-1>	\
    { %W instate {pressed} { %W state !pressed ; %W invoke } }
```

Das Widget wird **active**, wenn der Mauszeiger es betritt, und inaktiv beim Verlassen. Beim Drücken der Maustaste wird es **pressed**, bei ButtonRelease **!pressed**. Wird die Taste bei gedrückter Button-1 außerhalb des Widgets gezogen, wird der Druck aufgehoben; beim Zurückziehen wieder **pressed**. Beim Loslassen wird **-command** aufgerufen, aber nur, wenn der Button gerade im Zustand **pressed** ist. (Die tatsächlichen Bindungen sind etwas komplexer, aber nicht viel.)

# Styles

Jedes Widget ist einem *Style* zugeordnet, der Werte für Elementoptionen festlegt. Stylenamen verwenden wie Layouts und Elemente eine rekursive Punktnotation; standardmäßig nutzen Widgets den Klassennamen, um einen Style im aktuellen Theme zu finden. Beispiel:

```
ttk::style configure TButton \
	-background #d9d9d9 \
	-foreground black \
	-relief raised \
	;
```

Viele Elemente werden je nach Widget-Zustand unterschiedlich dargestellt. Buttons haben z. B. anderen Hintergrund, wenn sie aktiv sind, andere Vordergrundfarbe, wenn sie deaktiviert sind, und anderes Relief, wenn sie gedrückt sind. Der Befehl **style map** legt dynamische Optionseinstellungen für einen bestimmten Style fest:

```
ttk::style map TButton \
	-background [list disabled #d9d9d9  active #ececec] \
	-foreground [list disabled #a3a3a3] \
	-relief [list {pressed !disabled} sunken] \
	;
```


[entry]: entry.md
[pack]: pack.md
[ttk_button]: ttk_button.md
[ttk_scrollbar]: ttk_scrollbar.md
