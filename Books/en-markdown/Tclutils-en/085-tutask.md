# Tasks with tutask

## Purpose

[tutask]{.index} **0.2** (since tclutils 0.66.0) runs jobs as
tasks on [coroutines]{.index}. A task waits for an
operation with `await`; the event loop keeps running in the meantime. On top of that come
timeout, cancellation with cleanup, groups, a thread pool and a sandbox.

Pure Tcl from 8.6 on (`package require Tcl 8.6-`). Only the pool needs the
package `Thread` and loads it only on the first `pool`. The umbrella loads
`tutask` as well.

`tutask` 0.2 requires `tclutils::common 0.2`. When copying over an older tree,
delete `tutask-0.1.tm`; otherwise both versions lie
side by side.

```tcl
package require tclutils::tutask
namespace import ::tclutils::tutask::*
```

Exported are `spawn`, `run`, `current`, `await`, `sleep`, `timer`,
`onwrite`, `pipe`, `group`, `pool`, `sandbox`, `tasks` and `stats`. The
examples in this chapter assume the import.

---

## The contract: starters

Every operation is a command prefix, a [starter]{.index}. `await` appends
a callback `cb` and calls the starter. The starter returns a
cancel command (a prefix, may be empty) and later reports exactly
once:

```
starter cb                    ;# -> Abbruchbefehl
{*}$cb ok wert
{*}$cb error meldung ?optionen?
```

Only the first report counts. A late report after timeout or cancellation
is discarded. Your own operations follow the same lines:

```tcl
proc meinOp {cb} {
    set id [after 100 [list {*}$cb ok fertig]]
    return [list after cancel $id]
}
run apply {{} { await meinOp }}      ;# -> fertig
```

Supplied: `timer`, `pipe`, `onwrite`, tasks and groups (via `wait`),
`$pool op` and `$sandbox op`.

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

| Command | Effect |
|---|---|
| `spawn ?-detach bool? cmd ?arg …?` | task object; runs immediately up to the first `await` |
| `run ?-timeout ms? cmd ?arg …?` | `spawn`, `wait`, `destroy`; returns the value |
| `current` | running task or empty |
| `$t state` | `running`, `ok`, `error` or `cancelled` |
| `$t result` | value; otherwise the task's error, `CANCELLED` or `NOTDONE` |
| `$t wait ?-timeout ms?` | inside a task: `await`; outside: blocks in `vwait` |
| `$t cancel` | cancellation; 1 if the task was still running |
| `$t ondone cmd` | calls `cmd` with the task object appended as soon as it is done |
| `$t destroy` | cancels a running task first |

`run` is meant for scripts and tests. A timeout in `wait` cancels the
task; `state` is `cancelled` afterwards. `-timeout 0` (default) means:
no timeout. A task with `-detach 1` destroys
itself after it ends.

---

## Waiting: await and sleep

`await starter ?-timeout ms?` returns the value of the operation or throws
its error with its own `-errorcode`. If the timeout expires,
`await` calls the operation's cancel command and throws
`{TCLUTILS TUTASK TIMEOUT}`. `sleep ms` pauses the task without stopping the
event loop.

```tcl
try {
    run apply {{} { await [timer 500 x] -timeout 50 }}
} trap {TCLUTILS TUTASK TIMEOUT} msg {
    puts $msg                        ;# -> timeout after 50 ms
}
```

`await` works in any coroutine; `cancel` needs a task.
Outside any coroutine, `await` throws `{TCLUTILS TUTASK NOTASK}`.

`-timeout` must be an integer of 0 or more. From 0.66.0 on, `await`,
`run`, `$t wait` and `$g wait` check this the same way: a value such as `abc` or `-5` throws
`{TCLUTILS TUTASK OPTION}` with `-timeout must be a non-negative integer
(ms)`. `run` checks before `spawn`; a wrong value leaves no
task behind. Up to 0.65.0 only `await` checked. `run`, `$t wait` and `$g wait`
outside a task silently accepted the value and waited
without a timeout.

```tcl
catch {run -timeout abc {after 10}} msg opts
dict get $opts -errorcode    ;# -> TCLUTILS TUTASK OPTION
tasks                        ;# -> (leer)
```

---

## Cancelling with cleanup

`$t cancel` resumes the task with a cancellation request. Its
`await` throws `{TCLUTILS TUTASK CANCELLED}` there. The `finally` branches
have run by the time `cancel` returns. The operation the task
was waiting for is cancelled along with it.

