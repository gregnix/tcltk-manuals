# Hinter dem Proxy

## Einführung

Öffentlich oder im LAN mit Anmeldung: Reverse-Proxy davor, mdserver auf
Loopback. Dieses Kapitel ist der Vertrag des Dienstes. nginx-Konfiguration,
LXC und Firewall stehen in *Nginx* und den LAN-Büchern.

---

## Bind und Weiterleitung

```bash
tclsh mdserver.tcl --root /srv/md --bind 127.0.0.1 --trusted-proxy 127.0.0.1
```

`--bind 127.0.0.1` ist die Vorgabe; es steht hier, damit die Zeile
nichts dem Zufall überlässt. `X-Forwarded-For` wird **nur** gelesen, wenn die Gegenstelle in
`--trusted-proxy` steht. Sonst schreibt jeder, der den Port erreicht,
eine beliebige Adresse ins Protokoll.

Nur der **erste** Eintrag des Kopfes zählt. Alles dahinter kann der
Klient selbst gesetzt haben.

Ohne `--trusted-proxy` wird der Kopf nicht gelesen.

In nginx:

```nginx
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
```

---

## Pfade und Symlinks

Directory Traversal ist gesperrt. Jeder Pfadbestandteil wird aufgelöst
und erneut gegen die Wurzel geprüft: ein Link aus der Wurzel hinaus ist
**403**. `--root /srv/md` passt nicht auf `/srv/mdxyz`.

Dasselbe gilt für alles, was mdserver auflistet: Kopfleiste,
Seitenleiste, Kacheln und *Alle Dokumente* zeigen von einem Link aus der
Wurzel hinaus weder Namen noch Titel. Ein Ordner-Link auf einen eigenen
Elternordner wird in diesen Listen übersprungen, statt im Kreis zu
laufen. Ist `--root` selbst ein Link, gilt sein Ziel als Wurzel.

Versteckte Dateien: `--dotfiles` (Vorgabe aus). Jeder Pfad mit einem
Bestandteil, der mit einem Punkt beginnt (`/.git/HEAD`, `/a/.env`),
ist dann ebenfalls **403**. Die Suche lässt dieselben Ordner aus und
folgt keinem Symlink.

---

## Methoden und Grenzen

`POST` und andere Schreibmethoden: 405. Zeilen- und Kopfgrenzen:
`--maxline`, `--maxheader`. Slow-loris: Lese-Timeout, Coroutine pro
Verbindung, dazu `--maxconn` (200) und `--maxperaddr` (32). Hinter dem
Proxy zählt `--maxperaddr` für dessen Adresse nicht, sofern sie in
`--trusted-proxy` steht; sonst wären nach 32 gleichzeitigen Nutzern alle
weiteren abgewiesen (Kapitel *HTTP-Verhalten*).

---

## Zusammenfassung

- Loopback plus trusted-proxy, sonst lügt das Protokoll.
- 403 bei Symlink hinaus und bei Punkt-Dateien, nicht 200 mit
  `/etc/passwd` oder `/.git/config`.
- Proxy-Setup: Nachbarbücher, nicht hier noch einmal.

---

*Nächstes Kapitel: [Site aufbauen](090-site-aufbauen.md)*
