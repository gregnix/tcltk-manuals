---
CommandName: oauth
ManualSection: n
Version: 1.0.4
TclPart: tcllib
TclDescription: oauth
Keywords:
 - RFC 2718
 - RFC 5849
 - oauth
 - twitter
Copyright:
 - Copyright (c) 2014 Javi P. <hxm@eggdrop.es>
---

# NAME

oauth – Basissignatur der OAuth-API

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [oauth]{.lit} [1.0.4]{.optlit} 
[::oauth::config]{.cmd} 
[::oauth::config]{.cmd} [options]{.optdot} 
[::oauth::header]{.cmd} [baseURL]{.arg} [postQuery]{.optarg} 
[::oauth::query]{.cmd} [baseURL]{.arg} [postQuery]{.optarg} 
:::

# BESCHREIBUNG

Das Paket **oauth** stellt eine einfache, nur in Tcl geschriebene Bibliothek für die Kommunikation mit [oauth](http://oauth.net)-APIs bereit. Die aktuelle Version des Pakets unterstützt das OAuth-1.0-Protokoll, wie in [RFC 5849](http://tools.ietf.org/rfc/rfc5849.txt) festgelegt.

# TLS-SICHERHEITSHINWEISE

Dieses Paket nutzt das **TLS**-Paket, um die Sicherheit für **https**-URLs und andere Socket-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie im folgenden Beispiel gezeigt.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# BEFEHLE

**::oauth::config**
: Wird dieser Befehl ohne Argumente aufgerufen, gibt er ein Dictionary zurück, das die aktuellen Werte aller Optionen enthält.

**::oauth::config** ?*options*...?
: Mit Argumenten aufgerufen, Optionen gefolgt von ihren Werten, legt der Befehl verschiedene Parameter von Anwendung und Client fest und fragt sie ab, etwa den Proxy-Host und den User-Agent der HTTP-Anfragen. Die einzelnen Optionen stehen unten:


**-accesstoken** *string*
: Dies ist das Token des Benutzers.

**-accesstokensecret** *string*
: Dies ist das geheime Token des Benutzers.

**-consumerkey** *string*
: Dies ist der öffentliche Token Ihrer App.

**-consumersecret** *string*
: Dies ist das private Token Ihrer App.

**-debug** *bool*
: Der Standardwert ist **off**. Wenn Sie die Option auf **on** setzen, wird die gerade erzeugte Basissignatur zusammen mit weiterer Debug-Ausgabe auf stdout geschrieben.

**-oauthversion** *version*
: Dies ist die zu verwendende Version des OAuth-Protokolls. Derzeit wird ausschließlich **1.0** unterstützt, die Standardversion.

**-proxyhost** *hostname*
: Sie können einen Proxy-Host einrichten, über den die Verbindung zum API-Server von OAuth läuft.

**-proxyport** *port-number*
: Portnummer Ihres Proxys.

**-signmethod** *method*
: Die zu verwendende Signaturmethode. OAuth 1.0 unterstützt ausschließlich **HMAC-SHA1**, die Standardmethode.

**-timeout** *milliseconds*
: Zeitlimit in Millisekunden für Ihre Abfrage. Der Standardwert ist **6000**, das heißt 6 Sekunden.

**-urlencoding** *encoding*
: Die Kodierung, mit der **::http::formatQuery** die x-url-kodierten URLs erzeugt. Die Vorgabe ist **utf-8**, wie in [RFC 2718](http://tools.ietf.org/rfc/rfc2718.txt) festgelegt.


**::oauth::header** *baseURL* ?*postQuery*?
: Dieser Befehl erzeugt die Basissignatur. Mit passenden Einstellungen für die verschiedenen Tokens und Geheimnisse (siehe **::oauth::config**) ist das Ergebnis die Basis-Authentifizierungszeichenkette, die an den Server gesendet wird. Sie müssen diese Prozedur nicht aufrufen, um die Abfrage zu erzeugen, denn **::oauth::query** (siehe unten) übernimmt das. Für die Fehlersuche ist der Aufruf dennoch nützlich.


url *baseURL*
: Dieses Argument ist der URI-Pfad zum OAuth-API-Server. Wenn Sie eine GET-Anfrage senden wollen, geben Sie einen vollständigen Pfad an.


```
HTTP GET
::oauth::header {https://api.twitter.com/1.1/users/lookup.json?screen_name=AbiertaMente}
```

url-kodierte Zeichenkette *postQuery*
: Wenn Sie einen Header im POST-Format senden müssen, setzen Sie die Abfragezeichenkette in dieses Argument.


```
::oauth::header {https://api.twitter.com/1.1/friendships/create.json} {user_id=158812437&follow=true}
```

**::oauth::query** *baseURL* ?*postQuery*?
: Diese Prozedur verwendet die Einstellungen von **::oauth::config**, erzeugt damit die Basisauthentifizierung und sendet anschließend den Befehl an die Server-API. Sie nimmt dieselben Argumente entgegen wie **::oauth::header**. Das Ergebnis ist eine Liste aus zwei Elementen. Das erste Element ist ein Dictionary mit den HTTP-Header-Daten der Antwort. Damit können Sie beispielsweise den X-Rate-Limit von OAuth prüfen. Das zweite Element sind die Rohdaten, die der API-Server zurückgibt. Diese Zeichenkette ist in der Regel ein JSON-Objekt und lässt sich mit den Funktionen des Pakets **json** oder einem anderen JSON-Parser für Tcl weiter dekodieren. Hier ein Beispiel, wie das bei Twitter abläuft. Vergessen Sie nicht, die Platzhalter-Tokens und -Schlüssel des Beispiels durch Ihre eigenen zu ersetzen, wenn Sie es ausprobieren.


```
% package require oauth
% package require json
% oauth::config -consumerkey {your_consumer_key} -consumersecret {your_consumer_key_secret} -accesstoken {your_access_token} -accesstokensecret {your_access_token_secret}

% set response [oauth::query https://api.twitter.com/1.1/users/lookup.json?screen_name=AbiertaMente]
% set jsondata [lindex $response 1]
% set data [json::json2dict $jsondata]
$ set data [lindex $data 0]
% dict for {key val} $data {puts "$key => $val"}
id => 158812437
id_str => 158812437
name => Un Librepensador
screen_name => AbiertaMente
location => Explico mis tuits ahí →
description => 160Caracteres para un SMS y contaba mi vida entera sin recortar vocales. Ahora en Twitter, podemos usar hasta 140 y a mí me sobrarían 20 para contaros todo lo q
url => http://t.co/SGs3k9odBn
entities => url {urls {{url http://t.co/SGs3k9odBn expanded_url http://librepensamiento.es display_url librepensamiento.es indices {0 22}}}} description {urls {}}
protected => false
followers_count => 72705
friends_count => 53099
listed_count => 258
created_at => Wed Jun 23 18:29:58 +0000 2010
favourites_count => 297
utc_offset => 7200
time_zone => Madrid
geo_enabled => false
verified => false
statuses_count => 8996
lang => es
status => created_at {Sun Oct 12 08:02:38 +0000 2014} id 521209314087018496 id_str 521209314087018496 text {@thesamethanhim http://t.co/WFoXOAofCt} source {<a href="http://twitter.com" rel="nofollow">Twitter Web Client</a>} truncated false in_reply_to_status_id 521076457490350081 in_reply_to_status_id_str 521076457490350081 in_reply_to_user_id 2282730867 in_reply_to_user_id_str 2282730867 in_reply_to_screen_name thesamethanhim geo null coordinates null place null contributors null retweet_count 0 favorite_count 0 entities {hashtags {} symbols {} urls {{url http://t.co/WFoXOAofCt expanded_url http://www.elmundo.es/internacional/2014/03/05/53173dc1268e3e3f238b458a.html display_url elmundo.es/internacional/… indices {16 38}}} user_mentions {{screen_name thesamethanhim name Ἑλένη id 2282730867 id_str 2282730867 indices {0 15}}}} favorited false retweeted false possibly_sensitive false lang und
contributors_enabled => false
is_translator => true
is_translation_enabled => false
profile_background_color => 709397
profile_background_image_url => http://pbs.twimg.com/profile_background_images/704065051/9309c02aa2728bdf543505ddbd408e2e.jpeg
profile_background_image_url_https => https://pbs.twimg.com/profile_background_images/704065051/9309c02aa2728bdf543505ddbd408e2e.jpeg
profile_background_tile => true
profile_image_url => http://pbs.twimg.com/profile_images/2629816665/8035fb81919b840c5cc149755d3d7b0b_normal.jpeg
profile_image_url_https => https://pbs.twimg.com/profile_images/2629816665/8035fb81919b840c5cc149755d3d7b0b_normal.jpeg
profile_banner_url => https://pbs.twimg.com/profile_banners/158812437/1400828874
profile_link_color => FF3300
profile_sidebar_border_color => FFFFFF
profile_sidebar_fill_color => A0C5C7
profile_text_color => 333333
profile_use_background_image => true
default_profile => false
default_profile_image => false
following => true
follow_request_sent => false
notifications => false
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *oauth* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2014 Javi P. <hxm@eggdrop.es>
```
