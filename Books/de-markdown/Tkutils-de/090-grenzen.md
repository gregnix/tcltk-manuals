# Grenzen

---

- Ohne tclutils kein sinnvolles Pairing (Engines, tusettings, tutestrun);
  mindestens 0.64.0, empfohlen 0.68.0.
- Der Umbrella braucht Tablelist (über `tkufilelist` → `tkutablelist`).
- tkutils lädt überall `tablelist_tile`; eine Anwendung, die selbst
  zusätzlich `tablelist` anfordert, scheitert an tklib.
- Nicht jedes Modul im Umbrella: `tkuxml`, `tkusqlite`, `tkuicon`,
  `tkuscrolledframe`, `tkuload`, `tkurender`, die `tkutl*`-Helfer und
  weitere extra requiren (Kapitel
  [tkutils verstehen](010-tkutils-verstehen.md)).
- `tkufiledialog` ist kein Explorer; `-filetypes` filtert nur nach der
  ersten Endung eines Typs.
- tablelist kommt von außen (tklib, z. B. `apt install tklib`).
- tical kommt von außen; `setup.tcl` findet es nicht.
- `tkugeometry` erkennt Lücken zwischen verschieden großen Monitoren nicht.
- Die GUI-Tests brauchen ein Display; ohne Display werden sie übersprungen.
- Nicht jedes Modul prüft seine Optionen: `tkutlfooter` übergeht
  unbekannte Optionen.
- Controller und Undo: ctrlutils, nicht hier.
- Geprüft mit Tcl/Tk 8.6.14 und 9.0.4 unter Linux (Xvfb). Windows, macOS
  und die echte Bildschirmdarstellung sind nicht geprüft.

---

## Zusammenfassung

- View-Schicht; Model und Controller daneben.
- API-Wahrheit: Modul-Docs `docs/<modul>.md`.
- Die Lücken von 0.46.0 (Tablelist-Varianten, Doppelklick im
  Filedialog, Tests ohne Display) sind in 0.47.0 behoben; Einzelheiten
  in den Anhängen A und G.

---

*Nächstes Kapitel: [Fallen](800-anhang-fallen.md)*
