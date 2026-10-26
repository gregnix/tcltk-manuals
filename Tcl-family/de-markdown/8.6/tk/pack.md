---
CommandName: pack
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - grid(n)
 - place(n)
Keywords:
 - geometry manager
 - location
 - packer
 - parcel
 - propagation
 - size
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

pack - Geometrie-Manager, der entlang der Ränder des Hohlraums packt

# ÜBERSICHT

::: {.synopsis} :::
[pack]{.cmd} [option]{.arg} [arg]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **pack** dient der Kommunikation mit dem Packer, einem Geometrie-Manager, der die Kinder eines Eltern-Widgets anordnet, indem er sie der Reihe nach entlang der Ränder des Eltern-Widgets packt. Der Befehl **pack** kann je nach dem *option*-Argument mehrere Formen annehmen:

**pack** *window* ?*window ...*? ?*options*?
: Wenn das erste Argument von **pack** ein Fenstername ist (ein Wert, der mit „.“ beginnt), wird der Befehl auf dieselbe Weise verarbeitet wie **pack configure**.

**pack configure** *window* ?*window ...*? ?*options*?
: Die Argumente bestehen aus den Namen eines oder mehrerer Inhaltsfenster, gefolgt von Argumentpaaren, die festlegen, wie der Inhalt verwaltet wird. Details zur Verwendung der Optionen durch den Packer finden Sie unter **DER PACKER-ALGORITHMUS** weiter unten. Folgende Optionen werden unterstützt:

**-after** *other*
: *Other* muss der Name eines anderen Fensters sein. Dessen Container wird als Container für den Inhalt verwendet, und der Inhalt wird in der Packreihenfolge unmittelbar nach *other* eingefügt.

**-anchor** *anchor*
: *Anchor* muss eine gültige Ankerposition sein, etwa **n** oder **sw**; sie legt fest, wo jedes Inhaltsfenster in seinem Parcel positioniert wird. Standard ist **center**.

**-before** *other*
: *Other* muss der Name eines anderen Fensters sein. Dessen Container wird als Container für den Inhalt verwendet, und der Inhalt wird in der Packreihenfolge unmittelbar vor *other* eingefügt.

**-expand** *boolean*
: Legt fest, ob der Inhalt erweitert werden soll, um zusätzlichen Platz im Container zu nutzen. *Boolean* kann jeden gültigen booleschen Wert haben, etwa **1** oder **no**. Standard ist 0.

**-fill** *style*
: Ist das Parcel eines Inhalts größer als dessen angeforderte Abmessungen, kann diese Option verwendet werden, um den Inhalt zu strecken. *Style* muss einen der folgenden Werte haben:

**none**
: Dem Inhalt werden seine angeforderten Abmessungen plus jeder mit **-ipadx** oder **-ipady** angeforderten internen Polsterung gegeben. Dies ist der Standardwert.

**x**
: Den Inhalt horizontal strecken, um die gesamte Breite seines Parcels zu füllen (äußere Polsterung gemäß **-padx** bleibt ausgenommen).

**y**
: Den Inhalt vertikal strecken, um die gesamte Höhe seines Parcels zu füllen (äußere Polsterung gemäß **-pady** bleibt ausgenommen).

**both**
: Den Inhalt sowohl horizontal als auch vertikal strecken.


**-in** *container*
: Das Fenster am Ende der Packreihenfolge für den durch *container* angegebenen Container einfügen.

**-ipadx** *amount*
: *Amount* legt fest, wie viel horizontale interne Polsterung auf jeder Seite des Inhalts verbleiben soll. *Amount* muss eine gültige Bildschirmabstandseinheit sein, etwa **2** oder **.5c**. Standard ist 0.

**-ipady** *amount*
: *Amount* legt fest, wie viel vertikale interne Polsterung auf jeder Seite des Inhalts verbleiben soll. *Amount* hat standardmäßig den Wert 0.

**-padx** *amount*
: *Amount* legt fest, wie viel horizontale äußere Polsterung auf jeder Seite des Inhalts verbleiben soll. *Amount* kann eine Liste aus zwei Werten sein, um Polsterung links und rechts getrennt anzugeben. Standard ist 0.

**-pady** *amount*
: *Amount* legt fest, wie viel vertikale äußere Polsterung auf jeder Seite des Inhalts verbleiben soll. *Amount* kann eine Liste aus zwei Werten sein, um Polsterung oben und unten getrennt anzugeben. Standard ist 0.

**-side** *side*
: Legt fest, an welcher Seite des Containers der Inhalt gepackt wird. Muss **left**, **right**, **top** oder **bottom** sein. Standard ist **top**. Wenn keine Option **-in**, **-after** oder **-before** angegeben ist, wird jedes Inhaltsfenster am Ende der Packliste seines Eltern-Elements eingefügt, sofern es nicht bereits vom Packer verwaltet wird (dann bleibt es an seiner Position). Wird eine dieser Optionen angegeben, werden alle Inhalte am angegebenen Punkt eingefügt. Sind einige Inhalte bereits vom Geometrie-Manager verwaltet, behalten nicht angegebene Optionen ihre bisherigen Werte statt Standardwerte zu erhalten.

**pack forget** *window* ?*window ...*?
: Entfernt jedes der *window* aus der Packreihenfolge seines Containers und entmappt die Fenster. Der Inhalt wird nicht mehr vom Packer verwaltet.

**pack info** *window*
: Gibt eine Liste zurück, deren Elemente den aktuellen Konfigurationszustand des durch *window* angegebenen Fensters in derselben Option-Wert-Form enthalten, die auch an **pack configure** übergeben werden könnte. Die ersten beiden Elemente der Liste sind „**-in** *container*“, wobei *container* der Container des Fensters ist.

**pack propagate** *container* ?*boolean*?
: Hat *boolean* einen wahren booleschen Wert wie **1** oder **on**, ist die Propagation für *container* aktiviert; *container* muss ein Fenstername sein (siehe **GEOMETRIE-PROPAGATION** weiter unten). Hat *boolean* einen falschen booleschen Wert, ist die Propagation für *container* deaktiviert. In beiden Fällen wird ein leerer String zurückgegeben. Wird *boolean* weggelassen, gibt der Befehl **0** oder **1** zurück, je nachdem, ob Propagation für *container* derzeit aktiviert ist. Propagation ist standardmäßig aktiviert.

**pack slaves** *window*
: Gibt eine Liste aller Inhaltsfenster in der Packreihenfolge für *window* zurück. Die Reihenfolge der Inhaltsfenster in der Liste entspricht ihrer Reihenfolge in der Packreihenfolge. Hat *window* keinen Inhalt, wird ein leerer String zurückgegeben.

**pack content** *window*
: Synonym für **pack slaves** *window*.


# DER PACKER-ALGORITHMUS

Für jeden Container führt der Packer eine geordnete Liste von Inhaltsfenstern, die *Packliste* genannt wird. Die Konfigurationsoptionen **-in**, **-after** und **-before** legen den Container für jeden Inhalt und dessen Position in der Packliste fest. Wird für einen Inhalt keine dieser Optionen angegeben, wird der Inhalt am Ende der Packliste seines Eltern-Elements hinzugefügt.

Der Packer ordnet die Inhaltsfenster eines Containers an, indem er die Packliste der Reihe nach durchläuft. Wenn er jeden Inhalt verarbeitet, ist innerhalb des Containers noch ein rechteckiger Bereich unbelegt. Dieser Bereich heißt *Hohlraum*; für den ersten Inhalt ist er die gesamte Fläche des Containers.

Für jeden Inhalt führt der Packer folgende Schritte aus:

1. Der Packer weist dem Inhalt ein rechteckiges *Parcel* entlang der durch die Option **-side** des Inhalts angegebenen Seite des Hohlraums zu. Ist die Seite oben oder unten, ist die Breite des Parcels die Breite des Hohlraums und seine Höhe die angeforderte Höhe des Inhalts plus die Optionen **-ipady** und **-pady**. Bei der Seite links oder rechts ist die Höhe des Parcels die Höhe des Hohlraums und die Breite die angeforderte Breite des Inhalts plus **-ipadx** und **-padx**. Das Parcel kann wegen der Option **-expand** weiter vergrößert werden (siehe **ERWEITERUNG** weiter unten).

2. Der Packer wählt die Abmessungen des Inhalts. Die Breite ist normalerweise die angeforderte Breite des Inhalts plus das Doppelte seiner Option **-ipadx**, die Höhe normalerweise die angeforderte Höhe plus das Doppelte von **-ipady**. Ist die Option **-fill** jedoch **x** oder **both**, wird die Breite des Inhalts so erweitert, dass sie die Breite des Parcels abzüglich des Doppelten von **-padx** füllt. Ist **-fill** **y** oder **both**, wird die Höhe des Inhalts so erweitert, dass sie die Höhe des Parcels abzüglich des Doppelten von **-pady** füllt.

3. Der Packer positioniert den Inhalt über seinem Parcel. Ist der Inhalt kleiner als das Parcel, legt die Option **-anchor** fest, wo im Parcel der Inhalt platziert wird. Sind **-padx** oder **-pady** ungleich null, bleibt stets die angegebene äußere Polsterung zwischen Inhalt und Parcel-Rändern.


Sobald ein Inhalt gepackt ist, wird die Fläche seines Parcels vom Hohlraum abgezogen, sodass ein kleinerer rechteckiger Hohlraum für den nächsten Inhalt bleibt. Nutzt ein Inhalt sein Parcel nicht vollständig, wird der ungenutzte Platz nicht von nachfolgenden Inhalten verwendet. Wird der Hohlraum zu klein für die Anforderungen eines Inhalts, erhält der Inhalt den verbleibenden Platz im Hohlraum. Schrumpft der Hohlraum auf die Größe null, werden alle verbleibenden Inhalte der Packliste vom Bildschirm entmappt, bis das Container-Fenster wieder groß genug ist.

## ERWEITERUNG

Ist ein Container-Fenster so groß, dass nach dem Packen aller Inhalte noch zusätzlicher Platz übrig bleibt, wird dieser Platz gleichmäßig auf alle Inhalte verteilt, für die die Option **-expand** gesetzt ist. Zusätzlicher horizontaler Platz wird auf erweiterbare Inhalte mit **-side** **left** oder **right** verteilt, zusätzlicher vertikaler Platz auf erweiterbare Inhalte mit **-side** **top** oder **bottom**.

## GEOMETRIE-PROPAGATION

Der Packer berechnet normalerweise, wie groß ein Container sein muss, um genau den Bedarf seiner Inhalte zu decken, und setzt die angeforderte Breite und Höhe des Containers auf diese Werte. Dadurch propagieren Geometrieinformationen in der Fensterhierarchie bis zum Top-Level-Fenster, sodass sich der gesamte Unterbaum an die Blattfenster anpasst. Mit **pack propagate** kann die Propagation für einen oder mehrere Container jedoch abgeschaltet werden. Ist Propagation deaktiviert, setzt der Packer die angeforderte Breite und Höhe des Containers nicht. Das ist nützlich, wenn ein Container-Fenster etwa eine von Ihnen festgelegte feste Größe haben soll.

# EINSCHRÄNKUNGEN FÜR CONTAINER-FENSTER

Der Container jedes Inhalts muss entweder das Eltern-Element des Inhalts sein (Standard) oder ein Nachfahre des Eltern-Elements des Inhalts. Diese Einschränkung stellt sicher, dass der Inhalt über jeden sichtbaren Teil seines Containers gelegt werden kann, ohne vom Eltern-Element abgeschnitten zu werden.

# PACKREIHENFOLGE

Ist der Container eines Inhalts nicht dessen Eltern-Element, muss der Inhalt in der Stapelreihenfolge über dem Container liegen. Andernfalls verdeckt der Container den Inhalt, und es wirkt, als wäre der Inhalt nicht korrekt gepackt. Am einfachsten erreichen Sie das, indem Sie zuerst das Container-Fenster erzeugen: das zuletzt erzeugte Fenster liegt oben in der Stapelreihenfolge. Alternativ können **raise** und **lower** die Stapelreihenfolge von Container oder Inhalt ändern.

# BEISPIELE

```
# Widgets erzeugen
label .t \-text "Dieses Widget ist oben"    \-bg red
label .b \-text "Dieses Widget ist unten" \-bg green
label .l \-text "Linke\nSeite"
label .r \-text "Rechte\nSeite"
text .mid
\&.mid insert end "Dieses Layout entspricht Javas BorderLayout"
# Anordnen
pack .t   \-side top    \-fill x
pack .b   \-side bottom \-fill x
pack .l   \-side left   \-fill y
pack .r   \-side right  \-fill y
pack .mid \-expand 1    \-fill both
```
