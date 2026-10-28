---
CommandName: expatapi
title: expatapi
ManualSection: 3
Version: unknown
TclPart: Tcl
TclDescription:
Links:
 - expat
Keywords:
 - C handler set
Copyright:
---

# Name

CheckExpatParserObj, CHandlerSetInstall, CHandlerSetRemove, CHandlerSetCreate, CHandlerSetGetUserData, GetExpatInfo - Funktionen, um Erweiterungen von expat-Parserobjekten anzulegen, einzurichten und zu entfernen.

# Übersicht

::: {.synopsis} :::
**#include <tclexpat.h>**

[int]{.ret} [CheckExpatParserObj]{.ccmd} [interp, nameObj]{.cargs}

[int]{.ret} [CHandlerSetInstall]{.ccmd} [interp, expatObj, handlerSet]{.cargs}

[int]{.ret} [CHandlerSetRemove]{.ccmd} [interp, expatObj, handlerSetName]{.cargs}

[CHandlerSet\*]{.ret} [CHandlerSetCreate]{.ccmd} [handlerSetName]{.cargs}

[CHandlerSet\*]{.ret} [CHandlerSetGet]{.ccmd} [interp, expatObj, handlerSetName]{.cargs}

[void\*]{.ret} [CHandlerSetGetUserData]{.ccmd} [interp, expatObj, handlerSetName]{.cargs}

[TclGenExpatInfo\*]{.ret} [GetExpatInfo]{.ccmd} [interp, expatObj]{.cargs}
:::

# Argumente

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter mit dem expat-Parserobjekt.

[\*expatObj]{.carg .in type="Tcl_Obj"}
: Ein Tcl-Objekt mit dem Befehlsnamen des abzufragenden oder zu ändernden expat-Parserobjekts.

[\*handlerSetName]{.carg .in type="char"}
: Bezeichner der Handler-Menge.

[\*handlerSet]{.carg .in type="CHandlerSet"}
: Zeiger auf eine C-Handler-Menge.

[\*nameObj]{.carg .inout type="Tcl_Obj"}
: Ein Tcl-Objekt mit dem Namen eines expat-Parserobjekts.

:::

# Beschreibung

Die hier beschriebenen Funktionen erlauben es, einem tDOM-Tcl-expat-Parserobjekt auf C-Ebene geschriebene Ereignis-Handler hinzuzufügen. Ein tDOM-Tcl-expat-Parserobjekt kann zu einem bestimmten Ereignis mehrere Tcl-Skripte und C-Funktionen haben. Tritt das Ereignis ein, werden zuerst die Tcl-Skripte und dann die dem Ereignis zugeordneten C-Funktionen der Reihe nach aufgerufen.

Eine tDOM-Tcl-expat-Parsererweiterung ist eine gewöhnliche Tcl-Erweiterung und wird wie jede andere Tcl-Erweiterung geladen. Mindestens ein neuer Befehl der Tcl-Ebene muss eingerichtet werden, der ein tDOM-Tcl-expat-Parserobjekt bearbeitet.

Eine Handler-Menge auf C-Ebene ist eine Datenstruktur wie diese:

```
typedef struct CHandlerSet {
    struct CHandlerSet *nextHandlerSet;
    char *name;                     /* refname of the handler set */
    int ignoreWhiteCDATAs;          /* ignore 'white' CDATA sections */

    void *userData;                 /* Handler set specific Data Structure;
                                       the C handler set extension has to
                                       malloc the needed structure in his
                                       init func and has to provide a
                                       cleanup func (to free it). */

    CHandlerSet_userDataReset        resetProc;
    CHandlerSet_userDataFree         freeProc;

    /* C func for element start */
    XML_StartElementHandler          elementstartcommand;
    /* C func for element end */
    XML_EndElementHandler            elementendcommand;
    /* C func for character data */
    XML_CharacterDataHandler         datacommand;
    /* C func for namespace decl start */
    XML_StartNamespaceDeclHandler    startnsdeclcommand;
    /* C func for namespace decl end */
    XML_EndNamespaceDeclHandler      endnsdeclcommand;
    /* C func for processing instruction */
    XML_ProcessingInstructionHandler picommand;
    /* C func for default data */
    XML_DefaultHandler               defaultcommand;
    /* C func for unparsed entity declaration */
    XML_NotationDeclHandler          notationcommand;
    /* C func for external entity */
    XML_ExternalEntityRefHandler     externalentitycommand;
    /* C func for unknown encoding */
    XML_UnknownEncodingHandler       unknownencodingcommand;
    /* C func for comments */
    XML_CommentHandler               commentCommand;
    /* C func for "not standalone" docs */
    XML_NotStandaloneHandler         notStandaloneCommand;
    /* C func for CDATA section start */
    XML_StartCdataSectionHandler     startCdataSectionCommand;
    /* C func for CDATA section end */
    XML_EndCdataSectionHandler       endCdataSectionCommand;
    /* C func for !ELEMENT decl's */
    XML_ElementDeclHandler           elementDeclCommand;
    /* C func for !ATTLIST decl's */
    XML_AttlistDeclHandler           attlistDeclCommand;
    /* C func for !DOCTYPE decl's */
    XML_StartDoctypeDeclHandler      startDoctypeDeclCommand;
    /* C func for !DOCTYPE decl ends */
    XML_EndDoctypeDeclHandler        endDoctypeDeclCommand;
    /* C func for !ENTITY decls's */
    XML_EntityDeclHandler            entityDeclCommand;
} CHandlerSet;
```

Die Typen und die Argumente der Ereignisfunktionen (XML\_\*) sind genau dieselben wie die Handler-Funktionen der Bibliothek expat und in expat.h im Einzelnen beschrieben, siehe dort. Die Erweiterung muss nur die benötigten Handler-Funktionen bereitstellen. Ungenutzte Handler-Felder dürfen bleiben, wie sie sind. CHandlerSetCreate setzt sie auf NULL.

Der *name* dieser Struktur dient zur Kennzeichnung der Handler-Menge.

Ist die Markierung *ignoreWhiteCDATAs* gesetzt, wird Elementinhalt, der nur aus Leerraum besteht, nicht mit datacommand gemeldet.

Das Element *userData* zeigt auf die für die Handler-Menge eigenen Daten. Die Ereignis-Handler-Funktionen werden mit diesem Zeiger als Argument userData aufgerufen.

*resetProc* und *freeProc* müssen Argumente haben, die zum Typ passen

```
void (Tcl_Interp *interp, void *userData)
```

*resetProc* wird aufgerufen, wenn der Parser mit **<parserObj> reset** zurückgesetzt wird, und soll die nötige Aufräumarbeit und Neuinitialisierung tun, damit die C-Handler-Menge auf ein neues XML-Dokument vorbereitet ist. *freeProc* wird aufgerufen, wenn der Parser gelöscht wird, und soll Speicher aufräumen.

*CHandlerSetCreate* legt eine C-Handler-Menge an, gibt ihr den Namen *name* und setzt jedes andere Element auf NULL.

*CHandlerSetInstall* fügt die *handlerSet* dem Parser *expatObj* hinzu. Der Parser muss ein tDOM-Tcl-expat-Parserobjekt im Interpreter *interp* sein. Der Name der C-Handler-Menge muss für den Parser eindeutig sein. Bei Erfolg kommt 0 zurück. Ist *expatObj* im Interpreter *interp* kein Parserobjekt, kommt 1 zurück. Hat dieser Parser schon eine C-Handler-Menge mit dem Namen der handlerSet, kommt 2 zurück.

*CHandlerSetRemove* entfernt die über *handlerSetName* bezeichnete C-Handler-Menge vom Parser *expatObj*. Der Parser muss ein tDOM-Tcl-expat-Parserobjekt im Interpreter *interp* sein. *CHandlerSetRemove* ruft die Funktion freeProc der Struktur der C-Handler-Menge auf, entfernt die Handler-Menge aus der Liste der C-Handler-Mengen und gibt die Handler-Struktur frei. Bei Erfolg kommt 0 zurück. Ist *expatObj* im Interpreter *interp* kein Parserobjekt, kommt 1 zurück. Hat dieser Parser keine C-Handler-Menge namens *handlerSetName*, kommt 2 zurück.

*CheckExpatParserObj* gibt 1 zurück, wenn *nameObj* im Interpreter *interp* ein tDOM-Tcl-expat-Parserobjekt ist, sonst 0. Beispiel:

```
int
TclExampleObjCmd(dummy, interp, objc, objv)
     ClientData dummy;
     Tcl_Interp *interp;
     int objc;
     Tcl_Obj *const objv[];
{
    char          *method;
    CHandlerSet   *handlerSet;
    int            methodIndex, result;
    simpleCounter *counter;


    static char *exampleMethods[] = {
        "enable", "getresult", "remove",
        NULL
    };
    enum exampleMethod {
        m_enable, m_getresult, m_remove
    };

    if (objc != 3) {
        Tcl_WrongNumArgs (interp, 1, objv, example_usage);
        return TCL_ERROR;
    }

    if (!CheckExpatParserObj (interp, objv[1])) {
        Tcl_SetResult (interp, "First argument has to be a expat parser object", NULL);
        return TCL_ERROR;
    }
    /* ... */
```

*CHandlerSetGet* gibt einen Zeiger auf die über den Namen *handlerSetName* bezeichnete C-Handler-Menge des Parserobjekts *expatObj* zurück. *expatObj* muss ein expat-Parserobjekt im Interpreter *interp* sein. Bei einem Fehler kommt NULL zurück.

*CHandlerSetGetUserData* gibt einen Zeiger auf die userData der über den Namen *handlerSetName* bezeichneten C-Handler-Menge des Parserobjekts *expatObj* zurück. *expatObj* muss ein expat-Parserobjekt im Interpreter *interp* sein. Bei einem Fehler kommt NULL zurück.

*GetExpatInfo* ist eine Hilfsfunktion, die einen Zeiger auf die Struktur TclGenExpatInfo des tDOM-Tcl-expat-Parserobjekts *expatObj* zurückgibt. Das *expatObj* muss ein tDOM-Tcl-expat-Parserobjekt im Interpreter *interp* sein. Das ist vor allem nützlich, um den Anwendungsstatus des Parserobjekts zu setzen.

Ein einfaches, aber voll funktionsfähiges Beispiel steht im Verzeichnis extensions/example, ein umfangreicheres Beispiel tnc im Verzeichnis extensions/tnc, eine einfache Erweiterung zur DTD-Prüfung.
