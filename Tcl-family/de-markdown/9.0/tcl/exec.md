---
CommandName: exec
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - error(n)
 - file(n)
 - open(n)
Keywords:
 - execute
 - pipeline
 - redirection
 - subprocess
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2006 Donal K. Fellows.
---

# NAME

exec - Startet Unterprozesse

# ÜBERSICHT

::: {.synopsis} :::
[exec]{.cmd} [switches]{.optarg} [arg]{.arg} [arg]{.optdot} [&]{.optlit} 
:::

# BESCHREIBUNG

Dieser Befehl behandelt seine Argumente als Spezifikation eines oder mehrerer auszuführender Unterprozesse. Die Argumente haben die Form einer Standard-Shell-Pipeline, bei der jedes *arg* ein Wort eines Befehls wird und jeder eigenständige Befehl ein Unterprozess wird. Das Ergebnis des Befehls ist die Standardausgabe des letzten Unterprozesses in der Pipeline, interpretiert mit der System-**encoding**; um eine andere Kodierung zu verwenden (insbesondere einschließlich binärer Daten), muss die Pipeline explizit mit **open** geöffnet, konfiguriert und gelesen werden.

Beginnen die anfänglichen Argumente von **exec** mit **-**, werden sie als Befehlszeilenschalter behandelt und gehören nicht zur Pipeline-Spezifikation. Derzeit werden folgende Schalter unterstützt:

**-encoding** *encodingName*
: Legt den Namen der Kodierung fest, mit der die Ausgabe des ersten Unterprozesses dekodiert wird. Standard ist die von **encoding system** zurückgegebene Kodierung.

**-ignorestderr**
: Verhindert, dass der Befehl **exec** die Ausgabe von Meldungen auf dem Standardfehlerkanal der Pipeline als Fehlerfall behandelt.

**-keepnewline**
: Behält ein abschließendes Zeilenende in der Pipeline-Ausgabe bei. Normalerweise wird ein abschließendes Zeilenende entfernt.

**-\|-**
: Markiert das Ende der Schalter. Das folgende Argument wird als erstes *arg* behandelt, auch wenn es mit **-** beginnt.


Hat ein *arg* (oder ein Paar von *arg*s) eine der unten beschriebenen Formen, verwendet **exec** es zur Steuerung des Ein- und Ausgabeflusses zwischen den Unterprozessen. Solche Argumente werden nicht an die Unterprozesse übergeben. Bei Formen wie „**<** *fileName*“ kann *fileName* entweder in einem separaten Argument von „**<**“ stehen oder im selben Argument ohne Leerzeichen dazwischen (d. h. „**<**_fileName_“).

**|**
: Trennt eigenständige Befehle in der Pipeline. Die Standardausgabe des vorhergehenden Befehls wird in die Standardeingabe des nächsten Befehls geleitet.

**|&**
: Trennt eigenständige Befehle in der Pipeline. Sowohl Standardausgabe als auch Standardfehler des vorhergehenden Befehls werden in die Standardeingabe des nächsten Befehls geleitet. Diese Umleitungsform setzt Formen wie 2> und >& außer Kraft.

**<\0***fileName*
: Die von *fileName* benannte Datei wird geöffnet und als Standardeingabe für den ersten Befehl in der Pipeline verwendet.

**<@\0***fileId*
: *FileId* muss der Bezeichner einer geöffneten Datei sein, etwa der Rückgabewert eines früheren Aufrufs von **open**. Er wird als Standardeingabe für den ersten Befehl in der Pipeline verwendet. *FileId* muss zum Lesen geöffnet worden sein.

**<<**\\**0**_value_
: *Value* wird mit der Systemkodierung kodiert, Zeilenenden durch plattformspezifische Zeilenendesequenzen ersetzt und dann dem ersten Befehl als Standardeingabe übergeben.

**>\0***fileName*
: Die Standardausgabe des letzten Befehls wird in die von *fileName* benannte Datei umgeleitet und überschreibt deren bisherigen Inhalt.

**2>\0***fileName*
: Der Standardfehler aller Befehle in der Pipeline wird in die von *fileName* benannte Datei umgeleitet und überschreibt deren bisherigen Inhalt.

