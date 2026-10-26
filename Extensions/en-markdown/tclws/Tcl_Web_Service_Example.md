# Tcl Web Service Example

## Server Side 

 The following is placed in the httpdthread.tcl: 

```
   package require WS::Server
   package require WS::Utils
```

 The following is placed in the a file in the custom directory: 

```
   ##
   ## Define the service
   ##
   ::WS::Server::Service \
       -service wsExamples \
       -description  {Tcl Example Web Services} \
       -host         $::Config(host):$::Config(port)
```

```
   ##
   ## Define any special types
   ##
   ::WS::Utils::ServiceTypeDef Server wsExamples echoReply {
       echoBack     {type string}
       echoTS       {type dateTime}
   }
```

```
   ##
   ## Define the operations available
   ##
   ::WS::Server::ServiceProc \
       wsExamples \
       {SimpleEcho {type string comment {Requested Echo}}} \
       {
           TestString      {type string comment {The text to echo back}}
       } \
       {Echo a string back} {
```

```
       return [list SimpleEchoResult $TestString]
   }
```

  


```
   ::WS::Server::ServiceProc \
       wsExamples \
       {ComplexEcho {type echoReply comment {Requested Echo -- text and timestamp}}} \
       {
           TestString      {type string comment {The text to echo back}}
       } \
       {Echo a string and a timestamp back} {
```

```
       set timeStamp [clock format [clock seconds] -format {%Y-%m-%dT%H:%M:%SZ} -gmt yes]
       return [list ComplexEchoResult [list echoBack $TestString echoTS $timeStamp]  ]
   }
```

  


## Client Side 

```
   package require WS::Client
```

```
   ##
   ## Get Definition of the offered services
   ##
   ::WS::Client::GetAndParseWsdl http://localhost:8015/service/wsExamples/wsdl
```

```
   set testString "This is a test"
   set inputs [list TestString $testString]
```

```
   ##
   ## Call synchronously
   ##
   puts stdout "Calling SimpleEcho via DoCalls!"
   set results [::WS::Client::DoCall wsExamples SimpleEcho $inputs]
   puts stdout "\t Received: {$results}"
```

```
   puts stdout "Calling ComplexEcho via DoCalls!"
   set results [::WS::Client::DoCall wsExamples ComplexEcho $inputs]
   puts stdout "\t Received: {$results}"
```

  


```
   ##
   ## Generate stubs and use them for the calls
   ##
   ::WS::Client::CreateStubs wsExamples
   puts stdout "Calling SimpleEcho via Stubs!"
   set results [::wsExamples::SimpleEcho $testString]
   puts stdout "\t Received: {$results}"
```

```
   puts stdout "Calling ComplexEcho via Stubs!"
   set results [::wsExamples::ComplexEcho $testString]
   puts stdout "\t Received: {$results}"
```

```
   ##
   ## Call asynchronously
   ##
   proc success {service operation result} {
       global waitVar
```

```
       puts stdout "A call to $operation of $service was successful and returned $result"
       set waitVar 1
   }
```

```
   proc hadError {service operation errorCode errorInfo} {
       global waitVar
```

```
       puts stdout "A call to $operation of $service was failed with {$errorCode} {$errorInfo}"
       set waitVar 1
   }
```

```
   set waitVar 0
   puts stdout "Calling SimpleEcho via DoAsyncCall!"
   ::WS::Client::DoAsyncCall wsExamples SimpleEcho $inputs \
           [list success wsExamples SimpleEcho] \
           [list hadError wsExamples SimpleEcho]
   vwait waitVar
```

```
   puts stdout "Calling ComplexEcho via DoAsyncCall!"
   ::WS::Client::DoAsyncCall wsExamples ComplexEcho $inputs \
           [list success wsExamples SimpleEcho] \
           [list hadError wsExamples SimpleEcho]
   vwait waitVar
```

```
   exit
```
