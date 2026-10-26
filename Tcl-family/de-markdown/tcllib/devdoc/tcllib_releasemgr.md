---
CommandName: tcllib_releasemgr
title: tcllib_releasemgr
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription:
Copyright:
---

# Name

tcllib\_releasemgr – Tcllib – Leitfaden für Release-Manager

# Beschreibung

Willkommen bei Tcllib, der Tcl-Standardbibliothek. Beachten Sie, dass Tcllib selbst kein Paket ist. Es handelt sich um eine Sammlung von (teilweise unabhängigen) *Tcl*-Paketen, die Hilfsfunktionen bereitstellen, die für eine große Zahl von Tcl-Programmierern nützlich sind.

Dieses Dokument richtet sich an den Release-Manager von Tcllib, dessen Stellvertreter sowie an alle weiteren Personen, die an der Erstellung einer offiziellen Version von Tcllib zur Verbreitung interessiert sind.

Bitte lesen Sie zunächst *Tcllib – So erhalten Sie die Quellcodes*, falls das noch nicht geschehen ist. Hier wird davon ausgegangen, dass die Quelltexte bereits in einem Verzeichnis der Wahl vorliegen.

# Werkzeuge

Das Skript „*sak.tcl*“ im Toplevel-Verzeichnis eines Tcllib-Checkouts ist das einzige Werkzeug, das der Release-Manager zur Ausführung seiner [Aufgaben] verwendet.

Die wichtigsten Befehle, die verwendet werden sollen, sind

```
    sak.tcl validate
    sak.tcl test run
    sak.tcl review
    sak.tcl readme
    sak.tcl localdoc
    sak.tcl release
```

Weitere Einzelheiten finden Sie in den Erläuterungen zu den verschiedenen [Aufgaben].

# Aufgaben

## Einen Release Candidate starten

Aufgabe: Einen Kandidaten für die Veröffentlichung freigeben

## Den Kandidaten fertigstellen

Aufgaben: Testen, Validierung und Prüfen, ob die Version zur Veröffentlichung geeignet ist; Testsuiten korrigieren, ggf. Pakete korrigieren; Dokumentation neu generieren; sich mit den Paketbetreuern bezüglich der Korrekturen abstimmen; Wichtig: Die Pakete durchgehen und die Änderungen seit der letzten Version klassifizieren, um eine übersichtliche README-Datei zu erstellen.

## Offiziell machen

Aufgabe: Veröffentlichung abschließen, Kandidatenversion offiziell machen

## Das Release verteilen

Nach dem Release muss es veröffentlicht und die Öffentlichkeit über seine Existenz informiert werden.

1. Über <http://core.tcl-lang.org/tcllib/eventedit> ein Fossil-Ereignis für das Release anlegen.

    Als Vorlage dient ein [bestehendes Ereignis](http://core.tcl-lang.org/tcllib/event/dac0ddcd2e990234143196b4dc438fe01e7b9817).

2. Aktualisieren Sie eine Reihe von Webseiten:

    1. [Startseite](http://core.tcl-lang.org/tcllib/doc/trunk/embedded/index.md)

    2. [Downloads](http://core.tcl-lang.org/tcllib/wiki?name=Downloads)

    3. [Frühere Veröffentlichungen](http://core.tcl-lang.org/tcllib/wiki?name=Past+Releases)

    4. <http://www.tcl-lang.org/home/release.txt>

    5. <http://www.tcl-lang.org/software/tcllib/*.tml>

    6. <http://wiki.tcl-lang.org/page/Tcllib>


3. Der erste Speicherort verweist auf die Datei „*embedded/index.md*“ im Repository selbst und kann daher im Rahmen des Release-Prozesses bearbeitet werden. Hier wird der Verweis auf das neue Fossil-Ereignis als aktuelle Version hinzugefügt.

    Die nächsten beiden Speicherorte befinden sich im Fossil-tcllib-Wiki und erfordern Administrator- oder Wiki-Schreibrechte für <http://core.tcl-lang.org/tcllib>.

    Die letzten beiden Speicherorte erfordern SSH-Zugriff auf <http://www.tcl-lang.org> sowie die Berechtigung, Dateien im Webbereich zu bearbeiten.

4. \*\*\*TODO\*\*\* Mailinglisten und andere Plätze, an die Sie Hinweise senden können.
