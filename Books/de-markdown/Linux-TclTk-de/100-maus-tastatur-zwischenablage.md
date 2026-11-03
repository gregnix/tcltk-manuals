# Maus, Tastatur, Zwischenablage

## Einführung

Drei Stellen, an denen Linux-Code anders aussieht als Code für Windows
oder macOS: das Mausrad, das unter X11 als Maustaste ankommt; die
Modifier, deren Namen unter X11 keine feste Taste bedeuten; und die
zwei Zwischenablagen PRIMARY und CLIPBOARD. Beim Mausrad und bei
`Command` haben sich Tk 8.6 und Tk 9 verschieden entschieden.

Alle Werte dieses Kapitels sind im Container mit
`beispiele/rad-und-tasten.tcl` und `beispiele/auswahl-probe.tcl`
ermittelt. Die Skripte schicken mit `xdotool` echte X-Ereignisse an das
eigene Fenster. Die Tastaturbelegung des Xvfb ist die Vorgabe `pc105`,
`us`.

---

## Das Mausrad

X11 kennt kein Rad-Ereignis. Der X-Server meldet jede Raste als Druck
und Loslassen einer Maustaste: 4 nach oben, 5 nach unten, 6 und 7 für
das seitliche Kippen. Tk 8.6 reicht das so weiter. Tk 9 übersetzt es
in [`MouseWheel`]{.index} wie unter Windows und macOS (Quelltext
`tkEvent.c`: Tasten 4 bis 7 werden beim Drücken zu `MouseWheelEvent`
mit `%D` gleich ±120, 6 und 7 bekommen zusätzlich Shift; das Loslassen
wird verworfen).

Container-Prüfung:

| X-Taste | Tk 8.6.14 | Tk 9.0.4 |
|---------|-----------|----------|
| 4 (hoch) | `<Button-4>`, `%b`=4 | `<MouseWheel>`, `%D`=120 |
| 5 (runter) | `<Button-5>`, `%b`=5 | `<MouseWheel>`, `%D`=-120 |
| 6 (links) | `<Button-4>`, `%s`=1 (Shift) | `<Shift-MouseWheel>`, `%D`=120 |
| 7 (rechts) | `<Button-5>`, `%s`=1 (Shift) | `<Shift-MouseWheel>`, `%D`=-120 |
| 8 (Seitentaste „Zurück“) | `<ButtonPress>`, `%b`=8 | **`<Button-4>`**, `%b`=8 |
| 9 (Seitentaste „Vor“) | `<ButtonPress>`, `%b`=9 | **`<Button-5>`**, `%b`=9 |

Die letzten zwei Zeilen sind die Falle. Tk 9 hat die Nummern 4 und 5
freigemacht und an die Tasten 8 und 9 vergeben. Alter Code mit

```tcl
bind .c <Button-4> {.c yview scroll -1 units}
bind .c <Button-5> {.c yview scroll  1 units}
```

scrollt unter Tk 9 nicht mehr mit dem Rad, sondern mit den
Seitentasten einer Maus. Ein `event generate .l <Button-4>` liefert
unter Tk 9 ebenfalls `%b`=8. Tk 8.6 lehnt `<Button-8>` dagegen ab
(„bad button number "8"“).

Die Klassenbindungen von `Text` (`bind Text`) zeigen denselben
Unterschied:

```text
8.6.14  <Shift-Button-5> <Shift-Button-4>
        <Button-5> <Button-4>
        <Shift-MouseWheel> <MouseWheel>
9.0.4   <Shift-Alt-MouseWheel> <Shift-MouseWheel>
        <Alt-MouseWheel> <MouseWheel>
```

Eigener Code für beide Fassungen:

```tcl
proc rad {w delta} {
    $w yview scroll [expr {$delta > 0 ? -1 : 1}] units
}
bind .c <MouseWheel> {rad %W %D}
if {[tk windowingsystem] eq "x11"
        && ![package vsatisfies [package provide Tk] 9-]} {
    bind .c <Button-4> {rad %W 120}
    bind .c <Button-5> {rad %W -120}
}
```

`%D` ist unter X11 immer ein Vielfaches von 120. Feinere Werte, wie
sie Touchpads unter Windows und macOS liefern, kommen unter X11 nicht
an. Ob ein Touchpad unter Xfce glatte Werte erzeugt, ist nicht
geprüft.

---

## Modifier und Tasten

X11 hat acht Modifier-Bits: Shift, Lock, Control und Mod1 bis Mod5.
Welche Taste welches Bit setzt, legt die Tastaturbelegung fest
(`xmodmap -pm`). Im Container: Mod1 trägt Alt_L, Alt_R und Meta_L,
Mod2 Num_Lock, Mod4 Super_L und Super_R, Mod5 ISO_Level3_Shift
(AltGr).

Tk kennt dazu Namen, die Plattformen verbinden sollen. Container-Prüfung,
jede Bindung einzeln gesetzt:

| Bindung | 8.6.14 greift bei | 9.0.4 greift bei |
|---------|-------------------|------------------|
| `<Control-c>` | Strg+C | Strg+C |
| `<Alt-c>` | Alt+C | Alt+C |
| `<Mod1-c>` | Alt+C | Alt+C |
| `<Mod4-c>` | Super+C | Super+C |
| `<Meta-c>` | nichts | nichts |
| `<Command-c>` | **Alt+C** | **nichts** |
| `<Option-c>` | nichts | **Alt+C** |
| `<Super-c>` | Fehler beim `bind` | Fehler beim `bind` |

Unter Tk 8.6 ist [`Command`]{.index} unter X11 dasselbe wie `Mod1`. Unter
Tk 9.0.4 ist es dasselbe wie `Meta` (Quelltext `tkBind.c`), und `Option`
ist `Alt`. Welches Bit `Meta` ist, ermittelt Tk aus der Belegung: das
Bit, auf dem eine Taste mit dem Keysym `Meta_L` oder `Meta_R` in der
ersten Ebene liegt (Quelltext `tkUnixKey.c`). Im Container liegt
`Meta_L` auf Keycode 205, und dessen erste Ebene ist `NoSymbol`:

```text
$ xmodmap -pke | grep 'keycode 205'
keycode 205 = NoSymbol Meta_L NoSymbol Meta_L
```

Tk findet also kein Meta-Bit. Dann greift `Meta`, und damit `Command`,
bei keiner Taste.

Das Debian-Buch schreibt im Kapitel *Tcl unter Linux*: „Eine Bindung
`<Command-c>` aus einem Mac-Programm reagiert unter Linux also auf
Alt+C.“ Das gilt für Tk 8.6, geprüft mit 8.6.14. Unter Tk 9.0.4
reagiert sie im Container auf keine Taste. Auf dem Arbeitsplatz des
Autors (Xfce, deutsche Belegung) ebenso: `xdotool` sendet Alt+C an ein
Fenster mit nur `<Command-c>`. 8.6.18 löst aus und speichert die
Bindung als `<Mod1-Key-c>`, 9.0.4 und 9.1.0 bleiben stumm und speichern
`<Meta-Key-c>`. `Meta_L` liegt dort wie im Container auf Keycode 205
mit `NoSymbol` in der ersten Ebene. Die Regel des
Debian-Buchs bleibt richtig: `Command` nur unter `aqua` binden, unter
`x11` `Control`.

```tcl
set mod [expr {[tk windowingsystem] eq "aqua" ? "Command" : "Control"}]
event add <<Speichern>> <$mod-s>
bind . <<Speichern>> speichern
```

Die Super-Taste (Windows-Taste) heißt in `bind` `Mod4`. Der Desktop
fängt nur die Super-Kürzel ab, die er selbst belegt hat. Auf dem
Arbeitsplatz (Xfce) kommt Super+C bei Tk an, als `<Mod4-c>` mit dem
Keysym `Super_L`; die Sitzung belegt dort unter anderem Super+E,
Super+P und Super+R. Welche belegt sind, zeigt
`xfconf-query -c xfce4-keyboard-shortcuts -l -v`.

Die Taste selbst meldet Tk mit ihrem Keysym (`%K`): `Control_L`,
`Alt_L`, `Super_L`. Beim Drücken eines Modifiers ist `%s` noch 0, das
Bit erscheint erst bei der nächsten Taste.

---

## Zwei Zwischenablagen

X11 hat mehrere „Auswahlen“ (selections). Zwei sind für Programme
wichtig:

- [`PRIMARY`]{.index}: der zuletzt markierte Text. Er wird ohne
  Kopierbefehl gesetzt und mit der mittleren Maustaste eingefügt.
- `CLIPBOARD`: die Zwischenablage im Sinn von Windows und macOS.
  Gesetzt mit Strg+C oder `<<Copy>>`, eingefügt mit Strg+V oder
  `<<Paste>>`.

`clipboard` in Tk meint CLIPBOARD, `selection` ohne Option meint
PRIMARY. Container-Prüfung, 8.6.14 und 9.0.4 gleich, Text
„Auswahl-Ü“ im Entry markiert:

```text
PRIMARY von innen:    Auswahl-Ü
PRIMARY über xclip:   Auswahl-Ü
CLIPBOARD vorher:     leer (CLIPBOARD selection doesn't exist or form "STRING" not defined)
CLIPBOARD nachher:    Auswahl-Ü        (nach event generate .e <<Copy>>)
CLIPBOARD über xclip: Auswahl-Ü
TARGETS:              MULTIPLE TARGETS TIMESTAMP TK_APPLICATION TK_WINDOW UTF8_STRING STRING
```

Markieren allein setzt PRIMARY, nicht CLIPBOARD. Tk bietet beide als
`UTF8_STRING` und `STRING` an, Umlaute kommen also bei anderen
Programmen an.

Der wichtigste Unterschied zu Windows: Eine X11-Auswahl ist kein
gespeicherter Inhalt, sondern ein Versprechen des Programms, das sie
besitzt. Endet das Programm, ist der Inhalt weg. Im Container lieferte
`xclip -o -selection clipboard` nach dem Ende von `wish` nur
`Error: target STRING not available`. Ein Zwischenablage-Verwalter wie
`xfce4-clipman` übernimmt den Inhalt beim Kopieren und hält ihn fest,
aber nur, wenn es läuft. Auf dem Arbeitsplatz ist das Paket 1.6.6-1
installiert, ein Prozess läuft nicht; nach dem Ende von `wish` meldet
`xclip` dort dasselbe wie im Container. Installiert heißt also nicht
gestartet: `pgrep xfce4-clipman`.

`serie-linux` (Howto 11) zeigt: PRIMARY existiert erst nach einer
X11-Selektion, `selection get -selection PRIMARY` schlägt sonst fehl.
Code fragt deshalb mit `catch`:

```tcl
if {[catch {selection get -selection PRIMARY} text]} {
    set text ""
}
```

Wer die Auswahl eines anderen Programms mit einem Werkzeug wie
`xclip` liest, darf das nicht mit blockierendem `exec` tun, solange das
eigene Programm Besitzer ist. Das verklemmt beide, siehe
[exec, xdg-open, Prozesse](070-exec-und-prozesse.md).

### Virtuelle Ereignisse

Container-Prüfung, `event info`:

| Ereignis | 8.6.14 | 9.0.4 zusätzlich |
|----------|--------|------------------|
| `<<Copy>>` | `<Control-Key-c> <Key-F16> <Control-Lock-Key-C> <Meta-Key-w> <Lock-Meta-Key-W> <Control-Key-Insert>` | `<Key-XF86Copy>` |
| `<<Paste>>` | `<Control-Key-v> <Key-F18> <Control-Lock-Key-V> <Control-Key-y> <Control-Lock-Key-Y> <Shift-Key-Insert>` | `<Key-XF86Paste>` |
| `<<PasteSelection>>` | `<ButtonRelease-2>` | wie 8.6 |

`<<PasteSelection>>` fügt PRIMARY ein, nicht CLIPBOARD. Wer einem
Text-Widget das mittlere Einfügen abgewöhnen will, löscht die Bindung
für diese eine Klasse:

```tcl
bind Text <<PasteSelection>> {break}
```

---

## Zusammenfassung

- Mausrad: Tk 8.6 unter X11 `<Button-4>`/`<Button-5>`, Tk 9 überall
  `<MouseWheel>`. Unter Tk 9 sind `<Button-4>`/`<Button-5>` die
  Seitentasten 8 und 9.
- `Command` ist unter X11 in 8.6 Alt, in 9.0 und 9.1 keine Taste
  (Container und Xfce). Unter `x11` `Control` binden.
- Super heißt `Mod4`.
- PRIMARY durch Markieren, CLIPBOARD durch Kopieren. Beide verschwinden
  mit dem Programm, wenn kein Verwalter sie übernimmt.

---

*Nächstes Kapitel: [Native Dialoge und Desktop-Integration](110-dialoge-und-desktop.md)*
