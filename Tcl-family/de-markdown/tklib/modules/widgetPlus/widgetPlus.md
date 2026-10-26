---
CommandName: widgetPlus
title: widgetPlus
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Enhanced Entry, Spinbox, and Combobox Widgets with Undo/Redo and other useful features
Links:
 - BWidget
 - ComboBox
 - Entry
 - entry
 - persistentSelection
 - spinbox
 - text
 - ttk::combobox
 - ttk::entry
 - ttk::spinbox
Copyright:
---

# Name

widgetPlus – Erweiterte Widgets Entry, Spinbox und Combobox mit Undo/Redo und weiteren Funktionen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [widgetPlus]{.lit} [1.0]{.optlit}
[widgetPlus::entryPlus]{.cmd} [create]{.optarg} [pathName]{.arg}
[widgetPlus::spinboxPlus]{.cmd} [create]{.optarg} [pathName]{.arg}
[widgetPlus::ttkEntryPlus]{.cmd} [create]{.optarg} [pathName]{.arg}
[widgetPlus::ttkSpinboxPlus]{.cmd} [create]{.optarg} [pathName]{.arg}
[widgetPlus::ttkComboboxPlus]{.cmd} [create]{.optarg} [pathName]{.arg}
[widgetPlus::EnableBWidget]{.cmd}
[pathName]{.ins} [edit]{.sub} [arg arg]{.optdot}
[pathName]{.ins} [edit]{.sub} [canredo]{.lit}
[pathName]{.ins} [edit]{.sub} [canundo]{.lit}
[pathName]{.ins} [edit]{.sub} [modified]{.lit} [boolean]{.optarg}
[pathName]{.ins} [edit]{.sub} [redo]{.lit}
[pathName]{.ins} [edit]{.sub} [reset]{.lit}
[pathName]{.ins} [edit]{.sub} [separator]{.lit}
[pathName]{.ins} [edit]{.sub} [undo]{.lit}
:::

# Beschreibung

Das Paket „**widgetPlus**“ erweitert die Widgets „**entry**“, **spinbox**, **ttk::entry**, **ttk::spinbox** und **ttk::combobox**.

Neu sind Undo und Redo, ein Ereignis **<<Selection>>** und für die nicht thematisierten **Tk**-Widgets die Option **-inactiveselectbackground**, dazu kleinere Korrekturen an den Bindings.  Die neuen Funktionen orientieren sich eng an denen des **text**-Widgets.

Die überarbeiteten Widgets **entry**, **spinbox**, **ttk::entry**, **ttk::spinbox** sowie **ttk::combobox** werden durch die Befehle **widgetPlus::entryPlus**, **widgetPlus::spinboxPlus**, **widgetPlus::ttkEntryPlus**, **widgetPlus::ttkSpinboxPlus** bzw. **widgetPlus::ttkComboboxPlus** erstellt.

Zum Beispiel ist **widgetPlus::entryPlus** ein *Snit*-**snit::widgetadaptor**, der ein **Tk**-Widget **entry** umhüllt. Seine **winfo class** ist **Entry**, und der Bindtag [entryPlus] ersetzt den Bindtag **Entry**. Die anderen Widgets sind auf ähnliche Weise implementiert.

Das Paket verwendet den Namespace **::widgetPlus**, der (ausschließlich) die fünf unten definierten Befehle exportiert, die mit einem Kleinbuchstaben beginnen (**EnableBWidget** wird nicht exportiert).  Diese Befehle können in den globalen Namespace importiert werden; der Einfachheit halber wird in der Beschreibung dieses Handbuchs fortan auf die Angabe des Namespace-Qualifizierers verzichtet.

```
namespace import ::widgetPlus::*
```

# Widget-Optionen

Zusätzlich zu den üblichen Optionen der Widgets **entry**, **spinbox**, **ttk::entry**, **ttk::spinbox** und **ttk::combobox** bieten die Wrapper **entryPlus**, **spinboxPlus**, **ttkEntryPlus**, **ttkSpinboxPlus** und **ttkComboboxPlus** die folgenden Optionen.

**-inactiveselectbackground** (**inactiveSelectBackground**/**Foreground**)
: Farbe der Auswahl, wenn das Fenster nicht den Eingabe-**focus** hat. Ist der Wert leer, **{}**, wird ohne **focus** keine Auswahl gezeigt. Die Option **-inactiveselectbackground** wirkt nicht auf die thematisierten Widgets **ttkEntryPlus**, **ttkSpinboxPlus** und **ttkComboboxPlus**.

**-maxundo** (**maxUndo**/**MaxUndo**)
: Maximale Zahl zusammengesetzter Undo-Aktionen auf dem *Undo-Stapel*. Null oder ein negativer Wert bedeuten einen unbegrenzten *Undo-Stapel*.

**-undo** (**undo**/**Undo**)
: Ein *boolean*. Legt fest, ob der Undo-Mechanismus aktiv ist.


# Befehle

**widgetPlus::entryPlus** ?*create*? *pathName*
: Erzeugt ein Widget **entryPlus** oder wandelt ein vorhandenes Widget **entry** in ein **entryPlus** um.

**widgetPlus::spinboxPlus** ?*create*? *pathName*
: Erzeugt ein Widget **spinboxPlus** oder wandelt ein vorhandenes Widget **spinbox** in ein **spinboxPlus** um.

**widgetPlus::ttkEntryPlus** ?*create*? *pathName*
: Erzeugt ein Widget **ttkEntryPlus** oder wandelt ein vorhandenes Widget **ttk::entry** in ein **ttkEntryPlus** um.

**widgetPlus::ttkSpinboxPlus** ?*create*? *pathName*
: Erzeugt ein Widget **ttkSpinboxPlus** oder wandelt ein vorhandenes Widget **ttk::spinbox** in ein **ttkSpinboxPlus** um.

**widgetPlus::ttkComboboxPlus** ?*create*? *pathName*
: Erzeugt ein Widget **ttkComboboxPlus** oder wandelt ein vorhandenes Widget **ttk::combobox** in ein **ttkComboboxPlus** um.

**widgetPlus::EnableBWidget**
: Erlaubt **widgetPlus**, **BWidget**-Widgets **Entry** und ihre Zusammensetzungen zu ändern, etwa die **BWidget**-**ComboBox**. Der Befehl legt den Bindtag **BwEntryPlus** an, der den voreingestellten Bindtag **BwEntry** ersetzt. Das geschieht beim Laden des Pakets nicht, weil **BWidget** vorher geladen sein muss. Der Befehl wird aus dem Namespace **::widgetPlus** nicht exportiert.


# Widget-Befehle

Zusätzlich zu den üblichen Befehlen der Widgets **entry**, **spinbox**, **ttk::entry**, **ttk::spinbox** und **ttk::combobox** bieten die Wrapper **entryPlus**, **ttkEntryPlus**, **spinboxPlus**, **ttkSpinboxPlus** und **ttkComboboxPlus**:

*pathName* **edit** ?*arg arg ...*?
: Dieser Befehl steuert den Undo-Mechanismus und das *Änderungsflag*. Das genaue Verhalten hängt vom Optionsargument nach **edit** ab. Derzeit gibt es diese Formen:

*pathName* **edit canredo**
: Gibt ein *boolean* **true** zurück, wenn Redo möglich ist, also wenn der *Redo-Stapel* nicht leer ist. Sonst **false**.

*pathName* **edit canundo**
: Gibt ein *boolean* **true** zurück, wenn Undo möglich ist, also wenn der *Undo-Stapel* nicht leer ist. Sonst **false**.

*pathName* **edit modified** ?*boolean*?
: Ist *boolean* nicht angegeben, gibt der Befehl das *Änderungsflag* des Widgets zurück. Die Befehle **insert**, **delete**, **edit undo** und **edit redo**, oder über diesen Befehl der Aufrufer, können das *Änderungsflag* setzen oder löschen. Ist *boolean* angegeben, setzt der Befehl das *Änderungsflag* des Widgets auf *boolean*.

*pathName* **edit redo**
: Ist **-undo** **true**, wendet der Befehl die zuletzt rückgängig gemachten Änderungen wieder an, sofern seither keine anderen Änderungen erfolgten. Ist der *Redo-Stapel* leer, entsteht ein Fehler. Ist **-undo** **false**, geschieht nichts.

*pathName* **edit reset**
: Leert den *Undo-Stapel* und den *Redo-Stapel*.

*pathName* **edit separator**
: Wird der Vollständigkeit halber aufgenommen, hat jedoch keine Auswirkung.

    (Anmerkung: Bei jedem Aufruf eines Widget-Befehls (z. B. **insert** oder **delete**), der den Inhalt des Widgets verändert, wird dem *Undo-Stapel* ein implizites Trennzeichen hinzugefügt.  Sie trennen damit das Eintippen oder Löschen einzelner Zeichen, außer dass *cut* und *paste* jeweils ein eigener Schritt sind.)

*pathName* **edit undo**
: Macht die letzte Änderung rückgängig, wenn **-undo** **true** ist. Eine Änderung ist ein einzelner Befehl **insert** oder **delete** auf dem *Undo-Stapel*. Ist der *Undo-Stapel* leer, entsteht ein Fehler. Ist **-undo** **false**, geschieht nichts.


# Bindings

## Klassenbindungen

Das Klassen-Binding-Tag für verschiedene Widgets weist folgende Standardwerte auf:

- **entry** verwendet **Entry**

- **spinbox** verwendet **Spinbox**

- **ttk::entry** verwendet **TEntry**

- **ttk::spinbox**    verwendet **TSpinbox**

- **ttk::combobox**   verwendet **TCombobox**

- [entryPlus] verwendet **EntryPlus**

- [spinboxPlus]     verwendet **SpinboxPlus**

- **ttkEntryPlus**    verwendet [TEntryPlus]

- **ttkSpinboxPlus**  verwendet [TSpinboxPlus]

- **ttkComboboxPlus** verwendet [TComboboxPlus]


## Rückgängig und Wiederherstellen

Die virtuellen Ereignisse „**<<Undo>>**“ und „**<<Redo>>**“ werden diesen Tastaturereignissen zugeordnet:

- Auf X11-Systemen (Linux®, BSD®, Solaris® usw.):

    - **<<Undo>>** ist **<Control-z>** zugeordnet


    - **<<Redo>>** ist **<Control-Shift-z>** zugeordnet


- Auf Windows®-Systemen:

    - **<<Undo>>** ist **<Control-z>** zugeordnet


    - **<<Redo>>** ist **<Control-y>** zugeordnet


- Auf Aqua®-Systemen (d. h. Apple® macOS® oder OS X®):

    - **<<Undo>>** ist **<Command-z>** zugeordnet


    - **<<Redo>>** ist **<Command-Shift-z>** zugeordnet



## entryPlus

Die [entryPlus]-Bindings basieren auf denen des Bindtags **Entry**, wobei folgende Änderungen vorgenommen wurden:

- Neue Bindings zu **<<Undo>>** und **<<Redo>>**.

- Eine Anpassung der Bindung **<<Paste>>**, damit diese sich unter X11 genauso verhält wie unter anderen Fenstersystemen (d. h., sie löscht die vorhandene Auswahl, sofern eine solche vorhanden ist).

- Die Entfernung der veralteten Bindung „**<Insert>**“.

- Neue Bindings zu **<FocusIn>** und **<FocusOut>**, um die Implementierung der Option **-inactiveselectbackground** zu erleichtern.


## spinboxPlus

Die [spinboxPlus]-Bindings basieren auf denen des Bindtags **Spinbox**, wobei dieselben Änderungen vorgenommen wurden wie bei der Konvertierung von **Entry** in [entryPlus].

## TEntryPlus

Die [TEntryPlus]-Bindings basieren auf denen des Bindtags **TEntry**, wobei folgende Änderungen vorgenommen wurden:

- Neue Bindings zu **<<Undo>>** und **<<Redo>>**.


## TSpinboxPlus

Die [TSpinboxPlus]-Bindings basieren auf denen des Bindtags **TSpinbox**, wobei folgende Änderungen vorgenommen wurden:

- Neue Bindings zu **<<Undo>>** und **<<Redo>>**.


## TComboboxPlus

Die [TComboboxPlus]-Bindings basieren auf denen des Bindtags **TCombobox**, wobei folgende Änderungen vorgenommen wurden:

- Neue Bindings zu **<<Undo>>** und **<<Redo>>**.


# Virtuelles Ereignis <<selection>>

Jedes **widgetPlus**-Widget generiert ein virtuelles Ereignis **<<Selection>>**, sobald sich der Wert seiner Auswahl ändert.  Anderer **Tcl**-Code, zum Beispiel das Paket **persistentSelection**, kann die Auswahl in diesen Widgets verfolgen.

# Verwendung mit Megawidgets

Wenn ein **entry**, **spinbox**, **ttk::entry**, **ttk::spinbox** oder **ttk::combobox** Komponente eines Megawidgets ist, ist es häufig möglich, **widgetPlus** auf diese Komponente anzuwenden, ohne den Code des Megawidgets zu ändern.

## Combobox (von Bryan Oakley)

Ein **combobox** mit dem Pfad **$w** enthält ein Widget **entry** **$w.entry**, das den Bindtag **Entry** benutzt. **widgetPlus** lässt sich nach dem Erzeugen auf das **combobox** anwenden, mit diesem Befehl (siehe [Beispiele])

```
entryPlus $w.entry -undo 1 -maxundo 0
```

## Combobox (BWidget)

Eine **BWidget**-**ComboBox** mit dem Pfad **$w** enthält ein Widget **entry** **$w.e**, das statt des voreingestellten Tags **Entry** den Bindtag **BwEntry** benutzt.

Das Paket **widgetPlus** stellt ein Ersatz-Bindtag **BwEntryPlus** bereit; berechnet wird er beim Laden des Pakets nicht, weil **BWidget** vorher geladen sein muss. **::widgetPlus::EnableBWidget** muss aufgerufen werden, damit **BwEntryPlus** existiert. Danach lässt sich die **BWidget**-**ComboBox** ändern (siehe [Beispiele])

```
::widgetPlus::EnableBWidget
entryPlus $w.e -undo 1 -maxundo 0
```

# Noch zu tun

- Undo und Redo gleichen das *Änderungsflag* nicht ab. Sie setzen den Wert immer auf *boolean* **true**.

- Undo und Redo gleichen die Position des Einfügecursors nicht ab.

- Das Ereignis „**<<Modified>>**“ wird nicht generiert.

- Trennzeichen für Undo und Redo und die Option **-autoseparators**, wie sie im Widget **text** zu finden sind, sind nicht implementiert. Bei jedem Aufruf eines Widget-Befehls (z. B. **insert** oder **delete**), der den Inhalt des Widgets verändert, wird ein implizites Trennzeichen hinzugefügt. Der Befehl **edit separator** hat keine Wirkung.  Die Trennzeichen-Funktionalität wäre für Widgets wie **entryPlus** weniger nützlich als für ein **text**-Widget.

- Ein Modus *overwrite*, umgeschaltet mit **<Insert>** auf Systemen, die nicht macOS® sind.


# Bugs

Diese Version von **widgetPlus** bietet Kompatibilität mit allen Releases von **Tk** 8.5 und 8.6 sowie mit den Zweigen *core-8-5-branch*, *core-8-6-branch* sowie *trunk* im Quellcode-Repository für **Tk**.  Jede Inkompatibilität mit einer dieser Versionen, unabhängig vom verwendeten **Tk**-Fenstersystem, sollte als Fehler gemeldet werden. Bitte melden Sie solche Fehler in der Kategorie *widgetPlus* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist).

# Beispiele

Ein Widget **entryPlus** .ep mit unbegrenztem Undo/Redo-Stapel erzeugen und zuordnen:

```
package require widgetPlus
widgetPlus::entryPlus .ep -undo 1 -maxundo 0
pack .ep
```

Das Gleiche, jedoch unter Verwendung von **namespace import**:

```
package require widgetPlus
namespace import widgetPlus::*
entryPlus .ep -undo 1 -maxundo 0
pack .ep
```

Ein vorhandenes Widget **entry** .ee in ein **entryPlus** mit unbegrenztem Undo/Redo-Stapel umwandeln:

```
entry .ee

    .
    .
    .

package require widgetPlus
widgetPlus::entryPlus .ee -undo 1 -maxundo 0
```

Das Gleiche, jedoch unter Verwendung von **namespace import**:

```
entry .ee

    .
    .
    .

package require widgetPlus
namespace import widgetPlus::*
entryPlus .ee -undo 1 -maxundo 0
```

**widgetPlus** auf eine **combobox** von Bryan Oakley anwenden:

```
package require combobox
combobox::combobox .cb

    .
    .
    .

package require widgetPlus
namespace import widgetPlus::*
entryPlus .cb.entry -undo 1 -maxundo 0
```

**widgetPlus** auf eine **BWidget**-**ComboBox** anwenden. Zuerst **::widgetPlus::EnableBWidget** aufrufen.

```
package require BWidget
ComboBox .cb

    .
    .
    .

package require widgetPlus
::widgetPlus::EnableBWidget
namespace import widgetPlus::*

entryPlus .cb.e -undo 1 -maxundo 0
```

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *widgetPlus* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
