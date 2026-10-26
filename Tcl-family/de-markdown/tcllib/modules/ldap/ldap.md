---
CommandName: ldap
ManualSection: n
Version: 1.10.2
TclPart: tcllib
TclDescription: LDAP client
Keywords:
 - directory access
 - internet
 - ldap
 - ldap client
 - protocol
 - rfc 2251
 - rfc 4511
 - x.500
Copyright:
 - Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
 - Copyright (c) 2004 Jochen Loewer <loewerj@web.de>
 - Copyright (c) 2006 Michael Schlenker <mic42@users.sourceforge.net>
---

# NAME

ldap – LDAP-Client

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [ldap]{.lit} [1.10.2]{.optlit} 
[::ldap::connect]{.cmd} [host]{.arg} [port]{.optarg} 
[::ldap::tlsoptions]{.cmd} [reset]{.sub} 
[::ldap::tlsoptions]{.cmd} [opt1 val1]{.optarg} [opt2 val2]{.optarg} ... 
[::ldap::secure_connect]{.cmd} [host]{.arg} [port]{.optarg} 
[::ldap::secure_connect]{.cmd} [host]{.arg} [port]{.optarg} [verify_cert]{.optarg} [sni_servername]{.optarg} 
[::ldap::disconnect]{.cmd} [handle]{.arg} 
[::ldap::starttls]{.cmd} [handle]{.arg} 
[::ldap::starttls]{.cmd} [handle]{.arg} [cafile]{.optarg} [certfile]{.optarg} [keyfile]{.optarg} [verify_cert]{.optarg} [sni_servername]{.optarg} 
[::ldap::bind]{.cmd} [handle]{.arg} [name]{.optarg} [password]{.optarg} 
[::ldap::bindSASL]{.cmd} [handle]{.arg} [name]{.optarg} [password]{.optarg} 
[::ldap::unbind]{.cmd} [handle]{.arg} 
[::ldap::search]{.cmd} [handle]{.arg} [baseObject]{.arg} [filterString]{.arg} [attributes]{.arg} [options]{.arg} 
[::ldap::searchInit]{.cmd} [handle]{.arg} [baseObject]{.arg} [filterString]{.arg} [attributes]{.arg} [options]{.arg} 
[::ldap::searchNext]{.cmd} [handle]{.arg} 
[::ldap::searchEnd]{.cmd} [handle]{.arg} 
[::ldap::modify]{.cmd} [handle]{.arg} [dn]{.arg} [attrValToReplace]{.arg} [attrToDelete]{.optarg} [attrValToAdd]{.optarg} 
[::ldap::modifyMulti]{.cmd} [handle]{.arg} [dn]{.arg} [attrValToReplace]{.arg} [attrValToDelete]{.optarg} [attrValToAdd]{.optarg} 
[::ldap::add]{.cmd} [handle]{.arg} [dn]{.arg} [attrValueTuples]{.arg} 
[::ldap::addMulti]{.cmd} [handle]{.arg} [dn]{.arg} [attrValueTuples]{.arg} 
[::ldap::delete]{.cmd} [handle]{.arg} [dn]{.arg} 
[::ldap::modifyDN]{.cmd} [handle]{.arg} [dn]{.arg} [newrdn]{.arg} [deleteOld]{.optarg} [newSuperior]{.optarg} 
[::ldap::info]{.cmd} [ip]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [bound]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [bounduser]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [connections]{.sub} 
[::ldap::info]{.cmd} [tls]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [tlsstatus]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [saslmechanisms]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [control]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [extensions]{.sub} [extensions]{.arg} 
[::ldap::info]{.cmd} [whoami]{.sub} [handle]{.arg} 
:::

# BESCHREIBUNG

