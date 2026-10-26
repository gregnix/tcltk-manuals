---
CommandName: term::ansi::send
title: term::ansi::send
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - character output
 - control
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::ansi::send – Ausgabe von ANSI-Steuersequenzen an Terminals

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [term::ansi::send]{.lit} [0.2]{.optlit}
[::term::ansi::send::import]{.cmd} [ns]{.optarg} [...]{.arg}
[::term::ansi::send::eeol]{.cmd}
[::term::ansi::send::esol]{.cmd}
[::term::ansi::send::el]{.cmd}
[::term::ansi::send::ed]{.cmd}
[::term::ansi::send::eu]{.cmd}
[::term::ansi::send::es]{.cmd}
[::term::ansi::send::sd]{.cmd}
[::term::ansi::send::su]{.cmd}
[::term::ansi::send::ch]{.cmd}
[::term::ansi::send::sc]{.cmd}
[::term::ansi::send::rc]{.cmd}
[::term::ansi::send::sca]{.cmd}
[::term::ansi::send::rca]{.cmd}
[::term::ansi::send::st]{.cmd}
[::term::ansi::send::ct]{.cmd}
[::term::ansi::send::cat]{.cmd}
[::term::ansi::send::qdc]{.cmd}
[::term::ansi::send::qds]{.cmd}
[::term::ansi::send::qcp]{.cmd}
[::term::ansi::send::rd]{.cmd}
[::term::ansi::send::elw]{.cmd}
[::term::ansi::send::dlw]{.cmd}
[::term::ansi::send::eg]{.cmd}
[::term::ansi::send::lg]{.cmd}
[::term::ansi::send::scs0]{.cmd} [tag]{.arg}
[::term::ansi::send::scs1]{.cmd} [tag]{.arg}
[::term::ansi::send::sda]{.cmd} [arg...]{.arg}
[::term::ansi::send::sda\_fgblack]{.cmd}
[::term::ansi::send::sda\_fgred]{.cmd}
[::term::ansi::send::sda\_fggreen]{.cmd}
[::term::ansi::send::sda\_fgyellow]{.cmd}
[::term::ansi::send::sda\_fgblue]{.cmd}
[::term::ansi::send::sda\_fgmagenta]{.cmd}
[::term::ansi::send::sda\_fgcyan]{.cmd}
[::term::ansi::send::sda\_fgwhite]{.cmd}
[::term::ansi::send::sda\_fgdefault]{.cmd}
[::term::ansi::send::sda\_bgblack]{.cmd}
[::term::ansi::send::sda\_bgred]{.cmd}
[::term::ansi::send::sda\_bggreen]{.cmd}
[::term::ansi::send::sda\_bgyellow]{.cmd}
[::term::ansi::send::sda\_bgblue]{.cmd}
[::term::ansi::send::sda\_bgmagenta]{.cmd}
[::term::ansi::send::sda\_bgcyan]{.cmd}
[::term::ansi::send::sda\_bgwhite]{.cmd}
[::term::ansi::send::sda\_bgdefault]{.cmd}
[::term::ansi::send::sda\_bold]{.cmd}
[::term::ansi::send::sda\_dim]{.cmd}
[::term::ansi::send::sda\_italic]{.cmd}
[::term::ansi::send::sda\_underline]{.cmd}
[::term::ansi::send::sda\_blink]{.cmd}
[::term::ansi::send::sda\_revers]{.cmd}
[::term::ansi::send::sda\_hidden]{.cmd}
[::term::ansi::send::sda\_strike]{.cmd}
[::term::ansi::send::sda\_nobold]{.cmd}
[::term::ansi::send::sda\_noitalic]{.cmd}
[::term::ansi::send::sda\_nounderline]{.cmd}
[::term::ansi::send::sda\_noblink]{.cmd}
[::term::ansi::send::sda\_norevers]{.cmd}
[::term::ansi::send::sda\_nohidden]{.cmd}
[::term::ansi::send::sda\_nostrike]{.cmd}
[::term::ansi::send::sda\_reset]{.cmd}
[::term::ansi::send::fcp]{.cmd} [row]{.arg} [col]{.arg}
[::term::ansi::send::cu]{.cmd} [n]{.optarg}
[::term::ansi::send::cd]{.cmd} [n]{.optarg}
[::term::ansi::send::cf]{.cmd} [n]{.optarg}
[::term::ansi::send::cb]{.cmd} [n]{.optarg}
[::term::ansi::send::ss]{.cmd} [s e]{.optarg}
[::term::ansi::send::skd]{.cmd} [code]{.arg} [str]{.arg}
[::term::ansi::send::title]{.cmd} [str]{.arg}
[::term::ansi::send::gron]{.cmd}
[::term::ansi::send::groff]{.cmd}
[::term::ansi::send::tlc]{.cmd}
[::term::ansi::send::trc]{.cmd}
[::term::ansi::send::brc]{.cmd}
[::term::ansi::send::blc]{.cmd}
[::term::ansi::send::ltj]{.cmd}
[::term::ansi::send::ttj]{.cmd}
[::term::ansi::send::rtj]{.cmd}
[::term::ansi::send::btj]{.cmd}
[::term::ansi::send::fwj]{.cmd}
[::term::ansi::send::hl]{.cmd}
[::term::ansi::send::vl]{.cmd}
[::term::ansi::send::groptim]{.cmd} [str]{.arg}
[::term::ansi::send::clear]{.cmd}
[::term::ansi::send::init]{.cmd}
[::term::ansi::send::showat]{.cmd} [row]{.arg} [col]{.arg} [text]{.arg}
:::

# Beschreibung

Dieses Paket stellt Befehle zum Senden von ANSI-Terminalsteuerungssequenzen an ein Terminal bereit. Alle Befehle gibt es in zwei Varianten: eine zum Senden an einen beliebigen Kanal und eine zum Senden an *stdout*.

Die Befehle werden mithilfe der vom Paket **term::ansi::code::ctrl** bereitgestellten Steuersequenzen definiert. Sie verfügen über dieselben Argumente wie die Befehle, auf denen sie basieren, mit Ausnahme der Variante für die Ausgabe an einen beliebigen Kanal. Ihr erstes Argument ist stets ein Kanal-Handle, gefolgt von den ursprünglichen Argumenten. Im Folgenden werden wir nur die Variante auflisten, die an *stdout* sendet.

**::term::ansi::send::import** ?*ns*? *...*
: Importiert die Befehle dieses Pakets in den Namespace *ns*. Wird kein Namespace festgelegt, wird standardmäßig *send* verwendet. Hinweis: Es handelt sich bei diesem Standardwert um einen relativen Namespace-Namen, d. h., der eigentliche Namespace wird unter dem aktuellen Namespace angelegt.

    Standardmäßig werden alle Befehle importiert; dies kann jedoch auf bestimmte Befehle beschränkt werden, indem diese hinter dem zu importierenden Namespace aufgeführt werden.

**::term::ansi::send::eeol**
: Löschen bis zum Zeilenende.

**::term::ansi::send::esol**
: Löschen bis zum Zeilenanfang.

**::term::ansi::send::el**
: (Aktuelle) Zeile löschen.

**::term::ansi::send::ed**
: Nach unten löschen (bis zum Ende).

**::term::ansi::send::eu**
: Nach oben (zum Anfang).

**::term::ansi::send::es**
: Bildschirm löschen.

**::term::ansi::send::sd**
: Bitte scrollen Sie nach unten.

**::term::ansi::send::su**
: Bitte scrollen Sie nach oben.

**::term::ansi::send::ch**
: Cursor auf „Startseite“.

**::term::ansi::send::sc**
: Cursor speichern. Hinweis: Es kann jeweils nur eine gespeicherte Position verwaltet werden. Es handelt sich hierbei nicht um einen unbegrenzten Stapel. Ein Speichern vor dem Wiederherstellen überschreibt die gespeicherten Daten.

**::term::ansi::send::rc**
: Cursor wiederherstellen (Speicherung rückgängig machen).

**::term::ansi::send::sca**
: Cursor + Attribute speichern.

**::term::ansi::send::rca**
: Cursor und Attribute wiederherstellen.

**::term::ansi::send::st**
: Tabulator setzen (@ aktuelle Position).

**::term::ansi::send::ct**
: Registerkarte löschen (an der aktuellen Position).

**::term::ansi::send::cat**
: Alle Registerkarten löschen.

**::term::ansi::send::qdc**
: Gerätecode abfragen.

**::term::ansi::send::qds**
: Gerätestatus abfragen.

**::term::ansi::send::qcp**
: Position des Abfragecursors abfragen.

**::term::ansi::send::rd**
: Gerät zurücksetzen.

**::term::ansi::send::elw**
: Zeilenumbruch aktivieren.

**::term::ansi::send::dlw**
: Zeilenumbruch deaktivieren.

**::term::ansi::send::eg**
: Wechselt in den Grafikmodus.

**::term::ansi::send::lg**
: Grafikmodus beenden.

**::term::ansi::send::scs0** *tag*
: siehe unten ...

**::term::ansi::send::scs1** *tag*
: Wählt den Zeichensatz.

    Legt fest, welcher Zeichensatz für die Standardschriftart (scs0) und die alternative Schriftart (scs1) verwendet wird. Dies hat keinen Einfluss darauf, ob die Standard- oder die alternative Schriftart verwendet wird, sondern betrifft lediglich deren Definitionen.

    Die zulässigen Tags und ihre Bedeutungen lauten wie folgt:

    A
    : Zeichensatz Vereinigtes Königreich

    B
    : ASCII-Zeichensatz

    0
    : Spezielle Grafiken

    1
    : Standardzeichensatz des alternativen Zeichen-ROM

    2
    : Sondergrafik des alternativen Zeichen-ROM


**::term::ansi::send::sda** *arg*...
: Anzeigeattribute festlegen. Die Argumente sind die Codesequenzen für die möglichen Attribute, wie sie vom Paket **term::ansi::code::attr** bereitgestellt werden. Der Einfachheit halber bietet dieses Paket zudem zusätzliche Befehle, mit denen jeweils ein einzelnes spezifisches Attribut festgelegt werden kann.

**::term::ansi::send::sda\_fgblack**
: Setzt die Textfarbe auf *Black*.

**::term::ansi::send::sda\_fgred**
: Setzt die Textfarbe auf *Red*.

**::term::ansi::send::sda\_fggreen**
: Setzt die Textfarbe auf *Green*.

**::term::ansi::send::sda\_fgyellow**
: Setzt die Textfarbe auf *Yellow*.

**::term::ansi::send::sda\_fgblue**
: Setzt die Textfarbe auf *Blue*.

**::term::ansi::send::sda\_fgmagenta**
: Setzt die Textfarbe auf *Magenta*.

**::term::ansi::send::sda\_fgcyan**
: Setzt die Textfarbe auf *Cyan*.

**::term::ansi::send::sda\_fgwhite**
: Setzt die Textfarbe auf *White*.

**::term::ansi::send::sda\_fgdefault**
: Setzt die Standardtextfarbe (*Black*).

**::term::ansi::send::sda\_bgblack**
: Setzt den Hintergrund auf *Black*.

**::term::ansi::send::sda\_bgred**
: Setzt den Hintergrund auf *Red*.

**::term::ansi::send::sda\_bggreen**
: Setzt den Hintergrund auf *Green*.

**::term::ansi::send::sda\_bgyellow**
: Setzt den Hintergrund auf *Yellow*.

**::term::ansi::send::sda\_bgblue**
: Setzt den Hintergrund auf *Blue*.

**::term::ansi::send::sda\_bgmagenta**
: Setzt den Hintergrund auf *Magenta*.

**::term::ansi::send::sda\_bgcyan**
: Setzt den Hintergrund auf *Cyan*.

**::term::ansi::send::sda\_bgwhite**
: Setzt den Hintergrund auf *White*.

**::term::ansi::send::sda\_bgdefault**
: Standardhintergrund festlegen (transparent).

**::term::ansi::send::sda\_bold**
: Weiter so!

**::term::ansi::send::sda\_dim**
: Schaltet die abgeschwächte Darstellung ein.

**::term::ansi::send::sda\_italic**
: Kursivschrift aktivieren.

**::term::ansi::send::sda\_underline**
: Unterstrich aktivieren.

**::term::ansi::send::sda\_blink**
: Bitte blinken Sie weiter.

