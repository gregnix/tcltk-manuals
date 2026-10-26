---
CommandName: tclvars
ManualSection: n
Version: 8.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - eval(n)
 - library(n)
 - tclsh(1)
 - tkvars(n)
 - wish(1)
Keywords:
 - arithmetic
 - bytecode
 - compiler
 - error
 - environment
 - POSIX
 - precision
 - subprocess
 - user
 - variables
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# NAME

argc, argv, argv0, auto_path, env, errorCode, errorInfo, tcl_interactive, tcl_library, tcl_patchLevel, tcl_pkgPath, tcl_platform, tcl_rcFileName, tcl_traceCompile, tcl_traceExec, tcl_version - Von Tcl verwendete Variablen

# BESCHREIBUNG

Die folgenden globalen Variablen werden von der Tcl-Bibliothek automatisch erzeugt und verwaltet. Sofern unten nicht anders vermerkt, sollten diese Variablen von anwendungsspezifischem Code und von Benutzern in der Regel als schreibgeschützt behandelt werden.

**auto_path**
: Ist sie gesetzt, muss sie eine gültige Tcl-Liste mit Verzeichnissen enthalten, die bei Auto-Load-Vorgängen durchsucht werden (einschließlich Paketindexdateien bei Verwendung des Standard-Handlers **package unknown**). Diese Variable wird beim Start initialisiert und enthält in dieser Reihenfolge: die in der Umgebungsvariable **TCLLIBPATH** aufgeführten Verzeichnisse, das durch die globale Variable **tcl_library** benannte Verzeichnis, das übergeordnete Verzeichnis von **tcl_library**, **[file dirname [file dirname [info nameofexecutable]]]/lib**, die in der Variable **tcl_pkgPath** aufgeführten Verzeichnisse. Weitere Orte für Dateien und Paketindizes sollten normalerweise mit **lappend** zu dieser Variable hinzugefügt werden. Bei der Initialisierung von **auto_path** aus der Umgebungsvariable TCLLIBPATH wird für jeden Pfad eine Tilden-Substitution durchgeführt (siehe **filename**). Jede Tilden-Substitution, die fehlschlägt, weil der Benutzer unbekannt ist, wird aus **auto_path** weggelassen.
    Weitere Variablen zur Paketverwaltung existieren. Weitere Details stehen im Abschnitt **VARIABLES** der Manpage **library**.

**env**
: Diese Variable wird von Tcl als Array verwaltet, dessen Elemente die Umgebungsvariablen des Prozesses sind. Das Lesen eines Elements liefert den Wert der entsprechenden Umgebungsvariable. Das Setzen eines Array-Elements ändert die entsprechende Umgebungsvariable oder legt eine neue an, falls sie noch nicht existiert. Das Entfernen eines Elements von **env** löscht die entsprechende Umgebungsvariable. Änderungen am Array **env** wirken sich auf die Umgebung aus, die an Kindprozesse durch Befehle wie **exec** übergeben wird. Wird das gesamte Array **env** entfernt, überwacht Tcl keine Zugriffe auf **env** mehr und aktualisiert keine Umgebungsvariablen.
    Unter Windows werden die Umgebungsvariablen PATH und COMSPEC unabhängig von der Groß-/Kleinschreibung automatisch in Großbuchstaben umgewandelt. So kann die PATH-Variable vom Betriebssystem als „path“, „Path“, „PaTh“ usw. exportiert werden, was ansonsten einfachen Tcl-Code zu vielen Sonderfällen zwingen würde. Alle anderen von Tcl geerbten Umgebungsvariablen bleiben unverändert. Das Setzen eines **env**-Array-Elements auf einen leeren Wert entspricht dem Entfernen, da dies dem Verhalten des zugrunde liegenden Windows-Betriebssystems entspricht. Es ist zu beachten, dass sich auf Windows nicht auf eine vorhandene und leere Umgebungsvariable verlassen lässt; für plattformübergreifenden Einsatz wird dies nicht empfohlen.
    Die folgenden Elemente von **env** sind für Tcl besonders:

**env(HOME)**
: Diese Umgebungsvariable gibt, falls gesetzt, den Ort des Verzeichnisses an, das als Heimatverzeichnis des aktuellen Benutzers gilt. Der Wert dieser Variable wird vom Befehl **file home** zurückgegeben. Die meisten Plattformen setzen dies standardmäßig korrekt; sie muss normalerweise nicht durch Benutzercode gesetzt werden. Unter Windows wird sie, falls noch nicht gesetzt, auf den Wert der Umgebungsvariable **USERPROFILE** gesetzt.

