# Interaktive Bearbeitung von Tabellenzellen mit dem Tsw-Paket

## Für Tablelist Version 7.12

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Der Befehl tablelist::addToggleswitch](#der-befehl-tablelist-addtoggleswitch)

[Startseite](index.md)

---

## Überblick

Das Widget-Paket „Tsw“ für Kippschalter ist eine Bibliothek-Erweiterung für Tcl/Tk ab Version 8.6, die in reinem Tcl/Tk-Code geschrieben ist. Der Download-Link lautet

https://www.nemethi.de

Tablelist unterstützt die interaktive Bearbeitung von Zellen mithilfe des im oben genannten Paket implementierten ToggleSwitch-Widgets. Die folgenden Schritte sind erforderlich, um dieses Widget zur Bearbeitung der Zellen einer bestimmten Spalte zu verwenden:

1. Registrieren Sie das Toggle-Switch-Widget für die interaktive Zellenbearbeitung, indem Sie den unten beschriebenen Befehl `tablelist::addToggleswitch` aufrufen.
2. Verwenden Sie den Unterbefehl `columnconfigure` des Tablelist-Widgets, um die Option `-editable` der angegebenen Spalte auf „true“ und die Option `-editwindow` auf den vom oben genannten Befehl zurückgegebenen Wert zu setzen.  (Diese Optionen werden mithilfe des Unterbefehls `cellconfigure` auch auf Zellenebene unterstützt.)

**HINWEIS:**  Das temporär eingebettete Kippschalter-Widget, das für die interaktive Bearbeitung von Zellen verwendet wird, wird entsprechend der DPI-Skalierung des Bildschirms und dem durch `[tk scaling]` vorgegebenen Skalierungsfaktor von Tk korrekt skaliert angezeigt.

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addToggleswitch`

**NAME**
: `tablelist::addToggleswitch` – Das Kippschalter-Widget für die interaktive Bearbeitung von Zellen registrieren

**ÜBERSICHT**
: 

```
tablelist::addToggleswitch ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das „toggleswitch“-Widget für die interaktive Zellenbearbeitung in „tablelist“-Widgets. Das optionale Argument legt den Namen fest, der für das „toggleswitch“-Widget als Wert der Spalten- oder Zellenkonfigurationsoption `-editwindow` verwendet werden soll.  Es kann sich um eine beliebige Zeichenkette handeln, die sich von den Namen der Bearbeitungsfenster [Tk core](tablelistTkCore.md) und [tile](tablelistTile.md) unterscheidet.  Der Standardwert ist `toggleswitch`.  Der Befehl gibt sein Argument `name` zurück.

: Das temporäre, eingebettete Kippschalter-Widget, das für die interaktive Zellenbearbeitung verwendet wird, wird so erstellt, dass die Option `-size` auf `1` gesetzt ist.  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um die ursprünglichen Einstellungen nach Ihren Bedürfnissen zu überschreiben.

**SCHLÜSSELWÖRTER**
: tablelist, editing, Tsw, toggleswitch


[Startseite](index.md)
