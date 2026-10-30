# Filter: cufilter

[cufilter]{.index} 0.2 creates widgets itself. The other controllers
attach behaviour to existing paths. `widget $path $listwidget` builds a
`ttk::frame` with the label "Filter:", an entry field and a clear button
(caption "x") and returns `$path`. Packing is up to the app.

```tcl
::tkutils::tkufilelist::widget .list -dir [pwd]
::ctrlutils::cufilter::widget .filter .list
pack .filter -side top -fill x
pack .list   -side top -fill both -expand 1
```

- Every keystroke filters at once.
- Plain text becomes `*text*` (substring); text with `*` or `?` counts
  as a glob. Case does not matter: `tkufilelist` compares with
  `string match -nocase` ("A" finds `a.txt`).
- Directories always stay visible, navigation continues.
- Escape or the button clear the row (`cufilter::clear $path`), the
  focus goes back to the list.
- Since ctrlutils 0.4, "Filter:" and "x" go through msgcat (catalog in
  the namespace `::ctrlutils`, as with cufileops). Checked
  (Tcl/Tk 8.6.14, Linux, Xvfb): with `mcset {} Filter: Suche:` and
  `mcset {} x X` the row shows `Suche:` and `X`. In ctrlutils 0.3 both
  stay English.

- If the filter cannot be set (the list is gone or is not a
  `tkufilelist`), the entry goes into the ttk state `invalid`, `$path`
  gets `<<CufilterError>>`, and `cufilter::lastError $path` returns the
  message. There is no dialog, because the filter runs on every
  keystroke. Up to 0.1 the error vanished silently.

Prerequisite: `tkufilelist` with the option `-filter` / method
`setFilter`. The list itself is in the tkutils manual.

---

## In short

- `widget` returns the path and does not pack it.
- Text without `*` and `?` searches as a substring.
- Directories stay visible.
- The two captions come from msgcat since 0.4.
- A filter error is in `lastError` (since 0.2).

---

*Next chapter: [Watching a Directory](034-cumonitor.md)*