**env(TCL_LIBRARY)**
: Ist sie gesetzt, legt sie den Ort des Verzeichnisses mit Bibliotheksskripten fest (der Wert dieser Variable wird der Variable **tcl_library** zugewiesen und daher vom Befehl **info library** zurückgegeben). Ist diese Variable nicht gesetzt, wird ein Standardwert verwendet.

    Beachten Sie, dass diese Umgebungsvariable normalerweise *nicht* gesetzt werden sollte.

**env(TCLLIBPATH)**
: Ist sie gesetzt, muss sie eine gültige Tcl-Liste mit Verzeichnissen enthalten, die bei Auto-Load-Vorgängen durchsucht werden. Verzeichnisse müssen im Tcl-Format angegeben werden, mit „/“ als Pfadtrenner, unabhängig von der Plattform. Diese Variable wird nur bei der Initialisierung der Variable **auto_path** verwendet.

**env(TCL_TZ)**, **env(TZ)**
: Diese legen die Standardzeitzone für das Parsen und Formatieren von Zeiten und Datumsangaben im Befehl **clock** fest. Auf vielen Plattformen wird die TZ-Umgebungsvariable vom Betriebssystem eingerichtet.

**env(LC_ALL)**, **env(LC_MESSAGES)**, **env(LANG)**
: Diese Umgebungsvariablen werden vom Paket **msgcat** verwendet, um festzulegen, mit welcher Locale Nachrichten formatiert werden.

**env(TCL_INTERP_DEBUG_FRAME)**
: Existiert sie, hat sie dieselbe Wirkung wie die Ausführung von **interp debug** **{} -frame 1** als allererstem Befehl jedes neuen Tcl-Interpreters.

**errorCode**
: Diese Variable enthält den Wert der Rückgabeoption **-errorcode**, die durch den zuletzt in diesem Interpreter aufgetretenen Fehler gesetzt wurde. Dieser Listenwert stellt zusätzliche Informationen über den Fehler in einer für Programme leicht verarbeitbaren Form dar. Das erste Element der Liste identifiziert eine allgemeine Fehlerklasse und bestimmt das Format des restlichen Teils der Liste. Die folgenden Formate für Rückgabeoptionen **-errorcode** werden vom Tcl-Kern verwendet; einzelne Anwendungen können weitere Formate definieren.

**ARITH** *code msg*
: Dieses Format wird bei einem arithmetischen Fehler verwendet (z. B. ein Versuch, Null durch Null im Befehl **expr** zu teilen). *code* identifiziert den genauen Fehler und *msg* liefert eine für Menschen lesbare Fehlerbeschreibung. *code* ist entweder DIVZERO (bei einem Versuch, durch Null zu teilen), DOMAIN (wenn ein Argument außerhalb des Definitionsbereichs einer Funktion liegt, z. B. acos(-3)), IOVERFLOW (bei Integer-Überlauf), OVERFLOW (bei Gleitkomma-Überlauf) oder UNKNOWN (wenn die Fehlerursache nicht bestimmt werden kann).

    Die Erkennung dieser Fehler hängt teilweise von der zugrunde liegenden Hardware und den Systembibliotheken ab.

**CHILDKILLED** *pid sigName msg*
: Dieses Format wird verwendet, wenn ein Kindprozess wegen eines Signals beendet wurde. Das Element *pid* ist die Prozesskennung (dezimal). Das Element *sigName* ist der symbolische Name des Signals, das den Prozess beendet hat; es ist einer der Namen aus der Include-Datei signal.h, z. B. **SIGPIPE**. Das Element *msg* ist eine kurze, für Menschen lesbare Meldung zum Signal, z. B. „Schreiben in Pipe ohne Leser“ für **SIGPIPE**.

**CHILDSTATUS** *pid code*
: Dieses Format wird verwendet, wenn ein Kindprozess mit einem von Null verschiedenen Exit-Status beendet wurde. Das Element *pid* ist die Prozesskennung (dezimal) und das Element *code* ist der vom Prozess zurückgegebene Exit-Code (ebenfalls dezimal).

**CHILDSUSP** *pid sigName msg*
: Dieses Format wird verwendet, wenn ein Kindprozess wegen eines Signals angehalten wurde. Das Element *pid* ist die Prozesskennung in Dezimalform. Das Element *sigName* ist der symbolische Name des Signals, das den Prozess angehalten hat; es ist einer der Namen aus der Include-Datei signal.h, z. B. **SIGTTIN**. Das Element *msg* ist eine kurze, für Menschen lesbare Meldung zum Signal, z. B. „Hintergrund-TTY-Lesen“ für **SIGTTIN**.

