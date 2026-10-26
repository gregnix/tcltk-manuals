# Network and HTTPS

## tuhttps

[tuhttps]{.index} is the shared HTTPS policy for clients that
use `::http::register`. Certificates are verified; they can be turned off only
via `-insecure 1`. An internal CA is given with `-cafile`.
`tuhttps::with prefix script` registers `https` only for the duration
of a script and afterwards restores the previous registration, even
on errors. Do not use `return` in the script (comment in the code). An
application that itself registers `https` afterwards, or asynchronous
`::http::geturl -command` calls during `with`, are not seen by `tuhttps`:
the registration is temporary, not locked.

Clients: `tufetch`, `tudav`, `tupostgrest`. Raw REST without the
tclutils policy: book *Tcl REST*.

---

## tls 1.x and tls 2.0

| tls | CA store |
|---|---|
| 2.0 (Tcl 9) | OpenSSL default paths, no file needed |
| 1.x (Tcl 8.6, also Windows) | does not find the system store by itself |

Only under [tls]{.index} < 2.0 does `tuhttps` look for a CA bundle, in
this order: `$env(SSL_CERT_FILE)`, then fixed paths
(`/etc/ssl/certs/ca-certificates.crt`, `/etc/pki/tls/certs/ca-bundle.crt`,
`/etc/ssl/ca-bundle.pem`, `/etc/ssl/cert.pem`,
`/usr/local/etc/openssl/cert.pem`). If it finds none, it throws
`{TCLUTILS TUHTTPS NOCA}` and names the way out (`-cafile`,
`SSL_CERT_FILE`). It never falls back to "unverified". Under Windows with
tls 1.x: set `SSL_CERT_FILE` or pass `-cafile`.

Under Windows with tls 2.0, OpenSSL decides. If it finds no
store, the handshake fails. `-cafile` remains the way out.

---

## What socketCmd returns

`socketCmd` returns the command prefix for `::http::register`. It does not open
a socket. Under Tcl 8.6.18 with tls 2.0.1:

| Call | Prefix |
|---|---|
| `-host example.org` | `::tls::socket -autoservername 1 -require 1` |
| `-insecure 1 -host example.org` | `::tls::socket -autoservername 1 -request 0 -require 0` |
| `-host 127.0.0.1` | `::tls::socket -autoservername 0 -require 1` |

An IP gets no SNI (`-autoservername 0`). tls 2.0 and later appends no
`-cafile`. The `caFile` search runs anyway and returns the
first readable file. On this Linux that is
`/etc/ssl/certs/ca-certificates.crt`. It is needed only when
`socketCmd` sees a tls older than 2.0. An unreadable `-cafile`
throws `{TCLUTILS TUHTTPS CAFILE}` under tls 2 as well.

---

## tufetch

[tufetch]{.index} 0.4 fetches via native `http` + `tls`, otherwise via `curl`
or `wget`. All three ways verify the certificate. `-cafile` and
`-insecure` apply to all three.

| Command | Effect |
|---|---|
| `get url ?optionen?` | body as UTF-8 text |
| `download url pfad ?optionen?` | body as bytes into the file; returns `native`, `curl` or `wget` |

| Option | Default | Effect |
|---|---|---|
| `-timeout` | 30000 | milliseconds |
| `-redirects` | 5 | after that `{TCLUTILS TUFETCH REDIRECT}` |
| `-method` | `get` | `get` or `post` |
| `-headers` | | flat list name value |
| `-data` | | body, together with `-method post` |
| `-type` | | Content-Type of this body |
| `-cafile` | | CA file for verification |
| `-insecure` | 0 | any certificate is accepted |

If under tls 1.x no CA bundle at all is found, the native way steps aside and
`curl`/`wget` take over (they bring their own CA stores). If
neither of the two exists, `{TCLUTILS TUFETCH NOMETHOD}` comes with the way out
in the message (`no HTTP method available: …` plus the text of `NOCA`).
Entirely without tls and without curl/wget it reads
`no HTTP method available -- install the Tcl tls package or curl/wget`.

`{TCLUTILS TUFETCH CAFILE}`, in contrast, means: the file named with `-cafile`
is not readable. This code exists only on the native way, that is,
with `tls`. Without `tls`, `tufetch` passes the file on to curl
(`--cacert`) or wget (`--ca-certificate=`). An error from
curl then arrives as `CONNECT`, one from wget as `CHILDSTATUS` (according to
the code). `tuhttps` reports the case
as `{TCLUTILS TUHTTPS CAFILE}`. Without `tls` it reports
`{TCLUTILS TUHTTPS NOTLS}` there — the tls check runs before the
`-cafile` check.

Further codes from `tufetch`: `{TCLUTILS TUFETCH HTTP <Klasse> <Status>}`
(for example `HTTP 4XX 404`), `URL` (only `http://` and `https://`), `TIMEOUT`,
`CONNECT` and `REDIRECT`. Prefix traps such as `trap {TCLUTILS TUFETCH HTTP}`
catch a whole class. Via wget an HTTP status is not translated;
it appears as `CHILDSTATUS` from `exec`.

Without a server, these two errors remain:

```tcl
package require tclutils::tufetch
::tclutils::tufetch::get ftp://example.com/a
    ;# -> {TCLUTILS TUFETCH URL}  unsupported or invalid URL
::tclutils::tufetch::get https://example.com/ -cafile /gibt/es/nicht.pem
    ;# -> {TCLUTILS TUFETCH CAFILE}  cannot read CA file

package require tclutils::tuhttps
try {
    ::tclutils::tuhttps::socketCmd -cafile /gibt/es/nicht.pem
} trap {TCLUTILS TUHTTPS CAFILE} msg {
    puts "CA-Datei: $msg"
} trap {TCLUTILS TUHTTPS NOTLS} msg {
    puts "kein tls: $msg"
}
```

With tls the message reads `cannot read CA file: /gibt/es/nicht.pem`,
without tls `https needs the tls package: can't find package tls`. If
under tls 1.x no bundle at all is found, `NOCA` comes with the text to set
`-cafile` or `SSL_CERT_FILE`.

---

## tusparql

[tusparql]{.index} is a lean SPARQL client. The transport is
handled by `tufetch`, the query strings are built by `tuurl`, the result is read by
`tujson` (SPARQL 1.1 Query Results JSON). The same
prerequisites as for `tufetch` therefore apply: `http` with `tls`, otherwise `curl` or
`wget`. The module does not read XML results.

| Command | Effect |
|---|---|
| `query endpunkt sparql ?optionen?` | `SELECT`; list of dicts, per row variable to value |
| `ask endpunkt sparql ?optionen?` | `ASK`; `1` or `0` |

| Option | Default | Effect |
|---|---|---|
| `-method` | `get` | `post` sends the query as the body; any other value counts as `get` |
| `-timeout` | 30000 | milliseconds, passed on to `tufetch` |
| `-headers` | | further header lines, flat list name value; an `Accept` in it replaces `-accept` |
| `-accept` | `application/sparql-results+json` | value of the `Accept` header |

According to the code, `get` appends `?query=…&format=json` to the endpoint, with
`+` for the space. `post` sends the query raw with the
Content-Type `application/sparql-query`. `Accept` goes out exactly once:
if `-headers` already contains an `Accept` (in any
capitalization), that one applies, otherwise the value of `-accept`. `tusparql`
always reads the response as JSON. An endpoint that already has a
query string, such as `…/sparql?key=1`, gets the parameters appended
with `&`.

A result row contains only `value` per variable; `type`,
`datatype` and `xml:lang` are dropped. A variable without a binding, for example
behind `OPTIONAL`, is missing from the row's dict. The order of the
variables comes from `head vars`. If this list is missing, the
variables of all rows apply in the order of their first appearance,
not only those of the first row.

The example needs a reachable endpoint; the result depends
on its data and is therefore shown only in outline.

```tcl
package require tclutils::tusparql
set ep https://query.wikidata.org/sparql
set q {SELECT ?ort WHERE { ?ort wdt:P31 wd:Q515 } LIMIT 2}
::tclutils::tusparql::query $ep $q -timeout 10000
    ;# -> {ort http://www.wikidata.org/entity/Q…} {ort …}
::tclutils::tusparql::ask $ep {ASK { wd:Q64 wdt:P31 wd:Q515 }}
    ;# -> 1
```

The URL of a `get` call for `ASK {}` to
`https://example.org/sparql` is
`https://example.org/sparql?query=ASK+%7B%7D&format=json`. A response
with two rows, the second of which does not bind `gang`, yields
`{ort Nord gang 3} {ort Süd}`.

A response without `boolean` makes `ask` throw
`{TCLUTILS TUSPARQL NOTASK}`. Transport errors and HTTP status
come unchanged from `tufetch` (`{TCLUTILS TUFETCH …}`), a
response text that is not JSON as `{TCLUTILS TUJSON PARSE offset}`.
An unknown option throws `{TCLUTILS COMMON OPTION -name}`.

---

## Summary

- One place for HTTPS: `tuhttps`.
- tls 1.x needs a CA bundle; otherwise `NOCA` or `NOMETHOD`.
- `CAFILE` = `-cafile` not readable, not "CA missing".
- Keep `-insecure` deliberate and local.
- SPARQL: `tusparql` over `tufetch`, JSON results only, rows as dicts without type.
- Query strings: chapter [Encoding, Hashing and Comparing](052-kodierung-hash-vergleich.md) (`tuurl`).

---

*Next chapter: [tusettings](080-tusettings.md)*
