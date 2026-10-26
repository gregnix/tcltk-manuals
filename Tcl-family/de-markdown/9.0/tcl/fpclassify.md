---
CommandName: fpclassify
title: fpclassify
ManualSection: n
Version: 9.0
TclPart: Tcl
TclDescription: Tcl Float Classifier
Links:
 - expr(n)
 - mathfunc(n)
Keywords:
 - floating point
Copyright:
 - Copyright (c) 2018 Kevin B. Kenny <kennykb@acm.org>. All rights reserved
 - Copyright (c) 2019 Donal Fellows
---

# Name

fpclassify - Klassifikation von Gleitkommazahlen bei Tcl-Werten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl]{.lit} [9.0]{.lit}
[fpclassify]{.cmd} [value]{.arg}
:::

# Beschreibung

Der Befehl **fpclassify** nimmt eine Gleitkommazahl *value* und gibt eine der folgenden beschreibenden Zeichenketten zurück:

**zero**
: *value* ist eine Gleitkomma-Null.

**subnormal**
: *value* ist das Ergebnis eines graduellen Underflows.

**normal**
: *value* ist eine gewöhnliche Gleitkommazahl (weder Null, subnormal, unendlich noch NaN).

**infinite**
: *value* ist eine Gleitkomma-Unendlichkeit.

**nan**
: *value* ist Not-a-Number.


Der Befehl **fpclassify** löst einen Fehler aus, wenn *value* kein Gleitkommawert ist und nicht in einen umgewandelt werden kann.

# Beispiel

Dies zeigt, wie geprüft wird, ob das Ergebnis einer Berechnung numerisch sicher ist. (Es schützt jedoch nicht vor numerischen Fehlern, sondern nur vor Darstellungsproblemen.)

```
set value [command-that-computes-a-value]
switch [fpclassify $value] {
    normal - zero {
        puts "Result is $value"
    }
    infinite {
        puts "Result is infinite"
    }
    subnormal {
        puts "Result is $value - WARNING! precision lost"
    }
    nan {
        puts "Computation completely failed"
    }
}
```

# Standards

Dieser Befehl setzt voraus, dass das C-Makro **fpclassify**() der Norm „ISO C99“ entspricht (d. h. ISO/IEC 9899:1999).

# Copyright

```
Copyright © 2018 Kevin B. Kenny <kennykb@acm.org>. All rights reserved
```
