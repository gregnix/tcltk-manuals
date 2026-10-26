---
CommandName: valtype::creditcard::discover
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Validation types
Keywords:
 - Checking
 - Discover
 - Testing
 - Type checking
 - Validation
 - Value checking
 - bank
 - card for credit
 - credit card
 - finance
 - isA
Copyright:
 - Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

valtype::creditcard::discover – Validierung der Discover-Kreditkartennummer

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} [2]{.lit} 
[package]{.cmd} [require]{.sub} [valtype::common]{.lit} 
[package]{.cmd} [require]{.sub} [valtype::luhn]{.lit} 
[package]{.cmd} [require]{.sub} [valtype::creditcard::discover]{.lit} [1.1]{.optlit} 
[valtype::creditcard::discover]{.cmd} [validate]{.sub} [value]{.arg} 
[valtype::creditcard::discover]{.cmd} [checkdigit]{.sub} [value]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket implementiert einen Snit-Validierungstyp für eine Discover-Kreditkartennummer.

Ein Validierungstyp ist ein Objekt, mit dem Tcl-Werte einer bestimmten Art validiert werden können. So wird beispielsweise **snit::integer**, ein vom Paket **snit** definierter Validierungstyp, verwendet, um zu überprüfen, ob ein Tcl-Wert eine Ganzzahl ist.

Jeder Validierungstyp verfügt über eine Methode namens **validate**, die zur Durchführung der Validierung dient. Diese Methode muss ein einziges Argument entgegennehmen, nämlich den zu validierenden Wert; außerdem darf sie nichts unternehmen, wenn der Wert gültig ist, muss jedoch einen Fehler auslösen, wenn der Wert ungültig ist:

```
    valtype::creditcard::discover validate .... ;# Does nothing
    valtype::creditcard::discover validate .... ;# Throws an error (bad Discover creditcard number).
```

Die Methode **validate** gibt bei Erfolg stets den validierten Wert zurück und löst bei einem Fehler den Fehlercode **-errorcode** INVALID aus, möglicherweise zusammen mit zusätzlichen Elementen, die weitere Details zum Problem liefern.

# API

Die von diesem Paket bereitgestellte API entspricht der Spezifikation der Snit-Validierungstypen, wie sie in der Dokumentation von *Snit’s Not Incr Tcl* zu finden ist.

**valtype::creditcard::discover** **validate** *value*
: Diese Methode überprüft den *value* und gibt ihn – gegebenenfalls in kanonischer Form – zurück, wenn er die Validierung besteht. Wenn der Wert die Validierung nicht besteht, wird ein Fehler ausgelöst.

**valtype::creditcard::discover** **checkdigit** *value*
: Diese Methode berechnet eine Prüfziffer für den *value*. Zuvor wird dieser – mit Ausnahme der Prüfziffer – einer Validierung unterzogen. Wenn der Wert die Validierung nicht besteht, wird keine Prüfziffer berechnet, sondern stattdessen ein Fehler ausgelöst.


# FEHLERCODES

Wie in der Paketbeschreibung angegeben, verwenden die Fehler, die von den Befehlen dieses Pakets als Reaktion auf Fehler bei der Eingabevalidierung ausgelöst werden, den Code **-errorcode** INVALID, um sich von paketinternen Fehlern zu unterscheiden.

Um detailliertere Informationen darüber zu liefern, warum die Validierung fehlgeschlagen ist, geht der Fehlercode **-errorCode** tatsächlich noch einen Schritt weiter. Zunächst enthält er einen Code, der die Art des Fehlers selbst angibt. In diesem Fall lautet dieser **CREDITCARD DISCOVER**. Darauf folgen Werte, die den Grund für den Fehler näher erläutern. Die vollständige Liste der **-errorCode**-Fehler, die von diesem Paket ausgelöst werden können, lautet wie folgt:

**INVALID CREDITCARD DISCOVER CHARACTER**
: Der Wert der Eingabe enthielt ein oder mehrere unzulässige Zeichen, d. h. Zeichen, die in der Eingabe nicht vorkommen dürfen, damit es sich um eine Discover-Kreditkartennummer handelt.

**INVALID CREDITCARD DISCOVER CHECK-DIGIT**
: Die Prüfziffer des eingegebenen Werts ist falsch. Dies deutet in der Regel auf einen Eingabefehler hin, beispielsweise vertauschte oder fehlende Ziffern usw. Selbstverständlich kann es sich bei der Eingabe auch um eine regelrechte Fälschung handeln.

**INVALID CREDITCARD DISCOVER LENGTH**
: Der eingegebene Wert hat nicht die richtige Länge, um eine Discover-Kreditkartennummer zu sein.

**INVALID CREDITCARD DISCOVER PREFIX**
: Der eingegebene Wert beginnt nicht mit dem/den „magischen Wert(en)“, der/die erforderlich ist/sind, damit es sich um eine Discover-Kreditkartennummer handelt.


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
