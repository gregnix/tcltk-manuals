# Glossar

**Artefakt** — Inhalt ohne Bedeutung für den Text (Linien, Kopfzeile,
Seitenzahl); ein Vorleseprogramm überspringt ihn. `tag::artifact`.

**CID-Modus** — Schrift mit Identity-H-Kodierung; jedes Zeichen der
TrueType-Datei ist verfügbar. Einschalten mit `fonts::init -cid 1`.

**256-Zeichen-Modus** — Vorgabe von `fonts::init`: ASCII, Latin-1 und
32 ausgewählte Zeichen in einer einfachen Kodierung.

**Ersatztext** — Beschreibung einer Abbildung für Leser, die sie nicht
sehen; `-alt`.

**Erscheinung** — was ein Formularfeld auf der Seite zeigt, solange
niemand hineinklickt. Mit `/NeedAppearances` baut der Betrachter sie
neu auf.

**Grundlinie** — die Linie, auf der die Buchstaben stehen; `y` bei
`$pdf text` bezeichnet sie.

**Lesezeichen** — Eintrag in der Gliederung am Rand des Betrachters;
`toc::heading` legt je Überschrift eines an.

**Punkt** — Maßeinheit von PDF und pdf4tcl, 1/72 Zoll, etwa 0,353 mm.

**Rahmen (Bild)** — die Fläche, in die `image::place` ein Bild einpasst;
`contain` lässt Rand frei, `cover` schneidet ab.

**Satzspiegel** — die Fläche innerhalb der Ränder, in der der Inhalt
steht; `left`, `top`, `text_w`, `text_h` im Seitenkontext.

**Seitenkontext** — das Dict aus `page::context` mit allen Maßen der
Seite.

**Strukturbaum** — die Gliederung eines barrierefreien PDFs in
Überschriften, Absätze, Tabellen und Abbildungen; `$pdf tagged 1`.

**Zugriffsprozedur** — `fonts::fontSans` und Verwandte; liefern den
Namen, unter dem `fonts::init` eine Schrift angemeldet hat.

---

*Nächstes Kapitel: [Fehlermeldungen](830-anhang-fehlermeldungen.md)*
