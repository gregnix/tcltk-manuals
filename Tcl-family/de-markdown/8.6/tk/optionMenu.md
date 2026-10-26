---
CommandName: tk_optionMenu
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - option menu
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

tk_optionMenu - Erstellt ein Options-Menubutton und zugehöriges Menü

# ÜBERSICHT

::: {.synopsis} :::
[tk_optionMenu]{.cmd} [pathName]{.arg} [varName]{.arg} [value]{.arg} [value value]{.optdot} 
:::

# BESCHREIBUNG

Diese Prozedur erstellt einen Options-Menubutton mit dem Namen *pathName* sowie ein zugehöriges Menü. Zusammen ermöglichen sie dem Benutzer, einen der durch die *value*-Argumente angegebenen Werte auszuwählen. Der aktuelle Wert wird in der globalen Variable gespeichert, deren Name durch *varName* angegeben ist, und außerdem als Beschriftung im Options-Menubutton angezeigt. Der Benutzer kann auf den Menubutton klicken, um ein Menü mit allen *value*-Einträgen anzuzeigen und so einen neuen Wert auszuwählen. Sobald ein neuer Wert gewählt wurde, wird er in der Variable gespeichert und im Options-Menubutton angezeigt. Der aktuelle Wert kann auch durch Setzen der Variable geändert werden.

Der Rückgabewert von **tk_optionMenu** ist der Name des mit *pathName* verknüpften Menüs, sodass der Aufrufer dessen Konfigurationsoptionen ändern oder es auf andere Weise manipulieren kann.

# BEISPIEL

```
tk_optionMenu .foo myVar Foo Bar Boo Spong Wibble
pack .foo
```
