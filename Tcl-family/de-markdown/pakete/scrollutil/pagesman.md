# Der Befehl `scrollutil::pagesman`

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
: `scrollutil::pagesman` – Seiten-Widgets erstellen und bearbeiten

[ÜBERSICHT](#ausf-hrliche-referenz)
: 

```
scrollutil::pagesman pathName ?options?
```

[STANDARDOPTIONEN](#ausf-hrliche-referenz)
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor
-cursor       -highlightthickness
```

[WIDGET-SPEZIFISCHE OPTIONEN](#ausf-hrliche-referenz)
: `-forgetcommand command`

: `-height screenDistance`

: `-leavecommand command`

: `-takefocus 0|1|""|command`

: `-width screenDistance`

[SEITE KONFIGURATION OPTIONS](#ausf-hrliche-referenz)
: `-padding padding`

: `-sticky stickyness`

[Widget COMMAND](#ausf-hrliche-referenz)
: `pathName add window ?option value option value ...?`

: `pathName adjustsize`

: `pathName attrib ?name ?value name value ...??`

: `pathName cget option`

: `pathName configure ?option ?value option value ...??`

: `pathName forget pageIndex`

: `pathName hasattrib name`

: `pathName haspageattrib pageIndex name`

: `pathName index window`

: `pathName insert pageIndex window ?option value option value ...?`

: `pathName pageattrib pageIndex ?name ?value name value ...??`

: `pathName pagecget pageIndex option`

: `pathName pageconfigure pageIndex ?option ?value option value ...??`

: `pathName pages`

: `pathName select ?pageIndex?`

: `pathName size`

: `pathName unsetattrib name`

: `pathName unsetpageattrib pageIndex name`

: `pathName window pageIndex`

[SCHLÜSSELWÖRTER](#ausf-hrliche-referenz)
: pagesman, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Ausführliche Referenz

**NAME**
: `scrollutil::pagesman` – Seiten-Widgets erstellen und bearbeiten

**ÜBERSICHT**
: 

```
scrollutil::pagesman pathName ?options?
```

**BESCHREIBUNG**
: Der Befehl `scrollutil::pagesman` erstellt ein neues Fenster mit dem Namen `pathName` und der Klasse `Pagesman` und wandelt es in ein **pagesman**-Widget um.  Zusätzliche Optionen, die im Folgenden beschrieben werden, können über die Befehlszeile oder in der Optionsdatenbank festgelegt werden, um Aspekte des pagesman-Widgets wie Breite, Höhe, Rahmenbreite und Relief zu konfigurieren. Der Befehl `scrollutil::pagesman` gibt sein Argument `pathName` zurück.  Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen `pathName` existieren, aber das übergeordnete Fenster von `pathName` muss vorhanden sein.

: Ein „Pagesman“ ist ein Megawidget, das die Grundfunktionalität eines Seitenmanagers bereitstellt, d. h., es verwaltet eine Liste von Fenstern, die als **Seiten** bezeichnet werden, von denen jeweils nur eine sichtbar ist.  Durch die Verwendung von [plainnotebook](plainnotebook.md)-Widgets als Seiten ist es recht einfach, Anwendungen zu schreiben, in denen der Benutzer mit einem einzigen Mausklick von einem „plainnotebook“ zu einem anderen wechseln und auf dieselbe Weise wieder zum ursprünglichen zurückkehren kann.  Alles, was für diese Navigation benötigt wird, wird durch entsprechende Optionen und Unterbefehle des „plainnotebook“-Widgets bereitgestellt.

**STANDARDOPTIONEN**
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor
-cursor       -highlightthickness
```

: Weitere Informationen zu den Standardoptionen für Tk-Widgets finden Sie im Handbucheintrag zu den **options**. Die Optionen `-background`, `-highlightbackground`, `-highlightcolor` und `-highlightthickness` werden nur vom Scrollutil-Paket unterstützt, nicht jedoch von Scrollutil_tile.  Sie haben dieselben Standardwerte wie die gleichnamigen Optionen für Tk-Frame-Widgets.  Die Standardwerte der übrigen Standardoptionen lauten:


```
-borderwidth 0 -cursor "" -relief flat
```

**WIDGET-SPEZIFISCHE OPTIONEN**
: 

|   |   |
| --- | --- |
| Befehlszeilenname:  | `-forgetcommand` |
| Name der Datenbank: | ` forgetCommand` |
| Datenbankklasse: | ` ForgetCommand` |

Legt einen Befehl fest, der aufgerufen werden soll, wenn versucht wird, ein Fenster mithilfe des Unterbefehls `forget` aus der Verwaltung zu entfernen.  Wenn der Wert der Option eine nicht leere Zeichenkette ist, wird diese mit dem Pfadnamen des „pagesman“-Widgets und dem des Fensters, dessen Verwaltung aufgehoben werden soll, verkettet, und das resultierende Skript, das einen booleschen Wert geben muss, wird im globalen Geltungsbereich ausgewertet.  Wenn der Wert dieses Skripts „false“ ist, wird der Unterbefehl `forget` abgebrochen, d. h., das Fenster wird nicht aus der Verwaltung entfernt. Der Standardwert ist eine leere Zeichenkette.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-height` |
| Name der Datenbank: | ` height` |
| Datenbankklasse: | ` Height` |

Falls vorhanden und größer als Null, legt dieser Wert die gewünschte Gesamthöhe des Widgets fest, einschließlich des Rahmens und des Hervorhebungsrechtecks (falls vorhanden), die um das Widget herum gezeichnet werden, und zwar in einem der von `Tk_GetPixels` akzeptierten Formate.  Andernfalls wird die maximal angeforderte Höhe aller Seiten verwendet. Der Standardwert ist `0`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-leavecommand` |
| Name der Datenbank: | ` leaveCommand` |
| Datenbankklasse: | ` LeaveCommand` |

Legt einen Befehl fest, der aufgerufen werden soll, wenn versucht wird, das aktuell ausgewählte Fenster zu verlassen, indem mithilfe des Unterbefehls `select` ein anderes Fenster ausgewählt wird.  Wenn der Wert der Option eine nicht leere Zeichenkette ist, wird diese mit dem Pfadnamen des „pagesman“-Widgets und dem des aktuell ausgewählten Fensters verkettet, und das resultierende Skript, das einen booleschen Wert zurückgeben muss, wird im globalen Geltungsbereich ausgewertet.  Wenn der Wert dieses Skripts „false“ ist, wird der Vorgang der Auswahl eines anderen Fensters abgebrochen. Der Standardwert ist eine leere Zeichenkette.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-takefocus` |
| Name der Datenbank: | ` takeFocus` |
| Datenbankklasse: | ` TakeFocus` |

Diese Option legt fest, ob das Pagesman-Widget während der Tastaturnavigation den Fokus annimmt. Sie ist nahezu identisch mit der gleichnamigen Standardoption (Einzelheiten finden Sie im Handbucheintrag **options**).  Der einzige Unterschied besteht darin, dass nicht das „pagesman“-Widget selbst, sondern das aktuell ausgewählte Fenster (sofern vorhanden) den Fokus erhält, wenn die Standardtasten (`Tab` und `Shift-Tab`) zur Tastaturnavigation verwendet werden.  Der Standardwert ist eine leere Zeichenkette.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-width` |
| Name der Datenbank: | ` width` |
| Datenbankklasse: | ` Width` |

Wenn vorhanden und größer als Null, legt dieser Wert die gewünschte Gesamtbreite des Widgets fest, einschließlich des Rahmens und des Hervorhebungsrechtecks (falls vorhanden), die um das Widget herum gezeichnet werden, und zwar in einer der für `Tk_GetPixels` zulässigen Formen.  Andernfalls wird die maximal angeforderte Breite aller Seiten verwendet. Der Standardwert ist `0`.

**SEITENKONFIGURATIONSOPTIONEN**
: Die folgenden Optionen werden derzeit von den Befehlen `add`, `insert`, `pagecget` und `pageconfigure` unterstützt:


`-padding padding`
: Legt fest, wie viel zusätzlicher Abstand zwischen dem Widget und dieser Seite eingefügt werden soll.  `padding` muss eine Liste mit bis zu vier nicht-negativen Bildschirmabständen  `{left top right bottom}` sein.  Wenn weniger als vier Elemente festgelegt werden, wird `bottom` standardmäßig auf `top` gesetzt, `right` auf `left` und `top` auf `left`.  Ein als leere Liste festgelegter Innenabstand entspricht `0`, was dem Standardwert entspricht.

`-sticky stickyness`
: Legt fest, wie das Seitenfenster innerhalb des Widgets positioniert wird. `stickyness` muss eine Zeichenkette sein, die null oder mehr der Zeichen `n`, `s`, `e` oder `w` enthalten.  Jeder Buchstabe bezieht sich auf eine Seite (Norden, Süden, Osten oder Westen), an der das Seitenfenster gemäß dem Geometriemanager `grid` „haften“ wird.  Die Standard-Haftung ist `nsew`.


**WIDGET-BEFEHL**
: Der Befehl `scrollutil::pagesman` erstellt einen neuen Tcl-Befehl mit dem Namen `pathName`. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget auszuführen. Er hat die folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

: `option` und die `arg`s bestimmen das genaue Verhalten des Befehls.  In den folgenden Beschreibungen der Unterbefehle bezeichnet `pageIndex` stets einen numerischen Index der Seiten, der – mit Ausnahme des Unterbefehls `insert` – größer oder gleich Null und kleiner als die Seitenanzahl sein muss.  Für Pagesman-Widgets sind die folgenden Unterbefehle möglich:


`pathName add window ?option value option value ...?`
: Fügt dem „pagesman“-Widget eine neue Seite hinzu, die aus dem angegebenen Fenster besteht. Eine Liste der verfügbaren Optionen finden Sie im Abschnitt [SEITENKONFIGURATIONSOPTIONEN](#ausf-hrliche-referenz) für eine Liste der verfügbaren Optionen.  Wenn `window` bereits vom „pagesman“-Widget verwaltet wird, verwendet der Unterbefehl seine optionalen Argumente, um die Optionen der entsprechenden Seite zu aktualisieren.

`pathName adjustsize`
: Setzt die Option `-height` des Pagesman-Widgets auf die maximale angeforderte Höhe aller Seiten und die Option `-width` auf die maximale angeforderte Breite aller Seiten.

: **HINWEIS:**  Wenn alle Seiten des „pagesman“-Widgets „plainnotebooks“ sind, deren Optionen `-height` und `-width` den Standardwert `0` haben, ist es in vielen Fällen nicht erforderlich, einem Aufruf dieser Unterbefehl für das „pagesman“-Widget durch Aufrufe des gleichen Namens für dessen Seiten voranzustellen, da jedes „plainnotebook“ seine angeforderte Größe automatisch an die maximal angeforderte Größe seiner Teilflächen anpasst.  Beispielsweise könnte eine Änderung der Schriftart in einigen Teilflächen bestimmter Seiten es erforderlich machen, diesen Unterbefehl für das „pagesman“-Widget aufzurufen, und zum Zeitpunkt des Aufrufs werden die angeforderten Größen seiner Seiten bereits automatisch an die neue Schriftart angepasst sein.

`pathName attrib ?name ?value name value ...??`
: Fragt die Attribute des Widgets ab oder ändert sie.  Wenn kein `name` angegeben ist, gibt der Befehl eine Liste von Paaren zurück, von denen jedes den Namen und den Wert eines Attributs für `pathName` enthält.  Wenn `name` ohne `value` festgelegt wird, gibt der Befehl den Wert des genannten Attributs zurück oder eine leere Zeichenkette, falls kein entsprechender Wert vorhanden ist (mit dem Unterbefehl `hasattrib` können Sie diesen Fall von dem unterscheiden, bei dem der Wert eines *vorhandenen* Attributs eine leere Zeichenkette ist).  Wenn ein oder mehrere Paare aus `name` und `value` angegeben werden, legt der Befehl das/die angegebene(n) Widget-Attribut(e) auf den/die angegebenen Wert(e) fest; in diesem Fall ist der Rückgabewert eine leere Zeichenkette.  Jedes `name` kann eine beliebige Zeichenkette sein.

`pathName cget option`
: Gibt den aktuellen Wert der durch `option` angegebenen Konfigurationsoption zurück, die einen der vom Befehl `scrollutil::pagesman` akzeptierten Werte annehmen kann.

`pathName configure ?option ?value option value ...??`
: Ruft die Konfigurationsoptionen des Widgets ab oder ändert sie.  Wenn kein `option` angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für `pathName` beschreibt (Informationen zum Format dieser Liste finden Sie unter `Tk_ConfigureInfo`).  Wenn `option` ohne `value` festgelegt wird, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des Werts, der zurückgegeben wird, wenn kein `option` angegeben wurde).  Wenn ein oder mehrere Paare `option`–`value` festgelegt werden, ändert der Befehl die festgelegten Widget-Optionen so, dass sie die festgelegten Werte annehmen; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück.  `option` kann jeden der vom Befehl `scrollutil::pagesman` akzeptierten Werte annehmen.

`pathName forget pageIndex`
: Hebt die Zuordnung und Verwaltung der durch `pageIndex` identifizierten Seite auf.  Der Unterbefehl gibt `0` zurück, wenn er durch den Befehl abgebrochen wurde, der als Wert der Option `-forgetcommand` festgelegt wurde, andernfalls `1`.

`pathName hasattrib name`
: Gibt `1` zurück, wenn das Attribut `name` vorhanden ist, andernfalls `0`.

`pathName haspageattrib pageIndex name`
: Gibt `1` zurück, wenn das Attribut `name` für die durch `pageIndex` angegebene Seite vorhanden ist, andernfalls `0`.

`pathName index window`
: Gibt den numerischen Index der Seite zurück, die durch das angegebene Fenster identifiziert wird. Dieses Fenster muss zuvor mithilfe des Unterbefehls `add` oder `insert` zum Widget hinzugefügt worden sein.

`pathName insert pageIndex window ?option value option value ...?`
: Fügt eine neue Seite ein, die aus dem angegebenen Fenster besteht, und zwar an der durch `pageIndex` angegebenen Position. Eine Liste der verfügbaren Optionen finden Sie im Abschnitt [SEITENKONFIGURATIONSOPTIONEN](#ausf-hrliche-referenz).  Wenn `window` bereits vom „pagesman“-Widget verwaltet wird, verschiebt der Unterbefehl es an die angegebene Position und verwendet seine optionalen Argumente, um die Optionen der entsprechenden Seite zu aktualisieren.  Wenn `pageIndex` kleiner oder gleich Null ist, wird das Fenster an den Anfang der Liste der Seiten eingefügt; wenn es größer oder gleich der Anzahl der Seiten ist, wird das Fenster an das Ende der Liste der Seiten angehängt.

`pathName pageattrib pageIndex ?name ?value name value ...??`
: Fragt die Attribute der durch `pageIndex` angegebenen Seite ab oder ändert sie. Wenn kein `name` gelegt ist, gibt der Befehl eine Liste von Paaren zurück, von denen jedes den Namen und den Wert eines Attributs der Seite enthält.  Wenn `name` ohne `value` festgelegt wird, gibt der Befehl den Wert des einen benannten Seitenattributs zurück oder eine leere Zeichenkette, falls kein entsprechender Wert vorhanden ist (Sie können den Unterbefehl `haspageattrib` verwenden, um diesen Fall von dem zu unterscheiden, bei dem der Wert eines *vorhandenen* Seitenattributs eine leere Zeichenkette ist).  Wenn ein oder mehrere Paare aus `name` und `value` angegeben werden, legt der Befehl das/die angegebene(n) Seitenattribut(e) auf den/die angegebenen Wert(e) fest; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück.  Jedes `name` kann eine beliebige Zeichenkette sein.

`pathName pagecget pageIndex option`
: Gibt den aktuellen Wert der durch `option` angegebenen Seitenkonfigurationsoption für die durch `pageIndex` angegebene Seite zurück.  `option` kann einen beliebigen Wert annehmen, der vom Befehl `pageconfigure` akzeptiert wird.

`pathName pageconfigure pageIndex ?option ?value option value ...??`
: Ruft die Konfigurationsoptionen der durch `pageIndex` angegebenen Seite ab oder ändert diese.  Wenn kein `option` angegeben ist, gibt der Befehl eine Liste zurück, die alle für die Seite verfügbaren Optionen beschreibt (Informationen zum Format dieser Liste finden Sie unter `Tk_ConfigureInfo`).  Wenn `option` ohne `value` festgelegt wird, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste entspricht der entsprechenden Unterliste des Werts, der zurückgegeben wird, wenn kein `option` festgelegt wurde).  Wenn ein oder mehrere Paare aus `option` und `value` festgelegt werden, ändert der Befehl die festgelegten Seitenoptionen so, dass sie die festgelegten Werte annehmen; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück.  `option` kann einen beliebigen der im Abschnitt [SEITENKONFIGURATIONSOPTIONEN](#ausf-hrliche-referenz) beschriebenen Werte annehmen.

`pathName pages`
: Gibt die Liste aller vom „pagesman“-Widget verwalteten Fenster in der Reihenfolge ihrer numerischen Seitenindizes zurück.

`pathName select ?pageIndex?`
: Wenn `pageIndex` weggelassen wird, gibt der Unterbefehl den Pfadnamen des aktuell ausgewählten Fensters zurück. Andernfalls wählt er die angegebene Seite aus, indem er das entsprechende Fenster zuordnet und die Zuordnung des zuvor ausgewählten Fensters (sofern es sich um ein anderes handelt) aufhebt.  In diesem Fall gibt der Befehl, der als Wert der Option `-leavecommand` angegeben wurde, den Wert `0` zurück, wenn der Vorgang der Auswahl eines anderen Fensters abgebrochen wurde, und andernfalls den Wert `1`.

`pathName size`
: Gibt die Anzahl der Seiten zurück, d. h. die Anzahl der Fenster, die vom „pagesman“-Widget verwaltet werden.

`pathName unsetattrib name`
: Hebt das Attribut `name` auf. Gibt eine leere Zeichenfolge zurück.

`pathName unsetpageattrib pageIndex name`
: Hebt das Attribut `name` für die durch `pageIndex` angegebene Seite auf. Gibt eine leere Zeichenkette zurück.

`pathName window pageIndex`
: Gibt den Pfadnamen des Seitenfensters zurück, das durch `pageIndex` identifiziert wird.


**VIRTUELLE EREIGNISSE**
: Nachdem eine neue Seite ausgewählt wurde, generiert das Widget ein virtuelles Ereignis mit der Bezeichnung `<<PagesmanPageChanged>>`.

**VORGABEBINDUNGEN**
: Wenn ein neues „pagesman“-Widget erstellt wird, verfügt es über keine Standard-Ereignis-Bindungen: „pagesman“-Widgets sind nicht dafür vorgesehen, interaktiv zu sein.

**SCHLÜSSELWÖRTER**
: pagesman, pages manager, widget


[Inhalt](#inhalt)     [Startseite](index.md)
