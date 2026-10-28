---
CommandName: platform
title: platform
ManualSection: n
Version: 1.0.4
TclPart: platform
TclDescription: Tcl Bundled Packages
Keywords:
 - operating system
 - cpu architecture
 - platform
 - architecture
Copyright:
 - Copyright (c) 2006 ActiveState Software Inc
---

# Name

platform - Unterstützungscode und Hilfsmittel zur Systemidentifikation

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [platform]{.lit} [1.0.10]{.optlit}
[platform::generic]{.cmd}
[platform::identify]{.cmd}
[platform::patterns]{.cmd} [identifier]{.arg}
:::

# Beschreibung

Das Paket **platform** stellt mehrere Hilfsbefehle bereit, die zur Identifikation der Architektur einer Maschine nützlich sind, auf der Tcl läuft.

Tcl bietet zwar das Array [tcl\_platform][tclvars] zur Identifikation der aktuellen Architektur (insbesondere die Elemente platform und machine), das reicht nicht immer aus. Auf Unix-Systemen spiegelt [tcl\_platform][tclvars] die von **uname** gelieferten Werte wider, die über Plattformen und Architekturen nicht standardisiert sind. Auf mindestens einer Plattform (AIX) enthält **tcl\_platform(machine)** außerdem die CPU-Seriennummer.

Einzelne Anwendungen müssen daher Werte in [tcl\_platform][tclvars] (zusammen mit Ausgaben systemspezifischer Hilfsprogramme) selbst aufbereiten — unbequem für Entwickler und fehleranfällig bei Inkonsistenzen bei Architektur-Identifikation und Namenskonventionen.

Das Paket **platform** verhindert solche Fragmentierung: Es etabliert eine standardisierte Namenskonvention für Architekturen mit Tcl und erleichtert Entwicklern die Identifikation der Architektur, unter der ein Tcl-Programm läuft.

# Befehle

**platform::identify**
: Dieser Befehl gibt eine Kennung zurück, die die Plattform beschreibt, auf der der Tcl-Kern läuft. Die Kennung hat im Allgemeinen das Format *OS*-*CPU*. Der *OS*-Teil kann Details wie Kernel-Version, libc-Version usw. enthalten und selbst Bindestriche; der *CPU*-Teil enthält keine Bindestriche, sodass der vorletzte Bindestrich in der Kennung der letzte ist.

**platform::generic**
: Dieser Befehl gibt eine vereinfachte Kennung zurück, die die Plattform beschreibt, auf der der Tcl-Kern läuft. Im Gegensatz zu **platform::identify** werden Details wie Kernel- oder libc-Version weggelassen. Das Format ist im Allgemeinen *OS*-*CPU*.

**platform::patterns** *identifier*
: Dieser Befehl nimmt eine von **platform::identify** zurückgegebene Kennung und liefert eine Liste von Kennungen kompatibler Architekturen.


# Beispiele

Ermöglicht z. B., eine Anwendung mit mehreren Builds einer Shared Library auszuliefern, damit dasselbe Paket auf vielen Versionen eines Betriebssystems funktioniert:

```
package require platform
# Annahme: App-Skript ist .../theapp/bin/theapp.tcl
set binDir [file dirname [file normalize [info script]]]
set libDir [file join $binDir .. lib]
set platLibDir [file join $libDir [platform::identify]]
load [file join $platLibDir support[info sharedlibextension]]
```


[tclvars]: tclvars.md