**NONE**
: Dieses Format wird für Fehler verwendet, bei denen außer der mit dem Fehler zurückgegebenen Meldung keine weiteren Informationen verfügbar sind. In diesen Fällen besteht die Rückgabeoption **-errorcode** aus einer Liste mit einem einzigen Element, dessen Inhalt **NONE** ist.

**POSIX** *errName msg*
: Ist das erste Element **POSIX**, trat der Fehler bei einem POSIX-Kernelaufruf auf. Das Element *errName* enthält den symbolischen Namen des aufgetretenen Fehlers, z. B. **ENOENT**; es ist einer der in der Include-Datei errno.h definierten Werte. Das Element *msg* ist eine für Menschen lesbare Meldung zu *errName*, z. B. „Datei oder Verzeichnis nicht vorhanden“ im Fall **ENOENT**.

**TCL** ...
: Weist auf ein Problem im Zusammenhang mit Tcl selbst hin, z. B. das Fehlschlagen der Suche nach einem Kanal oder einer Variable.


Um die Rückgabeoption **-errorcode** zu setzen, sollten Anwendungen Bibliotheksprozeduren wie **Tcl_SetObjErrorCode**, **Tcl_SetReturnOptions** und **Tcl_PosixError** verwenden oder die Option **-errorcode** des Befehls **return** aufrufen. Wurde keine dieser Methoden zum Setzen des Fehlercodes verwendet, setzt der Tcl-Interpreter die Variable nach dem nächsten Fehler auf **NONE** zurück.

**errorInfo**
: Diese Variable enthält den Wert der Rückgabeoption **-errorinfo**, die durch den zuletzt in diesem Interpreter aufgetretenen Fehler gesetzt wurde. Dieser Zeichenkettenwert enthält eine oder mehrere Zeilen, die die Tcl-Befehle und Prozeduren identifizieren, die bei dem zuletzt aufgetretenen Fehler ausgeführt wurden. Der Inhalt hat die Form eines Stack-Trace mit den verschachtelten Tcl-Befehlen, die zum Zeitpunkt des Fehlers aufgerufen worden waren.

**tcl_library**
: Diese Variable enthält den Namen eines Verzeichnisses mit der Systembibliothek von Tcl-Skripten, z. B. solchen für Auto-Loading. Der Wert dieser Variable wird vom Befehl **info library** zurückgegeben. Details zu den Einrichtungen der Tcl-Skriptbibliothek stehen im Manpage-Eintrag **library**. Normalerweise verfügt jede Anwendung oder jedes Paket zusätzlich zur Tcl-Skriptbibliothek über eine eigene anwendungsspezifische Skriptbibliothek; jede Anwendung sollte eine globale Variable mit einem Namen wie **$***app***_library** setzen (wobei *app* der Anwendungsname ist), die den Netzwerkdateinamen des Bibliotheksverzeichnisses der Anwendung enthält. Der Anfangswert von **tcl_library** wird beim Erzeugen eines Interpreters gesetzt, indem mehrere Verzeichnisse durchsucht werden, bis eines gefunden wird, das ein geeignetes Tcl-Startskript enthält. Existiert die Umgebungsvariable **TCL_LIBRARY**, wird das von ihr benannte Verzeichnis zuerst geprüft. Ist **TCL_LIBRARY** nicht gesetzt oder verweist nicht auf ein geeignetes Verzeichnis, prüft Tcl weitere Verzeichnisse anhand eines fest eingebauten Standardorts, des Speicherorts der Binärdatei der Anwendung und des aktuellen Arbeitsverzeichnisses.

**tcl_patchLevel**
: Beim Erzeugen eines Interpreters initialisiert Tcl diese Variable mit einer Zeichenkette, die die aktuelle Patch-Stufe von Tcl angibt, z. B. **8.4.16** für Tcl 8.4 mit den ersten sechzehn offiziellen Patches oder **8.5b3** für die dritte Beta-Version von Tcl 8.5. Der Wert dieser Variable wird vom Befehl **info patchlevel** zurückgegeben.

