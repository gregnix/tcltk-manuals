---
CommandName: ntextBindings
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Alternative Bindings for the Text Widget
Links:
 - bindtags
 - ntext
 - ntextIndent
 - text
Keywords:
 - bindtags
 - text
Copyright:
---

# NAME

ntextBindings – Alternative Bindings für das Text-Widget

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5-]{.lit} 
[package]{.cmd} [require]{.sub} [ntext]{.lit} [1.0]{.optlit} 
:::

# BESCHREIBUNG

Das Paket **ntext** stellt ein Bindungs-Tag namens *Ntext* zur Verfügung, das von Text-Widgets anstelle des standardmäßigen Bindungs-Tags *Text* verwendet werden kann.

Das Bindungs-Tag *Text* bietet etwa hundert Bindings für das Text-Widget (die genaue Anzahl ist plattformabhängig). Einige davon verhalten sich anders als die meisten modernen Textverarbeitungsprogramme. *Ntext* zielt darauf ab, ein vertrauteres Verhalten zu bieten.

Merkmale der *Ntext*-Bindings, die sich von den Standard-*Text*-Bindings unterscheiden:

**•**
: Wenn Sie nahe dem Ende einer (logischen) Zeile klicken, springt der Cursor an das Ende dieser Zeile *(nicht an den Anfang der nächsten Zeile)*. Befindet sich das Widget im Modus *-wrap* *word*, gilt dieselbe Regel für die Anzeigezeilen.

**•**
: Durch einen Doppelklick oder das Ziehen nahe dem Ende einer (logischen) Zeile werden Zeichen ab dem Ende dieser Zeile markiert bzw. ausgewählt *(nicht die nächste Zeile oder der Bereich am Zeilenende, in dem sich keine Zeichen befinden)*.  Wenn das Widget im Modus *-wrap* *word* ist, gilt dieselbe Regel für die Anzeige von Zeilen.

**•**
: Auf anderen Fenstersystemen als macOS Aqua führt die *Home*-Taste die Funktion „Smart Home“ aus (durch wiederholtes Drücken der Taste wird der Cursor zunächst an den Anfang der Anzeigezeile, dann zum ersten Nicht-Leerzeichen am Anfang der logischen Zeile bewegt und schließlich zwischen dem Anfang und dem Ende der führenden Leerzeichen umgeschaltet); die *End*-Taste implementiert „Smart End“ (das ähnlich wie „Smart Home“ funktioniert).  Unter macOS Aqua wird diese Funktionalität durch die Operationen \<Command-Left> und \<Command-Right> bereitgestellt.

**•**
: Wenn eine Auswahl markiert ist, überschreibt eine Operation „Paste“ (zum Beispiel \<Control-v>) die Auswahl (wie es bei den meisten Editoren der Fall ist), und zwar auf allen Plattformen.

**•**
: Bei anderen Fenstersystemen als macOS Aqua schaltet die Taste *Insert* zwischen den Modi Insert und Overwrite für die Tastatureingabe um. *(Das Binding-Tag Text benutzt *Insert* dagegen, um die primäre Auswahl einzufügen. Das geht auch mit einem Klick der mittleren Maustaste.)*

**•**
: Mit der *Escape*-Taste wird die Auswahl aufgehoben.

**•**
: Im macOS-Aqua-Fenstersystem hält sich *Ntext* an die Aqua-Konventionen für die Tastaturnavigation.  Bestimmte Bindings für das vertikale Scrollen können so eingestellt werden, dass sie sich genauso verhalten wie bei den Windows- und X11-Fenstersystemen, indem Sie **::ntext::classicParagraphs** auf **1** setzen (siehe Abschnitt **KONFIGURATIONSOPTIONEN**).

**•**
: Im macOS-Aqua-Fenstersystem hält sich *Ntext* an die Aqua-Konventionen für die Platzierung der Einfügemarke, wenn eine Auswahl durch die Tastaturnavigation aufgehoben wird.  Dieses Verhalten kann deaktiviert werden, indem **::ntext::classicSelection** auf **1** gesetzt wird (siehe Abschnitt **KONFIGURATIONSOPTIONEN**).

**•**
: Wenn Sie \<Shift-Button1> auswählen, erfolgt die Auswahl an der vorherigen Position des Einfügecursors. *(Im Tag „Text binding“ kann der Anker der Auswahl die Position des letzten Mausklicks sein.)*

