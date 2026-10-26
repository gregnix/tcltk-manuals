---
CommandName: tkvars
title: tkvars
ManualSection: n
Version: 4.1
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - package(n)
 - tclvars(n)
 - wish(1)
Keywords:
 - environment
 - text
 - variables
 - version
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

geometry, tk\_library, tk\_patchLevel, tk::scalingPct, tk\_strictMotif, tk::svgFmt, tk\_version - Von Tk verwendete oder gesetzte Variablen

# Beschreibung

Die folgenden Tcl-Variablen werden von Tk zu verschiedenen Zeitpunkten während der Ausführung gesetzt oder verwendet:

**tk\_library**
: Diese Variable enthält den Dateinamen eines Verzeichnisses mit einer Bibliothek von Tcl-Skripten, die mit Tk zusammenhängen. Diese Skripte umfassen eine Initialisierungsdatei, die normalerweise bei jedem Start einer Tk-Anwendung verarbeitet wird, sowie weitere Dateien mit Prozeduren, die Standardverhalten für Widgets implementieren.

    Der Anfangswert von **tk\_library** wird gesetzt, wenn Tk einem Interpreter hinzugefügt wird; dazu werden mehrere Verzeichnisse durchsucht, bis eines gefunden wird, das ein passendes Tk-Startskript enthält. Existiert die Umgebungsvariable **TK\_LIBRARY**, wird das von ihr benannte Verzeichnis zuerst geprüft. Ist **TK\_LIBRARY** nicht gesetzt oder verweist nicht auf ein passendes Verzeichnis, prüft Tk weitere Verzeichnisse anhand eines kompilierten Standardorts, des Tcl-Bibliotheksverzeichnisses, des Speicherorts der Binärdatei der Anwendung und des aktuellen Arbeitsverzeichnisses.

    Die Variable kann von einer Anwendung geändert werden, um zu einer anderen Bibliothek zu wechseln.

**tk\_patchLevel**
: Enthält eine durch Punkte getrennte Folge von Dezimalzahlen mit dem aktuellen Patch-Level von Tk. Der Patch-Level wird bei jeder neuen Veröffentlichung oder jedem Patch erhöht und identifiziert eindeutig eine offizielle Tk-Version.

    Dieser Wert entspricht normalerweise dem Ergebnis von „[package require][package] **tk**“.

**tk::scalingPct**
: Tk setzt diese Variable bei der Initialisierung auf den Skalierungsprozentsatz, der dem DPI-Skalierungsniveau des Displays entspricht. Der Wert ist mindestens 100 und auf Vielfache von 25 beschränkt (100, 125, 150, 175, 200, 225, …). Die Größen und verschiedenen Attribute der Tk-Kern- und Ttk-Widgets sowie ihrer Komponenten und die Größen der von Tk verwendeten Bilder werden nach diesem Skalierungsprozentsatz gewählt; dasselbe wird für Anwendungen und Bibliothekspakete empfohlen.

    Jeder Zugriff auf diese Variable soll ausschließlich schreibgeschützt sein! Wird der Skalierungsfaktor zur Umrechnung zwischen physikalischen Einheiten und Pixeln über **tk scaling** geändert, wird der Wert von **tk::scalingPct** automatisch aktualisiert.

    Unter den Fenstersystemen **win32** und **aqua** wird der Skalierungsprozentsatz berechnet, indem \[**tk scaling**\] \* 75 auf das nächste Vielfache von 25 gerundet wird, das mindestens 100 ist. (Unter **aqua** ist das Ergebnis immer 100; die Desktop-Engine skaliert alles bei Bedarf automatisch.) Unter **x11** wird die Ableitung aus \[**tk scaling**\] nur als Fallback genutzt, weil die Display-Skalierung stark vom Desktop abhängt und meist Systemressourcen außerhalb von Xlib manipuliert, auf dem Tk basiert. Aus technischen Gründen kann der Wert von **tk::scalingPct** von der Systemeinstellung abweichen (z. B. 200 statt 125, 150 oder 175 unter GNOME auf Xorg oder Cinnamon). Unter **x11** wird der Prozentsatz überwiegend (nicht ausschließlich) aus der X-Ressource Xft.dpi ermittelt; Tk synchronisiert anschließend den Umrechnungsfaktor mit dem Prozentsatz mittels **tk scaling**.

**tk\_strictMotif**
: Diese Variable ist standardmäßig null. Setzt eine Anwendung sie auf eins, versucht Tk, den Motif-Look-and-Feel-Standards so weit wie möglich zu entsprechen. Aktive Elemente wie Buttons und Scrollbar-Schieberegler ändern z. B. ihre Farbe nicht, wenn der Mauszeiger darüber fährt. Moderne Anwendungen sollten diese Variable normalerweise nicht setzen.

**tk::svgFmt**
: Diese Variable wird bei der Tk-Initialisierung gesetzt auf

    \[**list svg -scale** \[[expr] {$**tk::scalingPct** / 100.0}\]\]

    Typische Werte sind {**svg -scale** 1.0}, {**svg -scale** 1.25}, {**svg -scale** 2.0} usw. Es wird empfohlen, den Wert dieser Variable den Befehlen **image create photo**, *imageName* **configure**, *imageName* **put** und *imageName* [read] als Wert ihrer Option **-format** zu übergeben, wenn SVG-Bilder erzeugt oder bearbeitet werden, damit ihre Größen dem DPI-Skalierungsniveau des Displays entsprechen.

    Jeder Zugriff auf diese Variable soll ausschließlich schreibgeschützt sein! Wird der Skalierungsfaktor zur Umrechnung zwischen physikalischen Einheiten und Pixeln über **tk scaling** geändert, wird der Wert von **tk::svgFmt** automatisch aktualisiert.

**tk\_version**
: Tk setzt diese Variable im Interpreter jeder Anwendung. Sie enthält die aktuelle Versionsnummer der Tk-Bibliothek in der Form *major*.*minor*. *Major* und *minor* sind Ganzzahlen. Die Hauptversionsnummer steigt bei jeder Tk-Veröffentlichung mit nicht abwärtskompatiblen Änderungen (wenn bestehende Tk-Anwendungen und Skripte angepasst werden müssen). Die Nebenversionsnummer steigt bei jeder neuen Tk-Veröffentlichung und wird auf null zurückgesetzt, wenn sich die Hauptversionsnummer ändert.


## Interne und Debug-Variablen

Diese Variablen sollten normalerweise nicht vom Anwendungscode gesetzt werden.

**tk::Priv**
: Diese Variable ist ein Array mit mehreren für Tk private Informationen. Die Elemente von **tk::Priv** werden von Tk-Bibliotheksprozeduren und Standard-Bindings verwendet. Sie dürfen von keinem Code außerhalb von Tk zugegriffen werden.

**tk\_textRedraw**
: siehe unten ...

**tk\_textRelayout**
: Diese Variablen werden von Text-Widgets gesetzt, wenn Debugging eingeschaltet ist. Die in diese Variablen geschriebenen Werte können zum Testen oder Debuggen von Text-Widget-Operationen verwendet werden. Sie werden überwiegend von Tks Test-Suite genutzt.


# Weitere globale Variablen

Die folgenden Variablen sind nur in [wish]-Programmen garantiert vorhanden; die Tk-Bibliothek definiert sie selbst nicht, aber viele Tk-Umgebungen tun es.

**geometry**
: Falls gesetzt, enthält sie die vom Benutzer vorgegebene Geometriespezifikation für das Haupt-Tk-Fenster.


[expr]: ../tcl/expr.md
[package]: ../tcl/package.md
[read]: ../tcl/read.md
[wish]: wish.md
