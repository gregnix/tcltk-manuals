# Barrierefreie PDFs

## Einführung

Ein Vorleseprogramm sieht keine Seite, sondern einen Baum: Überschrift,
Absatz, Tabelle mit Zeilen und Zellen, Abbildung mit Beschreibung. Steht
dieser [Strukturbaum]{.index} nicht im PDF, liest das Programm die Seite
so vor, wie die Texte im Datenstrom liegen, samt Seitenzahl, Kopfzeile
und Tabellenlinien. Behörden und viele Firmen verlangen deshalb
barrierefreie PDFs nach [PDF/UA]{.index} (ISO 14289).

pdf4tcl schreibt den Strukturbaum, wenn man ihn einschaltet. pdf4tcllib
sorgt dafür, dass seine Bausteine ihn richtig füllen: Eine Tabelle wird
`Table` mit `TR` und `TD`, eine Kopfzeile wird Schmuck. Was man selbst
zeichnet, muss man selbst einordnen. Dieses Kapitel zeigt beides an einem
Bericht.

---

## Was ein Dokument für PDF/UA braucht

| Anforderung | in pdf4tcl |
|---|---|
| Strukturbaum | `$pdf tagged 1` |
| Sprache des Dokuments | `tagged 1 -lang de-DE` |
| Titel, im Fenster statt des Dateinamens | `metadata -title ...`, `viewerPreferences -displaydoctitle 1` |
| eingebettete Schriften | `fonts::init`; keine der 14 Standardschriften |
| jeder Inhalt in einem Element oder als Schmuck markiert | Bausteine von pdf4tcllib, eigenes mit `tag::` |
| Ersatztext für Abbildungen | `-alt` |
| Kennzeichnung als PDF/UA | `tagged 1 -ua 1` |

`-ua 1` schreibt nur die Behauptung in die Metadaten, dass das Dokument
PDF/UA-1 erfüllt. Prüfen kann pdf4tcl das nicht. Ein Dokument, das die
Behauptung aufstellt und sie nicht hält, ist schlechter als eines, das
nichts behauptet; darum ist `-ua` nicht die Vorgabe.

Auch `-displaydoctitle` ist nicht die Vorgabe, und `-ua 1` setzt es
nicht mit. PDF/UA verlangt es aber: Ohne zeigt der Betrachter den
Dateinamen statt des Titels.

---

## Ein Bericht mit Strukturbaum

```tcl
# 180-barrierefrei.tcl -- ein Bericht mit Strukturbaum fuer PDF/UA
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclchart

pdf4tcllib::fonts::init -cid 1           ;# eingebettete Schrift
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Strukturbaum an, Sprache, Anspruch auf PDF/UA-1, Titel
$pdf tagged 1 -lang de-DE -ua 1
$pdf metadata -title "Lagerbericht Oktober" -author "Lager Nord"
$pdf viewerPreferences -displaydoctitle 1      ;# Titel statt Dateiname
set ::pdf4tcl::warnings {}

$pdf startPage
set x [dict get $ctx left]
set w [dict get $ctx text_w]
pdf4tcllib::page::header $pdf $ctx "Lagerbericht Oktober"

# Ueberschrift: writeParagraph mit dem Typ H1 statt des Vorgabe-P
set y [pdf4tcllib::text::writeParagraph $pdf "Bestand am Monatsende" \
    $x [expr {[dict get $ctx top] + 20}] $w 16 left H1]
set y [pdf4tcllib::text::writeParagraph $pdf "Der Bestand wurde am\
    Monatsende gezählt. Die Tabelle nennt die Abweichungen je Regal." \
    $x [expr {$y + 6}] $w 11]

# Eine Tabelle: Table, TR, TH, TD von selbst
set y [pdf4tcllib::table::draw $pdf $x [expr {$y + 10}] {
    {-header Regal -width 80}
    {-header Soll -width 60 -align right}
    {-header Ist -width 60 -align right}
} {{A-01 120 118} {A-02 80 80} {B-01 45 47}} \
    -summary "Soll und Ist je Regal"]

# Ein Diagramm: ein Element Figure mit Ersatztext
set y [pdf4tcllib::chart::bar $pdf $x [expr {$y + 20}] 300 150 \
    {A-01 -2 A-02 0 B-01 2} -title "Abweichung je Regal" \
    -alt "Balkendiagramm: A-01 minus 2, A-02 null, B-01 plus 2"]

# Selbst gezeichnet: Text als P, die Linie als Schmuck
pdf4tcllib::tag::begin $pdf P
$pdf setFont 9 [pdf4tcllib::fonts::fontSans]
$pdf text "Gezählt von: M. Albers" -x $x -y [expr {$y + 20}]
pdf4tcllib::tag::end $pdf
pdf4tcllib::tag::artifact $pdf -type Layout
$pdf line $x [expr {$y + 26}] [expr {$x + $w}] [expr {$y + 26}]
pdf4tcllib::tag::artifactEnd $pdf

pdf4tcllib::page::footer $pdf $ctx "Intern" 1
puts "ohne Element: [$pdf getUntaggedCount]"
$pdf endPage
$pdf write -file 180-barrierefrei.pdf
$pdf destroy
foreach m $::pdf4tcl::warnings { puts "Warnung: $m" }
```

