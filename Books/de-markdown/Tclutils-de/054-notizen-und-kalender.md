# Notizen und Kalender

Markdown, iCalendar mit Wiederholungsregeln, vCard, ein Notizbaum im
Speicher und in SQLite, ein Monatskalender als Text und die
bundesweiten Feiertage. Alles liegt im Umbrella und ist reines Tcl;
`tunotesdb` braucht beim Aufruf `sqlite3` mit FTS5. `tuvcard` nutzt
dazu `tubase64`.

---

## Markdown: tumd

[tumd]{.index} setzt eine Teilmenge von CommonMark in ein HTML-Fragment, ohne
`<html>`-Rahmen. Überschriften sind ATX (`#` bis `######`). Dazu kommen
Absätze, eingezäunter Code, Zitate, flache Listen und waagerechte
Linien. Im Fließtext: Code in Gravis, `**fett**`, `*kursiv*`, Links,
Bilder und Autolinks. Verschachtelte Listen, Setext-Überschriften,
Tabellen und Referenzlinks bleiben stehen, wie sie sind, und werden
nicht als solche erkannt. Eine eingerückte Liste wird eine flache Liste.

`frontmatter` trennt einen YAML-Kopf zwischen zwei Zeilen `---`. Fehlt
der schließende Strich, bleibt der Kopf leer und der Text ganz.
`toHtml` lässt den Kopf weg. `headings` liefert Paare aus Stufe und
Text. `toc` baut eine Liste mit Ankern. Der Anker ist kleingeschrieben,
nur aus `a`–`z`, Ziffern, Leerzeichen und Bindestrich. Andere Zeichen
fallen weg.

```tcl
package require tclutils::tumd
::tclutils::tumd::toHtml "# Größe\n\nEin **Regal** und `x < y`."
                                          ;# -> <h1 id="gre">Größe</h1>\n<p>Ein <strong>Regal</strong> und <code>x &lt; y</code>.</p>
::tclutils::tumd::headings "# Größe"       ;# -> {1 Größe}
::tclutils::tumd::toc "# Größe"            ;# -> - [Größe](#gre)
::tclutils::tumd::frontmatter "---\ntitle: Lager\n---\n# Lager\n"
                                          ;# -> {title: Lager} {# Lager\n}
::tclutils::tumd::toHtml "- a\n  - b"      ;# -> <ul>\n<li>a</li>\n<li>b</li>\n</ul>
```

Der Anker von „Größe“ ist `gre`. `tustr::slugify` macht daraus `gr-e`.

---

## iCalendar: tuical

`parse` liest den Text in eine Liste von Komponenten. Eine Komponente
ist ein Dict mit `type`, `props` und `components`. Eine Eigenschaft ist
ein Dict mit `name`, `value` und `params`. Der Wert bleibt roh, wie in
der Datei. `escapeText` und `unescapeText` setzen `\`, `;`, `,` und den
Zeilenumbruch nach RFC 5545. `eventInfo`, `todoInfo` und `journalInfo`
lösen die Textfelder auf. Eine Fortsetzungszeile beginnt mit Leerzeichen
oder Tabulator.

`events`, `todos` und `journals` suchen `VEVENT`, `VTODO` und
`VJOURNAL` auch in verschachtelten Komponenten. `newComponent` baut
eine Komponente aus einer flachen Liste `Name Wert`. `toIcs` schreibt
sie zurück, jede Zeile mit CR/LF.

```tcl
package require tclutils::tuical
set ics "BEGIN:VCALENDAR\nBEGIN:VEVENT\nUID:1\nSUMMARY:Lager\\, Nord\nDTSTART:20240315T090000\nEND:VEVENT\nEND:VCALENDAR\n"
set ev [lindex [::tclutils::tuical::events [::tclutils::tuical::parse $ics]] 0]
dict get [::tclutils::tuical::eventInfo $ev] summary
                                          ;# -> Lager, Nord
dict get [::tclutils::tuical::eventInfo $ev] dtstart
                                          ;# -> 20240315T090000
