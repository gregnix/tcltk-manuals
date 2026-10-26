---
CommandName: tcllib_ip
title: tcllib_ip
ManualSection: n
Version: 1.5.1
TclPart: tcllib
TclDescription: Domain Name Service
Links:
 - inet(3)
 - ip(7)
 - ipv6(7)
Keywords:
 - internet address
 - ip
 - ipv4
 - ipv6
 - rfc 3513
Copyright:
 - Copyright (c) 2004, Pat Thoyts
 - Copyright (c) 2005 Aamer Akhter <aakhter@cisco.com>
---

# Name

tcllib\_ip – Bearbeitung von IPv4- und IPv6-Adressen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [ip]{.lit} [1.5.1]{.optlit}
[::ip::version]{.cmd} [address]{.arg}
[::ip::is]{.cmd} [class]{.arg} [address]{.arg}
[::ip::equal]{.cmd} [address]{.arg} [address]{.arg}
[::ip::normalize]{.cmd} [address]{.arg}
[::ip::contract]{.cmd} [address]{.arg}
[::ip::distance]{.cmd} [ipaddr1]{.arg} [ipaddr2]{.arg}
[::ip::nextIp]{.cmd} [ipaddr]{.arg} [offset]{.optarg}
[::ip::prefix]{.cmd} [address]{.arg}
[::ip::type]{.cmd} [address]{.arg}
[::ip::mask]{.cmd} [address]{.arg}
[::ip::prefixToNative]{.cmd} [prefix]{.arg}
[::ip::nativeToPrefix]{.cmd} [nativeList|native]{.arg} [-ipv4]{.optlit}
[::ip::intToString]{.cmd} [number]{.arg} [-ipv4]{.optlit}
[::ip::toInteger]{.cmd} [ipaddr]{.arg}
[::ip::toHex]{.cmd} [ipaddr]{.arg}
[::ip::maskToInt]{.cmd} [ipmask]{.arg}
[::ip::broadcastAddress]{.cmd} [prefix]{.arg} [-ipv4]{.optlit}
[::ip::maskToLength]{.cmd} [dottedMask|integerMask|hexMask]{.arg} [-ipv4]{.optlit}
[::ip::lengthToMask]{.cmd} [maskLength]{.arg} [-ipv4]{.optlit}
[::ip::nextNet]{.cmd} [ipaddr]{.arg} [ipmask]{.arg} [count]{.optarg} [-ipv4]{.optlit}
[::ip::isOverlap]{.cmd} [prefix]{.arg} [prefix...]{.arg}
[::ip::isOverlapNative]{.cmd} [-all]{.optlit} [-inline]{.optlit} [-ipv4]{.optlit} [hexipaddr]{.arg} [hexipmask]{.arg} [hexiplist]{.arg}
[::ip::ipToLayer2Multicast]{.cmd} [ipaddr]{.arg}
[::ip::ipHostFromPrefix]{.cmd} [prefix]{.arg} [[-exclude]{.lit} [prefixExcludeList]{.arg}]{.optarg}
[::ip::reduceToAggregates]{.cmd} [prefixlist]{.arg}
[::ip::longestPrefixMatch]{.cmd} [ipaddr]{.arg} [prefixlist]{.arg} [-ipv4]{.optlit}
[::ip::collapse]{.cmd} [prefixlist]{.arg}
[::ip::subtract]{.cmd} [prefixlist]{.arg}
:::

# Beschreibung

Dieses Paket enthält eine Reihe von Befehlen, die beim Analysieren, Anzeigen und Vergleichen von Internetadressen helfen. Das Paket unterstützt sowohl IPv4- (1) als auch IPv6- (2) Adresstypen.

# Befehle

**::ip::version** *address*
: Gibt die Protokollversion der Adresse zurück (**4** oder **6**) oder **-1**, wenn es sich bei der Adresse weder um eine IPv4- noch um eine IPv6-Adresse handelt.

**::ip::is** *class* *address*
: Gibt „true“ zurück, wenn die Adresse zur angegebenen Protokollklasse gehört. Der Klassenparameter kann entweder **ipv4** oder **ipv6** lauten. Dies entspricht im Wesentlichen dem Befehl **version** in Form eines booleschen Werts. Das Argument *class* kann auf **4** oder **6** verkürzt werden.

