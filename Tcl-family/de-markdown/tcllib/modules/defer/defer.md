---
CommandName: defer
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Defered execution ala Go
Keywords:
 - cleanup
 - golang
Copyright:
 - Copyright (c) 2017, Roy Keene
---

# NAME

defer – Aufgeschobene Ausführung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [defer]{.lit} [1.1]{.optlit} 
[::defer::defer]{.cmd} [command]{.optarg} [arg1]{.optarg} [arg2]{.optarg} [argN]{.optdot} 
[::defer::with]{.cmd} [variableList]{.arg} [script]{.arg} 
[::defer::autowith]{.cmd} [script]{.arg} 
[::defer::cancel]{.cmd} [id]{.optdot} 
:::

# BESCHREIBUNG

Mit den **defer**-Befehlen kann ein Entwickler Aktionen so planen, dass sie im Rahmen der Beendigung des aktuellen Variablenbereichs ausgeführt werden. Dies ist besonders nützlich für Aufräumvorgänge.  Da die aufgeschobenen Aktionen stets ausgeführt werden – und zwar immer in umgekehrter Reihenfolge zu der, in der die „defer“-Anweisungen selbst ausgeführt werden –, kann der Programmierer die Bereinigung einer Ressource (beispielsweise eines Kanals) planen, sobald diese Ressource angefordert wird.  Wenn die Prozedur oder das Lambda später beendet wird – sei es aufgrund eines Fehlers oder einer expliziten Rückkehr –, erfolgt die Bereinigung dieser Ressource stets.

# BEFEHLE

**::defer::defer** ?*command*? ?*arg1*? ?*arg2*? ?*argN...*?
: Verschiebt die Ausführung eines Teils des Codes bis zum Ende des aktuellen Variablenbereichs. Jedes Argument wird mit den anderen verkettet, um das Skript zu bilden, das zum Zeitpunkt der Verschiebung ausgeführt wird. Es können mehrere defer-Anweisungen verwendet werden; diese werden in der Reihenfolge „Last-In, First-Out“ ausgeführt. Der Wert ist ein Bezeichner, der später mit **defer::cancel** verwendet werden kann.

**::defer::with** *variableList* *script*
: Verschiebt die Ausführung eines Skripts und kopiert dabei den aktuellen Wert einiger Variablen, deren Namen in *variableList* festgelegt sind, in das Skript. Das Skript verhält sich wie ein Lambda, wird jedoch auf derselben Ebene wie der Aufruf von **defer::with** ausgeführt. Der Wert wird wie bei **::defer::defer** zurückgegeben

**::defer::autowith** *script*
: Entspricht **::defer::with**, verwendet jedoch alle lokalen Variablen in der Variablenliste.

**::defer::cancel** ?*id...*?
: Bricht die Ausführung einer zurückgestellten Aktion ab. Das Argument *id* ist die Kennung, die von den Funktionen **::defer::defer**, **::defer::with** oder **::defer::autowith** gegeben wird. Es können beliebig viele Argumente angegeben werden; alle angegebenen IDs werden dabei abgebrochen.


# BEISPIELE

```
	package require defer 1
	apply {{} {
		set fd [open /dev/null]
		defer::defer close $fd
	}}
```

# LITERATUR

**\[1\]**
: 


# AUTOREN

Roy Keane

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *defer* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hilfsprogramme

# COPYRIGHT

```
Copyright (c) 2017, Roy Keene
```