::tclutils::tuical::escapeText "a;b\nc"    ;# -> a\;b\nc
```

Eine Zeile ohne Doppelpunkt und ein `END` ohne `BEGIN` werfen
`{TCLUTILS TUICAL SYNTAX}`. Eine Eigenschaftsliste mit ungerader Länge
wirft `{TCLUTILS TUICAL ARG}`.

---

## Wiederholungen: turrule

[turrule]{.index} rechnet eine Wiederholungsregel `RRULE` aus iCalendar
(RFC 5545) in einzelne Termine um. Gerechnet wird in UTC.

| Befehl | Wirkung |
|---|---|
| `parse rrule` | Dict der Teile; Schlüssel in Großbuchstaben, Werte wie geschrieben |
| `occurrences ?optionen?` | Liste der Termine |
| `eventsInRange ics von bis` | Liste von Dicts `uid summary start` für alle `VEVENT` im Zeitraum; lädt `tuical` |

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-dtstart` | | Beginn, Pflicht; `JJJJ-MM-TT`, `JJJJMMTT`, auch mit Uhrzeit `THHMMSS` oder `THH:MM:SS`; ein `Z` am Ende fällt weg |
| `-rule` | | die Regel ohne `RRULE:` |
| `-from` | `-dtstart` | frühere Termine erscheinen nicht |
| `-to` | | spätere Termine erscheinen nicht |
| `-count` | `0` | höchstens so viele Termine; `0` ohne Grenze |

| Teil der Regel | Umfang |
|---|---|
| `FREQ` | `DAILY`, `WEEKLY`, `MONTHLY`, `YEARLY` |
| `INTERVAL` | Abstand der Perioden, Vorgabe 1 |
| `COUNT` | Zahl der Termine, gezählt ab `-dtstart` |
| `UNTIL` | spätester Zeitpunkt; als Datum ohne Uhrzeit der ganze Tag |
| `BYDAY` | Wochentage `MO` bis `SU`; `MONTHLY`, `YEARLY`: auch mit Ordnungszahl wie `1MO`, `4TH` oder `-1FR` |
| `BYMONTHDAY` | Tage des Monats, negativ vom Monatsende; nicht mit `WEEKLY` |
| `BYMONTH` | Monate 1–12; `YEARLY` nimmt diese Monate, sonst grenzt es ein |
| `WKST` | nur `MO` |

`YEARLY` rechnet so: Mit `BYMONTH` gilt jeder genannte Monat, eine
Ordnungszahl in `BYDAY` zählt im Monat (`BYMONTH=11;BYDAY=4TH` ist der
vierte Donnerstag im November). Ohne `BYMONTH` gilt `BYMONTHDAY` in
jedem Monat, und eine Ordnungszahl in `BYDAY` zählt im Jahr
(`BYDAY=20MO` ist der 20. Montag). Ohne diese Teile bleibt der
Jahrestag von `-dtstart`. Stehen `BYDAY` und `BYMONTHDAY` zusammen,
bleiben nur Tage, die beide erfüllen (`BYDAY=FR;BYMONTHDAY=13`). Ein
Monatstermin am 31. überspringt Monate ohne 31. Tag, ein Jahrestermin
am 29. Februar die Jahre ohne Schalttag.

Andere Teile wie `BYSETPOS`, `BYWEEKNO`, `BYYEARDAY`, `BYHOUR` oder ein
`WKST` außer `MO` werfen `{TCLUTILS TURRULE UNSUPPORTED}`, statt
wegzufallen.

`COUNT` zählt ab `-dtstart`; `-from` und `-to` schneiden nur die
Ausgabe zu. Ein `-dtstart` ohne Uhrzeit liefert Daten, eines mit
Uhrzeit liefert `JJJJ-MM-TTTHH:MM:SS` mit derselben Uhrzeit. `UNTIL`
ohne Uhrzeit schließt den ganzen Tag ein: ein Termin um 09:00 am Tag
von `UNTIL` gehört dazu.

