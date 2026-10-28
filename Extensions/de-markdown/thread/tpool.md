---
CommandName: tpool
title: tpool
ManualSection: n
Version: 3.0
TclPart: Tcl Threading
TclDescription:
Links:
 - thread
 - tsv
 - ttrace
Keywords:
 - thread
 - threadpool
Copyright:
---

# Name

tpool - Teil der Tcl-Threading-Erweiterung für Pools von Arbeits-Threads

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [9.0]{.lit}
[package]{.cmd} [require]{.sub} [thread]{.lit} [3.0]{.optlit}
[tpool::create]{.cmd} [options]{.optarg}
[tpool::names]{.cmd}
[tpool::post]{.cmd} [-detached]{.optarg} [-nowait]{.optarg} [tpool]{.arg} [script]{.arg}
[tpool::wait]{.cmd} [tpool]{.arg} [joblist]{.arg} [varname]{.optarg}
[tpool::cancel]{.cmd} [tpool]{.arg} [joblist]{.arg} [varname]{.optarg}
[tpool::get]{.cmd} [tpool]{.arg} [job]{.arg}
[tpool::preserve]{.cmd} [tpool]{.arg}
[tpool::release]{.cmd} [tpool]{.arg}
[tpool::suspend]{.cmd} [tpool]{.arg}
[tpool::resume]{.cmd} [tpool]{.arg}
:::

# Beschreibung

Dieses Paket erzeugt und verwaltet Pools von Arbeits-Threads. Es erlaubt, Aufträge an Arbeits-Threads zu geben und auf ihren Abschluss zu warten. Die Umsetzung des Thread-Pools kennt die Tcl-Ereignisschleife. Das heißt: Immer wenn ein Aufrufer auf ein Ereignis warten muss (ein Auftrag wird abgeschlossen, oder ein Arbeits-Thread wird untätig oder ist initialisiert), betritt die Umsetzung die Ereignisschleife und erlaubt die Bearbeitung anderer anstehender Datei-, Timer- oder sonst unterstützter Ereignisse.

# Befehle

**tpool::create** ?options?
: Dieser Befehl erzeugt einen neuen Thread-Pool. Er nimmt mehrere Optionen als Schlüssel-Wert-Paare entgegen. Die Optionen dienen dazu, einige Parameter des Thread-Pools einzustellen. Der Befehl gibt die ID des neu erzeugten Thread-Pools zurück.

    Folgende Optionen werden unterstützt:

    **-minworkers** *number*
    : Mindestzahl der Arbeits-Threads, die diese Instanz des Thread-Pools braucht. Beim Erzeugen des Thread-Pools legt die Umsetzung so viele Arbeits-Threads im Voraus an und hält mindestens diese Zahl während der Lebensdauer der Instanz am Leben. Der Vorgabewert dieses Parameters ist 0 (null). Das bedeutet, dass ein neuer Thread-Pool anfangs keine Arbeits-Threads hat. Alle Arbeits-Threads werden bei Bedarf von Aufrufern gestartet, die den Befehl **tpool::post** ausführen und Aufträge in die Auftragswarteschlange stellen.

    **-maxworkers** *number*
    : Höchstzahl der Arbeits-Threads, die diese Instanz des Thread-Pools zulässt. Liegt ein neuer Auftrag an und ist kein untätiger Arbeits-Thread verfügbar, versucht die Umsetzung, einen neuen Arbeits-Thread zu erzeugen. Ist die Zahl der verfügbaren Arbeits-Threads kleiner als die angegebene Zahl, startet ein neuer Arbeits-Thread. Der Aufrufer betritt automatisch die Ereignisschleife und wartet, bis der Arbeits-Thread initialisiert ist. Ist die Zahl der verfügbaren Arbeits-Threads jedoch gleich der angegebenen Zahl, betritt der Aufrufer die Ereignisschleife und wartet, bis der erste Arbeits-Thread untätig und damit bereit ist, den Auftrag auszuführen. Der Vorgabewert dieses Parameters ist 4 (vier). Das bedeutet, dass die Instanz des Thread-Pools höchstens 4 Arbeits-Threads zulässt, die Aufträge ausführen oder untätig auf neue Aufträge in der Auftragswarteschlange warten.

    **-idletime** *seconds*
    : Zeit in Sekunden, die ein untätiger Arbeits-Thread auf einen Auftrag in der Auftragswarteschlange wartet. Trifft in diesem Intervall kein Auftrag ein und läuft die Zeit ab, prüft der Arbeits-Thread die Zahl der gerade verfügbaren Arbeits-Threads und beendet sich, wenn die Zahl höher ist als die durch die Option **minthreads** gesetzte Zahl. Ist ein **exitscript** definiert, führt der sich beendende Arbeits-Thread zuerst das Skript aus und beendet sich dann. Fehler aus dem Beendigungsskript, falls vorhanden, werden ignoriert.

        Der untätige Arbeits-Thread bedient die Ereignisschleife nicht. Wird der Arbeits-Thread jedoch in die Ereignisschleife gelegt, indem **vwait** oder andere verwandte Tcl-Befehle ausgewertet werden, ist der Arbeits-Thread nicht untätig, und der Untätigkeits-Timer wird nicht berücksichtigt. Der Vorgabewert dieser Option ist unbestimmt.

    **-initcmd** *script*
    : Setzt ein Tcl-Skript, mit dem ein neuer Arbeits-Thread initialisiert wird. Das dient gewöhnlich dazu, im Worker Pakete und Befehle zu laden, Vorgabevariablen zu setzen, Namespaces zu erzeugen und Ähnliches. Läuft das übergebene Skript in einen Tcl-Fehler, wird der Worker nicht erzeugt, und der auslösende Befehl (**tpool::create** oder **tpool::post**) löst einen Fehler aus. Der Vorgabewert dieser Option ist unbestimmt, der Tcl-Interpreter des Arbeits-Threads enthält also nur den anfänglichen Satz von Tcl-Befehlen.

    **-exitcmd** *script*
    : Setzt ein Tcl-Skript, das läuft, wenn der untätige Arbeits-Thread sich beendet. Das dient gewöhnlich dazu, den Zustand des Arbeits-Threads aufzuräumen, reservierte Ressourcen freizugeben, Speicher aufzuräumen und Ähnliches. Der Vorgabewert dieser Option ist unbestimmt, beim Beenden des Arbeits-Threads läuft also kein Tcl-Skript.


