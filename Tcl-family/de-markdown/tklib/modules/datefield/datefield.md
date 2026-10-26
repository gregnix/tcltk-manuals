---
CommandName: datefield
ManualSection: n
Version: 0.3
TclPart: tklib
TclDescription: Tk datefield widget
Links:
 - clock(n)
 - entry(n)
Keywords:
 - clock
 - date
 - dateentry
 - entry
 - widget
Copyright:
 - Copyright (c) Keith Vetter <keith@ebook.gemstar.com>
 - Copyright (c) Thomas Wunderlich <tcl.tk@blindenfreizeiten.de>
---

# NAME

datefield – Tk-Widget „datefield“

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tk]{.lit} 
[package]{.cmd} [require]{.sub} [datefield]{.lit} [0.3]{.optlit} 
[::datefield::datefield]{.cmd} [widgetpath]{.arg} [options]{.optarg} 
:::

*-format*

# BESCHREIBUNG

Das Paket **datefield** stellt das Widget datefield bereit, ein erweitertes Entry-Widget zur Eingabe von Datumswerten. Für die eingebbaren Daten gibt es drei zulässige Formate:

**\[1\]**
: Englische Form MM/DD/YYYY mit *-format "%m/%d/%Y"* (Vorgabe)

**\[2\]**
: Deutsche Form DD.MM.YYYY mit *-format "%d.%m.%Y"*

**\[3\]**
: ISO-Form YYYY-MM-DD mit *-format "%Y-%m-%d"* Das Widget datefield ist tatsächlich nur ein Entry-Widget mit besonderen Bindungen. Alle Befehle und Optionen eines Entry-Widgets gelten hier ebenso.


# BEFEHLE

**::datefield::datefield** *widgetpath* ?*options*?
: Erstellt und konfiguriert ein Datumsfeld-Widget.


# OPTIONEN

*-format*
: Eines von "%m/%d/%Y" (englisch, Vorgabe, wenn die Option weggelassen wird), "%d.%m.%Y" (deutsch) oder "%Y-%m-%d" (ISO). Die übrigen verfügbaren Optionen stehen in der Handbuchseite **entry**.


# BEISPIEL

```
 package require datefield

 wm title . "Datefield example"
 proc DayOfWeek {args} {
     set now [clock scan $::myDate]
     set ::myDate2 [clock format $now -format %A]
 }
 trace variable myDate w DayOfWeek

 ::datefield::datefield .df -textvariable myDate -format "%m/%d/%Y"
 label .l1 -text "Enter a date:"   -anchor e
 label .l2 -text "That date is a:" -anchor e
 label .l3 -textvariable myDate2 -relief sunken -width 12

 grid .l1 .df -sticky ew
 grid .l2 .l3 -sticky ew
 focus .df
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *datefield* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# KATEGORIE

Widget

# COPYRIGHT

```
Copyright (c) Keith Vetter <keith@ebook.gemstar.com>
Copyright (c) Thomas Wunderlich <tcl.tk@blindenfreizeiten.de>
```
