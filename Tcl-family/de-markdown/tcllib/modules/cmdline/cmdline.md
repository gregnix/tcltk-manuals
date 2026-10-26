---
CommandName: cmdline
ManualSection: n
Version: 1.5.3
TclPart: tcllib
TclDescription: Command line and option processing
Keywords:
 - argument processing
 - argv
 - argv0
 - cmdline processing
 - command line processing
Copyright:
---

# NAME

cmdline – Prozeduren zur Verarbeitung von Befehlszeilen und Optionen.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [cmdline]{.lit} [1.5.3]{.optlit} 
[::cmdline::getopt]{.cmd} [argvVar]{.arg} [optstring]{.arg} [optVar]{.arg} [valVar]{.arg} 
[::cmdline::getKnownOpt]{.cmd} [argvVar]{.arg} [optstring]{.arg} [optVar]{.arg} [valVar]{.arg} 
[::cmdline::getoptions]{.cmd} [argvVar]{.arg} [optlist]{.arg} [usage]{.optarg} 
[::cmdline::getKnownOptions]{.cmd} [argvVar]{.arg} [optlist]{.arg} [usage]{.optarg} 
[::cmdline::usage]{.cmd} [optlist]{.arg} [usage]{.optarg} 
[::cmdline::getfiles]{.cmd} [patterns]{.arg} [quiet]{.arg} 
[::cmdline::getArgv0]{.cmd} 
:::

# BESCHREIBUNG

Dieses Paket enthält Befehle zum Analysieren von Befehlszeilen und Optionen.

# BEHANDLUNG VON ::ARGV

Eine der am häufigsten verwendeten Variablen in diesem Paket ist **::argv**, die die Befehlszeile der aktuellen Anwendung enthält. Zu dieser Variablen gehört die Begleitvariable **::argc**, die zu Beginn der Anwendung auf die Anzahl der Elemente in **::argv** initialisiert wird.

Die Befehle in diesem Paket ändern den **::argc**-Begleiter *nicht*, wenn sie mit **::argv** aufgerufen werden. Es liegt in der Verantwortung des Aufrufers, den Wert konsistent zu halten, falls dies gewünscht oder erforderlich ist.

# API

**::cmdline::getopt** *argvVar* *optstring* *optVar* *valVar*
: Dieser Befehl funktioniert ähnlich wie die auf C basierende Standardfunktion **getopt**. Bei Angabe einer Optionszeichenfolge und eines Zeigers auf ein Array mit Argumenten verarbeitet dieser Befehl das *erste Argument* und gibt Informationen darüber zurück, wie weiter vorzugehen ist. Der Befehl gibt 1 zurück, wenn eine Option gefunden wurde, 0, wenn keine weiteren Optionen gefunden wurden, und -1, wenn ein Fehler aufgetreten ist. *argvVar* enthält den Namen der Liste der zu verarbeitenden Argumente. Wenn Optionen gefunden werden, wird die Liste geändert und die verarbeiteten Argumente werden vom Anfang der Liste entfernt. *optstring* enthält eine Liste der Befehlsoptionen, die die Anwendung akzeptiert. Wenn die Option auf „.arg“ endet, verwendet der Befehl das nächste Argument als Argument für die Option oder extrahiert es aus dem aktuellen Argument, sofern es die Form „option=Wert“ hat. Andernfalls ist die Option ein boolescher Wert, der bei Vorhandensein auf 1 gesetzt wird. *optVar* bezieht sich auf die Variable, in der der Befehl die gefundene Option speichert (ohne das führende „-“ und ohne die Erweiterung „.arg“). *valVar* bezieht sich auf die Variable, in der entweder der Wert für die angegebene Option bei Erfolg oder eine Fehlermeldung im Falle eines Fehlers gespeichert wird. Der gespeicherte Wert stammt bei .arg-Optionen aus der Befehlszeile, andernfalls ist der Wert 1.

**::cmdline::getKnownOpt** *argvVar* *optstring* *optVar* *valVar*
: Ähnlich wie **::cmdline::getopt**, mit dem Unterschied, dass unbekannte Optionen in der Eingabe ignoriert werden.

**::cmdline::getoptions** *argvVar* *optlist* ?*usage*?
: Verarbeitet den gesamten Satz an Befehlszeilenoptionen, die in der durch *argvVar* benannten Listenvariablen enthalten sind, und setzt für nicht angegebene Optionen Standardwerte ein. Außerdem wird eine Fehlermeldung ausgegeben, in der die zulässigen Flags aufgelistet sind, falls ein falsches Flag angegeben wurde. Das optionale *usage*-argument enthält eine Zeichenkette, die vor der generierten Meldung eingefügt werden soll. Ist es nicht vorhanden, lautet der Standardwert „Optionen:“. *argvVar* enthält den Namen der Liste der zu verarbeitenden Argumente. Wenn Optionen gefunden werden, wird die Liste geändert und die verarbeiteten Argumente werden vom Anfang der Liste entfernt. *optlist* enthält eine Liste von Listen, wobei jedes Element eine Option in der Form *flag* *default* *comment* legt. Wenn *flag* auf „.arg“ endet, wird der Wert aus der Befehlszeile übernommen. Andernfalls handelt es sich um einen booleschen Wert, der im Ergebnis erscheint, sofern er in der Befehlszeile vorhanden ist. Endet *flag* auf „.secret“, wird es in der Verwendung nicht angezeigt. Die Optionen **-?**, **-help** und **--** werden implizit berücksichtigt. Die ersten beiden brechen den Prozess der Optionenverarbeitung durch Auslösen eines Fehlers ab und erzwingen die Ausgabe der Hilfe, während die letzte die Optionenverarbeitung ohne Fehler abbricht und alle nachfolgenden Argumente der regulären Verarbeitung überlässt, selbst wenn sie mit einem Bindestrich beginnen. Das Ergebnis des Befehls ist ein Dictionary, das alle Optionen ihren Werten zuordnet, unabhängig davon, ob es sich um benutzerdefinierte oder Standardwerte handelt.

