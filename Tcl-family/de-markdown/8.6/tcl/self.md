---
CommandName: self
title: self
ManualSection: n
Version: 0.1
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - info(n)
 - next(n)
Keywords:
 - call
 - introspection
 - object
Copyright:
 - Copyright (c) 2007 Donal K. Fellows
---

# Name

self - Interne Introspektion bei Methodenaufrufen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [TclOO]{.lit}

[self]{.cmd} [subcommand]{.optarg}
:::

# Beschreibung

Der Befehl **self**, der nur innerhalb des Kontexts eines Methodenaufrufs verwendet werden sollte (d. h. im Rumpf einer Methode, eines Konstruktors oder Destruktors), ermöglicht es der Methode, Informationen darüber zu ermitteln, wie sie aufgerufen wurde. Er nimmt ein Argument *subcommand* entgegen, das angibt, welche Art von Information gewünscht ist; fehlt es, entspricht das Ergebnis dem von **self object**. Die unterstützten Unterbefehle sind:

**self call**
: Gibt eine Liste mit zwei Elementen zurück, die die zur Implementierung der aktuellen Aufrufkette verwendeten Methodenimplementierungen beschreibt. Das erste Element entspricht dem, was [info object][info] **call** für die aktuelle Methode melden würde (außer dass hier auch sinnvolle Werte aus Konstruktoren und Destruktoren geliefert werden, deren Namen als **<constructor>** bzw. **<destructor>** gemeldet werden), und das zweite Element ist ein Index in die Liste des ersten Elements, der angibt, welche Implementierung gerade ausgeführt wird (die erste auszuführende Implementierung steht stets bei Index 0).

**self caller**
: Wurde die Methode von innerhalb einer anderen Objektmethode aufgerufen, gibt dieser Unterbefehl eine Liste mit drei Elementen zurück, die das enthaltende Objekt und die Methode beschreiben. Das erste Element beschreibt das deklarierende Objekt oder die Klasse der Methode, das zweite ist der Name des Objekts, auf dem die enthaltende Methode aufgerufen wurde, und das dritte ist der Name der Methode (wobei die Zeichenketten **<constructor>** und **<destructor>** Konstruktoren bzw. Destruktoren kennzeichnen).

**self class**
: Gibt den Namen der Klasse zurück, in der die aktuelle Methode definiert wurde. Beachten Sie, dass sich dieser Wert ändert, wenn die Kette der Methodenimplementierungen mit [next] durchlaufen wird, und dass dies fehlschlägt, wenn die Methode auf einem Objekt definiert wurde.

    Wenn Sie die Klasse des aktuellen Objekts benötigen, verwenden Sie stattdessen:

    ```
    info object class [self object]
    ```

**self filter**
: Wird er innerhalb eines Filters aufgerufen, gibt dieser Unterbefehl eine Liste mit drei Elementen zurück, die den Filter beschreibt. Das erste Element gibt den Namen des Objekts oder der Klasse an, die den Filter deklariert hat (dies kann von dem Objekt oder der Klasse abweichen, die die Implementierung des Filters bereitstellt), das zweite ist entweder **object** oder **class**, je nachdem ob die deklarierende Entität ein Objekt oder eine Klasse war, und das dritte ist der Name des Filters.

**self method**
: Gibt den Namen der aktuellen Methode zurück (wobei die Zeichenketten **<constructor>** und **<destructor>** Konstruktoren bzw. Destruktoren kennzeichnen).

**self namespace**
: Gibt den Namen des eindeutigen Namespace des Objekts zurück, auf dem die Methode aufgerufen wurde.

**self next**
: Wird er von einer Methode aufgerufen, die nicht am Ende einer Aufrufkette steht (d. h. wo der Befehl [next] eine tatsächliche Methodenimplementierung aufrufen wird), gibt dieser Unterbefehl eine Liste mit zwei Elementen zurück, die das nächste Element in der Methodenaufrufkette beschreibt; das erste Element ist der Name der Klasse oder des Objekts, die den nächsten Teil der Aufrufkette deklariert, und das zweite ist der Name der Methode (wobei die Zeichenketten **<constructor>** und **<destructor>** Konstruktoren bzw. Destruktoren kennzeichnen). Wird er von einer Methode am Ende einer Aufrufkette aufgerufen, gibt dieser Unterbefehl die leere Zeichenkette zurück.

**self object**
: Gibt den Namen des Objekts zurück, auf dem die Methode aufgerufen wurde.

**self target**
: Wird er innerhalb einer Filterimplementierung aufgerufen, gibt dieser Unterbefehl eine Liste mit zwei Elementen zurück, die die gefilterte Methode beschreibt. Das erste Element ist der Name des Deklarators der Methode, das zweite der tatsächliche Name der Methode.


# Beispiele

Dieses Beispiel zeigt die grundlegende Verwendung von **self**, um Informationen über das aktuelle Objekt zu liefern:

```
oo::class create c {
    method foo {} {
        puts "this is the [self] object"
    }
}
c create a
c create b
a foo                → prints "this is the ::a object"
b foo                → prints "this is the ::b object"
```

Dies veranschaulicht, wie eine Methodenaufrufkette aussieht und wie sich der Index beim Durchlaufen ändert:

```
oo::class create c {
    method x {} {
        puts "Cls: [self call]"
    }
}
c create a
oo::objdefine a {
    method x {} {
        puts "Obj: [self call]"
        next
        puts "Obj: [self call]"
    }
}
a x     → Obj: {{method x object method} {method x ::c method}} 0
        → Cls: {{method x object method} {method x ::c method}} 1
        → Obj: {{method x object method} {method x ::c method}} 0
```


[info]: info.md
[next]: next.md
