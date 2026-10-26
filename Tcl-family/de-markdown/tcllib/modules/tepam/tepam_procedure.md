---
CommandName: tepam::procedure
ManualSection: n
Version: 0.5.0
TclPart: tcllib
TclDescription: Tcl's Enhanced Procedure and Argument Manager
Links:
 - tepam(n)
 - tepam::argument_dialogbox(n)
Keywords:
 - argument integrity
 - argument validation
 - arguments
 - procedure
 - subcommand
Copyright:
 - Copyright (c) 2009-2013, Andreas Drollinger
---

# NAME

tepam::procedure – TEPAM-Prozedur, Referenzhandbuch

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tepam]{.lit} [0.5]{.optlit} 
[tepam::procedure]{.cmd} [name]{.arg} [attributes]{.arg} [body]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket bietet eine alternative Möglichkeit, Tcl-Prozeduren zu deklarieren und deren Argumente zu verwalten. Die Deklaration einer Prozedur mit TEPAM bietet gegenüber dem Tcl-Standardbefehl **proc** zahlreiche Vorteile: TEPAM ermöglicht es, innerhalb der Prozedurdeklaration alle Informationen anzugeben, die zur Erstellung umfassender Dokumentationen und Hilfeunterstützung erforderlich sind.  Diese Informationen werden zudem von einem automatisch aufgerufenen Argumentprüfer verwendet, der die übergebenen Prozedurargumente validiert, bevor der Prozedurkörper ausgeführt wird. Schließlich kann eine Prozedur interaktiv aufgerufen werden, wodurch ein grafisches Formular geöffnet wird, in dem die Argumente der Prozedur festgelegt werden können.

TEPAM vereinfacht zudem den Umgang mit den verschiedenen Argumenttypen, wie beispielsweise den *benannten Argumenten* (oft auch als *Optionen* bezeichnet) und den *unbenannten Argumenten*. TEPAM unterstützt sowohl den Stil *benannte zuerst, unbenannte danach* (typischer Tcl-Befehlsstil) als auch den Stil *unbenannte zuerst, benannte danach* (typischer Tk-Befehlsstil). TEPAM kümmert sich um Vorgabewerte für Argumente, optionale Argumente, mehrfach anwendbare Argumente usw. und macht es überflüssig, die Gültigkeit der Argumente in den Prozedurkörpern zu prüfen.

Einen informellen Überblick über alle Funktionen zur Deklaration und zum Aufruf von TEPAM-Prozeduren sowie eine kurze Einführung in TEPAM bietet *tepam(n)*.

# BEGRIFFSBESTIMMUNGEN

Die genaue Bedeutung einiger in diesem Dokument verwendeter Begriffe wird im Folgenden kurz erläutert, um Unklarheiten und Missverständnisse zu vermeiden.

*Unterbefehl*
: Die Verwendung von Unterbefehlen ist in der Programmiersprache Tcl weit verbreitet. Mehrere Befehle sind in einem einzigen Hauptbefehl zusammengefasst und können über das erste Argument ausgewählt werden. Der Befehl **string** ist ein Beispiel für einen solchen Befehl, der unter anderem Unterbefehle zur Überprüfung der Länge einer Zeichenkette, zum Vergleich von Zeichenketten, zum Extrahieren von Teilzeichenketten usw. implementiert:


```
string length string
string compare string string
string range string first last
...
```

TEPAM bietet einen Rahmen, der die einfache Implementierung solcher Unterbefehle in Form von Tcl-Prozeduren ermöglicht. Er erlaubt nicht nur die Definition einer ersten Ebene von Unterbefehlen, sondern auch höherer Ebenen von Unterbefehlen. Die Klassenprüfung des Befehls **string** könnte als eigenständige Unter-Unterbefehle des Befehls **string** implementiert werden:

```
string is alnum string
string is integer string
string is double string
...
```

*Prozedurattribut*
: TEPAM ermöglicht es, einer deklarierten Prozedur verschiedene Arten von Attributen zuzuweisen. Einige dieser Attribute dienen *lediglich* zu Dokumentationszwecken, während andere Attribute festlegen, wie die Prozedur aufgerufen werden muss. Auch die Prozedurargumente werden in Form eines Prozedurattributs definiert.

*Argument*
: TEPAM verwendet den Begriff *Argument* für die Parameter einer Prozedur. Im folgenden Beispiel wird der Unterbefehl **string compare** mit mehreren Argumenten aufgerufen:


```
string compare -nocase -length 3 "emphasized" "emphasised"
```

: In den folgenden Absätzen werden diese verschiedenen Argumenttypen erörtert.


*Benanntes Argument*
: Einige Parameter, wie beispielsweise *-length 3* des Unterbefehls **string compare**, müssen als Paare aus Argumentnamen und Argumentwerten angegeben werden. Dieser Parametertyp wird häufig auch als *Option* bezeichnet. TEPAM verwendet den Begriff *benanntes Argument* sowohl für solche Optionen als auch für die Flags (siehe nächster Punkt).

*Flag, Schalter*
: Ein weiterer Parametertyp ist das *Flag* oder der *Schalter*. Flags werden einfach dadurch übergeben, dass ihr Name mit vorangestelltem Zeichen „-“ angegeben wird. Das *-nocase* aus dem vorherigen Beispiel **string compare** ist ein solches Flag. *Flags* werden von TEPAM als eine spezielle Form von *benannten Argumenten* betrachtet.

*Unbenanntes Argument*
: Für die übrigen Parameter, d. h. diejenigen, bei denen der Name des Arguments nicht angegeben werden muss, verwendet TEPAM den Begriff *unbenanntes Argument*. Das vorangegangene Beispiel **string compare** verwendet für die beiden übergebenen Zeichenfolgen zwei *unbenannte Argumente*.

*Argumentattribut*
: TEPAM ermöglicht es, den Zweck jedes Prozedurarguments mithilfe von *Argumentattributen* zu beschreiben. Während einige davon lediglich der Dokumentation der Argumente dienen, werden die meisten Attribute von einem Argumentmanager verwendet, um die bei einem Prozeduraufruf übergebenen Argumente zu steuern und zu validieren. Argumentattribute dienen dazu, Vorgabewerte, Parameterklassen (integer, xdigit, font, …), Validierungslisten für Auswahlmöglichkeiten, Wertebereiche usw. festzulegen.

*Benannte Argumente zuerst, unbenannte Argumente danach*
: Der Befehl **string compare** aus dem vorherigen Beispiel erfordert, dass die *benannten Argumente* (Optionen, Flags) zuerst angegeben werden. Die beiden obligatorischen (unbenannten) Argumente müssen als letztes Argument angegeben werden.


```
string compare -nocase -length 3 Water $Text
```

: Dies ist der übliche Tcl-Stil (es gibt Ausnahmen), der in der TEPAM-Dokumentation als Stil *benannte Argumente zuerst, unbenannte Argumente danach* bezeichnet wird.


