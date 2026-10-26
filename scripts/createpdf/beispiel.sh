#!/bin/sh
# Example: the sample pages as PDF, English and with German labels.
# Set TCLLIBPATH and TCL8_6_TM_PATH (or TCL9_0_TM_PATH) first, see README.md.
cd "$(dirname "$0")" || exit 1
tclsh createpdf.tcl en-markdown/9.0 -o tcltk-9.0-sample.pdf \
    -title "Tcl/Tk 9.0" -subtitle "Reference manual pages (sample)" || exit 1
tclsh createpdf.tcl en-markdown/9.0 -lang de -o tcltk-9.0-sample-de-labels.pdf \
    -title "Tcl/Tk 9.0" -subtitle "Handbuchseiten (Beispiel)"
