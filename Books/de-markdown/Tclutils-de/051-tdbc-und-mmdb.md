# TDBC und MaxMind

[tutdbc]{.index} 0.1 spricht eine TDBC-Verbindung an, die der Aufruf
schon geöffnet hat. Das Modul lädt keinen Treiber und steht nicht im
Umbrella. [tummdb]{.index} 0.1 liest eine MaxMind-DB der Fassung 2.0.
Es liegt im Umbrella und baut auf `tubin`.

---

## TDBC: tutdbc

```tcl
package require tclutils::tutdbc
::tclutils::tutdbc::insert  verbindung tabelle dict
::tclutils::tutdbc::rows    verbindung sql ?bindungen?
::tclutils::tutdbc::value   verbindung sql ?bindungen? ?vorgabe?
::tclutils::tutdbc::execute verbindung sql ?bindungen?
::tclutils::tutdbc::transaction verbindung skript
::tclutils::tutdbc::quoteId name
::tclutils::tutdbc::null
```

Platzhalter im SQL heißen `:name`. Die Bindungen sind ein Dict.
`rows` liefert eine Liste von Dicts. Eine SQL-NULL-Zelle ist die leere
Zeichenkette, die Spalte bleibt im Dict. `value` nimmt die erste Spalte
der ersten Zeile, sonst die Vorgabe. `insert` gibt die Zahl der
betroffenen Zeilen zurück. Ein leeres Dict wirft
`{TCLUTILS TUTDBC EMPTY}`.

`null` ist der Sentinel für SQL-NULL. Derselbe Effekt tritt ein, wenn
der Schlüssel im Dict fehlt. Eine gespeicherte `0` bleibt `0`.

```tcl
package require tdbc::sqlite3
package require tclutils::tutdbc
tdbc::sqlite3::connection create db :memory:
db allrows {create table lager (ort text, gang integer)}
::tclutils::tutdbc::insert db lager {ort Nord gang 3}
                                          ;# -> 1
::tclutils::tutdbc::rows db {select ort, gang from lager}
                                          ;# -> {ort Nord gang 3}
::tclutils::tutdbc::value db {select gang from lager where ort = :o} {o x} -
                                          ;# -> -
::tclutils::tutdbc::quoteId {a"b}         ;# -> "a""b"
```

`insert` mit `gang` auf `[null]` schreibt SQL-NULL. Nach
`insert db lager [list ort Sued gang [null]]` hat die Zeile für
`Sued` den Schlüssel `gang` mit leerem Wert. `gang 0`
kommt als `0` zurück.

Ein Fehler im Skript von `transaction` macht die Änderungen rückgängig
und wirft den ursprünglichen Fehler weiter. Nach einem Insert und einem
abgebrochenen zweiten Insert bleibt `count(*)` bei 1, die Meldung ist
`abbruch`, der `-errorcode` ist der des abgebrochenen Skripts.

---

## MaxMind: tummdb

```tcl
::tclutils::tummdb::open     pfad
::tclutils::tummdb::metadata handle
::tclutils::tummdb::lookup   handle ip
::tclutils::tummdb::close    handle
```

`open` und `close` stehen nicht in `namespace export`. Der Aufruf bleibt
qualifiziert, sonst träfe er Tcls `open` und `close`. `open` liest die
Datei ganz in den Speicher und gibt ein Handle wie `tummdb1` zurück.
`metadata` ist das Dict aus dem Dateiende. `lookup` liefert den
Datensatz oder die leere Zeichenkette, wenn die Adresse keinen Satz hat.

Eine Datei ohne die Markierung `MaxMind.com` wirft
`{TCLUTILS TUMMDB FORMAT}`. `metadata` und `lookup` mit einem
unbekannten Handle werfen `{TCLUTILS TUMMDB HANDLE}`. `close` auf
einem solchen Handle gibt die leere Zeichenkette zurück und wirft nicht.

Weitere Codes aus dem Modul: `RECORDSIZE`, wenn die Knotenbreite nicht
getragen wird, und `TYPE`, wenn ein Datenfeld eine unbekannte Art hat.

---

## Merkliste

- `tutdbc` lädt keinen Treiber. Die Verbindung öffnet der Aufruf.
- SQL-NULL bleibt eine Spalte mit leerem Wert. `0` bleibt `0`.
- `transaction` rollt bei Fehler zurück und reicht den Fehler weiter.
- `tummdb::open` und `close` immer mit Namensraum schreiben.

---

*Nächstes Kapitel: [Kodierung, Hash und Vergleich](052-kodierung-hash-vergleich.md)*
