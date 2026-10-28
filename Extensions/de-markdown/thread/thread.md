---
CommandName: thread
title: thread
ManualSection: n
Version: 3.0
TclPart: Tcl Threading
TclDescription:
Links:
 - http://www.tcl.tk/doc/howto/thread_model.html
 - tpool
 - tsv
 - ttrace
Keywords:
 - events
 - message passing
 - mutex
 - synchronization
 - thread
Copyright:
---

# Name

thread - Erweiterung für den Skriptzugriff auf Tcl-Threading

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [9.0]{.lit}
[package]{.cmd} [require]{.sub} [thread]{.lit} [3.0]{.optlit}
[thread::create]{.cmd} [-joinable]{.optarg} [-preserved]{.optarg} [script]{.optarg}
[thread::preserve]{.cmd} [id]{.optarg}
[thread::release]{.cmd} [-wait]{.optarg} [id]{.optarg}
[thread::id]{.cmd}
[thread::errorproc]{.cmd} [procname]{.optarg}
[thread::cancel]{.cmd} [-unwind]{.optarg} [id]{.arg} [result]{.optarg}
[thread::unwind]{.cmd}
[thread::exit]{.cmd} [status]{.optarg}
[thread::names]{.cmd}
[thread::exists]{.cmd} [id]{.arg}
[thread::send]{.cmd} [-async]{.optarg} [-head]{.optarg} [id]{.arg} [script]{.arg} [varname]{.optarg}
[thread::broadcast]{.cmd} [script]{.arg}
[thread::wait]{.cmd}
[thread::eval]{.cmd} [[-lock]{.lit} [mutex]{.arg}]{.optarg} [arg]{.arg} [arg]{.optdot}
[thread::join]{.cmd} [id]{.arg}
[thread::configure]{.cmd} [id]{.arg} [option]{.optarg} [value]{.optarg} [...]{.optarg}
[thread::transfer]{.cmd} [id]{.arg} [channel]{.arg}
[thread::detach]{.cmd} [channel]{.arg}
[thread::attach]{.cmd} [channel]{.arg}
[thread::mutex]{.cmd}
[thread::mutex]{.cmd} [create]{.lit} [-recursive]{.optarg}
[thread::mutex]{.cmd} [destroy]{.lit} [mutex]{.arg}
[thread::mutex]{.cmd} [lock]{.lit} [mutex]{.arg}
[thread::mutex]{.cmd} [unlock]{.lit} [mutex]{.arg}
[thread::rwmutex]{.cmd}
[thread::rwmutex]{.cmd} [create]{.lit}
[thread::rwmutex]{.cmd} [destroy]{.lit} [mutex]{.arg}
[thread::rwmutex]{.cmd} [rlock]{.lit} [mutex]{.arg}
[thread::rwmutex]{.cmd} [wlock]{.lit} [mutex]{.arg}
[thread::rwmutex]{.cmd} [unlock]{.lit} [mutex]{.arg}
[thread::cond]{.cmd}
[thread::cond]{.cmd} [create]{.lit}
[thread::cond]{.cmd} [destroy]{.lit} [cond]{.arg}
[thread::cond]{.cmd} [notify]{.lit} [cond]{.arg}
[thread::cond]{.cmd} [wait]{.lit} [cond]{.arg} [mutex]{.arg} [ms]{.optarg}
:::

# Beschreibung

Die Erweiterung **thread** erzeugt Threads, die Tcl-Interpreter enthalten, und erlaubt, Skripte zur Auswertung an diese Threads zu senden. Zusätzlich bietet sie auf Skriptebene Zugang zu den grundlegenden Grundelementen der Thread-Synchronisation, etwa Mutexen und Bedingungsvariablen.

# Befehle

Dieser Abschnitt beschreibt Befehle, um Threads zu erzeugen und zu zerstören und Skripte zur Auswertung an Threads zu senden.

**thread::create** ?-joinable? ?-preserved? ?script?
: Dieser Befehl erzeugt einen Thread, der einen Tcl-Interpreter enthält. Der Tcl-Interpreter wertet entweder das optionale **script** aus, falls angegeben, oder er wartet in der Ereignisschleife auf Skripte, die über den Befehl **thread::send** eintreffen. Das Ergebnis des optionalen **script**, falls vorhanden, wird dem Aufrufer nie zurückgegeben. Das Ergebnis von **thread::create** ist die ID des Threads. Das ist das undurchsichtige Handle, das den neu erzeugten Thread für alle anderen Befehle des Pakets bezeichnet. Das Handle des Threads verlässt den Geltungsbereich automatisch, wenn der Thread zum Beenden vorgemerkt ist (siehe den Befehl **thread::release** unten).

    Enthält das optionale Argument **script** den Befehl **thread::wait**, betritt der Thread die Ereignisschleife. Wird ein solcher Befehl im **script** nicht gefunden, führt der Thread das **script** bis zum Ende aus und beendet sich. In dem Fall darf das Handle unbedenklich ignoriert werden, weil es auf einen Thread verweist, der zu dem Zeitpunkt, an dem der Befehl zurückgibt, nicht mehr besteht.

    Mit dem Schalter **-joinable** lässt sich ein joinbarer Thread erzeugen, also einer, auf dessen Ende mit dem Befehl **thread::join** gewartet werden kann. Wird ein mit dem Schalter **-joinable** erzeugter Thread nicht verbunden, entstehen Ressourcen- und Speicherlecks.

    Threads, die **thread::create** erzeugt, lassen sich nicht gewaltsam zerstören. Folglich gibt es keinen entsprechenden Befehl, um einen Thread zu zerstören. Ein Thread darf nur mit **thread::release** freigegeben werden, und wenn sein interner Referenzzähler auf null fällt, wird der Thread zum Beenden vorgemerkt. Das wirft den Thread aus der Bedienung der Ereignisschleife, und der Thread führt die im Argument **script** übergebenen Befehle weiter aus, die auf den Befehl **thread::wait** folgen. War das der letzte Befehl im Skript, wie es gewöhnlich der Fall ist, beendet sich der Thread.

    Es lässt sich eine Lage erzeugen, in der der Thread sich nicht mehr beenden lässt, etwa indem nach **thread::wait** eine Endlosschleife steht oder die Ereignisschleife durch einen Befehl der Art **vwait** erneut betreten wird. In solchen Fällen beendet sich der Thread vielleicht nie. Das gilt als schlechte Praxis und ist zu vermeiden, wo es geht. Das Beispiel unten zeigt das am deutlichsten:

    ```
        # You should never do ...
        set tid [thread::create {
            package require Http
            thread::wait
            vwait forever ; # <-- this!
        }]
    ```

    Der im Beispiel oben erzeugte Thread kann sich nie beenden. Nachdem er mit dem letzten passenden Aufruf von **thread::release** freigegeben wurde, springt der Thread aus **thread::wait** und führt die folgenden Befehle weiter aus. Er betritt den Befehl **vwait** und wartet endlos auf Ereignisse. Einen solchen Thread kann nichts beenden, das ist also zu vermeiden.

    Jeder neu erzeugte Thread hat seinen internen Referenzzähler auf 0 (null) gesetzt, das heißt, er ist nicht reserviert. Dieser Zähler wird durch einen Aufruf von **thread::preserve** erhöht und durch einen Aufruf des Befehls **thread::release** verringert. Diese beiden Befehle setzen ein einfaches, aber wirksames System zur Reservierung von Threads um und bieten eine vorhersagbare und steuerbare Beendigung von Threads. Anfangs reservierte Threads lassen sich erzeugen, indem der Schalter **-preserved** des Befehls **thread::create** verwendet wird. Threads, die mit diesem Schalter erzeugt werden, haben als Anfangswert des Referenzzählers 1 (eins) und sind damit anfangs als reserviert gekennzeichnet.

