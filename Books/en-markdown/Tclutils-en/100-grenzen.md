# Limits

---

- No Tk — widgets and dialogs belong in tkutils.
- No complete GNU coreutils; only the filters shown.
- SFTP and TDBC: their own `package require`, external packages if needed.
- `tuflow` loads `tudiagram` immediately. The other diagram modules only
  on the first call of the respective kind. `parse` reads flowcharts;
  `pie` and the other kinds are drawn by `toSvg`. `validate` does not throw.
  See [Diagrams](056-diagramme.md).
- `tustr::graphemes` is a simplified UAX #29 (no Hangul syllables,
  no Indic conjuncts). `slugify` returns ASCII; scripts without Latin letters are dropped.
- `tupdf` counts pages by `/Type /Page`. `zugferd` looks for markers; it does not check
  the invoice. `object` throws `NOTFOUND` if the number is missing after
  inflating. See [ODF and PDF Structure](057-odf-und-pdf-struktur.md).
- `tuodf` reads paragraphs from `text:p`. It skips tables. `text`
  joins with `\n`, so an empty final paragraph makes the text end with it.
- `tupdftext` does not read encryption or text from images,
  does not keep columns apart and does not rejoin words hyphenated at the
  end of a line.
- `tuuniq` removes only adjacent duplicates. `tucut` is not CSV.
- `tujson::parse` turns `true` into `1` and `null` into empty.
- `tuhash` is pure Tcl. Text is converted to UTF-8 before the digest.
- `tumd` does not know nested lists, tables or Setext headings.
  The anchor keeps letters of every script, digits, `_` and `-`.
- `tuical` and `tuvcard` leave property values raw. `toIcs` and `toVcf`
  write CR/LF.
- `tuholiday` knows only `-region de` and no state-specific days.
- `tudict::getOr` puts the default before the path. `flatten` takes an
  even-length list as a dict.
- `tudiff` builds the comparison table in memory, limit `-maxcells`.
- `tusqlite` does not load `sqlite3`. A cell written as NULL comes
  back empty from `rows`.
- `tutdbc` loads no TDBC driver and is not in the umbrella.
  SQL NULL stays a column with an empty value. See
  [TDBC and MaxMind](051-tdbc-und-mmdb.md).
- `tummdb` keeps the file in memory. `open` and `close` are not
  exported. An address without a record yields the empty string.
- `tudate::diff -unit days` divides seconds by 86400. `relative`
  answers in English.
- `tupath::relative` requires two absolute or two relative paths.
- A ZIP provider has no `put`. The message has no `-errorcode`.
- `tufetch` without a server yields `URL` and `CAFILE`. `socketCmd` does not open
  a socket. Under tls 2 it appends no CA bundle.
- `tutask`: the sandbox runs in the calling thread; only the
  pool (package `Thread`) is parallel. On abort under Unix, `pipe` terminates only the
  direct processes, not grandchildren. `-commands` alone does not stop an empty
  loop. See [Tasks with tutask](085-tutask.md).
- Module docs and man pages are the API truth; this book is the path.

Stack, file view, explorer: book *Utils-Stack*.

---

## Windows notes

The table reflects code and CHANGELOG, not own tests under
Windows.

| Topic | Behavior under Windows |
|---|---|
| `tunum::format` | rounds as under Linux (since 0.4), not per the C runtime |
| `tupath::clean` | `..` stops at the drive root `C:/` |
| `tusettings::dir` | `%APPDATA%`, `%LOCALAPPDATA%`, `%TEMP%` |
| Recent list | same file recognized regardless of case |
| HTTPS with tls 1.x | no system CA store: `SSL_CERT_FILE` or `-cafile` |
| `tufetch` without CA bundle | falls back to curl/wget, otherwise `NOMETHOD` |
| Test suite | runs according to the CHANGELOG; CA tests skipped without a bundle |
| `tutask::pipe` | abort via `taskkill /T /F`, child processes included |

---

## Summary

- Engines yes, GUI and app glue no.
- Load optional backends explicitly.
- Under Windows: provide a CA bundle for tls 1.x.
- `tutask` has documented limits for processes and sandbox limits.

---

*Next chapter: [Pitfalls](800-anhang-fallen.md)*
