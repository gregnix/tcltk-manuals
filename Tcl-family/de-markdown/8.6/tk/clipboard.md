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

clipboard - Tk-Zwischenablage steuern

# Übersicht

::: {.synopsis} :::
[clipboard]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Dieser Befehl bietet eine Tcl-Schnittstelle zur Tk-Zwischenablage, die Daten für spätere Abfrage über die Selection-Mechanismen speichert (Option **-selection CLIPBOARD**). Zum Kopieren: zuerst **clipboard clear**, dann eine oder mehrere **clipboard append**-Aufrufe. Für atomare Updates alle Appends vor der Rückkehr in die Ereignisschleife abschließen.

Das erste Argument von **clipboard** legt Format der weiteren Argumente und Verhalten fest. Unterstützt werden:

**clipboard append** ?**-displayof** *window*? ?**-format** *format*? ?**-type** *type*? ?**--**? *data*
: Hängt *data* an die Zwischenablage auf dem Display von *window* an, in der Form *type* mit Darstellung *format*, und beansprucht die Zwischenablage auf diesem Display.

    *Type* ist die Rückgabeform der Selection (ICCCM-„target“), z. B. **STRING** oder **FILE\_NAME**; Details im Inter-Client Communication Conventions Manual. Standard **STRING**.

    *format* ist die Übertragungsdarstellung (ICCCM Tabelle 2, Spalte 2), Standard **STRING**. Bei **STRING**: 8-Bit-ASCII. Bei **ATOM**: *data* in Felder durch Leerzeichen geteilt, jedes Feld zum Atom-Wert, 32-Bit-Atom-Wert statt Name. Sonst: Felder zu 32-Bit-Integer, Array an den Anforderer. Strings an **clipboard append** werden vor der Konvertierung verkettet — passende Trennung beachten. Gleicher *type* erfordert gleichen *format*.

    *format* nur für Nicht-Tk-Anforderer nötig; bei Tk-Abfrage der **CLIPBOARD**-Selection wird am Ende wieder ein String geliefert — *format* irrelevant.

    **--** markiert Optionenende: nächstes Argument ist immer *data* (z. B. wenn *data* mit **-** beginnt).

**clipboard clear** ?**-displayof** *window*?
: Beansprucht die Zwischenablage auf dem Display von *window* und entfernt frühere Inhalte. *window* standardmäßig „.“. Leerer String als Rückgabe.

**clipboard get** ?**-displayof** *window*? ?**-type** *type*?
: Daten aus der Zwischenablage auf dem Display von *window*. *window* standardmäßig „.“. *type* z. B. **STRING** oder **FILE\_NAME**, Standard **STRING**. Entspricht „[selection get][selection] **-selection CLIPBOARD**“.

    Auf modernen X11-Systemen für Text oft **UTF8\_STRING** statt **STRING** sinnvoller.


# Beispiele

Aktuellen Zwischenablage-Inhalt lesen:

```
if {[catch {clipboard get} contents]} {
    # There were no clipboard contents at all
}
```

Zwischenablage mit festem String setzen:

```
clipboard clear
clipboard append "some fixed string"
```

Eigene Daten per **-type** (nicht unbedingt portabel, aber nützlich). Tcl-Skripte so zu übergeben ist wirksam; in Produktion mit Safe-Interpretern kombinieren.

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
