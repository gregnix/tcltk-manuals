---
CommandName: huddle
title: huddle
ManualSection: n
Version: 0.5
TclPart: tcllib
TclDescription: HUDDLE
Links:
 - yaml
Keywords:
 - data exchange
 - exchange format
 - huddle
 - json
 - parsing
 - text processing
 - yaml
Copyright:
 - Copyright (c) 2008-2011 KATO Kanryu <kanryu6@users.sourceforge.net>
 - Copyright (c) 2015 Miguel Martínez López <aplicacionamedida@gmail.com>
---

# Name

huddle – Erstellen und Bearbeiten eines „huddle“-Objekts

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [huddle]{.lit} [0.5]{.optlit}
[huddle]{.cmd} [create]{.sub} [key]{.arg} [value]{.arg} [key value]{.optdot}
[huddle]{.cmd} [list]{.sub} [value value]{.optdot}
[huddle]{.cmd} [number]{.sub} [number]{.arg}
[huddle]{.cmd} [string]{.sub} [string]{.arg}
[huddle]{.cmd} [boolean]{.sub} [expression]{.arg} [to]{.arg} [evaluate]{.arg} [as]{.arg} [true]{.arg} [or]{.arg} [false]{.arg}
[huddle]{.cmd} [true]{.sub}
[huddle]{.cmd} [false]{.sub}
[huddle]{.cmd} [null]{.sub}
[huddle]{.cmd} [get]{.sub} [object]{.arg} [key]{.arg} [key]{.optdot}
[huddle]{.cmd} [gets]{.sub} [object]{.arg} [key]{.arg} [key]{.optdot}
[huddle]{.cmd} [set]{.sub} [objectVar]{.arg} [key]{.arg} [key]{.optdot} [value]{.arg}
[huddle]{.cmd} [remove]{.sub} [object]{.arg} [key]{.arg} [key]{.optdot}
[huddle]{.cmd} [combine]{.sub} [object1]{.arg} [object2]{.arg} [object3]{.optdot}
[huddle]{.cmd} [equal]{.sub} [object1]{.arg} [object2]{.arg}
[huddle]{.cmd} [append]{.sub} [objectVar]{.arg} [key]{.arg} [value]{.arg} [key value]{.optdot}
[huddle]{.cmd} [append]{.sub} [objectVar]{.arg} [value]{.arg} [value]{.optdot}
[huddle]{.cmd} [keys]{.sub} [object]{.arg}
[huddle]{.cmd} [llength]{.sub} [object]{.arg}
[huddle]{.cmd} [type]{.sub} [object]{.arg} [key key...]{.optarg}
[huddle]{.cmd} [strip]{.sub} [object]{.arg}
[huddle]{.cmd} [jsondump]{.sub} [object]{.arg} [offset]{.optarg} [newline]{.optarg} [begin\_offset]{.optarg}
[huddle]{.cmd} [compile]{.sub} [spec]{.arg} [data]{.arg}
[huddle]{.cmd} [isHuddle]{.sub} [object]{.arg}
[huddle]{.cmd} [checkHuddle]{.sub} [object]{.arg}
[huddle]{.cmd} [to\_node]{.sub} [object]{.arg} [tag]{.optarg}
[huddle]{.cmd} [wrap]{.sub} [tag]{.arg} [src]{.arg}
[huddle]{.cmd} [call]{.sub} [tag]{.arg} [command]{.arg} [args]{.arg}
[huddle]{.cmd} [addType]{.sub} [callback]{.arg}
[callback]{.cmd} [command]{.arg} [args]{.optarg}
[setting]{.cmd}
[get\_sub]{.cmd} [src]{.arg} [key]{.arg}
[strip]{.cmd} [src]{.arg}
[set]{.cmd} [src]{.arg} [key]{.arg} [value]{.arg}
[remove]{.cmd} [src]{.arg} [key]{.arg} [value]{.arg}
:::

# Beschreibung

Huddle stellt ein generisches, Tcl-basiertes Serialisierungs- bzw. Zwischenformat bereit. Derzeit wird jeder Knoten in ein Tag mit einfachen Typinformationen eingeschlossen.