**thread::preserve** ?id?
: Dieser Befehl erhöht den Referenzzähler des Threads. Jeder Aufruf dieses Befehls erhöht den Referenzzähler um eins (1). Der Befehl gibt den Wert des Referenzzählers nach der Erhöhung zurück. Mit der optionalen Thread-**id** aufgerufen, reserviert der Befehl den gegebenen Thread. Andernfalls wird der aktuelle Thread reserviert.

    Mit der Referenzzählung lässt sich der kontrollierte Zugang zu einem gemeinsamen Tcl-Thread umsetzen. Durch das Erhöhen des Referenzzählers zeigt der Aufrufer an, dass er den Thread längere Zeit verwenden will. Durch das Verringern des Zählers zeigt der Aufrufer an, dass er die Verwendung des Threads beendet hat.

**thread::release** ?-wait? ?id?
: Dieser Befehl verringert den Referenzzähler des Threads. Jeder Aufruf dieses Befehls verringert den Referenzzähler um eins (1). Mit der optionalen Thread-**id** aufgerufen, gibt der Befehl den gegebenen Thread frei. Andernfalls wird der aktuelle Thread freigegeben. Der Befehl gibt den Wert des Referenzzählers nach der Verringerung zurück. Erreicht der Referenzzähler null (0), wird der Ziel-Thread zur Beendigung vorgemerkt. Nachdem der Befehl **thread::release** null oder eine negative ganze Zahl zurückgibt, darf der Thread nicht mehr verwendet werden. Das Handle des Threads verlässt den Geltungsbereich und darf nicht weiter verwendet werden. Jeder folgende Verweis auf dasselbe Thread-Handle führt zu einem Tcl-Fehler.

    Der optionale Schalter **-wait** weist den aufrufenden Thread an, auf das Ende des Ziel-Threads zu warten, wenn die Wirkung des Befehls die Beendigung des Ziel-Threads zur Folge hätte, das heißt, wenn das Ergebnis null (0) wäre. Ohne den Schalter wartet der aufrufende Thread nicht auf das Ende des Ziel-Threads. Beim Verwenden von **-wait** ist Vorsicht nötig, weil das den aufrufenden Thread unbegrenzt blockieren kann. Diese Option wurde für einige besondere Verwendungen der Erweiterung umgesetzt und ist für den regelmäßigen Gebrauch veraltet. Für den regelmäßigen Gebrauch sind joinbare Threads mit der Option **-joinable** des Befehls **thread::create** zu erzeugen und mit **thread::join** auf das Ende des Threads zu warten.

**thread::id**
: Dieser Befehl gibt die ID des aktuellen Threads zurück.

**thread::errorproc** ?procname?
: Dieser Befehl setzt eine Behandlung für Fehler, die in Skripten auftreten, die asynchron, mit dem Schalter **-async** des Befehls **thread::send**, an andere Threads gesendet werden. Ist keine Behandlung angegeben, wird die aktuelle Behandlung zurückgegeben. Die leere Zeichenkette setzt die Behandlung auf den Vorgabewert (unbestimmt) zurück. Ein nicht abgefangener Fehler in einem Thread bewirkt, dass eine Fehlermeldung an den Standardfehlerkanal gesendet wird. Dieses voreingestellte Melden lässt sich ändern, indem eine Prozedur registriert wird, die aufgerufen wird, um den Fehler zu melden. *procname* wird in dem Interpreter aufgerufen, der den Befehl **thread::errorproc** aufgerufen hat. *procname* wird so aufgerufen:

    ```
        myerrorproc thread_id errorInfo
    ```

**thread::cancel** ?-unwind? *id* ?result?
: Dieser Befehl verlangt Tcl ab Version 8.6.

    Er bricht das Skript ab, das in dem durch den Parameter *id* gegebenen Thread ausgewertet wird. Ohne den Schalter **-unwind** wird der Auswertungsstapel des Interpreters abgebaut, bis ein umschließender catch-Befehl gefunden wird oder keine weiteren Aufrufe des Interpreters auf dem Aufrufstapel bleiben. Mit dem Schalter **-unwind** wird der Auswertungsstapel des Interpreters ohne Rücksicht auf einen dazwischenliegenden catch-Befehl abgebaut, bis keine weiteren Aufrufe des Interpreters auf dem Aufrufstapel bleiben. Ist *result* vorhanden, wird es als Zeichenkette der Fehlermeldung verwendet; andernfalls wird eine voreingestellte Zeichenkette der Fehlermeldung verwendet.

