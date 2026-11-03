# Was der Test selbst herstellt

## Einführung

Auf dem Arbeitsplatz gibt der Fenstermanager einem neuen Fenster den
Fokus, hängt es in einen Rahmen und kann es verkleinern. Unter Xvfb
ohne Fenstermanager tut das niemand. Ein Test, der sich auf eines davon
verlässt, ist auf dem Arbeitsplatz grün und in der Pipeline rot, oder
umgekehrt. Die Regel aus `serie-xvfb` (Howto 16): Was die Umgebung
beisteuert, darf der Test nicht annehmen. Er stellt es selbst her, mit
`update`, `focus -force` und `winfo rooty`. Dann gilt er unter Xvfb ohne
Fenstermanager und mit openbox gleich.

Alle Aussagen in diesem Kapitel sind in `serie-xvfb` mit Tcl/Tk 8.6.14
und 9.0.4 geprüft, ohne Fenstermanager und mit openbox. Die Werte ohne
Fenstermanager hat die Container-Prüfung mit `beispiele/wm-probe.tcl`
bestätigt. Ausnahme ist der Xfce-Fall im Abschnitt *Der Rahmen kommt
spät*; er stammt aus Testläufen auf einem Arbeitsplatz.

---

## Übersicht

| | Xvfb ohne Fenstermanager | Xvfb mit openbox |
|--|--------------------------|------------------|
| `winfo manager .` | `wm` | `wm` |
| `wm frame .` gegen `winfo id .` | gleich | verschieden |
| `winfo ismapped`, `winfo viewable` nach `update` | 1 | 1 |
| `focus -force` | wirkt | wirkt |
| Fokus nach `update` ohne `focus -force` | leer | `.` |
| Titelleiste `rooty - gy` | 0 | 20 |
| `wm iconify` | bleibt `normal`, rund 2 s | `iconic` |
| lokaler `grab` | wirkt | wirkt |

---

## Mappen: erst update

Ein Fenster, das das Skript eben erzeugt hat, ist noch nicht auf dem
Bildschirm. Gemappt wird es beim nächsten `update` (`serie-xvfb`,
Howto 03 und 14):

```tcl
toplevel .t
winfo ismapped .t        ;# 0
update
winfo ismapped .t        ;# 1, auch ohne Fenstermanager
```

[`winfo viewable`]{.index} verlangt zusätzlich, dass alle Vorfahren
gemappt sind. Nach `wm withdraw .` ist ein Frame in `.` nicht
`viewable`, auch wenn er selbst gemappt ist (Howto 15).

---

## Tasten erzeugen: Fokus herstellen

`event generate` mit einem Tastenereignis geht an das Widget mit dem
**Tastaturfokus**, nicht an das Fenster, das man nennt (Howto 07):

```tcl
entry .e1; entry .e2; pack .e1 .e2
update
focus -force .e1
update
event generate .e2 <Key-x>      ;# landet bei .e1
```

Daraus folgen drei Fallen, alle geprüft ohne Fenstermanager und mit
openbox:

1. **Vor `update`:** Ein neues Toplevel ist nicht gemappt und hat
   keinen Fokus. `event generate .t <Escape>` kommt nicht an
   (Howto 05). Das ist kein Xvfb-Unterschied, es gilt überall.
2. **Zurückgezogen:** Ein Fenster nach `wm withdraw` bekommt die Taste
   nicht, auch nicht nach `focus -force .`. Erst `wm deiconify`,
   `update` und `focus -force` (Howto 06).
3. **Ohne Fenstermanager:** Nach `update` ist `focus` leer. Niemand
   vergibt den Fokus. Eine erzeugte Taste kommt erst nach
   `focus -force` an (Howto 07 und 20). Mit openbox hat `.` nach
   `update` meist schon den Fokus. Der Test wartet trotzdem nicht
   darauf.

Das Muster für jeden Tastentest steht in der Serie als
`serie::fokusVorbereiten`:

```tcl
proc fokusVorbereiten {{w .}} {
    update
    focus -force $w
    update
}
fokusVorbereiten .
event generate . <Control-s>
```

Container-Prüfung mit `beispiele/wm-probe.tcl`: Taste ohne
`focus -force` 0-mal angekommen, mit `focus -force` 1-mal, unter 8.6.14
und 9.0.4.

---

## Grab

Ein lokaler [`grab`]{.index} ist Tk-intern und braucht keinen
Fenstermanager (Howto 11). Die Serie macht das Fenster vorher
sichtbar:

```tcl
toplevel .dlg
update
grab .dlg
grab current            ;# .dlg
```

