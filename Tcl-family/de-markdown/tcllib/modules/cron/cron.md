---
CommandName: cron
ManualSection: n
Version: 2.2
TclPart: tcllib
TclDescription: cron
Keywords:
 - cron
 - odie
Copyright:
 - Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
---

# NAME

cron – Tool zur Automatisierung der periodischen Ausführung von Befehlen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [cron]{.lit} [2.2]{.optlit} 
[::cron::at]{.cmd} [processname]{.optarg} [timecode]{.arg} [command]{.arg} 
[::cron::cancel]{.cmd} [processname]{.arg} 
[::cron::every]{.cmd} [processname]{.arg} [frequency]{.arg} [command]{.arg} 
[::cron::in]{.cmd} [processname]{.optarg} [timecode]{.arg} [command]{.arg} 
[::cron::object_coroutine]{.cmd} [object]{.arg} [coroutine]{.arg} [info]{.optarg} 
[::cron::sleep]{.cmd} [milliseconds]{.arg} 
[::cron::task]{.cmd} [delete]{.sub} [process]{.arg} 
[::cron::task]{.cmd} [exists]{.sub} [process]{.arg} 
[::cron::task]{.cmd} [info]{.sub} [process]{.arg} 
[::cron::task]{.cmd} [set]{.sub} [process]{.arg} [field]{.arg} [value]{.arg} [field]{.optdot} [value]{.optdot} 
[::cron::wake]{.cmd} [who]{.optarg} 
[::cron::clock_step]{.cmd} [milliseconds]{.arg} 
[::cron::clock_delay]{.cmd} [milliseconds]{.arg} 
[::cron::clock_sleep]{.cmd} [seconds]{.arg} [offset]{.optarg} 
[::cron::clock_set]{.cmd} [newtime]{.arg} 
:::

# BESCHREIBUNG

Das Paket **cron** stellt eine Reihe von Pure-Tcl-Werkzeugen bereit, mit denen Programme Aufgaben so planen können, dass diese in regelmäßigen Abständen ausgeführt werden. Anstatt jede Aufgabe zu zwingen, einen eigenen Aufruf an die Ereignisschleife zu senden, ahmt das Cron-System das Cron-Dienstprogramm unter Unix nach: Eine Aufgabe prüft in regelmäßigen Abständen, ob etwas zu tun ist, und führt alle Befehle für einen bestimmten Zeitschritt auf einmal aus.

Änderungen in Version 2.0

Während Cron ursprünglich für Zeiträume von mehr als einer Sekunde konzipiert wurde, unterstützt die neueste Version nun eine Zeitauflösung bis auf die Millisekunde, was die Integration mit anderen zeitgesteuerten Ereignissen erleichtert. Version 2.0 ermöglicht zudem die korrekte Integration von Coroutinen und Objekten. Darüber hinaus wurde eine Funktion für eine externe (oder Skript-gesteuerte) Uhr hinzugefügt. Hinweis: Ereignisse im „vwait“-Stil mit einer externen Uhr funktionieren nicht besonders gut.

# BEFEHLE

**::cron::at** *?processname?* *timecode* *command*
: Dieser Befehl registriert einen *command*, der zu dem durch *timecode* angegebenen Zeitpunkt aufgerufen werden soll. Wird *timecode* als Ganzzahl angegeben, wird davon ausgegangen, dass es sich um eine Unix-Zeit handelt. Alle anderen Eingaben werden von **clock scan** interpretiert und in Unix-Zeit umgewandelt. Diese Aufgabe kann durch nachfolgende Aufrufe der Paketbefehle geändert werden, indem auf *processname* verwiesen wird. Falls *processname* bereits existiert, wird er ersetzt. Wird *processname* nicht angegeben, wird ein Name generiert und vom Befehl zurückgegeben.


```
::cron::at start_coffee {Tomorrow at 9:00am}  {remote::exec::coffeepot power on}
::cron::at shutdown_coffee {Tomorrow at 12:00pm}  {remote::exec::coffeepot power off}
```

**::cron::cancel** *processname*
: Dieser Befehl hebt die Registrierung des Prozesses *processname* auf und bricht alle ausstehenden Befehle ab. Hinweis: „processname“ kann ein Prozess sein, der entweder von **::cron::at** oder von **::cron::every** erstellt wurde.


```
::cron::cancel check_mail
```

**::cron::every** *processname* *frequency* *command*
: Dieser Befehl registriert einen *command*, der im Intervall *frequency* aufgerufen werden soll. *frequency* wird in Sekunden angegeben. Diese Aufgabe kann durch nachfolgende Aufrufe der Paketbefehle geändert werden, indem auf *processname* verwiesen wird. Falls *processname* bereits existiert, wird er ersetzt.


```
::cron::every check_mail 900  ::imap_client::check_mail
::cron::every backup_db  3600 {::backup_procedure ::mydb}
```

**::cron::in** *?processname?* *timecode* *command*
: Dieser Befehl registriert einen *command*, der nach einer durch *timecode* festgelegten Verzögerung aufgerufen werden soll. *timecode* wird als Ausdruck in Sekunden angegeben. Diese Aufgabe kann durch nachfolgende Aufrufe der Befehle dieses Pakets unter Bezugnahme auf *processname* geändert werden. Wenn *processname* bereits existiert, wird er ersetzt. Wird *processname* nicht angegeben, gibt der Befehl einen Namen zurück.

