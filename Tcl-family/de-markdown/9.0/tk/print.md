---
CommandName: tk
ManualSection: print
Version: n
TclPart: 
TclDescription: Tk
Links:
 - canvas(n)
 - text(n)
 - tk(n)
Keywords:
 - print
 - output
 - graphics
 - text
 - canvas
Copyright:
 - Copyright (c) 2021 Kevin Walzer.
---

# NAME

print - Canvas- und Text-Widgets mit nativen Dialogen und APIs drucken

# ÜBERSICHT

::: {.synopsis} :::
[tk]{.cmd} [print]{.sub} [window]{.arg} . 
:::

# BESCHREIBUNG

Der Befehl **tk print** öffnet einen Dialog, mit dem Benutzer die Ausgabe von **canvas**- und **text**-Widgets drucken können. Der Druck erfolgt, wo verfügbar, über plattformnative APIs und Dialoge.

Das **canvas**-Widget unterstützt seit langem PostScript-Export; sowohl PostScript- als auch Textdateien können auf Unix-ähnlichen Systemen direkt mit den Unix-Befehlen „lp“ und „lpr“ an einen Drucker gesendet werden. Der Befehl **tk print** ersetzt diese Funktionalität nicht, sondern baut darauf auf. **tk print** ist eine vollständigere Implementierung, die auf macOS und Windows native Dialoge nutzt und auf X11 einen Tk-basierten Dialog mit vergleichbarer Funktionalität bereitstellt.

# PLATTFORMHINWEISE

**macOS**
: Die Mac-Implementierung verwendet native Druckdialoge und stützt sich auf das darunterliegende Common Unix Printing System (CUPS), um Textausgabe aus dem Text-Widget und die PDF-Konvertierung der Canvas-Daten an den Drucker oder in eine PDF-Datei zu rendern.

**Windows**
: Die Windows-Implementierung basiert auf der GDI-API (Graphics Device Interface). Da GDI und das Tk-**canvas**-Widget Grafik leicht unterschiedlich darstellen, kann die gedruckte Canvas-Ausgabe unter Windows von der Bildschirmdarstellung abweichen.

**X11**
: Die X11-Implementierung nutzt eine Tk-GUI zur Konfiguration von Druckaufträgen, die per „lpr“ oder „lp“ oder über die API des Common Unix Printing System (CUPS) an einen Drucker gesendet werden, wenn libcups installiert ist. Diese Befehle haben viele Parameter zur Druckauftragskonfiguration; Drucker unterstützen sie jedoch sehr unterschiedlich. Daher werden nur Druckerauswahl und Anzahl der Kopien als Argumente des print-Befehls konfiguriert; viele Aspekte der Druckdarstellung (z. B. Graustufen oder Farbe für das Canvas) werden stattdessen bei der PostScript-Erzeugung eingestellt.

