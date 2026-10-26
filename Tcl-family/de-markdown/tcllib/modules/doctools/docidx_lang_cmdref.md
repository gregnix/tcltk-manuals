---
CommandName: docidx_lang_cmdref
title: docidx_lang_cmdref
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - docidx_lang_faq
 - docidx_lang_intro
 - docidx_lang_syntax
Keywords:
 - docidx commands
 - docidx language
 - docidx markup
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

docidx\_lang\_cmdref – docidx-Sprachbefehlsreferenz

# Übersicht

::: {.synopsis} :::
[comment]{.cmd} [plaintext]{.arg}
[include]{.cmd} [filename]{.arg}
[index\_begin]{.cmd} [text]{.arg} [title]{.arg}
[index\_end]{.cmd}
[key]{.cmd} [text]{.arg}
[lb]{.cmd}
[manpage]{.cmd} [file]{.arg} [text]{.arg}
[rb]{.cmd}
[url]{.cmd} [url]{.arg} [label]{.arg}
[vset]{.cmd} [varname]{.arg} [value]{.arg}
[vset]{.cmd} [varname]{.arg}
:::

# Beschreibung

Dieses Dokument legt sowohl die Namen als auch die Syntax aller Befehle fest, die zusammen die Markup-Sprache „docidx“, Version 1, bilden. Da dieses Dokument als Nachschlagewerk gedacht ist, sind die Befehle in alphabetischer Reihenfolge aufgeführt, und die Beschreibungen sind relativ kurz gehalten. Anfängern wird empfohlen, zunächst die wesentlich informeller verfasste *Einleitung in die Sprache docidx* zu lesen.

# Befehle

**comment** *plaintext*
: Indexauszeichnung. Der Text des Arguments wird als Kommentar markiert, der außerhalb des eigentlichen Dokumenttextes steht. Die Hauptverwendung liegt bei freiformigem Text.

**include** *filename*
: Vorlagen. Der Inhalt der genannten Datei wird als Text im docidx-Markup interpretiert und anstelle des Include-Befehls verarbeitet. Das Markup in der Datei muss in sich geschlossen sein. Ein Markup-Befehl kann die Dateigrenzen nicht überschreiten.

**index\_begin** *text* *title*
: Dokumentstruktur. Der Befehl zum Beginnen eines Indexes. Die Argumente sind eine Bezeichnung für die gesamte Gruppe von Dokumenten, auf die sich der Index bezieht (*text*), sowie der übergreifende Titeltext für den Index (*title*), ohne Markup.

    Die Bezeichnung ist häufig der Name des Pakets (oder der Erweiterung), zu dem die Dokumente gehören.

**index\_end**
: Dokumentstruktur. Befehl zum Beenden eines Indexes. Alles, was in diesem Dokument nach diesem Befehl folgt, ist ein Fehler.

**key** *text*
: Indexstruktur. Dieser Befehl fügt das Schlüsselwort *text* in den Index ein.

**lb**
: Text. Der Befehl wird durch eine öffnende eckige Klammer ersetzt. Verwendung in freiformigem Text. Erforderlich, um zu verhindern, dass eine öffnende eckige Klammer als Beginn eines Markup-Befehls interpretiert wird. Die Verwendung ist auf die Argumente anderer Markup-Befehle beschränkt.

**manpage** *file* *text*
: Indexstruktur. Dieser Befehl fügt dem Index ein Element hinzu, das auf ein Dokument verweist. Das Dokument wird über den symbolischen Namen *file* angegeben. Das Argument *text* dient zur Beschriftung des Verweises.

    Symbolische Namen werden verwendet, um die Konvertierbarkeit dieses Formats in jedes beliebige Ausgabeformat zu gewährleisten. Der tatsächliche Name der Datei wird bei der Konvertierung der Eingabe durch die gewählte Formatierungs-Engine eingefügt. Dies erfolgt auf der Grundlage einer Zuordnung von symbolischen zu tatsächlichen Namen, die der Engine bereitgestellt wird.

**rb**
: Text. Der Befehl wird durch eine schließende eckige Klammer ersetzt. Verwendung in freiformigem Text. Erforderlich, um zu verhindern, dass eine schließende eckige Klammer als Ende eines Markup-Befehls interpretiert wird. Die Verwendung ist auf die Argumente anderer Befehle beschränkt.

**url** *url* *label*
: Indexstruktur. Dies ist der zweite Befehl zum Hinzufügen eines Elements zum Index. Um auf ein Dokument zu verweisen, wird jedoch kein symbolischer Name verwendet, sondern eine (möglicherweise formatspezifische) URL, die den genauen Ort des hier indizierten Dokuments beschreibt.

**vset** *varname* *value*
: Vorlagen. In dieser Form setzt der Befehl die benannte Dokumentvariable auf den angegebenen *value*. Es wird keine Ausgabe erzeugt. Das heißt, der Befehl wird durch die leere Zeichenkette ersetzt.

**vset** *varname*
: Vorlagen. In dieser Form wird der Befehl durch den Wert der benannten Dokumentvariablen ersetzt


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