*Unbenannte Argumente zuerst, benannte Argumente danach*
: Im Gegensatz zu den meisten Tcl-Befehlen verwendet Tk in der Regel (auch hier gibt es Ausnahmen) eine andere Aufrufweise, bei der die *unbenannten Argumente* zuerst angegeben werden müssen, bevor die *benannten Argumente* folgen:


```
pack .ent1 .ent2 -fill x -expand yes -side left
```

: Dieser Stil wird in der TEPAM-Dokumentation als Stil *unbenannte Argumente zuerst, benannte Argumente danach* bezeichnet.


# PROZEDURDEKLARATION

Mit TEPAM können neue Tcl-Prozeduren mithilfe des Befehls **tepam::procedure** deklariert werden, der – ähnlich wie der Standard-Tcl-Befehl **proc** – ebenfalls drei Argumente aufweist:

**tepam::procedure** *name* *attributes* *body*
: Die Syntax für die Deklaration von TEPAM-Prozeduren wird anhand des folgenden Beispiels veranschaulicht:


```
tepam::procedure {display message} {
   -short_description
      "Displays a simple message box"
   -description
      "This procedure allows displaying a configurable\
       message box. The default message type that is\
       created is a warning, but also errors and info can\
       be generated.
       The procedure accepts multiple text lines."
   -example
      {display message -mtype Warning "Save first your job"}
   -args {
      {-mtype -choices {Info Warning Error} \
              -default Warning -description "Message type"}
      {text   -type string -multiple \
              -description "Multiple text lines to display"}
   }
} {
   puts "Message type: $mtype"
   puts "Message: $text"
}
```

Die drei Argumente von **procedure** lauten:

*name*
: Der Prozedurname lässt sich sehr flexibel verwenden. Prozedurnamen können Namespace-Qualifizierer enthalten. Durch die Angabe einer aus zwei Elementen bestehenden Namensliste als Prozedurnamen wird ein Unterbefehl einer Prozedur deklariert. Es ist sogar möglich, Unter-Unterbefehle einer Prozedur zu deklarieren, indem Namenslisten mit drei Elementen angegeben werden. Hier sind einige gültige Prozedurdeklarationen mit verschiedenen Prozedurnamen (die Argumente für Attribute und Körper sind der Einfachheit halber leer):


```
# Simple procedure name:
tepam::procedure display_message {} {}

# Procedure declared in the main namespace:
tepam::procedure ::display_message {} {}

# Procedure in the namespace ::ns:
tepam::procedure ::ns::display_message {} {}

# Declaration of the subcommand message of the procedure display:
tepam::procedure {display message} {} {}
```

*attributes*
: Alle Prozedurattribute werden in Form einer Optionsliste bereitgestellt, die Paare aus Optionsnamen und Optionswerten enthält. Das obige Beispiel weist als Prozedurattribute eine Kurzbeschreibung und eine normale Beschreibung auf, doch auch die Prozedurargumente werden in Form eines Prozedurattributs definiert. Die meisten Prozedurattribute dienen der Dokumentation. Einige von ihnen beeinflussen jedoch auch die Art und Weise, wie die Prozedur aufgerufen werden kann. Der Abschnitt **Prozedur-Attribute** behandelt die verfügbaren Prozedurattribute im Detail. Die Prozedurargumente werden in Form eines speziellen Prozedurattributs definiert. Die meisten der in der Argumentdefinition angegebenen Informationen dienen nicht nur zu Dokumentationszwecken. Diese Informationen werden vielmehr vom TEPAM-Argumentmanager verwendet, um die verschiedenen Formen von Argumenten, die bei Aufrufen von Prozeduren übergeben werden, zu verarbeiten und zu validieren. Der Abschnitt **Deklaration von Argumenten** behandelt alle Attribute der Argumentdefinition im Detail.

*body*
: Dies ist der normale Prozedurkörper. Die deklarierten Argumente stehen dem Prozedurkörper in Form von Variablen zur Verfügung. Der Prozedurkörper wird nur ausgeführt, wenn die übergebene Argumentgruppe vom TEPAM-Argumentmanager validiert werden konnte.


```
tepam::procedure {display_message} {
   -args {
      {-mtype -default Warning -choices {Warning Error}}
      {text -type string}
   }
} {
   puts "Message type: $mtype"
   puts "Message: $text"
}
```

Die Befehle **procedure** sowie **argument_dialogbox** werden aus dem Namespace **tepam** exportiert. Um diese Befehle ohne das Namespace-Präfix **tepam::** zu verwenden, reicht es aus, sie in den Haupt-Namespace zu importieren:

```
namespace import tepam::*

procedure {display_message} {
   -args {
      ...
```

## Prozedur-Attribute

Die erste Gruppe von Attributen beeinflusst das Verhalten der deklarierten Prozedur:

-named_arguments_first **0**|**1**
: Dieses Attribut definiert den Aufrufstil einer Prozedur. TEPAM verwendet standardmäßig den Stil *benannte Argumente zuerst, unbenannte Argumente danach* (Tcl). Dieses Standardverhalten kann global geändert werden, indem die Variable **tepam::named_arguments_first** auf **0** gesetzt wird. Dieser globale Aufrufstil kann für eine einzelne Prozedur mithilfe des Attributs *-named_arguments_first* individuell geändert werden.

-auto_argument_name_completion **0**|**1**
: Die deklarierten Prozeduren versuchen standardmäßig automatisch, eventuell abgekürzte Argumentnamen den definierten Argumentnamen zuzuordnen. Dieses Standardverhalten kann global geändert werden, indem die Variable **tepam::auto_argument_name_completion** auf **0** gesetzt wird. Diese globale Einstellung der automatischen Namenvervollständigung für Argumente kann für eine Prozedur individuell über das Prozedurattribut *-auto_argument_name_completion* geändert werden.

-interactive_display_format **extended**|**short**
: Eine mit dem TEPAM-Befehl **procedure** deklarierte Prozedur kann stets mit der Option **-interactive** aufgerufen werden. Auf diese Weise wird ein grafisches Formular generiert, in dem alle Werte der Prozedurargumente angegeben werden können. Für diese interaktiven Formulare gibt es zwei Anzeigemodi. Während der Modus *extended* eher für Prozeduren mit wenigen Argumenten geeignet ist, eignet sich die Form **short** besser für Prozeduren mit sehr vielen Argumenten. Die Wahl zwischen der Verwendung kurzer oder erweiterter Formulare kann global über die Variable **tepam::interactive_display_format** konfiguriert werden. Diese globale Einstellung lässt sich anschließend für eine einzelne Prozedur mithilfe des Prozedurattributs *-interactive_display_format* individuell ändern.

-args *list*
: Die Prozedurargumente werden über das Attribut *-args* deklariert. Ein Argument wird über eine Liste definiert, deren erstes Element der Name des Arguments ist, gefolgt von eventuellen Argumentattributen. Alle diese Argumentdefinitionslisten werden ihrerseits in eine globale Liste zusammengefasst, die dem Attribut *-args* zugewiesen wird. Die Syntax der Argumentdefinition wird im folgenden Unterabschnitt näher beschrieben. Die folgenden Attribute ermöglichen die Festlegung benutzerdefinierter Argumentprüfungen sowie benutzerdefinierter Fehlermeldungen für den Fall, dass diese Prüfungen fehlschlagen:

-validatecommand *script*
: Benutzerdefinierte Argumentvalidierungen können über spezifische Validierungsbefehle durchgeführt werden, die mit dem Attribut *-validatecommand* definiert sind. Beispiel für die Deklaration eines Validierungsbefehls:


```
tepam::procedure {display_message} {
   -args {
      {text -type string -description "Message text"} }
   -validatecommand {IllegalWordDetector $text}
} {
}
```

: Der Validierungsbefehl wird im Kontext des deklarierten Prozedurkörpers ausgeführt. Der Zugriff auf die verschiedenen Argumentwerte erfolgt über die Argumentnamen. Hinweis: Es gibt außerdem ein Argumentattribut *-validatecommand*, mit dem benutzerdefinierte Prüfungen für bestimmte Argumente deklariert werden können. Das Attribut *-validatecommand* kann wiederholt werden, um mehrere benutzerdefinierte Prüfungen zu deklarieren.


-validatecommand_error_text *string*
: Mit diesem Attribut lässt sich die Standardfehlermeldung für eine benutzerdefinierte Validierung eines Arguments (definiert durch *-validatecommand*) überschreiben. Außerdem kann dieses Attribut wiederholt werden, falls mehrere Validierungen von Argumenten deklariert sind. Mit dem folgenden Attribut lassen sich die Protokollierungseinstellungen für eine einzelne Prozedur steuern:

-command_log **0**|**1**|**"interactive"**
: Dieses Argument konfiguriert die Protokollierung der Prozeduraufrufe in der Listenvariablen **tepam::ProcedureCallLogList**. Wird dieses Argument in einer Prozedurdeklaration nicht definiert, wird die durch die Variable **tepam::command_log** festgelegte Standardkonfiguration verwendet. Wird dieses Argument auf **0** gesetzt, wird jede Protokollierung von Prozeduraufrufen abgeschaltet; bei **1** werden alle Prozeduraufrufe protokolliert, und bei **interactive** nur die Prozeduren, die interaktiv aufgerufen werden (Prozeduren, die mit dem Flag **-interactive** aufgerufen werden). Die nächste Gruppe von Prozedurattributen dient ausschließlich der Dokumentation und der Erstellung von Hilfetexten:

-category *string*
: Einer Prozedur kann zu Dokumentationszwecken eine Kategorie zugewiesen werden. Als Kategorie wird jede beliebige Zeichenfolge akzeptiert.

-short_description *string*
: Die Kurzbeschreibung einer Prozedur wird sowohl in der Zusammenfassung der Dokumentation einer generierten Liste von Prozeduren als auch im Abschnitt NAME einer generierten Handbuchseite zur Prozedur verwendet.

-description *string*
: Die einer Prozedur zugewiesene (vollständige) Beschreibung wird zur Erstellung des Benutzerhandbuchs und der Hilfeseiten verwendet.

-return *string*
: Das Attribut *-return* ermöglicht die Festlegung des erwarteten Rückgabewerts einer Prozedur (zu Dokumentationszwecken).

-example *string*
: Ein Hilfetext oder eine Seite des Handbuchs zu einer Prozedur kann mithilfe des Attributs *-example* gegebenenfalls um Beispiele ergänzt werden.


## Deklaration von Argumenten

Das folgende Beispiel veranschaulicht die Struktur, die für die Definitionen der Argumente im Rahmen einer Deklaration einer Prozedur verwendet wird:

```
tepam::procedure {display_message} {
   -args {
      {-mtype -default Warning -choices {Info Warning Error} -description "Message type"}
      {-font -type font -default {Arial 10 italic} -description "Message text font"}
      {-level -type integer -optional -range {1 10} -description "Message level"}
      {-fg -type color -optional -description "Message color"}
      {-log_file -type file -optional -description "Optional message log file"}
      {text -type string -multiple -description "Multiple text lines to display"}
   }
} {
}
```

Jedes der Prozedurargumente wird mit einer Liste deklariert, deren erstes Element der Name des Arguments ist, gefolgt von eventuellen Attributen. Die Syntax der Argumentdefinition lässt sich wie folgt formalisieren:

```
tepam::procedure <name> {
   -args {
      {<argument_name_1> <arg_attr_name_1a> <arg_attr_value_1a>  <arg_attr_name_1b> <arg_attr_value_1b> ...}
      {<argument_name_2> <arg_attr_name_2a> <arg_attr_value_2a>  <arg_attr_name_2b> <arg_attr_value_2b> ...}
      ...
   }
} <body>
```

Die Argumentnamen und Attribute müssen wie folgt verwendet werden:

Argumentname (*\<argument_name\_\<n>>*)
: Der angegebene Argumentname legt fest, ob es sich bei dem Argument um ein *unbenanntes Argument* oder ein *benanntes Argument* handelt. Darüber hinaus kann ein Argumentname auch leer sein, um einen Argumentkommentar zu kennzeichnen, oder mit # beginnen, um einen Abschnittskommentar zu kennzeichnen.


*"\<Name>"*
: Dies ist die einfachste Form eines Argumentnamens: Ein Argument, dessen Name nicht mit „-“ beginnt, ist ein *unbenanntes Argument*. Der bei einem Prozeduraufruf übergebene Parameter wird einer Variable mit dem Namen *\<Name>* zugewiesen.


```
tepam::procedure {print_string} {
   -args {
      {text -type string -description "This is an unnamed argument"}
   }
} {
   puts $text
}

print_string "Hello"
 -> Hello
```

*"-\<Name>"*
: Ein Argument, dessen Name mit „-“ beginnt, ist ein *benanntes Argument* (auch als *Option* bezeichnet). Der bei einem Prozeduraufruf übergebene Parameter wird einer Variable mit dem Namen *\<Name>* (nicht *-\<Name>*) zugewiesen.


```
tepam::procedure {print_string} {
   -args {
      {-text -type string -description "This is a named argument"}
   }
} {
   puts $text
}

print_string -text "Hello"
 -> Hello
```

*"--"*
: Dieses Flag ermöglicht es, das Ende der benannten Argumente und den Beginn der unbenannten Argumente eindeutig festzulegen, falls der Stil *benannte Argumente zuerst, unbenannte Argumente danach (Tcl)* ausgewählt wurde. Wenn der Stil *unbenannte Argumente zuerst, benannte Argumente danach (Tk)* ausgewählt ist, wird dieses Flag ignoriert, sofern die unbenannten Argumente bereits geparst wurden. Andernfalls wird es dem entsprechenden unbenannten Argument zugewiesen.

*"-"* oder *""*
: Ein leerer Argumentname (entweder '-' oder *''*) leitet einen Kommentar für die folgenden Argumente ein.


```
tepam::procedure {print_time} {
   -interactive_display_format short
   -args {
      {hours -type integer -description "Hour"}
      {minutes -type integer -description "Minute"}

      {- The following arguments are optional:}
      {seconds -type integer -default 0 -description "Seconds"}
      {milliseconds -type integer -default 0 -description "Milliseconds"}
   }
} {
   puts "${hour}h${minutes}:[expr $seconds+0.001*$milliseconds]"
}
```

: Argumentkommentare werden im Wesentlichen in den grafischen Formularen zur Argumentdefinition verwendet, die erstellt werden, wenn eine Prozedur interaktiv aufgerufen wird.


*"#\*"*
: Eine Argumentdefinitionsliste, die mit „#“ beginnt, wird als Abschnittskommentar gewertet. Die Argumentdefinitionsliste wird um die „#“-Zeichen gekürzt, und die verbleibende Zeichenfolge wird als Abschnittskommentar verwendet. Abschnittskommentare können dazu dienen, den Code der Argumentdefinitionen visuell zu strukturieren. Abschnittskommentare werden zudem zur Strukturierung der generierten Hilfetexte und der interaktiven Formulare zur Argumentdefinition verwendet.


```
tepam::procedure {complex_multiply} {
   -description "This function perform a complex multiplication"
   -args {
      {#### First complex number ####}
      {-r0 -type double -description "First number real part"}
      {-i0 -type double -description "First number imaginary part"}

      {#### Second complex number ####}
      {-r1 -type double -description "Second number real part"}
      {-i1 -type double -description "Second number imaginary part"}
   }
} {
   return [expr $r0*$r1 - $i0*$i1]
}
```

Argumentattribute (*\<arg_attr_name\_\<mn>> \<arg_attr_value\_\<mn>>*)
: Die folgenden Argumentattribute werden unterstützt:


-description *string*
: Das Argumentattribut description wird zu Dokumentationszwecken verwendet. Interaktive Formulare zur Definition von Argumenten nutzen dieses Attribut, um Erläuterungen zu einem Argument bereitzustellen.

-type *type*
: Das Argumentattribut type ermöglicht es, das Argument entweder einem vordefinierten Datentyp oder einem anwendungsspezifischen Datentyp zuzuweisen. Die bei einem Prozeduraufruf übergebenen Argumentwerte werden automatisch auf Übereinstimmung mit dem definierten Argumenttyp überprüft. Der Abschnitt **ARGUMENTTYPEN** enthält eine Liste vordefinierter Datentypen und erläutert, wie anwendungsspezifische Typen festgelegt werden können. Der Argumenttyp *none* hat eine besondere Bedeutung. Ein Argument vom Typ *none* wird als *Flag* behandelt. Ein Flag ist stets optional, und die zugehörige Variable enthält den logischen Wert **1**, wenn das Flag beim Prozeduraufruf angegeben wurde, andernfalls den Wert **0**.

-default *value*
: Eventuelle Vorgabewerte können über das Argumentattribut -default definiert werden. Argumente mit Vorgabewerten sind automatisch optionale Argumente.

**-optional|-mandatory**
: Argumente sind standardmäßig obligatorisch, sofern kein Vorgabewert definiert ist. Das Flag *-optional* macht ein Argument zu einem optionalen Argument. Wird ein optionales Argument bei einem Prozeduraufruf nicht definiert, wird die entsprechende Variable nicht definiert. Das Flag *-mandatory* ist das Gegenteil von *-optional*. Dieses Flag dient lediglich der Vollständigkeit, da ein Argument standardmäßig ohnehin obligatorisch ist.

**-multiple**
: Argumente mit dem Attribut *-multiple* können während eines Prozeduraufrufs mehrfach definiert werden. Die Werte, die während eines Prozeduraufrufs für ein solches Argument übergeben werden, werden in einer Listenvariablen gespeichert. Dies gilt auch dann, wenn ein solches Argument während eines Prozeduraufrufs nur einmal definiert wird. Das Attribut *-multiple* kann sowohl unbenannten als auch benannten Argumenten zugewiesen werden. Bei einem benannten Argument muss das Paar aus Argumentname und Wert für jeden übergebenen Wert wiederholt werden. Falls das Argument mit dem Attribut *-multiple* ein unbenanntes Argument ist, muss dieses das absolut letzte aller unbenannten Argumente sein.

-choices *list*
: Über das Attribut *-choices* kann einem Argument eine mögliche Menge gültiger Argumentwerte zugewiesen werden. Der bei einem Prozeduraufruf übergebene Argumentwert wird anhand der angegebenen Auswahlwerte überprüft.

-choicelabels *list*
: Jedem Auswahlwert kann mithilfe des Attributs *-choicelabels* eine kurze Beschreibung zugewiesen werden. Diese Beschreibungen werden in den generierten Hilfetexten sowie als Beschriftungen der Radio- und Checkboxen bei den interaktiven Aufrufen verwendet. Das Attribut *-choicelabels* ist optional; sollte es jedoch definiert werden, muss seine Liste dieselbe Länge aufweisen wie die Argumentliste von *-choices*.

-range *{double double}*
: Eine weitere Einschränkung des Arguments kann mit dem Attribut *-range* definiert werden. Der gültige Bereich wird durch eine Liste festgelegt, die den kleinsten und den größten zulässigen Wert enthält. Das Attribut *-range* darf ausschließlich für numerische Argumente wie Ganzzahlen und Gleitkommazahlen verwendet werden.

-validatecommand *script*
: Benutzerdefinierte Validierungen von Argumentwerten können über spezifische Validierungsbefehle durchgeführt werden, die mit dem Attribut *-validatecommand* definiert sind. Der angegebene Validierungsbefehl kann ein vollständiges Skript sein, in dem das Muster *%P* durch den zu validierenden Wert ersetzt wird. Beispiel für die Deklaration eines Validierungsbefehls:


```
tepam::procedure {display_message} {
   -args {
      {text -type string -description "Message text" \
            -validatecommand {IllegalWordDetector %P}}
} {
}
```

: Zwar dient dieses benutzerdefinierte Attribut zur Validierung eines bestimmten Arguments, doch gibt es auch ein globales Attribut *-validatecommand*, mit dem Validierungen durchgeführt werden können, die mehrere Argumente umfassen.


-validatecommand_error_text *string*
: Mit diesem Attribut lässt sich die Standardfehlermeldung für eine benutzerdefinierte Validierung eines Arguments (definiert durch *-validatecommand*) überschreiben.

-widget *string*
: Die Widgets, mit denen die verschiedenen Argumente bei einem interaktiven Aufruf einer Prozedur definiert werden können, werden in der Regel automatisch entsprechend dem Argumenttyp ausgewählt. Mit dem Attribut *-widget* lässt sich für ein Argument explizit ein bestimmter Widget-Typ festlegen.

