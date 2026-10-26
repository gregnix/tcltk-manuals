---
CommandName: ttk_vsapi
title: ttk_vsapi
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::intro(n)
 - ttk::widget(n)
 - ttk::style(n)
 - ttk_image(n)
Keywords:
 - style
 - theme
 - appearance
 - windows
Copyright:
 - Copyright (c) 2008 Pat Thoyts
---

# Name

ttk\_vsapi - Microsoft-Visual-Styles-Element definieren

# Übersicht

::: {.synopsis} :::
[ttk::style]{.cmd} [element]{.sub} [create]{.lit} [name]{.arg} [vsapi]{.lit} [className]{.arg} [partId]{.arg} [stateMap]{.optarg} [options]{.optarg}
:::

# Beschreibung

Die **vsapi**-Elementfabrik erstellt im aktuellen Theme ein neues Element, dessen visuelle Darstellung mit der Microsoft Visual Styles API gezeichnet wird, die ttk für die nativen Stile unter MS-Windows verwendet. Diese Fabrik erlaubt, beliebige Visual-Styles-Teile als Ttk-Elemente zu deklarieren, die dann in ein Style-Layout eingebunden werden können, um das Erscheinungsbild von Ttk-Widgets zu ändern.

Die Parameter *className* und *partId* sind erforderlich und legen die Visual-Styles-Klasse und den Teil gemäß der Microsoft-Dokumentation fest. *stateMap* kann angegeben werden, um Ttk-Zustände auf Visual-Styles-API-Zustände abzubilden (siehe [Zustandszuordnung]).

# Optionen

Gültige *options* sind:

[-padding]{.lit} [padding]{.arg}
: Legt den Innenabstand des Elements fest. *padding* ist eine Liste mit bis zu vier Ganzzahlen für die Abstände links, oben, rechts und unten. Sind weniger als vier Elemente angegeben, gilt *bottom* = *top*, *right* = *left* und *top* = *left*. Eine Liste mit drei Zahlen gibt links, vertikal und rechts an; zwei Zahlen horizontal und vertikal; eine Zahl denselben Abstand rundherum. Diese Option darf nicht mit anderen Optionen kombiniert werden.

[-margins]{.lit} [padding]{.arg}
: Legt den Außenabstand des Elements fest. *padding* ist eine Liste mit bis zu vier Ganzzahlen für die Abstände links, oben, rechts und unten. Diese Option darf nicht mit anderen Optionen kombiniert werden.

[-width]{.lit} [width]{.arg}
: Legt die Breite des Elements fest. Wenn diese Option gesetzt ist, wird die Visual Styles API nicht nach der empfohlenen Größe des Teils abgefragt. Wenn diese Option gesetzt ist, sollte auch **-height** gesetzt werden. Die Optionen **-width** und **-height** dürfen nicht mit **-padding** oder **-margins** kombiniert werden.

[-height]{.lit} [height]{.arg}
: Legt die Höhe des Elements fest. Siehe die Hinweise zu **-width**.


# Zustandszuordnung

Der Parameter *stateMap* ist eine Liste von ttk-Zuständen und dem zugehörigen Visual-Styles-API-Zustandswert. Damit kann sich das Erscheinungsbild des Elements bei Widget-Zustandsänderungen anpassen (z. B. aktiv oder gedrückt). Die Liste sollte wie beim Befehl [ttk::style map][ttk_style] beschrieben aufgebaut sein; das letzte Paar in der Liste sollte der Standardzustand sein und ist typischerweise eine leere Liste und 1. Leider haben alle Visual-Styles-Teile unterschiedliche Zustandswerte; diese müssen in der Microsoft-Dokumentation oder eher in den Header-Dateien nachgeschlagen werden. Ursprünglich war *tmschema.h* zu verwenden; in neueren Versionen des Windows Development Kit ist es *vssym32.h*.

Wenn kein Parameter *stateMap* angegeben wird, gilt implizit die Standardzuordnung {{} 1}

# Beispiele

Erstellen eines korrekt thematisierten Schließen-Buttons durch Änderung des Layouts eines [ttk::button][ttk_button](n). Verwendet den WINDOW-Teil WP\_SMALLCLOSEBUTTON; wie dokumentiert werden die Zustände CBS\_DISABLED, CBS\_HOT, CBS\_NORMAL und CBS\_PUSHED von ttk-Zuständen abgebildet.

```
ttk::style element create smallclose vsapi WINDOW 19 \
    {disabled 4 pressed 3 active 2 {} 1}
ttk::style layout CloseButton {CloseButton.smallclose -sticky news}
pack [ttk::button .close -style CloseButton]
```

Ändern des Erscheinungsbilds eines [ttk::checkbutton][ttk_checkbutton](n), um den Explorer-Pin-Teil EBP\_HEADERPIN zu verwenden.

```
ttk::style element create pin vsapi EXPLORERBAR 3 {
    {pressed !selected} 3
    {active !selected} 2
    {pressed selected} 6
    {active selected} 5
    {selected} 4
    {} 1
}
ttk::style layout Explorer.Pin {Explorer.Pin.pin -sticky news}
pack [ttk::checkbutton .pin -style Explorer.Pin]
```


[ttk_button]: ttk_button.md
[ttk_checkbutton]: ttk_checkbutton.md
[ttk_style]: ttk_style.md
