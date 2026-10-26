# Formular-Layout

## Einführung

Ein ausfüllbares Formular besteht in pdf4tcl aus Feldern, die man mit
`addForm` an eine Stelle setzt. Beschriftung, Abstände, Abschnitte und
die Rechnung, wo das nächste Feld hinkommt, bleiben dem Aufrufer. Der
Namensraum [form]{.index} in pdf4tcllib übernimmt dieses Layout: eine
Beschriftung links, das Feld rechts, eine Zeile tiefer das nächste.

Wie Felder selbst funktionieren (Typen, Werte, Berechnung, JavaScript),
erklärt das Buch *pdf4tcl*. Dieses Kapitel zeigt den Aufbau und die
Stellen, an denen ein Formular aus pdf4tcllib anders aussieht, als man
erwartet.

---

## Die Bausteine

Die Prozeduren [form::section]{.index}, [form::labelField]{.index},
[form::row]{.index}, `form::separator`, [form::orderTable]{.index} und
[form::sumLine]{.index} nehmen alle `pdf`, `ctx` und den **Namen** der y-Variablen und
schieben diese nach unten weiter:

| Prozedur | zeichnet |
|---|---|
| form::section `pdf ctx yVar titel` | einen grauen Balken mit fettem Titel |
| form::labelField `pdf ctx yVar beschriftung typ ?option ...?` | Beschriftung und Feld in einer Zeile |
| form::row `pdf ctx yVar felder` | mehrere Paare nebeneinander |
| `form::separator pdf ctx yVar` | eine dünne Linie |
| form::orderTable `pdf ctx yVar köpfe breiten ?zeilen? ?option ...?` | eine Positionstabelle |
| form::sumLine `pdf ctx yVar breiten text wert ?option ...?` | die Summenzeile darunter |

Die Typen sind die von `addForm`: `text`, `password`, `checkbox`,
`combobox`, `listbox`, `radiobutton`, `pushbutton`, `signature`. Die
x-Position kommt aus `SX` im Kontext, die Breite aus `SW`.

---

## Ein Bestellformular

```tcl
# 120-formular.tcl -- ein ausfuellbares Bestellformular
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
# Formularfelder brauchen eine Schrift mit cp1252: dieselbe
# TrueType-Datei ein zweites Mal angemeldet, fuer form:: eingestellt
pdf4tcl::createFont _Pdf4tcl_Base_Regular FormSans     cp1252
pdf4tcl::createFont _Pdf4tcl_Base_Bold    FormSansBold cp1252
pdf4tcllib::form::configure -fontFamily FormSans \
    -fontFamilyBold FormSansBold
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set y [expr {[dict get $ctx top] + 10}]
# Rahmen und Hintergrund gibt jedes Feld selbst an
set rahmen {-bordercolor {0.6 0.6 0.6} -borderwidth 1
            -bgcolor {0.97 0.97 0.97}}

pdf4tcllib::form::section    $pdf $ctx y "Kunde"
pdf4tcllib::form::labelField $pdf $ctx y "Name:" text -id f_name \
    -init "Müller GmbH" {*}$rahmen
pdf4tcllib::form::labelField $pdf $ctx y "E-Mail:" text -id f_mail \
    {*}$rahmen
# row nimmt dieselben Angaben als Schluessel ohne Bindestrich
set r [dict create bordercolor {0.6 0.6 0.6} borderwidth 1 \
    bgcolor {0.97 0.97 0.97} labelw 40 type text]
pdf4tcllib::form::row $pdf $ctx y [list \
    [dict merge $r {label "PLZ:" width 120 id f_plz}] \
    [dict merge $r {label "Ort:" width 260 id f_ort}]]
pdf4tcllib::form::labelField $pdf $ctx y "Versand:" combobox \
    -id f_versand -options {Paket Spedition "Abholung Lager Süd"} \
    -init Paket -fieldw 150 {*}$rahmen
# Das Kaestchen bekommt seinen Rahmen als Grafik (siehe Text)
set labelW [dict get [pdf4tcllib::form::configure] labelW]
set xk [expr {[dict get $ctx SX] + $labelW + 4}]
$pdf setStrokeColor 0.6 0.6 0.6
$pdf rectangle $xk $y 12 12
$pdf setStrokeColor 0 0 0
pdf4tcllib::form::labelField $pdf $ctx y "Eilig:" checkbox \
    -id f_eilig -fieldw 12 -fieldh 12
pdf4tcllib::form::separator  $pdf $ctx y

pdf4tcllib::form::section    $pdf $ctx y "Bestellung"
set breiten {40 230 60 90}
set zahl {number decimals 2 sep de}
pdf4tcllib::form::orderTable $pdf $ctx y \
    {Pos Artikel Menge Betrag} $breiten \
    {{1 "Schraube M8" 100 "12.50"}} -emptyRows 3 -cellForm f_pos \
    -cellOpts [list 3 [list -align right -format $zahl]]
# Die Summe rechnet der Betrachter: aus den Feldern der Spalte Betrag
set betraege [lmap r {0 1 2 3} { string cat f_pos_ $r _3 }]
pdf4tcllib::form::sumLine $pdf $ctx y $breiten "Summe:" "" \
    -id f_summe -init "12.50" -calculate [list sum $betraege] \
    -format $zahl
pdf4tcllib::form::labelField $pdf $ctx y "Bemerkung:" text -id f_bem \
    -multiline 1 -fieldh 40 {*}$rahmen

$pdf endPage
$pdf write -file 120-formular.pdf
$pdf destroy
puts "y am Ende: [format %.1f $y]"
```

```text
y am Ende: 388.7
```

Im PDF stehen 24 Felder: Name, E-Mail, PLZ, Ort, Versand, Eilig, sechzehn
Zellen der Positionstabelle (`f_pos_0_0` bis `f_pos_3_3`), die Summe und
die Bemerkung.

### labelField

Alles, was `labelField` selbst nicht kennt, geht an `addForm`: `-id`,
`-init`, `-options`, `-multiline`, die Rahmenfarben. Drei Optionen
gehören `labelField`:

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-labelw` | `90` | Breite der Beschriftung |
| `-fieldw` | Rest der Zeile | Breite des Feldes |
| `-fieldh` | `16` | Höhe des Feldes |

`-fieldw` gilt für jeden Typ. Ein Kontrollkästchen ohne `-fieldw` ist
also so breit wie die ganze Zeile; im Beispiel steht darum
`-fieldw 12 -fieldh 12`.

### row

`row` nimmt eine Liste von Dicts mit den Schlüsseln `label`, `type`,
`width` (Beschriftung und Feld zusammen), `id`, `init`, `options`,
`labelw`, `fieldh` und den Darstellungsschlüsseln `bordercolor`,
`borderwidth`, `bgcolor`, `align`, `calculate`, `format`. Ohne `labelw`
ist die Beschriftung so breit wie ihr Text.

### orderTable und sumLine

`orderTable` zeichnet eine Kopfzeile (weiß auf dunkelblau), die Zeilen
aus `zeilen` und `-emptyRows` leere Zeilen dazu. Ohne `-cellForm` sind
die Zellen gedruckter Text, mit `-cellForm präfix` Textfelder mit der
Kennung `präfix_zeile_spalte`. `-cellOpts {spalte {optionen}}` gibt den
Feldern einer Spalte weitere Optionen für `addForm`, im Beispiel
rechtsbündig und als Zahl.

`sumLine` setzt den Text rechtsbündig vor die letzte Spalte und den Wert
in die letzte. Mit `-id` wird der Wert ein Feld, und mit `-calculate`
rechnet der Betrachter:

```tcl
-calculate {sum {f_pos_0_3 f_pos_1_3 f_pos_2_3 f_pos_3_3}}
-format    {number decimals 2 sep de}
```

`sum` geht auch als `product`, `average`, `min`, `max`. `sep de` zeigt
die Zahl mit Dezimalkomma. Gerechnet wird nur in Betrachtern mit
Formular-JavaScript, etwa Acrobat Reader; in Evince oder Okular bleibt
der Wert aus `-init` stehen.

---

## Schriften in Formularen

Ein Formularfeld hat zwei Schriften: die, in der die Seite den Wert
zeigt (die Erscheinung), und die, in der der Betrachter den Wert neu
zeichnet, wenn jemand tippt. Die zweite muss der Betrachter selbst
kodieren können. Mit den Schriften aus `fonts::init` geht das schief:

- **Mit `-cid 1`** zeigt eine Auswahlliste Kästchen statt Buchstaben
  (`□□□N□H□` statt `Paket`), sobald der Betrachter sie neu zeichnet.
  `addForm` kann mit CID-Schriften nicht umgehen.
- **Ohne `-cid`** kodiert pdf4tcllib die Schrift mit einer eigenen
  Zeichentabelle. Die Erscheinung stimmt, der gespeicherte Wert aber
  steht in derselben Tabelle: Aus `Müller` wird beim Exportieren der
  Formulardaten `MÜller`, aus `ß` ein `¿`.

Abhilfe ist dieselbe TrueType-Datei, ein zweites Mal angemeldet, diesmal
mit der Kodierung `cp1252`, und `form` so eingestellt, dass es diese
Schrift nimmt:

```tcl
pdf4tcl::createFont _Pdf4tcl_Base_Regular FormSans     cp1252
pdf4tcl::createFont _Pdf4tcl_Base_Bold    FormSansBold cp1252
pdf4tcllib::form::configure -fontFamily FormSans \
    -fontFamilyBold FormSansBold
```

`_Pdf4tcl_Base_Regular` und `_Pdf4tcl_Base_Bold` sind die Namen, unter
denen `fonts::init` die Dateien lädt. Der übrige Text der Seite bleibt
in der CID-Schrift. Mit `cp1252` gehen deutsche Umlaute, `ß` und `€`;
Zeichen außerhalb davon gehören nicht in ein Formularfeld.

Ohne `form::configure` nehmen Kopfzeile von `orderTable` und Text von
`sumLine` übrigens immer **Helvetica-Bold**, auch nach `fonts::init`.
Diese Schrift ist nicht eingebettet; ein Formular für PDF/A oder PDF/UA
fällt damit durch.

Die Zellen von `orderTable` erscheinen fett: Mit `-cellForm` übernehmen
die Felder die Schrift der Kopfzeile. Eine Option dagegen gibt es nicht.

---

## Rahmen und Hintergrund

Jedes Feld, das `labelField`, `row`, `orderTable -cellForm` und
`sumLine -id` anlegen, bekommt Hintergrund und Rahmen aus
`form::configure`: `fieldBg`, `fieldBorder` und `fieldBorderW` werden zu
`-bgcolor`, `-bordercolor` und `-borderwidth`. Gibt der Aufruf eine
dieser Optionen selbst an, gilt seine. Im Beispiel bekommt jedes Feld
einen etwas dunkleren Rahmen:

```tcl
set rahmen {-bordercolor {0.6 0.6 0.6} -borderwidth 1
            -bgcolor {0.97 0.97 0.97}}
```

`fieldBg {}` lässt den Hintergrund weg, `fieldBorderW 0` den Rahmen. Bis
pdf4tcllib 0.6.6 kamen die Einstellungen bei keinem Feld an; ohne eigene
Angabe hatte ein Feld keinen Rahmen, und auf dem Bildschirm war nicht zu
erkennen, wo man klicken soll.

Beim Kontrollkästchen reicht das nicht. Sobald ein Feld des Dokuments
rechnet oder formatiert (`-calculate`, `-format`, `-js`), verlangt das
PDF vom Betrachter, alle Felder neu zu zeichnen (`/NeedAppearances`).
Für Textfelder nimmt er dann Rahmen und Hintergrund aus den Angaben
oben. Beim Kontrollkästchen schreibt pdf4tcl den Rahmen aber nur in die
eigene Erscheinung, die dann nicht mehr gilt, und das Kästchen ist
unsichtbar. Das Beispiel zeichnet seinen Rahmen darum als Rechteck auf
die Seite, an derselben Stelle wie das Feld.

---

## Einstellungen

`form::configure` ohne Argumente gibt alle Einstellungen zurück, mit
Paaren setzt es sie. Unbekannte Namen sind ein Fehler.

| Name | Vorgabe | Bedeutung |
|---|---|---|
| `fontFamily`, `fontFamilyBold` | `Helvetica`, `Helvetica-Bold` | Schriften (siehe oben) |
| `fontSize`, `fontSizeLabel`, `fontSizeSection` | `9`, `9`, `10` | Größen |
| `fieldH` | `16` | Feldhöhe und Zeilenhöhe der Tabelle |
| `labelW`, `labelGap` | `90`, `4` | Breite der Beschriftung, Abstand zum Feld |
| `rowGap`, `sectionGap` | `6`, `10` | Abstand nach Zeile und Abschnitt |
| `sectionBg`, `lineColor` | grau | Abschnittsbalken, Trennlinie |
| `fieldBg`, `fieldBorder` | hellgrau, grau | Hintergrund und Rahmen der Felder |
| `fieldBorderW` | `1` | Rahmenbreite der Felder; `0` = keiner |

Die Namen werden ohne Bindestrich gespeichert, aber mit gesetzt:
`form::configure -labelW 110`.

---

## Was man wissen sollte

- **Kein Seitenumbruch.** Die Prozeduren schieben `y` weiter, beginnen
  aber keine neue Seite. Ein Formular, das über eine Seite geht, teilt
  man selbst auf.
- **Die Beschriftung steht unten.** Sie sitzt auf der Grundlinie des
  Feldes; bei einem hohen Feld (`-fieldh 40`) steht „Bemerkung:“ also
  neben dem unteren Rand.
- **Barrierefrei.** Beschriftung und Feld liegen zusammen in einem
  Element `Form`, mit der Beschriftung als Ersatztext; in der
  Positionstabelle ist es der Spaltenkopf.

---

## Zusammenfassung

- `section`, `labelField`, `row`, `orderTable`, `sumLine` bauen ein
  Formular Zeile für Zeile; sie schieben `y` weiter.
- Für die Felder eine `cp1252`-Schrift anmelden und mit
  `form::configure` einstellen, sonst falsche Werte oder Kästchen.
- Rahmen bei jedem Feld selbst angeben; ein Kontrollkästchen in einem
  rechnenden Formular braucht einen gezeichneten Rahmen.
- `sumLine -calculate` rechnet im Betrachter, nicht in Tcl.

---

*Nächstes Kapitel: [Etikettenbögen](130-etikettenboegen.md)*
