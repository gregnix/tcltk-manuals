---
CommandName: history
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Keywords:
 - event
 - history
 - record
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# NAME

history - Manipuliert die Verlaufsliste

# ÜBERSICHT

::: {.synopsis} :::
[history]{.cmd} [option]{.optarg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **history** führt eine von mehreren Operationen aus, die sich auf kürzlich ausgeführte Befehle beziehen, die in einer Verlaufsliste gespeichert sind. Jeder dieser gespeicherten Befehle wird als „Ereignis“ bezeichnet. Beim Angeben eines Ereignisses für **history** können folgende Formen verwendet werden:

1. Eine Zahl: Ist sie positiv, bezieht sie sich auf das Ereignis mit dieser Nummer (alle Ereignisse werden ab 1 nummeriert). Ist die Zahl negativ, wählt sie ein Ereignis relativ zum aktuellen Ereignis (**-1** bezieht sich auf das vorherige Ereignis, **-2** auf das davor, und so weiter). Ereignis **0** bezeichnet das aktuelle Ereignis.

2. Eine Zeichenkette: Wählt das jüngste Ereignis, das zur Zeichenkette passt. Ein Ereignis gilt als passend, wenn die Zeichenkette mit den ersten Zeichen des Ereignisses übereinstimmt oder wenn die Zeichenkette im Sinne des Befehls **string match** zum Ereignis passt.


Der Befehl **history** kann eine der folgenden Formen annehmen:

**history**
: Entspricht **history info**, siehe unten.

**history add** *command* ?**exec**?
: Fügt das Argument *command* als neues Ereignis zur Verlaufsliste hinzu. Ist **exec** angegeben (oder abgekürzt), wird der Befehl auch ausgeführt und sein Ergebnis zurückgegeben. Ist **exec** nicht angegeben, wird als Ergebnis eine leere Zeichenkette zurückgegeben.

**history change** *newValue* ?*event*?
: Ersetzt den für ein Ereignis gespeicherten Wert durch *newValue*. *Event* gibt das zu ersetzende Ereignis an und standardmäßig das *aktuelle* Ereignis (nicht Ereignis **-1**). Der Befehl ist für Befehle gedacht, die neue Formen der Verlaufssubstitution implementieren und das aktuelle Ereignis (das die Substitution auslöst) durch den durch Substitution erzeugten Befehl ersetzen wollen. Der Rückgabewert ist eine leere Zeichenkette.

**history clear**
: Löscht die Verlaufsliste. Das aktuelle Behalte-Limit bleibt erhalten. Die Ereignisnummern werden zurückgesetzt.

**history event** ?*event*?
: Gibt den Wert des durch *event* angegebenen Ereignisses zurück. *Event* standardmäßig **-1**.

**history info** ?*count*?
: Gibt eine formatierte Zeichenkette zurück (für Menschen lesbar) mit Ereignisnummer und Inhalt für jedes Ereignis in der Verlaufsliste außer dem aktuellen. Ist *count* angegeben, werden nur die *count* jüngsten Ereignisse zurückgegeben.

**history keep** ?*count*?
: Kann verwendet werden, um die Größe der Verlaufsliste auf *count* Ereignisse zu ändern. Anfangs werden 20 Ereignisse in der Verlaufsliste behalten. Ist *count* nicht angegeben, wird das aktuelle Behalte-Limit zurückgegeben.

**history nextid**
: Gibt die Nummer des nächsten in der Verlaufsliste zu speichernden Ereignisses zurück. Nützlich etwa zum Anzeigen der Ereignisnummer in Kommandozeilen-Prompts.

**history redo** ?*event*?
: Führt den durch *event* angegebenen Befehl erneut aus und gibt sein Ergebnis zurück. *Event* standardmäßig **-1**. Dieser Befehl führt zu einer Verlaufsrevision; siehe unten.


# VERLAUFS-REVISION

Tcl vor Version 8.0 hatte einen komplexen Mechanismus zur Verlaufsrevision. Der aktuelle Mechanismus ist eingeschränkter; die alten Verlaufsoperationen **substitute** und **words** wurden entfernt. (Als Trost wurde die Operation **clear** hinzugefügt.)

Die Verlaufsoption **redo** führt zu einer deutlich einfacheren „Verlaufsrevision“. Wird diese Option aufgerufen, wird das jüngste Ereignis so geändert, dass der Befehl **history** entfernt und durch das Ergebnis des Befehls **history** ersetzt wird. Soll ein Ereignis ohne Änderung des Verlaufs erneut ausgeführt werden, verwenden Sie die Operation **event**, um ein Ereignis abzurufen, und die Operation **add**, um es zum Verlauf hinzuzufügen und auszuführen.
