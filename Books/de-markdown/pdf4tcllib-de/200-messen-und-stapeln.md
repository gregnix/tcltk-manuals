# Messen und stapeln

## Einführung

Jeder Bericht enthält dieselbe Schleife: einen Block zeichnen, das
zurückgegebene `y` nehmen, einen Abstand dazurechnen, den nächsten Block
zeichnen. Und bevor eine Tabelle kommt, die Frage: Passt sie noch auf
diese Seite, oder gehört sie ganz auf die nächste? Die Bausteine von
pdf4tcllib beantworten das nicht; sie zeichnen und sagen hinterher, wo
sie aufgehört haben.

Zwei Namensräume helfen: [measure]{.index} misst einen Block, bevor er
gezeichnet wird, und [layout::stack]{.index} setzt Blöcke untereinander
und beginnt eine neue Seite, wenn ein Block nicht mehr ganz passt.

---

## Messen durch Zeichnen

```tcl
set m [pdf4tcllib::measure::block varName skript ?option wert ...?]
```

[measure::block]{.index} zeichnet den Block wirklich, aber in ein
Wegwerf-Dokument, das nie geschrieben wird. Was gemessen wird, ist damit
genau das, was später herauskommt. Im Skript steht das Wegwerf-Dokument
in der Variablen, deren Namen man übergibt (im Beispiel `mp`). Das
Ergebnis ist ein Dict:

| Schlüssel | Inhalt |
|---|---|
| `height` | Höhe des Blocks, aus seinem Rückgabewert |
| `pages` | Seiten, über die er lief |
| `overflow` | `1`, wenn er unten über das Blatt hinauslief |
| `value` | was das Skript zurückgab |
| `sheet` | Höhe des Blatts |

Optionen: `-paper` (Vorgabe `a4`), `-orient`, `-landscape`, `-margin`,
`-y`. Die Höhe ist der Abstand zwischen `-y` (Vorgabe 0) und dem
Rückgabewert; der Block sollte darum bei y = 0 beginnen oder bei dem `y`,
das man mit `-y` angibt. Gibt das Skript keine Zahl zurück, ist `height`
leer.

Schriften, die `fonts::init` geladen hat, kennt auch das
Wegwerf-Dokument; sie gelten für alle Dokumente eines Prozesses.

### pages und overflow

Die Seitenzahl steigt nur, wenn der Block selbst umbricht, also etwa
`table::draw` mit `-ctx`. Ohne `-ctx` zeichnet `table::draw` über den
Seitenrand hinaus, und `pages` bleibt 1. Gemessen wird so, wie man
später zeichnet.

`writeParagraph` bricht nie um. Ein langer Absatz läuft unten aus dem
Blatt, `pages` bleibt 1, und erst `overflow` sagt, dass etwas nicht
stimmt. Im Beispiel ist der lange Absatz 896 Punkt hoch, das Blatt nur
842.

[measure::fits]{.index} `platz varName skript` fasst das zusammen: `1`,
wenn der Block höchstens `platz` hoch ist, auf einer Seite bleibt und
nicht überläuft. [measure::height]{.index} gibt nur die Höhe zurück.

---

## Das Beispiel

```tcl
# 200-messen-und-stapeln.tcl -- Hoehe vorab messen, Bloecke stapeln
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclchart

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set x [dict get $ctx left]
set w [dict get $ctx text_w]

set text "Der Bestand wurde am Monatsende gezählt und mit der Buchung\
    abgeglichen. Abweichungen unter zwei Stück sind ausgebucht."
set cols {
    {-header Regal -width 120}
    {-header Soll  -width 60 -align right}
    {-header Ist   -width 60 -align right}
}
set rows {}
for {set i 1} {$i <= 30} {incr i} {
    set soll [expr {$i * 7}]
    lappend rows [list "Regal $i" $soll [expr {$soll - $i % 3}]]
}

# 1. Messen: wie hoch wird die Tabelle, passt der Absatz?
set m [pdf4tcllib::measure::block mp {
    pdf4tcllib::table::draw $mp 0 0 $cols $rows -maxwidth $w
}]
puts "Tabelle: Höhe [format %.1f [dict get $m height]],\
    Seiten [dict get $m pages], Überlauf [dict get $m overflow]"
set lang [string repeat "$text " 40]
set m [pdf4tcllib::measure::block mp {
    pdf4tcllib::text::writeParagraph $mp $lang 0 0 $w 11
}]
puts "Langer Absatz: Höhe [format %.1f [dict get $m height]],\
    Seiten [dict get $m pages], Überlauf [dict get $m overflow]"
puts "passt in 200 pt: [pdf4tcllib::measure::fits 200 mp {
    pdf4tcllib::text::writeParagraph $mp $text 0 0 $w 11
}]"

# 2. Stapeln: Bloecke untereinander, Tabelle und Diagramm am Stueck
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
proc kopf {} {
    global pdf ctx
    pdf4tcllib::page::header $pdf $ctx "Lagerbericht"
}
$pdf startPage
kopf
# Die Linie der Kopfzeile liegt 2 pt unter top, im Satzspiegel. stack
# beginnt jede Seite bei SY (= top); also SY tiefer, SH kuerzer.
set oben [expr {[dict get $ctx top] + 12}]
set sh   [expr {[dict get $ctx SH] - 12}]
set sctx [dict replace $ctx SY $oben SH $sh]

set absatz  {pdf4tcllib::text::writeParagraph $bpdf $text \
                 $bx $by $bw 11}
set balken  {pdf4tcllib::chart::bar $bpdf $bx $by $bw 200 \
                 {Nord 120 Süd 95 West 60} -title "Bestand je Lager"}
set tabelle {pdf4tcllib::table::draw $bpdf $bx $by $cols $rows \
                 -maxwidth $bw}
set ende    {pdf4tcllib::text::writeParagraph $bpdf "Ende." \
                 $bx $by $bw}
set blocks [list \
    [list script $absatz] \
    [list script $balken keep 1] \
    [list script $absatz] \
    [list script $tabelle keep 1] \
    {gap 10} \
    [list script $ende]]
set r [pdf4tcllib::layout::stack $pdf $x $oben $w $blocks \
    -ctx $sctx -gap 14 -font [list 11 [pdf4tcllib::fonts::fontSans]] \
    -pagecmd kopf]
puts "Seitenwechsel: [dict get $r pages], Ende bei y =\
    [format %.1f [dict get $r y]]"
foreach b [dict get $r boxes] { puts "  [lmap v $b {format %.0f $v}]" }
$pdf endPage
$pdf write -file 200-messen-und-stapeln.pdf
$pdf destroy
```

```text
Tabelle: Höhe 502.2, Seiten 1, Überlauf 0
Langer Absatz: Höhe 896.0, Seiten 1, Überlauf 1
passt in 200 pt: 1
Seitenwechsel: 1, Ende bei y = 625.9
  57 69 482 32
  57 115 482 200
  57 329 482 32
  57 69 482 502
  57 595 482 17
```

Auf Seite 1 stehen Absatz, Diagramm und Absatz. Die Tabelle (502 Punkt)
passt ab y = 375 nicht mehr in den Satzspiegel; mit `keep 1` kommt sie
ganz auf Seite 2, mit Kopfzeile. Danach „Ende.“

---

## layout::stack

```tcl
set r [pdf4tcllib::layout::stack pdf x y breite blöcke \
    ?option wert ...?]
```

Jeder Eintrag in `blöcke` ist eines von beiden:

| Eintrag | Bedeutung |
|---|---|
| `script skript ?keep 1?` | ein Block |
| `gap n` | n Punkt Abstand vor dem nächsten Block |

Im Skript stehen vier Variablen bereit: `$bpdf`, `$bx`, `$by`, `$bw`,
das Dokument, die linke obere Ecke und die Breite. Das Skript gibt, wie
jeder Baustein, das `y` darunter zurück (oder eine Fläche
`{x y b h}`).

**Im Skript `$bpdf`, nicht `$pdf`.** Beim Messen ist `$bpdf` das
Wegwerf-Dokument. Ein Skript, das `$pdf` benutzt, zeichnet beim Messen
ins echte Dokument, und der Block steht zweimal da.

Das Skript läuft im Bereich des Aufrufers und sieht dessen Variablen
(`$text`, `$cols`, `$rows`). Im Beispiel stehen die Skripte darum in
geschweiften Klammern: Die Variablen werden erst beim Ausführen
eingesetzt. Ein Skript über mehrere Zeilen braucht `\` am Zeilenende
wie jeder andere Tcl-Befehl.

| Option | Bedeutung |
|---|---|
| `-ctx` | Seitenkontext; ohne ihn wird nie umgebrochen |
| `-gap` | Abstand nach jedem Block |
| `-font {größe schrift}`, `-fill {r g b}` | vor jedem Block gesetzt, danach wiederhergestellt |
| `-pagecmd` | läuft nach jedem Seitenwechsel, im Bereich des Aufrufers |
| `-paper` | Papier fürs Messen |

Zurück kommt ein Dict mit `y` (unter dem letzten Block), `pages` (Zahl
der Seitenwechsel, die `stack` selbst gemacht hat) und `boxes`, je Block
`{x y b h}`.

### Was keep tut und was nicht

Nur Blöcke mit `keep 1` werden gemessen. Passt so ein Block nicht mehr
bis zum unteren Rand, beendet `stack` die Seite, beginnt eine neue, ruft
`-pagecmd` auf und setzt den Block oben hin.

Blöcke **ohne** `keep` werden weder gemessen noch geprüft. Ein Absatz
ohne `keep` am Ende der Seite läuft über den unteren Rand hinaus, auch
mit `-ctx`. Darum lohnt `keep 1` auch für kurze Blöcke, wenn man nicht
weiß, wo sie landen.

Ein Block, der höher als eine ganze Seite ist, passt auch auf die neue
Seite nicht. `stack` setzt ihn trotzdem dorthin; umbrechen muss der
Block dann selbst (eine Tabelle mit `-ctx`). Die Seiten, die er dabei
anfängt, zählt `pages` nicht mit, und `boxes` sagt nicht, auf welcher
Seite ein Block steht.

### Die Kopfzeile und der obere Rand

`stack` beginnt jede neue Seite bei `SY` aus dem Kontext, das ist `top`.
`page::header` zieht seine Linie aber 2 Punkt **unter** `top`, also im
Satzspiegel. Ein Absatz, der genau bei `top` beginnt, wird von der Linie
durchgestrichen. Das Beispiel gibt `stack` darum einen Kontext, in dem
`SY` 12 Punkt tiefer liegt und `SH` entsprechend kürzer ist:

```tcl
set oben [expr {[dict get $ctx top] + 12}]
set sh   [expr {[dict get $ctx SH] - 12}]
set sctx [dict replace $ctx SY $oben SH $sh]
```

`SY` und `SH` sind die Schlüssel, die `stack` liest; die übrigen
Bausteine nehmen `top` und `bottom`. Die geänderte Kopie gilt darum nur
für `stack`.

---

## Zusammenfassung

- `measure::block` zeichnet zur Probe und gibt Höhe, Seiten und
  Überlauf zurück; `overflow` sieht, was `pages` nicht sieht.
- `layout::stack` setzt Blöcke untereinander; in den Skripten `$bpdf`,
  `$bx`, `$by`, `$bw`.
- Nur `keep 1` wird gemessen und bei Bedarf auf die nächste Seite
  gesetzt.
- Für Platz unter der Kopfzeile `SY` und `SH` im Kontext für `stack`
  anpassen.

---

*Nächstes Kapitel: [Fallstudie: Lagerbericht](210-fallstudie-bericht.md)*
