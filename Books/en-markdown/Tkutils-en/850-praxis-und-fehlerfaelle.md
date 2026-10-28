# Practice: Tk Integration, Measures and Window State

## Load Tk First

`tkutils` complements Tk; it does not replace the Tk runtime. Graphical
examples need a display. On Linux a test run under Xvfb can be useful,
while a plain `tclsh` without a display creates no windows.

```tcl
package require Tk
package require tkutils::tkuunits

label .label -text "Maßeinheiten"
pack .label -padx 12 -pady 12
puts [::tkutils::tkuunits::toPixels 10 mm .]
```

`tkuunits-0.1.tm` exports `units`, `toPixels`, `fromPixels` and
`convert`. The conversion can use the window argument `w`, because the
physical screen resolution matters. A pixel value is therefore not the
same on all displays.

## Comparing Units

```tcl
package require Tk
package require tkutils::tkuunits

set pixels [::tkutils::tkuunits::toPixels 25.4 mm .]
set inches [::tkutils::tkuunits::convert 25.4 mm inch .]
puts "pixels=$pixels inches=$inches"
```

Do not write the return values as fixed pixel constants into
documentation or tests. A good test compares the consistency of two
conversions under the same display configuration.

## Window Geometry

`tkugeometry-0.1.tm` exports `save`, `restore`, `track` and `key`. The
first three commands expect, among other things, a window and an
application name. The implementation also contains logic for adapting
to the available screen area.

```tcl
package require Tk
package require tkutils::tkugeometry

set appId demo-window
wm title . "Fensterzustand"
# "." ergibt den Schlüssel main, ohne zu speichern.
set geometryKey [::tkutils::tkugeometry::key .]
puts $geometryKey
```

The example does not write anything persistent. Before using `save`,
`restore` and `track`, check storage location, options and behavior with
several monitors in particular.

## Troubleshooting Optional Widgets

A widget module may need additional packages, such as Tablelist, Img,
tDOM or scrollutil. Test such modules one by one instead of concluding
from a successful `package require tkutils` alone that all additional
functions are available.

```tcl
package require Tk
set code [catch {package require tkutils::tkutablelist} result options]
if {$code} {
    puts stderr "Tablelist integration unavailable: $result"
} else {
    puts "tkutablelist $result"
}
```

A missing optional package is not an error of the Tk runtime. The
application should then either print a clear diagnosis or disable the
affected function.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 and 9.0.4 on Linux under Xvfb: all
examples of this appendix. With `tk scaling` 1.39 the first example
prints `39.38461538461539`, the second `pixels=100.03692307692307
inches=1.0`, the third `main`.

**Not tested:** different window managers.
:::
