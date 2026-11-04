# 02 — Pfade

```tcl
file join $env(HOME) Dokumente
file nativename $env(HOME)    ;# unter Unix gleich dem Unix-Pfad
```

Immer `file join`, nie `"$env(HOME)/foo"` mit hartem Slash mischen wenn
Teile leer sein können.

## Tilde

Tcl 8.6 ersetzt ein führendes `~` in jedem Dateibefehl durch `HOME`.
Tcl 9 tut das nicht mehr (TIP 602): `~` ist dort ein gewöhnlicher
Dateiname, `file normalize ~` ergibt `<aktueller Ordner>/~`.

| Ausdruck | Tcl 8.6 | Tcl 9 |
|----------|---------|-------|
| `file normalize ~` | `HOME` | `[pwd]/~` |
| `file home` | unbekannt | `HOME` |
| `file tildeexpand ~/x` | unbekannt | `HOME/x` |

Für beide Fassungen `$env(HOME)` nehmen, keine Tilde. Eine Tilde, die
von außen kommt (Konfigurationsdatei, Eingabe), löst unter Tcl 9
`file tildeexpand` auf.

## Demo

```bash
tclsh howto/02-pfade.tcl
```
