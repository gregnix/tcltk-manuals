# Interaktive Bearbeitung von Tabellenzellen mit dem Iwidgets-Paket

## Für Tablelist Version 7.12

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Der Befehl tablelist::addIncrEntryfield](#der-befehl-tablelist-addincrentryfield)
- [Der Befehl tablelist::addIncrDateTimeWidget](#der-befehl-tablelist-addincrdatetimewidget)
- [Der Befehl tablelist::addIncrSpinner](#der-befehl-tablelist-addincrspinner)
- [Der Befehl tablelist::addIncrSpinint](#der-befehl-tablelist-addincrspinint)
- [Der Befehl tablelist::addIncrCombobox](#der-befehl-tablelist-addincrcombobox)

[Startseite](index.md)

---

## Überblick

Das Iwidgets-Paket (auch bekannt als \[incr Widgets\]) ist eine Erweiterung für die Bibliotheken von Tcl/Tk ab Version 8.0, die in reinem Tcl/Tk-Code geschrieben ist.  Es benötigt die kompilierten Pakete Itcl und Itk (auch bekannt als \[incr Tcl\] bzw. \[incr Tk\]).  Der Download-Ort dieser drei Bibliotheken ist

https://sourceforge.net/projects/incrtcl/files

Tablelist unterstützt die interaktive Bearbeitung von Zellen mithilfe der Widgets „entryfield“, „datefield“, „dateentry“, „timefield“, „timeentry“, „spinner“, „spinint“ und „combobox“ aus dem Iwidgets-Paket. Die folgenden Schritte sind erforderlich, um eines dieser Widgets zur Bearbeitung der Zellen einer bestimmten Spalte zu verwenden:

1. Registrieren Sie das gewünschte Widget für die interaktive Zellenbearbeitung, indem Sie einen der auf dieser Referenzseite beschriebenen Befehle aufrufen.
2. Verwenden Sie den Unterbefehl `columnconfigure` des Tablelist-Widgets, um die Option `-editable` der angegebenen Spalte auf „true“ und die Option `-editwindow` auf den vom oben genannten Befehl zurückgegebenen Wert zu setzen.  (Diese Optionen werden mithilfe des Unterbefehls `cellconfigure` auch auf Zellenebene unterstützt.)

**HINWEIS:**  Das temporär eingebettete „Iwidgets“-Widget, das für die interaktive Bearbeitung von Zellen verwendet wird, wird entsprechend der DPI-Skalierung des Bildschirms und dem durch `[tk scaling]` vorgegebenen Skalierungsfaktor von Tk korrekt skaliert angezeigt.

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addIncrEntryfield`

**NAME**
: `tablelist::addIncrEntryfield` – Registrieren Sie das Eingabefeld-Widget aus dem Iwidgets-Paket für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addIncrEntryfield ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das „entryfield“-Widget aus dem Iwidgets-Paket für die interaktive Zellbearbeitung in Tablelist-Widgets. Das optionale Argument legt den Namen fest, der für das „entryfield“-Widget als Wert der Spalten- oder Zellkonfigurationsoption `-editwindow` verwendet werden soll.  Es kann sich um eine beliebige Zeichenkette handeln, die sich von den Namen der Bearbeitungsfenster [Tk core](tablelistTkCore.md) und [tile](tablelistTile.md) unterscheidet.  Der Standardwert ist `entryfield`.  Der Befehl gibt sein Argument `name` zurück.

**SCHLÜSSELWÖRTER**
: tablelist, editing, Iwidgets, entryfield


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addIncrDateTimeWidget`

**NAME**
: `tablelist::addIncrDateTimeWidget` – Registrieren Sie das Widget „datefield“, „dateentry“, „timefield“ oder „timeentry“ aus dem Iwidgets-Paket für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addIncrDateTimeWidget datefield|dateentry|timefield|timeentry ?-seconds? ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das Widget „datefield“, „dateentry“, „timefield“ oder „timeentry“ aus dem Iwidgets-Paket für die interaktive Zellbearbeitung in Tablelist-Widgets.  Wenn das Argument `-seconds` vorhanden ist, ruft der Unterbefehl `finishediting` des mit dem Tablelist-Widget verknüpften Tcl-Befehls den Inhalt des für die interaktive Zellbearbeitung verwendeten eingebetteten Fensters als ganzzahligen Zeitwert (in Sekunden) ab, ansonsten als Zeichenkette.  Verwenden Sie diese Option für Tablelist-Widgets, deren interne Liste Datums- oder Zeitangaben in Sekunden enthält (die mithilfe von Befehlen angezeigt werden, die durch die KONFIGURATIONSOPTIONEN `-formatcommand` vorgegeben sind).  Das zweite optionale Argument legt den Namen fest, der für das „datefield“-„dateentry“-„timefield“- oder „timeentry“-Widget als Wert der Spalten- oder Zellenkonfigurationsoption `-editwindow` verwendet werden soll.  Es kann sich um eine beliebige Zeichenkette handeln, die sich von den Namen der Bearbeitungsfenster [Tk core](tablelistTkCore.md) und [tile](tablelistTile.md) unterscheidet.  Der Standardwert ist `datefield`, `dateentry`, `timefield` oder `timeentry`, wie durch das erste Argument vorgegeben.  Der Befehl gibt sein Argument `name` zurück.

: Wenn Sie eine Zelle mithilfe des temporär eingebetteten Widgets „datefield“, „dateentry“, „timefield“ oder „timeentry“ bearbeiten, das mit dem oben genannten `name` verknüpft ist, können Sie das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um beliebige Optionen des Widgets festzulegen, wie beispielsweise `-gmt`, `-iq`, `-int` (internationales Datumsformat, unterstützt von den Widgets „datefield“ und „dateentry“) oder `-format` (für „timefield“- und „timeentry“-Widgets, mit den Werten `civilian` und `military`).  Für das „dateentry“-Widget können Sie außerdem die Option `-startday` auf `monday` und die Option `-days` beispielsweise auf `{Mo Tu We Th Fr Sa Su}`.

**SCHLÜSSELWÖRTER**
: tablelist, editing, Iwidgets, datefield, dateentry, timefield, timeentry


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addIncrSpinner`

**NAME**
: `tablelist::addIncrSpinner` – Registrieren Sie das Spinner-Widget aus dem Iwidgets-Paket für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addIncrSpinner ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das Spinner-Widget aus dem Iwidgets-Paket für die interaktive Zellbearbeitung in Tablelist-Widgets. Das optionale Argument legt den Namen fest, der für das Spinner-Widget als Wert der Spalten- oder Zellkonfigurationsoption `-editwindow` verwendet werden soll.  Es kann sich um eine beliebige Zeichenkette handeln, die sich von den Namen der Bearbeitungsfenster [Tk core](tablelistTkCore.md) und [tile](tablelistTile.md) unterscheidet. Der Standardwert ist `spinner`.  Der Befehl gibt sein Argument `name` zurück.

: Wenn Sie eine Zelle mithilfe des temporär eingebetteten Spinner-Widgets bearbeiten, das mit dem oben genannten `name` verknüpft ist, können Sie das Skript verwenden, das der Konfigurationsoption `-editstartcommand` für die Tablelist entspricht, um VALIDIERUNGEN für das Widget zu definieren oder andere Optionen festzulegen, wie beispielsweise `-decrement` und `-increment`.

**SCHLÜSSELWÖRTER**
: tablelist, editing, Iwidgets, spinner


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addIncrSpinint`

**NAME**
: `tablelist::addIncrSpinint` – Registrieren Sie das „spinint“-Widget aus dem „Iwidgets“-Paket für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addIncrSpinint ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das „spinint“-Widget aus dem „Iwidgets“-Paket für die interaktive Zellbearbeitung in „tablelist“-Widgets. Das optionale Argument legt den Namen fest, der für das „spinint“-Widget als Wert der Spalten- oder Zellkonfigurationsoption `-editwindow` verwendet werden soll.  Es kann sich um eine beliebige Zeichenkette handeln, die sich von den Namen der Bearbeitungsfenster [Tk core](tablelistTkCore.md) und [tile](tablelistTile.md) unterscheidet.  Der Standardwert ist `spinint`.  Der Befehl gibt sein Argument `name` zurück.

: Wenn Sie eine Zelle mithilfe des temporären, eingebetteten „spinint“-Widgets bearbeiten, das mit dem oben genannten `name` verknüpft ist, können Sie das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um VALIDIERUNGEN für das Widget zu definieren oder andere Optionen festzulegen, wie beispielsweise `-range`, `-step` und `-wrap`.

**SCHLÜSSELWÖRTER**
: tablelist, editing, Iwidgets, spinint


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addIncrCombobox`

**NAME**
: `tablelist::addIncrCombobox` – Registrieren Sie das Combobox-Widget aus dem Iwidgets-Paket für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addIncrCombobox ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das Combobox-Widget im Dropdown-Stil aus dem Iwidgets-Paket für die interaktive Zellenbearbeitung in Tablelist-Widgets. Das optionale Argument legt den Namen fest, der für das Combobox-Widget als Wert der Spalten- oder Zellenkonfigurationsoption `-editwindow` verwendet werden soll.  Es kann sich um eine beliebige Zeichenkette handeln, die sich von den Namen der Bearbeitungsfenster [Tk core](tablelistTkCore.md) und [tile](tablelistTile.md) unterscheidet.  Der Standardwert ist `combobox`.  Der Befehl gibt sein Argument `name` zurück.

: Das temporäre, eingebettete Combobox-Widget, das mit dem oben genannten `name` verknüpft ist, wird erstellt, wobei die Option `-editable` auf `1` und die Option `-grab` auf `global` gesetzt.  Sie können das Skript verwenden, das der Tablelist-Konfigurationsoption `-editstartcommand` entspricht, um die Combobox nicht bearbeitbar zu machen oder VALIDIERUNGEN dafür zu definieren, sowie zum Befüllen ihrer listbox-Komponente (mithilfe des Unterbefehls `insert list` und der Option `-listheight` des Kombinationsfeld-Widgets).

**SCHLÜSSELWÖRTER**
: tablelist, editing, Iwidgets, combobox


[Inhalt](#inhalt)     [Startseite](index.md)
