---
CommandName: udpcluster
ManualSection: n
Version: 0.3.4
TclPart: tcllib
TclDescription: Lightweight UDP based tool for cluster node discovery
Keywords:
 - name service
 - server
Copyright:
 - Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
---

# Name

udpcluster - UDP Peer-to-Peer cluster

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [udpcluster]{.lit} [0.3.4]{.optlit} 
[package]{.cmd} [require]{.sub} [ip]{.lit} 
[package]{.cmd} [require]{.sub} [nettool]{.lit} 
[package]{.cmd} [require]{.sub} [comm]{.lit} 
[package]{.cmd} [require]{.sub} [interp]{.lit} 
[package]{.cmd} [require]{.sub} [dicttool]{.lit} 
[package]{.cmd} [require]{.sub} [cron]{.lit} 
:::

# Description

This package is a lightweight alternative to Zeroconf. It utilizes UDP packets to populate a table of services provided by each node on a local network. Each participant broadcasts a key/value list in plain UTF-8 which lists what ports are open, and what protocols are expected on those ports. Developers are free to add any additional key/value pairs beyond those.

Using udpcluster.

For every service you wish to publish invoke:

```
cluster::publish echo@[cluster::macid] {port 10000 protocol echo}
```

To query what services are available on the local network:

```
set results [cluster::search PATTERN]
# And inside that result...
echo@LOCALMACID {
   port 10000
   protocol echo
}
```

To unpublish a service:

```
cluster::unpublish echo@[cluster::macid]
```

Results will Historical Notes:

This tool was originally known as nns::cluster, but as development progressed, it was clear that it wasn't interacting with any of the other facilities in NNS.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *nameserv* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
```