**•**
: \<Shift-Button1>-Operationen haben keinen Einfluss auf den Anker der Auswahl. *(Im Text-Binding-Tag ist dies jedoch der Fall.)*

**•**
: Standardmäßig bietet das Bindungs-Tag *Ntext* einige der durch das Bindungs-Tag *Text* bereitgestellten Strg-Tastenkombinationen nicht an.  Moderne Tastaturen bieten Alternativen, wie beispielsweise die Cursortasten zur Navigation; moderne Anwendungen nutzen die Strg-Tasten-Bindungen häufig für andere Zwecke (z. B. \<Control-p> für „Drucken“). In den letzten drei Fällen ist das Verhalten von *Text* oft nützlich, daher bietet Ihnen *Ntext* die Option, es beizubehalten, indem Sie die im Namespace ::ntext definierten Variablen auf 1 setzen (anstelle ihres Standardwerts 0).  Eine ausführlichere Erläuterung dieser Funktionen:

**•**
: Wenn Sie an Position A mit der Maus klicken, anschließend den Cursor mithilfe der Tastatur zu B bewegen, dann die Taste Shift gedrückt halten und an Position C mit der Maus klicken, ergibt das Binding-Tag *Text* eine Auswahl von A bis C; gibt *Ntext* eine Auswahl von B bis C an.  Wenn Sie möchten, dass sich *Ntext* in dieser Hinsicht wie *Text* verhält, setzen Sie **::ntext::classicMouseSelect** auf 1.

**•**
: Das Binding-Tag *Text* ermöglicht es, dass aufeinanderfolgende \<Shift-Button-1>-Ereignisse beide Enden der Auswahl verändern, indem der Anker der Auswahl an das Ende der Auswahl verschoben wird, das am weitesten vom Mausklick entfernt ist.  Im Gegensatz dazu fixiert das Bindung-Tag *Ntext* den Anker, und mehrere Ereignisse Shift-Button-1 können nur das nicht verankerte Ende der Auswahl verschieben. Soll sich *Ntext* darin wie *Text* verhalten, setzt man **::ntext::classicAnchor** auf 1. Bei *Text* und bei *Ntext* verändert die Tastaturnavigation bei gedrückter Taste Shift die Auswahl und hält den Auswahlanker fest.

**•**
: Die folgenden „zusätzlichen“ *Text*-Bindings sind standardmäßig deaktiviert, können jedoch in *Ntext* aktiviert werden, indem Sie **::ntext::classicExtras** auf 1 setzen: \<Control-a>, \<Control-b>, \<Control-d>, \<Control-e>, \<Control-f>, \<Control-h>, \<Control-i>, \<Control-k>, \<Control-n>, \<Control-o>, \<Control-p>, \<Control-t>, \<Control-space>, \<Control-Shift-space>.


# KONFIGURATIONSOPTIONEN

*Ntext* bietet Alternativen zu einer Reihe von Verhaltensweisen des klassischen *Text*-Bindungs-Tags. Sofern eine Option vorhanden ist, ist das *Ntext*-Verhalten standardmäßig aktiviert, mit Ausnahme der Einrückung von Zeilen, die auf einer separaten Seite unter *ntextIndent* erläutert wird.

Das Verhalten von *Ntext* lässt sich anwendungsweit konfigurieren, indem die Werte einer Reihe von Namespace-Variablen festgelegt werden:

**::ntext::classicAnchor**

**•**
: **0** – (Standardwert) wählt das *Ntext*-Verhalten aus, d. h., der Anker ist fest

**•**
: **1** – wählt das klassische *Text*-Verhalten aus, d. h., der Ankerpunkt ist variabel **::ntext::classicExtras**

**•**
: **0** – (Standardwert) wählt das *Ntext*-Verhalten aus, d. h., mehrere „zusätzliche“ *Text*-Bindungen werden deaktiviert

**•**
: **1** – wählt das klassische *Text*-Verhalten aus, d. h., die „zusätzlichen“ *Text*-Bindings werden aktiviert **::ntext::classicMouseSelect**

**•**
: **0** – (Standardwert) wählt das *Ntext*-Verhalten aus, d. h., der Anker für Mausauswahlvorgänge wird durch die Tastaturnavigation verschoben

**•**
: **1** – wählt das klassische *Text*-Verhalten **::ntext::classicParagraphs**

**•**
: **0** – (Vorgabe) Unter macOS Aqua verhalten sich bestimmte Tastatur-Bindings wie in der Mac-Anwendung TextEdit. Die Bindings betreffen das vertikale Verschieben des Bildschirms und lauten \<?Shift-?Option-(Up|Down)>.

**•**
: **1** – Unter macOS Aqua verhalten sich bestimmte Bindings so, wie sie es unter den Windows- und X11-Fenstersystemen sowie im klassischen *Text* tun, wobei die Konventionen von Aqua außer Acht gelassen werden.  Die Bindings betreffen das vertikale Scrollen des Bildschirms und lauten \<?Shift-?Option-(Up|Down)>. **::ntext::classicSelection**

**•**
: **0** - (Standardwert unter macOS Aqua) wählt ein Mac-ähnliches Verhalten aus, d. h., wenn ein Navigationstastenbefehl eine Auswahl aufhebt, springt die Einfügemarke zunächst an das Ende der Auswahl, das durch die Navigationsrichtung des Tastenbefehls bestimmt wird, und erst danach wird der Tastenbefehl ausgeführt.

**•**
: **1** – (Standardwert, außer unter macOS Aqua) wählt ein PC-ähnliches Verhalten aus (entspricht dem klassischen *Text*), d. h., wenn ein Navigationstastenanschlag eine Auswahl aufhebt, wird die Einfügemarke nicht verschoben, bevor der Tastenanschlag ausgeführt wird. **::ntext::overwrite**

**•**
: **0** – (Ausgangswert) Der über die Tastatur eingegebene Text wird in das Widget eingefügt

**•**
: **1** – Über die Tastatur eingegebener Text überschreibt den bereits im Widget vorhandenen Text

**•**
: Der Wert wird mit der Taste *Insert* umgeschaltet. **::ntext::useBlockCursor**

**•**
: **0** – Der Blockcursor wird nicht verwendet. Ist das Widget im Modus *overwrite* (siehe **::ntext::overwrite**), ändert stattdessen der gewöhnliche Cursor seine Farbe.

**•**
: **1** – Der Blockcursor wird verwendet, wenn das Widget im Modus *overwrite* ist (siehe **::ntext::overwrite**).

**•**
: Der Standardwert hängt von der Version von **Tk** ab. In Versionen von **Tk**, die älter sind als **8.5.12**, wies die Größenanpassung des Blockcursors einen Fehler auf, und **::ntext::useBlockCursor** wird standardmäßig auf **0** gesetzt.  Ab **8.5.12** ist der Fehler behoben, und **::ntext::useBlockCursor** wird standardmäßig auf **1** gesetzt.


# INTERNE ABLÄUFE

Um unabhängig von der Version von **Tk** (8.5 oder 8.6) zu bleiben, definiert **ntext** eigene virtuelle Ereignisse.  Diese neuen virtuellen Ereignisse werden ausschließlich im Tag für Bindungen *Ntext* verwendet und beeinträchtigen daher nicht die in anderem Code verwendeten realen oder virtuellen Ereignisse.

Zu diesen Ereignissen gehören <\<NtextCut>>, <\<NtextCopy>>, <\<NtextPaste>>, die jeweils anstelle von <\<Cut>>, <\<Copy>> und <\<Paste>> verwendet werden.

Die Definitionen der virtuellen Ereignisse <\<NtextCut>> (usw.) entsprechen den Definitionen der <\<Cut>> (usw.) in **Tk** 8.6.

# BUGS

Diese Version von **ntext** soll mit allen Releases von **Tk** 8.5, 8.6 und 8.7 kompatibel sein und mit den Zweigen *core-8-5-branch*, *core-8-6-branch* und *trunk* im Quellcode-Repository von **Tk**. Jede Inkompatibilität mit einer dieser Versionen, bei jedem Fenstersystem von **Tk**, ist als Fehler zu melden. Bitte melden Sie das in der Kategorie *ntext* der [Tklib-Tracker](https://core.tcl-lang.org/tklib/reportlist).

# BEISPIEL

Um *Ntext* zu verwenden, dabei aber die Funktion des variablen Ankers des klassischen *Text* beizubehalten:

```
package require ntext
text .t
set ::ntext::classicAnchor 1
bindtags .t {.t Ntext . all}
```
