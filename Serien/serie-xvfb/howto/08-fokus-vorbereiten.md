# 08 — serie::fokusVorbereiten

```tcl
serie::fokusVorbereiten    ;# focus -force . ; update
event generate . <Control-s>
```

Steht in `_bootstrap.tcl` und gilt für jedes Display, nicht nur unter
Xvfb. Ausführlich: Serie tk-test.

## Demo

```bash
wish howto/08-fokus-vorbereiten.tcl
```
