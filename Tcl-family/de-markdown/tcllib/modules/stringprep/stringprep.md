---
CommandName: stringprep
title: stringprep
ManualSection: n
Version: 1.0.3
TclPart: tcllib
TclDescription: Preparation of Internationalized Strings
Links:
 - unicode(n)
Keywords:
 - stringprep
 - unicode
Copyright:
 - Copyright (c) 2007-2009, Sergei Golovan <sgolovan@nes.ru>
---

# Name

stringprep – Implementierung von stringprep

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [stringprep]{.lit} [1.0.3]{.lit}
[::stringprep::register]{.cmd} [profile]{.arg} [-mapping list]{.optarg} [-normalization form]{.optarg} [-prohibited list]{.optarg} [-prohibitedList list]{.optarg} [-prohibitedCommand command]{.optarg} [-prohibitedBidi boolean]{.optarg}
[::stringprep::stringprep]{.cmd} [profile]{.arg} [string]{.arg}
[::stringprep::compare]{.cmd} [profile]{.arg} [string1]{.arg} [string2]{.arg}
:::

# Beschreibung

Hierbei handelt es sich um eine Tcl-Implementierung der „Preparation of Internationalized Strings“ („stringprep“). Sie unterstützt die Definition von stringprep-Profilen und deren Verwendung zur Aufbereitung von Unicode-Zeichenketten für Vergleiche, wie in [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454) definiert.

*Hinweis: RFC 3454 (2002) wurde durch RFC 7564 (2015) ersetzt, der wiederum durch* [RFC 8264](https://www.rfc-editor.org/rfc/rfc8264) *(2017)* ersetzt wurde.

*Dieses Paket wird derzeit nicht gepflegt; siehe* [ticket](https://core.tcl-lang.org/tcllib/tktview/b192bd4149e07ddf4e000f894100700c2ec35e1e).

# API

Wenn als einzige Zeichenaufbereitung die Unicode-Normalisierung nötig ist, reichen die Befehle des Pakets **unicode** aus.

**::stringprep::register** *profile* ?*-mapping list*? ?*-normalization form*? ?*-prohibited list*? ?*-prohibitedList list*? ?*-prohibitedCommand command*? ?*-prohibitedBidi boolean*?
: Registriert ein **stringprep**-Profil mit dem Namen *profile*, das die angegebenen Optionen anwendet.

    **-mapping** *list*
    : Diese Option legt die Zuordnungstabellen **stringprep** fest. Es handelt sich dabei um die Tabellen in Anhang B von [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454). Die üblichen Listenwerte sind {B.1 B.2} oder {B.1 B.3}, wobei B.1 Zeichen enthält, die üblicherweise auf nichts abgebildet werden, B.2 in Profilen mit der Unicode-Normalisierungsform KC verwendet wird und B.3 die Groß-/Kleinschreibungsfaltung festlegt. Der Standardwert ist eine leere Liste, was bedeutet, dass keine Zuordnung erfolgt.

    **-normalization** *form*
    : Diese Option legt fest, welche Normalisierungsform angewendet werden soll. Die *form* ist eine Zeichenkette, die einen der folgenden Werte annehmen kann: „D“, „C“, „KD“ oder „KC“. Formal unterstützt [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454) entweder keine Normalisierung oder „KC“. Die Standardeinstellung ist keine Normalisierung.

    **-prohibited** *list*
    : Diese Option legt eine Liste von [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454)-Tabellen mit unzulässigen Zeichen fest. Beispielsweise lautet die Liste aus [RFC 3491](https://www.rfc-editor.org/rfc/rfc3491) wie folgt: {A.1 C.1.2 C.2.2 C.3 C.4 C.5 C.6 C.7 C.8 C.9}. Formal erlaubt [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454) entweder das Verbieten aller Tabellen von C.3 bis C.9 oder keiner davon. Standardmäßig wird keine dieser Tabellen verboten.

    **-prohibitedList** *list*
    : Diese Option legt eine Liste verbotener Zeichen als Unicode-Codepunkte fest. Um beispielsweise die Zeichen **" & ' / : < > @** zu verbieten, ist eine Liste ihrer Codepunkte anzugeben: {0x22 0x26 0x27 0x2F 0x3A 0x3C 0x3E 0x40}. Standardmäßig ist die Liste leer. (Wenn diese Zeichen festgelegt werden, gelten sie zusätzlich zu den durch die Option *-prohibited* verbotenen Zeichen.)

    **-prohibitedCommand** *command*
    : Diese Option legt einen *command* fest, der mit einem Unicode-Codepunkt aufgerufen wird, sobald ein Zeichen zugeordnet und normalisiert wird. Wenn der *command* **1** (true) zurückgibt, wird das Zeichen als unzulässig behandelt. Ein Rückgabewert von **0** (false) gewährleistet die normale Verarbeitung. Diese Option ist eine nützliche Alternative dazu, der Option *-prohibitedList* eine sehr umfangreiche Liste zu übergeben. Standardmäßig ist kein Befehl festgelegt.

    **-prohibitedBidi** *boolean*
    : Wenn diese Option festgelegt und mit einem Wert ungleich Null übergeben wird (z. B. **1**; true), werden die in Abschnitt 6 von [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454) definierten Regeln zur bidirektionalen Zeichenverarbeitung verwendet. Standardmäßig werden die bidirektionalen Regeln nicht verwendet.


**::stringprep::stringprep** *profile* *string*
: Gibt eine möglicherweise geänderte Kopie von *string* basierend auf dem angegebenen *profile* zurück; andernfalls wird ein Fehler ausgelöst.

    Mögliche Fehler sind: *invalid\_profile* – das angegebene *profile* ist nicht definiert; *prohibited\_character* – die angegebene *string* enthält ein unzulässiges Zeichen; *prohibited\_bidi* – die angegebene *string* enthält eine unzulässige bidirektionale Zeichenfolge.

**::stringprep::compare** *profile* *string1* *string2*
: Führt einen Vergleich der beiden angegebenen Zeichenfolgen durch, indem das Ergebnis der jeweiligen Zeichenfolgenvorbereitung gemäß dem angegebenen *profile* verglichen wird. Gibt **0** zurück, wenn die Zeichenfolgen (gemäß dem angegebenen *profile*) gleich sind, oder **-1**, wenn *string1* lexikografisch kleiner ist als *string2*, bzw. **1**, wenn *string1* lexikografisch größer ist als *string2*.


# Beispiele

Dieses Beispiel zeigt, wie sich mit **stringprep** Zeichenfolgen vergleichen lassen.

```
::stringprep::register basicprep -mapping {B.1 B.2} -normalization KC
# Three poor UTF-8 byte sequences (to illustrate stringprep, not to use in practice):
const EACUTE [encoding convertfrom utf-8 \x65\xCC\x81]
const ANGSTROM [encoding convertfrom utf-8 \xE2\x84\xAB]
const ODOTS [encoding convertfrom utf-8 \x6F\xCC\x88]
const A "Caf${EACUTE} ${ANGSTROM}ngstr${ODOTS}m"
# Best to either use a UTF-8-savvy editor:
const B "Café Ångström"
# Or to use Tcl’s Unicode escapes:
const C "Caf\u00E9 \u212Bngstr\u00F6m"

puts "A '$A' hex: [binary encode hex [encoding convertto utf-8 $A]]"
puts "B '$B' hex: [binary encode hex [encoding convertto utf-8 $B]]"
puts "C '$C' hex: [binary encode hex [encoding convertto utf-8 $C]]"
puts "string compare \$A \$B → [expr {[string compare $A $B] ? "unequal" : "equal"}]"
puts "string compare \$A \$C → [expr {[string compare $A $C] ? "unequal" : "equal"}]"
puts "stringprep::compare basicprep \$A \$B → [expr {[stringprep::compare basicprep $A $B] ? "unequal" : "equal"}]"
puts "stringprep::compare basicprep \$A \$C → [expr {[stringprep::compare basicprep $A $C] ? "unequal" : "equal"}]"
=>
A 'Café Ångström' hex: 43616665cc8120e284ab6e677374726fcc886d
B 'Café Ångström' hex: 436166c3a920c3856e67737472c3b66d
C 'Café Ångström' hex: 436166c3a920e284ab6e67737472c3b66d
string compare $A $B → unequal
string compare $A $C → unequal
stringprep::compare basicprep $A $B → equal
stringprep::compare basicprep $A $C → equal
```

## Ältere Beispiele

Definition des Nameprep-Profils (siehe [RFC 3491](https://www.rfc-editor.org/rfc/rfc3491)).

```
::stringprep::register nameprep  -mapping {B.1 B.2}  -normalization KC  -prohibited {A.1 C.1.2 C.2.2 C.3 C.4 C.5 C.6 C.7 C.8 C.9}  -prohibitedBidi 1
```

Definitionen der Profile Nodeprep und resourceprep (siehe [RFC 3920](https://www.rfc-editor.org/rfc/rfc3920)).

```
::stringprep::register nodeprep  -mapping {B.1 B.2}  -normalization KC  -prohibited {A.1 C.1.1 C.1.2 C.2.1 C.2.2 C.3 C.4 C.5 C.6 C.7 C.8 C.9}  -prohibitedList {0x22 0x26 0x27 0x2f 0x3a 0x3c 0x3e 0x40}  -prohibitedBidi 1

::stringprep::register resourceprep  -mapping {B.1}  -normalization KC  -prohibited {A.1 C.1.2 C.2.1 C.2.2 C.3 C.4 C.5 C.6 C.7 C.8 C.9}  -prohibitedBidi 1
```

# Autoren

Sergei Golovan

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *stringprep* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Copyright

```
Copyright (c) 2007-2009, Sergei Golovan <sgolovan@nes.ru>
```
