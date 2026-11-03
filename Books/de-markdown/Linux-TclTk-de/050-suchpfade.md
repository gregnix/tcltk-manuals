# Suchpfade

## Einführung

`package require` sucht in [`auto_path`]{.index}, Module (`.tm`) im
tm-Pfad. Beide Listen setzt jedes Tcl beim Start aus eingebauten Werten
und Umgebungsvariablen zusammen. Debian und Ubuntu ändern die
eingebauten Werte mit eigenen Patches. Ein selbst gebautes Tcl unter
`/opt` kennt sie nicht. Wer beide nebeneinander hat, muss wissen, wer
welche Pakete sieht.

Die Grundlagen von `package`, `pkgIndex.tcl` und `.tm` stehen im Buch
*Pakete und Module*. Hier geht es nur um die
Linux-Werte.

---

## auto_path des Distributions-Tcl

Container-Prüfung, `tclsh8.6` aus Ubuntu 24.04, mit `env -i` ohne
`TCLLIBPATH`:

```text
/usr/share/tcltk/tcl8.6
/usr/share/tcltk
/usr/lib
/usr/local/lib/tcltk
/usr/local/share/tcltk
/usr/lib/tcltk/x86_64-linux-gnu
/usr/lib/tcltk
/usr/lib/tcltk/tcl8.6
```

Die Liste folgt der Debian-Tcl-Policy: architekturunabhängige Pakete
unter [`/usr/share/tcltk`]{.index}, Pakete mit C-Teil unter
`/usr/lib/tcltk/<multiarch>`, lokale Pakete unter `/usr/local/share/tcltk`
und `/usr/local/lib/tcltk`. `tcl_pkgPath` nennt dieselben Paketordner
in anderer Reihenfolge, aber nicht den Bibliotheksordner der Fassung.
Der steht nur in `auto_path`, bei 8.6 vorn: `/usr/share/tcltk/tcl8.6`.
Bei Debians `tclsh9.0` fehlt in `tcl_pkgPath` entsprechend
`/usr/lib/tcl9.0`, bei `tclsh9.1` `/usr/lib/tcl9.1`.
Debian unstable mit 8.6.18 auf lxpro liefert dieselbe Liste in
derselben Reihenfolge.

Paketierte Bibliotheken liegen dort mit Versionsnummer im
Ordnernamen. Im Container lädt `struct::list` aus
`/usr/share/tcltk/tcllib1.21/struct/list.tcl`.

Eigene Pakete für das System-Tcl gehören nach `/usr/local/share/tcltk`
(reines Tcl) oder `/usr/local/lib/tcltk` (mit `.so`). Dort findet das
System-Tcl sie ohne weitere Einstellung, und `apt` fasst sie nicht an.

---

## auto_path der Debian-Pakete für Tcl 9

Auf lxpro, `tclsh9.0` aus dem Paket `tcl9.0`, ohne die Einträge aus
`TCLLIBPATH`:

```text
/usr/lib/tcl9.0
/usr/lib
/usr/local/lib/tcltk
/usr/local/share/tcltk
/usr/lib/tcltk/x86_64-linux-gnu
/usr/lib/tcltk
/usr/share/tcltk
/usr/lib/tcltk/tcl9.0          (fehlt)
```

`tclsh9.1` meldet dieselbe Liste mit `9.1` statt `9.0`. Anders als ein
Quellbau sieht Debians Tcl 9 also **alle** Paketordner der
Distribution, auch die mit Bibliotheken nur für 8.6. Ob ein Paket unter
Tcl 9 lädt, entscheidet dann allein sein `pkgIndex.tcl`. Pakete wie
tdom, tcltls, Thread oder Img legen zwei Bibliotheken nebeneinander,
`libtdom0.9.6.so` für 8.6 und `libtcl9tdom0.9.6.so` für 9, und ihr
Index wählt nach der Fassung. Wo die zweite Datei fehlt, bricht
`package require` unter Tcl 9 ab (Abschnitt *sqlite3 unter Debians
Tcl 9*).

In der Liste der tm-Pfade stehen bei den Paketen für Tcl 9 zwei Ordner
als ein einziger Eintrag:

```text
/usr/lib/tcltk /usr/share/tcltk/tcl9/site-tcl
/usr/lib/tcltk /usr/share/tcltk/tcl9/9.0
```

Module unter `/usr/share/tcltk/tcl9` findet Tcl 9 so nicht. Auf lxpro
gibt es diese Ordner nicht, es fehlt also derzeit nichts.

---

## auto_path eines Quellbaus

Container-Prüfung, `/opt/tcl9/bin/tclsh9.0`, `env -i`:

```text
//zipfs:/lib/tcl/tcl_library
//zipfs:/lib/tcl
/opt/tcl9/lib
```

