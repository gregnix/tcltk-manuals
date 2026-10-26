---
CommandName: message
title: message
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - label(n)
Keywords:
 - message
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

message - Erstellt und manipuliert 'Message'-Widgets für nicht-interaktiven Text

# Übersicht

::: {.synopsis} :::
[message]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standardoptionen

**-anchor**, **-background**, **-borderwidth**, **-cursor**, **-font**, **-foreground**, **-highlightbackground**, **-highlightcolor**, **-highlightthickness**, **-padx**, **-pady**, **-relief**, **-takefocus**, **-text**, **-textvariable**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-aspect** (**aspect**/**Aspect**)
: Legt einen nicht-negativen Ganzzahlwert fest, der das gewünschte Seitenverhältnis für den Text angibt. Das Seitenverhältnis wird als 100*Breite/Höhe angegeben. 100 bedeutet, dass der Text so breit wie hoch sein soll, 200 bedeutet, dass der Text doppelt so breit wie hoch sein soll, 50 bedeutet, dass der Text doppelt so hoch wie breit sein soll usw. Wird verwendet, um die Zeilenlänge für Text zu wählen, wenn die Option **-width** nicht angegeben ist. Standardwert ist 150.

**-justify** (**justify**/**Justify**)
: Legt fest, wie Textzeilen ausgerichtet werden. Muss einer von **left**, **center** oder **right** sein. Standardwert ist **left**. Diese Option wirkt zusammen mit den Optionen **-anchor**, **-aspect**, **-padx**, **-pady** und **-width**, um verschiedene Anordnungen des Textes im Fenster zu ermöglichen. Die Optionen **-aspect** und **-width** bestimmen, wie viel Bildschirmplatz zum Anzeigen des Textes benötigt wird. Die Optionen **-anchor**, **-padx** und **-pady** bestimmen, wo dieser rechteckige Bereich im Fenster des Widgets angezeigt wird, und die Option **-justify** bestimmt, wie jede Zeile innerhalb dieses rechteckigen Bereichs angezeigt wird. Angenommen beispielsweise, **-anchor** ist **e** und **-justify** ist **left**, und das Message-Fenster ist viel größer als für den Text benötigt. Der Text wird so angezeigt, dass die linken Kanten aller Zeilen auf einer Linie liegen und die rechte Kante der längsten Zeile **-padx** vom rechten Rand des Fensters entfernt ist; der gesamte Textblock wird in der vertikalen Spanne des Fensters zentriert.

**-width** (**width**/**Width**)
: Legt die Länge der Zeilen im Fenster fest. Der Wert kann eine der von [Tk\_GetPixels][GetPixels] akzeptierten Formen haben. Wenn diese Option einen Wert größer als null hat, wird die Option **-aspect** ignoriert und die Option **-width** bestimmt die Zeilenlänge. Wenn dieser Optionswert negativ oder null ist, bestimmt die Option **-aspect** die Zeilenlänge.


# Beschreibung

Der Befehl **message** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Message-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte der Message wie Farben, Schriftart, Text und anfängliches Relief zu konfigurieren. Der Befehl **message** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Eine Message ist ein Widget, das einen Text-String anzeigt. Ein Message-Widget hat drei besondere Merkmale, die es von einem [label]-Widget unterscheiden. Erstens teilt es seinen String in Zeilen auf, um ein bestimmtes Seitenverhältnis für das Fenster zu erzeugen. Die Zeilenumbrüche werden nach Möglichkeit an Wortgrenzen gewählt (wenn nicht einmal ein einzelnes Wort in eine Zeile passt, wird das Wort über Zeilen hinweg geteilt). Zeilenumbruchzeichen im String erzwingen Zeilenumbrüche; sie können beispielsweise verwendet werden, um Leerzeilen in der Anzeige zu hinterlassen.

Das zweite Merkmal eines Message-Widgets ist die Ausrichtung. Der Text kann linksbündig angezeigt werden (jede Zeile beginnt am linken Rand des Fensters), zeilenweise zentriert oder rechtsbündig (jede Zeile endet am rechten Rand des Fensters).

Das dritte Merkmal eines Message-Widgets ist, dass Steuerzeichen und nicht druckbare Zeichen besonders behandelt werden. Tabulatorzeichen werden durch genügend Leerzeichen ersetzt, um an der nächsten 8-Zeichen-Grenze ausgerichtet zu sein. Zeilenumbrüche verursachen Zeilenumbrüche. Andere Steuerzeichen (ASCII-Code kleiner als 0x20) und in der Schriftart nicht definierte Zeichen werden als vierzeichenige Sequenz **\x***hh* angezeigt, wobei *hh* die zweistellige hexadezimale Zahl ist, die dem Zeichen entspricht. Im ungewöhnlichen Fall, dass die Schriftart nicht alle Zeichen in „0123456789abcdef\x" enthält, werden Steuerzeichen und undefinierte Zeichen überhaupt nicht angezeigt.

# Widget-Befehl

Der Befehl **message** erstellt einen neuen Tcl-Befehl, dessen Name *pathName* ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Die folgenden Befehle sind für Message-Widgets möglich:

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **message** akzeptierten Werte haben.

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe [Tk\_ConfigureInfo][ConfigWidg] für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **message** akzeptierten Werte haben.


# Standard-Bindings

Wenn eine neue Message erstellt wird, hat sie keine Standard-Event-Bindings: Messages sind nur für Ausgabe-Zwecke gedacht.

# Fehler

Tabulatoren funktionieren nicht sehr gut mit zentriertem oder rechtsbündigem Text. Das häufigste Ergebnis ist, dass die Zeile falsch ausgerichtet wird.


[ConfigWidg]: ../tk-c/ConfigWidg.md
[GetPixels]: ../tk-c/GetPixels.md
[label]: label.md
[options]: options.md