Wenn die Huddle-Notation in andere Serialisierungsformate wie JSON oder YAML konvertiert wird, werden diese Typinformationen verwendet, um die richtige Notation auszuwählen. Und wenn die Huddle-Notation von JSON/YAML/… in Huddle konvertiert wird, kann deren Notation verwendet werden, um den richtigen Huddle-Typ auszuwählen.

Auf diese Weise kann „Huddle“ als gemeinsames Vermittlungsformat dienen.

```
huddle-format: >
  {HUDDLE {huddle-node}}
huddle-node: >
  {tag content}
each content of tag means:
  s: (content is a) string
  L: list, each sub node is a huddle-node
  D: dict, each sub node is a huddle-node
confirmed:
  - JSON
  - YAML(generally, but cannot discribe YAML-tags)
limitation:
  - cannot discribe aliases from a node to other node.
```

Das **huddle**-Paket gibt Daten als Tcl-**dict** zurück. Für die Verwendung ist entweder das **dict**-Paket oder Tcl 8.5 erforderlich.

# Befehle

**huddle create** *key* *value* ?*key value ...*?
: Erstellt ein „Huddle“-Objekt als Dict. Es kann weitere „Huddle“-Objekte enthalten.

**huddle list** ?*value value ...*?
: Erstellt ein „Huddle“-Objekt als Liste. Es kann andere „Huddle“-Objekte enthalten.

**huddle number** *number*
: Erstellt ein „Huddle“-Objekt als Zahl.

**huddle string** *string*
: Erstellt ein „Huddle“-Objekt als Zeichenfolge.

**huddle boolean** *expression to evaluate as true or false*
: Erstellt ein Huddle-Objekt als Booleschen Wert, der einen Ausdruck als „wahr“ oder „falsch“ auswertet –

**huddle true**
: Erstellt ein „Huddle“-Objekt mit dem booleschen Wert „true“.

**huddle false**
: Erstellt ein „Huddle“-Objekt mit dem booleschen Wert „false“.

**huddle null**
: Erstellt ein „Huddle“-Objekt als Null.

**huddle get** *object* *key* ?*key ...*?
: Fast dasselbe wie **dict get**. Ruft ein Unterobjekt aus dem Huddle-Objekt ab. *key* kann als Index der Huddle-Liste verwendet werden.

**huddle gets** *object* *key* ?*key ...*?
: Holt ein Unterobjekt aus dem „Huddle“-Objekt, ohne Zusatzdaten.

**huddle set** *objectVar* *key* ?*key ...*? *value*
: Fast dasselbe wie **dict set**. Legt ein Unterobjekt des Huddle-Objekts fest. *key* kann als Index der Huddle-Liste verwendet werden.

**huddle remove** *object* *key* ?*key ...*?
: Fast dasselbe wie **dict remove**. Entfernt ein Unterobjekt aus dem Huddle-Objekt. *key* kann als Index der Huddle-Liste verwendet werden.

**huddle combine** *object1* *object2* ?*object3 ...*?
: Zusammenführen der angegebenen Huddle-Objekte.

    ```
    % set aa [huddle create a b c d]
    HUDDLE {D {a {s b} c {s d}}}
    % set bb [huddle create a k l m]
    HUDDLE {D {a {s k} l {s m}}}
    % huddle combine $aa $bb
    HUDDLE {D {a {s k} c {s d} l {s m}}}
    ```

**huddle equal** *object1* *object2*
: Vergleicht zwei Huddle-Objekte rekursiv. Gibt 1 zurück, wenn sie gleich sind, andernfalls 0.

    ```
    % set aa [huddle create a b c d]
    HUDDLE {D {a {s b} c {s d}}}
    % set bb [huddle create c d a b]
    HUDDLE {D {c {s d} a {s b}}}
    % huddle equal $aa $bb
    1
    ```

**huddle append** *objectVar* *key* *value* ?*key value ...*?
: siehe unten ...

**huddle append** *objectVar* *value* ?*value ...*?
: Unterelemente anhängen. Bei Dictionaries werden Schlüssel und Wert angegeben, bei Listen die Werte.

    ```
    % set aa [huddle create a b c d]
    HUDDLE {D {a {s b} c {s d}}}
    % huddle append aa a k l m
    HUDDLE {D {a {s k} c {s d} l {s m}}}
    % set bb [huddle list i j k l]
    HUDDLE {L {{s i} {s j} {s k} {s l}}}
    % huddle append bb g h i
    HUDDLE {L {{s i} {s j} {s k} {s l} {s g} {s h} {s i}}}
    ```

