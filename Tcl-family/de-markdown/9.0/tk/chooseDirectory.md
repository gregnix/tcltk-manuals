---
CommandName: tk_chooseDirectory
ManualSection: n
Version: 8.3
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - tk_getOpenFile(n)
 - tk_getSaveFile(n)
Keywords:
 - directory
 - selection
 - dialog
 - platform-specific
Copyright:
 - Copyright (c) 1998-2000 Scriptics Corporation.
 - All rights reserved.
---

# NAME

tk_chooseDirectory - Zeigt einen Dialog zur Verzeichnisauswahl an

# ÜBERSICHT

::: {.synopsis} :::
[tk_chooseDirectory]{.cmd} [option value]{.optdot} 
:::

# BESCHREIBUNG

Die Prozedur **tk_chooseDirectory** zeigt einen Dialog an, in dem der Benutzer ein Verzeichnis auswählen kann. Folgende *option-value*-Paare sind als Befehlszeilenargumente möglich:

**-command** *string*
: Legt das Präfix eines Tcl-Befehls fest, der ausgeführt wird, wenn der Benutzer den Dialog nach einer Auswahl schließt. Dieser Rückruf wird nicht aufgerufen, wenn der Benutzer den Dialog abbricht. Der tatsächliche Befehl besteht aus *string*, gefolgt von einem Leerzeichen und dem vom Benutzer im Dialog gewählten Wert. Nur unter macOS verfügbar.

**-initialdir** *dirname*
: Legt fest, dass beim Öffnen des Dialogs die Verzeichnisse in *directory* angezeigt werden. Wird dieser Parameter nicht angegeben, ist das Anfangsverzeichnis auf Nicht-Windows-Systemen und auf Windows vor Vista das aktuelle Arbeitsverzeichnis. Unter Vista und neuer ist es das zuletzt vom Benutzer für die Anwendung gewählte Verzeichnis. Gibt der Parameter einen relativen Pfad an, wandelt der Rückgabewert diesen in einen absoluten Pfad um.

**-message** *string*
: Legt eine Meldung fest, die im Client-Bereich des Dialogs angezeigt wird. Nur unter macOS verfügbar.

**-mustexist** *boolean*
: Legt fest, ob der Benutzer nicht vorhandene Verzeichnisse angeben darf. Ist dieser Parameter wahr, kann der Benutzer nur bereits existierende Verzeichnisse wählen. Der Standardwert ist *false*.

**-parent** *window*
: Macht *window* zum logischen Elternfenster des Dialogs. Der Dialog wird über seinem Elternfenster angezeigt. Unter macOS wird der Dateidialog zu einem an das Elternfenster angehängten Sheet.

**-title** *titleString*
: Legt eine Zeichenkette fest, die als Titel des Dialogfelds angezeigt wird. Wird diese Option nicht angegeben, wird ein Standardtitel angezeigt.


# BEISPIEL

```
set dir [tk_chooseDirectory \
        -initialdir ~ -title "Choose a directory"]
if {$dir eq ""} {
   label .l -text "No directory selected"
} else {
   label .l -text "Selected $dir"
}
```
