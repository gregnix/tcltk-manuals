# Formulare aus einem Dict

## Einführung

Das Kapitel [Formular-Layout](120-formular-layout.md) baut ein Formular
Befehl für Befehl auf: Abschnitt, Feld, Zeile, Tabelle. Das Paket
[pdf4tclforms]{.index} beschreibt dasselbe als **Daten**: ein Dict mit
Abschnitten, darin Felder, eine Tabelle und Summenzeilen. Ein Befehl
zeichnet es. So lässt sich ein Formular in einer Datei oder einer
Datenbank ablegen und von mehreren Programmen benutzen.

Dazu kommt der Rückweg: ein ausgefülltes Formular **lesen** und eines
**füllen**, ohne PDF-Betrachter, mit den Feldnamen als Schlüsseln.

Gezeichnet wird mit denselben Bausteinen aus `form::`; was dort über
Schriften, Rahmen und Einstellungen steht, gilt hier auch.

---

## Eine Rücksendung

```tcl
# 125-formular-schema.tcl -- ein Formular aus einem Dict, gefuellt, gelesen
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclforms

pdf4tcllib::fonts::init -cid 1
# Formularfelder brauchen eine Schrift mit cp1252 (Kapitel Formular-Layout)
pdf4tcl::createFont _Pdf4tcl_Base_Regular FormSans     cp1252
pdf4tcl::createFont _Pdf4tcl_Base_Bold    FormSansBold cp1252
pdf4tcllib::form::configure -fontFamily FormSans -fontFamilyBold FormSansBold
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Das Formular als Daten: Abschnitte mit Feldern, Tabelle und Summe
set breiten {30 260 60 100}
set schema [dict create \
    title "Rücksendung" \
    sections [dict create \
        kunde [dict create title "Kunde" fields {
            {id f_name type text label "Name:" required 1 borderwidth 1}
            {row {
                {id f_plz type text label "PLZ:" width 120}
                {id f_ort type text label "Ort:"  width 330}
            }}
            {id f_grund type combobox label "Grund:"
             options {"Beschädigt" "Falsch geliefert" "Gefällt nicht"}
             init "Beschädigt" borderwidth 1}
            {id f_ersatz type checkbox label "Ersatz statt Gutschrift"}
        }] \
        waren [dict create title "Waren" \
            table [dict create headers {Pos Artikel Menge Betrag} \
                widths $breiten emptyRows 3 editable 1 idPrefix f_pos \
                columns {3 {align right}}] \
            sums [list [dict create widths $breiten label "Summe:" \
                over {f_pos 3 3} init 0]]]]]

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set y [dict get $ctx top]
pdf4tcllib::forms::renderSchema $pdf $ctx $schema -yvar y
$pdf endPage
$pdf write -file 125-leer.pdf
$pdf destroy
puts "Formular endet bei y = [format %.1f $y]"

# Ausfuellen ohne Betrachter: Werte nach Feldname
set werte [dict create f_name "Erika Müller" f_plz 12345 f_ort Grünfeld \
    f_grund "Falsch geliefert" f_ersatz 1 \
    f_pos_0_0 1 f_pos_0_1 "Tontopf 18 cm" f_pos_0_2 2 f_pos_0_3 5.80]
puts "gefüllt: [pdf4tcllib::forms::write 125-leer.pdf 125-gefuellt.pdf $werte]"

# Zuruecklesen: ein Ankreuzfeld kommt als 1 oder 0
set daten [pdf4tcllib::forms::read 125-gefuellt.pdf]
foreach id {f_name f_ort f_grund f_ersatz f_pos_0_1 f_pos_1_1} {
    puts [format "%-10s %s" $id [dict get $daten $id]]
}
puts "Felder: [dict size $daten]"
```

```text
Formular endet bei y = 321.7
gefüllt: 9
f_name     Erika Müller
f_ort      Grünfeld
f_grund    Falsch geliefert
f_ersatz   1
f_pos_0_1  Tontopf 18 cm
f_pos_1_1  
Felder: 18
```

`125-leer.pdf` ist das leere Formular, `125-gefuellt.pdf` dasselbe mit den
Werten. Neun Felder wurden gefüllt; gelesen werden alle 18, auch die
leeren Tabellenzellen und das Summenfeld.

---

## Der Aufbau

```tcl
set y [pdf4tcllib::forms::renderSchema pdf ctx schema ?-yvar name? ?-pagebreak 0|1?]
```

[forms::renderSchema]{.index} zeichnet das ganze Dict ab `y` und gibt
die y-Position danach zurück. `-yvar` nennt die Variable des Aufrufers,
die dabei weiterrückt. Mit `-pagebreak 1` beginnt eine neue Seite, wenn
ein Feld oder eine Tabelle über den unteren Rand ginge; ohne geht das
Formular über den Rand hinaus.

| Ebene | Schlüssel |
|---|---|
| Formular | `title` (einmal oben, groß), `sections` (Pflicht) |
| Abschnitt | `title` (grauer Balken), `fields`, `table`, `sums` |

Die Abschnitte stehen in der Reihenfolge des Dicts. Innerhalb eines
Abschnitts ist die Reihenfolge fest: Titel, Felder, Tabelle, Summen,
gleich wie sie im Dict stehen.

**`fields` ist eine Liste**, kein Dict. Jeder Eintrag ist ein Feld oder
einer von vier Sondereinträgen:

| Eintrag | zeichnet |
|---|---|
| `{id … type … label …}` | ein Feld mit Beschriftung |
| `{row {feld feld …}}` | Felder nebeneinander; `width` ist die Breite des Paars aus Beschriftung und Feld |
| `{separator n}` | eine Linie und `n` Punkt Abstand |
| `{table {…}}`, `{sums {…}}` | Tabelle, Summenzeilen mitten in der Liste |

### Felder

| Typ | Besonderheit |
|---|---|
| `text`, `password` | `multiline 1` setzt die Beschriftung darüber, `fieldh` die Höhe |
| `combobox`, `listbox` | `options {…}`, `init` ist die Vorauswahl |
| `checkbox` | Kästchen links, Beschriftung rechts |
| `radio` | `group`, `options {{wert "Text"} …}` |
| `buttons` | `items` mit `{id caption action submit|reset|url}` |
| `signature` | Unterschriftsfeld, `placeholder` |

Ein Feld-Dict mischt zwei Arten von Schlüsseln. `label`, `labelw`,
`fieldh`, `fieldw`, `width` und `gap` gehören dem Layout und werden als
Text gezeichnet. `id`, `init`, `options`, `readonly`, `multiline`,
`required`, `tooltip`, `tabindex` und das Aussehen (`align`, `color`,
`borderwidth`, `bordercolor`, `bgcolor`, `format`, `calculate`, `js`)
gehen an `addForm`. Alles andere wird nicht weitergegeben.

`required 1` setzt ein rotes Sternchen hinter die Beschriftung. Ein
Feld ohne `borderwidth` hat keinen Rahmen; im Beispiel haben „Name“ und
„Grund“ einen, PLZ und Ort in der Zeile bekommen ihn von `form::row`.

### Die Tabelle

| Schlüssel | Bedeutung |
|---|---|
| `headers`, `widths` | Spaltenköpfe, Breiten in Punkt |
| `rows`, `emptyRows` | feste Zeilen, leere Zeilen dahinter |
| `editable` | `1`: jede Zelle ist ein Feld |
| `idPrefix` | Namen der Zellen: `präfix_zeile_spalte` |
| `columns` | Aussehen je Spalte, z. B. `{3 {align right}}` |
| `rowh`, `headerBg` | Zeilenhöhe, Farbe des Kopfes |

Die Zellen im Beispiel heißen `f_pos_0_0` bis `f_pos_2_3`, Zeilen und
Spalten ab 0. Jede Tabelle braucht ein eigenes `idPrefix`: Zwei Felder
mit demselben Namen sind im PDF ein Feld.

### Summenzeilen

Eine Summenzeile mit `value` ist fester Text. Mit `over {f_pos 3 3}` wird
sie ein Feld, das Spalte 3 der drei Zeilen von `f_pos` addiert, mit
`calculate {sum {…}}` oder `id` frei gewählte Felder. `init` steht im
Feld, bis gerechnet wird.

