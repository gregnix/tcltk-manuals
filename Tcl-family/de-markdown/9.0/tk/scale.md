---
CommandName: scale
ManualSection: n
Version: 4.1
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - ttk::scale(n)
Keywords:
 - scale
 - slider
 - trough
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

scale - Erstellt und manipuliert 'Scale'-Widgets mit wertgesteuertem Schieberegler

# ÜBERSICHT

::: {.synopsis} :::
[scale]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# WIDGET-SPEZIFISCHE OPTIONEN

**-bigincrement** (bigIncrement/BigIncrement)
: Einige Interaktionen mit der Scale bewirken, dass sich ihr Wert in „großen“ Schritten ändert; diese Option legt die Größe der großen Schritte fest. Wenn als 0 angegeben, entsprechen die großen Schritte standardmäßig 1/10 des Wertebereichs der Scale.

**-command** (command/Command)
: Legt das Präfix eines Tcl-Befehls fest, der aufgerufen wird, wenn sich der Wert der Scale über einen Widget-Befehl ändert. Der tatsächliche Befehl besteht aus dieser Option gefolgt von einem Leerzeichen und einer reellen Zahl, die den neuen Wert der Scale angibt.

**-digits** (digits/Digits)
: Eine Ganzzahl, die angibt, wie viele signifikante Stellen beim Umwandeln des Werts der Scale in einen String beibehalten werden sollen. Wenn die Zahl negativ oder null ist, wählt die Scale den kleinsten Wert, der garantiert, dass jede mögliche Schiebereglerposition als unterschiedlicher String ausgegeben wird.

**-from** (from/From)
: Ein reeller Wert, der dem linken oder oberen Ende der Scale entspricht.

**-label** (label/Label)
: Ein String, der als Beschriftung für die Scale angezeigt wird. Bei vertikalen Scales wird die Beschriftung direkt rechts vom oberen Ende der Scale angezeigt. Bei horizontalen Scales wird die Beschriftung direkt über dem linken Ende der Scale angezeigt. Wenn die Option als leerer String angegeben ist, wird keine Beschriftung angezeigt.

**-length** (length/Length)
: Legt die gewünschte Längenabmessung der Scale in Bildschirmeinheiten fest (d.h. alle von **Tk_GetPixels** akzeptierten Formen). Bei vertikalen Scales ist dies die Höhe der Scale; bei horizontalen Scales ist es die Breite der Scale.

**-resolution** (resolution/Resolution)
: Ein reeller Wert, der die Auflösung für die Scale angibt. Wenn dieser Wert größer als null ist, wird der Wert der Scale stets auf ein gerades Vielfaches dieses Werts gerundet, ebenso die Endpunkte der Scale. Wenn der Wert negativ ist, erfolgt keine Rundung. Standardwert ist 1 (d.h. der Wert ist ganzzahlig).

**-showvalue** (showValue/ShowValue)
: Legt einen booleschen Wert fest, der angibt, ob der aktuelle Wert der Scale angezeigt werden soll.

**-sliderlength** (sliderLength/SliderLength)
: Legt die Größe des Schiebereglers fest, gemessen in Bildschirmeinheiten entlang der Längenabmessung des Schiebereglers. Der Wert kann in einer der von **Tk_GetPixels** akzeptierten Formen angegeben werden.

**-sliderrelief** (sliderRelief/SliderRelief)
: Legt das Relief fest, das beim Zeichnen des Schiebereglers verwendet wird, z. B. **raised** oder **sunken**.

**-state** (state/State)
: Legt einen von drei Zuständen für die Scale fest: **normal**, **active** oder **disabled**. Wenn die Scale deaktiviert ist, kann der Wert nicht geändert werden und die Scale wird nicht aktiviert. Wenn die Scale aktiv ist, wird der Schieberegler mit der durch die Option **-activebackground** angegebenen Farbe angezeigt.

**-tickinterval** (tickInterval/TickInterval)
: Muss ein reeller Wert sein. Bestimmt den Abstand zwischen numerischen Markierungen, die unterhalb oder links vom Schieberegler angezeigt werden. Die Werte werden alle mit derselben Anzahl Dezimalstellen angezeigt, die ausreicht, um sicherzustellen, dass sie alle innerhalb von 20 % eines Markierungsintervalls genau sind. Wenn 0, werden keine Markierungen angezeigt.

**-to** (to/To)
: Legt einen reellen Wert fest, der dem rechten oder unteren Ende der Scale entspricht. Dieser Wert kann kleiner oder größer als die Option **-from** sein.

**-variable** (variable/Variable)
: Gibt den Namen einer globalen Variable an, die mit der Scale verknüpft wird. Wenn sich der Wert der Variable ändert, aktualisiert sich die Scale, um diesen Wert widerzuspiegeln. Wenn die Scale interaktiv manipuliert wird, wird die Variable geändert, um den neuen Wert der Scale widerzuspiegeln.

**-width** (width/Width)
: Legt die gewünschte schmale Abmessung der Scale in Bildschirmeinheiten fest (d.h. alle von **Tk_GetPixels** akzeptierten Formen). Bei vertikalen Scales ist dies die Breite der Scale; bei horizontalen Scales ist es die Höhe der Scale.


# BESCHREIBUNG

