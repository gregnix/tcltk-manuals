# Der Befehl `scrollutil::plainnotebook`

## Für Scrollutil Version 2.11

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Kurzanleitung](#kurzreferenz)
- [Ausführliche Referenz](#ausf-hrliche-referenz)

[Startseite](index.md)

---

## Kurzreferenz

[NAME](#ausf-hrliche-referenz)
: `scrollutil::plainnotebook` – Erstellen und Bearbeiten von PlainNotebook-Widgets

[ÜBERSICHT](#ausf-hrliche-referenz)
: 

```
package require scrollutil_tile
scrollutil::plainnotebook pathName ?options?
```

[STANDARDOPTIONEN](#ausf-hrliche-referenz)
: 

```
-class  -cursor  -style
```

[WIDGET-SPEZIFISCHE OPTIONEN](#ausf-hrliche-referenz)
: `-caller pageIndex`

: `-closabletabs boolean`

: `-forgetcommand command`

: `-height screenDistance`

: `-leavecommand command`

: `-movabletabs boolean`

: `-side left|right`

: `-takefocus 0|1|""|command`

: `-title text`

: `-width screenDistance`

[Widget COMMAND](#ausf-hrliche-referenz)
: `pathName add window ?options?`

: `pathName addbutton pageIndex text ?image?`

: `pathName addlabel text ?image?`

: `pathName addseparator`

: `pathName adjustsize`

: `pathName attrib ?name ?value name value ...??`

: `pathName cget option`

: `pathName closablestate tabId ?boolean?`

: `pathName configure ?option ?value option value ...??`

: `pathName forget tabId`

: `pathName hasattrib name`

: `pathName hastabattrib tabId name`

: `pathName hide tabId`

: `pathName index tabId`

: `pathName insert pos window ?options?`

: `pathName insertbutton pos pageIndex text ?image?`

: `pathName insertlabel pos text ?image?`

: `pathName insertseparator pos`

: `pathName instate stateSpec ?script?`

: `pathName see tabId`

: `pathName select ?tabId?`

: `pathName state ?stateSpec?`

: `pathName style`

: `pathName tab tabId ?option ?value option value ...??`

: `pathName tabattrib tabId ?name ?value name value ...??`

: `pathName tabpath tabId`

: `pathName tabs`

: `pathName titlepath`

: `pathName unsetattrib name`

: `pathName unsettabattrib tabId name`

[SCHLÜSSELWÖRTER](#ausf-hrliche-referenz)
: plainnotebook, widget, notebook, closebtn


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Ausführliche Referenz

**NAME**
: `scrollutil::plainnotebook` – Erstellen und Bearbeiten von PlainNotebook-Widgets

**ÜBERSICHT**
: 

```
package require scrollutil_tile
scrollutil::plainnotebook pathName ?options?
```

: HINWEIS: Der Befehl `scrollutil::plainnotebook` wird vom Paket „Scrollutil_tile“ bereitgestellt, nicht jedoch von Scrollutil.

**BESCHREIBUNG**
: Der Befehl `scrollutil::plainnotebook` erstellt ein neues Fenster mit dem Namen `pathName` und wandelt es in ein **plainnotebook**-Widget um.  Zusätzliche Optionen, die im Folgenden beschrieben werden, können über die Befehlszeile oder in der Optionsdatenbank festgelegt werden, um Aspekte des „plainnotebook“-Widgets wie Breite, Höhe und Seite zu konfigurieren. Der Befehl `scrollutil::plainnotebook` gibt sein Argument `pathName` zurück.  Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen `pathName` existieren, aber das übergeordnete Fenster von `pathName` muss vorhanden sein.

: Ein „plainnotebook“ ist ein Megawidget, das ein ttk::notebook mit einer beliebigen Anzahl von Seiten und unsichtbaren Registerkarten um ein ttk::frame links oder rechts davon erweitert, das unter anderem ein [scrollableframe](scrollableframe.md), dessen Inhaltsrahmen das übergeordnete Element einer Reihe von Widgets ist, die die Rolle vertikal angeordneter Notizbuchregisterkarten übernehmen.  Derzeit nicht sichtbare „Registerkarten“ können durch Navigation mit dem Mausrad, dem Touchpad oder der Tastatur sowie durch Scrollen mit der vertikalen Bildlaufleiste des [scrollarea](scrollarea.md), der den scrollableframe enthält.  Ein einzelner „Reiter“ kann programmgesteuert mithilfe des Unterbefehls `see` sichtbar gemacht werden.  Im Gegensatz zu einem ttk::notebook-Widget mit vertikal ausgerichteten Registerkarten, das in den meisten Themen ein suboptimales Erscheinungsbild aufweist und dessen `-height`-Option häufig durch die Gesamthöhe der Registerkarten überschrieben wird, beachtet das „plainnotebook“-Widget den Wert seiner Option `-height`, unabhängig vom Platzbedarf der „Registerkarten“.

: Im weiteren Verlauf dieses Dokuments werden die Widgets, die als vertikal angeordnete Notizbuchregisterkarten dienen, selbst als **Registerkarten** bezeichnet.

: Der obere Teil des Rahmens links oder rechts neben der Komponente ttk::notebook enthält eine Schaltfläche und ein ttk::label-Widget, die als **Aufwärts-Schaltfläche** bzw. **Titelbeschriftung** bezeichnet werden.  Ihre Sichtbarkeit wird durch die Widget-Optionen `-caller` und `-title` gesteuert.  Die Aufwärts-Schaltfläche zeigt ein Bild an, dessen Form der eines <-Zeichens ähnelt.

: Die API des „plainnotebook“-Widgets ähnelt stark der von ttk::notebook.  Abgesehen von einigen zusätzlichen, plainnotebook-spezifischen Unterbefehlen und dem fehlenden Unterbefehl `identify` bietet der mit einem „plainnotebook“-Widget verknüpfte Tcl-Befehl dieselben Unterbefehle wie der mit einem ttk::notebook verknüpfte.  Beachten Sie, dass die API keinen Befehl zum Abrufen des Pfadnamens des in einem „plainnotebook“ enthaltenen „ttk::notebook“-Widgets bereitstellt, da kein direkter Zugriff auf dieses Widget erforderlich ist.  Darüber hinaus führt die Verwendung seiner Optionen oder Unterbefehle anstelle derjenigen des „plainnotebook“-Widgets in den meisten Fällen zu unvorhersehbarem Verhalten.

: Beachten Sie außerdem, dass nur die mit den Unterbefehlen `add` und `insert` erstellten Registerkarten auswählbar sind.  Die mit den plainnotebook-spezifischen Unterbefehlen `addbutton` und `insertbutton` erstellten Registerkarten dienen dazu, zu einem anderen plainnotebook-Widget zu wechseln, während die mit `addlabel`, `addseparator`, `insertlabel` und `insertseparator` erstellt wurden, können als Titel und Trennzeichen für Registerkartengruppen verwendet werden.

**STANDARDOPTIONEN**
: 

```
-class  -cursor  -style
```

: Einzelheiten zu den Standardoptionen finden Sie im Handbucheintrag zu **ttk_widget**. Der Wert der Option `-class` lautet `Plainnotebook`, der der Option `-cursor` ist eine leere Zeichenkette.  Die Option `-style`, deren Wert `Plain.TNotebook` ist, bezieht sich auf den Stil des im „plainnotebook“ enthaltenen Widgets ttk::notebook.  Das „schlichte“ Erscheinungsbild dieses ttk::notebook-Widgets wird erreicht, indem das Layout des Stils `Plain.TNotebook.Tab` auf `null` und die Optionen `-mintabwidth`, `-tabmargins` und `-padding` des Stils `Plain.TNotebook` auf `0` gesetzt werden.

**WIDGET-SPEZIFISCHE OPTIONEN**
: 

|   |   |
| --- | --- |
| Befehlszeilenname:  | `-caller` |
| Name der Datenbank: | ` caller` |
| Datenbankklasse: | ` Caller` |

Der Wert dieser Option muss eine ganze Zahl sein.  Ist er nicht negativ, muss das übergeordnete Widget des Widgets ein [pagesman](pagesman.md)-Widget sein.  In diesem Fall wird der Wert als numerischer Index einer bereits vorhandenen Seite des übergeordneten pagesman-Widgets interpretiert, und die Schaltfläche „Nach oben“ des „plainnotebook“ wählt diese Seite aus, die als „Aufrufer“ des aktuellen „plainnotebook“-Widgets angesehen wird – das heißt, das aktuelle „plainnotebook“ wurde zuvor von dieser Seite aus ausgewählt.  Wenn der Wert der Option beispielsweise `0` lautet, führt das Drücken und anschließende Loslassen der linken Maustaste über der „Auf“-Schaltfläche dazu, dass Sie zur pagesman-Seite mit dem Index `0` zurückwechselt, von der aus der Benutzer vermutlich zuvor zur aktuellen Seite hinabgestiegen ist. Der Standardwert ist `-1`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-closabletabs` |
| Name der Datenbank: | ` closableTabs` |
| Datenbankklasse: | ` ClosableTabs` |

Legt einen booleschen Wert fest, der bestimmt, ob die (ausschließlich) mit den Unterbefehlen `add` und `insert` erstellten Registerkarten das Element `closebtn` enthalten.  Dieses Stilelement wird automatisch vom Paket „Scrollutil_tile“ erstellt und ähnelt stark dem Element `closetab`.  Siehe den Abschnitt [WEITERE BINDUNGEN](#ausf-hrliche-referenz) weiter unten für Details zum Schließen der Registerkarten mithilfe des Elements `closebtn`.  Der Standardwert ist `0`.  Diese Option kann für einzelne Registerkarten mithilfe des Unterbefehls `closablestate` überschrieben werden.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-forgetcommand` |
| Name der Datenbank: | ` forgetCommand` |
| Datenbankklasse: | ` ForgetCommand` |

Legt einen Befehl fest, der aufgerufen werden soll, wenn versucht wird, eine Registerkarte zu entfernen und das zugehörige Fenster mithilfe des Unterbefehls `forget` aus der Verwaltung zu nehmen.  Wenn der Wert der Option eine nicht leere Zeichenkette ist, wird diese mit dem Pfadnamen des „plainnotebook“-Widgets und dem des Fensters, dessen Verwaltung aufgehoben werden soll, verkettet, und das resultierende Skript, das einen booleschen Wert geben muss, wird im globalen Geltungsbereich ausgewertet.  Wenn der Wert des Skripts „false“ ist, wird der Unterbefehl `forget` abgebrochen, d. h., die Registerkarte wird nicht entfernt und das zugehörige Fenster wird nicht aus der Verwaltung entlassen. Der Standardwert ist eine leere Zeichenkette.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-height` |
| Name der Datenbank: | ` height` |
| Datenbankklasse: | ` Height` |

Falls vorhanden und größer als Null, legt dieser Wert die gewünschte Höhe der Teilfläche des Fensters in einem der von `Tk_GetPixels` akzeptierten Formate fest. Andernfalls wird die maximal angeforderte Höhe aller Teilflächen verwendet. Der Standardwert ist `0`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-leavecommand` |
| Name der Datenbank: | ` leaveCommand` |
| Datenbankklasse: | ` LeaveCommand` |

Legt einen Befehl fest, der aufgerufen werden soll, wenn versucht wird, das aktuell ausgewählte Fenster zu verlassen, indem eine andere Auswahl getroffen wird.  Wenn der Wert der Option eine nicht leere Zeichenkette ist, wird diese mit dem Pfadnamen des „plainnotebook“-Widgets und dem des aktuell ausgewählten Fensters verkettet, und das resultierende Skript, das einen booleschen Wert zurückgeben muss, wird im globalen Geltungsbereich ausgewertet.  Wenn der Wert dieses Skripts „false“ ist, wird der Vorgang der Auswahl eines anderen Fensters abgebrochen. Der Standardwert ist eine leere Zeichenkette.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-movabletabs` |
| Name der Datenbank: | ` movableTabs` |
| Datenbankklasse: | ` MovableTabs` |

Legt einen booleschen Wert fest, der bestimmt, ob die Registerkarten mit der Maus verschoben werden können.  Weitere Informationen finden Sie im Abschnitt [WEITERE BINDUNGEN](#ausf-hrliche-referenz) weiter unten.  Der Standardwert ist `1`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-side` |
| Name der Datenbank: | ` side` |
| Datenbankklasse: | ` Side` |

Legt fest, auf welcher Seite (`left` oder `right`) des Widgets das Element ttk::frame angezeigt werden soll, das die Registerkarten, die Schaltfläche „Aufsteigend“ und die Titelbeschriftung enthält.  Die Standardeinstellung ist `left`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-takefocus` |
| Name der Datenbank: | ` takeFocus` |
| Datenbankklasse: | ` TakeFocus` |

Diese Option legt fest, ob das „plainnotebook“-Widget während der Tastaturnavigation den Fokus annimmt. Sie ist nahezu identisch mit der gleichnamigen Standardoption (Einzelheiten finden Sie im Handbucheintrag **options**).  Der einzige Unterschied besteht darin, dass nicht das „plainnotebook“-Widget selbst, sondern der Inhaltsrahmen des darin enthaltenen „scrollableframe“ den Fokus erhält, wenn die Standardtasten (`Tab` und `Shift-Tab`) bei der Tastaturnavigation betätigt werden.  Die Standardeinstellung ist `"ttk::takefocus"` (genau wie bei ttk::notebook und einigen anderen Widgets im Tk-Thema).


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-title` |
| Name der Datenbank: | ` title` |
| Datenbankklasse: | ` Title` |

Legt den Text fest, der in der Titelbeschriftung des „plainnotebook“ angezeigt werden soll, bei dem es sich um ein ttk::label-Widget im Stil `PnbTitle.TLabel` handelt.  Die für diesen Stil verwendete Schriftart leitet sich von `TkDefaultFont` ab, wobei deren Größe um den Faktor 1,2 vergrößert wurde.  Um eine andere Schriftart festzulegen, verwenden Sie den Befehl `ttk::style` oder ermitteln Sie den Pfadnamen dieses Widgets mit dem Unterbefehl `titlepath` und rufen Sie anschließend `... configure -font ...` auf.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-width` |
| Name der Datenbank: | ` width` |
| Datenbankklasse: | ` Width` |

Falls vorhanden und größer als Null, legt dieser Wert die gewünschte Breite der Teilflächen im Fensterbereich in einem der von `Tk_GetPixels` akzeptierten Formate fest. Andernfalls wird die maximal angeforderte Breite aller Teilflächen verwendet. Der Standardwert ist `0`.

**REGISTEROPTIONEN**
: Siehe den Handbucheintrag zu **ttk_notebook**.

**REGISTERKENNUNGEN**
: Siehe den Handbucheintrag zu **ttk_notebook**. Beachten Sie, dass bei Positionsangaben der Form `"@x,y` die Koordinaten relativ zum „plainnotebook“-Fenster angegeben werden müssen.

**WIDGET-BEFEHL**
: Der Befehl `scrollutil::plainnotebook` erstellt einen neuen Tcl-Befehl mit dem Namen `pathName`. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget auszuführen. Er hat die folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

: `option` und `arg` legen das genaue Verhalten des Befehls fest. Für Plainnotebook-Widgets sind folgende Befehle möglich:


`pathName add window ?options?`
: Siehe den Handbucheintrag zu **ttk_notebook**. Wie dort erwähnt, stellt der Unterbefehl das Fenster `window` an seiner vorherigen Position wieder her, sofern es derzeit vom Notebook verwaltet wird, aber ausgeblendet ist.  Dies gilt gleichermaßen für die nicht auswählbaren (Dummy-)Fenster, die mit den Registerkarten verknüpft sind, die mit den Befehlen `addbutton`, `addlabel`, `addseparator`, `insertbutton`, `insertlabel` und `insertseparator` wurden als Unterbefehle erstellt.  Wenn `window` vom Notizbuch noch nicht verwaltet wird, ist die entsprechende Registerkarte ein ttk::radiobutton-Widget im Stil einer Werkzeugschaltfläche (`Page.Toolbutton` oder `ClosablePage.Toolbutton`, abhängig vom Wert der Option `-closabletabs`).  Der Wert, der zurückgegeben wird, ist der Pfadname des Widgets, das für die Registerkarte verwendet wird, die `window` entspricht (ein ttk::radiobutton oder ttk::button, beide im Toolbutton-Stil, oder ein ttk::label oder ein ttk::separator).

`pathName addbutton pageIndex text ?image?`
: Fügt eine neue Registerkarte hinzu, die als ttk::button-Widget im Toolbutton-Stil implementiert ist (`Desc.Toolbutton`), das neben dem angegebenen `text` und dem optionalen `image` das Element `descend` anzeigt, dessen Form der eines >-Zeichens ähnelt.  Dieses Stilelement wird automatisch vom Paket „Scrollutil_tile“ erstellt. Seine Größe hängt vom Skalierungsfaktor von Tk ab, während seine Vordergrundfarbe themenspezifisch ist und bei jedem Wechsel des Themas aktualisiert wird. Der Rückgabewert ist der Pfadname des oben genannten ttk::button-Widgets.

: Damit dieser Unterbefehl funktioniert, muss das übergeordnete Element des Widgets ein [pagesman](pagesman.md)-Widget sein. `pageIndex`, das eine nicht-negative Ganzzahl sein muss, legt den numerischen Index einer Seite innerhalb des pagesman-Widgets fest, die beim Aufrufen der Werkzeugschaltfläche ausgewählt wird.  Es wird nicht erwartet, dass die durch `pageIndex` identifizierte Seite zum Zeitpunkt des Aufrufs dieses Unterbefehls bereits existiert; sie kann später erstellt und dem „pagesman“-Widget hinzugefügt werden.

: Dieser Unterbefehl macht es zusammen mit der Option `-caller` einfach, Anwendungen zu schreiben, in denen der Benutzer mit einem einzigen Mausklick von einem plainnotebook zu einem anderen innerhalb eines gemeinsamen pagesman-Elternteils absteigt und auf dieselbe Weise zum ursprünglichen zurückwechselt. Haben die beiden plainnotebook-Widgets beispielsweise die Seitenindizes `0` und `1`, genügt es, den Seitenindex `1` an den Unterbefehl `addbutton` des ersten plainnotebook zu übergeben und die Option `-caller` des zweiten auf den Seitenindex `0` zu setzen.

`pathName addlabel text ?image?`
: Fügt eine neue Registerkarte hinzu, die als ttk::label-Widget im Stil `PnbLabel.TLabel` implementiert ist und das angegebene `text` sowie optional `image` anzeigt, und wird typischerweise als Titel einer Gruppe von Registerkarten verwendet. Die für diesen Stil verwendete Schriftart leitet sich von `TkDefaultFont` ab, wobei deren Größe um den Faktor 1,2 vergrößert wurde, und kann mit dem Befehl `ttk::style` geändert werden.  Der Wert, der zurückgegeben wird, ist der Pfadname des oben genannten ttk::label-Widgets; Sie können ihn beispielsweise verwenden, um die Schriftart des Stils für diese bestimmte Beschriftung über `... configure -font ...` zu überschreiben.

`pathName addseparator`
: Fügt eine neue Registerkarte hinzu, die als horizontales ttk::separator-Widget implementiert ist und in der Regel als Trennzeichen für eine Gruppe von Registerkarten dient. Der Wert ist der Pfadname des oben genannten ttk::separator-Widgets.

`pathName adjustsize`
: Setzt die Option `-height` des PlainNotebooks auf die maximal angeforderte Höhe aller Teilflächen und die Option `-width` auf die maximal angeforderte Breite aller Teilflächen.

: **HINWEIS:**  Wenn die Optionen `-height` und `-width` von plainnotebook den Standardwert `0` haben, ist in vielen Fällen kein Aufruf dieses Unterbefehls erforderlich, da das Widget automatisch versucht, seine Größe an die maximal angeforderte Größe seiner Teilflächen anzupassen.

`pathName attrib ?name ?value name value ...??`
: Fragt die Attribute des Widgets ab oder ändert sie.  Wenn kein `name` angegeben ist, gibt der Befehl eine Liste von Paaren zurück, von denen jedes den Namen und den Wert eines Attributs für `pathName` enthält.  Wenn `name` ohne `value` festgelegt wird, gibt der Befehl den Wert des genannten Attributs zurück oder eine leere Zeichenkette, falls kein entsprechender Wert vorhanden ist (mit dem Unterbefehl `hasattrib` können Sie diesen Fall von dem unterscheiden, bei dem der Wert eines *vorhandenen* Attributs eine leere Zeichenkette ist).  Wenn ein oder mehrere Paare aus `name` und `value` angegeben werden, legt der Befehl das/die angegebene(n) Widget-Attribut(e) auf den/die angegebenen Wert(e) fest; in diesem Fall ist der Rückgabewert eine leere Zeichenkette.  Jedes `name` kann eine beliebige Zeichenkette sein.

`pathName cget option`
: Gibt den aktuellen Wert der durch `option` angegebenen Konfigurationsoption zurück, die einen beliebigen der vom Befehl `scrollutil::plainnotebook` akzeptierten Werte annehmen kann.

`pathName closablestate tabId ?boolean?`
: Legt das Vorhandensein des Elements `closebtn` in der durch `tabId` angegebenen Registerkarte fest oder fragt es ab.  Das optionale Argument wird nur für Registerkarten unterstützt, die über `add` oder `insert` erstellt wurden. Dieser Unterbefehl überschreibt die Option `-closabletabs` für die angegebene Registerkarte.

`pathName configure ?option ?value option value ...??`
: Ruft die Konfigurationsoptionen des Widgets ab oder ändert sie.  Wenn kein `option` festgelegt ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für `pathName` beschreibt (Informationen zum Format dieser Liste finden Sie unter `Tk_ConfigureInfo`).  Wenn `option` ohne `value` festgelegt wird, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste entspricht der entsprechenden Unterliste des gegebenen Werts, wenn kein `option` angegeben wurde).  Wenn ein oder mehrere Paare aus `option` und `value` festgelegt werden, ändert der Befehl die festgelegten Widget-Optionen so, dass sie die festgelegten Werte annehmen; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück.  `option` kann jeden der vom Befehl `scrollutil::plainnotebook` akzeptierten Werte annehmen.

`pathName forget tabId`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName hasattrib name`
: Gibt `1` zurück, wenn das Attribut `name` vorhanden ist, andernfalls `0`.

`pathName hastabattrib tabId name`
: Gibt `1` zurück, wenn das Attribut `name` für die durch `tabId` angegebene Registerkarte vorhanden ist, andernfalls `0`.

`pathName hide tabId`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName index tabId`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName insert pos window ?options?`
: Siehe den Handbucheintrag zu **ttk_notebook**. Wie dort erwähnt, verschiebt der Unterbefehl `window` an die angegebene Position, sofern es bereits vom Notebook verwaltet wird.  Dies gilt gleichermaßen für die nicht auswählbaren (Dummy-)Fenster, die mit den Registerkarten verknüpft sind, die mit den Befehlen `addbutton`, `addlabel`, `addseparator`, `insertbutton`, `insertlabel` und `insertseparator` erstellten Unterbefehle, die nicht auswählbare (Dummy-)Fenster erstellen.  Wenn `window` vom Notebook noch nicht verwaltet wird, ist die entsprechende Registerkarte ein ttk::radiobutton-Widget im Stil einer Werkzeugschaltfläche (`Page.Toolbutton` oder `ClosablePage.Toolbutton`, je nach Wert der Option `-closabletabs`).  Der Wert, der zurückgegeben wird, ist der Pfadname des Widgets, das für die Registerkarte verwendet wird, die `window` entspricht (entweder ein ttk::radiobutton oder ttk::button, beide im Toolbutton-Stil, oder ein ttk::label oder ein ttk::separator).

`pathName insertbutton pos pageIndex text ?image?`
: Fügt eine neue Registerkarte ein, die als ttk::button-Widget im Stil einer Werkzeugschaltfläche implementiert ist (`Desc.Toolbutton`), das neben dem angegebenen `text` und dem optionalen `image` das Element `descend` an der angegebenen Position anzeigt.  Die Details entsprechen weitgehend denen des Unterbefehls `addbutton`.

`pathName insertlabel pos text ?image?`
: Fügt eine neue Registerkarte ein, die als ttk::label-Widget im Stil `PnbLabel.TLabel` implementiert ist und das angegebene `text` sowie optional `image` an an der angegebenen Position anzeigt. Die Details ähneln weitgehend denen des Unterbefehls `addlabel`.

`pathName insertseparator pos`
: Fügt an der festgelegten Position eine neue Registerkarte ein, die als horizontales ttk::separator-Widget implementiert ist. Die Details entsprechen weitgehend denen des Unterbefehls `addseparator`.

`pathName instate stateSpec ?script?`
: Siehe den Handbucheintrag zu **ttk_widget**.

`pathName see tabId`
: Dieser Unterbefehl passt die Ansicht im Fenster von „plainnotebook“ so an, dass die durch `tabId` angegebene Registerkarte darin sichtbar wird. HINWEIS: Dieser Befehl wird automatisch aufgerufen, sobald eine Registerkarte ausgewählt wird, um diese Registerkarte sichtbar zu machen.

`pathName select ?tabId?`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName state ?stateSpec?`
: Siehe den Handbucheintrag zu **ttk_widget**.

`pathName style`
: Gibt den Wert der Konfigurationsoption `-style` zurück (d. h. den Stil, der vom Widget ttk::notebook verwendet wird, das im „plainnotebook“ enthalten ist).  Für Widgets mit Tk-Thema wurde dieser Unterbefehl in Tk 8.7a4 eingeführt, das „plainnotebook“-Widget stellt ihn jedoch für alle unterstützten Tk-Versionen bereit.

`pathName tab tabId ?option ?value option value ...??`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName tabattrib tabId ?name ?value name value ...??`
: Fragt die Attribute der durch `tabId` angegebenen Registerkarte ab oder ändert sie. Wenn kein `name` festgelegt ist, gibt der Befehl eine Liste von Paaren zurück, von denen jedes den Namen und den Wert eines Attributs der Registerkarte enthält.  Wenn `name` ohne `value` festgelegt wird, gibt der Befehl den Wert des einen benannten Registerkartenattributs zurück oder eine leere Zeichenkette, falls kein entsprechender Wert vorhanden ist (Sie können den Unterbefehl `hastabattrib` verwenden, um diesen Fall von dem zu unterscheiden, bei dem der Wert eines *vorhandenen* Registerkartenattributs eine leere Zeichenkette ist).  Wenn ein oder mehrere Paare aus `name` und `value` gelegt werden, setzt der Befehl das/die angegebene(n) Registerkartenattribut(e) auf den/die angegebenen Wert(e); in diesem Fall gibt der Befehl eine leere Zeichenkette zurück.  Jedes `name` kann eine beliebige Zeichenkette sein.

`pathName tabpath tabId`
: Gibt den Pfadnamen des Widgets zurück, das für die angegebene Registerkarte verwendet wird.  Bei diesem Widget kann es sich um ein „ttk::radiobutton“ oder „ttk::button“ handeln, die beide den Stil „Toolbutton“ verwenden, oder um ein „ttk::label“ oder ein „ttk::separator“.

`pathName tabs`
: Siehe den Handbucheintrag zu **ttk_notebook**.

`pathName titlepath`
: Gibt den Pfadnamen der Titelbeschriftung des „plainnotebook“ zurück, bei der es sich um ein Widget vom Typ „ttk::label“ im Stil `PnbTitle.TLabel` handelt.

`pathName unsetattrib name`
: Hebt das Attribut `name` auf. Gibt eine leere Zeichenfolge zurück.

`pathName unsettabattrib tabId name`
: Hebt das Attribut `name` für die durch `tabId` angegebene Registerkarte auf. Gibt eine leere Zeichenkette zurück.


**TASTATURNAVIGATION**
: Siehe den Handbucheintrag zu **ttk_notebook**.

**VIRTUELLE EREIGNISSE**
: Wie im Handbucheintrag zu **ttk_notebook** beschrieben, generiert das Widget nach der Auswahl einer neuen Registerkarte eines ttk::notebook (programmgesteuert oder interaktiv) ein virtuelles Ereignis vom Typ `<<NotebookTabChanged>>`.  Dies gilt auch für „plainnotebook“-Widgets.

: Das Paket „Scrollutil_tile“ definiert das virtuelle Ereignis `<<Button3>>` für alle Fenstersysteme als `<Button-3>` und zusätzlich für Mac OS X/11+ als `<Control-Button-1>`.  Tritt dieses Ereignis über einer Registerkarte eines „plainnotebook“ auf, dessen Widget-Zustandsflag `disabled` nicht gesetzt ist, und handelt es sich um die Tk-Version 8.5a2 oder höher, dann erzeugt das Widget ein virtuelles Ereignis `<<MenuItemsRequested>>`, indem es ` event generate` aufruft, wobei die Option `-data` auf eine Liste gesetzt ist, die aus dem Pfadnamen eines leeren Popup-Menüs und dem numerischen Index der betreffenden Registerkarte besteht.  (Die Unterstützung für diese Option wurde in Tk 8.5a2 eingeführt.)  Wenn die Anwendung eine Bindung für dieses virtuelle Ereignis erstellt, kann das Skript der Bindung auf die Benutzerdaten als Wert des Feldes `%d` zugreifen, um das Menü mit anwendungsspezifischen Einträgen zu füllen.  HINWEIS: Das Popup-Menü wird mit einer Verzögerung von 100 ms angezeigt, um sicherzustellen, dass es bereits von der Anwendung ausgefüllt erscheint.

Das folgende Beispiel zeigt einen Eintrag im Popup-Menü zum Schließen der Registerkarten eines „plainnotebook“-Widgets mit der ID `$nb`:

```
bind $nb <<MenuItemsRequested>> { populateMenu %W %d }

proc populateMenu {nb data} {
    foreach {menu tabIdx} $data {}
    $menu add command -label "Close Tab" -command [list $nb forget $tabIdx]
}
```

: Eine BESCHREIBUNG der virtuellen EREIGNISSE `<<NotebookTabMoved>>` und `<<NotebookTabClosed>>` finden Sie im nächsten Abschnitt.

**WEITERE BINDUNGEN**
: Das Paket „Scrollutil_tile“ erstellt die folgenden zusätzlichen Bindungen für die „plainnotebook“-Widgets:


  1. **Navigation zwischen den auswählbaren Registerkarten eines PlainNotebook-Widgets über das Mausrad oder das Touchpad:**  Zur Erinnerung: Bei den auswählbaren Registerkarten handelt es sich um diejenigen, die mit den Unterbefehlen `add` und `insert` erstellt wurden.  Ein Mausrad-Klick oder eine Zwei-Finger-Geste auf dem Touchpad wählt zyklisch die Registerkarte mit dem Status `normal` aus, die auf die aktuell ausgewählte folgt bzw. ihr vorausgeht.  (HINWEIS: Der gleiche Effekt kann auch mit den Tasten `Down`, `Up`, `Control-Tab` und `Control-Shift-Tab` erzielt werden.)  Im Fenstersystem `aqua` wird, wenn die Taste `Option` gedrückt ist, während das Mausrad gedreht wird, durch einen Radsprung zyklisch die 10. auswählbare Registerkarte des Zustands `normal` ausgewählt, die auf die aktuell ausgewählte folgt bzw. ihr vorausgeht (modulo der Anzahl der auswählbaren Registerkarten).  Das Gleiche gilt für die Fenstersysteme `x11` und `win32`, wenn die Tk-Version 8.7a4 oder höher ist und das Mausrad bei gedrückter `Alt`-Taste gedreht wird.
  2. **Verschieben der Registerkarten eines „plainnotebook“-Widgets mit der Maus**:  Wenn die linke Maustaste über einer Registerkarte, jedoch außerhalb des Elements `closebtn` (sofern vorhanden) gedrückt und die Registerkarte anschließend außerhalb dieses Elements gezogen wird, nimmt der Mauszeiger – vorausgesetzt, der Wert der Option `-movabletabs` des Widgets ist „true“ – nimmt der Mauszeiger die Form eines Aufwärts-/Abwärtspfeils an, was anzeigt, dass die betreffende Registerkarte an eine andere Position verschoben wird.  Dieser Vorgang endet, wenn Maustaste 1 losgelassen wird, und kann durch Drücken der Taste `Escape` abgebrochen werden. In beiden Fällen wird der Mauszeiger auf seinen ursprünglichen Wert zurückgesetzt, der durch die Konfigurationsoption `-cursor` festgelegt ist.  Nach dem Loslassen der Maustaste 1 wird die Ausgangsregisterkarte an die Position verschoben, auf die der Pfeil zuvor zeigte (vorausgesetzt, die Aktion wurde nicht über `Escape` abgebrochen).  Wenn die Tk-Version 8.5a2 oder höher ist, generiert das Widget nach dem Verschieben der Registerkarte an ihre neue Position ein virtuelles Ereignis vom Typ `<<NotebookTabMoved>>`, indem es `event generate` aufruft, wobei die Option `-data` auf eine Liste gesetzt ist, die aus dem Pfadnamen des im Quellbereich enthaltenen Widgets und dem numerischen Index der Zielposition der Registerkarte besteht.  (Die Unterstützung für diese Option wurde in Tk 8.5a2 eingeführt.)
  3. **Schließen eines Reiters eines „plainnotebook“-Widgets mithilfe des „closebtn“-Elements**:  Wenn die Maustaste 1 über dem Element `closebtn` (sofern vorhanden) eines Reiters gedrückt und später über demselben Element wieder losgelassen wird, vorausgesetzt, der Wert der Option `-state` der Registerkarte ist `normal`, wird die Registerkarte mittels des Unterbefehls `forget` des Widgets geschlossen.  Beachten Sie, dass dieser Vorgang durch den als Wert der Option `-forgetcommand` angegebenen Befehl abgebrochen werden kann; sollte dies nicht der Fall sein und die Tk-Version 8.5a2 oder höher sein, dann erzeugt das Widget nach dem Schließen der Registerkarte ein virtuelles Ereignis vom Typ `<<NotebookTabClosed>>`, indem es `event generate` aufruft, wobei die Option `-data` auf den Pfadnamen des Widgets gesetzt ist, das sich auf der Teilfläche dieser Registerkarte befindet.

: Wenn das Statusflag `disabled` des Widgets gesetzt ist, findet keine der oben genannten Aktionen statt: Die Registerkarten sind vollständig deaktiviert.

**SCHLÜSSELWÖRTER**
: plainnotebook, widget, notebook, closebtn


[Inhalt](#inhalt)     [Startseite](index.md)
