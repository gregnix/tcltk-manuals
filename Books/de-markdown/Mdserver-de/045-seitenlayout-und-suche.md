# Seitenlayout und Suche

## Einführung

`site` ist der Vorgabestil. Er baut jede Seite
gleich auf, mit einem einzigen Stylesheet (`styles/site.css`), ohne
JavaScript. Dazu kommt eine [Volltextsuche]{.index} über alle
Markdown-Dateien der Wurzel, mit tclutils auch über PDFs, Office- und
CSV-Dateien.

Warum ein eigener Stil: die älteren machten `<body>` zum Raster. Eine
lange Seitenleiste schob den Text dann unter eine Lücke ihrer Höhe.

---

## Aufbau einer Seite

```
+--------------------------------------------------------------+
| [=] Titel  Start  Alle Dokumente  Bereich …        [Suchen]  |
+--------------+--------------------------------+--------------+
| Seitenleiste | Start > Ordner > Seite         | Auf dieser   |
|  Buch:       |                                | Seite        |
|  Übersicht   | # Überschrift                  |  - h2        |
|  Kapitel 1   | Text …                         |    - h3      |
|  Kapitel 2   |                                |  - h2        |
|              | [← Zurück]          [Weiter →] |              |
+--------------+--------------------------------+--------------+
```

| Teil | Inhalt |
|---|---|
| Kopfleiste | Site-Titel, Start, Alle Dokumente, Bereiche, Suchfeld |
| Seitenleiste | im Buch: Titel, PDF/HTML, Übersicht und Kapitel; sonst Unterordner und Dokumente des Ordners |
| Brotkrumen | Start › Ordnertitel › Seitentitel |
| Mitte | der gerenderte Inhalt |
| Zurück/Weiter | zwei Karten, nur in Buchkapiteln |
| Auf dieser Seite | h2 und h3 der Seite, ab drei Einträgen |

Die [Brotkrumen]{.index} nehmen als Beschriftung den Ordnertitel: Buchtitel
aus `book.tcl`, sonst H1 der `index.md`, sonst H1 der `README.md`, sonst
den Ordnernamen. Haben ein bookkit-Ordner `book-xyz/` und sein Buch
`Xyz-de/` denselben Titel, steht er nur einmal da.

Die Spalte „Auf dieser Seite“ fehlt bei weniger als drei Überschriften
h2/h3. Die Seitenleiste fehlt, wenn der Ordner nichts zu zeigen hat.

---

## Handbuchseiten

Eine in Markdown umgewandelte [Handbuchseite]{.index} beginnt mit
`# NAME` (deutsch auch `# BEZEICHNUNG`) und hat weitere H1 wie
`# SYNOPSIS` und `# DESCRIPTION`. mdserver erkennt solche Seiten an der
ersten H1 und behandelt sie im Stil `site` so:

| Stelle | Wert |
|---|---|
| Titel, Brotkrumen, Seitenleiste, Kachel, Suchtreffer | `CommandName` aus dem YAML-Kopf (TIP-700-Form), sonst der Teil der NAME-Zeile vor dem Gedankenstrich (aus `grab - Eingaben umlenken` wird `grab`) |
| „Auf dieser Seite“ | h1 und h2 statt h2 und h3, sobald die Seite mehr als eine H1 hat |

Ohne YAML-Kopf und ohne NAME-Zeile bleibt der Titel `NAME`. Die Liste
*Alle Dokumente* (`/?nav=index`) nimmt weiter die erste H1; dort heißen
solche Seiten `NAME`.

---

## Ordner ohne index.md

Liegt in einem Ordner keine `index.md` und keine `book.tcl`, zeigt
`site` den Inhalt als Kacheln. Eine [Kachel]{.index} ist eine Karte
mit Titel und kurzem Text. Oben der Ordnertitel, darunter
der erste Absatz der `README.md`, wenn es eine gibt. Dann bis zu vier
Gruppen:

| Gruppe | Was hineinkommt | Kachel zeigt |
|---|---|---|
| Bücher | Ordner mit `book.tcl`, oder ein Ordner, der Bücher direkt enthält | Abzeichen „Buch“, Titel, Untertitel, Sprachen |
| Bereiche | andere Ordner, wenn darunter eine `.md` oder `.pdf` liegt | Titel, erster Absatz von `index.md` oder `README.md` |
| Dokumente | `.md`-Dateien außer `index.md`, dazu `.pdf` | H1 und erster Absatz; bei einer PDF Dateiname, „PDF“ und Größe |
| Dateien | alles andere außer `.md`, `.pdf`, `.tcl`, `.tsv`, `.css`; eine `.csv` öffnet als Tabelle | Name, Typ, Größe in KB |

Ein Ordner nur mit PDFs zählt als Ordner mit Dokumenten. Er erscheint
in der Kopfleiste, in der Seitenleiste und bei den Kacheln. Die
Seitenleiste eines Ordners nennt seine PDFs nach den Markdown-Dokumenten,
mit dem Zusatz „PDF“.

Ein bookkit-Ordner `book-xyz/` mit genau einem Buch darin führt direkt
in das Buch. Mit mehreren Ausgaben (`Xyz-de/`, `Xyz-en/`) führt die
Kachel in den Ordner, die Sprachen stehen auf der Kachel.

Punkt-Ordner und Punkt-Dateien erscheinen nie. Ein leerer Ordner zeigt
„Keine Dokumente gefunden.“

Die älteren Stile zeigen stattdessen eine schlichte Liste, gerendert
über mdstack.

---

## Dunkelmodus, Handy, Druck

**Dunkel.** Der [Dunkelmodus]{.index} folgt der Systemeinstellung
(`prefers-color-scheme`). `?theme=dunkel` oder `--theme dunkel`
erzwingen ihn.

**Schmale Bildschirme.** Unter 1180 px Breite fällt die Spalte „Auf
dieser Seite“ weg. Unter 820 px verschwinden Seitenleiste und
die Links der Kopfleiste; links in der Kopfleiste erscheint der Menüknopf (drei Striche, im Bild `[=]`). Er
öffnet die Seitenleiste samt Kopfleisten-Links. Das ist ein
Kontrollkästchen mit CSS, kein JavaScript.

**Druck.** Kopfleiste, beide Seitenspalten, Brotkrumen und die
Zurück/Weiter-Karten fallen weg. Gedruckt wird der Text.

---

## Fehlende Seite

Eine unbekannte URL gibt **404** mit einer Seite im selben Layout:
„Nicht gefunden“, dazu Links auf die Startseite und auf *Alle
Dokumente*. Die älteren Stile senden eine schlichte 404-Seite.

---

## CSV als Tabelle

Ist `tclutils::tucsv` 0.2 ladbar (`--csv-view auto`, Vorgabe), zeigt
`site` eine `.csv` als [Tabelle]{.index} statt sie herunterzuladen:
oben der Dateiname, die Zahl der Zeilen und der Link „als CSV
herunterladen“, darunter die Tabelle mit der ersten Zeile als Kopf.

| Frage | Antwort |
|---|---|
| Trennzeichen | `;`, wenn die erste Zeile mehr davon hat als `,`, sonst `,` |
| Kodierung | UTF-8, wenn die Bytes gültiges UTF-8 sind, sonst cp1252 (Excel unter Windows) |
| Länge | höchstens 2000 Zeilen, darunter ein Hinweis auf die Gesamtzahl |
| die Datei selbst | `datei.csv?raw=1` |

Der Inhalt steht auch in der Suche (`typ:csv`). Die älteren Stile liefern
die Datei unverändert. `--csv-view 0` schaltet die Tabellenseite ab.

---

## Suche

In der Kopfleiste steht ein Suchfeld. Es schickt `/?q=Wörter`. Die
Adresse geht auch von Hand:

```
http://127.0.0.1:8080/?q=control+port
```

Regeln:

- Alle Wörter müssen vorkommen (UND). Wörter unter zwei Zeichen fallen
  weg.
- Groß und klein egal.
- [Umlautfaltung]{.index}: `ae`, `oe`, `ue`, `ss` treffen `ä`, `ö`, `ü`,
  `ß` — und umgekehrt. `groesse` findet „Größe“.
- Gesucht wird im Text ohne Markdown-Zeichen und ohne Link-Ziele.
- Treffer im Titel (erste H1) zählen mehr als Treffer im Text.
- Höchstens 50 Treffer, die besten zuerst.

[Suchsyntax]{.index} über einfache Wörter hinaus:

| Eingabe | Wirkung |
|---|---|
| `"die Freigabe"` | Wortfolge: die Wörter in dieser Reihenfolge, auch über einen Zeilenumbruch |
| `-proxy`, `-"im Archiv"` | Treffer mit diesem Wort oder dieser Folge fallen weg |
| `a OR b`, `a ODER b`, `a \| b` | eins von beiden; bindet nur die beiden Nachbarn |
| `in:buch/kapitel` | nur unterhalb dieses Ordners, relativ zur Wurzel |
| `typ:md`, `typ:pdf`, `typ:office`, `typ:csv` | nur diese Art von Datei |

`OR` und `ODER` gelten nur großgeschrieben; `or` ist ein gewöhnliches
Suchwort. `in` und `typ` gehen auch als URL-Parameter
(`/?q=router&in=netz&typ=pdf`); steht beides da, gilt die Angabe in der
Anfrage. `..`, `.` und Punkt-Ordner in `in` zählen als „überall“.

[Eingrenzen]{.index} geht auch ohne Syntax. Unter dem Suchfeld der
Ergebnisseite stehen zwei Auswahlen: *Bereich* und *Typ*. Das Suchfeld
in der Kopfleiste schickt den Ordner der aktuellen Seite als `von=` mit.
*Bereich* bietet dann diesen Ordner und alle darüber an, jeweils mit
ihrem Titel. Gesucht wird trotzdem zuerst überall; eingegrenzt wird erst,
wenn man einen Bereich wählt. Aus einem Buchkapitel heraus heißt das: ein
Klick, und die Suche bleibt im Buch.

Jeder Treffer zeigt den Titel als Link, darunter den Ordnerpfad
(`Bücher › Beispiel`, Ordnertitel wie in den Brotkrumen; bei einer Datei
in der Wurzel leer) und einen Ausschnitt von etwa 220
Zeichen. Er beginnt kurz vor dem ersten Treffer im Text, auch wenn der
weit hinten steht. Die Suchwörter sind darin markiert, auch in
gemischter Schreibung: `groesse` markiert „Grösse“, „Größe“ und
„GROESSE“.

**Bestand.** Durchsucht werden alle `.md` unter `--root`. Jeder Text
wird einmal gelesen und mit seiner mtime behalten; eine neue Suche liest
nur geänderte Dateien neu. Punkt-Ordner bleiben draußen (außer mit
`--dotfiles 1`), Symlinks immer — wie beim Ausliefern.

**PDFs.** Ist [`tclutils::tupdftext`]{.index} ladbar (ab tclutils 0.67.0,
auf dem Modulpfad oder über `TCLUTILS_TM`), durchsucht `?q=` auch jede
`.pdf` unter der Wurzel, Seite für Seite. Das ist die Vorgabe
`--pdf-search auto`; `--pdf-search 1` warnt beim Start, wenn das Paket
fehlt, `0` schaltet es ab. Ein Treffer heißt `handbuch, S. 17` und
verlinkt auf `handbuch.pdf#page=17`. Firefox (pdf.js) und Chrome
springen damit auf die Seite; andere Betrachter öffnen die Datei vorn.

Den Text liest `tupdftext` in reinem Tcl. Er landet in `--pdf-cache`
(Vorgabe `$HOME/.cache/mdserver-pdf`, nie in der Wurzel), eine Datei je
PDF, gültig solange mtime und Größe stimmen. Eine PDF ohne Text (Scan,
verschlüsselt) gibt keinen Treffer. Kann `tupdftext` eine Datei nicht
lesen (beschädigt, keine PDF), steht sie ebenfalls leer im Cache, und
das Protokoll sagt warum:

```
[10:29:26] pdf worker: /srv/md/pdfs/kaputt.pdf has no text, reader failed: not a PDF (no %PDF- header): /srv/md/pdfs/kaputt.pdf
```

Gelesen wird in einem eigenen `tclsh` je PDF, dem PDF-Worker
(`lib/pdftext-worker.tcl`, `--pdf-worker 1`, Vorgabe). mdserver startet
ihn mit `tclutils::tutask`, das ohnehin neben `tupdftext` liegt:

```tcl
await [pipe [list $tclsh pdftext-worker.tcl $pdf ...] -encoding utf-8] \
    -timeout 600000
```

`await` hält nur die Aufgabe an, die die PDFs der Reihe nach abarbeitet;
der Ereignis-Loop läuft weiter. Der Cache füllt sich gleich nach dem
Start und danach für jede neue oder geänderte PDF.
mdserver wartet nicht auf ihn: Eine Suche liefert, was im Cache steht,
und sagt dazu „3 PDFs werden noch gelesen; ihre Seiten fehlen in dieser
Liste“. Seiten und alle anderen Anfragen kommen sofort.

Mit `--pdf-worker 0` liest mdserver die PDFs im eigenen Prozess.
mdserver hat einen einzigen Ereignis-Loop, und solange `tupdftext`
läuft, steht er für alle. Gemessen mit 16 PDFs (1804 Seiten), leerer
Cache:

| | erste Suche | Seite, gleichzeitig angefragt |
|---|---:|---:|
| im Serverprozess (`--pdf-worker 0`) | 36,4 s | 36,3 s |
| mit Worker | 0,03 s | 0,04 s |

Der Worker brauchte für die 16 PDFs 35,9 s, so lange wie im
Serverprozess: ein `tclsh` je PDF kostet keine messbare Zeit; danach dauert eine Suche
über alle Seiten 0,03 s. Nach einem Neustart mit gefülltem Cache 0,3 s
für die erste Suche, weil die Cache-Dateien eingelesen werden.

Wenn es keinen Worker gibt oder er scheitert:

- Ohne `tclutils::tutask`, ohne `pdftext-worker.tcl` oder wenn mdserver
  als Starpack läuft (`info nameofexecutable` startet dann die
  Anwendung, keinen `tclsh`), liest mdserver selbst, wie mit
  `--pdf-worker 0`.
- Scheitert der Worker an einer PDF (Absturz, Exit-Code, mehr als
  10 Minuten), steht es im Protokoll, und die nächste Suche versucht es
  noch einmal. Beim zweiten Mal bleibt die PDF draußen, bis sie sich
  ändert (leerer Eintrag im Cache).
- Hält mdserver über den Steuerport an (`mdctl.tcl … stop`), bricht
  `tutask` den laufenden Worker ab. Stirbt mdserver hart, liest der
  Worker seine eine PDF zu Ende und endet dann.

Ob die PDF-Suche an ist, steht beim Start im Banner:

```
  PDF:   Suche an (tclutils::tupdftext 0.1, Cache /var/cache/mdserver-pdf)
  PDF:   Suche aus (--pdf-search 0)
  PDF:   Suche aus: tclutils::tupdftext nicht gefunden (TCLUTILS_TM setzen oder tclutils/lib/tm auf den Modulpfad)
```

Die erste Zeile gehört zu einem Start mit `--pdf-cache
/var/cache/mdserver-pdf`.

Außer im Banner meldet `auto` nichts. Unter systemd gehört
`TCLUTILS_TM` deshalb in die Unit (`Environment=TCLUTILS_TM=…`).

**Office-Dateien.** Mit `--office-search auto` (Vorgabe) durchsucht
`?q=` auch Office-Dateien, jedes Format, dessen Modul aus tclutils ladbar
ist: `.odt`, `.ods`, `.odp` mit `tuodf`, `.docx` mit `tudocx`, `.xlsx`
mit `tuxlsx`. Ein Treffer je Datei, verlinkt auf die Datei selbst.
Gelesen wird der Text der Absätze, auch in Tabellen, Listen und auf
Folien, bei Tabellenkalkulationen der Inhalt aller Zellen aller Blätter.
Überschriften in ODF findet erst `tuodf` 0.2. Das Lesen geht schnell
(ein ZIP und wenige XML-Teile) und läuft im Serverprozess, ohne Worker;
der Text bleibt mit der mtime im Suchindex. Das Banner nennt die
Formate:

```
  Office: Suche an (.odt .ods .odp .docx .xlsx; tuodf 0.2, tudocx 0.1, tuxlsx 0.1)
```

**Suche als JSON.** `/?q=…&format=json` gibt die Treffer als
[JSON]{.index} zurück, in jedem Stil, mit `in` und `typ` wie oben. Das
braucht `tclutils::tujson`; ohne es antwortet mdserver mit **501**.

```json
{"query":"proxy_pass","pending":0,"hits":[{"url":"/a/eins.md",
 "title":"Netzwerk","path":"A","snippet":"… der proxy_pass Wert.","score":1}]}
```

`snippet` ist reiner Text ohne `<mark>`; `pending` zählt die PDFs, die
der Worker noch liest. So kann ein Skript oder ein Editor die Suche
benutzen, ohne HTML zu zerlegen.

**Ältere Stile.** `?q=` geht auch dort. Die Antwort ist eine schlichte
Liste „Suche: …“ mit Titel und Ordnerpfad, ohne Ausschnitt. Ein Suchfeld
gibt es dort nicht.

---

## Zusammenfassung

- `site` ist ein ganzes Layout, ohne JavaScript, mit einem Stylesheet.
- Ordner ohne `index.md` werden Kacheln: Bücher, Bereiche, Dokumente,
  Dateien.
- Dunkel nach System oder `theme=dunkel`; Menüknopf unter 820 px.
- Handbuchseiten mit `# NAME` heißen nach dem Befehl.
- `/?q=` sucht UND-verknüpft, ohne Groß/klein, mit Umlautfaltung.
- Mit tclutils (ab 0.67.0) auch in PDFs, ein Treffer je Seite
  (`datei.pdf#page=N`); der Text liegt im Cache außerhalb der Wurzel.
- Wortfolgen in Anführungszeichen, `-wort`, `OR`, `in:` und `typ:`;
  *Bereich* und *Typ* auf der Ergebnisseite.
- Mit tclutils 0.69.0 auch Office-Dateien (ODF, DOCX, XLSX), CSV als
  Tabelle und die Suche als JSON (`format=json`).

---

*Nächstes Kapitel: [HTTP-Verhalten](050-http-verhalten.md)*
