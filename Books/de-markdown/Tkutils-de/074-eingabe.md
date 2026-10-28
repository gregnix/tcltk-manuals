# Eingabe

Formulare, einzelne beschriftete Felder und die spezialisierten
Eingaben für Datum, Uhrzeit, Zahl und Schlagwörter. Die Prüfung hängt
an `tclutils::tuvalidate`. Alle Module dieses Kapitels liegen im
Umbrella.

---

## Formular: tkuform

[tkuform]{.index} 0.1 baut aus einer Liste von Feld-Dicts ein Formular
und liest die Werte als Dict. `tkudialog::form` nutzt dasselbe Modul.
Der Dialog steht im Kapitel [Dialoge](030-dialoge.md).

Ein Feld braucht `name`. Dazu `label`, `type`, `default`, `values` bei
`combo`, `state` bei `combo` (`normal` oder `readonly`), `from` und
`to` bei `spin`, `height` bei `text`. Der Typ ist `entry`, `password`,
`check`, `combo`, `spin` oder `text`, Vorgabe `entry`.

```tcl
set w [::tkutils::tkuform::widget .w $felder ?-padding 8? ?-columns 1?]
::tkutils::tkuform::values    $w
::tkutils::tkuform::get       $w name
::tkutils::tkuform::setField  $w name wert
::tkutils::tkuform::setValues $w dict
::tkutils::tkuform::fieldNames $w
::tkutils::tkuform::widgetOf  $w name
```

`values` liefert ein Dict von Name zu Wert. `setValues` übergeht
unbekannte Schlüssel. `setField` heißt so, damit `set` frei bleibt.
`-columns` legt mehrere Paare aus Beschriftung und Feld nebeneinander.
Ein Feld vom Typ `text` nimmt immer eine eigene Zeile über die volle
Breite.

| Code | Anlass |
|---|---|
| `{TKUTILS TKUFORM OPTION}` | unbekannte Widget-Option |
| `{TKUTILS TKUFORM VALUE}` | `-columns` unbrauchbar |
| `{TKUTILS TKUFORM SPEC}` | Feld ohne `name` |
| `{TKUTILS TKUFORM TYPE}` | unbekannter Feldtyp |

---

## Eine Zeile: tkulabeled

[tkulabeled]{.index} 0.1 ist eine Zeile aus Beschriftung und Steuerelement,
wenn ein ganzes Formular zu viel ist. Der Typ ist ein Wert: `entry`,
`combo`, `spin`, `check` oder `text`.

```tcl
::tkutils::tkulabeled::add $pfad $typ \
    ?-label text? ?-labelwidth n? ?-orient horizontal|vertical? ?weitere Optionen?
::tkutils::tkulabeled::value       $pfad ?neu?
::tkutils::tkulabeled::control     $pfad
::tkutils::tkulabeled::labelwidget $pfad
```

Ein Argument liest den Wert, zwei setzen ihn. Optionen außer `-label`,
`-labelwidth` und `-orient` gehen an das innere Steuerelement.

---

## Prüfung: tkuvalidate

[tkuvalidate]{.index} 0.1 hängt eine Prüfung an Entry, Combo oder
Spinbox. Ein ungültiger Wert färbt den Text rot, setzt den ttk-Zustand
`invalid` und zeigt den Grund über `tkuballoon`.

```tcl
::tkutils::tkuvalidate::attach $w $prüfer \
    ?-message text? ?-when focusout|key|both? ?-allowempty 0|1? \
    ?-onvalid befehl? ?-oninvalid befehl?
::tkutils::tkuvalidate::check    $w
::tkutils::tkuvalidate::valid    $w
::tkutils::tkuvalidate::clear    $w
::tkutils::tkuvalidate::allValid {w ...}
```

`$prüfer` ist ein Name aus `tclutils::tuvalidate` (`email`, `url`,
`ipv4`, `port`, `alpha`, `alnum`, `numeric`, `integer`) oder ein
Befehlspräfix. Der Wert des Feldes wird angehängt. Der Präfix liefert
einen Wahrheitswert. `check` und `allValid` liefern `0` oder `1`.
`clear` nimmt Markierung und Bindung weg.

---

## Datum: tkudateentry

[tkudateentry]{.index} 0.1 ist ein Feld plus ein Monatskalender zum
Aufklappen. Der Montag steht vorn. `getDate` liefert immer
`jjjj-mm-tt` oder `""`, wenn das Feld leer oder ungültig ist. Die
Anzeige folgt `-dateformat`.

```tcl
set w [::tkutils::tkudateentry::widget .d \
    ?-dateformat fmt? ?-width n? ?-textvariable var? ?-command befehl?]
::tkutils::tkudateentry::getText $w
::tkutils::tkudateentry::getDate $w
::tkutils::tkudateentry::setDate $w iso
::tkutils::tkudateentry::today   $w
::tkutils::tkudateentry::clear   $w
```

`-command` bekommt das ISO-Datum, beim Löschen den leeren String.
`setDate` mit einem Text, der kein ISO-Datum ist, wirft
`{TKUTILS TKDATEENTRY DATE}`. Ein leeres `setDate` leert das Feld.

Der Monat zum Anklicken ohne Eingabezeile ist `tkucalendar` im Kapitel
[Kalender und Notizen](076-kalender-und-notizen.md).

---

## Uhrzeit: tkutimeentry

[tkutimeentry]{.index} 0.1 zeigt Stunde und Minute als Spinbox, mit
`-seconds` auch die Sekunde. `getTime` und `setTime` nutzen `HH:MM`
oder `HH:MM:SS`.

```tcl
set w [::tkutils::tkutimeentry::widget .t \
    ?-time HH:MM? ?-increment min? ?-seconds 0|1? ?-command befehl?]
::tkutils::tkutimeentry::getTime $w
::tkutils::tkutimeentry::setTime $w 09:30
```

`-increment` ist der Minutenschritt, Vorgabe 5. `-command` bekommt die
Zeit bei jeder Änderung. Ein unbrauchbares `setTime` wirft
`{TKUTILS TKTIMEENTRY TIME}`.

---

## Zahl: tkunumentry

[tkunumentry]{.index} 0.1 lässt nur eine Zahl mit höchstens `-decimals`
Nachkommastellen tippen. Klemmen und Neuformatieren laufen beim
Commit, also Return oder Fokusverlust.

```tcl
set w [::tkutils::tkunumentry::widget .n \
    ?-decimals n? ?-min v? ?-max v? ?-textvariable var? ?-width n? ?-command befehl?]
::tkutils::tkunumentry::getValue $w
::tkutils::tkunumentry::setValue $w 3.14
::tkutils::tkunumentry::clear    $w
```

`getValue` liefert die Zahl oder `""`, wenn das Feld leer ist.
`setValue` mit einem Text, der keine Zahl ist, wirft
`{TKUTILS TKNUMENTRY VALUE}`. `-command` bekommt den Wert beim Commit.

---

## Schlagwörter: tkutags

[tkutags]{.index} 0.1 zeigt Schlagwörter als entfernbare Plättchen.
Return oder „+" fügt eines hinzu. Doppelte und leere entfallen. Mit
`-readonly` fehlen Eingabe und Entfernen-Knopf. `-suggestions` macht
aus dem Feld eine Combobox.

```tcl
set w [::tkutils::tkutags::widget .t \
    ?-tags liste? ?-suggestions liste? ?-textvariable var? ?-readonly 0|1? ?-command befehl?]
::tkutils::tkutags::getTags   $w
::tkutils::tkutags::setTags   $w liste
::tkutils::tkutags::addTag    $w tag
::tkutils::tkutags::removeTag $w tag
::tkutils::tkutags::clear     $w
```

`-textvariable` spiegelt die Liste. Ist `-tags` leer, setzt die
Variable den Anfang. `-command` bekommt die Liste bei jeder Änderung.

---

## Merkliste

- `tkuform::values` ist ein Dict. `setField` setzt ein Feld.
- `tkuvalidate` nimmt die Namen aus `tclutils::tuvalidate` oder einen eigenen Befehl.
- `tkudateentry::getDate` ist ISO, die Anzeige folgt `-dateformat`.
- `tkunumentry` formatiert beim Commit, nicht bei jedem Tastendruck.

---

*Nächstes Kapitel: [Kalender und Notizen](076-kalender-und-notizen.md)*