**::ip::equal** *address* *address*
: Vergleicht zwei Adressangaben auf Gleichheit. Die Argumente werden normalisiert und das Adresspräfix ermittelt (sofern eine Maske angegeben wird). Die normalisierten Adressen werden anschließend Bit für Bit verglichen, und die Prozedur gibt „wahr“ zurück, wenn sie übereinstimmen.

**::ip::normalize** *address*
: Wandelt eine IPv4- oder IPv6-Adresse in eine vollständig ausgeschriebene Version um. Es gibt verschiedene Kurzschreibweisen für Internetadressen, bei denen überflüssige Teile oder Ziffern weggelassen werden. Diese Prozedur ist das Gegenteil von **contract**.

**::ip::contract** *address*
: Wandelt die Internetadresse „**normalize**d“ in eine kompaktere Form um, die für die Anzeige gegenüber den Benutzern geeignet ist.

**::ip::distance** *ipaddr1* *ipaddr2*
: Dieser Befehl berechnet den (ganzzahligen) Abstand zwischen der IPv4-Adresse *ipaddr1* und der IPv4-Adresse *ipaddr2*, d. h. „ipaddr2 – ipaddr1“

    ```
       % ::ip::distance 1.1.1.1  1.1.1.5
       4
    ```

**::ip::nextIp** *ipaddr* ?*offset*?
: Dieser Befehl addiert die Ganzzahl *offset* zur IPv4-Adresse *ipaddr* und gibt die neue IPv4-Adresse zurück.

    ```
       % ::ip::distance 1.1.1.1  4
       1.1.1.5
    ```

**::ip::prefix** *address*
: Gibt das Adresspräfix zurück, das durch Maskierung des Adressteils mit der Maske generiert wurde, sofern eine solche angegeben wurde. Liegt keine Maske vor, entspricht dies dem Aufruf von **normalize**.

**::ip::type** *address*
: siehe unten ...

**::ip::mask** *address*
: Wenn die angegebene Adresse eine Maske enthält, gibt sie diese zurück; andernfalls gibt sie eine leere Zeichenkette zurück.

**::ip::prefixToNative** *prefix*
: Dieser Befehl konvertiert die Zeichenfolge *prefix* aus der Punktnotation (im Format <ipaddr>/<mask>) in die native (hexadezimale) Form. Gibt eine Liste zurück, die zwei Elemente – „ipaddress“ und „mask“ – in dieser Reihenfolge in hexadezimaler Schreibweise enthält.

    ```
       % ip::prefixToNative 1.1.1.0/24
       0x01010100 0xffffff00
    ```

**::ip::nativeToPrefix** *nativeList*|*native* ?**-ipv4**?
: Dieser Befehl wandelt die native (Hexadezimal-)Darstellung in die Punktnotation um. Er ist das Gegenstück zu **::ip::prefixToNative**.

    list *nativeList* (in)
    : Liste mehrerer IP-Adressen in nativer Form. Die native Form ist eine Liste, wie sie von der Funktion **::ip::prefixToNative** zurückgegeben wird.

    list *native* (in)
    : Eine Liste, wie sie von der Funktion **::ip::prefixToNative** zurückgegeben wird.


    Der Befehl gibt eine Liste von Adressen in Punktnotation zurück, wenn er mit einer Liste von Adressen aufgerufen wurde. Andernfalls wird eine einzelne Adresse in Punktnotation zurückgegeben.

    ```
       % ip::nativeToPrefix {0x01010100 0xffffff00} -ipv4
       1.1.1.0/24
    ```

**::ip::intToString** *number* ?**-ipv4**?
: Dieser Befehl wandelt eine als Ganzzahl festgelegte IP-Adresse in die Punktnotation um.

    ```
           ip::intToString 4294967295
           255.255.255.255
    ```

**::ip::toInteger** *ipaddr*
: Dieser Befehl wandelt eine IP-Adresse in Punktnotation in eine Ganzzahl um.

    ```
       % ::ip::toInteger 1.1.1.0
       16843008
    ```

**::ip::toHex** *ipaddr*
: Dieser Befehl wandelt eine IP-Adresse in Punktnotation in eine Hexadezimalzahl um.

    ```
       % ::ip::toHex 1.1.1.0
       0x01010100
    ```

**::ip::maskToInt** *ipmask*
: Dieser Befehl wandelt eine IP-Maske entweder im Punktnotationsformat (255.255.255.0) oder im Längenformat (24) in eine Ganzzahl um.

    ```
       ::ip::maskToInt 24
       4294967040
    ```

**::ip::broadcastAddress** *prefix* ?**-ipv4**?
: Dieser Befehl gibt eine Broadcast-Adresse im Punktnotationsformat für das angegebene Routenpräfix *prefix* zurück, entweder in der Form „addr/mask“ oder im nativen Format. Das Ergebnis liegt im Punktnotationsformat vor.

    ```
       ::ip::broadcastAddress 1.1.1.0/24
       1.1.1.255

       ::ip::broadcastAddress {0x01010100 0xffffff00}
       0x010101ff
    ```

**::ip::maskToLength** *dottedMask*|*integerMask*|*hexMask* ?**-ipv4**?
: Dieser Befehl wandelt die Punkt- oder Ganzzahlform einer IP-Maske in die Form der Maskenlänge um.

    ```
       ::ip::maskToLength 0xffffff00 -ipv4
       24

       % ::ip::maskToLength 255.255.255.0
       24
    ```

**::ip::lengthToMask** *maskLength* ?**-ipv4**?
: Dieser Befehl wandelt eine IP-Maske im Format „Maskenlänge“ in die Punktnotation um.

    ```
       ::ip::lengthToMask 24
       255.255.255.0
    ```

**::ip::nextNet** *ipaddr* *ipmask* ?*count*? ?**-ipv4**?
: Dieser Befehl gibt eine IP-Adresse an derselben Position im *count*-ten nachfolgenden Netzwerk zurück. Der Standardwert für *count* lautet **1**.

    Die Adresse kann entweder als Ganzzahl oder in Punktnotation angegeben werden. Die Maske kann entweder als Ganzzahl, in Punktnotation oder in Form der Maskenlänge angegeben werden.

    Das Ergebnis wird im Hexadezimalformat ausgegeben.

**::ip::isOverlap** *prefix* *prefix*...
: Dieser Befehl prüft, ob sich die angegebenen IP-Präfixe überschneiden. Alle Argumente liegen im Format „Adresse/Maske“ mit Punkttrennung vor. Alle Argumente nach dem ersten Präfix werden mit dem ersten Präfix verglichen. Das Ergebnis ist ein boolescher Wert. Er ist wahr, wenn bei einem der Präfixe eine Überschneidung festgestellt wurde.

    ```
      % ::ip::isOverlap 1.1.1.0/24 2.1.0.1/32
      0

      ::ip::isOverlap 1.1.1.0/24 2.1.0.1/32 1.1.1.1/32
      1
    ```

**::ip::isOverlapNative** ?**-all**? ?**-inline**? ?**-ipv4**? *hexipaddr* *hexipmask* *hexiplist*
: Dieser Befehl ähnelt dem Befehl **::ip::isOverlap**, allerdings liegen die Argumente in ihrer nativen Form vor, und die Form des Ergebnisses lässt sich vom Aufrufer besser steuern. Wenn die Option **-all** festgelegt wird, werden alle Adressen auf Überschneidungen überprüft, nicht nur bis zur ersten gefundenen Adresse. Wenn die Option **-inline** festgelegt wird, gibt der Befehl anstelle von Index-Werten das überlappende Präfix zurück.

    Das Ergebnis des Befehls ist, abhängig von den angegebenen Optionen,

    no options
    : Der Index der ersten gefundenen Überlappung oder 0, falls keine vorhanden ist.

    -all
    : Eine Liste, die die Indizes aller gefundenen Überschneidungen enthält, oder eine leere Liste, falls keine vorhanden sind.

    -inline
    : Das erste überlappende Präfix oder, wenn kein solches vorhanden ist, eine leere Zeichenkette.

    -all -inline
    : Eine Liste, die die Präfixe aller gefundenen Überschneidungen enthält, oder eine leere Liste, falls keine vorhanden sind.


    ```
      % ::ip::isOverlapNative 0x01010100 0xffffff00 {{0x02010001 0xffffffff}}
      0

      % ::ip::isOverlapNative 0x01010100 0xffffff00 {{0x02010001 0xffffffff} {0x01010101 0xffffffff}}
      2
    ```

**::ip::ipToLayer2Multicast** *ipaddr*
: Dieser Befehl wandelt eine IPv4-Adresse in Punktnotation in eine Layer-2-Multicast-Adresse um, die ebenfalls in Punktnotation vorliegt.

    ```
      % ::ip::ipToLayer2Multicast 224.0.0.2
      01.00.5e.00.00.02
    ```

