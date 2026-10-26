---
CommandName: try
title: try
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - catch(n)
 - error(n)
 - return(n)
 - throw(n)
Keywords:
 - cleanup
 - error
 - exception
 - final
 - resource management
Copyright:
 - Copyright (c) 2008 Donal K. Fellows
---

# Name

try - Fehler und Ausnahmen abfangen und verarbeiten

# Übersicht

::: {.synopsis} :::
[try]{.cmd} [body]{.arg} [handler...]{.optarg} [[finally]{.lit} [script]{.arg}]{.optarg}
:::

# Beschreibung

Dieser Befehl führt das Skript *body* aus und startet je nach Ergebnis dieses Skripts (normales Ende, Fehler oder ein anderes Ausnahmeergebnis) ein Handler-Skript für diesen Fall. Danach, wenn eine Klausel **finally** vorhanden ist, läuft das darin enthaltene *script*, und das Ergebnis des Handlers (oder von *body*, wenn kein Handler gepasst hat) darf sich weiter ausbreiten. Die Klausel **finally** wird auch bei einem Fehler verarbeitet, unabhängig davon, welcher *handler* verwendet wird, falls überhaupt einer.

Jede *handler*-Klausel besteht aus mehreren Wörtern und muss eine der folgenden Formen haben:

**on** *code variableList script*
: Diese Klausel passt, wenn die Auswertung von *body* mit dem Ausnahmecode *code* endete. *code* darf eine Ganzzahl sein oder eines der Wörter **ok**, **error**, **return**, **break** oder **continue**. Diese Wörter entsprechen den Ganzzahlen 0 bis 4.

**trap** *pattern variableList script*
: Diese Klausel passt, wenn die Auswertung von *body* einen Fehler ergab und das Präfix von **-errorcode** aus dem Status-Dictionary des Interpreters gleich *pattern* ist. Die Anzahl der Präfixwörter aus **-errorcode** ist die Listenlänge von *pattern*; Leerzeichen zwischen den Wörtern werden in **-errorcode** und *pattern* vor dem Vergleich vereinheitlicht.


Das Wort *variableList* jedes *handler* gilt immer als Liste von Variablennamen. Ist das erste Wort der Liste vorhanden und nicht leer, nennt es eine Variable, in die das Ergebnis der Auswertung von *body* (aus dem umgebenden **try**) kommt; das enthält die lesbare Form von Fehlern. Ist das zweite Wort vorhanden und nicht leer, nennt es eine Variable für das Options-Dictionary des Interpreters zum Zeitpunkt, an dem *body* endete.

Das Wort *script* jedes *handler* gilt immer gleich: als Tcl-Skript, das ausgewertet wird, wenn die Klausel passt. Ist *script* das Literal „-“ und der *handler* nicht der letzte, wird stattdessen das *script* des folgenden *handler* aufgerufen (wie beim Befehl [switch]).

Die *handler*-Klauseln werden der Reihe nach geprüft, und die erste passende wird gewählt. Höchstens eine *handler*-Klausel wird gewählt. Deshalb verdeckt ein **on error** jedes nachfolgende **trap** im **try**. **on error** ist gleichwertig zu **trap {}**.

Tritt bei der Auswertung des *handler* oder der Klausel **finally** eine Ausnahme auf (jedes Ergebnis außer **ok**), wird das Status-Dictionary der ursprünglichen Ausnahme dem Status-Dictionary der neuen Ausnahme unter dem Schlüssel **-during** hinzugefügt.

# Beispiele

Eine Datei in jedem Fall schließen:

```
set f [open /some/file/name a]
try {
    puts $f "some message"
    # ...
} finally {
    close $f
}
```

Verschiedene Gründe behandeln, warum eine Datei nicht zum Lesen geöffnet werden kann:

```
try {
    set f [open /some/file/name r]
} trap {POSIX EISDIR} {} {
    puts "failed to open /some/file/name: it's a directory"
} trap {POSIX ENOENT} {} {
    puts "failed to open /some/file/name: it doesn't exist"
}
```

Prozedur, die eine Datei in UTF-8 liest und den Inhalt zurückgibt. Die Datei wird bei Erfolg und bei Fehler durch die Klausel **finally** geschlossen. **return** innerhalb des Blocks **try** ist zulässig. Ab Tcl 9 kann **read** auch UTF-8-Umwandlungsfehler auslösen:

```
proc readfile {filename} {
    set f [open $filename r]
    try {
        fconfigure $f -encoding utf-8 -profile strict
        return [read $f]
    } finally {
        close $f
    }
}
```


[switch]: switch.md