**huddle keys** *object*
: Genau wie bei **dict keys**.

**huddle llength** *object*
: Entspricht **llength**.

**huddle type** *object* ?*key key...*?
: Gibt den Elementtyp zurück, der durch die Schlüssel festgelegt ist. Wenn „key“ nicht angegeben ist, gibt es den Typ des Wurzelknotens zurück.

    **string**
    : Der Knoten ist eine TCL-Zeichenkette.

    **dict**
    : Der Knoten ist ein Dict.

    **list**
    : Der Knoten ist eine Liste.

    **number**
    : Der Knoten ist eine Zahl.

    **boolean**
    : Der Knoten ist ein boolescher Wert.

    **null**
    : Der Knoten ist ein Nullwert.


    ```
    % huddle type {HUDDLE {s str}}
    string
    % huddle type {HUDDLE {L {{s a} {s b} {s c}}}}
    list
    % huddle type {HUDDLE {D {aa {s b} cc {s d}}}} cc
    string
    ```

**huddle strip** *object*
: Alle Tags wurden entfernt. In normale Tcl-Listen/Dictionaries konvertiert.

**huddle jsondump** *object* ?*offset*? ?*newline*? ?*begin\_offset*?
: Einen JSON-Stream aus dem Huddle-Objekt ausgeben.

    **offset** ""
    : Beginn-Offset als Leerzeichen „  “.


    ```
    # normal output has some indents. some strings are escaped.
    % huddle jsondump {HUDDLE {L {{L {{s i} {s baa} {s \\k} {L {{s 1.0} {s true} {s /g} {s h}}} {L {{s g}}}}} {s t}}}}
    [
      [
        "i",
        "baa",
        "\\k",
        [
          1.0,
          true,
          "\/g",
          "h"
        ],
        ["g"]
      ],
      "t"
    ]
    # stripped output
    % huddle jsondump {HUDDLE {D {dd {D {bb {D {a {s baa} c {s {d
    a}}}} cc {D {g {s h}}}}} ee {D {i {s j} k {s 1} j {s { m\a}}}}}}} "" ""
    {"dd": {"bb": {"a": "baa","c": "d\na"},"cc": {"g": "h"}},"ee": {"i": "j","k": 1,"j": " m\\a"}}
    ```

**huddle compile** *spec* *data*
: Erstellt ein „Huddle“-Objekt aus einfachen Tcl-Werten. *spec* ist wie folgt definiert:

    **string**
    : Die Daten sind einfach eine Zeichenkette.

    **list**
    : „data“ ist eine TCL-Liste aus Zeichenketten

    **dict**
    : „data“ ist ein TCL-Dict aus Zeichenketten

    list list
    : „data“ ist eine TCL-Liste von Listen

    list dict
    : „data“ ist eine TCL-Liste aus Dictionaries

    dict xx list
    : „data“ ist ein TCL-Dict, bei dem der Wert des Schlüssels „xx“ eine TCL-Liste ist.

    dict \* list
    : „data“ ist ein TCL-Dict aus Listen; „*data*“ sind einfache TCL-Werte.


    ```
    % huddle compile {dict * list} {a {1 2 3} b {4 5}}
    HUDDLE {D {a {L {{s 1} {s 2} {s 3}}} b {L {{s 4} {s 5}}}}}
    % huddle compile {dict * {list {dict d list}}} {a {{c 1} {d {2 2 2} e 3}} b {{f 4 g 5}}}
    HUDDLE {D {a {L {{D {c {s 1}}} {D {d {L {{s 2} {s 2} {s 2}}} e {s 3}}}}} b {L {{D {f {s 4} g {s 5}}}}}}}
    ```

**huddle isHuddle** *object*
: Wenn *Objekt* ein „Huddle“ ist, gibt es 1 zurück. Andernfalls gibt es 0 zurück.

**huddle checkHuddle** *object*
: Wenn *Objekt* kein Huddle ist, wird ein Fehler ausgelöst.

**huddle to\_node** *object* ?*tag*?
: Für Typ-Callbacks.

    Wenn *object* ein „Huddle“ ist, gibt es den Stammknoten zurück. Andernfalls gibt es **\[list s $object\]** zurück.

    ```
    % huddle to_node str
    s str
    % huddle to_node str !!str
    !!str str
    % huddle to_node {HUDDLE {s str}}
    s str
    % huddle to_node {HUDDLE {l {a b c}}}
    l {a b c}
    ```

