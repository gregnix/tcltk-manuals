# Understanding the Stack

## Introduction

The utils stack consists of three libraries: [tclutils]{.index}
(logic), [tkutils]{.index} (widgets) and [ctrlutils]{.index}
(controllers). This manual describes how the three fit together:
pairing of the versions, setup, tests, the controller modules of
ctrlutils and the difference between the Explorer and Dateiblick. A
chapter of its own covers the calendar engine [tical]{.index}, a fourth,
optional library on which two calendar widgets of tkutils are built. The
API of the individual modules is described in the books *tclutils* and
*tkutils*.

It applies to the pairing tclutils **0.69.0**, tkutils **0.49.0** and
ctrlutils **0.5**, plus tical **1.1**. Examples and test suites are
checked with Tcl/Tk 8.6.14 and 9.0.4 on Linux (Xvfb), the test suites
also on macOS and Windows. The examples are not checked there.

---

## Three Repos, One Layering Rule

```
tclutils   (tu*)   Logik, kein Tk        = Model
tkutils    (tku*)  Widgets               = View
ctrlutils  (cu*)   Verhalten verdrahten  = Controller

tical      (tical::*)  Kalender-Engine, eigenes Repo, optional
```

A tkutils module **is** a widget (`tkufilelist $path …`). A ctrlutils
module **wires** behaviour onto existing widgets
(`cufileops::install …`) — without a widget path of its own. Two
exceptions: `cufilter::widget` builds a small filter row of its own, and
`cusync` needs no Tk at all (comparing and mirroring through providers).

Package names follow the prefixes: umbrellas `tclutils`, `tkutils`,
`ctrlutils`; single modules `tclutils::tu…`, `tkutils::tku…`,
`ctrlutils::cu…`. tical is not part of the layering: it has a core of
its own without Tk, its own renderers, and it is found through
`auto_path`, not through the module path (chapter
[Calendar: tical](070-tical.md)).

---

## Why Separate

- CI and servers load only tclutils.
- Reuse widgets without application policy.
- Controllers work against the provider API, not against a fixed app.

`ctrlutils::cusync`, `ctrlutils::cumonitor` and `ctrlutils::cuundo` load
without Tk. The `ctrlutils` umbrella, on the other hand, needs Tk,
because `cufileops` pulls in the context menu and dialogs from tkutils.
Checked (Tcl/Tk 8.6.14 and 9.0.4, Linux): without a display,
`package require ctrlutils` ends with
`no display name and no $DISPLAY environment variable`.

Pairing of this book: **0.69.0 / 0.49.0 / 0.4**, plus tical **1.1**.

---

## Structure

Chapter 2 covers pairing, setup and tests. Then come the five
controllers: overview, filter, watching a directory, mirroring,
`cufileops` and `cuundo`. Chapter 8 compares the Explorer and
Dateiblick, chapter 9 is the checklist for applications of your own.
Chapter 10 describes tical: views, appointments, renderers, public
holidays, iCalendar export and import, and how it relates to the
calendar modules of tclutils and tkutils. The appendices contain pitfalls (A), the module list (B), the glossary (C)
and error messages (D).

---

## In short

- Model / view / controller as three package trees.
- Apps are glue on top (Explorer, Dateiblick).
- Without Tk, load single controllers only, not the umbrella.
- tical is optional and sits beside the stack, not inside it.

---

*Next chapter: [Pairing and Setup](020-pairing-und-setup.md)*
