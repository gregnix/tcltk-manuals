---
CommandName: doctools_lang_intro
title: doctools_lang_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - doctools_intro
 - doctools_lang_cmdref
 - doctools_lang_faq
 - doctools_lang_syntax
Keywords:
 - doctools commands
 - doctools language
 - doctools markup
 - doctools syntax
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools\_lang\_intro – Einleitung in die Sprache „doctools“

# Beschreibung

Dieses Dokument bietet anhand zahlreicher Beispiele eine informelle Einleitung in Version 1 der doctools-Markup-Sprache. Nach der Lektüre dieses Dokuments sollten Autoren in der Lage sein, die beiden Teile der formalen Spezifikation zu verstehen, nämlich die Spezifikation der *doctools-Sprachsyntax* und die *doctools-Befehlsreferenz*.

## Grundlagen

Im weitesten Sinne ähnelt die *doctools-Auszeichnungssprache* eher LaTeX als SGML und ähnlichen Sprachen. Ein in dieser Sprache verfasstes Dokument besteht in erster Linie aus Text, in den Auszeichnungsbefehle eingebettet sind.

Jeder Markup-Befehl ist ein Tcl-Befehl, der von einem passenden Paar aus **\[** und **\]** umgeben ist. Innerhalb dieser Begrenzungszeichen gelten die üblichen Regeln für einen Tcl-Befehl hinsichtlich Wortanführungszeichen, verschachtelter Befehle, Fortsetzungszeilen usw. Das heißt:

```
  ... [list_begin enumerated] ...
```

```
  ... [call [cmd foo] \
          [arg bar]] ...
```

```
  ... [term {complex concept}] ...
```

```
  ... [opt "[arg key] [arg value]"] ...
```

## Grundlegender Aufbau

Das einfachste Dokument, das mit doctools erstellt werden kann, ist

```
    [manpage_begin NAME SECTION VERSION]
[see_also doctools_intro]
[see_also doctools_lang_cmdref]
[see_also doctools_lang_faq]
[see_also doctools_lang_syntax]
[keywords {doctools commands}]
[keywords {doctools language}]
[keywords {doctools markup}]
[keywords {doctools syntax}]
[keywords markup]
[keywords {semantic markup}]
    [description]
    [vset CATEGORY doctools]
[include ../common-text/feedback.inc]
[manpage_end]
```

Dies zeigt uns zudem, dass alle doctools-Dokumente in zwei Teile unterteilt sind: den *Kopf* und den *Hauptteil*. Alles, was vor \[[description][doctools_lang_cmdref]\] steht, gehört zum Kopf, und alles, was danach folgt, gehört zum Hauptteil, wobei das gesamte Dokument von den beiden Befehlen **manpage\_\*** eingerahmt wird. Vor und nach diesen öffnenden und schließenden Befehlen befindet sich lediglich *Leerraum*.

Im weiteren Verlauf dieses Abschnitts werden wir uns ausschließlich mit dem Inhalt des Kopfs befassen; die Struktur des Hauptteils wird im Abschnitt [Textstruktur] behandelt.

Der Kopfbereich kann leer sein; andernfalls darf er lediglich eine beliebige Abfolge der vier sogenannten *Kopf*-Befehle sowie *Leerraum* enthalten. Diese Befehle lauten

- [titledesc][doctools_lang_cmdref]
- [moddesc][doctools_lang_cmdref]
- [require][doctools_lang_cmdref]
- [copyright][doctools_lang_cmdref]


Sie liefern über ihre Argumente zusätzliche Informationen zum Dokument, wie beispielsweise dessen Titel, den Titel der größeren Gruppe, zu der das Dokument gehört (falls zutreffend), die Anforderungen der dokumentierten Pakete (falls zutreffend) sowie Urheberrechtsvermerke. Alle diese Angaben können mehrfach vorkommen – oder auch gar nicht – und in beliebiger Reihenfolge verwendet werden. Bei [titledesc][doctools_lang_cmdref] und [moddesc][doctools_lang_cmdref] wird jedoch nur das letzte Vorkommen berücksichtigt. Bei den beiden anderen werden die angegebenen Informationen in der angegebenen Reihenfolge kumuliert. Normaler Text ist innerhalb des Kopfs nicht zulässig.

