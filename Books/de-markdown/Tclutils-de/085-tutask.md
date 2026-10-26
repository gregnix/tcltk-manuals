# Tasks mit tutask

## Zweck

[tutask]{.index} **0.2** (seit tclutils 0.66.0) führt Aufgaben als
Tasks auf [Koroutinen]{.index} aus. Ein Task wartet mit `await` auf eine
Operation; die Ereignisschleife läuft währenddessen weiter. Dazu kommen
Timeout, Abbruch mit Aufräumen, Gruppen, ein Thread-Pool und eine Sandbox.

Pure Tcl ab 8.6 (`package require Tcl 8.6-`). Nur der Pool braucht das
Paket `Thread` und lädt es erst beim ersten `pool`. Der Umbrella lädt
`tutask` mit.

`tutask` 0.2 verlangt `tclutils::common 0.2`. Wer einen älteren Baum
überkopiert, löscht `tutask-0.1.tm`, sonst liegen beide Versionen
nebeneinander.

```tcl
package require tclutils::tutask
namespace import ::tclutils::tutask::*
```

Exportiert werden `spawn`, `run`, `current`, `await`, `sleep`, `timer`,
`onwrite`, `pipe`, `group`, `pool`, `sandbox`, `tasks` und `stats`. Die
Beispiele dieses Kapitels setzen den Import voraus.

---

## Der Vertrag: Starter

Jede Operation ist ein Befehlspräfix, ein [Starter]{.index}. `await` hängt
einen Callback `cb` an und ruft den Starter auf. Der Starter gibt einen
Abbruchbefehl zurück (ein Präfix, darf leer sein) und meldet später genau
einmal:

```
starter cb                    ;# -> Abbruchbefehl
{*}$cb ok wert
{*}$cb error meldung ?optionen?
```

Nur die erste Meldung zählt. Eine späte Meldung nach Timeout oder Abbruch
verfällt. Eigene Operationen folgen denselben Zeilen:

```tcl
proc meinOp {cb} {
    set id [after 100 [list {*}$cb ok fertig]]
    return [list after cancel $id]
}
run apply {{} { await meinOp }}      ;# -> fertig
```

Mitgeliefert: `timer`, `pipe`, `onwrite`, Tasks und Gruppen (über `wait`),
`$pool op` und `$sandbox op`.

---

## Tasks

```tcl
set t [spawn apply {{n} {
    sleep 50
    return [expr {$n * 2}]
}} 21]
$t state         ;# -> running
$t wait          ;# -> 42
$t state         ;# -> ok
$t destroy
```

| Befehl | Wirkung |
|---|---|
| `spawn ?-detach bool? cmd ?arg …?` | Task-Objekt; läuft sofort bis zum ersten `await` |
| `run ?-timeout ms? cmd ?arg …?` | `spawn`, `wait`, `destroy`; liefert den Wert |
| `current` | laufender Task oder leer |
| `$t state` | `running`, `ok`, `error` oder `cancelled` |
| `$t result` | Wert; sonst der Fehler des Tasks, `CANCELLED` oder `NOTDONE` |
| `$t wait ?-timeout ms?` | im Task: `await`; außerhalb: blockiert in `vwait` |
| `$t cancel` | Abbruch; 1, wenn der Task noch lief |
| `$t ondone cmd` | ruft `cmd` mit angehängtem Task-Objekt, sobald er fertig ist |
| `$t destroy` | bricht einen laufenden Task vorher ab |

`run` ist für Skripte und Tests gedacht. Ein Timeout bei `wait` bricht den
Task ab; `state` ist danach `cancelled`. `-timeout 0` (Default) heißt:
kein Timeout. Ein Task mit `-detach 1` zerstört
sich nach dem Ende selbst.

---

## Warten: await und sleep

`await starter ?-timeout ms?` liefert den Wert der Operation oder wirft
deren Fehler mit dem eigenen `-errorcode`. Läuft der Timeout ab, ruft
`await` den Abbruchbefehl der Operation und wirft
`{TCLUTILS TUTASK TIMEOUT}`. `sleep ms` pausiert den Task, ohne die
Ereignisschleife anzuhalten.

```tcl
try {
    run apply {{} { await [timer 500 x] -timeout 50 }}
} trap {TCLUTILS TUTASK TIMEOUT} msg {
    puts $msg                        ;# -> timeout after 50 ms
}
```

