---
CommandName: fileutil::magic::rt
ManualSection: n
Version: 2.0
TclPart: tcllib
TclDescription: file utilities
Links:
 - file(1)
 - fileutil
 - magic(5)
Keywords:
 - file recognition
 - file type
 - file utilities
 - mime
 - type
Copyright:
---

# NAME

fileutil::magic::rt – Laufzeit-Kern für Engines zur Dateityperkennung, geschrieben in reinem Tcl

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::rt]{.lit} [2.0]{.optlit} 
[::fileutil::magic::rt::>]{.cmd} 
[::fileutil::magic::rt::<]{.cmd} 
[::fileutil::magic::rt::new]{.cmd} [chan]{.arg} [named]{.arg} [analyze]{.arg} 
[::fileutil::magic::rt::file_start]{.cmd} [name]{.arg} 
[::fileutil::magic::rt::emit]{.cmd} [msg]{.arg} 
[::fileutil::magic::rt::O]{.cmd} [where]{.arg} 
[::fileutil::magic::rt::R]{.cmd} [where]{.arg} 
[::fileutil::magic::rt::Nv]{.cmd} [type]{.arg} [offset]{.arg} [compinvert]{.arg} [comp]{.arg} [expected]{.arg} 
[::fileutil::magic::rt::N]{.cmd} [type]{.arg} [offset]{.arg} [testinvert]{.arg} [compinvert]{.arg} [mod]{.arg} [mand]{.arg} [comp]{.arg} [expected]{.arg} 
[::fileutil::magic::rt::S]{.cmd} [type]{.arg} [offset]{.arg} [testinvert]{.arg} [mod]{.arg} [mand]{.arg} [comp]{.arg} [val]{.arg} 
[::fileutil::magic::rt::L]{.cmd} [newlevel]{.arg} 
[::fileutil::magic::rt::I]{.cmd} [offset]{.arg} [it]{.arg} [ioi]{.arg} [ioo]{.arg} [iir]{.arg} [io]{.arg} 
[::fileutil::magic::rt::R]{.cmd} [offset]{.arg} 
[::fileutil::magic::rt::U]{.cmd} [fileindex]{.arg} [name]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt den Laufzeitkern für in reinem Tcl geschriebene Engines zur Dateityperkennung bereit und wird daher von allen anderen Paketen in diesem Modul verwendet, wie beispielsweise **fileutil::magic::filetype** und den beiden Compiler-Paketen **fileutil::magic::cgen** und **fileutil::magic::cfront**.

# BEFEHLE

**::fileutil::magic::rt::>**
: Erhöht die Ebene und erledigt die zugehörige Verwaltung.

**::fileutil::magic::rt::<**
: Verringert die Ebene und erledigt die zugehörige Verwaltung.

**::fileutil::magic::rt::new** *chan* *named* *analyze*
: Erzeugt einen neuen Befehl, der bei jedem Aufruf eine Beschreibung der Datei zurückgibt und, wenn es keine weiteren Beschreibungen gibt, den Code *break*. *chan* ist der Kanal mit den zu beschreibenden Daten. Die Kanalkonfiguration wird danach nach Bedarf verwaltet. *named* ist ein Dictionary benannter Tests, wie es **fileutil::magic::cfront::compile** erzeugt. *analyze* ist ein Befehlspräfix für eine Routine aus der Befehlsliste, die **fileutil::magic::cfront::compile** zurückgibt.

**::fileutil::magic::rt::file_start** *name*
: Dieser Befehl markiert bei der Fehlersuche den Anfang einer magic-Datei. Er gibt die leere Zeichenkette zurück.

**::fileutil::magic::rt::emit** *msg*
: Dieser Befehl fügt den Text *msg* dem Ergebnispuffer hinzu. Die Meldung kann die folgenden besonderen Zeichenfolgen enthalten. Sie werden durch gepufferte Werte ersetzt, bevor die Meldung dem Ergebnis hinzugefügt wird. Der Befehl gibt die leere Zeichenkette zurück.


**\\b**
: Diese Folge wird entfernt.

**%s**
: Wird durch den zuletzt gepufferten Zeichenkettenwert ersetzt.

**%ld**
: Wird durch den zuletzt gepufferten numerischen Wert ersetzt.

**%d**
: Siehe oben.

**\${x:...?...}**
: Setzt eine Zeichenkette ein, wenn die Datei ausführbar ist, und sonst eine andere.


**::fileutil::magic::rt::O** *where*
: Erzeugt einen Versatz aus *where*, relativ zum Cursor eine Ebene höher. Erzeugt einen Versatz aus *where*, relativ zum Versatz eine Ebene höher.

**::fileutil::magic::rt::Nv** *type* *offset* *compinvert* *comp* *expected*
: Eine eingeschränkte Form von **::fileutile::magic::rt::N**, die nur auf Gleichheit prüft und bei der sich der Test nicht umkehren lässt.

**::fileutil::magic::rt::N** *type* *offset* *testinvert* *compinvert* *mod* *mand* *comp* *expected*
: Ruft den numerischen Wert mit dem Typ *type* an der absoluten Position *offset* ab, vergleicht ihn mit *expected* unter Verwendung von *comp* als Vergleichsoperator und gibt das Ergebnis zurück. Das Argument *comp* muss einer der Vergleichsoperatoren von Tcl sein.


```
	<comp> <fetched-and-masked-value> <comp> <expected>
```

Der spezielle Vergleichsoperator **x** signalisiert, dass kein Vergleich durchgeführt werden soll, oder, mit anderen Worten, dass der abgerufene Wert stets mit *val* übereinstimmt.

**::fileutil::magic::rt::S** *type* *offset* *testinvert* *mod* *mand* *comp* *val*
: Wie **::fileutil::magic::rt::N**, nur dass Zeichenkettentypen geholt und verglichen werden, keine numerischen Daten.

**::fileutil::magic::rt::L** *newlevel*
: Setzt die aktuelle Ebene im aufrufenden Kontext auf *newlevel*. Der Befehl gibt als Ergebnis die leere Zeichenkette zurück.

**::fileutil::magic::rt::I** *offset* *it* *ioi* *ioo* *iir* *io*
: Berechnet einen Versatz auf der Grundlage eines Anfangsversatzes und der angegebenen Modifikatoren.

**::fileutil::magic::rt::R** *offset*
: Berechnet ausgehend von einem anfänglichen Versatz einen Versatz relativ zum Cursor auf der nächsthöheren Ebene. Der Cursor ist die Position in den Daten, die ein Zeichen nach den aus der Datei auf der nächsthöheren Ebene extrahierten Daten liegt.

**::fileutil::magic::rt::U** *fileindex* *name*
: Fügt eine Ebene hinzu und verwendet ein benanntes Testskript.


# ZAHLENTYPEN

**byte**
: 8-Bit-Ganzzahl

**short**
: 16-Bit-Ganzzahl, gespeichert in nativer Byte-Reihenfolge

**beshort**
: siehe oben, gespeichert in Big-Endian

**leshort**
: siehe oben, gespeichert in Small-/Little-Endian

**long**
: 32-Bit-Ganzzahl, gespeichert in nativer Byte-Reihenfolge

**belong**
: siehe oben, gespeichert in Big-Endian

**lelong**
: siehe oben, gespeichert in Small-/Little-Endian. Alle oben genannten Typen gibt es auch vorzeichenlos. Die Typnamen sind dieselben, mit dem Zeichen "u" als Präfix.

**date**
: 32-Bit-Ganzzahl als Zeitstempel, gespeichert in nativer Byte-Reihenfolge

**bedate**
: siehe oben, gespeichert in Big-Endian

**ledate**
: siehe oben, gespeichert in Small-/Little-Endian

**ldate**
: 32-Bit-Ganzzahl als Zeitstempel, gespeichert in nativer Byte-Reihenfolge

**beldate**
: siehe oben, gespeichert in Big-Endian

**leldate**
: siehe oben, gespeichert in Small-/Little-Endian


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *fileutil :: magic* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge
