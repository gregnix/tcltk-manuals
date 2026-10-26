---
CommandName: canvas::edit::rectangle
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - editing
 - rectangle
Copyright:
---

# NAME

canvas::edit::rectangle – Bearbeiten eines Rechtecks auf einem Canvas

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::edit::points]{.lit} [0.1]{.optlit} 
[package]{.cmd} [require]{.sub} [canvas::edit::rectangle]{.lit} [0.1]{.optlit} 
[::canvas::edit]{.cmd} [rectangle]{.sub} [objectName]{.arg} [canvas]{.arg} [options...]{.arg} 
[objectName]{.cmd} [destroy]{.sub} 
[objectName]{.cmd} [enable]{.sub} 
[objectName]{.cmd} [disable]{.sub} 
[objectName]{.cmd} [active]{.sub} 
[objectName]{.cmd} [set]{.sub} [minx]{.arg} [miny]{.arg} [maxx]{.arg} [maxy]{.arg} 
[objectName]{.cmd} [clear]{.sub} 
[activeCmd]{.cmd} [editorObj]{.arg} [id]{.arg} 
[createCmd]{.cmd} [canvas]{.arg} [x]{.arg} [y]{.arg} 
[dataCmd]{.cmd} [editorObj]{.arg} [coordinates]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine Klasse bereit, deren Instanzen die Bearbeitung eines Rechtecks auf einem Canvas übernehmen. Die Instanzen können hinsichtlich der Darstellung der Markierungen, die die Ecken des Rechtecks kennzeichnen, konfiguriert werden. Hinweis: Die Instanzen speichern das bearbeitete Rechteck nicht selbst, sondern leiten diese Aufgabe an ein konfigurierbares Objekt weiter.

# INTERAKTION

Der Rechteck-Editor verwendet intern eine Instanz des Pakets **canvas::edit::points** und übernimmt alle damit verbundenen Optionen und Verhaltensweisen. Die Optionen zur Farbe werden zusätzlich auf das Rechteck-Element dieses Editors angewendet.

Darüber hinaus bietet es die Option „**-rect-config**“, mit der Sie das Rechteck-Element, das zur Darstellung des Rechtecks verwendet wird, anhand seiner Ecken anpassen können. Beachten Sie, dass damit die vererbten Farboptionen nicht überschrieben werden können.

Während einer Instanz wird eine Zustandsmaschine ausgeführt, in der der Benutzer zwei Punkte festlegt; daraufhin vervollständigt das System das Rechteck mit den fehlenden Ecken und meldet dies. Ab diesem Zeitpunkt verhindert das System das Hinzufügen weiterer Punkte. Das Ziehen der Punkte ist weiterhin möglich, wodurch eine Größenänderung und das Verschieben des Rechtecks ermöglicht werden. Das Löschen einer beliebigen Ecke löscht das gesamte Rechteck; daraufhin ist das System wieder bereit für die Erstellung eines neuen Rechtecks aus zwei Punkten.

# API FÜR KLASSEN

**::canvas::edit** **rectangle** *objectName* *canvas* *options*...
: Dieser Befehl, der „class“-Befehl, erstellt und konfiguriert eine neue Instanz eines Rechteck-Editors mit dem Namen *objectName*. Die Instanz wird mit dem angegebenen *canvas*-Widget verbunden. Das Ergebnis des Befehls ist der vollqualifizierte Name der Instanz. Die hier zulässigen Optionen und ihre Werte werden im Abschnitt **OPTIONEN** erläutert.


# INSTANZ-API

Instanzen der Rechteck-Editoren stellen die folgende API bereit:

**objectName** **destroy**
: Diese Methode löscht den Rechteck-Editor und gibt alle seine internen Ressourcen frei. Beachten Sie, dass durch diesen Vorgang weder die vom Editor auf dem zugehörigen Canvas verwalteten Elemente noch der Canvas selbst gelöscht werden. Das Ergebnis der Methode ist eine leere Zeichenkette.