**huddle wrap** *tag* *src*
: für Typ-Callbacks.

    Erstellt ein Huddle-Objekt aus *src* mit dem angegebenen *Tag*.

    ```
    % huddle wrap "" str
    HUDDLE str
    % huddle wrap s str
    HUDDLE {s str}
    ```

**huddle call** *tag* *command* *args*
: für Typ-Callbacks.

    *Befehl* wird an das Standard-*Tag* -callback weitergeleitet

**huddle addType** *callback*
: Fügt der Huddle-Bibliothek einen benutzerdefinierten Typ/Tag hinzu. Siehe „Zusätzlicher Typ“.

    **callback**
    : Name der Rückruffunktion für den zusätzlichen Typ.



# Rückruffunktion eingeben

Die Definition von „Callback“ für den Typ „user“.

**callback** *command* ?*args*?
: siehe unten ...

    **command**
    : huddle-Unterbefehl, der für die Antwort über die Rückruffunktion benötigt wird.

    **args**
    : Argumente des Unterbefehls. Die Anzahl der Argumente ist je nach Unterbefehl unterschiedlich.



Die Rückruffunktion sollte die folgenden Unterbefehle zurückgeben.

**setting**
: gibt lediglich ein festes Wörterbuch mit den Typinformationen zum Setzen des Benutzer-Tags zurück.

    **type** typename
    : Typname des Typs

    **method** {method1 method2 method3 ...}
    : Methodenliste als „huddle“-Unterbefehl. Anschließend können Sie **\[huddle method1 ...\]** aufrufen

    **tag** {tag1 child/parent tag2 child/parent ...}
    : Tag-Liste für „huddle-node“ als Wörterbuch. Wenn der Typ untergeordnete Knoten hat, verwende „parent“, andernfalls „child“.


**get\_sub** *src* *key*
: gibt einen durch *key* festgelegten Unterknoten zurück.

    **src**
    : Ein Knoteninhalt in einem Huddle-Objekt.


**strip** *src*
: Gibt den Inhalt des bereinigten Knotens zurück. Wenn der Typ untergeordnete Knoten hat, muss jeder Knoten bereinigt werden.

**set** *src* *key* *value*
: Legt einen Unterknoten aus dem markierten Inhalt fest und gibt „self“ zurück.

**remove** *src* *key* *value*
: Entfernt einen Unterknoten aus dem „tagged-content“ und gibt „self“ zurück.


**strip** muss für alle Typen definiert sein. **get\_sub** muss für Container-Typen definiert sein. **set/remove** sollten definiert sein, falls Sie sie aufrufen.

```
# callback sample for my-dict
proc my_dict_setting {command args} {
    switch -- $command {
        setting { ; # type definition
            return {
                type dict
                method {create keys}
                tag {d child D parent}
                constructor create
                str s
            }
            # type:   the type-name
            # method: add methods to huddle's subcommand.
            #          "get_sub/strip/set/remove/equal/append" called by huddle module.
            #          "strip" must be defined at all types.
            #          "get_sub" must be defined at container types.
            #          "set/remove/equal/append" shuould be defined, if you call them.
            # tag:    tag definition("child/parent" word is maybe obsoleted)
        }
        get_sub { ; # get a sub-node specified by "key" from the tagged-content
            foreach {src key} $args break
            return [dict get $src $key]
        }
        strip { ; # strip from the tagged-content
            foreach {src nop} $args break
            foreach {key val} $src {
                lappend result $key [huddle strip $val]
            }
            return $result
        }
        set { ; # set a sub-node from the tagged-content
            foreach {src key value} $args break
            dict set src $key $value
            return $src
        }
        remove { ; # remove a sub-node from the tagged-content
            foreach {src key value} $args break
            return [dict remove $src $key]
        }
        equal { ; # check equal for each node
            foreach {src1 src2} $args break
            if {[llength $src1] != [llength $src2]} {return 0}
            foreach {key1 val1} $src1 {
                if {![dict exists $src2 $key1]} {return 0}
                if {![huddle _equal_subs $val1 [dict get $src2 $key1]]} {return 0}
            }
            return 1
        }
        append { ; # append nodes
            foreach {str src list} $args break
            if {[llength $list] % 2} {error {wrong # args: should be "huddle append objvar ?key value ...?"}}
            set resultL $src
            foreach {key value} $list {
                if {$str ne ""} {
                    lappend resultL $key [huddle to_node $value $str]
                } else {
                    lappend resultL $key $value
                }
            }
            return [eval dict create $resultL]
        }
        create { ; # $args: all arguments after "huddle create"
            if {[llength $args] % 2} {error {wrong # args: should be "huddle create ?key value ...?"}}
            set resultL {}
            foreach {key value} $args {
                lappend resultL $key [huddle to_node $value]
            }
            return [huddle wrap D $resultL]
        }
        keys {
            foreach {src nop} $args break
            return [dict keys [lindex [lindex $src 1] 1]]
        }
        default {
            error "$command is not callback for dict"
        }
    }
}
```

