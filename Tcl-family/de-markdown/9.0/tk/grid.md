---
CommandName: grid
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - pack(n)
 - place(n)
Keywords:
 - geometry manager
 - location
 - grid
 - cell
 - propagation
 - size
 - pack
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
---

# NAME

grid - Geometrie-Manager, der Widgets in einem Raster anordnet

# ÜBERSICHT

::: {.synopsis} :::
[grid]{.cmd} [option]{.arg} [arg]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **grid** dient der Kommunikation mit dem Grid-Geometrie-Manager, der Widgets in Zeilen und Spalten innerhalb eines anderen Fensters anordnet, des Geometrie-Containers (oder Container-Fensters). Der Befehl **grid** kann je nach dem Argument *option* mehrere Formen annehmen:

**grid** *window* ?*window ...*? ?*options*?
: Wenn das erste Argument von **grid** als erstes Fensterargument für **grid configure** geeignet ist — entweder ein Fenstername (ein Wert, der mit **.** beginnt) oder eines der Zeichen **x** oder **^** (siehe Abschnitt **RELATIVE PLATZIERUNG** unten) —, wird der Befehl auf dieselbe Weise verarbeitet wie **grid configure**.

**grid anchor** *window* ?*anchor*?
: Der Ankerwert steuert, wie das Raster im Container-Fenster platziert wird, wenn keine Zeile oder Spalte ein Gewicht hat. Siehe **DER GRID-ALGORITHMUS** unten. Der Standard-*anchor* ist *nw*.

**grid bbox** *window* ?*column row*? ?*column2 row2*?
: Ohne Argumente wird die Begrenzungsbox (in Pixeln) des Rasters zurückgegeben. Der Rückgabewert besteht aus 4 Ganzzahlen. Die ersten beiden sind der Pixel-Offset vom Container-Fenster (zuerst x, dann y) der oberen linken Ecke des Rasters, die zweiten beiden sind Breite und Höhe des Rasters, ebenfalls in Pixeln. Wird auf der Befehlszeile genau eine *column* und *row* angegeben, wird die Begrenzungsbox für diese Zelle zurückgegeben; die Zelle oben links ist mit Null nummeriert. Werden sowohl *column* als auch *row* angegeben, wird die Begrenzungsbox zurückgegeben, die die angegebenen Zeilen und Spalten umfasst.

**grid columnconfigure** *window index* ?*-option value...*?
: Abfrage oder Festlegung der Spalteneigenschaften der Spalte *index* des Geometrie-Containers *window*. Gültige Optionen sind **-minsize**, **-weight**, **-uniform** und **-pad**. Wenn eine oder mehrere Optionen angegeben werden, kann *index* als Liste von Spaltenindizes angegeben werden, auf die die Konfigurationsoptionen wirken. Indizes können Ganzzahlen, Fensternamen oder das Schlüsselwort *all* sein. Bei *all* gelten die Optionen für alle Spalten, die derzeit von Inhaltsfenstern belegt sind. Bei einem Fensternamen muss dieses Fenster ein Inhalt dieses Containers sein; die Optionen gelten für alle Spalten, die derzeit von diesem Inhalt belegt sind. Die Option **-minsize** legt die minimale Größe in Bildschirmeinheiten fest, die für diese Spalte zulässig ist. Die Option **-weight** (Ganzzahl) legt das relative Gewicht für die Verteilung zusätzlichen Platzes auf die Spalten fest. Ein Gewicht von Null (0) bedeutet, dass die Spalte nicht von ihrer angeforderten Größe abweicht. Eine Spalte mit Gewicht zwei wächst bei zusätzlichem Platz doppelt so schnell wie eine Spalte mit Gewicht eins. Die Option **-uniform**: Ist ein nicht-leerer Wert angegeben, wird die Spalte in eine *uniforme Gruppe* mit anderen Spalten gleichen **-uniform**-Werts eingeordnet. Der Platz für Spalten einer uniformen Gruppe wird so verteilt, dass ihre Größen stets im strengen Verhältnis zu ihren **-weight**-Werten stehen. Siehe **DER GRID-ALGORITHMUS** unten. Die Option **-pad** gibt die Anzahl Bildschirmeinheiten an, die zum größten Fenster hinzugefügt werden, das vollständig in dieser Spalte liegt, wenn der Grid-Geometrie-Manager eine Größe vom Container-Fenster anfordert. Wird nur eine Option ohne Wert angegeben, wird der aktuelle Wert dieser Option zurückgegeben. Wird nur Container-Fenster und Index angegeben, werden alle aktuellen Einstellungen in einer Liste von „*-option value*“-Paaren zurückgegeben.

