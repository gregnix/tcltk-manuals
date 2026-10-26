# Glossar

---

[Umbrella]{.index}
:   Paket `tclutils`, lädt die Kernmodule.

[Modulpfad]{.index}
:   `tcl::tm::path` — wo `.tm`-Dateien gefunden werden.

[Provider]{.index}
:   Einheitliche Speicher-API (`tuprovider` + Backends).

[caps]{.index}
:   Liste der Operationen, die ein Provider wirklich kann (z. B. ZIP:
    `get list stat`).

[tusettings]{.index}
:   Per-User-INI und Recent-Listen.

[tutestrun]{.index}
:   Gemeinsamer `tests/all.tcl`-Runner der drei Libs.

[tuhttps]{.index}
:   Gemeinsame HTTPS-Politik: prüfende `tls`-Sockets, `https` nur
    befristet registriert.

[tutask]{.index}
:   Tasks auf Koroutinen mit `await`, Timeout, `cancel`, Gruppen, Pool und
    Sandbox (neu in 0.65.0, in 0.66.0 Version 0.2).

[Task]{.index}
:   Koroutine im Besitz eines Objekts (`spawn`); Zustand `running`, `ok`,
    `error` oder `cancelled`.

[Starter]{.index}
:   Befehlspräfix einer Operation: bekommt einen Callback, gibt einen
    Abbruchbefehl zurück, meldet einmal `ok` oder `error`.

[Sandbox]{.index}
:   Sicherer Interpreter mit Befehls- und Zeitgrenze (`tutask::sandbox`).

[NOCA]{.index}
:   tls < 2.0 und kein CA-Bundle gefunden.

[Graphem]{.index}
:   Sichtbares Zeichen, ggf. aus mehreren Codepoints (`tustr::graphemes`).

[tudiagram]{.index}
:   Knoten-Kanten-Modell, Layout in Pixeln, SVG und PNG in reinem Tcl.

[tuflow]{.index}
:   Flowchart-Text nach `tudiagram`. `toSvg` zeichnet auch die anderen Arten.

[tumd]{.index}
:   Kleine CommonMark-Teilmenge nach HTML, ohne verschachtelte Listen.

[tuholiday]{.index}
:   Ostern und die bundesweiten Feiertage, Region `de`.

[tutdbc]{.index}
:   NULL-feste Helfer auf einer bestehenden TDBC-Verbindung. Kein Treiber,
    nicht im Umbrella.

[tummdb]{.index}
:   Leser für MaxMind-DB 2.0. `open` und `close` nur qualifiziert.

[tuhash]{.index}
:   SHA-256, SHA-1 und MD5 in reinem Tcl. Textvorgabe ist UTF-8.

[tuurl]{.index}
:   Prozentkodierung und Query-Strings. An der Query ist `-plus` an.

[tupdftext]{.index}
:   Text einer PDF Seite für Seite, reines Tcl, ohne poppler (0.1, neu in
    0.67.0).

[tupdf]{.index}
:   PDF-Struktur: Version, Objekte, Infos, ZUGFeRD-Hinweis. Der Seitentext
    liegt bei `tupdftext`.

[tuodf]{.index}
:   Schlichtes OpenDocument aus Absätzen. `mimetype` ist der erste Eintrag.

[Schatten-Kopie]{.index}
:   Zweite Kopie eines Pakets auf den Suchpfaden, die `package require`
    nicht nimmt (`tupkgfinder::shadows`).

## Zusammenfassung

- Begriffe aus Pfaden, Providern, HTTPS, Tests, `tutask`, Notizen, PDF, ODF und TDBC.

---

*Nächstes Kapitel: [Fehlermeldungen](830-anhang-fehlermeldungen.md)*
