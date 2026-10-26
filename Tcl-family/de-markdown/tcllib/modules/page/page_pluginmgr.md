---
CommandName: page_pluginmgr
title: page_pluginmgr
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - page
 - parser generator
 - text processing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_pluginmgr – page-Plugin-Manager

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [page::pluginmgr]{.lit} [0.3]{.optlit}
[package]{.cmd} [require]{.sub} [fileutil]{.lit}
[::page::pluginmgr::reportvia]{.cmd} [cmd]{.arg}
[::page::pluginmgr::report]{.cmd} [level]{.arg} [text]{.arg} [from ?to]{.optarg}
[::page::pluginmgr::log]{.cmd} [cmd]{.arg}
[::page::pluginmgr::configuration]{.cmd} [name]{.arg}
[::page::pluginmgr::reader]{.cmd} [name]{.arg}
[::page::pluginmgr::rconfigure]{.cmd} [dict]{.arg}
[::page::pluginmgr::rtimeable]{.cmd}
[::page::pluginmgr::rtime]{.cmd}
[::page::pluginmgr::rgettime]{.cmd}
[::page::pluginmgr::rhelp]{.cmd}
[::page::pluginmgr::rlabel]{.cmd}
[::page::pluginmgr::read]{.cmd} [read]{.arg} [eof]{.arg} [complete]{.optarg}
[read]{.ins} [num]{.sub}
[eof]{.ins}
[done]{.ins}
[::page::pluginmgr::writer]{.cmd} [name]{.arg}
[::page::pluginmgr::wconfigure]{.cmd} [dict]{.arg}
[::page::pluginmgr::wtimeable]{.cmd}
[::page::pluginmgr::wtime]{.cmd}
[::page::pluginmgr::wgettime]{.cmd}
[::page::pluginmgr::whelp]{.cmd}
[::page::pluginmgr::wlabel]{.cmd}
[::page::pluginmgr::write]{.cmd} [chan]{.arg} [data]{.arg}
[::page::pluginmgr::transform]{.cmd} [name]{.arg}
[::page::pluginmgr::tconfigure]{.cmd} [id]{.arg} [dict]{.arg}
[::page::pluginmgr::ttimeable]{.cmd} [id]{.arg}
[::page::pluginmgr::ttime]{.cmd} [id]{.arg}
[::page::pluginmgr::tgettime]{.cmd} [id]{.arg}
[::page::pluginmgr::thelp]{.cmd} [id]{.arg}
[::page::pluginmgr::tlabel]{.cmd} [id]{.arg}
[::page::pluginmgr::transform\_do]{.cmd} [id]{.arg} [data]{.arg}
[page\_cdefinition]{.cmd}
[page\_rfeature]{.cmd} [name]{.arg}
[page\_rtime]{.cmd}
[page\_rgettime]{.cmd}
[page\_rlabel]{.cmd}
[page\_rhelp]{.cmd}
[page\_roptions]{.cmd}
[page\_rconfigure]{.cmd} [option]{.arg} [value]{.arg}
[page\_rrun]{.cmd}
[page\_read]{.cmd} [num]{.arg}
[page\_read\_done]{.cmd}
[page\_eof]{.cmd}
[page\_info]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_warning]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_error]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_log\_info]{.cmd} [text]{.arg}
[page\_log\_warning]{.cmd} [text]{.arg}
[page\_log\_error]{.cmd} [text]{.arg}
[page\_wfeature]{.cmd}
[page\_wtime]{.cmd}
[page\_wgettime]{.cmd}
[page\_wlabel]{.cmd}
[page\_whelp]{.cmd}
[page\_woptions]{.cmd}
[page\_wconfigure]{.cmd} [option]{.arg} [value]{.arg}
[page\_wrun]{.cmd} [chan]{.arg} [data]{.arg}
[page\_info]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_warning]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_error]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_log\_info]{.cmd} [text]{.arg}
[page\_log\_warning]{.cmd} [text]{.arg}
[page\_log\_error]{.cmd} [text]{.arg}
[page\_tfeature]{.cmd}
[page\_ttime]{.cmd}
[page\_tgettime]{.cmd}
[page\_tlabel]{.cmd}
[page\_thelp]{.cmd}
[page\_toptions]{.cmd}
[page\_tconfigure]{.cmd} [option]{.arg} [value]{.arg}
[page\_trun]{.cmd} [chan]{.arg} [data]{.arg}
[page\_info]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_warning]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_error]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_log\_info]{.cmd} [text]{.arg}
[page\_log\_warning]{.cmd} [text]{.arg}
[page\_log\_error]{.cmd} [text]{.arg}
:::

