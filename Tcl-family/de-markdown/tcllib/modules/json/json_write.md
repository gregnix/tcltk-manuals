---
CommandName: json::write
ManualSection: n
Version: 1.0.5
TclPart: tcllib
TclDescription: JSON
Keywords:
 - data exchange
 - exchange format
 - javascript
 - json
Copyright:
 - Copyright (c) 2009-2013,2022 Andreas Kupries <andreas_kupries@sourceforge.net>
---

# NAME

json::write – JSON-Generierung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [json::write]{.lit} [1.0.5]{.optlit} 
[::json::write]{.cmd} [indented]{.sub} 
[::json::write]{.cmd} [indented]{.sub} [flag]{.arg} 
[::json::write]{.cmd} [aligned]{.sub} 
[::json::write]{.cmd} [aligned]{.sub} [flag]{.arg} 
[::json::write]{.cmd} [string]{.sub} [s]{.arg} 
[::json::write]{.cmd} [array]{.sub} [arg...]{.arg} 
[::json::write]{.cmd} [array-strings]{.sub} [arg...]{.arg} 
[::json::write]{.cmd} [object]{.sub} [key]{.arg} [value...]{.arg} 
[::json::write]{.cmd} [object-strings]{.sub} [key]{.arg} [value...]{.arg} 
:::

# BESCHREIBUNG

Das **json::write** Das Paket bietet eine einfache, ausschließlich auf Tcl basierende Bibliothek zur Generierung von Text im JSON-Datenaustauschformat *http://www.json.org/*, wie in RFC 4627 *http://www.ietf.org/rfc/rfc4627.txt* festgelegt.

# BEFEHLE

**::json::write** **indented**
: Diese Methode gibt den aktuellen Status der Einrückungseinstellung zurück.

**::json::write** **indented** *flag*
: Diese Option und die Methode **aligned** legen das Layout des vom Paket generierten JSON fest. Ist dieses *Flag* gesetzt (Standard), teilt das Paket den generierten JSON-Code in Zeilen auf und rückt ihn entsprechend seiner inneren Struktur ein, wobei jeder Schlüssel eines Objekts in einer eigenen Zeile steht. Ist dieses Flag nicht gesetzt, wird das gesamte JSON-Objekt in einer einzigen Zeile geschrieben, wobei der Abstand zwischen allen Elementen minimal ist.

**::json::write** **aligned**
: Diese Methode gibt den aktuellen Status der Einstellung für die Ausrichtung zurück.

**::json::write** **aligned** *flag*
: Diese Option und die Methode **indented** legen das Layout des vom Paket generierten JSON fest. Ist dieses *Flag* gesetzt (Standard), sorgt das Paket dafür, dass die Werte der Schlüssel in einem Objekt vertikal zueinander ausgerichtet sind, was einen ansprechenden Tabelleneffekt erzeugt. Damit dies funktioniert, muss auch **indented** gesetzt sein. Ist dieses Flag nicht gesetzt, wird die Ausgabe entsprechend dem Wert von **indented** formatiert, ohne dass versucht wird, die Werte der Objektschlüssel zu richten.

**::json::write** **string** *s*
: Diese Methode nimmt die Zeichenkette *s* entgegen und gibt sie als Ergebnis mit den für JSON korrekten Anführungszeichen zurück.

**::json::write** **array** *arg*...
: Diese Methode nimmt eine Reihe von Argumenten im JSON-Format entgegen und gibt sie als ordnungsgemäß formatiertes JSON-Array zurück.

**::json::write** **array-strings** *arg*...
: Dies ist eine Komfortvariante von **array**. Sie geht davon aus, dass alle Argumente einfache Zeichenketten sind, und formatiert sie als JSON-Zeichenketten, bevor sie an **array** übergeben werden.

**::json::write** **object** *key* *value*...
: Diese Methode nimmt eine Reihe von Schlüssel-Wert-Argumenten entgegen, wobei die Werte bereits im JSON-Format vorliegen, und gibt sie als ordnungsgemäß formatiertes JSON-Objekt zurück, wobei die Schlüssel als JSON-Zeichenketten formatiert sind.

**::json::write** **object-strings** *key* *value*...
: Dies ist eine Komfortvariante von **object**. Sie geht davon aus, dass alle *Wert*-Argumente einfache Zeichenketten sind, und formatiert sie als JSON-Zeichenketten, bevor sie an **object** übergeben werden.


# VERWANDTE THEMEN

Um JSON zu parsen, anstatt es zu schreiben, siehe das Paket **json**.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *json* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

CGI-Programmierung

# COPYRIGHT

```
Copyright (c) 2009-2013,2022 Andreas Kupries <andreas_kupries@sourceforge.net>
```
