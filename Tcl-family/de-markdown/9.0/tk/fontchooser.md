---
CommandName: fontchooser
title: fontchooser
ManualSection: n
Version: unknown
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - font(n)
 - tk(n)
Keywords:
 - dialog
 - font
 - font selection
 - font chooser
 - font panel
Copyright:
 - Copyright (c) 2008 Daniel A. Steffen <das@users.sourceforge.net>
---

# Name

fontchooser - Schriftauswahl-Dialog steuern

# Übersicht

::: {.synopsis} :::
[tk]{.cmd} [fontchooser]{.sub} [configure]{.lit} [-option value]{.optdot}
[tk]{.cmd} [fontchooser]{.sub} [show]{.lit}
[tk]{.cmd} [fontchooser]{.sub} [hide]{.lit}
:::

# Beschreibung

Der Befehl [tk fontchooser][tk] steuert den Tk-Schriftauswahl-Dialog. Wo verfügbar, wird der native plattformspezifische Schriftauswahl-Dialog verwendet, andernfalls ein in Tcl implementierter Dialog.

Im Gegensatz zu den meisten anderen Tk-Dialogbefehlen liefert [tk fontchooser][tk] kein unmittelbares Ergebnis zurück, da auf manchen Plattformen (macOS) der Standardschriftdialog modellos ist, auf anderen (Windows) modal. Um diesen Unterschied auszugleichen, wird die gesamte Benutzerinteraktion mit dem Dialog dem Aufrufer über Rückruffunktionen oder virtuelle Ereignisse mitgeteilt.

Der Befehl [tk fontchooser][tk] kann eine der folgenden Formen haben:

[tk]{.cmd} [fontchooser]{.sub} [configure]{.lit} [-option value]{.optdot}
: Legt eine oder mehrere der unten stehenden Konfigurationsoptionen fest oder fragt sie ab (analog zur Widget-Konfiguration in Tk).

[tk]{.cmd} [fontchooser]{.sub} [show]{.lit}
: Zeigt den Schriftauswahl-Dialog an. Je nach Plattform kann der Befehl sofort zurückkehren oder erst, wenn der Dialog geschlossen wurde.

[tk]{.cmd} [fontchooser]{.sub} [hide]{.lit}
: Blendet den Schriftauswahl-Dialog aus, falls er sichtbar ist, und bewirkt, dass ein ausstehender [tk fontchooser][tk] **show**-Befehl zurückkehrt.


# Konfigurationsoptionen

[-parent]{.lit}
: Legt fest bzw. gibt das logische Elternfenster des Schriftauswahl-Dialogs zurück (ähnlich der Option **-parent** anderer Dialoge). Der Schriftauswahl-Dialog wird ausgeblendet, wenn er sichtbar ist und das Elternfenster zerstört wird.

[-title]{.lit}
: Legt fest bzw. gibt den Dialogtitel zurück. Hat auf Plattformen keine Wirkung, deren Schriftauswahl-Dialog keine Titel unterstützt.

[-font]{.lit}
: Legt fest bzw. gibt die im Dialog aktuell ausgewählte Schriftart zurück, wenn er sichtbar ist, oder die beim Anzeigen des Dialogs zunächst ausgewählte Schriftart (falls von der Plattform unterstützt). Kann auf den leeren String gesetzt werden, um anzuzeigen, dass keine Schriftart ausgewählt sein soll. Schriftarten können in jeder im Abschnitt „SCHRIFTART-BESCHREIBUNG“ der Manpage [font] beschriebenen Form angegeben werden.

[-command]{.lit}
: Legt fest bzw. gibt das Befehlspräfix zurück, das aufgerufen wird, wenn der Benutzer eine Schriftart gewählt hat. Das Präfix wird auf globaler Ebene ausgewertet, nachdem die Spezifikation der gewählten Schriftart angehängt wurde. Auf Plattformen, deren Schriftauswahl-Dialog weitere Schriftattribute (z. B. Farbe) anbietet, können vor der Auswertung zusätzliche Schlüssel/Wert-Paare angehängt werden. Kann auf den leeren String gesetzt werden, um anzuzeigen, dass keine Rückruffunktion aufgerufen werden soll. Schriftarten werden als Liste der Form aus Abschnitt \[3\] „SCHRIFTART-BESCHREIBUNG“ in der Manpage [font] angegeben (d. h. eine Liste der Form *{family size style ?style ...?}*).

[-visible]{.lit}
: Schreibgeschützte Option; gibt einen booleschen Wert zurück, ob der Schriftauswahl-Dialog derzeit sichtbar ist. Ein Versuch, diese Option zu setzen, führt zu einem Fehler.


# Virtuelle Ereignisse

**<<TkFontchooserVisibility>>**
: Wird an das Dialog-Elternfenster gesendet, wenn sich die Sichtbarkeit des Schriftauswahl-Dialogs ändert — sowohl durch Benutzeraktion (z. B. Schließen über OK/Abbrechen oder Schließen-Kästchen) als auch durch [tk fontchooser][tk] **show**/**hide**. Bindungs-Skripte können die aktuelle Sichtbarkeit über die Konfigurationsoption **-visible** ermitteln.

**<<TkFontchooserFontChanged>>**
: Wird an das Dialog-Elternfenster gesendet, wenn der Schriftauswahl-Dialog sichtbar ist und sich die gewählte Schriftart ändert — sowohl durch Benutzeraktion als auch durch Setzen der Option **-font**. Bindungs-Skripte können die aktuell gewählte Schriftart über die Konfigurationsoption **-font** ermitteln.


# Hinweise

Aufrufer sollten von [tk fontchooser][tk] **show** kein Ergebnis erwarten und dürfen nicht annehmen, dass der Dialog beim Zurückkehren des Befehls bereits geschlossen wurde. Die gesamte Benutzerinteraktion mit dem Dialog erfolgt über die Rückruffunktion **-command** und die virtuellen Ereignisse **<<TkFontchooser\*>>**. Welche Benutzeraktionen genau die Rückruffunktion bzw. die virtuellen Ereignisse auslösen, ist implementierungsabhängig. Ist im Dialog eine Schaltfläche „Übernehmen“ oder „OK“ vorhanden, löst diese die Rückruffunktion **-command** und das virtuelle Ereignis **<<TkFontchooserFontChanged>>** aus. In manchen Implementierungen können auch andere Benutzeraktionen dies bewirken; unter macOS spiegelt der Standardschriftauswahl-Dialog alle Benutzerentscheidungen unmittelbar an den Aufrufer wider.

Wenn mehrere Widgets vom Schriftauswahl-Dialog beeinflusst werden sollen, muss der Fokuswechsel korrekt behandelt werden: Die im Dialog gewählte Schriftart soll stets der aktuellen Schriftart des Widgets mit Fokus entsprechen, und die Rückruffunktion **-command** soll nur auf das Widget mit Fokus wirken. Empfohlen wird, die Konfigurationsoptionen **-font** und **-command** des Schriftdialogs in **<FocusIn>**-Handlern pro Widget zu setzen (und bei Bedarf in entsprechenden **<FocusOut>**-Handlern zurückzusetzen — d. h. auf den leeren String). Das ist besonders wichtig für Bibliotheksautoren, die den Schriftauswahl-Dialog nutzen, um Konflikte mit Anwendungscode zu vermeiden, der denselben Dialog ebenfalls verwenden möchte.

Da der Schriftauswahl-Dialog anwendungsweit global ist, wird bei mehreren Interpretern, die [tk fontchooser][tk] aufrufen, nur die **-command**-Rückruffunktion des Interpreters aufgerufen, der zuletzt [tk fontchooser][tk] **configure** oder [tk fontchooser][tk] **show** aufgerufen hat; nur das von diesem Interpreter gesetzte **-parent** erhält die virtuellen Ereignisse **<<TkFontchooser\*>>**.

Die Schriftdialog-Implementierung speichert und liefert unter Umständen nur [font] **actual**-Daten als Wert der Konfigurationsoption **-font**. Das kann problematisch sein, wenn **-font** auf eine benannte Schriftart gesetzt wird und diese später geändert wird: Die Option **-font** des Schriftdialogs muss erneut gesetzt werden, damit die gewählte Schriftart dem neuen Wert der benannten Schriftart entspricht.

# Beispiel

```
proc fontchooserDemo {} {
    wm title . "Font Chooser Demo"
    tk fontchooser configure -parent .
    button .b -command fontchooserToggle -takefocus 0
    fontchooserVisibility .b
    bind . <<TkFontchooserVisibility>> \
            [list fontchooserVisibility .b]
    foreach w {.t1 .t2} {
        text $w -width 20 -height 4 -borderwidth 1 -relief solid
        bind $w <FocusIn> [list fontchooserFocus $w]
        $w insert end "Text Widget $w"
    }
    .t1 configure -font {Courier 14}
    .t2 configure -font {Times 16}
    pack .b .t1 .t2; focus .t1
}
proc fontchooserToggle {} {
    tk fontchooser [expr {
            [tk fontchooser configure -visible] ?
            "hide" : "show"}]
}
proc fontchooserVisibility {w} {
    $w configure -text [expr {
            [tk fontchooser configure -visible] ?
            "Hide Font Dialog" : "Show Font Dialog"}]
}
proc fontchooserFocus {w} {
    tk fontchooser configure -font [$w cget -font] \
            -command [list fontchooserFontSelection $w]
}
proc fontchooserFontSelection {w font args} {
    $w configure -font [font actual $font]
}
fontchooserDemo
```


[font]: font.md
[tk]: tk.md