# Beschreibung

Dieses Paket enthält den Plugin-Manager, der das Herzstück der Anwendung **page** bildet. Er verwaltet die verschiedenen Reader-, Writer-, Konfigurations- und Transformations-Plugins, die den Text tatsächlich verarbeiten (lesen, transformieren und schreiben).

Alle Plugins werden in eigens dafür vorbereitete Slave-Interpreter geladen. Obwohl sie mithilfe von Paketen implementiert sind, benötigen sie diese spezielle Umgebung und können nicht in einem einfachen Interpreter wie tclsh verwendet werden. Aus diesem Grund werden sie im Abschnitt [Vordefinierte Plugins] nur allgemein beschrieben und nicht als reguläre Pakete dokumentiert. Es wird erwartet, dass sie den in den Abschnitten festgelegten APIs folgen.

1. [API für Konfigurations-Plugins]

2. [API des Reader-Plugins]

3. [API des Writer-Plugins]

4. **API DES TRANSFORM-PLUGINS**


je nach Typ.

# API

**::page::pluginmgr::reportvia** *cmd*
: Dieser Befehl definiert die Rückruffunktion, die **::page::pluginmgr::report** (siehe unten) verwendet, um Eingabefehler und Warnungen zu melden. Standardmäßig werden solche Meldungen in den Standardfehlerkanal geschrieben.

**::page::pluginmgr::report** *level* *text* ?*from* ?*to*??
: Dieser Befehl meldet Eingabefehler und Warnungen. Standardmäßig werden solche Meldungen in die Standardfehlerausgabe geschrieben. Das lässt sich ändern, indem mit **::page::pluginmgr::reportvia** eine eigene Rückruffunktion gesetzt wird (siehe oben).

    Die Argumente *level* und *text* legen die Wichtigkeit der Meldung und die Meldung selbst fest. Die zulässigen Werte für Ersteres stehen im Paket **logger**.

    Die optionalen Argumente *from* und *to* kann der Aufrufer verwenden, um die Stelle oder den Bereich in der Eingabe anzugeben, an der das gemeldete Problem aufgetreten ist. Jedes davon ist eine Liste mit zwei Elementen, der Zeile und der Spalte in der Eingabe, in dieser Reihenfolge.

**::page::pluginmgr::log** *cmd*
: Dieser Befehl definiert eine Protokoll-Rückruffunktion, die geladene Plugins zum Melden interner Fehler, Warnungen und allgemeiner Informationen verwenden. Die leere Zeichenkette als Rückruffunktion schaltet die Protokollierung ab.

    Hinweis: Das *cmd* muss vom Paket **logger** erzeugt worden sein oder derselben API folgen.

    Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.

**::page::pluginmgr::configuration** *name*
: Dieser Befehl lädt das benannte Konfigurations-Plugin, ruft die darin kodierten Optionen ab und entlädt es anschließend sofort wieder.

    Ist *name* der Pfad zu einer Datei, wird zuerst versucht, diese Datei als Plugin zu laden; schlägt das fehl, wird die Datei geöffnet und ihr Inhalt als Liste von Optionen und deren Argumenten gelesen, getrennt durch Leerzeichen, Tabulatoren und Zeilenumbrüche, gegebenenfalls quotiert mit einfachen und doppelten Anführungszeichen.

    Die von Konfigurations-Plugins erwartete API steht im Abschnitt [API für Konfigurations-Plugins].

    Das Ergebnis des Befehls ist die Liste der abgerufenen Optionen.

