---
CommandName: soundex
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Soundex
Keywords:
 - knuth
 - soundex
 - text comparison
 - text likeness
Copyright:
 - "Copyright (c) ????, Algorithm: Donald E. Knuth"
 - "Copyright (c) 2003, Documentation: Andreas Kupries <andreas_kupries@users.sourceforge.net>"
 - "Copyright (c) 1998, Tcl port: Evan Rempel <erempel@uvic.ca>"
---

# NAME

soundex – Soundex

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [soundex]{.lit} [1.1]{.optlit} 
[::soundex::knuth]{.cmd} [string]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Soundex-Algorithmen, die den Vergleich von Wörtern auf der Grundlage ihrer phonetischen Ähnlichkeit ermöglichen.

Derzeit steht lediglich ein Algorithmus von Knuth zur Verfügung, der auf englische Namen und Wörter abgestimmt ist.

**::soundex::knuth** *string*
: Berechnet den Soundex-Code der Eingabe *string* mit Knuths Algorithmus und gibt ihn als Ergebnis des Befehls zurück.


# BEISPIELE

```
    % ::soundex::knuth Knuth
    K530
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *soundex* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hashwerte, Prüfsummen und Verschlüsselung

# COPYRIGHT

```
Copyright (c) ????, Algorithm: Donald E. Knuth
Copyright (c) 2003, Documentation: Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 1998, Tcl port: Evan Rempel <erempel@uvic.ca>
```
