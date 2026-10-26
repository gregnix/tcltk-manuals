---
CommandName: struct::record
ManualSection: n
Version: 1.2.4
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - data structures
 - record
 - struct
Copyright:
 - Copyright (c) 2002, Brett Schwarz <brett_schwarz@yahoo.com>
---

# NAME

struct::record – Datensätze definieren und anlegen (ähnlich wie „C“-Strukturen)

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [struct::record]{.lit} [1.2.4]{.optlit} 
[record]{.cmd} [define]{.sub} [recordName]{.arg} [recordMembers]{.arg} [instanceName1 instanceName2]{.optdot} 
[record]{.cmd} [show]{.sub} [record]{.arg} 
[record]{.cmd} [show]{.sub} [instances]{.arg} [recordName]{.arg} 
[record]{.cmd} [show]{.sub} [members]{.arg} [recordName]{.arg} 
[record]{.cmd} [show]{.sub} [values]{.arg} [instanceName]{.arg} 
[record]{.cmd} [exists]{.sub} [record]{.arg} [recordName]{.arg} 
[record]{.cmd} [exists]{.sub} [instance]{.arg} [instanceName]{.arg} 
[record]{.cmd} [delete]{.sub} [record]{.arg} [recordName]{.arg} 
[record]{.cmd} [delete]{.sub} [instance]{.arg} [instanceName]{.arg} 
[instanceName]{.ins} [cget]{.sub} -member 
[instanceName]{.ins} [cget]{.sub} -member1 -member2 
[instanceName]{.ins} [cget]{.sub} 
[instanceName]{.ins} [configure]{.sub} 
[instanceName]{.ins} [configure]{.sub} -member [value]{.arg} 
[instanceName]{.ins} [configure]{.sub} -member1 [value1]{.arg} -member2 [value2]{.arg} 
[instanceName]{.ins} [cget]{.sub} [-member1 -member2]{.optdot} 
[instanceName]{.ins} [configure]{.sub} [-member1 value1 -member2 value2]{.optdot} 
:::

*instanceName*

*recordName* *instanceName*|**#auto** ?*-member1 value1 -member2 value2 ...*?

# BESCHREIBUNG

Das Paket **::struct::record** bietet eine Möglichkeit, Variablen zu einer einzigen Datenstruktur zusammenzufassen, ähnlich einer *C*-Struktur. Die Elemente eines Datensatzes können Variablen oder andere Datensätze sein. Ein Datensatz darf jedoch keine zirkulären Datensätze enthalten, d. h. Datensätze, die denselben Datensatz als Element enthalten.

Dieses Paket wurde so strukturiert, dass es der Funktionsweise von Tk-Objekten sehr ähnlich ist. Jede Datensatzdefinition erzeugt ein Datensatzobjekt, das diese Definition kapselt. Anschließend kann dieses Datensatzobjekt Instanzen dieses Datensatzes erstellen. Diese Instanzen können dann mit den Methoden **cget** und **configure** bearbeitet werden.

Das Paket enthält nur einen Befehl auf oberster Ebene, jedoch mehrere Unterbefehle (siehe unten). Es beachtet außerdem den Namespace, in dem der Datensatz definiert wurde; daher sind die zurückgegebenen Objekte vollqualifiziert.

*Hinweis: Wer Tcl 9 verwendet, findet die eingebaute objektorientierte Funktionalität von Tcl möglicherweise bequemer und vielseitiger als dieses Paket.*

**record define** *recordName* *recordMembers* ?*instanceName1 instanceName2 ...*?
: Definiert einen Datensatz. *recordName* ist der Name des Datensatzes und wird zudem als Objektbefehl verwendet. Dieser Objektbefehl dient dazu, Instanzen der Datensatzdefinition zu erstellen. Die *recordMembers* sind die Elemente des Datensatzes, aus denen sich die Datensatzdefinition zusammensetzt. Dabei handelt es sich um Variablen und andere Datensätze. Werden optionale *instanceName*-Argumente angegeben, wird nach der Erstellung der Definition für jeden *instanceName* eine Instanz generiert.

**record show** *record*
: Gibt eine Liste der definierten Datensätze zurück.

**record show** *instances* *recordName*
: Gibt die Instanzen zurück, die von *recordName* instanziiert wurden.

**record show** *members* *recordName*
: Gibt die für den Datensatz *recordName* definierten Elemente zurück. Das Format entspricht dem Format, in dem die Datensätze definiert wurden.

**record show** *values* *instanceName*
: Gibt eine Liste der Werte zurück, die für die Instanz *instanceName* festgelegt sind. Die Ausgabe besteht aus einer Liste von Schlüssel-Wert-Paaren. Falls verschachtelte Datensätze vorhanden sind, bilden die Werte dieser verschachtelten Datensätze ihrerseits eine Liste.

**record exists** *record* *recordName*
: Prüft, ob ein Datensatz (*record*) mit dem Namen *recordName* existiert.

