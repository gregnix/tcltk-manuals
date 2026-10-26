# Befehle im Zusammenhang mit dem Mausrad und der Ereignisbehandlung von `<TouchpadScroll>`

## Für Scrollutil Version 2.11

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Der Befehl scrollutil::addMouseWheelSupport](#der-befehl-scrollutil-addmousewheelsupport)
- [Der Befehl scrollutil::createWheelEventBindings](#der-befehl-scrollutil-createwheeleventbindings)
- [Der Befehl scrollutil::enableScrollingByWheel](#der-befehl-scrollutil-enablescrollingbywheel)
- [Der Befehl scrollutil::disableScrollingByWheel](#der-befehl-scrollutil-disablescrollingbywheel)
- [Der Befehl scrollutil::adaptWheelEventHandling](#der-befehl-scrollutil-adaptwheeleventhandling)
- [Der Befehl scrollutil::prepareScrollingByWheel](#der-befehl-scrollutil-preparescrollingbywheel)
- [Der Befehl scrollutil::setFocusCheckWindow](#der-befehl-scrollutil-setfocuscheckwindow)
- [Der Befehl scrollutil::focusCheckWindow](#der-befehl-scrollutil-focuscheckwindow)

[Startseite](index.md)

---

## Der Befehl `scrollutil::addMouseWheelSupport`

**NAME**
: `scrollutil::addMouseWheelSupport` – Unterstützung für Mausrad-Ereignisse bei (ttk::)menubutton, (ttk::)scale oder scrollbaren Widgets hinzufügen

**ÜBERSICHT**
: 

```
scrollutil::addMouseWheelSupport tag ?axes?
```

**ERFORDERLICHE TK-VERSION**
: 8.4 oder höher.

**BESCHREIBUNG**
: Fügt den Widgets mit dem angegebenen Bindungs-Tag Unterstützung für Mausrad- und `<TouchpadScroll>`-Ereignisse hinzu, indem Bindungen für die Mausrad- und `<TouchpadScroll>`-Ereignisse entlang der Achsen erstellt werden, die durch das optionale Argument `axes` angegeben werden, das entweder `xy` (Standardwert, d. h. sowohl die x- als auch die y-Achse), `x` (d. h. nur die x-Achse) oder `y` (d. h. nur die y-Achse) lauten muss.

  - Wenn `tag` der Pfadname einer Menüschaltfläche oder eines Widgets mit der Bezeichnung „ttk::menubutton“ ist oder der Name der Klasse `Menubutton` oder `TMenubutton`, dann wird `axes` ignoriert, und die durch diesen Befehl erstellten Bindungsskripte aktivieren den zyklisch nächsten oder vorherigen Eintrag des Menüs, das dem durch das Ereignisfeld `%W` angegebenen Widget zugeordnet ist, und rufen die Aktion dieses Menüeintrags auf, vorausgesetzt, dessen Typ ist nicht `cascade` oder `tearoff`.
  - Wenn `tag` der Pfadname eines Skalen- oder „ttk::scale“-Widgets oder der Name der Klasse `Scale` oder `TScale` ist, dann wird `axes` ignoriert, und die durch diesen Befehl erstellten Bindungsskripte erhöhen oder verringern den Wert des Widgets, das durch das Ereignisfeld `%W` angegeben wird, und verschieben dessen Schieberegler entsprechend.
  - Andernfalls scrollen die Bindungsskripte das im Ereignisfeld `%W` angegebene Fenster mithilfe der Unterbefehle `xview scroll number units` und/oder `yview scroll number units` des zugehörigen Tcl-Befehls, abhängig von `axes`.

: **ANMERKUNG 1:**  Wenn `tag` der Pfadname eines Fensters ist, werden die durch diesen Befehl erstellten Bindungsskripte durch einen Aufruf des Befehls `break` beendet, um zu verhindern, dass Mausrad- oder `<TouchpadScroll>`-Ereignisse von weiteren Bindungsskripten verarbeitet werden.  Beispielsweise wenn `tag` der Pfadname eines Text-Widgets ist, stellt der abschließende Befehl `break` sicher, dass Mausrad- oder `<TouchpadScroll>`-Ereignisse nicht *zusätzlich* von den Klassenbindungen (die mit dem Bindungs-Tag `Text` verknüpft sind), die in Tk 8.5 und höher ein Scrollen in *Pixeln* auslösen – im Gegensatz zu den durch diesen Befehl erstellten Bindungen, die das Widget in *Einheiten* (d. h. Zeilen und Zeichen) scrollen.

: **ANMERKUNG 2:** Das Canvas-Widget verfügt über keine integrierten Bindungen, aber Sie können diesen Befehl verwenden, um die Unterstützung für Mausrad- und `<TouchpadScroll>`-Ereignisse zur Widget-Klasse `Canvas` oder zu einzelnen Canvas-Widgets hinzuzufügen.

: **ANMERKUNG 3:**  *In Tk-Versionen vor 8.7a4* hängt der Umfang der Ereignisse des Mausrads vom Fenstersystem ab:

  - Die Ereignisse des Mausrads entlang der vertikalen Achse sind unter Windows `<MouseWheel>`, unter Mac OS X/11+ `<MouseWheel>` und `<Option-MouseWheel>` sowie unter X11 `<MouseWheel>`, `<Button-4>` und `<Button-5>` unter X11 (wobei `<MouseWheel>` nicht vom X-Server ausgelöst wird, sondern mithilfe von `event generate` erzeugt werden kann).
  - Die Ereignisse des Mausrads entlang der horizontalen Achse sind `<Shift-MouseWheel>` unter Windows, `<Shift-MouseWheel>` und `<Shift-Option-MouseWheel>` unter Mac OS X/11+ sowie `<Shift-MouseWheel>`, `<Shift-Button-4>` und `<Shift-Button-5>` unter X11 (wobei `<Shift-MouseWheel>` nicht vom X-Server ausgelöst wird, sondern mithilfe von `event generate` erzeugt werden kann).  Unter X11 treten bei Verwendung von Tk 8.7a3 zwei weitere Mausrad-Ereignisse entlang der horizontalen Achse auf: `<Button-6>` und `<Button-7>`, die jeweils genauso behandelt werden wie `<Shift-Button-4>` bzw. `<Shift-Button-5>`.  Diese Ereignisse werden üblicherweise durch das Neigen des Scrollrads nach links oder rechts bei einer Maus mit einer oder zwei zusätzlichen (Daumen-)Tasten ausgelöst.  (In Tk-Versionen 8.6.x, wobei x >= 10 ist, löst das Neigen des Scrollrads einer solchen Maus nach links oder rechts unter Windows und Mac OS X/11+ die Ereignisse `<Shift-MouseWheel>` aus und unter X11 die Ereignisse `<Shift-Button-4>` und `<Shift-Button-5>`.)

**ANMERKUNG 4:**  *In den Tk-Versionen 8.7a4 und höher* ist der Satz der Mausrad-Ereignisse auf allen Fenstersystemen identisch:

  - Die Ereignisse des Mausrads entlang der vertikalen Achse sind `<MouseWheel>` und `<Option-MouseWheel>`, wobei der Modifikator `Option` unter Mac OS X/11+ an die Taste `Option` und unter Windows sowie X11 an die Taste `Alt` gebunden ist.
  - Die Ereignisse des Mausrads entlang der horizontalen Achse sind `<Shift-MouseWheel>` und `<Shift-Option-MouseWheel>`, wobei der Modifikator `Option` unter Mac OS X/11+ an die Taste `Option` und unter Windows sowie X11 an die Taste `Alt` gebunden ist.  In diesen Tk-Versionen löst das Neigen des Scrollrads einer Maus mit einer oder zwei zusätzlichen (Daumen-)Tasten nach links oder rechts auf allen Fenstersystemen die Ereignisse `<Shift-MouseWheel>` (und `<Shift-Option-MouseWheel>`) aus.

**SCHLÜSSELWÖRTER**
: mouse wheel event, binding, menubutton, scale widget, scrolling


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::createWheelEventBindings`

**NAME**
: `scrollutil::createWheelEventBindings` – Erstellen Sie Bindungen für Mausrad-Ereignisse für Widgets der Toplevel-Fenster oder das Tag `all`

**ÜBERSICHT**
: 

```
scrollutil::createWheelEventBindings ?tag tag ...?
```

**ERFORDERLICHE TK-VERSION**
: 8.4 oder höher unter X11 und Mac OS X/11+; 8.6b2 oder höher unter Windows.

**BESCHREIBUNG**
: Erstellt Mausrad- und `<TouchpadScroll>`-Bindungen für die angegebenen Tags, sodass, wenn das Widget unter dem Mauszeiger (ein Nachkomme) eines der scrollbaren Widget-Container ist, der das gleiche Toplevel-Fenster wie das Widget hat und über `scrollutil::enableScrollingByWheel` registriert ist, diese Ereignisse ein Scrollen dieses Widget-Containers auslösen.  Falls mehrere verschachtelte, registrierte scrollbare Widget-Container diese Bedingungen erfüllen, wird der innerste davon gescrollt.  Jedes `tag`-Argument muss `all` oder der Pfadname eines vorhandenen Toplevel-Fensters (einschließlich `.`) sein.

: **HINWEIS:**  Der Grund für die Beschränkung der `tag`-Argumente auf `all` und Pfadnamen bestehender Toplevel-Fenster, anstatt auch Tags wie `"Scrollableframe"` (für scrollutil::scrollableframe), `"BwScrollableFrame"` (für BWidget ScrollableFrame) oder `"Scrolledframe"` (für iwidgets::scrolledframe) besteht darin, dass das Mausrad und `<TouchpadScroll>`-Ereignisse ein Scrollen des Widget-Containers unter dem Mauszeiger nicht nur dann auslösen sollten, wenn das Widget unter dem Mauszeiger der Widget-Container selbst ist, sondern auch, wenn es ein Nachkomme des letzteren ist (Beachten Sie, dass für jedes Fenster der Pfadname seines nächstgelegenen Vorfahren auf Toplevel und das Tag `all` in der Standardliste der Bindungs-Tags des Fensters enthalten sind).

**SCHLÜSSELWÖRTER**
: mouse wheel event, binding, scrolling, scrollable widget container


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::enableScrollingByWheel`

**NAME**
: `scrollutil::enableScrollingByWheel` – Registrieren von scrollbaren Widget-Containern für das Scrollen mit dem Mausrad

**ÜBERSICHT**
: 

```
scrollutil::enableScrollingByWheel ?scrollableWidgetContainer scrollableWidgetContainer ...?
```

**ERFORDERLICHE TK-VERSION**
: 8.4 oder höher unter X11 und Mac OS X/11+; 8.6b2 oder höher unter Windows.

**BESCHREIBUNG**
: Fügt die angegebenen scrollbaren Widget-Container zur internen Liste der Widget-Container hinzu, die für das Scrollen mit dem Mausrad und für die durch den Befehl `scrollutil::createWheelEventBindings` erstellten `<TouchpadScroll>`-Ereignisbindungen registriert sind.

: **ANMERKUNG 1:**  Wenn ein scrollbarer Widget-Container, dessen Pfadname an diesen Befehl übergeben wurde, zerstört wird, wird er automatisch aus der oben genannten internen Liste der registrierten Widget-Container entfernt.

: **ANMERKUNG 2:** Der Befehl `scrollutil::scrollableframe` ruft diesen Befehl automatisch für das von ihm erstellte „scrollableframe“-Widget auf.

**SCHLÜSSELWÖRTER**
: mouse wheel event, binding, scrolling, scrollable widget container


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::disableScrollingByWheel`

**NAME**
: `scrollutil::disableScrollingByWheel` – Scrollbare Widget-Container für das Scrollen mit dem Mausrad abmelden

**ÜBERSICHT**
: 

```
scrollutil::disableScrollingByWheel ?scrollableWidgetContainer scrollableWidgetContainer ...?
```

**ERFORDERLICHE TK-VERSION**
: 8.4 oder höher unter X11 und Mac OS X/11+; 8.6b2 oder höher unter Windows.

**BESCHREIBUNG**
: Entfernt die angegebenen scrollbaren Widget-Container aus der internen Liste der Widget-Container, die für das Scrollen mit dem Mausrad und für die durch den Befehl `scrollutil::createWheelEventBindings` erstellten `<TouchpadScroll>`-Ereignis-Bindungen registriert sind.

**SCHLÜSSELWÖRTER**
: mouse wheel event, binding, scrolling, scrollable widget container


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::adaptWheelEventHandling`

**NAME**
: `scrollutil::adaptWheelEventHandling` – Ereignisbehandlung für das Mausrad anpassen

**ÜBERSICHT**
: 

```
scrollutil::adaptWheelEventHandling ?-ignorefocus? ?widget widget ...?
```

**ERFORDERLICHE TK-VERSION**
: 8.4 oder höher unter X11 und Mac OS X/11+; 8.6b2 oder höher unter Windows.

**BESCHREIBUNG**
: Wenn der optionale Schalter `-ignorefocus` *nicht* vorhanden ist, führt der Befehl für jedes `widget`-Argument die folgenden Aktionen aus:


  -  Wenn `widget` der Pfadname eines [tablelist](https://www.nemethi.de/tablelist/)-Widgets ist, werden die beidenOptionen `-xmousewheelwindow` und `-ymousewheelwindow` auf den Pfadnamen des Toplevel-Fensters, vorausgesetzt, die Tablelist-Version ist 6.4 oder höher (bei früheren Tablelist-Versionen ignoriert der Befehl stillschweigend jedes Tablelist-Widget, das ihm als Argument übergeben wird).  Infolgedessen löst ein Mausrad- oder `<TouchpadScroll>`-Ereignis über dem Hauptbereich oder dem Bearbeitungsfenster der Tablelist (genauer gesagt: Ein Mausrad- oder `<TouchpadScroll>`-Ereignis, das an eine beliebige Komponente der Tablelist gesendet wird, die das Bindungs-Tag `TablelistBody` oder `TablelistEdit` trägt) wie folgt behandelt:  
  -  Andernfalls wird das (erste) Bindungs-Tag gesucht, das Bindungen für das Mausrad oder `<TouchpadScroll>` aufweist und sich sowohl vom Pfadnamen des Toplevel-Fensters als auch von `all` unterscheidet.  Wenn die Suche nach diesem Tag erfolgreich ist, ändert der Befehl die Liste der Bindungs-Tags des Widgets, indem er diesem Bindungs-Tag das Tag `WheeleventRedir` voranstellt und das Tag `WheeleventBreak` anhängt.  Infolgedessen wird ein an dieses Widget gesendetes Mausrad- oder `<TouchpadScroll>`-Ereignis wie folgt verarbeitet:  

    - Wenn der Fokus innerhalb des „Tablelist“-Widgets liegt, wird durch das Ereignis die „Tablelist“ oder deren Bearbeitungsfenster gescrollt, und es erfolgt keine weitere Verarbeitung des Ereignisses.
    - Wenn der Fokus außerhalb des Tablelist-Widgets liegt, erfolgt kein Scrollen des Hauptbereichs oder des Bearbeitungsfensters der Tablelist. Stattdessen wird das Ereignis über `event generate` an das Toplevel-Fenster weitergeleitet.  Dies löst wiederum ein Scrollen des (innersten) Widget-Containers aus, der ein Vorfahr von `widget` ist und das gleiche Toplevel-Fenster hat (wenn ein solcher scrollbarer Widget-Container vorhanden ist), vorausgesetzt, der Pfadname des übergeordneten Toplevel-Fensters oder das Bindungs-Tag `all` wurde an den Befehl `scrollutil::createWheelEventBindings` übergeben und dieser Widget-Container wurde über `scrollutil::enableScrollingByWheel` für das Scrollen registriert.

    - Wenn der Fokus auf oder innerhalb des Fensters  `[focusCheckWindow widget]` ist, wird das Ereignis durch das diesem Tag zugeordnete Skript der Bindung verarbeitet, und es erfolgt keine weitere Verarbeitung des Ereignisses.
    - Wenn der Fokus außerhalb des Fensters  `[focusCheckWindow widget]` ist, wird das Ereignis über  `event generate` an das Toplevel-Fenster weitergeleitet, anstatt vom Skript der Bindung verarbeitet zu werden, das dem oben genannten Tag zugeordnet ist.  Dies löst wiederum ein Scrollen des (innersten) Widget-Containers aus, der ein Vorfahr von `widget` ist und das gleiche Toplevel-Fenster hat (wenn ein solcher scrollbarer Widget-Container vorhanden ist), vorausgesetzt, der Pfadname des übergeordneten Toplevel-Fensters oder des Bindungs-Tags `all` wurde an den Befehl `scrollutil::createWheelEventBindings` übergeben und dieser Widget-Container wurde über `scrollutil::enableScrollingByWheel` für das Scrollen registriert.

: Wenn die Option `-ignorefocus` festgelegt ist, führt der Befehl für jedes Argument `widget` die folgenden Aktionen aus:


  - Wenn `widget` der Pfadname eines [tablelist](https://www.nemethi.de/tablelist/)-Widgets ist, setzt er dessen Optionen `-xmousewheelwindow` und `-ymousewheelwindow` auf `""` zurück, vorausgesetzt, die Tablelist-Version ist 6.4 oder höher (bei früheren Tablelist-Versionen ignoriert der Befehl stillschweigend jedes Tablelist-Widget, das ihm als Argument übergeben wird).  Folglich führt wenn die Tablelist-Version 6.16 oder höher ist ein Mausrad- oder `<TouchpadScroll>`-Ereignis über dem Hauptbereich oder dem Bearbeitungsfenster der Tablelist zu einem Bildlauf der Tablelist oder ihres Bearbeitungsfensters, ohne dass eine weitere Verarbeitung des Ereignisses stattfindet.
  - Andernfalls wird das (erste) Bindungs-Tag gesucht, das Bindungen für das Mausrad oder `<TouchpadScroll>` aufweist und sich sowohl vom Pfadnamen des Toplevel-Fensters als auch von `all` unterscheidet.  Wenn die Suche nach diesem Tag erfolgreich ist, ändert der Befehl die Liste der Bindungs-Tags des Widgets, indem er das Tag `WheeleventBreak` an dieses Bindungs-Tag anhängt.  Infolgedessen wird ein an dieses Widget gesendetes Mausrad- oder `<TouchpadScroll>`-Ereignis von dem mit diesem Tag verknüpften Skript der Bindung verarbeitet, und es findet keine weitere Verarbeitung des Ereignisses statt.

: **ANMERKUNG 1:** Dieser Befehl ist dafür vorgesehen, für Widgets aufgerufen zu werden, die Bindungen für das Mausrad oder `<TouchpadScroll>` aufweisen und Nachkommen eines scrollbaren Containers für Widgets sind.  Die Tk- und Tile-Widgets mit Klassenbindungen für Mausrad- und `<TouchpadScroll>`-Ereignisse sind: listbox, Text, Tk-Core-Scrollbar, ttk::scrollbar, ttk::combobox, ttk::spinbox, ttk::entry, ttk::notebook und ttk::treeview.  Beispiele für Widgets mit anderen Bindungs-Tags als ihren Klassennamen, die über Bindungen für Mausrad- und `<TouchpadScroll>`-Ereignisse verfügen, sind ctext- und tablelist-Widgets sowie die Eingabekomponenten von [mentry](https://www.nemethi.de/mentry/)-Widgets vom Typ `"Date"`, `"Time"`, `"DateTime"`, `"IPAddr"` und `"IPv6Addr"` (für Mentry-Versionen 3.2 und höher).  (Im Falle eines ctext-Widgets vom Typ `w` beziehen sich die in der obigen BESCHREIBUNG genannten Bindungs-Tags auf das untergeordnete Haupttext-Widget `w.t` des Widgets und nicht auf das Widget selbst.)

: **ANMERKUNG 2:**  Wie oben erwähnt, verfügen die Tk-Core-Scrollbar- und ttk::scrollbar-Widgets über Klassenbindungen für Mausrad- und `<TouchpadScroll>`-Ereignisse; daher sollte dieser Befehl für sie aufgerufen werden, falls sie Nachkommen eines scrollbaren Containers sind.  Da diese Aufgabe mühsam werden kann, sorgt Scrollutil dafür, dass, wenn Sie diesem Befehl ein Widget übergeben und dieses Widget in ein [scrollarea](scrollarea.md) über dessen `setwidget`-Unterbefehl eingebettet ist, dann wird dieser Befehl automatisch auch für die Bildlaufleisten dieses scrollarea aufgerufen.

: **ANMERKUNG 3:**  Bei der Verarbeitung eines Mausrad- oder `<TouchpadScroll>`-Ereignisses, das an eine Tk-Core- oder Tile-Bildlaufleiste gesendet wurde, deren Pfadname diesem Befehl ohne die Option `-ignorefocus` übergeben wurde, Wenn der Fokus auf oder innerhalb des zugehörigen Widgets liegt, wird das Ereignis von der Bildlaufleiste verarbeitet und nicht an das übergeordnete Toplevel-Fenster weitergeleitet – genau so, als befände sich der Fokus auf der Bildlaufleiste selbst.

: **ANMERKUNG 4:** Die Bindungen der Mausrad-Ereignisklasse für die Tk-Core-Bildlaufleiste unter Windows und X11 wurden in Tk 8.6 hinzugefügt.  Vor dieser Tk-Version gab es solche Bindungen nur für das Fenstersystem `aqua` auf dem Macintosh.  Scrollutil beseitigt diese Diskrepanz, indem es automatisch die `Scrollbar`-Klassenbindungen für Mausrad-Ereignisse unter Windows und X11 erstellt.  Beachten Sie außerdem, dass das Widget ttk::scrollbar in Tk-Versionen vor 8.7a4 keine *integrierten* Klassenbindungen für Mausrad-Ereignisse hatte, Scrollutil erstellt die fehlenden Bindungen jedoch automatisch, indem es die Ereignisse des Mausrads der Widget-Klasse `Scrollbar` in das Bindungs-Tag `TScrollbar` kopiert.

: **ANMERKUNG 5:** Die Bindungen der Mausrad-Ereignisklassen für das Widget ttk::entry wurden in Tk 9.1a1 hinzugefügt, werden jedoch von Scrollutil automatisch für alle Tk-Versionen ab 8.4 erstellt.

: **ANMERKUNG 6:** Die Ereignisklassen-Bindungen für das Mausrad des Widgets „ttk::notebook“ wurden in Tk 8.7a4 hinzugefügt, werden jedoch von Scrollutil automatisch für alle Tk-Versionen ab 8.4 erstellt.  Diese Bindungen ermöglichen die Navigation zwischen den Registerkarten eines ttk::notebook- oder [scrollutil::scrollednotebook](scrollednotebook.md)-Widgets über das Mausrad.

: **ANMERKUNG 7:** Es wird empfohlen, diesen Befehl ohne die Option `-ignorefocus` auszuführen, da dies die Wahrscheinlichkeit erheblich verringert, dass der Benutzer versehentlich in einem Fenster innerhalb eines Widget-Containers scrollt, der viele scrollbare Widgets enthält.

**SCHLÜSSELWÖRTER**
: mouse wheel event, binding, event handling, scrolling, scrollable widget container, focus


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::prepareScrollingByWheel`

**NAME**
: `scrollutil::prepareScrollingByWheel` – Scrollbare Widget-Container für das Scrollen mit dem Mausrad vorbereiten

**ÜBERSICHT**
: 

```
scrollutil::prepareScrollingByWheel ?-ignorefocus? ?scrollableWidgetContainer scrollableWidgetContainer ...?
```

**ERFORDERLICHE TK-VERSION**
: 8.4 oder höher unter X11 und Mac OS X/11+; 8.6b2 oder höher unter Windows.

**BESCHREIBUNG**
: Für jeden als Argument angegebenen Container mit scrollbaren Widgets bereitet dieser Befehl das Scrollen mit dem Mausrad und dem Touchpad vor, indem er dessen untergeordnete Elemente, die sich im gleichen Toplevel-Fenster befinden und über Bindungen für Mausrad- oder `<TouchpadScroll>`-Ereignisse verfügen, an `scrollutil::adaptWheelEventHandling` übergibt.

: **HINWEIS:** Wenn ein scrollbarer Widget-Container viele untergeordnete Elemente enthält, ist es wesentlich sicherer, diesen Befehl aufzurufen, als manuell eine große Anzahl von Widgets an `scrollutil::adaptWheelEventHandling` zu übergeben, da die Entscheidung, welche untergeordneten Elemente verarbeitet werden sollen, mühsam und fehleranfällig sein kann.

**SCHLÜSSELWÖRTER**
: mouse wheel event, binding, scrollable widget container


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::setFocusCheckWindow`

**NAME**
: `scrollutil::setFocusCheckWindow` – „Fokus-Prüffenster“ festlegen

**ÜBERSICHT**
: 

```
scrollutil::setFocusCheckWindow widget ?widget ...? otherWidget
```

**ERFORDERLICHE TK-VERSION**
: 8.4 oder höher.

**BESCHREIBUNG**
: Für jedes `widget`-Argument setzt der Befehl das zugehörige „Fokusprüfungsfenster“ auf `otherWidget`.  Dies ist das Fenster, das in den Skripten für die Tags `WheeleventRedir` und `Btn2EventRedir` anstelle des Widgets verwendet werden soll, wenn geprüft wird, ob sich der Fokus auf/innerhalb oder außerhalb dieses Fensters befindet.  Für jedes `widget`-Argument muss `otherWidget` ein übergeordnetes Element von `widget` sein oder mit diesem identisch sein.

: **ANMERKUNG 1:**  Wenn ein Widget, dessen Pfadname diesem Befehl als eines seiner `widget`-Argumente übergeben wurde, zerstört wird, wird die Verknüpfung zwischen dem Widget und seinem „Fokusprüfungsfenster“ automatisch aufgehoben.

: **ANMERKUNG 2:** Dieser Befehl ist nützlich, wenn Sie für bestimmte Widgets die Fokusprüfung in den Bindungen für die Tags `WheeleventRedir` und `Btn2EventRedir` weniger restriktiv gestalten möchten.  Wenn das Widget unter dem Mauszeiger beispielsweise eine Eingabekomponente eines [mentry](https://www.nemethi.de/mentry/) `me` vom Typ `"Date"`, `"Time"`, `"DateTime"`, `"IPAddr"`, oder `"IPv6Addr"` ist und der Fokus auf einem seiner Geschwister liegt, sollten die an dieses Mentry-Widget gesendeten Mausrad- und `<TouchpadScroll>`-Ereignisse vom Mentry-Widget selbst verarbeitet werden, anstatt den Container zu scrollen, der ein übergeordneter Vorfahr des Mentry ist.  Dies können Sie erreichen, indem Sie


```
set entryList [$me entries]
eval scrollutil::adaptWheelEventHandling $entryList
eval scrollutil::setFocusCheckWindow     $entryList [list $me]
```

: Ab Tcl/Tk 8.5 können Sie die kompaktere Form verwenden


```
set entryList [$me entries]
scrollutil::adaptWheelEventHandling {*}$entryList
scrollutil::setFocusCheckWindow     {*}$entryList $me
```

: **ANMERKUNG 3:**  Nehmen wir als ähnliches Beispiel an, dass `ss` ein [scrollsync](scrollsync.md)-Widget ist, das über seinen Unterbefehl `setwidgets` mit untergeordneten Widgets gefüllt wurde.  Wenn das Widget unter dem Mauszeiger eines dieser untergeordneten Widgets ist und der Fokus auf einem der anderen an diesen Unterbefehl übergebenen untergeordneten Widgets liegt, sollten die an das unter dem Mauszeiger befindliche untergeordnete Widget gesendeten Mausrad- und `<TouchpadScroll>`-Ereignisse von diesem untergeordneten Widget selbst verarbeitet werden, anstatt den Widget-Container zu scrollen, der ein übergeordnetes Element des scrollsync ist.  Dies lässt sich mit dem folgenden Code erreichen:


```
set widgetList [$ss widgets]
eval scrollutil::adaptWheelEventHandling $widgetList
eval scrollutil::setFocusCheckWindow     $widgetList [list $ss]
```

: Auch hier gilt: Ab Tcl/Tk 8.5 können Sie die kompaktere Form verwenden


```
set widgetList [$ss widgets]
scrollutil::adaptWheelEventHandling {*}$widgetList
scrollutil::setFocusCheckWindow     {*}$widgetList $ss
```

**SCHLÜSSELWÖRTER**
: binding, focus, "focus check window"


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::focusCheckWindow`

**NAME**
: `scrollutil::focusCheckWindow` – Abfrage des „Fokusprüfungsfensters“

**ÜBERSICHT**
: 

```
scrollutil::focusCheckWindow widget
```

**ERFORDERLICHE TK-VERSION**
: 8.4 oder höher.

**BESCHREIBUNG**
: Gibt den Pfadnamen des „Fokusprüfungsfensters“ zurück, das dem Argument `widget` zugeordnet ist.  Dies ist das Fenster, das in den Skripten für die Tags `WheeleventRedir` und `Btn2EventRedir` anstelle des Widgets verwendet wird, um zu prüfen, ob sich der Fokus auf/innerhalb oder außerhalb dieses Fensters befindet.  Wenn der Befehl `scrollutil::setFocusCheckWindow` nicht für `widget` aufgerufen wurde, ist der Wert `widget` selbst.

**SCHLÜSSELWÖRTER**
: binding, focus, "focus check window"


[Inhalt](#inhalt)     [Startseite](index.md)

---
