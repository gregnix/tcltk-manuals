---
CommandName: cookiejar
title: cookiejar
ManualSection: n
Version: 0.1
TclPart: http
TclDescription: Tcl Bundled Packages
Links:
 - http(n)
 - oo::class(n)
 - sqlite3(n)
Keywords:
 - cookie
 - internet
 - security policy
 - www
Copyright:
 - Copyright (c) 2014-2018 Donal K. Fellows.
---

# Name

cookiejar - Implementierung des Cookie-Jar-Protokolls des Tcl-http-Pakets

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [cookiejar]{.lit} [0.1]{.optlit}

[::http::cookiejar]{.cmd} [configure]{.sub} [optionName]{.optarg} [optionValue]{.optarg}
[::http::cookiejar]{.cmd} [create]{.sub} [name]{.arg} [filename]{.optarg}
[::http::cookiejar]{.cmd} [new]{.sub} [filename]{.optarg}

[cookiejar]{.ins} [destroy]{.sub}
[cookiejar]{.ins} [forceLoadDomainData]{.sub}
[cookiejar]{.ins} [getCookies]{.sub} [protocol]{.arg} [host]{.arg} [path]{.arg}
[cookiejar]{.ins} [storeCookie]{.sub} [options]{.arg}
[cookiejar]{.ins} [lookup]{.sub} [host]{.optarg} [key]{.optarg}
:::

# Beschreibung

Das Paket **cookiejar** stellt eine Implementierung des Cookie-Jar-Protokolls des http-Pakets unter Verwendung einer SQLite-Datenbank bereit. Es bietet einen Hauptbefehl, **::http::cookiejar**, eine TclOO-Klasse, die instanziiert werden sollte, um einen Cookie-Jar zu erzeugen, der eine bestimmte HTTP-Sitzung verwaltet.

Die Datenbankverwaltungsrichtlinie kann auf Paketebene über die Methode **configure** des Klassenobjekts **::http::cookiejar** gesteuert werden:

[::http::cookiejar]{.cmd} [configure]{.sub} [optionName]{.optarg} [optionValue]{.optarg}
: Wenn weder *optionName* noch *optionValue* angegeben sind, gibt dieser Befehl eine Kopie der Konfiguration als Tcl-Dictionary zurück. Wenn nur *optionName* angegeben ist, wird nur der Wert der benannten Option zurückgegeben. Wenn sowohl *optionName* als auch *optionValue* angegeben sind, wird die benannte Option auf den angegebenen Wert geändert.

    Unterstützte Optionen sind:

    [-domainfile]{.lit} [filename]{.arg}
    : Eine Datei (standardmäßig innerhalb des cookiejar-Pakets), die eine Beschreibung der Liste der Top-Level-Domains enthält (z. B. **.com** oder **.co.jp**). Solche Domains dürfen *keine* auf ihnen gesetzten Cookies akzeptieren. Beachten Sie, dass die Liste solcher Domains sowohl sicherheitsrelevant als auch *nicht* konstant ist und regelmäßig neu abgerufen werden sollte. Cookie-Jars führen einen eigenen Cache der Domain-Liste.

    [-domainlist]{.lit} [url]{.arg}
    : Eine URL, von der die Liste der Top-Level-Domains (z. B. **.com** oder **.co.jp**) abgerufen wird. Solche Domains dürfen *keine* auf ihnen gesetzten Cookies akzeptieren. Beachten Sie, dass die Liste solcher Domains sowohl sicherheitsrelevant als auch *nicht* konstant ist und regelmäßig neu abgerufen werden sollte. Cookie-Jars führen einen eigenen Cache der Domain-Liste.

    [-domainrefresh]{.lit} [intervalMilliseconds]{.arg}
    : Die Anzahl Millisekunden zwischen Prüfungen der **-domainlist** auf neue Domains.

    [-loglevel]{.lit} [level]{.arg}
    : Die Protokollierungsstufe dieses Pakets. Die Protokollierungsstufe muss (in absteigender Ausführlichkeit) eine von **debug**, **info**, **warn** oder **error** sein.

    [-offline]{.lit} [flag]{.arg}
    : Ermöglicht, die Cookie-Verwaltungsengine in den Offline-Modus zu versetzen. Im Offline-Modus wird die Domain-Liste sofort aus der in der Option **-domainfile** konfigurierten Datei gelesen, und die Option **-domainlist** wird nicht verwendet; außerdem wird die Option **-domainrefresh** faktisch ignoriert.

    [-purgeold]{.lit} [intervalMilliseconds]{.arg}
    : Die Anzahl Millisekunden zwischen Prüfungen der Datenbank auf abgelaufene Cookies; abgelaufene Cookies werden gelöscht.

    [-retain]{.lit} [cookieCount]{.arg}
    : Die maximale Anzahl Cookies, die in der Datenbank aufbewahrt werden.

    [-vacuumtrigger]{.lit} [deletionCount]{.arg}
    : Anzahl persistenter Cookie-Löschungen zwischen zwei **VACUUM**-Durchläufen der Datenbank.



