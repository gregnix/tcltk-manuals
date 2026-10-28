# Widgets (Orientierung)

Übersicht im tkutils-Baum: `docs/guide/tkutils-modules.md`. **75**
Module, je mit Test, Doc und Manpage (`tools/check-docman.tcl` meldet
keine fehlenden Dateien). Der Umbrella lädt 53 direkt und `tkutablelist`
und `tkuopts` indirekt; maßgeblich ist der Code des Umbrellas. Keine
Parallelversionen: `tkutablelist` nur 0.4, `tkudialog` nur 0.3.

## Auszug

| Widget | Rolle |
|---|---|
| tkudialog 0.3 | showInfo/Warning/Error, confirm, input, form, build/show |
| tkufiledialog 0.2 | open/save/directory |
| tkufilelist 0.2 / tkufiletree 0.2 | Provider-UI |
| tkupath 0.3 | Pfadzeile, auch Laufwerk und UNC |
| tkupreview 0.2 | Vorschau, Texte über msgcat |
| tkutablelist 0.4 | tablelist-Wrapper, `-exportselection 0` |
| tkugeometry 0.1 | Fenstergeometrie merken |
| tkuunits 0.1 | px/pt/mm/cm/inch |
| tkuaction 0.2 | Actions, Enable pro Fenster |
| tkutoolbar 0.2 | Leiste, `addAction` |
| tkulauncher 0.3 | Programmstarter (Menü/Liste) |
| tkuload 0.3 / tkurender 0.2 | UI-Laden / placeholder (nicht im Umbrella) |
| tkuopts 0.1 | Optionsprüfung (indirekt geladen) |
| tkuwinico 0.1 | Windows-Symbol aus Tk-Bildern |
| tkudhash 0.1 | Bildähnlichkeit über `tudhash` |

## Nur einzeln

| Modul | Braucht |
|---|---|
| tkuxml 0.1 | tDOM |
| tkusqlite 0.1 | sqlite3 |
| tkuicon 0.1 | tksvg / Tk 9 für SVG |
| tkuscrolledframe 0.1 | scrollutil |
| tkutical 0.3, tkumonthcanvas 0.5 | tical 1.0 |
| tkucanvaspng 0.2 | tclutils::tupngdraw |
| tkutltools 0.2, tkutl* (0.2/0.3) | Tablelist (`tablelist_tile`) |
| tkumdview, tkupdfinspect, tkulayoutcanvas (je 0.1) | tclutils-Engines |

---

## Zusammenfassung

- 75 Module: 55 über den Umbrella, 20 einzeln.
- Die Versionen dieses Anhangs sind die Dateien im Baum von 0.48.0.

---

*Nächstes Kapitel: [Glossar](820-anhang-glossar.md)*
