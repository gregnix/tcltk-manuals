---
CommandName: pullparser
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: 
Keywords:
 - XML
 - pull
 - parsing
Copyright:
---

# NAME

tdom::pullparser - Einen XML-Pull-Parser-Befehl anlegen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdom]{.lit} 

[tdom::pullparser]{.cmd} [cmdName]{.arg} [-ignorewhitecdata]{.optarg} 
:::

# BESCHREIBUNG

Dieser Befehl legt XML-Pull-Parser-Befehle mit einer einfachen API an, in der Art eines einfachen StAX-Parsers. Nach dem Anlegen muss eine Eingabequelle gesetzt werden, damit der Pull-Parser etwas Nützliches tut. Dazu dienen die Methoden *input*, *inputchannel* und *inputfile*.

Der Parser hat immer einen *state*. Das XML wird bis zu einem nächsten Zustand gelesen, die nötige Arbeit wird dort erledigt, und es geht weiter zum nächsten Zustand. Wohlgeformtheitsfehler unterwegs werden als TCL_ERROR gemeldet, mit zusätzlichen Angaben in der Fehlermeldung.

Die Pull-Parser folgen externen Entitäten nicht und kennen nur XML 1.0, von XML-Namensräumen wissen sie nichts. Tags und Attributnamen kommen wie in der Quelle. Kommentare, Verarbeitungsanweisungen und externe Entitäten werden nicht gemeldet und still übergangen. CDATA-Abschnitte werden behandelt, als wäre ihr Inhalt ohne CDATA-Abschnitt geliefert worden.

Zeichenentitäten und Attributvorgaben in der internen Teilmenge werden beachtet, weil expat der zugrunde liegende Parser ist. Das ist vermutlich etwas schneller als eine vergleichbare Umsetzung mit der SAX-Schnittstelle. Das Programmiermodell ist angenehm, die Schnittstelle ist schlank.

Ist die Option *-ignorewhitecdata* angegeben, übergeht der angelegte XML-Pull-Parser-Befehl jeden nur aus Leerraum bestehenden Textinhalt (' ', \\t, \\n und \\r) zwischen START_TAG und START_TAG oder END_TAG. Der Parser hält bei solcher Eingabe nicht an und legt TEXT-Zustandsereignisse nur für Text an, der nicht nur aus Leerraum besteht.

Nicht jede Methode ist in jedem Zustand gültig. Der Parser löst TCL_ERROR aus, wenn eine Methode in einem Zustand aufgerufen wird, für den sie nicht gilt. Die gültigen Methoden der angelegten Befehle sind:

**state**
: Diese Methode ist in allen Parserzuständen gültig. Die möglichen Rückgabewerte und ihre Bedeutung:


**•**
: *READY* - Der Parser ist angelegt oder zurückgesetzt, aber es ist keine Eingabe gesetzt.

**•**
: *START_DOCUMENT* - Die Eingabe ist gesetzt, der Parser ist bereit, mit dem Lesen zu beginnen.

**•**
: *START_TAG* - Der Parser hat das Lesen an einem Start-Tag angehalten.

**•**
: *END_TAG* - Der Parser hat das Lesen an einem Ende-Tag angehalten.

**•**
: *TEXT* - Der Parser hat das Lesen angehalten, um Text zwischen Tags zu melden.

**•**
: *END_DOKUMENT* - Der Parser hat das Lesen ohne Fehler beendet.

**•**
: *PARSE_ERROR* - Der Parser hat das Lesen bei einem XML-Fehler in der Eingabe angehalten.


**input** *data*
: Diese Methode ist nur im Zustand *READY* gültig. Sie bereitet den Parser darauf vor, *data* als zu lesende XML-Eingabe zu verwenden, und schaltet den Parser in den Zustand START_DOCUMENT.

**inputchannel** *channel*
: Diese Methode ist nur im Zustand *READY* gültig. Sie bereitet den Parser darauf vor, die zu lesende XML-Eingabe aus *channel* zu lesen, und schaltet den Parser in den Zustand START_DOCUMENT.

**inputfile** *filename*
: Diese Methode ist nur im Zustand *READY* gültig. Sie öffnet *filename* und bereitet den Parser darauf vor, die zu lesende XML-Eingabe aus dieser Datei zu lesen. Die Methode gibt TCL_ERROR zurück, wenn die Datei nicht im Lesemodus geöffnet werden kann. Sonst schaltet sie den Parser in den Zustand START_DOCUMENT.

**next**
: Diese Methode ist in den Zuständen *START_DOCUMENT*, *START_TAG*, *END_TAG* und *TEXT* gültig. Sie setzt das Lesen der XML-Eingabe bis zum nächsten Ereignis fort und gibt dieses zurück.

**tag**
: Diese Methode ist nur in den Zuständen *START_TAG* und *END_TAG* gültig. Sie gibt den Tagnamen des aktuellen Start- oder Ende-Tags zurück.

**attributes**
: Diese Methode ist nur im Zustand *START_TAG* gültig. Sie gibt alle Attribute des Elements in einer Liste aus Namen und Werten zurück.

**text**
: Diese Methode ist nur im Zustand *TEXT* gültig. Sie gibt die Zeichendaten des Ereignisses zurück. Zwischen START_TAG und dem nächsten Ereignis START_TAG oder END_TAG gibt es immer höchstens ein TEXT-Ereignis.

**skip**
: Diese Methode ist nur im Zustand *START_TAG* gültig. Sie springt zum zugehörigen Ende-Tag, übergeht unterwegs alle Ereignisse außer XML-Lesefehlern und gibt den neuen Zustand END_TAG zurück.

**find-element**  ? tagname | -names tagnames ?
: Diese Methode ist nur in den Zuständen *START_DOCUMENT*, *START_TAG* und *END_TAG* gültig. Sie springt vorwärts bis zum nächsten Element-Start-Tag mit dem Tagnamen *tagname* und gibt den neuen Zustand START_TAG zurück. Ist mit der Option *-names* eine Liste von Tagnamen angegeben, passt jeder der *tagnames*. Gibt es kein solches Element, hält der Parser am Ende der Eingabe an und gibt END_DOCUMENT zurück.

**reset**
: Diese Methode ist in allen Parserzuständen gültig. Sie setzt den Parser in den Zustand READY zurück und gibt diesen zurück.

**delete**
: Diese Methode ist in allen Parserzuständen gültig. Der Parserbefehl wird gelöscht. Weitere Methoden:

**line**
: Diese Methode ist in allen Parserzuständen außer READY und TEXT gültig. Sie gibt die Zeilennummer der Leseposition zurück. Die Zeilenzählung beginnt bei 1.

**column**
: Diese Methode ist in allen Parserzuständen außer READY und TEXT gültig. Sie gibt den Abstand der Leseposition vom Anfang der aktuellen Zeile zurück. Die Spaltenzählung beginnt bei 0.
