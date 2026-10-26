---
CommandName: docidx_lang_intro
title: docidx_lang_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - docidx_lang_cmdref
 - docidx_lang_syntax
Keywords:
 - docidx commands
 - docidx language
 - docidx markup
 - docidx syntax
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

docidx\_lang\_intro – Einleitung in die Sprache „docidx“

# Beschreibung

Dieses Dokument bietet anhand zahlreicher Beispiele eine informelle Einleitung in Version 1 der docidx-Auszeichnungssprache. Nach der Lektüre dieses Dokuments sollten Autoren in der Lage sein, die beiden Teile der formalen Spezifikation zu verstehen, nämlich die Spezifikation der *docidx-Sprachsyntax* und die *docidx-Befehlsreferenz*.

## Grundlagen

Zwar ähnelt die *docidx-Markup-Sprache* im weitesten Sinne der *doctools-Markup-Sprache*, doch gibt es einen wesentlichen Unterschied. Ein Index besteht im Wesentlichen ausschließlich aus Markup-Befehlen, zwischen denen – abgesehen von Leerzeichen – kein Klartext eingestreut ist.

Jeder Markup-Befehl ist ein Tcl-Befehl, der von einem passenden Paar aus **\[** und **\]** umgeben ist. Innerhalb dieser Begrenzungszeichen gelten die üblichen Regeln für einen Tcl-Befehl hinsichtlich Wortanführungszeichen, verschachtelter Befehle, Fortsetzungszeilen usw. Das heißt:

```
    ... [key {markup language}] ...
```

```
  ... [manpage thefile \
          {file description}] ...
```

## Grundlegender Aufbau

Das einfachste Dokument, das in docidx verfasst werden kann, ist

```
    [index_begin GROUPTITLE TITLE]
    [index_end]
```

Nicht besonders nützlich, aber gültig. Dies zeigt uns zudem, dass alle docidx-Dokumente aus nur einem Teil bestehen, in dem wir alle Schlüssel und deren Verweise auflisten werden.

Ein nützlicherer Index enthält zumindest Schlüsselwörter oder kurze „Schlüssel“, d. h. die Phrasen, die indexiert wurden. Also:

```
[index_begin GROUPTITLE TITLE]
[key markup]
[key {semantic markup}]]
[key {docidx markup}]
[key {docidx language}]
[key {docidx commands}]
[index_end]
```

Im obigen Beispiel wird der Befehl [key][docidx_lang_cmdref] verwendet, um die Schlüsselwortphrasen zu definieren, die in den Index aufgenommen werden sollen.

Ein wirklich nützlicher Index listet jedoch nicht nur die Schlüsselwortphrasen auf, sondern enthält auch Verweise auf Dokumente, die mit den Schlüsselwörtern in Verbindung stehen. Hier ist ein fiktiver Index für alle Manpages im Modul *base64*:

```
[index_begin tcllib/base64 {De- & Encoding}]
[key base64]
[manpage base64]
[key encoding]
[manpage base64]
[manpage uuencode]
[manpage yencode]
[key uuencode]
[manpage uuencode]
[key yEnc]
[manpage yencode]
[key ydecode]
[manpage yencode]
[key yencode]
[manpage yencode]
[index_end]
```

Im obigen Beispiel wird der Befehl [manpage][docidx_lang_cmdref] verwendet, um Verweise auf Dokumente unter Verwendung symbolischer Namen einzufügen, wobei jeder Befehl dem unmittelbar vorangehenden Befehl [key][docidx_lang_cmdref] zugeordnet ist.

Der andere Befehl zum Einfügen von Verweisen lautet **url**. Im Gegensatz zu [manpage][docidx_lang_cmdref] verwendet er explizite (möglicherweise formatspezifische) URLs, um den Speicherort des referenzierten Dokuments anzugeben. Daher ist dieser Befehl für die Erstellung von Verweisen auf externe Dokumente vorgesehen, die auf keine andere Weise verarbeitet werden konnten.

## Erweiterte Struktur

In allen bisherigen Beispielen waren wir hinsichtlich des Markups, das tatsächlich vor dem Befehl **index\_begin** zum Öffnen des Dokuments verwendet werden darf, etwas ungenau.

Anstelle von reinen Leerzeichen sind auch die beiden Vorlagenbefehle [include][docidx_lang_cmdref] und [vset][docidx_lang_cmdref] zulässig, damit der Verfasser für den Index relevante Konfigurationseinstellungen festlegen und/oder importieren kann. Das heißt, es ist möglich, Folgendes zu schreiben:

```
[include FILE]
[vset VAR VALUE]
[index_begin GROUPTITLE TITLE]
...
[index_end]
```

Noch wichtiger ist, dass diese beiden Befehle überall dort zulässig sind, wo ein Markup-Befehl zulässig ist, unabhängig von jeglicher anderen Struktur.

```
[index_begin GROUPTITLE TITLE]
[include FILE]
[vset VAR VALUE]
...
[index_end]
```

Die einzige Einschränkung, die [include][docidx_lang_cmdref] beachten muss, besteht darin, dass der Inhalt der eingebundenen Datei an der Stelle der Einbindung gültig sein muss. Das heißt, eine Datei, die vor **index\_begin** eingebunden wird, darf nur die Template-Befehle [vset][docidx_lang_cmdref] und [include][docidx_lang_cmdref] enthalten; eine Datei, die nach einem Schlüssel eingebunden wird, darf nur **manpage**- oder **url**-Verweise sowie andere Schlüssel enthalten, usw.

## Escapes

Neben den bisher vorgestellten sechs Befehlen stehen zwei weitere zur Verfügung. Diese dienen jedoch nicht der Markierung der Indexstruktur, sondern dem Einfügen von Zeichen, nämlich **\[** und **\]**. Diese Befehle, nämlich [lb][docidx_lang_cmdref] bzw. [rb][docidx_lang_cmdref], sind erforderlich, da unsere Verwendung von \[ und \] zur Einrahmung von Markup-Befehlen es unmöglich macht, \[ und \] direkt innerhalb des Textes zu verwenden.

Als Beispiel für ihre Verwendung dient der Quelltext des letzten Satzes im vorangegangenen Absatz, wobei einige Stellen hervorgehoben wurden.

```
  ...
  These commands, [cmd lb] and [cmd lb] respectively, are required
  because our use of [lb] and [rb] to bracket markup commands makes it
  impossible to directly use [lb] and [rb] within the text.
  ...
```

# Weiterführende Literatur

Nachdem der Leser dieses Dokument nun verinnerlicht hat – wobei davon ausgegangen wird, dass es sich um einen *Verfasser* von Dokumentationen handelt –, sollte er ausreichend gerüstet sein, um auch die formale Spezifikation der *docidx-Sprachsyntax* zu verstehen. Von nun an dient die *docidx-Befehlsreferenz* zudem als detaillierte Spezifikation und Spickzettel für alle verfügbaren Befehle und deren Syntax.

Um ein Dokument bereits während der Erstellung validieren zu können, empfiehlt es sich zudem, sich mit dem äußerst flexibel konfigurierbaren **dtp** von Tclapps vertraut zu machen.

Andererseits eignet sich docidx hervorragend für die automatische Generierung aus doctools-Dokumenten, und genau diesen Weg beschreitet das benutzerfreundliche und einfache **dtplite** von Tcllib, das im Hintergrund einen Index für eine Reihe von Dokumenten erstellt, ohne dass der Verfasser dies selbst tun muss.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dokumentationswerkzeuge

# Copyright

```
Copyright (c) 2007-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[docidx_lang_cmdref]: docidx_lang_cmdref.md
