---
CommandName: filename
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - glob(n)
 - zipfs(n)
Keywords:
 - current directory
 - absolute file name
 - relative file name
 - volume-relative file name
 - portability
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# NAME

filename - Von Tcl-Befehlen unterstützte Dateinamenskonventionen

# EINLEITUNG

Alle Tcl-Befehle und C-Prozeduren, die Dateinamen als Argumente erwarten, verlangen Dateinamen in einer von drei Formen, abhängig von der aktuellen Plattform. Auf jeder Plattform unterstützt Tcl Dateinamen in der oder den Standardform(en) dieser Plattform. Zusätzlich unterstützt Tcl auf allen Plattformen eine Unix-ähnliche Syntax, um einfache Dateinamen bequem zu konstruieren. Portierbare Skripte sollten jedoch keine bestimmte Form für Dateinamen voraussetzen. Stattdessen müssen portierbare Skripte die Befehle **file split** und **file join** zum Bearbeiten von Dateinamen verwenden (Einzelheiten im Manpage-Eintrag **file**).

# PFADTYPEN

Dateinamen werden in drei allgemeine Typen eingeteilt, je nach Ausgangspunkt des Pfads zur Angabe der Datei: absolut, relativ und volumen-relativ. Absolute Namen sind vollständig qualifiziert und geben einen Pfad zur Datei relativ zu einem bestimmten Volume und dem Stammverzeichnis auf diesem Volume an. Relative Namen sind unqualifiziert und geben einen Pfad relativ zum aktuellen Arbeitsverzeichnis an. Volumen-relative Namen sind teilweise qualifiziert — entweder relativ zum Stammverzeichnis auf dem aktuellen Volume oder relativ zum aktuellen Verzeichnis des angegebenen Volumes. Der Befehl **file pathtype** kann verwendet werden, um den Typ eines gegebenen Pfads zu bestimmen.

# PFAD-SYNTAX

Die Regeln für native Namen hängen vom Wert des Tcl-Elements **platform** im Array **tcl_platform** ab:

**Unix**
: Auf Unix- und Apple-macOS-Plattformen verwendet Tcl Pfadnamen, deren Komponenten durch Schrägstriche getrennt sind. Pfadnamen können relativ oder absolut sein, und Dateinamen dürfen jedes Zeichen außer Schrägstrich enthalten. Die Dateinamen **\&.** und **\&..** sind speziell und bezeichnen das aktuelle bzw. das übergeordnete Verzeichnis. Mehrere benachbarte Schrägstriche gelten als ein einzelnes Trennzeichen, außer dem ersten Doppel-Schrägstrich **//** in absoluten Pfaden. Beliebig viele abschließende Schrägstriche am Pfadende werden ignoriert, sodass **foo**, **foo/** und **foo//** identisch sind; insbesondere bedeutet **foo/** nicht zwingend ein Verzeichnis.
    Die folgenden Beispiele veranschaulichen verschiedene Pfadformen:

**/**
: Absoluter Pfad zum Stammverzeichnis.

**/etc/passwd**
: Absoluter Pfad zur Datei **passwd** im Verzeichnis **etc** im Stammverzeichnis.

**\&.**
: Relativer Pfad zum aktuellen Verzeichnis.

**foo**
: Relativer Pfad zur Datei **foo** im aktuellen Verzeichnis.

**foo/bar**
: Relativer Pfad zur Datei **bar** im Verzeichnis **foo** im aktuellen Verzeichnis.

**\&../foo**
: Relativer Pfad zur Datei **foo** im Verzeichnis über dem aktuellen Verzeichnis.


