# HTTP Behaviour

## Introduction

Only `GET` and `HEAD`. Other valid methods: **405** with
`Allow: GET, HEAD`. `HEAD` has the same status and the same
`Content-Length` as `GET`, but no body — also for 206 and 404.

The `Server:` header comes from `package provide mdserver`, not from a
second number in the script.

---

## Routing

| URL | Behaviour |
|---|---|
| `/` | `index.md` or directory page |
| `/file.md` | Markdown → HTML |
| `/file` | clean URL: `/file.md` |
| `/directory` | 301 to `/directory/` |
| `/directory/` | `index.md`, else book landing page (with `book.tcl`), else directory page |
| `/book/index.md` without the file | book landing page, if `book.tcl` lies next to it |
| `/?q=words` | full-text search |
| `/?nav=index` | all documents as a tree |
| `/__mdserver/health` | `ok` or 503 |
| `.css` `.js` images `.pdf` | file |
| path with a dot component | 403 with `--dotfiles 0` |
| unknown | 404 |

A [clean URL]{.index} works in every style and in subfolders:
`/tcltk/dict` returns `tcltk/dict.md`. Meant for `nroff2md` (chapter
*Building a Site*). A 301 to a folder keeps the query string.

Directory page without `index.md`: in style `site` cards (books,
sections, documents, files), built by mdserver itself. In the older
styles a list with subfolders, Markdown titles from the H1 and a link
upwards, rendered through mdstack — with the same `?style=` parameters.

---

## Files

- **Range / 206:** `bytes=0-99`, `bytes=1000-`, `bytes=-50`. Large PDFs
  can be jumped through in the browser.
- **416** only when the range cannot be satisfied: start beyond the end
  of the file, or start after end. An unreadable `Range` header
  (`bytes=abc`) is ignored: 200 with the whole content.
- **If-Range:** if the validator does not match, 200 with the whole
  content (RFC 9110). Otherwise a viewer glues together pieces of two
  versions.
- **If-Modified-Since / 304:** unchanged files are not sent again.

---

## Limits

- Request line longer than `--maxline`: **414**.
- One header line longer than `--maxline`, or all headers together
  longer than `--maxheader`: **431**.
- After that the server goes on serving normally.

---

## Log

One line per request, flushed after each line (under systemd it would
otherwise show up only kilobytes later). Address = peer, or the first
`X-Forwarded-For` entry if the peer is listed in `--trusted-proxy`.

```
[09:15:03] 127.0.0.1 GET /index.md 200 6194 markdown
[09:15:04] 127.0.0.1 GET / 200 8120 search
[09:15:05] 127.0.0.1 GET /buch/ 200 7311 book landing
[09:15:06] 127.0.0.1 GET /tcltk 301 0 -> /tcltk/
[09:15:07] 127.0.0.1 GET /.env 403 89 hidden files are not served: /.env
[09:15:08] 127.0.0.1 GET /pdfs/handbuch.pdf 206 100 bytes 0-99/306855
[09:15:09] 10.1.2.3 GET / 200 13247 index.md
```

The note at the end says which way was taken:

| Note | Way |
|---|---|
| `markdown`, `index.md`, `book landing` | Markdown page, `index.md` of a folder, generated book landing page |
| `directory index`, `site index`, `search` | directory page, `Alle Dokumente`, search |
| MIME type (`application/pdf`) | whole file, also after an `If-Range` that does not match |
| `bytes A-B/SIZE`, `range` | 206, 416 |
| `not modified` | 304 |
| `-> /target/` | 301 |
| error text | 403 (dot file, symlink leading out) and 500 |

The last example line came through a proxy listed in
`--trusted-proxy`: it names the address from `X-Forwarded-For`.

The path is logged without the query string; a search is recognised by
the note `search`.

`--no-log` turns logging off.

---

## Summary

- GET and HEAD. Everything else 405 or no HTTP answer at all.
- Clean URLs without `.md`, also in subfolders.
- Range and 304 apply to files, not only to Markdown.
- 416 only for an unsatisfiable range; a broken Range header gives 200.

---

*Next chapter: [Control Port](060-control-port.md)*
