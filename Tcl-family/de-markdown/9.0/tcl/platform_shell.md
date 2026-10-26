---
CommandName: platform::shell
title: platform::shell
ManualSection: n
Version: 1.1.4
TclPart: platform::shell
TclDescription: Tcl Bundled Packages
Keywords:
 - operating system
 - cpu architecture
 - platform
 - architecture
Copyright:
 - Copyright (c) 2006-2008 ActiveState Software Inc
---

# Name

platform::shell - Unterstützungscode und Hilfsmittel zur Systemidentifikation

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [platform::shell]{.lit} [1.1.4]{.optlit}

[platform::shell::generic]{.cmd} [shell]{.arg}
[platform::shell::identify]{.cmd} [shell]{.arg}
[platform::shell::platform]{.cmd} [shell]{.arg}
:::

# Beschreibung

Das Paket **platform::shell** stellt mehrere Hilfsbefehle bereit, die zur Identifikation der Architektur einer bestimmten Tcl-Shell nützlich sind.

Das Paket erlaubt die Identifikation der Architektur einer Tcl-Shell, die sich von der Shell unterscheidet, die das Paket ausführt. Voraussetzung ist nur, dass die andere Shell (über ihren Pfad identifiziert) auf der aktuellen Maschine ausführbar ist.

Auf den meisten Plattformen ist die Architektur der abgefragten Shell mit der der laufenden Shell identisch; das gilt nicht allgemein. Gegenbeispiel sind Plattformen mit 32- und 64-Bit-Varianten, auf denen ein 64-Bit-System 32-Bit-Code ausführen kann: Laufende und abgefragte Shell können unterschiedliche 32/64-Bit-Einstellungen und damit unterschiedliche Kennungen haben.

Für Anwendungen wie ein Code-Repository ist es wichtig, die Architektur der Shell zu kennen, die installierte Pakete tatsächlich ausführt — nicht nur die Architektur der Shell, die die Repository-Software betreibt.

# Befehle

[platform::shell::identify]{.cmd} [shell]{.arg}
: Führt dieselbe Identifikation wie [platform::identify][platform] durch, jedoch für die angegebene Tcl-Shell statt für die laufende Shell.

[platform::shell::generic]{.cmd} [shell]{.arg}
: Führt dieselbe Identifikation wie [platform::generic][platform] durch, jedoch für die angegebene Tcl-Shell statt für die laufende Shell.

[platform::shell::platform]{.cmd} [shell]{.arg}
: Gibt den Inhalt von **tcl\_platform(platform)** für die angegebene Tcl-Shell zurück.


[platform]: platform.md
