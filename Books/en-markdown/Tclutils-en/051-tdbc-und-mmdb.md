# TDBC and MaxMind

[tutdbc]{.index} 0.1 works with a TDBC connection that the caller
has already opened. The module loads no driver and is not in the
umbrella. [tummdb]{.index} 0.1 reads a MaxMind DB of format version 2.0.
It is in the umbrella and builds on `tubin`.

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

Placeholders in the SQL are written `:name`. The bindings are a dict.
`rows` returns a list of dicts. An SQL NULL cell is the empty
string; the column stays in the dict. `value` takes the first column
of the first row, otherwise the default. `insert` returns the number of
affected rows. An empty dict throws
`{TCLUTILS TUTDBC EMPTY}`.

`null` is the sentinel for SQL NULL. The same effect occurs when
the key is missing from the dict. A stored `0` stays `0`.

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

`insert` with `gang` set to `[null]` writes SQL NULL. After
`insert db lager [list ort Sued gang [null]]` the row for
`Sued` has the key `gang` with an empty value. `gang 0`
comes back as `0`.

An error in the script of `transaction` rolls back the changes
and rethrows the original error. After one insert and an
aborted second insert, `count(*)` stays at 1, the message is
`abbruch`, and the `-errorcode` is that of the aborted script.

---

## MaxMind: tummdb

```tcl
::tclutils::tummdb::open     pfad
::tclutils::tummdb::metadata handle
::tclutils::tummdb::lookup   handle ip
::tclutils::tummdb::close    handle
```

`open` and `close` are not in `namespace export`. The call stays
qualified; otherwise it would hit Tcl's `open` and `close`. `open` reads the
whole file into memory and returns a handle such as `tummdb1`.
`metadata` is the dict from the end of the file. `lookup` returns the
record, or the empty string if the address has no record.

A file without the marker `MaxMind.com` throws
`{TCLUTILS TUMMDB FORMAT}`. `metadata` and `lookup` with an
unknown handle throw `{TCLUTILS TUMMDB HANDLE}`. `close` on
such a handle returns the empty string and does not throw.

Further codes from the module: `RECORDSIZE` if the node width is not
supported, and `TYPE` if a data field has an unknown kind.

---

## In short

- `tutdbc` loads no driver. The caller opens the connection.
- SQL NULL stays a column with an empty value. `0` stays `0`.
- `transaction` rolls back on error and passes the error on.
- Always write `tummdb::open` and `close` with the namespace.

---

*Next chapter: [Encoding, Hashing and Comparing](052-kodierung-hash-vergleich.md)*
