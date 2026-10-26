---
CommandName: term::ansi::code::ctrl
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - ansi
 - attribute control
 - color control
 - control
 - terminal
Copyright:
 - Copyright (c) 2006-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

term::ansi::code::ctrl – ANSI-Steuersequenzen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [term::ansi::code]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [term::ansi::code::ctrl]{.lit} [0.3]{.optlit} 
[::term::ansi::code::ctrl::names]{.cmd} 
[::term::ansi::code::ctrl::import]{.cmd} [ns]{.optarg} [arg]{.optdot} 
[::term::ansi::code::ctrl::eeol]{.cmd} 
[::term::ansi::code::ctrl::esol]{.cmd} 
[::term::ansi::code::ctrl::el]{.cmd} 
[::term::ansi::code::ctrl::ed]{.cmd} 
[::term::ansi::code::ctrl::eu]{.cmd} 
[::term::ansi::code::ctrl::es]{.cmd} 
[::term::ansi::code::ctrl::sd]{.cmd} 
[::term::ansi::code::ctrl::su]{.cmd} 
[::term::ansi::code::ctrl::ch]{.cmd} 
[::term::ansi::code::ctrl::sc]{.cmd} 
[::term::ansi::code::ctrl::rc]{.cmd} 
[::term::ansi::code::ctrl::sca]{.cmd} 
[::term::ansi::code::ctrl::rca]{.cmd} 
[::term::ansi::code::ctrl::st]{.cmd} 
[::term::ansi::code::ctrl::ct]{.cmd} 
[::term::ansi::code::ctrl::cat]{.cmd} 
[::term::ansi::code::ctrl::qdc]{.cmd} 
[::term::ansi::code::ctrl::qds]{.cmd} 
[::term::ansi::code::ctrl::qcp]{.cmd} 
[::term::ansi::code::ctrl::rd]{.cmd} 
[::term::ansi::code::ctrl::elw]{.cmd} 
[::term::ansi::code::ctrl::dlw]{.cmd} 
[::term::ansi::code::ctrl::eg]{.cmd} 
[::term::ansi::code::ctrl::lg]{.cmd} 
[::term::ansi::code::ctrl::scs0]{.cmd} [tag]{.arg} 
[::term::ansi::code::ctrl::scs1]{.cmd} [tag]{.arg} 
[::term::ansi::code::ctrl::sda]{.cmd} [arg...]{.arg} 
[::term::ansi::code::ctrl::sda_fgblack]{.cmd} 
[::term::ansi::code::ctrl::sda_fgred]{.cmd} 
[::term::ansi::code::ctrl::sda_fggreen]{.cmd} 
[::term::ansi::code::ctrl::sda_fgyellow]{.cmd} 
[::term::ansi::code::ctrl::sda_fgblue]{.cmd} 
[::term::ansi::code::ctrl::sda_fgmagenta]{.cmd} 
[::term::ansi::code::ctrl::sda_fgcyan]{.cmd} 
[::term::ansi::code::ctrl::sda_fgwhite]{.cmd} 
[::term::ansi::code::ctrl::sda_fgdefault]{.cmd} 
[::term::ansi::code::ctrl::sda_bgblack]{.cmd} 
[::term::ansi::code::ctrl::sda_bgred]{.cmd} 
[::term::ansi::code::ctrl::sda_bggreen]{.cmd} 
[::term::ansi::code::ctrl::sda_bgyellow]{.cmd} 
[::term::ansi::code::ctrl::sda_bgblue]{.cmd} 
[::term::ansi::code::ctrl::sda_bgmagenta]{.cmd} 
[::term::ansi::code::ctrl::sda_bgcyan]{.cmd} 
[::term::ansi::code::ctrl::sda_bgwhite]{.cmd} 
[::term::ansi::code::ctrl::sda_bgdefault]{.cmd} 
[::term::ansi::code::ctrl::sda_bold]{.cmd} 
[::term::ansi::code::ctrl::sda_dim]{.cmd} 
[::term::ansi::code::ctrl::sda_italic]{.cmd} 
[::term::ansi::code::ctrl::sda_underline]{.cmd} 
[::term::ansi::code::ctrl::sda_blink]{.cmd} 
[::term::ansi::code::ctrl::sda_revers]{.cmd} 
[::term::ansi::code::ctrl::sda_hidden]{.cmd} 
[::term::ansi::code::ctrl::sda_strike]{.cmd} 
[::term::ansi::code::ctrl::sda_nobold]{.cmd} 
[::term::ansi::code::ctrl::sda_noitalic]{.cmd} 
[::term::ansi::code::ctrl::sda_nounderline]{.cmd} 
[::term::ansi::code::ctrl::sda_noblink]{.cmd} 
[::term::ansi::code::ctrl::sda_norevers]{.cmd} 
[::term::ansi::code::ctrl::sda_nohidden]{.cmd} 
[::term::ansi::code::ctrl::sda_nostrike]{.cmd} 
[::term::ansi::code::ctrl::sda_reset]{.cmd} 
[::term::ansi::send::fcp]{.cmd} [row]{.arg} [col]{.arg} 
[::term::ansi::code::ctrl::cu]{.cmd} [n]{.optarg} 
[::term::ansi::code::ctrl::cd]{.cmd} [n]{.optarg} 
[::term::ansi::code::ctrl::cf]{.cmd} [n]{.optarg} 
[::term::ansi::code::ctrl::cb]{.cmd} [n]{.optarg} 
[::term::ansi::code::ctrl::ss]{.cmd} [s e]{.optarg} 
[::term::ansi::code::ctrl::skd]{.cmd} [code]{.arg} [str]{.arg} 
[::term::ansi::code::ctrl::title]{.cmd} [str]{.arg} 
[::term::ansi::code::ctrl::gron]{.cmd} 
[::term::ansi::code::ctrl::groff]{.cmd} 
[::term::ansi::code::ctrl::tlc]{.cmd} 
[::term::ansi::code::ctrl::trc]{.cmd} 
[::term::ansi::code::ctrl::brc]{.cmd} 
[::term::ansi::code::ctrl::blc]{.cmd} 
[::term::ansi::code::ctrl::ltj]{.cmd} 
[::term::ansi::code::ctrl::ttj]{.cmd} 
[::term::ansi::code::ctrl::rtj]{.cmd} 
[::term::ansi::code::ctrl::btj]{.cmd} 
[::term::ansi::code::ctrl::fwj]{.cmd} 
[::term::ansi::code::ctrl::hl]{.cmd} 
[::term::ansi::code::ctrl::vl]{.cmd} 
[::term::ansi::code::ctrl::groptim]{.cmd} [str]{.arg} 
[::term::ansi::code::ctrl::clear]{.cmd} 
[::term::ansi::code::ctrl::init]{.cmd} 
[::term::ansi::code::ctrl::showat]{.cmd} [row]{.arg} [col]{.arg} [text]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt symbolische Namen für die ANSI-Steuersequenzen bereit. Für jede Sequenz wird ein einzelner Befehl bereitgestellt, der die Sequenz als Ergebnis zurückgibt. Keiner der Befehle dieses Pakets schreibt in einen Kanal; dies wird von Paketen höherer Ebene übernommen, wie beispielsweise **term::ansi::send**.