**::page::pluginmgr::reader** *name*
: Dieser Befehl lädt das angegebene Reader-Plugin und initialisiert es. Das Ergebnis des Befehls ist eine Liste der Optionen, die das Plugin versteht.

    Es kann jeweils nur ein Reader-Plugin geladen werden. Das Laden eines weiteren Reader-Plugins führt dazu, dass das zuvor geladene Reader-Plugin deinitialisiert und entladen wird.

    Informationen zur API, die von Reader-Plugins erwartet wird, finden Sie im Abschnitt [API des Reader-Plugins].

**::page::pluginmgr::rconfigure** *dict*
: Dieser Befehl konfiguriert das geladene Reader-Plugin. Die Optionen und ihre Werte werden als Tcl-Dictionary angegeben. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::page::pluginmgr::rtimeable**
: Dieser Befehl prüft, ob das geladene Reader-Plugin in der Lage ist, Zeitstatistiken zu erfassen. Das Ergebnis des Befehls ist ein boolescher Wert. Das Ergebnis lautet **true**, wenn das Plugin zeitlich erfasst werden kann, und andernfalls **false**.

**::page::pluginmgr::rtime**
: Dieser Befehl aktiviert die Erfassung von Zeitstatistiken im geladenen Reader-Plugin.

**::page::pluginmgr::rgettime**
: Dieser Befehl ruft die erfassten Zeitstatistiken des geladenen Reader-Plugins ab, nachdem dieses ausgeführt wurde.

**::page::pluginmgr::rhelp**
: Dieser Befehl ruft die Hilfe-Zeichenkette des geladenen Reader-Plugins ab. Es wird erwartet, dass diese im *doctools*-Format vorliegt.

**::page::pluginmgr::rlabel**
: Dieser Befehl ruft den für Menschen lesbaren Namen des geladenen Reader-Plugins ab.

**::page::pluginmgr::read** *read* *eof* ?*complete*?
: Dieser Befehl ruft das geladene Reader-Plugin auf, um die Eingabe zu verarbeiten, und gibt die Ergebnisse des Plugins als eigenes Ergebnis zurück. Die Eingabe ist über die Rückruffunktionen *read* und *eof* erreichbar. Das optionale *done* kann abfangen, wann das Plugin die Verarbeitung abgeschlossen hat. Alle Argumente sind Befehlspräfixe.

    Das Plugin ruft die Rückruffunktionen in den folgenden Situationen auf:

    *read* *num*
    : wird aufgerufen, wenn Eingabe zum Verarbeiten benötigt wird, mit der Anzahl der angeforderten Zeichen oder Bytes. Als Ergebnis wird die Eingabe erwartet, die das Plugin benötigt.

    *eof*
    : wird vom Plugin aufgerufen, um zu prüfen, ob die Eingabe das Ende des Datenstroms erreicht hat. Als Ergebnis wird ein boolescher Wert erwartet: **true**, wenn die Eingabe das EOF erreicht hat, und andernfalls **false**.

    *done*
    : wird aufgerufen, wenn das Plugin die Verarbeitung der Eingabe abgeschlossen hat.


**::page::pluginmgr::writer** *name*
: Dieser Befehl lädt das benannte Writer-Plugin und initialisiert es. Das Ergebnis des Befehls ist eine Liste der Optionen, die das Plugin versteht.

    Es kann jeweils nur ein Writer-Plugin geladen werden. Das Laden eines weiteren Writer-Plugins führt dazu, dass das zuvor geladene Writer-Plugin deinitialisiert und entladen wird.

    Die von Writer-Plugins erwartete API steht im Abschnitt [API des Writer-Plugins].

**::page::pluginmgr::wconfigure** *dict*
: Dieser Befehl konfiguriert das geladene Writer-Plugin. Die Optionen und ihre Werte werden als Tcl-Dictionary übergeben. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::page::pluginmgr::wtimeable**
: Dieser Befehl prüft, ob das geladene Writer-Plugin in der Lage ist, Ausführungszeiten zu messen. Das Ergebnis des Befehls ist ein boolescher Wert. Das Ergebnis lautet **true**, wenn das Plugin zeitlich gemessen werden kann, und andernfalls **false**.

