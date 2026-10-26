---
CommandName: pki
ManualSection: n
Version: 0.22
TclPart: tcllib
TclDescription: public key encryption
Links:
 - aes(n)
 - blowfish(n)
 - des(n)
 - md5(n)
 - sha1(n)
Keywords:
 - cipher
 - data integrity
 - encryption
 - public key cipher
 - rsa
 - security
Copyright:
 - Copyright (c) 2010, 2011, 2012, 2013, 2021 - 2024 Roy Keene, Andreas Kupries, Ashok P. Nadkarni
---

# Name

pki - Implementation of the public key cipher

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pki]{.lit} [0.22]{.optlit} 
[::pki::encrypt]{.cmd} [-binary]{.optarg} [-hex]{.optarg} [-pad]{.optarg} [-nopad]{.optarg} [-priv]{.optarg} [-pub]{.optarg} [--]{.optarg} [input]{.arg} [key]{.arg} 
[::pki::decrypt]{.cmd} [-binary]{.optarg} [-hex]{.optarg} [-unpad]{.optarg} [-nounpad]{.optarg} [-priv]{.optarg} [-pub]{.optarg} [--]{.optarg} [input]{.arg} [key]{.arg} 
[::pki::sign]{.cmd} [input]{.arg} [key]{.arg} [algo]{.optarg} 
[::pki::verify]{.cmd} [signedmessage]{.arg} [plaintext]{.arg} [key]{.arg} [algo]{.optarg} 
[::pki::key]{.cmd} [key]{.arg} [password]{.optarg} [encodePem]{.optarg} 
[::pki::pkcs::parse_key]{.cmd} [key]{.arg} [password]{.optarg} 
[::pki::x509::parse_cert]{.cmd} [cert]{.arg} 
[::pki::rsa::generate]{.cmd} [bitlength]{.arg} [exponent]{.optarg} 
[::pki::x509::verify_cert]{.cmd} [cert]{.arg} [trustedcerts]{.arg} [intermediatecerts]{.optarg} 
[::pki::x509::validate_cert]{.cmd} [cert]{.arg} [-sign_message dn_of_signer]{.optarg} [-encrypt_message dn_of_signer]{.optarg} [-sign_cert dn_to_be_signed ca_depth]{.optarg} [-ssl dn]{.optarg} 
[::pki::pkcs::create_csr]{.cmd} [keylist]{.arg} [namelist]{.arg} [encodePem]{.optarg} [algo]{.optarg} 
[::pki::pkcs::parse_csr]{.cmd} [csr]{.arg} 
[::pki::x509::create_cert]{.cmd} [signreqlist]{.arg} [cakeylist]{.arg} [serial_number]{.arg} [notBefore]{.arg} [notAfter]{.arg} [isCA]{.arg} [extensions]{.arg} [encodePem]{.optarg} [algo]{.optarg} 
:::

# Description

# Commands

**::pki::encrypt** ?*-binary*? ?*-hex*? ?*-pad*? ?*-nopad*? ?*-priv*? ?*-pub*? ?*--*? *input* *key*
: Encrypt a message using PKI (probably RSA). Requires the caller to specify either **-priv** to encrypt with the private key or **-pub** to encrypt with the public key.  The default option is to pad and return in hex.  One of **-pub** or **-priv** must be specified. The **-hex** option causes the data to be returned in encoded as a hexidecimal string, while the **-binary** option causes the data to be returned as a binary string.  If they are specified multiple times, the last one specified is used. The **-pad** option causes the data to be padded per PKCS#1 prior to being encrypted.  The **-nopad** inhibits this behaviour.  If they are specified multiple times, the last one specified is used. The input to encrypt is specified as *input*. The *key* parameter, holding the key to use, is a return value from either **::pki::pkcs::parse_key**, **::pki::x509::parse_cert**, or **::pki::rsa::generate**. Mapping to OpenSSL's **openssl** application:


**\[1\]**
: "openssl rsautl -encrypt" == "::pki::encrypt -binary -pub"

**\[2\]**
: "openssl rsautl -sign"    == "::pki::encrypt -binary -priv"


**::pki::decrypt** ?*-binary*? ?*-hex*? ?*-unpad*? ?*-nounpad*? ?*-priv*? ?*-pub*? ?*--*? *input* *key*
: Decrypt a message using PKI (probably RSA). See **::pki::encrypt** for option handling. Mapping to OpenSSL's **openssl** application:


**\[1\]**
: "openssl rsautl -decrypt" == "::pki::decrypt -binary -priv"

**\[2\]**
: "openssl rsautl -verify"  == "::pki::decrypt -binary -pub"


