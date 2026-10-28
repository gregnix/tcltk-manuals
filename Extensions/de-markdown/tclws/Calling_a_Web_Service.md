# Einen Webdienst aus Tcl aufrufen

---

## Inhalt

- [1 Überblick](#berblick) 
- [2 Das Paket Webservices Client laden](#das-paket-webservices-client-laden) 
- [3 WSDL eines entfernten Webdienst-Servers abfragen und zerlegen](#wsdl-eines-entfernten-webdienst-servers-abfragen-und-zerlegen) 
- [4 Eine gespeicherte WSDL zerlegen](#eine-gespeicherte-wsdl-zerlegen) 
- [5 Eine vorzerlegte WSDL laden](#eine-vorzerlegte-wsdl-laden) 
- [6 Einen REST-Dienst von Hand definieren](#einen-rest-dienst-von-hand-definieren) 
- [7 Transformationen definieren](#transformationen-definieren) 
- [8 Synchroner Aufruf, der ein Dictionary-Objekt zurückgibt](#synchroner-aufruf-der-ein-dictionary-objekt-zur-ckgibt) 
- [9 Asynchroner Aufruf mit getrennten Rückruffunktionen für Erfolg und Fehler](#asynchroner-aufruf-mit-getrennten-r-ckruffunktionen-f-r-erfolg-und-fehler) 
- [10 Erzeugen von Stub-Prozeduren in Tcl für synchrone Aufrufe](#erzeugen-von-stub-prozeduren-in-tcl-f-r-synchrone-aufrufe) 
- [11 Synchroner Aufruf, der das rohe XML zurückgibt](#synchroner-aufruf-der-das-rohe-xml-zur-ckgibt) 
- [12 Dienste konfigurieren](#einen-dienst-konfigurieren) 
- [13 Abstrakte Typen in konkrete Typen umwandeln](#abstrakte-typen-in-konkrete-typen-umwandeln) 

 

## Überblick 

Das Paket Webservices Client bietet mehrere Wege, festzulegen, welche Operationen ein entfernter Webdienst-Server bereitstellt und wie diese Operationen aufgerufen werden. Es enthält außerdem mehrere Wege, eine Operation aufzurufen. 

Die folgenden Wege stehen bereit, um entfernte Operationen zu definieren: 

- Eine vorzerlegte WSDL laden 
- WSDL eines entfernten Webdienst-Servers abfragen und zerlegen 
- Eine gespeicherte WSDL zerlegen 

- Einen REST-Dienst von Hand definieren 

Das zerlegte Format ist deutlich kompakter als das XML einer WSDL. 

Die folgenden Wege stehen bereit, um eine Operation eines Webdienst-Servers direkt aufzurufen: 

- Synchroner Aufruf, der ein Dictionary-Objekt zurückgibt 
- Synchroner Aufruf, der das rohe XML zurückgibt 
- Asynchroner Aufruf mit getrennten Rückruffunktionen für Erfolg und Fehler 
- Erzeugen von Stub-Prozeduren in Tcl für synchrone Aufrufe 

Dieses Paket verwendet das Paket **log** aus **TclLib**. Insbesondere werden die folgenden Stufen verwendet: 

- error/warning -- Fehler, die beim Zerlegen einer WSDL auftreten. Die tatsächliche Stufe hängt von den Optionen ab, die im Paket **::WS::Utils** gesetzt sind. 
- info -- HTTP-Aufrufe einschließlich des XML, mit denen Operationen aufgerufen werden, und die empfangenen Antworten. *Eingeführt in 2.2.8.* 
- debug -- ausführliche interne Angaben. Das sollte nur verwendet werden, wenn die Interna des Pakets TclWs im Code nachvollzogen werden sollen. 

## Das Paket Webservices Client laden 

Das Serverpaket für Webservices wird so geladen: 

```
 package require WS::Client
```

Dieser Befehl lädt die Hilfsprogramme nur beim ersten Mal, es schadet also nicht, ihn in jede Datei zu setzen, die die Hilfsprogramme verwendet. 

---

## WSDL eines entfernten Webdienst-Servers abfragen und zerlegen 

**Prozedurname : ::WS::Client::GetAndParseWsdl** 

**Beschreibung : Die WSDL-Datei von der angegebenen URL holen, sie zerlegen und den Dienst erzeugen.** 

**Argumente :** 

```
     url     - Die URL der WSDL
     headers - Zusätzliche Header für die HTTP-Anfrage. Das
               ist ein Schlüssel-Wert-Listenargument. Es muss eine Liste mit
               einer geraden Anzahl von Elementen sein, die abwechseln zwischen
               Schlüsseln und Werten. Die Schlüssel werden zu Headerfeldnamen.
               Zeilenumbrüche werden aus den Werten entfernt, damit der Header
               nicht verfälscht werden kann.
               Das ist ein optionales Argument und ist voreingestellt {}.
     serviceAlias - Aliasname (eindeutig) für den Dienst.
                    Das ist ein optionales Argument und ist voreingestellt auf den Namen des
                    Dienstes in serviceInfo.
     serviceNumber - Nummer des Dienstes innerhalb der WSDL, dem der
                     serviceAlias zugewiesen wird. Wird nur zusammen mit einem serviceAlias erkannt.
                     Der erste Dienst (Vorgabe) wird mit dem Wert "1" angesprochen.
```

Der folgende WSDL-Ausschnitt definiert zwei Dienste:

```
  >definitions ...<
    >service name="service1"<
      ...
    >/service<
    >service name="service1"<
      ...
    >/service<
  >/definitions<
```

Ein leerer oder fehlender *serviceAlias* würde die Dienste "service1" und "service2" erzeugen.

Mit *serviceAlias*="SE" und *serviceNumber*=2 entstünde der Dienst "SE", der "service2" aus der WSDL enthält.

**Gibt zurück : Die zerlegte Dienstdefinition** 

**Nebenwirkungen : Keine** 

**Ausnahmebedingungen : Keine** 

**Voraussetzungen : Keine** 

---

## Eine gespeicherte WSDL zerlegen 

**Prozedurname : ::WS::Client::ParseWsdl** 

**Beschreibung : Eine WSDL zerlegen und den Dienst erzeugen. Die Stubs ebenfalls erzeugen, wenn das angegeben ist.** 

**Argumente :** 

```
     wsdlXML - XML der WSDL
```

**Optionale Argumente:** 

```
     -createStubs 0|1 - Stub-Routinen für den Dienst erzeugen
     -headers         - Zusätzliche Header für die HTTP-Anfrage. Das
                        ist ein Schlüssel-Wert-Listenargument. Es muss eine Liste mit
                        einer geraden Anzahl von Elementen sein, die abwechseln zwischen
                        Schlüsseln und Werten. Die Schlüssel werden zu Headerfeldnamen.
                        Zeilenumbrüche werden aus den Werten entfernt, damit der Header
                        nicht verfälscht werden kann.
                        Das ist ein optionales Argument und ist voreingestellt {}.
     -serviceAlias    - Aliasname (eindeutig) für den Dienst.
                        Das ist ein optionales Argument und ist voreingestellt auf den Namen des
                        Dienstes in serviceInfo.
     serviceNumber - Nummer des Dienstes innerhalb der WSDL, dem der
                     serviceAlias zugewiesen wird. Wird nur zusammen mit einem serviceAlias erkannt.
                     Der erste Dienst (Vorgabe) wird mit dem Wert "1" angesprochen.
```

Die Argumente sind positionsunabhängig.

Ein Beispiel für *serviceAlias* und *serviceNumber* steht in [dem Kapitel oben](#wsdl-eines-entfernten-webdienst-servers-abfragen-und-zerlegen).

**Gibt zurück : Die zerlegte Dienstdefinition** 

**Nebenwirkungen : Keine** 

**Ausnahmebedingungen : Keine** 

**Voraussetzungen : Keine** 

---

## Eine vorzerlegte WSDL laden 

**Prozedurname : ::WS::Client::LoadParsedWsdl** 

**Beschreibung : Eine gespeicherte Dienstdefinition laden in** 

**Argumente :** 

```
     serviceInfo - zerlegte Dienstdefinition, wie zurückgegeben von
                   ::WS::Client::ParseWsdl oder ::WS::Client::GetAndParseWsdl
     headers     - Zusätzliche Header für die HTTP-Anfrage. Das
                     ist ein Schlüssel-Wert-Listenargument. Es muss eine Liste mit
                     einer geraden Anzahl von Elementen sein, die abwechseln zwischen
                     Schlüsseln und Werten. Die Schlüssel werden zu Headerfeldnamen.
                     Zeilenumbrüche werden aus den Werten entfernt, damit der Header
                     nicht verfälscht werden kann.
                     Das ist ein optionales Argument und ist voreingestellt {}.
     serviceAlias - Aliasname (eindeutig) für den Dienst.
                     Das ist ein optionales Argument und ist voreingestellt auf den Namen des
                     Dienstes in serviceInfo.
```

**Gibt zurück : Der Name des geladenen Dienstes** 

**Nebenwirkungen : Keine** 

**Ausnahmebedingungen : Keine** 

**Voraussetzungen : Keine** 

---

## Einen REST-Dienst von Hand definieren 

### Dienstdefinition

**Prozedurname : ::WS::Client::CreateService** 

**Beschreibung : Einen REST-Dienst definieren** 

**Argumente :** 

```
     serviceName - Dienstname, dem der Namespace hinzugefügt wird
     type        - Der Typ des Dienstes, derzeit wird nur REST unterstützt.
     url          - URL des Namespace.
     args         - Optionale Argumente:
                            Das ist ein optionales Argument und ist voreingestellt auf den Namen des
                                -header httpHeaderList.
```

**Gibt zurück : Der lokale Alias (tns)** 

**Nebenwirkungen : Keine** 

**Ausnahmebedingungen : Keine** 

**Voraussetzungen : Keine** 

### Methodendefinition

**Prozedurname : ::WS::Client::DefineRestMethod** 

**Beschreibung : Eine Methode eines REST-Dienstes definieren** 

**Argumente :** 

```
     serviceName - Dienstname, dem der Namespace hinzugefügt wird
     methodName  - Der Name der hinzuzufügenden Methode.
     returnType  - Der Typ, den die Prozedur gegebenenfalls zurückgibt. Das Format ist:
                           xmlTag typeInfo.
     inputArgs   - Liste von Definitionen der Eingabeargumente, wobei jede
                           Definition das Format hat: name typeInfo.

    dabei hat typeInfo das Format {type typeName comment commentString}
```

**Gibt zurück : Die aktuelle Dienstdefinition**  

**Nebenwirkungen : Keine** 

**Ausnahmebedingungen : Keine** 

**Voraussetzungen : Keine** 

---

## Transformationen definieren 

**Prozedurname : ::WS::Client::SetServiceTransforms** 

**Beschreibung : Die Transformationen eines Dienstes definieren** 

```
               Die Signatur der Transformation ist:
                   cmd serviceName operationName transformType xml {url {}} {argList {}}
               dabei ist transformType REQUEST oder REPLY
               und url und argList sind nur vorhanden, wenn transformType == REQUEST
```

**Argumente :** 

```
     serviceName  - Der Name des Webdienstes
     inTransform  - Befehl der Eingabetransformation, voreingestellt {}.
     inTransform ist die Prozedur, die die ausgehende SOAP-Nachricht umformt, die die Eingabe des Servers wird.
     outTransform - Befehl der Ausgabetransformation, voreingestellt {}.
     outTransform ist die Prozedur, die die eingehende SOAP-Nachricht umformt, die die Antwort des Servers ist.
```

**Gibt zurück : Nichts**

**Nebenwirkungen : Keine** 

**Ausnahmebedingungen : Keine** 

**Voraussetzungen : Der Dienst muss definiert worden sein.** 

---

## Synchroner Aufruf, der ein Dictionary-Objekt zurückgibt 

**Prozedurname : ::WS::Client::DoCall** 

**Beschreibung : Eine Operation eines Webdienstes aufrufen** 

**Argumente :** 

```
     serviceName     - Der Name des Webdienstes
     operationName   - Der Name der aufzurufenden Operation
     argList         - Die Argumente der Operation als Dictionary-Objekt
                       Das gilt für die Nachrichten von Soap-Header und Body.
     headers         - Zusätzliche Header für die HTTP-Anfrage. Das
                       ist ein Schlüssel-Wert-Listenargument. Es muss eine Liste mit
                       einer geraden Anzahl von Elementen sein, die abwechseln zwischen
                       Schlüsseln und Werten. Die Schlüssel werden zu Headerfeldnamen.
                       Zeilenumbrüche werden aus den Werten entfernt, damit der Header
                       nicht verfälscht werden kann.
                       Das ist ein optionales Argument und ist voreingestellt {}.
```

**Gibt zurück :** 

```
     Der Rückgabewert der Operation als Dictionary-Objekt.
       Das umfasst das Rückgabeergebnis und alle Rückgabeheader.
```

**Nebenwirkungen : Keine** 

**Ausnahmebedingungen :** 

```
     WSCLIENT HTTPERROR      - wenn ein HTTP-Fehler aufgetreten ist
     others                  - wie von der aufgerufenen Operation gemeldet
```

**Voraussetzungen : Der Dienst muss definiert worden sein.** 

---

## Asynchroner Aufruf mit getrennten Rückruffunktionen für Erfolg und Fehler 

**Prozedurname : ::WS::Client::DoAsyncCall** 

**Beschreibung : Eine Operation eines Webdienstes asynchron aufrufen** 

**Argumente :** 

```
     serviceName     - Der Name des Webdienstes
     operationName   - Der Name der aufzurufenden Operation
     argList         - Die Argumente der Operation als Dictionary-Objekt
                       Das gilt für die Nachrichten von Soap-Header und Body.
     succesCmd       - Ein Befehlspräfix, das aufgerufen wird, wenn die Operationen
                       keinen Fehler melden. Die Ergebnisse werden als Dictionary-
                       Objekt an das Präfix angehängt. Das umfasst
                       das Rückgabeergebnis und alle Rückgabeheader. Leer lassen,
                       damit keine Funktion aufgerufen wird.

     errorCmd        - Ein Befehlspräfix, das aufgerufen wird, wenn die Operationen
                       einen Fehler melden. Der Fehlercode, die Stapelverfolgung und
                       die Fehlermeldung werden an das Präfix angehängt. Leer lassen,
                       damit keine Funktion aufgerufen wird.
     headers         - Zusätzliche Header für die HTTP-Anfrage. Das
                       ist ein Schlüssel-Wert-Listenargument. Es muss eine Liste mit
                       einer geraden Anzahl von Elementen sein, die abwechseln zwischen
                       Schlüsseln und Werten. Die Schlüssel werden zu Headerfeldnamen.
                       Zeilenumbrüche werden aus den Werten entfernt, damit der Header
                       nicht verfälscht werden kann.
                       Das ist ein optionales Argument und ist voreingestellt {}.
```

**Gibt zurück : Nichts.** 

**Nebenwirkungen : Keine** 

**Ausnahmebedingungen :** 

```
     WSCLIENT HTTPERROR      - wenn ein HTTP-Fehler aufgetreten ist
     others                  - wie von der aufgerufenen Operation gemeldet
```

**Voraussetzungen : Der Dienst muss definiert worden sein.** 

---

## Erzeugen von Stub-Prozeduren in Tcl für synchrone Aufrufe 

**Prozedurname : ::WS::Client::CreateStubs** 

**Beschreibung : Stub-Routinen erzeugen, um Webdienst-Operationen aufzurufen.** 

```
             Alle Routinen werden in einem Namespace erzeugt, der gleich
             dem Dienstnamen ist. Der Prozedurname ist gleich
             dem Operationsnamen.
```

```
             HINWEIS -- Argumente des Webdienstes sind positionsunabhängig, deshalb
                     werden die Argumente der Prozedur in alphabetischer Reihenfolge definiert.
```

**Argumente :** 

```
     serviceName     - Der Dienst, für den Stubs erzeugt werden
```

**Gibt zurück : Eine Zeichenkette, die die erzeugten Prozeduren beschreibt.** 

**Nebenwirkungen : Der vorhandene Namespace wird gelöscht.** 

**Ausnahmebedingungen : Keine** 

**Voraussetzungen : Der Dienst muss definiert worden sein.** 

---

## Synchroner Aufruf, der das rohe XML zurückgibt 

**Prozedurname : ::WS::Client::DoRawCall** 

**Beschreibung : Eine Operation eines Webdienstes aufrufen** 

**Argumente :** 

```
     serviceName     - Der Name des Webdienstes
     operationName   - Der Name der aufzurufenden Operation
     argList         - Die Argumente der Operation als Dictionary-Objekt
                       Das gilt für die Nachrichten von Soap-Header und Body.
     headers         - Zusätzliche Header für die HTTP-Anfrage. Das
                       ist ein Schlüssel-Wert-Listenargument. Es muss eine Liste mit
                       einer geraden Anzahl von Elementen sein, die abwechseln zwischen
                       Schlüsseln und Werten. Die Schlüssel werden zu Headerfeldnamen.
                       Zeilenumbrüche werden aus den Werten entfernt, damit der Header
                       nicht verfälscht werden kann.
                       Das ist ein optionales Argument und ist voreingestellt {}.
```

**Gibt zurück :** 

```
     Das XML der Operation.
```

**Nebenwirkungen : Keine** 

**Ausnahmebedingungen :** 

```
     WSCLIENT HTTPERROR      - wenn ein HTTP-Fehler aufgetreten ist
```

**Voraussetzungen : Der Dienst muss definiert worden sein.** 

---

## Ein Vorlagen-Dictionary erzeugen

**Prozedurname : ::WS::Utils::GenerateTemplateDict** 

**Beschreibung : Ein Vorlagen-Dictionary-Objekt für einen gegebenen Typ erzeugen.** 

**Argumente :** 

```
     mode            - Der Modus, Client oder Server
     serviceName     - Der Name des Webdienstes
     type            - Der Name des Typs
     arraySize       - Anzahl der Elemente, die in einem Array erzeugt werden. Vorgabe ist 2
```

**Gibt zurück :** 

```
Ein Dictionary-Objekt für einen gegebenen Typ. Wenn zyklische Verweise vorkommen, haben sie den Wert <** Circular Reference **>
Nebenwirkungen : Keine 
Ausnahmebedingungen : Keine 
Voraussetzungen : Der Dienst muss definiert worden sein. 
```

---

## Einen Dienst konfigurieren 

Es gibt zwei Prozeduren, um einen Dienst zu konfigurieren:

- ::WS::Client::SetOption
- ::WS::Client::Config

Die erste Prozedur enthält die Vorgabeoptionen des Pakets. Die Vorgabeoptionen werden beim Erzeugen des Dienstes verwendet und dann in den Dienst kopiert.

Die zweite Prozedur enthält die Optionen jedes Dienstes. Sie werden beim Erzeugen des Dienstes aus den Vorgabeoptionen kopiert.

Die meisten Optionseinträge sind über beide Funktionen erreichbar. Einige Optionen werden nur in der Phase des Erzeugens verwendet und existieren nicht als Dienstoption. Andere Optionen existieren nicht als Vorgabeoption, weil sie aus der WSDL-Datei initialisiert werden.

Im Folgenden werden zuerst die beiden Zugriffsroutinen beschrieben. Danach folgt eine Liste der Optionen für beide Funktionen, mit Hinweisen, wenn sie nur für eine der beiden Prozeduren gelten.

**Prozedurname : ::WS::Client::SetOption** 

**Beschreibung : Die Vorgabeoptionen des Pakets abfragen oder setzen** 

**Argumente :** 

```
     -globalonly   - Gibt eine Liste der nur globalen Optionen und ihrer Werte zurück.
                     Nur globale Optionen werden nicht in den Dienst kopiert.
     -defaultonly  - Gibt eine Liste der nur als Vorgabe geltenden Optionen und ihrer Werte zurück.
                     Nur als Vorgabe geltende Optionen werden in den Dienst kopiert.
     --            - Ende der Optionen
     item          - Der Optionseintrag, der abgefragt oder konfiguriert wird.
                     Gibt eine Liste aller Paare aus Eintrag und Wert zurück, wenn er weggelassen wird. 
     value         - Der Wert, auf den der Optionseintrag gesetzt wird.
                     Gibt den aktuellen Wert zurück, wenn er weggelassen wird.
```

**Prozedurname : ::WS::Client::Config** 

**Beschreibung : Die Optionen abfragen oder setzen, die zu einer Dienstdefinition gehören** 

**Argumente :** 

```
     serviceName - Der Name des Webdienstes.
                   Gibt eine Liste der Vorgabepaare aus Eintrag und Wert zurück, wenn er nicht angegeben ist.
     item        - Der Optionseintrag, der abgefragt oder konfiguriert wird.
                   Gibt eine Liste aller Paare aus Eintrag und Wert zurück, wenn er nicht angegeben ist. 
     value       - Der Wert, auf den der Optionseintrag gesetzt wird.
                   Gibt den aktuellen Wert zurück, wenn er weggelassen wird.
```

**Optionsliste:** 

- 

  ```
  allowOperOverloading
  ```

  Eine überladene Operation ist eine Operation mit demselben Namen, die mit unterschiedlichen Sätzen von Eingabeparametern vorkommen kann.

  Diese Option meldet einen Fehler, wenn eine WSDL mit einer überladenen Operation zerlegt wird.

  Vorgabe: 1

- 

  ```
  contentType
  ```

  Der HTTP-Inhaltstyp der HTTP-Anfrage, die zum Aufruf des Webdienstes gesendet wird.  
   Vorgabe: "text/xml;charset=utf-8"

- 

  ```
  errorOnRedefine
  ```

  Meldet einen Fehler, wenn ein Dienst (CreateService und so weiter) für einen bereits vorhandenen Dienst erzeugt wird.

  Vorgabewert: 0

  Dieser Eintrag darf nicht mit *::WS::Client::Config* verwendet werden.

- 

  ```
  genOutAttr
  ```

  erzeugt Attribute an ausgehenden Tags, Einzelheiten stehen [hier](Using_Options.md#genoutattr-attribute-an-ausgehenden-tags-erzeugen)

- 

  ```
  inlineElementNS
  ```

  Namespace-Präfixe für Typen können im Wurzelelement der WSDL definiert sein.

  Dieser Eintrag darf nicht mit *::WS::Client::Config* verwendet werden.

  Diese Option einschalten, damit Namespace-Präfixe auch in der Typdefinition gesucht werden. Weil sie als globale Präfixe gelten, kann ein doppelt verwendetes Präfix einen Verarbeitungsfehler verursachen, wenn unterschiedliche URIs zugewiesen sind.

  Den Fehler würde eine WSDL wie folgt verursachen

  ```
  	<wsdl:definitions targetNamespace="http://www.webserviceX.NET/"
          xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/
  		xmlns:q1="myURI1"
  		...>
  	    ...
  	    <xs:element xmlns:q1="myURI2" type="q1:MessageQ1"/>
  ```

- 

  ```
  location
  ```

  Die URL des Dienstes. Sie wird mit dem Wert aus der WSDL-Datei initialisiert, wenn die WSDL-Datei zerlegt wird. Der Wert kann durch Setzen dieser Option überschrieben werden.

  Dieser Eintrag darf nicht mit *::WS::Client::SetOption* verwendet werden.

- 

  ```
  noTargetNs
  ```

  Die URI des Ziel-Namespace steht im Envelope des Webdienst-Aufrufs normalerweise zweimal:  

  ```
  <SOAP-ENV:Envelope
  	...
  	xmlns="http://targeturi.org/"
  	xmlns:tns1="http://targeturi.org/"
  	...>
  ```

  Wird diese Option auf 1 gesetzt, entfällt die Zeile mit "xmlns=".   
  Diese Option wurde gesetzt, um einen von SAP veröffentlichten Dienst aufzurufen.   
  Vorgabewert: 0

- 

  ```
  nsOnChangeOnly
  ```

  setzt das Namespace-Präfix nur, wenn sich Namespaces ändern

- 

  ```
  parseInAttr
  ```

  zerlegt Attribute an eingehenden Tags, Einzelheiten stehen [hier](Using_Options.md#parseinattr-attribute-an-eingehenden-tags-zerlegen)

- 

  ```
  queryTimeout
  ```

  Zeitlimit für jede Netzabfrage in ms. Vorgabewert: 60000 (1 Minute). Das [Hilfspaket](Using_Options.md#querytimeout-zeitlimit-f-r-http-s-abfragen-setzen) hat eine Option mit derselben Funktion, die verwendet wird, wenn kein Kontext einer Aufrufoption vorliegt.

- 

  ```
  skipHeaderLevel
  ```

  boolescher Wert, der angibt, dass die erste Ebene des XML in einem Anfrageheader *übersprungen werden soll*. Abgeleitet aus den Optionen. Vorgabe ist 0 (nicht überspringen). *(Eingeführt in 2.2.8)*

- 

  ```
  skipLevelOnReply
  ```

  boolescher Wert, der angibt, dass die erste Ebene des XML in einer Antwort *übersprungen werden darf*. Abgeleitet aus den Optionen. Vorgabe ist 0 (nicht überspringen). *(Eingeführt in 2.2.8)*

- 

  ```
  skipLevelWhenActionPresent
  ```

  boolescher Wert, der angibt, ob die erste Ebene des XML übersprungen wird. Abgeleitet aus den Optionen. Vorgabe ist 0 (nicht überspringen).

- 

  ```
  suppressNS (default: empty string)
  ```

  ein bestimmtes Namespace-Präfix nicht setzen

- 

  ```
  suppressTargetNS
  ```

  Das URI-Präfix "tns1" des Ziel-Namespace nicht an alle Parameter im XML des Webdienst-Aufrufs anhängen.

  Als Beispiel wird das XML geändert von (Option nicht gesetzt): 

  ```
  <SOAP-ENV:Envelope ...
      xmlns:tns1="http://targeturi.org/"
      ... >
    <SOAP-ENV:Body>
      <tns1:CalledMethod>
        <tns1:Parameter1>Value;/tns1:Parameter1>
      </tns1:CalledMethod>
    </SOAP-ENV:Body>
  </SOAP-ENV:Envelope>
  ```

  zu (Option gesetzt)

  ```
  <SOAP-ENV:Envelope ...
      xmlns:tns1="http://targeturi.org/"
      ... >
  <SOAP-ENV:Envelope ...
    <SOAP-ENV:Body>
      <tns1:CalledMethod>
        <Parameter1>Value;/Parameter1>
      </tns1:CalledMethod>
    </SOAP-ENV:Body>
  </SOAP-ENV:Envelope>
  ```

  Abgeleitet aus den Optionen.   
  Intern setzt diese Option die Option "suppressNS" auf "tns1".   
  Diese Option wurde gesetzt, um einen von SAP veröffentlichten Dienst aufzurufen.   
  Diese Option ließ einen Aufruf eines bestimmten MS-Webdienstes mit der Fehlermeldung scheitern: "Input parameter 'Parameter1' can not be NULL or Empty.".   
  Vorgabe ist 0 (nicht unterdrücken).

- 

  ```
  targetNamespace (default: empty string)
  ```

  der Ziel-Namespace des Dienstes, abgeleitet aus der WSDL.

  Dieser Eintrag darf nicht mit *::WS::Client::SetOption* verwendet werden.

- 

  ```
  UseNS (default: empty string)
  ```

  Siehe [hier](Using_Options.md#usens-namespaces-an-feld-tags-setzen)

- 

  ```
  useTypeNS (default: empty string)
  ```

  das Namespace-Präfix des Typs als Präfix der Elemente verwenden

- 

  ```
  valueAttrCompatiblityMode (default: 1)
  ```

  Wenn dies und genOutAttr/parseInAttr gesetzt sind, werden Werte im Dictionary als {} angegeben. Wenn dagegen genOutAttr/parseInAttr gesetzt ist und dies nicht gesetzt ist, werden die Werte im Dictionary als ::value angegeben.


```
     value         - Optional, der neue Wert.
```

**Gibt zurück :** 

```
     Der Wert des Eintrags.
Nebenwirkungen : Keine 
Ausnahmebedingungen : Keine 
Voraussetzungen : Der Dienst muss definiert worden sein. 
```

## Abstrakte Typen in konkrete Typen umwandeln 

 Wenn *parseInAttr* und *genOutAttr* eingeschaltet sind, behandelt das System halbautomatisch die Umwandlung von Elementen, die als Typ deklariert sind, der ein abstrakter Typ ist, in den konkreten Typ, der in einer Nachricht tatsächlich verwendet wird, und zurück. Bei einem Element, das als Typ deklariert ist, der ein abstrakter Typ ist, gibt der Wert des Schlüssels **::type** im Dictionary den konkreten Typ an, der tatsächlich verwendet werden soll (oder bei einer Antwortnachricht den konkreten Typ, der tatsächlich verwendet wurde). 

 **HINWEIS:** In der WSDL muss der konkrete Typ eine Erweiterung des abstrakten Typs sein, das Paket erzwingt diese Einschränkung jedoch nicht, deshalb ist Vorsicht geboten.
