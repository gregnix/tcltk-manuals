# Interaktive Bearbeitung von Tabellenzellen mithilfe des combobox-Pakets

## Für Tablelist Version 7.12

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Der Befehl tablelist::addOakleyCombobox](#der-befehl-tablelist-addoakleycombobox)

[Startseite](index.md)

---

## Überblick

Das „Combobox“-Paket von Bryan Oakley ist eine Erweiterung für die Bibliothek Tcl/Tk ab Version 8.0, die vollständig in Tcl/Tk geschrieben ist. Der Download-Link lautet

http://www1.clearlight.com/~oakley/tcl/combobox

Tablelist unterstützt die interaktive Bearbeitung von Zellen mithilfe des Combobox-Widgets, das in dem oben genannten Paket implementiert ist. Die folgenden Schritte sind erforderlich, um dieses Widget zur Bearbeitung der Zellen einer bestimmten Spalte zu verwenden:

1. Registrieren Sie das Combobox-Widget für die interaktive Zellenbearbeitung, indem Sie den unten beschriebenen Befehl `tablelist::addOakleyCombobox` aufrufen.
2. Verwenden Sie den Unterbefehl `columnconfigure` des Tablelist-Widgets, um die Option `-editable` der angegebenen Spalte auf „true“ und die Option `-editwindow` auf den vom oben genannten Befehl zurückgegebenen Wert zu setzen.  (Diese Optionen werden mithilfe des Unterbefehls `cellconfigure` auch auf Zellenebene unterstützt.)

**HINWEIS:**  Die Pfeil- und Bildlaufleisten-Komponenten des temporär eingebetteten Combobox-Widgets, das für die interaktive Zellbearbeitung verwendet wird, werden entsprechend der DPI-Skalierung des Bildschirms und dem durch `[tk scaling]` vorgegebenen Skalierungsfaktor von Tk korrekt skaliert angezeigt.

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addOakleyCombobox`

**NAME**
: `tablelist::addOakleyCombobox` – Registrieren Sie das Combobox-Widget von Bryan Oakley für die interaktive Zellbearbeitung

**ÜBERSICHT**
: 

```
tablelist::addOakleyCombobox ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das Combobox-Widget von Bryan Oakley für die interaktive Zellenbearbeitung in Tablelist-Widgets. Das optionale Argument legt den Namen fest, der für das Combobox-Widget als Wert der Spalten- oder Zellenkonfigurationsoption `-editwindow` verwendet werden soll.  Es kann sich um eine beliebige Zeichenkette handeln, die sich von den Namen der Bearbeitungsfenster [Tk core](tablelistTkCore.md) und [tile](tablelistTile.md) unterscheidet.  Der Standardwert ist `combobox`.  Der Befehl gibt sein Argument `name` zurück.

: Das temporäre, eingebettete Combobox-Widget, das mit dem oben genannten `name` verknüpft ist, wird erstellt, wobei die Option `-editable` auf `1` gesetzt ist.  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um die Combobox nicht editierbar zu machen oder VALIDIERUNGEN für ihr untergeordnetes Eingabefeld zu definieren (dessen Pfadname durch Aufruf des WidgetsUnterbefehl `entrypath` des Combobox-Widgets, durch Anhängen von `.entry` an den Pfadnamen des Combobox-Widgets oder – bei Verwendung von Combobox Version 2.3 oder höher – mithilfe des Unterbefehls `subwidget entry` des Combobox-Widgets) sowie zum Befüllen ihrer listbox-Komponente (mithilfe des Unterbefehls `list insert` des Combobox-Widgets).

**SCHLÜSSELWÖRTER**
: tablelist, editing, combobox


[Startseite](index.md)
