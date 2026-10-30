# Praxis: CSV, Datenstrukturen und sichere Fehlerbehandlung

## CSV-Zeilen verarbeiten

`tucsv` stellt die Funktionen `parseLine`, `joinLine`, `parse`, `text`, `file`, `dicts` und `writeFile` bereit. Die Parseroptionen `-delimiter`, `-quote`, `-trim` und `-strict` sind im Quelltext von `tucsv-0.2.tm` definiert; `text`, `file` und `writeFile` kennen dazu `-profile`, `-bom` und `-encoding`. Die Ausgabe von `joinLine` kann über `-alwaysQuote` gesteuert werden.

```tcl
package require tclutils::tucsv

set record [list {Müller, GmbH} {Er sagte "Hallo"} 48683]
set csvLine [::tclutils::tucsv::joinLine $record]
set parsed [::tclutils::tucsv::parseLine $csvLine]
if {$parsed ne $record} {
    error "CSV roundtrip failed"
}
puts $csvLine
```

Die Werte werden als Tcl-Liste aufgebaut. Dadurch bleiben eingebettete Kommas und Anführungszeichen in einem Feld erhalten. Der Test prüft die Rückübersetzung, nicht die Bytegleichheit zu einer fremden CSV-Datei.

## Fehlerfälle gezielt behandeln

Ein nicht geschlossenes Anführungszeichen erzeugt bei aktiviertem `-strict` den Fehlercode `{TCLUTILS TUCSV QUOTE}`. Damit kann der Aufrufer Parserfehler getrennt von Datei- oder Laufzeitfehlern behandeln.

```tcl
package require tclutils::tucsv

try {
    ::tclutils::tucsv::parseLine {"nicht geschlossen}
} trap {TCLUTILS TUCSV QUOTE} {message options} {
    puts "CSV input rejected: $message"
}
```

Die `trap`-Klausel reagiert nur auf den angegebenen Fehlercode. Für andere Fehler bleibt eine eigene Behandlung oder Weitergabe erforderlich.

## Dictionaries mit `tudict`

Die Implementierung von `tudict-0.1.tm` exportiert `getOr`, `paths`, `flatten`, `mergeDeep` und `invert`. Für verschachtelte Daten sind insbesondere die Argumentreihenfolge und der Umgang mit fehlenden Schlüsseln zu beachten.

```tcl
package require tclutils::tudict

set defaults [dict create ui [dict create language de theme light]]
set overrides [dict create ui [dict create theme dark]]
set settings [::tclutils::tudict::mergeDeep $defaults $overrides]
puts [dict get $settings ui language]
puts [dict get $settings ui theme]
```

`mergeDeep` ist für verschachtelte Dictionaries gedacht. Prüfen Sie vor produktivem Einsatz, ob einzelne Werte selbst gültige Dictionaries sein können und wie die Anwendung diese interpretiert.

## Dateipfade und Portabilität

`tupath` exportiert `normalize`, `clean`, `isAbsolute`, `components`, `join`, `relative`, `commonPath` und `readlink`. `file normalize` und `tupath::clean` sind nicht gleichbedeutend: Normalisierung kann vom Dateisystem und der Plattform abhängen; rein textuelle Bereinigung ist davon zu unterscheiden.

```tcl
package require tclutils::tupath
set relativePath [::tclutils::tupath::join docs manual index.md]
puts $relativePath
```

**Grenzen:** Der API-Katalog nennt Signaturen; die Beispiele oben sind aus den Quelltexten abgeleitet. Eine vollständige plattformübergreifende Ausführung der Beispiele ist damit nicht behauptet.
