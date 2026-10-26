---
CommandName: SASL
title: SASL
ManualSection: n
Version: 1.3.4
TclPart: tcllib
TclDescription: Simple Authentication and Security Layer (SASL)
Keywords:
 - SASL
 - authentication
Copyright:
 - Copyright (c) 2005-2006, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

SASL – Implementierung von SASL-Mechanismen für Tcl

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [SASL]{.lit} [1.3.4]{.optlit}
[::SASL::new]{.cmd} [option]{.arg} [value]{.arg} ?...?
[::SASL::configure]{.cmd} [option]{.arg} [value]{.arg} [...]{.optarg}
[::SASL::step]{.cmd} [context]{.arg} [challenge]{.arg} [...]{.optarg}
[::SASL::response]{.cmd} [context]{.arg}
[::SASL::reset]{.cmd} [context]{.arg}
[::SASL::cleanup]{.cmd} [context]{.arg}
[::SASL::mechanisms]{.cmd} [type]{.optarg} [minimum]{.optarg}
[::SASL::register]{.cmd} [mechanism]{.arg} [preference]{.arg} [clientproc]{.arg} [serverproc]{.optarg}
:::

# Beschreibung

Das Simple Authentication and Security Layer (SASL) ist ein Rahmen zur Bereitstellung von Authentifizierung und Autorisierung für Kommunikationsprotokolle. Der SASL-Rahmen ist so aufgebaut, dass er die Aushandlung zwischen verschiedenen Authentifizierungsmechanismen ermöglicht. SASL kann bei der SMTP-, IMAP- und HTTP-Authentifizierung eingesetzt werden. Es wird zudem in XMPP, LDAP und BEEP verwendet. Unter [Mechanismen] finden Sie eine Übersicht über die mit tcllib bereitgestellten SASL-Mechanismen.

Der SASL-Rahmen arbeitet mit einem einfachen, mehrstufigen Challenge-Response-Mechanismus. Alle Mechanismen funktionieren auf dieselbe Weise, auch wenn die Anzahl der Schritte variieren kann. In dieser Implementierung muss eine Rückruffunktion bereitgestellt werden, über die der SASL-Rahmen die Benutzerdaten abruft. Einzelheiten zu dieser Prozedur finden Sie unter [Callback-Prozedur].

# Befehle

**::SASL::new** *option value ?...?*
: Erstellt einen neuen SASL-Kontext. Einzelheiten zu den möglichen Optionen dieses Befehls finden Sie unter [Optionen]. Für die meisten SASL-Prozeduren ist ein Kontext-Token erforderlich.

**::SASL::configure** *option value* ?*...*?
: Liest oder setzt eine Option des SASL-Kontexts. Weitere Einzelheiten finden Sie unter [Optionen].

**::SASL::step** *context* *challenge* ?*...*?
: Dies ist die Kern-Prozedur für die Verwendung des SASL-Rahmens. Die Prozedur **step** sollte so lange aufgerufen werden, bis sie den Wert 0 gibt. Jeder Schritt nimmt eine Server-Challenge-Zeichenkette entgegen, die Antwort wird berechnet und im Kontext gespeichert. Jeder Mechanismus kann einen oder mehrere Schritte erfordern. Bei einigen Schritten ist möglicherweise keine Server-Challenge erforderlich; in diesem Fall sollte für diesen Parameter eine leere Zeichenfolge angegeben werden. Alle Mechanismen sollten eine anfänglich leere Challenge akzeptieren.

**::SASL::response** *context*
: Gibt die nächste Antwortzeichenfolge zurück, die an den Server gesendet werden soll.

**::SASL::reset** *context*
: Initialisiert den SASL-Kontext neu. Dabei werden alle internen Zustände verworfen, und das Token kann wiederverwendet werden.

**::SASL::cleanup** *context*
: Gibt alle mit dem SASL-Kontext verbundenen Ressourcen frei. Das Kontext-Token darf nach dem Aufruf dieser Prozedur nicht mehr verwendet werden.

