# Filter: cufilter

[cufilter]{.index} 0.2 legt selbst Widgets an. Die übrigen Controller
hängen Verhalten an vorhandene Pfade. `widget $path $listwidget` baut
einen `ttk::frame` mit Label „Filter:“, Eingabefeld und Leeren-Knopf
(Aufschrift „x“) und gibt `$path` zurück. Packen muss die App.

```tcl
::tkutils::tkufilelist::widget .list -dir [pwd]
::ctrlutils::cufilter::widget .filter .list
pack .filter -side top -fill x
pack .list   -side top -fill both -expand 1
```

- Jeder Tastendruck filtert sofort.
- Reiner Text wird zu `*text*` (Teilstring), Text mit `*` oder `?` gilt
  als Glob. Groß-/Kleinschreibung egal: `tkufilelist` vergleicht mit
  `string match -nocase` („A“ findet `a.txt`).
- Verzeichnisse bleiben immer sichtbar, Navigation geht weiter.
- Escape oder der Knopf leeren die Zeile (`cufilter::clear $path`), der
  Fokus geht zurück an die Liste.
- Seit ctrlutils 0.4 gehen „Filter:“ und „x“ über msgcat (Katalog im
  Namensraum `::ctrlutils`, wie bei cufileops). Geprüft
  (Tcl/Tk 8.6.14, Linux, Xvfb): mit `mcset {} Filter: Suche:` und
  `mcset {} x X` zeigt die Zeile `Suche:` und `X`. In ctrlutils 0.3
  bleiben beide englisch.

- Lässt sich der Filter nicht setzen (die Liste ist weg oder keine
  `tkufilelist`), geht das Eingabefeld in den ttk-Zustand `invalid`,
  `$path` bekommt `<<CufilterError>>`, und `cufilter::lastError $path`
  liefert die Meldung. Ein Dialog erscheint nicht, weil der Filter bei
  jedem Tastendruck läuft. Bis 0.1 verschwand der Fehler still.

Voraussetzung: `tkufilelist` mit Option `-filter` / Methode `setFilter`.
Die Liste selbst steht im Handbuch tkutils.

---

## Merkliste

- `widget` liefert den Pfad und packt ihn nicht.
- Text ohne `*` und `?` sucht als Teilstring.
- Verzeichnisse bleiben sichtbar.
- Die beiden Aufschriften kommen seit 0.4 aus msgcat.
- Ein Fehler beim Filtern steht in `lastError` (seit 0.2).

---

*Nächstes Kapitel: [Verzeichnis beobachten](034-cumonitor.md)*
