---
CommandName: httpd
ManualSection: n
Version: 4.3.6
TclPart: tcllib
TclDescription: Tcl Web Server
Keywords:
 - TclOO
 - WWW
 - http
 - httpd
 - httpserver
 - services
Copyright:
 - Copyright (c) 2018 Sean Woods <yoda@etoyoc.com>
---

# NAME

httpd – Ein auf TclOO und Coroutinen basierender Webserver

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [uuid]{.lit} 
[package]{.cmd} [require]{.sub} [clay]{.lit} 
[package]{.cmd} [require]{.sub} [coroutine]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::filetype]{.lit} 
[package]{.cmd} [require]{.sub} [websocket]{.lit} 
[package]{.cmd} [require]{.sub} [mime]{.lit} 
[package]{.cmd} [require]{.sub} [cron]{.lit} 
[package]{.cmd} [require]{.sub} [uri]{.lit} 
[package]{.cmd} [require]{.sub} [Markdown]{.lit} 
:::

Methode **ChannelCopy** *in* *out* ?*args*?

Methode **html_header** ?*title* ? ?*args*?

Methode **html_footer** ?*args*?

Methode **http_code_string** *code*

Methode **HttpHeaders** *sock* ?*debug* ?

Methode **HttpHeaders_Default**

Methode **HttpServerHeaders**

Methode **MimeParse** *mimetext*

Methode **Url_Decode** *data*

Methode **Url_PathCheck** *urlsuffix*

Methode **wait** *mode* *sock*

Variable **ChannelRegister**

Variable **reply**

Variable **request**

Weiterleitung **\<server>**

Methode **constructor** *ServerObj* ?*args*?

Methode **destructor** ?*dictargs*?

Methode **ChannelRegister** ?*args*?

Methode **close**

Methode **Log_Dispatched**

Methode **dispatch** *newsock* *datastate*

Methode **Dispatch**

Methode **html_header** *title* ?*args*?

Methode **html_footer** ?*args*?

Methode **error** *code* ?*msg* ? ?*errorInfo* ?

Methode **content**

Methode **EncodeStatus** *status*

Methode **log** *type* ?*info* ?

Methode **CoroName**

Methode **DoOutput**

Methode **FormData**

Methode **PostData** *length*

Methode **Session_Load**

Methode **puts** *line*

Methode **RequestFind** *field*

Methode **request** *subcommand* ?*args*?

Methode **reply** *subcommand* ?*args*?

Methode **reset**

Methode **timeOutCheck**

Methode **timestamp**

Variable **template**

Variable **url_patterns**

Methode **constructor** *args* ?*port* **auto**? ?*myaddr* **127.0.0.1**? ?*string* **auto**? ?*name* **auto**? ?*doc_root* ? ?*reverse_dns* **0**? ?*configuration_file* ? ?*protocol* **HTTP/1.1**?

Methode **destructor** ?*dictargs*?

Methode **connect** *sock* *ip* *port*

Methode **ServerHeaders** *ip* *http_request* *mimetxt*

Methode **Connect** *uuid* *sock* *ip*

Methode **counter** *which*

Methode **CheckTimeout**

Methode **debug** ?*args*?

Methode **dispatch** *data*

Methode **Dispatch_Default** *reply*

Methode **Dispatch_Local** *data*

Methode **Headers_Local** *varname*

Methode **Headers_Process** *varname*

Methode **HostName** *ipaddr*

Methode **log** ?*args*?

Methode **plugin** *slot* ?*class* ?

Methode **port_listening**

Methode **PrefixNormalize** *prefix*

Methode **source** *filename*

Methode **start**

Methode **stop**

Methode **SubObject {} db**

Methode **SubObject {} default**

Methode **template** *page*

Methode **TemplateSearch** *page*

Methode **Thread_start**

Methode **Uuid_Generate**

Methode **Validate_Connection** *sock* *ip*

Methode **reset**

Methode **content**

