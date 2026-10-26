# Multi-Entry Widgets for IPv6 Addresses

## For Mentry Version 4.5

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [The mentry::ipv6AddrMentry Command](#the-mentry-ipv6addrmentry-command)
- The mentry::putIPv6Addr Command
- [The mentry::getIPv6Addr Command](#the-mentry-getipv6addr-command)

[Start page](index.md)

---

## The `mentry::ipv6AddrMentry` Command

**NAME**
: `mentry::ipv6AddrMentry` – Create and manipulate mentry widgets for IPv6 addresses

**SYNOPSIS**
: 

```
mentry::ipv6AddrMentry pathName ?options?
```

**DESCRIPTION**
: This command creates a new mentry widget `pathName` for displaying and editing IPv6 addresses in the standard hexadecimal notation (where the eight groups of one to four hexadecimal digits are separated from each other by o colon).  The supported `options` are the same as in the case of the `mentry::mentry` command.

: The command sets the `type` attribute of the widget to the value `"IPv6Addr"` and returns the name of the newly created widget.

**DEFAULT BINDINGS**
: The `mentry::ipv6AddrMentry` command defines five new keyboard bindings for the entry components of the mentry widget it creates:  The `Up` key increments the entry's value by 1 if the latter is less than 65535.  Similarly, the `Down` key decrements the entry's value by 1 if the latter is greater than 0.  The `Prior` key increments the entry's value by at most 10 if the latter is less than 65535.  Similarly, the `Next` key decrements the entry's value by at most 10 if the latter is greater than 0.  If the entry is empty then all of these keys insert the value `0` into the entry.  Finally, `Control-v` (`Command-v` on the Mac) pastes the current contents of the clipboad into the mentry, provided that it is a valid IPv6 address.

: The actions performed by the `Up` and `Down` keys can also be triggered with the aid of the mouse wheel or a two-finger gesture on the touchpad.  In addition, on Mac OS X/11+ Aqua, the actions performed by the `Prior` and `Next` keys are also triggered by the `<Option-MouseWheel>` event.  The same holds true on all windowing systems if the Tk version is 8.7a4 or later, where the `Option` modifier is bound to the `Option` key on Mac OS X/11+ and to the `Alt` key on Windows and X11.

**KEYWORDS**
: mentry, widget, IPv6 address


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::putIPv6Addr` Command

**NAME**
: `mentry::putIPv6Addr` – Output an IPv6 address to a mentry of type `"IPv6Addr"`

**SYNOPSIS**
: 

```
mentry::putIPv6Addr address pathName
```

**DESCRIPTION**
: This command outputs the IPv6 address `address` to the mentry widget `pathName`, which must have been created with the `mentry::ipv6AddrMentry` command (this is checked by examining the widget's `type` attribute, which must have the value `"IPv6Addr"`).

: The address is expected to consist of up to eight colon-separated groups of one to four hexadecimal digits each.  in case of less than eight groups, the address must include exactly one double-colon (`::`) (representing consecutive groups of zeros).  The command generates an error if the address is invalid.

**KEYWORDS**
: mentry, widget, IPv6 address


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::getIPv6Addr` Command

**NAME**
: `mentry::getIPv6Addr` – Get an IPv6 address from a mentry of type `"IPv6Addr"`

**SYNOPSIS**
: 

```
mentry::getIPv6Addr pathName
```

**DESCRIPTION**
: This command returns the IPv6 address contained in the mentry widget `pathName`, which must have been created with the `mentry::ipv6AddrMentry` command (this is checked by examining the widget's `type` attribute, which must have the value `"IPv6Addr"`).

: If any entry component of the widget is empty, the command sets the focus to the first such entry, generates an error, and returns the string `"EMPTY"`.

**KEYWORDS**
: mentry, widget, IPv6 address


[Contents](#contents)     [Start page](index.md)
