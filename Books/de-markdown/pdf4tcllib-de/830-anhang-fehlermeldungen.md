# Fehlermeldungen

Die Meldungen von pdf4tcllib 0.6.7 und den Zusatzpaketen, nach Modul,
mit der üblichen Ursache. Die Texte sind englisch und stehen hier so,
wie Tcl sie ausgibt; `…` steht für den eingesetzten Wert.

Drei Arten gibt es:

- **Fehler** brechen den Aufruf ab (`catch` fängt sie).
- **Warnungen** landen in `::pdf4tcl::warnings`, einer Liste, die
  niemand von selbst leert. Vor dem Dokument `set ::pdf4tcl::warnings {}`,
  danach auslesen.
- **Hinweise auf stderr** schreibt pdf4tcllib selbst, meist nur einmal je
  Prozess.

---

## Für alle Bausteine

### …: unknown option -… (allowed: …) / (known: …)

Tippfehler oder eine Option, die es in dieser Version nicht gibt. Die
Meldung nennt die erlaubten. Seit 0.6.7 gilt das auch für
`table::draw`; vorher ging dort jede Option still durch.

### …: expected an even number of option/value words

### …: expected option/value pairs

Einer Option fehlt ihr Wert, oft weil eine Liste nicht geklammert ist:
`-colors $a $b` statt `-colors [list $a $b]`.

---

## Seite und Schriften

### unknown paper size: … (known: …)

`page::context` kennt das Papier nicht. Groß- und Kleinschreibung
spielt keine Rolle; die Liste in der Meldung nennt die bekannten Namen.

### pdf4tcllib::page::footer: unknown option …

Bei `footer` steht die Größe an fünfter Stelle, die Optionen danach:
`page::footer $pdf $ctx "Text" $seite 9 -pagelabel "Seite %s"`.

### pdf4tcllib::fonts: No TTF fonts found, falling back to Helvetica

Hinweis auf stderr, danach die durchsuchten Ordner. Ab hier gilt der
256-Zeichen-Modus mit Helvetica; Umlaute gehen, →, ✓ und
Anführungszeichen nicht. Unter Debian fehlt meist `fonts-dejavu-extra`
([Einrichten und Schriften](020-einrichten-und-schriften.md)).

### pdf4tcllib::fonts: TTF error: … / Fallback on Helvetica

Die Schriftdatei wurde gefunden, ließ sich aber nicht laden: beschädigt,
keine TrueType-Datei, oder ein anderes Programm hat sie gesperrt.

### pdf4tcllib::unicode: sanitize: at least one character is missing from the font and was replaced with '?' (first: U+…). …

Hinweis auf stderr, einmal je Prozess: Zeichen fehlten in der Schrift
und wurden zu `?`. Welche, sagt `unicode::substReport`. Für Griechisch
und Formelzeichen `fonts::init -cid 1`
([Unicode sicher ausgeben](030-unicode-sicher-ausgeben.md)).

### pdf4tcllib::math: unknown symbol '\…' rendered as literal text

`math::renderLatex` kennt den Befehl nicht und setzt ihn als Text.
Welche Namen es gibt, sagt `text::mathSymbolNames`.

---

## Text, Messen, Stapeln

### text::fitSize: unknown option …

`fitSize` nimmt `-min` und `-pdf`; `pdf` steht hier nicht an fester
Stelle wie bei `text::wrap`.

### layout::stack: an entry needs a script (or must be {gap <n>})

Ein Block in der Liste hat weder `script` noch die Form `{gap n}`.
Häufig: die Blöcke als ein Skript statt als Liste von Dicts übergeben.

### measure::block: unknown option …

Erlaubt: `-paper -orient -margin -landscape -y`.

---

## Tabellen

### table::draw: -orient 0 is not supported. …

Das Dokument wurde mit `-orient 0` (y nach oben) angelegt. `table::draw`
zeichnet nur bei y nach unten. Das pdf4tcl-Objekt mit `-orient 1`
anlegen, der Vorgabe ([Seitenkontext](040-einheiten-und-seitenkontext.md)).

### table::draw: rows … to … are joined by rowspan and need … pt, more than a page holds (… pt)

Ein Block aus Zeilen, die `rowspan` verbindet, wird nie getrennt. Hier
passt er auf keine Seite. `rowspan` verkleinern oder die Gruppe in
mehrere Blöcke teilen.

### table::group: -by … is outside the row (0..…)

Die Gruppenspalte gibt es nicht; die Zählung beginnt bei 0.

### table::group: the rows are not sorted by column …; a group falls into several blocks and each gets its own subtotal

Warnung in `::pdf4tcl::warnings`, mit `-strict 1` ein Fehler. Die Daten
vorher nach der Gruppenspalte sortieren, etwa mit
`lsort -index 0`. `group` sortiert absichtlich nicht.

### table::pivot: -agg must be sum, count, avg, min or max, not "…"

### orderTable: column widths total … pt, the text width is only … pt -- the table would be drawn past the edge of the page

`form::orderTable` passt nicht in den Satzspiegel. Breiten verkleinern
oder einen kleineren Rand im Kontext.

### orderTable: … header(s) but only … column width(s)

Eine Breite je Kopf.

### tablelist::render: … could not be reproduced (…). …

Warnung von `pdf4tcltable`: Bilder, eingebettete Fenster oder
umbrochene Zellen des Widgets kommen nicht ins PDF. Was genau, sagt
`tablelist::report`.

---

## Diagramme

### chart::…: no data

### chart::…: data must be label/value pairs or a list of {label value}, got … element(s)

Eine ungerade Liste: `{Jan 120 Feb}`. Leere Werte sind als Paar zu
schreiben, z. B. `{Feb 0}`.

### chart::bar: value for "…" is not a number: "…"

Gilt ebenso für `line` und `pie`. Ein leeres Feld ist keine Null
([Diagramme](100-diagramme.md)).

### chart::bar: box too small -- … x … pt leaves no room for axis and labels

Der Kasten ist kleiner als Achse und Beschriftung zusammen. Höhe
vergrößern oder `-labelsize` kleiner.

### chart::pie: negative value for "…" -- a slice of a whole cannot be negative

### chart::pie: the values add up to 0

---

## Spaltenfluss und Verzeichnis

### flow::…: -columns must be at least 1

### flow::boxes: … columns with a gap of … pt leave no width in … pt

Zu viele Spalten oder ein zu großes `-gap` für die Breite.

### toc::heading: level must be 1..6, got "…"

### toc::document: the contents was calculated as … page(s) and written as … -- every page number in it would be off by …

`pageCount` und `render` liefen mit verschiedenen Optionen, oder
`toc::configure` wurde zwischendurch geändert. Das Verzeichnis wäre
falsch nummeriert, darum bricht `document` ab
([Inhaltsverzeichnis](110-inhaltsverzeichnis.md)).

---

## Bilder und Zeichnen

### image::place: -fit must be contain, cover or stretch, not "…"

### image::place: width and height must be positive

### image::place: image … has no size

Die Kennung stammt nicht aus `$pdf addImage`, oder das Bild ist leer.

### image::place: … at … dpi (…x… pixels on …x… points), below …

Warnung bei `-dpi`: Das Bild ist für die Fläche zu grob aufgelöst.

### image::gallery: -cols and -rows must be at least 1

### image::gallery: the frame is too small for …x… cells

Der Rahmen reicht für das Raster nicht, meist wegen `-gap` oder
`-captionH`. Bis 0.6.6 kam stattdessen `invalid command name "2"`: Die
Meldung führte die Spaltenzahl als Befehl aus.

### pdf4tcllib::image needs Tk: …

`image::insert` und `insertAt` arbeiten mit Tk-Bildern. Für Dateien ohne
Tk: `$pdf addImage` und `image::place`.

### drawing::arrow: -at must be end, start or both, not "…"

### drawing::callout: width and height must be positive

### drawing::watermark: no text

### canvas::place: no such widget: …

### canvas::place: no room left for the drawing after the caption

`-captionH` ist so groß wie der Kasten.

### canvas::fitPage: the context leaves no height

---

## Etiketten

### unknown label sheet "…"; known: …

Der Bogen ist nicht eingetragen. Eigene Bögen mit `labels::define`
([Etikettenbögen](130-etikettenboegen.md)).

### label format …: missing "…"

`labels::define` ohne einen Pflichtschlüssel.

### label format …: paper "roll" means one label per page, so cols and rows must both be 1

### argSpec must name five variables: {x y w h record}

Das vierte Argument von `labels::render`.

### -start must be between 0 and … for sheet …

### -only: "…" is not a position on sheet … (0..…)

### -only names … position(s) for … record(s)

Je Datensatz eine Position.

### -frame: 0, 1 or layer, not "…"

### -frame layer needs pdf4tcl 0.9.4.70 or newer: … ignores -print 0, the grid would print

### -frame layer under -pdfa …: PDF/A forbids /AS, so -print 0 has no effect and the grid would print; use -frame 1 on a separate proof sheet

Das Hilfsraster liegt in einer Ebene, die nicht gedruckt werden soll.
Ältere pdf4tcl und PDF/A können das nicht; das Raster käme aufs
Etikett.

---

## Ausfüllbare Formulare

### forms::read: cannot read "…" / forms::write: cannot read "…"

Datei fehlt oder ist kein PDF mit Formular.

### forms::write: … has no field(s): …

Warnung, mit `-strict 1` ein Fehler: Diese Namen gibt es im Formular
nicht. Oft fehlt der volle Name mit Punkt (`person.city`, nicht `city`).

### forms::write: nothing to fill in

Das Dict mit den Werten ist leer, oder keiner der Namen kommt im
Formular vor.

### pdf4tclforms::renderSchema: spec needs 'sections' key

### pdf4tclforms::renderSchema: 'sections' must be a dict (name -> section), not a list of sections

### pdf4tclforms: field entry must be a dict, got: …

### pdf4tclforms::template: unknown template '…' (callnote inventory checklist order)

---

## Tk-Widgets

### treeview::render: no such widget: … / treeview::outline: no such widget: …

Der Pfad stimmt nicht, oder das Widget ist schon zerstört.

---

## Aus pdf4tcl

Zwei Warnungen von pdf4tcl selbst, die mit pdf4tcllib häufig sind:

### tagged: the … element is empty -- no content, no child element and no annotation. …

Ein Strukturelement ohne Inhalt. Bis pdf4tclchart 0.1.1 löste jedes
Diagramm sie aus (`Figure`); seit 0.1.2 nicht mehr. Bleibt sie, steht
ein eigenes `tag::begin`/`tag::end` ohne Zeichnung dazwischen.

### … must contain at least one …

Fehler beim Schließen eines Elements, etwa `Table` ohne `TR`. Kommt bei
selbst gebauten Tabellen vor, nicht bei `table::draw`
([Barrierefreie PDFs](180-barrierefreie-pdfs.md)).

---

*Zurück zum [Anfang](010-was-pdf4tcllib-ergaenzt.md)*
