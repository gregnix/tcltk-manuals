# Optionen eines Webdienstes verwenden

## Inhalt

- [Überblick](#berblick) 
- [Das Paket Webservices Utilities laden](#das-paket-webservices-utilities-laden) 
- [ Zugriffsroutine](#zugriffsroutine) 
-  Optionen  

  - [ genOutAttr - Attribute an ausgehenden Tags erzeugen](#genoutattr-attribute-an-ausgehenden-tags-erzeugen) 
  - [ includeDirectory - Plattenverzeichnis für XSD-Includes, wenn sie nicht über das Web erreichbar sind.](#includedirectory-plattenverzeichnis-f-r-xsd-includes-wenn-sie-nicht-ber-das-web-erreichbar-sind) 
  - [ nsOnChangeOnly - Namespace-Präfix nur setzen, wenn sich Namespaces ändern](#nsonchangeonly-namespace-pr-fix-nur-setzen-wenn-sich-namespaces-ndern) 
  - [parseInAttr - Attribute an eingehenden Tags zerlegen](#parseinattr-attribute-an-eingehenden-tags-zerlegen) 
  - [ queryTimeout - Zeitlimit für http(s)-Abrufe setzen.](#querytimeout-zeitlimit-f-r-http-s-abfragen-setzen) 
  - [ StrictMode - Verarbeitungsmodus für WSDL](#strictmode-verarbeitungsmodus-f-r-wsdl) 
  - [ UseNS - Namespaces an Feld-Tags setzen](#usens-namespaces-an-feld-tags-setzen) 
  - [ useTypeNs - das Namespace-Präfix des Typs als Präfix der Elemente verwenden](#usetypens-das-namespace-pr-fix-des-typs-als-pr-fix-der-elemente-verwenden) 
  - [ suppressNS - einen bestimmten Namespace-Präfix nicht setzen](#suppressns-einen-gegebenen-namespace-pr-fix-nicht-setzen) 

 

## Überblick

Die Pakete Webservices Client und Server verwenden die folgenden Optionen: 

- [UseNS](#usens-namespaces-an-feld-tags-setzen), wenn gesetzt, werden die folgenden Optionen wirksam:  
- [StrictMode](#strictmode-verarbeitungsmodus-f-r-wsdl) 
- [parseInAttr](#parseinattr-attribute-an-eingehenden-tags-zerlegen) 
- [genOutAttr](#genoutattr-attribute-an-ausgehenden-tags-erzeugen) 
- [includeDirectory](#includedirectory-plattenverzeichnis-f-r-xsd-includes-wenn-sie-nicht-ber-das-web-erreichbar-sind) 

  - [useTypeNs](#usetypens-das-namespace-pr-fix-des-typs-als-pr-fix-der-elemente-verwenden) 
  - [nsOnChangeOnly](#nsonchangeonly-namespace-pr-fix-nur-setzen-wenn-sich-namespaces-ndern) 
  - [suppressNS](#suppressns-einen-gegebenen-namespace-pr-fix-nicht-setzen) 

Die Attribute lassen sich mit [::WS::Utils::SetOption](#zugriffsroutine) abfragen und setzen.

Beim Aufruf von der Client-Seite werden die folgenden Optionen bei jedem Aufruf überschrieben und wiederhergestellt: 

- genOutAttr
- nsOnChangeOnly
- parseInAttr
- suppressNS
- UseNS
- useTypeNs
- valueAttrCompatiblityMode

---

## Das Paket Webservices Utilities laden 

Das Serverpaket für Webservices wird so geladen: 

```
 package require WS::Utils
```

Dieser Befehl lädt die Hilfsprogramme nur beim ersten Mal, es schadet also nicht, ihn in jede Datei zu setzen, die die Hilfsprogramme verwendet. 

---

## Zugriffsroutine 

**Prozedurname : ::WS::Utils::SetOption** 

**Beschreibung :** Eine Option abfragen oder setzen 

**Argumente :** 

```
    option - name of the option
    value - value of the option (optional)
```

**Gibt zurück : Der Wert der Option** 

**Nebenwirkungen : Keine** 

**Ausnahmebedingungen : Keine** 

**Voraussetzungen : Keine** 

---

## genOutAttr - Attribute an ausgehenden Tags erzeugen 

 Die Option *genOutAttr* wandelt, wenn sie auf einen Wert „true“ gesetzt ist, alle Dictionary-Schlüssel des Eintrags für ein gegebenes Feld-Tag in Attribut-Wert-Paare des Tags im ausgehenden XML um. Für Attribute in der URL „http://www.w3.org/2001/XMLSchema-instance“ ist der Schlüssel der Attributname mit zwei vorangestellten Doppelpunkten (zum Beispiel **::type**), und der Wert ist der Wert des Attributs. Für Attribute außerhalb der URL „http://www.w3.org/2001/XMLSchema-instance“ ist der Schlüssel der Attributname, und der Wert ist der Wert des Attributs. Der Wert des Tags erhält einen Schlüssel, den [valueAttrCompatiblityMode](#valueattrcompatiblitymode-den-dictionary-schl-ssel-f-r-den-wert-angeben-wenn-attribute-verwendet-werden) bestimmt. 

 Der Vorgabewert „0“ schaltet diese Option aus. 

---

## includeDirectory - Plattenverzeichnis für XSD-Includes, wenn sie nicht über das Web erreichbar sind. 

 Die Option *includeDirectory* weist TclWs an, wenn sie gesetzt ist, im angegebenen Verzeichnis nach XSD-Includes zu suchen, die über das Web nicht gefunden werden. 

 Der Vorgabewert „{}“ schaltet diese Option aus. 

---

## nsOnChangeOnly - Namespace-Präfix nur setzen, wenn sich Namespaces ändern 

 Die Option *nsOnChangeOnly* setzt, wenn sie auf einen Wert „true“ gesetzt ist, Namespace-Präfixe nur, wenn sich die Namespaces ändern. 

 Diese Option wirkt nur, wenn die Option [UseNS](#usens-namespaces-an-feld-tags-setzen) gesetzt ist. 

 Der Vorgabewert „0“ schaltet diese Option aus. 

---

## parseInAttr - Attribute an eingehenden Tags zerlegen 

 Die Option *parseInAttr* wandelt, wenn sie auf einen Wert „true“ gesetzt ist, alle Attribute eingehender Feld-Tags in Dictionary-Einträge für dieses Tag um. Für Attribute in der URL „http://www.w3.org/2001/XMLSchema-instance“ ist der Schlüssel der Attributname mit zwei vorangestellten Doppelpunkten (zum Beispiel **::type**), und der Wert ist der Wert des Attributs. Für Attribute außerhalb der URL „http://www.w3.org/2001/XMLSchema-instance“ ist der Schlüssel der Attributname, und der Wert ist der Wert des Attributs. Der Wert des Tags erhält einen Schlüssel, den [valueAttrCompatiblityMode](#valueattrcompatiblitymode-den-dictionary-schl-ssel-f-r-den-wert-angeben-wenn-attribute-verwendet-werden) bestimmt. 

 Der Vorgabewert „0“ schaltet diese Option aus. 

---

## queryTimeout - Zeitlimit für http(s)-Abfragen setzen

 Zeitlimit für jede Netzabfrage in ms. Das [Paket auf der Client-Seite](Calling_a_Web_Service.md#configuring-a-service) hat eine Option mit derselben Funktion, die verwendet wird, wenn ein Aufruf einen Optionskontext hat. 

Vorgabewert: 60000 (1 Minute).

---

## StrictMode - Verarbeitungsmodus für WSDL 

 Die Option *StrictMode* legt fest, was geschieht, wenn beim Zerlegen einer WSDL ein Fehler erkannt wird. Die zulässigen Werte sind: 

- **debug**
- **warning**
- **error**

 Wenn *StrictMode* auf **debug** oder **warning** gesetzt ist, wird eine Meldung mit dem Paket ::log auf dieser Stufe protokolliert, und der Fehler wird danach ignoriert. 

 Wenn *StrictMode* auf einen anderen Wert als **debug** oder **warning** gesetzt ist, wird eine Meldung mit dem Paket ::log auf der Stufe **error** protokolliert, und eine Ausnahme wird erzeugt. 

 Der Vorgabewert ist **error**. 

 Eine wichtige Verwendung ist, Namespace-Importe in einer WDSL zu ignorieren, die tatsächlich keine Definitionen importieren. 

---

## UseNS - Namespaces an Feld-Tags setzen 

 Die Option *UseNS* setzt, wenn sie auf einen Wert „true“ gesetzt ist, einen Namespace-Alias an alle Feld-Tags. 

 Der Vorgabewert „1“ schaltet diese Option ein. 

---

## useTypeNs - das Namespace-Präfix des Typs als Präfix der Elemente verwenden 

 Die Option *useTypeNs* verwendet, wenn sie auf einen Wert „true“ gesetzt ist, das Präfix des Namespace des Typs statt des Präfixes des Namespace des Elements. 

 Diese Option wirkt nur, wenn die Option [UseNS](#usens-namespaces-an-feld-tags-setzen) gesetzt ist. 

 Der Vorgabewert „0“ schaltet diese Option aus. 

---

## suppressNS - einen gegebenen Namespace-Präfix nicht setzen. 

 Die Option *suppressNS* bewirkt, wenn sie gesetzt ist, dass der gegebene Namespace nie als Präfix verwendet wird (Tags, die das gegebene Präfix sonst hätten, haben dann kein Präfix). 

 Diese Option wirkt nur, wenn die Option [UseNS](#usens-namespaces-an-feld-tags-setzen) gesetzt ist. 

 Der Vorgabewert „{}“ schaltet diese Option aus. 

---

## valueAttrCompatiblityMode - den Dictionary-Schlüssel für den Wert angeben, wenn Attribute verwendet werden

 Diese Option ist nur sinnvoll, wenn die Option *parseInAttr* oder *genOutAttr* auf einen Wert „true“ gesetzt ist. Bei einem Wert „true“ hat der Wert des Tags den Schlüssel der leeren Zeichenkette (also **{}**). Bei einem Wert „false“ hat der Wert des Tags den Schlüssel **::value**. 

 Der Vorgabewert „0“ schaltet diese Option aus. 

---
