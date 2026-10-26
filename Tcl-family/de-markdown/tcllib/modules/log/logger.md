---
CommandName: logger
title: logger
ManualSection: n
Version: 0.9.5
TclPart: tcllib
TclDescription: Object Oriented logging facility
Keywords:
 - log
 - log level
 - logger
 - service
Copyright:
---

# Name

logger – System zur Steuerung der Protokollierung von Ereignissen.

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [logger]{.lit} [0.9.5]{.optlit}
[logger::init]{.cmd} [service]{.arg}
[logger::import]{.cmd} [-all]{.optlit} [-force]{.optlit} [[-prefix]{.lit} [prefix]{.arg}]{.optarg} [[-namespace]{.lit} [namespace]{.arg}]{.optarg} [service]{.arg}
[logger::initNamespace]{.cmd} [ns]{.arg} [level]{.optarg}
[logger::services]{.cmd}
[logger::enable]{.cmd} [level]{.arg}
[logger::disable]{.cmd} [level]{.arg}
[logger::setlevel]{.cmd} [level]{.arg}
[logger::levels]{.cmd}
[logger::servicecmd]{.cmd} [service]{.arg}
[${log}::debug]{.cmd} [message]{.arg}
[${log}::info]{.cmd} [message]{.arg}
[${log}::notice]{.cmd} [message]{.arg}
[${log}::warn]{.cmd} [message]{.arg}
[${log}::error]{.cmd} [message]{.arg}
[${log}::critical]{.cmd} [message]{.arg}
[${log}::alert]{.cmd} [message]{.arg}
[${log}::emergency]{.cmd} [message]{.arg}
[${log}::setlevel]{.cmd} [level]{.arg}
[${log}::enable]{.cmd} [level]{.arg}
[${log}::disable]{.cmd} [level]{.arg}
[${log}::lvlchangeproc]{.cmd} [command]{.arg}
[${log}::lvlchangeproc]{.cmd}
[${log}::logproc]{.cmd} [level]{.arg}
[${log}::logproc]{.cmd} [level]{.arg} [command]{.arg}
[${log}::logproc]{.cmd} [level]{.arg} [argname]{.arg} [body]{.arg}
[${log}::services]{.cmd}
[${log}::servicename]{.cmd}
[${log}::currentloglevel]{.cmd}
[${log}::delproc]{.cmd} [command]{.arg}
[${log}::delproc]{.cmd}
[${log}::delete]{.cmd}
[${log}::trace]{.cmd} [command]{.arg}
[${log}::trace]{.cmd} [on]{.lit}
[${log}::trace]{.cmd} [off]{.lit}
[${log}::trace]{.cmd} [status]{.lit} [procName]{.optarg} [...]{.optarg}
[${log}::trace]{.cmd} [add]{.lit} [procName]{.arg} [...]{.optarg}
[${log}::trace]{.cmd} [add]{.lit} [-ns]{.optarg} [nsName]{.arg} [...]{.optarg}
[${log}::trace]{.cmd} [remove]{.lit} [procName]{.arg} [...]{.optarg}
[${log}::trace]{.cmd} [remove]{.lit} [-ns]{.optarg} [nsName]{.arg} [...]{.optarg}
:::

# Beschreibung

Das **logger**-Paket bietet ein flexibles System zur Protokollierung von Meldungen aus verschiedenen Diensten, nach Prioritätsstufen und mit unterschiedlichen Befehlen.

Um das Logger-Paket zu nutzen, gehen wir wie folgt vor:

```
    package require logger
    set log [logger::init myservice]
    ${log}::notice "Initialized myservice logging"

    ... code ...

    ${log}::notice "Ending myservice logging"
    ${log}::delete
```

Im obigen Code geschieht nach dem Laden des Pakets Folgendes:

**logger::init** *service*
: Initialisiert den Dienst *service* für die Protokollierung. Die Dienstnamen sind eigentlich Tcl-Namespace-Namen und werden daher durch „::“ getrennt. Der Dienstname darf weder eine leere Zeichenkette noch ausschließlich aus „:“ bestehen. Wenn ein Logger-Dienst initialisiert wird, „erbt“ er Eigenschaften von seinen übergeordneten Diensten.  Wenn es beispielsweise einen Dienst *foo* gäbe und wir **logger::init** *foo::bar* (um unter *foo* einen *bar*-Dienst anzulegen), würde *bar* die aktuelle Konfiguration des *foo*-Dienstes übernehmen, obwohl es natürlich auch möglich wäre, *bar* anschließend separat zu konfigurieren. Wenn ein Logger-Dienst initialisiert wird und der übergeordnete Dienst noch nicht existiert, wird dieser ebenfalls erstellt. Der neue Logger-Dienst wird mit dem Standard-Loglevel initialisiert, der mit **logger::setlevel** festgelegt wurde.

**logger::import** ?**-all**? ?**-force**? ?**-prefix** *prefix*? ?**-namespace** *namespace*? *service*
: Importiert die Befehle des Logger-Dienstes in den aktuellen Namespace. Ohne die Option **-all** werden nur die Befehle importiert, die den Protokollstufen entsprechen. Wird **-all** angegeben, werden alle Befehle im Format **${log}::cmd** importiert. Wenn der Import einen Befehl überschreiben würde, wird ein Fehler gegeben und kein Befehl importiert. Verwenden Sie die Option **-force**, um den Import zu erzwingen und vorhandene Befehle ohne Fehlermeldung zu überschreiben. Wenn die Option **-prefix** angegeben wird, werden die Befehle importiert, wobei ihren Namen das angegebene *Präfix* vorangestellt wird. Wenn die Option **-namespace** angegeben wird, werden die Befehle in den angegebenen Namespace importiert. Existiert der Namespace nicht, wird er angelegt. Wenn ein Namespace ohne vorangestelltes :: angegeben wird, wird er als untergeordneter Namespace des aktuellen Namespaces interpretiert.

**logger::initNamespace** *ns* ?*level*?
: Befehl zum Einrichten eines Namespace für die Protokollierung. Erstellt einen Logger-Dienst, der nach dem Namespace *ns* benannt ist (das Präfix :: wird entfernt), importiert alle Log-Befehle in den Namespace und legt die Standard-Protokollierungsstufe fest – entweder wie durch *level* angegeben, oder übernommen von einem Dienst im übergeordneten Namespace, oder als festgelegter Standardwert **warn**.

**logger::services**
: Gibt eine Liste aller verfügbaren Dienste zurück.

**logger::enable** *level*
: Aktiviert global die Protokollierung auf und „über“ der angegebenen Stufe. Die Stufen sind **debug**, **info**, **notice**, **warn**, **error**, **critical**, **alert**, **emergency**.

**logger::disable** *level*
: Deaktiviert die Protokollierung global auf und „unterhalb“ der angegebenen Stufe. Die Stufen sind die oben aufgeführten.

**logger::setlevel** *level*
: Aktiviert die Protokollierung global auf und „über“ der angegebenen Stufe. Die Stufen sind die oben aufgeführten. Dieser Befehl ändert die Standardprotokollierungsstufe für neue Logger, die mit **logger::init** erstellt werden.

**logger::levels**
: Gibt eine Liste der verfügbaren Protokollstufen zurück (die auch oben unter **enable** aufgeführt sind).

**logger::servicecmd** *service*
: Gibt das Token **${log}** zurück, das von **logger::init** für diesen Dienst erstellt wurde.

**${log}::debug** *message*
: siehe unten ...

**${log}::info** *message*
: siehe unten ...

**${log}::notice** *message*
: siehe unten ...

**${log}::warn** *message*
: siehe unten ...

**${log}::error** *message*
: siehe unten ...

**${log}::critical** *message*
: siehe unten ...

**${log}::alert** *message*
: siehe unten ...

**${log}::emergency** *message*
: Dies sind die Befehle, die aufgerufen werden, um tatsächlich eine Meldung zu einem Ereignis zu protokollieren. **${log}** ist die Variable, die aus **logger::init** abgeleitet wird.

**${log}::setlevel** *level*
: Aktiviert die Protokollierung in dem Dienst, auf den **${log}** verweist, sowie in dessen untergeordneten Elementen ab der angegebenen Ebene und deaktivieren Sie die Protokollierung unterhalb dieser Ebene.

**${log}::enable** *level*
: Aktiviert die Protokollierung in dem Dienst, auf den **${log}** verweist, sowie in dessen untergeordneten Diensten ab der angegebenen Ebene. Beachten Sie, dass dadurch die Protokollierung unterhalb dieser Ebene *nicht* deaktiviert wird; daher sollten Sie stattdessen wahrscheinlich **setlevel** verwenden.

**${log}::disable** *level*
: Deaktiviert die Protokollierung in dem Dienst, auf den **${log}** verweist, sowie in dessen untergeordneten Diensten auf der angegebenen Ebene und darunter. Hinweis: Dadurch wird die Protokollierung oberhalb dieser Ebene *nicht* aktiviert; daher sollten Sie stattdessen wahrscheinlich **setlevel** verwenden. Durch das Deaktivieren der Protokollstufe **emergency** wird die Protokollierung für den Dienst und seine untergeordneten Dienste ausgeschaltet.

**${log}::lvlchangeproc** *command*
: siehe unten ...

**${log}::lvlchangeproc**
: Legt das Skript so fest, dass es aufgerufen wird, wenn die betreffende Instanz ihre Protokollstufe ändert. Wird es ohne Befehl aufgerufen, gibt es den aktuell registrierten Befehl zurück. Dem Befehl werden zwei Argumente angehängt: die alte und die neue Protokollstufe. Die Rückruffunktion wird aufgerufen, nachdem alle Änderungen vorgenommen wurden. Sind untergeordnete Logger betroffen, werden deren Rückruffunktionen vor den Rückruffunktionen ihrer übergeordneten Logger aufgerufen.

    ```
     	proc lvlcallback {old new} {
     	    puts "Loglevel changed from $old to $new"
     	}
     	${log}::lvlchangeproc lvlcallback
    ```

**${log}::logproc** *level*
: siehe unten ...

**${log}::logproc** *level* *command*
: siehe unten ...

**${log}::logproc** *level* *argname* *body*
: Dieser Befehl gibt es in drei Varianten – die dritte, ältere Variante ist veraltet und wird möglicherweise aus zukünftigen Versionen des Logger-Pakets entfernt. Die aktuell verwendete Version erwartet ein Argument: einen Befehl, der wenn die Stufe aufgerufen wird, ausgeführt werden soll. Der Callback-Befehl erwartet ein Argument: den zu protokollierenden Text. Wird **logproc** nur mit einer gültigen Stufe aufgerufen, gibt es den Namen des Befehls zurück, der derzeit als Callback-Befehl registriert ist. **logproc** legt fest, welcher Befehl die eigentliche Protokollierung für eine bestimmte Stufe durchführt.  Das Logger-Paket enthält Standardbefehle für alle Protokollierungsstufen, doch mit **logproc** ist es möglich, diese durch benutzerdefinierten Code zu ersetzen.  Auf diese Weise könnten Sie Ihre Protokolle über das Netzwerk an eine Datenbank oder an einen anderen Ort senden.  Beispiel:

    ```
        proc logtoserver {txt} {
            variable socket
            puts $socket "Notice: $txt"
        }

        ${log}::logproc notice logtoserver
    ```

    Trace-Protokolle unterscheiden sich geringfügig: Anstelle eines Arguments im Klartext wird dem logproc ein Dictionary übergeben, das aus den Schlüsselwörtern **enter** oder **leave** sowie einem weiteren Dictionary mit Details zum Trace besteht. Dazu gehören:

    - **proc** – Name der Prozedur, die verfolgt wird.

    - **level** – Die Stapelebene für den Aufruf einer Prozedur (aus **info** **level**).

    - **script** – Der Name der Datei, in der die Prozedur definiert ist, oder eine leere Zeichenkette, wenn sie im interaktiven Modus definiert wurde.

    - **caller** – Der Name der Prozedur, die die zu verfolgende Prozedur aufruft, oder eine leere Zeichenkette, wenn die Prozedur aus dem globalen Bereich (Stapelebene 0) aufgerufen wurde.

    - **procargs** – Ein Dictionary, das aus den Namen der Argumente der Prozedur und den diesen Argumenten zugeordneten Werten besteht (nur bei **enter**-Traces).

    - **status** – Der Tcl-Rückgabecode (z. B. **ok**, **continue** usw.) (nur bei **leave**).

    - **result** – Der von der Prozedur zurückgegebene Wert (nur bei **leave**-Spuren).


