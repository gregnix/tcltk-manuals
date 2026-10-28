# Images

Loading, scaling and writing to a file. `tkuimage`, `tkuwinico` and
`tkudhash` are in the umbrella. `tkuicon` and `tkucanvaspng` come
separately: `tkuicon` needs an extension for SVG, `tkucanvaspng` the
engine `tclutils::tupngdraw`.

---

## Viewing: tkuimage

[tkuimage]{.index} 0.2 provides helpers and a viewer with scrolling and
zoom. Scaling uses `imgtools` when it is loaded, otherwise `subsample`
and `zoom` of the Tk photo. `imgtools` is optional.

```tcl
::tkutils::tkuimage::fit      bildB bildH kastenB kastenH ?contain|cover|none?
::tkutils::tkuimage::load     datei ?ziel?
::tkutils::tkuimage::fromData bytes ?ziel?
::tkutils::tkuimage::scale    quelle b h ?ziel?
::tkutils::tkuimage::thumbnail quelle max ?ziel?
```

`fit` returns `{newW newH scale}`. `load` and `fromData` know PNG and
GIF from Tk itself. `contain` fits the image into the box, `cover`
fills it.

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

`zoomLevel` is `1.0` at 100 percent. `getImage` is the photo at its
original size.

---

## Icons: tkuicon

[tkuicon]{.index} 0.1 loads SVG and PNG and creates a fixed set from
`tclutils::tusvg`. Results stay in the cache. SVG under Tk 8.6 needs
`tksvg`. Tk 9 draws SVG itself. Without SVG, files still load PNG and
GIF. `create` then raises `{TKUTILS TKUICON NOSVG}`.

```tcl
::tkutils::tkuicon::hassvg
::tkutils::tkuicon::available
::tkutils::tkuicon::create name größe ?-color farbe? ?-strokeWidth n? ?-name bild?
::tkutils::tkuicon::load   datei ?-height h? ?-width b? ?-name bild?
::tkutils::tkuicon::rescale bildname neueHöhe
::tkutils::tkuicon::loadToolbarSet größe ?-color farbe? ?-icons {namen ...}?
::tkutils::tkuicon::clearCache
```

`create` returns the name of the photo. `loadToolbarSet` returns a dict.
`rescale` is named so because `scale` is a Tk command. With SVG it
redraws, otherwise it scales the existing image. The toolbar that takes
the photo as `-icon` is in the chapter [Scaffolding](072-geruest.md).

---

## Canvas as PNG: tkucanvaspng

[tkucanvaspng]{.index} 0.2 writes a Tk canvas through
`tclutils::tupngdraw`. Real text needs glyphs and `-fontmap`.

```tcl
set png [::tkutils::tkucanvaspng::render $canvas \
    ?-region {x1 y1 x2 y2}? ?-scale n? ?-background farbe? \
    ?-textcmd befehl? ?-fontmap dict?]
::tkutils::tkucanvaspng::write aus.png $canvas ?dieselben Optionen?
```

The default for `-region` is `[$canvas bbox all]`. An empty canvas
raises `{TKUTILS TKCANVASPNG EMPTY}` with `canvas is empty`. A window
that does not exist raises `{TKUTILS TKCANVASPNG WINDOW}` with
`not a canvas window: .nix`. An existing widget that is not a canvas is
not checked by the module; it fails with the Tk error
`bad command "bbox"`. An unknown option reports
`{TCLUTILS COMMON OPTION <opt>}`. `-scale` is a positive integer.
`-background` is the background of the canvas, otherwise white. `write`
returns the file name.

---

## Windows Icon: tkuwinico

[tkuwinico]{.index} 0.1 lets Tk draw the individual sizes and hands the
PNG data to `tclutils::tuico`. Transparency is kept because the payload
is PNG.

```tcl
::tkutils::tkuwinico::fromSvg    logo.svg app.ico
::tkutils::tkuwinico::fromPhoto  $photo app.ico ?-sizes {32 16}?
::tkutils::tkuwinico::fromPhotos {{32 $groß} {16 $klein}} app.ico
```

`fromSvg` draws every size from the source. `fromPhoto` scales by
integer factors. `fromPhotos` takes a finished image per size and does
not scale. SVG output needs the same SVG support as `tkuicon`.

---

## Similarity: tkudhash

[tkudhash]{.index} 0.1 loads an image file as a photo and hands the
pixels to `tclutils::tudhash`. PNG, GIF and PPM work with Tk alone. JPEG
and TIFF need the package `Img`.

```tcl
::tkutils::tkudhash::fromFile     pfad ?-sample n?
::tkutils::tkudhash::similarFiles pfadA pfadB ?abstand?
::tkutils::tkudhash::distance     a b
::tkutils::tkudhash::similar      a b ?abstand?
```

`fromFile` returns 16 hex characters, the 64-bit hash. `-sample` is the
edge length of the sample. `distance` and `similar` come from `tudhash`.
`distance` lies between 0 and 64. `similarFiles` and `similar` use a
default distance of 10.

---

## In short

- `tkuimage::fit` returns width, height and scale. `imgtools` is
  optional.
- `tkuicon` and `tkuwinico` need `tksvg` or Tk 9 for SVG.
- `tkucanvaspng` writes PNG through `tupngdraw`. An empty canvas raises
  `EMPTY`.
- `tkudhash` does not compute itself. The hash comes from `tudhash`.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 and 9.0.4 on Linux under Xvfb: loading the
modules, `tkuimage::fit`, the errors of `tkucanvaspng` and `tkuicon`.
Under 8.6.14 without tksvg, `tkuicon::hassvg` returns `0` and `create`
the error `NOSVG`; under 9.0.4, `hassvg` returns `1`.
:::

---

*Next chapter: [tkdevtools](085-tkdevtools.md)*
