---
CommandName: docstrip
title: docstrip
ManualSection: n
Version: 1.3
TclPart: tcllib
TclDescription: Literate programming tool
Links:
 - docstrip_util
Keywords:
 - \.dtx
 - LaTeX
 - docstrip
 - documentation
 - literate programming
 - source
Copyright:
 - Copyright (c) 2003–2010 Lars Hellström <Lars dot Hellstrom at residenset dot net>
---

# Name

docstrip – Extraktion von Quellcode im Docstrip-Stil

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [docstrip]{.lit} [1.3]{.optlit}
[docstrip::extract]{.cmd} [text]{.arg} [terminals]{.arg} [option value]{.optdot}
[docstrip::sourcefrom]{.cmd} [filename]{.arg} [terminals]{.arg} [option value]{.optdot}
:::

# Beschreibung

**Docstrip** ist ein Tool, das zur Unterstützung einer Form der „Literate Programming“ entwickelt wurde. Es ist vor allem in der (La)TeX-Community verbreitet, wo es für nahezu alle Bereiche vom LaTeX-Kern aufwärts eingesetzt wird; es gibt jedoch keinen Grund, warum **docstrip** nicht auch für andere Arten von Software verwendet werden könnte.

Kurz gesagt besteht das Grundprinzip der literaten Programmierung darin, dass der Programmquellcode in erster Linie so geschrieben und strukturiert sein sollte, dass er den Entwicklern (und fortgeschrittenen Anwendern, die einen Blick „unter die Haube“ werfen möchten) entgegenkommt, und nicht den Launen eines Compilers oder eines entsprechenden Verwenders des Quellcodes. Das bedeutet, dass literate Quelltexte oft eine Art „Übersetzung“ in eine illiterate Form benötigen, die auch „dumme“ Software verstehen kann. Das Tcl-Paket **docstrip** übernimmt diese Übersetzung.

Selbst für diejenigen, die sich nicht uneingeschränkt der Philosophie hinter der „Literate Programming“ anschließen, kann **docstrip** insbesondere in folgenden Bereichen für mehr Klarheit sorgen:

- Programme, die nicht offensichtliche mathematische Konzepte nutzen

- Projekte, bei denen einzelne Codeabschnitte – möglicherweise in verschiedenen Sprachen – eng aufeinander abgestimmt werden müssen.


Zum einen, weil dadurch Zugriff auf weitaus leistungsfähigere Formatierungsfunktionen für Quellcode-Kommentare geboten wird, als dies im reinen Text möglich ist. Zum anderen, weil alle einzelnen Codeabschnitte nebeneinander in derselben Quelldatei zusammengefasst werden können.

Das funktioniert so, dass der Programmierer direkt nur eine oder mehrere „Master“-Quellcode-Dateien bearbeitet, aus denen **docstrip** dann die traditionelleren „Quell“-Dateien generiert, die Compiler oder ähnliche Programme erwarten würden. Die Master-Quelldateien enthalten in der Regel eine umfangreiche Dokumentation des Codes, manchmal sogar an Plätzen, an denen die Code-Nutzer keinerlei Kommentare zulassen würden. Die Etymologie von „docstrip“ liegt darin, dass diese *doc*umentation *strip*ped away wurde (obwohl „Code-Extraktion“ möglicherweise eine bessere Beschreibung wäre, da es stets darum ging, ausgewählte Teile der Master-Quelldatei zu kopieren, anstatt Text daraus zu löschen). Das Tcl-Paket **docstrip** enthält eine Neuimplementierung der grundlegenden Extraktionsfunktionalität aus dem Programm **docstrip** und ermöglicht es somit einem Tcl-Interpreter, die Master-Quelldateien direkt zu lesen und zu interpretieren.

Leser, die bisher noch nicht mit **docstrip** vertraut sind, aber mehr darüber erfahren möchten, können die folgenden Quellen zu Rate ziehen.

1. *The tclldoc package and class*, <http://ctan.org/tex-archive/macros/latex/contrib/tclldoc/>.

2. *The DocStrip utility*, <http://ctan.org/tex-archive/macros/latex/base/docstrip.dtx>.

3. *The doc and shortvrb Packages*, <http://ctan.org/tex-archive/macros/latex/base/doc.dtx>.

4. Kapitel 14 aus *The LaTeX Companion* (2. Auflage), Addison-Wesley, 2004; ISBN 0-201-36299-6.


# Dateiformat

Die Grundeinheit, mit der **docstrip** arbeitet, sind die *lines* einer Master-Quelldatei. Die Extraktion besteht darin, einige dieser Zeilen auszuwählen, die vom Eingabetext in den Ausgabetext kopiert werden sollen. Die grundlegende Unterscheidung erfolgt zwischen *Codezeilen* (die kopiert werden und nicht mit einem Prozentzeichen beginnen) und *Kommentarzeilen* (die mit einem Prozentzeichen beginnen und nicht kopiert werden).

```
   docstrip::extract [join {
     {% comment}
     {% more comment !"#$%&/(}
     {some command}
     { % blah $blah "Not a comment."}
     {% abc; this is comment}
     {# def; this is code}
     {ghi}
     {% jkl}
   } \n] {}
```

gibt dieselbe Zeilenfolge zurück wie

```
   join {
     {some command}
     { % blah $blah "Not a comment."}
     {# def; this is code}
     {ghi} ""
   } \n
```

Für **docstrip** spielt es keine Rolle, welches Format für die Dokumentation in den Kommentarzeilen verwendet wird; um jedoch mehr zu erreichen als reine Textkommentare, wird in der Regel eine Markup-Sprache verwendet. Am häufigsten wird LaTeX verwendet, da es sich um einen sehr etablierten Standard handelt und zudem die beste Unterstützung für mathematische Formeln bietet; das **docstrip::util**-Paket bietet jedoch auch eine gewisse Unterstützung für *doctools*-like-Markup.

Neben den normalen Code- und Kommentarzeilen gibt es auch *Guard-Zeilen*, die mit den beiden Zeichen „%<“ beginnen, sowie *Meta-Kommentarzeilen*, die mit den beiden Zeichen „\\'%%“ beginnen. Innerhalb der Guard-Zeilen wird zudem zwischen *Verbatim-Guard-Zeilen*, die mit „%<<“ beginnen, und gewöhnlichen Guard-Zeilen unterschieden, bei denen auf „%<“ kein weiteres „<“ folgt. Die letztgenannte Kategorie ist bei weitem am häufigsten anzutreffen.

Gewöhnliche Schutzzeilen bedingen die Einbindung der von ihnen geschützten Codezeile(n) vom Wert eines booleschen Ausdrucks; der geschützte Block von Codezeilen wird nur dann eingebunden, wenn die Auswertung des Ausdrucks den Wert „wahr“ ergibt. Die Syntax einer gewöhnlichen Schutzzeile lautet wie folgt:

```
    '%' '<' STARSLASH EXPRESSION '>'
    '%' '<' PLUSMINUS EXPRESSION '>' CODE
```

wobei

```
    STARSLASH  ::=  '*' | '/'
    PLUSMINUS  ::=  | '+' | '-'
    EXPRESSION ::= SECONDARY | SECONDARY ',' EXPRESSION
                 | SECONDARY '|' EXPRESSION
    SECONDARY  ::= PRIMARY | PRIMARY '&' SECONDARY
    PRIMARY    ::= TERMINAL | '!' PRIMARY | '(' EXPRESSION ')'
    CODE       ::= { any character except end-of-line }
```

Das Komma und der senkrechte Strich stehen beide für „oder“. Das Und-Zeichen steht für „und“. Das Ausrufezeichen steht für „nicht“. Ein TERMINAL kann eine beliebige nichtleere Zeichenfolge sein, die weder „>“, „&“, „|“, ein Komma, „(“ noch „)“ enthält, obwohl das Handbuch **docstrip** etwas restriktiv ist und den ordnungsgemäßen Betrieb nur für Zeichenfolgen aus Buchstaben garantiert (obwohl selbst die LaTeX-Kernquellen in TERMINALs in großem Umfang auch Ziffern verwenden). Das zweite Argument von **docstrip::extract** ist die Liste jener TERMINALs, die als den Wert „true“ habend gelten sollen; alle anderen TERMINALs gelten bei der Auswertung von Guard-Ausdrücken als „false“.

Im Falle einer „%<\**Ausdruck*>“-Abgrenzung umfassen die abgetrennten Zeilen alle Zeilen bis zur nächsten „%</*Ausdruck*>“-Abgrenzung mit demselben *Ausdruck (verglichen als Zeichenfolgen). Die durch solche „\*“- und „/“-Begrenzungszeilen abgegrenzten Codeblöcke müssen korrekt verschachtelt sein.

```
   set text [join {
      {begin}
      {%<*foo>}
      {1}
      {%<*bar>}
      {2}
      {%</bar>}
      {%<*!bar>}
      {3}
      {%</!bar>}
      {4}
      {%</foo>}
      {5}
      {%<*bar>}
      {6}
      {%</bar>}
      {end}
   } \n]
   set res [docstrip::extract $text foo]
   append res [docstrip::extract $text {foo bar}]
   append res [docstrip::extract $text bar]
```

setzt $res auf das Ergebnis von

```
   join {
      {begin}
      {1}
      {3}
      {4}
      {5}
      {end}
      {begin}
      {1}
      {2}
      {4}
      {5}
      {6}
      {end}
      {begin}
      {5}
      {6}
      {end} ""
   } \n
```

In Guard-Zeilen ohne einen Modifikator „\*“, „/“, „+“ oder „-“ nach dem „\\'%<“ gilt der Guard nur für den CODE, der auf das „>“ in dieser einzelnen Zeile folgt. Ein Modifikator „+“ entspricht keinem Modifikator. Ein Modifikator „-“ verhält sich wie der Fall ohne Modifikator, jedoch wird der Ausdruck implizit negiert, d. h., der CODE einer Guard-Zeile mit „%<-“ wird nur einbezogen, wenn die Auswertung den Wert „false“ ergibt.

Metakommentarzeilen sind „Kommentarzeilen, die nicht entfernt werden sollen“, sondern wie Codezeilen extrahiert werden; diese werden manchmal für Copyright-Hinweise und ähnliche Inhalte verwendet. Das Präfix „%%“ wird jedoch nicht beibehalten, sondern durch den aktuellen Wert **-metaprefix** ersetzt, der üblicherweise auf ein Zeichen (oder eine Zeichenfolge) gesetzt wird, das in der Sprache des zu extrahierenden Codes als „Kommentar bis zum Zeilenende“ dient.

```
   set text [join {
      {begin}
      {%<foo> foo}
      {%<+foo>plusfoo}
      {%<-foo>minusfoo}
      {middle}
      {%% some metacomment}
      {%<*foo>}
      {%%another metacomment}
      {%</foo>}
      {end}
   } \n]
   set res [docstrip::extract $text foo -metaprefix {# }]
   append res [docstrip::extract $text bar -metaprefix {#}]
```

setzt $res auf das Ergebnis von

```
   join {
      {begin}
      { foo}
      {plusfoo}
      {middle}
      {#  some metacomment}
      {# another metacomment}
      {end}
      {begin}
      {minusfoo}
      {middle}
      {# some metacomment}
      {end} ""
   } \n
```

Verbatim-Guards können verwendet werden, um die Interpretation eines Zeilenblocks als Code zu erzwingen, selbst wenn einige dieser Zeilen für „docstrip“ wie Zeilen anderer Art aussehen. Ein Verbatim-Guard hat die Form „%<<*END-TAG*“, und der Verbatim-Block wird durch die erste Zeile beendet, die genau „%*END-TAG*“ lautet.

```
   set text [join {
      {begin}
      {%<*myblock>}
      {some stupid()}
      {   #computer<program>}
      {%<<QQQ-98765}
      {% These three lines are copied verbatim (including percents}
      {%% even if -metaprefix is something different than %%).}
      {%</myblock>}
      {%QQQ-98765}
      {   using*strange@programming<language>}
      {%</myblock>}
      {end}
   } \n]
   set res [docstrip::extract $text myblock -metaprefix {# }]
   append res [docstrip::extract $text {}]
```

setzt $res auf das Ergebnis von

```
   join {
      {begin}
      {some stupid()}
      {   #computer<program>}
      {% These three lines are copied verbatim (including percents}
      {%% even if -metaprefix is something different than %%).}
      {%</myblock>}
      {   using*strange@programming<language>}
      {end}
      {begin}
      {end} ""
   } \n
```

Der Prozess der Verarbeitung von Verbatim-Guards erfolgt auch innerhalb von Zeilenblöcken, die aufgrund eines äußeren Block-Guards nicht kopiert werden.

Ein letzter Aspekt der Syntax von **docstrip** ist, dass die Extraktion an einer Zeile endet, die genau „\\endinput“ lautet; dies wird häufig verwendet, um das Kopieren zufälliger Leerzeichen am Dateiende zu vermeiden. Für den unwahrscheinlichen Fall, dass Sie eine solche Codezeile benötigen, können Sie diese mit einem Verbatim-Guard schützen.

# Befehle

Das Paket definiert zwei Befehle.

**docstrip::extract** *text* *terminals* ?*option* *value* ...?
: Der Befehl **extract** extrahiert den *text* und gibt die extrahierten Codezeilen als Zeichenkette zurück, wobei jede Zeile mit einem Zeilenumbruch abgeschlossen wird. *terminals* ist die Liste jener Terminale des Schutzausdrucks, deren Auswertung „wahr“ sein soll. Die verfügbaren Optionen sind:

    **-annotate** *lines*
    : Legt fest, dass auf jede extrahierte Zeile im Ergebnis die angegebene Anzahl von Anmerkungszeilen folgen soll. Der Standardwert ist 0. Anmerkungszeilen sind vor allem dann nützlich, wenn die extrahierten Zeilen einer weiteren Transformation unterzogen werden sollen. Eine erste Anmerkungszeile besteht aus einer Liste mit drei Elementen: Zeilentyp, bei der Extraktion entferntes Präfix und bei der Extraktion eingefügtes Präfix. Der Zeilentyp kann einer der folgenden sein: „V“ (wörtlich), „M“ (Metakommentar), „+“ (+ oder keine Modifikator-Schutzzeile), „-“ (– Modifikator-Schutzzeile), „.“ (normale Zeile). Eine zweite Anmerkungszeile ist die Nummer der Quellzeile. Eine dritte Anmerkungszeile ist der aktuelle Stapel der Block-Guards. Die Anforderung von mehr als drei Anmerkungszeilen wird derzeit nicht unterstützt.

    **-metaprefix** *string*
    : Die Zeichenfolge, durch die das Präfix „%%“ einer Metakommentarzeile ersetzt wird. Die Standardeinstellung lautet „%%“. Bei Tcl-Code wäre dies in der Regel „#“.

    **-onerror** *keyword*
    : Legt fest, welche Maßnahmen ergriffen werden, wenn ein Formatfehler im zu verarbeitenden *text* erkannt wird. Die Einstellungsmöglichkeiten sind:

        **ignore**
        : Ignoriert den Fehler und fährt fort, als wäre nichts geschehen.

        **puts**
        : Schreibt eine Fehlermeldung nach **stderr** und setzt die Verarbeitung fort.

        **throw**
        : Löst einen Fehler aus. Der Parameter **-errorcode** wird auf eine Liste gesetzt, deren erstes Element **DOCSTRIP** ist, deren zweites Element die Fehlerart angibt und deren drittes Element die Zeilennummer ist, in der der Fehler erkannt wurde. Dies ist die Standardeinstellung.


    **-trimlines** *boolean*
    : Legt fest, ob *Leerzeichen* am Ende einer Zeile vor dem Prozess der Zeile entfernt werden sollen. Der Standardwert ist „true“.


    Es sei darauf hingewiesen, dass die *terminals* im Zusammenhang mit dem Programm **docstrip** häufig als „Optionen“ bezeichnet werden, da diese festlegen, welche optionalen Codefragmente einbezogen werden sollen.

**docstrip::sourcefrom** *filename* *terminals* ?*option* *value* ...?
: Der Befehl **sourcefrom** ist eine Docstripping-Emulation von **source**. Er öffnet die Datei *filename*, liest sie ein, schließt sie, entfernt die Dokumentationsinformationen gemäß den Angaben unter *terminals* und führt die Auswertung des Ergebnisses im lokalen Kontext des Aufrufers durch; während dieser Zeit ist der Wert von **info** **script** der *filename*. Die Optionen werden an **fconfigure** übergeben, um die Datei vor dem Einlesen ihres Inhalts zu konfigurieren. **-metaprefix** wird auf „#“ gesetzt, alle anderen **extract**-Optionen behalten ihre Standardwerte.


# Dokumentaufbau

Das Dateiformat (wie oben beschrieben) bestimmt, ob eine Master-Quellcodedatei von **docstrip** korrekt verarbeitet werden kann; der Nutzen des Formats hängt jedoch nicht zuletzt auch davon ab, dass der Code und die Kommentarzeilen zusammen ein wohlgeformtes Dokument bilden.

Ein Dokumentformat, für das keine Tcl-fremde Software erforderlich ist, finden Sie unter dem Befehl **ddt2man** im Paket **docstrip::util**. Es wird empfohlen, Dateien, die dieses Dokumentformat verwenden, die Dateiendung „*.ddt*“ zu geben, um sie von den traditionelleren, auf LaTeX basierenden „*.dtx*“-Dateien zu unterscheiden.

Master-Quelldateien mit der Erweiterung „*.dtx*“ sind in der Regel so eingerichtet, dass sie direkt von **latex** gesetzt werden können, ohne dass weitere Dateien erforderlich sind. Dies wird dadurch erreicht, dass die Datei mit den folgenden Zeilen beginnt:

```
   % \iffalse
   %<*driver>
   \documentclass{tclldoc}
   \begin{document}
   \DocInput{filename.dtx}
   \end{document}
   %</driver>
   % \fi
```

oder eine Variante davon. Der Trick besteht darin, dass die Datei zweimal gelesen wird. Nach den üblichen LaTeX-Leseregeln gelten die ersten beiden Zeilen als Kommentare und werden daher ignoriert. Die dritte Zeile ist die Präambel des Dokuments, die vierte Zeile leitet den Dokumenttext ein und die sechste Zeile beendet das Dokument, sodass LaTeX an dieser Stelle stoppt – Nicht-Kommentare unterhalb dieser Stelle in der Datei unterliegen niemals den normalen LaTeX-Leseregeln. Zuvor wird jedoch der Befehl \\DocInput in der fünften Zeile verarbeitet, der zwei Dinge bewirkt: Er ändert die Interpretation von „%“ von „Kommentar“ in „ignoriert“ und gibt die im Argument angegebene Datei ein (bei der es sich normalerweise um den Namen der Datei handelt, in der sich der Befehl befindet). Erst bei diesem zweiten Durchlauf, bei dem die Datei gelesen wird, werden die darin enthaltenen Kommentare und der Code gesetzt.

Die Funktion von \\iffalse ... \\fi besteht darin, beim zweiten Durchlauf die Zeilen zwei bis sieben zu überspringen; dies ähnelt dem Konstrukt „if 0 { ... }“ für Blockkommentare im Tcl-Code und ist hier unter anderem deshalb erforderlich, weil der Befehl \\documentclass nur einmal ausgeführt werden darf. Die Funktion der <driver>-Schutzeinrichtungen besteht darin, zu verhindern, dass dieser kurze LaTeX-Code von **docstrip** extrahiert wird. Insgesamt führt dies dazu, dass die Datei sowohl als LaTeX-Dokument als auch als **docstrip**-Master-Quellcode-Datei fungieren kann.

Es ist nicht zwingend erforderlich, die Dokumentklasse „tclldoc“ zu verwenden, doch diese bietet eine Reihe von Funktionen, die für „*.dtx*“-Dateien mit Tcl-Code sehr praktisch sind. Weitere Informationen hierzu finden Sie in der oben genannten Literatur.

# Kategorie

Dokumentationswerkzeuge

# Copyright

```
Copyright (c) 2003–2010 Lars Hellström <Lars dot Hellstrom at residenset dot net>
```
