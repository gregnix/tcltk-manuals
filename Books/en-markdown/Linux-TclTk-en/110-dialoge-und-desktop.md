# Native dialogs and desktop integration

## Introduction

On Windows and macOS, `tk_getOpenFile` calls the system's dialog.
On Linux there is no "system" in that sense, but GTK, Qt and the
desktop portals, and Tk uses none of them. Tk draws the standard
dialogs itself. Desktop integration also includes a `.desktop` file,
an icon, notifications and, from Tk 9 on, an icon in the panel and
printing via CUPS.

---

## The standard dialogs are Tk dialogs

```tcl
set datei [tk_getOpenFile -title "Öffnen" \
    -filetypes {{Tcl {.tcl}} {Alle *}}]
set ordner [tk_chooseDirectory -mustexist 1]
tk_messageBox -message "Gespeichert." -type ok
```

On X11, `tk_getOpenFile` leads to `::tk::dialog::file::`
(container check, body of the procedure under 8.6.14 and 9.0.4):

```tcl
if {$::tk_strictMotif} {
    return [::tk::MotifFDialog open {*}$args]
} else {
    return [::tk::dialog::file:: open {*}$args]
}
```

The dialog therefore looks the same on every Linux, regardless of
Xfce, GNOME or KDE. It knows no bookmarks of the file manager and
no network locations from GVfs. `tk_messageBox`, `tk_chooseColor` and
`tk fontchooser` are Tk dialogs as well.

A peculiarity of the X11 file dialog: by default it **shows** hidden
files (dot files). The source of `tkfbox.tcl` (8.6.14 and 9.0.4)
contains `showHiddenVar 1` and `showHiddenBtn 0`. To hide them and
offer a toggle, load the dialog once and set both variables:

```tcl
catch {tk_getOpenFile -gibtsnicht}      ;# loads tkfbox.tcl
set ::tk::dialog::file::showHiddenVar 0
set ::tk::dialog::file::showHiddenBtn 1
```

`serie-linux` (howto 11) opens the dialogs only when `SERIES_AUTO`
is not set. In the container they were not opened.

If you want the desktop's dialog, call a helper program, such as
`zenity --file-selection` (GTK) or `kdialog --getopenfilename` (KDE),
via `exec` and read the output. Both were missing in the container. On
the workstation (Xfce) `zenity` 4.2.2 is installed, `kdialog` is missing.
`zenity --file-selection` from `wish` 8.6.18, 9.0.4 and 9.1.0, identical:

| Call | File chosen | Cancel |
|---|---|---|
| `exec zenity …` | `catch` 1, result path **plus** GTK warning, `-errorcode NONE` | `catch` 1, `CHILDSTATUS … 1` |
| `exec -ignorestderr zenity …` | `catch` 0, result only the path | `catch` 1, `child process exited abnormally` |

GTK writes a warning to stderr on every call
(`Gtk-WARNING … Failed to measure available space`). Without
`-ignorestderr`, `exec` turns this into an error, even if a file
was chosen. Therefore:

```tcl
proc dateiWaehlen {} {
    if {[catch {exec -ignorestderr zenity --file-selection} pfad]} {
        return ""          ;# Cancel: exit 1
    }
    return $pfad
}
```

Check beforehand which helper program is available:

```tcl
foreach p {zenity kdialog} {
    if {[auto_execok $p] ne ""} { set hilfe $p; break }
}
```

---

## The .desktop file

A program appears in the start menu through a
[`.desktop`]{.index} file according to the Desktop Entry Specification.
For one user it lives in `~/.local/share/applications/`, for all users in
`/usr/share/applications/`. Template `beispiele/meinapp.desktop`:

```text
[Desktop Entry]
Type=Application
Name=MeineApp
Name[de]=Meine Anwendung
Comment=Beispiel aus "Tcl/Tk unter Linux"
Exec=/opt/meineapp/bin/meineapp %F
Icon=meineapp
Terminal=false
Categories=Utility;
StartupWMClass=Meineapp
```

Notes on the keys:

- `Exec` with a full path. A program started from the start menu gets
  the session's `PATH`, not the one from `~/.bashrc`. A
  `/opt/tcl9/bin` that is only at the front in the shell is missing there.
  `%F` passes on selected files.
- `Icon` without extension and without path searches the icon theme, e.g.
  `~/.local/share/icons/hicolor/48x48/apps/meineapp.png`. A full
  path works too.
