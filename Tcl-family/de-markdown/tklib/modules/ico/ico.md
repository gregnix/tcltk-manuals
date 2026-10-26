---
CommandName: ico
ManualSection: n
Version: 1.1.3
TclPart: tklib
TclDescription: Windows ICO handling
Keywords:
 - dll
 - entry
 - exe
 - ico
 - icon
Copyright:
---

# NAME

ico – Windows-Symbole lesen und schreiben

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [ico]{.lit} [1.1.3]{.optlit} 
[::ico::icons]{.cmd} [file]{.arg} [option value]{.optdot} 
[::ico::iconMembers]{.cmd} [file]{.arg} [name]{.arg} [option value]{.optdot} 
[::ico::getIcon]{.cmd} [file]{.arg} [name]{.arg} [option value]{.optdot} 
[::ico::getIconByName]{.cmd} [file]{.arg} [name]{.arg} [option value]{.optdot} 
[::ico::getFileIcon]{.cmd} [file]{.arg} [option value]{.optdot} 
[::ico::writeIcon]{.cmd} [file]{.arg} [name]{.arg} [depth]{.arg} [data]{.arg} [option value]{.optdot} 
[::ico::copyIcon]{.cmd} [file]{.arg} [index]{.arg} [file2]{.arg} [index2]{.arg} [option value]{.optdot} 
[::ico::EXEtoICO]{.cmd} [file]{.arg} [dir]{.optarg} 
[::ico::clearCache]{.cmd} [file]{.optarg} 
[::ico::transparentColor]{.cmd} [image]{.arg} [color]{.arg} 
[::ico::Show]{.cmd} [file]{.arg} [option value]{.optdot} 
:::

# BESCHREIBUNG

Dieses Paket bietet Funktionen zum Lesen und Schreiben von Windows-Symbolen aus ICO-, EXE-, DLL-, ICL- und BMP-Dateien. Im Sinne dieses Moduls ist ein Symbol eine visuelle Darstellung eines Objekts. Ein Symbol besteht aus einem oder mehreren Bildern, die in der Regel unterschiedliche Auflösungen und Farbtiefen aufweisen. Jedes Symbol und jedes Bild verfügt über eine Ressourcen-ID, bei der es sich um eine Textzeichenfolge oder einen positiven ganzzahligen Wert handeln kann. Die meisten Befehle verwenden diese ID, um festzulegen, auf welches Symbol oder Bild sie angewendet werden sollen.

# API

**::ico::icons** *file* ?*option* *value*...?
: Gibt eine Liste der Symbole in *file* zurück. Jedes Element ist der Name oder die numerische ID. Erkennt diese Optionen:


**-type** fileFormat
: 


**::ico::iconMembers** *file* *name* ?*option* *value*...?
: Gibt eine Liste der Bilder zurück, aus denen das Symbol mit der ID *name* besteht. Jedes Element ist selbst eine Unterliste der Form {name width height bpp}. Erkennt diese Optionen:


**-type** fileFormat
: 


**::ico::getIcon** *file* *name* ?*option* *value*...?
: Extrahiert das Symbol mit der ID *name* aus *file*. Voreingestellt ist **-format** **image** und der Befehl gibt den Namen eines Tk-Bildes mit dem Symbol zurück. Auflösung und Farbtiefe wählen ?-res?, ?-bpp? und ?-exact?. Ist -exact angegeben und gibt es keine genaue Entsprechung, entsteht ein Fehler. Mit **-image** lässt sich der Name des erzeugten Tk-Bildes angeben. Ist **-format** **colors**, kommt eine Liste von Farbnamen im Format #RRGGBB zurück. Jedes Listenelement ist eine waagerechte Zeile. Jede Zeile enthält die Farben aller Pixel dieser Zeile von links nach rechts. Ist **-format** **name**, kommt der Ressourcenname des gewählten Bildes zurück. Das ist nützlich für writeIcon oder getIconByName. Erkennt diese *option*.


**-type** fileFormat
: ...siehe nächstes...

**-format** value
: ...siehe nächstes...

**-image** value
: ...siehe nächstes...

**-res** value
: ...siehe nächstes...

**-bpp** value
: ...siehe nächstes...

**-exact** value
: 


**::ico::getIconByName** *file* *name* ?*option* *value*...?
: Extrahiert das Bild mit der ID *name* aus *file*. Dieser Name sollte der Name eines bestimmten Bildes sein, wie er von **::ico::iconMembers** gegeben wird, und nicht der Name eines Symbols, der von **::ico::icons** gegeben wird. Wenn in *file* keine passende Ressourcen-ID vorhanden ist, wird ein Fehler ausgelöst. Die folgenden Optionen werden unterstützt:


**-type** fileFormat
: ...siehe nächstes...

**-format** value
: 


**::ico::getFileIcon** *file* ?*option* *value*...?
: Dieser Befehl arbeitet nur unter Windows. Er liest die Windows-Registrierung, um das Anzeigesymbol für *file* zu bestimmen, wie es im Explorer oder einem ähnlichen Programm erschiene. *file* muss nicht existieren und kann auch eine Dateiendung mit führendem Punkt sein. Ist *file* ein Verzeichnis oder heißt es **Folder**, kommt das Ordnersymbol zurück. Argumente und Gebrauch sind dieselben wie bei **getIcon**:


**-format** value
: ...siehe nächstes...

**-image** value
: ...siehe nächstes...

**-res** value
: ...siehe nächstes...

**-bpp** value
: ...siehe nächstes...

**-exact** value
: 


**::ico::writeIcon** *file* *name* *depth* *data* ?*option* *value*...?
: Schreibt ein Bild nach *file*. *name* ist der Ressourcenbezeichner des Bildes in *file*, das geschrieben wird. In eine EXE-, DLL- oder ICL-Datei lassen sich vorhandene Symbole nur mit einem Symbol derselben Abmessungen und Farbtiefe überschreiben. Diesen Dateitypen lassen sich keine Symbole hinzufügen. Beim Schreiben nach BMP wird der Name ignoriert, weil dieser Typ nur ein Bild enthalten kann. Existiert die Datei schon, wird sie vollständig überschrieben. Beim Schreiben nach ICO oder ICODATA wird ein Bild angehängt und der nächste Name in der Folge vergeben, wenn der angegebene Name nicht existiert. Der angegebene Name wird dann ignoriert. Bilder in ICO- und ICODATA-Dateien lassen sich mit anderen Abmessungen oder Farbtiefen überschreiben. Wer nicht jedes Bild ändert, aus dem ein Symbol besteht, bekommt beim Anzeigen merkwürdige Ergebnisse.


integer *depth* (in)
: Dieses Argument muss **1**, **4**, **8**, **24** oder **32** sein. Hat *data* mehr Farben, als die Farbtiefe erlaubt, entsteht ein Fehler.

options *data* (in)
: Dieses Argument ist entweder eine Farbliste in der Form von **::ico::getIcon -format colors** oder der Name eines Tk-Bildes.


Erkennt diese *option*.

**-type** fileFormat
: 


**::ico::copyIcon** *file* *index* *file2* *index2* ?*option* *value*...?
: Kopiert das Symbol bei *index* in *file* nach *index2* in *file2*.


**-fromtype** fileFormat
: ...siehe nächstes...

**-totype** fileFormat
: 


**::ico::EXEtoICO** *file* ?dir?
: Extrahiert alle Symbole aus der ausführbaren Datei *file* in ICO-Dateien in *dir*. ?dir? ist voreingestellt das Verzeichnis, in dem *file* liegt. Die Symboldateien heißen *file*-ID.ico, wobei ID der Ressourcenbezeichner des Symbols ist.


**-type** fileFormat
: 


**::ico::clearCache** ?file?
: Der Befehl **::ico::getIconList** speichert Symbolversätze in EXE-, DLL-, ICL- und ICO-Dateien, damit das Extrahieren schneller geht. Dieser Befehl leert den Speicher für die angegebene ?file? oder für alle Dateien.

**::ico::transparentColor** *image* *color*
: Wenn *image* aus einem einzigen Wort besteht, wird davon ausgegangen, dass es sich um den Namen eines Tk-Bildes handelt. Alle Pixel im *image*, die der Farbe *color* entsprechen, werden mit Transparenz gesetzt. Alternativ kann *image* auch eine Farbliste sein; in diesem Fall wird eine modifizierte Liste zurückgegeben.

**::ico::Show** *file* ?*option* *value*...?
: Befehl auf Anwendungsebene. Zeigt ein Fenster mit allen Symbolen in *file* und ihrem Namen.


**-type** fileFormat
: ...siehe nächstes...

**-parent** pathName
: 


# BEISPIEL

```
    button .explore -image [::ico::getIcon explorer.exe 0 -name explore -res 16 -bpp 8]

    set i [lsearch -inline [::ico::iconMembers tclkit.exe 0] {* 32 32 8}]
    set colorlist [::ico::getIconByName tclkit.exe [lindex $i 0] -format colors]
```

# EINSCHRÄNKUNGEN

Anderen Dateitypen als ICO lassen sich keine Symbole hinzufügen oder entnehmen. Symbole in diesen Dateien lassen sich nur durch Symbole derselben Abmessungen und Farbtiefe ersetzen.

Symbole mit 8bpp oder weniger müssen Schwarz in der Palette haben. Enthält das Symbol kein Schwarz, muss eine Farbe frei bleiben, damit writeIcon sie aufnimmt.

Derzeit gibt es keine Möglichkeit, Alphakanal-Informationen aus 32-bpp-Symbolen auszulesen.

Tk-Bilder haben keinen Alphakanal. Ein echtes 32bpp-Symbol lässt sich deshalb nur aus einer Farbliste schreiben. Ein 32bpp-Symbol aus einem Tk-Bild zu schreiben ist dasselbe wie ein 24bpp-Symbol.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *ico* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