**${log}::services**
: Gibt eine Liste der registrierten Protokollierungsdienste zurück, die untergeordneten Dienste dieses Dienstes sind.

**${log}::servicename**
: Gibt den Namen dieses Dienstes zurück.

**${log}::currentloglevel**
: Gibt die derzeit aktivierte Protokollierungsstufe für diesen Dienst zurück. Wenn keine Protokollierung aktiviert ist, wird **none** zurückgegeben.

**${log}::delproc** *command*
: siehe unten ...

**${log}::delproc**
: Legt das Skript so fest, dass es aufgerufen wird, wenn die betreffende Protokollinstanz gelöscht wird. Wird es ohne Befehl aufgerufen, gibt es den aktuell registrierten Befehl zurück. Beispiel:

    ```
        ${log}::delproc [list closesock $logsock]
    ```

**${log}::delete**
: Dieser Befehl löscht einen bestimmten Protokollierungsdienst sowie dessen untergeordnete Elemente. Sie müssen diesen Befehl aufrufen, um die von einem Dienst genutzten Ressourcen zu bereinigen.

**${log}::trace** *command*
: Dieser Befehl steuert die Protokollierung von Ein- und Ausstiegsverfolgungen für bestimmte Prozeduren. Er dient dazu, die Verfolgung zu aktivieren und zu deaktivieren, den Verfolgungsstatus abzufragen und festzulegen, welche Prozeduren verfolgt werden sollen. Wenn die Verfolgung deaktiviert wird, werden die Verfolgungshandler deregistriert. Daher hat die Deaktivierung der Verfolgung keine Auswirkungen auf die Leistung einer Bibliothek, genau wie bei anderen Befehlen zur Protokollierungsstufe.

    ```
      proc tracecmd { dict } {
          puts $dict
      }

      set log [::logger::init example]
      ${log}::logproc trace tracecmd

      proc foo { args } {
          puts "In foo"
          bar 1
          return "foo_result"
      }

      proc bar { x } {
          puts "In bar"
          return "bar_result"
      }

      ${log}::trace add foo bar
      ${log}::trace on

      foo

    # Output:
    enter {proc ::foo level 1 script {} caller {} procargs {args {}}}
    In foo
    enter {proc ::bar level 2 script {} caller ::foo procargs {x 1}}
    In bar
    leave {proc ::bar level 2 script {} caller ::foo status ok result bar_result}
    leave {proc ::foo level 1 script {} caller {} status ok result foo_result}
    ```

**${log}::trace** **on**
: Aktiviert die Trace-Protokollierung für Prozeduren, die über den Befehl **trace** **add** registriert wurden. Dies entspricht dem Befehl **enable** für andere Protokollierungsstufen, ermöglicht jedoch die Trace-Protokollierung auf jeder beliebigen Stufe. Der Trace-Protokollierungsmechanismus nutzt die Ausführungs-Trace-Funktion von Tcl 8.4 und höher. Der Befehl **trace** **on** gibt einen Fehler zurück, wenn er von früheren Tcl-Versionen aus aufgerufen wird.

**${log}::trace** **off**
: Deaktiviert die Trace-Protokollierung für Prozeduren, die über den Befehl **trace** **add** für die Trace-Protokollierung registriert wurden. Dies entspricht dem Befehl **disable** für andere Protokollierungsstufen, ermöglicht jedoch die Trace-Protokollierung auf jeder Stufe. Die Prozeduren werden nicht abgemeldet, sodass die Protokollierung für sie mit dem Befehl **trace** **on** wieder aktiviert werden kann.  Die Trace-Registrierung verursacht keinen Mehraufwand, wenn die Trace-Protokollierung deaktiviert ist.

