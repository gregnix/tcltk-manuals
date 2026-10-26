# Practice and Failure Cases

## Processing CSV Lines

`tucsv` provides the functions `parseLine`, `joinLine`, `parse`, `text`, `file`, `dicts` and `writeFile`. The parser options `-delimiter`, `-quote`, `-trim` and `-strict` are defined in the source of `tucsv-0.1.tm`. The output of `joinLine` can be controlled with `-alwaysQuote`.

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

The values are built as a Tcl list. This keeps embedded commas and quotes within a field. The test checks the round trip, not byte equality with a foreign CSV file.

## Handling Error Cases Specifically

With `-strict` enabled, an unclosed quote produces the error code `{TCLUTILS TUCSV QUOTE}`. This lets the caller handle parser errors separately from file or runtime errors.

```tcl
package require tclutils::tucsv

try {
    ::tclutils::tucsv::parseLine {"nicht geschlossen}
} trap {TCLUTILS TUCSV QUOTE} {message options} {
    puts "CSV input rejected: $message"
}
```

The `trap` clause responds only to the given error code. Other errors still need their own handling or have to be passed on.

## Dictionaries with `tudict`

The implementation of `tudict-0.1.tm` exports `getOr`, `paths`, `flatten`, `mergeDeep` and `invert`. For nested data, pay particular attention to the argument order and the handling of missing keys.

```tcl
package require tclutils::tudict

set defaults [dict create ui [dict create language de theme light]]
set overrides [dict create ui [dict create theme dark]]
set settings [::tclutils::tudict::mergeDeep $defaults $overrides]
puts [dict get $settings ui language]
puts [dict get $settings ui theme]
```

`mergeDeep` is meant for nested dictionaries. Before production use, check whether individual values can themselves be valid dictionaries and how the application interprets them.

## File Paths and Portability

`tupath` exports `normalize`, `clean`, `isAbsolute`, `components`, `join`, `relative`, `commonPath` and `readlink`. `file normalize` and `tupath::clean` are not equivalent: normalization can depend on the file system and the platform; purely textual cleanup is a different thing.

```tcl
package require tclutils::tupath
set relativePath [::tclutils::tupath::join docs manual index.md]
puts $relativePath
```

**Limits:** The API catalog lists signatures; the examples above are derived from the sources. This does not claim that the examples were run in full on every platform.
