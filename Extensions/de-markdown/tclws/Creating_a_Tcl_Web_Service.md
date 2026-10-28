# Einen Tcl-Webdienst erzeugen

## Inhalt

- [1 Das Paket Webservices Server laden](#das-paket-webservices-server-laden) 
- [2 Einen Dienst definieren](#einen-dienst-definieren) 
- [3 Eine Operation definieren (auch eine Dienstprozedur)](#eine-operation-definieren-auch-eine-dienstprozedur) 
- [4 Komplexe Typen deklarieren](#komplexe-typen-deklarieren) 

## Das Paket Webservices Server laden

Das Serverpaket für Webservices wird so geladen:

```
 package require WS::Server
```

Dieser Befehl lädt den Server nur beim ersten Mal, es schadet also nicht, ihn in jede Datei zu setzen, die einen Dienst oder eine Dienstprozedur deklariert.

### Verwendung als Teil von TclHttpd

Das Paket Web Services, WS::Server, ist keine eigenständige Anwendung, sondern als „Modul“ von TclHttpd gedacht. Der folgende Befehl steht gewöhnlich in httpdthread.tcl:

### Einbetten in eine eigenständige Anwendung

Um einen Webdienst in eine Anwendung einzubetten, muss die Anwendung ereignisgesteuert sein, und das Paket **WS::Embeded** wird gebraucht. Der Dienst muss außerdem mit der Option *-mode=embedded* definiert werden.

Siehe auch [Einen Webdienst in eine Anwendung einbetten](Embedded_Web_Service.md).

### Verwendung mit Apache Rivet

[Apache Rivet](http://tcl.apache.org/rivet/) ist ein Modul (mod_rivet), das der Apache-httpd-Server laden kann, damit Webseiten eingebettete Tcl-Befehle ausführen, ähnlich wie PHP. Um einen Webdienst in Rivet zu erzeugen, dient das Beispiel EchoRivetService.rvt als Ausgangspunkt: es wird einfach in ein Verzeichnis kopiert, das die Apache-Instanz ausliefert. Der neue Ort sollte sofort unter den folgenden URLs erreichbar sein:

```
               /path/to/EchoRivetService.rvt/doc
                     Zeigt eine HTML-Seite, die den Dienst beschreibt
               /path/to/EchoRivetService.rvt/wsdl
                     Gibt eine WSDL zurück, die den Dienst beschreibt
               /path/to/EchoRivetService.rvt/op
                     Ruft eine Operation auf
```

Wenn die veröffentlichten URLs des Dienstes anders erscheinen sollen, können die Standardmodule Apache mod_rewrite oder mod_alias jede andere URL transparent auf diese Orte abbilden.

---

## Einen Dienst definieren

Der Code, der einen Dienst definiert, steht gewöhnlich in einer oder mehreren Dateien im Verzeichnis custom.

**Prozedurname : ::WS::Server::Service**

**Beschreibung** : Einen Webdienst deklarieren, die folgenden URLs werden existieren

```
               /service/<ServiceName>
                     Zeigt eine HTML-Seite, die den Dienst beschreibt
               /service/<ServiceName>/wsdl
                     Gibt eine WSDL zurück, die den Dienst beschreibt
               /service/<ServiceName>/op
                     Ruft eine Operation auf
```

**Argumente** : diese Prozedur verwendet positionsunabhängige Argumente, und zwar:

```
             -hostcompatibility32 bool - Aktiviert den Kompatibilitätsmodus
                               der Version 3.2.0 für den Parameter -host.
                               Voreingestellt ist true.
             -host           - Die Host-Angabe innerhalb der XML-Namespaces
                               der übertragenen XML-Dateien.
                               Sie sollte eindeutig sein.
                               Voreingestellt ist localhost.
                               Wenn die Kompatibilität 3.2 aktiv ist, ändert sich
                               der Vorgabewert im eingebetteten Modus zu ip:port.
             -hostlocation   - Der Hostname, der in der erzeugten
                               WSDL-Datei bekanntgegeben wird. Voreingestellt ist localhost.
                               Wenn die Kompatibilität 3.2 aktiv ist, ist
                               der Vorgabewert gleich dem Parameter -host.
             -hostlocationserver bool - Wenn true, setzt der aktuelle Server
                               die Host-Lage.
                               Bei einem httpd-Server wird dieser Wert importiert.
                               Bei anderen Servern oder wenn das scheitert, ist der Wert
                               das aktuelle ip:port.
                               Der Vorgabewert ist true.
                               Bei Kompatibilität 3.2 ist der Vorgabewert
                               für tclhttpd true, sonst false.
             -hostProtocol   - Legt das Host-Protokoll (http, https) für die
                               URL der WSDL-Lage fest. Der besondere Wert „server“
                               (Vorgabe) folgt der Angabe des TCP/IP-Servers.
                               Das ist für den eingebetteten Server und tclhttpd umgesetzt.
                               Das Protokoll für XML-Namespaces
                               ist immer „http“.
             -description    - Die HTML-Beschreibung für diesen Dienst
             -htmlhead       - Die Titelzeichenkette der Dienstbeschreibung
             -author         - Die Autoreneigenschaft in der Dienstbeschreibung
             -xmlnamespace   - Zusätzliche XML-Namespaces, die der Dienst verwendet
             -service        - Der Dienstname (er wird auch für
                                 den Tcl-Namespace der Prozeduren verwendet, die
                                 die Operationen umsetzen.
             -premonitor     - Das ist ein Befehlspräfix, das aufgerufen wird, bevor
                                 eine Operation aufgerufen wird. Die folgenden Argumente werden
                                 dem Befehlspräfix hinzugefügt:
                                    PRE serviceName operationName operArgList
             -postmonitor    - Das ist ein Befehlspräfix, das aufgerufen wird, nachdem
                                 eine Operation aufgerufen wurde. Die folgenden Argumente werden
                                 dem Befehlspräfix hinzugefügt:
                                    POST serviceName operationName OK|ERROR results
             -inheaders      - Liste der Typen von Eingabeheadern.
             -outheaders     - Liste der Typen von Ausgabeheadern.
             -intransform    - Transformation für eingehende Anforderungen (2.0.3 und später).
                                Die Signatur des Befehls muss sein:
                                     cmd \
                                         mode (REQUEST) \
                                         xml \
                                         notUsed_1 \
                                         notUsed_2
             -outtransform   - Transformation für ausgehende Antworten (2.0.3 und später).
                                Die Signatur des Befehls muss sein:
                                     cmd \
                                         mode (REPLY) \
                                         xml \
                                         operation \
                                         resultDict
             -checkheader    - Befehlspräfix, um Header zu prüfen.
                                   Wenn der Aufruf nicht erlaubt sein soll, sollte dieser Befehl
                                   einen Fehler melden.
                                   Die Signatur des Befehls muss sein:
                                     cmd \
                                         service \
                                         operation \
                                         caller_ipaddr \
                                         http_header_list \
                                         soap_header_list
            -mode           - Modus, in dem der Dienst läuft. Muss einer der folgenden sein:
                                   tclhttpd  -- läuft innerhalb von tclhttpd oder einer
                                                Umgebung, die passende Befehle
                                                Url_PrefixInstall
                                                und Httpd_ReturnData bereitstellt
                                   embedded  -- verwendet das Paket ::WS::Embedded
                                   aolserver -- verwendet das Paket ::WS::AolServer
                                   wub       -- verwendet das Paket ::WS::Wub
                                   wibble    -- läuft innerhalb von wibble
                                   rivet     -- läuft innerhalb von Apache Rivet (mod_rivet)
            -ports          - Liste der Ports für den eingebetteten Modus. Vorgabe: 80
                                    HINWEIS -- für jeden Port in dieser Liste sollte
                                            ::WS::Embedded::Listen aufgerufen werden,
                                            bevor ::WS::Embeded::Start aufgerufen wird
            -prefix         - Pfadpräfix für den Namespace und den Endpunkt
                              Voreingestellt ist „/service/“ plus der Dienstname
            -traceEnabled   - Boolescher Wert, der steuert, ob ein Trace in der Ausnahme zurückgegeben wird
                              Voreingestellt ist „Y“
            -docFormat      - Format der Dokumentation für Operationen („text“ oder „html“).
                              Voreingestellt ist „text“
            -stylesheet     - Die URL des CSS-Stylesheets in der HTML-Dokumentation

            -errorCallback  - Rückruffunktion, die aufgerufen wird, wenn ein Fehler entsteht
            -verifyUserArgs - Boolescher Wert, der die Prüfung der vom Benutzer gelieferten Argumente steuert
                              Voreingestellt ist „N“
            -enforceRequired - Meldet einen Fehler, wenn ein Pflichtfeld in der
                               Antwort fehlt.
                               Voreingestellt ist „N“
```

**Gibt zurück** : Nichts

**Nebenwirkungen** : Keine

**Ausnahmebedingungen** :

```
     MISSREQARG -- Fehlende Pflichtargumente
```

**Voraussetzungen** : Keine

---

## Eine Operation definieren (auch eine Dienstprozedur)

**Prozedurname : ::WS::Server::ServiceProc**

**Beschreibung** : Eine Operation für einen Dienst registrieren und die Prozedur deklarieren, die die Operationen behandelt.

**Argumente** :

```
     ServiceName     -- Name des Dienstes, zu dem diese Operation gehört
     NameInfo        -- Liste aus zwei Elementen:
                             1) OperationName -- der Name der Operation
                             2) ReturnType    -- der Typ der Rückgabe der Prozedur,
                                                 das kann ein einfacher oder komplexer Typ sein
     Arglist         -- Liste von Argumentdefinitionen,
                         jedes Listenelement muss die Form haben:
                             1) ArgumentName -- der Name des Arguments
                             2) ArgumentTypeInfo -- -- Eine Liste aus:
                                    {type typeName comment commentString}
                                         typeName kann jeder einfache oder definierte Typ sein.
                                         commentString ist eine Zeichenkette in Anführungszeichen, die das Feld beschreibt
     Documentation   -- HTML, das beschreibt, was diese Operation tut
     Body            -- Der Tcl-Code, der aufgerufen wird, wenn die Operation aufgerufen wird. Dieser
                            Code sollte ein Dictionary zurückgeben, mit <OperationName>Result als
                            Schlüssel und dem Ergebnis der Operation als Wert.
```

Verfügbare einfache Typen sind:

- anyType, string, boolean, decimal, float, double, duration, dateTime, time, date, gYearMonth, gYear, gMonthDay, gDay, gMonth, hexBinary, base64Binary, anyURI, QName, NOTATION, normalizedString, token, language, NMTOKEN, NMTOKENS, Name, NCName, ID, IDREF, IDREFS, ENTITY, ENTITIES, integer, nonPositiveInteger, negativeInteger, long, int, short, byte, nonNegativeInteger, unsignedLong, unsignedInt, unsignedShort, unsignedByte, positiveInteger

Das

typeName

darf die folgenden Suffixe enthalten:

- *()* : der Typ ist ein Array
- *?* : der Typ ist ein optionaler Parameter

**Gibt zurück** : Nichts

*Nebenwirkungen* :

```
   Eine Prozedur namens "<ServiceName>::<OperationName>" ist definiert
   Ein Typname mit dem Namen <OperationName>Result ist definiert.
```

*Ausnahmebedingungen* : Keine

*Voraussetzungen* : ::WS::Server::Server muss für den ServiceName aufgerufen worden sein

---

## Komplexe Typen deklarieren

Siehe: [Einen Webdienst-Typ aus Tcl erzeugen](Creating_a_Web_Service_Type.md)