Vor diesem Hintergrund lautet ein weniger minimales Beispiel für ein Dokument:

```
[manpage_begin NAME SECTION VERSION]
[copyright {YEAR AUTHOR}]
[titledesc TITLE]
[moddesc   MODULE_TITLE]
[require   PACKAGE VERSION]
[require   PACKAGE]
[description]
[manpage_end]
```

Zu beachten ist, dass der Leerraum optional ist. Das Dokument

```
    [manpage_begin NAME SECTION VERSION]
    [copyright {YEAR AUTHOR}][titledesc TITLE][moddesc MODULE_TITLE]
    [require PACKAGE VERSION][require PACKAGE][description]
    [vset CATEGORY doctools]
[include ../common-text/feedback.inc]
[manpage_end]
```

hat dieselbe Bedeutung wie das vorherige Beispiel.

Wenn hingegen *Leerraum* vorhanden ist, besteht er nicht nur aus einer beliebigen Folge der Zeichen Leerzeichen, horizontaler und vertikaler Tabulator, Wagenrücklauf und Zeilenumbruch, sondern kann auch Kommentar-Markup in Form des Befehls [comment][docidx_lang_cmdref] enthalten.

```
[comment { ... }]
[manpage_begin NAME SECTION VERSION]
[copyright {YEAR AUTHOR}]
[titledesc TITLE]
[moddesc   MODULE_TITLE][comment { ... }]
[require   PACKAGE VERSION]
[require   PACKAGE]
[description]
[manpage_end]
[comment { ... }]
```

## Erweiterte Struktur

In den einfachen Beispielen des letzten Abschnitts waren wir hinsichtlich des Markups, das tatsächlich vor dem Befehl **manpage\_begin** zum Öffnen des Dokuments verwendet werden darf, etwas ungenau.

Anstelle von reinen Leerzeichen sind auch die beiden Vorlagenbefehle [include][docidx_lang_cmdref] und [vset][docidx_lang_cmdref] zulässig, damit der Verfasser dokumentrelevante Konfigurationseinstellungen festlegen und/oder importieren kann. Das heißt, es ist möglich, Folgendes zu schreiben:

```
[include FILE]
[vset VAR VALUE]
[manpage_begin NAME SECTION VERSION]
[description]
[manpage_end]
```

Noch wichtiger ist, dass diese beiden Befehle überall dort zulässig sind, wo ein Markup-Befehl zulässig ist, unabhängig von jeglicher anderen Struktur. Das heißt, beispielsweise auch im Kopfbereich.

```
[manpage_begin NAME SECTION VERSION]
[include FILE]
[vset VAR VALUE]
[description]
[manpage_end]
```

Die einzige Einschränkung, die [include][docidx_lang_cmdref] beachten muss, besteht darin, dass der Inhalt der eingebundenen Datei an der Stelle der Einbindung gültig sein muss. Das heißt, eine Datei, die vor **manpage\_begin** eingebunden wird, darf nur die Template-Befehle [vset][docidx_lang_cmdref] und [include][docidx_lang_cmdref] enthalten; eine in den Kopf eingebundene Datei darf nur Kopfbefehle enthalten usw.

## Textstruktur

Der Hauptteil des Dokuments besteht hauptsächlich aus Text, der möglicherweise in Abschnitte, Unterabschnitte und Absätze unterteilt ist, wobei bestimmte Teile zur Hervorhebung verschiedener semantischer Textkategorien markiert sind und durch die Verwendung von Beispielen und (verschachtelten) Listen eine zusätzliche Struktur entsteht.

In diesem Abschnitt werden die übergeordneten Strukturbefehle erläutert; alle weiteren Aspekte werden in den folgenden Abschnitten behandelt.

Die einfachste Möglichkeit, den Haupttext zu gliedern, ist die Einfügung von Absätzen. Der entsprechende Befehl lautet [para][doctools_lang_cmdref]. Jedes Auftreten dieses Befehls schließt den vorherigen Absatz und eröffnet automatisch den nächsten. Der erste Absatz wird am Anfang des Haupttextes automatisch durch den Befehl [description][doctools_lang_cmdref] eröffnet. Auf dieselbe Weise endet der letzte Absatz automatisch mit dem Befehl **manpage\_end**.

