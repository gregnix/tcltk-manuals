# Multi-Entry Widgets for IP Addresses

## For Mentry Version 4.5

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [The mentry::ipAddrMentry Command](#the-mentry-ipaddrmentry-command)
- [The mentry::putIPAddr Command](#the-mentry-putipaddr-command)
- [The mentry::getIPAddr Command](#the-mentry-getipaddr-command)

[Start page](index.md)

---

## The `mentry::ipAddrMentry` Command

**NAME**
: `mentry::ipAddrMentry` – Create and manipulate mentry widgets for IP addresses

**SYNOPSIS**
: 

```
mentry::ipAddrMentry pathName ?options?
```

**DESCRIPTION**
: This command creates a new mentry widget `pathName` for displaying and editing IP addresses in the standard dotted-decimal notation.  The supported `options` are the same as in the case of the `mentry::mentry` command.

: The command sets the `type` attribute of the widget to the value `"IPAddr"` and returns the name of the newly created widget.

**DEFAULT BINDINGS**
: The `mentry::ipAddrMentry` command defines five new keyboard bindings for the entry components of the mentry widget it creates:  The `Up` key increments the entry's value by 1 if the latter is less than 255.  Similarly, the `Down` key decrements the entry's value by 1 if the latter is greater than 0.  The `Prior` key increments the entry's value by at most 10 if the latter is less than 255.  Similarly, the `Next` key decrements the entry's value by at most 10 if the latter is greater than 0.  If the entry is empty then all of these keys insert the value `0` into the entry.  Finally, `Control-v` (`Command-v` on the Mac) pastes the current contents of the clipboad into the mentry, provided that it is a valid IP address.

: The actions performed by the `Up` and `Down` keys can also be triggered with the aid of the mouse wheel or a two-finger gesture on the touchpad.  In addition, on Mac OS X/11+ Aqua, the actions performed by the `Prior` and `Next` keys are also triggered by the `<Option-MouseWheel>` event.  The same holds true on all windowing systems if the Tk version is 8.7a4 or later, where the `Option` modifier is bound to the `Option` key on Mac OS X/11+ and to the `Alt` key on Windows and X11.

**KEYWORDS**
: mentry, widget, IP address


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::putIPAddr` Command

**NAME**
: `mentry::putIPAddr` – Output an IP address to a mentry of type `"IPAddr"`

**SYNOPSIS**
: 

```
mentry::putIPAddr address pathName
```

**DESCRIPTION**
: This command outputs the IP address `address` to the mentry widget `pathName`, which must have been created with the `mentry::ipAddrMentry` command (this is checked by examining the widget's `type` attribute, which must have the value `"IPAddr"`).

: The command generates an error if the address is invalid.

**KEYWORDS**
: mentry, widget, IP address


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::getIPAddr` Command

**NAME**
: `mentry::getIPAddr` – Get an IP address from a mentry of type `"IPAddr"`

**SYNOPSIS**
: 

```
mentry::getIPAddr pathName
```

**DESCRIPTION**
: This command returns the IP address contained in the mentry widget `pathName`, which must have been created with the `mentry::ipAddrMentry` command (this is checked by examining the widget's `type` attribute, which must have the value `"IPAddr"`).

: If any entry component of the widget is empty, the command sets the focus to the first such entry, generates an error, and returns the string `"EMPTY"`.

**KEYWORDS**
: mentry, widget, IP address


[Contents](#contents)     [Start page](index.md)