Das Paket **ldap** stellt eine ausschließlich auf Tcl basierende Client-Bibliothek für das LDAPv3-Protokoll bereit, wie es in RFC 4511 (*http://www.rfc-editor.org/rfc/rfc4511.txt*) festgelegt ist. Es funktioniert, indem es den Standard- (oder sicheren) LDAP-Socket auf dem Server öffnet und anschließend eine Tcl-API für den Zugriff auf die LDAP-Protokollbefehle bereitstellt. Alle Serverfehler werden als Tcl-Fehler zurückgegeben (ausgelöst), die mit dem Tcl-Befehl **catch** abgefangen werden müssen.

# TLS-SICHERHEITSHINWEISE

Dieses Paket nutzt das Paket **TLS**, um die Sicherheit für **LDAPS**-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie im folgenden Beispiel gezeigt.

```
    ldap::tlsoptions -tls1 1 -ssl2 0 -ssl3 0 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# BEFEHLE

**::ldap::connect** *host* ?*port*?
: Stellt eine LDAPv3-Verbindung zum angegebenen *host* am angegebenen *port* her und gibt ein Token für die Verbindung zurück. Dieses Token ist das Argument *handle* für alle anderen Befehle. Wird kein *port* angegeben, wird standardmäßig **389** verwendet. Der Befehl blockiert, bis die Verbindung hergestellt wurde oder der Verbindungsaufbau definitiv fehlgeschlagen ist.

**::ldap::tlsoptions** **reset**
: Dieser Befehl setzt die TLS-Optionen auf die Standardwerte zurück. Er gibt die Menge der Optionen zurück. Die Verwendung dieses Befehls ist nicht kompatibel mit der obsoleten Form von **::ldap::secure_connect** und **::ldap_starttls**.

**::ldap::tlsoptions** ?*opt1* *val1*? ?*opt2* *val2*? ...
: Dieser Befehl setzt eine oder mehrere Optionen auf einen Wert und kann mehrmals verwendet werden, um Optionen in mehreren Schritten hinzuzufügen. Eine vollständige Beschreibung der Optionen finden Sie in der Dokumentation zum Paket **tls**. Gültige Optionen und Werte sind:


**-cadir** directory
: Gibt das Verzeichnis mit den CA-Zertifikaten an. Kein Standardwert.

**-cafile** file
: Gibt die CA-Datei an. Kein Standardwert.

**-cipher** string
: Gibt die zu verwendenden Cipher-Suites an. Kein Standardwert.

**-dhparams** file
: Gibt eine Datei mit Diffie-Hellman-Parametern an. Kein Standardwert.

**-request** boolean
: Fordert während des SSL-Handshakes ein Zertifikat von der Gegenstelle an. Standard: true.

**-require** boolean
: Verlangt während des SSL-Handshakes ein gültiges Zertifikat von der Gegenstelle. Ist diese Option auf true gesetzt, muss auch -request auf true gesetzt sein. Standard: false

**-servername** host
: Nur verfügbar, wenn die OpenSSL-Bibliothek, gegen die das TLS-Paket gelinkt ist, die TLS-Hostnamen-Erweiterung für 'Server Name Indication' (SNI) unterstützt. Benennt den logischen Host, mit dem kommuniziert wird und für den ein Zertifikat erwartet wird. Kein Standardwert.

**-ssl2** bool
: Verwendung von SSL v2 aktivieren. Standard: false

**-ssl3** bool
: Verwendung von SSL v3 aktivieren. Standard: false

**-tls1** bool
: Verwendung von TLS v1 aktivieren. Standard: true

**-tls1.1** bool
: Verwendung von TLS v1.1 aktivieren. Standard: true

**-tls1.2** bool
: Verwendung von TLS v1.2 aktivieren. Standard: true


Dieser Befehl gibt die aktuell eingestellten TLS-Optionen und -Werte zurück. Insbesondere können Sie diesen Befehl ohne Argumente verwenden, um die aktuell eingestellten Optionen abzurufen.

Die Verwendung dieses Befehls ist nicht kompatibel mit der obsoleten Form von **::ldap::secure_connect** und **::ldap_starttls** (siehe unten).

**::ldap::secure_connect** *host* ?*port*?
: Ähnlich wie **::ldap::connect**, mit dem Unterschied, dass die hergestellte Verbindung durch SSL gesichert ist. Der Port ist standardmäßig **636**.  Dieser Befehl setzt die Verfügbarkeit des Pakets **TLS** voraus, einer SSL-Anbindung für Tcl. Ist **TLS** nicht verfügbar, schlägt dieser Befehl fehl. TLS-Optionen werden mit **::ldap::tlsoptions** festgelegt. Der Befehl blockiert, bis die Verbindung hergestellt wurde oder der Verbindungsaufbau definitiv fehlgeschlagen ist.

**::ldap::secure_connect** *host* ?*port*? ?*verify_cert*? ?*sni_servername*?
: Hinweis: Diese Form des Befehls ist veraltet, da TLS-Optionen mit einer Kombination aus Parametern dieses Befehls (*verify_cert* und *sni_servername*) und Argumenten für **::tls::init** (aus dem Paket **tls**) festgelegt werden mussten, etwa um Standardwerte für vertrauenswürdige Zertifikate festzulegen. Verwenden Sie vorzugsweise die oben genannte Form (ohne die Parameter *verify_cert* und *sni_servername*) und legen Sie die TLS-Optionen mit **::ldap::tlsoptions** fest. Wenn *verify_cert* auf 1 gesetzt ist (Standardeinstellung), wird das Serverzertifikat anhand der bekannten Hosts überprüft. Wenn *sni_servername* gesetzt ist, wird der angegebene Hostname als Hostname für die Server Name Indication im TLS-Handshake verwendet. Verwenden Sie **::tls::init**, um Standardwerte für vertrauenswürdige Zertifikate festzulegen. TLS unterstützt verschiedene Protokollstufen. Gängig sind die Versionen 1.0, 1.1 und 1.2. Standardmäßig werden alle diese Versionen angeboten. Wenn Sie die zulässigen Protokolle anpassen müssen, können Sie die Liste ::ldap::tlsProtocols ändern (veraltet).

**::ldap::disconnect** *handle*
: Schließt die LDAP-Verbindung, auf die sich das Token *handle* bezieht. Gibt als Ergebnis die leere Zeichenkette zurück.

**::ldap::starttls** *handle*
: Startet die TLS-Aushandlung für die durch *handle* bezeichnete Verbindung, mit den TLS-Parametern, die mit **::ldap::tlsoptions** festgelegt wurden.

**::ldap::starttls** *handle* ?*cafile*? ?*certfile*? ?*keyfile*? ?*verify_cert*? ?*sni_servername*?
: Hinweis: Diese Form des Befehls ist veraltet, da TLS-Optionen mit einer Kombination aus Parametern dieses Befehls (*cafile*, *certfile*, *keyfile*, *verify_cert* und *sni_servername*) und Argumenten für **::tls::init** (aus dem Paket **tls**) festgelegt werden mussten. Verwenden Sie vorzugsweise die oben genannte Form (ohne spezifische TLS-Argumente) und legen Sie die TLS-Optionen mit **::ldap::tlsoptions** fest. Startet die TLS-Aushandlung für die durch *handle* bezeichnete Verbindung. Sie müssen mindestens das Argument *cafile* auf eine Datei mit vertrauenswürdigen Zertifikaten setzen, wenn *verify_cert* den Wert 1 hat, was der Standard ist. Mit *sni_servername* kann während des TLS-Handshakes ein anderer Hostname signalisiert werden. Die angekündigten Protokolle werden auf dieselbe Weise wie bei **::ldap::secure_connect** festgelegt. Sie können ein TLS-Client-Zertifikat mit den Optionen *certfile* und *keyfile* angeben.

**::ldap::bind** *handle* ?*name*? ?*password*?
: Dieser Befehl authentifiziert die LDAP-Verbindung, auf die das Token in *handle* verweist, mit einem Benutzernamen und dem zugehörigen Passwort. Er blockiert, bis eine Antwort vom LDAP-Server eintrifft. Das Ergebnis ist die leere Zeichenkette. Sowohl *name* als auch *passwd* sind standardmäßig die leere Zeichenkette, wenn sie nicht angegeben werden. Indem Sie *name* und *passwd* weglassen, können Sie einen anonymen bind beim LDAP-Server durchführen. Sie können **::ldap::bind** erneut aufrufen, um sich mit anderen Anmeldedaten anzumelden.

**::ldap::bindSASL** *handle* ?*name*? ?*password*?
: Dieser Befehl nutzt SASL-Authentifizierungsmechanismen, um einen mehrstufigen bind durchzuführen. Ansonsten entspricht er dem normalen **::ldap::bind**. Diese Funktion ist derzeit experimentell und kann sich ändern. Einzelheiten zur Einrichtung und Verwendung von SASL mit OpenLDAP finden Sie in der Dokumentation zu **SASL** sowie in der Datei "*SASL.txt*" im tcllib-CVS-Repository.

**::ldap::unbind** *handle*
: Dieser Befehl bittet den LDAP-Server, den letzten bind für die Verbindung freizugeben, auf die sich das Token in *handle* bezieht. Das *handle* ist nach dem unbind ungültig, da der Server die Verbindung schließt. Im Grunde ist dies also nur eine höflichere Form von disconnect.

**::ldap::search** *handle* *baseObject* *filterString* *attributes* *options*
: Dieser Befehl führt unterhalb des *baseObject*-Baums eine LDAP-Suche mit einem komplexen LDAP-Suchausdruck *filterString* durch und gibt die angegebenen *attributes* aller passenden Objekte (DNs) zurück. Ist die Liste *attributes* leer, werden alle Attribute zurückgegeben. Der Befehl blockiert, bis er alle Ergebnisse empfangen hat. Die gültigen *options* entsprechen den für **::ldap::searchInit** aufgeführten Optionen. Ein Beispiel für einen Suchausdruck lautet


```
    set filterString "|(cn=Linus*)(sn=Torvalds*)"
```

Der Rückgabewert des Befehls ist eine Liste verschachtelter Dictionaries. Die Schlüssel der ersten Ebene sind Objektbezeichner (DNs), die der zweiten Ebene Attributnamen. Mit anderen Worten, er hat folgende Form:

```
    {dn1 {attr1 {val11 val12 ...} attr2 {val21...} ...}} {dn2 {a1 {v11 ...} ...}} ...
```

**::ldap::searchInit** *handle* *baseObject* *filterString* *attributes* *options*
: Dieser Befehl leitet eine LDAP-Suche unterhalb des *baseObject*-Baums mit einem komplexen LDAP-Suchausdruck *filterString* ein. Die Suche holt die angegebenen *attributes* aller passenden Objekte (DNs). Der Befehl selbst startet lediglich die Suche; um die eigentlichen Ergebnisse abzurufen, verwenden Sie **::ldap::searchNext**. Eine Suche kann jederzeit mit **::ldap::searchEnd** abgebrochen werden. Dadurch wird dem Server durch das Senden einer ABANDON-Nachricht mitgeteilt, dass keine weiteren Ergebnisse gesendet werden sollen, und der interne Zustand der Suche wird bereinigt. Es kann zu einem bestimmten Zeitpunkt nur ein **::ldap::search** aktiv sein; dies schließt die Introspektionsbefehle **::ldap::info saslmechanisms**, **ldap::info control** und **ldap::info extensions** ein, die intern eine Suche ausführen. Fehlerantworten des Servers aufgrund falscher Argumente oder ähnlicher Ursachen werden mit dem ersten Aufruf von **::ldap::searchNext** zurückgegeben und sollten dort geprüft und behandelt werden. Ist die Liste der angeforderten *attributes* leer, werden alle Attribute zurückgegeben. Der Parameter *options* legt die bei der Suche zu verwendenden Optionen fest und hat das folgende Format:


```
    {-option1 value1 -option2 value2 ... }
```

Folgende Optionen stehen zur Verfügung:

**-scope** base one sub
: Legt den Suchbereich auf **base**, **one** oder **sub** fest, für eine Suche nur im Basisobjekt, auf einer Ebene oder im ganzen Teilbaum.   Standard ist **sub**.

**-derefaliases** never search find always
: Legt fest, wie Aliase dereferenziert werden.  Der Wert sollte **never**, **always**, **search** oder **find** sein, um festzulegen, dass Aliase nie dereferenziert werden, immer, beim Suchen, oder nur beim Auffinden des Basisobjekts der Suche. Standardmäßig werden Aliase nie dereferenziert.

**-sizelimit** num
: Legt die maximale Anzahl der bei einer Suche zurückzugebenden Einträge fest. Wenn 0 angegeben wird, wird keine Begrenzung angewendet. Der Server kann eine konfigurationsabhängige Größenbeschränkung erzwingen, die unter dem mit dieser Option angegebenen Wert liegen kann. Der Standardwert ist 0, d. h. keine Begrenzung.

**-timelimit** seconds
: Bittet den Server, für die Suche ein Zeitlimit von *seconds* Sekunden zu verwenden. Der Wert Null bedeutet, dass kein Limit gilt. Der Standardwert ist 0, d. h. kein Limit.

**-attrsonly** boolean
: Ist der Wert 1, enthält das Suchergebnis nur die Attributnamen, nicht die Werte. Standardmäßig werden sowohl Attributnamen als auch Werte abgerufen.

**-referencevar** varname
: Ist diese Option gesetzt, werden die LDAP-URIs der Suchergebnis-Verweise (search result references), sofern vorhanden, in der angegebenen Variable zurückgegeben. Der Aufrufer kann dann entscheiden, diesen Verweisen zu folgen und weitere LDAP-Server nach zusätzlichen Ergebnissen abzufragen.


**::ldap::searchNext** *handle*
: Dieser Befehl gibt den nächsten Eintrag aus einer von **::ldap::searchInit** initiierten LDAP-Suche zurück. Er kehrt erst zurück, wenn ein neues Ergebnis empfangen wurde oder keine weiteren Ergebnisse mehr verfügbar sind, sorgt jedoch dafür, dass die Ereignisschleife aktiv bleibt. Der zurückgegebene Eintrag ist eine Liste mit zwei Elementen: Das erste ist der DN des Eintrags, das zweite ist die Liste der Attribute und Werte im folgenden Format:


```
    dn {attr1 {val11 val12 ...} attr2 {val21...} ...}
```

Der Befehl **::ldap::searchNext** gibt am Ende der Suche eine leere Liste zurück.

**::ldap::searchEnd** *handle*
: Dieser Befehl beendet eine von **::ldap::searchInit** initiierte LDAP-Suche. Zudem wird der interne Zustand bereinigt, sodass eine neue Suche gestartet werden kann. Wenn der Client noch nicht alle Ergebnisse erhalten hat, sendet er eine ABANDON-Nachricht, um dem Server mitzuteilen, dass keine weiteren Ergebnisse für die vorherige Suche gesendet werden sollen.

**::ldap::modify** *handle* *dn* *attrValToReplace* ?*attrToDelete*? ?*attrValToAdd*?
: Dieser Befehl ändert das Objekt *dn* auf dem LDAP-Server, mit dem wir über *handle* verbunden sind. Er ersetzt Attribute durch neue Werte, löscht Attribute und fügt neue Attribute mit neuen Werten hinzu. Alle Argumente sind Dictionaries, die Attributnamen auf Werte abbilden. Die optionalen Argumente sind standardmäßig das leere Dictionary, was bedeutet, dass weder Attribute gelöscht noch hinzugefügt werden.


dictionary *attrValToReplace* (in)
: Wenn dieses Argument leer ist, werden keine Attribute geändert. Das Dictionary enthält die neuen Attribute und deren Werte. Diese *ersetzen alle* dem Objekt bekannten Attribute.

dictionary *attrToDelete* (in)
: Wenn dieses Argument leer ist, werden keine Attribute gelöscht. Die Dictionary-Werte stellen Einschränkungen für die Löschung dar. Ein hier aufgeführtes Attribut wird genau dann gelöscht, wenn sein aktueller Wert auf dem Server mit dem im Dictionary angegebenen Wert übereinstimmt oder wenn der Wert im Dictionary die leere Zeichenkette ist.

dictionary *attrValToAdd* (in)
: Wenn dieses Argument leer ist, werden keine Attribute hinzugefügt. Die Dictionary-Werte sind die Werte für die neuen Attribute.


Der Befehl blockiert, bis alle Änderungen abgeschlossen sind. Das Ergebnis ist die leere Zeichenkette.

**::ldap::modifyMulti** *handle* *dn* *attrValToReplace* ?*attrValToDelete*? ?*attrValToAdd*?
: Dieser Befehl ändert das Objekt *dn* auf dem LDAP-Server, mit dem wir über *handle* verbunden sind. Er ersetzt Attribute durch neue Werte, löscht Attribute und fügt neue Attribute mit neuen Werten hinzu. Alle Argumente sind Listen im folgenden Format:


```
    attr1 {val11 val12 ...} attr2 {val21...} ...
```

wobei jede Werteliste leer sein kann, um alle Attribute zu löschen. Die optionalen Argumente sind standardmäßig leere Listen der zu löschenden und hinzuzufügenden Attribute.

list *attrValToReplace* (in)
: Wenn dieses Argument leer ist, werden keine Attribute geändert. Das Dictionary enthält die neuen Attribute und deren Werte. Diese *ersetzen alle* dem Objekt bekannten Attribute.

list *attrValToDelete* (in)
: Wenn dieses Argument leer ist, werden keine Attribute gelöscht. Wird kein Wert angegeben, wird die gesamte Wertemenge eines Attributs gelöscht.

list *attrValToAdd* (in)
: Wenn dieses Argument leer ist, werden keine Attribute hinzugefügt.


Der Befehl blockiert, bis alle Änderungen abgeschlossen sind. Das Ergebnis ist die leere Zeichenkette.

**::ldap::add** *handle* *dn* *attrValueTuples*
: Dieser Befehl erstellt ein neues Objekt unter Verwendung des angegebenen *dn*. Die Attribute des neuen Objekts werden auf die Werte in der Liste *attrValueTuples* gesetzt. Mehrwertige Attribute können mit mehreren Tupeln angegeben werden. Der Befehl blockiert, bis der Vorgang abgeschlossen ist. Das Ergebnis ist die leere Zeichenkette.

**::ldap::addMulti** *handle* *dn* *attrValueTuples*
: Dieser Befehl ist der bevorzugte, um ein neues Objekt mit dem angegebenen *dn* zu erstellen. Die Attribute des neuen Objekts werden auf die Werte im Dictionary *attrValueTuples* gesetzt (dessen Schlüssel die Attributnamen sind). Jedes Tupel ist eine Liste mit mehreren Werten. Der Befehl blockiert, bis der Vorgang abgeschlossen ist. Das Ergebnis ist die leere Zeichenkette.

**::ldap::delete** *handle* *dn*
: Dieser Befehl entfernt das durch *dn* festgelegte Objekt sowie alle seine Attribute vom Server. Der Befehl blockiert, bis der Vorgang abgeschlossen ist. Das Ergebnis ist die leere Zeichenkette.

**::ldap::modifyDN** *handle* *dn* *newrdn* ?*deleteOld*? ?*newSuperior*?
: Dieser Befehl verschiebt oder kopiert das durch *dn* angegebene Objekt an eine neue Stelle im Objektbaum. Diese Stelle wird durch *newrdn*, eine *relative* Angabe, oder durch *newrdn* und *newSuperior*, eine *absolute* Angabe, festgelegt. Das optionale Argument *deleteOld* ist standardmäßig **true**, d. h. es handelt sich um ein Verschieben. Ist *deleteOld* nicht gesetzt, erstellt die Operation eine Kopie von *dn* an der neuen Stelle. Das optionale Argument *newSuperior* ist standardmäßig eine leere Zeichenkette, was bedeutet, dass das Objekt nicht in einen anderen Zweig des Baums verschoben werden darf. Wird dieses Argument angegeben, muss auch das Argument *deleteOld* angegeben werden. Der Befehl blockiert, bis der Vorgang abgeschlossen ist. Das Ergebnis ist die leere Zeichenkette.

**::ldap::info** **ip** *handle*
: Dieser Befehl gibt die IP-Adresse des entfernten LDAP-Servers zurück, mit dem das Handle verbunden ist.

**::ldap::info** **bound** *handle*
: Dieser Befehl gibt den Wert 1 zurück, wenn ein Handle erfolgreich ein **::ldap::bind** abgeschlossen hat. Wurde kein bind durchgeführt oder ist er fehlgeschlagen, wird der Wert 0 zurückgegeben.

**::ldap::info** **bounduser** *handle*
: Dieser Befehl gibt den Benutzernamen zurück, der bei der bind-Operation verwendet wurde, sofern ein Handle erfolgreich ein **::ldap::bind** abgeschlossen hat. Wurde kein bind durchgeführt oder ist dieser fehlgeschlagen, wird eine leere Zeichenkette zurückgegeben.

**::ldap::info** **connections**
: Dieser Befehl gibt alle derzeit vorhandenen LDAP-Verbindungs-Handles zurück.

**::ldap::info** **tls** *handle*
: Dieser Befehl gibt den Wert 1 zurück, wenn die LDAP-Verbindung *handle* TLS/SSL über **ldap::secure_connect** verwendet oder **ldap::starttls** abgeschlossen hat, sonst 0.

**::ldap::info** **tlsstatus** *handle*
: Dieser Befehl gibt den aktuellen Sicherheitsstatus eines TLS-gesicherten Kanals zurück. Das Ergebnis ist eine Liste von Schlüssel-Wert-Paaren, die die verbundene Gegenstelle beschreiben (Informationen zu den zurückgegebenen Werten finden Sie in der Dokumentation zum Paket **TLS**). Wenn die Verbindung nicht mit TLS gesichert ist, wird eine leere Liste zurückgegeben.

**::ldap::info** **saslmechanisms** *handle*
: Gibt die vom Server angekündigten, unterstützten SASL-Mechanismen zurück. Nur gültig nach einem bind (anonym oder nicht).

**::ldap::info** **control** *handle*
: Gibt die vom Server angekündigten, unterstützten Controls als Liste von OIDs zurück. Nur gültig nach einem bind. Dies ist derzeit experimentell und kann sich ändern.

**::ldap::info** **extensions** *extensions*
: Gibt die unterstützten LDAP-Erweiterungen als Liste von OIDs zurück. Nur gültig nach einem bind. Dies ist derzeit experimentell und kann sich ändern.

**::ldap::info** **whoami** *handle*
: Gibt die authzId für die aktuelle Verbindung zurück. Hiermit wird die Protokollerweiterung gemäß RFC 4532 implementiert.


# BEISPIELE

Ein kleines Beispiel, das aus der mit diesem Code gelieferten Testanwendung entnommen wurde.

```
    package require ldap

    # Connect, bind, add a new object, modify it in various ways

    set handle [ldap::connect localhost 9009]

    set dn "cn=Manager, o=University of Michigan, c=US"
    set pw secret

    ldap::bind $handle $dn $pw

    set dn "cn=Test User,ou=People,o=University of Michigan,c=US"

    ldap::add $handle $dn {
	objectClass     OpenLDAPperson
	cn              {Test User}
	mail            test.user@google.com
	uid             testuid
	sn              User
	telephoneNumber +31415926535
	telephoneNumber +27182818285
    }

    set dn "cn=Another User,ou=People,o=University of Michigan,c=US"

    ldap::addMulti $handle $dn {
	objectClass     {OpenLDAPperson}
	cn              {{Anotther User}}
	mail            {test.user@google.com}
	uid             {testuid}
	sn              {User}
	telephoneNumber {+31415926535 +27182818285}
    }

    # Replace all attributes
    ldap::modify $handle $dn [list drink icetea uid JOLO]

    # Add some more
    ldap::modify $handle $dn {} {} [list drink water  drink orangeJuice pager "+1 313 555 7671"]

    # Delete
    ldap::modify $handle $dn {} [list drink water  pager ""]

    # Move
    ldap::modifyDN $handle $dn "cn=Tester"

    # Kill the test object, and shut the connection down.
    set dn "cn=Tester,ou=People,o=University of Michigan,c=US"
    ldap::delete $handle $dn

    ldap::unbind     $handle
    ldap::disconnect $handle
```

Und noch ein Beispiel: eine einfache Abfrage und die Verarbeitung der Ergebnisse.

```
    package require ldap
    set handle [ldap::connect ldap.acme.com 389]
    ldap::bind $handle
    set results [ldap::search $handle "o=acme,dc=com" "(uid=jdoe)" {}]
    foreach result $results {
	foreach {object attributes} $result break

	# The processing here is similar to what 'parray' does.
	# I.e. finding the longest attribute name and then
	# generating properly aligned output listing all attributes
	# and their values.

	set width 0
	set sortedAttribs {}
	foreach {type values} $attributes {
	    if {[string length $type] > $width} {
		set width [string length $type]
	    }
	    lappend sortedAttribs [list $type $values]
	}

	puts "object='$object'"

	foreach sortedAttrib  $sortedAttribs {
	    foreach {type values} $sortedAttrib break
	    foreach value $values {
		regsub -all "\[\x01-\x1f\]" $value ? value
		puts [format "  %-${width}s %s" $type $value]
	    }
	}
	puts ""
    }
    ldap::unbind $handle
    ldap::disconnect $handle
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *ldap* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2004 Jochen Loewer <loewerj@web.de>
Copyright (c) 2006 Michael Schlenker <mic42@users.sourceforge.net>
```
