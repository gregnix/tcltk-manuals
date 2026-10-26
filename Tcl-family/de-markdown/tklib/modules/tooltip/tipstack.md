---
CommandName: tipstack
title: tipstack
ManualSection: n
Version: 1.0.1
TclPart: tklib
TclDescription: Tooltip management
Keywords:
 - balloon
 - help
 - hover
 - tipstack
Copyright:
 - Copyright (c) 2003 ActiveState Corp
---

# Name

tipstack – Gestapelte Tooltips

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [msgcat]{.lit} [1.3]{.lit}
[package]{.cmd} [require]{.sub} [tooltip]{.lit} [1.7]{.optlit}
[package]{.cmd} [require]{.sub} [tipstack]{.lit} [1.0.1]{.optlit}
[::tipstack::push]{.cmd} [widget]{.arg} [[-index]{.lit} [index]{.arg}]{.optarg} [text]{.arg}
[::tipstack::pop]{.cmd} [widget]{.arg} [[-index]{.lit} [index]{.arg}]{.optarg}
[::tipstack::clear]{.cmd} [widget]{.arg} [[-index]{.lit} [index]{.arg}]{.optarg}
[::tipstack::def]{.cmd} [widget]{.arg} [text]{.arg} ...
[::tipstack::defsub]{.cmd} [base]{.arg} [widget]{.arg} [text]{.arg} ...
[::tipstack::clearsub]{.cmd} [base]{.arg}
:::

# Beschreibung

Dieses Paket erweitert die Funktionalität des Pakets **tooltip**. Es stellt einen dynamischen Stapel von Hinweistexten pro Widget bereit. Dies ermöglicht dynamische, vorübergehende Änderungen an den Hinweisen, beispielsweise um eine Standarderklärung zu einem Feld vorübergehend durch eine Fehlermeldung zu ersetzen.

# Befehle

**::tipstack::push** *widget* ?**-index** *index*? *text*
: Legt einen neuen *text* auf den Tooltip des *widget*. Bei einem Listen-Widget gilt

    ```
    -index ...
    ```

um den betreffenden Eintrag anzusprechen, für den der
: Tooltip geändert werden soll.

    Das Ergebnis des Befehls ist die leere Zeichenfolge

**::tipstack::pop** *widget* ?**-index** *index*?
: Nimmt den aktuellen Tooltip des *widget* vom Stapel und stellt den vorherigen Text wieder her. Das ist eine leere Operation, wenn der Stapel dadurch leer würde. Der Basistext des Tooltips kann nicht entnommen werden. Bei einem Listen-Widget gilt

    ```
    -index ...
    ```

um den betreffenden Eintrag anzusprechen, für den der
: Tooltip geändert werden soll.

    Das Ergebnis des Befehls ist die leere Zeichenfolge

**::tipstack::clear** *widget* ?**-index** *index*?
: Leert den Stapel des *widget* und stellt den Basiszustand wieder her. Bei einem Listen-Widget gilt

    ```
    -index ...
    ```

um den betreffenden Eintrag anzusprechen, für den der
: Tooltip geändert werden soll.

    Das Ergebnis des Befehls ist die leere Zeichenfolge

**::tipstack::def** *widget* *text* ...
: Legt in einem Aufruf Texte auf mehrere unabhängige *widget*s. Für Listen-Widgets geht das nicht, weil die nötige Indexangabe fehlt. Auch mit Menüs geht es nicht.

    Das Ergebnis ist die leere Zeichenkette.

**::tipstack::defsub** *base* *widget* *text* ...
: Variante von **::tipstack::def**, bei der alle Widgets, auf die ein Text gelegt wird, Unterwidgets von *base* sind. Das passt zu Megawidgets.

    Entweder beginnt jedes *widget* mit einem Punkt (**.**), oder *base* endet mit einem Punkt.

    Das Ergebnis ist die leere Zeichenkette.

**::tipstack::clearsub** *base*
: Variante von **::tipstack::clear**. Sie leert alle Kindwidgets von *base*, auf die Text gelegt wurde. Mit Menüs geht das nicht.

    Das Ergebnis ist die leere Zeichenkette.


# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *tooltip* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Copyright

```
Copyright (c) 2003 ActiveState Corp
```