**>&\0***fileName*
: Sowohl die Standardausgabe des letzten Befehls als auch der Standardfehler aller Befehle werden in die von *fileName* benannte Datei umgeleitet und überschreiben deren bisherigen Inhalt.

**>>\0***fileName*
: Die Standardausgabe des letzten Befehls wird in die von *fileName* benannte Datei umgeleitet und an diese angehängt, statt sie zu überschreiben.

**2>>\0***fileName*
: Der Standardfehler aller Befehle in der Pipeline wird in die von *fileName* benannte Datei umgeleitet und an diese angehängt, statt sie zu überschreiben.

**>>&\0***fileName*
: Sowohl die Standardausgabe des letzten Befehls als auch der Standardfehler aller Befehle werden in die von *fileName* benannte Datei umgeleitet und an diese angehängt, statt sie zu überschreiben.

**>@\0***fileId*
: *FileId* muss der Bezeichner einer geöffneten Datei sein, etwa der Rückgabewert eines früheren Aufrufs von **open**. Die Standardausgabe des letzten Befehls wird in die Datei von *fileId* umgeleitet, die zum Schreiben geöffnet worden sein muss.

**2>@**\\**0**_fileId_
: *FileId* muss der Bezeichner einer geöffneten Datei sein, etwa der Rückgabewert eines früheren Aufrufs von **open**. Der Standardfehler aller Befehle in der Pipeline wird in die Datei von *fileId* umgeleitet. Die Datei muss zum Schreiben geöffnet worden sein.

**2>@1\0**
: Der Standardfehler aller Befehle in der Pipeline wird in das Befehlsergebnis umgeleitet. Dieser Operator ist nur am Ende der Befehlspipeline gültig.

**>&@\0***fileId*
: *FileId* muss der Bezeichner einer geöffneten Datei sein, etwa der Rückgabewert eines früheren Aufrufs von **open**. Sowohl die Standardausgabe des letzten Befehls als auch der Standardfehler aller Befehle werden in die Datei von *fileId* umgeleitet. Die Datei muss zum Schreiben geöffnet worden sein.


Wurde die Standardausgabe nicht umgeleitet, gibt der Befehl **exec** die Standardausgabe des letzten Befehls in der Pipeline zurück, sofern nicht „2>@1“ angegeben wurde — in diesem Fall ist auch der Standardfehler enthalten. Beendet ein Befehl in der Pipeline abnormal, wird beendet oder angehalten, gibt **exec** einen Fehler zurück; die Fehlermeldung enthält die Ausgabe der Pipeline, gefolgt von Fehlermeldungen zu den abnormalen Beendigungen; die Rückgabeoption **-errorcode** enthält zusätzliche Informationen zur zuletzt aufgetretenen abnormalen Beendigung. Schreibt ein Befehl auf seine Standardfehlerdatei und ist der Standardfehler nicht umgeleitet und **-ignorestderr** nicht angegeben, gibt **exec** einen Fehler zurück; die Fehlermeldung enthält die Standardausgabe der Pipeline, gefolgt von Meldungen zu abnormalen Beendigungen (falls vorhanden), gefolgt von der Standardfehlerausgabe.

Ist das letzte Zeichen des Ergebnisses oder der Fehlermeldung ein Zeilenende, wird dieses Zeichen normalerweise aus dem Ergebnis oder der Fehlermeldung entfernt. Das entspricht anderen Tcl-Rückgabewerten, die normalerweise nicht mit Zeilenenden enden. Ist jedoch **-keepnewline** angegeben, bleibt das abschließende Zeilenende erhalten.

Wird die Standardeingabe nicht mit „<“, „<<“ oder „<@“ umgeleitet, stammt die Standardeingabe für den ersten Befehl in der Pipeline von der aktuellen Standardeingabe der Anwendung.

Ist das letzte *arg* „&“, wird die Pipeline im Hintergrund ausgeführt. In diesem Fall gibt **exec** eine Liste zurück, deren Elemente die Prozesskennungen aller Unterprozesse in der Pipeline sind. Die Standardausgabe des letzten Befehls in der Pipeline geht auf die Standardausgabe der Anwendung, sofern nicht umgeleitet; die Fehlerausgabe aller Befehle in der Pipeline geht auf die Standardfehlerdatei der Anwendung, sofern nicht umgeleitet.

