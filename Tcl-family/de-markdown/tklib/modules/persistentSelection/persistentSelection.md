---
CommandName: persistentSelection
title: persistentSelection
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Enhanced PRIMARY selection
Links:
 - bindtags
 - ntext
 - text
 - widgetPlus
Copyright:
---

# Name

persistentSelection – Erweiterte PRIMARY-Auswahl

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [persistentSelection]{.lit} [1.0]{.optlit}
[persistentSelection::fixText]{.cmd}
[persistentSelection::getClassicPrimarySel]{.cmd} [displayOf]{.optarg} [withOthers]{.optarg}
[persistentSelection::getPrimarySel]{.cmd} [displayOf]{.optarg}
[persistentSelection::report]{.cmd} [type]{.arg} [pathName]{.arg}
:::

# Beschreibung

Nehmen wir ein **Tk**-Widget, das seine Option **-exportselection** auf den booleschen Wert **true** setzt und dadurch seine Auswahl exportiert.  Wenn die Auswahl im Widget aufgehoben wird, hebt **Tk** standardmäßig auch die Auswahl **PRIMARY** auf.  In dieser Situation schlägt ein Versuch, die Auswahl **PRIMARY** auszulesen – beispielsweise durch ein **<<PasteSelection>>**-Ereignis – fehl.

Das Paket „**persistentSelection**“ bietet ein komfortableres Verhalten. Es behält – wie bei der Auswahl „**PRIMARY**“ – den letzten nicht leeren Wert bei, der von einem der von ihm überwachten „**Tk**“-Widgets gesetzt wurde, solange die Auswahl „**PRIMARY**“ nicht von einem anderen Prozess oder von einem Widget beansprucht wird, das es nicht überwacht.

Das Paket „**persistentSelection**“ funktioniert, indem es eine Bindung an das Ereignis „**<<Selection>>**“ der betreffenden Widgets herstellt und diese Bindung nutzt, um jede Änderung der Auswahl im Widget zu überwachen.  Seine Befehle sind auf den Namespace **::persistentSelection** beschränkt.

# Befehle

**persistentSelection::fixText**
: Einmal aufrufen, um Probleme mit **text**-Widgets zu beheben, die den voreingestellten Bindtag **Text** benutzen und nicht **Ntext**. Die Erklärung steht unter [Text-Widgets].

    Der Befehl passt einige **Text**-Bindings so an, dass **<<Selection>>**-Ereignisse generiert werden; und ordnet die Aufrufe des Befehls **tag** für das **text**-Widget im privaten Befehl **::tk::TextSelectTo** neu an, damit dieser Befehl besser mit **persistentSelection** zusammenarbeitet.

    Diese Anpassungen sind nur bei älteren Versionen von **Tk** erforderlich.  Der Befehl **persistentSelection::fixText** hat bei ausreichend aktuellen Versionen keine Auswirkungen. Er kann bei jeder Version von **Tk** bedenkenlos aufgerufen werden.

**persistentSelection::getClassicPrimarySel** ?*displayOf*? ?*withOthers*?
: - *displayOf* – ein **Tk**-Fensterpfad auf dem abzufragenden Display (optional, voreingestellt {**.**})

    - *withOthers* – Gibt an, ob die Auswahl „**PRIMARY**“ zurückgegeben werden soll, wenn sie einem anderen Prozess oder Interpreter gehört (optional, boolescher Wert, Standardwert: **false**)


    Ein Befehl, der die klassische (nicht persistente) Form der Auswahl „**PRIMARY**“ gibt. Wenn die Auswahl nicht existiert oder ausschließlich durch „**persistentSelection**“ aufrechterhalten wird, gibt der Befehl die leere Zeichenkette zurück.

**persistentSelection::getPrimarySel** ?*displayOf*?
: - *displayOf* – ein **Tk**-Fenster auf dem abzufragenden Display (optional, voreingestellt {**.**})


    Ein Befehl, der den Wert der Auswahl „**PRIMARY**“ gibt. Wenn die Auswahl nicht existiert, gibt der Befehl die leere Zeichenkette zurück. Die üblichen „**Tk**“-Befehle sind zwar durchaus gültig, lösen jedoch einen Fehler aus, wenn die Auswahl nicht existiert.