Cookie-Jar-Instanzen können mit allen üblichen TclOO-Instanzerzeugungsmethoden (**create** oder **new**) erzeugt werden.

[::http::cookiejar]{.cmd} [new]{.sub} [filename]{.optarg}
: Wenn ein Argument *filename* angegeben wird, ist es der Name einer Datei mit einer SQLite-Datenbank, die die persistenten Cookies des Cookie-Jars enthält; die Datenbank wird erzeugt, wenn die Datei noch nicht existiert. Wenn *filename* nicht angegeben wird, liegt die Datenbank vollständig im Speicher, wodurch alle darin enthaltenen Cookies faktisch Sitzungs-Cookies sind.


## Instanzmethoden

Die folgenden Methoden werden von Instanzen unterstützt:

[cookiejar]{.ins} [destroy]{.sub}
: Dies ist die Standard-TclOO-Zerstörungsmethode. Sie löscht die SQLite-Datenbank *nicht*, wenn sie auf die Platte geschrieben wurde. Aufrufer sind dafür verantwortlich, dass der Cookie-Jar zum Zeitpunkt der Zerstörung nicht mehr vom http-Paket verwendet wird.

[cookiejar]{.ins} [forceLoadDomainData]{.sub}
: Diese Methode veranlasst den Cookie-Jar, die Domain-Listendaten sofort zu laden (und zu cachen). Die Domain-Liste wird aus der auf Paketebene konfigurierten **-domainlist** geladen, sofern diese aktiviert ist, andernfalls aus der auf Paketebene konfigurierten **-domainfile**.

[cookiejar]{.ins} [getCookies]{.sub} [protocol]{.arg} [host]{.arg} [path]{.arg}
: Diese Methode ermittelt die Cookies für eine bestimmte HTTP-Anfrage. *Sie implementiert das http-Cookie-Jar-Protokoll.*

[cookiejar]{.ins} [policyAllow]{.sub} [operation]{.arg} [domain]{.arg} [path]{.arg}
: Diese Methode wird von der Methode **storeCookie** aufgerufen, um zu entscheiden, ob *operation* für *domain* und *path* ausgeführt werden darf. Die Prüfung erfolgt unmittelbar vor der Aktualisierung der Datenbank, nachdem die eingebauten Sicherheitsprüfungen durchgeführt wurden, und soll einen booleschen Wert zurückgeben; ist der Wert falsch, wird die Operation abgelehnt und die Datenbank nicht geändert. Unterstützte *operation*en sind:

    **delete**
    : Die *domain* möchte ein Cookie löschen.

    **session**
    : Die *domain* möchte ein Sitzungs-Cookie anlegen oder aktualisieren.

    **set**
    : Die *domain* möchte ein persistentes Cookie (mit definierter Lebensdauer) anlegen oder aktualisieren.


    Die Standardimplementierung dieser Methode gibt einfach true zurück; Unterklassen dieser Klasse können eigene Regeln festlegen.

[cookiejar]{.ins} [storeCookie]{.sub} [options]{.arg}
: Diese Methode speichert ein einzelnes Cookie aus einer bestimmten HTTP-Antwort. Cookies, die Sicherheitsprüfungen nicht bestehen, werden ignoriert. *Sie implementiert das http-Cookie-Jar-Protokoll.*

[cookiejar]{.ins} [lookup]{.sub} [host]{.optarg} [key]{.optarg}
: Diese Methode sucht ein Cookie durch exakte Host- (oder Domain-)Übereinstimmung. Wenn weder *host* noch *key* angegeben sind, wird die Liste der Hosts zurückgegeben, für die ein Cookie gespeichert ist. Wenn nur *host* (Hostname oder Domainname) angegeben ist, wird die Liste der gespeicherten Cookie-Schlüssel für diesen Host zurückgegeben. Wenn sowohl *host* als auch *key* angegeben sind, wird der Wert für diesen Schlüssel zurückgegeben; es ist ein Fehler, wenn Host oder Schlüssel nicht exakt übereinstimmen.


# Beispiele

Der einfachste Weg, einen Cookie-Jar zu verwenden, besteht darin, ihn zu Beginn der Anwendung dauerhaft zu konfigurieren.

```
package require http
package require cookiejar

set cookiedb [file join [file home] cookiejar]
http::config -cookiejar [http::cookiejar new $cookiedb]

# Keine weiteren expliziten Schritte zum Verwenden von Cookies nötig
set tok [http::geturl http://core.tcl-lang.org/]
```

Um nur einer bestimmten Domain Cookies zu erlauben, etwa weil nur ein bestimmter Host Sitzungen anlegen und verwalten soll, legen Sie eine Unterklasse an, die diese Richtlinie durchsetzt.

```
package require http
package require cookiejar

oo::class create MyCookieJar {
    superclass http::cookiejar

    method policyAllow {operation domain path} {
        return [expr {$domain eq "my.example.com"}]
    }
}

set cookiedb [file join [file home] cookiejar]
http::configure -cookiejar [MyCookieJar new $cookiedb]

# Keine weiteren expliziten Schritte zum Verwenden von Cookies nötig
set tok [http::geturl http://core.tcl-lang.org/]
```
