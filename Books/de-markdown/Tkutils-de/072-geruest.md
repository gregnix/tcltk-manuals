# Gerüst

Aktionen und der Launcher stehen im Kapitel
[Aktionen und Layout](070-aktionen-und-layout.md). Hier liegen die
Leisten, Reiter, Hinweise und die kleinen Helfer um Fokus, Rad und
Auswahlrahmen. Die Module gehören zum Umbrella, außer
`tkuscrolledframe`.

---

## Leiste: tkutoolbar

[tkutoolbar]{.index} 0.2 baut eine Leiste aus Knöpfen, Schaltern,
Aufklappmenüs, Trennern und eingebetteten Widgets. Jedes Stück hat eine
Id.

```tcl
set tb [::tkutils::tkutoolbar::widget .tb \
    ?-orient horizontal|vertical? ?-displaymode icon|text|both? \
    ?-spacing px? ?-padding px? ?-buttonstyle flat|raised?]
::tkutils::tkutoolbar::addButton   $tb id label befehl ?-icon bild? ?-tooltip text? ?-shortcut taste?
::tkutils::tkutoolbar::addToggle   $tb id label varname ?-onvalue v? ?-offvalue v?
::tkutils::tkutoolbar::addDropdown $tb id label ?-menu {{label befehl} ...}?
::tkutils::tkutoolbar::addSeparator $tb
::tkutils::tkutoolbar::addWidget    $tb id kind ?seite?
```

`-buttonstyle` ist `flat`. `raised` gibt Knöpfen einen Rand. Schalter
bleiben flach. `-shortcut` bindet auf das Toplevel und fällt weg, wenn
die Leiste zerstört wird. Hinweise gehen über `tkuballoon`. Ohne Icon
zeigt der Modus `icon` den Text.

```tcl
::tkutils::tkutoolbar::setEnabled     $tb id 0|1
::tkutils::tkutoolbar::setDisplayMode $tb icon|text|both
::tkutils::tkutoolbar::buttonWidget   $tb id
::tkutils::tkutoolbar::items          $tb
```

Fehler `{TKUTILS TKUTOOLBAR <GRUND>}`: `OPTION`, `ORIENT`,
`DISPLAYMODE`, `BUTTONSTYLE`, `NOITEM`, `NOTOOLBAR`.

---

## Status: tkustatus

[tkustatus]{.index} 0.2 hat eine Hauptzeile, benannte Felder und einen
Balken. Die Zugriffe heißen `setText` und `getText`, damit `set` frei
bleibt.

```tcl
set st [::tkutils::tkustatus::widget .st]
::tkutils::tkustatus::setText   $st text
::tkutils::tkustatus::getText   $st
::tkutils::tkustatus::addField  $st id ?-width n?
::tkutils::tkustatus::setField  $st id text
::tkutils::tkustatus::fieldText $st id
::tkutils::tkustatus::progress  $st ?0..100?
::tkutils::tkustatus::flash     $st text ?ms?
```

`progress` ohne Wert oder mit leerem Wert blendet den Balken aus.
`flash` zeigt den Text und stellt danach die vorige Zeile wieder her.

---

## Reiter: tkutab

[tkutab]{.index} 0.2 ist ein `ttk::notebook` mit einem Knopf „+" und
schließbaren Reitern. `add` liefert den Rahmen des neuen Reiters.
`current` liefert den Rahmen des aktiven, `tabs` die Rahmen in
Reihenfolge, `count` die Zahl.

| Option | Wirkung |
|---|---|
| `-onnew` | Skript beim „+" |
| `-onclose` | Skript, der schließende Rahmen wird angehängt |
| `-onselect` | Skript, der gewählte Rahmen wird angehängt |

Schließen geht über `close` und über den mittleren Mausknopf.

---

## Baum: tkutree

[tkutree]{.index} 0.2 ist ein dünner `ttk::treeview`. `tkufiletree` sitzt
darauf. Das Dateifenster steht im Kapitel
[Datei-Widgets](040-datei-widgets.md).

```tcl
set w [::tkutils::tkutree::widget .tr ?-columns ids? ?-headings texte? \
    ?-show spec? ?-height n? ?-command befehl?]
::tkutils::tkutree::insert   $w eltern text ?-values liste? ?-open 0|1? ?-id id?
::tkutils::tkutree::loadTree $w knoten
::tkutils::tkutree::selection $w
::tkutils::tkutree::itemText  $w id
::tkutils::tkutree::children  $w ?id?
::tkutils::tkutree::treeview  $w
```

---

## Hinweis: tkuballoon

[tkuballoon]{.index} 0.1 hängt einen Hinweis an ein beliebiges Widget.

```tcl
::tkutils::tkuballoon::add       $w text ?-delay ms? ?-wraplength px?
::tkutils::tkuballoon::clear     $w
::tkutils::tkuballoon::configure ?-delay ms? ?-wraplength px?
::tkutils::tkuballoon::cget      option
::tkutils::tkuballoon::enable
::tkutils::tkuballoon::disable
```

Die Vorgabe ist 600 ms und 320 Pixel Umbruch. `disable` schaltet alle
Hinweise ab und blendet einen offenen aus.

---

## Kontextmenü: tkucontextmenu

[tkucontextmenu]{.index} 0.1 baut Menüs und bindet sie an den
Kontextknopf der Plattform: Knopf 3 unter X11 und Windows, Knopf 2 und
Control-Klick unter macOS.

```tcl
set m [::tkutils::tkucontextmenu::create .m ?-tearoff 0|1? ?-dynamic 0|1?]
::tkutils::tkucontextmenu::addItem     $m label ?-command befehl? ?-accelerator text?
::tkutils::tkucontextmenu::addCheckItem $m label ?-variable v?
::tkutils::tkucontextmenu::addRadioItem $m label -variable v -value wert
::tkutils::tkucontextmenu::addSeparator $m
::tkutils::tkucontextmenu::addSubmenu   $m label $unter
::tkutils::tkucontextmenu::attach       $m $w ?-button 2|3?
::tkutils::tkucontextmenu::show         $m x y
```

`enable` und `disable` treffen einen Eintrag über sein Label.
`createStandardEdit` legt die üblichen Bearbeiten-Einträge an.
`createFromSpec` nimmt eine Liste von Einträgen.

---

## Tasten: tkubind

[tkubind]{.index} 0.1 schreibt `Mod` als Control unter X11 und Windows
und als Command unter macOS. Globale Kürzel bleiben stehen, solange ein
Eingabefeld, ein Text oder eine Tablelist den Fokus hat.

```tcl
set id [::tkutils::tkubind::key "Mod-s" {speichern} ?-toplevel .? ?-id name?]
::tkutils::tkubind::unbind $id
::tkutils::tkubind::accelerator "Mod-Shift-p"
::tkutils::tkubind::isEditing
::tkutils::tkubind::platform ?schlüssel?
::tkutils::tkubind::context     $w {menü %X %Y}
::tkutils::tkubind::doubleClick $w {öffnen %W}
```

`accelerator` liefert unter X11 und Windows `Ctrl+Shift+P`, unter macOS
`@^P`. Gruppen schalten mehrere Kürzel gemeinsam:

```tcl
::tkutils::tkubind::group define editKeys {{Mod-b {fett}} {Mod-i {kursiv}}}
::tkutils::tkubind::group enable  editKeys ?-toplevel .?
::tkutils::tkubind::group enabled editKeys
```

`clear` löst alle Bindungen und Gruppen.

---

## Fokus: tkukeynav

[tkukeynav]{.index} 0.1 bewegt den Fokus und bindet Return und Escape.

```tcl
::tkutils::tkukeynav::next $w
::tkutils::tkukeynav::prev $w
::tkutils::tkukeynav::enable $w ?-onreturn befehl? ?-onescape befehl? ?-tab 0|1?
::tkutils::tkukeynav::disable $w
::tkutils::tkukeynav::form $rahmen ?-onsubmit befehl? ?-wrap 0|1? ?-onescape befehl?
```

`next` und `prev` liefern das Widget, das den Fokus bekommt. `form`
bindet die Eingabefelder im Rahmen.

---

## Suche und Filter

[tkusearchbar]{.index} 0.1 ist ein Feld mit Löschen-Knopf und optionaler
Filterliste. Tippen ruft `-command` nach `-delay` Millisekunden Ruhe.
Vorgabe 300, Breite 28. Löschen und ein Filterwechsel feuern sofort.
`setText` setzt den Text und feuert nicht.

```tcl
set s [::tkutils::tkusearchbar::widget .s ?-command befehl? ?-delay ms? ?-filters liste?]
::tkutils::tkusearchbar::getText $s
::tkutils::tkusearchbar::clear   $s
::tkutils::tkusearchbar::getFilter $s
```

[tkufilterbar]{.index} 0.2 legt je Spalte ein Feld an. `-command`
bekommt ein Dict der nicht leeren Felder. Vorgabe der Pause 300 ms,
Feldbreite 10. `setFilter` feuert nicht, `clear` schon.

```tcl
set f [::tkutils::tkufilterbar::widget .f ?-command befehl?]
::tkutils::tkufilterbar::setColumns $f {name ort}
::tkutils::tkufilterbar::getFilters $f
```

---

## Scrollen

[tkuscrolledframe]{.index} 0.1 braucht `scrollutil` aus tklib und steht
außerhalb des Umbrellas. `widget` liefert den Außenrahmen, `content`
den Rahmen zum Packen.

```tcl
set sf [::tkutils::tkuscrolledframe::widget .sf ?-width n? ?-height n?]
set innen [::tkutils::tkuscrolledframe::content $sf]
::tkutils::tkuscrolledframe::see $sf $kind ?ecke?
```

[tkuwheel]{.index} 0.2 leitet das Mausrad von einem Widget an ein
scrollbares Ziel.

```tcl
::tkutils::tkuwheel::redirect ziel $w ?-orient y|x|both? ?-amount n? ?-dynamic 0|1?
::tkutils::tkuwheel::unbind   $w ?-recursive 0|1?
```

`-dynamic 1` trifft auch Widgets, die später in `$w` entstehen.

---

## Rahmen aufziehen: tkumarquee

[tkumarquee]{.index} 0.1 zieht auf einer Zeichenfläche ein Rechteck.

```tcl
::tkutils::tkumarquee::enable  .c ?-onselect befehl? ?-onstart befehl? ?-button n?
::tkutils::tkumarquee::disable .c
::tkutils::tkumarquee::region  .c
::tkutils::tkumarquee::active  .c
```

`region` liefert `{x1 y1 x2 y2}` oder den leeren String. `active` ist
`1`, solange die Taste gehalten ist.

---

## Merkliste

- `tkutoolbar` spricht Widgets über Ids an. Hinweise kommen von `tkuballoon`.
- `tkustatus` heißt `setText`, nicht `set`.
- `tkutab::add` liefert den Inhaltsrahmen.
- `Mod` in `tkubind` ist Control oder Command, je nach Plattform.
- `tkuscrolledframe` braucht `scrollutil` und ein eigenes `package require`.

---

*Nächstes Kapitel: [Eingabe](074-eingabe.md)*
