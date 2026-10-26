---
CommandName: widget_validator
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: widget::validator behaviour
Keywords:
 - invalid
 - state management
 - ttk::combobox
 - ttk::entry
 - validation
 - widget validation
Copyright:
---

# NAME

widget_validator – Verhalten von widget::validator

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [widget::validator]{.lit} [0.1]{.optlit} 
[widget::validator]{.cmd} [attach]{.sub} [w]{.arg} [color]{.arg} [cmdprefix]{.arg} 
[widget::validator]{.cmd} [detach]{.sub} [w]{.arg} 
[widget::validator]{.cmd} [validate]{.sub} [w]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine einheitliche Validierungs-API für die Widgets Entry und Combobox von **ttk** bereit.

Das hier festgelegte Validierungsverhalten weist ungültige Bearbeitungen nicht zurück. Es hebt nur das Entry mit den ungültigen Daten hervor und setzt das passende Zustandsflag.

Es liegt in der Verantwortung des verwendenden Pakets oder der Anwendung, zu entscheiden, wie und wann solche ungültigen Inhalte tatsächlich zurückgewiesen werden sollen.

**widget::validator** **attach** *w* *color* *cmdprefix*
: Diese Methode fügt dem Widget *w* ein Verhalten zur Validierung hinzu. Immer wenn sich der Inhalt des Eingabefelds des Widgets ändert, wird das angegebene *cmdprefix* aufgerufen und muss einen booleschen Wert geben, wobei **true** bedeutet, dass der Inhalt in Ordnung ist, und **false**, dass der Inhalt ungültig ist. Zum Befehlspräfix siehe den Abschnitt **VALIDIERUNG**. Im letzteren Fall wird die Hintergrundfarbe des Eingabefeldes in *color* geändert, um die Ungültigkeit anzuzeigen. Das System unterstützt weder die Verschachtelung von Validatoren auf einem Widget noch das Anhängen mehrerer Validatoren. Zum Ändern der Bedingungen zuerst den aktuellen Validator mit **detach** lösen und dann den neuen anhängen. Es wird ein Fehler ausgelöst, wenn dem Widget bereits ein Validierungsverhalten zugewiesen ist. Das Ergebnis der Methode ist die leere Zeichenkette. Um seine Ziele zu erreichen, überschreibt das Paket verschiedene Konfigurationsoptionen des Widgets, an das das Verhalten angehängt wird. Diese Optionen werden bei **detach** auf ihre vorherigen Werte zurückgesetzt. Wenn andere Verhaltensweisen zugeordnet sind, kann der Validator vorübergehend (teilweise) funktionsunfähig werden. Ebenso kann bei einer Trennung des Validators, während gleichzeitig eine andere Verhaltensweise zugeordnet ist, die Wiederherstellung der Konfiguration dazu führen, dass die andere Verhaltensweise funktionsunfähig wird.

**widget::validator** **detach** *w*
: Diese Methode entfernt das Validierungsverhalten aus dem Widget *w* und versetzt es in seinen ursprünglichen Zustand zurück. Es wird ein Fehler ausgelöst, wenn dem Widget kein Validierungsverhalten zugeordnet ist. Das Ergebnis der Methode ist die leere Zeichenkette.

**widget::validator** **validate** *w*
: Der Aufruf dieser Methode erzwingt eine Validierung des Widgets *w*, vorausgesetzt, diesem ist ein Validator-Verhalten zugeordnet. Das Ergebnis der Methode ist die leere Zeichenkette.


# VALIDIERUNG

Der für die Validierung verwendete Befehls-Präfix muss die folgende Signatur aufweisen:

{\*}*cmdprefix* *text*
: Das Argument ist der zu prüfende Text. Das Ergebnis des Rückrufs muss ein boolescher Wert sein. **true** bedeutet, dass *text* in Ordnung ist, **false**, dass *text* ungültig ist.


# BEISPIEL

```
package require Tk 8.5
package require widget::validator

set TE {}
set TC {}

ttk::entry    .e -textvariable TE
ttk::combobox .c -textvariable TC -values {fruit vegetable corn}
ttk::combobox .n -values {fruit vegetable corn}
ttk::button   .x -command ::exit -text Exit

pack .e -expand 1 -fill both -side top
pack .c -expand 1 -fill both -side top
pack .n -expand 1 -fill both -side top
pack .x -expand 1 -fill both -side top

widget::validator attach .e lightblue {apply {text {
    expr {$text ne {}}
}}}

widget::validator attach .c yellow {apply {text {
    expr {$text ni {{} hello world}}
}}}

widget::validator attach .n pink {apply {text {
    expr {$text ni {{} blub}}
}}}
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *widget::validator* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
