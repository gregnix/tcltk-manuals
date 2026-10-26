---
CommandName: tk_getOpenFile
title: tk_getOpenFile
ManualSection: n
Version: 4.2
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - tk_chooseDirectory
Keywords:
 - file selection dialog
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
---

# Name

tk\_getOpenFile, tk\_getSaveFile - Blendet einen Dialog zum Öffnen oder Speichern einer Datei ein

# Übersicht

::: {.synopsis} :::
[tk\_getOpenFile]{.cmd} [option value]{.optdot}
[tk\_getSaveFile]{.cmd} [option value]{.optdot}
:::

# Beschreibung

Die Prozeduren **tk\_getOpenFile** und **tk\_getSaveFile** blenden einen Dialog ein, in dem der Benutzer eine Datei zum Öffnen oder Speichern auswählt. Der Befehl **tk\_getOpenFile** ist üblicherweise dem Menübefehl **Open** im Menü **File** zugeordnet. Er dient dazu, dass der Benutzer *nur* eine bestehende Datei auswählt. Gibt der Benutzer eine nicht existierende Datei ein, zeigt der Dialog eine Fehlermeldung und verlangt eine andere Auswahl. Erlaubt eine Anwendung das Anlegen neuer Dateien, sollte dies über einen separaten Menübefehl **New** erfolgen.

Der Befehl **tk\_getSaveFile** ist üblicherweise dem Menübefehl **Save as** im Menü **File** zugeordnet. Gibt der Benutzer eine bereits existierende Datei ein, fragt der Dialog, ob die bestehende Datei überschrieben werden soll.

Die folgenden *Option-Wert*-Paare sind als Befehlszeilenargumente für diese beiden Befehle möglich:

[-command]{.lit} [string]{.arg}
: Legt das Präfix eines Tcl-Befehls fest, der ausgeführt wird, wenn der Benutzer den Dialog nach einer Auswahl schließt. Dieser Rückruf wird nicht aufgerufen, wenn der Benutzer den Dialog abbricht. Der tatsächliche Befehl besteht aus *string*, gefolgt von einem Leerzeichen und dem vom Benutzer im Dialog gewählten Wert. Nur unter macOS verfügbar.

[-confirmoverwrite]{.lit} [boolean]{.arg}
: Legt fest, wie der Speichern-Dialog reagiert, wenn die gewählte Datei bereits existiert und das Speichern sie überschreiben würde. Ein wahrer Wert fordert einen Bestätigungsdialog. Ein falscher Wert überschreibt ohne Bestätigung. Standardwert ist true.

[-defaultextension]{.lit} [extension]{.arg}
: Legt einen String fest, der an den Dateinamen angehängt wird, wenn der Benutzer einen Dateinamen ohne Erweiterung eingibt. Standard ist der leere String, d. h. es wird in keinem Fall eine Erweiterung angehängt. Diese Option wird unter macOS ignoriert, wo Dateinamen keine Erweiterung benötigen; die UNIX-Implementierung leitet vernünftige Werte aus **-filetypes** ab, wenn nichts angegeben ist.

[-filetypes]{.lit} [filePatternList]{.arg}
: Existiert auf der Plattform eine **File types**-Listbox im Dateidialog, gibt diese Option die *filetype*s in dieser Listbox an. Wählt der Benutzer einen Dateityp, werden nur Dateien dieses Typs aufgelistet. Ist die Option nicht angegeben, leer oder wird die **File types**-Listbox von der Plattform nicht unterstützt, werden alle Dateien unabhängig vom Typ aufgelistet. Siehe Abschnitt [Dateimuster festlegen] unten zur Struktur von *filePatternList*.

[-initialdir]{.lit} [directory]{.arg}
: Legt fest, dass beim Öffnen des Dialogs die Dateien in *directory* angezeigt werden. Ist der Parameter nicht angegeben, ist das Startverzeichnis auf Nicht-Windows-Systemen das aktuelle Arbeitsverzeichnis; unter Windows vor Vista ebenfalls. Unter Vista und später ist es das zuletzt vom Benutzer für die Anwendung gewählte Verzeichnis. Gibt der Parameter einen relativen Pfad an, wandelt der Rückgabewert ihn in einen absoluten Pfad um.

[-initialfile]{.lit} [filename]{.arg}
: Legt einen Dateinamen fest, der beim Öffnen des Dialogs angezeigt wird.

[-message]{.lit} [string]{.arg}
: Legt eine Meldung fest, die im Client-Bereich des Dialogs angezeigt wird. Nur unter macOS verfügbar.

