---
CommandName: image
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bitmap(n)
 - options(n)
 - photo(n)
Keywords:
 - height
 - image
 - types of images
 - width
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

image - Erstellt und manipuliert Bilder

# ÜBERSICHT

::: {.synopsis} :::
[image]{.cmd} [option]{.arg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **image** erstellt, löscht und fragt Bilder ab. Er kann je nach dem Argument *option* verschiedene Formen annehmen. Die zulässigen Formen sind:

**image create** *type* ?*name*? ?*option value ...*?
: Erstellt ein neues Bild und einen Befehl mit demselben Namen und gibt dessen Namen zurück. *type* legt den Bildtyp fest, der einer der derzeit definierten Typen sein muss (z. B. **bitmap**). *name* gibt den Namen des Bildes an; wird er weggelassen, wählt Tk einen Namen der Form **image***x*, wobei *x* eine Ganzzahl ist. Es kann beliebig viele *option*-*value*-Paare geben, die Konfigurationsoptionen für das neue Bild liefern. Die zulässigen Optionen sind für jeden Bildtyp separat definiert; Details zu den Optionen eingebauter Bildtypen siehe unten. Existiert bereits ein Bild mit dem angegebenen Namen, wird es durch das neue Bild ersetzt und alle Instanzen dieses Bildes werden mit dem neuen Inhalt neu gezeichnet. Wichtig: Der Befehl **image** überschreibt stillschweigend jede Prozedur, die unter dem angegebenen Namen definiert sein könnte — den Namen also mit Bedacht wählen. Es wird empfohlen, einen separaten Namespace für Bildnamen zu verwenden (z. B. **::img::logo**, **::img::large**).

**image delete** ?*name name* ...?
: Löscht jedes der benannten Bilder und gibt einen leeren String zurück. Werden Instanzen der Bilder in Widgets angezeigt, werden die Bilder erst wirklich gelöscht, wenn alle Instanzen freigegeben sind. Die Zuordnung zwischen Instanzen und dem Bildmanager wird jedoch aufgehoben. Bestehende Instanzen behalten ihre Größen, zeigen aber leere Bereiche. Wird ein gelöschtes Bild mit einem weiteren Aufruf von **image create** neu erzeugt, verwenden die bestehenden Instanzen das neue Bild.

**image height** *name*
: Gibt einen Dezimalstring mit der Höhe des Bildes *name* in Pixeln zurück.

**image inuse** *name*
: Gibt einen booleschen Wert zurück, der angibt, ob das Bild *name* von Widgets verwendet wird.

**image names**
: Gibt eine Liste mit den Namen aller vorhandenen Bilder zurück.

**image type** *name*
: Gibt den Typ des Bildes *name* zurück (den Wert des Arguments *type* bei **image create**, als das Bild erzeugt wurde).

**image types**
: Gibt eine Liste zurück, deren Elemente alle gültigen Bildtypen sind (d. h. alle Werte, die für das Argument *type* bei **image create** angegeben werden können).

**image width** *name*
: Gibt einen Dezimalstring mit der Breite des Bildes *name* in Pixeln zurück.


Weitere Operationen (z. B. Schreiben des Bildes in eine Datei) können als Unterbefehle des Bildinstanz-Befehls verfügbar sein. Details stehen in der Manpage des jeweiligen Bildtyps.

# EINGEBAUTE BILDTYPEN

Die folgenden Bildtypen werden von Tk definiert und stehen in jeder Tk-Anwendung zur Verfügung. Einzelne Anwendungen oder Erweiterungen können weitere Typen definieren.

**bitmap**
: Jedes Pixel im Bild zeigt eine Vordergrundfarbe, eine Hintergrundfarbe oder nichts. Weitere Informationen in der Manpage **bitmap**.

**photo**
: Zeigt verschiedene Vollfarbbilder an und nutzt Dithering, um Farben auf Displays mit begrenzten Farbfähigkeiten anzunähern. Weitere Informationen in der Manpage **photo**.