Ein Fehler kommt ohne `update` nicht. Container-Prüfung, 8.6.14 und
9.0.4: `grab .d` auf ein frisch erzeugtes, noch nicht sichtbares
Toplevel kehrt ohne Fehler zurück, `grab current` ist `.d`,
`grab status .d` ist `local`; dasselbe nach `wm withdraw .d`. Ein
lokaler Grab auf ein unsichtbares Fenster sperrt also still die übrige
Oberfläche. Ein globaler Grab (`grab -global`) hängt am X-Server. Auf
dem Arbeitsplatz (Xfce, 8.6.18, 9.0.4, 9.1.0) kehrt er ohne Fehler
zurück, `grab status` ist `global`, `grab release` hebt ihn auf; die
Sitzung blieb bedienbar. Im Test nur mit `grab release` im `finally`.

---

## Lage von Dialogen

`wm geometry +x+y` setzt die **Rahmenecke** eines Fensters,
`winfo rootx/rooty` liefert die Ecke der **Clientfläche** (Howto 04
und 12). Ein Dialog, der direkt unter der Titelleiste des
Hauptfensters liegen soll:

```tcl
set x [winfo rootx .]
set y [winfo rooty .]
wm geometry .dlg +$x+$y
```

Der Rahmen des Dialogs beginnt dann an der Oberkante der Clientfläche
des Hauptfensters; seine eigene Clientfläche liegt um die eigene
Titelleiste tiefer. Ohne Fenstermanager ist
`winfo rooty .dlg` gleich `y`, unter openbox `y + 20`.

Eine feste Zahl ist immer falsch irgendwo (Howto 13). Gemessene
Titelleisten: ohne Fenstermanager 0, openbox 20, Xfce auf dem
Arbeitsplatz des Autors 29. Code wie

```tcl
wm geometry .dlg +[expr {$gx}]+[expr {$gy + 80}]
```

stimmt nur, wenn die Titelleiste zufällig 80 Pixel hat. Die Demo der
Serie misst den Rahmen und prüft, dass 80 hier falsch wäre.

`scan [wm geometry .] {%dx%d%[+-]%d%[+-]%d}` liest auch die Form
`-X-Y`. Dann zählt X von rechts, und die Rechnung oben gilt nicht.
Vorher mit `+X+Y` setzen.

### Der Rahmen kommt spät

Wann der Fenstermanager seinen Rahmen anlegt, hängt vom
Fenstermanager ab. Unter Xvfb mit openbox ist er bei einem einfachen
Toplevel schon da, wenn das erste `update` nach `wm geometry`
zurückkehrt; das gilt auch für ein transientes. Ein Probeskript mit
einem Dialog bei `+300+250` lieferte mit 8.6.14 und 9.0.4:

| Zeitpunkt | ohne Fenstermanager | openbox |
|--|--|--|
| nach `update` | `winfo rootx/rooty` 300,250 | 301,270 |
| 10 bis 1000 ms danach | unverändert | unverändert |
| `<Configure>` mit Versatz | keines | vor `<Map>`, nach 17 bis 28 ms |

Auf einem Xfce-Arbeitsplatz mit wish 9.1.0 kam der Versatz später. Ein
Dialog, den der Code nach 100 ms ein einziges Mal korrigiert hatte,
lag am Ende 5 Pixel rechts und 28 bis 29 Pixel unter dem Ziel. Das
geschah nicht in jedem Lauf: in beiden Läufen der ganzen Suite, beim
Einzellauf der Testdatei im dritten von drei. Unter Xvfb, mit und ohne
openbox, kam es nie vor.

Für den Code heißt das: Eine Korrektur nach fester Wartezeit reicht
nicht. Er beobachtet `<Configure>` am Dialog eine Weile, etwa eine
Sekunde nach dem Erscheinen, und korrigiert jedes Mal kurz danach.
Dabei rechnet er von der Rahmenecke aus `wm geometry` aus, nicht von
`winfo rootx`; sonst schießt die Korrektur ohne Rahmen über das Ziel
hinaus.

Für den Test heißt das: Unter Xvfb tritt der Fall nicht von selbst
auf. Der Test stellt ihn her und verschiebt den Dialog nach dem
Erscheinen selbst, ausgehend von der Rahmenecke:

```tcl
after 300 {
    regexp {\+(-?\d+)\+(-?\d+)$} [wm geometry .d] -> fx fy
    wm geometry .d +[expr {$fx + 5}]+[expr {$fy + 29}]
}
```