```tcl
package require tclutils::turrule
::tclutils::turrule::parse "FREQ=WEEKLY;BYDAY=TU,TH;COUNT=4"
    ;# -> FREQ WEEKLY BYDAY TU,TH COUNT 4
::tclutils::turrule::occurrences -dtstart 2025-10-01 \
    -rule "FREQ=WEEKLY;BYDAY=TU,TH;COUNT=4"
    ;# -> 2025-10-02 2025-10-07 2025-10-09 2025-10-14
::tclutils::turrule::occurrences -dtstart 2025-01-31 \
    -rule "FREQ=MONTHLY;BYMONTHDAY=-1" -count 3
    ;# -> 2025-01-31 2025-02-28 2025-03-31
::tclutils::turrule::occurrences -dtstart 20251002T090000 \
    -rule "FREQ=DAILY;INTERVAL=2" -count 2
    ;# -> 2025-10-02T09:00:00 2025-10-04T09:00:00
set ics "BEGIN:VCALENDAR\nBEGIN:VEVENT\nUID:4\nSUMMARY:Standup\n"
append ics "DTSTART:20251002T090000\nRRULE:FREQ=WEEKLY\n"
append ics "END:VEVENT\nEND:VCALENDAR\n"
set ev [::tclutils::turrule::eventsInRange $ics 2025-10-01 2025-10-10]
lmap e $ev {dict get $e start}
    ;# -> 2025-10-02T09:00:00 2025-10-09T09:00:00
::tclutils::turrule::occurrences -dtstart 2025-01-01 \
    -rule "FREQ=YEARLY;BYMONTH=11;BYDAY=4TH;COUNT=2"
    ;# -> 2025-11-27 2026-11-26
::tclutils::turrule::occurrences -dtstart 2025-01-01 \
    -rule "FREQ=MONTHLY;BYDAY=FR;BYMONTHDAY=13;COUNT=2"
    ;# -> 2025-06-13 2026-02-13
::tclutils::turrule::occurrences -dtstart 2025-01-06T09:00:00 \
    -rule "FREQ=WEEKLY;UNTIL=20250120"
    ;# -> 2025-01-06T09:00:00 2025-01-13T09:00:00 2025-01-20T09:00:00
```

Ohne `-to`, `-count`, `COUNT` und `UNTIL` wirft `occurrences`
`{TCLUTILS TURRULE UNBOUNDED}`. Eine Regel ohne `FREQ` oder mit einer
anderen Frequenz als den vier oben wirft `{TCLUTILS TURRULE FREQ}`,
ein unlesbares Datum `{TCLUTILS TURRULE DATE}`. Ein unbekanntes
Wochentagskürzel wie `XX`, die Ordnungszahl 0 oder eine Ordnungszahl
bei `DAILY` und `WEEKLY` werfen `{TCLUTILS TURRULE BYDAY}`, ein Monat
außerhalb 1–12 in `BYMONTH` oder ein Tag außerhalb ±1–31 in
`BYMONTHDAY` `{TCLUTILS TURRULE VALUE}`.

---

## vCard: tuvcard

`parse` liefert eine Liste von Karten. Eine Karte ist eine Liste von
Eigenschafts-Dicts, derselbe Aufbau wie bei `tuical`. `property` gibt
den ersten Wert eines Namens, `get` alle Werte, `fullName` die
Eigenschaft `FN`. `toVcf` schreibt CR/LF. Groß- und Kleinschreibung des
Namens spielt keine Rolle.

```tcl
package require tclutils::tuvcard
set vcf "BEGIN:VCARD\nFN:Gregor\nN:Nachname;Gregor;;;\nTEL:1\nEND:VCARD\n"
set card [lindex [::tclutils::tuvcard::parse $vcf] 0]
::tclutils::tuvcard::fullName $card          ;# -> Gregor
::tclutils::tuvcard::get $card TEL           ;# -> 1
::tclutils::tuvcard::names $card             ;# -> FN N TEL
```

Eine Zeile ohne Doppelpunkt wirft `{TCLUTILS TUVCARD SYNTAX}`.

---

## Notizbaum: tunotes

Ein Speicher ist ein Dict von Id auf Notiz. Die Notiz hat `id`,
`parent_id`, `title`, `content`, `created`, `modified` und `tags`.
`create`, `update` und `delete` bekommen den Namen der Variablen und
ändern sie. `get`, `search`, `count`, `roots` und `children` bekommen
den Wert. Die Id ist `clock microseconds`.