```
[manpage_begin NAME SECTION VERSION]
[description]
 ...
[para]
 ...
[para]
 ...
[manpage_end]
```

Leere Absätze werden ignoriert.

Eine Struktur, die grober gegliedert ist als Absätze, sind Abschnitte, die es dem Verfasser ermöglichen, ein Dokument in größere, beschriftete Teile zu unterteilen. Der Befehl hierfür lautet **section**. Jedes Auftreten dieses Befehls schließt den vorherigen Abschnitt und eröffnet automatisch den nächsten, einschließlich dessen ersten Absatzes. Der erste Abschnitt wird am Anfang des Haupttextes automatisch durch den Befehl [description][doctools_lang_cmdref] eröffnet (dieser Abschnitt trägt die Bezeichnung „DESCRIPTION“). Auf dieselbe Weise endet der letzte Abschnitt automatisch mit dem Befehl **manpage\_end**.

Leere Abschnitte werden *nicht* ignoriert. Es steht uns frei, innerhalb von Abschnitten Absätze zu verwenden oder darauf zu verzichten.

```
[manpage_begin NAME SECTION VERSION]
[description]
 ...
[section {Section A}]
 ...
[para]
 ...
[section {Section B}]
 ...
[manpage_end]
```

Zwischen Abschnitten und Absätzen befinden sich Unterabschnitte, um Abschnitte zu unterteilen. Der Befehl hierfür lautet [subsection][doctools_lang_cmdref]. Jedes Vorkommen dieses Befehls schließt den vorherigen Unterabschnitt und eröffnet automatisch den nächsten, einschließlich dessen ersten Absatzes. Ein Unterabschnitt wird automatisch am Anfang des Haupttextes durch den Befehl [description][doctools_lang_cmdref] sowie am Anfang jedes Abschnitts eröffnet. Ebenso endet der letzte Unterabschnitt automatisch mit dem Befehl **manpage\_end**.

Leere Unterabschnitte werden *nicht* ignoriert. Es steht uns frei, innerhalb von Unterabschnitten Absätze zu verwenden oder darauf zu verzichten.

```
[manpage_begin NAME SECTION VERSION]
[description]
 ...
[section {Section A}]
 ...
[subsection {Sub 1}]
 ...
[para]
 ...
[subsection {Sub 2}]
 ...
[section {Section B}]
 ...
[manpage_end]
```

## Textmarkierung

Nachdem wir uns mit der Gesamtstruktur befasst haben, die ein Autor dem Dokument auferlegen kann, wollen wir uns nun den Text innerhalb eines Absatzes genauer ansehen.

Zwar handelt es sich dabei meist lediglich um den schmucklosen Inhalt des Dokuments, doch gibt es Fälle, in denen wir bestimmte Teile davon als eine bestimmte Art von Sache hervorheben möchten, wie beispielsweise Befehlsargumente, Befehlsnamen, Konzepte, URIs usw.

Hierfür steht uns eine Reihe von Markup-Befehlen zur Verfügung, die den hervorzuhebenden Text als einziges Argument entgegennehmen. Es sei darauf hingewiesen, dass diese Befehle zwar in erster Linie zum Hervorheben von Teilen eines Absatzes dienen, jedoch auch zur Markierung der Argumente von Listenelement-Befehlen und anderer Markup-Befehle verwendet werden können.

Die uns zur Verfügung stehenden Befehle sind

**arg**
: Sein Argument ist der Name eines Befehlsarguments.

**class**
: Sein Argument ist der Name einer Klasse.

[cmd][doctools_lang_cmdref]
: Sein Argument ist ein Befehlsname (Tcl-Befehl).

[const][doctools_lang_cmdref]
: Sein Argument ist eine Konstante.

[emph][doctools_lang_cmdref]
: Allgemeine, nicht-semantische Betonung.

**file**
: Als Argument wird ein Dateiname bzw. ein Pfad übergeben.

[fun][doctools_lang_cmdref]
: Sein Argument ist ein Funktionsname.

**method**
: Sein Argument ist der Name einer Methode

[namespace][doctools_lang_cmdref]
: Sein Argument ist der Name des Namespaces.

