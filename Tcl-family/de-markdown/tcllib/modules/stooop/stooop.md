---
CommandName: stooop
title: stooop
ManualSection: n
Version: 4.4.2
TclPart: tcllib
TclDescription: Simple Tcl Only Object Oriented Programming
Keywords:
 - C++
 - class
 - object
 - object oriented
Copyright:
---

# Name

stooop – Objektorientierte Erweiterung.

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [stooop]{.lit} [4.4.2]{.optlit}
[::stooop::class]{.cmd} [name]{.arg} [body]{.arg}
[::stooop::new]{.cmd} [class]{.arg} [arg arg]{.optdot}
[::stooop::delete]{.cmd} [object]{.arg} [object]{.optdot}
[::stooop::virtual]{.cmd} [proc]{.lit} [name]{.arg} [{this ?arg arg ...?}]{.arg} [body]{.optarg}
[::stooop::classof]{.cmd} [object]{.arg}
[::stooop::new]{.cmd} [object]{.arg}
[::stooop::printObjects]{.cmd} [pattern]{.optarg}
[::stooop::record]{.cmd}
[::stooop::report]{.cmd} [pattern]{.optarg}
:::

# Beschreibung

Dieses Paket stellt Befehle zur Verfügung, mit denen sich Tcl auf objektorientierte Weise erweitern lässt, wobei eine vertraute, C++-ähnliche Syntax und ein entsprechendes Verhalten zum Einsatz kommen. Stooop führt lediglich einige wenige neue Befehle ein: **class**, **new**, **delete**, **virtual** und **classof**. Zusammen mit einigen Programmierkonventionen ist das im Grunde alles, was Sie wissen müssen, um Stooop zu verwenden. Stooop soll so einfach wie möglich zu bedienen sein.

Dieses Handbuch ist sehr prägnant und dient als kurze Übersicht für den Programmierer, der zu diesem Zeitpunkt bereits die ausführliche HTML-Dokumentation *stooop\_man.html* gelesen haben sollte.

**::stooop::class** *name body*
: Dieser Befehl erzeugt eine Klasse. Der Klassenrumpf, inhaltlich einem Tcl-Namespace vergleichbar (eine Klasse ist tatsächlich auch einer), enthält Definitionen von Member-Prozeduren. Member-Prozeduren lassen sich auch außerhalb des Klassenrumpfs definieren, indem ihrem Namen das Präfix **class::** vorangestellt wird, so wie bei Namespace-Prozeduren.

    **proc** *class* {**this** ?*arg arg ...*?} ?*base* {?*arg arg ...*?} ...? *body*
    : Dies ist die Konstruktor-Prozedur für die Klasse. Sie wird nach einem Aufruf von **new** für die Klasse aufgerufen. Sie muss denselben Namen wie die Klasse tragen und ein erstes Argument mit dem Namen **this** enthalten. Vor dem eigentlichen Prozedurkörper sind beliebig viele Angaben zu Basisklassen zulässig, einschließlich der an deren Konstruktor zu übergebenden Argumente.

    **proc** ~*class* {**this**} *body*
    : Dies ist die Destruktor-Prozedur der Klasse. Sie wird nach einem Aufruf von **delete** aufgerufen. Ihr Name muss aus einem einzelnen Zeichen **~** gefolgt vom Klassennamen bestehen (wie in C++). Sie muss ein einziges Argument namens **this** haben.

    **proc** *name* {**this** ?*arg arg ...*?} *body*
    : Es handelt sich hierbei um eine Member-Prozedur der Klasse, da ihr erstes Argument den Namen **this** trägt. Sie ermöglicht innerhalb der Prozedur einen einfachen Zugriff auf die Member-Daten des Objekts, auf das **this** verweist. Beispiel:

        ```
           set ($this,data) 0
        ```

    **proc** *name* {?*arg arg ...*?} *body*
    : Es handelt sich hierbei um eine statische (im Sinne von C++) Member-Prozedur der Klasse, da ihr erstes Argument nicht den Namen „**this**“ trägt. Auf statische (globale) Klassendaten kann wie folgt zugegriffen werden:

        ```
           set (data) 0
        ```

    **proc** *class* {**this copy**} *body*
    : Dies ist die optionale Kopierprozedur für die Klasse. Sie muss denselben Namen wie die Klasse tragen und genau zwei Argumente mit den Namen **this** und **copy** aufweisen. Sie wird nach einem Aufruf von **new** für ein vorhandenes Objekt der Klasse aufgerufen.


**::stooop::new** *class* ?*arg arg ...*?
: Dieser Befehl erzeugt ein Objekt. Das erste Argument ist der Klassenname, danach folgen die Argumente, die der Konstruktor der entsprechenden Klasse benötigt. Zurückgegeben wird eine eindeutige Kennung für das soeben erzeugte Objekt.

**::stooop::delete** *object* ?*object ...*?
: Dieser Befehl dient zum Löschen eines oder mehrerer Objekte. Er benötigt ein oder mehrere Objektkennungen als Argument(e).

**::stooop::virtual** **proc** *name* {**this** ?*arg arg ...*?} ?*body*?
: Der Spezifizierer **virtual** kann bei Member-Prozeduren verwendet werden, um dynamische Bindung zu erreichen. Eine Prozedur einer Basisklasse kann dann in der abgeleiteten Klasse bzw. den abgeleiteten Klassen neu definiert (überladen) werden. Wird die Prozedur der Basisklasse für ein Objekt aufgerufen, wird tatsächlich die Prozedur der abgeleiteten Klasse aufgerufen, sofern sie vorhanden ist. Hat die Prozedur der Basisklasse keinen Prozedurrumpf, gilt sie als rein virtuell, und es wird stets die Prozedur der abgeleiteten Klasse aufgerufen.

**::stooop::classof** *object*
: Dieser Befehl gibt die Klasse des vorhandenen Objekts zurück, das als einzelner Parameter übergeben wurde.

**::stooop::new** *object*
: Dieser Befehl erzeugt ein Objekt durch Kopieren eines vorhandenen Objekts. Dabei wird der Kopierkonstruktor der entsprechenden Klasse aufgerufen, sofern er vorhanden ist; andernfalls werden die Daten-Member des kopierten Objekts einfach kopiert.


# Fehlersuche

Umgebungsvariablen
: siehe unten ...

    **STOOOPCHECKDATA**
    : Steht diese Variable auf einem beliebigen wahren Wert, prüft stooop Zugriffe auf ungültige Member- oder Klassendaten.

    **STOOOPCHECKPROCEDURES**
    : Steht diese Variable auf einem beliebigen wahren Wert, prüft stooop ungültige Argumente von Member-Prozeduren und die Instanziierung reiner Schnittstellenklassen.

    **STOOOPCHECKALL**
    : Steht diese Variable auf einem beliebigen wahren Wert, schaltet stooop sowohl die Prüfung der Prozeduren als auch die der Daten-Member ein.

    **STOOOPCHECKOBJECTS**
    : Steht diese Variable auf einem beliebigen wahren Wert, schaltet stooop die Objektprüfung ein. Danach stehen diese Prozeduren des stooop-Namespaces für die Fehlersuche bereit: **printObjects**, **record** und **report**.

    **STOOOPTRACEPROCEDURES**
    : Steht diese Umgebungsvariable auf **stdout**, **stderr** oder einem Dateinamen, wird die Prozedurverfolgung aktiviert. Die stooop-Bibliothek gibt dann für jeden Aufruf einer Member-Prozedur eine Zeile Informationstext auf dem angegebenen Kanal aus.

    **STOOOPTRACEPROCEDURESFORMAT**
    : Legt das Ausgabeformat der Prozedurverfolgung fest. Voreinstellung ist **"class: %C, procedure: %p, object: %O, arguments: %a"**.

    **STOOOPTRACEDATA**
    : Steht diese Umgebungsvariable auf **stdout**, **stderr** oder einem Dateinamen, wird die Datenverfolgung aktiviert. Die stooop-Bibliothek gibt dann für jeden Zugriff auf Member-Daten eine Zeile Informationstext auf dem angegebenen Kanal aus.

    **STOOOPTRACEDATAFORMAT**
    : Legt das Ausgabeformat der Datenverfolgung fest. Voreinstellung ist **"class: %C, procedure: %p, array: %A, object: %O, member: %m, operation: %o, value: %v"**.

    **STOOOPTRACEDATAOPERATIONS**
    : Bei der Datenverfolgung werden standardmäßig alle Lese-, Schreib- und Unset-Zugriffe gemeldet. Die Variable kann auf eine beliebige Kombination der Buchstaben **r**, **w** und **u** gesetzt werden, um gezielter zu verfolgen (siehe die Tcl-Handbuchseite zu **trace**).

    **STOOOPTRACEALL**
    : Steht diese Umgebungsvariable auf **stdout**, **stderr** oder einem Dateinamen, werden Prozedur- und Datenverfolgung zusammen aktiviert.


**::stooop::printObjects** ?*pattern*?
: Gibt eine geordnete Liste der vorhandenen Objekte in der Reihenfolge ihrer Erstellung aus, wobei das älteste Objekt an erster Stelle steht. Jede Ausgabezeile enthält den Klassennamen, die Objektkennung und die Prozedur, in der die Erstellung erfolgte. Das optionale Musterargument (wie im Tcl-Befehl **string match**) kann verwendet werden, um die Ausgabe auf übereinstimmende Klassennamen zu beschränken.

**::stooop::record**
: Beim Aufruf wird eine Momentaufnahme aller vorhandenen stooop-Objekte genommen. Mit report lässt sich später feststellen, welche Objekte in der Zwischenzeit erzeugt oder gelöscht wurden.

**::stooop::report** ?*pattern*?
: Gibt die Objekte aus, die seit dem letzten Aufruf von **::stooop::record** erzeugt oder gelöscht wurden. Ist das Argument pattern angegeben, beschränkt es die Ausgabe auf passende Klassennamen.


# Beispiele

Die vollständige HTML-Dokumentation finden Sie in der Datei *stooop\_man.html*.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *stooop* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge
