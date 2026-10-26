# Provider

## Eine API, mehrere Backends

[tuprovider]{.index} beschreibt Dateien und Ordner einheitlich: `list`,
`stat`, `get`, `put`, `mkdir`, `move`, `delete`, … — je nach
[Capabilities]{.index} (`caps`).

| Backend | Paket | typisch |
|---|---|---|
| lokal | `tclutils::tuprovider` | Dateisystem |
| ZIP | `tuprovider::zip` | Archiv nur lesen |
| DAV | `tuprovider::dav` | WebDAV |
| FTP | `tuprovider::ftp` | braucht tcllib-`ftp` beim `open` |
| SFTP | `tuprovider::sftp` | eigenes require, OpenSSH-`sftp` |

---

## Caps pro Schema

`caps` liefert eine Liste der Operationen, die das Backend wirklich
kann. Stand 0.68.0 (unverändert seit 0.64.0):

| Schema | caps |
|---|---|
| local | copy delete get list mkdir move put stat |
| zip | get list stat |
| dav | delete get list put stat |
| ftp | delete get list mkdir move put stat |
| sftp | delete get list mkdir move put stat |

Verbindlich ist die Tabelle in `docs/tuprovider.md`; der Test
`tests/tuprovider-caps.test` liest genau diese Zeilen. ZIP ist also
schreibgeschützt. WebDAV kennt weder `mkdir` noch `copy`/`move`: der
DAV-Provider leitet nur an `tudav` weiter, und `tudav` hat kein
öffentliches MKCOL/MOVE/COPY. Kopieren über Provider-Grenzen geht in der
App mit `get` + `put`.

```tcl
package require tclutils::tuprovider
set p [::tclutils::tuprovider::open local]
lsort [$p caps]      ;# -> copy delete get list mkdir move put stat
```

Ein unbekanntes Schema bricht ohne `-errorcode` ab. Die Meldung nennt
die Schemas, die geladen sind: nur mit `tuprovider` heißt sie
`unknown scheme 'unbekannt' (have: local)`. ZIP und DAV erscheinen
darin, sobald ihr Paket geladen ist.

### Eintrag

`list` und `stat` liefern Dicts. Darin stehen mindestens `name`,
`path`, `type` (`file` oder `dir`), `size` und `mtime`. `path` geht
unverändert wieder in `list`, `stat` und `get`. `get` liefert die
Bytes, ohne Kodierung. Wer Text will, wandelt selbst.

```tcl
$p put [file join $dir a.txt] eins
dict get [$p stat [file join $dir a.txt]] size    ;# -> 4
dict get [$p stat [file join $dir a.txt]] type    ;# -> file
$p get [file join $dir a.txt]                      ;# -> eins
```

`mtime` kann leer sein. Beim ZIP-Provider ist der Mitgliedspfad
`/notiz.txt`, die Zeit bleibt leer, `size` ist die Bytezahl.

### Schreiben, das die caps verbieten

ZIP hat `get`, `list` und `stat`. `put` darauf antwortet ohne
`-errorcode`: `provider ::tclutils::tuprovider::Zip does not support 'put'`.
Kopieren von einem Provider zum anderen ist `get` und danach `put`
auf dem Ziel, nicht `copy`. `copy` bleibt im selben Provider.

`head` ist keine Cap. Die Basisklasse liest per `get` und kürzt. SFTP
überträgt dabei die ganze Datei. Der lokale Provider liest nur die
verlangten Bytes.

---

## Apps darüber

tkutils-Widgets (`tkufilelist`, `tkufiletree`) und ctrlutils-Controller
(`cufileops`) sprechen nur die Provider-API. Rezepte und Dateiblick:
Buch *Utils-Stack*. HOWTOs im Lib-Baum: `docs/guide/howto-*.md`.

---

## Zusammenfassung

- Provider = einheitliche Speicher-API.
- Caps steuern, was die UI anbieten darf. ZIP ist nur lesend, und
  `put` darauf hat keinen `-errorcode`. DAV hat kein `mkdir`, `copy`, `move`.

---

*Nächstes Kapitel: [Bausteine für Anwendungen](062-anwendungsbausteine.md)*