**record exists** *instance* *instanceName*
: Prüft, ob eine Instanz (*instance*) mit dem Namen *instanceName* existiert.

**record delete** *record* *recordName*
: Löscht *recordName* sowie alle Instanzen von *recordName*. Existiert der Datensatz nicht, wird ein Fehler zurückgegeben.

**record delete** *instance* *instanceName*
: Löscht die *instance* mit dem Namen *instanceName*. Existiert die Instanz nicht, wird ein Fehler zurückgegeben. Beachten Sie, dass dabei auch alle verschachtelten Instanzen rekursiv gelöscht werden.


# DATENSATZELEMENTE

Die Elemente eines Datensatzes können entweder Variablen oder andere Datensätze sein. Ein und derselbe Datensatz darf jedoch nicht in sich selbst verschachtelt werden (zyklisch). Um einen verschachtelten Datensatz zu definieren, müssen Sie das Schlüsselwort **record** zusammen mit dem Namen des Datensatzes und dem Namen der Instanz dieses verschachtelten Datensatzes (innerhalb des Containers) angeben. Das sieht zum Beispiel so aus:

```
# this is the nested record
record define mynestedrecord {
    nest1
    nest2
}

# This is the main record
record define myrecord {
    mem1
    mem2
    {record mynestedrecord mem3}
}
```

Sie können den Elementen eines Datensatzes auch Standard- oder Anfangswerte zuweisen, indem Sie den Eintrag für das jeweilige Element in geschweifte Klammern setzen:

```
record define myrecord {
    mem1
    {mem2 5}
}
```

Alle Instanzen, die anhand dieser Datensatzdefinition angelegt werden, haben anfangs den Wert **5** für das Element *mem2*. Ist kein Standardwert angegeben, ist der Wert die leere Zeichenkette.

## Werte abrufen

Um den Wert eines Elements abzurufen, gibt es mehrere Möglichkeiten.

*instanceName* **cget** -*member*
: In dieser Form gibt die eingebaute Instanzmethode **cget** den Wert des angegebenen *member* zurück. Beachten Sie den führenden Bindestrich. Um auf ein verschachteltes Element zuzugreifen, verwenden Sie die *Punktnotation*:


```
instanceName cget -mem3.nest1
```

*instanceName* **cget** -*member1* -*member2*
: In dieser Form gibt die eingebaute Instanzmethode **cget** eine Liste zurück, die die Werte beider angegebener Elemente in der Reihenfolge ihrer Angabe enthält.

*instanceName* **cget**
: ...siehe nächstes...

*instanceName* **configure**
: ...siehe nächstes...

*instanceName*
: Diese Formen sind alle gleichwertig. Sie geben ein Dictionary zurück, das alle Elemente und die zugehörigen Werte enthält.


## Werte festlegen

Um den Wert eines Elements festzulegen, gibt es mehrere Möglichkeiten.

*instanceName* **configure** -*member* *value*
: In dieser Form setzt die eingebaute Instanzmethode **configure** das angegebene *member* auf den angegebenen *value*. Beachten Sie den führenden Bindestrich. Um auf ein verschachteltes Element zuzugreifen, verwenden Sie die *Punktnotation*:


```
instanceName configure -mem3.nest1 value
```

*instanceName* **configure** -*member1* *value1* -*member2* *value2*
: In dieser Form setzt die eingebaute Instanzmethode **configure** alle angegebenen Elemente auf die zugehörigen Werte.


## Zugriff über Alias

In der ursprünglichen Implementierung erfolgte der Zugriff mithilfe der Punktnotation, ähnlich wie beim Zugriff auf *C*-Strukturen. Es herrschte jedoch Einigkeit darüber, die Schnittstelle stärker an Tcl anzulehnen, was durchaus sinnvoll war. Der ursprüngliche Alias-Zugriff ist jedoch weiterhin vorhanden. Für manche könnte er sich als hilfreich erweisen.

Grundsätzlich wird für jedes Element jeder Instanz ein Alias erstellt. Dieser Alias dient dazu, Werte für dieses Element abzurufen und festzulegen. Ein Beispiel mit den oben definierten Datensätzen verdeutlicht das:

```
% # Create an instance first
% myrecord inst1
::inst1

% # To get a member of an instance, just use the alias. It behaves
% # like a Tcl command:
% inst1.mem1

% # To set a member via the alias, just include a value. And optionally
% # the equal sign - syntactic sugar.
% inst1.mem1 = 5
5

% inst1.mem1
5

% # For nested records, just continue with the dot notation.
% # note, no equal sign.
% inst1.mem3.nest1 10
10

% inst1.mem3.nest1
10

% # just the instance by itself gives all member/values pairs for that
% # instance
% inst1
-mem1 5 -mem2 {} -mem3 {-nest1 10 -nest2 {}}

% # and to get all members within the nested record
% inst1.mem3
-nest1 10 -nest2 {}
```

