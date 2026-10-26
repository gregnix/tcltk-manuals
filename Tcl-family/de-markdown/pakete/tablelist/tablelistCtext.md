# Interaktive Bearbeitung von Tabellenzellen mit dem ctext-Paket

## Für Tablelist Version 7.12

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Der Befehl tablelist::addCtext](#der-befehl-tablelist-addctext)

[Startseite](index.md)

---

## Überblick

Das ctext-Paket von George Peter Staplin ist eine Bibliothek-Erweiterung für Tcl/Tk ab Version 8.0, die in reinem Tcl/Tk-Code geschrieben ist. Es ist Teil von tklib, dessen Adresse lautet

https://core.tcl.tk/tklib

Tablelist unterstützt die interaktive Bearbeitung von Zellen mithilfe des im oben genannten Paket implementierten ctext-Widgets. Die folgenden Schritte sind erforderlich, um dieses Widget zur Bearbeitung der Zellen einer bestimmten Spalte zu verwenden:

1. Registrieren Sie das ctext-Widget für die interaktive Zellenbearbeitung, indem Sie den unten beschriebenen Befehl `tablelist::addCtext` aufrufen.
2. Verwenden Sie den Unterbefehl `columnconfigure` des Tablelist-Widgets, um die Option `-editable` der angegebenen Spalte auf „true“ und die Option `-editwindow` auf den vom oben genannten Befehl zurückgegebenen Wert zu setzen.  (Diese Optionen werden mithilfe des Unterbefehls `cellconfigure` auch auf Zellenebene unterstützt.)

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addCtext`

**NAME**
: `tablelist::addCtext` – Das ctext-Widget für die interaktive Bearbeitung von Zellen registrieren

**ÜBERSICHT**
: 

```
tablelist::addCtext ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das ctext-Widget für die interaktive Zellbearbeitung in Tablelist-Widgets. Das optionale Argument legt den Namen fest, der für das ctext-Widget als Wert der Spalten- oder Zellkonfigurationsoption `-editwindow` verwendet werden soll.  Es kann sich um eine beliebige Zeichenkette handeln, die sich von den Namen der Bearbeitungsfenster [Tk core](tablelistTkCore.md) und [tile](tablelistTile.md) unterscheidet.  Der Standardwert ist `ctext`.  Der Befehl gibt sein Argument `name` zurück.

: Das temporäre, eingebettete ctext-Widget, das für die interaktive Zellenbearbeitung verwendet wird, wird so erstellt, dass seine OPTIONEN `-padx` und `-pady` auf `2` gesetzt sind, die Option `-wrap` auf `none` gesetzt und die anfängliche Höhe auf die Anzahl der darin enthaltenen Zeilen festgelegt.  Es gibt jedoch eine Ausnahme von dieser Regel: Wenn die Option `-wrap` der Spalte der Zelle auf „true“ gesetzt wurde und Tk Version 8.5 oder höher verwendet wird, dann wird die Option `-wrap` des ctext-Widgets auf `word` gesetzt und seine Anfangshöhe entspricht der Anzahl der darin enthaltenen *angezeigten* Zeilen (unter Berücksichtigung der Zeilenumbrüche).  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um die Anfangseinstellungen (mit Ausnahme der Höhe) nach Ihren Bedürfnissen zu überschreiben.

: Wenn die Option `-wrap` des ctext-Widgets auf `word` oder `char` gesetzt wurde (entweder durch „Tablelist“ oder innerhalb des oben genannten Skripts) und es wird Tk Version 8.5 oder höher verwendet, wird bei jeder Änderung der Breite (z. B. durch interaktive Anpassung der Spalten) die Höhe automatisch auf die Anzahl der darin enthaltenen Anzeigezeilen gesetzt.  (Die Anzahl der Anzeigezeilen wird mithilfe des in Tk 8.5 eingeführten Text-Widget-Unterbefehls ``count -displaylines`` ermittelt.)

: Wenn das Widget-Callback-Paket „Wcb“ in den Interpreter geladen wurde (über  `package require Wcb`  oder  `package require wcb`),  wird die Höhe des ctext-Widgets automatisch aktualisiert, sobald Text eingefügt oder gelöscht wird, was die Bearbeitung wesentlich benutzerfreundlicher macht.  Dies wird durch die Verwendung einer entsprechend definierten Rückruffunktion „after-`insert`“ und „after-`delete`“ für das Bearbeitungsfenster erreicht.  Sie können das Skript verwenden, das der Konfigurationsoption „tablelist“ (`-editstartcommand`) entspricht, um weitere Callbacks für das ctext-Widget zu definieren.  (Der oben genannte Callback wird über `wcb::cbappend` erstellt, *nach* der Rückkehr aus diesem Skript.)

: Die Taste `Tab` ist für die Navigation zwischen den bearbeitbaren Zellen reserviert, der Benutzer kann jedoch durch Drücken von `Control-i` ein Tabulatorzeichen in das ctext-Widget einfügen.

: Anders als bei den anderen Widgets, die für die interaktive Zellenbearbeitung verwendet werden (mit Ausnahme des Tk-Core-Text-Widgets), fügen die Tasten `Return` und `KP_Enter` ein Zeilenumbruchzeichen in das ctext-Widget ein.  Auch `Control-j` kann zum Einfügen eines Zeilenumbruchs verwendet werden. `Control-Return` und `Control-KP_Enter` beenden die Bearbeitung und löschen das Bearbeitungsfenster.

: `Control-Home` und `Control-End` verfügen über ihre bekannten, für Text-Widgets spezifischen Bindungen, genau wie `Meta-<` und `Meta->`, wenn `tk_strictMotif` auf „false“ gesetzt ist.  Auch dies unterscheidet sich vom Verhalten der anderen Widgets, die für die interaktive Zellbearbeitung verwendet werden (mit Ausnahme des Tk-Core-Text-Widgets).  Um zur ersten bzw. letzten bearbeitbaren Zelle zu springen, kann der Benutzer `Alt-Home`/`Alt-End` oder `Meta-Home`/`Meta-End` (`Command-Home`/`Command-End` unter Mac OS X/11+ Aqua).

**SCHLÜSSELWÖRTER**
: tablelist, editing, ctext


[Startseite](index.md)
