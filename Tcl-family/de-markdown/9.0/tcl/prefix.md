---
CommandName: prefix
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - lsearch(n)
 - namespace(n)
 - string(n)
 - Tcl_GetIndexFromObj(3)
Keywords:
 - prefix
 - table lookup
Copyright:
 - Copyright (c) 2008 Peter Spjuth <pspjuth@users.sourceforge.net>
---

# NAME

tcl::prefix - Hilfsmittel für Präfixabgleich

# ÜBERSICHT

::: {.synopsis} :::
[::tcl::prefix]{.cmd} [all]{.sub} [table]{.arg} [string]{.arg} 
[::tcl::prefix]{.cmd} [longest]{.sub} [table]{.arg} [string]{.arg} 
[::tcl::prefix]{.cmd} [match]{.sub} [option]{.optdot} [table]{.arg} [string]{.arg} 
:::

# BESCHREIBUNG

Dieses Dokument beschreibt Befehle zum Nachschlagen eines Präfixes in einer Liste von Zeichenketten. Folgende Befehle werden unterstützt:

**::tcl::prefix all** *table string*
: Gibt eine Liste aller Elemente in *table* zurück, die mit dem Präfix *string* beginnen.

**::tcl::prefix longest** *table string*
: Gibt das längste gemeinsame Präfix aller Elemente in *table* zurück, die mit dem Präfix *string* beginnen.

**::tcl::prefix match** ?*option ...*? *table string*
: Wenn *string* einem Element in *table* entspricht oder das Präfix genau eines Elements ist, wird das gefundene Element zurückgegeben. Andernfalls hängt das Ergebnis von der Option **-error** ab. (Es wird empfohlen, *table* vor der Verwendung mit diesem Unterbefehl zu sortieren, damit die Liste der Übereinstimmungen in der Fehlermeldung ebenfalls sortiert ist; dies ist für die Funktion des Unterbefehls selbst jedoch nicht zwingend erforderlich.) Folgende Optionen werden unterstützt:

**-exact**
: Nur exakte Übereinstimmungen akzeptieren.

**-message**\\**0**_string_
: *string* in der Fehlermeldung bei Nichtübereinstimmung verwenden. Standard ist „option“.

**-error**\\**0**_options_
: Die *options* werden verwendet, wenn keine Übereinstimmung gefunden wird. Ist *options* leer, wird kein Fehler erzeugt und eine leere Zeichenkette zurückgegeben. Andernfalls werden die *options* als **return**-Optionen bei der Erzeugung der Fehlermeldung verwendet. Der Standard entspricht dem Setzen von „-level 0“. Beispiel: Wird „**-error** {-errorcode MyError -level 1}“ verwendet, würde ein Fehler wie folgt erzeugt:


    ```
    return -errorcode MyError -level 1 -code error \
           "ambiguous option ..."
    ```


# BEISPIELE

Grundlegende Verwendung:

```
namespace import ::tcl::prefix
prefix match {apa bepa cepa} apa
     → apa
prefix match {apa bepa cepa} a
     → apa
prefix match -exact {apa bepa cepa} a
     → bad option "a": must be apa, bepa, or cepa
prefix match -message "switch" {apa ada bepa cepa} a
     → ambiguous switch "a": must be apa, ada, bepa, or cepa
prefix longest {fblocked fconfigure fcopy file fileevent flush} fc
     → fco
prefix all {fblocked fconfigure fcopy file fileevent flush} fc
     → fconfigure fcopy
```

Optionenabgleich vereinfachen:

```
array set opts {-apa 1 -bepa "" -cepa 0}
foreach {arg val} $args {
    set opts([prefix match {-apa -bepa -cepa} $arg]) $val
}
```

Erzeugen eines **switch**, der Präfixe unterstützt:

```
switch [prefix match {apa bepa cepa} $arg] {
    apa  { }
    bepa { }
    cepa { }
}
```
