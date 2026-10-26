---
CommandName: mime
title: mime
ManualSection: n
Version: 1.7.2
TclPart: tcllib
TclDescription: Mime
Links:
 - ftp
 - http
 - pop3
 - smtp
Keywords:
 - email
 - internet
 - mail
 - mime
 - net
 - rfc 2045
 - rfc 2046
 - rfc 2049
 - rfc 821
 - rfc 822
 - smtp
Copyright:
 - Copyright (c) 1999-2000 Marshall T. Rose
---

# Name

mime – Bearbeitung von MIME-Body-Teilen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [mime]{.lit} [1.7.2]{.optlit}
[::mime::initialize]{.cmd} [[-canonical]{.lit} [type/subtype]{.arg} ?-param {key value}...]{.optarg} [[-encoding]{.lit} [value]{.arg}]{.optarg} [[-header]{.lit} {key value}...]{.optarg} ([-file]{.lit} [name]{.arg} | [-string]{.lit} [value]{.arg} | [-parts]{.lit} [{token1 ... tokenN}]{.arg})
[::mime::finalize]{.cmd} [token]{.arg} [[-subordinates]{.lit} all | dynamic | none]{.optarg}
[::mime::getproperty]{.cmd} [token]{.arg} [property | -names]{.optarg}
[::mime::getheader]{.cmd} [token]{.arg} [key | -names]{.optarg}
[::mime::setheader]{.cmd} [token]{.arg} [key]{.arg} [value]{.arg} [[-mode]{.lit} write | append | delete]{.optarg}
[::mime::getbody]{.cmd} [token]{.arg} [-decode]{.optlit} [[-command]{.lit} [callback]{.arg} [[-blocksize]{.lit} [octets]{.arg}]{.optarg}]{.optarg}
[::mime::copymessage]{.cmd} [token]{.arg} [channel]{.arg}
[::mime::buildmessage]{.cmd} [token]{.arg}
[::mime::parseaddress]{.cmd} [string]{.arg}
[::mime::parsedatetime]{.cmd} ([string]{.arg} | [-now]{.lit}) [property]{.arg}
[::mime::mapencoding]{.cmd} [encoding\_name]{.arg}
[::mime::reversemapencoding]{.cmd} [charset\_type]{.arg}
:::

# Beschreibung

Das Bibliothekspaket **mime** stellt Befehle zum Erstellen und Bearbeiten von MIME-Body-Teilen bereit.

**::mime::initialize** ?**-canonical** *type/subtype* ?**-param** {*key value*}...? ?**-encoding** *value*? ?**-header** {*key value*}...?? (**-file** *name* | **-string** *value* | **-parts** {*token1* ... *tokenN*})
: Erstellt einen MIME-Teil und gibt ein Token zurück, das diesen repräsentiert.

    - Wenn die Option **-canonical** vorhanden ist, liegt der Text in kanonischer (Roh-)Form vor und kann durch Abfrage der Option **-file**, **-string** oder **-parts** ermittelt.

        Darüber hinaus können sowohl die Optionen **-param** als auch **-header** Optionen nullmal oder mehrmals vorkommen, um **Content-Type**-Parameter (z. B. **charset**) bzw. Header-Schlüsselwörter und -Werte (z. B. **Content-Disposition**) festzulegen.

        Außerdem legt **-encoding**, sofern vorhanden, die **Content-Transfer-Encoding** beim Kopieren des Hauptteils fest.

    - Wenn die Option **-canonical** nicht vorhanden ist, wird der in der Option **-file** oder **-string** enthaltene MIME-Teil analysiert, wobei gegebenenfalls dynamisch untergeordnete Elemente generiert werden.


**::mime::finalize** *token* ?**-subordinates** **all** | **dynamic** | **none**?
: Löscht den durch *token* dargestellten MIME-Teil. Die Funktion gibt eine leere Zeichenkette zurück.

    Wenn die Option **-subordinates** vorhanden ist, legt sie fest, welche untergeordneten Elemente ebenfalls gelöscht werden sollen. Der Standardwert ist **dynamic**; dabei werden alle untergeordneten Elemente, die durch **::mime::initialize** erstellt wurden, zusammen mit dem sie enthaltenden Container gelöscht.

**::mime::getproperty** *token* ?*property* | **-names**?
: Gibt eine Zeichenkette oder eine Liste von Zeichenketten zurück, die die Eigenschaften eines MIME-Teils enthalten. Wenn der Befehl mit dem Namen einer bestimmten Eigenschaft aufgerufen wird, gibt er den entsprechenden Wert zurück; wenn stattdessen **-names** gelegt wird, gibt er eine Liste aller Eigenschaften zurück; andernfalls gibt er ein serialisiertes Array aus Eigenschaften und Werten zurück.

    Die möglichen Eigenschaften sind:

    **content**
    : Der Typ/Subtyp, der den Inhalt beschreibt

    **encoding**
    : Der „Content-Transfer-Encoding“-Header

    **params**
    : Eine Liste der „Content-Type“-Parameter

    **parts**
    : Eine Liste von Tokens für die untergeordneten Elemente des Teils. Diese Eigenschaft ist nur vorhanden, wenn der MIME-Teil untergeordnete Elemente enthält.

    **size**
    : Die ungefähre Größe des Inhalts (unverschlüsselt)


**::mime::getheader** *token* ?*key* | **-names**?
: Gibt den Header eines MIME-Teils als Dictionary mit möglicherweise redundanten Schlüsseln zurück.

    Wird *key* angegeben, wird eine Liste der Werte mit übereinstimmenden Namen (ohne Berücksichtigung der Groß-/Kleinschreibung) zurückgegeben.

    Wird **-names** angegeben, wird eine Liste aller Schlüssel zurückgegeben.

**::mime::setheader** *token* *key value* ?**-mode** **write** | **append** | **delete**?
: Wenn **append** angegeben wird, wird ein neuer Header mit dem Name *key* erstellt und der Wert *value* hinzugefügt. Wenn **write** angegeben wird, werden alle vorhandenen Header, deren Name mit *key* übereinstimmt, gelöscht und anschließend ein neuer Header mit dem Name *key* und dem Wert *value* erstellt. Wird **delete** angegeben, werden alle vorhandenen Header, deren Name mit *key* übereinstimmt, gelöscht. Gibt eine Liste von Zeichenketten zurück, die den zuvor mit dem Schlüssel verknüpften Wert enthalten.

    Der Wert für **-mode** ist einer der folgenden:

    **write**
    : Der *Schlüssel*/*Wert* wird entweder angelegt oder überschrieben (Standard).

    **append**
    : Dem *Schlüssel* wird ein neuer *Wert* angehängt (der bei Bedarf angelegt wird).

    **delete**
    : Alle mit dem Schlüssel verknüpften Werte werden entfernt (der Parameter *value* wird ignoriert).


**::mime::getbody** *token* ?**-decode**? ?**-command** *callback* ?**-blocksize** *octets*??
: Gibt eine Zeichenkette zurück, die den Hauptteil des durch *token* dargestellten MIME-Teils in kanonischer Form enthält.

    Wenn die Option **-command** gesetzt ist, wird die Funktion wiederholt mit jeweils einem Fragment des Hauptteils wie folgt aufgerufen:

    ```
      uplevel #0 $callback [list "data" $fragment]
    ```

    (Die Option **-blocksize**, wenn vorhanden, legt die maximale Größe jedes an die Rückruffunktion übergebenen Fragments fest.)

    Wenn das Ende des Hauptteils erreicht ist, wird die Rückruffunktion wie folgt aufgerufen:

    ```
        uplevel #0 $callback "end"
    ```

    Alternativ wird bei Auftreten eines Fehlers die Rückruffunktion wie folgt aufgerufen:

    ```
        uplevel #0 $callback [list "error" reason]
    ```

    Unabhängig davon wird der Wert des letzten Aufrufs der Rückruffunktion durch **::mime::getbody** nach oben weitergegeben.

    Wenn die Option **-command** fehlt, gibt **::mime::getbody** einen Wert zurück, der eine Zeichenkette enthält, die den gesamten Textkörper des MIME-Teils enthält.

    Wenn die Option **-decode** fehlt, wird der oben berechnete Wert zurückgegeben, ohne dass er verändert wird. Das bedeutet, dass er in dem für das Token angegebenen Zeichensatz vorliegt und nicht im üblichen UTF-8. Wenn die Option **-decode** jedoch vorhanden ist, verwendet der Befehl die mit dem Token verknüpften Zeichensatzinformationen, um die Zeichenkette vor der Rückgabe aus ihrer ursprünglichen Kodierung in UTF-8 zu konvertieren.

**::mime::copymessage** *token* *channel*
: Kopiert den durch den Teil *token* dargestellten MIME-Inhalt in den angegebenen *Kanal*. Der Befehl wird synchron ausgeführt und nutzt „fileevent“, damit asynchrone Vorgänge unabhängig davon fortgesetzt werden können. Er gibt eine leere Zeichenkette zurück.

**::mime::buildmessage** *token*
: Gibt den durch *token* dargestellten MIME-Teil als Zeichenkette zurück. Dies ähnelt **::mime::copymessage**, nur dass die Daten als Rückgabekette zurückgegeben werden, anstatt in einen Kanal geschrieben zu werden.

**::mime::parseaddress** *string*
: Nimmt eine Zeichenkette entgegen, die eine oder mehrere Adressangaben im 822-Format enthält, und gibt eine Liste serialisierter Arrays zurück, wobei jedes Element einer der im Argument festgelegten Adressen entspricht. Wenn die Zeichenkette mehr als eine Adresse enthält, werden diese durch Kommas getrennt.

    Jedes serialisierte Array enthält die unten aufgeführten Eigenschaften. Beachten Sie, dass eine oder mehrere dieser Eigenschaften leer sein können.

    **address**
    : local@domain

    **comment**
    : Kommentar im Stil von 822

    **domain**
    : der Domain-Teil (rhs)

    **error**
    : nicht leer bei einem Parsing-Fehler

    **group**
    : Mit dieser Adresse beginnt eine Gruppe

    **friendly**
    : benutzerfreundliche Darstellung

    **local**
    : der lokale Teil (lhs)

    **memberP**
    : Diese Adresse gehört zu einer Gruppe.

    **phrase**
    : der Satzteil

    **proper**
    : Adressangabe im 822-Format

    **route**
    : Routenspezifikation im 822-Stil (obsolet)


**::mime::parsedatetime** (*string* | **-now**) *property*
: Nimmt eine Zeichenkette entgegen, die eine Datums- und Zeitangabe im 822-Format enthält, und gibt die angegebene Eigenschaft als serialisiertes Array zurück.

    Die Liste der Eigenschaften und ihrer Wertebereiche lautet wie folgt:

    **hour**
    : 0 .. 23

    **lmonth**
    : Januar, Februar, …, Dezember

    **lweekday**
    : Sonntag, Montag, … Samstag

    **mday**
    : 1 .. 31

    **min**
    : 0 .. 59

    **mon**
    : 1 .. 12

    **month**
    : Jan, Feb, …, Dez

    **proper**
    : Datums- und Zeitangabe im 822-Format

    **rclock**
    : die seit damals bis heute verstrichenen Sekunden

    **sec**
    : 0 .. 59

    **wday**
    : 0 .. 6 (So .. Mo)

    **weekday**
    : So, Mo, …, Sa

    **yday**
    : 1 .. 366

    **year**
    : 1900 ...

    **zone**
    : -720 .. 720 (Minuten östlich von GMT)


**::mime::mapencoding** *encoding\_name*
: Maps ordnet TCL-Kodierungen den für ihren MIME-Zeichensatztyp entsprechenden Name zu. Dies geschieht nur für Kodierungen, deren Zeichensatztypen bekannt waren. Die übrigen Kodierungen geben vorerst „“ zurück.

**::mime::reversemapencoding** *charset\_type*
: Ordnet MIME-Zeichensatztypen den Tcl-Kodierungsnamen zu. Unbekannte Typen geben „“ zurück.


# Bekannte Fehler

Tcllib Bug #447037
: Dieses Problem betrifft nur Nutzer, die Tcl und Mime auf einem 64-Bit-System verwenden. Die derzeit empfohlene Lösung für dieses Problem ist ein Upgrade auf Tcl Version 8.4. Diese Version bietet erweiterte 64-Bit-Unterstützung, und der Fehler tritt nicht mehr auf.

    Das Problem hätte grundsätzlich gelöst werden können, indem für dieses Paket die Verwendung von Tcl 8.4 vorgeschrieben worden wäre. Wir haben uns jedoch gegen diese Lösung entschieden, da sie eine große Anzahl nicht betroffener Nutzer dazu zwingen würde, ihren Tcl-Interpreter ohne triftigen Grund zu aktualisieren.

    Weitere Informationen finden Sie unter *Ticket 447037* Name \[/tktview?Name=447037\].


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *mime* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung

# Copyright

```
Copyright (c) 1999-2000 Marshall T. Rose
```
