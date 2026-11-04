# 16 — was der Test herstellt

Was die Umgebung beisteuert (Fokus, Titelleiste), darf der Test nicht
annehmen. `focus -force`, `winfo rooty`, `update` — dann gilt der Test
unter Xvfb ohne WM und mit openbox (gemessen). Unter Windows nicht
gemessen.

## Demo

```bash
wish howto/16-test-stellt-her.tcl
```