`await` funktioniert in jeder Koroutine; `cancel` braucht einen Task.
Außerhalb jeder Koroutine wirft `await` `{TCLUTILS TUTASK NOTASK}`.

`-timeout` muss eine ganze Zahl ab 0 sein. Ab 0.66.0 prüfen das `await`,
`run`, `$t wait` und `$g wait` gleich: ein Wert wie `abc` oder `-5` wirft
`{TCLUTILS TUTASK OPTION}` mit `-timeout must be a non-negative integer
(ms)`. `run` prüft vor `spawn`; ein falscher Wert hinterlässt keinen
Task. Bis 0.65.0 prüfte nur `await`. `run`, `$t wait` und `$g wait`
außerhalb eines Tasks nahmen den Wert stillschweigend an und warteten
ohne Timeout.

```tcl
catch {run -timeout abc {after 10}} msg opts
dict get $opts -errorcode    ;# -> TCLUTILS TUTASK OPTION
tasks                        ;# -> (leer)
```

---

## Abbrechen mit Aufräumen

`$t cancel` setzt den Task mit einer Abbruchanforderung fort. Sein
`await` wirft dort `{TCLUTILS TUTASK CANCELLED}`. Die `finally`-Zweige
sind gelaufen, wenn `cancel` zurückkehrt. Die Operation, auf die der Task
wartete, wird mit abgebrochen.

```tcl
set t [spawn apply {{} {
    try { sleep 10000 } finally { puts aufgeraeumt }
}}]
$t cancel        ;# gibt "aufgeraeumt" aus, -> 1
$t state         ;# -> cancelled
$t destroy
```

- Aus dem Task selbst heraus wirkt `cancel` erst beim nächsten `await`.
- Ein Task, der `CANCELLED` fängt und wieder wartet, wird erneut
  abgebrochen.
- `destroy` aus dem eigenen Task wirft `{TCLUTILS TUTASK INSIDE}`; dort
  `cancel` verwenden.
- Wartet ein Task per `wait` auf einen anderen Task und wird abgebrochen,
  bricht das auch den anderen ab: beide enden `cancelled`, beide
  `finally`-Zweige laufen.

---

## Operationen

| Operation | Wert |
|---|---|
| `timer ms ?wert?` | nach `ms` Millisekunden `wert` (Default leer) |
| `onwrite varName` | der neue Inhalt, sobald die Variable geschrieben wird |
| `pipe cmdlist ?-encoding enc? ?-profile p?` | Ausgabe der Pipeline, stdout und stderr zusammen |

`onwrite` nimmt eine globale oder voll qualifizierte Variable; ohne
führendes `::` setzt es `::` davor. Typisch: ein Knopf setzt die Variable.

`pipe` startet die Pipeline nicht blockierend (`open |… 2>@1`). Ein
Exit-Code ungleich 0 wirft Tcls `{CHILDSTATUS pid code}`. Abbruch und
Timeout beenden die Prozesse: `kill` unter Unix, `taskkill /T /F` unter
Windows. `-profile` gibt es nur unter Tcl 9; unter 8.6 wirft die Option
`{TCLUTILS TUTASK OPTION}` mit `pipe: -profile needs Tcl 9`.

```tcl
run apply {{} { await [pipe {echo hallo}] }}     ;# -> "hallo\n"
try {
    run apply {{} { await [pipe {sh -c {exit 3}}] }}
} trap CHILDSTATUS {msg opts} {
    lindex [dict get $opts -errorcode] 2        ;# -> 3
}
```

Unter Unix trifft `kill` nur die Prozesse, die `pid` für den Kanal nennt.
Startet die Pipeline ihrerseits Kinder (etwa `sh -c "sleep 30 & …"`),
laufen diese nach Abbruch oder Timeout weiter. Die Roadmap im
tclutils-Baum plant dafür einen Prozessgruppen-Kill (`setsid`). Windows
beendet die Pipeline laut CHANGELOG mit `taskkill /T /F`.

---

## Gruppen

```tcl
set g [group]
$g spawn apply {{} { sleep 30; return a }}
$g spawn apply {{} { return b }}
$g wait                      ;# -> a b
$g destroy
```

- `-mode all` (Default): alle Ergebnisse in `spawn`-Reihenfolge. Der erste
  Fehler bricht die übrigen Tasks ab und wird geworfen.
