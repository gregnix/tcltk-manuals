---
CommandName: tk
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - busy(n)
 - fontchooser(n)
 - send(n)
 - winfo(n)
Keywords:
 - application name
 - send
Copyright:
 - Copyright (c) 1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

tk - Internen Tk-Zustand manipulieren

# ÜBERSICHT

::: {.synopsis} :::
[tk]{.cmd} [option]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **tk** bietet Zugriff auf verschiedene Elemente des internen Tk-Zustands. Die meisten durch diesen Befehl manipulierten Informationen betreffen die Anwendung als Ganzes oder einen Bildschirm bzw. ein Display, nicht ein bestimmtes Fenster. Je nach dem Argument *option* kann der Befehl verschiedene Formen annehmen. Die zulässigen Formen sind:

**tk appname** ?*newName*?
: Wenn *newName* nicht angegeben ist, gibt dieser Befehl den Namen der Anwendung zurück (den Namen, der in **send**-Befehlen zur Kommunikation mit der Anwendung verwendet werden kann). Wenn *newName* angegeben ist, wird der Anwendungsname in *newName* geändert. Ist der angegebene Name bereits vergeben, wird ein Suffix der Form " **#2**" oder " **#3**" angehängt, um den Namen eindeutig zu machen. Das Ergebnis des Befehls ist der tatsächlich gewählte Name. *newName* sollte nicht mit einem Großbuchstaben beginnen. Das stört die Optionsverarbeitung, da Namen mit Großbuchstaben als Klassen gelten; dadurch kann Tk ggf. einige Optionen der Anwendung nicht finden. Wurden Sends durch Löschen des Befehls **send** deaktiviert, aktiviert dieser Befehl sie wieder und erstellt **send** neu.

**tk busy** *subcommand* ...
: Dieser Befehl steuert die Markierung von Fensterhierarchien als „busy“, wodurch sie während einer anderen Operation nicht interaktiv sind. Weitere Details siehe die Manpage **busy**.

**tk caret** *window* ?**-x** *x*? ?**-y** *y*? ?**-height** *height*?
: Legt die Caret-Position für die Anzeige des angegebenen Tk-Fensters *window* fest und fragt sie ab. Der Caret ist die pro-Display-Cursorposition zur Anzeige des globalen Fokus (z. B. gemäß Microsoft-Barrierefreiheitsrichtlinien) sowie zur Position von Over-the-Spot-XIM- (X Input Methods) oder Windows-IME-Fenstern. Wenn keine Optionen angegeben sind, werden die zuletzt zum Setzen des Carets verwendeten Werte im Options-Wert-Paar-Format zurückgegeben. **-x** und **-y** sind fensterrelative Koordinaten; **-height** ist die Höhe der aktuellen Cursorposition oder die Höhe des angegebenen *window*, falls keine angegeben ist.

**tk inactive** ?**-displayof** *window*? ?**reset**?
: Gibt eine positive Ganzzahl zurück: die Anzahl der Millisekunden seit der letzten Benutzerinteraktion mit dem System. Wenn die Option **-displayof** angegeben ist, bezieht sich der Rückgabewert auf das Display von *window*; andernfalls auf das Display des Hauptfensters der Anwendung.
    **tk inactive** gibt -1 zurück, wenn die Abfrage der Benutzer-Inaktivitätszeit vom System nicht unterstützt wird, sowie in sicheren Interpretern.
    Wird die Literalzeichenkette **reset** als zusätzliches Argument übergeben, wird der Timer zurückgesetzt und eine leere Zeichenkette zurückgegeben. Das Zurücksetzen der Inaktivitätszeit ist in sicheren Interpretern verboten und löst bei einem Versuch einen Fehler aus.

**tk fontchooser** *subcommand* ...
: Steuert den Tk-Schriftartauswahldialog. Weitere Details siehe die Manpage **fontchooser**.

**tk scaling** ?**-displayof** *window*? ?*number*?
: Legt den aktuellen Skalierungsfaktor fest und fragt ihn ab, mit dem Tk zwischen physikalischen Einheiten (z. B. Punkte, Zoll oder Millimeter) und Pixeln umrechnet. Das Argument *number* ist eine Gleitkommazahl und gibt die Anzahl der Pixel pro Punkt auf dem Display von *window* an. Wenn das Argument *window* weggelassen wird, gilt das Hauptfenster. Wenn *number* weggelassen wird, wird der aktuelle Wert des Skalierungsfaktors zurückgegeben.
    Ein „Punkt“ ist eine Maßeinheit von 1/72 Zoll. Ein Skalierungsfaktor von 1,0 entspricht 1 Pixel pro Punkt, was einem Standard-72-dpi-Monitor entspricht. Ein Skalierungsfaktor von 1,25 bedeutet 1,25 Pixel pro Punkt, die Einstellung für einen 90-dpi-Monitor; die Einstellung 1,25 auf einem 72-dpi-Monitor würde alles in der Anwendung 1,25-mal so groß wie normal darstellen. Der Anfangswert des Skalierungsfaktors wird beim Start der Anwendung anhand der Eigenschaften des installierten Monitors gesetzt, kann aber jederzeit geändert werden. Messungen nach einer Änderung des Skalierungsfaktors verwenden den neuen Faktor; ob bestehende Widgets sich dynamisch an den neuen Skalierungsfaktor anpassen, ist undefiniert.

**tk useinputmethods** ?**-displayof** *window*? ?*boolean*?
: Legt fest und fragt ab, ob Tk XIM (X Input Methods) zum Filtern von Ereignissen verwenden soll. Der resultierende Zustand wird zurückgegeben. XIM wird in einigen Locales (z. B. Japanisch, Koreanisch) für spezielle Eingabegeräte verwendet. Diese Funktion ist nur unter X relevant. Wenn XIM-Unterstützung nicht verfügbar ist, wird immer 0 zurückgegeben. Wenn das Argument *window* weggelassen wird, gilt das Hauptfenster. Wenn *boolean* weggelassen wird, wird der aktuelle Zustand zurückgegeben. Für das Hauptdisplay ist dies standardmäßig eingeschaltet.

**tk windowingsystem**
: Gibt das aktuelle Tk-Fenstersystem zurück, eines von **x11** (X11-basiert), **win32** (MS Windows) oder **aqua** (macOS Aqua).

