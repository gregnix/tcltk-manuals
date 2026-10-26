# Rest-flavor service reply

---

## Contents

- [1 Overview](#overview) 
- [2 Rivet example](#rivet-example) 

 

## Overview 

Since TCLWS 2.4, it is possible to return a response in *REST style*. This means, that a JSON reply is returned instead of an XML document.

Our use case has only required us to accept FORM arguments and return JSON responses for everything, so we haven't implemented logic to parse any input arguments that are passed in as JSON serialized data, but this might be an area of future exploration for someone.

## Rivet Example

Here's a bit of code showing how we initially start up this mode in Apache Rivet, which is actually pretty similar to how you'd use tclws in SOAP mode from Apache Rivet:

```
        # Capture the info from the request into an array.
        load_headers hdrArray
        set sock [pid];         # an arbitrary value
        array unset ::Httpd$sock

        # Prepare the CGI style arguments into a list
        load_response formArray
        set opname $formArray(call)
        unset formArray(call)
        set queryarg [list $opname [array get formArray]]

        # Invoke the the method
        array set ::Httpd$sock [list query $queryarg ipaddr [env REMOTE_ADDR] headerlist [array get hdrArray]]

        # Invoke the method in REST mode.
        set result [catch {::WS::Server::callOperation $svcname $sock -rest} error]
        array unset ::Httpd$sock
        if {$result} {
                headers numeric 500
                puts "Operation failed: $error"
                abort_page
        }
```
