# Einstellungsdatei und GUI

## Einführung

Mit Zugriff, TLS und Steuerport wird die Befehlszeile lang. Die
[Einstellungsdatei]{.index} nimmt alle Optionen auf, und
`mdserver-gui.tcl` bearbeitet sie zusammen mit `zugriff.txt` und
`benutzer.txt` in einem Fenster.

---

## mdserver.conf

```bash
tclsh mdserver.tcl --config /etc/mdserver/mdserver.conf
```

```
# /etc/mdserver/mdserver.conf
root           /srv/md
title          Dokumente
bind           *
cert           server.crt
key            server.key
control        8099
access         zugriff.txt
users          benutzer.txt
no-log
```

- Eine Zeile je Option: Name ohne `--`, Leerzeichen, Wert bis zum
  Zeilenende. `#` am Zeilenanfang ist Kommentar.
- Ein Schalter wie `no-log` steht ohne Wert.
- Nicht genannte Optionen haben ihre Vorgabe.
- Die Befehlszeile geht vor: `--config mdserver.conf --port 9000`.
- Relative Pfade gelten vom **Ordner der Datei** aus, nicht vom
  Arbeitsverzeichnis. systemd und die Hand starten so mit derselben
  Datei. `zugriff.txt`, `benutzer.txt` und die Schlüssel liegen am
  besten daneben.
- Eine unbekannte Option, eine Zahl, die keine ist, oder eine Option,
  die zweimal steht, hält den Start an; die Meldung nennt Datei und
  Zeile (Anhang *Fehlermeldungen*).

`mdctl.tcl reload` liest nur `zugriff.txt` und `benutzer.txt` neu.
Alles andere in `mdserver.conf`, auch `control` selbst, gilt erst nach
einem Neustart.

In der Unit steht dann nur noch die Datei:

```ini
ExecStart=/usr/bin/tclsh /opt/mdserver/mdserver.tcl --config /etc/mdserver/mdserver.conf
ExecStop=/usr/bin/tclsh /opt/mdserver/mdctl.tcl --port 8099 stop
```

---

## mdserver-gui.tcl

```bash
wish mdserver-gui.tcl /etc/mdserver/mdserver.conf
```

Ohne Datei beginnt die GUI mit einer neuen `mdserver.conf` im
Arbeitsverzeichnis; „Speichern“ legt sie an. Sie braucht nur Tk (ttk),
keine weiteren Pakete, und läuft unter Tcl/Tk 8.6 und 9.

| Reiter | Inhalt |
|---|---|
| Einstellungen | alle Optionen nach Gruppen, mit Vorgabe und kurzem Text |
| Benutzer | anlegen, Gruppen, Passwort, löschen |
| Regeln | Ordnerbaum der Wurzel und die Regeln aus `zugriff.txt` |
| Wer sieht was | einen Leser wählen; der Baum zeigt, was er sieht |
| Start | Startbefehl, systemd-Unit und `start.tcl` zum Kopieren; „Server neu laden“ |

Das Passwort hasht die GUI wie `mdctl.tcl passwd`. Rechte rechnet sie
mit denselben Prozeduren wie der Server
(`lib/mdserver/access-0.5.tm`): Was „[Wer sieht was]{.index}“ zeigt,
gilt auch im Browser, schon vor dem Speichern. Nur Symlinks prüft
allein der Server.

Im Reiter *Regeln* gibt man einmal die Wurzel an, wie sie auf diesem
Rechner zu sehen ist; dann erscheint links der Ordnerbaum. „Regel für
den Ordner…“ legt für den gewählten Ordner eine Regel an oder ändert
die vorhandene.

---

## Speichern und prüfen

„Speichern“ prüft vorher. Das Ergebnis steht in einem Fenster, aus dem
sich der Text markieren und kopieren lässt.

| Art | Beispiele | Folge |
|---|---|---|
| Fehler | `zugriff.txt` in der Wurzel, Zahl erwartet | nicht gespeichert |
| Hinweis | kein HTTPS, Gruppe hat niemand, keine Regel für `/` | „Trotzdem speichern“ oder „Abbrechen“ |

Fehlt die Regel für `/`, bietet das Fenster „Regel / anlegen…“ an.
Steht kein `root` in der Datei, gilt die Vorgabe `.`, also der Ordner
der `mdserver.conf`; dann liegen `zugriff.txt` und `benutzer.txt`
daneben „in der Wurzel“, und die Meldung sagt das dazu.

Die alte Datei bleibt als `.bak`. Kommentare in `mdserver.conf` und am
Anfang von `zugriff.txt` und `benutzer.txt` bleiben stehen; eine
Option mit dem Wert der Vorgabe verschwindet aus `mdserver.conf`.

---

## Server neu laden

„Server neu laden“ im Reiter *Start* ruft `mdctl.tcl … reload` auf, auf
diesem Rechner oder per ssh. Das braucht `control` in den Einstellungen
und einen Server, der damit gestartet wurde. Der
[Steuerport]{.index} horcht immer nur auf `127.0.0.1`, auch bei
`bind *`; darum läuft das Neuladen auf einem anderen Rechner über ssh
und nicht direkt übers Netz.

Was nur die GUI braucht — die Wurzel auf diesem Rechner, das ssh-Ziel,
den Pfad von `mdserver.tcl` auf dem Server —, merkt sie sich je
Einstellungsdatei in `~/.config/mdserver-gui/orte.txt`, nicht in
`mdserver.conf`.

---

## Server auf einem anderen Rechner

Läuft mdserver etwa in einem LXC-Container, hängt man dessen Ordner mit
den Einstellungen und die Wurzel per [sshfs]{.index} ein:

```bash
# auf dem Server
chown admin:mdserver /etc/mdserver /etc/mdserver/*
chmod 750 /etc/mdserver
chmod 640 /etc/mdserver/*

# hier
mkdir -p ~/mnt/mdserver-conf ~/mnt/mdserver-docs
sshfs -o workaround=rename admin@server:/etc/mdserver ~/mnt/mdserver-conf
sshfs -o ro admin@server:/srv/md ~/mnt/mdserver-docs
wish mdserver-gui.tcl ~/mnt/mdserver-conf/mdserver.conf
```

- `workaround=rename` braucht es, weil die GUI erst `datei.neu`
  schreibt und dann umbenennt.
- Im Reiter *Regeln* als Wurzel `~/mnt/mdserver-docs`, im Reiter *Start*
  das ssh-Ziel (`admin@server`) und den Pfad von `mdserver.tcl` auf dem
  Server.
- „Server neu laden“ ruft dann `ssh -o BatchMode=yes admin@server tclsh
  …/mdctl.tcl --port 8099 reload` auf. Das braucht einen ssh-Schlüssel
  ohne Passwortfrage.
- Pfade in `mdserver.conf` sind Pfade auf dem Server. Absolute Pfade
  wie `/srv/md` prüft die GUI darum nicht gegen den eingehängten Ordner.

---

## Zusammenfassung

- `--config`: eine Option je Zeile; Befehlszeile geht vor; relative
  Pfade vom Ordner der Datei aus.
- `reload` liest nur Zugriff und Benutzer neu; alles andere braucht einen
  Neustart.
- `mdserver-gui.tcl`: Einstellungen, Benutzer, Regeln, „Wer sieht was“,
  Startbefehl; prüft vor dem Speichern, behält `.bak`.
- Anderer Rechner: sshfs für die Dateien, ssh für das Neuladen.

---

*Nächstes Kapitel: [Site aufbauen](090-site-aufbauen.md)*
