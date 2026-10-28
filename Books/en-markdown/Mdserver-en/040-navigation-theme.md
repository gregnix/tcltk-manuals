# Navigation and Theme

## Introduction

Every page carries a navigation. How it looks is decided by the style.
Style and theme are set on the server and also per URL, without a
restart.

---

## Page Style

| Style | Effect |
|---|---|
| `site` | full page layout: header bar with search field, chapter or folder sidebar, breadcrumbs, `Auf dieser Seite`, cards (default) |
| `plain` | TOC as a block at the top (the earlier default) |
| `sidebar` | TOC as a fixed bar on the left |
| `sticky` | TOC sticks to the top edge |
| `collapsible` | TOC can be folded |

```
http://127.0.0.1:8080/doc.md?style=plain
http://127.0.0.1:8080/doc.md?style=sidebar
```

The [site style]{.index} does not lay a stylesheet over a finished
page. It takes the rendered content and builds the page around it. The
details are in the next chapter. The four older styles, in contrast,
append a CSS file after the default CSS.

CSS in `tools/mdserver/styles/`: `site.css`, `sidebar.css`,
`sticky-top.css`, `collapsible.css`. If the file is missing, the page
comes without style — no error. Another location: `--stylesdir`.

---

## Theme per URL

In style `site` only dark mode counts:

```
http://127.0.0.1:8080/doc.md?theme=dunkel
```

Without `theme=dunkel` the page follows the browser's system setting.
Light cannot be forced.

In the older styles the names from `mdstack::theme` and the switch
`toc` apply:

```
http://127.0.0.1:8080/doc.md?style=plain&theme=solarized&toc=0
```

Names: `hell`, `dunkel`, `solarized`. `toc=0` removes the table of
contents at the top.

---

## Header Bar in `site`

- On the left the site title (`--title`); it leads to `/`.
- `Start` and `Alle Dokumente` ("all documents", `/?nav=index`).
- The top-level folders as sections, if any `.md` or `.pdf` lies below
  them. Label from the H1 of the `index.md`, else the folder name.
- On the right the search field (chapter *Page Layout and Search*).

---

## Bar of the Older Styles

- `Start` leads to `/` (`index.md` in the root).
- `Alle Dokumente`: `/?nav=index` — tree of all `.md`, titles from
  the first H1, plus every `.pdf` with its file name and "(PDF)".
- Top-level folders as sections, if any `.md` or `.pdf` lies below
  them. From `navmax` (6) on they fold into a dropdown. `--navmax 0`
  never folds.

Colours: `--navbg`, `--navfg`. Turned off in the constructor: `nav 0`.
These options apply only here, not in `site`.

---

## Books

A folder with `book.tcl` or a `<!-- bookkit:toc:begin -->` counts as a
book. Order from `book.tcl`, else from the TOC block, else from the
`NNN-` prefix.

| | `site` | older styles |
|---|---|---|
| chapter list | sidebar on the left, current chapter marked | only `sidebar`: bar on the left |
| overview | first entry of the sidebar | middle of the chapter bar |
| previous / next | two cards `Zurück` and `Weiter` at the foot | chapter bar (back, overview, next) at the foot |
| PDF/HTML | buttons above the chapter list | links on the landing page |

---

## Landing Page of a Book

If the book folder has no `index.md`, mdserver generates the
[book landing page]{.index} from `book.tcl`. This holds in every style.

1. Title (`title`), below it the subtitle (`subtitle`) in italics.
2. The first paragraph of the `README.md` — in the book folder, else in
   the folder above.
3. **Download:** `PDF` and `HTML`, if `<name>.pdf` and `<name>.html`
   lie next to the book folder. That is where bookkit puts them.
4. `Kapitel` (chapters): numbered list with the H1 titles.

For a book folder `Beispiel-de/` the downloads are called
`Beispiel-de.pdf` and `Beispiel-de.html` in the folder above.

An `index.md` of your own takes precedence. `book-webindex.tcl`
(bookkit) writes one if wanted — it is no longer necessary.

---

## Summary

- The default is `site`; the older styles via `--style` or `?style=`.
- In `site`, `theme=dunkel` counts, otherwise the system setting.
- `--navbg`, `--navfg`, `--navmax`, `toc` apply only to the older
  styles.
- A book without `index.md` gets a generated landing page.
- Missing CSS = unstyled, not 500.

---

*Next chapter: [Page Layout and Search](045-seitenlayout-und-suche.md)*
