# fillForms

## Einführung

Drei Aufrufe arbeiten auf einer **fertigen Datei**, nicht auf dem
Dokumentobjekt: `getForms`, [`fillForms`]{.index}, `exportForms`
(seit 0.9.4.50).

---

## Lesen, füllen, exportieren

```tcl
set fields [pdf4tcl::getForms "auftrag.pdf"]
pdf4tcl::fillForms "auftrag.pdf" "ausgefuellt.pdf" {f_name "Meier & Co"}
pdf4tcl::exportForms "ausgefuellt.pdf" "ausgefuellt.fdf"
```

`fillForms` schreibt Werte und gibt zurück, wie viele Felder es
getroffen hat. Unbekannter Name ist ein Fehler:

```
fillForms: no such field(s) in "auftrag.pdf": kein_feld
```

Nicht genannte Felder behalten, was sie hatten.

Verschlüsselte Dateien: `getForms` liefert leer, `fillForms` findet
keine Felder — es gibt kein `-password`. Vor dem Füllen unverschlüsselt
bauen oder die Kennwörter weglassen.

---

## Was getForms liefert

Dict von Feld-ID auf Dict:

| Schlüssel | Bedeutung |
|-----------|-----------|
| `type` | `/Tx`, `/Btn`, `/Ch`, `/Sig` |
| `value` | aktueller Wert, entpackt |
| `flags` | Feldflags |
| `default` | Appearance-Zustand bei Buttons |
| `maxlen` | Maximallänge oder leer (0.9.4.63) |
| `comb` | 1 bei Kammfeld (0.9.4.63) |
| `widgets` | Widget-Anzahl (0.9.4.64) |
| `description` | Tooltip (0.9.4.65) |
| `options` | erlaubte Werte der Auswahl (0.9.4.65) |

Code, der das ganze Dict mit einem Literal vergleicht, merkt die
neuen Schlüssel.

---

## Appearance seit 0.9.4.64

`fillForms` schreibt den Wert **und** baut den Stream neu — für
einfaches Textfeld, mehrzeilig und Comb **mit** `/MaxLen`. Ein Stream
pro Widget, aus dessen eigenem Rechteck.

Bis 0.9.4.63 blieb der Stream: ein Viewer mit Flagge zeigte den neuen
Wert, der Druckpfad den **alten**. Leeres Feld: nichts auf dem Papier.

Nicht neu gebaut, absichtlich:

| Feld | Stream |
|------|--------|
| Comb **ohne** `/MaxLen` | alt — kein Teiler, keine Zellen |
| Kennwort | alt — sonst Klartext im Stream |
| Auswahl (`choice`) | alt — Kasten und Rahmen gingen verloren |
| Check / Radio | Umschalten der vorhandenen Zustände |

---

## NeedAppearances nur bei altem Stream

[`NeedAppearances`]{.index} setzt fillForms **nur**, wo der Stream
alt bleibt (seit 0.9.4.66). Die Flagge sagt dem Viewer: bau alles neu.

Beobachtet: Ein Textfeld zu füllen ließ ein **unberührtes** Kästchen
seinen Rahmen verlieren. PDFium baut unter der Flagge jede
Off-Erscheinung neu und liefert eine leere.

Wo der Stream selbst gezeichnet wurde, bleibt die Flagge weg. Wo
Comb ohne MaxLen, Kennwort oder Auswahl den alten Stream behalten,
steht sie — sonst sähe man den neuen Wert nirgends.

Wer sich darauf verlassen hat, dass die Flagge immer da ist: Feld
des alten Typs füllen oder die Flagge selbst setzen.

---

## Werte

Text: Zeichenkette. Check / Radio: Zustandsname **mit Schrägstrich**,
wie in der Datei:

```tcl
pdf4tcl::fillForms in.pdf out.pdf {agreed /Yes}
```

Auswahl: Exportwert oder Label. Alles andere ist Fehler (seit
0.9.4.65). Leerer Wert ist erlaubt: nichts gewählt.

```
fillForms: "Frankreich" is not an option of "land";
allowed: Deutschland Niederlande Belgien
```

Bis 0.9.4.64 wurde jeder Wert geschrieben und Erfolg gemeldet; das
Feld trug dann einen Zustand, den kein Viewer zeigt.

---

## Feldbaum (0.9.4.64)

`getForms` und `fillForms` laufen über den Baum, nicht über jedes
Widget einzeln. Ein Feld auf mehreren Blättern (Frachtbrief) wird
gefunden. Verschachtelter Name: `person.city`, nicht `city`. Wer
früher den Kurznamen füllte, trifft nicht mehr.

---

## Roundtrip

`getForms` gibt Text **entpackt** zurück, genau so wie `fillForms`
ihn nimmt (seit 0.9.4.55):

```tcl
set fields [pdf4tcl::getForms "in.pdf"]
set values {}
dict for {id info} $fields {
    dict set values $id [dict get $info value]
}
dict set values f_name "Meier & Co (GmbH)"
pdf4tcl::fillForms "in.pdf" "out.pdf" $values
```

Name-Werte (`/Yes`, `/Off`) bleiben, wie fillForms sie für Buttons
erwartet.

---

## Dynamisches XFA

Dynamische XFA-Formulare lehnt fillForms ab (0.9.4.64): die Seiten
entstehen aus XML, `/V` ändert nichts Sichtbares. Hybride XFA
(XFA plus nutzbare AcroForm-Felder) werden wie bisher gefüllt.

---

## Zusammenfassung

- Appearance für einfaches Textfeld seit 0.9.4.64 neu.
- Comb ohne MaxLen, Kennwort, Auswahl: alter Stream.
- NeedAppearances nur dort, wo der Stream alt bleibt.
- Namen: volle Kette, `person.city`.

---

*Nächstes Kapitel: [Annotationen](100-annotationen.md)*
