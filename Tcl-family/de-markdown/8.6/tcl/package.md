---
CommandName: package
title: package
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - msgcat(n)
 - packagens(n)
 - pkgMkIndex(n)
Keywords:
 - package
 - version
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
---

# Name

package - Funktionen zum Laden von Paketen und zur Versionskontrolle

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [forget]{.sub} [package package]{.optdot}
[package]{.cmd} [ifneeded]{.sub} [package]{.arg} [version]{.arg} [script]{.optarg}
[package]{.cmd} [names]{.sub}
[package]{.cmd} [present]{.sub} [package]{.arg} [requirement...]{.optarg}
[package]{.cmd} [present]{.sub} [-exact]{.lit} [package]{.arg} [version]{.arg}
[package]{.cmd} [provide]{.sub} [package]{.arg} [version]{.optarg}
[package]{.cmd} [require]{.sub} [package]{.arg} [requirement...]{.optarg}
[package]{.cmd} [require]{.sub} [-exact]{.lit} [package]{.arg} [version]{.arg}
[package]{.cmd} [unknown]{.sub} [command]{.optarg}
[package]{.cmd} [vcompare]{.sub} [version1]{.arg} [version2]{.arg}
[package]{.cmd} [versions]{.sub} [package]{.arg}
[package]{.cmd} [vsatisfies]{.sub} [version]{.arg} [requirement...]{.arg}
[package]{.cmd} [prefer]{.sub} [latest|stable]{.optlit}
:::

# Beschreibung

Dieser Befehl führt eine einfache Datenbank der Pakete, die der aktuelle Interpreter verwenden kann, und hält fest, wie sie in den Interpreter geladen werden. Er unterstützt mehrere Versionen jedes Pakets und sorgt dafür, dass die richtige Version eines Pakets geladen wird, je nachdem, was die Anwendung benötigt. Außerdem erkennt und meldet der Befehl Versionskonflikte. In normalen Tcl-Skripten werden meist nur die Befehle **package require** und **package provide** aufgerufen. Die übrigen Befehle verwenden vor allem Systemskripte, die die Paketdatenbank pflegen.

Das Verhalten des Befehls **package** hängt von seinem ersten Argument ab. Die folgenden Formen sind zulässig:

**package forget** ?*package package ...*?
: Entfernt aus diesem Interpreter alle Informationen über jedes angegebene Paket, auch die Informationen, die mit **package ifneeded** und mit **package provide** bereitgestellt wurden.

[package]{.cmd} [ifneeded]{.sub} [package]{.arg} [version]{.arg} [script]{.optarg}
: Dieser Befehl steht normalerweise nur in Skripten zur Systemkonfiguration, die die Paketdatenbank einrichten. Er gibt an, dass eine bestimmte Version eines bestimmten Pakets bei Bedarf verfügbar ist und dass das Paket dem Interpreter hinzugefügt werden kann, indem *script* ausgeführt wird. Das Skript wird in einer Datenbank gespeichert, damit spätere **package require**-Befehle es verwenden können. Normalerweise richtet *script* das Auto-Load für die Befehle des Pakets ein (oder ruft direkt [load] und/oder [source] auf) und ruft danach **package provide** auf, um anzuzeigen, dass das Paket vorhanden ist. Die Datenbank kann Informationen zu mehreren verschiedenen Versionen eines einzigen Pakets enthalten. Enthält die Datenbank bereits Informationen zu *package* und *version*, ersetzt das neue *script* das vorhandene. Wird das Argument *script* weggelassen, wird das aktuelle Skript für die Version *version* des Pakets *package* zurückgegeben, oder eine leere Zeichenkette, wenn für dieses *package* und diese *version* noch kein **package ifneeded**-Befehl aufgerufen wurde.

[package]{.cmd} [names]{.sub}
: Gibt eine Liste der Namen aller Pakete im Interpreter zurück, für die eine Version bereitgestellt wurde (mit **package provide**) oder für die ein **package ifneeded**-Skript verfügbar ist. Die Reihenfolge der Elemente in der Liste ist beliebig.