Das ist alles. `/usr/share/tcltk` steht nicht darin. Ein Tcl 9 unter
`/opt` sieht kein einziges Paket der Distribution, weder Tk-Erweiterungen
noch Tcllib. Das ist gewollt: Ein Paket für 8.6 mit C-Teil lädt unter
Tcl 9 ohnehin nicht. Reine Tcl-Pakete laufen oft unter beiden
Fassungen, müssen aber ausdrücklich eingehängt werden.

Im Container brachte `/opt/tcl9/lib` eigene Fassungen mit: Tcllib 1.9
(`package versions struct::list`), Thread 3.0.6, sqlite3 3.53.0.
Insgesamt kannte `tclsh9.0` nach einem `package require` auf ein
fehlendes Paket 628 Paketnamen, `tclsh8.6` 584.

Was `package require` auf lxpro (Debian forky/sid, Debian-Pakete,
ohne `TCLLIBPATH`) liefert; `serie-tcltk-bauen`, Howto 10, nennt noch
Thread 3.0.6 und tdbc 1.1.14:

| Paket | Tcl 8.6.18 | Tcl 9.0.4 | Tcl 9.1.0 |
|-------|-----------|-----------|-----------|
| Thread | 3.0.7 | 3.0.7 | 3.0.7 |
| Itcl | 4.3.8 | 4.3.8 | 4.3.8 |
| sqlite3 | 3.53.4 | fehlt | fehlt |
| tdbc | 1.1.15 | 1.1.15 | 1.1.15 |

Thread kommt aus dem Paket `tcl-thread` 1:3.0.7-2, tdbc aus
`/usr/lib/tcltk/x86_64-linux-gnu/tdbc1.1.15`. sqlite3 bricht unter 9.0
und 9.1 mit `this extension is compiled for Tcl 8.6` ab (Abschnitt
*sqlite3 unter Debians Tcl 9*).

Ein Quellbau holt sqlite aus dem `pkgs/`-Ordner des Tcl-Baums; dem
Debian-Paket `tcl9.0` fehlte es dort.

---

## sqlite3 unter Debians Tcl 9

Das Paket [`libsqlite3-tcl`]{.index} enthält bis 3.53.4-2 nur eine
Bibliothek, gebaut für Tcl 8.6. Unter `tclsh9.0` und `tclsh9.1` bricht
`package require sqlite3` dann ab:

```text
% package require sqlite3
this extension is compiled for Tcl 8.6
```

Seit 3.54.1-1 (unstable, November 2026) bringt das Paket eine zweite
Bibliothek für Tcl 9 mit; dann ist nichts zu tun:

```text
/usr/lib/tcltk/x86_64-linux-gnu/sqlite3/
    libsqlite3.54.1.so        für 8.6
    libtcl9sqlite3.54.1.so    für 9.0 und 9.1
```

Beide sind dynamisch gegen `libsqlite3.so.0` aus `libsqlite3-0`
gebunden; die gegen 9.1 gebaute lädt auch unter 9.0.4.

### Mit 3.53.4-2 oder älter

Ein zweites sqlite3 daneben hilft nur mit gleicher Nummer und vorn in
`auto_path`; bei verschiedenen Nummern nimmt `package require` die
höchste. Also dieselbe Fassung für beide Tcl bauen, aus den Quellen der
Tcl-Distribution (für 9.1.0 `sqlite3.53.4.tar.gz`, ein TEA-Paket):

```bash
cd sqlite3.53.4
mkdir b86 b90
(cd b86 && ../configure --with-tcl=/usr/lib/tcl8.6 --libdir=$HOME/lib/tcltk \
        && make && make install-lib-binaries)
(cd b90 && ../configure --with-tcl=/usr/lib/tcl9.0 --libdir=$HOME/lib/tcltk \
        && make && make install-lib-binaries)
```

- `install-lib-binaries`, nicht `install-binaries`: Das zweite Ziel
  will `sqlite3_analyzer` nach `/usr/bin` legen.
- Gegen 9.0 bauen: Die Bibliothek lädt dann unter 9.0 und 9.1.
- Beide Bibliotheken gehören in denselben Ordner; der erzeugte Index
  wählt nach der Fassung.

`~/lib/tcltk` kommt über `TCLLIBPATH` nach vorn. Kommt später ein Paket
mit höherer Nummer, gewinnt wieder das Paket.

### Eigener Bau und Paket

Ein eigener Bau und Debians Paket haben nicht dieselben
`PRAGMA compile_options`. Zwei davon ändern das Verhalten:

| Option | eigener Bau 3.53.4 | Debian 3.54.1-1 |
|---|---|---|
| `DQS=0` | gesetzt: `SELECT "abc"` ist ein Fehler | fehlt: liefert `abc` |
| `USE_URI` | fehlt: `file:…` ohne `-uri 1` wird ein Dateiname | gesetzt: URI |

