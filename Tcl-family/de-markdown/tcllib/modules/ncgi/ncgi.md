---
CommandName: ncgi
ManualSection: n
Version: 1.4.6
TclPart: tcllib
TclDescription: CGI Support
Links:
 - html
Keywords:
 - CGI
 - cookie
 - form
 - html
Copyright:
---

# NAME

ncgi – Prozeduren zur Bearbeitung von CGI-Werten.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [ncgi]{.lit} [1.4.6]{.optlit} 
[::ncgi::cookie]{.cmd} [cookie]{.arg} 
[::ncgi::decode]{.cmd} [str]{.arg} 
[::ncgi::empty]{.cmd} [name]{.arg} 
[::ncgi::exists]{.cmd} [name]{.arg} 
[::ncgi::encode]{.cmd} [string]{.arg} 
[::ncgi::header]{.cmd} [type]{.optarg} [args]{.arg} 
[::ncgi::import]{.cmd} [cginame]{.arg} [tclname]{.optarg} 
[::ncgi::importAll]{.cmd} [args]{.arg} 
[::ncgi::importFile]{.cmd} [cmd]{.arg} [cginame]{.arg} [filename]{.optarg} 
[::ncgi::input]{.cmd} [fakeinput]{.optarg} [fakecookie]{.optarg} 
[::ncgi::multipart]{.cmd} [type]{.arg} [query]{.arg} 
[::ncgi::nvlist]{.cmd} 
[::ncgi::names]{.cmd} 
[::ncgi::parse]{.cmd} 
[::ncgi::parseMimeValue]{.cmd} [value]{.arg} 
[::ncgi::query]{.cmd} 
[::ncgi::redirect]{.cmd} [url]{.arg} 
[::ncgi::reset]{.cmd} [query]{.arg} [type]{.arg} 
[::ncgi::setCookie]{.cmd} [args]{.arg} 
[::ncgi::setDefaultValue]{.cmd} [key]{.arg} [defvalue]{.arg} 
[::ncgi::setDefaultValueList]{.cmd} [key]{.arg} [defvaluelist]{.arg} 
[::ncgi::setValue]{.cmd} [key]{.arg} [value]{.arg} 
[::ncgi::setValueList]{.cmd} [key]{.arg} [valuelist]{.arg} 
[::ncgi::type]{.cmd} 
[::ncgi::urlStub]{.cmd} [url]{.optarg} 
[::ncgi::value]{.cmd} [key]{.arg} [default]{.optarg} 
[::ncgi::valueList]{.cmd} [key]{.arg} [default]{.optarg} 
:::

# BESCHREIBUNG

Das **ncgi**-Paket stellt Befehle zur Bearbeitung von CGI-Werten bereit. Dabei handelt es sich um Werte, die aus Webformularen stammen und entweder von CGI-Skripten oder von Seiten mit eingebettetem Tcl-Code verarbeitet werden. Verwenden Sie das **ncgi**-Paket, um diese Werte abzufragen, Cookies zu setzen und abzurufen sowie www-url-codierte Werte zu kodieren und zu decodieren.

Im einfachsten Fall ruft ein CGI-Skript zunächst **::ncgi::parse** und anschließend **::ncgi::value** auf, um verschiedene Werte aus dem Formular abzurufen.  Wenn ein CGI-Wert wiederholt wird, sollten Sie **::ncgi::valueList** verwenden, um die vollständige Liste der Werte abzurufen.

Eine Alternative zu **::ncgi::parse** ist **::ncgi::input**, dessen Funktionsweise der Prozedur **cgi_input** von Don Libes ähnelt. **::ncgi::input** beschränkt wiederholte CGI-Werte so, dass ihre Name mit „List“ enden.  In diesem Fall gibt **::ncgi::value** die vollständige Liste der Werte zurück, während **::ncgi::input** Fehler auslöst, wenn es wiederholte Formularelemente ohne den richtigen Name findet.

Die Prozedur **::ncgi::reset** kann in TESTS und auf Webservern verwendet werden, um die Quelle der CGI-Werte zu initialisieren. Andernfalls werden die Werte aus der CGI-Umgebung eingelesen.

Im Folgenden wird der gesamte Ablauf der Prozeduren beschrieben.

**::ncgi::cookie** *cookie*
: Gibt eine Liste der Werte für *cookie* zurück, sofern vorhanden. Da möglicherweise mehrere Cookies mit demselben Namen vorhanden sind, gibt diese Prozedur eine Liste zurück.

**::ncgi::decode** *str*
: Dekodiert Zeichenketten in der www-url-encoding-Kodierung, bei der Sonderzeichen durch die Zeichenfolge „%xx“ dargestellt werden, wobei „xx“ für den Zeichencode im Hexadezimalformat steht.

**::ncgi::empty** *name*
: Gibt 1 zurück, wenn die CGI-Variable *name* nicht vorhanden ist oder den Wert „leere Zeichenkette“ hat.

**::ncgi::exists** *name*
: Der Wert wird als boolescher Wert zurückgegeben. Er gibt **0** zurück, wenn die CGI-Variable *name* nicht vorhanden ist, andernfalls **1**.

**::ncgi::encode** *string*
: *string* im www-url-encoded-Format kodieren.

**::ncgi::header** ?*type*? *args*
: Gibt den CGI-Header an die Standardausgabe aus. Dabei werden ein „Content-Type:“-Header sowie weitere Header basierend auf *args* ausgegeben, wobei *args* eine Liste aus Header-Namen und Header-Werten ist. Der Standardwert für *type* ist „text/html“.

**::ncgi::import** *cginame* ?*tclname*?
: Dadurch wird im aktuellen Gültigkeitsbereich eine Variable mit dem Wert der CGI-Variablen *cginame* angelegt. Der Name der Variablen lautet *tclname* oder *cginame*, falls *tclname* leer ist (Standard).

**::ncgi::importAll** *args*
: Dadurch werden mehrere CGI-Variablen als Tcl-Variablen importiert. Wenn *args* leer ist, werden alle CGI-Werte importiert. Andernfalls wird jede in *args* aufgeführte CGI-Variable importiert.

**::ncgi::importFile** *cmd* *cginame* ?*filename*?
: Hiermit werden Informationen zu einer hochgeladenen Datei aus einem Formular-Eingabefeld vom Typ **file** mit dem Name *cginame* bereitgestellt.  *cmd* kann einer der folgenden Werte sein: **-server**, **-client**, **-type** oder **-data** lauten.


**-client** *cginame*
: gibt den vom Client gesendeten Dateinamen zurück.

**-type** *cginame*
: Gibt den MIME-Typ der hochgeladenen Datei zurück.

**-data** *cginame*
: gibt den Inhalt der Datei zurück.

**-server** *cginame* *filename*
: Schreibt den Inhalt der Datei in eine lokale temporäre Datei (oder den Dateinamen, wenn angegeben) und gibt den Namen der Datei zurück. Der Aufrufer ist dafür verantwortlich, diese Datei nach der Verwendung zu löschen.


**::ncgi::input** ?*fakeinput*? ?*fakecookie*?
: Diese Funktion liest die CGI-Werte aus der Umgebung ein und dekodiert sie. Sie sorgt dafür, dass wiederholte Formularwerte am Ende ihres NAMENS den Zusatz „List“ enthalten. Die CGI-Werte werden später mit der Prozedur **::ncgi::value** abgerufen.

**::ncgi::multipart** *type query*
: Diese Prozedur analysiert eine *Abfrage* vom Typ „multipart/form-data“. Sie wird von **::ncgi::nvlist** verwendet und normalerweise nicht direkt aufgerufen. Sie gibt eine abwechselnde Liste aus Namen und strukturierten Werten zurück. Jeder strukturierte Wert ist wiederum eine Liste aus zwei Elementen.  Das erste Element enthält Metadaten aus der „multipart/form-data“-Struktur.  Das zweite Element ist der Formularwert.  Wenn Sie **::ncgi::value** verwenden, erhalten Sie lediglich den Formularwert.  Wenn Sie **::ncgi::valueList** verwenden, erhalten Sie den strukturierten Wert mit Metadaten und dem Wert. Der *Typ* ist der gesamte Content-Type, einschließlich der Parameter wie *boundary*. Dies gibt eine Liste von Namen und Werten zurück, die die Multipart-Daten beschreiben. Die Werte sind eine verschachtelte Listenstruktur, die zunächst einige beschreibende Informationen und anschließend den eigentlichen Formularwert enthält. Die beschreibenden Informationen sind eine Liste von Header-Namen und Werten, die den Inhalt beschreiben.

**::ncgi::nvlist**
: Dadurch geben Sie alle Abfragedaten als Liste aus Namen und Werten zurück. Bei „multipart/form-data“ sind die Werte wie in **::ncgi::multipart** beschrieben strukturiert.

**::ncgi::names**
: Dies gibt alle in den Abfragedaten gefundenen Namen als Liste zurück. **::ncgi::multipart**.

**::ncgi::parse**
: Diese Prozedur liest die CGI-Werte aus der Umgebung ein und dekodiert sie. Die CGI-Werte werden später mit der Prozedur **::ncgi::value** abgerufen. Wenn ein CGI-Wert mehrfach vorkommt, sollten Sie **::ncgi::valueList** verwenden, um die vollständige Liste der Werte zu erhalten.

**::ncgi::parseMimeValue** *value*
: Diese Funktion dekodiert den Content-Type und andere MIME-Header, die die Form „primärer Wert; param=val; p2=v2“ haben. Sie gibt eine Liste zurück, deren erstes Element der primäre Wert ist und deren zweites Elemente eine Liste mit Parameternamen und -werten enthält.

**::ncgi::query**
: Dies gibt die Rohdaten der Abfrage zurück.

**::ncgi::redirect** *url*
: Erzeugt eine Antwort, die eine 302-Weiterleitung durch den Webserver auslöst. Die *url* ist die neue URL, auf die die Weiterleitung zielt. Die URL wird bei Bedarf mit dem aktuellen Server und dem aktuellen Verzeichnis ergänzt, um sie in eine vollständige URL umzuwandeln.

**::ncgi::reset** *query type*
: Legt die Abfragedaten und den Content-Type für die aktuelle CGI-Sitzung fest. Dies wird von der Testsuite und von Webservern verwendet, um das ncgi-Modul so zu initialisieren, dass es nicht versucht, Daten aus der Standardeingabe zu lesen oder Variablen zu verwenden, um seine Daten zu beziehen.  Wenn weder *query* noch *type* festgelegt sind, sucht das **ncgi**-Modul seine Daten in der Standard-CGI-Umgebung.

**::ncgi::setCookie** *args*
: Legt einen Cookie-Wert fest, der als Teil der Antwort zurückgegeben wird. Dies muss erfolgen, bevor **::ncgi::header** oder **::ncgi::redirect** aufgerufen wird, damit das Cookie korrekt zurückgegeben wird.  Die *args* sind eine Reihe von Flags und Werten:


**-name** *name*
: ...siehe nächstes...

**-value** *value*
: ...siehe nächstes...

**-expires** *date*
: ...siehe nächstes...

**-path** *path restriction*
: ...siehe nächstes...

**-domain** *domain restriction*
: 


**::ncgi::setDefaultValue** *key defvalue*
: Legt einen CGI-Wert fest, wenn dieser noch nicht vorhanden ist. Dies wirkt sich auf zukünftige Aufrufe von **::ncgi::value** aus (jedoch nicht auf zukünftige Aufrufe von **::ncgi::nvlist**). Wenn der CGI-Wert bereits vorhanden ist, hat diese Prozedur keine Nebenwirkungen.

**::ncgi::setDefaultValueList** *key defvaluelist*
: Ähnlich wie **::ncgi::setDefaultValue**, mit dem Unterschied, dass der Wert bereits eine Listenstruktur aufweist, um mehrere Kontrollkästchen oder eine Mehrfachauswahl darzustellen.

**::ncgi::setValue** *key value*
: Legt einen CGI-Wert fest, der alle bereits in der CGI-Umgebung vorhandenen Werte überschreibt. Dies wirkt sich auf zukünftige Aufrufe von **::ncgi::value** aus (jedoch nicht auf zukünftige Aufrufe von **::ncgi::nvlist**).

**::ncgi::setValueList** *key valuelist*
: Ähnlich wie **::ncgi::setValue**, mit dem Unterschied, dass der Wert bereits eine Listenstruktur aufweist, um mehrere Kontrollkästchen oder eine Mehrfachauswahl darzustellen.

**::ncgi::type**
: Gibt den Content-Type der aktuellen CGI-Werte zurück.

**::ncgi::urlStub** ?*url*?
: Gibt die aktuelle URL zurück, jedoch ohne Protokoll, Server und Port. Wenn *url* angegeben wird, legt dies die URL für die aktuelle Sitzung fest. Dieser Wert wird bei zukünftigen Aufrufen von **::ncgi::urlStub** zurückgegeben.

**::ncgi::value** *key* ?*default*?
: Gibt den durch *key* identifizierten CGI-Wert zurück. Wenn der CGI-Wert nicht vorhanden ist, gibt es stattdessen den *Standardwert* zurück. Dieser Wert ist standardmäßig die leere Zeichenkette. Wenn der Formularwert *key* wiederholt wird, gibt es zwei Fälle: Wurde **::ncgi::parse** aufgerufen, gibt **::ncgi::value** nur den ersten mit *key* verknüpften Wert zurück.  Wenn **::ncgi::input** aufgerufen wird, gibt **::ncgi::value** einen Tcl-Wert zurück, und *key* muss auf „List“ enden (z. B. „skuList“).  Im Fall von „multipart/form-data“ gibt diese Prozedur lediglich den Wert des Formularelements zurück. Wenn Sie die zu jedem Formularwert gehörenden Metadaten erhalten möchten, verwenden Sie **::ncgi::valueList**.

**::ncgi::valueList** *key* ?*default*?
: Ähnlich wie **::ncgi::value**, gibt diese Prozedur jedoch immer eine Liste von Werten zurück (auch wenn nur ein Wert vorhanden ist). Im Fall von „multipart/form-data“ gibt diese Prozedur eine Liste mit zwei Elementen zurück. Das erste Element besteht aus Metadaten in Form einer Parameter-Wert-Liste. Das zweite Element ist der Formularwert.


# BEISPIELE

Eine Datei hochladen

```
HTML:
<html>
<form action="/cgi-bin/upload.cgi" method="POST" enctype="multipart/form-data">
Path: <input type="file" name="filedata"><br>
Name: <input type="text" name="filedesc"><br>
<input type="submit">
</form>
</html>

TCL: upload.cgi
#!/usr/local/bin/tclsh

::ncgi::parse
set filedata [::ncgi::value filedata]
set filedesc [::ncgi::value filedesc]

puts "<html> File uploaded at <a href=\"/images/$filedesc\">$filedesc</a> </html>"

set filename /www/images/$filedesc

set fh [open $filename w]
puts -nonewline $fh $filedata
close $fh
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *ncgi* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

CGI-Programmierung
