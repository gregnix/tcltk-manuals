---
CommandName: yaml
ManualSection: n
Version: 0.4.2
TclPart: tcllib
TclDescription: YAML processing
Links:
 - base64
 - huddle
 - json
Keywords:
 - data exchange
 - huddle
 - parsing
 - text processing
 - yaml
Copyright:
 - Copyright (c) 2008 KATO Kanryu <kanryu6@users.sourceforge.net>
---

# NAME

yaml – YAML-Format-Encoder/Decoder für die Kodierung und Dekodierung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [yaml]{.lit} [0.4.2]{.optlit} 
[::yaml::yaml2dict]{.cmd} [options]{.optarg} [txt]{.arg} 
[::yaml::yaml2huddle]{.cmd} [options]{.optarg} [txt]{.arg} 
[::yaml::setOption]{.cmd} [options]{.optarg} 
[::yaml::dict2yaml]{.cmd} [dict]{.arg} [indent]{.optarg} [wordwrap]{.optarg} 
[::yaml::list2yaml]{.cmd} [list]{.arg} [indent]{.optarg} [wordwrap]{.optarg} 
[::yaml::huddle2yaml]{.cmd} [huddle]{.arg} [indent]{.optarg} [wordwrap]{.optarg} 
:::

# BESCHREIBUNG

Das **yaml**-Paket bietet eine einfache, ausschließlich auf Tcl basierende Bibliothek zum Parsen des YAML-Datenaustauschformats *http://www.yaml.org/*, wie es unter *http://www.yaml.org/spec/1.1/* festgelegt ist.

Das **yaml**-Paket gibt Daten als Tcl-**dict** zurück. Für die Verwendung ist entweder das **dict**-Paket oder Tcl 8.5 erforderlich.

# BEFEHLE

**::yaml::yaml2dict** ?*options*? *txt*
: ...siehe nächstes...

**::yaml::yaml2huddle** ?*options*? *txt*
: YAML-formatierten Text *txt* in ein Tcl-Dict/Huddle parsen und den Wert geben.


**-file**
: *txt* ist der Dateiname eines YAML-Streams.

**-stream**
: *txt* ist lediglich ein YAML-Stream.

**-types** *list*
: Die *Liste* ist eine Typenliste für die YAML-Skalar-Typen (z. B. !!str !!timestamp !!integer !!true ...).


```
 -types {timestamp integer null true false}
```

: In diesem Fall, wenn eine Zeichenfolge mit „timestamp“ übereinstimmte, wurde sie in den TCL-internen Zeitstempel umgewandelt (z. B. „2001-12-15T02:59:43.1Z“ => 1008385183).


**-m:true** *param*
: Der *param* besteht aus zwei Elementen der Liste, die den Wert „true“ haben und als Zeichenfolgen betrachtet werden.


```
 -m:true {1 {true on + yes y}}
```

: In diesem Fall wurde die in YAML Stream gefundene Zeichenfolge „yes“ automatisch in 1 umgewandelt.


**-m:false** *param*
: Der *param* besteht aus zwei Elementen der Liste, die den Wert „false“ haben und als Zeichenfolgen betrachtet werden.


```
 -m:false {0 {false off - no n}}
```

**-m:null** *param*
: Der *param* besteht aus zwei Elementen der Liste, die den Wert „null“ haben und als Zeichenfolgen betrachtet werden.


```
 -m:null {"" {null nil "" ~}}
```

**-validate**
: Experiment, alt: Der Ausgabestrom enthält in jedem Knoten das YAML-Tag.


```
% puts [::yaml::load -validate {[aaa, bbb]}]
=>
!!seq {{!!str aaa} {!!str bbb}}
```

**::yaml::setOption** ?*options*?
: Ändert die impliziten Optionen für die Bibliothek. Die Parameter entsprechen nun denen von **::yaml::yaml2dict**. Die Argumente von **::yaml::yaml2dict** haben Vorrang vor dieser Einstellung.

**::yaml::dict2yaml** *dict* ?*indent*? ?*wordwrap*?
: ...siehe nächstes...

**::yaml::list2yaml** *list* ?*indent*? ?*wordwrap*?
: ...siehe nächstes...

**::yaml::huddle2yaml** *huddle* ?*indent*? ?*wordwrap*?
: Ein dict-/list-/huddle-Objekt in einen YAML-Stream umwandeln.


**indent**
: Einrückung jedes Blockknotens in Leerzeichen. Derzeit beträgt der Standardwert 2.

**wordwrap**
: Zeilenumbruch für YAML-Stream. Derzeit ist der Standardwert 40.


# BEISPIELE

Ein Beispiel für einen in Tcl konvertierten YAML-Stream. Ein YAML-Stream wird als einzelnes Element mit mehreren Unterelementen zurückgegeben.

```
{
--- !<tag:clarkevans.com,2002:invoice>
invoice: 34843
date   : 2001-01-23
bill-to: &id001
    given  : Chris
    family : Dumars
    address:
        lines: |
            458 Walkman Dr.
            Suite #292
        city    : Royal Oak
        state   : MI
        postal  : 48046
ship-to: *id001
product:
    - sku         : BL394D
      quantity    : 4
      description : Basketball
      price       : 450.00
    - sku         : BL4438H
      quantity    : 1
      description : Super Hoop
      price       : 2392.00
tax  : 251.42
total: 4443.52
comments:
    Late afternoon is best.
    Backup contact is Nancy
    Billsmer @ 338-4338.
}
=>
invoice 34843 date 2001-01-23 bill-to {given Chris family Dumars address {lines {458 Walkman Dr.
Suite #292
} city {Royal Oak} state MI postal 48046}} ship-to {given Chris family Dumars address {lines {458 Walkman Dr.
Suite #292
} city {Royal Oak} state MI postal 48046}} product {{sku BL394D quantity 4 description Basketball price 450.00} {sku BL4438H quantity 1 description {Super Hoop} price 2392.00}} tax 251.42 total 4443.52 comments {Late afternoon is best. Backup contact is Nancy Billsmer @ 338-4338.}
```

Ein Beispiel für ein in Tcl konvertiertes YAML-Objekt. Ein YAML-Objekt wird als Liste mit mehreren Elementen (ein Dict) zurückgegeben.

```
{
---
- [name        , hr, avg  ]
- [Mark McGwire, 65, 0.278]
- [Sammy Sosa  , 63, 0.288]
-
  Mark McGwire: {hr: 65, avg: 0.278}
  Sammy Sosa: { hr: 63, avg: 0.288}
}
=>
{name hr avg} {{Mark McGwire} 65 0.278} {{Sammy Sosa} 63 0.288} {{Mark McGwire} {hr 65 avg 0.278} {Sammy Sosa} {hr 63 avg 0.288}}
```

# EINSCHRÄNKUNGEN

Der Tag-Parser ist noch nicht implementiert. Derzeit werden Tags einfach ignoriert.

Nur Anker => Reihenfolge der Aliase. Rückverweise auf Aliase werden nicht unterstützt.

Zu viele Klammern oder zu wenige Klammern.

Der Zeichensatz für Zeilenvorschübe ist unzureichend. Bitte verwenden Sie als Zeilenumbrüche ausschließlich „\\n“.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *yaml* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# COPYRIGHT

```
Copyright (c) 2008 KATO Kanryu <kanryu6@users.sourceforge.net>
```
