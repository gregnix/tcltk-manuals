---
CommandName: EXPECT
title: EXPECT
ManualSection: 1
Version: 29 December 1994
TclPart:
TclDescription:
Copyright:
---

# Name

expect - programmierter Dialog mit interaktiven Programmen, Version 5

# Übersicht

::: {.synopsis} :::
[expect]{.cmd} [-dDinN]{.optlit} [[-c]{.lit} [cmds]{.arg}]{.optarg} [[-\[f|b\]]{.optlit} [cmdfile]{.arg}]{.optarg} [args]{.optarg}
:::

# Einleitung

**Expect** ist ein Programm, das nach einem Skript mit anderen interaktiven Programmen „spricht“. Dem Skript folgend weiß **Expect**, was von einem Programm zu erwarten ist und was die passende Antwort sein soll. Eine interpretierte Sprache stellt Verzweigungen und Steuerstrukturen auf hoher Ebene bereit, die den Dialog lenken. Zusätzlich kann der Benutzer die Steuerung übernehmen und bei Bedarf unmittelbar eingreifen und die Steuerung danach an das Skript zurückgeben.

**Expectk** ist eine Mischung aus **Expect** und **Tk**. Es verhält sich genau wie **Expect** und wie **wish** von **Tk**. **Expect** lässt sich auch unmittelbar in C oder C++ verwenden, also ohne Tcl. Die Beschreibung steht in libexpect(3).

Der Name "Expect" kommt von den Folgen *send/expect*, die uucp, kermit und andere Programme zur Modemsteuerung bekannt gemacht haben. Anders als uucp ist **Expect** so verallgemeinert, dass es als Befehl auf Benutzerebene mit jedem Programm und jeder Aufgabe laufen kann. **Expect** kann tatsächlich mit mehreren Programmen gleichzeitig sprechen.

Zum Beispiel kann **Expect** Folgendes:

- Sich vom eigenen Rechner zurückrufen lassen, um sich anzumelden, ohne das Gespräch zu bezahlen.

- Ein Spiel starten, zum Beispiel rogue, und wenn die günstigste Konfiguration nicht erscheint, es wieder und wieder neu starten, bis sie erscheint, und dann die Steuerung übergeben.

- fsck laufen lassen und auf seine Fragen mit "yes" oder "no" antworten oder die Steuerung nach festgelegten Kriterien zurückgeben.

- Eine Verbindung zu einem anderen Netz oder einem BBS aufbauen, zum Beispiel MCI Mail oder CompuServe, und die Post automatisch holen, sodass es aussieht, als wäre sie ursprünglich an das lokale System geschickt worden.

- Umgebungsvariablen, das aktuelle Verzeichnis oder beliebige Angaben über rlogin, telnet, tip, su, chgrp und Ähnliches hinübertragen.


Es gibt verschiedene Gründe, warum die Shell diese Aufgaben nicht ausführen kann. Ein Versuch zeigt es. Mit **Expect** sind sie alle möglich.

Im Allgemeinen eignet sich **Expect**, um jedes Programm laufen zu lassen, das eine Wechselwirkung zwischen Programm und Benutzer verlangt. Nötig ist nur, dass sich die Wechselwirkung programmgesteuert beschreiben lässt. **Expect** kann die Steuerung auf Wunsch an den Benutzer zurückgeben, ohne das gesteuerte Programm anzuhalten. Ebenso kann der Benutzer die Steuerung jederzeit an das Skript zurückgeben.

# Verwendung

**Expect** liest *cmdfile* als Liste auszuführender Befehle. Auf Systemen, die die Notation #! unterstützen, lässt sich **Expect** auch implizit aufrufen, indem das Skript ausführbar markiert wird und die erste Zeile des Skripts lautet:

```
    #!/usr/local/bin/expect -f
```

Der Pfad muss natürlich genau beschreiben, wo **Expect** liegt. /usr/local/bin ist nur ein Beispiel.

Die Markierung **-c** stellt einen Befehl voran, der vor jedem Befehl im Skript ausgeführt wird. Der Befehl sollte in Anführungszeichen stehen, damit die Shell ihn nicht zerlegt. Diese Option darf mehrmals verwendet werden. Mehrere Befehle lassen sich mit einem einzelnen **-c** ausführen, getrennt durch Semikolons. Die Befehle werden in der Reihenfolge ausgeführt, in der sie stehen. Bei Expectk heißt diese Option **-command**.

Die Markierung **-d** schaltet eine Diagnoseausgabe ein, die vor allem die interne Tätigkeit von Befehlen wie **expect** und **interact** meldet. Diese Markierung wirkt wie "exp\_internal 1" am Anfang eines Expect-Skripts, und zusätzlich wird die Version von **Expect** ausgegeben. Der Befehl **strace** eignet sich, um Anweisungen zu verfolgen, der Befehl **trace**, um Variablenzuweisungen zu verfolgen. Bei Expectk heißt diese Option **-diag**.

Die Markierung **-D** schaltet einen interaktiven Debugger ein. Es muss ein ganzzahliger Wert folgen. Der Debugger übernimmt die Steuerung vor der nächsten Tcl-Prozedur, wenn der Wert nicht null ist oder ^C gedrückt wird oder ein Haltepunkt getroffen wird oder ein anderer passender Debugger-Befehl im Skript erscheint. Weitere Angaben zum Debugger stehen in der Datei README oder unter SEE ALSO weiter unten. Bei Expectk heißt diese Option **-Debug**.

Die Markierung **-f** stellt eine Datei voran, aus der Befehle gelesen werden. Die Markierung selbst ist optional, denn sie nützt nur bei der Notation #!, siehe oben, damit weitere Argumente auf der Befehlszeile angegeben werden können. Bei Expectk heißt diese Option **-file**.

In der Vorgabe wird die Befehlsdatei in den Speicher gelesen und vollständig ausgeführt. Gelegentlich sollen Dateien zeilenweise gelesen werden. stdin wird zum Beispiel so gelesen. Sollen beliebige Dateien so behandelt werden, dient die Markierung **-b**. Bei Expectk heißt diese Option **-buffer**. Die Pufferung von stdio kann trotzdem stattfinden. Beim Lesen aus einem Fifo oder von stdin sollte das keine Probleme verursachen.

Ist als Dateiname die Zeichenkette "-" angegeben, wird stattdessen die Standardeingabe gelesen. "./-" liest eine Datei, die tatsächlich "-" heißt.

Die Markierung **-i** lässt **Expect** interaktiv nach Befehlen fragen, statt sie aus einer Datei zu lesen. Die Abfrage endet mit dem Befehl **exit** oder bei EOF. Weitere Angaben stehen bei **interpreter** weiter unten. **-i** gilt als gesetzt, wenn weder eine Befehlsdatei noch **-c** verwendet wird. Bei Expectk heißt diese Option **-interactive**.

**--** kann das Ende der Optionen markieren. Das ist nützlich, wenn ein optionsartiges Argument an das Skript gehen soll, ohne dass **Expect** es auswertet. In der Zeile #! verhindert das jede flagartige Auswertung durch Expect. Das folgende Beispiel lässt die ursprünglichen Argumente, einschließlich des Skriptnamens, in der Variable *argv*.

```
    #!/usr/local/bin/expect --
```

Beim Ergänzen von Argumenten in der Zeile #! sind die üblichen Konventionen von getopt(3) und execve(2) einzuhalten.

Die Datei $exp\_library/expect.rc wird automatisch eingelesen, wenn sie vorhanden ist, sofern nicht die Markierung **-N** verwendet wird. Bei Expectk heißt diese Option **-NORC**. Unmittelbar danach wird die Datei ~/.expect.rc automatisch eingelesen, sofern nicht die Markierung **-n** verwendet wird. Ist die Umgebungsvariable DOTDIR definiert, gilt sie als Verzeichnis, und .expect.rc wird von dort gelesen. Bei Expectk heißt diese Option **-norc**. Dieses Einlesen geschieht erst nach der Ausführung aller Markierungen **-c**.

**-v** lässt Expect seine Versionsnummer ausgeben und sich beenden. Die entsprechende Markierung in Expectk, das lange Markierungsnamen verwendet, ist -version.

Optionale *args* werden zu einer Liste zusammengebaut und in der Variable *argv* gespeichert. *argc* wird auf die Länge von argv gesetzt.

*argv0* ist der Name des Skripts, oder der Binärdatei, wenn kein Skript verwendet wird. Das folgende Beispiel gibt den Namen des Skripts und die ersten drei Argumente aus:

```
    send_user "$argv0 [lrange $argv 0 2]\n"
```

# Befehle

**Expect** verwendet *Tcl* (Tool Command Language). Tcl stellt den Steuerfluss bereit, zum Beispiel if, for, break, die Auswertung von Ausdrücken und mehrere weitere Eigenschaften wie Rekursion, Prozedurdefinition und Ähnliches. Befehle, die hier verwendet, aber nicht definiert werden, zum Beispiel **set**, **if**, **exec**, sind Tcl-Befehle, siehe tcl(3). **Expect** unterstützt zusätzliche Befehle, die unten beschrieben sind. Wenn nichts anderes angegeben ist, geben Befehle die leere Zeichenkette zurück.

Die Befehle stehen alphabetisch, damit sie sich schnell finden lassen. Neue Benutzer finden den Einstieg leichter, wenn sie die Beschreibungen von **spawn**, **send**, **expect** und **interact** in dieser Reihenfolge lesen.

Die beste Einführung in die Sprache, sowohl Expect als auch Tcl, steht im Buch "Exploring Expect", siehe SEE ALSO weiter unten. Diese Handbuchseite enthält Beispiele, aber nur sehr wenige, denn sie ist vor allem als Nachschlagewerk gedacht.

Im Text dieser Handbuchseite meint "Expect" mit großem "E" das Programm **Expect**, während "expect" mit kleinem "e" den Befehl **expect** innerhalb des Programms **Expect** meint.

**close** *\[-slave\] \[-onexec 0|1\] \[-i spawn\_id\]*
: Schließt die Verbindung zum aktuellen Prozess. Die meisten interaktiven Programme erkennen EOF auf ihrer Standardeingabe und beenden sich. **close** genügt deshalb gewöhnlich auch, um den Prozess zu beenden. Die Markierung **-i** nennt den zu schließenden Prozess anhand der angegebenen spawn\_id.

    Sowohl **expect** als auch **interact** erkennen, wenn der aktuelle Prozess endet, und führen implizit **close** aus. Wird der Prozess zum Beispiel mit "exec kill $pid" beendet, ist **close** ausdrücklich aufzurufen.

    Die Markierung **-onexec** bestimmt, ob die Spawn-Id in jedem neu gestarteten Prozess geschlossen wird oder wenn der Prozess überlagert wird. Der Wert 0 lässt eine Spawn-Id offen. Ein ganzzahliger Wert ungleich null erzwingt das Schließen des Spawns in jedem neuen Prozess, das ist die Vorgabe.

    Die Markierung **-slave** schließt den zur Spawn-Id gehörenden Slave. Siehe dazu "spawn -pty". Wird die Verbindung geschlossen, wird der Slave automatisch mitgeschlossen, falls er noch offen ist.

    Ob die Verbindung implizit oder ausdrücklich geschlossen wird, **wait** ist aufzurufen, um den zugehörigen Prozessplatz im Kernel freizugeben. **close** ruft **wait** nicht auf, denn es ist nicht gesichert, dass das Schließen einer Prozessverbindung den Prozess beendet. Weitere Angaben stehen unten bei **wait**.

**debug** *\[\[-now\] 0|1\]*
: Steuert einen Tcl-Debugger, der Anweisungen schrittweise ausführt, Haltepunkte setzt und Ähnliches.

    Ohne Argumente kommt 1 zurück, wenn der Debugger nicht läuft, sonst 0.

    Mit dem Argument 1 wird der Debugger gestartet. Mit dem Argument 0 wird der Debugger angehalten. Steht vor dem Argument 1 die Markierung **-now**, startet der Debugger sofort, also mitten im Befehl **debug** selbst. Sonst startet der Debugger mit der nächsten Tcl-Anweisung.

    Der Befehl **debug** ändert keine Traps. Zum Vergleich der Start von Expect mit der Markierung **-D**, siehe oben.

    Weitere Angaben zum Debugger stehen in der Datei README oder unter SEE ALSO weiter unten.

**disconnect**
: Trennt einen abgespaltenen Prozess vom Terminal. Er läuft im Hintergrund weiter. Der Prozess bekommt eine eigene Prozessgruppe, wenn das möglich ist. Die Standard-Ein-/Ausgabe wird nach /dev/null umgelenkt.

    Das folgende Fragment nutzt **disconnect**, damit das Skript im Hintergrund weiterläuft.

    ```
        if {[fork]!=0} exit
        disconnect
        . . .
    ```

    Das folgende Skript liest ein Passwort und lässt dann stündlich ein Programm laufen, das bei jedem Lauf ein Passwort verlangt. Das Skript liefert das Passwort, sodass es nur einmal einzugeben ist. Der Befehl **stty** zeigt, wie sich das Echo des Passworts abschalten lässt.

    ```
        send_user "password?\ "
        expect_user -re "(.*)\n"
        for {} 1 {} {
            if {[fork]!=0} {sleep 3600;continue}
            disconnect
            spawn priv_prog
            expect Password:
            send "$expect_out(1,string)\r"
            . . .
            exit
        }
    ```

    Ein Vorteil von **disconnect** gegenüber der asynchronen Prozessfunktion der Shell (&) ist, dass **Expect** die Terminalparameter vor dem Trennen speichern und sie später auf neue Ptys anwenden kann. Mit & kann **Expect** die Terminalparameter nicht lesen, denn das Terminal ist schon getrennt, wenn **Expect** die Steuerung erhält.

**exit** *\[-opts\] \[status\]*
: Lässt **Expect** sich beenden oder sich darauf vorbereiten.

    Die Markierung **-onexit** verwendet das nächste Argument als Exit-Handler. Ohne Argument kommt der aktuelle Exit-Handler zurück.

    Die Markierung **-noexit** lässt **Expect** das Beenden vorbereiten, ohne die Steuerung tatsächlich an das Betriebssystem zurückzugeben. Der benutzerdefinierte Exit-Handler läuft ebenso wie die eigenen internen Handler von Expect. Weitere Expect-Befehle sollten nicht ausgeführt werden. Das ist nützlich, wenn Expect zusammen mit anderen Tcl-Erweiterungen läuft. Der aktuelle Interpreter und, in der Tk-Umgebung, das Hauptfenster bleiben, damit andere Tcl-Erweiterungen aufräumen können. Wird **exit** von Expect erneut aufgerufen, wie auch immer das geschieht, laufen die Handler nicht noch einmal.

    Beim Beenden werden alle Verbindungen zu gestarteten Prozessen geschlossen. Gestartete Prozesse erkennen das Schließen als EOF. **exit** tut nichts weiter als die gewöhnliche Prozedur \_exit(2). Gestartete Prozesse, die nicht auf EOF prüfen, können deshalb weiterlaufen. Für die Frage, welche Signale ein gestarteter Prozess erhält, sind verschiedene Bedingungen maßgeblich. Diese Bedingungen hängen vom System ab und stehen gewöhnlich unter exit(3). Gestartete Prozesse, die weiterlaufen, werden von init geerbt.

    *status*, oder 0, wenn nichts angegeben ist, kommt als Exit-Status von **Expect** zurück. **exit** wird implizit ausgeführt, wenn das Ende des Skripts erreicht ist.

**exp\_continue** \[-continue\_timer\]
: Der Befehl **exp\_continue** lässt **expect** selbst weiter ausführen, statt wie gewöhnlich zurückzukehren. In der Vorgabe setzt **exp\_continue** den Timeout-Zeitgeber zurück. Die Markierung *-continue\_timer* verhindert, dass der Zeitgeber neu gestartet wird. Weitere Angaben stehen bei **expect**.

**exp\_internal** *\[-f file\] value*
: Lässt weitere Befehle Diagnoseangaben aus dem Inneren von **Expect** nach stderr senden, wenn *value* ungleich null ist. Diese Ausgabe ist aus, wenn *value* 0 ist. Die Diagnoseangaben umfassen jedes empfangene Zeichen und jeden Versuch, die aktuelle Ausgabe gegen die Muster zu prüfen.

    Ist die optionale *file* angegeben, wird die gesamte gewöhnliche Ausgabe und die Ausgabe zur Fehlersuche in diese Datei geschrieben, unabhängig vom Wert von *value*. Eine frühere Datei für die Diagnoseausgabe wird geschlossen.

    Die Markierung **-info** lässt exp\_internal eine Beschreibung der zuletzt angegebenen Argumente zurückgeben, die nicht info sind.

**exp\_open** *\[args\] \[-i spawn\_id\]*
: Gibt einen Tcl-Dateibezeichner zurück, der der ursprünglichen Spawn-Id entspricht. Der Dateibezeichner lässt sich dann verwenden, als hätte ihn der Tcl-Befehl **open** geöffnet. Die Spawn-Id sollte nicht mehr verwendet werden. **wait** sollte nicht ausgeführt werden.

    Die Markierung **-leaveopen** lässt die Spawn-Id für den Zugriff über Expect-Befehle offen. Für die Spawn-Id ist **wait** auszuführen.

**exp\_pid** *\[-i spawn\_id\]*
: Gibt die Prozesskennung zurück, die zum aktuell gestarteten Prozess gehört. Ist die Markierung **-i** verwendet, gehört die zurückgegebene pid zur angegebenen Spawn-Id.

**exp\_send**
: Ist ein Alias für **send**.

**exp\_send\_error**
: Ist ein Alias für **send\_error**.

**exp\_send\_log**
: Ist ein Alias für **send\_log**.

**exp\_send\_tty**
: Ist ein Alias für **send\_tty**.

**exp\_send\_user**
: Ist ein Alias für **send\_user**.

**exp\_version** *\[\[-exit\] version\]*
: Dient dazu, sicherzustellen, dass das Skript zur aktuellen Version von Expect passt.

    Ohne Argumente kommt die aktuelle Version von **Expect** zurück. Diese Version lässt sich dann im Skript festhalten. Ist bekannt, dass keine Eigenschaften neuerer Versionen verwendet werden, kann eine frühere Version angegeben werden.

    Versionen bestehen aus drei durch Punkte getrennten Zahlen. Die erste ist die Hauptnummer. Skripte, die für Versionen von **Expect** mit einer anderen Hauptnummer geschrieben sind, arbeiten mit ziemlicher Sicherheit nicht. **exp\_version** gibt einen Fehler zurück, wenn die Hauptnummern nicht übereinstimmen.

    Die zweite ist die Nebennummer. Skripte, die für eine Version mit einer größeren Nebennummer als der aktuellen Version geschrieben sind, können von einer neuen Eigenschaft abhängen und möglicherweise nicht laufen. **exp\_version** gibt einen Fehler zurück, wenn die Hauptnummern übereinstimmen, die Nebennummer des Skripts aber größer ist als die des laufenden **Expect**.

    Die dritte Zahl spielt beim Versionsvergleich keine Rolle. Diese Zahl wird aber erhöht, wenn die Software-Ausgabe von **Expect** irgendwie geändert wird, zum Beispiel durch zusätzliche Dokumentation oder eine Optimierung. Bei jeder neuen Nebenversion wird sie auf 0 gesetzt.

    Mit der Markierung **-exit** gibt **Expect** einen Fehler aus und beendet sich, wenn die Version veraltet ist.

**expect** *\[\[-opts\] pat1 body1\] ... \[-opts\] patn \[bodyn\]*
: Wartet, bis eines der Muster zur Ausgabe eines gestarteten Prozesses passt, eine angegebene Zeitspanne vergangen ist oder ein Dateiende gesehen wird. Ist der letzte Aktionsblock leer, darf er entfallen.

    Muster des letzten Befehls **expect\_before** werden implizit vor allen anderen Mustern verwendet. Muster des letzten Befehls **expect\_after** werden implizit nach allen anderen Mustern verwendet.

    Brauchen die Argumente der ganzen Anweisung **expect** mehr als eine Zeile, dürfen alle Argumente in eine geschweifte Klammer gefasst werden, damit nicht jede Zeile mit einem Rückwärtsschrägstrich enden muss. In diesem einen Fall finden die üblichen Tcl-Ersetzungen trotz der Klammern statt.

    Ist ein Muster das Schlüsselwort **eof**, wird der zugehörige Aktionsblock bei Dateiende ausgeführt. Ist ein Muster das Schlüsselwort **timeout**, wird der zugehörige Aktionsblock bei Zeitüberschreitung ausgeführt. Wird kein Schlüsselwort timeout verwendet, wird bei Zeitüberschreitung eine implizite leere Aktion ausgeführt. Die Vorgabe der Zeitspanne ist 10 Sekunden, sie lässt sich zum Beispiel mit dem Befehl "set timeout 30" auf 30 setzen. Eine unendliche Zeitspanne lässt sich mit dem Wert -1 bezeichnen. Ist ein Muster das Schlüsselwort **default**, wird der zugehörige Aktionsblock bei Zeitüberschreitung oder bei Dateiende ausgeführt.

    Passt ein Muster, wird der zugehörige Aktionsblock ausgeführt. **expect** gibt das Ergebnis des Aktionsblocks zurück, oder die leere Zeichenkette, wenn kein Muster gepasst hat. Passen mehrere Muster, wird das zuerst stehende verwendet, um einen Aktionsblock auszuwählen.

    Jedes Mal, wenn neue Ausgabe eintrifft, wird sie mit jedem Muster in der aufgeführten Reihenfolge verglichen. Das Fehlen einer Übereinstimmung lässt sich also prüfen, indem das letzte Muster etwas ist, das mit Sicherheit erscheint, zum Beispiel eine Eingabeaufforderung. Gibt es keine Eingabeaufforderung, ist **timeout** zu verwenden, so wie bei einer unmittelbaren Bedienung von Hand.

    Muster werden auf drei Arten angegeben. In der Vorgabe werden Muster wie beim Tcl-Befehl **string match** angegeben. Solche Muster ähneln auch den regulären Ausdrücken der C-Shell, die gewöhnlich "glob"-Muster heißen. Die Markierung **-gl** kann Muster schützen, die sonst auf Markierungen von **expect** passen würden. Jedes Muster, das mit "-" beginnt, sollte so geschützt werden. Alle Zeichenketten, die mit "-" beginnen, sind für künftige Optionen reserviert.

    Das folgende Fragment sucht zum Beispiel eine erfolgreiche Anmeldung. **abort** gilt als Prozedur, die an anderer Stelle im Skript definiert ist.

    ```
        expect {
            busy               {puts busy\n ; exp_continue}
            failed             abort
            "invalid password" abort
            timeout            abort
            connected
        }
    ```

    Beim vierten Muster sind Anführungszeichen nötig, weil es ein Leerzeichen enthält, das sonst das Muster von der Aktion trennen würde. Muster mit derselben Aktion, wie das dritte und das vierte, verlangen, dass die Aktionen erneut aufgeführt werden. Das lässt sich vermeiden, indem Muster im Regexp-Stil verwendet werden, siehe unten. Weitere Angaben zum Bilden von Mustern im Glob-Stil stehen im Tcl-Handbuch.

    Muster im Regexp-Stil folgen der Syntax, die der Tcl-Befehl **regexp** definiert, die Kurzform für "regular expression". Regexp-Muster werden mit der Markierung **-re** eingeleitet. Das vorige Beispiel lässt sich mit einem regulären Ausdruck so umschreiben:

    ```
        expect {
            busy       {puts busy\n ; exp_continue}
            -re "failed|invalid password" abort
            timeout    abort
            connected
        }
    ```

    Beide Arten von Mustern sind ohne Anker. Das heißt, Muster müssen nicht auf die ganze Zeichenkette passen, sondern können die Übereinstimmung irgendwo in der Zeichenkette beginnen und beenden, solange alles Übrige passt. ^ passt auf den Anfang einer Zeichenkette, $ auf das Ende. Wird nicht auf das Ende einer Zeichenkette gewartet, können die Antworten leicht mitten in der Zeichenkette landen, weil der gestartete Prozess sie zurücksendet. Das Ergebnis bleibt richtig, die Ausgabe kann aber unnatürlich aussehen. $ ist deshalb angebracht, wenn sich die Zeichen am Ende einer Zeichenkette genau beschreiben lassen.

    In vielen Editoren passen ^ und $ auf den Anfang beziehungsweise das Ende von Zeilen. Weil expect nicht zeilenorientiert ist, passen diese Zeichen auf den Anfang und das Ende der Daten, die gerade im Vergleichspuffer von expect stehen, nicht auf Zeilen. Dazu auch der Hinweis weiter unten zur „Systemüberlastung“.

    Die Markierung **-ex** lässt das Muster als "genaue" Zeichenkette passen. \*, ^ und Ähnliches werden nicht ausgewertet, die üblichen Tcl-Konventionen gelten trotzdem. Genaue Muster sind immer ohne Anker.

    Die Markierung **-nocase** lässt Großbuchstaben der Ausgabe so vergleichen, als wären sie Kleinbuchstaben. Das Muster bleibt unberührt.

    Beim Lesen der Ausgabe können mehr als 2000 Bytes frühere Bytes zum „Vergessen“ zwingen. Das lässt sich mit der Funktion **match\_max** ändern. Übermäßig große Werte können den Mustervergleich verlangsamen. Ist *patlist* **full\_buffer**, wird der zugehörige Aktionsblock ausgeführt, wenn *match\_max* Bytes empfangen wurden und kein anderes Muster gepasst hat. Ob das Schlüsselwort **full\_buffer** verwendet wird oder nicht, die vergessenen Zeichen werden nach expect\_out(buffer) geschrieben.

    Ist *patlist* das Schlüsselwort **null** und sind Nullen erlaubt, über den Befehl **remove\_nulls**, wird der zugehörige Aktionsblock ausgeführt, wenn ein einzelnes ASCII 0 passt. Über Glob- oder Regexp-Muster lassen sich 0 Bytes nicht treffen.

    Passt ein Muster, oder eof oder full\_buffer, wird jede passende und zuvor nicht passende Ausgabe in der Variable *expect\_out(buffer)* gespeichert. Bis zu 9 Übereinstimmungen von Regexp-Teilzeichenketten werden in den Variablen *expect\_out(1,string)* bis *expect\_out(9,string)* gespeichert. Wird vor einem Muster die Markierung **-indices** verwendet, werden Anfangs- und Endindex der 10 Zeichenketten, in einer für **lrange** geeigneten Form, in den Variablen *expect\_out(X,start)* und *expect\_out(X,end)* gespeichert. X ist eine Ziffer und entspricht der Position der Teilzeichenkette im Puffer. 0 meint Zeichenketten, die auf das ganze Muster gepasst haben, und wird für Glob-Muster ebenso erzeugt wie für Regexp-Muster. Hat ein Prozess zum Beispiel die Ausgabe "abcdefgh\\n" erzeugt, ist das Ergebnis von:

    ```
        expect "cd"
    ```

    so, als wären die folgenden Anweisungen ausgeführt worden:

    ```
        set expect_out(0,string) cd
        set expect_out(buffer) abcd
    ```

    und "efgh\\n" bleibt im Ausgabepuffer. Hat ein Prozess die Ausgabe "abbbcabkkkka\\n" erzeugt, ist das Ergebnis von:

    ```
        expect -indices -re "b(b*).*(k+)"
    ```

    so, als wären die folgenden Anweisungen ausgeführt worden:

    ```
        set expect_out(0,start) 1
        set expect_out(0,end) 10
        set expect_out(0,string) bbbcabkkkk
        set expect_out(1,start) 2
        set expect_out(1,end) 3
        set expect_out(1,string) bb
        set expect_out(2,start) 10
        set expect_out(2,end) 10
        set expect_out(2,string) k
        set expect_out(buffer) abbbcabkkkk
    ```

    und "a\\n" bleibt im Ausgabepuffer. Das Muster "\*" und -re ".\*" leeren den Ausgabepuffer, ohne weitere Ausgabe vom Prozess zu lesen.

    Gewöhnlich wird die passende Ausgabe aus den internen Puffern von Expect verworfen. Das lässt sich verhindern, indem einem Muster die Markierung **-notransfer** vorangestellt wird. Diese Markierung ist beim Ausprobieren besonders nützlich und lässt sich dabei der Kürze halber als "-not" schreiben.

    Die zur passenden Ausgabe gehörende Spawn-Id, oder eof oder full\_buffer, wird in *expect\_out(spawn\_id)* gespeichert.

    Die Markierung **-timeout** lässt den aktuellen Befehl expect den folgenden Wert als Zeitspanne verwenden, statt des Werts der Variable timeout.

    In der Vorgabe werden Muster gegen die Ausgabe des aktuellen Prozesses geprüft. Die Markierung **-i** bestimmt, dass die Ausgabe der genannten spawn\_id-Liste gegen alle folgenden Muster geprüft wird, bis zum nächsten **-i**. Die spawn\_id-Liste sollte entweder eine durch Leerraum getrennte Liste von spawn\_ids sein oder eine Variable, die auf eine solche Liste von spawn\_ids verweist.

    Das folgende Beispiel wartet auf "connected" vom aktuellen Prozess oder auf "busy", "failed" oder "invalid password" von der spawn\_id, die $proc2 nennt.

    ```
        expect {
            -i $proc2 busy {puts busy\n ; exp_continue}
            -re "failed|invalid password" abort
            timeout abort
            connected
        }
    ```

    Der Wert der globalen Variable *any\_spawn\_id* kann Muster auf alle spawn\_ids passen lassen, die mit allen anderen Markierungen **-i** im aktuellen Befehl **expect** genannt sind. Die spawn\_id einer Markierung **-i** ohne zugehöriges Muster, also unmittelbar gefolgt von einem weiteren **-i**, steht allen anderen Mustern im selben Befehl **expect** zur Verfügung, die zu *any\_spawn\_id.* gehören.

    Die Markierung **-i** kann auch eine globale Variable nennen. Dann wird die Variable als Liste von Spawn-Ids gelesen. Die Variable wird neu gelesen, sobald sie sich ändert. So lässt sich die Ein-/Ausgabe-Quelle ändern, während der Befehl läuft. Auf diese Weise angegebene Spawn-Ids heißen „indirekte“ Spawn-Ids.

    Aktionen wie **break** und **continue** lassen Steuerstrukturen, also **for** und **proc**, sich wie üblich verhalten. Der Befehl **exp\_continue** lässt **expect** selbst weiter ausführen, statt wie gewöhnlich zurückzukehren.

    Das vermeidet ausdrückliche Schleifen oder wiederholte expect-Anweisungen. Das folgende Beispiel ist Teil eines Fragments, das rlogin automatisiert. **exp\_continue** erspart eine zweite Anweisung **expect**, die erneut nach der Eingabeaufforderung sucht, wenn rlogin nach einem Passwort fragt.

    ```
        expect {
            Password: {
                stty -echo
                send_user "password (for $user) on $host: "
                expect_user -re "(.*)\n"
                send_user "\n"
                send "$expect_out(1,string)\r"
                stty echo
                exp_continue
            } incorrect {
                send_user "invalid password or account\n"
                exit
            } timeout {
                send_user "connection to $host timed out\n"
                exit
            } eof {
                send_user \
                    "connection to host failed: $expect_out(buffer)"
                exit
            } -re $prompt
        }
    ```

    Das folgende Fragment kann zum Beispiel helfen, eine schon vollständig automatisierte Wechselwirkung zu lenken. Das Terminal wird dabei in den Rohmodus gesetzt. Wird "+" gedrückt, wird eine Variable erhöht. Wird "p" gedrückt, gehen mehrere Wagenrückläufe an den Prozess, vielleicht um ihn anzustoßen, und "i" lässt den Benutzer unmittelbar mit dem Prozess arbeiten und entzieht dem Skript die Steuerung. In jedem Fall lässt **exp\_continue** das aktuelle **expect** nach der aktuellen Aktion weiter Muster vergleichen.

    ```
        stty raw -echo
        expect_after {
            -i $user_spawn_id
            "p" {send "\r\r\r"; exp_continue}
            "+" {incr foo; exp_continue}
            "i" {interact; exp_continue}
            "quit" exit
        }
    ```

    In der Vorgabe setzt **exp\_continue** den Timeout-Zeitgeber zurück. Der Zeitgeber wird nicht neu gestartet, wenn **exp\_continue** mit der Markierung **-continue\_timer** aufgerufen wird.

**expect\_after** *\[expect\_args\]*
: Arbeitet genauso wie **expect\_before**, außer dass das Muster von **expect** verwendet wird, wenn Muster von **expect** und von **expect\_after** passen können. Weitere Angaben stehen beim Befehl **expect\_before**.

**expect\_background** *\[expect\_args\]*
: Nimmt dieselben Argumente wie **expect**, kehrt aber sofort zurück. Muster werden geprüft, sobald neue Eingabe eintrifft. Die Muster **timeout** und **default** haben für **expect\_background** keine Bedeutung und werden still verworfen. Sonst verwendet der Befehl **expect\_background** Muster von **expect\_before** und **expect\_after** genau wie **expect**.

    Während Aktionen von **expect\_background** ausgewertet werden, ist die Hintergrundverarbeitung für dieselbe Spawn-Id gesperrt. Die Hintergrundverarbeitung wird freigegeben, wenn die Aktion endet. Solange die Hintergrundverarbeitung gesperrt ist, ist ein **expect** im Vordergrund auf derselben Spawn-Id möglich.

    Ein **expect** lässt sich nicht ausführen, solange ein **expect\_background** freigegeben ist. **expect\_background** für eine bestimmte Spawn-Id wird gelöscht, indem ein neues expect\_background mit derselben Spawn-Id erklärt wird. **expect\_background** ohne Muster nimmt der angegebenen Spawn-Id die Fähigkeit, Muster im Hintergrund zu prüfen.

**expect\_before** *\[expect\_args\]*
: Nimmt dieselben Argumente wie **expect**, kehrt aber sofort zurück. Paare aus Muster und Aktion des letzten **expect\_before** mit derselben Spawn-Id werden implizit jedem folgenden Befehl **expect** hinzugefügt. Passt ein Muster, wird es behandelt, als wäre es im Befehl **expect** selbst angegeben worden, und der zugehörige Aktionsblock wird im Zusammenhang des Befehls **expect** ausgeführt. Können Muster von **expect\_before** und von **expect** passen, wird das Muster von **expect\_before** verwendet.

    Ist kein Muster angegeben, wird die Spawn-Id auf keine Muster geprüft.

    Überschreibt eine Markierung **-i** das nicht, passen Muster von **expect\_before** gegen die Spawn-Id, die zum Zeitpunkt der Ausführung des Befehls **expect\_before** definiert war, nicht zum Zeitpunkt der Musterübereinstimmung.

    Die Markierung -info lässt **expect\_before** die aktuellen Angaben zurückgeben, welche Muster es prüfen wird. In der Vorgabe berichtet es über die aktuelle Spawn-Id. Eine optionale Spawn-Id-Angabe kann Auskunft über diese Spawn-Id verlangen. Zum Beispiel

    ```
        expect_before -info -i $proc
    ```

    Höchstens eine Spawn-Id-Angabe darf angegeben werden. Die Markierung -indirect unterdrückt direkte Spawn-Ids, die nur aus indirekten Angaben stammen.

    Statt einer Spawn-Id-Angabe lässt die Markierung "-all" die Markierung "-info" über alle Spawn-Ids berichten.

    Die Ausgabe der Markierung -info lässt sich erneut als Argument von expect\_before verwenden.

**expect\_tty** *\[expect\_args\]*
: Arbeitet wie **expect**, liest die Zeichen aber von /dev/tty, also die Tastenanschläge des Benutzers. In der Vorgabe wird im kanonischen Modus gelesen. Zeilen müssen deshalb mit einem Return enden, damit **expect** sie sieht. Das lässt sich mit **stty** ändern. Der Befehl **stty** steht weiter unten.

**expect\_user** *\[expect\_args\]*
: Arbeitet wie **expect**, liest die Zeichen aber von stdin, also die Tastenanschläge des Benutzers. In der Vorgabe wird im kanonischen Modus gelesen. Zeilen müssen deshalb mit einem Return enden, damit **expect** sie sieht. Das lässt sich mit **stty** ändern. Der Befehl **stty** steht weiter unten.

**fork**
: Legt einen neuen Prozess an. Der neue Prozess ist eine genaue Kopie des aktuellen **Expect**-Prozesses. Bei Erfolg gibt **fork** dem neuen Kindprozess 0 zurück und dem Elternprozess die Prozesskennung des Kindprozesses. Bei einem Fehlschlag, ausnahmslos wegen fehlender Betriebsmittel wie Auslagerungsspeicher oder Speicher, gibt **fork** dem Elternprozess -1 zurück, und es entsteht kein Kindprozess.

    Abgespaltene Prozesse beenden sich über den Befehl **exit**, genau wie der ursprüngliche Prozess. Abgespaltene Prozesse dürfen in die Protokolldateien schreiben. Wird die Fehlersuche oder das Protokollieren in den meisten Prozessen nicht ausgeschaltet, kann das Ergebnis verwirrend sein.

    Manche Pty-Umsetzungen geraten durch mehrere Leser und Schreiber durcheinander, auch wenn das nur einen Augenblick dauert. Am sichersten ist deshalb **fork**, bevor Prozesse gestartet werden.

**interact** *\[string1 body1\] ... \[stringn \[bodyn\]\]*
: Gibt dem Benutzer die Steuerung über den aktuellen Prozess. Tastenanschläge gehen an den aktuellen Prozess, und stdout und stderr des aktuellen Prozesses kommen zurück.

    Als Argumente dürfen Paare aus Zeichenkette und Aktionsblock angegeben werden. Dann wird der Aktionsblock ausgeführt, wenn die zugehörige Zeichenkette eingegeben wird. In der Vorgabe geht die Zeichenkette nicht an den aktuellen Prozess. Fehlt der letzte Aktionsblock, gilt der Befehl **interpreter**.

    Brauchen die Argumente der ganzen Anweisung **interact** mehr als eine Zeile, dürfen alle Argumente in eine geschweifte Klammer gefasst werden, damit nicht jede Zeile mit einem Rückwärtsschrägstrich enden muss. In diesem einen Fall finden die üblichen Tcl-Ersetzungen trotz der Klammern statt.

    Der folgende Befehl lässt zum Beispiel interact mit diesen Paaren aus Zeichenkette und Aktionsblock laufen. Wird ^Z gedrückt, wird **Expect** angehalten. Die Markierung **-reset** stellt die Terminalmodi wieder her. Wird ^A gedrückt, sieht der Benutzer "you typed a control-A", und der Prozess erhält ein ^A. Wird $ gedrückt, sieht der Benutzer das Datum. Wird ^C gedrückt, beendet sich **Expect**. Wird "foo" eingegeben, sieht der Benutzer "bar". Wird ~~ gedrückt, läuft der Interpreter von **Expect** interaktiv.

    ```
        set CTRLZ \032
        interact {
            -reset $CTRLZ {exec kill -STOP [pid]}
            \001   {send_user "you typed a control-A\n";
                    send "\001"
                   }
            $      {send_user "The date is [clock format [clock seconds]]."}
            \003   exit
            foo    {send_user "bar"}
            ~~
        }
    ```

    In Paaren aus Zeichenkette und Aktionsblock werden die Zeichenketten in der Reihenfolge geprüft, in der sie als Argumente stehen. Zeichenketten, die teilweise passen, gehen nicht an den aktuellen Prozess, weil der Rest noch kommen kann. Werden dann Zeichen eingegeben, die eine Übereinstimmung unmöglich machen, geht nur der Teil der Zeichenkette an den Prozess, der unmöglich eine andere Übereinstimmung beginnen kann. Zeichenketten, die Teilzeichenketten teilweiser Übereinstimmungen sind, können also später passen, wenn die ursprüngliche Zeichenkette, die passen sollte, am Ende fehlschlägt.

    In der Vorgabe ist der Zeichenkettenvergleich genau und ohne Platzhalter. Der Befehl **expect** verwendet in der Vorgabe dagegen Muster im Glob-Stil. Die Markierung **-ex** kann Muster schützen, die sonst auf Markierungen von **interact** passen würden. Jedes Muster, das mit "-" beginnt, sollte so geschützt werden. Alle Zeichenketten, die mit "-" beginnen, sind für künftige Optionen reserviert.

    Die Markierung **-re** erzwingt, dass die Zeichenkette als Muster im Regexp-Stil gelesen wird. Passende Teilzeichenketten werden dann in der Variable *interact\_out* gespeichert, so wie **expect** seine Ausgabe in der Variable **expect\_out** speichert. Die Markierung **-indices** wird ebenso unterstützt.

    Das Muster **eof** leitet eine Aktion ein, die bei Dateiende ausgeführt wird. Ein eigenes Muster **eof** darf auch auf die Markierung **-output** folgen. Dann passt es, wenn beim Schreiben der Ausgabe ein eof erkannt wird. Die Vorgabeaktion für **eof** ist "return", sodass **interact** bei jedem EOF einfach zurückkehrt.

    Das Muster **timeout** leitet eine Zeitspanne in Sekunden und eine Aktion ein, die ausgeführt wird, nachdem eine bestimmte Zeit lang keine Zeichen gelesen wurden. Das Muster **timeout** gilt für den zuletzt angegebenen Prozess. Eine Vorgabezeitspanne gibt es nicht. Die besondere Variable "timeout", die der Befehl **expect** verwendet, hat auf diese Zeitspanne keine Wirkung.

    Die folgende Anweisung kann zum Beispiel Benutzer abmelden, die eine Stunde lang nichts getippt haben, aber weiterhin häufig Systemmeldungen erhalten:

    ```
        interact -input $user_spawn_id timeout 3600 return -output \
            $spawn_id
    ```

    Ist das Muster das Schlüsselwort **null** und sind Nullen erlaubt, über den Befehl **remove\_nulls**, wird der zugehörige Aktionsblock ausgeführt, wenn ein einzelnes ASCII 0 passt. Über Glob- oder Regexp-Muster lassen sich 0 Bytes nicht treffen.

    Wird einem Muster die Markierung **-iwrite** vorangestellt, wird die Variable *interact\_out(spawn\_id)* auf die spawn\_id gesetzt, die auf das Muster oder auf eof gepasst hat.

    Aktionen wie **break** und **continue** lassen Steuerstrukturen, also **for** und **proc**, sich wie üblich verhalten. **return** lässt interact dagegen zu seinem Aufrufer zurückkehren, während **inter\_return** **interact** eine Rückkehr in seinem Aufrufer auslösen lässt. Hat zum Beispiel "proc foo" **interact** aufgerufen und dieses dann die Aktion **inter\_return** ausgeführt, würde **proc foo** zurückkehren. Ruft **interact** interaktiv **interpreter** auf, lässt eingetipptes **return** das interact weiterlaufen, während **inter\_return** das interact zu seinem Aufrufer zurückkehren lässt.

    Während **interact** gilt der Rohmodus, damit alle Zeichen an den aktuellen Prozess gehen können. Fängt der aktuelle Prozess Jobsteuerungs-Signale nicht ab, hält er an, wenn er ein Stoppsignal erhält, in der Vorgabe ^Z. Zum Weiterlaufen dient ein Continue-Signal, zum Beispiel "kill -CONT <pid>". Soll ein solcher Prozess wirklich ein SIGSTOP erhalten, durch ^Z, wird zuerst csh gestartet und dann das Programm. Soll **Expect** selbst ein SIGSTOP erhalten, wird zuerst interpreter aufgerufen, vielleicht über ein Fluchtzeichen, und dann ^Z gedrückt.

    Paare aus Zeichenkette und Aktionsblock können als Kurzform dienen, damit der Interpreter nicht betreten und Befehle nicht interaktiv ausgeführt werden müssen. Während der Aktionsblock eines solchen Paares ausgeführt wird, gilt der vorige Terminalmodus.

    Der Geschwindigkeit wegen laufen Aktionen in der Vorgabe im Rohmodus. Die Markierung **-reset** setzt das Terminal auf den Modus zurück, den es vor **interact** hatte, ausnahmslos den kanonischen Modus. Zeichen, die beim Umschalten des Modus eingegeben werden, können verloren gehen, eine unglückliche Eigenschaft des Terminaltreibers auf manchen Systemen. **-reset** ist nur dann begründet, wenn die Aktion den kanonischen Modus braucht.

    Die Markierung **-echo** sendet Zeichen, die auf das folgende Muster passen, an den Prozess zurück, der sie erzeugt hat, sobald jedes Zeichen gelesen wird. Das kann nützlich sein, wenn der Benutzer eine Rückmeldung zu teilweise getippten Mustern braucht.

    Wird ein Muster zurückgesendet, passt am Ende aber nicht, gehen die Zeichen an den gestarteten Prozess. Sendet der gestartete Prozess sie dann zurück, sieht der Benutzer die Zeichen zweimal. **-echo** passt vermutlich nur, wenn es unwahrscheinlich ist, dass das Muster nicht zu Ende getippt wird. Der folgende Ausschnitt stammt aus rftp, dem Skript für rekursives ftp. Der Benutzer wird aufgefordert, ~g, ~p oder ~l einzugeben, um das aktuelle Verzeichnis rekursiv zu holen, zu senden oder aufzulisten. Das liegt so weit von den gewöhnlichen ftp-Befehlen entfernt, dass nach ~ kaum etwas anderes getippt wird, außer aus Versehen. Dann wird das Ergebnis vermutlich übergangen.

    ```
        interact {
            -echo ~g {getcurdirectory 1}
            -echo ~l {getcurdirectory 0}
            -echo ~p {putcurdirectory}
        }
    ```

    Die Markierung **-nobuffer** sendet Zeichen, die auf das folgende Muster passen, an den Ausgabeprozess, während die Zeichen gelesen werden.

    Das ist nützlich, wenn ein Programm das Muster zurücksenden soll. Das Folgende kann zum Beispiel überwachen, wohin jemand wählt, ein Modem im Hayes-Stil. Jedes Mal, wenn "atd" gesehen wird, protokolliert das Skript den Rest der Zeile.

    ```
        proc lognumber {} {
            interact -nobuffer -re "(.*)\r" return
            puts $log "[clock format [clock seconds]]: dialed $interact_out(1,string)"
        }

        interact -nobuffer "atd" lognumber
    ```

    Während **interact** wird eine frühere Verwendung von **log\_user** übergangen. **interact** erzwingt insbesondere, dass seine Ausgabe protokolliert wird, also an die Standardausgabe geht, weil angenommen wird, dass der Benutzer nicht blind arbeiten will.

    Die Markierung **-o** wendet alle folgenden Paare aus Taste und Aktionsblock auf die Ausgabe des aktuellen Prozesses an. Das kann zum Beispiel nützlich sein bei Rechnern, die während einer Telnet-Sitzung unerwünschte Zeichen senden.

    In der Vorgabe erwartet **interact**, dass der Benutzer die Standardeingabe des **Expect**-Prozesses selbst schreibt und dessen Standardausgabe liest. Die Markierung **-u**, für "user", lässt **interact** den Benutzer als den Prozess suchen, den ihr Argument nennt. Das muss eine gestartete Id sein.

    So lassen sich zwei unabhängige Prozesse verbinden, ohne eine ausdrückliche Schleife zu benutzen. Zur Fehlersuche geht die Diagnose von Expect immer nach stderr, oder nach stdout bei bestimmten Angaben zum Protokoll und zur Fehlersuche. Aus demselben Grund liest der Befehl **interpreter** interaktiv von stdin.

    Das folgende Fragment legt zum Beispiel einen Login-Prozess an. Dann wählt es den Benutzer an, das ist nicht gezeigt, und verbindet die beiden schließlich. An die Stelle von login kann jeder Prozess treten. Eine Shell würde zum Beispiel die Arbeit erlauben, ohne ein Konto und ein Passwort anzugeben.

    ```
        spawn login
        set login $spawn_id
        spawn tip modem
        # dial back out to user
        # connect user to login
        interact -u $login
    ```

    Sollen mehrere Prozesse Ausgabe erhalten, wird jede Spawn-Id-Liste aufgeführt, der eine Markierung **-output** voransteht. Die Eingabe für eine Gruppe von Ausgabe-Spawn-Ids kann eine Spawn-Id-Liste bestimmen, der eine Markierung **-input** voransteht. **-input** und **-output** dürfen Listen in derselben Form annehmen wie die Markierung **-i** im Befehl **expect**, nur ist any\_spawn\_id in **interact** ohne Bedeutung. Alle folgenden Markierungen und Zeichenketten oder Muster gelten für diese Eingabe, bis eine weitere Markierung -input erscheint. Erscheint kein **-input**, bedeutet **-output** "-input $user\_spawn\_id -output". Ebenso bei Mustern, die kein **-input** haben. Ist ein **-input** angegeben, überschreibt es $user\_spawn\_id. Ist ein zweites **-input** angegeben, überschreibt es $spawn\_id. Weitere Markierungen **-input** dürfen angegeben werden.

    Die beiden mitgemeinten Eingabeprozesse haben in der Vorgabe ihre Ausgaben als $spawn\_id und $user\_spawn\_id angegeben, in umgekehrter Reihenfolge. Erscheint eine Markierung **-input** ohne Markierung **-output**, werden die Zeichen dieses Prozesses verworfen.

    Die Markierung **-i** führt einen Ersatz für die aktuelle spawn\_id ein, wenn keine anderen Markierungen **-input** oder **-output** verwendet werden. Eine Markierung -i bedeutet eine Markierung -o.

    Die Prozesse, mit denen gearbeitet wird, lassen sich über indirekte Spawn-Ids wechseln. Indirekte Spawn-Ids sind im Abschnitt zum Befehl expect beschrieben. Indirekte Spawn-Ids dürfen mit den Markierungen -i, -u, -input oder -output angegeben werden.