**::page::pluginmgr::wtime**
: Dieser Befehl aktiviert die Erfassung von Zeitstatistiken im geladenen Writer-Plugin.

**::page::pluginmgr::wgettime**
: Dieser Befehl ruft die erfassten Zeitstatistiken des geladenen Writer-Plugins ab, nachdem dieses ausgeführt wurde.

**::page::pluginmgr::whelp**
: Dieser Befehl ruft die Hilfe-Zeichenkette des geladenen Writer-Plugins ab. Es wird erwartet, dass diese im *doctools*-Format vorliegt.

**::page::pluginmgr::wlabel**
: Dieser Befehl ruft den für Menschen lesbaren Namen des geladenen Writer-Plugins ab.

**::page::pluginmgr::write** *chan* *data*
: Das geladene Writer-Plugin wird aufgerufen, um die Ausgabe zu erzeugen. Es erhält die *data*, aus denen die Ausgabe erzeugt werden soll, und das Tcl-Handle *chan* des Kanals, in den die erzeugte Ausgabe geschrieben wird. Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.

**::page::pluginmgr::transform** *name*
: Dieser Befehl lädt das angegebene Transformations-Plugin und initialisiert es. Das Ergebnis des Befehls ist eine Liste mit zwei Elementen, die in dieser Reihenfolge die Plugin-ID und eine Liste der vom Plugin unterstützten Optionen enthält.

    Es können mehrere Transformations-Plugins geladen werden, die über Handles identifiziert werden.

    Informationen zur API, die von Transformations-Plugins erwartet wird, finden Sie im Abschnitt **API DES TRANSFORM-PLUGINS**.

**::page::pluginmgr::tconfigure** *id* *dict*
: Dieser Befehl konfiguriert das angegebene Transformations-Plugin. Die Optionen und ihre Werte werden als Tcl-Dictionary angegeben. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::page::pluginmgr::ttimeable** *id*
: Dieser Befehl prüft, ob das angegebene Transformations-Plugin in der Lage ist, Zeitstatistiken zu erfassen. Das Ergebnis des Befehls ist ein boolescher Wert. Das Ergebnis lautet **true**, wenn das Plugin zeitlich erfasst werden kann, andernfalls **false**.

**::page::pluginmgr::ttime** *id*
: Dieser Befehl aktiviert die Erfassung von Zeitstatistiken im angegebenen Transformations-Plugin.

**::page::pluginmgr::tgettime** *id*
: Dieser Befehl ruft die erfassten Zeitstatistiken des angegebenen Transformations-Plugins nach dessen Ausführung ab.

**::page::pluginmgr::thelp** *id*
: Dieser Befehl ruft die Hilfe-Zeichenkette des angegebenen Transformations-Plugins ab. Diese sollte im *doctools*-Format vorliegen.

**::page::pluginmgr::tlabel** *id*
: Dieser Befehl ruft den für Menschen lesbaren Namen des identifizierten Transformations-Plugins ab.

**::page::pluginmgr::transform\_do** *id* *data*
: Das identifizierte Transformations-Plugin wird aufgerufen, um die angegebenen *data* zu verarbeiten. Das Ergebnis des Plugins wird als Ergebnis des Befehls zurückgegeben.


# API für Konfigurations-Plugins

Von Konfigurations-Plugins wird erwartet, dass sie einen einzigen Befehl bereitstellen, der im Folgenden beschrieben wird.

**page\_cdefinition**
: Dieser Befehl eines Konfigurations-Plugins wird vom Plugin-Manager aufgerufen, um ihn auszuführen. Das Ergebnis muss eine Liste von Optionen und Werten sein, die verarbeitet werden sollen.


Konfigurations-Plugins erwarten nicht, dass die Umgebung spezielle Befehle bereitstellt.

Es wird davon ausgegangen, dass ein Konfigurations-Plugin mit der Bezeichnung **FOO** durch das Paket **page::config::FOO** implementiert wird.

Konfigurations-Plugins werden in einem Schritt geladen, ausgeführt und entladen; sie werden nicht im Speicher gehalten. Der Befehl hierfür lautet **::page::pluginmgr::configuration**.

# API des Reader-Plugins

Von Reader-Plugins wird erwartet, dass sie die nachfolgend beschriebenen Befehle bereitstellen.

**page\_rfeature** *name*
: Dieser Befehl nimmt den *name* eines Merkmals entgegen und gibt ein boolesches Flag zurück, das angibt, ob das Merkmal vom Plugin unterstützt wird oder nicht. Das Ergebnis muss **true** lauten, wenn das Merkmal unterstützt wird, und andernfalls **false**.

    Im Abschnitt [Funktionen] stehen die möglichen Merkmale, nach denen der Plugin-Manager fragt.

**page\_rtime**
: Dieser Befehl wird aufgerufen, um die Erfassung von Zeitstatistiken zu aktivieren.

**page\_rgettime**
: Dieser Befehl wird aufgerufen, um die erfassten Zeitstatistiken abzurufen.

**page\_rlabel**
: Dieser Befehl wird aufgerufen, um eine für Menschen lesbare Bezeichnung für das Plugin abzurufen.

**page\_rhelp**
: Dieser Befehl wird aufgerufen, um einen Hilfetext für ein Plugin abzurufen. Der Text sollte im *doctools*-Format vorliegen.

**page\_roptions**
: Dieser Befehl wird aufgerufen, um die vom Plugin unterstützten Optionen abzurufen.

**page\_rconfigure** *option* *value*
: Dieser Befehl wird aufgerufen, um das Plugin neu zu konfigurieren; dabei wird insbesondere die angegebene *option* auf den neuen *value* gesetzt.

**page\_rrun**
: Dieser Befehl wird aufgerufen, um den Eingabestrom gemäß der aktuellen Konfiguration des Plugins zu verarbeiten. Das Ergebnis des Befehls ist das Ergebnis der Verarbeitung.


Reader-Plugins erwarten, dass die Umgebung die folgenden speziellen Befehle bereitstellt.

**page\_read** *num*
: Dieser Befehl wird aufgerufen, um *num* Zeichen/Bytes aus der Eingabe zu lesen. Das Ergebnis muss aus *num* Zeichen/Bytes bestehen.

**page\_read\_done**
: Dieser Befehl wird aufgerufen, um zu signalisieren, dass das Plugin die Verarbeitung der Eingabe abgeschlossen hat.

**page\_eof**
: Dieser Befehl wird aufgerufen, um zu prüfen, ob der Eingabestrom sein Ende erreicht hat. Das Ergebnis muss ein boolescher Wert sein: **true**, wenn das Ende der Eingabe erreicht ist, andernfalls **false**.

**page\_info** *text* ?*from* ?*to*??
: Wird aufgerufen, um dem Benutzer bestimmte Informationen anzuzeigen. Kann einen Ort oder einen Bereich in der Eingabe angeben. Jede Ortsangabe, sofern vorhanden, ist eine Liste mit zwei Elementen, die Zeilen- und Spaltennummern enthält.

**page\_warning** *text* ?*from* ?*to*??
: Wird aufgerufen, um dem Benutzer eine Warnung zu melden. Kann eine Stelle oder einen Bereich in der Eingabe angeben. Jede Positionsangabe, sofern vorhanden, ist eine Liste mit zwei Elementen, die Zeilen- und Spaltennummern enthält.

**page\_error** *text* ?*from* ?*to*??
: Wird aufgerufen, um dem Benutzer einen Fehler zu melden. Kann auf eine Stelle oder einen Bereich in der Eingabe hinweisen. Jede Positionsangabe, sofern vorhanden, ist eine Liste mit zwei Elementen, die Zeilen- und Spaltennummern enthält.

**page\_log\_info** *text*
: Wird aufgerufen, um bestimmte interne Informationen zu melden.

**page\_log\_warning** *text*
: Wird aufgerufen, um eine interne Warnung zu melden.

**page\_log\_error** *text*
: Wird aufgerufen, um einen internen Fehler zu melden.


Es wird erwartet, dass ein Reader-Plugin mit der Bezeichnung **FOO** durch das Paket **page::reader::FOO** implementiert wird.

