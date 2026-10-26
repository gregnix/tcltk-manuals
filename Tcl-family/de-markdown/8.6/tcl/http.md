---
CommandName: http
title: http
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

# Name

http - Clientseitige Implementierung des HTTP/1.1-Protokolls

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [http]{.lit} [?2.9?]{.lit}
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

# Exportierte Befehle

Der Namespace **http** exportiert die Befehle **config**, **formatQuery**, **geturl**, **quoteString**, **register**, **registerError**, **reset**, **unregister** und **wait**.

Er exportiert nicht die Befehle **cleanup**, **code**, **data**, **error**, **meta**, **ncode**, **size** oder **status**.

# Beschreibung

Das Paket **http** stellt die Client-Seite des HTTP/1.1-Protokolls bereit, wie in RFC 7230 bis RFC 7235 definiert, die RFC 2616 ablösen. Das Paket implementiert die GET-, POST- und HEAD-Operationen von HTTP/1.1. Es ermöglicht die Konfiguration eines Proxy-Hosts, um Firewalls zu passieren. Das Paket ist mit der **Safesock**-Sicherheitsrichtlinie kompatibel und kann daher von nicht vertrauenswürdigen Applets zum Abrufen von URLs von einer eingeschränkten Menge von Hosts verwendet werden. Dieses Paket kann erweitert werden, um zusätzliche HTTP-Transportprotokolle wie HTTPS zu unterstützen, indem ein benutzerdefinierter [socket]-Befehl über **::http::register** bereitgestellt wird.

Die Prozedur **::http::geturl** führt eine HTTP-Transaktion aus. Ihre *options* bestimmen, ob eine GET-, POST- oder HEAD-Transaktion ausgeführt wird. Der Rückgabewert von **::http::geturl** ist ein Token für die Transaktion. Dieser Wert ist zugleich der Name eines Arrays im Namespace ::http, das Zustandsinformationen zur Transaktion enthält. Die Elemente dieses Arrays werden im Abschnitt [Status-Array] beschrieben.

Ist die Option **-command** angegeben, wird die HTTP-Operation im Hintergrund ausgeführt. **::http::geturl** kehrt unmittelbar nach dem Erzeugen der HTTP-Anfrage zurück, und die Rückruffunktion wird aufgerufen, wenn die Transaktion abgeschlossen ist. Damit dies funktioniert, muss die Tcl-Ereignisschleife aktiv sein. In Tk-Anwendungen ist dies stets der Fall. In reinen Tcl-Anwendungen kann der Aufrufer nach dem Aufruf von **::http::geturl** **::http::wait** verwenden, um die Ereignisschleife zu starten.

**Hinweis:** Die Ereigniswarteschlange wird auch ohne die Option **-command** verwendet. Als Nebeneffekt können beliebige Befehle verarbeitet werden, während **http::geturl** läuft.

# Befehle

**::http::config** ?*options*?
: Der Befehl **::http::config** dient zum Setzen und Abfragen des Namens des Proxy-Servers und -Ports sowie des in den HTTP-Anfragen verwendeten User-Agent-Namens. Sind keine Optionen angegeben, wird die aktuelle Konfiguration zurückgegeben. Ist ein einzelnes Argument angegeben, sollte es eine der unten beschriebenen Flags sein; in diesem Fall wird der aktuelle Wert dieser Einstellung zurückgegeben. Andernfalls sollten die Optionen eine Menge von Flags und Werten sein, die die Konfiguration definieren:

    **-accept** *mimetypes*
    : Der Accept-Header der Anfrage. Der Standardwert ist \*/\*, was bedeutet, dass alle Dokumenttypen akzeptiert werden. Andernfalls können Sie eine durch Kommas getrennte Liste von MIME-Typ-Mustern angeben, die Sie empfangen möchten. Zum Beispiel "image/gif, image/jpeg, text/\*".

    **-pipeline** *boolean*
    : Legt fest, ob HTTP/1.1-Transaktionen auf einem persistenten Socket gepipelined werden. Siehe Abschnitt **PERSISTENTE SOCKETS** für Details. Der Standardwert ist 1.

    **-postfresh** *boolean*
    : Legt fest, ob Anfragen, die die Methode **POST** verwenden, stets einen frischen Socket nutzen und damit die Option **-keepalive** des Befehls **http::geturl** überschreiben. Siehe Abschnitt **PERSISTENTE SOCKETS** für Details. Der Standardwert ist 0.

    **-proxyhost** *hostname*
    : Der Name des Proxy-Hosts, falls vorhanden. Ist dieser Wert die leere Zeichenkette, wird der URL-Host direkt kontaktiert.

    **-proxyport** *number*
    : Die Proxy-Portnummer.

    **-proxyfilter** *command*
    : Der Befehl ist eine Rückruffunktion, die während **::http::geturl** aufgerufen wird, um zu ermitteln, ob für einen bestimmten Host ein Proxy erforderlich ist. Beim Aufruf wird dem *command* ein Argument, ein Hostname, angehängt. Ist ein Proxy erforderlich, soll die Rückruffunktion eine zweielementige Liste mit Proxy-Server und Proxy-Port zurückgeben. Andernfalls soll der Filterbefehl eine leere Liste zurückgeben. Der Standardfilter gibt die Werte der Einstellungen **-proxyhost** und **-proxyport** zurück, falls diese nicht leer sind.

        Der Befehl **::http::geturl** führt die **-proxyfilter**-Rückruffunktion innerhalb eines [catch]-Befehls aus. Ein Fehler in der Rückruffunktion ruft daher nicht den [bgerror]-Handler auf. Siehe Abschnitt [Fehler] für Details.

    **-repost** *boolean*
    : Legt fest, was zu tun ist, wenn eine POST-Anfrage über eine persistente Verbindung fehlschlägt, weil der Server die Verbindung halb geschlossen hat. Ist der boolesche Wert **true**, wird die Anfrage automatisch wiederholt; ist er **false**, nicht, und die Anwendung, die **http::geturl** verwendet, soll vor einer erneuten POST-Anfrage eine Bestätigung des Benutzers einholen. Der Wert **true** sollte nur unter bestimmten Bedingungen verwendet werden. Siehe Abschnitt **PERSISTENTE SOCKETS** für Details. Der Standardwert ist 0.

    **-urlencoding** *encoding*
    : Die *encoding*, die zum Erstellen von x-url-kodierten URLs mit **::http::formatQuery** und **::http::quoteString** verwendet wird. Der Standardwert ist **utf-8**, wie in RFC 2718 angegeben. Vor http 2.5 war dies nicht festgelegt; dieses Verhalten kann durch Angabe der leeren Zeichenkette (**{}**) wiederhergestellt werden, obwohl *iso8859-1* empfohlen wird, um ein ähnliches Verhalten wiederherzustellen, aber ohne dass **::http::formatQuery** oder **::http::quoteString** beim Verarbeiten von Zeichen außerhalb von Latin-1 einen Fehler werfen.

    **-useragent** *string*
    : Der Wert des User-Agent-Headers in der HTTP-Anfrage. In einem unsicheren Interpreter hängt der Standardwert vom Betriebssystem sowie von den Versionsnummern von **http** und **Tcl** ab und lautet (zum Beispiel) "**Mozilla/5.0 (Windows; U; Windows NT 10.0) http/2.9.0 Tcl/8.6.9**". Ein sicherer Interpreter kann sein Betriebssystem nicht ermitteln; der Standardwert in einem sicheren Interpreter ist daher ein Windows-10-Wert mit den aktuellen Versionsnummern von **http** und **Tcl**.

    **-zip** *boolean*
    : Ist der Wert boolesch **true**, senden Anfragen standardmäßig einen Header "**Accept-Encoding: gzip,deflate,compress**". Ist der Wert boolesch **false**, wird dieser Header standardmäßig nicht gesendet. In beiden Fällen kann der Standardwert für eine einzelne Anfrage überschrieben werden, indem ein benutzerdefinierter **Accept-Encoding**-Header in der Option **-headers** von **http::geturl** angegeben wird. Der Standardwert ist 1.


**::http::geturl** *url* ?*options*?
: Der Befehl **::http::geturl** ist die Hauptprozedur im Paket. Die Option **-query** bewirkt eine POST-Operation, die Option **-validate** eine HEAD-Operation; andernfalls wird eine GET-Operation ausgeführt. Der Befehl **::http::geturl** gibt einen *token*-Wert zurück, mit dem Informationen über die Transaktion abgerufen werden können. Siehe die Abschnitte [Status-Array] und [Fehler] für Details. Der Befehl **::http::geturl** blockiert, bis die Operation abgeschlossen ist, es sei denn, die Option **-command** gibt eine Rückruffunktion an, die aufgerufen wird, wenn die HTTP-Transaktion abgeschlossen ist. **::http::geturl** unterstützt mehrere Optionen:

    **-binary** *boolean*
    : Legt fest, ob die URL-Daten zwangsweise als Binärdaten interpretiert werden. Normalerweise erfolgt dies automatisch (alles, was nicht mit einem **text**-Content-Type beginnt oder dessen Content-Encoding **gzip** oder **compress** ist, gilt als Binärdaten).

    **-blocksize** *size*
    : Die Blockgröße beim Lesen der URL. Es werden höchstens *size* Bytes auf einmal gelesen. Nach jedem Block wird die **-progress**-Rückruffunktion aufgerufen (falls diese Option angegeben ist).

    **-channel** *name*
    : Kopiert den URL-Inhalt in den Kanal *name*, statt ihn in **state(body)** zu speichern.

    **-command** *callback*
    : Ruft *callback* auf, nachdem die HTTP-Transaktion abgeschlossen ist. Diese Option bewirkt, dass **::http::geturl** sofort zurückkehrt. *callback* erhält ein zusätzliches Argument, nämlich den von **::http::geturl** zurückgegebenen *token*. Dieser Token ist der Name eines Arrays, das im Abschnitt [Status-Array] beschrieben ist. Hier ist eine Vorlage für die Rückruffunktion:

        ```
        proc httpCallback {token} {
            upvar #0 $token state
            # Access state as a Tcl array
        }
        ```

        Der Befehl **::http::geturl** führt die **-command**-Rückruffunktion innerhalb eines [catch]-Befehls aus. Ein Fehler in der Rückruffunktion ruft daher nicht den [bgerror]-Handler auf. Siehe Abschnitt [Fehler] für Details.

    **-handler** *callback*
    : Ruft *callback* auf, sobald HTTP-Daten verfügbar sind; falls angegeben, werden die HTTP-Daten sonst nicht weiter verarbeitet. Diese Prozedur erhält zwei zusätzliche Argumente: den Socket für die HTTP-Daten und den von **::http::geturl** zurückgegebenen *token*. Der Token ist der Name eines globalen Arrays, das im Abschnitt [Status-Array] beschrieben ist. Von der Prozedur wird erwartet, dass sie die Anzahl der vom Socket gelesenen Bytes zurückgibt. Hier ist eine Vorlage für die Rückruffunktion:

        ```
        proc httpHandlerCallback {socket token} {
            upvar #0 $token state
            # Access socket, and state as a Tcl array
            # For example...
            ...
            set data [read $socket 1000]
            set nbytes [string length $data]
            ...
            return $nbytes
        }
        ```

        Der Code von **http::geturl** für die Option **-handler** ist weder mit Kompression noch mit Chunked Transfer-Encoding kompatibel. Ist **-handler** angegeben, setzt **http::geturl** zur Umgehung dieser Probleme das HTTP-Protokoll auf 1.0 herab und überschreibt die Option **-zip** (d. h. es sendet den Header "**Accept-Encoding: gzip,deflate,compress**" nicht).

        Werden die Optionen **-handler** und **-channel** gemeinsam verwendet, ist der Handler dafür verantwortlich, die Daten vom HTTP-Socket in den angegebenen Kanal zu kopieren. Der Kanalname ist dem Handler als Element **-channel** des Token-Arrays verfügbar.

        Der Befehl **::http::geturl** führt die **-handler**-Rückruffunktion innerhalb eines [catch]-Befehls aus. Ein Fehler in der Rückruffunktion ruft daher nicht den [bgerror]-Handler auf. Siehe Abschnitt [Fehler] für Details.

    **-headers** *keyvaluelist*
    : Diese Option fügt der HTTP-Anfrage Header hinzu, die nicht bereits durch **::http::config** festgelegt sind. Das Argument *keyvaluelist* muss eine Liste mit einer geraden Anzahl von Elementen sein, die zwischen Schlüsseln und Werten wechseln. Die Schlüssel werden zu Header-Feldnamen. Zeilenumbrüche werden aus den Werten entfernt, damit der Header nicht beschädigt wird. Ist *keyvaluelist* z. B. **Pragma no-cache**, wird folgender Header in die HTTP-Anfrage aufgenommen:

        ```
        Pragma: no-cache
        ```

    **-keepalive** *boolean*
    : Ist der Wert boolesch **true**, wird versucht, die Verbindung für die Bearbeitung mehrerer Anfragen offen zu halten. Der Standardwert ist 0.

    **-method** *type*
    : Erzwingt die HTTP-Anfragemethode *type*. **::http::geturl** wählt GET, POST oder HEAD anhand anderer Optionen automatisch; diese Option überschreibt die Auswahl und ermöglicht z. B. PUT und DELETE für WebDAV-Unterstützung.

        Es liegt in der Verantwortung des Aufrufers, dass Header und Anfragekörper (falls vorhanden) den Anforderungen der Anfragemethode entsprechen. Wird z. B. **-method** *POST* verwendet, um eine POST-Anfrage mit leerem Anfragekörper zu senden, muss der Aufrufer außerdem die Option "-headers {Content-Length 0}" angeben.

    **-myaddr** *address*
    : Übergibt eine bestimmte lokale Adresse an den zugrunde liegenden [socket]-Aufruf, falls mehrere Schnittstellen verfügbar sind.

    **-progress** *callback*
    : Der *callback* wird nach jedem Datenübertrag von der URL aufgerufen. Die Rückruffunktion erhält drei zusätzliche Argumente: den *token* von **::http::geturl**, die erwartete Gesamtgröße des Inhalts aus den **Content-Length**-Metadaten und die bisher übertragene Byteanzahl. Die erwartete Gesamtgröße kann unbekannt sein; dann wird 0 an die Rückruffunktion übergeben. Hier ist eine Vorlage für die Fortschritts-Rückruffunktion:

        ```
        proc httpProgress {token total current} {
            upvar #0 $token state
        }
        ```

    **-protocol** *version*
    : Wählt die zu verwendende HTTP-Protokollversion. Dies sollte 1.0 oder 1.1 sein (Standard). Nur bei Servern nötig, die HTTP/1.1 nicht verstehen oder sich anderweitig beschweren.

    **-query** *query*
    : Dieses Flag (bei nicht leerem Wert) bewirkt, dass **::http::geturl** eine POST-Anfrage ausführt, die die Zeichenkette *query* unverändert als Anfrage-Nutzlast an den Server übergibt. Das Format (und die Kodierung) von *query* wird durch den Anfrage-Header **Content-Type** angekündigt, der durch die Option **-type** gesetzt wird. Jeder Wert von **-type** ist zulässig; es liegt in der Verantwortung des Aufrufers, *query* im richtigen Format zu liefern.

        Ist **-type** nicht angegeben, gilt standardmäßig *application/x-www-form-urlencoded*, was erfordert, dass *query* eine x-url-kodierte Query-Zeichenkette ist (dieses **-type** und Query-Format werden bei einem aus einem HTML-Formular abgesendeten POST verwendet). Die Prozedur **::http::formatQuery** kann für die Formatierung verwendet werden.

    **-queryblocksize** *size*
    : Die Blockgröße beim Senden von Query-Daten an die URL. Es werden höchstens *size* Bytes auf einmal geschrieben. Nach jedem Block wird die **-queryprogress**-Rückruffunktion aufgerufen (falls diese Option angegeben ist).

    **-querychannel** *channelID*
    : Dieses Flag bewirkt, dass **::http::geturl** eine POST-Anfrage ausführt, die die in *channelID* enthaltenen Daten an den Server übergibt. Die Daten in *channelID* müssen eine x-url-kodierte Query sein, sofern die Option **-type** unten nicht verwendet wird. Ist kein Content-Length-Header über die Option **-headers** angegeben, versucht **::http::geturl**, die Größe der POST-Daten zu ermitteln, um diesen Header zu erzeugen. Kann die Größe nicht ermittelt werden, gibt es einen Fehler zurück.

    **-queryprogress** *callback*
    : Der *callback* wird nach jedem Datenübertrag an die URL (d. h. bei POST) aufgerufen und verhält sich genau wie die Option **-progress** (das Rückrufformat ist dasselbe).

    **-strict** *boolean*
    : Ob für die Anfrage eine URL-Validierung gemäß RFC 3986 erzwungen werden soll. Standard ist 1.

    **-timeout** *milliseconds*
    : Ist *milliseconds* ungleich null, richtet **::http::geturl** einen Timeout nach der angegebenen Anzahl Millisekunden ein. Ein Timeout führt zu einem Aufruf von **::http::reset** und zur **-command**-Rückruffunktion, falls angegeben. Der Rückgabewert von **::http::status** ist **timeout**, nachdem ein Timeout aufgetreten ist.

    **-type** *mime-type*
    : Verwendet *mime-type* als Wert von **Content-Type** statt des Standardwerts (**application/x-www-form-urlencoded**) während einer POST-Operation.

    **-validate** *boolean*
    : Ist *boolean* ungleich null, führt **::http::geturl** eine HTTP-HEAD-Anfrage aus. Diese Anfrage liefert Metainformationen über die URL, der Inhalt selbst wird jedoch nicht zurückgegeben. Die Metainformationen sind nach der Transaktion in der Variable **state(meta)** verfügbar. Siehe den Abschnitt [Status-Array] für Details.


**::http::formatQuery** *key value* ?*key value* ...?
: Diese Prozedur führt x-url-Kodierung von Query-Daten durch. Sie erwartet eine gerade Anzahl von Argumenten als Schlüssel und Werte der Query. Sie kodiert Schlüssel und Werte und erzeugt eine Zeichenkette mit den passenden &- und =-Trennzeichen. Das Ergebnis eignet sich als Wert für **-query** bei **::http::geturl**.

**::http::quoteString** *value*
: Diese Prozedur führt x-url-Kodierung einer Zeichenkette durch. Sie erwartet ein einzelnes Argument und kodiert es.

**::http::reset** *token* ?*why*?
: Dieser Befehl setzt die durch *token* identifizierte HTTP-Transaktion zurück, falls vorhanden. Dabei wird **state(status)** auf *why* gesetzt, standardmäßig **reset**, und die registrierte **-command**-Rückruffunktion aufgerufen.

**::http::wait** *token*
: Dies ist eine Komfortprozedur, die blockiert und auf den Abschluss der Transaktion wartet. Dies funktioniert nur in vertrauenswürdigem Code, weil [vwait] verwendet wird. Außerdem ist es nicht nützlich, wenn **::http::geturl** *ohne* die Option **-command** aufgerufen wird, da in diesem Fall der Aufruf von **::http::geturl** erst zurückkehrt, wenn die HTTP-Transaktion abgeschlossen ist, und es nichts zu erwarten gibt.

**::http::data** *token*
: Dies ist eine Komfortprozedur, die das Element **body** (d. h. die URL-Daten) des Status-Arrays zurückgibt.

**::http::error** *token*
: Dies ist eine Komfortprozedur, die das Element **error** des Status-Arrays zurückgibt.

**::http::status** *token*
: Dies ist eine Komfortprozedur, die das Element **status** des Status-Arrays zurückgibt.

**::http::code** *token*
: Dies ist eine Komfortprozedur, die das Element **http** des Status-Arrays zurückgibt.

**::http::ncode** *token*
: Dies ist eine Komfortprozedur, die nur den numerischen Rückgabecode (200, 404 usw.) aus dem Element **http** des Status-Arrays zurückgibt.

**::http::size** *token*
: Dies ist eine Komfortprozedur, die das Element **currentsize** des Status-Arrays zurückgibt, also die Anzahl der im Aufruf von **::http::geturl** von der URL empfangenen Bytes.

**::http::meta** *token*
: Dies ist eine Komfortprozedur, die das Element **meta** des Status-Arrays zurückgibt, das die HTTP-Antwort-Header enthält. Eine Erläuterung dieses Elements folgt unten.

**::http::cleanup** *token*
: Diese Prozedur bereinigt den mit der durch *token* identifizierten Verbindung verknüpften Zustand. Nach diesem Aufruf können Prozeduren wie **::http::data** keine Informationen mehr über die Operation liefern. Es wird *dringend* empfohlen, diese Funktion aufzurufen, wenn eine HTTP-Anfrage abgeschlossen ist. Andernfalls wird Speicher nicht freigegeben; ruft Ihre Anwendung **::http::geturl** oft genug auf, kann das Speicherleck die Leistung beeinträchtigen ... oder schlimmer.

**::http::register** *proto port command*
: Diese Prozedur ermöglicht benutzerdefinierte HTTP-Transporttypen wie HTTPS durch Registrierung eines Präfixes, des Standardports und des Befehls zum Erzeugen des Tcl-**channel**. Z. B.:

    ```
    package require http
    package require tls

    ::http::register https 443 ::tls::socket

    set token [::http::geturl https://my.secure.site/]
    ```

**::http::registerError** *port* ?*message*?
: Diese Prozedur ermöglicht es einem registrierten Protokoll-Handler, eine Fehlermeldung für **http** bereitzustellen. Der Aufruf dieses Befehls löst keinen Fehler aus. Der Befehl ist nützlich, wenn ein registrierter Protokoll-Handler ein Problem erkennt (z. B. ein ungültiges TLS-Zertifikat), das einen Fehler bis zu **http** durchreichen lässt. Der Befehl ermöglicht **http**, eine präzise Fehlermeldung statt einer allgemeinen zu liefern. Der Befehl gibt den Wert des letzten Aufrufs mit Argument *message* zurück oder die leere Zeichenkette, wenn kein solcher Aufruf erfolgt ist.

**::http::unregister** *proto*
: Diese Prozedur hebt die Registrierung eines zuvor über **::http::register** registrierten Protokoll-Handlers auf und gibt eine zweielementige Liste aus dem zuvor (über **::http::register**) installierten Standardport und Handler-Befehl zurück, falls ein solcher Handler existierte; andernfalls einen Fehler.


# Fehler

Die Prozedur **::http::geturl** löst in folgenden Fällen Fehler aus: ungültige Befehlszeilenoptionen, eine ungültige URL, eine URL auf einem nicht existierenden Host oder eine URL an einem ungültigen Port eines existierenden Hosts. Diese Fehler bedeuten, dass die Netzwerktransaktion gar nicht erst gestartet werden kann. Es wird auch ein Fehler ausgelöst, wenn beim Schreiben des HTTP-Anfrage-Headers ein I/O-Fehler auftritt. Bei synchronen Aufrufen von **::http::geturl** (wenn **-command** nicht angegeben ist) wird ein Fehler ausgelöst, wenn beim Lesen der HTTP-Antwort-Header oder -Daten ein I/O-Fehler auftritt. Da **::http::geturl** in diesen Fällen keinen Token zurückgibt, führt es die erforderliche Bereinigung selbst durch; die Anwendung muss **::http::cleanup** nicht aufrufen.

Bei asynchronen Aufrufen von **::http::geturl** gelten alle obigen Fehlersituationen, außer dass beim Lesen der HTTP-Antwort-Header oder -Daten keine Ausnahme geworfen wird. Nach dem Schreiben der HTTP-Header kehrt **::http::geturl** nämlich zurück; der Rest der HTTP-Transaktion läuft im Hintergrund. Die Befehls-Rückruffunktion kann prüfen, ob beim Lesen ein Fehler aufgetreten ist, indem sie mit **::http::status** den Status prüft und, falls dieser *error* ist, mit **::http::error** die Fehlermeldung abruft.

Alternativ kann der Hauptprogrammfluss an einer Stelle, an der er das Ergebnis der asynchronen HTTP-Anfrage benötigt, **::http::wait** aufrufen und dann Status und Fehler prüfen, genau wie die Rückruffunktion.

Der Befehl **::http::geturl** führt die Rückruffunktionen **-command**, **-handler** und **-proxyfilter** innerhalb eines [catch]-Befehls aus. Ein Fehler in der Rückruffunktion ruft daher nicht den [bgerror]-Handler auf. Beim Debuggen einer dieser Rückruffunktionen kann es praktisch sein, Fehler innerhalb der Rückruffunktion selbst mit einem [catch]-Befehl zu melden, z. B. um eine Fehlermeldung nach stdout zu schreiben.

In jedem Fall müssen Sie dennoch **::http::cleanup** aufrufen, um das Status-Array zu löschen, wenn Sie fertig sind.

Weitere mögliche Ergebnisse der HTTP-Transaktion ergeben sich aus dem Status von **::http::status**. Diese werden unten beschrieben.

**ok**
: Schließt die HTTP-Transaktion vollständig ab, ist der Status **ok**. Sie sollten dennoch den Wert von **::http::code** prüfen, um den HTTP-Status zu erhalten. Die Prozedur **::http::ncode** liefert nur den numerischen Fehlercode (z. B. 200, 404 oder 500), während die Prozedur **::http::code** einen Wert wie "HTTP 404 File not found" zurückgibt.

[eof]
: Schließt der Server den Socket ohne Antwort, wird kein Fehler ausgelöst, aber der Status der Transaktion ist [eof].

**error**
: Die Fehlermeldung wird außerdem im Element **error** des Status-Arrays gespeichert und ist über **::http::error** abrufbar.

**timeout**
: Ein Timeout ist aufgetreten, bevor die Transaktion abgeschlossen werden konnte.

**reset**
: Vom Benutzer zurückgesetzt.


Eine weitere Fehlerquelle ist, dass **::http::geturl** nicht alle POST-Query-Daten zum Server schreiben kann, bevor der Server antwortet und den Socket schließt. Die Fehlermeldung wird im Element **posterror** des Status-Arrays gespeichert, und anschließend versucht **::http::geturl**, die Transaktion abzuschließen. Kann die Serverantwort gelesen werden, endet die Transaktion mit Status **ok**, andernfalls mit Status [eof].

# Status-Array

Die Prozedur **::http::geturl** gibt einen *token* zurück, mit dem auf den Zustand der HTTP-Transaktion in Form eines Tcl-Arrays zugegriffen werden kann. Mit diesem Konstrukt lässt sich eine leicht nutzbare Array-Variable anlegen:

```
upvar #0 $token state
```

Sobald die mit der URL verknüpften Daten nicht mehr benötigt werden, sollte das Status-Array entfernt werden, um Speicher freizugeben. Dafür gibt es die Prozedur **::http::cleanup**. Folgende Elemente des Arrays werden unterstützt:

**binary**
: Boolesch **true**, wenn die HTTP-Antwort (nach dem Dekodieren einer im Antwort-Header "Content-Encoding" angegebenen Kompression) binär ist. Boolesch **false**, wenn die HTTP-Antwort Text ist.

**body**
: Der Inhalt der URL. Leer, wenn die Option **-channel** angegeben wurde. Dieser Wert wird vom Befehl **::http::data** zurückgegeben.

**charset**
: Der Wert des charset-Attributs aus den **Content-Type**-Metadaten. Wurde keiner angegeben, gilt der RFC-Standard **iso8859-1** oder der Wert von **$::http::defaultCharset**. Eingehende Textdaten werden automatisch von diesem Zeichensatz nach utf-8 konvertiert.

**coding**
: Eine Kopie des Metadatenwerts **Content-Encoding**.

**currentsize**
: Die bisher von der URL geholte Byteanzahl. Dieser Wert wird vom Befehl **::http::size** zurückgegeben.

**error**
: Falls definiert, die Fehlerzeichenkette, die beim Abbruch der HTTP-Transaktion auftrat.

**http**
: Die HTTP-Statusantwort des Servers. Dieser Wert wird vom Befehl **::http::code** zurückgegeben. Das Format dieses Werts ist:

    ```
    HTTP/1.1 code string
    ```

    *code* ist eine dreistellige Zahl, die im HTTP-Standard definiert ist. Der Code 200 bedeutet OK. Codes, die mit 4 oder 5 beginnen, zeigen Fehler an. Codes, die mit 3 beginnen, sind Umleitungsfehler. In diesem Fall geben die **Location**-Metadaten eine neue URL an, die die angeforderten Informationen enthält.

**meta**
: Das HTTP-Protokoll liefert Metadaten, die den URL-Inhalt beschreiben. Das Element **meta** des Status-Arrays ist eine Liste der Schlüssel und Werte der Metadaten. Das Format eignet sich zum Initialisieren eines Arrays, das nur die Metadaten enthält:

    ```
    array set meta $state(meta)
    ```

    Einige der Metadaten-Schlüssel sind unten aufgeführt, der HTTP-Standard definiert jedoch weitere, und Server dürfen eigene hinzufügen.

    **Content-Type**
    : Der Typ des URL-Inhalts. Beispiele sind **text/html**, **image/gif,** **application/postscript** und **application/x-tcl**.

    **Content-Length**
    : Die angekündigte Größe des Inhalts. Die tatsächlich von **::http::geturl** erhaltene Größe steht in **state(currentsize)** zur Verfügung.

    **Location**
    : Eine alternative URL, die die angeforderten Daten enthält.


**posterror**
: Der Fehler, falls einer auftrat, beim Schreiben der POST-Query-Daten an den Server.

**status**
: Siehe die Beschreibung im Kapitel [Fehler] oben für eine Liste und Beschreibung von **status**. Während der Transaktion ist dieser Wert die leere Zeichenkette.

**totalsize**
: Eine Kopie des Metadatenwerts **Content-Length**.

**type**
: Eine Kopie des Metadatenwerts **Content-Type**.

**url**
: Die angeforderte URL.


# Persistente Verbindungen

## Grundlagen

Siehe RFC 7230 Abschnitt 6, der RFC 2616 Abschnitt 8.1 ablöst.

Eine persistente Verbindung ermöglicht mehrere HTTP/1.1-Transaktionen über dieselbe TCP-Verbindung. Pipelining ermöglicht es einem Client, mehrere Anfragen über eine persistente Verbindung zu senden, ohne auf jede Antwort zu warten. Der Server sendet Antworten in derselben Reihenfolge, in der die Anfragen empfangen wurden.

Schlägt eine POST-Anfrage fehl, ist typischerweise eine Bestätigung des Benutzers nötig, bevor die Anfrage erneut gesendet wird. Der Benutzer möchte prüfen, ob der Server durch die fehlgeschlagene POST-Anfrage verändert wurde, bevor dieselbe Anfrage erneut gesendet wird.

Eine HTTP-Anfrage verwendet einen persistenten Socket, wenn der Aufruf von **http::geturl** die Option **-keepalive true** hat. Pipelining wird angewendet, wo erlaubt, wenn die **http::config**-Option **-pipeline** boolesch **true** ist (ihr Standardwert).

Das http-Paket hält höchstens eine persistente Verbindung zu jedem Server (d. h. zu jedem Wert von "domain:port"). Wird **http::geturl** aufgerufen, um eine Anfrage über eine persistente Verbindung zu stellen, während die Verbindung mit einer anderen Anfrage beschäftigt ist, wird die neue Anfrage in eine Warteschlange gestellt, bis die Verbindung frei ist.

Das http-Paket unterstützt keine HTTP/1.0-persistenten Verbindungen, die durch den Header **Keep-Alive** gesteuert werden.

## Sonderfälle

Dieser Unterabschnitt behandelt Fragen im Zusammenhang mit dem Schließen der persistenten Verbindung durch den Server, automatische Wiederholung fehlgeschlagener Anfragen, die besondere Behandlung von POST-Anfragen und die Optionen zum Umgang mit diesen Fällen.

Gemäß RFC 7230 pipelined **http::geturl** keine Anfragen mit der POST-Methode. Nutzt eine POST-Anfrage eine persistente Verbindung und ist nicht die erste Anfrage auf dieser Verbindung, wartet **http::geturl**, bis die Antwort auf die vorherige Anfrage empfangen wurde; oder (wenn die **http::config**-Option **-postfresh** boolesch **true** ist) verwendet es für jede POST-Anfrage eine neue Verbindung.

Verarbeitet der Server mehrere gepipelinete Anfragen und sendet er mit einer der Antworten (außer der letzten) einen Antwort-Header "**Connection: close**", bleiben nachfolgende Antworten unerfüllt. **http::geturl** sendet die unerfüllten Anfragen erneut über eine neue Verbindung.

Eine Schwierigkeit entsteht, wenn ein HTTP-Client eine Anfrage über eine persistente Verbindung sendet, die eine Weile untätig war. Der HTTP-Server kann eine scheinbar untätige Verbindung halb schließen, während der Client eine Anfrage sendet, aber bevor die Anfrage den Server erreicht: in diesem Fall (ein **asynchronous close event**) schlägt die Anfrage fehl. Die Schwierigkeit entsteht, weil der Client nicht sicher sein kann, ob die POST den Zustand des Servers verändert hat. Bei HEAD- oder GET-Anfragen öffnet **http::geturl** eine weitere Verbindung und sendet die fehlgeschlagene Anfrage erneut. War die Anfrage jedoch eine POST-Anfrage, verbietet RFC 7230 standardmäßig eine automatische Wiederholung und schlägt entweder eine Benutzerbestätigung oder eine Bestätigung durch User-Agent-Software mit semantischem Verständnis der Anwendung vor. Die **http::config**-Option **-repost** ermöglicht beide Möglichkeiten.

Asynchrone Schließ-Ereignisse können nur in einem kurzen Zeitintervall auftreten. Das Paket **http** überwacht jede persistente Verbindung auf Schließung durch den Server. Nach Erkennung wird die Verbindung auch auf der Client-Seite geschlossen; nachfolgende Anfragen verwenden eine frische Verbindung.

Wird **http::geturl** mit der Option **-keepalive true** aufgerufen, versucht es sowohl eine bestehende persistente Verbindung zu nutzen (falls verfügbar), als auch dem Server einen Anfrage-Header "**Connection: keep-alive**" zu senden, der die Verbindung für künftige Anfragen offen halten soll.

Die **http::config**-Optionen **-pipeline**, **-postfresh** und **-repost** betreffen persistente Verbindungen.

Ist die Option **-pipeline** boolesch **true**, werden GET- und HEAD-Anfragen über eine persistente Verbindung gepipelined. POST-Anfragen werden nicht gepipelined — ist die POST-Anfrage nicht die erste Transaktion auf der Verbindung, wird ihre Anfrage erst gesendet, wenn die vorherige Antwort abgeschlossen ist. GET- und HEAD-Anfragen nach einer POST-Anfrage werden erst gesendet, wenn die POST-Antwort geliefert wurde, und nicht, wenn die POST-Anfrage fehlschlägt.

Ist die Option **-postfresh** boolesch **true**, überschreibt sie die Option **-keepalive** von **http::geturl** und öffnet für jede POST-Anfrage stets eine frische Verbindung.

Option **-repost** erlaubt bei Wert **true** das automatische Wiederholen einer POST-Anfrage, die fehlschlägt, weil sie eine persistente Verbindung verwendet, die der Server halb geschlossen hat (ein "asynchronous close event"). Nachfolgende GET- und HEAD-Anfragen in einer fehlgeschlagenen Pipeline werden ebenfalls wiederholt. *Die Option -repost sollte nur verwendet werden, wenn die Anwendung versteht, dass die Wiederholung angemessen ist* - konkret muss die Anwendung wissen, dass ein wiederholter POST keine nachteiligen Auswirkungen hätte, falls der fehlgeschlagene POST den Zustand des Servers bereits erfolgreich verändert hat.

# Protokoll-Upgrades

Die HTTP/1.1-Client-Header **Connection** und **Upgrade** teilen dem Server mit, dass der Client das über die bestehende Verbindung genutzte Protokoll ändern möchte (RFC 7230). Dieser Mechanismus kann einen WebSocket (RFC 6455), eine höhere Version des HTTP-Protokolls (HTTP 2) oder TLS-Verschlüsselung anfordern. Nimmt der Server die Upgrade-Anfrage an, lautet sein Antwortcode 101.

Um beim Aufruf von **http::geturl** ein Protokoll-Upgrade anzufordern, muss die Option **-headers** passende Werte für **Connection** und **Upgrade** liefern, und die Option **-command** muss einen Befehl liefern, der das angeforderte Protokoll implementiert und auch die Serverantwort verarbeiten kann, wenn der Server das Upgrade ablehnt. Bei Upgrade-Anfragen ignoriert **http::geturl** den Wert der Option **-keepalive** und verwendet stets **0**, damit die Upgrade-Anfrage nicht über eine Verbindung erfolgt, die für mehrere HTTP-Anfragen gedacht ist.

Die Tcllib-Bibliothek **websocket** implementiert WebSockets und ruft die nötigen Befehle im Paket **http** auf.

Derzeit gibt es keine native Tcl-Client-Bibliothek für HTTP/2.

Der **Upgrade**-Mechanismus wird in Webbrowsern nicht verwendet, um TLS anzufordern, weil **http** und **https** über unterschiedliche Ports laufen. Er wird von Protokollen wie Internet Printing Protocol (IPP) verwendet, die auf **http(s)** aufbauen und dieselbe TCP-Portnummer für sichere und unsichere Verbindungen nutzen.

In Browsern wird opportunistische Verschlüsselung stattdessen durch den Client-Header **Upgrade-Insecure-Requests** umgesetzt. Ist ein sicherer Dienst verfügbar, lautet der Server-Antwortcode eine 307-Weiterleitung, und der Antwort-Header **Location** gibt die Ziel-URL an. Der Browser muss **http::geturl** erneut aufrufen, um diese URL abzurufen. Siehe <https://w3c.github.io/webappsec-upgrade-insecure-requests/>

# Beispiele

Dieses Beispiel erstellt eine Prozedur, die eine URL mit Fortschrittsanzeige in eine Datei kopiert, und gibt die mit der URL verknüpften Metadaten aus.

```
proc httpcopy { url file {chunk 4096} } {
    set out [open $file w]
    set token [::http::geturl $url -channel $out \
            -progress httpCopyProgress -blocksize $chunk]
    close $out

    # This ends the line started by httpCopyProgress
    puts stderr ""

    upvar #0 $token state
    set max 0
    foreach {name value} $state(meta) {
        if {[string length $name] > $max} {
            set max [string length $name]
        }
        if {[regexp -nocase ^location$ $name]} {
            # Handle URL redirects
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


[bgerror]: bgerror.md
[catch]: catch.md
[eof]: eof.md
[socket]: socket.md
[vwait]: vwait.md
