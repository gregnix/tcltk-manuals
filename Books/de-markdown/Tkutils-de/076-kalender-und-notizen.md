# Kalender und Notizen

Monat, Woche und Aufgaben in der Oberfläche. Die Engines bleiben in
tclutils (`tucal`, `tuical`, `tunotes`, `tuvcard`, `tuldif`). `tkutical`
und `tkumonthcanvas` brauchen zusätzlich tical und stehen außerhalb des
Umbrellas. Wie tical auf den `auto_path` kommt, steht im Kapitel
[tkutils verstehen](010-tkutils-verstehen.md); tical selbst, seine Views
und Renderer beschreibt das Buch *Utils-Stack*.

---

## Monat zum Anklicken: tkucalendar

[tkucalendar]{.index} 0.2 ist ein Monat aus Tagesknöpfen.

```tcl
::tkutils::tkucalendar::widget       pfad ?option wert ...?
::tkutils::tkucalendar::getDate      pfad
::tkutils::tkucalendar::getFormatted pfad
::tkutils::tkucalendar::setDate      pfad iso
::tkutils::tkucalendar::today        pfad
::tkutils::tkucalendar::next         pfad
::tkutils::tkucalendar::prev         pfad
::tkutils::tkucalendar::getMonth     pfad
```

`getDate` liefert das gewählte ISO-Datum oder `""`. `getFormatted`
nutzt `-dateformat`. `getMonth` liefert `jjjj mm` des angezeigten
Monats. `next` und `prev` blättern einen Monat.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-date` | keines | anfangs gewählter Tag, ISO |
| `-firstday` | `monday` | `monday` oder `sunday` |
| `-dateformat` | `%Y-%m-%d` | Format für `getFormatted` |
| `-locale` | die aktuelle | Monats- und Wochentagsnamen |
| `-command` | leer | Skript, das ISO-Datum wird angehängt |

Die Eingabezeile mit demselben Kalender als Aufklappfenster ist
`tkudateentry` im Kapitel [Eingabe](074-eingabe.md).

---

## Textkalender: tkucal

[tkucal]{.index} 0.1 zeigt den Monat als Text über `tclutils::tucal`.

```tcl
set w [::tkutils::tkucal::widget .w ?-year j? ?-month m? ?-weeknumbers 0|1?]
::tkutils::tkucal::setMonth $w jahr monat
::tkutils::tkucal::getMonth $w
::tkutils::tkucal::next     $w
::tkutils::tkucal::prev     $w
::tkutils::tkucal::today    $w
::tkutils::tkucal::getText  $w
```

`setMonth` und `getMonth` liefern `{jahr monat}`. Ein ungültiger Monat
wirft den Fehler von `tucal`, etwa `{TCLUTILS TUCAL MONTH}` mit
`invalid month 13`. Die Woche beginnt am Sonntag, wie bei `cal`. `getText` ist der gezeichnete Kalendertext.

---

## tical: tkutical und tkumonthcanvas

[tkutical]{.index} 0.4 zeichnet Monat oder Woche über tical.

```tcl
set w [::tkutils::tkutical::widget .w ?-year j? ?-month m? \
    ?-weeknumbers 0|1? ?-fontsize n? ?-holidays region? \
    ?-selectmode none|single|multiple? ?-command befehl? ?-events liste?]
::tkutils::tkutical::setMonth $w jahr monat
::tkutils::tkutical::getSelection $w
::tkutils::tkutical::setSelection $w {daten und A..B}
```

`setMonth` liefert `{jahr monat}` und wirft bei einem ungültigen Monat.
`getSelection` liefert sortierte ISO-Daten. `-events` und `setEvents`
(seit 0.4) nehmen Termine im Format von `tical::event`; sie erscheinen
als Punkte im Monat und als Titel in der Woche, eine Serie an jedem
ihrer Tage. Das braucht tical 1.1 oder neuer, sonst
`{TKUTILS TKUTICAL EVENTS}`.

[tkumonthcanvas]{.index} 0.5 zeichnet Monat, Quartal und Jahr auf eine
bestehende Zeichenfläche. `init` setzt Schrift und Thema, bevor
gezeichnet wird.

```tcl
::tkutils::tkumonthcanvas::init ?-fontsize 11? ?-font Arial?
::tkutils::tkumonthcanvas::drawMonth   $c jahr monat ?x0 y0?
::tkutils::tkumonthcanvas::drawQuarter $c jahr monat ?x0 y0?
::tkutils::tkumonthcanvas::drawYear    $c jahr ?x0 y0 spalten?
::tkutils::tkumonthcanvas::clear       $c
::tkutils::tkumonthcanvas::setSelectMode none|single|multiple
::tkutils::tkumonthcanvas::getSelection
::tkutils::tkumonthcanvas::setTheme default|dark|light
::tkutils::tkumonthcanvas::addNote datum text
```

`drawQuarter` nimmt irgendeinen Monat des Quartals. `setCallback`
kennt `day`, `week`, `month` und `select`. Themen sind `default`,
`dark` und `light`, dazu `defineTheme`.

---

## Termine: tkuical

[tkuical]{.index} 0.3 zeigt die `VEVENT`-Einträge eines iCalendar-Textes
in einer Tabelle: Summary, Start, Ende, Ort. Die Engine ist
`tclutils::tuical`.

```tcl
set w [::tkutils::tkuical::widget .w]
::tkutils::tkuical::loadText      $w text
::tkutils::tkuical::loadFile      $w datei
::tkutils::tkuical::setComponents $w komponenten
::tkutils::tkuical::events        $w
::tkutils::tkuical::count         $w
::tkutils::tkuical::toText        $w
::tkutils::tkuical::save          $w datei
```

`loadText` liefert die Zahl der Termine. `-editable 1` ist die Vorgabe
und zeigt eine Leiste für Summary, Start, Ende und Ort. `addEvent`,
`removeEvent` und `setField` ändern einen Termin. `setField` kennt
`summary`, `start`, `end` und `location`. Andere Eigenschaften und
Komponenten, die keine Termine sind, bleiben beim Schreiben erhalten,
an ihrer Stelle: Eine Aufgabe nach dem Termin steht danach wieder dort.
`loadFile` und `save` arbeiten in UTF-8, gleich welches Encoding das
System hat; `save` schreibt die Zeilenenden CRLF einmal (bis 0.2
`\r\r\n`). Mit `tuical` 0.2 endet auch die letzte Zeile mit CRLF; eine
Datei, die ohne Änderung gelesen und geschrieben wird, bleibt dann bis
auf die Faltung langer Zeilen gleich.

---

## Aufgaben: tkutodo

[tkutodo]{.index} 0.2 zeigt `VTODO`-Komponenten: Summary, Fälligkeit,
Priorität, Prozent. `-editable 1` lässt den Status umschalten, auch mit
Leertaste und Doppelklick.

```tcl
set w [::tkutils::tkutodo::widget .t ?-editable 1? ?-onchange befehl?]
::tkutils::tkutodo::loadText $w text
::tkutils::tkutodo::setTodos $w komponenten
::tkutils::tkutodo::todos    $w
::tkutils::tkutodo::count    $w
::tkutils::tkutodo::toggle   $w ?index?
```

Erledigt setzt `STATUS` auf `COMPLETED`, `PERCENT-COMPLETE` auf `100`
und einen Zeitstempel `COMPLETED`. Zurück setzt `NEEDS-ACTION`,
`PERCENT-COMPLETE` auf `0` und entfernt `COMPLETED`.

---

## Notizen: tkunotes

[tkunotes]{.index} 0.4 ist ein Baum links und ein Editor rechts. Speichern
und Suche kommen von `tclutils::tunotes`.

```tcl
set w [::tkutils::tkunotes::widget .w ?-file notizen.json? ?-toolbar 0?]
::tkutils::tkunotes::addRoot  $w titel inhalt ?tags?
::tkutils::tkunotes::addChild $w eltern titel inhalt ?tags?
::tkutils::tkunotes::commit   $w ?id?
::tkutils::tkunotes::delete   $w id ?cascade?
::tkutils::tkunotes::search   $w text
::tkutils::tkunotes::load     $w datei
::tkutils::tkunotes::save     $w ?datei?
::tkutils::tkunotes::store    $w
```

`addRoot` liefert die Id. `search` liefert Ids. `load` liefert die
Zahl. `commit` schreibt die Felder des Editors in den Speicher.
`store` ist das Dict von `tunotes`. Die Leiste ist an; `-toolbar 0`
blendet sie aus. Ihr Knopf „Save“ übernimmt die Felder und schreibt
seit 0.3 auch die JSON-Datei (`-file`, die zuletzt geladene oder
gespeicherte, sonst fragt er); bis 0.2 tat er nur `commit`. Im Feld
„Tags“ trennt ein Komma die Tags, `Arbeit Büro, privat` sind zwei (bis
0.2 war jedes Wort ein Tag). Seit 0.4 bleiben Änderungen erhalten, wenn
eine andere Notiz gewählt wird (Klick im Baum, `select`, neue Notiz,
Suchtreffer): Titel, Tags und Inhalt der bisherigen gehen in den
Speicher. Bis 0.3 waren sie ohne „Save“ verloren. Die Datei schreibt
weiter nur „Save“ oder `save`.

---

## Kontakte und LDIF

[tkuvcard]{.index} 0.3 zeigt jede Karte als Knoten mit `FN` und die
Eigenschaften als Kinder. Die Engine ist `tclutils::tuvcard`.

```tcl
set w [::tkutils::tkuvcard::widget .w]
::tkutils::tkuvcard::loadText $w text
::tkutils::tkuvcard::cards    $w
::tkutils::tkuvcard::count    $w
```

`loadText` liefert die Zahl der Karten. `-editable 1` ist die Vorgabe.
`setProperty` ändert Name, Wert und `TYPE` einer Zeile und behält die
übrigen Parameter wie `PREF` (bis 0.2 gingen sie verloren); mehrere
Typen stehen durch Komma getrennt (`"CELL, VOICE"`). Dateien liest und
schreibt `tkuvcard` in UTF-8 mit CRLF.

[tkuldif]{.index} 0.3 zeigt jeden LDIF-Eintrag als Knoten mit `dn` und
jede Attributzeile als Kind. Die Engine ist `tclutils::tuldif`.
`loadText` liefert die Zahl der Einträge. `-editable 1` ist die
Vorgabe. `entries` liefert die Einträge. Dateien in UTF-8. Mit `tuldif`
0.3 behalten Binärattribute wie `jpegPhoto` beim Speichern ihre Bytes.

---

## Rechner: tkucalc

[tkucalc]{.index} 0.2 ist ein Taschenrechner. `evaluate` rechnet ohne
Fenster, das Paket fordert trotzdem Tk an.

```tcl
::tkutils::tkucalc::widget       pfad ?-onresult befehl? ?-history 0?
::tkutils::tkucalc::evaluate     text
::tkutils::tkucalc::clear        pfad
::tkutils::tkucalc::getHistory   pfad
::tkutils::tkucalc::clearHistory pfad
```

`evaluate` ersetzt das deutsche Dezimalkomma durch einen Punkt, `^`
durch `**` und die Zeichen × ÷ − durch `*` `/` `-`. Außer Ziffern,
Operatoren, Klammern, Punkt, `e`, Leerzeichen, `^` und `%` wirft der
Text `invalid characters in expression`. Ein leerer Text wirft
`empty expression`. Beide ohne eigenen `-errorcode`.

Ohne `%` wird jede ganze Zahl zu `n.0`, damit `10/4` eine
Gleitkommadivision ist. Mit `%` bleibt die Zahl ganz, weil Modulo
ganze Operanden braucht. Die Rechnung läuft in einem sicheren
Interpreter. `Inf`, `-Inf` und `NaN` werden zu `divide by zero`. Ein
Ergebnis mit Endung `.0` verliert diese Endung.

`-history 1` zeigt die bisherigen Zeilen. `-onresult` bekommt das
Ergebnis.

---

## Merkliste

- `tkucalendar::getDate` ist ISO. `getFormatted` folgt `-dateformat`.
- `tkutical` und `tkumonthcanvas` brauchen tical und ein eigenes `package require`.
- `tkuical` und `tkutodo` lesen iCalendar über `tuical`.
- `tkucalc::evaluate` rechnet in einem sicheren Interpreter.

---

*Nächstes Kapitel: [Daten ansehen](078-daten-ansehen.md)*