Der Befehl **scale** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Scale-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte der Scale wie Farben, Ausrichtung und Relief zu konfigurieren. Der Befehl **scale** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Eine Scale ist ein Widget, das eine rechteckige *Rinne* (*trough*) und einen kleinen *Schieberegler* (*slider*) anzeigt. Die Rinne entspricht einem Bereich reeller Werte (bestimmt durch die Optionen **-from**, **-to** und **-resolution**), und die Position des Schiebereglers wählt einen bestimmten reellen Wert aus. Die Position des Schiebereglers (und damit der Wert der Scale) kann mit Maus oder Tastatur angepasst werden, wie im Abschnitt **STANDARD-BINDINGS** unten beschrieben. Wenn sich der Wert der Scale ändert, wird ein Tcl-Befehl aufgerufen (über die Option **-command**), um andere interessierte Widgets über die Änderung zu informieren. Zusätzlich kann der Wert der Scale mit einer Tcl-Variable verknüpft werden (über die Option **-variable**), sodass Änderungen in der einen in der anderen widergespiegelt werden.

In einem Scale-Widget können drei Anmerkungen angezeigt werden: eine Beschriftung oben rechts im Widget (oben links bei horizontalen Scales), eine Zahl direkt links vom Schieberegler (direkt über dem Schieberegler bei horizontalen Scales) und eine Sammlung numerischer Markierungen direkt links vom aktuellen Wert (direkt unter der Rinne bei horizontalen Scales). Jede dieser drei Anmerkungen kann über die Konfigurationsoptionen aktiviert oder deaktiviert werden.

# WIDGET-BEFEHL

Der Befehl **scale** erstellt einen neuen Tcl-Befehl, dessen Name *pathName* ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Die folgenden Befehle sind für Scale-Widgets möglich:

*pathName* **cget** *option*
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **scale** akzeptierten Werte haben.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe **Tk_ConfigureInfo** für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **scale** akzeptierten Werte haben.

*pathName* **coords** ?*value*?
: Gibt eine Liste zurück, deren Elemente die x- und y-Koordinaten des Punkts entlang der Mittellinie der Rinne sind, der *value* entspricht. Wenn *value* weggelassen wird, wird der aktuelle Wert der Scale verwendet.

*pathName* **get** ?*x y*?
: Wenn *x* und *y* weggelassen werden, gibt der Befehl den aktuellen Wert der Scale zurück. Wenn *x* und *y* angegeben sind, geben sie Pixelkoordinaten innerhalb des Widgets an; der Befehl gibt den Scale-Wert zurück, der dem gegebenen Pixel entspricht. Nur eines von *x* oder *y* wird verwendet: Bei horizontalen Scales wird *y* ignoriert, bei vertikalen Scales wird *x* ignoriert.

*pathName* **identify** *x y*
: Gibt einen String zurück, der angibt, welcher Teil der Scale unter den durch *x* und *y* gegebenen Koordinaten liegt. Ein Rückgabewert **slider** bedeutet, dass der Punkt über dem Schieberegler liegt; **trough1** bedeutet, dass der Punkt über dem Teil der Rinne oberhalb oder links vom Schieberegler liegt; und **trough2** bedeutet, dass der Punkt über dem Teil der Rinne unterhalb oder rechts vom Schieberegler liegt. Wenn der Punkt über keinem dieser Elemente liegt, wird ein leerer String zurückgegeben.

*pathName* **set** *value*
: Dieser Befehl wird aufgerufen, um den aktuellen Wert der Scale zu ändern und damit die Position, an der der Schieberegler angezeigt wird. *Value* gibt den neuen Wert für die Scale an. Der Befehl hat keine Wirkung, wenn die Scale deaktiviert ist.


# STANDARD-BINDINGS

Tk erstellt automatisch Klassen-Bindings für Scales, die ihnen folgendes Standardverhalten geben. Wenn sich das Verhalten für vertikale und horizontale Scales unterscheidet, wird das horizontale Verhalten in Klammern beschrieben.

1. Wenn Taste 1 in der Rinne gedrückt wird, wird der Wert der Scale um den Wert der Option **-resolution** erhöht oder verringert, sodass sich der Schieberegler in Richtung des Mauszeigers bewegt. Wenn die Taste gedrückt gehalten wird, wiederholt sich die Aktion automatisch.

2. Wenn Taste 1 über dem Schieberegler gedrückt wird, kann der Schieberegler mit der Maus gezogen werden.

3. Wenn Taste 1 in der Rinne mit gedrückter Steuerungstaste gedrückt wird, bewegt sich der Schieberegler bis zum Ende seines Bereichs in Richtung des Mauszeigers.

4. Wenn Taste 2 gedrückt wird, wird der Wert der Scale auf die Mausposition gesetzt. Wenn die Maus mit gedrückter Taste 2 gezogen wird, ändert sich der Wert der Scale mit dem Ziehen.

5. Die Tasten Pfeil-hoch und Pfeil-links bewegen den Schieberegler nach oben (links) um den Wert der Option **-resolution**.

6. Die Tasten Pfeil-runter und Pfeil-rechts bewegen den Schieberegler nach unten (rechts) um den Wert der Option **-resolution**.

7. Strg-Pfeil-hoch und Strg-Pfeil-links bewegen den Schieberegler nach oben (links) um den Wert der Option **-bigincrement**.

8. Strg-Pfeil-runter und Strg-Pfeil-rechts bewegen den Schieberegler nach unten (rechts) um den Wert der Option **-bigincrement**.

9. Pos1 bewegt den Schieberegler zum oberen (linken) Ende seines Bereichs.

10. Ende bewegt den Schieberegler zum unteren (rechten) Ende seines Bereichs.


Wenn die Scale mit der Option **-state** deaktiviert ist, haben keine der obigen Bindings Wirkung.

Das Verhalten von Scales kann geändert werden, indem neue Bindings für einzelne Widgets definiert werden oder indem die Klassen-Bindings neu definiert werden.
