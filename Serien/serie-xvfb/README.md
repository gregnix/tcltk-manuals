# Serie: Xvfb / GUI-Tests ohne Dekorator

Howto-Serie zu **Xvfb**, Display und dem, was ein GUI-Test selbst
herstellen muss. 20 Howtos.

Xvfb ist ein virtueller X-Server **ohne Fenstermanager**. `ismapped`
und `focus -force` gehen dort. Titelleiste, Iconify, echte Rahmenlage
nicht. Ohne WM bekommt kein Fenster von selbst den Fokus — eine
erzeugte Taste kommt erst nach `focus -force` an. Mit WM gibt dieser
dem Fenster nach `update` meist den Fokus; ein Test verlässt sich
trotzdem nicht darauf und setzt ihn selbst.

Ohne Paket `xvfb` / `xvfb-run`: Howtos 17–20 **SKIP**. 01–16 laufen
auf jedem X11-Display mit Tk; 10 (Iconify) braucht einen
Fenstermanager, sonst SKIP. Auf Windows und macOS melden die
X11-Howtos SKIP.

`serie::brauchtWM`, `serie::brauchtRahmen` und `serie::fokusVorbereiten`
stehen in `_bootstrap.tcl`.

Gemessen mit Tcl/Tk 8.6.14 und 9.0.4 unter Xvfb, ohne Fenstermanager
und mit openbox.

## Voraussetzungen

- Tcl/Tk 8.6+ (`wish`), X11-Display
- optional: `Xvfb` / `xvfb-run` (Debian-Paket `xvfb`), `openbox`

## Start

```bash
wish howto/01-erste-schritte.tcl
./run-all.tcl
# virtuelles Display ohne Fenstermanager:
xvfb-run -a ./run-all.tcl
# virtuelles Display mit Fenstermanager:
xvfb-run -a sh -c 'openbox >/dev/null 2>&1 & sleep 1; ./run-all.tcl'
```

Ein einzelnes Howto unter `xvfb-run` braucht `SERIES_AUTO=1`, sonst
bleibt das Fenster offen und `xvfb-run` kehrt nicht zurück (Howto 18).

Buch: *Tcl/Tk unter Linux* ([Markdown](../../Books/de-markdown/Linux-TclTk-de/), [PDF](../../Books/de-pdf/Linux-TclTk-de.pdf)).

Verwandte Serie: `serie-linux/`.