- `-mode first`: der erste fertige Task gewinnt, die übrigen werden
  abgebrochen. `$g winner` nennt den Gewinner.
- `$g wait` nimmt auch `-timeout ms`. `$g tasks` listet die Tasks;
  `$g destroy` zerstört sie mit.
- Leere Gruppe: `all` liefert eine leere Liste, `first` wirft
  `{TCLUTILS TUTASK EMPTY}`. Ein anderer Modus wirft
  `{TCLUTILS COMMON VALUE -mode}`.
- Wird ein Task abgebrochen, der auf eine Gruppe wartet, bricht das die
  Tasks der Gruppe ab.

`$g destroy` direkt nach `$g wait` ist unbedenklich, auch wenn `wait`
außerhalb eines Tasks mit `-mode first` lief oder `-mode all` mit einem
Fehler endete: Späte Rückmeldungen abgebrochener Tasks verfallen. Bis
0.65.0 meldete `bgerror` dann `invalid command name "::oo::Obj…::my"`.

---

## Thread-Pool

```tcl
set p [pool -size 2 -init {proc rechne {n} { expr {$n * 2} }}]
run apply {{p} { await [$p op {rechne 21}] -timeout 10000 }} $p
# -> 42
$p stats         ;# -> workers 1 idle 1 queued 0 jobs 0
$p destroy
```

- `-size` (Default 2) ist die Höchstzahl der Worker; sie entstehen erst
  bei Bedarf. `-init` läuft in jedem neuen Worker.
- Jeder Job läuft in einem Worker-Thread mit eigenem Interpreter. Es gibt
  keine gemeinsamen Variablen.
- Fehler behalten `-errorcode` und `-errorinfo` des Workers.
- Ein Job in der Warteschlange wird beim Abbruch entfernt. Ein laufender
  Job bekommt `thread::cancel`; der Worker lebt weiter (nach einem
  Timeout auf `while 1 {}` nimmt derselbe Pool den nächsten Job an).
- `$p destroy` gibt die Worker frei; wartende Tasks erhalten `CANCELLED`.
- Ohne Paket `Thread` wirft `pool` `{TCLUTILS TUTASK NOTHREAD}`.
  Scheitert `-init`, wirft der erste Job `{TCLUTILS TUTASK INIT}`.

Gemessen: zwei Jobs mit je `after 300` in einer Gruppe brauchten zusammen
rund 300 ms, liefen also parallel.

`pool -size 0` wirft `-size must be a positive integer`. Bei
`-init {error boom}` bekommt der Wartende `{TCLUTILS TUTASK INIT}` mit
`pool -init failed: boom`; `$p stats` zeigt danach
`workers 0 idle 0 queued 0 jobs 0`. Bis 0.65.0 meldete `bgerror` dabei
zusätzlich einen Fehler, und der Job blieb in der Warteschlange.

---

## Sandbox

```tcl
set s [sandbox -commands 1000 -time 500]
$s eval {expr {6*7}}                 ;# -> 42
catch {$s eval {while 1 {info level}}} msg opts
dict get $opts -errorcode
# -> TCLUTILS TUTASK LIMIT COMMANDS
$s eval {set x 1}                    ;# -> 1 (Grenzen wieder frisch)
run apply {{s} { await [$s op {string repeat ab 2}] }} $s   ;# -> abab
$s destroy
```

Die [Sandbox]{.index} ist ein sicherer Interpreter (`-safe 1`, Default;
`-safe 0` für einen normalen). Optionen: `-commands n` und `-time ms`
(je 0 = keine Grenze), `-aliases {name präfix …}` für Befehle, die das
Kind aufrufen darf. `$s interp` liefert den Interpreter.

- Die Grenzen gelten pro Auswertung. Überschreitung wirft
  `{TCLUTILS TUTASK LIMIT COMMANDS}` bzw. `{TCLUTILS TUTASK LIMIT TIME}`.
- Andere Fehler behalten den Code des Kinds, etwa
  `{TCL LOOKUP COMMAND open}` für `open` im sicheren Interpreter.
- Das Skript läuft im aufrufenden Thread. `op` lässt sich abbrechen, bis
  es startet (nächster Durchlauf der Ereignisschleife); danach begrenzen
  es nur die Limits. Für echte Parallelität den Pool nehmen.