**::SASL::mechanisms** ?*type*? ?*minimum*?
: Gibt eine Liste aller verfügbaren SASL-Mechanismen zurück. Die Liste ist nach dem Wert der Präferenz des Mechanismus sortiert (siehe **register**), wobei die bevorzugten Mechanismen am Anfang der Liste stehen. Jeder Mechanismus mit einem Wert für die Präferenz unterhalb des *Mindestwerts* (der standardmäßig auf 0 gesetzt ist) wird aus der zurückgegebenen Liste entfernt. Dies ermöglicht die Festlegung einer Schwelle für die Sicherheit. Mechanismen mit einer Präferenz unter 25, die eine Authentifizierung übertragen, sind besonders anfällig für Abhörversuche und sollten nur bereitgestellt werden, wenn ein sicherer Kanal verwendet wird (z. B. TLS).

    Der Parameter *type* kann entweder *client* oder *server* lauten und ist standardmäßig auf *client* gesetzt. Es werden nur Mechanismen zurückgegeben, deren Implementierung mit dem *type* übereinstimmt (dadurch können Server korrekt nur die Unterstützung für Mechanismen deklarieren, für die tatsächlich eine Server-Implementierung vorliegt).

**::SASL::register** *mechanism* *preference* *clientproc* ?*serverproc*?
: Neue Mechanismen können dem Paket hinzugefügt werden, indem der Mechanismenname und die entsprechenden Implementierungsprozeduren registriert werden. Die Serverprozedur ist optional. Der Präferenzwert ist eine ganze Zahl, die zur Sortierung der vom Befehl **mechanisms** gegebenen Liste verwendet wird. Höhere Werte kennzeichnen einen bevorzugten Mechanismus. Wenn der Mechanismus bereits registriert ist, werden die gespeicherten Werte aktualisiert.


# Optionen

**-callback**
: Legt einen Befehl fest, der ausgewertet werden soll, wenn der SASL-Mechanismus Informationen über den Benutzer benötigt. Der Befehl wird mit dem aktuellen SASL-Kontext und einem Namen aufgerufen, der die gewünschten Informationen angibt. Siehe [Beispiele].

**-mechanism**
: Legt den zu verwendenden SASL-Mechanismus fest. Eine Liste der unterstützten Authentifizierungsmechanismen finden Sie unter **mechanisms**.

**-service**
: Legt den Diensttyp für diesen Kontext fest. Einige Mechanismen nutzen diesen Parameter möglicherweise (z. B. DIGEST-MD5, GSSAPI und Kerberos). Wenn dieser Parameter nicht festgelegt wird, wird standardmäßig eine leere Zeichenkette verwendet. Wenn der Parameter **-type** auf „server“ gesetzt ist, sollte diese Option auf eine gültige Dienstidentität gesetzt werden. Beispiele für gültige Dienstnamen sind smtp, ldap, beep und xmpp.

**-server**
: Diese Option dient dazu, den Namen des Servers festzulegen, der bei SASL-Anfragen verwendet wird, wenn das System als SASL-Server fungiert.

**-type**
: Der Kontexttyp kann entweder „client“ oder „server“ lauten. Standardmäßig wird die Anwendung als Client ausgeführt und reagiert auf Herausforderungen des Servers. Es können Mechanismen zur Unterstützung von serverseitigem SASL programmiert werden; durch Setzen dieser Option wird bei jedem **step** die nächste Herausforderung ausgegeben. Im Servermodus muss für jede eingehende Client-Verbindung ein neuer Kontext erstellt werden.


# Callback-Prozedur

Wenn das SASL-Framework Benutzerdaten benötigt, ruft es die bei der Erstellung des Kontexts bereitgestellte Prozedur mit einem Argument auf, das die jeweils benötigte Information angibt.

In allen Fällen sollte eine einzige Antwortzeichenfolge gegeben werden.

login
: Die Callback-Prozedur sollte die Autorisierungsidentität des Benutzers geben. Geben Sie eine leere Zeichenkette zurück, sofern diese nicht von der Authentifizierungsidentität abweicht. Lesen Sie [1], um mehr über die spezifische Bedeutung von Autorisierungs- und Authentifizierungsidentitäten innerhalb von SASL zu erfahren.