**::term::ansi::send::sda\_revers**
: Rückwärtsgang einlegen.

**::term::ansi::send::sda\_hidden**
: Ausgeblendet.

**::term::ansi::send::sda\_strike**
: Durchstreichen aktiviert.

**::term::ansi::send::sda\_nobold**
: Fettdruck deaktivieren.

**::term::ansi::send::sda\_noitalic**
: Kursivschrift beenden.

**::term::ansi::send::sda\_nounderline**
: Unterstrich aus.

**::term::ansi::send::sda\_noblink**
: Blinken ausschalten.

**::term::ansi::send::sda\_norevers**
: Bitte fahren Sie rückwärts weg.

**::term::ansi::send::sda\_nohidden**
: Ausgeblendet.

**::term::ansi::send::sda\_nostrike**
: Durchstreichung deaktivieren.

**::term::ansi::send::sda\_reset**
: Setzt alle Attribute auf ihre Standardwerte zurück.

**::term::ansi::send::fcp** *row* *col*
: Cursorposition erzwingen (auch bekannt als „Gehe zu“).

**::term::ansi::send::cu** ?*n*?
: Cursor nach oben. *n* ist standardmäßig auf 1 gesetzt.

**::term::ansi::send::cd** ?*n*?
: Cursor nach unten. *n* ist standardmäßig auf 1 gesetzt.

**::term::ansi::send::cf** ?*n*?
: Cursor Weiterleitung. *n* ist standardmäßig auf 1 gesetzt.

**::term::ansi::send::cb** ?*n*?
: Cursor rückwärts. *n* ist standardmäßig auf 1 gesetzt.

**::term::ansi::send::ss** ?*s* *e*?
: Bildschirm scrollen (gesamter Bildschirm oder zwischen den Zeilen „Start“ und „Ende“, einschließlich).

**::term::ansi::send::skd** *code* *str*
: Schlüsseldefinition festlegen.

**::term::ansi::send::title** *str*
: Legt den Titel des Terminals fest.

**::term::ansi::send::gron**
: Wechselt zu Zeichen- und Kastengrafik, das heißt zur alternativen Schriftart.

**::term::ansi::send::groff**
: Wechselt zu normalen Zeichen, das heißt zur Standardschriftart.

**::term::ansi::send::tlc**
: Zeichengrafik, obere linke Ecke.

**::term::ansi::send::trc**
: Zeichengrafik, obere rechte Ecke.

**::term::ansi::send::brc**
: Zeichengrafik, rechte untere Ecke.

**::term::ansi::send::blc**
: Zeichengrafik, linke untere Ecke.

**::term::ansi::send::ltj**
: Zeichengrafik, T-Kreuzung links.

**::term::ansi::send::ttj**
: Zeichengrafik, obere T-Kreuzung.

**::term::ansi::send::rtj**
: Zeichengrafik, rechte T-Kreuzung.

**::term::ansi::send::btj**
: Zeichengrafik, T-Kreuzung unten.

**::term::ansi::send::fwj**
: Zeichengrafiken, Vierwegekreuzung.

**::term::ansi::send::hl**
: Zeichengrafik, horizontale Linie.

**::term::ansi::send::vl**
: Zeichengrafik, vertikale Linie.

**::term::ansi::send::groptim** *str*
: Zeichengrafiken optimieren. Die oben genannten Generatorbefehle erzeugen viel zu viele überflüssige Befehle zum Wechseln in den Grafikmodus und zurück. Dieser Befehl entfernt alle nicht benötigten Wechsel. Zu diesem Zweck erkennt er auch, welche Zeichen in beiden Modi gleich aussehen, um Zeichenfolgen zu verarbeiten, die außerhalb dieses Pakets erstellt wurden.

**::term::ansi::send::clear**
: Bildschirm löschen. Im Wesentlichen eine Abfolge von „CursorHome“ und „EraseDown“.

**::term::ansi::send::init**
: Initialisiert die Standard- und Alternativschriftarten auf ASCII und Box-Grafiken.

**::term::ansi::send::showat** *row* *col* *text*
: Zeigt den Textblock an der angegebenen Stelle an.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *term* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Terminalsteuerung

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
