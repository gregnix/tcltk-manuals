---
CommandName: ntextWordBreak
title: ntextWordBreak
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: ntext Word Boundary Detection for the Text Widget
Links:
 - bindtags
 - ntext
 - re_syntax
 - regexp
 - text
Keywords:
 - bindtags
 - re_syntax
 - regexp
 - text
Copyright:
---

# Name

ntextWordBreak – Erkennung von Wortgrenzen in ntext für das Text-Widget

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [ntext]{.lit} [1.0]{.optlit}
:::

# Beschreibung

Das Paket **ntext** stellt ein Bindungs-Tag namens *Ntext* zur Verfügung, das von Text-Widgets anstelle des standardmäßigen Bindungs-Tags *Text* verwendet werden kann.

Die Navigation und Auswahl in einem Text-Widget erfordern die Erkennung von Wörtern und deren Grenzen. Die von Tcl/Tk über das Binding-Tag *Text* bereitgestellten Funktionen zur Wortgrenzenerkennung sind eingeschränkt, da sie nur eine Klasse von „Wort“-Zeichen und eine Klasse von „Nicht-Wort“-Zeichen definieren.  Das Binding-Tag *Ntext* verwendet allgemeinere Regeln für die Wortgrenzenerkennung, die *zwei* Klassen von „Wort“-Zeichen und eine Klasse von „Nicht-Wort“-Zeichen definieren.

# Konfigurationsoptionen

Das Verhalten von *Ntext* lässt sich anwendungsweit konfigurieren, indem die Werte einer Reihe von Namespace-Variablen festgelegt werden. Eine davon ist für die Erkennung von Wortgrenzen relevant:

**::ntext::classicWordBreak**

- **0** – (Standardwert) wählt das *Ntext*-Verhalten aus, d. h. plattformunabhängig, zwei Klassen von Wortzeichen und eine Klasse von Nicht-Wortzeichen.

- **1** – wählt das klassische *Text*-Verhalten, das heißt plattformabhängig, eine Klasse von Wortzeichen und eine Klasse von Nicht-Wortzeichen

- Nach der Änderung dieses Werts sollten die Regexp-Muster zum Abgleich neu berechnet werden. Weitere Informationen sowie erweiterte Konfigurationsoptionen finden Sie unter [Funktionen].


# Fortgeschrittene Nutzung

# Variablen (fortgeschrittene Anwendung)

**::ntext::tcl\_match\_wordBreakAfter**

**::ntext::tcl\_match\_wordBreakBefore**

**::ntext::tcl\_match\_endOfWord**

**::ntext::tcl\_match\_startOfNextWord**

**::ntext::tcl\_match\_startOfPreviousWord**

Diese Variablen enthalten die regulären Muster, die von *Ntext* zur Suche nach Wortgrenzen verwendet werden. Werden sie geändert, wirkt sich dies sofort auf nachfolgende Suchvorgänge aus.  In vielen Fällen ist es nicht erforderlich, die Werte dieser Variablen direkt zu ändern: Rufen Sie stattdessen eine der Funktionen **::ntext::initializeMatchPatterns** oder **::ntext::createMatchPatterns** auf.

Im Binding-Tag *Text* können Sie die Suchregeln ändern, indem Sie die Werte der globalen Variablen **tcl\_wordchars** und **tcl\_nonwordchars** anpassen.  Die entsprechende Operation im *Ntext*-Binding-Tag besteht darin, **::ntext::createMatchPatterns** mit den entsprechenden Argumenten aufzurufen.

# Funktionen (fortgeschrittene Anwendung)

Wenn sich eine einfache Suche mit regulären Ausdrücken als unzureichend erweist, können die folgenden Funktionen (analog zu den Funktionen **tcl\_wordBreakAfter** usw. des Tcl/Tk-Kerns) vom Entwickler ersetzt werden:

**ntext::new\_wordBreakAfter**

**ntext::new\_wordBreakBefore**

**ntext::new\_endOfWord**

**ntext::new\_startOfNextWord**

**ntext::new\_startOfPreviousWord**

# Funktionen

Jede Funktion berechnet die fünf Regexp-Suchmuster, die die Suche nach Wortgrenzen definieren. Diese Werte werden in den oben aufgeführten Namespace-Variablen gespeichert.

**::ntext::initializeMatchPatterns**

- Diese Funktion wird bei der ersten Verwendung von *Ntext* aufgerufen und muss nur dann erneut aufgerufen werden, wenn das Skript den Wert von **::ntext::classicWordBreak** oder **::tcl\_platform(platform)** ändert.  Die Funktion wird ohne Argumente aufgerufen. Sie ist nützlich, wenn die gewünschten Suchmuster die Standardmuster für das Tag *Ntext* oder *Text* sind und somit implizit allein durch die Werte von **::ntext::classicWordBreak** und **::tcl\_platform(platform)** festgelegt werden.


**::ntext::createMatchPatterns** *new\_nonwordchars* *new\_word1chars* ?new\_word2chars?

- Diese Funktion ist in einem breiteren Anwendungsspektrum einsetzbar als **::ntext::initializeMatchPatterns**. Sie berechnet die Regexp-Suchmuster für jeden Fall, bei dem eine Klasse von „Nicht-Wort“-Zeichen und eine oder zwei Klassen von „Wort“-Zeichen vorliegen.

    Jedes Argument sollte ein regulärer Ausdruck sein, der eine Klasse von Zeichen definiert. Ein Argument ist in der Regel ein Klammerausdruck, kann aber alternativ auch eine Kurzschreibweise für eine Klasse von Zeichen oder ein einzelnes Zeichen sein. Das dritte Argument kann weggelassen oder als leere Zeichenkette angegeben werden; in diesem Fall wird es nicht verwendet.

    Das erste Argument wird als Klasse der Nicht-Wort-Zeichen interpretiert; das zweite Argument (und das dritte, falls vorhanden) sind Klassen von Wortzeichen. Die Klassen sollten alle möglichen Zeichen enthalten und schließen sich normalerweise gegenseitig aus: Oft ist es zweckmäßig, eine Klasse als Negation der beiden anderen zu definieren.


# Abgleich von Wortgrenzen

Die Auswahl der Wortgrenzen ist ein heikles Thema, da Text dazu dient, eine Vielzahl unterschiedlicher Informationsarten darzustellen, und es keine einfachen Regeln gibt, die für alle Datentypen oder für alle Zwecke geeignet sind.

*Ntext* versucht, die im klassischen *Text* verfügbaren Funktionen zu verbessern, indem es Möglichkeiten für komplexere Definitionen von Wörtern bietet (mit drei statt zwei Klassen von Zeichen).

*Was ist ein Wort?  Warum zwei Klassen von Wörtern?*

Wenn die modifizierten Cursortasten <Control-Left> und <Control-Right> zur Navigation durch ein *Ntext*-Widget verwendet werden, wird der Cursor an den Anfang eines Wortes platziert.  Ein Wort ist definiert als eine Folge von einem oder mehreren Zeichen, die ausschließlich aus einer der beiden definierten „Wort“-Klassen stammen; ihm kann ein Zeichen aus der anderen „Wort“-Klasse oder aus der „Nicht-Wort“-Klasse vorangestellt sein.

Durch einen Doppelklick mit der ersten Maustaste wird ein Wort im Text ausgewählt, wobei ein „Wort“ in diesem Fall entweder der oben genannten Definition entsprechen kann oder alternativ aus einer Folge von einem oder mehreren Zeichen aus der Klasse „Nicht-Wörter“ bestehen kann.

Traditionell hat Tcl nur eine Wortklasse und eine Nicht-Wortklasse definiert: Unter Windows ist die Nicht-Wortklasse Leerraum, sodass Buchstaben, Ziffern und Satzzeichen derselben Klasse angehören. Auf anderen Plattformen gehören Satzzeichen zusammen mit dem Leerraum zu den „Nicht-Wort“-Zeichen.  In beiden Fällen sind die Navigation und die Auswahl von Text unnötig grob granuliert und führen manchmal zu wenig hilfreichen Ergebnissen.

Die Verwendung von drei Zeichenklassen könnte die Auswahl zu detailliert gestalten; in diesem Fall ist die Taste *Shift* gedrückt halten und ein anderes Wort doppelklicken jedoch eine hervorragende Möglichkeit, einen längeren Textabschnitt auszuwählen (eine nützliche Bindung, die Tcl/Tk schon seit langem bietet, die jedoch in anderen Systemen fehlt).

Neben den Standardeinstellungen ermöglicht *Ntext* dem Entwickler, eigene Klassen von Zeichen zu definieren, auf die klassischen *Text*-Definitionen zurückzugreifen oder eigene reguläre Ausdrücke für die Muster des Abgleichs festzulegen.

# Bugs

Diese Version von **ntext** soll mit allen Releases von **Tk** 8.5, 8.6 und 8.7 kompatibel sein und mit den Zweigen *core-8-5-branch*, *core-8-6-branch* und *trunk* im Quellcode-Repository von **Tk**. Jede Inkompatibilität mit einer dieser Versionen, bei jedem Fenstersystem von **Tk**, ist als Fehler zu melden. Bitte melden Sie das in der Kategorie *ntext* der [Tklib-Tracker](https://core.tcl-lang.org/tklib/reportlist).

# Beispiel

So verwenden Sie *Ntext* unter Anwendung der üblichen Regeln zur Wortgrenzenerkennung von Tcl/Tk:

```
package require ntext
text .t
bindtags .t {.t Ntext . all}
set ::ntext::classicWordBreak 1
::ntext::initializeMatchPatterns
```

Weitere Informationen finden Sie unter „bindtags“.

So definieren Sie einen anderen Satz von Regeln zur Erkennung von Wortgrenzen:

```
package require ntext
text .t
bindtags .t {.t Ntext . all}
::ntext::createMatchPatterns  {[[:space:][:cntrl:]]} {[[:punct:]]} {[^[:punct:][:space:][:cntrl:]]}
```

Weitere Informationen finden Sie unter „regexp“ und „re\_syntax“.
