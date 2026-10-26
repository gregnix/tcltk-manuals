---
CommandName: menubutton
title: menubutton
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - ttk::menubutton(n)
 - menu(n)
Keywords:
 - menubutton
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

menubutton - Erstellt und manipuliert Menubutton-Widgets für Popup-Menüs

# Übersicht

::: {.synopsis} :::
[menubutton]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standardoptionen

**-activebackground**, **-disabledforeground**, **-padx**, **-activeforeground**, **-font**, **-pady**, **-anchor**, **-foreground**, **-relief**, **-background**, **-highlightbackground**, **-takefocus**, **-bitmap**, **-highlightcolor**, **-text**, **-borderwidth**, **-highlightthickness**, **-textvariable**, **-cursor**, **-image**, **-underline**, **-compound**, **-justify**, **-wraplength**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-direction** (**direction**/**Direction**)
: Gibt an, wo das Menü geöffnet wird. **above** öffnet oberhalb des Menubuttons, **below** darunter, **left** links, **right** rechts, [flush] direkt über dem Menubutton. Bei **above** oder **below** wird die Richtung umgekehrt, wenn das Menü sonst außerhalb des Bildschirms läge.

**-height** (**height**/**Height**)
: Gewünschte Höhe des Menubuttons. Bei Bild oder Bitmap in Bildschirmeinheiten (Formen von [Tk\_GetPixels][GetPixels]); bei Text in Textzeilen. Ohne Angabe: Höhe aus angezeigtem Bild/Bitmap/Text.

**-indicatoron** (**indicatorOn**/**IndicatorOn**)
: Muss ein gültiger boolescher Wert sein. Ist er wahr, wird rechts ein kleines Indikator-Rechteck gezeichnet und die Standard-Menü-Bindings behandeln den Menubutton als Options-Menubutton. Ist er falsch, wird kein Indikator angezeigt.

**-menu** ([menu]/**MenuName**)
: Pfadname des zugehörigen Menüs. Das Menü muss ein Kind des Menubuttons sein.

**-state** (**state**/**State**)
: Einer von drei Zuständen: **normal**, **active** oder **disabled**. Im Zustand **normal** Anzeige mit **foreground** und **background**. **active** typischerweise bei Maus über dem Widget, mit **-activeforeground** und **-activebackground**. **disabled**: Widget unempfindlich; Standard-Bindings aktivieren es nicht und ignorieren Mausklicks; **-disabledforeground** und **-background** bestimmen die Darstellung.

**-width** (**width**/**Width**)
: Gewünschte Breite. Bei Bild/Bitmap in Bildschirmeinheiten (Formen von [Tk\_GetPixels][GetPixels]); bei Text in Zeichen. Ohne Angabe: Breite aus angezeigtem Inhalt.


# Beschreibung

Der Befehl **menubutton** erstellt ein neues Fenster (*pathName*) und macht es zu einem Menubutton-Widget. Weitere Optionen können in der Befehlszeile oder Optionsdatenbank gesetzt werden (Farben, Schrift, Text, anfängliches Relief). **menubutton** liefert *pathName*. Beim Aufruf darf kein Fenster *pathName* existieren; das Eltern-Element muss existieren.

Ein Menubutton zeigt Text, Bitmap oder Bild und ist mit einem Menü-Widget verknüpft. Text in einer Schrift, mehrzeilig möglich (Zeilenumbrüche oder **-wraplength**); ein Zeichen kann mit **-underline** unterstrichen werden. Üblicherweise öffnet Maustaste 1 das zugehörige Menü unter dem Menubutton. Wird die Maus vor dem Loslassen über das Menü bewegt, wird der Eintrag unter dem Cursor aufgerufen; danach wird das Menü geschlossen.

Menubuttons bilden [tk\_optionMenu][optionMenu] — auf macOS die bevorzugte Auswahl aus einer Liste.

Früher wurden Menubuttons zu Menüleisten gruppiert (Scanning): Bleibt die Taste gedrückt und die Maus wechselt zu einem anderen Menubutton derselben Leiste, schließt sich das erste Menü und das neue öffnet sich. *Diese Nutzung ist veraltet*; stattdessen [menu] direkt als Menüleiste setzen (Option **-menu** von [toplevel]).

Wechselwirkungen zwischen Menubuttons und Menüs: siehe [menu] (Pulldown-, Options-Menüs usw.).

# Widget-Befehl

**menubutton** erzeugt einen Tcl-Befehl *pathName* mit folgender Form:

```
pathName option ?arg ...?
```

*Option* und *arg* bestimmen das Verhalten. Für Menubutton-Widgets möglich:

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Aktueller Wert der Konfigurationsoption *option* (alle von **menubutton** akzeptierten Werte).

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Optionen abfragen oder ändern. Ohne *option*: Liste aller Optionen (siehe [Tk\_ConfigureInfo][ConfigWidg]). Nur *option*: Liste für diese Option. Mit *option-value*-Paaren: Optionen setzen, leerer String als Rückgabe. *option*: alle von **menubutton** akzeptierten Werte.


# Standard-Bindings

Tk legt Klassen-Bindings für Menubuttons an:

1. Aktivierung bei Maus über dem Widget, Deaktivierung beim Verlassen.

2. Maustaste 1 über einem Menubutton öffnet ihn (Relief erhaben) und postet das Menü darunter. Wird bei gedrückter Taste ins Menü gezogen und dort losgelassen, schließt sich der Menubutton und der Eintrag wird aufgerufen.

3. Taste 1 drücken und auf demselben Menubutton loslassen: Menubutton bleibt geöffnet; Maus über Menü, Klick auf Eintrag zum Aufruf; danach schließt sich der Menubutton.

4. Taste 1 auf einem Menubutton, Ziehen zu anderem Menubutton: erster schließt sich, zweiter öffnet sich.

5. Taste 1 auf Menubutton, Loslassen außerhalb von Menubutton/Menü: schließen ohne Aufruf.

6. Geöffneter Menubutton: zugehöriges Menü übernimmt Eingabefokus für Tastatur-Navigation (siehe [menu]).

7. Mit **-underline**: Alt+*x* (*x* = unterstrichenes Zeichen oder Groß-/Kleinschreibung) in jedem Fenster unter dem Toplevel des Menubuttons öffnet ihn.

8. F10 in jedem Fenster öffnet den ersten nicht deaktivierten Menubutton unter dessen Toplevel.

9. Hat der Menubutton den Fokus, öffnen Leertaste und Return ihn.


Ist der Zustand **disabled**, trifft nichts davon zu — der Menubutton reagiert nicht.

Das Verhalten lässt sich durch neue Bindings pro Widget oder durch Neudefinition der Klassen-Bindings ändern.


[ConfigWidg]: ../tk-c/ConfigWidg.md
[flush]: ../tcl/flush.md
[GetPixels]: ../tk-c/GetPixels.md
[menu]: menu.md
[optionMenu]: optionMenu.md
[options]: options.md
[toplevel]: toplevel.md
