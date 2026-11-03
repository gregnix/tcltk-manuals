# Tk bauen: Abhängigkeiten

## Einführung

Wer Tcl/Tk 9 unter Linux selbst baut, braucht einen Übersetzer und die
X11-Entwicklungspakete. Den Bau selbst, mit allen Schaltern, beschreiben
*Tcl/Tk 9.0 bauen* und *Tcl/Tk 9.1 bauen*. Dieses Kapitel prüft nur,
welche Bibliotheken ein Linux-Tk tatsächlich braucht und mitbringt,
und wo das Debian-Paket von einem Quellbau abweicht. Grundlage ist
`serie-tcltk-bauen`, geprüft auf Debian forky (September 2026)
mit `tclsh8.6` (8.6.18) und `tclsh9.0` (9.0.4), je 12 von 12 Howtos
bestanden. Im Container lief die Serie unter 8.6.14 mit 11 OK und
1 SKIP (Howto 10: Ubuntu hat Itcl für 8.6 nicht installiert), unter
9.0.4 mit 11 OK und 1 FAIL; der FAIL steht unten.

---

## Was Debian zum Bau von Tk braucht

`apt-cache showsrc tk8.6` nennt als Build-Depends vier
X-Entwicklungspakete und `tcl8.6-dev` (Howto 02):

```text
libx11-dev libxss-dev libxext-dev libxft-dev tcl8.6-dev
```

Dazu die Werkzeugkette aus `build-essential`. `libxft-dev` zieht
fontconfig und freetype nach. Für freetype heißt das Paket heute
`libfreetype-dev`; `libfreetype6-dev` ist nur noch ein Übergangspaket.

Ein Quellbau von Tk 9 braucht laut *Tcl/Tk 9.0 bauen* (ausprobiert auf
Ubuntu 24.04) zusätzlich [`libxi-dev`]{.index}: `configure` hing dort
an `X11/extensions/XInput2.h`. Debian listet `libxi-dev` für `tk8.6`
nicht, und keine gelinkte Tk-Bibliothek braucht `libXi` (siehe unten).
Im Quelltext von Tk 9.0.4 kommt `XInput2` nicht vor
(Container-Suche über alle Dateien). Wo der Bedarf herkam, ist nicht
geklärt. Die Empfehlung der Serie bleibt: Für einen Selbstbau von Tk 9
das Paket hinstellen; es schadet nicht, und `configure` bricht ohne
den Kopf nicht spät ab.

---

## TK_LIBS und TCL_LIBS

Was eine Installation linkt, steht in `tkConfig.sh` und
`tclConfig.sh` (Howto 03 und 04). Debian forky:

```text
TK_LIBS  (8.6)  -lX11 -lXss -lXext -lXft -lfontconfig -lfreetype … -lz …
TCL_LIBS (8.6)  -ldl -lz -lpthread -lm
TCL_LIBS (9.0)  -ldl -lz -lpthread -lm -ltommath
```

Container-Prüfung:

```text
TK_LIBS  (Quellbau 9.0.4)  -lX11 -lXss -lXext -lXft -lfontconfig -lfreetype -lfontconfig -ldl -lz -lpthread -lm
TCL_LIBS (Ubuntu 8.6.14)   -ldl -lz -lpthread -lm
TCL_LIBS (Quellbau 9.0.4)  -ldl -lz -lpthread -lm
```

Hier liegt der FAIL im Container: Howto 03 erwartet unter 9.0
`-ltommath`. Das Debian-Paket `tcl9.0` linkt gegen die
Systembibliothek libtommath; ein Quellbau übersetzt die mitgelieferte
Fassung hinein und braucht kein `-ltommath`. Beides ist richtig, die
Demo prüft nur die Debian-Lage.

`zlib1g-dev` ist für Tcl Pflicht. Fehlt es, bleibt ein Selbstbau oft
mit einer undeutlichen `configure`-Meldung stehen (Howto 03).

---

## Was wirklich gelinkt ist

`TK_LIBS` ist die Absicht, `ldd` an der Bibliothek ist das Ergebnis
(Howto 07). Debian forky, `libtk8.6.so` und `libtcl9tk9.0.so`: Xft,
Xss, X11, Xext, fontconfig, freetype, Xrender, zlib, kein `libXi`.
`libpng16` führt `ldd` bei allen drei Tk-Fassungen auf, aber nur über
freetype (siehe unten).

`ldd` zeigt auch, was eine Bibliothek über andere nachzieht. Xrender
kommt über Xft, nicht als eigenes `-lXrender`. Genauer ist die Liste der
direkten Abhängigkeiten:

```bash
readelf -d /opt/tcl9/lib/libtcl9tk9.0.so | grep -E 'NEEDED|RUNPATH'
```

Container-Prüfung:

