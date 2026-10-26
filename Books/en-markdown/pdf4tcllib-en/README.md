# pdf4tcllib

*As of: 2026-10-25*

An English-language workshop book on [pdf4tcllib]{.index} 0.6.7:
fonts and Unicode, page context, text, tables with page breaks,
charts, table of contents, labels, forms and accessible
PDFs, on pdf4tcl 0.9.4.73.

This is the English translation of the German book. The German original
is in `pdf4tcllib-de/` next to this directory; both have the same file
names.

pdf4tcl draws; how that works is explained in the book *pdf4tcl*. This
book builds on it and solves the tasks that come up again and again in
reports and lists.

## Audience

- Tcl developers who produce reports, invoices, lists or labels as
  PDF
- Readers of the book *pdf4tcl* who do not want to break every table
  across pages by hand

## Examples

Every example is available as a script in `../beispiele/`. Whether book
and scripts agree and the scripts run is checked by:

```bash
tclsh beispiele/pruefe-beispiele.tcl -run
```

The treeview example needs Tk and therefore a display; without `DISPLAY`
it is skipped. On a server without a screen:

```bash
xvfb-run tclsh beispiele/pruefe-beispiele.tcl -run
```

The images for chapter 14 are in `../beispiele/bilder/`.

## License

Documentation text: [CC BY-SA 4.0](LICENSE)
Code examples: [MIT](LICENSE)