**tcl_pkgPath**
: Diese Variable enthält eine Liste von Verzeichnissen, die angibt, wo Pakete normalerweise installiert sind. Sie wird unter Windows nicht verwendet. Sie enthält typischerweise einen oder zwei Einträge; bei zwei Einträgen ist der erste normalerweise ein Verzeichnis für plattformabhängige Pakete (z. B. Shared-Library-Binärdateien) und der zweite ein Verzeichnis für plattformunabhängige Pakete (z. B. Skriptdateien). Ein Paket wird typischerweise als Unterverzeichnis eines Eintrags in **tcl_pkgPath** installiert. Die Verzeichnisse in **tcl_pkgPath** sind standardmäßig in **auto_path** enthalten, sodass sie und ihre unmittelbaren Unterverzeichnisse bei **package require** automatisch nach Paketen durchsucht werden. Hinweis: **tcl_pkgPath** ist nicht zur Änderung durch die Anwendung vorgesehen. Ihr Wert wird beim Start zu **auto_path** hinzugefügt; Änderungen an **tcl_pkgPath** spiegeln sich nicht in **auto_path** wider. Sollen Tcl weitere Verzeichnisse nach Paketen durchsuchen, fügen Sie deren Namen **auto_path** hinzu, nicht **tcl_pkgPath**.

**tcl_platform**
: Dies ist ein assoziatives Array, dessen Elemente Informationen über die Plattform enthalten, auf der die Anwendung läuft, z. B. Name des Betriebssystems, aktuelle Versionsnummer und Befehlssatz der Maschine. Die unten aufgeführten Elemente sind immer definiert, können aber leere Zeichenketten als Wert haben, wenn Tcl keine relevanten Informationen ermitteln konnte. Erweiterungen und Anwendungen können dem Array weitere Werte hinzufügen. Die vordefinierten Elemente sind:

**byteOrder**
: Die native Byte-Reihenfolge dieser Maschine: entweder **littleEndian** oder **bigEndian**.

**debug**
: Existiert diese Variable, wurde der Interpreter mit einer debug-fähigen C-Laufzeit kompiliert und verlinkt. Diese Variable existiert nur unter Windows, damit Erweiterungsautoren je nach verwendeter C-Laufzeitbibliothek festlegen können, welches Paket geladen wird. Dies ist kein Hinweis darauf, dass dieser Kern Symbole enthält.

**engine**
: Der Name der Tcl-Sprachimplementierung. Beim ersten Erzeugen des Interpreters ist dies immer die Zeichenkette **Tcl**.

**machine**
: Der von dieser Maschine ausgeführte Befehlssatz, z. B. **intel**, **PPC**, **68k** oder **sun4m**. Auf UNIX-Maschinen ist dies der von **uname -m** zurückgegebene Wert.

**os**
: Der Name des auf dieser Maschine laufenden Betriebssystems, z. B. **Windows NT** oder **SunOS**. Auf UNIX-Maschinen ist dies der von **uname -s** zurückgegebene Wert.

**osVersion**
: Die Versionsnummer des auf dieser Maschine laufenden Betriebssystems. Auf UNIX-Maschinen ist dies der von **uname -r** zurückgegebene Wert.

**pathSeparator**
: Das Zeichen, mit dem PATH-ähnliche Umgebungsvariablen per **split** in die entsprechende Liste von Verzeichnisnamen aufgeteilt werden sollten.

**platform**
: Entweder **windows** oder **unix**. Identifiziert die allgemeine Betriebsumgebung der Maschine.

**pointerSize**
: Gibt die Größe des nativen Maschinenzeigers in Bytes an (genau genommen entspricht sie dem Ergebnis der Auswertung von *sizeof(void*)* in C.)

**user**
: Identifiziert den aktuellen Benutzer anhand der auf der Plattform verfügbaren Anmeldeinformationen. Dieser Wert stammt unter Unix von den Systemaufrufen getuid() und getpwuid(), unter Windows vom Systemaufruf GetUserName().

**wordSize**
: Gibt die Größe des nativen Maschinenworts in Bytes an (genau genommen entspricht sie dem Ergebnis der Auswertung von *sizeof(long)* in C.)


**tcl_rcFileName**
: Diese Variable wird bei der Initialisierung verwendet, um den Namen einer benutzerspezifischen Startdatei anzugeben. Wird sie durch anwendungsspezifische Initialisierung gesetzt, prüft der Tcl-Startcode auf das Vorhandensein dieser Datei und führt **source** darauf aus, falls sie existiert. Für **wish** ist die Variable z. B. unter Unix auf **~/.wishrc** und unter Windows auf **~/wishrc.tcl** gesetzt.

**tcl_traceCompile**
: Der Wert dieser Variable kann gesetzt werden, um zu steuern, wie viele Trace-Informationen während der Bytecode-Kompilierung ausgegeben werden. Standardmäßig ist **tcl_traceCompile** null und es wird nichts ausgegeben. Der Wert 1 erzeugt eine einzeilige Zusammenfassung in **stdout**, sobald eine Prozedur oder ein Top-Level-Befehl kompiliert wird. Der Wert 2 erzeugt eine detaillierte Auflistung in **stdout** der bei jeder Kompilierung emittierten Bytecode-Anweisungen. Diese Variable ist hilfreich beim Aufspüren vermuteter Probleme mit dem Tcl-Compiler.


Diese Variable und die Funktionalität existieren nur, wenn **TCL_COMPILE_DEBUG** bei der Kompilierung von Tcl definiert wurde.

**tcl_traceExec**
: Der Wert dieser Variable kann gesetzt werden, um zu steuern, wie viele Trace-Informationen während der Bytecode-Ausführung ausgegeben werden. Standardmäßig ist **tcl_traceExec** null und es wird nichts ausgegeben. Der Wert 1 erzeugt bei jedem Aufruf einer Tcl-Prozedur eine einzeilige Spur in **stdout**. Der Wert 2 erzeugt bei jedem aufgerufenen Tcl-Befehl eine Zeile mit Befehlsname und Argumenten. Der Wert 3 erzeugt eine detaillierte Spur mit dem Ergebnis der Ausführung jeder Bytecode-Anweisung. Bei **tcl_traceExec** 2 oder 3 werden Befehle wie **set** und **incr**, die vollständig durch eine Folge von Bytecode-Anweisungen ersetzt wurden, nicht angezeigt. Das Setzen dieser Variable ist hilfreich beim Aufspüren vermuteter Probleme mit Bytecode-Compiler und -Interpreter.


Diese Variable und die Funktionalität existieren nur, wenn **TCL_COMPILE_DEBUG** bei der Kompilierung von Tcl definiert wurde.

**tcl_version**
: Beim Erzeugen eines Interpreters initialisiert Tcl diese Variable mit der Versionsnummer dieser Tcl-Version in der Form *x.y*. Änderungen an *x* stehen für größere Änderungen mit wahrscheinlichen Inkompatibilitäten; Änderungen an *y* stehen für kleinere Erweiterungen und Fehlerbehebungen mit Abwärtskompatibilität. Der Wert dieser Variable wird vom Befehl **info tclversion** zurückgegeben.


# WEITERE GLOBALE VARIABLEN

Die folgenden Variablen sind nur in den ausführbaren Programmen **tclsh** und **wish** garantiert vorhanden; die Tcl-Bibliothek definiert sie selbst nicht, viele Tcl-Umgebungen jedoch schon.

**argc**
: Die Anzahl der Argumente für **tclsh** oder **wish**.

**argv**
: Tcl-Liste der Argumente für **tclsh** oder **wish**.

**argv0**
: Das Skript, mit dem **tclsh** oder **wish** die Ausführung begonnen hat (falls angegeben), andernfalls der Name, unter dem **tclsh** oder **wish** aufgerufen wurde.

**tcl_interactive**
: Enthält 1, wenn **tclsh** oder **wish** interaktiv läuft (kein Skript angegeben und die Standardeingabe ein terminalähnliches Gerät ist), sonst 0.


# BEISPIELE

Um ein Verzeichnis zur Menge der von **package require** durchsuchten Orte hinzuzufügen, z. B. wegen anwendungsspezifischer Pakete, muss die Variable **auto_path** aktualisiert werden:

```
lappend ::auto_path [file join [pwd] "theLibDir"]
```

Ein einfacher, wenn auch nicht sehr robuster Weg, Kommandozeilenargumente der Form „-foo 1 -bar 2“ zu verarbeiten, ist, sie in ein Array zu laden, nachdem zuvor die Standardwerte gesetzt wurden:

```
array set arguments {-foo 0 -bar 0 -grill 0}
array set arguments $::argv
puts "foo is $arguments(-foo)"
puts "bar is $arguments(-bar)"
puts "grill is $arguments(-grill)"
```

Die globale Variable **argv0** kann (zusammen mit dem Befehl **info script**) verwendet werden, um festzustellen, ob das aktuelle Skript als Hauptskript ausgeführt oder als Bibliothek geladen wird. Das ist nützlich, weil ein einziges Skript sowohl als Bibliothek als auch als Demonstration dieser Bibliothek dienen kann:

```
if {$::argv0 eq [info script]} {
    # Ausführung als: tclsh example.tcl
} else {
    package provide Example 1.0
}
```