**::cmdline::getKnownOptions** *argvVar* *optlist* ?*usage*?
: Ähnlich wie **::cmdline::getoptions**, ignoriert jedoch alle unbekannten Optionen in der Eingabe.

**::cmdline::usage** *optlist* ?*usage*?
: Erzeugt und gibt eine Fehlermeldung zurück, in der die zulässigen Flags aufgeführt sind. *optlist* ist wie bei **::cmdline::getoptions** definiert. Das optionale *usage*-argument enthält eine Zeichenkette, die vor der generierten Meldung eingefügt werden soll. Ist es nicht vorhanden, wird standardmäßig „Optionen:“ verwendet.

**::cmdline::getfiles** *patterns* *quiet*
: Anhand einer Liste von Datei-*Mustern* ermittelt dieser Befehl die Menge der gültigen Dateien. Unter Windows wird für jedes Argument eine Dateisuche durchgeführt. Unter Unix wird lediglich geprüft, ob die Datei existiert. Wenn ein Datei-Argument keine gültigen Dateien liefert, wird optional eine Warnung ausgegeben (set *quiet* auf „true“ setzen). Dieser Code verwendet außerdem den vollständigen Pfad für jede Datei.  Wird dieser nicht angegeben, wird dem Dateinamen das aktuelle Verzeichnis vorangestellt. Dadurch wird sichergestellt, dass diese Dateien niemals mit Dateien in einer umschlossenen ZIP-Datei in Konflikt geraten. Der letzte Satz bezieht sich auf die Pro Tools.

**::cmdline::getArgv0**
: Dieser Befehl gibt die „bereinigte“ Version von *argv0* zurück. Dabei wird der führende Pfad entfernt und die Erweiterung „.bin“ gestrichen. Letzteres wird von den TclPro-Anwendungen verwendet, da diese von einem Shell-Skript umschlossen werden müssen.


## Fehlercodes

Ab Version 1.5 verfügen alle vom Paket ausgelösten Fehler über einen korrekten **::errorCode**, der mit dem Tcl-Befehl **try** verwendet werden kann. Dieser Code enthält immer das Wort **CMDLINE** als erstes Element.

# BEISPIELE

## Cmdline::getoptions

Dieses Beispiel, das aus dem Paket **fileutil** stammt und leicht angepasst wurde, veranschaulicht die Verwendung von **cmdline::getoptions**. Zunächst wird eine Liste mit Optionen erstellt, anschließend wird die „args“-Liste zur Verarbeitung an **cmdline** übergeben. Danach werden verschiedene Optionen überprüft, um festzustellen, ob sie an das Skript übergeben wurden und welchen Wert sie haben.

```
        package require Tcl 8.5
        package require try         ;# Tcllib.
        package require cmdline 1.5 ;# First version with proper error-codes.

        # Notes:
        # - Tcl 8.6+ has 'try' as a builtin command and therefore does not
        #   need the 'try' package.
        # - Before Tcl 8.5 we cannot support 'try' and have to use 'catch'.
        #   This then requires a dedicated test (if) on the contents of
        #   ::errorCode to separate the CMDLINE USAGE signal from actual errors.

        set options {
            {a          "set the atime only"}
            {m          "set the mtime only"}
            {c          "do not create non-existent files"}
            {r.arg  ""  "use time from ref_file"}
            {t.arg  -1  "use specified time"}
        }
        set usage ": MyCommandName \[options] filename ...\noptions:"

        try {
            array set params [::cmdline::getoptions argv $options $usage]

	    # Note: argv is modified now. The recognized options are
	    # removed from it, leaving the non-option arguments behind.
        } trap {CMDLINE USAGE} {msg o} {
            # Trap the usage signal, print the message, and exit the application.
            # Note: Other errors are not caught and passed through to higher levels!
	    puts $msg
	    exit 1
        }

        if {  $params(a) } { set set_atime "true" }
        set has_t [expr {$params(t) != -1}]
        set has_r [expr {[string length $params(r)] > 0}]
        if {$has_t && $has_r} {
            return -code error "Cannot specify both -r and -t"
        } elseif {$has_t} {
	    ...
        }
```

## Cmdline::getopt

Dieses Beispiel zeigt die Kernschleife von **cmdline::getoptions** aus dem vorherigen Beispiel. Es veranschaulicht, wie dabei **cmdline::get** verwendet wird, um die Optionen nacheinander zu verarbeiten.

```
    while {[set err [getopt argv $opts opt arg]]} {
	if {$err < 0} {
            set result(?) ""
            break
	}
	set result($opt) $arg
    }
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *cmdline* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge
