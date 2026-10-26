# Tcl Web Services

## Summary

 The distribution provides both client side access to Web Services and server side creation of Web Services. Currently only document/literal and rpc/encoded with HTTP Soap transport are supported on the client side. The server side currently works only with TclHttpd or embedded into an application. The server side provides all services as document/literal over HTTP Soap transport. Documentation for the package, including examples can be found here. 

-  [Calling a Web Service from Tcl](Calling_a_Web_Service.md)
-  [Creating a Tcl Web Service](Creating_a_Tcl_Web_Service.md)
-  [Creating a Web Service Type](Creating_a_Web_Service_Type.md)
-  [REST flavor service response](Rest_flavor_service_response.md)
-  [Dictionary Representation of XML Arrays](Dictionary_Representation_of_XML_Arrays.md)
-  [Using Web Service Options](Using_Options.md)
-  [Embeding a Web Service into an application](Embedded_Web_Service.md)
-  [Tcl Web Service Example](Tcl_Web_Service_Example.md)
-  [Tcl Web Service Math Example](Tcl_Web_Service_Math_Example.md)

 The client is known to work with #C and Java based Web Services (your mileage may very). 

## License

Standard BSD.

# Web Servers

 The server side works with the following web servers: 

-  [TclHttpd](https://core.tcl-lang.org/tclhttpd) 
-  [Rivet](http://tcl.apache.org/rivet) 
-  [AOLserver](http://www.aolserver.com/) 
-  [WUB](http://code.google.com/p/wub/) 
-  [wibble](http://wiki.tcl-lang.org/23626) 
-  Embedded mode (see [Embedding](Embedded_Web_Service.md)) 

## Packages Required

 The following packages are used: 

-  [Tcl 8.6](http://www.tcl-lang.org/) 
-  [tdom 0.8.1](http://www.tdom.org/) 
-  [tcltls](http://core.tcl-lang.org/tcltls/) or [TWAPI 4.4.0](https://www.magicsplat.com/tcl-docs/doctoc_twapi.html) for client and embedded server TLS support 
-  log from [TclLib](https://core.tcl-lang.org/tcllib) 
-  uri from [TclLib](https://core.tcl-lang.org/tcllib) 
-  struct::set from [TclLib](https://core.tcl-lang.org/tcllib) 
-  http from [Tcl](http://www.tcl-lang.org/) itself 
-  yajl-tcl from [flightaware github](https://github.com/flightaware/yajl-tcl) (only for rest-flavour requests) 

 If you are running the TclHttpd on Windows, it is highly recommended that you use the iocpsock extension. 

 The following packages are additionally used in Embedded Server mode: 

-  base64 from [TclLib](https://core.tcl-lang.org/tcllib) (also channel server) 
-  html from [TclLib](https://core.tcl-lang.org/tcllib) (also channel server) 
-  ncgi from [TclLib](https://core.tcl-lang.org/tcllib) 
-  fileutil from [TclLib](https://core.tcl-lang.org/tcllib)
