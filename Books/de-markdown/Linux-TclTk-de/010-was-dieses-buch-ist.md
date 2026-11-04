# Was dieses Buch ist

## Einführung

Tcl/Tk läuft unter Linux zu Hause: Die Distributionen bringen es als
Paket mit, `wish` zeichnet mit dem Fenstersystem [X11]{.index}, und die
meisten Tcl-Beispiele im Netz setzen stillschweigend Linux voraus.
Trotzdem verhält sich ein Tcl-Programm auf einem Linux-Arbeitsplatz an
vielen Stellen anders als unter macOS oder Windows: mehrere Interpreter
liegen nebeneinander, Pfade folgen [XDG]{.index}, die Kodierung kommt
aus der Locale, ein Fenstermanager entscheidet über Fokus und Größe,
und es gibt zwei Zwischenablagen.

Dieses Buch behandelt diese Besonderheiten aus Sicht der
Tcl/Tk-Entwicklung: den Plattformwert, welches Tcl gerade läuft, Pfade
und Suchpfade der Distribution, Kodierung, `exec`, X11 und
Fenstermanager, Schriften und Skalierung, Mausrad und Zwischenablage,
die Einbindung in den Desktop, Xfce, GUI-Tests unter Xvfb, die
Bauabhängigkeiten von Tk und die Weitergabe.

Es ist ein Werkstattbuch. Die Kapitel zeigen Vorgehen und Befehle, die
unter Linux ausprobiert sind, mit der Ausgabe, die dabei herauskommt,
und mit den Stellen, an denen etwas nicht wie erwartet lief. Allgemeine
Tcl/Tk-Kenntnisse setzt es voraus. Ein Linux-Handbuch ist es nicht.

---

## Womit die Beispiele arbeiten

Die Beispiele verwenden Tcl 8.6 aus dem Paket der Distribution und
Tcl/Tk 9.0.4, selbst gebaut unter `/opt/tcl9`, auf Debian und Ubuntu
mit X11. Wo sich 8.6 und 9.0 unterscheiden, steht es im Text, ebenso,
wenn ein Wert nur mit einem Fenstermanager oder nur unter Xfce gilt.

Grundlage sind fünf Howto-Serien des Autors. `serie-linux`,
`serie-xvfb` und `serie-xfce` sind veröffentlicht, im Repository
`tcltk-manuals` unter [`Serien/`](https://github.com/gregnix/tcltk-manuals/tree/main/Serien); `serie-tcltk-bauen` und
`serie-tcl9-app` nicht. Angaben wie „(`serie-linux`, Howto 08)“ nennen das
Skript, mit dem ein Wert geprüft wurde. Jede Serie hat ein
`README.md` mit den geprüften Werten, ein `TUTORIAL.md`, eine
Kurzreferenz `howto/00-referenz.md` und je Howto eine Erklärung
`NN-*.md` mit einer lauffähigen Demo `NN-*.tcl`. Die Demos prüfen
ihre Aussagen selbst und melden OK, SKIP oder FAIL.

| Serie | Inhalt | Kapitel hier |
|-------|--------|--------------|
| `serie-linux` | Pfade, XDG, Umgebung, `exec`, Kodierung, Dateisystem, `tcl_platform`, Dialoge | 2, 4, 6, 7, 11 |
| `serie-xvfb` | Xvfb, Fenstermanager, Fokus, Iconify, Grab, Tests ohne Dekorator (20 Howtos) | 8, 13, 14 |
| `serie-xfce` | Xfce 4.20 aus Tcl: xfconf, DBus, Thunar, `exo-open`, `notify-send` | 11, 12 |
| `serie-tcltk-bauen` | Bauabhängigkeiten von Tk unter Debian, `TK_LIBS`, `ldd` | 2, 3, 5, 15 |
| `serie-tcl9-app` | Programme mit Tcl 9 und zipfs | 16 |

Das Buch übernimmt die Howtos nicht Stück für Stück. Es ordnet sie nach
Themen, erklärt den Zusammenhang und behält die Codezeilen, auf die es
ankommt. Laufen die Serien gesammelt, ist `SERIES_AUTO=1` gesetzt; dann
öffnet keine Demo einen Dialog, einen Browser oder ein
Benachrichtigungsfenster.

Wer eine Aussage selbst prüfen will, nimmt die Skripte in `beispiele/`
neben dem Buchordner, allen voran
[`messprobe-linux.tcl`](810-anhang-cli.md), das alle Werte der Tabellen
dieses Buches druckt.

Rechner, genaue Versionen und was noch nicht getestet ist, nennt
[Anhang F: Testumgebung](860-anhang-testumgebung.md). Werte aus dem
Ubuntu-Container heißen im Text „Container-Prüfung“; dort läuft Xvfb
ohne Fenstermanager, ohne Desktop-Sitzung und ohne Xfce.

---

## Wie das Buch zu lesen ist

Teil 1 (Kapitel 1 bis 7) erklärt die Plattform: `tcl_platform`, welches
Tcl, Pfade und XDG, Suchpfade, Kodierung und Locale, `exec`. Teil 2
(Kapitel 8 bis 12) geht an die Oberfläche: X11 und Fenstermanager,
Schriften und Skalierung, Maus, Tastatur und Zwischenablage, Dialoge
und Desktop, Xfce. Teil 3 (Kapitel 13 bis 17) behandelt Tests unter
Xvfb, die Bauabhängigkeiten von Tk, die Weitergabe und häufige Fragen.

Die Anhänge sind zum Nachschlagen: Fallen (A), Befehle (B), Glossar (C),
Fehlermeldungen (D), Quellen (E) und die Testumgebung (F). Anhang A
lohnt sich beim Lesen nebenbei offen zu halten.

Andere Themen stehen in eigenen Büchern derselben Reihe: Debian als
Betriebssystem in *Debian unter Linux* (dieses Buch beschreibt den
Interpreter auf der Distribution, jenes die Distribution), die
Schwesterbücher *Tcl/Tk unter macOS* und *Tcl/Tk unter Windows*, Tcl/Tk
selbst bauen in *Tcl/Tk 9.0 bauen* und *Tcl/Tk 9.1 bauen*, Kits, zipfs,
`.deb` und `.rpm` in *Tcl-Anwendungen ausliefern* (im Text kurz
*Ausliefern*), C-Erweiterungen in *Tcl-Erweiterungen*, Pakete und
Module in *Pakete und Module*.

---

*Nächstes Kapitel: [tcl_platform und Distribution](020-tcl-platform-und-distribution.md)*