**objectName** **enable**
: Diese Methode aktiviert die Bearbeitung des Rechtecks auf dem Canvas. Dies ist die Standardeinstellung nach der Instanzerstellung. Ein Aufruf wird ignoriert, wenn der Editor bereits aktiv ist. Das Ergebnis der Methode ist eine leere Zeichenkette. Die zugehörige Methode ist **disable**. Die Abfragemethode für den aktuellen Status lautet **active**.

**objectName** **disable**
: Diese Methode deaktiviert die Bearbeitung des Rechtecks auf dem Canvas. Ein Aufruf wird ignoriert, wenn der Editor bereits deaktiviert ist. Das Ergebnis der Methode ist eine leere Zeichenkette. Die zugehörige Methode lautet **enable**. Die Abfragemethode für den aktuellen Status lautet **active**.

**objectName** **active**
: Diese Methode fragt den Status des Editors ab. Das Ergebnis der Methode ist ein boolescher Wert: **true**, wenn der Editor aktiv ist, und andernfalls **false**, d. h. deaktiviert. Die Methoden zum Ändern des Status lauten **enable** und **disable**.

**objectName** **set** *minx* *miny* *maxx* *maxy*
: Diese Methode legt das Rechteck programmgesteuert anhand der Rahmen-Koordinaten fest. Dabei wird ein zuvor vorhandenes (möglicherweise unvollständiges) Rechteck überschrieben. Das Ergebnis der Methode ist eine leere Zeichenkette. Hinweis: Diese Methode durchläuft die gesamte Reihe von Rückruffunktionen, die beim Erstellen von Ecken aufgerufen werden, d. h. **-create-cmd** und, was noch wichtiger ist, **-data-cmd**. Dies ist die Methode, mit der ein bereits vorhandenes Rechteck in eine Editor-Instanz geladen wird.

**objectName** **clear**
: Diese Methode entfernt das Rechteck programmgesteuert aus dem Editor und schafft so Platz für die Erstellung eines neuen Rechtecks. Das Ergebnis der Methode ist eine leere Zeichenkette. Beachten Sie, dass diese Methode dieselben Rückruffunktionen durchläuft, die auch dann aufgerufen werden, wenn der Benutzer interaktiv eine Ecke entfernt, d. h. **-data-cmd**.


# OPTIONEN

Der Befehl „class“ akzeptiert die folgenden Optionen

**-active-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn die Maus in das von der Instanz verwaltete Rechteck oder eine Ecke hinein- oder aus diesem herausbewegt wird. Wird kein Wert angegeben, wird standardmäßig ein leerer Befehl verwendet, der keine Aktion ausführt. Die Signatur dieses Befehlspräfixes lautet


**activeCmd** *editorObj* *id*
: Die *id* identifiziert das eingegebene Objekt. Eine leere *id* bedeutet, dass das zuletzt eingegebene Objekt beibehalten wurde. Der Wert **rect** gibt an, dass die Gliederung des Rechtecks eingegeben wurde. Jeder andere Wert ist ein Code für eine der Ecken des Rechtecks, d. h. **tl**, **tr**, **bl** und **br**. Das Ergebnis dieser Methode wird ignoriert.


**-add-remove-point** *eventspec*
: Der Wert dieser Option ist eine Ereignisspezifikation (ohne Klammerwinkel), die festlegt, welches Ereignis das Hinzufügen bzw. Entfernen eines Punktes auslöst. Diese Option kann nur bei der Erstellung festgelegt werden. In der Standardeinstellung werden für das Hinzufügen und Entfernen von Punkten unterschiedliche Ereignisse verwendet, nämlich **ButtonPress-1** bzw. **ButtonPress-2**. Bei Verwendung dieser Option wird für beide Vorgänge dasselbe Ereignis verwendet. Dies stellt kein Problem dar, da das Hinzufügen als canvas-globales Ereignis gebunden ist, während das Entfernen an die jeweiligen Canvas-Elemente gebunden ist.

**-color** *colorspec*
: Der Wert dieser Option ist die Farbe für das Standardelement, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-create-cmd** angegeben ist. Der Standardwert lautet **SkyBlue2**.

