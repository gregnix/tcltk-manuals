---
CommandName: font
title: font
ManualSection: n
Version: 8.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - options(n)
Keywords:
 - font
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
 - Copyright (c) 2006-2007 Daniel A. Steffen <das@users.sourceforge.net>
---

# Name

font - Schriftarten erzeugen und inspizieren

# Übersicht

::: {.synopsis} :::
[font]{.cmd} [option]{.arg} [arg]{.optdot}
:::

# Beschreibung

Der Befehl **font** bietet mehrere Einrichtungen zum Umgang mit Schriftarten, etwa zum Definieren benannter Schriftarten und zum Inspizieren der tatsächlichen Attribute einer Schriftart. Der Befehl hat mehrere Formen, bestimmt durch das erste Argument. Derzeit werden folgende Formen unterstützt:

[font]{.cmd} [actual]{.sub} [font]{.arg} [[-displayof]{.lit} [window]{.arg}]{.optarg} [option]{.optarg} [--]{.optlit} [char]{.optarg}
: Gibt Informationen über die tatsächlichen Attribute zurück, die erhalten werden, wenn *font* auf dem Display von *window* verwendet wird; die erhaltenen Attribute können sich von den angeforderten unterscheiden, z. B. wegen plattformabhängiger Einschränkungen wie Verfügbarkeit von Schriftfamilien und Punktgrößen. *font* ist eine Schriftbeschreibung; siehe [Schriftbeschreibungen] unten. Wenn das Argument *window* weggelassen wird, gilt standardmäßig das Hauptfenster. Wenn *option* angegeben ist, wird der Wert dieses Attributs zurückgegeben; andernfalls ist der Rückgabewert eine Liste aller Attribute und ihrer Werte. Siehe [Schriftoptionen] unten für die möglichen Attribute. Wenn das Argument *char* angegeben ist, muss es ein einzelnes Zeichen sein. Die zurückgegebenen Schriftattribute sind die der konkreten Schrift, mit der dieses Zeichen dargestellt wird; sie unterscheiden sich von der Basisschrift, wenn die Basisschrift das Zeichen nicht enthält. Kann *char* ein Bindestrich sein, sollte es mit **-\|-** vorangestellt werden, um es von einer falsch geschriebenen *option* zu unterscheiden.

[font]{.cmd} [configure]{.sub} [fontname]{.arg} [option]{.optarg} [value option value]{.optdot}
: Fragt die gewünschten Attribute der benannten Schrift *fontname* ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste aller Optionen und ihrer Werte für *fontname* zurück. Wenn eine einzelne *option* ohne *value* angegeben ist, wird der aktuelle Wert dieses Attributs zurückgegeben. Wenn ein oder mehrere *option*-*value*-Paare angegeben sind, ändert der Befehl die benannte Schrift entsprechend; in diesem Fall zeichnen sich alle Widgets, die diese Schrift verwenden, mit den neuen Attributen neu. Siehe [Schriftoptionen] unten für die möglichen Attribute.

    Beachten Sie, dass unter Aqua/macOS die Systemschriften (siehe [Plattformspezifische Schriften] unten) möglicherweise nicht wirklich geändert werden können, weil sie vom System-Theme implementiert sind. Um den Effekt einer Änderung zu erzielen, verwenden Sie **font actual**, um die Konfiguration zu lesen, und **font create**, um eine kopierbare, änderbare Schrift zu erzeugen.

[font]{.cmd} [create]{.sub} [fontname]{.optarg} [option value]{.optdot}
: Erzeugt eine neue benannte Schrift und gibt ihren Namen zurück. *fontname* legt den Namen fest; wenn er weggelassen wird, erzeugt Tk einen neuen Namen der Form **font***x*, wobei *x* eine Ganzzahl ist. Es kann beliebig viele *option*-*value*-Paare geben, die die gewünschten Attribute der neuen benannten Schrift festlegen. Siehe [Schriftoptionen] unten für die möglichen Attribute.

[font]{.cmd} [delete]{.sub} [fontname]{.arg} [fontname]{.optdot}
: Löscht die angegebenen benannten Schriften. Wenn Widgets die benannte Schrift noch verwenden, wird sie erst gelöscht, wenn alle Instanzen freigegeben sind. Diese Widgets zeigen weiterhin die zuletzt bekannten Werte der benannten Schrift. Wird eine gelöschte benannte Schrift später mit **font create** neu erzeugt, verwenden die Widgets die neue benannte Schrift und zeichnen sich mit deren neuen Attributen neu.

[font]{.cmd} [families]{.sub} [[-displayof]{.lit} [window]{.arg}]{.optarg}
: Der Rückgabewert ist eine Liste der namensunabhängigen Namen aller Schriftfamilien auf dem Display von *window*. Wenn *window* weggelassen wird, gilt standardmäßig das Hauptfenster.

[font]{.cmd} [measure]{.sub} [font]{.arg} [[-displayof]{.lit} [window]{.arg}]{.optarg} [text]{.arg}
: Misst, wie viel Platz die Zeichenkette *text* in der angegebenen Schrift *font* auf *window* einnehmen würde. *font* ist eine Schriftbeschreibung; siehe [Schriftbeschreibungen] unten. Wenn *window* weggelassen wird, gilt standardmäßig das Hauptfenster. Der Rückgabewert ist die Gesamtbreite von *text* in Pixeln, ohne zusätzliche Pixel für stark überzeichnete Zeichen wie ein geschwungenes „f“. Enthält die Zeichenkette Zeilenumbrüche oder Tabulatoren, werden diese beim Messen nicht expandiert oder besonders behandelt.

[font]{.cmd} [metrics]{.sub} [font]{.arg} [[-displayof]{.lit} [window]{.arg}]{.optarg} [option]{.optarg}
: Gibt Informationen über die Metriken (schriftspezifische Daten) von *font* auf dem Display von *window* zurück. *font* ist eine Schriftbeschreibung; siehe [Schriftbeschreibungen] unten. Wenn *window* weggelassen wird, gilt standardmäßig das Hauptfenster. Wenn *option* angegeben ist, wird der Wert dieser Metrik zurückgegeben; andernfalls ist der Rückgabewert eine Liste aller Metriken und ihrer Werte. Siehe [Schriftmetriken] unten für die möglichen Metriken.

[font]{.cmd} [names]{.sub}
: Der Rückgabewert ist eine Liste aller derzeit definierten benannten Schriften.


# Schriftbeschreibungen

Die folgenden Formate werden als Schriftbeschreibung überall akzeptiert, wo oben *font* als Argument angegeben ist; dieselben Formen sind auch bei der Option **-font** von Widgets zulässig.

\[1\] *fontname*
: Der Name einer benannten Schrift, erzeugt mit **font create**. Verwendet ein Widget eine benannte Schrift, ist garantiert, dass dies nie einen Fehler verursacht, solange die benannte Schrift existiert — unabhängig davon, wie ungültig oder sinnlos die Attribute der benannten Schrift sind. Kann die benannte Schrift nicht exakt mit den angegebenen Attributen dargestellt werden, wird automatisch eine ähnliche Schrift substituiert.

\[2\] *systemfont*
: Der plattformspezifische Name einer Schrift, vom Grafikserver interpretiert. Unter X gehört dazu auch ein XLFD (siehe \[4\]), bei dem ein einzelnes Zeichen „**\***“ mehr als ein Feld in der Mitte des Namens ausgelassen hat. Siehe [Plattformspezifische Schriften] für die Systemschriften.

\[3\] *family* ?*size*? ?*style*? ?*style ...*?
: Eine wohlgeformte Liste, deren erstes Element die gewünschte Schrift-*family* ist und deren optionales zweites Element die gewünschte *size* ist. Die Auslegung von *size* folgt denselben Regeln wie **-size** unter [Schriftoptionen] unten. Weitere optionale Argumente nach *size* sind Schrift-*style*s. Mögliche Werte für *style* sind:

    ::: {.info DISPLAY="yes"}
    **normal**	**bold**	**roman**	**italic**\
    **underline**	**overstrike**
    :::

