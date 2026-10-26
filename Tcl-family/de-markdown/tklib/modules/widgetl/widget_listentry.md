---
CommandName: widget_listentry
ManualSection: n
Version: 0.1.2
TclPart: tklib
TclDescription: widget::listentry widget
Keywords:
 - data entry lists
 - data entry ordered list
 - data entry set of strings
 - data entry unordered list
 - list entry panel
 - set entry panel
 - widget
Copyright:
---

# NAME

widget_listentry – widget::listentry-Widget

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [widget::listentry]{.lit} [0.1.2]{.optlit} 
[package]{.cmd} [require]{.sub} [widget::validator]{.lit} [0.1]{.optlit} 
[package]{.cmd} [require]{.sub} [widget::scrolledwindow]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [tooltip]{.lit} 
[package]{.cmd} [require]{.sub} [img::png]{.lit} 
[package]{.cmd} [require]{.sub} [msgcat]{.lit} 
[widget::listentry]{.cmd} [pathname]{.arg} [options]{.optarg} 
[widgetCmd]{.cmd} [destroy]{.sub} 
[widgetCmd]{.cmd} [configure]{.sub} 
[widgetCmd]{.cmd} [configure]{.sub} [option]{.arg} [value]{.arg} ... 
[widgetCmd]{.cmd} [configure]{.sub} [option]{.arg} 
[widgetCmd]{.cmd} [cget]{.sub} [option]{.arg} 
:::

*{\*}cmdprefix* **get**

*{\*}cmdprefix* **set** *values*

*{\*}cmdprefix* *text* *errvar*

*{\*}cmdprefix* *text*

*{\*}cmdprefix* *cookievar*

# BESCHREIBUNG

Dieses Paket stellt ein Megawidget zur interaktiven Eingabe geordneter und ungeordneter Listen bereit. Ein einfacheres, enger gefasstes Megawidget ist das Paket **widget::listsimple**.

# API FÜR KLASSEN

Die Widget-Klasse unterstützt einen einzigen Befehl zur Erstellung von Widgets.

**widget::listentry** *pathname* ?options?
: Dieser Befehl erstellt und konfiguriert neue Instanzen des Widgets. Einzelheiten zu den verfügbaren Optionen finden Sie im Abschnitt **WIDGET-OPTIONEN**. Das Ergebnis des Befehls ist der Pfadname des neuen Widgets.


# INSTANZ-API

Alle Widget-Instanzen unterstützen die folgenden Methoden.

**widgetCmd** **destroy**
: Diese Methode löscht das Widget. Jeder weitere Zugriff auf das Widget führt zu Fehlern. Das Ergebnis des Befehls ist die leere Zeichenkette.

**widgetCmd** **configure**
: Diese Methode gibt es in drei Varianten. Diese Variante gibt eine Liste zurück, die die aktuelle Konfiguration des Widgets enthält, d. h. die Werte für alle Optionen. Einzelheiten zu den verfügbaren Optionen finden Sie im Abschnitt **WIDGET-OPTIONEN**.

**widgetCmd** **configure** *option* *value* ...
: Diese Methode gibt es in drei Varianten. Diese Variante konfiguriert das Widget neu und setzt die angegebenen Optionen auf die angegebenen Werte. *Hinweis*: Es ist nicht möglich, Optionen zu ändern, die ausschließlich zur Erstellungszeit gelten. Einzelheiten zu den verfügbaren Optionen finden Sie im Abschnitt **Allgemeine Optionen für Widgets**. Das Ergebnis des Befehls ist die leere Zeichenkette.

**widgetCmd** **configure** *option*
: Diese Methode gibt es in drei Varianten. Die vorliegende Variante ist ein Alias für die unten aufgeführte Methode **cget** und mit dieser identisch.

**widgetCmd** **cget** *option*
: Diese Methode gibt den aktuellen Wert der angegebenen *option* zurück. Einzelheiten zu den verfügbaren Optionen finden Sie im Abschnitt **WIDGET-OPTIONEN**.


# WIDGET-OPTIONEN

In diesem Abschnitt werden alle Optionen erläutert, die für Instanzen von **widget::listentry** verfügbar sind. Beachten Sie, dass einige der Optionen nur bei der Erstellung der Instanz festgelegt werden können. Die meisten Optionen können jedoch sowohl bei der Erstellung als auch zur Laufzeit festgelegt werden.

## Optionen, die ausschließlich zur Erstellungszeit des Widgets gelten

**-ordered** boolean
: Diese Option sagt der neuen Instanz, ob die Liste geordnet ist. Ist sie geordnet, zeigt das Widget Schaltflächen, mit denen sich die ausgewählten Einträge verschieben lassen. Voreingestellt ist **false**, eine ungeordnete Liste.

**-allow-duplicates** boolean
: Diese Option legt fest, ob die neue Widget-Instanz eine Zeichenfolge mehrfach zur Liste hinzufügen darf oder nicht. Die Standardeinstellung ist **false**, was bedeutet, dass Duplikate nicht zulässig sind.

**-values** cmdprefix
: Diese Option legt eine Rückruffunktion für die Verwaltung einer vordefinierten Liste von Zeichenfolgen fest, die ein Benutzer eingeben kann. Wenn diese Option angegeben wird, verwendet das Widget anstelle eines einfachen Eingabefeldes eine Combobox und füllt deren Liste während der Erstellung des Widgets mit den von dieser Rückruffunktion gelieferten Daten. Die Rückruffunktion wird zudem jedes Mal aufgerufen, wenn ein neuer Wert in die Hauptliste eingegeben wird, um die erweiterte Liste der vordefinierten Werte zu speichern. Die Signatur dieser Rückruffunktion lautet


*{\*}cmdprefix* **get**
: In dieser Form soll die Rückruffunktion eine Liste von Zeichenfolgen geben. Die Zeichenfolgen werden in die Liste der internen Combobox geladen, um dem Benutzer einen schnellen Zugriff zu ermöglichen. Die Funktion wird einmalig während der Erstellung des Widgets aufgerufen, um die Liste der vordefinierten Zeichenfolgen zu laden, die ein Benutzer eingeben kann.

*{\*}cmdprefix* **set** *values*
: In dieser Form erhält die Rückruffunktion eine Liste neuer Zeichenfolgen und soll diese für die spätere Verwendung an einem Ort speichern. Der Rückgabewert der Rückruffunktion wird ignoriert. Diese Form wird immer dann aufgerufen, wenn der Benutzer eine neue Zeichenfolge in die Hauptliste eingegeben hat. Die Reihenfolge der Zeichenfolgen in *values* entspricht der Reihenfolge, in der sie in der Liste der Combobox angezeigt werden.


**-validate** cmdprefix
: Diese Option legt eine Rückruffunktion fest, die nach jeder Änderung des Inhalts des internen Eingabefelds aufgerufen wird. Die Signatur dieser Rückruffunktion lautet


*{\*}cmdprefix* *text* *errvar*
: wobei *text* die zu validierende Zeichenkette und *errvar* der Name einer Variablen ist, in der die Rückruffunktion eine Fehlermeldung speichern kann, wenn sie ungültige Daten feststellt. Das Widget erwartet, dass die Rückruffunktion einen booleschen Wert gibt, wobei **true** angibt, dass *text* gültig ist.


: Die Standardvalidierung behandelt – sofern keine Rückruffunktion festgelegt wurde – eine leere Zeichenkette als ungültig und alle anderen Eingaben als gültig. *Bitte beachten Sie*, dass das Widget die Eingabe doppelter Werte in die Hauptliste verhindert, unabhängig von der ansonsten bestehenden Gültigkeit der Eingabe. Dies steht im Einklang mit der Tatsache, dass dieses Widget für die Eingabe ungeordneter Listen vorgesehen ist, also im Wesentlichen für eine Reihe von Zeichenfolgen.


**-transform** cmdprefix
: Diese Option legt eine Rückruffunktion fest, die immer dann aufgerufen wird, wenn ein neu eingegebenes Element aus dem Eingabefeld in die Hauptliste verschoben wird oder wenn das Eingabefeld im Rahmen einer Duplikatsprüfung validiert wird, sofern Duplikate nicht zulässig sind. Die Rückruffunktion erhält den Text aus dem Eingabefeld und muss den Text geben, der tatsächlich zur Liste hinzugefügt oder mit dieser abgeglichen wird. Der Anwendungsfall für diese Rückruffunktion ist im Wesentlichen die *Eingabenormalisierung*. Der einfachste Fall hierfür wäre beispielsweise die Verwendung von


```
string tolower
```

**um eine einheitliche Schreibung**
: der Daten durchzusetzen. Weitere Beispiele sind denkbar, etwa mehrere Eingabeformen auf eine kanonische Form zu bringen. Die Signatur dieser Rückruffunktion lautet


*{\*}cmdprefix* *text*
: wobei *text* die zu transformierende Zeichenkette ist. Das Widget erwartet, dass die Rückruffunktion die transformierte Zeichenkette zurückgibt.


Standardmäßig wird keine Transformation der eingegebenen Zeichenfolgen durchgeführt.

**-browse** cmdprefix
: Ist diese Option angegeben, zeigt das Widget eine Schaltfläche „Search“ und ruft die Rückruffunktion auf, wenn diese Schaltfläche geklickt wird. Die Signatur lautet


*{\*}cmdprefix* *cookievar*
: wobei die Cookie-Variable Zugriff auf Kontextinformationen bietet, die die Rückruffunktion möglicherweise zwischen den Aufrufen beibehalten möchte. Der in der Variablen gespeicherte Anfangswert ist die leere Zeichenkette. Danach enthält sie alles, was die Rückruffunktion speichern möchte. Das Widget erwartet, dass die Rückruffunktion eine Liste von Zeichenketten gibt, die dann – vorbehaltlich Validierung und Duplikatsprüfungen – der Liste hinzugefügt werden.


Voreingestellt gibt es keine Browse-Rückruffunktion und keine Schaltfläche.

## Allgemeine Optionen für Widgets

**-listvariable** varname
: Diese Option legt die Variable fest, die die Liste enthält, die vom Widget bearbeitet werden soll. Alle Änderungen an der Liste, die außerhalb des Widgets vorgenommen werden, werden automatisch in das Widget übernommen. Ebenso werden alle Änderungen, die das Widget an der Liste vornimmt, automatisch in diese Variable exportiert.

**-state** normal|disabled
: Zustand des Widgets, **normal**, also aktiv, oder **disabled**. Ein deaktiviertes Widget lässt sich nicht bearbeiten. Voreingestellt ist **normal**.

**-height** integer
: Höhe der internen Listbox, in Zeilen. Voreingestellt ist **20**.

**-skin-add** string
: ...siehe nächstes...

**-skin-remove** string
: ...siehe nächstes...

**-skin-up** string
: ...siehe nächstes...

**-skin-down** string
: ...siehe nächstes...

**-skin-browse** string
: ...siehe nächstes...

**-skin-tip-add** string
: ...siehe nächstes...

**-skin-tip-remove** string
: ...siehe nächstes...

**-skin-tip-up** string
: ...siehe nächstes...

**-skin-tip-down** string
: ...siehe nächstes...

**-skin-tip-browse** string
: ...siehe nächstes...

**-skin-tip-main** string
: ...siehe nächstes...

**-skin-tip-entry** string
: ...siehe nächstes...

**-skin-tip-list** string
: ...siehe nächstes...

**-skin-tip-empty** string
: ...siehe nächstes...

**-skin-tip-duplicate** string
: ...siehe nächstes...

**-skin-tip-add-none** string
: ...siehe nächstes...

**-skin-tip-remove-none** string
: ...siehe nächstes...

**-skin-img-add** image
: ...siehe nächstes...

**-skin-img-remove** image
: ...siehe nächstes...

**-skin-img-up** string
: ...siehe nächstes...

**-skin-img-down** string
: ...siehe nächstes...

**-skin-img-browse** string
: ...siehe nächstes...

**-skin-invalid-color** color
: Diese Optionen ändern alle das Erscheinungsbild des Widgets, d. h. dessen Skin. Alle Optionen, die ein Zeichenfolgenargument entgegennehmen, beeinflussen die verschiedenen angezeigten Beschriftungen, wobei insbesondere die Optionen vom Typ **-skin-tip-\*** die Tooltips beeinflussen, die beim Bewegen des Mauszeigers über verschiedene Bereiche angezeigt werden. Alle Zeichenfolgen werden zunächst durch **msgcat** geleitet, wodurch die Lokalisierung von Text über Meldungskataloge ermöglicht wird. Die Standardwerte sind Schlüssel in den Meldungskatalogen, die Teil des Pakets selbst sind. Die Optionen, die Bilder als Argument annehmen, ändern die Bilder, die auf den Schaltflächen zum Hinzufügen und Entfernen von Elementen der Liste angezeigt werden. Standardmäßig werden die mit dem Paket selbst ausgelieferten PNG-Bilder verwendet. Die einzige Option, die einen Farbwert akzeptiert, ändert die Farbe, mit der ungültige Daten hervorgehoben werden, die in das interne Eingabefeld des Widgets eingegeben wurden. Diese Option ist standardmäßig auf **yellow** gesetzt.


# BEISPIEL

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *widget::listentry* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
