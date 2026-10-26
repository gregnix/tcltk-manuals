# Einen Webdienst einbetten

## Inhalt

- [1 Das eingebettete Paket Webservices laden](#das-paket-webservices-server-laden) 
- [2 Einen Port angeben, auf dem Anforderungen empfangen werden](#einen-port-angeben-auf-dem-anforderungen-empfangen-werden) 
- [3 Die Ereigniswarteschlange ausführen](#die-ereigniswarteschlange-ausf-hren) 
- [4 Einen Port schließen](#einen-port-schlie-en) 
- [4 Alle Ports schließen](#alle-ports-schlie-en) 

## Das Paket Webservices Server laden 

Das Serverpaket für Webservices wird so geladen: 

```
 package require WS::Embeded
```

Dieser Befehl lädt den Server nur beim ersten Mal. Es schadet also nicht, ihn in jede Datei zu setzen, die einen Dienst oder eine Dienstprozedur deklariert. 

---

## Einen Port angeben, auf dem Anforderungen empfangen werden

Der folgende Befehl öffnet einen Listener-Socket auf dem angegebenen Port. Die Webdienst-Funktion lässt sich durch einen Aufruf von *::WS::Server::Service* hinzufügen, bei dem der Parameter *-mode* auf *embedded* gesetzt ist. 

**Prozedurname : ::WS::Embeded::Listen** 

**Beschreibung** : Weist das Modul an, auf einem Port zu lauschen, mit Sicherheitsangaben. 

**Argumente** : diese Prozedur verwendet positionsabhängige Argumente, und zwar: 

```
     port     -- Port number to listen on.
     certfile -- Name of the certificate file or a pfx archive for twapi.
                 Defaults to {}.
     keyfile  -- Name of the key file. Defaults to {}.
                 To use twapi TLS, specify a list with the following elements:
                 -- "-twapi": Flag, that TWAPI TLS should be used
                 -- password: password of PFX file passed by
                    [::twapi::conceal]. The concealing makes sure that the
                    password is not readable in the error stack trace
                 -- ?subject?: optional search string in pfx file, if
                    multiple certificates are included.
     userpwds -- A list of username:password. Defaults to {}.
     realm    -- The seucrity realm. Defaults to {}.
     timeout  -- A time in ms the sender may use to send the request.
                 If a sender sends wrong data (Example: TLS if no TLS is
                 used), the process will just stand and a timeout is required
                 to clear the connection. Set to 0 to not use a timeout.
                 Default: 60000 (1 Minuit).
```

**Gibt zurück** : Handle des Sockets 

**Nebenwirkungen** : Keine 

**Ausnahmebedingungen** : : Keine 

**Voraussetzungen** : Keine 

---

## Die Ereigniswarteschlange ausführen

Um Anforderungen zu bedienen, muss der Interpreter die Ereigniswarteschlange ausführen. Ist das nicht ohnehin der Fall (etwa weil Tk geladen ist), genügt der folgende Aufruf:

```
     vwait waitVariable
```

Um die Ereigniswarteschlange nach dem Herunterfahren des Servers zu beenden, dient:

```
     set waitVariable 1
```

---

## Einen Port schließen

**Prozedurname : ::WS::Embeded::Close** 

**Beschreibung** : Schließt einen zuvor geöffneten Listener-Port und beendet alle laufenden Anforderungen auf diesem Port. 

**Argumente** : diese Prozedur verwendet positionsabhängige Argumente, und zwar: 

```
     port     -- Port number to close.
```

**Gibt zurück** : Nichts 

**Nebenwirkungen** : Keine 

**Ausnahmebedingungen** : : Keine 

**Voraussetzungen** : Keine 

---

## Alle Ports schließen

**Prozedurname : ::WS::Embeded::CloseAll** 

**Beschreibung** : Schließt alle zuvor geöffneten Listener-Ports und beendet alle laufenden Anforderungen. 

**Argumente** : diese Prozedur verwendet keine Argumente

**Gibt zurück** : Nichts 

**Nebenwirkungen** : Keine 

**Ausnahmebedingungen** : : Keine 

**Voraussetzungen** : Keine
