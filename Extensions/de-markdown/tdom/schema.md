---
CommandName: schema
title: schema
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription:
Keywords:
 - Validation
 - Postvalidation
 - DOM
 - SAX
Copyright:
---

# Name

tdom::schema - Einen Befehl zur Schema-Prüfung anlegen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdom]{.lit}

[tdom::schema]{.cmd} [create]{.optarg} [cmdName]{.arg}
:::

# Beschreibung

Jeder Aufruf dieses Befehls legt einen neuen Prüfbefehl an. Ein Prüfbefehl hat Methoden, um ein Schema zu definieren, und kann XML-Daten prüfen oder einen tDOM-DOM-Baum nachträglich gegen dieses Schema prüfen, in gewissem Maß auch andere hierarchische Daten.

Ein Prüfbefehl kann außerdem als Argument der Option *-validateCmd* der Befehle *dom parse* und *expat* dienen, damit zusätzlich zu ihrer übrigen Arbeit geprüft wird.

Die Methoden der angelegten Befehle sind:

**prefixns** *?prefixUriList?*
: Diese Methode steuert die Zuordnung von Präfix oder Kurzform zum Namensraum-URI. Wo die Methoden des Schemabefehls ein Namensraum-Argument erwarten, kann der Präfix statt des Namensraum-URI stehen. Bildet die Liste denselben Präfix auf verschiedene Namensraum-URIs ab, gilt der erste. Gibt es den Präfix nicht, wird das Namensraum-Argument wörtlich als Namensraum-URI verwendet. Ohne Argument gibt die Methode die aktuelle prefixUriList zurück. Mit der leeren Zeichenkette werden alle Namensraum-URI-Argumente wörtlich verwendet. Das ist die Vorgabe.

**defelement** *name* *?namespace?* *<definition script>*
: Diese Methode definiert das Element *name* im Schema, optional im Namensraum *namespace*. Das *definition script* wird ausgewertet und definiert das Inhaltsmodell des Elements. Ist das Argument *namespace* angegeben, werden Verweise *element* oder *ref* im Definitionsskript, die nicht in einem Befehl *namespace* stehen, in diesem Namensraum aufgelöst. Gibt es für die Kombination aus Name und Namensraum schon eine Elementdefinition, löst der Befehl einen Fehler aus.

**defelementtype** *typename* *?namespace?* *<definition script>*
: Diese Methode definiert den Elementtyp *typename* im Schema, optional im Namensraum *namespace*. Wird der Elementtyp in einem Definitionsskript mit dem Schemabefehl element verwendet, erwartet die Prüfmaschine einen Elementinhalt nach dem Inhaltsmodell *definition script*. Elementtypen zu definieren und zu verwenden ist nur sinnvoll, wenn Elemente denselben Namen und Namensraum, aber verschiedene Inhaltsmodelle haben. Das *definition script* wird ausgewertet und definiert das Inhaltsmodell des Elements, dem es zugeordnet wird. Ist das Argument *namespace* angegeben, werden Verweise *element* oder *ref* im Definitionsskript, die nicht in einem Befehl *namespace* stehen, in diesem Namensraum aufgelöst. Gibt es für die Kombination aus Typname und Namensraum schon eine Elementtypdefinition, löst der Befehl einen Fehler aus. Das Dokumentelement eines zu prüfenden XML kann kein mit *defelementtype* definiertes Element sein.

**defpattern** *name* *?namespace?* *<definition script>*
: Diese Methode definiert einen, möglicherweise komplexen, Inhaltspartikel mit dem *name* im Schema, optional im Namensraum *namespace*, zur Verwendung in anderen Definitionsskripten mit dem Definitionsbefehl *ref*. Das *definition script* wird ausgewertet und definiert das Inhaltsmodell des Inhaltspartikels. Ist das Argument *namespace* angegeben, werden Verweise *element* oder *ref* im Definitionsskript, die nicht in einem Befehl *namespace* stehen, in diesem Namensraum aufgelöst. Gibt es für die Kombination aus Name und Namensraum schon eine Musterdefinition, löst der Befehl einen Fehler aus.

**deftexttype** *name* *<constraint script>*
: Diese Methode definiert ein Bündel von Texteinschränkungen, auf das sich bei Einschränkungen von Textelementen oder Attributwerten mit *name* verweisen lässt. Gibt es schon eine Texttypdefinition dieses Namens, löst der Befehl einen Fehler aus. Auf einen Texttyp darf verwiesen werden, bevor er im Schema definiert ist. Ist ein verwiesener Texttyp nirgends im Schema definiert, passt bei der Prüfung jeder Text auf diesen Typ.

**start** *documentElement* *?namespace?*
: Diese Methode definiert Name und Namensraum des Wurzelelements eines zu prüfenden Baums. Wird die Methode verwendet, muss das Wurzelelement für die Gültigkeit passen. Fehlt *start*, darf jedes mit *defelement* definierte Element die Wurzel eines gültigen Dokuments sein. Die Methode *start* darf während der Lebensdauer eines Prüfbefehls mehrmals mit wechselnden Argumenten verwendet werden. Wird der Befehl nur mit der leeren Zeichenkette und ohne Namensraum-Argument aufgerufen, entfällt die Prüfeinschränkung für das Wurzelelement, und jedes definierte Element ist als Wurzel eines zu prüfenden Baums gültig.

**define** *<definition script>*
: Diese Methode definiert mit einem Aufruf mehrere Elemente oder Muster oder ein ganzes Schema, indem sie das *definition script* auswertet. Alle bisherigen Methoden des Schemabefehls, *prefixns*, *defelement*, *defelementtype*, *defpattern*, *deftexttype* und *start*, sind auf der obersten Ebene des *definition script* erlaubt. Die Methode *define* selbst ist nicht rekursiv erlaubt.

**event** *(start|end|text)* *?event specific data?*
: Diese Methode prüft hierarchische Daten gegen die Inhaltseinschränkungen des Prüfbefehls.

    **start**  *name ?attributes? ?namespace?*
    : Prüft, ob der aktuelle Prüfzustand hier den Beginn des Elements *name* im *namespace* erlaubt. Sonst wird ein Fehler ausgelöst.

    **end**
    : Prüft, ob das aktuell innerste offene Element im aktuellen Zustand dort enden darf, ohne Prüfeinschränkungen zu verletzen. Sonst wird ein Fehler ausgelöst.

    **text**  *text*
    : Prüft, ob der aktuelle Prüfzustand den angegebenen Textinhalt erlaubt. Sonst wird ein Fehler ausgelöst.


**validate** ?*options***?** *<XML string>* *?objVar?*
: Gibt wahr zurück, wenn *<XML string>* gültig ist, sonst falsch. Ist die Prüfung fehlgeschlagen und das optionale Argument *objVar* angegeben, wird die Variable dieses Namens auf eine Prüffehler-Meldung gesetzt. Ist die XML-Zeichenkette gültig und das optionale Argument *objVar* angegeben, bleibt die Variable unberührt.

    Die gültigen Optionen sind:

    **-baseurl**  *<baseURI>*
    : Mit *-baseurl <baseURI>* ist die baseURI die Basis-URI des Dokuments. Verweise auf externe Entitäten im Dokument werden relativ zu dieser Basis-URI aufgelöst. Diese Basis-URI wird auch im DOM-Baum gespeichert.

    **-externalentitycommand**  *<script>*
    : Mit *-externalentitycommand <script>* wird das angegebene Tcl-Skript aufgerufen, um externe Entitäten des Dokuments aufzulösen. Die Vorgabe ist "::tdom::extRefHandler", ein einfacher Auflöser für Datei-URLs, definiert im Skriptteil des Pakets. Der leere Zeichenkettenwert schaltet das Auflösen externer Entitäten aus. Der tatsächlich ausgewertete Befehl besteht aus dieser Option und drei Argumenten: der Basis-URI, dem Systembezeichner der Entität und dem öffentlichen Bezeichner der Entität. Die Basis-URI und der öffentliche Bezeichner können die leere Liste sein. Das Skript gibt eine Tcl-Liste aus drei Elementen zurück. Das erste Element sagt, wie die externe Entität an den Prozessor zurückgegeben wird. Derzeit sind die Typen "string" und "channel" erlaubt. Das zweite Element muss die absolute Basis-URI der zu lesenden externen Entität sein. Das dritte Element sind die Daten: bei Typ "string" die bereits gelesenen Daten der externen Entität als Zeichenkette, bei Typ "channel" der Name eines Tcl-Kanals. Gibt das Skript einen Tcl-Kanal zurück, schließt der Prozessor ihn nicht. Er muss getrennt geschlossen werden, wenn er nicht mehr gebraucht wird.

    **-paramentityparsing**  *<always|never|notstandalone>*
    : Die Option *-paramentityparsing* steuert, ob der Parser beim Aufbau des DOM-Baums die externen Entitäten des Dokuments aufzulösen versucht, einschließlich der externen DTD-Teilmenge. *-paramentityparsing* braucht ein Argument, entweder "always", "never" oder "notstandalone". Der Wert "always" heißt: der Parser versucht, alle externen Entitäten der XML-Quelle aufzulösen, auch rekursiv. Das ist die Vorgabe, wenn *-paramentityparsing* fehlt. Der Wert "never" heißt: nur die angegebene XML-Quelle wird gelesen, keine externe Entität und nicht die externe Teilmenge wird aufgelöst und gelesen. Der Wert "notstandalone" heißt: alle externen Entitäten werden aufgelöst und gelesen, außer bei Dokumenten, die in der XML-Deklaration ausdrücklich standalone="yes" angeben.

    **-useForeignDTD**  *<boolean>*
    : Ist <boolean> wahr und hat das Dokument keine externe Teilmenge, ruft der Parser das Skript -externalentitycommand mit leeren Werten für die Argumente systemId und publicID auf. Hat das Dokument auch keine interne Teilmenge, werden die Skripte -startdoctypedeclcommand und -enddoctypedeclcommand, sofern gesetzt, nicht aufgerufen.


**validatefile** ?*options***?** *filename* *?objVar?*
: Gibt wahr zurück, wenn der Inhalt von *filename* gültig ist, sonst falsch. Die Datei geht als Binärstrom an expat. Deshalb arbeiten mit dieser Methode nur Daten in US-ASCII, ISO-8859-1, UTF-8 oder UTF-16. Ist die Prüfung fehlgeschlagen und das optionale Argument *objVar* angegeben, wird die Variable dieses Namens auf eine Prüffehler-Meldung gesetzt. Sind die XML-Daten gültig und das optionale Argument *objVar* angegeben, bleibt die Variable unberührt. Die erlaubten Optionen und ihre Bedeutung sind dieselben wie bei der Methode *validate*, die Beschreibung steht dort.

**validatechannel** ?*options***?** *channel* *?objVar?*
: Gibt wahr zurück, wenn der aus dem Tcl-Kanal *channel* gelesene Inhalt gültig ist, sonst falsch. Daten aus einem Tcl-Kanal sind UTF-8-kodiert. Eine irreführende Kodierungsdeklaration am Anfang der Daten führt deshalb zu Fehlern. Schlägt die Prüfung fehl und ist das optionale Argument *objVar* angegeben, wird die Variable dieses Namens auf eine Prüffehler-Meldung gesetzt. Sind die XML-Daten gültig und das optionale Argument *objVar* angegeben, bleibt die Variable unberührt. Die erlaubten Optionen und ihre Bedeutung sind dieselben wie bei der Methode *validate*, die Beschreibung steht dort.

**domvalidate** *domNode* *?objVar?*
: Gibt wahr zurück, wenn das erste Argument ein gültiger Baum ist, sonst falsch. Ist die Prüfung fehlgeschlagen und das optionale Argument *objVar* angegeben, wird die Variable dieses Namens auf eine Prüffehler-Meldung gesetzt. Ist der DOM-Baum gültig und das optionale Argument *objVar* angegeben, wird die Variable dieses Namens auf die leere Zeichenkette gesetzt.

**reportcmd** *?cmd?*
: Diese Methode erwartet den Namen eines Tcl-Befehls, der bei einem Prüffehler aufgerufen wird. Der Befehl wird mit zwei angehängten Argumenten aufgerufen: dem Schemabefehl, der den Prüffehler auslöst, und einem Prüffehlercode.

    Die möglichen Fehlercodes sind:

    - **MISSING\_ELEMENT**
    - **MISSING\_TEXT**
    - **UNEXPECTED\_ELEMENT**
    - **UNEXPECTED\_ROOT\_ELEMENT**
    - **UNEXPECTED\_TEXT**
    - **UNKNOWN\_ROOT\_ELEMENT**
    - **UNKNOWN\_ATTRIBUTE**
    - **MISSING\_ATTRIBUTE**
    - **INVALID\_ATTRIBUTE\_VALUE**
    - **DOM\_KEYCONSTRAINT**
    - **DOM\_XPATH\_BOOLEAN**
    - **INVALID\_KEYREF**
    - **INVALID\_VALUE**
    - **UNKNOWN\_GLOBAL\_ID**
    - **UNKNOWN\_ID**


    Genaueres steht im Abschnitt Wiederaufnahme.

**delete**
: Diese Methode löscht den Prüfbefehl.

**info** *?args?*
: Diese Methode bündelt Methoden, die den Zustand und Einzelheiten des Schemabefehls abfragen.

    **validationstate**
    : Diese Methode gibt den Zustand des Prüfbefehls hinsichtlich der Prüfung zurück. Die möglichen Rückgabewerte und ihre Bedeutung:

        READY
        : Der Prüfbefehl ist bereit, mit der Prüfung zu beginnen.

        VALIDATING
        : Der Prüfbefehl prüft gerade die Eingabe.

        FINISHED
        : Die Prüfung ist beendet, weitere Ereignisse werden nicht erwartet.


    **vstate**
    : Diese Methode ist ein kürzerer Alias für validationstate, siehe dort.

    **line**
    : Prüft der Schemabefehl gerade, gibt diese Methode den Zeilenanteil der Leseposition zurück, sonst die leere Zeichenkette. Prüft der Schemabefehl gerade einen DOM-Baum nach, kann an manchen oder allen Knoten keine Positionsangabe gespeichert sein. In diesen Fällen kommt die leere Zeichenkette zurück.

    **column**
    : Prüft der Schemabefehl gerade, gibt diese Methode den Spaltenanteil der Leseposition zurück, sonst die leere Zeichenkette. Prüft der Schemabefehl gerade einen DOM-Baum nach, kann an manchen oder allen Knoten keine Positionsangabe gespeichert sein. In diesen Fällen kommt die leere Zeichenkette zurück.

    **byteIndex**
    : Prüft der Schemabefehl gerade, gibt diese Methode die Byteposition der Leseposition zurück, sonst die leere Zeichenkette. Prüft der Schemabefehl gerade einen DOM-Baum nach, kann an manchen oder allen Knoten keine Positionsangabe gespeichert sein. In diesen Fällen kommt die leere Zeichenkette zurück.

    [domNode]
    : Prüft der Schemabefehl gerade keinen DOM-Baum nach, gibt diese Methode die leere Zeichenkette zurück. Wartet der Schemabefehl sonst, während er sich von einem Prüffehler erholt, auf das Ende des Skripts reportcmd, kommt der Knoten zurück, den die Prüfmaschine gerade ansieht, wenn der Knoten ein ELEMENT\_NODE ist, sonst sein Elternknoten. Von dieser Methode ist abzuraten. Wird sie doch verwendet, bleibt der DOM-Baum unangetastet und wird nur gelesen.

    **nrForwardDefinitions**
    : Gibt zurück, wie viele Elemente, Elementtypen und ref-Muster verwiesen sind, die noch nicht definiert sind, als Summe.

    **definedElements**
    : Gibt die definierten Elemente der Grammatik als Liste zurück, ohne bestimmte Reihenfolge. Hat ein Element einen Namensraum, ist sein Listeneintrag selbst eine Liste aus zwei Elementen, zuerst der Name, dann der Namensraum.

    **definedElementtypes**
    : Gibt die definierten Elementtypen der Grammatik als Liste zurück, ohne bestimmte Reihenfolge. Hat ein Elementtyp einen Namensraum, ist sein Listeneintrag selbst eine Liste aus zwei Elementen, zuerst der Name, dann der Namensraum.

    **definedPatterns**
    : Gibt die definierten benannten Muster der Grammatik als Liste zurück, ohne bestimmte Reihenfolge. Hat ein benanntes Muster einen Namensraum, ist sein Listeneintrag selbst eine Liste aus zwei Elementen, zuerst der Name, dann der Namensraum.

    **expected**
    : Gibt alle möglichen nächsten Ereignisse als Liste zurück, ohne bestimmte Reihenfolge, seit der letzten erfolgreichen Ereignisübereinstimmung, falls es eine gab. Hat ein Element einen Namensraum, ist sein Listeneintrag selbst eine Liste aus zwei Elementen, zuerst der Name, dann der Namensraum. Ist Text ein mögliches nächstes Ereignis, ist der Listeneintrag eine Liste aus zwei Elementen, zuerst #text und dann die leere Zeichenkette. Ist eine any-Element-Einschränkung möglich, ist der Listeneintrag eine Liste aus zwei Elementen, zuerst <any> und dann die leere Zeichenkette. Ist eine any-Element-Einschränkung in einem bestimmten Namensraum möglich, ist der Listeneintrag eine Liste aus zwei Elementen, zuerst <any> und dann der Namensraum. Ist das Elementende ein mögliches Ereignis, ist der Listeneintrag eine Liste aus zwei Elementen, zuerst <elementend> und dann die leere Zeichenkette.

    **definition name ?namespace?**
    : Gibt den Code zurück, der das angegebene Element definiert. Der Befehl löst einen Fehler aus, wenn es keine Definition dieses Elements gibt.

    **typedefinition name ?namespace?**
    : Gibt den Code zurück, der die angegebene Elementtypdefinition definiert. Der Befehl löst einen Fehler aus, wenn es keine Definition dieses Elements gibt.

    **patterndefinition name ?namespace?**
    : Gibt den Code zurück, der die angegebene Musterdefinition definiert. Der Befehl löst einen Fehler aus, wenn es keine Definition eines Musters mit diesem Namen und, falls angegeben, diesem Namensraum gibt.

    **vaction ?name|namespace|text?**
    : Diese Methode gibt nur dann nützliche Angaben zurück, wenn der Schemabefehl auf das Ende des Skripts reportcmd wartet, während er sich von einem Prüffehler erholt. Sonst gibt sie NONE zurück.

        Ohne das optionale Argument sind die möglichen Rückgabewerte und ihre Bedeutung:

        NONE
        : Der Schemabefehl erholt sich gerade nicht von einem Prüfereignis.

        MATCH\_ELEMENT\_START
        : Ereignis Elementanfang, einschließlich der Suche nach fehlenden oder unbekannten Attributen.

        MATCH\_ELEMENT\_END
        : Ereignis Elementende.

        MATCH\_TEXT
        : Prüfung von Text zwischen Tags.

        MATCH\_ATTRIBUTE\_TEXT
        : Prüfung der Werteinschränkung eines Attributtexts.

        MATCH\_GLOBAL
        : Prüfung globaler IDs.

        MATCH\_DOM\_KEYCONSTRAINT
        : Prüfung der Einschränkung domunique.

        MATCH\_DOM\_XPATH\_BOOLEAN
        : Prüfung der Konstante domxpathboolean.


        Mit einem der möglichen optionalen Argumente gibt der Befehl je nach aktueller Aktion Einzelheiten zurück.

        name
        : Gibt bei MATCH\_ELEMENT\_START den Namen des Elements zurück, das passen muss. Gibt bei MATCH\_ELEMENT\_END den Namen des geschlossenen Elements zurück. Gibt bei MATCH\_ATTRIBUTE\_TEXT den Namen des Attributs zurück. Gibt bei MATCH\_TEXT den Namen des Elternelements zurück.

        namespace
        : Gibt bei MATCH\_ELEMENT\_START den Namensraum des Elements zurück, das passen muss. Gibt bei MATCH\_ELEMENT\_END den Namensraum des geschlossenen Elements zurück. Gibt bei MATCH\_ATTRIBUTE\_TEXT den Namensraum des Attributs zurück. Gibt bei MATCH\_TEXT den Namensraum des Elternelements zurück.

        text
        : Gibt bei MATCH\_TEXT den Text zurück, der passen muss. Gibt bei MATCH\_ATTRIBUTE\_TEXT den Wert des Attributs zurück.


    **stack top|inside|associated**
    : In Tcl-Skripten, die die Prüfung auswertet, gibt diese Methode Angaben zum aktuellen Prüfstapel. Außerhalb dieses Zusammenhangs gibt die Methode die leere Zeichenkette zurück.

        **top**
        : Gibt das Element zurück, dessen Inhalt gerade geprüft wird, also das in diesem Augenblick offene Element-Tag.

        **inside**
        : Gibt alle gerade offenen Elemente als Liste zurück.

        **associated**
        : Gibt die Daten zurück, die dem aktuell obersten Inhaltspartikel des Stapels zugeordnet sind, oder die leere Zeichenkette, wenn es keine gibt.



**reset**
: Diese Methode setzt den Prüfbefehl in den Zustand READY zurück und behält die definierte Grammatik.


# Schema-Definitionsskripte

Schema-Definitionsskripte sind gewöhnliche Tcl-Skripte, die im Namensraum tdom::schema ausgewertet werden. Die unten aufgeführten Befehle der Schemadefinition in diesem Tcl-Namensraum erlauben die Definition sehr verschiedener Dokumentstrukturen. Jeder Befehl der Schemadefinition stellt eine Prüfeinschränkung an den Inhalt, der passen muss oder optional sein muss, damit der Inhalt als gültig gilt. Weiterer, nicht passender Inhalt ist ein Prüffehler. Nur aus Leerraum bestehender Text, im XML-Sinn von Leerraum, zwischen verschiedenen Tags wird übergangen, außer bei reinen Textelementen, bei denen auch nur aus Leerraum bestehender Text als bedeutsamer Inhalt gilt.

Die Befehle der Schemadefinition sind:

**element** *name* *?quant?* *(?<definition script>|"type" typename)?*
: Ist weder das optionale Argument *definition script* noch die Zeichenkette "type" und ein *typename* angegeben, verweist dieser Befehl auf das mit *defelement* definierte Element mit dem Namen *name* im aktuellen Kontextnamensraum.

    Sind die Zeichenkette "type" und ein *typename* angegeben, beschreibt das mit *defelementtype* definierte Inhaltsmodell mit dem Namen *typename* im aktuellen Kontextnamensraum den Inhalt des Elements.

    Ist das Argument *defelement script* angegeben, erwartet die Prüfeinschränkung ein Element mit dem Namen *name* im aktuellen Namensraum, dessen Inhalt das *definition script* örtlich definiert. Vorwärtsverweise auf noch nicht definierte Elemente oder Muster oder andere örtliche Definitionen desselben Namens innerhalb des *definition script* sind erlaubt. Ist ein vorwärts verwiesenes Element bis zur Prüfung nicht definiert, passt nur ein leeres Element mit dem Namen *name*, dem Namensraum *namespace* und ohne Attribute.

**ref** *name* *?quant?*
: Dieser Befehl verweist auf den mit *defpattern* definierten Inhaltspartikel mit dem Namen *name* im aktuellen Kontextnamensraum. Vorwärtsverweise auf ein noch nicht definiertes Muster und rekursive Verweise sind erlaubt. Ist ein vorwärts verwiesenes Muster bis zur Prüfung nicht definiert, wird keinerlei Inhalt erwartet, ein leerer Treffer.

**group** *?quant?* *<definition script>*
: Diese Methode gruppiert eine Folge von Inhaltspartikeln, die das *definition script* definiert und die in dieser Reihenfolge passen müssen.

**choice** *?quant?* *<definition script>*
: Diese Schemaeinschränkung passt, wenn einer der obersten Inhaltspartikel passt, die das *definition script* definiert. Ist einer dieser obersten Inhaltspartikel optional, passt diese Einschränkung auf den leeren Treffer.

**interleave** *?quant?* *<definition script>*
: Diese Schemaeinschränkung passt, nachdem jeder der erforderlichen obersten Inhaltspartikel, die das *definition script* definiert, gepasst hat, und optional einige oder alle übrigen, in beliebiger Reihenfolge.

**mixed** *?quant?* *<definition script>*
: Diese Schemaeinschränkung passt auf jeden Text, auch den leeren, und auf jeden obersten Inhaltspartikel, den das *definition script* definiert, mit dem Vorgabequantor \*.

**text** *?<constraint script>|"type" typename?*
: Ohne das optionale Einschränkungsskript passt diese Prüfeinschränkung auf jede Zeichenkette, auch die leere. Mit *constraint script* oder mit einem angegebenen Texttyp-Argument wird ein Text erwartet, der auf dieses Skript oder den Texttyp passt.

**any** ?*options***?** *?<namespace list>?* *?quant?*
: Ohne Argumente passt der Befehl any auf jedes Element. Ist das Argument *<namespace list>* angegeben, passt dies auf jedes Element in einem Namensraum aus dieser Liste. Die leere Zeichenkette meint Elemente ohne Namensraum. Ist zusätzlich die Option *-not* angegeben, passt dies auf jedes Element mit einem Namensraum, der nicht in der Liste steht. Die einzige weitere erkannte Option ist *--*, sie markiert das Ende aller Optionen. Fehlt das Argument *namespace*, verbrauchen die Quantoren \* und + alle Elemente, bis das umschließende Element endet. Sieht ein Namensraum wie ein gültiger tDOM-Schema-Quantor aus, müssen immer beide Argumente ausgeschrieben werden.

**attribute** *name* *?quant?* *(?<constraint script>|"type" typename?)*
: Der Befehl attribute definiert ein Attribut ohne Namensraum am umschließenden Element. Die erste Definition von *name* innerhalb einer Elementdefinition gilt, spätere Definitionen desselben Namens werden still übergangen. Nach dem Argument *name* kann einer der Quantoren ? oder ! stehen. Steht er dort, wird er verwendet. Sonst ist das Attribut erforderlich und muss in der XML-Quelle vorhanden sein. Gibt es ein Argument mehr, wird dieses Argument als Einschränkungsskript ausgewertet und definiert die Werteinschränkungen des Attributs. Gibt es sonst zwei Argumente mehr und ist das erste das bloße Wort "type", wird das folgende Argument als Name eines Texttyps verwendet. Dieser Befehl ist nur auf der obersten Ebene im Definitionsskript eines defelement- oder element-Skripts erlaubt.

**nsattribute** *name* *namespace* *?quant?* *(?<constraint script>|"type" typename?)*
: Dieser Befehl tut dasselbe wie der Befehl *attribute*, für das Attribut *name* im Namensraum *namespace*.

**namespace** *URI* *<definition script>*
: Wertet das *definition script* mit dem Kontextnamensraum *URI* aus. Jeder Name eines Befehls element, eines Elementtyps oder von ref wird im Namensraum *URI* nachgeschlagen, und örtlich definierte Elemente liegen in diesem Namensraum. Die leere Zeichenkette als *URI* meint keinen Namensraum.

**tcl** *tclcmd* *?arg arg ...?*
: Wertet das Tcl-Skript *tclcmd arg arg ...* aus. Dieser Prüfbefehl ist nur in streng sequenziellem Zusammenhang erlaubt, nicht in choice, mixed und interleave. Ist der Rückgabecode etwas anderes als TCL\_OK, ist das ein Fehler, den reportcmd nicht abfängt und nicht meldet.

**self**
: Gibt den Schemabefehl zurück.

**associate** *data*
: Dieser Befehl ist nur auf der obersten Ebene innerhalb von Definitionsskripten der Inhaltspartikel element, elementtype, pattern oder interleave erlaubt. Er ordnet die als Argument angegebenen *data* dem gerade definierten Inhaltspartikel zu. In Skripten, die beim Prüfen des Inhalts dieses Partikels ausgewertet werden, lassen sie sich mit dem Methodenaufruf *info stack associated* des Schemabefehls abfragen.

**domunique** *selector* *fieldlist* *?name?* *?"IGNORE\_EMPTY\_FIELD\_SET"|("EMPTY\_FIELD\_SET\_VALUE" emptyFieldSetValue)?*
: Wird ein DOM-Baum nicht mit *domvalidate* nachträglich geprüft, passt diese Einschränkung immer. Beim Nachprüfen entspricht sie dem Mechanismus xsd key/keyref. Das Argument *selector* darf jeder gültige XPath-Ausdruck sein, ohne die Grenzen von xsd. Mehrere Befehle *domunique* innerhalb einer Elementdefinition sind erlaubt und werden in der Definitionsreihenfolge geprüft. Der Argumentname steht im Wiederaufnahme-Skript über *info vaction name* zur Verfügung. Wählt die *fieldlist* für einen Knoten der Ergebnismenge des *selector* nichts aus, ist der Schlüsselwert in der Vorgabe die leere Zeichenkette. Sind die Argumente *EMPTY\_FIELD\_SET\_VALUE <value>* angegeben, hat eine leere Knotenmenge den Schlüsselwert *value*. Ist stattdessen die Markierung *IGNORE\_EMPTY\_FIELD\_SET* angegeben, hat das Ergebnis einer leeren Knotenmenge keinen Schlüsselwert.

**domxpathboolean** *XPath\_expr* *?name?*
: Wird ein DOM-Baum nicht mit *domvalidate* nachträglich geprüft, passt diese Einschränkung immer. Beim Nachprüfen wird das Argument *XPath\_expr* ausgewertet, mit dem Knoten als Kontextknoten, der zum Schema-Elternteil des Befehls *domxpathboolean* passt. Die Einschränkung passt, wenn das Ergebnis dieses XPath-Ausdrucks nach den XPath-Regeln in einen booleschen Wert umgewandelt wahr ist. Mehrere Befehle *domxpathboolean* innerhalb einer Elementdefinition sind erlaubt und werden in der Definitionsreihenfolge geprüft.

    Das ermöglicht Prüfungen, die von mehr als einem Element abhängen. Beispiel:

    ```
    tdom::schema s
    s define {
        defelement doc {
            element a ! text
            element b ! text
            element c ! text
            domxpathboolean "a * b * c >= 20000" volume
            domxpathboolean "a > b and b > c" sequence
        }
    }
    ```

**jsontype** *JSON structure type*
: Wird ein DOM-Baum nicht mit *domvalidate* nachträglich geprüft, passt diese Einschränkung immer. Beim Nachprüfen passt die Einschränkung, wenn das umschließende Element den JSON-Typ hat, der der Struktureinschränkung als Argument angegeben ist. Die möglichen JSON-Strukturtypen sind *NONE*, *OBJECT* und *ARRAY*. Diese Einschränkung ist nur als direktes Kind einer defelement-, defelementtype- oder örtlichen Elementdefinition erlaubt.

**prefixns**         *?prefixUriList?*
: Dies definiert eine Zuordnung von Präfix zum Namensraum-URI genau so, wie es *schemacmd prefixns* täte. Gedacht ist es als Befehl der obersten Ebene eines Skripts *schemacmd define*. Dieser Befehl darf nicht in einem anderen Befehl eines Definitionsskripts verschachtelt sein und löst einen Fehler aus, wenn der Aufruf dort steht.

**defelement** *name* *?namespace?* *<definition script>*
: Dies definiert ein Element genau so, wie es ein Aufruf *schemacmd defelement* täte. Gedacht ist es als Befehl der obersten Ebene eines Skripts *schemacmd define*. Dieser Befehl darf nicht in einem anderen Befehl eines Definitionsskripts verschachtelt sein und löst einen Fehler aus, wenn der Aufruf dort steht.

**defelementtype** *typename* *?namespace?* *<definition script>*
: Dies definiert einen Elementtyp genau so, wie es ein Aufruf *schemacmd defelementtype* täte. Gedacht ist es als Befehl der obersten Ebene eines Skripts *schemacmd define*. Dieser Befehl darf nicht in einem anderen Befehl eines Definitionsskripts verschachtelt sein und löst einen Fehler aus, wenn der Aufruf dort steht.

**defpattern** *name* *?namespace?* *<definition script>*
: Dies definiert ein benanntes Muster genau so, wie es ein Aufruf *schemacmd defpattern* täte. Gedacht ist es als Befehl der obersten Ebene eines Skripts *schemacmd define*. Dieser Befehl darf nicht in einem anderen Befehl eines Definitionsskripts verschachtelt sein und löst einen Fehler aus, wenn der Aufruf dort steht.

**deftexttype** *name* *<constraint script>*
: Dies definiert ein benanntes Bündel von Texteinschränkungen genau so, wie es ein Aufruf *schemacmd deftexttype* täte. Gedacht ist es als Befehl der obersten Ebene eines Skripts *schemacmd define*. Dieser Befehl darf nicht in einem anderen Befehl eines Definitionsskripts verschachtelt sein und löst einen Fehler aus, wenn der Aufruf dort steht.

**start** *name* *?namespace?*
: Dieser Befehl arbeitet genau so, wie es ein Aufruf *schemacmd start* täte. Gedacht ist er als Befehl der obersten Ebene eines Skripts *schemacmd define*. Dieser Befehl darf nicht in einem anderen Befehl eines Definitionsskripts verschachtelt sein und löst einen Fehler aus, wenn der Aufruf dort steht.


# Quantor

Mehrere Befehle der Schemadefinition erwarten einen Quantor als eines ihrer Argumente. Er bestimmt, wie oft der vom Befehl angegebene Inhaltspartikel erwartet wird. Die gültigen Werte für ein Argument *quant* sind:

**!**
: Der Inhaltspartikel muss in gültigen Dokumenten genau einmal vorkommen.

**?**
: Der Inhaltspartikel darf in gültigen Dokumenten nicht öfter als einmal vorkommen, der Partikel ist optional.

**\***
: Der Inhaltspartikel darf in gültigen Dokumenten nullmal oder öfter hintereinander vorkommen.

**+**
: Der Inhaltspartikel darf in gültigen Dokumenten einmal oder öfter hintereinander vorkommen.

**n**
: Der Inhaltspartikel muss in gültigen Dokumenten n-mal hintereinander vorkommen. Der Quantor muss eine ganze Zahl größer als null sein.

**{n m}**
: Der Inhaltspartikel muss in gültigen Dokumenten mindestens n-mal und höchstens m-mal hintereinander vorkommen. Der Quantor muss eine Tcl-Liste mit zwei Elementen sein. Das erste Element dieser Liste muss eine ganze Zahl mit n >= 0 sein. Ist das zweite Listenelement das Zeichen \*, gibt es keine obere Grenze. Sonst muss das zweite Listenelement eine ganze Zahl mit n < m sein.


Fehlt ein optionaler Quantor, ist die Vorgabe \* beim Befehl *mixed* und ! bei allen anderen Befehlen.

# Text-Einschränkungsskripte

Text, von XML parsed character data genannt, muss manchmal von einer bestimmten Art sein oder bestimmten Regeln folgen, um gültig zu sein. Die Argumente des Texteinschränkungsskripts der Befehle text, attribute, nsattribute und deftexttype werden im Tcl-Namensraum *tdom::schema::text* ausgewertet und erlauben den folgenden Befehlen der Texteinschränkung, Text auf bestimmte Eigenschaften zu prüfen. Die Befehle sind im Tcl-Namensraum *tdom::schema::text* definiert. Ein Aufruf außerhalb eines Texteinschränkungsskripts löst einen Fehler aus.

Einige der folgenden Texttyp-Befehle stehen als allgemeine Tcl-Befehle zur Verfügung. Definiert sind sie im Namensraum tdom::type und werden wie unten beschrieben aufgerufen, mit dem zu prüfenden Text an die Argumentliste angehängt. Der Rückgabewert ist logisch. Die Befehle müssen führenden oder abschließenden Leerraum nicht annehmen. Ob ein Befehl im Namensraum tdom::type zur Verfügung steht, steht in seiner Beschreibung.

## Der Tcl-Text-Einschränkungsbefehl

Der Texteinschränkungsbefehl *tcl* gibt die Prüfung an einen beliebigen Tcl-Befehl weiter und ermöglicht so beliebige programmierbare Entscheidungsregeln.

**tcl** *tclcmd* *?arg arg ...?*
: Wertet das Tcl-Skript *tclcmd arg arg ...* aus, mit dem zu prüfenden Text an die Argumentliste angehängt. Der Rückgabewert des Tcl-Befehls wird als boolescher Wert gelesen.


## Grundlegende XML-Typen

**name**
: <URL: https://www.w3.org/TR/xml/#NT-Name> ["https://www.w3.org/TR/xml/#NT-Name"]("https://www.w3.org/TR/xml/#NT-Name") Diese Texteinschränkung passt, wenn der Textwert auf die XML-Produktion name passt . Der Textwert muss also mit einem Buchstaben, einem Unterstrich (\_) oder einem Doppelpunkt (:) beginnen und darf nur Buchstaben, Ziffern, Unterstriche (\_), Doppelpunkte (:), Bindestriche (-) und Punkte (.) enthalten.

**ncname**
: <URL: https://www.w3.org/TR/xml-names/#NT-NCName> ["https://www.w3.org/TR/xml-names/#NT-NCName"]("https://www.w3.org/TR/xml-names/#NT-NCName") Diese Texteinschränkung passt, wenn der Textwert auf die XML-Produktion ncname passt . Der Textwert muss also mit einem Buchstaben oder einem Unterstrich (\_) beginnen und darf nur Buchstaben, Ziffern, Unterstriche (\_), Bindestriche (-) und Punkte (.) enthalten. Der einzige Unterschied zur Einschränkung name ist, dass Doppelpunkte nicht erlaubt sind.

**qname**
: <URL: https://www.w3.org/TR/xml-names/#NT-QName> ["https://www.w3.org/TR/xml-names/#NT-QName"]("https://www.w3.org/TR/xml-names/#NT-QName") Diese Texteinschränkung passt, wenn der Textwert auf die XML-Produktion qname passt . Der Textwert ist also entweder ein ncname oder zwei durch einen Doppelpunkt (:) verbundene ncnames.

**nmtoken**
: <URL: https://www.w3.org/TR/xml/#NT-Nmtoken> ["https://www.w3.org/TR/xml/#NT-Nmtoken"]("https://www.w3.org/TR/xml/#NT-Nmtoken") Diese Texteinschränkung passt, wenn der Textwert auf die XML-Produktion nmtoken passt

**nmtokens**
: <URL: https://www.w3.org/TR/xml/#NT-Nmtokens> ["https://www.w3.org/TR/xml/#NT-Nmtokens"]("https://www.w3.org/TR/xml/#NT-Nmtokens") Diese Texteinschränkung passt, wenn der Textwert auf die XML-Produktion nmtokens passt


## Grundlegende Typtests

**integer** *?(xsd|tcl)?*
: Diese Texteinschränkung passt, wenn der Textwert als ganze Zahl gelesen werden könnte. Ist das optionale Argument des Befehls *tcl*, passt alles, was TCL\_OK zurückgibt, wenn es an Tcl\_GetInt() geht. Ist das optionale Argument des Befehls *xsd*, passt die Einschränkung, wenn der Wert ein gültiges xsd:integer ist. Ohne Argument ist *xsd* die Vorgabe.

**negativeInteger** *?(xsd|tcl)?*
: Diese Texteinschränkung passt auf dieselben Textwerte wie die Texteinschränkung *integer*, siehe dort, mit der zusätzlichen Einschränkung, dass der Wert < null sein muss.

**nonNegativeInteger** *?(xsd|tcl)?*
: Diese Texteinschränkung passt auf dieselben Textwerte wie die Texteinschränkung *integer*, siehe dort, mit der zusätzlichen Einschränkung, dass der Wert >= null sein muss.

**nonPositiveInteger** *?(xsd|tcl)?*
: Diese Texteinschränkung passt auf dieselben Textwerte wie die Texteinschränkung *integer*, siehe dort, mit der zusätzlichen Einschränkung, dass der Wert <= null sein muss.

**positiveInteger** *?(xsd|tcl)?*
: Diese Texteinschränkung passt auf dieselben Textwerte wie die Texteinschränkung *integer*, siehe dort, mit der zusätzlichen Einschränkung, dass der Wert > null sein muss.

**number** *?(xsd|tcl)?*
: Diese Texteinschränkung passt, wenn der Textwert als Zahl gelesen werden könnte. Ist das optionale Argument des Befehls *tcl*, passt alles, was TCL\_OK zurückgibt, wenn es an Tcl\_GetDouble() geht. Ist das optionale Argument des Befehls *xsd*, passt die Einschränkung, wenn der Wert ein gültiges xsd:decimal ist. Ohne Argument ist *xsd* die Vorgabe.

**boolean** *?(xsd|tcl)?*
: Diese Texteinschränkung passt, wenn der Textwert als boolescher Wert gelesen werden könnte. Ist das optionale Argument des Befehls *tcl*, passt alles, was TCL\_OK zurückgibt, wenn es an Tcl\_GetBoolean() geht. Ist das optionale Argument des Befehls *xsd*, passt die Einschränkung, wenn der Wert ein gültiges xsd:boolean ist. Ohne Argument ist *xsd* die Vorgabe.

**date**
: Diese Texteinschränkung passt, wenn der Textwert ein xsd:date ist, im Wesentlichen ein ISO-8601-Datum der Form YYYY-MM-DD, mit optionalem Zeitzonenanteil, entweder dem Buchstaben Z oder Plus (+) oder Minus (-), gefolgt von hh:mm, und mit der höchsten erlaubten positiven oder negativen Zeitzone 14:00. Für alle Daten gelten die Datumsregeln des gregorianischen Kalenders. Ein vorangestelltes Minuszeichen für Daten v. Chr. ist erlaubt. Ein Jahr 0 gibt es nicht. Das Jahr darf mehr als 4 Stellen haben, aber nur wenn nötig, ohne zusätzliche führende Nullen. Verfügbar als allgemeiner Tcl-Befehl tdom::type::date.

**time**
: Diese Texteinschränkung passt, wenn der Textwert ein xsd:time ist, im Wesentlichen eine ISO-8601-Uhrzeit der Form hh:mm:ss mit optionalem Zeitzonenanteil. Der Zeitzonenanteil folgt den Regeln des Befehls *date*, siehe dort. Alle drei Teile des Zeitwerts, Stunden, Minuten und Sekunden, müssen mit 2 Stellen ausgeschrieben sein. Zusätzliche Sekundenbruchteile mit einem Punkt ('.') als Trenner sind erlaubt, nicht aber ein alleinstehender Punkt. Der Zeitwert 24:00:00 ohne Bruchteil ist erlaubt. Verfügbar als allgemeiner Tcl-Befehl tdom::type::time.

**dateTime**
: Diese Texteinschränkung passt, wenn der Textwert ein xsd:dateTime ist, im Wesentlichen eine ISO-8601-Datumszeit der Form YYYY-MM-DDThh:mm:ss mit optionalem Zeitzonenanteil. Die Anteile Datum und Zeitzone folgen den Regeln der Befehle *date* und *time*, siehe dort. Der Zeitanteil einschließlich des kennzeichnenden Zeichens 'T' ist erforderlich. Verfügbar als allgemeiner Tcl-Befehl tdom::type::dateTime.

**duration**
: Diese Texteinschränkung passt, wenn der Textwert eine xsd:duration ist, im Wesentlichen eine ISO-8601-Dauer der Form PnYnMnDTnHnMnS. Alle Teile außer dem beginnenden P und, wenn eines von H, M oder S angegeben ist, T sind optional. Ist der folgende Kennbuchstabe S, darf n eine Dezimalzahl sein, mit mindestens einer Ziffer vor und nach dem Punkt, sonst muss es eine positive ganze Zahl sein. Verfügbar als allgemeiner Tcl-Befehl tdom::type::duration.

**base64**
: Diese Texteinschränkung passt, wenn der Text nach RFC 4648 gültig ist. Verfügbar als allgemeiner Tcl-Befehl tdom::type::base64.

**hexBinary**
: Diese Texteinschränkung passt, wenn der Text eine Folge binärer Oktette in hexadezimaler Kodierung ist, wobei jedes binäre Oktett eine zweistellige Hexadezimalzahl ist. Klein- und Großbuchstaben A bis F sind erlaubt.

**unsignedByte**
: Diese Texteinschränkung passt, wenn der Textwert ein xsd:unsignedByte ist. Das ist eine ganze Zahl zwischen 0 und 255, beide eingeschlossen, optional mit vorangestelltem Pluszeichen und führenden Nullen.

**unsignedShort**
: Diese Texteinschränkung passt, wenn der Textwert ein xsd:unsignedShort ist. Das ist eine ganze Zahl zwischen 0 und 65535, beide eingeschlossen, optional mit vorangestelltem Pluszeichen und führenden Nullen.

**unsignedInt**
: Diese Texteinschränkung passt, wenn der Textwert ein xsd:unsignedInt ist. Das ist eine ganze Zahl zwischen 0 und 4294967295, beide eingeschlossen, optional mit vorangestelltem Pluszeichen und führenden Nullen.

**unsignedLong**
: Diese Texteinschränkung passt, wenn der Textwert ein xsd:unsignedLong ist. Das ist eine ganze Zahl zwischen 0 und 18446744073709551615, beide eingeschlossen, optional mit vorangestelltem Pluszeichen und führenden Nullen.

**byte**
: Diese Texteinschränkung passt, wenn der Textwert ein xsd:byte ist. Das ist eine ganze Zahl zwischen -128 und 127, beide eingeschlossen, optional mit vorangestelltem Plus- oder Minuszeichen und führenden Nullen.

**short**
: Diese Texteinschränkung passt, wenn der Textwert ein xsd:short ist. Das ist eine ganze Zahl zwischen -32768 und 32767, beide eingeschlossen, optional mit vorangestelltem Plus- oder Minuszeichen und führenden Nullen.

**int**
: Diese Texteinschränkung passt, wenn der Textwert ein xsd:int ist. Das ist eine ganze Zahl zwischen -2147483648 und 2147483647, beide eingeschlossen, optional mit vorangestelltem Plus- oder Minuszeichen und führenden Nullen.

**long**
: Diese Texteinschränkung passt, wenn der Textwert ein xsd:long ist. Das ist eine ganze Zahl zwischen -9223372036854775808 und 9223372036854775807, beide eingeschlossen, optional mit vorangestelltem Plus- oder Minuszeichen und führenden Nullen.


## Logische Verknüpfungen

**oneOf** *<constraint script>*
: Diese Texteinschränkung passt, wenn eine der im Argument *constraint script* definierten Texteinschränkungen auf den Text passt. Die Prüfung hält nach der ersten Übereinstimmung an und prüft die Texteinschränkungen in der Definitionsreihenfolge.

**allOf** *<constraint script>*
: Diese Texteinschränkung passt, wenn alle im Argument *constraint script* definierten Texteinschränkungen auf den Text passen. Die Prüfung hält nach dem ersten Fehlschlag an und prüft die Texteinschränkungen in der Definitionsreihenfolge. Da auch der Schemadefinitionsbefehl *text* erwartet, dass alle Texteinschränkungen auf die Texteinschränkung passen, ist *allOf* vor allem zusammen mit dem Texteinschränkungsbefehl *oneOf* nützlich.

**not** *<constraint script>*
: Diese Texteinschränkung passt, wenn keine der im Argument *constraint script* definierten Texteinschränkungen auf den Text passt. Die Prüfung hält nach der ersten passenden Einschränkung im *constraint script* an und meldet einen Prüffehler. Die Texteinschränkungen im *constraint script* werden in der Definitionsreihenfolge geprüft.

**type** *text type name*
: Diese Texteinschränkung passt, wenn der als Argument angegebene Texttyp passt.


## Einschränkungen des verarbeiteten Textwerts

**whitespace** *(preserve|replace|collapse)* *<constraint script>*
: Dieser Texteinschränkungsbefehl normalisiert den Leerraum des Textwerts, #x20 (Leerzeichen, ' '), #x9 (Tabulator, \\t), #xA (Zeilenvorschub, \\n) und #xD (Wagenrücklauf, \\r), und prüft den entstandenen Text mit den Texteinschränkungen des Arguments des Einschränkungsskripts. Die Normalisierungsmethode *preserve* lässt alles, wie es ist; das ist eine andere Art, *allOf* zu sagen. Die Normalisierungsmethode *replace* ersetzt jedes einzelne Leerraumzeichen, wie oben, durch ein Leerzeichen. Die Normalisierungsmethode *collapse* entfernt allen führenden und abschließenden Leerraum, und alle übrigen Folgen zusammenhängenden Leerraums werden durch ein einzelnes Leerzeichen ersetzt.

**split** *?type ?args??<constraint script>*
: Dieser Texteinschränkungsbefehl zerlegt den zu prüfenden Text in eine Liste von Werten und prüft alle Elemente dieser Liste auf die Texteinschränkungen im ausgewerteten *constraint script*.

    Die verfügbaren Typen sind:

    whitespace
    : Der zu zerlegende Text wird am Anfang und am Ende von allem Leerraum befreit und an jedem aufeinanderfolgenden Leerraum in eine Liste zerlegt.

    tcl tclcmd ?arg ...?
    : Der zu zerlegende Text geht an *tclcmd*, das auf globaler Ebene ausgewertet wird, mit jedem angegebenen arg angehängt und dem zu zerlegenden Text als letztem Argument. Dieser Aufruf muss eine gültige Tcl-Liste zurückgeben, deren Elemente geprüft werden.


    Fehlt das Argument des Zerlegungstyps, ist die Vorgabe *whitespace*.

**strip** *<constraint script>*
: Dieser Texteinschränkungsbefehl prüft alle Texteinschränkungen im ausgewerteten *constraint script* mit dem zu prüfenden Text, befreit von allem Leerraum am Anfang und am Ende.


## Weitere Zeichenketteneigenschaften

**fixed** *value*
: Die Texteinschränkung passt nur, wenn der Textwert zeichengleich mit dem angegebenen Wert ist.

**enumeration** *list*
: Diese Texteinschränkung passt, wenn der Textwert einem Element des Arguments *list* gleicht, unter Beachtung von Groß- und Kleinschreibung und jedem Leerraum. *list* muss eine gültige Tcl-Liste sein.

**match** *?-nocase?* *glob\_style\_match\_pattern>*
: <URL: https://www.tcl.tk/man/tcl8.6/TclCmd/string.htm#M35> ["https://www.tcl.tk/man/tcl8.6/TclCmd/string.htm#M35"]("https://www.tcl.tk/man/tcl8.6/TclCmd/string.htm#M35") Diese Texteinschränkung passt, wenn der Textwert auf das als Argument angegebene Glob-Muster passt. Es gelten die Regeln des Tcl-Befehls \[string match\], siehe .

**regexp** *expression*
: <URL: https://www.tcl.tk/man/tcl8.6/TclCmd/re_syntax.htm> ["https://www.tcl.tk/man/tcl8.6/TclCmd/re_syntax.htm"]("https://www.tcl.tk/man/tcl8.6/TclCmd/re_syntax.htm") Diese Texteinschränkung passt, wenn der Textwert auf den als Argument angegebenen regulären Ausdruck passt.  beschreibt die Syntax des regulären Ausdrucks

**length** *length*
: Diese Texteinschränkung passt, wenn die Länge des Textwerts, in Zeichen und nicht in Bytes, *length* ist. Das Argument length muss eine positive ganze Zahl oder null sein.

**maxLength** *length*
: Diese Texteinschränkung passt, wenn die Länge des Textwerts, in Zeichen und nicht in Bytes, höchstens *length* ist. Das Argument length muss eine ganze Zahl größer als null sein.

**minLength** *length*
: Diese Texteinschränkung passt, wenn die Länge des Textwerts, in Zeichen und nicht in Bytes, mindestens *length* ist. Das Argument length muss eine ganze Zahl größer als null sein.

**id** *?keySpace?*
: Dieser Texteinschränkungsbefehl markiert den Text als dokumentweite ID, auf die ein idref verweisen kann. Jeder ID-Wert innerhalb eines Dokuments muss eindeutig sein. Es ist kein Fehler, wenn auf die ID im Dokument tatsächlich nicht verwiesen wird. Das optionale Argument *keySpace* tut all das für einen benannten Schlüsselraum. Der Schlüsselraum "" (die leere Zeichenkette) ist ein anderer Schlüsselraum als der Befehl *id* ohne Argument keySpace.

**idref** *?keySpace?*
: Dieser Texteinschränkungsbefehl erwartet, dass der Text ein Verweis auf eine ID innerhalb des Dokuments ist. Die verwiesene ID darf im Dokument später stehen als der Verweis. Mehrere Verweise innerhalb des Dokuments auf eine ID sind möglich. Zum optionalen Argument *keySpace* siehe *id*.

**jsontype** *<JSON text type>*
: Wird ein DOM-Baum nicht mit *domvalidate* nachträglich geprüft, passt diese Einschränkung immer. Beim Nachprüfen muss der zu prüfende TEXT\_NODE den JSON-Texttyp haben, der dem Texteinschränkungsbefehl als Argument angegeben ist. Die möglichen Typen sind *NULL*, *TRUE*, *FALSE*, *STRING* und *NUMBER*.


# Lokale Schlüsseleinschränkungen

Dokumentweite Eindeutigkeit und Fremdschlüssel-Einschränkungen stehen mit den Texteinschränkungsbefehlen id und idref zur Verfügung. Schlüsselräume erlauben eindeutige Werte und Fremdschlüssel-Einschränkungen, die auf einen Teilbaum beschränkt sind.

**keyspace** *<names list>* *<constraint script>*
: Beliebig viele Schlüsselräume sind möglich. Ein Schlüsselraum ist entweder aktiv oder nicht. Ein innerhalb eines *constraint script* aufgerufener keyspace mit demselben Namen tut nichts.


Diese Texteinschränkungsbefehle arbeiten mit Schlüsselräumen:

**key** *<name>*
: Ist der Schlüsselraum mit dem Namen *<name>* nicht aktiv, passt die Einschränkung immer. Ist der Schlüsselraum aktiv, wird ein Fehler gemeldet, wenn es schon einen Schlüssel mit dem Wert gibt. Sonst speichert sie den Wert als Schlüssel in diesem Schlüsselraum und passt.

**keyref** *<name>*
: Ist der Schlüsselraum mit dem Namen *<name>* nicht aktiv, passt sie immer. Ist der Schlüsselraum aktiv, wird ein Fehler gemeldet, wenn es am Ende des Schlüsselraums *<name>* noch keinen Schlüssel mit dem Wert gibt. Sonst passt sie.


# Wiederaufnahme

In der Vorgabe hält die Prüfmaschine bei der ersten erkannten Prüfverletzung an und meldet diesen Befund. Wird der Schemabefehl selbst zur Prüfung der Eingabe verwendet, gibt sie dazu falsch zurück und setzt, falls angegeben, die Ergebnisvariable auf eine Fehlermeldung. Verwendet ein SAX-Parser oder der DOM-Parser den Schemabefehl, löst sie dazu einen Fehler aus.

Ist ein *reportcmd* gesetzt, wird dieser Befehl auf globaler Ebene aufgerufen, mit dem Schemabefehl und einem Fehlertyp als angehängten Argumenten, sobald eine Prüfverletzung erkannt wird. Danach erholt sich die Prüfung vom Fehler und läuft weiter. Bei manchen Prüffehlern lässt sich die Strategie der Wiederaufnahme mit dem Skriptergebnis von reportcmd bestimmen.

Mit einem *reportcmd*, solange der *reportcmd* beim Aufruf keinen Fehler auslöst, meldet die Prüfmaschine ihrem Aufrufer nie einen Prüffehlschlag. Die Prüfmaschine erholt sich, läuft weiter und meldet den nächsten Fehler, falls einer auftritt, und so weiter bis zum Ende der Eingabe. Der Schemabefehl gibt wahr zurück, und der SAX-Parser und der DOM-Aufbau arbeiten bis zum Ende der Eingabe normal, als hätte es keinen Prüffehler gegeben.

Das gilt nur für Prüffehler. Von Wohlgeformtheitsfehlern lässt sich nicht erholen. Ist die Eingabe nicht wohlgeformt, gibt der Schemabefehl falsch zurück und setzt, falls angegeben, die Ergebnisvariable auf eine Fehlermeldung über den Wohlgeformtheitsfehler.

Löst der *reportcmd* beim Aufruf durch die Prüfmaschine einen Fehler aus, hält die Prüfung an, und der Schemabefehl löst einen Fehler mit der Fehlermeldung des Skripts aus.

Beim Prüfen können im Wesentlichen drei Ereignisse eintreten: ein Element-Start-Tag muss passen, ein Textstück muss passen oder ein Element-Ende-Tag muss passen. Die Methode *info vaction*, aufgerufen im Wiederaufnahme-Skript oder in jedem von dort aufgerufenen Skriptcode, gibt zurück, welches Ereignis die Fehlermeldung ausgelöst hat, der Reihe nach MATCH\_ELEMENT\_START, MATCH\_TEXT, MATCH\_ELEMENT\_END. Während der Befehl das Schema durchläuft und prüft, ob das Ereignis passt, können andere, datengetriebene Ereignisse eintreten, zum Beispiel die Prüfung, ob ein keyref innerhalb eines Schlüsselraums vorhanden ist.

Mehrere der Prüffehlercodes, die den Aufrufen von *reportcmd* als zweites Argument angehängt werden, können bei mehr als einer Art von Prüfereignis auftreten. Die Methode *info vaction* und ihre Unterbefehle geben Angaben zum aktuellen Prüfereignis, wenn sie aus dem Meldebefehl aufgerufen werden.

Tritt ein struktureller Prüffehler auf, ist die Vorgabe der Wiederaufnahme, jeden folgenden oder fehlenden Inhalt innerhalb des aktuellen Teilbaums zu übergehen und mit dem Ereignis Elementende des Teilbaums weiterzumachen.

Die Rückgabe "ignore" aus dem Wiederaufnahme-Skript beim Fehlertyp MISSING\_ELEMENT erholt sich, indem die fehlgeschlagene Einschränkung übergangen wird, und passt das Ereignis weiter gegen das Schema.

Die Rückgabe "vanish" aus dem Wiederaufnahme-Skript bei den Fehlertypen MISSING\_ELEMENT und UNEXPECTED\_ELEMENT erholt sich, indem das Ereignis übergangen wird.

# Beispiele

[<URL: https://www.w3.org/TR/xmlschema-0/>]("https://www.w3.org/TR/xmlschema-0/") XML Schema Part 0: Primer Second Edition () beginnt mit diesem Beispielschema:

```
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">

  <xsd:annotation>
    <xsd:documentation xml:lang="en">
     Purchase order schema for Example.com.
     Copyright 2000 Example.com. All rights reserved.
    </xsd:documentation>
  </xsd:annotation>

  <xsd:element name="purchaseOrder" type="PurchaseOrderType"/>

  <xsd:element name="comment" type="xsd:string"/>

  <xsd:complexType name="PurchaseOrderType">
    <xsd:sequence>
      <xsd:element name="shipTo" type="USAddress"/>
      <xsd:element name="billTo" type="USAddress"/>
      <xsd:element ref="comment" minOccurs="0"/>
      <xsd:element name="items"  type="Items"/>
    </xsd:sequence>
    <xsd:attribute name="orderDate" type="xsd:date"/>
  </xsd:complexType>

  <xsd:complexType name="USAddress">
    <xsd:sequence>
      <xsd:element name="name"   type="xsd:string"/>
      <xsd:element name="street" type="xsd:string"/>
      <xsd:element name="city"   type="xsd:string"/>
      <xsd:element name="state"  type="xsd:string"/>
      <xsd:element name="zip"    type="xsd:decimal"/>
    </xsd:sequence>
    <xsd:attribute name="country" type="xsd:NMTOKEN"
                   fixed="US"/>
  </xsd:complexType>

  <xsd:complexType name="Items">
    <xsd:sequence>
      <xsd:element name="item" minOccurs="0" maxOccurs="unbounded">
        <xsd:complexType>
          <xsd:sequence>
            <xsd:element name="productName" type="xsd:string"/>
            <xsd:element name="quantity">
              <xsd:simpleType>
                <xsd:restriction base="xsd:positiveInteger">
                  <xsd:maxExclusive value="100"/>
                </xsd:restriction>
              </xsd:simpleType>
            </xsd:element>
            <xsd:element name="USPrice"  type="xsd:decimal"/>
            <xsd:element ref="comment"   minOccurs="0"/>
            <xsd:element name="shipDate" type="xsd:date" minOccurs="0"/>
          </xsd:sequence>
          <xsd:attribute name="partNum" type="SKU" use="required"/>
        </xsd:complexType>
      </xsd:element>
    </xsd:sequence>
  </xsd:complexType>

  <!-- Stock Keeping Unit, a code for identifying products -->
  <xsd:simpleType name="SKU">
    <xsd:restriction base="xsd:string">
      <xsd:pattern value="\d{3}-[A-Z]{2}"/>
    </xsd:restriction>
  </xsd:simpleType>

</xsd:schema>
```

Eine einfache Eins-zu-eins-Übertragung davon in ein tDOM-Schema-Definitionsskript wäre:

```
tdom::schema schema
schema define {

    # Purchase order schema for Example.com.
    # Copyright 2000 Example.com. All rights reserved.

    defelement purchaseOrder {ref PurchaseOrderType}

    foreach elm {comment name street city state product} {
        defelement $elm text
    }

    defpattern PurchaseOrderType {
        element shipTo ! {ref USAddress}
        element billTo ! {ref USAddress}
        element comment ?
        element items
        attribute orderDate date
    }

    defpattern USAddress {
        element name
        element street
        element city
        element state
        element zip ! {text number}
        attribute country {fixed "US"}
    }

    defelement items {
        element item * {
            element product
            element quantity ! {text positiveInteger}
            element USPrice ! {text number}
            element comment
            element shipDate ? {text date}
            attribute partNum {regexp "^\d{3}-[A-Z]{2}$"}
        }
    }
}
```

[<URL: http://relaxng.org/tutorial-20011203.html>]("http://relaxng.org/tutorial-20011203.html") Das RELAX NG Tutorial () beginnt mit diesem Beispiel:

```
Consider a simple XML representation of an email address book:

<addressBook>
  <card>
    <name>John Smith</name>
    <email>js@example.com</email>
  </card>
  <card>
    <name>Fred Bloggs</name>
    <email>fb@example.net</email>
  </card>
</addressBook>

The DTD would be as follows:

<!DOCTYPE addressBook [
<!ELEMENT addressBook (card*)>
<!ELEMENT card (name, email)>
<!ELEMENT name (#PCDATA)>
<!ELEMENT email (#PCDATA)>
]>

A RELAX NG pattern for this could be written as follows:

<element name="addressBook" xmlns="http://relaxng.org/ns/structure/1.0">
  <zeroOrMore>
    <element name="card">
      <element name="name">
        <text/>
      </element>
      <element name="email">
        <text/>
      </element>
    </element>
  </zeroOrMore>
</element>
```

Dieses Schema-Definitionsskript leistet dasselbe:

```
tdom::schema schema
schema define {
    defelement addressBook {
        element card *
    }
    defelement card {
        element name
        element email
    }
    foreach e {name email} {
        defelement $e text
    }
}
```


[domNode]: domNode.md