```text
ohne Element: 0
```

Bis pdf4tclchart 0.1.1 stand darunter noch eine Warnung: „the Figure
element is empty“. Das Diagramm war damals ganz als Artefakt markiert,
die `Figure` hatte keinen Inhalt. Seit 0.1.2 ist das Gezeichnete ihr
Inhalt, und die Warnung entfällt.

Der Strukturbaum des Ergebnisses, mit einem PDF-Werkzeug ausgelesen:

```text
Document
  H1          [Inhalt]
  P           [Inhalt]
  Table       Summary="Soll und Ist je Regal"
    TR
      TH  TH  TH        Scope=Column
    TR
      TD  TD  TD
    TR  ...
  Figure      Alt="Balkendiagramm: A-01 minus 2, A-02 null,
                   B-01 plus 2"  [Inhalt]
  P           [Inhalt]
```

Kopf- und Fußzeile und die Linie unter „Gezählt von“ stehen nicht im
Baum. Sie sind als [Artefakt]{.index} markiert: Schmuck, den ein
Vorleseprogramm überspringt.

Die Linien der Tabelle dagegen hängen als Inhalt am Element `Table`.
Die Dokumentation von pdf4tcllib nennt sie Artefakte; im Datenstrom
stehen sie mit einer Inhaltsnummer unter `Table`. Ein Vorleseprogramm
liest Linien nicht vor, und `getUntaggedCount` zählt sie nicht. Ob ein
Prüfprogramm Inhalt direkt unter `Table` beanstandet, ist hier nicht
geprüft.

---

## Was die Bausteine selbst tun

| Baustein | im Strukturbaum |
|---|---|
| `text::writeParagraph` | `P`, oder der Typ im letzten Argument |
| `table::draw` | `Table`, `TR`, `TH` mit `Scope=Column`, `TD`; `-summary` |
| `chart::bar`, `line`, `pie` | `Figure` mit Ersatztext aus `-alt` oder `-title`; Balken und Achsen sind ihr Inhalt |
| `image::place`, `gallery` | `Figure` mit `-alt`; Unterschrift als `Caption` |
| `toc::heading`, `toc::render` | `H1` bis `H6`; `TOC` und `TOCI` |
| `form::labelField`, `row` | `Form` mit Beschriftung und Feld |
| `labels::render` | ein `Sect` je Etikett |
| `drawing::callout` | Text als `P`, Kasten und Zeiger als Artefakt |
| `page::header`, `footer`, `number`, `drawing::watermark` | Artefakt (Seitengestaltung) |

Ist `tagged` aus, tun die Bausteine nichts davon. Derselbe Code erzeugt
dann ein gewöhnliches PDF.

### Überschriften

`writeParagraph` setzt `P`, wenn man nichts sagt. Für eine Überschrift
gehört der Typ als achtes Argument dazu, mit Größe und Ausrichtung
davor:

```tcl
pdf4tcllib::text::writeParagraph $pdf "Bestand" $x $y $w 16 left H1
```

`writeParagraph` stellt dabei immer die normale Schrift ein; ein
`setFont` mit Fett davor hat keine Wirkung. Die Überschrift im Beispiel
ist darum nur größer, nicht fett. Für eine fette Überschrift mit
Strukturelement zeichnet man sie selbst (Abschnitt
[Selbst gezeichnetes einordnen](#selbst-gezeichnetes-einordnen)).

Die Ebenen dürfen nicht springen: nach `H1` ein `H2`, nicht gleich
`H3`. Das prüft pdf4tcl nicht.

### Diagramme

Ein Diagramm wird ein `Figure` mit Ersatztext; Balken, Achsen und
Beschriftungen sind sein Inhalt. Ein Vorleseprogramm sagt den
Ersatztext, nicht die einzelnen Striche. Der Titel ist als Ersatztext meist zu
wenig: „Abweichung je Regal“ sagt nicht, wie die Abweichung aussieht.
Im Beispiel stehen die Werte im Ersatztext.

Mehr als den Ersatztext bekommt ein Leser vom Diagramm nicht. Sind die
Zahlen wichtig, gehören sie zusätzlich in eine Tabelle.

### Tabellen

`-summary` beschreibt die Tabelle in einem Satz, bevor die Zellen kommen.
Die Kopfzeile wird `TH` mit `Scope=Column`; damit weiß ein Leser bei
jeder Zelle, zu welcher Spalte sie gehört.

---

## Selbst gezeichnetes einordnen

Was man direkt mit pdf4tcl zeichnet, gehört zu nichts, bis man es
einordnet. Dafür gibt es vier Prozeduren im Namensraum [tag]{.index}:

| Prozedur | tut |
|---|---|
| `tag::begin pdf typ ?-alt text?` | ein Element öffnen (`P`, `H2`, `Figure` …) |
| `tag::end pdf` | es schließen |
| `tag::artifact pdf ?-type Layout\|Pagination?` | Schmuck beginnen |
| `tag::artifactEnd pdf` | Schmuck beenden |

Eine fette Überschrift, selbst gesetzt:

```tcl
pdf4tcllib::tag::begin $pdf H2
$pdf setFont 13 [pdf4tcllib::fonts::fontSansBold]
$pdf text "Abweichungen" -x $x -y $y
pdf4tcllib::tag::end $pdf
```

Alle vier tun nichts, wenn `tagged` aus ist. Darum können sie in Code
stehen bleiben, der auch gewöhnliche PDFs erzeugt.

`Layout` ist Schmuck auf der Seite (Linien, Flächen, Rahmen),
`Pagination` gehört zur Seitengestaltung (Kopfzeile, Seitenzahl,
Wasserzeichen).

### getUntaggedCount

`$pdf getUntaggedCount` zählt die Zeichenbefehle, die weder in einem
Element noch in einem Artefakt stehen. Null ist das Ziel. Ohne die vier
`tag::`-Zeilen im Beispiel wären es 2: der Text „Gezählt von“ und die
Linie. pdf4tcl schreibt dann beim Speichern zusätzlich eine Warnung
nach `$::pdf4tcl::warnings`.

Gezählt wird nur, was gezeichnet wird. Eine Farbe oder Schrift außerhalb
eines Elements stört nicht.

---

## Prüfen

Null in `getUntaggedCount` heißt nur, dass alles eingeordnet ist. Ob die
Einordnung stimmt, sagt die Zahl nicht. Drei Stufen:

1. **`getUntaggedCount` und `$::pdf4tcl::warnings`** im Programm, bei
   jedem Lauf. Das Beispiel gibt beides aus.
2. **Ein Prüfprogramm** für die Norm. [veraPDF]{.index} prüft PDF/UA-1:

   ```bash
   verapdf -f ua1 bericht.pdf
   ```

   `qpdf --check` prüft nur, ob die Datei sauber gebaut ist, nicht die
   Norm.
3. **Ein Mensch mit Vorleseprogramm** (NVDA, JAWS, Orca). Ein Dokument
   kann jede Regel erfüllen und trotzdem in einer Reihenfolge vorgelesen
   werden, die keinen Sinn ergibt.

---

## Zusammenfassung

- `tagged 1 -lang de-DE`, Titel mit `metadata -title` und
  `viewerPreferences -displaydoctitle 1`, eingebettete Schrift.
- Die Bausteine füllen den Strukturbaum selbst; Überschriften brauchen
  den Typ als Argument.
- Selbst Gezeichnetes mit `tag::begin`/`end` oder als Artefakt.
- `getUntaggedCount` muss 0 sein; danach veraPDF und ein Mensch.
- `-ua 1` ist eine Behauptung, keine Prüfung.

---

*Nächstes Kapitel: [Grafikzustand sichern](190-grafikzustand.md)*
