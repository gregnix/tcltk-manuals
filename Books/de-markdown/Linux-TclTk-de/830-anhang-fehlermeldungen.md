# Fehlermeldungen

Meldungen, die bei den Prüfungen für dieses Buch aufgetreten sind, mit
Ursache und Abhilfe. Wo nicht anders angegeben, im Container unter
8.6.14 und 9.0.4 gleich.

---

## no display name and no $DISPLAY environment variable

```text
application-specific initialization failed: no display name and no $DISPLAY environment variable
```

`DISPLAY` fehlt. `wish` führt das Skript danach ohne Tk aus und endet
mit 0. Abhilfe: Anzeige setzen oder `xvfb-run`. Im Skript
`package require Tk` mit `catch` prüfen. Siehe
[X11, Fenstermanager und Wayland](080-x11-fenstermanager-wayland.md).

## couldn't connect to display

```text
application-specific initialization failed: couldn't connect to display ":77"
```

`DISPLAY` ist gesetzt, aber kein Server antwortet. Typisch nach einem
beendeten Xvfb, dessen Sockel unter `/tmp/.X11-unix/` liegen blieb, oder
bei `ssh` ohne `-X`.

## couldn't execute … no such file or directory

```text
couldn't execute "gibtsnicht": no such file or directory
```

`exec` findet das Programm nicht. `errorCode` ist
`POSIX ENOENT {no such file or directory}`. Vorher `auto_execok`.

## child process exited abnormally

Das Kind endete mit einem Wert ungleich 0. `errorCode` ist
`CHILDSTATUS <pid> <wert>`. Kein Fehler im Sinn des Programms, wenn
der Wert eine Antwort ist (etwa `grep` ohne Treffer: 1).

## child killed: software termination signal

Das Kind wurde mit `SIGTERM` beendet. `errorCode`:
`CHILDKILLED <pid> SIGTERM {software termination signal}`.

## (Text auf stderr)

`exec` meldet als Fehlertext, was das Kind auf stderr geschrieben hat,
bei Rückgabewert 0. `errorCode` ist `NONE`. Abhilfe: `-ignorestderr`
oder `2>@1`. Siehe [exec, xdg-open, Prozesse](070-exec-und-prozesse.md).

## invalid or incomplete multibyte or wide character

```text
error reading "file5": invalid or incomplete multibyte or wide character
```

Nur Tcl 9: Ein Kanal mit `-encoding utf-8` hat Bytes gelesen, die
kein UTF-8 sind. Tcl 8.6 deutet sie still als Latin-1. Siehe
[Kodierung und Locale](060-kodierung-und-locale.md).

## unknown or ambiguous subcommand "home"

```text
unknown or ambiguous subcommand "home": must be atime, attributes, …
```

`file home`, `file tildeexpand` und `file tempdir` gibt es erst ab
Tcl 9. Unter 8.6 `$env(HOME)` nehmen.

## unknown or ambiguous subcommand "systray"

```text
unknown or ambiguous subcommand "systray": must be appname, busy, caret, fontchooser, inactive, scaling, useinputmethods, or windowingsystem
```

`tk systray`, `tk sysnotify` und `tk print` gibt es erst ab Tk 9.

## bad button number "8"

Tk 8.6 kennt in `bind` nur die Tasten 1 bis 5. Tk 9 nimmt auch 6 bis 9.

## bad event type or keysym "Super"

Es gibt keinen Modifier `Super`. Die Super-Taste heißt in `bind`
`Mod4`.

## CLIPBOARD selection doesn't exist or form "STRING" not defined

```text
CLIPBOARD selection doesn't exist or form "STRING" not defined
PRIMARY selection doesn't exist or form "STRING" not defined
```

Niemand besitzt die Auswahl. Bei CLIPBOARD: Es wurde nichts kopiert,
oder das kopierende Programm ist beendet. Bei PRIMARY: Es ist nichts
markiert. `selection get` und `clipboard get` immer mit `catch`.

## Error: target STRING not available

Meldung von `xclip`, wenn der Besitzer der Auswahl nicht mehr läuft. Im
Container nach dem Ende von `wish`.

## Unable to obtain the list of printers

```text
Unable to obtain the list of printers. Command "lpstat" not found. Please install the CUPS package for your system.
```

Tk 9, `::tk::print::cups getprinters` ohne CUPS. Paket `cups-client`
oder `cups` installieren. Nur 9.0.4.

## Failed to execute child process “dbus-launch”

```text
Failed to execute child process “dbus-launch” (No such file or directory)
```

`notify-send` ohne Sitzungs-DBus. Rückgabewert 1. In einer
Desktop-Sitzung tritt das nicht auf; in Cron, `ssh` oder Container
schon. `tk sysnotify` meldet in derselben Lage nichts.

## Verbindung ist gescheitert

`xfconf-query` ohne Sitzungs-DBus (`serie-xfce`, Referenz; deutsche
Meldung auf dem Arbeitsplatz des Autors). Gilt für jeden Aufruf.

## SKIP: serie-xfce braucht XFCE

```text
SKIP: serie-xfce braucht XFCE (XDG_CURRENT_DESKTOP=)
```

Keine Xfce-Sitzung. Die Serie prüft dann nichts.

## WARNING: unrecognized options

`configure` von Tcl 9 kennt den Schalter nicht mehr; Threads sind immer
an (`serie-tcltk-bauen`, Howto 05). Schalter weglassen.

## file format not recognized

Der Linker trifft auf eine leere `.o` aus einem abgebrochenen `make`
(`serie-tcltk-bauen`, Howto 11). `find . -name '*.o' -size 0 -delete`,
dann `make` erneut.

## XInput2.h fehlt

Fehlender Kopf `X11/extensions/XInput2.h` beim Tk-Quellbau, gemeldet in
*Tcl/Tk 9.0 bauen* auf Ubuntu 24.04. Paket `libxi-dev`. Den genauen
Wortlaut der Meldung nennt das Baubuch nicht; hier ist er nicht
nachgeprüft.

## this extension is compiled for Tcl 8.6

```text
% package require sqlite3
this extension is compiled for Tcl 8.6
    while executing
"load /usr/lib/tcltk/sqlite3/libsqlite3.53.4.so"
```

Unter Debians `tclsh9.0` und `tclsh9.1` mit `libsqlite3-tcl` bis
3.53.4-2; diese Fassungen sind nur für Tcl 8.6 gebaut. Seit 3.54.1-1
bringt das Paket eine Bibliothek für Tcl 9 mit, und die Meldung
entfällt. Hintergrund und ein Weg für ältere Fassungen in
[Suchpfade](050-suchpfade.md), Abschnitt *sqlite3 unter Debians Tcl 9*.

## Keine Berechtigung beim Installieren nach /usr/bin

```text
/bin/bash ../tclconfig/install-sh -c  -m 755 ../compat/sqlite3/spaceanal.tcl "/usr/bin/sqlite3_analyzer"
cp: reguläre Datei '/usr/bin/_inst.669779_' kann nicht angelegt werden: Keine Berechtigung
```

Ein TEA-Paket, gebaut gegen Debians `tclConfig.sh`, übernimmt den
Präfix `/usr`. `make install-binaries` will dann Programme nach
`/usr/bin` legen. Bibliothek und Index sind zu diesem Zeitpunkt schon
installiert. Abhilfe: `make install-lib-binaries`.

---

*Nächstes Kapitel: [Quellen](850-anhang-quellen.md)*
