---
CommandName: domDoc
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: 
Links:
 - dom
 - domNode
Keywords:
 - DOM node creation
 - document element
Copyright:
---

# NAME

domDoc - Eine Instanz eines DOM-Dokumentobjekts bearbeiten

# ÜBERSICHT

```
domDocObjCmd method ?arg arg ...?
```

# BESCHREIBUNG

Dieser Befehl bearbeitet eine bestimmte Instanz eines Dokumentobjekts. *method* bezeichnet eine bestimmte Methode der Dokumentklasse. Diese Methoden sollen sich eng an die W3C-Empfehlung "Document Object Model (Core) Level 1" (http://www.w3.org/TR/REC-DOM-Level-1/level-one-core.html) halten. Diese Dokumente beschreiben die Funktion genauer.

Die gültigen Methoden sind:

**documentElement** ?*objVar*__?__
: Gibt das oberste Element im Dokument zurück, das Wurzelelement.

**getElementsByTagName** *name*
: Gibt eine Liste aller Elemente im Dokument zurück, die im Glob-Stil auf *name* passen.

**getElementsByTagNameNS** *uri* *localname*
:  Gibt eine Liste aller Elemente im Teilbaum zurück, die im Glob-Stil auf *localname* passen und den angegebenen Namensraum *uri* haben.

**createElement** *tagName* **?**_objVar_**?**
: Legt einen neuen Elementknoten mit dem Knotennamen *tagName* an, hängt ihn an die versteckte Fragmentliste im Dokumentobjekt an und gibt das Knotenobjekt zurück.  Ist *objVar* angegeben, wird das neue Knotenobjekt in dieser Variable gespeichert.

**createElementNS** *url* *tagName* **?**_objVar_**?**
: Legt einen neuen Elementknoten in einem Namensraum an, mit *uri* als URI und dem Knotennamen *tagName*, der den Namensraumpräfix enthalten kann, hängt ihn an die versteckte Fragmentliste im Dokumentobjekt an und gibt das Knotenobjekt zurück.  Ist *objVar* angegeben, wird das neue Knotenobjekt in dieser Variable gespeichert.

**createTextNode** *text* **?**_objVar_**?**
: Legt einen neuen Textknoten mit dem Knotenwert *text* an, hängt ihn an die versteckte Fragmentliste im Dokumentobjekt an und gibt das Knotenobjekt zurück.  Ist *objVar* angegeben, wird das neue Knotenobjekt in dieser Variable gespeichert.

**createComment** *text* **?**_objVar_**?**
: Legt einen neuen Kommentarknoten mit dem Wert *text* an, hängt ihn an die versteckte Fragmentliste im Dokumentobjekt an und gibt das Knotenobjekt zurück.  Ist *objVar* angegeben, wird das neue Kommentarknotenobjekt in dieser Variable gespeichert.

**createCDATASection** *data* **?**_objVar_**?**
: Legt einen neuen CDATA-Knoten mit dem Knotenwert *data* an, hängt ihn an die versteckte Fragmentliste im Dokumentobjekt an und gibt das Knotenobjekt zurück.  Ist *objVar* angegeben, wird das neue Knotenobjekt in dieser Variable gespeichert.

**createProcessingInstruction** *target* *data* **?**_objVar_**?**
: Legt eine Verarbeitungsanweisung an, hängt sie an die versteckte Fragmentliste im Dokumentobjekt an und gibt das Knotenobjekt zurück.  Ist *objVar* angegeben, wird das neue Knotenobjekt in dieser Variable gespeichert.

**delete**
: Löscht das Dokument ausdrücklich, einschließlich der zugehörigen Tcl-Objektbefehle für Knoten, Fragment- und neue Knoten und das Dokumentobjekt selbst, und den zugrunde liegenden DOM-Baum.

**getDefaultOutputMethod**
: Gibt die Vorgabe-Ausgabemethode des Dokuments zurück. Das ist gewöhnlich das Ergebnis einer XSLT-Transformation.

**asXML** **?-indent none/tabs/1..8?** **?-channel channelId?** **?-escapeNonASCII?** **?-doctypeDeclaration \<boolean>?** **-xmlDeclaration \<boolean>?** **-encString \<string>** **?-escapeAllQuot?** **?-indentAttrs?** **?-nogtescape?** **?-noEmptyElementTag?** **?-escapeCR?** **?-escapeTab?**
: 


Gibt den DOM-Baum als optional eingerückte XML-Zeichenkette zurück oder sendet die Ausgabe direkt an die angegebene channelId.

Die Option -indent verlangt als Wert "no", "none", "tabs" oder eine natürliche Zahl zwischen 0 und 8, beide eingeschlossen. Mit den Werten "no" oder "none" wird außerhalb des Markups kein zusätzlicher Leerraum zur Serialisierung hinzugefügt. I. Sonst ist es eine "pretty-print"-Serialisierung, weil zwischen dem Ende-Tag und dem nächsten Start-Tag entsprechend der Schachtelungstiefe Leerraum eingefügt wird. Die Breite der Einrückung je Ebene gibt die Zahl an. Ist der Wert "tabs", erfolgt die Einrückung mit Tabulatoren, ein Tabulator je Ebene.

Ist die Option *-escapeNonASCII* angegeben, wird jedes Zeichen außerhalb von 7-Bit-ASCII in Attributwerten oder im PCDATA-Inhalt von Elementen als Zeichenreferenz in dezimaler Darstellung geschützt.

Die Markierung *-doctypeDeclaration* bestimmt, ob vor dem ersten Knoten des Dokuments eine DOCTYPE-Deklaration ausgegeben wird. In der Vorgabe wird sie nicht ausgegeben. Der DOCTYPE-Name ist immer der Elementname des Dokumentelements. Eine Deklaration der externen Entität der externen Teilmenge wird nur ausgegeben, wenn das Dokument einen Systembezeichner hat.

Die Markierung *-xmlDeclaration* bestimmt, ob vor allem anderen eine XML-Deklaration und ein Zeilenumbruch ausgegeben werden. In der Vorgabe wird keine ausgegeben. Ist diese Markierung mit einem wahren Argument angegeben, dann

*-encString* setzt den Kodierungswert in der XML-Deklaration. Sonst wird diese Option übergangen. Diese Option ergänzt nur die Zeichenketten-Darstellung der erzeugten XML-Deklaration um eine Kodierungsangabe, nicht mehr. Die Kodierung beim Schreiben in einen Kanal oder beim erneuten Lesen bleibt Sache des Aufrufers.

Ist die Option *-escapeAllQuot* angegeben, werden Anführungszeichen auch im Textinhalt von Elementen mit &quot; geschützt.

Ist die Option *-indentAttrs* angegeben, wird jedes Attribut mit Zeilenumbrüchen getrennt und auf dieselbe Ebene wie der Elternknoten eingerückt, zuzüglich des als Argument von *-indentAttrs* angegebenen Werts (0..8).

Ist die Option *-nogtescape* angegeben, wird das Zeichen '>' in Attributwerten und im Textinhalt von Elementen nicht geschützt. In der Vorgabe wird dieses Zeichen geschützt.

Ist die Option *-noEmptyElementTag* angegeben, wird keine Syntax für leere Tags verwendet. Hat ein Element leeren Inhalt, wird es mit einem Element-Start-Tag und einem unmittelbar folgenden Element-Ende-Tag serialisiert.

Ist die Option *-escapeCR* angegeben, wird das Zeichen '\\r' in Attributwerten und im Textinhalt von Elementen als Zeichenreferenz geschützt. In der Vorgabe geschieht das nicht.

Ist die Option *-escapeTab* angegeben, wird das Zeichen '\\t' in Attributwerten und im Textinhalt von Elementen als Zeichenreferenz geschützt. In der Vorgabe geschieht das nicht.

**asCanonicalXML** **?-channel channelId?** **?-comments \<boolean>?**
: 


Gibt den DOM-Baum als kanonische XML-Zeichenkette nach der "Canonical XML Version 1.0 W3C Recommendation 15 March 2001" zurück oder sendet die Ausgabe direkt an die angegebene channelId.

Soll die kanonische XML-Serialisierung der XML-Datei entstehen, aus der der DOM-Baum gelesen wurde, gelten ein paar Voraussetzungen. Die XML-Daten müssen mit der Option *-keepEmpties* gelesen werden. Enthalten die XML-Daten eine DTD, die Attributvorgaben oder Verweise auf externe gelesene Entitäten definiert, ist der expat-Parser nötig, nicht der mit *-simple*. Enthalten die XML-Daten bei einer unterstützten Tcl-Version kleiner als 9.0 Zeichen außerhalb der BMP, ist ein Tcl-Bau mit TCL_UTF_MAX gleich 6 und ein tDOM-Bau mit diesem Tcl nötig.

Ist die Option -channel angegeben, geht die Ausgabe direkt an den als Argument angegebenen Tcl-Kanal. Der Aufrufer muss sicherstellen, dass der Kanal richtig konfiguriert ist. Fehlt diese Option, gibt der Befehl die Serialisierung als Zeichenkette zurück.

Ist die Option *-comments* mit einem wahren Wert angegeben, enthält die Serialisierung Kommentare nach den Regeln der Empfehlung. Ist der Wert falsch oder fehlt die Option, werden Kommentare aus der Serialisierung entfernt.

**asHTML** **?-channel channelId?** **?-escapeNonASCII?** **?-htmlEntities?** **?-doctypeDeclaration \<boolean>?** **?-breakLines?** **?-onlyContents?**
: 


Gibt den nach HTML-Regeln serialisierten DOM-Baum als Zeichenkette zurück oder sendet die Ausgabe direkt an die angegebene channelId. HTML-Elemente werden unabhängig von der Großschreibung erkannt, leere HTML-Elemente ohne Ende-Tags und so weiter.

Ist die Option *-escapeNonASCII* angegeben, wird jedes Zeichen außerhalb von 7-Bit-ASCII in Attributwerten oder im PCDATA-Inhalt von Elementen als Zeichenreferenz in dezimaler Darstellung geschützt.

Ist die Option *-htmlEntities* angegeben, wird ein Zeichen oder ein Zeichenpaar mit seiner HTML-5-Zeichenentität geschrieben, wenn es eine hat. Manche HTML-5-Zeichenentitäten kodieren dasselbe Zeichen oder dieselben Codepunkte. Von den möglichen Entitätsnamen wird der kürzeste gewählt. Gibt es mehr als einen kürzesten Namen und unterscheiden sich diese Namen nur in der Großschreibung, wird die kleingeschriebene Variante gewählt. Sonst wird der erste Name in lexikalischer ASCII-Reihenfolge gewählt. Es gibt eine HTML5-Entität (ThickSpace), die zwei Zeichen schützt, für die das erste und das zweite Zeichen selbst einen Entitätsnamen haben. Sollen die zwei Zeichen serialisiert werden, wird die Entität ThickSpace für zwei Zeichen gewählt.

Ist die Option *-breakLines* angegeben, gibt die Serialisierung für die öffnenden Tags von Elementen "\\n>" statt ">" aus.

Ist die Option *-onlyContents* angegeben, werden nur alle Kindknoten serialisiert. Dokumentknoten übergehen diese Option.

Ist die Markierung *-doctypeDeclaration* angegeben, wird vor dem ersten Knoten des Dokuments eine DOCTYPE-Deklaration ausgegeben. In der Vorgabe geschieht das nicht. Der DOCTYPE-Name ist immer der Elementname des Dokumentelements ohne Normalisierung der Großschreibung. Eine Deklaration der externen Entität der externen Teilmenge wird nur ausgegeben, wenn das Dokument einen Systembezeichner hat. Die Doctype-Deklaration wird aus den vorhandenen Angaben geschrieben, ohne Prüfung, ob das eine bekannte HTML-Versionsangabe des W3C ist oder ob das Dokument der angegebenen HTML-Version entspricht. Alle Knotentypen außer Dokumentknoten übergehen diese Option.

**asText**
: Die Methode asText gibt den Baum zurück, indem sie den Zeichenkettenwert jedes Textknotens in Dokumentreihenfolge ohne jeden Schutz serialisiert. Das ist genau das, was die XSLT-Ausgabemethode "text" tut, Empfehlung XSLT 1.0, Abschnitt 16.3.

**asJSON** **?-indent none/0..8?** **?-channel channelId?**
: 


Die Methode asJSON serialisiert den Baum in eine gültige JSON-Datenzeichenkette. Im Allgemeinen kann diese Serialisierung verlustbehaftet sein. Für diese Serialisierung werden alle Kommentare, Zeichendatenabschnitte und Knoten von Verarbeitungsanweisungen, alle Attribute und alle XML-Namensräume übergangen. In der erzeugten JSON-Serialisierung können sich nur Element- und Textknoten niederschlagen. Passende JSON-Datentypangaben eines Knotens werden beachtet.

Hat ein Elementknoten den JSON-Typ OBJECT, wird jedes Elementknoten-Kind dieses Elements als Member dieses Objekts serialisiert, mit dem Knotennamen des Kindes als Member-Namen und den maßgeblichen Kindern dieses Kindes als Wert. Alle anderen Kindknoten werden übergangen.

Hat ein Elementknoten den JSON-Typ ARRAY, werden die Text- und Elementknoten-Kinder dieses Elementknotens als die aufeinanderfolgenden Werte des Arrays serialisiert. Elementknoten-Kinder eines ARRAY-Elements sind Container-Knoten für verschachtelte Werte ARRAY oder OBJECT.

Textknoten mit den JSON-Typen TRUE, FALSE oder NULL werden zum entsprechenden JSON-Token serialisiert, ohne den Wert des Textknotens anzusehen. Ein Textknoten ohne JSON-Typ wird immer als JSON-Zeichenketten-Token serialisiert. Ein Textknoten mit dem JSON-Typ NUMBER wird als JSON-Zahl-Token serialisiert, wenn der Wert des Textknotens tatsächlich eine gültige JSON-Zahl ist, und sonst als JSON-Zeichenkette.

Hat ein Elementknoten keinen JSON-Typ, bestimmen die folgenden Regeln die Serialisierung seiner Kinder:

Maßgeblich sind nur Text- und Elementknoten-Kinder. Ist der zu serialisierende Elementknoten der Member eines JSON-Objekts und gibt es keinen maßgeblichen Kindknoten, ist der Wert dieses Members eine leere JSON-Zeichenkette. Ist der einzige maßgebliche Kindknoten dieses Elementknotens ein Textknoten, ist der JSON-Wert dieses Textknotens der Wert des Objekt-Members. Hat das Element mehr als einen maßgeblichen Kindknoten und ist der erste ein Textknoten, werden die maßgeblichen Kinder als JSON-Array serialisiert. Ist der einzige maßgebliche Kindknoten ein Elementknoten oder ist das erste maßgebliche Kind ein Elementknoten und gleicht der Knotenname dieses einzigen oder ersten maßgeblichen Kindes nicht dem Namen des Array-Container-Knotens, werden alle Elementknoten-Kinder als die Member eines JSON-Objekts serialisiert, wobei eingestreute Textknoten übergangen werden. Ist das einzige oder erste maßgebliche Kind ein Elementknoten und gleicht der Knotenname dieses Kindes dem Namen des Array-Container-Elements, werden alle maßgeblichen Kinder als die Werte eines JSON-Arrays serialisiert.

Ist das zu serialisierende Element ein Wert eines JSON-Arrays und gleicht der Knotenname dieses Elements nicht dem Namen des Array-Container-Knotens, gilt dieses Element als Container-Knoten für ein JSON-Objekt, und alle Elementknoten-Kinder werden als die Member dieses Arrays serialisiert, wobei Textknoten-Kinder übergangen werden. Ist das zu serialisierende Element ein Wert eines JSON-Arrays und gleicht der Knotenname dieses Elements dem Namen des Array-Container-Knotens, werden alle maßgeblichen Kinder als JSON-Array serialisiert.

Ist die Option *-channel* angegeben, kommt die Serialisierung nicht als Zeichenkette zurück, sondern geht direkt an den Kanal, der der Option als Argument angegeben ist.

Ist die Option *-indent* angegeben und ist das Argument dieser Option nicht "none", wird die zurückgegebene JSON-Zeichenkette "pretty-printed". Das numerische Argument dieser Option bestimmt die Anzahl der Leerzeichen je Einrückungsebene. In der Vorgabe wird kein zusätzlicher Leerraum ausgegeben.

**asTclValue** **?typevariable?**
: 


Enthält der DOM-Baum JSON-Typangaben, gibt diese Methode die JSON-Daten als verschachtelte Tcl-Datenstruktur zurück.

Der zurückgegebene Wert kann ein Tcl-Dict, eine Tcl-Liste oder eine Zeichenkette sein. Ist das optionale Argument *typevariable* angegeben, wird die Variable dieses Namens auf den Wert *dict*, *list* oder *string* gesetzt und zeigt so den Typ des Ergebnisses an.

Ein JSON-Objekt kommt als Tcl-Dict zurück, ein JSON-Array als Liste, und JSON-Zeichenketten und Zahlen sowie die symbolischen JSON-Werte null, true und false kommen als Zeichenkette zurück, mit den Zeichenketten null, true und false für das jeweilige JSON-Symbol. Der Wert eines Members eines JSON-Objekts kann ebenfalls ein Tcl-Dict, eine Tcl-Liste oder eine Zeichenkette sein, und die Elemente einer JSON-Array-Liste können ein Tcl-Dict, eine Tcl-Liste oder eine Zeichenkette sein.

**asTypedList**
: 


Enthält der DOM-Baum JSON-Typangaben, gibt diese Methode die JSON-Daten als verschachtelte Tcl-Liste zurück.

Das erste Element jeder dieser Listen beschreibt den Typ des Werts. Die Typen sind OBJECT, ARRAY, STRING, NUMBER, TRUE, FALSE oder NULL.

Ist der Typ NUMBER oder STRING, ist das zweite und letzte Element der Wert. Ist der Typ NULL, TRUE oder FALSE, hat die Liste keine weiteren Elemente.

Ist der Typ OBJECT, ist der zweite Wert eine Tcl-Liste aus Paaren von Eigenschaftsname und Wert, das zweite Element lässt sich also als Dict verwenden. Der Wert ist eine Tcl-Liste, aufgebaut nach den Regeln der Methode *asTypedList*.

Ist der Typ ARRAY, ist der zweite Wert eine Tcl-Liste der JSON-Array-Werte, jeder einzelne aufgebaut nach den Regeln der Methode *asTypedList*.

**publicId** *?publicId?*
: Gibt den öffentlichen Bezeichner der Doctype-Deklaration des Dokuments zurück, wenn es einen gibt, sonst die leere Zeichenkette. Ist der Methode ein Wert angegeben, wird der öffentliche Bezeichner des Dokuments auf diesen Wert gesetzt.

**systemId** *?systemId?*
: Gibt den Systembezeichner der Doctype-Deklaration des Dokuments zurück, wenn es einen gibt, sonst die leere Zeichenkette. Ist der Methode ein Wert angegeben, wird der Systembezeichner des Dokuments auf diesen Wert gesetzt.

**internalSubset** *?internalSubset?*
: Gibt die interne Teilmenge der Doctype-Deklaration des Dokuments zurück, wenn es eine gibt, sonst die leere Zeichenkette. Ist der Methode ein Wert angegeben, wird die interne Teilmenge des Dokuments auf diesen Wert gesetzt. Keine der Lesemethoden bewahrt die interne Teilmenge eines Dokuments. Ein frisch gelesenes Dokument hat immer eine leere interne Teilmenge. Die Methode prüft eine angegebene interne Teilmenge auch nicht syntaktisch.

**cdataSectionElements** *(?URI:?localname|\*) ?\<boolean>?*
: Diese Methode steuert, für welche Elementknoten die Textknoten-Kinder als CDATA-Abschnitte serialisiert werden. Das betrifft nur die Serialisierung mit der Methode asXML, kein Textknoten wird von dieser Methode irgendwie verändert. Wird die Methode mit einem Elementnamen als erstem Argument und einem booleschen Wert wahr als zweitem Argument aufgerufen, wird jedes Textknoten-Kind jedes Elementknotens im Dokument mit demselben Namen wie das erste Argument als CDATA-Abschnitt serialisiert. Ist das zweite Argument ein boolescher Wert falsch, werden alle Textknoten aller Elemente mit demselben Namen wie das erste Argument wie üblich serialisiert. Elementnamen mit Namensraum müssen in der Form namespace_URI:localname angegeben werden, nicht in der sonst üblichen Form prefix:localname. Mit zwei Argumenten aufgerufen gibt die Methode den verwendeten booleschen Wert zurück. Wird die Methode nur mit einem Elementnamen aufgerufen, gibt sie einen booleschen Wert zurück, der anzeigt, dass die Textknoten-Kinder aller Elemente dieses Namens im Dokument als CDATA-Abschnitt-Elemente serialisiert werden (Rückgabewert 1) oder nicht (Rückgabewert 0). Wird die Methode mit nur einem Argument aufgerufen und ist dieses Argument ein Stern ('\*'), gibt die Methode eine ungeordnete Liste aller Elementnamen des Dokuments zurück, für die die Textknoten-Kinder als CDATA-Abschnitt-Knoten serialisiert werden.

**selectNodesNamespaces** **?prefixUriList?**
: Diese Methode steuert eine dokumentweite Zuordnung von Präfix zum Namensraum-URI. Sie wird für Aufrufe der Methode selectNodes verwendet, am Dokument und an allen Knoten, die zum Dokument gehören, sofern die Option -namespaces der Methode selectNodes sie nicht überschreibt. Jeder Namensraumpräfix in einem XPath-Ausdruck wird zuerst gegen diese Liste aufgelöst. Bindet die Liste denselben Präfix an verschiedene Namensräume, gilt die erste Bindung. Lässt sich ein Präfix nicht gegen die dokumentweite Liste aus Präfix und Namensräumen auflösen, werden wie üblich die Namensraumdefinitionen im Geltungsbereich des Kontextknotens verwendet. Ist das optionale Argument *prefixUriList* angegeben, wird die globale Liste aus Präfix und Namensraum auf diese Liste gesetzt, und die Methode gibt sie zurück. Ohne das optionale Argument gibt die Methode die aktuelle Liste zurück. Die Vorgabe ist die leere Liste.

**xslt** **?-parameters parameterList?** **?-ignoreUndeclaredParameters?** **?-maxApplyDepth int?** **?-xsltmessagecmd script?** *stylesheet* *?outputVar?*
: Wendet eine XSLT-Transformation auf das ganze Dokument des Knotenobjekts an, mit dem XSLT-*stylesheet*, angegeben als domDoc. Gibt ein Dokumentobjekt mit dem Ergebnisdokument der Transformation zurück und speichert dieses Dokumentobjekt in der optionalen *outputVar*, falls sie angegeben ist.


Die optionale Option *-parameters* setzt \<xsl:param> der obersten Ebene auf Zeichenkettenwerte. Die *parameterList* muss eine Tcl-Liste aus Paaren von Parametername und Wert sein.

Ist die Option *-ignoreUndeclaredParameters* angegeben, werden Parameternamen in der *parameterList* der Option *-parameters*, die im Stylesheet nicht als Parameter der obersten Ebene deklariert sind, still übergangen. Ohne diese Option wird ein Fehler ausgelöst, wenn ein Parameter der obersten Ebene gesetzt wird, der im Stylesheet nicht deklariert ist.

Die Option *-maxApplyDepth* erwartet als Argument eine positive ganze Zahl. In der Vorgabe erlaubt die XSLT-Maschine, dass sich XSLT-Templates bis zu 3000 Ebenen schachteln, und löst einen Fehler aus, wenn sie tiefer schachteln. Diese Grenze lässt sich mit der Option *-maxApplyDepth* setzen.

Die Option *-xsltmessagecmd* setzt eine Rückruffunktion für Elemente xslt:message im Stylesheet. Der tatsächliche Befehl besteht aus dem Skript, das der Option als Argument angegeben ist, angehängt das XML-Fragment aus der Instanziierung des Elementinhalts von xsl:message als Zeichenkette, als wäre die XPath-Funktion string() auf das XML-Fragment angewandt worden, und eine Markierung, die anzeigt, ob xsl:message ein Attribut "terminate" mit dem Wert "yes" hat. Gibt das aufgerufene Skript etwas anderes als TCL_OK zurück, wird die XSLT-Transformation abgebrochen und ein Fehler zurückgegeben. Gibt das aufgerufene Skript -code break zurück, ist die Fehlermeldung leer, sonst wird der Ergebniscode gemeldet. Bei abgebrochener Transformation wird outputVar, falls angegeben, auf die leere Zeichenkette gesetzt.

**toXSLTcmd** ?*objVar*__?__
: Stellt der DOM-Baum ein gültiges XSLT-Stylesheet dar, wandelt diese Methode den DOM-Baum in einen XSLT-Befehl um, sonst gibt sie einen Fehler zurück. Der angelegte xsltCmd wird zurückgegeben und in der *objVar* gespeichert, wenn ein Variablenname angegeben war. Eine erfolgreiche Umwandlung des DOM-Baums in einen xsltCmd entfernt den Befehl domDoc und alle nodeCmds des Dokuments.


Die Syntax des angelegten xsltCmd ist:

```
xsltCmd method ?arg ...?
```

Die gültigen Methoden sind:

**transform** **?-parameters parameterList?** **?-ignoreUndeclaredParameters?** **?-maxApplyDepth int?**  **?-xsltmessagecmd script?** *domDoc* *?outputVar?*
: Wendet die XSLT-Transformation auf das Dokument *domDoc* an. Gibt ein Dokumentobjekt mit dem Ergebnisdokument dieser Transformation zurück und speichert es in der optionalen *outputVar*.


Die optionale Option *-parameters* setzt \<xsl:param> der obersten Ebene auf Zeichenkettenwerte. Die *parameterList* muss eine Tcl-Liste aus Paaren von Parametername und Wert sein.

Ist die Option *-ignoreUndeclaredParameters* angegeben, werden Parameternamen in der *parameterList* der Option *-parameters*, die im Stylesheet nicht als Parameter der obersten Ebene deklariert sind, still übergangen. Ohne diese Option wird ein Fehler ausgelöst, wenn ein Parameter der obersten Ebene gesetzt wird, der im Stylesheet nicht deklariert ist.

Die Option *-maxApplyDepth* erwartet als Argument eine positive ganze Zahl. In der Vorgabe erlaubt die XSLT-Maschine, dass sich XSLT-Templates bis zu 3000 Ebenen schachteln, und löst einen Fehler aus, wenn sie tiefer schachteln. Diese Grenze lässt sich mit der Option *-maxApplyDepth* setzen.

Die Option *-xsltmessagecmd* setzt eine Rückruffunktion für Elemente xslt:message im Stylesheet. Der tatsächliche Befehl besteht aus dem Skript, das der Option als Argument angegeben ist, angehängt das XML-Fragment aus der Instanziierung des Elementinhalts von xsl:message als Zeichenkette, als wäre die XPath-Funktion string() auf das XML-Fragment angewandt worden, und eine Markierung, die anzeigt, ob xsl:message ein Attribut "terminate" mit dem Wert "yes" hat.

**delete**
: Löscht den xsltCmd und räumt alle verwendeten Ressourcen auf. Ist das erste Argument eines xsltCmd ein domDoc oder beginnt es mit "-", wird der Befehl genauso verarbeitet wie *\<xsltCmd> transform*.


**normalize** *?-forXPath?*
: Bringt alle Textknoten im Dokument in eine "normale" Form, in der nur Struktur, zum Beispiel Elemente, Kommentare, Verarbeitungsanweisungen und CDATA-Abschnitte, Textknoten trennt. Es gibt also weder benachbarte Textknoten noch leere Textknoten. Ist die Option *-forXPath* angegeben, werden alle CDATA-Abschnitte in den Knoten als erster Schritt vor der Normalisierung in Textknoten umgewandelt.

**nodeType**
: Gibt den Knotentyp des Dokumentknotens zurück. Das ist immer DOCUMENT_NODE.

**getElementById** *id*
: Gibt den Knoten zurück, der ein id-Attribut mit dem Wert *id* hat, oder die leere Zeichenkette, wenn kein Knoten ein id-Attribut mit diesem Wert hat.

**firstChild** **?objVar?**
: Gibt den ersten Knoten der obersten Ebene des Dokuments zurück.

**lastChild** **?objVar?**
: Gibt den letzten Knoten der obersten Ebene des Dokuments zurück.

**appendChild** *newChild*
: Hängt *newChild* an das Ende der Liste der Knoten der obersten Ebene des Dokuments an.

**removeChild** *child*
: Entfernt *child* aus der Liste der Knoten der obersten Ebene des Dokuments. *child* ist nach dieser Operation Teil der Dokumentfragmentliste. Er wird nicht physikalisch gelöscht.

**hasChildNodes**
: Gibt 1 zurück, wenn das Dokument Knoten im Baum hat. Sonst kommt 0 zurück.

**childNodes**
: Gibt eine Liste der Knoten der obersten Ebene des Dokuments zurück.

**ownerDocument** **?domObjVar?**
: Gibt das Dokument selbst zurück.

**insertBefore** *newChild*  *refChild*
: Fügt *newChild* vor *refChild* in die Liste der Knoten der obersten Ebene des Dokuments ein. Ist *refChild* die leere Zeichenkette, wird *newChild* an das Ende der Knoten der obersten Ebene eingefügt.

**replaceChild** *newChild*  *oldChild*
: Ersetzt *oldChild* durch *newChild* in der Liste der Kinder dieses Knotens. Der Knoten *oldChild* ist nach dieser Operation Teil der Dokumentfragmentliste.

**appendFromList** *list*
: Liest *list* , legt einen entsprechenden DOM-Teilbaum an und hängt diesen Teilbaum an das Ende der aktuellen Liste der Knoten der obersten Ebene des Dokuments an.

**appendXML** *XMLstring*
: Liest *XMLstring*, legt einen entsprechenden DOM-Teilbaum an und hängt diesen Teilbaum an das Ende der aktuellen Liste der Knoten der obersten Ebene des Dokuments an.

**selectNodes** **?-namespaces prefixUriList?** **?-cache \<boolean>?** **?-list?** *xpathQuery* **?typeVar?**
: 


Gibt das Ergebnis der Anwendung der XPath-Abfrage *xpathQuery* auf das Dokument zurück. Der Kontextknoten der Abfrage ist der Wurzelknoten im Sinn der XPath-Empfehlung, nicht das Dokumentelement. Das Ergebnis kann eine Zeichenkette oder ein Wert, eine Liste von Zeichenketten, eine Liste von Knoten oder eine Liste aus Paaren von Attributname und Wert sein. Ist *typeVar* angegeben, wird der Name des Ergebnistyps in dieser Variable gespeichert: empty, bool, number, string, nodes, attrnodes oder mixed.

Die genaue Beschreibung der Argumente steht in der Dokumentation der der

**domNode**
:  Befehlsmethode **selectNodes**.


**baseURI** *?URI?*
: Gibt die aktuelle baseURI des Dokuments zurück. Ist das optionale Argument URI angegeben, wird die Basis-URI des Dokuments auf die angegebene URI gesetzt.

**appendFromScript** *tclScript*
: Hängt die Knoten, die das *tclScript* mit Tcl-Funktionen anlegt, die mit *dom createNodeCmd* gebaut wurden, an das Ende der aktuellen Liste der Knoten der obersten Ebene des Dokuments an.

**insertBeforeFromScript** *tclScript* *refChild*
: Fügt die Knoten, die im *tclScript* mit Tcl-Funktionen angelegt werden, die mit *dom createNodeCmd* gebaut wurden, vor *refChild* in die Liste der Knoten der obersten Ebene des Dokuments ein. Ist *refChild* die leere Zeichenkette, werden die neuen Knoten angehängt.

**deleteXPathCache** *?xpathQuery?*
: Ohne das optionale Argument werden alle zwischengespeicherten XPath-Ausdrücke des Dokuments freigegeben. Mit dem optionalen Argument *xpathQuery* wird diese einzelne XPath-Abfrage aus dem Zwischenspeicher entfernt, wenn sie dort liegt. Die Methode gibt immer eine leere Zeichenkette zurück. Wird sonst ein unbekannter Methodenname angegeben, wird versucht, den Befehl desselben Namens wie die angegebene Methode im Namensraum **::dom::domDoc** auszuführen. Das erlaubt schnelles Ergänzen von Methoden auf Tcl-Ebene. Neu angelegte Knoten werden an eine versteckte Fragmentliste angehängt. Werden sie nicht in den Baum verschoben, werden sie automatisch gelöscht, sobald das ganze Dokument gelöscht wird.
