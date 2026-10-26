---
CommandName: textutil::patch
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Text and string utilities
Keywords:
 - diff -ruN
 - diff
 - unified format
 - fossil
 - git
 - patch
 - unified format diff
Copyright:
---

# NAME

textutil::patch – Anwendung von Uni-Diff-Patches auf Verzeichnisbäume

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil::patch]{.lit} [0.2]{.optlit} 
[::textutil::patch::apply]{.cmd} [basedirectory]{.arg} [striplevel]{.arg} [patch]{.arg} [reportcmd]{.arg} 
:::

**{\*}reportcmd** **apply** *Dateiname*

**{\*}reportcmd** **Fehler** *Dateiname* *Block* *erwartet* *tatsächlich*

**{\*}reportcmd** **fail-already** *Dateiname* *Hunk*

# BESCHREIBUNG

Dieses Paket stellt einen einzigen Befehl bereit, der einen Patch im [unified diff format](https://www.gnu.org/software/diffutils/manual/html_node/Detailed-Unified.html) auf die Dateien in einer Verzeichnisstruktur anwendet.

# API

**::textutil::patch::apply** *basedirectory* *striplevel* *patch* *reportcmd*
: Wendet den *Patch* (d. h. den Text des eigentlichen Patches, nicht einen Dateinamen) unter Verwendung des angegebenen *striplevel* auf die Dateien im *basedirectory* an und meldet Aktionen durch Aufrufe des Befehlspräfixes *reportcmd*. Gibt eine leere Zeichenkette zurück. Das Argument *striplevel* entspricht dem Befehl **-p** (oder **--strip**) der Option [patch](https://www.man7.org/linux/man-pages/man1/patch.1.html)] mit dem Wert *striplevel*. Löst einen Fehler aus, wenn *patch* nicht geparst werden kann oder wenn an den Dateien im *basedirectory* keine Änderungen vorgenommen werden. Aktionen, die während des Patchvorgangs auftreten, einschließlich der Unmöglichkeit, einen Hunk anzuwenden, werden über das Befehlspräfix *reportcmd* gemeldet. Dateien mit Problemen bleiben unverändert, während Dateien ohne Probleme – unabhängig davon, ob sie vor oder nach den problematischen Dateien verarbeitet werden – gemäß dem *patch* geändert werden. Jeder Aufruf des Befehlspräfixes kann eine von drei möglichen Formen annehmen:


**{\*}reportcmd** **apply** *Dateiname*
: Dieser Aufruf erfolgt zu Beginn jeder Patch-Anwendung, wobei der *Dateiname* der zu patchenden Datei übergeben wird. Es wird versucht, alle für den *Dateinamen* gesammelten Hunks anzuwenden.

**{\*}reportcmd** **Fehler** *Dateiname* *Block* *erwartet* *tatsächlich*
: Dieser Aufruf erfolgt jedes Mal, wenn die Anwendung eines „Hunks“ fehlschlägt. Dem Befehl werden der gerade verarbeitete *Dateiname*, die *Hunk*-Nummer, der *erwartete* Text sowie der tatsächlich *erkannte* Text übergeben.

**{\*}reportcmd** **fail-already** *Dateiname* *Hunk*
: Dieser Aufruf erfolgt jedes Mal, wenn die Anwendung eines „Hunks“ fehlschlägt, weil die angegebene *Hunk*-Nummer *bereits* auf den *Dateinamen* angewendet wurde.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung
