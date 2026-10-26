---
CommandName: uri
ManualSection: n
Version: 1.2.8
TclPart: tcllib
TclDescription: Tcl Uniform Resource Identifier Management
Keywords:
 - fetching information
 - file
 - ftp
 - gopher
 - http
 - https
 - ldap
 - mailto
 - news
 - prospero
 - rfc 1630
 - rfc 2255
 - rfc 2396
 - rfc 3986
 - uri
 - url
 - wais
 - www
Copyright:
---

# NAME

uri – URI-Dienstprogramme

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [uri]{.lit} [1.2.8]{.optlit} 
[uri::setQuirkOption]{.cmd} [option]{.arg} [value]{.optarg} 
[uri::split]{.cmd} [url]{.arg} [defaultscheme]{.optarg} 
[uri::join]{.cmd} [key value?]{.optdot} 
[uri::resolve]{.cmd} [base]{.arg} [url]{.arg} 
[uri::isrelative]{.cmd} [url]{.arg} 
[uri::geturl]{.cmd} [url]{.arg} [options]{.optdot} 
[uri::canonicalize]{.cmd} [uri]{.arg} 
[uri::register]{.cmd} [schemeList]{.arg} [script]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket erfüllt zwei Aufgaben.

Erstens bietet es eine Reihe von Befehlen zur Bearbeitung von URLs/URIs und zum Abrufen der darin festgelegten Daten. Zum Abrufen von Daten analysiert dieses Paket die angeforderte URL/URI und leitet sie anschließend an das entsprechende Paket (**http**, **ftp**, …) weiter, um die Daten tatsächlich abzurufen.  Derzeit sind diese Befehle für die Schemata *http*, *https*, *ftp*, *mailto*, *news*, *ldap*, *ldaps* und *file* definiert. Das Paket **uri::urn** fügt das Schema *urn* hinzu.

Zweitens stellt es reguläre Ausdrücke für eine Reihe von **registered** URL-/URI-Schemas bereit. Zu den registrierten Schemata gehören derzeit *ftp*, *ldap*, *ldaps*, *file*, *http*, *https*, *gopher*, *mailto*, *news*, *wais* und *prospero*.  Das Paket **uri::urn** fügt das Schema *urn* hinzu.

