---
CommandName: rest
ManualSection: n
Version: 1.7
TclPart: tcllib
TclDescription: A framework for RESTful web services
Copyright:
---

# NAME

rest – REST-Web-APIs definieren und inline oder asynchron aufrufen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [rest]{.lit} [1.7]{.optlit} 
[::rest::simple]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg} 
[::rest::get]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg} 
[::rest::post]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg} 
[::rest::patch]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg} 
[::rest::head]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg} 
[::rest::put]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg} 
[::rest::delete]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg} 
[::rest::save]{.cmd} [name]{.arg} [file]{.arg} 
[::rest::describe]{.cmd} [name]{.arg} 
[::rest::parameters]{.cmd} [url]{.arg} [key]{.optarg} 
[::rest::parse_opts]{.cmd} [static]{.arg} [required]{.arg} [optional]{.arg} [words]{.arg} 
[::rest::substitute]{.cmd} [string]{.arg} [var]{.arg} 
[::rest::create_interface]{.cmd} [name]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket unterstützt zwei Arten der Nutzung: *einfache Aufrufe* und vollständige *Schnittstellen*. In einer *Schnittstelle* legen Sie eine Reihe von Regeln fest, woraufhin das Paket die Befehle erstellt, die den REST-Methoden entsprechen. Diese Befehle können zahlreiche Optionen umfassen, wie beispielsweise Eingabe- und Ausgabetransformationen sowie datentypspezifische Formatierungen. Dies führt zu einem übersichtlicheren und einfacheren Skript. Ein *einfacher Aufruf* hingegen lässt sich zwar einfacher und schneller implementieren, bietet jedoch weniger Funktionen. Er nimmt die URL und einige Optionen zum Befehl entgegen und gibt das Ergebnis direkt zurück. Jegliche Formatierung oder Überprüfung obliegt dem restlichen Skript.

# EINFACHE ANWENDUNG

Im einfachen Anwendungsfall führen Sie Aufrufe mithilfe der HTTP-Prozeduren durch und überprüfen oder verarbeiten die zurückgegebenen Daten anschließend selbst.

**::rest::simple** *url* *query* ?*config*? ?*body*?
: ...siehe nächstes...

**::rest::get** *url* *query* ?*config*? ?*body*?
: ...siehe nächstes...

**::rest::post** *url* *query* ?*config*? ?*body*?
: ...siehe nächstes...

**::rest::patch** *url* *query* ?*config*? ?*body*?
: ...siehe nächstes...

**::rest::head** *url* *query* ?*config*? ?*body*?
: ...siehe nächstes...

**::rest::put** *url* *query* ?*config*? ?*body*?
: ...siehe nächstes...

**::rest::delete** *url* *query* ?*config*? ?*body*?
: Diese Befehle sind bis auf die verwendete HTTP-Methode alle gleichwertig. Wenn Sie **simple** verwenden, sollte die Methode als Option im *config*-Dictionary festgelegt werden. Ist dies nicht der Fall, wird standardmäßig **get** verwendet. Wenn ein *body* benötigt wird, muss das *config*-Dictionary vorhanden sein; es darf jedoch leer sein. Das *config*-Dictionary unterstützt die folgenden Schlüssel


**auth**
: ...siehe nächstes...

**content-type**
: ...siehe nächstes...

**cookie**
: ...siehe nächstes...

**error-body**
: ...siehe nächstes...

**format**
: ...siehe nächstes...

**headers**
: ...siehe nächstes...

**method**
: ...siehe nächstes...

**timeout**
: 


Zwei kurze Beispiele:

Beispiel 1, Yahoo-Chef:

```
    set appid APPID
    set search tcl
    set res [rest::get http://boss.yahooapis.com/ysearch/web/v1/$search [list appid $appid]]
    set res [rest::format_json $res]
```

Beispiel 2, Twitter:

```
    set url   http://twitter.com/statuses/update.json
    set query [list status $text]
    set res [rest::simple $url $query {
        method post
        auth   {basic user password}
        format json
    }]
```

# VERWENDUNG DER SCHNITTSTELLE

Eine Schnittstelle zu einer REST-API besteht aus einer Reihe von Definitionen von REST-Aufrufen, die in einem Array enthalten sind. Der Name dieses Arrays wird zu einem Namespace, der die definierten Befehle enthält. Jeder Schlüssel des Arrays legt den Namen des Aufrufs fest, wobei die zugehörige Konfiguration aus einem Dictionary, d. h. Schlüssel-Wert-Paaren, besteht. Die zulässigen Schlüssel, d. h. die gültigen Konfigurationsoptionen, werden im Folgenden beschrieben. Nachdem Sie die Definitionen im Array erstellt haben, rufen Sie einfach **rest::create_interface** mit dem Array als Argument auf, um die gewünschten Befehle zu erstellen.

Beispiele: Yahoo Wetter:

```
    package require rest

    set yweather(forecast) {
       url      http://weather.yahooapis.com/forecastrss
       req_args { p: }
       opt_args { u: }
    }
    rest::create_interface yweather
    puts [yweather::forecast -p 94089]
```

**::rest::save** *name* *file*
: Dieser Befehl speichert eine Kopie der dynamisch erstellten Prozeduren für alle in der Array-Variablen *name* angegebenen API-Aufrufe in der Datei *file*, um sie später laden zu können. Das Ergebnis des Befehls ist die leere Zeichenkette

**::rest::describe** *name*
: Dieser Befehl gibt eine Beschreibung aller in der Array-Variablen *name* angegebenen API-Aufrufe auf dem Kanal **stdout** aus. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::rest::parameters** *url* ?*key*?
: Dieser Befehl analysiert eine *url*-Abfragezeichenfolge und wandelt sie in ein Dictionary um; anschließend gibt er dieses Dictionary als Ergebnis zurück. Wenn *key* festgelegt wird, gibt der Befehl nicht das gesamte Dictionary zurück, sondern lediglich den Wert des festgelegten *key*.

**::rest::parse_opts** *static* *required* *optional* *words*
: Dieser Befehl implementiert einen benutzerdefinierten Parser für Befehlsoptionen.


dict *static*
: Ein Verzeichnis von Optionen und deren Werten, die stets in der Ausgabe enthalten sind.

Liste *required*
: Eine Liste von Optionen, die durch *words* angegeben werden müssen

Liste *optional*
: Eine Liste von Optionen, die in den *words* vorkommen können, jedoch nicht erforderlich sind. Die Elemente müssen in einer der folgenden drei Formen vorliegen:


**name**
: Die Option kann vorhanden sein oder auch nicht; es gibt keine Standardeinstellung.

**name:**
: Sofern vorhanden, erfordert diese Option ein Argument.

**name:value**
: Wenn dieser nicht vorhanden ist, verwenden Sie bitte **value** als Standardwert.


Liste *words*
: Die Wörter, die in Optionen und Werte zerlegt werden sollen.


Das Ergebnis des Befehls ist eine Liste mit zwei Elementen. Das erste Element ist ein Dictionary, das die analysierten Optionen und deren Werte enthält. Das zweite Element ist eine Liste der verbleibenden Wörter.

**::rest::substitute** *string* *var*
: Dieser Befehl nimmt eine *string* entgegen, ersetzt darin alle gefundenen Optionsbezeichner durch Werte und gibt die geänderte Zeichenkette als Ergebnis zurück. Die zu ersetzenden Werte befinden sich in der Variablen *var*, die ein Dictionary enthalten soll, das die zu ersetzenden Optionsbezeichner ihren jeweiligen Werten zuordnet. *Hinweis*: Optionen-Bezeichner, für die in *var* kein Schlüssel vorhanden ist, werden durch die leere Zeichenkette ersetzt. Die Bezeichner für Optionen in *string* müssen der Syntax **%...%** entsprechen, wobei **...** eine beliebige Kombination aus Kleinbuchstaben, Ziffern, Unterstrichen, Doppelpunkten und Bindestrichen enthalten darf.

**::rest::create_interface** *name*
: Dieser Befehl erstellt Prozeduren für alle API-Aufrufe, die in der Array-Variablen *name* angegeben sind. Der Name dieses Arrays wird zu einem Namespace, der die definierten Befehle enthält. Jeder Schlüssel des Arrays legt den Namen des Aufrufs fest, wobei die zugehörige Konfiguration aus einem Dictionary besteht, d. h. aus Schlüssel-Wert-Paaren. Die zulässigen Schlüssel und ihre Bedeutungen lauten wie folgt:


**url**
: Der Wert dieser *required* Option muss das Ziel der HTTP-Anfrage sein.

**description**
: Der Wert dieser Option muss eine kurze Zeichenfolge sein, die den Aufruf beschreibt. Wenn kein Wert angegeben wird, gilt standardmäßig die leere Zeichenfolge. Wird ausschließlich von **::rest::describe** verwendet.

**body**
: Der Wert dieser Option gibt an, ob für den Anforderungstext des Aufrufs Argumente erforderlich sind oder nicht. Die zulässigen Werte sind nachstehend aufgeführt. Sofern nicht anders angegeben, lautet der Standardwert **optional**.


**none**
: Der Aufruf enthält keinen Anforderungstext; es darf kein Anforderungstext angegeben werden.

**optional**
: Ein Request-Body kann angegeben werden, ist jedoch nicht erforderlich.

**required**
: Es muss ein Request-Body angegeben werden.

**argument**
: Auf diesen Wert muss der Name einer Option folgen, wobei die gesamte Zeichenfolge als Liste behandelt wird. Der Request-Body wird als Wert dieser Option verwendet.

**mime_multipart**
: Ein Anfragetext muss angegeben werden und wird so interpretiert, dass jedes Argument einen Teil eines MIME/Multipart-Dokuments darstellt. Argumente müssen Listen mit zwei Elementen sein: einer Liste von Header-Schlüsseln und -Werten sowie dem MIME-Teiltext, und zwar in dieser Reihenfolge.

**mime_multipart/\<value>**
: Entspricht „mime_multipart“, jedoch wird der Header „**Content-Type**“ auf „**multipart/\<value>**“ gesetzt.


**method**
: Der Wert dieser Option muss der Name der HTTP-Methode sein, die für die URL aufgerufen werden soll. Sofern nicht anders angegeben, ist die Standardeinstellung „GET“. Zulässige Werte sind **GET**, **POST** und **PUT**, wobei die Groß- und Kleinschreibung keine Rolle spielt.

**copy**
: Wenn der Wert dieser Option angegeben ist, legt er den Namen eines zuvor definierten Aufrufs fest. Die Definition dieses Aufrufs wird in den aktuellen Aufruf übernommen, mit Ausnahme der Optionen, die vom aktuellen Aufruf selbst angegeben wurden.

**unset**
: Wenn der Wert dieser Option vorhanden ist, enthält er eine Liste der Optionen im aktuellen Aufruf. Diese Optionen werden aus den Definitionen entfernt. Verwenden Sie diese Option, nachdem Sie eine bestehende Definition mit **copy** bearbeitet haben, um Optionen zu entfernen, anstatt deren Wert zu überschreiben.

**headers**
: Angabe zusätzlicher Header-Felder. Der Wert dieser Option muss ein Dictionary sein, das die neuen Header-Felder und deren Werte enthält. Standardmäßig werden keine zusätzlichen Header hinzugefügt.

**content-type**
: Der Wert dieser Option legt den Inhaltstyp für die Anfragedaten fest.

**req_args**
: Der Wert dieser Option ist eine Liste, in der die erforderlichen Argumente des Aufrufs aufgeführt sind. Für Namen, die mit einem Doppelpunkt enden, muss ein Wert angegeben werden.

**opt_args**
: Der Wert dieser Option ist eine Liste, in der die Argumente aufgeführt sind, die bei einem Aufruf vorhanden sein können, jedoch nicht erforderlich sind.

**static_args**
: Der Wert dieser Option ist eine Liste, in der die Argumente aufgeführt sind, die stets gleich bleiben. Es macht keinen Sinn, den Benutzer damit zu belasten. Ein führender Bindestrich (**-**) ist zulässig, jedoch nicht erforderlich, um die Konsistenz mit der Befehlszeile zu wahren.

**auth**
: Der Wert dieser Option legt fest, wie die Aufrufe authentifiziert werden sollen. Wird die Option nicht angegeben, findet keine Authentifizierung statt.


**basic**
: Der Benutzer kann die *Basisauthentifizierung* konfigurieren, indem er die Prozedur **basic_auth** im Namespace „interface“ überschreibt. Diese Prozedur benötigt zwei Argumente: den Benutzernamen und das Passwort, in dieser Reihenfolge.

**bearer**
: Der Benutzer kann ein Bearer-Token als Authentifizierung konfigurieren. Der Wert entspricht dem Token, das an den HTTP-Autorisierungsheader übergeben wird.

**sign**
: Der Wert muss tatsächlich eine Liste sein, deren zweites Element den Namen einer Prozedur enthält, die zur Signierung der Anfrage aufgerufen wird.


**callback**
: Wenn diese Option vorhanden ist, wird die Methode als *asynchroner* Aufruf erstellt. Solche Aufrufe geben sofort den Wert des zugehörigen HTTP-Tokens zurück, anstatt das Ergebnis des Aufrufs zu geben. Die Ereignisschleife muss aktiv sein, um diese Option nutzen zu können. Der Wert dieser Option wird als Befehlspräfix behandelt, das aufgerufen wird, sobald der HTTP-Aufruf abgeschlossen ist. Das Präfix erhält mindestens zwei zusätzliche Argumente: den Namen der aufrufenden Prozedur und den Status des Ergebnisses (entweder **OK** oder **ERROR**) in dieser Reihenfolge. Im Falle von **OK** wird ein drittes Argument hinzugefügt: die mit dem Ergebnis verbundenen Daten. Nur wenn es sich bei **ERROR** um eine Weiterleitung handelt, wird die Zieladresse der Weiterleitung als Argument hinzugefügt. Wenn der Konfigurationsschlüssel **error-body** auf **true** gesetzt wird, werden die mit dem Ergebnis verbundenen Daten ebenfalls als Argument hinzugefügt. Der HTTP-Anfrage-Header steht in dieser Prozedur über **upvar token token** zur Verfügung.

**cookie**
: Der Wert dieser Option ist eine Liste von Cookies, die im HTTP-Header übermittelt werden sollen. Dies ist eine Abkürzung für die Option **headers**.

**input_transform**
: Der Wert dieser Option ist ein Befehlspräfix oder ein Skript, mit dem vor dem Aufruf des Befehls eine Transformation der Abfrage durchgeführt wird. Eine Skripttransformation wird in eine automatisch generierte interne Prozedur eingebettet. Wird kein Wert angegeben, erfolgt keine Transformation. Der Befehl (Präfix) muss ein einzelnes Argument akzeptieren – nämlich die zu transformierende Abfrage (ein Dictionary) – und muss die modifizierte Abfrage (ebenfalls als Dictionary) als Ergebnis geben. Auf den Request-Body kann im Befehl zur Transformation über **upvar body body** zugegriffen werden.

**format**
: ...siehe nächstes...

**result**
: Der Wert dieser Option legt das Format der zurückgegebenen Daten fest. Sofern nicht anders angegeben, lautet der Standardwert **auto**. Zulässige Werte sind:


**auto**
: Automatische Erkennung zwischen **xml** und **json**.

**discard**
: ...siehe nächstes...

**json**
: ...siehe nächstes...

**raw**
: ...siehe nächstes...

**rss**
: Dies ist als Sonderfall von **xml** formatiert.

**tdom**
: ...siehe nächstes...

**xml**
: 


**pre_transform**
: Der Wert dieser Option ist ein Befehlspräfix oder ein Skript, mit dem eine Transformation des Ergebnisses eines Aufrufs durchgeführt wird (*vor* der Anwendung der Ausgabetransformation gemäß **format**). Eine Skript-Transformation wird in eine automatisch generierte interne Prozedur eingebettet. Wird nichts angegeben, erfolgt keine Transformation. Der Befehl (Präfix) muss ein einzelnes Argument – das zu transformierende Ergebnis – akzeptieren und das geänderte Ergebnis als Rückgabewert geben. Der HTTP-Request-Header ist im Transformationsbefehl über **upvar token token** zugänglich.

**post_transform**
: Der Wert dieser Option ist ein Befehlspräfix oder ein Skript, mit dem eine Transformation des Ergebnisses eines Aufrufs durchgeführt wird (*nach* der Anwendung der Ausgabetransformation gemäß **format**). Eine Skript-Transformation wird in eine automatisch generierte interne Prozedur eingebettet. Wenn nichts festgelegt wird, erfolgt keine Transformation. Der Befehl (Präfix) muss ein einzelnes Argument – das zu transformierende Ergebnis – akzeptieren und das geänderte Ergebnis als Rückgabewert geben. Der HTTP-Request-Header ist im Transformationsbefehl über **upvar token token** zugänglich.

**check_result**
: Der Wert dieser Option muss eine Liste aus zwei Ausdrücken sein, von denen jeder leer sein kann. Der erste Ausdruck prüft die OK-Bedingung; er gibt den Wert **true** zurück, wenn das Ergebnis zufriedenstellend ist, und andernfalls den Wert **false**. Der zweite Ausdruck stellt die ERROR-Bedingung dar; er gibt den Wert **false** zurück, sofern kein Fehler vorliegt; liegt ein Fehler vor, gibt er den Wert **true** zurück.

**error_body**
: Der Wert dieser Option legt fest, ob bei Auftreten eines HTTP-Fehlers die Antwort gegeben wird oder nicht. Standardmäßig wird der Antworttext bei einem Fehler nicht gegeben. Weitere Informationen finden Sie unter **callback** weiter oben.

**timeout**
: Der Wert dieser Option legt fest, ob für den HTTP-Aufruf ein Timeout festgelegt werden soll. Standardmäßig ist kein Timeout festgelegt. Der Timeout-Wert wird in Millisekunden angegeben.


# BEISPIELE

Yahoo Geo:

```
set ygeo(parse) {
    url http://wherein.yahooapis.com/v1/document
    method post
    body { arg documentContent }
}
ygeo::parse "san jose ca"
# "san jose ca" will be interpreted as if it were specified as the -documentContent option
```

Google Docs:

```
set gdocs(upload) {
    url http://docs.google.com/feeds/default/private/full
    body mime_multipart
}
gdocs::upload [list {Content-Type application/atom+xml} $xml] [list {Content-Type image/jpeg} $filedata]
```

Köstlich:

```
set delicious(updated) {
    url https://api.del.icio.us/v1/posts/update
    auth basic
}

rest::create_interface flickr

flickr::basic_auth username password
```

Flickr:

```
set flickr(auth.getToken) {
   url http://api.flickr.com/services/rest/
   req_args { api_key: secret: }
   auth { sign do_signature }
}

rest::create_interface flickr

proc ::flickr::do_signature {query} {
    # perform some operations on the query here
    return $query
}
```

# ENTHALTEN

Das Paket bietet funktionsfähige, jedoch unvollständige Implementierungen für die folgenden Dienste:

**del.icio.us**
: ...siehe nächstes...

**facebook**
: ...siehe nächstes...

**flickr**
: ...siehe nächstes...

**twitter**
: ...siehe nächstes...

**google calendar**
: ...siehe nächstes...

**yahoo boss**
: ...siehe nächstes...

**yahoo weather**
: Bitte lesen Sie entweder die Implementierung des Pakets oder verwenden Sie nach dem Laden des Pakets **rest::describe**, um weitere Informationen zu erhalten. Beachten Sie bitte auch die Entwicklerdokumentation auf den jeweiligen Websites.


# TLS

Das Paket „**rest**“ kann mit *https*-secured-Diensten verwendet werden, indem das **TLS**-Paket angefordert und anschließend bei dem Paket „**http**“, auf dem es aufbaut, registriert wird. Beispiele

```
    package require tls
    http::register https 443 ::tls::socket
```

# TLS-SICHERHEITSHINWEISE

Dieses Paket nutzt das **TLS**-Paket, um die Sicherheit für **https**-URLs und andere Socket-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs ](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie in den folgenden Beispielen gezeigt.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *rest* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.
