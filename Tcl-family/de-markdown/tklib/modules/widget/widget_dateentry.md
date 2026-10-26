---
CommandName: widget_dateentry
ManualSection: n
Version: 0.99
TclPart: tklib
TclDescription: Various megawidgets
Keywords:
 - date
 - dateentry
 - megawidget
 - snit
 - widget
Copyright:
---

# NAME

widget_dateentry – Dateentry-Megawidget

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [widget]{.lit} [3.0]{.optlit} 
[package]{.cmd} [require]{.sub} [widget::dateentry]{.lit} [0.99]{.optlit} 
[widget::dateentry]{.cmd} [pathname]{.arg} [options]{.optarg} 
[pathname]{.ins} [get]{.sub} 
[pathname]{.ins} [set]{.sub} [date]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt ein Dateentry-Megawidget (snidget) bereit. Es basiert auf einem ttk::entry. Alle Widget-Befehle des ttk::entry stehen für das Dateentry zur Verfügung.

**widget::dateentry** *pathname* ?options?
: 


# WIDGET-OPTIONEN

**-command**
: Ein Befehlspräfix, das ausgewertet wird, wenn ein Datum ausgewählt wurde. Das Befehlspräfix wird im globalen Namespace ausgeführt und erhält zwei Argumente: das Rohdatum in Sekunden sowie das formatierte Datum gemäß der Option **-dateformat**.

**-dateformat**
: Das Format des Datums, das eingegeben oder zurückgegeben wird. Standard: %m/%d/%Y.

**-firstday**
: Siehe die Handbuchseite **widget::calendar**.

**-font**
: Wählt die im Widget verwendete Schriftart. Die Vorgabe ist Helvetica 9.

**-highlightcolor**
: Siehe die Handbuchseite **widget::calendar**. Siehe die Handbuchseite calendar.

**-language**
: Siehe die Handbuchseite **widget::calendar**.

**-shadecolor**
: Siehe die Handbuchseite **widget::calendar**.

**-showpast**
: Siehe die Handbuchseite **widget::calendar**.

**-textvariable**
: Legt den Namen einer Variablen fest, deren Wert mit dem Inhalt des Entry-Widgets verknüpft ist. Ändert sich der Wert der Variablen, wird der Inhalt des Widgets aktualisiert, und umgekehrt.


# WIDGET-BEFEHL

*pathname* **get**
: Gibt das ausgewählte Datum zurück.

*pathname* **set** *date*
: Legt programmgesteuert ein neues Datum fest. Es wird davon ausgegangen, dass das Datum dasselbe Format aufweist, wie es durch die Option **-dateformat** konfiguriert wurde. Der gleiche Effekt lässt sich auch durch die Einstellung einer verknüpften Option **-textvariable** erzielen.


# STANDARD-BINDINGS

Beim Erstellen des Widgets dateentry werden die folgenden Bindings eingerichtet. Zur Navigation im Kalender siehe dessen Handbuchseite.

**•**
: Button-1 – Auswahl übernehmen, das Datum auswählen und das Kalenderfenster schließen.

**•**
: Return, space – Das ausgewählte Datum übernehmen und das Kalenderfenster schließen

**•**
: Escape – Kalenderfenster schließen

**•**
: Control-space – Kalenderfenster anzeigen


# BEISPIEL

```
    package require widget::dateentry; # or widget::all
    set t [widget::dateentry .de]
    pack $t -fill x -expand 1
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *widget::dateentry* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# KATEGORIE

Widget
