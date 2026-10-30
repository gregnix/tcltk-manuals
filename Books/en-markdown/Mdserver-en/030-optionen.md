# Options

## Introduction

`tclsh mdserver.tcl [options]`. An empty default for `--bind` and
`--trusted-proxy` means: all interfaces, `X-Forwarded-For` is ignored.

---

## Table

| Option | Default | Meaning |
|---|---|---|
| `--port` | `8080` | HTTP port |
| `--bind` | empty | listen address. Empty = all interfaces |
| `--dotfiles` | `0` | serve `.git`, `.env` |
| `--pdf-search` | `auto` | PDFs in the search: `auto` (when `tclutils::tupdftext` loads), `1`, `0` |
| `--pdf-cache` | `$HOME/.cache/mdserver-pdf` | cache for the PDF text, outside the root. Without `HOME`, below the working directory |
| `--pdf-worker` | `1` | read PDFs in a second `tclsh`; `0`: in the server process |
| `--office-search` | `auto` | `.odt`, `.ods`, `.odp`, `.docx`, `.xlsx` in the search: `auto` (each format whose module loads), `1`, `0` |
| `--csv-view` | `auto` | `.csv` as a table in style `site` and in the search: `auto` (when `tclutils::tucsv` 0.2 loads), `1`, `0` |
| `--trusted-proxy` | empty | peers whose `X-Forwarded-For` counts. Exact address, no mask |
| `--maxline` | `8190` | bytes per line. Request line over that: 414, header line over that: 431. `0` = no limit |
| `--maxheader` | `16384` | bytes of all headers; over that 431. `0` = no limit |
| `--healthpath` | `/__mdserver/health` | health path |
| `--root` | `.` | document root |
| `--theme` | `hell` | `hell`, `dunkel`, `solarized` (light, dark, solarized). In `site` only `dunkel` counts |
| `--style` | `site` | page style: `site`, `plain`, `sidebar`, `sticky`, `collapsible` |
| `--stylesdir` | `../styles` | CSS next to `lib/` |
| `--navbg` `--navfg` | `#2c3e50` `#ffffff` | colours of the nav bar, older styles only |
| `--navmax` | `6` | sections inline; more go into the dropdown. `0` = never fold. Older styles only |
| `--title` | `mdserver` | site title, in `site` on the left of the header bar |
| `--toc` | `1` | table of contents at the top, older styles only |
| `--control` | empty | control port, localhost only |
| `--no-log` | — | no access log |
| `--cert` `--key` | empty | TLS |
| `--tlsport` | `8443` | HTTPS port |
| `--help` | — | help |

Several proxies: `--trusted-proxy "127.0.0.1 10.0.0.5"`.

For `--pdf-search`, `--pdf-worker`, `--office-search` and `--csv-view`,
`off`, `no` and `false` also mean off. `--pdf-search 1` warns at the start when
`tclutils::tupdftext` is missing; `auto` then turns the search off
quietly.

---

## What Applies in Style `site`

The style `site` builds the page itself, with one stylesheet
(`styles/site.css`). Not every option takes effect there:

| Option | in `site` |
|---|---|
| `--theme dunkel` | dark mode for all pages |
| `--theme hell`, `solarized` | no effect; light or dark following the system setting |
| `--toc` | no effect; `Auf dieser Seite` stands on the right from three headings on |
| `--navbg` `--navfg` `--navmax` | no effect; `site` has a header bar of its own |
| `--title` | name on the left of the header bar and in the window title |

Theme names, `--toc` and the bar colours apply to `plain`, `sidebar`,
`sticky` and `collapsible`.

---

## `--dotfiles`

Off, because a root that is also a working copy would otherwise hand
out `/.git/config`. The search follows it: with `--dotfiles 0`, dot
folders stay out of what is searched.

---

## Summary

- The dangerous defaults are bind and trusted proxy: empty.
- The default style is `site`; `--style plain` gives the old look.
- Styles are in `tools/mdserver/styles/` next to `lib/`.
- The control port is optional, but the clean way to stop under systemd.

---

*Next chapter: [Navigation and Theme](040-navigation-theme.md)*
