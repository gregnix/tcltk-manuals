---
CommandName: usual
ManualSection: n
Version: 3.0
TclPart: itk
TclDescription: "[incr\\ Tk]"
Keywords:
 - itk
 - Archetype
 - component
 - mega-widget
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---


# NAME

usual - Zugriff auf die voreingestellten Befehle zur Optionsbehandlung

für eine Megawidget-Komponente

# ÜBERSICHT

::: {.synopsis} :::
[usual]{.cmd} [tag]{.optarg} [commands]{.optarg} 
:::

# BESCHREIBUNG

Der Befehl **usual** wird außerhalb einer Klassendefinition von **\[incr**\\ **Tcl\]** verwendet, um die übliche Menge der Befehle zur Optionsbehandlung für ein Komponenten-Widget festzulegen. Befehle zur Optionsbehandlung werden verwendet, wenn eine Komponente über die Methode „**itk_component add**“ bei der Basisklasse **Archetype** registriert wird. Sie legen fest, wie die Konfigurationsoptionen der Komponente in die zusammengesetzte Optionsliste des Megawidgets eingehen. Optionen können behalten, umbenannt oder ignoriert werden, wie auf der Handbuchseite von **Archetype** beschrieben.

Es ist mühsam, dieselben Deklarationen jedes Mal erneut einzufügen, wenn Komponenten hinzugefügt werden. Der Befehl **usual** erlaubt es, für jede Widget-Klasse ein Standard-Codefragment zu registrieren, das voreingestellt die Optionen behandelt. Alle Standard-Widgets von Tk haben **usual**-Deklarationen, die in der Bibliothek **\[incr**\\ **Tk\]** definiert sind. Ähnliche **usual**-Deklarationen sollten angelegt werden, sobald eine neue Megawidget-Klasse entworfen wird. In die Deklaration **usual** gehören nur die allgemeinsten Optionen.

Der Name *tag* ist gewöhnlich der Name einer Widget-Klasse und beginnt mit einem Großbuchstaben; jede hier registrierte Zeichenkette lässt sich später jedoch mit dem Befehl **usual** verwenden, der auf der Handbuchseite von **Archetype** beschrieben ist.

Wenn das Argument *commands* angegeben ist, wird es der Zeichenkette *tag* zugeordnet und lässt sich später über **itk_component add** abrufen.

Wenn nur das Argument *tag* angegeben ist, sucht dieser Befehl einen vorhandenen Namen *tag* und gibt die ihm zugeordneten Befehle zurück. Wenn dem Namen *tag* keine Befehle zugeordnet sind, gibt dieser Befehl die leere Zeichenkette zurück.

Wenn keine Argumente angegeben sind, gibt dieser Befehl eine Liste aller zuvor registrierten Namen *tag* zurück.

# BEISPIEL

Es folgt die Deklaration **usual** für das Standard-Widget Button von Tk:

```
itk::usual Button {
    keep -background -cursor -foreground -font
    keep -activebackground -activeforeground -disabledforeground
    keep -highlightcolor -highlightthickness
    rename -highlightbackground -background background Background
}
```

Behalten oder umbenannt werden nur die Optionen, die allen Schaltflächen in einem einzelnen Megawidget gemeinsam wären. Optionen wie „-text“, die einer bestimmten Schaltfläche eigen wären, werden ignoriert.