```tcl
set t [spawn apply {{} {
    try { sleep 10000 } finally { puts aufgeraeumt }
}}]
$t cancel        ;# gibt "aufgeraeumt" aus, -> 1
$t state         ;# -> cancelled
$t destroy
```

- From within the task itself, `cancel` takes effect only at the next `await`.
- A task that catches `CANCELLED` and waits again is cancelled
  again.
- `destroy` from within the task itself throws `{TCLUTILS TUTASK INSIDE}`; use
  `cancel` there.
- If a task waits via `wait` for another task and is cancelled,
  this cancels the other one as well: both end `cancelled`, both
  `finally` branches run.

---

## Operations

| Operation | Value |
|---|---|
| `timer ms ?wert?` | after `ms` milliseconds, `wert` (default empty) |
| `onwrite varName` | the new content as soon as the variable is written |
| `pipe cmdlist ?-encoding enc? ?-profile p?` | output of the pipeline, stdout and stderr combined |

`onwrite` takes a global or fully qualified variable; without a
leading `::` it prepends `::`. Typical use: a button sets the variable.

`pipe` starts the pipeline non-blocking (`open |… 2>@1`). A
nonzero exit code throws Tcl's `{CHILDSTATUS pid code}`. Cancellation and
timeout terminate the processes: `kill` under Unix, `taskkill /T /F` under
Windows. `-profile` exists only under Tcl 9; under 8.6 the option throws
`{TCLUTILS TUTASK OPTION}` with `pipe: -profile needs Tcl 9`.

```tcl
run apply {{} { await [pipe {echo hallo}] }}     ;# -> "hallo\n"
try {
    run apply {{} { await [pipe {sh -c {exit 3}}] }}
} trap CHILDSTATUS {msg opts} {
    lindex [dict get $opts -errorcode] 2        ;# -> 3
}
```

Under Unix, `kill` hits only the processes that `pid` names for the channel.
If the pipeline in turn starts children (such as `sh -c "sleep 30 & …"`),
these keep running after cancellation or timeout. The roadmap in the
tclutils tree plans a process group kill (`setsid`) for this. According to the CHANGELOG,
Windows terminates the pipeline with `taskkill /T /F`.

---

## Groups

```tcl
set g [group]
$g spawn apply {{} { sleep 30; return a }}
$g spawn apply {{} { return b }}
$g wait                      ;# -> a b
$g destroy
```

- `-mode all` (default): all results in `spawn` order. The first
  error cancels the remaining tasks and is thrown.
- `-mode first`: the first finished task wins, the others are
  cancelled. `$g winner` names the winner.
- `$g wait` also takes `-timeout ms`. `$g tasks` lists the tasks;
  `$g destroy` destroys them as well.
- Empty group: `all` returns an empty list, `first` throws
  `{TCLUTILS TUTASK EMPTY}`. Any other mode throws
  `{TCLUTILS COMMON VALUE -mode}`.
- If a task that waits for a group is cancelled, this cancels the
  group's tasks.

`$g destroy` directly after `$g wait` is safe, even if `wait`
ran outside a task with `-mode first` or `-mode all` ended with an
error: late reports from cancelled tasks are discarded. Up to
0.65.0, `bgerror` then reported `invalid command name "::oo::Obj…::my"`.

---

## Thread pool

```tcl
set p [pool -size 2 -init {proc rechne {n} { expr {$n * 2} }}]
run apply {{p} { await [$p op {rechne 21}] -timeout 10000 }} $p
# -> 42
$p stats         ;# -> workers 1 idle 1 queued 0 jobs 0
$p destroy
```

- `-size` (default 2) is the maximum number of workers; they are created only
  when needed. `-init` runs in every new worker.
- Each job runs in a worker thread with its own interpreter. There are
  no shared variables.
- Errors keep the worker's `-errorcode` and `-errorinfo`.
- A job in the queue is removed on cancellation. A running
  job gets `thread::cancel`; the worker lives on (after a
  timeout on `while 1 {}` the same pool accepts the next job).
- `$p destroy` releases the workers; waiting tasks receive `CANCELLED`.
- Without the package `Thread`, `pool` throws `{TCLUTILS TUTASK NOTHREAD}`.
  If `-init` fails, the first job throws `{TCLUTILS TUTASK INIT}`.

Measured: two jobs with `after 300` each in a group took about
300 ms together, so they ran in parallel.

