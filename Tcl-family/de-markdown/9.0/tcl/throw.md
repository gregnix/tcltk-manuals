---
CommandName: throw
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - catch(n)
 - error(n)
 - errorCode(n)
 - errorInfo(n)
 - return(n)
 - try(n)
Keywords:
 - error
 - exception
Copyright:
 - Copyright (c) 2008 Donal K. Fellows
---

# NAME

throw - Erzeugt einen maschinenlesbaren Fehler

# ÜBERSICHT

::: {.synopsis} :::
[throw]{.cmd} [type]{.arg} [message]{.arg} 
:::

# BESCHREIBUNG

Dieser Befehl bricht die aktuelle Auswertung mit einem Fehler ab. Der Fehler wird durch die Argumente *type* und *message* beschrieben: *type* muss eine Liste von Wörtern enthalten, die den Fehler in maschinenlesbarer Form beschreiben (und den error-code-Teil des Ergebnis-Dictionarys bilden), *message* soll Text für die Anzeige an Menschen enthalten.

Der Stack wird entwunden, bis der Fehler von einem passenden **catch**- oder **try**-Befehl abgefangen wird. Erreicht er die Event-Schleife ungefangen, wird er über den Mechanismus **bgerror** gemeldet. Erreicht er in **tclsh** die oberste Skriptebene, wird er auf der Konsole ausgegeben und beendet im nicht-interaktiven Fall das Programm (in anderen Programmen hängt das Verhalten von der Einbettung von Tcl ab).

Üblicherweise gehen die Wörter in *type* vom Allgemeinsten zum Spezifischsten.

# BEISPIELE

Erzeugt einen Fehler, der dem von **expr** beim Dividieren durch Null entspricht:

```
throw {ARITH DIVZERO {divide by zero}} {divide by zero}
```
