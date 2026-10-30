# Listen und tablelist

## tkutablelist 0.5

Wrapper um [tablelist]{.index} aus tklib: Zeilen-/Spalten-API, Sortieren per
Kopfklick, editierbare Zellen, Auswahlhilfen, Zeilen-IDs, CSV laden und
speichern, Fußzeile, Hierarchie. Nicht im Umbrella direkt, kommt aber über
`tkufilelist` mit.

```tcl
package require tkutils::tkutablelist
set w [::tkutils::tkutablelist::widget .t -columns {Name Größe Typ}]
pack $w -fill both -expand 1
::tkutils::tkutablelist::setRows $w {
    {a.txt 120 Text} {b.md 80 Markdown} {c.png 4096 Bild}
}
::tkutils::tkutablelist::selectRows $w {0 2}
puts [::tkutils::tkutablelist::selection $w]   ;# -> 0 2
```

Optionen von `widget`: `-columns`, `-stretch`, `-titlecolumns`,
`-sortable`, `-editable`, `-selectmode` (Standard `extended`),
`-exportselection` (Standard **0**), `-stripes`, `-selectcommand`,
`-doublecommand`, `-editendcommand`, `-footer`. Weitere Standardwerte:
`-stretch all`, `-titlecolumns 0`, `-sortable 1`, `-editable 0`,
`-stripes ""` (keine Streifen), `-footer 0`. Die rohe Tablelist liefert
`tableWidget` (Pfad `<w>.tbl`).

---

## Warum `-exportselection 0`

Tk exportiert die Auswahl eines Listen-Widgets normalerweise als
X-Selection PRIMARY. Nimmt ein anderes Widget PRIMARY — ein Eintrag in
einem Menü, eine Combobox, ein Entry in der Toolbar —, verliert die Tabelle
ihre Auswahl. Bei einem Dateimanager heißt das: Mehrere Dateien markieren,
Rechtsklick, und die Markierung ist weg, bevor *Kopieren* greift.

Mit [exportselection]{.index} 0 bleibt die Auswahl stehen. Diese Vorgabe
kam mit **0.4**.

```tcl
package require tkutils::tkutablelist
set w [::tkutils::tkutablelist::widget .alt -columns {A B} \
    -exportselection 1]
puts [[::tkutils::tkutablelist::tableWidget $w] cget -exportselection]   ;# -> 1
```

Wer das alte Tk-Verhalten braucht, setzt `-exportselection 1`.

---

## Zeilen-IDs und Sortieren

Eine Zeilennummer gilt nur, bis der Benutzer sortiert. Seit **0.5** trägt
jede Zeile auf Wunsch eine ID in ihrer Zeilenoption `-name`. `setRows`
nimmt die IDs mit `-ids`, `insert` als drittes Argument.

```tcl
::tkutils::tkutablelist::setRows $w {
    {c.png 4096 Bild} {a.txt 120 Text} {b.md 80 Markdown}
} -ids {f3 f1 f2}
::tkutils::tkutablelist::sortBy $w 0
puts [::tkutils::tkutablelist::findId $w f3]          ;# -> 2
puts [::tkutils::tkutablelist::selectIds $w {f2 f9}]  ;# -> f2
puts [::tkutils::tkutablelist::selectedIds $w]        ;# -> f2
```

| Befehl | Wirkung |
|---|---|
| `rowId w index` | ID der Zeile, leer ohne ID |
| `findId w id` | aktuelle Zeilennummer, `-1` ohne Treffer |
| `selectedIds w` | IDs der ausgewählten Zeilen; eine Zeile ohne ID fehlt, `curselection` liefert alle |
| `selectIds w ids` | wählt diese Zeilen aus, aktiviert die erste und rollt zu ihr; liefert die gefundenen IDs |

`setRows` fügt alle Zeilen mit einem `insertlist` ein und stellt danach
die Sortierung wieder her, die der Benutzer zuletzt gewählt hat. Passt
die Zahl der IDs nicht zur Zahl der Zeilen, wirft es
`{TKUTILS TKUTABLELIST IDS}` mit
`-ids needs one id per row (2 rows, 1 ids)`. `selectRows` aktiviert
ebenfalls die erste Zeile und rollt zu ihr.

