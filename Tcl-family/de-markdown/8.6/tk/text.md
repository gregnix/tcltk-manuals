---
CommandName: text
title: text
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - entry(n)
 - scrollbar(n)
Keywords:
 - text
 - widget
 - tkvars
Copyright:
 - Copyright (c) 1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

text, tk\_textCopy, tk\_textCut, tk\_textPaste - Erstellt und manipuliert 'text'-Hypertext-Bearbeitungswidgets

# Übersicht

::: {.synopsis} :::
[text]{.cmd} [pathName]{.arg} [options]{.optarg}
[tk\_textCopy]{.cmd} [pathName]{.arg}
[tk\_textCut]{.cmd} [pathName]{.arg}
[tk\_textPaste]{.cmd} [pathName]{.arg}
:::

# Standardoptionen

**-background**, **-highlightthickness**, **-relief**, **-borderwidth**, **-insertbackground**, **-selectbackground**, **-cursor**, **-insertborderwidth**, **-selectborderwidth**, **-exportselection**, **-insertofftime**, **-selectforeground**, **-font**, **-insertontime**, **-setgrid**, **-foreground**, **-insertwidth**, **-takefocus**, **-highlightbackground**, **-padx**, **-xscrollcommand**, **-highlightcolor**, **-pady**, **-yscrollcommand**

Siehe die Manualseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-autoseparators** (**autoSeparators**/**AutoSeparators**)
: Legt einen booleschen Wert fest, der angibt, ob automatisch Trennzeichen in den Rückgängig-Stapel eingefügt werden. Die Option ist nur von Bedeutung, wenn die Option **-undo** true ist.

**-blockcursor** (**blockCursor**/**BlockCursor**)
: Legt einen booleschen Wert fest, der angibt, ob der blinkende Einfügecursor als rechteckiger Block in Zeichengröße gezeichnet werden soll. Ist der Wert false (Standard), wird für den Einfügecursor eine dünne senkrechte Linie verwendet.

**-endline** (**endLine**/**EndLine**)
: Legt einen ganzzahligen Zeilenindex fest, der die Zeile des zugrunde liegenden textuellen Datenspeichers angibt, die unmittelbar nach der letzten im Widget enthaltenen Zeile liegen soll. Dadurch kann ein Text-Widget nur einen Teil eines größeren Textes wiedergeben. Statt einer Ganzzahl kann für diese Konfigurationsoption die leere Zeichenkette angegeben werden; das Widget endet dann in der allerletzten Zeile des textuellen Datenspeichers.

**-height** (**height**/**Height**)
: Legt die gewünschte Höhe des Fensters fest, gemessen in Zeichen der Schriftart, die mit der Option **-font** angegeben ist. Der Wert muss mindestens eins sein.

**-inactiveselectbackground** (**inactiveSelectBackground**/**Foreground**)
: Legt die Farbe fest, die für die Auswahl (das Tag **sel**) verwendet wird, wenn das Fenster nicht den Eingabefokus hat. Ist der Wert leer (**{}**), wird keine Auswahl angezeigt, solange das Fenster nicht den Fokus hat.

**-insertunfocussed** (**insertUnfocussed**/**InsertUnfocussed**)
: [Legt fest, wie der Einfügecursor angezeigt wird, wenn das Widget nicht den Fokus hat. Der Wert muss **none** (Standard) sein, was bedeutet, dass der Cursor nicht angezeigt wird, **hollow**, was eine hohle Box anzeigt, oder **solid**, was eine ausgefüllte Box anzeigt. Beachten Sie, dass **hollow** und **solid** sehr ähnlich aussehen, wenn die Option **-blockcursor** false ist.]{version="8.6"}

**-maxundo** (**maxUndo**/**MaxUndo**)
: Legt die maximale Anzahl zusammengesetzter Rückgängig-Aktionen auf dem Rückgängig-Stapel fest. Null oder ein negativer Wert bedeuten einen unbegrenzten Rückgängig-Stapel.

**-spacing1** (**spacing1**/**Spacing1**)
: Fordert zusätzlichen Abstand oberhalb jeder Textzeile im Widget an; dabei ist jede der Standardformen für Bildschirmabstände zulässig. Wird eine Zeile umbrochen, gilt diese Option nur für die erste Zeile der Anzeige. Diese Option kann durch **-spacing1**-Optionen in Tags überschrieben werden.

**-spacing2** (**spacing2**/**Spacing2**)
: Für Zeilen, die umbrochen werden (und damit auf der Anzeige mehr als eine Zeile einnehmen), legt diese Option zusätzlichen Abstand zwischen den Anzeigezeilen fest, die eine einzelne Textzeile darstellen. Der Wert kann jede der Standardformen für Bildschirmabstände haben. Diese Option kann durch **-spacing2**-Optionen in Tags überschrieben werden.

**-spacing3** (**spacing3**/**Spacing3**)
: Fordert zusätzlichen Abstand unterhalb jeder Textzeile im Widget an; dabei ist jede der Standardformen für Bildschirmabstände zulässig. Wird eine Zeile umbrochen, gilt diese Option nur für die letzte Zeile der Anzeige. Diese Option kann durch **-spacing3**-Optionen in Tags überschrieben werden.

**-startline** (**startLine**/**StartLine**)
: Legt einen ganzzahligen Zeilenindex fest, der die erste Zeile des zugrunde liegenden textuellen Datenspeichers angibt, die im Widget enthalten sein soll. Dadurch kann ein Text-Widget nur einen Teil eines größeren Textes wiedergeben. Statt einer Ganzzahl kann für diese Konfigurationsoption die leere Zeichenkette angegeben werden; das Widget beginnt dann in der allerersten Zeile des textuellen Datenspeichers.

**-state** (**state**/**State**)
: Legt einen von zwei Zuständen für den Text fest: **normal** oder **disabled**. Ist der Text deaktiviert, können keine Zeichen eingefügt oder gelöscht werden, und es wird kein Einfügecursor angezeigt, selbst wenn der Eingabefokus im Widget liegt.

**-tabs** (**tabs**/**Tabs**)
: Legt eine Menge von Tabstopps für das Fenster fest. Der Wert der Option besteht aus einer Liste von Bildschirmabständen, die die Positionen der Tabstopps angeben; jede Position ist ein Abstand relativ zum linken Rand des Widgets (ohne Rahmen, Innenabstand usw.). Auf jede Position kann im nächsten Listenelement optional eines der Schlüsselwörter **left**, **right**, **center** oder **numeric** folgen; es legt fest, wie der Text relativ zum Tabstopp ausgerichtet wird. **Left** ist die Vorgabe; dabei wird der Text nach dem Tabulatorzeichen so positioniert, dass seine linke Kante an der Tabposition liegt. **Right** bedeutet, dass die rechte Kante des Textes nach dem Tabulatorzeichen an der Tabposition liegt, und **center** bedeutet, dass der Text an der Tabposition zentriert wird. **Numeric** bedeutet, dass der Dezimalpunkt im Text an der Tabposition liegt; gibt es keinen Dezimalpunkt, wird die niederwertigste Ziffer der Zahl unmittelbar links von der Tabposition gesetzt; enthält der Text keine Zahl, wird er rechtsbündig an der Tabposition ausgerichtet. Zum Beispiel erzeugt „**-tabs {2c left 4c 6c center}**“ drei Tabstopps im Abstand von zwei Zentimetern; die ersten beiden sind linksbündig, der dritte ist zentriert.

    Enthält die Liste der Tabstopps nicht genug Elemente, um alle Tabulatoren einer Textzeile abzudecken, extrapoliert Tk neue Tabstopps anhand von Abstand und Ausrichtung des letzten Tabstopps der Liste. Tab-Abstände müssen strikt positiv sein und von einem Tabstopp zum nächsten stets zunehmen (andernfalls wird ein Fehler ausgelöst). Der Wert der Option **-tabs** kann durch **-tabs**-Optionen in Tags überschrieben werden.

    Ist keine Option **-tabs** angegeben oder ist sie als leere Liste angegeben, verwendet Tk Standard-Tabulatoren im Abstand von je acht (durchschnittlich breiten) Zeichen. Um einen anderen Standardabstand zu erreichen, zum Beispiel alle 4 Zeichen, konfigurieren Sie das Widget einfach mit „**-tabs "\[expr {4 \* \[font measure $font 0\]}\] left" -tabstyle wordprocessor**“.

**-tabstyle** (**tabStyle**/**TabStyle**)
: Legt fest, wie die Beziehung zwischen den Tabstopps einer Zeile und den Tabulatoren im Text dieser Zeile interpretiert wird. Der Wert muss **tabular** (Standard) oder **wordprocessor** sein. Beachten Sie, dass Tabulatoren in der Reihenfolge interpretiert werden, in der sie im Text vorkommen. Ist der Tabulatorstil **tabular**, wird das *n*-te Tabulatorzeichen im Text der Zeile dem *n*-ten Tabstopp zugeordnet, der für diese Zeile definiert ist. Liegt die x-Koordinate des Tabulatorzeichens rechts vom *n*-ten Tabstopp, wird ersatzweise eine Lücke von einem einzelnen Leerzeichen eingefügt. Ist der Tabulatorstil **wordprocessor**, verwendet jedes Tabulatorzeichen, das gesetzt wird, den ersten Tabstopp rechts von den vorangehenden Zeichen, die in dieser Zeile bereits gesetzt sind (und wird durch diesen Tabstopp bestimmt). Der Wert der Option **-tabstyle** kann durch **-tabstyle**-Optionen in Tags überschrieben werden.

**-undo** (**undo**/**Undo**)
: Legt einen booleschen Wert fest, der angibt, ob der Rückgängig-Mechanismus aktiv ist oder nicht.

**-width** (**width**/**Width**)
: Legt die gewünschte Breite des Fensters fest, gemessen in Zeichen der Schriftart, die mit der Option **-font** angegeben ist. Hat die Schriftart keine einheitliche Breite, wird bei der Umrechnung von Zeicheneinheiten in Bildschirmeinheiten die Breite des Zeichens „0“ verwendet.

**-wrap** (**wrap**/**Wrap**)
: Legt fest, wie mit Zeilen im Text umgegangen wird, die zu lang sind, um in einer einzigen Zeile des Textfensters angezeigt zu werden. Der Wert muss **none**, **char** oder **word** sein. Der Umbruchmodus **none** bedeutet, dass jede Textzeile als genau eine Zeile auf dem Bildschirm erscheint; überzählige Zeichen, die nicht auf den Bildschirm passen, werden nicht angezeigt. In den anderen Modi wird jede Textzeile bei Bedarf auf mehrere Bildschirmzeilen aufgeteilt, damit alle Zeichen sichtbar bleiben. Im Modus **char** kann ein Bildschirmzeilenumbruch nach jedem beliebigen Zeichen erfolgen; im Modus **word** wird eine Zeile nur an Wortgrenzen umbrochen.


# Beschreibung

Der Befehl **text** erstellt ein neues Fenster (angegeben durch das Argument *pathName*) und macht es zu einem Text-Widget. Weitere, oben beschriebene Optionen können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des Textes wie die Standard-Hintergrundfarbe und das Relief zu konfigurieren. Der Befehl **text** gibt den Pfadnamen des neuen Fensters zurück.

Ein Text-Widget zeigt eine oder mehrere Textzeilen an und erlaubt es, diesen Text zu bearbeiten. Text-Widgets unterstützen vier verschiedene Arten von Annotationen im Text: Tags, Marken, eingebettete Fenster und eingebettete Bilder. Mit Tags lassen sich verschiedene Teile des Textes in unterschiedlichen Schriftarten und Farben darstellen. Außerdem können Tags Tcl-Befehle zugeordnet werden, sodass Skripte aufgerufen werden, wenn in bestimmten Bereichen des Textes bestimmte Aktionen wie Tastendrücke oder das Drücken von Maustasten auftreten. Weitere Einzelheiten finden Sie unten unter [Tags].

Die zweite Form der Annotation besteht aus schwebenden Markierungen im Text, den sogenannten „Marken“. Mit Marken lassen sich verschiedene interessante Positionen im Text verfolgen, während er bearbeitet wird. Weitere Einzelheiten finden Sie unten unter [Marken].

Die dritte Form der Annotation erlaubt es, beliebige Fenster in ein Text-Widget einzubetten. Weitere Einzelheiten finden Sie unten unter [Eingebettete Fenster].

Die vierte Form der Annotation erlaubt es, Tk-Bilder in ein Text-Widget einzubetten. Weitere Einzelheiten finden Sie unten unter [Eingebettete Bilder].

Das Text-Widget hat außerdem einen eingebauten Rückgängig-/Wiederholen-Mechanismus. Weitere Einzelheiten finden Sie unten unter [Der Rückgängig-Mechanismus].

Das Text-Widget erlaubt das Erstellen von Peer-Widgets. Das sind weitere Text-Widgets, die dieselben zugrunde liegenden Daten (Text, Marken, Tags, Bilder usw.) gemeinsam nutzen. Weitere Einzelheiten finden Sie unten unter [Peer-Widgets].

# Indizes

Viele der Widget-Befehle für Text-Widgets nehmen einen oder mehrere Indizes als Argumente entgegen. Ein Index ist eine Zeichenkette, die eine bestimmte Stelle in einem Text angibt, etwa eine Stelle, an der Zeichen eingefügt werden sollen, oder einen Endpunkt eines Bereichs von Zeichen, die gelöscht werden sollen. Indizes haben die Syntax

```
base modifier modifier modifier ...
```

Dabei gibt *base* einen Ausgangspunkt an, und die *modifier* verschieben den Index von diesem Ausgangspunkt aus (z. B. ein Zeichen vorwärts oder rückwärts). Jeder Index muss eine *base* enthalten, die *modifier* sind dagegen optional. Die meisten Modifier (wie unten dokumentiert) erlauben einen optionalen Submodifier. Gültige Submodifier sind **any** und **display**. Ist der Submodifier abgekürzt, muss Leerraum auf ihn folgen; andernfalls ist zwischen dem Submodifier und dem folgenden *modifier* kein Leerzeichen nötig. Typischerweise ändert der Submodifier **display** die Bedeutung des folgenden *modifier* so, dass er sich auf sichtbare bzw. nicht ausgeblendete Einheiten statt auf logische Einheiten bezieht; dies wird aber unten für jeden betroffenen Fall einzeln erklärt. Schließlich kann *count*, wo es Teil eines Modifiers ist, positiv oder negativ sein; „*base* - -3 lines“ ist also völlig gültig (und gleichwertig mit „*base* +3lines“).

Die *base* eines Index muss eine der folgenden Formen haben:

*line*__.__*char*
: Bezeichnet das *char*-te Zeichen in Zeile *line*. Zeilen werden ab 1 nummeriert, um mit anderen UNIX-Programmen übereinzustimmen, die dieses Nummerierungsschema verwenden. Innerhalb einer Zeile werden Zeichen ab 0 nummeriert. Ist *char* **end**, bezieht es sich auf das Zeilenumbruchzeichen, das die Zeile beendet.

**@**_x_**,**_y_
: Bezeichnet das Zeichen, das das Pixel bedeckt, dessen x- und y-Koordinaten im Fenster des Textes *x* und *y* sind.

**end**
: Bezeichnet das Ende des Textes (das Zeichen unmittelbar nach dem letzten Zeilenumbruch).

*mark*
: Bezeichnet das Zeichen unmittelbar nach der Marke mit dem Namen *mark* (Einzelheiten siehe [Marken]).

*tag*__.first__
: Bezeichnet das erste Zeichen im Text, das mit dem Tag *tag* versehen ist. Diese Form erzeugt einen Fehler, wenn derzeit keine Zeichen mit *tag* versehen sind.

*tag*__.last__
: Bezeichnet das Zeichen unmittelbar nach dem letzten Zeichen im Text, das mit dem Tag *tag* versehen ist. Diese Form erzeugt einen Fehler, wenn derzeit keine Zeichen mit *tag* versehen sind.

*pathName*
: Bezeichnet die Position des eingebetteten Fensters mit dem Namen *pathName*. Diese Form erzeugt einen Fehler, wenn es kein eingebettetes Fenster mit diesem Namen gibt.

*imageName*
: Bezeichnet die Position des eingebetteten Bildes mit dem Namen *imageName*. Diese Form erzeugt einen Fehler, wenn es kein eingebettetes Bild mit diesem Namen gibt.


Könnte die *base* mehr als einer der obigen Formen entsprechen, etwa wenn eine *mark* und ein *imageName* denselben Wert haben, hat die Form Vorrang, die in der obigen Liste weiter oben steht. Folgen Modifier auf den Basisindex, muss jeder von ihnen eine der unten aufgeführten Formen haben. Schlüsselwörter wie **chars** und **wordend** dürfen abgekürzt werden, solange die Abkürzung eindeutig ist.

**+** *count* ?*submodifier*? **chars**
: Verschiebt den Index um *count* Zeichen vorwärts und geht dabei bei Bedarf zu späteren Zeilen im Text über. Gibt es im Text nach dem aktuellen Index weniger als *count* Zeichen, wird der Index auf den letzten Index im Text gesetzt. Leerzeichen auf beiden Seiten von *count* sind optional. Ist der Submodifier **display** angegeben, werden ausgeblendete Zeichen übersprungen, ohne gezählt zu werden. Ist **any** angegeben, werden alle Zeichen gezählt. Ist keiner der beiden Modifier angegeben, erfolgt die Zählung aus historischen Gründen tatsächlich in Einheiten von Indexpositionen (Einzelheiten siehe [Indizes]). Dieses Verhalten kann sich in einer künftigen Hauptversion ändern. Wenn Sie eine Zählung von Indizes benötigen, sollten Sie daher nach Möglichkeit stattdessen **indices** verwenden.

**-** *count* ?*submodifier*? **chars**
: Verschiebt den Index um *count* Zeichen rückwärts und geht dabei bei Bedarf zu früheren Zeilen im Text über. Gibt es im Text vor dem aktuellen Index weniger als *count* Zeichen, wird der Index auf den ersten Index im Text (1.0) gesetzt. Leerzeichen auf beiden Seiten von *count* sind optional. Ist der Submodifier **display** angegeben, werden ausgeblendete Zeichen übersprungen, ohne gezählt zu werden. Ist **any** angegeben, werden alle Zeichen gezählt. Ist keiner der beiden Modifier angegeben, erfolgt die Zählung aus historischen Gründen tatsächlich in Einheiten von Indexpositionen (Einzelheiten siehe [Indizes]). Dieses Verhalten kann sich in einer künftigen Hauptversion ändern. Wenn Sie eine Zählung von Indizes benötigen, sollten Sie daher nach Möglichkeit stattdessen **indices** verwenden.

**+** *count* ?*submodifier*? **indices**
: Verschiebt den Index um *count* Indexpositionen vorwärts und geht dabei bei Bedarf zu späteren Zeilen im Text über. Gibt es im Text nach dem aktuellen Index weniger als *count* Indexpositionen, wird der Index auf die letzte Indexposition im Text gesetzt. Leerzeichen auf beiden Seiten von *count* sind optional. Beachten Sie, dass eine Indexposition entweder ein einzelnes Zeichen oder ein einzelnes eingebettetes Bild oder eingebettetes Fenster ist. Ist der Submodifier **display** angegeben, werden ausgeblendete Indizes übersprungen, ohne gezählt zu werden. Ist **any** angegeben, werden alle Indizes gezählt; dies ist auch das Standardverhalten, wenn kein Modifier angegeben ist.

**-** *count* ?*submodifier*? **indices**
: Verschiebt den Index um *count* Indexpositionen rückwärts und geht dabei bei Bedarf zu früheren Zeilen im Text über. Gibt es im Text vor dem aktuellen Index weniger als *count* Indexpositionen, wird der Index auf die erste Indexposition (1.0) im Text gesetzt. Leerzeichen auf beiden Seiten von *count* sind optional. Ist der Submodifier **display** angegeben, werden ausgeblendete Indizes übersprungen, ohne gezählt zu werden. Ist **any** angegeben, werden alle Indizes gezählt; dies ist auch das Standardverhalten, wenn kein Modifier angegeben ist.

**+** *count* ?*submodifier*? **lines**
: Verschiebt den Index um *count* Zeilen vorwärts und behält dabei dieselbe Zeichenposition innerhalb der Zeile bei. Gibt es nach der Zeile mit dem aktuellen Index weniger als *count* Zeilen, wird der Index auf dieselbe Zeichenposition in der letzten Zeile des Textes gesetzt. Ist die Zeile dann nicht lang genug, um an der angegebenen Zeichenposition ein Zeichen zu enthalten, wird die Zeichenposition auf das letzte Zeichen der Zeile (den Zeilenumbruch) gesetzt. Leerzeichen auf beiden Seiten von *count* sind optional. Ist der Submodifier **display** angegeben, wird jede sichtbare Anzeigezeile einzeln gezählt. Ist dagegen **any** (oder kein Modifier) angegeben, zählt jede logische Zeile nur einmal, unabhängig davon, wie oft sie in der Anzeige umbrochen ist. Sind die betreffenden Zeilen nicht umbrochen, sind beide Zählweisen gleichwertig.

**-** *count* ?*submodifier*? **lines**
: Verschiebt den Index um *count* logische Zeilen rückwärts und behält dabei dieselbe Zeichenposition innerhalb der Zeile bei. Gibt es vor der Zeile mit dem aktuellen Index weniger als *count* Zeilen, wird der Index auf dieselbe Zeichenposition in der ersten Zeile des Textes gesetzt. Ist die Zeile dann nicht lang genug, um an der angegebenen Zeichenposition ein Zeichen zu enthalten, wird die Zeichenposition auf das letzte Zeichen der Zeile (den Zeilenumbruch) gesetzt. Leerzeichen auf beiden Seiten von *count* sind optional. Ist der Submodifier **display** angegeben, wird jede sichtbare Anzeigezeile einzeln gezählt. Ist dagegen **any** (oder kein Modifier) angegeben, zählt jede logische Zeile nur einmal, unabhängig davon, wie oft sie in der Anzeige umbrochen ist. Sind die betreffenden Zeilen nicht umbrochen, sind beide Zählweisen gleichwertig.

?*submodifier*? **linestart**
: Setzt den Index auf den ersten Index der Zeile. Ist der Submodifier **display** angegeben, ist dies der erste Index der Anzeigezeile, andernfalls der logischen Zeile.

?*submodifier*? **lineend**
: Setzt den Index auf den letzten Index der Zeile (den Zeilenumbruch). Ist der Submodifier **display** angegeben, ist dies der letzte Index der Anzeigezeile, andernfalls der logischen Zeile.

?*submodifier*? **wordstart**
: Setzt den Index auf das erste Zeichen des Wortes, das den aktuellen Index enthält. Ein Wort besteht aus beliebig vielen benachbarten Zeichen, die Buchstaben, Ziffern oder Unterstriche sind, oder aus einem einzelnen Zeichen, das keines davon ist. Ist der Submodifier **display** angegeben, werden nur nicht ausgeblendete Zeichen untersucht, andernfalls alle Zeichen (ausgeblendet oder nicht).

?*submodifier*? **wordend**
: Setzt den Index auf das Zeichen unmittelbar nach dem letzten Zeichen des Wortes, das den aktuellen Index enthält. Verweist der aktuelle Index auf das letzte Zeichen des Textes, wird er nicht verändert. Ist der Submodifier **display** angegeben, werden nur nicht ausgeblendete Zeichen untersucht, andernfalls alle Zeichen (ausgeblendet oder nicht).


Sind mehrere Modifier vorhanden, werden sie von links nach rechts angewendet. Zum Beispiel bezeichnet der Index „**end - 1 chars**“ das vorletzte Zeichen im Text, und „**insert wordstart - 1 c**“ bezeichnet das Zeichen unmittelbar vor dem ersten Zeichen des Wortes, das den Einfügecursor enthält. Die Modifier werden einzeln in dieser Reihenfolge von links nach rechts angewendet, und nach jedem Schritt wird der resultierende Index auf einen gültigen Index im Text-Widget beschränkt. So bezeichnet zum Beispiel der Index „**1.0 -1c +1c**“ den Index „**2.0**“.

Führen Modifier zu Indexänderungen um Anzeigezeilen, Anzeigezeichen oder Anzeigeindizes und verweist die *base* auf einen Index innerhalb eines ausgeblendeten Tags, gilt dieser Basisindex als gleichwertig mit dem ersten folgenden nicht ausgeblendeten Index.

# Tags

Die erste Form der Annotation in Text-Widgets ist ein Tag. Ein Tag ist eine Zeichenkette, die mit einigen Zeichen eines Textes verknüpft ist. Tags dürfen beliebige Zeichen enthalten, doch vermeiden Sie am besten die Zeichen " " (Leerzeichen), **+** und **-**: Diese Zeichen haben in Indizes eine besondere Bedeutung, daher können Tags, die sie enthalten, nicht als Indizes verwendet werden. Mit den Zeichen eines Textes können beliebig viele Tags verknüpft sein. Jedes Tag kann sich auf ein einzelnes Zeichen, auf einen Bereich von Zeichen oder auf mehrere Bereiche von Zeichen beziehen. Ein einzelnes Zeichen kann mit beliebig vielen Tags verknüpft sein.

Unter den Tags ist eine Prioritätsreihenfolge festgelegt, die bei der Umsetzung einiger der unten beschriebenen tag-bezogenen Funktionen verwendet wird. Wenn ein Tag definiert wird (indem es Zeichen zugeordnet wird, seine Anzeigeoptionen gesetzt werden oder Befehle an es gebunden werden), erhält es eine höhere Priorität als jedes bestehende Tag. Die Prioritätsreihenfolge der Tags kann mit den Widget-Befehlen „*pathName* **tag raise**“ und „*pathName* **tag lower**“ neu festgelegt werden.

Tags erfüllen in Text-Widgets drei Zwecke. Erstens steuern sie, wie Informationen auf dem Bildschirm dargestellt werden. Standardmäßig werden Zeichen so dargestellt, wie es die Optionen **-background**, **-font** und **-foreground** des Text-Widgets bestimmen. Mit dem Widget-Befehl „*pathName* **tag configure**“ können jedoch einzelnen Tags Anzeigeoptionen zugeordnet werden. Ist ein Zeichen mit einem Tag versehen, überschreiben die dem Tag zugeordneten Anzeigeoptionen den Standard-Anzeigestil. Für Tags werden derzeit die folgenden Optionen unterstützt:

**-background** *color*
: *Color* legt die Hintergrundfarbe für Zeichen fest, die mit dem Tag verknüpft sind. Sie kann jede der Formen haben, die [Tk\_GetColor][GetColor] akzeptiert.

**-bgstipple** *bitmap*
: *Bitmap* legt eine Bitmap fest, die als Stippelmuster für den Hintergrund verwendet wird. Sie kann jede der Formen haben, die [Tk\_GetBitmap][GetBitmap] akzeptiert. Ist *bitmap* nicht angegeben oder als leere Zeichenkette angegeben, wird der Hintergrund vollflächig gefüllt.

**-borderwidth** *pixels*
: *Pixels* legt die Breite eines Rahmens fest, der um das Tag gezeichnet wird; dabei ist jede der Formen zulässig, die [Tk\_GetPixels][GetPixels] akzeptiert. Diese Option sollte zusammen mit der Option **-relief** verwendet werden, um den gewünschten Rahmen zu erhalten.

**-elide** *boolean*
: *Elide* legt fest, ob die Daten ausgeblendet werden sollen. Ausgeblendete Daten (Zeichen, Bilder, eingebettete Fenster usw.) werden nicht angezeigt und nehmen keinen Platz auf dem Bildschirm ein, verhalten sich aber ansonsten wie normale Daten.

**-fgstipple** *bitmap*
: *Bitmap* legt eine Bitmap fest, die als Stippelmuster beim Zeichnen von Text und anderen Vordergrundinformationen wie Unterstreichungen verwendet wird. Sie kann jede der Formen haben, die [Tk\_GetBitmap][GetBitmap] akzeptiert. Ist *bitmap* nicht angegeben oder als leere Zeichenkette angegeben, wird vollflächig gefüllt.

**-font** *fontName*
: *FontName* ist der Name einer Schriftart, die zum Zeichnen der Zeichen verwendet wird. Er kann jede der Formen haben, die [Tk\_GetFont][GetFont] akzeptiert.

**-foreground** *color*
: *Color* legt die Farbe fest, die beim Zeichnen von Text und anderen Vordergrundinformationen wie Unterstreichungen verwendet wird. Sie kann jede der Formen haben, die [Tk\_GetColor][GetColor] akzeptiert.

**-justify** *justify*
: Hat das erste nicht ausgeblendete Zeichen einer Anzeigezeile ein Tag, für das diese Option angegeben ist, bestimmt *justify*, wie die Zeile ausgerichtet wird. Der Wert muss **left**, **right** oder **center** sein. Wird eine Zeile umbrochen, bestimmt für jede Zeile der Anzeige das erste nicht ausgeblendete Zeichen dieser Anzeigezeile die Ausrichtung.

**-lmargin1** *pixels*
: Hat das erste nicht ausgeblendete Zeichen einer Textzeile ein Tag, für das diese Option angegeben ist, legt *pixels* fest, wie weit die Zeile vom linken Rand des Fensters eingerückt wird. *Pixels* kann jede der Standardformen für Bildschirmabstände haben. Wird eine Textzeile umbrochen, gilt diese Option nur für die erste Zeile der Anzeige; die Option **-lmargin2** steuert die Einrückung der folgenden Zeilen.

**-lmargin2** *pixels*
: Hat das erste nicht ausgeblendete Zeichen einer Anzeigezeile ein Tag, für das diese Option angegeben ist, und ist die Anzeigezeile nicht die erste ihrer Textzeile (d. h. die Textzeile wurde umbrochen), legt *pixels* fest, wie weit die Zeile vom linken Rand des Fensters eingerückt wird. *Pixels* kann jede der Standardformen für Bildschirmabstände haben. Diese Option wird nur verwendet, wenn der Umbruch aktiviert ist, und sie gilt nur für die zweite und alle weiteren Anzeigezeilen einer Textzeile.

**-lmargincolor** *color*
: *Color* legt die Hintergrundfarbe für Bereiche fest, die keine Zeichen enthalten, weil sie durch **-lmargin1** oder **-lmargin2** eingerückt sind. Sie kann jede der Formen haben, die [Tk\_GetColor][GetColor] akzeptiert. Ist *color* nicht angegeben oder als leere Zeichenkette angegeben, wird die Farbe verwendet, die die Tag-Option **-background** festlegt (oder, falls auch diese nicht angegeben ist, die Widget-Option **-background**).

**-offset** *pixels*
: *Pixels* legt einen Betrag in Pixeln fest, um den die Grundlinie des Textes senkrecht gegenüber der Grundlinie der gesamten Zeile verschoben werden soll. Zum Beispiel kann ein positiver Versatz für Hochstellungen und ein negativer Versatz für Tiefstellungen verwendet werden. *Pixels* kann jede der Standardformen für Bildschirmabstände haben.

**-overstrike** *boolean*
: Legt fest, ob durch die Mitte der Zeichen ein waagerechter Strich gezeichnet wird. *Boolean* kann jede der Formen haben, die [Tcl\_GetBoolean][GetInt] akzeptiert.

**-overstrikefg** *color*
: *Color* legt die Farbe fest, die beim Anzeigen der Durchstreichung verwendet wird. Sie kann jede der Formen haben, die [Tk\_GetColor][GetColor] akzeptiert. Ist *color* nicht angegeben oder als leere Zeichenkette angegeben, wird die Farbe verwendet, die die Tag-Option **-foreground** festlegt.

**-relief** *relief*
: *Relief* legt den Reliefstil fest, mit dem der Rahmen gezeichnet wird; dabei ist jede der Formen zulässig, die [Tk\_GetRelief][GetRelief] akzeptiert. Diese Option wird zusammen mit der Option **-borderwidth** verwendet, um das gewünschte Aussehen des Rahmens zu erreichen.

**-rmargin** *pixels*
: Hat das erste nicht ausgeblendete Zeichen einer Anzeigezeile ein Tag, für das diese Option angegeben ist, legt *pixels* fest, wie breit der Rand zwischen dem Ende der Zeile und dem rechten Rand des Fensters sein soll. *Pixels* kann jede der Standardformen für Bildschirmabstände haben. Diese Option wird nur verwendet, wenn der Umbruch aktiviert ist. Wird eine Textzeile umbrochen, bestimmt für jede Zeile der Anzeige das erste nicht ausgeblendete Zeichen dieser Anzeigezeile den rechten Rand.

**-rmargincolor** *color*
: *Color* legt die Hintergrundfarbe für Bereiche fest, die keine Zeichen enthalten, weil sie durch **-rmargin** eingerückt sind. Sie kann jede der Formen haben, die [Tk\_GetColor][GetColor] akzeptiert. Ist *color* nicht angegeben oder als leere Zeichenkette angegeben, wird die Farbe verwendet, die die Tag-Option **-background** festlegt (oder, falls auch diese nicht angegeben ist, die Widget-Option **-background**).

**-selectbackground** *color*
: *Color* legt die Hintergrundfarbe fest, die beim Anzeigen ausgewählter Elemente verwendet wird. Sie kann jede der Formen haben, die [Tk\_GetColor][GetColor] akzeptiert. Ist *color* nicht angegeben oder als leere Zeichenkette angegeben, wird die Farbe verwendet, die die Tag-Option **-background** festlegt.

**-selectforeground** *color*
: *Color* legt die Vordergrundfarbe fest, die beim Anzeigen ausgewählter Elemente verwendet wird. Sie kann jede der Formen haben, die [Tk\_GetColor][GetColor] akzeptiert. Ist *color* nicht angegeben oder als leere Zeichenkette angegeben, wird die Farbe verwendet, die die Tag-Option **-foreground** festlegt.

**-spacing1** *pixels*
: *Pixels* legt fest, wie viel zusätzlicher Abstand oberhalb jeder Textzeile gelassen werden soll; dabei ist jede der Standardformen für Bildschirmabstände zulässig. Wird eine Zeile umbrochen, gilt diese Option nur für die erste Zeile der Anzeige.

**-spacing2** *pixels*
: Für Zeilen, die umbrochen werden, legt diese Option fest, wie viel zusätzlicher Abstand zwischen den Anzeigezeilen einer einzelnen Textzeile gelassen werden soll. *Pixels* kann jede der Standardformen für Bildschirmabstände haben.

**-spacing3** *pixels*
: *Pixels* legt fest, wie viel zusätzlicher Abstand unterhalb jeder Textzeile gelassen werden soll; dabei ist jede der Standardformen für Bildschirmabstände zulässig. Wird eine Zeile umbrochen, gilt diese Option nur für die letzte Zeile der Anzeige.

**-tabs** *tabList*
: *TabList* legt eine Menge von Tabstopps in derselben Form fest wie die Option **-tabs** des Text-Widgets. Diese Option gilt für eine Anzeigezeile nur, wenn sie für das erste nicht ausgeblendete Zeichen dieser Anzeigezeile gilt. Wird diese Option als leere Zeichenkette angegeben, wird sie aufgehoben und bleibt für das Tag unbestimmt (die Vorgabe). Wird die Option als nicht leere Zeichenkette angegeben, die eine leere Liste ist, etwa **-tags { }**, fordert sie Standard-Tabulatoren im Abstand von 8 Zeichen an, wie bei der Widget-Option **-tags** beschrieben.

**-tabstyle** *style*
: *Style* legt fest, ob für das Text-Widget der Tabulatorstil *tabular* oder *wordprocessor* verwendet wird. Diese Option gilt für eine Anzeigezeile nur, wenn sie für das erste nicht ausgeblendete Zeichen dieser Anzeigezeile gilt. Wird diese Option als leere Zeichenkette angegeben, wird sie aufgehoben und bleibt für das Tag unbestimmt (die Vorgabe).

**-underline** *boolean*
: *Boolean* legt fest, ob unter den Zeichen eine Unterstreichung gezeichnet wird. Der Wert kann jede der Formen haben, die [Tcl\_GetBoolean][GetInt] akzeptiert.

**-underlinefg** *color*
: *Color* legt die Farbe fest, die beim Anzeigen der Unterstreichung verwendet wird. Sie kann jede der Formen haben, die [Tk\_GetColor][GetColor] akzeptiert. Ist *color* nicht angegeben oder als leere Zeichenkette angegeben, wird die Farbe verwendet, die die Tag-Option **-foreground** festlegt.

**-wrap** *mode*
: *Mode* legt fest, wie mit Zeilen umgegangen wird, die breiter als das Fenster des Textes sind. Diese Option gilt für eine Anzeigezeile nur, wenn sie für das erste nicht ausgeblendete Zeichen dieser Anzeigezeile gilt. Sie hat dieselben zulässigen Werte wie die Option **-wrap** des Text-Widgets: **none**, **char** oder **word**. Ist diese Tag-Option angegeben, überschreibt sie die Option **-wrap** des Text-Widgets.


Ist ein Zeichen mit mehreren Tags verknüpft und widersprechen sich deren Anzeigeoptionen, werden die Optionen des Tags mit der höchsten Priorität verwendet. Ist eine bestimmte Anzeigeoption für ein bestimmtes Tag nicht angegeben oder als leere Zeichenkette angegeben, wird diese Option nie verwendet; stattdessen wird die Option des Tags mit der nächsthöheren Priorität verwendet. Legt kein Tag eine bestimmte Anzeigeoption fest, wird der Standardstil des Widgets verwendet.

Der zweite Zweck von Tags sind Ereignisbindungen. Sie können einem Tag Bindungen auf ganz ähnliche Weise zuordnen wie einer Widget-Klasse: Immer wenn bestimmte X-Ereignisse bei Zeichen mit dem angegebenen Tag auftreten, wird ein angegebener Tcl-Befehl ausgeführt. Mit Tag-Bindungen lassen sich Bereichen von Zeichen Verhaltensweisen zuweisen; unter anderem können so hypertextähnliche Funktionen umgesetzt werden. Einzelheiten finden Sie unten in der Beschreibung des Widget-Befehls „*pathName* **tag bind**“. Tag-Bindungen werden von allen Peer-Widgets gemeinsam genutzt (einschließlich aller Bindungen für das besondere Tag **sel**).

Der dritte Verwendungszweck von Tags ist die Verwaltung der Auswahl. Siehe [Die Auswahl] unten. Mit Ausnahme des besonderen Tags **sel** werden alle Tags von Peer-Text-Widgets gemeinsam genutzt und können von jedem dieser Widgets gleichberechtigt bearbeitet werden. Das Tag **sel** existiert in jedem Peer-Text-Widget getrennt und unabhängig (alle Tag-Bindungen an **sel** werden jedoch gemeinsam genutzt).

# Marken

Die zweite Form der Annotation in Text-Widgets ist eine Marke. Marken dienen dazu, sich bestimmte Stellen in einem Text zu merken. Sie ähneln Tags insofern, als sie Namen haben und sich auf Stellen in der Datei beziehen, doch eine Marke ist nicht mit bestimmten Zeichen verknüpft. Stattdessen ist eine Marke mit der Lücke zwischen zwei Zeichen verknüpft. Mit einer Marke kann zu jedem Zeitpunkt nur eine einzige Position verknüpft sein. Werden die Zeichen um eine Marke herum gelöscht, bleibt die Marke dennoch bestehen; sie hat dann lediglich neue Nachbarzeichen. Werden dagegen die Zeichen gelöscht, die ein Tag enthalten, ist das Tag nicht mehr mit Zeichen in der Datei verknüpft. Marken können mit dem Widget-Befehl „*pathName* **mark**“ bearbeitet werden, und ihre aktuelle Position lässt sich ermitteln, indem der Markenname in Widget-Befehlen als Index verwendet wird.

Jede Marke hat außerdem eine „Schwerkraft“, die entweder **left** oder **right** ist. Die Schwerkraft einer Marke legt fest, was mit der Marke geschieht, wenn an der Stelle der Marke Text eingefügt wird. Hat eine Marke linke Schwerkraft, wird sie so behandelt, als wäre sie an das Zeichen links von ihr angehängt; die Marke bleibt also links von jedem Text, der an der Markenposition eingefügt wird. Hat die Marke rechte Schwerkraft, erscheint neuer Text, der an der Markenposition eingefügt wird, links von der Marke (sodass die Marke ganz rechts bleibt). Standardmäßig hat eine Marke die Schwerkraft **right**.

Der Namensraum für Marken ist ein anderer als der für Tags: Derselbe Name kann sowohl für eine Marke als auch für ein Tag verwendet werden, bezeichnet aber jeweils etwas anderes.

Zwei Marken haben eine besondere Bedeutung. Erstens ist die Marke **insert** mit dem Einfügecursor verknüpft, wie unten unter [Der Einfügecursor] beschrieben. Zweitens ist die Marke **current** mit dem Zeichen verknüpft, das dem Mauszeiger am nächsten liegt; sie wird automatisch angepasst, um der Mausposition und allen Änderungen am Text im Widget zu folgen (mit einer Ausnahme: **current** wird bei Mausbewegungen nicht aktualisiert, solange eine Maustaste gedrückt ist; die Aktualisierung wird aufgeschoben, bis alle Maustasten losgelassen sind). Keine dieser beiden besonderen Marken darf gelöscht werden. Mit Ausnahme dieser beiden besonderen Marken werden alle Marken von Peer-Text-Widgets gemeinsam genutzt und können von jedem Peer gleichberechtigt bearbeitet werden.

# Eingebettete Fenster

Die dritte Form der Annotation in Text-Widgets ist ein eingebettetes Fenster. Jede Annotation in Form eines eingebetteten Fensters bewirkt, dass an einer bestimmten Stelle im Text ein Fenster angezeigt wird. Ein Text-Widget kann beliebig viele eingebettete Fenster enthalten, und jedes Widget kann als eingebettetes Fenster verwendet werden (vorbehaltlich der üblichen Regeln der Geometrieverwaltung, nach denen das Textfenster das Elternfenster des eingebetteten Fensters oder ein Nachkomme von dessen Elternfenster sein muss).

Die Position des eingebetteten Fensters auf dem Bildschirm wird aktualisiert, wenn der Text geändert oder gescrollt wird, und das Fenster wird auf dem Bildschirm abgebildet (map) bzw. von ihm entfernt (unmap), wenn es in den sichtbaren Bereich des Text-Widgets hinein- oder aus ihm herausrückt. Jedes eingebettete Fenster belegt im Indexraum des Text-Widgets eine Einheit, und es kann entweder über den Namen seines eingebetteten Fensters oder über seine Position im Indexraum des Widgets angesprochen werden. Wird der Textbereich gelöscht, der das eingebettete Fenster enthält, wird das Fenster zerstört. Ebenso wird das Fenster zerstört, wenn das Text-Widget als Ganzes gelöscht wird.

Wird ein eingebettetes Fenster unmittelbar ausgeblendet, nachdem seine Erstellung mit *pathName* **window create** *index* **-create** eingeplant wurde, wird es tatsächlich nicht erstellt. Wird ein ausgeblendetes eingebettetes Fenster, dessen Erstellung mit *pathName* **window create** *index* **-create** eingeplant ist, wieder eingeblendet, wird automatisch das zugehörige Erstellungsskript ausgelöst. Nachdem ein ausgeblendetes eingebettetes Fenster zerstört wurde, wird es nicht automatisch neu erstellt.

Wenn einem Text-Widget mit dem Widget-Befehl *pathName* **window create** ein eingebettetes Fenster hinzugefügt wird, können ihm mehrere Konfigurationsoptionen zugeordnet werden. Diese Optionen lassen sich später mit dem Widget-Befehl *pathName* **window configure** ändern. Derzeit werden die folgenden Optionen unterstützt:

**-align** *where*
: Ist das Fenster nicht so hoch wie die Zeile, in der es angezeigt wird, bestimmt diese Option, wo in der Zeile das Fenster angezeigt wird. *Where* muss einen der Werte **top** (Oberkante des Fensters an der Oberkante der Zeile ausrichten), **center** (Fenster innerhalb des Zeilenbereichs zentrieren), **bottom** (Unterkante des Fensters an der Unterkante des Zeilenbereichs ausrichten) oder **baseline** (Unterkante des Fensters an der Grundlinie der Zeile ausrichten) haben.

**-create** *script*
: Legt ein Tcl-Skript fest, das ausgewertet werden kann, um das Fenster für die Annotation zu erstellen. Ist für die Annotation keine Option **-window** angegeben, wird dieses Skript ausgewertet, wenn die Annotation gerade auf dem Bildschirm angezeigt werden soll. *Script* muss ein Fenster für die Annotation erstellen und den Namen dieses Fensters als Ergebnis zurückgeben. Vor der Auswertung werden in *script* zwei Ersetzungen vorgenommen: *%W* wird durch den Namen des übergeordneten Text-Widgets ersetzt, und *%%* wird durch ein einzelnes *%* ersetzt. Sollte das Fenster der Annotation jemals gelöscht werden, wird *script* beim nächsten Anzeigen der Annotation erneut ausgewertet.

**-padx** *pixels*
: *Pixels* legt fest, wie viel zusätzlicher Platz auf jeder Seite des eingebetteten Fensters gelassen werden soll. Der Wert kann jede der üblichen Formen für Bildschirmabstände haben.

**-pady** *pixels*
: *Pixels* legt fest, wie viel zusätzlicher Platz oberhalb und unterhalb des eingebetteten Fensters gelassen werden soll. Der Wert kann jede der üblichen Formen für Bildschirmabstände haben.

**-stretch** *boolean*
: Ist die angeforderte Höhe des eingebetteten Fensters kleiner als die Höhe der Zeile, in der es angezeigt wird, kann mit dieser Option festgelegt werden, ob das Fenster senkrecht gestreckt werden soll, um seine Zeile auszufüllen. Ist zusätzlich die Option **-pady** angegeben, bleibt der angeforderte Innenabstand auch dann erhalten, wenn das Fenster gestreckt wird.

**-window** *pathName*
: Legt den Namen eines Fensters fest, das in der Annotation angezeigt werden soll. Beachten Sie: Wenn ein *pathName* gesetzt wurde, löscht ein späteres Konfigurieren des Fensters auf die leere Zeichenkette nicht das Widget, das zum alten *pathName* gehört. Stattdessen wird nur die Verknüpfung zwischen dem alten *pathName* und dem Text-Widget aufgehoben. Werden mehrere Peer-Widgets verwendet und sollen in jedem Peer eingebettete Fenster erscheinen, ist es meist einfacher, die Option **-create** zu verwenden.


# Eingebettete Bilder

Die letzte Form der Annotation in Text-Widgets ist ein eingebettetes Bild. Jede Annotation in Form eines eingebetteten Bildes bewirkt, dass an einer bestimmten Stelle im Text ein Bild angezeigt wird. Ein Text-Widget kann beliebig viele eingebettete Bilder enthalten, und ein bestimmtes Bild kann an mehreren Stellen desselben Text-Widgets eingebettet sein.

Die Position des eingebetteten Bildes auf dem Bildschirm wird aktualisiert, wenn der Text geändert oder gescrollt wird. Jedes eingebettete Bild belegt im Indexraum des Text-Widgets eine Einheit, und es kann entweder über seine Position im Indexraum des Widgets angesprochen werden oder über den Namen, den es erhält, wenn das Bild mit *pathName* **image create** in das Text-Widget eingefügt wird. Wird der Textbereich gelöscht, der das eingebettete Bild enthält, wird diese Kopie des Bildes vom Bildschirm entfernt.

Wird ein eingebettetes Bild unmittelbar ausgeblendet, nachdem seine Erstellung mit *pathName* **image create** *index* **-create** eingeplant wurde, wird es tatsächlich nicht erstellt. Wird ein ausgeblendetes eingebettetes Bild, dessen Erstellung mit *pathName* **image create** *index* **-create** eingeplant ist, wieder eingeblendet, wird automatisch das zugehörige Erstellungsskript ausgelöst. Nachdem ein ausgeblendetes eingebettetes Bild zerstört wurde, wird es nicht automatisch neu erstellt.

Wenn einem Text-Widget mit dem Widget-Befehl *pathName* **image create** ein eingebettetes Bild hinzugefügt wird, wird ein Name zurückgegeben, der für diese Instanz des Bildes eindeutig ist. Über diesen Namen kann diese Bildinstanz anschließend angesprochen werden. Als Name wird der Wert der Option **-name** (unten beschrieben) verwendet. Ist die Option **-name** nicht angegeben, wird stattdessen der Name aus **-image** verwendet. Ist der *imageName* im Text-Widget bereits vergeben, wird **#**_nn_ an das Ende des *imageName* angehängt, wobei *nn* eine beliebige Ganzzahl ist. So ist sichergestellt, dass der *imageName* eindeutig ist. Sobald dieser Name der Bildinstanz zugewiesen ist, ändert er sich nicht mehr, auch wenn die Werte von **-image** oder **-name** mit *pathName* **image configure** geändert werden.

Wenn einem Text-Widget mit dem Widget-Befehl *pathName* **image create** ein eingebettetes Bild hinzugefügt wird, können ihm mehrere Konfigurationsoptionen zugeordnet werden. Diese Optionen lassen sich später mit dem Widget-Befehl *pathName* **image configure** ändern. Derzeit werden die folgenden Optionen unterstützt:

**-align** *where*
: Ist das Bild nicht so hoch wie die Zeile, in der es angezeigt wird, bestimmt diese Option, wo in der Zeile das Bild angezeigt wird. *Where* muss einen der Werte **top** (Oberkante des Bildes an der Oberkante der Zeile ausrichten), **center** (Bild innerhalb des Zeilenbereichs zentrieren), **bottom** (Unterkante des Bildes an der Unterkante des Zeilenbereichs ausrichten) oder **baseline** (Unterkante des Bildes an der Grundlinie der Zeile ausrichten) haben.

**-image** *image*
: Legt den Namen des Tk-Bildes fest, das in der Annotation angezeigt werden soll. Ist *image* kein gültiges Tk-Bild, wird ein Fehler zurückgegeben.

**-name** *ImageName*
: Legt den Namen fest, über den diese Bildinstanz im Text-Widget angesprochen werden kann. Ist *ImageName* nicht angegeben, wird stattdessen der Name des Tk-Bildes verwendet. Ist der *imageName* bereits vergeben, wird wie oben beschrieben *#nn* an das Ende des Namens angehängt.

**-padx** *pixels*
: *Pixels* legt fest, wie viel zusätzlicher Platz auf jeder Seite des eingebetteten Bildes gelassen werden soll. Der Wert kann jede der üblichen Formen für Bildschirmabstände haben.

**-pady** *pixels*
: *Pixels* legt fest, wie viel zusätzlicher Platz oberhalb und unterhalb des eingebetteten Bildes gelassen werden soll. Der Wert kann jede der üblichen Formen für Bildschirmabstände haben.


# Die Auswahl

Die Unterstützung der Auswahl ist über Tags umgesetzt. Ist die Option **-exportselection** des Text-Widgets true, wird das Tag **sel** mit der Auswahl verknüpft:

1. Immer wenn Zeichen mit **sel** versehen werden, beansprucht das Text-Widget den Besitz der Auswahl.

2. Versuche, die Auswahl abzurufen, werden vom Text-Widget bedient; es gibt alle Zeichen mit dem Tag **sel** zurück.

3. Wird die Auswahl von einer anderen Anwendung oder von einem anderen Fenster innerhalb dieser Anwendung übernommen, wird das Tag **sel** von allen Zeichen im Text entfernt.

4. Immer wenn sich der Bereich des Tags **sel** ändert, wird ein virtuelles Ereignis **<<Selection>>** erzeugt. Es kann auch erzeugt werden, wenn die Auswahl betroffen ist, sich aber nicht tatsächlich ändert. Außerdem können mehrere Änderungen der Auswahl erfolgen, bevor Ereignisse verarbeitet werden können; das führt dann zu mehreren Ereignissen mit derselben sichtbaren Auswahl.


Das Tag **sel** wird automatisch definiert, wenn ein Text-Widget erstellt wird, und es darf nicht mit dem Widget-Befehl „*pathName* **tag delete**“ gelöscht werden. Ferner sind die Optionen **-selectbackground**, **-selectborderwidth** und **-selectforeground** des Text-Widgets an die Optionen **-background**, **-borderwidth** und **-foreground** des Tags **sel** gekoppelt: Änderungen auf einer der beiden Seiten spiegeln sich automatisch auf der anderen wider. Außerdem wird die Option **-inactiveselectbackground** des Text-Widgets anstelle von **-selectbackground** verwendet, wenn das Text-Widget nicht den Fokus hat. Dadurch lässt sich die Darstellung des Tags **sel** für Vordergrund- und Hintergrundfenster programmgesteuert festlegen, oder **sel** kann für Hintergrundfenster gar nicht angezeigt werden (wenn **-inactiveselectbackground** leer ist). Jedes Peer-Text-Widget hat ein eigenes Tag **sel**, das getrennt konfiguriert und gesetzt werden kann.

# Der Einfügecursor

Die Marke mit dem Namen **insert** hat in Text-Widgets eine besondere Bedeutung. Sie wird automatisch definiert, wenn ein Text-Widget erstellt wird, und sie darf nicht mit dem Widget-Befehl „*pathName* **mark unset**“ entfernt werden. Die Marke **insert** stellt die Position des Einfügecursors dar, und der Einfügecursor wird automatisch an dieser Stelle gezeichnet, sobald das Text-Widget den Eingabefokus hat.

# Die Modified-Flagge

Das Text-Widget kann mit Hilfe der modified-Flagge Änderungen am Inhalt des Widgets verfolgen. Das Einfügen oder Löschen von Text setzt diese Flagge. Die Flagge kann auch programmgesteuert abgefragt, gesetzt und gelöscht werden. Immer wenn die Flagge ihren Zustand ändert, wird ein virtuelles Ereignis **<<Modified>>** erzeugt. Weitere Einzelheiten finden Sie beim Widget-Befehl *pathName* **edit modified**.

# Der Rückgängig-Mechanismus

Das Text-Widget hat einen unbegrenzten Rückgängig- und Wiederholen-Mechanismus (wenn die Widget-Option **-undo** true ist), der jede Einfüge- und Löschaktion auf einem Stapel aufzeichnet.

Zwischen Bearbeitungsaktionen werden Grenzen eingefügt, die „Trennzeichen“ (separators) heißen. Diese Trennzeichen dienen dazu, Einfüge-, Lösch- und Ersetzungsaktionen zu einer zusammengesetzten Bearbeitungsaktion zu gruppieren. Beim Rückgängigmachen einer Änderung wird alles zwischen zwei Trennzeichen rückgängig gemacht. Die rückgängig gemachten Änderungen werden dann auf den Wiederholen-Stapel verschoben, sodass eine rückgängig gemachte Bearbeitung erneut ausgeführt werden kann. Der Wiederholen-Stapel wird geleert, sobald neue Bearbeitungsaktionen auf dem Rückgängig-Stapel aufgezeichnet werden. Der Rückgängig- und der Wiederholen-Stapel können geleert werden, um ihre Tiefe unter Kontrolle zu halten.

Trennzeichen werden automatisch eingefügt, wenn die Widget-Option **-autoseparators** true ist. Sie können Trennzeichen auch programmgesteuert einfügen. Liegt oben auf dem Rückgängig-Stapel bereits ein Trennzeichen, wird kein weiteres eingefügt. Das bedeutet, dass zwei Trennzeichen auf dem Rückgängig-Stapel stets durch mindestens eine Einfüge- oder Löschaktion voneinander getrennt sind.

Das virtuelle Ereignis **<<UndoStack>>** wird jedes Mal erzeugt, wenn der Rückgängig-Stapel oder der Wiederholen-Stapel leer wird oder nicht mehr leer ist.

Der Rückgängig-Mechanismus ist außerdem mit der modified-Flagge gekoppelt. Das bedeutet, dass das Rückgängigmachen oder Wiederholen von Änderungen ein geändertes Text-Widget in den unveränderten Zustand zurückversetzen kann und umgekehrt. Die modified-Flagge wird automatisch auf den passenden Zustand gesetzt. Diese automatische Kopplung funktioniert nicht, wenn die modified-Flagge vom Benutzer gesetzt wurde, und zwar so lange, bis die Flagge wieder zurückgesetzt wird.

Den Widget-Befehl *pathName* **edit**, der den Rückgängig-Mechanismus steuert, finden Sie weiter unten.

# Peer-Widgets

Das Text-Widget hat einen eigenen Speicher für alle seine Daten, also für den Textinhalt jeder Zeile, für Marken, Tags, Bilder und Fenster sowie für den Rückgängig-Stapel.

Auf diesen Datenspeicher kann zwar nicht direkt zugegriffen werden (d. h. nicht ohne ein Text-Widget als Vermittler), doch es können mehrere Text-Widgets erstellt werden, die jeweils unterschiedliche Ansichten derselben zugrunde liegenden Daten darstellen. Solche Text-Widgets werden als Peer-Text-Widgets bezeichnet.

Wenn in einem dieser Widgets Text hinzugefügt, gelöscht, bearbeitet und eingefärbt wird und wenn Bilder, Marken und Tags angepasst werden, spiegeln sich alle diese Änderungen in allen Peers wider.

Alle Daten und Auszeichnungen werden gemeinsam genutzt, abgesehen von einigen kleinen Details. Erstens kann das Tag **sel** für jeden Peer unterschiedlich gesetzt und (in seinem Anzeigestil) konfiguriert werden. Zweitens hat jeder Peer eigene Positionen der Marken **insert** und **current** (alle anderen Marken werden jedoch gemeinsam genutzt). Drittens können eingebettete Fenster, die ja beliebige andere Widgets sind, nicht zwischen Peers geteilt werden. Das bedeutet, dass die Option **-window** eingebetteter Fenster für jeden Peer unabhängig gesetzt wird (es empfiehlt sich, die Möglichkeiten des **-create**-Skripts zu nutzen, damit jeder Peer seine eigenen eingebetteten Fenster nach Bedarf erstellen kann). Viertens können alle Konfigurationsoptionen jedes Peers (z. B. **-font** usw.) unabhängig gesetzt werden, mit Ausnahme von **-undo**, **-maxundo** und **-autoseparators** (d. h. alles, was den Rückgängig-, Wiederholen- und modified-Zustand betrifft, wird gemeinsam genutzt).

Schließlich muss ein einzelner Peer nicht alle Zeilen des zugrunde liegenden Datenspeichers enthalten. Beim Erstellen eines Peers kann ein zusammenhängender Zeilenbereich angegeben werden (z. B. nur die Zeilen 52 bis 125). Dadurch kann ein Peer nur einen kleinen Teil des gesamten Textes enthalten. Der Zeilenbereich wächst und schrumpft, wenn Text eingefügt oder gelöscht wird. Der Peer zeigt immer nur vollständige Textzeilen an (es ist nicht möglich, nur einen Teil einer Zeile gemeinsam zu nutzen). Schrumpft der Inhalt des Peers auf nichts (d. h. alle vollständigen Zeilen im Peer-Widget wurden von einem anderen Widget aus gelöscht), können keine neuen Zeilen mehr eingefügt werden. Der Peer wird dann einfach zu einer leeren Hülle, deren Hintergrund konfiguriert werden kann, die aber nie Inhalt anzeigt (ohne manuelles Neukonfigurieren der Start- und Endzeile). Beachten Sie, dass auch ein Peer, der nicht den gesamten zugrunde liegenden Datenspeicher enthält, Indizes von „1.0“ bis „end“ hat. Diese Indizes geben lediglich eine Teilmenge der gesamten Daten wieder, und Daten außerhalb des enthaltenen Bereichs sind für den Peer nicht zugänglich. Das bedeutet, dass der Befehl *peerName* **index end** in verschiedenen Peers ganz unterschiedliche Werte zurückgeben kann. Ebenso geben Befehle wie *peerName* **tag ranges** keine Indexbereiche außerhalb dessen zurück, was für den Peer von Bedeutung ist. Mit den Konfigurationsoptionen **-startline** und **-endline** lässt sich steuern, wie viel der zugrunde liegenden Daten ein bestimmtes Text-Widget enthält.

Beachten Sie, dass Peers wirklich gleichrangig sind. Das Löschen des „ursprünglichen“ Text-Widgets führt nicht dazu, dass andere Peers gelöscht oder anderweitig beeinflusst werden.

Den Widget-Befehl *pathName* **peer**, der das Erstellen von Peer-Widgets steuert, finden Sie weiter unten.

# Asynchrone Aktualisierung der Zeilenhöhen

Um eine reaktionsschnelle Bedienung zu gewährleisten, berechnet das Text-Widget die Zeilenmetriken (Zeilenhöhen in Pixeln) asynchron. Deshalb können einige Befehle des Text-Widgets falsche Ergebnisse zurückgeben, wenn die asynchronen Berechnungen zum Zeitpunkt des Aufrufs noch nicht abgeschlossen sind. Das betrifft *pathName* **count -ypixels** und *pathName* **yview**.

Ebenfalls aus Leistungsgründen wäre es nicht sinnvoll, diese Befehle bei jedem Aufruf stets auf das Ende der Aktualisierungsberechnung warten zu lassen. In den meisten Anwendungsfällen dieser Befehle spielt ein mehr oder weniger ungenaues Ergebnis im Vergleich zur Ausführungsgeschwindigkeit keine wirkliche Rolle.

Wird ein genaues Ergebnis benötigt (und wird das Text-Widget von einem Geometriemanager verwaltet), können Sie auf *pathName* **sync** und *pathName* **pendingsync** zurückgreifen, um die Synchronisierung der Ansicht von Text-Widgets zu steuern.

Das virtuelle Ereignis **<<WidgetViewSync>>** wird ausgelöst, wenn die Zeilenhöhen des Text-Widgets veralten (durch einen Bearbeitungsbefehl oder eine Konfigurationsänderung), und erneut, wenn die internen Daten des Text-Widgets wieder mit der Ansicht des Widgets synchron sind. Das Detail-Feld (Ersetzung %d) ist entweder true (wenn das Widget synchron ist) oder false (wenn es das nicht ist).

*pathName* **sync**, *pathName* **pendingsync** und **<<WidgetViewSync>>** gelten für jedes Text-Widget unabhängig von seinen Peers.

Anwendungsbeispiele:

```
## Example 1:
# immediately complete line metrics at any cost (GUI unresponsive)
$w sync
$w yview moveto $fraction

## Example 2:
# synchronously wait for up-to-date line metrics (GUI responsive)
# before executing the scheduled command, but don't block execution flow
$w sync -command [list $w yview moveto $fraction]

## Example 3:
# init
set yud($w) 0
proc updateaction w {
set ::yud($w) 1
# any other update action here...
}
# runtime, synchronously wait for up-to-date line metrics (GUI responsive)
$w sync -command [list updateaction $w]
vwait yud($w)
$w yview moveto $fraction

## Example 4:
# init
set todo($w) {}
proc updateaction w {
foreach cmd $::todo($w) {uplevel #0 $cmd}
set todo($w) {}
}
# runtime
lappend todo($w) [list $w yview moveto $fraction]
$w sync -command [list updateaction $w]

## Example 5:
# init
set todo($w) {}
bind $w <<WidgetViewSync>> {
if {%d} {
foreach cmd $todo(%W) {eval $cmd}
set todo(%W) {}
}
}
# runtime
if {![$w pendingsync]} {
$w yview moveto $fraction
} else {
lappend todo($w) [list $w yview moveto $fraction]
}
```

# Widget-Befehl

Der Befehl **text** erstellt einen neuen Tcl-Befehl, dessen Name mit dem Pfadnamen des Textfensters übereinstimmt. Mit diesem Befehl können verschiedene Operationen auf dem Widget ausgeführt werden. Er hat die folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

*PathName* ist der Name des Befehls; er stimmt mit dem Pfadnamen des Text-Widgets überein. *Option* und die *arg*-Argumente legen das genaue Verhalten des Befehls fest. Für Text-Widgets sind die folgenden Befehle möglich:

*pathName* **bbox** *index*
: Gibt eine Liste mit vier Elementen zurück, die den Bildschirmbereich des durch *index* angegebenen Zeichens beschreiben. Die ersten beiden Elemente der Liste geben die x- und y-Koordinate der oberen linken Ecke des Bereichs an, den das Zeichen belegt; die letzten beiden Elemente geben Breite und Höhe des Bereichs an. Ist das Zeichen auf dem Bildschirm nur teilweise sichtbar, gibt der Rückgabewert nur den sichtbaren Teil wieder. Ist das Zeichen auf dem Bildschirm nicht sichtbar, ist der Rückgabewert eine leere Liste.

*pathName* **cget** *option*
: Gibt den aktuellen Wert der durch *option* angegebenen Konfigurationsoption zurück. *Option* kann jeden der Werte haben, die der Befehl **text** akzeptiert.

*pathName* **compare** *index1 op index2*
: Vergleicht die durch *index1* und *index2* angegebenen Indizes gemäß dem durch *op* angegebenen Vergleichsoperator und gibt 1 zurück, wenn die Beziehung erfüllt ist, und 0, wenn nicht. *Op* muss einer der Operatoren <, <=, ==, >=, > oder != sein. Ist *op* gleich ==, wird 1 zurückgegeben, wenn sich beide Indizes auf dasselbe Zeichen beziehen; ist *op* gleich <, wird 1 zurückgegeben, wenn sich *index1* auf ein Zeichen bezieht, das im Text vor *index2* steht, und so weiter.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Ist keine *option* angegeben, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (zum Format dieser Liste siehe [Tk\_ConfigureInfo][ConfigWidg]). Ist *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine genannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der ohne Angabe von *option* zurückgegeben wird). Sind ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Widget-Optionen auf die angegebenen Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden der Werte haben, die der Befehl **text** akzeptiert.

*pathName* **count** ?*options*? *index1 index2*
: Zählt die Anzahl der relevanten Einheiten zwischen den beiden Indizes. Liegt *index1* hinter *index2*, ist das Ergebnis eine negative Zahl (das gilt für jede der möglichen Optionen). Welche Einheiten tatsächlich gezählt werden, hängt von den angegebenen Optionen ab. Das Ergebnis ist eine Liste von Ganzzahlen, eine für das Ergebnis jeder angegebenen Zähloption. Gültige Zähloptionen sind **-chars**, **-displaychars**, **-displayindices**, **-displaylines**, **-indices**, **-lines**, **-xpixels** und **-ypixels**. Ist keine Option angegeben, gilt der Vorgabewert **-indices**. Zusätzlich gibt es die Option **-update**, die als Modifikator wirkt. Ist sie angegeben (und wird das Text-Widget von einem Geometriemanager verwaltet), sorgen alle nachfolgenden Optionen dafür, dass möglicherweise veraltete Informationen neu berechnet werden. Das wirkt sich derzeit nur auf die Zählung mit **-ypixels** aus (die ohne **-update** für jede Zeile den aktuell zwischengespeicherten Wert des Text-Widgets verwendet). Die Option **-update** ist durch *pathName* **sync**, *pathName* **pendingsync** und **<<WidgetViewSync>>** obsolet geworden.  Die Zähloptionen werden wie folgt interpretiert:

    **-chars**
    : zählt alle Zeichen, ob ausgeblendet oder nicht. Eingebettete Fenster oder Bilder werden nicht gezählt.

    **-displaychars**
    : zählt alle nicht ausgeblendeten Zeichen.

    **-displayindices**
    : zählt alle nicht ausgeblendeten Zeichen, Fenster und Bilder.

    **-displaylines**
    : zählt alle Anzeigezeilen (d. h. jeder Umbruch einer Zeile zählt einmal) von der Zeile des ersten Index bis ausschließlich zur Anzeigezeile des zweiten Index. Liegen also beide auf derselben Anzeigezeile, wird null zurückgegeben. Anzeigezeilen sind per Definition sichtbar; daher werden nur Teile tatsächlich sichtbarer Zeilen gezählt.

    **-indices**
    : zählt alle Zeichen und eingebetteten Fenster oder Bilder (d. h. alles, was im Indexraum des Text-Widgets zählt), ob ausgeblendet oder nicht.

    **-lines**
    : zählt alle logischen Zeilen (unabhängig vom Umbruch) von der Zeile des ersten Index bis ausschließlich zur Zeile des zweiten Index. Liegen also beide auf derselben Zeile, wird null zurückgegeben. Logische Zeilen werden gezählt, ob sie gerade sichtbar (nicht ausgeblendet) sind oder nicht.

    **-xpixels**
    : zählt die Anzahl der horizontalen Pixel vom ersten Pixel des ersten Index bis ausschließlich zum ersten Pixel des zweiten Index. Um die gesamte gewünschte Breite des Text-Widgets zu ermitteln (sofern der Zeilenumbruch nicht aktiviert ist), suchen Sie zuerst die längste Zeile und verwenden dann „.text count -xpixels "${line}.0" "${line}.0 lineend"“.

    **-ypixels**
    : zählt die Anzahl der vertikalen Pixel vom ersten Pixel des ersten Index bis ausschließlich zum ersten Pixel des zweiten Index. Liegen beide Indizes auf derselben Anzeigezeile, wird null zurückgegeben. Um die Gesamtzahl der vertikalen Pixel im Text-Widget zu ermitteln, verwenden Sie „.text count -ypixels 1.0 end“; damit dieser Wert aktuell ist, verwenden Sie „.text count -update -ypixels 1.0 end“.


    Der Befehl gibt eine positive oder negative Ganzzahl zurück, die der Anzahl der zwischen den beiden Indizes gezählten Einheiten entspricht. Für jede angegebene Zähloption wird eine solche Ganzzahl zurückgegeben; wurde mehr als eine Option angegeben, wird also eine Liste zurückgegeben. So ist zum Beispiel „.text count -xpixels -ypixels 1.3 4.5“ völlig gültig und gibt eine Liste mit zwei Elementen zurück.

*pathName* **debug** ?*boolean*?
: Ist *boolean* angegeben, muss es einer der Wahr- oder Falsch-Werte sein, die [Tcl\_GetBoolean][GetInt] akzeptiert. Ist der Wert wahr, werden interne Konsistenzprüfungen im B-Baum-Code der Text-Widgets eingeschaltet. Hat *boolean* einen falschen Wert, werden die Debugging-Prüfungen ausgeschaltet. In beiden Fällen gibt der Befehl eine leere Zeichenkette zurück. Ist *boolean* nicht angegeben, gibt der Befehl **on** oder **off** zurück, je nachdem, ob das Debugging eingeschaltet ist. Es gibt einen einzigen Debugging-Schalter, den sich alle Text-Widgets teilen: Wird das Debugging in einem Widget ein- oder ausgeschaltet, gilt das für alle Widgets. Bei Widgets mit großen Textmengen können die Konsistenzprüfungen eine spürbare Verlangsamung verursachen.

    Ist das Debugging eingeschaltet, setzen die Zeichenroutinen des Text-Widgets die globalen Variablen **tk\_textRedraw** und **tk\_textRelayout** auf die Listen der neu gezeichneten Indizes. Die Werte dieser Variablen werden von der Testsuite von Tk geprüft.

*pathName* **delete** *index1* ?*index2 ...*?
: Löscht einen Bereich von Zeichen aus dem Text. Sind sowohl *index1* als auch *index2* angegeben, werden alle Zeichen ab dem durch *index1* angegebenen bis direkt vor *index2* gelöscht (d. h. das Zeichen bei *index2* wird nicht gelöscht). Gibt *index2* keine Position an, die im Text hinter *index1* liegt, werden keine Zeichen gelöscht. Ist *index2* nicht angegeben, wird das einzelne Zeichen bei *index1* gelöscht. Versuche, Zeichen so zu löschen, dass der Text nicht mehr mit einem Zeilenumbruch als letztem Zeichen endet, gleicht das Text-Widget so aus, dass dies nicht geschieht. Insbesondere löscht das Entfernen vollständiger Zeilen bis zum Textende auch das Zeilenumbruchzeichen direkt vor dem gelöschten Block, sodass es durch den neuen abschließenden Zeilenumbruch des Text-Widgets ersetzt wird. Der Befehl gibt eine leere Zeichenkette zurück. Werden weitere Indizes angegeben, werden mehrere Textbereiche gelöscht. Bevor gelöscht wird, werden zuerst alle Indizes auf Gültigkeit geprüft. Sie werden sortiert, und der Text wird vom letzten bis zum ersten Bereich entfernt, damit gelöschter Text keine unerwünschten Indexverschiebungen als Nebenwirkung verursacht.  Werden mehrere Bereiche mit demselben Startindex angegeben, wird der längste Bereich verwendet.  Werden überlappende Bereiche angegeben, werden sie zu Abschnitten zusammengeführt, die nicht dazu führen, dass durch den beim Löschen verschobenen Text Zeichen außerhalb der angegebenen Bereiche gelöscht werden.

*pathName* **dlineinfo** *index*
: Gibt eine Liste mit fünf Elementen zurück, die den Bereich der Anzeigezeile beschreiben, die *index* enthält. Die ersten beiden Elemente der Liste geben die x- und y-Koordinate der oberen linken Ecke des von der Zeile belegten Bereichs an, das dritte und vierte Element geben Breite und Höhe des Bereichs an, und das fünfte Element gibt die Position der Grundlinie der Zeile an, gemessen von der Oberkante des Bereichs nach unten. Alle diese Angaben werden in Pixeln gemessen. Ist der aktuelle Umbruchmodus **none** und reicht die Zeile über die Grenzen des Fensters hinaus, gibt der zurückgegebene Bereich die gesamte Fläche der Zeile wieder, einschließlich der Teile außerhalb des Fensters. Ist die Zeile kürzer als die volle Breite des Fensters, gibt der zurückgegebene Bereich nur den Teil der Zeile wieder, der von Zeichen und eingebetteten Fenstern belegt ist. Ist die Anzeigezeile mit *index* auf dem Bildschirm nicht sichtbar, ist der Rückgabewert eine leere Liste.

*pathName* **dump** ?*switches*? *index1* ?*index2*?
: Gibt den Inhalt des Text-Widgets von *index1* bis ausschließlich *index2* zurück, einschließlich des Textes und der Informationen über Marken, Tags und eingebettete Fenster. Ist *index2* nicht angegeben, liegt es standardmäßig ein Zeichen hinter *index1*. Die Informationen werden im folgenden Format zurückgegeben:

    *key1 value1 index1 key2 value2 index2* ...

    Die möglichen Werte für *key* sind **text**, **mark**, **tagon**, **tagoff**, **image** und **window**. Der zugehörige *value* ist der Text, der Markenname, der Tag-Name, der Bildname oder der Fenstername. Die *index*-Information ist der Index des Anfangs des Textes, der Marke, des Tag-Übergangs, des Bildes oder des Fensters. Einer oder mehrere der folgenden Schalter (oder Abkürzungen davon) können angegeben werden, um den Dump zu steuern:

    **-all**
    : Gibt Informationen über alle Elemente zurück: Text, Marken, Tags, Bilder und Fenster. Das ist die Vorgabe.

    **-command** *command*
    : Statt die Informationen als Ergebnis der Dump-Operation zurückzugeben, wird *command* für jedes Element des Text-Widgets innerhalb des Bereichs aufgerufen. An den Befehl werden vor seiner Auswertung drei Argumente angehängt: *key*, *value* und *index*.

    **-image**
    : Nimmt Informationen über Bilder in die Dump-Ergebnisse auf.

    **-mark**
    : Nimmt Informationen über Marken in die Dump-Ergebnisse auf.

    **-tag**
    : Nimmt Informationen über Tag-Übergänge in die Dump-Ergebnisse auf. Tag-Informationen werden als Elemente **tagon** und **tagoff** zurückgegeben, die jeweils Anfang bzw. Ende jedes Bereichs jedes Tags angeben.

    **-text**
    : Nimmt Informationen über Text in die Dump-Ergebnisse auf. Der Wert ist der Text bis zum nächsten Element oder bis zum Ende des durch *index2* angegebenen Bereichs. Ein Textelement reicht nicht über Zeilenumbrüche hinweg. Ein mehrzeiliger Textblock ohne Marken oder Tag-Übergänge wird dennoch als Folge von Textsegmenten ausgegeben, die jeweils mit einem Zeilenumbruch enden. Der Zeilenumbruch ist Teil des Wertes.

    **-window**
    : Nimmt Informationen über eingebettete Fenster in die Dump-Ergebnisse auf. Der Wert eines Fensters ist sein Tk-Pfadname, es sei denn, das Fenster wurde noch nicht erstellt. (Es muss dann ein Erstellungsskript haben.) In diesem Fall wird eine leere Zeichenkette zurückgegeben, und Sie müssen das Fenster über seine Indexposition abfragen, um weitere Informationen zu erhalten.


*pathName* **edit** *option* ?*arg arg ...*?
: Dieser Befehl steuert den Rückgängig-Mechanismus und die modified-Flagge. Das genaue Verhalten des Befehls hängt vom Argument *option* ab, das auf das Argument **edit** folgt. Derzeit werden die folgenden Formen des Befehls unterstützt:

    *pathName* **edit canredo**
    : Gibt einen booleschen Wahr-Wert zurück, wenn Wiederholen möglich ist, d. h. wenn der Wiederholen-Stapel nicht leer ist. Andernfalls wird ein Falsch-Wert zurückgegeben.

    *pathName* **edit canundo**
    : Gibt einen booleschen Wahr-Wert zurück, wenn Rückgängigmachen möglich ist, d. h. wenn der Rückgängig-Stapel nicht leer ist. Andernfalls wird ein Falsch-Wert zurückgegeben.

    *pathName* **edit modified** ?*boolean*?
    : Ist *boolean* nicht angegeben, gibt der Befehl die modified-Flagge des Widgets zurück. Die Befehle insert, delete, edit undo und edit redo oder der Benutzer können die modified-Flagge setzen oder löschen. Ist *boolean* angegeben, wird die modified-Flagge des Widgets auf *boolean* gesetzt.

    *pathName* **edit redo**
    : Ist die Option **-undo** wahr, werden die zuletzt rückgängig gemachten Bearbeitungen erneut angewendet, sofern seitdem keine anderen Bearbeitungen vorgenommen wurden. Ist der Wiederholen-Stapel leer, wird ein Fehler erzeugt. Ist die Option **-undo** falsch, geschieht nichts.

    *pathName* **edit reset**
    : Leert den Rückgängig- und den Wiederholen-Stapel.

    *pathName* **edit separator**
    : Fügt ein Trennzeichen (eine Grenze) in den Rückgängig-Stapel ein. Ist die Option **-undo** falsch, geschieht nichts.

    *pathName* **edit undo**
    : Macht die letzte Bearbeitungsaktion rückgängig, wenn die Option **-undo** wahr ist. Eine Bearbeitungsaktion umfasst alle Einfüge- und Löschbefehle, die zwischen zwei Trennzeichen auf dem Rückgängig-Stapel aufgezeichnet sind. Ist der Rückgängig-Stapel leer, wird ein Fehler erzeugt. Ist die Option **-undo** falsch, geschieht nichts.


*pathName* **get** ?**-displaychars**? ?**--**? *index1* ?*index2 ...*?
: Gibt einen Bereich von Zeichen aus dem Text zurück. Der Rückgabewert umfasst alle Zeichen des Textes, beginnend mit dem Zeichen mit dem Index *index1* und endend direkt vor dem Zeichen mit dem Index *index2* (das Zeichen bei *index2* wird nicht zurückgegeben). Fehlt *index2*, wird das einzelne Zeichen bei *index1* zurückgegeben. Enthält der angegebene Bereich keine Zeichen (z. B. weil *index1* hinter dem Dateiende liegt oder *index2* kleiner oder gleich *index1* ist), wird eine leere Zeichenkette zurückgegeben. Enthält der angegebene Bereich eingebettete Fenster, werden keine Informationen über sie in die zurückgegebene Zeichenkette aufgenommen. Werden mehrere Indexpaare angegeben, werden mehrere Textbereiche als Liste zurückgegeben. Ungültige Bereiche werden in der Liste nicht durch leere Zeichenketten dargestellt. Die Bereiche werden in der Reihenfolge zurückgegeben, in der sie an *pathName* **get** übergeben wurden. Ist die Option **-displaychars** angegeben, werden innerhalb jedes Bereichs nur die Zeichen zurückgegeben, die nicht ausgeblendet sind. Dadurch können einige der zurückgegebenen Bereiche leere Zeichenketten sein.

*pathName* **image** *option* ?*arg arg ...*?
: Mit diesem Befehl werden eingebettete Bilder bearbeitet. Das Verhalten des Befehls hängt vom Argument *option* ab, das auf das Argument **image** folgt. Derzeit werden die folgenden Formen des Befehls unterstützt:

    *pathName* **image cget** *index option*
    : Gibt den Wert einer Konfigurationsoption für ein eingebettetes Bild zurück. *Index* bezeichnet das eingebettete Bild, und *option* gibt eine bestimmte Konfigurationsoption an, die zu den im Abschnitt [Eingebettete Bilder] aufgeführten gehören muss.

    *pathName* **image configure** *index* ?*option value ...*?
    : Fragt die Konfigurationsoptionen für ein eingebettetes Bild ab oder ändert sie. Ist keine *option* angegeben, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für das eingebettete Bild bei *index* beschreibt (zum Format dieser Liste siehe [Tk\_ConfigureInfo][ConfigWidg]). Ist *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine genannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der ohne Angabe von *option* zurückgegeben wird). Sind ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Optionen auf die angegebenen Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. Die unterstützten Optionen sind unter [Eingebettete Bilder] beschrieben.

    *pathName* **image create** *index* ?*option value ...*?
    : Dieser Befehl erzeugt eine neue Bildannotation, die im Text an der durch *index* angegebenen Position erscheint. Zur Konfiguration der Annotation kann eine beliebige Anzahl von *option-value*-Paaren angegeben werden. Gibt einen eindeutigen Bezeichner zurück, der als Index verwendet werden kann, um auf dieses Bild zu verweisen. Die unterstützten Optionen und eine Beschreibung des zurückgegebenen Bezeichners finden Sie unter [Eingebettete Bilder].

    *pathName* **image names**
    : Gibt eine Liste zurück, deren Elemente die Namen aller Bildinstanzen sind, die derzeit in *window* eingebettet sind.


*pathName* **index** *index*
: Gibt die Position, die *index* entspricht, in der Form *line.char* zurück, wobei *line* die Zeilennummer und *char* die Zeichennummer ist. *Index* kann jede der Formen haben, die oben unter [Indizes] beschrieben sind.

*pathName* **insert** *index chars* ?*tagList chars tagList ...*?
: Fügt alle *chars*-Argumente direkt vor dem Zeichen bei *index* ein. Verweist *index* auf das Textende (das Zeichen nach dem letzten Zeilenumbruch), wird der neue Text stattdessen direkt vor dem letzten Zeilenumbruch eingefügt. Gibt es ein einzelnes *chars*-Argument und keine *tagList*, erhält der neue Text alle Tags, die sowohl auf dem Zeichen vor als auch auf dem Zeichen nach der Einfügestelle vorhanden sind; ist ein Tag nur auf einem dieser Zeichen vorhanden, wird er nicht auf den neuen Text angewendet. Ist *tagList* angegeben, besteht es aus einer Liste von Tag-Namen; die neuen Zeichen erhalten alle Tags dieser Liste und keine anderen, unabhängig von den Tags um die Einfügestelle. Sind mehrere *chars*-*tagList*-Argumentpaare vorhanden, haben sie dieselbe Wirkung, als wäre für jedes Paar der Reihe nach ein eigener Widget-Befehl *pathName* **insert** ausgeführt worden. Das letzte *tagList*-Argument kann entfallen.

*pathName* **mark** *option* ?*arg arg ...*?
: Mit diesem Befehl werden Marken bearbeitet. Das genaue Verhalten des Befehls hängt vom Argument *option* ab, das auf das Argument **mark** folgt. Derzeit werden die folgenden Formen des Befehls unterstützt:

    *pathName* **mark gravity** *markName* ?*direction*?
    : Ist *direction* nicht angegeben, gibt der Befehl **left** oder **right** zurück, je nachdem, an welches der beiden benachbarten Zeichen *markName* gebunden ist. Ist *direction* angegeben, muss es **left** oder **right** sein; die Schwerkraft von *markName* wird auf den angegebenen Wert gesetzt.

    *pathName* **mark names**
    : Gibt eine Liste zurück, deren Elemente die Namen aller derzeit gesetzten Marken sind.

    *pathName* **mark next** *index*
    : Gibt den Namen der nächsten Marke bei oder nach *index* zurück. Ist *index* in numerischer Form angegeben, beginnt die Suche nach der nächsten Marke bei diesem Index. Ist *index* der Name einer Marke, beginnt die Suche nach der nächsten Marke direkt hinter dieser Marke. Dabei kann trotzdem eine Marke an derselben Position zurückgegeben werden, wenn sich mehrere Marken am selben Index befinden. Aus dieser Semantik folgt, dass sich mit der Operation **mark next** alle Marken eines Text-Widgets in derselben Reihenfolge durchlaufen lassen, in der die Operation *pathName* **dump** die Markeninformationen zurückgibt. Wurde eine Marke auf den besonderen Index **end** gesetzt, erscheint sie bezüglich der Operation *pathName* **mark next** *hinter* **end**. Gibt es nach *index* keine Marken, wird eine leere Zeichenkette zurückgegeben.

    *pathName* **mark previous** *index*
    : Gibt den Namen der Marke bei oder vor *index* zurück. Ist *index* in numerischer Form angegeben, beginnt die Suche nach der vorherigen Marke beim Zeichen direkt vor diesem Index. Ist *index* der Name einer Marke, beginnt die Suche nach der vorherigen Marke direkt vor dieser Marke. Dabei kann trotzdem eine Marke an derselben Position zurückgegeben werden, wenn sich mehrere Marken am selben Index befinden. Aus dieser Semantik folgt, dass sich mit der Operation *pathName* **mark previous** alle Marken eines Text-Widgets in umgekehrter Reihenfolge zu den Markeninformationen durchlaufen lassen, die die Operation *pathName* **dump** zurückgibt. Gibt es vor *index* keine Marken, wird eine leere Zeichenkette zurückgegeben.

    *pathName* **mark set** *markName index*
    : Setzt die Marke mit dem Namen *markName* auf eine Position direkt vor dem Zeichen bei *index*. Existiert *markName* bereits, wird sie von ihrer alten Position verschoben; existiert sie nicht, wird eine neue Marke erzeugt. Dieser Befehl gibt eine leere Zeichenkette zurück.

    *pathName* **mark unset** *markName* ?*markName markName ...*?
    : Entfernt die Marke, die zu jedem der *markName*-Argumente gehört. Die entfernten Marken können nicht mehr in Indizes verwendet werden und werden von künftigen Aufrufen von „*pathName* **mark names**“ nicht mehr zurückgegeben. Dieser Befehl gibt eine leere Zeichenkette zurück.


*pathName* **peer** *option args*
: Mit diesem Befehl werden Peer-Widgets erzeugt und abgefragt. Er hat je nach *option* zwei Formen:

    *pathName* **peer create** *newPathName* ?*options*?
    : Erzeugt ein Peer-Text-Widget mit dem angegebenen *newPathName* und beliebigen optionalen Standard-Konfigurationsoptionen (wie beim Befehl *text*). Standardmäßig hat der Peer dieselbe Start- und Endzeile wie das Eltern-Widget; diese lassen sich jedoch mit den Standard-Konfigurationsoptionen überschreiben.

    *pathName* **peer names**
    : Gibt eine Liste der Peers dieses Widgets zurück (das Widget selbst ist nicht enthalten). Die Reihenfolge innerhalb dieser Liste ist nicht festgelegt.


*pathName* **pendingsync**
: Gibt 1 zurück, wenn die Berechnungen der Zeilenhöhen nicht aktuell sind, andernfalls 0.

*pathName* **replace** *index1 index2 chars* ?*tagList chars tagList ...*?
: Ersetzt den Zeichenbereich zwischen *index1* und *index2* durch die angegebenen Zeichen und Tags.  Wie die *tagList...*-Argumente behandelt werden, ist im Abschnitt zu *pathName* **insert** erklärt; wie die Indizes behandelt werden, im Abschnitt zu *pathName* **delete**.  Entspricht *index2* einem Index, der im Text vor *index1* liegt, wird ein Fehler erzeugt.

    Löschen und Einfügen erfolgen so, dass weder unnötiges Scrollen des Fensters noch eine Bewegung des Einfügecursors auftritt. Außerdem werden der Rückgängig- und der Wiederholen-Stapel korrekt angepasst, wenn im Text-Widget Rückgängig-Operationen aktiv sind. Der Befehl gibt eine leere Zeichenkette zurück.

*pathName* **scan** *option args*
: Mit diesem Befehl wird das Scannen in Text-Widgets umgesetzt. Er hat je nach *option* zwei Formen:

    *pathName* **scan mark** *x y*
    : Speichert *x* und *y* sowie die aktuelle Ansicht im Textfenster zur Verwendung mit späteren Befehlen *pathName* **scan dragto**. Typischerweise ist dieser Befehl mit dem Drücken einer Maustaste im Widget verknüpft. Er gibt eine leere Zeichenkette zurück.

    *pathName* **scan dragto** *x y*
    : Dieser Befehl berechnet die Differenz zwischen seinen Argumenten *x* und *y* und den Argumenten *x* und *y* des letzten Befehls *pathName* **scan mark** für das Widget. Anschließend verschiebt er die Ansicht um das Zehnfache der Koordinatendifferenz. Dieser Befehl ist typischerweise mit Mausbewegungsereignissen im Widget verknüpft, um den Effekt zu erzeugen, dass der Text mit hoher Geschwindigkeit durch das Fenster gezogen wird. Der Rückgabewert ist eine leere Zeichenkette.


*pathName* **search** ?*switches*? *pattern index* ?*stopIndex*?
: Durchsucht den Text in *pathName* ab *index* nach einem Zeichenbereich, auf den *pattern* passt. Wird ein Treffer gefunden, wird der Index des ersten Zeichens des Treffers als Ergebnis zurückgegeben; andernfalls wird eine leere Zeichenkette zurückgegeben. Einer oder mehrere der folgenden Schalter (oder Abkürzungen davon) können angegeben werden, um die Suche zu steuern:

    **-forwards**
    : Die Suche verläuft vorwärts durch den Text und findet den ersten passenden Bereich, der bei oder nach der durch *index* angegebenen Position beginnt. Das ist die Vorgabe.

    **-backwards**
    : Die Suche verläuft rückwärts durch den Text und findet den passenden Bereich, der *index* am nächsten liegt und dessen erstes Zeichen vor *index* liegt (es darf nicht bei *index* liegen). Beachten Sie, dass Rückwärtssuchen aus verschiedenen Gründen erheblich langsamer sein können als Vorwärtssuchen (insbesondere bei Verwendung von **-regexp**); daher wird empfohlen, in leistungskritischem Code vorwärts zu suchen.

    **-exact**
    : Verwendet exakten Vergleich: Die Zeichen im passenden Bereich müssen mit denen in *pattern* identisch sein. Das ist die Vorgabe.

    **-regexp**
    : Behandelt *pattern* als regulären Ausdruck und vergleicht ihn nach den Regeln für reguläre Ausdrücke mit dem Text (Einzelheiten siehe den Befehl [regexp] und die Seite [re\_syntax][re_syntax]). Der Standardvergleich übergibt automatisch die beiden Optionen **-lineanchor** und **-linestop** an die Regexp-Engine (sofern nicht **-nolinestop** verwendet wird), sodass *^$* auf Zeilenanfang und Zeilenende passen und die Sequenzen *.* und *\[^* nie auf das Zeilenumbruchzeichen *\\n* passen.

    **-nolinestop**
    : Damit können die Sequenzen *.* und *\[^* auf das Zeilenumbruchzeichen *\\n* passen, was sie sonst nicht tun (Einzelheiten siehe den Befehl [regexp]). Diese Option ist nur zusammen mit **-regexp** sinnvoll; andernfalls wird ein Fehler ausgelöst. Um zum Beispiel den gesamten Text zu treffen, verwenden Sie „*pathName* **search -nolinestop -regexp** ".\*" 1.0“.

    **-nocase**
    : Ignoriert Unterschiede in der Groß- und Kleinschreibung zwischen dem Muster und dem Text.

    **-count** *varName*
    : Das Argument nach **-count** gibt den Namen einer Variablen an; wird ein Treffer gefunden, wird die Anzahl der Indexpositionen zwischen Anfang und Ende des passenden Bereichs in der Variablen gespeichert. Enthält der passende Bereich keine eingebetteten Bilder oder Fenster (und keine ausgeblendeten Zeichen, wenn **-elide** nicht angegeben ist), entspricht dies der Anzahl der getroffenen Zeichen. In beiden Fällen liefert der Bereich *matchIdx* bis *matchIdx + $count chars* den gesamten getroffenen Text.

    **-all**
    : Findet alle Treffer im angegebenen Bereich und gibt eine Liste der Indizes des jeweils ersten Zeichens jedes Treffers zurück. Ist ein Schalter **-count** *varName* angegeben, wird *varName* ebenfalls auf eine Liste gesetzt, die für jeden erfolgreichen Treffer ein Element enthält. Beachten Sie, dass sich die Elemente dieser Liste auch bei exakten Suchen unterscheiden können, wenn eingebettete Bilder, Fenster oder verborgener Text vorhanden sind. Suchen mit **-all** verhalten sich sehr ähnlich wie der Tcl-Befehl [regexp -all][regexp], da überlappende Treffer normalerweise nicht zurückgegeben werden. So trifft zum Beispiel eine Suche mit **-all** nach dem Muster „\\w+“ in „hello there“ nur zweimal, einmal für jedes Wort, und der Vergleich von „Z\[a-z\]+Z“ mit „ZooZooZoo“ trifft nur einmal.

    **-overlap**
    : Bei Suchen mit **-all** werden normalerweise keine Treffer zurückgegeben, die einen bereits gefundenen Treffer überlappen. Dieser Schalter ändert dieses Verhalten so, dass alle Treffer zurückgegeben werden, die nicht vollständig in einem anderen Treffer enthalten sind. So trifft zum Beispiel eine Suche mit **-overlap** nach dem Muster „\\w+“ in „hello there“ nur zweimal (d. h. nicht anders als mit **-all** allein), der Vergleich von „Z\[a-z\]+Z“ mit „ZooZooZoo“ trifft jetzt aber zweimal. Wird dieser Schalter ohne **-all** verwendet, wird ein Fehler ausgelöst.

    **-strictlimits**
    : Bei jeder Suche werden die Start- und Stoppgrenzen normalerweise bezogen auf den Anfang des passenden Textes geprüft. Mit dem Schalter **-strictlimits** muss der gesamte passende Bereich innerhalb der angegebenen Start- und Stoppgrenzen liegen, damit der Treffer gültig ist.

    **-elide**
    : Findet auch ausgeblendeten (verborgenen) Text. Standardmäßig wird nur angezeigter Text durchsucht.

    **--**
    : Dieser Schalter hat keine andere Wirkung, als die Liste der Schalter zu beenden: Das nächste Argument wird als *pattern* behandelt, auch wenn es mit **-** beginnt.


    Der passende Bereich kann innerhalb einer einzelnen Textzeile liegen oder sich über mehrere Zeilen erstrecken (wenn Teile des Musters auf einen Zeilenumbruch passen können). Beim Vergleich mit regulären Ausdrücken können Sie die verschiedenen Möglichkeiten für Zeilenumbrüche nutzen, etwa **$** für das Zeilenende und **^** für den Zeilenanfang, und steuern, ob **.** auf einen Zeilenumbruch passen darf. Ist *stopIndex* angegeben, endet die Suche bei diesem Index: Bei Vorwärtssuchen wird kein Treffer bei oder nach *stopIndex* berücksichtigt; bei Rückwärtssuchen wird kein Treffer berücksichtigt, der im Text vor *stopIndex* liegt. Fehlt *stopIndex*, wird der gesamte Text durchsucht: Wird Anfang oder Ende des Textes erreicht, wird die Suche am anderen Ende fortgesetzt, bis die Startposition wieder erreicht ist; ist *stopIndex* angegeben, findet kein Umlauf statt. Das bedeutet zum Beispiel: Ist die Suche **-forwards**, liegt *stopIndex* aber im Text vor *startIndex*, wird nie etwas gefunden. Unter [Bekannte Fehler] weiter unten finden Sie einige kleinere Einschränkungen des Befehls *pathName* **search**.

*pathName* **see** *index*
: Passt die Ansicht im Fenster so an, dass das durch *index* angegebene Zeichen vollständig sichtbar ist. Ist *index* bereits sichtbar, tut der Befehl nichts. Liegt *index* knapp außerhalb der Ansicht, verschiebt der Befehl die Ansicht gerade so weit, dass *index* am Rand des Fensters sichtbar wird. Liegt *index* weit außerhalb der Ansicht, zentriert der Befehl *index* im Fenster.

*pathName* **sync** ?**-command** *command*?
: Steuert die Synchronisation der Ansicht des Text-Widgets.

    *pathName* **sync**
    : Bringt die Zeilenmetriken sofort auf den aktuellen Stand, indem die Berechnung aller veralteten Zeilenhöhen erzwungen wird. Gibt es keine veralteten Zeilenhöhen, kehrt der Befehl sofort zurück, andernfalls erst am Ende der Berechnung. Der Befehl gibt eine leere Zeichenkette zurück.

    *pathName* **sync -command** *command*
    : Plant *command* zur Ausführung (durch die Ereignisschleife) genau einmal ein, sobald alle Zeilenhöhen aktuell sind. Stehen keine Berechnungen der Zeilenmetriken aus, erfolgt die Einplanung sofort. Der Befehl gibt eine leere Zeichenkette zurück. Schlägt *command* fehl, wird [bgerror] aufgerufen.


*pathName* **tag** *option* ?*arg arg ...*?
: Mit diesem Befehl werden Tags bearbeitet. Das genaue Verhalten des Befehls hängt vom Argument *option* ab, das auf das Argument **tag** folgt. Derzeit werden die folgenden Formen des Befehls unterstützt:

    *pathName* **tag add** *tagName index1* ?*index2 index1 index2 ...*?
    : Verknüpft den Tag *tagName* mit allen Zeichen ab *index1* bis direkt vor *index2* (das Zeichen bei *index2* wird nicht markiert). Ein einzelner Befehl kann beliebig viele *index1*-*index2*-Paare enthalten. Fehlt das letzte *index2*, wird das einzelne Zeichen bei *index1* markiert. Enthält der angegebene Bereich keine Zeichen (z. B. weil *index1* hinter dem Dateiende liegt oder *index2* kleiner oder gleich *index1* ist), hat der Befehl keine Wirkung.

    *pathName* **tag bind** *tagName* ?*sequence*? ?*script*?
    : Dieser Befehl verknüpft *script* mit dem durch *tagName* angegebenen Tag. Immer wenn die durch *sequence* angegebene Ereignissequenz für ein Zeichen eintritt, das mit *tagName* markiert ist, wird das Skript aufgerufen. Dieser Widget-Befehl ähnelt dem Befehl **bind**, wirkt aber auf Zeichen in einem Text statt auf ganze Widgets. Ausführliche Angaben zur Syntax von *sequence* und zu den Ersetzungen, die vor dem Aufruf in *script* vorgenommen werden, finden Sie in der Handbuchseite zu **bind**. Sind alle Argumente angegeben, wird eine neue Bindung erzeugt, die eine bestehende Bindung für dieselbe *sequence* und denselben *tagName* ersetzt (ist das erste Zeichen von *script* ein „+“, ergänzt *script* eine bestehende Bindung, statt sie zu ersetzen). In diesem Fall ist der Rückgabewert eine leere Zeichenkette. Fehlt *script*, gibt der Befehl das mit *tagName* und *sequence* verknüpfte *script* zurück (gibt es keine solche Bindung, tritt ein Fehler auf). Fehlen sowohl *script* als auch *sequence*, gibt der Befehl eine Liste aller Sequenzen zurück, für die Bindungen für *tagName* definiert sind.

        Bindungen können nur für Ereignisse angegeben werden, die mit Maus und Tastatur zusammenhängen (etwa **Enter**, **Leave**, **ButtonPress**, **Motion** und **KeyPress**), sowie für virtuelle Ereignisse. Bindungen an Maus- und Tastaturereignisse eines Text-Widgets verwenden die Marken **current** bzw. **insert**, die oben unter [Marken] beschrieben sind. Ein **Enter**-Ereignis wird für einen Tag ausgelöst, wenn der Tag erstmals am aktuellen Zeichen vorhanden ist, und ein **Leave**-Ereignis, wenn er am aktuellen Zeichen nicht mehr vorhanden ist. **Enter**- und **Leave**-Ereignisse können eintreten, weil sich die Marke **current** bewegt hat oder weil sich das Zeichen an dieser Position geändert hat. Beachten Sie, dass sich diese Ereignisse von den **Enter**- und **Leave**-Ereignissen für Fenster unterscheiden. Mausereignisse werden an das aktuelle Zeichen gerichtet, Tastaturereignisse an das Einfügezeichen. Wird in einer Bindung ein virtuelles Ereignis verwendet, kann diese Bindung nur ausgelöst werden, wenn das virtuelle Ereignis durch ein zugrunde liegendes Maus- oder Tastaturereignis definiert ist.

        Das aktuelle Zeichen kann mehrere Tags haben, und jeder davon kann eine Bindung für eine bestimmte Ereignissequenz haben. In diesem Fall wird für jeden Tag eine Bindung aufgerufen, in der Reihenfolge von niedrigster zu höchster Priorität. Gibt es für einen einzelnen Tag mehrere passende Bindungen, wird die spezifischste gewählt (Einzelheiten siehe die Handbuchseite zum Befehl **bind**). Die Befehle [continue] und [break] in Bindungsskripten werden genauso verarbeitet wie bei Bindungen, die mit dem Befehl **bind** erzeugt wurden.

        Werden mit dem Befehl **bind** Bindungen für das Widget als Ganzes erzeugt, ergänzen diese die Tag-Bindungen. Zuerst werden die Tag-Bindungen aufgerufen, danach die Bindungen für das Fenster als Ganzes.

    *pathName* **tag cget** *tagName option*
    : Dieser Befehl gibt den aktuellen Wert der Option *option* zurück, die mit dem durch *tagName* angegebenen Tag verknüpft ist. *Option* kann jeden der Werte haben, die der Widget-Befehl *pathName* **tag configure** akzeptiert.

    *pathName* **tag configure** *tagName* ?*option*? ?*value*? ?*option value ...*?
    : Dieser Befehl ähnelt dem Widget-Befehl *pathName* **configure**, ändert aber Optionen des durch *tagName* angegebenen Tags statt Optionen des gesamten Text-Widgets. Ist keine *option* angegeben, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *tagName* beschreibt (zum Format dieser Liste siehe [Tk\_ConfigureInfo][ConfigWidg]). Ist *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine genannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der ohne Angabe von *option* zurückgegeben wird). Sind ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Optionen in *tagName* auf die angegebenen Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. Einzelheiten zu den für Tags verfügbaren Optionen finden Sie oben unter [Tags].

    *pathName* **tag delete** *tagName* ?*tagName ...*?
    : Löscht alle Tag-Informationen für jedes der *tagName*-Argumente. Der Befehl entfernt die Tags von allen Zeichen in der Datei und löscht außerdem alle anderen mit den Tags verknüpften Informationen, etwa Bindungen und Anzeigeinformationen. Der Befehl gibt eine leere Zeichenkette zurück.

    *pathName* **tag lower** *tagName* ?*belowThis*?
    : Ändert die Priorität des Tags *tagName* so, dass sie knapp unter der Priorität des Tags mit dem Namen *belowThis* liegt. Fehlt *belowThis*, wird die Priorität von *tagName* so geändert, dass sie die niedrigste aller Tags ist.

    *pathName* **tag names** ?*index*?
    : Gibt eine Liste zurück, deren Elemente die Namen aller Tags sind, die an der durch *index* angegebenen Zeichenposition aktiv sind. Fehlt *index*, beschreibt der Rückgabewert alle Tags, die für den Text existieren (dazu gehören alle Tags, die in einem Widget-Befehl „*pathName* **tag**“ genannt, aber nicht durch einen Widget-Befehl „*pathName* **tag delete**“ gelöscht wurden, auch wenn derzeit keine Zeichen mit dem Tag markiert sind). Die Liste ist von niedrigster zu höchster Priorität sortiert.

    *pathName* **tag nextrange** *tagName index1* ?*index2*?
    : Dieser Befehl durchsucht den Text nach einem Bereich von Zeichen, die mit *tagName* markiert sind, wobei das erste Zeichen des Bereichs nicht vor dem Zeichen bei *index1* und nicht nach dem Zeichen direkt vor *index2* liegt (ein Bereich, der bei *index2* beginnt, wird nicht berücksichtigt). Gibt es mehrere passende Bereiche, wird der erste gewählt. Der Rückgabewert des Befehls ist eine Liste mit zwei Elementen: dem Index des ersten Zeichens des Bereichs und dem Index des Zeichens direkt nach dem letzten Zeichen des Bereichs. Wird kein passender Bereich gefunden, ist der Rückgabewert eine leere Zeichenkette. Ist *index2* nicht angegeben, gilt als Vorgabe das Textende.

    *pathName* **tag prevrange** *tagName index1* ?*index2*?
    : Dieser Befehl durchsucht den Text nach einem Bereich von Zeichen, die mit *tagName* markiert sind, wobei das erste Zeichen des Bereichs vor dem Zeichen bei *index1* und nicht vor dem Zeichen bei *index2* liegt (ein Bereich, der bei *index2* beginnt, wird berücksichtigt). Gibt es mehrere passende Bereiche, wird der Bereich gewählt, der *index1* am nächsten liegt. Der Rückgabewert des Befehls ist eine Liste mit zwei Elementen: dem Index des ersten Zeichens des Bereichs und dem Index des Zeichens direkt nach dem letzten Zeichen des Bereichs. Wird kein passender Bereich gefunden, ist der Rückgabewert eine leere Zeichenkette. Ist *index2* nicht angegeben, gilt als Vorgabe der Textanfang.

    *pathName* **tag raise** *tagName* ?*aboveThis*?
    : Ändert die Priorität des Tags *tagName* so, dass sie knapp über der Priorität des Tags mit dem Namen *aboveThis* liegt. Fehlt *aboveThis*, wird die Priorität von *tagName* so geändert, dass sie die höchste aller Tags ist.

    *pathName* **tag ranges** *tagName*
    : Gibt eine Liste zurück, die alle Textbereiche beschreibt, die mit *tagName* markiert sind. Die ersten beiden Elemente der Liste beschreiben den ersten markierten Bereich im Text, die nächsten beiden Elemente den zweiten Bereich und so weiter. Das erste Element jedes Paares enthält den Index des ersten Zeichens des Bereichs, das zweite Element den Index des Zeichens direkt nach dem letzten Zeichen des Bereichs. Sind keine Zeichen mit *tag* markiert, wird eine leere Zeichenkette zurückgegeben.

    *pathName* **tag remove** *tagName index1* ?*index2 index1 index2 ...*?
    : Entfernt den Tag *tagName* von allen Zeichen ab *index1* bis direkt vor *index2* (das Zeichen bei *index2* ist nicht betroffen). Ein einzelner Befehl kann beliebig viele *index1*-*index2*-Paare enthalten. Fehlt das letzte *index2*, wird der Tag vom einzelnen Zeichen bei *index1* entfernt. Enthält der angegebene Bereich keine Zeichen (z. B. weil *index1* hinter dem Dateiende liegt oder *index2* kleiner oder gleich *index1* ist), hat der Befehl keine Wirkung. Dieser Befehl gibt eine leere Zeichenkette zurück.


*pathName* **window** *option* ?*arg arg ...*?
: Mit diesem Befehl werden eingebettete Fenster bearbeitet. Das Verhalten des Befehls hängt vom Argument *option* ab, das auf das Argument **window** folgt. Derzeit werden die folgenden Formen des Befehls unterstützt:

    *pathName* **window cget** *index option*
    : Gibt den Wert einer Konfigurationsoption für ein eingebettetes Fenster zurück. *Index* bezeichnet das eingebettete Fenster, und *option* gibt eine bestimmte Konfigurationsoption an, die zu den im Abschnitt [Eingebettete Fenster] aufgeführten gehören muss.

    *pathName* **window configure** *index* ?*option value ...*?
    : Fragt die Konfigurationsoptionen für ein eingebettetes Fenster ab oder ändert sie. Ist keine *option* angegeben, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für das eingebettete Fenster bei *index* beschreibt (zum Format dieser Liste siehe [Tk\_ConfigureInfo][ConfigWidg]). Ist *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine genannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der ohne Angabe von *option* zurückgegeben wird). Sind ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Optionen auf die angegebenen Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. Die unterstützten Optionen sind unter [Eingebettete Fenster] beschrieben.

    *pathName* **window create** *index* ?*option value ...*?
    : Dieser Befehl erzeugt eine neue Fensterannotation, die im Text an der durch *index* angegebenen Position erscheint. Zur Konfiguration der Annotation kann eine beliebige Anzahl von *option-value*-Paaren angegeben werden. Die unterstützten Optionen sind unter [Eingebettete Fenster] beschrieben. Gibt eine leere Zeichenkette zurück.

    *pathName* **window names**
    : Gibt eine Liste zurück, deren Elemente die Namen aller Fenster sind, die derzeit in *window* eingebettet sind.


*pathName* **xview** *option args*
: Mit diesem Befehl wird die horizontale Position des Textes im Fenster des Widgets abgefragt und geändert. Er kann jede der folgenden Formen annehmen:

    *pathName* **xview**
    : Gibt eine Liste mit zwei Elementen zurück. Jedes Element ist ein reeller Bruch zwischen 0 und 1; zusammen beschreiben sie den Teil der horizontalen Ausdehnung des Dokuments, der im Fenster sichtbar ist. Ist zum Beispiel das erste Element .2 und das zweite .6, liegen 20 % des Textes links außerhalb des Bildschirms, die mittleren 40 % sind im Fenster sichtbar, und 40 % des Textes liegen rechts außerhalb des Bildschirms. Die Brüche beziehen sich nur auf die tatsächlich im Fenster sichtbaren Zeilen: Sind die Zeilen im Fenster alle sehr kurz, sodass sie vollständig sichtbar sind, sind die zurückgegebenen Brüche 0 und 1, auch wenn der Text andere Zeilen enthält, die viel breiter als das Fenster sind. Das sind dieselben Werte, die über die Option **-xscrollcommand** an Scrollbars übergeben werden.

    *pathName* **xview moveto** *fraction*
    : Passt die Ansicht im Fenster so an, dass der Anteil *fraction* der horizontalen Ausdehnung des Textes links außerhalb des Bildschirms liegt. *Fraction* ist ein Bruch zwischen 0 und 1.

    *pathName* **xview scroll** *number what*
    : Dieser Befehl verschiebt die Ansicht im Fenster gemäß *number* und *what* nach links oder rechts. *What* muss **units**, **pages** oder **pixels** sein. Ist *what* gleich **units** oder **pages**, muss *number* eine Ganzzahl sein; andernfalls kann number in jeder Form angegeben werden, die [Tk\_GetPixels][GetPixels] akzeptiert, etwa „2.0c“ oder „1i“ (das Ergebnis wird auf die nächste Ganzzahl gerundet; ist keine Einheit angegeben, werden Pixel angenommen). Ist *what* gleich **units**, verschiebt sich die Ansicht um *number* durchschnittlich breite Zeichen der Anzeige nach links oder rechts; ist es **pages**, um *number* Bildschirmseiten; ist es **pixels**, um *number* Pixel. Ist *number* negativ, werden weiter links liegende Zeichen sichtbar; ist es positiv, werden weiter rechts liegende Zeichen sichtbar.


*pathName* **yview** ?*args*?
: Mit diesem Befehl wird die vertikale Position des Textes im Fenster des Widgets abgefragt und geändert. Er kann jede der folgenden Formen annehmen:

    *pathName* **yview**
    : Gibt eine Liste mit zwei Elementen zurück, die beide reelle Brüche zwischen 0 und 1 sind. Das erste Element gibt die Position des ersten sichtbaren Pixels des ersten Zeichens (oder Bildes usw.) in der obersten Zeile des Fensters relativ zum gesamten Text an (0.5 bedeutet zum Beispiel, dass es in der Mitte des Textes liegt). Das zweite Element gibt die Position des ersten Pixels direkt nach dem letzten sichtbaren Pixel in der untersten Zeile des Fensters relativ zum gesamten Text an. Das sind dieselben Werte, die über die Option **-yscrollcommand** an Scrollbars übergeben werden.

    *pathName* **yview moveto** *fraction*
    : Passt die Ansicht im Fenster so an, dass das durch *fraction* angegebene Pixel am oberen Rand der obersten Zeile des Fensters erscheint. *Fraction* ist ein Bruch zwischen 0 und 1; 0 bezeichnet das erste Pixel des ersten Zeichens im Text, 0.33 das Pixel, das ein Drittel des Weges durch den Text liegt, und so weiter. Werte nahe 1 bezeichnen Werte nahe dem letzten Pixel im Text (1 bezieht sich eigentlich auf ein Pixel hinter dem letzten Pixel); in solchen Fällen scrollt das Widget jedoch nie über das letzte Pixel hinaus, sodass ein Wert von 1 effektiv auf den Bruch zurückgerundet wird, bei dem das letzte Pixel am unteren Rand des Fensters und ein anderes Pixel am oberen Rand liegt.

    *pathName* **yview scroll** *number what*
    : Dieser Befehl verschiebt die Ansicht im Fenster gemäß *number* und *what* nach oben oder unten. *What* muss **units**, **pages** oder **pixels** sein. Ist *what* gleich **units** oder **pages**, muss *number* eine Ganzzahl sein; andernfalls kann number in jeder Form angegeben werden, die [Tk\_GetPixels][GetPixels] akzeptiert, etwa „2.0c“ oder „1i“ (das Ergebnis wird auf die nächste Ganzzahl gerundet; ist keine Einheit angegeben, werden Pixel angenommen). Ist *what* gleich **units**, verschiebt sich die Ansicht um *number* Zeilen der Anzeige nach oben oder unten; ist es **pages**, um *number* Bildschirmseiten; ist es **pixels**, um *number* Pixel. Ist *number* negativ, werden frühere Positionen im Text sichtbar; ist es positiv, werden spätere Positionen im Text sichtbar.

    *pathName* **yview** ?**-pickplace**? *index*
    : Ändert die Ansicht im Fenster des Widgets so, dass *index* sichtbar wird. Ist die Option **-pickplace** nicht angegeben, erscheint *index* am oberen Rand des Fensters. Ist **-pickplace** angegeben, wählt das Widget, wo *index* im Fenster erscheint:

        1. Ist *index* bereits irgendwo im Fenster sichtbar, tut der Befehl nichts.

        2. Liegt *index* nur wenige Zeilen oberhalb des Fensters außerhalb des Bildschirms, wird es am oberen Rand des Fensters positioniert.

        3. Liegt *index* nur wenige Zeilen unterhalb des Fensters außerhalb des Bildschirms, wird es am unteren Rand des Fensters positioniert.

        4. Andernfalls wird *index* im Fenster zentriert.


        Die Option **-pickplace** ist durch den Widget-Befehl *pathName* **see** obsolet geworden (*pathName* **see** behandelt Bewegungen in x- und y-Richtung, um eine Position sichtbar zu machen, während der Modus **-pickplace** nur Bewegungen in y-Richtung behandelt).

    *pathName* **yview** *number*
    : Dieser Befehl macht das erste Zeichen der Zeile nach der durch *number* angegebenen Zeile am oberen Rand des Fensters sichtbar. *Number* muss eine Ganzzahl sein. Dieser Befehl wurde früher zum Scrollen verwendet, ist inzwischen aber obsolet.



# Bindungen

Tk erstellt automatisch Klassenbindungen für Text-Widgets, die ihnen das folgende Standardverhalten geben. In den folgenden Beschreibungen hängt „Wort“ vom Wert der Variablen **tcl\_wordchars** ab.  Siehe [tclvars]\(n).

1. Ein Klick mit Maustaste 1 setzt den Einfügecursor an die nächstgelegene Kante des Zeichens unter dem Mauszeiger, setzt den Eingabefokus auf dieses Widget und hebt jede Auswahl im Widget auf. Ziehen mit Maustaste 1 zieht eine Auswahl zwischen dem Einfügecursor und dem Zeichen unter der Maus auf.

2. Ein Doppelklick mit Maustaste 1 wählt das Wort unter der Maus aus und setzt den Einfügecursor an den Anfang des Wortes. Ziehen nach einem Doppelklick zieht eine Auswahl aus ganzen Wörtern auf.

3. Ein Dreifachklick mit Maustaste 1 wählt die Zeile unter der Maus aus und setzt den Einfügecursor an den Anfang der Zeile. Ziehen nach einem Dreifachklick zieht eine Auswahl aus ganzen Zeilen auf.

4. Die Enden der Auswahl lassen sich durch Ziehen mit Maustaste 1 bei gedrückter Umschalttaste anpassen; dabei wird das Ende der Auswahl angepasst, das dem Mauszeiger beim Drücken von Taste 1 am nächsten war. Wird die Taste vor dem Ziehen doppelt geklickt, wird die Auswahl in Einheiten ganzer Wörter angepasst; wird sie dreifach geklickt, wird die Auswahl in Einheiten ganzer Zeilen angepasst.

5. Ein Klick mit Maustaste 1 bei gedrückter Strg-Taste setzt den Einfügecursor neu, ohne die Auswahl zu beeinflussen.

6. Werden normale druckbare Zeichen eingegeben, werden sie an der Position des Einfügecursors eingefügt.

7. Die Ansicht im Widget lässt sich durch Ziehen mit der mittleren Maustaste anpassen (Taste 2, unter TkAqua Taste 3). Wird die mittlere Maustaste geklickt, ohne die Maus zu bewegen, wird die Auswahl an der Position des Mauszeigers in den Text kopiert. Die Einfg-Taste fügt die Auswahl ebenfalls ein, allerdings an der Position des Einfügecursors.

8. Wird die Maus bei gedrückter Taste 1 aus dem Widget gezogen, scrollt das Widget automatisch, um mehr Text sichtbar zu machen (sofern auf der Seite, auf der die Maus das Fenster verlassen hat, weiterer Text außerhalb des Bildschirms liegt).

9. Die Tasten Links und Rechts bewegen den Einfügecursor um ein Zeichen nach links oder rechts; außerdem heben sie jede Auswahl im Text auf. Wird Links oder Rechts bei gedrückter Umschalttaste gedrückt, bewegt sich der Einfügecursor, und die Auswahl wird um das neue Zeichen erweitert. Strg-Links und Strg-Rechts bewegen den Einfügecursor wortweise, und Strg-Umschalt-Links und Strg-Umschalt-Rechts bewegen den Einfügecursor wortweise und erweitern zusätzlich die Auswahl. Strg-b und Strg-f verhalten sich wie Links bzw. Rechts. Meta-b und Meta-f verhalten sich wie Strg-Links bzw. Strg-Rechts.

10. Die Tasten Hoch und Runter bewegen den Einfügecursor um eine Zeile nach oben oder unten und heben jede Auswahl im Text auf. Wird Hoch oder Runter bei gedrückter Umschalttaste gedrückt, bewegt sich der Einfügecursor, und die Auswahl wird um das neue Zeichen erweitert. Strg-Hoch und Strg-Runter bewegen den Einfügecursor absatzweise (Gruppen von Zeilen, die durch Leerzeilen getrennt sind), und Strg-Umschalt-Hoch und Strg-Umschalt-Runter bewegen den Einfügecursor absatzweise und erweitern zusätzlich die Auswahl. Strg-p und Strg-n verhalten sich wie Hoch bzw. Runter.

11. Die Tasten Bild-ab und Bild-auf bewegen den Einfügecursor um eine Bildschirmseite vorwärts oder rückwärts und heben jede Auswahl im Text auf. Wird beim Drücken von Bild-ab oder Bild-auf die Umschalttaste gedrückt gehalten, wird die Auswahl um das neue Zeichen erweitert.

12. Strg-Bild-ab und Strg-Bild-auf scrollen die Ansicht um eine Seite nach rechts oder links, ohne den Einfügecursor zu bewegen oder die Auswahl zu beeinflussen.

13. Pos1 und Strg-a bewegen den Einfügecursor an den Anfang seiner Anzeigezeile und heben jede Auswahl im Widget auf. Umschalt-Pos1 bewegt den Einfügecursor an den Anfang der Anzeigezeile und erweitert zusätzlich die Auswahl bis zu dieser Stelle.

14. Ende und Strg-e bewegen den Einfügecursor an das Ende der Anzeigezeile und heben jede Auswahl im Widget auf. Umschalt-Ende bewegt den Cursor an das Ende der Anzeigezeile und erweitert die Auswahl bis zu dieser Stelle.

15. Strg-Pos1 und Meta-< bewegen den Einfügecursor an den Anfang des Textes und heben jede Auswahl im Widget auf. Strg-Umschalt-Pos1 bewegt den Einfügecursor an den Anfang des Textes und erweitert zusätzlich die Auswahl bis zu dieser Stelle.

16. Strg-Ende und Meta-> bewegen den Einfügecursor an das Ende des Textes und heben jede Auswahl im Widget auf. Strg-Umschalt-Ende bewegt den Cursor an das Ende des Textes und erweitert die Auswahl bis zu dieser Stelle.

17. Die Select-Taste und Strg-Leertaste setzen den Auswahlanker auf die Position des Einfügecursors. Sie beeinflussen die aktuelle Auswahl nicht. Umschalt-Select und Strg-Umschalt-Leertaste passen die Auswahl an die aktuelle Position des Einfügecursors an; gab es zuvor keine Auswahl, wird vom Anker bis zum Einfügecursor ausgewählt.

18. Strg-/ wählt den gesamten Inhalt des Widgets aus.

19. Strg-\\ hebt jede Auswahl im Widget auf.

20. Die Taste F16 (auf vielen Sun-Workstations mit Copy beschriftet) oder Meta-w kopiert die Auswahl im Widget in die Zwischenablage, sofern es eine Auswahl gibt. Diese Aktion wird vom Befehl **tk\_textCopy** ausgeführt.

21. Die Taste F20 (auf vielen Sun-Workstations mit Cut beschriftet) oder Strg-w kopiert die Auswahl im Widget in die Zwischenablage und löscht die Auswahl. Diese Aktion wird vom Befehl **tk\_textCut** ausgeführt. Gibt es im Widget keine Auswahl, haben diese Tasten keine Wirkung.

22. Die Taste F18 (auf vielen Sun-Workstations mit Paste beschriftet) oder Strg-y fügt den Inhalt der Zwischenablage an der Position des Einfügecursors ein. Diese Aktion wird vom Befehl **tk\_textPaste** ausgeführt.

23. Die Taste Entf löscht die Auswahl, sofern es im Widget eine gibt. Gibt es keine Auswahl, löscht sie das Zeichen rechts vom Einfügecursor.

24. Rücktaste und Strg-h löschen die Auswahl, sofern es im Widget eine gibt. Gibt es keine Auswahl, löschen sie das Zeichen links vom Einfügecursor.

25. Strg-d löscht das Zeichen rechts vom Einfügecursor.

26. Meta-d löscht das Wort rechts vom Einfügecursor.

27. Strg-k löscht vom Einfügecursor bis zum Ende seiner Zeile; steht der Einfügecursor bereits am Ende einer Zeile, löscht Strg-k das Zeilenumbruchzeichen.

28. Strg-o öffnet eine neue Zeile, indem ein Zeilenumbruchzeichen vor dem Einfügecursor eingefügt wird, ohne den Einfügecursor zu bewegen.

29. Meta-Rücktaste und Meta-Entf löschen das Wort links vom Einfügecursor.

30. Strg-x löscht alles, was im Text-Widget ausgewählt ist, nachdem es in die Zwischenablage kopiert wurde.

31. Strg-t vertauscht die Reihenfolge der beiden Zeichen rechts vom Einfügecursor.

32. Strg-z macht die letzte Bearbeitungsaktion rückgängig, wenn die Option **-undo** wahr ist. Andernfalls geschieht nichts.

33. Strg-Z (unter Windows Strg-y) wendet die letzte rückgängig gemachte Bearbeitungsaktion erneut an, wenn die Option **-undo** wahr ist. Andernfalls geschieht nichts.


Wird das Widget mit der Option **-state** deaktiviert, lässt sich seine Ansicht weiterhin anpassen und Text weiterhin auswählen, es wird aber kein Einfügecursor angezeigt, und es finden keine Textänderungen statt.

Das Verhalten von Text-Widgets lässt sich ändern, indem Sie neue Bindungen für einzelne Widgets definieren oder die Klassenbindungen neu definieren.

# Bekannte Probleme

## Probleme bezüglich chars und Indizes

Vor Tk 8.5 verwendete das Widget die Zeichenkette „chars“, um Indexpositionen zu bezeichnen (zu denen Zeichen, eingebettete Fenster und eingebettete Bilder gehörten). Seit Tk 8.5 behandelt das Text-Widget „chars“ und „indices“ getrennt und korrekt. Aus Gründen der Abwärtskompatibilität beziehen sich die Indexmodifikatoren „+N chars“ und „-N chars“ jedoch weiterhin auf Indizes. Um sich auf tatsächliche Zeichenindizes zu beziehen, müssen Sie eine der vollständigen Formen „+N any chars“ oder „-N any chars“ usw. verwenden. Diese Unklarheit wird möglicherweise in einer künftigen Version behoben, indem das Widget „+N chars“ korrekt als Synonym für „+N any chars“ interpretiert.

## Performance-Probleme

Text-Widgets sollten unter den verschiedensten Bedingungen effizient arbeiten. Das Text-Widget belegt etwa 2–3 Byte Hauptspeicher für jedes Byte Text, sodass Texte mit einem Megabyte oder mehr auf den meisten Workstations praktikabel sein sollten. Intern wird Text mit einer modifizierten B-Baum-Struktur dargestellt, die Operationen auch bei großen Texten relativ effizient macht. Tags sind so in die B-Baum-Struktur eingebunden, dass sie große Bereiche überspannen oder viele getrennte kleinere Bereiche haben können, ohne an Effizienz zu verlieren. Auch Marken sind so implementiert, dass eine große Anzahl von Marken möglich ist. In den meisten Fällen ist es unproblematisch, eine große Anzahl eindeutiger Tags oder einen Tag mit vielen getrennten Bereichen zu haben.

Ein Leistungsproblem kann entstehen, wenn Sie Hunderte oder Tausende verschiedener Tags haben, die alle die folgenden Eigenschaften aufweisen: Der erste und der letzte Bereich jedes Tags liegen nahe am Anfang bzw. am Ende des Textes, oder ein einzelner Tag-Bereich deckt den größten Teil des Text-Widgets ab. Die Kosten für das Hinzufügen und Löschen solcher Tags sind proportional zur Anzahl der anderen Tags mit denselben Eigenschaften. Dagegen ist es unproblematisch, Tausende verschiedener Tags zu haben, wenn ihre Gesamtbereiche lokal begrenzt und gleichmäßig über den Text verteilt sind.

Sehr lange Textzeilen können aufwendig sein, besonders wenn sie viele Marken und Tags enthalten.

Die Anzeigezeile mit dem Einfügecursor wird bei jedem Blinken des Cursors neu gezeichnet, was einen ständigen Strom von Grafikverkehr verursacht. Setzen Sie das Attribut **-insertofftime** auf 0, um dies zu vermeiden.

## Bekannte Fehler

Der Unterbefehl *pathName* **search -regexp** versucht (seit Tk 8.5), anspruchsvolle Regexp-Vergleiche über mehrere Zeilen effizient durchzuführen, indem er jede Zeile einzeln und dann in kleinen Gruppen von Zeilen untersucht, unabhängig davon, ob vorwärts oder rückwärts gesucht wird. Unter bestimmten Bedingungen kann das Suchergebnis von dem Ergebnis abweichen, das entsteht, wenn derselbe reguläre Ausdruck in einem Durchgang auf den gesamten Text des Widgets angewendet wird. Bei der Suche mit einem gierigen regulären Ausdruck versucht das Widget zum Beispiel so lange, dem Treffer weitere Zeilen hinzuzufügen, wie eine von zwei Bedingungen erfüllt ist: Entweder meldet die Regexp-Bibliothek von Tcl mit einem Code, dass ein längerer Treffer möglich ist (es gibt jedoch bekannte Fehler in Tcl, aufgrund derer dieser Code nicht immer korrekt zurückgegeben wird), oder jede zusätzlich hinzugefügte Zeile führt zumindest zu einem teilweisen Treffer des Musters. Das bedeutet: Führt die erste zusätzlich hinzugefügte Zeile zu keinem Treffer, gibt das Regexp-System von Tcl den falschen Code zurück und würde das Hinzufügen einer zweiten zusätzlichen Zeile tatsächlich einen Treffer ergeben, dann gibt das Text-Widget ein falsches Ergebnis zurück. In der Praxis ist das ein seltenes Problem, es kann aber auftreten, zum Beispiel:

```
pack [text .t]
.t insert 1.0 "aaaa\nbbbb\ncccc\nbbbb\naaaa\n"
.t search -regexp -- {(a+|b+\nc+\nb+)+\na+} 1.0
```

findet keinen Treffer, obwohl einer mit 19 Zeichen existiert, der beim ersten „b“ beginnt.

Immer wenn ein möglicher Treffer vollständig in einem anderen enthalten ist, versucht der Befehl search sicherzustellen, dass nur der größere Treffer zurückgegeben wird. Bei rückwärts gerichteten Regexp-Suchen gelingt Tcl das möglicherweise nicht immer, nämlich dann, wenn einem Treffer ein oder mehrere kurze, nicht überlappende Treffer vorausgehen, denen wiederum ein großer Treffer vorausgeht, der sie tatsächlich alle umfasst. Der vom Widget verwendete Suchalgorithmus blickt nicht beliebig weit zurück, um einen möglichen Treffer zu finden, der große Teile des Widgets abdecken könnte. Zum Beispiel:

```
pack [text .t]
.t insert 1.0 "aaaa\nbbbb\nbbbb\nbbbb\nbbbb\n"
.t search -regexp -backward -- {b+\n|a+\n(b+\n)+} end
```

trifft bei „5.0“, während ein wirklich gieriger Treffer bei „1.0“ träfe. Ebenso trifft die Suche, wenn in diesem Fall **-all** hinzugefügt wird, bei „5.0“, „4.0“, „3.0“ und „1.0“, obwohl sie eigentlich nur bei „1.0“ treffen sollte, da dieser Treffer alle anderen umschließt.


[bgerror]: ../tcl/bgerror.md
[break]: ../tcl/break.md
[ConfigWidg]: ../tk-c/ConfigWidg.md
[continue]: ../tcl/continue.md
[GetBitmap]: ../tk-c/GetBitmap.md
[GetColor]: ../tk-c/GetColor.md
[GetFont]: ../tk-c/GetFont.md
[GetInt]: ../tcl-c/GetInt.md
[GetPixels]: ../tk-c/GetPixels.md
[GetRelief]: ../tk-c/GetRelief.md
[options]: options.md
[re_syntax]: ../tcl/re_syntax.md
[regexp]: ../tcl/regexp.md
[tclvars]: ../tcl/tclvars.md
