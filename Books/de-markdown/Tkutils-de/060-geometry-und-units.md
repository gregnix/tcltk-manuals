# Geometrie und Units

## tkugeometry 0.1

[tkugeometry]{.index} merkt sich Größe, Position und Zoom-Zustand eines
Toplevels über `tclutils::tusettings`, in einer eigenen Datei
`<Konfig-Ordner>/<app>/geometry.ini`. Eine App, die beim Beenden ihr
eigenes Settings-Dict speichert, kann die Geometrie so nicht
überschreiben. Braucht mindestens tclutils **0.64.0** (dort kam
`tusettings` dazu); empfohlen ist 0.68.0.

Der Konfig-Ordner kommt aus `tusettings::dir config`: unter Linux
`$XDG_CONFIG_HOME/<app>`, sonst `$HOME/.config/<app>`; laut Code unter
Windows `%APPDATA%\<app>` und unter macOS
`$HOME/Library/Application Support/<app>` (nur unter Linux geprüft).

| Befehl | Wirkung | Rückgabe |
|---|---|---|
| `track w app ?-key k? ?-default geo?` | jetzt herstellen, beim Zerstören speichern | angewandte Geometrie oder `""` |
| `restore w app ?-key k? ?-default geo?` | gespeicherte Geometrie anwenden | angewandte Geometrie oder `""` |
| `save w app ?-key k?` | jetzt speichern | gespeicherte Geometrie |
| `key w` | Schlüssel aus dem Pfad | `.` → `main`, `.dlg` → `dlg` |

```tcl
package require tkutils::tkugeometry
::tkutils::tkugeometry::track . meineapp -default 800x600         ;# -> 800x600
toplevel .vorschau
::tkutils::tkugeometry::track .vorschau meineapp -default 400x300 ;# -> 400x300
```

`track` stellt selbst her — ein vorheriges `restore` ist nicht nötig.
`-default` (eine Größe wie `800x600` oder eine volle Geometrie) gilt, wenn
noch nichts gespeichert ist. Gespeichert wird beim `<Destroy>` des Fensters
über einen eigenen Bindtag; die `<Destroy>`-Bindings der App bleiben
unberührt. `save` ruft man nur, wenn zu einem anderen Zeitpunkt gesichert
werden soll. Mit `-key` wählen Sie einen anderen Abschnittsnamen als den aus
`key`.

Unter Xvfb ohne Fenstermanager steht nach dem Beenden in
`geometry.ini`:

```ini
[main]
geometry=800x600+0+0
zoomed=0
```

---

## Außerhalb des Bildschirms

Eine gespeicherte Position, die nicht mehr auf dem Bildschirm liegt — der
zweite Monitor fehlt, die Auflösung ist kleiner —, wird nicht benutzt. Das
Fenster behält seine Größe (falls nötig auf den Bildschirm verkleinert) und
wird **zentriert**. „Auf dem Bildschirm“ heißt: der obere Streifen des
Fensters (Titelleiste, 100×30 Pixel) liegt in Tks virtueller Wurzel — unter
X11 alle Monitore als ein Rechteck, unter Windows der virtuelle Desktop.
Eine Lücke zwischen verschieden großen Monitoren erkennt die Prüfung nicht.

Beispiel bei einem Bildschirm von 1280×1024 Pixeln: Gespeichert ist
`500x400+5000+5000`, `restore` setzt `500x400+390+312` — gleiche Größe,
zentriert.

Der Zoom-Zustand wird als `zoomed` gespeichert und dort wiederhergestellt,
wo Tk ihn kennt (`wm state zoomed` unter Windows/macOS,
`wm attributes -zoomed` unter X11).

Fehler: `{TKUTILS TKUGEOMETRY WINDOW}`, Meldung
`".nix" is not an existing toplevel` (kein vorhandenes Toplevel). Eine
unbekannte Option meldet `{TCLUTILS COMMON OPTION <opt>}` mit
`unknown option "<opt>"` und `Known: -key -default`, weil das Modul die
Optionsprüfung von tclutils benutzt. Ungültige App-Namen und unlesbare
Dateien melden die `tusettings`-Fehler, etwa `{TCLUTILS TUSETTINGS APP}`
mit `bad app name "a/b": must be a plain directory name`.

---

## tkuunits 0.1

[tkuunits]{.index} rechnet Bildschirmmaße zwischen px, pt, mm, cm und inch
um. Tk versteht die Einheiten selbst (`winfo fpixels . 10m`), aber Pixel
zurück in Millimeter oder Einheit in Einheit bleibt dem Aufrufer. Für
Etiketten- und Druckvorschauen.

| Befehl | Rückgabe |
|---|---|
| `units` | `px pt mm cm inch` |
| `toPixels wert einheit ?fenster?` | Pixel als Fließkommazahl |
| `fromPixels px ?fenster?` | Dict mit `px pt mm cm inch` |
| `convert wert von nach ?fenster?` | Fließkommazahl |

```tcl
package require tkutils::tkuunits
puts [::tkutils::tkuunits::convert 62 mm cm]       ;# -> 6.2
puts [::tkutils::tkuunits::convert 1 inch pt]      ;# -> 72.0
set px [::tkutils::tkuunits::toPixels 62 mm]       ;# Etikettenbreite am Schirm
puts [dict get [::tkutils::tkuunits::fromPixels 300] mm]
```

Neben `px pt mm cm inch` gelten die Tk-Buchstaben `p m c i` und `in`. `pt`
ist der Druckerpunkt, 1/72 Zoll, wie in Tk. Pixelwerte richten sich nach
der Auflösung des Fensters (Standard `.`) und damit nach `tk scaling`;
Einheit-zu-Einheit-Ergebnisse hängen davon nicht ab.

Fehler (Meldungen aus dem Test):

| Code | Meldung |
|---|---|
| `{TKUTILS TKUUNITS UNIT}` | `unknown unit "furlong": must be px, pt, mm, cm, inch` |
| `{TKUTILS TKUUNITS VALUE}` | `expected a number but got "2c"` |
| `{TKUTILS TKUUNITS WINDOW}` | `bad window path name ".nix"` |

Bei `tk scaling` 1,39 (Xvfb-Standard) und 2,0 bleibt
`convert 1 inch pt` bei `72.0`; `convert 62 mm cm` liefert bei 1,39
`6.2`, bei 2,0 `6.199999999999999` — Rundungsrest der
Fließkommarechnung. Runden Sie Ausgaben selbst, etwa mit `format %.2f`.

---

## Zusammenfassung

- `track` stellt her und speichert beim Schließen; `-default` für den
  ersten Start.
- Position außerhalb des Bildschirms → zentriert, Größe bleibt.
- Units für geräteunabhängige Maße am Bildschirm.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 und 9.0.4 unter Linux, Xvfb ohne
Fenstermanager, Bildschirm 1280×1024: alle Beispiele, Fehlercodes und
Meldungen dieses Kapitels.

**Nicht getestet:** Konfig-Ordner unter Windows und macOS, mehrere
Monitore, Zoom-Zustand (Xvfb ohne Fenstermanager kennt keinen).
:::

---

*Nächstes Kapitel: [Aktionen und Layout](070-aktionen-und-layout.md)*