Reader-Plugins werden mit dem Befehl **::page::pluginmgr::reader** geladen. Es kann höchstens ein Reader-Plugin im Speicher verbleiben.

# API des Writer-Plugins

Von Writer-Plugins wird erwartet, dass sie die folgenden Befehle bereitstellen, die im Folgenden beschrieben werden.

**page\_wfeature**
: Dieser Befehl nimmt den *name* eines Merkmals entgegen und gibt ein boolesches Flag zurück, das angibt, ob das Merkmal vom Plugin unterstützt wird oder nicht. Das Ergebnis muss **true** lauten, wenn das Merkmal unterstützt wird, und andernfalls **false**.

    Im Abschnitt [Funktionen] stehen die möglichen Merkmale, nach denen der Plugin-Manager fragt.

**page\_wtime**
: Dieser Befehl wird aufgerufen, um die Erfassung von Zeitstatistiken zu aktivieren.

**page\_wgettime**
: Dieser Befehl wird aufgerufen, um die erfassten Zeitstatistiken abzurufen.

**page\_wlabel**
: Dieser Befehl wird aufgerufen, um eine für Menschen lesbare Bezeichnung für das Plugin abzurufen.

**page\_whelp**
: Dieser Befehl wird aufgerufen, um einen Hilfetext für ein Plugin abzurufen. Der Text sollte im *doctools*-Format vorliegen.

**page\_woptions**
: Dieser Befehl wird aufgerufen, um die vom Plugin unterstützten Optionen abzurufen.

**page\_wconfigure** *option* *value*
: Dieser Befehl wird aufgerufen, um das Plugin neu zu konfigurieren; dabei wird insbesondere die angegebene *option* auf den neuen *value* gesetzt.

**page\_wrun** *chan* *data*
: Dieser Befehl wird aufgerufen, um die angegebenen *data* zu verarbeiten und in den Ausgabestrom *chan* zu schreiben. Bei *chan* handelt es sich um ein Tcl-Kanal-Handle, das zum Schreiben geöffnet wurde. Das Ergebnis des Befehls ist die leere Zeichenkette.


Writer-Plugins erwarten, dass die Umgebung die folgenden speziellen Befehle bereitstellt.

**page\_info** *text* ?*from* ?*to*??
: Wird aufgerufen, um dem Benutzer bestimmte Informationen anzuzeigen. Kann einen Ort oder einen Bereich in der Eingabe angeben. Jede Ortsangabe, sofern vorhanden, ist eine Liste mit zwei Elementen, die Zeilen- und Spaltennummern enthält.

**page\_warning** *text* ?*from* ?*to*??
: Wird aufgerufen, um dem Benutzer eine Warnung zu melden. Kann eine Stelle oder einen Bereich in der Eingabe angeben. Jede Positionsangabe, sofern vorhanden, ist eine Liste mit zwei Elementen, die Zeilen- und Spaltennummern enthält.

**page\_error** *text* ?*from* ?*to*??
: Wird aufgerufen, um dem Benutzer einen Fehler zu melden. Kann auf eine Stelle oder einen Bereich in der Eingabe hinweisen. Jede Positionsangabe, sofern vorhanden, ist eine Liste mit zwei Elementen, die Zeilen- und Spaltennummern enthält.

**page\_log\_info** *text*
: Wird aufgerufen, um bestimmte interne Informationen zu melden.

**page\_log\_warning** *text*
: Wird aufgerufen, um eine interne Warnung zu melden.

**page\_log\_error** *text*
: Wird aufgerufen, um einen internen Fehler zu melden.


Es wird erwartet, dass ein Writer-Plugin mit der Bezeichnung **FOO** durch das Paket **page::writer::FOO** implementiert wird.

Writer-Plugins werden mit dem Befehl **::page::pluginmgr::writer** geladen. Es kann höchstens ein Writer-Plugin im Speicher gehalten werden.

# API des Transform-Plugins

Von Transformations-Plugins wird erwartet, dass sie die folgenden Befehle bereitstellen, die im Folgenden beschrieben werden.