**thread::unwind**
: Die Verwendung dieses Befehls ist veraltet zugunsten des weiter entwickelten Systems zur Reservierung von Threads, das mit den Befehlen **thread::preserve** und **thread::release** umgesetzt ist. Die Unterstützung für den Befehl **thread::unwind** wird in einer künftigen Hauptversion der Erweiterung verschwinden.

    Dieser Befehl beendet ein vorangegangenes **thread::wait**. Die Ausführung des Skripts, das an den neu erzeugten Thread übergeben wurde, setzt am Befehl **thread::wait** fort. War **thread::wait** der letzte Befehl im Skript, beendet sich der Thread. Der Befehl gibt ein leeres Ergebnis zurück, kann aber in manchen Situationen einen Tcl-Fehler mit der Meldung „target thread died“ auslösen.

**thread::exit** ?status?
: Die Verwendung dieses Befehls ist veraltet zugunsten des weiter entwickelten Systems zur Reservierung von Threads, das mit den Befehlen **thread::preserve** und **thread::release** umgesetzt ist. Die Unterstützung für den Befehl **thread::exit** wird in einer künftigen Hauptversion der Erweiterung verschwinden.

    Dieser Befehl zwingt einen Thread, der im Befehl **thread::wait** feststeckt, bedingungslos zum Beenden. Der Beendigungsstatus des Threads ist voreingestellt 666 und lässt sich mit dem optionalen Argument *status* angeben. Die Ausführung des Befehls **thread::exit** hinterlässt den Programmspeicher garantiert in einem inkonsistenten Zustand, erzeugt Speicherlecks und beeinträchtigt andere Teilsysteme der Tcl-Anwendung auf unvorhersagbare Weise. Der Befehl gibt ein leeres Ergebnis zurück, kann aber in manchen Situationen einen Tcl-Fehler mit der Meldung „target thread died“ auslösen.

**thread::names**
: Dieser Befehl gibt eine Liste von Thread-IDs zurück. Das sind nur Threads, die über den Befehl **thread::create** erzeugt wurden. Erzeugt die Anwendung weitere Threads auf C-Ebene, meldet dieser Befehl sie nicht.

**thread::exists** *id*
: Gibt wahr (1) zurück, wenn der durch den Parameter *id* gegebene Thread besteht, andernfalls falsch (0). Das gilt nur für Threads, die über den Befehl **thread::create** erzeugt wurden.

**thread::send** ?-async? ?-head? *id* *script* ?varname?
: Dieser Befehl übergibt ein *script* an einen anderen Thread und wartet optional auf das Ergebnis. Ist der Schalter **-async** angegeben, wartet der Befehl nicht auf das Ergebnis und gibt die leere Zeichenkette zurück. Der Ziel-Thread muss seine Ereignisschleife betreten, um Skripte zu empfangen, die über diesen Befehl gesendet werden. Das geschieht voreingestellt für Threads, die ohne Startskript erzeugt wurden. Threads können die Ereignisschleife ausdrücklich betreten, indem sie **thread::wait** oder einen anderen passenden Tcl/Tk-Befehl aufrufen, etwa **update**, **vwait** und so weiter.

    Das optionale **varname** legt fest, in welcher Variable das Ergebnis des *script* gespeichert wird. Ohne den Schalter **-async** gibt der Befehl den Auswertungscode zurück, ähnlich dem üblichen Tcl-Befehl **catch**. Ist der Schalter **-async** jedoch angegeben, gibt der Befehl sofort zurück, und der Aufrufer kann später **vwait** auf ?varname? ausführen, um das Ergebnis des übergebenen *script* zu erhalten.

    ```
        set t1 [thread::create]
        set t2 [thread::create]
        thread::send -async $t1 "set a 1" result
        thread::send -async $t2 "set b 2" result
        for {set i 0} {$i < 2} {incr i} {
            vwait result
        }
    ```

    Im Beispiel oben wurde zwei Threads Arbeit zugeführt, und beide wurden angewiesen, dieselbe Variable „result“ im aufrufenden Thread zu signalisieren. Der Aufrufer betrat die Ereignisschleife zweimal, um beide Ergebnisse zu erhalten. Die Reihenfolge der empfangenen Ergebnisse kann jedoch schwanken, abhängig von der aktuellen Systemlast, der Art der geleisteten Arbeit und so weiter.

    Viele Threads können gleichzeitig Skripte zur Ausführung an den Ziel-Thread senden. Alle werden in die Ereigniswarteschlange des Ziel-Threads eingereiht und nach FIFO ausgeführt, vermischt mit optional anderen Ereignissen, die in der Ereigniswarteschlange des Ziel-Threads anstehen. Mit dem optionalen Schalter ?-head? lassen sich Skripte, die in die Ereigniswarteschlange des Threads gestellt werden, an den Kopf statt an das Ende der Warteschlange setzen und damit nach LIFO ausführen.

**thread::broadcast** *script*
: Dieser Befehl übergibt ein *script* zur Ausführung an alle vom Paket erzeugten Threads. Er wartet auf keine Antwort von irgendeinem der Threads.

    Der sendende Thread (derjenige, der den Befehl thread::broadcast ausführt) sendet das Skript nicht an sich selbst.

    Jeder empfangende Thread wird angewiesen, die Auswertung des gesendeten Skripts an den Kopf seiner Ereigniswarteschlange zu setzen, vor alle anderen Ereignisse, die auf die Verarbeitung warten.

**thread::wait**
: Damit wird die Ereignisschleife betreten, sodass ein Thread Nachrichten vom Befehl **thread::send** empfangen kann. Dieser Befehl darf nur innerhalb des Skripts verwendet werden, das an **thread::create** übergeben wird. Er soll der allerletzte Befehl im Skript sein. Ist das nicht der Fall, führt der sich beendende Thread die Skriptzeilen nach **thread::wait** weiter aus, was gewöhnlich nicht das Gewünschte und Erwartete ist.

    ```
        set t1 [thread::create {
            #
            # Do some initialization work here
            #
            thread::wait ; # Enter the event loop
        }]
    ```

**thread::eval** ?-lock mutex? *arg* ?arg ...?
: Dieser Befehl reiht die übergebenen Argumente aneinander und wertet das entstehende Skript unter dem Schutz eines Mutex aus. Ist mit dem optionalen Argument ?-lock mutex? kein Mutex angegeben, wird der interne statische Mutex verwendet.

**thread::join** *id*
: Dieser Befehl wartet, bis der Thread mit der ID *id* sich beendet, und gibt dann seinen Beendigungscode zurück. Für Threads, die nicht joinbar sind oder auf die bereits ein anderer Thread gewartet hat, werden Fehler zurückgegeben. Nach dem Verbinden hat das Handle des Threads den Geltungsbereich verlassen und darf nicht weiter verwendet werden.

**thread::configure** *id* ?option? ?value? ?...?
: Dieser Befehl konfiguriert verschiedene Aspekte auf niedriger Ebene des Threads mit der ID *id*, ähnlich wie der übliche Tcl-Befehl **fconfigure** einige Optionen eines Tcl-Kanals konfiguriert. Derzeit unterstützt werden die Optionen **-eventmark** und **-unwindonerror**.

    Wird **-eventmark** mit einem Wert größer als 0 (null) angegeben, ist dieser Wert die Höchstzahl asynchron abgegebener Skripte, die für den Thread anstehen dürfen. **thread::send -async** blockiert, bis die Zahl der anstehenden Skripte in der Ereignisschleife unter den Wert von **-eventmark** fällt.

    Wird **-unwindonerror** mit einem wahren Wert angegeben, bewirkt ein Fehlerergebnis in einem Skript, dass der Thread abgewickelt wird und keine weiteren Skripte mehr auswerten kann.

