# Eigenes dieser Serie. Gestanztes steht in _bootstrap.tcl.

proc ::serie::requireLinux {} {
    if {$::tcl_platform(platform) ne "unix"} {
        ::serie::skip "serie-linux braucht Unix/Linux"
    }
    if {$::tcl_platform(os) ne "Linux"} {
        ::serie::skip "serie-linux braucht Linux (os=$::tcl_platform(os))"
    }
}

proc ::serie::xdgDir {which} {
    switch -- $which {
        config {
            if {[info exists ::env(XDG_CONFIG_HOME)] && $::env(XDG_CONFIG_HOME) ne ""} {
                return $::env(XDG_CONFIG_HOME)
            }
            return [file join $::env(HOME) .config]
        }
        data {
            if {[info exists ::env(XDG_DATA_HOME)] && $::env(XDG_DATA_HOME) ne ""} {
                return $::env(XDG_DATA_HOME)
            }
            return [file join $::env(HOME) .local share]
        }
        cache {
            if {[info exists ::env(XDG_CACHE_HOME)] && $::env(XDG_CACHE_HOME) ne ""} {
                return $::env(XDG_CACHE_HOME)
            }
            return [file join $::env(HOME) .cache]
        }
        default {
            error "xdgDir: config|data|cache erwartet"
        }
    }
}

proc ::serie::configDir {appName} {
    set dir [file join [serie::xdgDir config] $appName]
    if {![file exists $dir]} {
        file mkdir $dir
    }
    return $dir
}

proc ::serie::parseOsRelease {} {
    set path /etc/os-release
    if {![file exists $path]} {
        return {}
    }
    set fh [open $path r]
    set raw [read $fh]
    close $fh
    set d {}
    foreach line [split $raw \n] {
        if {[regexp {^([A-Z_]+)=(.*)$} $line -> k v]} {
            set v [string trim $v "\""]
            dict set d $k $v
        }
    }
    return $d
}

proc ::serie::done {title} {
    puts "OK: $title  (Tcl [info patchlevel], $::tcl_platform(os))"
    exit 0
}
