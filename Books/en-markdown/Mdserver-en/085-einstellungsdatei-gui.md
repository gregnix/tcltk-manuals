# Settings File and GUI

## Introduction

With access control, TLS and control port, the command line gets long.
The [settings file]{.index} holds all options, and `mdserver-gui.tcl`
edits it together with `zugriff.txt` and `benutzer.txt` in one window.

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

- One line per option: name without `--`, a space, the value up to the
  end of the line. `#` at the start of a line is a comment.
- A switch such as `no-log` has no value.
- Options not named keep their default.
- The command line wins: `--config mdserver.conf --port 9000`.
- Relative paths are relative to the **folder of the file**, not to the
  working directory. systemd and a manual start thus use the same file.
  `zugriff.txt`, `benutzer.txt` and the keys are best kept next to it.
- An unknown option, a number that is none, or an option given twice
  stops the start; the message names file and line (appendix *Error
  Messages*).

`mdctl.tcl reload` rereads only `zugriff.txt` and `benutzer.txt`.
Everything else in `mdserver.conf`, `control` itself included, takes
effect after a restart.

The unit then names only the file:

```ini
ExecStart=/usr/bin/tclsh /opt/mdserver/mdserver.tcl --config /etc/mdserver/mdserver.conf
ExecStop=/usr/bin/tclsh /opt/mdserver/mdctl.tcl --port 8099 stop
```

---

## mdserver-gui.tcl

```bash
wish mdserver-gui.tcl /etc/mdserver/mdserver.conf
```

Without a file, the GUI starts with a new `mdserver.conf` in the working
directory; "Speichern" (save) creates it. It needs only Tk (ttk), no
other packages, and runs under Tcl/Tk 8.6 and 9. Its labels are German;
the tabs:

| Tab | Content |
|---|---|
| Einstellungen (settings) | all options by group, with default and a short text |
| Benutzer (users) | create, groups, password, delete |
| Regeln (rules) | folder tree of the root and the rules from `zugriff.txt` |
| Wer sieht was (who sees what) | pick a reader; the tree shows what they see |
| Start | start command, systemd unit and `start.tcl` to copy; "Server neu laden" (reload server) |

The GUI hashes the password like `mdctl.tcl passwd`. It computes rights
with the same procedures as the server
(`lib/mdserver/access-0.5.tm`): what [who sees what]{.index} shows holds
in the browser too, even before saving. Only symlinks are checked by
the server alone.

In the *Regeln* tab, the root is given once as it is seen on this
machine; then the folder tree appears on the left. "Regel für den
Ordner…" (rule for the folder) creates a rule for the selected folder
or edits the existing one.

---

## Saving and checking

"Speichern" checks first. The result appears in a window whose text can
be selected and copied.

| Kind | Examples | Effect |
|---|---|---|
| error | `zugriff.txt` in the root, number expected | not saved |
| hint | no HTTPS, group nobody has, no rule for `/` | "Trotzdem speichern" (save anyway) or "Abbrechen" (cancel) |

When the rule for `/` is missing, the window offers "Regel / anlegen…"
(create rule for /). If the file has no `root`, the default `.` holds,
the folder of `mdserver.conf`; then `zugriff.txt` and `benutzer.txt`
next to it lie "in the root", and the message says so.

The old file is kept as `.bak`. Comments in `mdserver.conf` and at the
top of `zugriff.txt` and `benutzer.txt` stay; an option set to its
default disappears from `mdserver.conf`.

---

## Reloading the server

"Server neu laden" in the *Start* tab runs `mdctl.tcl … reload`, on
this machine or over ssh. It needs `control` in the settings and a
server started with it. The [control port]{.index} always listens on
`127.0.0.1` only, even with `bind *`; that is why reloading on another
machine goes through ssh and not directly over the network.

What only the GUI needs — the root on this machine, the ssh target, the
path of `mdserver.tcl` on the server — it remembers per settings file
in `~/.config/mdserver-gui/orte.txt`, not in `mdserver.conf`.

---

## Server on another machine

If mdserver runs, say, in an LXC container, its folder with the
settings and the root are mounted with [sshfs]{.index}:

```bash
# on the server
chown admin:mdserver /etc/mdserver /etc/mdserver/*
chmod 750 /etc/mdserver
chmod 640 /etc/mdserver/*

# here
mkdir -p ~/mnt/mdserver-conf ~/mnt/mdserver-docs
sshfs -o workaround=rename admin@server:/etc/mdserver ~/mnt/mdserver-conf
sshfs -o ro admin@server:/srv/md ~/mnt/mdserver-docs
wish mdserver-gui.tcl ~/mnt/mdserver-conf/mdserver.conf
```

- `workaround=rename` is needed because the GUI first writes
  `file.neu` and then renames it.
- In the *Regeln* tab the root is `~/mnt/mdserver-docs`; in the *Start*
  tab the ssh target (`admin@server`) and the path of `mdserver.tcl` on
  the server.
- "Server neu laden" then runs `ssh -o BatchMode=yes admin@server tclsh
  …/mdctl.tcl --port 8099 reload`. That needs an ssh key without a
  passphrase prompt.
- Paths in `mdserver.conf` are paths on the server. Absolute paths such
  as `/srv/md` are therefore not checked against the mounted folder.

---

## Summary

- `--config`: one option per line; the command line wins; relative
  paths from the folder of the file.
- `reload` rereads access and users only; everything else needs a
  restart.
- `mdserver-gui.tcl`: settings, users, rules, who sees what, start
  command; checks before saving, keeps `.bak`.
- Another machine: sshfs for the files, ssh for reloading.

---

*Next chapter: [Building a Site](090-site-aufbauen.md)*
