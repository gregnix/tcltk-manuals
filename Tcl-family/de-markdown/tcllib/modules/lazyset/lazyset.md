---
CommandName: lazyset
title: lazyset
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Lazy evaluation for variables and arrays
Copyright:
 - Copyright (c) 2018 Roy Keene
---

# Name

lazyset – Lazy Auswertung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [lazyset]{.lit} [1.1]{.optlit}
[::lazyset::variable]{.cmd} [-array boolean]{.optarg} [-appendArgs boolean]{.optarg} [someVar]{.arg} [commandPrefix]{.arg}
:::

# Beschreibung

Das Paket „**lazyset**“ bietet eine Möglichkeit, die Ausführung von Code so lange aufzuschieben, bis auf eine bestimmte Variable oder einen beliebigen Index eines Arrays verwiesen wird.

*(Eine andere Art, die Ausführung aufzuschieben, ist eine Singleton-Klasse. Beim ersten Aufruf ihres Konstruktors, falls er überhaupt erfolgt, wird das Objekt erzeugt. Jeder weitere Konstruktoraufruf liefert das zuerst erzeugte Objekt zurück. Siehe* [oo::singleton](https://www.tcl-lang.org/man/tcl/TclCmd/singleton.html).)

# API

**::lazyset::variable** ?*-array boolean*? ?*-appendArgs boolean*? *someVar* *commandPrefix*
: Sorgt dafür, dass der als *commandPrefix* angegebene Code ausgeführt wird, wenn die Variable, deren Name durch *someVar* festgelegt wird, zum ersten Mal gelesen wird.

    Wenn das optionale Argument *-array boolean* auf „true“ gelegt wird, wird die als *someVar* angegebene Variable als Array behandelt, und jeder Versuch, einen beliebigen Index des Arrays auszulesen, bewirkt, dass dieser Index beim Auslesen durch *commandPrefix* gesetzt wird.

    Wenn das optionale Argument *-appendArgs boolean* als „false“ festgelegt wird, werden der Name der Variable und die Unternamen nicht an das *commandPrefix* angehängt, bevor die Auswertung durchgeführt wird.

    Wenn das Argument *-appendArgs boolean* nicht angegeben wird oder auf „true“ gelegt wird, werden dem *commandPrefix* 1 oder 2 zusätzliche Argumente angehängt. Wenn *-array boolean* als „true“ festgelegt wird, werden 2 Argumente angehängt, die dem Namen der Variablen und dem Index entsprechen; andernfalls wird 1 Argument angehängt, das den Namen der Variablen enthält.

    Der *commandPrefix*-Code wird im selben Geltungsbereich ausgeführt wie die Variable, die ausgelesen wird.


# Beispiele

```
	::lazyset::variable page {apply {{name} {
		package require http
		set token [http::geturl http://www.tcl-lang.org/]
		set data [http::data $token]
		return $data
	}}}

	puts $page
```

```
	::lazyset::variable -array true page {apply {{name index} {
		package require http
		set token [http::geturl $index]
		set data [http::data $token]
		return $data
	}}}

	puts $page(http://www.tcl-lang.org/)
```

```
	::lazyset::variable -appendArgs false simple {
		return -level 0 42
	}

	puts $simple
```

# Autoren

Roy Keane

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *utility* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hilfsprogramme

# Copyright

```
Copyright (c) 2018 Roy Keene
```