**::cron::object_coroutine** *object* *coroutine* *?info?*
: Dieser Befehl registriert eine *coroutine*, die mit *object* verknüpft ist und unter Angabe der Parameter von *info* aufgerufen werden soll. Werden keine Parameter angegeben, wird davon ausgegangen, dass es sich bei der Coroutine um eine Leerlaufaufgabe handelt, die sich selbst beendet. *info* kann in jeder Form angegeben werden, die mit **::cron::task set** kompatibel ist.

**::cron::sleep** *milliseconds*
: Wird dieser Befehl innerhalb einer Coroutine ausgeführt, registriert er die Coroutine für eine Callback-Funktion zum festgelegten Zeitpunkt und führt sofort ein „Yield“ durch. Wenn die Variable ::cron::time größer als 0 ist, erhöht dieser Befehl die interne Zeit schrittweise um jeweils 100 ms. In allen anderen Fällen erzeugt dieser Befehl eine fiktive Variable, löst einen Nachruf aus und wartet mit „vwait“ auf die Variable:


```
set eventid [incr ::cron::eventcount]
set var ::cron::event_#$eventid
set $var 0
::after $ms "set $var 1"
::vwait $var
::unset $var
```

Verwendung:

```
::cron::sleep 250
```

**::cron::task delete** *process*
: Löscht den angegebenen Prozess *process*

**::cron::task exists** *process*
: Gibt „true“ zurück, wenn *process* bei cron registriert ist.

**::cron::task info** *process*
: Gibt ein Dict zurück, das *process* beschreibt. Eine Beschreibung der Optionen finden Sie in **::cron::task set**.

**::cron::task set** *process* *field* *value* *?field...?* *?value...?*
: Wenn der *process* nicht existiert, wird er angelegt. Zu den Optionen gehören:


**command**
: Wenn **coroutine** auf „black“ gesetzt ist, handelt es sich um einen globalen Befehl, der diesen Prozess ausführt. Wenn **coroutine** nicht auf „black“ gesetzt ist, ist dies der Befehl, der zum Erstellen oder erneuten Erstellen der Coroutine aufgerufen werden muss.

**coroutine**
: Der Name der Coroutine (sofern vorhanden), die diesen Prozess implementiert.

**frequency**
: Wenn der Wert -1 ist, wird dieser Prozess nach dem nächsten Ereignis beendet. Wenn der Wert 0 ist, soll dieser Prozess bei jedem Leerlaufereignis aufgerufen werden. Wenn der Wert positiv ist, soll dieser Prozess in regelmäßigen Abständen Ereignisse erzeugen. Die Frequenz ist eine ganze Zahl in Millisekunden, die den Abstand zwischen den Ereignissen angibt.

**object**
: Das Objekt, das diesem Prozess oder dieser Coroutine zugeordnet ist.

**scheduled**
: Wenn der Wert ungleich Null ist, ist dies die absolute Zeit (in Millisekunden) ab der Epoche, nach der dieser Prozess ein Ereignis auslöst. Wenn der Wert Null ist und der Wert von **frequency** ebenfalls Null ist, wird dieser Prozess bei jeder Leerlaufschleife aufgerufen.

**running**
: Ein boolescher Flag. Ist er auf „true“ gesetzt, bedeutet dies, dass der Prozess während der Ereignisschleife weder zurückgegeben hat noch die Kontrolle abgegeben hat und erst dann erneut aufgerufen wird, wenn dies geschieht.


**::cron::wake** *?who?*
: Weckt den Cron-Prozess auf und sorgt dafür, dass dessen Ereignisschleife während des nächsten Leerlaufzyklus ausgeführt wird.


```
::cron::wake {I just did something important}
```

Es stehen mehrere Hilfsprogramme zur Verfügung, die intern in cron sowie zum Testen von cron verwendet werden, die jedoch im allgemeinen Fall nützlich sein können oder auch nicht.

**::cron::clock_step** *milliseconds*
: Gibt eine absolute Uhrzeit relativ zur Epoche zurück, die auf den nächsten Rahmen zwischen einer Sekunde und der nächsten fällt, und zwar für den Wert von *milliseconds*

**::cron::clock_delay** *milliseconds*
: Gibt eine absolute Uhrzeit relativ zur Epoche zurück, die auf den nächsten Rahmen zwischen einer Sekunde und den nächsten *milliseconds* in der Zukunft fällt.

**::cron::clock_sleep** *seconds* *?offset?*
: Gibt eine absolute Uhrzeit relativ zur Epoche zurück, die genau *seconds* in der Zukunft liegt. Wenn „offset“ angegeben wird, kann dieser Wert positiv oder negativ sein und verschiebt die endgültige Zeit vor oder nach den Sekundenwechsel.

**::cron::clock_set** *newtime*
: Stellt die interne Uhr für cron ein. Dieser Befehl verschiebt die Zeit in Schritten von 100 ms nach vorne und löst dabei Ereignisse aus, bis die interne Zeit den Wert *newtime* erreicht hat. *newtime* wird in absoluten Millisekunden seit Beginn der Epoche als Ausdruck angegeben.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *odie* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

System

# COPYRIGHT

```
Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
```