| Bibliothek | direkt gebraucht (`NEEDED`) | `RUNPATH` |
|------------|-----------------------------|-----------|
| `libtk8.6.so` (Ubuntu) | Xft, fontconfig, X11, Xss, m, c | keiner |
| `libtcl9tk9.0.so` (Quellbau) | Xft, fontconfig, X11, Xss, m, c | `/opt/tcl9/lib` |
| `libtcl8.6.so` (Ubuntu) | z, m, c | keiner |
| `libtcl9.0.so` (Quellbau) | z, m, c | `/opt/tcl9/lib` |

Im Container führt `ldd` `libpng16` für **beide** Tk-Fassungen auf, als
Abhängigkeit von freetype. Auf dem Arbeitsplatz (Debian forky) ebenso:
`readelf -d` zeigt bei `libtk8.6.so`, `libtcl9tk9.0.so` und
`libtcl9tk9.1.so` kein `libpng` unter `NEEDED`; `libfreetype.so.6` hat
es dort direkt. Tk 9.1 braucht zusätzlich direkt HarfBuzz und Xrender.

Den `RUNPATH` `/opt/tcl9/lib` setzt der Quellbau. Er sorgt dafür, dass
`tclsh9.0` seine Bibliothek ohne `LD_LIBRARY_PATH` findet, bindet sie
aber an diesen Ort. Das wird beim Weitergeben wichtig, siehe
[Weitergeben](150-weitergeben.md).

---

## tclConfig.sh unter Debian

Unter Debian und Ubuntu ist `/usr/lib/tcl8.6/tclConfig.sh` ein Wrapper
von zwei Zeilen (Howto 09; im Container genauso):

```sh
#! /bin/sh
. /usr/lib/`dpkg-architecture -qDEB_HOST_MULTIARCH`/tcl8.6/tclConfig.sh
```

Die Werte stehen in `/usr/lib/x86_64-linux-gnu/tcl8.6/tclConfig.sh`.
Wer `TCL_LIBS` mit `grep` in der Wrapper-Datei sucht, findet nichts.
Ein Quellbau nach `/opt/tcl9` legt `tclConfig.sh` direkt nach
`/opt/tcl9/lib`; `configure --with-tcl=` will genau diesen Ordner. Für
TEA-Erweiterungen siehe *Tcl-Erweiterungen*.

---

## Threads und shared

- Tcl 8.6 ist immer mit Threads gebaut: `TCL_THREADS=1`. Tcl 9 hat
  keinen Schalter mehr; `--enable-threads` erzeugt nur
  `WARNING: unrecognized options` (Howto 05).
- Ein normaler Linux-Bau ist shared: `TCL_SHARED_BUILD=1`,
  `libtcl9.0.so`, `info sharedlibextension` ist `.so` (Howto 06;
  Container: alle drei bestätigt). Statisch (`--disable-shared`) ist
  die Ausnahme für Zipkits.

---

## Zwei Fallen beim Bau

Aus `serie-tcltk-bauen`, Howto 11:

- **Leere `.o`:** Ein abgebrochener `make` hinterlässt Objektdateien
  mit null Byte und neuem Zeitstempel. `make` übersetzt sie nicht
  noch einmal, der Linker scheitert später mit
  `file format not recognized`. Suchen mit
  `find . -name '*.o' -size 0`.
- **`LD_LIBRARY_PATH` bei Tcl 9:** Das frisch gebaute `tclsh` im
  Bauordner findet `libtcl9.0.so` nicht, solange sie nicht
  installiert ist. Die Meldung schlägt `TCLSH_NATIVE` vor; gemeint ist
  der Bibliothekspfad: `env LD_LIBRARY_PATH=$PWD make`.

Die `configure`-Zeilen der Serie (Howto 12):

```bash
cd tcl9.0.4/unix
./configure --prefix=/opt/tcl90 --enable-shared --enable-64bit
env LD_LIBRARY_PATH=$PWD make
make install

cd ../../tk9.0.4/unix
./configure --prefix=/opt/tcl90 --exec-prefix=/opt/tcl90 \
    --with-tcl=/opt/tcl90/lib --enable-64bit
env LD_LIBRARY_PATH=/opt/tcl90/lib make
make install
```

`configure` läuft im Ordner `unix/`, nicht in der Wurzel des Baums.

---

## Zusammenfassung

- Debian baut Tk gegen `libx11-dev libxss-dev libxext-dev libxft-dev`.
  Für einen Tk-9-Quellbau `libxi-dev` dazustellen.
- Gelinkt sind Xft, fontconfig, X11, Xss; über diese Xext, Xrender,
  freetype, zlib, `libpng`. Kein `libXi`. Tk 9.1 direkt auch HarfBuzz
  und Xrender.
- `-ltommath` nur beim Debian-Paket `tcl9.0`, nicht beim Quellbau.
- `tclConfig.sh` unter Debian ist ein Wrapper; Werte in der
  Multiarch-Datei.
- Quellbau setzt `RUNPATH` auf das Prefix.

---

*Nächstes Kapitel: [Weitergeben](150-weitergeben.md)*
