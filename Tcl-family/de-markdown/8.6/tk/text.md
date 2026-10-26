---
CommandName: text
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

# NAME

text, tk_textCopy, tk_textCut, tk_textPaste - Erstellt und manipuliert 'text'-Hypertext-Bearbeitungswidgets

# ÜBERSICHT

::: {.synopsis} :::
[text]{.cmd} [pathName]{.arg} [options]{.optarg} 
[tk_textCopy]{.cmd} [pathName]{.arg} 
[tk_textCut]{.cmd} [pathName]{.arg} 
[tk_textPaste]{.cmd} [pathName]{.arg} 
:::

# WIDGET-SPEZIFISCHE OPTIONEN

**-autoseparators** (autoSeparators/AutoSeparators)
: Legt einen booleschen Wert fest, der angibt, ob automatisch Trennzeichen in den Rückgängig-Stapel eingefügt werden. Nur bedeutsam, wenn die Option **-undo** true ist.

**-blockcursor** (blockCursor/BlockCursor)
: Legt einen booleschen Wert fest, der angibt, ob der blinkende Einfügecursor als rechteckiger Block in Zeichengröße gezeichnet werden soll. Ist der Wert false (Standard), wird eine dünne vertikale Linie als Einfügecursor verwendet.

**-endline** (endLine/EndLine)
: Legt einen ganzzahligen Zeilenindex fest, der die Zeile des zugrunde liegenden textuellen Datenspeichers angibt, die unmittelbar nach der letzten im Widget enthaltenen Zeile liegen soll. Dadurch kann ein Text-Widget nur einen Teil eines größeren Textes wiedergeben. Statt einer Ganzzahl kann für diese Konfigurationsoption der leere String angegeben werden; das Widget endet dann in der allerletzten Zeile des textuellen Datenspeichers.

**-height** (height/Height)
: Legt die gewünschte Höhe des Fensters in Zeichen der mit **-font** angegebenen Schriftart fest. Muss mindestens eins sein.

**-inactiveselectbackground** (inactiveSelectBackground/Foreground)
: Legt die Farbe fest, die für die Auswahl (Tag **sel**) verwendet wird, wenn das Fenster nicht den Eingabefokus hat. Ist der Wert leer (**{}**), wird keine Auswahl angezeigt, wenn das Fenster nicht den Fokus hat.

**-insertunfocussed** (insertUnfocussed/InsertUnfocussed)
: 


Legt fest, wie der Einfügecursor angezeigt wird, wenn das Widget nicht den Fokus hat. Muss **none** (Standard) sein, d. h. der Cursor wird nicht angezeigt, **hollow** bedeutet eine hohle Box, **solid** eine ausgefüllte Box. **hollow** und **solid** wirken sehr ähnlich, wenn **-blockcursor** false ist.

**-maxundo** (maxUndo/MaxUndo)
: Legt die maximale Anzahl zusammengesetzter Rückgängig-Aktionen auf dem Rückgängig-Stapel fest. Null oder ein negativer Wert bedeuten einen unbegrenzten Stapel.

**-spacing1** (spacing1/Spacing1)
: Fordert zusätzlichen Abstand oberhalb jeder Textzeile im Widget an (beliebige Standardformen für Bildschirmabstände). Bei umbrochenen Zeilen gilt die Option nur für die erste Anzeigezeile. Kann durch **-spacing1** in Tags überschrieben werden.

**-spacing2** (spacing2/Spacing2)
: Gibt bei umbrochenen Zeilen den zusätzlichen Abstand zwischen den Anzeigezeilen an, die eine logische Textzeile darstellen. Der Wert kann in beliebigen Standardformen für Bildschirmabstände angegeben werden. Kann durch **-spacing2** in Tags überschrieben werden.

**-spacing3** (spacing3/Spacing3)
: Fordert zusätzlichen Abstand unterhalb jeder Textzeile an (beliebige Standardformen für Bildschirmabstände). Bei umbrochenen Zeilen gilt die Option nur für die letzte Anzeigezeile. Kann durch **-spacing3** in Tags überschrieben werden.

**-startline** (startLine/StartLine)
: Legt einen ganzzahligen Zeilenindex für die erste Zeile des zugrunde liegenden textuellen Datenspeichers fest, die im Widget enthalten sein soll. Dadurch kann ein Text-Widget nur einen Teil eines größeren Textes wiedergeben. Statt einer Ganzzahl kann der leere String angegeben werden; das Widget beginnt dann in der allerersten Zeile des Datenspeichers.

**-state** (state/State)
: Legt einen von zwei Zuständen für den Text fest: **normal** oder **disabled**. Ist der Text deaktiviert, dürfen keine Zeichen eingefügt oder gelöscht werden und es wird kein Einfügecursor angezeigt, auch wenn der Eingabefokus im Widget liegt.

**-tabs** (tabs/Tabs)
: Legt eine Menge von Tabstopps für das Fenster fest. Der Optionswert ist eine Liste von Bildschirmabständen mit den Positionen der Tabstopps, jeweils relativ zum linken Rand des Widgets (ohne Rahmen, Padding usw.). Jeder Position kann im nächsten Listenelement eines der Schlüsselwörter **left**, **right**, **center** oder **numeric** folgen, die die Ausrichtung des Textes am Tabstopp festlegen. **Left** ist Standard: Der Text nach dem Tabulator wird mit seiner linken Kante am Tabstopp positioniert. **Right** positioniert die rechte Kante, **center** zentriert den Text. **Numeric** positioniert den Dezimalpunkt am Tabstopp; fehlt ein Dezimalpunkt, wird die niederwertigste Ziffer knapp links vom Tabstopp gesetzt; fehlt eine Zahl, wird rechtsbündig am Tabstopp ausgerichtet. Beispiel: "**-tabs {2c left 4c 6c center}**" erzeugt drei Tabstopps im Abstand von zwei Zentimetern; die ersten beiden linksbündig, der dritte zentriert.


Reicht die Tabstopp-Liste nicht für alle Tabs einer Zeile, extrapoliert Tk neue Tabstopps anhand von Abstand und Ausrichtung des letzten Tabstopps. Tab-Abstände müssen strikt positiv und streng wachsend sein (sonst Fehler). Der Wert von **-tabs** kann durch **-tabs** in Tags überschrieben werden.

Ist **-tabs** nicht gesetzt oder eine leere Liste, verwendet Tk Standard-Tabs im Abstand von acht (durchschnittlich breiten) Zeichen. Für anderen Standardabstand, z. B. alle 4 Zeichen: "**-tabs "[expr {4 * [font measure \$font 0]}] left" -tabstyle wordprocessor**".

**-tabstyle** (tabStyle/TabStyle)
: Legt fest, wie der Zusammenhang zwischen Tabstopps einer Zeile und Tabulatoren im Text dieser Zeile interpretiert wird. Der Wert muss **tabular** (Standard) oder **wordprocessor** sein. Tabs werden beim Durchlaufen des Textes ausgewertet. Bei **tabular** wird der *n*. Tabulator der Zeile dem *n*. Tabstopp der Zeile zugeordnet. Liegt die x-Koordinate des Tabulators rechts vom *n*. Tabstopp, wird als Fallback ein einzelnes Leerzeichen eingefügt. Bei **wordprocessor** verwendet jeder Tabulator den ersten Tabstopp rechts der bereits gesetzten Zeichen. **-tabstyle** kann durch Tag-Optionen überschrieben werden.

**-undo** (undo/Undo)
: Legt einen booleschen Wert fest, ob der Rückgängig-Mechanismus aktiv ist.

**-width** (width/Width)
: Legt die gewünschte Fensterbreite in Zeichen der mit **-font** angegebenen Schriftart fest. Hat die Schrift keine einheitliche Breite, wird die Breite der Zeichen „0“ für die Umrechnung verwendet.

**-wrap** (wrap/Wrap)
: Legt fest, wie mit Zeilen umgegangen wird, die zu lang für eine Anzeigezeile sind. Der Wert muss **none**, **char** oder **word** sein. **none**: Jede Textzeile erscheint als genau eine Bildschirmzeile; überzählige Zeichen werden nicht angezeigt. In den anderen Modi wird bei Bedarf umgebrochen. **char** erlaubt Umbrüche nach jedem Zeichen; **word** nur an Wortgrenzen.


# BESCHREIBUNG

Der Befehl **text** erstellt ein neues Fenster (Argument *pathName*) und macht es zu einem Text-Widget. Weitere Optionen können in der Befehlszeile oder der Optionsdatenbank gesetzt werden (Hintergrundfarbe, Relief usw.). Der Befehl **text** gibt den Pfadnamen des neuen Fensters zurück.

