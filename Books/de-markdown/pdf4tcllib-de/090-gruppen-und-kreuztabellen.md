# Gruppensummen und Kreuztabellen

## Einführung

Eine Liste von Buchungen wird selten so gedruckt, wie sie aus der
Datenbank kommt. Gefragt ist die Summe je Region, je Kunde, je Monat,
oder eine Übersicht mit Regionen als Zeilen und Quartalen als Spalten.
[table::group]{.index} und [table::pivot]{.index} rechnen das aus und
geben Zeilen zurück, die `table::draw` direkt zeichnet. Gezeichnet wird
dabei nichts; beide arbeiten nur auf den Daten.

---

## Das Beispiel

Neun Umsätze, nach Region sortiert. Ein Feld ist leer: Für West im
zweiten Quartal liegt kein Wert vor.

```tcl
# 090-gruppen.tcl -- Zwischensummen je Gruppe und eine Kreuztabelle
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Umsatz je Region, Quartal und Vertreter -- nach Region sortiert
set umsatz {
    {Nord Q1 Albers 1200}  {Nord Q2 Albers 1350}  {Nord Q2 Brandt 400}
    {Nord Q4 Brandt 980}   {Süd  Q1 Celik  2100}
    {Süd  Q3 Celik  1875.5}
    {West Q1 Dorn   640}   {West Q2 Dorn   ""}    {West Q3 Dorn   720}
}

# Zahlen fuer die Ausgabe formatieren; leere Felder bleiben leer
proc betrag {v} {
    if {[string is double -strict $v]} { return [format %.2f $v] }
    return $v
}

# 1. Gruppieren: Zwischensumme je Region, Gesamtsumme am Ende
set g [pdf4tcllib::table::group $umsatz -by 0 -sum {3} \
    -label "Summe %s" -totallabel "Gesamt" -blank 1]
puts "Zwischensummen in Zeile: [dict get $g subtotals],\
    Gesamt: [dict get $g total]"

set zeilen [lmap z [dict get $g rows] {
    lset z end [betrag [lindex $z end]]
    set z
}]
set stile {}
foreach i [dict get $g subtotals] {
    lappend stile $i {-font bold -bg {0.93 0.93 0.93}}
}
lappend stile [dict get $g total] {-font bold -bg {0.85 0.85 0.85}}

$pdf startPage
set x [dict get $ctx left]
set y [expr {[dict get $ctx top] + 10}]
set y [pdf4tcllib::table::draw $pdf $x $y {
    {-header Region   -width 80}
    {-header Quartal  -width 50}
    {-header Vertreter -width 80}
    {-header Umsatz   -width 70 -align right}
} $zeilen -rowstyles $stile]

# 2. Kreuztabelle: Regionen als Zeilen, Quartale als Spalten
set p [pdf4tcllib::table::pivot $umsatz -row 0 -col 1 -value 3 \
    -rowlabel Region -colorder {Q1 Q2 Q3 Q4}]
puts "Kopf: [dict get $p header]"
foreach z [dict get $p rows] { puts "  $z" }

set kopf [lmap h [dict get $p header] {
    set a [expr {$h eq "Region" ? "left" : "right"}]
    list -header $h -width 60 -align $a
}]
set zeilen [lmap z [dict get $p rows] { lmap v $z { betrag $v } }]
pdf4tcllib::table::draw $pdf $x [expr {$y + 30}] $kopf $zeilen \
    -rowstyles [list [dict get $p total] {-font bold}]

$pdf endPage
$pdf write -file 090-gruppen.pdf
$pdf destroy
```

```text
Zwischensummen in Zeile: 4 7 11, Gesamt: 12
Kopf: Region Q1 Q2 Q3 Q4 Gesamt
  Nord 1200 1750 {} 980 3930
  Süd 2100 {} 1875.5 {} 3975.5
  West 640 {} 720 {} 1360
  Gesamt 3940 1750 2595.5 980 9265.5
```

Im PDF steht die gruppierte Liste mit hervorgehobenen Summenzeilen und
darunter die Kreuztabelle:

```text
Region      Quartal  Vertreter     Umsatz
Nord        Q1       Albers       1200.00
            Q2       Albers       1350.00
            Q2       Brandt        400.00
            Q4       Brandt        980.00
Summe Nord                        3930.00
Süd         Q1       Celik        2100.00
...
Gesamt                            9265.50

Region        Q1       Q2       Q3      Q4   Gesamt
Nord     1200.00  1750.00           980.00  3930.00
Süd      2100.00           1875.50          3975.50
West      640.00            720.00          1360.00
Gesamt   3940.00  1750.00  2595.50  980.00  9265.50
```

---

## table::group

