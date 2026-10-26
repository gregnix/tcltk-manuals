---
CommandName: canvas::edit::quadrilateral
title: canvas::edit::quadrilateral
ManualSection: n
Version: 0.2
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - concave
 - convex
 - editing
 - non-convex
 - quadrilateral
Copyright:
---

# Name

canvas::edit::quadrilateral – Bearbeiten eines Vierecks auf einem Canvas

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::edit::points]{.lit} [0.1]{.optlit}
[package]{.cmd} [require]{.sub} [canvas::edit::quadrilateral]{.lit} [0.2]{.optlit}
[::canvas::edit]{.cmd} [quadrilateral]{.lit} [objectName]{.arg} [canvas]{.arg} [options...]{.arg}
[objectName]{.cmd} [destroy]{.lit}
[objectName]{.cmd} [enable]{.lit}
[objectName]{.cmd} [disable]{.lit}
[objectName]{.cmd} [active]{.lit}
[objectName]{.cmd} [add]{.lit} [x]{.arg} [y]{.arg}
[objectName]{.cmd} [clear]{.lit}
[createCmd]{.cmd} [canvas]{.arg} [x]{.arg} [y]{.arg}
[highlightCmd]{.cmd} [on]{.lit} [canvas]{.arg} [item]{.arg}
[highlightCmd]{.cmd} [off]{.lit} [canvas]{.arg} [state]{.arg}
[dataCmd]{.cmd} [editorObj]{.arg} [coordinates]{.arg}
:::

# Beschreibung

Dieses Paket stellt eine Klasse bereit, deren Instanzen die Bearbeitung eines Vierecks auf einem Canvas übernehmen. Die Instanzen lassen sich hinsichtlich der Darstellung (normal und hervorgehoben) der Eckpunktmarkierungen konfigurieren. Beachten Sie, dass die Instanzen das bearbeitete Viereck nicht selbst speichern, sondern diese Aufgabe an ein konfigurierbares Objekt weiterleiten.

# API für Klassen

**::canvas::edit** **quadrilateral** *objectName* *canvas* *options*...
: Dieser Befehl der Klasse erstellt und konfiguriert eine neue Instanz eines Viereck-Editors mit dem Namen *objectName*. Die Instanz wird mit dem angegebenen *canvas*-Widget verbunden.

    Das Ergebnis des Befehls ist der vollqualifizierte Name der Instanz.

    Die hier zulässigen Optionen und ihre Werte werden im Abschnitt [Optionen] erläutert.


# Instanz-API

Die Instanzen der Viereck-Editoren stellen die folgende API bereit:

**objectName** **destroy**
: Diese Methode löscht den Viereck-Editor und gibt alle seine internen Ressourcen frei.

    Beachten Sie, dass durch diesen Vorgang weder die vom Editor auf dem zugehörigen Canvas verwalteten Elemente noch der Canvas selbst gelöscht werden.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

**objectName** **enable**
: Diese Methode aktiviert die Bearbeitung des Vierecks auf dem Canvas. Dies ist die Standardeinstellung nach der Erstellung der Instanz. Ein Aufruf wird ignoriert, wenn der Editor bereits aktiv ist.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Die komplementäre Methode lautet **disable**. Die Abfragemethode für den aktuellen Status lautet **active**.

**objectName** **disable**
: Diese Methode deaktiviert die Bearbeitung des Vierecks auf dem Canvas. Ein Aufruf wird ignoriert, wenn der Editor bereits deaktiviert ist.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Die zugehörige Methode ist **enable**. Die Abfragemethode für den aktuellen Status lautet **active**.

**objectName** **active**
: Diese Methode fragt den Status des Editors ab.

    Das Ergebnis der Methode ist ein boolescher Wert: **true**, wenn der Editor aktiv ist, und andernfalls **false**, d. h. deaktiviert.

    Die Methoden zum Ändern des Status lauten **enable** und **disable**.

**objectName** **add** *x* *y*
: Diese Methode fügt dem Viereck programmgesteuert einen Scheitelpunkt an der festgelegten Position hinzu.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Hinweis: Diese Methode durchläuft die gesamte Reihe von Rückruffunktionen, die aufgerufen werden, wenn der Benutzer interaktiv einen Scheitelpunkt erstellt, d. h. **-create-cmd** und, was noch wichtiger ist, **-data-cmd**.

    Dies ist die Methode, mit der die Eckpunkte eines bereits vorhandenen Vierecks in eine Editor-Instanz geladen werden.

    Es gibt Hinweise darauf, dass höchstens 4 Eckpunkte angegeben werden können und mindestens 4 angegeben werden müssen, damit das Viereck vollständig ist.

**objectName** **clear**
: Diese Methode hebt die Auswahl des Vierecks im Editor programmgesteuert auf.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Hinweis: Diese Methode durchläuft die gleiche Rückruffunktion, die auch dann aufgerufen wird, wenn der Benutzer einen Scheitelpunkt interaktiv entfernt, d. h. **-data-cmd**.


# Optionen

Der Befehl „class“ akzeptiert die folgenden Optionen

**-convex** *boolean*
: Der Wert dieser Option ist ein boolescher Schalter. Wenn das Flag gesetzt ist, akzeptiert der Editor ausschließlich konvexe Vierecke und lehnt alle Operationen ab, die zu einer Verletzung der Konvexität führen würden.

    Diese Option kann nur bei der Erstellung festgelegt werden.

    Wird sie nicht angegeben, gilt standardmäßig der Wert **false**, d. h. es werden alle Vierecke akzeptiert.

**-tag** *string*
: Der Wert dieser Option ist der Name des Canvas-Tags, mit dem alle Elemente aller vom Editor verwalteten Vierecke identifiziert werden sollen.

    Diese Option kann nur bei der Erstellung festgelegt werden.

    Wird sie nicht angegeben, lautet der Standardwert „**QUADRILATERAL**“.

**-create-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn er einen neuen Scheitelpunkt erstellen muss.

    Diese Option kann nur bei der Erstellung festgelegt werden.

    Wird kein Wert angegeben, wird standardmäßig ein Befehl verwendet, der einen blauen Kreis mit schwarzem Rahmen und einem Radius von 3 erstellt, dessen Mittelpunkt an der Position des neuen Punktes liegt.

    Die Signatur dieses Befehlspräfixes lautet

    **createCmd** *canvas* *x* *y*
    : Das Ergebnis des Befehlspräfixes *muss* eine Liste der Canvas-Elemente sein, die es zur Darstellung des Markers erstellt hat. Beachten Sie hierbei, dass die visuelle Darstellung eines „Eckpunkts“ aus mehreren Canvas-Elementen in beliebiger Form bestehen kann.


**-highlight-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn er einen Eckpunkt hervorheben oder die Hervorhebung aufheben muss.

    Diese Option kann nur bei der Erstellung festgelegt werden.

    Wird sie nicht angegeben, wird standardmäßig ein Befehl verwendet, der das zu markierende Element rot einfärbt (und die Farbe beim Aufheben der Markierung wiederherstellt).

    Die beiden Signaturen dieses Befehlspräfixes lauten

    **highlightCmd** **on** *canvas* *item*
    : Diese Methode des Befehlspräfixes muss alle erforderlichen Schritte ausführen, um den Scheitelpunkt hervorzuheben, zu dem das *item* gehört (beachten Sie dabei den obigen Hinweis, dass ein Viereck aus mehreren Canvas-Elementen zusammengesetzt sein darf).

        Das Ergebnis des Befehls kann beliebig sein und wird unverändert als Argument *state* an die Methode **off** übergeben.

    **highlightCmd** **off** *canvas* *state*
    : Diese Methode wird aufgerufen, um die Hervorhebung eines durch den *state* beschriebenen Eckpunkts aufzuheben, wobei es sich um das unveränderte Ergebnis der Methode **on** des Befehlspräfixes handelt. Das Ergebnis dieser Methode wird ignoriert.

        Beachten Sie, dass jegliche Interaktion zwischen dem Ziehen und der Hervorhebung eines Vierecks innerhalb des Editors abgewickelt wird und dass die Rückruffunktion hierfür keine Verantwortung trägt.


**-data-cmd** *command-prefix*
: Der Wert dieser Option ist ein Befehlspräfix, das der Editor aufruft, wenn das Viereck in irgendeiner Weise bearbeitet wurde. Auf diese Weise leitet der Editor die eigentliche Speicherung der Viereckdaten an ein externes Objekt weiter.

    Diese Option kann nur bei der Erstellung festgelegt werden.

    Wird sie nicht angegeben, ist der Standardwert eine leere Zeichenkette, und sie wird vom Editor ignoriert, d. h., nicht aufgerufen.

    Die Signaturen dieses Befehlspräfixes lauten

    **dataCmd** *editorObj* *coordinates*
    : Diese Rückruffunktion wird aufgerufen, wenn das Viereck entweder interaktiv oder programmgesteuert geändert wurde. Informationen zu letzterem finden Sie in der Instanzmethode **add**.

        Das *editorObj* identifiziert die Instanz, die die Rückruffunktion aufruft, während *coordinates* eine Liste von Eckpunktpositionen ist, wobei jede Position aus einem Paar von x- und y-Koordinaten besteht.

        Das Ergebnis dieser Methode wird ignoriert.



# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