Ein Text-Widget zeigt eine oder mehrere Textzeilen an und erlaubt deren Bearbeitung. Es unterstützt vier Arten von Annotationen: Tags, Marken, eingebettete Fenster und eingebettete Bilder. Tags erlauben unterschiedliche Darstellung (Schrift, Farben). Tcl-Befehle können Tags zugeordnet werden, sodass Skripte bei Tastendrücken oder Mausklicks in bestimmten Bereichen ausgeführt werden. Siehe **TAGS** unten.

Die zweite Annotationsform sind schwebende Markierungen im Text, „Marken“. Marken merken sich interessante Positionen während der Bearbeitung. Siehe **MARKEN** unten.

Die dritte Form erlaubt beliebige eingebettete Fenster. Siehe **EINGEBETTETE FENSTER** unten.

Die vierte Form erlaubt eingebettete Tk-Bilder. Siehe **EINGEBETTETE BILDER** unten.

Das Text-Widget hat einen eingebauten Rückgängig-/Wiederholen-Mechanismus. Siehe **DER RÜCKGÄNGIG-MECHANISMUS** unten.

Peer-Widgets sind weitere Text-Widgets mit denselben zugrunde liegenden Daten (Text, Marken, Tags, Bilder usw.). Siehe **PEER-WIDGETS** unten.

# INDIZES

Viele Widget-Befehle für Text-Widgets nehmen einen oder mehrere Indizes als Argumente. Ein Index ist eine Zeichenkette, die eine bestimmte Stelle im Text bezeichnet, z. B. Einfügeposition oder Endpunkt eines zu löschenden Bereichs. Indizes haben die Syntax

```
base modifier modifier modifier ...
```

*wobei* *base* den Ausgangspunkt angibt und die *modifier* den Index davon aus justieren (z. B. ein Zeichen vor oder zurück). Jeder Index muss eine *base* enthalten; *modifier* sind optional. Die meisten Modifier (siehe unten) erlauben einen optionalen Submodifier. Gültige Submodifier sind **any** und **display**. Ist der Submodifier abgekürzt, muss Leerzeichen folgen; sonst kann Submodifier und *modifier* ohne Leerzeichen aneinander stehen. Typischerweise bewirkt **display**, dass der folgende *modifier* sichtbare bzw. nicht ausgeblendete Einheiten statt logischer Einheiten meint; Details je nach Fall unten. *count* in einem Modifier kann positiv oder negativ sein; „*base* - -3 lines“ ist gültig (äquivalent zu „*base* +3lines“).

Die *base* eines Index muss eine der folgenden Formen haben:

*line*__.__*char*
: Bezeichnet das *char*. Zeichen in Zeile *line*. Zeilen werden ab 1 nummeriert (wie bei anderen UNIX-Programmen). Innerhalb einer Zeile beginnen Zeichen bei 0. Ist *char* **end**, bezeichnet das den Zeilenumbruch am Zeilenende.

**@**_x_**,**_y_
: Bezeichnet das Zeichen unter dem Pixel mit den Koordinaten *x* und *y* im Textfenster.

**end**
: Bezeichnet das Textende (das Zeichen unmittelbar nach dem letzten Zeilenumbruch).

*mark*
: Bezeichnet das Zeichen unmittelbar nach der Marke *mark* (siehe **MARKEN**).

*tag*__.first__
: Erstes mit *tag* markiertes Zeichen. Fehler, wenn derzeit kein Zeichen dieses Tags hat.

*tag*__.last__
: Zeichen unmittelbar nach dem letzten mit *tag* markierten Zeichen. Fehler, wenn derzeit kein Zeichen dieses Tags hat.

*pathName*
: Position des eingebetteten Fensters *pathName*. Fehler, wenn kein solches Fenster existiert.

*imageName*
: Position des eingebetteten Bildes *imageName*. Fehler, wenn kein solches Bild existiert.


Könnte die *base* mehreren Formen entsprechen (z. B. gleicher Wert für *mark* und *imageName*), hat die frühere Form in der obigen Liste Vorrang. Folgen Modifier der Basis, muss jeder eine der unten genannten Formen haben. Schlüsselwörter wie **chars** und **wordend** dürfen abgekürzt werden, solange die Abkürzung eindeutig ist.

**+** *count* ?*submodifier*? **chars**
: Verschiebt den Index um *count* Zeichen vorwärts, ggf. auf spätere Zeilen. Gibt es nach dem aktuellen Index weniger als *count* Zeichen, wird der letzte Index im Text gesetzt. Leerzeichen um *count* sind optional. Mit Submodifier **display** werden ausgeblendete Zeichen übersprungen. Mit **any** werden alle gezählt. Aus historischen Gründen zählt ohne Submodifier die Einheit „Indexposition“ (siehe **INDIZES**). Das kann sich in einer künftigen Hauptversion ändern; für Indexzählungen **indices** verwenden, wo möglich.

**-** *count* ?*submodifier*? **chars**
: Verschiebt den Index um *count* Zeichen rückwärts, ggf. auf frühere Zeilen. Gibt es vor dem aktuellen Index weniger als *count* Zeichen, wird der erste Index (1.0) gesetzt. Leerzeichen um *count* sind optional. Mit **display** werden ausgeblendete Zeichen übersprungen. Mit **any** werden alle gezählt. Ohne Submodifier zählt aus historischen Gründen die Einheit „Indexposition“ (siehe **INDIZES**); künftig kann sich das ändern — **indices** bevorzugen.

**+** *count* ?*submodifier*? **indices**
: Verschiebt den Index um *count* Indexpositionen vorwärts. Eine Indexposition ist ein Zeichen oder ein eingebettetes Bild/Fenster. Gibt es weniger als *count* Positionen danach, wird die letzte gesetzt. Mit **display** werden ausgeblendete Positionen übersprungen. Mit **any** (oder ohne Submodifier) werden alle gezählt.

**-** *count* ?*submodifier*? **indices**
: Verschiebt den Index um *count* Indexpositionen rückwärts. Gibt es weniger als *count* Positionen davor, wird 1.0 gesetzt. Mit **display** werden ausgeblendete Positionen übersprungen. Mit **any** (oder ohne Submodifier) werden alle gezählt.

**+** *count* ?*submodifier*? **lines**
: Verschiebt den Index um *count* Zeilen vorwärts bei gleicher Zeichenposition. Gibt es weniger Zeilen danach, wird dieselbe Position in der letzten Zeile verwendet; reicht die Zeile nicht, die letzte Zeichenposition (Zeilenumbruch). Mit **display** zählt jede sichtbare Anzeigezeile; mit **any** oder ohne Submodifier jede logische Zeile (unabhängig vom Umbruch). Ohne Umbruch sind beide gleichwertig.

**-** *count* ?*submodifier*? **lines**
: Verschiebt den Index um *count* logische Zeilen rückwärts bei gleicher Zeichenposition. Gibt es weniger Zeilen davor, wird dieselbe Position in der ersten Zeile verwendet; reicht die Zeile nicht, die letzte Zeichenposition. Mit **display** zählt jede Anzeigezeile; mit **any** oder ohne Submodifier jede logische Zeile. Ohne Umbruch gleichwertig.

?*submodifier*? **linestart**
: Setzt den Index auf den ersten Index der Zeile. Mit **display** der Anzeigezeile, sonst der logischen Zeile.

?*submodifier*? **lineend**
: Setzt den Index auf den letzten Index der Zeile (Zeilenumbruch). Mit **display** der Anzeigezeile, sonst der logischen Zeile.

?*submodifier*? **wordstart**
: Erstes Zeichen des Wortes am aktuellen Index. Ein Wort besteht aus Buchstaben, Ziffern oder Unterstrichen oder ist ein einzelnes anderes Zeichen. Mit **display** nur nicht ausgeblendete Zeichen, sonst alle.

?*submodifier*? **wordend**
: Zeichen unmittelbar nach dem letzten des Wortes am aktuellen Index. Steht der Index bereits auf dem letzten Textzeichen, bleibt er unverändert. Mit **display** nur nicht ausgeblendete Zeichen, sonst alle.


Stehen mehrere Modifier aneinander, werden sie von links nach rechts angewendet. Beispiel: „**end - 1 chars**“ ist das vorletzte Zeichen; „**insert wordstart - 1 c**“ das Zeichen vor dem ersten des Worts am Einfügecursor. Nach jedem Schritt wird der Index auf Gültigkeit im Widget beschränkt; „**1.0 -1c +1c**“ ergibt „**2.0**“.

