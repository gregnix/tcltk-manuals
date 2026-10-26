---
CommandName: page
title: page
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Development Tools
Links:
 - page::pluginmgr
Keywords:
 - parser generator
 - text processing
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

Seite – Parser-Generator

# Übersicht

::: {.synopsis} :::
[page]{.cmd} [options...]{.optarg} [input ?output]{.optarg}
:::

# Beschreibung

Die in diesem Dokument beschriebene Anwendung, **page**, ist tatsächlich nicht nur ein Parser-Generator, wie der Name vermuten lässt, sondern ein generisches Werkzeug zur Durchführung beliebiger Transformationen an Texten.

Seine Vielseitigkeit beruht auf der Verwendung von *Plugins* zum Lesen, zur Transformation und zum Schreiben von Daten, und die von Tcllib bereitgestellte vordefinierte Sammlung von Plugins dient der Generierung von rekursiven Abstiegsparsern mit Memoisierung (auch bekannt als *Packrat-Parser*) aus Grammatik-Spezifikationen (*Parsing Expression Grammars*).

**page** baut auf dem Paket **page::pluginmgr** auf und bündelt dessen Funktionalität in einer kommandozeilenbasierten Anwendung. Alle anderen **page::\***-Pakete sind Plugins und/oder Unterstützungspakete für die Erstellung von Parsern. Die Parser selbst basieren auf den Paketen **grammar::peg**, **grammar::peg::interp** und **grammar::mengine**.

## Befehlszeile

**page** ?*options*...? ?*input* ?*output*??
: Dies ist die allgemeine Form zum Aufruf von **page**. Die Anwendung liest den Inhalt der Datei *input*, führt einen Prozess unter Berücksichtigung der festgelegten *options* durch und schreibt das Ergebnis anschließend in die Datei *output*.

    Wenn *input* die Zeichenfolge **-** ist, werden die zu verarbeitenden Daten statt aus einer Datei aus **stdin** gelesen. Analog dazu wird das Ergebnis in die Datei **stdout** statt in eine Datei geschrieben, wenn *output* die Zeichenfolge **-** ist. Fehlt eine Angabe für die Ausgabe oder Eingabe, geht die Anwendung von „**-**“ aus.

    Die detaillierten Spezifikationen der unterstützten *options* finden Sie im Abschnitt [Optionen].

    path *input* (in)
    : Dieses Argument legt den Pfad zu der Datei fest, die von der Anwendung verarbeitet werden soll, oder „**-**“. Der letzte Wert bewirkt, dass die Anwendung den Text aus der Datei „**stdin**“ liest. Andernfalls muss die Datei vorhanden und lesbar sein. Wenn das Argument fehlt, wird „**-**“ angenommen.

    path *output* (in)
    : Dieses Argument legt fest, wohin der generierte Text geschrieben werden soll. Es kann sich dabei um den Pfad zu einer Datei oder um „**-**“ handeln. Der letztgenannte Wert bewirkt, dass die Anwendung das generierte Dokument in „**stdout**“ schreibt.

        Wenn die Datei *output* nicht existiert, muss \[file dirname $output\] vorhanden sein und ein beschreibbares Verzeichnis darstellen, da die Anwendung die Datei, in die geschrieben werden soll, selbst anlegt.

        Fehlt das Argument, wird **-** angenommen.



## Betrieb

... Lesen ... Transformation ... Schreiben – Plugins – Pipeline ...

## Optionen

In diesem Abschnitt werden alle Optionen beschrieben, die dem Benutzer der Anwendung zur Verfügung stehen. Die Optionen werden stets der Reihe nach verarbeitet. Das heißt, wenn sowohl **--help** als auch **--version** angegeben sind, hat die zuerst gefundene Option Vorrang.

Unbekannte Optionen, die vor einer der Optionen **-rd**, **-wr** oder **-tr** festgelegt werden, führen dazu, dass der Prozess mit einer Fehlermeldung abgebrochen wird. Unbekannte Optionen, die zwischen diesen Optionen oder nach der letzten davon stehen, werden so behandelt, als würden sie stets ein einzelnes Argument erwarten, und werden der letzten vor ihnen stehenden Plugin-Option zugeordnet. Sie werden erst geprüft, nachdem alle relevanten Plugins – und damit die von ihnen unterstützten Optionen – bekannt sind. Das heißt, solche unbekannten Optionen führen genau dann zu einem Fehler, wenn die Plugin-Option, der sie zugeordnet sind, diese nicht versteht und nicht durch eine nachfolgende Plugin-Option ersetzt wurde.