[opt][doctools_lang_cmdref]
: Sein Argument ist ein optionales Syntaxelement.

**option**
: Sein Argument ist ein Befehlszeilenschalter bzw. eine Widget-Option.

**package**
: Sein Argument ist der Name eines Pakets.

[sectref][doctools_lang_cmdref]
: Sein Argument ist der Titel eines Abschnitts oder Unterabschnitts, d. h. ein Verweis auf einen Abschnitt.

[syscmd][doctools_lang_cmdref]
: Als Argument wird der Name eines Befehls (externer Systembefehl) übergeben.

[term][doctools_lang_cmdref]
: Sein Argument ist ein Begriff oder eine allgemeine Bezeichnung.

**type**
: Sein Argument ist ein Typname.

**uri**
: Sein Argument ist ein Uniform Resource Identifier, d. h. ein externer Verweis. Mit einem zweiten Argument kann eine explizite Bezeichnung für den betreffenden Verweis angegeben werden.

[usage][doctools_lang_cmdref]
: Die Argumente beschreiben die Syntax eines Tcl-Befehls.

[var][doctools_lang_cmdref]
: Sein Argument ist eine Variable.

**widget**
: Als Argument wird der Name eines Widgets übergeben.


Das Beispiel zur Veranschaulichung der Verwendung von Textmarkierungen ist ein Auszug aus der *doctools-Sprachbefehlsreferenz*, wobei einige Stellen hervorgehoben wurden. Es zeigt deren Verwendung innerhalb eines Textblocks, als Argumente eines Befehls für Listenelemente ([call][doctools_lang_cmdref]) sowie die Möglichkeit, diese zu verschachteln.

```
  ...
  [call [cmd arg_def] [arg type] [arg name] [opt [arg mode]]]

  Text structure. List element. Argument list. Automatically closes the
  previous list element. Specifies the data-[arg type] of the described
  argument of a command, its [arg name] and its i/o-[arg mode]. The
  latter is optional.
  ...
```

## Escapes

Neben den 20 Befehlen für einfache Auszeichnung, die im vorigen Abschnitt vorgestellt wurden, stehen zwei weitere zur Verfügung, bei denen es sich technisch gesehen ebenfalls um einfache Auszeichnung handelt. Ihre Funktion besteht jedoch nicht darin, Phrasen als bestimmte Arten von Dingen zu markieren, sondern Zeichen einzufügen, nämlich **\[** und **\]**. Diese Befehle, nämlich [lb][docidx_lang_cmdref] bzw. [rb][docidx_lang_cmdref], sind erforderlich, da unsere Verwendung von \[ und \] zur Einfassung von Markup-Befehlen die direkte Verwendung von \[ und \] innerhalb des Textes unmöglich macht.

Als Beispiel für ihre Verwendung dient der Quelltext des letzten Satzes im vorangegangenen Absatz, wobei einige Stellen hervorgehoben wurden.

```
  ...
  These commands, [cmd lb] and [cmd lb] respectively, are required
  because our use of [lb] and [rb] to bracket markup commands makes it
  impossible to directly use [lb] and [rb] within the text.
  ...
```

## Querverweise

Die letzten beiden Befehle, die wir noch behandeln müssen, dienen der Deklaration von Querverweisen zwischen Dokumenten – sowohl expliziten als auch impliziten. Es handelt sich dabei um [keywords][doctools_lang_cmdref] und **see\_also**. Beide akzeptieren eine beliebige Anzahl von Argumenten, die alle aus einfachem, unmarkiertem Text bestehen müssen. Das heißt, es ist nicht zulässig, Markup-Elemente darin zu verwenden. Beide Befehle können in einem Dokument mehrfach verwendet werden. In diesem Fall werden alle Argumente aller Vorkommen eines der beiden Befehle zu einer einzigen Menge zusammengefasst.

[keywords][doctools_lang_cmdref]
: Die Argumente dieses Befehls werden als Schlüsselwörter interpretiert, die das Dokument beschreiben. Ein Prozessor kann diese Informationen nutzen, um einen Index zu erstellen, der das betreffende Dokument indirekt mit allen Dokumenten verknüpft, die dieselben Schlüsselwörter enthalten.

