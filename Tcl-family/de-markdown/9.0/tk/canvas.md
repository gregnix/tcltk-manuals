---
CommandName: canvas
title: canvas
ManualSection: n
Version: 8.3
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bind(n)
 - font(n)
 - image(n)
 - scrollbar(n)
Keywords:
 - canvas
 - widget
Copyright:
 - Copyright (c) 1992-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 1997-1999 Scriptics Corporation.
---

# Name

canvas - Erstellt und manipuliert 'Canvas'-Hypergraphik-Zeichen-Oberflächen-Widgets

# Übersicht

::: {.synopsis} :::
[canvas]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standardoptionen

**-background**, **-borderwidth**, **-cursor**, **-highlightbackground**, **-highlightcolor**, **-highlightthickness**, **-insertbackground**, **-insertborderwidth**, **-insertofftime**, **-insertontime**, **-insertwidth**, **-relief**, **-selectbackground**, **-selectborderwidth**, **-selectforeground**, **-takefocus**, **-xscrollcommand**, **-yscrollcommand**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-closeenough** (**closeEnough**/**CloseEnough**)
: Legt einen Gleitkommawert fest, der angibt, wie nah der Mauszeiger an einem Element sein muss, damit er als „innerhalb“ des Elements gilt. Der Standardwert ist 1.0.

**-confine** (**confine**/**Confine**)
: Legt einen booleschen Wert fest, der angibt, ob die Ansicht des Canvas außerhalb der Region gesetzt werden darf, die das Argument **scrollRegion** festlegt. Der Standardwert ist true; das bedeutet, dass die Ansicht auf die Scroll-Region beschränkt bleibt.

**-height** (**height**/**Height**)
: Legt eine gewünschte Fensterhöhe fest, die das Canvas-Widget von seinem Geometriemanager anfordern soll. Der Wert kann in einer der im Abschnitt [Koordinaten] unten beschriebenen Formen angegeben werden.

**-scrollregion** (**scrollRegion**/**ScrollRegion**)
: Legt eine Liste mit vier Koordinaten fest, die die linke, obere, rechte und untere Koordinate einer rechteckigen Region beschreiben. Diese Region wird zum Scrollen verwendet und gilt als Grenze der Informationen im Canvas. Jede der Koordinaten kann in einer der Formen angegeben werden, die im Abschnitt [Koordinaten] unten beschrieben sind.

**-state** (**state**/**State**)
: Ändert den Standardzustand des Canvas, wobei *state* auf einen der folgenden Werte gesetzt werden kann: **normal**, **disabled** oder **hidden**. Einzelne Canvas-Elemente haben jeweils eine eigene Zustandsoption, die den Standardzustand überschreiben kann. Viele Optionen erlauben getrennte Angaben, sodass das Element in verschiedenen Situationen unterschiedlich aussehen kann. Die Optionen, die mit **active** beginnen, steuern das Aussehen, wenn sich der Mauszeiger über dem Element befindet; die Option, die mit **disabled** beginnt, steuert das Aussehen im deaktivierten Zustand. Canvas-Elemente im Zustand **disabled** reagieren nicht auf Canvas-Bindungen.

**-width** (**width**/**width**)
: Legt eine gewünschte Fensterbreite fest, die das Canvas-Widget von seinem Geometriemanager anfordern soll. Der Wert kann in einer der im Abschnitt [Koordinaten] unten beschriebenen Formen angegeben werden.

**-xscrollincrement** (**xScrollIncrement**/**ScrollIncrement**)
: Legt ein Inkrement für das horizontale Scrollen fest, in einer der üblichen Formen, die für Bildschirmabstände zulässig sind. Ist der Wert dieser Option größer als null, wird die horizontale Ansicht im Fenster so beschränkt, dass die x-Koordinate des Canvas am linken Fensterrand stets ein ganzzahliges Vielfaches von **xScrollIncrement** ist; außerdem ist auch die Einheit beim Scrollen (z. B. die Änderung der Ansicht, wenn der linke oder rechte Pfeil einer Scrollbar betätigt wird) **xScrollIncrement**. Ist der Wert dieser Option negativ oder null, ist das horizontale Scrollen nicht beschränkt.

**-yscrollincrement** (**yScrollIncrement**/**ScrollIncrement**)
: Legt ein Inkrement für das vertikale Scrollen fest, in einer der üblichen Formen, die für Bildschirmabstände zulässig sind. Ist der Wert dieser Option größer als null, wird die vertikale Ansicht im Fenster so beschränkt, dass die y-Koordinate des Canvas am oberen Fensterrand stets ein ganzzahliges Vielfaches von **yScrollIncrement** ist; außerdem ist auch die Einheit beim Scrollen (z. B. die Änderung der Ansicht, wenn der obere oder untere Pfeil einer Scrollbar betätigt wird) **yScrollIncrement**. Ist der Wert dieser Option negativ oder null, ist das vertikale Scrollen nicht beschränkt.


# Einleitung

Der Befehl **canvas** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Canvas-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des Canvas wie Farben und 3-D-Relief zu konfigurieren. Der Befehl **canvas** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Elternfenster von *pathName* muss existieren.

Canvas-Widgets implementieren strukturierte Grafiken. Ein Canvas zeigt beliebig viele *Elemente* an, die Dinge wie Rechtecke, Kreise, Linien und Text sein können. Elemente können manipuliert werden (z.B. verschoben oder umgefärbt) und Befehle können mit Elementen verknüpft werden, ähnlich wie der Befehl [bind] es erlaubt, Befehle an Widgets zu binden. Zum Beispiel kann ein bestimmter Befehl mit dem Ereignis <Button-1> verknüpft werden, sodass der Befehl aufgerufen wird, wenn Maustaste 1 gedrückt wird, während sich der Mauszeiger über einem Element befindet. Das bedeutet, dass Elemente in einem Canvas Verhalten haben können, die durch die an sie gebundenen Tcl-Skripte definiert sind.

# Anzeigeliste

Die Elemente in einem Canvas sind für die Anzeige geordnet: Das erste Element der Anzeigeliste wird zuerst angezeigt, danach das nächste Element der Liste und so weiter. Elemente, die später in der Anzeigeliste stehen, verdecken die früheren und werden manchmal als „oben auf“ den früheren Elementen liegend bezeichnet. Ein neu erzeugtes Element wird ans Ende der Anzeigeliste gesetzt, also oben auf alle anderen. Mit Widget-Befehlen lässt sich die Reihenfolge der Anzeigeliste ändern.

Fenster-Elemente sind eine Ausnahme von diesen Regeln. Die zugrunde liegenden Fenstersysteme verlangen, dass sie immer über allen anderen Elementen gezeichnet werden. Außerdem wird die Stapelreihenfolge der Fenster-Elemente von keinem der Canvas-Widget-Befehle beeinflusst; Sie müssen stattdessen die Tk-Befehle [raise] und [lower] verwenden.

# Element-IDs und Tags

Elemente in einem Canvas-Widget können auf zwei Arten benannt werden: per ID oder per Tag. Jedes Element hat eine eindeutige Identifikationsnummer, die diesem Element bei seiner Erstellung zugewiesen wird. Die ID eines Elements ändert sich nie und ID-Nummern werden innerhalb der Lebensdauer eines Canvas-Widgets nie wiederverwendet.

Jedem Element kann außerdem eine beliebige Anzahl von *Tags* zugeordnet sein. Ein Tag ist einfach eine Zeichenkette und kann jede Form haben außer der einer Ganzzahl. So ist zum Beispiel „x123“ zulässig, „123“ aber nicht. Derselbe Tag kann vielen verschiedenen Elementen zugeordnet sein. Das wird häufig genutzt, um Elemente auf verschiedene nützliche Arten zu gruppieren; zum Beispiel könnten alle ausgewählten Elemente den Tag „selected“ erhalten.

Der Tag **all** ist implizit mit jedem Element im Canvas verknüpft; er kann verwendet werden, um Operationen auf allen Elementen im Canvas aufzurufen.

Der Tag **current** wird automatisch von Tk verwaltet; er gilt für das *aktuelle Element*, das das oberste Element ist, dessen gezeichneter Bereich die Position des Mauszeigers abdeckt (verschiedene Elementtypen interpretieren dies auf unterschiedliche Weise; siehe die Dokumentation der einzelnen Elementtypen für Details). Wenn sich die Maus nicht im Canvas-Widget befindet oder nicht über einem Element ist, hat kein Element den Tag **current**.

Wird in Canvas-Widget-Befehlen ein Element angegeben und ist die Angabe eine Ganzzahl, wird angenommen, dass sie das einzelne Element mit dieser ID bezeichnet. Ist die Angabe keine Ganzzahl, wird angenommen, dass sie alle Elemente im Canvas bezeichnet, die einen zur Angabe passenden Tag haben. Das Symbol *tagOrId* zeigt im Folgenden an, dass ein Argument entweder eine ID angibt, die ein einzelnes Element auswählt, oder einen Tag, der null oder mehr Elemente auswählt.

*tagOrId* kann mit den Operatoren „**&&**“, „**||**“, „**^**“, „**!**“ und geklammerten Teilausdrücken logische Ausdrücke aus Tags enthalten. Zum Beispiel:

```
      .c find withtag {(a&&!b)||(!a&&b)}
```

oder äquivalent:

```
      .c find withtag {a^b}
```

findet nur die Elemente, die entweder den Tag „a“ oder den Tag „b“ haben, aber nicht beide.

Einige Widget-Befehle wirken jeweils nur auf ein einzelnes Element; wird *tagOrId* so angegeben, dass es mehrere Elemente bezeichnet, verwendet der Befehl normalerweise das erste (unterste) dieser Elemente in der Anzeigeliste, das für den Befehl geeignet ist. Ausnahmen sind in den Beschreibungen der Widget-Befehle unten vermerkt.

# Koordinaten

Alle Koordinaten, die mit Canvas-Widgets zusammenhängen, werden als Gleitkommazahlen gespeichert. Koordinaten und Abstände werden in Bildschirmeinheiten angegeben; das sind Gleitkommazahlen, denen optional einer von mehreren Buchstaben folgt. Wird kein Buchstabe angegeben, ist der Abstand in Pixeln angegeben. Ist der Buchstabe **m**, ist der Abstand in Millimetern auf dem Bildschirm angegeben, bei **c** in Zentimetern; **i** bedeutet Zoll, und **p** bedeutet Druckerpunkte (1/72 Zoll). Größere y-Koordinaten bezeichnen Punkte weiter unten auf dem Bildschirm, größere x-Koordinaten Punkte weiter rechts. Koordinaten können entweder als gerade Anzahl von Parametern oder als ein einzelner Listenparameter mit einer geraden Anzahl von x- und y-Koordinatenwerten angegeben werden.

## Transformationen

Normalerweise liegt der Ursprung des Canvas-Koordinatensystems in der linken oberen Ecke des Fensters, das den Canvas enthält. Mit den Widget-Befehlen **xview** und **yview** lässt sich der Ursprung des Canvas-Koordinatensystems relativ zum Ursprung des Fensters verschieben; das wird typischerweise zum Scrollen verwendet. Canvas-Widgets unterstützen keine Skalierung oder Drehung des Canvas-Koordinatensystems relativ zum Koordinatensystem des Fensters.

Einzelne Elemente können mit den unten beschriebenen Widget-Befehlen verschoben, skaliert [oder gedreht]{version="9.0, TIP164"} werden.

Beachten Sie, dass der Standardursprung des sichtbaren Canvas-Bereichs mit dem Ursprung des gesamten Fensters zusammenfällt, weil das die Arbeit mit Bindungen erleichtert, die die Mausposition verwenden; die Widget-Befehle **canvasx** und **canvasy** brauchen Sie nur, wenn Sie den Ursprung des sichtbaren Bereichs verschieben. Das bedeutet aber auch, dass ein Fokusring (gesteuert durch die Option **-highlightthickness**) und der Fensterrand (gesteuert durch die Option **-borderwidth**) berücksichtigt werden müssen, bevor der sichtbare Bereich des Canvas beginnt.

# Indizes

Text-Elemente unterstützen das Konzept eines *Index*, mit dem bestimmte Positionen innerhalb des Elements bezeichnet werden. Auf ähnliche Weise unterstützen Linien- und Polygon-Elemente einen *Index*, mit dem Teilmengen ihrer Koordinaten bezeichnet, eingefügt und gelöscht werden. Indizes werden für Befehle verwendet, die zum Beispiel einen Bereich von Zeichen oder Koordinaten einfügen oder löschen oder die Position der Einfügemarke setzen. Ein Index kann auf verschiedene Weise angegeben werden, und verschiedene Elementtypen können unterschiedliche Formen der Indexangabe unterstützen. Text-Elemente unterstützen die folgenden Formen für einen Index; wenn Sie neue textähnliche Elementtypen definieren, ist es ratsam, so viele dieser Formen zu unterstützen, wie es praktikabel ist. Beachten Sie, dass Sie auf das Zeichen unmittelbar nach dem letzten Zeichen des Text-Elements verweisen können; das ist zum Beispiel nötig, um neuen Text am Ende des Elements einzufügen. Linien und Polygone unterstützen weder die Einfügemarke noch die Auswahl. Ihre Indizes sollen stets gerade sein, weil Koordinaten immer paarweise auftreten.

*number*
: Eine Dezimalzahl, die die Position des gewünschten Zeichens innerhalb des Text-Elements angibt. 0 bezeichnet das erste Zeichen, 1 das nächste Zeichen und so weiter. Sind die Indizes bei Linien und Polygonen ungerade, werden sie automatisch um eins verringert. Eine negative Zahl wird so behandelt, als wäre sie null, und eine Zahl, die größer als die Länge des Text-Elements ist, wird so behandelt, als wäre sie gleich der Länge des Text-Elements. Bei Polygonen werden negative Zahlen oder Zahlen, die größer als die Länge der Koordinatenliste sind, angepasst, indem die Länge addiert oder subtrahiert wird, bis das Ergebnis zwischen null und der Länge (einschließlich) liegt.

**end**
: Bezeichnet das Zeichen oder die Koordinate unmittelbar nach dem letzten im Element (entspricht der Anzahl der Zeichen bzw. Koordinaten im Element).

**insert**
: Bezeichnet das Zeichen, unmittelbar vor dem in diesem Element die Einfügemarke gezeichnet wird. Für Linien und Polygone nicht gültig.

**sel.first**
: Bezeichnet das erste ausgewählte Zeichen im Element. Liegt die Auswahl nicht in diesem Element, ist diese Form unzulässig.

**sel.last**
: Bezeichnet das letzte ausgewählte Zeichen im Element. Liegt die Auswahl nicht in diesem Element, ist diese Form unzulässig.

**@***x,y*
: Bezeichnet das Zeichen oder die Koordinate an dem durch *x* und *y* gegebenen Punkt, wobei *x* und *y* im Koordinatensystem des Canvas angegeben werden. Liegen *x* und *y* außerhalb der Koordinaten, die das Text-Element abdeckt, bezeichnen sie das erste oder letzte Zeichen in der Zeile, die dem angegebenen Punkt am nächsten liegt.


# Strichmuster

Viele Elemente unterstützen das Konzept eines Strichmusters für Umrisse.

Die erste mögliche Syntax ist eine Liste von Ganzzahlen. Jedes Listenelement gibt die Anzahl der Pixel eines Liniensegments an. Nur die ungeraden Segmente werden in der „outline“-Farbe gezeichnet. Die anderen Segmente werden transparent gezeichnet.

Die zweite mögliche Syntax ist eine Zeichenliste, die nur die 5 möglichen Zeichen „**.,-\_** “ enthält. Das Leerzeichen vergrößert den Abstand zwischen den anderen Linienelementen und darf nicht an erster Stelle der Zeichenkette stehen. Einige Beispiele:

```
-dash .     → -dash {2 4}
-dash -     → -dash {6 4}
-dash -.    → -dash {6 4 2 4}
-dash -..   → -dash {6 4 2 4 2 4}
-dash {. }  → -dash {2 8}
-dash ,     → -dash {4 4}
```

Der Hauptunterschied dieser Syntax zur vorherigen besteht darin, dass sie formerhaltend ist. Das bedeutet, dass alle Werte der Strichliste vor der Anzeige mit der Linienbreite multipliziert werden. So ist sichergestellt, dass „.“ unabhängig von der Linienbreite immer als Punkt und „-“ immer als Strich angezeigt wird.

Auf Systemen, die nur eine begrenzte Menge von Strichmustern unterstützen, wird das ähnlichste verfügbare Strichmuster angezeigt. Unter Windows sind zum Beispiel nur die ersten 4 der obigen Beispiele verfügbar. Die letzten 2 Beispiele werden genauso wie das erste angezeigt.

# Widget-Befehl

Der Befehl **canvas** erzeugt einen neuen Tcl-Befehl mit dem Namen *pathName*. Mit diesem Befehl können verschiedene Operationen auf dem Widget aufgerufen werden. Er hat die folgende allgemeine Form:

```
pathName option ?arg ...?
```

*Option* und die Argumente *arg* bestimmen das genaue Verhalten des Befehls. Folgende Widget-Befehle sind für Canvas-Widgets möglich:

[pathName]{.ins} [addtag]{.sub} [tag]{.arg} [searchSpec]{.arg} [arg]{.optdot}
: Fügt für jedes Element, das die durch *searchSpec* und die Argumente *arg* angegebenen Bedingungen erfüllt, *tag* zur Liste der Tags des Elements hinzu, sofern *tag* noch nicht in dieser Liste steht. Es kann vorkommen, dass kein Element die durch *searchSpec* und die Argumente *arg* gegebenen Bedingungen erfüllt; in diesem Fall hat der Befehl keine Wirkung. Der Befehl gibt als Ergebnis eine leere Zeichenkette zurück. *SearchSpec* und die Argumente *arg* können eine der folgenden Formen haben:

    **above** *tagOrId*
    : Wählt das Element, das in der Anzeigeliste unmittelbar nach (über) dem durch *tagOrId* angegebenen Element steht. Bezeichnet *tagOrId* mehr als ein Element, wird das letzte (oberste) dieser Elemente in der Anzeigeliste verwendet.

    **all**
    : Wählt alle Elemente im Canvas.

    **below** *tagOrId*
    : Wählt das Element, das in der Anzeigeliste unmittelbar vor (unter) dem durch *tagOrId* angegebenen Element steht. Bezeichnet *tagOrId* mehr als ein Element, wird das erste (unterste) dieser Elemente in der Anzeigeliste verwendet.

    **closest** *x y* ?*halo*? ?*start*?
    : Wählt das Element, das dem durch *x* und *y* gegebenen Punkt am nächsten liegt. Haben mehrere Elemente denselben kleinsten Abstand (z. B. weil zwei Elemente den Punkt überlappen), wird das oberste dieser Elemente (das letzte in der Anzeigeliste) verwendet. Wird *halo* angegeben, muss es ein nicht negativer Wert sein. Jedes Element, das näher als *halo* am Punkt liegt, gilt als den Punkt überlappend. Mit dem Argument *start* lassen sich alle nächstgelegenen Elemente zyklisch durchlaufen. Wird *start* angegeben, bezeichnet es ein Element über einen Tag oder eine ID (bei einem Tag wird das erste Element in der Anzeigeliste mit diesem Tag gewählt). Statt des obersten nächstgelegenen Elements wählt diese Form dann das oberste nächstgelegene Element, das in der Anzeigeliste unterhalb von *start* liegt; gibt es kein solches Element, verhält sich die Auswahl so, als wäre *start* nicht angegeben worden.

    **enclosed** *x1 y1 x2 y2*
    : Wählt alle Elemente, die vollständig innerhalb der durch *x1*, *y1*, *x2* und *y2* gegebenen rechteckigen Region liegen. *X1* darf nicht größer als *x2* sein, und *y1* darf nicht größer als *y2* sein.

    **overlapping** *x1 y1 x2 y2*
    : Wählt alle Elemente, die die durch *x1*, *y1*, *x2* und *y2* gegebene rechteckige Region überlappen oder vollständig darin liegen. *X1* darf nicht größer als *x2* sein, und *y1* darf nicht größer als *y2* sein.

    **withtag** *tagOrId*
    : Wählt alle durch *tagOrId* bezeichneten Elemente.


[pathName]{.ins} [bbox]{.sub} [tagOrId]{.arg} [tagOrId tagOrId]{.optdot}
: Gibt eine Liste mit vier Elementen zurück, die eine näherungsweise Bounding-Box für alle durch die Argumente *tagOrId* benannten Elemente angibt. Die Liste hat die Form „*x1 y1 x2 y2*“, sodass die gezeichneten Bereiche aller benannten Elemente innerhalb der Region liegen, die links durch *x1*, rechts durch *x2*, oben durch *y1* und unten durch *y2* begrenzt ist. Der Rückgabewert kann die tatsächliche Bounding-Box um einige Pixel überschätzen. Passt kein Element zu einem der Argumente *tagOrId* oder haben die passenden Elemente leere Bounding-Boxen (d. h. sie haben nichts anzuzeigen), wird eine leere Zeichenkette zurückgegeben.

[pathName]{.ins} [bind]{.sub} [tagOrId]{.arg} [sequence]{.optarg} [command]{.optarg}
: Dieser Befehl verknüpft *command* mit allen durch *tagOrId* angegebenen Elementen, sodass der Befehl immer dann aufgerufen wird, wenn die durch *sequence* angegebene Ereignisfolge für eines der Elemente eintritt. Dieser Widget-Befehl ähnelt dem Befehl [bind], wirkt aber auf Elemente in einem Canvas statt auf ganze Widgets. Die vollständige Beschreibung der Syntax von *sequence* und der Ersetzungen, die vor dem Aufruf in *command* vorgenommen werden, finden Sie auf der Handbuchseite [bind]. Werden alle Argumente angegeben, wird eine neue Bindung erzeugt, die eine bestehende Bindung für dieselbe *sequence* und dasselbe *tagOrId* ersetzt (ist das erste Zeichen von *command* ein „+“, ergänzt *command* die bestehende Bindung, statt sie zu ersetzen). In diesem Fall ist der Rückgabewert eine leere Zeichenkette. Fehlt *command*, gibt der Befehl den mit *tagOrId* und *sequence* verknüpften *command* zurück (gibt es keine solche Bindung, tritt ein Fehler auf). Fehlen sowohl *command* als auch *sequence*, gibt der Befehl eine Liste aller Ereignisfolgen zurück, für die Bindungen für *tagOrId* definiert wurden.

    Bindungen lassen sich nur für Ereignisse festlegen, die mit Maus und Tastatur zusammenhängen (etwa **Enter**, **Leave**, **Button**, **Motion** und **Key**), sowie für virtuelle Ereignisse. Die Ereignisbehandlung in Canvas-Widgets verwendet das aktuelle Element, das oben unter [Element-IDs und Tags] definiert ist. **Enter**- und **Leave**-Ereignisse werden für ein Element ausgelöst, wenn es zum aktuellen Element wird oder aufhört, das aktuelle Element zu sein; beachten Sie, dass sich diese Ereignisse von den **Enter**- und **Leave**-Ereignissen für Fenster unterscheiden. Mausbezogene Ereignisse werden an das aktuelle Element geleitet, sofern es eines gibt. Tastaturbezogene Ereignisse werden an das Fokus-Element geleitet, sofern es eines gibt (mehr dazu beim Widget-Befehl **focus** unten). Wird in einer Bindung ein virtuelles Ereignis verwendet, kann die Bindung nur ausgelöst werden, wenn das virtuelle Ereignis durch ein zugrunde liegendes Maus- oder Tastaturereignis definiert ist.

    Es ist möglich, dass mehrere Bindungen zu einem bestimmten Ereignis passen. Das kann zum Beispiel vorkommen, wenn eine Bindung mit der ID des Elements und eine andere mit einem der Tags des Elements verknüpft ist. In diesem Fall werden alle passenden Bindungen aufgerufen. Zuerst wird eine Bindung aufgerufen, die mit dem Tag **all** verknüpft ist, dann je eine Bindung für jeden Tag des Elements (in dessen Reihenfolge) und zuletzt eine Bindung, die mit der ID des Elements verknüpft ist. Gibt es für einen einzelnen Tag mehrere passende Bindungen, wird nur die spezifischste aufgerufen. Ein Befehl [continue] in einem Bindungsskript beendet dieses Skript, und ein Befehl [break] beendet dieses Skript und überspringt alle weiteren Skripte für das Ereignis, genau wie beim Befehl [bind].

    Wurden mit dem Befehl [bind] Bindungen für ein Canvas-Fenster erzeugt, werden sie zusätzlich zu den Bindungen aufgerufen, die mit dem Widget-Befehl **bind** für die Elemente des Canvas erzeugt wurden. Die Bindungen für Elemente werden vor allen Bindungen für das Fenster als Ganzes aufgerufen.

[pathName]{.ins} [canvasx]{.sub} [screenx]{.arg} [gridspacing]{.optarg}
: Zu einer Fenster-x-Koordinate *screenx* im Canvas gibt dieser Befehl die Canvas-x-Koordinate zurück, die an dieser Stelle angezeigt wird. Wird *gridspacing* angegeben, wird die Canvas-Koordinate auf das nächstliegende Vielfache von *gridspacing* Einheiten gerundet.

[pathName]{.ins} [canvasy]{.sub} [screeny]{.arg} [gridspacing]{.optarg}
: Zu einer Fenster-y-Koordinate *screeny* im Canvas gibt dieser Befehl die Canvas-y-Koordinate zurück, die an dieser Stelle angezeigt wird. Wird *gridspacing* angegeben, wird die Canvas-Koordinate auf das nächstliegende Vielfache von *gridspacing* Einheiten gerundet.

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der Konfigurationsoption *option* zurück. *Option* kann jeden der Werte haben, die der Befehl **canvas** akzeptiert.

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value]{.optarg} [option value]{.optdot}
: Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wird keine *option* angegeben, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (zum Format dieser Liste siehe [Tk\_ConfigureInfo][ConfigWidg]). Wird *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Werts, der zurückgegeben wird, wenn keine *option* angegeben ist). Werden ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Widget-Optionen auf die angegebenen Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden der Werte haben, die der Befehl **canvas** akzeptiert.

[pathName]{.ins} [coords]{.sub} [tagOrId]{.arg} [x0 y0]{.optdot}
: ...siehe nächstes...

[pathName]{.ins} [coords]{.sub} [tagOrId]{.arg} [coordList]{.optarg}
: Fragt die Koordinaten ab, die ein Element definieren, oder ändert sie. Werden keine Koordinaten angegeben, gibt der Befehl eine Liste zurück, deren Elemente die Koordinaten des durch *tagOrId* benannten Elements sind. Werden Koordinaten angegeben, ersetzen sie die aktuellen Koordinaten des benannten Elements. Bezeichnet *tagOrId* mehrere Elemente, wird das erste in der Anzeigeliste verwendet.

    Beachten Sie, dass bei Rechtecken, Ovalen und Bögen die zurückgegebene Koordinatenliste eine feste Reihenfolge hat, nämlich linke, obere, rechte und untere Koordinate; das ist nicht unbedingt die ursprünglich angegebene Reihenfolge. Außerdem werden die Koordinaten immer in Bildschirmeinheiten ohne Einheitenangabe zurückgegeben (also in Pixeln). Wurden die ursprünglichen Koordinaten zum Beispiel in Zentimetern oder Zoll angegeben, sind die zurückgegebenen Werte trotzdem in Pixeln.

[pathName]{.ins} [create]{.sub} [type]{.arg} [x]{.arg} [y]{.arg} [x y]{.optdot} [option value]{.optdot}
: ...siehe nächstes...

[pathName]{.ins} [create]{.sub} [type]{.arg} [coordList]{.arg} [option value]{.optdot}
: Erzeugt in *pathName* ein neues Element vom Typ *type*. Das genaue Format der Argumente nach *type* hängt von *type* ab; meist bestehen sie aus den Koordinaten eines oder mehrerer Punkte, gefolgt von Angaben für null oder mehr Elementoptionen. Mehr zur Syntax dieses Befehls finden Sie in den Unterabschnitten zu den einzelnen Elementtypen unten. Der Befehl gibt die ID des neuen Elements zurück.

[pathName]{.ins} [dchars]{.sub} [tagOrId]{.arg} [first]{.arg} [last]{.optarg}
: Löscht für jedes durch *tagOrId* angegebene Element die Zeichen oder Koordinaten im Bereich von *first* bis einschließlich *last*. Unterstützen einige der durch *tagOrId* angegebenen Elemente keine Indexoperationen, ignorieren sie diese Operation. Text-Elemente interpretieren *first* und *last* als Indizes auf ein Zeichen, Linien- und Polygon-Elemente als Indizes auf eine Koordinate (ein x,y-Paar). Indizes sind oben unter [Indizes] beschrieben. Fehlt *last*, wird standardmäßig *first* verwendet. Der Befehl gibt eine leere Zeichenkette zurück.

[pathName]{.ins} [delete]{.sub} [tagOrId tagOrId]{.optdot}
: Löscht alle Elemente, die durch die einzelnen *tagOrId* angegeben sind, und gibt eine leere Zeichenkette zurück.

[pathName]{.ins} [dtag]{.sub} [tagOrId]{.arg} [tagToDelete]{.optarg}
: Entfernt bei jedem durch *tagOrId* angegebenen Element den Tag *tagToDelete* aus der Liste der Tags, die dem Element zugeordnet sind. Hat ein Element den Tag *tagToDelete* nicht, bleibt es von dem Befehl unberührt. Fehlt *tagToDelete*, wird standardmäßig *tagOrId* verwendet. Der Befehl gibt eine leere Zeichenkette zurück.

[pathName]{.ins} [find]{.sub} [searchCommand]{.arg} [arg]{.optdot}
: Dieser Befehl gibt eine Liste aller Elemente zurück, die die durch *searchCommand* und die Argumente *arg* angegebenen Bedingungen erfüllen. *SearchCommand* und *args* können jede der Formen haben, die der Befehl **addtag** akzeptiert. Die Elemente werden in Stapelreihenfolge zurückgegeben, das unterste Element zuerst.

[pathName]{.ins} [focus]{.sub} [tagOrId]{.optarg}
: Setzt den Tastaturfokus des Canvas-Widgets auf das durch *tagOrId* angegebene Element. Bezeichnet *tagOrId* mehrere Elemente, wird der Fokus auf das erste dieser Elemente in der Anzeigeliste gesetzt, das die Einfügemarke unterstützt. Bezeichnet *tagOrId* kein Element oder unterstützt keines davon die Einfügemarke, bleibt der Fokus unverändert. Ist *tagOrId* eine leere Zeichenkette, wird das Fokus-Element zurückgesetzt, sodass kein Element den Fokus hat. Wird *tagOrId* nicht angegeben, gibt der Befehl die ID des Elements zurück, das gerade den Fokus hat, oder eine leere Zeichenkette, wenn kein Element den Fokus hat.

    Sobald der Fokus auf ein Element gesetzt ist, zeigt das Element die Einfügemarke an, und alle Tastaturereignisse werden an dieses Element geleitet. Das Fokus-Element innerhalb eines Canvas und das Fokus-Fenster auf dem Bildschirm (gesetzt mit dem Befehl [focus]) sind völlig unabhängig voneinander: Ein Element hat den Eingabefokus nur dann tatsächlich, wenn (a) sein Canvas das Fokus-Fenster ist und (b) das Element das Fokus-Element innerhalb des Canvas ist. In den meisten Fällen ist es ratsam, nach dem Widget-Befehl **focus** den Befehl [focus] aufzurufen, um das Fokus-Fenster auf den Canvas zu setzen (falls es nicht schon dort liegt).

[pathName]{.ins} [gettags]{.sub} [tagOrId]{.arg}
: Gibt eine Liste zurück, deren Elemente die Tags sind, die dem durch *tagOrId* angegebenen Element zugeordnet sind. Bezeichnet *tagOrId* mehr als ein Element, werden die Tags des ersten dieser Elemente in der Anzeigeliste zurückgegeben. Bezeichnet *tagOrId* kein Element oder hat das Element keine Tags, wird eine leere Zeichenkette zurückgegeben.

[pathName]{.ins} [icursor]{.sub} [tagOrId]{.arg} [index]{.arg}
: Setzt die Position der Einfügemarke für das oder die durch *tagOrId* angegebenen Elemente unmittelbar vor das Zeichen, dessen Position durch *index* gegeben ist. Unterstützen einige oder alle der durch *tagOrId* angegebenen Elemente keine Einfügemarke, hat dieser Befehl auf sie keine Wirkung. Die zulässigen Formen für *index* sind oben unter [Indizes] beschrieben.

    Beachten Sie, dass die Einfügemarke in einem Element nur angezeigt wird, wenn dieses Element gerade den Tastaturfokus hat (siehe den Widget-Befehl **focus** oben); die Position der Einfügemarke kann aber auch gesetzt werden, wenn das Element den Fokus nicht hat.

    Der Befehl gibt eine leere Zeichenkette zurück.

[pathName]{.ins} [image]{.sub} [imagename]{.arg} [subsample]{.optarg} [zoom]{.optarg}
: Zeichnet den Canvas in das Tk-Foto-Image mit dem Namen *imagename*. Wurde eine **-scrollregion** festgelegt, bestimmt sie die Grenzen der gezeichneten Canvas-Region und die endgültige Größe des Foto-Images. Andernfalls bestimmen Breite und Höhe des Widgets mit dem Ursprung 0,0 die Größe der gezeichneten Canvas-Region und die endgültige Größe des Foto-Images. Optional kann ein ganzzahliger Faktor *subsample* angegeben werden; das Foto-Image wird dann verkleinert.

    Zusätzlich zu *subsample* kann auch ein ganzzahliger Faktor *zoom* angegeben werden; das Foto-Image wird dann vergrößert. Der Hintergrund des Bildes wird mit der Hintergrundfarbe des Canvas gefüllt. Das Canvas-Widget muss nicht gemappt sein, damit dieser Widget-Befehl funktioniert, aber mindestens einer seiner Vorfahren muss gemappt sein.

    Der Befehl gibt eine leere Zeichenkette zurück.

[pathName]{.ins} [imove]{.sub} [tagOrId]{.arg} [index]{.arg} [x]{.arg} [y]{.arg}
: Dieser Befehl versetzt die Koordinate mit dem Index *index* jedes durch *tagOrId* angegebenen Elements an die Position (*x*,*y*). Jedes Element interpretiert *index* unabhängig nach den Regeln, die oben unter [Indizes] beschrieben sind. Von den Standard-Elementtypen lassen sich nur bei Linien- und Polygon-Elementen die Koordinaten auf diese Weise versetzen.

[pathName]{.ins} [index]{.sub} [tagOrId]{.arg} [index]{.arg}
: Dieser Befehl gibt eine Dezimalzeichenkette zurück, die den numerischen Index innerhalb von *tagOrId* angibt, der *index* entspricht. *Index* beschreibt die gewünschte Position in Textform, wie oben unter [Indizes] beschrieben. Text-Elemente interpretieren *index* als Index auf ein Zeichen, Linien- und Polygon-Elemente als Index auf eine Koordinate (ein x,y-Paar). Der Rückgabewert liegt garantiert zwischen 0 und der Anzahl der Zeichen bzw. Koordinaten im Element (jeweils einschließlich). Bezeichnet *tagOrId* mehrere Elemente, wird der Index im ersten dieser Elemente (in der Reihenfolge der Anzeigeliste) verarbeitet, das Indexoperationen unterstützt.

[pathName]{.ins} [insert]{.sub} [tagOrId]{.arg} [beforeThis]{.arg} [string]{.arg}
: Für jedes durch *tagOrId* angegebene Element, das das Einfügen von Text oder Koordinaten unterstützt, wird *string* unmittelbar vor dem Zeichen bzw. der Koordinate mit dem Index *beforeThis* in den Text des Elements eingefügt. Text-Elemente interpretieren *beforeThis* als Index auf ein Zeichen, Linien- und Polygon-Elemente als Index auf eine Koordinate (ein x,y-Paar). Bei Linien und Polygonen muss *string* eine gültige Koordinatenfolge sein.

    Die zulässigen Formen für *beforeThis* sind oben unter [Indizes] beschrieben.

    Der Befehl gibt eine leere Zeichenkette zurück.

[pathName]{.ins} [itemcget]{.sub} [tagOrId]{.arg} [option]{.arg}
: Gibt den aktuellen Wert der Konfigurationsoption mit dem Namen *option* für das durch *tagOrId* angegebene Element zurück. Dieser Befehl ähnelt dem Widget-Befehl **cget**, bezieht sich aber auf ein bestimmtes Element statt auf das Widget als Ganzes. *Option* kann jeden der Werte haben, die der Widget-Befehl **create** beim Erzeugen des Elements akzeptiert. Ist *tagOrId* ein Tag, der mehr als ein Element bezeichnet, wird das erste (unterste) dieser Elemente verwendet.

[pathName]{.ins} [itemconfigure]{.sub} [tagOrId]{.arg} [option]{.optarg} [value]{.optarg} [option value]{.optdot}
: Dieser Befehl ähnelt dem Widget-Befehl **configure**, ändert aber elementspezifische Optionen der durch *tagOrId* angegebenen Elemente statt der Optionen des gesamten Canvas-Widgets. Wird keine *option* angegeben, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für das erste durch *tagOrId* angegebene Element beschreibt (zum Format dieser Liste siehe [Tk\_ConfigureInfo][ConfigWidg]). Wird *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Werts, der zurückgegeben wird, wenn keine *option* angegeben ist). Werden ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Optionen in jedem der durch *tagOrId* angegebenen Elemente auf die angegebenen Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. Die *option*- und *value*-Angaben sind dieselben, die beim Erzeugen der Elemente im Widget-Befehl **create** zulässig sind; die zulässigen Optionen sind in den Abschnitten zu den einzelnen Elementtypen unten beschrieben.

[pathName]{.ins} [lower]{.sub} [tagOrId]{.arg} [belowThis]{.optarg}
: Verschiebt alle durch *tagOrId* angegebenen Elemente an eine neue Position in der Anzeigeliste, unmittelbar vor das durch *belowThis* angegebene Element. Bezeichnet *tagOrId* mehr als ein Element, werden alle verschoben, ihre Reihenfolge untereinander bleibt jedoch erhalten. *BelowThis* ist ein Tag oder eine ID; bezeichnet es mehr als ein Element, wird das erste (unterste) dieser Elemente in der Anzeigeliste als Zielposition für die verschobenen Elemente verwendet. Beachten Sie, dass dieser Befehl auf Fenster-Elemente keine Wirkung hat. Fenster-Elemente verdecken stets alle anderen Elementtypen, und die Stapelreihenfolge der Fenster-Elemente wird durch die Befehle [raise] und [lower] bestimmt, nicht durch die Widget-Befehle **raise** und **lower** des Canvas. Der Befehl gibt eine leere Zeichenkette zurück.