**::ip::ipHostFromPrefix** *prefix* ?**-exclude** *prefixExcludeList*?
: Dieser Befehl gibt eine Hostadresse aus einem Präfix im Format „ipaddr/masklen“ zurück und stellt dabei sicher, dass das Ergebnis keine Adresse ist, die in der *prefixExcludeList* enthalten ist. Das Ergebnis ist eine IP-Adresse im Punktnotationsformat.

    ```
      %::ip::ipHostFromPrefix  1.1.1.5/24
      1.1.1.1

      %::ip::ipHostFromPrefix  1.1.1.1/32
      1.1.1.1
    ```

**::ip::reduceToAggregates** *prefixlist*
: Dieser Befehl ermittelt sich überschneidende Netzwerke und filtert die spezifischeren Netzwerke heraus. Die Präfixe liegen entweder im Addr/Mask-Format oder im nativen Format vor. Das Ergebnis ist eine Liste, die die sich nicht überschneidenden IP-Präfixe aus der Eingabe enthält.

    ```
      % ::ip::reduceToAggregates {1.1.1.0/24 1.1.0.0/8  2.1.1.0/24 1.1.1.1/32 }
      1.0.0.0/8 2.1.1.0/24
    ```

**::ip::longestPrefixMatch** *ipaddr* *prefixlist* ?**-ipv4**?
: Dieser Befehl ermittelt bei Angabe einer bestimmten Hostadresse das längste übereinstimmende Präfix aus einer Reihe von Präfixen. Die Präfixe in der Liste liegen entweder in nativer Form oder in der mit Punkten getrennten Form vor, während die Hostadresse entweder im ipprefix-Format, in der mit Punkten getrennten Form oder als Ganzzahl vorliegt. Das Ergebnis ist das Präfix, das am genauesten mit der Hostadresse übereinstimmt.

    ```
      % ::ip::longestPrefixMatch 1.1.1.1 {1.1.1.0/24 1.0.0.0/8  2.1.1.0/24 1.1.1.0/28 }
      1.1.1.0/28
    ```

**::ip::collapse** *prefixlist*
: Dieser Befehl nimmt eine Liste von Präfixen entgegen und gibt eine Liste von Präfixen mit den größtmöglichen Subnetzmasken zurück, die die Eingabe abdecken, wodurch benachbarte Präfixe zu größeren Bereichen zusammengefasst werden.

    Dies unterscheidet sich von **::ip::reduceToAggregates** darin, dass letzterer lediglich bestimmte Netzwerke aus einer Liste entfernt, wenn diese von anderen Elementen der Eingabe abgedeckt werden, während dieser Befehl Netzwerke aktiv zu größeren Bereichen zusammenfasst, wenn sie aneinandergrenzen.

    ```
    % ::ip::collapse {1.2.2.0/24 1.2.3.0/24}
    1.2.2.0/23
    ```

**::ip::subtract** *prefixlist*
: Dieser Befehl erwartet eine Liste von Präfixen, von denen einige mit einem Bindestrich beginnen. Diese *negativen* Präfixe dienen dazu, Ausnahmen in den durch die anderen, *positiven* Präfixe beschriebenen Bereichen zu definieren. Das heißt, die negativen Präfixe werden von den positiven abgezogen, was zu einer umfangreicheren Liste von Beschreibungen führt, die die abgedeckten Bereiche ausschließlich als positive Werte beschreiben.


# Beispiele

```
% ip::version ::1
6
% ip::version 127.0.0.1
4
```

```
% ip::normalize 127/8
127.0.0.0/8
% ip::contract 192.168.0.0
192.168
%
% ip::normalize fec0::1
fec0:0000:0000:0000:0000:0000:0000:0001
% ip::contract fec0:0000:0000:0000:0000:0000:0000:0001
fec0::1
```

```
% ip::equal 192.168.0.4/16 192.168.0.0/16
1
% ip::equal fec0::1/10 fec0::fe01/10
1
```

# Literatur

1. Postel, J. „Internet Protocol“. RFC 791, September 1981, (<http://www.ietf.org/rfc/rfc791.txt>)

2. Hinden, R. und Deering, S., „Internet Protocol Version 6 (IPv6) Addressing Architecture“, RFC 3513, April 2003 (<http://www.ietf.org/rfc/rfc3513.txt>)


# Autoren

Pat Thoyts

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *dns* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk

# Copyright

```
Copyright (c) 2004, Pat Thoyts
Copyright (c) 2005 Aamer Akhter <aakhter@cisco.com>
```
