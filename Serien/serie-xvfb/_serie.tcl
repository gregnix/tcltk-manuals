# Eigenes dieser Serie. Gestanztes steht in _bootstrap.tcl.

package require Tk
package require Ttk

set ::serie::shellGeo 520x260
# DISPLAY gibt es nur unter X11; [winfo screen .] gibt es überall.
set ::serie::statusDefault "xvfb  Tk $::tk_patchLevel  Screen [winfo screen .]"

# Die Howtos dieser Serie messen X11-Verhalten.
proc ::serie::brauchtX11 {} {
    if {[tk windowingsystem] ne "x11"} {
        ::serie::skip "kein X11 ([tk windowingsystem])"
    }
}

# Ein Tk-Skript auf einem EIGENEN, frischen Xvfb ausführen (xvfb-run -a)
# und seine Ausgabe liefern. Ohne xvfb-run: SKIP. Das Skript endet
# selbst mit exit.
proc ::serie::aufEigenemXvfb {skript {serverArgs {-screen 0 800x600x24}}} {
    ::serie::brauchtX11
    set run [auto_execok xvfb-run]
    if {$run eq ""} { ::serie::skip "xvfb-run fehlt" }
    set f [::serie::out xvfb-probe-[pid].tcl]
    set ch [open $f w]
    puts $ch "package require Tk"
    puts $ch $skript
    close $ch
    set rc [catch {exec {*}$run -a -s $serverArgs \
            [info nameofexecutable] $f </dev/null 2>@1} out]
    file delete $f
    if {$rc} { error "xvfb-run: $out" }
    return $out
}
