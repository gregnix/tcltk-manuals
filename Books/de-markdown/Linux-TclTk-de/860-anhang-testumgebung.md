# Testumgebung

## Einführung

Dieser Anhang nennt die Rechner und Versionen, mit denen die Beispiele
des Buchs ausprobiert sind, die Prüfskripte dazu und die Punkte, die
noch offen sind. Die Kapitel nennen davon nur, was für das Verständnis
nötig ist. Wie die Werte entstanden sind, steht in
[Anhang E: Quellen](850-anhang-quellen.md).

---

## Rechner und Versionen

Zwei Umgebungen, beide x86_64 mit X11:

| Was | Debian-Arbeitsplatz des Autors | Container |
|---|---|---|
| System | Debian forky (Testing) | Ubuntu 24.04.5 LTS, Kernel 6.18, glibc 2.39 |
| Tcl 8.6 | 8.6.18 aus dem Paket | 8.6.14 aus den Paketen `tcl8.6`, `tk8.6` |
| Tcl/Tk 9 | 9.0.4 und 9.1.0 aus den Paketen | 9.0.4, Quellbau unter `/opt/tcl9` |
| Anzeige | Xfce 4.20 unter X11 (Fenstermanager xfwm4) | Xvfb ohne Fenstermanager, 1280x1024x24, 100 dpi |
| Quelle der Werte | die fünf Howto-Serien | `beispiele/` und die Serien außer `serie-xfce` |

Im Container laufen die Interpreter für Suchpfade und Kodierung mit
leerer Umgebung (`env -i`), damit keine Variable aus der Sitzung die
Werte verfälscht. Aussagen über Tk-Interna (Mausrad, `tk print`,
`tk systray`, Skalierung) sind in den Tk-9.0.4-Quellen nachgelesen und
im Container nachgeprüft. Die Werte mit Fenstermanager stammen aus
`serie-xvfb` (openbox) und vom Arbeitsplatz des Autors (Xfce).

Im Container gibt es keine Desktop-Sitzung, keinen Sitzungs-DBus, kein
Xfce, keinen Fenstermanager, kein Wayland und kein CUPS. Die
Xfce-Werte stammen deshalb nur aus `serie-xfce`.

---

## Prüfskripte

| Skript | prüft | Kapitel |
|---|---|---|
| `beispiele/messprobe-linux.tcl` | alle Werte der Tabellen dieses Buchs | alle, siehe [CLI](810-anhang-cli.md) |
| `beispiele/rad-und-tasten.tcl` | Mausrad und Modifier mit `xdotool` | Maus, Tastatur, Zwischenablage |
| `beispiele/auswahl-probe.tcl` | PRIMARY und CLIPBOARD, ohne Verklemmung | Maus, Tastatur, Zwischenablage |
| `beispiele/wm-probe.tcl` | Fokus, Rahmen, Iconify, Vollbild, `WM_CLASS` | X11, Fenstermanager; Tests |
| `beispiele/spaeter-rahmen.tcl` | Dialoglage bei spätem Rahmen | Tests |
| `beispiele/utf8-wache.tcl` | UTF-8-Skript unter `LANG=C` mit 8.6 | Kodierung und Locale |
| `beispiele/xdg-ordner.tcl` | XDG-Ordner und Benutzerordner, 8.6 und 9 | Pfade, Umgebung, XDG |
| `serie-*/run-all.tcl` | alle Howtos einer Serie (drei veröffentlicht, Kapitel 1) | siehe Kapitel 1 |

---

## Noch nicht getestet

| Kapitel | offen |
|---|---|
| [X11, Fenstermanager und Wayland](080-x11-fenstermanager-wayland.md) | eine echte Wayland-Sitzung (verschachteltes Weston geprüft) |
| [Native Dialoge und Desktop-Integration](110-dialoge-und-desktop.md) | `tk systray` im Xfce-Panel am Bild |
| [Was der Test selbst herstellt](135-gui-tests-fenstermanager.md) | die Howtos unter Windows |

Ein Ergebnis zu einem dieser Punkte gehört in das jeweilige Kapitel und
wird hier gestrichen.
