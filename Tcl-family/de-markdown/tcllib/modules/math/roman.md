---
CommandName: math::roman
ManualSection: 1.1
Version: tcllib
TclPart: Tcl Math Library
TclDescription: 
Keywords:
 - conversion
 - integer
 - roman numeral
Copyright:
 - Copyright (c) 2005 Kenneth Green <kenneth.green@gmail.com>
---

# NAME

math::roman – Werkzeuge zum Erstellen und Bearbeiten römischer Zahlen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math::roman]{.lit} [1.1]{.optlit} 
[::math::roman::toroman]{.cmd} [i]{.arg} 
[::math::roman::tointeger]{.cmd} [r]{.arg} 
[::math::roman::sort]{.cmd} [list]{.arg} 
[::math::roman::expr]{.cmd} [args]{.arg} 
:::

# BESCHREIBUNG

**::math::roman** ist eine reine Tcl-Bibliothek zur Konvertierung zwischen Ganzzahlen und römischen Zahlen. Sie bietet zudem Hilfsfunktionen zum Sortieren römischer Zahlen und zum Rechnen mit ihnen.

Dieser Code stammt ursprünglich aus dem Tcler-Wiki unter http://wiki.tcl.tk/1823 und steht daher für jede Nutzung und jeden Zweck frei zur Verfügung. Ein herzliches Dankeschön an die findigen Köpfe, die diese cleveren Routinen entwickelt und sie großzügig der Tcl-Community zur Verfügung gestellt haben.

Obwohl diese Bibliothek unter Tcl 8.3 geschrieben und durch Tests geprüft wurde, gehe ich davon aus, dass sie unter allen 8.x-Versionen von Tcl funktionieren wird.

# BEFEHLE

**::math::roman::toroman** *i*
: Wandelt eine Ganzzahl in eine römische Zahl um. Das Ergebnis wird stets in Großbuchstaben ausgegeben. Der Wert Null wird in eine leere Zeichenkette umgewandelt.

**::math::roman::tointeger** *r*
: Wandelt eine römische Zahl in eine Ganzzahl um.

**::math::roman::sort** *list*
: Sortiert eine Liste römischer Zahlen von der kleinsten zur größten.

**::math::roman::expr** *args*
: Wertet einen Ausdruck aus, dessen Operanden ausschließlich römische Zahlen sind. Von diesen Befehlen werden sowohl *toroman* als auch *tointeger* zur einfacheren Verwendung exportiert. Die beiden anderen werden nicht exportiert, da sie zu Konflikten mit bestehenden Tcl-Befehlen führen oder mit diesen verwechselt werden könnten.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: roman* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik

# COPYRIGHT

```
Copyright (c) 2005 Kenneth Green <kenneth.green@gmail.com>
```
