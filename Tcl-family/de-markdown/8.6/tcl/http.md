---
CommandName: http
ManualSection: n
Version: 2.9
TclPart: http
TclDescription: Tcl Bundled Packages
Links:
 - safe(n)
 - socket(n)
 - safesock(n)
Keywords:
 - internet
 - security policy
 - socket
 - www
Copyright:
 - Copyright (c) 1995-1997 Sun Microsystems, Inc.
 - Copyright (c) 1998-2000 Ajuba Solutions.
 - Copyright (c) 2004 ActiveState Corporation.
---

# NAME

http - Clientseitige Implementierung des HTTP/1.1-Protokolls

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [http]{.lit} [2.9]{.optlit} 
[::http::config]{.cmd} [-option value]{.optdot} 
[::http::geturl]{.cmd} [url]{.arg} [-option value]{.optdot} 
[::http::formatQuery]{.cmd} [key]{.arg} [value]{.arg} [key value]{.optdot} 
[::http::quoteString]{.cmd} [value]{.arg} 
[::http::reset]{.cmd} [token]{.arg} [why]{.optarg} 
[::http::wait]{.cmd} [token]{.arg} 
[::http::status]{.cmd} [token]{.arg} 
[::http::size]{.cmd} [token]{.arg} 
[::http::code]{.cmd} [token]{.arg} 
[::http::ncode]{.cmd} [token]{.arg} 
[::http::meta]{.cmd} [token]{.arg} 
[::http::data]{.cmd} [token]{.arg} 
[::http::error]{.cmd} [token]{.arg} 
[::http::cleanup]{.cmd} [token]{.arg} 
[::http::register]{.cmd} [proto]{.arg} [port]{.arg} [command]{.arg} 
[::http::registerError]{.cmd} [port]{.arg} [message]{.optarg} 
[::http::unregister]{.cmd} [proto]{.arg} 
:::

# EXPORTIERTE BEFEHLE

Der Namespace **http** exportiert die Befehle **config**, **formatQuery**, **geturl**, **quoteString**, **register**, **registerError**, **reset**, **unregister** und **wait**.

Er exportiert die Befehle **cleanup**, **code**, **data**, **error**, **meta**, **ncode**, **size** und **status** nicht.

# BESCHREIBUNG

Das Paket **http** stellt die Client-Seite des HTTP/1.1-Protokolls bereit, wie in RFC 7230 bis RFC 7235 definiert, die RFC 2616 ersetzen. Das Paket implementiert die HTTP/1.1-Operationen GET, POST und HEAD. Es erlaubt die Konfiguration eines Proxy-Hosts, um Firewalls zu passieren. Das Paket ist mit der **Safesock**-Sicherheitsrichtlinie kompatibel und kann daher von nicht vertrauenswuerdigen Applets verwendet werden, um URLs von einer eingeschraenkten Menge von Hosts abzurufen. Dieses Paket kann erweitert werden, um zusaetzliche HTTP-Transportprotokolle wie HTTPS zu unterstuetzen, indem ueber **::http::register** ein eigener **socket**-Befehl bereitgestellt wird.

Die Prozedur **::http::geturl** fuehrt eine HTTP-Transaktion aus. Ihre *Optionen* bestimmen, ob eine GET-, POST- oder HEAD-Transaktion ausgefuehrt wird. Der Rueckgabewert von **::http::geturl** ist ein Token fuer die Transaktion. Dieser Wert ist zugleich der Name eines Arrays im Namespace ::http, das Zustandsinformationen zur Transaktion enthaelt. Die Elemente dieses Arrays werden im Abschnitt **ZUSTANDS-ARRAY** beschrieben.

Wenn die Option **-command** angegeben ist, wird die HTTP-Operation im Hintergrund ausgefuehrt. **::http::geturl** kehrt direkt nach dem Erzeugen der HTTP-Anfrage zurueck, und der Callback wird aufgerufen, wenn die Transaktion abgeschlossen ist. Damit dies funktioniert, muss die Tcl-Ereignisschleife aktiv sein. In Tk-Anwendungen ist das immer der Fall. In reinen Tcl-Anwendungen kann der Aufrufer nach dem Aufruf von **::http::geturl** **::http::wait** verwenden, um die Ereignisschleife zu starten.

**Hinweis:** Die Ereigniswarteschlange wird auch ohne die Option **-command** verwendet. Als Nebeneffekt koennen waehrend der Ausfuehrung von **http::geturl** beliebige Befehle verarbeitet werden.

# BEFEHLE

**::http::config** ?*options*?
: Der Befehl **::http::config** dient zum Setzen und Abfragen des Namens und Ports des Proxy-Servers sowie des User-Agent-Namens, der in HTTP-Anfragen verwendet wird. Wenn keine Optionen angegeben werden, wird die aktuelle Konfiguration zurueckgegeben. Wenn ein einzelnes Argument angegeben wird, muss es eines der unten beschriebenen Flags sein. In diesem Fall wird der aktuelle Wert dieser Einstellung zurueckgegeben. Andernfalls sollten die Optionen eine Menge aus Flags und Werten sein, die die Konfiguration festlegen:

**-accept** *mimetypes*
: Der Accept-Header der Anfrage. Der Standardwert ist \*/\*, was bedeutet, dass alle Dokumenttypen akzeptiert werden. Andernfalls koennen Sie eine durch Kommata getrennte Liste von Mime-Type-Mustern angeben, die Sie empfangen moechten. Zum Beispiel

**-pipeline** *boolean*
: Legt fest, ob HTTP/1.1-Transaktionen auf einem persistenten Socket per Pipelining ausgefuehrt werden. Details finden Sie im Abschnitt **PERSISTENTE VERBINDUNGEN**. Der Standardwert ist 1.

**-postfresh** *boolean*
: Legt fest, ob Anfragen mit der Methode **POST** immer einen frischen Socket verwenden und damit die Option **-keepalive** des Befehls **http::geturl** uebersteuern. Details finden Sie im Abschnitt **PERSISTENTE VERBINDUNGEN**. Der Standardwert ist 0.

**-proxyhost** *hostname*
: Der Name des Proxy-Hosts, falls vorhanden. Wenn dieser Wert die leere Zeichenkette ist, wird der URL-Host direkt kontaktiert.

**-proxyport** *number*
: Die Proxy-Portnummer.

**-proxyfilter** *command*
: Der Befehl ist ein Callback, der waehrend **::http::geturl** aufgerufen wird, um zu bestimmen, ob fuer einen bestimmten Host ein Proxy erforderlich ist. Beim Aufruf wird ein Argument, ein Hostname, an *command* angehaengt. Falls ein Proxy erforderlich ist, sollte der Callback eine Liste mit zwei Elementen zurueckgeben, die Proxy-Server und Proxy-Port enthaelt. Andernfalls sollte der Filter eine leere Liste zurueckgeben. Der Standardfilter gibt die Werte der Einstellungen **-proxyhost** und **-proxyport** zurueck, falls diese nicht leer sind.

Der Befehl **::http::geturl** fuehrt den Callback **-proxyfilter** innerhalb eines **catch**-Befehls aus. Deshalb ruft ein Fehler im Callback-Befehl den Handler **bgerror** nicht auf. Details finden Sie im Abschnitt **FEHLER**.

**-repost** *boolean*
: Legt fest, was geschehen soll, wenn eine POST-Anfrage ueber eine persistente Verbindung fehlschlaegt, weil der Server die Verbindung halb geschlossen hat. Bei booleschem Wert **true** wird die Anfrage automatisch erneut versucht; bei booleschem Wert **false** nicht. Dann wird erwartet, dass die Anwendung, die **http::geturl** verwendet, vor einem erneuten POST eine Bestaetigung vom Benutzer einholt. Der Wert **true** sollte nur unter bestimmten Bedingungen verwendet werden. Details finden Sie im Abschnitt **PERSISTENTE VERBINDUNGEN**. Der Standardwert ist 0.

**-urlencoding** *encoding*
: Die *Kodierung*, die zum Erstellen von x-url-kodierten URLs mit **::http::formatQuery** und **::http::quoteString** verwendet wird. Der Standardwert ist **utf-8**, wie in RFC 2718 angegeben. Vor http 2.5 war dies nicht festgelegt; dieses Verhalten kann durch Angabe der leeren Zeichenkette (**{}**) wiederhergestellt werden, obwohl *iso8859-1* empfohlen wird, um ein aehnliches Verhalten wiederherzustellen, aber ohne dass **::http::formatQuery** oder **::http::quoteString** beim Verarbeiten von Zeichen ausserhalb von Latin-1 einen Fehler werfen.

**-useragent** *string*
: Der Wert des User-Agent-Headers in der HTTP-Anfrage. In einem unsicheren Interpreter haengt der Standardwert vom Betriebssystem sowie von den Versionsnummern von **http** und **Tcl** ab und ist (zum Beispiel)

Ein sicherer Interpreter kann sein Betriebssystem nicht bestimmen, daher besteht der Standardwert in einem sicheren Interpreter aus einem Windows-10-Wert mit den aktuellen Versionsnummern von **http** und **Tcl**.

**-zip** *boolean*
: Wenn der Wert boolesch **true** ist, senden Anfragen standardmaessig einen Header

Wenn der Wert boolesch **false** ist, wird dieser Header standardmaessig nicht gesendet. In beiden Faellen kann der Standard fuer eine einzelne Anfrage ueberschrieben werden, indem in der Option **-headers** von **http::geturl** ein benutzerdefinierter **Accept-Encoding**-Header angegeben wird. Der Standardwert ist 1.

**::http::geturl** *url* ?*options*?
: Der Befehl **::http::geturl** ist die Hauptprozedur im Paket. Die Option **-query** bewirkt eine POST-Operation und die Option **-validate** bewirkt eine HEAD-Operation; andernfalls wird eine GET-Operation ausgefuehrt. Der Befehl **::http::geturl** gibt einen *token*-Wert zurueck, der verwendet werden kann, um Informationen ueber die Transaktion abzurufen. Details finden Sie in den Abschnitten **ZUSTANDS-ARRAY** und **FEHLER**. Der Befehl **::http::geturl** blockiert, bis die Operation abgeschlossen ist, es sei denn, die Option **-command** gibt einen Callback an, der nach Abschluss der HTTP-Transaktion aufgerufen wird. **::http::geturl** unterstuetzt mehrere Optionen:

**-binary** *boolean*
: Legt fest, ob die URL-Daten zwangsweise als binaer interpretiert werden. Normalerweise wird dies automatisch erkannt (alles, was nicht mit einem **text**-Inhaltstyp beginnt oder dessen Inhaltskodierung **gzip** oder **compress** ist, wird als binaere Daten betrachtet).

**-blocksize** *size*
: Die Blockgroesse beim Lesen der URL. Pro Schritt werden hoechstens *size* Byte gelesen. Nach jedem Block wird ein Aufruf des Callbacks **-progress** ausgefuehrt (falls diese Option angegeben wurde).

**-channel** *name*
: Kopiert den URL-Inhalt in den Kanal *name*, anstatt ihn in **state(body)** zu speichern.

**-command** *callback*
: Ruft *callback* auf, nachdem die HTTP-Transaktion abgeschlossen ist. Diese Option bewirkt, dass **::http::geturl** sofort zurueckkehrt. *callback* erhaelt ein zusaetzliches Argument, naemlich den von **::http::geturl** zurueckgegebenen *token*. Dieser Token ist der Name eines Arrays, das im Abschnitt **ZUSTANDS-ARRAY** beschrieben ist. Hier ist eine Vorlage fuer den Callback:

```
proc httpCallback {token} {
    upvar #0 $token state
    # Zugriff auf state als Tcl-Array
}
```

Der Befehl **::http::geturl** fuehrt den Callback **-command** innerhalb eines **catch**-Befehls aus. Deshalb ruft ein Fehler im Callback-Befehl den Handler **bgerror** nicht auf. Details finden Sie im Abschnitt **FEHLER**.

**-handler** *callback*
: Ruft *callback* auf, sobald HTTP-Daten verfuegbar sind; falls angegeben, werden die HTTP-Daten sonst nicht weiter verarbeitet. Diese Prozedur erhaelt zwei zusaetzliche Argumente: den Socket fuer die HTTP-Daten und den von **::http::geturl** zurueckgegebenen *token*. Der Token ist der Name eines globalen Arrays, das im Abschnitt **ZUSTANDS-ARRAY** beschrieben ist. Von der Prozedur wird erwartet, dass sie die Anzahl der vom Socket gelesenen Bytes zurueckgibt. Hier ist eine Vorlage fuer den Callback:

```
proc httpHandlerCallback {socket token} {
    upvar #0 $token state
    # Zugriff auf Socket und state als Tcl-Array
    # Zum Beispiel...
    ...
    set data [read $socket 1000]
    set nbytes [string length $data]
    ...
    return $nbytes
}
```

Der **http::geturl**-Code fuer die Option **-handler** ist weder mit Kompression noch mit chunked transfer-encoding kompatibel. Wenn **-handler** angegeben ist, stuft **http::geturl** das HTTP-Protokoll als Workaround auf 1.0 herunter und ueberschreibt die Option **-zip** (d. h., es sendet den Header \"**Accept-Encoding: gzip,deflate,compress**\" nicht).

Wenn die Optionen **-handler** und **-channel** zusammen verwendet werden, ist der Handler dafuer verantwortlich, die Daten vom HTTP-Socket in den angegebenen Kanal zu kopieren. Der Name des Kanals steht dem Handler als Element **-channel** des Token-Arrays zur Verfuegung.

Der Befehl **::http::geturl** fuehrt den Callback **-handler** innerhalb eines **catch**-Befehls aus. Deshalb ruft ein Fehler im Callback-Befehl den Handler **bgerror** nicht auf. Details finden Sie im Abschnitt **FEHLER**.

**-headers** *keyvaluelist*
: Diese Option wird verwendet, um Header zur HTTP-Anfrage hinzuzufuegen, die nicht bereits durch **::http::config** angegeben wurden. Das Argument *keyvaluelist* muss eine Liste mit gerader Elementanzahl sein, deren Elemente zwischen Schluesseln und Werten abwechseln. Die Schluessel werden zu Header-Feldnamen. Zeilenumbrueche werden aus den Werten entfernt, damit der Header nicht beschaedigt werden kann. Wenn *keyvaluelist* z. B. **Pragma no-cache** ist, wird folgender Header in die HTTP-Anfrage aufgenommen:

```
Pragma: no-cache
```

**-keepalive** *boolean*
: Wenn boolesch **true**, wird versucht, die Verbindung fuer mehrere Anfragen offen zu halten. Standard ist 0.

**-method** *type*
: Erzwingt die HTTP-Anfragemethode *type*. **::http::geturl** waehlt basierend auf anderen Optionen automatisch GET, POST oder HEAD, aber diese Option ueberschreibt die Auswahl und erlaubt fuer WebDAV auch Optionen wie PUT und DELETE.

Es liegt in der Verantwortung des Aufrufers sicherzustellen, dass Header und Request-Body (falls vorhanden) den Anforderungen der Anfragemethode entsprechen. Wenn z. B. mit **-method** *POST* ein POST mit leerem Request-Body gesendet wird, muss der Aufrufer ausserdem die Option

**-myaddr** *address*
: Uebergibt bei mehreren verfuegbaren Schnittstellen eine bestimmte lokale Adresse an den zugrunde liegenden **socket**-Aufruf.

**-progress** *callback*
: Der *callback* wird nach jedem Datentransfer von der URL aufgerufen. Der Callback erhaelt drei zusaetzliche Argumente: den *token* von **::http::geturl**, die erwartete Gesamtgroesse des Inhalts aus den **Content-Length**-Metadaten und die aktuell bereits uebertragene Bytezahl. Die erwartete Gesamtgroesse kann unbekannt sein; dann wird dem Callback Null uebergeben. Hier ist eine Vorlage fuer den Fortschritts-Callback:

```
proc httpProgress {token total current} {
    upvar #0 $token state
}
```

**-protocol** *version*
: Waehlt die zu verwendende HTTP-Protokollversion. Dies sollte 1.0 oder 1.1 (der Standard) sein. Dies ist nur fuer Server noetig, die HTTP/1.1 nicht verstehen oder anderweitig Beanstandungen dagegen haben.

**-query** *query*
: Dieses Flag (wenn der Wert nicht leer ist) veranlasst **::http::geturl**, eine POST-Anfrage auszufuehren, die die Zeichenkette *query* unveraendert als Request-Payload an den Server uebergibt. Das Inhaltsformat (und die Kodierung) von *query* wird durch den Request-Header **Content-Type** angegeben, der ueber die Option **-type** gesetzt wird. Jeder Wert fuer **-type** ist erlaubt, und es liegt in der Verantwortung des Aufrufers, *query* im korrekten Format bereitzustellen.

Wenn **-type** nicht angegeben wird, ist der Standard *application/x-www-form-urlencoded*, was voraussetzt, dass *query* eine x-url-kodierte Query-Zeichenkette ist (dieses **-type**- und Query-Format wird bei einem aus einem HTML-Formular uebermittelten POST verwendet). Die Prozedur **::http::formatQuery** kann fuer diese Formatierung verwendet werden.

**-queryblocksize** *size*
: Die Blockgroesse beim Senden von Query-Daten an die URL. Pro Schritt werden hoechstens *size* Byte geschrieben. Nach jedem Block wird ein Aufruf des Callbacks **-queryprogress** ausgefuehrt (falls diese Option angegeben wurde).

**-querychannel** *channelID*
: Dieses Flag veranlasst **::http::geturl**, eine POST-Anfrage auszufuehren, die die in *channelID* enthaltenen Daten an den Server uebergibt. Die Daten in *channelID* muessen x-url-kodierte Query-Daten sein, sofern nicht die untenstehende Option **-type** verwendet wird. Wenn kein Content-Length-Header ueber die Option **-headers** angegeben ist, versucht **::http::geturl** die Groesse der POST-Daten zu bestimmen, um diesen Header zu erzeugen. Falls dies nicht moeglich ist, wird ein Fehler zurueckgegeben.

**-queryprogress** *callback*
: Der *callback* wird nach jedem Datentransfer zur URL (d. h. POST) aufgerufen und funktioniert exakt wie die Option **-progress** (das Callback-Format ist identisch).

**-strict** *boolean*
: Ob fuer die Anfrage eine URL-Validierung gemaess RFC 3986 erzwungen werden soll. Standard ist 1.

**-timeout** *milliseconds*
: Wenn *milliseconds* nicht Null ist, richtet **::http::geturl** ein Timeout ein, das nach der angegebenen Millisekundenanzahl ausgeloest wird. Ein Timeout fuehrt zu einem Aufruf von **::http::reset** und (falls angegeben) des Callbacks **-command**. Der Rueckgabewert von **::http::status** ist **timeout**, nachdem ein Timeout eingetreten ist.

**-type** *mime-type*
: Verwendet *mime-type* als **Content-Type**-Wert statt des Standardwerts (**application/x-www-form-urlencoded**) waehrend einer POST-Operation.

**-validate** *boolean*
: Wenn *boolean* nicht Null ist, fuehrt **::http::geturl** eine HTTP- HEAD-Anfrage aus. Diese Anfrage liefert Metainformationen ueber die URL, der Inhalt selbst wird jedoch nicht zurueckgegeben. Die Metainformationen sind nach der Transaktion in der Variable **state(meta)** verfuegbar. Details finden Sie im Abschnitt **ZUSTANDS-ARRAY**.

**::http::formatQuery** *key value* ?*key value* \...?
: Diese Prozedur fuehrt x-url-Kodierung fuer Query-Daten aus. Sie erwartet eine gerade Anzahl Argumente, naemlich die Schluessel und Werte der Query. Sie kodiert Schluessel und Werte und erzeugt eine Zeichenkette mit den korrekten Trennzeichen & und =. Das Ergebnis eignet sich als **-query**- Wert fuer **::http::geturl**.

**::http::quoteString** *value*
: Diese Prozedur fuehrt x-url-Kodierung fuer eine Zeichenkette aus. Sie erwartet ein einzelnes Argument und kodiert es.

**::http::reset** *token* ?*why*?
: Dieser Befehl setzt die durch *token* identifizierte HTTP-Transaktion zurueck, falls vorhanden. Dabei wird **state(status)** auf *why* gesetzt, wobei der Standardwert **reset** ist, und danach der registrierte Callback **-command** aufgerufen.

**::http::wait** *token*
: Dies ist eine Komfortprozedur, die blockiert und auf den Abschluss der Transaktion wartet. Das funktioniert nur in vertrauenswuerdigem Code, da **vwait** verwendet wird. Ausserdem ist sie fuer den Fall unnuetz, dass **::http::geturl** *ohne* Option **-command** aufgerufen wird, weil in diesem Fall der Aufruf von **::http::geturl** erst nach Abschluss der HTTP-Transaktion zurueckkehrt und es somit nichts gibt, worauf gewartet werden muesste.

**::http::data** *token*
: Dies ist eine Komfortprozedur, die das Element **body** (d. h. die URL- Daten) aus dem Zustands-Array zurueckgibt.

**::http::error** *token*
: Dies ist eine Komfortprozedur, die das Element **error** des Zustands-Arrays zurueckgibt.

**::http::status** *token*
: Dies ist eine Komfortprozedur, die das Element **status** des Zustands-Arrays zurueckgibt.

**::http::code** *token*
: Dies ist eine Komfortprozedur, die das Element **http** des Zustands-Arrays zurueckgibt.

**::http::ncode** *token*
: Dies ist eine Komfortprozedur, die nur den numerischen Rueckgabecode (200, 404 usw.) aus dem Element **http** des Zustands-Arrays zurueckgibt.

**::http::size** *token*
: Dies ist eine Komfortprozedur, die das Element **currentsize** des Zustands-Arrays zurueckgibt, also die Anzahl der in der **::http::geturl**-Anfrage von der URL empfangenen Bytes.

**::http::meta** *token*
: Dies ist eine Komfortprozedur, die das Element **meta** des Zustands- Arrays zurueckgibt, das die HTTP-Antwortheader enthaelt. Unten folgt eine Erlaeuterung zu diesem Element.

**::http::cleanup** *token*
: Diese Prozedur raeumt den Zustand auf, der der durch *token* identifizierten Verbindung zugeordnet ist. Nach diesem Aufruf koennen Prozeduren wie **::http::data** nicht mehr verwendet werden, um Informationen ueber die Operation zu erhalten. Es wird *dringend* empfohlen, diese Funktion aufzurufen, nachdem Sie mit einer bestimmten HTTP-Anfrage fertig sind. Andernfalls wird Speicher nicht freigegeben, und wenn Ihre Anwendung **::http::geturl** oft genug aufruft, kann das Speicherleck zu einem Performanceverlust fuehren ... oder Schlimmerem.

**::http::register** *proto port command*
: Diese Prozedur ermoeglicht die Bereitstellung benutzerdefinierter HTTP- Transporttypen wie HTTPS, indem ein Praefix, der Standardport und der auszufuehrende Befehl zur Erzeugung des Tcl-**channel** registriert werden. Z. B.:

```
package require http
package require tls

::http::register https 443 ::tls::socket

set token [::http::geturl https://my.secure.site/]
```

**::http::registerError** *port* ?*message*?
: Diese Prozedur ermoeglicht es einem registrierten Protokoll-Handler, eine Fehlermeldung zur Verwendung durch **http** bereitzustellen. Der Aufruf dieses Befehls loest keinen Fehler aus. Der Befehl ist nuetzlich, wenn ein registriertes Protokoll ein Problem erkennt (z. B. ein ungueltiges TLS- Zertifikat), das dazu fuehrt, dass sich ein Fehler bis zu **http** fortpflanzt. Der Befehl ermoeglicht **http**, eine praezise statt einer allgemeinen Fehlermeldung bereitzustellen. Der Befehl gibt den Wert zurueck, der beim letzten Aufruf mit dem Argument *message* geliefert wurde, oder eine leere Zeichenkette, falls kein solcher Aufruf erfolgte.

**::http::unregister** *proto*
: Diese Prozedur deregistriert einen Protokoll-Handler, der zuvor ueber **::http::register** registriert wurde, und gibt eine Liste mit zwei Elementen zurueck: den zuvor installierten Standardport und den Handler- Befehl (via **::http::register**), falls ein solcher Handler existierte. Falls kein solcher Handler existierte, wird ein Fehler zurueckgegeben.

# FEHLER

Die Prozedur **::http::geturl** loest in den folgenden Faellen Fehler aus: ungueltige Kommandozeilenoptionen, eine ungueltige URL, eine URL auf einem nicht existierenden Host oder eine URL an einem ungueltigen Port eines existierenden Hosts. Diese Fehler bedeuten, dass die Netzwerktransaktion nicht einmal gestartet werden kann. Es wird auch ein Fehler ausgeloest, wenn beim Schreiben des HTTP-Request-Headers ein I/O-Fehler auftritt. Bei synchronen **::http::geturl**-Aufrufen (wenn **-command** nicht angegeben ist) wird ein Fehler ausgeloest, wenn beim Lesen der HTTP-Antwortheader oder -Daten ein I/O-Fehler auftritt. Da **::http::geturl** in diesen Faellen kein Token zurueckgibt, fuehrt es alle erforderlichen Aufraeumarbeiten selbst aus, und Ihre Anwendung muss **::http::cleanup** nicht aufrufen.

Bei asynchronen **::http::geturl**-Aufrufen gelten alle oben genannten Fehlersituationen ebenfalls, ausser dass bei Fehlern waehrend des Lesens der HTTP-Antwortheader oder -Daten keine Ausnahme geworfen wird. Der Grund ist, dass **::http::geturl** nach dem Schreiben der HTTP-Header zurueckkehrt und der Rest der HTTP-Transaktion im Hintergrund ablaeuft. Der Kommando-Callback kann pruefen, ob beim Lesen ein Fehler aufgetreten ist, indem er **::http::status** prueft und, falls dieser *error* ist, **::http::error** aufruft, um die Fehlermeldung zu erhalten.

Alternativ kann der Hauptprogrammfluss an einem spaeteren Zeitpunkt, an dem das Ergebnis der asynchronen HTTP-Anfrage benoetigt wird, **::http::wait** aufrufen und dann Status und Fehler genau wie der Callback pruefen.

Der Befehl **::http::geturl** fuehrt die Callbacks **-command**, **-handler** und **-proxyfilter** innerhalb eines **catch**-Befehls aus. Deshalb ruft ein Fehler im Callback-Befehl den Handler **bgerror** nicht auf. Beim Debuggen eines dieser Callbacks kann es praktisch sein, Fehler direkt im Callback selbst mit einem **catch**-Befehl zu melden, z. B. durch Ausgeben einer Fehlermeldung auf stdout.

In jedem Fall muessen Sie weiterhin **::http::cleanup** aufrufen, um das Zustands-Array zu loeschen, wenn Sie fertig sind.

Es gibt weitere moegliche Ergebnisse der HTTP-Transaktion, die durch Pruefen des Status von **::http::status** bestimmt werden. Diese sind unten beschrieben.

**ok**
: Wenn die HTTP-Transaktion vollstaendig abgeschlossen wird, lautet der Status **ok**. Trotzdem sollten Sie den Wert von **::http::code** pruefen, um den HTTP-Status zu erhalten. Die Prozedur **::http::ncode** liefert nur den numerischen Fehlercode (z. B. 200, 404 oder 500), waehrend die Prozedur **::http::code** einen Wert wie "HTTP 404 File not found" zurueckgibt.

**eof**
: Wenn der Server den Socket ohne Antwort schliesst, wird kein Fehler ausgeloest, aber der Status der Transaktion ist **eof**.

**error**
: Die Fehlermeldung wird ausserdem im Element **error** des Status-Arrays gespeichert und ist ueber **::http::error** abrufbar.

**timeout**
: Ein Timeout ist eingetreten, bevor die Transaktion abgeschlossen werden konnte.

**reset**
: user-reset

Eine weitere Fehlerquelle ist, dass **::http::geturl** nicht in der Lage ist, alle POST-Query-Daten zum Server zu schreiben, bevor der Server antwortet und den Socket schliesst. Die Fehlermeldung wird im Element **posterror** des Status-Arrays gespeichert, und anschliessend versucht **::http::geturl**, die Transaktion abzuschliessen. Wenn die Serverantwort gelesen werden kann, endet die Transaktion mit Status **ok**, andernfalls mit **eof**.

# ZUSTANDS-ARRAY

Die Prozedur **::http::geturl** gibt ein *token* zurueck, mit dem auf den Zustand der HTTP-Transaktion in Form eines Tcl-Arrays zugegriffen werden kann. Verwenden Sie dieses Konstrukt, um eine leicht nutzbare Array-Variable anzulegen:

```
upvar #0 $token state
```

Sobald die mit der URL verknuepften Daten nicht mehr benoetigt werden, sollte das Zustands-Array entfernt werden, um Speicher freizugeben. Dafuer gibt es die Prozedur **::http::cleanup**. Folgende Elemente des Arrays werden unterstuetzt:

**binary**
: Boolesch **true**, wenn die HTTP-Antwort (nach dem Dekodieren einer im Antwort-Header "Content-Encoding" angegebenen Kompression) binaer ist. Boolesch **false**, wenn die HTTP-Antwort Text ist.

**body**
: Der Inhalt der URL. Leer, wenn die Option **-channel** angegeben wurde. Dieser Wert wird vom Befehl **::http::data** zurueckgegeben.

**charset**
: Der Wert des charset-Attributs aus den **Content-Type**-Metadaten. Wurde keiner angegeben, gilt der RFC-Standard **iso8859-1** oder der Wert von **\$::http::defaultCharset**. Eingehende Textdaten werden automatisch von diesem Zeichensatz nach utf-8 konvertiert.

**coding**
: Eine Kopie des Metadatenwerts **Content-Encoding**.

**currentsize**
: Die bisher von der URL geholte Byteanzahl. Dieser Wert wird vom Befehl **::http::size** zurueckgegeben.

**error**
: Falls definiert, die Fehlerzeichenkette, die beim Abbruch der HTTP-Transaktion auftrat.

**http**
: Die HTTP-Statusantwort des Servers. Dieser Wert wird vom Befehl **::http::code** zurueckgegeben. Das Format dieses Werts ist:

```
HTTP/1.1 code string
```

*code* ist eine dreistellige Zahl, die im HTTP-Standard definiert ist. Der Code 200 bedeutet OK. Codes, die mit 4 oder 5 beginnen, zeigen Fehler an. Codes, die mit 3 beginnen, sind Umleitungsfehler. In diesem Fall geben die **Location**-Metadaten eine neue URL an, die die angeforderten Informationen enthaelt.

**meta**
: Das HTTP-Protokoll liefert Metadaten, die den URL-Inhalt beschreiben. Das Element **meta** des Zustands-Arrays ist eine Liste der Schluessel und Werte der Metadaten. Das Format eignet sich zum Initialisieren eines Arrays, das nur die Metadaten enthaelt:

```
array set meta $state(meta)
```

Einige der Metadaten-Schluessel sind unten aufgefuehrt, der HTTP-Standard definiert jedoch weitere, und Server duerfen eigene hinzufuegen.

**Content-Type**
: Der Typ des URL-Inhalts. Beispiele sind **text/html**, **image/gif**, **application/postscript** und **application/x-tcl**.

**Content-Length**
: Die angekuendigte Groesse des Inhalts. Die tatsaechlich von **::http::geturl** erhaltene Groesse steht in **state(currentsize)** zur Verfuegung.

**Location**
: Eine alternative URL, die die angeforderten Daten enthaelt.

**posterror**
: Der Fehler, falls einer auftrat, beim Schreiben der POST-Query-Daten an den Server.

**status**
: Siehe die Beschreibung im Kapitel **FEHLER** oben fuer eine Liste und Beschreibung von **status**. Waehrend der Transaktion ist dieser Wert die leere Zeichenkette.

**totalsize**
: Eine Kopie des Metadatenwerts **Content-Length**.

**type**
: Eine Kopie des Metadatenwerts **Content-Type**.

**url**
: Die angeforderte URL.

# PERSISTENTE VERBINDUNGEN

## GRUNDLAGEN

Siehe RFC 7230 Abschnitt 6, der RFC 2616 Abschnitt 8.1 ablöst.

Eine persistente Verbindung ermoeglicht es, mehrere HTTP/1.1-Transaktionen ueber dieselbe TCP-Verbindung abzuwickeln. Pipelining erlaubt einem Client, mehrere Anfragen ueber eine persistente Verbindung zu senden, ohne auf jede einzelne Antwort zu warten. Der Server sendet Antworten in derselben Reihenfolge, in der die Anfragen empfangen wurden.

Wenn eine POST-Anfrage nicht erfolgreich abgeschlossen wird, ist typischerweise eine Bestaetigung des Benutzers erforderlich, bevor dieselbe Anfrage erneut gesendet wird. Der Benutzer moechte moeglicherweise zuerst pruefen, ob der Server durch die fehlgeschlagene POST-Anfrage bereits veraendert wurde.

Eine HTTP-Anfrage verwendet einen persistenten Socket, wenn der Aufruf von **http::geturl** die Option **-keepalive true** enthaelt. Pipelining wird verwendet, wo es zulaessig ist, wenn die Option **-pipeline** von **http::config** boolesch **true** ist (Standardwert).

Das Paket http unterhaelt hoechstens eine persistente Verbindung zu jedem Server (d. h. pro Wert von

Wenn **http::geturl** eine Anfrage ueber eine persistente Verbindung senden soll, waehrend diese gerade mit einer anderen Anfrage beschaeftigt ist, wird die neue Anfrage in einer Warteschlange gehalten, bis die Verbindung frei ist.

Das Paket http unterstuetzt keine persistenten HTTP/1.0-Verbindungen, die ueber den Header **Keep-Alive** gesteuert werden.

## SONDERFÄLLE

Dieser Unterabschnitt behandelt Probleme im Zusammenhang mit dem Schliessen der persistenten Verbindung durch den Server, dem automatischen Wiederholen fehlgeschlagener Anfragen, der notwendigen Sonderbehandlung von POST-Anfragen und den Optionen zur Behandlung dieser Faelle.

Entsprechend RFC 7230 fuehrt **http::geturl** fuer Anfragen mit der Methode POST kein Pipelining aus. Wenn ein POST eine persistente Verbindung verwendet und nicht die erste Anfrage auf dieser Verbindung ist, wartet **http::geturl**, bis die Antwort auf die vorherige Anfrage empfangen wurde; oder (wenn die Option **-postfresh** von **http::config** boolesch **true** ist) es wird fuer jeden POST eine neue Verbindung verwendet.

Wenn der Server eine Reihe gepipelter Anfragen verarbeitet und mit einer der Antworten (ausser der letzten) einen Response-Header sendet

dann bleiben nachfolgende Antworten unerfuellt. **http::geturl** sendet die unerfuellten Anfragen erneut ueber eine neue Verbindung.

Eine Schwierigkeit entsteht, wenn ein HTTP-Client eine Anfrage ueber eine persistente Verbindung sendet, die eine Weile inaktiv war. Der HTTP-Server kann eine scheinbar inaktive Verbindung halb schliessen, waehrend der Client eine Anfrage sendet, aber bevor die Anfrage den Server erreicht: in diesem Fall (ein

schlaegt die Anfrage fehl. Die Schwierigkeit besteht darin, dass der Client nicht sicher wissen kann, ob der POST den Zustand des Servers veraendert hat. Bei HEAD- oder GET-Anfragen oeffnet **http::geturl** eine weitere Verbindung und sendet die fehlgeschlagene Anfrage erneut. Wenn die Anfrage jedoch ein POST war, verbietet RFC 7230 standardmaessig die automatische Wiederholung und empfiehlt stattdessen entweder eine Benutzerbestaetigung oder eine Bestaetigung durch User-Agent-Software, die die Semantik der Anwendung versteht. Die Option **-repost** von **http::config** ermoeglicht beide Moeglichkeiten.

Asynchrone Close-Ereignisse koennen nur in einem kurzen Zeitintervall auftreten. Das Paket **http** ueberwacht jede persistente Verbindung darauf, ob der Server sie schliesst. Bei Erkennung wird die Verbindung auch clientseitig geschlossen, und nachfolgende Anfragen verwenden eine frische Verbindung.

Wenn der Befehl **http::geturl** mit Option **-keepalive true** aufgerufen wird, versucht er sowohl, eine bestehende persistente Verbindung zu verwenden (falls verfuegbar), als auch dem Server einen

Request-Header zu senden, der darum bittet, die Verbindung fuer zukuenftige Anfragen offen zu halten.

Die Optionen **-pipeline**, **-postfresh** und **-repost** von **http::config** beziehen sich auf persistente Verbindungen.

Option **-pipeline** fuehrt, wenn boolesch **true**, GET- und HEAD-Anfragen ueber persistente Verbindungen als Pipeline aus. POST-Anfragen werden nicht gepipelined - ist der POST nicht die erste Transaktion auf der Verbindung, wird seine Anfrage erst gesendet, wenn die vorherige Antwort abgeschlossen ist. GET- und HEAD-Anfragen nach einem POST werden erst gesendet, wenn die POST- Antwort zugestellt wurde, und werden nicht gesendet, falls der POST fehlschlaegt.

Option **-postfresh** ueberschreibt, wenn boolesch **true**, die Option **-keepalive** von **http::geturl** und oeffnet fuer eine POST-Anfrage immer eine neue Verbindung.

Option **-repost** erlaubt bei Wert **true** das automatische Wiederholen einer POST-Anfrage, die fehlschlaegt, weil sie eine persistente Verbindung verwendet, die der Server halb geschlossen hat (ein

Nachfolgende GET- und HEAD-Anfragen in einer fehlgeschlagenen Pipeline werden ebenfalls wiederholt. *Die Option -repost sollte nur verwendet werden, wenn die Anwendung versteht*, dass die Wiederholung angemessen ist - konkret muss die Anwendung wissen, dass ein wiederholter POST keine nachteiligen Auswirkungen haette, falls der fehlgeschlagene POST den Zustand des Servers bereits erfolgreich veraendert hat.

# PROTOKOLL-UPGRADES

Die HTTP/1.1-Client-Header **Connection** und **Upgrade** teilen dem Server mit, dass der Client das Protokoll ueber die bestehende Verbindung aendern moechte (RFC 7230). Dieser Mechanismus kann verwendet werden, um WebSocket (RFC 6455), eine hoehere Version des HTTP-Protokolls (HTTP 2) oder TLS- Verschluesselung anzufordern. Wenn der Server die Upgrade-Anfrage akzeptiert, ist sein Antwortcode 101.

Um beim Aufruf von **http::geturl** ein Protokoll-Upgrade anzufordern, muss die Option **-headers** geeignete Werte fuer **Connection** und **Upgrade** bereitstellen, und die Option **-command** muss einen Befehl bereitstellen, der das angeforderte Protokoll implementiert und auch die Serverantwort behandeln kann, falls der Server das Protokoll-Upgrade ablehnt. Bei Upgrade-Anfragen ignoriert **http::geturl** den Wert der Option **-keepalive** und verwendet immer den Wert **0**, damit die Upgrade-Anfrage nicht ueber eine Verbindung erfolgt, die fuer mehrere HTTP-Anfragen gedacht ist.

Die Tcllib-Bibliothek **websocket** implementiert WebSockets und fuehrt die dafuer notwendigen Aufrufe von Befehlen im Paket **http** aus.

Derzeit gibt es keine native Tcl-Client-Bibliothek für HTTP/2.

Der **Upgrade**-Mechanismus wird in Webbrowsern nicht zum Anfordern von TLS verwendet, weil **http** und **https** ueber unterschiedliche Ports bereitgestellt werden. Er wird von Protokollen wie dem Internet Printing Protocol (IPP) verwendet, die auf **http(s)** aufbauen und fuer sicheren und unsicheren Datenverkehr dieselbe TCP-Portnummer verwenden.

In Browsern wird opportunistische Verschluesselung stattdessen ueber den Client-Header **Upgrade-Insecure-Requests** umgesetzt. Wenn ein sicherer Dienst verfuegbar ist, lautet der Serverantwortcode auf 307 Redirect, und der Response-Header **Location** gibt die Ziel-URL an. Der Browser muss **http::geturl** erneut aufrufen, um diese URL abzurufen. Siehe https://w3c.github.io/webappsec-upgrade-insecure-requests/

# BEISPIEL

Dieses Beispiel erzeugt eine Prozedur, die eine URL in eine Datei kopiert, dabei einen Fortschrittsanzeiger ausgibt und die mit der URL verknuepften Metadaten ausgibt.

```
proc httpcopy { url file {chunk 4096} } {
    set out [open $file w]
    set token [::http::geturl $url -channel $out \
            -progress httpCopyProgress -blocksize $chunk]
    close $out

    # Das beendet die von httpCopyProgress begonnene Zeile
    puts stderr ""

    upvar #0 $token state
    set max 0
    foreach {name value} $state(meta) {
        if {[string length $name] > $max} {
            set max [string length $name]
        }
        if {[regexp -nocase ^location$ $name]} {
            # URL-Weiterleitungen behandeln
            puts stderr "Location:$value"
            return [httpcopy [string trim $value] $file $chunk]
        }
    }
    incr max
    foreach {name value} $state(meta) {
        puts [format "%-*s %s" $max $name: $value]
    }

    return $token
}
proc httpCopyProgress {args} {
    puts -nonewline stderr .
    flush stderr
}
```