Das Programm legt das Verhalten selbst fest, in jedem Bau gleich:

```tcl
sqlite3 db $datei -uri 1      ;# file:-Namen immer als URI
db config dqs_dml 0           ;# "Text" in SELECT/INSERT … ein Fehler
db config dqs_ddl 0           ;# ebenso in CREATE TABLE …
```

`tdbc::sqlite3` ist reines Tcl und braucht keinen eigenen Bau. Unter
8.6 lädt Debians Modul, unter Tcl 9 jedes `sqlite3-1.1.15.tm` in einem
tm-Pfad der Fassung, auf lxpro über `TCL9_0_TM_PATH`. Hat das Programm
vorher ein Paket aus einem Index geladen, gewinnt bei gleicher Fassung
der Index (Abschnitt *Welche Kopie gewinnt*).

---

## TCLLIBPATH

[`TCLLIBPATH`]{.index} wird beim Start **vorn** an `auto_path`
gestellt. Der Wert ist eine Tcl-Liste, getrennt durch Leerzeichen, nicht
durch Doppelpunkte wie `PATH`. Container-Prüfung, beide Fassungen
gleich:

| `TCLLIBPATH` | Anfang von `auto_path` |
|--------------|------------------------|
| `/x/eins /x/zwei` | `/x/eins /x/zwei …` |
| `/x/eins:/x/zwei` | `/x/eins:/x/zwei …`, ein einziger Eintrag |

Der zweite Eintrag ist ein Pfad, den es nicht gibt. Tcl meldet nichts,
das Paket bleibt unauffindbar.

`TCLLIBPATH` gilt für **jedes** Tcl, das die Sitzung startet. Wer darin
Ordner mit 9er-Paketen einträgt, gibt sie auch dem `tclsh8.6`. Tcl sucht
eine Ebene unter jedem Eintrag nach `pkgIndex.tcl`; eine `.so` für
Tcl 9 bricht unter 8.6 beim `load` ab. Sauberer ist es, je Fassung einen
eigenen Ordner zu führen und `auto_path` im Programm zu ergänzen:

```tcl
set hier [file dirname [file normalize [info script]]]
set auto_path [linsert $auto_path 0 [file join $hier lib]]
```

---

## tm-Pfade

Module suchen nicht in `auto_path`, sondern im tm-Pfad
(`tcl::tm::path list`). Container-Prüfung, Tcl 9.0.4 aus `/opt/tcl9`:

```text
/opt/tcl9/lib/tcl9/site-tcl
/opt/tcl9/lib/tcl9/9.0
//zipfs:/lib/tcl/tcl9/site-tcl
//zipfs:/lib/tcl/tcl9/9.0
```

Das Ubuntu-`tclsh8.6` meldet 25 Einträge: `site-tcl` und die Ordner
`8.0` bis `8.6` jeweils unter `/usr/lib/tcltk/tcl8`, `/usr/lib/tcl8` und
`/usr/share/tcltk/tcl8`, dazu `/usr/share/tcltk/tcl8.6/tcl8`.

Zusätzliche Orte kommen aus Umgebungsvariablen, deren Name die
Fassung trägt: [`TCL9_0_TM_PATH`]{.index} für Tcl 9.0, `TCL8_6_TM_PATH`
für 8.6, dazu `TCL8_5_TM_PATH` und so weiter für ältere Unterfassungen,
die 8.6 ebenfalls liest. Tcl 9.1 liest `TCL9_1_TM_PATH` und ebenso
`TCL9_0_TM_PATH`. Zu jedem Namen gibt es eine Schreibweise mit Punkt
(`TCL9.0_TM_PATH`), die `tm.tcl` auch liest; in `bash` lässt sie sich
nicht exportieren. Diese Variablen trennen mit **Doppelpunkt**,
anders als `TCLLIBPATH`. Container-Prüfung:

- `TCL9_0_TM_PATH=/x/tm90a:/x/tm90b`: Tcl 9.0.4 setzt `/x/tm90b` und
  `/x/tm90a` an die Spitze, in dieser umgekehrten Reihenfolge.
- `TCL9_TM_PATH` und `TCL8_TM_PATH` (ohne Unterfassung) liest keine der
  beiden Fassungen.
- `TCL8_6_TM_PATH` sieht Tcl 9.0 nicht.
- Ubuntus 8.6.14 setzt die Einträge aus `TCL8_6_TM_PATH` nicht an die
  Spitze, sondern hinter die acht Ordner unter `/usr/lib/tcltk/tcl8`
  (geprüft mit `TCL8_5_TM_PATH` und `TCL8_6_TM_PATH`: Index 8 bis 10
  von 28). Module gleichen Namens und gleicher Version in diesen Ordnern
gewinnen also; eine höhere Version gewinnt unabhängig vom Ordner.