`search` vergleicht Titel und Inhalt mit `string match`, ohne Rücksicht
auf Großbuchstaben. Ein Stern in der Frage ist ein Musterzeichen.
`toJson` und `fromJson` gehen über `tujson`. Fehlende Felder füllt
`fromJson` leer auf. `load` einer fehlenden Datei ergibt einen leeren
Speicher. `delete` mit dem dritten Argument `1` (Vorgabe) entfernt den
Zweig, mit `0` hängen die Kinder an der Wurzel.

```tcl
package require tclutils::tunotes
set store [dict create]
set id [::tclutils::tunotes::create store Lager "Regal 3" {ort}]
dict get [::tclutils::tunotes::get $store $id] title
                                          ;# -> Lager
dict get [::tclutils::tunotes::get $store $id] tags
                                          ;# -> ort
::tclutils::tunotes::count $store           ;# -> 1
set gelesen [::tclutils::tunotes::fromJson {{"7":{"title":"Lager"}}}]
dict get [dict get $gelesen 7] title        ;# -> Lager
dict get [dict get $gelesen 7] parent_id    ;# ->
```

Eine unbekannte Id wirft `{TCLUTILS TUNOTES NOTFOUND}`, ebenso ein
`create` mit fehlendem Elter.

---

## Notizen in SQLite: tunotesdb

[tunotesdb]{.index} speichert dieselben Notizen wie `tunotes` in SQLite, je
Notiz eine Zeile, mit einem FTS5-Index für die Volltextsuche. Wie
`tusqlite` lädt das Modul `sqlite3` nicht: der Aufrufer öffnet die
Datenbank und übergibt das Handle. Das Notiz-Dict hat denselben Aufbau
wie in `tunotes`; `parent_id` ist bei einer Wurzel leer.

`init db` legt Tabelle, FTS5-Index und drei Trigger an, falls sie
fehlen, und schaltet `journal_mode = WAL` und `foreign_keys` ein. Ein
wiederholter Aufruf schadet nicht.

| Befehl | Wirkung |
|---|---|
| `create db titel inhalt ?tags? ?elter?` | die neue Id aus `clock microseconds` |
| `update db id titel inhalt ?tags? ?elter?` | die Id; `elter` hat die Vorgabe `KEEP` und bleibt dann |
| `get db id`, `exists db id` | das Notiz-Dict bzw. 1 oder 0 |
| `delete db id ?kaskade?` | `1` (Vorgabe) löscht den Zweig, `0` macht die Kinder zu Wurzeln |
| `move db id elter` | die Id; eine Notiz unter sich selbst oder ein Kind wird abgelehnt |
| `ids db`, `count db` | alle Ids bzw. ihre Zahl |
| `roots db`, `children db elter` | Wurzeln bzw. direkte Kinder; `children db ""` sind die Wurzeln |
| `descendants`, `ancestors`, `parent`, `path`, `depth`, `siblings`, `subtree` | der Baum über `WITH RECURSIVE`; `path` beginnt an der Wurzel |
| `search db frage ?optionen?` | Treffer-Dicts `id title snippet rank`, bester zuerst |
| `byTag db tag`, `tags db` | Ids mit dem Tag bzw. alle Tags, sortiert |
| `toStore db`, `fromStore db store ?-clear 1?` | die Brücke zu einem `tunotes`-Speicher |

| Option von `search` | Vorgabe | Wirkung |
|---|---|---|
| `-limit` | `50` | höchstens so viele Treffer; `0` für alle |
| `-snippet` | `10` | Wörter Kontext im Ausschnitt; der Treffer steht in `[` `]` |

Die Frage geht unverändert an FTS5: mehrere Wörter heißen UND,
`"wort folge"` ist eine Phrase, `wort*` ein Präfix, `OR` und `NOT`
gelten wie geschrieben. Der Tokenizer `unicode61` mit
`remove_diacritics 2` sucht ohne Rücksicht auf Groß- und
Kleinschreibung und auf Akzente. Tags liegen als Tcl-Liste in einer
Spalte; `byTag` vergleicht in Tcl.

```tcl
package require sqlite3
package require tclutils::tunotesdb
sqlite3 db :memory:
::tclutils::tunotesdb::init db
set a [::tclutils::tunotesdb::create db Lager "Regal 3 Nord" ort]
set b [::tclutils::tunotesdb::create db Regal "Fach 2, Schrauben" \
    {} $a]
::tclutils::tunotesdb::count db             ;# -> 2
expr {[::tclutils::tunotesdb::parent db $b] == $a}
                                          ;# -> 1
::tclutils::tunotesdb::depth db $b          ;# -> 1
set h [lindex [::tclutils::tunotesdb::search db schraube*] 0]
dict get $h snippet                         ;# -> Fach 2, [Schrauben]
::tclutils::tunotesdb::tags db              ;# -> ort
```

`fromStore` liest den Speicher in einer Transaktion ein. Eine Notiz
mit vorhandener Id wird an Ort und Stelle geändert; ihre Kinder in der
Datenbank bleiben. Die Reihenfolge im Speicher spielt keine Rolle, ein
Kind darf vor seinem Elter stehen: die Prüfung der Fremdschlüssel
wartet bis zum Ende der Transaktion. Jeder `parent_id` muss im
Speicher oder in der Datenbank stehen, sonst wirft `fromStore`
`NOTFOUND` und nimmt alles zurück.

```tcl
set st [::tclutils::tunotesdb::toStore db]
dict set st $a title Lagerhalle
::tclutils::tunotesdb::fromStore db [dict create $a [dict get $st $a]]
                                          ;# -> 1
::tclutils::tunotesdb::count db             ;# -> 2
expr {[::tclutils::tunotesdb::path db $b] eq [list $a $b]}
                                          ;# -> 1
```

Der `-errorcode` ist `{TCLUTILS TUNOTESDB grund}`:

| Grund | Fall |
|---|---|
| `NODB` | das Handle ist kein brauchbarer `sqlite3`-Befehl |
| `NOFTS5` | SQLite ohne FTS5 |
| `NOTFOUND` | keine Notiz mit der Id, oder kein solcher Elter (auch ein `parent_id` an `fromStore`) |
| `CYCLE` | `move` unter sich selbst oder einen Nachfahren |
| `BADQUERY` | FTS5 kann die Frage nicht lesen, etwa `"offen` |
| `BADOPTION` | unbekannte Option oder `-limit` keine Zahl ≥ 0 |
| `BADNOTE` | einer Notiz an `fromStore` fehlt ein Feld |

---

## Monatskalender: tucal

[tucal]{.index} gibt Kalender als Text aus, wie das Kommando `cal`. Das
Gegenstück als PNG ist `tumonthpng` im Kapitel
[Bilder ohne Tk](058-bilder-ohne-tk.md).

| Befehl | Wirkung |
|---|---|
| `month ?monat? ?jahr? ?optionen?` | ein Monat; ohne Angabe der laufende Monat, ohne Jahr das laufende Jahr (UTC) |
| `now ?…?` | dasselbe wie `month` |
| `render jahr monat ?optionen?` | ein Monat, das Jahr zuerst |
| `three ?monat? ?jahr? ?optionen?` | Vormonat, Monat und Folgemonat nebeneinander |
| `year jahr ?optionen?` | das ganze Jahr in vier Zeilen zu je drei Monaten |

Eine einzelne vierstellige Zahl ab 1900 an `month` gilt als Jahr und
liefert `year`. In `year` laufen die Monate zeilenweise wie bei
`cal`: die erste Zeile zeigt Januar, Februar und März.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-mondayfirst` | `0` | `1` beginnt die Woche am Montag |
| `-weeknumbers` | `0` | `1` setzt die Kalenderwoche links davor; mit Montag zuerst nach ISO (`%V`), sonst `%U` |
| `-iso` | `0` | `1` setzt `-mondayfirst 1` und `-weeknumbers 1` |
| `-locale` | | Locale von `clock format` für Monatsnamen und Wochentage, etwa `de_DE`; leer bleibt es englisch (`Su Mo Tu …`) |

Jede Option braucht einen Wert; `-iso` allein reicht nicht. Die
Rückgabe ist Text mit `\n`, ohne Zeilenumbruch am Ende. Eine Tageszelle
ist in `month`, `render` und `three` drei Zeichen breit, in `year`
zwei; ein Monat ist damit 27 bzw. 20 Zeichen breit, mit Kalenderwoche
4 Zeichen mehr. Der Monatstitel steht mittig über den Tagesspalten.
`three` und `year` setzen die Monate mit zwei Leerzeichen Abstand
nebeneinander; das Jahr in `year` steht mittig über der ganzen Breite.
Keine Zeile endet mit einem Leerzeichen.

```tcl
package require tclutils::tucal
puts [::tclutils::tucal::month 5 2026 -locale de_DE -iso 1]
set kal [::tclutils::tucal::month 2 2026]
llength [split $kal \n]                     ;# -> 6
set titel [lindex [split $kal \n] 0]
string first F $titel                       ;# -> 7
string trim $titel                          ;# -> February 2026
set j [split [::tclutils::tucal::year 2026] \n]
regexp -all -inline {[A-Z][a-z]+} [lindex $j 2]
                                          ;# -> January February March
