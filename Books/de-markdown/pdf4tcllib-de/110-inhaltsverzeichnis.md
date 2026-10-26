# Inhaltsverzeichnis

## Einführung

Ein Inhaltsverzeichnis steht vorn, kennt aber Seitenzahlen, die erst
feststehen, wenn alles dahinter gesetzt ist. Und es verschiebt diese
Seitenzahlen selbst, um so viele Seiten, wie es lang ist. Ohne zwei
Durchläufe geht es nicht. Das Paket [pdf4tcltoc]{.index} macht beide
Durchläufe und schreibt dazu je Überschrift ein Lesezeichen.

---

## Der Inhalt als Skript

```tcl
package require pdf4tcltoc
set r [pdf4tcllib::toc::document pdf papier skript ?option wert ...?]
```

Der Inhalt wird nicht direkt gezeichnet, sondern als Skript übergeben,
denn [toc::document]{.index} muss ihn zweimal ausführen:

1. in ein Wegwerf-Dokument; dabei merkt sich jede Überschrift, auf
   welcher Seite sie landet;
2. in das echte Dokument, nachdem das Verzeichnis geschrieben ist.

Im Skript gibt es zwei Variablen: `pdf` (im ersten Lauf das
Wegwerf-Dokument) und `ctx`. Das Skript beginnt und beendet seine Seiten
selbst. Überschriften setzt es mit [toc::heading]{.index}; nur was so
gesetzt ist, kommt ins Verzeichnis.

```tcl
# 110-inhaltsverzeichnis.tcl -- Verzeichnis mit echten Seitenzahlen
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltoc

pdf4tcllib::fonts::init -cid 1

set kapitel {
    {1 "Einleitung"} {2 "Zweck des Berichts"} {2 "Datenquellen"}
    {1 "Bestand"}    {2 "Lager Nord"} {2 "Lager Süd"}
    {1 "Ausblick"}
}
set absatz "Der Bestand wurde am Monatsende gezählt und mit der\
    Buchung abgeglichen. Abweichungen unter zwei Stück sind\
    ausgebucht."

# Der Inhalt als Skript: es sieht die Variablen pdf und ctx,
# beginnt seine Seiten selbst und laeuft zweimal -- also keine
# Nebenwirkungen.
set inhalt {
    $pdf startPage
    set y [dict get $ctx top]
    foreach k $kapitel {
        lassign $k ebene titel
        if {$ebene == 1 && $y > [dict get $ctx top]} {
            $pdf endPage; $pdf startPage; set y [dict get $ctx top]
        }
        pdf4tcllib::toc::heading $pdf $ctx y $ebene $titel
        for {set i 0} {$i < 12} {incr i} {
            if {$y > [dict get $ctx bottom] - 40} {
                $pdf endPage; $pdf startPage; set y [dict get $ctx top]
            }
            set y [pdf4tcllib::text::writeParagraph $pdf $absatz \
                [dict get $ctx left] $y [dict get $ctx text_w] 11]
        }
    }
    $pdf endPage
}

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
set r [pdf4tcllib::toc::document $pdf a4 $inhalt -title "Inhalt"]
puts "Verzeichnis: [dict get $r tocPages] Seite(n),\
    Inhalt: [dict get $r contentPages] Seiten"
foreach e [dict get $r entries] { puts "  $e" }
$pdf write -file 110-inhaltsverzeichnis.pdf
$pdf destroy
```

```text
Verzeichnis: 1 Seite(n), Inhalt: 5 Seiten
  1 Einleitung 2
  2 {Zweck des Berichts} 2
  2 Datenquellen 3
  1 Bestand 4
  2 {Lager Nord} 4
  2 {Lager Süd} 5
  1 Ausblick 6
```

Das Verzeichnis selbst auf Seite 1:

```text
Inhalt
Einleitung ............................................. 2
    Zweck des Berichts ................................. 2
    Datenquellen ....................................... 3
Bestand ................................................ 4
    Lager Nord ......................................... 4
    Lager Süd .......................................... 5
Ausblick ............................................... 6
```

Die Seitenzahlen im Ergebnis sind schon um die Länge des Verzeichnisses
verschoben; sie stimmen mit dem fertigen PDF überein.

### Was das Skript nicht darf

Weil es zweimal läuft, darf das Skript **keine Nebenwirkungen** haben:
nicht in eine Datei anhängen, keinen Zähler außerhalb hochzählen, nicht
aus einem Kanal lesen, den der erste Lauf schon leer gelesen hat. Daten
werden vorher geladen, wie `kapitel` und `absatz` im Beispiel.

### Welcher Kontext gilt

`toc::document` baut seinen Kontext selbst, aus dem Papier mit
`page::context papier`, also mit 20 mm Rand und y nach unten. Ein `ctx`,
den der Aufrufer vorher gebaut hat, wird **nicht** benutzt, sondern
überschrieben: Nach dem Aufruf steht in `ctx` der Kontext von
`toc::document`, und in `pdf` wieder das echte Dokument. Wer einen
anderen Rand braucht, geht den Weg von Hand (Abschnitt
[Ein Deckblatt davor](#ein-deckblatt-davor)).

---

## Überschriften

```tcl
pdf4tcllib::toc::heading pdf ctx yVar ebene text ?option wert ...?
```

Die Ebene (1 bis 6) bestimmt drei Dinge: die Schriftgröße (18 minus 2 je
Ebene, mindestens 10), die Einrückung im Verzeichnis und im
barrierefreien PDF das Element `H1` bis `H6`. `yVar` ist der Name der
y-Variablen, wie bei den Formularprozeduren; sie steht danach unter der
Überschrift.

| Option | Bedeutung |
|---|---|
| `-size` | Schriftgröße statt der Vorgabe der Ebene |
| `-gap` | Abstand unter der Überschrift (Vorgabe 4) |
| `-tag` | Strukturelement statt `H<ebene>` |

Zwei Dinge macht `heading` nicht:

- **Fett setzen.** Die Überschrift läuft durch `text::writeParagraph` und
  steht in der normalen Schrift, nur größer. Eine fette Überschrift
  zeichnet man selbst und ruft `heading` nicht auf, dann fehlt sie aber
  im Verzeichnis.
- **Umbrechen.** `heading` prüft nicht, ob unter der Überschrift noch
  Platz ist. Das Beispiel beginnt darum jedes Kapitel der Ebene 1 auf
  einer neuen Seite und prüft vor jedem Absatz den unteren Rand.

---

## Optionen von toc::document

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-title` | `Contents` | Überschrift des Verzeichnisses |
| `-titlesize` | `16` | ihre Größe |
| `-size` | `11` | Größe der Einträge |
| `-leader` | `.` | Füllzeichen bis zur Seitenzahl; `""` für keines |
| `-indent` | `14` | Einrückung je Ebene in Punkt |
| `-gap` | `4` | Abstand unter jeder Überschrift |
| `-bookmarks` | `1` | ein Lesezeichen je Überschrift |

Die Vorgabe für `-title` ist englisch; für ein deutsches Dokument
gehört `-title "Inhalt"` dazu.

`-gap` und `-bookmarks` gelten für die Überschriften dieses Aufrufs;
danach steht die Konfiguration des Pakets wieder wie vorher. Für alle
folgenden Dokumente im selben Prozess:

```tcl
pdf4tcllib::toc::configure -bookmarks 0
```

Bis pdf4tcltoc 0.1 wirkten die beiden Optionen bei `toc::document`
nicht: `heading` las nur die Konfiguration, `-bookmarks 0` schrieb
trotzdem Lesezeichen. Beim Weg von Hand (unten) ruft man `heading` ohne
`document` auf; dort gilt weiter `toc::configure`.

---

## Ein Deckblatt davor

`toc::document` schreibt das Verzeichnis als Erstes ins Dokument. Ein
Deckblatt davor ist so nicht möglich. Die Bausteine, aus denen
`document` besteht, sind aber einzeln aufrufbar:
[toc::collect]{.index}, `toc::pageCount` und `toc::render`.

| Prozedur | tut |
|---|---|
| toc::collect `skript ?versatz?` | führt das Skript aus und gibt die Einträge zurück |
| `toc::pageCount ctx einträge ?option ...?` | wie viele Seiten das Verzeichnis braucht |
| `toc::render pdf ctx einträge ?option ...?` | schreibt das Verzeichnis, mit eigenen Seiten |

Damit lässt sich jede Reihenfolge bauen:

```tcl
# 110-mit-deckblatt.tcl -- Deckblatt vor dem Inhaltsverzeichnis
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltoc

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

set inhalt {
    foreach titel {Einleitung Bestand Ausblick} {
        $pdf startPage
        set y [dict get $ctx top]
        pdf4tcllib::toc::heading $pdf $ctx y 1 $titel
        $pdf endPage
    }
}

# 1. Probelauf in ein Wegwerf-Dokument: wo stehen die Ueberschriften?
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
set eintraege [pdf4tcllib::toc::collect $inhalt]
$pdf destroy

# 2. Seitenzahlen verschieben: um das Deckblatt und das Verzeichnis
set vorne 1
set n [pdf4tcllib::toc::pageCount $ctx $eintraege -title "Inhalt"]
set eintraege [lmap e $eintraege {
    lset e 2 [expr {[lindex $e 2] + $vorne + $n}]
}]

# 3. Das echte Dokument: Deckblatt, Verzeichnis, Inhalt
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
pdf4tcllib::page::centerText $pdf $ctx "Bestandsbericht" 300 28 \
    [pdf4tcllib::fonts::fontSansBold]
$pdf endPage
pdf4tcllib::toc::render $pdf $ctx $eintraege -title "Inhalt"
eval $inhalt

puts "Einträge: $eintraege"
puts "Seiten: [$pdf pageCount]"
$pdf write -file 110-mit-deckblatt.pdf
$pdf destroy
```

```text
Einträge: {1 Einleitung 3} {1 Bestand 4} {1 Ausblick 5}
Seiten: 5
```

Hier läuft das Skript im eigenen Bereich, sieht also den eigenen `ctx`
mit dem eigenen Rand. `collect` setzt keine Lesezeichen; die entstehen
erst beim zweiten Lauf mit `eval`. Die Verschiebung rechnet man selbst:
Seiten vor dem Verzeichnis plus Länge des Verzeichnisses.

`pageCount` und `render` müssen dieselben Optionen bekommen, sonst
stimmt die Zahl der Verzeichnisseiten nicht. `toc::document` prüft das
und wirft einen Fehler; der Weg von Hand prüft nichts.

---

## Zusammenfassung

- `toc::document` mit dem Inhalt als Skript ohne Nebenwirkungen; es läuft
  zweimal.
- Überschriften mit `toc::heading`; sie stehen in der normalen Schrift
  und brechen nicht selbst um.
- Der Kontext kommt aus dem Papier, nicht vom Aufrufer.
- Lesezeichen abschalten mit `-bookmarks 0` beim Aufruf oder
  `toc::configure -bookmarks 0` für alle Dokumente.
- Deckblatt davor: `collect`, `pageCount`, `render` von Hand.

---

*Nächstes Kapitel: [Formular-Layout](120-formular-layout.md)*