```
# inheritance sample from default dict-callback
proc ::yaml::_huddle_mapping {command args} {
    switch -- $command {
        setting { ; # type definition
            return {
                type dict
                method {mapping}
                tag {!!map parent}
                constructor mapping
                str !!str
            }
        }
        mapping { ; # $args: all arguments after "huddle mapping"
            if {[llength $args] % 2} {error {wrong # args: should be "huddle mapping ?key value ...?"}}
            set resultL {}
            foreach {key value} $args {
                lappend resultL $key [huddle to_node $value !!str]
            }
            return [huddle wrap !!map $resultL]
        }
        default { ; # devolving to default dict-callback
            return [huddle call D $command $args]
        }
    }
}
```

# So fügen Sie einen Typ hinzu

Sie können Huddle-Knotentypen hinzufügen, z. B. ::struct::tree. Definieren Sie dazu zunächst eine Callback-Prozedur für einen zusätzlichen getaggten Typ. Die Prozedur erhält die Argumente *command* und ?*args*?. Sie enthält einige Switch-Abschnitte.

Außerdem wird der Unterbefehl „addType“ aufgerufen.

```
huddle addType my_dict_setting
```

# Arbeitsbeispiel

```
# create as a dict
% set bb [huddle create a b c d]
HUDDLE {D {a {s b} c {s d}}}

# create as a list
% set cc [huddle list e f g h]
HUDDLE {L {{s e} {s f} {s g} {s h}}}
% set bbcc [huddle create bb $bb cc $cc]
HUDDLE {D {bb {D {a {s b} c {s d}}} cc {L {{s e} {s f} {s g} {s h}}}}}
% set folding [huddle list $bbcc p [huddle list q r] s]
HUDDLE {L {{D {bb {D {a {s b} c {s d}}} cc {L {{s e} {s f} {s g} {s h}}}}} {s p} {L {{s q} {s r}}} {s s}}}

# normal Tcl's notation
% huddle strip $folding
{bb {a b c d} cc {e f g h}} p {q r} s

# get a sub node
% huddle get $folding 0 bb
HUDDLE {D {a {s b} c {s d}}}
% huddle gets $folding 0 bb
a b c d

# overwrite a node
% huddle set folding 0 bb c kkk
HUDDLE {L {{D {bb {D {a {s b} c {s kkk}}} cc {L {{s e} {s f} {s g} {s h}}}}} {s p} {L {{s q} {s r}}} {s s}}}

# remove a node
% huddle remove $folding 2 1
HUDDLE {L {{D {bb {D {a {s b} c {s kkk}}} cc {L {{s e} {s f} {s g} {s h}}}}} {s p} {L {{s q}}} {s s}}}
% huddle strip $folding
{bb {a b c kkk} cc {e f g h}} p {q r} s

# dump as a JSON stream
% huddle jsondump $folding
[
  {
    "bb": {
      "a": "b",
      "c": "kkk"
    },
    "cc": [
      "e",
      "f",
      "g",
      "h"
    ]
  },
  "p",
  [
    "q",
    "r"
  ],
  "s"
]
```

# Einschränkungen

Wird gerade gedruckt.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *huddle* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Copyright

```
Copyright (c) 2008-2011 KATO Kanryu <kanryu6@users.sourceforge.net>
Copyright (c) 2015 Miguel Martínez López <aplicacionamedida@gmail.com>
```