# DER BEFEHL RECORD

Für jeden Datensatzbefehl stehen die folgenden Unterbefehle und die zugehörigen Argumente zur Verfügung:

*recordName* *instanceName*|**#auto** ?*-member1 value1 -member2 value2 ...*?
: Mithilfe des Objektbefehls *recordName*, der aus der Datensatzdefinition erstellt wurde, können Instanzen der Datensatzdefinition angelegt werden. Sobald eine Instanz angelegt ist, erbt sie die Elemente der Datensatzdefinition – ganz ähnlich wie bei Objekten. Beim Anlegen der Instanz wird außerdem ein Objektbefehl für die Instanz mit dem Namen *instanceName* erzeugt. Dieser Objektbefehl dient dem Zugriff auf die Datenelemente der Instanz. Während der Instanziierung können zwar Werte für diese Instanz angegeben werden; am Ende müssen jedoch *alle* Werte angegeben werden, und zwar als Schlüssel-Wert-Paare, wie bei der Methode **configure**. Verschachtelte Datensätze müssen im Listenformat vorliegen. Anstelle von *instanceName* kann auch **#auto** angegeben werden. Wird **#auto** verwendet, wird der Name der Instanz automatisch erzeugt und hat die Form **recordNameN**, wobei **N** eine erzeugte eindeutige ganze Zahl ist (beginnend bei 0).


# INSTANZBEFEHL

Die folgenden Unterbefehle und die dazugehörigen Argumente stehen für jeden Instanzbefehl eines Datensatzes zur Verfügung:

*instanceName* **cget** ?*-member1 -member2 ...*?
: Jede Instanz verfügt über die Methode **cget**. Sie funktioniert sehr ähnlich wie der Befehl **cget** von Tk-Widgets. Sie fragt die Werte der Elemente dieser bestimmten Instanz ab. Werden keine Argumente angegeben, gibt sie ein Dictionary zurück.

*instanceName* **configure** ?*-member1 value1 -member2 value2 ...*?
: Jede Instanz verfügt über die Methode **configure**. Sie funktioniert sehr ähnlich wie der Befehl **configure** von Tk-Widgets. Sie setzt die Werte der angegebenen Elemente dieser Instanz. Werden keine Argumente angegeben, gibt sie eine Dictionary-Liste zurück.


# BEISPIELE

Zwei Beispiele zeigen anschaulich, wie dieses Paket verwendet wird.

## Beispiel 1 – Kontaktdaten

Das wohl offensichtlichste Beispiel wäre die Speicherung von Kontaktdaten wie Adressen, Telefonnummern, Anmerkungen usw. Da eine Person mehrere Telefonnummern, mehrere E-Mail-Adressen usw. haben kann, werden wir diese mithilfe verschachtelter Datensätze definieren. Als Erstes definieren wir also die verschachtelten Datensätze:

```
##
##  This is an interactive example, to see what is returned by
##  each command as well.
##

% namespace import ::struct::record::*

% # define a nested record. Notice that country has default 'USA'.
% record define locations {
    street
    street2
    city
    state
    zipcode
    {country USA}
    phone
}
::locations
% # Define the main record. Notice that it uses the location record twice.
% record define contacts {
    first
    middle
    last
    {record locations home}
    {record locations work}
}
::contacts
% # Create an instance for the contacts record.
% contacts cont1
::cont1
% # Display some introspection values
% record show records
::contacts ::locations
% #
% record show values cont1
-first {} -middle {} -last {} -home {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}} -work {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}}
% #
% record show instances contacts
::cont1
% #
% cont1 config
-first {} -middle {} -last {} -home {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}} -work {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}}
% #
% cont1 cget
-first {} -middle {} -last {} -home {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}} -work {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}}
% # copy one record to another record
% record define contacts2 [record show members contacts]
::contacts2
% record show members contacts2
first middle last {record locations home} {record locations work}
% record show members contacts
first middle last {record locations home} {record locations work}
%
```

## Beispiel 2 – verkettete Liste

Das folgende Beispiel veranschaulicht lediglich eine einfache verkettete Liste

```
% # define a very simple record for linked list
% record define linkedlist {
    value
    next
}
::linkedlist
% linkedlist lstart
::lstart
% lstart config -value 1 -next [linkedlist #auto]
% [lstart cget -next] config -value 2 -next [linkedlist #auto]
% [[lstart cget -next] cget -next] config -value 3 -next "end"
% set next lstart
lstart
% while 1 {
    lappend values [$next cget -value]
    set next [$next cget -next]
    if {[string match "end" $next]} break
}
% puts "$values"
1 2 3
% # cleanup linked list
% # We could just use delete record linkedlist also
% foreach I [record show instances linkedlist] {
    record delete instance $I
}
% record show instances linkedlist
%
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: record* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Datenstrukturen

# COPYRIGHT

```
Copyright (c) 2002, Brett Schwarz <brett_schwarz@yahoo.com>
```
