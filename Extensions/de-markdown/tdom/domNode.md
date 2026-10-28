---
CommandName: domNode
title: domNode
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription:
Links:
 - dom
 - domDoc
Keywords:
 - XML
 - DOM
 - document
 - node
 - parsing
Copyright:
---

# Name

domNode - Eine Instanz eines DOM-Knotenobjekts bearbeiten

# Übersicht

::: {.synopsis} :::
[$nodeObject]{.cmd} [method]{.arg} [arg]{.arg} [arg]{.arg} [...]{.arg}
:::

# Beschreibung

Dieser Befehl bearbeitet eine bestimmte Instanz eines DOM-Knotenobjekts. *method* nennt eine Methode der Knotenklasse. Die Methoden sollen sich eng an die W3C-Empfehlung "Document Object Model (Core) Level 1" (http://www.w3.org/TR/REC-DOM-Level-1/level-one-core.html) halten und an Teile des W3C-Entwurfs "XML Pointer Language (XPointer)" (http://www.w3.org/TR/1998/WD-xptr-19980303). Die XPointer-Methoden sind veraltet. Statt ihrer sind DOM-Methoden oder XPath-Ausdrücke zu verwenden.

Die Methode selectNodes setzt die W3C-Empfehlung "XML Path Language (XPath) Version 1.0" vom 16. November 1999 um (http://www.w3.org/TR/1999/REC-xpath-19991116). Diese Dokumente beschreiben die Funktion genauer.

Die gültigen Methoden sind:

**nodeType**
: Gibt den Knotentyp dieses Knotenobjekts zurück. Das kann sein: ELEMENT\_NODE, TEXT\_NODE, CDATA\_SECTION\_NODE, COMMENT\_NODE oder PROCESSING\_INSTRUCTION\_NODE.

**nodeName**
: Gibt den Knotennamen dieses Knotenobjekts zurück. Das ist der Elementname für Elementknoten (Typ ELEMENT\_NODE), das Ziel der Verarbeitungsanweisung, "#text" für einen Textknoten, "#comment" für Kommentarknoten oder "#cdata" für CDATA-Abschnittknoten.

**nodeValue** *?newValue?*
: Gibt den Wert dieses Knotenobjekts zurück. Das ist der Text oder die Daten für Knoten der Typen TEXT\_NODE, COMMENT\_NODE, PROCESSING\_INSTRUCTION\_NODE oder CDATA\_SECTION\_NODE). Sonst ist der Wert leer. Ist der Knoten ein TEXT\_NODE, COMMENT\_NODE oder PROCESSING\_INSTRUCTION\_NODE und ist das optionale Argument *newValue* angegeben, wird der Knoten auf diesen Wert gesetzt.

**hasChildNodes**
: Gibt 1 zurück, wenn der Knoten Kinder hat. Sonst kommt 0 zurück.

**parentNode** **?objVar?**
: Gibt den Elternknoten zurück.

**childNodes**
: Gibt eine Liste der direkten Kindknotenobjekte zurück.

**childNodesLive**
: Gibt ein lebendiges nodeList-Objekt der Kindknoten des Knotens im Sinne der DOM-Empfehlung zurück. Lebendig heißt: Änderungen an den Kindern des Knotenobjekts, aus dem die Liste entstand, zeigen sich sofort in den Knoten, die die Zugriffe der NodeList liefern. Es ist keine stehende Aufnahme des Knoteninhalts. Die beiden Zugriffe des nodeList-Objekts sind "item <index>", der den Eintrag an der Stelle index in der Sammlung zurückgibt, und "length", der die Anzahl der Knoten in der Liste zurückgibt.

**firstChild** **?objVar?**
: Gibt das erste Kind als Knotenobjekt zurück.

**lastChild** **?objVar?**
: Gibt das letzte Kind als Knotenobjekt zurück.

**nextSibling**  **?objVar?**
: Gibt den nächsten Geschwisterknoten zum aktuellen Knoten als Knotenobjekt zurück.

**previousSibling** **?objVar?**
: Gibt den vorigen Geschwisterknoten zum aktuellen Knoten als Knotenobjekt zurück.

**getElementsByTagName** *name*
: Gibt eine Liste aller Elemente im Teilbaum zurück, die auf *name* passen (Glob-Muster).

**getElementsByTagNameNS** *uri* *localname*
: Gibt eine Liste aller Elemente im Teilbaum zurück, die auf *localname* passen (Glob-Muster) und den angegebenen Namensraum *uri* haben.

**getElementById** *id*
: Gibt den Knoten zurück, dessen id-Attribut den Wert *id* hat, oder die leere Zeichenkette, wenn kein Knoten ein id-Attribut mit diesem Wert hat.

**hasAttribute** *attributeName*
: Gibt 1 zurück, wenn der Objektknoten ein Attribut des Namens *attributeName* enthält. Sonst kommt 0 zurück.

**getAttribute** *attributeName  ?defaultValue?*
: Gibt den Wert des Attributs *attributeName* zurück. Fehlt das Attribut, kommt *defaultValue* zurück.

**setAttribute** *attributeName newValue  ?attributeName newValue ...?*
: Setzt den Wert eines oder mehrerer Attribute. Jeder *attributeName* wird auf den zugehörigen *newValue* gesetzt. Fehlt zu einem *attributeName* das Attribut, wird es angelegt. Von Attributen, die wie XML-Namensraumdeklarationen aussehen, ist abzuraten.

**removeAttribute** *attributeName*
: Entfernt das Attribut *attributeName*.

**hasAttributeNS** *uri* *localName*
: Gibt 1 zurück, wenn der Objektknoten ein Attribut mit dem lokalen Namen *localName* im Namensraum *uri* enthält. Sonst kommt 0 zurück.

**getAttributeNS** *uri* *localName ?defaultValue?*
: Gibt den Wert des Attributs mit dem lokalen Namen *localName* im Namensraum-URI *uri* zurück. Hat der Knoten dieses Attribut nicht, kommt *defaultValue* zurück.

**setAttributeNS** *uri qualifiedName newValue ?uri qualifiedName newValue ...?*
: Setzt den Wert eines oder mehrerer voll qualifizierter Attribute. Jedes Attribut *qualifiedName* mit dem Namensraum-URI *uri* wird auf *newValue* gesetzt. Fehlt das Attribut, wird es angelegt. Ein Attribut in einem Namensraum braucht den Attributnamen mit Präfix, auch wenn ein vorhandenes Attribut einen neuen Wert bekommen soll. Bei der Suche, ob das Attribut schon existiert, zählen nur der angegebene *uri* und der lokale Name von *qualifiedName*.

    ```
    $node setAttributeNS "http://some.uri.com/wow" prefix:attr1 attrValue
    ```

    Ist der URI die leere Zeichenkette und hat der Attributname keinen Präfix, wirkt diese Methode wie **setAttribute**.

    ```
    $node setAttributeNS "" attri "some Value"
    ```

    Außer bei den besonderen Präfixen "xmlns" und "xml" muss *uri* nicht leer sein, wenn *qualifiedName* einen Präfix hat. Von XML-Namensraumdeklarationen ist abzuraten. Die Wirkungen sind verwickelt und nicht immer offensichtlich, bis hin zu Serialisierungen, die nach weiterer Verarbeitung nicht wohlgeformt sind.

**removeAttributeNS** *uri* *localName*
: Entfernt das Attribut mit dem lokalen Namen *localName* im Namensraum *uri*.

**attributes** **?attributeNamePattern?**
: Gibt Angaben zu den Attributen zurück, die auf *attributeNamePattern* passen. Fehlt *attributeNamePattern*, kommen Angaben zu allen Attributen zurück. Der Rückgabewert ist eine Tcl-Liste. Bei Attributen ohne Namensraum ist das Element nur der Attributname, bei Attributen mit Namensraum eine Unterliste aus drei Elementen. Bei einem gewöhnlichen Attribut mit Namensraum sind die Elemente der Unterliste {<localname> <prefix> <namespace\_uri>}. Bei einer XML-Namensraumdeklaration ist es {<der definierte Präfix> <localname> ""}.

**attributeNames** **?attributeNamePattern?**
: Gibt eine flache Liste aller Attributnamen zurück, wie sie in der XML-Quelle stehen und auf *attributeNamePattern* passen. Fehlt *attributeNamePattern*, kommen alle Attributnamen als Tcl-Liste zurück.

**appendChild** *newChild*
: Hängt *newChild* ans Ende der Kindliste des Knotens.

**insertBefore** *newChild*  *refChild*
: Fügt *newChild* vor *refChild* in die Kindliste des Knotens ein. Ist *refChild* die leere Zeichenkette, wird *newChild* ans Ende der Kindliste dieses Knotens gesetzt.

**replaceChild** *newChild*  *oldChild*
: Ersetzt *oldChild* durch *newChild* in der Kindliste dieses Knotens. Der Knoten *oldChild* gehört nach diesem Vorgang zur Dokumentfragmentliste.

**removeChild** *child*
: Nimmt *child* aus der Kindliste dieses Knotens. *child* gehört nach diesem Vorgang zur Dokumentfragmentliste.

**delete**
: Löscht den angegebenen Knoten und seinen gesamten Kindbaum und gibt den gesamten internen Speicher frei. Die betroffenen Knoten sind über die Dokumentfragmentliste nicht erreichbar.

**cloneNode** **?-deep?**
: Klont diesen Knoten und nimmt den neu angelegten Knoten in die Dokumentfragmentliste auf. Mit der Option *-deep* werden auch alle Nachfahren geklont.

**ownerDocument** **?domObjVar?**
: Gibt das Dokumentobjekt des Dokuments zurück, zu dem dieser Knoten gehört.

**find** *attrName* *attrVal* **?objVar?**
: Sucht im Teilbaum ab dem aktuellen Knoten den Knoten mit dem Attributnamen *attrName* und dem Attributwert *attrVal*.

**child** *number|all* **type** **attrName attrValue**
: (XPointer) Kind

**descendant** *number|all* **type** **attrName attrValue**
: (XPointer) Nachfahre

**ancestor** *number|all* **type** **attrName attrValue**
: (XPointer) Vorfahr

**fsibling** *number|all* **type** **attrName attrValue**
: (XPointer) folgender Geschwisterknoten

**psibling** *number|all* **type** **attrName attrValue**
: (XPointer) voriger Geschwisterknoten

**root**  **objVar**
: (XPointer) Wurzel

**text**
: Gibt alle Textknoten-Kinder des aktuellen Knotens aneinandergehängt als eine Zeichenkette zurück.

**target**
: Bei einem Verarbeitungsanweisungsknoten kommt der Zielteil zurück. Sonst wird ein Fehler erzeugt.

**data**
: Bei einem Verarbeitungsanweisungsknoten kommt der Datenteil zurück. Bei einem Textknoten, Kommentarknoten oder CDATA-Abschnittknoten kommt der Wert zurück. Sonst wird ein Fehler erzeugt.

**prefix**
: Gibt den Namensraum-Präfix zurück.

**namespaceURI**
: Gibt den Namensraum-URI zurück.

**localName**
: Gibt den localName aus dem Elementnamen des angegebenen Knotens zurück.

**selectNodes** **?-namespaces prefixUriList?** **?-cache <boolean>?** **?-list?** *xpathQuery* **?typeVar?**
: Gibt das Ergebnis der XPath-Abfrage *xpathQuery* auf den Teilbaum zurück. Das Ergebnis kann eine Zeichenkette oder ein Wert sein, eine Liste von Zeichenketten, eine Liste von Knoten oder eine Liste von Paaren aus Attributname und Wert. Ist das Argument *typeVar* angegeben, wird der Name des Ergebnistyps in diese Variable geschrieben (empty, bool, number, string, nodes, attrnodes oder mixed).

    Das Argument *xpathQuery* muss ein gültiger XPath-1.0-Ausdruck sein. Von dieser Regel gibt es wenige Ausnahmen. Tcl-Variablenverweise, in der üblichen Tcl-Syntax $varname, dürfen im XPath-Ausdruck an jeder Stelle stehen, an der die XPath-Syntax eine XPath-Variable erlaubt. Abgesehen von den XPath-Syntaxregeln darf der Tcl-Variablenname jeder zulässige Tcl-Variablenname sein: lokale Variablen, globale Variablen, Array-Einträge und so weiter. Die xpath-Maschine sieht den Wert immer als Zeichenkettenliteral. Der Wert lässt sich bei Bedarf mit den passenden xpath-Funktionen number() und boolean() ausdrücklich in einen anderen Datentyp wandeln.

    Ähnlich wie sich Literale über Tcl-Variablenverweise sicher in den XPath-Ausdruck setzen lassen, gibt es eine Schreibweise, um Elementnamen aus Tcl-Variablen einzusetzen. An jeder Stelle, an der die XPath-Syntax einen Knotentest erlaubt, kann ein Tcl-Variablenverweis in jeder Form stehen, nur das führende $ ist durch % ersetzt. So lassen sich Knoten mit seltsamen Knotennamen auswählen, die nach der passenden XML-Produktion ungültig sind. Das kann bei JSON-Daten nötig sein.

    Die Option *-namespaces* erwartet als Argument eine Tcl-Liste aus Paaren von Präfix und Namensraum. Fehlt die Option, wird jeder Namensraum-Präfix im xpath-Ausdruck zuerst gegen die Liste der Präfix-Namensraum-Paare aufgelöst, die die Methode selectNodesNamespaces für das Dokument gesetzt hat, zu dem der Knoten gehört. Gelingt das nicht, gelten die Namensraumdefinitionen im Geltungsbereich des Kontextknotens. Ist die Option angegeben, wird jeder Namensraum-Präfix im xpath-Ausdruck zuerst gegen diese Liste aufgelöst, und die dokumentweite Präfix-Namensraum-Liste wird ignoriert. Bindet die Liste denselben Präfix an verschiedene Namensräume, gilt die erste Bindung. Gelingt das nicht, gelten wie üblich die Namensraumdefinitionen im Geltungsbereich des Kontextknotens.

    Ist die Option *-cache* mit einem wahren Wert angegeben, wird *xpathQuery* in einem dokumenteigenen Cache gesucht. Wird die Abfrage gefunden, wird die gespeicherte vorkompilierte Abfrage verwendet. Wird sie nicht gefunden, wird sie kompiliert und für weitere Aufrufe im Cache gespeichert. Die als Zeichenkette angegebene *xpathQuery* ist der Schlüssel des Cache. Gleiche XPath-Ausdrücke, die sich nur im Leerraum unterscheiden, sind verschiedene Cache-Einträge. Besondere Vorsicht ist nötig, wenn der XPath-Ausdruck Namensraum-Präfixe oder Verweise auf Tcl-Variablen enthält. Beides wird nach den XML-Präfix-Namensraum-Zuordnungen und den Tcl-Variablenwerten zur Kompilierzeit des Ausdrucks aufgelöst. Wird derselbe XPath-Ausdruck später in einem Zusammenhang mit anderen XML-Präfix-Namensraum-Zuordnungen oder anderen Werten der verwendeten Tcl-Variablen benutzt, muss der kompilierte Ausdruck zuerst mit der Methode **deleteXPathCache** aus dem Cache genommen werden, damit er neu kompiliert wird. Ohne die Option *-cache* ist diese Überlegung nie nötig.

    Ist die Option *-list* angegeben, muss das Argument *xpathQuery* eine Tcl-Liste von XPath-Abfragen sein. Jede XPath-Abfrage in dieser Liste außer der letzten muss eine Knotenmenge liefern. Mit denselben Regeln für Kontext und Namensraumauflösung wie ohne *-list* läuft die erste Abfrage der Liste. Jeder Knoten ihrer Ergebnismenge ist der Kontextknoten der nächsten XPath-Abfrage der Liste, und so weiter. Zurück kommen die Ergebnismengen der letzten Abfrage der Liste, aneinandergehängt.

    Beispiele:

    ```
    set paragraphNodes [$node selectNodes {chapter[3]//para[@type='warning' or @type='error'} ]
    foreach paragraph $paragraphNodes {
        lappend  values [$paragraph selectNodes attribute::type]
    }

    set doc [dom parse {<doc xmlns="http://www.defaultnamespace.org"><child/></doc>}]
    set root [$doc documentElement]
    set childNodes [$root selectNodes -namespaces {default http://www.defaultnamespace.org} default:child]
    ```

**getLine**
: Gibt die Zeilennummer dieses Knotens im ursprünglich gelesenen XML zurück. Die Zählung beginnt bei 1.

**getColumn**
: Gibt die Spaltennummer dieses Knotens im ursprünglich gelesenen XML zurück. Die Zählung beginnt bei 0.

**getByteIndex**
: Gibt die Byteposition dieses Knotens im ursprünglich gelesenen XML zurück. Die Zählung beginnt bei 0.

**asList**
: Gibt den DOM-Teilbaum ab dem aktuellen Knoten als verschachtelte Tcl-Liste zurück.

**asXML** **?-indent none/tabs/1..8?** **?-channel channelId?** **?-escapeNonASCII?** **?-doctypeDeclaration <boolean>?** **-xmlDeclaration <boolean>?** **-encString <string>** **?-escapeAllQuot?** **?-indentAttrs?** **?-nogtescape?** **?-noEmptyElementTag?** **?-escapeCR?** **?-escapeTab?**
: Gibt den DOM-Teilbaum ab dem aktuellen Knoten als Wurzel des Ergebnisses als optional eingerückte XML-Zeichenkette zurück oder sendet die Ausgabe direkt an die angegebene channelId.

    Die genaue Beschreibung der Argumente steht in der Dokumentation des

    [domDoc]
    :  Befehls **asXML**.


**asCanonicalXML** **?-channel channelId?** **?-comment?**
: Gibt den DOM-Baum als kanonische XML-Zeichenkette nach der "Canonical XML Version 1.0 W3C Recommendation 15 March 2001" zurück oder sendet die Ausgabe direkt an die angegebene channelId.

    Die genaue Beschreibung der Argumente steht in der Dokumentation des

    [domDoc]
    :  Befehls **asCanonicalXML**.


**asHTML** **?-channel channelId?** **b?-escapeNonASCII?** **?-htmlEntities?** **?-doctypeDeclaration <boolean>?** **?-breakLines?** **?-onlyContents?**
: Gibt den DOM-Teilbaum ab dem aktuellen Knoten als Wurzel des Ergebnisses nach HTML-Regeln serialisiert zurück. HTML-Elemente werden unabhängig von der Schreibung erkannt, leere HTML-Elemente ohne Endmarken und so weiter. Das Ergebnis ist eine Zeichenkette, oder die Ausgabe geht direkt an die angegebene channelId.

    Die genaue Beschreibung der Argumente steht in der Dokumentation der

    [domDoc]
    :  Methode **asHTML**.


**asText**
: Bei ELEMENT_NODE gibt die Methode asText den Zeichenkettenwert jedes Textknoten-Nachfahren des Knotens in Dokumentreihenfolge ohne Maskierung aus. Bei jedem anderen Knotentyp gibt die Methode den XPath-Zeichenkettenwert dieses Knotens aus.

**asJSON** **?-indent none/0..8?** **?-channel channelId?**
: Die Methode asJSON serialisiert den Teilbaum ab dem Knoten, an dem die Methode aufgerufen wurde, in eine gültige JSON-Datenzeichenkette.

    Die genaue Beschreibung der Methode steht in der Dokumentation der

    [domDoc]
    :  Methode **asJSON**.


**asTclValue** **?typevariable?**
: Enthält der Teilbaum ab dem Knoten, an dem die Methode aufgerufen wurde, JSON-Typangaben, gibt diese Methode die JSON-Daten als verschachtelte Tcl-Datenstruktur zurück.

    Die genaue Beschreibung der Methode steht in der Dokumentation der

    [domDoc]
    :  Methode **asTclValue**.


**appendFromList** *list*
: Liest *list*, legt einen entsprechenden DOM-Teilbaum an und hängt ihn an den aktuellen Knoten.

**appendFromScript** *tclScript*
: Hängt die Knoten, die im *tclScript* von Tcl-Funktionen angelegt werden, die mit *dom createNodeCmd* gebaut wurden, an den angegebenen Knoten.

**insertBeforeFromScript** *tclScript* *refChild*
: Fügt die Knoten, die im *tclScript* von Tcl-Funktionen angelegt werden, die mit *dom createNodeCmd* gebaut wurden, vor *refChild* in die Kindliste des Knotens ein. Ist *refChild* die leere Zeichenkette, werden die neuen Knoten angehängt.

**appendXML** *XMLstring*
: Liest *XMLstring*, legt einen entsprechenden DOM-Teilbaum an und hängt ihn an den aktuellen Knoten.

**simpleTranslate** *outputVar* *specifications*
: Überträgt den Teilbaum ab dem Objektknoten nach den Angaben in *specifications* und schreibt das Ergebnis in die Variable *outputVar*. Die Übertragung ähnelt stark dem Modus Cost Simple.

**toXPath** *?-legacy?*
: Gibt einen XPath zurück, der den angegebenen Knoten in seinem Dokument genau bezeichnet. Dieser XPath gilt nur, solange der DOM-Baum danach nicht geändert wird. Mit der Option -legacy kommen andere XPath-Ausdrücke zurück, die nicht in allen Fällen funktionieren.

**getBaseURI**
: Gibt die baseURI des Knotens zurück. Diese Methode ist veraltet, an ihrer Stelle steht die Methode *baseURI*.

**baseURI** *?URI?*
: Gibt die aktuelle baseURI des Knotens zurück. Ist das optionale Argument URI angegeben, setzt es die Basis-URI des Knotens und aller seiner Kindknoten aus derselben Entität wie der Knoten auf den angegebenen URI.

**disableOutputEscaping** *?boolean?*
: Diese Methode gilt nur für Textknoten. Bei jedem anderen Knoten kommt ein Fehler zurück. Ohne das optionale Argument gibt sie zurück, ob die Ausgabemaskierung aus ist. Der Rückgabewert 0 heißt: die Zeichen des Textknotens werden maskiert, damit beim Serialisieren gültiges XML entsteht. Das ist die Vorgabe für jeden gelesenen oder angelegten Textknoten, außer Textknoten in einem Ergebnisbaum einer XSLT-Transformation, für die das Stylesheet die abgeschaltete Ausgabemaskierung ausdrücklich verlangt hat. Der Rückgabewert 1 heißt: die Ausgabemaskierung ist für diesen Textknoten aus. Wird ein solcher Textknoten serialisiert, mit asXML oder asHTML, wird er wörtlich geschrieben, ohne Maskierung der besonderen XML-Zeichen. Ist der optionale boolesche Wert *boolean* angegeben, wird die Marke entsprechend gesetzt. Die Marke sollte nur auf 1 gesetzt werden, wenn die Wirkung bekannt ist.

**precedes** *refnode*
: Vergleicht die relative Ordnung des Knotens und von *refnode*. Beide Knoten müssen zum selben Dokument gehören und dürfen nicht in der Fragmentliste des Dokuments stehen. Gibt wahr zurück, wenn der Knoten in Dokumentreihenfolge im Sinne der XPath-1.0-Empfehlung vor *refnode* steht, sonst falsch.

**normalize** *?-forXPath?*
: Bringt alle Textknoten in der ganzen Tiefe des Teilbaums unter diesem Knoten in eine normale Form, in der nur Struktur Textknoten trennt, also Elemente, Kommentare, Verarbeitungsanweisungen und CDATA-Abschnitte. Es gibt dann weder benachbarte noch leere Textknoten. Mit der Option *-forXPath* werden alle CDATA-Abschnitte in den Knoten zuerst in Textknoten gewandelt, vor der Normalisierung.

**xslt** **?-parameters parameterList?** **?-ignoreUndeclaredParameters?** **?-maxApplyDepth int?** **?-xsltmessagecmd script?** *stylesheet* *?outputVar?*
: Wendet eine XSLT-Transformation auf das Dokument an, mit dem XSLT-*stylesheet* als domDoc. Gibt ein Dokumentobjekt mit dem Ergebnisdokument dieser Transformation zurück und speichert es in der optionalen *outputVar*.

    Die optionale Option *-parameters* setzt <xsl:param> der obersten Ebene auf Zeichenkettenwerte. *parameterList* muss eine Tcl-Liste aus Paaren von Parametername und Wert sein.

    Mit der Option *-ignoreUndeclaredParameters* werden Parameternamen in der *parameterList* der Option *-parameters* still ignoriert, die im Stylesheet nicht als Parameter der obersten Ebene deklariert sind. Ohne diese Option wird ein Fehler ausgelöst, wenn ein Parameter der obersten Ebene gesetzt werden soll, den das Stylesheet nicht deklariert.

    Die Option *-maxApplyDepth* erwartet eine positive ganze Zahl. Voreingestellt erlaubt die XSLT-Maschine eine Verschachtelung von XSLT-Vorlagen bis zu 3000 Ebenen und löst einen Fehler aus, wenn sie tiefer verschachteln. Diese Grenze setzt die Option *-maxApplyDepth*.

    Die Option *-xsltmessagecmd* setzt eine Rückruffunktion für xslt:message-Elemente im Stylesheet. Der tatsächliche Befehl besteht aus dem Skript, das der Option als Argument übergeben wird, angehängt der XML-Fragment-Zeichenkette aus der Instanzierung des Inhalts des Elements xsl:message, so als wäre die XPath-Funktion string() auf das XML-Fragment angewendet worden, und einer Marke, die angibt, ob xsl:message ein Attribut "terminate" mit dem Wert "yes" hat. Gibt das aufgerufene Skript etwas anderes als TCL\_OK zurück, bricht die XSLT-Transformation ab und gibt einen Fehler zurück. Gibt das aufgerufene Skript -code break zurück, ist die Fehlermeldung leer, sonst wird der Ergebniscode gemeldet. Bei abgebrochener Transformation wird outputVar, falls angegeben, auf die leere Zeichenkette gesetzt.

*@attrName*
: Gibt den Wert des Attributs *attrName* zurück. Kurzform für *getAttribute*.

**jsonType** *?(OBJECT|ARRAY|NONE)|(STRING|NUMBER|TRUE|FALSE|NULL|NONE)?*
: Nur Element- und Textknoten können einen JSON-Typ haben, und nur diese Knotentypen kennen die Methode *jsonType*. Die anderen Knotentypen geben einen Fehler zurück, wenn die Methode an ihnen aufgerufen wird. Gibt den jsonType des Knotens zurück. Ist das optionale Argument angegeben, wird der JSON-Typ des Knotens auf den angegebenen Typ gesetzt und zurückgegeben. Gültige Typargumente für Elementknoten sind OBJECT, ARRAY und NONE. Gültige Typargumente für Textknoten sind STRING, NUMBER, TRUE, FALSE, NULL und NONE.


Ist sonst ein unbekannter Methodenname angegeben, wird versucht, den Befehl dieses Namens im Namensraum **::dom::domNode** auszuführen. So lassen sich auf Tcl-Ebene schnell Methoden ergänzen.


[domDoc]: domDoc.md
