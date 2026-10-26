---
CommandName: term::receive
title: term::receive
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - character input
 - control
 - get character
 - listener
 - receiver
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::receive – Allgemeine Eingaben von Terminals

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [term::receive]{.lit} [0.2]{.optlit}
[::term::receive::getch]{.cmd} [chan]{.optarg}
[::term::receive::listen]{.cmd} [cmd]{.arg} [chan]{.optarg}
[cmd]{.ins} [process]{.sub} [string]{.arg}
[cmd]{.ins} [eof]{.sub}
[::term::receive::unlisten]{.cmd} [chan]{.optarg}
:::

# Beschreibung

Dieses Paket stellt die grundlegendsten Befehle zum Empfangen von Zeichen auf einem Terminal bereit. Im Wesentlichen handelt es sich dabei um praktische Wrapper für die integrierten Befehle **read** und **fileevent**.

**::term::receive::getch** ?*chan*?
: Dieser Befehl liest ein einzelnes Zeichen aus dem Kanal mit dem Handle *chan* und gibt es als Ergebnis des Befehls zurück.

    Wird *chan* nicht angegeben, wird standardmäßig **stdin** verwendet.

    Es liegt in der Verantwortung des Aufrufenden, sicherzustellen, dass der Kanal einzelne Zeichen bereitstellen kann. Unter Unix kann dies beispielsweise mithilfe des Befehls aus dem Paket **term::ansi::ctrl::unix** erfolgen.

**::term::receive::listen** *cmd* ?*chan*?
: Dieser Befehl richtet einen fileevent-Listener für den Kanal mit dem Handle *chan* ein und ruft das Befehlspräfix *cmd* auf, sobald Zeichen empfangen wurden oder das EOF erreicht wurde.

    Wenn *chan* nicht angegeben wird, wird standardmäßig **stdin** verwendet.

    Die Signatur des Befehlspräfixes lautet

    *cmd* **process** *string*
    : Diese Methode wird aufgerufen, wenn Zeichen empfangen wurden, und *string* enthält diese zur weiteren Verarbeitung.

    *cmd* **eof**
    : Diese Methode wird aufgerufen, wenn am Kanal, den wir überwachen, das EOF erreicht wurde. Es handelt sich dabei um den letzten Aufruf, den die Rückruffunktion empfängt.


**::term::receive::unlisten** ?*chan*?
: Dieser Befehl deaktiviert den fileevent-Listener für den Kanal mit dem Handle *chan*.

    Wird *chan* nicht angegeben, wird standardmäßig **stdin** verwendet.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *term* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Terminalsteuerung

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
