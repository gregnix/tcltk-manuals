---
CommandName: diagram-viewer
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Documentation toolbox
Keywords:
 - canvas
 - conversion
 - diagram
 - vector
Copyright:
 - Copyright (c) 2010 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

diagram-viewer – Ein schlanker Diagramm-Prozessor

# ÜBERSICHT

::: {.synopsis} :::
[diagram-viewer]{.cmd} [show]{.sub} [inputfile...]{.arg} 
[diagram-viewer]{.cmd} [convert]{.sub} [-o]{.lit} [output]{.arg} [format]{.arg} [inputfile...]{.arg} 
:::

# BESCHREIBUNG

Die in diesem Dokument beschriebene Anwendung, **diagram-viewer**, ist ein schlanker Prozessor für tklib-Diagrammdateien

**diagram-viewer** basiert auf dem Paket **diagram**. Dort stehen Beispiele und die Sprachreferenz.

## Anwendungsfälle

**diagram-viewer** wurde unter Berücksichtigung der folgenden beiden Anwendungsfälle entwickelt.

**\[1\]**
: Prozess der Verarbeitung und Anzeige einer oder mehrerer Diagrammdateien.

**\[2\]**
: Stapelkonvertierung einer oder mehrerer Diagrammdateien in Rasterbilder.


## Befehlszeile

**diagram-viewer** **show** *inputfile*...
: Dies ist die Aufrufform für den Anwendungsfall \[1\]. Die Anwendung öffnet eine grafische Benutzeroberfläche, auf der links die Liste der Eingabedateien angezeigt wird, sodass der Benutzer auswählen kann, welche davon auf der rechten Seite auf dem Canvas dargestellt werden sollen.

**diagram-viewer** **convert** **-o** *output* *format* *inputfile*...
: Dies ist die Aufrufform für den Anwendungsfall \[2\]. Die Anwendung wandelt die Eingabedateien in ein Rasterbild des angegebenen *format* um.


path *output* (in)
: Dieses Argument legt fest, wohin das erzeugte Bild geschrieben werden soll. Es kann sich um den Pfad zu einer Datei oder einem Verzeichnis handeln. Wenn *output* nicht existiert, muss \[file dirname \$output\] vorhanden sein und es muss sich um ein beschreibbares Verzeichnis handeln. Bei mehreren Eingabedateien wird das generierte Bild in eine Datei in diesem Verzeichnis geschrieben, wobei der Name dieser Datei aus *inputfile* und *format* abgeleitet wird. Bei einer einzelnen Eingabedatei wird das generierte Bild in diese Datei geschrieben.

(handle) *format* (in)
: Dieses Argument legt das Bildformat fest, in das die Diagramme bei der Verarbeitung der Eingabe konvertiert werden sollen. Die Anwendung erkennt alle Formate, die vom Paket **Img** unterstützt werden, d. h. für die sie ein Paket **img::format** (zusammen mit **canvas::snap**) laden kann, sowie alle Formate, für die sie ein Paket **canvas::format** laden kann. Dies sind (derzeit) **mvg** und **pdf**.

path *inputfile* (in)
: Dieses Argument legt den Pfad zur zu verarbeitenden Diagrammdatei fest. Die Datei muss vorhanden und lesbar sein sowie im *diagram*-Format vorliegen.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und die darin beschriebene Anwendung enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *diagram* der [Tcllib-SF-Tracker](http://sourceforge.net/tracker/?group_id=12883). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen an der Anwendung oder an der Dokumentation.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument sowie das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *diagram* des [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Bitte teilen Sie uns auch Ihre Ideen für Verbesserungen mit, die Sie möglicherweise für eines der beiden Pakete und/oder die Dokumentation haben.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2010 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
