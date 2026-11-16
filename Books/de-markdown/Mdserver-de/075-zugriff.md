# Zugriff

## Einführung

Ohne `--access` ist alles offen. Mit `--access` und `--users` meldet man
sich mit Name und Passwort an, und jeder sieht nur die Ordner seiner
[Gruppen]{.index}. Zwei Dateien steuern das:

| Datei | Option | Inhalt |
|---|---|---|
| `zugriff.txt` | `--access` | je Pfad die Gruppen, die ihn sehen |
| `benutzer.txt` | `--users` | je Benutzer die Gruppen und der Passwort-Hash |

Beide liegen **außerhalb** von `--root`. Liegt eine darin, startet der
Server nicht; er würde sie sonst ausliefern.

```bash
tclsh mdserver.tcl --root /srv/md --bind '*' \
    --cert /etc/mdserver/server.crt --key /etc/mdserver/server.key \
    --access /etc/mdserver/zugriff.txt --users /etc/mdserver/benutzer.txt \
    --control 8099
```

Die Anmeldung geht nur über HTTPS (Kapitel *TLS*). Bequemer als die
lange Befehlszeile ist eine Einstellungsdatei (Kapitel *Einstellungsdatei
und GUI*).

---

## zugriff.txt

Eine Zeile je Pfad: `pfad;gruppen`, Gruppen durch Leerzeichen getrennt.
`#` am Zeilenanfang ist Kommentar.

```
# pfad;gruppen
/;mitarbeiter
/oeffentlich/;gast
/fibu/;fibu management
/lohn/;lohn management
/technik/;technik
/__mdserver/;technik
```

Es gilt die **längste** passende Zeile. Ein Pfad passt auf sich selbst
und alles darunter: `/lohn/` gilt für `/lohn/januar.md` und
`/lohn/2026/februar.md`. Eine Zeile kann auch eine einzelne Datei nennen
(`/fibu/kontenplan.md;office fibu`). Mehrere Gruppen in einer Zeile
heißen „eine davon genügt“.

**Ein Pfad ohne passende Zeile ist für niemanden offen.** Darum gehört
fast immer eine [Grundregel]{.index} für `/` hinein. Fehlt sie, sieht
niemand etwas, auch die Startseite nicht; das Protokoll warnt beim
Start.

Zwei Gruppen hat jeder von selbst:

- [gast]{.index} — alle, auch ohne Anmeldung. Ein Ordner mit `gast` ist
  öffentlich.
- [mitarbeiter]{.index} — jeder, der angemeldet ist. Man trägt sie
  niemandem ein.

Alle anderen Gruppen stehen bei den Benutzern in `benutzer.txt`. Eine
Gruppe, die in `zugriff.txt` steht, aber bei keinem Benutzer, meldet das
Protokoll beim Start — meist ein Tippfehler. Eine Gruppe wie
`management` sieht nur, wo sie steht; soll sie alles sehen, gehört sie
in jede Zeile.

`/__mdserver/` betrifft den Status über HTTP (`--statuspath`). Ohne
eigene Zeile gilt dafür die Zeile für `/`. Der Health-Endpunkt bleibt
immer offen.

---

## benutzer.txt

```
# name;gruppen;hash
anna;office fibu;pbkdf2-sha256$5000$...
bernd;lohn;pbkdf2-sha256$5000$...
chef;management;pbkdf2-sha256$5000$...
```

Ein Klartext-Passwort steht nie in der Datei. Den Hash schreibt
[mdctl.tcl passwd]{.index}:

```bash
tclsh mdctl.tcl passwd --users /etc/mdserver/benutzer.txt anna "office fibu"
tclsh mdctl.tcl passwd --users /etc/mdserver/benutzer.txt anna
```

Die erste Zeile legt `anna` an, die zweite setzt ein neues Passwort; die
Gruppen bleiben, wenn keine angegeben sind. `mdctl.tcl` fragt das
Passwort zweimal, mindestens 8 Zeichen, unter Linux ohne Anzeige.
Gruppen ändern geht auch im Editor; einen Benutzer löschen heißt seine
Zeile löschen. Namen werden klein geschrieben und dürfen kein `:`, kein
`;` und keinen Leerraum enthalten.

Nach einer Änderung liest der laufende Server beide Dateien neu:

```bash
tclsh mdctl.tcl --port 8099 reload
```

Ist dabei eine Datei falsch, bleibt der alte Stand, und das Protokoll
nennt Datei und Zeile. Beim Start hält derselbe Fehler den Server an.

---

## Was „nicht sehen“ heißt

Was jemand nicht lesen darf, gibt es für ihn nicht:

- Es fehlt in Kopfleiste, Seitenleiste, Ordnerkacheln, *Alle
  Dokumente*, den Kapitelleisten der Bücher und den Titelvorschlägen
  des Suchfelds.
- Die Suche findet es nicht, auch nicht in Zählern, „Meinten Sie“ und
  Beispielen; das JSON der Suche nennt es nicht.
- Ein direkter Aufruf gibt **404**, wie für etwas, das es nicht gibt.
  Der Statuscode verrät nicht, ob der Pfad existiert.
- Ein Symlink zählt an beiden Enden: `/oeffentlich/x.md` als Verweis auf
  `/lohn/y.md` sieht nur, wer beide Ordner darf.

Suche (`/?q=`) und *Alle Dokumente* (`/?nav=index`) gehen auch ohne
Recht auf `/`; sie zeigen nur, was der Leser darf. Ein Gast findet so
die öffentlichen Seiten.

---

## Anmelden

- Ohne Anmeldung gibt ein Pfad, der nicht für `gast` offen ist, **401**;
  der Browser fragt nach Name und Passwort. Das gilt auch für Pfade, die
  es nicht gibt.
- In der Kopfleiste steht „Anmelden“ (`/__mdserver/login`) oder der Name
  dessen, der angemeldet ist.
- Abmelden kennt [HTTP Basic]{.index} nicht: den Browser schließen.
- **Nur über HTTPS.** Über HTTP ginge das Passwort lesbar durchs Netz.
  mdserver lehnt dort jede Anmeldung mit **403** ab und nennt den
  HTTPS-Port; Seiten für `gast` gehen weiter über HTTP. `--auth-http 1`
  hebt das auf, nur für einen Test auf `127.0.0.1`.
- **Fünf falsche Passwörter** von einer Adresse sperren sie für
  10 Minuten (**429**), auch für richtige Passwörter.

Ohne `--cert` und `--key` kann sich also niemand anmelden. Die
Startmeldung sagt es:

```
  Zugriff: zugriff.txt (6 Regeln), 3 Benutzer
  Achtung: Anmeldung nur ueber HTTPS, und HTTPS ist nicht aktiv (--cert/--key)
```

Mit `--bind '*'` warnt die Startmeldung ohne Zugriff vor einem offenen
Port (Kapitel *Starten*). Mit `--access` steht dort stattdessen:

```
  Netz:  von anderen Rechnern erreichbar (--bind *), mit Anmeldung (--access)
```

---

## Was der Server dabei rechnet

Das Passwort prüft [PBKDF2]{.index}-HMAC-SHA256 mit 5000 Runden, in
reinem Tcl. Das dauert etwa eine Sekunde. Währenddessen bedient der
Server die anderen Anfragen weiter; nur der, der sich anmeldet, wartet.
Danach merkt sich der Server die geprüfte Anmeldung 30 Minuten nach der
letzten Anfrage, als SHA-256, nicht das Passwort. Die Rundenzahl steht
im Hash (`pbkdf2-sha256$5000$…`) und gilt je Benutzer.

Mit Zugriffsschutz trägt jede Antwort `Cache-Control: private` und
`Vary: Authorization`, damit kein Zwischenspeicher eine Seite an den
Falschen gibt. Im Protokoll steht der Name vor der Adresse:

```
[09:12:04] anna@192.168.17.42 GET /fibu/buchung.md 200 16800 markdown
```

---

## Zusammenfassung

- `zugriff.txt`: `pfad;gruppen`, die längste Zeile gilt; ohne Zeile für
  `/` sieht niemand etwas.
- `gast` = alle, `mitarbeiter` = angemeldet; die übrigen Gruppen stehen
  in `benutzer.txt`.
- Hashes mit `mdctl.tcl passwd`, neu laden mit `mdctl.tcl reload`.
- Was jemand nicht darf, fehlt überall und gibt 404.
- Anmeldung nur über HTTPS; fünf Fehlversuche sperren 10 Minuten.
- Beide Dateien außerhalb der Wurzel.

---

*Nächstes Kapitel: [Hinter dem Proxy](080-hinter-proxy.md)*
