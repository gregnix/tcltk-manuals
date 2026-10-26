---
CommandName: oo::util
ManualSection: n
Version: 1.2.2
TclPart: tcllib
TclDescription: Utility commands for TclOO
Links:
 - snit(n)
Keywords:
 - TclOO
 - callback
 - class methods
 - class variables
 - command prefix
 - currying
 - method reference
 - my method
 - singleton
Copyright:
 - Copyright (c) 2011-2015 Andreas Kupries, BSD licensed
---

# NAME

oo::util – Hilfsbefehle für TclOO

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [oo::util]{.lit} [1.2.2]{.optlit} 
[mymethod]{.cmd} [method]{.arg} [arg]{.optdot} 
[classmethod]{.cmd} [name]{.arg} [arguments]{.arg} [body]{.arg} 
[classvariable]{.cmd} [arg]{.optdot} 
[link]{.cmd} [method...]{.arg} 
[link]{.cmd} { [alias]{.arg} [method]{.arg} } ... 
[ooutil::singleton]{.cmd} [arg]{.optdot} 
:::

# BESCHREIBUNG

Dieses Paket bietet einen Komfortbefehl zur einfachen Festlegung von Instanzmethoden als Rückruffunktionen, wie beispielsweise Timer, Dateiereignisse, Tk-Bindungen usw.

# BEFEHLE

**mymethod** *method* ?*arg*...?
: Dieser Befehl steht innerhalb von Instanzmethoden zur Verfügung. Er nimmt einen Methodennamen und gegebenenfalls Argumente für die Methode entgegen und gibt ein Befehlspräfix zurück, das bei seiner Ausführung die benannte Methode des Objekts, in dem wir uns gerade befinden, mit den übergebenen Argumenten sowie allen weiteren Argumenten aufruft, die zum Zeitpunkt des tatsächlichen Aufrufs bereitgestellt werden. Hinweis: Der Befehl entspricht dem Befehl, der vom OO-Paket **snit** für denselben Zweck bereitgestellt wird, und ist nach diesem benannt.

**classmethod** *name* *arguments* *body*
: Dieser Befehl steht innerhalb von Klassendefinitionen zur Verfügung. Er nimmt einen Namen für die Methode und gegebenenfalls Argumente für die Methode entgegen und erstellt eine Methode in der Klasse, die für Benutzer dieser Klasse sowie abgeleiteter Klassen verfügbar ist. Hinweis: Der Befehl entspricht dem Befehl **typemethod**, der vom OO-Paket **snit** für denselben Zweck bereitgestellt wird. Beispiel


```
oo::class create ActiveRecord {
    classmethod find args { puts "[self] called with arguments: $args" }
}
oo::class create Table {
    superclass ActiveRecord
}
puts [Table find foo bar]
# ======
# which will write
# ======
# ::Table called with arguments: foo bar
```

**classvariable** ?*arg*...?
: Dieser Befehl steht innerhalb von Instanzmethoden zur Verfügung. Er nimmt eine Reihe von Variablennamen entgegen und macht diese im Gültigkeitsbereich der Methode verfügbar. Der ursprüngliche Gültigkeitsbereich der Variablen ist die Klasse (Instanz), zu der die Objektinstanz gehört. Mit anderen Worten: Die referenzierten Variablen werden von allen Instanzen ihrer Klasse gemeinsam genutzt. Hinweis: Der Befehl entspricht in etwa dem Befehl **typevariable**, der vom OO-Paket **snit** für denselben Zweck bereitgestellt wird. Der Unterschied besteht darin, dass er nicht in der Klassendefinition selbst verwendet werden kann. Beispiel:


```
% oo::class create Foo {
    method bar {z} {
        classvariable x y
        return [incr x $z],[incr y]
    }
}
::Foo
% Foo create a
::a
% Foo create b
::b
% a bar 2
2,1
% a bar 3
5,2
% b bar 7
12,3
% b bar -1
11,4
% a bar 0
11,5
```

**link** *method*...
: ...siehe nächstes...

**link** {*alias* *method*}...
: Dieser Befehl steht innerhalb von Instanzmethoden zur Verfügung. Er nimmt eine Liste von Methodennamen und/oder Paaren aus Alias- und Methodennamen entgegen und macht die genannten Methoden für alle Instanzmethoden verfügbar, ohne dass der Befehl **my** erforderlich ist. Der Aliasname, unter dem die Methode verfügbar wird, entspricht standardmäßig dem Methodennamen, sofern nicht ausdrücklich ein Alias-Methoden-Paar angegeben wurde. Beispiele:


```
    link foo
    # The method foo is now directly accessible as foo instead of my foo.

    link {bar foo}
    # The method foo is now directly accessible as bar.

    link a b c
    # The methods a, b, and c all become directly acessible under their
    # own names.
```

: Dieser Befehl wird voraussichtlich vor allem in Instanz-Konstruktoren verwendet werden – entweder aus Gründen der Einfachheit oder um bestimmte Methoden für die Verwendung in einer Mini-DSL einzurichten.


**ooutil::singleton** ?*arg*...?
: Dieser Befehl ist eine Metaklasse, d. h. eine Variante des integrierten Befehls **oo::class**, die sicherstellt, dass nur eine einzige Instanz der damit definierten Klassen erstellt wird. Syntax und Ergebnisse entsprechen denen von **oo::class**. Beispiel:


```
% oo::class create example {
   self mixin singleton
   method foo {} {self}
}
::example
% [example new] foo
::oo::Obj22
% [example new] foo
::oo::Obj22
```

# AUTOREN

Donal Fellows, Andreas Kupries

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *oo::util* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hilfsprogramme

# COPYRIGHT

```
Copyright (c) 2011-2015 Andreas Kupries, BSD licensed
```