Methode **Dispatch**

Methode **content**

Methode **FileName**

Methode **DirectoryListing** *local_file*

Methode **content**

Methode **Dispatch**

Variable **exename**

Methode **CgiExec** *execname* *script* *arglist*

Methode **Cgi_Executable** *script*

Methode **proxy_channel**

Methode **proxy_path**

Methode **ProxyRequest** *chana* *chanb*

Methode **ProxyReply** *chana* *chanb* ?*args*?

Methode **Dispatch**

Methode **FileName**

Methode **proxy_channel**

Methode **ProxyRequest** *chana* *chanb*

Methode **ProxyReply** *chana* *chanb* ?*args*?

Methode **DirectoryListing** *local_file*

Methode **EncodeStatus** *status*

Methode **scgi_info**

Methode **proxy_channel**

Methode **ProxyRequest** *chana* *chanb*

Methode **ProxyReply** *chana* *chanb* ?*args*?

Methode **debug** ?*args*?

Methode **Connect** *uuid* *sock* *ip*

Methode **Dispatch_Dict** *data*

Methode **uri {} add** *vhosts* *patterns* *info*

Methode **uri {} direct** *vhosts* *patterns* *info* *body*

Methode **output**

Methode **DoOutput**

Methode **close**

Methode **local_memchan** *command* ?*args*?

Methode **Connect_Local** *uuid* *sock* ?*args*?

# BESCHREIBUNG

Dieses Modul implementiert einen Webserver, der sich zur Einbindung in eine Anwendung eignet. Der Server ist objektorientiert und enthält alle Grundlagen, die für eine voll funktionsfähige Website erforderlich sind.

# MINIMALBEISPIEL

Zum Starten eines Webdienstes wird eine Klasse vom Typ **httpd::server** instanziiert und diesem Server werden eine oder mehrere zu bedienende URIs sowie von **httpd::reply** abgeleitete Klassen zur Generierung dieser URIs bereitgestellt.

```
package require httpd

oo::class create ::reply.hello {
  method content {} {
    my puts "<HTML><HEAD><TITLE>IRM Dispatch Server</TITLE></HEAD><BODY>"
    my puts "<h1>Hello World!</h1>"
    my puts </BODY></HTML>
  }
}
::httpd::server create HTTPD port 8015 myaddr 127.0.0.1 doc_root [file home]/htdocs
HTTPD plugin dispatch ::httpd::plugin.dict_dispatch
HTTPD uri add * /hello [list mixin reply.hello]
vwait forever
```

Das Grundmodul kann Dateien aus einem Dateisystem ausliefern. Dateien, deren Name auf **.tml** endet, werden im Stil von Tclhttpd substituiert:

```
<!-- hello.tml -->
[my html_header {Hello World!}]
Your Server is running.
<p>
The time is now [clock format [clock seconds]]
[my html_footer]
```

Ein vollständiges Beispiel für einen httpd-Server im Verzeichnis /examples der Tcllib. Hier wird zudem gezeigt, wie URIs über SCGI und HTTP-Proxys an andere Prozesse weitergeleitet werden können.

```
cd ~/tcl/sandbox/tcllib
tclsh examples/httpd.tcl
```

# KLASSEN

## Klasse httpd::mime

Eine Metaklasse für das MIME-Verarbeitungsverhalten über einen aktiven Socket hinweg

**Methods**

Methode **ChannelCopy** *in* *out* ?*args*?
: ...siehe nächstes...

Methode **html_header** ?*title* ? ?*args*?
: Gibt einen HTML-Block zurück

Methode **html_footer** ?*args*?
: ...siehe nächstes...

Methode **http_code_string** *code*
: ...siehe nächstes...

Methode **HttpHeaders** *sock* ?*debug* ?
: ...siehe nächstes...

Methode **HttpHeaders_Default**
: ...siehe nächstes...

Methode **HttpServerHeaders**
: ...siehe nächstes...

Methode **MimeParse** *mimetext*
: Wandelt einen Block von MIME-kodiertem Text in eine Schlüssel-Wert-Liste um. Tritt eine Ausnahme auf, löst die Methode einen eigenen Aufruf der Methode **error** aus und ruft unverzüglich die Methode **output** auf, um einen Fehlercode zu generieren und die Verbindung zu schließen.

Methode **Url_Decode** *data*
: Entfernt die HTTP-Kodierung aus einer Zeichenkette.

Methode **Url_PathCheck** *urlsuffix*
: ...siehe nächstes...

Methode **wait** *mode* *sock*
: 


## Klasse httpd::reply

*ancestors*: **httpd::mime**

Eine Klasse, die eine Anfrage durch den Prozess der Antwortgenerierung begleitet. Der mit der Antwort verbundene Socket ist jederzeit über die Variable *chan* verfügbar. Der Prozess der Antwortgenerierung beginnt damit, dass eine **httpd::server** ein **http::class**-Objekt erzeugt, eine Reihe von Verhaltensweisen einbindet und anschließend die **dispatch**-Methode des Antwortobjekts aufruft. Im Normalbetrieb führt die Methode **dispatch** folgende Schritte aus:

**\[1\]**
: Ruft die Methode **reset** des Objekts auf, um die Standard-Header zu füllen.

**\[2\]**
: Ruft die Methode **HttpHeaders** auf, um die MIME-Header aus dem Socket zu streamen

**\[3\]**
: Ruft die Methode **request parse** auf, um den Strom der MIME-Header in ein Dictionary umzuwandeln, das über die Methode **request** gelesen werden kann.

**\[4\]**
: Speichert den Rohdatenstrom der MIME-Header in der Variable *rawrequest* des Objekts.

**\[5\]**
: Ruft die Methode **content** für das Objekt auf und löst einen Aufruf der Methode **error** aus, falls eine Ausnahme ausgelöst wird.

**\[6\]**
: Ruft die Methode **output** des Objekts auf. Entwickler können die Ausgabe über die Methode **puts** der Antwort in einen Puffer schreiben oder einfach die Variable *reply_body* des Objekts füllen. Die von der Methode **content** zurückgegebenen Informationen werden in keiner Weise interpretiert. Wenn eine Ausnahme ausgelöst wird (beispielsweise über den Befehl **error** in Tcl), erzeugt der Aufrufer automatisch eine Meldung 500 {Internal Error}. Eine typische Implementierung von **content** sieht wie folgt aus:


```
 clay::define ::test::content.file {
 	superclass ::httpd::content.file
 	# Return a file
 	# Note: this is using the content.file mixin which looks for the reply_file variable
 	# and will auto-compute the Content-Type
 	method content {} {
 	  my reset
     set doc_root [my request get DOCUMENT_ROOT]
     my variable reply_file
     set reply_file [file join $doc_root index.html]
 	}
 }
 clay::define ::test::content.time {
   # return the current system time
 	method content {} {
 		my variable reply_body
     my reply set Content-Type text/plain
 		set reply_body [clock seconds]
 	}
 }
 clay::define ::test::content.echo {
 	method content {} {
 		my variable reply_body
     my reply set Content-Type [my request get CONTENT_TYPE]
 		set reply_body [my PostData [my request get CONTENT_LENGTH]]
 	}
 }
 clay::define ::test::content.form_handler {
 	method content {} {
 	  set form [my FormData]
 	  my reply set Content-Type {text/html; charset=UTF-8}
     my puts [my html_header {My Dynamic Page}]
     my puts "<BODY>"
     my puts "You Sent<p>"
     my puts "<TABLE>"
     foreach {f v} $form {
       my puts "<TR><TH>$f</TH><TD><verbatim>$v</verbatim></TD>"
     }
     my puts "</TABLE><p>"
     my puts "Send some info:<p>"
     my puts "<FORM action=/[my request get REQUEST_PATH] method POST>"
     my puts "<TABLE>"
     foreach field {name rank serial_number} {
       set line "<TR><TH>$field</TH><TD><input name=\"$field\" "
       if {[dict exists $form $field]} {
         append line " value=\"[dict get $form $field]\"""
       }
       append line " /></TD></TR>"
       my puts $line
     }
     my puts "</TABLE>"
     my puts [my html footer]
 	}
 }
```

**Variable**

Variable **ChannelRegister**
: ...siehe nächstes...

Variable **reply**
: Ein Dictionary, das in die MIME-Header der Antwort umgewandelt wird

Variable **request**
: Ein Dictionary, das die durch SCGI durchgeführte Transformation der HTTP-Header für die Anfrage **Delegate** enthält

Weiterleitung **\<server>**
: Das Server-Objekt, das diese Antwort erzeugt hat **Methods**

Methode **constructor** *ServerObj* ?*args*?
: ...siehe nächstes...

Methode **destructor** ?*dictargs*?
: Räumt beim Beenden auf.

Methode **ChannelRegister** ?*args*?
: Registriert einen Kanal, der von der Methode **close** geschlossen werden soll.

Methode **close**
: Schließt die von diesem Objekt geöffneten Kanäle.

Methode **Log_Dispatched**
: Erfasst ein Dispatch-Ereignis.

Methode **dispatch** *newsock* *datastate*
: Nimmt die Übergabe des Sockets *newsock* vom Server-Objekt entgegen und übergibt ihm den Zustand *datastate*. Felder, nach denen *datastate* insbesondere sucht, sind: \* **mixin** – eine Schlüssel-Wert-Liste mit Slots und Klassen, die vor dem Aufruf von **Dispatch** in das Objekt eingebunden werden sollen. \* **http** – eine Schlüssel-Wert-Liste mit Werten, die in das Ensemble *request* des Objekts eingefügt werden sollen. Alle übrigen Felder werden an die Struktur **clay** des Objekts weitergereicht.

Methode **Dispatch**
: ...siehe nächstes...

Methode **html_header** *title* ?*args*?
: ...siehe nächstes...

Methode **html_footer** ?*args*?
: ...siehe nächstes...

Methode **error** *code* ?*msg* ? ?*errorInfo* ?
: ...siehe nächstes...

Methode **content**
: REPLACE ME: Diese Methode ist der Kern Ihrer Anwendung. Sie schreibt über die Methode **puts** in den Ergebnispuffer und kann die Header über „clay put header_reply“ anpassen.

Methode **EncodeStatus** *status*
: Bildet aus der angegebenen Zeichenkette einen HTTP-Status-Header in Standardform.

Methode **log** *type* ?*info* ?
: ...siehe nächstes...

Methode **CoroName**
: ...siehe nächstes...

Methode **DoOutput**
: Erzeugt die HTTP-Antwort, überträgt sie über *chan* und zerstört das Objekt.

Methode **FormData**
: Bei GET-Anfragen wird der QUERY_DATA-Header in eine Schlüssel-Wert-Liste umgewandelt. Bei POST-Anfragen werden die POST-Daten gelesen und diese Informationen für „application/x-www-form-urlencoded“-POSTs in eine Schlüssel-Wert-Liste umgewandelt. Bei Multipart-Posts fasst es alle MIME-Header des Posts zu einer einzigen Schlüssel-Wert-Liste zusammen und stellt MIME\_\* Informationen bereit, wie sie vom Paket **mime** berechnet werden, einschließlich des MIME_TOKEN, das wieder in das mime-Paket eingespeist werden kann, um den Inhalt auszulesen.

Methode **PostData** *length*
: Liest *length* Bytes aus dem Socket *chan*, aber nur wenn die Anfrage ein POST oder PUSH ist. Andernfalls wird eine leere Zeichenkette zurückgegeben.

Methode **Session_Load**
: Verwaltet Sitzungsdaten.

Methode **puts** *line*
: Hängt den Wert von *string* an *reply_body* an und fügt ein abschließendes Zeilenumbruchzeichen hinzu.

Methode **RequestFind** *field*
: ...siehe nächstes...

Methode **request** *subcommand* ?*args*?
: ...siehe nächstes...

Methode **reply** *subcommand* ?*args*?
: ...siehe nächstes...

Methode **reset**
: Löscht den Inhalt der Variablen *reply_body* und setzt alle Header in der Struktur **reply** auf die Standardwerte dieses Objekts zurück.

Methode **timeOutCheck**
: Wird vom Objekt **http::server** aufgerufen, das diese Antwort ausgelöst hat. Es wird geprüft, ob beim Warten auf Daten oder beim Erstellen einer Antwort zu viel Zeit verstrichen ist; ist dies der Fall, wird ein Timeout-Fehler an die Anfrage zurückgegeben, das Objekt zerstört und der *chan*-Socket geschlossen.

Methode **timestamp**
: Gibt die aktuelle Systemzeit im folgenden Format zurück:


```
%a, %d %b %Y %T %Z
```

## Klasse httpd::server

*ancestors*: **httpd::mime**

**Variable**

Variable **template**
: ...siehe nächstes...

Variable **url_patterns**
: **Methods**

Methode **constructor** *args* ?*port* **auto**? ?*myaddr* **127.0.0.1**? ?*string* **auto**? ?*name* **auto**? ?*doc_root* ? ?*reverse_dns* **0**? ?*configuration_file* ? ?*protocol* **HTTP/1.1**?
: ...siehe nächstes...

Methode **destructor** ?*dictargs*?
: ...siehe nächstes...

Methode **connect** *sock* *ip* *port*
: Antwortet auf einen offenen Socket. Diese Methode erzeugt eine Coroutine, die den Rest der Verbindung verwaltet. Die Abläufe der Coroutine steuert die Methode **Connect**.

Methode **ServerHeaders** *ip* *http_request* *mimetxt*
: ...siehe nächstes...

Methode **Connect** *uuid* *sock* *ip*
: Diese Methode liest die HTTP-Header und greift anschließend auf die Methode **dispatch** zurück, um festzustellen, ob die Anfrage gültig ist und/oder welche Art von Antwort generiert werden soll. Im Normalfall wird ein Objekt der Klasse **::http::reply** erstellt und die Methode **dispatch** dieser Klasse aufgerufen. Dadurch wird die Kontrolle über den Socket an das Antwortobjekt übergeben. Das Antwortobjekt verwaltet den Rest der Transaktion, einschließlich des Schließens des Sockets.

Methode **counter** *which*
: Erhöht einen internen Zähler.

Methode **CheckTimeout**
: Prüft offene Verbindungen auf ein Timeout.

Methode **debug** ?*args*?
: ...siehe nächstes...

Methode **dispatch** *data*
: Gibt zu einer Schlüssel-Wert-Liste mit Informationen eine Datenstruktur zurück, die beschreibt, wie der Server antworten soll.

Methode **Dispatch_Default** *reply*
: Dispatch-Methode als letztes Mittel, bevor ein Fehler 404 NOT FOUND zurückgegeben wird. Standardmäßig wird in *DOCUMENT_ROOT* nach einer Datei gesucht, die zur Abfrage passt.

Methode **Dispatch_Local** *data*
: Dispatch-Methode, die vor den von Plugins implementierten Methoden aufgerufen wird. Gibt sie ein nicht leeres Dictionary zurück, wird diese Struktur an die Antwort übergeben. Die Standardimplementierung ist leer.

Methode **Headers_Local** *varname*
: Untersucht eine für eine Antwort vorgesehene Datenstruktur und passt sie gegebenenfalls an. Diese Methode wird vor den von Plugins implementierten Header-Methoden aufgerufen. Die Standardimplementierung ist leer.

Methode **Headers_Process** *varname*
: Untersucht eine für eine Antwort vorgesehene Datenstruktur und passt sie gegebenenfalls an. Diese Methode wird von der Methode **plugin** dynamisch aufgebaut.

Methode **HostName** *ipaddr*
: Wandelt eine IP-Adresse in einen Hostnamen um. Ist das Flag server/reverse_dns false, gibt die Methode nur die IP-Adresse zurück. Intern verwendet sie das Modul *dns* aus tcllib.

Methode **log** ?*args*?
: Protokolliert ein Ereignis. Die Eingabe für args ist frei formulierbar. Die Methode ist dafür vorgesehen, vom Benutzer ersetzt zu werden, und tut bei einem http::server-Objekt im Auslieferungszustand nichts.

Methode **plugin** *slot* ?*class* ?
: Bindet Verhalten aus einem Plugin ein. Diese Methode baut die Methoden **Dispatch** und **Headers** dynamisch neu auf. Für jedes Plugin sucht der Server unter *clay plugin/* nach diesen Einträgen: *load* – ein Skript, das beim Aufruf der Methode **plugin** im Namespace des Servers ausgeführt wird. *dispatch* – ein Skript, das in die Methode **Dispatch** des Servers eingefügt wird. *headers* – ein Skript, das in die Methode **Headers** des Servers eingefügt wird. *thread* – ein Skript, das in die Methode **Thread_start** des Servers eingefügt wird.

Methode **port_listening**
: Gibt den Port zurück, auf dem httpd tatsächlich auf Verbindungen wartet.

Methode **PrefixNormalize** *prefix*
: Die Fassung im Auslieferungszustand entfernt abschließende „/“ und „\*“ von einem Präfix. Die Methode kann ersetzt werden, um weitere für die Anwendung nötige Umformungen auszuführen.

Methode **source** *filename*
: ...siehe nächstes...

Methode **start**
: Öffnet den Socket-Listener.

Methode **stop**
: Schaltet den Socket-Listener ab und zerstört alle ausstehenden Antworten.

Methode **SubObject {} db**
: ...siehe nächstes...

Methode **SubObject {} default**
: ...siehe nächstes...

Methode **template** *page*
: Gibt eine Vorlage für die Zeichenkette *page* zurück.

Methode **TemplateSearch** *page*
: Sucht die Vorlage, die am besten zu *page* passt. Das kann lokale Dateisuchen, Strukturen im Arbeitsspeicher oder auch Datenbankabfragen umfassen. Die Fassung im Auslieferungszustand sucht nur nach Dateien mit der Erweiterung .tml oder .html im Verzeichnis ?doc_root?.

Methode **Thread_start**
: Wird von der Methode **plugin** aufgebaut. Wird von der Methode **start** aufgerufen. Damit können Plugins Arbeits-Threads erzeugen.

Methode **Uuid_Generate**
: Erzeugt eine GUUID. Damit erhält jede Anfrage eine eindeutige ID. Die Standardimplementierung lautet:


```
   return [::clay::uuid generate]
```

Methode **Validate_Connection** *sock* *ip*
: Gibt bei einem Socket und einer IP-Adresse true zurück, wenn diese Verbindung beendet werden soll, und false, wenn sie fortgesetzt werden darf. Die Fassung im Auslieferungszustand gibt stets 0 zurück. Anwendungen können damit Sperrlisten umsetzen und den Zugriff anhand der IP-Adresse einschränken.


## Klasse httpd::server::dispatch

*ancestors*: **httpd::server**

Stellt einen abwärtskompatiblen Alias bereit.

## Klasse httpd::content.redirect

**Methods**

Methode **reset**
: ...siehe nächstes...

Methode **content**
: 


## Klasse httpd::content.cache

**Methods**

Methode **Dispatch**
: 


## Klasse httpd::content.template

**Methods**

Methode **content**
: 


## Klasse httpd::content.file

Klasse zur Bereitstellung statischer Inhalte. Wenn diese Klasse verwendet wird, wird ihr vom Dispatcher ein lokaler Dateiname übergeben.

**Methods**

Methode **FileName**
: ...siehe nächstes...

Methode **DirectoryListing** *local_file*
: ...siehe nächstes...

Methode **content**
: ...siehe nächstes...

Methode **Dispatch**
: 


## Klasse httpd::content.exec

**Variable**

Variable **exename**
: **Methods**

Methode **CgiExec** *execname* *script* *arglist*
: ...siehe nächstes...

Methode **Cgi_Executable** *script*
: 


## Klasse httpd::content.proxy

*ancestors*: **httpd::content.exec**

Gibt Daten aus einem Proxy-Prozess zurück.

**Methods**

Methode **proxy_channel**
: ...siehe nächstes...

Methode **proxy_path**
: ...siehe nächstes...

Methode **ProxyRequest** *chana* *chanb*
: ...siehe nächstes...

Methode **ProxyReply** *chana* *chanb* ?*args*?
: ...siehe nächstes...

Methode **Dispatch**
: 


## Klasse httpd::content.cgi

*ancestors*: **httpd::content.proxy**

**Methods**

Methode **FileName**
: ...siehe nächstes...

Methode **proxy_channel**
: ...siehe nächstes...

Methode **ProxyRequest** *chana* *chanb*
: ...siehe nächstes...

Methode **ProxyReply** *chana* *chanb* ?*args*?
: ...siehe nächstes...

Methode **DirectoryListing** *local_file*
: Bei den meisten CGI-Anwendungen ist eine Verzeichnisauflistung verboten.


## Klasse httpd::protocol.scgi

Gibt Daten aus einem SCGI-Prozess zurück.

**Methods**

Methode **EncodeStatus** *status*
: 


## Klasse httpd::content.scgi

*ancestors*: **httpd::content.proxy**

**Methods**

Methode **scgi_info**
: ...siehe nächstes...

Methode **proxy_channel**
: ...siehe nächstes...

Methode **ProxyRequest** *chana* *chanb*
: ...siehe nächstes...

Methode **ProxyReply** *chana* *chanb* ?*args*?
: 


## Klasse httpd::server.scgi

*ancestors*: **httpd::server**

Fungiert als SCGI-Server.

**Methods**

Methode **debug** ?*args*?
: ...siehe nächstes...

Methode **Connect** *uuid* *sock* *ip*
: 


## Klasse httpd::content.websocket

Wertet eine Verbindung zu einem WebSocket auf.

## Klasse httpd::plugin

httpd-Plugin-Vorlage

## Klasse httpd::plugin.dict_dispatch

Ein einfaches Plugin, das URLs anhand einer dict-Datenstruktur weiterleitet.

**Methods**

Methode **Dispatch_Dict** *data*
: Implementierung des Dispatchers

Methode **uri {} add** *vhosts* *patterns* *info*
: ...siehe nächstes...

Methode **uri {} direct** *vhosts* *patterns* *info* *body*
: 


## Klasse httpd::reply.memchan

*ancestors*: **httpd::reply**

**Methods**

Methode **output**
: ...siehe nächstes...

Methode **DoOutput**
: ...siehe nächstes...

Methode **close**
: 


## Klasse httpd::plugin.local_memchan

**Methods**

Methode **local_memchan** *command* ?*args*?
: ...siehe nächstes...

Methode **Connect_Local** *uuid* *sock* ?*args*?
: Eine abgewandelte Verbindungsmethode, die eine einfache GET-Anfrage an ein Objekt übergibt und die Daten direkt aus der Variablen reply_body des Objekts holt. Nötig, weil memchan bidirektional ist und sich anscheinend nicht ausdrücken lässt, dass der Server die eine Seite der Verbindung ist und die Antwort die andere.


# AUTOREN

Sean Woods

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *network* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2018 Sean Woods <yoda@etoyoc.com>
```
