---
CommandName: expat
title: expat
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription:
Links:
 - expatapi
 - tdom
Keywords:
 - SAX
 - push
 - pushparser
Copyright:
---

# Name

expat - Eine Instanz eines expat-Parserobjekts anlegen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdom]{.lit}

[expat]{.cmd} [parsername]{.optarg} [-namespace]{.optarg} [arg arg ..]{.optarg}

[xml::parser]{.cmd} [parsername]{.optarg} [-namespace]{.optarg} [arg arg ..]{.optarg}
:::

# Beschreibung

Der mit *expat* oder *xml::parser* angelegte Parser, nur ein anderer Name desselben Befehls in einem eigenen Namensraum, kann jede Art von wohlgeformtem XML lesen. Die Parser sind stromorientierte XML-Parser. Vor dem Lesen werden Handler-Skripte beim Parser angemeldet. Diese Skripte werden aufgerufen, wenn der Parser die zugehörigen Strukturen im gelesenen Dokument findet. Eine Startmarke ist ein Beispiel für eine Struktur, für die sich ein Handler-Skript anmelden lässt.

Die Parser prüfen die Eingabe immer auf XML-Wohlgeformtheit und melden einen Fehler, wenn die Eingabe nicht wohlgeformt ist. Sie lesen die interne DTD und auf Wunsch die externe DTD und externe Entitäten, wenn der Bezeichner der externen Entitäten mit dem Skript -externalentitycommand aufgelöst wird, siehe dort. Mit der Option -validateCmd, siehe dort, wird die Eingabe zusätzlich geprüft.

Zusätzlich stellt der Tcl-Erweiterungscode dieses Befehls eine API bereit, um Handler in C einzuhängen. Bislang gibt es den Parser-Erweiterungsbefehl "tdom". Der von dieser Erweiterung eingebaute Handlersatz baut beim Lesen der Eingabe einen "tDOM"-DOM-Baum im Speicher.

Für die meisten Ereignisse lassen sich beliebig viele verschiedene Handler-Skripte und Handler in C anmelden. Tritt das Ereignis ein, werden sie der Reihe nach aufgerufen.

# Befehlsoptionen

**-namespace**
: Schaltet das Lesen von Namensräumen ein. Diese Option muss beim Anlegen des Parsers mit **expat** oder **xml::parser** angegeben werden. Mit **<parserobj> configure ...** lässt sich das Lesen von Namensräumen weder ein- noch ausschalten.

**-namespaceseparator**  *char*
: Diese Option wirkt nur zusammen mit *-namespace*. Sie bestimmt das Zeichen, das zwischen Namensraum-URI und lokalem Namen eingefügt wird, wenn ein XML-Elementname an ein Handler-Skript gemeldet wird. Die Vorgabe ist das Zeichen ':'. Der Wert muss eine Zeichenkette aus einem Zeichen kleiner oder gleich \\u00FF sein, vorzugsweise ein 7-Bit-ASCII-Zeichen, oder die leere Zeichenkette. Ist der Wert die leere Zeichenkette, auch wenn der Wert \\x00 ist, werden Namensraum-URI und lokaler Name ohne Trenner aneinandergehängt.

**-final**  *boolean*
: Diese Option sagt, ob die als Nächstes an die Methode parse übergebenen Dokumentdaten der letzte Teil des Dokuments sind. Der Wert "0" heißt, dass weitere Daten erwartet werden. Der Wert "1" heißt, dass nichts weiter erwartet wird. Die Vorgabe ist "1".

    Steht die Option auf "0", meldet der Parser bestimmte Fehler nicht, wenn die XML-Daten am Ende der Eingabe nicht wohlgeformt sind, etwa nicht geschlossene oder unausgeglichene Start- oder Endmarken. Stattdessen kann der Parser Daten bis zum nächsten Aufruf der Methode parse aufheben und die Meldung eines Teils der Daten aufschieben.

    Steht die Option auf "1", erzeugen Dokumente, die am Ende der Eingabe nicht wohlgeformt sind, einen Fehler.