Führen Modifier zu Änderungen über Anzeigezeilen, Anzeigezeichen oder Anzeigeindizes und verweist die *base* auf einen Index innerhalb eines ausgeblendeten Tags, gilt die *base* als äquivalent zum ersten folgenden nicht ausgeblendeten Index.

# TAGS

Die erste Annotationsform in Text-Widgets ist ein Tag. Ein Tag ist eine Zeichenkette, die mit einigen Textzeichen verknüpft ist. Tags dürfen beliebige Zeichen enthalten; am besten vermeidet man Leerzeichen, **+** und **-**, da diese in Indizes Sonderbedeutung haben und solche Tags nicht als Indizes verwendet werden können. Beliebig viele Tags können Zeichen zugeordnet sein. Ein Tag kann ein Zeichen, einen Bereich oder mehrere Bereiche betreffen. Ein Zeichen kann beliebig viele Tags haben.

Unter Tags gilt eine Prioritätsreihenfolge, die bei tag-bezogenen Funktionen unten verwendet wird. Beim Definieren (Zuordnung zu Zeichen, Anzeigeoptionen, Bindings) erhält ein Tag höhere Priorität als alle bestehenden. Die Reihenfolge kann mit „*pathName* **tag raise**“ und „*pathName* **tag lower**“ geändert werden.

Tags haben drei Zwecke. Erstens steuern sie die Darstellung. Standardmäßig gelten **-background**, **-font** und **-foreground** des Widgets. Über „*pathName* **tag configure**“ können einzelnen Tags Anzeigeoptionen zugeordnet werden; diese überschreiben den Standard. Für Tags werden derzeit folgende Optionen unterstützt:

**-background** *color*
: *Color* legt die Hintergrundfarbe für mit dem Tag verknüpfte Zeichen fest (Formen von **Tk_GetColor**).

**-bgstipple** *bitmap*
: *Bitmap* ist ein Stippelmuster für den Hintergrund (**Tk_GetBitmap**). Fehlt *bitmap* oder ist es leer, wird vollflächig gefüllt.

**-borderwidth** *pixels*
: *Pixels* ist die Rahmenbreite (**Tk_GetPixels**), zusammen mit **-relief** für das gewünschte Erscheinungsbild.

**-elide** *boolean*
: *Elide* gibt an, ob Daten ausgeblendet werden. Ausgeblendete Daten (Zeichen, Bilder, Fenster usw.) werden nicht angezeigt und nehmen keinen Platz ein, verhalten sich sonst normal.

**-fgstipple** *bitmap*
: *Bitmap* ist ein Stippelmuster für Vordergrund (Text, Unterstreichungen). Fehlt *bitmap* oder ist es leer, wird vollflächig gefüllt.

**-font** *fontName*
: *FontName* ist der Schriftname (**Tk_GetFont**).

**-foreground** *color*
: *Color* legt die Vordergrundfarbe fest (**Tk_GetColor**).

**-justify** *justify*
: Hat das erste nicht ausgeblendete Zeichen einer Anzeigezeile ein Tag mit dieser Option, bestimmt *justify* die Ausrichtung (**left**, **right**, **center**). Bei Umbruch gilt pro Anzeigezeile das erste nicht ausgeblendete Zeichen.

**-lmargin1** *pixels*
: Hat das erste nicht ausgeblendete Zeichen einer Textzeile ein Tag mit dieser Option, gibt *pixels* den linken Einzug an (Standardformen für Bildschirmabstände). Bei Umbruch nur für die erste Anzeigezeile; **-lmargin2** für folgende.

**-lmargin2** *pixels*
: Gilt für die erste nicht ausgeblendete Zeichen einer Anzeigezeile, die nicht die erste ihrer Textzeile ist (Umbruch), *pixels* als linker Einzug. Nur bei aktiviertem Umbruch für die zweite und weitere Anzeigezeilen.

**-lmargincolor** *color*
: *Color* ist die Hintergrundfarbe in Bereichen ohne Zeichen wegen **-lmargin1** oder **-lmargin2**. Fehlt *color* oder ist es leer, gilt **-background** des Tags oder des Widgets.

**-offset** *pixels*
: *Pixels* verschiebt die Text-Baseline vertikal (z. B. positiv für Hochstellung, negativ für Tiefstellung).

**-overstrike** *boolean*
: Gibt an, ob ein horizontaler Strich durch die Zeichenmitte gezeichnet wird (**Tcl_GetBoolean**).

**-overstrikefg** *color*
: *Color* für die Durchstreichung. Fehlt *color* oder ist es leer, gilt **-foreground** des Tags.

**-relief** *relief*
: *Relief* für den Rahmen (**Tk_GetRelief**), zusammen mit **-borderwidth**.

**-rmargin** *pixels*
: Hat das erste nicht ausgeblendete Zeichen einer Anzeigezeile ein Tag mit dieser Option, *pixels* als rechter Rand bis zum Fensterrand. Nur bei Umbruch; pro Anzeigezeile das erste nicht ausgeblendete Zeichen.

**-rmargincolor** *color*
: *Color* für Hintergrund in Bereichen ohne Zeichen wegen **-rmargin**. Fehlt *color* oder ist es leer, gilt **-background** des Tags oder des Widgets.

**-selectbackground** *color*
: *Color* für den Hintergrund ausgewählter Elemente. Fehlt *color* oder ist es leer, gilt **-background** des Tags.

**-selectforeground** *color*
: *Color* für den Vordergrund ausgewählter Elemente. Fehlt *color* oder ist es leer, gilt **-foreground** des Tags.

**-spacing1** *pixels*
: Zusätzlicher Abstand oberhalb jeder Textzeile. Bei Umbruch nur für die erste Anzeigezeile.

**-spacing2** *pixels*
: Bei Umbruch zusätzlicher Abstand zwischen Anzeigezeilen einer Textzeile.

**-spacing3** *pixels*
: Zusätzlicher Abstand unterhalb jeder Textzeile. Bei Umbruch nur für die letzte Anzeigezeile.

**-tabs** *tabList*
: *TabList* wie **-tabs** des Widgets. Gilt nur, wenn sie für das erste nicht ausgeblendete Zeichen der Anzeigezeile gilt. Leerer String hebt die Option auf. Nicht-leerer String mit leerer Liste (z. B. **-tags\0{\0}**) fordert Standard-Tabs à 8 Zeichen wie bei **-tabs** des Widgets.

**-tabstyle** *style*
: *Style* ist *tabular* oder *wordprocessor*. Gilt nur für das erste nicht ausgeblendete Zeichen der Anzeigezeile. Leerer String hebt die Option auf.

**-underline** *boolean*
: Unterstreichung ja/nein (**Tcl_GetBoolean**).

**-underlinefg** *color*
: *Color* für die Unterstreichung. Fehlt *color* oder ist es leer, gilt **-foreground** des Tags.

**-wrap** *mode*
: *Mode* für zu breite Zeilen (**none**, **char**, **word** wie beim Widget). Gilt nur für das erste nicht ausgeblendete Zeichen der Anzeigezeile und überschreibt **-wrap** des Widgets.


Hat ein Zeichen mehrere Tags mit widersprüchlichen Anzeigeoptionen, gilt der Tag mit höchster Priorität. Ist eine Option für einen Tag nicht gesetzt oder leer, wird sie nicht verwendet; die nächsthöhere Priorität gilt. Spezifiziert kein Tag eine Option, gilt der Widget-Standard.

Zweitens dienen Tags Ereignis-Bindings. Bindings können einem Tag wie einer Widget-Klasse zugeordnet werden: Bei bestimmten X-Ereignissen auf markierten Zeichen wird ein Tcl-Befehl ausgeführt. So lassen sich Hypertext-ähnliche Verhalten realisieren; siehe „*pathName* **tag bind**“ unten. Tag-Bindings werden von allen Peer-Widgets geteilt (einschließlich **sel**).

Drittens verwalten Tags die Auswahl. Siehe **DIE AUSWAHL** unten. Außer **sel** teilen alle Tags alle Peer-Widgets und sind von jedem gleich bearbeitbar. **sel** existiert in jedem Peer separat (Bindings zu **sel** werden geteilt).

# MARKEN

Die zweite Annotationsform sind Marken. Marken merken sich bestimmte Stellen im Text. Sie ähneln Tags (Namen, Bezug auf Stellen), sind aber keinem Zeichen zugeordnet, sondern der Lücke zwischen zwei Zeichen. Eine Marke hat jeweils nur eine Position. Werden benachbarte Zeichen gelöscht, bleibt die Marke mit neuen Nachbarn. Werden Zeichen mit einem Tag gelöscht, entfällt die Tag-Zuordnung. Marken werden mit „*pathName* **mark**“ bearbeitet; ihre Position ist als Index mit dem Markennamen abfragbar.

Jede Marke hat eine „Schwerkraft“ (**left** oder **right**), die bestimmt, was bei Einfügen am Markenpunkt passiert. Bei **left** bleibt die Marke links vom eingefügten Text; bei **right** erscheint neuer Text links von der Marke (Marke bleibt ganz rechts). Standard ist **right**.

Der Namensraum der Marken ist getrennt von dem der Tags: derselbe Name kann für Marke und Tag verwendet werden, bezeichnet aber Unterschiedliches.

Zwei Marken sind besonders: **insert** gehört zum Einfügecursor (siehe **DER EINFÜGECURSOR**); **current** zum der Maus nächsten Zeichen und folgt Maus und Textänderungen (Ausnahme: bei gedrückter Maustaste keine Aktualisierung bis alle Tasten losgelassen sind). Diese beiden dürfen nicht gelöscht werden. Alle anderen Marken teilen Peer-Widgets und sind von jedem Peer gleich bearbeitbar.

# EINGEBETTETE FENSTER

Die dritte Annotationsform sind eingebettete Fenster. Jedes eingebettete Fenster wird an einer Textstelle angezeigt. Beliebig viele sind möglich; jedes Widget kann eingebettet werden (Geometrie-Regeln: Textfenster ist Eltern- oder Vorfahren-Widget).

Die Position wird bei Textänderung und Scrollen aktualisiert; beim Betreten/Verlassen des sichtbaren Bereichs wird gemappt/unmapped. Jedes Fenster belegt eine Index-Einheit und ist über Fensternamen oder Indexposition ansprechbar. Wird der Textbereich gelöscht, wird das Fenster zerstört; dasselbe gilt beim Löschen des gesamten Text-Widgets.

Ausblenden unmittelbar nach Planung via *pathName* **window create** *index* **-create** verhindert die effektive Erstellung. Einblenden löst das Erstellungsskript aus. Nach Zerstörung eines ausgeblendeten Fensters erfolgt keine automatische Neuerstellung.

Beim Hinzufügen mit *pathName* **window create** können Optionen gesetzt und später mit *pathName* **window configure** geändert werden. Unterstützt werden:

**-align** *where*
: Ist das Fenster niedriger als die Zeile, bestimmt *where* die vertikale Position: **top** (Oberkante an Zeilenoberkante), **center** (zentriert), **bottom** (Unterkante an Zeilenunterkante), **baseline** (Unterkante an Zeilen-Baseline).

**-create** *script*
: Tcl-Skript zur Fenstererstellung. Ohne **-window** wird es vor der Anzeige ausgewertet. *Script* muss ein Fenster erzeugen und dessen Namen zurückgeben. Vor der Auswertung: *%W* → Name des Text-Widgets, *%%* → *%*. Wird das Fenster gelöscht, wird *script* bei der nächsten Anzeige erneut ausgewertet.

**-padx** *pixels*
: Zusätzlicher Abstand links und rechts (übliche Formen für Bildschirmabstände).

**-pady** *pixels*
: Zusätzlicher Abstand oben und unten.

**-stretch** *boolean*
: Soll ein zu niedriges Fenster vertikal auf Zeilenhöhe gestreckt werden? Mit **-pady** bleibt der gewünschte Abstand erhalten.

**-window** *pathName*
: Name des anzuzeigenden Fensters. Späterer leerer **-window**-Wert löscht das Widget nicht, sondern hebt nur die Verknüpfung auf. Bei mehreren Peers ist **-create** meist einfacher.


# EINGEBETTETE BILDER

Die vierte Annotationsform sind eingebettete Bilder. Jedes Bild wird an einer Textstelle angezeigt. Beliebig viele sind möglich; dasselbe Bild kann mehrfach eingebettet sein.

Die Position wird bei Textänderung und Scrollen aktualisiert. Jedes Bild belegt eine Index-Einheit und ist über Indexposition oder den bei *pathName* **image create** vergebenen Namen ansprechbar. Wird der Textbereich gelöscht, verschwindet diese Bildkopie vom Bildschirm.

Ausblenden unmittelbar nach Planung via *pathName* **image create** *index* **-create** verhindert die Erstellung. Einblenden löst das Erstellungsskript aus. Nach Zerstörung kein automatisches Neuerstellen.

Bei *pathName* **image create** wird ein für diese Instanz eindeutiger Name zurückgegeben (**-name**, siehe unten; sonst **-image**). Ist *imageName* bereits vergeben, wird **#**_nn_ angehängt (*nn* beliebig). Der Name bleibt nach Zuweisung unverändert, auch wenn **-image** oder **-name** per *pathName* **image configure** geändert werden.

Optionen können bei der Erstellung gesetzt und mit *pathName* **image configure** geändert werden:

**-align** *where*
: Ist das Bild niedriger als die Zeile: **top**, **center**, **bottom** oder **baseline** (wie bei eingebetteten Fenstern).

**-image** *image*
: Name des Tk-Bildes. Ist *image* ungültig, Fehler.

**-name** *ImageName*
: Referenzname im Text-Widget. Fehlt er, gilt der Tk-Bildname. Bei Kollision *#nn* wie oben.

**-padx** *pixels*
: Zusätzlicher Abstand links und rechts.

**-pady** *pixels*
: Zusätzlicher Abstand oben und unten.


# DIE AUSWAHL

Die Auswahl wird über Tags realisiert. Ist **-exportselection** true, wird der **sel**-Tag mit der Auswahl verknüpft:

1. Werden Zeichen mit **sel** markiert, beansprucht das Text-Widget die Auswahl.

2. Abfragen der Auswahl liefert alle Zeichen mit **sel**.

3. Wird die Auswahl von einer anderen Anwendung oder einem anderen Fenster übernommen, wird **sel** von allen Zeichen entfernt.

4. Bei jeder Änderung des **sel**-Bereichs wird **<\<Selection>>** erzeugt, ggf. auch wenn die Auswahl betroffen, aber nicht geändert ist. Mehrere Änderungen vor der Ereignisverarbeitung können mehrere Ereignisse mit gleicher sichtbarer Auswahl ergeben.


**sel** wird beim Erstellen automatisch definiert und darf nicht mit „*pathName* **tag delete**“ gelöscht werden. **-selectbackground**, **-selectborderwidth** und **-selectforeground** des Widgets sind an **-background**, **-borderwidth** und **-foreground** von **sel** gekoppelt; Änderungen spiegeln sich gegenseitig. Ohne Fokus gilt **-inactiveselectbackground** statt **-selectbackground**. So lässt sich **sel** für Vorder- und Hintergrundfenster steuern oder bei leerem **-inactiveselectbackground** ausblenden. Jedes Peer-Widget hat ein eigenes **sel**.

# DER EINFÜGECURSOR

Die Marke **insert** ist besonders. Sie wird automatisch erzeugt und darf nicht mit „*pathName* **mark unset**“ entfernt werden. **insert** ist die Einfügeposition; der Cursor wird dort gezeichnet, wenn das Widget den Eingabefokus hat.

# DIE MODIFIED-FLAGGE

Das Widget kann Änderungen über die modified-Flagge verfolgen. Einfügen oder Löschen setzt sie. Abfrage, Setzen und Löschen sind programmatisch möglich. Bei Zustandsänderung wird **<\<Modified>>** erzeugt. Siehe *pathName* **edit modified**.

# DER RÜCKGÄNGIG-MECHANISMUS

Bei **-undo** true zeichnet das Widget jede Einfüge- und Löschaktion auf einem Stapel auf (unbegrenzt).

Trennzeichen („separators“) gruppieren Aktionen zu zusammengesetzten Bearbeitungen. Rückgängig macht alles zwischen zwei Trennzeichen; die Aktionen wandern auf den Wiederholen-Stapel. Neuerungen auf dem Rückgängig-Stapel leeren den Wiederholen-Stapel. Beide Stapel können geleert werden.

Bei **-autoseparators** true werden Trennzeichen automatisch eingefügt; auch manuell möglich. Steht oben bereits eines, wird kein zweites eingefügt — zwei Trennzeichen sind stets durch mindestens eine Einfüge- oder Löschaktion getrennt.

**<\<UndoStack>>** wird erzeugt, wenn Rückgängig- oder Wiederholen-Stapel leer oder nicht mehr leer wird.

Der Mechanismus ist mit der modified-Flagge gekoppelt: Rückgängig/Wiederholen kann zum unveränderten Zustand führen. Die automatische Kopplung gilt nicht, wenn der Benutzer die Flagge gesetzt hat, bis sie zurückgesetzt wurde.

Siehe *pathName* **edit** unten.

# PEER-WIDGETS

Das Text-Widget speichert Zeileninhalt, Marken, Tags, Bilder, Fenster und den Rückgängig-Stapel separat.

Der Speicher ist nicht direkt zugreifbar (nur über ein Text-Widget), aber mehrere Widgets können dieselben Daten unterschiedlich darstellen — Peer-Text-Widgets.

Änderungen (Text, Farben, Bilder, Marken, Tags) in einem Widget spiegeln sich in allen Peers.

Daten und Markup werden geteilt, mit Ausnahmen: **sel** pro Peer unterschiedlich setzbar/konfigurierbar; **insert** und **current** pro Peer, andere Marken geteilt; eingebettete Fenster nicht teilbar — **-window** pro Peer (**-create** empfohlen); Konfiguration (z. B. **-font**) pro Peer, außer **-undo**, **-maxundo**, **-autoseparators** (Rückgängig/Wiederholen und modified geteilt).

Ein Peer muss nicht alle Zeilen enthalten; beim Erstellen kann ein Zeilenbereich (z. B. 52–125) angegeben werden. Der Bereich wächst/schrumpft mit Einfügen/Löschen. Nur ganze Zeilen werden angezeigt. Schrumpft der Inhalt auf nichts, sind keine neuen Zeilen einfügbar — leere Hülle ohne Inhalt (ohne manuelle **-startline**/**-endline**-Anpassung). Indizes laufen dennoch von „1.0“ bis „end“, beziehen sich aber auf die Teilmenge; *peerName* **index end** und *peerName* **tag ranges** können zwischen Peers abweichen. **-startline** und **-endline** steuern den Umfang.

Peers sind gleichberechtigt: Löschen des „ursprünglichen“ Widgets betrifft andere Peers nicht.

Siehe *pathName* **peer** unten.

# ASYNCHRONE AKTUALISIERUNG DER ZEILENHÖHEN

Für Reaktionsfähigkeit berechnet das Widget Zeilenmetriken (Höhen in Pixeln) asynchron. Manche Befehle liefern daher falsche Ergebnisse, wenn die Berechnung noch läuft — u. a. *pathName* **count -ypixels** und *pathName* **yview**.

Aus Performance-Gründen warten diese Befehle nicht immer auf Abschluss; in vielen Fällen genügt eine ungefähre Antwort.

Bei Bedarf an Genauigkeit (und Geometrie-Verwaltung): *pathName* **sync** und *pathName* **pendingsync**.

**<\<WidgetViewSync>>** tritt auf, wenn Zeilenhöhen veraltet sind, und erneut bei Synchronität. Das Detail-Feld (%d) ist true (synchron) oder false.

*pathName* **sync**, *pathName* **pendingsync** und **<\<WidgetViewSync>>** gelten pro Widget unabhängig von Peers.

Beispiele:

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
\&set ::yud($w) 1
\&# any other update action here...
}
# runtime, synchronously wait for up-to-date line metrics (GUI responsive)
$w sync -command [list updateaction $w]
vwait yud($w)
$w yview moveto $fraction

## Example 4:
# init
set todo($w) {}
proc updateaction w {
\&foreach cmd $::todo($w) {uplevel #0 $cmd}
\&set todo($w) {}
}
# runtime
lappend todo($w) [list $w yview moveto $fraction]
$w sync -command [list updateaction $w]

## Example 5:
# init
set todo($w) {}
bind $w <<WidgetViewSync>> {
\&if {%d} {
\&\&foreach cmd $todo(%W) {eval $cmd}
\&\&set todo(%W) {}
\&}
}
# runtime
if {![$w pendingsync]} {
\&$w yview moveto $fraction
} else {
\&lappend todo($w) [list $w yview moveto $fraction]
}
```

# WIDGET-BEFEHL

Der Befehl **text** erstellt einen neuen Tcl-Befehl mit demselben Namen wie der Pfad des Textfensters. Er ruft verschiedene Widget-Operationen auf. Allgemeine Form:

```
pathName option ?arg arg ...?
```

*PathName* ist der Befehlsname, identisch mit dem Widget-Pfad. *Option* und die *arg*s bestimmen das Verhalten. Für Text-Widgets sind folgende Befehle möglich:

*pathName* **bbox** *index*
: Gibt eine Liste mit vier Elementen zurück, die den Bildschirmbereich des Zeichens bei *index* beschreiben: x- und y-Koordinate der oberen linken Ecke sowie Breite und Höhe. Ist das Zeichen nur teilweise sichtbar, gilt nur der sichtbare Teil. Ist es unsichtbar, leere Liste.

*pathName* **cget** *option*
: Aktueller Wert der Konfigurationsoption *option* (alle vom Befehl **text** akzeptierten Werte).

*pathName* **compare** *index1 op index2*
: Vergleicht *index1* und *index2* mit dem Relationoperator *op*; 1 wenn erfüllt, sonst 0. *Op* ist <, <=, ==, >=, > oder !=. Bei == gleiches Zeichen; bei < steht *index1* vor *index2* usw.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Abfrage oder Änderung der Konfiguration. Ohne *option* Liste aller Optionen (**Tk_ConfigureInfo**). *option* ohne *value*: Beschreibung dieser Option. *option-value*-Paare: setzen und leeren String zurück. *Option* wie beim Befehl **text**.

*pathName* **count** ?*options*? *index1 index2*
: Zählt relevante Einheiten zwischen zwei Indizes. Liegt *index1* nach *index2*, negatives Ergebnis (für jede Option). Die gezählten Einheiten hängen von den Optionen ab. Ergebnis: Liste von Ganzzahlen, je eine pro Zähloption. Gültig: **-chars**, **-displaychars**, **-displayindices**, **-displaylines**, **-indices**, **-lines**, **-xpixels**, **-ypixels**. Standard: **-indices**. Zusätzlich **-update** als Modifier: bei gesetztem Wert (und Geometrie-Verwaltung) werden veraltete Daten neu berechnet — derzeit vor allem für **-ypixels** (ohne **-update** Cache pro Zeile). **-update** ist veraltet zugunsten von *pathName* **sync**, *pathName* **pendingsync** und **<\<WidgetViewSync>>**. Interpretation:

**-chars**
: alle Zeichen, ausgeblendet oder nicht; keine eingebetteten Fenster/Bilder.

**-displaychars**
: alle nicht ausgeblendeten Zeichen.

**-displayindices**
: alle nicht ausgeblendeten Zeichen, Fenster und Bilder.

**-displaylines**
: Anzeigezeilen (je Umbruch +1) von der Zeile des ersten Index bis vor die Anzeigezeile des zweiten; auf derselben Anzeigezeile: 0. Nur sichtbare Abschnitte.

**-indices**
: Zeichen und eingebettete Fenster/Bilder (alles in Index-Raum), ausgeblendet oder nicht.

**-lines**
: logische Zeilen (ohne Umbruch) von der Zeile des ersten Index bis vor die des zweiten; auf derselben Zeile: 0; auch ausgeblendete Zeilen.

**-xpixels**
: horizontale Pixel vom ersten Pixel des ersten Index bis vor den des zweiten. Gesamtbreite ohne Umbruch: längste Zeile finden, dann „.text count -xpixels "\${line}.0" "\${line}.0 lineend"“.

**-ypixels**
: vertikale Pixel analog; auf derselben Anzeigezeile: 0. Gesamthöhe: „.text count -ypixels 1.0 end“; aktuell: „.text count -update -ypixels 1.0 end“.

    Rückgabe: positive oder negative Ganzzahl pro Option; mehrere Optionen → Liste. „.text count -xpixels -ypixels 1.3 4.5“ ist gültig und liefert zwei Elemente.

*pathName* **debug** ?*boolean*?
: Ist *boolean* gesetzt, muss es ein von Tcl_GetBoolean akzeptierter Wahrheitswert sein. Bei true werden interne Konsistenzprüfungen im B-Baum-Code aktiviert, bei false deaktiviert. Rückgabe: leerer String. Ohne *boolean*: **on** oder **off**. Ein Schalter gilt für alle Text-Widgets. Bei großen Texten kann es spürbar langsamer werden.
    Bei aktiviertem Debugging setzen Zeichenroutinen **tk_textRedraw** und **tk_textRelayout** auf die Listen neu gezeichneter Indizes (Tk-Testsuite).

*pathName* **delete** *index1* ?*index2 ...*?
: Löscht einen Zeichenbereich. Mit *index1* und *index2*: von *index1* bis vor *index2* (Zeichen bei *index2* bleibt). Liegt *index2* nicht nach *index1*, nichts gelöscht. Ohne *index2*: ein Zeichen bei *index1*. Löschungen, die den abschließenden Zeilenumbruch entfernen würden, werden angepasst; beim Löschen bis Textende auch der Zeilenumbruch davor. Leerer String. Mehrere Indexpaare: mehrere Bereiche; zuerst Gültigkeitsprüfung, sortiert, Löschung von hinten nach vorne gegen Indexverschiebung. Gleicher Start: längster Bereich. Überlappung: Zusammenführung ohne Löschen außerhalb der Bereiche.

*pathName* **dlineinfo** *index*
: Fünf Elemente für die Anzeigezeile mit *index*: x, y, Breite, Höhe, Baseline-Position (Pixel). Bei **none** und überstehender Zeile: gesamte Zeile inkl. unsichtbarer Teile. Kürzere Zeile: nur belegter Teil. Unsichtbare Anzeigezeile: leere Liste.

*pathName* **dump** ?*switches*? *index1* ?*index2*?
: Inhalt von *index1* bis vor *index2* inkl. Text sowie Marken, Tags und eingebettete Fenster. Ohne *index2*: ein Zeichen nach *index1*. Format: *key1 value1 index1 key2 value2 index2* ... Mögliche *key*: **text**, **mark**, **tagon**, **tagoff**, **image**, **window**; *value* entsprechend; *index* Startposition. Schalter:

**-all**
: alles (Standard).

**-command** *command*
: statt Rückgabe *command* pro Element mit angehängten *key*, *value*, *index*.

**-image**
: Bilder einbeziehen.

**-mark**
: Marken einbeziehen.

**-tag**
: Tag-Übergänge als **tagon**/**tagoff**.

**-text**
: Text bis zum nächsten Element oder *index2*; kein Textelement über Zeilenumbrüche; mehrzeiliger Block ohne Marken/Tags als Segmente mit Zeilenumbruch im Wert.

**-window**
: Fenster; Wert ist Tk-Pfadname, oder leer wenn noch nicht erstellt (**-create**); dann Abfrage per Index.


*pathName* **edit** *option* ?*arg arg ...*?
: Steuert Rückgängig-Mechanismus und modified-Flagge. Verhalten hängt von *option* ab:

*pathName* **edit canredo**
: true wenn Wiederholen möglich (Wiederholen-Stapel nicht leer), sonst false.

*pathName* **edit canundo**
: true wenn Rückgängig möglich (Rückgängig-Stapel nicht leer), sonst false.

*pathName* **edit modified** ?*boolean*?
: Ohne *boolean*: modified-Flagge. insert, delete, edit undo/redo oder der Benutzer setzen/löschen sie. Mit *boolean*: setzen auf *boolean*.

*pathName* **edit redo**
: Bei **-undo** true: letzte rückgängig gemachte Bearbeitungen erneut anwenden (wenn seitdem nichts Neues). Fehler bei leerem Stapel. Bei **-undo** false: nichts.

*pathName* **edit reset**
: Leert Rückgängig- und Wiederholen-Stapel.

*pathName* **edit separator**
: Trennzeichen auf Rückgängig-Stapel. Bei **-undo** false: nichts.

*pathName* **edit undo**
: Bei **-undo** true: letzte Bearbeitung rückgängig (alles zwischen zwei Trennzeichen). Fehler bei leerem Stapel. Bei **-undo** false: nichts.


*pathName* **get** ?**-displaychars**? ?**--**? *index1* ?*index2 ...*?
: Zeichenbereich aus dem Text. Von *index1* bis vor *index2* (Zeichen bei *index2* nicht enthalten). Ohne *index2*: ein Zeichen. Leerer Bereich → leerer String. Eingebettete Fenster nicht im String. Mehrere Paare → Liste in übergebener Reihenfolge; ungültige Bereiche fehlen in der Liste. Mit **-displaychars** nur nicht ausgeblendete Zeichen — Bereiche können leer sein.

*pathName* **image** *option* ?*arg arg ...*?
: Eingebettete Bilder. Verhalten hängt von *option* ab:

*pathName* **image cget** *index option*
: Konfigurationswert; *index* identifiziert das Bild; *option* aus **EINGEBETTETE BILDER**.

*pathName* **image configure** *index* ?*option value ...*?
: Abfrage/Änderung wie **configure**; Optionen siehe **EINGEBETTETE BILDER**.

*pathName* **image create** *index* ?*option value ...*?
: Neues Bild bei *index*; eindeutiger Bezeichner als Index; siehe **EINGEBETTETE BILDER**.

*pathName* **image names**
: Liste aller eingebetteten Bildinstanzen in *window*.


*pathName* **index** *index*
: Position als *line.char*; *index* gemäß **INDIZES**.

*pathName* **insert** *index chars* ?*tagList chars tagList ...*?
: Fügt *chars* vor *index* ein. Bei Textende vor dem letzten Zeilenumbruch. Ein *chars* ohne *tagList*: Tags, die vor und nach der Einfügestelle gemeinsam sind; nur auf einer Seite → nicht auf neuen Text. Mit *tagList*: nur diese Tags. Mehrere Paare wie mehrfaches **insert**; letztes *tagList* optional.

*pathName* **mark** *option* ?*arg arg ...*?
: Marken bearbeiten:

*pathName* **mark gravity** *markName* ?*direction*?
: Ohne *direction*: **left** oder **right**. Mit *direction* (**left**/**right**): Schwerkraft setzen.

*pathName* **mark names**
: Liste aller gesetzten Marken.

*pathName* **mark next** *index*
: Name der nächsten Marke ab *index* (numerisch ab dieser Position; bei Markenname direkt danach; mehrere Marken am gleichen Index möglich). Reihenfolge wie **dump**. Marke auf **end** wirkt *nach* **end**. Keine Marke danach: leerer String.

*pathName* **mark previous** *index*
: Name der vorherigen Marke; numerisch ab Zeichen davor; bei Markenname davor. Umgekehrte **dump**-Reihenfolge. Keine Marke davor: leerer String.

*pathName* **mark set** *markName index*
: *markName* vor *index* setzen oder verschieben. Leerer String.

*pathName* **mark unset** *markName* ?*markName markName ...*?
: Marken entfernen; nicht mehr in Indizes oder „*pathName* **mark names**“. Leerer String.


*pathName* **peer** *option args*
: Peer-Widgets:

*pathName* **peer create** *newPathName* ?*options*?
: Peer mit *newPathName* und optionalen Standardoptionen (wie **text**). Standard: gleiche Start-/Endzeile wie Eltern-Widget.

*pathName* **peer names**
: Liste der Peers (ohne sich selbst); Reihenfolge undefiniert.


*pathName* **pendingsync**
: 1 wenn Zeilenhöhen nicht aktuell, sonst 0.

*pathName* **replace** *index1 index2 chars* ?*tagList chars tagList ...*?
: Ersetzt Bereich *index1*–*index2* durch *chars* und Tags; *tagList* wie bei **insert**, Indizes wie bei **delete**. Liegt *index2* vor *index1*, Fehler.
    Löschen und Einfügen ohne unnötiges Scrollen oder Cursor-Verschieben; Rückgängig-Stapel korrekt bei aktivem **-undo**. Leerer String.

*pathName* **scan** *option args*
: Scanning:

*pathName* **scan mark** *x y*
: Merkt *x*, *y* und aktuelle Ansicht für **scan dragto**. Leerer String.

*pathName* **scan dragto** *x y*
: Verschiebt die Ansicht um das Zehnfache der Differenz zu **scan mark**. Leerer String.


*pathName* **search** ?*switches*? *pattern index* ?*stopIndex*?
: Sucht ab *index* nach *pattern*. Treffer: Index des ersten Zeichens; sonst leerer String. Schalter:

**-forwards**
: vorwärts ab *index* (Standard).

**-backwards**
: rückwärts; erstes Zeichen des Treffers vor *index* (nicht bei *index*). Rückwärtssuche oft langsamer (**-regexp**); bei Performance vorwärts suchen.

**-exact**
: exakter Vergleich (Standard).

**-regexp**
: *pattern* als regulärer Ausdruck (**regexp**, **re_syntax**). Standard übergibt **-lineanchor** und **-linestop** (außer **-nolinestop**): *^\$* Zeilenanfang/-ende; *.* und *[^* nicht *\n*.

**-nolinestop**
: *.* und *[^* dürfen *\n* treffen; nur mit **-regexp**, sonst Fehler. Gesamter Text: „*pathName* **search -nolinestop -regexp** ".*" 1.0“.

**-nocase**
: Groß-/Kleinschreibung ignorieren.

**-count** *varName*
: Variable für Anzahl Indexpositionen im Treffer; ohne Bilder/Fenster (und ohne **-elide** auch ohne ausgeblendete Zeichen) = Zeichenanzahl. *matchIdx* bis *matchIdx + \$count chars* liefert den Treffer.

**-all**
: alle Treffer als Indexliste; mit **-count** Liste in *varName*. Wie **regexp -all**: überlappende Treffer normalerweise nicht. „\w+“ in „hello there“: zweimal; „Z[a-z]+Z“ in „ZooZooZoo“: einmal.

**-overlap**
: bei **-all**: auch Treffer, die einen bereits gefundenen überlappen, wenn sie nicht vollständig eingeschlossen sind. Nur mit **-all**, sonst Fehler.

**-strictlimits**
: gesamter Treffer muss innerhalb Start/Stopp liegen (nicht nur Trefferanfang).

**-elide**
: auch ausgeblendeten Text suchen.

**-\|-**
: beendet Schalterliste; nächstes Argument ist *pattern* auch bei führendem **-**.

    Treffer kann eine oder mehrere Zeilen umfassen. Mit *stopIndex*: Suche endet dort (vorwärts: nicht ab *stopIndex*; rückwärts: nicht vor *stopIndex*). Ohne *stopIndex*: Wrap-around am Textende. **-forwards** mit *stopIndex* vor Start: kein Treffer. Siehe **BEKANNTE FEHLER** zu **search**.

*pathName* **see** *index*
: Ansicht so anpassen, dass *index* vollständig sichtbar ist. Bereits sichtbar: nichts. Knapp außerhalb: minimal an Rand bringen. Weit außerhalb: zentrieren.

*pathName* **sync** ?**-command** *command*?
: Synchronisation der Ansicht:

*pathName* **sync**
: Zeilenmetriken sofort aktualisieren; sofort zurück wenn nichts veraltet, sonst nach Berechnung. Leerer String.

*pathName* **sync -command** *command*
: *command* einmal nach aktuellen Zeilenhöhen ausführen; bei keiner ausstehenden Berechnung sofort. Leerer String. Bei Fehler **bgerror**.


*pathName* **tag** *option* ?*arg arg ...*?
: Tags bearbeiten:

*pathName* **tag add** *tagName index1* ?*index2 index1 index2 ...*?
: Verknüpft *tagName* mit Zeichen von *index1* bis vor *index2*. Mehrere Paare möglich. Ohne letztes *index2*: ein Zeichen. Leerer Bereich: keine Wirkung.

*pathName* **tag bind** *tagName* ?*sequence*? ?*script*?
: Ordnet *script* dem Tag zu; bei *sequence* auf markierten Zeichen wird es ausgeführt. Ähnlich **bind**, aber für Zeichen. Siehe **bind** zu *sequence* und Substitutionen. Alle Argumente: neues Binding (ersetzt gleiches *sequence*/*tagName*; führendes „+“ in *script* ergänzt). Ohne *script*: zugehöriges *script*. Ohne beides: Liste aller Sequenzen.

    Bindings nur für Maus/Tastatur (**Enter**, **Leave**, **ButtonPress**, **Motion**, **KeyPress**) oder virtuelle Ereignisse. Maus: Marke **current**; Tastatur: **insert** (siehe **MARKEN**). **Enter**/**Leave** beim Betreten/Verlassen des Tags am aktuellen Zeichen (nicht wie Fenster-Enter/Leave). Mehrere Tags: ein Binding pro Tag, niedrigste zu höchster Priorität; bei einem Tag die spezifischste Variante (**bind**). **continue**/**break** wie bei **bind**. Widget-weite **bind**-Bindings ergänzen Tag-Bindings (Tags zuerst).

*pathName* **tag cget** *tagName option*
: Aktueller Optionswert für *tagName*.

*pathName* **tag configure** *tagName* ?*option*? ?*value*? ?*option value ...*?
: Wie **configure**, aber für Tag-Optionen; siehe **TAGS**.

*pathName* **tag delete** *tagName* ?*tagName ...*?
: Löscht Tag-Informationen inkl. Bindings und Anzeige. Leerer String.

*pathName* **tag lower** *tagName* ?*belowThis*?
: Priorität knapp unter *belowThis*; ohne *belowThis*: niedrigste Priorität.

*pathName* **tag names** ?*index*?
: Tags an *index* oder alle existierenden (auch ohne markierte Zeichen), sortiert nach Priorität.

*pathName* **tag nextrange** *tagName index1* ?*index2*?
: Nächster *tagName*-Bereich ab *index1* bis vor *index2*; zwei Indizes oder leer. Ohne *index2*: bis Textende.

*pathName* **tag prevrange** *tagName index1* ?*index2*?
: Vorheriger Bereich vor *index1*, nicht vor *index2*. Ohne *index2*: ab Textanfang.

*pathName* **tag raise** *tagName* ?*aboveThis*?
: Priorität knapp über *aboveThis*; ohne *aboveThis*: höchste Priorität.

*pathName* **tag ranges** *tagName*
: Alle Bereiche als Indexpaare; ohne markierte Zeichen: leerer String.

*pathName* **tag remove** *tagName index1* ?*index2 index1 index2 ...*?
: Entfernt *tagName* von *index1* bis vor *index2*; wie **tag add**. Leerer String.

*pathName* **window** *option* ?*arg arg ...*?
: Eingebettete Fenster:

*pathName* **window cget** *index option*
: Konfigurationswert; Optionen aus **EINGEBETTETE FENSTER**.

*pathName* **window configure** *index* ?*option value ...*?
: Abfrage/Änderung; siehe **EINGEBETTETE FENSTER**.

*pathName* **window create** *index* ?*option value ...*?
: Neues Fenster bei *index*; siehe **EINGEBETTETE FENSTER**. Leerer String.

*pathName* **window names**
: Liste aller eingebetteten Fenster in *window*.


*pathName* **xview** *option args*
: Horizontale Position des Textes:

*pathName* **xview**
: Liste mit zwei Brüchen 0–1: sichtbarer horizontaler Anteil. Beispiel .2 und .6: 20 % links außerhalb, 40 % sichtbar, 40 % rechts. Nur tatsächlich sichtbare Zeilen; kurze sichtbare Zeilen → 0 und 1. Werte für **-xscrollcommand**.

*pathName* **xview moveto** *fraction*
: *fraction* des horizontalen Umfangs links außerhalb (0–1).

*pathName* **xview scroll** *number what*
: Verschiebt die Ansicht; *what* ist **units**, **pages** oder **pixels**. Bei **units**/**pages** ganzzahliges *number*, sonst **Tk_GetPixels** (gerundet; ohne Einheit Pixel). **units**: durchschnittlich breite Zeichen; **pages**: Bildschirmseiten; **pixels**: Pixel. Negatives *number*: weiter links sichtbar; positiv: weiter rechts.


*pathName* **yview** ?*args*?
: Vertikale Position:

*pathName* **yview**
: Zwei Brüche 0–1: oberes sichtbares Pixel der obersten Zeile und Pixel nach dem letzten sichtbaren der untersten Zeile, relativ zum Gesamttext. Für **-yscrollcommand**.

*pathName* **yview moveto** *fraction*
: Pixel bei *fraction* an den oberen Rand der obersten Zeile (0 = Textanfang; nahe 1 wird auf maximalen Scroll begrenzt).

*pathName* **yview scroll** *number what*
: Verschiebt vertikal; *what* **units**, **pages** oder **pixels**; bei **units**/**pages** ganzzahlig, sonst **Tk_GetPixels**. **units**: Zeilen; **pages**: Bildschirmseiten; **pixels**: Pixel. Negativ: frühere Positionen; positiv: spätere.

*pathName* **yview** ?**-pickplace**? *index*
: *index* sichtbar machen. Ohne **-pickplace**: oben im Fenster. Mit **-pickplace**:

[1]
: Bereits sichtbar: nichts.

[2]
: Knapp oberhalb: oben positionieren.

[3]
: Knapp unterhalb: unten positionieren.

[4]
: Sonst zentrieren.

    **-pickplace** ist veraltet; *pathName* **see** übernimmt x- und y-Bewegung (**-pickplace** nur y).

*pathName* **yview** *number*
: Erstes Zeichen der Zeile nach *number* oben sichtbar; *number* ganzzahlig. Veraltet.


# BINDINGS

Tk erstellt automatisch Klassen-Bindings für Text-Widgets mit folgendem Standardverhalten. „Wort“ hängt von **tcl_wordchars** ab; siehe **tclvars**(n).

1. Maustaste 1 setzt den Einfügecursor an die nächste Kante des Zeichens unter dem Cursor, setzt den Eingabefokus und löscht die Auswahl. Ziehen mit Taste 1 erweitert die Auswahl zwischen Einfügecursor und Zeichen unter der Maus.

2. Doppelklick mit Taste 1 wählt das Wort unter der Maus und setzt den Cursor an den Wortanfang. Ziehen danach erweitert die Auswahl in ganzen Wörtern.

3. Dreifachklick mit Taste 1 wählt die Zeile und setzt den Cursor an den Zeilenanfang. Ziehen danach erweitert die Auswahl in ganzen Zeilen.

4. Mit gedrückter Umschalttaste und Taste 1 lässt sich das Auswahlende anpassen (das Ende, das der Maus beim Drücken am nächsten war). Nach Doppelklick: in Wörtern; nach Dreifachklick: in Zeilen.

5. Taste 1 mit Strg verschiebt den Einfügecursor ohne die Auswahl zu ändern.

6. Normale druckbare Zeichen werden am Einfügecursor eingefügt.

7. Die Ansicht lässt sich mit der mittleren Maustaste ziehen (Taste 2, unter TkAqua Taste 3). Klick ohne Bewegung kopiert die Auswahl an die Mausposition. Die Einfüge-Taste fügt die Auswahl am Einfügecursor ein.

8. Wird die Maus mit gedrückter Taste 1 aus dem Widget gezogen, scrollt es automatisch, wenn dort noch Text außerhalb des Fensters liegt.

9. Links/Rechts bewegen den Cursor um ein Zeichen und löschen die Auswahl. Mit Umschalt: Cursor bewegen und Auswahl erweitern. Strg-Links/Rechts: wortweise; Strg-Umschalt-Links/Rechts: wortweise mit Auswahl. Strg-b/Strg-f wie Links/Rechts. Meta-b/Meta-f wie Strg-Links/Rechts.

10. Hoch/Runter bewegen den Cursor um eine Zeile und löschen die Auswahl. Mit Umschalt (im Original „Up or Right“; gemeint: Up oder Down): Auswahl erweitern. Strg-Hoch/Runter: Absätze (durch Leerzeilen getrennt); Strg-Umschalt-Hoch/Runter: Absätze mit Auswahl. Strg-p/Strg-n wie Hoch/Runter.

11. Bild-ab/Bild-auf bewegen den Cursor um einen Bildschirm und löschen die Auswahl. Mit Umschalt: Auswahl erweitern.

12. Strg-Bild-ab/Bild-auf scrollen die Ansicht um eine Seite nach rechts/links, ohne Cursor oder Auswahl zu ändern.

13. Pos1 und Strg-a: Anfang der Anzeigezeile, Auswahl löschen. Umschalt-Pos1: Anfang der Anzeigezeile mit Auswahl.

14. Ende und Strg-e: Ende der Anzeigezeile, Auswahl löschen. Umschalt-Ende: Ende der Anzeigezeile mit Auswahl.

15. Strg-Pos1 und Meta-<: Textanfang, Auswahl löschen. Strg-Umschalt-Pos1: Textanfang mit Auswahl.

16. Strg-Ende und Meta->: Textende, Auswahl löschen. Strg-Umschalt-Ende: Textende mit Auswahl.

17. Select und Strg-Leerzeichen setzen den Auswahlanker auf den Einfügecursor, ohne die aktuelle Auswahl zu ändern. Umschalt-Select und Strg-Umschalt-Leerzeichen passen die Auswahl vom Anker zum Cursor an.

18. Strg-/ wählt den gesamten Inhalt.

19. Strg-\\ löscht die Auswahl.

20. F16 (auf vielen Sun-Workstations „Copy“) oder Meta-w kopiert die Auswahl (**tk_textCopy**), falls vorhanden.

21. F20 („Cut“) oder Strg-w kopiert und löscht die Auswahl (**tk_textCut**). Ohne Auswahl keine Wirkung.

22. F18 („Paste“) oder Strg-y fügt die Zwischenablage am Einfügecursor ein (**tk_textPaste**).

23. Entf löscht die Auswahl oder, ohne Auswahl, das Zeichen rechts vom Cursor.

24. Rücktaste und Strg-h löschen die Auswahl oder das Zeichen links vom Cursor.

25. Strg-d löscht das Zeichen rechts vom Cursor.

26. Meta-d löscht das Wort rechts vom Cursor.

27. Strg-k löscht vom Cursor bis Zeilenende; am Zeilenende den Zeilenumbruch.

28. Strg-o fügt einen Zeilenumbruch vor dem Cursor ein, ohne den Cursor zu verschieben.

29. Meta-Rücktaste und Meta-Entf löschen das Wort links vom Cursor.

30. Strg-x kopiert die Auswahl in die Zwischenablage und löscht sie.

31. Strg-t vertauscht die beiden Zeichen rechts vom Cursor.

32. Strg-z macht die letzte Bearbeitung rückgängig, wenn **-undo** true ist.

33. Strg-Z (unter Windows Strg-y) stellt die letzte rückgängig gemachte Bearbeitung wieder her, wenn **-undo** true ist.


Ist das Widget mit **-state** deaktiviert, lässt sich die Ansicht noch anpassen und Text auswählen, aber es gibt keinen Einfügecursor und keine Textänderungen.

Das Verhalten lässt sich durch neue Widget-Bindings oder neu definierte Klassen-Bindings ändern.

# BEKANNTE PROBLEME

## Probleme bezüglich chars und Indizes

Vor Tk 8.5 bezog sich „chars“ auf Indexpositionen (Zeichen, eingebettete Fenster und Bilder). Ab Tk 8.5 werden „chars“ und „indices“ getrennt behandelt. Aus Kompatibilität beziehen „+N chars“ und „-N chars“ weiterhin Indizes ein; für echte Zeichen „+N any chars“, „-N any chars“ usw. verwenden. In einer künftigen Version könnte „+N chars“ synonym zu „+N any chars“ werden.

## Performance-Probleme

Text-Widgets sollten unter verschiedenen Bedingungen effizient laufen. Etwa 2–3 Byte Hauptspeicher pro Textbyte; Megabyte-Texte sind auf den meisten Workstations machbar. Intern modifizierter B-Baum; Tags und Marken skalieren in vielen Fällen gut.

Problematisch können Hunderte oder Tausende Tags sein, deren erster und letzter Bereich nahe am Textanfang bzw. -ende liegen oder ein Bereich fast das ganze Widget abdeckt — Kosten proportional zu ähnlichen Tags. Viele Tags mit lokal verteilten Bereichen sind unkritisch.

Sehr lange Zeilen können teuer sein, besonders mit vielen Marken und Tags.

Die Anzeigezeile mit dem Einfügecursor wird bei jedem Blinken neu gezeichnet — setzen Sie **-insertofftime** auf 0, um das zu vermeiden.

## Bekannte Fehler

*pathName* **search -regexp** sucht seit Tk 8.5 zeilenweise und in kleinen Gruppen effizient über mehrere Zeilen; unter Umständen weicht das Ergebnis von einer regexp über den gesamten Text ab. Bei gierigen Mustern werden Zeilen ergänzt, solange Tcl einen längeren Treffer meldet (nicht immer korrekt) oder jede neue Zeile teilweise passt. Fehlt der Treffer in der ersten Zusatzzeile bei falschem Tcl-Code, obwohl die zweite passen würde, ist das Ergebnis falsch — selten, aber möglich, z. B.:

```
pack [text .t]
\&.t insert 1.0 "aaaa\nbbbb\ncccc\nbbbb\naaaa\n"
\&.t search -regexp -- {(a+|b+\nc+\nb+)+\na+} 1.0
```

findet keinen Treffer, obwohl ab dem ersten „b“ ein 19-Zeichen-Treffer existiert.

Umschließt ein möglicher Treffer einen anderen vollständig, soll nur der größere zurückgegeben werden. Bei rückwärts regexp-Suche gelingt das nicht immer, wenn kurze nicht überlappende Treffer einem großen vorausgehen, der sie alle umfasst — der Algorithmus schaut nicht beliebig weit zurück. Beispiel:

```
pack [text .t]
\&.t insert 1.0 "aaaa\nbbbb\nbbbb\nbbbb\nbbbb\\n"
\&.t search -regexp -backward -- {b+\n|a+\n(b+\n)+} end
```

trifft bei „5.0“ zu, ein wirklich gieriger Treffer wäre „1.0“. Mit **-all** trifft es „5.0“, „4.0“, „3.0“ und „1.0“ zu, korrekt wäre nur „1.0“, da dieser alle anderen umschließt.

