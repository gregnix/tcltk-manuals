---
CommandName: tkvars
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

# NAME

geometry, tk_library, tk_patchLevel, tk_strictMotif, tk_version - Von Tk verwendete oder gesetzte Variablen

# BESCHREIBUNG

Die folgenden Tcl-Variablen werden von Tk zu verschiedenen Zeitpunkten während der Ausführung gesetzt oder verwendet:

**tk_library**
: Diese Variable enthält den Dateinamen eines Verzeichnisses mit einer Bibliothek von Tcl-Skripten, die mit Tk zusammenhängen. Diese Skripte umfassen eine Initialisierungsdatei, die normalerweise bei jedem Start einer Tk-Anwendung verarbeitet wird, sowie weitere Dateien mit Prozeduren, die Standardverhalten für Widgets implementieren.
    Der Anfangswert von **tk_library** wird gesetzt, wenn Tk einem Interpreter hinzugefügt wird; dazu werden mehrere Verzeichnisse durchsucht, bis eines gefunden wird, das ein passendes Tk-Startskript enthält. Existiert die Umgebungsvariable **TK_LIBRARY**, wird das von ihr benannte Verzeichnis zuerst geprüft. Ist **TK_LIBRARY** nicht gesetzt oder verweist nicht auf ein passendes Verzeichnis, prüft Tk weitere Verzeichnisse anhand eines kompilierten Standardorts, des Tcl-Bibliotheksverzeichnisses, des Speicherorts der Binärdatei der Anwendung und des aktuellen Arbeitsverzeichnisses.
    Die Variable kann von einer Anwendung geändert werden, um zu einer anderen Bibliothek zu wechseln.

**tk_patchLevel**
: Enthält eine durch Punkte getrennte Folge von Dezimalzahlen mit dem aktuellen Patch-Level von Tk. Der Patch-Level wird bei jeder neuen Veröffentlichung oder jedem Patch erhöht und identifiziert eindeutig eine offizielle Tk-Version.
    Dieser Wert entspricht normalerweise dem Ergebnis von „**package require** **Tk**“.

**tk_strictMotif**
: Diese Variable ist standardmäßig null. Setzt eine Anwendung sie auf eins, versucht Tk, den Motif-Look-and-Feel-Standards so weit wie möglich zu entsprechen. Aktive Elemente wie Buttons und Scrollbar-Schieberegler ändern z. B. ihre Farbe nicht, wenn der Mauszeiger darüber fährt. Moderne Anwendungen sollten diese Variable normalerweise nicht setzen.

**tk_version**
: Tk setzt diese Variable im Interpreter jeder Anwendung. Sie enthält die aktuelle Versionsnummer der Tk-Bibliothek in der Form *major*.*minor*. *Major* und *minor* sind Ganzzahlen. Die Hauptversionsnummer steigt bei jeder Tk-Veröffentlichung mit nicht abwärtskompatiblen Änderungen (wenn bestehende Tk-Anwendungen und Skripte angepasst werden müssen). Die Nebenversionsnummer steigt bei jeder neuen Tk-Veröffentlichung und wird auf null zurückgesetzt, wenn sich die Hauptversionsnummer ändert.


## Interne und Debug-Variablen

Diese Variablen sollten normalerweise nicht vom Anwendungscode gesetzt werden.

**tk::Priv**
: Diese Variable ist ein Array mit mehreren für Tk private Informationen. Die Elemente von **tk::Priv** werden von Tk-Bibliotheksprozeduren und Standard-Bindings verwendet. Sie dürfen von keinem Code außerhalb von Tk zugegriffen werden.

**tk_textRedraw**
: ...siehe nächstes...

**tk_textRelayout**
: Diese Variablen werden von Text-Widgets gesetzt, wenn Debugging eingeschaltet ist. Die in diese Variablen geschriebenen Werte können zum Testen oder Debuggen von Text-Widget-Operationen verwendet werden. Sie werden überwiegend von Tks Test-Suite genutzt.


# Weitere globale Variablen

Die folgenden Variablen sind nur in **wish**-Programmen garantiert vorhanden; die Tk-Bibliothek definiert sie selbst nicht, aber viele Tk-Umgebungen tun es.

**geometry**
: Falls gesetzt, enthält sie die vom Benutzer vorgegebene Geometriespezifikation für das Haupt-Tk-Fenster.

