---
CommandName: http
ManualSection: n
Version: 2.10
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
[package]{.cmd} [require]{.sub} [http]{.lit} [2.10]{.optlit} 

[::http::config]{.cmd} [-option value]{.optdot} 
[::http::geturl]{.cmd} [url]{.arg} [-option value]{.optdot} 
[::http::formatQuery]{.cmd} [key]{.arg} [value]{.arg} [key value]{.optdot} 
[::http::quoteString]{.cmd} [value]{.arg} 
[::http::reset]{.cmd} [token]{.arg} [why]{.optarg} 
[::http::wait]{.cmd} [token]{.arg} 
[::http::status]{.cmd} [token]{.arg} 
[::http::size]{.cmd} [token]{.arg} 
[::http::error]{.cmd} [token]{.arg} 
[::http::postError]{.cmd} [token]{.arg} 
[::http::cleanup]{.cmd} [token]{.arg} 
[::http::requestLine]{.cmd} [token]{.arg} 
[::http::requestHeaders]{.cmd} [token]{.arg} [headerName]{.optarg} 
[::http::requestHeaderValue]{.cmd} [token]{.arg} [headerName]{.arg} 
[::http::responseLine]{.cmd} [token]{.arg} 
[::http::responseCode]{.cmd} [token]{.arg} 
[::http::reasonPhrase]{.cmd} [code]{.arg} 
[::http::responseHeaders]{.cmd} [token]{.arg} [headerName]{.optarg} 
[::http::responseHeaderValue]{.cmd} [token]{.arg} [headerName]{.arg} 
[::http::responseInfo]{.cmd} [token]{.arg} 
[::http::responseBody]{.cmd} [token]{.arg} 
[::http::register]{.cmd} [proto]{.arg} [port]{.arg} [command]{.arg} [socketCmdVarName]{.optarg} [useSockThread]{.optarg} [endToEndProxy]{.optarg} 
[::http::registerError]{.cmd} [sock]{.arg} [message]{.optarg} 
[::http::unregister]{.cmd} [proto]{.arg} 
[::http::code]{.cmd} [token]{.arg} 
[::http::data]{.cmd} [token]{.arg} 
[::http::meta]{.cmd} [token]{.arg} [headerName]{.optarg} 
[::http::metaValue]{.cmd} [token]{.arg} [headerName]{.arg} 
[::http::ncode]{.cmd} [token]{.arg} 
:::

# EXPORTIERTE BEFEHLE

Der Namespace **http** exportiert die Befehle **config**, **formatQuery**, **geturl**, **postError**, **quoteString**, **reasonPhrase**, **register**, **registerError**, **requestHeaders**, **requestHeaderValue**, **requestLine**, **responseBody**, **responseCode**, **responseHeaders**, **responseHeaderValue**, **responseInfo**, **responseLine**, **reset**, **unregister** und **wait**.

Er exportiert nicht die Befehle **cleanup**, **code**, **data**, **error**, **meta**, **metaValue**, **ncode**, **size** oder **status**.

# BESCHREIBUNG

Das Paket **http** stellt die Client-Seite des HTTP/1.1-Protokolls bereit, wie in RFC 9110 bis 9112 definiert, die RFC 7230 bis RFC 7235 ablösen, die wiederum RFC 2616 ablösen. Das Paket implementiert die GET-, POST- und HEAD-Operationen von HTTP/1.1. Es ermöglicht die Konfiguration eines Proxy-Hosts, um Firewalls zu passieren. Das Paket ist mit der **Safesock**-Sicherheitsrichtlinie kompatibel und kann daher von nicht vertrauenswürdigen Applets zum Abrufen von URLs von einer eingeschränkten Menge von Hosts verwendet werden. Dieses Paket kann erweitert werden, um zusätzliche HTTP-Transportprotokolle wie HTTPS zu unterstützen, indem ein benutzerdefinierter **socket**-Befehl über **::http::register** bereitgestellt wird.

Die Prozedur **::http::geturl** führt eine HTTP-Transaktion aus. Ihre *Optionen* legen fest, ob eine GET-, POST- oder HEAD-Transaktion durchgeführt wird. Der Rückgabewert von **::http::geturl** ist ein Token für die Transaktion. Das Token kann als Argument an andere Befehle übergeben werden, um die Transaktion zu verwalten und ihre Ergebnisse zu prüfen.

Ist die Option **-command** angegeben, wird die HTTP-Operation im Hintergrund ausgeführt. **::http::geturl** kehrt unmittelbar nach dem Erzeugen der HTTP-Anfrage zurück, und die **-command**-Rückruffunktion wird aufgerufen, wenn die Transaktion abgeschlossen ist. Damit dies funktioniert, muss die Tcl-Ereignisschleife aktiv sein. In Tk-Anwendungen ist dies stets der Fall. In reinen Tcl-Anwendungen kann der Aufrufer nach dem Aufruf von **::http::geturl** **::http::wait** verwenden, um die Ereignisschleife zu starten.

**Hinweis:** Die Ereigniswarteschlange wird auch ohne die Option **-command** verwendet. Als Nebeneffekt können beliebige Befehle verarbeitet werden, während **http::geturl** läuft.

Hat der HTTP-Server auf die Anfrage geantwortet, rufen Sie den Befehl **::http::responseInfo** auf, der ein **dict** mit Metadaten zurückgibt, die für die Erkennung einer erfolgreichen Transaktion und die Nutzung der Antwort wesentlich sind. Details zu den zurückgegebenen Informationen finden Sie im Abschnitt **METADATEN**. Die Antwort selbst wird vom Befehl **::http::responseBody** zurückgegeben, sofern sie nicht durch die Option *-channel* von **::http::geturl** in eine Datei umgeleitet wurde.

# BEFEHLE

**::http::config** ?*options*?
: Der Befehl **::http::config** dient zum Setzen und Abfragen des Namens des Proxy-Servers und -Ports sowie des in den HTTP-Anfragen verwendeten User-Agent-Namens. Sind keine Optionen angegeben, wird die aktuelle Konfiguration zurückgegeben. Ist ein einzelnes Argument angegeben, sollte es eine der unten beschriebenen Flags sein; in diesem Fall wird der aktuelle Wert dieser Einstellung zurückgegeben. Andernfalls sollten die Optionen eine Menge von Flags und Werten sein, die die Konfiguration definieren:

**-accept** *mimetypes*
: Der Accept-Header der Anfrage. Der Standardwert ist \*/\*, was bedeutet, dass alle Dokumenttypen akzeptiert werden. Andernfalls können Sie eine durch Kommas getrennte Liste von MIME-Typ-Mustern angeben, die Sie empfangen möchten. Zum Beispiel,

image/gif, image/jpeg, text/*

**-cookiejar** *command*
: Der Cookie-Speicher, den das Paket zur Verwaltung von HTTP-Cookies verwenden soll. *command* ist eine Befehlspräfix-Liste; wird die leere Liste (der Standardwert) verwendet, senden Anfragen keine Cookies und speichern keine aus Antworten. Der durch *command* angegebene Befehl muss, falls angegeben, dem unten beschriebenen **COOKIE-JAR-PROTOKOLL** entsprechen.

**-pipeline** *boolean*
: Legt fest, ob HTTP/1.1-Transaktionen auf einem persistenten Socket gepipelined werden. Siehe Abschnitt **PERSISTENTE SOCKETS** für Details. Der Standardwert ist 1.

**-postfresh** *boolean*
: Legt fest, ob Anfragen, die die Methode **POST** verwenden, stets einen frischen Socket nutzen und damit die Option **-keepalive** des Befehls **http::geturl** überschreiben. Siehe Abschnitt **PERSISTENTE SOCKETS** für Details. Der Standardwert ist 0.

**-proxyauth** *string*
: Ist der String nicht leer, wird er dem Proxy-Server als Wert des Anfrage-Headers Proxy-Authorization übergeben. Diese Option kann für HTTP Basic Authentication verwendet werden. Erfordert der Proxy-Server eine Authentifizierung mit einer anderen Technik, z. B. Digest Authentication, ist die Option **-proxyauth** nicht nützlich. In diesem Fall muss der Aufrufer mit einer 407-Antwort des Proxys rechnen, den bereitzustellenden Authentifizierungswert berechnen und über die Option **-headers** als Wert des Headers Proxy-Authorization liefern.

**-proxyfilter** *command*
: Der Befehl ist eine Rückruffunktion, die während **::http::geturl** aufgerufen wird, um zu ermitteln, ob für einen bestimmten Host ein Proxy erforderlich ist. Beim Aufruf wird dem *command* ein Argument, ein Hostname, angehängt. Ist ein Proxy erforderlich, soll die Rückruffunktion eine zweielementige Liste mit Proxy-Server und Proxy-Port zurückgeben. Andernfalls soll der Filterbefehl eine leere Liste zurückgeben.

Der Standardwert von **-proxyfilter** ist **http::ProxyRequired**; dieser Befehl gibt die Werte der Einstellungen **-proxyhost** und **-proxyport** zurück, sofern sie nicht leer sind. Die Optionen **-proxyhost**, **-proxyport** und **-proxynot** werden nur von **http::ProxyRequired** verwendet und sonst nirgends in **::http::geturl**. Ein benutzerdefinierter **-proxyfilter**-Befehl kann diese Optionen nutzen oder Werte aus anderer Stelle im aufrufenden Skript beziehen. Im letzteren Fall bleiben alle für **-proxyhost**, **-proxyport** und **-proxynot** angegebenen Werte ungenutzt.

Der Befehl **::http::geturl** führt die **-proxyfilter**- Rückruffunktion innerhalb eines **catch**-Befehls aus. Ein Fehler in der Rückruffunktion ruft daher nicht den **bgerror**-Handler auf. Siehe Abschnitt **FEHLER** für Details.

**-proxyhost** *hostname*
: Der Hostname oder die IP-Adresse des Proxy-Servers, falls vorhanden. Ist dieser Wert die leere Zeichenkette, wird der URL-Host direkt kontaktiert. Siehe **-proxyfilter** zur Verwendung des Werts.

**-proxynot** *list*
: Eine Tcl-Liste von Domänennamen und IP-Adressen, die direkt und nicht über den Proxy-Server erreicht werden sollen. Der Ziel-Hostname wird mit jedem Listenelement per **string match** ohne Berücksichtigung der Groß-/Kleinschreibung verglichen. Oft ist es praktisch, das Platzhalterzeichen \"\*\" am Anfang eines Domänennamens (z. B. \*.example.com) oder am Ende einer IP-Adresse (z. B. 192.168.0.\*) zu verwenden. Siehe **-proxyfilter** zur Verwendung des Werts.

**-proxyport** *number*
: Die Portnummer des Proxy-Servers. Siehe **-proxyfilter** zur Verwendung des Werts.

**-repost** *boolean*
: Legt fest, was zu tun ist, wenn eine POST-Anfrage über eine persistente Verbindung fehlschlägt, weil der Server die Verbindung halb geschlossen hat. Ist der boolesche Wert **true**, wird die Anfrage automatisch wiederholt; ist er **false**, nicht, und die Anwendung, die **http::geturl** verwendet, soll vor einer erneuten POST-Anfrage eine Bestätigung des Benutzers einholen. Der Wert **true** sollte nur unter bestimmten Bedingungen verwendet werden. Siehe Abschnitt **PERSISTENTE SOCKETS** für Details. Der Standardwert ist 0.

**-threadlevel** *level*
: Legt fest, ob und wie das Paket **Thread** verwendet wird. Mögliche Werte von *level* sind 0, 1 oder 2.

0.  (Standard) Thread nicht verwenden

1.  Thread verwenden, falls verfügbar; andernfalls nicht verwenden

2.  Thread verwenden, falls verfügbar; andernfalls Fehler auslösen

Der Tcl-Befehl **socket -async** kann in ungünstigen Fällen blockieren (z. B. bei einer langsamen DNS-Abfrage). Die Verwendung des Thread-Pakets umgeht dieses Problem sowohl bei HTTP- als auch bei HTTPS-Transaktionen. Werte von *level* ungleich 0 stehen nur dem Haupt-Interpreter in jedem Thread zur Verfügung. Siehe Abschnitt **THREADS** für weitere Informationen.

**-urlencoding** *encoding*
: Die *encoding*, die zum Erzeugen x-url-kodierter URLs mit **::http::formatQuery** und **::http::quoteString** verwendet wird. Der Standardwert ist **utf-8**, wie in RFC 2718 festgelegt.

**-useragent** *string*
: Der Wert des User-Agent-Headers in der HTTP-Anfrage. In einem unsicheren Interpreter hängt der Standardwert vom Betriebssystem sowie von den Versionsnummern von **http** und **Tcl** ab und lautet (zum Beispiel)

Mozilla/5.0 (Windows; U; Windows NT 10.0) http/2.10.1 Tcl/9.0.0

Ein sicherer Interpreter kann sein Betriebssystem nicht ermitteln; der Standardwert in einem sicheren Interpreter ist daher ein Windows-10-Wert mit den aktuellen Versionsnummern von **http** und **Tcl**.

**-zip** *boolean*
: Ist der Wert boolesch **true**, senden Anfragen standardmäßig einen Header

Accept-Encoding: gzip,deflate

Ist der Wert boolesch **false**, senden Anfragen standardmäßig einen Header

Accept-Encoding: identity

In beiden Fällen kann der Standardwert für eine einzelne Anfrage überschrieben werden, indem ein benutzerdefinierter **Accept-Encoding**-Header in der Option **-headers** von **http::geturl** angegeben wird. Der Standardwert ist 1.

**::http::geturl** *url* ?*options*?
: Der Befehl **::http::geturl** ist die Hauptprozedur im Paket. Die Option **-query** oder **-querychannel** bewirkt eine POST-Operation, die Option **-validate** eine HEAD-Operation; andernfalls wird eine GET-Operation ausgeführt. Der Befehl **::http::geturl** gibt einen *token*-Wert zurück, der als Argument an andere Befehle übergeben werden kann, um Informationen über die Transaktion zu erhalten. Siehe die Abschnitte **METADATEN** und **FEHLER** für Details. Der Befehl **::http::geturl** blockiert, bis die Operation abgeschlossen ist, es sei denn, die Option **-command** gibt eine Rückruffunktion an, die aufgerufen wird, wenn die HTTP-Transaktion abgeschlossen ist. **::http::geturl** unterstützt mehrere Optionen:

**-binary** *boolean*
: Legt fest, ob die URL-Daten zwangsweise als Binärdaten interpretiert werden. Normalerweise erfolgt dies automatisch (alles, was nicht mit einem **text**-Content-Type beginnt oder dessen Content-Encoding **gzip** oder **deflate** ist, gilt als Binärdaten).

**-blocksize** *size*
: Die Blockgröße beim Lesen der URL. Es werden höchstens *size* Bytes auf einmal gelesen. Nach jedem Block wird die **-progress**- Rückruffunktion aufgerufen (falls diese Option angegeben ist).

**-channel** *name*
: Kopiert den URL-Inhalt in den Kanal *name*, statt ihn in einer Tcl-Variable für den Abruf durch **::http::responseBody** zu speichern.

**-command** *callback*
: Ist diese Option gesetzt, kehrt **::http::geturl** unmittelbar zurück. Nach Abschluss der HTTP-Transaktion wird *callback* expandiert, ein zusätzliches Argument angehängt und der resultierende Befehl ausgewertet. Das zusätzliche Argument ist der von **::http::geturl** zurückgegebene *token*. Dieser Token ist der Name eines Arrays, das im Abschnitt **STATUS-ARRAY** beschrieben ist. Hier ist eine Vorlage für die Rückruffunktion:

```
proc httpCallback {token} {
    upvar 0 $token state
    # Zugriff auf state als Tcl-Array in dieser Prozedur
    ...
    return
}
```

Der Befehl **::http::geturl** führt die **-command**-Rückruffunktion innerhalb eines **catch**-Befehls aus. Ein Fehler in der Rückruffunktion ruft daher nicht den **bgerror**-Handler auf. Siehe Abschnitt **FEHLER** für Details.

**-guesstype** *boolean*
: Versucht, **Content-Type** und Zeichensatz zu erraten, wenn ein falsch konfigurierter Server keine Angaben liefert. Der Standardwert ist *false* (nichts tun). Ist der boolesche Wert *true* und sendet der Server keinen **Content-Type**-Header oder sendet er den Wert \"application/octet-stream\", versucht **http::geturl**, passende Werte zu erraten. Dies ist nicht als allgemeines Werkzeug gedacht und derzeit auf die Erkennung von XML-Dokumenten beschränkt, die mit einer XML-Deklaration beginnen. In diesem Fall wird **Content-Type** auf \"application/xml\" geändert, die Binär-Flag state(binary) auf 0 gesetzt und der Zeichensatz auf den in der XML-Zeile angegebenen Wert des Tags \"encoding\" oder auf utf-8, falls keine Kodierung angegeben ist. Wird nicht verwendet, wenn **-channel** angegeben ist.

**-handler** *callback*
: Fehlt diese Option, verarbeitet **http::geturl** eingehende Daten selbst, entweder durch Anhängen an die Variable state(body) oder durch Schreiben in den -channel. Ist die Option **-handler** gesetzt, führt **http::geturl** diese Verarbeitung nicht durch; stattdessen wird *callback* aufgerufen. Sobald HTTP-Daten verfügbar sind, wird *callback* expandiert, zwei zusätzliche Argumente angehängt und der resultierende Befehl ausgewertet. Die beiden zusätzlichen Argumente sind: der Socket für die HTTP-Daten und der von **::http::geturl** zurückgegebene *token*. Der Token ist der Name eines globalen Arrays, das im Abschnitt **STATUS-ARRAY** beschrieben ist. Die Prozedur soll die Anzahl der vom Socket gelesenen Bytes zurückgeben. Hier ist eine Vorlage für die Rückruffunktion:

```
proc httpHandlerCallback {socket token} {
    upvar 0 $token state
    # Zugriff auf socket und state als Tcl-Array in dieser Prozedur
    # Zum Beispiel...
    ...
    set data [read $socket 1000]
    set nbytes [string length $data]
    ...
    return $nbytes
}
```

Der Code von **http::geturl** für die Option **-handler** ist weder mit Kompression noch mit Chunked Transfer-Encoding kompatibel. Ist **-handler** angegeben, setzt **http::geturl** zur Umgehung dieser Probleme das HTTP-Protokoll auf 1.0 herab und überschreibt die Option **-zip** (d. h. es sendet den Header **Accept-Encoding: identity** statt **Accept-Encoding: gzip,deflate**).

Werden die Optionen **-handler** und **-channel** gemeinsam verwendet, ist der Handler dafür verantwortlich, die Daten vom HTTP-Socket in den angegebenen Kanal zu kopieren. Der Kanalname ist dem Handler als Element **-channel** des Token-Arrays verfügbar.

Der Befehl **::http::geturl** führt die **-handler**-Rückruffunktion innerhalb eines **catch**-Befehls aus. Ein Fehler in der Rückruffunktion ruft daher nicht den **bgerror**-Handler auf. Siehe Abschnitt **FEHLER** für Details.

**-headers** *keyvaluelist*
: Diese Option fügt der HTTP-Anfrage Header hinzu, die nicht bereits durch **::http::config** festgelegt sind. Das Argument *keyvaluelist* muss eine Liste mit einer geraden Anzahl von Elementen sein, die zwischen Schlüsseln und Werten wechseln. Die Schlüssel werden zu Header-Feldnamen. Zeilenumbrüche werden aus den Werten entfernt, damit der Header nicht beschädigt wird. Ist *keyvaluelist* z. B. **Pragma no-cache**, wird folgender Header in die HTTP-Anfrage aufgenommen:

```
Pragma: no-cache
```

**-method** *type*
: Erzwingt die HTTP-Anfragemethode *type*. **::http::geturl** wählt GET, POST oder HEAD anhand anderer Optionen automatisch; diese Option überschreibt die Auswahl und ermöglicht z. B. PUT und DELETE für WebDAV-Unterstützung.

Es liegt in der Verantwortung des Aufrufers, dass Header und Anfragekörper (falls vorhanden) den Anforderungen der Anfragemethode entsprechen. Wird z. B. **-method** *POST* verwendet, um eine POST-Anfrage mit leerem Anfragekörper zu senden, muss der Aufrufer außerdem die Option

```
-headers {Content-Length 0}
```

**-myaddr** *address*
: Übergibt eine bestimmte lokale Adresse an den zugrunde liegenden **socket**-Aufruf, falls mehrere Schnittstellen verfügbar sind.

**-progress** *callback*
: Ist die Option **-progress** gesetzt, wird *callback* nach jedem Datenübertrag vom URL aufgerufen. *callback* wird expandiert, drei zusätzliche Argumente angehängt und der resultierende Befehl ausgewertet. Die drei zusätzlichen Argumente sind: der von **::http::geturl** zurückgegebene *token*, die erwartete Gesamtgröße des Inhalts aus dem Antwort-Header **Content-Length** und die bisher übertragene Byteanzahl. Der Token ist der Name eines globalen Arrays, das im Abschnitt **STATUS-ARRAY** beschrieben ist. Die erwartete Gesamtgröße kann unbekannt sein; dann wird 0 an die Rückruffunktion übergeben. Hier ist eine Vorlage für die Fortschritts-Rückruffunktion:

```
proc httpProgress {token total current} {
    upvar 0 $token state
    # Zugriff auf state als Tcl-Array in dieser Prozedur
    ...
    return
}
```

**-protocol** *version*
: Wählt die zu verwendende HTTP-Protokollversion. Dies sollte 1.0 oder 1.1 sein (Standard). Nur bei Servern nötig, die HTTP/1.1 nicht verstehen oder sich anderweitig beschweren.

**-query** *query*
: Dieses Flag (bei nicht leerem Wert) bewirkt, dass **::http::geturl** eine POST-Anfrage ausführt, die

die Zeichenkette *query* unverändert als Anfrage-Nutzlast an den Server übergibt. Das Format (und die Kodierung) von *query* wird durch den Anfrage-Header **Content-Type** angekündigt, der durch die Option **-type** gesetzt wird. Jeder Wert von **-type** ist zulässig; es liegt in der Verantwortung des Aufrufers, *query* im richtigen Format zu liefern.

Ist **-type** nicht angegeben, gilt standardmäßig *application/x-www-form-urlencoded*, was erfordert, dass *query* eine x-url-kodierte Query-Zeichenkette ist (dieses **-type** und Query-Format werden bei einem aus einem HTML-Formular abgesendeten POST verwendet). Die Prozedur **::http::formatQuery** kann für die Formatierung verwendet werden.

**-queryblocksize** *size*
: Die Blockgröße beim Senden von Query-Daten an die URL. Es werden höchstens *size* Bytes auf einmal geschrieben. Nach jedem Block wird die **-queryprogress**-Rückruffunktion aufgerufen (falls diese Option angegeben ist).

**-querychannel** *channelID*
: Dieses Flag bewirkt, dass **::http::geturl** eine POST-Anfrage ausführt, die die in *channelID*

enthaltenen Daten an den Server übergibt. Die Daten in *channelID* müssen eine x-url-kodierte Query sein, sofern die Option **-type** unten nicht verwendet wird. Ist kein **Content-Length**-Header über die Option **-headers** angegeben, versucht **::http::geturl**, die Größe der POST-Daten zu ermitteln, um diesen Header zu erzeugen. Kann die Größe nicht ermittelt werden, gibt es einen Fehler zurück.

**-queryprogress** *callback*
: Ist die Option **-queryprogress** gesetzt, wird *callback* nach jedem Datenübertrag an die URL in einer POST-Anfrage aufgerufen (d. h. bei einem Aufruf von **::http::geturl** mit Option **-query** oder **-querychannel**) und verhält sich genau wie die Option **-progress** (das Rückrufformat ist dasselbe).

**-strict** *boolean*
: Ist der Wert wahr, prüft der Befehl, ob die URL RFC 3986 entspricht, d. h. keine Zeichen enthält, die x-url-kodiert werden müssten (z. B. muss ein Leerzeichen als \"%20\" kodiert sein). Der Standardwert ist 1.

**-timeout** *milliseconds*
: Ist *milliseconds* ungleich null, richtet **::http::geturl** einen Timeout nach der angegebenen Anzahl Millisekunden ein. Ein Timeout führt zu einem Aufruf von **::http::reset** und zur **-command**- Rückruffunktion, falls angegeben. Der Rückgabewert von **::http::status** (und der Wert des Schlüssels *status* im von **::http::responseInfo** zurückgegebenen Dictionary) ist **timeout**, nachdem ein Timeout aufgetreten ist.

**-type*** mime-type*
: Verwendet *mime-type* als Wert von **Content-Type** statt des Standardwerts (**application/x-www-form-urlencoded**) während einer POST-Operation.

**-validate** *boolean*
: Ist *boolean* ungleich null, führt **::http::geturl** eine HTTP-HEAD-Anfrage aus. Der Server liefert dieselbe Statuszeile und dieselben Antwort-Header wie bei einer HTTP-GET-Anfrage, lässt aber die Antwort-Entität (den URL-\"Inhalt\") weg. Die Antwort-Header sind nach der Transaktion mit dem Befehl **::http::responseHeaders** oder für ausgewählte Informationen mit **::http::responseInfo** verfügbar.

**::http::formatQuery** *key value* ?*key value ...*?
: Diese Prozedur führt x-url-Kodierung von Query-Daten durch. Sie erwartet eine gerade Anzahl von Argumenten als Schlüssel und Werte der Query. Sie kodiert Schlüssel und Werte und erzeugt eine Zeichenkette mit den passenden &- und =-Trennzeichen. Das Ergebnis eignet sich als Wert für **-query** bei **::http::geturl**.

**::http::quoteString** *value*
: Diese Prozedur führt x-url-Kodierung einer Zeichenkette durch. Sie erwartet ein einzelnes Argument und kodiert es.

**::http::reset** *token* ?*why*?
: Dieser Befehl setzt die durch *token* identifizierte HTTP-Transaktion zurück, falls vorhanden. Dabei wird **state(status)** auf *why* gesetzt, standardmäßig **reset**, und die registrierte **-command**- Rückruffunktion aufgerufen.

**::http::wait** *token*
: Dieser Befehl blockiert und wartet auf den Abschluss der Transaktion. Dies funktioniert nur in vertrauenswürdigem Code, weil **vwait** verwendet wird. Außerdem ist es nicht nützlich, wenn **::http::geturl** *ohne* die Option **-command** aufgerufen wird, da in diesem Fall der Aufruf von **::http::geturl** erst zurückkehrt, wenn die HTTP-Transaktion abgeschlossen ist, und es nichts zu erwarten gibt.

**::http::status** *token*
: Dieser Befehl gibt eine Beschreibung des Status der HTTP-Transaktion zurück. Der Rückgabewert ist die leere Zeichenkette, bis die HTTP-Transaktion abgeschlossen ist; danach hat er einen der Werte ok, eof, error, timeout und reset. Die Bedeutung dieser Werte wird im Abschnitt **FEHLER** (unten) beschrieben.

> Der Name \"status\" steht in keinem Zusammenhang mit den Begriffen > \"status line\" und \"status code\", die für eine HTTP-Antwort definiert > sind.

**::http::size** *token*
: Dieser Befehl gibt die Anzahl der bisher vom URL im Aufruf von **::http::geturl** empfangenen Bytes zurück.

**::http::error** *token*
: Dieser Befehl gibt die Fehlerinformationen zurück, wenn die HTTP-Transaktion fehlgeschlagen ist, oder die leere Zeichenkette, wenn kein Fehler aufgetreten ist. Die Information ist eine Tcl-Liste aus Fehlermeldung, Stack-Trace und Fehlercode.

**::http::postError** *token*
: Eine POST-Anfrage ist ein Aufruf von **::http::geturl** mit der Option **-query** oder **-querychannel**. Der Befehl **::http::postError** gibt die Fehlerinformationen zurück, die entstehen, wenn eine HTTP-POST- Anfrage ihren Anfragekörper an den Server sendet; oder die leere Zeichenkette, wenn kein Fehler aufgetreten ist. Die Information ist eine Tcl-Liste aus Fehlermeldung, Stack-Trace und Fehlercode. Tritt dieser Fehlertyp auf, setzt der Befehl **::http::geturl** die Transaktion fort und versucht, eine Antwort vom Server zu empfangen.

**::http::cleanup** *token*
: Diese Prozedur bereinigt den mit der durch *token* identifizierten Verbindung verknüpften Zustand. Nach diesem Aufruf können Befehle wie **::http::responseBody** keine Informationen mehr über die Operation liefern. Es wird *dringend* empfohlen, diese Funktion aufzurufen, wenn eine HTTP-Anfrage abgeschlossen ist. Andernfalls wird Speicher nicht freigegeben; ruft Ihre Anwendung **::http::geturl** oft genug auf, kann das Speicherleck die Leistung beeinträchtigen \... oder schlimmer.

**::http::requestLine** *token*
: Dieser Befehl gibt die an den Server gesendete \"request line\" zurück. Die \"request line\" ist die erste Zeile einer HTTP- Client-Anfrage und hat drei durch Leerzeichen getrennte Elemente: die HTTP-Methode, die URL relativ zum Server und die HTTP-Version. Beispiele:

> GET / HTTP/1.1 GET /introduction.html?subject=plumbing HTTP/1.1 POST > /forms/order.html HTTP/1.1

**::http::requestHeaders** *token* ?*headerName*?
: Dieser Befehl gibt die Namen und Werte der HTTP-Anfrage-Header in der Reihenfolge zurück, in der sie an den Server gesendet wurden, als Tcl- Liste der Form ?name value \...? Header-Namen sind nicht case-sensitiv und werden in Kleinbuchstaben umgewandelt. Der Rückgabewert ist kein **dict**, weil einige Header-Namen mehrfach vorkommen können. Wird das zweite Argument nicht übergeben, werden alle Anfrage-Header zurückgegeben. Wird es übergeben, liefert es den Wert eines Header-Namens. Es werden nur Header mit dem angeforderten Namen (in Kleinbuchstaben) zurückgegeben. Werden keine solchen Header gefunden, wird eine leere Liste zurückgegeben.

**::http::requestHeaderValue** *token headerName*
: Dieser Befehl gibt den Wert des HTTP-Anfrage-Headers *headerName* zurück. Header-Namen sind nicht case-sensitiv und werden in Kleinbuchstaben umgewandelt. Existiert kein solcher Header, ist der Rückgabewert die leere Zeichenkette. Gibt es mehrere Header mit dem Namen *headerName*, wird das Ergebnis durch Verknüpfen der einzelnen Werte mit der Zeichenkette \", \" (Komma und Leerzeichen) erzeugt, wobei die Reihenfolge erhalten bleibt.

**::http::responseLine** *token*
: Dieser Befehl gibt die erste Zeile der Serverantwort zurück: die HTTP- \"status line\". Die \"status line\" hat drei durch Leerzeichen getrennte Elemente: die HTTP-Version, einen dreistelligen numerischen \"status code\" und eine \"reason phrase\". Nur die reason phrase darf Leerzeichen enthalten. Beispiele:

> HTTP/1.1 200 OK HTTP/1.0 404 Not Found

> Der \"status code\" ist eine dreistellige Zahl im Bereich 100 bis 599. Ein > Wert von 200 ist die normale Rückgabe einer GET-Anfrage; die zugehörige > \"reason phrase\" ist \"OK\". Codes, die mit 4 oder 5 beginnen, weisen auf > Fehler hin. Codes, die mit 3 beginnen, sind Weiterleitungsfehler. In diesem > Fall gibt der Antwort-Header **Location** eine neue URL an, die die > angeforderten Informationen enthält. > > Die \"reason phrase\" ist eine textuelle Beschreibung des \"status code\": > sie kann von Server zu Server variieren und kann ohne Auswirkung auf das > HTTP-Protokoll geändert werden. Die empfohlenen Werte (RFC 7231 und IANA- > Zuweisungen) für jeden Code liefert der Befehl **::http::reasonPhrase**.

**::http::responseCode** *token*
: Dieser Befehl gibt den \"status code\" (200, 404 usw.) der Server- \"status line\" zurück. Kann kein dreistelliger Code gefunden werden, wird die vollständige Statuszeile zurückgegeben. Siehe Befehl **::http::responseLine** für weitere Informationen zur \"status line\".

**::http::reasonPhrase** *code*
: Dieser Befehl gibt die von der IANA empfohlene \"reason phrase\" für einen bestimmten von einem HTTP-Server zurückgegebenen \"status code\" zurück. Das Argument *code* ist ein gültiger Statuscode und damit eine Ganzzahl im Bereich 100 bis 599 einschließlich. Für Zahlen in diesem Bereich ohne zugewiesene Bedeutung gibt der Befehl den Wert \"Unassigned\" zurück. Mehrere Statuscodes werden nur als Antwort auf die von HTTP-Erweiterungen wie WebDAV definierten Methoden verwendet und nicht als Antwort auf HEAD, GET oder POST.

> Die von einem HTTP-Server zurückgegebene \"reason phrase\" kann vom > empfohlenen Wert abweichen, ohne das HTTP-Protokoll zu beeinträchtigen. Der > von **::http::geturl** gelieferte Wert kann durch Aufruf von > **::http::responseLine** (vollständige Statuszeile) oder > **::http::responseInfo** (Dictionary mit der \"reason phrase\" im > Schlüssel *reasonPhrase*) ermittelt werden. > > Ein Register gültiger Statuscodes wird geführt unter > https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml

**::http::responseHeaders** *token* ?*headerName*?
: Die Antwort eines HTTP-Servers enthält Metadaten-Header, die den Antwortkörper und die Transaktion selbst beschreiben. Dieser Befehl gibt die Namen und Werte der HTTP-Antwort-Header in der Reihenfolge zurück, in der sie vom Server empfangen wurden, als Tcl-Liste der Form ?name value \...? Header-Namen sind nicht case-sensitiv und werden in Kleinbuchstaben umgewandelt. Der Rückgabewert ist kein **dict**, weil einige Header-Namen mehrfach vorkommen können, insbesondere **Set-Cookie**. Wird das zweite Argument nicht übergeben, werden alle Antwort-Header zurückgegeben. Wird es übergeben, liefert es den Wert eines Header-Namens. Es werden nur Header mit dem angeforderten Namen (in Kleinbuchstaben) zurückgegeben. Werden keine solchen Header gefunden, wird eine leere Liste zurückgegeben. Siehe Abschnitt **METADATEN** für weitere Informationen.

**::http::responseHeaderValue** *token headerName*
: Dieser Befehl gibt den Wert des HTTP-Antwort-Headers *headerName* zurück. Header-Namen sind nicht case-sensitiv und werden in Kleinbuchstaben umgewandelt. Existiert kein solcher Header, ist der Rückgabewert die leere Zeichenkette. Gibt es mehrere Header mit dem Namen *headerName*, wird das Ergebnis durch Verknüpfen der einzelnen Werte mit der Zeichenkette \", \" (Komma und Leerzeichen) erzeugt, wobei die Reihenfolge erhalten bleibt. Mehrere Header mit demselben Namen können so verarbeitet werden, außer **Set-Cookie**, das der Syntax einer durch Kommas getrennten Liste nicht entspricht und nicht zu einem einzelnen Wert zusammengefasst werden kann. Jeder **Set-Cookie**-Header muss einzeln verarbeitet werden, z. B. durch Auswertung des Rückgabewerts von **::http::responseHeaders** *token* **Set-Cookie**.

**::http::responseInfo** *token*
: Dieser Befehl gibt ein **dict** aus ausgewählten Antwort-Metadaten zurück, die für die Erkennung einer erfolgreichen Transaktion und die Nutzung der Antwort wesentlich sind, sowie weitere informative Metadaten. Die Schlüssel des **dict** sind *stage*, *status*, *responseCode*, *reasonPhrase*, *contentType*, *binary*, *redirection*, *upgrade*, *error*, *postError*, *method*, *charset*, *compression*, *httpRequest*, *httpResponse*, *url*, *connectionRequest*, *connectionResponse*, *connectionActual*, *transferEncoding*, *totalPost*, *currentPost*, *totalSize* und *currentSize*. Die Bedeutung dieser Schlüssel wird im Abschnitt **METADATEN** unten beschrieben.

Es lohnt sich stets, nach einer HTTP-Transaktion den Wert von *binary* zu prüfen, um festzustellen, ob ein falsch konfigurierter Server **http** veranlasst hat, eine Textressource als Binärdaten oder umgekehrt zu interpretieren.

Nach einer POST-Transaktion prüfen Sie den Wert von *postError*, um sicherzustellen, dass der Anfragekörper fehlerfrei hochgeladen wurde.

**::http::responseBody** *token*
: Dieser Befehl gibt die vom HTTP-Server gesendete Entität zurück (es sei denn, **-channel** wurde verwendet; dann wurde die Entität an den Kanal geliefert und der Befehl gibt die leere Zeichenkette zurück).

Weitere Begriffe für \"entity\" mit unterschiedlicher Genauigkeit sind \"Repräsentation der Ressource\", \"Ressource\", \"Antwortkörper nach Dekodierung\", \"Nutzlast\", \"Nachrichtenkörper nach Dekodierung\", \"Inhalt(e)\" und \"Datei\".

**::http::register** *proto port command* ?*socketCmdVarName*? ?*useSockThread*? ?*endToEndProxy*?
: Diese Prozedur ermöglicht benutzerdefinierte HTTP-Transporttypen wie HTTPS durch Registrierung eines Präfixes, des Standardports und des Befehls zum Erzeugen des Tcl-**channel**. Die optionalen Argumente konfigurieren, wie **http** den benutzerdefinierten Transport nutzt, und haben Standardwerte, die mit älteren Versionen von **http** kompatibel sind, in denen **::http::register** keine optionalen Argumente hat.

Das Argument *socketCmdVarName* ist der Name einer vom Transport bereitgestellten Variablen, deren Wert der Befehl ist, mit dem der Transport einen Socket öffnet. Sein Standardwert wird vom Transport gesetzt und lautet \"::socket\"; wird der Variablenname an **::http::register** übergeben, setzt **http** einen neuen Wert, um optionale Einrichtungen verfügbar zu machen. Diese werden durch die optionalen Argumente *useSockThread* und *endToEndProxy* aktiviert, die boolesche Werte mit Standardwert *false* annehmen.

Ist das Argument *useSockThread* angegeben und boolesch *true*, und erlaubt es der Wert von \[**http::config*** -threadlevel*\] sowie die Verfügbarkeit des Pakets **Thread**, werden für den Transport erzeugte Sockets in einem anderen Thread geöffnet, damit eine langsame DNS- Abfrage das Skript nicht blockiert.

Ist das Argument *endToEndProxy* angegeben und boolesch *true*, öffnet **http::geturl** beim Zugriff auf einen Server über einen Proxy einen Kanal durch Senden einer CONNECT-Anfrage an den Proxy und stellt die eigentliche Anfrage über diesen Kanal. Das ermöglicht Ende-zu-Ende- Verschlüsselung für HTTPS-Anfragen über einen Proxy.

Zum Beispiel,

```
package require http
package require tls

::http::register https 443 ::tls::socket ::tls::socketCmd 1 1

set token [::http::geturl https://my.secure.site/]
```

**::http::registerError** *sock* ?*message*?
: Diese Prozedur ermöglicht es einem registrierten Protokoll-Handler, eine Fehlermeldung für **http** bereitzustellen. Der Aufruf dieses Befehls löst keinen Fehler aus. Der Befehl ist nützlich, wenn ein registrierter Protokoll-Handler ein Problem erkennt (z. B. ein ungültiges TLS- Zertifikat), das einen Fehler bis zu **http** durchreichen lässt. Der Befehl ermöglicht **http**, eine präzise Fehlermeldung statt einer allgemeinen zu liefern. Der Befehl gibt den Wert des letzten Aufrufs mit Argument *message* zurück oder die leere Zeichenkette, wenn kein solcher Aufruf erfolgt ist.

**::http::unregister** *proto*
: Diese Prozedur hebt die Registrierung eines zuvor über **::http::register** registrierten Protokoll-Handlers auf und gibt eine sechselementige Liste der zuvor an **::http::register** übergebenen Werte zurück, falls ein solcher Handler existierte; andernfalls einen Fehler.

**::http::code** *token*
: Ein alternativer Name für den Befehl **::http::responseLine**

**::http::data** *token*
: Ein alternativer Name für den Befehl **::http::responseBody**.

**::http::meta** *token* ?*headerName*?
: Ein alternativer Name für den Befehl **::http::responseHeaders**

**::http::ncode** *token*
: Ein alternativer Name für den Befehl **::http::responseCode**
# FEHLER

Die Prozedur **::http::geturl** löst in folgenden Fällen Fehler aus: ungültige Befehlszeilenoptionen oder eine ungültige URL. Diese Fehler bedeuten, dass die Netzwerktransaktion gar nicht erst gestartet werden kann. Bei synchronen Aufrufen von **::http::geturl** (wenn **-command** nicht angegeben ist) wird ein Fehler ausgelöst, wenn die URL auf einem nicht existierenden Host liegt oder auf einem bestehenden Host an einem ungültigen Port. Es wird auch ein Fehler bei I/O-Fehlern beim Schreiben der HTTP-Anfragezeile und -Header oder beim Lesen der HTTP-Antwort-Header oder -Daten ausgelöst. Da **::http::geturl** in diesen Fällen keinen Token zurückgibt, führt es die erforderliche Bereinigung selbst durch; die Anwendung muss **::http::cleanup** nicht aufrufen.

Bei asynchronen Aufrufen von **::http::geturl** gelten alle obigen Fehlersituationen, außer dass beim Lesen der HTTP-Antwort-Header oder -Daten keine Ausnahme geworfen wird. Nach dem Schreiben der HTTP-Header kehrt **::http::geturl** zurück; der Rest der HTTP-Transaktion läuft im Hintergrund. Die Befehls-Rückruffunktion kann mit **::http::responseInfo** prüfen, ob beim Lesen ein Fehler aufgetreten ist.

Alternativ kann der Hauptprogrammfluss an einer Stelle **::http::wait** aufrufen und dann Status und Fehler prüfen, wie beim synchronen Aufruf.

Der Befehl **::http::geturl** führt die Rückruffunktionen **-command**, **-handler** und **-proxyfilter** innerhalb eines **catch**-Befehls aus. Ein Fehler in der Rückruffunktion ruft daher nicht den **bgerror**-Handler auf. Beim Debuggen einer dieser Rückruffunktionen kann es praktisch sein, Fehler innerhalb der Rückruffunktion selbst mit einem **catch**-Befehl zu melden, z. B. um eine Fehlermeldung nach stdout zu schreiben.

In jedem Fall müssen Sie dennoch **::http::cleanup** aufrufen, um das Status-Array zu löschen, wenn Sie fertig sind.

Weitere mögliche Ergebnisse der HTTP-Transaktion ergeben sich aus dem Status von **::http::status** (oder dem Wert des Schlüssels *status* im von **::http::responseInfo** zurückgegebenen Dictionary). Diese werden unten beschrieben.

ok
: Schließt die HTTP-Transaktion vollständig ab, ist der Status **ok**. Sie sollten dennoch den Wert von **::http::responseLine** prüfen, um den HTTP-Status zu erhalten. Die Prozedur **::http::responseCode** liefert nur den numerischen Code (z. B. 200, 404 oder 500), während **::http::responseLine** einen Wert wie

> HTTP 404 Datei nicht gefunden

zurückgibt.

eof
: Schließt der Server den Socket ohne Antwort, wird kein Fehler ausgelöst, aber der Status der Transaktion ist **eof**.

error
: Fehlermeldung, Stack-Trace und Fehlercode sind über **::http::error** zugänglich. Die Fehlermeldung wird auch durch den Wert des Schlüssels *error* im von **::http::responseInfo** zurückgegebenen Dictionary bereitgestellt.

timeout
: Ein Timeout ist aufgetreten, bevor die Transaktion abgeschlossen werden konnte.

reset
: Der Benutzer hat **::http::reset** aufgerufen.

\"\"
: (leere Zeichenkette) Die Transaktion ist noch nicht abgeschlossen.

Eine weitere Fehlermöglichkeit ist, dass **::http::geturl** den gesamten POST-Anfragekörper (**-query**- oder **-querychannel**-Daten) nicht an den Server schreiben konnte. **::http::geturl** speichert die Fehlermeldung für den späteren Abruf durch **::http::postError** oder **::http::responseInfo** und versucht dann, die Transaktion abzuschließen. Kann die Antwort des Servers gelesen werden, ist der Status **ok**; es ist jedoch wichtig, nach jedem POST **::http::postError** oder **::http::responseInfo** aufzurufen, um zu prüfen, ob die Daten vollständig gesendet wurden. Hat der Server die Verbindung geschlossen, ist der Status **eof**.

# METADATEN

## NÜTZLICHSTE METADATEN

Antwortet ein HTTP-Server auf eine Anfrage, liefert er nicht nur die angeforderte Entität, sondern auch Metadaten. Diese stammen aus der ersten Zeile (der \"status line\") der Antwort und aus einer Reihe von HTTP-Headern. Weitere Metadaten betreffen, wie **::http::geturl** die Antwort des Servers verarbeitet hat.

Die wichtigsten Metadaten sind mit dem Befehl **::http::responseInfo** zugänglich. Dieser Befehl gibt ein **dict** aus Metadaten zurück, die für die Erkennung einer erfolgreichen Transaktion und die Nutzung der Antwort wesentlich sind, sowie weitere informative Metadaten. Die Schlüssel des **dict** sind:

> > **===== Wesentliche Werte =====**

stage
: Dieser von **::http::geturl** gesetzte Wert beschreibt die erreichte Phase der Transaktion. Werte in der Reihenfolge des Transaktions- lebenszyklus sind: \"created\", \"connecting\", \"header\", \"body\" und \"complete\". Die anderen **dict**-Schlüssel stehen erst zur Verfügung, wenn **stage** \"body\" oder \"complete\" ist. Der Schlüssel **currentSize** hat seinen endgültigen Wert erst, wenn **stage** \"complete\" ist.

status
: Dieser von **::http::geturl** gesetzte Wert ist \"ok\" bei einer erfolgreichen Transaktion; \"eof\", \"error\", \"timeout\" oder \"reset\" bei einer fehlgeschlagenen Transaktion; oder \"\" solange die Transaktion noch läuft. Der Wert entspricht dem Rückgabewert von **::http::status**. Die Bedeutung dieser Werte wird im Abschnitt **FEHLER** (oben) beschrieben.

responseCode
: Der vom Server in der ersten Zeile (der \"status line\") der Antwort gesendete \"HTTP status code\". Kann der Wert nicht aus der Statuszeile extrahiert werden, wird die vollständige Statuszeile zurückgegeben.

reasonPhrase
: Die vom Server als Beschreibung des HTTP-Statuscodes gesendete \"reason phrase\". Kann der Wert nicht aus der Statuszeile extrahiert werden, wird die vollständige Statuszeile zurückgegeben.

contentType
: Der Wert des Antwort-Headers **Content-Type** oder, falls der Header nicht geliefert wurde, der Standardwert \"application/octet-stream\".

binary
: Dieser boolesche, von **::http::geturl** gesetzte Wert beschreibt, wie der Befehl die vom Server zurückgegebene Entität (nach Dekodierung einer in **Content-Encoding** angegebenen Kompression) interpretiert hat. Auf diese dekodierte Entität greift der Rückgabewert von **::http::responseBody** zu.

> Der Wert ist **true**, wenn **http** die dekodierte Entität als Binärdaten > interpretiert hat. Der Rückgabewert von **::http::responseBody** ist dann > eine Tcl-Binärzeichenkette. Das eignet sich für Bilddaten, Zip-Dateien usw. > **::http::geturl** wählt diesen Wert, wenn der Benutzer die Option > **-binary** übergeben hat, der Server einen binären Content-Type in einem > **Content-Type**-Antwort-Header geliefert hat oder keinen **Content-Type**- > Header gesendet hat. > > Der Wert ist in anderen Fällen **false**; dann hat **http** die dekodierte > Entität als Text interpretiert. Der Text wurde aus dem vom Server > angegebenen Zeichensatz in Tcls internes Unicode-Format konvertiert; der > Rückgabewert von **::http::responseBody** ist eine gewöhnliche Tcl- > Zeichenkette. > > Es lohnt sich stets, nach einer HTTP-Transaktion den Wert von \"binary\" zu > prüfen, um festzustellen, ob ein falsch konfigurierter Server **http** > veranlasst hat, eine Textressource als Binärdaten oder umgekehrt zu > interpretieren.

redirection
: Die URL, die Ziel der Weiterleitung ist. Der Wert stammt vom Antwort- Header **Location**. Dieser Header wird gesendet, wenn die Antwort den Statuscode 3XX (Weiterleitung) hat.

upgrade
: Ist der Wert nicht leer, gibt er die Protokoll(e) an, auf die der Server nach Abschluss dieser Transaktion bei weiterhin derselben Verbindung wechseln wird. Will der Server das Protokoll wechseln, sendet er außerdem \"101\" als Statuscode (Schlüssel **responseCode**), das Wort \"upgrade\" als Element des Antwort-Headers **Connection** (Schlüssel **connectionResponse**) und keinen Antwortkörper. Siehe Abschnitt **PROTOKOLL-UPGRADES** für weitere Informationen.

error
: Die Fehlermeldung, falls vorhanden. Weitere Informationen einschließlich Stack-Trace und Fehlercode liefert **::http::error**.

postError
: Die Fehlermeldung (falls vorhanden), die entsteht, wenn eine HTTP-POST- Anfrage ihren Anfragekörper an den Server sendet. Weitere Informationen liefert **::http::postError**. Eine POST-Transaktion kann laut den Schlüsseln **stage**, **status** und **responseCode** abgeschlossen erscheinen; es ist jedoch wichtig, **postError** zu prüfen, falls beim Hochladen des Anfragekörpers ein Fehler aufgetreten ist.

> > **===== Informative Werte =====**

method
: Die in der Anfrage verwendete HTTP-Methode.

charset
: Der Wert des charset-Attributs des Antwort-Headers **Content-Type**. Der charset-Wert wird nur für Textressourcen verwendet. Hat der Server keinen charset angegeben, gilt der Wert der Variable **::http::defaultCharset**, die, sofern der Aufrufer sie nicht geändert hat, **iso8859-1** ist. Eingehende Textdaten werden automatisch aus dem durch **charset** definierten Zeichensatz in Tcls interne Unicode-Darstellung, d. h. in eine Tcl-Zeichenkette, konvertiert.

compression
: Eine Kopie des Werts des Antwort-Headers **Content-Encoding**.

httpRequest
: Die in der Anfrage angegebene HTTP-Version (in der Anfragezeile gesendet). Der Wert entspricht der Option **-protocol** von **::http::geturl** (Standard \"1.1\"), sofern der Befehl den Wert nicht auf \"1.0\" herabsetzte, weil **-handler** übergeben wurde.

httpResponse
: Die vom Server verwendete HTTP-Version (aus der Antwort-\"status line\"). Der Server verwendet diese Version in der Antwort, stellt aber sicher, dass die Antwort mit der in der Client-Anfrage angegebenen HTTP-Version kompatibel ist. Kann der Wert nicht aus der Statuszeile extrahiert werden, wird die vollständige Statuszeile zurückgegeben.

url
: Die angeforderte URL, typischerweise die als Argument an **::http::geturl** übergebene URL ohne ihr \"Fragment\" (der letzte Teil der URL ab \"#\").

connectionRequest
: Der Wert, falls vorhanden, der dem Server in **Connection**- Anfrage-Header(n) gesendet wurde.

connectionResponse
: Der Wert, falls vorhanden, der vom Server in **Connection**- Antwort-Header(n) empfangen wurde.

connectionActual
: Dieser von **::http::geturl** gesetzte Wert gibt an, ob die Verbindung nach der Transaktion geschlossen wurde (Wert \"close\") oder offen blieb (Wert \"keep-alive\").

transferEncoding
: Der Wert des Antwort-Headers Transfer-Encoding, falls vorhanden. Der Wert ist entweder \"chunked\" (HTTP/1.1 \"chunked encoding\") oder die leere Zeichenkette.

totalPost
: Die Gesamtlänge des Anfragekörpers einer POST-Anfrage.

currentPost
: Die Anzahl der Bytes des POST-Anfragekörpers, die bisher an den Server gesendet wurden. Der Wert entspricht dem Rückgabewert von **::http::size**.

totalSize
: Eine Kopie des Werts des Antwort-Headers **Content-Length**. Die in einem **Content-Length**-Header angegebene Byteanzahl, falls gesendet. Wurde keiner gesendet, ist der Wert 0. Ein korrekt konfigurierter Server lässt diesen Header weg, wenn die Transfer-Kodierung \"chunked\" ist, oder (bei älteren Servern) wenn der Server die Verbindung am Ende der Ressource schließt.

currentSize
: Die bisher vom Server abgerufene Byteanzahl.

## WEITERE METADATEN

Das von **::http::responseInfo** zurückgegebene Dictionary ist die nützlichste Teilmenge der verfügbaren Metadaten. Weitere Metadaten umfassen:

1\. Die vollständige \"status line\" der Antwort, verfügbar als Rückgabewert von **::http::responseLine**.

2\. Die vollständigen Antwort-Header, verfügbar als Rückgabewert von **::http::responseHeaders**. Der Rückgabewert ist eine Liste der Namen und Werte der Antwort-Header in der Empfangsreihenfolge vom Server.

Der Rückgabewert ist kein **dict**, weil einige Header-Namen mehrfach vorkommen können, insbesondere **Set-Cookie**. Wird der Wert in ein **dict** oder ein Array gelesen (mit array set), bleibt nur der letzte Header mit jedem Namen erhalten.

> Einige der Header-Namen (Metadaten-Schlüssel) sind unten aufgeführt; der > HTTP-Standard definiert jedoch weitere, und Server können eigene hinzufügen. > Wird unten ein Dictionary-Schlüssel erwähnt, bezieht sich das auf den von > **::http::responseInfo** zurückgegebenen **dict**-Wert. > > Content-Type > > :   Der Content-Type des URL-Inhalts. Beispiele sind **text/html**, >     **image/gif,** **application/postscript** und **application/x-tcl**. >     Textwerte geben typischerweise einen Zeichensatz an, z. B. **text/html; >     charset=UTF-8**. Dictionary-Schlüssel *contentType*. > > Content-Length > > :   Die angegebene Größe des Inhalts in Bytes, verfügbar als Dictionary- >     Schlüssel *totalSize*. Die tatsächlich von **::http::geturl** bisher >     gelesene Byteanzahl ist Dictionary-Schlüssel *currentSize*. > > Content-Encoding > > :   Der für den Inhalt verwendete Kompressionsalgorithmus. Beispiele sind >     **gzip**, **deflate**. Dictionary-Schlüssel *compression*. > > Location > > :   Dieser Header wird gesendet, wenn die Antwort den Statuscode 3XX >     (Weiterleitung) hat. Er liefert die URL, die Weiterleitungsziel ist. >     Dictionary-Schlüssel *redirection*. > > Set-Cookie > > :   Dieser Header bietet dem Client ein Cookie an. Die Cookie-Verwaltung >     erfolgt über die Option **-cookiejar** von **::http::config**; die >     **Set-Cookie**-Header müssen daher nicht von Benutzerskripten geparst >     werden. Siehe Abschnitt **COOKIE-JAR-PROTOKOLL**. > > Connection > > :   Der Wert kann als durch Kommas getrennte Liste oder durch mehrere >     Header geliefert werden. Die Liste hat oft nur ein Element, entweder >     \"close\" oder \"keep-alive\". Der Wert \"upgrade\" zeigt eine >     erfolgreiche Upgrade-Anfrage an und wird typischerweise mit Statuscode >     101, einem **Upgrade**-Antwort-Header und ohne Antwortkörper kombiniert. >     Dictionary-Schlüssel *connectionResponse*. > > Upgrade > > :   Der Wert gibt die Protokoll(e) an, auf die der Server unmittelbar nach >     der leeren Zeile, die die 101-Antwort-Header beendet, wechselt. >     Dictionary-Schlüssel *upgrade*.

## NOCH WEITERE METADATEN

1.  Details der HTTP-Anfrage. Die Anfrage wird durch die an **::http::geturl** und **::http::config** übergebenen Optionen bestimmt. Es ist manchmal hilfreich zu prüfen, was **::http::geturl** tatsächlich an den Server gesendet hat; diese Informationen sind über **::http::requestHeaders** und **::http::requestLine** verfügbar.

2.  Das Status-Array: die internen Variablen von **::http::geturl**. Es kann manchmal hilfreich sein, dieses Array zu untersuchen. Details im nächsten Abschnitt.

# STATUS-ARRAY

Die Prozedur **::http::geturl** gibt einen *token* zurück, der als Argument an andere **::http::\***-Befehle übergeben werden kann, die den Zustand der HTTP-Transaktion untersuchen und verwalten. Für die meisten Zwecke reichen diese Befehle. Der *token* kann auch verwendet werden, um auf den internen Zustand der Transaktion zuzugreifen, der in einem Tcl-Array gespeichert ist. Das ist besonders nützlich beim Schreiben von Rückruffunktionen für die Optionen **-command**, **-handler**, **-progress** oder **-queryprogress**. Verwenden Sie innerhalb der Prozedur folgenden Befehl, um ein leicht nutzbares Array *state* als lokale Variable in der Prozedur zu definieren:

```
upvar 0 $token state
```

Sind die mit der URL verknüpften Daten nicht mehr nötig, sollte das Array entfernt werden, um Speicher freizugeben. Dafür dient die Prozedur **::http::cleanup**.

Die folgenden Array-Elemente werden unterstützt und sind die Quelle der von Befehlen zurückgegebenen Werte, wie unten beschrieben. Wird unten ein Dictionary-Schlüssel erwähnt, bezieht sich das auf den von **::http::responseInfo** zurückgegebenen **dict**-Wert.

> binary > > :   Für Dictionary-Schlüssel *binary*. > > body > > :   Für Befehl **::http::responseBody**. > > charset > > :   Für Dictionary-Schlüssel *charset*. > > coding > > :   Für Dictionary-Schlüssel *compression*. > > connection > > :   Für Dictionary-Schlüssel *connectionActual*. > > currentsize > > :   Für Befehl **::http::size**; und für Dictionary-Schlüssel *currentSize*. > > error > > :   Für Befehl **::http::error**; ein Teil wird im Dictionary-Schlüssel >     *error* verwendet. > > http > > :   Für Befehl **::http::responseLine**. > > httpResponse > > :   Für Dictionary-Schlüssel *httpResponse*. > > meta > > :   Für Befehl **::http::responseHeaders**. Weitere Erläuterung oben im >     Abschnitt **WEITERE METADATEN**. > > method > > :   Für Dictionary-Schlüssel *method*. > > posterror > > :   Für Dictionary-Schlüssel *postError*. > > postErrorFull > > :   Für Befehl **::http::postError**. > > -protocol > > :   Für Dictionary-Schlüssel *httpRequest*. > > querylength > > :   Für Dictionary-Schlüssel *totalPost*. > > queryoffset > > :   Für Dictionary-Schlüssel *currentPost*. > > reasonPhrase > > :   Für Dictionary-Schlüssel *reasonPhrase*. > > requestHeaders > > :   Für Befehl **::http::requestHeaders**. > > requestLine > > :   Für Befehl **::http::requestLine**. > > responseCode > > :   Für Dictionary-Schlüssel *responseCode*. > > state > > :   Für Dictionary-Schlüssel *stage*. > > status > > :   Für Befehl **::http::status**; und für Dictionary-Schlüssel *status*. > > totalsize > > :   Für Dictionary-Schlüssel *totalSize*. > > transfer > > :   Für Dictionary-Schlüssel *transferEncoding*. > > type > > :   Für Dictionary-Schlüssel *contentType*. > > upgrade > > :   Für Dictionary-Schlüssel *upgrade*. > > url > > :   Für Dictionary-Schlüssel *url*.

# PERSISTENTE VERBINDUNGEN

## GRUNDLAGEN

Siehe RFC 7230 Abschnitt 6, der RFC 2616 Abschnitt 8.1 ablöst.

Eine persistente Verbindung ermöglicht mehrere HTTP/1.1-Transaktionen über dieselbe TCP-Verbindung. Pipelining ermöglicht es einem Client, mehrere Anfragen über eine persistente Verbindung zu senden, ohne auf jede Antwort zu warten. Der Server sendet Antworten in derselben Reihenfolge, in der die Anfragen empfangen wurden.

Schlägt eine POST-Anfrage fehl, ist typischerweise eine Bestätigung des Benutzers nötig, bevor die Anfrage erneut gesendet wird. Der Benutzer möchte prüfen, ob der Server durch die fehlgeschlagene POST-Anfrage verändert wurde, bevor dieselbe Anfrage erneut gesendet wird.

Eine HTTP-Anfrage verwendet einen persistenten Socket, wenn der Aufruf von **http::geturl** die Option **-keepalive true** hat. Pipelining wird angewendet, wo erlaubt, wenn die **http::config**-Option **-pipeline** boolesch **true** ist (ihr Standardwert).

Das http-Paket hält höchstens eine persistente Verbindung zu jedem Server (d. h. zu jedem Wert von *domain:port*).

Wird **http::geturl** aufgerufen, um eine Anfrage über eine persistente Verbindung zu stellen, während die Verbindung mit einer anderen Anfrage beschäftigt ist, wird die neue Anfrage in eine Warteschlange gestellt, bis die Verbindung frei ist.

Das http-Paket unterstützt keine HTTP/1.0-persistenten Verbindungen, die durch den Header **Keep-Alive** gesteuert werden.

## SONDERFÄLLE

Dieser Unterabschnitt behandelt Fragen im Zusammenhang mit dem Schließen der persistenten Verbindung durch den Server, automatische Wiederholung fehlgeschlagener Anfragen, die besondere Behandlung von POST-Anfragen und die Optionen zum Umgang mit diesen Fällen.

Gemäß RFC 7230 pipelined **http::geturl** keine Anfragen mit der POST-Methode. Nutzt eine POST-Anfrage eine persistente Verbindung und ist nicht die erste Anfrage auf dieser Verbindung, wartet **http::geturl**, bis die Antwort auf die vorherige Anfrage empfangen wurde; oder (wenn die **http::config**-Option **-postfresh** boolesch **true** ist) verwendet es für jede POST-Anfrage eine neue Verbindung.

Verarbeitet der Server mehrere gepipelinete Anfragen und sendet er mit einer der Antworten (außer der letzten) einen Antwort-Header

Connection: close

, bleiben nachfolgende Antworten unerfüllt. **http::geturl** sendet die unerfüllten Anfragen erneut über eine neue Verbindung.

Eine Schwierigkeit entsteht, wenn ein HTTP-Client eine Anfrage über eine persistente Verbindung sendet, die eine Weile untätig war. Der HTTP-Server kann eine scheinbar untätige Verbindung halb schließen, während der Client eine Anfrage sendet, aber bevor die Anfrage den Server erreicht: in diesem Fall (ein **asynchronous close event**) schlägt die Anfrage fehl. Die Schwierigkeit entsteht, weil der Client nicht sicher sein kann, ob die POST den Zustand des Servers verändert hat. Bei HEAD- oder GET-Anfragen öffnet **http::geturl** eine weitere Verbindung und sendet die fehlgeschlagene Anfrage erneut. War die Anfrage jedoch eine POST-Anfrage, verbietet RFC 7230 standardmäßig eine automatische Wiederholung und schlägt entweder eine Benutzerbestätigung oder eine Bestätigung durch User-Agent- Software mit semantischem Verständnis der Anwendung vor. Die **http::config**- Option **-repost** ermöglicht beide Möglichkeiten.

Asynchrone Schließ-Ereignisse können nur in einem kurzen Zeitintervall auftreten. Das Paket **http** überwacht jede persistente Verbindung auf Schließung durch den Server. Nach Erkennung wird die Verbindung auch auf der Client-Seite geschlossen; nachfolgende Anfragen verwenden eine frische Verbindung.

Wird **http::geturl** mit der Option **-keepalive true** aufgerufen, versucht es sowohl eine bestehende persistente Verbindung zu nutzen (falls verfügbar), als auch dem Server einen Anfrage-Header

Connection: keep-alive

zu senden, der die Verbindung für künftige Anfragen offen halten soll.

Die **http::config**-Optionen **-pipeline**, **-postfresh** und **-repost** betreffen persistente Verbindungen.

Ist die Option **-pipeline** boolesch **true**, werden GET- und HEAD-Anfragen über eine persistente Verbindung gepipelined. POST-Anfragen werden nicht gepipelined — ist die POST-Anfrage nicht die erste Transaktion auf der Verbindung, wird ihre Anfrage erst gesendet, wenn die vorherige Antwort abgeschlossen ist. GET- und HEAD-Anfragen nach einer POST-Anfrage werden erst gesendet, wenn die POST-Antwort geliefert wurde, und nicht, wenn die POST- Anfrage fehlschlägt.

Ist die Option **-postfresh** boolesch **true**, überschreibt sie die Option **-keepalive** von **http::geturl** und öffnet für jede POST-Anfrage stets eine frische Verbindung.

Ist die Option **-repost** **true**, ist die automatische Wiederholung einer POST-Anfrage erlaubt, die fehlschlägt, weil sie eine persistente Verbindung nutzt, die der Server halb geschlossen hat (ein **asynchronous close event**).

Nachfolgende GET- und HEAD-Anfragen in einer fehlgeschlagenen Pipeline werden ebenfalls wiederholt. *Die Option **-repost** sollte nur verwendet werden, wenn die Anwendung versteht*, dass die Wiederholung angemessen ist — die Anwendung muss wissen, dass eine Wiederholung der POST-Anfrage keine nachteiligen Auswirkungen hat, falls die fehlgeschlagene POST den Serverzustand erfolgreich verändert hat.

# COOKIE-JAR-PROTOKOLL

::: {.info -version="TIP406"}
Cookies sind kurze Schlüssel-Wert-Paare zur Implementierung von Sitzungen im ansonsten zustandslosen HTTP-Protokoll. (Details siehe RFC 6265; Tcl implementiert das Cookie2-Protokoll nicht, da es in der Praxis selten vorkommt.)

Cookie-Speicherverwaltungsbefehle — **cookie jars** — müssen diese Unterbefehle unterstützen, die das HTTP-Cookie- Speicherverwaltungsprotokoll bilden. *cookieJar* unten muss kein Befehlsname sein; es ist ein Befehlspräfix (eine Tcl-Liste von Wörtern, die an Ort und Stelle expandiert wird) und lässt viele Implementierungen zu.

Obwohl nicht formell Teil des Protokolls, wird erwartet, dass bestimmte Werte von *cookieJar* Sitzungen entsprechen; es liegt beim Aufrufer von **::http::config**, welche Sitzung gilt und wann diese Sitzungen gelöscht werden, wenn sie nicht mehr gewünscht sind (was der Fall sein sollte, wenn sie nicht mehr als aktueller Cookie-Jar konfiguriert sind).
:::

*cookieJar* **getCookies** *protocol host requestPath*
: Dieser Befehl fragt den Cookie-Jar, welche Cookies für eine bestimmte Anfrage geliefert werden sollen. Er soll *protocol* (typischerweise **http** oder **https**), *host* und *requestPath* (aus dem *url*- Argument von **::http::geturl** geparst) entgegennehmen und eine Liste von Cookie-Schlüsseln und -Werten zurückgeben, die die an den Remote-Host zu sendenden Cookies beschreiben. Die Liste muss eine gerade Anzahl von Elementen haben.

::: {.info -version="TIP406"}
Pro Anfrage sollte höchstens ein Cookie mit einem bestimmten Schlüssel existieren (typischerweise das mit der spezifischsten *host*/domain- und *requestPath*/path-Übereinstimmung), aber es kann viele Cookies mit unterschiedlichen Namen in einer Anfrage geben.
:::

*cookieJar* **storeCookie** *cookieDictionary*
: Dieser Befehl bittet den Cookie-Jar, ein bestimmtes Cookie zu speichern, das von einer Anfrage zurückgegeben wurde; das Ergebnis dieses Befehls wird ignoriert. Das Cookie (vom http-Paket geparst) wird durch ein Dictionary *cookieDictionary* beschrieben, das folgende Schlüssel haben kann:

domain
: Immer vorhanden. Sein Wert beschreibt den Domänen-Hostnamen *oder* das Präfix, für das das Cookie zurückgegeben werden soll. Die Prüfung der Domäne gegen den Ursprung (unten) soll sorgfältig erfolgen, da Sites, die Cookies ausstellen, dies nur für mit ihnen verbundene Domänen tun sollten. Cookies, die keine relevante Origin-Matching- Regel einhalten, sind zu ignorieren.

expires
: Optional. Ist er vorhanden, ist das Cookie als persistentes Cookie gedacht; der Wert ist der Tcl-Zeitstempel (in Sekunden zur gleichen Basis wie **clock seconds**) des Ablaufzeitpunkts (der in der Vergangenheit liegen kann; dann soll das Cookie sofort gelöscht werden). Fehlt er, ist das Cookie ein Sitzungs-Cookie, das nicht über die Lebensdauer des Cookie-Jars hinaus persistiert werden soll.

hostonly
: Immer vorhanden. Sein Wert ist ein Boolescher Wert, der angibt, ob es ein Single-Host-Cookie (**true**) oder ein Domänen-Cookie (**false**) ist.

httponly
: Immer vorhanden. Sein Wert ist **true**, wenn die Site wünscht, dass das Cookie nur mit HTTP- (oder HTTPS-)Verkehr verwendet wird.

key
: Immer vorhanden. Sein Wert ist der *key* des Cookies, Teil der Information, die beim erneuten Senden dieses Cookies in einer künftigen Anfrage zurückgegeben werden muss.

origin
: Immer vorhanden. Sein Wert beschreibt, wo das http-Paket glaubt, das Cookie erhalten zu haben; nützlich zur Prüfung, ob die Domäne des Cookies gültig ist.

path
: Immer vorhanden. Sein Wert beschreibt das Pfadpräfix von Anfragen an die Cookie-Domäne, für die das Cookie zurückgegeben werden soll.

secure
: Immer vorhanden. Sein Wert ist **true**, wenn das Cookie nur bei Anfragen über sichere Kanäle (typischerweise HTTPS) verwendet werden soll.

value
: Immer vorhanden. Sein Wert ist der Wert des Cookies, Teil der Information, die beim erneuten Senden in einer künftigen Anfrage zurückgegeben werden muss.

Andere Schlüssel können stets ignoriert werden; sie haben in diesem Protokoll keine Bedeutung.

# PROTOKOLL-UPGRADES

Die HTTP/1.1-Anfrage-Header **Connection** und **Upgrade** teilen dem Server mit, dass der Client das über die bestehende Verbindung genutzte Protokoll ändern möchte (RFC 7230). Dieser Mechanismus kann einen WebSocket (RFC 6455), eine höhere HTTP-Version (HTTP 2) oder TLS-Verschlüsselung anfordern. Nimmt der Server die Upgrade-Anfrage an, lautet sein Antwortcode 101.

Um beim Aufruf von **http::geturl** ein Protokoll-Upgrade anzufordern, muss die Option **-headers** passende Werte für **Connection** und **Upgrade** liefern, und die Option **-command** muss einen Befehl liefern, der das angeforderte Protokoll implementiert und auch die Serverantwort verarbeiten kann, wenn der Server das Upgrade ablehnt. Bei Upgrade-Anfragen ignoriert **http::geturl** den Wert der Option **-keepalive** und verwendet stets **0**, damit die Upgrade- Anfrage nicht über eine Verbindung erfolgt, die für mehrere HTTP-Anfragen gedacht ist.

Die Tcllib-Bibliothek **websocket** implementiert WebSockets und ruft die nötigen Befehle im Paket **http** auf.

Derzeit gibt es keine native Tcl-Client-Bibliothek für HTTP/2.

Der **Upgrade**-Mechanismus wird in Webbrowsern nicht verwendet, um TLS anzufordern, weil **http** und **https** über unterschiedliche Ports laufen. Er wird von Protokollen wie Internet Printing Protocol (IPP) verwendet, die auf **http(s)** aufbauen und dieselbe TCP-Portnummer für sichere und unsichere Verbindungen nutzen.

In Browsern wird opportunistische Verschlüsselung stattdessen durch den Client-Header **Upgrade-Insecure-Requests** umgesetzt. Ist ein sicherer Dienst verfügbar, lautet der Server-Antwortcode eine 307-Weiterleitung, und der Antwort-Header **Location** gibt die Ziel-URL an. Der Browser muss **http::geturl** erneut aufrufen, um diese URL abzurufen. Siehe https://w3c.github.io/webappsec-upgrade-insecure-requests/

# THREADS

## ZWECK

Der Befehl **::http::geturl** verwendet den Tcl-Befehl **::socket** mit der Option **-async**, um eine Verbindung zu einem Remote-Server herzustellen; die Rückkehr dieses Befehls kann in ungünstigen Fällen verzögert sein (z. B. bei einer langsamen DNS-Abfrage) und verhindert, dass die Ereignisschleife andere Ereignisse verarbeitet. Diese Verzögerung entfällt, wenn **::socket** in einem anderen Thread ausgewertet wird. Das Thread-Paket ist nicht Teil von Tcl, wird aber in \"Batteries Included\"-Distributionen mitgeliefert. Statt **::socket** verwendet das http-Paket **::http::socket**, das Verbindungen gemäß dem Wert von **-threadlevel** und der Verfügbarkeit des Pakets Thread herstellt.

## MIT TLS (HTTPS)

Dieselbe **-threadlevel**-Konfiguration gilt für HTTP- und HTTPS-Verbindungen. HTTPS wird durch **http::register** aktiviert, typischerweise durch Angabe des Befehls **::tls::socket** des tls-Pakets für TLS-Kryptografie. **::tls::socket** verbindet zum Remote-Server mit dem Befehl, der durch den Wert der Variable **::tls::socketCmd** angegeben ist; dieser Standardwert ist \"::socket\". Findet http::geturl, dass **::tls::socketCmd** diesen Wert hat, ersetzt es ihn durch \"::http::socket\". Hat **::tls::socketCmd** einen anderen Wert als \"::socket\", d. h. hat das Skript oder die Tcl-Installation den Wert \"::socket\" durch einen anderen Befehlsnamen ersetzt, ändert http den Wert nicht. Das Skript oder die Installation, die **::tls::socketCmd** geändert hat, ist dafür verantwortlich, **::http::socket** in den eigenen Ersatzbefehl zu integrieren.

## MIT EINEM UNTER-INTERPRETER

Der Peer-Thread kann den Socket nur an den Haupt-Interpreter des Threads des Skripts übertragen. Daher funktioniert der thread-basierte **::http::socket** mit **-threadlevel**-Werten ungleich 0 nur, wenn das Skript im Haupt-Interpreter läuft. Ein Unter-Interpreter muss **-threadlevel 0** verwenden, sofern der Eltern-Interpreter keine alternativen Einrichtungen bereitgestellt hat. Der Haupt-Eltern-Interpreter kann einem Unter-Interpreter volle **-threadlevel**- Einrichtungen gewähren, z. B. durch Aliasierung von **::http::socket** im Kind auf einen Befehl, der **http::socket** im Eltern ausführt und den Socket dann an das Kind überträgt.

# BEISPIELE

Dieses Beispiel erstellt eine Prozedur zum Kopieren einer URL in eine Datei mit Fortschrittsanzeige und gibt die mit der URL verknüpften Antwort-Header aus.

```
proc httpcopy { url file {chunk 4096} } {
    set out [open $file w]
    set token [::http::geturl $url -channel $out \
            -progress httpCopyProgress -blocksize $chunk]
    close $out

    # Beendet die von httpCopyProgress begonnene Zeile
    puts stderr ""

    upvar 0 $token state
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