**::pki::sign** *input* *key* ?*algo*?
: Digitally sign message *input* using the private *key*. If *algo* is ommited "sha1" is assumed. Possible values for *algo* include "**md5**", "**sha1**", "**sha256**", and "**raw**". Specifying "**raw**" for *algo* will inhibit the building of an ASN.1 structure to encode which hashing algorithm was chosen. *Attention*: In this case the corresponding **pkgi::verify** must be called **with** algorithm information. Conversely, specifying a non-"**raw**" algorithm here means that the corresponding **pkgi::verify** invokation has to be made *without* algorithm information. The *input* should be the plain text, hashing will be performed on it. The *key* should include the private key.

**::pki::verify** *signedmessage* *plaintext* *key* ?*algo*?
: Verify a digital signature using a public *key*.  Returns true or false. *Attention*: The algorithm information *algo* has to be specified if and only if the **pki::sign** which generated the *signedmessage* was called with algorithm "**raw**". This inhibited the building of the ASN.1 structure encoding the chosen hashing algorithm. Conversely, if a proper algorithm was specified during signing then you *must not* specify an algorithm here.

**::pki::key** *key* ?*password*? ?*encodePem*?
: Convert a key structure into a serialized PEM (default) or DER encoded private key suitable for other applications.  For RSA keys this means PKCS#1.

**::pki::pkcs::parse_key** *key* ?*password*?
: Convert a PKCS#1 private *key* into a usable key, i.e. one which can be used as argument for **::pki::encrypt**, **::pki::decrypt**, **::pki::sign**, and **::pki::verify**.

