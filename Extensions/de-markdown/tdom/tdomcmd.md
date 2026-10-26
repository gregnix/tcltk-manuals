---
CommandName: tdom
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: 
Links:
 - dom
 - expat
Keywords:
 - DOM
 - SAX
 - C handler set
Copyright:
---

# NAME

tdom - tdom ist eine Erweiterung eines expat-Parserobjekts und legt beim Lesen aus der Eingabe einen DOM-Baum im Speicher an.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdom]{.lit} 

set parser \[expat\]

tdom \$parser enable
:::

# BESCHREIBUNG

*tdom* fügt einem Tcl-expat-Parserobjekt die C-Handler-Menge "tdom" hinzu. Diese Handler-Menge baut aus der vom Parser gelesenen Eingabe einen DOM-Baum im Speicher. Ein so angelegter DOM-Baum verhält sich genau wie ein mit dem Befehl "dom" angelegter DOM-Baum, siehe dort. tdom ist nur eine weitere Schnittstelle zur selben Funktion und nutzt den Code hinter dem Code von **dom**, um den DOM-Baum aufzubauen.

**tdom** *parserObj* **enable**
: 


Fügt einem Tcl-expat-Parserobjekt die C-Handler-Menge tdom hinzu. Wenn der Parser das nächste Mal Eingabe liest, legen die C-Handler-Funktionen von tdom einen DOM-Baum im Speicher an.

**tdom** *parserObj* **getdoc**
: 


Gibt den DOM-Baum als Objekt domDoc zurück, siehe dort.

**tdom** *parserObj* **setStoreLineColumn** ?*boolean*__?__
: 


Die genaue Beschreibung steht bei der Methode **setStoreLineColumn** des Befehls **dom**.

**tdom** *parserObj* **remove**
: 


Entfernt die C-Handler-Menge tdom vom Parserobjekt.

**tdom** *parserObj* **keepEmpties**
: 


Die genaue Beschreibung steht bei der Option **-keepEmpties** des Befehls **dom**.

**tdom** *parserObj* **setExternalEntityResolver** *script*
:
