---
CommandName: fileutil::multi::op
ManualSection: n
Version: 0.5.4
TclPart: tcllib
TclDescription: file utilities
Keywords:
 - copy
 - file utilities
 - move
 - multi-file
 - remove
Copyright:
---

# NAME

fileutil::multi::op – Bearbeitung mehrerer Dateien, Scatter/Gather

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil::multi::op]{.lit} [0.5.4]{.optlit} 
[package]{.cmd} [require]{.sub} [wip]{.lit} [1.0]{.optlit} 
[::fileutil::multi::op]{.cmd} [opName]{.optarg} [word]{.optdot} 
[opName]{.cmd} [option]{.arg} [arg arg]{.optdot} 
[\$opName]{.cmd} [do]{.sub} [word]{.optdot} 
[into]{.cmd} [directory]{.arg} 
[in]{.cmd} [directory]{.arg} 
[to]{.cmd} [directory]{.arg} 
[from]{.cmd} [directory]{.arg} 
[not]{.cmd} [pattern]{.arg} 
[for]{.cmd} [pattern]{.arg} 
[exclude]{.cmd} [pattern]{.arg} 
[but]{.cmd} 
[except]{.cmd} 
[as]{.cmd} [name]{.arg} 
[recursive]{.cmd} 
[recursively]{.cmd} 
[copy]{.cmd} 
[move]{.cmd} 
[remove]{.cmd} 
[expand]{.cmd} 
[invoke]{.cmd} [cmdprefix]{.arg} 
[reset]{.cmd} 
[(]{.cmd} 
[)]{.cmd} 
[cd]{.cmd} [directory]{.arg} 
[up]{.cmd} 
[for-windows]{.cmd} 
[for-win]{.cmd} 
[for-unix]{.cmd} 
[the]{.cmd} [pattern]{.arg} 
[the-set]{.cmd} [varname]{.arg} 
[->]{.cmd} [varname]{.arg} 
[strict]{.cmd} 
[!strict]{.cmd} 
[files]{.cmd} 
[links]{.cmd} 
[directories]{.cmd} 
[dirs]{.cmd} 
[all]{.cmd} 
[state?]{.cmd} 
[as?]{.cmd} 
[excluded?]{.cmd} 
[from?]{.cmd} 
[into?]{.cmd} 
[operation?]{.cmd} 
[recursive?]{.cmd} 
[strict?]{.cmd} 
[type?]{.cmd} 
:::

# BESCHREIBUNG

Dieses Paket stellt Objekte bereit, mit denen sich Aktionen auf mehrere Dateien ausführen lassen, die anhand von Glob-Mustern ausgewählt wurden.

Im Mittelpunkt steht eine domänenspezifische Sprache, die die einfache Spezifizierung von Operationen zum Kopieren und/oder Verschieben und/oder Löschen mehrerer Dateien ermöglicht. Alternative Namen wären „Scatter/Gather-Prozessor“ oder vielleicht sogar „Assembler“.

# API FÜR KLASSEN

Der Hauptbefehl des Pakets lautet:

**::fileutil::multi::op** ?*opName*? ?*word*...?
: Der Befehl erstellt ein neues Objekt für eine Operation mit mehreren Dateien, dem ein globaler Tcl-Befehl mit dem Namen *opName* zugeordnet ist. Mit diesem Befehl lassen sich die verschiedenen möglichen Dateioperationen aufrufen. Er hat die folgende allgemeine Form:


**opName** *option* ?*arg arg ...*?
: *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls.


Wenn die Zeichenfolge **%AUTO%** als *opName* verwendet wird, generiert das Paket selbstständig einen eindeutigen Name.

Wenn ein oder mehrere *Wörter* angegeben werden, werden diese als anfängliche Reihe von auszuführenden Dateibefehlen interpretiert. Das heißt, die Methode **do** des neu erstellten Objekts wird implizit aufgerufen, wobei die Wörter als Argumente verwendet werden.

# OBJEKT-API

Für Objekte mit Mehrdateienbetrieb sind folgende Methoden möglich:

**\$opName** **do** ?*word*...?
: Diese Methode interpretiert die angegebenen Wörter als auszuführende Dateibefehle. Informationen zu den zulässigen Befehlen, ihrer Syntax und Semantik finden Sie im Abschnitt **FILE API**. Das Ergebnis der Methode ist das Ergebnis des zuletzt ausgeführten Dateibefehls.


# DATEI-API

Sowohl der Objektkonstruktor als auch die Methode **do** eine Liste von Wörtern und interpretieren diese als auszuführende Dateibefehle. Die Namen wurden so gewählt, dass Operationen als Sätze in einer nahezu natürlichen Sprache gebildet werden können. Die meisten Befehle beeinflussen lediglich den Zustand des Objekts, d. h., sie liefern lediglich die Konfiguration, die von dem Befehl verwendet wird, der die eigentliche Aktion auslöst.

**into** *directory*
: Legt das Zielverzeichnis für die Vorgänge fest.

**in** *directory*
: Alias für **into**.

**to** *directory*
: Alias für **into**.

**from** *directory*
: Legt das Verzeichnis für die Vorgänge fest.

**not** *pattern*
: Legt ein Glob-Muster für Pfade fest, die von der Operation ausgeschlossen werden sollen.

**for** *pattern*
: Alias für **not**.

**exclude** *pattern*
: Alias für **not**.

**but**
: Hat keine eigenen Argumente, sondern durchsucht die Wortliste nach vorne und führt alle **not**-Befehle aus, die unmittelbar darauf folgen. Dies ermöglicht die Bildung von „aber nicht“- und „aber ausschließen“-Klauseln für eine natürlicher klingende Angabe ausgeschlossener Pfade.

**except**
: Ein Semi-Alias für **but**. Hat keine eigenen Argumente, sucht jedoch in der Wortliste vorwärts und führt alle unmittelbar darauf folgenden **for**-Befehle aus. Dies ermöglicht die Bildung von „außer“-Klauseln für eine natürlicher klingende Angabe ausgeschlossener Pfade.

**as** *name*
: Legt einen neuen Name für die erste Datei fest, die im Rahmen des aktuellen Vorgangs bearbeitet wird. Das heißt, für die Umbenennung einer einzelnen Datei während des Vorgangs.

**recursive**
: Gibt an, dass die Dateierweiterung in der gesamten Verzeichnishierarchie und nicht nur im Verzeichnis selbst erfolgen soll.

**recursively**
: Ein Alias für **recursive**.

**copy**
: Zeigt an, dass es sich bei dem Vorgang um das Kopieren von Dateien vom Quell- in das Zielverzeichnis gemäß den angegebenen Einschluss- und Ausschlussmustern handelt.

**move**
: Zeigt an, dass es sich bei dem Vorgang um das Verschieben von Dateien vom Quell- in das Zielverzeichnis gemäß den angegebenen Ein- und Ausschlussmustern handelt.

**remove**
: Zeigt an, dass bei diesem Vorgang Dateien im Zielverzeichnis gemäß den angegebenen Ein- und Ausschlussmustern entfernt werden.

**expand**
: Zeigt an, dass außer der Berechnung der Dateimenge anhand der Ein- und Ausschlussmuster keine weitere Operation stattfindet. Diese Operation ist nicht verfügbar, wenn **the-set** verwendet wird.

**invoke** *cmdprefix*
: Gibt an, dass das vom Benutzer angegebene Befehlspräfix *cmdprefix* die auszuführende Operation ist. Das Befehlspräfix wird auf globaler Ebene ausgeführt und erhält dabei das Quellverzeichnis, das Zielverzeichnis sowie die Dateigruppe (als Wörterbuchzuordnung von Quell- zu Zieldateien) in dieser Reihenfolge.

**reset**
: Versetzt das Objekt in den Grundzustand, in dem alle Teile der Konfiguration Standardwerte aufweisen.

**(**
: Speichert eine Kopie des aktuellen Zustands des Objekts auf einem Stapel.

**)**
: Entnimmt den Zustand vom obersten Element des Zustandsstapels und stellt ihn wieder her, d. h., macht ihn zum neuen aktuellen Zustand des Objekts.

**cd** *directory*
: Ändert das Zielverzeichnis in das Unterverzeichnis *verzeichnis* des aktuellen Ziels.

**up**
: Ändert das Zielverzeichnis in das übergeordnete Verzeichnis des aktuellen Ziels.

**for-windows**
: Prüft, ob Windows die aktuelle Plattform ist. Bricht den Prozess ab, wenn dies nicht der Fall ist.

**for-win**
: Ein Alias für **for-windows**.

**for-unix**
: Prüft, ob Unix die aktuelle Plattform ist. Bricht den Prozess ab, wenn dies nicht der Fall ist.

**the** *pattern*
: Dieser Befehl legt die zu bearbeitenden Dateien anhand eines Glob-Musters fest und ist zugleich das aktive Element, d. h. der Befehl, der die angegebene Operation tatsächlich ausführt. Alle anderen Befehle ändern lediglich den Objektzustand, um die Operation vorzubereiten, führen aber keine weiteren Aktionen aus. Um eine natürlichere Syntax zu ermöglichen, blickt dieser Befehl auch in die Liste der nachfolgenden Wörter vor und führt mehrere unmittelbar darauf folgende Befehle aus, bevor er seine eigenen Aktionen ausführt. Diese Befehle sind **as**, **but**, **exclude**, **except**, **from** und **into** (sowie Aliase). Auf diese Weise fungieren diese Befehle wie Qualifizierer und werden dennoch so wirksam, als wären sie vor diesem Befehl geschrieben worden. Nachdem die Operation ausgeführt wurde, werden der Objektzustand, die Ausschlussmuster und der Aliasname, wenn sie festgelegt wurden, auf ihre Standardwerte (d. h. leer) zurückgesetzt, aber sonst nichts.

**the-set** *varname*
: Ähnlich wie bei **the** wird die zu verwendende Dateimenge jedoch nicht implizit über ein Glob-Muster angegeben, sondern ist in der angegebenen Variable enthalten und wird von dort geladen. Die Operation **expand** steht bei Verwendung dieses Befehls nicht zur Verfügung.

**->** *varname*
: Speichert die Dateien aus der letzten Erweiterung in der angegebenen Variable.

**strict**
: Die Dateierweiterung und die Definition des Zielverzeichnisses (**in** und Aliase) streng handhaben, d. h. Fehler bei fehlenden Verzeichnissen und leeren Erweiterungen melden.

**!strict**
: Ergänzung zu **strict**. Ein fehlendes Zielverzeichnis oder eine leere Erweiterung werden nicht als Fehler gemeldet.

**files**
: Die Suche auf Dateien beschränken. Standardmäßig werden alle Pfadtypen akzeptiert.

**links**
: Die Suche auf symbolische Links beschränken. Standardmäßig werden alle Pfadtypen akzeptiert.

**directories**
: Die Suche auf Verzeichnisse beschränken. Standardmäßig werden alle Arten von Pfaden akzeptiert.

**dirs**
: Ein Alias für **directories**.

**all**
: Alle Pfadtypen akzeptieren (Standard).

**state?**
: Gibt den aktuellen Zustand des Objekts als Dictionary zurück. Die Schlüssel des Dictionary und ihre Bedeutungen lauten:


**as**
: Letzte Einstellung vorgenommen von **as**.

**excluded**
: Liste der derzeit bekannten Ausschlussmuster.

**from**
: Aktuelles Verzeichnis für die Quellcodes, festgelegt durch **from**.

**into**
: Aktuelles Verzeichnis für das Ziel, festgelegt durch **into** (und Aliase).

**operation**
: Derzeit auszuführende Operation, festgelegt durch **copy**, **move**, **remove**, **expand** oder **invoke**.

**recursive**
: Aktueller Rekursionsstatus. Wird durch **recursive** und **!recursive** gesetzt bzw. zurückgesetzt.

**strict**
: Aktuelle Strenge. Wird mit **strict** und **!strict** gesetzt bzw. aufgehoben.

**type**
: Begrenzer für den aktuellen PFADTYP. Einstellbar auf **files**, **directories**, **links** oder **all**.


**as?**
: Gibt den aktuellen Aliasnamen zurück.

**excluded?**
: Gibt die aktuell festgelegten Ausschlussmuster zurück.

**from?**
: Gibt das aktuelle Quellverzeichnis zurück.

**into?**
: Gibt das aktuelle Zielverzeichnis zurück.

**operation?**
: Gibt die aktuell auszuführende Operation zurück.

**recursive?**
: Gibt den aktuellen Rekursionsstatus zurück.

**strict?**
: Gibt den aktuellen Strengegrad zurück.

**type?**
: Gibt den aktuellen Pfadtyp-Begrenzer zurück.


# BEISPIELE

In den folgenden Beispielen wird davon ausgegangen, dass die Variable **F** einen Verweis auf ein Objekt für eine Operation mit mehreren Dateien enthält.

```
    $F do copy                       \
	the  *.dll                    \
	from c:/TDK/PrivateOpenSSL/bin \
	to   [installdir_of tls]
```

```
    $F do move      \
	the  *       \
	from /sources \
	into /scratch  \
	but not *.html

    # Alternatively use 'except for *.html'.
```

```
    $F do           \
	move         \
	the  index    \
	from /sources  \
	into /scratch   \
	as   pkgIndex.tcl
```

```
    $F do         \
	remove     \
	the *.txt  \
	in /scratch
```

Beachten Sie, dass die Tatsache, dass die meisten Befehle lediglich den Zustand des Objekts verändern, es uns ermöglicht, neben fast natürlich klingenden Sätzen auch weitere Formulierungen als Spezifikationen zu verwenden. So lässt sich beispielsweise das zweite Beispiel in diesem Abschnitt wie folgt umformulieren:

```
    $F do            \
	from /sources \
	into /scratch  \
	but not *.html \
	move           \
	the  *
```

Und das Ergebnis ist nicht nur nach wie vor eine gültige Spezifikation, sondern bleibt sogar relativ gut lesbar.

Beachten Sie außerdem, dass die durch die Befehle **but**, **except** und **as** gesammelten Informationen automatisch zurückgesetzt werden, nachdem das zugehörige **the** ausgeführt wurde. Es wird jedoch kein anderer Status auf diese Weise zurückgesetzt, sodass der Benutzer Wiederholungen unveränderlicher Informationen vermeiden kann. Beispielsweise lassen sich die zweiten und dritten Beispiele dieses Abschnitts zusammenfassen und wie folgt umschreiben:

```
$F do                   \
    move                 \
    the  *                \
    from /sources          \
    into /scratch           \
    but not *.html not index \
    the  index               \
    as   pkgIndex.tcl
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *fileutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge
