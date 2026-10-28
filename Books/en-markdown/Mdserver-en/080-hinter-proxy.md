# Behind the Proxy

## Introduction

Public, or in the LAN with authentication: a reverse proxy in front,
mdserver on loopback. This chapter is the contract of the service.
nginx configuration, LXC and firewall are in *Nginx* and the LAN books.

---

## Bind and Forwarding

```bash
tclsh mdserver.tcl --root /srv/md --bind 127.0.0.1 --trusted-proxy 127.0.0.1
```

`X-Forwarded-For` is read **only** if the peer is listed in
`--trusted-proxy`. Otherwise anyone who reaches the port writes any
address they like into the log.

Only the **first** entry of the header counts. Everything after it may
have been set by the client itself.

Without `--trusted-proxy` the header is not read.

In nginx:

```nginx
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
```

---

## Paths and Symlinks

Directory traversal is blocked. Every path component is resolved and
checked against the root again: a link leading out of the root is
**403**. `--root /srv/md` does not match `/srv/mdxyz`.

Hidden files: `--dotfiles` (default off). Every path with a component
that starts with a dot (`/.git/HEAD`, `/a/.env`) is then also **403**.
The search leaves out the same folders and follows no symlink.

---

## Methods and Limits

`POST` and other writing methods: 405. Line and header limits:
`--maxline`, `--maxheader`. Slow loris: read timeout, one coroutine per
connection.

---

## Summary

- Loopback plus trusted proxy, otherwise the log lies.
- 403 for a symlink leading out and for dot files, not 200 with
  `/etc/passwd` or `/.git/config`.
- Proxy setup: neighbouring books, not repeated here.

---

*Next chapter: [Building a Site](090-site-aufbauen.md)*
