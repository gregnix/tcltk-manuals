---
CommandName: ensemble
ManualSection: n
Version: 3.0
TclPart: itcl
TclDescription: "[incr\\ Tcl]"
Keywords:
 - ensemble
 - part
 - info
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# NAME

itcl::ensemble - einen zusammengesetzten Befehl erzeugen oder ändern

# ÜBERSICHT

::: {.synopsis} :::
[itcl::ensemble]{.cmd} [ensName]{.arg} [command arg arg]{.optdot} 
[ensemble]{.cmd} [ensName]{.arg} { 
[part]{.cmd} [partName]{.arg} [args]{.arg} [body]{.arg} 
...
[ensemble]{.cmd} [partName]{.arg} { 
[part]{.cmd} [subPartName]{.arg} [args]{.arg} [body]{.arg} 
[part]{.cmd} [subPartName]{.arg} [args]{.arg} [body]{.arg} 
...
}
}
:::

oder

# BESCHREIBUNG

Der Befehl **ensemble** erzeugt einen zusammengesetzten Befehl oder ändert ihn. Ein kurzer Überblick über Ensembles steht unten im Abschnitt **WAS IST EIN ENSEMBLE?**.

Wenn der Befehl **ensemble** ein vorhandenes Ensemble namens *ensName* findet, aktualisiert er dieses Ensemble. Sonst erzeugt er ein Ensemble namens *ensName*. Wenn der *ensName* ein einfacher Name wie „foo“ ist, wird dem aktuellen Namespace-Kontext ein Ensemble-Befehl namens „foo“ hinzugefügt. Wenn in diesem Kontext bereits ein Befehl namens „foo“ existiert, wird er gelöscht. Wenn der *ensName* Namespace-Qualifizierer wie „a::b::foo“ enthält, wird der Namespace-Pfad aufgelöst, und der Ensemble-Befehl wird diesem Namespace-Kontext hinzugefügt. Übergeordnete Namespaces wie „a“ und „b“ werden bei Bedarf automatisch erzeugt.

Wenn der *ensName* Leerzeichen enthält wie „a::b::foo bar baz“, werden weitere Wörter wie „bar“ und „baz“ als Unter-Ensembles behandelt. Unter-Ensembles sind lediglich Teile innerhalb eines Ensembles; ihnen ist kein Tcl-Befehl zugeordnet. Ein Ensemble wie „foo“ kann ein Unter-Ensemble „foo bar“ haben, das seinerseits ein Unter-Ensemble „foo bar baz“ haben kann. In diesem Fall muss das Unter-Ensemble „foo bar“ erzeugt werden, bevor das Unter-Ensemble „foo bar baz“ erzeugt wird, das in ihm liegt.

Wenn auf *ensName* Argumente folgen, werden sie als Befehle behandelt und ausgeführt, um das Ensemble zu aktualisieren. In diesem Zusammenhang werden die folgenden Befehle erkannt: **part** und **ensemble**.

Der Befehl **part** definiert einen neuen Teil des Ensembles. Seine Syntax ist mit dem gewöhnlichen Befehl **proc** identisch, er definiert aber einen Teil innerhalb eines Ensembles statt eines Tcl-Befehls. Wenn im Ensemble bereits ein Teil namens *partName* existiert, gibt der Befehl **part** einen Fehler zurück.

Der Befehl **ensemble** kann in einem anderen Befehl **ensemble** verschachtelt werden, um ein Unter-Ensemble zu definieren.

# WAS IST EIN ENSEMBLE?

Der gewöhnliche Befehl „info“ ist ein zusammengesetzter Befehl: auf den Befehlsnamen **info** muss ein Unterbefehl wie **body** oder **globals** folgen. Ein Befehl wie **info** wird hier *Ensemble* genannt, Unterbefehle wie **body** oder **globals** seine *Teile*.

Ensembles können verschachtelt sein. Der Befehl **info** hat zum Beispiel ein Ensemble **info namespace** in sich. Dieses Ensemble hat Teile wie **info namespace all** und **info namespace children**.

Mit Ensembles lassen sich zusammengesetzte Befehle automatisch erzeugen und erweitern. Jedes Paket kann ein vorhandenes Ensemble finden und ihm neue Teile hinzufügen. Autoren von Erweiterungen können zum Beispiel dem Befehl **info** eigene Teile hinzufügen.

Die Ensemble-Einrichtung verwaltet alle Teilnamen und merkt sich eindeutige Abkürzungen. Gewöhnlich lässt sich **info complete** zu **info comp** abkürzen. Wenn eine Erweiterung aber den Teil **info complexity** hinzufügt, wird die kürzeste Abkürzung für **info complete** zu **info complet**.

Die Ensemble-Einrichtung automatisiert nicht nur den Bau zusammengesetzter Befehle, sondern auch die Fehlerbehandlung. Wird ein Ensemble-Befehl ohne Teilnamen aufgerufen, entsteht eine automatisch erzeugte Fehlermeldung, die die Verwendung zusammenfasst. Wenn der Befehl **info** zum Beispiel ohne Argumente aufgerufen wird, erzeugt er die folgende Fehlermeldung:

```
wrong # args: should be one of...
  info args procname
  info body procname
  info cmdcount
  info commands ?pattern?
  info complete command
  info context
  info default procname arg varname
  info exists varName
  info globals ?pattern?
  info level ?number?
  info library
  info locals ?pattern?
  info namespace option ?arg arg ...?
  info patchlevel
  info procs ?pattern?
  info protection ?-command? ?-variable? name
  info script
  info tclversion
  info vars ?pattern?
  info which ?-command? ?-variable? ?-namespace? name
```

Auch die Reaktion eines Ensembles auf Fehler lässt sich anpassen. Wenn ein Ensemble auf einen nicht angegebenen oder mehrdeutigen Teilnamen trifft, sucht es einen Teil namens **@error**. Wenn der existiert, behandelt er den Fehler. Dieser Teil erhält alle Argumente der Befehlszeile, beginnend mit dem beanstandeten Teilnamen. Er kann den Befehl auf einem anderen Weg auflösen oder eine eigene Fehlermeldung erzeugen.

# BEISPIEL

Ein Ensemble könnte die Syntax der verschiedenen „wait“-Befehle in Tcl/Tk aufräumen. Statt einer Reihe eigenartiger Befehle wie dieser:

```
vwait x
tkwait visibility .top
tkwait window .
```

ließen sich Befehle mit einheitlicher Syntax verwenden, so:

```
wait variable x
wait visibility .top
wait window .
```

Das Paket Tcl könnte das folgende Ensemble definieren:

```
itcl::ensemble wait part variable {name} {
    uplevel vwait $name
}
```

Das Paket Tk könnte diesem Ensemble einige Optionen hinzufügen, mit einem Befehl wie diesem:

```
itcl::ensemble wait {
    part visibility {name} {
        tkwait visibility $name
    }
    part window {name} {
        tkwait window $name
    }
}
```

Andere Erweiterungen könnten dem Befehl **wait** ebenfalls eigene Teile hinzufügen.
