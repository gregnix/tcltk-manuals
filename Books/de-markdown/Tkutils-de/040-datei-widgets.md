# Datei-Widgets

## Liste und Baum

| Widget | Rolle |
|---|---|
| `tkufilelist` 0.2 | Detailliste eines Verzeichnisses über Provider |
| `tkufiletree` 0.2 | Lazy-Baum; lokal oder mit `-provider` |
| `tkupath` 0.3 | Pfadzeile (Breadcrumb) |
| `tkupreview` 0.2 | Vorschau (Text, Markdown, Meldung, …) |

Die Widgets sprechen einen [Provider]{.index} aus `tclutils::tuprovider`,
nicht das feste Dateisystem. Ohne `-provider` legt `tkufilelist` selbst
einen lokalen an.

```tcl
package require tclutils::tuprovider
package require tkutils::tkufilelist

set prov [::tclutils::tuprovider open local]
::tkutils::tkufilelist::widget .l -provider $prov -dir [pwd] \
    -onactivate {apply {e {
        if {[dict get $e type] eq "dir"} {
            ::tkutils::tkufilelist::setDir .l [dict get $e path]
        }
    }}}
pack .l -fill both -expand 1
::tkutils::tkufilelist::setFilter .l *.txt
```

Callbacks bekommen den Eintrag des Providers als Dict mit `name`, `path`,
`type` (`file`/`dir`), `size` und `mtime`; `size` und `mtime` können leer
sein. Weitere Befehle: `dir`, `refresh`, `selectedEntry`,
`selectedEntries`. `tkufilelist` baut auf `tkutablelist` auf und braucht
deshalb Tablelist.

Optionen von `widget`: `-provider`, `-dir` (Standard `/`, nicht das
aktuelle Verzeichnis), `-files` (Standard 1), `-showhidden` (Standard 0),
`-filter`, `-onactivate` (Doppelklick oder Return), `-onselect`, `-height`
(Standard 16). `setFilter` nimmt **ein** Glob-Muster, ohne Beachtung der
Groß-/Kleinschreibung; Ordner bleiben immer sichtbar, damit die Navigation
möglich bleibt. Die Sortierung nach Kopfklick hält die Zuordnung Zeile →
Eintrag, weil der Eintrag als Zeilenattribut der Tablelist gespeichert
ist.

Controller (`cufileops`, Filter, Monitor) verdrahten Verhalten — Buch
*Utils-Stack*. ZIP/Remote: Caps des Providers steuern Schreibaktionen.

---

## tkufiletree

[tkufiletree]{.index} liest Unterverzeichnisse erst beim Aufklappen.
Optionen: `-root`, `-filter` (Glob-Liste, ohne Beachtung der
Groß-/Kleinschreibung), `-files`, `-showhidden`, `-provider`,
`-onactivate`, `-onselect`, `-height`, `-isolatekeys`.

```tcl
package require tkutils::tkufiletree
set t [::tkutils::tkufiletree::widget .t -root [pwd] -showhidden 1 \
    -filter {*.txt *.md} \
    -onactivate {apply {p {puts "öffnen: $p"}}}]
pack $t -fill both -expand 1
::tkutils::tkufiletree::reveal $t [file join [pwd] README.md]
```

Item-Ids sind die normalisierten vollen Pfade. `reveal` klappt bis zum
Ziel auf und liefert 1, wenn genau dieses Ziel gewählt wurde, sonst 0.
Weitere Befehle: `setRoot`, `root`, `up` (auch BackSpace), `refresh`,
`refreshDir`, `selectedPath`, `treeview`, `volumesRoot`.

### Versteckte Dateien unter Windows

Mit `-showhidden 1` liest der Baum `*` und `.*`. Unter Windows trifft `*`
die Punkt-Dateien bereits, sie kamen also doppelt, und das Treeview brach
mit `ITEM_EXISTS` ab. Seit 0.46.0 werden die Treffer vor dem Einfügen mit
`lsort -unique` entdoppelt (Test `tkufiletree-1.7`).

Ohne `-root` gilt das aktuelle Verzeichnis. `volumesRoot` liefert einen
Sonderwert für `-root`: einen virtuellen Knoten *This PC* mit allen
Laufwerken. `up` steigt an einer Laufwerkswurzel dorthin, wenn es mehr als
ein Laufwerk gibt.

---

## tkupath 0.3

[tkupath]{.index} zeigt einen Pfad als Reihe von Knöpfen. Ein Klick setzt
die Zeile auf diesen Teilpfad und ruft `-onnavigate` mit ihm auf. Die
Zeile berührt kein Dateisystem; sie trennt nur an `/`.

```tcl
package require tkutils::tkupath
::tkutils::tkupath::widget .bar -onnavigate {apply {p {puts "gehe: $p"}}}
pack .bar -fill x
::tkutils::tkupath::setPath .bar /srv/daten/docs
puts [::tkutils::tkupath::getPath .bar]   ;# -> /srv/daten/docs
```

Die Zeile hat sich schon umgestellt, bevor sie den Callback ruft. Der
Callback braucht deshalb kein `setPath`. Nur wenn die Navigation woanders
endet (Umleitung, Wechsel fehlgeschlagen), setzt er mit `setPath` den
echten Ort.

Optionen: `-onnavigate`, `-rootlabel` (Beschriftung der Wurzel `/`,
Standard `/`). Seit 0.3 erkennt die Zeile Laufwerks- und UNC-Pfade;
Backslashes gelten als `/`:

| Pfad | Segmente | Ziele |
|---|---|---|
| `/srv/daten/docs` | `/` `srv` `daten` `docs` | `/` `/srv` `/srv/daten` `/srv/daten/docs` |
| `S:/projekte/daten` | `S:` `projekte` `daten` | `S:/` `S:/projekte` `S:/projekte/daten` |
| `//srv/share/x` | `//srv/share` `x` | `//srv/share/` `//srv/share/x` |

Bis 0.2 stand vor jedem Ziel ein `/` (`/S:/projekte`); Windows liest das
als Pfad auf dem aktuellen Laufwerk. `S:\projekte\daten` ergibt dieselben
Segmente und Ziele wie `S:/projekte/daten`. Die Zerlegung ist reine
Zeichenkettenarbeit.

---

## tkupreview 0.2

`tkupreview` zeigt Inhalte an, die der Aufrufer liefert (`text`,
`markdown`, `message` und weitere Arten); welche Datei welche Art bekommt,
entscheidet die App. Seit 0.2 laufen die Meldungen, die das Widget selbst
schreibt (Vorschau nicht verfügbar, Datei nicht lesbar, Rendern
fehlgeschlagen), über `msgcat`, wenn es geladen ist. Übersetzungen legt die
App im Namensraum `::tkutils` ab:

```tcl
package require msgcat
namespace eval ::tkutils {
    ::msgcat::mcset {} "Image preview unavailable." "Bildvorschau nicht verfügbar."
}
```

Ohne Katalog bleiben die Texte englisch.

---

## tkufiledialog 0.2

[tkufiledialog]{.index} ist ein modaler Dialog auf `tkupath` +
`tkufilelist`, im Look des Explorer-Stacks. Lokaler Provider als Standard,
optional `-provider` für ZIP/Remote.

| Befehl | Rückgabe |
|---|---|
| `open ?opt?` | Pfad; mit `-multiple 1` Liste von Pfaden |
| `save ?opt?` | Pfad (Datei muss nicht existieren) |
| `directory ?opt?` | gewählter Ordner, sonst der aktuelle |

Bei Abbruch ist das Ergebnis `""` (bzw. eine leere Liste).

| Option | Bedeutung |
|---|---|
| `-parent w` | Toplevel für transient und Platzierung |
| `-title t` | Fenstertitel (Standard *Open*, *Save*, *Choose folder*, über `msgcat`) |
| `-initialdir d` | Startordner; Standard `$HOME`, sonst `pwd` |
| `-provider p` | `tuprovider`; Standard ein frischer lokaler |
| `-filetypes {{Label {.ext …}} …}` | Typ-Combobox; filtert nach der ersten Endung; ohne Angabe ein Eintrag *All files* |
| `-multiple 0/1` | nur `open`: mehrere Dateien |
| `-showhidden 0/1` | Punkt-Dateien zeigen |
| `-initialfile name` | nur `save`: Name vorbelegen |
| `-defaultextension .ext` | nur `save`: anhängen, wenn der Name keine Endung hat |

```tcl
package require tkutils::tkufiledialog

set f [::tkutils::tkufiledialog::open -parent . -title "Text öffnen" \
    -initialdir [pwd] -filetypes {{Text {.txt .md}} {Alle *}}]
if {$f ne ""} { puts "gewählt: $f" }

set s [::tkutils::tkufiledialog::save -parent . -initialdir [pwd] \
    -initialfile bericht -defaultextension .txt]

set d [::tkutils::tkufiledialog::directory -parent . -initialdir [pwd]]
```

- Doppelklick auf einen Ordner wechselt hinein.
- Doppelklick auf eine Datei schließt den Dialog und liefert den Pfad
  (seit `tkufiledialog` 0.2; in 0.1 lieferte er `""`).
- *OK* oder Return im Namensfeld bestätigt, Escape oder *Cancel* bricht ab.
- `directory` listet nur Ordner.
- Unbekannte Option: `{TKUTILS TKUFILEDIALOG OPTION <opt>}`, Meldung
  `unknown option "<opt>"` mit `Known:`-Liste; unbekannter Parent:
  `{TKUTILS TKUFILEDIALOG PARENT <w>}`, Meldung
  `bad window path name "<w>" given as -parent`.

Der Doppelklick läuft wie *OK* und Return über `_finishOk` (Test
`tkufiledialog-1.4a`). Die Bedienung Schritt für Schritt und der Fehler
in 0.1: [Anhang G](860-anhang-testumgebung.md).

Der Dialog ist kein voller Dateimanager.

---

## Zusammenfassung

- Liste/Baum sprechen Provider, nicht festes FS.
- `tkufiletree -showhidden 1` zeigt Punkt-Dateien auch unter Windows einmal.
- `tkupath` 0.3 zeigt Laufwerks- und UNC-Pfade mit echten Zielen.
- Filedialog: `open`/`save`/`directory`, `""` bei Abbruch; Doppelklick auf
  eine Datei liefert den Pfad.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 und 9.0.4 unter Linux und Xvfb: die
Beispiele zu `tkufilelist`, `tkufiletree` und `tkupath`, die Tabelle der
Segmente und Ziele, `tkufiledialog.test` (7 von 7).

**Nicht getestet:** Windows (versteckte Dateien im Baum, Navigation mit
Laufwerks- und UNC-Pfaden).
:::

---

*Nächstes Kapitel: [Listen und tablelist](050-listen-und-tablelist.md)*
