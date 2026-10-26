---
CommandName: doctools_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - doctoc_intro
 - doctools
 - doctools_lang_cmdref
 - doctools_lang_faq
 - doctools_lang_intro
 - doctools_lang_syntax
 - doctools_plugin_apiref
Keywords:
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools_intro – Einleitung in doctools

# BESCHREIBUNG

*doctools* (Abkürzung für *documentation tools*) bezeichnet eine Reihe miteinander verbundener, aber dennoch unterschiedlicher Komponenten, die zusammenwirken, um die Erstellung und Transformation von Dokumentationen zu vereinfachen. Dazu gehören

**\[1\]**
: Eine auf Tcl basierende Sprache zur semantischen Auszeichnung von Text. Die Auszeichnung wird durch Tcl-Befehle dargestellt, die in den eigentlichen Text eingestreut sind.

**\[2\]**
: Ein Paket, das die Möglichkeit bietet, Texte zu lesen und zu transformieren, die in dieser Auszeichnungssprache verfasst sind. Es ist wichtig zu beachten, dass die eigentliche Transformation des Eingabetextes an Plugins weitergeleitet wird.

**\[3\]**
: Eine API, die die Schnittstelle zwischen dem oben genannten Paket und einem Plugin beschreibt. Welche der ausführlicheren Dokumente für den Leser dieser Einleitung relevant sind, hängt von seiner Rolle im Dokumentationsprozess ab.

**\[1\]**
: Ein *Autor* von Dokumentationen muss die Auszeichnungssprache selbst verstehen. Ein Anfänger im Umgang mit doctools sollte zunächst die eher informell verfasste *Einleitung in die doctools-Sprache* lesen. Nachdem er diese verinnerlicht hat, sollte die formale Spezifikation der *doctools-Sprachsyntax* verständlich werden. Ein mit doctools erfahrener Autor benötigt möglicherweise nur gelegentlich die *Befehlsreferenz der doctools-Sprache*, um sein Gedächtnis aufzufrischen. Während ein Dokument verfasst wird, kann die Anwendung **dtplite** zu seiner Prüfung verwendet werden, und nach der Fertigstellung führt sie auch die Umwandlung in das gewählte System visueller Auszeichnung durch, sei es \*roff, HTML, Klartext, Wiki usw.

**\[2\]**
: Ein *Verarbeiter* von Dokumentation, die in der Auszeichnungssprache *doctools* verfasst wurde, muss wissen, welche Werkzeuge zur Verfügung stehen. Das wichtigste Werkzeug ist die bereits erwähnte Anwendung **dtplite**, die von Tcllib bereitgestellt wird. Ein leistungsfähigeres Werkzeug, was die Optionen und die Möglichkeit angeht, es zu konfigurieren, ist die Anwendung **dtp**, die von Tclapps bereitgestellt wird. Auf der untersten Ebene, die beiden Anwendungen gemeinsam ist, befindet sich jedoch das Paket **doctools**, das die grundlegenden Funktionen zum Lesen und Verarbeiten von Dateien bereitstellt, die Text im doctools-Format enthalten.

**\[3\]**
: Nicht zuletzt müssen *Plugin-Entwickler* die Wechselwirkung zwischen dem Paket **doctools** und dessen Plugins verstehen, wie in der *doctools-Plugin-API-Referenz* beschrieben.


# VERWANDTE FORMATE

doctools steht nicht für sich allein, sondern hat zwei begleitende Formate. Diese heißen *docidx* und *doctoc* und dienen jeweils der Auszeichnung von *Schlüsselwortindizes* bzw. *Inhaltsverzeichnissen*. Sie werden in eigenen Dokumentenreihen beschrieben, beginnend jeweils mit der *docidx-Einleitung* und der *doctoc-Einleitung*.

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
