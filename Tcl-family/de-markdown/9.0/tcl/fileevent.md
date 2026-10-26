---
CommandName: fileevent
title: fileevent
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - chan(n)
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2008 Pat Thoyts
---

# Name

fileevent - Führt ein Skript aus, wenn ein Kanal lesbar oder beschreibbar wird

# Übersicht

::: {.synopsis} :::
[fileevent]{.cmd} [channel]{.arg} [readable]{.lit} [script]{.optarg}
[fileevent]{.cmd} [channel]{.arg} [writable]{.lit} [script]{.optarg}
:::

# Beschreibung

Der Befehl **fileevent** wurde durch den Befehl [chan event][chan] abgelöst, der dieselbe Syntax und dieselben Optionen unterstützt.


[chan]: chan.md