**persistentSelection::report** *type* *pathName*
: - *type* – (Wert **text** oder **entry**) Einordnung des Widgets, dessen Auswahl sich geändert hat

    - *pathName* – der **Tk**-Fensterpfad des Widgets, dessen Auswahl sich geändert hat


    Damit das Paket **persistentSelection** ein Widget überwacht, muss dieser Befehl an das Ereignis **<<Selection>>** dieses Widgets gebunden werden.  Der Befehl erfasst Änderungen an der Auswahl des Widgets und nutzt diese Informationen, um auf jedem Display eine nicht leere **PRIMARY**-Auswahl zu halten.


# Verwendung

## Anforderungen an das Skript

Für jedes Widget, das von **persistentSelection** überwacht werden soll, muss der Befehl **persistentSelection::report** in einem der Bindungs-Tags des Widgets an das Ereignis **<<Selection>>** gebunden werden.

Beispielsweise möchte der Entwickler möglicherweise **persistentSelection** mit jedem **text**- und **entryPlus**-Widget in einer Anwendung verwenden: Dies lässt sich erreichen, indem die Bindung „**<<Selection>>**“ zu den Bindings „**Text**“ und „**EntryPlus**“ hinzugefügt wird.  Siehe [Beispiele].

Wenn **persistentSelection** nicht für alle Widgets einer bestimmten Klasse erforderlich ist, kann die Bindung den Bindtags der einzelnen Widgets hinzugefügt werden. Siehe [Beispiele].

## Anforderungen an Widgets

Damit ein Widget von **persistentSelection** überwacht werden kann, muss es drei Bedingungen erfüllen:

- Es muss über die Option „**-exportselection**“ verfügen, die es ermöglicht, die aktuelle Auswahl in die Auswahl „**PRIMARY**“ zu exportieren.

- Es muss bei jeder Änderung der Auswahl ein Ereignis vom Typ „**<<Selection>>**“ auslösen.

- Die Bindungen zu anderen Ereignissen sollten angemessen sein – insbesondere in Versionen von **Tk**, die älter sind als **8.6.6**, sollte ein GUI-Ereignis, das die Auswahl von einem nicht leeren Wert auf einen anderen erweitert oder einschränkt, keinen Zwischenzustand mit einer leeren Auswahl verwenden, weil das **persistentSelection** verwirrt.


Die **Tk**- und **Ttk**-Widgets, die ihre Auswahl exportieren können, sind **text**, **entry**, **listbox**, **spinbox**, **ttk::entry**, **ttk::spinbox** und **ttk::combobox**.

## Text-Widgets

In Versionen von **Tk**, die älter sind als **8.6.9**, löst das **text**-Widget in einigen „Sonderfällen“, in denen sich seine Auswahl ändert, keine **<<Selection>>**-Ereignisse aus.  Diese Auslassungen lassen sich durch Änderungen an den **Text**-Bindings beheben, um die zweite Bedingung der [Anforderungen an Widgets] zu erfüllen.

Zudem verarbeiten Versionen von **Tk**, die älter sind als **8.6.6**, Ereignisse der Auswahl etwas anders als neuere Versionen, und in Kombination mit den **Text**-Bindungen verwirrt das **persistentSelection**.  Wenn ein Upgrade auf die aktuelle Version von **Tcl/Tk** nicht möglich ist, lässt sich dieses Problem durch eine geringfügige Anpassung der Widget-Bindungen beheben, um die dritte Anforderung der [Anforderungen an Widgets] zu erfüllen.

Entweder sollte das Skript den Befehl „**persistentSelection::fixText**“ aufrufen, um die **Text**-Bindings und die von diesen aufgerufenen Befehle anzupassen; oder das Widget kann anstelle des standardmäßigen Bindings **Text** das Binding-Tag **Ntext** (für **ntext** Version 1.0 oder höher) verwenden.

