---
CommandName: send
title: send
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - application
 - dde
 - name
 - remote execution
 - security
 - send
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

send - Führt einen Befehl in einer anderen Anwendung aus

# Übersicht

::: {.synopsis} :::
[send]{.cmd} [options]{.optarg} [app]{.arg} [cmd]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Dieser Befehl sorgt dafür, dass *cmd* (und *arg*) in der Anwendung mit dem Namen *app* ausgeführt werden. Er gibt das Ergebnis oder den Fehler dieser Ausführung zurück. *App* kann der Name jeder Anwendung sein, deren Hauptfenster auf dem Display liegt, das auch das Hauptfenster des Senders enthält; sie muss nicht im selben Prozess laufen. Sind keine *arg*-Argumente vorhanden, steht der auszuführende Befehl vollständig im Argument *cmd*. Sind ein oder mehr *arg* vorhanden, werden sie wie beim Befehl [eval] zu einem auszuführenden Befehl zusammengefügt.

Beginnen die ersten Argumente des Befehls mit „-", werden sie als Optionen behandelt. Folgende Optionen sind derzeit definiert:

**-async**
: Fordert asynchrone Ausführung an. In diesem Fall endet der Befehl **send** sofort, ohne auf den Abschluss von *cmd* in der Zielanwendung zu warten; es steht kein Ergebnis zur Verfügung, und Fehler im gesendeten Befehl werden ignoriert. Liegt die Zielanwendung im selben Prozess wie die sendende Anwendung, wird die Option **-async** ignoriert.

**-displayof** *pathName*
: Legt fest, dass das Hauptfenster der Zielanwendung auf dem Display des durch *pathName* angegebenen Fensters liegt, statt auf dem Display des Hauptfensters der Anwendung.

**--**
: Dient nur dazu, die Optionsliste zu beenden. Diese Option ist nur nötig, wenn *app* mit „-" beginnen könnte.


# Anwendungsnamen

Der Name einer Anwendung wird zunächst aus dem Namen des Programms oder Skripts gesetzt, das die Anwendung erzeugt hat. Name abfragen und ändern lässt sich mit dem Befehl [tk appname][tk].

# Deaktivierung von send

Wird der Befehl **send** aus einer Anwendung entfernt (z. B. mit [rename] **send {}**), antwortet die Anwendung nicht mehr auf eingehende Send-Anfragen und kann auch keine ausgehenden Anfragen mehr stellen. Die Kommunikation lässt sich durch Aufruf von [tk appname][tk] wieder aktivieren.

# Sicherheit

Der Befehl **send** ist potenziell eine ernsthafte Sicherheitslücke. Unter Unix kann jede Anwendung, die sich mit Ihrem X-Server verbinden kann, Skripte an Ihre Anwendungen senden. Diese eingehenden Skripte können Tcl nutzen, um unter Ihrem Namen Dateien zu lesen und zu schreiben und Unterprozesse zu starten. Host-basierte Zugriffskontrolle wie die von **xhost** ist besonders unsicher, da jeder mit einem Konto auf bestimmten Rechnern sich mit Ihrem Server verbinden kann; ist sie deaktiviert, kann sich jeder überall verbinden. Um wenigstens etwas Sicherheit zu bieten, prüft Tk die vom Server verwendete Zugriffskontrolle und lehnt eingehende Send-Anfragen ab, es sei denn, (a) **xhost**-artige Zugriffskontrolle ist aktiv (nur bestimmte Rechner dürfen Verbindungen aufbauen) und (b) die Liste der freigeschalteten Rechner ist leer. Anwendungen können sich also nur verbinden, wenn sie eine andere Autorisierung wie die von **xauth** verwenden. Unter Windows ist **send** derzeit deaktiviert. Den Großteil der Funktionalität bietet stattdessen der Befehl [dde].

# Beispiel

Dieses Skriptfragment kann verwendet werden, damit eine Anwendung auf einem bestimmten Display nur einmal läuft.

```
if {[tk appname FoobarApp] ne "FoobarApp"} {
    send -async FoobarApp RemoteStart $argv
    exit
}
# Befehl, der remote aufgerufen wird, hebt das
# Hauptfenster an und öffnet die angeforderten Dateien
proc RemoteStart args {
    raise .
    foreach filename $args {
        OpenFile $filename
    }
}
```


[dde]: ../tcl/dde.md
[eval]: ../tcl/eval.md
[rename]: ../tcl/rename.md
[tk]: tk.md