**Windows**
: Auf Microsoft-Windows-Plattformen unterstützt Tcl sowohl laufwerks-relative als auch UNC-Namen. Sowohl **/** als auch **\\** können als Verzeichnistrenner verwendet werden. Laufwerks-relative Namen bestehen aus einem optionalen Laufwerksbezeichner gefolgt von einem absoluten oder relativen Pfad. UNC-Pfade folgen der Form **\\servername\sharename\path\file**, müssen aber mindestens Server- und Freigabe-Komponenten enthalten, also **\\servername\sharename**. In beiden Formen sind **.** und **..** speziell und bezeichnen das aktuelle bzw. das übergeordnete Verzeichnis. Die folgenden Beispiele veranschaulichen verschiedene Pfadformen:

**\&\\Host\share/file**
: Absoluter UNC-Pfad zu einer Datei **file** im Stammverzeichnis der Freigabe **share** auf dem Host **Host**. Wiederholtes **file dirname** auf diesem Pfad liefert **//Host/share**, nie nur **//Host**.

**c:foo**
: Volumen-relativer Pfad zur Datei **foo** im aktuellen Verzeichnis auf Laufwerk **c**.

**c:/foo**
: Absoluter Pfad zur Datei **foo** im Stammverzeichnis von Laufwerk **c**.

**foo\bar**
: Relativer Pfad zur Datei **bar** im Verzeichnis **foo** im aktuellen Verzeichnis auf dem aktuellen Volume.

**\&\foo**
: Volumen-relativer Pfad zur Datei **foo** im Stammverzeichnis des aktuellen Volumes.

**\&\\foo**
: Volumen-relativer Pfad zur Datei **foo** im Stammverzeichnis des aktuellen Volumes. Das ist kein gültiger UNC-Pfad; die zusätzlichen Backslashes gelten als überflüssig.



# TILDE-ERSETZUNG

Zusätzlich zu den oben beschriebenen Dateinamensregeln unterstützt Tcl *csh*-artige Tilde-Ersetzung. Beginnt ein Dateiname mit einer Tilde, wird er so interpretiert, als wäre das erste Element durch das Home-Verzeichnis des angegebenen Benutzers ersetzt. Folgt der Tilde unmittelbar ein Trennzeichen, wird die Umgebungsvariable **$HOME** substituiert. Andernfalls werden die Zeichen zwischen Tilde und dem nächsten Trennzeichen als Benutzername genommen, um das Home-Verzeichnis für die Substitution zu ermitteln. Das funktioniert unter Unix, macOS und Windows (außer sehr alten Versionen).

Ältere Windows-Plattformen unterstützen keine Tilde-Ersetzung, wenn ein Benutzername der Tilde folgt. Dort führt der Versuch, eine Tilde mit Benutzernamen zu verwenden, zu einem Fehler, dass der Benutzer nicht existiert, wenn Tcl diesen Pfadteil interpretiert oder sonst auf die Datei zugreift. Das Verhalten solcher Pfade ohne Interpretationsversuch entspricht Unix. Dateinamen mit Tilde ohne Benutzernamen werden korrekt über **$HOME** substituiert, wie unter Unix.

# PORTABILITÄTSFRAGEN

Nicht alle Dateisysteme unterscheiden Groß-/Kleinschreibung; Skripte sollten Code vermeiden, der von der Schreibweise in Dateinamen abhängt. Zudem können erlaubte Zeichensätze je Gerät variieren; Skripte sollten Dateinamen ohne Sonderzeichen wie **<>:?"/\|** wählen. Am sichersten sind Namen nur aus alphanumerischen Zeichen. Vorsicht bei Dateinamen mit Leerzeichen (häufig unter Windows) und bei Dateinamen, bei denen Backslash das Verzeichnistrennzeichen ist (native Windows-Pfade).

Unter Windows gelten Längenbeschränkungen für Dateien und Pfade. Vollständige Pfade oder Dateinamen länger als etwa 260 Zeichen führen bei den meisten Dateioperationen zu Fehlern.

Eine weitere Windows-Besonderheit: beliebig viele abschließende Punkte „.“ in Dateinamen werden völlig ignoriert — der Versuch, eine Datei oder ein Verzeichnis „foo.“ zu erstellen, erzeugt „foo“. Das spiegelt sich in den Ergebnissen von **file normalize** wider. Außerdem ist ein Dateiname, der nur aus Punkten besteht („.........“) oder aus Punkten mit nachfolgenden Zeichen („.....abc“), unzulässig.
