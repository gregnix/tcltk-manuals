# Wcb-Befehlsreferenz

## Für Wcb Version 4.2

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Der Befehl wcb::callback](#der-befehl-wcb-callback)
- [Der Befehl wcb::cbappend](#der-befehl-wcb-cbappend)
- [Der Befehl wcb::cbprepend](#der-befehl-wcb-cbprepend)
- [Der Befehl wcb::cancel](#der-befehl-wcb-cancel)
- [Der Befehl wcb::canceled](#der-befehl-wcb-canceled)
- [Der Befehl wcb::extend](#der-befehl-wcb-extend)
- [Der Befehl wcb::replace](#der-befehl-wcb-replace)
- [Der Befehl wcb::pathname](#der-befehl-wcb-pathname)
- [Der Befehl wcb::changeEntryText](#der-befehl-wcb-changeentrytext)
- [Der Befehl wcb::postInsertEntryLen](#der-befehl-wcb-postinsertentrylen)
- [Der Befehl wcb::postInsertEntryText](#der-befehl-wcb-postinsertentrytext)
- [Der Befehl wcb::postDeleteEntryText](#der-befehl-wcb-postdeleteentrytext)
- [before-insert-Rückruffunktionen für entry-, spinbox- und combobox-Widgets](#before-insert-r-ckruffunktionen-f-r-entry-spinbox-und-combobox-widgets)
- [before-insert-Rückruffunktionen für text- und ctext-Widgets](#before-insert-r-ckruffunktionen-f-r-text-und-ctext-widgets)

[Startseite](index.md)

---

## Der Befehl `wcb::callback`

**NAME**
: `wcb::callback` – Widget-Rückruffunktionen abfragen, setzen und entfernen

**ÜBERSICHT**
: 

```
wcb::callback widgetName before|after option ?callback callback ...?
```

**BESCHREIBUNG**
: Fragt die Rückruffunktionen für das Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox-, Ttk-combobox-, listbox-, tablelist-, Ttk-treeview-, text- oder ctext-Widget `widgetName`, das Argument `before` oder `after` und den Befehl zu `option` ab, setzt sie oder entfernt sie. Die Werte des Arguments `option` können sein:


  - `insert`, `delete` oder `motion`, für ein Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox-, Ttk-combobox-, text- oder ctext-Widget;
  - `replace`, für ein text- oder ctext-Widget;
  - `activate`, für ein listbox-, tablelist- oder Ttk-treeview-Widget;
  - `selset` oder `selclear`, für ein listbox-, tablelist-, Ttk-treeview-, text- oder ctext-Widget;
  - `seladd` oder `seltoggle`, für ein Ttk-treeview-Widget;
  - `cellselset` oder `cellselclear`, für ein tablelist- oder Ttk-treeview-Widget;
  - `cellseladd` oder `cellseltoggle`, für ein Ttk-treeview-Widget;
  - `activatecell`, für ein tablelist-Widget.

: Ist nach dem Parameter `option` kein Argument angegeben, gibt die Prozedur nur die aktuelle before- bzw. after-Rückruffunktionsliste für die gegebene Widget-Operation zurück.

: Andernfalls:


  - Ist mindestens eines der Argumente nach dem Parameter `option` eine nichtleere Zeichenkette, dann:
  - Sind alle Argumente nach dem Parameter `option` leer, hebt die Prozedur die Eintragung aller zugehörigen before- oder after-Rückruffunktionen für das gegebene Widget auf und gibt eine leere Zeichenkette zurück.

    - wird der Befehl für dieses Widget zum ersten Mal mit mindestens einem nichtleeren Argument nach dem Parameter `option` aufgerufen, benennt die Prozedur den Tcl-Befehl `::widgetName` in `::_widgetName` um und baut eine neue Prozedur `::widgetName`, in der die Ausführung der Widget-Operationen zu den oben genannten Werten von `option` von Aufrufen der zugehörigen before-Rückruffunktionen eingeleitet und von Aufrufen der zugehörigen after-Rückruffunktionen im globalen Geltungsbereich gefolgt wird;
    - sie setzt die Rückruffunktionsliste auf die aus diesen Argumenten gebildete Liste und gibt die neue Liste zurück.

: Wird eine Rückruffunktion für das Widget `widgetName` aufgerufen, werden der Name des **Proxy-Befehls** `::_widgetName` und die Befehlsargumente automatisch als Parameter angehängt. Mit dem Befehl `wcb::pathname` holen Sie den ursprünglichen Widget-Pfadnamen.

: Die folgende Tabelle zeigt die Widget-Unterbefehle zu den oben genannten Werten von `option`, zusammen mit den Argumenten dieser Unterbefehle:


| Widget | `option` | Unterbefehl | Argumente |
| --- | --- | --- | --- |
| Tk entry, ttk::entry,    BWidget Entry,    Tk spinbox, ttk::spinbox,    oder ttk::combobox | `insert` | `insert` | `index string` |
| `delete` | `delete` | `from ?to?` |
| `motion` | `icursor` | `index` |
| listbox | `activate` | `activate` | `index` |
| `selset` | `selection set` | `first ?last?` |
| `selclear` | `selection clear` | `first ?last?` |
| tablelist::tablelist | `activate` | `activate` | `index` |
| `selset` | `selection set` | `first ?last?`   (`indexList`   oder  `firstIndex lastIndex`) |
| `selclear` | `selection clear` | `first ?last?`   (`indexList`   oder  `firstIndex lastIndex`) |
| `activatecell` | `activatecell` | `cellIndex` |
| `cellselset` | `cellselection set` | `first ?last?`   (`cellIndexList`   oder  `firstCell lastCell`) |
| `cellselclear` | `cellselection clear` | `first ?last?`   (`cellIndexList`   oder  `firstCell lastCell`) |
| ttk::treeview | `activate` | `focus` | `item` |
| `selset` | `selection set` | `itemList` |
| `seladd` | `selection add` | `itemList` |
| `selclear` | `selection remove` | `itemList` |
| `seltoggle` | `selection toggle` | `itemList` |
| `cellselset` | `cellselection set` | `first ?last?`   (`cellList`   oder  `firstCell lastCell`) |
| `cellseladd` | `cellselection add` | `first ?last?`   (`cellList`   oder  `firstCell lastCell`) |
| `cellselclear` | `cellselection remove` | `first ?last?`   (`cellList`   oder  `firstCell lastCell`) |
| `cellseltoggle` | `cellselection toggle` | `first ?last?`   (`cellList`   oder  `firstCell lastCell`) |
| text oder ctext | `insert` | `insert` | `index string ?tagList string tagList ...?` |
| `delete` | `delete` | `from ?to?` |
| `replace` | `replace` | `from to string ?tagList string tagList ...?` |
| `motion` | `mark set insert` | `index` |
| `selset` | `tag add sel` | `from ?to from to ...?` |
| `selclear` | `tag remove sel` | `from ?to from to ...?` |

: **HINWEISE:**


  1. Die Wörter `before`, `after`, `insert`, `delete`, `replace`, `motion` und `activate` (letzteres nicht bei tablelist-Widgets) dürfen Sie auf mindestens ein Zeichen kürzen. Ebenso genügen die ersten vier Zeichen der Wörter `selset`, `selclear`, `seladd` und `seltoggle`, die ersten acht Zeichen von `cellselset`, `cellselclear`, `cellseladd` und `cellseltoggle` und die ersten neun Zeichen von `activatecell`, damit Wcb diese Optionen erkennt.
  2. Nach einem erfolgreichen Aufruf dieses Befehls mit mindestens einer nichtleeren Rückruffunktion nach dem Argument `option` können Sie entweder die neue Prozedur `widgetName` oder den Proxy-Befehl `::_widgetName` verwenden, um jede gültige Operation auf dem Widget `widgetName` auszuführen. Verwenden Sie den Proxy-Befehl `::_widgetName`, wenn die Rückruffunktionen beim Ausführen des jeweiligen Widget-Unterbefehls nicht aufgerufen werden sollen.
  3. Wird ein Widget `widgetName` zerstört, für das `wcb::callback` den zugehörigen Tcl-Befehl durch eine neue Prozedur ersetzt hat, löscht der Tcl-Interpreter den Proxy-Befehl `::_widgetName` automatisch. Das gilt nicht für ein BWidget Entry, ein tablelist- oder ein ctext-Widget. Die neue Widget-Prozedur `widgetName` bliebe bestehen, Wcb sorgt aber dafür, dass sie aus einem Aufräumskript gelöscht wird, das an das Ereignis `<Destroy>` gebunden ist. Dieses Aufräumskript gehört zu einem Bindungs-Tag namens `WcbCleanup`, das der Liste der Bindungs-Tags des Widgets angehängt wird, wenn zum ersten Mal Rückruffunktionen dafür eingetragen werden. Bei einem BWidget Entry, einem tablelist- oder einem ctext-Widget löscht dieses Skript auch den Proxy-Befehl `::_widgetName`.
  4. Das genannte Aufräumskript hebt außerdem die Eintragung aller für `widgetName` festgelegten Rückruffunktionen auf. Ein später mit demselben Pfad erzeugtes Widget erbt sie dadurch nicht von dem gerade gelöschten Widget. Das kann in manchen Anwendungen wichtig sein. Entfernen Sie `WcbCleanup` deshalb nicht aus der Liste der Bindungs-Tags des gegebenen Widgets.

**SCHLÜSSELWÖRTER**
: callback, widget, Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, listbox, tablelist, Ttk treeview, text, ctext


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `wcb::cbappend`

**NAME**
: `wcb::cbappend` – An eine Rückruffunktionsliste anhängen

**ÜBERSICHT**
: 

```
wcb::cbappend widgetName before|after option ?callback callback ...?
```

**BESCHREIBUNG**
: Dieser Befehl ist nahezu identisch mit `wcb::callback`. Der einzige Unterschied: `wcb::cbappend` *hängt* die nach dem Parameter `option` angegebenen Argumente an die aktuelle Rückruffunktionsliste an, falls eine vorhanden ist, während `wcb::callback` die alten Rückruffunktionen durch diese Argumente *ersetzt*.

**SCHLÜSSELWÖRTER**
: callback, append, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `wcb::cbprepend`

**NAME**
: `wcb::cbprepend` – Einer Rückruffunktionsliste voranstellen

**ÜBERSICHT**
: 

```
wcb::cbprepend widgetName before|after option ?callback callback ...?
```

**BESCHREIBUNG**
: Dieser Befehl ist nahezu identisch mit `wcb::callback`. Der einzige Unterschied: `wcb::cbprepend` *stellt* die nach dem Parameter `option` angegebenen Argumente der aktuellen Rückruffunktionsliste *voran*, falls eine vorhanden ist, während `wcb::callback` die alten Rückruffunktionen durch diese Argumente *ersetzt*.

**SCHLÜSSELWÖRTER**
: callback, prepend, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `wcb::cancel`

**NAME**
: `wcb::cancel` – Einen Widget-Befehl abbrechen

**ÜBERSICHT**
: 

```
wcb::cancel ?script?
```

**BESCHREIBUNG**
: Diese Prozedur ist dafür gedacht, aus einer before-Rückruffunktion für einen Widget-Befehl aufgerufen zu werden. Sie bricht die Ausführung dieses Befehls und der übrigen Rückruffunktionen ab und wertet das Argument `script` im globalen Geltungsbereich aus. Ist dieses Argument nicht angegeben, ist die Vorgabe der Befehl `bell`.

: Der Rückgabewert ist der von `script`, wenn dieses Argument angegeben und nichtleer ist. Sonst gibt der Befehl eine leere Zeichenkette zurück.

**SCHLÜSSELWÖRTER**
: cancel, command, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `wcb::canceled`

**NAME**
: `wcb::canceled` – Den Abbruchzustand eines Widget-Befehls abfragen

**ÜBERSICHT**
: 

```
wcb::canceled widgetName option
```

**BESCHREIBUNG**
: Gibt den Wert `1` zurück, wenn der jüngste Aufruf der Widget-Operation zu `widgetName` und `option` von einer before-Rückruffunktion durch den Aufruf von `wcb::cancel` abgebrochen wurde; sonst ist der Rückgabewert `0`. Die Argumente müssen dieselben Einschränkungen erfüllen wie beim Befehl `wcb::callback`.

**SCHLÜSSELWÖRTER**
: cancel, command, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `wcb::extend`

**NAME**
: `wcb::extend` – Die Argumentliste eines Widget-Befehls erweitern

**ÜBERSICHT**
: 

```
wcb::extend ?arg arg ...?
```

**BESCHREIBUNG**
: Diese Prozedur ist dafür gedacht, aus einer before-Rückruffunktion für einen Widget-Befehl aufgerufen zu werden. Sie hängt die in den optionalen Parametern `arg` gegebenen Werte an die Argumentliste dieses Befehls an. Die neue Argumentliste wird auch an die übrigen Rückruffunktionen für diesen Befehl weitergegeben.

: Diese Prozedur gibt ihre Parameter einfach an den Befehl `lappend` weiter, aufgerufen für die Argumentliste der jeweiligen Widget-Operation.

**SCHLÜSSELWÖRTER**
: extend, argument, command, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `wcb::replace`

**NAME**
: `wcb::replace` – Argumente eines Widget-Befehls durch neue ersetzen

**ÜBERSICHT**
: 

```
wcb::replace first last ?arg arg ...?
```

**BESCHREIBUNG**
: Diese Prozedur ist dafür gedacht, aus einer before-Rückruffunktion für einen Widget-Befehl aufgerufen zu werden. Sie ersetzt die Argumente mit den Indizes `first` bis `last` dieses Befehls durch die optionalen Parameter `arg`. Die neue Argumentliste wird auch an die übrigen Rückruffunktionen für diesen Befehl weitergegeben. Die Argumente sind ab `0` nummeriert (siehe die Tabelle in der Beschreibung des Befehls `wcb::callback`).

: Diese Prozedur gibt ihre Parameter einfach an den Befehl `lreplace` weiter, aufgerufen für die Argumentliste der jeweiligen Widget-Operation.

**SCHLÜSSELWÖRTER**
: replace, argument, command, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `wcb::pathname`

**NAME**
: `wcb::pathname` – Den Pfadnamen des Widgets zu einem Tcl-Befehlsnamen abfragen

**ÜBERSICHT**
: 

```
wcb::pathname proxyCmd
```

**BESCHREIBUNG**
: Diese Prozedur gibt den Pfadnamen des Widgets zurück, das zu dem Tcl-Befehlsnamen `proxyCmd` gehört, der an eine Rückruffunktion übergeben wurde.

: Wird eine before- oder after-Rückruffunktion für ein Widget aufgerufen, wird der Name des zugehörigen Proxy-Befehls automatisch als Parameter angehängt. Innerhalb einer Rückruffunktion holt diese Prozedur den Pfadnamen des Widgets aus dem Befehlsnamen, der der Rückruffunktion als Argument übergeben wurde. Sie gibt einfach den Zeichenkettenbereich zurück, der aus `proxyCmd` durch Entfernen des Präfixes `"::_"` entsteht.

**SCHLÜSSELWÖRTER**
: path name, command, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `wcb::changeEntryText`

**NAME**
: `wcb::changeEntryText` – Den Text eines Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widgets ändern

**ÜBERSICHT**
: 

```
wcb::changeEntryText widgetName string
```

**BESCHREIBUNG**
: Ersetzt den Text des Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widgets `widgetName` durch `string`, über die Operationen `delete` und `insert`. Bricht eine before-`delete`-Rückruffunktion den ersten Unterbefehl ab, kehrt die Prozedur zurück, ohne den neuen Text einzufügen. Bricht eine before-`insert`-Rückruffunktion die zweite Operation ab, stellt der Befehl den ursprünglichen Inhalt des Widgets wieder her.

: Die Prozedur behält die Position der Einfügemarke bei. Der Rückgabewert ist `1` bei Erfolg und `0` bei Fehlschlag, also wenn eine der versuchten Operationen von einer before-Rückruffunktion abgebrochen wurde.

**SCHLÜSSELWÖRTER**
: Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `wcb::postInsertEntryLen`

**NAME**
: `wcb::postInsertEntryLen` – Die Länge abfragen, die der Text in einem Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widget nach dem Einfügen hätte

**ÜBERSICHT**
: 

```
wcb::postInsertEntryLen widgetName string
```

**BESCHREIBUNG**
: Gibt die Länge des Textes zurück, den das Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widget `widgetName` nach dem Einfügen von `string` enthielte.

**SCHLÜSSELWÖRTER**
: insert, Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `wcb::postInsertEntryText`

**NAME**
: `wcb::postInsertEntryText` – Den Text abfragen, den ein Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widget nach dem Einfügen hätte

**ÜBERSICHT**
: 

```
wcb::postInsertEntryText widgetName index string
```

**BESCHREIBUNG**
: Gibt den Text zurück, den das Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widget `widgetName` enthielte, nachdem `string` vor dem Zeichen eingefügt wurde, das `index` bezeichnet.

**SCHLÜSSELWÖRTER**
: insert, Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `wcb::postDeleteEntryText`

**NAME**
: `wcb::postDeleteEntryText` – Den Text abfragen, den ein Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widget nach dem Löschen hätte

**ÜBERSICHT**
: 

```
wcb::postDeleteEntryText widgetName from ?to?
```

**BESCHREIBUNG**
: Gibt den Text zurück, den das Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widget `widgetName` enthielte, nachdem die Zeichen ab dem von `from` bezeichneten und unmittelbar vor `to` gelöscht wurden. Ist `to` nicht angegeben, ist der Rückgabewert der Text, den das Widget nach dem Löschen des einzelnen von `from` gegebenen Zeichens enthielte.

: **HINWEIS:** Dieser Befehl hat eine veränderliche Anzahl von Argumenten (2 oder 3), weil der Unterbefehl `delete` des zu `widgetName` gehörenden Tcl-Befehls entweder einen oder zwei Indizes als Argumente erwartet. Der richtige Aufruf aus einer before-`delete`-Rückruffunktion sieht deshalb so aus wie im folgenden Beispiel:


```
proc myBeforeDeleteCallback {w args} {
    #
    # Get the text that would be contained in the widget after
    # deleting the characters specified by $args, which stands
    # for the one or two arguments passed to delete; pass these
    # arguments to wcb::postDeleteEntryText by expanding $args
    #
    set newText [eval [list wcb::postDeleteEntryText $w] $args]
    if {!some_condition_on_$newText} {
        wcb::cancel
    }
}
```

: Die folgende alternative, elegantere Lösung braucht Tcl/Tk 8.5 oder neuer:


```
proc myBeforeDeleteCallback {w args} {
    # . . .
    set newText [wcb::postDeleteEntryText $w {*}$args]
    . . .
}
```

**SCHLÜSSELWÖRTER**
: delete, Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## before-`insert`-Rückruffunktionen für entry-, spinbox- und combobox-Widgets

**NAME**
: `wcb::checkStrFor*`, `wcb::convStrTo*`, `wcb::checkEntryFor*`, `wcb::checkEntryLen` – before-`insert`-Rückruffunktionen für Tk-entry-, Ttk-entry-, BWidget-Entry-, Tk-spinbox-, Ttk-spinbox- und Ttk-combobox-Widgets

**ÜBERSICHT**
: 

```
wcb::checkStrForRegExp  exp w idx str

wcb::checkStrForAlpha       w idx str
wcb::checkStrForNum         w idx str
wcb::checkStrForAlnum       w idx str

wcb::convStrToUpper         w idx str
wcb::convStrToLower         w idx str

wcb::checkEntryForInt       w idx str
wcb::checkEntryForUInt  max w idx str
wcb::checkEntryForReal      w idx str
wcb::checkEntryForFixed cnt w idx str

wcb::checkEntryLen      len w idx str
```

**BESCHREIBUNG**
: Die Rückruffunktion `wcb::checkStrForRegExp` prüft, ob der reguläre Ausdruck `exp` die Zeichenkette `str` trifft, die in das Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widget `w` eingefügt werden soll. Trifft er sie nicht, bricht sie die Operation `insert` ab.

: Die drei anderen Rückruffunktionen `wcb::checkStrFor*` prüfen, ob die Zeichenkette `str`, die in das Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widget `w` eingefügt werden soll, alphabetisch, numerisch bzw. alphanumerisch ist. Ist sie es nicht, brechen sie die Operation `insert` ab. Diese Prozeduren rufen nur die Rückruffunktion `wcb::checkStrForRegExp` auf und übergeben ihr die Unicode-Muster `{^[[:alpha:]]*$}`, `{^[[:digit:]]*$}` und `{^[[:alnum:]]*$}`.

: Die Rückruffunktionen `wcb::convStrTo*` ersetzen die Zeichenkette `str`, die in das Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widget `w` eingefügt werden soll, durch ihre Entsprechung in Groß- bzw. Kleinbuchstaben.

: Die Rückruffunktionen `wcb::checkEntryFor*` prüfen, ob der Text im Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widget `w` nach dem Einfügen der Zeichenkette `str` vor dem Zeichen, das der Index `idx` bezeichnet, der Anfang einer ganzen Zahl, einer vorzeichenlosen ganzen Zahl nicht größer als `max`, einer reellen Zahl bzw. einer reellen Zahl im Festkommaformat mit höchstens `cnt` Stellen nach dem Dezimalpunkt wäre. Ist das nicht der Fall, brechen sie die Operation `insert` ab. `max` und `cnt` sollen nichtnegative Zahlen oder `*` sein. `max = *` bedeutet: keine obere Schranke für den Wert des Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widgets, während `cnt = *` für eine unbegrenzte Anzahl von Stellen nach dem Dezimalpunkt steht.

: Die Rückruffunktion `wcb::checkEntryLen` prüft, ob die Länge des Textes im Tk- oder Ttk-entry-, BWidget-Entry-, Tk- oder Ttk-spinbox- oder Ttk-combobox-Widget `w` nach dem Einfügen der Zeichenkette `str` größer als `len` wäre. Ist das der Fall, bricht sie die Operation `insert` ab.

: Diese Rückruffunktionen sind in der Datei `wcbEntry.tcl` im Verzeichnis `scripts` implementiert. Sie geben eine leere Zeichenkette zurück.

**SCHLÜSSELWÖRTER**
: callback, insert, Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## before-`insert`-Rückruffunktionen für text- und ctext-Widgets

**NAME**
: `wcb::checkStrsFor*`, `wcb::convStrsTo*` – before-`insert`-Rückruffunktionen für text- und ctext-Widgets

**ÜBERSICHT**
: 

```
wcb::checkStrsForRegExp exp w idx args

wcb::checkStrsForAlpha      w idx args
wcb::checkStrsForNum        w idx args
wcb::checkStrsForAlnum      w idx args

wcb::convStrsToUpper        w idx args
wcb::convStrsToLower        w idx args
```

**BESCHREIBUNG**
: Die Rückruffunktion `wcb::checkStrsForRegExp` prüft, ob der reguläre Ausdruck `exp` die Zeichenketten trifft, die in das text- oder ctext-Widget `w` eingefügt werden sollen und in der Liste `args` der Form `string ?tagList string tagList ...?` stehen. Trifft er sie nicht, bricht sie die Operation `insert` ab.

: Die drei anderen Rückruffunktionen `wcb::checkStrsFor*` prüfen, ob die Zeichenketten, die in das text- oder ctext-Widget `w` eingefügt werden sollen und in der Liste `args` der Form `string ?tagList string tagList ...?` stehen, alphabetisch, numerisch bzw. alphanumerisch sind. Sind sie es nicht, brechen sie die Operation `insert` ab. Diese Prozeduren rufen nur die Rückruffunktion `wcb::checkStrsForRegExp` auf und übergeben ihr die Unicode-Muster `{^[[:alpha:]\n]*$}`, `{^[[:digit:]\n]*$}` und `{^[[:alnum:]\n]*$}`.

: Die Rückruffunktionen `wcb::convStrsTo*` ersetzen die Zeichenketten, die in das text- oder ctext-Widget `w` eingefügt werden sollen und in der Liste `args` der Form `string ?tagList string tagList ...?` stehen, durch ihre Entsprechungen in Groß- bzw. Kleinbuchstaben.

: Diese Rückruffunktionen sind in der Datei `wcbText.tcl` im Verzeichnis `scripts` implementiert. Sie geben eine leere Zeichenkette zurück.

**SCHLÜSSELWÖRTER**
: callback, insert, text, ctext, widget


[Inhalt](#inhalt)     [Startseite](index.md)
