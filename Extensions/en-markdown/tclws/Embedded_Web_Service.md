# Embeding a Web Service

## Contents

- [1 Loading the Webservices Embeded Package](#loading-the-webservices-server-package) 
- [2 Specify a Port to Receive Request on](#specify-a-port-to-receive-request-on) 
- [3 Run the event queue](#run-the-event-queue) 
- [4 Close a port](#close-a-port) 
- [4 Close all ports](#close-all-ports) 

## Loading the Webservices Server Package 

To load the webservices server package, do: 

```
 package require WS::Embeded
```

This command will only load the server the first time it is used, so it causes no ill effects to put this in each file declaring a service or service procedure. 

---

## Specify a Port to Receive Request on

The following command opens a listener socket in the specified port. The webservice functionality may be added by a call to *::WS::Server::Service* with the *-mode* parameter set to *embedded*. 

**Procedure Name : ::WS::Embeded::Listen** 

**Description** : Instruct the module to listen on a Port, security information. 

**Arguments** : this procedure uses position dependent arguments, they are: 

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

**Returns** : Handle of socket 

**Side-Effects** : None 

**Exception Conditions** :  : None 

**Pre-requisite Conditions** : None 

---

## Run the event queue

To serve any requests, the interpreter must run the event queue using. If this is not anyway the case (Tk present etc.), one may call:

```
     vwait waitVariable
```

To stop the event queue after server shutdown, one may execute:

```
     set waitVariable 1
```

---

## Close a port

**Procedure Name : ::WS::Embeded::Close** 

**Description** : Close a formerly opened listener port and stop all running requests on this port. 

**Arguments** : this procedure uses position dependent arguments, they are: 

```
     port     -- Port number to close.
```

**Returns** : None 

**Side-Effects** : None 

**Exception Conditions** :  : None 

**Pre-requisite Conditions** : None 

---

## Close all ports

**Procedure Name : ::WS::Embeded::CloseAll** 

**Description** : Close all formerly opened listener port and stop all running requests. 

**Arguments** : this procedure uses no arguments

**Returns** : None 

**Side-Effects** : None 

**Exception Conditions** :  : None 

**Pre-requisite Conditions** : None
