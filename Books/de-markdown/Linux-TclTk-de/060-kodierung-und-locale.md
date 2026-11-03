# Kodierung und Locale

## Einführung

Unter Linux bestimmt die Locale die Kodierung, nicht das
Betriebssystem. Tcl liest beim Start `LC_ALL`, `LC_CTYPE` und `LANG`
und setzt daraus [`encoding system`]{.index}. Ist die Locale `C` oder
fehlt sie, ist das nicht UTF-8. Daran hängen drei Dinge: wie `open`
eine Datei liest, wie `puts` auf das Terminal schreibt, und unter Tcl
8.6 auch, wie `source` ein Skript liest.

Die Langfassung zum Thema, mit Windows und TIP 656, steht im Buch
*Encoding*.

---

## encoding system folgt der Locale

`serie-linux` (Howto 08) zeigt auf Debian forky mit Tcl 8.6.18:

```text
LANG=C         encoding system = iso8859-1
LANG=C.UTF-8   encoding system = utf-8
```

Die Container-Prüfung bestätigt das und ergänzt weitere Werte. Jeder
Lauf mit `env -i`, also ohne sonstige Variable. Ausgewertet: `encoding
system`, die Länge eines UTF-8-Literals `"Grüße"` im Skript, und die
Länge derselben fünf Zeichen, gelesen aus einer UTF-8-Datei mit `open`
ohne `fconfigure`.

| Umgebung | 8.6.14 System | 8.6.14 Literal | 9.0.4 System | 9.0.4 Literal | `open`, beide |
|----------|---------------|----------------|--------------|---------------|---------------|
| keine Locale | iso8859-1 | 7 | iso8859-1 | 5 | 7 |
| `LANG=C` | iso8859-1 | 7 | iso8859-1 | 5 | 7 |
| `LANG=POSIX` | iso8859-1 | 7 | iso8859-1 | 5 | 7 |
| `LANG=C.UTF-8` | utf-8 | 5 | utf-8 | 5 | 5 |
| `LANG=de_DE.UTF-8` | utf-8 | 5 | utf-8 | 5 | 5 |
| `LANG=en_US.ISO-8859-1` | iso8859-1 | 7 | iso8859-1 | 5 | 7 |
| `LANG=de_DE` | iso8859-1 | 7 | **utf-8** | 5 | 7 bzw. 5 |
| `LANG=C.UTF-8 LC_ALL=C` | iso8859-1 | 7 | iso8859-1 | 5 | 7 |
| `LANG=C LC_CTYPE=C.UTF-8` | utf-8 | 5 | utf-8 | 5 | 5 |

Was daraus folgt:

- Die Reihenfolge ist `LC_ALL`, dann `LC_CTYPE`, dann `LANG`. Ein
  `LC_ALL=C` schlägt jedes `LANG`.
- Die Locale muss nicht installiert sein. Im Container gibt es nur `C`,
  `C.utf8` und `POSIX` (`locale -a`), trotzdem führt
  `LANG=de_DE.UTF-8` zu `utf-8`. Tcl liest den Namen.
- Eine Locale ohne Zeichensatz (`de_DE`) behandeln 8.6.14 und 9.0.4
  verschieden: 8.6 nimmt iso8859-1, 9.0 nimmt utf-8.
- `open` folgt in beiden Fassungen `encoding system`.
- Skripte liest Tcl 9 immer als UTF-8. Tcl 8.6 liest sie in
  `encoding system`.

---

## Dateien: immer mit Kodierung

Weil die Vorgabe von der Locale abhängt, öffnet ein Programm jede
Textdatei mit ausdrücklicher Kodierung. Das gilt unter 8.6 und 9:

```tcl
set ch [open $pfad r]
fconfigure $ch -encoding utf-8
set text [read $ch]
close $ch
```

`open` selbst hat keine Option für die Kodierung, auch unter Tcl 9
nicht. Die Zeile `fconfigure` bleibt.

Tcl 9 bricht beim Lesen ungültiger Bytes ab, statt sie still
umzudeuten (TIP 656, Profil `strict` als Vorgabe für Kanäle).
Container-Prüfung mit einer Latin-1-Datei `Gr\xfc\xdfe`, gelesen mit
`-encoding utf-8`:

```text
8.6.14   Grüße
9.0.4    error reading "file5": invalid or incomplete multibyte or wide character
```

