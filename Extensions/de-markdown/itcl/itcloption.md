---
CommandName: option
title: option
ManualSection: n
Version: 4.0
TclPart: itcl
TclDescription: "[incr Tcl]"
Keywords:
 - option
 - widget
 - widgetadaptor
 - extendedclass
Copyright:
 - Copyright (c) 2008 Arnulf Wiedemann
---

# Name

itcl::option - Optionen für extendedclass, widget oder widgetadaptor definieren

Teile dieser Beschreibung sind von der Tcl-Erweiterung \[snit\] „entliehen“, weil die Funktion weitgehend gleich ist.

# Warnung

Das ist neue Funktionalität in \[incr Tcl\], bei der sich die API noch ändern kann!!

# Übersicht

::: {.synopsis} :::
[option]{.cmd} [optionSpec]{.arg} [defaultValue]{.optarg}
[option]{.cmd} [optionSpec]{.arg} [options]{.optarg}
:::

# Beschreibung

Der Befehl **option** wird innerhalb einer Definition extendedclass/widget/widgetadaptor von **\[incr Tcl\]** verwendet, um Optionen zu definieren.

Die erste Form definiert eine Option für Instanzen dieses Typs und gibt ihr optional einen Anfangswert. Der Anfangswert ist die leere Zeichenkette, wenn kein defaultValue angegeben ist.

Eine so definierte Option gilt als lokal definiert. Die optionSpec ist eine Liste, die den Namen der Option, den Ressourcennamen und den Klassennamen definiert, zum Beispiel:

```
    option {-font font Font} {Courier 12}
```

Der Optionsname muss mit einem Bindestrich beginnen und darf keine Großbuchstaben enthalten. Ressourcenname und Klassenname sind optional; fehlen sie, ist der Ressourcenname voreingestellt der Optionsname ohne den Bindestrich, und der Klassenname ist voreingestellt der Ressourcenname mit großem Anfangsbuchstaben. Die folgende Anweisung entspricht deshalb dem vorherigen Beispiel:

```
    option -font {Courier 12}
```

Weitere Angaben zu Ressourcen- und Klassennamen stehen in der Optionsdatenbank von Tk.

Optionen werden gewöhnlich mit den Standard-Instanzmethoden configure und cget gesetzt und abgefragt; im Instanzcode (Methodenrümpfe und so weiter) stehen die Optionswerte über das Array options zur Verfügung:

```
    set myfont $itcl_options(-font)
```

In der zweiten Form lassen sich Optionsbehandler definieren (zum Beispiel -configuremethod); der Code sollte dann wahrscheinlich configure und cget verwenden, um auf seine Optionen zuzugreifen und subtile Fehler zu vermeiden.

Die Anweisung option kann die folgenden Optionen enthalten:

**-default** *defvalue*
: Legt den Vorgabewert der Option fest; sonst ist der Vorgabewert der Option "".

**-readonly**
: Die Option wird nur lesbar behandelt: sie lässt sich mit configure nur zur Erzeugungszeit setzen, also im Konstruktor des Typs.

**-cgetmethod** *methodName*
: Jede lokal definierte Option darf eine -cgetmethod definieren; sie wird aufgerufen, wenn der Wert der Option mit der Methode cget abgefragt wird. Was der Rumpf der Methode zurückgibt, ist der Rückgabewert des Aufrufs von cget.

    Die genannte Methode muss ein Argument nehmen, den Optionsnamen. Dieser Code entspricht zum Beispiel der voreingestellten cget-Behandlung von Itcl, ist aber langsamer:

    ```
            option -font -cgetmethod GetOption
            method GetOption {option} {
                return $itcl_options($option)
            }
    ```

    Beliebig viele Optionen können sich eine -cgetmethod teilen.

**-cgetmethodvar** *varName*
: Das ist -cgetmethod sehr ähnlich, der einzige Unterschied ist, dass sich eine Variable angeben lässt, in der die cgetmethod zur Laufzeit zu finden ist.

**-configuremethod** *methodName*
: Jede lokal definierte Option darf eine -configuremethod definieren; sie wird aufgerufen, wenn der Wert der Option mit den Methoden configure oder configurelist gesetzt wird. Die genannte Methode muss den Wert der Option selbst speichern; der Wert wird also nur dann im Array itcl\_options() gespeichert, wenn die Methode ihn dort speichert.

    Die genannte Methode muss zwei Argumente nehmen, den Optionsnamen und seinen neuen Wert. Dieser Code entspricht zum Beispiel der voreingestellten configure-Behandlung von Itcl, ist aber langsamer:

    ```
            option -font -configuremethod SetOption
            method SetOption {option value} {
                set itcl_options($option) $value
            }
    ```

    Beliebig viele Optionen können sich eine einzelne -configuremethod teilen.

**-configuremethodvar** *varName*
: Das ist -configuremethod sehr ähnlich, der einzige Unterschied ist, dass sich eine Variable angeben lässt, in der die configuremethod zur Laufzeit zu finden ist.

**-validatemethod** *methodName*
: Jede lokal definierte Option darf eine -validatemethod definieren; sie wird aufgerufen, wenn der Wert der Option mit den Methoden configure oder configurelist gesetzt wird, unmittelbar vor der -configuremethod (falls vorhanden). Die genannte Methode muss den neuen Wert der Option prüfen und einen Fehler melden, wenn der Wert ungültig ist.

    Die genannte Methode muss zwei Argumente nehmen, den Optionsnamen und seinen neuen Wert. Dieser Code prüft zum Beispiel, dass der Wert von -flag ein gültiger boolescher Wert ist:

    ```
            option -font -validatemethod CheckBoolean
            method CheckBoolean {option value} {
                if {![string is boolean -strict $value]} {
                    error "option $option must have a boolean value."
                }
            }
    ```

    Beliebig viele Optionen können sich eine einzelne -validatemethod teilen.

**-validatemethodvar** *varName*
: Das ist -validatemethod sehr ähnlich, der einzige Unterschied ist, dass sich eine Variable angeben lässt, in der die validatemethod zur Laufzeit zu finden ist.