Die Standardoptionen kommen genau dann zur Anwendung, wenn die Befehlszeile keinerlei Optionen enthielt. Sie richten die Anwendung als PEG-basierten Parsergenerator ein. Die genaue Liste der Optionen lautet

```
-c peg
```

Und nun die unterstützten Optionen und ihre Argumente, sofern vorhanden:

**--help**
: siehe unten ...

**-h**
: siehe unten ...

**-?**
: Wird eine dieser Optionen in der Befehlszeile gefunden, werden alle davor oder danach stehenden Argumente ignoriert. Die Anwendung gibt eine kurze Beschreibung der erkannten Optionen aus und wird beendet.

**--version**
: siehe unten ...

**-V**
: Wird eine dieser Optionen in der Befehlszeile gefunden, werden alle davor oder danach folgenden Argumente ignoriert. Die Anwendung gibt ihre eigene Versionsnummer aus und wird beendet.

**-P**
: Diese Option weist die Anwendung an, während des Einlesens der Eingabe eine visuelle Rückmeldung zu aktivieren.

**-T**
: Diese Option weist die Anwendung an, während des Einlesens der Eingabe Statistiken zu erfassen und diese nach Abschluss des Einlesevorgangs, jedoch vor Beginn des Prozesses, auszugeben.

**-D**
: Diese Option weist die Anwendung an, die Protokollierung in der „Safe“-Basis zu aktivieren, um Probleme mit Plugins zu beheben.

**-r** parser
: siehe unten ...

**-rd** parser
: siehe unten ...

**--reader** parser
: Diese Optionen legen fest, welches Plugin die Anwendung zum Einlesen von *input* verwenden soll. Wenn die Optionen mehrfach angegeben werden, wird die zuletzt angegebene Option verwendet.

**-w** generator
: siehe unten ...

**-wr** generator
: siehe unten ...

**--writer** generator
: Diese Optionen legen fest, welches Plugin die Anwendung zur Erstellung und zum Schreiben von *output* verwenden soll. Wenn die Optionen mehrfach angegeben werden, wird die zuletzt angegebene Option verwendet.

**-t** process
: siehe unten ...

**-tr** process
: siehe unten ...

**--transform** process
: Diese Optionen legen ein Plugin fest, das auf die Eingabe angewendet werden soll. Im Gegensatz zu Lese- und Schreiboperationen überschreibt jede Verwendung die vorherigen Verwendungen *nicht*, sondern fügt jedes ausgewählte Plugin einer Liste von Transformationen hinzu – entweder am Anfang oder am Ende –, je nachdem, welche der beiden Optionen **-p** oder **-a** zuletzt verwendet wurde. Standardmäßig werden die neuen Transformationen angehängt.

**-a**
: siehe unten ...

**--append**
: Diese Optionen signalisieren der Anwendung, dass alle nachfolgenden Transformationen am Ende der Transformationsliste hinzugefügt werden sollen.

**-p**
: siehe unten ...

**--prepend**
: Diese Optionen teilen der Anwendung mit, dass alle nachfolgenden Transformationen am Anfang der Transformationsliste eingefügt werden sollen.

**--reset**
: Diese Option weist die Anwendung an, die Liste der Transformationen zu löschen. Dies ist erforderlich, um die verwendeten Standardtransformationen zu entfernen.

**-c** file
: siehe unten ...

**--configuration** file
: Diese Option bewirkt, dass die Anwendung eine Konfigurationsdatei und/oder ein Plugin lädt. Dabei handelt es sich um ein Plugin, das im Wesentlichen einen vordefinierten Satz von Befehlszeilenoptionen bereitstellt. Diese werden genau so verarbeitet, als wären sie anstelle der Option und ihrer Argumente angegeben worden. Das bedeutet, dass unbekannte Optionen, die am Anfang der Konfigurationsdatei gefunden werden, dem letzten Plugin zugeordnet werden, selbst wenn dieses Plugin vor der Konfigurationsdatei selbst angegeben wurde. Umgekehrt können unbekannte Optionen, die nach der Konfigurationsdatei folgen, einem in der Datei angegebenen Plugin zugeordnet werden.

    Wenn es sich bei dem Argument um eine Datei handelt, die nicht als Plugin geladen werden kann, geht die Anwendung davon aus, dass ihr Inhalt eine Liste von Optionen und deren Argumenten ist, getrennt durch Leerzeichen, Tabulatoren und Zeilenumbrüche. Optionen und Argumente, die Leerzeichen enthalten, können durch doppelte Anführungszeichen (") und einfache Anführungszeichen (') in Anführungszeichen gesetzt werden. Das Anführungszeichen kann innerhalb einer in Anführungszeichen gesetzten Zeichenfolge durch Verdopplung angegeben werden. Zeilenumbrüche in einer in Anführungszeichen gesetzten Zeichenfolge werden unverändert akzeptiert.


## Plugins

**page** nutzt vier verschiedene Arten von Plugins, nämlich: Reader, Writer, Transformationen und Konfigurationen. An dieser Stelle geben wir lediglich eine grundlegende Einleitung in deren Verwendung aus **page**. Die genauen APIs, die den Plugins zur Verfügung gestellt werden und von diesen erwartet werden, finden Sie in der Dokumentation zu **page::pluginmgr** – für diejenigen, die eigene Plugins erstellen möchten.

Plugins werden als Argumente für die Optionen **-r**, **-w**, **-t**, **-c** und deren entsprechende längere Formen festgelegt. Weitere Informationen finden Sie im Abschnitt [Optionen].

Jedes dieser Argumente wird zunächst als Name einer Datei behandelt, und diese Datei wird als Plugin geladen. Wenn es jedoch keine Datei mit diesem Namen gibt, wird das Argument in den Namen eines Pakets umgewandelt, und dieses Paket wird anschließend geladen. Für jeden Plugin-Typ durchsucht die Paketverwaltung nicht nur die regulären Pfade, sondern auch eine Reihe von anwendungs- und typ-spezifischen Pfaden. Eine Auflistung aller Pfade und ihrer Quellen finden Sie im Abschnitt [Speicherorte für Plugins].

**-c** *name*
: Konfigurationen. Der Name des Pakets für das Plugin *name* lautet „page::config::*name*“.

    Wir verfügen über ein vordefiniertes Plugin:

    *peg*
    : Es richtet die Anwendung als Parser-Generator ein, der Parsing-Ausdrucksgrammatiken akzeptiert und einen Packrat-Parser in Tcl erstellt. Die tatsächlich festgelegten Argumente lauten:

        ```
        	--reset
        	--append
        	--reader    peg
        	--transform reach
        	--transform use
        	--writer    me
        ```


**-r** *name*
: Sehr geehrte Leserinnen und Leser. Der Name des Pakets für das Plugin *name* lautet „page::reader::*name*“.

    Wir verfügen über fünf vordefinierte Plugins:

    *peg*
    : Interpretiert die Eingabe als Parsing-Ausdruck-Grammatik (*PEG*) und generiert dafür eine Baumdarstellung. Sowohl die Syntax von PEGs als auch die Struktur der Baumdarstellung werden in den jeweiligen Manpages erläutert.

    *hb*
    : Interpretiert die Eingabe als Tcl-Code, wie er vom Writer-Plugin *hb* generiert wird, und erzeugt dessen Baumdarstellung.

    *ser*
    : Interpretiert die Eingabe als Serialisierung eines PEG, wie sie vom Writer-Plugin *ser* unter Verwendung des Pakets **grammar::peg** generiert wurde.

    *lemon*
    : Interpretiert die Eingabe als Grammatikbeschreibung, wie sie der von Richard Hipp entwickelte Parsergenerator *LEMON* versteht, und erzeugt daraus eine Baumdarstellung. Sowohl die Eingabesyntax als auch die Struktur der Baumdarstellung sind in den jeweiligen Handbuchseiten erklärt.

    *treeser*
    : Der Interpreter interpretiert die Eingabe als Serialisierung eines **struct::tree**. Sie wird als solche validiert, jedoch nicht darüber hinaus. Es wird *nicht* davon ausgegangen, dass es sich um die Baumdarstellung einer Grammatik handelt.


**-w** *name*
: Autoren. Der Name des Pakets für das Plugin *name* lautet „page::writer::*name*“.

    Wir verfügen über acht vordefinierte Plugins:

    *identity*
    : Schreibt die eingehenden Daten einfach unverändert weiter, ohne Änderungen vorzunehmen. Dies eignet sich gut zur Überprüfung des Rohdatenergebnisses eines Lesers oder einer Transformation.

    *null*
    : Erzeugt nichts und ignoriert die eingehende Datenstruktur.

    *tree*
    : Geht davon aus, dass es sich bei der eingehenden Datenstruktur um ein „**struct::tree**“ handelt, und generiert eine eingerückte textuelle Darstellung aller Knoten, ihrer übergeordneten Beziehungen sowie ihrer Attributinformationen.

    *peg*
    : Geht davon aus, dass die eingehende Datenstruktur eine Baumdarstellung einer *PEG* oder einer anderen Grammatik ist, und gibt sie als PEG aus. Das Ergebnis ist übersichtlich formatiert und teilweise vereinfacht (Zeichenketten als Zeichenfolgen). Im Wesentlichen handelt es sich um einen „Pretty Printer“, der jedoch auch dazu verwendet werden kann, eine kanonische Darstellung der Eingabegrammatik zu erhalten.

    *tpc*
    : Geht davon aus, dass es sich bei der eingehenden Datenstruktur um eine Baumdarstellung einer *PEG* oder einer anderen Grammatik handelt, und generiert Tcl-Code, der ein Paket definiert, welches ein **grammar::peg**-Objekt enthält, das die Grammatik umfasst, wenn dieses in einen Interpreter geladen wird.

    *hb*
    : Dies ähnelt dem Writer-Plugin *tpc*, schreibt jedoch nur die Anweisungen, die statische Ausdrücke und Grammatikregeln definieren. Der Code, der das Ergebnis zu einem Paket macht, wird weggelassen.

    *ser*
    : Geht davon aus, dass es sich bei der eingehenden Datenstruktur um eine Baumdarstellung einer *PEG* oder einer anderen Grammatik handelt, führt eine Transformation auf der internen Ebene in ein **grammar::peg**-Objekt durch und schreibt deren Serialisierung aus.

    *me*
    : Geht davon aus, dass es sich bei der eingehenden Datenstruktur um eine Baumdarstellung einer *PEG* oder einer anderen Grammatik handelt, und generiert Tcl-Code zur Definition eines Pakets, das einen rekursiven Abstiegsparser mit Memoization implementiert, der auf der vom Paket **grammar::mengine** bereitgestellten Match-Engine (ME) basiert.


**-t** *name*
: Transformers. Der Name des Pakets für das Plugin *name* lautet „page::transform::*name*“.

    Wir verfügen über zwei vordefinierte Plugins:

    *reach*
    : Es wird davon ausgegangen, dass die eingehende Datenstruktur eine Baumdarstellung einer *PEG* oder einer anderen Grammatik ist. Es wird ermittelt, welche nichtterminalen Symbole und Regeln vom Startsymbol bzw. Ausdruck aus erreichbar sind. Alle nichtterminalen Symbole, die nicht erreicht wurden, werden entfernt.

    *use*
    : Es wird davon ausgegangen, dass die eingehende Datenstruktur eine Baumdarstellung einer *PEG* oder einer anderen Grammatik ist. Es wird ermittelt, welche nichtterminalen Symbole und Regeln *endliche* Folgen von terminalen Symbolen erzeugen können (im Sinne einer kontextfreien Grammatik). Alle nichtterminalen Symbole, die in diesem Sinne als nicht nützlich erachtet wurden, werden entfernt.



## Speicherorte für Plugins

Die anwendungsspezifischen Pfade, die von **page** durchsucht werden, sind entweder folgende oder stammen aus:

1. Das Verzeichnis „*~/.page/plugin*“

2. Die Variable *PAGE\_PLUGINS*

3. Der Registrierungseintrag *HKEY\_LOCAL\_MACHINE\\SOFTWARE\\PAGE\\PLUGINS*

4. Der Registrierungseintrag *HKEY\_CURRENT\_USER\\SOFTWARE\\PAGE\\PLUGINS*


Die von **page** durchsuchten typspezifischen Pfade sind entweder:

1. Das Verzeichnis „*~/.page/plugin/<TYPE>*“

2. Die Umgebungsvariable *PAGE\_<TYPE>\_PLUGINS*

3. Der Registrierungseintrag *HKEY\_LOCAL\_MACHINE\\SOFTWARE\\PAGE\\<TYPE>\\PLUGINS*

4. Der Registrierungseintrag *HKEY\_CURRENT\_USER\\SOFTWARE\\PAGE\\<TYPE>\\PLUGINS*


Dabei ist der Platzhalter *<TYPE>* stets einer der unten aufgeführten Werte, in korrekter Großschreibung.

1. reader

2. writer

3. transform

4. config


Die Registrierungseinträge gelten speziell für die Windows(tm)-Plattform; alle anderen Plattformen ignorieren sie.

Der Inhalt sowohl der Umgebungsvariablen als auch der Registrierungseinträge wird als Liste von Pfaden interpretiert, wobei die Elemente entweder durch einen Doppelpunkt (Unix) oder ein Semikolon (Windows) voneinander getrennt sind.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *page* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Page-Parsergenerator

# Copyright

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