Die Befehle des Pakets entsprechen RFC 3986 (*https://www.rfc-editor.org/rfc/rfc3986.txt*), mit Ausnahme einer Lücke, die sich aus RFC 1630 ergibt und in RFC 3986, Abschnitte 5.2.2 und 5.4.2, beschrieben ist. Diese Lücke erlaubt es, dass eine relative URI ein Schema enthält, wenn dieses mit dem Schema der Basis-URI übereinstimmt, anhand derer sie aufgelöst wird. RFC 3986 empfiehlt, diese Verwendung zu vermeiden.

# BEFEHLE

**uri::setQuirkOption** *option* ?*value*?
: **uri::setQuirkOption** ist ein Zugriffsbefehl für eine Reihe von „Quirk-Optionen“. Der Befehl hat dieselbe Semantik wie der Befehl **set**: Wird er mit einem Argument aufgerufen, liest er einen vorhandenen Wert aus; mit zwei Argumenten schreibt er einen neuen Wert.  Der Wert einer „Quirk-Option“ ist boolesch: Der Wert **false** fordert die Konformität mit RFC 3986, während **true** die Verwendung der Quirk verlangt.  Eine Erläuterung der verschiedenen Optionen und ihres Zwecks finden Sie im Abschnitt **QUIRK-OPTIONEN**.

**uri::split** *url* ?*defaultscheme*?
: **uri::split** nimmt eine *URL* entgegen, dekodiert sie und gibt anschließend eine Liste von Schlüssel-Wert-Paaren zurück, die für **array set** geeignet sind und die Bestandteile der *URL* enthalten. Wenn das Schema in der *URL* fehlt, wird standardmäßig der Wert von *defaultscheme* verwendet, wenn dieser festgelegt wurde, andernfalls *http*. Derzeit werden die Schemata *http*, *https*, *ftp*, *mailto*, *news*, *ldap*, *ldaps* und *file* vom Paket selbst unterstützt. Informationen dazu, wie dieser Bereich erweitert werden kann, finden Sie im Abschnitt **ERWEITERUNG**. Die Menge der Bestandteile einer URL (= die Menge der Schlüssel im zurückgegebenen Dictionary) hängt vom Schema der URL ab. Der einzige Schlüssel, der daher immer vorhanden ist, ist **scheme**. Für die folgenden Schemata sind die Bestandteile und ihre Schlüssel bekannt:


**ftp**
: **user**, **pwd**, **host**, **port**, **path**, **type**, **pbare**. Das Feld „pbare“ ist optional.

**http(s)**
: **user**, **pwd**, **host**, **port**, **path**, **query**, **fragment**, **pbare**. Das „pbare“ ist optional.

**file**
: **path**, **host**. Der Host ist optional.

**mailto**
: **user**, **host**. Der Host ist optional.

**ldap(s)**
: **host**, **port**, **dn**, **attrs**, **scope**, **filter**, **extensions**

**news**
: Entweder **message-id** oder **newsgroup-name**.


: Eine Erläuterung des booleschen Werts **pbare** finden Sie unter den Optionen *NoInitialSlash* und *NoExtraKeys* in **QUIRK-OPTIONEN**. Die Bestandteile werden als Ausschnitte des Arguments *url* zurückgegeben, ohne Entfernung der Prozent-Kodierung („URL-Kodierung“) oder anderer Anpassungen. Insbesondere unter Windows® ist der **path** in *file* kein gültiger lokaler Dateiname. Weitere Informationen finden Sie unter **BEISPIELE**.


**uri::join** ?*key* *value*?...
: **uri::join** nimmt eine Liste von Schlüssel-Wert-Paaren entgegen (die beispielsweise von **uri::split** generiert wurden) und gibt die kanonische URL zurück, die diese darstellen. Derzeit werden die Schemata *http*, *https*, *ftp*, *mailto*, *news*, *ldap*, *ldaps* und *file* vom Paket selbst unterstützt. Informationen dazu, wie dieser Bereich erweitert werden kann, finden Sie im Abschnitt **ERWEITERUNG**. Die Argumente müssen Ausschnitte einer gültigen URL sein, mit Prozent-Kodierung („URL-Kodierung“) und allen anderen erforderlichen Anpassungen. Insbesondere ist unter Windows der **path** im Schema *file* kein gültiger lokaler Dateiname. Weitere Informationen finden Sie unter **BEISPIELE**.

**uri::resolve** *base* *url*
: **uri::resolve** löst die festgelegte *URL* relativ zu *base* gemäß RFC 3986 auf. Mit anderen Worten: Eine nicht-relative *url* wird unverändert zurückgegeben, während bei einer relativen *url* die fehlenden Teile aus *base* entnommen und dieser vorangestellt werden. Das Ergebnis dieser Operation wird zurückgegeben. Bei einer leeren *url* ist das Ergebnis *base* ohne deren URI-Fragment (falls vorhanden). Der Befehl ist für die Schemata *http*, *https*, *ftp* und *file* verfügbar.

**uri::isrelative** *url*
: **uri::isrelative** ermittelt, ob die angegebene *URL* absolut oder relativ ist. Der Befehl steht für *URLs* mit beliebigen Schemata zur Verfügung.

**uri::geturl** *url* ?*options*...?
: **uri::geturl** dekodiert die angegebene *URL* und leitet die Anfrage anschließend an das Paket weiter, das für das in der URL gefundene Schema geeignet ist. Der Befehl geht davon aus, dass das Paket zur Verarbeitung des angegebenen Schemas entweder denselben Namen wie das Schema selbst (einschließlich möglicher Groß- und Kleinschreibung) gefolgt von **::geturl** trägt oder, falls dies nicht der Fall ist, denselben Namen wie das Schema selbst (einschließlich möglicher Groß- und Kleinschreibung) hat. Er geht ferner davon aus, dass das geladene Paket eine Funktion **geturl**-command im Namespace bereitstellt, der denselben Namen wie das Paket selbst trägt. Dieser Befehl wird mit der angegebenen *URL* und allen angegebenen *Optionen* aufgerufen. Derzeit verarbeitet **geturl** selbst keine Optionen. *Hinweis:* *file*-URLs bilden eine Ausnahme von der oben beschriebenen Regel. Sie werden intern verarbeitet. Es ist nicht möglich, die Ergebnisse des Befehls festzulegen. Sie hängen von der Funktion **geturl**-command für das Schema ab, an das die Anfrage weitergeleitet wurde.

**uri::canonicalize** *uri*
: **uri::canonicalize** gibt die kanonische Form einer URI zurück. Die kanonische Form einer URI ist eine Form, in der relative Pfade, d. h. „.“ und „..“, aufgelöst wurden.  Der Befehl ist für alle URI-Schemas verfügbar, für die die Befehle **uri::split** und **uri::join** vorhanden sind. Der Befehl gibt eine kanonisierte URI zurück, wenn das URI-Schema eine **path**-Komponente enthält (d. h. *http*, *https*, *ftp* und *file*).  Bei Schemata, die über die Befehle **uri::split** und **uri::join** verfügen, aber keine **path**-Komponente haben (d. h. *mailto*, *news*, *ldap* und *ldaps*), gibt der Befehl die *uri* unverändert zurück.

**uri::register** *schemeList* *script*
: **uri::register** registriert das erste Element von *schemeList* als neues Schema und die übrigen Elemente als Aliase für dieses Schema. Es erstellt den Namespace für das Schema und führt das *Skript* im neuen Namespace aus. Das Skript muss Variablen deklarieren, die für das Schema relevante reguläre Ausdrücke enthalten. Zumindest die Variable **schemepart** muss deklariert werden, da diese dazu dient, die Variablen zu erweitern, die die registrierten Schemata verwalten.


# PROGRAMME

Zusätzlich zu den oben genannten Befehlen bietet dieses Paket reguläre Ausdrücke zur Erkennung von URLs für eine Reihe von URL-Schemas.

Für jedes unterstützte Schema wird innerhalb des Namensraums *uri* ein Namespace bereitgestellt, der denselben Namen wie das Schema selbst trägt. Dieser enthält die Variable **url**, deren Inhalt ein regulärer Ausdruck zur Erkennung von URLs dieses Schemas ist. Weitere Variablen können reguläre Ausdrücke für Teile von URLs dieses Schemas enthalten.

Die Variable **uri::schemes** enthält eine Liste aller registrierten Schemata. Derzeit sind dies *ftp*, *ldap*, *ldaps*, *file*, *http*, *https*, *gopher*, *mailto*, *news*, *wais* und *prospero*.

# ERWEITERUNG

Die Erweiterung der von **uri::split** und **uri::join** unterstützten Schemata ist einfach, da beide Befehle die Anfrage nicht selbst bearbeiten, sondern sie anhand des Schemas der URL an einen anderen Befehl im *uri*-Namespace weiterleiten.

**uri::split** und **uri::join** rufen **Split\[string totitle \<scheme>\]** bzw. **Join\[string totitle \<scheme>\]** auf.

Die Bereitstellung der Befehle „split“ und „join“ reicht aus, um die Befehle **uri::canonicalize** und **uri::geturl** zu erweitern (wobei Letzteres von der Verfügbarkeit eines geeigneten Pakets mit einem **geturl**-Befehl abhängt).  Um hingegen den Befehl **uri::resolve** auf ein neues Schema zu erweitern, muss der Befehl selbst geändert werden.

Um die Palette der Schemata zu erweitern, für die Musterinformationen verfügbar sind, verwenden Sie den Befehl **uri::register**.

Ein Beispiel für ein Paket, das sowohl Befehle als auch Musterinformationen für ein neues Schema bereitstellt, ist **uri::urn**, das das Schema *urn* hinzufügt.

# QUIRK-OPTIONEN

Der Wert einer „Quirk-Option“ ist ein boolescher Wert: Der Wert **false** fordert die Konformität mit RFC 3986, während **true** die Verwendung des Quirks anfordert. Verwenden Sie den Befehl **uri::setQuirkOption**, um auf die Werte der Quirk-Optionen zuzugreifen.

Quirk-Optionen sind sowohl nützlich, um bei Änderungen an der Befehlsspezifikation Abwärtskompatibilität zu gewährleisten, als auch, um nützliche Funktionen hinzuzufügen, die nicht in den RFC-Spezifikationen enthalten sind. Derzeit sind folgende Quirk-Optionen definiert:

*NoInitialSlash*
: Diese „Besonderheiten“-Option betrifft das führende Zeichen vom **path** (sofern nicht leer) in den Schemata *http*, *https* und *ftp*. RFC 3986 definiert, dass **path** in einer absoluten URI mit einem führenden „/“ beginnen muss, es sei denn, der Wert von **path** ist die leere Zeichenkette. Für das Schema *file* folgen alle Versionen des Pakets **uri** dieser Regel.  Die Quirk-Option *NoInitialSlash* gilt nicht für das Schema *file*. Für die Schemata *http*, *https* und *ftp* definieren Versionen von **uri** vor 1.2.7, dass **path** *KEIN* führendes „/“ enthält.  Wenn die Quirk-Option *NoInitialSlash* auf **true** gesetzt ist (Standardeinstellung), wird dieses Verhalten auch in Version 1.2.7 angewendet.  Um stattdessen die in RFC 3986 definierten Werte für **path** zu verwenden, setzen Sie diese Quirk-Option auf **false**. Diese Einstellung hat keinen Einfluss auf die Konformität mit RFC 3986.  Wenn *NoInitialSlash* auf **true** gesetzt ist, kann der Wert von **path** in den Schemata *http*, *https* oder *ftp* nicht zwischen URIs unterscheiden, bei denen der vollständige „RFC 3986-Pfad“ jeweils die leere Zeichenkette „“ oder einen einzelnen Schrägstrich „/“ ist.  Die fehlenden Informationen werden in einem zusätzlichen **uri::split**-Schlüssel **pbare** erfasst. Der boolesche Wert **pbare** wird definiert, wenn die Besonderheiten *NoInitialSlash* und *NoExtraKeys* die Werte **true** bzw. **false** haben.  In diesem Fall gilt: Ist der Wert von **path** die leere Zeichenkette „“, ist **pbare** **true**, wenn der vollständige „RFC 3986-Pfad“ „“ ist, und **pbare** ist **false**, wenn der vollständige „RFC 3986-Pfad“ „/“ ist. Die Verwendung der Quirk-Option *NoInitialSlash* ist eine Frage der persönlichen Vorliebe.

*NoExtraKeys*
: Diese Quirk-Option ermöglicht vollständige Abwärtskompatibilität mit Versionen von **uri** vor 1.2.7, indem der oben beschriebene **uri::split**-Schlüssel **pbare** weggelassen wird (siehe Quirk-Option *NoInitialSlash*).  Das Ergebnis ist eine größere Abwärtskompatibilität des Befehls **uri::split** Befehl, jedoch die Unfähigkeit, zwischen URIs zu unterscheiden, bei denen der vollständige „RFC 3986-Pfad“ jeweils die leere Zeichenkette "" oder einen einzelnen Schrägstrich „/“ ist – d. h. eine geringfügige Abweichung vom RFC 3986. Wenn die Quirk-Option *NoExtraKeys* auf **false** gesetzt (Standard), gibt der Befehl **uri::split** einen zusätzlichen Schlüssel **pbare** zurück, und die Befehle entsprechen RFC 3986. Wenn die Quirk-Option *NoExtraKeys* auf **true** gesetzt ist, wird der Schlüssel **pbare** nicht definiert, und es besteht keine vollständige Konformität mit RFC 3986. Die Verwendung der Quirk-Option *NoExtraKeys* wird *NICHT* empfohlen, da sie bei der Einstellung auf **true** die Konformität mit RFC 3986 beeinträchtigt.  Die Option ist nur aus Gründen der Kompatibilität enthalten, um mit Code kompatibel zu sein, der für frühere Versionen von **uri** geschrieben wurde und Werte für **path** ohne führendes „/“ benötigt, *UND AUCH* unerwartete Schlüssel in den Ergebnissen von **uri::split** nicht tolerieren kann.

*HostAsDriveLetter*
: Wenn Sie das Schema *file* auf der Windows-Plattform verarbeitet, verwenden Versionen von **uri** vor 1.2.7 das Feld **host** zur Darstellung eines Windows-Laufwerksbuchstabens und des darauf folgenden Doppelpunkts sowie das Feld **path** zur Darstellung des Dateinamenspfads nach dem Doppelpunkt.  Solche URIs sind ungültig und werden von keinem RFC anerkannt. Wenn die Option *HostAsDriveLetter* auf **true** gesetzt ist, wird dieses Verhalten auch in Version 1.2.7 verwendet.  Um unter Windows *file*-URIs zu verwenden, die dem RFC 3986 entsprechen, setzen Sie diese Option auf **false** (Standard). Die Verwendung dieser Quirk-Option wird *NICHT* empfohlen, da bei der Einstellung **true** die **uri**-Befehle ungültige URIs erwarten und erzeugen. Die Option ist nur aus Gründen der Kompatibilität mit älterem Code enthalten.

*RemoveDoubleSlashes*
: Wenn eine URI durch **uri::canonicalize** kanonisiert wird, wird ihr **path** durch Entfernen der Segmente „.“ und „..“ normalisiert.  RFC 3986 schreibt die Entfernung leerer Segmente „“ nicht vor (d. h. die Zusammenführung doppelter Schrägstriche, was ein Merkmal der Normalisierung von Dateinamen, nicht jedoch der **path**-Normalisierung von URIs ist): Er behandelt URIs mit überzähligen Schrägstrichen so, als würden sie auf unterschiedliche Ressourcen verweisen.  Wenn die Quirk-Option *RemoveDoubleSlashes* auf **true** gesetzt ist (Standardeinstellung), werden leere Segmente aus dem **path** entfernt.  Um die Entfernung zu verhindern und damit RFC 3986 zu entsprechen, setzen Sie diese Quirk-Option auf **false**. Die Verwendung dieser Besonderheiten-Option ist eine Frage der Präferenz. Ein URI mit doppelten Schrägstrichen im Pfad wurde höchstwahrscheinlich versehentlich generiert, ganz sicher dann, wenn er eine direkte Zuordnung zu einer Datei auf einem Server aufweist. In manchen Fällen kann es besser sein, den URI zu bereinigen; in anderen Fällen ist es besser, den URI beizubehalten und den möglichen Fehler vom Server behandeln zu lassen.


## Abwärtskompatibilität

Um sich so ähnlich wie möglich wie Versionen von **uri** vor 1.2.7 zu verhalten, legen Sie die folgenden Quirk-Optionen fest:

**•**
: **uri::setQuirkOption** *NoInitialSlash* 1

**•**
: **uri::setQuirkOption** *NoExtraKeys* 1

**•**
: **uri::setQuirkOption** *HostAsDriveLetter* 1

**•**
: **uri::setQuirkOption** *RemoveDoubleSlashes* 0 In Code, der die Rückgabe eines zusätzlichen Schlüssels **pbare** durch **uri::split** tolerieren kann, setzen Sie

**•**
: **uri::setQuirkOption** *NoExtraKeys* 0, um eine bessere Übereinstimmung mit RFC 3986 zu erreichen.


## Neue Designs

Für neue Projekte werden folgende Einstellungen empfohlen:

**•**
: **uri::setQuirkOption** *NoInitialSlash* 0

**•**
: **uri::setQuirkOption** *NoExtraKeys* 0

**•**
: **uri::setQuirkOption** *HostAsDriveLetter* 0

**•**
: **uri::setQuirkOption** *RemoveDoubleSlashes* 0|1


## Standardwerte

Die Standardwerte für das Paket **uri** in Version 1.2.7 sollen einen Kompromiss zwischen Abwärtskompatibilität und verbesserten Funktionen darstellen. In zukünftigen Versionen des Pakets **uri** können andere Werte gewählt werden.

**•**
: **uri::setQuirkOption** *NoInitialSlash* 1

**•**
: **uri::setQuirkOption** *NoExtraKeys* 0

**•**
: **uri::setQuirkOption** *HostAsDriveLetter* 0

**•**
: **uri::setQuirkOption** *RemoveDoubleSlashes* 1


# BEISPIELE

Ein lokaler Windows®-Dateiname wie „**C:\\Other Files\\startup.txt**“ ist nicht geeignet, als **path**-Element einer URI im Schema *file* verwendet zu werden.

Der Tcl-Befehl **file normalize** wandelt die Backslashes in Schrägstriche um.  Um einen gültigen **path** für das Scheme-*file* zu erzeugen, muss dem normalisierten Dateinamen „**/**“ vorangestellt werden, gefolgt von allen Zeichen, die nicht dem Klammerausdruck **regexp** entsprechen

```
    [a-zA-Z0-9$_.+!*'(,)?:@&=-]
```

muss durch prozentkodierte Kodierung dargestellt werden.

Das Ergebnis in diesem Beispiel lautet „**/C:/Other%20Files/startup.txt**“, was ein gültiger Wert für **path** ist.

```
% uri::join path /C:/Other%20Files/startup.txt scheme file

file:///C:/Other%20Files/startup.txt

% uri::split file:///C:/Other%20Files/startup.txt

path /C:/Other%20Files/startup.txt scheme file
```

Auf UNIX®-Systemen beginnen Dateinamen mit „**/**“, was gleichzeitig als Verzeichnisrennzeichen dient. Die einzige Maßnahme, die erforderlich ist, um einen Dateinamen in einen gültigen **path** umzuwandeln, ist die Prozent-Kodierung.

# DANKSAGUNGEN

Originalcode (reguläre Ausdrücke) von Andreas Kupries. Modularisierung durch Steve Ball, ebenso die Funktionen „split“, „join“ und „resolve“. Konformität mit RFC 3986 durch Keith Nash.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *uri* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk
