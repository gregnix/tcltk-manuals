# Antwort im Rest-Stil

---

## Inhalt

- [1 Überblick](#berblick) 
- [2 Rivet-Beispiel](#rivet-beispiel) 

 

## Überblick

Seit TCLWS 2.4 kann eine Antwort im *REST-Stil* zurückgegeben werden. Das heißt, statt eines XML-Dokuments wird eine JSON-Antwort zurückgegeben.

Unser Anwendungsfall verlangte nur, FORM-Argumente anzunehmen und für alles JSON-Antworten zurückzugeben. Logik, die Eingabeargumente zerlegt, die als serialisierte JSON-Daten übergeben werden, ist deshalb nicht umgesetzt. Das könnte jemand später untersuchen.

## Rivet-Beispiel

Ein Stück Code zeigt, wie dieser Modus in Apache Rivet anfangs gestartet wird. Das ähnelt tatsächlich stark der Verwendung von tclws im SOAP-Modus aus Apache Rivet:

```
        # Die Angaben der Anfrage in ein Array übernehmen.
        load_headers hdrArray
        set sock [pid];         # ein beliebiger Wert
        array unset ::Httpd$sock

        # Die Argumente im CGI-Stil in eine Liste bringen.
        load_response formArray
        set opname $formArray(call)
        unset formArray(call)
        set queryarg [list $opname [array get formArray]]

        # Die Methode aufrufen.
        array set ::Httpd$sock [list query $queryarg ipaddr [env REMOTE_ADDR] headerlist [array get hdrArray]]

        # Die Methode im REST-Modus aufrufen.
        set result [catch {::WS::Server::callOperation $svcname $sock -rest} error]
        array unset ::Httpd$sock
        if {$result} {
                headers numeric 500
                puts "Operation failed: $error"
                abort_page
        }
```
