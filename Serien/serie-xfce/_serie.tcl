# Eigenes dieser Serie. Gestanztes steht in _bootstrap.tcl.

proc ::serie::requireXfce {} {
    if {$::tcl_platform(platform) ne "unix"} {
        ::serie::skip "serie-xfce braucht Unix/Linux"
    }
    set desk ""
    if {[info exists ::env(XDG_CURRENT_DESKTOP)]} {
        set desk $::env(XDG_CURRENT_DESKTOP)
    }
    if {![string match -nocase *XFCE* $desk]} {
        ::serie::skip "serie-xfce braucht XFCE (XDG_CURRENT_DESKTOP=$desk)"
    }
    if {[auto_execok xfconf-query] eq ""} {
        ::serie::skip "xfconf-query fehlt"
    }
    if {[catch {exec {*}[auto_execok xfconf-query] -c xfwm4 -p /general/workspace_count} err]} {
        ::serie::skip "xfconf/DBus nicht erreichbar"
    }
}

proc ::serie::xfconf {args} {
    set cmd [auto_execok xfconf-query]
    if {$cmd eq ""} {
        ::serie::skip "xfconf-query fehlt"
    }
    return [exec {*}$cmd {*}$args]
}

proc ::serie::done {title} {
    puts "OK: $title  (Tcl [info patchlevel], XFCE)"
    exit 0
}
