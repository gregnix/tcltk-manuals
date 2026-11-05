# Glossar

**Brotkrumen** — Pfadzeile über dem Text im Stil `site`: Start ›
Ordnertitel › Seitentitel.

**Buch-Startseite** — von mdserver aus `book.tcl` erzeugte Seite für
einen Buchordner ohne `index.md`: Titel, Untertitel, README-Absatz,
Downloads, Kapitel.

**Clean URL** — Pfad ohne `.md`; der Server sucht die Datei mit Endung,
auch in Unterordnern.

**Control-Port** — localhost-Kanal `ping`, `status`, `reload`, `stop`
(`mdctl.tcl`).

**Dunkelmodus** — dunkle Farben im Stil `site`; nach Systemeinstellung
oder per `theme=dunkel`.

**Horchadresse** — Adresse, auf der mdserver Verbindungen annimmt
(`--bind`); Vorgabe `127.0.0.1`, `*` für alle Schnittstellen.

**Handbuchseite** — in Markdown umgewandelte Manpage, erste H1
`# NAME`; mdserver nennt sie nach `CommandName` oder der NAME-Zeile.

**Health-Endpunkt** — Vorgabe `/__mdserver/health`.

**Kachel** — Karte für ein Buch, einen Ordner oder ein Dokument auf
einer Verzeichnisseite im Stil `site`.

**Nebenläufigkeit** — eine Coroutine je Verbindung, non-blocking I/O,
alles in einem Thread.

**Office-Ansicht** — eine `.docx`, `.odt`, `.odp`, `.xlsx` oder `.ods`
als Seite statt als Download (`--office-view`).

**PDF-Worker** — eigener `tclsh` je PDF (`lib/pdftext-worker.tcl`),
der den Text für die Suche liest, damit der Server weiter antwortet.

**Range** — Teil einer Datei (206), für große PDFs.

**Suchindex** — Text, Titel und Wörter aller durchsuchten Dateien, je
Datei mit ihrer mtime; entsteht nach dem Start im Hintergrund.

**Suchtipps** — aufklappbare Hilfe zur Suchsyntax auf der
Ergebnisseite, mit Beispielen aus dem eigenen Bestand.

**Stil site** — Vorgabe-Seitenstil: ganzes Layout mit Kopfleiste,
Seitenleiste, Brotkrumen, „Auf dieser Seite“.

**trusted-proxy** — Gegenstellen, deren `X-Forwarded-For` gilt.

**Umlautfaltung** — die Suche behandelt `ae`, `oe`, `ue`, `ss` wie `ä`,
`ö`, `ü`, `ß`.

**Verbindungsgrenze** — höchstens so viele offene Verbindungen,
insgesamt (`--maxconn`) und je Absender (`--maxperaddr`); darüber 503.

**Volltextsuche** — `/?q=Wörter` über alle `.md` der Wurzel, mit
tclutils auch über PDFs, UND-verknüpft.

**Wurzel** — `--root`, der Dokumentenbaum.

**Zwischenablage** — fertige Office- und CSV-Seiten, die liegen bleiben,
bis sich die Datei ändert (`--viewcache`).

---

*Nächstes Kapitel: [Fehlermeldungen](830-anhang-fehlermeldungen.md)*
