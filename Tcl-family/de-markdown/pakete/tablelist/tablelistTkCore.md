# Interaktive Bearbeitung von Tabellenzellen mithilfe von Tk-Core-Widgets

## Für Tablelist Version 7.12

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Interaktive Zellbearbeitung mithilfe des Eintrags „Widget](#interaktive-zellbearbeitung-mithilfe-des-eingabe-widgets)“]
- [Interaktive Zellbearbeitung mit dem Text-Widget](#interaktive-zellbearbeitung-mit-dem-text-widget)
- [Interaktive Zellbearbeitung mit dem Spinbox-Widget](#interaktive-zellbearbeitung-mithilfe-des-spinbox-widgets)
- [Interaktive Zellbearbeitung mit dem checkbutton-Widget](#interaktive-zellbearbeitung-mit-dem-checkbutton-widget)
- [Interaktive Zellbearbeitung mit dem Menüschaltflächen-Widget](#interaktive-zellbearbeitung-mit-dem-men-schaltfl-chen-widget)

[Startseite](index.md)

---

## Überblick

Tablelist unterstützt die interaktive Bearbeitung von Zellen mithilfe der Tk-Core-Widgets „entry“, „text“, „spinbox“, „checkbutton“ und „menubutton“. Diese Widgets werden automatisch für die Zellenbearbeitung registriert, sodass zur Verwendung eines dieser Widgets zur Bearbeitung der Zellen einer bestimmten Spalte lediglich folgender Schritt erforderlich ist:

Verwenden Sie den Unterbefehl `columnconfigure` des Tabellisten-Widgets, um die Spalte zu setzenOption `-editable` auf „true“ und die Option `-editwindow` auf `entry`, `text`, `spinbox`, `checkbutton` oder `menubutton` fest.  (Diese Optionen werden mithilfe des Unterbefehls `cellconfigure` auch auf Zellenebene unterstützt.)  Da der Standardwert der KONFIGURATIONSOPTIONEN für die Spalte `-editwindow` `entry` lautet, ist es nicht erforderlich, ihn explizit festzulegen, wenn die Bearbeitung mithilfe eines eingebetteten Widgets erfolgen soll.

**HINWEIS:**  Das temporär eingebettete Tk-Core-Widget, das für die interaktive Bearbeitung von Zellen verwendet wird, wird entsprechend der DPI-Skalierung des Bildschirms und dem durch `[tk scaling]` vorgegebenen Skalierungsfaktor von Tk korrekt skaliert angezeigt.

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Interaktive Zellbearbeitung mithilfe des Eingabe-Widgets

**BESCHREIBUNG**
: Wie oben erwähnt, erfolgt die interaktive Zellbearbeitung in einem Tablelist-Widget standardmäßig mithilfe eines eingebetteten Eingabe-Widgets.  Einzelheiten zum Bearbeitungsprozess finden Sie im Abschnitt [INTERACTIVE CELL EDITING](tablelistWidget.md#ausf-hrliche-referenz) der Referenzseite, in dem der Befehl `tablelist::tablelist` beschrieben wird.

**SCHLÜSSELWÖRTER**
: tablelist, editing, entry


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Interaktive Zellbearbeitung mit dem Text-Widget

**BESCHREIBUNG**
: Das temporäre eingebettete Text-Widget, das für die interaktive Zellbearbeitung verwendet wird, wird so erstellt, dass seine OPTIONEN `-padx` und `-pady` auf `2` gesetzt sind, die Option `-wrap` auf `none` und die anfängliche Höhe auf die Anzahl der darin enthaltenen Zeilen.  Es gibt jedoch eine Ausnahme von dieser Regel:  Wenn die Option `-wrap` der Spalte der Zelle auf „true“ gesetzt wurde und Tk Version 8.5 oder höher verwendet wird, dann wird die Option `-wrap` des Text-Widgets auf `word` gesetzt und seine Anfangshöhe entspricht der Anzahl der darin enthaltenen *angezeigten* Zeilen (unter Berücksichtigung der Zeilenumbrüche).  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um die Anfangseinstellungen (mit Ausnahme der Höhe) nach Ihren Bedürfnissen zu überschreiben.

: Wenn die Option `-wrap` des Text-Widgets auf `word` oder `char` gesetzt wurde (entweder durch „Tablelist“ oder innerhalb des oben genannten Skripts) und es wird Tk Version 8.5 oder höher verwendet, wird bei jeder Änderung seiner Breite (z. B. durch interaktive Anpassung der Spalten) seine Höhe automatisch auf die Anzahl der darin enthaltenen Anzeigezeilen gesetzt.  (Die Anzahl der Anzeigezeilen wird mithilfe des in Tk 8.5 eingeführten Text-Widget-Unterbefehls ``count -displaylines`` ermittelt.)

: Wenn das Widget-Rückruffunktion-Paket „Wcb“ in den Interpreter geladen wurde (über  `package require Wcb`  oder  `package require wcb`),  wird die Höhe des Text-Widgets automatisch aktualisiert, sobald Text eingefügt oder gelöscht wird, was die Bearbeitung wesentlich benutzerfreundlicher macht.  Dies wird durch die Verwendung einer entsprechend definierten Rückruffunktion „after-`insert`“ und „after-`delete`“ für das Bearbeitungsfenster erreicht.  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um weitere Callbacks für das Text-Widget zu definieren.  (Der oben erwähnte Callback wird über `wcb::cbappend` erstellt, *nach* der Rückkehr aus diesem Skript.)

: Die Taste `Tab` ist für die Navigation zwischen den bearbeitbaren Zellen reserviert, der Benutzer kann jedoch durch Drücken der Taste `Control-i` ein Tabulatorzeichen in das Text-Widget einfügen.

: Im Gegensatz zu den anderen Widgets, die für die interaktive Zellenbearbeitung verwendet werden, fügen die Tasten `Return` und `KP_Enter` ein Zeilenumbruchzeichen in das Text-Widget ein.  Auch `Control-j` kann zum Einfügen eines Zeilenumbruchs verwendet werden. `Control-Return` und `Control-KP_Enter` beenden die Bearbeitung und schließen das Bearbeitungsfenster.

: `Control-Home` und `Control-End` verfügen über ihre bekannten, für Text-Widgets spezifischen Bindungen, genau wie `Meta-<` und `Meta->`, wenn `tk_strictMotif` auf „false“ gesetzt ist. Auch dies unterscheidet sich vom Verhalten der anderen Widgets, die für die interaktive Zellbearbeitung verwendet werden.  Um zur ersten bzw. letzten bearbeitbaren Zelle zu springen, kann der Benutzer `Alt-Home`/`Alt-End` oder `Meta-Home`/`Meta-End` (`Command-Home`/`Command-End` unter Mac OS X/11+ Aqua).

**SCHLÜSSELWÖRTER**
: tablelist, editing, text


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Interaktive Zellbearbeitung mithilfe des Spinbox-Widgets

**BESCHREIBUNG**
: Das temporäre, eingebettete Spinbox-Widget, das für die interaktive Bearbeitung von Zellen verwendet wird, wird so erstellt, dass die Option `-state` auf `normal` gesetzt ist, wodurch das Widget bearbeitbar wird.  Sie können das Skript verwenden, das der Konfigurationsoption `-editstartcommand` der Tablelist entspricht, um den Status der Spinbox auf `readonly` zu setzen oder VALIDIERUNGEN dafür zu definieren, sowie zur Festlegung ihres Wertebereichs und ihrer Option `-wrap`.

**SCHLÜSSELWÖRTER**
: tablelist, editing, spinbox


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Interaktive Zellbearbeitung mit dem checkbutton-Widget

**BESCHREIBUNG**
: Unter Windows und Mac OS X/11+ Aqua wird das temporäre, eingebettete checkbutton-Widget, das für die interaktive Zellbearbeitung verwendet wird, mit explizit festgelegten Werten für die Optionen `-borderwidth`, `-font`, `-padx`, `-pady` und `-variable` erstellt.  In einer X11-Umgebung wird es mit explizit festgelegten Werten für die Optionen `-borderwidth`, `-indicatoron`, `-image`, `-selectimage`, `-background`, `-activebackground`, `-selectcolor` und `-variable` erstellt.  Sie können das Skript verwenden, das der Tablelist-KONFIGURATIONSOPTIONEN-Option `-editstartcommand` entspricht, um beliebige andere Optionen wie `-offvalue` und `-onvalue` entsprechend den *internen* Werten der Zellen festzulegen.  Da die Standardwerte der checkbutton-Optionen `-offvalue` und `-onvalue` `0` und `1` lauten, Sie müssen diese Optionen nicht ändern, wenn die Zellen die gleichen internen Werte `0` und `1` haben.

**SCHLÜSSELWÖRTER**
: tablelist, editing, checkbutton


---

## Interaktive Zellbearbeitung mit dem Menüschaltflächen-Widget

**BESCHREIBUNG**
: Das temporär eingebettete menubutton-Widget für die interaktive Zellenbearbeitung wird mit ausdrücklich gesetzten Werten seiner Optionen `-anchor`, `-indicatoron`, `-justify`, `-padx`, `-pady`, `-relief` und `-textvariable` erzeugt. Zusätzlich wird ein Menü erzeugt, dessen Option `-tearoff` auf `0` gesetzt ist und das ein passendes Skript als Wert der Option `-postcommand` erhält, und dieses Menü wird als Wert der Option `-menu` der menubutton gesetzt. Unter X11 wird das Aussehen des Menüs an das Tablelist-Widget angepasst, indem die Optionen `-background`, `-foreground`, `-activebackground`, `-activeforeground` und `-activeborderwidth` auf passende Werte gesetzt werden. Mit dem Skript zur Tablelist-Konfigurationsoption `-editstartcommand` können Sie weitere Optionen der menubutton oder des zugehörigen Menüs setzen. Dieses Skript brauchen Sie vor allem, um das Menü zu füllen, vorzugsweise mit radiobutton-Einträgen. Für jeden dem Menü hinzugefügten radiobutton-Eintrag sorgt die Tablelist-Implementierung dafür, dass sein Wert (angegeben über die Option `-value` oder `-label` des Eintrags) beim Auswählen als Text der menubutton angezeigt wird. (Tablelist erreicht das, indem die Option `-variable` des Menüeintrags auf den Wert der Option `-textvariable` der menubutton gesetzt wird.) Bei Menüeinträgen eines anderen Typs als radiobutton (zum Beispiel command-Einträge) muss die Anwendung dafür sorgen, dass der Text des ausgewählten Eintrags in der menubutton erscheint, zum Beispiel über die Option `-command` des Menüeintrags.

**SCHLÜSSELWÖRTER**
: tablelist, editing, menubutton


[Inhalt](#inhalt)     [Startseite](index.md)
