---
CommandName: chatwidget
title: chatwidget
ManualSection: n
Version: 1.1.4
TclPart: tklib
TclDescription: Composite widget for chat applications
Links:
 - text(n)
Keywords:
 - chat
 - chatwidget
 - composite widget
 - irc
 - mega-widget
 - widget
Copyright:
---

# Name

chatwidget – Mehrteilige Ansicht für einen Chatraum oder einen IRC-Kanal

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [chatwidget]{.lit} [1.1.4]{.optlit}
[::chatwidget::chatwidget]{.cmd} [path]{.arg} [options]{.optarg}
[$widget]{.cmd} [topic]{.lit} [command]{.arg} [args]{.arg}
[$widget]{.cmd} [name]{.lit} [nick]{.arg} [args]{.arg}
[$widget]{.cmd} [message]{.lit} [text]{.arg} [args]{.arg}
[$widget]{.cmd} [hook]{.lit} [command]{.arg} [args]{.arg}
[$widget]{.cmd} [names]{.lit} [args]{.arg}
[$widget]{.cmd} [entry]{.lit} [args]{.arg}
[$widget]{.cmd} [chat]{.lit} [args]{.arg}
:::

# Beschreibung

Ein zusammengesetztes Widget, das den Bau von Chat-Anwendungen vereinfacht. Es enthält Anzeigebereiche für Chat-Nachrichten, Benutzernamen und das Thema sowie einen Eingabebereich. Nachrichten werden je nick gefärbt, und die Vervollständigung der nicks läuft von selbst. Hooks lassen die Anzeige anpassen. Der Hauptbereich des Chats lässt sich teilen, für den Verlauf oder für die Suche.

Das Widget besteht aus mehreren Text-Widgets und Panedwindow-Widgets, sodass sich die Größe jedes Teils der Anzeige einstellen lässt. Alle Text-Widgets sind über Durchreichbefehle erreichbar, wenn es genauer sein soll. Die Bereiche Thema und Namen lassen sich ausblenden.

# Befehle

**::chatwidget::chatwidget** *path* ?*options*?
: Erzeugt ein neues chatwidget mit der Tk-Fensterkennung *path*. Angegebene Optionen gehen derzeit direkt an das Text-Widget des Hauptchats.


# Widget-Befehle

**$widget** topic *command* *args*
: Das Chat-Widget kann eine Themenzeile anzeigen, zum Beispiel das Thema oder den Namen eines Mehrbenutzer-Chatraums oder eines IRC-Kanals.

    **show**
    : Schaltet die Anzeige des Themas ein.

    **hide**
    : Schaltet die Anzeige des Themas aus.

    **set** *topic*
    : Setzt den Thementext auf *topic*.


**$widget** name *nick* *args*
: Steuert die Namen und die Tags zu den Namen.

    **list** ?*-full*?
    : Gibt eine Liste aller Benutzernamen aus der Namensansicht zurück. Ist ?-full? angegeben, ist die Liste eine Liste von Listen. Jede Unterliste besteht aus dem nick und danach den Optionen, die an diesem nick-Eintrag gesetzt sind. Damit lassen sich anwendungseigene Optionen prüfen, die **add** an einen nick hängt.

    - **add** *nick* ?*options*?
    - **delete** *nick*


**$widget** message *text* *args*
: Fügt Nachrichten zur Anzeige hinzu. Die Optionen sind -nick, -time, -type, -mark -tags

**$widget** hook *command* *args*
: Verwaltet Hooks. add (message, post, names\_group, names\_nick, chatstate), remove, run

**$widget** names *args*
: Durchreichung an das Text-Widget der Namensanzeige. Alle Befehle stehen im Handbuch des Widgets **text**. chatwidget stellt zusätzlich **show** und **hide** bereit, mit denen sich die Anzeige dieses Teils steuern lässt.

**$widget** entry *args*
: Durchreichung an das Text-Widget der Eingabe. Alle Befehle stehen im Handbuch des Widgets **text**.

**$widget** chat *args*
: Durchreichung an das Text-Widget des Chats. Alle Befehle stehen im Handbuch des Widgets **text**.


# Beispiel

```
chatwidget::chatwidget .chat
proc speak {w msg} {$w message $msg -nick user}
.chat hook add post [list speak .chat]
pack .chat -side top -fill both -expand 1
.chat topic show
.chat topic set "Chat widget demo"
.chat name add "admin" -group admin
.chat name add "user" -group users -color tomato
.chat message "Chatwidget ready" -type system
.chat message "Hello, user" -nick admin
.chat message "Hello, admin" -nick user
```

Ein umfangreicheres Beispiel steht im Code des Programms picoirc im Repository tclapps. Es verbindet das tcllib-Paket **picoirc** mit diesem Paket **chatwidget** zu einem einfachen IRC-Client.

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *chatwidget* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