**page\_tfeature**
: Dieser Befehl nimmt den *name* eines Merkmals entgegen und gibt ein boolesches Flag zurück, das angibt, ob das Merkmal vom Plugin unterstützt wird oder nicht. Das Ergebnis muss **true** lauten, wenn das Merkmal unterstützt wird, und andernfalls **false**.

    Im Abschnitt [Funktionen] stehen die möglichen Merkmale, nach denen der Plugin-Manager fragt.

**page\_ttime**
: Dieser Befehl wird aufgerufen, um die Erfassung von Zeitstatistiken zu aktivieren.

**page\_tgettime**
: Dieser Befehl wird aufgerufen, um die erfassten Zeitstatistiken abzurufen.

**page\_tlabel**
: Dieser Befehl wird aufgerufen, um eine für Menschen lesbare Bezeichnung für das Plugin abzurufen.

**page\_thelp**
: Dieser Befehl wird aufgerufen, um einen Hilfetext für ein Plugin abzurufen. Der Text sollte im *doctools*-Format vorliegen.

**page\_toptions**
: Dieser Befehl wird aufgerufen, um die vom Plugin unterstützten Optionen abzurufen.

**page\_tconfigure** *option* *value*
: Dieser Befehl wird aufgerufen, um das Plugin neu zu konfigurieren; dabei wird insbesondere die angegebene *option* auf den neuen *value* gesetzt.

**page\_trun** *chan* *data*
: Dieser Befehl wird aufgerufen, um die angegebenen *data* zu verarbeiten und in den Ausgabestrom *chan* zu schreiben. Bei *chan* handelt es sich um ein Tcl-Kanal-Handle, das zum Schreiben geöffnet wurde. Das Ergebnis des Befehls ist die leere Zeichenkette.


Transformations-Plugins erwarten, dass die Umgebung die folgenden speziellen Befehle bereitstellt.

**page\_info** *text* ?*from* ?*to*??
: Wird aufgerufen, um dem Benutzer bestimmte Informationen anzuzeigen. Kann einen Ort oder einen Bereich in der Eingabe angeben. Jede Ortsangabe, sofern vorhanden, ist eine Liste mit zwei Elementen, die Zeilen- und Spaltennummern enthält.

**page\_warning** *text* ?*from* ?*to*??
: Wird aufgerufen, um dem Benutzer eine Warnung zu melden. Kann eine Stelle oder einen Bereich in der Eingabe angeben. Jede Positionsangabe, sofern vorhanden, ist eine Liste mit zwei Elementen, die Zeilen- und Spaltennummern enthält.

**page\_error** *text* ?*from* ?*to*??
: Wird aufgerufen, um dem Benutzer einen Fehler zu melden. Kann auf eine Stelle oder einen Bereich in der Eingabe hinweisen. Jede Positionsangabe, sofern vorhanden, ist eine Liste mit zwei Elementen, die Zeilen- und Spaltennummern enthält.

**page\_log\_info** *text*
: Wird aufgerufen, um bestimmte interne Informationen zu melden.

**page\_log\_warning** *text*
: Wird aufgerufen, um eine interne Warnung zu melden.

**page\_log\_error** *text*
: Wird aufgerufen, um einen internen Fehler zu melden.


Es wird erwartet, dass ein Transformations-Plugin **FOO** durch das Paket **page::transform::FOO** implementiert wird.

Transformations-Plugins werden mit dem Befehl **::page::pluginmgr::transform** geladen. Es können mehrere Transformations-Plugins im Speicher gehalten werden.

# Vordefinierte Plugins

Die folgenden vordefinierten Plugins sind bekannt, d. h., sie werden vom Modul page bereitgestellt.

Configuration
: siehe unten ...

    peg
    : Gibt eine Reihe von Optionen zurück, mit denen die Anwendung **page** für die Verarbeitung einer PEG-Grammatik und die Generierung von ME-Code konfiguriert werden kann. Weitere Einzelheiten stehen in den Paketen **grammar\_peg**, **grammar\_me** und verwandten Paketen.


