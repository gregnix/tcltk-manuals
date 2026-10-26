---
CommandName: tepam
title: tepam
ManualSection: n
Version: 0.5.4
TclPart: tcllib
TclDescription: Tcl's Enhanced Procedure and Argument Manager
Links:
 - tepam::argument_dialogbox(n)
 - tepam::procedure(n)
Keywords:
 - argument integrity
 - argument validation
 - arguments
 - entry mask
 - parameter entry form
 - procedure
 - subcommand
Copyright:
 - Copyright (c) 2009-2013, Andreas Drollinger
---

# Name

tepam – Eine Einleitung in TEPAM, den erweiterten Manager für Prozeduren und Argumente von Tcl

# Beschreibung

Dieses Dokument bietet eine informelle Einleitung in TEPAM, den „Enhanced Procedure and Argument Manager“ von Tcl. Ausführliche Informationen zum TEPAM-Paket finden Sie in den Referenzhandbüchern *tepam::procedure* und *tepam::argument\_dialogbox*.

# Überblick

Dieses Paket bietet eine neue Syntax für die Deklaration von Tcl-Prozeduren, die die Implementierung von Unterbefehlen für Prozeduren sowie den Umgang mit den verschiedenen Arten von Prozedurargumenten – wie Flags oder Schalter, Optionen, unbenannte Argumente, optionale und obligatorische Optionen und Argumente, Vorgabewerte usw. – vereinfacht. Prozedurdeklarationen können um detaillierte Informationen zur Prozedur und ihren Argumenten ergänzt werden. Diese Informationen werden für folgende Zwecke verwendet:

Zunächst wird vor den Körper einer mit TEPAM deklarierten Prozedur eine Präambel gesetzt. Diese Präambel ruft einen Argumentmanager auf, der anhand der bereitgestellten Informationen die Gültigkeit der Argumenttypen und -werte überprüft, bevor der Prozedurkörper ausgeführt wird. Außerdem werden diese Informationen verwendet, um auf Wunsch Hilfe- und Verwendungstexte zu generieren oder um klare Fehlermeldungen auszugeben, falls die Validierung der Argumente fehlschlägt. Die Informationen ermöglichen zudem die automatische Erstellung grafischer Formulare, die eine interaktive Definition aller Argumente ermöglichen, wenn eine Prozedur interaktiv aufgerufen wird. Und schließlich tragen die zusätzlichen Informationen dazu bei, die Deklaration einer Prozedur und aller ihrer Argumente auf übersichtliche Weise selbst zu kommentieren.

Der grafische Formulargenerator, der die erforderlichen Formulare zur Argumentspezifikation für die interaktiven Aufrufe einer Prozedur erstellt, steht auch für andere Zwecke als die Spezifikation von Prozedurargumenten zur Verfügung. Er ermöglicht die effiziente Erstellung komplexer Formulare zur Parametereingabe, die unabhängig von der neuen Methode zur Definition von Prozeduren in TEPAM verwendet werden können.

Hier ein kurzer Überblick über alle wichtigen Funktionen von TEPAM:

- Neue Syntax für selbstdokumentierende Prozedurdeklarationen: Die zusätzlichen Informationen, die für eine korrekte Deklaration einer Prozedur erforderlich sind, müssen nicht mehr durch zusätzliche Anweisungen bereitgestellt werden, sondern können in einer natürlichen Syntax direkt in den Prozedurkopf eingefügt werden.

- Einfache Methode zur Definition von Unterbefehlen: Ein Unterbefehl wird wie eine Prozedur deklariert, und zwar einfach mit einem Namen der Prozedur, der sich aus einem Basisnamen und einem daran anschließenden Namen des Unterbefehls zusammensetzt. Unter-Unterbefehle werden auf identische Weise erstellt, indem einfach Namen der Prozeduren verwendet werden, die aus drei Wörtern bestehen.

- Flexible Verwendung von Flags (Schaltern), Optionen (benannte Argumente) und unbenannten Argumenten. Optionsnamen werden optional automatisch vervollständigt.

- Unterstützung für Vorgabewerte, obligatorische bzw. optionale Optionen und Argumente, Auswahllisten, Wertebereiche sowie mehrfach verwendbare Optionen und Argumente.

- Wahl zwischen dem Aufrufstil *benannte Argumente zuerst, unbenannte Argumente danach* (typisch für Tcl-Befehle) und dem Aufrufstil *unbenannte Argumente zuerst, benannte Argumente danach* (typisch für Tk-Befehle).

- Falls der Stil *benannte Argumente zuerst, unbenannte Argumente danach* (Tcl) ausgewählt ist:  Klare Trennung zwischen Optionen und Argumenten durch das Flag „--“. Auf die unbenannten Argumente kann optional als Optionen (benannte Argumente) zugegriffen werden.

- Automatische Typ- und Wertprüfung vor der Ausführung des Prozedurkörpers unter Berücksichtigung von Validierungsbereichen, Auswahllisten und benutzerdefinierten Validierungsbefehlen. Bei Bedarf Generierung einer eindeutigen Fehlermeldung.

- Es gibt zahlreiche vordefinierte Typen (integer, boolean, double, color, file, font, …). Weitere anwendungsspezifische Typen lassen sich problemlos hinzufügen.

- Automatische Generierung von Hilfe- und Verwendungstexten, wenn eine Prozedur mit dem Flag *-help* aufgerufen wird.

- Automatische Erstellung eines interaktiven Formulars zur Definition der Argumente, falls eine Prozedur mit dem Flag *-interactive* aufgerufen wird.

- Prozeduraufrufe können protokolliert werden, was nützlich ist, um bei interaktiv aufgerufenen Prozeduren die Befehlszeilen des Aufrufs zu erhalten.

- Leistungsstarke und codeeffiziente Generierung komplexer Formulare zur Definition von Parametern.


# Prozedurdeklaration

Die Syntax für die Deklaration einer Prozedur in TEPAM ist einfach und selbsterklärend. Anstatt eine Prozedur mit dem Tcl-Schlüsselwort **proc** zu deklarieren, wird eine Prozedur mit dem TEPAM-Befehl **procedure** deklariert, der wie **proc** ebenfalls drei Argumente benötigt: den Namen der Prozedur, den Prozedurkopf und den Prozedurkörper.

Im folgenden Beispiel wird der Unterbefehl **message** der Prozedur **display** deklariert. Dieser Befehl verfügt über mehrere benannte und unbenannte Argumente:

```
tepam::procedure {display message} {
   -return            -
   -short_description "Displays a simple message box"
   -description       "This procedure allows displaying a configurable message box."
   -args {
      {-mtype -default Warning -choices {Info Warning Error} -description "Message type"}
      {-font -type font -default {Arial 10 italic} -description "Message text font"}
      {-level -type integer -optional -range {1 10} -description "Message level"}
      {-fg -type color -default black -description "Message color"}
      {-bg -type color -optional -description "Background color"}
      {-no_border -type none -description "Use a splash window style (no border)"}
      {-log_file -type file -optional -description "Optional message log file"}
      {text -type string -multiple -description "Multiple text lines to display"}
   }
} {
   puts "display message:"
   foreach var {mtype font level fg bg no_border log_file text} {
      if {[info exists $var]} {
         puts  "  $var=[set $var]"
      }
   }
}
```

Ein Aufruf einer auf diese Weise deklarierten Prozedur ruft zunächst den TEPAM-Argumentmanager auf, bevor der Prozedurkörper ausgeführt wird. Der Argumentmanager analysiert die übergebenen Argumente, validiert sie, ergänzt sie gegebenenfalls um Vorgabewerte und stellt sie schließlich dem Prozedurkörper als lokale Variablen zur Verfügung. Falls ein Argument fehlt oder einen falschen Typ aufweist, generiert der Argumentmanager eine Fehlermeldung, die den Grund für den Fehler erläutert.

Wie das obige Beispiel zeigt, akzeptiert der TEPAM-Befehl **procedure** Unterbefehlsdefinitionen als Prozedurnamen und ermöglicht es, weitaus mehr Informationen als nur die Argumentliste im Prozedurkopf zu definieren. Der Prozedurkörper hingegen ist bei einem mit **proc** deklarierten Befehl identisch mit dem eines mit **procedure** deklarierten Befehls.

Der Prozedurkopf ermöglicht es, zusätzlich zu den Argumenten einige Prozedurattribute zu definieren, wie beispielsweise eine Beschreibung, Angaben zum Rückgabewert usw. Diese Informationen werden im Wesentlichen für die automatische Generierung umfassender Hilfe- und Verwendungstexte verwendet.

Eine Liste von Anweisungen zur Definition von Argumenten, die dem Argument *-args* zugewiesen wird, definiert die Argumente der Prozedur. Jede Anweisung zur Definition eines Arguments beginnt mit dem Namen des Arguments, auf den optional einige Argumentattribute folgen.

Es lassen sich drei Arten von Argumenten definieren: unbenannte Argumente, benannte Argumente und Flags. Die Unterscheidung zwischen benannten und unbenannten Argumenten erfolgt anhand des ersten Zeichens des Argumentnamens, das bei benannten Argumenten einfach „-“ lautet. Ein Flag ist definiert als ein benanntes Argument vom Typ *none*.

Benannte und unbenannte Argumente sind obligatorisch, es sei denn, sie werden mit dem Flag *-optional* deklariert oder es wurde für sie ein Vorgabewert mit der Option *-default* festgelegt. Benannte Argumente und das letzte unbenannte Argument können das Attribut *-multiple* aufweisen, was bedeutet, dass sie mehrfach definiert werden können. Der erwartete Datentyp des Arguments wird mit der Option *-type* festgelegt. TEPAM definiert eine große Auswahl an Standarddatentypen, die problemlos durch anwendungsspezifische Datentypen ergänzt werden können.

Die Reihenfolge der Argumentdeklarationen ist nur für unbenannte Argumente von Bedeutung, die standardmäßig nach den benannten Argumenten ausgewertet werden (Tcl-Stil). Mit einer Variable lässt sich dieses Verhalten so ändern, dass unbenannte Argumente vor den benannten Argumenten ausgewertet werden (Tk-Stil).

# Hilfe zur Prozedur

Die deklarierte Prozedur kann einfach mit der Option *-help* aufgerufen werden, um Informationen über die Verwendung der Prozedur und ihrer Argumente abzurufen:

```
display message -help
  ->
NAME
      display message - Displays a simple message box
SYNOPSYS
      display message
            [-mtype <mtype>] :
               Message type, default: "Warning", choices: {Info Warning Error}
            [-font <font>] :
               Message text font, type: font, default: Arial 10 italic
            [-level <level>] :
               Message level, type: integer, range: 1..10
            [-fg <fg>] :
               Message color, type: color, default: black
            [-bg <bg>] :
               Background color, type: color
            [-no_border ] :
               Use a splash window style (no border)
            [-log_file <log_file>] :
               Optional message log file, type: file
            <text> :
               Multiple text lines to display, type: string
DESCRIPTION
      This procedure allows displaying a configurable message box.
```

# Prozedurenaufruf

Die angegebene Prozedur kann auf vielfältige Weise aufgerufen werden. Das folgende Listing zeigt einige gültige Prozeduraufrufe:

```
display message "The document hasn't yet been saved!"
-> display message:
     mtype=Warning
     font=Arial 10 italic
     fg=black
     no_border=0
     text={The document hasn't yet been saved!}

display message -fg red -bg black "Please save first the document"
-> display message:
     mtype=Warning
     font=Arial 10 italic
     fg=red
     bg=black
     no_border=0
     text={Please save first the document}

display message -mtype Error -no_border "Why is here no border?"
-> display message:
     mtype=Error
     font=Arial 10 italic
     fg=black
     no_border=1
     text={Why is here no border?}

display message -font {Courier 12} -level 10 \
   "Is there enough space?" "Reduce otherwise the font size!"
-> display message:
     mtype=Warning
     font=Courier 12
     level=10
     fg=black
     no_border=0
     text={Is there enough space?} {Reduce otherwise the font size!}
```

Die folgenden Zeilen veranschaulichen, wie fehlerhafte Argumente erkannt werden. Das obligatorische Argument *text* fehlt beim ersten Prozeduraufruf:

```
display message -font {Courier 12}
  -> display message: Required argument is missing: text
```

Es werden nur bekannte Argumente akzeptiert:

```
display message -category warning Hello
  -> display message: Argument '-category' not known
```

Argumenttypen werden automatisch überprüft, und es wird eine Fehlermeldung ausgegeben, falls der Wert des Arguments nicht den erwarteten Typ aufweist:

```
display message -fg MyColor "Hello"
  -> display message: Argument 'fg' requires type 'color'.  Provided value: 'MyColor'
```

Auswahllisten müssen eingehalten werden …

```
display message -mtype Fatal Hello
  -> display message: Argument (mtype) has to be one of the  following elements: Info, Warning, Error
```

... sowie gültige Wertebereiche:

```
display message -level 12 Hello
  -> display message: Argument (level) has to be between 1 and 10
```

# Interaktive Prozedurenaufrufe

Die intuitivste Art, die Prozedur aufzurufen, ist die Verwendung eines Formulars, in dem alle Argumente interaktiv festgelegt werden können. Dieses Formular wird automatisch generiert, wenn die deklarierte Prozedur mit dem Flag *-interactive* aufgerufen wird. Um diese Funktion nutzen zu können, muss die Tk-Bibliothek geladen sein.

```
display message -interactive
```

Das generierte Formular enthält für jedes Argument ein Dateneingabe-Widget, das an den jeweiligen Argumenttyp angepasst ist. Zur Festlegung von Flags werden Checkbuttons verwendet, für kleine Auswahllisten Radioboxen, für größere Auswahllisten disjunkte Listboxen, und Dateien, Verzeichnisse, Schriftarten und Farben lassen sich mit eigenen Auswahldialogen (Browsern) auswählen.

Nachdem die angegebenen Argumentdaten über eine „OK“-Schaltfläche bestätigt wurden, werden die eingegebenen Daten zunächst validiert, bevor die angegebenen Argumente in lokale Variablen umgewandelt und der Prozedurkörper ausgeführt wird. Sollten die eingegebenen Daten ungültig sein, erscheint eine Meldung, und der Benutzer kann diese korrigieren, bis sie gültig sind.

Die Prozeduraufrufe können optional in einer Variablen protokolliert werden. Dies ist beispielsweise nützlich, um die Befehlszeilen von interaktiv aufgerufenen Prozeduren abzurufen.

# Flexible Argument-Dialogbox

Der Formulargenerator, der im vorangegangenen Beispiel die Argument-Dialogbox für den interaktiven Aufruf einer Prozedur erstellt, steht auch für andere Zwecke als die Definition von Prozedurargumenten zur Verfügung. Wenn Tk geladen wurde, stellt TEPAM eine Argument-Dialogbox bereit, mit dem sich komplexe Parameterdefinitionsformulare auf sehr effiziente Weise erstellen lassen.

Das folgende Beispiel soll veranschaulichen, wie einfach es ist, komplexe Eingabeformulare zu erstellen. Es erstellt eine Eingabemaske, über die eine zu kopierende Datei sowie ein Zielverzeichnis angegeben werden können, und enthält zudem eine Checkbox, mit der festgelegt werden kann, ob eine eventuell bereits vorhandene Datei überschrieben werden darf. Zur Auswahl von Dateien und Verzeichnissen stehen benutzerfreundliche Browser zur Verfügung. Und schließlich bietet das Formular auch die Möglichkeit, die Auswahl zu bestätigen oder abzulehnen. Hier ist der Codeausschnitt, der all dies umsetzt:

```
tepam::argument_dialogbox \
   -existingfile {-label "Source file" -variable SourceFile} \
   -existingdirectory {-label "Destination folder" -variable DestDir} \
   -checkbutton {-label "Overwrite existing file" -variable Overwrite}
```

Der Befehl **argument\_dialogbox** gibt **ok** zurück, wenn die eingegebenen Daten validiert wurden. Er gibt **cancel** zurück, wenn die Dateneingabe abgebrochen wurde. Nach der Validierung der eingegebenen Daten definiert **argument\_dialogbox** alle angegebenen Variablen mit den eingegebenen Daten im aufrufenden Kontext.

Der Befehl **argument\_dialogbox** benötigt für jede Variable, die er verarbeiten soll, ein Argumentpaar. Das erste Argument definiert den Typ des Eingabe-Widgets, mit dem der Wert der Variable ausgewählt wird, und das zweite Argument ist eine Liste von Attributen, die sich auf die Variable und das Eingabe-Widget beziehen.

Es stehen zahlreiche Arten von Eingabe-Widgets zur Verfügung: Neben den einfachen generischen Eingabefeldern gibt es verschiedene Arten von Listen- und Kombinationsfeldern, Browser für vorhandene und neue Dateien und Verzeichnisse, Check- und Radioboxen und -buttons sowie Farb- und Schriftartenauswahlfelder. Bei Bedarf können zusätzliche Eingabe-Widgets definiert werden.

Die Attributliste enthält Paare aus Attributnamen und Attributdaten. Das primäre Attribut ist *-variable*, mit dem die Variable im aufrufenden Kontext festgelegt wird, in der die eingegebenen Daten gespeichert werden sollen. Ein weiteres häufig verwendetes Attribut ist *-label*, mit dem dem Dateneingabe-Widget eine Beschriftung hinzugefügt werden kann. Es stehen weitere Attribute zur Verfügung, mit denen Vorgabewerte, die erwarteten Datentypen, gültige Datenbereiche usw. festgelegt werden können.

Das folgende Beispiel für eine komplexere Argument-Dialogbox bietet einen guten Überblick über die verschiedenen verfügbaren Eingabe-Widget-Typen und Parameterattribute. Das Beispiel enthält zudem einige Formatierungsanweisungen wie *-frame* und *-sep*, die es ermöglichen, die verschiedenen Eingabe-Widgets in Rahmen und Abschnitten zu organisieren:

```
set ChoiceList {"Choice 1" "Choice 2" "Choice 3" "Choice 4" "Choice 5" "Choice 6"}

set Result [tepam::argument_dialogbox \
   -title "System configuration" \
   -context test_1 \
   -frame {-label "Entries"} \
      -entry {-label Entry1 -variable Entry1} \
      -entry {-label Entry2 -variable Entry2 -default "my default"} \
   -frame {-label "Listbox & combobox"} \
      -listbox {-label "Listbox, single selection" -variable Listbox1 \
                -choices {1 2 3 4 5 6 7 8} -default 1 -height 3} \
      -listbox {-label "Listbox, multiple selection" -variable Listbox2
                -choicevariable ChoiceList -default {"Choice 2" "Choice 3"}
                -multiple_selection 1 -height 3} \
      -disjointlistbox {-label "Disjoined listbox" -variable DisJntListbox
                        -choicevariable ChoiceList \
                        -default {"Choice 3" "Choice 5"} -height 3} \
      -combobox {-label "Combobox" -variable Combobox \
                 -choices {1 2 3 4 5 6 7 8} -default 3} \
   -frame {-label "Checkbox, radiobox and checkbutton"} \
      -checkbox {-label Checkbox -variable Checkbox
                 -choices {bold italic underline} -choicelabels {Bold Italic Underline} \
                 -default italic} \
      -radiobox {-label Radiobox -variable Radiobox
                 -choices {bold italic underline} -choicelabels {Bold Italic Underline} \
                 -default underline} \
      -checkbutton {-label CheckButton -variable Checkbutton -default 1} \
   -frame {-label "Files & directories"} \
      -existingfile {-label "Input file" -variable InputFile} \
      -file {-label "Output file" -variable OutputFile} \
      -sep {} \
      -existingdirectory {-label "Input directory" -variable InputDirectory} \
      -directory {-label "Output irectory" -variable OutputDirectory} \
   -frame {-label "Colors and fonts"} \
      -color {-label "Background color" -variable Color -default red} \
      -sep {} \
      -font {-label "Font" -variable Font -default {Courier 12 italic}}]
```

Der Befehl **argument\_dialogbox** belegt alle angegebenen Variablen mit den eingegebenen Daten und gibt **ok** zurück, wenn die Daten über die Schaltfläche „OK“ bestätigt wurden. Wenn die Dateneingabe mit der Schaltfläche „Cancel“ abgebrochen wird, gibt **argument\_dialogbox** **cancel** zurück.

```
if {$Result=="cancel"} {
   puts "Canceled"
} else { # $Result=="ok"
   puts "Arguments: "
   foreach Var {
      Entry1 Entry2
      Listbox1 Listbox2 DisJntListbox
      Combobox Checkbox Radiobox Checkbutton
      InputFile OutputFile InputDirectory OutputDirectory
      Color Font
   } {
      puts "  $Var: '[set $Var]'"
   }
}
-> Arguments:
   Entry1: 'Hello, this is a trial'
   Entry2: 'my default'
   Listbox1: '1'
   Listbox2: '{Choice 2} {Choice 3}'
   DisJntListbox: '{Choice 3} {Choice 5}'
   Combobox: '3'
   Checkbox: 'italic'
   Radiobox: 'underline'
   Checkbutton: '1'
   InputFile: 'c:\tepam\in.txt'
   OutputFile: 'c:\tepam\out.txt'
   InputDirectory: 'c:\tepam\input'
   OutputDirectory: 'c:\tepam\output'
   Color: 'red'
   Font: 'Courier 12 italic'
```

# Kategorie

Prozeduren, Argumente, Parameter, Optionen

# Copyright

```
Copyright (c) 2009-2013, Andreas Drollinger
```