**interpreter  \[args\]**
: Fordert den Benutzer interaktiv zur Eingabe von Befehlen für **Expect** und Tcl auf. Das Ergebnis jedes Befehls wird ausgegeben.

    Aktionen wie **break** und **continue** lassen Steuerstrukturen, also **for** und **proc**, sich wie üblich verhalten. **return** lässt interpreter dagegen zu seinem Aufrufer zurückkehren, während **inter\_return** **interpreter** eine Rückkehr in seinem Aufrufer auslösen lässt. Hat zum Beispiel "proc foo" **interpreter** aufgerufen und dieses dann die Aktion **inter\_return** ausgeführt, würde **proc foo** zurückkehren. Jeder andere Befehl lässt **interpreter** weiter nach neuen Befehlen fragen.

    In der Vorgabe enthält die Eingabeaufforderung zwei ganze Zahlen. Die erste beschreibt die Tiefe des Auswertungsstapels, also wie oft Tcl\_Eval aufgerufen wurde. Die zweite ist der Tcl-Verlaufskennzeichner. Die Eingabeaufforderung lässt sich setzen, indem eine Prozedur "prompt1" definiert wird, deren Rückgabewert die nächste Eingabeaufforderung wird. Hat eine Anweisung offene Anführungszeichen, Klammern, geschweifte oder eckige Klammern, erscheint bei einem Zeilenumbruch eine zweite Eingabeaufforderung, in der Vorgabe "+> ". Die zweite Eingabeaufforderung lässt sich setzen, indem eine Prozedur "prompt2" definiert wird.

    Während **interpreter** gilt der kanonische Modus, auch wenn sein Aufrufer den Rohmodus verwendet hat.

    Ist stdin geschlossen, kehrt **interpreter** zurück, sofern nicht die Markierung **-eof** verwendet wird. Dann wird das folgende Argument aufgerufen.

**log\_file** *\[args\] \[\[-a\] file\]*
: Ist ein Dateiname angegeben, zeichnet **log\_file** ab diesem Punkt ein Protokoll der Sitzung in der Datei auf. Ohne Argument beendet **log\_file** das Protokoll. Eine frühere Protokolldatei wird geschlossen.

    Statt eines Dateinamens kann mit den Markierungen **-open** oder **-leaveopen** ein Tcl-Dateibezeichner angegeben werden. Das ähnelt dem Befehl **spawn**. Weitere Angaben stehen bei **spawn**.

    Die Markierung **-a** erzwingt, dass Ausgabe protokolliert wird, die der Befehl **log\_user** unterdrückt hat.

    In der Vorgabe *hängt* der Befehl **log\_file** an alte Dateien an, statt sie abzuschneiden, damit sich das Protokollieren in einer Sitzung mehrmals aus- und einschalten lässt. Zum Abschneiden dient die Markierung **-noappend**.

    Die Markierung **-info** lässt log\_file eine Beschreibung der zuletzt angegebenen Argumente zurückgeben, die nicht info sind.

**log\_user** *-info|0|1*
: In der Vorgabe wird der Dialog send/expect nach stdout protokolliert und in eine Protokolldatei, wenn eine offen ist. Der Befehl "log\_user 0" schaltet das Protokollieren nach stdout aus, "log\_user 1" schaltet es wieder ein. Das Protokollieren in die Protokolldatei bleibt unverändert.

    Die Markierung **-info** lässt log\_user eine Beschreibung der zuletzt angegebenen Argumente zurückgeben, die nicht info sind.

**match\_max** *\[-d\] \[-i spawn\_id\] \[size\]*
: Legt die Größe des Puffers in Bytes fest, den **expect** intern verwendet. Ohne Argument *size* kommt die aktuelle Größe zurück.

    Mit der Markierung **-d** wird die Vorgabegröße gesetzt. Die anfängliche Vorgabe ist 2000. Mit der Markierung **-i** wird die Größe für die genannte Spawn-Id gesetzt, sonst für den aktuellen Prozess.

