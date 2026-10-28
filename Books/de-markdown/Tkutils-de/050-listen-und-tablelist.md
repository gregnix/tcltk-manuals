# Listen und tablelist

## tkutablelist 0.4

Wrapper um [tablelist]{.index} aus tklib: Zeilen-/Spalten-API, Sortieren per
Kopfklick, editierbare Zellen, Auswahlhilfen, CSV laden und speichern,
Fußzeile, Hierarchie. Nicht im Umbrella direkt, kommt aber über
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

Mit [exportselection]{.index} 0 bleibt die Auswahl stehen. Weil sich damit
beobachtbares Verhalten ändert, trägt das Modul die Nummer **0.4**.

```tcl
package require tkutils::tkutablelist
set w [::tkutils::tkutablelist::widget .alt -columns {A B} \
    -exportselection 1]
puts [[::tkutils::tkutablelist::tableWidget $w] cget -exportselection]   ;# -> 1
```

Wer das alte Tk-Verhalten braucht, setzt `-exportselection 1`.

---

## Nur 0.4

Es gibt nur noch **0.4**. `package require tkutils::tkutablelist 0.3`
lädt 0.4 (gleiche Major-Version 0); eine eigene 0.3 wird nicht mehr
gepflegt (`package require … 0.3` liefert `0.4`).

Unbekannte Option: `{TKUTILS TKUTABLELIST OPTION -colums}` mit dem
Optionsnamen, wie bei `tkuopts`. Die Meldung hat zwei Zeilen:

```text
unknown option "-colums"
Known: -columns -doublecommand -editable -editendcommand -exportselection -footer -selectcommand -selectmode -sortable -stretch -stripes -titlecolumns
```

Bis 0.46.0 fehlten Optionsname und `Known:`-Liste (Anhang
[Fallen](800-anhang-fallen.md)); die Modulversion blieb 0.4. Ein fehlender
Wert meldet `{TKUTILS TKUTABLELIST OPTION}` mit
`missing value for option "-columns"`.

---

## Tablelist-Helfer

Sortieren, Anzeige, Zwischenablage, Fußzeile, Suche, Spaltenlayout und
Baum stehen im Kapitel [Tablelist-Helfer](052-tablelist-helfer.md).
`tkutltools` lädt alle sieben. Wrapper und Helfer laden
`tablelist_tile`; die Reihenfolge zum Umbrella ist frei (Kapitel
[tkutils verstehen](010-tkutils-verstehen.md)).

---

## Zusammenfassung

- 0.4 für Multi-Select + Kontextmenü; Auswahl bleibt bei Menüs.
- Altes Verhalten über `-exportselection 1`.
- `require … 0.3` lädt 0.4.
- `tkutltools` lädt alle sieben Helfer. Befehle: Kapitel
  [Tablelist-Helfer](052-tablelist-helfer.md).

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 (Tablelist 6.20) und 9.0.4 (Tablelist
7.11) unter Linux und Xvfb: alle Beispiele und Meldungen dieses Kapitels.
:::

---

*Nächstes Kapitel: [Tablelist-Helfer](052-tablelist-helfer.md)*
