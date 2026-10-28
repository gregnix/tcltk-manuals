# CLI

## Einführung

Aus `mdstack/tools/mdserver/`, sofern nicht anders angegeben.

---

## Start und Stop

```bash
tclsh mdserver.tcl --root /srv/md --port 8080 --bind 127.0.0.1 \
    --trusted-proxy 127.0.0.1 --control 8099 --title Dokumente
tclsh mdctl.tcl --port 8099 ping
tclsh mdctl.tcl --port 8099 stop
tclsh mdctl.tcl --host 127.0.0.1 --port 8099 --timeout 5000 stop
```

---

## PDF-Suche

```bash
TCLUTILS_TM=/opt/tclutils/lib/tm tclsh mdserver.tcl --root /srv/md
tclsh mdserver.tcl --root /srv/md --pdf-cache /var/cache/mdserver-pdf
tclsh mdserver.tcl --root /srv/md --pdf-search 1     # Warnung, wenn tclutils fehlt
tclsh mdserver.tcl --root /srv/md --pdf-search 0     # nur Markdown
tclsh mdserver.tcl --root /srv/md --pdf-worker 0     # PDFs im Serverprozess lesen
```

---

## Lokal

```bash
tclsh mdserver.tcl --root ../../docs --port 8080
tclsh mdserver.tcl --root demo/docs --port 8080
tclsh mdserver.tcl --help
```

---

## Stil und Theme

```bash
tclsh mdserver.tcl --root /srv/md --theme dunkel            # site, dunkel
tclsh mdserver.tcl --root /srv/md --style plain             # früheres Aussehen
tclsh mdserver.tcl --root /srv/md --style sidebar --theme solarized
```

---

## URLs

```
/?q=control+port                  Volltextsuche (auch PDFs, je Seite)
/?nav=index                       alle Dokumente
/doc.md?theme=dunkel              Dunkelmodus (site)
/doc.md?style=plain&toc=0         älterer Stil ohne TOC
/__mdserver/health                ok oder 503
```

---

## Zertifikat

```bash
tclsh mkcert.tcl
tclsh mkcert.tcl --cn mdstack --san 192.168.1.50
tclsh mkcert.tcl --cn mdstack --san 192.168.1.50 --out /etc/mdserver
tclsh mkcert.tcl --check
```

---

## Tcl/Tk-Handbuch

Aus `mdstack/tools/`:

```bash
tclsh nroff2md.tcl --batch tcltkdoc/ /srv/md/tcltk/ --linkmode file
```

---

*Nächstes Kapitel: [Glossar](820-anhang-glossar.md)*
