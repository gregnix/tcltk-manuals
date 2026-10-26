---
CommandName: tk_messageBox
title: tk_messageBox
ManualSection: n
Version: 4.2
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - message box
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
---

# Name

tk\_messageBox - Blendet ein Meldungsfenster ein und wartet auf die Benutzerantwort

# Übersicht

::: {.synopsis} :::
[tk\_messageBox]{.cmd} [option value]{.optdot}
:::

# Beschreibung

Diese Prozedur erstellt und zeigt ein Meldungsfenster mit einer anwendungsspezifischen Nachricht, einem Symbol und einer Menge von Buttons. Jeder Button im Meldungsfenster wird durch einen eindeutigen symbolischen Namen identifiziert (siehe die Option **-type**). Nach dem Einblenden wartet **tk\_messageBox**, bis der Benutzer einen der Buttons wählt. Anschließend gibt sie den symbolischen Namen des gewählten Buttons zurück.

Die folgenden Option-Wert-Paare werden unterstützt:

**-command** *string*
: Legt das Präfix eines Tcl-Befehls fest, der aufgerufen wird, wenn der Benutzer den Dialog schließt. Der tatsächliche Befehl besteht aus *string*, gefolgt von einem Leerzeichen und dem Namen des Buttons, mit dem der Benutzer den Dialog geschlossen hat. Nur unter macOS verfügbar.

**-default** *name*
: *name* gibt den symbolischen Namen des Standard-Buttons für dieses Meldungsfenster an („ok“, „cancel“ usw.). Eine Liste der symbolischen Namen siehe **-type**. Ist diese Option nicht angegeben, wird der erste Button im Dialog zum Standard.

**-detail** *string*
: Legt eine Zusatznachricht zur Hauptnachricht der Option **-message** fest. Die Detailnachricht wird unter der Hauptnachricht angezeigt und — wo das Betriebssystem es unterstützt — in einer weniger betonten Schriftart als die Hauptnachricht.

**-icon** *iconImage*
: Legt ein anzuzeigendes Symbol fest. *iconImage* muss einer der folgenden Werte sein: **error**, **info**, **question** oder **warning**. Ist diese Option nicht angegeben, wird das Info-Symbol angezeigt.

**-message** *string*
: Legt die in dieser Meldungsbox anzuzeigende Nachricht fest. Standard ist ein leerer String.

**-parent** *window*
: Macht *window* zum logischen Elternfenster der Meldungsbox. Die Meldungsbox wird über ihrem Elternfenster angezeigt.

**-title** *titleString*
: Legt einen String als Titel der Meldungsbox fest. Standard ist ein leerer String.

**-type** *predefinedType*
: Ordnet eine vordefinierte Menge von Buttons an. Folgende Werte sind für *predefinedType* möglich:

    **abortretryignore**
    : Zeigt drei Buttons mit den symbolischen Namen **abort**, **retry** und **ignore**.

    **ok**
    : Zeigt einen Button mit dem symbolischen Namen **ok**. Das ist der Standard.

    **okcancel**
    : Zeigt zwei Buttons mit den symbolischen Namen **ok** und **cancel**.

    **retrycancel**
    : Zeigt zwei Buttons mit den symbolischen Namen **retry** und **cancel**.

    **yesno**
    : Zeigt zwei Buttons mit den symbolischen Namen **yes** und **no**.

    **yesnocancel**
    : Zeigt drei Buttons mit den symbolischen Namen **yes**, **no** und **cancel**.



# Beispiel

```
set answer [tk_messageBox -message "Really quit?" \
        -icon question -type yesno \
        -detail "Select \"Yes\" to make the application exit"]
switch -- $answer {
    yes exit
    no {tk_messageBox -message "I know you like this application!" \
            -type ok}
}
```
