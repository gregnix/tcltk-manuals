---
CommandName: doctools::idx
ManualSection: n
Version: 1.2.1
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - docidx_lang_cmdref
 - docidx_lang_intro
 - docidx_lang_syntax
 - docidx_plugin_apiref
Keywords:
 - HTML
 - TMML
 - conversion
 - docidx
 - documentation
 - index
 - keyword index
 - latex
 - manpage
 - markdown
 - markup
 - nroff
 - wiki
Copyright:
 - Copyright (c) 2003-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::idx – docidx – Indizes verarbeiten

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::idx]{.lit} [1.2.1]{.optlit} 
[::doctools::idx::new]{.cmd} [objectName]{.arg} [-option value]{.optdot} 
[::doctools::idx::help]{.cmd} 
[::doctools::idx::search]{.cmd} [path]{.arg} 
[objectName]{.cmd} [method]{.sub} [arg arg]{.optdot} 
[objectName]{.ins} [configure]{.sub} 
[objectName]{.ins} [configure]{.sub} [option]{.arg} 
[objectName]{.ins} [configure]{.sub} [-option]{.lit} [value...]{.arg} 
[objectName]{.ins} [cget]{.sub} [-option]{.lit} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [format]{.sub} [text]{.arg} 
[objectName]{.ins} [map]{.sub} [symbolic]{.arg} [actual]{.arg} 
[objectName]{.ins} [parameters]{.sub} 
[objectName]{.ins} [search]{.sub} [path]{.arg} 
[objectName]{.ins} [setparam]{.sub} [name]{.arg} [value]{.arg} 
[objectName]{.ins} [warnings]{.sub} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine Klasse zur Verfügung, mit der Objekte erstellt werden können, die in der Markup-Sprache *docidx* verfassten Text verarbeiten und in ein beliebiges Ausgabeformat X konvertieren können, für das eine *Formatierungs-Engine* verfügbar ist.

Leser, die sich für die Auszeichnungssprache selbst interessieren, sollten mit der *Einleitung in die Sprache docidx* beginnen und von dort aus zu den formalen Spezifikationen übergehen, d. h. zur *Syntax der Sprache docidx* und zur *Befehlsreferenz der Sprache docidx*.

Sollte der Leser hingegen eine eigene Formatierungs-Engine für ein bestimmtes Format schreiben wollen, d. h. als *Plugin-Entwickler* tätig sein, ist das Lesen und Verstehen der *docidx-Plugin-API-Referenz* unbedingt erforderlich, da dieses Dokument die Interaktion zwischen diesem Paket und seinen Plugins, d. h. den Formatierungs-Engines, im Detail festlegt.

# ÖFFENTLICHE API

## Paketbefehle

**::doctools::idx::new** *objectName* ?**-option** *value* ...?
: Dieser Befehl erstellt ein neues docidx-Objekt mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten **Objektbefehl** und **Objektmethoden** ausführlich erläutert. Der Objektbefehl wird im aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist; andernfalls erfolgt die Erstellung im angegebenen Namespace. Die Optionen und ihre Werte, die auf den Namen des Objekts folgen, dienen dazu, die Anfangskonfiguration des Objekts festzulegen.

**::doctools::idx::help**
: Dies ist ein Komfortbefehl für Anwendungen, die ihren Benutzern eine kurze Beschreibung der verfügbaren Formatierungsbefehle und deren Bedeutung bereitstellen möchten. Er gibt eine Zeichenkette zurück, die einen Standard-Hilfetext enthält.

**::doctools::idx::search** *path*
: Wann immer ein durch dieses Paket erstelltes Objekt den Namen eines Formats der Datei zuordnen muss, die den Code für dessen Formatierungs-Engine enthält, sucht es in einer Reihe von Verzeichnissen nach dieser Datei, die in einer Liste gespeichert sind. Weitere Erläuterungen finden Sie im Abschnitt **Formatzuordnung**. Diese Liste enthält nicht nur drei Standardverzeichnisse, die vom Paket selbst deklariert werden, sondern kann auch vom Benutzer des Pakets erweitert werden. Dieser Befehl dient dazu. Wird ein *path* zu einem vorhandenen und lesbaren Verzeichnis angegeben, wird dieses Verzeichnis der Liste der zu durchsuchenden Verzeichnisse vorangestellt. Das bedeutet, dass der zuletzt hinzugefügte *path* später als erstes durchsucht wird. Es wird ein Fehler ausgelöst, wenn der *path* entweder nicht existiert, kein Verzeichnis ist oder nicht lesbar ist.


## Objektbefehl

Alle von **::doctools::idx::new** erstellten Befehle haben die folgende allgemeine Form und können verwendet werden, um verschiedene Operationen auf ihrem „docidx“-Konverterobjekt auszuführen.

**objectName** **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt **Objektmethoden**.


## Objektmethoden

*objectName* **configure**
: Die Methode gibt eine Liste aller bekannten Optionen und deren aktuelle Werte zurück, wenn sie ohne Argumente aufgerufen wird.