**Gerechnet wird im Betrachter**, mit JavaScript. `forms::write` rechnet
nicht: Im gefüllten Beispiel steht im Summenfeld 0, bis ein Betrachter
mit JavaScript das Formular öffnet und neu rechnet. Wer die Summe im PDF
braucht, rechnet sie in Tcl und schreibt sie mit.

---

## Vorlagen

[forms::template]{.index} gibt ein fertiges Schema zurück, ohne zu
zeichnen:

| Name | Inhalt | Optionen |
|---|---|---|
| `callnote` | Telefonnotiz | `-title` |
| `inventory` | PC-Inventar in drei Abschnitten | `-title` |
| `checklist` | Liste mit ausfüllbaren Zellen | `-title -headers -widths -emptyRows` |
| `order` | Bestellung mit Positionen | `-title -emptyRows` |

```tcl
set spec [pdf4tcllib::forms::template callnote -title "Rückruf"]
pdf4tcllib::forms::renderSchema $pdf $ctx $spec -yvar y
```

Das Schema ist ein gewöhnliches Dict; man kann es vor dem Zeichnen
ändern. Die Vorlagen sind deutsch beschriftet, ohne Umlaute.

---

## Füllen und lesen

```tcl
set n    [pdf4tcllib::forms::write ein.pdf aus.pdf werte ?-strict 0|1?]
set daten [pdf4tcllib::forms::read datei ?-schema felder? ?-strict 0|1? ?-raw 0|1?]
```

[forms::write]{.index} schreibt die Werte eines Dicts `feldname wert`
in eine Kopie des Formulars und gibt die Zahl der gefüllten Felder
zurück. Ein Ankreuzfeld bekommt `1` oder `0`; wie der Zustand im PDF
heißt (`/Yes`, `/Off`), erledigt das Paket. Ein Feld, das das Formular
nicht hat, wird übergangen und in `::pdf4tcl::warnings` gemeldet, mit
`-strict 1` ist es ein Fehler. pdf4tcl zeichnet dabei das Aussehen des
Feldes neu, sodass auch ein Druck ohne Formularunterstützung den Wert
zeigt; nur Passwort- und Auswahlfelder bekommen stattdessen
`/NeedAppearances`.

[forms::read]{.index} gibt alle Felder als Dict zurück: Text als Text,
Ankreuzfelder als `1` oder `0`, andere so, wie pdf4tcl sie liefert.
`-raw 1` liefert die Rohdaten von `pdf4tcl::getForms` (`type /Btn value
/Yes …`). Gelesen wird jedes Formular, nicht nur eines aus
pdf4tclforms.

`-schema` nimmt eine flache Liste von Feld-Dicts mit `id`. Dann kommt das
Ergebnis in deren Reihenfolge, und fehlende oder überzählige Felder
werden gemeldet. Felder in einem `row`-Eintrag gehören dafür einzeln in
die Liste.

---

## Was man wissen sollte

- Formularfelder brauchen eine Schrift mit cp1252, eingestellt mit
  `form::configure`, wie im Kapitel
  [Formular-Layout](120-formular-layout.md). Zeichen außerhalb von cp1252
  gehen in Feldern nicht.
- Kontext und Dokument mit `-orient true`.
- `sections` ist Pflicht, auch für einen einzigen Abschnitt.
- Die Befehle gibt es auch als `pdf4tclforms::renderSchema` usw.; die
  Bausteine aus `form::` sind dort ebenfalls angelegt.

---

## Zusammenfassung

- `forms::renderSchema` zeichnet ein Formular aus einem Dict: Abschnitte,
  Felder, Tabelle, Summen.
- `fields` ist eine Liste; `row`, `separator`, `table`, `sums` sind
  Sondereinträge.
- Tabellenzellen heißen `präfix_zeile_spalte`.
- `forms::write` füllt, `forms::read` liest, mit Feldnamen als
  Schlüsseln; gerechnet wird nur im Betrachter.

---

*Nächstes Kapitel: [Etikettenbögen](130-etikettenboegen.md)*
