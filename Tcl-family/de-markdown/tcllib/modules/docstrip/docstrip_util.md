---
CommandName: docstrip_util
ManualSection: n
Version: 1.3.3
TclPart: tcllib
TclDescription: Literate programming tool
Links:
 - docstrip
 - doctools
 - doctools_fmt
Keywords:
 - \.ddt
 - dtx
 - LaTeX
 - Tcl module
 - catalogue
 - diff
 - docstrip
 - doctools
 - documentation
 - literate programming
 - module
 - package indexing
 - patch
 - source
Copyright:
 - Copyright (c) 2003–2010 Lars Hellström <Lars dot Hellstrom at residenset dot net>
---

# NAME

docstrip_util – Dienstprogramme im Zusammenhang mit Docstrip

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [docstrip]{.lit} [1.3]{.optlit} 
[package]{.cmd} [require]{.sub} [docstrip::util]{.lit} [1.3.3]{.optlit} 
[pkgProvide]{.cmd} [name]{.arg} [version]{.arg} [terminals]{.arg} 
[pkgIndex]{.cmd} [terminal]{.optdot} 
[fileoptions]{.cmd} [option value]{.optdot} 
[docstrip::util::index_from_catalogue]{.cmd} [dir]{.arg} [pattern]{.arg} [option value]{.optdot} 
[docstrip::util::modules_from_catalogue]{.cmd} [target]{.arg} [source]{.arg} [option value]{.optdot} 
[docstrip::util::classical_preamble]{.cmd} [metaprefix]{.arg} [message]{.arg} [target]{.arg} [source terminals]{.optdot} 
[docstrip::util::classical_postamble]{.cmd} [metaprefix]{.arg} [message]{.arg} [target]{.arg} [source terminals]{.optdot} 
[docstrip::util::packages_provided]{.cmd} [text]{.arg} [setup-script]{.optarg} 
[docstrip::util::ddt2man]{.cmd} [text]{.arg} 
[docstrip::util::guards]{.cmd} [subcmd]{.arg} [text]{.arg} 
[docstrip::util::patch]{.cmd} [source-var]{.arg} [terminals]{.arg} [fromtext]{.arg} [diff]{.arg} [option value]{.optdot} 
[docstrip::util::thefile]{.cmd} [filename]{.arg} [option value]{.optdot} 
[docstrip::util::import_unidiff]{.cmd} [diff-text]{.arg} [warning-var]{.optarg} 
:::

# BESCHREIBUNG

Das Paket „**docstrip::util**“ dient der Zusammenstellung verschiedener Hilfsprozeduren, die vor allem während der Installation oder der Entwicklungsphase nützlich sind. Es ist vom Basispaket getrennt, um einen Mehraufwand zu vermeiden, wenn dieses zur Kompilierung von „**source**“-Code verwendet wird.

# BEFEHLE ZUR PAKETINDIZIERUNG

Ähnlich wie bei rohen „*.tcl*“-Dateien können die Codezeilen in Docstrip-Quelldateien nach Paketdeklarationen durchsucht und entsprechende Indizes erstellt werden. Eine Komplikation besteht jedoch darin, dass man anhand der Codeblöcke selbst nicht erkennen kann, welche Teile zusammen ein funktionierendes Paket ergeben; normalerweise wäre diese Information in einer begleitenden „*.ins*“-Datei zu finden, doch das Parsen einer solchen Datei ist keine leichte Aufgabe. Daher führt **docstrip::util** eine alternative Kodierung solcher Informationen in Form eines deklarativen Tcl-Skripts ein: den *Katalog* (des Inhalts einer Quelldatei).

Die folgenden Sonderbefehle stehen innerhalb eines Katalogs zur Verfügung:

**pkgProvide** *name* *version* *terminals*
: Legt fest, dass der Code für ein Paket mit dem Namen *name* und der Version *version* aus jenen Modulen in der Quelldatei besteht, die durch die Liste *terminals* der Terminale des Schutzausdrucks ausgewählt werden. Dieser Code sollte vorzugsweise keinen Befehl **package** **provide** für das Paket enthalten, da ein solcher durch die Mechanismen zum Laden des Pakets bereitgestellt wird.

**pkgIndex** ?*terminal* ...?
: Gibt an, dass sich der Code für ein Paket aus jenen Modulen in der Quelldatei zusammensetzt, die durch die aufgeführten *terminal*-Ausdrücke der Schutzklausel ausgewählt werden. Der Name und die Version dieses Pakets werden anhand der in diesem Code gefundenen Befehle **package** und **provide** ermittelt (daher muss ein solcher Befehl darin enthalten sein).

**fileoptions** ?*option* *value* ...?
: Legt die **fconfigure**-Optionen fest, die beim Einlesen der Quelle gelten sollen; bei reinen ASCII-Dateien kann dies in der Regel ignoriert werden. Wenn die Datei jedoch gemäß einer anderen **-encoding**-Einstellung interpretiert werden muss, kann dies auf diese Weise festgelegt werden. Der Befehl sollte normalerweise an erster Stelle im Katalog stehen, da er nur für die darauf folgenden Befehle wirksam ist. Andere Tcl-Befehle werden ebenfalls unterstützt – ein Katalog wird durch Auswertung in einem sicheren Interpreter analysiert –, doch sind diese selten erforderlich. Um zukünftige Erweiterungen zu ermöglichen, werden unbekannte Befehle im Katalog stillschweigend ignoriert. Um die Verteilung von Katalogen zusammen mit ihren Quelldateien zu vereinfachen, wird der Katalog *in der Quelldatei selbst* als Modul gespeichert, das durch das Terminal „**docstrip.tcl::catalogue**“ ausgewählt wird. Dies unterstützt sowohl die Vorgehensweise, alle Katalogzeilen an einer Stelle zu sammeln, als auch die Vorgehensweise, jede Katalogzeile in unmittelbarer Nähe des Codes zu platzieren, den sie deklariert. Die Platzierung von Katalogeinträgen neben dem Code, den sie deklarieren, könnte wie folgt aussehen


```
%    First there's the catalogue entry
%    \begin{tcl}
%<docstrip.tcl::catalogue>pkgProvide foo::bar 1.0 {foobar load}
%    \end{tcl}
%    second a metacomment used to include a copyright message
%    \begin{macrocode}
%<*foobar>
%% This file is placed in the public domain.
%    \end{macrocode}
%    third the package implementation
%    \begin{tcl}
namespace eval foo::bar {
   # ... some clever piece of Tcl code elided ...
%    \end{tcl}
%    which at some point may have variant code to make use of a
%    |load|able extension
%    \begin{tcl}
%<*load>
   load [file rootname [info script]][info sharedlibextension]
%</load>
%<*!load>
   # ... even more clever scripted counterpart of the extension
   # also elided ...
%</!load>
}
%</foobar>
%    \end{tcl}
%    and that's it!
```

Die entsprechende Konfiguration mit **pkgIndex** würde wie folgt lauten:

```
%    First there's the catalogue entry
%    \begin{tcl}
%<docstrip.tcl::catalogue>pkgIndex foobar load
%    \end{tcl}
%    second a metacomment used to include a copyright message
%    \begin{tcl}
%<*foobar>
%% This file is placed in the public domain.
%    \end{tcl}
%    third the package implementation
%    \begin{tcl}
package provide foo::bar 1.0
namespace eval foo::bar {
   # ... some clever piece of Tcl code elided ...
%    \end{tcl}
%    which at some point may have variant code to make use of a
%    |load|able extension
%    \begin{tcl}
%<*load>
   load [file rootname [info script]][info sharedlibextension]
%</load>
%<*!load>
   # ... even more clever scripted counterpart of the extension
   # also elided ...
%</!load>
}
%</foobar>
%    \end{tcl}
%    and that's it!
```

**docstrip::util::index_from_catalogue** *dir* *pattern* ?*option* *value* ...?
: Dieser Befehl ist dem Standardbefehl **pkg_mkIndex** insofern ähnlich, als er Paketeinträge zu den Dateien „*pkgIndex.tcl*“ hinzufügt. Der Unterschied besteht darin, dass er Quelldateien im **docstrip**-Format indexiert und nicht rohe „*.tcl*“-Dateien oder ladbare Bibliotheksdateien. Es werden nur Pakete berücksichtigt, die im Katalog einer Datei aufgeführt sind. Das Argument *dir* ist das Verzeichnis, in dem nach Dateien gesucht werden soll (und dessen „*pkgIndex.tcl*“-Datei entsprechend angepasst werden sollte). Das Argument *pattern* ist ein Muster im Format **glob** für die zu durchsuchenden Dateien; ein typischer Wert wäre **\*.dtx** or **\*.{dtx,ddt}**. Die übrigen Argumente sind Option-Wert-Paare, wobei folgende Optionen unterstützt werden:


**-recursein** *dirpattern*
: Wenn diese Option angegeben wird, wird die Operation **index_from_catalogue** in jedem Unterverzeichnis wiederholt, dessen Name mit dem Muster *dirpattern* übereinstimmt. **-recursein** **\*** bewirkt, dass der gesamte Unterverzeichnisbaum mit *dir* als Stammverzeichnis in den Index aufgenommen wird.

**-sourceconf** *dictionary*
: Gibt **fileoptions** an, wenn Sie die Dateikataloge lesen (sowie beim Lesen der Pakete, wenn der Katalog keinen Befehl „**fileoptions**“ enthält). Standardmäßig ist das Feld leer. Dies ist vor allem dann nützlich, wenn sich die Kodierung Ihres Systems stark von der der Quelldatei unterscheidet (z. B. wenn es sich bei der einen um eine Zwei-Byte-Kodierung und bei der anderen um eine Ein-Byte-Kodierung handelt). **ascii** und **utf-8** unterscheiden sich in dieser Hinsicht nicht wesentlich.

**-options** *terminals*
: Die *terminals* sind eine Liste von Terminals zusätzlich zu **docstrip.tcl::catalogue**, die beim Extrahieren des Katalogs als „wahr“ markiert werden sollen. Standardmäßig ist diese Liste leer. Dies ermöglicht die Verwendung von „Variantenabschnitten“ im Katalog selbst, z. B. um bestimmte Einträge mit einem zusätzlichen „experimentellen“ Kennzeichen zu kennzeichnen und so zu verhindern, dass sie im Index erscheinen, es sei denn, dieser wird mit „experimentell“ in der Liste **-options** generiert.

**-report** *boolean*
: Wenn der *boolean* „true“ ist, dann gibt der Programmcode einen textuellen, wahrscheinlich mehrzeiligen Bericht darüber zurück, was ausgeführt wurde. Der Standardwert ist „false“; in diesem Fall gibt es keinen bestimmten Rückgabewert.

**-reportcmd** *commandPrefix*
: Jeder Eintrag im Bericht wird als zusätzliches Argument an das Befehlspräfix übergeben. Da „**index_from_catalogue**“ in der Regel auf einer relativ hohen Ebene in Installationsskripten und dergleichen verwendet wird, ist der Standardwert für *commandPrefix* „**puts** **stdout**“. Verwenden Sie **list**, um diese Funktion effektiv zu deaktivieren. Die Werte des Präfixes werden ignoriert.


: Die generierten **package ifneeded**-Skripte enthalten einen **package require docstrip**-Befehl und einen **docstrip::sourcefrom**-Befehl. Wenn es sich bei dem Katalogeintrag um den Typ **pkgProvide** handelt, enthält das Skript **package ifneeded** zudem den Befehl **package provide**. Hinweis: **index_from_catalogue** entfernt niemals etwas aus einer bestehenden „*pkgIndex.tcl*“-Datei. Daher müssen Sie diese möglicherweise löschen (oder von **pkg_mkIndex** von Grund auf neu erstellen lassen), bevor Sie **index_from_catalogue** ausführen, um bestimmte Informationen, wie beispielsweise eine Versionsnummer für ein Paket, zu aktualisieren.


**docstrip::util::modules_from_catalogue** *target* *source* ?*option* *value* ...?
: Dieser Befehl stellt eine Alternative zu **index_from_catalogue** dar, der anstelle von „*pkgIndex.tcl*“-Einträgen Tcl-Modul-Dateien („*.tm*“) erstellt. Da diese Aktion eher der klassischen Funktionsweise von **docstrip** entspricht, verfügt sie über Funktionen zum Einfügen von Vor- und Nachworten in die generierten Dateien. Das Argument *source* ist der Name der Quelldatei, aus der „*.tm*“-Dateien generiert werden sollen. Das Argument *target* ist das Verzeichnis, das als Modulpfad gelten soll, d. h., dies ist der Pfad, an den die aus den Paketnamen abgeleiteten relativen Pfade angehängt werden. Die unterstützten Optionen sind:


**-preamble** *message*
: Eine Meldung, die in die Präambel (den einleitenden Kommentarblock) der generierten Dateien eingefügt werden soll. Standardmäßig ist dies ein Leerzeichen. Es können mehrere Zeilen sein, die dann durch Zeilenumbrüche voneinander getrennt werden. Traditionell wird dies für Copyright-Hinweise oder Ähnliches verwendet, doch Metakommentarzeilen bieten hierfür eine Alternative.

**-postamble** *message*
: Ähnlich wie **-preamble**, jedoch wird die Nachricht am Dateiende statt am Anfang eingefügt. Standardmäßig ist das Feld leer.

**-sourceconf** *dictionary*
: Legt die **fileoptions** fest, die beim Einlesen des Katalogs der *source* verwendet werden (und auch beim Einlesen der Pakete, wenn der Katalog keinen Befehl **fileoptions** enthält). Standardmäßig ist das Feld leer. Dies ist vor allem dann nützlich, wenn sich die Kodierung Ihres Systems stark von der der Quelldatei unterscheidet (z. B. wenn es sich bei der einen um eine Zwei-Byte-Kodierung und bei der anderen um eine Ein-Byte-Kodierung handelt). **ascii** und **utf-8** unterscheiden sich in dieser Hinsicht nicht wesentlich.

**-options** *terminals*
: Die *terminals* ist eine Liste von Terminals zusätzlich zu **docstrip.tcl::catalogue**, die beim Extrahieren des Katalogs als „wahr“ behandelt werden sollen. Standardmäßig ist diese Liste leer. Dies ermöglicht die Verwendung von „Variantenabschnitten“ im Katalog selbst, z. B. um bestimmte Einträge mit einer zusätzlichen „experimentellen“ Schutzklausel abzusichern und somit zu verhindern, dass diese Pakete beitragen, es sei denn, diese werden mit „experimentell“ in der Liste **-options** generiert.

**-formatpreamble** *commandPrefix*
: Befehlspräfix, das zur eigentlichen Formatierung der Präambel verwendet wird. Es nimmt vier zusätzliche Argumente entgegen: *message*, *targetFilename*, *sourceFilename* und *terminalList* und gibt eine vollständig formatierte Präambel zurück. Standardmäßig wird **classical_preamble** mit einem *metaprefix* von „##“ verwendet.

**-formatpostamble** *commandPrefix*
: Befehlspräfix, das zur eigentlichen Formatierung des Postambels verwendet wird. Es nimmt vier zusätzliche Argumente entgegen: *message*, *targetFilename*, *sourceFilename* und *terminalList* und gibt ein vollständig formatiertes Postambel zurück. Standardmäßig wird **classical_postamble** mit einem *metaprefix* von „##“ verwendet.

**-report** *boolean*
: Wenn der *boolean* „true“ (was die Standardeinstellung ist), so gibt der Programmcode einen textuellen, wahrscheinlich mehrzeiligen Bericht darüber zurück, was ausgeführt wurde. Wenn er „false“ ist, gibt es keinen bestimmten Wert.

**-reportcmd** *commandPrefix*
: Jeder Eintrag im Bericht wird als zusätzliches Argument an dieses Befehlspräfix übergeben. Der Standardwert ist **list**, wodurch diese Funktion effektiv deaktiviert wird. Die Rückgabewerte des Präfixes werden ignoriert. Verwenden Sie beispielsweise „**puts** **stdout**“, um Berichtselemente sofort auf das Terminal auszugeben.


: Eine bereits vorhandene Datei, die denselben Namen wie die zu erstellende Datei trägt, wird überschrieben.


**docstrip::util::classical_preamble** *metaprefix* *message* *target* ?*source* *terminals* ...?
: Dieser Befehl gibt eine Einleitung im klassischen **docstrip**-Stil zurück


```
##
## This is `TARGET',
## generated by the docstrip::util package.
##
## The original source files were:
##
## SOURCE (with options: `foo,bar')
##
## Some message line 1
## line2
## line3
```

: Wenn …


```
docstrip::util::classical_preamble {##}\
  "\nSome message line 1\nline2\nline3" TARGET SOURCE {foo bar}
```

: Der Befehl unterstützt Präambeln für Dateien, die aus mehreren Quellen generiert wurden, auch wenn **modules_from_catalogue** dies derzeit nicht benötigt.


**docstrip::util::classical_postamble** *metaprefix* *message* *target* ?*source* *terminals* ...?
: Dieser Befehl gibt eine Postamble im klassischen **docstrip**-Stil zurück


```
## Some message line 1
## line2
## line3
##
## End of file `TARGET'.
```

: Wenn …


```
docstrip::util::classical_postamble {##}\
  "Some message line 1\nline2\nline3" TARGET SOURCE {foo bar}
```

: Mit anderen Worten: Die Argumente *source* und *terminals* werden ignoriert, werden jedoch aus Gründen der Symmetrie gegenüber **classical_preamble** unterstützt.


**docstrip::util::packages_provided** *text* ?*setup-script*?
: Dieser Befehl gibt eine Liste zurück, in der jedes Element mit geradem Index den Namen eines Pakets **provide**d von *text* enthält, wenn dieses als Tcl-Skript ausgewertet wird, und das darauf folgende Element mit ungeradem Index die entsprechende Version angibt. Er dient zur Indexierung von Paketen mit extrahiertem Code, ähnlich wie bei **pkg_mkIndex**. Ein Unterschied zu **pkg_mkIndex** besteht darin, dass der *text* in einem sicheren Interpreter ausgewertet wird. Befehle vom Typ **package require** werden stillschweigend ignoriert, ebenso wie unbekannte Befehle (darunter **source** und **load**). Andere Fehler führen dazu, dass der Prozess des *text* abgebrochen wird; in diesem Fall werden nur jene Paketdeklarationen in den Rückgabewert aufgenommen, die vor dem Fehler angetroffen wurden. Das Argument *setup-script* kann verwendet werden, um die Umgebung der Auswertung anzupassen, wenn der Code in *text* ganz besondere Anforderungen stellt. Das *setup-Skript* wird im lokalen Kontext der Prozedur **packages_provided** unmittelbar vor der Verarbeitung von *text* ausgewertet. Zu diesem Zeitpunkt wird der Name des Slave-Befehls für den sicheren Interpreter, der diese Verarbeitung durchführt, in der lokalen Variablen **c** gespeichert. Um beispielsweise den Inhalt des Arrays **::env** in den sicheren Interpreter zu kopieren, könnte man ein *setup-Skript* mit folgendem Inhalt verwenden:


```
  $c eval [list array set env [array get ::env]]
```

# BEFEHLE ZUR QUELLDATENVERARBEITUNG

Im Gegensatz zur vorherigen Befehlsgruppe, die mit dem Befehl **docstrip::extract** bestimmte Codezeilen extrahierte und diese anschließend weiterverarbeitete, werden die folgenden Befehle auf Text angewendet, der aus Zeilen aller Art besteht.

**docstrip::util::ddt2man** *text*
: Der Befehl **ddt2man** formatiert *text* vom allgemeinen Format **docstrip** in das Format **doctools** „*.man*“ (Tcl Markup Language für Manpages) um. Die verschiedenen Zeilentypen werden wie folgt behandelt:


**comment and metacomment lines**
: Die Präfixe „%“ und „%%“ werden entfernt, der restliche Text bleibt unverändert.

**empty lines**
: Diese werden unverändert beibehalten. (Das bedeutet im Endeffekt, dass sie nach einer Kommentarzeile als Kommentarzeilen und nach einer Codezeile als Codezeilen gezählt werden.)

**code lines**
: Die Befehle **example_begin** und **example_end** werden am Anfang und am Ende jedes Blocks aufeinanderfolgender Codezeilen platziert. Klammern in einer Codezeile werden in die Befehle **lb** und **rb** umgewandelt.

**verbatim guards**
: Diese werden wie gewohnt im Prozess verarbeitet, sodass sie im Ergebnis nicht erscheinen; jede Zeile in einem Verbatim-Block wird jedoch als Codezeile behandelt.

**other guards**
: Diese werden als Codezeilen behandelt, mit der Ausnahme, dass die eigentliche Schutzklausel auf „**emph**“ basiert.


: Zum Zeitpunkt der Erstellung dieses Dokuments hat noch kein Projekt die **doctools**-Markups in den Master-Quelldateien verwendet, sodass noch keine Erfahrungen darüber vorliegen, was gut funktioniert. Eine Quelldatei könnte jedoch wie folgt aussehen


```
% [manpage_begin gcd n 1.0]
% [keywords divisor]
% [keywords math]
% [moddesc {Greatest Common Divisor}]
% [require gcd [opt 1.0]]
% [description]
%
% [list_begin definitions]
% [call [cmd gcd] [arg a] [arg b]]
%   The [cmd gcd] procedure takes two arguments [arg a] and [arg b] which
%   must be integers and returns their greatest common divisor.
proc gcd {a b} {
%   The first step is to take the absolute values of the arguments.
%   This relieves us of having to worry about how signs will be treated
%   by the remainder operation.
   set a [expr {abs($a)}]
   set b [expr {abs($b)}]
%   The next line does all of Euclid's algorithm! We can make do
%   without a temporary variable, since $a is substituted before the
%   [lb]set a $b[rb] and thus continues to hold a reference to the
%   "old" value of [var a].
   while {$b>0} { set b [expr { $a % [set a $b] }] }
%   In Tcl 8.3 we might want to use [cmd set] instead of [cmd return]
%   to get the slight advantage of byte-compilation.
%<tcl83>  set a
%<!tcl83>   return $a
}
% [list_end]
%
% [manpage_end]
```

: Wenn der obige Text durch **docstrip::util::ddt2man** geleitet wird, ergibt sich eine syntaktisch korrekte **doctools**-Manpage, auch wenn deren Zweck etwas anders ist. Es wird empfohlen, Master-Quellcode-Dateien mit **doctools**-Markup die Endung „*.ddt*“ zu geben; daher das „ddt“ in **ddt2man**.


**docstrip::util::guards** *subcmd* *text*
: Der Befehl **guards** gibt Informationen (vorwiegend statistischer Art) zu den gewöhnlichen „docstrip“-Schutzelementen zurück, die im *text* vorkommen. Der *subcmd* legt fest, welche Informationen zurückgegeben werden.


**counts**
: Listet die Guard-Ausdrucks-Terminale mit deren Häufigkeiten auf. Das Format des Rückgabewerts ist ein Dictionary, das den Namen des Terminals der Anzahl seiner Vorkommen in der Datei zuordnet.

**exprcount**
: Listet die Guard-Ausdrücke mit der jeweiligen Häufigkeit auf. Das Format des Rückgabewerts ist ein Dictionary, das den Ausdruck der Anzahl seiner Vorkommen in der Datei zuordnet.

**exprerr**
: Listet die syntaktisch fehlerhaften Guard-Ausdrücke auf (z. B. nicht übereinstimmende Klammern oder ein fehlendes Terminal). Der Wert ist eine Liste, deren Elemente in keiner bestimmten Reihenfolge stehen.

**expressions**
: Listet die Guard-Ausdrücke auf. Der Wert, der zurückgegeben wird, ist eine Liste, deren Elemente in keiner bestimmten Reihenfolge angeordnet sind.

**exprmods**
: Listet die Guard-Ausdrücke mit Modifikatoren auf. Das Format des Werts ist ein Dictionary, bei dem jeder Index ein Guard-Ausdruck ist und jeder Eintrag eine Zeichenkette mit einem Zeichen für jede Guard-Zeile, die diesen Ausdruck enthält. Die Zeichen im Eintrag legen fest, welcher Modifikator in dieser Zeile verwendet wurde: +, -, \*, / oder (für eine Schutzanweisung ohne Modifikator:) ein Leerzeichen. Dies ist die grundlegendste Form der von **guards** gesammelten Informationen.

**names**
: Gibt die Terminale des Guard-Ausdrucks aus. Der Wert ist eine Liste, deren Elemente in keiner bestimmten Reihenfolge angeordnet sind.

**rotten**
: Listet die fehlerhaften Guard-Zeilen auf (dabei sind jedoch Zeilen, in denen lediglich der Ausdruck fehlerhaft ist, nicht enthalten). Das Format des Werts, der zurückgegeben wird, ist ein Dictionary, das Zeilennummern ihrem Inhalt zuordnet.


**docstrip::util::patch** *source-var* *terminals* *fromtext* *diff* ?*option* *value* ...?
: Dieser Befehl versucht, eine **diff**-Datei (beispielsweise einen eingereichten Patch), die für eine generierte Datei berechnet wurde, auf die **docstrip**-Quelldatei anzuwenden. Dies kann nützlich sein, wenn jemand eine generierte Datei bearbeitet und sie dabei fälschlicherweise für die Quelldatei gehalten hat. Dieser Befehl trifft keine spezifischen Annahmen für den Fall, dass es sich bei der generierten Datei um ein Tcl-Skript handelt. **patch** setzt voraus, dass die zu patchen Quelldatei als Liste von Zeilen in einer Variablen gespeichert ist, und der Name dieser Variablen im Aufrufkontext wird in das Argument *source-var* übergeben. *terminals* ist die Liste der Terminals, die zum Extrahieren der gepatchten Datei verwendet werden. *diff* ist der tatsächlich anzuwendende Diff (in einem Format, wie unten erläutert), und *fromtext* ist der Inhalt der Datei, die bei der Berechnung des Diffs als „Ausgangsdatei“ diente. Mithilfe von Optionen lässt sich der Prozess weiter steuern. Der Prozess funktioniert, indem die „Hunks“ im *diff* von der generierten in die Quelldatei „übertragen“ und anschließend auf die Elemente der *source-var* angewendet werden. Um diese Übertragung durchzuführen, muss festgelegt werden, wie Zeilen im *fromtext* den Elementen der *source-var* entsprechen, und genau hier kommen die *terminals* ins Spiel; Die Quelldatei wird zunächst unter den angegebenen *terminals*extract**extract** verarbeitet, und das Ergebnis dieser Verarbeitung wird anschließend mit dem *fromtext* abgeglichen. Dadurch entsteht eine Zuordnung, die die im *diff* angegebenen Zeilennummern in Elementnummern in *source-var* übersetzt – genau das ist für das Übertragen der Blöcke erforderlich. Es gibt zwei Gründe, warum sowohl die *terminals* als auch der *fromtext* angegeben werden müssen. Erstens ist es sehr schwierig, den Überblick darüber zu behalten, wie viele Zeilen der Präambel auf andere Weise als durch das Kopieren von Zeilen aus Quelldateien bereitgestellt werden. Zweitens kann eine generierte Datei Material aus mehreren Quelldateien enthalten. Beides macht es unmöglich, vorherzusagen, welche Zeilennummer eine extrahierte Datei in der generierten Datei haben würde; daher sucht der Algorithmus zur Berechnung der Zeilennummernzuordnung stattdessen nach einem Zeilenblock im *fromtext*, der mit dem übereinstimmt, was aus der Quelle extrahiert werden kann. Dieser Abgleich wird durch die folgenden Optionen beeinflusst:


**-matching** *mode*
: Wie ähnlich müssen zwei Zeilen sein, damit sie übereinstimmen? Die unterstützten *mode* sind:


**exact**
: Zeilen müssen als Zeichenfolgen identisch sein. Dies ist die Standardeinstellung.

**anyspace**
: Alle Folgen von Leerzeichen werden vor dem Vergleich in einzelne Leerzeichen umgewandelt.

**nonspace**
: Wenn der Vergleich durchgeführt wird, werden ausschließlich Zeichen berücksichtigt, die keine Leerzeichen sind.

**none**
: Zwei beliebige Zeilen gelten als gleich.


**-metaprefix** *string*
: Der Wert „**-metaprefix**“, der beim Extrahieren verwendet werden soll. Der Standardwert lautet „%%“, doch bei Tcl-Code ist es wahrscheinlicher, dass für die generierte Datei „#“ oder „##“ verwendet wurde.

**-trimlines** *boolean*
: Der Wert „**-trimlines**“, der beim Extrahieren verwendet werden soll. Der Standardwert ist „true“.


: Der Wert wird in Form eines „Unified Diff“ gegeben und enthält ausschließlich jene Blöcke, die nicht oder nur teilweise übernommen wurden; ein Kommentar im Kopf jedes Blocks legt fest, welcher Fall vorliegt. In der Regel ist es erforderlich, sowohl den Wert von **patch** als auch den gepatchten Text selbst manuell zu überprüfen, da dieser Befehl Kommentarzeilen nicht an den neuen Inhalt anpassen kann. Ein Beispiel würde wie folgt aussehen:


```
set sourceL [split [docstrip::util::thefile from.dtx] \n]
set terminals {foo bar baz}
set fromtext [docstrip::util::thefile from.tcl]
set difftext [exec diff --unified from.tcl to.tcl]
set leftover [docstrip::util::patch sourceL $terminals $fromtext\
  [docstrip::util::import_unidiff $difftext] -metaprefix {#}]
set F [open to.dtx w]; puts $F [join $sourceL \n]; close $F
return $leftover
```

: Hier wurde „*from.dtx*“ als Vorlage für „*from.tcl*“ verwendet, das jemand zu „*to.tcl*“ umgeschrieben hat. Wir versuchen nun, eine Datei „*to.dtx*“ zu erstellen, die als Vorlage für „*to.tcl*“ dienen kann.


**docstrip::util::thefile** *filename* ?*option* *value* ...?
: Der Befehl **thefile** öffnet die Datei *filename*, liest sie bis zum Ende, schließt sie und gibt den Inhalt zurück (wobei ein eventuell vorhandener abschließender Zeilenumbruch entfernt wird). Die Option-Wert-Paare werden an **fconfigure** übergeben, um den geöffneten Dateikanal zu konfigurieren, bevor Daten daraus gelesen werden.

**docstrip::util::import_unidiff** *diff-text* ?*warning-var*?
: Dieser Befehl zerlegt einen Diff im unified-Format (**diff**-Schalter **-U** und **--unified**) in die Liste von Hunks, die **docstrip::util::patch** erwartet. *diff-text* ist der zu zerlegende Text. *warning-var* ist, falls angegeben, der Name einer Variablen im aufrufenden Kontext, an die Warnungen zu Zerlegungsproblemen mit **append** angehängt werden. Das Ergebnis ist eine Liste von *hunks*. Jeder Hunk ist eine Liste aus fünf Elementen: *start1*, *end1*, *start2*, *end2*, *lines*. *start1* und *end1* sind die Zeilennummern der ersten und der letzten Zeile des Hunks in der Datei „from“. *start2* und *end2* sind die entsprechenden Zeilennummern in der Datei „to“. Die Zählung beginnt bei 1. *lines* enthält je Zeile des Hunks zwei Elemente: zuerst die Art der Zeile, dann ihren Inhalt. Die Art ist **-** für Zeilen nur in „from“, **+** für Zeilen nur in „to“ und **0** für Zeilen in beiden.


# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2003–2010 Lars Hellström <Lars dot Hellstrom at residenset dot net>
```
