---
CommandName: tepam::argument_dialogbox
title: tepam::argument_dialogbox
ManualSection: n
Version: 0.5.0
TclPart: tcllib
TclDescription: Tcl's Enhanced Procedure and Argument Manager
Links:
 - tepam(n)
 - tepam::procedure(n)
Keywords:
 - data entry form
 - parameter entry form
Copyright:
 - Copyright (c) 2009-2013, Andreas Drollinger
---

# Name

tepam::argument\_dialogbox – TEPAM argument\_dialogbox, Referenzhandbuch

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.3]{.lit}
[package]{.cmd} [require]{.sub} [tepam]{.lit} [0.5]{.optlit}
[tepam::argument\_dialogbox]{.cmd} [item\_name]{.arg} [item\_attributes]{.arg} [item\_name item\_attributes]{.optarg} ?...?
[tepam::argument\_dialogbox]{.cmd} [{item\_name item\_attributes ?item\_name item\_attributes? ?...?}]{.arg}
:::

# Beschreibung

# Aufruf der Argument-Dialogbox

Der TEPAM-Befehl **argument\_dialogbox** ist ein flexibler und einfach zu verwendender Generator für Dateneingabeformulare, der zur Verfügung steht, wenn Tk geladen wurde. Jedes Eingabefeld eines Formulars wird über ein *Dateneingabeelement* definiert, das an **argument\_dialogbox** in zwei Formaten übergeben werden kann:

**tepam::argument\_dialogbox** *item\_name item\_attributes ?item\_name item\_attributes? ?...?*
: Bei diesem ersten Format wird jedes *Dateneingabeelement* über ein Paar aus zwei Argumenten definiert. Das erste Argument ist der *Elementname*, der das im Formular zu verwendende Eingabe-Widget festlegt. Das zweite Argument, die sogenannten *Elementattribute*, legt die Variable fest, die dem Dateneingabeelement zugewiesen wird, sowie eventuelle Formatierungs- und Kontextinformationen.

    Der Befehl **argument\_dialogbox** gibt **ok** zurück, wenn die eingegebenen Daten (über die Schaltfläche *OK*) bestätigt und durch eine Datenprüfung validiert wurden. Wenn die eingegebenen Daten verworfen werden (über die Schaltfläche *Cancel*), gibt **argument\_dialogbox** **cancel** zurück.

    Ein kleines Beispiel veranschaulicht, wie **argument\_dialogbox** eingesetzt werden kann:

    ```
    set DialogResult [tepam::argument_dialogbox \
       -title "Itinerary selection" \
       -file {-label "Itinerary report" -variable report_file} \
       -frame {-label "Itinerary start"} \
          -comment {-text "Specify your itinerary start location"} \
          -entry {-label "City" -variable start_city -type string} \
          -entry {-label "Street" -variable start_street -type string -optional 1} \
          -entry {-label "Street number" -variable start_street_nbr -type integer -optional 1} \
       -frame {-label "Itinerary destination"} \
          -comment {-text "Specify your itinerary destination"} \
          -entry {-label "City" -variable dest_city -type string} \
          -entry {-label "Street" -variable dest_street -type string -optional 1} \
          -entry {-label "Street number" -variable dest_street_nbr -type integer -optional 1} \
       -frame {} \
       -checkbutton {-label "Don't use highways" -variable no_highway}]
    ```

    In diesem Beispiel wird eine Dialogbox mit dem Titel *Itinerary selection* geöffnet. Ein erstes Eingabe-Widget in dieser Box ermöglicht die Auswahl einer Berichtsdatei. Es folgen zwei Rahmen, in denen jeweils der Start- und der Zielort der Route festgelegt werden. Jeder dieser Orte, die mit einem Kommentar beschrieben sind, verfügt über drei Eingabe-Widgets zur Angabe der Stadt, der Straße und der Hausnummer. Unterhalb des zweiten Rahmens befindet sich ein Checkbutton, mit dem festgelegt werden kann, ob eventuelle Autobahnen ignoriert werden sollen.

**tepam::argument\_dialogbox** {*item\_name item\_attributes ?item\_name item\_attributes? ?...?*}
: Manchmal ist es einfacher, alle Definitionen der Dateneingabeelemente in Form einer einzigen Liste an **argument\_dialogbox** zu übergeben und nicht als einzelne Argumente. Das zweite von **argument\_dialogbox** unterstützte Format entspricht genau dem ersten, mit dem Unterschied, dass alle Elementdefinitionen in einer einzigen Liste zusammengefasst sind, die an **argument\_dialogbox** übergeben wird. Das vorangegangene Beispiel lässt sich daher auch wie folgt schreiben:

    ```
    set DialogResult [tepam::argument_dialogbox {
       -title "Itinerary selection"
       -file {-label "Itinerary report" -variable report_file}
       ...
       -checkbutton {-label "Don't use highways" -variable no_highway} }]
    ```


Die Befehle **argument\_dialogbox** sowie **procedure** werden aus dem Namespace [tepam][tepam_introduction] exportiert. Um diese Befehle ohne das Namespace-Präfix **tepam::** zu verwenden, reicht es aus, sie in den Haupt-Namespace zu importieren:

```
namespace import tepam::*

set DialogResult [argument_dialogbox \
   -title "Itinerary selection"
   ...
```