[see\_also][doctools_lang_cmdref]
: Die Argumente dieses Befehls werden als Verweise auf andere Dokumente interpretiert. Ein Prozessor kann sie als direkte Links zu diesen Dokumenten formatieren.


Alle Querverweis-Befehle können an beliebiger Stelle im Dokument zwischen **manpage\_begin** und **manpage\_end** vorkommen. Somit kann die Verfasserin entscheiden, ob sie diese am Anfang des Hauptteils oder an dessen Ende platzieren möchte, vielleicht in der Nähe der Stelle, an der ein Schlüsselwort im Hauptinhalt tatsächlich definiert wird, oder ob sie sie als Metadaten betrachtet, die im Kopf stehen sollten, usw.

Unser Beispiel zeigt den Quelltext der Querverweise dieses Dokuments, wobei einige Stellen hervorgehoben wurden. Sie befinden sich übrigens am Ende des Hauptteils.

```
  ...
  [see_also doctools_intro]
  [see_also doctools_lang_syntax]
  [see_also doctools_lang_cmdref]
  [keywords markup {semantic markup}]
  [keywords {doctools markup} {doctools language}]
  [keywords {doctools syntax} {doctools commands}]
  [manpage_end]
```

## Beispiele

Überall dort, wo wir einfachen Text eingeben können, können wir auch Beispiele eingeben. Für einfache Beispiele steht uns der Befehl **example** zur Verfügung, der ein einziges Argument erwartet, nämlich den Text des Arguments. Der Beispieltext darf keine Markups enthalten. Wenn wir Markups innerhalb eines Beispiels verwenden möchten, müssen wir stattdessen die Kombination aus den beiden Befehlen **example\_begin** / **example\_end** verwenden.

Der erste Befehl öffnet einen Beispielblock, der andere schließt ihn, und dazwischen können wir einfachen Text schreiben und alle üblichen Befehle zur Textauszeichnung verwenden. Zu beachten ist, dass Befehle zur Textstruktur nicht zulässig sind. Dies bedeutet auch, dass es nicht möglich ist, Beispiele und Listen innerhalb eines Beispiels einzubetten. Andererseits *können* wir innerhalb von Beispielblöcken Template-Befehle verwenden, um deren Inhalt aus einer Datei zu lesen (siehe Abschnitt [Erweiterte Struktur]).

Die Quelle für das allererste Beispiel in diesem Dokument (siehe Abschnitt [Grundlagen]), mit einigen Hervorhebungen, lautet:

```
  [example {
    ... [list_begin enumerated] ...
  }]
```

Bei Verwendung von **example\_begin** / **example\_end** würde dies wie folgt aussehen:

```
  [example_begin]
    ... [list_begin enumerated] ...
  [example_end]
```

## Listen

Überall dort, wo wir einfachen Text schreiben können, können wir auch Listen schreiben. Die wichtigsten Befehle sind **list\_begin** zum Starten einer Liste und **list\_end** zum Schließen einer Liste. Der eröffnende Befehl nimmt ein Argument entgegen, das den Typ der begonnenen Liste festlegt; dies bestimmt wiederum, welche der acht vorhandenen Listenelement-Befehle innerhalb der Liste zum Beginnen von Listenelementen zulässig sind.

Nach dem Eröffnungsbefehl ist nur Leerraum zulässig, bis der erste Listenelement-Befehl das erste Element der Liste eröffnet. Jedes Element ist eine reguläre Folge von Absätzen und wird entweder durch den nächsten Listenelement-Befehl oder durch das Ende der Liste geschlossen. Wird es durch einen Listenelement-Befehl geschlossen, eröffnet dieser Befehl automatisch das nächste Listenelement. Da ein Listenelement eine Folge von Absätzen ist, kann innerhalb eines Listenelements die gesamte reguläre Textauszeichnung verwendet werden, einschließlich Beispielen und weiterer Listen.

Die von **list\_begin** unterstützten Listentypen und die zugehörigen Befehle für Listenelemente lauten wie folgt:

**arguments**
: (**arg\_def**) Hiermit wird eine *Argumentliste (Deklaration)* geöffnet. Es handelt sich um eine spezielle Form einer Begriffsdefinitionsliste, bei der der Begriff ein Argumentname ist, zusammen mit seinem Typ und seinem E/A-Modus.

