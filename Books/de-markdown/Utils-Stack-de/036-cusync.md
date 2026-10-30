# Spiegeln: cusync

[cusync]{.index} 0.2 ist Tk-frei und läuft unter `tclsh`. Jede Seite hat
ihren eigenen Provider. Lokal, ZIP, WebDAV und SFTP lassen sich mischen.
Der Ablauf ist compare, dann plan, dann apply. Einseitig und ohne
Löschen: auf dem Ziel wird nichts entfernt. Eine Option zum Löschen
gibt es nicht. Den Dialog liefert der Explorer, nicht cusync.

```tcl
package require tclutils::tuprovider
package require ctrlutils::cusync

set pL [::tclutils::tuprovider open local]
set pR [::tclutils::tuprovider open local]
set diffs [::ctrlutils::cusync::compare $pL $dirL $pR $dirR]
set plan  [::ctrlutils::cusync::plan $diffs LR]
set res   [::ctrlutils::cusync::apply $pL $dirL $pR $dirR $plan]
```

Geprüft (Tcl 8.6.14 und 9.0.4, Linux) mit links `a.txt` und
`sub/b.txt`, rechts nur `nur-rechts.txt`: vier Diffs (`a.txt`, `sub`,
`sub/b.txt` als `onlyLeft`, `nur-rechts.txt` als `onlyRight`), drei
Aktionen im Plan, Ergebnis `done 3 errors {}`. Ein zweites `compare`
danach meldet `a.txt` `same`, `nur-rechts.txt` `onlyRight` und
`sub/b.txt` `same`; das Verzeichnis `sub`, jetzt auf beiden Seiten,
steht nicht mehr in der Liste. Die rechte Datei bleibt stehen.

---

## compare

`compare` liefert je Eintrag ein Dict. Eltern stehen vor den Kindern.

| Schlüssel | Inhalt |
|---|---|
| `rel` | Pfad relativ zu den beiden Wurzeln, `/`, ohne führenden Schrägstrich |
| `name` | Blattname |
| `status` | siehe Tabelle |
| `ltype` | `file`, `dir` oder `""`, wenn links fehlend |
| `rtype` | `file`, `dir` oder `""`, wenn rechts fehlend |

| Status | Bedeutung |
|---|---|
| `onlyLeft` | nur links |
| `onlyRight` | nur rechts |
| `newerLeft` | beide, links neuer |
| `newerRight` | beide, rechts neuer |
| `diff` | beide, gleiche oder fehlende mtime, andere Größe |
| `same` | beide, gleiche mtime und Größe |
| `conflict` | Datei gegen Verzeichnis |

Verzeichnisse, die nur auf einer Seite liegen, werden betreten. Jede
Datei darunter bekommt einen eigenen Eintrag. Ein Verzeichnis, das auf
beiden Seiten liegt, hat selbst keinen Eintrag; nur sein Inhalt
erscheint.

`same` vergleicht nur Größe und mtime, nicht den Inhalt. Zwei Dateien mit
gleichen Angaben und anderem Inhalt gelten als gleich.

Lässt sich ein Verzeichnis, das auf einer Seite liegt, nicht auflisten,
endet `compare` mit dem Fehler `{CTRLUTILS CUSYNC LIST side dir}`
(`side` ist `L` oder `R`). Bis ctrlutils 0.4 (`cusync` 0.2) galt diese
Seite als leer: Scheiterte das Auflisten des Ziels, wurde jede Datei der
Quelle `onlyLeft`, und `apply` kopierte sie über das Ziel, auch über
neuere Dateien. Der Explorer zeigt den Fehler in der Statuszeile des
Dialogs.

---

## plan

`plan` macht aus den Diffs Kopieraktionen `{op copy rel … type file|dir}`
für eine Richtung, `LR` oder `RL`. Kopiert wird, was im Ziel fehlt oder
dort älter oder abweichend ist. Die Seite, die nur im Ziel existiert,
kommt nicht herüber. `conflict` auch nicht. Ein `LR`-Plan übergeht
`onlyRight`, ein `RL`-Plan übergeht `onlyLeft`.

---

## apply und applyOne

`apply` führt den Plan aus und liefert `done N errors {…}`. Ein
Fehlertext beginnt mit dem relativen Pfad, zum Beispiel
`fehlt.txt (read): couldn't open …` oder `… (write): …`. Ein Fehler
bricht den Rest nicht ab.

`-ondir` und `-onfile` bekommen je Aktion den relativen Pfad angehängt,
vor der Aktion. Ein Fehler im Callback wird übergangen. In `cusync` 0.1
aus ctrlutils 0.3 prüft `apply` andere Optionen nicht. Ein Tippfehler
bleibt still. Seit 0.2 ist eine unbekannte Option ein Fehler
`unknown option "-x"` mit der Zeile `Known: -onfile -ondir` und dem
Errorcode `{CTRLUTILS CUSYNC OPTION -x}`. Eine Option ohne Wert meldet
`missing value for option "-onfile"` mit dem Errorcode
`{CTRLUTILS CUSYNC OPTION}` (geprüft, Tcl 8.6.14 und 9.0.4, Linux, Xvfb).

`applyOne` führt eine einzelne Aktion aus und liefert `ok 1` oder
`ok 0 error …`. Eine Oberfläche kann den Plan per `after` schrittweise
abarbeiten. Vor einer Datei legt `applyOne` per `mkdir` das
Elternverzeichnis am Ziel an. Ein Fehler dabei bleibt still.

Die mtime der Quelle überträgt `applyOne` mit `file mtime`. Das wirkt
nur bei lokalen Pfaden, sonst bleibt es still. In ctrlutils 0.3 kann
dabei bei einem ZIP-, DAV- oder SFTP-Ziel eine gleichnamige lokale
Datei die mtime bekommen. Seit ctrlutils 0.4 überträgt `applyOne` die
mtime nur, wenn beide Provider der lokale sind (Test `cusync-3.7`).

---

## Merkliste

- compare, plan, apply. Richtung `LR` oder `RL`.
- Nichts wird gelöscht.
- Ein Fehler beim Auflisten bricht `compare` ab (seit `cusync` 0.3).
- `apply` sammelt Fehler und läuft weiter. `applyOne` nimmt eine Aktion.
- mtime nur zwischen zwei lokalen Providern.

---

*Nächstes Kapitel: [cufileops und Undo](040-cufileops-und-undo.md)*
