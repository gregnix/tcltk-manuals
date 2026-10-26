---
CommandName: idna
ManualSection: n
Version: 0.1
TclPart: http
TclDescription: Tcl Bundled Packages
Links:
 - http(n)
 - cookiejar(n)
Keywords:
 - internet
 - www
Copyright:
 - Copyright (c) 2014-2018 Donal K. Fellows.
---

# NAME

tcl::idna - Unterstützung für die Normalisierung internationalisierter Domainnamen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl::idna]{.lit} [1.0]{.lit} 

[tcl::idna]{.cmd} [decode]{.sub} [hostname]{.arg} 
[tcl::idna]{.cmd} [encode]{.sub} [hostname]{.arg} 
[tcl::idna]{.cmd} [puny]{.sub} [decode]{.lit} [string]{.arg} [case]{.optarg} 
[tcl::idna]{.cmd} [puny]{.sub} [encode]{.lit} [string]{.arg} [case]{.optarg} 
[tcl::idna]{.cmd} [version]{.sub} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine Implementierung des in internationalisierten Domainnamen verwendeten Punycode-Verfahrens sowie einige Zugriffsbefehle bereit. (Siehe RFC 3492 für eine Beschreibung von Punycode.)

**tcl::idna decode** *hostname*
: Nimmt einen Hostnamen *hostname*, der möglicherweise punycode-kodierte Zeichenfolgen enthält, und gibt den Hostnamen zurück, wie er einem Benutzer angezeigt werden könnte. Beachten Sie, dass es oft UNICODE-Zeichen mit extrem ähnlichen Glyphen gibt; Hostnamen sollten Benutzern daher mit Vorsicht angezeigt werden.

**tcl::idna encode** *hostname*
: Nimmt einen Hostnamen *hostname*, wie er einem Benutzer angezeigt werden könnte, und gibt die Variante zurück, in der in einfachen Hostnamen nicht zulässige Zeichen mit Punycode kodiert sind.

**tcl::idna puny** *subcommand ...*
: Bietet direkten Zugriff auf den grundlegenden Punycode-Encoder und -Decoder. Unterstützt zwei *subcommand*s:

**tcl::idna puny decode** *string* ?*case*?
: Dekodiert die punycode-kodierte Zeichenkette *string* und gibt das Ergebnis zurück. Ist *case* angegeben, ist es ein boolescher Wert: bei true wird die Schreibweise während der Dekodierung in Großbuchstaben, bei false in Kleinbuchstaben gefaltet; fehlt er, findet keine Schreibweisen-Transformation statt.

**tcl::idna puny encode** *string* ?*case*?
: Kodiert die Zeichenkette *string* und gibt die punycode-kodierte Version zurück. Ist *case* angegeben, ist es ein boolescher Wert: bei true wird die Schreibweise während der Kodierung in Großbuchstaben, bei false in Kleinbuchstaben gefaltet; fehlt er, findet keine Schreibweisen-Transformation statt.


**tcl::idna version**
: Gibt die Version des Pakets **tcl::idna** zurück.


# BEISPIEL

Beispiel für die Punycode-Kodierung einer Zeichenkette:

```
package require tcl::idna

puts [tcl::idna puny encode "abc→def"]
#    gibt aus: abcdef-kn2c
puts [tcl::idna puny decode "abcdef-kn2c"]
#    gibt aus: abc→def
```
