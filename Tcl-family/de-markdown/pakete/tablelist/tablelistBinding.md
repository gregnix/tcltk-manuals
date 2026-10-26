# Befehle im Zusammenhang mit Bindungsskripten

## Für Tablelist Version 7.12

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Der Befehl tablelist::convEventFields](#der-befehl-tablelist-conveventfields)
- [Der Befehl tablelist::getTablelistPath](#der-befehl-tablelist-gettablelistpath)
- [Der Befehl tablelist::getTablelistColumn](#der-befehl-tablelist-gettablelistcolumn)
- [Der Befehl tablelist::delaySashPosUpdates](#der-befehl-tablelist-delaysashposupdates)

[Startseite](index.md)

---

## Überblick

Die ersten drei in dieser Referenzseite beschriebenen Befehle sind für die Verwendung in Bindungs-Skripten vorgesehen, die mit den Bindungs-Tags verknüpft sind, deren Namen von den Unterbefehlen `bodytag` und `labeltag` des Tcl-Befehls gegeben werden, der einem Tablelist-Widget zugeordnet ist.  Die ersten beiden dieser Befehle werden auch in den Standard-Skripten für die VORGABEBINDUNGEN verwendet, die mit dem Bindungs-Tag `TablelistBody` verknüpft sind.  Einzelheiten und Beispiele finden Sie in den Abschnitten [VORGABEBINDUNGEN UND INDIVIDUELLE BINDUNGEN FÜR DEN TABLELIST-KÖRPER] (](tablelistWidget.md#ausf-hrliche-referenz)) und [VORGABEBINDUNGEN UND INDIVIDUELLE BINDUNGEN FÜR DIE KOPFZEILENBEZEICHNUNGEN] (](tablelistWidget.md#ausf-hrliche-referenz)).

Der letzte Befehl bezieht sich auf die Standard-BINDINGS für die Tk-Core-Widgets „panedwindow“ und „ttk::panedwindow“.  Er kann verwendet werden, um die Häufigkeit der Aktualisierungen der Sash-Position zu steuern, was erforderlich sein kann, um bestimmte Artefakte zu beseitigen, die beim Verschieben eines Sash entstehen, wenn ein oder mehrere der Fensterbereiche ein „Tablelist“-Widget mit EINGEBETTETEN BILDERN enthalten.

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::convEventFields`

**NAME**
: `tablelist::convEventFields` – EREIGNISFELDER relativ zu einem untergeordneten Element eines „Tablelist“-Widgets konvertieren

**ÜBERSICHT**
: 

```
tablelist::convEventFields descendantPathName x y
```

**BESCHREIBUNG**
: Dieser Befehl / Der Befehl ermittelt den Pfadnamen eines Tablelist-Widgets sowie die x- und y-Koordinaten relativ zu diesem Widget anhand des Pfadnamens `descendantPathName` eines seiner Nachkommen und anhand der x- und y-Koordinaten `x`, `y`, die relativ zu diesem untergeordneten Element sind. Der Befehl gibt diese Werte als Komponenten einer Liste zurück, die aus drei Elementen besteht.

: In einem Bindungsskript entspricht das untergeordnete Widget dem EREIGNISFELD `%W`. Dabei kann es sich um den Hauptteil der Tablelist, einen der Trennrahmen, ein Label-Widget, das ein eingebettetes Bild anzeigt, oder um (ein untergeordnetes Element) eines eingebetteten Fensters handeln.  Es kann sich auch um ein Kopfzeilen-Label oder einen in ein Kopfzeilen-Label eingebetteten Tk-Core- oder Tile-Checkbutton oder um einen Sortierpfeil handeln.  Ebenso entsprechen die Argumente `x` und `y` den EREIGNISFELDERN `%x` und `%y`.  Die drei Elemente der von dem Befehl gegebenen Liste werden üblicherweise den Hilfevariablen `tablelist::W`, `tablelist::x` und `tablelist::y` zugewiesen, und zwar mithilfe der Anweisung

```
foreach {tablelist::W tablelist::x tablelist::y} \
    [tablelist::convEventFields %W %x %y] {}
```

**SCHLÜSSELWÖRTER**
: tablelist, event fields, binding script


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::getTablelistPath`

**NAME**
: `tablelist::getTablelistPath` – Den Pfadnamen eines „Tablelist“-Widgets anhand des Pfadnamens eines seiner untergeordneten Elemente ermitteln

**ÜBERSICHT**
: 

```
tablelist::getTablelistPath descendantPathName
```

**BESCHREIBUNG**
: Dieser Befehl ruft den Pfadnamen eines Tablelist-Widgets anhand des Pfadnamens `descendantPathName` eines seiner untergeordneten Elemente ab.

: In einem Bindungsskript entspricht das untergeordnete Widget dem EREIGNISFELD `%W`, bei dem es sich um den Hauptteil der Tablelist, einen der Trennrahmen, ein Label-Widget mit eingebettetem Bild oder (ein untergeordnetes Element) eines eingebetteten Fensters handeln kann.  Es kann sich auch um eine Kopfzeilenbeschriftung oder einen in eine Kopfzeilenbeschriftung eingebetteten Tk-Core- oder Tile-Checkbutton oder um einen Sortierpfeil handeln. Der Wert wird häufig der Hilfevariablen `tablelist::W` zugewiesen.

**SCHLÜSSELWÖRTER**
: tablelist, path name, binding script


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::getTablelistColumn`

**NAME**
: `tablelist::getTablelistColumn` – Die Spaltennummer aus dem Pfadnamen einer Tablelist-Kopfzeile ermitteln

**ÜBERSICHT**
: 

```
tablelist::getTablelistColumn headerLabelPathName
```

**BESCHREIBUNG**
: Dieser Befehl ermittelt die Spaltennummer anhand des Pfadnamens `headerLabelPathName` einer Tablelist-Kopfzeile, eines in eine Kopfzeile eingebetteten Tk-Core- oder Tile-Checkbuttons oder eines Sortierpfeils.  Gibt bei Erfolg die Spaltennummer und bei Fehlschlag den Wert `-1` zurück.

: In einem Bindungsskript entspricht das Argument dem EREIGNISFELD `%W`. Der Rückgabewert wird häufig der Hilfsvariablen `tablelist::col` zugewiesen.

**SCHLÜSSELWÖRTER**
: tablelist, path name, binding script


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::delaySashPosUpdates`

**NAME**
: `tablelist::delaySashPosUpdates` – Verzögerung für die Aktualisierung der Sash-Position bei Fenstern mit geteilten Sashn festlegen

**ÜBERSICHT**
: 

```
tablelist::delaySashPosUpdates panedwindowPathName ms
```

**BESCHREIBUNG**
: Dieser Befehl legt eine Verzögerung für die Aktualisierungen der Sash-Position fest, die durch das Ziehen eines Sash des durch das erste Argument angegebenen „panedwindow“-Widgets verursacht werden. Das erste Argument muss der Pfadname eines Tk-Core-„panedwindow“-Widgets oder eines ttk::panedwindow-Widgets sein.  `ms` muss eine Ganzzahl sein, die die Verzögerung in Millisekunden angibt.  Wenn diese Zahl nicht negativ ist, wird die Aktualisierung der Sash-Position über  `sash place ...`  (für ein panedwindow-Widget des Tk-Kerns) oder  `sashpos ...`  (bei einem ttk::panedwindow-Widget) `ms` Millisekunden später so eingeplant, dass bis zum Ablauf der Zeit für eine bereits eingeplante Aktualisierung neue Zieh-Ereignisse keine neuen Aktualisierungsvorgänge einplanen (lediglich deren Daten werden gespeichert).  Dadurch wird die Häufigkeit der Aktualisierungen der Sash-Position, die durch das Ziehen eines Sash des angegebenen Widgets verursacht werden, je nach dem Wert von `ms` verringert.  Ist diese Zahl negativ, löst jedes Ziehen eines Sash des angegebenen Widgets sofort eine Aktualisierung der Sash-Position aus, wie es in den Standard-Skripten für die Tk-Kern-Widgets panedwindow und ttk::panedwindow implementiert ist.

: Mit diesem Befehl lässt sich die Häufigkeit der Aktualisierungen der Sash-Position für ein bestimmtes „panedwindow“-Widget steuern. Dies kann erforderlich sein, um bestimmte Artefakte zu beseitigen, die beim Ziehen eines Sashs entstehen, wenn ein oder mehrere der Fensterbereiche ein „tablelist“-Widget mit EINGEBETTETEN BILDERN enthalten.  Der Wert `ms` (in der Regel eine Zahl zwischen 10 und 100) ist anwendungs- und plattformspezifisch (unter Windows und Mac OS X/11+ ist ein höherer Wert erforderlich als unter X11).

**SCHLÜSSELWÖRTER**
: panedwindow, tablelist, path name, binding script


[Inhalt](#inhalt)     [Startseite](index.md)
