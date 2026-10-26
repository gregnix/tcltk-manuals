---
CommandName: canvas::edit::polyline
ManualSection: n
Version: 0.2
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - editing
 - polyline
Copyright:
---

# NAME

canvas::edit::polyline – Bearbeiten einer Polylinie auf einem Canvas

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::edit::points]{.lit} [0.1]{.optlit} 
[package]{.cmd} [require]{.sub} [canvas::edit::polyline]{.lit} [0.2]{.optlit} 
[::canvas::edit]{.cmd} [polyline]{.sub} [objectName]{.arg} [canvas]{.arg} [options...]{.arg} 
[objectName]{.cmd} [destroy]{.sub} 
[objectName]{.cmd} [enable]{.sub} 
[objectName]{.cmd} [disable]{.sub} 
[objectName]{.cmd} [active]{.sub} 
[objectName]{.cmd} [add]{.sub} [x]{.arg} [y]{.arg} 
[objectName]{.cmd} [clear]{.sub} 
[activeCmd]{.cmd} [editorObj]{.arg} [id]{.arg} 
[createCmd]{.cmd} [canvas]{.arg} [x]{.arg} [y]{.arg} 
[dataCmd]{.cmd} [editorObj]{.arg} [coordinates]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine Klasse bereit, deren Instanzen die Bearbeitung einer einzelnen Polylinie (oder -gon) auf einem Canvas übernehmen. Instanzen können hinsichtlich der Darstellung der Markierungen, die die Eckpunkte der Linie kennzeichnen, konfiguriert werden; ebenso kann festgelegt werden, ob die Linie geschlossen sein soll oder nicht, und ob eine geschlossene Linie konvex sein muss oder nicht. Beachten Sie, dass Instanzen die bearbeitete Polylinie nicht selbst speichern, sondern diese Aufgabe an ein konfigurierbares Objekt weiterleiten.

# INTERAKTION

Der Polylinien-Editor verwendet intern eine Instanz des Pakets **canvas::edit::points** und übernimmt alle damit verbundenen Optionen und Verhaltensweisen. Die Optionen zur Farbe werden zusätzlich auf das Linienelement dieses Editors angewendet.

Darüber hinaus bietet es zwei Optionen zur Konfiguration des Bearbeitungsmodus sowie eine Option zur Anpassung des Linien-/Polygon-Elements, das zum Zeichnen der Linie durch die Punkte verwendet wird.

Der Hauptbearbeitungsmodus wird durch die Option **-closed** gesteuert, die zwischen *Linie* (d. h. offen) und *Polygon* (d. h. geschlossen) unterscheidet. Die Standardeinstellung ist der Linien-/offene Modus.

Im Modus „Polygon/geschlossen“ legt die Option **-convex** fest, ob der Editor die Konvexität des Polygons erzwingt oder nicht. Standardmäßig wird die Konvexität nicht erzwungen.

Die Option **-line-config** ermöglicht eine grundlegende Anpassung des Linien-/Polygon-Elements. Hinweis: Sie kann die vererbten Farboptionen nicht überschreiben.

# API FÜR KLASSEN

**::canvas::edit** **polyline** *objectName* *canvas* *options*...
: Dieser Befehl, der Klassenbefehl, erstellt und konfiguriert eine neue Instanz eines Polylinien-Editors mit dem Namen *objectName*. Die Instanz wird mit dem angegebenen *canvas*-Widget verbunden. Das Ergebnis des Befehls ist der vollqualifizierte Name der Instanz. Die hier zulässigen Optionen und ihre Werte werden im Abschnitt **OPTIONEN** erläutert.


# INSTANZ-API

Instanzen der Polylinien-Editoren stellen die folgende API bereit:

**objectName** **destroy**
: Diese Methode löscht den Polylinien-Editor und gibt alle seine internen Ressourcen frei. Hinweis: Durch diesen Vorgang werden weder die vom Editor auf dem zugehörigen Canvas verwalteten Elemente noch der Canvas selbst gelöscht. Das Ergebnis der Methode ist eine leere Zeichenkette.

**objectName** **enable**
: Diese Methode aktiviert die Bearbeitung der Polylinie auf dem Canvas. Dies ist die Standardeinstellung nach der Erstellung der Instanz. Ein Aufruf wird ignoriert, wenn der Editor bereits aktiv ist. Das Ergebnis der Methode ist eine leere Zeichenkette. Die komplementäre Methode lautet **disable**. Die Abfragemethode für den aktuellen Status lautet **active**.

**objectName** **disable**
: Diese Methode deaktiviert die Bearbeitung der Polylinie auf dem Canvas. Ein Aufruf wird ignoriert, wenn der Editor bereits deaktiviert ist. Das Ergebnis der Methode ist eine leere Zeichenkette. Die komplementäre Methode lautet **enable**. Die Abfragemethode für den aktuellen Status lautet **active**.

**objectName** **active**
: Diese Methode fragt den Status des Editors ab. Das Ergebnis der Methode ist ein boolescher Wert: **true**, wenn der Editor aktiv ist, und andernfalls **false**, d. h. deaktiviert. Die Methoden zum Ändern des Status lauten **enable** und **disable**.

**objectName** **add** *x* *y*
: Diese Methode fügt der Linie programmgesteuert einen Eckpunkt an der festgelegten Stelle hinzu. Das Ergebnis der Methode ist eine leere Zeichenkette. Beachten Sie, dass diese Methode die gesamte Reihe von Rückruffunktionen durchläuft, die aufgerufen werden, wenn der Benutzer interaktiv einen Eckpunkt erstellt, d. h. **-create-cmd** und, was noch wichtiger ist, **-data-cmd**. Es gibt jedoch einen wichtigen Unterschied: Der neue Scheitelpunkt wird stets am Ende der Linie hinzugefügt, während bei der interaktiven Erstellung Heuristiken zum Einsatz kommen, um ihn an einer geeigneten Stelle in die Linie einzufügen. Dies ist die Methode, mit der die Scheitelpunkte einer bereits vorhandenen Linie in eine Editor-Instanz geladen werden.

**objectName** **clear**
: Diese Methode entfernt programmgesteuert alle Eckpunkte aus dem Editor, wodurch im Wesentlichen die ganze Linie gelöscht wird. Das Ergebnis der Methode ist eine leere Zeichenkette. Hinweis: Diese Methode durchläuft dieselben Rückruffunktionen, die auch dann aufgerufen werden, wenn der Benutzer einen Eckpunkt interaktiv entfernt, d. h. **-data-cmd**.


# OPTIONEN

Der Befehl „class“ akzeptiert die folgenden Optionen

**-active-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn die Maus in die Zeile oder an einen von der Instanz verwalteten Punkt ein- bzw. aus diesem herausfährt. Wird kein Wert angegeben, wird standardmäßig ein leerer Befehl verwendet, der keine Aktion ausführt. Die Signatur dieses Befehlspräfixes lautet


**activeCmd** *editorObj* *id*
: Die *id* identifiziert das eingegebene Objekt. Eine leere *id* bedeutet, dass das zuletzt eingegebene Objekt beibehalten wurde. Der Wert **line** gibt an, dass die Linie eingegeben wurde. Ein numerischer Wert **N** bedeutet, dass der **N**. Scheitelpunkt der Linie eingegeben wurde, gezählt ab **0**. Das Ergebnis dieser Methode wird ignoriert.


**-add-remove-point** *eventspec*
: Der Wert dieser Option ist eine Ereignisspezifikation (ohne Klammerwinkel), die festlegt, welches Ereignis das Hinzufügen bzw. Entfernen eines Punktes auslöst. Diese Option kann nur bei der Erstellung festgelegt werden. In der Standardeinstellung werden für das Hinzufügen und Entfernen von Punkten unterschiedliche Ereignisse verwendet, nämlich **ButtonPress-1** bzw. **ButtonPress-2**. Bei Verwendung dieser Option wird für beide Vorgänge dasselbe Ereignis verwendet. Dies stellt kein Problem dar, da das Hinzufügen als canvas-globales Ereignis gebunden ist, während das Entfernen an die jeweiligen Canvas-Elemente gebunden ist.

**-closed** *boolean*
: Der Wert dieser Option ist ein boolescher Schalter, der angibt, ob die bearbeitete Polylinie geschlossen ist, d. h. eine Schleife bildet, oder nicht. *Hinweis*: Eine korrekte Schleife erfordert mindestens drei Punkte. Bei weniger als drei Punkten wird eine offene Linie oder sogar nur ein Punkt angezeigt. Diese Option kann nur bei der Erstellung festgelegt werden. Wird sie nicht angegeben, gilt standardmäßig der Wert **false**.

**-color** *colorspec*
: Der Wert dieser Option ist die Farbe für das Standardelement, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-create-cmd** angegeben ist. Der Standardwert lautet **SkyBlue2**.

**-convex** *boolean*
: Der Wert dieser Option ist ein boolescher Schalter, der angibt, ob die bearbeitete Polylinie streng konvex ist oder nicht. Diese Option ist nur dann von Bedeutung, wenn die Option **-closed** auf den Wert **true** eingestellt ist. Diese Option kann nur bei der Erstellung festgelegt werden. Wird sie nicht angegeben, gilt standardmäßig der Wert **false**.

**-create-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn er einen neuen Eckpunkt erstellen muss. Obwohl diese Option auch nach der Erstellung festgelegt werden kann, wird empfohlen, diese Funktion ausschließlich dazu zu nutzen, benutzerdefinierte Verarbeitungsschritte einzufügen, die zum Zeitpunkt der Erstellung ausgeführt werden sollen und dabei den vorherigen Wert der Option speichern und aufrufen. Wird kein Wert festgelegt, wird standardmäßig ein Befehl verwendet, der einen blauen Kreis mit schwarzem Rahmen und einem Radius von 3 erzeugt, dessen Mittelpunkt an der Position des neuen Punktes liegt. Die Signatur dieses Befehlspräfixes lautet


**createCmd** *canvas* *x* *y*
: Das Ergebnis des Befehlspräfixes *muss* eine Liste der Canvas-Elemente sein, die zur Darstellung des Markers erstellt wurden. Hinweis: Die visuelle Darstellung eines „Eckpunkts“ kann aus mehreren Canvas-Elementen in beliebiger Form bestehen. Die zurückgegebene Liste der Elemente darf leer sein; dies wird als Signal gewertet, dass die Rückruffunktion die Erstellung des Eckpunkts abgelehnt hat.


**-data-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn die Linie in irgendeiner Weise bearbeitet wurde (Eckpunkt hinzugefügt, entfernt, verschoben). Auf diese Weise leitet der Editor die eigentliche Speicherung der Linieninformationen an ein externes Objekt weiter. Diese Option kann nur bei der Erstellung festgelegt werden. Wird sie nicht angegeben, ist der Standardwert eine leere Zeichenkette, und sie wird vom Editor ignoriert, d. h., nicht aufgerufen. Die Signatur dieses Befehlspräfixes lautet


**dataCmd** *editorObj* *coordinates*
: Diese Rückruffunktion wird aufgerufen, wenn die Linie entweder interaktiv oder programmgesteuert geändert wurde. Informationen zum letzteren Fall finden Sie in der Instanzmethode **add**. Das *editorObj* identifiziert die Instanz, die die Rückruffunktion aufruft, während *coordinates* eine Liste von Scheitelpunktpositionen ist, wobei jede Position aus einem Paar von x- und y-Koordinaten besteht. Das Ergebnis dieser Methode wird ignoriert.


**-drag-point** *eventspec*
: Der Wert dieser Option ist eine Ereignisspezifikation (ohne eckige Klammern), die festlegt, welches Ereignis eine Drag-Aktion an Punkten auslöst. Diese Option kann nur zur Erstellungszeit festgelegt werden. Die Standard-Spezifikation lautet **ButtonPress-3**.

**-hilit-color** *colorspec*
: Der Wert dieser Option ist die Hervorhebungsfarbe für das Standardelement, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-highlight-cmd** festgelegt ist. Der Standardwert lautet **red**.

**-kind** *name*
: Der Wert dieser Option ist der Canvas-Elementtyp für das Standardelement, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-create-cmd** angegeben ist. Es sind ausschließlich Elementtypen zulässig, die über einen Begrenzungsrahmen festgelegt werden. Der Standardwert lautet **oval**.

**-line-config** *list*
: Der Wert dieser Option ist eine Liste von Optionen und deren Werten, die auf das interne Linien-/Polygon-Element angewendet werden sollen, sobald dieses nach Änderungen neu generiert wird. Hinweis: Diese Optionen können die durch die Hauptoptionen **-color** und **-hilit-color** festgelegte Farbe der Linie/des Polygons *nicht* überschreiben. Wird kein Wert angegeben, wird standardmäßig eine leere Liste verwendet.

**-radius** *int*
: Der Wert dieser Option gibt den Radius für das Standardelement an, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-create-cmd** angegeben ist. Der Standardwert lautet **3**.

**-tag** *string*
: Der Wert dieser Option ist der Name des Canvas-Tags, mit dem alle Elemente aller vom Editor verwalteten Eckpunkte identifiziert werden sollen. Diese Option kann nur bei der Erstellung festgelegt werden. Wird sie nicht angegeben, lautet der Standardwert **POLYLINE**.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
