---
CommandName: uevent::onidle
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: User events
Keywords:
 - callback
 - deferal
 - event
 - idle
 - merge
 - on-idle
Copyright:
 - Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

uevent::onidle – Antrag auf Zusammenlegung und Verschiebung in die Leerlaufzeit

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [uevent::onidle]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[::uevent::onidle]{.cmd} [objectName]{.arg} [commandprefix]{.arg} 
[objectName]{.ins} [request]{.sub} 
:::

# BESCHREIBUNG

Dieses Paket stellt Objekte bereit, mit denen mehrere Anfragen für eine Aktion zusammengefasst und die Aktion ausgeführt werden können, sobald das System (die Ereignisschleife) nicht mehr ausgelastet ist. Die auszuführende Aktion wird bei der Erstellung des Objekts konfiguriert.

# API

Das Paket exportiert eine Klasse namens „**uevent::onidle**“, wie im Folgenden beschrieben.

**::uevent::onidle** *objectName* *commandprefix*
: Der Befehl erstellt ein neues *onidle*-Objekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *objectName* lautet. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Objekt auszuführen. Das *commandprefix* ist die Aktion, die ausgeführt werden soll, wenn die Ereignisschleife im Leerlauf ist und der Benutzer dies über die Methode **request** angefordert hat (siehe unten). Die durch die oben genannten Klassenbefehle erstellten Objektbefehle haben folgende Form:

*objectName* **request**
: Diese Methode fordert die Ausführung des bei der Erstellung von *objectName* festgelegten Befehlspräfixes an, sobald die Ereignisschleife das nächste Mal inaktiv ist. Mehrere Anfragen werden zusammengefasst und führen zu nur einer einzigen Ausführung des Befehlspräfixes.


# BEISPIELE

Beispiele für diese Art der Verzögerung finden sich in den (C-Level-)Implementierungen aller Tk-Widgets, in denen Geometrieberechnungen und das Neuzeichnen von Fenstern auf diese Weise verzögert werden.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *uevent* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# COPYRIGHT

```
Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
