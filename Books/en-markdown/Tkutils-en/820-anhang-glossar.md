# Glossary

---

[umbrella]{.index}
:   Package `tkutils`, loads 53 core modules directly; needs Tablelist.

[namespace]{.index}
:   `::tkutils::tku<name>` — always call commands fully qualified.

[provider]{.index}
:   Storage API from tclutils (`tuprovider`); feeds the file widgets.

[exportselection]{.index}
:   Tk PRIMARY export; off by default in tkutablelist 0.4.

[button id]{.index}
:   Return value of `tkudialog::show`; `{id Label}` in `-buttons`.

[window override]{.index}
:   `tkuaction::setEnabled id 0 $w` — enable for one toplevel only.

[placeholder]{.index}
:   tkurender type: a labeled frame (default 200×120) as a host slot;
    `slot` empties it.

[slot]{.index}
:   `::tkuload::slot` — empty a placeholder for a host widget.

[tutestrun]{.index}
:   Test runner from tclutils; `tclsh tests/all.tcl`.

[package shadow]{.index}
:   Second copy of a package on the search path; tkdevtools shows it.

[pairing]{.index}
:   Recommended combination of versions: tclutils 0.69.0 + tkutils
    0.49.0 + ctrlutils 0.5.

[tablelist_tile]{.index}
:   ttk variant of Tablelist; `tkutablelist` and the `tkutl*` helpers
    load it. The two variants exclude each other.

---

## Summary

- Short definitions of the terms that recur in the book.

---

*Next chapter: [Error Messages](830-anhang-fehlermeldungen.md)*
