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
: Legt einen Gleitkommawert fest, der angibt, wie nah der Mauszeiger an einem Item sein muss, bevor es als „innerhalb“ des Items gilt. Standardwert 1.0.

**-confine** (**confine**/**Confine**)
: Legt einen booleschen Wert fest, der angibt, ob die Ansicht des Canvas außerhalb der durch das Argument **scrollRegion** definierten Region gesetzt werden darf. Standardwert true, d.h. die Ansicht wird auf die Scroll-Region beschränkt.

**-height** (**height**/**Height**)
: Legt eine gewünschte Fensterhöhe fest, die das Canvas-Widget von seinem Geometry-Manager anfordern soll. Der Wert kann in einer der im Abschnitt [Koordinaten] unten beschriebenen Formen angegeben werden.

**-scrollregion** (**scrollRegion**/**ScrollRegion**)
: Legt eine Liste mit vier Koordinaten fest, die die linke, obere, rechte und untere Koordinate einer rechteckigen Region beschreiben. Diese Region dient dem Scrollen und gilt als Grenze der Informationen im Canvas. Jede Koordinate kann in einer der im Abschnitt [Koordinaten] angegebenen Formen angegeben werden.

**-state** (**state**/**State**)
: Ändert den Standardzustand des Canvas; *state* kann **normal**, **disabled** oder **hidden** sein. Einzelne Canvas-Objekte haben jeweils eine eigene Zustandsoption, die den Standardzustand überschreiben kann. Viele Optionen können getrennte Angaben für verschiedene Situationen haben, sodass das Erscheinungsbild des Items je nach Zustand unterschiedlich sein kann. Optionen, die mit **active** beginnen, steuern das Erscheinungsbild, wenn der Mauszeiger darüber ist; die mit **disabled** beginnende Option steuert das Erscheinungsbild im deaktivierten Zustand. Canvas-Items im Zustand **disabled** reagieren nicht auf Canvas-Bindings.

**-width** (**width**/**width**)
: Legt eine gewünschte Fensterbreite fest, die das Canvas-Widget von seinem Geometry-Manager anfordern soll. Der Wert kann in einer der im Abschnitt [Koordinaten] beschriebenen Formen angegeben werden.

**-xscrollincrement** (**xScrollIncrement**/**ScrollIncrement**)
: Legt ein Inkrement für horizontales Scrollen fest, in einer der üblichen für Bildschirmabstände zulässigen Formen. Ist der Wert größer als null, wird die horizontale Ansicht so beschränkt, dass die Canvas-x-Koordinate am linken Fensterrand stets ein gerades Vielfaches von **xScrollIncrement** ist; außerdem sind die Scroll-Einheiten (z.B. die Ansichtsänderung bei Auswahl der linken und rechten Pfeile einer Scrollbar) ebenfalls **xScrollIncrement**. Ist der Wert kleiner oder gleich null, ist horizontales Scrollen unbeschränkt.

**-yscrollincrement** (**yScrollIncrement**/**ScrollIncrement**)
: Legt ein Inkrement für vertikales Scrollen fest, in einer der üblichen für Bildschirmabstände zulässigen Formen. Ist der Wert größer als null, wird die vertikale Ansicht so beschränkt, dass die Canvas-y-Koordinate am oberen Fensterrand stets ein gerades Vielfaches von **yScrollIncrement** ist; außerdem sind die Scroll-Einheiten (z.B. die Ansichtsänderung bei Auswahl der oberen und unteren Pfeile einer Scrollbar) ebenfalls **yScrollIncrement**. Ist der Wert kleiner oder gleich null, ist vertikales Scrollen unbeschränkt.


# Einleitung

Der Befehl **canvas** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Canvas-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des Canvas wie Farben und 3-D-Relief zu konfigurieren. Der Befehl **canvas** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Canvas-Widgets implementieren strukturierte Grafiken. Ein Canvas zeigt beliebig viele *Items* an, die Dinge wie Rechtecke, Kreise, Linien und Text sein können. Items können manipuliert werden (z.B. verschoben oder umgefärbt) und Befehle können mit Items verknüpft werden, ähnlich wie der Befehl [bind] es erlaubt, Befehle an Widgets zu binden. Zum Beispiel kann ein bestimmter Befehl mit dem Ereignis <Button-1> verknüpft werden, sodass der Befehl aufgerufen wird, wenn Maustaste 1 gedrückt wird, während sich der Mauszeiger über einem Item befindet. Das bedeutet, dass Items in einem Canvas Verhalten haben können, die durch die an sie gebundenen Tcl-Scripte definiert sind.

# Anzeigeliste

Die Items in einem Canvas sind für Anzeigezwecke geordnet, wobei das erste Item in der Anzeigeliste zuerst angezeigt wird, gefolgt vom nächsten Item in der Liste usw. Items, die später in der Anzeigeliste stehen, verdecken diejenigen, die früher in der Anzeigeliste stehen, und werden manchmal als "oben" auf früheren Items bezeichnet. Wenn ein neues Item erstellt wird, wird es am Ende der Anzeigeliste platziert, oben auf allem anderen. Widget-Befehle können verwendet werden, um die Reihenfolge der Anzeigeliste neu anzuordnen.

Fenster-Items sind eine Ausnahme von den obigen Regeln. Die zugrunde liegenden Fenstersysteme erfordern, dass sie immer oben auf anderen Items gezeichnet werden. Außerdem wird die Stapelreihenfolge von Fenster-Items nicht durch Canvas-Widget-Befehle beeinflusst; stattdessen müssen die Tk-Befehle [raise] und [lower] verwendet werden.

# Item-IDs und Tags

Items in einem Canvas-Widget können auf zwei Arten benannt werden: per ID oder per Tag. Jedes Item hat eine eindeutige Identifikationsnummer, die diesem Item bei seiner Erstellung zugewiesen wird. Die ID eines Items ändert sich nie und ID-Nummern werden innerhalb der Lebensdauer eines Canvas-Widgets nie wiederverwendet.

Jedes Item kann auch eine beliebige Anzahl von *Tags* haben. Ein Tag ist einfach eine Zeichenkette und kann jede Form annehmen, außer der einer Ganzzahl. Zum Beispiel ist "x123" OK, aber "123" nicht. Derselbe Tag kann vielen verschiedenen Items zugeordnet werden. Dies wird häufig verwendet, um Items auf verschiedene interessante Arten zu gruppieren; zum Beispiel könnten alle ausgewählten Items den Tag "selected" erhalten.

Der Tag **all** ist implizit mit jedem Item im Canvas verknüpft; er kann verwendet werden, um Operationen auf allen Items im Canvas aufzurufen.

Der Tag **current** wird automatisch von Tk verwaltet; er gilt für das *aktuelle Item*, das das oberste Item ist, dessen gezeichneter Bereich die Position des Mauszeigers abdeckt (verschiedene Item-Typen interpretieren dies auf unterschiedliche Weise; siehe die Dokumentation der einzelnen Item-Typen für Details). Wenn sich die Maus nicht im Canvas-Widget befindet oder nicht über einem Item ist, hat kein Item den Tag **current**.

Wenn Items in Canvas-Widget-Befehlen angegeben werden: Wenn der Spezifizierer eine Ganzzahl ist, wird angenommen, dass er sich auf das einzelne Item mit dieser ID bezieht. Wenn der Spezifizierer keine Ganzzahl ist, wird angenommen, dass er sich auf alle Items im Canvas bezieht, die einen zum Spezifizierer passenden Tag haben. Das Symbol *tagOrId* wird unten verwendet, um anzuzeigen, dass ein Argument entweder eine ID angibt, die ein einzelnes Item auswählt, oder einen Tag, der null oder mehr Items auswählt.

*tagOrId* kann logische Ausdrücke von Tags enthalten, indem die Operatoren "**&&**", "**||**", "**^**", "**!**" und geklammerte Unterausdrücke verwendet werden. Zum Beispiel:

```
      .c find withtag {(a&&!b)||(!a&&b)}
```

oder äquivalent:

```
      .c find withtag {a^b}
```

findet nur die Items mit entweder "a" oder "b" Tags, aber nicht beide.

Einige Widget-Befehle operieren nur auf jeweils einem Item; wenn *tagOrId* so angegeben wird, dass mehrere Items benannt werden, besteht das normale Verhalten darin, dass der Befehl das erste (niedrigste) dieser Items in der Anzeigeliste verwendet, das für den Befehl geeignet ist. Ausnahmen werden in den Widget-Befehlsbeschreibungen unten vermerkt.

# Koordinaten

Alle mit Canvas zusammenhängenden Koordinaten werden als Gleitkommazahlen gespeichert. Koordinaten und Abstände werden in Bildschirmeinheiten angegeben — Gleitkommazahlen, optional gefolgt von einem Buchstaben. Ohne Buchstabe gilt der Abstand in Pixeln. **m** bedeutet Millimeter auf dem Bildschirm, **c** Zentimeter, **i** Zoll und **p** Druckerpunkte (1/72 Zoll). Größere y-Koordinaten bezeichnen Punkte weiter unten auf dem Bildschirm; größere x-Koordinaten Punkte weiter rechts. Koordinaten können entweder als gerade Anzahl von Parametern oder als ein einzelner Listenparameter mit gerader Anzahl von x- und y-Koordinatenwerten angegeben werden.

## Transformationen

Normalerweise liegt der Ursprung des Canvas-Koordinatensystems in der oberen linken Ecke des Fensters, das den Canvas enthält. Der Ursprung des Canvas-Koordinatensystems relativ zum Fensterursprung kann mit den Widget-Befehlen **xview** und **yview** angepasst werden; typischerweise für Scrollen. Canvas unterstützen keine Skalierung oder Rotation des Canvas-Koordinatensystems relativ zum Fenster-Koordinatensystem.

Einzelne Items können mit den unten beschriebenen Widget-Befehlen verschoben oder skaliert werden, dürfen jedoch nicht gedreht werden.

Beachten Sie, dass der Standardursprung des sichtbaren Canvas-Bereichs mit dem Ursprung des gesamten Fensters zusammenfällt; das erleichtert Bindings mit der Mausposition — **canvasx** und **canvasy** sind nur nötig, wenn Sie den Ursprung des sichtbaren Bereichs verschieben. Gleichzeitig müssen Fokusring (Option **-highlightthickness**) und Fensterrand (Option **-borderwidth**) berücksichtigt werden, bevor der sichtbare Canvas-Bereich erreicht ist.

# Indizes

Text-Items unterstützen den Begriff eines *Index* zur Identifikation bestimmter Positionen innerhalb des Items. Entsprechend unterstützen Linien- und Polygon-Items *Index* zum Identifizieren, Einfügen und Löschen von Teilmengen ihrer Koordinaten. Indizes werden für Befehle wie Einfügen oder Löschen eines Zeichen- oder Koordinatenbereichs und zum Setzen der Einfügemarken-Position verwendet. Ein Index kann auf verschiedene Weise angegeben werden; verschiedene Item-Typen können unterschiedliche Formen unterstützen. Text-Items unterstützen folgende Index-Formen; bei neuen textähnlichen Item-Typen ist es ratsam, möglichst viele dieser Formen zu unterstützen. Es ist möglich, auf das Zeichen unmittelbar nach dem letzten im Text-Item zu verweisen — nötig z.B. zum Einfügen neuer Texte am Ende. Linien und Polygone unterstützen weder Einfügemarke noch Auswahl; ihre Indizes sollen stets gerade sein, da Koordinaten stets paarweise auftreten.

*number*
: Eine Dezimalzahl für die Position des gewünschten Zeichens im Text-Item. 0 bezeichnet das erste Zeichen, 1 das nächste usw. Bei Linien und Polygonen werden ungerade Indizes automatisch um eins verringert. Eine Zahl kleiner als 0 wird wie null behandelt; eine Zahl größer als die Textlänge wie die Textlänge. Bei Polygonen werden Zahlen kleiner als 0 oder größer als die Koordinatenlistenlänge durch Addieren oder Subtrahieren der Länge angepasst, bis das Ergebnis zwischen null und der Länge (einschließlich) liegt.

**end**
: Bezeichnet das Zeichen oder die Koordinate unmittelbar nach dem letzten im Item (entspricht der Anzahl der Zeichen bzw. Koordinaten im Item).

**insert**
: Bezeichnet das Zeichen unmittelbar vor der Einfügemarke in diesem Item. Für Linien und Polygone ungültig.

**sel.first**
: Bezeichnet das erste ausgewählte Zeichen im Item. Ungültig, wenn die Auswahl nicht in diesem Item liegt.

**sel.last**
: Bezeichnet das letzte ausgewählte Zeichen im Item. Ungültig, wenn die Auswahl nicht in diesem Item liegt.

**@***x,y*
: Bezeichnet das Zeichen oder die Koordinate am Punkt *x*, *y* im Canvas-Koordinatensystem. Liegen *x* und *y* außerhalb der vom Text-Item abgedeckten Koordinaten, beziehen sie sich auf das erste bzw. letzte Zeichen in der dem Punkt nächsten Zeile.


# Strichmuster

Viele Items unterstützen Strichmuster für Umrisse.

Die erste mögliche Syntax ist eine Liste von Ganzzahlen. Jedes Element gibt die Pixelanzahl eines Liniensegments an. Nur die ungeraden Segmente werden in der „outline“-Farbe gezeichnet; die anderen sind transparent.

Die zweite mögliche Syntax ist eine Zeichenliste mit nur 5 Zeichen „**.,-_** “. Leerzeichen vergrößern den Abstand zwischen anderen Linienelementen und dürfen nicht an erster Stelle stehen. Beispiele:

```
-dash .     → -dash {2 4}
-dash -     → -dash {6 4}
-dash -.    → -dash {6 4 2 4}
-dash -..   → -dash {6 4 2 4 2 4}
-dash {. }  → -dash {2 8}
-dash ,     → -dash {4 4}
```

Der Hauptunterschied dieser Syntax zur ersten ist die Formtreue: Alle Werte der Strichliste werden vor der Anzeige mit der Linienbreite multipliziert. So wird „.“ stets als Punkt und „-“ stets als Strich dargestellt, unabhängig von der Linienbreite.

Auf Systemen mit nur begrenzt unterstützten Strichmustern wird das nächstliegende verfügbare Muster verwendet. Unter Windows sind z.B. nur die ersten 4 der obigen Beispiele verfügbar; die letzten 2 werden wie das erste dargestellt.

# Widget-Befehl

Der Befehl **canvas** erstellt einen neuen Tcl-Befehl mit dem Namen *pathName*. Dieser Befehl kann verschiedene Operationen auf dem Widget aufrufen. Er hat folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Folgende Widget-Befehle sind für Canvas-Widgets möglich:

*pathName* **addtag** *tag searchSpec* ?*arg arg ...*?
: Für jedes Item, das die durch *searchSpec* und die *arg*s angegebenen Bedingungen erfüllt, wird *tag* zur Tag-Liste des Items hinzugefügt, falls noch nicht vorhanden. Es ist möglich, dass kein Item die Bedingungen erfüllt; dann hat der Befehl keine Wirkung. Rückgabe: leerer String. *SearchSpec* und *arg*s können folgende Formen haben:

    **above** *tagOrId*
    : Wählt das Item unmittelbar nach (oberhalb) dem durch *tagOrId* bezeichneten in der Anzeigeliste. Bezeichnet *tagOrId* mehrere Items, wird das letzte (oberste) davon verwendet.

    **all**
    : Wählt alle Items im Canvas.

    **below** *tagOrId*
    : Wählt das Item unmittelbar vor (unterhalb) dem durch *tagOrId* bezeichneten in der Anzeigeliste. Bezeichnet *tagOrId* mehrere Items, wird das erste (unterste) davon verwendet.

    **closest** *x y* ?*halo*? ?*start*?
    : Wählt das dem Punkt *x*, *y* nächste Item. Liegen mehrere Items in gleicher Mindestentfernung (z.B. Überlappung), wird das oberste (letzte in der Anzeigeliste) gewählt. *halo* muss, falls angegeben, nicht negativ sein; jedes Item näher als *halo* zum Punkt gilt als überlappend. *start* ermöglicht zyklisches Durchsteppen aller nächsten Items. Ist *start* angegeben, benennt es ein Item per Tag oder ID (bei Tag: erstes Item in der Anzeigeliste mit diesem Tag). Statt des obersten nächsten Items wird das oberste nächste unterhalb von *start* in der Anzeigeliste gewählt; existiert keines, verhält sich die Auswahl wie ohne *start*.

    **enclosed** *x1* *y1* *x2* *y2*
    : Wählt alle Items, die vollständig im Rechteck *x1*, *y1*, *x2*, *y2* liegen. *x1* darf *x2* nicht überschreiten, *y1* nicht *y2*.

    **overlapping** *x1* *y1* *x2* *y2*
    : Wählt alle Items, die das Rechteck *x1*, *y1*, *x2*, *y2* überlappen oder einschließen. *x1* darf *x2* nicht überschreiten, *y1* nicht *y2*.

    **withtag** *tagOrId*
    : Wählt alle durch *tagOrId* bezeichneten Items.


*pathName* **bbox** *tagOrId* ?*tagOrId tagOrId ...*?
: Gibt eine Liste mit vier Elementen zurück — eine näherungsweise Bounding-Box für alle durch die *tagOrId*-Argumente benannten Items. Form „*x1 y1 x2 y2*“, sodass die gezeichneten Bereiche aller benannten Elemente innerhalb der Region links *x1*, rechts *x2*, oben *y1*, unten *y2* liegen. Der Rückgabewert kann die tatsächliche Box um wenige Pixel überschätzen. Stimmen keine Items überein oder haben leere Bounding-Boxes (nichts Darstellbares), wird ein leerer String zurückgegeben.

*pathName* **bind** *tagOrId* ?*sequence*? ?*command*?
: Verknüpft *command* mit allen durch *tagOrId* bezeichneten Items, sodass der Befehl aufgerufen wird, wenn die Ereignisfolge *sequence* für eines der Items eintritt. Ähnlich dem Befehl [bind], operiert aber auf Canvas-Items statt ganzen Widgets. Siehe [bind] für Syntax von *sequence* und Substitutionen in *command*. Sind alle Argumente angegeben, wird ein neues Binding erstellt und ersetzt ein bestehendes für dieselbe *sequence* und *tagOrId* (beginnt *command* mit „+“, wird ein bestehendes Binding ergänzt). Rückgabe: leerer String. Fehlt *command*, wird der mit *tagOrId* und *sequence* verknüpfte Befehl zurückgegeben (Fehler, wenn kein Binding existiert). Fehlen *command* und *sequence*, eine Liste aller Sequenzen mit Bindings für *tagOrId*.

    Bindings sind nur für Maus- und Tastaturereignisse (z.B. **Enter**, **Leave**, **ButtonPress**, **Motion** und **KeyPress**) oder virtuelle Ereignisse möglich. Die Ereignisbehandlung nutzt das aktuelle Item aus [Item-IDs und Tags] oben. **Enter** und **Leave** für ein Item, wenn es aktuelles Item wird oder aufhört — anders als Fenster-**Enter**/**Leave**. Mausereignisse gehen an das aktuelle Item; Tastaturereignisse an das Fokus-Item (siehe **focus** unten). Virtuelle Bindings lösen nur aus, wenn das virtuelle Ereignis von einem Maus- oder Tastaturereignis abgeleitet ist.

    Mehrere Bindings können zu einem Ereignis passen (z.B. Binding an Item-ID und an einen Tag). Dann werden alle passenden aufgerufen: zuerst **all**, dann je ein Binding pro Tag des Items (in Reihenfolge), dann Binding an die Item-ID. Bei mehreren passenden Bindings für einen Tag nur das spezifischste. [continue] beendet das Skript; [break] beendet es und überspringt weitere Skripte für das Ereignis — wie bei [bind].

    Bindings am Canvas-Fenster per [bind] werden zusätzlich zu Item-Bindings per **bind**-Widget-Befehl aufgerufen; Item-Bindings vor Fenster-Bindings.

*pathName* **canvasx** *screenx* ?*gridspacing*?
: Zu einer Fenster-x-Koordinate *screenx* im Canvas die dort angezeigte Canvas-x-Koordinate. Mit *gridspacing* wird auf das nächste Vielfache von *gridspacing* gerundet.

*pathName* **canvasy** *screeny* ?*gridspacing*?
: Zu einer Fenster-y-Koordinate *screeny* im Canvas die dort angezeigte Canvas-y-Koordinate. Mit *gridspacing* wird auf das nächste Vielfache von *gridspacing* gerundet.

*pathName* **cget** *option*
: Gibt den aktuellen Wert der Konfigurationsoption *option* zurück. *Option* kann jeden vom Befehl **canvas** akzeptierten Wert haben.

*pathName* **configure** ?*option*? ?*value*? ?*option value ...*?
: Abfrage oder Änderung der Widget-Konfigurationsoptionen. Ohne *option*: Liste aller verfügbaren Optionen für *pathName* (Format siehe [Tk\_ConfigureInfo][ConfigWidg]). *option* ohne *value*: Liste für diese eine Option. Ein oder mehrere *option-value*-Paare ändern die Option(en); Rückgabe: leerer String. *Option* kann jeden vom Befehl **canvas** akzeptierten Wert haben.

*pathName* **coords** *tagOrId* ?*x0 y0 ...*?
: ...siehe nächstes...

*pathName* **coords** *tagOrId* ?*coordList*?
: Abfrage oder Änderung der Koordinaten, die ein Item definieren. Ohne Koordinaten: Liste der Koordinaten des durch *tagOrId* benannten Items. Mit Koordinaten: Ersetzen der aktuellen Koordinaten. Bei mehreren Items durch *tagOrId* wird das erste in der Anzeigeliste verwendet.

    Bei Rechtecken, Ovals und Bögen hat die zurückgegebene Koordinatenliste feste Reihenfolge: links, oben, rechts, unten — nicht unbedingt die ursprünglich angegebene. Koordinaten werden stets in Bildschirmeinheiten ohne Einheit (Pixel) zurückgegeben; waren sie z.B. in Zentimetern angegeben, sind die Rückgabewerte dennoch in Pixeln.

*pathName* **create** *type x y* ?*x y ...*? ?*option value ...*?
: ...siehe nächstes...

*pathName* **create** *type coordList* ?*option value ...*?
: Erstellt ein neues Item vom Typ *type* in *pathName*. Das genaue Format der Argumente nach *type* hängt vom Typ ab, meist Koordinaten eines oder mehrerer Punkte, gefolgt von null oder mehr Item-Optionen. Siehe die Unterabschnitte zu den Item-Typen unten. Rückgabe: ID des neuen Items.

*pathName* **dchars** *tagOrId first* ?*last*?
: Für jedes durch *tagOrId* bezeichnete Item werden die Zeichen bzw. Koordinaten im Bereich *first* bis *last* (einschließlich) gelöscht. Items ohne Index-Unterstützung ignorieren die Operation. Text-Items interpretieren *first* und *last* als Zeichenindizes; Linien- und Polygon-Items als Koordinatenindizes (x,y-Paar). Indizes siehe [Indizes] oben. Fehlt *last*, entspricht es *first*. Rückgabe: leerer String.

*pathName* **delete** ?*tagOrId tagOrId ...*?
: Löscht jedes durch *tagOrId* bezeichnete Item; Rückgabe: leerer String.

*pathName* **dtag** *tagOrId* ?*tagToDelete*?
: Entfernt für jedes durch *tagOrId* bezeichnete Item den Tag *tagToDelete* aus der zugehörigen Liste. Hat ein Item den Tag nicht, bleibt es unverändert. Fehlt *tagToDelete*, entspricht es *tagOrId*. Rückgabe: leerer String.

*pathName* **find** *searchCommand* ?*arg arg ...*?
: Gibt eine Liste aller Items zurück, die die durch *searchCommand* und *arg*s angegebenen Bedingungen erfüllen. *SearchCommand* und *args* haben die von **addtag** akzeptierten Formen. Items in Stapelreihenfolge, unterstes zuerst.

*pathName* **focus** ?*tagOrId*?
: Setzt den Tastaturfokus des Canvas auf das durch *tagOrId* bezeichnete Item. Bei mehreren Items: erstes in der Anzeigeliste mit Einfügemarken-Unterstützung. Bezeichnet *tagOrId* keine Items oder unterstützt keines die Einfügemarke, bleibt der Fokus unverändert. Ist *tagOrId* ein leerer String, hat kein Item den Fokus. Ohne *tagOrId*: ID des Items mit Fokus oder leerer String.
    Mit Fokus auf einem Item zeigt es die Einfügemarke; alle Tastaturereignisse gehen dorthin. Fokus-Item im Canvas und Fokus-Fenster auf dem Bildschirm (per [focus]) sind unabhängig: Ein Item hat den Eingabefokus nur, wenn (a) sein Canvas das Fokus-Fenster ist und (b) es das Fokus-Item im Canvas ist. Meist sollte auf den **focus**-Widget-Befehl der [focus]-Befehl folgen, um das Fokus-Fenster auf den Canvas zu setzen.


*pathName* **gettags** *tagOrId*
: Gibt eine Liste der mit dem durch *tagOrId* bezeichneten Item verknüpften Tags zurück. Bei mehreren Items: Tags des ersten in der Anzeigeliste. Bezeichnet *tagOrId* keine Items oder hat das Item keine Tags: leerer String.

*pathName* **icursor** *tagOrId index*
: Setzt die Einfügemarken-Position für die durch *tagOrId* bezeichneten Items unmittelbar vor das Zeichen an Position *index*. Items ohne Einfügemarke bleiben unverändert. Zulässige Formen für *index* siehe [Indizes] oben. Hinweis: Die Einfügemarke wird in einem Item nur angezeigt, wenn es gerade den Tastaturfokus hat (siehe Widget-Befehl **focus** oben); die Position kann aber auch gesetzt werden, wenn das Item den Fokus nicht hat. Rückgabe: leerer String.

*pathName* **imove** *tagOrId index x y*
: [Verschiebt die *index*. Koordinate jedes durch *tagOrId* bezeichneten Items nach (*x*,*y*). Jedes Item interpretiert *index* gemäß [Indizes] oben. Von den Standard-Items können nur Linien und Polygone ihre Koordinaten so verschieben.]{version="8.6"}

*pathName* **index** *tagOrId index*
: Gibt eine Dezimalzeichenkette mit dem numerischen Index innerhalb von *tagOrId* zurück, der *index* entspricht. *index* beschreibt die gewünschte Position gemäß [Indizes] oben. Text-Items: Zeichenindex; Linien und Polygone: Koordinatenindex (x,y-Paar). Der Rückgabewert liegt garantiert zwischen 0 und der Anzahl der Zeichen bzw. Koordinaten im Item (einschließlich). Bei mehreren Items wird das erste mit Index-Unterstützung in Anzeigelistenreihenfolge verwendet.

*pathName* **insert** *tagOrId beforeThis string*
: Für jedes durch *tagOrId* bezeichnete Item mit Text- oder Koordinaten-Einfügeunterstützung wird *string* unmittelbar vor das Zeichen bzw. die Koordinate mit Index *beforeThis* eingefügt. Text-Items: Zeichenindex; Linien und Polygone: Koordinatenindex. Bei Linien und Polygonen muss *string* eine gültige Koordinatenfolge sein. Zulässige Formen für *beforeThis* siehe [Indizes] oben. Rückgabe: leerer String.

*pathName* **itemcget** *tagOrId* *option*
: Gibt den aktuellen Wert der Konfigurationsoption *option* für das durch *tagOrId* bezeichnete Item zurück. Ähnlich **cget**, aber für ein einzelnes Item. *option* kann jeden beim **create**-Widget-Befehl akzeptierten Wert haben. Bei Tag mit mehreren Items: erstes (unterstes).

*pathName* **itemconfigure** *tagOrId* ?*option*? ?*value*? ?*option value ...*?
: Ähnlich **configure**, ändert aber Item-spezifische Optionen der durch *tagOrId* bezeichneten Items statt der Canvas-Gesamtoptionen. Ohne *option*: Liste aller Optionen für das erste Item (Format [Tk\_ConfigureInfo][ConfigWidg]). *option* ohne *value*: Liste für diese Option. *option-value*-Paare setzen die Werte in allen genannten Items; Rückgabe: leerer String. *option* und *value* wie beim **create**-Widget-Befehl; Details siehe Item-Typ-Abschnitte unten.

*pathName* **lower** *tagOrId* ?*belowThis*?
: Verschiebt alle durch *tagOrId* bezeichneten Items in der Anzeigeliste unmittelbar vor das durch *belowThis* bezeichnete Item. Bei mehreren Items werden alle verschoben; die relative Reihenfolge der verschobenen Items bleibt. *belowThis* ist Tag oder ID; bei mehreren Items wird das erste (unterste) als Ziel verwendet. Keine Wirkung auf Fenster-Items — sie verdecken stets andere Item-Typen, und deren Stapelreihenfolge bestimmen die Befehle [raise] und [lower], nicht die Canvas-Widget-Befehle **raise** und **lower**. Rückgabe: leerer String.

*pathName* **move** *tagOrId xAmount yAmount*
: Verschiebt jedes durch *tagOrId* bezeichnete Item im Canvas-Koordinatenraum um Addition von *xAmount* zu jeder x-Koordinate und *yAmount* zu jeder y-Koordinate aller zugehörigen Punkte. Rückgabe: leerer String.

*pathName* **moveto** *tagOrId xPos yPos*
: [Verschiebt die durch *tagOrId* bezeichneten Items so, dass das erste Koordinatenpaar (obere linke Ecke der Bounding-Box) des ersten Items (unterstes in der Anzeigeliste) mit Tag *tagOrId* an Position (*xPos*,*yPos*) liegt. *xPos* und *yPos* können leerer String sein (Koordinate unverändert). Alle passenden Items behalten ihre relative Position zueinander. Rückgabe: leerer String.]{version="8.6"}

*pathName* **postscript** ?*option value option value ...*?
: Erzeugt eine Postscript-Darstellung für einen Teil oder den gesamten Canvas. Mit Option **-file** wird Postscript in eine Datei geschrieben und ein leerer String zurückgegeben; sonst ist Postscript das Ergebnis des Befehls. Ist der Interpreter des Canvas als safe markiert, schlägt die Operation fehl (safe Interpreter dürfen keine Dateien schreiben). Mit **-channel** bezeichnet das Argument einen bereits zum Schreiben geöffneten Kanal; Postscript wird dorthin geschrieben, der Kanal bleibt offen. Postscript wird als Encapsulated Postscript nach Document Structuring Conventions Version 3.0 erzeugt. Hinweis: Standardmäßig wird Postscript nur für im Canvas-Fenster sichtbare Information erzeugt. Ein neu erstellter Canvas kann noch 1×1 Pixel groß sein — dann erscheint nichts im Postscript. Abhilfe: [update] aufrufen, bis das Fenster seine endgültige Größe hat, oder **-width** und **-height** zur Angabe des Druckbereichs. Die *option*-*value*-Paare steuern die Postscript-Erzeugung. Unterstützte Optionen:

    **-channel** *channelName*
    : Name des Kanals, in den Postscript geschrieben wird. Ohne diese und ohne **-file** wird Postscript als Befehlsergebnis zurückgegeben.

    **-colormap** *varName*
    : *VarName* muss der Name einer Array-Variable mit Farbzuordnung für Postscript sein. Jedes Element besteht aus Postscript-Code zum Setzen einer Farbe (z.B. „**1.0 1.0 0.0 setrgbcolor**“). Beim Ausgeben von Farbinformation prüft Tk, ob ein Element von *varName* denselben Namen wie die Farbe hat; dann wird dessen Wert als Postscript-Befehl verwendet. Ist diese Option nicht angegeben oder enthält *varName* keinen Eintrag für eine Farbe, verwendet Tk die Rot-, Grün- und Blau-Intensitäten der X-Farbe.

    **-colormode** *mode*
    : Steuert die Farbausgabe. *mode* muss **color** (Vollfarbe), **gray** (Graustufen) oder **mono** (Schwarz/Weiß) sein.

    **-file** *fileName*
    : Dateiname für Postscript. Ohne diese und ohne **-channel** wird Postscript als Befehlsergebnis zurückgegeben.

    **-fontmap** *varName*
    : *VarName* muss der Name einer Array-Variable mit Schriftzuordnung für Postscript sein. Jedes Element ist eine Tcl-Liste mit zwei Elementen: Name und Punktgröße einer Postscript-Schrift. Beim Ausgeben prüft Tk, ob *varName* ein Element mit demselben Namen wie die Schrift enthält; dann werden dessen Angaben verwendet. Sonst versucht Tk zu erraten. Das gelingt meist nur bei bekannten Schriften wie Times, Helvetica und Courier und nur, wenn der X-Schriftname bis zur Punktgröße keine Bindestriche auslässt. Zum Beispiel funktioniert **-\*-Courier-Bold-R-Normal--\*-120-\***, **\*Courier-Bold-R-Normal\*120\*** dagegen nicht; Tk braucht die Bindestriche, um den Schriftnamen zu zerlegen.

    **-height** *size*
    : Höhe des zu druckenden Canvas-Bereichs. Standard: Höhe des Canvas-Fensters.

    **-pageanchor** *anchor*
    : Welcher Punkt des gedruckten Canvas-Bereichs über dem Positionierungspunkt auf der Seite liegt (gegeben durch **-pagex** und **-pagey**). Zum Beispiel bedeutet **-pageanchor n**, dass die obere Mitte des gedruckten Canvas-Bereichs (wie er im Canvas-Fenster erscheint) über dem Positionierungspunkt liegt. Standard ist **center**.

    **-pageheight** *size*
    : Postscript wird in x und y skaliert, sodass der Druckbereich auf der Postscript-Seite *size* hoch ist. *size*: Gleitkommazahl gefolgt von **c** (Zentimeter), **i** (Zoll), **m** (Millimeter) oder **p** bzw. nichts (Druckerpunkte, 1/72 Zoll). Standard: Bildschirmhöhe des Druckbereichs. Sind **-pageheight** und **-pagewidth** gesetzt, wird der Skalierungsfaktor von **-pagewidth** verwendet (ungleichmäßige Skalierung ist nicht implementiert).

    **-pagewidth** *size*
    : Wie **-pageheight**, aber für die Breite. *size* hat dieselbe Form. Standard: Bildschirmbreite. Bei beiden Optionen gilt der Skalierungsfaktor von **-pagewidth**.

    **-pagex** *position*
    : *position* gibt die x-Koordinate des Positionierungspunkts auf der Postscript-Seite in einer für **-pageheight** zulässigen Form. Zusammen mit **-pagey** und **-pageanchor** bestimmt dies die Platzierung. Standard: Seitenmitte.

    **-pagey** *position*
    : *position* gibt die y-Koordinate des Positionierungspunkts auf der Postscript-Seite. Zusammen mit **-pagex** und **-pageanchor**. Standard: Seitenmitte.

    **-rotate** *boolean*
    : *boolean* gibt an, ob der Druckbereich um 90 Grad gedreht wird. Ohne Drehung verläuft die x-Achse entlang der kurzen Seite („Hochformat“); mit Drehung entlang der langen Seite („Querformat“). Standard: nicht gedreht.

    **-width** *size*
    : Breite des zu druckenden Canvas-Bereichs. Standard: Breite des Canvas-Fensters.

    **-x** *position*
    : x-Koordinate der linken Kante des zu druckenden Bereichs in Canvas-Koordinaten, nicht Fensterkoordinaten. Standard: linke Fensterkante.

    **-y** *position*
    : y-Koordinate der oberen Kante des zu druckenden Bereichs in Canvas-Koordinaten. Standard: obere Fensterkante.


*pathName* **raise** *tagOrId* ?*aboveThis*?
: Verschiebt alle durch *tagOrId* bezeichneten Items in der Anzeigeliste unmittelbar nach dem durch *aboveThis* bezeichneten Item. Bei mehreren Items werden alle verschoben; die relative Reihenfolge bleibt. *aboveThis* ist Tag oder ID; bei mehreren Items wird das letzte (oberste) als Ziel verwendet. Rückgabe: leerer String.
    Hinweis: Dieser Befehl hat keine Wirkung auf Fenster-Items. Fenster-Items verdecken stets andere Item-Typen; ihre Stapelreihenfolge bestimmen die Befehle [raise] und [lower], nicht die Canvas-Widget-Befehle **raise** und **lower**.


*pathName* **rchars** *tagOrId first last string*
: [Ersetzt für jedes durch *tagOrId* bezeichnete Item den Text bzw. die Koordinaten zwischen *first* und *last* durch *string*. Jedes Item interpretiert *first* und *last* gemäß [Indizes] oben. Text-Items ändern ihren Text; Linien und Polygone ihre Koordinatenliste (*string* dann Koordinatenliste). Andere Items ignorieren die Operation.]{version="8.6"}

*pathName* **scale** *tagOrId xOrigin yOrigin xScale yScale*
: Skaliert die Koordinaten aller durch *tagOrId* bezeichneten Items im Canvas-Koordinatenraum. *xOrigin* und *yOrigin* sind der Skalierungsursprung; *xScale* und *yScale* die Skalierungsfaktoren für x- bzw. y-Koordinaten (1.0 = keine Änderung). Für jeden Punkt wird die x-Koordinate so angepasst, dass der Abstand von *xOrigin* mit *xScale* multipliziert wird; analog für y. Rückgabe: leerer String.

    Einige Items haben nur ein Koordinatenpaar (Text, Bilder, Fenster) — Skalierung verschiebt sie dann nur.

*pathName* **scan** *option args*
: Implementiert Scanning auf Canvas. Zwei Formen je nach *option*:

    *pathName* **scan mark** *x y*
    : Speichert *x*, *y* und die aktuelle Canvas-Ansicht; für spätere **scan dragto**-Befehle. Typischerweise bei Maustastendruck; *x* und *y* sind Mauskoordinaten. Rückgabe: leerer String.

    *pathName* **scan dragto** *x y ?gain?*
    : Berechnet die Differenz zwischen *x*, *y* (meist Mauskoordinaten) und den Argumenten des letzten **scan mark** für das Widget. Passt die Ansicht um *gain* mal die Koordinatendifferenz an (*gain* standardmäßig 10). Typischerweise bei Mausbewegung, um schnelles Ziehen des Canvas durch das Fenster zu simulieren. Rückgabe: leerer String.


*pathName* **select** *option* ?*tagOrId arg*?
: Manipuliert die Auswahl auf verschiedene Weise je nach *option*. Formen siehe unten. *tagOrId* muss ein Item mit Index- und Auswahl-Unterstützung bezeichnen; bei mehreren Items das erste mit dieser Unterstützung. *index* beschreibt eine Position in *tagOrId* gemäß [Indizes] oben.

    *pathName* **select adjust** *tagOrId index*
    : Findet das Auswahlende in *tagOrId*, das dem Zeichen *index* am nächsten ist, und setzt dieses Ende auf *index* (einschließlich, aber nicht darüber hinaus). Das andere Ende wird Anker für künftige **select to**-Befehle. Liegt die Auswahl nicht in *tagOrId*, verhält sich der Befehl wie **select to**. Rückgabe: leerer String.

    *pathName* **select clear**
    : Löscht die Auswahl, wenn sie in diesem Widget liegt. Sonst keine Wirkung. Rückgabe: leerer String.

    *pathName* **select from** *tagOrId index*
    : Setzt den Auswahlanker des Widgets unmittelbar vor das durch *index* bezeichnete Zeichen im durch *tagOrId* bezeichneten Item. Ändert die Auswahl nicht; setzt nur das feste Ende für künftige **select to**-Befehle. Rückgabe: leerer String.

    *pathName* **select item**
    : Gibt die ID des ausgewählten Items zurück, wenn die Auswahl in einem Item dieses Canvas liegt. Sonst leerer String.

    *pathName* **select to** *tagOrId index*
    : Setzt die Auswahl auf die Zeichen von *tagOrId* zwischen Auswahlanker und *index*. Die neue Auswahl schließt das Zeichen *index* ein; das Ankerzeichen nur, wenn *index* größer oder gleich dem Anker ist. Der Anker ergibt sich aus dem letzten **select adjust** oder **select from** für dieses Widget. Liegt der Anker nicht in *tagOrId*, wird er auf dasselbe Zeichen wie *index* gesetzt. Rückgabe: leerer String.


*pathName* **type** *tagOrId*
: Gibt den Typ des durch *tagOrId* bezeichneten Items zurück, z.B. **rectangle** oder **text**. Bei mehreren Items: Typ des ersten in der Anzeigeliste. Bezeichnet *tagOrId* keine Items: leerer String.

*pathName* **xview** ?*args*?
: Abfrage und Änderung der horizontalen Position der im Canvas-Fenster angezeigten Information. Formen:

    *pathName* **xview**
    : Liste mit zwei Elementen — reelle Brüche zwischen 0 und 1, die den sichtbaren horizontalen Bereich beschreiben. Z.B. .2 und .6: 20 % der Canvas-Fläche (laut **-scrollregion**) links außerhalb, mittlere 40 % sichtbar, 40 % rechts außerhalb. Dieselben Werte wie an Scrollbars über **-xscrollcommand**.

    *pathName* **xview moveto** *fraction*
    : Passt die Ansicht so an, dass *fraction* der Gesamtbreite des Canvas links außerhalb liegt. *fraction* zwischen 0 und 1.

    *pathName* **xview scroll** *number what*
    : Verschiebt die Ansicht im Fenster links oder rechts gemäß *number* und *what*. *Number* muss eine Ganzzahl sein. *What* muss **units** oder **pages** sein (oder eine Abkürzung davon). Ist *what* **units**, passt sich die Ansicht in Einheiten der Option **xScrollIncrement** an, falls diese größer als null ist, sonst in Einheiten von einem Zehntel der Fensterbreite. Ist *what* **pages**, passt sich die Ansicht in Einheiten von neun Zehnteln der Fensterbreite an. Ist *number* negativ, wird weiter links gelegene Information sichtbar; ist es positiv, weiter rechts gelegene.


*pathName* **yview** ?*args*?
: Abfrage und Änderung der vertikalen Position der im Canvas-Fenster angezeigten Information. Formen:

    *pathName* **yview**
    : Liste mit zwei Elementen — Brüche zwischen 0 und 1 für den sichtbaren vertikalen Bereich. Z.B. .6 und 1.0: unterste 40 % der Canvas-Fläche (laut **-scrollregion**) sichtbar. Dieselben Werte wie an Scrollbars über **-yscrollcommand**.

    *pathName* **yview moveto** *fraction*
    : Passt die Ansicht so an, dass *fraction* der Canvas-Fläche oberhalb außerhalb liegt. *fraction* zwischen 0 und 1.

    *pathName* **yview scroll** *number what*
    : Verschiebt die Ansicht im Fenster nach oben oder unten gemäß *number* und *what*. *Number* muss eine Ganzzahl sein. *What* muss **units** oder **pages** sein. Ist *what* **units**, passt sich die Ansicht in Einheiten der Option **yScrollIncrement** an, falls diese größer als null ist, sonst in Einheiten von einem Zehntel der Fensterhöhe. Ist *what* **pages**, passt sich die Ansicht in Einheiten von neun Zehnteln der Fensterhöhe an. Ist *number* negativ, wird höher gelegene Information sichtbar; ist es positiv, tiefer gelegene.



# Übersicht der Item-Typen

Die folgenden Abschnitte beschreiben die von Canvas-Widgets unterstützten Item-Typen. Jeder Item-Typ ist durch zwei Dinge gekennzeichnet: die Form des **create**-Befehls zum Erzeugen von Instanzen des Typs und eine Menge Konfigurationsoptionen für Items dieses Typs, verwendbar in den Widget-Befehlen **create** und **itemconfigure**. Die meisten Items unterstützen weder Indexierung noch Auswahl noch die zugehörigen Befehle wie **index** und **insert**. Wo Items diese Funktionen unterstützen, ist es in den Beschreibungen unten ausdrücklich vermerkt. Derzeit bieten Text-, Linien- und Polygon-Items diese Unterstützung. Bei Linien und Polygonen dient die Indexierung der Manipulation der Item-Koordinaten.

## Gemeinsame Item-Optionen

Viele Items teilen einen gemeinsamen Optionssatz. Diese Optionen werden hier erläutert und von jedem Widget-Typ der Kürze halber nur referenziert.

**-anchor** *anchorPos*
: *anchorPos* legt fest, wie das Item relativ zum Positionierungspunkt platziert wird; zulässig sind alle von [Tk\_GetAnchor][GetAnchor] akzeptierten Formen. Ist *anchorPos* **center**, ist das Item auf dem Punkt zentriert; ist es **n**, wird es so gezeichnet, dass seine obere Mitte am Positionierungspunkt liegt. Standard: **center**.

**-dash** *pattern*
: ...siehe nächstes...

**-activedash** *pattern*
: ...siehe nächstes...

**-disableddash** *pattern*
: Diese Option legt Strichmuster für den normalen, aktiven und deaktivierten Zustand eines Items fest. *pattern* kann jede von [Tk\_GetDash][GetDash] akzeptierte Form haben. Fehlen die Strichoptionen, ist der Standard ein durchgezogener Umriss. Siehe [Strichmuster] für weitere Informationen.

**-dashoffset** *offset*
: Start-*offset* in Pixeln in das von **-dash** bereitgestellte Muster. **-dashoffset** wird ignoriert, wenn kein **-dash**-Muster gesetzt ist. *offset* kann jede im Abschnitt [Koordinaten] beschriebene Form haben.

**-fill** *color*
: ...siehe nächstes...

**-activefill** *color*
: ...siehe nächstes...

**-disabledfill** *color*
: Legt die Füllfarbe des Item-Bereichs in normalen, aktiven und deaktivierten Zuständen fest. Es gilt die Even-Odd-Füllregel. *Color* kann jede von [Tk\_GetColor][GetColor] akzeptierte Form haben. Bei Linien-Items: Farbe der gezeichneten Linie. Bei Text-Items: Vordergrundfarbe des Textes. Ist *color* ein leerer String (Standard für alle Canvas-Items außer Linie und Text), wird das Item nicht gefüllt.

**-outline** *color*
: ...siehe nächstes...

**-activeoutline** *color*
: ...siehe nächstes...

**-disabledoutline** *color*
: Diese Option legt die Umrissfarbe in normalen, aktiven und deaktivierten Zuständen fest. *Color* kann jede von [Tk\_GetColor][GetColor] akzeptierte Form haben. Ist *color* ein leerer String, wird kein Umriss gezeichnet.

**-offset** *offset*
: Legt den Versatz von Stippelmuster fest. Der Wert kann die Form **x,y** oder *side* haben, wobei *side* **n**, **ne**, **e**, **se**, **s**, **sw**, **w**, **nw** oder **center** sein kann. Im ersten Fall ist der Ursprung der des Toplevel des aktuellen Fensters. Für den Canvas selbst und Canvas-Objekte ist der Ursprung der Canvas-Ursprung; **#** vor dem Koordinatenpaar bedeutet Toplevel-Ursprung. Bei Canvas-Objekten steuert **-offset** auch Stippelung. Bei Linien- und Polygon-Items kann ein Index angegeben werden, der den Stippelursprung mit einem Koordinatenpunkt verbindet. Stippelversätze werden *nur unter X11 unterstützt*; auf anderen Plattformen still ignoriert.

**-outlinestipple** *bitmap*
: ...siehe nächstes...

**-activeoutlinestipple** *bitmap*
: ...siehe nächstes...

**-disabledoutlinestipple** *bitmap*
: Diese Option legt Stippelmuster für den Umriss in normalen, aktiven und deaktivierten Zuständen fest. *bitmap* gibt das Muster in einer von [Tk\_GetBitmap][GetBitmap] akzeptierten Form an. Ohne **-outline** keine Wirkung. Ist *bitmap* leerer String (Standard), wird der Umriss durchgezogen gezeichnet. *Stippel werden auf Plattformen ohne X11 als Zeichen-API nur eingeschränkt unterstützt.*

**-outlineoffset** *offset*
: Versatz des Stippelmusters für Umrisse, analog zur Steuerung von Füll-Stippeln durch **-stipple**. (Syntax von *offset* siehe **-offset**.)

**-stipple** *bitmap*
: ...siehe nächstes...

**-activestipple** *bitmap*
: ...siehe nächstes...

**-disabledstipple** *bitmap*
: Diese Option legt Stippelmuster für die Füllung in normalen, aktiven und deaktivierten Zuständen fest. *bitmap* in einer von [Tk\_GetBitmap][GetBitmap] akzeptierten Form. Ohne **-fill** keine Wirkung. Ist *bitmap* leerer String (Standard), erfolgt Füllung durchgezogen. Bei Text-Items betrifft es den eigentlichen Text. *Stippel werden auf Plattformen ohne X11 als Zeichen-API nur eingeschränkt unterstützt.*

**-state** *state*
: Ermöglicht einem Item, die globale *state*-Option des Canvas zu überschreiben. Dieselben Werte: *normal*, *disabled* oder *hidden*.

**-tags** *tagList*
: Legt Tags für das Item fest. *tagList* ist eine Liste von Tag-Namen, die bestehende Tags ersetzen. *tagList* kann leer sein.

**-width** *outlineWidth*
: ...siehe nächstes...

**-activewidth** *outlineWidth*
: ...siehe nächstes...

**-disabledwidth** *outlineWidth*
: Legt die Umrissbreite um den Item-Bereich in normalen, aktiven und deaktivierten Zuständen fest. *outlineWidth* in einer im Abschnitt [Koordinaten] oben beschriebenen Form. Ist **-outline** leerer String, keine Wirkung. Standard 1.0. Bei Bögen werden breite Umrisse zentriert auf die Kanten des Bogenbereichs gezeichnet.


# Standard-Item-Typen

## Bogen-Items

Items vom Typ **arc** erscheinen als bogenförmige Bereiche. Ein Bogen ist ein Abschnitt einer Ovalform, begrenzt durch zwei Winkel (über **-start** und **-extent**) und auf eine von mehreren Arten dargestellt (**-style**). Bögen werden mit Widget-Befehlen folgender Form erstellt:

```
pathName create arc x1 y1 x2 y2 ?option value ...?
pathName create arc coordList ?option value ...?
```

Die Argumente *x1*, *y1*, *x2* und *y2* oder *coordList* geben die Koordinaten zweier diagonal gegenüberliegender Ecken eines Rechtecks an, das die den Bogen definierende Ovalform umschließt. Nach den Koordinaten können beliebig viele *option*-*value*-Paare folgen, die Konfigurationsoptionen setzen. Dieselben Paare können in **itemconfigure**-Widget-Befehlen verwendet werden. Ein Bogen-Item wird aktuelles Item, wenn der Mauszeiger über einen gezeichneten Teil liegt oder (bei vollständiger Transparenz) über einen Teil, der gezeichnet würde, wenn **-fill** und **-outline** nicht leer wären.

Folgende Standardoptionen unterstützen Bögen:

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

Zusätzliche Optionen für Bögen:

**-extent** *degrees*
: Größe des Winkelbereichs des Bogens. Der Bereich erstreckt sich *degrees* Grad gegen den Uhrzeigersinn ab dem Startwinkel von **-start**. *degrees* kann negativ sein. Ist der Wert größer als 360 oder kleiner als -360, wird *degrees* modulo 360 als Ausdehnung verwendet.

**-start** *degrees*
: Beginn des Winkelbereichs. *degrees* in Grad gegen den Uhrzeigersinn ab der 3-Uhr-Position; positiv oder negativ.

**-style** *type*
: Zeichenweise des Bogens. Bei **pieslice** (Standard) wird der Bereich durch einen Abschnitt des Ovalumfangs plus zwei Linien vom Ovalzentrum zu den Endpunkten des Abschnitts definiert. Bei **chord** ein Umfangsabschnitt plus eine Verbindungslinie zwischen den Endpunkten. Bei **arc** nur der Umfangsabschnitt; dann wird **-fill** ignoriert.


## Bitmap-Items

Items vom Typ **bitmap** erscheinen als Bilder mit zwei Farben, Vorder- und Hintergrund. Bitmaps werden mit Widget-Befehlen folgender Form erstellt:

```
pathName create bitmap x y ?option value ...?
pathName create bitmap coordList ?option value ...?
```

Die Argumente *x* und *y* oder *coordList* (zwei Elemente) geben die Koordinaten eines Punkts zur Positionierung des Bitmaps an, gesteuert durch **-anchor**. Nach den Koordinaten können *option*-*value*-Paare folgen; dieselben Paare in **itemconfigure**. Ein Bitmap-Item wird aktuelles Item, wenn der Mauszeiger über einen Teil seiner Bounding-Box liegt.

Folgende Standardoptionen unterstützen Bitmaps:

::: {.info DISPLAY="yes"}
**-anchor**	**-state**\
**-tags**
:::

Zusätzliche Optionen für Bitmaps:

**-background** *color*
: ...siehe nächstes...

**-activebackground** *color*
: ...siehe nächstes...

**-disabledbackground** *color*
: Farbe für die „0“-Pixel des Bitmaps in normalen, aktiven und deaktivierten Zuständen. *color* kann jede von [Tk\_GetColor][GetColor] akzeptierte Form haben. Ohne Angabe oder bei leerem String wird an Stellen mit 0-Pixeln nichts gezeichnet — transparenter Effekt.

**-bitmap** *bitmap*
: ...siehe nächstes...

**-activebitmap** *bitmap*
: ...siehe nächstes...

**-disabledbitmap** *bitmap*
: Legt die in normalen, aktiven und deaktivierten Zuständen anzuzeigenden Bitmaps fest. *Bitmap* kann jede von [Tk\_GetBitmap][GetBitmap] akzeptierte Form haben.

**-foreground** *color*
: ...siehe nächstes...

**-activeforeground** *color*
: ...siehe nächstes...

**-disabledforeground** *color*
: Legt die Farbe für die „1“-Pixel des Bitmaps in normalen, aktiven und deaktivierten Zuständen fest. *Color* kann jede von [Tk\_GetColor][GetColor] akzeptierte Form haben.


## Bild-Items

Items vom Typ [image] zeigen Bilder auf einem Canvas an. Bilder werden mit Widget-Befehlen folgender Form erstellt:

```
pathName create image x y ?option value ...?
pathName create image coordList ?option value ...?
```

Die Argumente *x* und *y* oder *coordList* geben den Positionierungspunkt an (**-anchor**). Nach den Koordinaten *option*-*value*-Paare; dieselben in **itemconfigure**. Ein Bild-Item wird aktuelles Item über der Bounding-Box.

Folgende Standardoptionen unterstützen Bilder:

::: {.info DISPLAY="yes"}
**-anchor**	**-state**\
**-tags**
:::

Zusätzliche Optionen für Bilder:

**-image** *name*
: ...siehe nächstes...

**-activeimage** *name*
: ...siehe nächstes...

**-disabledimage** *name*
: Namen der Bilder in normalen, aktiven und deaktivierten Zuständen. Das Bild muss zuvor mit [image create][image] erstellt worden sein.


## Linien-Items

Items vom Typ **line** erscheinen als eine oder mehrere verbundene Liniensegmente oder Kurven. Linien-Items unterstützen Koordinaten-Indexierung mit **dchars**, **index** und **insert**. Linien werden mit Widget-Befehlen folgender Form erstellt:

```
pathName create line x1 y1... xn yn ?option value ...?
pathName create line coordList ?option value ...?
```

Die Argumente *x1* bis *yn* oder *coordList* geben Koordinaten für zwei oder mehr Punkte verbundener Segmente. Danach *option*-*value*-Paare; dieselben in **itemconfigure**. Eine Linie ist aktuelles Item, wenn der Mauszeiger über einem Segment liegt — gezeichnet oder nicht, geglättet oder nicht.

Folgende Standardoptionen unterstützen Linien:

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

Zusätzliche Optionen für Linien:

**-arrow** *where*
: Gibt an, ob Pfeilspitzen an einem oder beiden Linienenden gezeichnet werden. *where* muss **none**, **first**, **last** oder **both** sein. Standard **none**. Beim Zeichnen einer Pfeilspitze passt Tk den Linienendpunkt so an, dass die Linie am Pfeilhals endet, nicht an der Spitze. Das kann **Leave** auslösen, wenn die Maus am Linienende schwebt; beim Entfernen umgekehrt **Enter**.

**-arrowshape** *shape*
: Form der Pfeilspitzen. *shape* ist eine Liste mit drei Elementen — Abstände in Formen aus [Koordinaten]. Erstes Element: Abstand entlang der Linie vom Pfeilhals zur Spitze. Zweites: von den Hinterpunkten zur Spitze. Drittes: vom Linienrand zu den Hinterpunkten. Ohne Angabe wählt Tk eine „vernünftige“ Form.

**-capstyle** *style*
: Endenzeichnung an Linienenden. *style* kann jede von [Tk\_GetCapStyle][GetCapStyl] akzeptierte Form haben (**butt**, **projecting**, **round**). Standard **butt**. Bei Pfeilspitzen wird der Cap-Stil ignoriert.

**-joinstyle** *style*
: Verbindungszeichnung an Linienecken. *style* kann jede von [Tk\_GetJoinStyle][GetJoinStl] akzeptierte Form haben (**bevel**, **miter**, **round**). Standard **round**. Bei nur zwei Punkten irrelevant.

**-smooth** *smoothMethod*
: *smoothMethod* muss eine von [Tcl\_GetBoolean][GetInt] akzeptierte Form oder eine Glättungsmethode sein. Im Kern nur **true** und **raw** (**bezier** Alias für **true**), weitere zur Laufzeit. Bei false oder leerem String keine Glättung; bei true **true**-Glättung. Bei **true** wird die Linie als Kurve mit quadratischen Splines gezeichnet: je ein Spline pro benachbartes Segmentpaar. Gerade Segmente durch Duplizieren der Endpunkte. Bei **raw** ist jedes erste (und jedes dritte) Koordinatenpaar ein Knotenpunkt einer kubischen Bézier-Kurve, die anderen Kontrollpunkte. Gerade Segmente durch gleiche Kontroll- und Knotenpunkte. Ist der letzte Punkt nur Kontrollpunkt, wird er ein- oder zweimal wiederholt.

**-splinesteps** *number*
: Gewünschter Glättegrad für Kurven: jeder Spline wird mit *number* Liniensegmenten approximiert. Ignoriert, wenn **-smooth** nicht true oder **raw** ist.


## Oval-Items

Items vom Typ **oval** erscheinen als kreisförmige oder ovale Bereiche. Jedes Oval kann Umriss, Füllung oder beides haben. Ovale werden mit Widget-Befehlen folgender Form erstellt:

```
pathName create oval x1 y1 x2 y2 ?option value ...?
pathName create oval coordList ?option value ...?
```

Die Argumente *x1*, *y1*, *x2*, *y2* oder *coordList* geben diagonal gegenüberliegende Ecken des umschließenden Rechtecks an. Das Oval schließt die obere und linke Kante ein, nicht die untere und rechte. Ist das Rechteck quadratisch, ist das Oval kreisförmig; sonst oval. Danach *option*-*value*-Paare; dieselben in **itemconfigure**. Aktuelles Item bei Maus über gezeichnetem Teil oder (transparent) über Teil, der bei nicht leeren **-fill** und **-outline** gezeichnet würde.

Folgende Standardoptionen unterstützen Ovale:

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

Es gibt keine oval-spezifischen Optionen.

## Polygon-Items

Items vom Typ **polygon** erscheinen als polygonale oder gekrümmte gefüllte Bereiche. Polygon-Items unterstützen Koordinaten-Indexierung mit **dchars**, **index** und **insert**. Polygone werden mit Widget-Befehlen folgender Form erstellt:

```
pathName create polygon x1 y1 ... xn yn ?option value ...?
pathName create polygon coordList ?option value ...?
```

Die Argumente *x1* bis *yn* oder *coordList* geben Koordinaten für drei oder mehr Eckpunkte. Der erste Punkt soll nicht als letzter wiederholt werden; Tk schließt den Umfang automatisch. Danach *option*-*value*-Paare; dieselben in **itemconfigure**. Aktuelles Item bei Maus über beliebigem Teilstück — gezeichnet oder nicht, Umriss geglättet oder nicht.

Folgende Standardoptionen unterstützen Polygone:

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

Zusätzliche Optionen für Polygone:

**-joinstyle** *style*
: Verbindungszeichnung an Umriss-Ecken. *style* kann jede von [Tk\_GetJoinStyle][GetJoinStl] akzeptierte Form haben. Standard **round**.

**-smooth** *boolean*
: *boolean* muss eine von [Tcl\_GetBoolean][GetInt] akzeptierte Form oder Glättungsmethode sein. Im Kern nur **true** und **raw** (**bezier** Alias für **true**). Bei false oder leerem String keine Glättung. Bei **true** quadratische Splines wie bei Linien. Bei **raw** kubische Bézier-Knoten und Kontrollpunkte wie bei Linien; fehlt am Ende das zweite Kontrollpunkt-Paar, wird der Punkt ein- oder zweimal wiederholt.

**-splinesteps** *number*
: Gewünschter Glättegrad für Kurven: jeder Spline wird mit *number* Liniensegmenten approximiert. Ignoriert, wenn **-smooth** nicht true oder **raw** ist.


Polygon-Items unterscheiden sich von Rechtecken, Ovalen und Bögen: Innenpunkte gelten als „innerhalb“ (z.B. für **find closest** und **find overlapping**), auch ohne Füllung. Bei den meisten anderen Typen nur bei Füllung oder ohne Füllung und Umriss. Für ein ungefülltes Polygon, dessen Innen nicht als „innerhalb“ gilt, ein Linien-Item verwenden.

## Rechteck-Items

Items vom Typ **rectangle** erscheinen als rechteckige Bereiche mit optionalem Umriss, Füllung oder beidem. Erstellung mit Widget-Befehlen folgender Form:

```
pathName create rectangle x1 y1 x2 y2 ?option value ...?
pathName create rectangle coordList ?option value ...?
```

Die Argumente *x1*, *y1*, *x2*, *y2* oder *coordList* (vier Elemente) geben diagonal gegenüberliegende Ecken an (obere und linke Kante eingeschlossen, untere und rechte nicht). Danach *option*-*value*-Paare; dieselben in **itemconfigure**. Aktuelles Item wie bei Ovalen.

Folgende Standardoptionen unterstützen Rechtecke:

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

Es gibt keine rechteck-spezifischen Optionen.

## Text-Items

Ein Text-Item zeigt eine Zeichenkette in einer oder mehreren Zeilen. Text-Items unterstützen Indexierung, Bearbeitung und Auswahl über **dchars**, **focus**, **icursor**, **index**, **insert** und **select**. Erstellung mit Widget-Befehlen folgender Form:

```
pathName create text x y ?option value ...?
pathName create text coordList ?option value ...?
```

Die Argumente *x* und *y* oder *coordList* (zwei Elemente) positionieren den Text (siehe Optionen unten). Danach *option*-*value*-Paare; dieselben in **itemconfigure**. Aktuelles Item über der Bounding-Box.

Folgende Standardoptionen unterstützen Text-Items:

::: {.info DISPLAY="yes"}
**-anchor**	**-fill**\
**-activefill**	**-disabledfill**\
**-stipple**	**-activestipple**\
**-disabledstipple**	**-state**\
**-tags**
:::

Zusätzliche Optionen für Text-Items:

**-angle** *rotationDegrees*
: [*rotationDegrees* gibt die Drehung des Textes gegen den Uhrzeigersinn um den Positionierungspunkt in Grad (0.0 bis 360.0). Bei **90** wird der Text von unten nach oben gezeichnet. Standard **0.0**.]{version="8.6"}

**-font** *fontName*
: Schrift für das Text-Item. *fontName* jeder von [Tk\_GetFont][GetFont] akzeptierte String. Standard: systemspezifische Schrift.

**-justify** *how*
: Ausrichtung des Textes im Begrenzungsbereich. *how* muss **left**, **right** oder **center** sein. Nur relevant bei mehrzeiligem Text. Standard **left**.

**-text** *string*
: *string* gibt die anzuzeigenden Zeichen an. Zeilenumbrüche durch Newline. Änderbar mit **insert** und **delete**. Standard: leerer String.

**-underline**
: Index des zu unterstreichenden Zeichens. 0 = erstes Zeichen, 1 = nächstes usw. -1 = keine Unterstreichung (für gesamten Text passende Schrift verwenden).

**-width** *lineLength*
: Maximale Zeilenlänge in Formen aus [Koordinaten]. Bei 0 (Standard) nur Umbruch bei Newline. Sonst wird vor einem Leerzeichen umgebrochen, wenn die Zeile länger als *lineLength* wäre; das Leerzeichen gilt wie Newline.


## Fenster-Items

Items vom Typ **window** zeigen ein bestimmtes Fenster an einer Position auf dem Canvas. Erstellung mit Widget-Befehlen folgender Form:

```
pathName create window x y ?option value ...?
pathName create window coordList ?option value ...?
```

Die Argumente *x* und *y* oder *coordList* (zwei Elemente) positionieren das Fenster (**-anchor**). Danach *option*-*value*-Paare; dieselben in **itemconfigure**. Theoretisch aktuelles Item über der Bounding-Box; praktisch oft nicht, weil der Mauszeiger dann nicht mehr über dem Canvas liegt.

Folgende Standardoptionen unterstützen Fenster-Items:

::: {.info DISPLAY="yes"}
**-anchor**	**-state**\
**-tags**
:::

Zusätzliche Optionen für Fenster-Items:

**-height** *pixels*
: Höhe des Item-Fensters. *pixels* in Formen aus [Koordinaten]. Ohne Angabe oder bei 0 die intern angeforderte Höhe.

**-width** *pixels*
: Breite des Item-Fensters. *pixels* in Formen aus [Koordinaten]. Ohne Angabe oder bei 0 die intern angeforderte Breite.

**-window** *pathName*
: Mit diesem Item zu verknüpfendes Fenster. *pathName* muss Kind des Canvas oder eines Vorfahren sein, nicht Toplevel.


Hinweis: Aufgrund von Fensterverwaltungsbeschränkungen können andere grafische Items (Linien, Bilder) nicht über Fenster-Items gezeichnet werden. Ein Fenster-Item verdeckt stets überlappende Grafik, unabhängig von der Anzeigeliste. Fenster-Items werden außerdem, anders als andere Canvas-Items, nicht am Canvas-Rand beschnitten, sondern am Eltern-Widget des in **-window** angegebenen Fensters; ist das der Canvas, kann das Fenster-Item über den Canvas-Rand hinausragen.

# Anwendungsdefinierte Item-Typen

Einzelne Anwendungen können mit C-Code neue Item-Typen für Canvas-Widgets definieren. Siehe [Tk\_CreateItemType][CrtItemType].

# Bindings

In der aktuellen Implementierung erhalten neue Canvas kein Standardverhalten: Sie müssen explizite Tcl-Befehle ausführen, um dem Canvas sein Verhalten zu geben.

# Danksagungen

Das Canvas-Widget von Tk übernimmt Ideen aus Joel Bartletts Programm *ezd*. *Ezd* bietet strukturierte Grafik in einer Scheme-Umgebung und ging Canvas um ein bis zwei Jahre voraus. Seine einfachen Mechanismen zum Platzieren und Animieren grafischer Objekte inspirierten die Canvas-Funktionen.


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
