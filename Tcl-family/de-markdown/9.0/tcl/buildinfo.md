---
CommandName: build-info
title: build-info
ManualSection: n
Version: 9.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - info(n)
Keywords:
 - build-info
Copyright:
 - Copyright (c) 2025 Jan Nijtmans.
---

# Name

buildinfo - Build-Informationen

# Übersicht

::: {.synopsis} :::
[::tcl::build-info]{.cmd} [field]{.optarg}
:::

# Beschreibung

Dieser Befehl liefert Informationen darüber, wie Tcl gebaut wurde. Ohne Argumente: Tcl-Patchlevel, dann „+“, dann die Fossil-Commit-ID, gefolgt von einer Liste punktgetrennter Tags. Ist *field* angegeben, wird das entsprechende Feld extrahiert (siehe unten). Jeder andere *field*-Wert, der unten nicht genannt ist, liefert „0“. Bei offiziellen Tcl-Releases gelten folgende *field*-Werte:

[::tcl::build-info]{.cmd} [clang]{.sub}
: Clang-Versionsnummer (4 Ziffern), wenn Tcl mit Clang kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [commit]{.sub}
: Fossil-Commit-ID, aus der Tcl gebaut wurde.

[::tcl::build-info]{.cmd} [compiledebug]{.sub}
: 1, wenn Tcl mit **-DTCL\_COMPILE\_DEBUG** kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [compiler]{.sub}
: Compilername (clang, gcc, icc oder msvc), Bindestrich, (4-stellige) Versionsnummer.

[::tcl::build-info]{.cmd} [compilestats]{.sub}
: 1, wenn Tcl mit **-DTCL\_COMPILE\_STATS** kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [cplusplus]{.sub}
: 1, wenn Tcl mit einem C++-Compiler kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [debug]{.sub}
: 1, wenn Tcl nicht mit **-DNDEBUG** kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [gcc]{.sub}
: GCC-Versionsnummer (4 Ziffern) bei GCC-Build, sonst 0.

[::tcl::build-info]{.cmd} [icc]{.sub}
: ICC-Versionsnummer (4 Ziffern) bei ICC-Build, sonst 0.

[::tcl::build-info]{.cmd} [ilp32]{.sub}
: 1, wenn Integer, Long und Zeiger jeweils 32 Bit sind, sonst 0.

[::tcl::build-info]{.cmd} [memdebug]{.sub}
: 1, wenn Tcl mit **-DTCL\_MEM\_DEBUG** kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [msvc]{.sub}
: MSVC-Versionsnummer (4 Ziffern) bei MSVC-Build, sonst 0.

[::tcl::build-info]{.cmd} [nmake]{.sub}
: 1, wenn Tcl mit nmake gebaut wurde, sonst 0.

[::tcl::build-info]{.cmd} [no-deprecate]{.sub}
: 1, wenn Tcl mit **-DTCL\_NO\_DEPRECATED** kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [no-thread]{.sub}
: 1, wenn Tcl mit **-DTCL\_THREADS=0** kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [no-optimize]{.sub}
: 1, wenn Tcl nicht mit **-DTCL\_CFG\_OPTIMIZED** kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [objective-c]{.sub}
: 1, wenn Tcl mit einem Objective-C-Compiler kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [objective-cplusplus]{.sub}
: 1, wenn Tcl mit einem Objective-C++-Compiler kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [patchlevel]{.sub}
: Tcl-Patchlevel, wie [info patchlevel][info].

[::tcl::build-info]{.cmd} [profile]{.sub}
: 1, wenn Tcl mit **-DTCL\_CFG\_PROFILED** kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [purify]{.sub}
: 1, wenn Tcl mit **-DPURIFY** kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [static]{.sub}
: 1, wenn Tcl als statische Bibliothek kompiliert wurde, sonst 0.

[::tcl::build-info]{.cmd} [tommath]{.sub}
: libtommath-Versionsnummer (4 Ziffern), wenn libtommath in Tcl eingebaut ist, sonst 0.

[::tcl::build-info]{.cmd} [version]{.sub}
: Tcl-Version, wie [info tclversion][info].

[::tcl::build-info]{.cmd} [zlib]{.sub}
: zlib-Versionsnummer (4 Ziffern), wenn zlib in Tcl eingebaut ist, sonst 0.


# Beispiele

Verwendung von **::tcl::build-info**:

```
::tcl::build-info
     → 9.0.2+af16c07b81655fabde8028374161ad54b84ef9956843c63f49976b4ef601b611.gcc-1204
::tcl::build-info commit
     → af16c07b81655fabde8028374161ad54b84ef9956843c63f49976b4ef601b611
::tcl::build-info compiler
     → gcc-1204
::tcl::build-info gcc
     → 1204
::tcl::build-info version
     → 9.0
::tcl::build-info patchlevel
     → 9.0.2
```


[info]: info.md
