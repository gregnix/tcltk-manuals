---
CommandName: canvas::edit::circle
title: canvas::edit::circle
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - circle
 - editing
Copyright:
---

# Name

canvas::edit::circle – Bearbeiten eines Kreises auf einem Canvas

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::edit::points]{.lit} [0.1]{.optlit}
[package]{.cmd} [require]{.sub} [canvas::edit::circle]{.lit} [0.1]{.optlit}
[::canvas::edit]{.cmd} [circle]{.lit} [objectName]{.arg} [canvas]{.arg} [options...]{.arg}
[objectName]{.cmd} [destroy]{.lit}
[objectName]{.cmd} [enable]{.lit}
[objectName]{.cmd} [disable]{.lit}
[objectName]{.cmd} [active]{.lit}
[objectName]{.cmd} [set]{.lit} [minx]{.arg} [miny]{.arg} [maxx]{.arg} [maxy]{.arg}
[objectName]{.cmd} [clear]{.lit}
[activeCmd]{.cmd} [editorObj]{.arg} [id]{.arg}
[createCmd]{.cmd} [canvas]{.arg} [x]{.arg} [y]{.arg}
[dataCmd]{.cmd} [editorObj]{.arg} [coordinates]{.arg}
:::

# Beschreibung

Dieses Paket stellt eine Klasse bereit, deren Instanzen die Bearbeitung eines Kreises auf einem Canvas übernehmen. Die Instanzen können hinsichtlich der Darstellung der Markierungen, die die Hauptpunkte des Kreises kennzeichnen, konfiguriert werden. Beachten Sie, dass die Instanzen den bearbeiteten Kreis nicht selbst speichern, sondern diese Aufgabe an ein konfigurierbares Objekt weiterleiten.

# Interaktion

Der Kreis-Editor verwendet intern eine Instanz des Pakets **canvas::edit::points** und übernimmt alle damit verbundenen Optionen und Verhaltensweisen. Die Optionen zur Farbe werden zusätzlich auf das Kreis-Element dieses Editors angewendet.

Darüber hinaus bietet es die Option „**-circle-config**“, mit der Sie das Kreisobjekt, das zur Darstellung des Kreises anhand seiner Hauptpunkte verwendet wird, individuell anpassen können. Beachten Sie, dass damit die vererbten Farboptionen nicht überschrieben werden können.

Während einer Instanz wird eine Zustandsmaschine ausgeführt, in der der Benutzer zwei Punkte legt; daraufhin vervollständigt das System den Kreis und meldet dies. Ab diesem Zeitpunkt verhindert das System das Hinzufügen weiterer Punkte. Das Ziehen der Punkte ist weiterhin möglich, wodurch eine Größenänderung und das Verschieben des Kreises ermöglicht werden. Wird einer der Hauptpunkte gelöscht, wird der gesamte Kreis gelöscht; daraufhin ist das System wieder bereit für die Erstellung eines neuen Kreises aus zwei Punkten.

# API für Klassen

**::canvas::edit** **circle** *objectName* *canvas* *options*...
: Dieser Befehl „class“ erstellt und konfiguriert eine neue Instanz eines Kreiseditors mit dem Namen *objectName*. Die Instanz wird mit dem angegebenen *canvas*-Widget verbunden.

    Das Ergebnis des Befehls ist der vollqualifizierte Name der Instanz.

    Die hier zulässigen Optionen und ihre Werte werden im Abschnitt [Optionen] erläutert.


# Instanz-API

Die Instanzen der Kreis-Editoren stellen die folgende API bereit:

**objectName** **destroy**
: Diese Methode löscht den Kreis-Editor und gibt alle seine internen Ressourcen frei.

    Hinweis: Durch diesen Vorgang werden weder die vom Editor auf dem zugehörigen Canvas verwalteten Elemente noch der Canvas selbst gelöscht.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

**objectName** **enable**
: Diese Methode aktiviert die Bearbeitung des Kreises auf dem Canvas. Dies ist die Standardeinstellung nach der Erstellung der Instanz. Ein Aufruf wird ignoriert, wenn der Editor bereits aktiv ist.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Die komplementäre Methode lautet **disable**. Die Abfragemethode für den aktuellen Status lautet **active**.

**objectName** **disable**
: Diese Methode deaktiviert die Bearbeitung des Kreises auf dem Canvas. Ein Aufruf wird ignoriert, wenn der Editor bereits deaktiviert ist.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Die zugehörige Methode lautet **enable**. Die Abfragemethode für den aktuellen Status lautet **active**.

**objectName** **active**
: Diese Methode fragt den Status des Editors ab.

    Das Ergebnis der Methode ist ein boolescher Wert: **true**, wenn der Editor aktiv ist, und andernfalls **false**, d. h. deaktiviert.

    Die Methoden zum Ändern des Status lauten **enable** und **disable**.

**objectName** **set** *minx* *miny* *maxx* *maxy*
: Diese Methode legt den Kreis programmgesteuert anhand der Koordinaten des Rahmens fest. Dabei wird ein zuvor gezeichneter (möglicherweise unvollständiger) Kreis überschrieben.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Beachten Sie, dass diese Methode die gesamte Reihe von Rückruffunktionen durchläuft, die beim Erstellen der Hauptpunkte aufgerufen werden, d. h. **-create-cmd** und, was noch wichtiger ist, **-data-cmd**.

    Dies ist die Methode, mit der ein bereits vorhandener Kreis in eine Editor-Instanz geladen wird.

**objectName** **clear**
: Diese Methode entfernt den Kreis programmgesteuert aus dem Editor und schafft so Platz für die Erstellung eines neuen Kreises.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Hinweis: Diese Methode durchläuft dieselben Rückruffunktionen, die auch dann aufgerufen werden, wenn der Benutzer einen Hauptpunkt interaktiv entfernt, d. h. **-data-cmd**.


# Optionen

Der Befehl „class“ akzeptiert die folgenden Optionen

**-active-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn die Maus den Kreis oder einen der von der Instanz verwalteten Hauptpunkte berührt oder verlässt.

    Wird kein Wert angegeben, wird standardmäßig ein leerer Befehl verwendet, der keine Aktion auslöst.

    Die Signatur dieses Befehlspräfixes lautet

    **activeCmd** *editorObj* *id*
    : Die *id* identifiziert das eingegebene Objekt.

        Eine leere *id* bedeutet, dass das zuletzt eingegebene Objekt beibehalten wurde.

        Der Wert **circle** gibt an, dass die Gliederung des Kreises eingegeben wurde.

        Jeder andere Wert ist ein Code für einen der Hauptpunkte des Kreises, d. h. **center** und **edge**.

        Das Ergebnis dieser Methode wird ignoriert.


**-add-remove-point** *eventspec*
: Der Wert dieser Option ist eine Ereignisspezifikation (ohne Klammerwinkel), die festlegt, welches Ereignis das Hinzufügen bzw. Entfernen eines Punktes auslöst.

    Diese Option kann nur bei der Erstellung festgelegt werden.

    In der Standardeinstellung werden für das Hinzufügen und Entfernen von Punkten unterschiedliche Ereignisse verwendet, nämlich **ButtonPress-1** bzw. **ButtonPress-2**.

    Bei Verwendung dieser Option wird für beide Vorgänge dasselbe Ereignis verwendet. Dies stellt kein Problem dar, da das Hinzufügen als canvas-globales Ereignis gebunden ist, während das Entfernen an die jeweiligen Canvas-Elemente gebunden ist.

**-circle-config** *list*
: Der Wert dieser Option ist eine Liste von Optionen und deren Werten, die auf das Element „interner Kreis“ angewendet werden sollen, sobald dieses nach Änderungen neu generiert wird. Hinweis: Diese Optionen können die durch die Hauptoptionen **-color** und **-hilit-color** festgelegte Farbe des Kreises *nicht* überschreiben.

    Wird kein Wert angegeben, wird standardmäßig eine leere Liste verwendet.

**-color** *colorspec*
: Der Wert dieser Option ist die Farbe für das Standardelement, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-create-cmd** angegeben ist.

    Der Standardwert lautet **SkyBlue2**.

**-create-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn er einen neuen Hauptpunkt erstellen muss.

    Obwohl diese Option auch nach der Erstellung festgelegt werden kann, wird empfohlen, diese Funktion ausschließlich dazu zu nutzen, benutzerdefinierte Verarbeitungsschritte einzufügen, die zum Zeitpunkt der Erstellung ausgeführt werden sollen und dabei den vorherigen Wert der Option speichern und aufrufen.

    Wird kein Wert festgelegt, wird standardmäßig ein Befehl verwendet, der einen blau umrandeten Kreis mit einem Radius von 3 und dem Mittelpunkt an der Position des neuen Punktes erstellt.

    Die Signatur dieses Befehlspräfixes lautet

    **createCmd** *canvas* *x* *y*
    : Das Ergebnis des Befehlspräfixes *muss* eine Liste der Canvas-Elemente sein, die zur Darstellung des Markers erstellt wurden. Beachten Sie hierbei, dass die visuelle Darstellung eines „Hauptpunkts“ aus mehreren Canvas-Elementen in beliebiger Form bestehen kann.

        Die zurückgegebene Liste der Elemente darf leer sein; dies wird als Hinweis darauf gewertet, dass die Rückruffunktion die Erstellung des Hauptpunkts abgelehnt hat.


**-data-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn der Kreis in irgendeiner Weise bearbeitet wurde (erstellt, geändert, gelöscht). Auf diese Weise leitet der Editor die eigentliche Speicherung der Kreisdaten an ein externes Objekt weiter.

    Diese Option kann nur bei der Erstellung festgelegt werden.

    Wird sie nicht angegeben, ist der Standardwert eine leere Zeichenkette, und sie wird vom Editor ignoriert, d. h., nicht aufgerufen.

    Die Signatur dieses Befehlspräfixes lautet

    **dataCmd** *editorObj* *coordinates*
    : Diese Rückruffunktion wird aufgerufen, wenn der Kreis entweder interaktiv oder programmgesteuert geändert wurde. Informationen zum letzteren Fall finden Sie in der Instanzmethode **set**.

        Das *editorObj* identifiziert die Instanz, die die Rückruffunktion aufruft, während *coordinates* eine Liste mit vier Elementen ist, die in dieser Reihenfolge die minimalen x- und y-Koordinaten sowie die maximalen x- und y-Koordinaten des Kreises enthält.

        Das Ergebnis dieser Methode wird ignoriert.


**-drag-point** *eventspec*
: Der Wert dieser Option ist eine Ereignisspezifikation (ohne eckige Klammern), die festlegt, welches Ereignis eine Drag-Aktion an Punkten auslöst.

    Diese Option kann nur zur Erstellungszeit festgelegt werden.

    Die Standard-Spezifikation lautet **ButtonPress-3**.

**-hilit-color** *colorspec*
: Der Wert dieser Option ist die Hervorhebungsfarbe für das Standardelement, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-highlight-cmd** festgelegt ist.

    Der Standardwert lautet **red**.

**-kind** *name*
: Der Wert dieser Option ist der Canvas-Elementtyp für das Standardelement, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-create-cmd** angegeben ist. Es sind ausschließlich Elementtypen zulässig, die über einen Begrenzungsrahmen festgelegt werden.

    Der Standardwert lautet **oval**.

**-radius** *int*
: Der Wert dieser Option gibt den Radius für das Standardelement an, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-create-cmd** angegeben ist.

    Der Standardwert lautet **3**.

**-tag** *string*
: Der Wert dieser Option ist der Name des Canvas-Tags, mit dem alle Elemente aller vom Editor verwalteten Eckpunkte identifiziert werden sollen.

    Diese Option kann nur bei der Erstellung festgelegt werden.

    Wird sie nicht angegeben, lautet der Standardwert **CIRCLE**.


# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
