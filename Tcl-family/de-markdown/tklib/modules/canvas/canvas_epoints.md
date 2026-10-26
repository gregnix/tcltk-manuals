---
CommandName: canvas::edit::points
title: canvas::edit::points
ManualSection: n
Version: 0.3
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - editing
 - point cloud
 - points
Copyright:
---

# Name

canvas::edit::points – Bearbeiten einer Punktwolke auf einem Canvas

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::edit::points]{.lit} [0.3]{.optlit}
[::canvas::edit]{.cmd} [points]{.lit} [objectName]{.arg} [canvas]{.arg} [options...]{.arg}
[objectName]{.cmd} [destroy]{.lit}
[objectName]{.cmd} [enable]{.lit}
[objectName]{.cmd} [disable]{.lit}
[objectName]{.cmd} [active]{.lit}
[objectName]{.cmd} [add]{.lit} [x]{.arg} [y]{.arg}
[objectName]{.cmd} [clear]{.lit}
[activeCmd]{.cmd} [editorObj]{.arg} [id]{.arg}
[createCmd]{.cmd} [canvas]{.arg} [x]{.arg} [y]{.arg}
[dataCmd]{.cmd} [add]{.lit} [editorObj]{.arg} [id]{.arg} [x]{.arg} [y]{.arg}
[dataCmd]{.cmd} [remove]{.lit} [editorObj]{.arg} [id]{.arg}
[dataCmd]{.cmd} [move]{.lit} [start]{.lit} [editorObj]{.arg} [id]{.arg}
[dataCmd]{.cmd} [move]{.lit} [delta]{.lit} [editorObj]{.arg} [id]{.arg} [x]{.arg} [y]{.arg} [dx]{.arg} [dy]{.arg}
[dataCmd]{.cmd} [move]{.lit} [done]{.lit} [editorObj]{.arg} [id]{.arg}
:::

# Beschreibung

Dieses Paket stellt eine Klasse bereit, deren Instanzen die Bearbeitung einer Ansammlung von Punktmarkierungen auf einem Canvas übernehmen. Die Instanzen können hinsichtlich der Darstellung der Markierungen konfiguriert werden. Beachten Sie, dass die Instanzen die bearbeiteten Punkte nicht selbst speichern, sondern diese Aufgabe an ein konfigurierbares Objekt weiterleiten.

# Interaktion

Die Standard-Bindings ermöglichen das Erstellen, Entfernen und Verschieben von Punkten (Markern) mithilfe der Maustasten 1, 2 und 3. Im Einzelnen:

1. Wenn Sie mit Taste 1 auf eine beliebige Stelle klicken, wird ein neuer Punkt hinzugefügt.

2. Wenn Sie mit Taste 2 auf einen Punkt klicken, wird dieser Punkt entfernt.

3. Durch Klicken auf einen Punkt mit Taste 3 wird ein Ziehvorgang gestartet, der mit dem Loslassen der Taste endet.


Mit der Option **-drag-point** können Sie die Taste ändern, mit der Ziehvorgänge ausgelöst werden. Hinweis: Der Wert der Option enthält nicht nur die Tastennummer, sondern auch ein Modifikatorpräfix, das durch einen Bindestrich von der Tastennummer getrennt ist („**-**“). Die unterstützten Modifikatoren sind **Control**, **Shift** und **Alt**.

Die Option **-add-remove-point** kann verwendet werden, um die Taste zu ändern, mit der Punkte hinzugefügt oder entfernt werden. Dies funktioniert, da das Entfernen eine Bindung ist, während das Hinzufügen global für den Canvas gilt. Die Option erkennt für die Taste dieselbe Syntax wie **-drag-point**.

In der Standardkonfiguration ist das Canvas-Element, das einen Punkt darstellt, ein Kreis, der mithilfe der Darstellungsoptionen **-color**, **-hilit-color** und **-radius** konfiguriert wird. Ihre Standardwerte sind **Skyblue2**, **red** bzw. **3**.

Mit der Option **-kind** lässt sich das Canvas-Element leicht an beliebige Arten anpassen, wobei die Element-Optionen **-width**, **-outline**, **-fill** und **-activefill** akzeptiert.

Für eine umfassendere Anpassung ist es erforderlich, mithilfe der Option **-create-cmd** einen Erstellungs-Callback zu konfigurieren. Die Rückruffunktion nimmt den Canvas sowie die x- und y-Koordinaten in dieser Reihenfolge als Argumente entgegen und soll eine Liste der Canvas-Elemente zurückgeben, die den Punkt darstellen.

Beachten Sie den Plural. Mit der Rückruffunktion ist es möglich, einen Punkt mithilfe einer Gruppe von Elementen darzustellen.

Beachten Sie ferner, dass kein Punkt erstellt wird, wenn die Rückruffunktion eine leere Liste gibt. Mit anderen Worten: Die Rückruffunktion kann auch dazu verwendet werden, zu prüfen, ob ein Punkt an der angegebenen Position erwünscht ist oder nicht. Dies lässt sich mit dem Standardverhalten bei der Erstellung kombinieren, da die Option abgefragt werden kann und ihr Standardwert die Rückruffunktion für das Standardverhalten ist.

Um noch etwas bei der Rückruffunktion zu bleiben: Die Option **-active-cmd** legt eine Rückruffunktion fest, die immer dann aufgerufen wird, wenn sich der Mauszeiger über einem der erstellten Punkte befindet, d. h. wenn dieser aktiv ist. Dies kann zur Steuerung abgeleiteter Anzeigen genutzt werden, beispielsweise zum Hervorheben des Eintrags des Punktes in einer Tabelle oder einem anderen Widget.

Die letzte wichtige Option ist **-tag**. Ihr Wert ist der Name des Canvas-Tags, mit dem alle Elemente gekennzeichnet werden, die einem gehören, d. h. von diesem erstellt und verwaltet werden. Der Standardwert lautet **POINT**.

Wenn mehrere Instanzen dieses Verhaltens an dieselbe „Canvas“ angehängt werden, muss jede Instanz mit einem eindeutigen Tag konfiguriert werden, um zu verhindern, dass sie sich gegenseitig stören.

# API für Klassen

**::canvas::edit** **points** *objectName* *canvas* *options*...
: Dieser Befehl der Klasse erstellt und konfiguriert eine neue Instanz eines Punktwolken-Editors mit dem Namen *objectName*. Die Instanz wird mit dem angegebenen *canvas*-Widget verbunden.

    Das Ergebnis des Befehls ist der vollqualifizierte Name der Instanz.

    Die hier zulässigen Optionen und ihre Werte werden im Abschnitt [Optionen] erläutert.


# Instanz-API

Instanzen der Punktwolken-Editoren stellen die folgende API bereit:

**objectName** **destroy**
: Diese Methode löscht den Punktwolken-Editor und gibt alle seine internen Ressourcen frei.

    Beachten Sie, dass dieser Vorgang weder die Elemente der Punktmarkierungen, die der Editor auf dem zugehörigen Canvas verwaltet hat, noch den Canvas selbst löscht.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

**objectName** **enable**
: Diese Methode aktiviert die Bearbeitung der Punktwolke auf dem Canvas. Dies ist die Standardeinstellung nach der Erstellung der Instanz. Ein Aufruf wird ignoriert, wenn der Editor bereits aktiv ist.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Die zugehörige Methode ist **disable**. Die Abfragemethode für den aktuellen Status lautet **active**.

**objectName** **disable**
: Diese Methode deaktiviert die Bearbeitung der Punktwolke auf dem Canvas. Ein Aufruf wird ignoriert, wenn der Editor bereits deaktiviert ist.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Die zugehörige Methode ist **enable**. Die Abfragemethode für den aktuellen Status lautet **active**.

**objectName** **active**
: Diese Methode fragt den Status des Editors ab.

    Das Ergebnis der Methode ist ein boolescher Wert: **true**, wenn der Editor aktiv ist, und andernfalls **false**, d. h. deaktiviert.

    Die Methoden zum Ändern des Status lauten **enable** und **disable**.

**objectName** **add** *x* *y*
: Diese Methode erstellt programmgesteuert einen Punkt an der festgelegten Position.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Hinweis: Diese Methode durchläuft die gesamte Reihe von Rückruffunktionen, die aufgerufen werden, wenn der Benutzer interaktiv einen Punkt erstellt, d. h. **-create-cmd** und, was noch wichtiger ist, **-data-cmd**.

    Dies ist die Methode, mit der bereits vorhandene Punkte in eine Editor-Instanz geladen werden können.

**objectName** **clear**
: Diese Methode entfernt programmgesteuert alle Punkte aus dem Editor.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Beachten Sie, dass diese Methode die gleiche Rückruffunktion durchläuft, die auch dann aufgerufen wird, wenn der Benutzer einen Punkt interaktiv entfernt, d. h. **-data-cmd**.


# Optionen

Der Befehl „class“ akzeptiert die folgenden Optionen

**-active-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn die Maus einen von der Instanz verwalteten Punkt erreicht oder verlässt.

    Wird kein Wert angegeben, wird standardmäßig ein leerer Befehl verwendet, der keine Aktion ausführt.

    Die Signatur dieses Befehlspräfixes lautet

    **activeCmd** *editorObj* *id*
    : Die *id* identifiziert die Position innerhalb des Editors.

        Eine leere *id* bedeutet, dass die zuletzt eingegebene Position verlassen wurde.

        Das Ergebnis dieser Methode wird ignoriert.


**-add-remove-point** *eventspec*
: Der Wert dieser Option ist eine Ereignisspezifikation (ohne Klammerwinkel), die festlegt, welches Ereignis das Hinzufügen bzw. Entfernen eines Punktes auslöst.

    Diese Option kann nur bei der Erstellung festgelegt werden.

    In der Standardeinstellung werden für das Hinzufügen und Entfernen von Punkten unterschiedliche Ereignisse verwendet, nämlich **ButtonPress-1** bzw. **ButtonPress-2**.

    Bei Verwendung dieser Option wird für beide Vorgänge dasselbe Ereignis verwendet. Dies stellt kein Problem dar, da das Hinzufügen als canvas-globales Ereignis gebunden ist, während das Entfernen an die jeweiligen Canvas-Elemente gebunden ist.

**-color** *colorspec*
: Der Wert dieser Option ist die Farbe für das Standardelement, das beim Hinzufügen eines Punktes erstellt wird, sofern kein **-create-cmd** angegeben ist.

    Der Standardwert lautet **SkyBlue2**.

**-create-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn er einen neuen Punkt erstellen muss.

    Obwohl diese Option auch nach der Erstellung festgelegt werden kann, wird empfohlen, diese Funktion ausschließlich dazu zu nutzen, benutzerdefinierte Verarbeitungsschritte einzufügen, die zum Zeitpunkt der Erstellung ausgeführt werden sollen und dabei den vorherigen Wert der Option speichern und aufrufen.

    Wird kein Wert festgelegt, wird standardmäßig ein Befehl verwendet, der einen blauen Kreis mit schwarzem Rahmen und einem Radius von 3 erzeugt, dessen Mittelpunkt an der Position des neuen Punktes liegt.

    Die Signatur dieses Befehlspräfixes lautet

    **createCmd** *canvas* *x* *y*
    : Das Ergebnis des Befehlspräfixes *muss* eine Liste der Canvas-Elemente sein, die zur Darstellung des Markers erstellt wurden. Beachten Sie hierbei, dass die visuelle Darstellung eines „Punkts“ aus mehreren Canvas-Elementen in beliebiger Form bestehen kann.

        Die zurückgegebene Liste der Elemente darf leer sein; dies wird als Signal gewertet, dass die Rückruffunktion die Erstellung des Punkts abgelehnt hat.


**-data-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn ein Punkt in irgendeiner Weise bearbeitet wurde. Auf diese Weise leitet der Editor die eigentliche Speicherung der Punktinformationen an ein externes Objekt weiter.

    Diese Option kann nur bei der Erstellung festgelegt werden.

    Wird sie nicht angegeben, ist der Standardwert eine leere Zeichenkette, und sie wird vom Editor ignoriert, d. h., nicht aufgerufen.

    Die Signaturen dieses Befehlspräfixes lauten

    **dataCmd** **add** *editorObj* *id* *x* *y*
    : Diese Rückruffunktion wird aufgerufen, wenn der Instanz ein neuer Punkt hinzugefügt wurde, sei es interaktiv oder programmgesteuert. Informationen zu letzterem finden Sie in der Instanzmethode **add**.

        Die Variable *id* identifiziert den Punkt innerhalb des Editors und wird von den beiden anderen Rückruffunktionen verwendet, um festzulegen, welcher Punkt geändert werden soll.

        Die letzten beiden Argumente *x* und *y* legen die Position des neuen Punkts in Canvas-Koordinaten fest.

        Das Ergebnis dieser Methode wird ignoriert.

    **dataCmd** **remove** *editorObj* *id*
    : Diese Rückruffunktion wird aufgerufen, wenn ein Punkt aus der Editor-Instanz entfernt wird.

        Die *id* identifiziert den entfernten Punkt innerhalb des Editors.

        Das Ergebnis dieser Methode wird ignoriert.

    **dataCmd** **move start** *editorObj* *id*
    : Diese Rückruffunktion wird aufgerufen, wenn die Verschiebung eines Punktes in der Editor-Instanz begonnen hat.

        Die *id* identifiziert den Punkt innerhalb des Editors, der verschoben werden soll.

        Das Ergebnis dieser Methode wird ignoriert.

    **dataCmd** **move delta** *editorObj* *id* *x* *y* *dx* *dy*
    : Diese Rückruffunktion wird aufgerufen, wenn der Punkt in der Editor-Instanz verschoben wurde.

        Die Variable *id* identifiziert den verschobenen Punkt innerhalb des Editors, und die übrigen Argumente *x*, *y*, *dx* und *dy* geben die neue absolute Position des Punkts sowie die vollständigen Delta-Werte zur ursprünglichen Position an.

        Zum Zeitpunkt des Aufrufs ist die Verschiebung vom System *noch nicht* bestätigt. Erst nachdem die Methode **move done** aufgerufen wurde und die letzte Position akzeptiert oder abgelehnt hat, aktualisiert der Editor seine internen Datenstrukturen, wobei er entweder die neue Position bestätigt oder die Verschiebung auf die ursprüngliche Position zurücknimmt.

        Vor diesem Hintergrund sollten die hier bereitgestellten Positionsdaten bis dahin nur im temporären Speicher abgelegt werden.

        Das Ergebnis dieser Methode wird ignoriert.

    **dataCmd** **move done** *editorObj* *id*
    : Diese Rückruffunktion wird aufgerufen, wenn die Verschiebung eines Punktes in der Editor-Instanz abgeschlossen ist.

        Die *id* identifiziert den verschobenen Punkt innerhalb des Editors.

        Das Ergebnis dieser Methode muss ein boolescher Wert sein. Wenn die Methode den Wert **false** gibt, wird die Verschiebung abgelehnt und rückgängig gemacht.


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
: Der Wert dieser Option ist der Name des Canvas-Tags, mit dem alle Elemente aller vom Editor verwalteten Punkte identifiziert werden sollen.

    Diese Option kann nur bei der Erstellung festgelegt werden.

    Wird sie nicht angegeben, lautet der Standardwert „**POINT**“.


# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