In den folgenden Unterabschnitten werden die verschiedenen Typen von Argumentelementen erläutert, die **argument\_dialogbox** akzeptiert, eingeteilt in drei Gruppen. Im weiteren Verlauf dieses Dokuments wird das erste Format zur Definition von Dateneingabeelementen verwendet, wobei dieses Format jederzeit in das zweite Format umgewandelt werden kann, indem alle Argumente in eine einzige Liste zusammengefasst werden, die anschließend an **argument\_dialogbox** übergeben wird.

## Elemente zur Definition des Kontexts

Mit der ersten Elementgruppe lassen sich einige Kontextaspekte einer Argument-Dialogbox festlegen. Diese Elemente nehmen eine einfache Zeichenkette als Elementattribut entgegen:

```
tepam::argument_dialogbox \
   -<argument_name> string \
   ...
```

Die folgenden Elemente werden dieser Gruppe zugeordnet:

-title *string*
: Der Fenstertitel der Dialogbox, der standardmäßig *Dialog* lautet, kann über das Element *-title* geändert werden:

    ```
    tepam::argument_dialogbox \
       -title "System configuration" \
       ...
    ```

-window *string*
: Die Argument-Dialogbox verwendet standardmäßig *.dialog* als Toplevel-Fenster des Dialogs. Dieser Pfad kann über das Element *-window* geändert werden:

    ```
    tepam::argument_dialogbox \
       -window .dialog \
       ...
    ```

-parent *string*
: Wird ein Elternfenster festgelegt, wird die Argument-Dialogbox neben diesem angezeigt. Ohne explizite Festlegung eines Elternfensters gilt das Toplevel-Fenster als Elternfenster.

    ```
    tepam::argument_dialogbox \
       -parent .my_appl \
       ...
    ```

-context *string*
: Wenn ein Kontext definiert ist, wird der Zustand der Dialogbox – d. h. die eingegebenen Daten sowie die Fenstergröße und -position – beim nächsten Aufruf der Argument-Dialogbox wiederhergestellt. Durch die Zuweisung eines Kontexts kann der Zustand der Dialogbox in ihrem Kontext gespeichert werden, um zwischen verschiedenen Verwendungen der Argument-Dialogbox zu unterscheiden.

    ```
    tepam::argument_dialogbox \
       -context destination_definitions \
       ...
    ```


## Formatierungs- und Anzeigeoptionen

Insbesondere bei großen, komplexen Formularen ist es wichtig, dass die verschiedenen Dateneingabe-Widgets grafisch übersichtlich angeordnet und mit Erläuterungen versehen sind, um dem Benutzer einen sofortigen und klaren Überblick zu verschaffen. Es stehen einige Elemente zur Verfügung, mit denen sich die Dialogboxen strukturieren und mit Erläuterungen versehen lassen.

Die Elemente dieser Klassifizierungsgruppe erfordern als Elementattribute eine Liste mit Definitionen, die ihrerseits Attribut-Name-Wert-Paare enthält:

```
tepam::argument_dialogbox \
   ...
   -<argument_name> {
      ?-<attribute_name> <attribute_value>?
      ?-<attribute_name> <attribute_value>?
      ?...?
   }
   ...
```

Die folgenden Elemente werden dieser Gruppe zugeordnet:

-frame *list*
: Das Element *-frame* ermöglicht es, alle nachfolgenden Eingabe-Widgets in einen beschrifteten Rahmen zu packen, bis ein nächstes Rahmenelement definiert wird oder bis das letzte Eingabe-Widget definiert wurde. Es erkennt die folgenden Attribute innerhalb der Attributliste des Elements:

    -label *string*
    : Mit der Anweisung *-label* kann eine optionale Rahmenbeschriftung festgelegt werden.


    Beispiel:

    ```
    tepam::argument_dialogbox \
       ...
       -frame {-label "Destination address"}
       ...
    ```

    Um einen offenen Rahmen zu schließen, ohne einen neuen zu öffnen, muss der Anweisung *-frame* eine leere Liste übergeben werden.

    ```
    tepam::argument_dialogbox \
       ...
       -frame {}
       ...
    ```

-sep \[const {{}}\]
: Eingabe-Widgets können mit der Anweisung *-sep* getrennt werden, wofür keine zusätzlichen Definitionen erforderlich sind. Die zugehörige Definitionsliste muss vorhanden sein, ihr Inhalt wird jedoch ignoriert.

    ```
    tepam::argument_dialogbox \
       ...
       -sep {}
       ...
    ```

-comment *string*
: Kommentare und Beschreibungen können über das Attribut *-text* des Elements *-comment* hinzugefügt werden. Beachten Sie, dass jedes Eingabe-Widget selbst ebenfalls ein *-text*-Attribut für Kommentare und Beschreibungen enthalten kann. Das Element *-comment* ermöglicht es jedoch beispielsweise, eine Beschreibung zwischen zwei Rahmen einzufügen.

    ```
    tepam::argument_dialogbox \
       ...
       -comment {-text "Specify bellow the destination address"}
       ...
    ```

-yscroll **0**|**1**|**auto**
: Mit diesem Attribut lässt sich eine eventuell vorhandene vertikale Bildlaufleiste steuern. Durch die Einstellung auf **0** wird die Bildlaufleiste dauerhaft deaktiviert, durch die Einstellung auf **1** wird sie aktiviert. Standardmäßig ist der Wert auf **auto** gesetzt. Die Bildlaufleiste wird in diesem Modus nur dann aktiviert, wenn die vertikale Größe des Dateneingabeformulars 66 % der Bildschirmhöhe überschreitet.

    ```
    tepam::argument_dialogbox \
       ...
       -yscroll auto
       ...
    ```


## Globale benutzerdefinierte Validierung der Daten

Mit dieser Elementgruppe lassen sich globale benutzerdefinierte Prüfungen festlegen, um die eingegebenen Daten zu validieren.

-validatecommand *script*
: Benutzerdefinierte Datenprüfungen können über Validierungsbefehle durchgeführt werden, die mit dem Element *-validatecommand* definiert werden. Beispiel:

    ```
    tepam::argument_dialogbox \
       -entry {-label "Your comment" -variable YourCom} \
       -validatecommand {IllegalWordDetector $YourCom}
    ```

    Der Validierungsbefehl wird im Kontext der aufrufenden Prozedur ausgeführt, sobald alle grundlegenden Datenprüfungen durchgeführt und die Datenvariablen zugewiesen wurden. Der Zugriff auf alle Daten erfolgt über die Datenvariablen. Beachten Sie, dass es auch ein Eingabe-Widget-spezifisches Attribut *-validatecommand* gibt, mit dem benutzerdefinierte Prüfungen für bestimmte Dateneingaben festgelegt werden können.

    Das Attribut *-validatecommand* kann wiederholt werden, um mehrere benutzerdefinierte Prüfungen festzulegen.

-validatecommand\_error\_text *string*
: Mit diesem Element lässt sich die Standardfehlermeldung für eine globale benutzerdefinierte Validierung des Arguments (definiert durch *-validatecommand*) überschreiben. Außerdem kann dieses Attribut wiederholt werden, falls mehrere Prüfungen deklariert sind.

-validatecommand2 *script*
: siehe unten ...

-validatecommand2\_error\_text *string*
: Diese Elemente sind hauptsächlich für den internen Gebrauch in TEPAM bestimmt.

    Sie entsprechen jeweils den Elementen *-validatecommand* und *-validatecommand\_error\_text*. Die Validierung der Daten erfolgt jedoch nicht auf der nächsthöheren Stapelebene, sondern zwei Stapelebenen höher.


## Elemente für Dateneingabe-Widgets

Dateneingabe-Widgets werden mithilfe der Widget-Elemente erstellt. Diese Elemente erfordern als Elementattribute eine Liste der Definitionen, die wiederum Attribut-Name-Wert-Paare enthält:

```
tepam::argument_dialogbox \
   ...
   -<argument_name> {
      ?-<attribute_name> <attribute_value>?
      ?-<attribute_name> <attribute_value>?
      ?...?
   }
   ...
```

Die Attributliste kann verschiedene Attribute enthalten, um ein Eingabe-Widget zu beschreiben und zu kommentieren sowie dessen eingegebenen Wert einzuschränken. Alle Eingabe-Widgets akzeptieren einen gemeinsamen Satz von Attributen, die im Abschnitt [Attribute der Eingabe-Widget-Elemente] beschrieben sind.

TEPAM definiert eine umfangreiche Sammlung von Eingabe-Widgets. Wenn Bedarf besteht, kann diese Sammlung um weitere anwendungsspezifische Eingabe-Widgets erweitert werden (siehe [Anwendungsspezifische Eingabe-Widgets]):

-entry *list*
: Das Element *-entry* erzeugt das einfachste, aber universellste Dateneingabe-Widget. Es ermöglicht die Eingabe beliebiger Daten in Form von einzeiligen Zeichenfolgen.

    ```
    tepam::argument_dialogbox \
       -entry {-label Name -variable Entry}
    ```

-text *list*
: Das Element *-text* erzeugt ein Widget für mehrzeilige Texteingaben. Die Höhe des Widgets kann über das Attribut *-height* festgelegt werden.

    ```
    tepam::argument_dialogbox \
       -text {-label Name -variable Text -height 5}
    ```

-checkbox *list*
: Mit dem Element *-checkbox* wird eine Gruppe von Checkboxen erstellt. Die Anzahl der Checkboxen und ihre Optionswerte werden über eine dem Attribut *-choices* zugewiesene Liste oder über eine mit dem Attribut *-choicevariable* deklarierte Variable festgelegt:

    ```
    tepam::argument_dialogbox \
       -checkbox {-label "Font sytle" -variable FontStyle \
                   -choices {bold italic underline} -default italic}
    ```

    Wenn die Beschriftungen der Checkboxen von den Optionswerten abweichen sollen, können diese Beschriftungen mit dem Attribut *-choicelabels* definiert werden:

    ```
    tepam::argument_dialogbox \
       -checkbox {-label "Font sytle" -variable FontStyle \
                  -choices {bold italic underline} \
                  -choicelabels {Bold Italic Underline} \
                  -default italic}
    ```

    Im Gegensatz zu einer Radiobox-Gruppe ermöglicht eine Checkbox-Gruppe die gleichzeitige Auswahl mehrerer Auswahloptionen. Die Auswahl wird aus diesem Grund in der definierten Variablen in Form einer Liste gespeichert, auch wenn nur eine Auswahloption ausgewählt wurde.

