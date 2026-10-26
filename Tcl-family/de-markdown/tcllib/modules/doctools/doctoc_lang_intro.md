---
CommandName: doctoc_lang_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - doctoc_intro
 - doctoc_lang_cmdref
 - doctoc_lang_syntax
Keywords:
 - doctoc commands
 - doctoc language
 - doctoc markup
 - doctoc syntax
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctoc_lang_intro – Einleitung in die Sprache „doctoc“

# BESCHREIBUNG

Dieses Dokument bietet anhand zahlreicher Beispiele eine informelle Einleitung in die Version 1.1 der Markup-Sprache „doctoc“. Nach der Lektüre dieses Dokuments sollten Autoren in der Lage sein, die beiden Teile der formalen Spezifikation zu verstehen, nämlich die Spezifikation der *doctoc-Sprachsyntax* und die *doctoc-Befehlsreferenz*.

## Grundlagen

Zwar ähnelt die *doctoc-Auszeichnungssprache* im weitesten Sinne der *doctools-Auszeichnungssprache*, doch gibt es einen wesentlichen Unterschied. Ein Inhaltsverzeichnis besteht im Wesentlichen ausschließlich aus Auszeichnungsbefehlen, zwischen denen – abgesehen von Leerzeichen – kein einfacher Text eingestreut ist.

Jeder Markup-Befehl ist ein Tcl-Befehl, der von einem passenden Paar aus **\[** und **\]** umgeben ist. Innerhalb dieser Begrenzungszeichen gelten die üblichen Regeln für einen Tcl-Befehl hinsichtlich Wortanführungszeichen, verschachtelter Befehle, Fortsetzungszeilen usw. Das heißt:

```
    ... [division_start {Appendix 1}] ...
```

```
  ... [item thefile \
          label {file description}] ...
```

## Grundlegender Aufbau

Das einfachste Dokument, das in doctoc verfasst werden kann, ist

```
    [toc_begin GROUPTITLE TITLE]
    [toc_end]
```

Dies zeigt uns zudem, dass alle doctoc-Dokumente aus nur einem Teil bestehen, in dem wir *Einträge* und *Abschnitte* auflisten werden.

Es steht frei, diese nach eigenem Ermessen zu kombinieren. Dies stellt eine Änderung gegenüber Version 1 der Sprache dar, die eine solche Kombination nicht zuließ, sondern lediglich die Verwendung entweder einer Reihe von Einträgen oder einer Reihe von Abschnitten erlaubte.

In den folgenden Abschnitten werden wir die Befehle für jede dieser beiden Möglichkeiten erläutern.

## Einträge

Der Befehl **item** nimmt einen *Eintrag* in ein Inhaltsverzeichnis auf. Dabei handelt es sich im Wesentlichen um einen Verweis auf einen Abschnitt, Unterabschnitt usw. in dem Dokument oder der Dokumentensammlung, für die das Inhaltsverzeichnis bestimmt ist. Der Befehl benötigt drei Argumente: einen symbolischen Namen für die Datei, auf die sich der Eintrag bezieht, sowie zwei Textangaben zur Beschriftung des Eintrags und zur Beschreibung des referenzierten Abschnitts.

Es werden symbolische Namen verwendet, um die Konvertierbarkeit dieses Formats in jedes beliebige Ausgabeformat zu gewährleisten. Der tatsächliche Name einer Datei wird bei der Konvertierung der Eingabe von der gewählten Formatierungs-Engine eingefügt, basierend auf einer Zuordnung von symbolischen zu tatsächlichen Namen, die der Engine bereitgestellt werden.

Hier ein fiktives Beispiel für ein Inhaltsverzeichnis dieses Dokuments:

```
[toc_begin Doctoc {Language Introduction}]
[item 1 DESCRIPTION]
[item 1.1 {Basic structure}]
[item 1.2 Items]
[item 1.3 Divisions]
[item 2 {FURTHER READING}]
[toc_end]
```

## Abschnitte

Im letzten Beispiel des vorangegangenen Abschnitts fällt auf, dass die referenzierten Abschnitte tatsächlich eine verschachtelte Struktur aufwiesen, was in den Bezeichnungen der Einträge zum Ausdruck kam, indem für alle unter Abschnitt 1 verschachtelten Abschnitte ein gemeinsames Präfix verwendet wurde.

Diese Art von Struktur lässt sich in der doctoc-Sprache durch die Verwendung von Abschnitten deutlicher hervorheben. Anstelle einer Reihe einfacher Einträge verwenden wir eine Reihe von Abschnitten für die wichtigsten Verweise und ordnen die verschachtelten Einträge dann innerhalb dieser an.

Selbstverständlich können wir anstelle der verschachtelten Einträge auch wieder Abschnitte verwenden und so beliebig tief verschachteln.

Ein Abschnitt wird durch zwei Befehle anstelle von einem gekennzeichnet: einen zum Starten des Abschnitts und einen zum Schließen des zuletzt geöffneten Abschnitts. Diese lauten:

**division_start**
: Dieser Befehl eröffnet einen neuen Abschnitt. Er erwartet ein oder zwei Argumente: den Titel des Abschnitts und den symbolischen Namen der Datei, auf die er verweist. Letzteres ist optional. Wenn der symbolische Dateiname angegeben ist, sollte der Abschnittstitel auf das referenzierte Dokument verweisen, sofern das Ausgabeformat Verweise unterstützt.

**division_end**
: Dieser Befehl schließt den zuletzt geöffneten und noch nicht geschlossenen Abschnitt. Auf diese Weise können wir das letzte Beispiel wie folgt umformulieren:


```
[toc_begin Doctoc {Language Introduction}]
[division_start DESCRIPTION]
[item 1 {Basic structure}]
[item 2 Items]
[item 3 Divisions]
[division_end]
[division_start {FURTHER READING}]
[division_end]
[toc_end]
```

Oder, um eine tiefere Verschachtelung zu veranschaulichen

```
[toc_begin Doctoc {Language Introduction}]
[division_start DESCRIPTION]
[division_start {Basic structure}]
[item 1 Do]
[item 2 Re]
[division_end]
[division_start Items]
[item a Fi]
[item b Fo]
[item c Fa]
[division_end]
[division_start Divisions]
[item 1 Sub]
[item 1 Zero]
[division_end]
[division_end]
[division_start {FURTHER READING}]
[division_end]
[toc_end]
```

Es ist möglich, Einträge und Abschnitte beliebig zu kombinieren und leere Abschnitte einzufügen.

```
[toc_begin Doctoc {Language Introduction}]
[item 1 Do]
[division_start DESCRIPTION]
[division_start {Basic structure}]
[item 2 Re]
[division_end]
[item a Fi]
[division_start Items]
[item b Fo]
[item c Fa]
[division_end]
[division_start Divisions]
[division_end]
[division_end]
[division_start {FURTHER READING}]
[division_end]
[toc_end]
```

## Erweiterte Struktur

In allen bisherigen Beispielen waren wir hinsichtlich des Markups, das tatsächlich vor dem Befehl **toc_begin** zum Öffnen des Dokuments verwendet werden darf, etwas ungenau.

Anstelle von reinen Leerzeichen sind auch die beiden Vorlagenbefehle **include** und **vset** zulässig, damit der Verfasser für das Inhaltsverzeichnis relevante Konfigurationseinstellungen festlegen und/oder importieren kann. Das heißt, es ist möglich, Folgendes zu schreiben:

```
[include FILE]
[vset VAR VALUE]
[toc_begin GROUPTITLE TITLE]
...
[toc_end]
```

Noch wichtiger ist, dass diese beiden Befehle überall dort zulässig sind, wo ein Markup-Befehl zulässig ist, unabhängig von jeglicher anderen Struktur.

```
[toc_begin GROUPTITLE TITLE]
[include FILE]
[vset VAR VALUE]
...
[toc_end]
```

Die einzige Einschränkung, die **include** beachten muss, besteht darin, dass der Inhalt der eingebundenen Datei an der Stelle der Einbindung gültig sein muss. Das heißt, eine Datei, die vor **toc_begin** eingebunden wird, darf nur die Vorlagenbefehle **vset** und **include** enthalten; eine Datei, die in einen Abschnitt eingebunden wird, darf nur Befehle für Elemente oder Abschnitte enthalten usw.

## Escapes

Neben den bisher gezeigten sechs Befehlen stehen uns zwei weitere zur Verfügung. Ihre Funktion besteht jedoch nicht in der Markierung der Inhaltsverzeichnisstruktur, sondern im Einfügen von Zeichen, nämlich **\[** und **\]**. Diese Befehle, nämlich **lb** bzw. **rb**, sind erforderlich, da unsere Verwendung von \[ und \] zur Einfassung von Markup-Befehlen die direkte Verwendung von \[ und \] innerhalb des Textes unmöglich macht.

Als Beispiel für ihre Verwendung dient der Quelltext des letzten Satzes im vorangegangenen Absatz, wobei einige Stellen hervorgehoben wurden.

```
  ...
  These commands, [cmd lb] and [cmd lb] respectively, are required
  because our use of [lb] and [rb] to bracket markup commands makes it
  impossible to directly use [lb] and [rb] within the text.
  ...
```

# WEITERFÜHRENDE LITERATUR

Nachdem der Leser dieses Dokument verinnerlicht hat – wobei davon ausgegangen wird, dass es sich um einen *Verfasser* von Dokumentationen handelt –, sollte er nun ausreichend gerüstet sein, um auch die formale *Syntaxspezifikation der Sprache doctoc* zu verstehen. Von nun an dient die *Befehlsreferenz der Sprache doctoc* zudem als detaillierte Spezifikation und Spickzettel für alle verfügbaren Befehle und deren Syntax.

Um ein Dokument bereits während der Erstellung validieren zu können, empfiehlt es sich zudem, sich mit dem äußerst flexibel konfigurierbaren **dtp** von Tclapps vertraut zu machen.

Andererseits eignet sich doctoc hervorragend für die automatische Generierung aus doctools-Dokumenten, und genau diesen Weg beschreitet das benutzerfreundliche und einfache **dtplite** von Tcllib, das hinter den Kulissen ein Inhaltsverzeichnis für eine Reihe von Dokumenten erstellt, ohne dass der Verfasser dies selbst tun muss.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