Die umgekehrte Reihenfolge folgt daraus, dass `tcl::tm::path add` jeden
Eintrag vorn einfügt. Wer eine bestimmte Reihenfolge braucht, setzt sie
im Programm mit `tcl::tm::path add`.

---

## Welche Kopie gewinnt

Liegt ein Paket als Modul im tm-Pfad und zugleich hinter einem
`pkgIndex.tcl` in `auto_path`, hängt die geladene Kopie davon ab, was
das Programm vorher verlangt hat:

- Ist noch kein Index gelesen, beendet ein passendes Modul die Suche.
- Die erste Suche nach einem Paket, das kein Modul ist, liest jeden
  `pkgIndex.tcl` in allen Ordnern von `auto_path`. Danach kennt Tcl
  alle Fassungen daraus. Passt eine davon, fragt ein späterer Aufruf
  nicht mehr nach Modulen.
- Bei gleicher Version gewinnt dann der Index. Lag das früher gesuchte
  Paket in einem anderen Namensraum-Ordner als das Modul, gewinnt der
  Index auch mit einer niedrigeren Version: Der Modul-Handler hat
  dabei nur in jenem Ordner gesucht, `struct/` für `struct::list`, die
  Wurzel für `tablelist`.

Geprüft mit 8.6.14, 9.0.4 und 9.1.0, mit gleichem Ergebnis. Die ganze
Tabelle und ein Skript zum Nachmachen stehen in *Ausliefern*, Kapitel
Suchpfade.

Unter Linux trifft das vor allem alte Kopien in Ordnern aus
`TCLLIBPATH`. Ein typischer Fall: In `~/lib/tcltk` liegt noch eine
frühere Installation mit `pkgIndex.tcl`, die neue liegt in derselben
Version als Modul in `site-tcl`. Ein Programm, das zuerst `tablelist`
lädt (hinter einem Index), bekommt danach die alte Kopie; ein
Programm, das nur das Modul verlangt, die neue. Abhilfe ist, die alte
Kopie wegzuräumen.

---

## Welches Paket wurde geladen?

```tcl
package require struct::list
puts [package ifneeded struct::list [package present struct::list]]
```

Die Zeile zeigt den Befehl, mit dem Tcl das Paket laden würde, also
seinen Pfad. Das ist die schnellste Antwort auf „warum lädt mein Tcl 9
das alte Paket“: Meist steht ein Ordner aus `TCLLIBPATH` davor.

Für Pakete mit C-Teil ist [`info loaded`]{.index} der Beweis. Es nennt
jede Bibliothek, die der Interpreter tatsächlich geladen hat:

```tcl
package require sqlite3
puts [info loaded]
```

Alles auf einmal zeigt der Bericht von `tclutils::tuappinfo`: die
Suchvariablen (`TCLLIBPATH`, `TCL*_TM_PATH`, `LD_LIBRARY_PATH`) Eintrag
für Eintrag, `auto_path`, `tcl_pkgPath` und den tm-Pfad mit einer
Marke `(missing)` an jedem Ordner, den es nicht gibt, jedes geladene
Paket mit seiner Datei und die Liste aus `info loaded`. Das Beispiel
der Bibliothek lädt vorher die genannten Pakete:

```bash
tclsh9.0 examples/demo-tuappinfo.tcl sqlite3
```

---

## Zusammenfassung

- Debian-Tcl: `auto_path` über `/usr/share/tcltk` und
  `/usr/lib/tcltk/<multiarch>`, eigene Pakete nach `/usr/local/…/tcltk`.
- Debians Tcl 9 sieht dieselben Paketordner wie 8.6. Ob ein Paket lädt,
  entscheidet sein Index.
- `libsqlite3-tcl` bis 3.53.4-2 ist nur für 8.6 gebaut, ab 3.54.1-1
  auch für Tcl 9. Für ältere: dieselbe Fassung für 8.6 und 9.0 bauen und
  vorn in `auto_path` legen.
- Tcl 9 unter `/opt` sieht keine Distributionspakete.
- `TCLLIBPATH`: Tcl-Liste mit Leerzeichen, gilt für jedes Tcl der
  Sitzung.
- `TCL9_0_TM_PATH`, `TCL8_6_TM_PATH`: Doppelpunkt, je Fassung,
  umgekehrt eingefügt; 9.1 liest auch `TCL9_0_TM_PATH`.
- Ein passendes `.tm` beendet die Suche, solange kein Index gelesen
  ist. Danach gewinnt bei gleicher Version der Index, nach einem Paket
  aus einem anderen Namensraum-Ordner auch ein älterer.
- Herkunft eines Pakets: `package ifneeded` mit `package present`;
  geladene Bibliotheken: `info loaded`.

---

*Nächstes Kapitel: [Kodierung und Locale](060-kodierung-und-locale.md)*
