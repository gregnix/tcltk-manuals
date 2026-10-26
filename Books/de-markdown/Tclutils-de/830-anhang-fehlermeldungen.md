# Fehlermeldungen

Typische `-errorcode`-Muster (Auszug). Vollständig: jeweiliges
`docs/<modul>.md`.

| Code | Bedeutung |
|---|---|
| `{TCLUTILS COMMON OPTION …}` | unbekannte Option (`parseOptions`) |
| `{TCLUTILS COMMON VALUE …}` | Wert nicht in erlaubter Menge |
| `{TCLUTILS COMMON BOOLEAN …}` | Option verlangt einen Wahrheitswert |
| `{TCLUTILS COMMON INTEGER …}` | Option verlangt eine positive Ganzzahl |
| `{TCLUTILS TUSETTINGS APP}` | App-Name leer oder mit Pfadzeichen |
| `{TCLUTILS TUSETTINGS KIND}` | unbekanntes kind bei `dir` |
| `{TCLUTILS TUSETTINGS SYNTAX}` | INI nicht parsebar |
| `{TCLUTILS TUSETTINGS VALUE}` | Wert oder Schlüssel nicht INI-tauglich |
| `{TCLUTILS TUHTTPS NOTLS}` | Paket `tls` fehlt |
| `{TCLUTILS TUHTTPS CAFILE}` | `-cafile` keine lesbare Datei |
| `{TCLUTILS TUHTTPS NOCA}` | tls < 2.0 und kein CA-Bundle gefunden |
| `{TCLUTILS TUFETCH CAFILE}` | `-cafile` keine lesbare Datei (nur auf dem nativen Weg mit tls) |
| `{TCLUTILS TUFETCH NOMETHOD}` | kein Transport (auch: tls 1.x ohne CA-Bundle, kein curl/wget) |
| `{TCLUTILS TUFETCH CONNECT}` | Verbindung/DNS/Zertifikat gescheitert |
| `{TCLUTILS TUFETCH HTTP <Klasse> <Status>}` | HTTP-Status außerhalb 2xx, z. B. `HTTP 4XX 404` |
| `{TCLUTILS TUFETCH URL}` | URL weder `http://` noch `https://` |
| `{TCLUTILS TUFETCH TIMEOUT}` | Zeitüberschreitung |
| `{TCLUTILS TUFETCH REDIRECT}` | zu viele Weiterleitungen |
| `{TCLUTILS TUCSV QUOTE}` | CSV-Feld mit offenem Anführungszeichen (`-strict 1`) |
| `{TCLUTILS TUJSON PARSE offset}` | JSON an dieser Stelle ungültig |
| `{TCLUTILS TUJSON TYPE}` | `toJson` mit unbekannter Art |
| `{TCLUTILS TUINI SYNTAX}` | INI nicht parsebar, auch ein offener Abschnitt |
| `{TCLUTILS TUBASE64 MAXLEN}` | `-maxlen` keine ganze Zahl ab 0 |
| `{TCLUTILS TUHASH ENCODING}` | `-encoding` weder `utf-8` noch `binary` |
| `{TCLUTILS TUUUID INVALID}` | `version` ohne UUID-Form |
| `{TCLUTILS TUUUID VERSION}` | `generate -version` weder 4 noch 7 |
| `{TCLUTILS TUDICT ARG}` | `getOr` ohne Schlüssel |
| `{TCLUTILS TUDIFF OPTION MAXCELLS}` | `-maxcells` keine positive ganze Zahl |
| `{TCLUTILS TUDIFF TOO_LARGE}` | Zeilen alt mal Zeilen neu über `-maxcells` |
| `{TCLUTILS TUXML NAME <name>}` | Elementname ungültig |
| `{TCLUTILS TUXML ATTR <name>}` | Attributname ungültig |
| `{TCLUTILS TUSQLITE EMPTY}` | `insert` ohne Spalte |
| `{TCLUTILS TUTDBC EMPTY}` | `tutdbc::insert` ohne Spalte |
| `{TCLUTILS TUMMDB FORMAT}` | Datei ist keine MaxMind-DB |
| `{TCLUTILS TUMMDB HANDLE}` | unbekanntes Handle bei `metadata` oder `lookup` |
| `{TCLUTILS TUICAL SYNTAX}` | iCalendar-Zeile ohne `:`, oder `END` ohne `BEGIN` |
| `{TCLUTILS TUICAL ARG}` | `newComponent` mit ungerader Eigenschaftsliste |
| `{TCLUTILS TUVCARD SYNTAX}` | vCard-Zeile ohne `:` |
| `{TCLUTILS TUNOTES NOTFOUND}` | Notiz oder Elter fehlt |
| `{TCLUTILS TUHOLIDAY YEAR}` | `easter` ohne Jahreszahl |
| `{TCLUTILS TUHOLIDAY REGION}` | `-region` ist nicht `de` |
| `{TCLUTILS TUDIAGRAM DUPID}` | Knoten-Id schon vorhanden |
| `{TCLUTILS TUDIAGRAM DIR}` | Richtung weder `LR`, `TB`, `RL` noch `BT` |
| `{TCLUTILS TUDIAGRAM ARG}` | Knotenform außerhalb der acht Namen |
| `{TCLUTILS TUFLOW BADID}` | ungültige Knoten-Id, etwa mit angehängtem `-…` |
| `{TCLUTILS TUFLOW EMPTY}` | Flowchart ohne Knoten |
| `{TCLUTILS TUFLOW UNSUPPORTED}` | `parse` auf einer Art, die nur `toSvg` zeichnet |
| `{TCLUTILS TUPIE EMPTY}` | Kreisdiagramm ohne Sektor |
| `{TCLUTILS TUPIE VALUE}` | negativer Wert, oder Sektoren summieren sich nicht positiv |
| `{TCLUTILS TUC4 EMPTY}` | C4 ohne Elemente |
| `{TCLUTILS TUSTR ARG}` | `isPrintable` nicht mit genau einem Zeichen; `truncate` mit negativer Länge |
| `{TCLUTILS TUPATH RELATIVE}` | `relative`: ein Pfad absolut, der andere relativ |
| `{TCLUTILS TUPATH ARGS}` | `commonPath` ohne Pfad |
| `{TCLUTILS TUPATH NOTLINK}` | `readlink` auf keiner symbolischen Verknüpfung |
| `{TCLUTILS TUDATE PARSE}` | `tudate::parse` liest das Datum nicht |
| `{TCLUTILS TUDATE UNIT}` | `tudate::add` mit unbekannter Einheit |
| `{TCLUTILS TUNUM DECIMALS}` | `format -decimals` keine ganze Zahl ab 0 |
| `{TCLUTILS TUNUM LOCALE}` | `parse`-Locale nicht `auto`/`de-strict`, oder `format`-Locale nicht `de` |
| `{TCLUTILS TUPDFTEXT FILE}` | PDF-Datei nicht lesbar |
| `{TCLUTILS TUPDFTEXT FORMAT}` | kein `%PDF-`-Kopf, keine Objekte oder keine Seiten |
| `{TCLUTILS TUPDFTEXT ENCRYPTED}` | PDF verschlüsselt |
| `{TCLUTILS TUPDFTEXT NOTEXT}` | keine Seite hat Text |
| `{TCLUTILS TUPDFTEXT OPTION}` | unbekannte Option oder fehlender Wert |
| `{TCLUTILS TUTESTRUN OPTION …}` | unbekannte Runner-Option |
| `{TCLUTILS TUTASK CANCELLED}` | Task abgebrochen oder Pool zerstört |
| `{TCLUTILS TUTASK TIMEOUT}` | `-timeout` von `await`/`wait` abgelaufen |
| `{TCLUTILS TUTASK NOTASK}` | `await` außerhalb einer Koroutine |
| `{TCLUTILS TUTASK NOTDONE}` | `result` eines laufenden Tasks |
| `{TCLUTILS TUTASK OPTION}` | falsches Argument (`spawn`, `timer`, `pipe`, `-timeout`) |
| `{TCLUTILS TUTASK NOTHREAD}` | `pool` ohne Paket `Thread` |
| `{TCLUTILS TUTASK EMPTY}` | `wait -mode first` auf leerer Gruppe |
| `{TCLUTILS TUTASK INIT}` | `-init` des Pools gescheitert |
| `{TCLUTILS TUTASK INSIDE}` | `destroy` aus dem eigenen Task |
| `{TCLUTILS TUTASK PROTOCOL}` | Koroutine unerwartet fortgesetzt |
| `{TCLUTILS TUTASK LIMIT COMMANDS}` | Befehlsgrenze der Sandbox |
| `{TCLUTILS TUTASK LIMIT TIME}` | Zeitgrenze der Sandbox |
| `{TCLUTILS TUPKGFINDER OPTION}` | unbekannte Option / falsche Anzahl |
| `{TCLUTILS TUPDF FORMAT}` | kein `%PDF-`-Kopf, oder `endobj` fehlt |
| `{TCLUTILS TUPDF ARG}` | Objektnummer ist keine ganze Zahl |
| `{TCLUTILS TUPDF NOTFOUND}` | Objektnummer nach dem Aufblasen nicht im Text |
| `{TCLUTILS TUNL START\|INCREMENT\|WIDTH}` | `tunl`: Start oder Schritt keine Ganzzahl, Breite keine Ganzzahl ab 1 |
| `{TCLUTILS TUTR RANGE}` | `tutr`: absteigender Bereich wie `c-a` |
| `{TCLUTILS TUTR SET2}` | `tutr`: leere zweite Menge ohne `-delete` |
| `{TCLUTILS TUTABLE COLUMNS}` | `tutable`: Zeile mit mehr Zellen als Köpfe |
| `{TCLUTILS TUTABLE HEADERS}` | `tutable`: leere Kopfliste |
| `{TCLUTILS TUAWK OPTION}` | `tuawk`: unbekannte Option oder Option ohne Wert |
| `{TCLUTILS TUAGREP MAXDIST}` | `tuagrep`: `-maxdist` keine Ganzzahl ab 0 |
| `{TCLUTILS TUSPLIT BYTES}` | `tusplit::splitBytes`: Zeichen über `\xFF` |
| `{TCLUTILS <MODUL> BYTES}` | Bytes erwartet, Zeichen über 255 gefunden (`tuhexdump`, `tuod`, `tustrings`, `tucmp`, `tuhexedit`, `tuxxhash`) |
| `{TCLUTILS TUHEXEDIT OFFSET\|RANGE\|ENCODING}` | ungültiger Offset; Schreiben über das Dateiende; Zeichen nicht kodierbar |
| `{TCLUTILS TUHEXDUMP OFFSET\|LENGTH}` | `-offset` bzw. `-length` ungültig |
| `{TCLUTILS TUCODE LOOKUP}` | `tucode::lookup`: leer oder außerhalb der Tabelle |
| `{TCLUTILS TUPNG CRC}` | PNG-Block mit falscher oder fehlender CRC |
| `{TCLUTILS TUCOLOR HSV}` | `fromHsv`: h nicht 0..360 oder s/v nicht 0..100 |
| `{TCLUTILS TUTABLEPNG PADDING\|SPACING}` | keine Ganzzahl ab 0 |
| `{TCLUTILS TUMONTHPNG YEAR\|FIRSTWEEKDAY}` | Jahr nicht 1..9999; erster Wochentag nicht 1..7 |
| `{TCLUTILS TUPNGPAD TRIM\|SQUARE\|SIZE}` | ungültiger Wert der Option |
| `{TCLUTILS TULAYOUT OPTION}` | `tulayout`: unbekannte Option oder Option ohne Wert |
| `{TCLUTILS TUAPPINFO OPTION\|VALUE}` | `tuappinfo`: unbekannte Option; ungültiger Wert |
| `{TCLUTILS TUDEPLOY VALUE}` | `-tmadd` oder `-fail` kein Wahrheitswert |
| `{TCLUTILS TUXXHASH OPTION\|ENCODING}` | `tuxxhash`: unbekannte Option; `-encoding` nicht `utf-8`/`binary` |
| `{TCLUTILS TULDIF CHANGETYPE}` | LDIF-Änderungssatz (`changetype:`) wird nicht gelesen |
| `{TCLUTILS TURRULE UNSUPPORTED}` | RRULE-Teil, den `turrule` nicht auswertet |
| `{TCLUTILS TURRULE BYDAY\|VALUE}` | unbekanntes Wochentagskürzel; ungültiger Wert |
| `{TCLUTILS TUBASE32 LENGTH\|BITS}` | Base32: unmögliche Länge; Füllbits nicht 0 |
| `{TCLUTILS TUDIAGRAM THEME}` | unbekanntes Diagramm-Theme |
| `{TCLUTILS TUJOURNEY VALUE}` | Bewertung keine Zahl 1..5 |
| `{TCLUTILS TUPROVIDER FTP NOPKG}` | FTP-Backend ohne tcllib-ftp |

`can't find package tclutils::…` — Modulpfad / `TCLUTILS_TM` prüfen
(Kapitel [Installation](020-installation.md)). Wortlaut der
`tutask`-Meldungen: Kapitel [Tasks mit tutask](085-tutask.md).

## Zusammenfassung

- Fehlercodes haben die Form `{TCLUTILS <MODUL> <GRUND>}`.
- Präfix-Traps (`trap {TCLUTILS TUFETCH}`) fangen ganze Gruppen.
