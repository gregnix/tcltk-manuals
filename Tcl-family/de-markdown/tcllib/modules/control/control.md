---
CommandName: control
title: control
ManualSection: n
Version: 0.1.4
TclPart: tcllib
TclDescription: Tcl Control Flow Commands
Links:
 - break
 - continue
 - expr
 - if
 - join
 - namespace
 - return
 - string
 - while
Keywords:
 - assert
 - control
 - do
 - flow
 - no-op
 - structure
Copyright:
---

# Name

Steuerung – Prozeduren für Kontrollflussstrukturen.

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [control]{.lit} [0.1.4]{.optlit}
[control::control]{.cmd} [command]{.arg} [option]{.arg} [arg arg]{.optdot}
[control::assert]{.cmd} [expr]{.arg} [arg arg]{.optdot}
[control::do]{.cmd} [body]{.arg} [option test]{.optarg}
[control::no-op]{.cmd} [arg arg]{.optdot}
:::

# Beschreibung

Das **control**-Paket bietet eine Vielzahl von Befehlen, die über die von Tcl bereitgestellten integrierten Strukturen hinaus zusätzliche Strukturen zur Steuerung des Programmablaufs bereitstellen. Dabei handelt es sich um Befehle, die in vielen Programmiersprachen als *Schlüsselwörter* oder als Teil der Sprache selbst betrachtet werden könnten. In Tcl sind Strukturen zur Steuerung des Programmablaufs jedoch genau wie alles andere auch einfach nur Befehle.

# Befehle

**control::control** *command* *option* ?*arg arg ...*?
: Der Befehl **control** dient als Konfigurationsbefehl zur Anpassung der anderen öffentlichen Befehle des control-Pakets. Das Argument *command* gibt den Befehl an, der angepasst werden soll. Die gültigen *Optionen* und nachfolgenden Argumente richten sich nach dem anzupassenden Befehl und sind in der Dokumentation zu diesem Befehl aufgeführt.

**control::assert** *expr* ?*arg arg ...*?
: Wenn der Befehl **assert** deaktiviert ist, verhält er sich genau wie der Befehl **no-op**.

    Wenn er aktiviert ist, führt der Befehl **assert** die Auswertung von *expr* als Ausdruck durch (genauso wie **expr** sein Argument auswertet). Wenn sich bei der Auswertung herausstellt, dass *expr* kein gültiger boolescher Ausdruck ist (gemäß \[**string is boolean -strict**\]), wird ein Fehler ausgelöst.  Wenn *expr* zu einem wahren booleschen Wert ausgewertet wird (wie von **if** erkannt), gibt **assert** eine leere Zeichenkette zurück.  Andernfalls werden die verbleibenden Argumente von **assert** verwendet, um eine Meldungszeichenfolge zu bilden.  Wenn keine Argumente vorhanden sind, lautet die Meldungszeichenfolge „assertion failed: $expr“.  Wenn Argumente vorhanden sind, werden diese mit **join** zu einer Meldungszeichenfolge zusammengefügt. Die Meldungszeichenfolge wird dann als Argument an einen Callback-Befehl angehängt, und der vervollständigte Callback-Befehl wird im globalen Namespace ausgewertet.

    Der Befehl **assert** kann durch den Befehl **control** auf zwei Arten angepasst werden:

    \[**control::control assert enabled** ?*boolean*?\] fragt ab oder legt fest, ob **control::assert** aktiviert ist.  Wird der Befehl ohne ein *boolean*-Argument aufgerufen, gibt er einen booleschen Wert zurück, der angibt, ob der Befehl **control::assert** aktiviert ist.  Wird der Befehl mit einem gültigen booleschen Wert als *boolean*-Argument aufgerufen, wird der Befehl **control::assert** entsprechend dem Argument aktiviert oder deaktiviert, und es wird eine leere Zeichenkette zurückgegeben.

    \[**control::control assert callback** ?*command*?\] fragt die Rückruffunktion ab oder legt sie fest, die bei einem Assertion-Fehler von einem aktivierten **assert** aufgerufen wird.  Wird die Funktion ohne ein *command*-Argument aufgerufen, gibt sie den aktuellen Befehl der Rückruffunktion zurück. Wird der Befehl mit einem *command*-Argument aufgerufen, wird dieses Argument zum neuen Callback-Befehl für den Fall eines Assertion-Fehlers. Hinweis: Ein Callback-Befehl für den Fall eines Assertion-Fehlers ist immer definiert, auch wenn **assert** deaktiviert ist. Der Standard-Callback-Befehl lautet \[**return -code error**\].

    Hinweis: **control::assert** wurde so geschrieben, dass es in Kombination mit \[**namespace import**\] möglich ist, aktivierte **assert**-Befehle in einigen Namespaces und deaktivierte **assert**-Befehle in anderen Namespaces gleichzeitig zu verwenden.  Diese Funktion ist nützlich, um die Fehlersuche modulweise unabhängig voneinander steuern zu können.

    ```
    % package require control
    % control::control assert enabled 1
    % namespace eval one namespace import ::control::assert
    % control::control assert enabled 0
    % namespace eval two namespace import ::control::assert
    % one::assert {1 == 0}
    assertion failed: 1 == 0
    % two::assert {1 == 0}
    ```

**control::do** *body* ?*option test*?
: Der Befehl **do** wertet den Skriptkörper *body* wiederholt aus, *bis* der Ausdruck *test* wahr wird oder solange (*while*) *test* wahr ist, je nachdem, ob der Wert von *option**until** oder **while** lautet. Wenn *option* und *test* weggelassen werden, wird der Körper genau einmal ausgewertet. Nach normaler Ausführung gibt **do** eine leere Zeichenkette zurück. Ausnahmerückgabecodes (**break**, **continue**, **error** usw.) während der Auswertung von *body* werden genauso behandelt wie beim Befehl **while**, mit Ausnahme der unten unter [Einschränkungen] genannten Fälle.

**control::no-op** ?*arg arg ...*?
: Der Befehl **no-op** akzeptiert eine beliebige Anzahl von Argumenten und führt keine Aktion aus. Er gibt eine leere Zeichenkette zurück.


# Einschränkungen

Einige der vom **control**-Paket bereitgestellten Befehle akzeptieren Argumente in Form von Skripten, die ausgewertet werden sollen. Aufgrund grundlegender Einschränkungen der Tcl-Befehle **catch** und **return** ist es diesen Befehlen nicht möglich, den Befehl \[**return -code $code**\] innerhalb eines dieser Skript-Argumente für einen beliebigen Wert von *$code* außer *ok* korrekt auszuwerten.  In dieser Hinsicht sind die Befehle des **control**-Pakets im Vergleich zu den in Tcl integrierten Befehlen zur Steuerungsflusssteuerung (wie **if**, **while** usw.) sowie zu den Befehlen zur Steuerungsflusssteuerung, die von in C programmierten Paketen bereitgestellt werden können, eingeschränkt. Ein Beispiel für diesen Unterschied:

```
% package require control
% proc a {} {while 1 {return -code error a}}
% proc b {} {control::do {return -code error b} while 1}
% catch a
1
% catch b
0
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *control* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge
