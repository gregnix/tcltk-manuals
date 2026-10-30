# Dialoge

## tkudialog 0.3

[tkudialog]{.index} ersetzt `tk_messageBox`-Muster mit ttk. Der Meldungstext
ist markierbar und kopierbar (Strg-C oder Knopf *Copy*). Dazu kommen
Default-Button, Return/Escape, Fokus/Grab und Button-Ids. Reines Tk, keine
tclutils-Engine.

```tcl
package require tkutils::tkudialog 0.3
set ok [::tkutils::tkudialog::confirm "Datei löschen?" -parent .]
if {$ok} { puts "wird gelöscht" }
```

`confirm` liefert **1** für *Ja*, sonst **0** — auch bei Escape oder
Fenster schließen.

---

## Alle Einstiege

| Aufruf | Art | Rückgabe |
|---|---|---|
| `showInfo msg ?opt?` | modal | `ok`; `""` bei Escape/Schließen |
| `showWarning msg ?opt?` | modal | wie `showInfo` |
| `showError msg ?opt?` | modal | wie `showInfo`; `-detail` startet eingeklappt |
| `confirm msg ?opt?` | modal | 1 (Ja) oder 0 |
| `input ?opt?` | modal | eingegebener Text; `""` bei Abbruch oder leerer Eingabe |
| `form spec ?-title? ?-parent?` | modal | Werte-Dict; `""` bei Abbruch |
| `show win ?opt?` | modal | Id des gewählten Knopfs |
| `build win ?opt?` | nicht modal | `win` |
| `choose win id` | Knopf programmatisch wählen | leer |
| `result win` | Status | gewählte Id, `""` solange offen |
| `getText win` | Status | Meldungstext |
| `getDetail win` | Status | Detailtext |
| `copyText win` | Zwischenablage | kopierter Text (Meldung + Detail) |

Alle Befehle liegen in `::tkutils::tkudialog`. Ein `message` oder `warning`
gibt es nicht.

Optionen von `build`/`show` (und damit der fertigen Varianten): `-title`,
`-message`, `-icon info|warning|error|question`, `-detail`, `-buttons`,
`-default`, `-cancel`, `-entry`, `-initial`, `-parent`,
`-detailcollapsed`, `-width` (Standard 48), `-maxheight` (Standard 20).
`input` kennt nur `-title`, `-message`, `-initial`, `-parent`; `form` nur
`-title` und `-parent`. `input` liefert auch bei *OK* mit leerem Feld `""`
— Abbruch und leere Eingabe sind am Ergebnis nicht zu unterscheiden.

```tcl
package require tkutils::tkudialog 0.3
::tkutils::tkudialog::showInfo "Export fertig." -parent .
::tkutils::tkudialog::showError "Speichern fehlgeschlagen." \
    -detail "permission denied" -parent .

set name [::tkutils::tkudialog::input -title "Neuer Ordner" \
    -message "Name:" -initial "Neu" -parent .]
if {$name ne ""} { puts "anlegen: $name" }
```

---

## Knöpfe mit Ids

`-buttons` nimmt Einträge `Label` (Id gleich Label, wie in 0.2) oder
`{id Label}`. `show` gibt die **Id** zurück, unabhängig von der
Beschriftung — so bleibt der Code gleich, wenn [msgcat]{.index} die Labels
übersetzt.

```tcl
package require tkutils::tkudialog 0.3
set id [::tkutils::tkudialog::show .frage -title "Ungespeichert" \
    -icon question -message "Änderungen speichern?" \
    -buttons {{save Speichern} {discard Verwerfen} {cancel Abbrechen}} \
    -default save -cancel cancel -parent .]
switch -- $id {
    save    { puts speichern }
    discard { puts verwerfen }
    default { puts abbruch }
}
```

- Return / KP_Enter wählt `-default` (ohne Angabe den ersten Knopf).
- Escape und Fenster schließen wählen `-cancel`. Ohne Angabe gilt der
  erste Knopf mit der Id `No`, `Cancel`, `no` oder `cancel` oder mit dem
  Label `No` oder `Cancel`; gibt es keinen, ist das Ergebnis `""`.
- `confirm`, `input` und `form` benutzen feste Ids (`yes`/`no`,
  `ok`/`cancel`).
- Titel und Standardlabels (`OK`, `Yes`, `Copy`, …) laufen über `msgcat`,
  wenn es geladen ist.
- Modale Dialoge stellen Fokus und Grab des Aufrufers wieder her.

---

## Formular

`form` bettet ein `tkuform` mit OK/Abbrechen in einen modalen Dialog.

```tcl
package require tkutils::tkudialog 0.3
set v [::tkutils::tkudialog::form {
    {name titel  label "Titel"    type entry}
    {name prio   label "Prio"     type combo values {niedrig normal hoch} default normal}
    {name fertig label "Erledigt" type check}
} -title "Neue Notiz" -parent .]
if {$v ne ""} { puts "prio=[dict get $v prio]" }
```

---

## Nicht modal

`build` baut den Dialog und kehrt sofort zurück. Den Rest verdrahten Sie
selbst.

```tcl
package require tkutils::tkudialog 0.3
::tkutils::tkudialog::build .info -title "Protokoll" \
    -message "Lauf beendet." -detail "3 Dateien kopiert" \
    -buttons {{ok OK}} -default ok
puts [::tkutils::tkudialog::getDetail .info]   ;# -> 3 Dateien kopiert
::tkutils::tkudialog::copyText .info
::tkutils::tkudialog::choose .info ok
puts [::tkutils::tkudialog::result .info]      ;# -> ok
destroy .info
```

---

## Parent und Platzierung

`-parent w` macht den Dialog transient zum Toplevel von `w` und zentriert
ihn darüber. Ohne `-parent` gilt das Toplevel mit dem Tastaturfokus, sonst
`.`. Geben Sie `-parent` an, wann immer das Fenster bekannt ist — bei
mehreren Monitoren ist es die einzige verlässliche Antwort. Ein `-parent`,
das es nicht gibt, ist ein Fehler `{TKUTILS TKUDIALOG PARENT <w>}` mit der
Meldung `bad window path name ".nix" given as -parent` (für `-parent
.nix`). Ein Parent, der noch nicht sichtbar ist, macht den Dialog nicht
transient; er wird dann auf dem Bildschirm zentriert.

---

## Optionen werden geprüft

Eine unbekannte Option ist ein Fehler mit der Liste der bekannten:

```tcl
package require tkutils::tkudialog 0.3
catch {::tkutils::tkudialog::showInfo "x" -parnet .} msg opts
puts [dict get $opts -errorcode]   ;# -> TKUTILS TKUDIALOG OPTION -parnet
```

Die Meldung lautet `unknown option "-parnet"`, in der zweiten Zeile
`Known:` mit den gültigen Optionen in der Reihenfolge des Codes
(`-title -message -icon -detail -buttons -entry -initial -parent -default
-cancel -detailcollapsed -width -maxheight`). Fehlt ein Wert, lautet sie
`missing value for option "…"` mit dem Code `{TKUTILS TKUDIALOG OPTION}`.

---

## Versionen

Die Datei **0.2** ist entfernt; `package require tkutils::tkudialog 0.2`
lädt 0.3 (kompatibel für einfache Labels). Doc: `docs/tkudialog.md`.

---

## ctrlutils

`cufileops` verlangt seit 0.3 `tkudialog` 0.3 für Bestätigungen; der
aktuelle Stand in ctrlutils 0.5 ist `cufileops` 0.6. Siehe *Utils-Stack*.

---

## Zusammenfassung

- Einstiege: `showInfo`, `showWarning`, `showError`, `confirm`, `input`,
  `form`, `build`/`show`, dazu `choose`, `result`, `getText`,
  `getDetail`, `copyText`.
- `confirm` → 1/0, `show` → Id, `input`/`form` → `""` bei Abbruch.
- Immer `-parent` angeben.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 und 9.0.4 unter Linux und Xvfb: alle
Beispiele; die modalen Dialoge wurden dabei per `choose` geschlossen.

**Nicht getestet:** Darstellung, Fokus und Platzierung auf einem echten
Bildschirm.
:::

---

*Nächstes Kapitel: [Datei-Widgets](040-datei-widgets.md)*