Tcl 8.6 deutet ungültige UTF-8-Bytes als Latin-1. Das sieht hier
zufällig richtig aus und verdeckt, dass die Datei gar kein UTF-8 ist.
Unter Tcl 9 fällt derselbe Fehler auf. Unter Linux trifft das vor
allem alte Dateien und Ausgaben fremder Programme. Die Profile
(`-profile replace`, `-profile tcl8`) beschreibt das Buch *Encoding*.

---

## Skripte: die Wache unter Tcl 8.6

Ein UTF-8-Skript mit Umlauten im Quelltext läuft unter Tcl 8.6 nur
richtig, wenn die Locale UTF-8 ist. Unter `LANG=C` wird aus
`Rückgängig` die Zeichenfolge `RÃ¼ckgÃ¤ngig` (`serie-linux`, Howto 08).
Das trifft Programme, die aus Cron, aus einer Systemd-Einheit oder aus
einem Container ohne Locale starten.

Abhilfe ohne Startparameter ist eine Wache am Dateianfang. Die Datei
selbst ist UTF-8. Liest Tcl sie als iso8859-1, ist `"ü"` zwei Zeichen
lang. Dann liest die Wache die Datei noch einmal, diesmal als UTF-8:

```tcl
if {[string length "ü"] != 1} {
    source -encoding utf-8 [file normalize [info script]]
    return
}
```

`beispiele/utf8-wache.tcl` zeigt das. Container-Prüfung, unter
`LANG=C` und `LANG=C.UTF-8`, mit 8.6.14 und 9.0.4: In allen vier Läufen
hat `"Rückgängig"` die Länge 10. Unter `LANG=C` sieht das Terminal die
Umlaute trotzdem falsch, weil `stdout` in iso8859-1 schreibt. Der
String im Programm stimmt.

Die Wache gehört in das Startskript. Für weitere Dateien gibt es
`source -encoding utf-8` direkt, für Pakete den Eintrag in
`pkgIndex.tcl`:

```tcl
package ifneeded meinpaket 1.0 \
    [list source -encoding utf-8 [file join $dir meinpaket.tcl]]
```

Alternativ ruft der Startbefehl die Kodierung ausdrücklich:
`tclsh8.6 -encoding utf-8 app.tcl`. Das geht nur, wenn man den Aufruf
selbst in der Hand hat, also nicht über eine Shebang-Zeile mit `env`
(siehe [Welches Tcl?](030-welches-tcl.md)).

---

## Terminal und exec

`stdout`, `stderr` und `stdin` stehen beim Start auf `encoding system`
(Container: `fconfigure stdout -encoding` liefert `utf-8` unter
`C.UTF-8`). Dasselbe gilt für Kanäle zu Kindprozessen: `exec` und
`open "|…"` dekodieren die Ausgabe des Kindes in `encoding system`.
`exec printf %s "Grüße"` liefert unter `LANG=C.UTF-8`
`Grüße`. Ein Kind, das immer UTF-8 schreibt, liest man unter
unbekannter Locale über einen Kanal mit fester Kodierung:

```tcl
set ch [open |[list git log -1 --format=%an] r]
fconfigure $ch -encoding utf-8
set autor [string trim [read $ch]]
close $ch
```

Siehe [exec, xdg-open, Prozesse](070-exec-und-prozesse.md).

---

## msgcat und Sprache

`msgcat::mclocale` liest ebenfalls die Locale-Variablen, in der
Reihenfolge `LC_ALL`, `LC_MESSAGES`, `LANG` (Quelltext von
`msgcat.tcl` in Tcl 9.0.4). Im Container mit `LANG=C.UTF-8` ist das
Ergebnis `c`. Ein Programm mit deutschen Meldungen in `de.msg` braucht
also eine deutsche Locale oder einen ausdrücklichen Aufruf
`msgcat::mclocale de`. `LANGUAGE`, unter Linux die Sprachliste für
gettext, wertet `msgcat` nicht aus.

---

## Zusammenfassung

- `encoding system` folgt `LC_ALL`, `LC_CTYPE`, `LANG`. `C` und
  fehlende Locale ergeben iso8859-1.
- `open` folgt `encoding system`. Dateien immer mit `fconfigure
  -encoding utf-8`.
- Tcl 9 liest Skripte als UTF-8, Tcl 8.6 in `encoding system`. Für
  8.6 die Wache am Anfang des Startskripts.
- `de_DE` ohne Zeichensatz: 8.6 iso8859-1, 9.0 utf-8.
- Ausgaben von Kindprozessen über einen Kanal mit fester Kodierung
  lesen.

---

*Nächstes Kapitel: [exec, xdg-open, Prozesse](070-exec-und-prozesse.md)*
