# Glossary

---

[umbrella]{.index}
:   Package `tclutils`, loads the core modules.

[module path]{.index}
:   `tcl::tm::path` — where `.tm` files are found.

[provider]{.index}
:   Uniform storage API (`tuprovider` + backends).

[caps]{.index}
:   List of the operations a provider can actually perform (e.g. ZIP:
    `get list stat`).

[tusettings]{.index}
:   Per-user INI and recent lists.

[tutestrun]{.index}
:   Shared `tests/all.tcl` runner of the three libraries.

[tuhttps]{.index}
:   Shared HTTPS policy: verifying `tls` sockets, `https` registered
    only temporarily.

[tutask]{.index}
:   Tasks on coroutines with `await`, timeout, `cancel`, groups, pool and
    sandbox (new in 0.65.0, version 0.2 in 0.66.0).

[task]{.index}
:   Coroutine owned by an object (`spawn`); state `running`, `ok`,
    `error` or `cancelled`.

[starter]{.index}
:   Command prefix of an operation: receives a callback, returns a
    cancel command, reports `ok` or `error` once.

[sandbox]{.index}
:   Safe interpreter with a command and time limit (`tutask::sandbox`).

[NOCA]{.index}
:   tls < 2.0 and no CA bundle found.

[grapheme]{.index}
:   Visible character, possibly made of several code points (`tustr::graphemes`).

[tudiagram]{.index}
:   Node-edge model, layout in pixels, SVG and PNG in pure Tcl.

[tuflow]{.index}
:   Flowchart text to `tudiagram`. `toSvg` also draws the other kinds.

[tumd]{.index}
:   Small CommonMark subset to HTML, without nested lists.

[tuholiday]{.index}
:   Easter and the nationwide public holidays, region `de`.

[tutdbc]{.index}
:   NULL-safe helpers on an existing TDBC connection. Not a driver,
    not in the umbrella.

[tummdb]{.index}
:   Reader for MaxMind DB 2.0. `open` and `close` only qualified.

[tuhash]{.index}
:   SHA-256, SHA-1 and MD5 in pure Tcl. The text default is UTF-8.

[tuurl]{.index}
:   Percent encoding and query strings. For the query `-plus` is on.

[tupdftext]{.index}
:   Text of a PDF page by page, pure Tcl, without poppler (0.1, new in
    0.67.0).

[tupdf]{.index}
:   PDF structure: version, objects, info, ZUGFeRD hint. The page text
    is handled by `tupdftext`.

[tuodf]{.index}
:   Plain OpenDocument from paragraphs. `mimetype` is the first entry.

[shadow copy]{.index}
:   Second copy of a package on the search paths that `package require`
    does not pick (`tupkgfinder::shadows`).

## Summary

- Terms from paths, providers, HTTPS, tests, `tutask`, notes, PDF, ODF and TDBC.

---

*Next chapter: [Error Messages](830-anhang-fehlermeldungen.md)*
