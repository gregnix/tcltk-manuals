# Interaktive Bearbeitung von Tabellenzellen mit dem BWidget-Paket

## Für Tablelist Version 7.12

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Der Befehl tablelist::addBWidgetEntry](#der-befehl-tablelist-addbwidgetentry)
- [Der Befehl tablelist::addBWidgetSpinBox](#der-befehl-tablelist-addbwidgetspinbox)
- [Der Befehl tablelist::addBWidgetComboBox](#der-befehl-tablelist-addbwidgetcombobox)

[Startseite](index.md)

---

## Überblick

Das BWidget-Paket ist eine Erweiterung für die Bibliothek Tcl/Tk ab Version 8.1.1, die in reinem Tcl/Tk-Code geschrieben ist.  Es kann hier heruntergeladen werden:

https://sourceforge.net/projects/tcllib/files

Tablelist unterstützt die interaktive Bearbeitung von Zellen mithilfe der Widgets „Entry“, „SpinBox“ und „ComboBox“ aus dem BWidget-Paket. Die folgenden Schritte sind erforderlich, um eines dieser Widgets zur Bearbeitung der Zellen einer bestimmten Spalte zu verwenden:

1. Registrieren Sie das gewünschte Widget für die interaktive Zellenbearbeitung, indem Sie einen der auf dieser Referenzseite beschriebenen Befehle aufrufen.
2. Verwenden Sie den Unterbefehl `columnconfigure` des Tablelist-Widgets, um die Option `-editable` der angegebenen Spalte auf „true“ und die Option `-editwindow` auf den vom oben genannten Befehl zurückgegebenen Wert zu setzen.  (Diese Optionen werden mithilfe des Unterbefehls `cellconfigure` auch auf Zellenebene unterstützt.)

**HINWEIS:**  Das temporär eingebettete BWidget-Widget, das für die interaktive Zellbearbeitung verwendet wird, wird entsprechend der DPI-Skalierung des Bildschirms und dem durch `[tk scaling]` vorgegebenen Skalierungsfaktor von Tk korrekt skaliert angezeigt.

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addBWidgetEntry`

**NAME**
: `tablelist::addBWidgetEntry` – Registrieren Sie das „Entry“-Widget aus dem BWidget-Paket für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addBWidgetEntry ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das „Entry“-Widget aus dem BWidget-Paket für die interaktive Zellenbearbeitung in Tablelist-Widgets. Das optionale Argument legt den Namen fest, der für das „Entry“-Widget als Wert der Spalten- oder Zellenkonfigurationsoption `-editwindow` verwendet werden soll.  Es kann sich um eine beliebige Zeichenkette handeln, die sich von den Namen der Bearbeitungsfenster [Tk core](tablelistTkCore.md) und [tile](tablelistTile.md) unterscheidet.  Der Standardwert ist `Entry`.  Der Befehl gibt sein Argument `name` zurück.

**SCHLÜSSELWÖRTER**
: tablelist, editing, BWidget, Entry


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addBWidgetSpinBox`

**NAME**
: `tablelist::addBWidgetSpinBox` – Registrieren Sie das SpinBox-Widget aus dem BWidget-Paket für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addBWidgetSpinBox ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das SpinBox-Widget aus dem BWidget-Paket für die interaktive Zellbearbeitung in Tablelist-Widgets. Das optionale Argument legt den Namen fest, der für das SpinBox-Widget als Wert der Spalten- oder Zellkonfigurationsoption `-editwindow` verwendet werden soll.  Es kann sich um eine beliebige Zeichenkette handeln, die sich von den Namen der Bearbeitungsfenster [Tk core](tablelistTkCore.md) und [tile](tablelistTile.md) unterscheidet.  Der Standardwert ist `SpinBox`.  Der Befehl gibt sein Argument `name` zurück.

: Das temporäre, eingebettete SpinBox-Widget, das mit dem oben genannten `name` verknüpft ist, wird erstellt, wobei die Option `-editable` auf `1` gesetzt ist.  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um die SpinBox nicht editierbar zu machen oder VALIDIERUNGEN dafür zu definieren sowie deren Werte (bzw. Wertebereich) und die Option `-wrap` festzulegen.

**SCHLÜSSELWÖRTER**
: tablelist, editing, BWidget, SpinBox


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addBWidgetComboBox`

**NAME**
: `tablelist::addBWidgetComboBox` – Registrieren Sie das ComboBox-Widget aus dem BWidget-Paket für die interaktive Zellbearbeitung

**ÜBERSICHT**
: 

```
tablelist::addBWidgetComboBox ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das ComboBox-Widget aus dem BWidget-Paket für die interaktive Zellbearbeitung in Tablelist-Widgets. Das optionale Argument legt den Namen fest, der für das ComboBox-Widget als Wert der Spalten- oder Zellkonfigurationsoption `-editwindow` verwendet werden soll.  Es kann sich um eine beliebige Zeichenkette handeln, die sich von den Namen der Bearbeitungsfenster [Tk core](tablelistTkCore.md) und [tile](tablelistTile.md) unterscheidet.  Der Standardwert ist `ComboBox`.  Der Befehl gibt sein Argument `name` zurück.

: Das temporäre, eingebettete ComboBox-Widget, das mit dem oben genannten `name` verknüpft ist, wird erstellt, wobei die Option `-editable` auf `1` gesetzt ist.  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` für die Tablelist entspricht, um die ComboBox nicht bearbeitbar zu machen oder VALIDIERUNGEN dafür zu definieren, sowie zum Befüllen ihrer listbox-Komponente (mithilfe der Option `-values` des ComboBox-Widgets).

**SCHLÜSSELWÖRTER**
: tablelist, editing, BWidget, ComboBox


[Inhalt](#inhalt)     [Startseite](index.md)