*objectName* **configure** *option*
: Die Methode verhält sich wie die Methode **cget**, wenn sie mit einem einzigen Argument aufgerufen wird, und gibt den Wert der durch dieses Argument festgelegten Option zurück.

*objectName* **configure** **-option** *value*...
: Die Methode konfiguriert die angegebenen **option**s des Objekts neu und setzt sie auf die zugehörigen *value*s, wenn sie mit einer geraden Anzahl von Argumenten (mindestens zwei) aufgerufen wird. Die zulässigen Optionen sind im Abschnitt **Objekt-Konfiguration** beschrieben.

*objectName* **cget** **-option**
: Diese Methode erwartet eine zulässige Konfigurationsoption als Argument und gibt den aktuellen Wert dieser Option für das Objekt zurück, für das die Methode aufgerufen wurde. Die zulässigen Konfigurationsoptionen sind im Abschnitt **Objekt-Konfiguration** beschrieben.

*objectName* **destroy**
: Diese Methode löscht das Objekt, für das sie aufgerufen wird.

*objectName* **format** *text*
: Diese Methode verarbeitet den *text* mithilfe der konfigurierten Formatierungs-Engine und gibt die generierte Zeichenfolge als Ergebnis zurück. Es wird ein Fehler ausgelöst, wenn für das Objekt keine Konfiguration von **-format** vorhanden ist. Die Methode geht davon aus, dass der *text* im *docidx*-Format vorliegt, wie im Begleitdokument *docidx_fmt* festgelegt. Andernfalls werden Fehler ausgelöst.

*objectName* **map** *symbolic* *actual*
: Diese Methode fügt dem objektbezogenen Zuordnungsschema von *symbolic* Dateinamen zu den *actual* URIs einen Eintrag hinzu. Das Objekt speichert lediglich diese Zuordnung und stellt sie der konfigurierten Formatierungs-Engine über den Befehl **dt_fmap** zur Verfügung. Dieser Befehl wird ausführlicher in der *docidx-Plugin-API-Referenz* beschrieben, die die Interaktion zwischen den von diesem Paket erstellten Objekten und den Index-Formatierungs-Engines festlegt.

*objectName* **parameters**
: Diese Methode gibt eine Liste zurück, die die Namen aller von der konfigurierten Formatierungs-Engine bereitgestellten Parameter enthält. Sie gibt eine leere Liste zurück, wenn das Objekt noch nicht für ein bestimmtes Format konfiguriert ist.

*objectName* **search** *path*
: Diese Methode erweitert die objektbezogene Liste der Pfade, die von den Indexformatierungs-Engines durchsucht werden. Siehe auch den Befehl **::doctools::idx::search** zur Erweiterung der paketbezogenen Pfadliste. Beachten Sie, dass der zuletzt eingegebene Pfad zuerst durchsucht wird. Weitere Einzelheiten finden Sie im Abschnitt **Formatzuordnung**.

*objectName* **setparam** *name* *value*
: Diese Methode setzt den mit *name* bezeichneten Engine-Parameter auf den angegebenen *value*. Es wird ein Fehler ausgelöst, wenn das Objekt entweder noch nicht für ein bestimmtes Format konfiguriert ist oder wenn die Formatierungs-Engine für das konfigurierte Format keinen Parameter mit dem angegebenen *name* bereitstellt. Die Liste der von der konfigurierten Formatierungs-Engine bereitgestellten Parameter kann über die Methode **parameters** abgerufen werden.

*objectName* **warnings**
: Diese Methode gibt eine Liste zurück, die alle Warnungen enthält, die von der konfigurierten Formatierungs-Engine beim letzten Aufruf der Methode **format** erzeugt wurden.


## Objekt-Konfiguration

Alle docidx-Objekte unterstützen die folgenden Konfigurationsoptionen:

**-file** *file*
: Das Argument dieser Option wird im Objekt gespeichert und der konfigurierten Formatierungs-Engine über den Befehl **dt_file** zur Verfügung gestellt. Dieser Befehl wird im Begleitdokument *docidx_api* näher beschrieben, das die API zwischen dem Objekt und den Formatierungs-Engines festlegt. Der Standardwert dieser Option ist die leere Zeichenkette. Die konfigurierte Formatierungs-Engine sollte den Wert als Namen der Datei interpretieren, die das aktuell verarbeitete Dokument enthält.

**-format** *text*
: Das Argument dieser Option legt das zu erzeugende Format fest und damit implizit auch die Formatierungs-Engine, die bei der Konvertierung von Text über die Methode **format** verwendet werden soll. Der Standardwert ist die leere Zeichenkette. Die Methode **format** kann nicht verwendet werden, wenn diese Option nicht mindestens einmal auf einen gültigen Wert gesetzt wurde. Das Paket versucht umgehend, den angegebenen Namen einer Datei zuzuordnen, die den Code für eine Formatierungs-Engine enthält, welche dieses Format erzeugt. Sollte diese Zuordnung fehlschlagen, wird ein Fehler ausgelöst. In diesem Fall bleibt ein zuvor konfiguriertes Format unverändert. Im Abschnitt **Formatzuordnung** wird detailliert erläutert, wie das Paket und das Objekt nach Engine-Implementierungen suchen.


## Formatzuordnung

Das Paket und das Objekt führen den folgenden Algorithmus aus, wenn versucht wird, einen Formatnamen *foo* einer Datei zuzuordnen, die eine Implementierung einer Formatierungs-Engine für *foo* enthält:

**\[1\]**
: Ist *foo* der Name einer vorhandenen Datei, so wird diese Datei direkt als Implementierung herangezogen.

**\[2\]**
: Wenn dies nicht der Fall ist, wird die Liste der objektbezogenen Suchpfade durchsucht. Für jedes Verzeichnis in der Liste prüft das Paket, ob dieses Verzeichnis eine Datei „*idx.foo*“ enthält. Ist dies der Fall, wird diese Datei als Implementierung herangezogen. Hinweise: Diese Liste von Pfaden ist zunächst leer und kann über die Objektmethode **search** erweitert werden.

**\[3\]**
: Ist dies nicht der Fall, wird die Liste der Paketpfade durchsucht. Für jedes Verzeichnis in der Liste prüft das Paket, ob dieses Verzeichnis eine Datei „*idx.foo*“ enthält. Ist dies der Fall, wird diese Datei als Implementierung herangezogen. Diese Liste der Pfade kann über den Befehl **::doctools::idx::search** erweitert werden. Sie enthält zunächst einen Pfad, nämlich das Unterverzeichnis „*mpformats*“ des Verzeichnisses, in dem sich das Paket selbst befindet. Mit anderen Worten: Wenn die Paketimplementierung „*docidx.tcl*“ im Verzeichnis „*/usr/local/lib/tcllib/doctools*“ installiert ist, wird standardmäßig das Verzeichnis „*/usr/local/lib/tcllib/doctools/mpformats*“ nach Formatimplementierungen durchsucht.

**\[4\]**
: Die Zuordnung schlägt fehl.


# VORDEFINIERTE ENGINES

Das Paket stellt vordefinierte Formatierungs-Engines für die folgenden Formate bereit. Einige der Formatierungs-Engines unterstützen Engine-Parameter. Diese werden ausdrücklich hervorgehoben.

**html**
: Diese Engine erzeugt HTML-Markup zur Verarbeitung durch Webbrowser und Ähnliches. Diese Engine unterstützt drei Parameter:


**footer**
: Der Wert für diesen Parameter muss gültiges, in sich geschlossenes HTML-Markup für den „body“-Abschnitt eines HTML-Dokuments sein. Der Standardwert ist die leere Zeichenkette. Der Wert wird in die generierte Ausgabe unmittelbar vor dem Tag „**\</body>**“ eingefügt und schließt damit den „body“-Abschnitt des generierten HTML-Codes ab. Dies kann genutzt werden, um Standard-Fußzeilen-Markup in das generierte Dokument einzufügen.

**header**
: Der Wert für diesen Parameter muss gültiges, in sich geschlossenes HTML-Markup für den „body“-Abschnitt eines HTML-Dokuments sein. Der Standardwert ist die leere Zeichenkette. Der Wert wird in die generierte Ausgabe unmittelbar nach dem **\<body>**-Tag eingefügt und bildet den Beginn des Hauptteils des generierten HTML-Codes. Dies kann genutzt werden, um Standard-Kopfzeilen-Markup in das generierte Dokument einzufügen.

**meta**
: Der Wert für diesen Parameter muss gültiges, in sich geschlossenes HTML-Markup für den Kopfbereich eines HTML-Dokuments sein. Der Standardwert ist eine leere Zeichenkette. Der Wert wird in die generierte Ausgabe unmittelbar nach dem **\<head>**-Tag eingefügt und bildet den Beginn des Kopfbereichs des generierten HTML-Dokuments. Dies kann genutzt werden, um Standard-Metadaten-Markup in das generierte Dokument einzufügen, wie beispielsweise Verweise auf ein Stylesheet, Standard-Meta-Schlüsselwörter usw.


**latex**
: Diese Engine erzeugt eine Ausgabe, die für den Textprozessor **latex** aus der TeX-Welt geeignet ist.

**list**
: Diese Engine extrahiert Version, Abschnitt und Titel der Manpage aus dem Dokument. Damit lässt sich eine Verzeichnisliste für eine Reihe von Manpages erzeugen.

**markdown**
: Diese Engine generiert *Markdown*-Markup.

**nroff**
: Diese Engine erzeugt eine nroff-Ausgabe, die von **nroff** oder **groff** verarbeitet wird. Das Ergebnis sind Standard-Manpages, wie sie in der Unix-Welt bekannt sind.

**null**
: Diese Engine erzeugt keinerlei Ausgabe. Das kann genutzt werden, wenn lediglich eine Eingabe validiert werden soll.

**tmml**
: Diese Engine generiert TMML-Markup gemäß der Festlegung von Joe English. Die Tcl Manpage Markup Language ist eine Ableitung von XML.

**wiki**
: Diese Engine generiert Wiki-Markup, wie es Jean Claude Wipplers Anwendung **wikit** versteht.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2003-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
