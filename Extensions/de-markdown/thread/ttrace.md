---
CommandName: ttrace
ManualSection: n
Version: 3.0
TclPart: Tcl Threading
TclDescription: 
Links:
 - thread
 - tpool
 - tsv
Keywords:
 - command tracing
 - introspection
Copyright:
---

# NAME

ttrace - Trace-basierte Initialisierung von Interpretern

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [9.0]{.lit} 
[package]{.cmd} [require]{.sub} [thread]{.lit} [3.0]{.optlit} 
[ttrace::eval]{.cmd} [arg]{.arg} [arg]{.optdot} 
[ttrace::enable]{.cmd} 
[ttrace::disable]{.cmd} 
[ttrace::cleanup]{.cmd} 
[ttrace::update]{.cmd} [epoch]{.optarg} 
[ttrace::getscript]{.cmd} 
[ttrace::atenable]{.cmd} [cmd]{.arg} [arglist]{.arg} [body]{.arg} 
[ttrace::atdisable]{.cmd} [cmd]{.arg} [arglist]{.arg} [body]{.arg} 
[ttrace::addtrace]{.cmd} [cmd]{.arg} [arglist]{.arg} [body]{.arg} 
[ttrace::addscript]{.cmd} [name]{.arg} [body]{.arg} 
[ttrace::addresolver]{.cmd} [cmd]{.arg} [arglist]{.arg} [body]{.arg} 
[ttrace::addcleanup]{.cmd} [body]{.arg} 
[ttrace::addentry]{.cmd} [cmd]{.arg} [var]{.arg} [val]{.arg} 
[ttrace::getentry]{.cmd} [cmd]{.arg} [var]{.arg} 
[ttrace::getentries]{.cmd} [cmd]{.arg} [pattern]{.optarg} 
[ttrace::delentry]{.cmd} [cmd]{.arg} 
[ttrace::preload]{.cmd} [cmd]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket schafft einen Rahmen, um den Zustand des Interpreters bei Bedarf über Threads einer Anwendung mit mehreren Threads hinweg nachzubilden. Es stützt sich auf die Mechanik der Tcl-Befehlstraces und auf den Tcl-Befehl **unknown** und dessen Mechanismus.

Das Paket verlangt die Tcl-Threading-Erweiterung, lässt sich aber auch eigenständig im AOLserver verwenden, einem skalierbaren Webserver von America Online.

Kurz gefasst ein kleines Beispiel, das die Verwendung von ttrace mit der Tcl-Threading-Erweiterung zeigt:

```
    % package require ttrace
    3.0.1

    % set t1 [thread::create {package require ttrace; thread::wait}]
    tid0x1802800

    % ttrace::eval {proc test args {return test-[thread::id]}}
    % thread::send $t1 test
    test-tid0x1802800

    % set t2 [thread::create {package require ttrace; thread::wait}]
    tid0x1804000

    % thread::send $t2 test
    test-tid0x1804000
```

Wie oben zu sehen, dienen die Befehle **ttrace::eval** und **ttrace::update** dazu, eine für alle Threads geltende Definition einer einfachen Tcl-Prozedur zu erzeugen und diese Definition auf alle bereits bestehenden oder später erzeugten Threads zu übertragen.

# BENUTZERBEFEHLE

Dieser Abschnitt beschreibt Befehle auf Benutzerebene. Skriptautoren können mit diesen Befehlen die Ausführung des Trace-Rahmens steuern.

**ttrace::eval** *arg* ?arg ...?
: Dieser Befehl reiht die gegebenen Argumente aneinander und wertet den entstehenden Tcl-Befehl aus, wobei der Trace-Rahmen eingeschaltet ist. War die Ausführung des Befehls in Ordnung, unternimmt er die nötigen Schritte, um die Änderung der Trace-Epoche automatisch an alle Threads in der Anwendung weiterzugeben. Beim AOLserver erhalten nur neu erzeugte Threads die Änderung der Epoche. Bei der Tcl-Threading-Erweiterung werden alle von der Erweiterung erzeugten Threads automatisch aktualisiert. Führte die Ausführung des Befehls zu einem Tcl-Fehler, findet keine Weitergabe des Zustands statt. Das ist der wichtigste Befehl des Pakets auf Benutzerebene, weil er die meisten der unten beschriebenen Befehle umschließt. Das vereinfacht die Sache erheblich, weil der Benutzer nur diesen einen Befehl lernen muss, um das Paket wirksam zu verwenden. Die anderen Befehle, wie unten beschrieben, stehen vor allem der Vollständigkeit halber dabei.

**ttrace::enable**
: Aktiviert alle registrierten Rückruffunktionen im Rahmen und beginnt eine neue Trace-Epoche. Die Trace-Epoche umfasst alle Änderungen am Interpreter während der Zeit, in der die Traces aktiv sind.

**ttrace::disable**
: Deaktiviert alle registrierten Rückruffunktionen im Rahmen und schließt die aktuelle Trace-Epoche.

**ttrace::cleanup**
: Dient dazu, alle bei Bedarf geladenen Ressourcen im Interpreter aufzuräumen. Er bringt den Tcl-Interpreter wirksam in seinen ursprünglichen Zustand zurück.

**ttrace::update** ?epoch?
: Dient dazu, den Zustand des Interpreters aufzufrischen, sodass er zur optionalen Trace-Epoche ?epoch? passt. Ist die optionale ?epoch? nicht angegeben, nimmt er die jüngste Trace-Epoche.

**ttrace::getscript**
: Gibt ein zusammengesetztes Tcl-Skript zurück, das in jedem Interpreter per source geladen werden kann. Dieses Skript bereitet den Tcl-Befehl **unknown** so vor, dass er per Trace erfasste Ressourcen aus der Datenbank im Speicher laden kann. Gewöhnlich rufen andere Befehle höherer Ebene wie **ttrace::eval** und **ttrace::update** diesen Befehl automatisch auf.


# RÜCKRUFFBEFEHLE

Vorweg: Das Paket enthält bereits Rückruffunktionen, um die folgenden Tcl-Befehle zu tracen: **proc**, **namespace**, **variable**, **load** und **rename**. Zusätzlich liegt ein Satz von Rückruffunktionen vor, um Ressourcen (Objekt, Klassen) von XOTcl ab Version 1.3.8 zu tracen, einer OO-Erweiterung von Tcl. Das gibt eine tragfähige Grundlage, die meisten Bedürfnisse der Praxis zu lösen, und dient als Beispiel für alle, die das Paket an ihre besonderen Bedürfnisse anpassen wollen.

Unten stehen Befehle, um Rückruffunktionen im Rahmen zu registrieren und Rückruffunktionskripte zu schreiben. Der Rahmen ruft diese Rückruffunktionen auf, um Zustandsänderungen des Interpreters zu sammeln, die Datenbank im Speicher aufzubauen, eigene Aufräumarbeiten auszuführen und verschiedene andere Aufgaben zu erledigen.

**ttrace::atenable** *cmd* *arglist* *body*
: Registriert eine Tcl-Rückruffunktion, die bei **ttrace::enable** aktiviert wird. Registrierte Rückruffunktionen werden nach FIFO aktiviert. Die Definition der Rückruffunktion umfasst den Namen der Rückruffunktion, *cmd*, eine Liste der Argumente der Rückruffunktion, *arglist*, und den *body* der Rückruffunktion. Wirksam entspricht das der Aufrufschnittstelle des üblichen Tcl-Befehls **proc**.

**ttrace::atdisable** *cmd* *arglist* *body*
: Registriert eine Tcl-Rückruffunktion, die bei **ttrace::disable** aktiviert wird. Registrierte Rückruffunktionen werden nach FIFO aktiviert. Die Definition der Rückruffunktion umfasst den Namen der Rückruffunktion, *cmd*, eine Liste der Argumente der Rückruffunktion, *arglist*, und den *body* der Rückruffunktion. Wirksam entspricht das der Aufrufschnittstelle des üblichen Tcl-Befehls **proc**.

**ttrace::addtrace** *cmd* *arglist* *body*
: Registriert eine Tcl-Rückruffunktion, die aktiviert wird, um den Tcl-Befehl **cmd** zu tracen. Die Definition der Rückruffunktion umfasst den Namen des zu tracenden Tcl-Befehls, *cmd*, eine Liste der Argumente der Rückruffunktion, *arglist*, und den *body* der Rückruffunktion. Wirksam entspricht das der Aufrufschnittstelle des üblichen Tcl-Befehls **proc**.

**ttrace::addscript** *name* *body*
: Registriert eine Tcl-Rückruffunktion, die aktiviert wird, um ein Tcl-Skript aufzubauen, das an andere Interpreter übergeben wird. Dieses Skript bereitet den Tcl-Befehl **unknown** vor. Registrierte Rückruffunktionen werden nach FIFO aktiviert. Die Definition der Rückruffunktion umfasst den Namen der Rückruffunktion, *name*, und den *body* der Rückruffunktion.

**ttrace::addresolver** *cmd* *arglist* *body*
: Registriert eine Tcl-Rückruffunktion, die der überladene Tcl-Befehl **unknown** aktiviert. Registrierte Rückruffunktionen werden nach FIFO aktiviert. Diese Rückruffunktion dient dazu, die Ressource aufzulösen und sie im aktuellen Interpreter zu laden.

**ttrace::addcleanup** *body*
: Registriert eine Tcl-Rückruffunktion, die von **trace::cleanup** aktiviert wird. Registrierte Rückruffunktionen werden nach FIFO aktiviert.

**ttrace::addentry** *cmd* *var* *val*
: Fügt der benannten Datenbank im Speicher einen Eintrag hinzu.

**ttrace::getentry** *cmd* *var*
: Gibt den Wert des Eintrags aus der benannten Datenbank im Speicher zurück.

**ttrace::getentries** *cmd* ?pattern?
: Gibt die Namen aller Einträge aus der benannten Datenbank im Speicher zurück.

**ttrace::delentry** *cmd*
: Löscht einen Eintrag aus der benannten Datenbank im Speicher.

**ttrace::preload** *cmd*
: Registriert den Tcl-Befehl, der in den Interpreter geladen werden soll. Auf diese Weise registrierte Befehle sind stets Teil des Interpreters und werden nicht bei Bedarf durch den Tcl-Befehl **unknown** geladen.


# DISKUSSION

Übliche Verfahren, den Zustand durch Introspektion nachzubilden, verwenden ein eigenes Tcl-Skript, um den laufenden Interpreter zu untersuchen und ein weiteres Tcl-Skript zu erzeugen, das diesen Zustand in einem anderen Interpreter nachbildet. Dieses Paket verwendet stattdessen Tcl-Befehlstraces. Befehlstraces werden auf ausgewählte Tcl-Befehle registriert, etwa **proc**, **namespace**, **load** und andere übliche (und/oder vom Benutzer definierte) Tcl-Befehle. Sind sie aktiv, bauen diese Traces eine Datenbank der erzeugten Ressourcen im Speicher auf. Diese Datenbank dient als Ressourcenlager für den (überladenen) Tcl-Befehl **unknown**, der die angeforderte Ressource im Interpreter bei Bedarf erzeugt. So können Benutzer nur einen Interpreter (den Master) in einem Thread aktualisieren und diesen Interpreterzustand (oder einen Teil davon) auf andere Threads und Interpreter im Prozess übertragen.

Der unmittelbare Gewinn dieses Vorgehens ist der deutlich kleinere Speicherbedarf der Anwendung und die deutlich schnellere Erzeugung von Threads. Werden nicht alle nötigen Prozeduren (und anderen Ressourcen) in jedem Thread schon bei der Initialisierung des Threads geladen, sondern erst dann, wenn die Ressource tatsächlich verwendet wird, lassen sich Speicherverbrauch und Initialisierungszeit der Threads deutlich verbessern. Einige Tests haben gezeigt, dass der Speicherbedarf einer Tcl-Anwendung mit mehreren Threads auf weniger als ein Drittel sank und die Startzeit der Threads etwa auf ein Fünfzigstel zurückging. Die Ergebnisse können davon abweichen. Weitere Gewinne sind die feinere Steuerung, was (und wann) vom Master auf andere Tcl-Threads und Interpreter übertragen wird.
