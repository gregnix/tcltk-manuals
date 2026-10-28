# Praxis: Tk-Integration, Maße und Fensterzustand

## Tk zuerst laden

`tkutils` ergänzt Tk; es ersetzt die Tk-Laufzeit nicht. Für grafische Beispiele wird ein Display benötigt. Unter Linux kann ein Testlauf mit Xvfb sinnvoll sein, während der reine `tclsh` ohne Display keine Fenster erstellt.

```tcl
package require Tk
package require tkutils::tkuunits

label .label -text "Maßeinheiten"
pack .label -padx 12 -pady 12
puts [::tkutils::tkuunits::toPixels 10 mm .]
```

`tkuunits-0.1.tm` exportiert `units`, `toPixels`, `fromPixels` und `convert`. Die Umrechnung kann das Fensterargument `w` verwenden, weil die physische Bildschirmauflösung relevant ist. Ein Pixelwert ist deshalb nicht auf allen Displays identisch.

## Einheiten vergleichen

```tcl
package require Tk
package require tkutils::tkuunits

set pixels [::tkutils::tkuunits::toPixels 25.4 mm .]
set inches [::tkutils::tkuunits::convert 25.4 mm inch .]
puts "pixels=$pixels inches=$inches"
```

Die Rückgabewerte sollten nicht als feste Pixelkonstanten in Dokumentation oder Tests eingetragen werden. Ein guter Test vergleicht die Konsistenz zweier Umrechnungen unter derselben Displaykonfiguration.

## Fenstergeometrie

`tkugeometry-0.1.tm` exportiert `save`, `restore`, `track` und `key`. Die ersten drei Befehle erwarten unter anderem ein Fenster und eine Anwendungskennung. Die interne Implementierung enthält außerdem Logik zum Anpassen an verfügbare Bildschirmflächen.

```tcl
package require Tk
package require tkutils::tkugeometry

set appId demo-window
wm title . "Fensterzustand"
# "." ergibt den Schlüssel main, ohne zu speichern.
set geometryKey [::tkutils::tkugeometry::key .]
puts $geometryKey
```

Das Beispiel führt keine persistenten Schreibzugriffe aus. Für `save`, `restore` und `track` sind vor dem Einsatz insbesondere Ablageort, Optionen und Verhalten bei mehreren Monitoren zu prüfen.

## Fehlersuche bei optionalen Widgets

Ein Widget-Modul kann zusätzliche Pakete benötigen, etwa Tablelist, Img, tDOM oder scrollutil. Testen Sie solche Module einzeln, statt allein aus einem erfolgreichen `package require tkutils` auf die Verfügbarkeit sämtlicher Zusatzfunktionen zu schließen.

```tcl
package require Tk
set code [catch {package require tkutils::tkutablelist} result options]
if {$code} {
    puts stderr "Tablelist integration unavailable: $result"
} else {
    puts "tkutablelist $result"
}
```

Ein fehlendes optionales Paket ist kein Fehler der Tk-Laufzeit. Die Anwendung sollte dann entweder eine verständliche Diagnose ausgeben oder die betroffene Funktion deaktivieren.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 und 9.0.4 unter Linux und Xvfb: alle
Beispiele dieses Anhangs. Bei `tk scaling` 1,39 gibt das erste Beispiel
`39.38461538461539` aus, das zweite `pixels=100.03692307692307
inches=1.0`, das dritte `main`.

**Nicht getestet:** verschiedene Fenstermanager.
:::
