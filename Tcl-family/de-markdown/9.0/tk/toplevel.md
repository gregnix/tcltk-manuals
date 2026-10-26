---
CommandName: toplevel
title: toplevel
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bind(n)
 - bindtags(n)
 - frame(n)
 - wm(n)
Keywords:
 - toplevel
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

toplevel - Erstellt und manipuliert Haupt- und Popup-Fenster vom Typ 'toplevel'

# Übersicht

::: {.synopsis} :::
[toplevel]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standardoptionen

**-borderwidth**, **-highlightcolor**, **-pady**, **-cursor**, **-highlightthickness**, **-relief**, **-highlightbackground**, **-padx**, **-takefocus**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-background** (**background**/**Background**)
: Diese Option ist identisch mit der Standard-Option **-background**, außer dass ihr Wert auch als leerer String angegeben werden kann. In diesem Fall zeigt das Widget keinen Hintergrund oder Rahmen an, und es werden keine Farben aus seiner Farbkarte für Hintergrund und Rahmen verbraucht. [Ein leerer Hintergrund deaktiviert das Zeichnen des Hintergrundbildes.]{version="9.0, TIP262"}

[**-backgroundimage** (**backgroundImage**/**BackgroundImage**)]{version="9.0, TIP262"}
: [Bild, das im Hintergrund des Toplevel innerhalb des Rahmens angezeigt wird (das Bild wird durch Hervorhebungsring und Rahmen des Toplevel abgeschnitten, falls vorhanden); Unter-Widgets werden darüber gezeichnet. Das Bild muss mit [image create][image] erstellt worden sein. Als leerer String: kein Bild.]{version="9.0, TIP262"}

**-class** (**class**/**Class**)
: Klasse des Fensters. Wird bei Abfragen der Optionsdatenbank und später z. B. für Bindings verwendet. Manche Window-Manager zeigen den Klassennamen im Dock, andere den Fenstertitel. **-class** kann nicht mit **configure** geändert werden.

**-colormap** (**colormap**/**Colormap**)
: Farbkarte für das Fenster: **new** (neue Farbkarte für Fenster und Kinder) oder Name eines anderen Fensters (gleicher Bildschirm, gleiche Visualisierung wie *pathName*); dann nutzt das neue Fenster dessen Farbkarte. Ohne Angabe: Standard-Farbkarte des Bildschirms. Nicht mit **configure** änderbar.

**-container** (**container**/**Container**)
: Wert muss ein Boolean sein. Ist er wahr, dient das Fenster als Container für eine eingebettete Anwendung (z. B. Tk-Toplevel mit **-use**). Das Fenster unterstützt die passenden Window-Manager-Protokolle (z. B. Geometrie). In dieser Anwendung sollte das Fenster keine eigenen Kinder haben. Nicht mit **configure** änderbar.

**-height** (**height**/**Height**)
: Legt die gewünschte Höhe für das Fenster in einer der von [Tk\_GetPixels][GetPixels] akzeptierten Formen fest. Wenn diese Option negativ oder null ist, fordert das Fenster überhaupt keine Größe an.

**-menu** ([menu]/**Menu**)
: Menü-Widget als Menüleiste. Auf dem Macintosh über den gesamten Hauptmonitor; unter Windows und UNIX in der Fensterdekoration des Toplevel.

**-screen**
: Bildschirm für das neue Fenster. Jeder gültige Bildschirmname, auch eines anderen Displays. Standard: gleicher Bildschirm wie das Eltern-Element. Speziell: nicht über die Optionsdatenbank setzbar, nicht mit **configure** änderbar.

**-tile** (**tile**/**Tile**)
: [Legt fest, wie das Hintergrundbild (siehe **-backgroundimage**) gezeichnet wird. Ist der Wert wahr ([Tcl\_GetBoolean][GetInt]), wird das Bild gekachelt, Ursprung der ersten Kopie oben links im Innenraum des Toplevel. Standard falsch: Bild zentriert.]{version="9.0, TIP262"}

**-use** (**use**/**Use**)
: Für Einbettung. Ist der Wert nicht leer, muss er die Fenster-ID eines Container-Fensters sein (hexadezimal wie von [winfo id][winfo]). Das Toplevel wird Kind dieses Containers statt des Root-Fensters des Bildschirms. Liegt der Container in einer Tk-Anwendung, muss es ein frame- oder toplevel-Widget mit gesetzter Option **-container** sein. Nicht mit **configure** änderbar.

**-visual** (**visual**/**Visual**)
: Visuelle Informationen in allen von [Tk\_GetVisual][GetVisual] akzeptierten Formen. Ohne Angabe: Standard-Visual des Bildschirms. **-visual** nicht mit **configure** änderbar.

**-width** (**width**/**Width**)
: Gewünschte Breite in allen von [Tk\_GetPixels][GetPixels] akzeptierten Formen. Negativ oder null: keine Größenanforderung.


# Beschreibung

Der Befehl **toplevel** erstellt ein neues Toplevel-Widget (*pathName*). Weitere Optionen können in der Befehlszeile oder Optionsdatenbank gesetzt werden (Hintergrund, Relief usw.). **toplevel** liefert den Pfadnamen des neuen Fensters.

Ein Toplevel ähnelt einem [frame], wird aber als Top-Level-Fenster erzeugt: sein X-Eltern-Element ist das Root-Fenster eines Bildschirms, nicht das logische Eltern-Element aus dem Tk-Pfadnamen. Hauptzweck: Container für Dialoge und Widget-Sammlungen. Sichtbar sind im Wesentlichen Hintergrund und optional ein 3D-Rahmen (erhaben/eingesenkt).

# Widget-Befehl

**toplevel** erzeugt einen neuen Tcl-Befehl mit dem Namen des Fensterpfads. Form:

```
pathName option ?arg ...?
```

*PathName* ist der Befehlsname (gleich dem Toplevel-Pfad). *Option* und *arg* bestimmen das Verhalten. Für Toplevel-Widgets möglich:

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Aktueller Wert der Konfigurationsoption *option* (alle vom Befehl **toplevel** akzeptierten Werte).

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Konfigurationsoptionen abfragen oder ändern. Ohne *option*: Liste aller Optionen (Format siehe [Tk\_ConfigureInfo][ConfigWidg]). Nur *option*: Liste für diese eine Option. Mit *option-value*-Paaren: Optionen setzen, leerer String als Rückgabe. *option*: alle von **toplevel** akzeptierten Werte.


# Bindings

Beim Erzeugen eines neuen Toplevel gibt es keine Standard-Bindings; Toplevels sind nicht für Interaktion gedacht.

Bindings auf Toplevels können Ereignisse von Unter-Widgets erhalten.


[ConfigWidg]: ../tk-c/ConfigWidg.md
[frame]: frame.md
[GetInt]: ../tcl-c/GetInt.md
[GetPixels]: ../tk-c/GetPixels.md
[GetVisual]: ../tk-c/GetVisual.md
[image]: image.md
[menu]: menu.md
[options]: options.md
[winfo]: winfo.md
