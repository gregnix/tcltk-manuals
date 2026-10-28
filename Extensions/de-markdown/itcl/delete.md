---
CommandName: delete
title: delete
ManualSection: n
Version: 3.0
TclPart: itcl
TclDescription: "[incr Tcl]"
Keywords:
 - namespace
 - proc
 - variable
 - ensemble
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

itcl::delete - Dinge im Interpreter löschen

# Übersicht

::: {.synopsis} :::
[itcl::delete]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Der Befehl **delete** löscht Dinge im Interpreter. Er ist als Ensemble umgesetzt, sodass Erweiterungen eigene Optionen hinzufügen und das Verhalten dieses Befehls erweitern können. Voreingestellt übernimmt der Befehl **delete** das Zerstören von Namespaces.

Das Argument *option* legt fest, welche Aktion der Befehl ausführt. Die zulässigen *options* (die abgekürzt werden dürfen) sind:

**delete class** *name* ?*name...*?
: Löscht eine oder mehrere Klassen von **\[incr Tcl\]** namens *name*. Dabei werden alle Objekte der Klasse und ebenso alle abgeleiteten Klassen gelöscht.

    Wenn beim Zerstören eines Objekts ein Fehler auftritt, verhindert das die Zerstörung der Klasse und aller übrigen Objekte. Um die gesamte Klasse ohne Rücksicht auf Fehler zu zerstören, dient der Befehl „**delete namespace**“.

**delete object** *name* ?*name...*?
: Löscht ein oder mehrere Objekte von **\[incr Tcl\]** namens *name*. Ein Objekt wird gelöscht, indem alle Destruktoren seiner Klassenhierarchie aufgerufen werden, der Reihe nach vom spezifischsten zum allgemeinsten. Wenn alle Destruktoren erfolgreich sind, werden die dem Objekt zugeordneten Daten gelöscht, und der *name* wird als Befehl aus dem Interpreter entfernt.

    Wenn der Zugriffsbefehl eines Objekts in einem anderen Namespace liegt, kann sein qualifizierter Name verwendet werden:

    ```
    itcl::delete object foo::bar::x
    ```

    Wenn beim Zerstören eines Objekts ein Fehler auftritt, wird der Befehl **delete** abgebrochen, und das Objekt bleibt bestehen. Um ein Objekt ohne Rücksicht auf Fehler zu zerstören, dient der Befehl „**rename**“ dazu, den Zugriffsbefehl des Objekts zu zerstören.

**delete namespace** *name* ?*name...*?
: Löscht einen oder mehrere Namespaces namens *name*. Dabei werden alle Befehle und Variablen im Namespace gelöscht und ebenso alle Kind-Namespaces. Wenn ein Namespace gelöscht wird, wird er automatisch aus den Importlisten aller anderen Namespaces entfernt.
