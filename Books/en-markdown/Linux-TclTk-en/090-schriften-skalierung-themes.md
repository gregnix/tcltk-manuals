# Fonts, scaling, themes

## Introduction

Under X11, Tk draws text with [Xft]{.index} and looks up fonts via
fontconfig. The size of the user interface depends on `tk scaling`,
and that depends on the resolution the X server reports. Colors and
themes come from Tk itself and from the X resource database, not from
the desktop settings. This chapter shows where each value comes from
and what Tk 9 has changed about scaling.

---

## Fonts: Xft and fontconfig

Whether Tk is built with Xft is reported by
`tk::pkgconfig get fontsystem`. In the container it returns `xft`
under 8.6.14 and 9.0.4. Tk then sets the named fonts to the fontconfig
names `sans-serif` and `monospace` (source `ttk/fonts.tcl`). Which
family is behind them is decided by fontconfig on the machine the
program runs on:

```bash
fc-match sans-serif     # Container: Inter-Regular.otf: "Inter" "Regular"
fc-match monospace      # Container: DejaVuSansMono.ttf: "DejaVu Sans Mono" "Book"
```

Container check, both versions identical:

| Name | Family | Size |
|------|---------|-------|
| `TkDefaultFont`, `TkTextFont`, `TkMenuFont`, `TkIconFont` | Inter | 10 |
| `TkHeadingFont` | Inter, bold | 10 |
| `TkCaptionFont` | Inter, bold | 12 |
| `TkTooltipFont`, `TkSmallCaptionFont` | Inter | 9 |
| `TkFixedFont` | DejaVu Sans Mono | 10 |

`serie-xvfb` (howto 01) also reports `TkDefaultFont` `Inter 10`.
On a machine without Inter, fontconfig returns a different family,
usually DejaVu Sans. The text must not assume it.

The sizes are **points**, not pixels. A requested name that does not
exist does not lead to an error: `font actual {GibtsNicht 10}`
returns `Inter` in the container. `Helvetica` becomes
`TeX Gyre Heros`, because fontconfig knows a substitute for it. To
check whether a family is really there, ask `font families`:

```tcl
if {"Noto Sans" in [font families]} {
    font configure TkDefaultFont -family "Noto Sans"
}
```

The fonts come from the **client**, not from the X server. A program
that runs on another machine via `ssh -X` draws with the fonts of the
remote machine. The same applies to Xvfb: the virtual server has no
fonts of its own in the Xft sense.

---

## tk scaling and DPI

[`tk scaling`]{.index} is the number of pixels per point. Tk computes
it at startup from the screen size in pixels and millimeters:
pixels ÷ (mm ÷ 25.4) ÷ 72. At 100 dpi that is 1.389. All sizes in
points, including the fonts, grow with this value.

`serie-xvfb` (howto 01, Tcl/Tk 8.6.14 and 9.0.4) measures this with
different `-dpi` values of Xvfb:

| Xvfb | `tk scaling` |
|------|--------------|
| 1280x1024, without `-dpi` | 1.389 (≈ 100 dpi) |
| `-dpi 50` | 0.695 |
| `-dpi 200` | 2.770 |

Container check with a label "Hallo Welt" in `TkDefaultFont` and a
`ttk::scrollbar`:

| Xvfb | Version | `tk scaling` | `::tk::scalingPct` | Line height | Text width | Scrollbar |
|------|---------|--------------|--------------------|------------|------------|-----------|
| 100 dpi | 8.6.14 | 1.389 | missing | 18 | 69 | 15 |
| 100 dpi | 9.0.4 | 1.389 | 100 | 18 | 69 | 15 |
| 192 dpi | 8.6.14 | 2.667 | missing | 33 | 131 | 15 |
| 192 dpi | 9.0.4 | 2.667 | 200 | 33 | 131 | 27 |

The font grows in both versions. The scrollbar grows only under
Tk 9: Tk 9 computes many dimensions in ttk and in the standard dialogs
via [`::tk::scalingPct`]{.index}, the resolution as a percentage of
96 dpi, rounded to 25 and at least 100. Under 8.6, pixel dimensions
such as scrollbar width and checkbox stay fixed.

### Where Tk 9 gets the scaling from

A desktop usually does not set the magnification via the DPI of the
X server, but via its own settings. Tk 9 reads some of them at
startup (source `library/scaling.tcl`, 9.0.4), in this order:

1. If `xfce4-session` is running: `xfconf-query -c xsettings -p
   /Gdk/WindowScalingFactor`. From factor 2 on, 200 % applies, and
   the font sizes are doubled (`::tk::fontScalingFactor` 2).
2. If `mate-session` is running: `gsettings` for MATE.
3. If `gnome-session` is running: the key `Gdk/WindowScalingFactor`
   in the xsettings overrides.
4. Otherwise the X resource [`Xft.dpi`]{.index}, read with
   `xrdb -query`: percent = `Xft.dpi` ÷ 96 × 100.
5. Under GNOME without Wayland, finally `~/.config/monitors.xml`.

If the value found differs from the measured one, Tk 9 sets
`tk scaling` anew. Container check: Xvfb with 100 dpi, plus
`Xft.dpi: 192` via `xrdb -merge`:

| Version | `tk scaling` | `scalingPct` | `font actual … -size` | Line height | Scrollbar |
|---------|--------------|--------------|------------------------|------------|-----------|
| 8.6.14 | 1.389 | missing | 19 | 33 | 15 |
| 9.0.4 | 2.672 | 200 | 10 | 33 | 27 |

Under 8.6, Xft enlarges the font itself, because fontconfig knows
`Xft.dpi`. Tk knows nothing about it: `tk scaling` stays 1.389, and
`font actual` reports the back-calculated size 19 instead of 10.
Pixel dimensions stay small. Under 9.0, font, computed value and
dimensions agree.

To set the scaling yourself, set it before building the user
interface:

```tcl
tk scaling 2.0     ;# 144 dpi; before the first widget
```

Under Tk 9, `tk scaling` immediately updates `::tk::scalingPct` as
well: `tk scaling 2.0` gives 150 (factor × 75, rounded to 25; source
`tkCmds.c`). How much a standard dialog grows depends on the font.
`tk_messageBox` before and after `tk scaling 2.0`:

| Environment | Version | `scalingPct` | Dialog | Line height `TkDefaultFont` |
|---|---|---|---|---|
| Container, Xvfb 100 dpi | 8.6.14 | missing | 117×95 → 162×114 | 18 → 25 |
| Container, Xvfb 100 dpi | 9.0.4 | 100 → 150 | 117×95 → 164×116 | 18 → 25 |
| Workstation, Xfce | 8.6.18 | missing | 110×96 → 110×96 | 34 → 34 |
| Workstation, Xfce | 9.0.4 | 100 → 150 | 110×96 → 110×100 | 34 → 34 |
| Workstation, Xfce | 9.1.0 | 100 → 150 | 112×96 → 128×119 | 31 → 31 |

In the container the font grows, and the dialog with it. On the
workstation the font stays the same; what grows there is computed by
Tk via `scalingPct`: barely under 9.0, clearly under 9.1.

---

## Themes

Under X11, Tk ships four ttk themes. Container check, both versions:
`ttk::style theme names` returns `clam alt default classic`, the
active one is `default`. There is no native Linux theme like `aqua`
or `vista`. Tk does not adopt the look of GTK or Qt programs. There
are add-on packages for that (such as `ttk::theme::*` collections);
they are not part of this book.

The background of classic widgets is `#d9d9d9`. `TButton -padding`
reports `3 3` under 8.6 and `2.25p` under 9.0: Tk 9 computes spacing
in points so that it grows with `tk scaling`.

---

## X resources

Under X11, Tk reads the [resource database]{.index} of the X server at
startup, the property `RESOURCE_MANAGER` on the root window, which
`xrdb` sets. If it is missing, Tk reads `~/.Xdefaults`. Container
check, 8.6.14 and 9.0.4 identical:

```text
*background:  lightyellow     -> option get . background Background: lightyellow
                                 button -background: lightyellow
*Label.font:  {DejaVu Sans} 14 -> label -font: {DejaVu Sans} 14
*TkTheme:     clam            -> ttk::style theme use: clam
```

So `*TkTheme` selects the ttk theme without a single line of code.
The file `~/.Xdefaults` with `*background: pink` took effect in the
container as long as no resources were loaded. With `XENVIRONMENT`
set to a file, nothing changed.

This has two sides. A user can adjust color, font and theme of a Tk
program this way. A program that looks strange on someone else's
machine may find a `~/.Xdefaults` from old times there.
`xrdb -query` shows what is loaded.

A program loads its own defaults with low priority so that the user
can override them:

```tcl
option add *Entry.background white widgetDefault
option readfile [file join $hier app.Xdefaults] startupFile
```

A peculiarity of Xvfb: without `-noreset`, the server resets its
state as soon as the last client closes the connection. Resources
that an `xrdb` loaded beforehand are then gone before the Tk program
starts. In the container, `xrdb -query` stayed empty for this reason
until Xvfb ran with `-noreset`. For tests with resources, `-noreset`
belongs in the Xvfb options, see
[GUI tests with Xvfb](130-gui-tests-xvfb.md).

---

## Summary

- Xft and fontconfig: `sans-serif` and `monospace`, family from the
  machine the program runs on. Sizes in points.
- `tk scaling` from pixels and millimeters. Tk 9 additionally reads
  Xfce, MATE and GNOME settings and `Xft.dpi`, and also scales pixel
  dimensions.
- Under 8.6, `Xft.dpi` only enlarges the font.
- Themes: `clam alt default classic`, default `default`.
- X resources take effect: `*background`, `*TkTheme`. If
  `RESOURCE_MANAGER` is missing, `~/.Xdefaults` applies.

---

*Next chapter: [Mouse, keyboard, clipboard](100-maus-tastatur-zwischenablage.md)*
