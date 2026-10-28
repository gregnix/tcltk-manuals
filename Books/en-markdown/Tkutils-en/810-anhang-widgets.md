# Widgets (Overview)

Overview in the tkutils tree: `docs/guide/tkutils-modules.md`. **75**
modules, each with a test, a doc and a man page
(`tools/check-docman.tcl` reports no missing files). The umbrella loads
53 directly and `tkutablelist` and `tkuopts` indirectly; the code of the
umbrella is authoritative. No parallel versions: `tkutablelist` only
0.4, `tkudialog` only 0.3.

## Excerpt

| Widget | Role |
|---|---|
| tkudialog 0.3 | showInfo/Warning/Error, confirm, input, form, build/show |
| tkufiledialog 0.2 | open/save/directory |
| tkufilelist 0.2 / tkufiletree 0.2 | provider UI |
| tkupath 0.3 | path bar, also drive and UNC |
| tkupreview 0.2 | preview, texts through msgcat |
| tkutablelist 0.4 | tablelist wrapper, `-exportselection 0` |
| tkugeometry 0.1 | remember window geometry |
| tkuunits 0.1 | px/pt/mm/cm/inch |
| tkuaction 0.2 | actions, enable per window |
| tkutoolbar 0.2 | toolbar, `addAction` |
| tkulauncher 0.3 | program launcher (menu/list) |
| tkuload 0.3 / tkurender 0.2 | UI loading / placeholder (not in the umbrella) |
| tkuopts 0.1 | option check (loaded indirectly) |
| tkuwinico 0.1 | Windows icon from Tk images |
| tkudhash 0.1 | image similarity through `tudhash` |

## Separate Only

| Module | Needs |
|---|---|
| tkuxml 0.1 | tDOM |
| tkusqlite 0.1 | sqlite3 |
| tkuicon 0.1 | tksvg / Tk 9 for SVG |
| tkuscrolledframe 0.1 | scrollutil |
| tkutical 0.3, tkumonthcanvas 0.5 | tical 1.0 |
| tkucanvaspng 0.2 | tclutils::tupngdraw |
| tkutltools 0.2, tkutl* (0.2/0.3) | Tablelist (`tablelist_tile`) |
| tkumdview, tkupdfinspect, tkulayoutcanvas (0.1 each) | tclutils engines |

---

## Summary

- 75 modules: 55 through the umbrella, 20 separately.
- The versions in this appendix are the files in the 0.48.0 tree.

---

*Next chapter: [Glossary](820-anhang-glossar.md)*
