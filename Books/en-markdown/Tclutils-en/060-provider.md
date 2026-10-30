# Providers

## One API, several backends

[tuprovider]{.index} describes files and folders uniformly: `list`,
`stat`, `get`, `put`, `mkdir`, `move`, `delete`, … — depending on the
[capabilities]{.index} (`caps`).

| Backend | Package | typical use |
|---|---|---|
| local | `tclutils::tuprovider` | file system |
| ZIP | `tuprovider::zip` | archive, read only |
| DAV | `tuprovider::dav` | WebDAV |
| FTP | `tuprovider::ftp` | needs tcllib `ftp` on `open` |
| SFTP | `tuprovider::sftp` | its own require, OpenSSH `sftp` |

---

## Caps per scheme

`caps` returns a list of the operations the backend actually
supports. The table applies to 0.69.0 (the same since 0.64.0):

| Scheme | caps |
|---|---|
| local | copy delete get list mkdir move put stat |
| zip | get list stat |
| dav | delete get list put stat |
| ftp | delete get list mkdir move put stat |
| sftp | delete get list mkdir move put stat |

The table in `docs/tuprovider.md` is authoritative; the test
`tests/tuprovider-caps.test` reads exactly these lines. ZIP is therefore
read-only. WebDAV has neither `mkdir` nor `copy`/`move`: the
DAV provider only forwards to `tudav`, and `tudav` has no
public MKCOL/MOVE/COPY. Copying across provider boundaries is done in the
app with `get` + `put`.

```tcl
package require tclutils::tuprovider
set p [::tclutils::tuprovider::open local]
lsort [$p caps]      ;# -> copy delete get list mkdir move put stat
```

An unknown scheme aborts without `-errorcode`. The message names
the schemes that are loaded: with `tuprovider` only, it reads
`unknown scheme 'unbekannt' (have: local)`. ZIP and DAV appear
in it as soon as their package is loaded.

### Entry

`list` and `stat` return dicts. They contain at least `name`,
`path`, `type` (`file` or `dir`), `size` and `mtime`. `path` goes
back unchanged into `list`, `stat` and `get`. `get` returns the
bytes, without encoding. Anyone who wants text converts it themselves.

```tcl
$p put [file join $dir a.txt] eins
dict get [$p stat [file join $dir a.txt]] size    ;# -> 4
dict get [$p stat [file join $dir a.txt]] type    ;# -> file
$p get [file join $dir a.txt]                      ;# -> eins
```

`put` of the local provider writes through a temporary file; if it
fails, the old file stays (0.3). `mtime` can be empty. With the ZIP provider the member path is
`/notiz.txt`, the time stays empty, `size` is the byte count.

### Writes the caps forbid

ZIP has `get`, `list` and `stat`. `put` on it answers without
`-errorcode`: `provider ::tclutils::tuprovider::Zip does not support 'put'`.
Copying from one provider to another is `get` followed by `put`
on the target, not `copy`. `copy` stays within the same provider.

`head` is not a cap. The base class reads via `get` and truncates. SFTP
transfers the whole file in doing so. The local provider reads only the
requested bytes.

---

## Apps on top

tkutils widgets (`tkufilelist`, `tkufiletree`) and ctrlutils controllers
(`cufileops`) speak only the provider API. Recipes and file view:
book *Utils-Stack*. HOWTOs in the library tree: `docs/guide/howto-*.md`.

---

## Summary

- Provider = uniform storage API.
- Caps control what the UI may offer. ZIP is read-only, and
  `put` on it has no `-errorcode`. DAV has no `mkdir`, `copy`, `move`.

---

*Next chapter: [Building Blocks for Applications](062-anwendungsbausteine.md)*