-radiobox *list*
: Mit dem Element *-radiobox* wird eine Gruppe von Radioboxen angelegt. Die Anzahl der Radioboxen und ihre Optionswerte werden über eine dem Attribut *-choices* zugewiesene Liste oder über eine mit dem Attribut *-choicevariable* deklarierte Variable festgelegt.

    Im Gegensatz zu einer Checkbox-Gruppe erlaubt eine Radiobox-Gruppe nur die Auswahl einer einzigen Auswahloption. Der ausgewählte Optionswert wird direkt – und nicht in Form einer Liste – in der definierten Variable gespeichert.

    ```
    tepam::argument_dialogbox \
       -radiobox {-label "Text adjustment" -variable Adjustment \
                  -choices {left center right} -default left}
    ```

    Wenn sich die Beschriftungen der Radioboxen von den Optionswerten unterscheiden sollen, können diese Beschriftungen mit dem Attribut *-choicelabels* definiert werden:

    ```
    tepam::argument_dialogbox \
       -radiobox {-label "Text adjustment" -variable Adjustment \
                  -choices {left center right} \
                  -choicelabels {Left Center Right} -default left}
    ```

-checkbutton *list*
: Das Eingabe-Widget *-checkbutton* ermöglicht das Aktivieren oder Deaktivieren einer einzelnen Auswahloption. Der in die Variable geschriebene Wert lautet entweder **0**, wenn der Checkbutton nicht aktiviert wurde, oder **1**, wenn er aktiviert wurde. Ein eventuell angegebener Vorgabewert muss ebenfalls entweder **0** oder **1** lauten.

    ```
    tepam::argument_dialogbox \
       -checkbutton {-label Capitalize -variable Capitalize -default 1}
    ```


Für die Verwaltung von Auswahllisten stehen verschiedene Arten von List- und Comboboxen zur Verfügung.

-combobox *list*
: Die Combobox ist eine Kombination aus einem normalen Eingabe-Widget und einer Dropdown-Liste. Die Combobox ermöglicht die Auswahl eines einzelnen Elements aus dieser Dropdown-Liste. Die Liste der verfügbaren Elemente kann entweder als Liste für das Attribut *-choices* bereitgestellt werden oder über eine Variable, die mit dem Attribut *-choicevariable* festgelegt wird.

    ```
    tepam::argument_dialogbox \
       -combobox {-label "Text size" -variable Size -choices {8 9 10 12 15 18} -default 12}
    ```

    Und hier ist ein Beispiel für die Verwendung einer Variablen zur Definition der Auswahlliste:

    ```
    set TextSizes {8 9 10 12 15 18}
    tepam::argument_dialogbox \
       -combobox {-label "Text size" -variable Size -choicevariable TextSizes -default 12}
    ```

-listbox *list*
: Im Gegensatz zur Combobox wird die Listbox beim Eingabe-Widget *listbox* stets angezeigt. Es kann jeweils nur ein Element ausgewählt werden, es sei denn, das Attribut *-multiple\_selection* ist gesetzt. Die Höhe der Listbox kann über das Attribut *-height* festgelegt werden. Wenn die Höhe nicht explizit definiert wird, passt sich die Höhe der Listbox automatisch an die Größe der Argument-Dialogbox an. Im ersten Beispiel wird eine Variable verwendet, um die verfügbaren Auswahlmöglichkeiten zu definieren:

    ```
    set set AvailableSizes
    for {set k 0} {$k<16} {incr k} {lappend AvailableSizes [expr 1<<$k]}

    tepam::argument_dialogbox \
       -listbox {-label "Distance" -variable Distance \
                 -choicevariable AvailableSizes -default 6 -height 5}
    ```

    Hier ein Beispiel für die Auswahl mehrerer Elemente. Beachten Sie, dass auch die Vorgabeauswahl mehrere Elemente enthalten kann:

    ```
    tepam::argument_dialogbox \
       -listbox {-label "Text styles" -variable Styles \
                 -choices {bold italic underline overstrike} \
                 -choicelabels {Bold Italic Underline Overstrike} \
                 -default {bold underline} -multiple_selection 1 \
                 -height 3}
    ```

-disjointlistbox *list*
: Anstelle einer normalen Listbox muss eine disjunkte Listbox verwendet werden, wenn die Reihenfolge der Auswahl von Bedeutung ist. Das Eingabe-Widget für disjunkte Listboxen besteht eigentlich aus zwei Listboxen: einer zur Auswahl der Elemente und einer zur Anzeige der ausgewählten Elemente in der gewählten Reihenfolge.

    Disjunkte Listboxen ermöglichen stets die Auswahl mehrerer Elemente. Mit Ausnahme des Attributs *-multiple\_selection* akzeptieren disjunkte Listboxen dieselben Attribute wie normale Listboxen, z. B. *-height, -choices, -choicevariable, -default*.

    ```
    tepam::argument_dialogbox \
       -disjointlistbox {-label "Preferred scripting languages" -variable Languages \
                 -comment "Please select your preferred languages in the order" \
                 -choices {JavaScript Lisp Lua Octave PHP Perl Python Ruby Scheme Tcl} \
                 -default {Tcl Perl Python}}
    ```


Die Datei- und Verzeichnisauswahl bilden eine weitere Gruppe von Dateneingabe-Widgets. Ein Absatz im Abschnitt [Attribute der Eingabe-Widget-Elemente] erläutert die widgetspezifischen Attribute, mit denen die gewünschten Dateitypen, das aktive Verzeichnis usw. festgelegt werden können.

-file *list*
: Das Element *-file* erstellt eine Gruppe, die aus einem Eingabe-Widget und einer Schaltfläche besteht, über die ein Dateibrowser geöffnet werden kann. Für dieses Eingabefeld wird automatisch der Datentyp *file* ausgewählt, wenn kein Datentyp explizit über das Attribut *-type* definiert wurde.

    ```
    tepam::argument_dialogbox \
       -file {-label "Image file" -variable ImageF \
              -filetypes {{"GIF" {*.gif}} {"JPG" {*.jpg}}} \
              -initialfile "picture.gif"}
    ```

-existingfile *list*
: Das Element *-existingfile* erstellt eine Gruppe, die aus einem Eingabe-Widget sowie einer Schaltfläche besteht, über die ein Browser geöffnet werden kann, um eine vorhandene Datei auszuwählen. Der Datentyp *existingfile* wird für dieses Eingabefeld automatisch ausgewählt, wenn kein Datentyp explizit über das Attribut *-type* definiert wurde.

    ```
    tepam::argument_dialogbox \
       -existingfile {-label "Image file" -variable ImageF \
                      -filetypes {{"GIF" {*.gif}} {"JPG" {*.jpg}}} \
                      -initialfile "picture.gif"}
    ```

-directory *list*
: Das Element *-directory* erstellt eine Gruppe, die aus einem Eingabe-Widget und einer Schaltfläche besteht, über die ein Verzeichnisbrowser geöffnet werden kann. Für dieses Eingabefeld wird automatisch der Datentyp *directory* ausgewählt, wenn kein Datentyp explizit über das Attribut *-type* definiert wurde.

    ```
    tepam::argument_dialogbox \
       -directory {-label "Report directory" -variable ReportDir}
    ```

-existingdirectory *list*
: Das Element *-existingdirectory* erstellt eine Gruppe, die aus einem Eingabe-Widget sowie einer Schaltfläche besteht, über die ein Browser geöffnet werden kann, um ein vorhandenes Verzeichnis auszuwählen. Der Datentyp *existingdirectory* wird für dieses Eingabefeld automatisch ausgewählt, wenn kein Datentyp explizit über das Attribut *-type* definiert wurde.

    ```
    tepam::argument_dialogbox \
       -existingdirectory {-label "Report directory" -variable ReportDir}
    ```


Schließlich gibt es noch eine letzte Gruppe mit einigen weiteren speziellen Dateneingabe-Widgets.

-color *list*
: Die Farbauswahl besteht aus einem Eingabe-Widget sowie einer Schaltfläche, über die ein Farbauswahlfenster geöffnet werden kann. Für diesen Eingabe-Widget-Typ wird automatisch der Datentyp *color* ausgewählt, wenn kein Datentyp explizit über das Attribut *-type* definiert wurde.

    ```
    tepam::argument_dialogbox \
       -color {-label "Background color" -variable Color -default red}
    ```

-font *list*
: Die Schriftartauswahl besteht aus einem Eingabe-Widget sowie einer Schaltfläche, über die ein Schriftarten-Browser geöffnet werden kann. Für diesen Eingabe-Widget-Typ wird automatisch der Datentyp *font* ausgewählt, sofern kein Datentyp explizit über das Attribut *-type* definiert wurde. Das Eingabe-Widget zeigt einen Beispieltext im Format der ausgewählten Schriftart an.

    Der Schriftarten-Browser ermöglicht standardmäßig die Auswahl der vom Tk-Befehl **font families** bereitgestellten Schriftfamilien sowie einer angemessenen Auswahl verschiedener Schriftgrößen zwischen 6 und 40 Punkt. Über die Attribute *-font\_families* bzw. *-font\_sizes* können jeweils andere Sätze von Schriftfamilien und Schriftgrößen festgelegt werden.

    Wenn über das Attribut *-default* keine Vorgabeschriftart angegeben wird, wird die Standardschriftart des Label-Widgets, das die ausgewählte Schriftart anzeigt, als vorausgewählte Schriftart verwendet. Gehört die Schriftfamilie dieses Label-Widgets nicht zu den verfügbaren Familien, wird die erste verfügbare Familie als Vorgabe verwendet. Wenn die Schriftgröße dieses Label-Widgets nicht zu den verfügbaren Größen gehört, wird die nächstgelegene verfügbare Größe als Standardgröße ausgewählt.

    ```
    tepam::argument_dialogbox \
       -font {-label "Font" -variable Font \
              -font_sizes {8 10 12 16} \
              -default {Arial 20 italic}}
    ```


## Attribute der Eingabe-Widget-Elemente

Alle Eingabe-Widget-Elemente akzeptieren die folgenden Attribute:

-text *string*
: Etwaige Beschreibungen und Kommentare, die mit dem Attribut *-text* festgelegt werden, werden oberhalb des Eingabe-Widgets angezeigt.

    ```
    tepam::argument_dialogbox \
       -entry {-text "Please enter your name bellow" -variable Name}
    ```

-label *string*
: Das Attribut label erstellt links neben dem Eingabe-Widget eine Beschriftung, wobei die angegebene Zeichenfolge als Beschriftungstext verwendet wird:

    ```
    tepam::argument_dialogbox \
       -entry {-label Name -variable Name}
    ```

-variable *string*
: Alle Eingabe-Widgets erfordern die Angabe einer Variablen. Nachdem die eingegebenen Informationen über die Schaltfläche „OK“ bestätigt wurden, werden die Daten des Eingabe-Widgets in den definierten Variablen gespeichert.

    ```
    tepam::argument_dialogbox \
       -existingdirectory {-label "Report directory" -variable ReportDir}
    ```

-default *string*
: Über das Attribut *-default* können eventuelle Vorgabedaten für die Eingabe-Widgets bereitgestellt werden. Der Vorgabewert wird überschrieben, wenn eine Argument-Dialogbox mit einem definierten Kontext erneut aufgerufen wird. In diesem Fall wird der bei einem vorherigen Aufruf bestätigte Wert als Vorgabewert verwendet.

    ```
    tepam::argument_dialogbox \
       -checkbox {-label "Font sytle" -variable FontStyle \
                   -choices {bold italic underline} -default italic}
    ```

-optional **0**|**1**
: Daten können mit dem Attribut *-optional* als optional oder obligatorisch gekennzeichnet werden, wobei dieses Attribut entweder **0** (obligatorisch) oder **1** (optional) als Attributdaten erfordert.

    Falls ein Eintrag optional ist und keine Daten eingegeben wurden – d. h. der Eintrag enthält eine leere Zeichenkette –, wird der Eintrag als undefiniert betrachtet und die zugewiesene Variable wird nicht definiert.

    ```
    tepam::argument_dialogbox \
       -entry {-label "City" -variable start_city -type string} \
       -entry {-label "Street" -variable start_street -type string -optional 0} \
       -entry {-label "Street number" -variable start_street_nbr -type integer -optional 1} \
    ```

-type *string*
: Wenn der Datentyp mit dem Attribut *-type* definiert wird, führt die Argument-Dialogbox nach der Bestätigung der eingegebenen Werte und vor dem Schließen der Dialogbox automatisch eine Datentypprüfung durch. Wenn ein typinkompatibler Wert festgestellt wird, erscheint ein Fehlermeldungsfenster, und der Benutzer kann den Wert korrigieren.

    Die Argument-Dialogbox akzeptiert alle Typen, die im TEPAM-Paket festgelegt wurden und die auch von [tepam::procedure][tepam_procedure] verwendet werden (siehe das *Referenzhandbuch zu tepam::procedure*).

    Einige Eingabe-Widgets wie die Datei- und Verzeichnis-Widgets sowie die Farb- und Schriftart-Widgets legen den Standarddatentyp automatisch fest, wenn kein Typ explizit mit dem Attribut *-type* angegeben wurde.

    ```
    tepam::argument_dialogbox \
       -entry {-label "Street number" -variable start_street_nbr -type integer} \
    ```

-range *string*
: Werte können mit dem Attribut *-range* eingeschränkt werden. Der gültige Bereich wird durch eine Liste definiert, die den kleinsten und den größten gültigen Wert enthält.

    Das Attribut *-range* darf nur für numerische Argumente wie Ganzzahlen und Gleitkommazahlen verwendet werden.

    ```
    tepam::argument_dialogbox \
       -entry {-label Month -variable Month -type integer -range {1 12}}
    ```

-validatecommand *string*
: Benutzerdefinierte Validierungen von Argumentwerten können über spezifische Validierungsbefehle durchgeführt werden, die mit dem Attribut *-validatecommand* definiert sind. Der angegebene Validierungsbefehl kann ein vollständiges Skript sein, in dem das Muster *%P* als Platzhalter für den zu validierenden Wert dient.

    ```
    tepam::argument_dialogbox \
       -entry {-label "Your comment" -variable YourCom \
               -validatecommand "IllegalWordDetector %P"}
    ```

    Zwar dient dieses benutzerdefinierte Attribut zur Validierung eines bestimmten Arguments, doch gibt es auch ein globales Attribut zur Datenvalidierung (*-validatecommand*), mit dem Validierungen durchgeführt werden können, die mehrere Argumente umfassen.

-validatecommand\_error\_text *string*
: Mit diesem Attribut lässt sich die Standardfehlermeldung für eine benutzerdefinierte Validierung des Arguments (definiert durch *-validatecommand*) überschreiben.


Einige weitere Attribute werden sowohl von den List- und Comboboxen als auch von den Radio- und Checkbuttons unterstützt.

-choices *string*
: Auswahllisten können direkt mit dem Attribut *-choices* definiert werden. Diese Art der Definition von Auswahllisten eignet sich besonders für kleinere, feste Auswahlen.

    ```
    tepam::argument_dialogbox \
       -listbox {-label "Text styles" -variable Styles \
                 -choices {bold italic underline} -default underline
    ```

-choicelabels *string* *(only check and radio buttons)*
: Wenn die Beschriftungen der Check- und Radioboxen von den Optionswerten abweichen sollen, können diese mit dem Attribut *-choicelabels* definiert werden:

    ```
    tepam::argument_dialogbox \
       -checkbox {-label "Font sytle" -variable FontStyle \
                  -choices {bold italic underline} \
                  -choicelabels {Bold Italic Underline}
    ```

-choicevariable *string*
: Eine weitere Möglichkeit zur Definition der Auswahllisten ist die Verwendung des Attributs *-choicevariable*. Diese Methode zur Definition von Auswahllisten eignet sich besonders für umfangreiche und gegebenenfalls variable Auswahlen.

    ```
    set TextSizes {8 9 10 12 15 18}
    tepam::argument_dialogbox \
       -combobox {-label "Text size" -variable Size -choicevariable TextSizes}
    ```

-multiple\_selection **0**|**1**
: Das Listbox-Element (**-listbox**) erlaubt standardmäßig die Auswahl von nur einem Element. Durch Setzen des Attributs *-multiple\_selection* auf **1** können mehrere Elemente ausgewählt werden.

    ```
    tepam::argument_dialogbox \
       -listbox {-label "Text styles" -variable Styles \
                 -choices {bold italic underline} -default underline \
                 -multiple_selection 1 -height 3}
    ```


Die Widgets zur Datei- und Verzeichnisauswahl unterstützen einige zusätzliche Attribute.

-filetypes *string*
: Das Dateityp-Attribut wird von den Elementen **-file** und **-existingfile** verwendet, um die Dateiendungen festzulegen, nach denen der Dateibrowser sucht.

    ```
    tepam::argument_dialogbox \
       -file {-label "Image file" -variable ImageF \
              -filetypes {{"GIF" {*.gif}} {"JPG" {*.jpg}}}}
    ```

-initialfile *string*
: Die von den Dateibrowsern der Widgets **-file** und **-existingfile** verwendete Ausgangsdatei ist standardmäßig die mit dem Attribut *-default* definierte Datei, es sei denn, es wird eine Datei mit dem Attribut *-initialfile* angegeben.

    ```
    tepam::argument_dialogbox \
       -file {-variable ImageF -initialfile "picture.gif"}
    ```

-activedir *string*
: Das Attribut *-activedir* überschreibt das standardmäßige aktive Suchverzeichnis, das von den Dateibrowsern aller Datei- und Verzeichnis-Eingabe-Widgets verwendet wird. Das standardmäßige aktive Suchverzeichnis wird durch das Verzeichnis einer angegebenen Startdatei (*-initialfile*) definiert, sofern eine solche definiert ist; andernfalls durch das Verzeichnis der Vorgabedatei bzw. des Vorgabeverzeichnisses, das mit dem Attribut *-default* festgelegt wird.

    ```
    tepam::argument_dialogbox \
       -file "-variable ImageF -activedir $pwd"
    ```


Schließlich gibt es noch ein letztes Attribut, das von einigen Widgets unterstützt wird:

-height *string*
: Alle Widgets, die eine Auswahlliste enthalten (**-listbox**, **-disjointlistbox**, **-font**) sowie das mehrzeilige Widget **-text** akzeptieren das Attribut *-height*, das die Anzahl der angezeigten Zeilen der Auswahllisten festlegt.

    ```
    tepam::argument_dialogbox \
       -listbox {-label "Text size" -variable Size \
                 -choices {8 9 10 12 15 18} -default 12 -height 3}
    ```

    Wenn keine Höhe explizit angegeben wurde, wird die Höhe des Widgets dynamisch an die Größe der Argument-Dialogbox angepasst.


# Anwendungsspezifische Eingabe-Widgets

Ein anwendungsspezifisches Eingabe-Widget kann der Argument-Dialogbox zur Verfügung gestellt werden, indem eine entsprechende Prozedur zum Namespace [tepam][tepam_introduction] hinzugefügt wird. Diese Prozedur verfügt über drei Argumente: Das erste ist der Pfad zum Widget, das zweite ein Unterbefehl und das dritte Argument dient verschiedenen Zwecken:

```
proc tepam::ad_form(<WidgetName>) {W Command {Par ""}} {
   upvar Option Option; # if required
   variable argument_dialogbox; # if required
   switch $Command {
      "create" <CreateCommandSequence>
      "set_choice" <SetChoiceCommandSequence>
      "set" <SetCommandv>
      "get" <GetCommandSequence>
   }
}
```

**Argument\_dialogbox** übernimmt die Verwaltung der Attribute *-label* und *-text* für alle Eingabe-Widgets. Für jedes Dateneingabe-Widget erstellt er einen Rahmen, in den die Komponenten des Dateneingabe-Widgets eingefügt werden können. Der Pfad zu diesem Rahmen wird über das Argument *W* angegeben.

Die Prozedur des Eingabe-Widgets muss drei obligatorische und einen optionalen Befehl unterstützen, die über das Argument *Command* ausgewählt werden:

