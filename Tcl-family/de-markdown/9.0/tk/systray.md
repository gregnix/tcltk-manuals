---
CommandName: tk
ManualSection: systray
Version: n
TclPart: 
TclDescription: Tk
Keywords:
 - image
 - callback
Copyright:
 - Copyright (c) 2020 Kevin Walzer
---

# NAME

systray - Erzeugt ein Symbol in der plattformspezifischen Systemleiste

# ÜBERSICHT

::: {.synopsis} :::
[tk]{.cmd} [systray]{.sub} [create]{.lit} [-image]{.lit} [image]{.arg} [-text text]{.optarg} [-button1 callback]{.optarg} [-button3 callback]{.optarg} 
[tk]{.cmd} [systray]{.sub} [configure]{.lit} [option]{.optarg} [value option value]{.optdot} 
[tk]{.cmd} [systray]{.sub} [exists]{.lit} 
[tk]{.cmd} [systray]{.sub} [destroy]{.lit} 
:::

# BESCHREIBUNG

Der Befehl **tk systray create** erzeugt ein Symbol in der plattformspezifischen Leiste. Das Widget erhält ein Tk-Bild für die Anzeige, optional eine Zeichenkette für einen Tooltip und optionale Rückrufe, die an \<Button-1> und \<Button-3> gebunden sind.

Der Befehl **tk systray configure** setzt eine oder mehrere Optionen des Leistensymbols. Die einstellbaren Optionen sind dieselben wie beim Unterbefehl **create**. Ist nur ein Optionsname angegeben, gibt der Befehl den aktuellen Wert dieser Option zurück. Ohne Option gibt er die Liste aller Optionen und ihrer aktuellen Werte zurück.

Der Befehl **tk systray exists** prüft, ob ein Leistensymbol erzeugt wurde. Er gibt einen booleschen Wert zurück.

Der Befehl **tk systray destroy** nimmt das Symbol aus der Anzeige und gibt es frei.

Aus Sicht der Oberfläche wird nur ein Symbol je Interpreter unterstützt; der Versuch, weitere Symbole zu erzeugen, gibt einen Fehler zurück. Das vorhandene Leistensymbol lässt sich mit anderen Bildern und Zeichenketten ändern, um den Zustand der Anwendung anzuzeigen. Weitere Interpreter in einer laufenden Wish-Instanz erlauben weitere Symbole.

# BEISPIELE

Ein Beispiel für **tk systray**:

```
image create photo book -data \
        R0lGODlhDwAPAKIAAP//////AP8AAMDAwICAgAAAAAAAAAAAACwAAAAADwAPAAADSQhA2u5ksPeKABKSCaya29d4WKgERFF0l1IMQCAKatvBJ0OTdzzXI1xMB3TBZAvATtB6NSLKleXi3OBoLqrVgc0yv+DVSEUuFxIAOw==
tk systray create -image book -text "tk systray sample" \
        -button1 {puts "Here is the tk systray output"} \
        -button3 {puts "here is alternate output"}
```

So lässt sich das Symbol **tk systray** ändern:

```
image create photo book_page -data \
        R0lGODlhCwAPAKIAAP//////AMDAwICAgAAA/wAAAAAAAAAAACwAAAAACwAPAAADMzi6CzAugiAgDGE68aB0RXgRJBFVX0SNpQlUWfahQOvSsgrX7eZJMlQMWBEYj8iQchlKAAA7
tk systray configure -image book_page -text "Updated sample" \
        -button1 {puts "Different output from the tk systray"} \
        -button3 {puts "and more different output from the tk systray"}
```

# PLATTFORMHINWEISE

Die X11-Implementierung wird nach bestem Bemühen unterstützt, weil sie vom Fenstermanager abhängt. Die Option „text“, umgesetzt als Tooltip, erscheint nicht immer, wenn der Fenstermanager das nicht kann; bei manchen Fenstermanagern erscheint das Leistensymbol selbst nicht.

Unter Windows muss das in **-image** angegebene Tk-Bild ein Photo-Image sein. Auf anderen Plattformen ist ein Bitmap- oder ein Photo-Image zulässig.