[package]{.cmd} [present]{.sub} [-exact]{.optlit} [package]{.arg} [requirement...]{.optarg}
: Dieser Befehl entspricht **package require**, versucht aber nicht, das Paket zu laden, wenn es noch nicht geladen ist.

[package]{.cmd} [provide]{.sub} [package]{.arg} [version]{.optarg}
: Dieser Befehl wird aufgerufen, um anzuzeigen, dass die Version *version* des Pakets *package* jetzt im Interpreter vorhanden ist. Normalerweise wird er einmal im Rahmen eines **ifneeded**-Skripts aufgerufen und ein weiteres Mal vom Paket selbst, wenn es schließlich geladen ist. Wurde mit einem früheren **package provide**-Befehl eine andere Version von *package* bereitgestellt, tritt ein Fehler auf. Wird das Argument *version* weggelassen, gibt der Befehl die derzeit bereitgestellte Versionsnummer zurück, oder eine leere Zeichenkette, wenn in diesem Interpreter für *package* noch kein **package provide**-Befehl aufgerufen wurde.

[package]{.cmd} [require]{.sub} [package]{.arg} [requirement...]{.optarg}
: Dieser Befehl wird normalerweise von Tcl-Code aufgerufen, der eine bestimmte Version eines bestimmten Pakets verwenden will. Die Argumente geben an, welches Paket gewünscht ist, und der Befehl stellt sicher, dass eine passende Version des Pakets in den Interpreter geladen wird. Ist der Befehl erfolgreich, gibt er die geladene Versionsnummer zurück. Andernfalls erzeugt er einen Fehler.

    Eine passende Version des Pakets ist jede Version, die mindestens eine der Anforderungen erfüllt, wie sie unten im Abschnitt [Anforderung] definiert sind. Sind mehrere Versionen passend, wird die Implementierung mit der höchsten Version gewählt. Dieser letzte Schritt wird zusätzlich vom Auswahlmodus beeinflusst, der mit **package prefer** festgelegt wird.

    Im Auswahlmodus „stable“ wählt der Befehl die höchste stabile Version, die die Anforderungen erfüllt, sofern es eine gibt. Erfüllt keine stabile Version die Anforderungen, wird die höchste instabile Version gewählt, die die Anforderungen erfüllt. Im Auswahlmodus „latest“ akzeptiert der Befehl die höchste Version, die alle Anforderungen erfüllt, unabhängig davon, ob sie stabil ist.

    Wurde bereits eine Version von *package* bereitgestellt (durch Aufruf des Befehls **package provide**), muss ihre Versionsnummer die *requirement*-Argumente erfüllen, und der Befehl kehrt sofort zurück. Andernfalls durchsucht der Befehl die Datenbank mit den Informationen aus früheren **package ifneeded**-Befehlen, um festzustellen, ob eine annehmbare Version des Pakets verfügbar ist. Ist das der Fall, wird das Skript für die höchste annehmbare Versionsnummer im globalen Namespace ausgewertet. Es muss alles Nötige tun, um das Paket zu laden, einschließlich des Aufrufs von **package provide** für das Paket. Enthält die **package ifneeded**-Datenbank keine annehmbare Version des Pakets und wurde für den Interpreter ein **package unknown**-Befehl festgelegt, wird dieser Befehl im globalen Namespace ausgewertet. Wenn er abgeschlossen ist, prüft Tcl erneut, ob das Paket jetzt bereitgestellt ist oder ob es ein **package ifneeded**-Skript dafür gibt. Liefert keiner dieser Schritte eine annehmbare Version des Pakets, gibt der Befehl einen Fehler zurück.

[package]{.cmd} [require]{.sub} [-exact]{.lit} [package]{.arg} [version]{.arg}
: Diese Form des Befehls wird verwendet, wenn für den Aufrufer nur die angegebene *version* von *package* annehmbar ist. Dieser Befehl entspricht **package require** *package version*-*version*.