Mit `-sortable 1` (Vorgabe) sortiert ein Klick auf den Kopf über
`tablelist::sortByColumn`: Der zweite Klick dreht die Richtung, der Pfeil
erscheint, `<<TablelistColumnSorted>>` kommt. Umschalt+Klick nimmt eine
weitere Spalte dazu (`tablelist::addToSortColumns`).

---

## CSV

`toCsv` liefert, was der Benutzer sieht: sichtbare Zeilen, sichtbare
Spalten, Rohwerte der Zellen. `saveCsv` schreibt dasselbe als UTF-8.

```tcl
set tbl [::tkutils::tkutablelist::tableWidget $w]
::tkutils::tkutablelist::setRows $w {
    {a.txt 120 Text} {b.md 80 Markdown} {c.png 4096 Bild}
}
$tbl rowconfigure 1 -hide 1
$tbl columnconfigure 2 -hide 1
puts [::tkutils::tkutablelist::toCsv $w]
;# Name,Größe
;# a.txt,120
;# c.png,4096
::tkutils::tkutablelist::saveCsv $w liste.csv -profile excel-de
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-header` | `1` | Spaltentitel als erste Zeile |
| `-all` | `0` | `1`: alle Zeilen und Spalten, auch versteckte |
| `-formatted` | `0` | `1`: angezeigte Werte statt Rohwerte |
| `-encoding` | `utf-8` | nur `saveCsv` |

Alle anderen Optionen gehen an `tclutils::tucsv::text`, etwa
`-delimiter ;` oder `-profile excel-de` (Semikolon, CRLF, BOM). Dafür
braucht `tkutablelist` `tclutils::tucsv` 0.2 aus tclutils 0.69.0.

---

## Versionen

Es gibt nur **0.5**. `package require tkutils::tkutablelist 0.4` und
`… 0.3` laden 0.5 (gleiche Major-Version 0). Liegt eine alte
`tkutablelist-0.4.tm` noch im Baum, lädt `package require` trotzdem die
höhere Version; die alte Datei beim Überkopieren löschen.

Unbekannte Option: `{TKUTILS TKUTABLELIST OPTION -colums}` mit dem
Optionsnamen, wie bei `tkuopts`. Die Meldung hat zwei Zeilen:

```text
unknown option "-colums"
Known: -columns -doublecommand -editable -editendcommand -exportselection -footer -selectcommand -selectmode -sortable -stretch -stripes -titlecolumns
```

Bis 0.46.0 fehlten Optionsname und `Known:`-Liste (Anhang
[Fallen](800-anhang-fallen.md)). Ein fehlender
Wert meldet `{TKUTILS TKUTABLELIST OPTION}` mit
`missing value for option "-columns"`.

---

## Tablelist-Helfer

Sortieren, Anzeige, Zwischenablage, Fußzeile, Suche, Spaltenlayout,
Baum, Filtern, Gruppieren und Ziehen stehen im Kapitel
[Tablelist-Helfer](052-tablelist-helfer.md). `tkutltools` lädt alle
zehn. Wrapper und Helfer laden
`tablelist_tile`; die Reihenfolge zum Umbrella ist frei (Kapitel
[tkutils verstehen](010-tkutils-verstehen.md)).

---

## Zusammenfassung

- Auswahl bleibt bei Menüs (`-exportselection 0`); altes Verhalten über
  `-exportselection 1`.
- Zeilen-IDs mit `setRows -ids`; `findId`, `selectIds` gelten auch nach
  dem Sortieren.
- `toCsv` und `saveCsv` exportieren nur Sichtbares; `-all 1` nimmt alles.
- `require … 0.4` lädt 0.5.
- `tkutltools` lädt alle zehn Helfer. Befehle: Kapitel
  [Tablelist-Helfer](052-tablelist-helfer.md).

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 (Tablelist 6.20) und 9.0.4 (Tablelist
7.11) unter Linux und Xvfb: alle Beispiele und Meldungen dieses Kapitels.
:::

---

*Nächstes Kapitel: [Tablelist-Helfer](052-tablelist-helfer.md)*
