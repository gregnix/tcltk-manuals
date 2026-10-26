---
CommandName: ntext
title: ntext
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Alternative Bindings for the Text Widget
Links:
 - bindtags
 - ntextBindings
 - ntextIndent
 - ntextWordBreak
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

ntext – Alternative Bindings für das Text-Widget

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [ntext]{.lit} [1.0]{.optlit}
[::ntext::new\_textCopy]{.cmd} [pathName]{.arg}
[::ntext::new\_textCut]{.cmd} [pathName]{.arg}
[::ntext::new\_textPaste]{.cmd} [pathName]{.arg}
[::ntext::syncIndentColor]{.cmd} [pathName]{.arg}
[::ntext::syncTabColor]{.cmd} [pathName]{.arg}
:::

# Beschreibung

Das **ntext**-Paket dient dazu, das Verhalten des Text-Widgets stärker an das anderer Textbearbeitungsprogramme anzupassen. Dadurch eignet sich das Text-Widget besser für die Implementierung eines Texteditors und verhält sich auf eine Weise, die den meisten Benutzern vertrauter ist.

Das Paket stellt ein Bindungs-Tag namens *Ntext* bereit, das von Text-Widgets anstelle des standardmäßigen Bindungs-Tags *Text* verwendet werden kann.

Die Funktionen und Variablen des Pakets **ntext** sind vollständig im Namespace **::ntext** enthalten; der übrige Code befindet sich im Binding-Tag *Ntext*.  **ntext** enthält keine Exporte in den globalen oder anderen Namespaces und keine neuen Widget-Befehle. Es verwendet modifizierte Kopien des **Tk**-Codes, wobei der ursprüngliche Code und das Binding-Tag *Text* unverändert bleiben.

Die Unterschiede zwischen dem Bindungs-Tag *Ntext* und dem Standard-Bindungs-Tag *Text* lassen sich in drei Kategorien einteilen:

- Einige *Text*-Bindings verhalten sich anders als in den meisten Textbearbeitungsprogrammen. *Ntext* gibt diesen Bindings ein vertrauteres Verhalten. Einzelheiten stehen in *ntextBindings*.

- Wird eine logische Zeile mit führendem Leerraum im Wortumbruch auf mehrere Anzeigezeilen umbrochen, beginnen die umbrochenen Anzeigezeilen weiter links als die erste Anzeigezeile. Das Layout kann dadurch unordentlich und schwer lesbar werden. *Ntext* kann die umbrochenen Zeilen so einrücken, dass sie zum führenden Leerraum der ersten Anzeigezeile passen (diese Möglichkeit ist vorgegeben ausgeschaltet). Einzelheiten stehen in *ntextIndent*.

- Wenn der Benutzer durch den Text navigiert oder Text auswählt, muss **Tcl/Tk** gelegentlich Wortgrenzen erkennen. *Ntext* bietet verbesserte Regeln für die Erkennung von Wortgrenzen. Einzelheiten finden Sie unter *ntextWordBreak*.


Im weiteren Verlauf dieser Seite werden die grundlegende Verwendung und Konfiguration aller drei Aspekte von *Ntext* beschrieben.  Ausführlichere Informationen zu den verschiedenen Funktionen von *Ntext* finden Sie auf den Seiten *ntextBindings*, *ntextIndent* und *ntextWordBreak*.

Im Abschnitt [Beispiel] erfahren Sie, wie Sie das Bindungs-Tag *Ntext* anstelle des Bindungs-Tags *Text* anwenden können.

# Befehle

**::ntext::new\_textCopy** *pathName*
: Ersatz für ::tk\_textCopy.

**::ntext::new\_textCut** *pathName*
: Ersatz für ::tk\_textCut, der zudem die *Ntext*-Einrückung beibehält (siehe *ntextIndent*).

**::ntext::new\_textPaste** *pathName*
: Ersatz für ::tk\_textPaste, der zudem die *Ntext*-Einrückung beibehält (siehe *ntextIndent*).

**::ntext::syncIndentColor** *pathName*
: Befehl zum Anwenden des aktuellen Werts der Variablen **::ntext::indentColor** auf vorhandene Zeilen in einem Text-Widget.  Dieser Befehl ist nützlich, wenn ein Text-Widget erstellt wurde, Text in das Widget eingefügt wurde *und anschließend* der Wert von **::ntext::indentColor** geändert wird (siehe *ntextIndent*).

**::ntext::syncTabColor** *pathName*
: Befehl zum Anwenden der aktuellen Werte der Variablen **::ntext::tabColor** und **::ntext::tabSelColor** auf Tabulatorzeichen in einem Text-Widget.  Dieser Befehl ist nützlich, wenn ein Text-Widget erstellt wurde, Text in das Widget eingefügt wurde *und anschließend* der Wert von **::ntext::tabColor** oder **::ntext::tabSelColor** geändert wird.


# Konfigurationsoptionen

*Ntext* bietet Alternativen zu einer Reihe von Verhaltensweisen des klassischen Bindungs-Tags *Text*. Sofern Optionen vorhanden sind, ist das *Ntext*-Verhalten (mit Ausnahme der Einrückung der Anzeigezeilen) standardmäßig aktiviert.

Das Verhalten von *Ntext* lässt sich anwendungsweit konfigurieren, indem die Werte einer Reihe von Namespace-Variablen festgelegt werden:

**::ntext::classicAnchor**

- **0** – (Standardwert) wählt das *Ntext*-Verhalten aus, d. h., der Anker ist fest

- **1** – wählt das klassische *Text*-Verhalten aus, d. h., der Anker ist variabel

- Weitere Informationen finden Sie unter *ntextBindings*


**::ntext::classicExtras**

- **0** – (Standardwert) wählt das *Ntext*-Verhalten aus, d. h., mehrere herkömmliche *Text*-Bindungen werden deaktiviert

- **1** – wählt das klassische *Text*-Verhalten, das heißt, alle *Text*-Bindings sind aktiviert

- Weitere Informationen finden Sie unter *ntextBindings*


**::ntext::classicMouseSelect**

- **0** – (Standardwert) wählt das *Ntext*-Verhalten aus, d. h., der Anker für Mausauswahlvorgänge wird durch die Tastaturnavigation verschoben

- **1** – wählt das klassische *Text*-Verhalten

- Weitere Informationen finden Sie unter *ntextBindings*


**::ntext::classicParagraphs**

- **0** – (Vorgabe) Unter macOS Aqua verhalten sich bestimmte Tastatur-Bindings wie in der Mac-Anwendung TextEdit. Die Bindings betreffen das vertikale Verschieben des Bildschirms und lauten <?Shift-?Option-(Up|Down)>.

- **1** – Unter macOS Aqua verhalten sich bestimmte Bindings wie klassisches *Text* und ignorieren die Konventionen von Aqua. Die Bindings betreffen das vertikale Verschieben des Bildschirms und lauten <?Shift-?Option-(Up|Down)>.

- Weitere Informationen finden Sie unter *ntextBindings*


**::ntext::classicSelection**

- **0** - (Standardwert unter macOS Aqua) wählt ein Mac-ähnliches Verhalten aus, d. h., wenn ein Navigationstastenbefehl eine Auswahl aufhebt, springt die Einfügemarke zunächst an das Ende der Auswahl, das durch die Navigationsrichtung des Tastenbefehls bestimmt wird, und erst danach wird der Tastenbefehl ausgeführt.

- **1** – (Standardwert, außer unter macOS Aqua) wählt ein PC-ähnliches Verhalten aus (entspricht dem klassischen *Text*), d. h., wenn ein Navigationstastenbefehl eine Auswahl aufhebt, wird die Einfügemarke nicht verschoben, bevor der Tastenbefehl ausgeführt wird.

- Weitere Informationen finden Sie unter *ntextBindings*


**::ntext::classicWordBreak**

- **0** – (Standardwert) wählt das *Ntext*-Verhalten aus, d. h. plattformunabhängig, zwei Klassen von Wortzeichen und eine Klasse von Nicht-Wortzeichen.

- **1** – wählt das klassische *Text*-Verhalten, d. h. plattformabhängig, mit einer Klasse für Wortzeichen und einer Klasse für Nicht-Wortzeichen

- Nach der Änderung dieses Werts sollten die Übereinstimmungsmuster neu berechnet werden. Weitere Informationen sowie erweiterte Konfigurationsoptionen finden Sie unter *ntextWordBreak*.


**::ntext::classicWrap**

- **0** – wählt das *Ntext*-Verhalten, das heißt, Anzeigezeilen von Text-Widgets im Modus *-wrap* *word* werden so eingerückt, dass sie zum anfänglichen Leerraum der ersten Anzeigezeile einer logischen Zeile passen. Enthält das Widget beim Setzen dieses Werts schon Text, kann ein Funktionsaufruf nötig sein. Die genaue Verwendung der Einrückung von *Ntext* steht in *ntextIndent*.

- **1** – (Vorgabe) wählt das klassische *Text*-Verhalten, das heißt keine Einrückung

- Weitere Informationen finden Sie unter *ntextIndent*


**::ntext::indentColor**

- **{}** – Wenn der Wert eine leere Zeichenkette ist, so hat der Einzug der umgebrochenen Anzeigezeilen dieselbe Farbe wie der Hintergrund des Widgets.

- *color* – eine gültige **Tk**-Farbe, die für den Einzug von umgebrochenen Anzeigezeilen verwendet werden soll (Standardwert *#d9d9d9*).

    Die Farbgebung wird über die Tag-Option *-lmargincolor* des Text-Widgets implementiert, die ab **Tk** 8.6.6 verfügbar ist.  Die Einrückungsfarbe von *Ntext* hat in früheren Versionen von **Tk** keine Auswirkung.

    Der Wert von **::ntext::indentColor** wird häufig beim Start festgelegt.  Wenn der Wert geändert wird, während bereits Text-Widgets vorhanden sind und Text enthalten, können diese Widgets durch Aufruf des Befehls **::ntext::syncIndentColor** aktualisiert werden.

- Weitere Informationen finden Sie unter *ntextIndent*


**::ntext::overwrite**

- **0** – (Ausgangswert) Der über die Tastatur eingegebene Text wird in das Widget eingefügt

- **1** – Über die Tastatur eingegebener Text überschreibt den bereits im Widget vorhandenen Text

- Der Wert wird mit der Taste *Insert* umgeschaltet, außer unter macOS Aqua, wo es diese Taste nicht gibt.

- Weitere Informationen finden Sie unter *ntextBindings*


**::ntext::tabColor**

- **{}** – Wenn der Wert eine leere Zeichenkette ist, haben die Tabulatorzeichen dieselbe Farbe wie der Hintergrund des Widgets.

- *color* – eine gültige **Tk**-Farbe für die Tabulatorabstände (Vorgabe *#ffffaa*).

    Der Wert von **::ntext::tabColor** wird oft beim Start gesetzt. Wird er geändert, während Text-Widgets schon Text enthalten, lassen sich diese Widgets mit **::ntext::syncTabColor** aktualisieren.


**::ntext::tabSelColor**

- **{}** – Ist der Wert die leere Zeichenkette, ist die Farbe der Tabulatorabstände in der Auswahl vorgegeben dieselbe wie die der nicht ausgewählten Tabulatoren (siehe **::ntext::tabColor**) und *nicht* die Farbe *-selectbackground* des Widgets.

- *color* – eine gültige **Tk**-Farbe für die Tabulatorabstände in der Auswahl (Vorgabe *#418bd4*).

    Der Wert von **::ntext::tabSelColor** wird oft beim Start gesetzt. Wird er geändert, während Text-Widgets schon Text enthalten, lassen sich diese Widgets mit **::ntext::syncTabColor** aktualisieren.


**::ntext::useBlockCursor**

- **0** – Der Blockcursor wird nicht verwendet. Ist das Widget im Modus *overwrite* (siehe **::ntext::overwrite**), ändert stattdessen der gewöhnliche Cursor seine Farbe.

- **1** – Der Blockcursor wird verwendet, wenn das Widget im Modus *overwrite* ist (siehe **::ntext::overwrite**).

- Der Standardwert hängt von der Version von **Tk** ab. In Versionen von **Tk**, die älter sind als **8.5.12**, wies die Größenanpassung des Blockcursors einen Fehler auf, und **::ntext::useBlockCursor** wird standardmäßig auf **0** gesetzt.  Ab **8.5.12** ist der Fehler behoben, und **::ntext::useBlockCursor** wird standardmäßig auf **1** gesetzt.

- Weitere Informationen finden Sie unter *ntextBindings*


# Bugs

Diese Version von **ntext** soll mit allen Releases von **Tk** 8.5, 8.6 und 8.7 kompatibel sein und mit den Zweigen *core-8-5-branch*, *core-8-6-branch* und *trunk* im Quellcode-Repository von **Tk**. Jede Inkompatibilität mit einer dieser Versionen, bei jedem Fenstersystem von **Tk**, ist als Fehler zu melden. Bitte melden Sie das in der Kategorie *ntext* der [Tklib-Tracker](https://core.tcl-lang.org/tklib/reportlist).

# Beispiel

So erstellen Sie ein Text-Widget .t und verwenden die *Ntext*-Bindungen:

```
package require ntext
text .t
bindtags .t {.t Ntext . all}
```

Weitere Informationen finden Sie unter **bindtags**.
