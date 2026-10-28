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

`X-Forwarded-For` wird **nur** gelesen, wenn die Gegenstelle in
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

Versteckte Dateien: `--dotfiles` (Vorgabe aus). Jeder Pfad mit einem
Bestandteil, der mit einem Punkt beginnt (`/.git/HEAD`, `/a/.env`),
ist dann ebenfalls **403**. Die Suche lässt dieselben Ordner aus und
folgt keinem Symlink.

---

## Methoden und Grenzen

`POST` und andere Schreibmethoden: 405. Zeilen- und Kopfgrenzen:
`--maxline`, `--maxheader`. Slow-loris: Lese-Timeout, Coroutine pro
Verbindung.

---

## Zusammenfassung

- Loopback plus trusted-proxy, sonst lügt das Protokoll.
- 403 bei Symlink hinaus und bei Punkt-Dateien, nicht 200 mit
  `/etc/passwd` oder `/.git/config`.
- Proxy-Setup: Nachbarbücher, nicht hier noch einmal.

---

*Nächstes Kapitel: [Site aufbauen](090-site-aufbauen.md)*