**-validateCmd**  *<tdom schema cmd>*
: Diese Option erwartet den Namen eines tDOM-Schemabefehls. Ist sie angegeben, wird die Eingabe auch geprüft. Hat der Schemabefehl kein reportcmd gesetzt, beendet der erste Prüffehler das weitere Lesen, wie ein Wohlgeformtheitsfehler.

**-baseurl**  *url*
: Meldet dem Parser die Basis-URL des Dokuments.

**-fastcall**  *boolean*
: Voreingestellt ist diese Option 0, also aus. Ist sie an, wird jeder Handler, den die Optionen *-elementstartcommand*, *-elementendcommand* und *-characterdatacommand* von diesem Zeitpunkt an einbauen, so eingebaut, dass der Aufruf weniger Aufwand hat als üblich. Die Option darf zwischen dem Einbauen der Rückruffunktionen nach Wunsch umgeschaltet werden.

    Dafür gelten Bedingungen. Die Handler-Prozedur muss definiert sein, bevor sie als Rückruffunktion verwendet wird. Sonst wird die Rückruffunktion wie üblich eingebaut. Die Handler-Prozedur darf nicht entfernt oder neu definiert werden, solange sie als Rückruffunktion dient. Geschieht das, stürzt das Programm wahrscheinlich ab oder führt beliebigen Code aus.

    Rückruffunktionen, die eingebaut werden, während diese Option an ist, werden beim Ausführen nicht verfolgt.

**-keepTextStart**  *boolean*
: Voreingestellt ist diese Option 0, also aus. Ist sie an, bleibt die Positionsangabe des Anfangs eines Text- oder CDATA-Knotens erhalten, während die von expat manchmal stückweise gelieferten cdata-Teile gesammelt werden. Mit dieser Option sind die Positionsangaben richtig, die der Parser in einer Prozedur -characterdatacommand zurückgibt, sonst nicht. In allem anderen Handler-Code gibt der Parser immer die richtigen Positionen zurück, unabhängig vom Wert dieser Option. Sie ist voreingestellt aus, weil sie selten gebraucht wird und so ein paar CPU-Takte spart.

**-elementstartcommand**  *script*
: Legt einen Tcl-Befehl fest, der zur Startmarke eines Elements gehört. Der tatsächliche Befehl besteht aus dieser Option und mindestens zwei Argumenten: dem Elementtypnamen und der Attributliste.

    Die Attributliste ist eine Tcl-Liste aus Name-Wert-Paaren, geeignet für den Tcl-Befehl array set.

    Beispiel:

    ```
    proc HandleStart {name attlist} {
        puts stderr "Element start ==> $name has attributes $attlist"
    }

    $parser configure -elementstartcommand HandleStart

    $parser parse {<test id="123"></test>}
    ```

    Dabei wird dieser Befehl aufgerufen:

    ```
    HandleStart text {id 123}
    ```

**-elementendcommand**  *script*
: Legt einen Tcl-Befehl fest, der zur Endmarke eines Elements gehört. Der tatsächliche Befehl besteht aus dieser Option und mindestens einem Argument, dem Elementtypnamen. Ist zusätzlich die Option -reportempty gesetzt, kann der Befehl mit der Konfigurationsoption -empty aufgerufen werden, die angibt, ob das Element leer ist. Ein Beispiel steht in der Beschreibung der Option -reportempty.

    Beispiel:

    ```
    proc HandleEnd {name} {
        puts stderr "Element end ==> $name"
    }

    $parser configure -elementendcommand HandleEnd

    $parser parse {<test id="123"></test>}
    ```

    Dabei wird dieser Befehl aufgerufen:

    ```
    HandleEnd test
    ```

**-characterdatacommand**  *script*
: Legt einen Tcl-Befehl fest, der zu Zeichendaten im Dokument gehört, also zu Text. Der tatsächliche Befehl besteht aus dieser Option und einem Argument, dem Text.

    Anders als bei der C-API des expat-Parsers ist zugesichert, dass Zeichendaten der Anwendung in einem einzigen Aufruf dieses Befehls übergeben werden.

    Beispiel:

    ```
    proc HandleText {data} {
        puts stderr "Character data ==> $data"
    }

    $parser configure -characterdatacommand HandleText

    $parser parse {<test>this is a test document</test>}
    ```

    Dabei wird dieser Befehl aufgerufen:

    ```
    HandleText {this is a test document}
    ```

**-processinginstructioncommand**  *script*
: Legt einen Tcl-Befehl fest, der zu Verarbeitungsanweisungen im Dokument gehört. Der tatsächliche Befehl besteht aus dieser Option und zwei Argumenten: dem Ziel der Verarbeitungsanweisung und ihren Daten.

    Beispiel:

    ```
    proc HandlePI {target data} {
        puts stderr "Processing instruction ==> $target $data"
    }

    $parser configure -processinginstructioncommand HandlePI

    $parser parse {<test><?special this is a processing instruction?></test>}
    ```

    Dabei wird dieser Befehl aufgerufen:

    ```
    HandlePI special {this is a processing instruction}
    ```

 **-notationdeclcommand**  *script*
: Legt einen Tcl-Befehl fest, der zu einer Notationsdeklaration im Dokument gehört. Der tatsächliche Befehl besteht aus dieser Option und vier Argumenten: dem Notationsnamen, der Basis-URI des Dokuments, also dem, was die Option -baseurl gesetzt hat, dem Systembezeichner und dem öffentlichen Bezeichner. Der Notationsname ist nie leer, die anderen Argumente können es sein.

 **-externalentitycommand**  *script*
: Legt einen Tcl-Befehl fest, der zu Verweisen auf externe Entitäten im Dokument gehört. Der tatsächliche Befehl besteht aus dieser Option und drei Argumenten: der Basis-URI, dem Systembezeichner der Entität und dem öffentlichen Bezeichner der Entität. Die Basis-URI und der öffentliche Bezeichner können die leere Liste sein.

    Dieses Handler-Skript gibt eine Tcl-Liste aus drei Elementen zurück. Das erste Element sagt, wie die externe Entität an den Prozessor zurückgegeben wird. Derzeit sind die Typen "string", "channel" und "filename" erlaubt. Das zweite Element muss die absolute Basis-URI der zu lesenden externen Entität sein. Das dritte Element sind die Daten: bei Typ "string" die bereits gelesenen Daten der externen Entität als Zeichenkette, bei Typ "channel" der Name eines Tcl-Kanals, bei Typ "filename" der Pfad der zu lesenden externen Entität. Hinter den Kulissen wird die externe Entität, auf die der zurückgegebene Tcl-Kanal, die Zeichenkette oder der Dateiname zeigt, mit einem expat-Parser für externe Entitäten gelesen, mit denselben Handlersätzen wie der Hauptparser. Schlägt das Lesen der externen Entität fehl, stoppt das gesamte Lesen mit einer Fehlermeldung. Kann ein als externalentitycommand angemeldeter Tcl-Befehl eine externe Entität nicht auflösen, darf er TCL\_CONTINUE zurückgeben. Dann versucht der Wrapper den nächsten angemeldeten externalentitycommand. Kann keiner die externe Entität behandeln, stoppt das Lesen mit einem Fehler.

    Beispiel:

    ```
    proc externalEntityRefHandler {base systemId publicId} {
        if {![regexp {^[a-zA-Z]+:/} $systemId]}  {
            regsub {^[a-zA-Z]+:} $base {} base
            set basedir [file dirname $base]
            set systemId "[set basedir]/[set systemId]"
        } else {
            regsub {^[a-zA-Z]+:} $systemId systemId
        }
        if {[catch {set fd [open $systemId]}]} {
            return -code error \
                    -errorinfo "Failed to open external entity $systemId"
        }
        return [list channel $systemId $fd]
    }

    set parser [expat -externalentitycommand externalEntityRefHandler \
                      -baseurl "file:///local/doc/doc.xml" \
                      -paramentityparsing notstandalone]
    $parser parse {<?xml version='1.0'?>
    <!DOCTYPE test SYSTEM "test.dtd">
    <test/>}
    ```

    Dabei wird dieser Befehl aufgerufen:

    ```
    externalEntityRefHandler file:///local/doc/doc.xml test.dtd {}
    ```

    Externe Entitäten werden über dieses Handler-Skript nur aufgelöst, wenn es nötig ist. Externe Parameterentitäten lösen diesen Handler nur aus, wenn -paramentityparsing mit dem Argument "always" verwendet wird oder wenn -paramentityparsing mit dem Argument "notstandalone" verwendet wird und das Dokument nicht als standalone gekennzeichnet ist.

 **-unknownencodingcommand**  *script*
: Auf Tcl-Ebene nicht umgesetzt.

**-startnamespacedeclcommand**  *script*
: Legt einen Tcl-Befehl fest, der zum Beginn des Geltungsbereichs von Namensraumdeklarationen im Dokument gehört. Der tatsächliche Befehl besteht aus dieser Option und zwei Argumenten: dem Namensraum-Präfix und dem Namensraum-URI. Bei einem Attribut xmlns ist der Präfix die leere Liste. Bei einem Attribut xmlns="" ist der URI die leere Liste. Die Aufrufe der Handler für Start- und Endelement liegen zwischen den Aufrufen der Handler für Beginn und Ende der Namensraumdeklaration.

 **-endnamespacedeclcommand**  *script*
: Legt einen Tcl-Befehl fest, der zum Ende des Geltungsbereichs von Namensraumdeklarationen im Dokument gehört. Der tatsächliche Befehl besteht aus dieser Option und dem Namensraum-Präfix als Argument. Bei einem Attribut xmlns ist der Präfix die leere Liste. Die Aufrufe der Handler für Start- und Endelement liegen zwischen den Aufrufen der Handler für Beginn und Ende der Namensraumdeklaration.

 **-commentcommand**  *script*
: Legt einen Tcl-Befehl fest, der zu Kommentaren im Dokument gehört. Der tatsächliche Befehl besteht aus dieser Option und einem Argument, den Kommentardaten.

    Beispiel:

    ```
    proc HandleComment {data} {
        puts stderr "Comment ==> $data"
    }

    $parser configure -commentcommand HandleComment

    $parser parse {<test><!-- this is <obviously> a comment --></test>}
    ```

    Dabei wird dieser Befehl aufgerufen:

    ```
    HandleComment { this is <obviously> a comment }
    ```

 **-notstandalonecommand**  *script*
: Dieser Tcl-Befehl wird aufgerufen, wenn das Dokument nicht eigenständig ist. Es hat eine externe Teilmenge oder einen Verweis auf eine Parameterentität, aber kein standalone="yes". Der Aufruf hat keine weiteren Argumente.

 **-startcdatasectioncommand**  *script*
: Legt einen Tcl-Befehl fest, der zum Beginn eines CDATA-Abschnitts gehört. Der Aufruf hat keine weiteren Argumente.

 **-endcdatasectioncommand**  *script*
: Legt einen Tcl-Befehl fest, der zum Ende eines CDATA-Abschnitts gehört. Der Aufruf hat keine weiteren Argumente.

 **-elementdeclcommand**  *script*
: Legt einen Tcl-Befehl fest, der zu Elementdeklarationen gehört. Der tatsächliche Befehl besteht aus dieser Option und zwei Argumenten: dem Namen des Elements und dem Inhaltsmodell. Das Argument des Inhaltsmodells ist eine Tcl-Liste aus vier Elementen. Das erste Listenelement nennt den Typ des XML-Elements. Die sechs möglichen Typen werden als "MIXED", "NAME", "EMPTY", "CHOICE", "SEQ" oder "ANY" gemeldet. Das zweite Listenelement nennt den Quantor des Inhaltsmodells in XML-Syntax ("?", "\*" oder "+") oder ist die leere Liste. Ist der Typ "MIXED", ist der Quantor "{}", das heißt ein Element nur mit PCDATA, oder "\*", und die Elemente, die sich mit PCDATA mischen dürfen, stehen als Tcl-Liste im vierten Argument. Ist der Typ "NAME", ist der Name das dritte Argument, sonst ist das dritte Argument die leere Liste. Ist der Typ "CHOICE" oder "SEQ", enthält das vierte Argument eine Liste von Inhaltsmodellen, die wie dieses aufgebaut sind. Die Typen "EMPTY", "ANY" und "MIXED" kommen nur auf der obersten Ebene vor.

    Beispiele:

    ```
    proc elDeclHandler {name content} {
         puts "$name $content"
    }

    set parser [expat -elementdeclcommand elDeclHandler]
    $parser parse {<?xml version='1.0'?>
    <!DOCTYPE test [
    <!ELEMENT test (#PCDATA)>
    ]>
    <test>foo</test>}
    ```

    Dabei wird dieser Befehl aufgerufen:

    ```
    test {MIXED {} {} {}}

    $parser reset
    $parser parse {<?xml version='1.0'?>
    <!DOCTYPE test [
    <!ELEMENT test (a|b)>
    ]>
    <test><a/></test>}
    ```

    Dabei wird dieser Befehl aufgerufen:

    ```
    elDeclHandler test {CHOICE {} {} {{NAME {} a {}} {NAME {} b {}}}}
    ```

 **-attlistdeclcommand**  *script*
: Legt einen Tcl-Befehl fest, der zu Attlist-Deklarationen gehört. Der tatsächliche Befehl besteht aus dieser Option und fünf Argumenten. Der Handler der Attlist-Deklaration wird für \*jedes\* Attribut aufgerufen. Eine einzelne Attlist-Deklaration mit mehreren Attributen erzeugt also mehrere Aufrufe dieses Handlers. Die Argumente sind der Elementname, zu dem das Attribut gehört, der Name des Attributs, der Typ des Attributs, der Vorgabewert, der die leere Liste sein kann, und eine Marke required. Ist diese Marke wahr und der Vorgabewert nicht die leere Liste, ist das eine Vorgabe "#FIXED".

    Beispiel:

    ```
    proc attlistHandler {elname name type default isRequired} {
        puts "$elname $name $type $default $isRequired"
    }

    set parser [expat -attlistdeclcommand attlistHandler]
    $parser parse {<?xml version='1.0'?>
    <!DOCTYPE test [
    <!ELEMENT test EMPTY>
    <!ATTLIST test
              id      ID      #REQUIRED
              name    CDATA   #IMPLIED>
    ]>
    <test/>}
    ```

    Dabei werden diese Befehle aufgerufen:

    ```
    attlistHandler test id ID {} 1
    attlistHandler test name CDATA {} 0
    ```

 **-startdoctypedeclcommand**  *script*
: Legt einen Tcl-Befehl fest, der zum Beginn der DOCTYPE-Deklaration gehört. Dieser Befehl wird aufgerufen, bevor eine DTD oder die interne Teilmenge gelesen wird. Der tatsächliche Befehl besteht aus dieser Option und vier Argumenten: dem Doctype-Namen, dem Systembezeichner, dem öffentlichen Bezeichner und einem Booleschen, das angibt, ob der DOCTYPE eine interne Teilmenge hat.

 **-enddoctypedeclcommand**  *script*
: Legt einen Tcl-Befehl fest, der zum Ende der DOCTYPE-Deklaration gehört. Dieser Befehl wird nach der Verarbeitung einer externen Teilmenge aufgerufen. Der Aufruf hat keine weiteren Argumente.

 **-paramentityparsing**  *never|notstandalone|always*
: "never" schaltet das Auflösen von Parameterentitäten aus, "always" löst immer auf, und "notstandalone" nur, wenn das Dokument nicht "standalone='no'" ist. Die Vorgabe ist "never".

 **-entitydeclcommand**  *script*
: Legt einen Tcl-Befehl fest, der zu jeder Entitätsdeklaration gehört. Der tatsächliche Befehl besteht aus dieser Option und sieben Argumenten: dem Entitätsnamen, einem Booleschen, das Parameterentitäten kennzeichnet, dem Wert der Entität, der Basis-URI, dem Systembezeichner, dem öffentlichen Bezeichner und dem Notationsnamen. Je nach Art der Entitätsdeklaration können einige dieser Argumente die leere Liste sein.

 **-ignorewhitecdata**  *boolean*
: Ist diese Marke gesetzt, wird Elementinhalt, der nur aus Leerraum besteht, nicht mit **-characterdatacommand** gemeldet.

 **-ignorewhitespace**  *boolean*
: Ein anderer Name für *-ignorewhitecdata*, siehe dort.

 **-handlerset**  *name*
: Diese Option setzt den Geltungsbereich des Tcl-Handlersatzes für die configure-Optionen. Jedes Options-Wert-Paar, das in demselben Aufruf des Parsers auf diese Option folgt, ändert den genannten Tcl-Handlersatz. Ohne diese Option wird der Vorgabe-Handlersatz "default" geändert.

 **-noexpand**  *boolean*
: Normalerweise versucht der Parser, Verweise auf Entitäten aufzulösen, die in der internen Teilmenge definiert sind. Steht diese Option auf wahr, werden diese Entitäten nicht aufgelöst, sondern wörtlich über den Vorgabe-Handler gemeldet. **Warnung:** Wird diese Option auf wahr gesetzt und ist nicht für jeden Handlersatz des Parsers ein Vorgabe-Handler mit der Option -defaultcommand eingebaut, gehen alle internen Entitäten für die Handlersätze ohne Vorgabe-Handler still verloren.

**-useForeignDTD**  *<boolean>*
: Ist <boolean> wahr und hat das Dokument keine externe Teilmenge, ruft der Parser das Skript -externalentitycommand mit leeren Werten für die Argumente systemId und publicID auf. Diese Option muss gesetzt sein, bevor das erste Stück Daten gelesen wird. Sie nach Beginn des Lesens zu setzen, hat keine Wirkung. Voreingestellt wird keine fremde DTD verwendet. Die Vorgabe wird nach einem Zurücksetzen des Parsers wiederhergestellt. Ein Wert "never" von -paramentityparsing, das ist die Vorgabe, unterdrückt jeden Aufruf des Skripts -externalentitycommand. Hat das Dokument auch keine interne Teilmenge, werden die Skripte -startdoctypedeclcommand und enddoctypedeclcommand, sofern gesetzt, nicht aufgerufen.

**-billionLaughsAttackProtectionMaximumAmplification**  *<float>*
: <URL: https://en.wikipedia.org/wiki/Billion_laughs_attack> ["https://en.wikipedia.org/wiki/Billion_laughs_attack"]("https://en.wikipedia.org/wiki/Billion_laughs_attack") Diese Option steuert zusammen mit *-billionLaughsAttackProtectionActivationThreshold* die Parsergrenzen gegen Billion-Laughs-Angriffe (). Erwartet wird eine Gleitkommazahl >= 1.0. Die Option sollte nie nötig sein, die Vorgabe 100.0 reicht für wirkliche Daten. Muss der Wert für eine Nutzlast erhöht werden, die kein Angriff ist, bitte melden.

**-billionLaughsAttackProtectionActivationThreshold**  *<long>*
: <URL: https://en.wikipedia.org/wiki/Billion_laughs_attack> ["https://en.wikipedia.org/wiki/Billion_laughs_attack"]("https://en.wikipedia.org/wiki/Billion_laughs_attack") Diese Option steuert zusammen mit *-billionLaughsAttackProtectionMaximumAmplification* die Parsergrenzen gegen Billion-Laughs-Angriffe (). Erwartet wird eine positive ganze Zahl. Die Option sollte nie nötig sein, die Vorgabe 8388608 reicht für wirkliche Daten. Muss der Wert für eine Nutzlast erhöht werden, die kein Angriff ist, bitte melden.

**-setReparseDeferralEnabled**  *<boolean>*
: Expat schützt sich gegen quadratische Lesezeit durch lange Token in böswillig gebauten Dokumenten. Als Nebenwirkung kann ein Leseereignis nicht direkt nach dem Ende des betreffenden Tokens ausgelöst werden, sondern erst, nachdem der Parser weitere Bytes der Eingabe verarbeitet hat. Diese Option schaltet dieses Verhalten ab.

**-allocTrackerActivationThreshold**  *<float>*
: Diese Option steuert zusammen mit *-allocTrackerMaximumAmplification* die Parsergrenzen gegen unverhältnismäßig viel dynamischen Speicher durch böswillig gebaute Dokumente. Erwartet wird eine positive ganze Zahl. Die Option sollte nie nötig sein, die Vorgabe 100.0 reicht für wirkliche Daten. Muss der Wert für eine Nutzlast erhöht werden, die kein Angriff ist, bitte melden.

**-allocTrackerMaximumAmplification**  *<long>*
: Diese Option steuert zusammen mit *-allocTrackerActivationThreshold* die Parsergrenzen gegen unverhältnismäßig viel dynamischen Speicher durch böswillig gebaute Dokumente. Erwartet wird eine positive ganze Zahl. Die Option sollte nie nötig sein, die Vorgabe 67108864, das sind 64 MiB, reicht für wirkliche Daten. Muss der Wert für eine Nutzlast erhöht werden, die kein Angriff ist, bitte melden.


# Befehlsmethoden

**parser** **configure** *option value ?option value?*
: Setzt Konfigurationsoptionen des Parsers. Jede Befehlsoption außer *-namespace* lässt sich mit dieser Methode setzen oder ändern.

**parser** **cget** *?-handlerset name? option*
: Gibt den aktuellen Konfigurationswert der Option für den Parser zurück.

    Mit der Option -handlerset kommt die Konfiguration des genannten Handlersatzes zurück.

**parser** **currentmarkup**
: Gibt das aktuelle Markup zurück, wie es im XML steht, wenn der Aufruf aus einem Handler-Skript für Markup-Ereignisse kommt, also -elementstartcommand, -elementendcommand, -commentcommand und -processinginstructioncommand. Sonst kommt die leere Zeichenkette zurück.

**parser** **delete**
: Löscht den Parser und den Parserbefehl. Ein Parser lässt sich nicht aus einer seiner Handler-Rückruffunktionen löschen, weder direkt noch indirekt. In dem Fall wird ein Tcl-Fehler ausgelöst.

**parser** **free**
: Ein anderer Name für den Aufruf der Methode *delete*, siehe dort.

**parser** **get** *-specifiedattributecount|-idattributeindex|-currentbytecount|-currentlinenumber|-currentcolumnnumber|-currentbyteindex*
: siehe unten ...

    **-specifiedattributecount**
    : Gibt die Anzahl der Attribut-Wert-Paare zurück, die beim letzten Aufruf von elementstartcommand übergeben wurden und in der Startmarke angegeben waren, nicht als Vorgabe. Jedes Attribut-Wert-Paar zählt als 2. Das entspricht einem Index in die Attributliste, die an elementstartcommand übergeben wird.

    **-idattributeindex**
    : Gibt den Index des ID-Attributs zurück, das beim letzten Aufruf von XML\_StartElementHandler übergeben wurde, oder -1, wenn es kein ID-Attribut gibt. Jedes Attribut-Wert-Paar zählt als 2. Das entspricht einem Index in die Attributliste, die an elementstartcommand übergeben wird.

    **-currentbytecount**
    : Gibt die Anzahl der Bytes im aktuellen Ereignis zurück. Kommt 0 zurück, liegt das Ereignis in einer internen Entität.

        Bei dieser Option ist zu prüfen, ob die Parseroption *-keepTextStart* gebraucht wird.

    **-currentlinenumber**
    : Gibt die Zeilennummer der aktuellen Lesestelle zurück.

        Bei dieser Option ist zu prüfen, ob die Parseroption *-keepTextStart* gebraucht wird.

    **-currentcolumnnumber**
    : Gibt die Spaltennummer der aktuellen Lesestelle zurück.

        Bei dieser Option ist zu prüfen, ob die Parseroption *-keepTextStart* gebraucht wird.

    **-currentbyteindex**
    : Gibt den Byteindex der aktuellen Lesestelle zurück.

        Bei dieser Option ist zu prüfen, ob die Parseroption *-keepTextStart* gebraucht wird.


    Es kann immer nur ein Wert erfragt werden.

**parser** **parse** *data*
: Liest die XML-Zeichenkette *data*. Die Ereignis-Rückrufskripte werden aufgerufen, wenn ihre auslösenden Ereignisse eintreten. Diese Methode lässt sich nicht aus einer Rückruffunktion des zu verwendenden Parsers aufrufen, weder direkt noch indirekt. In dem Fall wird ein Fehler ausgelöst.

**parser** **parsechannel** *channelID*
: Liest die XML-Daten aus dem Tcl-Kanal *channelID*, ab der aktuellen Zugriffsposition, ohne Seek, bis zum Dateiende, und liest diese Daten. Die Kodierung des Kanals wird beachtet. Zum Öffnen einer Datei für diese Methode dient die Hilfsprozedur tDOM::xmlOpenFile aus der Skriptbibliothek von tDOM. Diese Methode lässt sich nicht aus einer Rückruffunktion des zu verwendenden Parsers aufrufen, weder direkt noch indirekt. In dem Fall wird ein Fehler ausgelöst.

**parser** **parsefile** *filename*
: Liest die XML-Daten direkt aus der Datei *filename* und liest diese Daten. Das geschieht mit Dateioperationen auf niedriger Ebene. Die XML-Daten müssen in US-ASCII, ISO-8859-1, UTF-8 oder UTF-16 kodiert sein. Wo das passt, ist das der schnellste Weg, XML-Daten zu lesen. Diese Methode lässt sich nicht aus einer Rückruffunktion des zu verwendenden Parsers aufrufen, weder direkt noch indirekt. In dem Fall wird ein Fehler ausgelöst.

**parser** **reset**
: Setzt den Parser zurück, damit ein weiteres Dokument gelesen werden kann. Ein Parser lässt sich nicht aus einer seiner Handler-Rückruffunktionen zurücksetzen, weder direkt noch indirekt. In diesen Fällen wird ein Tcl-Fehler ausgelöst.


# Rückgabecodes der Rückrufe

Ein Skript, das für einen der Parser-Rückrufbefehle aufgerufen wird, etwa -elementstartcommand oder -elementendcommand, darf einen anderen Fehlercode als "ok" oder "error" zurückgeben. Alle Rückruffunktionen dürfen zusätzlich "break" oder "continue" zurückgeben.

Gibt ein Rückrufskript den Fehlercode "error" zurück, wird die Verarbeitung des Dokuments beendet und der Fehler wie üblich weitergereicht.

Gibt ein Rückrufskript den Fehlercode "break" zurück, unterbleibt jede weitere Verarbeitung jedes Handler-Skripts dieses Tcl-Handlersatzes für das weitere Lesen. Andere Handlersätze sind davon nicht betroffen.

Gibt ein Rückrufskript den Fehlercode "continue" zurück, endet die Verarbeitung des aktuellen Elements und seiner Kinder für jedes Handler-Skript dieses Tcl-Handlersatzes, und die Verarbeitung geht mit dem nächsten Geschwisterelement weiter. Andere Handlersätze sind davon nicht betroffen.

Gibt ein Rückrufskript den Fehlercode "return" zurück, wird das Lesen insgesamt abgebrochen, ohne dass ein Fehler ausgelöst wird.