username
: Die Callback-Prozedur sollte die Authentifizierungsidentität des Benutzers geben. Eine Erläuterung der genauen Bedeutung von Autorisierungs- und Authentifizierungsidentitäten im Rahmen von SASL finden Sie unter \[1\].

password
: Die Callback-Prozedur sollte das Passwort geben, das mit der Authentifizierungsidentität übereinstimmt, wie sie innerhalb des aktuellen Realms verwendet wird.

    Bei Servermechanismen sollte der Passwort-Callback stets mit der Authentifizierungsidentität und dem Realm als ersten beiden Parametern aufgerufen werden.

realm
: Einige SASL-Mechanismen verwenden Realms zur Unterteilung von Authentifizierungsidentitäten. Die Realm-Zeichenkette ist protokollabhängig und entspricht häufig der aktuellen DNS-Domäne oder – im Falle des NTLM-Mechanismus – dem Windows NT-Domänennamen.

hostname
: Gibt den Hostnamen des Clients zurück – in der Regel \[info host\].


# Mechanismen

ANONYMOUS
: Bei der Verwendung im Rahmen von FTP übermittelt dieser Mechanismus lediglich eine E-Mail-Adresse zur Authentifizierung. Der ANONYMOUS-Mechanismus wird in \[2\] festgelegt.

PLAIN
: Dies ist der einfachste Mechanismus. Die Anmeldedaten der Benutzer werden im Klartext übertragen. Dieser Mechanismus sollte nur dann bereitgestellt werden, wenn eine verschlüsselte Verbindung besteht – in der Regel nachdem SSL oder TLS ausgehandelt wurde.

LOGIN
: Der LOGIN-Mechanismus \[1\] übermittelt die Benutzerdaten in Base64-Kodierung. Dies ist nicht sicherer als PLAIN und sollte daher ebenfalls nicht ohne eine sichere Verbindung verwendet werden.

CRAM-MD5
: Dieser Mechanismus verhindert, dass das Passwort des Benutzers im Klartext über das Netzwerk übertragen wird, indem das Passwort mit einem vom Server bereitgestellten Zufallswert (einem sogenannten „Nonce“) gehasht wird. Ein Nachteil dieses Mechanismus besteht darin, dass der Server eine Datenbank mit Passwörtern im Klartext zum Vergleich führen muss. CRAM-MD5 wurde in [4] definiert.

DIGEST-MD5
: Dieser Mechanismus stellt eine Verbesserung gegenüber dem CRAM-MD5-Mechanismus dar, da der Server keine Passwörter im Klartext speichern muss. Bei der Digest-Authentifizierung muss der Server den MD5-Digest des Benutzerpassworts speichern, was zur Erhöhung der Sicherheit des Systems beiträgt. Wie bei CRAM-MD5 wird das Passwort zusammen mit einem Server-Nonce und weiteren Daten gehasht, bevor es über das Netzwerk übertragen wird. Spezifiziert in \[3\].

OTP
: OTP ist das in RFC 2289 \[6\] beschriebene Einmalpasswort-System. Dieser Mechanismus bietet Sicherheit gegen Replay-Angriffe und verhindert zudem, dass Passwörter oder Passwortäquivalente auf dem Server gespeichert werden. Über das Netzwerk wird lediglich ein Digest aus einem Seed und einer Passphrase übertragen. Erforderlich sind das Paket **otp** aus tcllib sowie eines oder mehrere der kryptografischen Digest-Pakete (md5 oder sha-1 werden am häufigsten verwendet).

NTLM
: Es handelt sich hierbei um ein von Microsoft entwickeltes proprietäres Protokoll [5], das häufig zur Authentifizierung von Benutzern in einer Windows-Netzwerkumgebung verwendet wird. NTLM nutzt DES-Verschlüsselung und MD4-Hashwerte des Benutzerpassworts, um eine Verbindung zu authentifizieren. Da bei NTLM gewisse Schwachstellen festgestellt wurden, gibt es eine Reihe von Versionen des Protokolls. Da dieser Mechanismus zusätzliche Abhängigkeiten aufweist, wird er als separates Unterpaket bereitgestellt. Um diesen Mechanismus zu aktivieren, muss Ihre Anwendung das Paket [SASL::NTLM][ntlm] laden.