**overlay** *\[-# spawn\_id\] \[-# spawn\_id\] \[...\] program \[args\]*
: Führt *program args* anstelle des aktuellen Programms **Expect** aus, das sich beendet. Ein bloßes Bindestrich-Argument erzwingt einen Bindestrich vor dem Befehlsnamen, als wäre es eine Login-Shell. Alle spawn\_ids werden geschlossen, außer den als Argumente genannten. Diese werden auf die genannten Dateibezeichner abgebildet.

    Spawn-Ids werden auf Dateibezeichner abgebildet, die das neue Programm erbt. Die folgende Zeile lässt zum Beispiel chess laufen und vom aktuellen Prozess steuern, etwa einem Schachmeister.

    ```
        overlay -0 $spawn_id -1 $spawn_id -2 $spawn_id chess
    ```

    Das ist effizienter als "interact -u", gibt aber die Möglichkeit auf, den Dialog weiter per Programm zu steuern, weil der Prozess **Expect** nicht mehr die Steuerung hat.

    Ein steuerndes Terminal wird nicht bereitgestellt. Wird die Verbindung getrennt oder die Standardeingabe umgelegt, arbeiten Programme mit Jobsteuerung, also Shells, login und Ähnliches, nicht richtig.

**parity** *\[-d\] \[-i spawn\_id\] \[value\]*
: Legt fest, ob die Parität in der Ausgabe gestarteter Prozesse erhalten oder entfernt wird. Ist *value* null, wird die Parität entfernt, sonst nicht. Ohne Argument *value* kommt der aktuelle Wert zurück.

    Mit der Markierung **-d** wird der Vorgabewert der Parität gesetzt. Die anfängliche Vorgabe ist 1, die Parität wird also nicht entfernt. Mit der Markierung **-i** wird der Paritätswert für die genannte Spawn-Id gesetzt, sonst für den aktuellen Prozess.

**remove\_nulls** *\[-d\] \[-i spawn\_id\] \[value\]*
: Legt fest, ob Nullen in der Ausgabe gestarteter Prozesse erhalten oder entfernt werden, bevor Muster geprüft oder in der Variable *expect\_out* oder *interact\_out* gespeichert werden. Ist *value* 1, werden Nullen entfernt. Ist *value* 0, werden Nullen nicht entfernt. Ohne Argument *value* kommt der aktuelle Wert zurück.

    Mit der Markierung **-d** wird der Vorgabewert gesetzt. Die anfängliche Vorgabe ist 1, Nullen werden also entfernt. Mit der Markierung **-i** wird der Wert für die genannte Spawn-Id gesetzt, sonst für den aktuellen Prozess.

    Ob Nullen entfernt werden oder nicht, zeichnet **Expect** Nullbytes im Protokoll und auf stdout auf.

**send** *\[-flags\] string*
: Sendet *string* an den aktuellen Prozess. Zum Beispiel der Befehl

    ```
        send "hello world\r"
    ```

    sendet die Zeichen h e l l o <blank> w o r l d <return> an den aktuellen Prozess. Tcl enthält einen printf-ähnlichen Befehl, **format**, der beliebig verwickelte Zeichenketten bauen kann.

    Die Zeichen werden sofort gesendet, obwohl Programme mit zeilenweise gepufferter Eingabe die Zeichen erst lesen, wenn ein Return-Zeichen gesendet wird. Ein Return-Zeichen wird als "\\r" geschrieben.

    Die Markierung **--** erzwingt, dass das nächste Argument als Zeichenkette gelesen wird und nicht als Markierung. Jeder Zeichenkette darf "--" voranstehen, ob sie wie eine Markierung aussieht oder nicht. Das ist ein verlässlicher Weg, veränderliche Zeichenketten anzugeben, ohne an solchen zu scheitern, die zufällig wie Markierungen aussehen. Alle Zeichenketten, die mit "-" beginnen, sind für künftige Optionen reserviert.

    Die Markierung **-i** legt fest, dass die Zeichenkette an die genannte spawn\_id gesendet wird. Ist die spawn\_id *user\_spawn\_id* und steht das Terminal im Rohmodus, werden Zeilenumbrüche in der Zeichenkette in Folgen aus Return und Zeilenumbruch übersetzt, sodass sie aussehen, als stünde das Terminal im kanonischen Modus. Die Markierung **-raw** schaltet diese Übersetzung aus.

    Die Markierung **-null** sendet Nullzeichen, 0 Bytes. In der Vorgabe wird eine Null gesendet. Auf **-null** darf eine ganze Zahl folgen, die angibt, wie viele Nullen gesendet werden.

    Die Markierung **-break** erzeugt eine Break-Bedingung. Das ist nur sinnvoll, wenn die Spawn-Id ein tty-Gerät meint, das über "spawn -open" geöffnet wurde. Wurde ein Prozess wie tip gestartet, gilt zum Erzeugen eines Breaks die Konvention von tip.

    Die Markierung **-s** erzwingt, dass die Ausgabe "langsam" gesendet wird, und vermeidet so den häufigen Fall, dass ein Rechner einen Eingabepuffer schneller füllt, als ein Mensch denselben Puffer tippen würde. Diese Ausgabe steuert der Wert der Variable "send\_slow", die eine Liste aus zwei Elementen annimmt. Das erste Element ist eine ganze Zahl, die angibt, wie viele Bytes unteilbar gesendet werden. Das zweite Element ist eine reelle Zahl, die angibt, wie viele Sekunden die unteilbaren Sendungen trennen müssen. "set send\_slow {10 .001}" würde zum Beispiel "send -s" zwingen, Zeichenketten mit 1 Millisekunde Abstand zwischen jeweils 10 gesendeten Zeichen zu senden.

    Die Markierung **-h** erzwingt, dass die Ausgabe einigermaßen so gesendet wird, wie ein Mensch wirklich tippt. Zwischen den Zeichen erscheinen menschenähnliche Verzögerungen. Der Algorithmus beruht auf einer Weibull-Verteilung, mit Änderungen für diese Anwendung. Diese Ausgabe steuert der Wert der Variable "send\_human", die eine Liste aus fünf Elementen annimmt. Die ersten beiden Elemente sind die mittlere Zwischenankunftszeit der Zeichen in Sekunden. Das erste gilt in der Vorgabe. Das zweite gilt an Wortenden, um die feinen Pausen nachzubilden, die an solchen Übergängen gelegentlich auftreten. Der dritte Parameter misst die Streuung: 0,1 ist sehr veränderlich, 1 ist einigermaßen veränderlich, und 10 ist sehr gleichmäßig. Die Extreme sind 0 bis unendlich. Die letzten beiden Parameter sind eine kleinste und eine größte Zwischenankunftszeit. Minimum und Maximum werden zuletzt angewendet und schneiden die endgültige Zeit ab. Der endgültige Mittelwert kann sich deutlich vom angegebenen Mittelwert unterscheiden, wenn Minimum und Maximum genug Werte abschneiden.

    Der folgende Befehl bildet zum Beispiel einen schnellen und gleichmäßigen Tipper nach:

    ```
        set send_human {.1 .3 1 .05 2}
        send -h "I'm hungry.  Let's do lunch."
    ```

    Das Folgende passt eher nach einem Kater:

    ```
        set send_human {.4 .4 .2 .5 100}
        send -h "Goodd party lash night!"
    ```

    Fehler werden nicht nachgebildet. Situationen zur Fehlerkorrektur lassen sich selbst anlegen, indem Tippfehler und Korrekturen in ein send-Argument eingebettet werden.

    Die Markierungen zum Senden von Nullzeichen, zum Senden von Breaks, zum Erzwingen langsamer Ausgabe und zur Ausgabe im menschlichen Stil schließen einander aus. Nur die zuletzt angegebene wird verwendet. Außerdem darf bei den Markierungen zum Senden von Nullzeichen oder Breaks kein Argument *string* angegeben werden.

    Dem ersten **send** an einen Prozess sollte ein **expect** vorangehen. **expect** wartet, bis der Prozess startet, **send** kann das nicht. Endet das erste **send** insbesondere, bevor der Prozess läuft, können die Daten übergangen werden. Bieten interaktive Programme keine anfängliche Eingabeaufforderung, kann **send** eine Verzögerung vorangehen, wie hier:

    ```
        # To avoid giving hackers hints on how to break in,
        # this system does not prompt for an external password.
        # Wait for 5 seconds for exec to complete
        spawn telnet very.secure.gov
        sleep 5
        send password\r
    ```

    **exp\_send** ist ein Alias für **send**_._ Läuft Expectk oder eine andere Variante von Expect in der Tk-Umgebung, definiert Tk **send** für einen ganz anderen Zweck. **exp\_send** sorgt für die Verträglichkeit zwischen den Umgebungen. Ähnliche Aliase gibt es für die anderen send-Befehle von Expect.

**send\_error** *\[-flags\] string*
: Arbeitet wie **send**, nur geht die Ausgabe nach stderr und nicht an den aktuellen Prozess.

**send\_log** *\[--\] string*
: Arbeitet wie **send**, nur geht die Zeichenkette allein in die Protokolldatei. Siehe dazu **log\_file**. Ist keine Protokolldatei offen, werden die Argumente übergangen.

**send\_tty** *\[-flags\] string*
: Arbeitet wie **send**, nur geht die Ausgabe nach /dev/tty und nicht an den aktuellen Prozess.

**send\_user** *\[-flags\] string*
: Arbeitet wie **send**, nur geht die Ausgabe nach stdout und nicht an den aktuellen Prozess.

**sleep** *seconds*
: Lässt das Skript die angegebene Zahl von Sekunden schlafen. Sekunden dürfen eine Dezimalzahl sein. Während Expect schläft, werden Unterbrechungen verarbeitet, und Tk-Ereignisse, wenn Expectk läuft.

**spawn** *\[args\] program \[args\]*
: Legt einen neuen Prozess an, der *program args* ausführt. Seine Standardeingabe, Standardausgabe und Standardfehlerausgabe sind mit Expect verbunden, sodass andere Befehle von **Expect** sie lesen und schreiben können. Die Verbindung bricht durch **close** oder wenn der Prozess selbst einen der Dateibezeichner schließt.

    Startet **spawn** einen Prozess, wird die Variable *spawn\_id* auf einen Deskriptor gesetzt, der diesen Prozess meint. Der Prozess, den *spawn\_id* beschreibt, gilt als *aktueller Prozess*. *spawn\_id* darf gelesen oder geschrieben werden und bietet so eine Jobsteuerung.

    *user\_spawn\_id* ist eine globale Variable mit einem Deskriptor, der den Benutzer meint. Wird *spawn\_id* zum Beispiel auf diesen Wert gesetzt, verhält sich **expect** wie **expect\_user**.

    *error\_spawn\_id* ist eine globale Variable mit einem Deskriptor, der die Standardfehlerausgabe meint. Wird *spawn\_id* zum Beispiel auf diesen Wert gesetzt, verhält sich **send** wie **send\_error**.

    *tty\_spawn\_id* ist eine globale Variable mit einem Deskriptor, der /dev/tty meint. Gibt es /dev/tty nicht, etwa in einem cron-, at- oder batch-Skript, ist *tty\_spawn\_id* nicht definiert. Das lässt sich so prüfen:

    ```
        if {[info vars tty_spawn_id]} {
            # /dev/tty exists
        } else {
            # /dev/tty doesn't exist
            # probably in cron, batch, or at script
        }
    ```

    **spawn** gibt die UNIX-Prozesskennung zurück. Wird kein Prozess gestartet, kommt 0 zurück. Die Variable *spawn\_out(slave,name)* wird auf den Namen des Pty-Slave-Geräts gesetzt.

    In der Vorgabe gibt **spawn** den Befehlsnamen und die Argumente aus. Die Markierung **-noecho** hält **spawn** davon ab.

    Die Markierung **-console** leitet die Konsolenausgabe an den gestarteten Prozess um. Das wird nicht auf allen Systemen unterstützt.

    Intern verwendet **spawn** eine Pty, die wie das tty des Benutzers eingerichtet wird. Diese Pty wird weiter so eingerichtet, dass alle Einstellungen "sane" sind, laut stty(1). Ist die Variable *stty\_init* definiert, wird sie im Stil von stty-Argumenten als weitere Einrichtung gelesen. "set stty\_init raw" lässt zum Beispiel die Terminals später gestarteter Prozesse im Rohmodus beginnen. **-nottycopy** überspringt die Einrichtung nach dem tty des Benutzers. **-nottyinit** überspringt die Einrichtung "sane".

    Gewöhnlich braucht **spawn** wenig Zeit. Dauert spawn auffällig lange, trifft es vermutlich auf festgefahrene Ptys. Auf Ptys laufen mehrere Prüfungen, damit es keine Verwicklung mit fehlgeleiteten Prozessen gibt. Das dauert 10 Sekunden je festgefahrener Pty. Läuft Expect mit der Option **-d**, zeigt sich, ob **Expect** viele Ptys in merkwürdigen Zuständen trifft. Lassen sich die Prozesse nicht beenden, an denen diese Ptys hängen, bleibt als einziger Ausweg ein Neustart.

    Kann *program* nicht erfolgreich gestartet werden, weil exec(2) fehlschlägt, etwa weil *program* nicht existiert, gibt der nächste Befehl **interact** oder **expect** eine Fehlermeldung zurück, als wäre *program* gelaufen und hätte die Fehlermeldung als Ausgabe erzeugt. Dieses Verhalten folgt aus der Umsetzung von **spawn**. Intern spaltet spawn ab. Danach kann der gestartete Prozess mit dem ursprünglichen Prozess **Expect** nur noch über die spawn\_id kommunizieren.

    Die Markierung **-open** lässt das nächste Argument als Tcl-Dateibezeichner lesen, also als Rückgabe von **open**. Die Spawn-Id lässt sich dann verwenden, als wäre sie ein gestarteter Prozess. Der Dateibezeichner sollte nicht mehr verwendet werden. So lassen sich Rohgeräte, Dateien und Pipelines als gestartete Prozesse behandeln, ohne eine Pty. 0 kommt zurück und zeigt, dass kein Prozess zugehört. Wird die Verbindung zum gestarteten Prozess geschlossen, wird auch der Tcl-Dateibezeichner geschlossen. Die Markierung **-leaveopen** ähnelt **-open**, nur lässt **-leaveopen** den Dateibezeichner offen, auch nachdem die Spawn-Id geschlossen ist.

    Die Markierung **-pty** öffnet eine Pty, startet aber keinen Prozess. 0 kommt zurück und zeigt, dass kein Prozess zugehört. Die Spawn-Id wird wie üblich gesetzt.

    Die Variable *spawn\_out(slave,fd)* wird auf einen Dateibezeichner gesetzt, der dem Pty-Slave entspricht. Er lässt sich mit "close -slave" schließen.

    Die Markierung **-ignore** nennt ein Signal, das im gestarteten Prozess übergangen wird. Sonst erhalten Signale das Vorgabeverhalten. Signale werden wie im Befehl **trap** benannt, nur braucht jedes Signal eine eigene Markierung.

**strace** *level*
: Lässt die folgenden Anweisungen ausgeben, bevor sie ausgeführt werden. Der trace-Befehl von Tcl verfolgt Variablen. *level* gibt an, wie weit im Aufrufstapel verfolgt wird. Der folgende Befehl lässt zum Beispiel **Expect** laufen und verfolgt die ersten 4 Aufrufebenen, aber keine darunter.

    ```
        expect -c "strace 4" script.exp
    ```

    Die Markierung **-info** lässt strace eine Beschreibung der zuletzt angegebenen Argumente zurückgeben, die nicht info sind.

**stty** *args*
: Ändert die Terminalmodi ähnlich wie der externe Befehl stty.

    In der Vorgabe wird das steuernde Terminal angesprochen. Andere Terminals lassen sich ansprechen, indem "< /dev/tty..." an den Befehl angehängt wird. Die Argumente sollten nicht zu einem einzigen Argument zusammengefasst werden.

    Statusanfragen geben den Status als Ergebnis des Befehls zurück. Wird kein Status angefragt und das steuernde Terminal angesprochen, kommt der vorige Status der Attribute raw und echo in einer Form zurück, die der Befehl später verwenden kann.

    Die Argumente **raw** oder **-cooked** setzen das Terminal zum Beispiel in den Rohmodus. Die Argumente **-raw** oder **cooked** setzen das Terminal in den kanonischen Modus. Die Argumente **echo** und **-echo** setzen das Terminal in den Echo- beziehungsweise den Noecho-Modus.

    Das folgende Beispiel zeigt, wie das Echo vorübergehend ausgeschaltet wird. Das kann in sonst automatischen Skripten verhindern, dass Passwörter darin stehen. Weitere Erörterung dazu steht unter den Expect-Hinweisen weiter unten.

    ```
        stty -echo
        send_user "Password: "
        expect_user -re "(.*)\n"
        set password $expect_out(1,string)
        stty echo
    ```

**system** *args*
: Gibt *args* an sh(1) als Eingabe, als wäre es als Befehl von einem Terminal getippt worden. **Expect** wartet, bis die Shell endet. Der Rückgabestatus von sh wird so behandelt, wie **exec** seinen Rückgabestatus behandelt.

    **exec** leitet stdin und stdout an das Skript um. **system** nimmt keine Umleitung vor, außer der, die die Zeichenkette selbst angibt. So lassen sich Programme verwenden, die unmittelbar mit /dev/tty sprechen müssen. Aus demselben Grund werden die Ergebnisse von **system** nicht im Protokoll aufgezeichnet.

**timestamp** *\[args\]*
: Gibt einen Zeitstempel zurück. Ohne Argumente kommt die Zahl der Sekunden seit der Epoche zurück.

    Die Markierung **-format** leitet eine Zeichenkette ein, die zurückgegeben wird, aber mit Ersetzungen nach den POSIX-Regeln für strftime. %a wird zum Beispiel durch einen abgekürzten Wochentagsnamen ersetzt, also Sat. Weitere sind:

    ```
        %a      abbreviated weekday name
        %A      full weekday name
        %b      abbreviated month name
        %B      full month name
        %c      date-time as in: Wed Oct  6 11:45:56 1993
        %d      day of the month (01-31)
        %H      hour (00-23)
        %I      hour (01-12)
        %j      day (001-366)
        %m      month (01-12)
        %M      minute (00-59)
        %p      am or pm
        %S      second (00-61)
        %u      day (1-7, Monday is first day of week)
        %U      week (00-53, first Sunday is first day of week one)
        %V      week (01-53, ISO 8601 style)
        %w      day (0-6)
        %W      week (00-53, first Monday is first day of week one)
        %x      date-time as in: Wed Oct  6 1993
        %X      time as in: 23:59:59
        %y      year (00-99)
        %Y      year as in: 1993
        %Z      timezone (or nothing if not determinable)
        %%      a bare percent sign
    ```

    Andere %-Angaben sind undefiniert. Andere Zeichen gehen unverändert durch. Nur die Locale C wird unterstützt.

    Die Markierung **-seconds** leitet eine Zahl von Sekunden seit der Epoche ein, die als Quelle für die Formatierung dient. Sonst gilt die aktuelle Zeit.

    Die Markierung **-gmt** erzwingt, dass die Ausgabe von timestamp die Zeitzone GMT verwendet. Ohne Markierung gilt die lokale Zeitzone.

**trap** *\[\[command\] signals\]*
: Lässt den angegebenen *command* bei künftigem Empfang eines der angegebenen Signale ausführen. Der Befehl wird im globalen Geltungsbereich ausgeführt. Fehlt *command*, kommt die Signalaktion zurück. Ist *command* die Zeichenkette SIG\_IGN, werden die Signale übergangen. Ist *command* die Zeichenkette SIG\_DFL, werden die Signale auf die Systemvorgabe zurückgesetzt. *signals* ist entweder ein einzelnes Signal oder eine Liste von Signalen. Signale dürfen numerisch oder symbolisch angegeben werden, wie in signal(3). Die Vorsilbe "SIG" darf entfallen.

    Ohne Argumente, oder mit dem Argument -number, gibt **trap** die Signalnummer des trap-Befehls zurück, der gerade ausgeführt wird.

    Die Markierung **-code** verwendet den Rückgabecode des Befehls anstelle des Codes, den Tcl zurückgeben wollte, als der Befehl ursprünglich zu laufen begann.

    Die Markierung **-interp** lässt den Befehl mit dem Interpreter auswerten, der aktiv war, als der Befehl zu laufen begann, und nicht mit dem, der galt, als der Trap vereinbart wurde.

    Die Markierung **-name** lässt den Befehl **trap** den Signalnamen des trap-Befehls zurückgeben, der gerade ausgeführt wird.

    Die Markierung **-max** lässt den Befehl **trap** die größte Signalnummer zurückgeben, die gesetzt werden kann.

    Der Befehl "trap {send\_user "Ouch!"} SIGINT" gibt zum Beispiel jedes Mal "Ouch!" aus, wenn der Benutzer ^C drückt.

    In der Vorgabe lassen SIGINT, gewöhnlich durch ^C erzeugt, und SIGTERM Expect enden. Das liegt an folgendem Trap, der in der Vorgabe angelegt wird, wenn Expect startet.

    ```
        trap exit {SIGINT SIGTERM}
    ```

    Wird der Debugger mit der Markierung -D gestartet, wird SIGINT umdefiniert, sodass es den interaktiven Debugger startet. Das liegt an folgendem Trap:

    ```
        trap {exp_debug 1} SIGINT
    ```

    Der Debugger-Trap lässt sich ändern, indem die Umgebungsvariable EXPECT\_DEBUG\_INIT auf einen neuen trap-Befehl gesetzt wird.

    Beide lassen sich überschreiben, indem trap-Befehle in das Skript kommen. Ein eigenes "trap exit SIGINT" überschreibt insbesondere den Debugger-Trap. Das ist nützlich, wenn Benutzer den Debugger gar nicht erreichen sollen.

    Soll für SIGINT ein eigener Trap gelten, bei laufendem Debugger aber weiter der Debugger angesprungen werden, dient:

    ```
        if {![exp_debug]} {trap mystuff SIGINT}
    ```

    Stattdessen lässt sich der Debugger über ein anderes Signal anspringen.

    **trap** lässt die Aktion für SIGALRM nicht überschreiben, weil **Expect** das Signal intern verwendet. Der Befehl disconnect setzt SIGALRM auf SIG\_IGN (ignore). Das lässt sich wieder einschalten, solange es bei den folgenden spawn-Befehlen ausgeschaltet wird.

    Weitere Angaben stehen in signal(3).

**wait** *\[args\]*
: Wartet, bis ein gestarteter Prozess endet, oder der aktuelle Prozess, wenn keiner genannt ist.

    **wait** gibt gewöhnlich eine Liste aus vier ganzen Zahlen zurück. Die erste ist die pid des Prozesses, auf den gewartet wurde. Die zweite ist die zugehörige Spawn-Id. Die dritte ist -1, wenn ein Fehler des Betriebssystems auftrat, sonst 0. War die dritte Zahl 0, ist die vierte der Status, den der gestartete Prozess zurückgegeben hat. War die dritte Zahl -1, ist die vierte der Wert von errno, den das Betriebssystem gesetzt hat. Die globale Variable errorCode wird ebenfalls gesetzt.

    Am Ende des Rückgabewerts von **wait** können weitere Elemente stehen. Ein optionales fünftes Element nennt eine Klasse von Angaben. Derzeit ist der einzige mögliche Wert dieses Elements CHILDKILLED. Dann sind die nächsten beiden Werte der Signalname im C-Stil und eine kurze Textbeschreibung.

    Die Markierung **-i** nennt den Prozess, auf den gewartet wird, über die genannte spawn\_id, nicht über die Prozesskennung. In einem SIGCHLD-Handler lässt sich mit der Spawn-Id -1 auf jeden gestarteten Prozess warten.

    Die Markierung **-nowait** lässt wait sofort zurückkehren und ein erfolgreiches Warten melden. Endet der Prozess später, verschwindet er von selbst, ohne ein ausdrückliches wait.

    Der Befehl **wait** kann mit den Argumenten "-i -1" auch auf einen abgespaltenen Prozess warten. Anders als bei gestarteten Prozessen darf dieser Befehl jederzeit ausgeführt werden. Welcher Prozess eingesammelt wird, lässt sich nicht steuern. Der Rückgabewert kann aber auf die Prozesskennung geprüft werden.


# Bibliotheken

Expect kennt von selbst zwei eingebaute Bibliotheken für Expect-Skripte. Die Bibliotheken sind durch die Verzeichnisse bestimmt, die in den Variablen exp\_library und exp\_exec\_library genannt sind. Beide sollen Hilfsdateien enthalten, die andere Skripte verwenden können.

exp\_library enthält architekturunabhängige Dateien. exp\_exec\_library enthält architekturabhängige Dateien. Je nach System können beide Verzeichnisse völlig leer sein. Ob die Datei $exp\_exec\_library/cat-buffers existiert, beschreibt, ob /bin/cat in der Vorgabe puffert.

# Formatierte Ausgabe

Für die formatierte Ausgabe von **Expect**-Skripten gibt es eine vgrind-Definition. Ist die vgrind-Definition aus der **Expect**-Distribution richtig installiert, lässt sie sich so verwenden:

```
    vgrind -lexpect file
```

# Beispiele

Es ist nicht ohne Weiteres zu sehen, wie alles zusammengehört, was die Handbuchseite beschreibt. Die Beispiele im Beispielverzeichnis der **Expect**-Distribution sollten gelesen und ausprobiert werden. Manche sind echte Programme. Andere veranschaulichen nur bestimmte Techniken, und ein paar sind nur schnelle Behelfslösungen. Die Datei INSTALL gibt einen kurzen Überblick über diese Programme.

Die Aufsätze zu **Expect** (siehe SEE ALSO) sind ebenfalls nützlich. Manche Aufsätze verwenden die Syntax früherer Expect-Versionen. Die zugehörigen Begründungen gelten weiter und gehen viel mehr ins Einzelne als diese Handbuchseite.

# Einschränkungen

Erweiterungen können mit den Befehlsnamen von Expect zusammenstoßen. **send** ist zum Beispiel von Tk für einen ganz anderen Zweck definiert. Deshalb stehen die meisten Befehle von **Expect** auch als "exp\_XXXX" zur Verfügung. Befehle und Variablen, die mit "exp", "inter", "spawn" und "timeout" beginnen, haben keine Aliase. Die erweiterten Befehlsnamen dienen der Verträglichkeit zwischen den Umgebungen.

**Expect** fasst Geltungsbereiche recht großzügig. Variablen, die Befehle des Programms **Expect** lesen, werden insbesondere zuerst im lokalen Geltungsbereich gesucht und, wenn sie dort fehlen, im globalen. Damit entfällt "global timeout" in jeder Prozedur, die **expect** verwendet. Geschriebene Variablen liegen dagegen immer im lokalen Geltungsbereich, sofern kein Befehl "global" abgesetzt wurde. Das häufigste Problem entsteht, wenn spawn in einer Prozedur ausgeführt wird. Außerhalb der Prozedur gibt es *spawn\_id* nicht mehr, und der gestartete Prozess ist allein wegen des Geltungsbereichs nicht mehr erreichbar. In eine solche Prozedur kommt "global spawn\_id".

Lässt sich die Fähigkeit nicht einschalten, mehrere Prozesse zu starten, weil das System weder select (BSD \*.\*), poll (SVR>2) noch etwas Gleichwertiges unterstützt, kann **Expect** nur einen Prozess zur Zeit steuern. In diesem Fall darf *spawn\_id* nicht gesetzt werden, und über exec dürfen keine Prozesse ausgeführt werden, solange ein gestarteter Prozess läuft. Außerdem lässt sich nicht gleichzeitig von mehreren Prozessen **expect** ausführen, den Benutzer als einen davon eingeschlossen.

Terminalparameter können Skripte stark beeinflussen. Ist ein Skript zum Beispiel auf Echo geschrieben, verhält es sich falsch, wenn das Echo ausgeschaltet ist. Deshalb erzwingt Expect in der Vorgabe Terminalparameter im Zustand sane. Das kann andere Programme stören. Die emacs-Shell will zum Beispiel die „üblichen“ Zuordnungen ändern: Zeilenumbrüche werden auf Zeilenumbrüche abgebildet statt auf Zeilenumbrüche mit Wagenrücklauf, und das Echo ist ausgeschaltet. So lässt sich die Eingabezeile mit emacs bearbeiten. Expect kann das unmöglich erraten.

Expect kann angewiesen werden, seine Vorgabe für die Terminalparameter nicht zu überschreiben. Dann ist beim Schreiben von Skripten für solche Umgebungen große Vorsicht nötig. Im Fall von emacs wird nicht auf Echo und Zuordnungen am Zeilenende gebaut.

Die Befehle, die Argumente in einer einzigen Liste mit geschweiften Klammern annehmen, die Varianten von **expect** und **interact**, verwenden eine Heuristik, um zu entscheiden, ob die Liste tatsächlich ein Argument oder viele ist. Die Heuristik kann nur fehlschlagen, wenn die Liste wirklich ein einziges Argument darstellt, das mehrere eingebettete \\n mit Zeichen dazwischen enthält, die kein Leerraum sind. Das erscheint hinreichend unwahrscheinlich. Das Argument "-nobrace" kann trotzdem erzwingen, dass ein einziges Argument als ein einziges Argument behandelt wird. Das kann bei maschinell erzeugtem Expect-Code nützlich sein. Ebenso erzwingt -brace, dass ein einziges Argument als mehrere Muster und Aktionen behandelt wird.

# Bugs

Es war sehr verlockend, das Programm "sex" zu nennen, für "Smart EXec" oder "Send-EXpect". Die Vernunft, oder vielleicht nur der Puritanismus, hat sich durchgesetzt.

Auf manchen Systemen beklagt sich eine gestartete Shell, das tty nicht erreichen zu können, läuft aber trotzdem. Das System hat dann einen Mechanismus, das steuernde tty zu erlangen, den **Expect** nicht kennt. Ist er bekannt, soll die Angabe an den Autor zurückgehen.

Ultrix 4.1, zumindest die letzten Versionen hier, behandelt Zeitspannen über 1000000 als gleichwertig mit 0.

Digital UNIX 4.0A, und vermutlich andere Versionen, verweigert die Zuteilung von Ptys, wenn ein SIGCHLD-Handler definiert wird. Weitere Angaben stehen auf der Seite grantpt.

IRIX 6.0 behandelt Pty-Rechte falsch. Versucht Expect, eine Pty zuzuteilen, die vorher jemand anders benutzt hat, schlägt das fehl. Abhilfe schafft ein Wechsel auf IRIX 6.1.

Telnet, nur unter SunOS 4.1.2 geprüft, hängt, wenn TERM nicht gesetzt ist. Das ist ein Problem unter cron, at und in cgi-Skripten, die TERM nicht definieren. Es muss also ausdrücklich gesetzt werden. Welcher Typ, ist meist unerheblich. Es muss nur irgendein Wert sein. Das Folgende genügt vermutlich in den meisten Fällen.

```
    set env(TERM) vt100
```

Tip, nur unter BSDI BSD/OS 3.1 i386 geprüft, hängt, wenn SHELL und HOME nicht gesetzt sind. Das ist ein Problem unter cron, at und in cgi-Skripten, die diese Umgebungsvariablen nicht definieren. Die Variablen müssen also ausdrücklich gesetzt werden. Welcher Wert, ist meist unerheblich. Es muss nur irgendein Wert sein. Das Folgende genügt vermutlich in den meisten Fällen.

```
    set env(SHELL) /bin/sh
    set env(HOME) /usr/local/bin
```

Manche Pty-Umsetzungen sind so gebaut, dass der Kern ungelesene Ausgabe 10 bis 15 Sekunden nach dem Schließen des Dateideskriptors durch den Prozess verwirft. Die genaue Zahl hängt von der Umsetzung ab. **Expect**-Programme wie diese schlagen deshalb fehl:

```
    spawn date
    sleep 20
    expect
```

Das lässt sich vermeiden, indem nicht interaktive Programme mit **exec** aufgerufen werden und nicht mit **spawn**. Solche Situationen sind denkbar. In der Praxis ist dem Autor kein Fall begegnet, in dem die letzte Ausgabe eines wirklich interaktiven Programms durch dieses Verhalten verloren ging.

Ptys von Cray UNICOS verwerfen ungelesene Ausgabe dagegen sofort, nachdem der Prozess den Dateideskriptor geschlossen hat. Das ist an Cray gemeldet, und dort wird an einer Korrektur gearbeitet.

Manchmal ist zwischen einer Eingabeaufforderung und einer Antwort eine Verzögerung nötig, etwa wenn eine tty-Schnittstelle UART-Einstellungen ändert oder Baudraten angleicht, indem sie nach Start- und Stoppbits sucht. Gewöhnlich genügt es, ein oder zwei Sekunden zu schlafen. Robuster ist, es zu wiederholen, bis die Hardware Eingabe annehmen kann. Das folgende Beispiel verwendet beide Wege:

```
    send "speed 9600\r";
    sleep 1
    expect {
        timeout {send "\r"; exp_continue}
        $prompt
    }
```

trap -code arbeitet mit keinem Befehl, der in der Ereignisschleife von Tcl sitzt, etwa sleep. In der Ereignisschleife verwirft Tcl die Rückgabecodes asynchroner Ereignisbehandler. Ein Ausweg ist, im Trap-Code eine Variable zu setzen und sie unmittelbar nach dem Befehl zu prüfen, also nach sleep.

Der Befehl expect\_background übergeht Argumente -timeout und kennt Zeitüberschreitungen allgemein nicht.

# Expect-Hinweise

Einiges an **Expect** ist nicht naheliegend. Dieser Abschnitt geht auf einiges davon mit ein paar Vorschlägen ein.

Ein häufiges Problem von expect ist, Shell-Eingabeaufforderungen zu erkennen. Diese Eingabeaufforderungen werden von verschiedenen Personen und verschiedenen Shells unterschiedlich angepasst. rlogin lässt sich deshalb ohne Kenntnis der Eingabeaufforderung schwer so automatisieren, dass es auf anderen Systemen ebenso läuft. Eine vernünftige Vereinbarung ist, dass Benutzer einen regulären Ausdruck, der ihre Eingabeaufforderung beschreibt, insbesondere ihr Ende, in der Umgebungsvariable EXPECT\_PROMPT ablegen. Code wie der folgende kann verwendet werden. Fehlt EXPECT\_PROMPT, hat der Code trotzdem gute Aussicht, richtig zu arbeiten.

```
    set prompt "(%|#|\\$) $"          ;# default prompt
    catch {set prompt $env(EXPECT_PROMPT)}

    expect -re $prompt
```

Muster für **expect** sollten das Ende dessen enthalten, was erwartet wird. So wird vermieden, eine Frage zu beantworten, bevor sie ganz gesehen wurde. Fragen lassen sich zwar beantworten, bevor sie ganz sichtbar sind. Wird früh geantwortet, kann die Antwort mitten in der Frage zurückgesendet erscheinen. Der entstehende Dialog ist dann richtig, sieht aber durcheinander aus.

Die meisten Eingabeaufforderungen enden mit einem Leerzeichen. Die Eingabeaufforderung von ftp ist zum Beispiel 'f', 't', 'p', '>' und <blank>. Damit dieses Muster passt, muss jedes dieser Zeichen berücksichtigt werden. Ein häufiger Fehler ist, das Leerzeichen wegzulassen. Das Leerzeichen wird ausdrücklich ins Muster geschrieben.

Wird ein Muster der Form X\* verwendet, passt das \* auf die ganze Ausgabe vom Ende von X bis zum zuletzt Empfangenen. Das klingt naheliegend, kann aber verwirren, weil „zuletzt Empfangenes“ je nach Geschwindigkeit des Rechners und der Ein-/Ausgabe-Verarbeitung durch Kern und Gerätetreiber verschieden sein kann.

Menschen sehen Programm-Ausgabe insbesondere gern in großen Stücken ankommen, unteilbar, während die meisten Programme in Wirklichkeit eine Zeile nach der anderen erzeugen. Trifft das zu, passt das \* im Muster des vorigen Absatzes vielleicht nur auf das Ende der aktuellen Zeile, obwohl mehr zu kommen scheint, weil zum Zeitpunkt der Übereinstimmung nur diese Ausgabe empfangen worden war.

**expect** kann nicht wissen, dass weitere Ausgabe kommt, wenn das Muster das nicht ausdrücklich berücksichtigt.

Sich auf zeilenorientiertes Puffern zu verlassen, ist unklug. Programme machen selten Zusagen über die Art ihres Pufferns, und Systemüberlastung kann Ausgabezeilen so zerteilen, dass die Zeilen an scheinbar zufälligen Stellen umbrechen. Lassen sich beim Schreiben von Mustern die letzten Zeichen einer Eingabeaufforderung ausdrücken, ist das ratsam.

Wird auf ein Muster in der letzten Ausgabe eines Programms gewartet und das Programm gibt stattdessen etwas anderes aus, lässt sich das mit dem Schlüsselwort **timeout** nicht erkennen. **expect** läuft dann nicht in die Zeitüberschreitung, sondern erhält eine Anzeige **eof**. Die wird verwendet. Besser ist, beide zu verwenden. Wird die Zeile später verschoben, muss die Zeile selbst nicht geändert werden.

Zeilenumbrüche werden vom Terminaltreiber gewöhnlich in Folgen aus Wagenrücklauf und Zeilenvorschub umgewandelt. Soll ein Muster die beiden Zeilen ausdrücklich treffen, etwa aus printf("foo\\nbar"), dient das Muster "foo\\r\\nbar".

Eine ähnliche Übersetzung geschieht beim Lesen vom Benutzer, über **expect\_user**. Wird Return gedrückt, wird das in einen Zeilenumbruch übersetzt. Gibt **Expect** das dann an ein Programm weiter, das sein Terminal in den Rohmodus setzt, wie telnet, entsteht ein Problem, weil das Programm ein echtes Return erwartet. Manche Programme sind nachsichtig und übersetzen Zeilenumbrüche von selbst in Returns, die meisten nicht. Es gibt leider keinen Weg zu erkennen, dass ein Programm sein Terminal in den Rohmodus gesetzt hat.

Statt Zeilenumbrüche von Hand durch Returns zu ersetzen, dient der Befehl "stty raw", der die Übersetzung anhält. Damit entfallen allerdings die Funktionen zur Zeilenbearbeitung im kanonischen Modus.

**interact** setzt das Terminal implizit in den Rohmodus, sodass dieses Problem dann nicht auftritt.

Es ist oft nützlich, Passwörter oder andere private Angaben in **Expect**-Skripten zu speichern. Das ist nicht zu empfehlen, weil alles, was auf einem Rechner liegt, von jedem gelesen werden kann. Passwörter interaktiv aus einem Skript abzufragen, ist klüger, als sie wörtlich einzubetten. Trotzdem ist das Einbetten manchmal die einzige Möglichkeit.

Das UNIX-Dateisystem hat keinen unmittelbaren Weg, Skripte anzulegen, die ausführbar, aber nicht lesbar sind. Systeme, die setgid-Shellskripte unterstützen, können das mittelbar so nachbilden:

Das **Expect**-Skript mit den geheimen Daten wird wie üblich angelegt. Seine Rechte werden 750 (-rwxr-x---), und es gehört einer vertrauenswürdigen Gruppe, also einer Gruppe, die es lesen darf. Nötigenfalls wird dafür eine neue Gruppe angelegt. Danach wird ein /bin/sh-Skript mit den Rechten 2751 (-rwxr-s--x) angelegt, das derselben Gruppe gehört.

Das Ergebnis ist ein Skript, das jeder ausführen und lesen darf. Beim Aufruf führt es das **Expect**-Skript aus.

# Siehe auch

**Tcl**(3), **libexpect**(3)

*"Exploring Expect: A Tcl-Based Toolkit for Automating Interactive Programs"* von Don Libes, pp. 602, ISBN 1-56592-090-2, O'Reilly and Associates, 1995.

*"expect: Curing Those Uncontrollable Fits of Interactivity"* von Don Libes, Proceedings of the Summer 1990 USENIX Conference, Anaheim, California, June 11-15, 1990.

*"Using* **expect** to Automate System Administration Tasks" von Don Libes, Proceedings of the 1990 USENIX Large Installation Systems Administration Conference, Colorado Springs, Colorado, October 17-19, 1990.

*"Tcl: An Embeddable Command Language"* von John Ousterhout, Proceedings of the Winter 1990 USENIX Conference, Washington, D.C., January 22-26, 1990.

*"expect: Scripts for Controlling Interactive Programs"* von Don Libes, Computing Systems, Vol. 4, No. 2, University of California Press Journals, November 1991.

*"Regression Testing and Conformance Testing Interactive Programs",* von Don Libes, Proceedings of the Summer 1992 USENIX Conference, pp. 135-144, San Antonio, TX, June 12-15, 1992.

*"Kibitz - Connecting Multiple Interactive Programs Together",* von Don Libes, Software - Practice & Experience, John Wiley & Sons, West Sussex, England, Vol. 23, No. 5, May, 1993.

*"A Debugger for Tcl Applications",* von Don Libes, Proceedings of the 1993 Tcl/Tk Workshop, Berkeley, CA, June 10-11, 1993.

# Autoren

Don Libes, National Institute of Standards and Technology

# Danksagungen

Dank an John Ousterhout für Tcl und an Scott Paisley für die Anregung. Dank an Rob Savoye für den Autokonfigurations-Code von Expect.

Die Datei HISTORY dokumentiert einen großen Teil der Entwicklung von **expect**. Die Datei ist lesenswert und kann weiteren Einblick in diese Software geben. Dank an die dort genannten Personen, die Fehlerkorrekturen geschickt und sonst geholfen haben.

Entwurf und Umsetzung von **Expect** wurden zum Teil von der Regierung der USA bezahlt und sind deshalb gemeinfrei. Der Autor und das NIST wünschen eine Nennung, wenn dieses Programm und diese Dokumentation oder Teile davon verwendet werden.