**commands**
: (**cmd\_def**) Hiermit wird eine *Befehlsliste (Deklaration)* geöffnet. Es handelt sich um eine spezielle Form einer Begriffsdefinitionsliste, bei der der Begriff ein Befehlsname ist.

**definitions**
: ([def][doctools_lang_cmdref] und [call][doctools_lang_cmdref]) Hiermit wird eine allgemeine *Liste der Begriffsdefinitionen* geöffnet. Die durch die Listenelemente definierten Begriffe werden über die Argumente der Listenelement-Befehle festgelegt; dabei handelt es sich entweder um allgemeine Begriffe, gegebenenfalls mit Markup ([def][doctools_lang_cmdref]), oder um Tcl-Befehle mit ihrer Syntax ([call][doctools_lang_cmdref]).

**enumerated**
: ([enum][doctools_lang_cmdref]) Hiermit wird eine allgemeine *nummerierte Liste* geöffnet.

**itemized**
: ([item][doctoc_lang_cmdref]) Hiermit wird eine allgemeine *Auflistung* geöffnet.

**options**
: (**opt\_def**) Hiermit wird eine *Optionsliste (Deklaration)* geöffnet. Es handelt sich um eine spezielle Form einer Begriffsdefinitionsliste, bei der der Begriff ein Optionsname ist, gegebenenfalls zusammen mit den Argumenten der Option.

**tkoptions**
: (**tkoption\_def**) Hiermit wird eine *Widget-Optionsliste (Deklaration)* geöffnet. Es handelt sich um eine spezielle Form einer Begriffsdefinitionsliste, bei der der Begriff der Name einer Konfigurationsoption für ein Widget ist, mit seinem Namen und seiner Klasse in der Optionsdatenbank.


Unser Beispiel ist der Quelltext der Definitionsliste im vorigen Absatz, wobei der größte Teil des Inhalts in der Mitte entfernt wurde.

```
  ...
  [list_begin definitions]
  [def [const arg]]

  ([cmd arg_def]) This opens an argument (declaration) list. It is a
  specialized form of a definition list where the term is an argument
  name, with its type and i/o-mode.

  [def [const itemized]]

  ([cmd item])
  This opens a general itemized list.

  ...
  [def [const tkoption]]

  ([cmd tkoption_def]) This opens a widget option (declaration) list. It
  is a specialized form of a definition list where the term is the name
  of a configuration option for a widget, with its name and class in the
  option database.

  [list_end]
  ...
```

Hinweis: Eine Liste darf nicht in einem (Unter-)Abschnitt beginnen und in einem anderen enden. Anders gesagt: Wechsel des (Unter-)Abschnitts sind innerhalb von Listen und Listenelementen nicht zulässig. Ein Beispiel für dieses *unzulässige* Konstrukt ist

```
  ...
  [list_begin itemized]
  [item]
  ...
  [section {ILLEGAL WITHIN THE LIST}]
  ...
  [list_end]
  ...
```

# Weiterführende Literatur

Nachdem der Leser dieses Dokument verinnerlicht hat – wobei davon ausgegangen wird, dass es sich um einen *Verfasser* von Dokumentationen handelt –, sollte er nun ausreichend gerüstet sein, um auch die formale Spezifikation der *doctools-Sprachsyntax* zu verstehen. Von nun an dient die *doctools-Sprachbefehlsreferenz* zudem als detaillierte Spezifikation und Spickzettel für alle verfügbaren Befehle und deren Syntax.

Um ein Dokument bereits während der Erstellung validieren zu können, empfiehlt es sich zudem, sich mit einer der Anwendungen zur Verarbeitung und Konvertierung von doctools-Dokumenten vertraut zu machen, das heißt entweder mit dem benutzerfreundlichen und einfachen **dtplite** von Tcllib oder mit dem äußerst flexibel konfigurierbaren **dtp** von Tclapps.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dokumentationswerkzeuge

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[docidx_lang_cmdref]: docidx_lang_cmdref.md
[doctoc_lang_cmdref]: doctoc_lang_cmdref.md
[doctools_lang_cmdref]: doctools_lang_cmdref.md