**-create-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn er einen neuen Eckpunkt erstellen muss. Obwohl diese Option auch nach der Erstellung festgelegt werden kann, wird empfohlen, diese Funktion ausschließlich dazu zu nutzen, benutzerdefinierte Verarbeitungsschritte einzufügen, die zum Zeitpunkt der Erstellung ausgeführt werden sollen und dabei den vorherigen Wert der Option speichern und aufrufen. Wird kein Wert festgelegt, wird standardmäßig ein Befehl verwendet, der einen blauen Kreis mit schwarzem Rahmen und einem Radius von 3 erzeugt, dessen Mittelpunkt an der Position des neuen Punktes liegt. Die Signatur dieses Befehlspräfixes lautet


**createCmd** *canvas* *x* *y*
: Das Ergebnis des Befehlspräfixes *muss* eine Liste der Canvas-Elemente sein, die zur Darstellung des Markers erstellt wurden. Beachten Sie hierbei, dass die visuelle Darstellung einer „Ecke“ aus mehreren Canvas-Elementen in beliebiger Form bestehen kann. Die zurückgegebene Liste der Elemente darf leer sein; dies wird als Hinweis darauf gewertet, dass die Rückruffunktion die Erstellung der Ecke abgelehnt hat.


**-data-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn das Rechteck in irgendeiner Weise bearbeitet wurde (erstellt, geändert, gelöscht). Auf diese Weise leitet der Editor die eigentliche Speicherung der Rechteckdaten an ein externes Objekt weiter. Diese Option kann nur bei der Erstellung festgelegt werden. Wird sie nicht angegeben, ist der Standardwert eine leere Zeichenkette, und sie wird vom Editor ignoriert, d. h., der Befehl wird nicht aufgerufen. Die Signatur dieses Befehlspräfixes lautet


**dataCmd** *editorObj* *coordinates*
: Diese Rückruffunktion wird aufgerufen, wenn das Rechteck entweder interaktiv oder programmgesteuert geändert wurde. Informationen zu letzterem finden Sie in der Instanzmethode **set**. Das *editorObj* identifiziert die Instanz, die die Rückruffunktion aufruft, während *coordinates* eine Liste mit vier Elementen ist, die in dieser Reihenfolge die minimalen x- und y-Koordinaten sowie die maximalen x- und y-Koordinaten des Rechtecks enthält. Das Ergebnis dieser Methode wird ignoriert.


**-drag-point** *eventspec*
: Der Wert dieser Option ist eine Ereignisspezifikation (ohne eckige Klammern), die festlegt, welches Ereignis eine Drag-Aktion an Punkten auslöst. Diese Option kann nur zur Erstellungszeit festgelegt werden. Die Standard-Spezifikation lautet **ButtonPress-3**.

**-hilit-color** *colorspec*
: Der Wert dieser Option ist die Hervorhebungsfarbe für das Standardelement, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-highlight-cmd** festgelegt ist. Der Standardwert lautet **red**.

**-kind** *name*
: Der Wert dieser Option ist der Canvas-Elementtyp für das Standardelement, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-create-cmd** angegeben ist. Es sind ausschließlich Elementtypen zulässig, die über einen Begrenzungsrahmen festgelegt werden. Der Standardwert lautet **oval**.

**-radius** *int*
: Der Wert dieser Option gibt den Radius für das Standardelement an, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-create-cmd** angegeben ist. Der Standardwert lautet **3**.

**-rect-config** *list*
: Der Wert dieser Option ist eine Liste von Optionen und deren Werten, die auf das interne Rechteck-Element angewendet werden sollen, sobald dieses nach Änderungen neu generiert wird. Hinweis: Diese Optionen können die durch die Hauptoptionen **-color** und **-hilit-color** festgelegte Farbe des Rechtecks *nicht* überschreiben. Wird kein Wert angegeben, wird standardmäßig eine leere Liste verwendet.

**-tag** *string*
: Der Wert dieser Option ist der Name des Canvas-Tags, mit dem alle Elemente aller vom Editor verwalteten Eckpunkte identifiziert werden sollen. Diese Option kann nur bei der Erstellung festgelegt werden. Wird sie nicht angegeben, lautet der Standardwert **RECTANGLE**.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
