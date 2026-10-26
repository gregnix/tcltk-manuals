# Fallen

Kurze Liste, nach Thema. Die Begründung steht im genannten Kapitel.

---

## Einrichten

- `package require pdf4tcllib` lädt pdf4tcl nicht mit; beide Zeilen
  schreiben ([Einrichten](020-einrichten-und-schriften.md)).
- Tcl 8.6 liest Skripte in der Systemkodierung. Ohne UTF-8-Locale werden
  Umlaute im Quelltext zu „Ã¼“ im PDF.
- Ohne passende TrueType-Datei läuft alles mit Helvetica weiter; nur
  stderr sagt es. `fonts::hasTtf` prüfen.
- Die Vorgabefamilie `DejaVuSansCondensed` liegt unter Debian in
  `fonts-dejavu-extra`, nicht in `fonts-dejavu-core`.
- Dateinamen nach dem Schema `<familie>.ttf`, `<familie>-Bold.ttf`;
  Liberation-Schriften passen nicht.
- Der CID-Modus wird beim ersten `fonts::init` festgelegt. Ein späteres
  `fonts::init -cid 1` (auch mit `-force 1`) lädt nichts neu, meldet bei
  `fonts::isCidMode` aber 1.

## Text und Zeichen

- `unicode::sanitize` richtet sich nach `fonts::init`, nicht nach
  `setFont`. Helvetica nach `fonts::init` verliert →, ✓ und Rahmenlinien
  ohne Meldung ([Unicode](030-unicode-sicher-ausgeben.md)).
- `safeText` macht aus „…“ immer "…", auch im CID-Modus; ebenso die
  Kopf- und Fußzeilen aus `page::`.
- `text::writeParagraph` ruft `sanitize` nicht auf. Fehlende Zeichen
  zählt dann pdf4tcl (`$pdf getSubstCount`), nicht pdf4tcllib.
- `unicode::substCount` zählt über den ganzen Prozess; vor jedem
  Dokument `resetSubst`.
- Im 256-Zeichen-Modus gibt es keine deutschen Anführungszeichen.

## Text setzen

- `text::width`, `wrap`, `truncate`, `fits` ohne `$pdf` schätzen die
  Breite nur ([Text setzen](050-text-setzen.md)).
- `text::wrap` kürzt ein Wort, das allein zu breit ist, auf „...“;
  `hardBreak 1` zerlegt es stattdessen.
- Bei `text::wrap` steht `pdf` an sechster Stelle, nach `code`; bei
  `fitSize` heißt es `-pdf`.
- `text::writeParagraph` setzt immer die normale Schrift und bricht
  nicht über Seiten um.
- Nach einer Fuß- oder Kopfzeile ist deren Schrift gesetzt; vor dem
  nächsten Text `setFont` erneut aufrufen.

## Seiten und Spalten

- „Seite X von Y“ braucht zwei Durchläufe; der Inhalt darf keine
  Nebenwirkungen haben ([Seitenzahlen](060-kopf-fuss-seitenzahlen.md)).
- `-pagelabel` ist ein `format`-Text: `%` als `%%` schreiben.
- `flow::columns` ohne `-newpage` gibt den Rest in `rest` zurück, statt
  umzubrechen ([Spaltenfluss](070-spaltenfluss-wasserzeichen.md)).
- `flow::columns` setzt die erste Grundlinie auf `-top`; ohne Angabe
  ragt die erste Zeile in den Rand.
- `-firsty` gilt nur für die erste Spalte; `-align` wirkt nicht.
- `drawing::watermark` vor allem anderen zeichnen; mit `-orient 0` liegt
  es außerhalb der Seite.

## Tabellen und Diagramme

- `table::draw` ohne `-ctx` bricht nicht um; ohne `-pagebreakcmd` gibt
  es auf den Folgeseiten keine Kopf- und Fußzeile ([Tabellen](080-tabellen.md)).
- `-pagebreakcmd` läuft im globalen Bereich und muss die neue y-Position
  zurückgeben.
- Zellen sind einzeilig und werden mit „...“ gekürzt, auch die Kopfzeile;
  `-notruncate 1` für Werte, die abgetippt werden.
- Ein Block aus Zeilen, die `rowspan` verbindet, wird nicht getrennt;
  ist er höher als eine Seite, bricht `table::draw` mit einem Fehler ab.
- `table::group` sortiert nicht; unsortierte Daten ergeben mehrere
  Zwischensummen je Gruppe ([Gruppen](090-gruppen-und-kreuztabellen.md)).
- Summen aus `group` und `pivot` sind rohe Tcl-Zahlen; vor dem Zeichnen
  formatieren.
- `table::pivot` sortiert die Spalten alphabetisch; Monate und Quartale
  mit `-colorder`.
- `chart::line` zeigt die Namen der Reihen nicht; die Legende selbst
  zeichnen ([Diagramme](100-diagramme.md)).
- `-format` der Diagramme kennt kein Dezimalkomma.

## Dokumente

- Das Skript für `toc::document` läuft zweimal; keine Nebenwirkungen.
  `toc::document` baut seinen eigenen Kontext und überschreibt `ctx`
  ([Inhaltsverzeichnis](110-inhaltsverzeichnis.md)).
- `toc::heading` setzt nicht fett und bricht nicht um.
- `-gap` und `-bookmarks` von `toc::document` gelten nur für diesen
  Aufruf; beim Weg von Hand zählt `toc::configure`.
- Ein Deckblatt vor dem Verzeichnis geht nur über `collect`,
  `pageCount`, `render`.
- Formularfelder mit den Schriften aus `fonts::init`: im CID-Modus
  Kästchen in Auswahllisten, sonst falsch gespeicherte Umlaute. Eine
  `cp1252`-Schrift anmelden und mit `form::configure` einstellen
  ([Formular-Layout](120-formular-layout.md)).
- `orderTable` und `sumLine` nehmen ohne `form::configure` immer
  Helvetica-Bold.
- Ein Kontrollkästchen in einem Formular mit `-calculate` oder
  `-format` ist in Poppler-Betrachtern unsichtbar; den Rahmen zeichnen.
- `labelField ... checkbox` ohne `-fieldw` ist so breit wie die Zeile.
- `labels::render` beginnt die Seiten selbst; kein `startPage` davor
  ([Etikettenbögen](130-etikettenboegen.md)).
- `labels::fitSize` hört bei `min` auf, auch wenn der Text nicht passt;
  nachmessen. Argumente anders als bei `text::fitSize`.
- Drucken in tatsächlicher Größe, nicht „an Seite anpassen“.
- Ein JPEG, das vor dem ersten `startPage` geladen wird, beginnt eine
  Seite ([Bilder](140-bilder.md)).
- `image::gallery -caption` kennt nur `unten` und `keine`; andere Werte
  schalten die Unterschriften still ab.
- `roundedRect -clip 1` beschneidet eckig
  ([Pfeile und Callouts](150-pfeile-und-callouts.md)).
- Ohne `fonts::init -cid 1` werden Formelzeichen zu `?`
  ([Formeln](160-formeln.md)).
- `renderLatex` setzt keinen Abstand um `=`; `\,` einfügen. Danach die
  Schrift neu setzen.
- Ein Skript mit Tk braucht `exit` am Ende und eine Anzeige
  ([Treeview](170-treeview.md)).
- Eine CID-Schrift, die mit `setFont` eingestellt, aber nie benutzt
  wird, landet ganz in der Datei: rund 330 KB für DejaVu Sans Bold.

## Barrierefreiheit und Aufbau

- `tagged 1 -ua 1` setzt `DisplayDocTitle` nicht; PDF/UA verlangt es:
  `viewerPreferences -displaydoctitle 1`
  ([Barrierefreie PDFs](180-barrierefreie-pdfs.md)).
- `writeParagraph` setzt `P`, wenn kein Typ angegeben ist; für
  Überschriften `H1` usw. als achtes Argument. Es stellt immer die
  normale Schrift ein.
- Ein Diagramm ist für ein Vorleseprogramm nur sein Ersatztext. Wichtige
  Zahlen zusätzlich als Tabelle. (Bis pdf4tclchart 0.1.1 blieb das
  `Figure` ohne Inhalt, und pdf4tcl warnte.)
- Selbst Gezeichnetes in `tag::begin`/`end` oder als Artefakt, sonst
  ist `getUntaggedCount` nicht 0.
- Bausteine hinterlassen ihre Schrift und Farbe; `state::with`
  ([Grafikzustand](190-grafikzustand.md)).
- `state::with` stellt wieder her, was man angibt, nicht was eingestellt
  war.
- `gsave`/`grestore` über einen Seitenwechsel ergibt unausgeglichene
  Ströme, ohne Meldung.
- `measure::block`: `pages` bleibt 1, wenn der Block nicht selbst
  umbricht; `overflow` lesen ([Messen und stapeln](200-messen-und-stapeln.md)).
- In Skripten für `layout::stack` `$bpdf` statt `$pdf`.
- `layout::stack` prüft nur Blöcke mit `keep 1`.
- `page::header` zieht seine Linie 2 pt unter `top`; Inhalt ab `top`
  wird durchgestrichen.

## Seite

- pdf4tcl-Objekt ohne `-unit mm`: pdf4tcllib rechnet in Punkt, sonst
  landet Text außerhalb der Seite ([Seitenkontext](040-einheiten-und-seitenkontext.md)).
- pdf4tcl-Option `-margin` und `page::context` zusammen ergeben den
  doppelten Rand.
- `-orient` im Kontext und im pdf4tcl-Objekt müssen gleich sein.
- `page::context a4 20 0`: das zweite Wort ist die Richtung, nicht das
  Querformat.
- y ist die Grundlinie: Text bei `y = top` ragt in den Rand.
- `page::footer` schreibt „Seite N“, auch in einem englischen Dokument;
  `pageLabelFormat` setzen.
- `page::grid` ist ein Hilfsraster zum Entwickeln, kein Spaltenraster.
- `page::centerText` ohne Schriftargument setzt Helvetica, auch nach
  `fonts::init`; die Schrift mitgeben.

---

*Nächstes Kapitel: [API je Modul](810-anhang-api.md)*