**::pki::x509::parse_cert** *cert*
: Convert an X.509 certificate to a usable (public) key. The returned dictionary can be used as argument for **::pki:encrypt**, **::pki::decrypt**, and **::pki::verify**. The *cert* argument can be either PEM or DER encoded. In addition to the public keying information, the dictionary contains the following keys containing certificate content as defined in [RFC5280](https://www.rfc-editor.org/rfc/rfc5280#section-4.1):


**•**
: **subject** holds the name of the subject from the certificate.

**•**
: **issuer** holds the name of the issuing CA.

**•**
: **serial_number** holds the serial number of the certificate.

**•**
: **notBefore** holds the starting date for certificate validity.

**•**
: **notAfter** holds the ending date for certificate validity.

**•**
: **version** holds the X.509 version format.

**•**
: **extensions** holds a dictionary containing the extensions included in the certificate (see below).


: The dictionary holds additional entries related to keying. These are intended for use of the above-mentioned commands for cryptographic operations. The **extensions** key in the returned dictionary holds a nested dictionary whose keys correspond to the names (with same exact case) in [Certificate Extensions](https://www.rfc-editor.org/rfc/rfc5280#section-4.2) in RFC5280. The format of each value is also based on the ASN.1 structures defined there. See the *Examples* \[#section3\] for an illustration.


**::pki::rsa::generate** *bitlength* ?*exponent*?
: Generate a new RSA key pair, the parts of which can be used as argument for **::pki::encrypt**, **::pki::decrypt**, **::pki::sign**, and **::pki::verify**. The *bitlength* argument is the length of the public key modulus. The *exponent* argument should generally not be specified unless you really know what you are doing.

**::pki::x509::verify_cert** *cert* *trustedcerts* ?*intermediatecerts*?
: Verify that a trust can be found between the certificate specified in the *cert* argument and one of the certificates specified in the list of certificates in the *trustedcerts* argument.  (Eventually the chain can be through untrusted certificates listed in the *intermediatecerts* argument, but this is currently unimplemented). The certificates specified in the *cert* and *trustedcerts* option should be parsed (from **::pki::x509::parse_cert**).

**::pki::x509::validate_cert** *cert* ?**-sign_message** *dn_of_signer*? ?**-encrypt_message** *dn_of_signer*? ?**-sign_cert** *dn_to_be_signed* *ca_depth*? ?**-ssl** *dn*?
: Validate that a certificate is valid to be used in some capacity.  If multiple options are specified they must all be met for this procedure to return "true". Currently, only the **-sign_cert** option is functional. Its arguments are *dn_to_be_signed* and *ca_depth*.  The *dn_to_be_signed* is the distinguished from the subject of a certificate to verify that the certificate specified in the *cert* argument can sign.  The *ca_depth* argument is used to indicate at which depth the verification should be done at.  Some certificates are limited to how far down the chain they can be used to verify a given certificate.

**::pki::pkcs::create_csr** *keylist* *namelist* ?*encodePem*? ?*algo*?
: Generate a certificate signing request from a key pair specified in the *keylist* argument. The *namelist* argument is a list of "name" followed by "value" pairs to encoding as the requested distinguished name in the CSR. The *encodePem* option specifies whether or not the result should be PEM encoded or DER encoded.  A "true" value results in the result being PEM encoded, while any other value 9results in the the result being DER encoded.  DER encoding is the default. The *algo* argument specifies the hashing algorithm we should use to sign this certificate signing request with.  The default is "sha1". Other possible values include "md5" and "sha256".

**::pki::pkcs::parse_csr** *csr*
: Parse a Certificate Signing Request. The *csr* argument can be either PEM or DER encoded. The command returns a dictionary that includes the following keys:


**•**
: **subject** - contains the subject name from the CSR.

**•**
: **type** - contains the public key algorithm name. Currently only **rsa** is supported.

**•**
: **extensionRequest** - contains a dictionary with the contents of the **extensionRequest** <https://datatracker.ietf.org/doc/html/rfc2986#page-5> information in the CSR. This has the same form as described for the **extensions** dictionary in the documentation for **parse_cert**.


: There may be other keys in the dictionary related to the public key algorithm in use.


**::pki::x509::create_cert** *signreqlist* *cakeylist* *serial_number* *notBefore* *notAfter* *isCA* *extensions* ?*encodePem*? ?*algo*?
: Sign a signing request (usually from **::pki::pkcs::create_csr** or **::pki::pkcs::parse_csr**) with a Certificate Authority (CA) certificate. The *signreqlist* argument should be the parsed signing request. The *cakeylist* argument should be the parsed CA certificate. The *serial_number* argument should be a serial number unique to this certificate from this certificate authority. The *notBefore* and *notAfter* arguments should contain the time before and after which (respectively) the certificate should be considered invalid.  The time should be encoded as something **clock format** will accept (i.e., the results of **clock seconds** and **clock add**). The *isCA* argument is a boolean argument describing whether or not the signed certificate should be a a CA certificate.  If specified as true the "id-ce-basicConstraints" extension is added with the arguments of "critical" being true, "allowCA" being true, and caDepth being -1 (infinite). The *extensions* argument is a list of extensions and their parameters that should be encoded into the created certificate.   Currently only one extension is understood ("id-ce-basicConstraints").  It accepts three arguments *critical* *allowCA* *caDepth*.  The *critical* argument to this extension (and any extension) whether or not the validator should reject the certificate as invalid if it does not understand the extension (if set to "true") or should ignore the extension (if set to "false").  The *allowCA* argument is used to specify as a boolean value whether or not we can be used a certificate authority (CA).  The *caDepth* argument indicates how many children CAs can be children of this CA in a depth-wise fashion.  A value of "0" for the *caDepth* argument means that this CA cannot sign a CA certificate and have the result be valid.  A value of "-1" indicates infinite depth.


# Examples

The example below retrieves a certificate from *www.example.com* using the TLS extension and dumps its content.

```
    % set so [tls::socket www.example.com 443]
    sock00000229EB84E710
    % tls::handshake $so
    1
    % set status [tls::status $so]
    ...output not shown...
    % set cert_pem [dict get $status certificate]
    ...output not shown...
    % set cert [::pki::x509::parse_cert $cert_pem]
    ...output not shown...
    % dict get $cert subject
    C=US, ST=California, L=Los Angeles, O=Internet Corporation for Assigned Names and Numbers, CN=www.example.org
    % dict get $cert issuer
    C=US, O=DigiCert Inc, CN=DigiCert TLS RSA SHA256 2020 CA1
    % clock format [dict get $cert notAfter]
    Sun Dec 26 05:29:59 +0530 2021
    % set extensions [dict get $cert extensions]
    ...output not shown...
    % dict keys $extensions
    authorityKeyIdentifier subjectKeyIdentifier subjectAltName keyUsage extKeyUsage cRLDistributionPoints certificatePolicies authorityInfoAccess id-ce-basicConstraints basicConstraints 1.3.6.1.4.1.11129.2.4.2
    dict get $extensions basicConstraints
    1 {0 -1}
    % dict get $extensions keyUsage
    1 {5 digitalSignature keyEncipherment}
    % dict get $extensions extKeyUsage
    0 {serverAuth clientAuth}
    % dict get $extensions subjectAltName
    0 {dNSName www.example.org dNSName example.com dNSName example.edu dNSName example.net dNSName example.org dNSName www.example.com dNSName www.example.edu dNSName www.example.net}
    % dict get $extensions basicConstraints
    1 {0 -1}
    % dict get $extensions keyUsage
    1 {5 digitalSignature keyEncipherment}
    % dict get $extensions extKeyUsage
    0 {serverAuth clientAuth}
```

# References

**\[1\]**
: [Internet X.509 Public Key Infrastructure Certificate and Certificate Revocation List (CRL) Profile](https://www.rfc-editor.org/rfc/rfc5280)

**\[2\]**
: [New ASN.1 Modules for the Public Key Infrastructure Using X.509 (PKIX)](https://www.rfc-editor.org/rfc/rfc5912)

**\[3\]**
: [PKCS #10: Certification Request Syntax Specification](https://www.rfc-editor.org/rfc/rfc2986)


# Authors

Roy Keene, Ashok P. Nadkarni

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *rsa* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2010, 2011, 2012, 2013, 2021 - 2024 Roy Keene, Andreas Kupries, Ashok P. Nadkarni
```