**${log}::trace** **status** ?procName? ?...?
: Dieser Befehl gibt eine Liste der derzeit für die Trace-Protokollierung registrierten Prozeduren zurück oder ein Flag, das angibt, ob für eine oder mehrere angegebene Prozeduren ein Trace registriert ist oder nicht.

**${log}::trace** **add** *procName* ?...?
: siehe unten ...

**${log}::trace** **add** ?-ns? *nsName* ?...?
: Dieser Befehl registriert eine oder mehrere Prozeduren für die Protokollierung von Ein- und Ausstiegsverläufen. Prozeduren können über eine Liste von Prozedurnamen oder Namespaces angegeben werden (in diesem Fall betrifft der Vorgang alle Prozeduren innerhalb des Namespaces).  Standardmäßig wird jeder Name zunächst als Name einer Prozedur oder als Suchmuster im Glob-Stil interpretiert; wird er nicht gefunden, wird er als Name eines Namespaces interpretiert. Mit der Option *-ns* kann die Interpretation aller angegebenen Argumente als Namespace-Namen erzwungen werden. Prozeduren müssen definiert sein, bevor sie mit dem Befehl **trace** **add** zur Protokollierung registriert werden können. Alle Prozedur- oder Namespace-Namen bzw. -Muster, die mit keiner vorhandenen Prozedur übereinstimmen, werden stillschweigend ignoriert.

**${log}::trace** **remove** *procName* ?...?
: siehe unten ...

**${log}::trace** **remove** ?-ns? *nsName* ?...?
: Dieser Befehl hebt die Registrierung einer oder mehrerer Prozeduren auf, sodass für diese keine Trace-Protokollierung mehr durchgeführt wird. Dabei gelten dieselben Übereinstimmungsregeln wie beim Befehl **trace** **add**.


# Umsetzung

Das Logger-Paket ist so implementiert, dass (unter Tcl 8.4 und neuer) deaktivierte Protokollierungsprozeduren optimiert werden. Sie werden auf eine Prozedur verweist, die keinen Körper hat und im Bytecode zu einem No-Op kompiliert wird. Dadurch sollte der Leistungseinbruch minimal sein.  Wenn Sie wirklich alle Register ziehen wollen, können Sie das Token ${log} in Ihrem Code durch den tatsächlichen Namespace und Befehl ersetzen (${log}::warn wird zu ::logger::tree::myservice::warn), sodass keine Suche nach Variablen durchgeführt wird. Dadurch liegt die Leistung deaktivierter Logger-Befehle fast auf dem Niveau einer vollständigen Deaktivierung der Protokollierung.

Die „Objektorientierung“ erfolgt über eine Hierarchie von Namespaces. Die Verwendung eines echten objektorientierten Systems wäre wahrscheinlich die bessere Vorgehensweise oder würde zumindest eine übersichtlichere Implementierung ermöglichen.

Die „Objektorientierung“ des Dienstes wird mithilfe von Namespaces realisiert.

# Logprocs und Callstack

Das Logger-Paket achtet besonders darauf, dass der Logproc nicht in den Aufrufstapel gelangt. Dadurch können Logprocs Code im Geltungsbereich des Aufrufers ausführen, indem sie „uplevel“ verwenden, oder auf lokale Variablen zugreifen, indem sie „upvar“ nutzen. Dies kann Traces mit allen üblichen Nebeneffekten auslösen.

```
     # Print caller and current vars in the calling proc
     proc log_local_var {txt} {
          set caller [info level -1]
          set vars [uplevel 1 info vars]
          foreach var [lsort $vars] {
             if {[uplevel 1 [list array exists $var]] == 1} {
             	lappend val $var <Array>
             } else {
             	lappend val $var [uplevel 1 [list set $var]]
             }
          }
          puts "$txt"
          puts "Caller: $caller"
          puts "Variables in callers scope:"
          foreach {var value} $val {
          	puts "$var = $value"
          }
     }

     # install as logproc
     ${log}::logproc debug log_local_var
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *logger* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge
