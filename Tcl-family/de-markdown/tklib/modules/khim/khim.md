---
CommandName: khim
title: khim
ManualSection: n
Version: 1.0.3
TclPart: tklib
TclDescription: Kevin's Hacky Input Method
Keywords:
 - character
 - i18n
 - input
 - international
 - method
Copyright:
---

# Name

khim – Bietet Bindings zur Eingabe internationaler Zeichen auf einer Tastatur, die diese nicht unterstützt

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit}
[package]{.cmd} [require]{.sub} [khim]{.lit} [1.0.3]{.optlit}
[::khim::getOptions]{.cmd} [path]{.arg}
[::khim::getConfig]{.cmd}
[::khim::setConfig]{.cmd} [version]{.arg} [enabled]{.arg} [compose]{.arg} [map]{.arg}
[::khim::showHelp]{.cmd} [path]{.arg}
:::

# Beschreibung

Dieses Paket stellt Tastenbindungen bereit, mit denen sich beliebige Zeichen auf einer Tastatur eingeben lassen, die sie nicht anbietet. Dafür wird eine selten benutzte Taste zur Compose-Taste bestimmt. Diese Taste ist eine andere als eine Taste, die bereits so beschriftet ist, und ist oft Pause, F12 oder L2. Die Compose-Taste und danach eine Folge aus zwei Tasten fügt ein Zeichen in ein Widget ein. Zweimal hintereinander angeschlagen öffnet die Compose-Taste einen Dialog mit einer Unicode-Zeichentabelle, über den sich beliebige Zeichen einfügen lassen.

Der weitaus größte Teil des Pakets steckt in einem einzigen Bindtag, **KHIM**. Eine Anwendung lässt ein Text- oder Entry-Widget beliebige Zeichen aufnehmen, indem sie diesen Bindtag vor den Bindtag **Text** oder **Entry** des Widgets setzt:

```
text .t -width 80 -height 24
bindtags .t {.t KHIM Text . all}
```

Der Tag **KHIM** muss vor der Klassenbindung **Text** oder **Entry** stehen, sonst arbeitet das Paket nicht richtig.

# Prozeduren

Neben den Befehlen zum Bindtag KHIM exportiert das Paket die folgenden Befehle:

**::khim::getOptions** *path*
: Öffnet einen modalen Toplevel-Dialog mit dem Pfadnamen *path*, der nach den KHIM-Optionen fragt. Die Tastenfolgen für die Compose-Taste lassen sich neu festlegen, die Taste für die Compose-Funktion wechseln, und die KHIM-Tastenbindungen ganz ein- oder ausschalten.

**::khim::getConfig**
: Gibt ein Tcl-Skript zurück, das die aktuelle KHIM-Konfiguration wiederherstellt: den Zustand ein oder aus, die gewählte Compose-Taste und die Tastenfolgen, die sich zusammensetzen lassen. Das Skript ist dazu gedacht, in einer Konfigurationsdatei zu stehen und beim nächsten Start derselben Anwendung zu gelten:

    ```
    # Save KHIM configuration
    set f [open ~/.khimrc w]
    puts $f [::khim::getConfig]
    close $f

    # Restore KHIM configuration
    source ~/.khimrc
    ```

**::khim::setConfig** *version* *enabled* *compose* *map*
: Stellt eine früher gespeicherte Konfiguration wieder her. Kaum eine Anwendung ruft diesen Befehl anders auf, als das von **::khim::getConfig** gelieferte Skript auszuwerten.

**::khim::showHelp** *path*
: Zeigt einen Toplevel-Dialog mit der Hilfe zu KHIM für den Benutzer. Der Dialog hat den Pfadnamen *path*.


# Lokalisierung

Wer KHIM in einer nicht englischsprachigen Locale anbieten will, legt eine **.msg**-Datei mit dem passenden Text an. Der Katalog braucht die folgenden Meldungen:

**Apply**
: Text der Schaltfläche Apply im Dialog, der die KHIM-Optionen setzt.

**Cancel**
: Text der Schaltfläche Cancel in mehreren Dialogen.

**Change**
: Text der Schaltfläche Change. Sie ändert die Bindung eines Paares zusammengesetzter Zeichen, legt sie an oder ersetzt sie.

**Character**
: Text der Beschriftung des Entry-Widgets, das das Zeichen aus einer Compose-Folge aufnimmt.

**{Compose Key}**
: Fenstertitel des Dialogs, der zum Anschlagen der Taste auffordert, die die Compose-Taste wird.

**{Compose key:}**
: Beschriftung der Komponente, die im Dialog der KHIM-Optionen die gewählte Compose-Taste zeigt.

**{Composed sequence must be two characters long}**
: Fehlermeldung, wenn eine Compose-Folge kürzer oder länger als zwei Zeichen definiert wird.

**Delete**
: Text einer Schaltfläche, die eine Compose-Folge löscht.

**Help...**
: Text einer Schaltfläche, die den KHIM-Hilfedialog zeigt.

**HELPTEXT**
: Vollständiger Hilfetext für den Benutzer. Die englische Fassung steht in *en.msg*.

**{Input key sequence}**
: Text der Beschriftung des Entry-Widgets, das nach einer Folge aus zwei Zeichen für die Compose-Taste fragt.

**{Insert Character}**
: Fenstertitel des Dialogs, der eine Unicode-Zeichentabelle zeigt und nach dem einzufügenden Zeichen fragt.

**{Key sequences}**
: Text einer Beschriftung über einer Listbox der derzeit gebundenen Compose-Folgen.

**{KHIM Controls}**
: Fenstertitel des Dialogs, der nach den KHIM-Einstellungen fragt.

**{KHIM Help}**
: Fenstertitel des Fensters, das den Hilfetext zu KHIM zeigt.

**OK**
: Beschriftung der Schaltfläche OK in mehreren Dialogen.

**Select code page:**
: Beschriftung einer Spinbox, die nach der Nummer einer Unicode-Codepage fragt.

**SELECT COMPOSE KEY**
: Eine Meldung in kurzen Zeilen, die zum Drücken der Taste auffordert, die in KHIM die Compose-Taste wird.

**Unicode...**
: Text einer Schaltfläche, die die Zeichentabelle öffnet, um das Zeichen zu wählen, an das eine Compose-Folge gebunden wird.

**{Use KHIM}**
: Text eines Checkbuttons, der fragt, ob KHIM die Compose-Tastenfolgen verwalten soll.


# Danksagungen

KHIM geht auf die Tastenbindungen zurück, die Brent Welch für den Editor sedit im Mail-Programm exmh entwickelt hat. Der Code von KHIM ist vollständig von dem von sedit getrennt.

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *khim* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