```

Die Ausgabe von `puts`:

```text
             Mai 2026
     Mo  Di  Mi  Do  Fr  Sa  So
18                    1   2   3
19    4   5   6   7   8   9  10
20   11  12  13  14  15  16  17
21   18  19  20  21  22  23  24
22   25  26  27  28  29  30  31
```

Ein Monat außerhalb 1–12 wirft `{TCLUTILS TUCAL MONTH}`, ein Jahr
kleiner 1 `{TCLUTILS TUCAL YEAR}`. Mehr als zwei Zahlen werfen
`{TCLUTILS TUCAL ARGS}`, eine Option ohne Wert
`{TCLUTILS TUCAL OPTION}`, eine unbekannte Option
`{TCLUTILS COMMON OPTION -name}`.

---

## Feiertage: tuholiday

`easter` rechnet den Ostersonntag im gregorianischen Kalender
(Meeus/Jones/Butcher) und gibt ein ISO-Datum. `holidays` liefert ein
Dict Datum auf Name, sortiert. `-region` kennt nur `de`: die Tage, die
in allen Ländern gelten, dazu Ostersonntag und Pfingstsonntag. Heilige
Drei Könige, Fronleichnam, Allerheiligen und der Reformationstag fehlen.
`isHoliday` gibt den Namen oder die leere Zeichenkette.

| Abstand zu Ostern | Name |
|---|---|
| −2 | Karfreitag |
| 0 | Ostersonntag |
| +1 | Ostermontag |
| +39 | Christi Himmelfahrt |
| +49 | Pfingstsonntag |
| +50 | Pfingstmontag |

Fest liegen Neujahr, der Tag der Arbeit, der Tag der Deutschen Einheit
und die beiden Weihnachtstage. 2024 hat das Dict elf Einträge.

```tcl
package require tclutils::tuholiday
::tclutils::tuholiday::easter 2024           ;# -> 2024-03-31
::tclutils::tuholiday::easter 2025           ;# -> 2025-04-20
::tclutils::tuholiday::isHoliday 2024-03-31  ;# -> Ostersonntag
::tclutils::tuholiday::isHoliday 2024-03-15  ;# ->
```

`easter xyz` wirft `{TCLUTILS TUHOLIDAY YEAR}`. `-region at` wirft
`{TCLUTILS TUHOLIDAY REGION}`.

---

## Merkliste

- `tumd` ist eine Teilmenge. Der Anker von „Größe“ ist `gre`.
- iCalendar- und vCard-Werte bleiben roh. `eventInfo` löst Text auf.
- `toIcs` und `toVcf` schreiben CR/LF.
- `tunotes`: ändern über den Variablennamen, lesen über den Wert.
- Feiertage: nur `de`, elf Namen, keine landesspezifischen Tage.
- `turrule` braucht eine Grenze: `-to`, `-count`, `COUNT` oder `UNTIL`. Nicht unterstützte Teile werfen `UNSUPPORTED`.
- `tunotesdb`: Handle selbst öffnen, dann `init`. `fromStore` ändert vorhandene Notizen an Ort und Stelle.
- `tucal` ist Text wie `cal`; als PNG `tumonthpng`.

---

*Nächstes Kapitel: [Text aus PDF-Dateien](055-pdf-text.md)*