`pool -size 0` throws `-size must be a positive integer`. With
`-init {error boom}` the waiting task gets `{TCLUTILS TUTASK INIT}` with
`pool -init failed: boom`; afterwards `$p stats` shows
`workers 0 idle 0 queued 0 jobs 0`. Up to 0.65.0, `bgerror` additionally
reported an error in this case, and the job stayed in the queue.

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

The [sandbox]{.index} is a safe interpreter (`-safe 1`, default;
`-safe 0` for a normal one). Options: `-commands n` and `-time ms`
(0 each = no limit), `-aliases {name präfix …}` for commands the
child may call. `$s interp` returns the interpreter.

- The limits apply per evaluation. Exceeding them throws
  `{TCLUTILS TUTASK LIMIT COMMANDS}` or `{TCLUTILS TUTASK LIMIT TIME}`.
- Other errors keep the child's code, for example
  `{TCL LOOKUP COMMAND open}` for `open` in the safe interpreter.
- The script runs in the calling thread. `op` can be cancelled until
  it starts (next pass of the event loop); after that only the
  limits bound it. For real parallelism use the pool.
- An empty
  loop `while 1 {}` counts no commands. `-commands` alone does not
  stop it; the run hung until the outer cancellation. `-time 500` ended
  it after 500 ms with `LIMIT TIME`. Therefore always set `-time` as well.

---

## Leaks and forgotten errors

`tasks` returns the living task objects, `stats` a dict with
`tasks running awaits pipes pools sandboxes`. After a test run
all values are expected to be 0:

```tcl
stats
# -> tasks 0 running 0 awaits 0 pipes 0 pools 0 sandboxes 0
```

An error that neither `result`, `wait`, `ondone` nor a group
has collected is reported by the task object on `destroy` via `bgerror`, with
the task's `-errorcode`:

```
tutask: error in task <obj> was never collected: <Meldung>
```

This also applies to tasks with `-detach 1`.

---

## In Tk programs

In the event handler, only call `spawn` and return; the task does
the waiting. No `$t wait` outside a task in a handler:
that starts a nested `vwait`, the same trap as `vwait` in a
callback. Inside a task, `wait` and `await` are safe.

`examples/demo-task.tcl` in the tclutils tree shows both: under `tclsh`
a console part, under `wish` additionally a progress bar with
a cancel button. The handler only starts the task; `ondone` destroys it.
After cancellation the `finally` branch resets the buttons; `stats`
is 0 everywhere afterwards. Widgets themselves: book *tkutils*.

---

## Error codes

All codes begin with `TCLUTILS TUTASK`:

| Reason | Case | Message |
|---|---|---|
| `CANCELLED` | task cancelled, pool destroyed | `task cancelled` |
| `TIMEOUT` | `-timeout` expired | `timeout after <ms> ms` |
| `NOTASK` | `await` outside a coroutine | `await outside a task or coroutine` |
| `NOTDONE` | `result` of a running task | `task <obj> is still running` |
| `OPTION` | wrong argument (`spawn` without command, `timer -1`, empty `pipe`, `-timeout x`) | per case; for `-timeout`: `-timeout must be a non-negative integer (ms)` |
| `NOTHREAD` | `pool` without package `Thread` | `the Thread package is not available` |
| `EMPTY` | `wait -mode first` on an empty group | `group is empty` |
| `INIT` | the pool's `-init` failed | `pool -init failed: <Fehler>` |
| `INSIDE` | `destroy` from within the task itself | `a task cannot destroy itself while running; use cancel` |
| `PROTOCOL` | coroutine resumed unexpectedly (internal) | per case |
| `LIMIT COMMANDS` | command limit of the sandbox | message from Tcl |
| `LIMIT TIME` | time limit of the sandbox | message from Tcl |

Unknown options go through `common::parseOptions` and throw
`{TCLUTILS COMMON OPTION <opt>}`.

---

## Summary

- `tutask` 0.2: tasks on coroutines, in the umbrella.
- An operation is a starter: callback in, cancel command out.
- `cancel` lets `finally` run and cancels the awaited operation.
- Groups (`all`, `first`), pool (package `Thread`), sandbox (limits).
- Under Unix, `pipe` does not kill grandchild processes on cancellation.
- `-commands` alone does not stop an empty loop; set `-time` as well.
- From 0.66.0 on, `await`, `run`, `$t wait` and `$g wait` check `-timeout`
  the same way; a wrong value throws `{TCLUTILS TUTASK OPTION}`.

---

*Next chapter: [Tests and tutestrun](090-tests-und-tutestrun.md)*
