# gsave und Text

## Einführung

`text` lässt das [Textobjekt]{.index} offen, damit mehrere Aufrufe
ein `BT` teilen. `q` (`gsave`) und `Q` (`grestore`) sind
Grafikoperatoren. ISO 32000-1 Abschnitt 8.2 erlaubt zwischen `BT`
und `ET` nur Textoperatoren.

---

## Die Falle bis 0.9.4.61

`gsave` und `grestore` schrieben `q` / `Q` gerade ins offene
Textobjekt:

```
BT … q … ET Q
```

Poppler, MuPDF und pdftotext zeichneten den ungültigen Stream
trotzdem. **Adobe Reader zeigte eine leere Seite ohne Meldung.**
`pdfinfo` meldete eine gesunde Datei.

Gefunden über `pdf4tcllib::labels::render` mit `-clip 1`.
`tests/nesting.test` prüft die Klasse, nicht einen String.

---

## Seit 0.9.4.62

Beide Methoden rufen `EndTextObj` **vor** `q` / `Q`. Am Aufruf
ändert sich nichts. Wer erzeugte Dateien byteweise vergleicht, sieht
`q` und `Q` außerhalb von `BT`/`ET`, und ein `ET` kann erscheinen,
wo keines war.

```tcl
$pdf setFont 12 Helvetica
$pdf text "Zeile eins" -x 50 -y 50
$pdf gsave
$pdf clip 40 40 200 80
$pdf rectangle 40 40 200 80 -filled 1
$pdf grestore
$pdf text "Zeile zwei" -x 50 -y 80
```

Nach `gsave` beginnt der nächste `text` ein neues Textobjekt. Das
ist richtig, nicht ein Rückschritt.

---

## Andere Methoden

`clip`, `rectangle` und der Linienweg schließen das Textobjekt
selbst bzw. über `DrawLine`. Nur `gsave` / `grestore` taten das
nicht — bis 0.9.4.62.

Transformationen (`translate`, `rotate`, `scale`) gehören zwischen
`gsave` und `grestore`. Text mit `Tm` folgt `cm` nicht; siehe
[Grafik](050-grafik.md). Trotzdem zuerst den Grafikzustand retten,
sonst bleibt die Matrix für alles Weitere schief.

---

## Regel

Nach `text` und vor jeder Grafikoperation, die `q`, `cm`, `W` oder
Pfadoperatoren schreibt: entweder eine Zeichenmethode nutzen, die
`EndTextObj` selbst aufruft, oder explizit `gsave`. Seit 0.9.4.62
reicht `gsave`.

Adobe als Prüfleser behalten. Eine Seite, die in Poppler voll ist
und in Acrobat leer, ist oft genau dieser Stream.

---

## Tagged Text seit 0.9.4.69

`TagEnsureMC` schreibt `BDC`/`EMC` außerhalb von `BT`/`ET` und
kann dafür ein offenes Textobjekt schließen. Stand der Aufruf
zwischen `Tm` und `Tj`, lag `Tj` außerhalb:

```
BT / Tm / ET / << /MCID n >> BDC / (…) Tj / EMC
```

ISO 32000-1 9.4: Textausgabe gehört zwischen `BT` und `ET`. Adobe
zeichnet sie außerhalb nicht; Poppler, MuPDF und Chrome tun es.
Seit 0.9.4.69 kommt die Auszeichnung **vor** `BeginTextObj`. Schließt
`TagEnsureMC` ein offenes Textobjekt, folgt `Tm` neu (`posSet`).

---

## Zusammenfassung

- `text` hält `BT` offen.
- `gsave` / `grestore` schließen `BT` vor `q` / `Q` (0.9.4.62).
- Tagged: Auszeichnung vor `BT`, sonst `Tj` draußen (0.9.4.69).
- Adobe: leere Seite ohne Meldung, wenn `q` in `BT` landet oder
  `Tj` außerhalb von `BT`/`ET`.

---

*Nächstes Kapitel: [CID-Subset und CMap](170-cid-subset-cmap.md)*