```tcl
set g [pdf4tcllib::table::group zeilen ?option wert ...?]
```

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-by` | `0` | Spalte, nach der gruppiert wird |
| `-sum` | – | Liste der Spalten, die summiert werden |
| `-label` | `Summe %s` | Text der Zwischensumme; `%s` wird der Gruppenwert |
| `-total` | `1` | Gesamtsumme anhängen (nur mit `-sum`) |
| `-totallabel` | `Gesamt` | Text der Gesamtsumme |
| `-header` | `0` | `1`: vor jeder Gruppe eine Zeile mit dem Gruppenwert |
| `-blank` | `0` | `1`: den Gruppenwert nur in der ersten Zeile der Gruppe zeigen |
| `-strict` | `0` | `1`: bei unsortierten Daten einen Fehler werfen |

Das Ergebnis ist ein Dict:

| Schlüssel | Inhalt |
|---|---|
| `rows` | die Zeilen mit eingefügten Zwischensummen |
| `subtotals` | die Nummern der Zwischensummenzeilen |
| `groups` | die Nummern der Gruppenkopfzeilen (mit `-header 1`) |
| `total` | die Nummer der Gesamtsummenzeile, sonst `-1` |

Die Nummern passen direkt zu `-rowstyles` von `table::draw`; so werden
im Beispiel die Summen fett und grau hinterlegt.

### Die Daten müssen sortiert sein

`group` sortiert nicht selbst; die Reihenfolge der Zeilen bleibt, wie
sie kommt. Stehen dieselben Werte nicht beieinander, zerfällt eine
Gruppe in mehrere Blöcke, und jeder bekommt seine eigene Zwischensumme.
`group` merkt das, wirft aber nur mit `-strict 1` einen Fehler. Ohne
landet die Warnung in `$::pdf4tcl::warnings`, wo sie nur sieht, wer
nachschaut. Darum vorher sortieren:

```tcl
set umsatz [lsort -index 0 $umsatz]
```

### Leere Felder sind keine Null

Ein Wert, der keine Zahl ist (leer, „k. A.“), wird beim Summieren
übersprungen, nicht als 0 gezählt. Bei einer Summe macht das keinen
Unterschied; bei einem Durchschnitt in der Kreuztabelle schon.

### Die Beschriftung reicht über mehrere Spalten

Die Zwischensumme beginnt mit einer verbundenen Zelle (`colspan`), die
bis zur ersten Summenspalte reicht. Seit pdf4tcllib 0.6.7 zieht
`table::draw` keine Linie mehr hindurch (Kapitel
[Tabellen mit Seitenumbruch](080-tabellen.md)). Mit älteren Versionen
muss die erste Spalte so breit sein wie die längste Beschriftung, im
Beispiel 80 Punkt für „Summe West“, sonst läuft die Linie durch den
Text.

### Summen formatieren

`group` und `pivot` rechnen mit `expr`. Was herauskommt, ist eine Zahl
in Tcl-Schreibweise: `3930`, `3975.5`, bei manchen Beträgen auch
`1234.5000000000002`. Für die Ausgabe gehört ein `format` davor; im
Beispiel macht das `betrag` für jede Zelle, die eine Zahl ist. Ein
Dezimalkomma setzt keines der beiden Pakete:

```tcl
proc betrag {v} {
    if {![string is double -strict $v]} { return $v }
    string map {. ,} [format %.2f $v]
}
```

---

## table::pivot

```tcl
set p [pdf4tcllib::table::pivot zeilen ?option wert ...?]
```

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-row` | `0` | Spalte, deren Werte die Zeilen werden |
| `-col` | `1` | Spalte, deren Werte die Spalten werden |
| `-value` | `2` | Spalte mit den Zahlen |
| `-agg` | `sum` | `sum`, `count`, `avg`, `min`, `max` |
| `-empty` | `""` | was in einem Feld ohne Wert steht |
| `-colorder` | sortiert | Reihenfolge der Spalten |
| `-rowlabel` | `""` | Kopf der ersten Spalte |
| `-total` | `1` | Summenspalte und Summenzeile anhängen |
| `-totallabel` | `Gesamt` | deren Beschriftung |

Das Ergebnis enthält `header` (die Kopfzeile), `rows`, `cols` (die
Spaltenwerte ohne Kopf und Summe) und `total` (Nummer der Summenzeile).
Die Kopfzeile ist eine Liste von Texten; für `table::draw` muss daraus
eine Spaltenbeschreibung werden, im Beispiel mit `lmap`.

Drei Entscheidungen trifft jede Kreuztabelle, und `pivot` überlässt sie
dem Aufrufer:

- **Welche Spalten.** Sie ergeben sich aus den Daten. Ein Quartal ohne
  einen einzigen Wert fehlt; wer alle vier sehen will, gibt
  `-colorder {Q1 Q2 Q3 Q4}` an. Ohne `-colorder` wird alphabetisch
  sortiert, aus Monatsnamen wird dann „Apr Aug Dez …“.
- **Was in einer leeren Zelle steht.** Vorgabe ist nichts, nicht 0.
  „Kein Umsatz“ und „keine Angabe“ sind verschiedene Aussagen; wer 0
  will, setzt `-empty 0`.
- **Was bei mehreren Werten je Feld geschieht.** Nord hat in Q2 zwei
  Umsätze (Albers und Brandt); `-agg sum` addiert sie zu 1750.

Mit `-agg avg` ist die Summenzeile der Durchschnitt über alle Werte der
Spalte, nicht die Summe der Durchschnitte.

---

## Zusammenfassung

- `table::group` fügt Zwischensummen ein und sagt, in welchen Zeilen sie
  stehen; die Nummern gehen an `-rowstyles`.
- Vorher nach der Gruppenspalte sortieren, oder `-strict 1`.
- `table::pivot` für Kreuztabellen; `-colorder` für die Spalten,
  `-empty` für leere Felder.
- Zahlen vor dem Zeichnen formatieren, auch das Dezimalkomma.

---

*Nächstes Kapitel: [Diagramme](100-diagramme.md)*