[pathName]{.ins} [move]{.sub} [tagOrId]{.arg} [xAmount]{.arg} [yAmount]{.arg}
: Verschiebt jedes durch *tagOrId* angegebene Element im Koordinatenraum des Canvas, indem *xAmount* zur x-Koordinate und *yAmount* zur y-Koordinate jedes Punkts des Elements addiert wird. Der Befehl gibt eine leere Zeichenkette zurück.

[pathName]{.ins} [moveto]{.sub} [tagOrId]{.arg} [xPos]{.arg} [yPos]{.arg}
: Verschiebt die durch *tagOrId* angegebenen Elemente im Koordinatenraum des Canvas so, dass das erste Koordinatenpaar (die linke obere Ecke der Bounding-Box) des ersten Elements (des untersten in der Anzeigeliste) mit dem Tag *tagOrId* an der Position (*xPos*,*yPos*) liegt. *xPos* und *yPos* dürfen leere Zeichenketten sein; die entsprechende Koordinate bleibt dann unverändert. Alle zu *tagOrId* passenden Elemente behalten ihre Lage zueinander. Der Befehl gibt eine leere Zeichenkette zurück.

[pathName]{.ins} [postscript]{.sub} [option value option value]{.optdot}
: Erzeugt eine Postscript-Darstellung eines Teils oder des gesamten Canvas. Wird die Option **-file** angegeben, wird das Postscript in eine Datei geschrieben und eine leere Zeichenkette zurückgegeben; andernfalls wird das Postscript als Ergebnis des Befehls zurückgegeben. Ist der Interpreter, dem der Canvas gehört, als sicher markiert, schlägt die Operation fehl, weil sichere Interpreter keine Dateien schreiben dürfen. Wird die Option **-channel** angegeben, bezeichnet das Argument den Namen eines Kanals, der bereits zum Schreiben geöffnet ist. Das Postscript wird in diesen Kanal geschrieben, und der Kanal bleibt am Ende der Operation für weiteres Schreiben geöffnet. Das Postscript wird als Encapsulated Postscript nach Version 3.0 der Document Structuring Conventions erzeugt. Hinweis: Standardmäßig wird Postscript nur für die Informationen erzeugt, die im Fenster des Canvas auf dem Bildschirm erscheinen. Ein frisch erzeugter Canvas hat unter Umständen noch seine Anfangsgröße von 1×1 Pixel, sodass im Postscript nichts erscheint. Um dieses Problem zu umgehen, rufen Sie entweder den Befehl [update] auf, um zu warten, bis das Canvas-Fenster seine endgültige Größe erreicht hat, oder Sie legen mit den Optionen **-width** und **-height** den zu druckenden Bereich des Canvas fest. Die Argumentpaare *option*-*value* liefern zusätzliche Angaben zur Steuerung der Postscript-Erzeugung. Die folgenden Optionen werden unterstützt:

    [-channel]{.lit} [channelName]{.arg}
    : Legt den Namen des Kanals fest, in den das Postscript geschrieben wird. Werden weder diese Option noch die Option **-file** angegeben, wird das Postscript als Ergebnis des Befehls zurückgegeben.

    [-colormap]{.lit} [varName]{.arg}
    : *VarName* muss der Name einer Array-Variablen sein, die eine Farbzuordnung für das Postscript festlegt. Jedes Element von *varName* muss aus Postscript-Code bestehen, der einen bestimmten Farbwert setzt (z. B. „**1.0 1.0 0.0 setrgbcolor**“). Bei der Ausgabe von Farbinformationen im Postscript prüft Tk, ob es in *varName* ein Element mit demselben Namen wie die Farbe gibt. Ist das der Fall, verwendet Tk den Wert dieses Elements als Postscript-Befehl zum Setzen der Farbe.

        Wurde diese Option nicht angegeben oder gibt es in *varName* keinen Eintrag für eine bestimmte Farbe, verwendet Tk die Rot-, Grün- und Blauintensitäten der X-Farbe.

    [-colormode]{.lit} [mode]{.arg}
    : Legt fest, wie Farbinformationen ausgegeben werden. *Mode* muss entweder **color** (für vollfarbige Ausgabe), **gray** (alle Farben in ihre Graustufenentsprechungen umwandeln) oder **mono** (alle Farben in Schwarz oder Weiß umwandeln) sein.

    [-file]{.lit} [fileName]{.arg}
    : Legt den Namen der Datei fest, in die das Postscript geschrieben wird. Werden weder diese Option noch die Option **-channel** angegeben, wird das Postscript als Ergebnis des Befehls zurückgegeben.

    [-fontmap]{.lit} [varName]{.arg}
    : *VarName* muss der Name einer Array-Variablen sein, die eine Schriftzuordnung für das Postscript festlegt. Jedes Element von *varName* muss eine Tcl-Liste mit zwei Elementen sein, nämlich dem Namen und der Punktgröße einer Postscript-Schriftart. Bei der Ausgabe von Postscript-Befehlen für eine bestimmte Schriftart prüft Tk, ob *varName* ein Element mit demselben Namen wie die Schriftart enthält. Gibt es ein solches Element, werden die darin enthaltenen Schriftinformationen im Postscript verwendet. Andernfalls versucht Tk zu erraten, welche Postscript-Schriftart verwendet werden soll. Die Vermutungen von Tk funktionieren in der Regel nur bei bekannten Schriftarten wie Times, Helvetica und Courier und nur dann, wenn im X-Schriftnamen bis einschließlich der Punktgröße keine Bindestriche fehlen.

        So funktioniert zum Beispiel **-\*-Courier-Bold-R-Normal--\*-120-\***, **\*Courier-Bold-R-Normal\*120\*** dagegen nicht; Tk braucht die Bindestriche, um den Schriftnamen zu zerlegen).

    [-height]{.lit} [size]{.arg}
    : Legt die Höhe des zu druckenden Bereichs des Canvas fest. Der Standardwert ist die Höhe des Canvas-Fensters.

    [-pageanchor]{.lit} [anchor]{.arg}
    : Legt fest, welcher Punkt des gedruckten Bereichs des Canvas über dem Positionierungspunkt auf der Seite liegen soll (dieser wird durch die Optionen **-pagex** und **-pagey** angegeben).

        So bedeutet zum Beispiel **-pageanchor n**, dass die obere Mitte des gedruckten Canvas-Bereichs (wie er im Canvas-Fenster erscheint) über dem Positionierungspunkt liegen soll. Der Standardwert ist **center**.

    [-pageheight]{.lit} [size]{.arg}
    : Legt fest, dass das Postscript in x- und y-Richtung so skaliert wird, dass der gedruckte Bereich auf der Postscript-Seite *size* hoch ist. *Size* besteht aus einer Gleitkommazahl, gefolgt von **c** für Zentimeter, **i** für Zoll, **m** für Millimeter oder **p** bzw. nichts für Druckerpunkte (1/72 Zoll). Der Standardwert ist die Höhe des gedruckten Bereichs auf dem Bildschirm. Werden sowohl **-pageheight** als auch **-pagewidth** angegeben, wird der Skalierungsfaktor von **-pagewidth** verwendet (ungleichmäßige Skalierung ist nicht implementiert).

    [-pagewidth]{.lit} [size]{.arg}
    : Legt fest, dass das Postscript in x- und y-Richtung so skaliert wird, dass der gedruckte Bereich auf der Postscript-Seite *size* breit ist. *Size* hat dieselbe Form wie bei **-pageheight**. Der Standardwert ist die Breite des gedruckten Bereichs auf dem Bildschirm. Werden sowohl **-pageheight** als auch **-pagewidth** angegeben, wird der Skalierungsfaktor von **-pagewidth** verwendet (ungleichmäßige Skalierung ist nicht implementiert).

    [-pagex]{.lit} [position]{.arg}
    : *Position* gibt die x-Koordinate des Positionierungspunkts auf der Postscript-Seite an, in einer der Formen, die für **-pageheight** zulässig sind. Zusammen mit den Optionen **-pagey** und **-pageanchor** bestimmt sie, wo der gedruckte Bereich auf der Postscript-Seite erscheint. Der Standardwert ist die Mitte der Seite.

    [-pagey]{.lit} [position]{.arg}
    : *Position* gibt die y-Koordinate des Positionierungspunkts auf der Postscript-Seite an, in einer der Formen, die für **-pageheight** zulässig sind. Zusammen mit den Optionen **-pagex** und **-pageanchor** bestimmt sie, wo der gedruckte Bereich auf der Postscript-Seite erscheint. Der Standardwert ist die Mitte der Seite.

    [-rotate]{.lit} [boolean]{.arg}
    : *Boolean* legt fest, ob der gedruckte Bereich um 90 Grad gedreht werden soll. Bei nicht gedrehter Ausgabe verläuft die x-Achse des gedruckten Bereichs entlang der kurzen Kante der Seite („Hochformat“); bei gedrehter Ausgabe verläuft die x-Achse entlang der langen Kante der Seite („Querformat“). Standardmäßig wird nicht gedreht.

    [-width]{.lit} [size]{.arg}
    : Legt die Breite des zu druckenden Bereichs des Canvas fest. Der Standardwert ist die Breite des Canvas-Fensters.

    [-x]{.lit} [position]{.arg}
    : Legt die x-Koordinate des linken Rands des zu druckenden Canvas-Bereichs fest, und zwar in Canvas-Koordinaten, nicht in Fensterkoordinaten. Der Standardwert ist die Koordinate des linken Fensterrands.

    [-y]{.lit} [position]{.arg}
    : Legt die y-Koordinate des oberen Rands des zu druckenden Canvas-Bereichs fest, und zwar in Canvas-Koordinaten, nicht in Fensterkoordinaten. Der Standardwert ist die Koordinate des oberen Fensterrands.


[pathName]{.ins} [raise]{.sub} [tagOrId]{.arg} [aboveThis]{.optarg}
: Verschiebt alle durch *tagOrId* angegebenen Elemente an eine neue Position in der Anzeigeliste, unmittelbar nach dem durch *aboveThis* angegebenen Element. Bezeichnet *tagOrId* mehr als ein Element, werden alle verschoben, ihre Reihenfolge untereinander bleibt jedoch erhalten. *AboveThis* ist ein Tag oder eine ID; bezeichnet es mehr als ein Element, wird das letzte (oberste) dieser Elemente in der Anzeigeliste als Zielposition für die verschobenen Elemente verwendet. Der Befehl gibt eine leere Zeichenkette zurück.

    Beachten Sie, dass dieser Befehl auf Fenster-Elemente keine Wirkung hat. Fenster-Elemente verdecken stets alle anderen Elementtypen, und die Stapelreihenfolge der Fenster-Elemente wird durch die Befehle [raise] und [lower] bestimmt, nicht durch die Widget-Befehle **raise** und **lower** des Canvas.

[pathName]{.ins} [rchars]{.sub} [tagOrId]{.arg} [first]{.arg} [last]{.arg} [string]{.arg}
: Dieser Befehl ersetzt bei jedem durch *tagOrId* angegebenen Element den Text bzw. die Koordinaten zwischen *first* und *last* durch *string*. Jedes Element interpretiert *first* und *last* unabhängig nach den Regeln, die oben unter [Indizes] beschrieben sind. Von den Standard-Elementtypen unterstützen Text-Elemente diese Operation, indem sie ihren Text entsprechend ändern, und Linien- und Polygon-Elemente, indem sie ihre Koordinatenliste ändern (in diesem Fall sollte *string* eine Liste der Ersatzkoordinaten sein). Die anderen Elemente ignorieren diese Operation.

[pathName]{.ins} [rotate]{.sub} [tagOrId]{.arg} [xOrigin]{.arg} [yOrigin]{.arg} [angle]{.arg}
: [Dreht die Koordinaten aller durch *tagOrId* angegebenen Elemente im Koordinatenraum des Canvas. *XOrigin* und *yOrigin* bezeichnen den Ursprung der Drehung, und *angle* gibt an, um wie viel Grad die Koordinaten gegen den Uhrzeigersinn gedreht werden. (Negative Werte drehen im Uhrzeigersinn.) Der Befehl gibt eine leere Zeichenkette zurück.]{version="9.0, TIP164"}

    Hinweis zur Implementierung: Nicht alle Elementtypen verhalten sich bei Drehungen gleich. Insbesondere drehen **bitmap**-, **image**-, **text**- und **window**-Elemente nur ihre Ankerpunkte und nicht die Elemente selbst um diese Punkte, und die Typen **arc**, **oval** und **rectangle** drehen sich um einen berechneten Mittelpunkt, statt die Koordinaten der Bounding-Box direkt zu verschieben.

    Einige Elemente (derzeit **arc** und **text**) haben Winkel in ihren Optionen; dieser Befehl wirkt sich *nicht* auf diese Optionen aus.

[pathName]{.ins} [scale]{.sub} [tagOrId]{.arg} [xOrigin]{.arg} [yOrigin]{.arg} [xScale]{.arg} [yScale]{.arg}
: Skaliert die Koordinaten aller durch *tagOrId* angegebenen Elemente im Koordinatenraum des Canvas neu. *XOrigin* und *yOrigin* bezeichnen den Ursprung der Skalierung, und *xScale* und *yScale* geben die Skalierungsfaktoren für die x- bzw. y-Koordinaten an (ein Skalierungsfaktor von 1.0 bedeutet, dass sich die betreffende Koordinate nicht ändert). Für jeden Punkt, der ein Element definiert, wird die x-Koordinate so angepasst, dass sich ihr Abstand von *xOrigin* um den Faktor *xScale* ändert. Ebenso wird jede y-Koordinate so angepasst, dass sich ihr Abstand von *yOrigin* um den Faktor *yScale* ändert. Der Befehl gibt eine leere Zeichenkette zurück.

    Beachten Sie, dass einige Elemente nur ein einziges Koordinatenpaar haben (z. B. Text, Bilder und Fenster); dieser Befehl kann sie beim Skalieren daher nur verschieben.

[pathName]{.ins} [scan]{.sub} [option]{.arg} [args]{.arg}
: Dieser Befehl dient dazu, das Scannen in Canvas-Widgets zu implementieren. Er hat je nach *option* zwei Formen:

    [pathName]{.ins} [scan]{.sub} [mark]{.lit} [x]{.arg} [y]{.arg}
    : Speichert *x* und *y* sowie die aktuelle Ansicht des Canvas; wird zusammen mit späteren **scan dragto**-Befehlen verwendet. Typischerweise ist dieser Befehl mit einem Maustastendruck im Widget verknüpft, und *x* und *y* sind die Koordinaten der Maus. Er gibt eine leere Zeichenkette zurück.

    [pathName]{.ins} [scan]{.sub} [dragto]{.lit} [x]{.arg} [y]{.arg} ?gain?
    : Dieser Befehl berechnet die Differenz zwischen seinen Argumenten *x* und *y* (typischerweise Mauskoordinaten) und den Argumenten *x* und *y* des letzten **scan mark**-Befehls für das Widget. Dann verschiebt er die Ansicht um das *gain*-fache der Koordinatendifferenz, wobei *gain* standardmäßig 10 ist. Dieser Befehl ist typischerweise mit Mausbewegungsereignissen im Widget verknüpft, um den Effekt zu erzeugen, dass der Canvas mit hoher Geschwindigkeit durch sein Fenster gezogen wird. Der Rückgabewert ist eine leere Zeichenkette.


[pathName]{.ins} [select]{.sub} [option]{.arg} [tagOrId arg]{.optarg}
: Manipuliert die Auswahl je nach *option* auf eine von mehreren Arten. Der Befehl kann jede der unten beschriebenen Formen haben. In allen folgenden Beschreibungen muss *tagOrId* ein Element bezeichnen, das Indexierung und Auswahl unterstützt; bezeichnet es mehrere Elemente, wird das erste davon verwendet, das Indexierung und Auswahl unterstützt. *Index* beschreibt in Textform eine Position innerhalb von *tagOrId*, wie oben unter [Indizes] beschrieben.

    [pathName]{.ins} [select]{.sub} [adjust]{.lit} [tagOrId]{.arg} [index]{.arg}
    : Sucht das Ende der Auswahl in *tagOrId*, das dem durch *index* angegebenen Zeichen am nächsten liegt, und setzt dieses Ende der Auswahl auf *index* (d. h. einschließlich *index*, aber nicht darüber hinaus). Das andere Ende der Auswahl wird zum Ankerpunkt für künftige **select to**-Befehle. Liegt die Auswahl gerade nicht in *tagOrId*, verhält sich dieser Befehl wie der Widget-Befehl **select to**. Gibt eine leere Zeichenkette zurück.

    [pathName]{.ins} [select]{.sub} [clear]{.lit}
    : Hebt die Auswahl auf, wenn sie in diesem Widget liegt. Liegt die Auswahl nicht in diesem Widget, hat der Befehl keine Wirkung. Gibt eine leere Zeichenkette zurück.

    [pathName]{.ins} [select]{.sub} [from]{.lit} [tagOrId]{.arg} [index]{.arg}
    : Setzt den Auswahl-Ankerpunkt des Widgets unmittelbar vor das durch *index* angegebene Zeichen in dem durch *tagOrId* angegebenen Element. Dieser Befehl ändert die Auswahl nicht; er setzt nur das feste Ende der Auswahl für künftige **select to**-Befehle. Gibt eine leere Zeichenkette zurück.

    [pathName]{.ins} [select]{.sub} [item]{.lit}
    : Gibt die ID des ausgewählten Elements zurück, wenn die Auswahl in einem Element dieses Canvas liegt. Liegt die Auswahl nicht in diesem Canvas, wird eine leere Zeichenkette zurückgegeben.

    [pathName]{.ins} [select]{.sub} [to]{.lit} [tagOrId]{.arg} [index]{.arg}
    : Setzt die Auswahl auf die Zeichen von *tagOrId* zwischen dem Auswahl-Ankerpunkt und *index*. Die neue Auswahl schließt das durch *index* angegebene Zeichen ein; das Zeichen am Ankerpunkt schließt sie nur ein, wenn *index* größer oder gleich dem Ankerpunkt ist. Der Ankerpunkt wird durch den letzten **select adjust**- oder **select from**-Befehl für dieses Widget bestimmt. Liegt der Auswahl-Ankerpunkt des Widgets gerade nicht in *tagOrId*, wird er auf dasselbe Zeichen gesetzt, das *index* angibt. Gibt eine leere Zeichenkette zurück.


[pathName]{.ins} [type]{.sub} [tagOrId]{.arg}
: Gibt den Typ des durch *tagOrId* angegebenen Elements zurück, etwa **rectangle** oder **text**. Bezeichnet *tagOrId* mehr als ein Element, wird der Typ des ersten Elements in der Anzeigeliste zurückgegeben. Bezeichnet *tagOrId* überhaupt kein Element, wird eine leere Zeichenkette zurückgegeben.

[pathName]{.ins} [xview]{.sub} [args]{.optarg}
: Dieser Befehl dient dazu, die horizontale Position der im Fenster des Canvas angezeigten Informationen abzufragen und zu ändern. Er kann jede der folgenden Formen haben:

    [pathName]{.ins} [xview]{.sub}
    : Gibt eine Liste mit zwei Elementen zurück. Jedes Element ist ein reeller Bruch zwischen 0 und 1; zusammen beschreiben sie den horizontalen Bereich, der im Fenster sichtbar ist. Ist zum Beispiel das erste Element .2 und das zweite .6, liegen 20 % der Fläche des Canvas (wie durch die Option **-scrollregion** festgelegt) links außerhalb des sichtbaren Bereichs, die mittleren 40 % sind im Fenster sichtbar, und 40 % des Canvas liegen rechts außerhalb des sichtbaren Bereichs. Das sind dieselben Werte, die über die Option **-xscrollcommand** an Scrollbars übergeben werden.

    [pathName]{.ins} [xview]{.sub} [moveto]{.lit} [fraction]{.arg}
    : Passt die Ansicht im Fenster so an, dass der Anteil *fraction* der Gesamtbreite des Canvas links außerhalb des sichtbaren Bereichs liegt. *Fraction* muss ein Bruch zwischen 0 und 1 sein.

    [pathName]{.ins} [xview]{.sub} [scroll]{.lit} [number]{.arg} [what]{.arg}
    : Dieser Befehl verschiebt die Ansicht im Fenster abhängig von *number* und *what* nach links oder rechts. *Number* muss eine Ganzzahl oder eine Gleitkommazahl sein; eine Gleitkommazahl wird in eine Ganzzahl umgewandelt, wobei von 0 weg gerundet wird. *What* muss entweder **pages** oder **units** oder eine Abkürzung davon sein. Ist *what* **pages**, wird die Ansicht in Einheiten von neun Zehnteln der Fensterbreite verschoben. Ist *number* negativ, werden weiter links liegende Informationen sichtbar; ist es positiv, werden weiter rechts liegende Informationen sichtbar. Ist *what* **units**, wird die Ansicht in Einheiten der Option **xScrollIncrement** nach links oder rechts verschoben, sofern diese größer als null ist, andernfalls in Einheiten von einem Zehntel der Fensterbreite.


[pathName]{.ins} [yview]{.sub} [args]{.optarg}
: Dieser Befehl dient dazu, die vertikale Position der im Fenster des Canvas angezeigten Informationen abzufragen und zu ändern. Er kann jede der folgenden Formen haben:

    [pathName]{.ins} [yview]{.sub}
    : Gibt eine Liste mit zwei Elementen zurück. Jedes Element ist ein reeller Bruch zwischen 0 und 1; zusammen beschreiben sie den vertikalen Bereich, der im Fenster sichtbar ist. Ist zum Beispiel das erste Element .6 und das zweite 1.0, sind die untersten 40 % der Fläche des Canvas (wie durch die Option **-scrollregion** festgelegt) im Fenster sichtbar. Das sind dieselben Werte, die über die Option **-yscrollcommand** an Scrollbars übergeben werden.

    [pathName]{.ins} [yview]{.sub} [moveto]{.lit} [fraction]{.arg}
    : Passt die Ansicht im Fenster so an, dass der Anteil *fraction* der Fläche des Canvas oben außerhalb des sichtbaren Bereichs liegt. *Fraction* ist ein Bruch zwischen 0 und 1.

    [pathName]{.ins} [yview]{.sub} [scroll]{.lit} [number]{.arg} [what]{.arg}
    : Dieser Befehl verschiebt die Ansicht im Fenster abhängig von *number* und *what* nach oben oder unten. *Number* muss eine Ganzzahl oder eine Gleitkommazahl sein; eine Gleitkommazahl wird in eine Ganzzahl umgewandelt, wobei von 0 weg gerundet wird. *What* muss entweder **pages** oder **units** sein. Ist *what* **pages**, wird die Ansicht in Einheiten von neun Zehnteln der Fensterhöhe verschoben. Ist *number* negativ, werden weiter oben liegende Informationen sichtbar; ist es positiv, werden weiter unten liegende Informationen sichtbar. Ist *what* **units**, wird die Ansicht in Einheiten der Option **yScrollIncrement** nach oben oder unten verschoben, sofern diese größer als null ist, andernfalls in Einheiten von einem Zehntel der Fensterhöhe.



# Überblick über die Elementtypen

Die folgenden Abschnitte beschreiben die verschiedenen Elementtypen, die Canvas-Widgets unterstützen. Jeder Elementtyp ist durch zwei Dinge gekennzeichnet: erstens durch die Form des **create**-Befehls, mit dem Instanzen des Typs erzeugt werden, und zweitens durch eine Menge von Konfigurationsoptionen für Elemente dieses Typs, die in den Widget-Befehlen **create** und **itemconfigure** verwendet werden können. Die meisten Elemente unterstützen weder Indexierung noch Auswahl noch die zugehörigen Befehle wie **index** und **insert**. Wo Elemente diese Funktionen unterstützen, ist das in den Beschreibungen unten ausdrücklich vermerkt. Derzeit bieten Text-, Linien- und Polygon-Elemente diese Unterstützung. Bei Linien und Polygonen dient die Indexierung dazu, die Koordinaten des Elements zu bearbeiten.

## Gemeinsame Elementoptionen

Viele Elemente haben einen gemeinsamen Satz von Optionen. Diese Optionen werden hier erläutert, und der Kürze halber verweist dann jeder Widget-Typ nur darauf.

[-anchor]{.lit} [anchorPos]{.arg}
: *AnchorPos* legt fest, wie das Element relativ zu seinem Positionierungspunkt platziert wird; es kann jede der Formen haben, die [Tk\_GetAnchor][GetAnchor] akzeptiert. Ist *anchorPos* zum Beispiel **center**, wird das Element auf dem Punkt zentriert; ist *anchorPos* **n**, wird das Element so gezeichnet, dass sein oberer Mittelpunkt am Positionierungspunkt liegt. Der Standardwert dieser Option ist **center**.

[-dash]{.lit} [pattern]{.arg}
: ...siehe nächstes...

[-activedash]{.lit} [pattern]{.arg}
: ...siehe nächstes...

[-disableddash]{.lit} [pattern]{.arg}
: Diese Optionen legen die Strichmuster für den normalen, den aktiven und den deaktivierten Zustand eines Elements fest. *pattern* kann jede der Formen haben, die [Tk\_GetDash][GetDash] akzeptiert. Werden die Strichoptionen weggelassen, ist der Umriss standardmäßig durchgezogen. Weitere Informationen finden Sie unter [Strichmuster].

[-dashoffset]{.lit} [offset]{.arg}
: Der Start-*offset* in Pixeln innerhalb des Musters, das die Option **-dash** angibt. **-dashoffset** wird ignoriert, wenn kein **-dash**-Muster vorhanden ist. *offset* kann jede der Formen haben, die oben im Abschnitt [Koordinaten] beschrieben sind.

[-fill]{.lit} [color]{.arg}
: ...siehe nächstes...

[-activefill]{.lit} [color]{.arg}
: ...siehe nächstes...

[-disabledfill]{.lit} [color]{.arg}
: Diese Optionen legen die Farbe fest, mit der der Bereich des Elements im normalen, aktiven und deaktivierten Zustand gefüllt wird. Es gilt die Even-Odd-Füllregel. *color* kann jede von [Tk\_GetColor][GetColor] akzeptierte Form haben. Beim Linien-Element legt die Option die Farbe der gezeichneten Linie fest. Beim Text-Element legt sie die Vordergrundfarbe des Textes fest. Ist *color* eine leere Zeichenkette (der Standard für alle Canvas-Elemente außer Linie und Text), wird das Element nicht gefüllt.

[-outline]{.lit} [color]{.arg}
: ...siehe nächstes...

[-activeoutline]{.lit} [color]{.arg}
: ...siehe nächstes...

[-disabledoutline]{.lit} [color]{.arg}
: Diese Optionen legen die Farbe fest, mit der der Umriss des Elements im normalen, aktiven und deaktivierten Zustand gezeichnet wird. *color* kann jede von [Tk\_GetColor][GetColor] akzeptierte Form haben. Ist *color* als leere Zeichenkette angegeben, wird für das Element kein Umriss gezeichnet.

[-offset]{.lit} [offset]{.arg}
: Legt den Versatz von Stippelmustern fest. Der Versatz kann die Form **x,y** oder *side* haben, wobei *side* **n**, **ne**, **e**, **se**, **s**, **sw**, **w**, **nw** oder **center** sein kann. Im ersten Fall ist der Ursprung der Ursprung des Toplevel-Fensters des aktuellen Fensters. Für den Canvas selbst und für Canvas-Elemente ist der Ursprung der Ursprung des Canvas; ein **#** vor dem Koordinatenpaar bedeutet jedoch, dass stattdessen der Ursprung des Toplevel-Fensters verwendet wird. Bei Canvas-Elementen wird die Option **-offset** auch für die Stippelung verwendet. Bei Linien- und Polygon-Elementen können Sie als Argument auch einen Index angeben, der den Ursprung des Stippelmusters mit einem der Koordinatenpunkte der Linie bzw. des Polygons verbindet. Beachten Sie, dass Stippelversätze *nur unter X11 unterstützt werden*; auf anderen Plattformen werden sie stillschweigend ignoriert.

[-outlinestipple]{.lit} [bitmap]{.arg}
: ...siehe nächstes...

[-activeoutlinestipple]{.lit} [bitmap]{.arg}
: ...siehe nächstes...

[-disabledoutlinestipple]{.lit} [bitmap]{.arg}
: Diese Optionen legen die Stippelmuster fest, mit denen der Umriss des Elements im normalen, aktiven und deaktivierten Zustand gezeichnet wird. Sie geben an, dass der Umriss des Elements mit einem Stippelmuster gezeichnet werden soll; *bitmap* legt das zu verwendende Stippelmuster in einer der von [Tk\_GetBitmap][GetBitmap] akzeptierten Formen fest. Wurde die Option **-outline** nicht angegeben, hat diese Option keine Wirkung. Ist *bitmap* eine leere Zeichenkette (der Standard), wird der Umriss durchgehend gezeichnet. *Beachten Sie, dass Stippelmuster auf Plattformen, die nicht X11 als Zeichen-API verwenden, nur eingeschränkt unterstützt werden.*

[-outlineoffset]{.lit} [offset]{.arg}
: Legt den Versatz des Stippelmusters für Umrisse fest, so wie die Option **-offset** die Stippelmuster der Füllung steuert. (Die Syntax von *offset* ist bei der Option **-offset** beschrieben.)

[-stipple]{.lit} [bitmap]{.arg}
: ...siehe nächstes...

[-activestipple]{.lit} [bitmap]{.arg}
: ...siehe nächstes...

[-disabledstipple]{.lit} [bitmap]{.arg}
: Diese Optionen legen die Stippelmuster fest, mit denen das Element im normalen, aktiven und deaktivierten Zustand gefüllt wird. *bitmap* legt das zu verwendende Stippelmuster in einer der von [Tk\_GetBitmap][GetBitmap] akzeptierten Formen fest. Wurde die Option **-fill** nicht angegeben, hat diese Option keine Wirkung. Ist *bitmap* eine leere Zeichenkette (der Standard), wird durchgehend gefüllt. Beim Text-Element betrifft die Option den eigentlichen Text. *Beachten Sie, dass Stippelmuster auf Plattformen, die nicht X11 als Zeichen-API verwenden, nur eingeschränkt unterstützt werden.*

[-state]{.lit} [state]{.arg}
: Mit dieser Option kann ein Element die globale Option *state* des Canvas-Widgets überschreiben. Sie akzeptiert dieselben Werte: *normal*, *disabled* oder *hidden*.

[-tags]{.lit} [tagList]{.arg}
: Legt eine Menge von Tags fest, die dem Element zugewiesen werden. *tagList* besteht aus einer Liste von Tag-Namen, die alle bisherigen Tags des Elements ersetzen. *tagList* darf eine leere Liste sein.

[-width]{.lit} [outlineWidth]{.arg}
: ...siehe nächstes...

[-activewidth]{.lit} [outlineWidth]{.arg}
: ...siehe nächstes...

[-disabledwidth]{.lit} [outlineWidth]{.arg}
: Diese Optionen legen die Breite des Umrisses fest, der im normalen, aktiven und deaktivierten Zustand um den Bereich des Elements gezeichnet wird. *outlineWidth* kann jede der im Abschnitt [Koordinaten] oben beschriebenen Formen haben. Wurde die Option **-outline** als leere Zeichenkette angegeben, hat diese Option keine Wirkung. Der Standardwert ist 1.0. Bei Bögen werden breite Umrisse mittig auf den Kanten des Bogenbereichs gezeichnet.


# Standard-Elementtypen

## Bogen-Elemente

Elemente vom Typ **arc** erscheinen auf dem Bildschirm als bogenförmige Bereiche. Ein Bogen ist ein Ausschnitt eines Ovals, der von zwei Winkeln begrenzt wird (festgelegt entweder durch die Optionen **-start** und **-extent** oder durch die Option **-height**) und auf eine von mehreren Arten dargestellt wird (festgelegt durch die Option **-style**). Bögen werden mit Widget-Befehlen der folgenden Form erzeugt:

```
pathName create arc x1 y1 x2 y2 ?option value ...?
pathName create arc coordList ?option value ...?
```

Die Argumente *x1*, *y1*, *x2* und *y2* bzw. *coordList* geben die Koordinaten zweier diagonal gegenüberliegender Ecken eines rechteckigen Bereichs an, der das Oval umschließt, das den Bogen definiert (außer wenn **-height** angegeben ist – siehe unten).

Nach den Koordinaten können beliebig viele *option*-*value*-Paare folgen, von denen jedes eine der Konfigurationsoptionen des Elements setzt. Dieselben *option*-*value*-Paare können in **itemconfigure**-Widget-Befehlen verwendet werden, um die Konfiguration des Elements zu ändern. Ein Bogen-Element wird zum aktuellen Element, wenn sich der Mauszeiger über einem Teil befindet, der gezeichnet ist, oder (bei vollständiger Transparenz) über einem Teil, der gezeichnet würde, wenn die Optionen **-fill** und **-outline** beide nicht leer wären.

Bögen unterstützen die folgenden Standardoptionen:

::: {.info DISPLAY="yes"}
**-dash**	**-activedash**\
**-disableddash**	**-dashoffset**\
**-fill**	**-activefill**\
**-disabledfill**	**-offset**\
**-outline**	**-activeoutline**\
**-disabledoutline**	**-outlineoffset**\
**-outlinestipple**	**-activeoutlinestipple**\
**-disabledoutlinestipple**	**-stipple**\
**-activestipple**	**-disabledstipple**\
**-state**	**-tags**\
**-width**	**-activewidth**\
**-disabledwidth**
:::

Bögen unterstützen die folgenden zusätzlichen Optionen:

[-extent]{.lit} [degrees]{.arg}
: Legt die Größe des Winkelbereichs fest, den der Bogen einnimmt. Der Bereich des Bogens erstreckt sich über *degrees* Grad gegen den Uhrzeigersinn, beginnend beim Startwinkel aus der Option **-start**. *degrees* darf negativ sein. Ist der Wert größer als 360 oder kleiner als -360, wird *degrees* modulo 360 als Ausdehnung verwendet.

[-start]{.lit} [degrees]{.arg}
: Legt den Anfang des Winkelbereichs fest, den der Bogen einnimmt. *degrees* wird in Grad angegeben, gemessen gegen den Uhrzeigersinn ab der 3-Uhr-Position; der Wert darf positiv oder negativ sein.

[-height]{.lit} [distance]{.arg}
: Bietet eine Abkürzung, um ein Kreisbogensegment zu erzeugen, indem der Abstand des Bogenmittelpunkts von seiner Sehne festgelegt wird. Wird diese Option verwendet, werden die Koordinaten als Anfangs- und Endkoordinaten der Sehne interpretiert, und die Optionen **-start** und **-extent** werden ignoriert. Der Wert von *distance* hat folgende Bedeutung:

    *distance* > 0 erzeugt einen Bogen im Uhrzeigersinn

    *distance* < 0 erzeugt einen Bogen gegen den Uhrzeigersinn

    *distance* = 0 erzeugt einen Bogen, als wäre diese Option nicht angegeben worden

    Wenn der Bogen einen bestimmten Radius *r* haben soll, verwenden Sie die Formel:

    *distance* = *r* ± sqrt(*r*\*\*2 - (chordLength / 2)\*\*2)

    Dabei wählen Sie das Minuszeichen für den kleineren Bogen und das Pluszeichen für den größeren Bogen.

    Beachten Sie, dass **itemcget -height** immer 0 zurückgibt, damit Code zur Introspektion einfach bleiben kann.

[-style]{.lit} [type]{.arg}
: Legt fest, wie der Bogen gezeichnet wird. Ist *type* **pieslice** (der Standard), wird der Bereich des Bogens durch einen Abschnitt des Ovalumfangs und zwei Strecken festgelegt, die jeweils den Mittelpunkt des Ovals mit einem Ende des Umfangsabschnitts verbinden. Ist *type* **chord**, wird der Bereich des Bogens durch einen Abschnitt des Ovalumfangs und eine einzelne Strecke festgelegt, die die beiden Endpunkte des Umfangsabschnitts verbindet. Ist *type* **arc**, besteht der Bereich des Bogens nur aus einem Abschnitt des Umfangs. In diesem letzten Fall wird die Option **-fill** ignoriert.


## Bitmap-Elemente

Elemente vom Typ **bitmap** erscheinen auf dem Bildschirm als Bilder mit zwei Farben, Vordergrund und Hintergrund. Bitmaps werden mit Widget-Befehlen der folgenden Form erzeugt:

```
pathName create bitmap x y ?option value ...?
pathName create bitmap coordList ?option value ...?
```

Die Argumente *x* und *y* bzw. *coordList* (die zwei Elemente haben muss) legen die Koordinaten eines Punkts fest, mit dem das Bitmap auf dem Bildschirm positioniert wird; wie das geschieht, steuert die Option **-anchor**. Nach den Koordinaten können beliebig viele *option*-*value*-Paare folgen, von denen jedes eine der Konfigurationsoptionen des Elements setzt. Dieselben *option*-*value*-Paare können in **itemconfigure**-Widget-Befehlen verwendet werden, um die Konfiguration des Elements zu ändern. Ein Bitmap-Element wird zum aktuellen Element, wenn sich der Mauszeiger über einem beliebigen Teil seiner Bounding-Box befindet.

Bitmaps unterstützen die folgenden Standardoptionen:

::: {.info DISPLAY="yes"}
**-anchor**	**-state**\
**-tags**
:::

Bitmaps unterstützen die folgenden zusätzlichen Optionen:

[-background]{.lit} [color]{.arg}
: ...siehe nächstes...

[-activebackground]{.lit} [color]{.arg}
: ...siehe nächstes...

[-disabledbackground]{.lit} [color]{.arg}
: Legt die Farbe fest, die im normalen, aktiven und deaktivierten Zustand für jedes Pixel des Bitmaps mit dem Wert „0“ verwendet wird. *color* kann jede von [Tk\_GetColor][GetColor] akzeptierte Form haben. Wird diese Option nicht angegeben oder als leere Zeichenkette angegeben, wird dort, wo die Pixel des Bitmaps 0 sind, nichts angezeigt; das ergibt einen transparenten Effekt.

[-bitmap]{.lit} [bitmap]{.arg}
: ...siehe nächstes...

[-activebitmap]{.lit} [bitmap]{.arg}
: ...siehe nächstes...

[-disabledbitmap]{.lit} [bitmap]{.arg}
: Diese Optionen legen die Bitmaps fest, die im Element im normalen, aktiven und deaktivierten Zustand angezeigt werden. *bitmap* kann jede von [Tk\_GetBitmap][GetBitmap] akzeptierte Form haben.

[-foreground]{.lit} [color]{.arg}
: ...siehe nächstes...

[-activeforeground]{.lit} [color]{.arg}
: ...siehe nächstes...

[-disabledforeground]{.lit} [color]{.arg}
: Diese Optionen legen die Farbe fest, die im normalen, aktiven und deaktivierten Zustand für jedes Pixel des Bitmaps mit dem Wert „1“ verwendet wird. *color* kann jede von [Tk\_GetColor][GetColor] akzeptierte Form haben.


## Bild-Elemente

Elemente vom Typ [image] dienen dazu, Bilder auf einem Canvas anzuzeigen. Bilder werden mit Widget-Befehlen der folgenden Form erzeugt:

```
pathName create image x y ?option value ...?
pathName create image coordList ?option value ...?
```

Die Argumente *x* und *y* bzw. *coordList* legen die Koordinaten eines Punkts fest, mit dem das Bild auf dem Bildschirm positioniert wird; wie das geschieht, steuert die Option **-anchor**. Nach den Koordinaten können beliebig viele *option*-*value*-Paare folgen, von denen jedes eine der Konfigurationsoptionen des Elements setzt. Dieselben *option*-*value*-Paare können in **itemconfigure**-Widget-Befehlen verwendet werden, um die Konfiguration des Elements zu ändern. Ein Bild-Element wird zum aktuellen Element, wenn sich der Mauszeiger über einem beliebigen Teil seiner Bounding-Box befindet.

Bilder unterstützen die folgenden Standardoptionen:

::: {.info DISPLAY="yes"}
**-anchor**	**-state**\
**-tags**
:::

Bilder unterstützen die folgenden zusätzlichen Optionen:

[-image]{.lit} [name]{.arg}
: ...siehe nächstes...

[-activeimage]{.lit} [name]{.arg}
: ...siehe nächstes...

[-disabledimage]{.lit} [name]{.arg}
: Legt die Namen der Bilder fest, die im Element im normalen, aktiven und deaktivierten Zustand angezeigt werden. Das Bild muss zuvor mit dem Befehl [image create][image] erzeugt worden sein.


## Linien-Elemente

Elemente vom Typ **line** erscheinen auf dem Bildschirm als eine oder mehrere verbundene Strecken oder Kurven. Linien-Elemente unterstützen Operationen mit Koordinatenindizes über die Widget-Befehle **dchars**, **index** und **insert**. Linien werden mit Widget-Befehlen der folgenden Form erzeugt:

```
pathName create line x1 y1... xn yn ?option value ...?
pathName create line coordList ?option value ...?
```

Die Argumente *x1* bis *yn* bzw. *coordList* geben die Koordinaten einer Folge von zwei oder mehr Punkten an, die eine Folge verbundener Strecken beschreiben. Nach den Koordinaten können beliebig viele *option*-*value*-Paare folgen, von denen jedes eine der Konfigurationsoptionen des Elements setzt. Dieselben *option*-*value*-Paare können in **itemconfigure**-Widget-Befehlen verwendet werden, um die Konfiguration des Elements zu ändern. Ein Linien-Element ist immer dann das aktuelle Element, wenn sich der Mauszeiger über einer beliebigen Strecke der Linie befindet, unabhängig davon, ob sie gezeichnet ist und ob die Linie geglättet ist.

Linien unterstützen die folgenden Standardoptionen:

::: {.info DISPLAY="yes"}
**-dash**	**-activedash**\
**-disableddash**	**-dashoffset**\
**-fill**	**-activefill**\
**-disabledfill**	**-stipple**\
**-activestipple**	**-disabledstipple**\
**-state**	**-tags**\
**-width**	**-activewidth**\
**-disabledwidth**
:::

Linien unterstützen die folgenden zusätzlichen Optionen:

[-arrow]{.lit} [where]{.arg}
: Gibt an, ob an einem oder an beiden Enden der Linie Pfeilspitzen gezeichnet werden. *where* muss einen der Werte **none** (keine Pfeilspitzen), **first** (eine Pfeilspitze am ersten Punkt der Linie), **last** (eine Pfeilspitze am letzten Punkt der Linie) oder **both** (Pfeilspitzen an beiden Enden) haben. Der Standardwert dieser Option ist **none**. Soll eine Pfeilspitze gezeichnet werden, verschiebt Tk intern den zugehörigen Endpunkt der Linie so, dass die gezeichnete Linie am Hals der Pfeilspitze endet und nicht an ihrer Spitze; so ragt die Linie nicht über den Rand der Pfeilspitze hinaus. Das kann ein **Leave**-Ereignis auslösen, wenn sich die Maus über diesem Linienende befindet. Umgekehrt verschiebt Tk beim Entfernen einer Pfeilspitze den zugehörigen Linienpunkt in die andere Richtung, was ein **Enter**-Ereignis auslösen kann.

[-arrowshape]{.lit} [shape]{.arg}
: Diese Option gibt an, wie Pfeilspitzen gezeichnet werden. Das Argument *shape* muss eine Liste mit drei Elementen sein, von denen jedes einen Abstand in einer der im Abschnitt [Koordinaten] oben beschriebenen Formen angibt. Das erste Element der Liste gibt den Abstand entlang der Linie vom Hals der Pfeilspitze bis zu ihrer Spitze an. Das zweite Element gibt den Abstand entlang der Linie von den hinteren Punkten der Pfeilspitze bis zur Spitze an, und das dritte Element gibt den Abstand vom äußeren Rand der Linie bis zu den hinteren Punkten an. Wird diese Option nicht angegeben, wählt Tk eine „vernünftige“ Form.

[-capstyle]{.lit} [style]{.arg}
: Legt fest, wie die Enden (Caps) an den Endpunkten der Linie gezeichnet werden. *style* kann jede von [Tk\_GetCapStyle][GetCapStyl] akzeptierte Form haben (**butt**, **projecting** oder **round**). Wird diese Option nicht angegeben, ist der Standardwert **butt**. Wo Pfeilspitzen gezeichnet werden, wird der Endenstil ignoriert.

[-joinstyle]{.lit} [style]{.arg}
: Legt fest, wie die Verbindungen an den Eckpunkten der Linie gezeichnet werden. *style* kann jede von [Tk\_GetJoinStyle][GetJoinStl] akzeptierte Form haben (**bevel**, **miter** oder **round**). Wird diese Option nicht angegeben, ist der Standardwert **round**. Besteht die Linie nur aus zwei Punkten, ist diese Option bedeutungslos.

[-smooth]{.lit} [smoothMethod]{.arg}
: *smoothMethod* muss eine der von [Tcl\_GetBoolean][GetInt] akzeptierten Formen haben oder eine Glättungsmethode für Linien sein. Im Kern werden nur **true** und **raw** unterstützt (wobei **bezier** ein Alias für **true** ist), weitere Methoden können aber zur Laufzeit hinzugefügt werden. Wird ein boolescher Wert für „falsch“ oder eine leere Zeichenkette angegeben, wird nicht geglättet. Ein boolescher Wert für „wahr“ bedeutet Glättung mit **true**. Ist die Glättungsmethode **true**, wird die Linie als Kurve gezeichnet, die aus einer Folge quadratischer Splines besteht: Ein Spline wird für die erste und zweite Strecke gezeichnet, einer für die zweite und dritte und so weiter. Gerade Strecken lassen sich innerhalb einer Kurve erzeugen, indem Sie die Endpunkte der gewünschten Strecke doppelt angeben. Ist die Glättungsmethode **raw**, wird die Linie ebenfalls als Kurve gezeichnet, wobei die Koordinatenliste aber so aufgebaut ist, dass das erste Koordinatenpaar (und danach jedes dritte Koordinatenpaar) ein Knotenpunkt einer kubischen Bézierkurve ist und die übrigen Koordinaten Kontrollpunkte der kubischen Bézierkurve sind. Gerade Strecken lassen sich innerhalb einer Kurve erzeugen, indem Sie Kontrollpunkte gleich den benachbarten Knotenpunkten setzen. Ist der letzte Punkt ein Kontrollpunkt und kein Knotenpunkt, wird der Punkt (ein- oder zweimal) wiederholt, sodass er ebenfalls ein Knotenpunkt wird.

[-splinesteps]{.lit} [number]{.arg}
: Legt den gewünschten Grad der Glätte von Kurven fest: Jeder Spline wird durch *number* Strecken angenähert. Diese Option wird ignoriert, sofern die Option **-smooth** nicht true oder **raw** ist.


## Oval-Elemente

Elemente vom Typ **oval** erscheinen auf dem Bildschirm als kreisförmige oder ovale Bereiche. Jedes Oval kann einen Umriss, eine Füllung oder beides haben. Ovale werden mit Widget-Befehlen der folgenden Form erzeugt:

```
pathName create oval x1 y1 x2 y2 ?option value ...?
pathName create oval coordList ?option value ...?
```

Die Argumente *x1*, *y1*, *x2* und *y2* bzw. *coordList* geben die Koordinaten zweier diagonal gegenüberliegender Ecken eines rechteckigen Bereichs an, der das Oval umschließt. Das Oval schließt die obere und die linke Kante des Rechtecks ein, nicht aber die untere oder die rechte Kante. Ist der Bereich quadratisch, ist das entstehende Oval kreisförmig; andernfalls ist es länglich. Nach den Koordinaten können beliebig viele *option*-*value*-Paare folgen, von denen jedes eine der Konfigurationsoptionen des Elements setzt. Dieselben *option*-*value*-Paare können in **itemconfigure**-Widget-Befehlen verwendet werden, um die Konfiguration des Elements zu ändern. Ein Oval-Element wird zum aktuellen Element, wenn sich der Mauszeiger über einem Teil befindet, der gezeichnet ist, oder (bei vollständiger Transparenz) über einem Teil, der gezeichnet würde, wenn die Optionen **-fill** und **-outline** beide nicht leer wären.

Ovale unterstützen die folgenden Standardoptionen:

::: {.info DISPLAY="yes"}
**-dash**	**-activedash**\
**-disableddash**	**-dashoffset**\
**-fill**	**-activefill**\
**-disabledfill**	**-offset**\
**-outline**	**-activeoutline**\
**-disabledoutline**	**-outlineoffset**\
**-outlinestipple**	**-activeoutlinestipple**\
**-disabledoutlinestipple**	**-stipple**\
**-activestipple**	**-disabledstipple**\
**-state**	**-tags**\
**-width**	**-activewidth**\
**-disabledwidth**
:::

Es gibt keine Optionen, die nur für Ovale gelten.

## Polygon-Elemente

Elemente vom Typ **polygon** erscheinen auf dem Bildschirm als vieleckige oder gekrümmte gefüllte Bereiche. Polygon-Elemente unterstützen Operationen mit Koordinatenindizes über die Widget-Befehle **dchars**, **index** und **insert**. Polygone werden mit Widget-Befehlen der folgenden Form erzeugt:

```
pathName create polygon x1 y1 ... xn yn ?option value ...?
pathName create polygon coordList ?option value ...?
```

Die Argumente *x1* bis *yn* bzw. *coordList* legen die Koordinaten von drei oder mehr Punkten fest, die ein Polygon definieren. Der erste Punkt sollte nicht als letzter wiederholt werden, um die Form zu schließen; Tk schließt den Umfang zwischen dem ersten und dem letzten Punkt automatisch. Nach den Koordinaten können beliebig viele *option*-*value*-Paare folgen, von denen jedes eine der Konfigurationsoptionen des Elements setzt. Dieselben *option*-*value*-Paare können in **itemconfigure**-Widget-Befehlen verwendet werden, um die Konfiguration des Elements zu ändern. Ein Polygon-Element ist immer dann das aktuelle Element, wenn sich der Mauszeiger über einem beliebigen Teil des Polygons befindet, unabhängig davon, ob er gezeichnet ist und ob der Umriss geglättet ist.

Polygone unterstützen die folgenden Standardoptionen:

::: {.info DISPLAY="yes"}
**-dash**	**-activedash**\
**-disableddash**	**-dashoffset**\
**-fill**	**-activefill**\
**-disabledfill**	**-offset**\
**-outline**	**-activeoutline**\
**-disabledoutline**	**-outlineoffset**\
**-outlinestipple**	**-activeoutlinestipple**\
**-disabledoutlinestipple**	**-stipple**\
**-activestipple**	**-disabledstipple**\
**-state**	**-tags**\
**-width**	**-activewidth**\
**-disabledwidth**
:::

Polygone unterstützen die folgenden zusätzlichen Optionen:

[-joinstyle]{.lit} [style]{.arg}
: Legt fest, wie die Verbindungen an den Eckpunkten des Umrisses gezeichnet werden. *style* kann jede von [Tk\_GetJoinStyle][GetJoinStl] akzeptierte Form haben (**bevel**, **miter** oder **round**). Wird diese Option nicht angegeben, ist der Standardwert **round**.

[-smooth]{.lit} [boolean]{.arg}
: *boolean* muss eine der von [Tcl\_GetBoolean][GetInt] akzeptierten Formen haben oder eine Glättungsmethode für Linien sein. Im Kern werden nur **true** und **raw** unterstützt (wobei **bezier** ein Alias für **true** ist), weitere Methoden können aber zur Laufzeit hinzugefügt werden. Wird ein boolescher Wert für „falsch“ oder eine leere Zeichenkette angegeben, wird nicht geglättet. Ein boolescher Wert für „wahr“ bedeutet Glättung mit **true**. Ist die Glättungsmethode **true**, wird das Polygon als Kurve gezeichnet, die aus einer Folge quadratischer Splines besteht: Ein Spline wird für die erste und zweite Strecke gezeichnet, einer für die zweite und dritte und so weiter. Gerade Strecken lassen sich innerhalb einer Kurve erzeugen, indem Sie die Endpunkte der gewünschten Strecke doppelt angeben. Ist die Glättungsmethode **raw**, wird das Polygon ebenfalls als Kurve gezeichnet, wobei die Koordinatenliste aber so aufgebaut ist, dass das erste Koordinatenpaar (und danach jedes dritte Koordinatenpaar) ein Knotenpunkt einer kubischen Bézierkurve ist und die übrigen Koordinaten Kontrollpunkte der kubischen Bézierkurve sind. Gerade Strecken lassen sich innerhalb einer Kurve erzeugen, indem Sie Kontrollpunkte gleich den benachbarten Knotenpunkten setzen. Ist der letzte Punkt nicht der zweite Punkt eines Kontrollpunktpaars, wird der Punkt (ein- oder zweimal) wiederholt, sodass er ebenfalls zum zweiten Punkt eines Kontrollpunktpaars wird (der zugehörige Knotenpunkt ist dann der erste Kontrollpunkt).

[-splinesteps]{.lit} [number]{.arg}
: Legt den gewünschten Grad der Glätte von Kurven fest: Jeder Spline wird durch *number* Strecken angenähert. Diese Option wird ignoriert, sofern die Option **-smooth** nicht true oder **raw** ist.


Polygon-Elemente unterscheiden sich von anderen Elementen wie Rechtecken, Ovalen und Bögen darin, dass Punkte im Inneren als „innerhalb“ des Polygons gelten (etwa für die Widget-Befehle **find closest** und **find overlapping**), auch wenn es nicht gefüllt ist. Bei den meisten anderen Elementtypen gilt ein Punkt im Inneren nur dann als innerhalb des Elements, wenn das Element gefüllt ist oder weder eine Füllung noch einen Umriss hat. Wenn Sie ein ungefülltes Polygon möchten, dessen innere Punkte nicht als innerhalb des Polygons gelten, verwenden Sie stattdessen ein Linien-Element.

## Rechteck-Elemente

Elemente vom Typ **rectangle** erscheinen auf dem Bildschirm als rechteckige Bereiche. Jedes Rechteck kann einen Umriss, eine Füllung oder beides haben. Rechtecke werden mit Widget-Befehlen der folgenden Form erzeugt:

```
pathName create rectangle x1 y1 x2 y2 ?option value ...?
pathName create rectangle coordList ?option value ...?
```

Die Argumente *x1*, *y1*, *x2* und *y2* bzw. *coordList* (die vier Elemente haben muss) geben die Koordinaten zweier diagonal gegenüberliegender Ecken des Rechtecks an (das Rechteck schließt seine obere und linke Kante ein, nicht aber seine untere oder rechte Kante). Nach den Koordinaten können beliebig viele *option*-*value*-Paare folgen, von denen jedes eine der Konfigurationsoptionen des Elements setzt. Dieselben *option*-*value*-Paare können in **itemconfigure**-Widget-Befehlen verwendet werden, um die Konfiguration des Elements zu ändern. Ein Rechteck-Element wird zum aktuellen Element, wenn sich der Mauszeiger über einem Teil befindet, der gezeichnet ist, oder (bei vollständiger Transparenz) über einem Teil, der gezeichnet würde, wenn die Optionen **-fill** und **-outline** beide nicht leer wären.

Rechtecke unterstützen die folgenden Standardoptionen:

::: {.info DISPLAY="yes"}
**-dash**	**-activedash**\
**-disableddash**	**-dashoffset**\
**-fill**	**-activefill**\
**-disabledfill**	**-offset**\
**-outline**	**-activeoutline**\
**-disabledoutline**	**-outlineoffset**\
**-outlinestipple**	**-activeoutlinestipple**\
**-disabledoutlinestipple**	**-stipple**\
**-activestipple**	**-disabledstipple**\
**-state**	**-tags**\
**-width**	**-activewidth**\
**-disabledwidth**
:::

Es gibt keine Optionen, die nur für Rechtecke gelten.

## Text-Elemente

Ein Text-Element zeigt eine Zeichenkette in einer oder mehreren Zeilen auf dem Bildschirm an. Text-Elemente unterstützen Indizierung, Bearbeitung und Auswahl über die Widget-Befehle **dchars**, **focus**, **icursor**, **index**, **insert** und **select**. Text-Elemente werden mit Widget-Befehlen der folgenden Form erzeugt:

```
pathName create text x y ?option value ...?
pathName create text coordList ?option value ...?
```

Die Argumente *x* und *y* bzw. *coordList* (die zwei Elemente haben muss) legen die Koordinaten eines Punkts fest, mit dem der Text auf dem Bildschirm positioniert wird (wie der Text dargestellt wird, beschreiben die Optionen weiter unten genauer). Nach den Koordinaten können beliebig viele *option*-*value*-Paare folgen, von denen jedes eine der Konfigurationsoptionen des Elements setzt. Dieselben *option*-*value*-Paare können in **itemconfigure**-Widget-Befehlen verwendet werden, um die Konfiguration des Elements zu ändern. Ein Text-Element wird zum aktuellen Element, wenn sich der Mauszeiger über einem beliebigen Teil seiner Bounding-Box befindet.

Text-Elemente unterstützen die folgenden Standardoptionen:

::: {.info DISPLAY="yes"}
**-anchor**	**-fill**\
**-activefill**	**-disabledfill**\
**-stipple**	**-activestipple**\
**-disabledstipple**	**-state**\
**-tags**
:::

Text-Elemente unterstützen die folgenden zusätzlichen Optionen:

[-angle]{.lit} [rotationDegrees]{.arg}
: *rotationDegrees* gibt an, um wie viele Grad der Text gegen den Uhrzeigersinn um seinen Positionierungspunkt gedreht wird; der Wert kann eine beliebige Gleitkommazahl von 0.0 bis 360.0 sein. Ist *rotationDegrees* zum Beispiel **90**, wird der Text senkrecht von unten nach oben gezeichnet. Der Standardwert dieser Option ist **0.0**.

[-font]{.lit} [fontName]{.arg}
: Legt die Schriftart für das Text-Element fest. *fontName* kann jede Zeichenkette sein, die [Tk\_GetFont][GetFont] akzeptiert. Wird diese Option nicht angegeben, wird standardmäßig eine systemabhängige Schriftart verwendet.

[-justify]{.lit} [how]{.arg}
: Legt fest, wie der Text innerhalb seines Begrenzungsbereichs ausgerichtet wird. *how* muss einer der Werte **left**, **right** oder **center** sein. Diese Option spielt nur eine Rolle, wenn der Text in mehreren Zeilen angezeigt wird. Wird die Option weggelassen, ist der Standardwert **left**.

[-text]{.lit} [string]{.arg}
: *string* legt die Zeichen fest, die im Text-Element angezeigt werden. Zeilenumbruchzeichen bewirken einen Zeilenumbruch. Die Zeichen im Element können auch mit den Widget-Befehlen **insert** und **delete** geändert werden. Der Standardwert dieser Option ist eine leere Zeichenkette.

[-underline]{.lit} [number]{.arg}
: Legt den ganzzahligen Index eines Zeichens im Text fest, das unterstrichen werden soll. 0 entspricht dem ersten Zeichen des angezeigten Textes, 1 dem nächsten Zeichen und so weiter. -1 bedeutet, dass nichts unterstrichen wird (soll das gesamte Text-Element unterstrichen werden, verwenden Sie stattdessen eine passende Schriftart).

[-width]{.lit} [lineLength]{.arg}
: Legt eine maximale Zeilenlänge für den Text fest, in einer der im Abschnitt [Koordinaten] oben beschriebenen Formen. Ist diese Option null (der Standard), wird der Text nur an Zeilenumbruchzeichen in Zeilen aufgeteilt. Ist die Option dagegen nicht null, wird jede Zeile, die länger als *lineLength* wäre, unmittelbar vor einem Leerzeichen umgebrochen, damit die Zeile kürzer als *lineLength* wird; das Leerzeichen wird dabei wie ein Zeilenumbruchzeichen behandelt.


## Fenster-Elemente

Elemente vom Typ **window** bewirken, dass ein bestimmtes Fenster an einer gegebenen Position auf dem Canvas angezeigt wird. Fenster-Elemente werden mit Widget-Befehlen der folgenden Form erzeugt:

```
pathName create window x y ?option value ...?
pathName create window coordList ?option value ...?
```

Die Argumente *x* und *y* bzw. *coordList* (die zwei Elemente haben muss) legen die Koordinaten eines Punkts fest, mit dem das Fenster auf dem Bildschirm positioniert wird; wie das geschieht, steuert die Option **-anchor**. Nach den Koordinaten können beliebig viele *option*-*value*-Paare folgen, von denen jedes eine der Konfigurationsoptionen des Elements setzt. Dieselben *option*-*value*-Paare können in **itemconfigure**-Widget-Befehlen verwendet werden, um die Konfiguration des Elements zu ändern. Theoretisch wird ein Fenster-Element zum aktuellen Element, wenn sich der Mauszeiger über einem beliebigen Teil seiner Bounding-Box befindet. In der Praxis geschieht das meist nicht, weil sich der Mauszeiger an dieser Stelle nicht mehr über dem Canvas befindet.

Fenster-Elemente unterstützen die folgenden Standardoptionen:

::: {.info DISPLAY="yes"}
**-anchor**	**-state**\
**-tags**
:::

Fenster-Elemente unterstützen die folgenden zusätzlichen Optionen:

[-height]{.lit} [pixels]{.arg}
: Legt die Höhe fest, die dem Fenster des Elements zugewiesen wird. *pixels* kann jede der im Abschnitt [Koordinaten] oben beschriebenen Formen haben. Wird diese Option nicht angegeben oder als null angegeben, erhält das Fenster die Höhe, die es intern anfordert.

[-width]{.lit} [pixels]{.arg}
: Legt die Breite fest, die dem Fenster des Elements zugewiesen wird. *pixels* kann jede der im Abschnitt [Koordinaten] oben beschriebenen Formen haben. Wird diese Option nicht angegeben oder als null angegeben, erhält das Fenster die Breite, die es intern anfordert.

[-window]{.lit} [pathName]{.arg}
: Legt das Fenster fest, das mit diesem Element verknüpft wird. Das durch *pathName* angegebene Fenster muss entweder ein Kind des Canvas-Widgets oder ein Kind eines Vorfahren des Canvas-Widgets sein. *pathName* darf nicht auf ein Toplevel-Fenster verweisen.


Beachten Sie, dass es wegen Einschränkungen bei der Verwaltung von Fenstern nicht möglich ist, andere grafische Elemente (etwa Linien und Bilder) über Fenster-Elemente zu zeichnen. Ein Fenster-Element verdeckt immer alle Grafiken, die es überlappen, unabhängig von ihrer Reihenfolge in der Anzeigeliste. Beachten Sie außerdem, dass Fenster-Elemente anders als andere Canvas-Elemente bei der Anzeige nicht am Rahmen des umgebenden Canvas abgeschnitten werden, sondern am Eltern-Widget des Fensters, das mit der Option **-window** angegeben ist; ist das Eltern-Widget der Canvas, bedeutet das, dass das Fenster-Element den Rahmen des Canvas überlappen kann.

# Anwendungsdefinierte Elementtypen

Einzelne Anwendungen können mit C-Code neue Elementtypen für Canvas-Widgets definieren. Siehe dazu die Dokumentation zu [Tk\_CreateItemType][CrtItemType].

# Bindungen

In der aktuellen Implementierung erhalten neue Canvas-Widgets kein Standardverhalten: Sie müssen explizite Tcl-Befehle ausführen, um dem Canvas sein Verhalten zu geben.

# Danksagungen

Das Canvas-Widget von Tk ist eine unverhohlene Übernahme von Ideen aus Joel Bartletts Programm *ezd*. *Ezd* bietet strukturierte Grafik in einer Scheme-Umgebung und ging dem Canvas um ein oder zwei Jahre voraus. Seine einfachen Mechanismen zum Platzieren und Animieren grafischer Objekte haben die Funktionen des Canvas angeregt.


[bind]: bind.md
[break]: ../tcl/break.md
[ConfigWidg]: ../tk-c/ConfigWidg.md
[continue]: ../tcl/continue.md
[CrtItemType]: ../tk-c/CrtItemType.md
[focus]: focus.md
[GetAnchor]: ../tk-c/GetAnchor.md
[GetBitmap]: ../tk-c/GetBitmap.md
[GetCapStyl]: ../tk-c/GetCapStyl.md
[GetColor]: ../tk-c/GetColor.md
[GetDash]: ../tk-c/GetDash.md
[GetFont]: ../tk-c/GetFont.md
[GetInt]: ../tcl-c/GetInt.md
[GetJoinStl]: ../tk-c/GetJoinStl.md
[image]: image.md
[lower]: lower.md
[options]: options.md
[raise]: raise.md
[update]: ../tcl/update.md
