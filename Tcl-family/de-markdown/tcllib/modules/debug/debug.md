---
CommandName: debug
ManualSection: n
Version: 1.0.7
TclPart: tcllib
TclDescription: debug narrative
Keywords:
 - debug
 - log
 - narrative
 - trace
Copyright:
 - Copyright (c) 200?, Colin McCormack, Wub Server Utilities
 - Copyright (c) 2012-2014, Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

debug – Debug-Erzählung – Kern

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [debug]{.lit} [1.0.7]{.optlit} 
[debug.tag]{.cmd} [message]{.arg} [level]{.optarg} 
[debug]{.cmd} [2array]{.sub} 
[debug]{.cmd} [define]{.sub} [tag]{.arg} 
[debug]{.cmd} [header]{.sub} [text]{.arg} 
[debug]{.cmd} [level]{.sub} [tag]{.arg} [level]{.optarg} [fd]{.optarg} 
[debug]{.cmd} [names]{.sub} 
[debug]{.cmd} [off]{.sub} [tag]{.arg} 
[debug]{.cmd} [on]{.sub} [tag]{.arg} 
[debug]{.cmd} [parray]{.sub} [arrayvarname]{.arg} 
[debug]{.cmd} [pdict]{.sub} [dict]{.arg} 
[debug]{.cmd} [hexl]{.sub} [data]{.arg} [prefix]{.optarg} 
[debug]{.cmd} [nl]{.sub} 
[debug]{.cmd} [tab]{.sub} 
[debug]{.cmd} [prefix]{.sub} [tag]{.arg} [text]{.optarg} 
[debug]{.cmd} [setting]{.sub} (tag [level)]{.arg} ... [fd]{.optarg} 
[debug]{.cmd} [suffix]{.sub} [tag]{.arg} [text]{.optarg} 
[debug]{.cmd} [trailer]{.sub} [text]{.arg} 
:::

# BESCHREIBUNG

Die für die Fehlersuche relevanten Bereiche werden durch „Tags“ dargestellt, für die unabhängig voneinander Relevanzstufen festgelegt werden können (eine ganze Zahl; je höher, desto detaillierter).

# API

**debug.tag** *message* ?*level*?
: Für jedes bekannte Tag erstellt das Paket einen Befehl mit dieser Signatur, den der Benutzer anschließend verwenden kann, um die Debug-Beschreibung des Tags bereitzustellen. Die Beschreibung *message* wird als Tcl-Skript bereitgestellt, dessen Wert im Geltungsbereich des Aufrufers nur dann per **subst** eingesetzt wird, wenn die aktuelle Detailstufe für das *tag* der Detailstufe *level* des Aufrufs entspricht oder diese übersteigt.  Dies ist nützlich, da man beliebig komplexe Beschreibungen im Code platzieren kann, ohne diese unnötigerweise auswerten zu müssen. Siehe die Methoden **level** und **setting** zum Abfragen und Bearbeiten der aktuellen Detailebene für Tags. Der tatsächlich ausgegebene Text besteht nicht nur aus der *message*, sondern auch aus globalen und tag-spezifischen Präfixen und Suffixen, sofern vorhanden, wobei jede Zeile der Nachricht die angegebenen Kopfzeilen und Nachspanne enthält. Alle diese Teile sind **subst**-fähige Tcl-Skripte, die vor der Zusammenstellung einmal pro Nachricht ersetzt werden.

**debug** **2array**
: Diese Methode gibt ein Dictionary zurück, das die Namen aller dem Paket derzeit bekannten Debug-Tags ihrem Status und ihrer Protokollstufe zuordnet. Letztere werden in einem einzigen numerischen Wert kodiert, wobei eine negative Zahl ein inaktives Tag auf der durch den Absolutwert angegebenen Stufe bezeichnet und eine positive Zahl ein aktives Tag auf dieser Stufe. Siehe auch die Methode **settings** weiter unten.

**debug** **define** *tag*
: Diese Methode registriert den benannten *tag* im Paket. Wenn das Tag zuvor noch nicht bekannt gewesen ist, wird es in einen inaktiven Zustand platziert. Der Zustand eines bereits bekannten Tags bleibt unverändert. Das Ergebnis der Methode ist die leere Zeichenkette.

**debug** **header** *text*
: Diese Methode definiert ein globales **subst**-fähiges Tcl-Skript, das einen Text bereitstellt, der vor jeder Ausgabezeile gedruckt wird. Beachten Sie, dass dies tagunabhängig ist. Beachten Sie ferner, dass die Ersetzung der Kopfzeile nur einmal pro tatsächlich ausgegebener Meldung erfolgt, d. h., alle Zeilen derselben Meldung weisen denselben tatsächlichen Kopfzeilentext auf. Das Ergebnis der Methode ist der angegebene Text.

**debug** **level** *tag* ?*level*? ?*fd*?
: Diese Methode legt die Detailstufe *level* für das *tag* sowie den Kanal *fd* fest, in den die Beschreibung des Tags geschrieben werden soll. *level* ist ein ganzzahliger Wert >= 0, dessen Standardwert **1** lautet. Der Kanal ist standardmäßig auf **stderr** eingestellt. Das Ergebnis der Methode ist die neue Detailstufe für das Tag.

**debug** **names**
: Diese Methode gibt eine Liste zurück, die die Namen aller dem Paket derzeit bekannten Debug-Tags enthält.

**debug** **off** *tag*
: Diese Methode registriert den benannten *tag* im Paket und setzt ihn auf inaktiv. Das Ergebnis der Methode ist die leere Zeichenkette.

