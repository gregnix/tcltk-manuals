# Tests and tutestrun

## Suite

```bash
tclsh8.6 tests/all.tcl
tclsh8.6 tests/all.tcl -match 'tusettings-*'
```

Each `*.test` file runs in its own process; the runner passes through tcltest options such as
`-match`. The banner shows where `tclutils`
resolves to. Time limit per file: environment `TCLUTILS_TESTGRENZE`
(default 120 s). At the end the runner lists "Files with problems" or
reports `All test files passed`; exit code 1 on problems. If
`all.tcl` does not find the runner, it aborts with exit code 2 and
`all.tcl: tclutils::tutestrun not found (set TCLUTILS_TM)`.

Result for tclutils 0.68.0 under Linux (Xvfb):

| Run | Files | Tests | passed | skipped | failed |
|---|---|---|---|---|---|
| Tcl 8.6.14 with tls 1.7.22, Thread 2.8.9, tDOM 0.9.3 | 150 | 2355 | 2330 | 25 | 0 |
| Tcl 9.0.4 (built from source) with tls 2.0 (OpenSSL 3.0.13), Thread 3.0.6, tDOM 0.9.7 | 150 | 2355 | 2338 | 17 | 0 |

No test fails. Skipped tests depend
on missing packages or on the platform (constraints such as `tdbc`,
`haveTk`, `net`, `windows`).

---

## tutestrun

[tutestrun]{.index} **0.1** is the shared runner for tclutils,
tkutils and ctrlutils. **Not** in the umbrella — `tests/all.tcl` sources the
`.tm` from the tree under test (its own `lib/tm`, `$env(TCLUTILS_TM)` or
the sibling checkout); otherwise an old installation wins.

```tcl
exit [::tclutils::tutestrun::run $here {tclutils} \
    -limitvar TCLUTILS_TESTGRENZE -argv $argv]
```

What `run` does:

1. **Own trees first.** Only the own trees (`lib/tm` of the repo and
   the sibling checkouts of the named libs) are removed from
   `TCL8_6_TM_PATH` / `TCL9_0_TM_PATH` and inserted at the front in the runner.
   Foreign entries stay in place. Reason: if the tree already stands
   behind a `site-tcl` with the same version number,
   `tcl::tm::path add` has no effect, and the installed copy would be tested.
2. **Banner.** Where each lib resolves to — looked up without
   loading anything —, other versions alongside as `(also: <version>)`, set
   variables (`TCL8_6_TM_PATH`, `TCL9_0_TM_PATH`, `TCLLIBPATH`,
   `<LIB>_TM`) as `note: … is set: …`.
3. **Limit per file.** `-limit` seconds (default 120) or the value
   of the environment variable from `-limitvar`, if it is a positive integer;
   a hanging file is terminated (Unix: `kill -TERM`, then
   `-KILL`; Windows: `taskkill /T /F`).
4. **Invalid bytes.** Tcl 9 reads channels strictly: a byte that is invalid in the
   system encoding made the run stall until the limit.
   tutestrun replaces such bytes (`-profile replace`); Tcl 8.6 does not need
   this.
5. **Summary.** Failed tests, a missing tcltest total,
   a nonzero exit or hangs end up under "Files with problems".
   tcltest ends a file with 0 even on errors — the total line
   is what counts.

Options of `run`: `-argv`, `-limit`, `-limitvar`. Unknown options:
`{TCLUTILS TUTESTRUN OPTION <opt>}`. A test file started
directly without the runner remains exposed to the `site-tcl` problem.

---

## Checking the origin: tupkgfinder 0.2

The package database knows only one `ifneeded` per version. If the same
version lies twice on the paths, the second copy is not visible there.
[tupkgfinder]{.index} 0.2 therefore searches by itself:

- `candidates` — every copy of a package on module paths and
  `auto_path`, as a dict `{package version kind path}`.
- `shadows` — per package with more than one copy: which one is active, and
  for each copy a `status` (`active`, `same version`, `other
  version`). `duplicate` is 1 if a version is present twice.

```tcl
package require tclutils::tupkgfinder
foreach d [::tclutils::tupkgfinder::candidates -pattern tclutils::tunum] {
    puts "[dict get $d version] [dict get $d kind] [dict get $d path]"
}
foreach d [::tclutils::tupkgfinder::shadows -pattern tclutils::*] {
    if {[dict get $d duplicate]} { puts "doppelt: [dict get $d package]" }
}
```

Nothing is loaded in the process. The output is
`0.4 tm …/lib/tm/tclutils/tunum-0.4.tm`; `shadows` found no
duplicate copy, and `tclutils::tunum` was not loaded afterwards.
For packages with unregistered copies, `shadows` runs an
unsatisfiable `package require`; in doing so Tcl reads the
`pkgIndex.tcl` files but loads nothing.

`kind` is `tm` (path of the `.tm` file) or `pkgIndex` (path of the
`pkgIndex.tcl`; only literal `package ifneeded NAME VERSION` lines
are recognized). Wrong options throw `{TCLUTILS TUPKGFINDER OPTION}`,
for example `unknown option "-x" (-pattern, -tmpaths, -autopath)`.

---

## Windows

According to the CHANGELOG, the suite also runs under Windows since 0.64.0: no
`/dev/null` or Unix roots in fixtures; tests that need a CA bundle
are skipped without one (constraint `caOK`). In 0.65.0
the Windows tests `tutask` 2.8w/4.4w for `pipe` were added.

---

## Summary

- `tests/all.tcl` → tutestrun: own trees first, banner, limit.
- Source the runner from the tree, do not require it blindly.
- `tupkgfinder::shadows` finds duplicate copies.

---

*Next chapter: [Limits](100-grenzen.md)*