Wer hier `winfo rootx` statt der Rahmenecke nimmt, verschiebt unter
openbox um den Rahmen zusätzlich, im Probelauf 6 und 49 statt 5 und
29 Pixel. Beim mittigen transienten Dialog aus dem nächsten Abschnitt
ergibt auch die Rahmenecke 6 und 49, weil `wm geometry` dort nicht
stimmt. Einem Test, der nur prüft, dass die Korrektur greift, schadet
das nicht; einer, der den Versatz genau vergleicht, setzt den Dialog
vorher nicht genau mittig oder nicht transient.

`beispiele/spaeter-rahmen.tcl` zeigt beides nebeneinander. Mit 8.6.14
und 9.0.4, ohne Fenstermanager und mit openbox, war das Ergebnis
gleich, ebenso auf lxpro unter Xvfb ohne Fenstermanager mit 8.6.18,
9.0.4 und 9.1.0:

```text
einmal     Abstand der Mitten: 5,29
beobachten Abstand der Mitten: 0,0
```

### openbox setzt mittige Dialoge selbst

Eine Ausnahme zeigte sich unter openbox bei einem transienten Dialog,
den das Programm genau mittig über die Clientfläche des Elternfensters
setzt. Elternfenster `.p` mit `wm geometry .p 800x500+500+300`, Dialog
418×92 Pixel, transient zu `.p`; abgelesen 50 ms nach dem Setzen, mit
8.6.14 und 9.0.4:

| verlangte Rahmenecke | `wm geometry` | Rahmen laut `xwininfo` | Clientfläche |
|--|--|--|--|
| +692+524 (mittig) | +692+524 | 691,504 | 692,524 |
| +680+524 | +680+524 | 680,524 | 681,544 |
| +692+524, nicht transient | +692+524 | nicht abgelesen | 693,544 |

Im ersten Fall liegt der Rahmen mittig über dem Rahmen von `.p`, nicht
an der verlangten Stelle. Offenbar setzt openbox einen transienten
Dialog, der mittig verlangt wird, selbst mittig. Die Clientfläche liegt
dann sofort am Ziel. `wm geometry` meldet aber weiter die verlangte
Lage, nach 950 ms noch immer; die Rahmenecke daraus ist um 1 und 20
Pixel falsch. Erst nachdem das Programm die Lage selbst wieder setzt,
stimmen die Werte wieder.

---

## Tests, die einen Fenstermanager brauchen

Iconify, echte Rahmenlage und Fokuswechsel durch den Fenstermanager
lassen sich ohne ihn nicht prüfen. Solche Tests melden SKIP, wenn
keiner läuft. Die Erkennung (Howto 09) steht in
[X11, Fenstermanager und Wayland](080-x11-fenstermanager-wayland.md):
`wm frame` gegen `winfo id`, sonst eine Iconify-Probe.

In der Serie heißen die Wächter `serie::brauchtWM` (irgendein
Fenstermanager) und `serie::brauchtRahmen` (ein reparentierender). Die
Iconify-Probe kostet ohne Fenstermanager rund zwei Sekunden, weil Tk
auf eine Zustandsänderung wartet (Container: 2002 und 2003 ms). Die
Serie lässt sich das Ergebnis deshalb über `SERIE_WM` vorgeben:

```bash
SERIE_WM=0 xvfb-run -a wish9.0 run-all.tcl
```

Für Tests mit Fenstermanager startet `xvfb-run` openbox vorab, siehe
[GUI-Tests mit Xvfb](130-gui-tests-xvfb.md). Mit xfwm4 unter Xvfb sind
die Howtos nicht gelaufen.

Unter Windows und macOS gibt es immer einen Fenstermanager. Dort
skippt nichts; die X11-spezifischen Howtos melden SKIP, weil
`tk windowingsystem` nicht `x11` ist. Unter Windows sind die Howtos
nicht ausprobiert.

---

## Zusammenfassung

- `update` vor jeder Prüfung von Sichtbarkeit, Lage oder Fokus.
- Erzeugte Tasten gehen an das Fokus-Widget. `focus -force`, dann
  `update`, dann `event generate`.
- Lokaler `grab` braucht nur ein sichtbares Fenster.
- Dialoglage aus `winfo rooty`, nie aus `wm geometry` plus fester Zahl.
- Ein Rahmen kann nach dem Mappen kommen. `<Configure>` eine Weile
  beobachten; im Test die späte Verschiebung selbst erzeugen.
- openbox setzt einen mittig verlangten transienten Dialog selbst;
  `wm geometry` meldet dann nicht die Rahmenecke.
- Iconify und Rahmen nur mit Fenstermanager; ohne ihn SKIP,
  vorgegeben über `SERIE_WM`.

---

*Nächstes Kapitel: [Tk bauen: Abhängigkeiten](140-tk-bauen-abhaengigkeiten.md)*
