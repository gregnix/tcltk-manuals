---
CommandName: doctoc_lang_cmdref
title: doctoc_lang_cmdref
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - doctoc_intro
 - doctoc_lang_faq
 - doctoc_lang_intro
 - doctoc_lang_syntax
Keywords:
 - doctoc commands
 - doctoc language
 - doctoc markup
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctoc\_lang\_cmdref – doctoc-Sprachbefehlsreferenz

# Übersicht

::: {.synopsis} :::
[comment]{.cmd} [plaintext]{.arg}
[division\_end]{.cmd}
[division\_start]{.cmd} [text]{.arg} [symfile]{.optarg}
[include]{.cmd} [filename]{.arg}
[item]{.cmd} [file]{.arg} [text]{.arg} [desc]{.arg}
[lb]{.cmd}
[rb]{.cmd}
[toc\_begin]{.cmd} [text]{.arg} [title]{.arg}
[toc\_end]{.cmd}
[vset]{.cmd} [varname]{.arg} [value]{.arg}
[vset]{.cmd} [varname]{.arg}
:::

# Beschreibung

Dieses Dokument legt sowohl die Namen als auch die Syntax aller Befehle fest, die zusammen die doctoc-Markup-Sprache, Version 1, bilden. Da dieses Dokument als Nachschlagewerk gedacht ist, sind die Befehle in alphabetischer Reihenfolge aufgeführt, und die Beschreibungen sind relativ kurz gehalten. Anfängern wird empfohlen, zunächst die wesentlich informeller verfasste *Einleitung in die doctoc-Sprache* zu lesen.

# Befehle

**comment** *plaintext*
: Auszeichnung des Inhaltsverzeichnisses. Der Text des Arguments wird als Kommentar markiert, der außerhalb des eigentlichen Dokumenttextes steht. Die Hauptverwendung liegt bei freiformigem Text.

**division\_end**
: Inhaltsverzeichnisstruktur. Dieser Befehl schließt den Abschnitt, der durch den letzten, ihm vorausgehenden und noch nicht geschlossenen **division\_begin**-Befehl geöffnet wurde.

**division\_start** *text* ?*symfile*?
: Inhaltsverzeichnisstruktur. Dieser Befehl eröffnet einen Abschnitt im Inhaltsverzeichnis. Sein Gegenstück ist **division\_end**. Gemeinsam ermöglichen sie es einem Benutzer, einem Inhaltsverzeichnis eine zusätzliche Struktur zu verleihen.

    Der Titel des neuen Abschnitts wird durch das Argument *text* angegeben.

    Wenn der symbolische Dateiname *symfile* vorhanden ist, soll der Abschnittstitel auf das referenzierte Dokument verweisen, sofern das Ausgabeformat Verweise unterstützt.

**include** *filename*
: Vorlagen. Der Inhalt der genannten Datei wird als Text im doctoc-Markup interpretiert und anstelle des Include-Befehls verarbeitet. Das Markup in der Datei muss in sich geschlossen sein. Ein Markup-Befehl kann die Dateigrenzen nicht überschreiten.

**item** *file* *text* *desc*
: Inhaltsverzeichnisstruktur. Dieser Befehl fügt dem Inhaltsverzeichnis ein einzelnes Element hinzu. Jedes dieser Elemente verweist auf ein Dokument. Das Dokument wird über den symbolischen Namen *file* angegeben. Das Argument *text* dient zur Beschriftung des Verweises, während *desc* einen kurzen beschreibenden Text zu diesem Dokument liefert.

    Die symbolischen Namen werden verwendet, um die Konvertierbarkeit dieses Formats in jedes beliebige Ausgabeformat zu gewährleisten. Der tatsächliche Name der Datei wird bei der Konvertierung der Eingabe durch die gewählte Formatierungs-Engine eingefügt. Dies erfolgt auf der Grundlage einer Zuordnung von symbolischen zu tatsächlichen Namen, die der Engine bereitgestellt wird.

**lb**
: Text. Der Befehl wird durch eine öffnende eckige Klammer ersetzt. Verwendung in freiformigem Text. Erforderlich, um zu verhindern, dass eine öffnende eckige Klammer als Beginn eines Markup-Befehls interpretiert wird. Die Verwendung ist auf die Argumente anderer Markup-Befehle beschränkt.

**rb**
: Text. Der Befehl wird durch eine schließende eckige Klammer ersetzt. Verwendung in freiformigem Text. Erforderlich, um zu verhindern, dass eine schließende eckige Klammer als Ende eines Markup-Befehls interpretiert wird. Die Verwendung ist auf die Argumente anderer Befehle beschränkt.

**toc\_begin** *text* *title*
: Dokumentstruktur. Der Befehl zum Beginnen eines Inhaltsverzeichnisses. Die Argumente sind eine Bezeichnung für die gesamte Gruppe von Dokumenten, auf die sich das Inhaltsverzeichnis bezieht (*text*), sowie der übergreifende Titeltext für das Inhaltsverzeichnis (*title*), ohne Markup.

    Die Bezeichnung ist häufig der Name des Pakets (oder der Erweiterung), zu dem die Dokumente gehören.

**toc\_end**
: Dokumentstruktur. Befehl zum Beenden eines Inhaltsverzeichnisses. Alles, was im Dokument nach diesem Befehl folgt, ist ein Fehler.

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
