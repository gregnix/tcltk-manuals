# Umbrella und Module

## Was der Umbrella lädt

```tcl
package require tclutils    ;# -> 0.68.0
```

Die Datei ist `lib/tm/tclutils-0.68.0.tm`. Sie fordert 119 Module mit
`package require tclutils::…`, darunter `common` 0.2, `tutask` 0.2,
`tusettings` 0.1, `tupdftext` 0.1, `tufetch` 0.4, `tuhttps` 0.1 und
`tuflow` 0.3. `tuflow` fordert beim Laden `tudiagram`. Danach sind
120 Pakete `tclutils::*` geladen.

24 Moduldateien im Baum bleiben außen, bis sie jemand einzeln fordert:

| Gruppe | Pakete |
|---|---|
| nur mit eigenem `package require` | `tutestrun`, `tutdbc`, `tuprovider::sftp` |
| Diagramm, `tuflow` lädt sie beim ersten Abruf der betreffenden Art | `tustate`, `turequirement`, `tuer`, `tuclass`, `tumindmap`, `tuc4`, `tublock`, `tugit`, `tuarchitecture`, `tupie`, `tuxychart`, `tuquadrant`, `tujourney`, `tutimeline`, `tusankey`, `tugantt`, `tusequence`, `turadar`, `tutreemap`, `tupacket`, `tukanban` |

`tudiagram` steht nicht in der Liste der 119, ist nach dem Umbrella aber
da, weil `tuflow` es sofort lädt. Die übrigen Diagramm-Module nicht.
25 Dateien stehen nicht in der Anforderungsliste des Umbrella.

```tcl
::tcl::tm::path add /pfad/zu/tclutils-0.68.0/lib/tm
package require tclutils                       ;# -> 0.68.0
package present tclutils::tutask               ;# -> 0.2
package present tclutils::tusettings           ;# -> 0.1
package present tclutils::tupdftext            ;# -> 0.1
catch {package present tclutils::tutestrun}    ;# -> 1
```

`catch` liefert 1, weil `tutestrun` nicht geladen ist. Das Paket gibt
es im Baum. `package require tclutils::tutestrun` lädt es ohne den
Umbrella.

In 0.68.0 haben 76 Module Korrekturen und eine neue Version bekommen;
die Liste steht in [Anhang B](810-anhang-module.md). Neu in 0.67.0 ist
`tupdftext` 0.1, Kapitel
[Text aus PDF-Dateien](055-pdf-text.md). In 0.66.0 wurde `tutask` 0.2,
Kapitel [Tasks mit tutask](085-tutask.md). In 0.65.0 kam `tutask` 0.1
in den Umbrella. Aus 0.64.0 bleiben `tusettings` 0.1, `tustr` 0.2,
`tudate` 0.2, `tunum` 0.4 und `tupkgfinder` 0.2.

FTP liegt im Umbrella (`tuprovider::ftp` 0.2) und fordert tcllib-`ftp`
erst bei `open`. SFTP nicht. TDBC nicht.

---

## Datei, Doku, Test

| Stück | Beispiel |
|---|---|
| Paket | `tclutils::tujson` |
| Datei | `lib/tm/tclutils/tujson-0.1.tm` |
| Befehle | Namensraum `::tclutils::tujson` |
| Doku | `docs/tujson.md` |
| Test | `tests/tujson.test` |
| man | `man/mann/tujson.n` |

Die Version im Dateinamen ist die des Moduls, nicht die des Umbrella.
`tujson-0.1.tm` bleibt 0.1, während der Umbrella auf 0.68.0 steht.

```bash
tclsh tools/check-modules.tcl -require test,doc,man
```

144 Module, keines ohne Test, Doc oder man-Seite.

---

## common

`tclutils::common` 0.2 ist die gemeinsame Hilfe, kein Modul für die
Anwendung. Darüber laufen die Optionsfehler der anderen Module.

| Befehl | Wirkung |
|---|---|
| `parseOptions defaults args` | unbekannte Option wird `{TCLUTILS COMMON OPTION name}` |
| `ensureBoolean wert option` | kein Wahrheitswert wird `{TCLUTILS COMMON BOOLEAN …}` |
| `ensurePositiveInteger wert was` | `{TCLUTILS COMMON INTEGER …}` |
| `ensureOneOf wert liste was` | Wert nicht in der Liste wird `{TCLUTILS COMMON VALUE …}` |
| `readFile`, `writeFile` | Text, Kanal schließt auch beim Fehler |
| `readBinaryFile` | Bytes, Kanal `iso8859-1`, damit Tcl 9 ohne die alte Kodierung `binary` auskommt |

```tcl
::tclutils::tudate::iso 0 -nope 1
```

Das wirft `{TCLUTILS COMMON OPTION -nope}` und nennt die bekannten
Optionen, hier `-time`.

---

## Fehlercodes

Der eigene Fehler eines Moduls hat die Form
`{TCLUTILS <MODUL> <GRUND> …}`. `try`/`trap` vergleicht von vorn. Wer
`{TCLUTILS TUFETCH}` fängt, bekommt jeden Fehler von `tufetch`. Die
Liste der Codes, die dieses Buch ausprobiert hat, steht im Anhang
[Fehlermeldungen](830-anhang-fehlermeldungen.md).

---

## Merkliste

- `package require tclutils` lädt 120 Pakete, nicht die 144 Dateien im Baum.
- `tutestrun`, `tutdbc` und `tuprovider::sftp` bleiben außen.
- Die Diagramm-Arten außer `tudiagram` lädt `tuflow` erst beim Abruf.
  Befehle: Kapitel [Diagramme](056-diagramme.md).
- Unbekannte Optionen kommen als `{TCLUTILS COMMON OPTION …}`.

---

*Nächstes Kapitel: [Text und Dateien](040-text-und-dateien.md)*
