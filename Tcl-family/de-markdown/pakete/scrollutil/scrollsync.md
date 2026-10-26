# Das `scrollutil::scrollsync` und  
 `scrollutil::getscrollsync` BEFEHLE

## Für Scrollutil Version 2.11

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Der Befehl scrollutil::scrollsync – Kurzreferenz](#der-befehl-scrollutil-scrollsync-kurzreferenz)
- [Der Befehl scrollutil::scrollsync – Ausführliche Referenz](#der-befehl-scrollutil-scrollsync-ausf-hrliche-referenz)
- [Der Befehl scrollutil::getscrollsync](#der-befehl-scrollutil-getscrollsync)

[Startseite](index.md)

---

## Der Befehl `scrollutil::scrollsync` – Kurzreferenz

[NAME](#der-befehl-scrollutil-scrollsync-ausf-hrliche-referenz)
: `scrollutil::scrollsync` – Erstellen und Bearbeiten von ScrollSync-Widgets

[ÜBERSICHT](#der-befehl-scrollutil-scrollsync-ausf-hrliche-referenz)
: 

```
scrollutil::scrollsync pathName ?options?
```

[STANDARDOPTIONEN](#der-befehl-scrollutil-scrollsync-ausf-hrliche-referenz)
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor       -xscrollcommand
-cursor       -highlightthickness   -yscrollcommand
```

[WIDGET-SPEZIFISCHE OPTIONEN](#der-befehl-scrollutil-scrollsync-ausf-hrliche-referenz)
: `-takefocus 0|1|""|command`

[Widget COMMAND](#der-befehl-scrollutil-scrollsync-ausf-hrliche-referenz)
: `pathName attrib ?name ?value name value ...??`

: `pathName cget option`

: `pathName configure ?option ?value option value ...??`

: `pathName hasattrib name`

: `pathName setwidgets widgetList`

: `pathName unsetattrib name`

: `pathName widgets`

: `pathName xview ?args?`

: `pathName xview`

: `pathName xview moveto fraction`

: `pathName xview scroll number units|pages`


: `pathName yview ?args?`

: `pathName yview`

: `pathName yview moveto fraction`

: `pathName yview scroll number units|pages`


[SCHLÜSSELWÖRTER](#der-befehl-scrollutil-scrollsync-ausf-hrliche-referenz)
: Scrollsync, Widget, Bildlauf


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::scrollsync` – Ausführliche Referenz

**NAME**
: `scrollutil::scrollsync` – Erstellen und Bearbeiten von ScrollSync-Widgets

**ÜBERSICHT**
: 

```
scrollutil::scrollsync pathName ?options?
```

**BESCHREIBUNG**
: Der Befehl `scrollutil::scrollsync` erstellt ein neues Fenster mit dem Namen `pathName` und der Klasse `Scrollsync` und wandelt es in ein **scrollsync**-Widget um.  Zusätzliche Optionen, die im Folgenden beschrieben werden, können über die Befehlszeile oder in der Optionsdatenbank festgelegt werden, um Aspekte des **scrollsync**-Widgets wie beispielsweise dessen Rahmenbreite und Relief zu konfigurieren. Der Befehl `scrollutil::scrollsync` gibt sein Argument `pathName` zurück.  Zum Zeitpunkt der Ausführung dieses Befehls darf kein Fenster mit dem Namen `pathName` vorhanden sein, das übergeordnete Fenster von `pathName` muss jedoch vorhanden sein.

: Ein „Scrollsync“ ist ein Megawidget, das dafür konzipiert ist, mehrere Widgets gleichzeitig zu scrollen. Es lässt sich sowohl horizontal als auch vertikal scrollen, was bedeutet, dass es die Konfigurationsoptionen `-xscrollcommand` und `-yscrollcommand` unterstützt und der zugehörige Tcl-Befehl über die Unterbefehle `xview` und `yview` verfügt.  Immer wenn sich die horizontale/vertikale Position der Ansicht im Fenster eines der horizontal/vertikal scrollbaren Widgets ändert, die in der an den Unterbefehl `setwidgets` des zugehörigen Tcl-Befehls übergebenen Liste enthalten sind, wird die Ansicht in den Fenstern aller anderen horizontal/vertikal scrollbaren Elemente dieser Liste automatisch entsprechend angepasst, wodurch sichergestellt wird, dass die Position der Ansicht in diesen Fenstern synchron bleibt.

: Ein ScrollSync-Widget wird in der Regel innerhalb eines [scrollarea](scrollarea.md) erstellt, wie im folgenden Beispiel gezeigt:

```
set sa [scrollutil::scrollarea ...]
set ss [scrollutil::scrollsync $sa.ss ...]
$sa setwidget $ss

set lb1 [listbox $ss.lb1 ...]
set lb2 [listbox $ss.lb2 ...]
$ss setwidgets [list $lb1 $lb2]

grid $lb1 $lb2 -sticky news -padx {0 2}
grid rowconfigure    $ss 0   -weight 1
grid columnconfigure $ss all -weight 1

pack $sa -expand yes -fill both
```

**STANDARDOPTIONEN**
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor       -xscrollcommand
-cursor       -highlightthickness   -yscrollcommand
```

: Weitere Informationen zu den Standardoptionen für Tk-Widgets finden Sie im Handbucheintrag zu den **options**. Die Optionen `-background`, `-highlightbackground`, `-highlightcolor` und `-highlightthickness` werden nur vom Scrollutil-Paket unterstützt, nicht jedoch von Scrollutil_tile.  Sie haben dieselben Standardwerte wie die gleichnamigen Optionen für Tk-Frame-Widgets.  Die Standardwerte der übrigen Standardoptionen lauten:


```
-borderwidth 0 -cursor "" -relief flat -xscrollcommand "" -yscrollcommand ""
```

**WIDGET-SPEZIFISCHE OPTIONEN**
: 

|   |   |
| --- | --- |
| Befehlszeilenname:  | `-takefocus` |
| Name der Datenbank: | ` takeFocus` |
| Datenbankklasse: | ` TakeFocus` |

Diese Option legt fest, ob das Scrollsync-Widget während der Tastaturnavigation den Fokus annimmt. Sie ist nahezu identisch mit der gleichnamigen Standardoption (Einzelheiten finden Sie im Handbucheintrag **options**).  Der einzige Unterschied besteht darin, dass nicht das „scrollsync“-Widget selbst, sondern das erste Element der Widget-Liste, die an den Unterbefehl `setwidgets` des zugehörigen Tcl-Befehls übergeben wird, den Fokus während der Tastaturnavigation mit den Standardtasten (`Tab` und `Shift-Tab`).  Die Standardeinstellung ist `0`, da ein „scrollsync“-Widget im Wesentlichen ein Container ist, der die oben genannten Widgets enthält.

**WIDGET-BEFEHL**
: Der Befehl `scrollutil::scrollsync` erstellt einen neuen Tcl-Befehl mit dem Namen `pathName`. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget auszuführen. Er hat die folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

: `option` und die `arg`-Elemente legen das genaue Verhalten des Befehls fest. Für Scrollsync-Widgets sind die folgenden Befehle möglich:


`pathName attrib ?name ?value name value ...??`
: Fragt die Attribute des Widgets ab oder ändert sie.  Wenn kein `name` angegeben ist, gibt der Befehl eine Liste von Paaren zurück, von denen jedes den Namen und den Wert eines Attributs für `pathName` enthält.  Wenn `name` ohne `value` festgelegt wird, gibt der Befehl den Wert des genannten Attributs zurück oder eine leere Zeichenkette, falls kein entsprechender Wert vorhanden ist (mit dem Unterbefehl `hasattrib` können Sie diesen Fall von dem unterscheiden, bei dem der Wert eines *vorhandenen* Attributs eine leere Zeichenkette ist).  Wenn ein oder mehrere Paare aus `name` und `value` angegeben werden, legt der Befehl das/die angegebene(n) Widget-Attribut(e) auf den/die angegebenen Wert(e) fest; in diesem Fall ist der Rückgabewert eine leere Zeichenkette.  Jedes `name` kann eine beliebige Zeichenkette sein.

`pathName cget option`
: Gibt den aktuellen Wert der durch `option` angegebenen Konfigurationsoption zurück, die einen der vom Befehl `scrollutil::scrollsync` akzeptierten Werte annehmen kann.

`pathName configure ?option ?value option value ...??`
: Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie.  Wenn kein `option` festgelegt ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für `pathName` beschreibt (Informationen zum Format dieser Liste finden Sie unter `Tk_ConfigureInfo`).  Wenn `option` ohne `value` festgelegt wird, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste entspricht der entsprechenden Unterliste des gegebenen Werts, wenn kein `option` festgelegt wurde).  Wenn ein oder mehrere Paare aus `option` und `value` festgelegt werden, ändert der Befehl die festgelegten Widget-Optionen so, dass sie die festgelegten Werte annehmen; in diesem Fall ist der Rückgabewert eine leere Zeichenkette.  `option` kann jeden der vom Befehl `scrollutil::scrollsync` akzeptierten Werte annehmen.

`pathName hasattrib name`
: Gibt `1` zurück, wenn das Attribut `name` vorhanden ist, andernfalls `0`.

`pathName setwidgets widgetList`
: Legt die Widgets fest, in deren Fenstern die Position der Ansicht synchronisiert werden soll. Das Argument `widgetList` muss eine gültige Liste sein, die aus Pfadnamen vorhandener Widgets besteht.  Immer wenn sich die horizontale/vertikale Position der Ansicht im Fenster eines der in dieser Liste enthaltenen, horizontal/vertikal scrollbaren Widgets ändert, wird die Ansicht in den Fenstern aller anderen horizontal/vertikal scrollbaren Elemente der Liste automatisch entsprechend angepasst, wodurch sichergestellt wird, dass die Position der Ansicht in diesen Fenstern synchron bleibt. Der Wert wird als Argument beim letzten erfolgreichen Aufruf dieses Unterbefehls übergeben, oder eine leere Liste, falls zuvor kein erfolgreicher Aufruf von `setwidgets` stattgefunden hat.

: **HINWEIS:**  Wenn eines der Widgets, dessen Pfadname in `widgetList` enthalten ist, zerstört wird, wird dieses Widget automatisch aus der internen Liste der Widgets entfernt, in deren Fenstern die Position der Ansicht synchronisiert wird.

`pathName unsetattrib name`
: Hebt das Attribut `name` auf. Gibt eine leere Zeichenfolge zurück.

`pathName widgets`
: Gibt das Argument zurück, das beim letzten erfolgreichen Aufruf des Unterbefehls `setwidgets` übergeben wurde, oder eine leere Liste, falls dieser Unterbefehl noch nicht erfolgreich aufgerufen wurde.

`pathName xview ?args?`
: `pathName xview`

: `pathName xview moveto fraction`

: `pathName xview scroll number units|pages`

: Dieser Befehl übergibt seine Argumente an den Befehl `xview` des aktuellen **Master-Widgets für die x-Achse** und gibt das Ergebnis dieses Befehlsaufrufs zurück.  Das Master-Widget für die x-Achse ist das Element der an den Unterbefehl `setwidgets` übergebenen Widget-Liste, das unter den horizontal scrollbaren Widgets in dieser Liste die geringste relative Ansichtsbreite aufweist, d. h., die geringste Differenz zwischen dem letzten und dem ersten Element der aus dem Befehl `xview` zurückgegebenen Liste mit zwei Elementen.  Dieses Master-Widget kann sich während der Programmausführung ändern (bei Text-Widgets kann es sich sogar in Abhängigkeit von der aktuellen vertikalen Ansichtsposition ändern).

`pathName yview ?args?`
: `pathName yview`

: `pathName yview moveto fraction`

: `pathName yview scroll number units|pages`

: Dieser Befehl übergibt seine Argumente an den Befehl `yview` des aktuellen **Master-Widgets für die y-Achse** und gibt das Ergebnis dieses Befehlsaufrufs zurück.  Das Master-Widget für die y-Achse ist das Element der an den Unterbefehl `setwidgets` übergebenen Widget-Liste, das unter den vertikal scrollbaren Widgets in dieser Liste die geringste relative Ansichtshöhe aufweist, d. h. die geringste Differenz zwischen dem letzten und dem ersten Element der aus zwei Elementen bestehenden Liste, die von seinem Befehl `yview` gegeben wird. Dieses Master-Widget kann sich während der Programmausführung ändern.


**VORGABEBINDUNGEN**
: Wenn ein neues „scrollsync“-Widget erstellt wird, verfügt es über keine VORGABEBINDUNGEN für Ereignisse: „scrollsync“-Widgets sind nicht dafür vorgesehen, interaktiv zu sein.

**SCHLÜSSELWÖRTER**
: scrollsync, widget, scrolling


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::getscrollsync`

**NAME**
: `scrollutil::getscrollsync` – Abfrage des ScrollSync, der ein bestimmtes Widget enthält

**ÜBERSICHT**
: 

```
scrollutil::getscrollsync widget
```

**BESCHREIBUNG**
: Gibt den Pfadnamen des Scrollsync zurück, in das das durch das Argument `widget` angegebene Widget über den Unterbefehl `setwidgets` des Scrollsync eingebettet ist, oder eine leere Zeichenkette, falls kein solches Scrollsync-Widget vorhanden ist.

**SCHLÜSSELWÖRTER**
: scrollsync, widget


[Inhalt](#inhalt)     [Startseite](index.md)
