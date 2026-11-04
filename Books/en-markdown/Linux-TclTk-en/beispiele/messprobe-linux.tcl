# messprobe-linux.tcl -- Messwerte für "Tcl/Tk unter Linux"
#
# Start:
#   tclsh8.6 messprobe-linux.tcl            ;# nur Tcl-Teil
#   wish8.6  messprobe-linux.tcl            ;# Tcl- und Tk-Teil, endet selbst
#   /opt/tcl9/bin/wish9.0 messprobe-linux.tcl
#   wish9.0  messprobe-linux.tcl -keys      ;# danach Fenster für Tasten und Mausrad
#
# Für die Standard-Suchpfade mit sauberer Umgebung starten:
#   env -i HOME=$HOME PATH=/usr/bin:/bin DISPLAY=$DISPLAY wish8.6 messprobe-linux.tcl
#
# Jede Abfrage läuft für sich. Fehlt ein Werkzeug, steht "-" oder die
# Fehlermeldung in der Zeile, die Probe läuft weiter.

set ::keys [expr {"-keys" in $argv}]

proc zeile {name wert} {
    puts [format "  %-22s %s" $name $wert]
}
proc versuch {name script} {
    if {[catch {uplevel 1 $script} r]} {
        set r "FEHLER: $r"
    }
    zeile $name $r
}
proc envwert {n} {
    if {[info exists ::env($n)]} { return $::env($n) }
    return "-"
}

# ---------------------------------------------------------------- Plattform
puts "== Plattform"
foreach k {platform os osVersion machine byteOrder pointerSize wordSize threaded} {
    if {[info exists ::tcl_platform($k)]} {
        zeile $k $::tcl_platform($k)
    } else {
        zeile $k "(Schlüssel fehlt)"
    }
}
versuch "uname -m" {exec uname -m}
if {[file readable /etc/os-release]} {
    set f [open /etc/os-release]
    foreach l [split [read $f] \n] {
        if {[regexp {^(PRETTY_NAME|ID|ID_LIKE|VERSION_ID|VERSION_CODENAME)=(.*)$} $l -> k v]} {
            zeile "os-release $k" [string trim $v \"]
        }
    }
    close $f
}
if {[file readable /etc/debian_version]} {
    versuch "debian_version" {string trim [read [set f [open /etc/debian_version]]][close $f]}
}

# ---------------------------------------------------------------- Interpreter
puts "== Interpreter"
zeile patchlevel [info patchlevel]
zeile nameofexecutable [info nameofexecutable]
versuch "readlink -f" {exec readlink -f [info nameofexecutable]}
zeile tcl_library $::tcl_library
versuch tcl_pkgPath {set ::tcl_pkgPath}
zeile sharedlibext [info sharedlibextension]
versuch "zipfs mount" {
    if {[info commands ::tcl::zipfs::mount] eq ""} {
        set _ "(kein zipfs)"
    } else {
        set _ [::tcl::zipfs::mount]
    }
}
puts "  auto_path:"
foreach p $::auto_path { puts "    $p" }
puts "  tcl::tm::path list:"
foreach p [tcl::tm::path list] { puts "    $p" }
foreach v {TCLLIBPATH TCL_LIBRARY TK_LIBRARY TCL8_6_TM_PATH TCL9_0_TM_PATH} {
    zeile "env $v" [envwert $v]
}

# ---------------------------------------------------------------- Locale
puts "== Locale und Kodierung"
foreach v {LANG LC_ALL LC_CTYPE LANGUAGE} { zeile "env $v" [envwert $v] }
zeile "encoding system" [encoding system]
versuch "fconfigure stdout" {fconfigure stdout -encoding}
versuch "msgcat mclocale" {package require msgcat; msgcat::mclocale}
versuch "file home" {file home}
versuch "file tildeexpand ~" {file tildeexpand ~}
versuch "file exists ~" {file exists ~}
versuch "file normalize ~" {file normalize ~}
versuch "file volumes" {file volumes}
versuch "file tempdir" {set d [file tempdir]; file delete $d; set d}
versuch "Rechte /tmp" {file attributes /tmp -permissions}
versuch "info hostname" {info hostname}
zeile "tcl_platform(user)" $::tcl_platform(user)
zeile "env USER" [envwert USER]
foreach v {HOME XDG_CONFIG_HOME XDG_DATA_HOME XDG_CACHE_HOME XDG_STATE_HOME
           XDG_RUNTIME_DIR TMPDIR} {
    zeile "env $v" [envwert $v]
}
versuch "xdg-user-dir DOCUMENTS" {exec xdg-user-dir DOCUMENTS}

# ---------------------------------------------------------------- Prozesse
puts "== Prozesse"
versuch "auto_execok sh" {auto_execok sh}
versuch "auto_execok xdg-open" {auto_execok xdg-open}
versuch "auto_execok lpstat" {auto_execok lpstat}
versuch "exec gibtsnicht" {exec gibtsnicht}
versuch "errorCode" {set ::errorCode}
versuch "exec false" {exec false}
versuch "errorCode" {set ::errorCode}
versuch "exec stderr" {exec sh -c {echo meldung >&2}}
versuch "errorCode" {set ::errorCode}
versuch "exec -ignorestderr" {exec -ignorestderr sh -c {echo meldung >&2; echo ok}}
versuch "exec kill TERM" {exec sh -c {kill -TERM $$}}
versuch "errorCode" {set ::errorCode}
versuch "exec Umlaut" {exec printf %s "Grüße"}
versuch "pid" {pid}

# ---------------------------------------------------------------- Tk
if {[catch {package require Tk} tkerr]} {
    puts "== Tk"
    zeile "package require Tk" "FEHLER: $tkerr"
    exit 0
}
wm withdraw .

puts "== Tk"
zeile Tk [package provide Tk]
zeile windowingsystem [tk windowingsystem]
zeile tk_library $::tk_library
foreach v {DISPLAY WAYLAND_DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP} {
    zeile "env $v" [envwert $v]
}
versuch "winfo server" {winfo server .}
zeile "Bildschirm" "[winfo screenwidth .]x[winfo screenheight .] px, [winfo screenmmwidth .]x[winfo screenmmheight .] mm, Tiefe [winfo screendepth .]"
zeile "visual" [winfo visual .]
zeile "tk scaling" [tk scaling]
zeile "winfo fpixels 1i" [winfo fpixels . 1i]
versuch "tk::scalingPct" {set ::tk::scalingPct}
versuch "fontScalingFactor" {set ::tk::fontScalingFactor}
versuch "tk Unterbefehle" {
    catch {tk gibtsnicht} m
    set m
}
versuch "Mausrad Text" {
    lmap b [bind Text] {
        if {![string match *Button-4* $b] && ![string match *Button-5* $b]
            && ![string match *MouseWheel* $b] && ![string match *Shift-Button-4* $b]} continue
        set b
    }
}
versuch "Mausrad all" {
    lmap b [bind all] {
        if {![string match *Button-* $b] && ![string match *MouseWheel* $b]} continue
        set b
    }
}

puts "== Schriften"
foreach f {TkDefaultFont TkTextFont TkFixedFont TkMenuFont TkHeadingFont
           TkCaptionFont TkSmallCaptionFont TkIconFont TkTooltipFont} {
    versuch $f {font actual $f}
}
zeile "Familien" [llength [font families]]
versuch "fontsystem" {tk::pkgconfig get fontsystem}
versuch "Xft.dpi" {
    if {[catch {exec xrdb -query} r]} {set _ "-"} else {
        set _ [expr {[regexp -line {^Xft\.dpi:\s*(\S+)} $r -> d] ? $d : "-"}]
    }
}
versuch "Helvetica" {font actual {Helvetica 10}}
versuch "GibtsNicht" {font actual {GibtsNicht 10}}
versuch "fc-match sans" {exec fc-match sans-serif}
versuch "fc-match mono" {exec fc-match monospace}

puts "== ttk und Optionen"
zeile "themes" [ttk::style theme names]
versuch "theme in use" {ttk::style theme use}
zeile "background ." [. cget -background]
versuch "button bg" {button .b; set _ [.b cget -background]; destroy .b; set _}
versuch "TButton -padding" {ttk::style lookup TButton -padding}
versuch "option get" {option get . background Background}
versuch "RESOURCE_MANAGER" {exec xrdb -query}

puts "== Fenster"
toplevel .w
wm geometry .w 300x200+50+60
update
zeile "wm attributes" [wm attributes .w]
versuch "wm iconphoto" {
    image create photo ikon -width 16 -height 16
    ikon put red -to 0 0 16 16
    wm iconphoto .w -default ikon
    set _ ok
}
versuch "wm class ." {winfo class .}
versuch "tk appname" {tk appname}
versuch "wm geometry .w" {wm geometry .w}
versuch "winfo rootx/y" {list [winfo rootx .w] [winfo rooty .w]}
versuch "wm frame .w" {wm frame .w}
versuch "wm state .w" {wm state .w}
versuch "wm attr -fullscreen" {wm attributes .w -fullscreen}
versuch "wm attr -type" {wm attributes .w -type}
versuch "tk_getOpenFile" {
    if {[info commands ::tk_getOpenFile] eq ""} {auto_load tk_getOpenFile}
    string trim [info body ::tk_getOpenFile]
}
versuch "systray Befehl" {
    if {[catch {tk systray exists} r]} {set _ "nicht vorhanden: $r"} else {set _ "exists=$r"}
}
versuch "systray create" {
    tk systray create -image ikon -text Probe
    set _ "angelegt, exists=[tk systray exists]"
}
versuch "sysnotify C-Teil" {
    if {[package vsatisfies [package provide Tk] 9-]} {
        expr {[info commands ::tk::sysnotify::_sysnotify] ne "" ? "libnotify geladen" : "kein libnotify, Tk-Fenster"}
    } else {
        set _ "(erst ab Tk 9)"
    }
}
versuch "tk print Befehl" {
    if {[catch {tk print} r]} {set r}
}
versuch "tk::print::cups" {
    if {[info commands ::tk::print::_print] eq ""} {
        catch {auto_load ::tk::print::_print}
    }
    if {[namespace ensemble exists ::tk::print::cups]} {
        set _ "Tcl-Ensemble (lpstat/lpr)"
    } elseif {[info commands ::tk::print::cups] ne ""} {
        set _ "C-Befehl (libcups)"
    } else {
        set _ "fehlt"
    }
}
versuch "cups getprinters" {::tk::print::cups getprinters}

puts "== Zwischenablage"
versuch "event info <<Copy>>" {event info <<Copy>>}
versuch "event info <<Paste>>" {event info <<Paste>>}
versuch "<<PasteSelection>>" {event info <<PasteSelection>>}
versuch "clipboard eigen" {
    clipboard clear; clipboard append "Probe-Ä"; clipboard get
}
versuch "PRIMARY leer" {selection get -selection PRIMARY}
versuch "CLIPBOARD via xclip" {
    set ch [open "|xclip -o -selection clipboard"]
    fconfigure $ch -blocking 0 -encoding utf-8
    set ::xc ""
    fileevent $ch readable [list apply {{ch} {
        append ::xc [read $ch]
        if {[eof $ch]} { fconfigure $ch -blocking 1; catch {close $ch}; set ::xcdone 1 }
    }} $ch]
    after 3000 {set ::xcdone timeout}
    vwait ::xcdone
    if {$::xcdone eq "timeout"} {set _ timeout} {set ::xc}
}

if {!$::keys} {
    puts "== Ende (ohne -keys)"
    exit 0
}

# ---------------------------------------------------------------- Tasten
puts "== Tasten und Mausrad: Fenster bedienen, Escape beendet"
destroy .w
wm deiconify .
wm title . "Messprobe Linux"
label .l -text "Tasten drücken, Mausrad drehen,\nShift+Mausrad, Rechtsklick\nEscape beendet" \
    -padx 40 -pady 40
pack .l -fill both -expand 1
focus -force .l
proc taste {K k s A} {
    puts [format "  Key       %-14s keycode=%-4s state=%-6s char=%s" $K $k $s [list $A]]
}
bind .l <KeyPress> {taste %K %k %s %A}
bind .l <ButtonPress> {puts "  Button-%b  state=%s"}
bind .l <MouseWheel> {puts "  MouseWheel D=%D state=%s"}
bind .l <Shift-MouseWheel> {puts "  Shift-MouseWheel D=%D state=%s"}
bind .l <Button-4> {puts "  Button-4  state=%s"}
bind .l <Button-5> {puts "  Button-5  state=%s"}
bind .l <Escape> {exit 0}