**thread::transfer** *id* *channel*
: Damit wird der angegebene *channel* aus dem aktuellen Thread und Interpreter in den Hauptinterpreter des Threads mit der gegebenen *id* verschoben. Nach dem Verschieben hat der aktuelle Interpreter keinen Zugang mehr zum Kanal, der Hauptinterpreter des Ziel-Threads kann ihn aber von nun an verwenden. Der Befehl wartet, bis der andere Thread den Kanal aufgenommen hat. Dadurch ist es möglich, die beteiligten Threads zu verklemmen, indem der andere durch ein synchrones **thread::send** angewiesen wird, einen Kanal an uns zu übertragen. Das weitet sich leicht zu längeren Schleifen von Threads aus, die aufeinander warten. Weitere Einschränkungen: Der betreffende Kanal darf nicht unter mehreren Interpretern geteilt sein, die im sendenden Thread laufen. Das schließt die besonderen Kanäle für Standardeingabe, Standardausgabe und Standardfehler von selbst aus.

    Wegen der internen Umsetzung des Tcl-Kerns und der Einschränkung, geteilte Kanäle zu übertragen, sind besondere Maßnahmen nötig, wenn Socket-Kanäle übertragen werden, die durch das Annehmen der Verbindung aus den Rückruffunktionen des Befehls **socket** entstanden sind:

    ```
        socket -server _Accept 2200
        proc _Accept {s ipaddr port} {
            after idle [list Accept $s $ipaddr $port]
        }
        proc Accept {s ipaddr port} {
            set tid [thread::create]
            thread::transfer $tid $s
        }
    ```

**thread::detach** *channel*
: Damit wird der angegebene *channel* vom aktuellen Thread und Interpreter gelöst. Danach hat der aktuelle Interpreter keinen Zugang mehr zum Kanal. Der Kanal ist im geparkten Zustand, bis ein anderer (oder derselbe) Thread den Kanal mit **thread::attach** wieder anhängt. Einschränkungen: dieselben wie beim Übertragen geteilter Kanäle mit dem Befehl **thread::transfer**.

**thread::attach** *channel*
: Damit wird der zuvor gelöste *channel* im aktuellen Thread und Interpreter angehängt. Für bereits bestehende Kanäle tut der Befehl nichts, das heißt, es ist kein Fehler, denselben Kanal mehr als einmal anzuhängen. Die erste Operation führt die Operation tatsächlich aus, alle folgenden Operationen tun nur nichts. Der Befehl löst einen Fehler aus, wenn der *channel* nicht in der Liste der gelösten Kanäle und/oder im aktuellen Interpreter gefunden wird.

**thread::mutex**
: Mutexe sind die häufigsten Grundelemente der Thread-Synchronisation. Sie dienen dazu, den Zugang von zwei oder mehr Threads zu einer oder mehr gemeinsamen Ressourcen zu synchronisieren. Dieser Befehl bietet auf Skriptebene Zugang zu exklusiven und/oder rekursiven Mutexen. Exklusive Mutexe kann ein Thread nur einmal sperren, rekursive Mutexe kann derselbe Thread viele Male sperren. Bei rekursiven Mutexen muss die Zahl der Sperr- und Entsperroperationen übereinstimmen, andernfalls wird der Mutex nie freigegeben, was zu verschiedenen Verklemmungen führen würde.

    Beim Verwenden von Mutexen in einem Programm mit mehreren Threads ist Vorsicht nötig. Unsachgemäße Verwendung von Mutexen kann zu verschiedenen Verklemmungen führen, besonders bei exklusiven Mutexen.

    Der Befehl **thread::mutex** unterstützt die folgenden Unterbefehle und Optionen:

    **thread::mutex** **create** ?-recursive?
    : Erzeugt den Mutex und gibt sein undurchsichtiges Handle zurück. Dieses Handle ist für jeden künftigen Verweis auf den neu erzeugten Mutex zu verwenden. Wurde kein optionales Argument ?-recursive? angegeben, erzeugt der Befehl den exklusiven Mutex. Mit dem Argument ?-recursive? erzeugt der Befehl einen rekursiven Mutex.

    **thread::mutex** **destroy** *mutex*
    : Zerstört den *mutex*. Der Mutex soll vor dem Versuch zu zerstören entsperrt sein. Ist der Mutex gesperrt, löst der Befehl einen Tcl-Fehler aus.

    **thread::mutex** **lock** *mutex*
    : Sperrt den *mutex*. Das Sperren des exklusiven Mutex kann einen Tcl-Fehler auslösen, wenn versucht wird, denselben Mutex zweimal aus demselben Thread zu sperren. Zwingt die Programmlogik dazu, denselben Mutex zweimal oder öfter aus demselben Thread zu sperren (das kann bei rekursiven Prozeduraufrufen geschehen), sind rekursive Mutexe in Betracht zu ziehen.

    **thread::mutex** **unlock** *mutex*
    : Entsperrt den *mutex*, sodass ein anderer Thread ihn wieder sperren kann. Der Versuch, den bereits entsperrten Mutex zu entsperren, löst einen Tcl-Fehler aus.


**thread::rwmutex**
: Dieser Befehl erzeugt Mutexe für viele Leser und einen Schreiber. Lese-/Schreib-Mutexe erlauben, den Zugang zu einer gemeinsamen Ressource günstiger zu serialisieren. Wird eine gemeinsame Ressource meist gelesen und selten verändert, lässt sich mit Lese-/Schreib-Mutexen statt exklusiver oder rekursiver Mutexe etwas an Leistung gewinnen.

    Zum Lesen der Ressource soll der Thread eine Lesesperre auf die Ressource erlangen. Die Lesesperre ist nicht exklusiv, das heißt, mehr als ein Thread kann eine Lesesperre auf dieselbe Ressource erlangen, ohne auf andere Leser zu warten. Zum Ändern der Ressource muss ein Thread jedoch eine exklusive Schreibsperre erlangen. Diese Sperre hindert alle Threads wirksam daran, die Lesesperre zu erlangen, während der Schreiber-Thread die Ressource verändert. Erst nachdem die Schreibsperre freigegeben wurde, darf die Ressource wieder lesend gesperrt werden.

    Der Befehl **thread::rwmutex** unterstützt die folgenden Unterbefehle und Optionen:

    **thread::rwmutex** **create**
    : Erzeugt den Lese-/Schreib-Mutex und gibt sein undurchsichtiges Handle zurück. Dieses Handle ist für jeden künftigen Verweis auf den neu erzeugten Mutex zu verwenden.

    **thread::rwmutex** **destroy** *mutex*
    : Zerstört den Lese-/Schreib-*mutex*. Ist der Mutex bereits gesperrt, löst der Versuch, ihn zu zerstören, einen Tcl-Fehler aus.

    **thread::rwmutex** **rlock** *mutex*
    : Sperrt den *mutex* zum Lesen. Mehr als ein Thread darf denselben *mutex* gleichzeitig lesend sperren.

    **thread::rwmutex** **wlock** *mutex*
    : Sperrt den *mutex* zum Schreiben. Nur ein Thread darf denselben *mutex* gleichzeitig schreibend sperren. Der Versuch, denselben *mutex* zweimal aus demselben Thread schreibend zu sperren, löst einen Tcl-Fehler aus.

    **thread::rwmutex** **unlock** *mutex*
    : Entsperrt den *mutex*, sodass ein anderer Thread ihn wieder sperren kann. Der Versuch, einen bereits entsperrten *mutex* zu entsperren, löst einen Tcl-Fehler aus.


**thread::cond**
: Dieser Befehl bietet auf Skriptebene Zugang zu Bedingungsvariablen. Eine Bedingungsvariable schafft eine sichere Umgebung, in der das Programm eine Bedingung prüfen, bei falschem Ergebnis darauf schlafen und geweckt werden kann, wenn sie wahr geworden sein könnte. Eine Bedingungsvariable wird stets zusammen mit einem exklusiven Mutex verwendet. Wird versucht, eine andere Art von Mutex zusammen mit der Bedingungsvariable zu verwenden, wird ein Tcl-Fehler ausgelöst.

    Der Befehl unterstützt die folgenden Unterbefehle und Optionen:

    **thread::cond** **create**
    : Erzeugt die Bedingungsvariable und gibt ihr undurchsichtiges Handle zurück. Dieses Handle ist für jeden künftigen Verweis auf die neu erzeugte Bedingungsvariable zu verwenden.

    **thread::cond** **destroy** *cond*
    : Zerstört die Bedingungsvariable *cond*. Äußerste Vorsicht ist nötig, dass niemand die Bedingungsvariable verwendet (das heißt, auf sie wartet), andernfalls können unerwartete Fehler geschehen.

    **thread::cond** **notify** *cond*
    : Weckt alle Threads, die auf die Bedingungsvariable *cond* warten.

    **thread::cond** **wait** *cond* *mutex* ?ms?
    : Dieser Befehl dient dazu, die Programmausführung anzuhalten, bis die Bedingungsvariable *cond* signalisiert wurde oder der optionale Timer abgelaufen ist. Der exklusive *mutex* muss beim Eintritt in diesen Befehl vom aufrufenden Thread gesperrt sein. Ist der Mutex nicht gesperrt, wird ein Tcl-Fehler ausgelöst. Während des Wartens auf *cond* gibt der Befehl *mutex* frei. Bevor er zum aufrufenden Thread zurückkehrt, erlangt der Befehl *mutex* wieder. Das Entsperren von *mutex* und das Warten auf die Bedingungsvariable *cond* geschehen atomar.

        Die Befehlsoption **ms**, falls angegeben, muss eine ganze Zahl sein, die das Zeitintervall in Millisekunden angibt, das der Befehl auf ein Signal wartet. Andernfalls wartet der Befehl unbegrenzt auf die Benachrichtigung der Bedingung.

        In Programmen mit mehreren Threads gibt es viele Situationen, in denen ein Thread auf ein Ereignis warten muss, bevor er fortfahren darf. Das wird gewöhnlich erreicht, indem eine Bedingung unter dem Schutz des Mutex wiederholt geprüft und auf die Bedingungsvariable gewartet wird, bis die Bedingung wahr ergibt:

        ```
            set mutex [thread::mutex create]
            set cond  [thread::cond  create]

            thread::mutex lock $mutex
            while {<some_condition_is_true>} {
                thread::cond wait $cond $mutex
            }
            # Do some work under mutex protection
            thread::mutex unlock $mutex
        ```

        Die Bedingung muss wiederholt geprüft werden, weil die Bedingungsvariable signalisiert werden kann, ohne dass die Bedingung sich tatsächlich geändert hat (zum Beispiel unechtes Aufwecken von Threads).



# Diskussion

Das grundlegende Threading-Modell in Tcl ist, dass es einen oder mehrere Tcl-Interpreter je Thread geben kann, jeder Tcl-Interpreter aber nur von dem einen Thread verwendet werden soll, der ihn erzeugt hat. Eine Abstraktion „gemeinsamer Speicher“ ist in Tcl ungeschickt bereitzustellen, weil Tcl Annahmen über den Besitz von Variablen und Daten macht. Darum unterstützt diese Erweiterung eine einfache Form des Threading, bei der der Haupt-Thread mehrere Hintergrund- oder „Arbeits“-Threads verwalten kann. Ein ereignisgetriebener Server kann zum Beispiel Aufträge an Arbeits-Threads weitergeben und dann auf Antworten der Arbeits-Threads oder auf neue Client-Aufträge warten. Alles läuft durch die gemeinsame Tcl-Ereignisschleife, sodass die Nachrichtenübermittlung zwischen Threads natürlich mit ereignisgetriebener Ein-/Ausgabe, **vwait** auf Variablen und so weiter zusammenwirkt. Für die Übertragung großer Informationsmengen lassen sich Kanäle zwischen den Threads verschieben.

Für fortgeschrittene Skripte mit mehreren Threads wird auch der Zugang auf Skriptebene zu zwei grundlegenden Synchronisationsgrundelementen unterstützt, Mutex und Bedingungsvariablen.