[package]{.cmd} [unknown]{.sub} [command]{.optarg}
: Dieser Befehl legt einen Befehl als „letzten Ausweg“ fest, der bei **package require** aufgerufen wird, wenn in der **package ifneeded**-Datenbank keine passende Version eines Pakets zu finden ist. Wird das Argument *command* angegeben, enthält es den ersten Teil eines Befehls. Wird dieser Befehl während eines **package require**-Befehls aufgerufen, hängt Tcl ein oder mehrere zusätzliche Argumente an, die den gewünschten Paketnamen und die Anforderungen angeben. Ist *command* zum Beispiel **foo bar** und wird später der Befehl **package require test 2.4** aufgerufen, führt Tcl den Befehl **foo bar test 2.4** aus, um das Paket zu laden. Werden dem Befehl **package require** keine Anforderungen übergeben, wird dem aufgerufenen Befehl nur der Name hinzugefügt. Wird der Befehl **package unknown** ohne das Argument *command* aufgerufen, wird das aktuelle **package unknown**-Skript zurückgegeben, oder eine leere Zeichenkette, wenn es keines gibt. Wird *command* als leere Zeichenkette angegeben, wird das aktuelle **package unknown**-Skript entfernt, sofern es eines gibt.

[package]{.cmd} [vcompare]{.sub} [version1]{.arg} [version2]{.arg}
: Vergleicht die beiden Versionsnummern *version1* und *version2*. Gibt -1 zurück, wenn *version1* eine frühere Version als *version2* ist, 0, wenn beide gleich sind, und 1, wenn *version1* später als *version2* ist.

[package]{.cmd} [versions]{.sub} [package]{.arg}
: Gibt eine Liste aller Versionsnummern von *package* zurück, für die mit **package ifneeded**-Befehlen Informationen bereitgestellt wurden.

[package]{.cmd} [vsatisfies]{.sub} [version]{.arg} [requirement...]{.arg}
: Gibt 1 zurück, wenn *version* mindestens eine der angegebenen Anforderungen erfüllt, sonst 0. Die *requirements* sind unten im Abschnitt [Anforderung] definiert.

[package]{.cmd} [prefer]{.sub} [latest|stable]{.optlit}
: Ohne Argumente gibt der Befehl entweder „latest“ oder „stable“ zurück, je nachdem, welcher Wert den aktuellen Modus der Auswahllogik von **package require** beschreibt.

    Mit dem Argument „latest“ setzt er den Modus der Auswahllogik auf „latest“.

    Mit dem Argument „stable“ bleibt der Wert erhalten, wenn der Modus bereits „stable“ ist. Ist der Modus bereits „latest“, bleibt der Versuch wirkungslos, ihn auf „stable“ zurückzusetzen, und der Modus bleibt „latest“.

    Mit jedem anderen Wert als Argument wird ein Fehler wegen eines ungültigen Arguments ausgelöst.

    Wenn ein Interpreter erzeugt wird, wird sein anfänglicher Auswahlmodus auf „stable“ gesetzt, sofern die Umgebungsvariable **TCL\_PKG\_PREFER\_LATEST** nicht gesetzt ist (auf einen beliebigen Wert). Andernfalls wird der anfängliche (und dauerhafte) Auswahlmodus auf „latest“ gesetzt.


# Versionsnummern

Versionsnummern bestehen aus einer oder mehreren Dezimalzahlen, die durch Punkte getrennt sind, etwa 2, 1.162 oder 3.1.13.1. Die erste Zahl heißt Hauptversionsnummer. Größere Zahlen entsprechen späteren Versionen eines Pakets, wobei die Zahlen weiter links mehr Gewicht haben. So ist zum Beispiel Version 2.1 später als 1.3, und Version 3.4.6 ist später als 3.3.5. Fehlende Felder entsprechen Nullen: Version 1.3 ist dasselbe wie Version 1.3.0 und 1.3.0.0 und damit früher als 1.3.1 oder 1.3.0.2. Außerdem dürfen die Buchstaben „a“ (alpha) und/oder „b“ (beta) genau einmal anstelle eines Punkts als Trennzeichen stehen. Diese Buchstaben fügen der Version semantisch eine negative Angabe hinzu, wobei „a“ für -2 und „b“ für -1 steht. Jeder darf nur einmal angegeben werden, und „a“ und „b“ schließen sich in einer Angabe gegenseitig aus. So wird 1.3a1 (semantisch) zu 1.3.-2.1, und 1.3b1 ist 1.3.-1.1. Negative Zahlen sind in Versionsangaben nicht direkt erlaubt. Eine Versionsnummer, die die Buchstaben „a“ oder „b“ wie oben beschrieben nicht enthält, heißt **stable** (stabile Version). Enthält sie die Buchstaben, heißt die Version **unstable** (instabil). Eine spätere Versionsnummer gilt als aufwärtskompatibel zu einer früheren, solange beide Versionen dieselbe Hauptversionsnummer haben. So sollten Tcl-Skripte, die für Version 2.3 eines Pakets geschrieben wurden, unverändert unter den Versionen 2.3.2, 2.4 und 2.5.1 funktionieren. Änderungen der Hauptversionsnummer bedeuten inkompatible Änderungen: Ist Code für Version 2.1 eines Pakets geschrieben, ist nicht garantiert, dass er ohne Änderungen mit Version 1.7.3 oder Version 3.1 funktioniert.

