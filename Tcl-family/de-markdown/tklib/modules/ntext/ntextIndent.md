---
CommandName: ntextIndent
title: ntextIndent
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: ntext Indentation for the Text Widget
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

ntextIndent – Einrückung für das Text-Widget

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [ntext]{.lit} [1.0]{.optlit}
[::ntext::new\_textCopy]{.cmd} [pathName]{.arg}
[::ntext::new\_textCut]{.cmd} [pathName]{.arg}
[::ntext::new\_textPaste]{.cmd} [pathName]{.arg}
[::ntext::syncIndentColor]{.cmd} [pathName]{.arg}
:::

# Beschreibung

Das Paket **ntext** stellt ein Bindungs-Tag namens *Ntext* zur Verfügung, das von Text-Widgets anstelle des standardmäßigen Bindungs-Tags *Text* verwendet werden kann.

Das Text-Widget von Tk kann so konfiguriert werden, dass Textzeilen, die länger sind als die Breite des Textbereichs, umgebrochen werden – eine Funktion, die man aus Texteditoren und Textverarbeitungsprogrammen kennt.  Eine vollständige Textzeile (abgegrenzt durch Zeilenumbrüche oder durch den Anfang bzw. das Ende des Dokuments) wird als „logische Zeile“ bezeichnet. Wenn eine logische Zeile auf mehrere Zeilen des Anzeigebereichs umgebrochen wird, werden diese Fragmente der logischen Zeile als „Anzeigzeilen“ bezeichnet.

Beginnt eine logische Zeile mit Leerraum, beginnen die umbrochenen Anzeigezeilen weiter links als die erste Anzeigezeile. Das Layout kann dadurch unordentlich und schwer lesbar werden. Das Binding-Tag *Ntext* kann ein Text-Widget im Modus *-wrap* *word* so einrichten, dass die Anzeigezeilen außer der ersten automatisch zum anfänglichen Leerraum der ersten Anzeigezeile eingerückt werden.

Diese Einrückung steht Text-Widgets nur im *-wrap* *word*-Modus zur Verfügung.

# Befehle

**::ntext::new\_textCopy** *pathName*
: Ersatz für ::tk\_textCopy.

**::ntext::new\_textCut** *pathName*
: Ersatz für ::tk\_textCut, der auch die *Ntext*-Einrückung beibehält.

**::ntext::new\_textPaste** *pathName*
: Ersatz für ::tk\_textPaste, der auch die *Ntext*-Einrückung beibehält.

**::ntext::syncIndentColor** *pathName*
: Befehl zum Anwenden des aktuellen Werts der Variablen **::ntext::indentColor** auf bereits vorhandene Zeilen in einem Text-Widget. Dieser Befehl ist nützlich, wenn ein Text-Widget erstellt wurde, Text in das Widget eingefügt wurde *und anschließend* der Wert von **::ntext::indentColor** geändert wird.


# Konfigurationsoptionen

Das Verhalten von *Ntext* lässt sich anwendungsweit konfigurieren, indem die Werte einer Reihe von Namespace-Variablen festgelegt werden:

**::ntext::classicWrap**

- **0** – wählt das *Ntext*-Verhalten, das heißt, die Anzeigezeilen werden so eingerückt, dass sie zum anfänglichen Leerraum der ersten Anzeigezeile einer logischen Zeile passen.

    Es sind keine weiteren Maßnahmen erforderlich, sofern diese Option sowie die Option *-wrap* des Text-Widgets festgelegt sind, bevor Text in das Widget eingegeben wird, und sofern die Texteingabe und -bearbeitung ausschließlich über Maus und Tastatur erfolgt. Wenn der Text hingegen durch ein Skript bearbeitet wird oder wenn die Option *-wrap* des Text-Widgets oder der Wert von **::ntext::classicWrap** geändert werden, während das Widget Text enthält, sind Aufrufe der *ntext*-Funktionen erforderlich, um die Einrückung anzupassen.  Detaillierte Anweisungen finden Sie im Abschnitt [Einrückung von Anzeigezeilen].

- **1** – (Vorgabe) wählt das klassische *Text*-Verhalten, das heißt keine Einrückung.


**::ntext::indentColor**

- **{}** – Wenn der Wert eine leere Zeichenkette ist, so hat der Einzug der umgebrochenen Anzeigezeilen dieselbe Farbe wie der Hintergrund des Widgets.

- *color* – eine gültige Tk-Farbe, die für die Einrückung von umgebrochenen Anzeigezeilen verwendet werden soll (Standardwert *#d9d9d9*).

    Die Farbgebung wird über die Tag-Option *-lmargincolor* des Text-Widgets implementiert, die ab **Tk** 8.6.6 verfügbar ist.  Die Einrückungsfarbe von *Ntext* hat in früheren Versionen von **Tk** keine Wirkung.

    Der Wert von **::ntext::indentColor** wird häufig beim Start festgelegt. Wenn der Wert geändert wird, während bereits Text-Widgets vorhanden sind und Text enthalten, können diese Widgets durch Aufruf des Befehls **::ntext::syncIndentColor** aktualisiert werden.


*Erweiterte Verwendung*

**::ntext::newWrapRegexp**

- Der Wert ist ein reguläres Muster, das das Zeichen einer logischen Zeile festlegt, an dem alle Anzeigezeilen außer der ersten ausgerichtet werden. Der Standardwert **\[^\[:space:\]\]** gewährleistet die Ausrichtung am ersten Zeichen, das kein Leerzeichen ist.


# Einrückung von Anzeigezeilen

So verwenden Sie die Einrückung der Anzeigezeile von *Ntext*:

1. Setzen Sie die Variable **::ntext::classicWrap** auf **0** (der Standardwert lautet **1**).  Dadurch werden Bindings aktiviert, die die Einrückung beibehalten, wenn der Benutzer den Inhalt des Widgets über Tastatur und Maus ändert.  Wenn das Widget bereits Text enthält, rufen Sie **::ntext::wrapIndent** auf, um die Einrückung zu initialisieren.

    Weitere Anweisungen gelten, wenn das Programm den Inhalt des Widgets, die Zeilenumbruch-Konfiguration oder die Einrückungskonfiguration ändert.

2. Das Programm kann den Textinhalt ändern, z. B. mit dem Befehl „.text insert“. Eine solche Änderung löst keine Bindung aus; daher sollte das Programm nach dem Einfügen von Text explizit die Funktion **::ntext::wrapIndent** aufrufen.

3. Eine automatische Einrückung erfolgt nur, wenn sich das Widget im Modus *-wrap* *word* befindet.  Wenn das Programm in den Modus *-wrap* *word* wechselt oder zurückkehrt, während das Widget nicht leer ist, sollte es die Funktion **::ntext::wrapIndent** aufrufen, um den Text des Widgets zu formatieren.

4. Wenn Einrückungen verwendet werden und diese anschließend durch die Einstellung von **::ntext::classicWrap** auf **1** deaktiviert werden, rufen Sie bitte **::ntext::wrapIndent** auf, um die Einrückungen zu entfernen.


# Funktionen

**::ntext::wrapIndent** *textWidget* ?index1? ?index2?

- Passen Sie den Einzug eines Text-Widgets an. Im Folgenden werden verschiedene Fälle erläutert.


**::ntext::wrapIndent** *textWidget*

- Passen Sie den Einzug des gesamten Textes im Text-Widget *textWidget* an.


**::ntext::wrapIndent** *textWidget* *index1*

- Passen Sie den Einzug einer einzelnen logischen Zeile eines Text-Widgets an – der Zeile von *textWidget*, die den Index *index1* enthält.


**::ntext::wrapIndent** *textWidget* *index1* *index2*

- Passen Sie den Einzug eines Bereichs logischer Zeilen eines Text-Widgets an – also der Zeilen von *textWidget*, die die Indizes *index1* bis *index2* enthalten.


*Verwendung*

- **::ntext::wrapIndent** sollte nur aufgerufen werden, wenn das Skript den Inhalt oder die Anzeigeeigenschaften des Widgets ändert.  Wenn der Inhalt des Widgets über die Tastatur oder die Maus geändert wurde, ist es nicht erforderlich, dass das Skript **::ntext::wrapIndent** aufruft, da die entsprechenden Aufrufe automatisch durch die *Ntext*-Bindungen erfolgen.

- Das Skript sollte normalerweise **::ntext::wrapIndent** aufrufen, wenn es beispielsweise eine der folgenden Einstellungen ändert, während das Widget nicht leer ist: den Wert von **::ntext::classicWrap**, oder den Status *-wrap* des Widgets, oder den Tabulatorabstand des Widgets, oder die Schriftgröße, oder den Inhalt des Widgets.

- Ein Aufruf in der Form **::ntext::wrapIndent** *textWidget* ist stets ausreichend; sollten jedoch nur bestimmte Zeilen geändert werden müssen, ist es effizienter, diese Zeilen mithilfe der optionalen Argumente ?index1? und ?index2? anzugeben.

- Ist das Widget im Modus *-wrap* *word* und **::ntext::classicWrap** auf **0** gesetzt, rückt **::ntext::wrapIndent** die logischen Zeilen in dem Bereich ein, den die Argumente der Funktion angeben.

- In den anderen Fällen, also im Modus *-wrap* *char* oder *-wrap* *none*, oder wenn **::ntext::classicWrap** auf **1** steht, entfernt **::ntext::wrapIndent** die Einrückung der logischen Zeilen in diesem Bereich.


# Bugs

Diese Version von **ntext** soll mit allen Releases von **Tk** 8.5, 8.6 und 8.7 kompatibel sein und mit den Zweigen *core-8-5-branch*, *core-8-6-branch* und *trunk* im Quellcode-Repository von **Tk**. Jede Inkompatibilität mit einer dieser Versionen, bei jedem Fenstersystem von **Tk**, ist als Fehler zu melden. Bitte melden Sie das in der Kategorie *ntext* der [Tklib-Tracker](https://core.tcl-lang.org/tklib/reportlist).

# Beispiele

So aktivieren Sie die Einrückung von *Ntext* und verwenden diese im Widget .t unter Verwendung der Standardfarbe für Einrückungen *#d9d9d9*:

```
package require ntext
set ::ntext::classicWrap 0
text .t -wrap word
bindtags .t {.t Ntext . all}
```

So aktivieren Sie die Einrückung von *Ntext* und verwenden diese in der Widget-Datei .t ohne farbige Einrückungen:

```
package require ntext
set ::ntext::classicWrap 0
set ::ntext::indentColor {}
text .t -wrap word
bindtags .t {.t Ntext . all}
```

So aktivieren Sie die Einrückung von *Ntext* und verwenden diese in der Widget-Datei .t, wobei die Einrückungen die Farbe Schwarz haben:

```
package require ntext
set ::ntext::classicWrap 0
set ::ntext::indentColor black
text .t -wrap word
bindtags .t {.t Ntext . all}
```

Um die Einrückung von *Ntext* später zu deaktivieren:

```
set ::ntext::classicWrap 1
::ntext::wrapIndent .t
```

So können Sie die Einrückung von *Ntext* später wieder aktivieren:

```
set ::ntext::classicWrap 0
::ntext::wrapIndent .t 1.0 end
```

So fügen Sie Text in das Widget ein:

```
set foo [.t index end]
.t insert end {This line was added by the script, not the keyboard!}
::ntext::wrapIndent .t $foo end
```

So ändern Sie die Farbe der Einrückung, wenn ein Widget vom Typ „.t“ bereits Text enthält:

```
set ::ntext::indentColor black
::ntext::syncIndentColor .t
```

Um in den Modus *-wrap* *char* zu wechseln:

```
.t configure -wrap char
::ntext::wrapIndent .t
```
