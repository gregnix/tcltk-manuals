---
CommandName: udp
ManualSection: n
Version: 1.0.14
TclPart: udp
TclDescription: Tcl UDP extension
Links:
 - socket
Keywords:
 - I/O
 - IP Address
 - TclUDP
 - UDP
 - asynchronous I/O
 - bind
 - channel
 - connection
 - domain
 - host
 - name
 - network
 - network address
 - networking
 - socket
 - udp
Copyright:
 - Copyright (c) 1999-2000 Columbia University; all rights reserved
---

# Name

udp - Create UDP sockets in Tcl

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit} 
[package]{.cmd} [require]{.sub} [udp]{.lit} [1.0.14]{.lit} 
[udp_open]{.cmd} [localport]{.optarg} [reuse]{.optlit} [ipv6]{.optlit} 
[udp_conf]{.cmd} [channel]{.arg} [host]{.arg} [port]{.arg} 
[udp_conf]{.cmd} [channel]{.arg} [optionName]{.optarg} [value]{.optarg} [optionName value]{.optdot} 
[udp_peek]{.cmd} [channel]{.arg} [buffersize]{.optarg} 
[::udp::build-info]{.cmd} 
[::udp::getaddrinfo]{.cmd} [-hostname]{.sub} [name]{.arg} [optionName value]{.optdot} 
[::udp::getnameinfo]{.cmd} [address]{.arg} [ipv6]{.optlit} 
:::

# Description

This package provides support for using UDP through Tcl. The package provides a new channel type and attempts to permit the use of packet oriented UDP over stream oriented Tcl channels. The package defined three commands but **udp_conf** should be considered depreciated in favor of the standard Tcl command **fconfigure**.

# Commands

**udp_open** ?*localport*? ?**reuse**? ?**ipv6**?
: **udp_open** will open a UDP socket. If a *localport* is specified the UDP socket will be opened on that port. Otherwise the system will choose a port and the user can use the **udp_conf** command to obtain the port number if required. The following keywords can be used to specify options on the opened socket.


**reuse**
: Using this keyword sets the SO_REUSEADDR socket option which permits multiple sockets to be bound to the same address/port combination.

**ipv6**
: By default a IPv4 socket is created. When keyword **ipv6** is specified, an IPv6 socket is opened.


**udp_conf** *channel* *host* *port*
: *Deprecated* in favor of the standard Tcl **fconfigure** or **chan configure** commands. **udp_conf** in this configuration is used to specify the remote destination for packets written to this *channel*. You must call this command before writing data to the UDP socket.

**udp_conf** *channel* *?optionName?* *?value?* *?optionName value ...?*
: *Deprecated* in favor of the standard Tcl **fconfigure** or **chan configure** commands. In addition to being used to configure the remote host, the **udp_conf** command is used to obtain information about the UDP socket. NOTE all these options are now available using the standard Tcl **fconfigure** or **chan configure** command.


**-myport**
: Returns the local port number of the socket. Read-only option.

**-remote** *?address port?*
: Specifies or returns the remote hostname and port number. Can also be set using **udp_conf** *channel* *host* *port*.

**-peer**
: Returns the remote hostname and port number for the packet most recently received by this socket. Read-only option.

**-family**
: Returns whether socket is configured for IPv4 or IPv6. Read-only option.

**-broadcast** *?boolean?*
: Specifies or returns whether can listen and send on the broadcast address. For some systems a flag must be set on the socket to use broadcast. This option is not permitted when using IPv6, instead use multicast.

**-ttl** *?count?*
: The time-to-live is given as the number of router hops the packet may do. For multicast packets this is important in specifying the distribution of the packet. The system default for multicast is 1 which restricts the packet to the local subnet. To permit packets to pass routers, you must increase the ttl. A value of 31 should keep it within a site, while 255 is global.

**-mcastadd** groupaddr
: ...see next...

**-mcastadd** "groupaddr netwif"
: ...see next...

**-mcastdrop** groupaddr
: ...see next...

**-mcastdrop** "groupaddr netwif"
: ...see next...

**-mcastgroups**
: **tcludp** sockets can support IPv4 and IPv6 multicast operations. To receive multicast packets the application has to notify the operating system that it should join a particular multicast group. For IPv4 these are specified as addresses in the range 224.0.0.0 to 239.255.255.255. When specifying only the *groupaddr* the system will determine the network interface to use. Specifying the *netwif* will join a multicast group on a specific network interface. This is useful on a multihomed system with multiple network interfaces. On windows you must specify the network interface index. For other platforms the network interface (e.g. 'eth0') name can be specified. To view the current set of multicast groups for a channel use *-mcastgroups*

**-mcastif**
: Returns which interface is used for outgoing multicast packets. UNIX only.

**-mcastloop** *?boolean?*
: With multicast udp the system can choose to receive packets that it has sent or it can drop them. This is known as multicast loopback and can be controlled using this option. By default the value is true and your application will receive its own transmissions.


**udp_peek** *channel* ?*buffersize*?
: Examine a packet without removing it from the buffer. Option *buffersize* specifies the maximum buffer size. Value must be between 0 and 16. This function is not available on windows.

**::udp::build-info**
: Return information on the build environment.

**::udp::getaddrinfo** **-hostname** *name* *?optionName value ...?*
: Returns a list with info on the IP address matching the specified parameters. Valid options are:


**-hostname** *name*
: Specifies which IP address to use for lookup. Can use IP address or name. Required option.

**-port** *number*
: Specifies which port number to use for lookup.

**-service** *name*
: Specifies which well-known service (i.e. http, https, etc.) to use for port in lookup.

**-ipv4**
: Only return IP v4 addresses.

**-ipv6**
: Only return IP v6 addresses.

**-server**
: Only return services for which hostname is a server.

**-tcp**
: Only return TCP services.

**-udp**
: Only return UDP services.


**::udp::getnameinfo** *address* **?ipv6?**
: **::udp::getnameinfo** will return the name(s) corresponding to IP address *address*. With *ipv6*, address is an IPv6 address.


# Examples

```
# Send data to a remote UDP socket
proc udp_puts {host port} {
    set s [udp_open]
    fconfigure $s -remote [list $host $port]
    puts $s "Hello, World"
    close $f
}
```

```
# A simple UDP server
package require udp

proc udpEventHandler {sock} {
    set pkt [read $sock]
    set peer [fconfigure $sock -peer]
    puts "$peer: [string length $pkt] {$pkt}"
    return
}

proc udp_listen {port} {
    set srv [udp_open $port]
    fconfigure $srv -buffering none -translation binary
    fileevent $srv readable [list ::udpEventHandler $srv]
    puts "Listening on udp port: [fconfigure $srv -myport]"
    return $srv
}

set sock [udp_listen 53530]
vwait forever
close $sock
```

```
# A multicast demo.
proc udpEvent {chan} {
    set data [read $chan]
    set peer [fconfigure $chan -peer]
    puts "$peer [string length $data] '$data'"
    if {[string match "QUIT*" $data]} {
        close $chan
        set ::forever 1
    }
    return
}

set group 224.5.1.21
set port  7771
set s [udp_open $port]
fconfigure $s -buffering none -blocking 0
fconfigure $s -mcastadd $group -remote [list $group $port]
fileevent $s readable [list udpEvent $s]
puts -nonewline $s "hello, world"
set ::forever 0
vwait ::forever
exit
```

# History

Some of the code in this extension is copied from Michael Miller's tcludp package. (http://www.neosoft.com/tcl/ftparchive/sorted/comm/tcludp-1.0/) Compared with Michael's UDP extension, this extension provides Windows support and provides the ability of using 'gets/puts' to read/write the socket. In addition, it provides more configuration ability.

Enhancements to support binary data and to setup the package for the Tcl Extension Architecture by Pat Thoyts.

Support for IPv6 and allowing a multicast join on a specific network interface is added by Huub Eikens.

# Copyright

```
Copyright (c) 1999-2000 Columbia University; all rights reserved
```
