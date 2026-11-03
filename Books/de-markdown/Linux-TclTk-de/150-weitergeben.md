# Weitergeben

## Einführung

Ein Tcl-Programm verlässt den eigenen Rechner auf drei Wegen: als
Skript für das Tcl des Zielrechners, als Systempaket (`.deb`, `.rpm`)
oder als eine einzige ausführbare Datei mit [zipfs]{.index}. Das Buch
*Ausliefern* beschreibt alle drei ausführlich,
mit Zipkits, Starkits und Installern. Dieses Kapitel nennt nur, was
unter Linux dabei auffällt: welches Tcl der Zielrechner hat, woran ein
Image hängt, und was für den Desktop dazugehört. Grundlage für zipfs ist
`serie-tcl9-app`, im Container vollständig nachgelaufen (18 von 18 OK,
`tclsh9.0` 9.0.4).

---

## Welches Tcl hat der Zielrechner?

Ein Skript braucht ein passendes Tcl auf dem Zielrechner. Unter Linux
ist das meist 8.6 aus dem Paket:

- Debian Stable (trixie): Tcl 8.6.16 und das Paket `tcl9.0` 9.0.1.
- Debian Testing (forky) und unstable: 8.6.18, `tcl9.0` 9.0.4 und
  `tcl9.1` 9.1.0.
- Ubuntu 24.04: 8.6.14. Im Container kennt `apt-cache policy` kein
  Paket `tcl9.0`.

Ein Programm, das Tcl 9 verlangt, läuft also auf den meisten
Linux-Rechnern nicht mit dem System-Tcl. Es bringt sein Tcl mit, oder
es bleibt 8.6-fähig. Für ein `.deb` mit `Depends: tcl9.0` gilt: Das
Paket muss es auf dem Zielsystem geben. *Ausliefern*, Kapitel *Linux:
deb und rpm*, rät deshalb, vorher `apt-cache policy tcl9.0 tcl8.6` auf
dem Ziel zu prüfen.

Ein Skript, das unter beiden Fassungen laufen soll, beachtet die
Unterschiede dieses Buches: Tilde (siehe
[Pfade, Umgebung, XDG](040-pfade-umgebung-xdg.md)), Kodierung der
Skripte ([Kodierung und Locale](060-kodierung-und-locale.md)),
Mausrad ([Maus, Tastatur, Zwischenablage](100-maus-tastatur-zwischenablage.md)).

---

## Ein Image mit zipfs mkimg

Tcl 9 kann ein Verzeichnis als ZIP an einen Interpreter hängen. Das
Ergebnis ist eine ausführbare Datei, die beim Start ihr Archiv unter
`//zipfs:/app` einhängt und `main.tcl` daraus ausführt
(`serie-tcl9-app`, Howto 06 und 07):

```tcl
zipfs mkimg app.bin app.vfs app.vfs "" [info nameofexecutable]
file attributes app.bin -permissions 0o755
```

Das vierte Argument `""` ist das Passwort. Es muss stehen, wenn als
fünftes die Basis folgt, sonst landet der Pfad im Passwortfeld.

Container-Prüfung mit einem `main.tcl`, das seine Lage druckt, gebaut
auf `/opt/tcl9/bin/tclsh9.0`:

```text
Größe     16374 Byte
lib       //zipfs:/lib/tcl/tcl_library
mounts    //zipfs:/lib/tcl  /opt/tcl9/lib/libtcl9.0.so
          //zipfs:/app      …/app.bin
script    //zipfs:/app/main.tcl
```

16 KB, weil das Image nur das kleine `tclsh9.0` und das eigene Archiv
enthält. Die Tcl-Bibliothek steckt in `libtcl9.0.so` und wird von dort
eingehängt. Das Image hängt deshalb an genau dieser Datei:

```bash
ldd app.bin | grep tcl
#   libtcl9.0.so => /opt/tcl9/lib/libtcl9.0.so
readelf -d /opt/tcl9/bin/tclsh9.0 | grep RUNPATH
#   Library runpath: [/opt/tcl9/lib]
```

Auf einem Rechner ohne `/opt/tcl9/lib/libtcl9.0.so` startet es nicht.
Das ist nicht auf einem zweiten Rechner geprüft, folgt aber aus
`RUNPATH` und `NEEDED`. Ein solches Image ist zum Üben gut, zum
Weitergeben nicht.

`serie-tcl9-app` betont für statische Basen das Gegenteil: Liegt die
Tcl-Bibliothek im Archiv der ausführbaren Datei selbst, ersetzt
`mkimg` dieses Archiv, und `tcl_library` muss ins eigene `app.vfs`
kopiert werden (Howto 15). Beim dynamischen Quellbau unter `/opt/tcl9`
liegt sie in `libtcl9.0.so` und bleibt erhalten. Welche Lage vorliegt,
zeigt `zipfs mount` in der Basis.

Für GUI-Programme ist die Basis `wish9.0`, nicht `tclsh9.0`
(Howto 09). Das Image hängt dann zusätzlich an `libtcl9tk9.0.so` und
an den X-Bibliotheken des Zielrechners (siehe
[Tk bauen: Abhängigkeiten](140-tk-bauen-abhaengigkeiten.md)).

---

## Zipkit: statische Basis

Zum Weitergeben braucht das Image eine Basis, die nicht auf
`/opt/tcl9` zeigt: ein statisch gebautes `tclsh` oder `wish` mit
angehängter Tcl-Bibliothek, ein [Zipkit]{.index} (`serie-tcl9-app`,
Howto 13). Wie man es baut oder bezieht (BAWT, eigener Bau mit
`--disable-shared`), steht in *Ausliefern*, Kapitel *Zipkits bauen und
füllen*, und in *Tcl/Tk 9.0 bauen*, Kapitel *Statisch bauen*.

Auch ein statisches Tk hängt an den X-Bibliotheken des Systems (`libX11`,
`libXft`, `libfontconfig`). Die gibt es auf jedem Linux-Desktop, aber
nicht auf jedem Server. Und es hängt an der C-Bibliothek: Der Quellbau
im Container verlangt Symbole bis `GLIBC_2.38` (`objdump -T`), Ubuntu
24.04 hat 2.39. Auf einem Ziel mit älterer glibc startet er nicht. Wer
für viele Distributionen baut, baut auf der ältesten. Das ist nicht
geprüft.

Weil ein Image nur Basis plus ZIP ist, lässt sich derselbe ZIP-Inhalt
mit einer anderen Basis für eine andere Plattform zusammensetzen,
solange er keine `.so` enthält (Howto 16 und 17):

```sh
cat zipkit-linux-x86_64 app.zip > app
chmod +x app
```

---

## Desktop: Starter und Symbol

Ein Programm für den Desktop braucht neben der ausführbaren Datei:

- eine `.desktop`-Datei in `~/.local/share/applications/` oder
  `/usr/share/applications/`,
- ein Symbol im Symbolthema, etwa
  `/usr/share/icons/hicolor/48x48/apps/meineapp.png`,
- eine Fensterklasse, die zu `StartupWMClass` passt.

Alle drei beschreibt
[Native Dialoge und Desktop-Integration](110-dialoge-und-desktop.md).
Bei einem Image nimmt Tk den Namen nicht von der Datei, sondern vom
Startskript im Archiv. Container-Prüfung, Image `meineapp.bin` auf Basis
`wish9.0`: `tk appname` ist `main.tcl`, die Klasse `Main.tcl`. Jedes
Image mit `main.tcl` heißt also für den Fenstermanager gleich. Mit
`./meineapp.bin -name meineapp` wird daraus `Meineapp`. Das `-name`
gehört deshalb in die `Exec`-Zeile. Bei einer `wish`-Basis ist Tk
schon geladen, wenn `main.tcl` läuft; dort hilft nur die Befehlszeile.
Bei einer `tclsh`-Basis kann `main.tcl` es vor `package require Tk` in
`::argv` setzen (siehe
[X11, Fenstermanager und Wayland](080-x11-fenstermanager-wayland.md)).

---

## Zusammenfassung

- Ziel-Tcl ist meist 8.6. Tcl 9 gibt es als Paket in Debian Stable
  (`tcl9.0` 9.0.1), Testing und unstable (`tcl9.0` 9.0.4, `tcl9.1`
  9.1.0); Ubuntu 24.04 hat es nicht.
- `zipfs mkimg` auf einem dynamischen `tclsh9.0` ergibt ein kleines
  Image, das an `/opt/tcl9/lib/libtcl9.0.so` hängt. Zum Weitergeben
  eine statische Basis (Zipkit).
- Auch statisch bleiben X-Bibliotheken und glibc Sache des Zielrechners.
- Zum Desktop gehören `.desktop`, Symbol und passende Fensterklasse.
- Einzelheiten: *Ausliefern*.

---

*Nächstes Kapitel: [FAQ](160-faq.md)*