X-GOOGLE-TOKEN
: Hierbei handelt es sich um ein von Google entwickeltes proprietäres Protokoll, das zur Authentifizierung von Nutzern für den Google Talk-Dienst verwendet wird. Dieser Mechanismus führt zwei HTTP-Anfragen über einen SSL-Kanal durch und ist daher von der Verfügbarkeit der Pakete „tls“ und „http“ abhängig. Um diesen Mechanismus zu aktivieren, muss Ihre Anwendung das Paket „[SASL::XGoogleToken][gtoken]“ laden. Darüber hinaus wird empfohlen, das „autoproxy“-Paket zu verwenden, um HTTP-Proxys weitgehend mit hoher Transparenz zu handhaben.

SCRAM
: Hierbei handelt es sich um ein in RFC 5802 \[7\] festgelegtes Protokoll. Um diesen Mechanismus zu aktivieren, muss Ihre Anwendung das Paket [SASL::SCRAM][scram] laden.


# Beispiele

Im Unterverzeichnis „examples“ finden Sie ausführlichere Beispiele für die Verwendung von SASL mit Netzwerkprotokollen. Die folgenden Beispiele sollen Ihnen einen Eindruck davon vermitteln, wie die SASL-Befehle verwendet werden. In der Praxis sollte dies ereignisgesteuert erfolgen. Bei jedem Aufruf des Befehls **step** sollte die letzte Serverantwort als Argument des Befehls übergeben werden, damit der SASL-Mechanismus entsprechende Maßnahmen ergreifen kann.

```
proc ClientCallback {context command args} {
    switch -exact -- $command {
        login    { return "" }
        username { return $::tcl_platform(user) }
        password { return "SecRet" }
        realm    { return "" }
        hostname { return [info host] }
        default  { return -code error unxpected }
    }
}

proc Demo {{mech PLAIN}} {
    set ctx [SASL::new -mechanism $mech -callback ClientCallback]
    set challenge ""
    while {1} {
        set more_steps [SASL::step $ctx challenge]
        puts "Send '[SASL::response $ctx]'"
        puts "Read server response into challenge var"
        if {!$more_steps} {break}
    }
    SASL::cleanup $ctx
}
```

# Literatur

1. Myers, J. „Simple Authentication and Security Layer (SASL)“, RFC 2222, Oktober 1997. (<http://www.ietf.org/rfc/rfc2222.txt>)

2. Newman, C. „Anonymous SASL Mechanism“, RFC 2245, November 1997. (<http://www.ietf.org/rfc/rfc2245.txt>)

3. Leach, P., Newman, C. „Using Digest Authentication as a SASL Mechanism“, RFC 2831, Mai 2000, (<http://www.ietf.org/rfc/rfc2831.txt>)

4. Klensin, J., Catoe, R. und Krumviede, P., „IMAP/POP AUTHorize-Erweiterung für Simple Challenge/Response“ RFC 2195, September 1997. (<http://www.ietf.org/rfc/rfc2195.txt>)

5. Es liegt keine offizielle Spezifikation vor. Eine gute Beschreibung finden Sie jedoch unter <http://davenport.sourceforge.net/ntlm.html>.

6. Haller, N. et al., „A One-Time Password System“, RFC 2289, Februar 1998, (<http://www.ieft.org/rfc/rfc2289.txt>)

7. Newman, C. et al., „Salted Challenge Response Authentication Mechanism (SCRAM) – SASL- und GSS-API-Mechanismen“, RFC 5802, Juli 2010, (<http://www.ieft.org/rfc/rfc5802.txt>)


# Autoren

Pat Thoyts

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *sasl* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk

# Copyright

```
Copyright (c) 2005-2006, Pat Thoyts <patthoyts@users.sourceforge.net>
```


[gtoken]: gtoken.md
[ntlm]: ntlm.md
[scram]: scram.md
