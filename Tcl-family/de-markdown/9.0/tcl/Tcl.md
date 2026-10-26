---
CommandName: Tcl
title: Tcl
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Keywords:
 - backslash
 - command
 - comment
 - script
 - substitution
 - variable
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tcl - Tool Command Language

# Übersicht

Zusammenfassung der Tcl-Sprachsyntax.

# Beschreibung

## Syntax

Die folgenden Regeln definieren Syntax und Semantik der Tcl-Sprache:

\[1\] **Befehle.**
: Ein Tcl-Skript ist eine Zeichenkette mit einem oder mehreren Befehlen. Semikolons und Zeilenumbrüche sind Befehlstrenner, sofern sie nicht wie unten beschrieben in Anführungszeichen stehen. Schließende eckige Klammern sind während der Befehlssubstitution (siehe unten) Befehlsablaufmarker, sofern sie nicht in Anführungszeichen stehen.

\[2\] **Auswertung.**
: Ein Befehl wird in zwei Schritten ausgewertet. Zuerst zerlegt der Tcl-Interpreter den Befehl in *Wörter* und führt die unten beschriebenen Substitutionen durch. Diese Substitutionen erfolgen für alle Befehle auf gleiche Weise. Zweitens wird das erste Wort verwendet, um eine Routine zur Ausführung des Befehls zu finden, und die übrigen Wörter des Befehls werden an diese Routine übergeben. Die Routine kann jedes ihrer Wörter beliebig interpretieren, etwa als Ganzzahl, Variablenname, Liste oder Tcl-Skript. Verschiedene Befehle interpretieren ihre Wörter unterschiedlich.

\[3\] **Wörter.**
: Die Wörter eines Befehls werden durch Leerzeichen getrennt (ausgenommen Zeilenumbrüche, die Befehlstrenner sind).

\[4\] **Doppelte Anführungszeichen.**
: Steht das erste Zeichen eines Wortes in doppelten Anführungszeichen ("""), wird das Wort durch das nächste doppelte Anführungszeichen abgeschlossen. Stehen Semikolons, schließende eckige Klammern oder Leerzeichen (einschließlich Zeilenumbrüche) zwischen den Anführungszeichen, werden sie als gewöhnliche Zeichen behandelt und zum Wort gezählt. Auf die Zeichen zwischen den Anführungszeichen werden Befehls-, Variablen- und Backslash-Substitutionen wie unten beschrieben angewendet. Die doppelten Anführungszeichen gehören nicht zum Wort.

\[5\] **Argument-Erweiterung.**
: Beginnt ein Wort mit der Zeichenkette "{\*}", gefolgt von einem Nicht-Leerzeichen, wird das führende "{\*}" entfernt und der Rest des Wortes wie jedes andere Wort geparst und substituiert. Nach der Substitution wird das Wort als Liste geparst (ohne Befehls- oder Variablensubstitutionen; Backslash-Substitutionen erfolgen wie üblich für eine Liste, und einzelne innere Wörter können in geschweiften Klammern oder doppelten Anführungszeichen stehen), und seine Wörter werden dem substituierten Befehl hinzugefügt. Beispielsweise ist "cmd a {\*}{b \[c\]} d {\*}{$e f {g h}}" gleichwertig zu "cmd a b {\[c\]} d {$e} f {g h}".

\[6\] **Geschweifte Klammern.**
: Steht das erste Zeichen eines Wortes in einer öffnenden geschweiften Klammer ("{") und gilt Regel \[5\] nicht, wird das Wort durch die passende schließende geschweifte Klammer ("}") abgeschlossen. Geschweifte Klammern können im Wort verschachtelt sein: Für jede zusätzliche öffnende geschweifte Klammer muss eine zusätzliche schließende vorhanden sein (steht jedoch eine öffnende oder schließende geschweifte Klammer im Wort in Backslash-Anführung, zählt sie nicht bei der Suche nach der passenden schließenden Klammer). Auf die Zeichen zwischen den geschweiften Klammern werden keine Substitutionen angewendet, außer den unten beschriebenen Backslash-Zeilenumbruch-Substitutionen; Semikolons, Zeilenumbrüche, schließende eckige Klammern oder Leerzeichen erhalten keine besondere Bedeutung. Das Wort besteht genau aus den Zeichen zwischen den äußeren geschweiften Klammern, ohne die Klammern selbst.

\[7\] **Befehlssubstitution.**
: Enthält ein Wort eine öffnende eckige Klammer ("\["), führt Tcl *Befehlssubstitution* durch. Dazu ruft es den Tcl-Interpreter rekursiv auf, um die Zeichen nach der öffnenden eckigen Klammer als Tcl-Skript zu verarbeiten. Das Skript kann beliebig viele Befehle enthalten und muss mit einer schließenden eckigen Klammer ("\]") abgeschlossen werden. Das Ergebnis des Skripts (d. h. das Ergebnis seines letzten Befehls) wird an Stelle der eckigen Klammern und aller Zeichen dazwischen in das Wort substituiert. In einem einzelnen Wort können beliebig viele Befehlssubstitutionen vorkommen. Befehlssubstitution wird bei Wörtern in geschweiften Klammern nicht durchgeführt.

\[8\] **Variablensubstitution.**
: Enthält ein Wort ein Dollarzeichen ("$"), gefolgt von einer der unten beschriebenen Formen, führt Tcl *Variablensubstitution* durch: Das Dollarzeichen und die folgenden Zeichen werden im Wort durch den Wert einer Variable ersetzt. Variablensubstitution kann eine der folgenden Formen annehmen:

    **$***name*
    : *Name* ist der Name einer Skalarvariablen; der Name ist eine Folge aus einem oder mehreren Zeichen, die ein Buchstabe, eine Ziffer, ein Unterstrich oder Namespace-Trenner (zwei oder mehr Doppelpunkte) sind. Buchstaben und Ziffern sind *ausschließlich* die standardmäßigen ASCII-Zeichen (**0**–**9**, **A**–**Z** und **a**–**z**).

    **$***name***(***index***)**
    : *Name* gibt den Namen einer Array-Variable an und *index* den Namen eines Elements in diesem Array. *Name* darf nur Buchstaben, Ziffern, Unterstriche und Namespace-Trenner enthalten und kann eine leere Zeichenkette sein. Buchstaben und Ziffern sind *ausschließlich* die standardmäßigen ASCII-Zeichen (**0**–**9**, **A**–**Z** und **a**–**z**). Auf die Zeichen von *index* werden Befehls-, Variablen- und Backslash-Substitutionen angewendet.

    **${***name***}**
    : *Name* ist der Name einer Skalarvariablen oder eines Array-Elements. Er darf beliebige Zeichen enthalten, außer schließenden geschweiften Klammern. Er bezeichnet ein Array-Element, wenn *name* die Form "*arrayName***(***index***)**" hat, wobei *arrayName* keine öffnenden Klammerzeichen "**(**" oder schließenden geschweiften Klammern "**}**" enthält und *index* eine beliebige Zeichenfolge außer schließenden geschweiften Klammern sein kann. Beim Parsen von *name* werden keine weiteren Substitutionen durchgeführt.


    In einem einzelnen Wort können beliebig viele Variablensubstitutionen vorkommen. Variablensubstitution wird bei Wörtern in geschweiften Klammern nicht durchgeführt.

    Beachten Sie, dass Variablen Zeichenfolgen enthalten können, die nicht in den obigen Formen aufgeführt sind; in diesem Fall müssen andere Mechanismen zum Zugriff verwendet werden (z. B. die Ein-Argument-Form des Befehls [set]).

\[9\] **Backslash-Substitution.**
: Erscheint ein Backslash ("\\") innerhalb eines Wortes, tritt *Backslash-Substitution* auf. In allen Fällen außer den unten beschriebenen wird der Backslash entfernt und das folgende Zeichen als gewöhnliches Zeichen behandelt und zum Wort gezählt. So können Zeichen wie doppelte Anführungszeichen, schließende eckige Klammern und Dollarzeichen in Wörter aufgenommen werden, ohne besondere Verarbeitung auszulösen. Die folgende Tabelle listet die Backslash-Sequenzen auf, die besonders behandelt werden, zusammen mit dem Wert, der jede Sequenz ersetzt.

    \\**a**
    : Hörbare Warnung (Glocke) (Unicode U+000007).

    \\**b**
    : Rückwärtsblättern (Backspace) (Unicode U+000008).

    \\**f**
    : Seitenvorschub (Form Feed) (Unicode U+00000C).

    \\**n**
    : Zeilenumbruch (Newline) (Unicode U+00000A).

    \\**r**
    : Wagenrücklauf (Carriage Return) (Unicode U+00000D).

    \\**t**
    : Tabulator (Tab) (Unicode U+000009).

    \\**v**
    : Vertikaler Tabulator (Vertical Tab) (Unicode U+00000B).

    \\**<newline>***whiteSpace*
    : Ein einzelnes Leerzeichen ersetzt den Backslash, den Zeilenumbruch und alle Leerzeichen und Tabulatorzeichen nach dem Zeilenumbruch. Diese Backslash-Sequenz ist einzigartig, weil sie in einem separaten Pre-Pass ersetzt wird, bevor der Befehl tatsächlich geparst wird. Das bedeutet, dass sie auch ersetzt wird, wenn sie zwischen geschweiften Klammern steht, und das resultierende Leerzeichen als Worttrenner behandelt wird, wenn es nicht in geschweiften Klammern oder Anführungszeichen steht.

    \\\\
    : Backslash ("\\").

    \\*ooo*
    : Die Ziffern *ooo* (eine, zwei oder drei) geben einen acht Bit breiten Oktalwert für das Unicode-Zeichen an, das eingefügt wird, im Bereich *000*–*377* (d. h. U+000000–U+0000FF). Der Parser stoppt kurz bevor dieser Bereich überläuft oder wenn das Maximum von drei Ziffern erreicht ist. Die oberen Bits des Unicode-Zeichens sind 0.

    \\**x***hh*
    : Die hexadezimalen Ziffern *hh* (eine oder zwei) geben einen acht Bit breiten hexadezimalen Wert für das Unicode-Zeichen an, das eingefügt wird. Die oberen Bits des Unicode-Zeichens sind 0 (d. h. das Zeichen liegt im Bereich U+000000–U+0000FF).

    \\**u***hhhh*
    : Die hexadezimalen Ziffern *hhhh* (eine, zwei, drei oder vier) geben einen sechzehn Bit breiten hexadezimalen Wert für das Unicode-Zeichen an, das eingefügt wird. Die oberen Bits des Unicode-Zeichens sind 0 (d. h. das Zeichen liegt im Bereich U+000000–U+00FFFF).

    \\**U***hhhhhhhh*
    : Die hexadezimalen Ziffern *hhhhhhhh* (eine bis acht) geben einen einundzwanzig Bit breiten hexadezimalen Wert für das Unicode-Zeichen an, das eingefügt wird, im Bereich U+000000–U+10FFFF. Der Parser stoppt kurz bevor dieser Bereich überläuft oder wenn das Maximum von acht Ziffern erreicht ist. Die oberen Bits des Unicode-Zeichens sind 0.


    Backslash-Substitution wird bei Wörtern in geschweiften Klammern nicht durchgeführt, außer für Backslash-Zeilenumbruch wie oben beschrieben.

\[10\] **Kommentare.**
: Erscheint ein Rautezeichen ("#") an einer Stelle, an der Tcl das erste Zeichen des ersten Wortes eines Befehls erwartet, werden das Rautezeichen und die folgenden Zeichen bis zum nächsten Zeilenumbruch als Kommentar behandelt und ignoriert. Das Kommentarzeichen ist nur bedeutsam, wenn es am Anfang eines Befehls steht.

\[11\] **Reihenfolge der Substitution.**
: Jedes Zeichen wird vom Tcl-Interpreter beim Erzeugen der Wörter eines Befehls genau einmal verarbeitet. Tritt beispielsweise Variablensubstitution auf, werden auf den Wert der Variable keine weiteren Substitutionen angewendet; der Wert wird wörtlich in das Wort eingefügt. Tritt Befehlssubstitution auf, wird der verschachtelte Befehl vollständig durch den rekursiven Aufruf des Tcl-Interpreters verarbeitet; vor dem rekursiven Aufruf werden keine Substitutionen durchgeführt, und auf das Ergebnis des verschachtelten Skripts werden keine zusätzlichen Substitutionen angewendet.

    Substitutionen erfolgen von links nach rechts, und jede Substitution wird vollständig ausgewertet, bevor die nächste versucht wird. Eine Sequenz wie

    ```
    set y [set x 0][incr x][incr x]
    ```

    wird die Variable *y* immer auf den Wert *012* setzen.

\[12\] **Substitution und Wortgrenzen.**
: Substitutionen beeinflussen die Wortgrenzen eines Befehls nicht, außer bei Argument-Erweiterung gemäß Regel \[5\]. Wird beispielsweise während der Variablensubstitution der gesamte Wert der Variable Teil eines einzelnen Wortes, auch wenn der Variablenwert Leerzeichen enthält.


## Tcl-Werte

Begrifflich sind alle Werte in Tcl Zeichenketten, genauer: Folgen von Unicode-Codepunkten. Dass alle Werte Zeichenketten sind, heißt üblicherweise *Everything Is A String (EIAS)*.

Meist kann man Tcl-Zeichenketten als Folgen von Zeichen statt von Codepunkten auffassen; dem üblichen Sprachgebrauch folgend sprechen Befehlsbeschreibungen so. Der Unterschied zählt, weil manche Zeichen mehrere Darstellungen als Folgen von Unicode-Codepunkten haben und Tcl bei Vergleichen einzelne Codepunkte vergleicht, nicht abstrakte Zeichen.

Obwohl alle Werte Zeichenketten sind, können einzelne Befehle ihre Argumente als Darstellung eines bestimmten Typs behandeln oder erwarten. [incr] erwartet zum Beispiel Ganzzahlen.

Die wichtigste Folge des EIAS-Prinzips: Befehle müssen Argumente mit derselben Zeichendarstellung gleich behandeln, unabhängig davon, wie der Wert entstanden ist. [incr] muss **100**, entstanden durch Anhängen von **0** an **10**, genauso behandeln wie **100**, entstanden durch Multiplikation von 10 mit sich selbst.

Das EIAS-Prinzip gilt nur auf der begrifflichen Ebene. Aus Effizienzgründen kann die Implementierung je nach Verwendung verschiedene interne Darstellungen wählen. Arithmetik mit Ganzzahlen kann den Wert intern als Maschinenwort speichern. Eine *binäre Zeichenkette* ist eine Folge von Unicode-Codepunkten im Bereich U+0000 bis U+00FF und kann als Bytefeld gespeichert werden. Diese interne Darstellung ist auf der Tcl-Sprachebene belanglos und in der Tcl-C-API sichtbar.


[incr]: incr.md
[set]: set.md