# Paket-Indizes

Für Pakete in Tcl wird empfohlen, in Skripten die Befehle **package require** und **package provide** aufzurufen und mit der Prozedur [pkg\_mkIndex][pkgMkIndex] Paketindexdateien zu erzeugen. Danach werden Pakete automatisch geladen, wenn **package require**-Befehle sie anfordern. Einzelheiten finden Sie in der Dokumentation zu [pkg\_mkIndex][pkgMkIndex].

# Anforderung

Eine *requirement*-Zeichenkette prüft, ob eine kompatible Versionsnummer eines Pakets vorhanden ist. Die meisten Befehle akzeptieren eine Liste von Anforderungszeichenketten, wobei die höchste passende Version gewählt wird.

Jede *requirement* darf eine der folgenden Formen haben:

*min*
: Diese Form heißt „min-bounded“.

*min***-**
: Diese Form heißt „min-unbound“.

*min***-***max*
: Diese Form heißt „bounded“.


wobei „*min*“ und „*max*“ gültige Versionsnummern sind. Die ältere Syntax ist ein Sonderfall der erweiterten Syntax, sodass die Abwärtskompatibilität erhalten bleibt. Für die Erfüllung gelten folgende Regeln:

1. Die *version* muss mindestens eines der aufgeführten *requirement*-Argumente erfüllen, damit sie passt.

2. Eine Version erfüllt eine „bounded“-Anforderung unter folgenden Bedingungen:

    \[a\]
    : Ist *min* gleich *max*, dann genau dann, wenn die *version* gleich *min* ist.

    \[b\]
    : Andernfalls genau dann, wenn die *version* größer oder gleich *min* und kleiner als *max* ist, wobei *min* und *max* intern beide mit „a0“ aufgefüllt werden. Beachten Sie, dass der Vergleich mit *min* inklusiv ist, der Vergleich mit *max* dagegen exklusiv.


3. Eine „min-bounded“-Anforderung ist eine verkappte „bounded“-Anforderung, deren *max*-Teil implizit die nächsthöhere Hauptversionsnummer des *min*-Teils ist. Ob eine Version sie erfüllt, richtet sich nach den obigen Regeln.

4. Eine *version* erfüllt eine „min-unbound“-Anforderung genau dann, wenn sie größer oder gleich *min* ist, wobei *min* intern mit „a0“ aufgefüllt wird. Eine Obergrenze gibt es nicht.


# Beispiele

Um festzulegen, dass ein Tcl-Skript die Pakete Tk und http benötigt, setzen Sie Folgendes an den Anfang des Skripts:

```
package require Tk
package require http
```

Um zu prüfen, ob das Paket Snack verfügbar ist, und es gegebenenfalls zu laden, gehen Sie so vor (das ist oft nützlich für optionale Erweiterungen von Programmen, bei denen der Verlust der Funktionalität nicht kritisch ist):

```
if {[catch {package require Snack}]} {
    # Error thrown - package not found.
    # Set up a dummy interface to work around the absence
} else {
    # We have the package, configure the app to use it
}
```


[load]: load.md
[pkgMkIndex]: pkgMkIndex.md
[source]: source.md
