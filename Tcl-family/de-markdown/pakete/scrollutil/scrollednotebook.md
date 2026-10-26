# Der Befehl `scrollutil::scrollednotebook`  
 und das Stilelement `closetab`

## Für Scrollutil Version 2.11

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Der Befehl scrollutil::scrollednotebook – Kurzreferenz](#der-befehl-scrollutil-scrollednotebook-kurzreferenz)
- [Der Befehl scrollutil::scrollednotebook – Ausführliche Referenz](#der-befehl-scrollutil-scrollednotebook-ausf-hrliche-referenz)
- [Das „Closetab“-Style-Element](#das-stilelement-closetab)
- [Der Befehl scrollutil::addclosetab](#der-befehl-scrollutil-addclosetab)
- [Der Befehl scrollutil::removeclosetab](#der-befehl-scrollutil-removeclosetab)
- [Der Befehl scrollutil::closetabstate](#der-befehl-scrollutil-closetabstate)

[Startseite](index.md)

---

## Der Befehl `scrollutil::scrollednotebook` – Kurzreferenz

[NAME](#der-befehl-scrollutil-scrollednotebook-ausf-hrliche-referenz)
: `scrollutil::scrollednotebook` – Erstellen und Bearbeiten von „scrollednotebook“-Widgets

[ÜBERSICHT](#der-befehl-scrollutil-scrollednotebook-ausf-hrliche-referenz)
: 

```
package require scrollutil_tile
scrollutil::scrollednotebook pathName ?options?
```

[STANDARDOPTIONEN](#der-befehl-scrollutil-scrollednotebook-ausf-hrliche-referenz)
: 

```
-class  -cursor  -style
```

[WIDGET-SPEZIFISCHE OPTIONEN](#der-befehl-scrollutil-scrollednotebook-ausf-hrliche-referenz)
: `-forgetcommand command`

: `-height screenDistance`

: `-leavecommand command`

: `-movabletabs boolean`

: `-padding paddingSpec`

: `-takefocus 0|1|""|command`

: `-width screenDistance`

[Widget COMMAND](#der-befehl-scrollutil-scrollednotebook-ausf-hrliche-referenz)
: `pathName add window ?options?`

: `pathName adjustsize`

: `pathName attrib ?name ?value name value ...??`

: `pathName cget option`

: `pathName closetabstate tabId ?normal|disabled?`

: `pathName configure ?option ?value option value ...??`

: `pathName forget tabId`

: `pathName hasattrib name`

: `pathName hastabattrib tabId name`

: `pathName hide tabId`

: `pathName identify component x y`

: `pathName index tabId`

: `pathName insert pos window ?options?`

: `pathName instate stateSpec ?script?`

: `pathName notebookpath`

: `pathName see tabId`

: `pathName select ?tabId?`

: `pathName state ?stateSpec?`

: `pathName style`

: `pathName tab tabId ?option ?value option value ...??`

: `pathName tabattrib tabId ?name ?value name value ...??`

: `pathName tabs`

: `pathName unsetattrib name`

: `pathName unsettabattrib tabId name`

[SCHLÜSSELWÖRTER](#der-befehl-scrollutil-scrollednotebook-ausf-hrliche-referenz)
: scrollednotebook, widget, notebook, scrolled


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::scrollednotebook` – Ausführliche Referenz

**NAME**
: `scrollutil::scrollednotebook` – „ScrolledNotebook“-Widgets erstellen und bearbeiten

**ÜBERSICHT**
: 

```
package require scrollutil_tile
scrollutil::scrollednotebook pathName ?options?
```

: Es gibt einen HINWEIS, dass der Befehl `scrollutil::scrollednotebook` vom Paket „Scrollutil_tile“ bereitgestellt wird, nicht jedoch von Scrollutil.

**BESCHREIBUNG**
: Der Befehl `scrollutil::scrollednotebook` erstellt ein neues Fenster mit dem Namen `pathName` und wandelt es in ein **scrollednotebook**-Widget um.  Zusätzliche Optionen, die im Folgenden beschrieben werden, können über die Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des „scrollednotebook“-Widgets wie dessen Breite, Höhe und Stil zu konfigurieren. Der Befehl `scrollutil::scrollednotebook` gibt sein Argument `pathName` zurück.  Zum Zeitpunkt der Ausführung dieses Befehls darf kein Fenster mit dem Namen `pathName` vorhanden sein, das übergeordnete Fenster von `pathName` muss jedoch vorhanden sein.

: Ein „scrollednotebook“ ist ein Megawidget, das ein ttk::notebook innerhalb eines [scrollableframe](scrollableframe.md) enthält und eine beliebige Anzahl von nicht komprimierten Registerkarten unterstützt.  Derzeit nicht sichtbare Registerkarten können durch Navigation mit dem Mausrad, dem Touchpad oder der Tastatur sowie durch Scrollen mithilfe der beiden Pfeiltasten, die je nach Bedarf in den oberen linken und rechten bzw. unteren linken und rechten Ecken platziert werden (abhängig vom [style](#der-befehl-scrollutil-scrollednotebook-ausf-hrliche-referenz)).  Die Größe der Pfeile hängt vom Skalierungsfaktor von Tk ab, während ihre Farbe themenspezifisch ist und bei jedem Wechsel des Themas aktualisiert wird.  Ein einzelner Reiter kann programmgesteuert mithilfe des Unterbefehls `see` sichtbar gemacht werden.  Im Gegensatz zum Widget ttk::notebook, dessen Option `-width` häufig durch die Gesamtbreite der Registerkarten überschrieben wird, beachtet das „scrollednotebook“-Widget den Wert seiner Option `-width`, unabhängig vom Platzbedarf der Registerkarten.

: Die API des „scrollednotebook“-Widgets ist nahezu identisch mit der von ttk::notebook.  Abgesehen von einigen zusätzlichen, für „scrollednotebook“ spezifischen Unterbefehlen bietet der mit einem „scrollednotebook“-Widget verknüpfte Tcl-Befehl dieselben Unterbefehle wie der mit einem „ttk::notebook“ verknüpfte.

**STANDARDOPTIONEN**
: 

```
-class  -cursor  -style
```

: Einzelheiten zu den Standardoptionen finden Sie im Handbucheintrag zu **ttk_widget**. Der Wert der Option `-class` lautet `Scrollednotebook`, der der Option `-cursor` ist eine leere Zeichenkette.  Die Option `-style`, deren Wert `TNotebook` ist, bezieht sich auf den Stil des im „scrollednotebook“ enthaltenen Widgets ttk::notebook.  Der Wert der Option `-tabposition` für den durch diese Option festgelegten Stil muss einer der folgenden Werte sein: `nw` (Standard), `n` (Standardwert für das Thema `aqua`), `ne`, `sw`, `s` oder `se`. Diese Werte führen zu einem horizontalen Registerlayout (das „scrollednotebook“-Widget unterstützt keine vertikalen Registerlayouts).

**WIDGET-SPEZIFISCHE OPTIONEN**
: 

|   |   |
| --- | --- |
| Befehlszeilenname:  | `-forgetcommand` |
| Name der Datenbank: | ` forgetCommand` |
| Datenbankklasse: | ` ForgetCommand` |

Legt einen Befehl fest, der aufgerufen werden soll, wenn versucht wird, eine Registerkarte zu entfernen und das zugehörige Fenster mithilfe des Unterbefehls `forget` aus der Verwaltung zu nehmen.  Wenn der Wert der Option eine nicht leere Zeichenkette ist, wird diese mit dem Pfadnamen des „scrollednotebook“-Widgets und dem des Fensters, dessen Verwaltung aufgehoben werden soll, verkettet, und das resultierende Skript, das einen booleschen Wert geben muss, wird im globalen Geltungsbereich ausgewertet.  Wenn der Wert des Skripts „false“ ist, wird der Unterbefehl `forget` abgebrochen, d. h., die Registerkarte wird nicht entfernt und das zugehörige Fenster wird nicht aus der Verwaltung entlassen. Der Standardwert ist eine leere Zeichenkette.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-height` |
| Name der Datenbank: | ` height` |
| Datenbankklasse: | ` Height` |

Falls vorhanden und größer als Null, legt dieser Wert die gewünschte Höhe der Teilfläche des Fensters in einem der von `Tk_GetPixels` akzeptierten Formate fest. Andernfalls wird die Höhe des Widgets auf die angeforderte Höhe des darin enthaltenen ttk::notebook gesetzt (die wiederum von der maximal angeforderten Höhe aller Teilflächen und Registerkarten sowie dem zusätzlichen vertikalen Platz abhängt, der sich aus dem Wert der Option `-padding` ergibt), unmittelbar nachdem das „scrollednotebook“ zugeordnet wurde.  Der Standardwert ist `0`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-leavecommand` |
| Name der Datenbank: | ` leaveCommand` |
| Datenbankklasse: | ` LeaveCommand` |

Legt einen Befehl fest, der aufgerufen werden soll, wenn versucht wird, das aktuell ausgewählte Fenster zu verlassen, indem ein anderes ausgewählt wird.  Wenn der Wert der Option eine nicht leere Zeichenkette ist, wird diese mit dem Pfadnamen des „scrollednotebook“-Widgets und dem des aktuell ausgewählten Fensters verkettet, und das resultierende Skript, das einen booleschen Wert geben muss, wird im globalen Geltungsbereich ausgewertet.  Wenn der Wert des Skripts „false“ ist, wird der Vorgang der Auswahl eines anderen Fensters abgebrochen. Der Standardwert ist eine leere Zeichenkette.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-movabletabs` |
| Name der Datenbank: | ` movableTabs` |
| Datenbankklasse: | ` MovableTabs` |

Legt einen booleschen Wert fest, der bestimmt, ob die Registerkarten mit der Maus verschoben werden können.  Weitere Informationen finden Sie im Abschnitt [WEITERE BINDUNGEN](#der-befehl-scrollutil-scrollednotebook-ausf-hrliche-referenz) weiter unten.  Der Standardwert ist `1`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-padding` |
| Name der Datenbank: | ` padding` |
| Datenbankklasse: | ` Padding` |

Legt fest, wie viel zusätzlicher Abstand um das im „scrollednotebook“ enthaltene Widget „ttk::notebook“ herum hinzugefügt werden soll.  Weitere Informationen finden Sie im Handbucheintrag zu **ttk_notebook**.  Der Standardwert ist eine leere Zeichenkette.  Beachten Sie, dass bei Verwendung dieses Standardwerts das Widget ttk::notebook mit dem äußeren Innenabstand gezeichnet wird, der durch die Option `-padding` des Widget-Stils festgelegt ist.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-takefocus` |
| Name der Datenbank: | ` takeFocus` |
| Datenbankklasse: | ` TakeFocus` |

Diese Option legt fest, ob das „scrollednotebook“-Widget während der Tastaturnavigation den Fokus annimmt. Sie ist nahezu identisch mit der gleichnamigen Standardoption (Einzelheiten finden Sie im Handbucheintrag **options**).  Der einzige Unterschied besteht darin, dass nicht das „scrollednotebook“-Widget selbst, sondern das darin enthaltene „ttk::notebook“ den Fokus erhält, wenn die Standardtasten (`Tab` und `Shift-Tab`) bei der Tastaturnavigation gedrückt werden.  Die Standardeinstellung ist `"ttk::takefocus"` (genau wie bei ttk::notebook und einigen anderen Widgets im Tk-Thema).


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-width` |
| Name der Datenbank: | ` width` |
| Datenbankklasse: | ` Width` |

Falls vorhanden und größer als Null, legt dieser Wert die gewünschte Breite des im Widget enthaltenen ttk::notebook fest, und zwar in einer der von `Tk_GetPixels` akzeptierten Formen.  Andernfalls wird die Breite des Widgets auf die angeforderte Breite des darin enthaltenen ttk::notebook im Container gesetzt (die wiederum von der maximal angeforderten Breite aller Teilflächen, der Gesamtbreite der Registerkarten und dem zusätzlichen horizontalen Platz abhängt, der sich aus dem Wert der Option `-padding` ergibt), unmittelbar nachdem das „scrollednotebook“ zugeordnet wurde.  Der Standardwert ist `10c`, der durch einen geeigneten anwendungsspezifischen Wert überschrieben werden sollte.

**REGISTEROPTIONEN**
: Siehe den Handbucheintrag zu **ttk_notebook**.

**REGISTERKENNUNGEN**
: Siehe den Handbucheintrag zu **ttk_notebook**.

**WIDGET-BEFEHL**
: Der Befehl `scrollutil::scrollednotebook` erstellt einen neuen Tcl-Befehl mit dem Namen `pathName`.  Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget auszuführen.  Er hat die folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

: `option` und die `arg`s legen das genaue Verhalten des Befehls fest. Für „scrollednotebook“-Widgets sind folgende Befehle möglich:


`pathName add window ?options?`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName adjustsize`
: Setzt die Option `-height` des „scrollednotebook“ auf die maximal angeforderte Höhe aller Teilflächen und die Option `-width` auf die maximale angeforderte Breite aller Teilflächen, erhöht um den zusätzlichen horizontalen Platz, der sich aus dem Wert der Option `-padding` ergibt.

`pathName attrib ?name ?value name value ...??`
: Fragt die Attribute des Widgets ab oder ändert sie.  Wenn kein `name` angegeben ist, gibt der Befehl eine Liste von Paaren zurück, von denen jedes den Namen und den Wert eines Attributs für `pathName` enthält.  Wenn `name` ohne `value` festgelegt wird, gibt der Befehl den Wert des genannten Attributs zurück oder eine leere Zeichenkette, falls kein entsprechender Wert vorhanden ist (mit dem Unterbefehl `hasattrib` können Sie diesen Fall von dem unterscheiden, bei dem der Wert eines *vorhandenen* Attributs eine leere Zeichenkette ist).  Wenn ein oder mehrere Paare aus `name` und `value` angegeben werden, legt der Befehl das/die angegebene(n) Widget-Attribut(e) auf den/die angegebenen Wert(e) fest; in diesem Fall ist der Rückgabewert eine leere Zeichenkette.  Jedes `name` kann eine beliebige Zeichenkette sein.

`pathName cget option`
: Gibt den aktuellen Wert der durch `option` angegebenen Konfigurationsoption zurück, die einen der vom Befehl `scrollutil::scrollednotebook` akzeptierten Werte annehmen kann.

`pathName closetabstate tabId ?normal|disabled?`
: Legt den Status des Elements `closetab` der durch `tabId` angegebenen Registerkarte fest oder fragt ihn ab.

: **HINWEIS:** Der Aufruf dieses Unterbefehls ist lediglich eine Abkürzung, um die Parameter `pathName`, `tabId` und das optionale Argument (falls vorhanden) an den Befehl `scrollutil::closetabstate` zu übergeben.

`pathName configure ?option ?value option value ...??`
: Ruft die Konfigurationsoptionen des Widgets ab oder ändert sie.  Wenn kein `option` festgelegt ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für `pathName` beschreibt (Informationen zum Format dieser Liste finden Sie unter `Tk_ConfigureInfo`).  Wenn `option` ohne `value` festgelegt wird, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste entspricht der entsprechenden Unterliste des gegebenen Werts, wenn kein `option` festgelegt wurde).  Wenn ein oder mehrere Paare aus `option` und `value` angegeben werden, ändert der Befehl die angegebenen Widget-Optionen so, dass sie die angegebenen Werte annehmen; in diesem Fall ist der Rückgabewert eine leere Zeichenkette.  `option` kann jeden der vom Befehl `scrollutil::scrollednotebook` akzeptierten Werte annehmen.

`pathName forget tabId`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName hasattrib name`
: Gibt `1` zurück, wenn das Attribut `name` vorhanden ist, andernfalls `0`.

`pathName hastabattrib tabId name`
: Gibt `1` zurück, wenn das Attribut `name` für die durch `tabId` angegebene Registerkarte vorhanden ist, andernfalls `0`.

`pathName hide tabId`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName identify component x y`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName index tabId`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName insert pos window ?options?`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName instate stateSpec ?script?`
: Siehe den Handbucheintrag zu **ttk_widget**.

`pathName notebookpath`
: Gibt den Pfadnamen des im „scrollednotebook“ enthaltenen Widgets „ttk::notebook“ zurück.  Einer der äußerst seltenen Fälle, in denen dieser Unterbefehl benötigt wird, hängt mit der Einstellung eines Tooltips für eine der Registerkarten zusammen.  Wenn `nb` den von diesem Unterbefehl gegebenen Pfad ttk::notebook bezeichnet, können Sie einen Tooltip `message` für eine seiner Registerkarten festlegen, indem Sie entweder die Option `-tab` des Befehls `tooltip::tooltip` aus dem in tklib enthaltenen Tooltip-Paket verwenden:

```
tooltip::tooltip nb -tab tabId message
```

: oder die Option `-nbktab` des Befehls `baltip::tip` aus dem baltip-Paket von Alex Plotnikov:

```
baltip::tip nb message -nbktab tabWindow ...
```

: Die Unterstützung für die Option `-tab` des Befehls `tooltip::tooltip` wurde in Version 1.6 des Tooltip-Pakets hinzugefügt. Der Befehl `baltip::tip` akzeptiert zudem eine Vielzahl weiterer Optionen.  Das baltip-Paket kann unter folgendem Link heruntergeladen werden:

https://chiselapp.com/user/aplsimple/repository/baltip/download/

: **HINWEIS:**  Abgesehen von der oben genannten Ausnahme ist es in den allermeisten Fällen nicht erforderlich, direkt auf das im „scrollednotebook“-Widget enthaltene „ttk::notebook“-Widget zuzugreifen.  Darüber hinaus führt die Verwendung der Optionen oder Unterbefehle von ttk::notebook anstelle derjenigen des „scrollednotebook“-Widgets in den meisten Fällen zu unvorhersehbarem Verhalten.

`pathName see tabId`
: Dieser Unterbefehl passt die Ansicht im Fenster von „scrollednotebook“ so an, dass die durch `tabId` angegebene Registerkarte darin sichtbar wird. Beachten Sie, dass dieser Befehl automatisch aufgerufen wird, sobald eine Registerkarte ausgewählt wird, um diese Registerkarte sichtbar zu machen.

`pathName select ?tabId?`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName state ?stateSpec?`
: Siehe den Handbucheintrag zu **ttk_widget**.

`pathName style`
: Gibt den Wert der Konfigurationsoption `-style` zurück (d. h. den Stil, der vom Widget ttk::notebook verwendet wird, das im Widget „scrollednotebook“ enthalten ist).  Für Widgets mit Tk-Thema wurde dieser Unterbefehl in Tk 8.7a4 eingeführt, das „scrollednotebook“-Widget stellt ihn jedoch für alle unterstützten Tk-Versionen bereit.

`pathName tab tabId ?option ?value option value ...??`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName tabattrib tabId ?name ?value name value ...??`
: Fragt die Attribute der durch `tabId` angegebenen Registerkarte ab oder ändert sie. Wenn kein `name` festgelegt ist, gibt der Befehl eine Liste von Paaren zurück, von denen jedes den Namen und den Wert eines Attributs der Registerkarte enthält.  Wenn `name` ohne `value` festgelegt wird, gibt der Befehl den Wert des einen benannten Registerkartenattributs zurück oder eine leere Zeichenkette, falls kein entsprechender Wert vorhanden ist (Sie können den Unterbefehl `hastabattrib` verwenden, um diesen Fall von dem zu unterscheiden, bei dem der Wert eines *vorhandenen* Registerkartenattributs eine leere Zeichenkette ist).  Wenn ein oder mehrere Paare aus `name` und `value` gelegt werden, setzt der Befehl das/die angegebene(n) Registerkartenattribut(e) auf den/die angegebenen Wert(e); in diesem Fall gibt der Befehl eine leere Zeichenkette zurück.  Jedes `name` kann eine beliebige Zeichenkette sein.

`pathName tabs`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName unsetattrib name`
: Hebt das Attribut `name` auf. Gibt eine leere Zeichenfolge zurück.

`pathName unsettabattrib tabId name`
: Hebt das Attribut `name` für die durch `tabId` angegebene Registerkarte auf. Gibt eine leere Zeichenkette zurück.


**TASTATURNAVIGATION**
: Siehe den Handbucheintrag zu **ttk_notebook**.

**VIRTUELLE EREIGNISSE**
: Wie im Handbucheintrag zu **ttk_notebook** beschrieben, generiert das Widget ein virtuelles Ereignis vom Typ `<<NotebookTabChanged>>`, nachdem eine neue Registerkarte eines ttk::notebook (programmgesteuert oder interaktiv) ausgewählt wurde.  Dies gilt auch für „scrollednotebook“-Widgets.

: Das Paket „Scrollutil_tile“ definiert das virtuelle Ereignis `<<Button3>>` für alle Fenstersysteme als `<Button-3>` und zusätzlich für Mac OS X/11+ als `<Control-Button-1>`.  Wenn dieses Ereignis über einer Registerkarte eines ttk::notebook oder eines scrollednotebook auftritt, dessen Widget-Statusflag `disabled` nicht gesetzt ist, und die Tk-Version 8.5a2 oder höher ist, dann erzeugt das Widget ein virtuelles Ereignis `<<MenuItemsRequested>>`, indem es `` event generate`` aufruft, wobei die Option ``-data`` auf eine Liste gesetzt ist, die aus dem Pfadnamen eines leeren Popup-Menüs und dem numerischen Index der betreffenden Registerkarte besteht.  (Die Unterstützung für diese Option wurde in Tk 8.5a2 eingeführt.)  Wenn die Anwendung eine Bindung für dieses virtuelle Ereignis erstellt, kann das Bindungsskript auf die Benutzerdaten als Wert des Feldes `%d` zugreifen, um das Menü mit anwendungsspezifischen Einträgen zu füllen.  HINWEIS: Das Popup-Menü wird mit einer Verzögerung von 100 ms angezeigt, um sicherzustellen, dass es bereits von der Anwendung ausgefüllt erscheint.

Das folgende Beispiel zeigt einen Popup-Menüpunkt zum Schließen der Registerkarten eines ttk::notebook- oder eines scrollednotebook-Widgets (`$nb`):

```
bind $nb <<MenuItemsRequested>> { populateMenu %W %d }

proc populateMenu {nb data} {
    foreach {menu tabIdx} $data {}
    $menu add command -label "Close Tab" -command [list $nb forget $tabIdx]
}
```

: Eine BESCHREIBUNG der VIRTUELLEN EREIGNISSE `<<NotebookTabMoved>>`, `<<NotebookTabClosed>>` und `<<CloseTabRequested>>` finden Sie im nächsten Abschnitt.

**WEITERE BINDUNGEN**
: Das Paket „Scrollutil_tile“ erstellt die folgenden zusätzlichen Bindungen für die Widgets „ttk::notebook“ und „scrollednotebook“:


  1. **Navigation zwischen den Registerkarten eines „scrollednotebook“- oder „ttk::notebook“-Widgets über das Mausrad oder das Touchpad:**  Ein Klick mit dem Mausrad oder eine Zwei-Finger-Geste auf dem Touchpad wählt zyklisch die Registerkarte im Zustand `normal` aus, die der aktuell ausgewählten vorausgeht bzw. ihr folgt.  (HINWEIS: Der gleiche Effekt kann auch mit den Tasten `Right`, `Left`, `Control-Tab` und `Control-Shift-Tab` erzielt werden.)  Im Fenstersystem `aqua` wird, wenn die Taste `Option` gedrückt ist, während das Mausrad gedreht wird, durch einen Mausrad-Tick zyklisch die 10. Registerkarte des Zustands `normal` ausgewählt, die auf die aktuell ausgewählte folgt bzw. ihr vorausgeht (modulo der Anzahl der Registerkarten).  Das Gleiche gilt für die Fenstersysteme `x11` und `win32`, wenn die Tk-Version 8.7a4 oder höher ist und das Mausrad bei gedrückter Taste `Alt` gedreht wird.
  2. **Blättern in der Registerkarten-Zeile eines „scrollednotebook“-Widgets mithilfe der Pfeiltasten:**  Wenn die Registerkarte am rechten Rand des „scrollednotebook“-Widgets nur teilweise sichtbar ist, passt ein Klick mit der linken Maustaste auf den Rechtspfeil die Ansicht in der Registerkarten-Zeile so an, dass die Registerkarte vollständig sichtbar wird; andernfalls wird durch den Klick die nächste nicht ausgeblendete Registerkarte eingeblendet.  Ähnlich verhält es sich, wenn die Registerkarte am linken Rand des „scrollednotebook“-Widgets nur teilweise sichtbar ist: Durch Drücken der linken Maustaste über dem Pfeil nach links wird die Ansicht in der Registerkarten-Zeile so angepasst, dass die Registerkarte vollständig sichtbar wird; andernfalls wird durch den Klick die vorherige, nicht ausgeblendete Registerkarte eingeblendet.  Wenn die Maustaste mindestens 300 Millisekunden lang gedrückt gehalten wird, wiederholen sich die oben beschriebenen Aktionen automatisch alle 100 Millisekunden.
  3. **Verschieben der Registerkarten eines „scrollednotebook“- oder „ttk::notebook“-Widgets mit der Maus**:  Wenn Maustaste 1 über einer Registerkarte, jedoch außerhalb des `closetab`-Elements (sofern vorhanden) gedrückt und anschließend außerhalb dieser Registerkarte gezogen wird, dann (im Falle eines „scrollednotebook“, vorausgesetzt, der Wert der Option `-movabletabs` des Widgets ist „true“) nimmt der Mauszeiger die Form eines Links-/Rechtspfeils an, was anzeigt, dass die betreffende Registerkarte an eine andere Position verschoben wird.  Dieser Vorgang endet, wenn Maustaste 1 losgelassen wird, und kann durch Drücken der Taste `Escape` abgebrochen werden. In beiden Fällen wird der Mauszeiger auf seinen ursprünglichen Wert zurückgesetzt, der durch die Konfigurationsoption `-cursor` festgelegt ist.  Nach dem Loslassen der Maustaste 1 wird die Quellregisterkarte an die Position verschoben, auf die zuvor der Pfeil zeigte (vorausgesetzt, die Aktion wurde nicht über `Escape` abgebrochen).  Wenn die Tk-Version 8.5a2 oder höher ist, generiert das Widget nach dem Verschieben der Registerkarte an ihre neue Position ein virtuelles Ereignis `<<NotebookTabMoved>>`, indem es `event generate` aufruft, wobei die Option `-data` auf eine Liste gesetzt ist, die aus dem Pfadnamen des im Quellbereich enthaltenen Widgets und dem numerischen Index der Zielposition der Registerkarte besteht.  (Die Unterstützung für diese Option wurde in Tk 8.5a2 eingeführt.) All das gilt auch für ein ttk::notebook mit vertikalem Registerkarten-Layout, mit dem einzigen Unterschied, dass der Cursor für die Dauer des Ziehvorgangs die Form eines Aufwärts-/Abwärtspfeils annimmt.
  4. **Schließen eines Reiters eines „scrollednotebook“-Widgets mithilfe des „closetab“-Elements**:  Wenn die Maustaste 1 über dem Element `closetab` (sofern vorhanden) eines Reiters gedrückt und später über demselben Element wieder losgelassen wird, vorausgesetzt, dass sowohl der Wert der Option `-state` der Registerkarte als auch der Status ihres Elements `closetab` `normal` ist, wird die Registerkarte mittels des Unterbefehls `forget` des Widgets geschlossen.  Beachten Sie, dass dieser Vorgang durch den als Wert der Option `-forgetcommand` angegebenen Befehl abgebrochen werden kann; war dies nicht der Fall und handelt es sich um die Tk-Version 8.5a2 oder höher, dann erzeugt das Widget nach dem Schließen der Registerkarte ein virtuelles Ereignis vom Typ `<<NotebookTabClosed>>`, indem es `event generate` aufruft, wobei die Option `-data` auf den Pfadnamen des Widgets gesetzt ist, das sich auf der Teilfläche dieser Registerkarte befindet.
  5.  **Schließen eines Reiters eines ttk::notebook-Widgets mithilfe des „closetab“-Elements**:  Wenn die linke Maustaste über dem `closetab`-Element (sofern vorhanden) eines Reiters gedrückt und später über demselben Element wieder losgelassen wird, vorausgesetzt, dass sowohl der Wert der Option `-state` der Registerkarte als auch der Status ihres Elements `closetab` den Wert `normal` haben, wird eine von der Tk-Version abhängige Aktion ausgeführt:  

    - Wenn die Tk-Version 8.5a2 oder höher ist, wird die Registerkarte (noch) nicht geschlossen.  Stattdessen generiert das Widget ein virtuelles Ereignis vom Typ `<<CloseTabRequested>>`, indem es `event generate` aufruft, wobei die Option `-data` auf den numerischen Index der betreffenden Registerkarte gesetzt ist.  Es liegt in der Verantwortung der Anwendung, eine Bindung für dieses virtuelle Ereignis zu erstellen und die Registerkarte aus dem Bindungsskript heraus zu schließen, indem gegebenenfalls der Unterbefehl `forget` des Widgets aufgerufen wird, wie im folgenden Beispiel gezeigt:

      ```
      bind $nb <<CloseTabRequested>> { closeTab %W %d }

      proc closeTab {nb tabIdx} {
          set btn [tk_messageBox -title "Close Tab?" -icon question \
                   -message "Do you really want to close the tab?" -type yesno
          if {$btn eq "yes"} {
              $nb forget $tabIdx

              # Optionally:
              set widget [lindex [$nb tabs] $tabIdx]
              event generate $nb <<NotebookTabClosed>> -data $widget
          }
      }
      ```

    - Wenn die Tk-Version älter als 8.5a2 ist, wird die Registerkarte sofort über den Unterbefehl `forget` des Widgets geschlossen.  (Zur Erinnerung: Die Option `-data` für VIRTUELLE EREIGNISSE wurde in Tk 8.5a2 eingeführt.)

: Wenn das Statusflag `disabled` des Widgets gesetzt ist, findet keine der oben genannten Aktionen statt: Die Registerkarten sind vollständig deaktiviert.

**SCHLÜSSELWÖRTER**
: scrollednotebook, widget, notebook, scrolled


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Das Stilelement `closetab`

Das Paket „Scrollutil_tile“ erstellt automatisch ein neues Stilelement mit dem Namen `closetab`, dessen Form einem „x“ ähnelt. Die Größe des Elements hängt vom Skalierungsfaktor von Tk ab, während seine Vordergrundfarbe themenspezifisch ist und bei jedem Wechsel des Themas aktualisiert wird.

Sie können dieses Element zu den Registerkarten eines Stile vom Typ ttk::notebook (wie `TNotebook` oder `My.TNotebook`) hinzufügen, mithilfe des Befehls `scrollutil::addclosetab`, wodurch die Registerkarten jedes ttk::notebook- oder scrollednotebook-Widgets dieses Stils vom Benutzer geschlossen werden können.

Für den umgekehrten Vorgang stellt das Paket „Scrollutil_tile“ den Befehl `scrollutil::removeclosetab` zur Verfügung.

Der Status (`normal` oder `disabled`) der Elemente `closetab` einer Registerkarte vom Typ ttk::notebook oder scrollednotebook kann mithilfe des Befehls `scrollutil::closetabstate` festgelegt und abgefragt werden.

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::addclosetab`

**NAME**
: `scrollutil::addclosetab` – Fügen Sie das Element `closetab` zu den Registerkarten des Stile ttk::notebook hinzu

**ÜBERSICHT**
: 

```
package require scrollutil_tile
scrollutil::addclosetab notebookStyle
```

: HINWEIS: Der Befehl `scrollutil::addclosetab` wird vom Paket „Scrollutil_tile“ bereitgestellt, nicht jedoch von Scrollutil.

**BESCHREIBUNG**
: Passen Sie den Stil `notebookStyle.Tab` an einen bestimmten Stil „ttk::notebook“ an (wie z. B. `TNotebook` oder `My.TNotebook`), indem das Element `closetab` hinzugefügt wird.  Dadurch können die Registerkarten aller ttk::notebook- oder scrollednotebook-Widgets, bei denen die Option `-style` auf `notebookStyle` gesetzt wurde, vom Benutzer geschlossen werden.  Wenn das Element `closetab` bereits im Stil `notebookStyle.Tab` vorhanden ist, gibt der Befehl zurück, ohne eine Aktion auszuführen.

**SCHLÜSSELWÖRTER**
: ttk::notebook style, closetab


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::removeclosetab`

**NAME**
: `scrollutil::removeclosetab` – Entfernen Sie das Element `closetab` aus den Registerkarten eines Stils vom Typ ttk::notebook

**ÜBERSICHT**
: 

```
package require scrollutil_tile
scrollutil::removeclosetab notebookStyle
```

: HINWEIS: Der Befehl `scrollutil::removeclosetab` wird vom Paket „Scrollutil_tile“ bereitgestellt, nicht jedoch von Scrollutil.

**BESCHREIBUNG**
: Ändert den Stil `notebookStyle.Tab`, der zu einem gegebenen ttk::notebook-Stil gehört (etwa `TNotebook` oder `My.TNotebook`), indem das Element `closetab` daraus entfernt wird. War das Element `closetab` im Stil `notebookStyle.Tab` nicht vorhanden, kehrt der Befehl zurück, ohne etwas zu tun.

**SCHLÜSSELWÖRTER**
: ttk::notebook style, closetab


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::closetabstate`

**NAME**
: `scrollutil::closetabstate` – Den Status des Elements `closetab` eines ttk::notebook oder einer Registerkarte eines ScrolledNotebook festlegen oder abfragen

**ÜBERSICHT**
: 

```
package require scrollutil_tile
scrollutil::closetabstate notebook tabId ?normal|disabled?
```

: Es gibt einen HINWEIS, dass der Befehl `scrollutil::closetabstate` vom Paket „Scrollutil_tile“ bereitgestellt wird, nicht jedoch von Scrollutil.

**BESCHREIBUNG**
: Setzt oder fragt den Status des Elements `closetab` der Registerkarte ab, die durch `tabId` des Widgets „ttk::notebook“ oder „scrollednotebook“ (`notebook`) angegeben wird.  Das optionale Argument legt den Status als `normal` oder `disabled` fest. Ohne dieses Argument gibt der Befehl den aktuellen Status des Elements `closetab` der Registerkarte zurück.

: Sofern das Statusflag `disabled` des Widgets nicht gesetzt ist und der Wert der Option `-state` der Registerkarte `normal` lautet, bestehen folgende Unterschiede zwischen den beiden `closetab`-Zuständen:

  - Im Standardzustand `normal` wird das Elemente `closetab` bei Mauszeigerüberführung in weißer Farbe auf hellrotem Hintergrund angezeigt und bei Betätigung mit Maustaste 1 in weißer Farbe auf dunkelrotem Hintergrund.  Wird die Maustaste 1 über demselben Element losgelassen, wird die unter den Punkten 4 und 5 des obigen Abschnitts [WEITERE BINDUNGEN](#der-befehl-scrollutil-scrollednotebook-ausf-hrliche-referenz) beschriebene Aktion ausgelöst.
  - Im Zustand `disabled` wird das Elemente `closetab` sowohl beim Bewegen des Mauszeigers darüber als auch beim Klicken in derselben themenspezifischen Vordergrundfarbe wie deaktivierter Text angezeigt, und das Klicken und anschließende Loslassen der Maustaste 1 darüber hat keine Auswirkung.

: Beachten Sie, dass der Unterbefehl „`closetabstate` scrollednotebook“ eine praktische Abkürzung für diesen Befehl ist.

**SCHLÜSSELWÖRTER**
: tab, closetab, state


[Inhalt](#inhalt)     [Startseite](index.md)
