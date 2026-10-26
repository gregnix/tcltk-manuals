# Das `scrollutil::scrollarea` und  
 `scrollutil::getscrollarea` BEFEHLE

## Für Scrollutil Version 2.11

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Der Befehl scrollutil::scrollarea – Kurzreferenz](#der-befehl-scrollutil-scrollarea-kurzreferenz)
- [Der Befehl scrollutil::scrollarea – Ausführliche Referenz](#der-befehl-scrollutil-scrollarea-ausf-hrliche-referenz)
- [Der Befehl scrollutil::getscrollarea](#der-befehl-scrollutil-getscrollarea)

[Startseite](index.md)

---

## Der Befehl `scrollutil::scrollarea` – Kurzreferenz

[NAME](#der-befehl-scrollutil-scrollarea-ausf-hrliche-referenz)
: `scrollutil::scrollarea` – Erstellen und Bearbeiten von Scrollarea-Widgets

[ÜBERSICHT](#der-befehl-scrollutil-scrollarea-ausf-hrliche-referenz)
: 

```
scrollutil::scrollarea pathName ?options?
```

[STANDARDOPTIONEN](#der-befehl-scrollutil-scrollarea-ausf-hrliche-referenz)
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor
-cursor       -highlightthickness
```

[WIDGET-SPEZIFISCHE OPTIONEN](#der-befehl-scrollutil-scrollarea-ausf-hrliche-referenz)
: `-autohidescrollbars boolean`

: `-lockinterval milliseconds`

: `-respectheader boolean`

: `-respecttitlecolumns boolean`

: `-setfocus boolean`

: `-takefocus 0|1|""|command`

: `-xscrollbarmode static|dynamic|none`

: `-yscrollbarmode static|dynamic|none`

[Widget COMMAND](#der-befehl-scrollutil-scrollarea-ausf-hrliche-referenz)
: `pathName attrib ?name ?value name value ...??`

: `pathName cget option`

: `pathName configure ?option ?value option value ...??`

: `pathName hasattrib name`

: `pathName setwidget widget`

: `pathName unsetattrib name`

: `pathName widget`

[SCHLÜSSELWÖRTER](#der-befehl-scrollutil-scrollarea-ausf-hrliche-referenz)
: Bildlaufbereich, Widget, Bildlaufleiste


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::scrollarea` – Ausführliche Referenz

**NAME**
: `scrollutil::scrollarea` – Erstellen und Bearbeiten von Scrollarea-Widgets

**ÜBERSICHT**
: 

```
scrollutil::scrollarea pathName ?options?
```

**BESCHREIBUNG**
: Der Befehl `scrollutil::scrollarea` erstellt ein neues Fenster mit dem Namen `pathName` und der Klasse `Scrollarea` und wandelt es in ein **scrollarea**-Widget um.  Zusätzliche Optionen, die im Folgenden beschrieben werden, können über die Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des **scrollarea**-Widgets zu konfigurieren, wie beispielsweise die Rahmenbreite, die Relief-Einstellung und den Anzeigemodus für die Bildlaufleisten.  Der Befehl `scrollutil::scrollarea` gibt sein Argument `pathName` zurück.  Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen `pathName` vorhanden sein, aber das übergeordnete Fenster von `pathName` muss vorhanden sein.

: Ein Scrollarea ist ein Megawidget, das aus einem scrollbaren Widget – das mithilfe des Unterbefehls `setwidget` des zugehörigen Tcl-Befehls festgelegt wird – sowie zwei mit diesem Widget verbundenen Bildlaufleisten besteht.  Diese Komponenten werden innerhalb der Scrollarea mithilfe von `grid` verwaltet. Die Bildlaufleisten mit den Namen `hsb` (zusammen mit `-orient horizontal`)  und `vsb` (zusammen mit `-orient vertical`)  sind direkte untergeordnete Elemente des scrollarea.  Der Anzeigemodus jeder Bildlaufleiste kann `static`, `dynamic` oder `none` lauten (siehe die Konfigurationsoptionen `-xscrollbarmode` und `-yscrollbarmode`).  Die Option `-takefocus` beider Bildlaufleisten ist auf `0` gesetzt.  Im Paket „Scrollutil_tile“ werden die Bildlaufleisten als ttk::scrollbar-Widgets erstellt, außer unter Mac OS X/11+ bei Verwendung einer Tk-Version vor 8.6.10, wo das native ttk::scrollbar-Widget des `aqua`-Themas noch nicht wie erwartet aussah.

: Wenn das über `setwidget` in den Scrollbereich eingebettete Widget ein [tablelist](https://www.nemethi.de/tablelist/) und Tablelist Version 6.5 oder höher verwendet wird, kann der Scrollbereich auch gleichrangige Elemente des Tablelist-Widgets oberhalb der vertikalen Bildlaufleiste und/oder links von der horizontalen Bildlaufleiste enthalten, was dazu führt, dass die vertikale Bildlaufleiste unterhalb der Kopfzeile der Tablelist angezeigt wird und/oder die horizontale Bildlaufleiste rechts neben dem Titelbereich der Tablelist erscheint, abhängig von den Werten der Konfigurationsoptionen `-respectheader` und `-respecttitlecolumns`.

: Das folgende Beispiel zeigt die typischen Schritte zum Erstellen eines Widgets innerhalb eines Scrollbereichs:

```
set sa [scrollutil::scrollarea ...]
set lb [listbox $sa.lb ...]
$sa setwidget $lb

pack $sa -expand yes -fill both
```

**STANDARDOPTIONEN**
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor
-cursor       -highlightthickness
```

: Weitere Informationen zu den Standardoptionen für Tk-Widgets finden Sie im Handbucheintrag zu den **options**. Die Optionen `-background`, `-highlightbackground`, `-highlightcolor` und `-highlightthickness` werden nur vom Scrollutil-Paket unterstützt, nicht jedoch von Scrollutil_tile.  Sie haben dieselben Standardwerte wie die gleichnamigen Optionen für Tk-Frame-Widgets.  Die Standardwerte der übrigen Standardoptionen lauten:


```
-borderwidth 1 -cursor "" -relief sunken
```

: **HINWEIS:**  Wenn Sie die Option `-borderwidth` oder `-relief` konfigurieren und die Scrollarea infolge dieser Aktion einen positiven `-borderwidth`-Wert aufweist (z. B. der Standardwert `1`) und einen `-relief`-Wert aufweist, der nicht `flat` ist (z. B. den Standardwert `sunken`), dann wird die Option `-borderwidth` des Widgets, das über den Unterbefehl `setwidget` des zugehörigen Tcl-Befehls in den Scrollbereich eingebettet wurde, automatisch auf `0` gesetzt, vorausgesetzt, das eingebettete Widget unterstützt diese Option.

**WIDGET-SPEZIFISCHE OPTIONEN**
: 

|   |   |
| --- | --- |
| Befehlszeilenname:  | `-autohidescrollbars` |
| Name der Datenbank: | ` autoHideScrollbars` |
| Datenbankklasse: | ` AutoHideScrollbars` |

Legt einen booleschen Wert fest, der festlegt, ob die Bildlaufleisten ausgeblendet werden sollen, wenn sich der Fokus außerhalb des Toplevel-Fensters befindet, das den Bildlaufbereich enthält, oder wenn sich der Mauszeiger außerhalb des Bildlaufbereichs-Widgets befindet. Der Standardwert ist `0`.

**ANMERKUNG 1:**  Der einfachste Weg, den Standardwert für alle „scrollarea“-Instanzen Ihrer Anwendung zu überschreiben, besteht darin, die folgende Zeile einzufügen:

```
option add *Scrollarea.autoHideScrollbars 1
```

irgendwo am Anfang Ihres Skripts (bevor Sie Scrollarea-Widgets erstellen).

**ANMERKUNG 2:** Um eine Bildlaufleiste auszublenden, legt Scrollutil einfach einen Rahmen darüber, wodurch der von ihr eingenommene Bereich reserviert bleibt (wenn er zuvor zugeordnet war).  Dies unterscheidet sich vom Aufheben der Zuordnung einer dynamischen Bildlaufleiste, wenn in dem in den Bildlaufbereich eingebetteten Widget nichts zum Scrollen vorhanden ist. Das Ausblenden oder Einblenden einer Bildlaufleiste ändert nichts an ihrem Status „zugeordnet“ bzw. „nicht zugeordnet“.

**ANMERKUNG 3:**  Unabhängig vom Fokus und dem Wert dieser Option werden die Bildlaufleisten sichtbar, wenn sich der Mauszeiger innerhalb des Bildlaufbereichs befindet und das über `setwidget` darin eingebettete Widget gescrollt wird (z. B. mithilfe des Mausrads oder des Touchpads).


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-lockinterval` |
| Name der Datenbank: | ` lockInterval` |
| Datenbankklasse: | ` LockInterval` |

Legt das Zeitintervall in Millisekunden fest, für das die Bildlaufleisten mit dem Anzeigemodus `dynamic` (siehe die Optionen `-xscrollbarmode` und `-yscrollbarmode`) vor dem Entmappen geschützt sind, nachdem sie gemappt wurden, um Shimmering-Effekte zu vermeiden.  Dies ist auch das Zeitintervall, während dessen sich die dynamischen Bildlaufleisten gegenseitig davor schützen, neu zugeordnet zu werden, nachdem eine von ihnen neu zugeordnet wurde.  Ohne diesen Sperrmechanismus könnte eine dynamische Bildlaufleiste unter bestimmten seltenen Umständen in einer Endlosschleife immer wieder neu zugeordnet und wieder entfernt werden, was zu einem störenden und oft gefährlichen Flackereffekt führen würde.  Das gleiche Problem kann aufgrund eines zu kleinen Werts für `-lockinterval` auftreten. Der Standardwert ist `1`, der in den allermeisten Fällen wie erwartet funktioniert.  Sollten Sie in einem Ihrer Scrollarea-Widgets ein Shimmering feststellen, setzen Sie diese Option für die betreffende Scrollarea einfach auf einen ausreichend großen Wert (z. B. `100`).  HINWEIS: Dieser Wert sollte nicht größer als `300` sein, da aus implementierungsspezifischen Gründen ein Wert von `-lockinterval`, der größer als `300` ist, dazu führen kann, dass eine dynamische Bildlaufleiste, die ausgeblendet werden sollte, nicht entfernt wird, oder dass eine, die angezeigt werden sollte, nicht eingeblendet wird.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-respectheader` |
| Name der Datenbank: | ` respectHeader` |
| Datenbankklasse: | ` RespectHeader` |

Diese Option ist nur relevant, wenn es sich bei dem Widget, das mithilfe des Unterbefehls `setwidget` des zugehörigen Tcl-Befehls in den Scrollbereich eingebettet wurde, um ein [tablelist](https://www.nemethi.de/tablelist/) handelt und die verwendete Tablelist-Version 6.5 oder höher ist.  Sein Wert muss ein Boolescher Wert sein, der festlegt, ob die vertikale Bildlaufleiste unterhalb der Kopfzeile des Tablelist-Widgets angezeigt werden soll, wodurch das native Look & Feel unter Mac OS X/11+ und auf vielen modernen Linux-Systemen beibehalten wird.  Der Standardwert ist `1` auf den Fenstersystemen `aqua` und `x11`, und `0` auf `win32`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-respecttitlecolumns` |
| Name der Datenbank: | ` respectTitleColumns` |
| Datenbankklasse: | ` RespectTitleColumns` |

Diese Option ist nur relevant, wenn es sich bei dem Widget, das mithilfe des Unterbefehls `setwidget` des zugehörigen Tcl-Befehls in den Scrollbereich eingebettet wurde, um ein [tablelist](https://www.nemethi.de/tablelist/) handelt und die verwendete Tablelist-Version 6.5 oder höher ist.  Ihr Wert muss ein Boolescher Wert sein, der festlegt, ob die horizontale Bildlaufleiste rechts neben der nicht scrollbaren Spalte des Titels des Tablelist-Widgets beginnen soll, wenn der Wert der Tablelist-Option `-titlecolumns` positiv ist.  Der Standardwert ist `1`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-setfocus` |
| Name der Datenbank: | ` setFocus` |
| Datenbankklasse: | ` SetFocus` |

Legt einen booleschen Wert fest, der bestimmt, ob ein Klick mit Maustaste 1 oder 2 auf eine der Bildlaufleisten den Fokus mithilfe des Unterbefehls `setwidget` auf das in den Bildlaufbereich eingebettete Widget setzen soll, sofern sich dieses Widget nicht im deaktivierten Zustand befindet.  Der Standardwert ist `0`.

**ANMERKUNG 1:**  Wenn der Wert der Option `1` lautet und es sich bei dem eingebetteten Widget um ein Text- oder Ctext-Widget handelt, wird durch einen Klick mit Maustaste 1 oder 2 auf eine der Bildlaufleisten der Fokus auf dieses Widget gesetzt, unabhängig vom Status des Widgets, vorausgesetzt, das Fenstersystem ist `win32` oder die Tk-Version ist mindestens 8.6.11 oder 8.7a4.  Dies entspricht dem Verhalten, das die VORGABEBINDUNGEN dieser Widgets bei Ereignissen vom Typ `<Button-1>` zeigen.  (Im Falle eines ctext-Widgets `w` wird der Fokus auf das untergeordnete Haupttext-Widget `w.t` gesetzt und nicht auf das Widget selbst.)

**ANMERKUNG 2:**  Wenn der Wert der Option `1` lautet und das eingebettete Widget ein ttk::treeview-Widget ist, wird durch einen Klick mit Maustaste 1 oder 2 auf eine der Bildlaufleisten der Fokus auf dieses Widget gesetzt, unabhängig vom Zustand des Widgets, und zwar auf allen Fenstersystemen und für alle Tk-Versionen. Auch hier handelt es sich um dasselbe Verhalten, das die VORGABEBINDUNGEN dieses Widgets für `<Button-1>`-Ereignisse zeigen.

**ANMERKUNG 3:**  Der einfachste Weg, den Standardwert für alle „scrollarea“-Instanzen Ihrer Anwendung zu überschreiben, besteht darin, die folgende Zeile einzufügen:

```
option add *Scrollarea.setFocus 1
```

irgendwo am Anfang Ihres Skripts (bevor Sie Scrollarea-Widgets erstellen).


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-takefocus` |
| Name der Datenbank: | ` takeFocus` |
| Datenbankklasse: | ` TakeFocus` |

Diese Option legt fest, ob der Scrollbereich während der Tastaturnavigation den Fokus annimmt. Sie ist nahezu identisch mit der gleichnamigen Standardoption (Einzelheiten finden Sie im Handbucheintrag **options**).  Der einzige Unterschied besteht darin, dass nicht der Scrollbereich selbst, sondern das Widget, das über den Unterbefehl `setwidget` des zugehörigen Tcl-Befehls in ihn eingebettet wurde, den Fokus bei der Tastaturnavigation mit den Standardtasten erhält (`Tab` und `Shift-Tab`).  Die Standardeinstellung ist `0`, da ein Scrollbereich im Wesentlichen ein Container ist, der das oben genannte Widget und zwei Bildlaufleisten enthält.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-xscrollbarmode` |
| Name der Datenbank: | ` xScrollbarMode` |
| Datenbankklasse: | ` ScrollbarMode` |

Legt den Anzeigemodus fest, der für die horizontale Bildlaufleiste verwendet werden soll. Die zulässigen Werte sind `static`, `dynamic` und `none`.  Im Modus `static` wird die Bildlaufleiste stets angezeigt.  Im Modus `dynamic` (dem Standardmodus) wird die Bildlaufleiste je nach Bedarf ein- und ausgeblendet. Der Anzeigemodus `none` deaktiviert die Anzeige der Bildlaufleiste.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-yscrollbarmode` |
| Name der Datenbank: | ` yScrollbarMode` |
| Datenbankklasse: | ` ScrollbarMode` |

Legt den Anzeigemodus fest, der für die vertikale Bildlaufleiste verwendet werden soll. Die zulässigen Werte sind `static`, `dynamic` und `none`.  Im Modus `static` wird die Bildlaufleiste stets angezeigt.  Im Modus `dynamic` (dem Standardmodus) wird die Bildlaufleiste je nach Bedarf ein- und ausgeblendet. Der Anzeigemodus `none` deaktiviert die Anzeige der Bildlaufleiste.

**WIDGET-BEFEHL**
: Der Befehl `scrollutil::scrollarea` erstellt einen neuen Tcl-Befehl mit dem Namen `pathName`. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget auszuführen. Er hat die folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

: `option` und `arg` legen das genaue Verhalten des Befehls fest. Für Scrollarea-Widgets sind folgende Befehle möglich:


`pathName attrib ?name ?value name value ...??`
: Fragt die Attribute des Widgets ab oder ändert sie.  Wenn kein `name` angegeben ist, gibt der Befehl eine Liste von Paaren zurück, von denen jedes den Namen und den Wert eines Attributs für `pathName` enthält.  Wenn `name` ohne `value` festgelegt wird, gibt der Befehl den Wert des genannten Attributs zurück oder eine leere Zeichenkette, falls kein entsprechender Wert vorhanden ist (mit dem Unterbefehl `hasattrib` können Sie diesen Fall von dem unterscheiden, bei dem der Wert eines *vorhandenen* Attributs eine leere Zeichenkette ist).  Wenn ein oder mehrere Paare aus `name` und `value` angegeben werden, legt der Befehl das/die angegebene(n) Widget-Attribut(e) auf den/die angegebenen Wert(e) fest; in diesem Fall ist der Rückgabewert eine leere Zeichenkette.  Jedes `name` kann eine beliebige Zeichenkette sein.

`pathName cget option`
: Gibt den aktuellen Wert der durch `option` angegebenen Konfigurationsoption zurück, die einen beliebigen der vom Befehl `scrollutil::scrollarea` akzeptierten Werte annehmen kann.

`pathName configure ?option ?value option value ...??`
: Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie.  Wenn kein `option` angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für `pathName` beschreibt (Informationen zum Format dieser Liste finden Sie unter `Tk_ConfigureInfo`).  Wenn `option` ohne `value` festgelegt wird, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste entspricht der entsprechenden Unterliste des gegebenen Werts, wenn kein `option` festgelegt wurde).  Wenn ein oder mehrere Paare aus `option` und `value` festgelegt werden, ändert der Befehl die festgelegten Widget-Optionen so, dass sie die festgelegten Werte annehmen; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück.  `option` kann jeden der vom Befehl `scrollutil::scrollarea` akzeptierten Werte annehmen.

`pathName hasattrib name`
: Gibt `1` zurück, wenn das Attribut `name` vorhanden ist, andernfalls `0`.

`pathName setwidget widget`
: Das Argument `widget` muss der Pfadname eines vorhandenen Widgets oder eine leere Zeichenkette sein. Im ersten Fall sorgt der Befehl dafür, dass das Widget den oberenlinken oberen Teil des Scrollbereichs ausfüllt und es mit den Bildlaufleisten verbindet, indem er die Optionen `-xscrollcommand` und `-yscrollcommand` auf entsprechende Wrapper für den Befehl `set` der beiden Bildlaufleisten setzt und die Option `-command` Option der Bildlaufleisten auf `[list widget xview]` bzw. `[list widget yview]`.  Wenn `widget` eine leere Zeichenkette ist, ist das an den letzten `setwidget`-Aufruf (falls vorhanden) übergebene Widget nicht verwaltet und nicht mit den Bildlaufleisten verbunden.  Der Wert wird als Argument an den letzten erfolgreichen Aufruf dieses Unterbefehls übergeben, oder als leere Zeichenkette, wenn zuvor kein erfolgreicher Aufruf von `setwidget` stattgefunden hat.

: **ANMERKUNG 1:**  Wenn `widget` nicht leer ist und der Wert der Option `-xscrollbarmode` sich von dem der Option `none` unterscheidet, muss `widget` ein horizontal scrollbares Widget sein, d. h., es muss die Konfigurationsoption `-xscrollcommand` unterstützen und der zugehörige Tcl-Befehl muss den Unterbefehl `xview` enthalten.  Ebenso wenn `widget` nicht leer ist und der Wert der Option `-yscrollbarmode` sich von `none` unterscheidet, muss `widget` ein vertikal scrollbares Widget sein, was bedeutet, dass es die Konfigurationsoption `-yscrollcommand` unterstützen muss und der zugehörige Tcl-Befehl den Unterbefehl `yview` enthalten muss.  Folglich wenn `widget` ein Eintrag oder ttk::entry ist, ist dieser Unterbefehl nur dann erfolgreich, wenn die Option `-yscrollbarmode` zuvor auf `none` gesetzt wurde.

: **ANMERKUNG 2:** Das durch das Argument `widget` identifizierte Widget muss ein untergeordnetes Element des scrollarea oder eines seiner übergeordneten Elemente sein.  Diese geringfügige Einschränkung wird durch den Geometriemanager `grid` auferlegt.

: **ANMERKUNG 3:**  Wenn das Widget, dessen Pfadname an `setwidget` übergeben wurde, zerstört wird, wird dieser Unterbefehl automatisch mit einer leeren Zeichenkette als Argument aufgerufen.

: **ANMERKUNG 4:**  Dieser Unterbefehl setzt die Option `-highlightthickness` von `widget` auf `0`, wenn `widget` diese Konfigurationsoption unterstützt. Hat der Scrollbereich außerdem einen positiven Wert für `-borderwidth` (zum Beispiel die Vorgabe `1`) und einen Wert für `-relief` ungleich `flat` (zum Beispiel die Vorgabe `sunken`), setzt dieser Unterbefehl die Option `-borderwidth` von `widget` auf `0`, sofern `widget` diese Option unterstützt.

: **ANMERKUNG 5:** Dieser Unterbefehl ist die einzige unterstützte Möglichkeit, ein Widget in einen Scrollbereich einzubetten.  Jeder Versuch, weitere Widgets mithilfe eines beliebigen Geometriemanagers einzubetten, führt zu unvorhersehbaren Ergebnissen!

`pathName unsetattrib name`
: Hebt das Attribut `name` auf. Gibt eine leere Zeichenfolge zurück.

`pathName widget`
: Gibt das Argument zurück, das beim letzten erfolgreichen Aufruf des Unterbefehls `setwidget` übergeben wurde, oder eine leere Zeichenkette, falls dieser Unterbefehl noch nicht erfolgreich aufgerufen wurde.


**VORGABEBINDUNGEN**
: Wenn ein neuer Scrollbereich erstellt wird, verfügt dieser über keine VORGABEBINDUNGEN für Ereignisse: Scrollbereiche sind nicht für interaktive Funktionen vorgesehen.

**SCHLÜSSELWÖRTER**
: scrollarea, widget, scrollbar


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::getscrollarea`

**NAME**
: `scrollutil::getscrollarea` – Abfrage des Bildlaufbereichs, der ein bestimmtes Widget enthält

**ÜBERSICHT**
: 

```
scrollutil::getscrollarea widget
```

**BESCHREIBUNG**
: Gibt den Pfadnamen des Scrollbereichs zurück, in den das durch das Argument `widget` angegebene Widget über den Unterbefehl `setwidget` des Scrollbereichs eingebettet ist, oder eine leere Zeichenkette, falls kein solches Scrollbereich-Widget vorhanden ist.

**SCHLÜSSELWÖRTER**
: scrollarea, widget


[Inhalt](#inhalt)     [Startseite](index.md)
