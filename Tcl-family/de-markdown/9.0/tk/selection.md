---
CommandName: selection
ManualSection: n
Version: 8.1
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - clipboard(n)
Keywords:
 - clear
 - format
 - handler
 - ICCCM
 - own
 - selection
 - target
 - type
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

selection - X-Auswahl steuern

# ÜBERSICHT

::: {.synopsis} :::
[selection]{.cmd} [option]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Dieser Befehl bietet eine Tcl-Schnittstelle zum X-Selection-Mechanismus und implementiert die vollständige Selection-Funktionalität aus dem X Inter-Client Communication Conventions Manual (ICCCM).

Zur Verwaltung der **CLIPBOARD**-Selection (siehe unten) kann auch der Befehl **clipboard** verwendet werden.

Das erste Argument von **selection** legt das Format der weiteren Argumente und das Verhalten fest. Unterstützt werden:

**selection clear** ?**-displayof** *window*? ?**-selection** *selection*?
: Existiert *selection* irgendwo auf dem Display von *window*, wird sie gelöscht, sodass kein Fenster die Selection mehr besitzt. *Selection* gibt die zu löschende X-Selection an und sollte ein Atom-Name wie **PRIMARY** oder **CLIPBOARD** sein; Details im Inter-Client Communication Conventions Manual. *Selection* standardmäßig **PRIMARY**, *window* standardmäßig „.“. Gibt einen leeren String zurück.

**selection get** ?**-displayof** *window*? ?**-selection** *selection*? ?**-type** *type*?
: Liest den Wert von *selection* vom Display von *window* und gibt ihn zurück. *Selection* standardmäßig **PRIMARY**, *window* standardmäßig „.“. *Type* legt die Rückgabeform fest (gewünschtes ICCCM-„target“ für die Konvertierung) und sollte ein Atom-Name wie **STRING** oder **FILE_NAME** sein; Details im ICCCM. *Type* standardmäßig **STRING**. Der Selection-Besitzer kann die Selection in verschiedenen Darstellungsformaten zurückgeben, z. B. **STRING**, **UTF8_STRING**, **ATOM**, **INTEGER** usw. (dieses Format unterscheidet sich vom Selection-Typ; Details im ICCCM). Wird die Selection in einem Nicht-String-Format wie **INTEGER** oder **ATOM** geliefert, wandelt **selection** sie in einen String aus durch Leerzeichen getrennten Feldern um: Atome werden in ihre Textnamen, alles andere in hexadezimale Ganzzahlen. **selection get** liest die Selection nicht im Format **UTF8_STRING**, sofern nicht angefordert.

**selection handle** ?**-selection** *s*? ?**-type** *t*? ?**-format** *f*? *window command*
: Erzeugt einen Handler für Selection-Anfragen: *command* wird ausgeführt, wenn *window* die Selection *s* besitzt und jemand sie in der durch Typ *t* angegebenen Form abruft (z. B. *t* in **selection get**). *S* standardmäßig **PRIMARY**, *t* standardmäßig **STRING**, *f* standardmäßig **STRING**. Ist *command* ein leerer String, wird ein vorhandener Handler für *window*, *t* und *s* entfernt. Wird die Selection als Typ **STRING** behandelt, geschieht das automatisch auch für **UTF8_STRING**.
    Bei einer Selection-Anfrage ist *window* der Besitzer, *type* der angeforderte Typ; *command* wird als Tcl-Befehl mit zwei zusätzlichen Zahlen (durch Leerzeichen getrennt) ausgeführt: *offset* und *maxChars*. *offset* ist die Startposition in der Selection, *maxChars* die maximale Zeichenanzahl. Der Befehl soll höchstens *maxChars* Zeichen ab Position *offset* zurückgeben. Bei sehr großen Selections (größer als *maxChars*) erfolgt mehrfacher Aufruf von *command* mit steigendem *offset*. Ist die Ergebnislänge kleiner als *maxChars*, gilt der Rest als geliefert; ist sie gleich *maxChars*, wird *command* erneut aufgerufen, bis ein kürzeres Ergebnis kommt. *maxChars* ist stets relativ groß (Tausende Zeichen).
    Liefert *command* einen Fehler, wird die Abfrage abgelehnt, als ob die Selection nicht existierte.
    *format* legt die Übertragungsdarstellung fest (ICCCM Tabelle 2, Spalte 2), Standard **STRING**. Bei **STRING**: 8-Bit-ASCII (wie von *command* zurückgegeben, in der System-**encoding**; **UTF8_STRING** nutzt stets UTF-8). Bei **ATOM**: Rückgabe von *command* in durch Leerzeichen getrennte Felder, jedes Feld zum Atom-Wert, 32-Bit-Atom-Wert statt Name. Bei anderem *format*: Felder zu 32-Bit-Ganzzahlen, Array an den Anforderer.
    *format* ist nur für Kompatibilität mit Anfragern nötig, die kein Tk verwenden. Bei Tk-Abfrage wird am Ende wieder ein String geliefert — *format* ist irrelevant.

**selection own** ?**-displayof** *window*? ?**-selection** *selection*?
: ...siehe nächstes...

**selection own** ?**-command** *command*? ?**-selection** *selection*? *window*
: Die erste Form von **selection own** gibt den Pfadnamen des Fensters in dieser Anwendung zurück, das *selection* auf dem Display von *window* besitzt, oder einen leeren String, wenn kein Fenster in dieser Anwendung die Selection besitzt. *Selection* standardmäßig **PRIMARY**, *window* standardmäßig „.“.
    Die zweite Form lässt *window* neuer Besitzer von *selection* auf dem Display von *window* werden; Rückgabe ist ein leerer String. Der bisherige Besitzer wird benachrichtigt, dass er die Selection verloren hat. Ist *command* angegeben, ist es ein Tcl-Skript, das ausgeführt wird, wenn ein anderes Fenster die Selection von *window* übernimmt. *Selection* standardmäßig **PRIMARY**.


# WIDGET-FUNKTIONEN

Die Widgets **text**, **entry**, **ttk::entry**, **listbox**, **spinbox** und **ttk::spinbox** haben die Option **-exportselection**. Ist sie auf den booleschen Wert **true** gesetzt, wird (in einem unsicheren Interpreter) eine im Widget getroffene Auswahl automatisch in die **PRIMARY**-Selection geschrieben.

Ein GUI-Ereignis, z. B. **<\<PasteSelection>>**, kann die **PRIMARY**-Selection in bestimmte Widgets kopieren. Die Kopie erfolgt über eine Widget-Bindung an das Ereignis; das Bindungs-Skript ruft **selection** auf.

# PORTIERBARKEIT

Unter X11 ist die **PRIMARY**-Selection eine systemweite Funktion des X-Servers und ermöglicht Kommunikation zwischen verschiedenen X11-Client-Prozessen.

Unter Windows stellt das System keine **PRIMARY**-Selection bereit, sondern nur Tk; sie wird nur zwischen Fenstern eines Eltern-Interpreters und seiner Kind-Interpreter geteilt, nicht zwischen Interpretern in verschiedenen Prozessen oder Threads. Jeder Eltern-Interpreter hat eine eigene **PRIMARY**-Selection, die nur mit seinen Kind-Interpreter geteilt wird, die keine sicheren Interpreter sind.

# SICHERHEIT

Ein sicherer Interpreter kann die **PRIMARY**-Selection nicht lesen, weil sein **selection**-Befehl verborgen ist. Daher kann die **PRIMARY**-Selection nicht in die Tk-Widgets eines sicheren Interpreters geschrieben werden.

Ein Tk-Widget kann **-exportselection** auf **true** setzen; in einem sicheren Interpreter hat diese Option keine Wirkung: Schreiben vom Widget in die **PRIMARY**-Selection ist deaktiviert.

Das sind Sicherheitsmerkmale. In einem sicheren Interpreter können nicht vertrauenswürdige Skripte ausgeführt werden, und es wäre ein Sicherheitsrisiko, wenn dieser Code die **PRIMARY**-Selection anderer Interpreter lesen oder beschreiben könnte.

# BEISPIELE

Auf X11-Plattformen ist eine der Standard-Selections die **SECONDARY**-Selection. Sie wird kaum genutzt; so liest man sie mit Tk:

```
set selContents [selection get -selection SECONDARY]
```

Für eine Selection können viele Datentypen verfügbar sein; der spezielle Typ **TARGETS** liefert eine Liste verfügbarer Typen:

```
foreach type [selection get -type TARGETS] {
   puts "Selection PRIMARY supports type $type"
}
```

Um die Selection zu beanspruchen, richten Sie zuerst einen Handler ein, der die Daten liefert. Dann beanspruchen Sie die Selection …

```
# Daten-Handler für eingehende Anfragen einrichten
set foo "This is a string with some data in it... blah blah"
selection handle -selection SECONDARY . getData
proc getData {offset maxChars} {
   puts "Retrieving selection starting at $offset"
   return [string range $::foo $offset [expr {$offset+$maxChars-1}]]
}

# Selection selbst beanspruchen
puts "Claiming selection"
selection own -command lost -selection SECONDARY .
proc lost {} {
   puts "Lost selection"
}
```
