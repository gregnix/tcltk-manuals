---
CommandName: valtype::common
title: valtype::common
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Validation types
Keywords:
 - Checking
 - Testing
 - Type checking
 - Validation
 - Value checking
 - isA
Copyright:
 - Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

valtype::common – Validierung, allgemeiner Code

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [valtype::common]{.lit} [1.1]{.optlit}
[valtype::common::reject]{.cmd} [code]{.arg} [text]{.arg}
[valtype::common::badchar]{.cmd} [code]{.arg} [text]{.optarg}
[valtype::common::badcheck]{.cmd} [code]{.arg} [text]{.optarg}
[valtype::common::badlength]{.cmd} [code]{.arg} [lengths]{.arg} [text]{.optarg}
[valtype::common::badprefix]{.cmd} [code]{.arg} [prefixes]{.arg} [text]{.optarg}
:::

# Beschreibung

Dieses Paket implementiert eine Reihe gängiger Befehle, die von den Validierungstypen in diesem Modul verwendet werden. Diese Befehle kapseln im Wesentlichen die Auslösung von Validierungsfehlern und stellen sicher, dass ein korrekter **-errorcode** verwendet wird. Siehe Abschnitt [Fehlercodes].

# API

**valtype::common::reject** *code* *text*
: Der Hauptbefehl dieses Pakets löst einen **INVALID**-Fehler mit dem angegebenen *text* aus. Das erste Argument ist eine Liste von Codes, die den **INVALID** um detaillierte Informationen erweitern.

**valtype::common::badchar** *code* ?*text*?
: Dieser Befehl löst einen **INVALID CHAR**-Fehler mit dem angegebenen *text* aus. Das erste Argument ist eine Liste von Codes, die weitere Details enthalten. Diese werden zwischen den Codes **INVALID** und **CHARACTER** eingefügt.

**valtype::common::badcheck** *code* ?*text*?
: Dieser Befehl löst einen **INVALID CHECK-DIGIT**-Fehler mit dem angegebenen *text* aus, sofern vorhanden, ergänzt um den Standardtext „Die Prüfziffer ist falsch“. Das erste Argument ist eine Liste von Codes, die Details liefern. Diese werden zwischen den Codes **INVALID** und **CHECK\_DIGIT** eingefügt.

**valtype::common::badlength** *code* *lengths* ?*text*?
: Dieser Befehl löst einen **INVALID LENGTH**-Fehler mit dem angegebenen *text* aus, sofern vorhanden, ergänzt um den Standardtext „falsche Länge, erwartet wurden … Zeichen“. Das erste Argument ist eine Liste von Codes, die Details liefern. Diese werden zwischen den Codes **INVALID** und **LENGTH** eingefügt. Das Argument *lengths* ist eine Liste der erwarteten Eingabelängen, d. h. dies sind die gültigen Längen.

**valtype::common::badprefix** *code* *prefixes* ?*text*?
: Dieser Befehl löst einen **INVALID PREFIX**-Fehler mit dem angegebenen *text* aus, sofern vorhanden, ergänzt um den Standardtext „Falsches Präfix, erwartet wurde …“. Das erste Argument ist eine Liste von Codes, die weitere Details liefern. Diese werden zwischen den Codes **INVALID** und **PREFIX** eingefügt. Das Argument *prefixes* ist eine Liste der erwarteten Eingabeprefixe, d. h., dies sind die gültigen Präfixe.


# Fehlercodes

Die von den Befehlen dieses Pakets ausgelösten Fehler verwenden durchweg die Codes **-errorcode** und **INVALID**, um die von ihnen dargestellten Fehler bei der Validierung der Eingaben von pakketinternen Fehlern zu unterscheiden.

Um detailliertere Informationen darüber zu liefern, warum die Validierung fehlgeschlagen ist, geht der Fehlercode **-errorCode** tatsächlich noch einen Schritt weiter. Zunächst enthält er einen Code, der den Typ selbst beschreibt. Dieser wird vom Aufrufer bereitgestellt. Darauf folgen Werte, die den Grund für den Fehler näher erläutern. Die vollständige Liste der **-errorCode**-Fehler, die von diesem Paket ausgelöst werden können, ist unten aufgeführt, wobei **<>** als Platzhalter sowohl für die vom Aufrufer bereitgestellten Typinformationen als auch für die Typbeschreibung dient.

INVALID **<>** CHARACTER
: Der Eingabewert enthielt ein oder mehrere unzulässige Zeichen, d. h. Zeichen, die in der Eingabe nicht vorkommen dürfen, damit es sich um einen **<>** handelt.

INVALID **<>** CHECK-DIGIT
: Die Prüfziffer des eingegebenen Werts ist falsch. Dies deutet in der Regel auf einen Eingabefehler hin, beispielsweise vertauschte oder fehlende Ziffern usw. Selbstverständlich kann es sich bei der Eingabe auch um eine regelrechte Fälschung handeln.

INVALID **<>** LENGTH
: Der Wert hat eine falsche Länge, um als **<>** zu gelten.

INVALID **<>** PREFIX
: Der Eingabewert beginnt nicht mit dem/den magischen Wert(en), der/die erforderlich ist/sind, damit es sich um einen **<>** handelt.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *valtype* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Validierung, Typprüfung

# Copyright

```
Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
