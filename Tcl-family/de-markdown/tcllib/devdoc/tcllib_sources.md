---
CommandName: tcllib_sources
title: tcllib_sources
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription:
Copyright:
---

# Name

tcllib\_sources – Tcllib – So erhalten Sie die Quellcodes

# Beschreibung

Willkommen bei Tcllib, der Tcl-Standardbibliothek. Beachten Sie, dass Tcllib selbst kein Paket ist. Es handelt sich um eine Sammlung von (teilweise unabhängigen) *Tcl*-Paketen, die Hilfsfunktionen bereitstellen, die für eine große Zahl von Tcl-Programmierern nützlich sind.

Dieses Dokument richtet sich an alle, die sich entweder lediglich den Quellcode von Tcllib ansehen, die Pakete kompilieren oder diese erweitern und anpassen möchten.

Für alle, die die Pakete bauen oder entwickeln, gibt es darüber hinaus:

1. *Tcllib - The Installer's Guide*.

2. *Tcllib – Das Entwicklerhandbuch*,


in dieser Reihenfolge.

# Fundort der Quellen

Das offizielle Repository für Tcllib finden Sie unter <http://core.tcl-lang.org/tcllib>. Dieses Repository wird von [Fossil SCM](http://www.fossil-scm.org) verwaltet.

# Archive für „HEAD“ und Veröffentlichungen abrufen

Am einfachsten geht dies, indem man das [offizielle Repository](http://core.tcl-lang.org/tcllib) aufruft und den Links im Abschnitt *Releases* oben folgt, direkt unterhalb des Eingabefelds für die Suche in der Dokumentation des Pakets.

# Abruf beliebiger Commits

Bei allem, was über den Head-Status und Veröffentlichungen hinausgeht, ist der Prozess etwas aufwendiger.

Wenn die Commit-ID (Commit-Hash) **((ID))** der betreffenden Revision bereits bekannt ist, lassen sich Links zu den gewünschten Archiven in folgender Form bilden:

```
    https://core.tcl-lang.org/tcllib/tarball/((ID))/Tcl+Library+Source+Code.tar.gz
    https://core.tcl-lang.org/tcllib/zip/((ID))/Tcl+Library+Source+Code.zip
```

Beachten Sie, dass für „**((ID))**“ auch Zweignamen verwendet werden können. Das ergibt Archive mit der aktuellsten Revision des genannten Zweigs.

Der Teil der URL nach „**((ID))**“ ist der Name der zurückgegebenen Datei und kann nach Bedarf angepasst werden.

Ohne bekannte Commit-ID dauert der Prozess erneut länger:

1. Das [offizielle Repository](http://core.tcl-lang.org/tcllib) aufrufen.

2. Den Anmeldelink bzw. die Anmeldeschaltfläche in der oberen rechten Ecke der Seite suchen.

3. Als „anonymous“ anmelden, mit dem halbzufälligen Passwort aus dem Captcha.

4. Die „Timeline“ über den Link bzw. die Schaltfläche in der Mitte der Navigationsleiste öffnen.

5. Die gewünschte Revision auswählen.

6. Dem Link zur Seite mit den Einzelheiten folgen.

7. Auf dieser Seite den Link „ZIP“ oder „Tarball“ wählen, um eine Kopie dieser Revision im gewünschten Format zu erhalten.


# Quellcodeverwaltung

Die Quellen werden mit [Fossil SCM](http://www.fossil-scm.org) verwaltet. Binärdateien für gängige Plattformen liegen auf der [Download-Seite](http://www.fossil-scm.org/download.html).

Mit diesem Tool lässt sich die vollständige Geschichte wie folgt abrufen:

```
    fossil clone  http://core.tcl-lang.org/tcllib  tcllib.fossil
```

gefolgt von

```
    mkdir tcllib
    cd tcllib
    fossil open ../tcllib.fossil
```

um einen Checkout des Trunk-Heads durchzuführen.
