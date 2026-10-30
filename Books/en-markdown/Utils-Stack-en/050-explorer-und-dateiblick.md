# Explorer and Dateiblick

## Two Roles

| App | Location | Role |
|---|---|---|
| Explorer | `ctrlutils/apps/explorer/` | reference / demo for the controllers |
| Dateiblick | `dateiblick/` | end-user app |

Keep names and trees separate. The Explorer stays **untouched** in
reviews and rules.

The Explorer is the only app in the three repos that uses ctrlutils.
The apps under `tkutils/apps/` (editors, launcher, tkdevtools …) build
on tclutils and tkutils only; those under `tclutils/apps/`
(`find-tclconfig`, `build-app`) are Tk-free.

---

## Explorer (in Brief)

```bash
wish ctrlutils/apps/explorer/explorer.tcl ?verzeichnis?
wish ctrlutils/apps/explorer/explorer.tcl -zip archiv.zip
wish ctrlutils/apps/explorer/explorer.tcl -remote URL ?provider-optionen?
wish ctrlutils/apps/explorer/explorer.tcl --check
```

- Without an argument the Explorer starts in the current directory.
- `-remote` takes `sftp://`, `ftp://`, `dav://`, `davs://` or
  `http(s)://` and loads the matching provider only when needed.
- `--check` (or `-check`) shows which optional previews are loaded
  (image formats through `img::*`, SVG through `tcllunasvg`, PDF through
  `pdfiumtcl`, SQLite) — on the console and in a window. After the
  window is closed it ends with exit 0 only if all of them are there.
  Checked (Tcl/Tk 8.6.14, Linux, Xvfb): here `img::jpeg`, `img::tiff`,
  `img::bmp`, `img::ico`, `tcllunasvg` and `pdfiumtcl` are missing;
  SQLite is `OK`.

The three libraries must be on the module path (setup or `site-tcl`, see
[Pairing and Setup](020-pairing-und-setup.md)). The Explorer does not
source `setup.tcl` itself. It also needs Tablelist (with Scrollutil) from
tklib. If a required package is missing, it shows a message box
"Explorer cannot start" instead of an empty window and ends with exit 1.
The message names the package, the error message of `package require`,
the module path searched and the `auto_path`:

```
Missing package:
  tkutils::tkufiletree

can't find package tkutils::tkufiletree

Searched module path (tcl::tm::path):
/usr/lib/tcltk/tcl8/site-tcl
...

Searched auto_path:
...
```

Checked (Tcl/Tk 8.6.14 and 9.0.4, Linux, Xvfb) without a module path to
the three libraries. The required modules are `.tm` modules and are
found through the module path, not through `auto_path`. Up to
ctrlutils 0.3 the message named only the `auto_path`.

Per tab: `tkufiletree`, `tkufilelist` with a `cufilter` row above it,
`tkupreview`; plus `cuundo::install … -list`, `cufileops::install … -onop
[list ::ctrlutils::cuundo::record $f]` and `cumonitor` with 2000 ms.

Every tab holds its **own** provider. One tab can show a ZIP, another
the local disk; cufileops copies between them because its clipboard
knows the source provider. The "+" button and Ctrl+T open a new local
tab in the home directory. When a tab is closed, the Explorer stops its
`cumonitor` and destroys the provider if no other tab still uses it.
Checked (Tcl/Tk 8.6.14, Linux, Xvfb): starting with `-zip` gives a tab
with the provider `::tclutils::tuprovider::Zip`; a new tab gets a
provider object of its own.

`cusync` is loaded optionally: if it is missing, the Explorer still
starts; only "File > Sync folders..." reports
`Sync needs the ctrlutils::cusync module.` and advises putting the
module next to the other ctrlutils modules. Equally optional is
`tkutils::tkutlfind` for searching in the list; if it is missing, the
message says to put the module with the other tkutils modules. Up to
ctrlutils 0.4 both messages named a file (`cusync-0.2.tm`,
`tkutlfind-0.2.tm`); since tkutils 0.49.0 the file is called
`tkutlfind-0.3.tm`, though. The "Edit" menu offers undo, redo and
the same file operations as the context menu. Errors at startup and
background errors are shown by `tkudialog` with copyable details. The
Explorer's own user interface texts are English and do not go through
msgcat.

As a standalone program, the Explorer can be built with `build-app` from
tclutils (Tcl 9 zipkit with all three `lib/tm` trees plus Tablelist and
Scrollutil). This is described in `tclutils/apps/build-app/doc/`; not
checked here.

---

## Dateiblick (in Brief)

Dateiblick is not in the three repos. The following points come from
the review state and are **not checked** for this state:

- Hand-wired GUI (no `tkuload::slot` / `.tkd`)
- Requires among others `tkudialog` 0.3, `cufileops` 0.3
- Suite against the sibling utils green (review state: 45/45)
- Workarounds for multi-select and dialog defaults removed — the
  libraries handle that

Architecture note: `00review/dateiblick-review.md` (in the Dateiblick
tree).

`package require ctrlutils::cufileops 0.3` also loads 0.5 (same major
version). To show Dateiblick in German, put the translations in the
namespace `::ctrlutils` (see
[cufileops and Undo](040-cufileops-und-undo.md)) and, for the dialogs,
in `::tkutils`. Dateiblick shares the "Open with" registry with the
Explorer until it calls `::ctrlutils::cufileops::owSetApp dateiblick`
(from ctrlutils 0.4).

---

## Summary

- Explorer = reference, Dateiblick = product.
- Both on the same stack; do not mix them.
- In the Explorer every tab has its own provider.

---

*Next chapter: [App Checklist](060-checkliste-app.md)*