- Eine leere
  Schleife `while 1 {}` zählt keine Befehle. `-commands` allein hält sie
  nicht an; der Lauf hing bis zum äußeren Abbruch. `-time 500` beendete
  sie nach 500 ms mit `LIMIT TIME`. Deshalb `-time` immer mit setzen.

---

## Lecks und vergessene Fehler

`tasks` liefert die lebenden Task-Objekte, `stats` ein Dict mit
`tasks running awaits pipes pools sandboxes`. Nach einem Testlauf sollten
alle Werte 0 sein:

```tcl
stats
# -> tasks 0 running 0 awaits 0 pipes 0 pools 0 sandboxes 0
```

Einen Fehler, den weder `result`, `wait`, `ondone` noch eine Gruppe
abgeholt hat, meldet das Task-Objekt beim `destroy` über `bgerror`, mit
dem `-errorcode` des Tasks:

```
tutask: error in task <obj> was never collected: <Meldung>
```

Das gilt auch für Tasks mit `-detach 1`.

---

## In Tk-Programmen

Im Ereignis-Handler nur `spawn` aufrufen und zurückkehren; das Warten
erledigt der Task. Kein `$t wait` außerhalb eines Tasks in einem Handler:
das startet ein verschachteltes `vwait`, dieselbe Falle wie `vwait` im
Callback. Im Task sind `wait` und `await` unbedenklich.

`examples/demo-task.tcl` im tclutils-Baum zeigt beides: unter `tclsh`
einen Konsolenteil, unter `wish` zusätzlich einen Fortschrittsbalken mit
Abbrechen-Knopf. Der Handler startet nur den Task; `ondone` zerstört ihn.
Nach dem Abbruch setzt der `finally`-Zweig die Knöpfe zurück, `stats`
ist danach überall 0. Widgets selbst: Buch *tkutils*.

---

## Fehlercodes

Alle Codes beginnen mit `TCLUTILS TUTASK`:

| Grund | Fall | Meldung |
|---|---|---|
| `CANCELLED` | Task abgebrochen, Pool zerstört | `task cancelled` |
| `TIMEOUT` | `-timeout` abgelaufen | `timeout after <ms> ms` |
| `NOTASK` | `await` außerhalb einer Koroutine | `await outside a task or coroutine` |
| `NOTDONE` | `result` eines laufenden Tasks | `task <obj> is still running` |
| `OPTION` | falsches Argument (`spawn` ohne Befehl, `timer -1`, leere `pipe`, `-timeout x`) | je Fall, bei `-timeout`: `-timeout must be a non-negative integer (ms)` |
| `NOTHREAD` | `pool` ohne Paket `Thread` | `the Thread package is not available` |
| `EMPTY` | `wait -mode first` auf leerer Gruppe | `group is empty` |
| `INIT` | `-init` des Pools gescheitert | `pool -init failed: <Fehler>` |
| `INSIDE` | `destroy` aus dem eigenen Task | `a task cannot destroy itself while running; use cancel` |
| `PROTOCOL` | Koroutine unerwartet fortgesetzt (intern) | je Fall |
| `LIMIT COMMANDS` | Befehlsgrenze der Sandbox | Meldung von Tcl |
| `LIMIT TIME` | Zeitgrenze der Sandbox | Meldung von Tcl |

Unbekannte Optionen laufen über `common::parseOptions` und werfen
`{TCLUTILS COMMON OPTION <opt>}`.

---

## Zusammenfassung

- `tutask` 0.2: Tasks auf Koroutinen, im Umbrella.
- Eine Operation ist ein Starter: Callback rein, Abbruchbefehl raus.
- `cancel` lässt `finally` laufen und bricht die erwartete Operation ab.
- Gruppen (`all`, `first`), Pool (Paket `Thread`), Sandbox (Limits).
- Unter Unix tötet `pipe` beim Abbruch keine Enkelprozesse.
- `-commands` allein stoppt keine leere Schleife; `-time` mit setzen.
- Ab 0.66.0 prüfen `await`, `run`, `$t wait` und `$g wait` `-timeout`
  gleich; ein falscher Wert wirft `{TCLUTILS TUTASK OPTION}`.

---

*Nächstes Kapitel: [Tests und tutestrun](090-tests-und-tutestrun.md)*