Das erste Wort jedes Befehls gilt als Befehlsname; enthält das Ergebnis keinen Schrägstrich, werden die Verzeichnisse in der PATH-Umgebungsvariable nach einem ausführbaren Programm mit diesem Namen durchsucht. Enthält der Name einen Schrägstrich, muss er auf ein aus der aktuellen Verzeichnisstruktur erreichbares ausführbares Programm verweisen. Auf die Befehlsargumente werden keine „glob“-Erweiterungen oder andere shell-ähnliche Substitutionen angewendet.

# PORTABILITÄTSFRAGEN

**Windows** (alle Versionen)
: Lesen von oder Schreiben auf einen Socket mit der Notation „**@\0***fileId*“ funktioniert nicht. Beim Lesen von einem Socket hängt eine 16-Bit-DOS-Anwendung, eine 32-Bit-Anwendung kehrt sofort mit Dateiende zurück. Schreibt eine der beiden Anwendungstypen auf einen Socket, werden die Informationen stattdessen an die Konsole gesendet, falls vorhanden, oder verworfen.
    Beachten Sie, dass die derzeitige Escape- bzw. Quoting-Behandlung von Argumenten unter Windows nur mit ausführbaren Programmen funktioniert, die CommandLineToArgv, die CRT-Bibliothek oder Ähnliches verwenden, sowie mit Windows-Batchdateien (außer dem Zeilenende, siehe unten). Obwohl es der übliche Escape-Algorithmus ist, ist in Wirklichkeit entscheidend, wie das ausführbare Programm die Befehlszeile parst (bzw. in einzelne Argumente aufteilt).
    Leider gibt es derzeit keine Möglichkeit, ein Zeilenendezeichen innerhalb eines Arguments an Batchdateien (**.cmd** oder **.bat**) oder an den Befehlsprozessor (**cmd.exe /c**) zu übergeben, weil die Befehlszeile (auch die Argumentkette) beim ersten Zeilenendezeichen abgeschnitten wird. Mit einem ausführbaren Programm (CommandLineToArgv usw.) funktioniert es jedoch korrekt.
    **Argument-Quoting** Die Argumente des Befehls **exec** werden den Argumenten des aufgerufenen Programms zugeordnet. Zusätzliche Anführungszeichen (**"**) werden bei Bedarf automatisch um Argumente gesetzt. Sonderzeichen werden durch Einfügen von Backslash-Zeichen escaped.
    Die MS-Windows-Umgebung führt in den Argumenten genannte Programme aus, und aufgerufene Batchdateien (conspec) ersetzen Umgebungsvariablen, was Nebenwirkungen (Sicherheitslücken) haben oder bestehendes Quoting zerstören kann (z. B. wenn die Umgebungsvariable ein Sonderzeichen wie **"** enthält). Beispiele:

    ```
    % exec my-echo.cmd {test&whoami}
      test
      mylogin
    % exec my-echo.cmd "ENV X:%X%"
      ENV X: CONTENT OF X
    ```
    Folgende Formatierung wird automatisch auf jedes Argumentelement angewendet, um die Ausführung von Unterprogrammen zu vermeiden: Jedes Argument, das ein Sonderzeichen (**&**, **|**, **^**, **<**, **>**, **!**, **(**, **)**, **(**, **%**) enthält, wird automatisch in Anführungszeichen (**"**) gesetzt. Jedes Daten-Anführungszeichen wird durch Einfügen von Backslash-Zeichen escaped.
    Die automatische Auflösung von Umgebungsvariablen mit „**%var%**“ ist kritisch, hat aber mehr Nutzen als Gefahr und wird nicht escaped.


Das Tk-Konsolen-Text-Widget bietet keine echten Standard-E/A-Fähigkeiten. Unter Tk sehen alle Anwendungen bei Umleitung von der Standardeingabe sofort Dateiende; auf Standardausgabe oder Standardfehler umgeleitete Informationen werden verworfen.

Sowohl vorwärts als auch rückwärts gerichtete Schrägstriche werden als Pfadtrenner in Argumenten von Tcl-Befehlen akzeptiert. Beim Ausführen einer Anwendung kann der angegebene Pfadname ebenfalls vorwärts oder rückwärts gerichtete Schrägstriche als Pfadtrenner enthalten. Beachten Sie jedoch, dass die meisten Windows-Anwendungen Argumente mit vorwärts gerichteten Schrägstrichen nur als Optionstrenner und rückwärts gerichtete Schrägstriche nur in Pfaden akzeptieren. Argumente mit vorwärts gerichteten Schrägstrichen als Pfadtrenner werden nicht automatisch in Backslashes umgewandelt. Ob ein solches Argument als Pfadname erkannt wird, hängt vom Programm ab.

Zwei oder mehr aufeinanderfolgende vorwärts oder rückwärts gerichtete Schrägstriche in einem Pfad bezeichnen einen Netzwerkpfad. Eine einfache Verkettung des Stammverzeichnisses **c:/** mit einem Unterverzeichnis **/windows/system** ergibt z. B. **c://windows/system** (zwei Schrägstriche zusammen), was auf den Einhängepunkt **system** auf dem Rechner **windows** verweist (und **c:/** ignoriert wird), und ist nicht gleichwertig mit **c:/windows/system**, das ein Verzeichnis auf dem aktuellen Rechner beschreibt. Zum Verketten von Pfadkomponenten sollte **file join** verwendet werden.

Es gibt zwei allgemeine Typen von Win32-Konsolenanwendungen:

1. CLI — CommandLine Interface, einfacher stdio-Austausch. Beispiel: **netstat.exe**.

2. TUI — Textmode User Interface, jede Anwendung, die die Konsolen-API für Cursorbewegung, Textfarbe, Tastendrücke, Mausbewegung usw. nutzt. Beispiel: **telnet.exe** unter Windows 2000. Solche Anwendungen sind unter Windows selten, existieren aber.


**exec** funktioniert mit TUI-Anwendungen schlecht, wenn keine Konsole vorhanden ist, wie beim Start unter wish. Konsolenanwendungen sollen verborgen und abgetrennt laufen. Das ist eine bewusste Einschränkung, weil **exec** über Pipes kommunizieren will. Die Expect-Erweiterung adressiert dieses Problem bei der Kommunikation mit TUI-Anwendungen.

Beim Versuch, eine Anwendung auszuführen, sucht **exec** zuerst nach dem angegebenen Namen. Anschließend werden der Reihe nach **.com**, **.exe**, **.bat** und **.cmd** an den angegebenen Namen angehängt und nach dem längeren Namen gesucht. War kein Verzeichnisname Teil des Anwendungsnamens, werden folgende Verzeichnisse der Reihe nach automatisch durchsucht:

- Das Verzeichnis, aus dem die Tcl-Ausführungsdatei geladen wurde.

- Das aktuelle Verzeichnis.

- Das Windows-32-Bit-Systemverzeichnis.

- Das Windows-Home-Verzeichnis.

- Die in PATH aufgeführten Verzeichnisse.


Um Shell-eingebaute Befehle wie **dir** und **copy** auszuführen, muss der Aufrufer den gewünschten Befehl mit „**cmd.exe /c\0**“ voranstellen, weil eingebaute Befehle nicht als ausführbare Programme implementiert sind.

**Unix** (einschließlich macOS)
: Der Befehl **exec** ist voll funktionsfähig und arbeitet wie beschrieben.


# UNIX-BEISPIELE

Hier einige Beispiele für **exec** unter Unix. Ein einfaches Programm ausführen und das Ergebnis erhalten:

```
exec uname -a
```

## Mit von Null verschiedenen Ergebnissen arbeiten

Um ein Programm auszuführen, das einen von Null verschiedenen Rückgabewert liefern kann, sollte der Aufruf von **exec** in **catch** eingebettet und bei Fehler der Inhalt der Rückgabeoption **-errorcode** geprüft werden:

```
set status 0
if {[catch {exec grep foo bar.txt} results options]} {
    set details [dict get $options -errorcode]
    if {[lindex $details 0] eq "CHILDSTATUS"} {
        set status [lindex $details 2]
    } else {
        # Anderer Fehler; Fehler an Aufrufer weitergeben
        return -options $options -level 0 $results
    }
}
```

Einfacher schreibt sich das mit **try**, weil sich bestimmte Fehlertypen leichter abfangen lassen:

```
try {
    set results [exec grep foo bar.txt]
    set status 0
} trap CHILDSTATUS {results options} {
    set status [lindex [dict get $options -errorcode] 2]
}
```

## Mit in Anführungszeichen gesetzten Argumenten arbeiten

Beim Übersetzen eines Befehls aus einer Unix-Shell-Aufrufzeile ist zu beachten, dass einfache Anführungszeichen in Tcl keine besondere Bedeutung haben. Also:

```
awk '{sum += $1} END {print sum}' numbers.list
```

wird etwa so übersetzt:

```
exec awk {{sum += $1} END {print sum}} numbers.list
```

## Mit Globbing arbeiten

Bei Aufrufen mit Shell-Globbing ist zu bedenken, dass Tcl standardmäßig kein Globbing durchführt und Dinge nicht in mehrere Argumente expandiert. Stattdessen schreibt man z. B.:

```
exec ls -l {*}[glob *.tcl]
```

## Mit vom Benutzer gelieferten Shell-Skriptfragmenten arbeiten

Eine nützliche Technik ist, Benutzern eines Skripts ein Shell-Skriptfragment ausführen zu lassen, dem auf der Standardeingabe vom Tcl-Programm erzeugte Daten übergeben werden. Das ist bei *lpr* zum Drucken üblich. Am einfachsten übergibt man das Benutzerskript der Shell des Benutzers zur Verarbeitung — das vermeidet viel Komplexität beim Parsen anderer Sprachen.

```
set lprScript [vom Benutzer holen...]
set postscriptData [irgendwie erzeugen...]

exec $env(SHELL) -c $lprScript << $postscriptData
```

# WINDOWS-BEISPIELE

Hier einige Beispiele für **exec** unter Windows. Eine *notepad*-Instanz starten, die eine Datei bearbeitet, ohne auf das Ende der Bearbeitung zu warten:

```
exec notepad myfile.txt &
```

Eine Textdatei mit *notepad* drucken:

```
exec notepad /p myfile.txt
```

## Mit Konsolenprogrammen arbeiten

Ruft ein Programm andere Programme auf, wie bei Compilern üblich, kann es nötig sein, Batchdateien zu verwenden, um Konsolenfenster zu verbergen, die manchmal aufpoppen:

```
exec cmp.bat somefile.c -o somefile
```

Mit einer *cmp.bat* etwa wie:

```
@gcc %*
```

oder einer Variante mit einzelnen Parametern:

```
@gcc %1 %2 %3 %4 %5 %6 %7 %8 %9
```

## Mit eingebauten Befehlen arbeiten

Manchmal ist Vorsicht nötig: Verschiedene Programme können denselben Namen haben und in PATH liegen. Dann kann derselbe Befehl an der DOS-Eingabeaufforderung *ein anderes Programm* finden als über **exec**. Das liegt an den (dokumentierten) Verhaltensunterschieden zwischen **exec** und DOS-Batchdateien.

Im Zweifel **auto_execok** verwenden: Es liefert den vollständigen Pfad zum Programm, wie **exec** ihn sieht. Das gilt besonders für „interne“ Befehle wie *dir* aus einem Tcl-Skript (zum bloßen Auflisten von Dateinamen **glob** verwenden). So geht es:

```
exec {*}[auto_execok dir] *.tcl
```

## Mit nativen Dateinamen arbeiten

Viele Windows-Programme verlangen Dateinamen mit Backslashes als Pfadtrenner. Dazu dient **file nativename**. Um ein Verzeichnis (auf NTFS) zu verschlüsseln, sodass nur der aktuelle Benutzer darauf zugreifen kann, braucht man *CIPHER*, etwa so:

```
set secureDir [file join [file home] Desktop/SecureDirectory]
file mkdir $secureDir
exec CIPHER /e /s:[file nativename $secureDir]
```