- [`StartupWMClass`]{.index} connects the running window with the
  entry, so that the panel shows the right icon. The value is the
  class from `WM_CLASS`. A program started with `wish9.0 meineapp.tcl`
  has the class `Meineapp.tcl`; with `-name meineapp` it becomes
  `Meineapp`. See
  [X11, window managers and Wayland](080-x11-fenstermanager-wayland.md).

Check with `desktop-file-validate` from the package `desktop-file-utils`.
`serie-xfce` (howto 07) writes a minimal file
(`Type`, `Name`, `Exec=true`, `Terminal`, `Categories`) and checks it
with that; under Xfce 4.20 without a message. In the container the tool
was missing. The template above, `beispiele/meinapp.desktop`, passes on
the workstation without a message, exit 0.

---

## Window icon

```tcl
image create photo ikon -file [file join $hier meineapp.png]
wm iconphoto . -default ikon
```

`-default` applies to all later toplevels. On X11, Tk puts the image
into the property `_NET_WM_ICON`; the panel takes it if it finds no
better entry via `StartupWMClass`. In the container the call ran
without error; without a panel the icon is not visible.
Several sizes in one call (`wm iconphoto . -default ikon16
ikon32 ikon48`) leave the choice to the desktop.

---

## Notifications

Two ways: the program `notify-send` and, from Tk 9 on, `tk sysnotify`.

`serie-xfce` (howto 06) calls under Xfce 4.20:

```tcl
exec {*}[auto_execok notify-send] -t 1000 -e --app-name meineapp \
    "Titel" "Text"
```

There the service is provided by `xfce4-notifyd`. `notify-send` needs
the session D-Bus. In the container without a session it ends with

```text
Failed to execute child process “dbus-launch” (No such file or directory)
```

and exit status 1.

[`tk sysnotify`]{.index} loads `libnotify.so.4` (or older versions)
at runtime on X11 via `Tcl_LoadFile`; Tk is not linked against it
(source `tkUnixSysNotify.c`). If that succeeds, the command
`::tk::sysnotify::_sysnotify` exists, and the message goes to
libnotify. If the library is missing, Tk draws its own borderless
window at the top right that fades out after a while (`systray.tcl`,
procedure `_notifywindow`).

Container check with 9.0.4: `libnotify4` is installed,
`_sysnotify` is present. `tk sysnotify Titel Text` returns without an
error, but nothing appears, and no window is left behind:
without D-Bus, libnotify has nobody to hand the message to. A
program learns nothing about this. `tk sysnotify` has not been checked
with Xfce.

---

## Icon in the panel

`tk systray` creates an icon in the system tray on X11.
For this, Tk uses the system tray protocol (XEmbed), taken over
from the package tktray (source `tkUnixSysTray.c`). Container check
with 9.0.4:

```tcl
image create photo ikon -width 16 -height 16
tk systray exists                       ;# 0
tk systray create -image ikon -text Probe
tk systray exists                       ;# 1
```

`exists` reports 1, although no system tray is running in the
container. The value only says that `create` has run, not that
anybody shows the icon. Tk 8.6 does not have the command
("unknown or ambiguous subcommand "systray""). On the workstation
(Xfce, 9.0.4 and 9.1.0) likewise `exists` 1 after `create`; the text from
`-text` is the tooltip and does not appear as a window name in the
window tree. Whether the Xfce panel shows the icon has not been checked
visually.

---

## Printing

`tk print` exists from Tk 9 on. On X11 it shows its own
Tk dialog and prints via the commands `lpstat` and `lpr` of
[CUPS]{.index} (source `print.tcl`). A canvas goes to the printer as
PostScript, a text widget as text. Container check without CUPS:

```text
tk print                     wrong # args: should be "tk print w"
::tk::print::cups            Tcl-Ensemble (lpstat/lpr)
::tk::print::cups getprinters
    Unable to obtain the list of printers. Command "lpstat" not found.
    Please install the CUPS package for your system.
```

The printer list comes from `lpstat -e`, the default printer from
`lpstat -d`. Printing via CUPS, PDF routes and label printers are
covered in the book *Printing*.

---

## Summary

- `tk_getOpenFile` and its relatives are Tk dialogs on X11, not
  GTK or Qt dialogs. Hidden files are visible until
  `showHiddenVar` is 0.
- `.desktop` in `~/.local/share/applications`, `Exec` with a full path,
  `StartupWMClass` equal to the class from `WM_CLASS`.
- `notify-send` and `tk sysnotify` need the session D-Bus.
  `tk sysnotify` stays silent if it is missing.
- `tk systray exists` says nothing about visibility.
- `tk print` on X11: CUPS commands `lpstat` and `lpr`.

---

*Next chapter: [Xfce from Tcl](120-xfce.md)*
