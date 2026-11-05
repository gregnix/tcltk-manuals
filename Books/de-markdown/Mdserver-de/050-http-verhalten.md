# HTTP-Verhalten

## Einführung

Nur `GET` und `HEAD`. Andere gültige Methoden: **405** mit
`Allow: GET, HEAD`. `HEAD` hat denselben Status und dieselbe
`Content-Length` wie `GET`, aber keinen Körper — auch bei 206 und 404.

Der Kopf `Server:` kommt aus `package provide mdserver`, nicht aus einer
zweiten Zahl im Skript.

---

## Routing

| URL | Verhalten |
|---|---|
| `/` | `index.md` oder Verzeichnisseite |
| `/datei.md` | Markdown → HTML |
| `/datei` | Clean URL: `/datei.md` |
| `/verzeichnis` | 301 auf `/verzeichnis/` |
| `/verzeichnis/` | `index.md`, sonst Buch-Startseite (mit `book.tcl`), sonst Verzeichnisseite |
| `/buch/index.md` ohne Datei | Buch-Startseite, wenn `book.tcl` daneben liegt |
| `/?q=Wörter` | Volltextsuche |
| `/?q=Wörter&format=json` | Suche als JSON |
| `/tabelle.csv`, `/brief.docx` … | Tabellen- bzw. Textseite (`--csv-view`, `--office-view`) |
| `/tabelle.csv?raw=1` | die Datei selbst |
| `/?nav=index` | alle Dokumente als Baum |
| `/__mdserver/health` | `ok` oder 503 |
| `--statuspath` | Status als Text, nur wenn eingeschaltet |
| `.css` `.js` Bilder `.pdf` | Datei |
| Pfad mit Punkt-Bestandteil | 403 bei `--dotfiles 0` |
| unbekannt | 404 |

Eine [Clean URL]{.index} gilt in jedem Stil und in Unterordnern:
`/tcltk/dict` liefert `tcltk/dict.md`. Gedacht für `nroff2md`
(Kapitel *Site aufbauen*). Ein 301 auf einen Ordner behält den
Query-String.

Verzeichnisseite ohne `index.md`: im Stil `site` Kacheln (Bücher,
Bereiche, Dokumente, Dateien), gebaut von mdserver selbst. In den
älteren Stilen eine Liste mit Unterordnern, Markdown-Titeln aus H1 und
Link nach oben, gerendert über mdstack — mit denselben
`?style=`-Parametern.

---

## Dateien

- **Range / 206:** `bytes=0-99`, `bytes=1000-`, `bytes=-50`. Große PDFs
  im Browser springbar.
- **416** nur, wenn der Bereich nicht erfüllbar ist: Anfang hinter dem
  Dateiende oder Anfang nach Ende. Ein unlesbarer `Range`-Kopf
  (`bytes=abc`) wird übergangen: 200 mit dem ganzen Inhalt.
- **If-Range:** passt der Validator nicht, kommt 200 mit dem ganzen
  Inhalt (RFC 9110). Sonst klebt ein Viewer Stücke zweier Fassungen.
- **If-Modified-Since / 304:** unveränderte Dateien nicht neu senden.

---

## Grenzen

- Anfragezeile länger als `--maxline`: **414**.
- Eine Kopfzeile länger als `--maxline` oder alle Köpfe zusammen länger
  als `--maxheader`: **431**.
- Danach bedient der Server normal weiter.

Dazu kommen [Verbindungsgrenzen]{.index}. mdserver hält je offener
Verbindung eine Coroutine, bis die Anfrage da ist oder das Lese-Timeout
(15 s) greift. Wer viele Verbindungen öffnet und nichts schickt, würde
den einen Thread sonst allein beschäftigen.

| Option | Vorgabe | darüber |
|---|---|---|
| `--maxconn` | 200 insgesamt | **503** mit `Retry-After: 1` |
| `--maxperaddr` | 32 je Absenderadresse | **503** mit `Retry-After: 1` |

Über der Grenze antwortet mdserver, ohne die Anfrage zu lesen, und
schließt. Das Protokoll nennt Adresse und Grund:

```
[09:20:11] 503 127.0.0.1 -- zu viele Verbindungen von 127.0.0.1 (32)
```