**grid configure** *window* ?*window ...*? ?*options*?
: Die Argumente bestehen aus den Namen eines oder mehrerer Inhaltsfenster gefolgt von Argumentpaaren, die festlegen, wie der Inhalt verwaltet wird. Statt eines Fensternamens können die Zeichen **-**, **x** und **^** angegeben werden, um die Standardposition eines *window* zu ändern (siehe Abschnitt **RELATIVE PLATZIERUNG** unten). Folgende Optionen werden unterstützt:

**-column** *n*
: Das Fenster wird so eingefügt, dass es die *n*-te Spalte im Raster belegt. Spaltennummern beginnen bei 0. Fehlt diese Option, wird das Fenster direkt rechts vom zuvor in diesem **grid**-Aufruf angegebenen Fenster platziert, oder in Spalte „0“, wenn es das erste Fenster ist. Für jedes **x**, das unmittelbar dem *window* vorausgeht, wird die Spaltenposition um eins erhöht. **x** steht damit für eine leere Spalte in dieser Zeile des Rasters.

**-columnspan** *n*
: Das Fenster belegt *n* Spalten im Raster. Standard ist eine Spalte, außer der Fenstername wird von **-** gefolgt; dann wird der Spaltenumfang für jedes unmittelbar folgende **-** um eins erhöht.

**-in** *container*
: Die Fenster werden im Container-Fenster *container* eingefügt. Standard ist das Elternfenster des ersten Fensters.

**-ipadx** *amount*
: *amount* legt fest, wie viel horizontaler innerer Abstand auf jeder Seite des Inhalts bleibt. Dieser Abstand wird innerhalb des Inhaltsrahmens hinzugefügt. *amount* muss eine gültige Bildschirmdistanz sein, z. B. **2** oder **.5c**. Standard ist 0.

**-ipady** *amount*
: *amount* legt fest, wie viel vertikaler innerer Abstand oben und unten am Inhalt bleibt. Dieser Abstand wird innerhalb des Inhaltsrahmens hinzugefügt. *amount* hat standardmäßig 0.

**-padx** *amount*
: *amount* legt den horizontalen äußeren Abstand auf jeder Seite des Inhalts in Bildschirmeinheiten fest. *Amount* kann eine Liste aus zwei Werten sein, um Abstand links und rechts getrennt anzugeben. Standard ist 0. Dieser Abstand liegt außerhalb des Inhaltsrahmens.

**-pady** *amount*
: *amount* legt den vertikalen äußeren Abstand oben und unten am Inhalt in Bildschirmeinheiten fest. *Amount* kann eine Liste aus zwei Werten sein, um Abstand oben und unten getrennt anzugeben. Standard ist 0. Dieser Abstand liegt außerhalb des Inhaltsrahmens.

**-row** *n*
: Der Inhalt wird so eingefügt, dass er die *n*-te Zeile im Raster belegt. Zeilennummern beginnen bei 0. Fehlt diese Option, wird der Inhalt in derselben Zeile wie der zuvor in diesem **grid**-Aufruf angegebene Inhalt platziert, oder in der nächsten Zeile unter der höchsten belegten Zeile, wenn dies der erste Inhalt ist.

**-rowspan** *n*
: Der Inhalt belegt *n* Zeilen im Raster. Standard ist eine Zeile. Enthält der nächste **grid**-Befehl **^**-Zeichen statt *content*, die mit den Spalten dieses *content* ausgerichtet sind, wird der **rowspan** dieses *content* um eins verlängert.

**-sticky** *style*
: Ist die Zelle eines Inhalts größer als seine angeforderten Abmessungen, kann diese Option den Inhalt in der Zelle positionieren (oder strecken). *Style* ist eine Zeichenkette mit null oder mehr der Zeichen **n**, **s**, **e** oder **w**. Die Zeichenkette darf optional Leerzeichen oder Kommas enthalten; sie werden ignoriert. Jeder Buchstabe bezeichnet eine Seite (Norden, Süden, Osten oder Westen), an die der Inhalt „klebt“. Sind sowohl **n** als auch **s** (oder **e** und **w**) angegeben, wird der Inhalt gestreckt, um die gesamte Höhe (oder Breite) seiner Zelle zu füllen. Die Option **-sticky** umfasst die Kombination aus **-anchor** und **-fill** von **pack**. Standard ist „“, wodurch der Inhalt in seiner Zelle zentriert in der angeforderten Größe erscheint. Wird Inhalt bereits vom Geometrie-Manager verwaltet, behalten nicht angegebene Optionen ihre bisherigen Werte statt Standardwerte zu erhalten.