Reader
: siehe unten ...

    hb
    : Erwartet einen sogenannten *half-baked PEG container* als Eingabe und gibt den entsprechenden abstrakten Syntaxbaum zurück. Das Writer-Plugin *hb* erzeugt diese Art von Eingabe.

    lemon
    : Erwartet eine Grammatikbeschreibung, wie sie vom LEMON-Parsergenerator von Richard Hipp verarbeitet wird, und gibt einen abstrakten Syntaxbaum dafür zurück.

    peg
    : Erwartet eine Grammatikspezifikation in Form einer Parsing Expression Grammar (PEG) und gibt einen abstrakten Syntaxbaum dafür zurück.

    ser
    : Erwartet als Eingabe die serialisierte Form einer Parsing Expression Grammar, wie sie das Paket **grammar::peg** erzeugt, wandelt sie in einen äquivalenten abstrakten Syntaxbaum um und gibt diesen zurück.

    treeser
    : Erwartet als Eingabe die vom Paket **struct::tree** generierte serialisierte Form eines Baums und gibt diese nach der Validierung zurück.


Writer
: siehe unten ...

    hb
    : Erwartet als Eingabe einen abstrakten Syntaxbaum für eine Parsing Expression Grammar und schreibt ihn als sogenannten *half-baked PEG container* aus.

    identity
    : Nimmt jede Eingabe entgegen und schreibt sie unverändert aus.

    mecpu
    : Erwartet symbolischen Assembler-Code für die MatchEngine-CPU (siehe das Paket **grammar::me::cpu** und zugehörige Pakete) und gibt diesen als Tcl-Code für einen Parser aus.

    me
    : Erwartet als Eingabe einen abstrakten Syntaxbaum für eine Parsing Expression Grammar und schreibt ihn als Tcl-Code für die MatchEngine aus (siehe das Paket **grammar::me** und verwandte Pakete), die Eingabe in dieser Grammatik parst.

    null
    : Nimmt beliebige Eingaben entgegen und gibt nichts aus. Das logische Äquivalent zu /dev/null.

    peg
    : Erwartet als Eingabe einen abstrakten Syntaxbaum für eine Parsing Expression Grammar und gibt diesen in Form einer kanonischen PEG aus, die vom Reader-Plugin *peg* gelesen werden kann.

    ser
    : Erwartet als Eingabe einen abstrakten Syntaxbaum für eine Parsing Expression Grammar und gibt diesen als serialisierten PEG-Container aus, der vom Reader-Plugin *ser* gelesen werden kann.

    tpc
    : Erwartet als Eingabe einen abstrakten Syntaxbaum für eine Parsing Expression Grammar und gibt diesen als Tcl-Code aus, der einen PEG-Container initialisiert, wie er vom Paket **grammar::peg** bereitgestellt wird.

    tree
    : Nimmt einen beliebigen serialisierten Baum (gemäß dem Paket **struct::tree**) als Eingabe entgegen und gibt ihn in einem generischen, eingerückten Format aus.


Transformation
: siehe unten ...

    mecpu
    : Nimmt einen abstrakten Syntaxbaum für eine Parsing Expression Grammar als Eingabe entgegen, generiert symbolischen Assembler-Code für die MatchEngine-CPU und gibt diesen als Ergebnis zurück (siehe das Paket **grammar::me::cpu** und zugehörige Pakete).

    reachable
    : Nimmt einen abstrakten Syntaxbaum für eine Parsing Expression Grammar als Eingabe entgegen, führt eine Erreichbarkeitsanalyse durch und gibt den veränderten und annotierten Baum zurück.

    realizable
    : Nimmt einen abstrakten Syntaxbaum für eine Parsing Expression Grammar als Eingabe entgegen, führt eine Realisierbarkeitsanalyse durch und gibt den modifizierten und mit Anmerkungen versehenen Baum zurück.



# Funktionen

Der Plugin-Manager prüft die Plugins derzeit nur auf ein einziges Merkmal, **timeable**. Von einem Plugin, das dieses Merkmal unterstützt, wird angenommen, dass es auf Anforderung Zeitstatistiken erfassen kann.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *page* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Page-Parsergenerator

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
