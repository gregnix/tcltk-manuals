---
CommandName: picoirc
title: picoirc
ManualSection: n
Version: 0.14.1
TclPart: tcllib
TclDescription: Simple embeddable IRC interface
Links:
 - rfc 1459
Keywords:
 - chat
 - irc
Copyright:
---

# Name

picoirc – Ein kleiner und einfacher, einbettbarer IRC-Client.

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [picoirc]{.lit} [0.14.1]{.optlit}
[::picoirc::connect]{.cmd} [callback]{.arg} [nick]{.arg} [password]{.optarg} [url]{.arg}
[::picoirc::post]{.cmd} [context]{.arg} [channel]{.arg} [message]{.arg}
:::

# Beschreibung

Dieses Paket enthält einen universell einsetzbaren, minimalistischen IRC-Client, der sich zur Einbindung in andere Anwendungen eignet. Die gesamte Kommunikation mit der übergeordneten Anwendung erfolgt über eine von der Anwendung bereitgestellte Rückrufprozedur. Jede Verbindung verfügt über einen eigenen Zustand, sodass sich mehrere Server in einer einzigen Anwendungsinstanz anbinden lassen.

Zum Aufbau einer IRC-Verbindung wird **picoirc::connect** mit einer Rückrufprozedur, einem auf IRC zu verwendenden Nickname und der IRC-URL aufgerufen, die die Verbindung beschreibt. Zurückgegeben wird ein Variablenname, der den IRC-Verbindungskontext darstellt. Einzelheiten stehen unter [Callback].

Dieses Paket ist ein relativ einfacher IRC-Client. Wenn mehr Funktionen nötig sind, kommt das Paket **irc** in Betracht.

# Befehle

**::picoirc::connect** *callback* *nick* ?*password*? *url*
: Stellt eine neue IRC-Verbindung zu dem durch *url* angegebenen Server her und meldet sich mit dem *nick* als Benutzername und optional mit dem *password* an. Wenn die *url* mit *ircs://* beginnt, wird eine TLS-Verbindung hergestellt. Der *callback* muss den Angaben unter [Callback] entsprechen. Zurückgegeben wird eine paketspezifische Variable, die beim Aufruf anderer Befehle in diesem Paket verwendet wird.

    *Hinweis:* Für die Verbindung über TLS muss das Tcl-Modul *tls* bereits geladen sein, andernfalls wird ein Fehler ausgelöst.

    ```
    # must be loaded for TLS
    package require tls
    # default arguments
    tls::init -autoservername true -command workaround \
        -require 1 -cadir /etc/ssl/certs -tls1 0 -tls1.1 0
    # avoid annoying bgerror, errors are already catched internally
    proc workaround {state args} {
        if {$state == "verify"} {
            return [lindex $args 3]
        }
    }
    ```

**::picoirc::post** *context* *channel* *message*
: Dieser Befehl verarbeitet Benutzereingaben und sendet sie an den Server. Wenn *message* mehrzeilig ist, wird jede Zeile einzeln verarbeitet und gesendet. Eine Reihe von Befehlen wird erkannt, wenn ihnen ein Schrägstrich (/) vorangestellt ist. Solche Befehle werden in IRC-Befehlssequenzen umgewandelt und anschließend gesendet. Wenn *channel* leer ist, wird die gesamte Rohausgabe an den Server behandelt. Standardmäßig wird die *message* in den IRC-Socket geschrieben. Bevor dies geschieht, wird die Rückruffunktion mit "debug write" aufgerufen. Dadurch kann der Autor der Anwendung die rohen IRC-Daten prüfen und bei Bedarf den Fehlercode break zurückgeben, um die weitere Verarbeitung anzuhalten. Auf diese Weise kann die Anwendung das standardmäßige Senden über die Rückruffunktion überschreiben.


# Callback

Die Rückruffunktion muss wie folgt aussehen:

```
proc Callback {context state args} {
}
```

Dabei ist context der Name der IRC-Kontextvariablen (falls er an eine picoirc-Prozedur zurückgegeben werden muss). state ist einer der unten beschriebenen Zustände.

**init**
: wird unmittelbar vor der Erstellung des Sockets aufgerufen

**connect**
: wird aufgerufen, sobald die Verbindung hergestellt ist, bevor wir einem Kanal beitreten

**close**
: wird aufgerufen, wenn der Socket geschlossen wird, bevor der Kontext gelöscht wird. Tritt vor dem Herstellen der Verbindung ein Fehler auf, ist das einzige Argument die Fehlermeldung des Sockets.

**userlist** *channel* *nicklist*
: Wird aufgerufen, um die Anwendung über eine aktualisierte Benutzerliste zu informieren. Diese wird generiert, wenn die Ausgabe des IRC-Befehls „NAMES“ erkannt wird. Das Paket sammelt die gesamte Ausgabe, die sich über mehrere Zeilen vom Server erstrecken kann, und ruft diese Rückruffunktion auf, wenn alle Zeilen empfangen wurden.

**userinfo** *nick* *info*
: wird als Antwort auf einen WHOIS-Befehl aufgerufen. *nick* ist der Benutzer, an den sich der Befehl richtete. *info* ist das Dictionary mit detaillierten Angaben zu diesem Benutzer: name, host, channels und userinfo. userinfo enthält in der Regel Name und Version des IRC-Clients des Benutzers.

**chat** *target* *nick* *message* *type*
: Wird aufgerufen, wenn eine Nachricht eintrifft. *target* ist die Identität, an die die Nachricht gerichtet war. Dies kann der angemeldete Nickname oder ein Kanalname sein. *nick* ist der Name des Absenders der Nachricht. *message* ist der Text der Nachricht. *type* wird auf „ACTION“ gesetzt, wenn die Nachricht als CTCP-ACTION gesendet wurde. *type* wird auf „NOTICE“ gesetzt, wenn die Nachricht als NOTICE-Befehl gesendet wurde; in diesem Fall ist *target* leer, wenn es mit dem Nickname des aktuellen Benutzers übereinstimmt, oder es lautet „\*“; im letzteren Fall bedeutet ein leeres *target*, dass die Benachrichtigung vom Server stammt.

**mode** *nick* *target* *flags*
: Wird aufgerufen, wenn sich der Modus eines Benutzers oder eines Kanals ändert. *nick* ist der Name des Benutzers, der die Änderung angefordert hat; dieser Parameter kann leer sein, wenn es sich um den Server handelt. *target* ist die Identität, deren Modus geändert wird. *flags* sind die Änderungen am Modus.

**system** *channel* *message*
: wird aufgerufen, wenn eine Systemmeldung empfangen wird

**topic** *channel* *topic*
: wird aufgerufen, wenn die Zeichenfolge des Kanalthemas erkannt wird. *topic* ist der Text des Kanalthemas.

**traffic** *action* *channel* *nick* ?*newnick*?
: wird aufgerufen, wenn Benutzer beitreten, den Server verlassen oder ihren Namen ändern. *action* ist entweder entered, left oder nickchange, und *nick* ist der Benutzer, der die Aktion ausführt. *newnick* ist der neue Name, wenn *action* nickchange ist.

    *Hinweis*: *channel* ist bei diesen Meldungen oft leer, da Nickname-Aktionen für den gesamten IRC-Server gelten. Die Nicknames aller verbundenen Kanäle sind selbst zu verwalten.

**version**
: Diese Funktion wird aufgerufen, um eine Versionszeichenfolge abzufragen, mit der die interne Version überschrieben werden soll. Wenn sie implementiert ist, sollte sie eine durch Doppelpunkte getrennte Zeichenfolge in folgendem Format zurückgeben:

    Appname:Appversion:LibraryVersion

    Beispielsweise lautet der Vorgabewert

    PicoIRC:\[package provide picoirc\]:Tcl \[info patchlevel\]

**debug** *type* *raw*
: wird aufgerufen, wenn Daten entweder aus dem Netzwerk-Socket gelesen oder in diesen geschrieben werden. *type* wird beim Lesen von Daten auf **read** gesetzt und auf **write**, wenn die Daten geschrieben werden sollen. *raw* sind die unverarbeiteten IRC-Protokolldaten.

    In beiden Fällen kann die Anwendung den Fehlercode break zurückgeben, um die weitere Verarbeitung der Rohdaten zu unterbrechen. Handelt es sich um eine Operation vom Typ **read**, verarbeitet das Paket diese Zeile nicht. Handelt es sich um die Operation **write**, sendet das Paket die Daten nicht. Diese Rückruffunktion ist für die Fehlersuche bei Protokollproblemen vorgesehen, könnte bei Bedarf aber auch dazu dienen, die gesamte Ein- und Ausgabe umzuleiten.


# Kategorie

Netzwerk