**debug** **on** *tag*
: Diese Methode registriert den benannten *tag* als aktiv im Paket. Das Ergebnis der Methode ist die leere Zeichenkette.

**debug** **parray** *arrayvarname*
: Hierbei handelt es sich um eine Methode, die das benannte Array ähnlich wie der integrierte Befehl **parray** formatiert, mit dem Unterschied, dass sie die resultierende Zeichenkette zurückgibt, anstatt sie direkt in **stdout** zu schreiben. Dadurch eignet sie sich für die Verwendung in Debug-Meldungen.

**debug** **pdict** *dict*
: Hierbei handelt es sich um eine Methode, die das Dictionary ähnlich wie der integrierte Befehl **parray** für Arrays formatiert und die resultierende Zeichenkette zurückgibt. Dadurch eignet sie sich für die Verwendung in Debug-Meldungen.

**debug** **hexl** *data* ?*prefix*?
: Dies ist eine Hilfsmethode, die beliebige Daten als Hex-Dump formatiert und gibt die resultierende Zeichenkette zurück. Dadurch eignet sie sich für die Verwendung in Debug-Meldungen. Jeder Zeile des Dumps wird das Präfix *prefix* vorangestellt. Standardmäßig ist dieses Präfix eine leere Zeichenkette.

**debug** **nl**
: Dies ist eine praktische Methode, um ein Zeilenvorschubzeichen (ASCII 0x0a) in eine Debug-Meldung einzufügen.

**debug** **tab**
: Dies ist eine praktische Methode, um ein Tabulatorzeichen (ASCII 0x09) in eine Debug-Meldung einzufügen.

**debug** **prefix** *tag* ?*text*?
: Diese Methode ähnelt der oben beschriebenen Methode **header** insofern, als sie ein **subst**-fähiges Tcl-Skript definiert, das zusätzlichen Text für Debug-Meldungen bereitstellt. Im Gegensatz zu **header** wird der generierte Text der Meldung des Benutzers hinzugefügt, bevor diese in Zeilen aufgeteilt wird, wodurch es sich um eine Erweiterung auf Meldungsebene handelt. Darüber hinaus ist das Skript tagabhängig. Eine Ausnahme bildet das Skript für den Tag **::**, das auf alle Meldungen angewendet wird. Wenn sowohl ein globales als auch ein tagabhängiges Präfix vorhanden sind, werden beide angewendet, wobei das globale Präfix vor dem tagabhängigen Präfix steht. Beachten Sie, dass die Präfixersetzung nur einmal pro tatsächlich ausgegebener Meldung erfolgt. Das Ergebnis der Methode ist die leere Zeichenkette. Wenn das *tag* zum Zeitpunkt des Aufrufs noch nicht bekannt war, wird es registriert und als inaktiv markiert.

**debug** **setting** (*tag* *level*) ... ?*fd*?
: Diese Methode ist eine Multi-Tag-Variante der oben genannten Methode **level**, in die zudem die Funktionalität der Methoden **on** und **off** integriert ist. Jedes benannte *tag* wird auf die ihm folgende Detailstufe *level* gesetzt, wobei eine negative Stufe das Tag deaktiviert und eine positive Stufe es aktiviert. Wenn auf das letzte Argument keine Stufe folgt, wird es nicht als Tag-Name behandelt, sondern als Kanal, in den alle benannten Tags ihre Meldungen ausgeben sollen. Das Ergebnis der Methode ist die leere Zeichenkette.

**debug** **suffix** *tag* ?*text*?
: Diese Methode ähnelt der unten aufgeführten Methode **trailer** insofern, als sie ein **subst**-fähiges Tcl-Skript definiert, das zusätzlichen Text für Debug-Meldungen bereitstellt. Im Gegensatz zu **trailer** wird der generierte Text der Meldung des Benutzers hinzugefügt, bevor diese in Zeilen aufgeteilt wird, wodurch es sich um eine Erweiterung auf Meldungsebene handelt. Darüber hinaus ist das Skript tagabhängig. Als Ausnahme davon wird ein Skript für das Tag **::** auf alle Meldungen angewendet. Wenn sowohl ein globales als auch ein tagabhängiges Suffix vorhanden sind, werden beide angewendet, wobei das globale Suffix nach dem tagabhängigen Suffix folgt. Beachten Sie, dass die Ersetzung der Suffixe nur einmal pro tatsächlich ausgegebener Meldung erfolgt. Das Ergebnis der Methode ist die leere Zeichenkette. Wenn das *tag* zum Zeitpunkt des Aufrufs noch nicht bekannt war, wird es registriert und als inaktiv markiert.

**debug** **trailer** *text*
: Diese Methode definiert ein globales **subst**-fähiges Tcl-Skript, das einen Text bereitstellt, der nach jeder Ausgabezeile (jedoch vor dem Zeilenende) ausgegeben wird. Hinweis: Dies ist tagunabhängig. Hinweis: Die Ersetzung des Nachspanns erfolgt nur einmal pro tatsächlich ausgegebener Meldung, d. h., alle Zeilen derselben Meldung erhalten denselben tatsächlichen Nachspann. Das Ergebnis der Methode ist der angegebene Text.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *debug* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Debugging, Ablaufverfolgung und Protokollierung

# COPYRIGHT

```
Copyright (c) 200?, Colin McCormack, Wub Server Utilities
Copyright (c) 2012-2014, Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
