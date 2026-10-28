# Limits

---

- Without tclutils no sensible pairing (engines, tusettings, tutestrun);
  at least 0.64.0, 0.68.0 recommended.
- The umbrella needs Tablelist (through `tkufilelist` → `tkutablelist`).
- tkutils loads `tablelist_tile` everywhere; an application that also
  requires `tablelist` itself fails in tklib.
- Not every module is in the umbrella: `tkuxml`, `tkusqlite`, `tkuicon`,
  `tkuscrolledframe`, `tkuload`, `tkurender`, the `tkutl*` helpers and
  others need their own require (chapter
  [Understanding tkutils](010-tkutils-verstehen.md)).
- `tkufiledialog` is not an explorer; `-filetypes` filters only by the
  first extension of a type.
- tablelist comes from outside (tklib, e.g. `apt install tklib`).
- tical comes from outside; `setup.tcl` does not find it.
- `tkugeometry` does not detect gaps between monitors of different
  sizes.
- The GUI tests need a display; without one they are skipped.
- Not every module checks its options: `tkutlfooter` skips unknown
  options.
- Controllers and undo: ctrlutils, not here.
- Checked with Tcl/Tk 8.6.14 and 9.0.4 on Linux (Xvfb). Windows, macOS
  and the real on-screen appearance are not checked.

---

## Summary

- View layer; model and controller beside it.
- API reference: module docs `docs/<modul>.md`.
- The gaps of 0.46.0 (Tablelist variants, double click in the file
  dialog, tests without a display) are fixed in 0.47.0; details in
  Appendices A and G.

---

*Next chapter: [Pitfalls](800-anhang-fallen.md)*