*create*
: Die Eingabe-Widget-Prozedur wird ein erstes Mal mit dem Befehl *create* aufgerufen, um das Dateneingabe-Widget zu erstellen.

    Die von **argument\_dialogbox** für die Eingabe-Widgets bereitgestellten Rahmen sind standardmäßig nur in X-Richtung ausdehnbar. Um sie auch in Y-Richtung ausdehnbar zu machen, beispielsweise für ausdehnbare Listboxen, muss beim Erstellen eines Eingabe-Widgets der Befehl **ad\_form(make\_expandable) $W** ausgeführt werden.

*set\_choice*
: Die Prozedur des Eingabe-Widgets wird nur dann mit dem Befehl *set\_choice* aufgerufen, wenn das Attribut *-choices* oder *-choicevariable* festgelegt wurde. Der Befehl ist daher nur für List- und Comboboxen relevant.

    Die Liste der verfügbaren Auswahlmöglichkeiten, die entweder mit dem Attribut *-choices* oder *-choicevariable* festgelegt wird, wird über das Argument *Par* an die Eingabe-Widget-Prozedur übergeben. Diese Liste kann zur Initialisierung einer Liste der verfügbaren Auswahlmöglichkeiten verwendet werden.

*set*
: Wenn ein Vorgabewert entweder über das Attribut *-default* oder über einen vorangehenden Aufruf definiert wird, wird die Prozedur des Eingabe-Widgets mit dem Befehl *set* aufgerufen. Das Argument *Par* enthält in diesem Fall den Wert, auf den das Eingabe-Widget initialisiert werden soll.

*get*
: Der Befehl *get* der Eingabe-Widget-Prozedur muss den aktuellen Wert des Eingabe-Widgets zurückgeben.


Eventuell angegebene Attribute der Eingabe-Widget-Elemente stehen über die Array-Variable **Option** der aufrufenden Prozedur zur Verfügung. Auf diese Variable kann innerhalb der Eingabe-Widget-Prozedur über den Befehl **upvar** zugegriffen werden.

Möglicherweise müssen bestimmte Informationen in einer Variablen gespeichert werden. Zu diesem Zweck muss die Array-Variable **argument\_dialogbox** zusammen mit Array-Indizes verwendet werden, die mit *"$W,"* beginnen, z. B. *argument\_dialogbox($W,values)*.

Beispiele für Eingabe-Widget-Prozeduren werden direkt in der Quelldatei des TEPAM-Pakets bereitgestellt, die die Standard-Eingabe-Widget-Prozeduren festlegt. Die einfachste Prozedur ist die für das grundlegende *entry*-Widget:

```
proc tepam::ad_form(entry) {W Command {Par ""}} {
   switch $Command {
      "create" {pack [entry \$W.entry] -fill x \
                        -expand yes -pady 4 -side left}
      "set" {\$W.entry insert 0 $Par}
      "get" {return [\$W.entry get]}
   }
}
```

Es ist zudem möglich, auf eine bereits vorhandene Eingabe-Widget-Prozedur zurückzugreifen, um eine neue, spezifischere abzuleiten. Das *radiobox*-Widget wird beispielsweise verwendet, um ein neues Eingabe-Widget zu erstellen, das die Auswahl zwischen *left*, *center* oder *right* ermöglicht. Das ursprüngliche *radiobox*-Widget wird unmittelbar nach dem *create*-Befehl mit dem *set\_choice*-Befehl aufgerufen, um die feste Liste der Auswahloptionen festzulegen.

```
proc tepam::ad_form(rcl) {W Command {Par ""}} {
   set Res [ad_form(radiobox) $W $Command $Par]
   if {$Command=="create"} {
      ad_form(radiobox) $W set_choice {left center right}
   }
   return $Res
}
```

Bitte sehen Sie in der Quelldatei des TEPAM-Pakets nach, um weitere und komplexere Beispiele für Prozeduren des Eingabe-Widgets zu finden.

# Variablen

Der Befehl **argument\_dialogbox** verwendet zwei Variablen innerhalb des Namespaces **::tepam**:

**argument\_dialogbox**
: Anwendungsspezifische Eingabe-Widget-Prozeduren können diese Array-Variable nutzen, um ihre eigenen Daten zu speichern, wobei sie den an die Prozedur übergebenen Widget-Pfad als Index verwenden, z. B. *argument\_dialogbox($W,<sub\_index>)*.

**last\_parameters**
: Diese Array-Variable wird von einer Argument-Dialogbox nur dann verwendet, wenn deren Kontext über das Attribut *-context* festgelegt wurde. Die Position und Größe der Argument-Dialogbox sowie die darin eingegebenen Daten werden in dieser Variablen gespeichert, wenn die Daten bestätigt und das Formular geschlossen werden. Dadurch kann das Formular seinen vorherigen Zustand wiederherstellen, sobald es erneut aufgerufen wird.

    Um die gespeicherten Parameter nicht nur in der aktuellen Anwendungssitzung, sondern auch in einer anderen wiederzuverwenden, reicht es aus, den Inhalt der Array-Variablen **last\_parameter** in einer Konfigurationsdatei zu speichern, die beim nächsten Start der Anwendung geladen wird.


# Kategorie

Eingabeformular für Argumente, Megawidget

# Copyright

```
Copyright (c) 2009-2013, Andreas Drollinger
```


[tepam_introduction]: tepam_introduction.md
[tepam_procedure]: tepam_procedure.md