-auxargs *list*
: Wird eine Prozedur interaktiv aufgerufen, können dem interaktiven Formular zur Argumentdefinition zusätzliche Argumentattribute über das Attribut *-auxargs* übergeben werden, das selbst eine Liste aus Attributnamen- und Attributwertpaaren darstellt:


```
-auxargs {-<arg_attr_name_1a> <arg_attr_value_1a> \
          -<arg_attr_name_1b> <arg_attr_value_1b>
          ...
}
```

: Wenn eine Prozedur beispielsweise einen Dateinamen als Argument entgegennimmt, kann es sinnvoll sein, den erforderlichen Dateityp für das interaktive Argumentdefinitionsformular festzulegen. Diese Information kann über das Attribut *-auxargs* an das Argumentdefinitionsformular übermittelt werden:


```
tepam::procedure LoadPicture {
   -args {
      {FileName -type existingfile -description "Picture file" \
                 -auxargs {-filetypes {{"GIF" {*.gif}} {"JPG" {*.jpg}} }}}
   }
} {
}
```

-auxargs_commands *script*
: Wenn die Attribute der Hilfsargumente nicht statisch sind, sondern dynamisch anpassbar sein müssen, ermöglicht das Attribut *-auxargs_commands* deren Definition über Befehle, die während eines Prozeduraufrufs ausgeführt werden. Dem Attribut *-auxargs_commands* muss eine Liste von Paaren aus Hilfsattributnamen und Befehlen übergeben werden. Die übergebenen Befehle werden im Kontext der aufrufenden Prozedur ausgeführt.


```
-auxargs_commands {-<arg_attr_name_1a> <arg_attr_command_1a> \
                   -<arg_attr_name_1b> <arg_attr_command_1b>
                   ...
}
```

# VARIABLEN

Mehrere im Namespace **::tepam** definierte Variablen beeinflussen die Funktionsweise der Prozeduren, die mit dem TEPAM-Befehl **procedure** deklariert wurden.

**named_arguments_first**
: Diese Variable legt den allgemeinen Aufrufstil der Prozeduren fest. Sie ist standardmäßig auf **1** gesetzt, wodurch der Stil *benannte Argumente zuerst, unbenannte Argumente danach* (Tcl-Stil) ausgewählt wird. Durch Setzen dieser Variable auf **0** wird der Stil *unbenannte Argumente zuerst, benannte Argumente danach* global ausgewählt (Tk-Stil):


```
set tepam::named_arguments_first 0
```

Während diese Variable den allgemeinen Aufrufstil festlegt, kann das Prozedurattribut *-named_arguments_first* diesen Stil für jede deklarierte Prozedur individuell anpassen.

**auto_argument_name_completion**
: Diese Variable steuert den allgemeinen Modus für den automatischen Abgleich von Argumentnamen. Standardmäßig ist sie auf **1** gesetzt, was bedeutet, dass die aufgerufenen Prozeduren versuchen, eventuell abgekürzte Argumentnamen mit den deklarierten Argumentnamen abzugleichen. Durch Setzen dieser Variable auf **0** wird der Modus für den automatischen Abgleich der Argumentnamen deaktiviert:


```
set tepam::auto_argument_name_completion 0
```

Während diese Variable den allgemeinen Abgleichmodus festlegt, kann das Prozedurattribut *-auto_argument_name_completion* diesen Modus für jede deklarierte Prozedur individuell anpassen.

**interactive_display_format**
: Eine über den TEPAM-Befehl **procedure** deklarierte Prozedur kann stets mit dem Schalter **-interactive** aufgerufen werden. Auf diese Weise wird ein grafisches Formular generiert, das die interaktive Eingabe aller Prozedurargumente ermöglicht. Für diese interaktiven Formulare stehen zwei Anzeigemodi zur Verfügung. Der Modus *extended*, der als Standardmodus dient, eignet sich eher für Prozeduren mit wenigen Argumenten. Die Form **short** ist besser für Prozeduren mit sehr vielen Argumenten geeignet:


```
set tepam::interactive_display_format "short"
```

Die Entscheidung, ob kurze oder erweiterte Formulare verwendet werden sollen, kann über die Variable **interactive_display_format** global konfiguriert werden. Diese globale Einstellung kann für eine Prozedur mithilfe des Prozedurattributs *-interactive_display_format* individuell geändert werden.

**help_line_length**
: Mit dieser Variable lässt sich die maximale Zeilenlänge festlegen, die vom Prozedur-Hilfetextgenerator verwendet wird. Die Standardlänge, die auf 80 (Zeichen) festgelegt ist, lässt sich problemlos an die Anforderungen einer Anwendung anpassen:


```
set tepam::help_line_length 120
```

: Da diese Variable direkt bei der Erstellung des Hilfetextes verwendet wird, kann ihr Wert kontinuierlich an den aktuellen Bedarf angepasst werden.


**command_log**
: Prozeduraufrufe können in der Listenvariablen **tepam::ProcedureCallLogList** protokolliert werden. Die Variable **tepam::command_log** steuert die Standardprotokollierungseinstellungen für alle Prozeduren. Folgende Konfigurationen werden unterstützt:


**•**
: *0*: Deaktiviert die Protokollierung aller Prozeduraufrufe

**•**
: *1*: Aktiviert die Protokollierung aller Prozeduraufrufe

**•**
: *"interactive"*: Protokolliert alle interaktiv aufgerufenen Prozeduren (d. h. Prozeduren, die mit dem Flag -interactive aufgerufen werden). Dies ist die Standardkonfiguration.


: Diese Standardkonfiguration für die Protokollierung kann für jede Prozedur individuell über das Attribut *-command_log* geändert werden.


# ARGUMENTTYPEN

TEPAM bietet eine umfassende Auswahl an Argumenttypen für Prozeduren. Diese lassen sich bei Bedarf problemlos durch anwendungsspezifische Typen ergänzen.

## Vordefinierte Argumenttypen

Zur Erinnerung: Jedem angegebenen Argument einer Prozedur kann ein Typ zugewiesen werden:

```
tepam::procedure {warning} {
   -args {
      {-font -type font -default {Arial 10 italic}}
      {-severity_level -type integer -optional -range {1 10}}
      {-fg -type color -optional -description "Message color"}
      {text -type string -multiple -description "Multiple text lines to display"}
   }
} {
   ...
}
```

Es gibt einige *Spezialtypen*, die die erste Kategorie vordefinierter Argumenttypen bilden:

**•**
: **none** Ein *Flag*, auch *Schalter* genannt, ist als benanntes Argument definiert, das den Typ **none** hat. Flags sind stets optional, und der Vorgabewert der zugewiesenen Variable wird auf **0** gesetzt. Im Gegensatz zu den (normalen) benannten Argumenten muss für ein Flag kein Wert für das Argument angegeben werden.


