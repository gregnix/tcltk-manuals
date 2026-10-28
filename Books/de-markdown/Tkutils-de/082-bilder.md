# Bilder

Laden, skalieren und in eine Datei schreiben. `tkuimage`, `tkuwinico`
und `tkudhash` liegen im Umbrella. `tkuicon` und `tkucanvaspng` kommen
einzeln: `tkuicon` braucht für SVG eine Erweiterung, `tkucanvaspng` die
Engine `tclutils::tupngdraw`.

---

## Ansehen: tkuimage

[tkuimage]{.index} 0.2 liefert Hilfen und einen Viewer mit Scrollen und
Zoom. Skalieren nimmt `imgtools`, wenn es geladen ist, sonst
`subsample` und `zoom` des Tk-Photo. `imgtools` ist optional.

```tcl
::tkutils::tkuimage::fit      bildB bildH kastenB kastenH ?contain|cover|none?
::tkutils::tkuimage::load     datei ?ziel?
::tkutils::tkuimage::fromData bytes ?ziel?
::tkutils::tkuimage::scale    quelle b h ?ziel?
::tkutils::tkuimage::thumbnail quelle max ?ziel?
```

`fit` liefert `{neueB neueH maßstab}`. `load` und `fromData` kennen
PNG und GIF aus Tk selbst. `contain` passt das Bild in den Kasten,
`cover` füllt ihn.

```tcl
set v [::tkutils::tkuimage::view .v ?-fitmode contain? ?-onchange befehl?]
::tkutils::tkuimage::openFile  .v datei.png
::tkutils::tkuimage::zoomIn    .v
::tkutils::tkuimage::zoomOut   .v
::tkutils::tkuimage::zoom1     .v
::tkutils::tkuimage::fitView   .v
::tkutils::tkuimage::getImage  .v
::tkutils::tkuimage::zoomLevel .v
```

`zoomLevel` ist `1.0` bei 100 Prozent. `getImage` ist das Photo in
Originalgröße.

---

## Symbole: tkuicon

[tkuicon]{.index} 0.1 lädt SVG und PNG und erzeugt einen festen Satz
aus `tclutils::tusvg`. Ergebnisse bleiben im Cache. SVG unter Tk 8.6
braucht `tksvg`. Tk 9 zeichnet SVG selbst. Ohne SVG laden Dateien
weiterhin PNG und GIF. `create` wirft dann
`{TKUTILS TKUICON NOSVG}`.

```tcl
::tkutils::tkuicon::hassvg
::tkutils::tkuicon::available
::tkutils::tkuicon::create name größe ?-color farbe? ?-strokeWidth n? ?-name bild?
::tkutils::tkuicon::load   datei ?-height h? ?-width b? ?-name bild?
::tkutils::tkuicon::rescale bildname neueHöhe
::tkutils::tkuicon::loadToolbarSet größe ?-color farbe? ?-icons {namen ...}?
::tkutils::tkuicon::clearCache
```

`create` liefert den Namen des Photo. `loadToolbarSet` liefert ein
Dict. `rescale` heißt so, weil `scale` ein Tk-Befehl ist. Mit SVG
zeichnet es neu, sonst skaliert es das vorhandene Bild. Die Leiste,
die das Photo als `-icon` nimmt, steht im Kapitel
[Gerüst](072-geruest.md).

---

## Zeichenfläche als PNG: tkucanvaspng

[tkucanvaspng]{.index} 0.2 schreibt eine Tk-Zeichenfläche über
`tclutils::tupngdraw`. Echte Schrift braucht Glyphs und `-fontmap`.

```tcl
set png [::tkutils::tkucanvaspng::render $canvas \
    ?-region {x1 y1 x2 y2}? ?-scale n? ?-background farbe? \
    ?-textcmd befehl? ?-fontmap dict?]
::tkutils::tkucanvaspng::write aus.png $canvas ?dieselben Optionen?
```

Die Vorgabe für `-region` ist `[$canvas bbox all]`. Eine leere Fläche
wirft `{TKUTILS TKCANVASPNG EMPTY}` mit `canvas is empty`. Ein Fenster,
das es nicht gibt, wirft `{TKUTILS TKCANVASPNG WINDOW}` mit
`not a canvas window: .nix`. Ein vorhandenes Widget, das keine
Zeichenfläche ist, prüft das Modul nicht; es scheitert mit dem Tk-Fehler
`bad command "bbox"`. Eine unbekannte Option meldet
`{TCLUTILS COMMON OPTION <opt>}`. `-scale` ist eine positive ganze Zahl.
`-background` ist der Hintergrund der Fläche, sonst weiß. `write`
liefert den Dateinamen.

---

## Windows-Symbol: tkuwinico

[tkuwinico]{.index} 0.1 lässt Tk die einzelnen Größen zeichnen und gibt
die PNG-Daten an `tclutils::tuico`. Die Transparenz bleibt, weil die
Nutzlast PNG ist.

```tcl
::tkutils::tkuwinico::fromSvg    logo.svg app.ico
::tkutils::tkuwinico::fromPhoto  $photo app.ico ?-sizes {32 16}?
::tkutils::tkuwinico::fromPhotos {{32 $groß} {16 $klein}} app.ico
```

`fromSvg` zeichnet jede Größe aus der Vorlage. `fromPhoto` skaliert
ganzzahlig. `fromPhotos` nimmt je Größe ein fertiges Bild und skaliert
hier nichts. SVG-Ausgabe braucht dieselbe SVG-Unterstützung wie
`tkuicon`.

---

## Ähnlichkeit: tkudhash

[tkudhash]{.index} 0.1 lädt eine Bilddatei als Photo und gibt die Pixel
an `tclutils::tudhash`. PNG, GIF und PPM gehen mit Tk allein. JPEG und
TIFF brauchen das Paket `Img`.

```tcl
::tkutils::tkudhash::fromFile     pfad ?-sample n?
::tkutils::tkudhash::similarFiles pfadA pfadB ?abstand?
::tkutils::tkudhash::distance     a b
::tkutils::tkudhash::similar      a b ?abstand?
```

`fromFile` liefert 16 Hexzeichen, den 64-Bit-Hash. `-sample` ist die
Kantenlänge der Probe. `distance` und `similar` kommen von `tudhash`.
`distance` liegt zwischen 0 und 64. `similarFiles` und `similar` nehmen
als Vorgabe den Abstand 10.

---

## Merkliste

- `tkuimage::fit` liefert Breite, Höhe und Maßstab. `imgtools` ist optional.
- `tkuicon` und `tkuwinico` brauchen für SVG `tksvg` oder Tk 9.
- `tkucanvaspng` schreibt PNG über `tupngdraw`. Eine leere Fläche wirft `EMPTY`.
- `tkudhash` rechnet nicht selbst. Den Hash liefert `tudhash`.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 und 9.0.4 unter Linux und Xvfb: Laden der
Module, `tkuimage::fit`, die Fehler von `tkucanvaspng` und `tkuicon`.
Unter 8.6.14 ohne tksvg liefert `tkuicon::hassvg` `0` und `create` den
Fehler `NOSVG`; unter 9.0.4 liefert `hassvg` `1`.
:::

---

*Nächstes Kapitel: [tkdevtools](085-tkdevtools.md)*