\[4\] X-Schriftnamen (XLFD)
: Ein Unix-orientierter Schriftname der Form *-foundry-family-weight-slant-setwidth-addstyle-pixel-point-resx-resy-spacing-width-charset-encoding*. Das Zeichen „**\***“ kann verwendet werden, um einzelne Felder zu überspringen. Pro übersprungenem Feld muss genau ein „**\***“ stehen, außer ein „**\***“ am Ende des XLFD überspringt alle restlichen Felder; der kürzeste gültige XLFD ist einfach „**\***“ (alle Felder Standard). Übersprungene Felder erhalten Standardwerte. Zur Kompatibilität wählt ein XLFD immer eine Schrift der angegebenen Pixelgröße (nicht Punktgröße); obwohl das nicht streng korrekt ist, gingen bestehende Anwendungen davon aus, dass ein „Punkt“ ein Pixel war, und würden bei korrekter Größe falsch (meist größer) dargestellt.

\[5\] *option value* ?*option value ...*?
: Eine wohlgeformte Liste von *option*-*value*-Paaren, die die gewünschten Schriftattribute im gleichen Format wie bei einer benannten Schrift festlegen; siehe [Schriftoptionen] unten.


Wird die Schriftbeschreibung *font* verwendet, versucht das System, die Beschreibung nacheinander nach den fünf Regeln zu parsen. Fälle \[1\] und \[2\] müssen einem existierenden benannten oder System-Schriftnamen entsprechen. Fälle \[3\], \[4\] und \[5\] werden auf allen Plattformen akzeptiert; die nächstliegende verfügbare Schrift wird verwendet. Manchmal ist keine nahe Schrift möglich (z. B. ungültige Familie); dann wird eine systemabhängige Standardschrift gewählt. Entspricht die Beschreibung keinem Muster, entsteht ein Fehler.

# Schriftmetriken

Die folgenden Optionen werden von **font metrics** abgefragt; sie sind schriftspezifische Daten beim Erzeugen der Schrift. Sie gelten für die ganze Schrift, nicht für einzelne Zeichen. In den Definitionen ist die „Grundlinie“ die horizontale Linie, an der die Unterkante der meisten Buchstaben ausgerichtet ist; manche Buchstaben wie „g“ ragen darunter hinaus.

[-ascent]{.lit}
: Anzahl Pixel, um die der höchste Buchstabe über der Grundlinie ragt, plus eventueller Leerraum des Schriftdesigners.

[-descent]{.lit}
: Größter Betrag in Pixeln, um den ein Buchstabe unter die Grundlinie ragt, plus eventueller Leerraum des Schriftdesigners.

[-linespace]{.lit}
: Gibt zurück, wie weit zwei Textzeilen in derselben Schrift vertikal in Pixeln platziert werden sollen, damit sich keine Zeichen überlappen. Im Allgemeinen Summe aus Aufstieg über der Grundlinie und Abstieg darunter.

[-fixed]{.lit}
: Gibt ein boolesches Flag zurück: „**1**“, wenn dies eine Festbreitenschrift ist (jedes normale Zeichen gleich breit), oder „**0**“ bei proportionaler Schrift. Steuerzeichen, Tabulatoren und andere nicht druckbare Zeichen zählen nicht mit.


# Schriftoptionen

Die folgenden Optionen werden auf allen Plattformen unterstützt und beim Erzeugen einer benannten Schrift oder bei Schriftbeschreibung nach Stil \[5\] verwendet:

[-family]{.lit} [name]{.arg}
: Name der Schriftfamilie (Groß-/Kleinschreibung irrelevant). Tk garantiert **Courier** (Monospace-Schreibmaschine), **Times** (Serif-Zeitung) und **Helvetica** (Sans-Serif). Bei Verwendung einer dieser Familien wird automatisch die passendste native Familie substituiert. *name* kann auch eine native, plattformspezifische Familie sein; dann funktioniert sie auf einer Plattform, auf anderen evtl. nicht. Ist die Familie nicht angegeben oder unbekannt, wird eine plattformspezifische Standardschrift gewählt.

[-size]{.lit} [size]{.arg}
: Gewünschte Schriftgröße. Ist *size* positiv, wird sie in Punkten interpretiert. Ist *size* negativ, ist der Absolutwert die Größe in Pixeln. Kann die Schrift in der Größe nicht dargestellt werden, wird eine nahe Größe gewählt. Ist *size* nicht angegeben oder 0, wird eine plattformabhängige Standardgröße gewählt.

    Größen sollten normalerweise in Punkten angegeben werden, damit die Anwendung auf dem Bildschirm gleich groß bleibt, auch bei geänderten Auflösungen oder beim Portieren. Pixel sind sinnvoll, wenn Text zu einem Bitmap mit fester Größe passen muss. Die Zuordnung Punkte/Pixel wird beim Start anhand des Monitors festgelegt, kann aber mit [tk scaling][tk] überschrieben werden.

[-weight]{.lit} [weight]{.arg}
: Nominale Strichstärke. **normal** ist normal, **bold** fett. Die nächstliegende verfügbare Stärke wird gewählt. Standard **normal**.

[-slant]{.lit} [slant]{.arg}
: Neigung der Zeichen gegen die Vertikale. Gültig: **roman** und **italic**. **roman** ist aufrecht, **italic** geneigt. Die nächstliegende Neigung wird gewählt. Standard **roman**.

[-underline]{.lit} [boolean]{.arg}
: Boolesches Flag: Zeichen unterstrichen. Standard **false**.

[-overstrike]{.lit} [boolean]{.arg}
: Boolesches Flag: horizontale Linie durch die Mitte der Zeichen. Standard **false**.


# Standardschriften

Die folgenden benannten Schriften werden auf allen Systemen unterstützt und entsprechen passenden System-Standards.

**TkDefaultFont**
: Standardschrift für alle GUI-Elemente ohne eigene Angabe.

**TkTextFont**
: Für Benutzertext in entry, listbox usw.

**TkFixedFont**
: Standard-Festbreitenschrift.

**TkMenuFont**
: Für Menüeinträge.

**TkHeadingFont**
: Für Spaltenüberschriften in Listen und Tabellen.

**TkCaptionFont**
: Für Fenster- und Dialog-Titelleisten.

**TkSmallCaptionFont**
: Für Beschriftungen in eingebetteten Fenstern oder Werkzeugdialogen.

**TkIconFont**
: Für Symbolbeschriftungen.

**TkTooltipFont**
: Für Tooltip-Fenster (kurzlebige Infofenster).


Diese Schriften sollten *nicht* geändert werden, da Tk sie bei Systemänderungen selbst anpassen kann. Stattdessen eine Kopie erzeugen und diese ändern.

# Plattformspezifische Schriften

Folgende Systemschriften werden unterstützt:

**X Windows**
: Alle gültigen X-Schriftnamen, einschließlich der von xlsfonts(1) gelisteten.

**MS Windows**
: Folgende Schriften, zugeordnet zu den Stil-Standards des Benutzers:

    ::: {.info DISPLAY="yes"}
    **system**	**ansi**	**device**\
    **systemfixed**	**ansifixed**	**oemfixed**
    :::

**macOS**
: Folgende Schriften, zugeordnet zu den Stil-Standards des Benutzers:

    ::: {.info DISPLAY="yes"}
    **system**	**application**	**menu**
    :::

    Zusätzlich liefern folgende benannte Schriften Zugriff auf Aqua-Theme-Schriften:

    ::: {.info DISPLAY="yes"}
    **systemSystemFont**	**systemEmphasizedSystemFont**\
    **systemSmallSystemFont**	**systemSmallEmphasizedSystemFont**\
    **systemApplicationFont**	**systemLabelFont**\
    **systemViewsFont**	**systemMenuTitleFont**\
    **systemMenuItemFont**	**systemMenuItemMarkFont**\
    **systemMenuItemCmdKeyFont**	**systemWindowTitleFont**\
    **systemPushButtonFont**	**systemUtilityWindowTitleFont**\
    **systemAlertHeaderFont**	**systemToolbarFont**\
    **systemMiniSystemFont**	**systemDetailSystemFont**\
    **systemDetailEmphasizedSystemFont**
    :::


# Beispiel

Ein Text-Widget mit Schriftmustern für jede installierte Familie füllen:

```
pack [text .t -wrap none] -fill both -expand 1
set count 0
set tabwidth 0
foreach family [lsort -dictionary [font families]] {
    .t tag configure f[incr count] -font [list $family 10]
    .t insert end ${family}:\t {} \
            "This is a simple sampler\n" f$count
    set w [font measure [.t cget -font] ${family}:]
    if {$w + 5 > $tabwidth} {
        set tabwidth [expr {$w + 5}]
        .t configure -tabs $tabwidth
    }
}
```


[tk]: tk.md
