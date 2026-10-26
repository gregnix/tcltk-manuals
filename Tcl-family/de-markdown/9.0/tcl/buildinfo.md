---
CommandName: build-info
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

# NAME

buildinfo - Build-Informationen

# ÜBERSICHT

::: {.synopsis} :::
[::tcl::build-info]{.cmd} [field]{.optarg} 
:::

# BESCHREIBUNG

Dieser Befehl liefert Informationen darüber, wie Tcl gebaut wurde. Ohne Argumente: Tcl-Patchlevel, dann „+“, dann die Fossil-Commit-ID, gefolgt von einer Liste punktgetrennter Tags. Ist *field* angegeben, wird das entsprechende Feld extrahiert (siehe unten). Jeder andere *field*-Wert, der unten nicht genannt ist, liefert „0“. Bei offiziellen Tcl-Releases gelten folgende *field*-Werte:

**::tcl::build-info clang**
: Clang-Versionsnummer (4 Ziffern), wenn Tcl mit Clang kompiliert wurde, sonst 0.

**::tcl::build-info commit**
: Fossil-Commit-ID, aus der Tcl gebaut wurde.

**::tcl::build-info compiledebug**
: 1, wenn Tcl mit **-DTCL_COMPILE_DEBUG** kompiliert wurde, sonst 0.

**::tcl::build-info compiler**
: Compilername (clang, gcc, icc oder msvc), Bindestrich, (4-stellige) Versionsnummer.

**::tcl::build-info compilestats**
: 1, wenn Tcl mit **-DTCL_COMPILE_STATS** kompiliert wurde, sonst 0.

**::tcl::build-info cplusplus**
: 1, wenn Tcl mit einem C++-Compiler kompiliert wurde, sonst 0.

**::tcl::build-info debug**
: 1, wenn Tcl nicht mit **-DNDEBUG** kompiliert wurde, sonst 0.

**::tcl::build-info gcc**
: GCC-Versionsnummer (4 Ziffern) bei GCC-Build, sonst 0.

**::tcl::build-info icc**
: ICC-Versionsnummer (4 Ziffern) bei ICC-Build, sonst 0.

**::tcl::build-info ilp32**
: 1, wenn Integer, Long und Zeiger jeweils 32 Bit sind, sonst 0.

**::tcl::build-info memdebug**
: 1, wenn Tcl mit **-DTCL_MEM_DEBUG** kompiliert wurde, sonst 0.

**::tcl::build-info msvc**
: MSVC-Versionsnummer (4 Ziffern) bei MSVC-Build, sonst 0.

**::tcl::build-info nmake**
: 1, wenn Tcl mit nmake gebaut wurde, sonst 0.

**::tcl::build-info no-deprecate**
: 1, wenn Tcl mit **-DTCL_NO_DEPRECATED** kompiliert wurde, sonst 0.

**::tcl::build-info no-thread**
: 1, wenn Tcl mit **-DTCL_THREADS=0** kompiliert wurde, sonst 0.

**::tcl::build-info no-optimize**
: 1, wenn Tcl nicht mit **-DTCL_CFG_OPTIMIZED** kompiliert wurde, sonst 0.

**::tcl::build-info objective-c**
: 1, wenn Tcl mit einem Objective-C-Compiler kompiliert wurde, sonst 0.

**::tcl::build-info objective-cplusplus**
: 1, wenn Tcl mit einem Objective-C++-Compiler kompiliert wurde, sonst 0.

**::tcl::build-info patchlevel**
: Tcl-Patchlevel, wie **info patchlevel**.

**::tcl::build-info profile**
: 1, wenn Tcl mit **-DTCL_CFG_PROFILED** kompiliert wurde, sonst 0.

**::tcl::build-info purify**
: 1, wenn Tcl mit **-DPURIFY** kompiliert wurde, sonst 0.

**::tcl::build-info static**
: 1, wenn Tcl als statische Bibliothek kompiliert wurde, sonst 0.

**::tcl::build-info tommath**
: libtommath-Versionsnummer (4 Ziffern), wenn libtommath in Tcl eingebaut ist, sonst 0.

**::tcl::build-info version**
: Tcl-Version, wie **info tclversion**.

**::tcl::build-info zlib**
: zlib-Versionsnummer (4 Ziffern), wenn zlib in Tcl eingebaut ist, sonst 0.


# BEISPIELE

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
