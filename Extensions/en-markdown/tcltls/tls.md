---
CommandName: tls
title: tls
ManualSection: n
Version: 2.0.1
TclPart: tls
TclDescription: Tcl TLS extension
Links:
 - OpenSSL [https://www.openssl.org/]
 - http
 - socket
Keywords:
 - I/O
 - IP Address
 - OpenSSL
 - SSL
 - TCP
 - TLS
 - TclTLS
 - asynchronous I/O
 - bind
 - certificate
 - channel
 - connection
 - domain name
 - host
 - https
 - network
 - network address
 - socket
 - tls
Copyright:
 - Copyright (c) 1999 Matt Newman
 - Copyright (c) 2004 Starfish Systems
 - Copyright (c) 2024 Brian O'Hagan
---

# Name

tls - binding to the OpenSSL library for encrypted socket and I/O channel communications

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [tls]{.lit} [2.0.1]{.lit}
[tls::init]{.cmd} [-option]{.optarg} [value]{.optarg} [-option value]{.optdot}
[tls::socket]{.cmd} [-option]{.optarg} [value]{.optarg} [-option value]{.optdot} [host]{.arg} [port]{.arg}
[tls::socket]{.cmd} [-server]{.lit} [command]{.arg} [-option]{.optarg} [value]{.optarg} [-option value]{.optdot} [port]{.arg}
[tls::import]{.cmd} [channel]{.arg} [-option]{.optarg} [value]{.optarg} [-option value]{.optdot}
[tls::starttls]{.cmd} [channel]{.arg} [-option]{.optarg} [value]{.optarg} [-option value]{.optdot}
[tls::handshake]{.cmd} [channel]{.arg}
[tls::shutdown]{.cmd} [channel]{.arg}
[tls::unimport]{.cmd} [channel]{.arg}
[tls::unstack]{.cmd} [channel]{.arg}
[tls::status]{.cmd} [-local]{.optlit} [channel]{.arg}
[tls::connection]{.cmd} [channel]{.arg}
[tls::ciphers]{.cmd} [protocol]{.optarg} [verbose]{.optarg} [supported]{.optarg}
[tls::protocols]{.cmd}
[tls::version]{.cmd}
:::

# Description

This extension provides TCL script access to Secure Socket Layer (SSL) communications using the Transport Layer Security (TLS) protocol. It provides a generic binding to [OpenSSL](https://www.openssl.org/), utilizing the **Tcl\_StackChannel** API in TCL 8.4 or later. These sockets behave exactly the same as channels created using the built-in **socket** command, but provide additional options for controlling the SSL/TLS session.

# Compatibility

This extension is compatible with OpenSSL 1.1.1 or later including the 3.x and 4.0 releases. It requires Tcl version 8.5 or later and will work with Tcl 9.0.

# Commands

The following are the commands provided by the TcLTLS package. See [Examples] for example usage and the "*demos*" directory for more example usage.

**tls::init** ?*-option*? ?*value*? ?*-option value ...*?
: Optional function to set the default options used by **tls::socket**. If you call **tls::import** directly, the values set by this command have no effect. This command supports all of the same options as the **tls::socket** command, though you should limit your options to only the TLS related ones.

**tls::socket** ?*-option*? ?*value*? ?*-option value ...*? *host* *port*
: This is a helper function that utilizes the underlying commands **socket** and **tls::import** to create the connection. It behaves the same as the native TCL **socket** command, but also supports the **tls::import** command options with one additional option. It returns the channel handle id for the new socket. Additional options are:

    **-autoservername** *bool*
    : If **true**, automatically set the **-servername** argument to the *host* argument. Prior to TclTLS 2.0, the default is **false**. Starting in TclTLS 2.0, the default is **true** unless **-servername** is also specified.


**tls::socket** **-server** *command* ?*-option*? ?*value*? ?*-option value ...*? *port*
: Same as previous command, but instead creates a server socket for clients to connect to just like the Tcl **socket -server** command. It returns the channel handle id for the new socket.

**tls::import** *channel* ?*-option*? ?*value*? ?*-option value ...*?
: see below ...

**tls::starttls** *channel* ?*-option*? ?*value*? ?*-option value ...*?
: Start TLS encryption on TCL channel *channel* via a stacked channel. It need not be a socket, but must provide bi-directional flow. Also sets session parameters for SSL handshake. Valid options are:

    **-alpn** *list*
    : List of protocols to offer during Application-Layer Protocol Negotiation (ALPN). For example: **h2** and **http/1.1**, but not **h3** or **quic**. This option is new for TclTLS 1.8.

    **-cadir** *directory*
    : Specifies the directory where the Certificate Authority (CA) certificates are stored. The default is platform specific and can be set at compile time. The default location can be overridden by the **SSL\_CERT\_DIR** environment variable. See [Certificate Validation] for more details.

    **-cafile** *filename*
    : Specifies the file with the Certificate Authority (CA) certificates to use in **PEM** file format. The default is "*cert.pem*", in the OpenSSL directory. The default file can be overridden by the **SSL\_CERT\_FILE** environment variable. See [Certificate Validation] for more details.

    **-castore** *URI*
    : Specifies the Uniform Resource Identifier (URI) for the Certificate Authority (CA) store, which may be a single container or a catalog of containers. Starting with OpenSSL 3.2 on MS Windows, set to "**org.openssl.winstore://**" to use the built-in MS Windows Certificate Store. See [Certificate Validation] for more details. This option is new for TclTLS 1.8.

    **-certfile** *filename*
    : Specifies the name of the file with the certificate to use in PEM format as the local (client or server) certificate. It also contains the public key.

    **-cert** *string*
    : Specifies the certificate to use as a DER encoded string (X.509 DER).

    **-cipher** *string*
    : Specifies the list of ciphers to use for TLS 1.2 and earlier connections. String is a colon "**:**" separated list of ciphers. Ciphers can be combined using the "**+**" character. Prefixes can be used to permanently remove "**!**", delete "**-**", or move to the end "**+**" a specified cipher. Keywords **@STRENGTH** (sort by algorithm key length), **@SECLEVEL=***n* (set security level to n), and **DEFAULT** (use default cipher list, at start only) can also be specified. See the [OpenSSL](https://docs.openssl.org/master/man1/openssl-ciphers/#options) documentation for the full list of valid values.

    **-ciphersuites** *string*
    : Specifies the list of cipher suites to use for TLS 1.3 as a colon "**:**" separated list of cipher suite names. See the [OpenSSL](https://docs.openssl.org/master/man1/openssl-ciphers/#options) documentation for the full list of valid values. This option is new for TclTLS 1.8.

    **-command** *callback*
    : Specifies the callback command to be invoked at several points during the handshake to pass errors, tracing information, and protocol messages. See [Callback options] for more info.

    **-dhparams** *filename*
    : Specifies the Diffie-Hellman (DH) parameters file.

    **-keyfile** *filename*
    : Specifies the private key file. The default is to use the file specified by the **-certfile** option.

    **-key** *string*
    : Specifies the private key to use as a DER encoded string (PKCS#1 DER).

    **-model** *channel*
    : Force this channel to share the same *SSL\_CTX* structure as the specified *channel*, and therefore share config, callbacks, etc.

    **-password** *callback*
    : Specifies the callback command to invoke when OpenSSL needs to obtain a password. This is typically used to unlock the private key of a certificate. The callback should return a password string. This option has changed for TclTLS 1.8. See [Callback options] for more info.

    **-post\_handshake** *bool*
    : Allow post-handshake session ticket updates. This option is new for TclTLS 1.8.

    **-request** *bool*
    : Request a certificate from the peer during the SSL handshake. This is needed to do Certificate Validation. Starting in TclTLS 1.8, the default is **true** for client connections. Starting in TclTLS 2.0, if set to **false** and **-require** is **true**, then this will be overridden to **true**. See [Certificate Validation] for more details.

    **-require** *bool*
    : Require a valid certificate from the peer during the SSL handshake. If this is set to true, then **-request** must also be set to true and a either **-cadir**, **-cafile**, **-castore**, or a platform default must be provided in order to validate against. The default in TclTLS 1.8 and earlier versions is **false** since not all platforms have certificates to validate against in a form compatible with OpenSSL. Starting in TclTLS 2.0, the default is **true** for client connections. See [Certificate Validation] for more details.

    **-security\_level** *integer*
    : Specifies the security level (value from 0 to 5). The security level affects the allowed cipher suite encryption algorithms, supported ECC curves, supported signature algorithms, DH parameter sizes, certificate key sizes and signature algorithms. The default is 1 prior to OpenSSL 3.2 and 2 thereafter. Level 3 and higher disable support for session tickets and only accept cipher suites that provide forward secrecy. This option is new for TclTLS 1.8.

    **-server** *bool*
    : Specifies whether to act as a server and respond with a server handshake when a client connects and provides a client handshake. The default is **false**.

    **-servername** *hostname*
    : Specify the peer's hostname. This is used to set the TLS Server Name Indication (SNI) extension. Set this to the expected servername in the server's certificate or one of the Subject Alternate Names (SAN). Starting in TclTLS 2.0, this will default to the host from the **tls::socket** command.

    **-session\_id** *binary\_string*
    : Specifies the session id to resume a session. Not supported yet. This option is new for TclTLS 1.8.

    **-ssl2** *bool*
    : Enable use of SSL v2.The default is **false**. OpenSSL 1.1+ no longer supports SSL v2, so this may not have any effect. See the **tls::protocols** command for supported protocols.

    **-ssl3** *bool*
    : Enable use of SSL v3. The default is **false**. Starting in TclTLS 1.8, use of SSL v3 if only available via a compile time option. OpenSSL 4.0+ no longer supports SSL v3, so this may not have any effect. See the **tls::protocols** command for supported protocols.

    **-tls1** *bool*
    : Enable use of TLS v1. Starting in TclTLS 2.0, the default is **false**. Note: TLS 1.0 needs SHA1 to operate, which is only available in security level 0 for Open SSL 3.0+. See the **-security\_level** option.

    **-tls1.1** *bool*
    : Enable use of TLS v1.1. Starting in TclTLS 2.0, the default is **false**. Note: TLS 1.1 needs SHA1 to operate, which is only available in security level 0 for Open SSL 3.0+. See the **-security\_level** option.

    **-tls1.2** *bool*
    : Enable use of TLS v1.2. The default is **true**.

    **-tls1.3** *bool*
    : Enable use of TLS v1.3. The default is **true**. This is only available starting with OpenSSL 1.1.1 and TclTLS 1.7.

    **-validatecommand** *callback*
    : Specifies the callback command to invoke to validate the peer certificates and other config info during the protocol negotiation phase. This can be used by TCL scripts to perform their own Certificate Validation to supplement the default validation provided by OpenSSL. The script must return a boolean true to continue the negotiation. See [Callback options] for more info. This option is new for TclTLS 1.8.


**tls::handshake** *channel*
: Forces the TLS negotiation handshake to take place immediately, and returns 0 if handshake is still in progress (non-blocking), or 1 if the handshake was successful. If the handshake failed, an error will be returned.

**tls::shutdown** *channel*
: see below ...

**tls::unimport** *channel*
: see below ...

**tls::unstack** *channel*
: This terminates the SSL/TLS session by sending the "close\_notify" message and removes the top level stacked channel from *channel*, but it does not close the socket. It is the compliment to **tls::import** by ending encryption of a TCL channel. An error is thrown if TLS is not the top stacked channel type.

**tls::status** ?**-local**? *channel*
: Returns the current status of an SSL channel. The result is a list of key-value pairs describing the SSL, certificate, and certificate verification status. If the SSL handshake has not yet completed, an empty list is returned. If the **-local** option is specified, then the local certificate is used. Returned values include:

    SSL Status

    **alpn** *protocol*
    : The protocol selected after Application-Layer Protocol Negotiation (ALPN). This value is new for TclTLS 1.8.

    **cipher** *cipher*
    : The current cipher in use for the session.

    **peername** *name*
    : The peername from the certificate. This value is new for TclTLS 1.8.

    **protocol** *version*
    : The protocol version used for the connection: SSL2, SSL3, TLS1, TLS1.1, TLS1.2, TLS1.3, or unknown. This value is new for TclTLS 1.8.

    **sbits** *n*
    : The number of bits used for the session key.

    **signatureHashAlgorithm** *algorithm*
    : The signature hash algorithm. This value is new for TclTLS 1.8.

    **signatureType** *type*
    : The signature type value. This value is new for TclTLS 1.8.

    **verifyDepth** *n*
    : Maximum depth for the certificate chain verification. Default is -1, to check all. This value is new for TclTLS 1.8.

    **verifyMode** *list*
    : List of certificate verification modes. This value is new for TclTLS 1.8.

    **verifyResult** *result*
    : Certificate verification result. This value is new for TclTLS 1.8.

    **ca\_names** *list*
    : List of the Certificate Authorities used to create the certificate. This value is new for TclTLS 1.8.


    Certificate Status

    **all** *string*
    : Dump of all certificate info. This value is new for TclTLS 1.8.

    **version** *value*
    : The certificate version.

    **serialNumber** *string*
    : The serial number of the certificate as a hex string. This value was changed from serial in TclTLS 1.8.

    **signature** *algorithm*
    : Cipher algorithm used for certificate signature. This value is new for TclTLS 1.8.

    **issuer** *string*
    : The distinguished name (DN) of the certificate issuer.

    **notBefore** *date*
    : The beginning date of the certificate validity.

    **notAfter** *date*
    : The expiration date of the certificate validity.

    **subject** *string*
    : The distinguished name (DN) of the certificate subject. Fields include: Common Name (CN), Organization (O), Locality or City (L), State or Province (S), and Country Name (C).

    **issuerUniqueID** *string*
    : The issuer unique id. This value is new for TclTLS 1.8.

    **subjectUniqueID** *string*
    : The subject unique id. This value is new for TclTLS 1.8.

    **num\_extensions** *n*
    : Number of certificate extensions. This value is new for TclTLS 1.8.

    **extensions** *list*
    : List of certificate extension names. This value is new for TclTLS 1.8.

    **authorityKeyIdentifier** *string*
    : Authority Key Identifier (AKI) of the Issuing CA certificate that signed the SSL certificate as a hex string. This value matches the SKI value of the Intermediate CA certificate. This value is new for TclTLS 1.8.

    **subjectKeyIdentifier** *string*
    : Subject Key Identifier (SKI) hash of the public key inside the certificate as a hex string. Used to identify certificates that contain a particular public key. This value is new for TclTLS 1.8.

    **subjectAltName** *list*
    : List of all of the Subject Alternative Names (SAN) including domain names, sub domains, and IP addresses that are secured by the certificate. This value is new for TclTLS 1.8.

    **ocsp** *list*
    : List of all Online Certificate Status Protocol (OCSP) URLs that can be used to check the validity of this certificate. This value is new for TclTLS 1.8.

    **certificate** *cert*
    : The PEM encoded certificate.

    **signatureAlgorithm** *algorithm*
    : Cipher algorithm used for the certificate signature. This value is new for TclTLS 1.8.

    **signatureValue** *string*
    : Certificate signature as a hex string. This value is new for TclTLS 1.8.

    **signatureDigest** *version*
    : Certificate signing digest as a hex string. This value is new for TclTLS 1.8.

    **publicKeyAlgorithm** *algorithm*
    : Certificate signature public key algorithm. This value is new for TclTLS 1.8.

    **publicKey** *string*
    : Certificate signature public key as a hex string. This value is new for TclTLS 1.8.

    **bits** *n*
    : Number of bits used for certificate signature key. This value is new for TclTLS 1.8.

    **self\_signed** *boolean*
    : Whether the certificate signature is self signed. This value is new for TclTLS 1.8.

    **sha1\_hash** *hash*
    : The SHA1 hash of the certificate as a hex string. This value is new for TclTLS 1.8.

    **sha256\_hash** *hash*
    : The SHA256 hash of the certificate as a hex string. This value is new for TclTLS 1.8.


**tls::connection** *channel*
: Returns the current connection status of an SSL channel. The result is a list of key-value pairs describing the connection. This command is new for TclTLS 1.8. Returned values include:

    SSL Status

    **state** *state*
    : State of the connection.

    **servername** *name*
    : The name of the connected to server.

    **protocol** *version*
    : The protocol version used for the connection: SSL2, SSL3, TLS1, TLS1.1, TLS1.2, TLS1.3, or unknown.

    **renegotiation\_allowed** *boolean*
    : Whether protocol renegotiation is supported or not.

    **security\_level** *level*
    : The security level used for selection of ciphers, key size, etc.

    **session\_reused** *boolean*
    : Whether the session has been reused or not.

    **is\_server** *boolean*
    : Whether the connection is configured as a server (1) or client (0).

    **compression** *mode*
    : Compression method.

    **expansion** *mode*
    : Expansion method.

    **caList** *list*
    : List of Certificate Authorities (CA) for X.509 certificate.


    Cipher Info

    **cipher** *cipher*
    : The current cipher in use for the connection.

    **standard\_name** *name*
    : The standard RFC name of cipher.

    **algorithm\_bits** *n*
    : The number of processed bits used for cipher.

    **secret\_bits** *n*
    : The number of secret bits used for cipher.

    **min\_version** *version*
    : The minimum protocol version for cipher.

    **cipher\_is\_aead** *boolean*
    : Whether the cipher is Authenticated Encryption with Associated Data (AEAD).

    **cipher\_id** *id*
    : The OpenSSL cipher id.

    **description** *string*
    : A text description of the cipher.

    **handshake\_digest** *boolean*
    : Digest used during handshake.


    Session Info

    **alpn** *protocol*
    : The protocol selected after Application-Layer Protocol Negotiation (ALPN).

    **resumable** *boolean*
    : Whether the session can be resumed or not.

    **start\_time** *seconds*
    : Time since session started in seconds since epoch.

    **timeout** *seconds*
    : Max duration of session in seconds before time-out.

    **lifetime** *seconds*
    : Session ticket lifetime hint in seconds.

    **session\_id** *binary\_string*
    : Unique session id for use in resuming the session.

    **session\_ticket** *binary\_string*
    : Unique session ticket for use in resuming the session.

    **ticket\_app\_data** *binary\_string*
    : Unique session ticket application data.

    **master\_key** *binary\_string*
    : Unique session master key.

    **session\_cache\_mode** *mode*
    : Server cache mode (client, server, or both).


**tls::ciphers** ?*protocol*? ?*verbose*? ?*supported*?
: Without any options, it returns a list of all symmetric ciphers for use with the *-cipher* option. With *protocol*, only the ciphers supported for that protocol are returned. See the **tls::protocols** command for the supported protocols. If *verbose* is specified as true then a verbose, human readable list is returned with additional information on the cipher. If *supported* is specified as true, then only the ciphers supported for protocol will be listed. The *supported* arg is new for TclTLS 1.8.

**tls::protocols**
: Returns a list of the supported SSL/TLS protocols. Valid values are: **ssl2**, **ssl3**, **tls1**, **tls1.1**, **tls1.2**, and **tls1.3**. Exact list depends on OpenSSL version and compile time flags. This command is new for TclTLS 1.8.

**tls::version**
: Returns the OpenSSL version string.


# Certificate Validation

## PKI and certificates

Using the Public Key Infrastructure (PKI), each user creates a private key that only they know about and a public key they can exchange with others for use in encrypting and decrypting data. The process is the sender encrypts their data using their private key and the receiver's public key. The data is then sent to the receiver. In a similar manner, the receiver uses their private key and the sender's public key to decrypt the data. This provides data integrity, to ensure the data can't be viewed or altered during transport. See the **-key** and **-keyfile** options for how to specify the private key. Also see the **-password** option for how to provide the password.

In order to provide authentication, i.e. ensuring someone is who they say they are, the public key and user identification info is stored in a X.509 certificate and that certificate is authenticated (i.e. signed) by a Certificate Authority (CA). Users can then exchange these certificates during the TLS initialization process and check them against the root CA certificates to ensure they are valid. This is handled by OpenSSL via the **-request** and **-require** options. See the **-cadir**, **-cadir**, and **-castore** options for how to specify where to find the CA certificates. Optionally, in a future release, they can also be checked against the Certificate Revocation List (CRL) of revoked certificates. Certificates can also be self-signed, but they are by default not trusted unless you add them to your certificate store.

Typically when visiting web sites, only the client needs to check the server's certificate to ensure it is valid. The server doesn't need to check the client certificate unless you need to authenticate with them to login, etc. See the **-cert** and **-certfile** options if you need to provide a certificate.

## Summary of command line options

The following options are used for peer certificate validation:

**-cadir** *directory*
: Specifies the directory where the Certificate Authority (CA) certificates are stored. The default is platform specific, but is usually "*/etc/ssl/certs*" on Linux/Unix systems. The default location can be overridden by the **SSL\_CERT\_DIR** environment variable.

**-cafile** *filename*
: Specifies the file with the Certificate Authority (CA) certificates to use in **PEM** file format. The default is "*cert.pem*", in the OpenSSL directory. On Linux/Unix systems, this is usually "*/etc/ssl/ca-bundle.pem*". The default file can be overridden by the **SSL\_CERT\_FILE** environment variable.

**-castore** *URI*
: Specifies the Uniform Resource Identifier (URI) for the Certificate Authority (CA) store, which may be a single container or a catalog of containers. Starting with OpenSSL 3.2 on MS Windows, set to "**org.openssl.winstore://**" to use the built-in MS Windows Certificate Store. Starting in TclTLS 2.0, this is the default if **-cadir**, **-cadir**, and **-castore** are not specified. This store only supports root certificate stores.

**-request** *bool*
: Request a certificate from the peer during the SSL handshake. This is needed to do Certificate Validation. Starting in TclTLS 1.8, the default is **true** for client connections. Starting in TclTLS 2.0, if set to **false** and **-require** is **true**, then this will be overridden to **true**. In addition, the client can manually inspect and accept or reject each certificate using the **-validatecommand** option.

**-require** *bool*
: Require a valid certificate from the peer during the SSL handshake. If this is set to true, then **-request** must also be set to true and a either **-cadir**, **-cafile**, **-castore**, or a platform default must be provided in order to validate against. The default in TclTLS 1.8 and earlier versions is **false** since not all platforms have certificates to validate against in a form compatible with OpenSSL. Starting in TclTLS 2.0, the default is **true** for client connections.


## When are command line options needed?

In TclTLS 1.8 and earlier versions, certificate validation is *NOT* enabled by default. This limitation is due to the lack of a common cross platform database of Certificate Authority (CA) provided certificates to validate against. Many Linux systems natively support OpenSSL and thus have these certificates installed as part of the OS, but MacOS and MS Windows do not. Staring in TclTLS 2.0, the default for client connections has been changed to require certificate validation by default. In order to use the **-require** option, one of the following must be true:

- On Linux and Unix systems with OpenSSL already installed or if the CA certificates are available in PEM format, and if they are stored in the standard locations, or if the **SSL\_CERT\_DIR** or **SSL\_CERT\_FILE** environment variables are set, then **-cadir**, **-cadir**, and **-castore** aren't needed.

- If OpenSSL is not installed in the default location, or when using Mac OS or MS Windows and OpenSSL is installed, the **SSL\_CERT\_DIR** and/or **SSL\_CERT\_FILE** environment variables or the one of the **-cadir**, **-cadir**, or **-castore** options must be defined.

- On MS Windows, starting in OpenSSL 3.2, it is now possible to access the built-in Windows Certificate Store from OpenSSL. This can be utilized by setting the **-castore** option to "**org.openssl.winstore://**". In TclTLS 2.0, this is the default value if **-cadir**, **-cadir**, and **-castore** are not specified.

- If OpenSSL is not installed or the CA certificates are not available in PEM format, the CA certificates must be downloaded and installed with the user software. The CURL team makes them available at [CA certificates extracted from Mozilla](https://curl.se/docs/caextract.html) in the "*cacert.pem*" file. You must then either set the **SSL\_CERT\_DIR** and/or **SSL\_CERT\_FILE** environment variables or the **-cadir** or **-cafile** options to the CA cert file's install location. It is your responsibility to keep this file up to date.


# Callback options

As previously described, each channel can be given their own callbacks to handle intermediate processing by the OpenSSL library, using the **-command**, **-password**, and **-validate\_command** options passed to either of **tls::socket** or **tls::import**. Unlike previous versions of TclTLS, only if the callback generates an error, will the **bgerror** command be invoked with the error information.

## Values for command callback

The callback for the **-command** option is invoked at several points during the OpenSSL handshake and during routine operations. See below for the possible arguments passed to the callback script. Values returned from the callback are ignored.

**error** *channelId message*
: This form of callback is invoked whenever an error occurs during the initial connection, handshake, or I/O operations. The *message* argument can be from the Tcl\_ErrnoMsg, OpenSSL function **ERR\_reason\_error\_string()**, or a custom message. This callback is new for TclTLS 1.8.

**info** *channelId major minor message type*
: This form of callback is invoked by the OpenSSL function **SSL\_set\_info\_callback()** during the initial connection and handshake operations. The arguments are:

    *major*
    : Major category for error. Valid enums are: **handshake**, **alert**, **connect**, **accept**.

    *minor*
    : Minor category for error. Valid enums are: **start**, **done**, **read**, **write**, **loop**, **exit**.

    *message*
    : Descriptive message string which may be generated either by **SSL\_state\_string\_long()** or **SSL\_alert\_desc\_string\_long()**, depending on the context.

    *type*
    : For alerts, the possible values are: **warning**, **fatal**, and **unknown**. For others, **info** is used. This argument is new for TclTLS 1.8.


**message** *channelId direction version content\_type message*
: This form of callback is invoked by the OpenSSL function **SSL\_set\_msg\_callback()** whenever a message is sent or received during the initial connection, handshake, or I/O operations. It is only available when OpenSSL is complied with the **enable-ssl-trace** option. This callback is new for TclTLS 1.8. The arguments are:

    *direction*
    : Direction is either **Sent** or **Received**.

    *version*
    : Version is the protocol version.

    *content\_type*
    : Content type is the message content type.

    *message*
    : Message is more info from the **SSL\_trace** API.


**session** *channelId session\_id session\_ticket lifetime*
: This form of callback is invoked by the OpenSSL function **SSL\_CTX\_sess\_set\_new\_cb()** whenever a new session id is sent by the server during the initial connection and handshake and also during the session if the **-post\_handshake** option is set to true. This callback is new for TclTLS 1.8. The arguments are:

    *session\_id*
    : Session Id is the current session identifier

    *session\_ticket*
    : Ticket is the session ticket info

    *lifetime*
    : Lifetime is the ticket lifetime in seconds.


**verify** *channelId depth cert status error*
: This callback was moved to **-validatecommand** in TclTLS 1.8.


## Values for password callback

The callback for the **-password** option is invoked by TclTLS whenever OpenSSL needs to obtain a password. See below for the possible arguments passed to the callback script. The user provided password is expected to be returned by the callback.

**password** *rwflag size*
: Invoked when loading or storing an encrypted PEM certificate. The arguments are:

    *rwflag*
    : The read/write flag is 0 for reading/decryption or 1 for writing/encryption. The latter can be used to determine when to prompt the user to confirm. This argument is new for TclTLS 1.8.

    *size*
    : The size is the maximum length of the password in bytes. This argument is new for TclTLS 1.8.



## Values for validate command callback

The callback for the **-validatecommand** option is invoked during the handshake process in order for the application to validate the provided value(s). See below for the possible arguments passed to the callback script. If not specified, OpenSSL will accept all valid certificates and extensions. To reject the value and abort the connection, the callback should return 0. To accept the value and continue the connection, it should return 1. To reject the value, but continue the connection, it should return 2. This callback is new for TclTLS 1.8.

**alpn** *channelId protocol match*
: For servers, this form of callback is invoked when the client ALPN extension is received. If *match* is true, then *protocol* is the first **-alpn** protocol option in common to both the client and server. If not, the first client specified protocol is used. This callback is called after the Hello and SNI callbacks.

**hello** *channelId servername session\_id*
: For servers, this form of callback is invoked during client hello message processing. The purpose is so the server can select the appropriate certificate to present to the client, and to make other configuration adjustments relevant to that server name and its configuration. It is called before the SNI and ALPN callbacks.

**sni** *channelId servername*
: For servers, this form of callback is invoked when the Server Name Indication (SNI) extension is received. The *servername* argument is the client provided server name specified in the **-servername** option. The purpose is so when a server supports multiple names, the right certificate can be used. It is called after the Hello callback but before the ALPN callback.

**verify** *channelId depth cert status error*
: This form of callback is invoked by OpenSSL when a new certificate is received from the peer. It allows the client to check the certificate verification results and choose whether to continue or not. It is called for each certificate in the certificate chain. This callback was moved from **-command** in TclTLS 1.8. The arguments are:

    *depth*
    : The depth is the integer depth of the certificate in the certificate chain, where 0 is the peer certificate and higher values going up to the Certificate Authority (CA).

    *cert*
    : The cert argument is a list of key-value pairs similar to those returned by **tls::status**.

    *status*
    : The status argument is the boolean validity of the current certificate where 0 is invalid and 1 is valid.

    *error*
    : The error argument is the error message, if any, generated by **X509\_STORE\_CTX\_get\_error()**.



Reference implementations of these callbacks are provided in "*tls.tcl*" as **tls::callback**, **tls::password**, and **tls::validate\_command** respectively. Note that these are only *sample* implementations. In a more realistic deployment you would specify your own callback scripts on each TLS channel using the **-command**, **-password**, and **-validate\_command** options.

The default behavior when the **-command** and **-validate\_command** options are not specified, is for TclTLS to process the associated library callbacks internally. The default behavior when the **-password** option is not specified is for TclTLS to process the associated library callbacks by attempting to call **tls::password**. The difference between these two behaviors is a consequence of maintaining compatibility with earlier implementations.

*The use of the reference callbacks* **tls::callback**, **tls::password**, and **tls::validate\_command** is not recommended. They may be removed from future releases.

# Debug

For most debugging needs, the **-callback** option can be used to provide sufficient insight and information on the TLS handshake and progress. If further troubleshooting insight is needed, the compile time option **--enable-debug** can be used to get detailed execution flow status.

TLS key logging can be enabled by setting the environment variable **SSLKEYLOGFILE** to the name of the file to log to. Then whenever TLS key material is generated or received it will be logged to the file. This is useful for logging key data for network logging tools to use to decrypt the data.

The **tls::debug** variable provides some additional control over the debug logging in the **tls::callback**, **tls::password**, and **tls::validate\_command** default handlers in "*tls.tcl*". The default value is 0 with higher values producing more diagnostic output, and will also force the verify method in **tls::callback** to accept the certificate, even if it is invalid when the **-validatecommand** option is set to **tls::validate\_command**.

*The use of the variable* **tls::debug** is not recommended. It may be removed from future releases.

# Examples

The following are example scripts to download a webpage and file using the http package. See [Certificate Validation] for when the **-cadir**, **-cafile**, and **-castore** options are also needed. See the "*demos*" directory for more example scripts.

Example #1: Download a web page

```
package require http
package require tls

set url "https://www.tcl.tk/"
http::register https 443 [list ::tls::socket -autoservername 1 -require 1]

# Get URL
set token [http::geturl $url]

# Check for error
if {[http::status $token] ne "ok"} {
    puts [format "Error %s" [http::status $token]]
}

# Save web page to file
set ch [open example.html wb]
puts $ch [http::data $token]
close $ch

# Cleanup
::http::cleanup $token
```

Example #2: Download a file

```
package require http
package require tls

set url "https://wiki.tcl-lang.org/sitemap.xml"
http::register https 443 [list ::tls::socket -autoservername 1 -require 1]

# Open output file
set filename [file tail $url]
set ch [open $filename wb]

# Get file
set token [::http::geturl $url -blocksize 65536 -channel $ch]

# Check for error
if {[http::status $token] ne "ok"} {
    puts [format "Error %s" [http::status $token]]
}

# Cleanup
close $ch
::http::cleanup $token
```

# Special considerations

The capabilities of this package can vary enormously based upon how the linked to OpenSSL library was configured and built. New versions may obsolete older protocol versions, add or remove ciphers, change default values, etc. Use the **tls::protocols** command to obtain the supported protocol versions.

# Error messages

Some OpsnSSl error messages have cryptic meanings. This is a list of messages along with their true meaning.

*handshake failed: certificate verify failed due to "unable to get local issuer certificate"*
: The certificates in the CA file or certificate store either do not have one or more issuers of the certificates you are validating or they have expired. Usually this means you need an updated CAcert file.

*packet length too long*
: Client has tried to connect to a HTTP server on the plain-text port instead of the SSL/TLS port.

*unexpected eof while reading*
: The peer has closed the connection without sending the "close notify" shutdown alert. Some servers will terminate the connection after the file or webpage has been sent without sending the "close notify" message. In this case, it should not result in a loss of data.

*wrong version number*
: Client has tried to connect to a non-HTTP server on a non-TLS (i.e. plain text) port.


# Category

tls

# Copyright

```
Copyright (c) 1999 Matt Newman
Copyright (c) 2004 Starfish Systems
Copyright (c) 2024 Brian O'Hagan
```