**tpool::names**
: Dieser Befehl gibt eine Liste der IDs von Thread-Pools zurück, die mit dem Befehl **tpool::create** erzeugt wurden. Wurden keine Thread-Pools gefunden, gibt der Befehl eine leere Liste zurück.

**tpool::post** ?-detached? ?-nowait? *tpool* *script*
: Dieser Befehl sendet ein *script* zur Ausführung an den Ziel-Thread-Pool *tpool*. Das Skript wird im ersten verfügbaren untätigen Arbeits-Thread ausgeführt. Ist kein untätiger Arbeits-Thread verfügbar, erzeugt der Befehl einen neuen, betritt die Ereignisschleife und bedient Ereignisse, bis der neu erzeugte Thread initialisiert ist. Ist die aktuelle Zahl der Arbeits-Threads gleich der Höchstzahl, wie sie beim Erzeugen des Thread-Pools festgelegt wurde, betritt der Befehl die Ereignisschleife und bedient Ereignisse, während er darauf wartet, dass einer der Arbeits-Threads untätig wird. Ist das optionale Argument ?-nowait? angegeben, legt der Befehl den Auftrag nur in die Auftragswarteschlange des Pools, ohne auf einen untätigen Worker zu warten oder einen neuen zu erzeugen, auch wenn der Pool noch Platz für weitere Threads hätte.

    Der Befehl gibt die ID des abgegebenen Auftrags zurück. Diese ID wird für die nachfolgenden Befehle **tpool::wait**, **tpool::get** und **tpool::cancel** verwendet, um auf das Ergebnis des abgegebenen Skripts zu warten und es abzuholen oder den abgegebenen Auftrag abzubrechen. Ist das optionale Argument ?-detached? angegeben, gibt der Befehl einen losgelösten Auftrag ab. Ein losgelöster Auftrag lässt sich nicht abbrechen und nicht abwarten und ist nicht durch die Auftrags-ID bezeichnet.

    Wird der Thread-Pool *tpool* nicht in der Liste der aktiven Thread-Pools gefunden, löst der Befehl einen Fehler aus. Der Fehler wird auch ausgelöst, wenn der neu erzeugte Arbeits-Thread sich nicht initialisieren lässt.

**tpool::wait** *tpool* *joblist* ?varname?
: Dieser Befehl wartet auf einen oder viele Aufträge, deren Auftrags-IDs in *joblist* stehen, bis sie von den Arbeits-Threads verarbeitet sind. Ist keiner der angegebenen Aufträge fertig, betritt der Befehl die Ereignisschleife, bedient Ereignisse und wartet auf den ersten fertigen Auftrag.

    Der Befehl gibt die Liste der abgeschlossenen Auftrags-IDs zurück. Ist die optionale Variable ?varname? angegeben, wird sie auf die Liste der Aufträge in *joblist* gesetzt, die noch anstehen. Wird der Thread-Pool *tpool* nicht in der Liste der aktiven Thread-Pools gefunden, löst der Befehl einen Fehler aus.

**tpool::cancel** *tpool* *joblist* ?varname?
: Dieser Befehl bricht die zuvor an den Pool *tpool* abgegebenen Aufträge ab, die *joblist* nennt. Das Abbrechen gelingt nur für einen Auftrag, der noch auf die Verarbeitung wartet. Wird der Auftrag bereits von einem der Arbeits-Threads ausgeführt, wird er nicht abgebrochen. Der Befehl gibt die Liste der abgebrochenen Auftrags-IDs zurück. Ist die optionale Variable ?varname? angegeben, wird sie auf die Liste der Aufträge in *joblist* gesetzt, die nicht abgebrochen wurden. Wird der Thread-Pool *tpool* nicht in der Liste der aktiven Thread-Pools gefunden, löst der Befehl einen Fehler aus.

**tpool::get** *tpool* *job*
: Dieser Befehl holt das Ergebnis des zuvor abgegebenen *job*. Nur Ergebnisse von Aufträgen, auf die mit dem Befehl **tpool::wait** gewartet wurde, lassen sich abholen. Führte die Ausführung des Skripts zu einem Fehler, löst der Befehl den Fehler aus und aktualisiert die Variablen **errorInfo** und **errorCode** entsprechend. Wird der Pool *tpool* nicht in der Liste der Thread-Pools gefunden, löst der Befehl einen Fehler aus. Ist der Auftrag *job* nicht zur Abholung bereit, weil ein Arbeits-Thread ihn gerade ausführt, löst der Befehl einen Fehler aus.

**tpool::preserve** *tpool*
: Jeder Aufruf dieses Befehls erhöht den Referenzzähler des Thread-Pools *tpool* um eins (1). Der Befehl gibt den Wert des Referenzzählers nach der Erhöhung zurück. Durch das Erhöhen des Referenzzählers zeigt der Aufrufer an, dass er die Ressource längere Zeit verwenden will.

**tpool::release** *tpool*
: Jeder Aufruf dieses Befehls verringert den Referenzzähler des Thread-Pools *tpool* um eins (1). Der Befehl gibt den Wert des Referenzzählers nach der Verringerung zurück. Erreicht der Referenzzähler null (0), wird der Thread-Pool *tpool* zur Beendigung vorgemerkt. Nachdem der Befehl **tpool::release** null zurückgibt, darf der Thread-Pool nicht mehr verwendet werden. Das Handle *tpool* verlässt den Geltungsbereich und darf nicht weiter verwendet werden. Jeder folgende Verweis auf dasselbe Handle des Thread-Pools führt zu einem Tcl-Fehler.

**tpool::suspend** *tpool*
: Hält die Verarbeitung von Arbeit auf dieser Warteschlange an. Alle Worker des Pools werden pausiert, weitere Arbeit kann dem Pool aber hinzugefügt werden. Das Hinzufügen weiterer Arbeit erhöht die Zahl der Worker nicht dynamisch, weil die Verarbeitung des Pools angehalten ist. Die Zahl der Worker bleibt bei dem Stand, der vor dem Anhalten der Worker-Tätigkeit bestand. Muss eine bestimmte Zahl von Arbeits-Threads sichergestellt werden, dient die Option **minworkers** des Befehls **tpool::create**.

**tpool::resume** *tpool*
: Nimmt die Verarbeitung von Arbeit auf dieser Warteschlange wieder auf. Alle pausierten (angehaltenen) Worker dürfen sich Arbeit aus dem Pool holen. Das Wiederaufnehmen des Poolbetriebs lässt nur bereits erzeugte Worker fortfahren. Es erzeugt keine zusätzlichen Arbeits-Threads, um die in die Arbeitswarteschlange des Pools gestellte Arbeit zu erledigen.


# Diskussion

Der Thread-Pool ist eines der häufigsten Threading-Muster, wenn Serveranwendungen eine große Zahl verhältnismäßig kleiner Aufgaben bearbeiten. Ein sehr einfaches Modell für eine Serveranwendung würde bei jedem eintreffenden Auftrag einen neuen Thread erzeugen und den Auftrag in dem neuen Thread bedienen. Ein Nachteil dieses Vorgehens ist, dass der Aufwand, für jeden Auftrag einen neuen Thread zu erzeugen, erheblich ist. Ein Server, der für jeden Auftrag einen neuen Thread erzeugt, würde mehr Zeit und mehr Systemressourcen für das Erzeugen und Zerstören von Threads aufwenden als für die eigentlichen Benutzeraufträge. Neben dem Aufwand für das Erzeugen und Zerstören von Threads verbrauchen aktive Threads Systemressourcen. Zu viele Threads können dazu führen, dass dem System der Speicher ausgeht oder es durch übermäßigen Speicherverbrauch zusammenbricht.

Ein Thread-Pool löst sowohl das Problem des Aufwands im Lebenszyklus von Threads als auch das Problem der Ressourcenüberlastung. Werden Threads für mehrere Aufgaben wiederverwendet, verteilt sich der Aufwand der Thread-Erzeugung auf viele Aufgaben. Als Zugabe entfällt die Verzögerung durch die Thread-Erzeugung, weil der Thread schon besteht, wenn ein Auftrag eintrifft. Der Auftrag kann also sofort bedient werden. Wird die Zahl der Threads im Thread-Pool passend eingestellt, lässt sich auch die Ressourcenüberlastung vermeiden, indem jeder Auftrag warten muss, bis ein Thread frei ist, ihn zu verarbeiten.
