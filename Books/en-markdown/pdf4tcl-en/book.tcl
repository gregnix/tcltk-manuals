# book.tcl -- pdf4tcl (bookkit, English)
#
# Build (from the folder that holds bookkit/):
#   tclsh bookkit/tools/book-build.tcl book-pdf4tcl/pdf4tcl-en/ -number

set title     "pdf4tcl"
set author    ""
set subtitle  "Creating PDFs, forms, CID fonts, encryption"
set date      "2026-10-26"
set lang      "en"
set titlePage 1
set booktype  textbook               ;# textbook, see bookkit/doc/STYLE.md

set tocTitle   "Contents"
set indexTitle "Index"

set chapters {
    010-pdf4tcl-verstehen.md
    020-dokument-und-seite.md
    030-text-und-standardschriften.md
    040-cid-und-unicode.md
    050-grafik.md
    060-bilder.md
    070-canvas-export.md
    080-formulare-erzeugen.md
    090-fillforms.md
    100-annotationen.md
    110-verschluesselung.md
    120-catpdf.md
    130-pdfa.md
    140-ebenen.md
    150-metadaten.md
    160-gsave-und-text.md
    170-cid-subset-cmap.md
    180-fallstudie-bericht.md
    800-anhang-fallen.md
    810-anhang-api.md
    820-anhang-glossar.md
    830-anhang-fehlermeldungen.md
}
