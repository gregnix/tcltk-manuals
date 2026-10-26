---
CommandName: shtmlview
title: shtmlview
ManualSection: n
Version: 1.1.2
TclPart: tklib
TclDescription: Basic HTML and Markdown viewer widget
Links:
 - text
Keywords:
 - html
 - text
 - widget
Copyright:
 - Copyright (c) 2018-2022, Detlef Groth <detlef(at)dgroth(dot)de>
 - Copyright (c) 2009, Robert Heller
 - Copyright (c) 2000, Clif Flynt
 - Copyright (c) 1995-1999, Stephen Uhler
---

# Name

shtmlview – Erweitertes Tcl/Tk-Text-Widget mit grundlegender Unterstützung für die Darstellung von HTML und Markdown

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tk]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [Markdown]{.lit} [;#]{.lit} [optional]{.lit} [Markdown]{.lit} [support]{.lit}
[package]{.cmd} [require]{.sub} [img::jpeg]{.lit} [;#]{.lit} [optional]{.lit} [jpeg]{.lit} [image]{.lit} [support]{.lit}
[package]{.cmd} [require]{.sub} [shtmlview::shtmlview]{.lit} [1.1.2]{.optlit}
[::shtmlview::converter]{.cmd} [extension]{.arg} [description]{.arg} [cmdprefix]{.arg}
[::shtmlview::shtmlview]{.cmd} [pathName]{.arg} [options]{.optarg}
[pathName]{.ins} [back]{.sub}
[pathName]{.ins} [browse]{.sub} [filename]{.arg} [args]{.optarg}
[pathName]{.ins} [dosearch]{.sub} [string]{.arg} [direction]{.arg}
[pathName]{.ins} [edittext]{.sub} [cmd]{.arg} [options]{.optarg}
[pathName]{.ins} [editView]{.sub}
[pathName]{.ins} [forward]{.sub}
[pathName]{.ins} [getFiles]{.sub}
[pathName]{.ins} [getHistory]{.sub}
[pathName]{.ins} [getEditWidget]{.sub}
[pathName]{.ins} [getTextWidget]{.sub}
[pathName]{.ins} [helptext]{.sub} [cmd]{.arg} [options]{.optarg}
[pathName]{.ins} [home]{.sub}
[pathName]{.ins} [open]{.sub}
[pathName]{.ins} [reload]{.sub}
[pathName]{.ins} [render]{.sub} [text]{.arg} [ext]{.optarg}
[pathName]{.ins} [sourceView]{.sub}
[pathName]{.ins} [url]{.sub}
:::

# Beschreibung

Das Paket **shtmlview::shtmlview** stellt ein reines Tcl/Tk-Widget mit dem gleichen Namen bereit, um einfache HTML- und Markdown-Dateien sowie Zeichenfolgen zu rendern und anzuzeigen.

Ein kurzer historischer Rückblick: Das Widget basiert auf der Bibliothek **htmllib**, die in den 90er Jahren von Stephen Uhler und Clif Flynt entwickelt wurde. Im Jahr 2009 integrierte Robert Heller diese Bibliothek in den hervorragenden Megawidget-Rahmen **snit**. Das daraus resultierende Widget war jedoch direkt in ein Hilfesystem eingebunden. Der Verfasser dieses Dokuments hat zunächst lediglich den Anzeigeteil isoliert und anschließend einige Funktionen hinzugefügt, wie beispielsweise die Änderung der Schriftgröße und einige Schaltflächen in der Symbolleiste. Später wurde eine rudimentäre Darstellung von Datentabellen hinzugefügt. Noch später wurden Unterstützung für Inline-Bilder, erweiterte Tastenkombinationen sowie Markdown-Unterstützung integriert.

Das Widget ist *kein* Webbrowser. Es unterstützt ausschließlich relative Links im lokalen Dateisystem. Es unterstützt *keine* Stylesheets. Es unterstützt weder HTTP(S)-Links noch Bilder. Es ist als letzte Ausweichmöglichkeit gedacht, die in Fällen genutzt werden soll, in denen keine anderen Möglichkeiten bestehen, HTML- oder Markdown-Markup aus einer Tk-Anwendung heraus anzuzeigen.

Anwendungsfälle sind der Hilfe-Viewer sowie alle Fälle, in denen der Entwickler die Kontrolle über die verwendeten HTML-Tags hat.

Kommentare und Rückmeldungen sind willkommen.

Das Widget **shtmlview::shtmlview** überlädt das Text-Widget und bietet neue Befehle und Optionen. Diese werden in den Abschnitten [Widget-Befehle] und [Widget-Optionen] erläutert.

Hinweis: Die Datei „*shtmlview.tcl*“ ist nicht nur ein Paket, sondern auch eine eigenständige Anwendung zur direkten Anzeige von Markdown- und HTML-Dateien. Aufruf:

```
 tclsh shtmlview.tcl filename.html
```

in einem Terminal.

Die in diesem Dokument beschriebene API stellt nicht die gesamte API dar, die vom snit-Objekt **::shtmlview::shtmlview** bereitgestellt wird. Vielmehr handelt es sich um eine Teilmenge dieser API, bei der davon ausgegangen wird, dass sie sich in zukünftigen Versionen nicht ändern wird.

# Befehle

**::shtmlview::converter** *extension* *description* *cmdprefix*
: Registriert ein Konvertierungspräfix (*cmdprefix*) für Dateien mit der *extension*. Die *description* ist eine kurze Zusammenfassung der Dateien, die diese Erweiterung tragen sollen.

    Das Ergebnis des Befehls ist die leere Zeichenkette.

    Stößt ein shtmlview-Widget auf eine Datei mit dieser *extension*, ruft es das registrierte Präfix mit einem Argument auf, dem Pfad der zu konvertierenden Datei. Der Aufruf soll das HTML liefern, das dargestellt wird.

    Ein Beispiel steht im Abschnitt [Erweiterungen].

**::shtmlview::shtmlview** *pathName* ?*options*?
: Erzeugt und konfiguriert das shtmlview-Widget *pathName*.

    Das Ergebnis des Befehls ist der *pathName*.

    Ein Fehler entsteht, wenn für *pathName* schon ein Widget besteht.

    Ein Fehler entsteht auch, wenn das Eltern-Widget von *pathName* nicht besteht.

    Die erkannten Optionen stehen im Abschnitt [Widget-Optionen].

    Die Methoden des neuen Widgets stehen im Abschnitt [Widget-Befehle].


# Widget-Optionen

Die Methode **helptext** konfiguriert das interne Text-Widget.

**-browsecmd** cmd
: Jedes Mal, wenn eine HTML- oder Markdown-Seite gerendert wird, wird der angegebene Befehl *cmd* aufgerufen. Die aktuelle URL wird als erstes Argument an den Befehl angehängt.

**-closebutton** boolean
: Wenn **true** (Standard) eingestellt ist, wird in der Symbolleiste eine Schaltfläche zum Schließen angezeigt. Dies ist nützlich, wenn das Widget das einzige untergeordnete Element eines Toplevel-Fensters ist.

**-historycombo** boolean
: Ist der Wert **true** und ist das Paket **tile** vorhanden, kommt eine **ttk::combobox** für den Seitenverlauf in die Symbolleiste. Voreinstellung ist **false**. Die Option lässt sich nur beim Erzeugen des Widgets setzen.

**-home** string
: Legt den Dateinamen der Startseite des Widgets fest. Falls dieser nicht festgelegt wird, wird die erste aufgerufene Seite automatisch als Startseite festgelegt.

**-tablesupport** boolean
: Wenn **true** (Standard) eingestellt ist, wird eine gewisse Unterstützung für Tabellen bereitgestellt. Dies führt zu unerwünschten Ergebnissen, wenn Tabellen-Tags als Markup-Werkzeug missbraucht werden. Einfache HTML-Tabellen mit den Tags **th** und **td** sollten jedoch korrekt dargestellt werden, sofern innerhalb dieser Tags kein internes Markup verwendet wird.

**-toolbar** boolean
: Wenn **true** (Standard) eingestellt ist, wird oben eine Symbolleiste angezeigt. Die Symbolleiste enthält Standardschaltflächen für die Methoden **back**, **forward** und **home** sowie Suchfunktionen. Standardmäßig ist **true** eingestellt.


# Widget-Befehle

Jedes mit dem oben genannten Befehl erstellte shtmlview-Widget unterstützt die folgenden Befehle und Optionen:

*pathName* **back**
: Zeigt die vorherige HTML- und Markdown-Seite im Browserverlauf an, sofern vorhanden.

*pathName* **browse** *filename* ?args?
: Zeigt den HTML- oder Markdown-Text der genannten Datei. Weitere Argumente sind ebenfalls Dateinamen und kommen nur auf den Verlaufsstapel. Die Verlaufstasten **f** und **b** gehen sie durch.

*pathName* **dosearch** *string* *direction*
: Sucht die angegebene Zeichenkette ab dem aktuellen Index in der angegebenen Richtung und hebt sie hervor. Die Richtung ist **forward** (Voreinstellung) oder **backwards**.

*pathName* **edittext** *cmd* ?*options*?
: Legt das interne Texteditor-Widget zur Konfiguration offen. Beispiel:

    ```
        ::shtmlview::shtmlview .help
        .help browse index.md
        .help editView
        .help edittext configure -background salmon
    ```

*pathName* **editView**
: Wechselt das Widget von der Anzeige zur Bearbeitung. In diesem Modus lässt sich die geladene Datei ändern. Die nicht bearbeitbare Quellansicht ist **sourceView** weiter unten.

    ```
        ::shtmlview::shtmlview .help
        .help browse index.md
        .help editView
    ```

*pathName* **forward**
: Zeigt die nächste HTML- oder Markdown-Seite im Browserverlauf an, sofern vorhanden.

*pathName* **getFiles**
: Gibt die Liste aller besuchten Dateien zurück. Doppelte Einträge und Ankerlinks entfallen aus den Rohdaten.

*pathName* **getHistory**
: Gibt die aktuelle Verlaufsliste der besuchten Dateien und Anker zurück.

*pathName* **getEditWidget**
: Gibt den internen Pfadnamen des Texteditor-Widgets zurück, mit dem das aktuelle Dokument bearbeitet wird. Damit lässt sich direkt darauf zugreifen. Das ist gefährlich. Siehe auch **edittext** weiter oben.

*pathName* **getTextWidget**
: Gibt den internen Pfadnamen des internen Text-Widgets der Anzeige zurück. Damit lässt sich direkt darauf zugreifen. Das ist gefährlich. Siehe auch **helptext** weiter unten.

*pathName* **helptext** *cmd* ?*options*?
: Legt das interne Text-Widget der Anzeige zur Konfiguration offen. Beispiel:

    ```
        ::shtmlview::shtmlview .help
        .help browse index.html
        .help helptext configure -background yellow
    ```

*pathName* **home**
: Zeigt entweder die durch die Option **-home** festgelegte Seite oder die erste Seite an, für die **browse** aufgerufen wurde.

*pathName* **open**
: Verwendet einen Standard-Datei-Öffnen-Dialog, um ein Dokument in einem der unterstützten Formate zur Anzeige auszuwählen, und rendert diese Datei anschließend, wenn vorhanden.

*pathName* **reload**
: Lädt die aktuell angezeigte Seite neu und zeigt sie erneut an.

*pathName* **render** *text* ?ext?
: Stellt den angegebenen *text* in der Anzeige dar. Ist eine Erweiterung *ext* angegeben, gilt die Zeichenkette als in dem zugehörigen Format, und der zugehörige Konverter wird benutzt. Sonst gilt die Zeichenkette als HTML oder Markdown. Als HTML gilt *text* nur, wenn er mit einem erkannten HTML-Tag beginnt. Sonst gilt er als Markdown.

*pathName* **sourceView**
: Dieser Befehl wechselt die Ansicht des Widgets vom aktuellen Dokument selbst zur Quelltextansicht dieses Dokuments. Um zur bearbeitbaren Quelltextansicht zu wechseln, siehe **editView** oben.

    ```
        ::shtmlview::shtmlview .help
        .help browse index.md
        .help sourceView
    ```

*pathName* **url**
: Gibt die aktuell angezeigte URL zurück.


# Bindings für das Widget

Dem Widget sind die folgenden Tasten für die Navigation und andere Aktionen zugewiesen:

<cursor>
: Standardmäßige Cursorbewegung in der Ansicht

b
: Zurück. Zeigt die vorherige Seite im Verlauf.

f
: Vorwärts. Zeigt die nächste Seite im Verlauf.

p
: Vorheriger Treffer. Bewegt den Cursor zum vorherigen Suchtreffer.

n
: Weiter. Bewegt den Cursor zum nächsten Suchtreffer.

q
: Entfernt die aktuelle Seite aus dem Verlauf. Das setzt **f** voraus.

r
: Suche rückwärts starten

s
: Suche vorwärts starten

Ctrl-E
: Bearbeitungsmodus umschalten

Ctrl-s
: Im Bearbeitungsmodus: Seite speichern

Ctrl-r
: Aktuelle Seite neu laden

Ctrl-u
: Zwischen Quell- und gerenderter Ansicht umschalten

Return
: Folgt dem Link unter dem Cursor.

TAB
: Cursor zum nächsten Link auf der aktuellen Seite bewegen


# Beispiel

```
    package require shtmlview::shtmlview
    proc browsed {url} {
        puts "You browsed $url"
    }
    ::shtmlview::shtmlview .help -toolbar true -browsecmd browsed
    .help browse index.html
    pack .help -fill both -expand true -side left
    package require Markdown
    .help browser test.md
```

Weitere Beispiele stehen in den Quelldateien des Pakets.

# Erweiterungen

Zwar unterstützt das Paket standardmäßig nur HTML-Dokumente sowie Markdown-Dokumente, wenn das entsprechende Paket „**Markdown**“ verfügbar ist, doch lässt sich der Bereich der unterstützten Formate über einen Erweiterungsmechanismus vergrößern.

Der wichtigste Einstiegspunkt in dieses System ist der Befehl **shtmlview::converter**. Mit ihm ist es möglich, ein Dokumentformat und einen zugehörigen Konvertierungsbefehl zu registrieren. Das Format wird anhand seiner Dateierweiterung identifiziert, wie beispielsweise „*.md*“, „*.man*“ usw. Der Konvertierungsbefehl soll den Inhalt der ihm übergebenen Datei zur Anzeige in HTML konvertieren.

Die Pakete **shtmlview::doctools** und **shtmlview::mkdoc** sind Beispiele für solche Erweiterungen. Das erste unterstützt das Format *doctools*, mit dem *Tcllib* und *Tklib* ihre Handbuchseiten schreiben. Das zweite unterstützt Tcl-Quelldateien mit *mkdoc*, also Tcl-Dateien mit eingebetteter Dokumentation in der Syntax *mkdoc*.

Nachstehend der reine Tcl-Code des Pakets **shtmlview::mkdoc**:

```
    package require shtmlview::shtmlview
    package require mkdoc::mkdoc

    ::shtmlview::converter .tcl {Tcl+mkdoc files}   ::shtmlview::mkdoc
    ::shtmlview::converter .tm  {Tcl+mkdoc modules} ::shtmlview::mkdoc

    proc ::shtmlview::mkdoc {url} {
	close [file tempfile htmltemp .html]

	mkdoc::mkdoc $url $htmltemp -html

	if {[catch {
	    open $htmltemp r
	} result]} {
	    return -code error "Cannot open $url: $result"
	}

	set html [read $result]
	close $result
	file delete $htmltemp

	return $html
    }

    package provide shtmlview::mkdoc 0.1
```

Erweiterungen können statt eines Tcl-Pakets eine externe Anwendung wie **pandoc** benutzen, die das darzustellende HTML erzeugt.

Und natürlich ist es mit diesem Paket auch möglich, Konvertierungsbefehle direkt aus der Anwendung heraus zu registrieren, anstatt über ein separates Paket zu gehen.

# Änderungsprotokoll

2022-02-25 version 0.9.2
: - Korrektur zu **tk\_textCopy** und Aktualisierung der Dokumentation


2022-03-06 version 0.9.3
: - Unterstützung für Mausrad-Bindings

    - Korrektur von Hyperlinks auf http(s)-Links

    - Unterstützung für Datei-Anker-Links wie **file.html#anchor**

    - Unterstützung für **#** als Link zum Seitenanfang

    - Vielen Dank an aplsimple für die Vorschläge und Fehlermeldungen


2022-03-26 version 1.0.0
: - HTML 3.2-Tags: div, sub, sup, small, big

    - Erste Unterstützung für Markdown-Dateien

    - Erste Unterstützung für Base64-kodierte Inline-Bilddateien

    - Unterstützung für JPEG-Bilder, wenn das Paket „**img::jpeg**“ verfügbar ist

    - Unterstützung für SVG-Bilder, wenn entweder **critcl** und *librsvg-dev(el)* oder die Terminal-Anwendung **rsvg-convert** bzw. **cairosvg** verfügbar sind

    - Zurück und Vorwärts auch für Anker

    - Schaltflächen für den ersten und letzten Eintrag des Verlaufs

    - Verlauf mit vollständigem Dateipfad, damit sich das Verzeichnis wechseln lässt

    - Verbesserte Aufrufzeile und Installationsoption

    - Bindings für die nächste und die vorherige Suche

    - Return und Tab für Links

    - Option -historycombo

    - Korrektur der Symbolleiste

    - Korrektur von browse für nicht vorhandene Dateien

    - Nicht verwendeter CSS-/Stylesheet- und WebForms-Code wurde entfernt

    - Vielen Dank an pepdiz für die Fehlermeldungen und Vorschläge


2022-04-XX version 1.1.0
: - Tastenbindung Ctrl-u für die Quellansicht von HTML- und Markdown-Dateien

    - Tastenbindung Ctrl-Shift-e für einen einfachen Texteditor zur Dateibearbeitung

    - Der Dialog zum Öffnen von Dateien speichert nun das zuletzt verwendete Verzeichnis und die zuletzt verwendete Erweiterung.

    - Es wurde eine Schaltfläche zum Schließen der Datei mit der Option -closebutton hinzugefügt, die für Toplevel-Fenster nützlich ist

    - Einige Korrekturen bezüglich des Backslashs bei Markdown-Links

    - Hinzufügen eines „span“-Tags zur Formatierung

    - Hinzufügen einer Render-Methode zum direkten Einlesen von HTML ohne Dateinamen

    - Erweiterungsstruktur für weitere Dateitypen wie die Doctools von Tcllib oder mkdoc

    - Die Unterstützung für Tcl doctools ist in einem eigenen Paket enthalten

    - Die Unterstützung für Tcl-mkdoc liegt in einem eigenen Paket.



# Noch zu tun

- Markdown-Rendering mithilfe des tcllib-Pakets **Markdown**, falls eine URL mit „*.md*“ endet (erledigt)

- Unterstützung für SVG-Bilder, beispielsweise mithilfe von [svgconvert](https://wiki.tcl-lang.org/page/svgconvert), zumindest unter Linux/Windows

- Weitere Tags, siehe die Geschichte der HTML-Tags, HTML-3.2-Tags ergänzen: <http://www.martinrinehart.com/frontend-engineering/engineers/html/html-tag-history.html> (erledigt)

- Quellansicht mit Ctrl-u (erledigt)

- Bearbeitungsansicht mit Ctrl-Shift-e

- Behebung von Problemen mit dem Mausrad


# Dank

Stephen Uhler, Clif Flynt und Robert Heller haben den Großteil des Codes für dieses Widget beigesteuert.

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese dem Autor des Pakets. Bitte teilen Sie ihm auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation mit.

# Copyright am Code

Art der BSD-Lizenz:

Sun Microsystems, Inc.  Die folgenden Bedingungen gelten für alle Dateien, die mit der Software in Zusammenhang stehen, sofern in einzelnen Dateien nicht ausdrücklich etwas anderes angegeben ist.

Die Autoren erteilen hiermit die Erlaubnis, diese Software und ihre Dokumentation für jeden beliebigen Zweck zu nutzen, zu vervielfältigen, zu ändern, zu verbreiten und zu lizenzieren, vorausgesetzt, dass die vorhandenen Copyright-Hinweise in allen Kopien beibehalten werden und dass dieser Hinweis bei jeder Weitergabe wörtlich übernommen wird. Für keine der zulässigen Verwendungszwecke ist eine schriftliche Vereinbarung, eine Lizenz oder die Zahlung von Lizenzgebühren erforderlich. Änderungen an dieser Software können durch ihre Autoren urheberrechtlich geschützt sein und müssen nicht den hier beschriebenen Lizenzbedingungen entsprechen, sofern die neuen Bedingungen auf der ersten Seite jeder Datei, für die sie gelten, deutlich angegeben sind.

In keinem Fall haften die Autoren oder Vertreiber gegenüber Dritten für direkte, indirekte, besondere, zufällige oder Folgeschäden, die sich aus der Nutzung dieser Software, ihrer Dokumentation oder daraus abgeleiteter Werke ergeben, selbst wenn die Autoren auf die Möglichkeit solcher Schäden hingewiesen wurden.

Die Autoren und Vertreiber schließen ausdrücklich jegliche Gewährleistung aus, einschließlich, aber nicht beschränkt auf die stillschweigenden Gewährleistungen der Marktgängigkeit, der Eignung für einen bestimmten Zweck und der Nichtverletzung von Rechten Dritter. Diese Software wird „wie besehen“ bereitgestellt, und die Autoren und Vertreiber sind nicht verpflichtet, Wartung, Support, Updates, Erweiterungen oder Modifikationen bereitzustellen.

EINGESCHRÄNKTE RECHTE: Die Nutzung, Vervielfältigung oder Offenlegung durch die Regierung unterliegt den Einschränkungen, die in Unterabsatz (c) (1) (ii) der Klausel über Rechte an technischen Daten und Computersoftware gemäß DFARS 252.227-7013 und FAR 52.227-19 festgelegt sind.

# Copyright

```
Copyright (c) 2018-2022, Detlef Groth <detlef(at)dgroth(dot)de>
Copyright (c) 2009, Robert Heller
Copyright (c) 2000, Clif Flynt
Copyright (c) 1995-1999, Stephen Uhler
```
