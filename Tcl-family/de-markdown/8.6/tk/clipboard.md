---
CommandName: clipboard
title: clipboard
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - interp(n)
 - selection(n)
Keywords:
 - clear
 - format
 - clipboard
 - append
 - selection
 - type
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

clipboard - Bearbeitet die Tk-Zwischenablage

# Übersicht

::: {.synopsis} :::
[clipboard]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Dieser Befehl stellt eine Tcl-Schnittstelle zur Tk-Zwischenablage bereit. Die Zwischenablage speichert Daten, die später über den Auswahlmechanismus (mit der Option **-selection CLIPBOARD**) abgerufen werden können. Um Daten in die Zwischenablage zu kopieren, muss zuerst **clipboard clear** aufgerufen werden, gefolgt von einem oder mehreren Aufrufen von **clipboard append**. Damit die Zwischenablage atomar aktualisiert wird, sollten alle Anhängevorgänge abgeschlossen sein, bevor die Kontrolle an die Ereignisschleife zurückgeht.

Das erste Argument von **clipboard** bestimmt das Format der übrigen Argumente und das Verhalten des Befehls. Derzeit werden die folgenden Formen unterstützt:

**clipboard append** ?**-displayof** *window*? ?**-format** *format*? ?**-type** *type*? ?**--**? *data*
: Hängt *data* an die Zwischenablage auf dem Display von *window* an, und zwar in der durch *type* gegebenen Form mit der durch *format* gegebenen Darstellung. Außerdem übernimmt der Befehl den Besitz der Zwischenablage auf dem Display von *window*.

    *type* legt fest, in welcher Form die Auswahl zurückgegeben werden soll (das gewünschte „Ziel“ der Umwandlung, in der Terminologie des ICCCM). Der Wert sollte ein Atomname wie **STRING** oder **FILE\_NAME** sein; alle Einzelheiten finden Sie im Inter-Client Communication Conventions Manual. Die Voreinstellung für *type* ist **STRING**.

    Das Argument *format* legt die Darstellung fest, in der die Auswahl an den Anforderer übertragen werden soll (die zweite Spalte von Tabelle 2 des ICCCM). Die Voreinstellung ist **STRING**. Ist *format* **STRING**, wird die Auswahl als 8-Bit-ASCII-Zeichen übertragen. Ist *format* **ATOM**, wird *data* in durch Leerraum getrennte Felder aufgeteilt. Jedes Feld wird in seinen Atomwert umgewandelt, und statt des Atomnamens wird der 32-Bit-Atomwert übertragen. Bei jedem anderen *format* wird *data* in durch Leerraum getrennte Felder aufgeteilt, und jedes Feld wird in eine 32-Bit-Ganzzahl umgewandelt; an den Anforderer der Auswahl wird ein Array von Ganzzahlen übertragen. Beachten Sie, dass die an **clipboard append** übergebenen Zeichenketten vor der Umwandlung verkettet werden. Der Aufrufer muss also selbst für passende Abstände an den Grenzen zwischen den Zeichenketten sorgen. Alle Elemente, die mit demselben *type* an die Zwischenablage angehängt werden, müssen dasselbe *format* haben.

    Das Argument *format* wird nur für die Kompatibilität mit Anforderern der Zwischenablage benötigt, die nicht Tk verwenden. Wird die Auswahl **CLIPBOARD** mit dem Tk-Toolkit abgerufen, wird der Wert auf der anfordernden Seite wieder in eine Zeichenkette umgewandelt; *format* spielt dann keine Rolle.

    Ein Argument **--** kann angegeben werden, um das Ende der Optionen zu markieren: Das nächste Argument wird dann immer als *data* verwendet. Das kann praktisch sein, wenn *data* zum Beispiel mit einem **-** beginnt.

**clipboard clear** ?**-displayof** *window*?
: Übernimmt den Besitz der Zwischenablage auf dem Display von *window* und entfernt alle bisherigen Inhalte. Die Voreinstellung für *window* ist „.“. Gibt eine leere Zeichenkette zurück.

**clipboard get** ?**-displayof** *window*? ?**-type** *type*?
: Ruft Daten aus der Zwischenablage auf dem Display von *window* ab. Die Voreinstellung für *window* ist „.“. *type* legt fest, in welcher Form die Daten zurückgegeben werden sollen, und sollte ein Atomname wie **STRING** oder **FILE\_NAME** sein. Die Voreinstellung für *type* ist **STRING**. Dieser Befehl entspricht „[selection get][selection] **-selection CLIPBOARD**“.

    Beachten Sie, dass auf modernen X11-Systemen der nützlichste Typ zum Abrufen übertragener Zeichenketten nicht **STRING** ist, sondern **UTF8\_STRING**.


# Beispiele

Den aktuellen Inhalt der Zwischenablage abrufen.

```
if {[catch {clipboard get} contents]} {
    # There were no clipboard contents at all
}
```

Die Zwischenablage auf eine feste Zeichenkette setzen.

```
clipboard clear
clipboard append "some fixed string"
```

Mit einer eigenen Option **-type** können Sie eigene Daten in die Zwischenablage legen. Das ist nicht unbedingt portierbar, kann aber sehr nützlich sein. Tcl-Skripte auf diese Weise zu übergeben ist wirksam, sollte in Produktionscode aber mit sicheren Interpretern kombiniert werden.

```
# This is a very simple canvas serializer;
# it produces a script that recreates the item(s) when executed
proc getItemConfig {canvas tag} {
   set script {}
   foreach item [$canvas find withtag $tag] {
      append script {$canvas create } [$canvas type $item]
      append script { } [$canvas coords $item] { }
      foreach config [$canvas itemconf $item] {
         lassign $config name - - - value
         append script [list $name $value] { }
      }
      append script \n
   }
   return [string trim $script]
}

# Set up a binding on a canvas to cut and paste an item
set c [canvas .c]
pack $c
$c create text 150 30 -text "cut and paste me"
bind $c <<Cut>> {
   clipboard clear
   clipboard append -type TkCanvasItem \
         [getItemConfig %W current]
   # Delete because this is cut, not copy.
   %W delete current
}
bind $c <<Paste>> {
   catch {
      set canvas %W
      eval [clipboard get -type TkCanvasItem]
   }
}
```


[selection]: selection.md
