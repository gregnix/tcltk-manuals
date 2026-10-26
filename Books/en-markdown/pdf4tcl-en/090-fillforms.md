# fillForms

## Introduction

Three calls work on a **finished file**, not on the document object:
`getForms`, [`fillForms`]{.index}, `exportForms` (since 0.9.4.50).

---

## Reading, Filling, Exporting

```tcl
set fields [pdf4tcl::getForms "auftrag.pdf"]
pdf4tcl::fillForms "auftrag.pdf" "ausgefuellt.pdf" {f_name "Meier & Co"}
pdf4tcl::exportForms "ausgefuellt.pdf" "ausgefuellt.fdf"
```

`fillForms` writes values and returns how many fields it hit. An
unknown name is an error:

```
fillForms: no such field(s) in "auftrag.pdf": kein_feld
```

Fields not named keep what they had.

Encrypted files: `getForms` returns an empty result, `fillForms` finds
no fields — there is no `-password`. Build the file unencrypted before
filling, or leave out the passwords.

---

## What getForms Returns

A dict mapping field ID to a dict:

| Key | Meaning |
|-----------|-----------|
| `type` | `/Tx`, `/Btn`, `/Ch`, `/Sig` |
| `value` | current value, unescaped |
| `flags` | field flags |
| `default` | appearance state for buttons |
| `maxlen` | maximum length or empty (0.9.4.63) |
| `comb` | 1 for a comb field (0.9.4.63) |
| `widgets` | number of widgets (0.9.4.64) |
| `description` | tooltip (0.9.4.65) |
| `options` | allowed values of a choice field (0.9.4.65) |

Code that compares the whole dict with a literal will notice the
new keys.

---

## Appearance Since 0.9.4.64

`fillForms` writes the value **and** rebuilds the stream — for a
simple text field, a multiline field and a comb **with** `/MaxLen`.
One stream per widget, built from that widget's own rectangle.

Up to 0.9.4.63 the stream stayed as it was: a viewer honoring the flag
showed the new value, the print path the **old** one. Empty field:
nothing on paper.

Deliberately not rebuilt:

| Field | Stream |
|------|--------|
| Comb **without** `/MaxLen` | old — no divisor, no cells |
| Password | old — otherwise plain text in the stream |
| Choice (`choice`) | old — box and border would be lost |
| Check / radio | switching between the existing states |

---

## NeedAppearances Only with an Old Stream

fillForms sets [`NeedAppearances`]{.index} **only** where the stream
stays old (since 0.9.4.66). The flag tells the viewer: rebuild
everything.

Observed: filling a text field made an **untouched** check box lose
its border. Under the flag, PDFium rebuilds every Off appearance and
produces an empty one.

Where the stream was drawn by pdf4tcl itself, the flag is left out.
Where comb without MaxLen, password or choice keep the old stream, it
is set — otherwise the new value would not be visible anywhere.

Code that relied on the flag always being present: fill a field of
the old kind, or set the flag yourself.

---

## Values

Text: a string. Check / radio: state name **with a slash**, as in the
file:

```tcl
pdf4tcl::fillForms in.pdf out.pdf {agreed /Yes}
```

Choice: export value or label. Anything else is an error (since
0.9.4.65). An empty value is allowed: nothing selected.

```
fillForms: "Frankreich" is not an option of "land";
allowed: Deutschland Niederlande Belgien
```

Up to 0.9.4.64 every value was written and success was reported; the
field then carried a state that no viewer displays.

---

## Field Tree (0.9.4.64)

`getForms` and `fillForms` walk the tree, not each widget on its own.
A field on several sheets (waybill) is found. Nested name:
`person.city`, not `city`. Code that used to fill the short name no
longer hits the field.

---

## Round Trip

`getForms` returns text **unescaped**, exactly as `fillForms` takes
it (since 0.9.4.55):

```tcl
set fields [pdf4tcl::getForms "in.pdf"]
set values {}
dict for {id info} $fields {
    dict set values $id [dict get $info value]
}
dict set values f_name "Meier & Co (GmbH)"
pdf4tcl::fillForms "in.pdf" "out.pdf" $values
```

Name values (`/Yes`, `/Off`) stay as fillForms expects them for
buttons.

---

## Dynamic XFA

fillForms rejects dynamic XFA forms (0.9.4.64): the pages are
generated from XML, and `/V` changes nothing visible. Hybrid XFA
(XFA plus usable AcroForm fields) is filled as before.

---

## Summary

- Appearance for a simple text field rebuilt since 0.9.4.64.
- Comb without MaxLen, password, choice: old stream.
- NeedAppearances only where the stream stays old.
- Names: full chain, `person.city`.

---

*Next chapter: [Annotations](100-annotationen.md)*
