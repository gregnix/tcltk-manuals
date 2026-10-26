---
CommandName: inifile
ManualSection: n
Version: 0.3.3
TclPart: tcllib
TclDescription: Parsing of Windows INI files
Copyright:
---

# NAME

inifile – Auswerten von Windows-INI-Dateien

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [inifile]{.lit} [0.3.3]{.optlit} 
[::ini::open]{.cmd} [file]{.arg} [-encoding encoding]{.optarg} [access]{.optarg} 
[::ini::close]{.cmd} [ini]{.arg} 
[::ini::commit]{.cmd} [ini]{.arg} 
[::ini::revert]{.cmd} [ini]{.arg} 
[::ini::filename]{.cmd} [ini]{.arg} 
[::ini::sections]{.cmd} [ini]{.arg} 
[::ini::keys]{.cmd} [ini]{.arg} [section]{.arg} 
[::ini::get]{.cmd} [ini]{.arg} [section]{.arg} 
[::ini::exists]{.cmd} [ini]{.arg} [section]{.arg} [key]{.optarg} 
[::ini::value]{.cmd} [ini]{.arg} [section]{.arg} [key]{.arg} [default]{.optarg} 
[::ini::set]{.cmd} [ini]{.arg} [section]{.arg} [key]{.arg} [value]{.arg} 
[::ini::delete]{.cmd} [ini]{.arg} [section]{.arg} [key]{.optarg} 
[::ini::comment]{.cmd} [ini]{.arg} [section]{.arg} [key]{.optarg} [text]{.optarg} 
[::ini::commentchar]{.cmd} [char]{.optarg} 
:::

# BESCHREIBUNG

Dieses Paket bietet eine Schnittstelle zur einfachen Bearbeitung von Windows-INI-Dateien.

**::ini::open** *file* ?**-encoding** *encoding*? ?*access*?
: Öffnet eine INI-Datei und gibt ein Handle zurück, das von anderen Befehlen verwendet wird. *access* entspricht der ersten (nicht POSIX-konformen) Form des Befehls **open**, mit der Ausnahme, dass der Modus **a** nicht unterstützt wird. Der Standardmodus ist **r+**. Die Standard-*Kodierung* ist die Systemkodierung.

**::ini::close** *ini*
: Schließt das angegebene Handle. Falls Änderungen vorgenommen, aber nicht mit **commit** gespeichert wurden, gehen diese verloren.

**::ini::commit** *ini*
: Schreibt die Datei und alle Änderungen auf die Festplatte. Die Abschnitte werden in beliebiger Reihenfolge geschrieben. Die Schlüssel innerhalb eines Abschnitts werden in alphabetischer Reihenfolge geschrieben. Wenn die INI-Datei im schreibgeschützten Modus geöffnet wurde, wird ein Fehler ausgelöst.

**::ini::revert** *ini*
: Setzt alle am inifile-Objekt vorgenommenen Änderungen auf den zuletzt festgeschriebenen Zustand zurück.

**::ini::filename** *ini*
: Gibt den Namen der Datei zurück, mit der das *ini*-Objekt verknüpft ist.

**::ini::sections** *ini*
: Gibt eine Liste aller Namen der vorhandenen Abschnitte im angegebenen Dateihandle zurück.

**::ini::keys** *ini* *section*
: Gibt eine Liste aller Schlüsselnamen in dem angegebenen Abschnitt und der angegebenen Datei zurück.

**::ini::get** *ini* *section*
: Gibt eine Liste von Schlüssel-Wert-Paaren zurück, die in dem angegebenen Abschnitt und der angegebenen Datei vorhanden sind.

**::ini::exists** *ini* *section* ?*key*?
: Gibt einen booleschen Wert zurück, der angibt, ob der angegebene Abschnitt als Ganzes oder der angegebene Schlüssel innerhalb dieses Abschnitts vorhanden ist.

**::ini::value** *ini* *section* *key* ?*default*?
: Gibt den Wert des angegebenen Schlüssels und Abschnitts zurück. Wenn angegeben, wird der Standardwert zurückgegeben, wenn der Schlüssel nicht existiert. Wenn der Schlüssel nicht existiert und kein Standardwert festgelegt wurde, wird ein Fehler ausgelöst.

**::ini::set** *ini* *section* *key* *value*
: Legt den Wert des Schlüssels im angegebenen Abschnitt fest. Wenn der Abschnitt nicht existiert, wird ein neuer erstellt.

**::ini::delete** *ini* *section* ?*key*?
: Entfernt den Schlüssel oder den gesamten Abschnitt samt aller darin enthaltenen Schlüssel. Ein Abschnitt wird nicht automatisch gelöscht, wenn er keine Schlüssel mehr enthält.

**::ini::comment** *ini* *section* ?*key*? ?*text*?
: Liest und ändert Kommentare für Abschnitte und Schlüssel. Um einen Abschnitts-Kommentar zu schreiben, verwenden Sie eine leere Zeichenkette für den *Schlüssel*. Um alle Kommentare zu entfernen, verwenden Sie eine leere Zeichenkette für *text*. *text* kann aus einer Liste von Zeilen oder einer einzelnen Zeile bestehen. Alle in *text* enthaltenen Zeilenumbrüche werden korrekt verarbeitet. Kommentare können für nicht vorhandene Abschnitte oder Schlüssel geschrieben werden und führen nicht zu einem Fehler. Das Lesen eines Kommentars aus einem nicht vorhandenen Abschnitt oder Schlüssel gibt eine leere Zeichenkette zurück.

**::ini::commentchar** ?Zeichen?
: Liest das Kommentarzeichen aus und legt es fest. Zeilen, die mit diesem Zeichen beginnen, werden als Kommentare behandelt. Wenn Kommentare ausgegeben werden, wird jedem Satz dieses Zeichen vorangestellt. Die Standardeinstellung ist **;**.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *inifile* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung
