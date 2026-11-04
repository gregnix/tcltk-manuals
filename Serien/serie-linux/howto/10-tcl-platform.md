# 10 — tcl_platform

```tcl
$tcl_platform(platform)    ;# unix
$tcl_platform(os)          ;# Linux
$tcl_platform(osVersion)   ;# Kernel, z.B. 7.1.9+deb14-amd64
$tcl_platform(machine)     ;# x86_64
$tcl_platform(user)        ;# effective uid
$tcl_platform(wordSize)    ;# 8
```

`osVersion` ist der Kernel, nicht die Debian-Version (`/etc/os-release`).

## Demo

```bash
tclsh howto/10-tcl-platform.tcl
```
