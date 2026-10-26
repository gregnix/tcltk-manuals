---
CommandName: javascript
title: javascript
ManualSection: n
Version: 1.0.3
TclPart: tcllib
TclDescription: HTML and Java Script Generation
Links:
 - html
 - ncgi
Keywords:
 - checkbox
 - html
 - javascript
 - selectionbox
 - submitbutton
Copyright:
---

# Name

javascript – Prozeduren zur Erzeugung von HTML- und JavaScript-Strukturen.

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [javascript]{.lit} [1.0.3]{.optlit}
[::javascript::makeSelectorWidget]{.cmd} [id]{.arg} [leftLabel]{.arg} [leftValueList]{.arg} [rightLabel]{.arg} [rightValueList]{.arg} [rightNameList]{.arg} [length]{.optarg} [minWidth]{.optarg}
[::javascript::makeSubmitButton]{.cmd} [name]{.arg} [value]{.arg}
[::javascript::makeProtectedSubmitButton]{.cmd} [name]{.arg} [value]{.arg} [msg]{.arg}
[::javascript::makeMasterButton]{.cmd} [master]{.arg} [value]{.arg} [slavePattern]{.arg} [boolean]{.arg}
[::javascript::makeParentCheckbox]{.cmd} [parentName]{.arg} [childName]{.arg}
[::javascript::makeChildCheckbox]{.cmd} [parentName]{.arg} [childName]{.arg}
:::

# Beschreibung

Das Paket **::javascript** stellt Befehle bereit, die HTML- und JavaScript-Code erzeugen. Diese Befehle geben üblicherweise eine HTML-Zeichenkette zurück. Insbesondere schreiben sie ihr Ergebnis nicht nach **stdout**.

**::javascript::makeSelectorWidget** *id leftLabel leftValueList rightLabel rightValueList rightNameList* ?*length*? ?*minWidth*?
: Erzeugt HTML-Code für ein Megawidget mit zwei Mehrfachauswahlen. Es besteht aus zwei nebeneinander stehenden Mehrfachauswahlfeldern, getrennt durch eine Schaltfläche mit Pfeil nach links und eine mit Pfeil nach rechts. Die Schaltfläche mit dem Pfeil nach rechts verschiebt alle im linken Feld ausgewählten Elemente in das rechte Feld. Die Schaltfläche mit dem Pfeil nach links verschiebt alle im rechten Feld ausgewählten Elemente in das linke Feld. Das Argument *id* ist das Suffix aller HTML-Objekte dieses Megawidgets. Das Argument *leftLabel* ist der Text über dem linken Auswahlfeld. Das Argument *leftValueList* enthält die Werte der Elemente im linken Auswahlfeld. Das Argument *leftNameList* enthält die Namen, die im linken Auswahlfeld erscheinen. Das Argument *rightLabel* ist der Text über dem rechten Auswahlfeld. Das Argument *rightValueList* enthält die Werte der Elemente im rechten Auswahlfeld. Das Argument *rightNameList* enthält die Namen, die im rechten Auswahlfeld erscheinen. Das Argument *length* (optional) legt fest, wie viele Elemente gezeigt werden, bevor eine senkrechte Bildlaufleiste hinzukommt; die Vorgabe ist 8. Das Argument *minWidth* (optional) ist die Anzahl der Leerzeichen für die Mindestbreite des Feldes; die Vorgabe ist 32.

**::javascript::makeSubmitButton** *name value*
: Erzeugt eine HTML-Schaltfläche zum Absenden, die für jedes registrierte Mehrfachauswahlfeld ein verstecktes Feld zurücksetzt. Das Argument *name* ist der Name des HTML-Schaltflächenobjekts. Das Argument *value* ist die Beschriftung des HTML-Schaltflächenobjekts.

**::javascript::makeProtectedSubmitButton** *name value msg*
: Erzeugt eine HTML-Schaltfläche zum Absenden, die den Benutzer vor dem Absenden des Formulars mit einer Rückfrage (Weiter/Abbrechen) warnt. Das Argument *name* ist der Name des HTML-Schaltflächenobjekts. Das Argument *value* ist die Beschriftung des HTML-Schaltflächenobjekts. Das Argument *msg* ist die Meldung, die beim Drücken der Schaltfläche erscheint.

**::javascript::makeMasterButton** *master value slavePattern boolean*
: Erzeugt eine HTML-Schaltfläche, die ihre untergeordneten Kontrollkästchen auf den booleschen Wert setzt. Das Argument *master* ist der Name des übergeordneten HTML-Kontrollkästchens des Kindes. Das Argument *value* ist der Wert des Masters. Das Argument *slaves* ist der Name des zu erzeugenden untergeordneten HTML-Kontrollkästchens. Das Argument *boolean* ist der boolesche JavaScript-Wert für alle untergeordneten Kontrollkästchen; er muss "true" oder "false" sein.

**::javascript::makeParentCheckbox** *parentName childName*
: Erzeugt ein HTML-Kontrollkästchen und koppelt seinen Wert an den des untergeordneten Kontrollkästchens. Ist das übergeordnete nicht markiert, wird das untergeordnete ebenfalls nicht markiert. Das Argument *parentName* ist der Name des zu erzeugenden übergeordneten HTML-Kontrollkästchens. Das Argument *childName* ist der Name des untergeordneten HTML-Kontrollkästchens.

**::javascript::makeChildCheckbox** *parentName childName*
: Erzeugt ein HTML-Kontrollkästchen und koppelt seinen Wert an den des übergeordneten Kontrollkästchens. Ist das untergeordnete markiert, wird das übergeordnete ebenfalls markiert. Das Argument *parentName* ist der Name des übergeordneten HTML-Kontrollkästchens. Das Argument *childName* ist der Name des zu erzeugenden untergeordneten HTML-Kontrollkästchens.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *javascript* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

CGI-Programmierung
