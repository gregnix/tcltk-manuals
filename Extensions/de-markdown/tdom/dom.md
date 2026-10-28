---
CommandName: dom
title: dom
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription:
Keywords:
 - XML
 - DOM
 - document
 - node
 - parsing
Copyright:
---

# Name

dom - Aus XML einen DOM-Baum im Speicher anlegen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdom]{.lit}

[dom]{.cmd} [method]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Dieser Befehl legt DOM-Bäume im Speicher an. Im üblichen Fall wird eine Zeichenkette mit einem XML-Dokument gelesen und in einen DOM-Baum umgewandelt. Andere Eingaben können HTML oder JSON sein. *method* nennt den Unterbefehl.

Die gültigen Methoden sind:

**dom** **parse** ?*options***?** ?*data***? ?objvar?**
: Liest *data* und baut daraus im Speicher einen DOM-Baum. Dazu gibt es einen Tcl-Objektbefehl für dieses DOM-Dokument. Beispiel:

    ```
    dom parse $xml doc
    $doc documentElement root
    ```

    Das liest die XML-Daten in der Variablen xml, legt den DOM-Baum im Speicher an, erzeugt einen Verweis auf das Dokumentobjekt, in Tcl sichtbar als Dokument-Objektbefehl, und weist diesen neuen Objektbefehl der Variablen doc zu. Verlässt die Variable doc den Geltungsbereich, werden der DOM-Baum und das zugehörige Tcl-Befehlsobjekt (Dokument und alle Knotenobjekte) von selbst freigegeben.

    Statt des Arguments *objvar* kann der zurückgegebene Objektbefehl verwendet werden:

    ```
    set document [dom parse $xml]
    set root     [$document documentElement]
    ```

    Das legt einen dauerhaften DOM-Baum an, der nicht von selbst freigegeben wird. Damit der DOM-Baum und die zugehörigen Tcl-Objektbefehle (Dokument, Knoten und Fragmentknoten) frei werden, muss der Dokument-Objektbefehl ausdrücklich gelöscht werden, mit:

    ```
    $document delete
    ```

    or

    ```
    rename $document ""
    ```

    Voreingestellt werden keine Textknoten eingefügt, die nur aus Leerraum bestehen. Dabei gilt das Attribut *xml:space="preserve"*, und innerhalb eines solchen Teilbaums stellt *xml:space="default"* die Vorgabe wieder her.

    Die gültigen Optionen sind:

    **-simple**
    : Mit *-simple* wird ein einfacher, schneller Parser verwendet. Er entspricht der XML-Empfehlung nicht vollständig. Einlesen und Aufbau des DOM sollten damit etwa doppelt so schnell sein. Die Kodierung der Daten wird im Parser nicht umgewandelt. Der einfache Parser beachtet keine Kodierungsangabe in der XML-Deklaration. Er überspringt die interne DTD-Teilmenge und ignoriert, was darin steht. Vorgabewerte von Attributen kommen deshalb nicht in den Baum, auch wenn die zugehörige Attributdeklaration in der internen Teilmenge steht. Interne oder externe Entitätsverweise werden nicht aufgelöst, außer den vordefinierten Entitäten und Zeichenverweisen.

    **-html**
    : Mit *-html* wird ein schneller HTML-Parser verwendet, der auch fehlerhaftes HTML in einen DOM-Baum zu lesen versucht. Hat das übergebene HTML-Dokument kein einzelnes Wurzelelement, was bis HTML 4.01 zulässig war, und fehlt die Option -forest, wird ein html-Knoten als Dokumentelement eingefügt. Die Elemente der obersten Ebene der HTML-Eingabe werden seine Kinder.

    **-html5**
    : Diese Option gibt es nur, wenn tDOM mit --enable-html5 gebaut wurde. Ob das eingebaut ist, sagt die Methode *featureinfo*. Mit *-html5* baut der HTML5-Parser der Bibliothek gumbo (https://github.com/google/gumbo-parser) den DOM-Baum. Soweit das reicht, kennt er XML-Namensräume. Alle HTML-Elemente liegen dann im Namensraum html5. Das ist oft nicht gewollt und in vielen Fällen nur Ballast. *-html5* lässt sich mit *-ignorexmlns* kombinieren. Dann liegen alle Knoten und Attribute des DOM-Baums in keinem XML-Namensraum. Alle Element- und Attributnamen im DOM-Baum werden klein geschrieben, auch fremde Elemente außerhalb der Namensräume xhtml, svg oder mathml. Der DOM-Baum kann Knoten enthalten, die der Parser ergänzt hat, weil der Zusammenhang sie verlangt, etwa <head> und <tbody>. Eingaben länger als 4 GByte unterstützt der zugrunde liegende gumbo-Parser nicht.

    **-json**
    : Mit *-json* muss *data* eine gültige JSON-Zeichenkette nach RFC 7159 sein. Der Befehl gibt ein gewöhnliches DOM-Dokument zurück. Verschachtelung in den JSON-Daten wird zur Baumhierarchie. Ist ein JSON-Array-Wert selbst ein Objekt oder ein Array, werden Container-Elementknoten in den Baum eingefügt, in einem Vorgabebau arraycontainer beziehungsweise objectcontainer. Die JSON-Serialisierung dieses Dokuments, mit der domDoc-Methode *asJSON*, ist dieselbe JSON-Information wie *data*. JSON-Datentypen bleiben erhalten, Member-Namen von Objekten dürfen mehrfach vorkommen und behalten ihre Reihenfolge, und der ganze Wertebereich von JSON-Zeichenketten bleibt. Die JSON-Datentypen hängen als zusätzliche Eigenschaft an den Dokument- und Baumknoten. Diese Eigenschaft steht nicht in einer XML-Serialisierung des Dokuments. Sollen die JSON-Daten eines Dokuments gespeichert werden, wird die JSON-Serialisierung gespeichert und von dort wieder gelesen. Abgesehen von dieser JSON-Typangabe ist der zurückgegebene Dokumentbefehl oder das Handle ein gewöhnliches DOM-Dokument. Es lässt sich mit dem vollen Umfang der Dokument- und Knotenmethoden untersuchen und ändern. Elementnamen und Textknotenwerte im Baum können außerhalb dessen liegen, was die passenden XML-Produktionen erlauben.

    **-jsonroot <document element name>**
    : Ist die Option angegeben, wird der angegebene Elementname das Dokumentelement des entstehenden Dokuments. Der gelesene Inhalt der JSON-Zeichenkette wird zu den Kindern dieses Dokumentelementknotens.

    **-jsonmaxnesting**  *integer*
    : Diese Option wirkt nur zusammen mit *-json*. Die vorliegende Umsetzung verwendet einen rekursiv absteigenden JSON-Parser. Damit der Stapelspeicher nicht überläuft, gilt JSON-Eingabe mit mehr als einer bestimmten Verschachtelungstiefe als ungültig. Die voreingestellte größte Tiefe ist 2000. Die Option -jsonmaxnesting stellt diesen Wert ein.

    **--**
    : Die Option *--* markiert das Ende der Optionen. Sie ist nicht zwingend nötig, auch beim Lesen von JSON, dessen gültige Daten mit "-" beginnen können. Beim Lesen von JSON wird das vorletzte oder letzte Argument als JSON-Daten gelesen, wenn es mit "-" beginnt und kein bekannter Optionsname ist.

    **-keepEmpties**
    : Mit *-keepEmpties* gehören Textknoten, die nur aus Leerraum bestehen, zum entstehenden DOM-Baum. Voreingestellt, also ohne *-keepEmpties*, werden diese leeren Textknoten beim Lesen entfernt.

    **-keepCDATA**
    : Mit *-keepCDATA* kommen CDATA-Abschnitte nicht als Textknoten in den Baum und werden nicht, wie ohne diese Option, nötigenfalls mit benachbarten Textknoten zu einem Textknoten zusammengezogen. Sie kommen als CDATA_SECTION_NODE in den Baum. Der entstehende Baum ist nicht für XPath-Auswahlen vorbereitet und nicht als Quelle oder Stylesheet einer XSLT-Transformation. Ohne *-keepEmpties* kommen nur CDATA-Abschnitte in den DOM-Baum, die nicht ausschließlich aus Leerraum bestehen.

    **-channel**  *<channel-ID>*
    : Mit *-channel <channel-ID>* wird die zu lesende Eingabe aus dem angegebenen Kanal gelesen. Die Kodierung des Kanals, gesetzt mit fconfigure -encoding, wird beachtet. Die aus dem Kanal gelesenen Daten werden vor dem Lesen gemäß dieser Kodierung nach UTF-8 gewandelt.

    **-baseurl**  *<baseURI>*
    : Mit *-baseurl <baseURI>* ist die baseURI die Basis-URI des Dokuments. Verweise auf externe Entitäten im Dokument werden relativ zu dieser Basis-URI aufgelöst. Diese Basis-URI wird auch im DOM-Baum gespeichert.

    **-feedbackAfter**  *<#bytes>*
    : Mit *-feedbackAfter <#bytes>* wird der Tcl-Befehl aus *-feedbackcmd* beim ersten Elementanfang im Dokument oder in einer externen Entität ausgewertet, nach dem Beginn des Dokuments oder der externen Entität oder nach dem letzten solchen Aufruf nach #bytes. Aus Gründen der Verträglichkeit wird, wenn -feedbackcmd fehlt, aber eine Tcl-Prozedur ::dom::domParseFeedback existiert, diese Prozedur als -feedbackcmd verwendet. Gibt es diese Prozedur nicht und wird -feedbackAfter verwendet, ist es ein Fehler, -feedbackcmd nicht ebenfalls zu verwenden. Löst das aufgerufene Skript einen Fehler aus, bricht das Lesen ab. Der Aufruf *dom parse* gibt den Fehler zurück, mit der Fehlermeldung des Skripts. Führt das aufgerufene Skript *return -code break* aus, bricht das Lesen ab, und der Aufruf *dom parse* gibt die leere Zeichenkette zurück.

    **-feedbackcmd**  *<script>*
    : Mit *-feedbackcmd <script>* wird das Skript *script* beim ersten Elementanfang im Dokument oder in einer externen Entität ausgewertet, nach dem Beginn des Dokuments oder der externen Entität oder nach dem letzten solchen Aufruf nach dem Wert #bytes aus der Option *-feedbackAfter*. Fehlt *-feedbackAfter*, hat diese Option keine Wirkung. Löst das aufgerufene Skript einen Fehler aus, bricht das Lesen ab. Der Aufruf *dom parse* gibt den Fehler zurück, mit der Fehlermeldung des Skripts. Führt das aufgerufene Skript *return -code break* aus, bricht das Lesen ab, und der Aufruf *dom parse* gibt die leere Zeichenkette zurück.

    **-externalentitycommand**  *<script>*
    : Mit *-externalentitycommand <script>* wird das angegebene Tcl-Skript aufgerufen, um externe Entitäten des Dokuments aufzulösen. Der tatsächlich ausgewertete Befehl besteht aus dieser Option und drei Argumenten: der Basis-URI, dem Systembezeichner der Entität und dem öffentlichen Bezeichner der Entität. Die Basis-URI und der öffentliche Bezeichner können die leere Liste sein. Das Skript gibt eine Tcl-Liste aus drei Elementen zurück. Das erste Element sagt, wie die externe Entität an den Prozessor zurückgegeben wird. Derzeit sind die Typen "string" und "channel" erlaubt. Das zweite Element muss die absolute Basis-URI der zu lesenden externen Entität sein. Das dritte Element sind die Daten: bei Typ "string" die bereits gelesenen Daten der externen Entität als Zeichenkette, bei Typ "channel" der Name eines Tcl-Kanals. Gibt das Skript einen Tcl-Kanal zurück, schließt der Prozessor ihn nicht. Er muss getrennt geschlossen werden, wenn er nicht mehr gebraucht wird.

    **-useForeignDTD**  *<boolean>*
    : Ist <boolean> wahr und hat das Dokument keine externe Teilmenge, ruft der Parser das Skript -externalentitycommand mit leeren Werten für die Argumente systemId und publicID auf. Hat das Dokument auch keine interne Teilmenge, werden die Skripte -startdoctypedeclcommand und -enddoctypedeclcommand, sofern gesetzt, nicht aufgerufen.

    **-paramentityparsing**  *<always|never|notstandalone>*
    : Die Option *-paramentityparsing* steuert, ob der Parser beim Aufbau des DOM-Baums die externen Entitäten des Dokuments aufzulösen versucht, einschließlich der externen DTD-Teilmenge. *-paramentityparsing* braucht ein Argument, entweder "always", "never" oder "notstandalone". Der Wert "always" heißt: der Parser versucht, alle externen Entitäten der XML-Quelle aufzulösen, auch rekursiv. Das ist die Vorgabe, wenn *-paramentityparsing* fehlt. Der Wert "never" heißt: nur die angegebene XML-Quelle wird gelesen, keine externe Entität und nicht die externe Teilmenge wird aufgelöst und gelesen. Der Wert "notstandalone" heißt: alle externen Entitäten werden aufgelöst und gelesen, außer bei Dokumenten, die in der XML-Deklaration ausdrücklich standalone="yes" angeben.

    **-forest**
    : Mit dieser Option ist keine einzelne Wurzel nötig. Jede Folge wohlgeformter, ausbalancierter Teilbäume wird in einen DOM-Baum gelesen. Das gilt für den expat-DOM-Aufbau, den einfachen XML-Parser mit *-simple* und den einfachen HTML-Parser mit *-html*. Zusammen mit *-json* oder *-html5* wird die Option ignoriert.

    **-ignorexmlns**
    : Diese Option sollte nur zusammen mit *-html5* verwendet werden. Ist sie angegeben, wird kein Knoten des angelegten DOM-Baums intern als in einem XML-Namensraum stehend markiert, auch wenn für Elemente ohne Präfix ein Vorgabe-Namensraum gilt oder das Element einen Namensraum-Präfix hat. Eine Folge: XPath-Knotenausdrücke auf einem solchen DOM-Baum arbeiten nicht wie erwartet. Elementknoten mit Präfix lassen sich nicht naiv auswählen, und Elementknoten ohne Präfix sieht XPath so, als lägen sie in keinem Namensraum, auch wenn sie in einem Vorgabe-Namensraum liegen sollten. Ein Präfix in einem XPath-Ausdruck wird mit der '%'-Schreibweise gesetzt, beschrieben in der Dokumentation der der

    [domNode]
    :  Befehlsmethode **selectNodes**.

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


**dom** **createDocument** *docElemName* **?***objVar***?**
: Legt ein neues DOM-Dokumentobjekt mit einem Elementknoten des Knotennamens *docElemName* an. *objVar* steuert die Speicherbehandlung wie oben beschrieben.

**dom** **createDocumentNS** *uri* *docElemName* **?***objVar***?**
: Legt ein neues DOM-Dokumentobjekt mit einem Elementknoten des Knotennamens *docElemName* an. *Uri* gibt den Namensraum des anzulegenden Dokumentelements an. *objVar* steuert die Speicherbehandlung wie oben beschrieben.

**dom** **createDocumentNode** ?*-jsonType jsonType***?** ?*objVar***?**
: Legt ein neues leeres DOM-Dokumentobjekt ohne Elementknoten an. *objVar* steuert die Speicherbehandlung wie oben beschrieben. Ist die Option -jsonType angegeben, hat der angelegte Dokumentknoten den angegebenen JSON-Typ.

**dom** **createFromTypedList** *typedList* **?***objVar***?**
: Legt aus dem Argument *typedList* ein neues DOM-Dokument an. Das Argument *objVar* steuert die Speicherbehandlung wie oben beschrieben.

    Das Argument *typedList* muss eine Tcl-Liste sein und dem Format der Ausgabe der Dokumentbefehlsmethode *asTypedList* folgen, siehe dort.

**dom** **createNodeCmd**           *?-returnNodeCmd?* *?-tagName name?* *?-jsonType jsonType?* *?-namespace URI?* *?-noNamespacedAttributes?* *?-notempty?* *(element|comment|text|cdata|pi)Node* *commandName*
: Diese Methode legt Tcl-Befehle an, die wiederum tDOM-Knoten anlegen. Die so angelegten Tcl-Befehle gibt es nur in einem Skript, das den domNode-Methoden *appendFromScript* oder *insertBeforeFromScript* übergeben wird. Wird ein mit *createNodeCmd* angelegter Befehl in einem anderen Zusammenhang aufgerufen, kommt ein Fehler zurück. Der angelegte Befehl *commandName* ersetzt einen vorhandenen Befehl oder eine vorhandene Prozedur dieses Namens. Enthält *commandName* Tcl-Namensraum-Qualifizierer, wird er in diesem Namensraum angelegt. Die Option *-tagName* ist nur für den Typ elementNode erlaubt. Die Option *-jsonType* ist nur für die Typen elementNode und textNode erlaubt.

    Wird ein solcher Befehl in einem Skript aufgerufen, das der domNode-Methode *appendFromScript* oder *insertBeforeFromScript* als Argument übergeben wurde, legt er einen neuen Knoten an und hängt ihn ans Ende der Kindliste des aufrufenden Elementknotens. War die Option *-returnNodeCmd* angegeben, gibt der Befehl den angelegten Knoten als Tcl-Befehl zurück. Fehlt die Option, gibt der Befehl nichts zurück. Jeder Befehl legt immer denselben Knotentyp an. Welcher Typ entsteht, bestimmt das erste Argument von *createNodeCmd*. Die Syntax des angelegten Befehls hängt vom Typ des Knotens ab, den er anlegt.

    Ist der anzulegende Befehlstyp *elementNode*, legt der Befehl beim Aufruf einen Elementknoten an. Wurde beim Anlegen des Knotenbefehls die Marke *-notempty* verwendet, entsteht der Elementknoten nur, wenn er nicht leer ist. Ohne die Option *-tagName* ist der Elementname des angelegten Knotens *commandName* ohne Tcl-Namensraum-Qualifizierer. War *-tagName* angegeben, haben die angelegten Elemente den Wert dieser Option als Elementnamen. War *-jsonType* angegeben, haben die angelegten Elementknoten den angegebenen JSON-Typ. Ist *-namespace* angegeben, liegt der angelegte Elementknoten im XML-Namensraum dieser Option. Der Elementname bleibt wörtlich so, wie ihn der Befehlsname oder, falls angegeben, die Option *-tagname* vorgibt. Eine passende XML-Namensraumdeklaration wird von selbst ergänzt. Sie bindet den Präfix, wenn der Elementname einen hat, oder den Vorgabe-Namensraum, wenn der Elementname keinen Präfix hat, an den Namensraum, sofern eine solche Bindung nicht gilt.

    Die Syntax des angelegten Befehls ist:

    ```
    elementNodeCmd ?attributeName attributeValue ...? ?script?
    elementNodeCmd ?-attributeName attributeValue ...? ?script?
    elementNodeCmd ?name_value_list? ?script?
    ```

    Die Befehlssyntax erlaubt drei Arten, die Attribute des entstehenden Elements anzugeben. Als Argumentpaare *attributeName attributeValue*, im Optionsstil als Argumentpaare *-attriubteName attributeValue*, wobei das Zeichen '-' nur syntaktischer Zucker ist und abgeschnitten wird, oder als Tcl-Liste, deren Elemente als Attributname und zugehöriger Attributwert gelesen werden. Die Attributnamen in der Liste dürfen mit '-' beginnen, das dann abgeschnitten wird. Wird *elementNodeCmd* mit nur einem Argument aufgerufen, gilt das als Inhaltsskript.

    Hat *attributeName* einen Präfix, wird der Präfix voreingestellt zuerst in der Präfix-URI-Liste *selectNodesNamespaces* gesucht und, falls nicht gefunden, im XML-Namensraum des Knotens. Löst sich der Präfix nicht auf, wird ein Fehler ausgelöst. Löst er sich auf, entsteht das Attribut in diesem Namensraum, nötigenfalls mit XML-Namensraumdeklarationen. Wurde *elementNodeCmd* mit der Marke *-noNamespacedAttributes* angelegt, gibt es keine Präfixsuche. Das Attribut entsteht mit dem angegebenen Namen und in keinem XML-Namensraum. XML-Namensraumdeklarationen sollten damit nicht angelegt werden.

    Jeder *elementNodeCmd* nimmt als letztes Argument ein optionales Tcl-Skript an. Dieses Skript wird als rekursives *appendFromScript*-Skript ausgewertet. Der von *elementNodeCmd* angelegte Knoten ist der Elter aller Knoten, die das Skript anlegt.

    Ist das erste Argument der Methode *textNode*, legt der Befehl einen Textknoten an. War die Option *-jsonType* angegeben, hat der angelegte Textknoten diesen JSON-Typ. Die Syntax des angelegten Befehls ist:

    ```
    textNodeCmd ?-disableOutputEscaping? ?data?
    ```

    Ist der JSON-Typ des angelegten Textknotens NULL, TRUE oder FALSE, ist das Argument *data* optional. Sonst muss dieses Argument angegeben werden.

    Ist der JSON-Typ des angelegten Textknotens der virtuelle Typ BOOLEAN und erkennt Tcl\_GetBooleanFromObj() den Textwert als boolesch, wird der JSON-Wert der entsprechende JSON-Boolesche. Versteht Tcl den Textknotenwert nicht als boolesch, wird der Wert als JSON-Zeichenkette geschrieben.

    Mit der optionalen Marke *-disableOutputEscaping* entfällt die Maskierung des Und-Zeichens (&) und der linken spitzen Klammer (<) in den Daten. Diese Marke ist mit Vorsicht zu verwenden.

    Ist das erste Argument der Methode *commentNode* oder *cdataNode*, legt der Befehl einen Kommentarknoten oder einen CDATA-Abschnittknoten an. Die Syntax des angelegten Befehls ist:

    ```
    nodeCmd data
    ```

    Ist das erste Argument der Methode *piNode*, legt der Befehl einen Verarbeitungsanweisungsknoten an. Die Syntax des angelegten Befehls ist:

    ```
    piNodeCmd target data
    ```

    Neben den mit **dom** **createNodeCmd** angelegten Knotenbefehlen gibt es zwei weitere Befehle, die in einem **appendFromScript**-Skript Knoten von selbst in den Baum einfügen.

    ```
    tdom::fsnewNode ?-jsonType <jsonType>? ?-namespace <namespace>? ?-noNamespacedAttributes? -notempty tagName ?attributes? ?script?
    ```

    Im Zusammenhang fromScript legt dieser Befehl einen neuen Knoten *tagName* an, im XML-Namensraum *namespace*, wenn *-namespace* angegeben war, und mit dem JSON-Typ *jsonType*, wenn *-jsonType* angegeben war, und hängt ihn ans Ende der Kindliste des aufrufenden Elementknotens. Die übrigen Marken wirken wie beim Anlegen eines Befehls, der Elemente anlegt, siehe dort. Die Argumente *attributes* und *script* werden ebenso verarbeitet wie bei einem Knotenbefehl, der Elemente anlegt. Außerhalb eines fromScript-Zusammenhangs löst dieser Befehl einen Fehler aus.

    ```
    tdom::fsinsertNode node
    ```

    Im Zusammenhang fromScript hängt dieser Befehl den als Argument angegebenen Knoten ans Ende der Kindliste des aufrufenden Elementknotens, statt einen neuen Knoten anzulegen. Der Knoten wird von seinem bisherigen Ort gelöst. Außerhalb eines fromScript-Zusammenhangs löst dieser Befehl einen Fehler aus.

**dom** **fromScriptContext** ?*objVar***?**
: Im Zusammenhang fromScript gibt diese Methode den Knoten zurück, an dessen Kindliste der Skriptzusammenhang Knoten anhängt. Sonst kommt ein Fehler zurück.

    Werden Knotenbefehle mit -notempty angelegt, kann der zurückgegebene Knoten außerhalb des Auswertungszusammenhangs verschwunden sein, wenn er am Ende der Auswertung noch leer ist.

**dom** **setStoreLineColumn** *?boolean***?**
: Ist das eingeschaltet, enthalten die DOM-Knoten nach dem Lesen Zeile und Spalte im ursprünglichen XML-Dokument. Voreingestellt werden Zeile und Spalte nicht gespeichert.

**dom** **setNameCheck** *?boolean***?**
: Ist NameCheck wahr, prüft jede Methode, die einen XML-Namen, einen voll qualifizierten Namen oder ein Ziel einer Verarbeitungsanweisung erwartet, ob die angegebene Zeichenkette nach ihrer Produktionsregel gültig ist. Bei Befehlen, die die Methode *createNodeCmd* für den Zusammenhang *appendFromScript* anlegt, entscheidet der Stand der Marke zur Anlegezeit. Ist NameCheck zur Anlegezeit wahr, prüft der Befehl seine Argumente, sonst nicht. *setNameCheck* setzt diese Marke. Zurück kommt der aktuelle Stand der Marke NameCheck. Die Vorgabe für NameCheck ist wahr.

**dom** **setTextCheck** *?boolean***?**
: Ist TextCheck wahr, prüft jeder Befehl, der XML-Zeichen, einen Kommentar, einen CDATA-Abschnittwert oder einen Wert einer Verarbeitungsanweisung erwartet, ob die angegebene Zeichenkette nach ihrer Produktionsregel gültig ist. Bei Befehlen, die die Methode *createNodeCmd* für den Zusammenhang *appendFromScript* anlegt, entscheidet der Stand der Marke zur Anlegezeit. Ist TextCheck zur Anlegezeit wahr, prüft der Befehl seine Argumente, sonst nicht. Die Methode *setTextCheck* setzt diese Marke. Zurück kommt der aktuelle Stand der Marke TextCheck. Die Vorgabe für TextCheck ist wahr.

**dom** **setObjectCommands** ?*(automatic|token|command)***?**
: Steuert, ob Dokumente und Knoten als Tcl-Befehle entstehen oder als Token für die Befehle domNode und domDoc. Im Modus 'automatic' legen Methoden an Tcl-Befehlen Tcl-Befehle an, und Methoden an Dokument- oder Knoten-Token legen Token an. Im Modus 'command' entstehen immer Tcl-Befehle. Im Modus 'token' entstehen immer Token. Die Methode gibt den aktuellen Modus zurück. Die Methode ist eine experimentelle Schnittstelle.

**dom** **isName** *name*
: Gibt 1 zurück, wenn *name* nach Produktion 5 der XML-1.0-Empfehlung ein gültiger XML-Name ist. Dann ist *name* ein gültiger XML-Element- oder Attributname. Sonst kommt 0 zurück.

**dom** **isPIName** *name*
: Gibt 1 zurück, wenn *name* nach Produktion 17 der XML-1.0-Empfehlung ein gültiges Ziel einer XML-Verarbeitungsanweisung ist. Sonst kommt 0 zurück.

**dom** **isNCName** *name*
: Gibt 1 zurück, wenn *name* nach Produktion 4 der der Empfehlung Namespaces in XML ein gültiger NCName ist. Sonst kommt 0 zurück.

**dom** **isQName** *name*
: Gibt 1 zurück, wenn *name* nach Produktion 6 der der Empfehlung Namespaces in XML ein gültiger QName ist. Sonst kommt 0 zurück.

**dom** **isCharData** *string*
: Gibt 1 zurück, wenn jedes Zeichen in *string* nach Produktion 2 der XML-1.0-Empfehlung ein gültiges XML-Char ist. Sonst kommt 0 zurück.

**dom** **isHTML5CustomName** *string*
: Gibt 1 zurück, wenn *string* ein nach HTML5 gültiger Name eines Custom Elements ist, nach https://html.spec.whatwg.org/#valid-custom-element-name vom 26. Juni 2024. Das ist ein lebender Standard. Sonst kommt 0 zurück.

**dom** **clearString** ?*-replace***?** *string*
: Gibt die als Argument angegebene Zeichenkette zurück, bereinigt um alle Zeichen, die als geparste XML-Zeichendaten nicht erlaubt sind. Mit der Option *-replace* werden solche Zeichen nicht entfernt, sondern durch \\uFFFD ersetzt.

**dom** **isBMPCharData** *string*
: Gibt 1 zurück, wenn jedes Zeichen in *string* ein gültiges XML-Char mit einem Unicode-Codepunkt in der Basic Multilingual Plane ist. Das heißt, jedes Zeichen der Zeichenkette ist höchstens 3 Bytes lang. Sonst kommt 0 zurück.

**dom** **isComment** *string*
: Gibt 1 zurück, wenn *string* nach Produktion 15 der XML-1.0-Empfehlung ein gültiger Kommentar ist. Sonst kommt 0 zurück.

**dom** **isCDATA** *string*
: Gibt 1 zurück, wenn *string* nach Produktion 20 der XML-1.0-Empfehlung gültig ist. Sonst kommt 0 zurück.

**dom** **isPIValue** *string*
: Gibt 1 zurück, wenn *string* nach Produktion 16 der XML-1.0-Empfehlung gültig ist. Sonst kommt 0 zurück.

**dom** **jsonEscape** *string*
: Gibt das Argument *string* so maskiert zurück, dass ein konformer JSON-Parser die zurückgegebene Zeichenkette, wörtlich in ein JSON-Dokument gesetzt, als die ursprüngliche Zeichenkette liest.

**dom** **featureinfo** *feature*
: Diese Methode nennt die verwendeten Bauoptionen und die expat-Version. Gültige Werte für das Argument *feature* sind:

    **expatversion**
    : Gibt die Version des zugrunde liegenden expat als Zeichenkette zurück, etwa "exapt\_2.1.0". Das ist die Rückgabe der expat-API-Funktion XML\_ExpatVersion().

    **expatmajorversion**
    : Gibt die Hauptversion des zur Bauzeit verwendeten expat als ganze Zahl zurück.

    **expatminorversion**
    : Gibt die Nebenversion des zur Bauzeit verwendeten expat als ganze Zahl zurück.

    **expatmicroversion**
    : Gibt die Mikroversion des zur Bauzeit verwendeten expat als ganze Zahl zurück.

    **dtd**
    : Gibt als booleschen Wert zurück, ob mit *--enable-dtd* gebaut wurde.

    **ns**
    : Gibt als booleschen Wert zurück, ob mit *--enable-ns* gebaut wurde.

    **unknown**
    : Gibt als booleschen Wert zurück, ob mit *--enable-unknown* gebaut wurde.

    **tdomalloc**
    : Gibt als booleschen Wert zurück, ob mit *--enable-tdomalloc* gebaut wurde.

    **lessns**
    : Gibt als booleschen Wert zurück, ob mit *--enable-lessns* gebaut wurde.

    **TCL\_UTF\_MAX**
    : Gibt den Wert TCL\_UTF\_MAX des Tcl-Kerns als ganze Zahl zurück, mit dem tDOM gebaut wurde.

    **html5**
    : Gibt als booleschen Wert zurück, ob mit *--enable-html5* gebaut wurde.

    **versionhash**
    : Gibt den Versions-Hash des Fossil-Repositoriums zurück.

    **pullparser**
    : Gibt als booleschen Wert zurück, ob der Befehl pullparser eingebaut ist.

    **schema**
    : Gibt als booleschen Wert zurück, ob die Schema-Funktionen von tDOM eingebaut sind.

    **largedata**
    : Gibt als booleschen Wert zurück, ob die Konfiguration der Bibliothek expat PCDATA-Inhalt eines XML-Elements größer als 2 GByte erlaubt. Wahr kann das nur sein, wenn mit Tcl 9 für eine 64-Bit-Architektur gebaut wurde. Dann hängt es davon ab, ob das eingebaute expat mit Vorgabekonfiguration verwendet wird oder ob die verwendete Systembibliothek expat das kann. In der Regel nicht.


[domNode]: domNode.md
