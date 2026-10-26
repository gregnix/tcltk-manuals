# Interaktive Bearbeitung von Tabellenzellen mithilfe von Tile-Widgets

## Für Tablelist Version 7.12

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Interaktive Zellbearbeitung mit dem Widget ttk::entry](#interaktive-zellbearbeitung-mit-dem-widget-ttk-entry)
- [Interaktive Zellbearbeitung mit dem Widget ttk::spinbox](#interaktive-zellbearbeitung-mit-dem-widget-ttk-spinbox)
- [Interaktive Zellbearbeitung mit dem Widget ttk::combobox](#interaktive-zellbearbeitung-mit-dem-widget-ttk-combobox)
- [Interaktive Zellbearbeitung mit dem Widget ttk::checkbutton](#interaktive-zellbearbeitung-mit-dem-widget-ttk-checkbutton)
- [Interaktive Zellbearbeitung mit dem Widget ttk::menubutton](#interaktive-zellbearbeitung-mit-dem-widget-ttk-menubutton)
- [Interaktive Zellbearbeitung mit dem Widget ttk::toggleswitch](#interaktive-zellbearbeitung-mit-dem-widget-ttk-toggleswitch)

[Startseite](index.md)

---

## Überblick

Die Tile-Themen-Engine ist eine kompilierte Bibliothek-Erweiterung für Tcl/Tk ab Version 8.4. Ab Tk 8.5a6 ist „tile“ in den Tk-Kern integriert. Für frühere Tk-Versionen kann sie unter folgender Adresse heruntergeladen werden:

https://sourceforge.net/projects/tktable//files/tile

Tablelist unterstützt die interaktive Bearbeitung von Zellen mithilfe der Widgets ttk::entry, ttk::spinbox, ttk::combobox, ttk::checkbutton, ttk::menubutton und ttk::toggleswitch, auf die als `ttk::entry`, `ttk::spinbox`, `ttk::combobox`, `ttk::checkbutton`, `ttk::menubutton` und `ttk::toggleswitch` aufgerufen werden.  Die vollqualifizierten Namen `::ttk::entry`, `::ttk::spinbox`, `::ttk::combobox`, `::ttk::checkbutton`, `::ttk::menubutton` und `::ttk::toggleswitch` werden ebenfalls unterstützt.  Die Version des „tile“-Pakets muss 0.6 oder höher sein (das Widget ttk::spinbox erfordert sogar „tile“ 0.8.3 oder höher oder alternativ Tk 8.5.9 oder höher).  Das Widget ttk::toggleswitch wurde in Tk 9.1a1 eingeführt. Diese Widgets werden automatisch für die Zellbearbeitung registriert, daher ist zur Verwendung eines dieser Widgets für die Bearbeitung der Zellen einer bestimmten Spalte lediglich Folgendes erforderlich:

Verwenden Sie den Unterbefehl `columnconfigure` des Tabellisten-Widgets, um die Spalte zu setzenOption `-editable` auf „true“ und die Option `-editwindow` auf `ttk::entry`, `ttk::spinbox`, `ttk::combobox`, `ttk::checkbutton`, `ttk::menubutton` oder `ttk::toggleswitch` (bzw. auf den entsprechenden vollqualifizierten Namen) festzulegen.  (Diese Optionen werden mithilfe des Unterbefehls `cellconfigure` auch auf Zellenebene unterstützt.)

**ANMERKUNG 1:**  Wenn eines der integrierten Themen verwendet wird, wird das temporäre, eingebettete Tile-Widget, das für die interaktive Zellenbearbeitung verwendet wird, entsprechend der DPI-Skalierungsstufe des Bildschirms und dem durch `[tk scaling]` vorgegebenen Skalierungsfaktor von Tk korrekt skaliert angezeigt.  Die einzige Ausnahme bildet das Tile-Checkbutton-Widget, das bei den Themen `aqua`, `clam`, `classic`, `default`, `vista`, und `xpnative` wie erwartet skaliert wird, aus technischen Gründen jedoch nicht skaliert werden kann, wenn das Thema `alt` oder `winnative` lautet und die Tk-Version älter als 9 ist.

**ANMERKUNG 2:**  Eine bekannte Einschränkung früherer Tile-Versionen bestand darin, dass der Befehl  `(ttk::)style theme use`  nur zum Festlegen des aktuellen Themas verwendet werden konnte, nicht jedoch zum Abrufen desselben.  Aus diesem Grund greift Tablelist, wenn es das aktuelle Thema nicht mithilfe von  `ttk::style theme use`  abrufen kann, auf die Variable `ttk::currentTheme` oder `tile::currentTheme` (je nach Tile-Version), die durch den Befehl `ttk::setTheme` oder `tile::setTheme` gesetzt wird.  Daraus folgt: Wenn die verwendete Tile-Version den Befehl ``ttk::style theme use`` ohne Argument nicht unterstützt, werden die für die interaktive Zellbearbeitung verwendeten Tile-Widgets nur dann wie erwartet verwaltet, wenn das plattformspezifische Vorgabethema entweder unverändert bleibt oder durch Aufruf der Prozedur der Bibliothek `ttk::setTheme` oder `tile::setTheme` – je nach aktueller Tile-Version – durch ein anderes Thema ersetzt wird.  (Siehe auch den Befehl `tablelist::setTheme`.)

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Interaktive Zellbearbeitung mit dem Widget „ttk::entry“

**BESCHREIBUNG**
: Das temporäre, eingebettete ttk::entry-Widget, das für die interaktive Bearbeitung von Zellen verwendet wird, wird mit einem explizit festgelegten Wert für die Option `-style` erstellt. Abgesehen von seinem themenspezifischen Erscheinungsbild verhält es sich genau wie sein Tk-Core-Pendant.

: Wenn eine Anwendung das Widget „ttk::entry“ für die interaktive Zellenbearbeitung sowie das Wcb-Paket verwendet (auch wenn dies nicht für dieses Widget gilt), muss die Version von Wcb 3.1 oder höher sein (da frühere Wcb-Versionen keine Tile-Widgets unterstützten).

**SCHLÜSSELWÖRTER**
: tablelist, editing, ttk::entry


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Interaktive Zellbearbeitung mit dem Widget „ttk::spinbox“

**BESCHREIBUNG**
: Das temporäre, eingebettete ttk::spinbox-Widget, das für die interaktive Zellbearbeitung verwendet wird, wird mit einem explizit festgelegten Wert für die Option `-style` erstellt, wobei die Option `-state` auf `normal` gesetzt ist, wodurch das Widget bearbeitbar wird.  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um den Zustand des Spinbox-Feldes auf `readonly` zu setzen oder VALIDIERUNGEN dafür zu definieren, sowie zur Festlegung ihres (Wertebereichs) und ihrer Option `-wrap`.  Abgesehen von ihrem themenspezifischen Erscheinungsbild verhält sie sich genau wie ihr Tk-Core-Pendant.

: Wenn eine Anwendung das Widget „ttk::spinbox“ für die interaktive Zellbearbeitung sowie das Wcb-Paket verwendet (auch wenn dies nicht für dieses Widget gilt), dann muss die Version von Wcb 3.2 oder höher sein (da die Unterstützung für das neue „Tile Spinbox“-Widget erst in Version 3.2 von Wcb hinzugefügt wurde).

**SCHLÜSSELWÖRTER**
: tablelist, editing, ttk::spinbox


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Interaktive Zellbearbeitung mit dem Widget „ttk::combobox“

**BESCHREIBUNG**
: Das temporäre, eingebettete ttk::combobox-Widget, das für die interaktive Zellenbearbeitung verwendet wird, wird mit einem explizit festgelegten Wert für die Option `-style` erstellt, wobei die Option `-state` auf `normal` gesetzt ist, wodurch das Widget bearbeitbar wird.  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` für die Tablelist entspricht, um den Zustand der Combobox auf `readonly` zu setzen oder VALIDIERUNGEN dafür zu definieren, sowie zum Befüllen ihrer listbox-Komponente (mithilfe der Option `-values` des Combobox-Widgets).

: Wenn eine Anwendung das Widget „ttk::combobox“ für die interaktive Zellenbearbeitung sowie das Wcb-Paket verwendet (auch wenn dies nicht für dieses Widget gilt), muss die Version von Wcb 3.1 oder höher sein (da frühere Wcb-Versionen keine Tile-Widgets unterstützten).

**SCHLÜSSELWÖRTER**
: tablelist, editing, ttk::combobox


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Interaktive Zellbearbeitung mit dem Widget „ttk::checkbutton“.

**BESCHREIBUNG**
: Das temporäre, eingebettete ttk::checkbutton-Widget, das für die interaktive Zellenbearbeitung verwendet wird, wird mit explizit festgelegten Werten für die OPTIONEN `-style` und `-variable` erstellt.  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um beliebige andere Konfigurationsoptionen wie `-offvalue` und `-onvalue` entsprechend den *internen* Werten der Zellen festzulegen.  Da die Standardwerte der OPTIONEN `-offvalue` und `-onvalue` ttk::checkbutton lauten, müssen Sie diese OPTIONEN nicht ändern, wenn die Zellen die gleichen internen Werte `0` und `1` lauten, müssen Sie diese Optionen nicht ändern, wenn die Zellen die gleichen internen Werte `0` und `1` aufweisen.

**SCHLÜSSELWÖRTER**
: tablelist, editing, ttk::checkbutton


---

## Interaktive Zellbearbeitung mit dem Widget „ttk::menubutton“.

**BESCHREIBUNG**
: Das temporär eingebettete ttk::menubutton-Widget für die interaktive Zellenbearbeitung wird mit ausdrücklich gesetzten Werten seiner Optionen `-style` und `-textvariable` erzeugt. Zusätzlich wird ein Menü erzeugt, dessen Option `-tearoff` auf `0` gesetzt ist und das ein passendes Skript als Wert der Option `-postcommand` erhält, und dieses Menü wird als Wert der Option `-menu` der menubutton gesetzt. Unter X11 wird das Aussehen des Menüs an das Tablelist-Widget angepasst, indem die Optionen `-background`, `-foreground`, `-activebackground`, `-activeforeground` und `-activeborderwidth` auf passende Werte gesetzt werden. Mit dem Skript zur Tablelist-Konfigurationsoption `-editstartcommand` können Sie weitere Optionen der menubutton oder des zugehörigen Menüs setzen. Dieses Skript brauchen Sie vor allem, um das Menü zu füllen, vorzugsweise mit radiobutton-Einträgen. Für jeden dem Menü hinzugefügten radiobutton-Eintrag sorgt die Tablelist-Implementierung dafür, dass sein Wert (angegeben über die Option `-value` oder `-label` des Eintrags) beim Auswählen als Text der menubutton angezeigt wird. (Tablelist erreicht das, indem die Option `-variable` des Menüeintrags auf den Wert der Option `-textvariable` der menubutton gesetzt wird.) Bei Menüeinträgen eines anderen Typs als radiobutton (zum Beispiel command-Einträge) muss die Anwendung dafür sorgen, dass der Text des ausgewählten Eintrags in der menubutton erscheint, zum Beispiel über die Option `-command` des Menüeintrags.

**SCHLÜSSELWÖRTER**
: tablelist, editing, ttk::menubutton


---

## Interaktive Zellbearbeitung mit dem Widget „ttk::toggleswitch“.

**BESCHREIBUNG**
: Das temporäre, eingebettete ttk::toggleswitch-Widget, das für die interaktive Zellenbearbeitung verwendet wird, wird erstellt, wobei die Option `-size` auf `1` gesetzt ist.  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um die ursprünglichen Einstellungen nach Ihren Bedürfnissen zu überschreiben.

**SCHLÜSSELWÖRTER**
: tablelist, editing, ttk::toggleswitch


---

[Inhalt](#inhalt)     [Startseite](index.md)