[-multiple]{.lit} [boolean]{.arg}
: Erlaubt dem Benutzer, mehrere Dateien im Öffnen-Dialog auszuwählen.

[-parent]{.lit} [window]{.arg}
: Macht *window* zum logischen Elternfenster des Dateidialogs. Der Dialog wird über dem Elternfenster angezeigt. Unter macOS wird der Dialog zu einem Sheet am Elternfenster.

[-title]{.lit} [titleString]{.arg}
: Legt einen String als Titel des Dialogs fest. Ist die Option nicht angegeben, wird ein Standardtitel angezeigt.

[-typevariable]{.lit} [variableName]{.arg}
: Die globale Variable *variableName* wählt beim Öffnen des Dialogs den Filter aus *filterList* vor und wird beim Schließen auf den zuletzt gewählten Filter aktualisiert. Die Variable wird einmal zu Beginn gelesen. Existiert sie nicht, passt ihr Wert keinem Filter-Typnamen oder ist leer (**{}**), wählt der Dialog standardmäßig den ersten Filter. Wird der Dialog abgebrochen, bleibt die Variable unverändert.


Wählt der Benutzer eine Datei, geben **tk\_getOpenFile** und **tk\_getSaveFile** den vollständigen Pfadnamen zurück. Bricht der Benutzer ab, geben beide Befehle den leeren String zurück.

# Dateimuster festlegen

Der von **-filetypes** angegebene Wert *filePatternList* ist eine Liste von Dateimustern. Jedes Dateimuster ist eine Liste der Form

```
typeName {extension ?extension ...?} ?{macType ?macType ...?}?
```

*typeName* ist der Name des durch dieses Muster beschriebenen Dateityps und der Text in der **File types**-Listbox. *extension* ist eine Dateierweiterung für dieses Muster. *macType* ist ein vierstelliges Macintosh-Dateityp-Kürzel. Die Liste der *macType*s ist optional und kann für Anwendungen ohne Macintosh-Bedarf weggelassen werden.

Mehrere Dateimuster können denselben *typeName* haben; sie bezeichnen dann denselben Dateityp und teilen sich einen Listbox-Eintrag. Wählt der Benutzer einen Eintrag, werden alle Dateien aufgelistet, die mindestens einem der zugehörigen Muster entsprechen. Üblicherweise entspricht jedes Muster einem eigenen Dateityp. Mehrere Muster für einen Typ sind nur auf der Macintosh-Plattform nötig.

Auf Macintosh passt eine Datei zu einem Muster, wenn ihr Name mindestens einer *extension* entspricht UND sie zu mindestens einem *macType* des Musters gehört. Das Muster **C Source Files** im Beispielcode passt zu Dateien mit Erweiterung **.c** UND *macType* **TEXT**. Für die ODER-Regel verwenden Sie zwei Muster, eines nur mit *extensions*, eines nur mit *macType*. Der Dateityp **GIF Files** im Beispielcode passt zu Dateien, die *entweder* die Erweiterung **.gif** haben ODER zum *macType* **GIFF** gehören.

Auf Unix und Windows passt eine Datei, wenn ihr Name mindestens einer *extension* des Musters entspricht. Die *macType*s werden ignoriert.

# Erweiterungen festlegen

Auf Unix und Macintosh werden Erweiterungen per Glob-Muster abgeglichen. Unter Windows übernimmt das Betriebssystem den Abgleich. Mögliche Erweiterungstypen:

1. die Sondererweiterung „\*“ passt zu jeder Datei;

2. die Sondererweiterung „“ passt zu Dateien ohne Erweiterung (d. h. der Dateiname enthält keinen Punkt);

3. jede Zeichenkette ohne Platzhalter (\* und ?).


Wegen unterschiedlicher Abgleichregeln auf den Plattformen sind Platzhalter in Erweiterungen zur Portierbarkeit nicht erlaubt, außer bei der Sondererweiterung „\*“. Erweiterungen ohne Punkt (z. B. „~“) sind erlaubt, funktionieren aber nicht auf allen Plattformen.

# Beispiel

```
set types {
    {{Text Files}       {.txt}        }
    {{TCL Scripts}      {.tcl}        }
    {{C Source Files}   {.c}      TEXT}
    {{GIF Files}        {.gif}        }
    {{GIF Files}        {}        GIFF}
    {{All Files}        *             }
}
set filename [tk_getOpenFile -filetypes $types]

if {$filename ne ""} {
    # Open the file ...
}
```
