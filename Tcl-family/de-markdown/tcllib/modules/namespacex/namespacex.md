---
CommandName: namespacex
ManualSection: n
Version: 0.4
TclPart: tcllib
TclDescription: Namespace utility commands
Keywords:
 - extended namespace
 - info
 - namespace unknown
 - namespace utilities
 - state (de)serialization
 - unknown hooking
 - utilities
Copyright:
 - Copyright (c) 200? Neil Madden (http://wiki.tcl.tk/12790)
 - Copyright (c) 200? Various (http://wiki.tcl.tk/1489)
 - Copyright (c) 2010 Documentation, Andreas Kupries
---

# NAME

namespacex – Befehle für Namespace-Dienstprogramme

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [namespacex]{.lit} [0.4]{.optlit} 
[::namespacex]{.cmd} [hook]{.sub} [add]{.lit} [namespace]{.optarg} [cmdprefix]{.arg} 
[::namespacex]{.cmd} [hook]{.sub} [proc]{.lit} [namespace]{.optarg} [arguments]{.arg} [body]{.arg} 
[::namespacex]{.cmd} [hook]{.sub} [on]{.lit} [namespace]{.optarg} [guardcmdprefix]{.arg} [actioncmdprefix]{.arg} 
[::namespacex]{.cmd} [hook]{.sub} [next]{.lit} [arg...]{.arg} 
[::namespacex]{.cmd} [import]{.sub} [fromns]{.lit} [cmdname]{.arg} [newname]{.optdot} 
[::namespacex]{.cmd} [info]{.sub} [allchildren]{.lit} [namespace]{.arg} 
[::namespacex]{.cmd} [info]{.sub} [allvars]{.lit} [namespace]{.arg} 
[::namespacex]{.cmd} [normalize]{.sub} [namespace]{.arg} 
[::namespacex]{.cmd} [info]{.sub} [vars]{.lit} [namespace]{.arg} [pattern]{.optarg} 
[::namespacex]{.cmd} [state]{.sub} [get]{.lit} [namespace]{.arg} 
[::namespacex]{.cmd} [state]{.sub} [set]{.lit} [namespace]{.arg} [dict]{.arg} 
[::namespacex]{.cmd} [state]{.sub} [drop]{.lit} [namespace]{.arg} 
[::namespacex]{.cmd} [strip]{.sub} [prefix]{.arg} [namespaces]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält eine Reihe von Hilfsprogrammen für die Arbeit mit Namespaces. Die Befehle lassen sich in vier Kategorien einteilen:

**\[1\]**
: Hook-Befehle stellen eine Befehlskette bereit und bearbeiten diese, wodurch der einzelne reguläre **namespace unknown**-Handler ersetzt wird.

**\[2\]**
: Ein Importbefehl ermöglicht es, beliebige Befehle aus einem anderen Namespace zu importieren.

**\[3\]**
: Mit Informationsbefehlen können Variablen und untergeordnete Namespaces abgefragt werden.

**\[4\]**
: Zustandsbefehle bieten die Möglichkeit, Werte von Variablen in einem Namespace zu serialisieren.


# BEFEHLE

**::namespacex hook add** ?*namespace*? *cmdprefix*
: Fügt das *cmdprefix* zur Kette der Handler für unbekannte Befehle hinzu, die aufgerufen werden, wenn der *namespace* andernfalls seinen eigenen Handler für unbekannte Befehle aufrufen würde. Wenn *namespace* nicht angegeben ist, wird *cmdprefix* zur Kette der Handler für den Namensraum des Aufrufers hinzugefügt. Die Kette der *cmdprefix*-Befehle wird in umgekehrter Reihenfolge ihrer Hinzufügung ausgeführt, d. h., der zuletzt hinzugefügte *cmdprefix* wird zuerst ausgeführt. Bei der Ausführung werden *cmdprefix* zusätzliche Argumente angehängt, wie dies bei jedem Handler für unbekannte Befehle eines Namespace der Fall wäre.

**::namespacex hook proc** ?*namespace*? *arguments* *body*
: Fügt der Kette der Handler für den Namespace *namespace* eine anonyme Prozedur hinzu. Wenn *namespace* nicht festgelegt wird, wird der Handler der Kette der Handler für den Namespace des Aufrufers hinzugefügt. Die *arguments* und *body* werden wie beim Kernbefehl **proc** festgelegt.

**::namespacex hook on** ?*namespace*? *guardcmdprefix* *actioncmdprefix*
: Fügt der Kette der Handler für den Namespace *namespace* eine geschützte Aktion hinzu. Wenn *namespace* nicht festgelegt wird, wird der Handler der Kette der Handler für den Namespace des Aufrufers hinzugefügt. Zunächst wird *guardcmdprefix* ausgeführt. Wenn dieser einen Wert gibt, der als „falsch“ interpretiert werden kann, wird der nächste Handler für unbekannte Namenräume in der Kette ausgeführt. Andernfalls wird *actioncmdprefix* ausgeführt, und der Wert, der vom Handler zurückgegeben wird, entspricht dem Wert, der von *actioncmdprefix* zurückgegeben wird. Bei der Ausführung werden sowohl *guardcmdprefix* als auch *actioncmdprefix* mit denselben zusätzlichen Argumenten versehen wie bei jedem Handler für unbekannte Namespaces.

**::namespacex hook next** *arg*...
: Dieser Befehl steht Namespace-Hooks zur Verfügung, um den nächsten Hook in der Kette der Handler für den Namespace auszuführen.

**::namespacex import fromns** *cmdname ?newname* ...?
: Importiert den Befehl *cmdname* aus dem Namespace *fromns* in den Namespace des Aufrufers. Der Befehl *cmdname* wird auch dann importiert, wenn der Namespace *fromns* den Befehl ursprünglich nicht exportiert hat. Wird *newname* angegeben, wird der importierte Befehl unter diesem Namen bekannt sein. Andernfalls behält der Befehl seinen ursprünglichen Namen, wie er durch *cmdname* angegeben wurde. Es können auch weitere Paare von *cmdname*-/*newname*-Argumenten angegeben werden.

**::namespacex info allchildren** *namespace*
: Gibt eine Liste zurück, die die Namen aller untergeordneten Namespaces im angegebenen *namespace* und dessen untergeordneten Namespaces enthält. Die Namen sind alle vollständig qualifiziert.

**::namespacex info allvars** *namespace*
: Gibt eine Liste zurück, die die Namen aller Variablen im angegebenen *namespace* und dessen untergeordneten Namespaces enthält. Die Namen sind alle relativ zum *namespace* angegeben und *nicht* vollständig qualifiziert.

**::namespacex normalize** *namespace*
: Gibt den absoluten Namen von *namespace* zurück, der relativ zum Namensraum des Aufrufers aufgelöst wird, wobei alle nicht benötigten Doppelpunkte entfernt werden.

**::namespacex info vars** *namespace* ?*pattern*?
: Gibt eine Liste zurück, die die Namen aller Variablen im angegebenen *namespace* enthält. Wenn das Argument *pattern* festgelegt wird, werden nur Variablen zurückgegeben, die mit *pattern* übereinstimmen. Die Übereinstimmung wird nach denselben Regeln ermittelt wie bei **string match**.

**::namespacex state get** *namespace*
: Gibt ein Dictionary zurück, das die Namen und Werte aller Variablen im angegebenen *namespace* und dessen untergeordneten Namespaces enthält. Beachten Sie, dass sich alle Namen relativ zum *namespace* beziehen und *nicht* vollständig qualifiziert sind.

**::namespacex state set** *namespace* *dict*
: Nimmt ein Dictionary entgegen, das die Namen und Werte für eine Reihe von Variablen enthält, und ersetzt den aktuellen Zustand des angegebenen *namespace* und seiner untergeordneten Namespaces durch diesen Zustand. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::namespacex state drop** *namespace*
: Löscht alle Variablen im angegebenen *namespace* und dessen untergeordneten Namespaces. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::namespacex strip** *prefix* *namespaces*
: Jedes Element in *namespaces* muss der absolute, normalisierte Name eines untergeordneten Namespaces des Namespaces *prefix* sein. Gibt die entsprechende Liste der relativen Namen der untergeordneten Namespaces zurück.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *namespacex* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# COPYRIGHT

```
Copyright (c) 200? Neil Madden (http://wiki.tcl.tk/12790)
Copyright (c) 200? Various (http://wiki.tcl.tk/1489)
Copyright (c) 2010 Documentation, Andreas Kupries
```
