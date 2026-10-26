---
CommandName: try
title: try
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Forward compatibility implementation of [try]
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
 - Copyright (c) 2008 Donal K. Fellows, BSD licensed
---

# Name

try – try – Fehler und Ausnahmen abfangen und verarbeiten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [try]{.lit} [1.1]{.optlit}
[::try]{.cmd} [body]{.arg} [handler...]{.optarg} [[finally]{.lit} [script]{.arg}]{.optarg}
:::

# Beschreibung

Dieses Paket bietet eine Implementierung mit Kompatibilität zum Tcl 8.6-Befehl **try**/**finally** (TIP 329) für Tcl 8.5. Der Code stammt direkt aus der Tcl-8.6-Revision ?, als **try**/**finally** als Tcl-Prozedur statt in C implementiert wurde.

**::try** *body* ?*handler...*? ?**finally** *script*?
: Dieser Befehl führt das Skript *body* aus und ruft – je nachdem, wie das Skript endet (normales Beenden, Fehler oder ein anderes außergewöhnliches Ergebnis) – ein Handler-Skript auf, um den jeweiligen Fall zu behandeln. Sobald all dies geschehen ist und eine **finally**-Klausel vorhanden ist, wird das darin enthaltene *Skript* ausgeführt, und das Ergebnis des Handlers (oder des *body*, falls kein Handler gefunden wurde) darf weiterverbreitet werden. Hinweise: Die **finally**-Klausel wird auch dann verarbeitet, wenn ein Fehler auftritt, und zwar unabhängig davon, welcher *Handler* gegebenenfalls verwendet wird.

    Die *Handler*-Klauseln haben jeweils einen Ausdruck aus mehreren Wörtern und müssen eine der folgenden Formen haben:

    **on** *code variableList script*
    : Diese Klausel passt, wenn die Auswertung von *body* mit dem Ausnahmecode *code* endete. *code* darf eine Ganzzahl sein oder eines der Wörter **ok**, **error**, **return**, **break** oder **continue**. Diese Wörter entsprechen den Ganzzahlen 0 bis 4.

    **trap** *pattern variableList script*
    : Diese Klausel trifft zu, wenn die Auswertung von *body* zu einem Fehler geführt hat und das Präfix von **-errorcode** aus dem Dictionary des Interpreters mit dem Muster übereinstimmt. Die Anzahl der aus **-errorcode** entnommenen Präfixwörter entspricht der Listenlänge von *Muster*, und Leerzeichen zwischen den Wörtern werden sowohl in **-errorcode** als auch in *Muster* vor dem Vergleich normalisiert.

        Das Wort *variableList* in jedem *Handler* wird stets als Liste von Variablennamen interpretiert. Wenn das erste Wort der Liste vorhanden und nicht leer ist, benennt es eine Variable, in die das Ergebnis der Auswertung von *body* (aus dem Haupt-**try**) gespeichert wird; diese enthält die für Menschen lesbare Form etwaiger Fehler. Wenn das zweite Wort der Liste vorhanden und nicht leer ist, benennt es eine Variable, in die das Options Dictionary des Interpreters zum Zeitpunkt der Beendigung der Ausführung von *body* platziert wird.

        Das Wort *script* in jedem *handler* wird ebenfalls immer gleich interpretiert: als Tcl-Skript, das ausgewertet wird, wenn die Klausel übereinstimmt. Ist *script* ein Literal **-** und ist der *handler* nicht der letzte, wird stattdessen das *script* des folgenden *handler* aufgerufen (genau wie beim **switch**-Befehl).

        Beachte, dass *handler*-Klauseln der Reihe nach abgeglichen werden und dass immer die erste übereinstimmende ausgewählt wird. Es wird höchstens eine *Handler*-Klausel ausgewählt. Folglich überdeckt ein **on error** alle nachfolgenden **trap**-Anweisungen im **try**. Hinweis: **on error** ist gleichbedeutend mit **trap {}**.

        Wenn während der Auswertung entweder der *Handler*- oder der **finally**-Klausel eine Ausnahme auftritt (d. h. ein beliebiges Ergebnis, das nicht **ok** ist), wird das Dictionary der ursprünglichen Ausnahme unter dem Schlüssel **-during** .



# Beispiele

Eine Datei in jedem Fall schließen:

```
set f [open /some/file/name a]
try {
    puts \$f "some message"
    # ...
} finally {
    close \$f
}
```

Verschiedene Gründe behandeln, warum eine Datei nicht zum Lesen geöffnet werden kann:

```
try {
    set f [open /some/file/name]
} trap {POSIX EISDIR} {} {
    puts "failed to open /some/file/name: it's a directory"
} trap {POSIX ENOENT} {} {
    puts "failed to open /some/file/name: it doesn't exist"
}
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *try* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hilfsprogramme

# Copyright

```
Copyright (c) 2008 Donal K. Fellows, BSD licensed
```