**grid content** *window* ?*-option value*?
: Ohne Optionen wird eine Liste aller Inhalte in *window* zurückgegeben, zuletzt verwaltete zuerst. *Option* kann **-row** oder **-column** sein; dann werden nur die Inhalte in der durch *value* angegebenen Zeile (bzw. Spalte) zurückgegeben.

**grid forget** *window* ?*window ...*?
: Entfernt jedes *window* aus dem Raster seines Containers und entmappt die Fenster. Der Inhalt wird nicht mehr vom Grid-Geometrie-Manager verwaltet. Die Konfigurationsoptionen für dieses Fenster werden vergessen, sodass bei erneuter Verwaltung durch den Grid-Geometrie-Manager die anfänglichen Standardwerte gelten.

::: {.info -version="TIP 518"}
Wird das letzte verwaltete Inhaltsfenster des Containers nicht mehr verwaltet, wird außerdem das virtuelle Ereignis **<\<NoManagedChild>>** an den Container gesendet; der Container kann sich daraufhin selbst neu dimensionieren (oder anderweitig reagieren).
:::


**grid info** *window*
: Gibt eine Liste zurück, deren Elemente den aktuellen Konfigurationszustand des Inhalts *window* in derselben Option-Wert-Form darstellen, die an **grid configure** übergeben werden könnte. Die ersten beiden Elemente sind „**-in** *container*“, wobei *container* das Container-Fenster des Fensters ist.

**grid location** *window x y*
: Bei *x*- und *y*-Werten in Bildschirmeinheiten relativ zum Container-Fenster werden Spalten- und Zeilennummer an dieser Position zurückgegeben. Liegt die Position oberhalb oder links vom Raster, wird **-1** zurückgegeben.

**grid propagate** *window* ?*boolean*?
: Hat *boolean* einen wahren booleschen Wert wie **1** oder **on**, ist Propagation für *window* aktiviert; *window* muss ein Fenstername sein (siehe **GEOMETRIE-PROPAGATION** unten). Hat *boolean* einen falschen booleschen Wert, ist Propagation für *window* deaktiviert. In beiden Fällen wird ein leerer String zurückgegeben. Fehlt *boolean*, gibt der Befehl **0** oder **1** zurück, je nachdem, ob Propagation für *window* derzeit aktiv ist.
    Propagation ist standardmäßig aktiviert.

**grid rowconfigure** *window index* ?*-option value...*?
: Abfrage oder Festlegung der Zeileneigenschaften der Zeile *index* des Geometrie-Containers *window*. Gültige Optionen sind **-minsize**, **-weight**, **-uniform** und **-pad**. Wenn eine oder mehrere Optionen angegeben werden, kann *index* als Liste von Zeilenindizes angegeben werden, auf die die Konfigurationsoptionen wirken. Indizes können Ganzzahlen, Fensternamen oder das Schlüsselwort *all* sein. Bei *all* gelten die Optionen für alle Zeilen, die derzeit von Inhaltsfenstern belegt sind. Bei einem Fensternamen muss dieses Fenster ein Inhaltsfenster dieses Containers sein; die Optionen gelten für alle Zeilen, die derzeit vom Container-Fenster belegt sind. Die Option **-minsize** legt die minimale Größe in Bildschirmeinheiten fest, die für diese Zeile zulässig ist. Die Option **-weight** (Ganzzahl) legt das relative Gewicht für die Verteilung zusätzlichen Platzes auf die Zeilen fest. Ein Gewicht von Null (0) bedeutet, dass die Zeile nicht von ihrer angeforderten Größe abweicht. Eine Zeile mit Gewicht zwei wächst bei zusätzlichem Platz doppelt so schnell wie eine Zeile mit Gewicht eins. Die Option **-uniform**: Ist ein nicht-leerer Wert angegeben, wird die Zeile in eine *uniforme Gruppe* mit anderen Zeilen gleichen **-uniform**-Werts eingeordnet. Der Platz für Zeilen einer uniformen Gruppe wird so verteilt, dass ihre Größen stets im strengen Verhältnis zu ihren **-weight**-Werten stehen. Siehe **DER GRID-ALGORITHMUS** unten. Die Option **-pad** gibt die Anzahl Bildschirmeinheiten an, die zum größten Fenster hinzugefügt werden, das vollständig in dieser Zeile liegt, wenn der Grid-Geometrie-Manager eine Größe vom Container-Fenster anfordert. Wird nur eine Option ohne Wert angegeben, wird der aktuelle Wert dieser Option zurückgegeben. Wird nur Container-Fenster und Index angegeben, werden alle aktuellen Einstellungen in einer Liste von „-option value“-Paaren zurückgegeben.

**grid remove** *window* ?*window ...*?
: Entfernt jedes *window* aus dem Raster seines Containers und entmappt die Fenster. Der Inhalt wird nicht mehr vom Grid-Geometrie-Manager verwaltet. Die Konfigurationsoptionen für dieses Fenster bleiben jedoch gespeichert, sodass bei erneuter Verwaltung die bisherigen Werte erhalten bleiben.

::: {.info -version="TIP 518"}
Wird das letzte verwaltete Inhaltsfenster des Containers nicht mehr verwaltet, wird außerdem das virtuelle Ereignis **<\<NoManagedChild>>** an den Container gesendet; der Container kann sich daraufhin selbst neu dimensionieren (oder anderweitig reagieren).
:::


**grid size** *container*
: Gibt die Rastergröße (zuerst Spalten, dann Zeilen) für *container* zurück. Die Größe ergibt sich entweder aus dem *content*, der die größte Zeile oder Spalte belegt, oder aus der größten Spalte oder Zeile mit nicht-null **-minsize**, **-weight** oder **-pad**.

**grid slaves** *window* ?*-option value*?
: Synonym für **grid content** *window* ?*-option value*?.


# RELATIVE PLATZIERUNG

Der Befehl **grid** bietet begrenzte Möglichkeiten, Layouts zu erzeugen, ohne für jeden Inhalt Zeilen- und Spalteninformationen anzugeben. Inhalte können so umgeordnet, hinzugefügt oder entfernt werden, ohne Zeilen und Spalten explizit festzulegen. Fehlen Spalten- oder Zeilenangaben für einen *content*, werden beim Verwalten Standardwerte für **-column**, **-row**, **-columnspan** und **-rowspan** gewählt. Die Werte hängen vom aktuellen Rasterlayout, der Position des *content* relativ zu anderen *content*s im selben **grid**-Befehl und vom Vorkommen der Zeichen **-**, **x** und **^** an Stellen ab, an denen normalerweise *content*-Namen erwartet werden.

**-**
: Erhöht den **-columnspan** des Inhalts links davon. Mehrere **-** hintereinander erhöhen die Spaltenanzahl schrittweise. Ein **-** darf nicht auf **^** oder **x** folgen und nicht das erste *content*-Argument von **grid configure** sein.

**x**
: Lässt eine leere Spalte zwischen dem Inhalt links und dem Inhalt rechts.

**^**
: Verlängert den **-rowspan** des Inhalts über den **^** im Raster. Die Anzahl der **^** in einer Zeile muss der Spaltenanzahl entsprechen, die der Inhalt darüber überspannt.


# DER GRID-ALGORITHMUS

Der Grid-Geometrie-Manager legt seinen Inhalt in drei Schritten aus. Im ersten Schritt wird die Mindestgröße berechnet, die alle Inhalte benötigen; ist Propagation eingeschaltet, wird das Container-Fenster gebeten, diese Größe anzunehmen. Im zweiten Schritt wird die angeforderte Größe mit der tatsächlichen Größe des Containers verglichen. Weichen sie ab, wird dem Layout bei Bedarf Platz hinzugefügt oder entnommen. Im letzten Schritt wird jeder Inhalt in seine Zeile(n) und Spalte(n) gemäß der *sticky*-Einstellung gesetzt.

Zur Berechnung der Mindestgröße eines Layouts betrachtet der Grid-Geometrie-Manager zuerst allen Inhalt mit **-columnspan** und **-rowspan** gleich eins und ermittelt die nominale Größe jeder Zeile oder Spalte als entweder *minsize* für diese Zeile oder Spalte oder Summe aus *pad* und Größe des größten Inhalts — je nachdem, was größer ist. Danach passen sich Zeilen oder Spalten in jeder uniformen Gruppe aneinander an. Anschließend werden Inhalte mit Zeilen- oder Spaltenumfang größer als eins geprüft. Muss eine Gruppe von Zeilen oder Spalten vergrößert werden, um diese Inhalte unterzubringen, wird jeder Zeile oder Spalte der Gruppe zusätzlicher Platz gemäß ihrem *weight* zugewiesen. Hat eine Gruppe überall Gewicht null, wird der zusätzliche Platz gleichmäßig verteilt.

Gehören mehrere Zeilen oder Spalten einer uniformen Gruppe an, wird der zugewiesene Platz stets im Verhältnis ihrer Gewichte verteilt. (Gewicht null gilt als 1.) Eine Zeile oder Spalte mit **-weight 1 -uniform a** hat also dieselbe Größe wie jede andere mit **-weight 1 -uniform a**. Mit **-weight 2 -uniform b** ist sie genau doppelt so groß wie mit **-weight 1 -uniform b**.

Technisch hat jede Zeile oder Spalte der Gruppe eine Größe *k*·*weight* für eine Konstante *k*. *k* wird so gewählt, dass keine Zeile oder Spalte unter ihre Mindestgröße fällt. Haben alle Zeilen oder Spalten einer Gruppe dasselbe Gewicht, hat jede dieselbe Größe wie die größte Zeile oder Spalte der Gruppe.

Ist der Container größer als das angeforderte Layout, wird zusätzlicher Platz gemäß Zeilen- und Spaltengewichten verteilt. Sind alle Gewichte null, wird das Layout gemäß dem *anchor*-Wert im Container platziert. Ist der Container kleiner als das angeforderte Layout, wird Platz von Spalten und Zeilen gemäß ihren Gewichten entnommen. Sobald eine Spalte oder Zeile ihre *minsize* erreicht, gilt ihr Gewicht als null. Muss mehr Platz entfernt werden als zulässig (wenn alle Zeilen oder Spalten bei Mindestgröße sind), wird das Layout platziert und gemäß *anchor* beschnitten.

# GEOMETRIE-PROPAGATION

Der Grid-Geometrie-Manager berechnet normalerweise, wie groß ein Container sein muss, um den Bedarf seines Inhalts genau zu decken, und setzt angeforderte Breite und Höhe des Containers auf diese Maße. So propagieren Geometrieinformationen in der Fensterhierarchie bis zum Toplevel, sodass der gesamte Teilbaum sich den Blattfenstern anpasst. Mit **grid propagate** kann Propagation für einen oder mehrere Container jedoch abgeschaltet werden. Ist Propagation deaktiviert, setzt **grid** die angeforderte Breite und Höhe des Container-Fensters nicht. Das ist nützlich, wenn ein Container eine von Ihnen festgelegte feste Größe haben soll.

# EINSCHRÄNKUNGEN FÜR CONTAINER-FENSTER

Der Container jedes Inhalts muss entweder das Elternelement des Inhalts sein (Standard) oder ein Nachkomme des Elternelements. Diese Einschränkung stellt sicher, dass der Inhalt über jeden sichtbaren Teil seines Containers gelegt werden kann, ohne vom Elternfenster abgeschnitten zu werden. Außerdem müssen alle Inhalte eines **grid**-Aufrufs denselben Container haben.

# STACKING-REIHENFOLGE

Ist der Container eines Inhalts nicht dessen Elternelement, muss der Inhalt in der Stacking-Reihenfolge über dem Container liegen. Andernfalls verdeckt der Container den Inhalt, und es wirkt, als wäre der Inhalt nicht korrekt verwaltet. Am einfachsten stellt man das sicher, indem man zuerst das Container-Fenster erzeugt: das zuletzt erzeugte Fenster liegt oben in der Stacking-Reihenfolge.

# DANKSAGUNGEN

Der Befehl **grid** basiert auf Ideen des Geometrie-Managers *GridBag* von Doug Stein und des Geometrie-Managers **blt_table** von George Howlett.

# BEISPIELE

Ein Toplevel-Fenster mit Text-Widget und zwei Scrollleisten:

```
# Widgets erzeugen
toplevel .t
text .t.txt -wrap none -xscroll {.t.h set} -yscroll {.t.v set}
scrollbar .t.v -orient vertical   -command {.t.txt yview}
scrollbar .t.h -orient horizontal -command {.t.txt xview}

# Anordnen
grid .t.txt .t.v -sticky nsew
grid .t.h        -sticky nsew

# Text-Widget soll den zusätzlichen Platz einnehmen
grid rowconfigure    .t .t.txt -weight 1
grid columnconfigure .t .t.txt -weight 1
```

Drei Widgets gleicher Breite trotz unterschiedlicher „natürlicher“ Breite:

```
button .b -text "Foo"
entry .e -textvariable foo ; set foo "Hello World!"
label .l -text "This is a fairly long piece of text"

grid .b .e .l -sticky ew
grid columnconfigure . "all" -uniform allTheSame
```
