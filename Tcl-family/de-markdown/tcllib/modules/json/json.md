---
CommandName: json
ManualSection: n
Version: 1.3.6
TclPart: tcllib
TclDescription: JSON
Keywords:
 - data exchange
 - exchange format
 - javascript
 - json
Copyright:
 - Copyright (c) 2006 ActiveState Software Inc.
 - Copyright (c) 2009 Thomas Maeder, Glue Software Engineering AG
---

# NAME

json – JSON-Parser

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [json]{.lit} [1.3.6]{.optlit} 
[::json::json2dict]{.cmd} [json_txt]{.arg} 
[::json::many-json2dict]{.cmd} [json_txt]{.arg} [max]{.optarg} 
:::

# BESCHREIBUNG

Das **json**-Paket bietet eine einfache, ausschließlich auf Tcl basierende Bibliothek zum Parsen des [JSON](http://www.json.org/)-Datenaustauschformats, wie es in [RFC 4627](http://www.ietf.org/rfc/rfc4627.txt) festgelegt ist. Beim Parsen von JSON bestehen gewisse Unklarheiten, da JSON Typinformationen enthält, die bei der Konvertierung durch dieses Modul nicht beibehalten werden. Außerdem werden JSON-**null**-Werte in das String-Literal „null“ konvertiert (siehe [Ticket ](https://core.tcl-lang.org/tcllib/tktview/2aa0cebb88)). Das **json**-Paket gibt Daten entweder als Tcl-**dict** oder als **list** zurück, die wiederum verschachtelte **dict**s oder **list**s enthalten können. (Für die Verwendung ist entweder das **dict**-Paket oder Tcl 8.5 oder höher erforderlich.)

Eine alternative, ausschließlich auf Tcl basierende, typkonservierende Implementierung finden Sie im Modul [typed-json](https://wiki.tcl-lang.org/page/typed-json)].

# BEFEHLE

**::json::json2dict** *json_txt*
: Gibt ein **dict** oder eine **list** zurück (die wiederum verschachtelte **dict**s und/oder **list**s enthalten können), das bzw. die das Ergebnis der Analyse des in *json_txt* übergebenen JSON-formatierten Textes ist. Wenn *json_txt* mehr als eine JSON-Entität enthält, gibt es nur die erste zurück.

**::json::many-json2dict** *json_txt* ?*max*?
: Gibt eine **list** zurück (die ihrerseits verschachtelte **dict**s und/oder **list**s enthält), die das Ergebnis der Analyse aller JSON-Entitäten (oder, wenn *max* festgelegt ist, der ersten *max* Entitäten) im JSON-formatierten Text ist, der in *json_txt* übergeben wurde. Wenn *max* festgelegt ist, muss es sich um eine positive ganze Zahl **> 0** handeln, andernfalls löst der Befehl einen Fehler aus. Wenn der JSON-formatierte Text verschachtelte Listen und Dicts enthält, gilt dies auch für das zurückgegebene Dict. In solchen Fällen kann der Zugriff auf einen Wert eine *Kombination* aus der Verwendung von dict get und lindex erfordern. (Siehe das zweite Beispiel.)


# BEISPIELE

Ein Beispiel für ein in Tcl konvertiertes JSON-Array. Ein JSON-Array wird als einzelnes Element mit mehreren Unterelementen zurückgegeben.

```
[
    {
       "precision": "zip",
       "Latitude":  37.7668,
       "Longitude": -122.3959,
       "Address":   "",
       "City":      "SAN FRANCISCO",
       "State":     "CA",
       "Zip":       "94107",
       "Country":   "US"
    },
    {
       "precision": "zip",
       "Latitude":  37.371991,
       "Longitude": -122.026020,
       "Address":   "",
       "City":      "SUNNYVALE",
       "State":     "CA",
       "Zip":       "94085",
       "Country":   "US"
    }
]
=>
{Country US Latitude 37.7668 precision zip State CA City {SAN FRANCISCO} Address {} Zip 94107 Longitude -122.3959} {Country US Latitude 37.371991 precision zip State CA City SUNNYVALE Address {} Zip 94085 Longitude -122.026020}
```

Ein Beispiel für ein JSON-Dikt, das einen Eintrag enthält, dessen Wert eine Liste von Dicts ist.

```
{
  "items": [
     {
      "snippet": {
        "title": "In The Shade",
        "channelTitle": "Flox - Topic"
      },
      "statistics": {
        "viewCount": "274"
      }
    }
  ]
}
=>
items {{snippet {title {In The Shade} channelTitle {Flox - Topic}} statistics {viewCount 274}}}
```

Angenommen, der im JSON-Format vorliegende Text befindet sich in der Variable **jdata**, dann kann er in ein **dict** umgewandelt und die Elemente extrahiert werden.

```
set d [json::json2dict $jdata]
set title [dict get [lindex [dict get $d items] 0] snippet title]
=>
In The Shade
```

Ein Beispiel für ein in Tcl konvertiertes JSON-Objekt. Ein JSON-Objekt wird als Liste mit mehreren Elementen (ein „dict“) zurückgegeben.

```
{
    "Image": {
        "Width":  800,
        "Height": 600,
        "Title":  "View from 15th Floor",
        "Thumbnail": {
            "Url":    "http://www.example.com/image/481989943",
            "Height": 125,
            "Width":  "100"
        },
        "IDs": [116, 943, 234, 38793]
    }
}
=>
Image {IDs {116 943 234 38793} Thumbnail {Width 100 Height 125 Url http://www.example.com/image/481989943} Width 800 Height 600 Title {View from 15th Floor}}
```

# VERWANDTE THEMEN

Um JSON zu schreiben, anstatt es zu parsen, siehe das Paket **json::write**.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *json* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

CGI-Programmierung

# COPYRIGHT

```
Copyright (c) 2006 ActiveState Software Inc.
Copyright (c) 2009 Thomas Maeder, Glue Software Engineering AG
```
