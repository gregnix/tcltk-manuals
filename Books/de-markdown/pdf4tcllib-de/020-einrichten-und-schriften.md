# Einrichten und Schriften

## Einführung

pdf4tcllib braucht zwei Dinge: das Paket pdf4tcl und eine
TrueType-Schrift. Ohne TrueType arbeitet es mit Helvetica weiter, dann
fehlen aber alle Zeichen außerhalb von Latin-1, und das PDF lässt sich
nicht als PDF/A ablegen. Dieses Kapitel richtet beides ein und zeigt,
wie man prüft, was `fonts::init` gefunden hat.

---

## Das Modul laden

pdf4tcllib ist ein Tcl-Modul: eine Datei `pdf4tcllib-0.6.7.tm` im Ordner
`lib/`, daneben die Zusatzpakete (`pdf4tcltoc-0.1.tm` usw.). Tcl findet
sie über den Modulpfad:

```tcl
tcl::tm::path add /pfad/zu/pdf4tcllib/lib
package require pdf4tcllib
```

Oder ohne Änderung am Skript über die Umgebung, je nach Tcl-Version:

```bash
export TCL8_6_TM_PATH=/pfad/zu/pdf4tcllib/lib
export TCL9_0_TM_PATH=/pfad/zu/pdf4tcllib/lib
```

pdf4tcl selbst ist ein klassisches Paket mit `pkgIndex.tcl`; sein Ordner
gehört in `auto_path` oder in `TCLLIBPATH`. `package require pdf4tcllib`
lädt pdf4tcl nicht mit. Beide Zeilen stehen darum am Anfang jedes
Beispiels:

```tcl
package require pdf4tcl
package require pdf4tcllib
```

Wer pdf4tcllib mit einer Anwendung ausliefert, kopiert die gebrauchten
`.tm`-Dateien in einen eigenen Modulordner der Anwendung und fügt ihn mit
`tcl::tm::path add` hinzu. Mehr braucht es nicht; pdf4tcllib hat außer
pdf4tcl keine Abhängigkeiten. Nur der Namensraum `image` braucht Tk.

---

## Skripte in UTF-8

Die Beispiele enthalten Umlaute im Quelltext. Tcl 9 liest Skripte als
UTF-8. Tcl 8.6 liest sie in der Systemkodierung, und die ist ohne
gesetzte Locale (`LANG` leer, etwa in einem Cron-Job oder Container)
ISO 8859-1. Dann wird aus „gegenüber“ im PDF „gegenÃ¼ber“, ohne
Fehlermeldung.

Abhilfe, eins von dreien:

- die Locale setzen (`LANG=de_DE.UTF-8` oder `C.UTF-8`),
- das Skript mit `source -encoding utf-8 skript.tcl` laden,
- Zeichen außerhalb von ASCII als `\u`-Folge schreiben (`gegen\u00fcber`).

Prüfen lässt sich die Kodierung mit `encoding system`.

---

## fonts::init

```tcl
pdf4tcllib::fonts::init ?-fontdir dir? ?-family name? \
    ?-cid 0|1? ?-force 0|1?
```

`fonts::init` sucht eine TrueType-Familie, meldet ihre Schnitte bei
pdf4tcl an und merkt sich die Namen. Es wirkt einmal je Prozess; jeder
weitere Aufruf kehrt sofort zurück.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-family` | `DejaVuSansCondensed` | Name der Familie, so wie er in den Dateinamen steht |
| `-fontdir` | – | Ordner, der vor allen anderen durchsucht wird |
| `-cid` | `0` | `1`: volle Schrift statt 256 Zeichen (Abschnitt [256 Zeichen oder CID](#256-zeichen-oder-cid)) |
| `-force` | `0` | `1`: erneut suchen, auch wenn schon geladen |

### Welche Dateien es sucht

Eine Familie gilt als gefunden, wenn in einem Ordner **beide** Dateien
liegen:

```
<familie>.ttf
<familie>-Bold.ttf
```

Aus demselben Ordner nimmt `fonts::init` dazu, wenn vorhanden:

- `<familie>-Oblique.ttf` und `<familie>-BoldOblique.ttf` für kursiv,
- `<familie>Mono.ttf`, sonst `DejaVuSansMono.ttf`, sonst
  `LiberationMono-Regular.ttf` für die Festbreitenschrift.

Die Namen folgen dem Schema von DejaVu. Liberation heißt
`LiberationSans-Regular.ttf` und `LiberationSans-Italic.ttf`; das passt
nicht, auch nicht mit `-family LiberationSans`.

### Wo es sucht

In dieser Reihenfolge, der erste Ordner mit beiden Dateien gewinnt:

1. der Ordner aus `-fontdir`,
2. `fonts/` neben `lib/` und `lib/fonts/`, also beim Modul selbst,
3. unter Linux `/usr/share/fonts/truetype/dejavu`,
   `/usr/share/fonts/dejavu-sans-fonts` (Fedora), `/usr/share/fonts/TTF`
   (Arch), `/usr/share/fonts/truetype`, `$HOME/.fonts`,
   `$HOME/.local/share/fonts`,
4. unter Windows `%SystemRoot%\Fonts` und
   `%LOCALAPPDATA%\Microsoft\Windows\Fonts`,
5. unter macOS `/Library/Fonts`, `/System/Library/Fonts`,
   `$HOME/Library/Fonts`.

Unterordner durchsucht es nicht.

### Woher die Schrift kommt

| System | Was zu tun ist |
|---|---|
| Debian, Ubuntu | `apt install fonts-dejavu-core fonts-dejavu-extra fonts-dejavu-mono` |
| Fedora | `dnf install dejavu-sans-fonts dejavu-sans-mono-fonts` |
| Windows, macOS | DejaVu ist nicht dabei: die `.ttf`-Dateien in `fonts/` neben `lib/` legen oder `-fontdir` angeben |

Unter Debian liegen die Schnitte in drei Paketen. `fonts-dejavu-core`
enthält `DejaVuSans.ttf` und `DejaVuSans-Bold.ttf`, aber nicht die
schmale Familie `DejaVuSansCondensed`, die `fonts::init` ohne `-family`
sucht. Die liegt in `fonts-dejavu-extra`, zusammen mit allen
Oblique-Schnitten. Ist nur das Kernpaket installiert, hilft
`-family DejaVuSans`.

Für eine Anwendung, die auf fremden Rechnern laufen soll, ist der
Ordner `fonts/` neben `lib/` der sichere Weg: Die Schrift reist mit, und
das PDF sieht überall gleich aus.

---

## Prüfen, was geladen ist

```tcl
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init
set kursiv [pdf4tcllib::fonts::hasTtfItalic]
puts "TrueType:  [pdf4tcllib::fonts::hasTtf]  kursiv: $kursiv"
puts "CID-Modus: [pdf4tcllib::fonts::isCidMode]"
foreach p {fontSans fontSansBold fontSansItalic fontSansBoldItalic
           fontMono} {
    puts [format "%-20s %s" $p [pdf4tcllib::fonts::$p]]
}
```

Ausgabe:

```text
pdf4tcllib::fonts: TTF italic faces loaded
pdf4tcllib::fonts: TTF faces loaded from /usr/share/fonts/truetype/dejavu
TrueType:  1  kursiv: 1
CID-Modus: 0
fontSans             Pdf4tclSans
fontSansBold         Pdf4tclSansBold
fontSansItalic       Pdf4tclSansItalic
fontSansBoldItalic   Pdf4tclSansBoldItalic
fontMono             Pdf4tclMono
```

Findet `fonts::init` nichts, sagt es auf stderr, wo es gesucht hat, und
fällt auf die Standardschriften zurück:

```text
pdf4tcllib::fonts: No TTF fonts found, falling back to Helvetica
pdf4tcllib::fonts: searched in:
pdf4tcllib::fonts:   [---] .../pdf4tcllib/lib/../fonts
pdf4tcllib::fonts:   [---] .../pdf4tcllib/lib/fonts
pdf4tcllib::fonts:   [exists] /usr/share/fonts/truetype/dejavu
...
TrueType: 0  Sans: Helvetica
```

`[exists]` heißt nur, dass es den Ordner gibt, nicht, dass die Familie
darin liegt. Das Programm läuft weiter. Wer sich auf TrueType verlässt,
prüft darum `fonts::hasTtf` und bricht selbst ab:

```tcl
pdf4tcllib::fonts::init
if {![pdf4tcllib::fonts::hasTtf]} {
    error "keine TrueType-Schrift gefunden, siehe stderr"
}
```

---

## Schriftnamen immer über die Zugriffsprozeduren

pdf4tcl kennt die geladene Schrift unter einem Namen, den
`fonts::init` vergibt: `Pdf4tclSans` mit TrueType, `Helvetica` ohne.
Der Code fragt ihn ab, statt ihn hinzuschreiben:

| Prozedur | mit TrueType | ohne |
|---|---|---|
| `fonts::fontSans` | `Pdf4tclSans` | `Helvetica` |
| `fonts::fontSansBold` | `Pdf4tclSansBold` | `Helvetica-Bold` |
| `fonts::fontSansItalic` | `Pdf4tclSansItalic` | `Helvetica-Oblique` |
| `fonts::fontSansBoldItalic` | `Pdf4tclSansBoldItalic` | `Helvetica-BoldOblique` |
| `fonts::fontMono` | `Pdf4tclMono` | `Courier` |

So läuft derselbe Code mit und ohne TrueType. Die kursiven Schnitte
fallen einzeln auf Helvetica-Oblique zurück, wenn die Oblique-Dateien
fehlen (`fonts::hasTtfItalic` ist dann 0).

`fonts::setFont` nimmt einen Stil als Wort:

```tcl
pdf4tcllib::fonts::setFont $pdf 14 Sans Bold       ;# fontSansBold
pdf4tcllib::fonts::setFont $pdf 14 Sans Italic     ;# fontSansItalic
pdf4tcllib::fonts::setFont $pdf 14 Sans BoldItalic ;# ...BoldItalic
```

Nach `fonts::init` ist die Familie dabei egal: `Bold`, `Italic` und
`BoldItalic` führen immer zu den geladenen Schnitten. Ohne Stil setzt
`fonts::setFont` die Familie unverändert, `fonts::setFont $pdf 14
Helvetica` also wirklich Helvetica. Für normalen Text darum
`$pdf setFont 14 [pdf4tcllib::fonts::fontSans]`.

Mit TrueType sind alle Schnitte eingebettet:

```text
$ pdffonts 020-schriften.pdf     (Spalten gekürzt)
name                             type       emb
AAAAAA+_Pdf4tcl_Base_Italic      TrueType   yes
AAAAAA+_Pdf4tcl_Base_BoldItalic  TrueType   yes
AAAAAA+_Pdf4tcl_Base_Mono        TrueType   yes
AAAAAA+_Pdf4tcl_Base_Regular     TrueType   yes
AAAAAA+_Pdf4tcl_Base_Bold        TrueType   yes
```

---

## 256 Zeichen oder CID

`fonts::init` meldet die Schrift in einem von zwei Modi an:

| | ohne `-cid` | `-cid 1` |
|---|---|---|
| Zeichen | 256: ASCII, Latin-1 und 32 Zeichen dazu | alle, die die Schrift hat |
| darunter | Umlaute, €, –, —, …, •, Pfeile ←↑→↓, Rahmenlinien, ✓ ✗ ☐ ☑, ≤ ≥ | zusätzlich Griechisch, Mathematik, Kyrillisch, typografische Anführungszeichen |
| PDF mit einer Zeile Text | 22 KB | 49–52 KB, je nach Text |
| Zeichen außerhalb | werden „?“ | werden „?“, wenn die Schrift sie nicht hat |

Die Größen stammen aus dem Beispiel des nächsten Kapitels; der
Unterschied ist die Schrift, die im CID-Modus vollständiger eingebettet
wird.

Für deutsche Texte ist `-cid 1` die bessere Wahl. Die 256 Zeichen
reichen für Umlaute und ß, aber nicht für die deutschen
Anführungszeichen „ und “: Sie fehlen in der Auswahl. Was das für
`safeText` bedeutet, zeigt das Kapitel
[Unicode sicher ausgeben](030-unicode-sicher-ausgeben.md).

### Den Modus beim ersten Aufruf wählen

Der Modus gilt für den ganzen Prozess, und er wird beim **ersten**
`fonts::init` festgelegt. Ein späteres `fonts::init -cid 1` ändert die
Schrift nicht mehr, auch nicht mit `-force 1`: Die Schrift ist bei
pdf4tcl schon unter ihrem Namen angemeldet und wird nicht neu
angemeldet. `fonts::isCidMode` meldet danach aber 1. In einem Versuch
kam so aus „αβγ“ im PDF „???“. Der Zähler von pdf4tcllib blieb 0, auf
stderr stand nichts; nur `$pdf getSubstCount` zählte die drei Zeichen.

Darum gehört `fonts::init` mit allen Optionen an eine Stelle am
Programmanfang, bevor eine Bibliothek es mit anderen Optionen aufruft.

---

## Zusammenfassung

- `package require pdf4tcl` und `package require pdf4tcllib`, dann
  einmal `pdf4tcllib::fonts::init`, mit `-cid 1` für deutsche Texte.
- Die Schrift muss als `<familie>.ttf` und `<familie>-Bold.ttf` in einem
  der Suchordner liegen; unter Debian `fonts-dejavu-extra` installieren
  oder `-family DejaVuSans` angeben.
- `fonts::hasTtf` prüfen, wenn TrueType Pflicht ist.
- Schriftnamen nur über `fonts::fontSans` und die anderen
  Zugriffsprozeduren.
- Tcl 8.6 braucht für Umlaute im Skript eine UTF-8-Locale.

---

*Nächstes Kapitel: [Unicode sicher ausgeben](030-unicode-sicher-ausgeben.md)*
