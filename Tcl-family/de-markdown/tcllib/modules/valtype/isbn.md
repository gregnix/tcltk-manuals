---
CommandName: valtype::isbn
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Validation types
Keywords:
 - Book Number
 - Checking
 - EAN
 - EAN13
 - European Article Number
 - ISBN
 - International Article Number
 - International Standard Book Number
 - Testing
 - Type checking
 - Validation
 - Value checking
 - isA
Copyright:
 - Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

valtype::isbn – Validierung der ISBN

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} [2]{.lit} 
[package]{.cmd} [require]{.sub} [valtype::common]{.lit} 
[package]{.cmd} [require]{.sub} [valtype::isbn]{.lit} [1.1]{.optlit} 
[valtype::isbn]{.cmd} [validate]{.sub} [value]{.arg} 
[valtype::isbn]{.cmd} [checkdigit]{.sub} [value]{.arg} 
[valtype::isbn]{.cmd} [13of]{.sub} [value]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket implementiert einen SNIT-Validierungstyp für eine ISBN.

Ein Validierungstyp ist ein Objekt, mit dem Tcl-Werte einer bestimmten Art validiert werden können. So wird beispielsweise **snit::integer**, ein vom Paket **snit** definierter Validierungstyp, verwendet, um zu überprüfen, ob ein Tcl-Wert eine Ganzzahl ist.

Jeder Validierungstyp verfügt über eine Methode namens **validate**, die zur Durchführung der Validierung dient. Diese Methode muss ein einziges Argument entgegennehmen, nämlich den zu validierenden Wert; außerdem darf sie nichts unternehmen, wenn der Wert gültig ist, muss jedoch einen Fehler auslösen, wenn der Wert ungültig ist:

```
    valtype::isbn validate .... ;# Does nothing
    valtype::isbn validate .... ;# Throws an error (bad ISBN).
```

Die Methode **validate** gibt bei Erfolg stets den validierten Wert zurück und löst bei einem Fehler den Fehlercode **-errorcode** INVALID aus, möglicherweise zusammen mit zusätzlichen Elementen, die weitere Details zum Problem liefern.

# API

Die von diesem Paket bereitgestellte API entspricht der Spezifikation der Snit-Validierungstypen, wie sie in der Dokumentation von *Snit’s Not Incr Tcl* zu finden ist.

**valtype::isbn** **validate** *value*
: Diese Methode überprüft den *value* und gibt ihn – gegebenenfalls in kanonischer Form – zurück, wenn er die Validierung besteht. Wenn der Wert die Validierung nicht besteht, wird ein Fehler ausgelöst.

**valtype::isbn** **checkdigit** *value*
: Diese Methode berechnet eine Prüfziffer für den *value*. Zuvor wird dieser – mit Ausnahme der Prüfziffer – einer Validierung unterzogen. Wenn der Wert die Validierung nicht besteht, wird keine Prüfziffer berechnet, sondern stattdessen ein Fehler ausgelöst.

**valtype::isbn** **13of** *value*
: Diese Methode erwartet eine 10-stellige ISBN im alten Format und gibt die kanonische, moderne 13-stellige ISBN zurück. Dies wird von **validate** verwendet, um die Eingabe zu kanonisieren, sodass alle Teile des Systems nach der Validierung davon ausgehen können, mit modernen 13-stelligen ISBNs zu arbeiten.


# FEHLERCODES

Wie in der Paketbeschreibung angegeben, verwenden die Fehler, die von den Befehlen dieses Pakets als Reaktion auf Fehler bei der Eingabevalidierung ausgelöst werden, den Code **-errorcode** INVALID, um sich von paketinternen Fehlern zu unterscheiden.

Um detailliertere Informationen darüber zu liefern, warum die Validierung fehlgeschlagen ist, geht der Fehlercode **-errorCode** tatsächlich noch einen Schritt weiter. Zunächst enthält er einen Code, der die Art des Fehlers selbst angibt. In diesem Fall lautet dieser **ISBN**. Darauf folgen Werte, die den Grund für den Fehler näher erläutern. Die vollständige Liste der **-errorCode**-Fehler, die von diesem Paket ausgelöst werden können, lautet wie folgt:

**INVALID ISBN CHARACTER**
: Der Wert der Eingabe enthielt ein oder mehrere unzulässige Zeichen, d. h. Zeichen, die in der Eingabe nicht vorkommen dürfen, damit es sich um eine ISBN handelt.

**INVALID ISBN CHECK-DIGIT**
: Die Prüfziffer des eingegebenen Werts ist falsch. Dies deutet in der Regel auf einen Eingabefehler hin, beispielsweise vertauschte oder fehlende Ziffern usw. Selbstverständlich kann es sich bei der Eingabe auch um eine regelrechte Fälschung handeln.

**INVALID ISBN LENGTH**
: Der eingegebene Wert hat nicht die richtige Länge für eine ISBN.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *valtype* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Validierung, Typprüfung

# COPYRIGHT

```
Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
