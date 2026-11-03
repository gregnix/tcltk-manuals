# Mouse, keyboard, clipboard

## Introduction

Three places where Linux code looks different from code for Windows
or macOS: the mouse wheel, which arrives as a mouse button under X11;
the modifiers, whose names do not mean a fixed key under X11; and the
two clipboards PRIMARY and CLIPBOARD. For the mouse wheel and for
`Command`, Tk 8.6 and Tk 9 have made different decisions.

All values in this chapter were determined in the container with
`beispiele/rad-und-tasten.tcl` and `beispiele/auswahl-probe.tcl`.
The scripts use `xdotool` to send real X events to their own window.
The keyboard layout of the Xvfb is the default `pc105`, `us`.

---

## The mouse wheel

X11 has no wheel event. The X server reports each notch as a press
and release of a mouse button: 4 up, 5 down, 6 and 7 for tilting
sideways. Tk 8.6 passes this on as is. Tk 9 translates it into
[`MouseWheel`]{.index} as on Windows and macOS (source `tkEvent.c`:
buttons 4 to 7 become `MouseWheelEvent` on press, with `%D` equal to
±120, 6 and 7 additionally get Shift; the release is discarded).

Container check:

| X button | Tk 8.6.14 | Tk 9.0.4 |
|---------|-----------|----------|
| 4 (up) | `<Button-4>`, `%b`=4 | `<MouseWheel>`, `%D`=120 |
| 5 (down) | `<Button-5>`, `%b`=5 | `<MouseWheel>`, `%D`=-120 |
| 6 (left) | `<Button-4>`, `%s`=1 (Shift) | `<Shift-MouseWheel>`, `%D`=120 |
| 7 (right) | `<Button-5>`, `%s`=1 (Shift) | `<Shift-MouseWheel>`, `%D`=-120 |
| 8 (side button "Back") | `<ButtonPress>`, `%b`=8 | **`<Button-4>`**, `%b`=8 |
| 9 (side button "Forward") | `<ButtonPress>`, `%b`=9 | **`<Button-5>`**, `%b`=9 |

The last two rows are the pitfall. Tk 9 has freed the numbers 4 and 5
and assigned them to buttons 8 and 9. Old code with

```tcl
bind .c <Button-4> {.c yview scroll -1 units}
bind .c <Button-5> {.c yview scroll  1 units}
```

no longer scrolls with the wheel under Tk 9, but with the side
buttons of a mouse. An `event generate .l <Button-4>` also gives
`%b`=8 under Tk 9. Tk 8.6, on the other hand, rejects `<Button-8>`
("bad button number "8"").

The class bindings of `Text` (`bind Text`) show the same difference:

```text
8.6.14  <Shift-Button-5> <Shift-Button-4>
        <Button-5> <Button-4>
        <Shift-MouseWheel> <MouseWheel>
9.0.4   <Shift-Alt-MouseWheel> <Shift-MouseWheel>
        <Alt-MouseWheel> <MouseWheel>
```

Your own code for both versions:

```tcl
proc rad {w delta} {
    $w yview scroll [expr {$delta > 0 ? -1 : 1}] units
}
bind .c <MouseWheel> {rad %W %D}
if {[tk windowingsystem] eq "x11"
        && ![package vsatisfies [package provide Tk] 9-]} {
    bind .c <Button-4> {rad %W 120}
    bind .c <Button-5> {rad %W -120}
}
```

Under X11, `%D` is always a multiple of 120. Finer values, as
touchpads deliver them under Windows and macOS, do not arrive under
X11. Whether a touchpad under Xfce produces smooth values has not
been checked.

---

## Modifiers and keys

X11 has eight modifier bits: Shift, Lock, Control and Mod1 to Mod5.
Which key sets which bit is defined by the keyboard layout
(`xmodmap -pm`). In the container: Mod1 carries Alt_L, Alt_R and
Meta_L, Mod2 Num_Lock, Mod4 Super_L and Super_R, Mod5
ISO_Level3_Shift (AltGr).

Tk has names for these that are meant to bridge platforms. Container
check, each binding set individually:

| Binding | 8.6.14 fires on | 9.0.4 fires on |
|---------|-------------------|------------------|
| `<Control-c>` | Ctrl+C | Ctrl+C |
| `<Alt-c>` | Alt+C | Alt+C |
| `<Mod1-c>` | Alt+C | Alt+C |
| `<Mod4-c>` | Super+C | Super+C |
| `<Meta-c>` | nothing | nothing |
| `<Command-c>` | **Alt+C** | **nothing** |
| `<Option-c>` | nothing | **Alt+C** |
| `<Super-c>` | error at `bind` | error at `bind` |

Under Tk 8.6, [`Command`]{.index} under X11 is the same as `Mod1`.
Under Tk 9.0.4 it is the same as `Meta` (source `tkBind.c`), and
`Option` is `Alt`. Tk determines which bit `Meta` is from the layout:
the bit on which a key with the keysym `Meta_L` or `Meta_R` lies in
the first level (source `tkUnixKey.c`). In the container, `Meta_L`
is on keycode 205, and its first level is `NoSymbol`:

```text
$ xmodmap -pke | grep 'keycode 205'
keycode 205 = NoSymbol Meta_L NoSymbol Meta_L
```

So Tk finds no Meta bit. Then `Meta`, and with it `Command`, fires on
no key.

The Debian book writes in the chapter *Tcl unter Linux*: "A binding
`<Command-c>` from a Mac program therefore reacts to Alt+C on Linux."
This holds for Tk 8.6, checked with 8.6.14. Under Tk 9.0.4 it reacts
to no key in the container. The same on the author's workstation
(Xfce, German layout): `xdotool` sends Alt+C to a window with only
`<Command-c>`. 8.6.18 fires and stores the binding as
`<Mod1-Key-c>`, 9.0.4 and 9.1.0 stay silent and store
`<Meta-Key-c>`. There, as in the container, `Meta_L` is on keycode
205 with `NoSymbol` in the first level. The rule of the Debian book
remains correct: bind `Command` only under `aqua`, under `x11` bind
`Control`.

```tcl
set mod [expr {[tk windowingsystem] eq "aqua" ? "Command" : "Control"}]
event add <<Speichern>> <$mod-s>
bind . <<Speichern>> speichern
```

The Super key (Windows key) is called `Mod4` in `bind`. The desktop
only intercepts the Super shortcuts it has assigned itself. On the
workstation (Xfce), Super+C reaches Tk, as `<Mod4-c>` with the keysym
`Super_L`; the session there assigns Super+E, Super+P and Super+R,
among others. Which ones are assigned is shown by
`xfconf-query -c xfce4-keyboard-shortcuts -l -v`.

Tk reports the key itself with its keysym (`%K`): `Control_L`,
`Alt_L`, `Super_L`. When a modifier is pressed, `%s` is still 0; the
bit only appears with the next key.

---

## Two clipboards

X11 has several "selections". Two are important for programs:

- [`PRIMARY`]{.index}: the most recently selected text. It is set
  without a copy command and pasted with the middle mouse button.
- `CLIPBOARD`: the clipboard in the sense of Windows and macOS. Set
  with Ctrl+C or `<<Copy>>`, pasted with Ctrl+V or `<<Paste>>`.

`clipboard` in Tk means CLIPBOARD, `selection` without an option
means PRIMARY. Container check, 8.6.14 and 9.0.4 identical, text
"Auswahl-Ü" selected in the entry:

```text
PRIMARY von innen:    Auswahl-Ü
PRIMARY über xclip:   Auswahl-Ü
CLIPBOARD vorher:     leer (CLIPBOARD selection doesn't exist or form "STRING" not defined)
CLIPBOARD nachher:    Auswahl-Ü        (nach event generate .e <<Copy>>)
CLIPBOARD über xclip: Auswahl-Ü
TARGETS:              MULTIPLE TARGETS TIMESTAMP TK_APPLICATION TK_WINDOW UTF8_STRING STRING
```

Selecting alone sets PRIMARY, not CLIPBOARD. Tk offers both as
`UTF8_STRING` and `STRING`, so umlauts arrive in other programs.

The most important difference from Windows: an X11 selection is not
stored content, but a promise by the program that owns it. When the
program ends, the content is gone. In the container,
`xclip -o -selection clipboard` returned only
`Error: target STRING not available` after `wish` had ended. A
clipboard manager such as `xfce4-clipman` takes over the content on
copy and keeps it, but only if it is running. On the workstation the
package 1.6.6-1 is installed, but no process is running; after `wish`
ends, `xclip` reports the same there as in the container. So
installed does not mean started: `pgrep xfce4-clipman`.

`serie-linux` (howto 11) shows: PRIMARY only exists after an X11
selection; otherwise `selection get -selection PRIMARY` fails. Code
therefore asks with `catch`:

```tcl
if {[catch {selection get -selection PRIMARY} text]} {
    set text ""
}
```

Anyone reading another program's selection with a tool such as
`xclip` must not do so with a blocking `exec` while their own program
is the owner. That deadlocks both, see
[exec, xdg-open, processes](070-exec-und-prozesse.md).

### Virtual events

Container check, `event info`:

| Event | 8.6.14 | 9.0.4 additionally |
|----------|--------|------------------|
| `<<Copy>>` | `<Control-Key-c> <Key-F16> <Control-Lock-Key-C> <Meta-Key-w> <Lock-Meta-Key-W> <Control-Key-Insert>` | `<Key-XF86Copy>` |
| `<<Paste>>` | `<Control-Key-v> <Key-F18> <Control-Lock-Key-V> <Control-Key-y> <Control-Lock-Key-Y> <Shift-Key-Insert>` | `<Key-XF86Paste>` |
| `<<PasteSelection>>` | `<ButtonRelease-2>` | as 8.6 |

`<<PasteSelection>>` pastes PRIMARY, not CLIPBOARD. To stop a text
widget from pasting with the middle button, delete the binding for
this one class:

```tcl
bind Text <<PasteSelection>> {break}
```

---

## Summary

- Mouse wheel: Tk 8.6 under X11 `<Button-4>`/`<Button-5>`, Tk 9
  `<MouseWheel>` everywhere. Under Tk 9, `<Button-4>`/`<Button-5>` are
  the side buttons 8 and 9.
- Under X11, `Command` is Alt in 8.6, and no key in 9.0 and 9.1
  (container and Xfce). Under `x11`, bind `Control`.
- Super is called `Mod4`.
- PRIMARY by selecting, CLIPBOARD by copying. Both disappear with the
  program unless a manager takes them over.

---

*Next chapter: [Native dialogs and desktop integration](110-dialoge-und-desktop.md)*