# API

## Introspektion

**::term::ansi::code::ctrl::names**
: Dieser Befehl dient der Introspektion. Er gibt als Ergebnis eine Liste zurück, die die Namen aller Attributbefehle enthält.

**::term::ansi::code::ctrl::import** ?*ns*? ?*arg*...?
: Dieser Befehl importiert einige oder alle Attributbefehle in den Namespace *ns*. Standardmäßig ist dies der Namespace *ctrl*. Beachten Sie, dass es sich hierbei um einen relativen Namensraumnamen handelt, wodurch der importierte Befehl in einen Unternamensraum des aktuellen Namensraums eingefügt wird. Standardmäßig werden alle Befehle importiert; dies kann jedoch eingeschränkt werden, indem die Namen der gewünschten Befehle nach dem Namensraum-Argument aufgeführt werden.


## Sequenzen

**::term::ansi::code::ctrl::eeol**
: Löschen bis zum Zeilenende

**::term::ansi::code::ctrl::esol**
: Löschen bis zum Zeilenanfang

**::term::ansi::code::ctrl::el**
: (Aktuelle) Zeile löschen

**::term::ansi::code::ctrl::ed**
: Nach unten löschen (bis zum Ende)

**::term::ansi::code::ctrl::eu**
: Nach oben (zurück zum Anfang)

**::term::ansi::code::ctrl::es**
: Bildschirm löschen

**::term::ansi::code::ctrl::sd**
: Bitte scrollen Sie nach unten

**::term::ansi::code::ctrl::su**
: Nach oben scrollen

**::term::ansi::code::ctrl::ch**
: Cursor Startseite

**::term::ansi::code::ctrl::sc**
: Cursor speichern

**::term::ansi::code::ctrl::rc**
: Cursor wiederherstellen (Speicherung rückgängig machen)

**::term::ansi::code::ctrl::sca**
: Cursor + Attribute speichern

**::term::ansi::code::ctrl::rca**
: Cursor und Attribute wiederherstellen

**::term::ansi::code::ctrl::st**
: Tabulator setzen (@ aktuelle Position)

**::term::ansi::code::ctrl::ct**
: Registerkarte löschen (an der aktuellen Position)

**::term::ansi::code::ctrl::cat**
: Alle Registerkarten löschen

**::term::ansi::code::ctrl::qdc**
: Gerätecode abfragen

**::term::ansi::code::ctrl::qds**
: Gerätestatus abfragen

**::term::ansi::code::ctrl::qcp**
: Cursorposition abfragen

**::term::ansi::code::ctrl::rd**
: Gerät zurücksetzen

**::term::ansi::code::ctrl::elw**
: Zeilenumbruch aktivieren

**::term::ansi::code::ctrl::dlw**
: Zeilenumbruch deaktivieren

**::term::ansi::code::ctrl::eg**
: Grafikmodus aufrufen

**::term::ansi::code::ctrl::lg**
: Grafikmodus beenden

**::term::ansi::code::ctrl::scs0** *tag*
: Standardzeichensatz festlegen

**::term::ansi::code::ctrl::scs1** *tag*
: Legt den alternativen Zeichensatz fest. Legt fest, welcher Zeichensatz für die Standardschriftart (scs0) oder die alternative Schriftart (scs1) verwendet wird. Dies hat keinen Einfluss darauf, ob die Standard- oder die alternative Schriftart verwendet wird, sondern betrifft lediglich deren Definitionen. Die zulässigen Tags und ihre Bedeutungen lauten wie folgt:


**A**
: Zeichensatz Vereinigtes Königreich

**B**
: ASCII-Zeichensatz

**0**
: Spezielle Grafiken

**1**
: Standardzeichensatz des alternativen Zeichen-ROM

**2**
: Sondergrafik des alternativen Zeichen-ROM


**::term::ansi::code::ctrl::sda** *arg*...
: Anzeigeattribute festlegen. Die Argumente sind die Codesequenzen für die möglichen Attribute, wie sie vom Paket **term::ansi::code::attr** bereitgestellt werden. Der Einfachheit halber bietet dieses Paket zudem zusätzliche Befehle, mit denen jeweils ein einzelnes spezifisches Attribut festgelegt werden kann.

**::term::ansi::code::ctrl::sda_fgblack**
: Setzt die Textfarbe auf *Black*.

**::term::ansi::code::ctrl::sda_fgred**
: Setzt die Textfarbe auf *Red*.

**::term::ansi::code::ctrl::sda_fggreen**
: Setzt die Textfarbe auf *Green*.

**::term::ansi::code::ctrl::sda_fgyellow**
: Setzt die Textfarbe auf *Yellow*.

**::term::ansi::code::ctrl::sda_fgblue**
: Setzt die Textfarbe auf *Blue*.

**::term::ansi::code::ctrl::sda_fgmagenta**
: Setzt die Textfarbe auf *Magenta*.

**::term::ansi::code::ctrl::sda_fgcyan**
: Setzt die Textfarbe auf *Cyan*.

**::term::ansi::code::ctrl::sda_fgwhite**
: Setzt die Textfarbe auf *White*.

**::term::ansi::code::ctrl::sda_fgdefault**
: Setzt die Standardtextfarbe (*Black*).

**::term::ansi::code::ctrl::sda_bgblack**
: Setzt den Hintergrund auf *Black*.

**::term::ansi::code::ctrl::sda_bgred**
: Setzt den Hintergrund auf *Red*.

**::term::ansi::code::ctrl::sda_bggreen**
: Setzt den Hintergrund auf *Green*.

**::term::ansi::code::ctrl::sda_bgyellow**
: Setzt den Hintergrund auf *Yellow*.

**::term::ansi::code::ctrl::sda_bgblue**
: Setzt den Hintergrund auf *Blue*.

**::term::ansi::code::ctrl::sda_bgmagenta**
: Setzt den Hintergrund auf *Magenta*.

**::term::ansi::code::ctrl::sda_bgcyan**
: Setzt den Hintergrund auf *Cyan*.

**::term::ansi::code::ctrl::sda_bgwhite**
: Setzt den Hintergrund auf *White*.

**::term::ansi::code::ctrl::sda_bgdefault**
: Standardhintergrund festlegen (transparent).

**::term::ansi::code::ctrl::sda_bold**
: Weiter so!

**::term::ansi::code::ctrl::sda_dim**
: Schaltet die abgeschwächte Darstellung ein.

**::term::ansi::code::ctrl::sda_italic**
: Kursivschrift aktivieren.

**::term::ansi::code::ctrl::sda_underline**
: Unterstrich aktivieren.

**::term::ansi::code::ctrl::sda_blink**
: Bitte blinken Sie weiter.

**::term::ansi::code::ctrl::sda_revers**
: Rückwärtsgang einlegen.

**::term::ansi::code::ctrl::sda_hidden**
: Ausgeblendet.

**::term::ansi::code::ctrl::sda_strike**
: Durchstreichen aktiviert.

**::term::ansi::code::ctrl::sda_nobold**
: Fettdruck deaktivieren.

**::term::ansi::code::ctrl::sda_noitalic**
: Kursivschrift beenden.

**::term::ansi::code::ctrl::sda_nounderline**
: Unterstrich aus.

**::term::ansi::code::ctrl::sda_noblink**
: Blinken ausschalten.

**::term::ansi::code::ctrl::sda_norevers**
: Bitte fahren Sie rückwärts weg.

**::term::ansi::code::ctrl::sda_nohidden**
: Ausgeblendet.

**::term::ansi::code::ctrl::sda_nostrike**
: Durchstreichung deaktivieren.

**::term::ansi::code::ctrl::sda_reset**
: Setzt alle Attribute auf ihre Standardwerte zurück.

**::term::ansi::send::fcp** *row* *col*
: Cursorposition erzwingen (auch bekannt als „Gehe zu“).

**::term::ansi::code::ctrl::cu** ?*n*?
: Cursor nach oben. *n* ist standardmäßig auf 1 gesetzt.

**::term::ansi::code::ctrl::cd** ?*n*?
: Cursor nach unten. *n* ist standardmäßig auf 1 gesetzt.

**::term::ansi::code::ctrl::cf** ?*n*?
: Cursor Weiterleitung. *n* ist standardmäßig auf 1 gesetzt.

**::term::ansi::code::ctrl::cb** ?*n*?
: Cursor rückwärts. *n* ist standardmäßig auf 1 gesetzt.

**::term::ansi::code::ctrl::ss** ?*s* *e*?
: Bildschirm scrollen (gesamter Bildschirm oder zwischen den Zeilen „Start“ und „Ende“, einschließlich).

**::term::ansi::code::ctrl::skd** *code* *str*
: Schlüsseldefinition festlegen.

**::term::ansi::code::ctrl::title** *str*
: Legt den Titel des Terminals fest.

**::term::ansi::code::ctrl::gron**
: Wechselt zu Zeichen- und Kastengrafik, das heißt zur alternativen Schriftart.

**::term::ansi::code::ctrl::groff**
: Wechselt zu normalen Zeichen, das heißt zur Standardschriftart.

**::term::ansi::code::ctrl::tlc**
: Zeichengrafik, obere linke Ecke.

**::term::ansi::code::ctrl::trc**
: Zeichengrafik, obere rechte Ecke.

**::term::ansi::code::ctrl::brc**
: Zeichengrafik, rechte untere Ecke.

**::term::ansi::code::ctrl::blc**
: Zeichengrafik, linke untere Ecke.

**::term::ansi::code::ctrl::ltj**
: Zeichengrafik, T-Kreuzung links.

**::term::ansi::code::ctrl::ttj**
: Zeichengrafik, obere T-Kreuzung.

**::term::ansi::code::ctrl::rtj**
: Zeichengrafik, rechte T-Kreuzung.

**::term::ansi::code::ctrl::btj**
: Zeichengrafik, T-Kreuzung unten.

**::term::ansi::code::ctrl::fwj**
: Zeichengrafiken, Vierwegekreuzung.

**::term::ansi::code::ctrl::hl**
: Zeichengrafik, horizontale Linie.

**::term::ansi::code::ctrl::vl**
: Zeichengrafik, vertikale Linie.

**::term::ansi::code::ctrl::groptim** *str*
: Zeichengrafiken optimieren. Die oben genannten Generatorbefehle erzeugen viel zu viele überflüssige Befehle zum Wechseln in den Grafikmodus und zurück. Dieser Befehl entfernt alle nicht benötigten Wechsel. Zu diesem Zweck erkennt er auch, welche Zeichen in beiden Modi gleich aussehen, um Zeichenfolgen zu verarbeiten, die außerhalb dieses Pakets erstellt wurden.

**::term::ansi::code::ctrl::clear**
: Bildschirm löschen. Im Wesentlichen eine Abfolge von „CursorHome“ und „EraseDown“.

**::term::ansi::code::ctrl::init**
: Initialisiert die Standard- und Alternativschriftarten auf ASCII und Box-Grafiken.

**::term::ansi::code::ctrl::showat** *row* *col* *text*
: Formatiert den Textblock für die Anzeige an der angegebenen Stelle.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *term* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Terminalsteuerung

# COPYRIGHT

```
Copyright (c) 2006-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