In beiden Fällen soll das Argument *type* für **persistentSelection::report** den Wert **text** haben.

## Die Widgets entry, spinbox, ttk::entry, ttk::spinbox und ttk::combobox

Die Widgets **entry**, **spinbox**, **ttk::entry**, **ttk::spinbox** und **ttk::combobox** erzeugen kein **<<Selection>>**-Ereignis, wenn sich ihre Auswahl ändert, und müssen daher angepasst werden.

Das Paket **widgetPlus** stellt jeweils die **snit**-Wrapper **widgetPlus::entryPlus**, **widgetPlus::spinboxPlus**, **widgetPlus::ttkEntryPlus**, **widgetPlus::ttkSpinboxPlus** und **widgetPlus::ttkComboboxPlus** bereit.  Jedes **widgetPlus**-Widget generiert die erforderlichen **<<Selection>>**-Ereignisse.

In all diesen Fällen sollte das an den Befehl **persistentSelection::report** übergebene Argument *type* den Wert **entry** haben.  Dieses Argument legt fest, wie **persistentSelection** die Auswahl des Widgets überprüft, und die Befehle, die dies tun, sind für alle diese Widgets identisch.

## Listbox-Widgets

Für das Widget „**listbox**“, bei dem die Auswahl mehrerer Elemente möglich ist, wurde kein entsprechender Wrapper erstellt.

# Noch zu tun

- Auf einem System mit mehreren Displays prüfen.


# Bugs

Diese Version von **persistentSelection** bietet Kompatibilität mit allen Ausgaben von **Tk** 8.5- und 8.6 sowie mit den Zweigen *core-8-5-branch*, *core-8-6-branch*, *revised\_text* und *trunk* im Quellcode-Repository von **Tk**. Jede Unverträglichkeit mit einer dieser Versionen, für jedes Fenstersystem von **Tk**, ist als Fehler zu melden. Bitte melden Sie solche Fehler in der Kategorie *persistentSelection* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist).

# Beispiele

In jedem Beispiel wird „**persistentSelection**“ verwendet, um den letzten nicht leeren Wert der Auswahl in bestimmten Widgets beizubehalten. Jedes Beispiel umfasst zudem die Erstellung von Beispiel-Widgets.

Alle Widgets **entryPlus** überwachen.

```
package require widgetPlus
widgetPlus::entryPlus .ep
pack .ep

package require persistentSelection
bind EntryPlus <<Selection>> {::persistentSelection::report entry %W}
```

Alle **text**-Widgets überwachen, die die voreingestellten Bindings **Text** benutzen.

```
text .t
pack .t

package require persistentSelection
::persistentSelection::fixText
bind Text <<Selection>> {::persistentSelection::report text %W}
```

Alle **text**-Widgets mit den voreingestellten Bindings **Text** und alle Widgets **entryPlus** überwachen.

```
text .t
pack .t

package require widgetPlus
widgetPlus::entryPlus .ep
pack .ep

package require persistentSelection
::persistentSelection::fixText
bind Text <<Selection>> {::persistentSelection::report text %W}
bind EntryPlus <<Selection>> {::persistentSelection::report entry %W}
```

Alle **text**-Widgets überwachen, die Bindings **Ntext** benutzen.

```
text .t
pack .t

package require ntext
bindtags .t {.t Ntext . all}

package require persistentSelection
bind Ntext <<Selection>> {::persistentSelection::report text %W}
```

Ein einzelnes Widget **entryPlus** **.ep** überwachen.

```
package require widgetPlus
widgetPlus::entryPlus .ep
pack .ep

package require persistentSelection
bind .ep <<Selection>> {::persistentSelection::report entry %W}
```

Ein einzelnes **text**-Widget **.t** überwachen.

```
text .t
pack .t

package require persistentSelection
bind .t <<Selection>> {::persistentSelection::report text %W}
```
