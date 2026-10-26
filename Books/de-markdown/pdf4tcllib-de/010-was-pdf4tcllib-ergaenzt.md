# Was pdf4tcllib ergänzt

## Einführung

[pdf4tcl]{.index} zeichnet: Text an eine Stelle, eine Linie von hier
nach dort, ein Bild in ein Rechteck. Wer damit einen Bericht baut,
schreibt bald dieselben Hilfsprozeduren wie alle anderen: Seitenränder
ausrechnen, Text umbrechen, eine Tabelle über die Seitengrenze retten,
Kopf- und Fußzeile setzen, Sonderzeichen abfangen.

[pdf4tcllib]{.index} ist diese Schicht als Bibliothek. Es zeichnet nicht
selbst, sondern ruft dieselben Methoden des pdf4tcl-Objekts auf, die
auch der eigene Code benutzt. Beides lässt sich daher mischen: eine
Tabelle aus pdf4tcllib, darunter eine Linie direkt mit pdf4tcl.

Dieses Buch ist ein Werkstattbuch. Jedes Kapitel löst eine Aufgabe, die
in Berichten, Formularen und Listen immer wieder vorkommt, mit einem
Beispiel, das so läuft, wie es abgedruckt ist. Wie pdf4tcl selbst
arbeitet (Koordinaten, Schriften, Formulare, Verschlüsselung), erklärt
das Buch *pdf4tcl*; hier steht es nur, wo es für die Aufgabe nötig ist.

---

## Womit die Beispiele arbeiten

| Teil | Version |
|---|---|
| pdf4tcllib | 0.6.7 |
| pdf4tcl | 0.9.4.73 (pdf4tcllib verlangt mindestens 0.9.4.23) |
| Tcl | 8.6 und 9.0 |
| Schrift | DejaVu Sans Condensed (TrueType) |

Alle Beispiele liegen als Skript im Ordner `beispiele/` neben dem Buch,
mit der Kapitelnummer im Namen. Die Ausgaben im Text stammen aus diesen
Skripten.

---

## Die Module

pdf4tcllib ist eine Datei, `pdf4tcllib-0.6.7.tm`, mit mehreren
Namensräumen. Daneben liegen Pakete, die darauf aufbauen und einzeln
geladen werden.

| Namensraum | Aufgabe | Kapitel |
|---|---|---|
| `fonts` | TrueType-Schrift suchen und laden, Schriftnamen liefern | [Schriften](020-einrichten-und-schriften.md) |
| `unicode` | Zeichen, die die Schrift nicht hat, ersetzen | [Unicode](030-unicode-sicher-ausgeben.md) |
| `units`, `page` | Einheiten, Satzspiegel, Kopf- und Fußzeile | [Seitenkontext](040-einheiten-und-seitenkontext.md) |
| `text` | Umbruch, Breite messen, Kürzen, Hoch- und Tiefstellen | [Text setzen](050-text-setzen.md) |
| `table` | Tabellen mit Seitenumbruch, Gruppen, Kreuztabellen | [Tabellen](080-tabellen.md) |
| `drawing`, `image` | Formen, Verläufe, Pfeile, Bilder | [Bilder](140-bilder.md), [Pfeile](150-pfeile-und-callouts.md) |
| `form` | Beschriftete Formularfelder in Zeilen | [Formular-Layout](120-formular-layout.md) |
| `math` | Formeln im Text | [Formeln](160-formeln.md) |
| `tag`, `state`, `measure`, `layout` | Barrierefreiheit, Grafikzustand, Höhe vorab messen, Blöcke stapeln | [Barrierefrei](180-barrierefreie-pdfs.md), [Zustand](190-grafikzustand.md), [Stapeln](200-messen-und-stapeln.md) |

| Paket | Aufgabe | Kapitel |
|---|---|---|
| `pdf4tcltoc` | Inhaltsverzeichnis mit echten Seitenzahlen | [Inhaltsverzeichnis](110-inhaltsverzeichnis.md) |
| `pdf4tclchart` | Balken-, Linien- und Tortendiagramme | [Diagramme](100-diagramme.md) |
| `pdf4tclflow` | Text über Spalten und Seiten | [Spaltenfluss](070-spaltenfluss-wasserzeichen.md) |
| `pdf4tcllabels` | Etikettenbögen | [Etikettenbögen](130-etikettenboegen.md) |
| `pdf4tcltreeview` | ein `ttk::treeview` als Tabelle oder Gliederung | [Treeview](170-treeview.md) |
| `pdf4tclforms` | ausfüllbare Formulare aus einer Beschreibung | nur [Anhang B](810-anhang-api.md) |
| `pdf4tcltable` | ein `tablelist`-Widget als PDF | nur [Anhang B](810-anhang-api.md) |
| `pdf4tcltext` | ein Tk-`text`-Widget als PDF | nur [Anhang B](810-anhang-api.md) |
| `pdf4tclcanvas` | eine Tk-`canvas`-Zeichnung als PDF | nur [Anhang B](810-anhang-api.md) |

Die vier letzten haben im Buch kein eigenes Kapitel; ihre Aufrufe stehen
in Anhang B, ihre Meldungen in Anhang D.

---

## Ein erster Bericht

Das kleinste sinnvolle Beispiel: Kopfzeile, Überschrift, ein
umbrochener Absatz, Fußzeile mit Seitenzahl.

```tcl
# 010-erstes-dokument.tcl -- ein Bericht in wenigen Zeilen
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init
set ctx [pdf4tcllib::page::context a4 -margin 20]

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
pdf4tcllib::page::header $pdf $ctx "Monatsbericht"

set x [dict get $ctx left]
set y [expr {[dict get $ctx top] + 20}]
set w [dict get $ctx text_w]

$pdf setFont 16 [pdf4tcllib::fonts::fontSansBold]
pdf4tcllib::unicode::safeText $pdf "Umsatz im Oktober" -x $x -y $y
set y [expr {$y + 28}]

set absatz "Der Umsatz stieg gegenüber dem Vormonat um 4 %. Am\
    stärksten wuchs der Bereich Wartung, der jetzt ein Drittel des\
    Umsatzes ausmacht. Die Zahlen sind vorläufig; die Schlussrechnung\
    folgt mit dem Quartal."
set y [pdf4tcllib::text::writeParagraph $pdf $absatz $x $y $w 11]
puts "nächste Zeile bei y = $y"

pdf4tcllib::page::footer $pdf $ctx "Vertraulich" 1
$pdf endPage
$pdf write -file 010-erstes-dokument.pdf
$pdf destroy
```

Ausgabe:

```text
pdf4tcllib::fonts: TTF italic faces loaded
pdf4tcllib::fonts: TTF faces loaded from /usr/share/fonts/truetype/dejavu
nächste Zeile bei y = 152.69291338582678
```

Die zwei ersten Zeilen schreibt `fonts::init` nach stderr. Sie sagen,
dass eine TrueType-Schrift gefunden wurde und woher sie kommt.

Was die Zeilen tun:

- `fonts::init` sucht einmal je Prozess eine TrueType-Schrift und meldet
  sie bei pdf4tcl an. Danach liefern `fonts::fontSans`,
  `fonts::fontSansBold` usw. die Namen, unter denen sie angemeldet ist.
- `page::context` rechnet aus Papier und Rand den Satzspiegel aus und
  gibt ein Dict zurück: `left`, `top`, `text_w` und weitere Werte, alle
  in Punkt.
- `page::header` und `page::footer` setzen Kopf- und Fußzeile mit einer
  dünnen Linie, beide innerhalb des Rands.
- `unicode::safeText` schreibt Text wie `$pdf text`, ersetzt aber vorher
  Zeichen, die die Schrift nicht hat.
- `text::writeParagraph` bricht den Absatz in der Breite `w` um und gibt
  die y-Position nach der letzten Zeile zurück. Dort geht es weiter.

`-orient true` bei `pdf4tcl::new` gehört dazu: y wächst nach unten, wie
im Tk-Canvas. `page::context` geht ohne weitere Angabe ebenfalls davon
aus. Wie beide zusammenpassen müssen, steht im Kapitel
[Einheiten und Seitenkontext](040-einheiten-und-seitenkontext.md).

---

## Wie das Buch zu lesen ist

- **Teil 1** (dieses Kapitel bis Kapitel 4) richtet ein, was alle
  anderen Kapitel voraussetzen: Schrift, Unicode, Seitenkontext.
- **Teile 2 bis 4** sind Aufgaben: Text, Tabellen, Diagramme,
  Inhaltsverzeichnis, Etiketten, Formulare. Sie lassen sich einzeln
  lesen.
- **Teil 5** macht ein Dokument barrierefrei und zeigt, wie man Blöcke
  vorab misst und untereinander setzt.
- Die **Fallstudie** baut einen Bericht von den Daten bis zum
  Inhaltsverzeichnis.
- Die **Anhänge** sammeln Fallen, die API je Modul und die Meldungen.

::: {.info}
**Getestet mit** pdf4tcllib 0.6.7, pdf4tcl 0.9.4.73, Tcl 8.6.18 und
9.0.4, Debian mit DejaVu-Schriften.
:::

---

*Nächstes Kapitel: [Einrichten und Schriften](020-einrichten-und-schriften.md)*
