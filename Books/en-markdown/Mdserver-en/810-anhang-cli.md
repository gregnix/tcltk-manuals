# CLI

## Introduction

From `mdstack/tools/mdserver/`, unless stated otherwise.

---

## Start and Stop

```bash
tclsh mdserver.tcl --root /srv/md --port 8080 --bind 127.0.0.1 \
    --trusted-proxy 127.0.0.1 --control 8099 --title Dokumente
tclsh mdctl.tcl --port 8099 ping
tclsh mdctl.tcl --port 8099 stop
tclsh mdctl.tcl --host 127.0.0.1 --port 8099 --timeout 5000 stop
```

---

## PDF Search

```bash
TCLUTILS_TM=/opt/tclutils/lib/tm tclsh mdserver.tcl --root /srv/md
tclsh mdserver.tcl --root /srv/md --pdf-cache /var/cache/mdserver-pdf
tclsh mdserver.tcl --root /srv/md --pdf-search 1     # Warnung, wenn tclutils fehlt
tclsh mdserver.tcl --root /srv/md --pdf-search 0     # nur Markdown
tclsh mdserver.tcl --root /srv/md --pdf-worker 0     # PDFs im Serverprozess lesen
```

The comments mean: warning if tclutils is missing; Markdown only; read
PDFs in the server process.

---

## Locally

```bash
tclsh mdserver.tcl --root ../../docs --port 8080
tclsh mdserver.tcl --root demo/docs --port 8080
tclsh mdserver.tcl --help
```

---

## Style and Theme

```bash
tclsh mdserver.tcl --root /srv/md --theme dunkel            # site, dunkel
tclsh mdserver.tcl --root /srv/md --style plain             # früheres Aussehen
tclsh mdserver.tcl --root /srv/md --style sidebar --theme solarized
```

`--style plain` gives the earlier look.

---

## URLs

```
/?q=control+port                  Volltextsuche (auch PDFs, je Seite)
/?nav=index                       alle Dokumente
/doc.md?theme=dunkel              Dunkelmodus (site)
/doc.md?style=plain&toc=0         älterer Stil ohne TOC
/__mdserver/health                ok oder 503
```

In order: full-text search (also PDFs, per page), all documents, dark
mode (`site`), older style without TOC, health.

---

## Certificate

```bash
tclsh mkcert.tcl
tclsh mkcert.tcl --cn mdstack --san 192.168.1.50
tclsh mkcert.tcl --cn mdstack --san 192.168.1.50 --out /etc/mdserver
tclsh mkcert.tcl --check
```

---

## Tcl/Tk Manual

From `mdstack/tools/`:

```bash
tclsh nroff2md.tcl --batch tcltkdoc/ /srv/md/tcltk/ --linkmode file
```

---

*Next chapter: [Glossary](820-anhang-glossar.md)*
