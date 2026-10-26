---
CommandName: doctools::changelog
ManualSection: n
Version: 1.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - changelog
 - doctools
 - emacs
Copyright:
 - Copyright (c) 2003-2013 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::changelog – Verarbeitung von Text im Emacs-ChangeLog-Format

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::changelog]{.lit} [1.2]{.optlit} 
[::doctools::changelog::scan]{.cmd} [text]{.arg} 
[::doctools::changelog::flatten]{.cmd} [entries]{.arg} 
[::doctools::changelog::toDoctools]{.cmd} [title]{.arg} [module]{.arg} [version]{.arg} [entries]{.arg} 
[::doctools::changelog::merge]{.cmd} [entries...]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Tcl-Befehle zur Verarbeitung und Neuformatierung von Text im „*ChangeLog*“-Format, das von **emacs** erzeugt wird.

# API

**::doctools::changelog::scan** *text*
: Der Befehl nimmt den *text* und parst ihn unter der Annahme, dass er ein von **emacs** erzeugtes ChangeLog enthält. Er gibt eine Datenstruktur zurück, die den Inhalt dieses ChangeLogs beschreibt. Diese Datenstruktur ist eine Liste, in der jedes Element einen Eintrag im ChangeLog beschreibt. Jedes Element bzw. jeder Eintrag ist wiederum eine Liste aus drei Elementen, die in dieser Reihenfolge das Datum des Eintrags, dessen Autor und die abgegebenen Kommentare beschreiben. Das letzte Element jedes Eintrags, die Kommentare, ist eine Liste von Abschnitten. Jeder Abschnitt wird durch eine Liste beschrieben, die zwei Elemente enthält: eine Liste von Dateinamen und eine Zeichenkette mit dem eigentlichen Kommentar, der zu den Dateien des Abschnitts gehört.


```
    {
	{
	    date
	    author
	    {
		{
		    {file ...}
		    commenttext
		}
		...
	    }
	}
	{...}
    }
```

**::doctools::changelog::flatten** *entries*
: Dieser Befehl wandelt eine Liste von Einträgen, wie sie oben von **change::scan** generiert wurde, in eine einfachere Liste aus Klartextblöcken um, die jeweils alle Informationen eines einzelnen Eintrags enthalten.

**::doctools::changelog::toDoctools** *title* *module* *version* *entries*
: Dieser Befehl wandelt die vom Befehl **::doctools::changelog::scan** generierten, bereits geparsten *entries* des ChangeLog in ein Dokument im *doctools*-Format um und gibt dieses als Ergebnis des Befehls zurück. Die anderen drei Argumente liefern die Informationen für den Kopf dieses Dokuments, die im ChangeLog selbst nicht enthalten sind.

**::doctools::changelog::merge** *entries*...
: Jedes Argument des Befehls wird als vorab geparstes Changelog angesehen, wie es vom Befehl **::doctools::changelog::scan** generiert wurde. Dieser Befehl führt sie alle zu einer einzigen Struktur zusammen und fasst mehrere Einträge mit demselben Datum und demselben Autor zu einem einzigen Eintrag zusammen. Die neue Struktur wird vom Befehl zurückgegeben.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2003-2013 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
