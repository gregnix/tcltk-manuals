# Contributing to This Book

This work is the English translation of the German-language textbook
for pdf4tcl 0.9.4.69. Corrections, additions and new chapters are
welcome. Content changes go into the German original first.

## What Can Be Contributed

### Corrections

- Factual errors (pdf4tcl API, behavior, examples)
- Outdated information about version 0.9.4.69
- Code examples that do not run
- Typos, smoother wording

### Additions

- Checked viewer notes (Acrobat, PDFium, Poppler, MuPDF)
- Further methods with a concrete example
- Pitfalls from your own tests

### What Does Not Fit

- General Tcl introductions without a PDF connection
- Layout libraries as a replacement for the drawing API
- Advertising for proprietary PDF tools

## Style

The book consistently uses:

- **Imperative and impersonal form**, no direct "you"
- **Established technical terms**
  (CID, appearance, NeedAppearances stay as technical terms)
- **Real German umlauts** (ä, ö, ü) in the German original, code
  comments included; code blocks stay unchanged in the translation
- **Concrete code examples** instead of abstract descriptions
- **Cross-references** to other chapters/appendices

Example of good form:

> "fillForms rebuilds the appearance stream for a simple text field.
> Comb without MaxLen, password and choice fields keep the old stream."

Example of unsuitable form:

> "When you call fillForms, you can fill your fields. You then don't
> have to set NeedAppearances yourself."

## Format

- **Markdown** (CommonMark + GitHub tables)
- **Code blocks with a language hint** (`` ```tcl ``, `` ```bash ``)
- **Cross-references** as relative Markdown links to the flat file names:
  `[fillForms](090-fillforms.md)`
- **Date stamp** in each chapter: `*Stand: YYYY-MM-DD*` (English
  edition: *As of:*) directly below the H1 heading

## Workflow for Contributions

1. **Open an issue** for larger changes
2. **Pull request** with a clear description
3. **One thing per PR**

### Commit Style

- Short, descriptive first line (≤72 characters)

Examples:

```
090-fillforms: NeedAppearances nur bei altem Stream
170-cid-subset-cmap: Identity-CMap, nicht FFFE
```

## Code License for Contributions

- **Documentation text:** CC BY-SA 4.0
- **Code examples:** MIT

## Topics Covered in the Book

These chapters already exist (do not treat them as "missing"):

- **CID cmap:** [CID Subset and CMap](170-cid-subset-cmap.md)
- **gsave and BT:** [gsave and Text](160-gsave-und-text.md)
- **fillForms:** [fillForms](090-fillforms.md)

New chapters only after agreement with the list in `book.tcl`.