```
tepam::procedure flag_test {
   -args {
      {-flag -type none -description "This is a flag"}
   }
} {
   puts $flag
}

flag_test
-> 0

flag_test -flag
-> 1
```

Da für ein Flag kein Wert angegeben werden muss, wird für diesen Argumenttyp auch keine Datenprüfung durchgeführt.

**•**
: **string** **String** ist ein generischer Argumentdatentyp. Einem Argument vom Typ string kann eine beliebige Zeichenkette übergeben werden, weshalb keine Datentypüberprüfungen durchgeführt werden. Der Typ string ermöglicht die Definition einzeiliger Zeichenketten bei interaktiven Aufrufen von Prozeduren.

**•**
: **text** **Text** entspricht **string**, mit dem einzigen Unterschied, dass es die Eingabe mehrzeiliger Zeichenfolgen bei interaktiven Aufrufen von Prozeduren ermöglicht.

**•**
: **{}** Ein leerer Argumenttyp (**blank**) bezeichnet einen undefinierten Argumenttyp. Dies ist der Standardargumenttyp, der verwendet wird, wenn kein Typ explizit angegeben wurde. Ein Argument vom Typ **blank** verhält sich genauso wie ein Argument vom Typ **string**, d. h., es werden keine Datenprüfungen für Argumente durchgeführt. Der einzige Unterschied besteht darin, dass der Datentyp **string** in der generierten Hilfedokumentation erwähnt wird, während dies beim Typ **blank** nicht der Fall ist. Von TEPAM werden mehrere *numerische Typen* definiert. Die Typvalidierungsprozeduren verwenden die Befehle **string is \<type> -strict**, um die Gültigkeit der übergebenen Argumente zu überprüfen, wodurch sichergestellt wird, dass keine leeren Zeichenfolgen als Argumentwert akzeptiert werden. Der Typvalidierungsausdruck für die numerischen Typen und die Argumenttypen, auf die dieser Ausdruck angewendet wird, lauten wie folgt:


```
string is <type_to_check> -strict <argument_value>
```

**•**
: *boolean*

**•**
: *integer*

**•**
: *double* Leere Zeichenfolgen werden als Argumentwert für alle alphanumerischen Argumenttypen akzeptiert. Die Argumenttypen, die in diese Kategorie fallen, sowie der für sie verwendete Validierungsausdruck lauten wie folgt:


```
string is <type_to_check> <argument_value>
```

**•**
: *alnum*

**•**
: *alpha*

**•**
: *ascii*

**•**
: *control*

**•**
: *digit*

**•**
: *graph*

**•**
: *lower*

**•**
: *print*

**•**
: *punct*

**•**
: *space*

**•**
: *upper*

**•**
: *wordchar*

**•**
: *xdigit* Zusätzlich zu den mit den Befehlen **string is \<type>** überprüften Datentypen legt TEPAM einige weitere nützliche Datentypen fest:

**•**
: *char* Jede Zeichenkette mit einer Länge von 1 Zeichen entspricht dem Typ *character*. Die Typüberprüfung erfolgt anhand des folgenden Ausdrucks:


```
expr [string length <argument_value>]==1
```

**•**
: *color* Alle Zeichenfolgen, die von Tk als Farbe akzeptiert werden, gelten als gültiges Farbargument. Beachten Sie, dass das Tk-Paket geladen sein muss, um den Typ *color* verwenden zu können. TEPAM verwendet den folgenden Befehl zur Validierung des Farbtyps:


```
expr ![catch {winfo rgb . <argument_value>}]
```

**•**
: *font* Alle Zeichenfolgen, die von Tk als Schriftart akzeptiert werden, gelten als gültiges Schriftart-Argument. Beachten Sie, dass das Tk-Paket geladen sein muss, um den Typ *font* verwenden zu können. TEPAM verwendet den folgenden Befehl zur Validierung des Schriftarttyps:


```
expr ![catch {font measure <argument_value> ""}]
```

**•**
: *file* Alle Zeichenfolgen, die keines der folgenden Zeichen enthalten, gelten als gültige Dateinamen: \* ? " < >. Es ist nicht erforderlich, dass die Datei und das Verzeichnis, in dem sie sich befindet, vorhanden sind. Zeichenfolgen der Länge Null gelten nicht als gültige Dateinamen. Zur Validierung der Dateinamen wird der folgende Ausdruck verwendet:


```
expr [string length <argument_value>]>0 && ![regexp {[\"*?<>:]} <argument_value>]
```

**•**
: *existingfile* Das Argument ist gültig, wenn es mit einer vorhandenen Datei übereinstimmt. Zur Validierung der Argumente dieses Typs wird folgende Prüfung durchgeführt:


```
file exists <argument_value>
```

**•**
: *directory* Ein Argument vom Typ directory wird auf genau dieselbe Weise validiert wie die Argumente vom Typ file.

**•**
: *existingdirectory* Das Argument ist gültig, wenn es mit einem vorhandenen Verzeichnis übereinstimmt. Zur Validierung der Argumente dieses Typs wird folgende Prüfung durchgeführt:


```
file isdirectory <argument_value>
```

## Anwendungsspezifische Argumenttypen definieren

Um die Unterstützung für einen neuen anwendungsspezifischen Argumenttyp hinzuzufügen, muss lediglich im Namespace **tepam** eine Validierungsfunktion **Validation(\<type>)** hinzugefügt werden. Diese Funktion erwartet ein Argument. Sie muss **1** zurückgeben, wenn das übergebene Argument dem entsprechenden Datentyp entspricht, andernfalls **0**.

Der Abschnitt mit den Validierungsbefehlen im Paket *tepam.tcl* enthält genügend Beispiele für Validierungsfunktionen, da dort die Funktionen für die Standard-TEPAM-Typen implementiert sind.

Der folgende zusätzliche Codeausschnitt zeigt die Validierungsfunktion für einen benutzerdefinierten Argumenttyp, der Werte mit einer Zeichenfolgenlänge von genau 2 erfordert:

```
proc tepam::Validate(two_char) {v} {expr {[string length $v]==2}}
```

# PROZEDUREN-AUFRUFE

## Hilfe

Jede Prozedur kann mit dem Flag *-help* aufgerufen werden. Die Prozedur gibt dann einen generierten Hilfetext an *stdout* aus und kehrt anschließend zurück, ohne weitere Aktionen auszuführen.

Für die erste in **PROZEDUREN-AUFRUFE** deklarierte Prozedur würden die Hilfeanfrage und der ausgegebene Hilfetext wie folgt lauten:

```
display message -help
->
NAME
      display message - Displays a simple message box
SYNOPSIS
      display message
            [-mtype <mtype>]
               Message type, default: "Warning", choices: {Info, Warning, Error}
            <text>
               Multiple text lines to display, type: string
DESCRIPTION
      This procedure allows displaying a configurable message box. The default
      message type that is created is a warning, but also errors and info can
      be generated.
      The procedure accepts multiple text lines.
EXAMPLE
      display message -mtype Warning "Save first your job"
```

Der Argumentmanager prüft, ob das zuletzt übergebene Argument *-help* lautet, und generiert in diesem Fall die angeforderte Hilfemeldung. Somit wird auch im folgenden Beispiel die Hilfemeldung ausgegeben:

```
display message -mtype Info "It is 7:00" -help
```

Andererseits führt der folgende Aufruf zu einem Fehler:

```
display message -help -mtype Info "It is 7:00"
->
display message: Argument '-help' not known
```

## Interaktiver Aufruf einer Prozedur

Wenn Tk geladen wurde, kann eine Prozedur mit dem Flag *-interactive* aufgerufen werden, um ein grafisches Formular zu öffnen, in dem alle Prozedurargumente interaktiv angegeben werden können. Das folgende Beispiel stellt sicher, dass die Tk-Bibliothek geladen ist, und zeigt die Befehlszeile zum interaktiven Aufruf der unter **PROZEDUREN-AUFRUFE** deklarierten Prozedur:

```
package require Tk
display message -interactive
```

Auch das Flag *-interactive* muss an der letzten Argumentposition stehen, wie es auch für das Flag *-help* erforderlich ist. Argumente, die vor dem Flag *-interactive* definiert sind, werden ignoriert. Das folgende Beispiel ist daher ebenfalls ein gültiger interaktiver Aufruf einer Prozedur:

```
display message -mtype Info "It is 7:00" -interactive
```

## Unbenannte Argumente

Unbenannte Argumente werden der aufgerufenen Prozedur in der Regel als einfache Parameter übergeben. Bei dieser Form des Prozeduraufrufs müssen die übergebenen Argumente streng der Reihenfolge der angegebenen Argumente entsprechen. Dem letzten Argument können mehrere Parameter zugewiesen werden, sofern dieses über das Attribut *-multiple* verfügt. Somit gilt für die folgende deklarierte Prozedur …

```
tepam::procedure {display_message} {
   -args {
      {mtype -choices {Info Warning Error}}
      {text -type string -multiple}
   }
} {
   puts "$mtype: [join $text]"
}
```

... kann beispielsweise auf folgende Weise aufgerufen werden:

```
display_message Info "It is PM 7:00."
-> Info: It is PM 7:00.

display_message Info "It is PM 7:00." "You should go home."
-> Info: It is PM 7:00. You should go home.
```

Das Schöne daran ist, dass unbenannte Argumente auch als benannte Argumente übergeben werden können, was beispielsweise dann praktisch sein kann, wenn einem Benutzer die genaue Reihenfolge der Argumente nicht bekannt ist:

```
display_message -mtype Info -text "It is PM 7:00."
-> Info: It is PM 7:00.

display_message -text "It is PM 7:00." -mtype Info
-> Info: It is PM 7:00.

display_message -mtype Info -text "It is PM 7:00." -text "You should go home."
-> Info: It is PM 7:00. You should go home.

display_message -text "It is PM 7:00." -text "You should go home." -mtype Info
-> Info: It is PM 7:00. You should go home.
```

## Benannte Argumente

Benannte Argumente müssen einer Prozedur in Form von Parameterpaaren übergeben werden, die sich aus den Argumentnamen und den Argumentwerten zusammensetzen. Die Reihenfolge, in der sie bei einem Prozeduraufruf übergeben werden, ist unerheblich und muss nicht mit der Reihenfolge in der Argumentspezifikation übereinstimmen.

Die folgende deklarierte Prozedur …

```
tepam::procedure {display_message} {
   -args {
      {-mtype -choices {Info Warning Error}}
      {-text -type string -multiple}
   }
} {
   puts "$mtype: [join $text]"
}
```

... kann auf folgende Weise aufgerufen werden:

```
display_message -mtype Info -text "It is PM 7:00."
-> Info: It is PM 7:00.

display_message -text "It is PM 7:00." -mtype Info
-> Info: It is PM 7:00.

display_message -mtype Info -text "It is PM 7:00." -text "You should go home."
-> Info: It is PM 7:00. You should go home.

display_message -text "It is PM 7:00." -text "You should go home." -mtype Info
-> Info: It is PM 7:00. You should go home.
```

Auch benannte Argumente, die nicht über das Attribut *-multiple* verfügen, können mehrfach angegeben werden. In einem solchen Fall wird nur das zuletzt angegebene Argument berücksichtigt:

```
display_message -mtype Info -text "It is PM 7:00." -mtype Warning
-> Warning: It is PM 7:00.
```

## Unbenannte Argumente zuerst, benannte Argumente danach (Tk-Stil)

Eine Prozedur, die definiert wurde, während die Variable **tepam::named_arguments_first** auf 1 gesetzt war, oder bei der das Prozedurattribut *-named_arguments_first* auf 1 gesetzt war, muss im Tcl-Stil aufgerufen werden. Die folgende Deklaration einer Prozedur wird in diesem Abschnitt verwendet, um die Bedeutung dieser Aufrufweise zu veranschaulichen:

```
set tepam::named_arguments_first 1
tepam::procedure my_proc {
   -args {
      {-n1 -default ""}
      {-n2 -default ""}
      {u1 -default ""}
      {u2 -default ""}
   }
} {
   puts "n1:'$n1', n2:'$n2', u1:'$u1', u2:'$u2'"
}
```

Die unbenannten Argumente werden am Ende des Prozeduraufrufs hinter den benannten Argumenten platziert:

```
my_proc -n1 N1 -n2 N2 U1 U2
-> n1:'N1', n2:'N2', u1:'U1', u2:'U2'
```

Der Argumentparser betrachtet das erste Argument, das nicht mit dem Zeichen „-“ beginnt, sowie alle nachfolgenden Argumente als unbenannte Argumente:

```
my_proc U1 U2
-> n1:'', n2:'', u1:'U1', u2:'U2'
```

Benannte Argumente können mehrfach definiert werden. Wenn das benannte Argument über das Attribut *-multiply* verfügt, werden alle Argumentwerte in einer Liste zusammengefasst. Andernfalls wird nur der zuletzt angegebene Wert beibehalten:

```
my_proc -n1 N1 -n2 N2 -n1 M1 U1 U2
-> n1:'M1', n2:'N2', u1:'U1', u2:'U2'
```

Der Name des ersten unbenannten Arguments darf daher nicht mit dem Zeichen „-“ beginnen. Andernfalls wird das unbenannte Argument als Name eines anderen benannten Arguments interpretiert. Dies ist insbesondere dann von Bedeutung, wenn das erste unbenannte Argument durch eine Variable angegeben wird, die beliebige Zeichenfolgen enthalten kann:

```
my_proc -n1 N1 -n2 N2 "->" "<-"
-> my_proc: Argument '->' not known

set U1 "->"
my_proc -n1 N1 -n2 N2 $U1 U2
my_proc: Argument '->' not known
```

Das Flag „--“ ermöglicht es, die unbenannten Argumente eindeutig von den benannten Argumenten zu trennen. Alle Daten nach dem Flag „--“ werden als unbenanntes Argument betrachtet:

```
my_proc -n1 N1 -n2 N2 -- "->" "<-"
-> n1:'N1', n2:'N2', u1:'->', u2:'<-'

set U1 "->"
my_proc -n1 N1 -n2 N2 -- $U1 U2
-> n1:'N1', n2:'N2', u1:'->', u2:'<-'
```

## Benannte Argumente zuerst, unbenannte Argumente danach (Tcl-Stil)

Der Tk-Aufrufstil wird gewählt, wenn eine Prozedur definiert wird, während die Variable **tepam::named_arguments_first** auf 0 gesetzt ist, oder wenn das Prozedurattribut *-named_arguments_first* auf 0 gesetzt wurde. Zur Veranschaulichung dieser Aufrufart wird in diesem Abschnitt die folgende Prozedur verwendet:

```
set tepam::named_arguments_first 0
tepam::procedure my_proc {
   -args {
      {-n1 -default ""}
      {-n2 -default ""}
      {u1}
      {u2 -default "" -multiple}
   }
} {
   puts "n1:'$n1', n2:'$n2', u1:'$u1', u2:'$u2'"
}
```

In diesem Fall müssen die unbenannten Argumente zuerst angegeben werden. Die benannten Argumente werden anschließend angegeben:

```
my_proc U1 U2 -n1 N1 -n2 N2
-> n1:'N1', n1:'N1', u1:'U1', u2:'U2'
```

Der Argumentparser weist jedem definierten, unbenannten Argument einen Wert zu, bevor er zum Einlesen der benannten Argumente übergeht. Dieses Standardverhalten ändert sich geringfügig, wenn es unbenannte Argumente gibt, die optional sind oder mehrere Werte annehmen können.

Einem unbenannten Argument, das optional ist (das entweder das Attribut *-optional* besitzt oder einen Vorgabewert hat), wird nur dann ein Wert zugewiesen, wenn der Wert nicht mit dem Zeichen „-“ beginnt oder wenn keine benannten Argumente definiert sind. Ein Wert, der mit „-“ beginnt, wird andernfalls als Name eines benannten Arguments betrachtet.

Einem Argument, das das Attribut *-multiple* aufweist, werden Werte zugewiesen, solange der Parameterwert nicht mit dem Zeichen „-“ beginnt.

Werte, die mit dem Zeichen „-“ beginnen, können daher keinen optionalen, unbenannten Argumenten zugewiesen werden, was die Verwendung des Tcl-Prozeduraufrufstils einschränkt. Der Tk-Stil ist in manchen Fällen möglicherweise vorzuziehen, da er eine eindeutige Trennung der benannten von den unbenannten Argumenten mittels des Flags „--“ ermöglicht.

Lassen Sie uns nun etwas weniger theoretisch untersuchen, auf welche Weise die zuvor definierte Prozedur aufgerufen werden kann: Im ersten Beispiel wird die Prozedur ohne Parameter aufgerufen, was zu einem Fehler führt, da *u1* ein obligatorisches Argument ist:

```
my_proc
-> my_proc: Required argument is missing: u1
```

Der Prozeduraufruf ist gültig, wenn für *u1* ein Parameter angegeben wird:

```
my_proc U1
-> n1:'', n2:'', u1:'U1', u2:''
```

Wenn weitere Parameter angegeben werden, die nicht mit dem Zeichen „-“ beginnen, werden diese den unbenannten Argumenten zugeordnet. *U2* erhält drei dieser Parameter, da es mehrere Werte akzeptiert:

```
my_proc U1 U2 U3 U4
-> n1:'', n2:'', u1:'U1', u2:'U2 U3 U4'
```

Sobald ein Parameter mit „-“ beginnt und alle unbenannten Argumente zugewiesen wurden, versucht der Argumentmanager, den Parameter als Namen eines benannten Arguments zu interpretieren. Der Prozeduraufruf schlägt fehl, wenn einem unbenannten Argument ein Wert zugewiesen wird, der mit „-“ beginnt:

```
my_proc U1 U2 U3 U4 -U5
-> my_proc: Argument '-U5' not known
```

Die Zuweisung eines Parameters zu einem benannten Argument schlägt fehl, wenn undefinierte, unbenannte (nicht optionale) Argumente vorhanden sind. Die Namensangabe wird in diesem Fall einfach als Parameterwert betrachtet, der dem *nächsten* unbenannten Argument zugewiesen wird. Dies war im folgenden Beispiel sicherlich nicht beabsichtigt:

```
my_proc -n1 N1
-> n1:'', n2:'', u1:'-n1', u2:'N1'
```

Die Situation ist völlig anders, wenn allen obligatorischen, unbenannten Argumenten bereits Werte zugewiesen wurden. Ein Parameter, der mit dem Zeichen „-“ beginnt, wird in diesem Fall als Namensbezeichner für ein benanntes Argument betrachtet:

```
my_proc U1 -n1 N1
-> n1:'N1', n2:'', u1:'U1', u2:''
```

Hinter den benannten Argumenten sind keine unbenannten Argumente zulässig:

```
my_proc U1 -n1 N1 U2
-> my_proc: Argument 'U2' is not an option
```

Das Flag „--“ hat keine besondere Bedeutung, wenn nicht allen obligatorischen Argumenten ein Wert zugewiesen wurde. Dieses Flag wird einfach einem der unbenannten Argumente zugeordnet:

```
my_proc -- -n1 N1
-> n1:'N1', n2:'', u1:'--', u2:''
```

Das Flag „--“ wird jedoch einfach ignoriert, wenn der Argumentparser bereits mit der Verarbeitung der benannten Argumente begonnen hat:

```
my_proc U1 -- -n1 N1
-> n1:'N1', n2:'', u1:'U1', u2:''

my_proc U1 -n1 N1 -- -n2 N2
-> n1:'N1', n2:'N2', u1:'U1', u2:''
```

## Roh-Argumentliste

Manchmal kann es erforderlich sein, dass der Prozedurkörper auf die gesamte Liste der bei einem Prozeduraufruf übergebenen Argumente zugreifen kann. Dies ist über die Variable **args** möglich, die stets die unverarbeitete Argumentliste enthält:

```
tepam::procedure {display_message} {
   -args {
      {-mtype -choices {Warning Error} -default Warning}
      {text -type string -multiple}

   }
} {
   puts "args: $args"
}
display_message -mtype Warning "It is 7:00"
-> args: -mtype Warning {It is 7:00}
```

# KATEGORIE

Prozeduren, Argumente, Parameter, Optionen

# COPYRIGHT

```
Copyright (c) 2009-2013, Andreas Drollinger
```
