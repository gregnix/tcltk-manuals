# 19 — Xvfb ohne Dekorator

Auf einem frischen Xvfb ohne Fenstermanager gibt es keinen Rahmen:
`rooty - gy` ist 0, `wm frame` ist numerisch gleich `winfo id`. Die
Demo misst das auf einem **eigenen** Xvfb (`serie::aufEigenemXvfb`),
nicht auf dem Display, auf dem sie selbst läuft. SKIP, wenn
`xvfb-run` fehlt.

## Demo

```bash
wish howto/19-xvfb-deko.tcl
```
