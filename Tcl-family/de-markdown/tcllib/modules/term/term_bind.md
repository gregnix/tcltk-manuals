---
CommandName: term::receive::bind
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - character input
 - control
 - dispatcher
 - listener
 - receiver
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

term::receive::bind – Tastaturzuordnung von Terminals

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [term::receive::bind]{.lit} [0.2]{.optlit} 
[term::receive::bind]{.cmd} [object]{.arg} [map]{.optarg} 
[object]{.ins} [map]{.sub} [str]{.arg} [cmd]{.arg} 
[object]{.ins} [default]{.sub} [cmd]{.arg} 
[object]{.ins} [listen]{.sub} [chan]{.optarg} 
[object]{.ins} [unlisten]{.sub} [chan]{.optarg} 
[object]{.ins} [reset]{.sub} 
[object]{.ins} [next]{.sub} [char]{.arg} 
[object]{.ins} [process]{.sub} [str]{.arg} 
[object]{.ins} [eof]{.sub} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine Klasse zur Erstellung einfacher Dispatcher bereit, die Zeichenfolgen zu Aktionen zuordnen. Intern ist jeder Dispatcher im Wesentlichen ein deterministischer endlicher Automat mit Baumstruktur.

# API FÜR KLASSEN

Das Paket exportiert einen einzigen Befehl, den Befehl „class“, der die Erstellung von Dispatcher-Instanzen ermöglicht. Seine API lautet wie folgt:

**term::receive::bind** *object* ?*map*?
: Dieser Befehl erstellt ein neues Dispatcher-Objekt mit dem Namen *object*, initialisiert es und gibt den vollqualifizierten Namen des Objektbefehls als Ergebnis zurück. Das Argument ist ein Dictionary, das Zeichenketten, das heißt Zeichenfolgen, den Befehlspräfixen zuordnet, die aufgerufen werden sollen, wenn die Zeichenfolge im Eingabestrom gefunden wird.


# OBJEKT-API

Die durch den Befehl „class“ erstellten Objekte stellen die nachfolgend aufgeführten Methoden bereit:

*object* **map** *str* *cmd*
: Diese Methode fügt eine zusätzliche Zuordnung von der Zeichenkette *str* zur Aktion *cmd* hinzu. Die Zuordnung wird sofort wirksam, sobald sich der Prozessor in einem Präfix von *str* befindet, oder beim nächsten Reset-Vorgang. Die Aktion ist ein Befehlspräfix und wird mit einem angehängten Argument aufgerufen, nämlich der Zeichenfolge, die den Aufruf auslöst. Sie wird im globalen Namespace ausgeführt.

*object* **default** *cmd*
: Diese Methode definiert eine Standardaktion *cmd*, die immer dann aufgerufen wird, wenn eine unbekannte Zeichenfolge auftritt. Der Befehlspräfix wird genauso behandelt wie die reguläre Aktion, die über die Methode **map** definiert wurde.

*object* **listen** ?*chan*?
: Diese Methode richtet einen fileevent-Listener für den Kanal mit dem Handle *chan* ein und ruft das Dispatcher-Objekt auf, sobald Zeichen empfangen wurden oder das EOF erreicht wurde. Wird *chan* nicht angegeben, wird standardmäßig **stdin** verwendet.

*object* **unlisten** ?*chan*?
: Diese Methode entfernt den fileevent-Listener für den Kanal mit dem Handle *chan*. Wenn *chan* nicht festgelegt wird, wird standardmäßig **stdin** verwendet.

*object* **reset**
: Diese Methode setzt den Zeichenprozessor auf den Anfang des Baums zurück.

*object* **next** *char*
: Diese Methode bewirkt, dass der Zeichenprozessor das Zeichen *c* verarbeitet. Dies kann lediglich zu einem Wechsel des internen Zustands führen oder eine zugehörige Aktion für eine erkannte Zeichenfolge auslösen.

*object* **process** *str*
: Diese Methode bewirkt, dass der Zeichenprozessor die Zeichenfolge *str* verarbeitet, dabei den internen Zustand weiterführt und bei Bedarf Aktionen auslöst. Hierbei handelt es sich um eine Rückruffunktion für **listen**.

*object* **eof**
: Diese Methode bewirkt, dass der Zeichenprozessor ein EOF in der Eingabe verarbeitet. Derzeit hat dies keine Auswirkung. Es handelt sich hierbei um eine Rückruffunktion für **listen**.


# HINWEISE

Aufgrund der Einfachheit des DFA ist es nicht möglich, eine Zeichenfolge zu erkennen, deren Präfix eine andere bereits erkannte Zeichenfolge ist.

Mit anderen Worten: Die Menge der erkannten Zeichenfolgen muss einen *Präfixcode* bilden.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *term* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Terminalsteuerung

# COPYRIGHT

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