Hinter einem Proxy kommen alle Anfragen von dessen Adresse. Darum
zählen Adressen aus `--trusted-proxy` nicht je Absender, nur insgesamt.

---

## Antwortzeiten

Viele kleine Anfragen gleichzeitig sind kein Problem. Eine teure Anfrage
aber hält alle anderen auf, bis sie fertig ist; es gibt nur einen
Thread. Die Zahlen stammen von einem Rechner mit zwei Kernen, Tcl 8.6,
Markdown-Dateien zu je etwa 5 KB:

| Lage | 3 000 Dateien | 30 000 Dateien |
|---|---|---|
| kleine Seite, ruhig | 5 ms | 5 ms |
| 20 Klienten gleichzeitig, kleine Seite | 0,1 s für alle | 0,1 s für alle |
| Suchindex nach dem Start (im Hintergrund) | 4–8 s | etwa 45 s |
| kleine Seite, während der Index entsteht | 10 ms | 10 ms |
| Suche | 0,1 s | 1 s |
| Suche ohne Treffer, mit „Meinten Sie“ | 0,1 s | 1 s |
| *Alle Dokumente* | 0,1–0,2 s | 0,8 s |

Unter Tcl 9.0 liegen die Werte in derselben Größenordnung. Eine `.xlsx`
mit 20 000 Zeilen als Seite kostet beim ersten Aufruf 4,5–7 s, danach
10 ms (`--viewcache`, Kapitel *Seitenlayout und Suche*).

---

## Protokoll

Eine Zeile je Anfrage, nach jeder Zeile Flush (unter systemd sonst erst
Kilobytes später sichtbar). Adresse = Gegenstelle, oder der erste
`X-Forwarded-For`, wenn die Gegenstelle in `--trusted-proxy` steht.

```
[09:15:03] 127.0.0.1 GET /index.md 200 6194 markdown
[09:15:04] 127.0.0.1 GET / 200 8120 search
[09:15:05] 127.0.0.1 GET /buch/ 200 7311 book landing
[09:15:06] 127.0.0.1 GET /tcltk 301 0 -> /tcltk/
[09:15:07] 127.0.0.1 GET /.env 403 89 hidden files are not served: /.env
[09:15:08] 127.0.0.1 GET /pdfs/handbuch.pdf 206 100 bytes 0-99/306855
[09:15:09] 10.1.2.3 GET / 200 13247 index.md
```

Die Notiz am Ende sagt, welcher Weg genommen wurde:

| Notiz | Weg |
|---|---|
| `markdown`, `index.md`, `book landing` | Markdown-Seite, `index.md` eines Ordners, erzeugte Buch-Startseite |
| `directory index`, `site index`, `search` | Verzeichnisseite, *Alle Dokumente*, Suche |
| `view csv`, `view xlsx` … | Tabellen- oder Textseite einer CSV- oder Office-Datei |
| MIME-Typ (`application/pdf`) | ganze Datei, auch nach einem `If-Range`, der nicht passt |
| `bytes A-B/GRÖSSE`, `range` | 206, 416 |
| `not modified` | 304 |
| `-> /ziel/` | 301 |
| Fehlertext | 403 (Punkt-Datei, Symlink hinaus) und 500 |

Die letzte Beispielzeile kam über einen Proxy aus `--trusted-proxy`: Sie
nennt die Adresse aus `X-Forwarded-For`.

Der Pfad steht ohne Query-String da; eine Suche erkennt man an der
Notiz `search`.

`--no-log` schaltet ab.

---

## Zusammenfassung

- GET und HEAD. Alles andere 405 oder gar keine HTTP-Antwort.
- Clean URLs ohne `.md`, auch in Unterordnern.
- Range und 304 gelten für Dateien, nicht nur für Markdown.
- 416 nur bei unerfüllbarem Bereich; kaputter Range-Kopf gibt 200.
- Zu viele offene Verbindungen: sofort 503 (`--maxconn`, `--maxperaddr`).
- Eine teure Anfrage hält die anderen auf; die Suche bei 30 000 Dateien
  etwa 1 s.

---

*Nächstes Kapitel: [Control-Port](060-control-port.md)*
