---
CommandName: unknown
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - info(n)
 - proc(n)
 - interp(n)
 - library(n)
 - namespace(n)
Keywords:
 - error
 - non-existent command
 - unknown
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

unknown - Behandelt Versuche, nicht existierende Befehle zu verwenden

# ÜBERSICHT

::: {.synopsis} :::
[unknown]{.cmd} [cmdName]{.arg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Dieser Befehl wird vom Tcl-Interpreter aufgerufen, wenn ein Skript versucht, einen Befehl aufzurufen, der nicht existiert. Die Standardimplementierung von **unknown** ist eine Bibliotheksprozedur, die beim Initialisieren eines Interpreters definiert wird. Sie können die Standard-**unknown** überschreiben, um ihr Verhalten zu ändern, oder für einzelne Namespaces einen neuen Handler mit **namespace unknown** registrieren. Beachten Sie, dass es in einem sicheren Interpreter keine Standardimplementierung von **unknown** gibt.

Trifft der Tcl-Interpreter auf einen Befehlsnamen, für den weder im aktuellen Namespace noch im globalen Namespace ein Befehl definiert ist, prüft Tcl, ob ein unknown-Handler für den aktuellen Namespace existiert. Standardmäßig ist dieser Handler ein Befehl namens **::unknown**. Gibt es keinen solchen Befehl, liefert der Interpreter einen Fehler. Existiert **unknown** (oder wurde für den aktuellen Namespace ein neuer Handler registriert), wird er mit Argumenten aufgerufen, die aus dem vollständig substituierten Namen und den Argumenten des ursprünglich nicht existierenden Befehls bestehen. **unknown** führt typischerweise Aktionen aus wie das Durchsuchen von Bibliotheksverzeichnissen nach einer Befehlsprozedur mit dem Namen *cmdName*, das Erweitern abgekürzter Befehlsnamen auf volle Länge oder das automatische Ausführen unbekannter Befehle als Unterprozesse. In manchen Fällen (z. B. beim Erweitern von Abkürzungen) ändert **unknown** den ursprünglichen Befehl leicht und führt ihn dann (erneut) aus. Das Ergebnis von **unknown** wird als Ergebnis des ursprünglich nicht existierenden Befehls verwendet.

Die Standardimplementierung von **unknown** verhält sich wie folgt. Zuerst ruft sie die Bibliotheksprozedur **auto_load** auf, um den Befehl zu laden. Gelingt das, führt sie den ursprünglichen Befehl mit seinen ursprünglichen Argumenten aus. Schlägt das Auto-Load fehl und läuft Tcl interaktiv, ruft **unknown** **auto_execok** auf, um zu prüfen, ob es eine ausführbare Datei mit dem Namen *cmd* gibt. Ist das der Fall, ruft sie den Tcl-Befehl **exec** mit *cmd* und allen *args* als Argumente auf. Kann *cmd* nicht auto-ausgeführt werden, prüft **unknown**, ob der Befehl auf oberster Ebene und außerhalb eines Skripts aufgerufen wurde. Ist das so, führt **unknown** zwei weitere Schritte aus. Zuerst prüft sie, ob *cmd* eine der folgenden drei Formen hat: **!!**, **!**_event_ oder **^**_old_**^**_new_?**^**?. Ist das der Fall, führt **unknown** History-Substitution wie **csh** für diese Konstrukte durch. Schließlich prüft **unknown**, ob *cmd* eine eindeutige Abkürzung eines existierenden Tcl-Befehls ist. Ist das so, erweitert sie den Befehlsnamen und führt den Befehl mit den ursprünglichen Argumenten aus. Konnte keiner dieser Schritte den Befehl ausführen, erzeugt **unknown** einen Fehlerrückgabewert. Ist die globale Variable **auto_noload** definiert, wird der Auto-Load-Schritt übersprungen. Ist **auto_noexec** definiert, wird der Auto-Exec-Schritt übersprungen. Unter normalen Umständen ist der Rückgabewert von **unknown** der Rückgabewert des schließlich ausgeführten Befehls.

# BEISPIELE

**unknown** soll sein Standardverhalten haben, aber zuerst protokollieren, dass ein Befehl nicht gefunden wurde:

```
# Original speichern, damit wir daran anknüpfen können
rename unknown _original_unknown

# Eigene Implementierung bereitstellen
proc unknown args {
    puts stderr "WARNING: unknown command: $args"
    uplevel 1 [list _original_unknown {*}$args]
}
```
