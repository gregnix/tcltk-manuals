---
CommandName: tcl::transform::rot
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - caesar cipher
 - channel transformation
 - cipher
 - decryption
 - encryption
 - reflected channel
 - rot
 - rot13
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::transform::rot – Rot-Verschlüsselung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::transform::rot]{.lit} [1.1]{.optlit} 
[::tcl::transform::rot]{.cmd} [chan]{.arg} [key]{.arg} 
:::

# BESCHREIBUNG

Das Paket **tcl::transform::rot** enthält einen Befehl zum Erstellen einer Kanal-Transformation, die eine einfache Verschlüsselung (beim Schreiben) und Entschlüsselung (beim Lesen) der Buchstaben durchführt. Der verwendete Algorithmus ist die Caesar-Chiffre, wobei es sich bei „rot13“ um eine spezielle Variante davon handelt.

Eine damit verbundene Transformation in diesem Modul ist **tcl::transform::otp**.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::rot** *chan* *key*
: Dieser Befehl erstellt eine Rotationsverschlüsselungstransformation für den Kanal *chan* und gibt dessen Handle zurück. Der Parameter „*key*“ legt fest, um wie viele Stellen die Zeichen im Alphabet gedreht werden, und wird auf den Bereich „0…25“ umgewandelt. Beachten Sie, dass diese Transformation nur Bytes in den Bereichen ASCII 65…90 sowie 97…122, d. h. die Groß- und Kleinbuchstaben „A…Z“ und „a…z“. Alle anderen Bytes werden unverändert weitergeleitet.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *virtchannel* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Kanäle

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
