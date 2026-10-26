---
CommandName: tnc
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: 
Keywords:
 - Validation
 - DTD
Copyright:
---

# NAME

tnc - tnc ist eine Erweiterung eines expat-Parserobjekts, die den XML-Strom beim Lesen gegen die Dokument-DTD prüft.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdom]{.lit} 
[package]{.cmd} [require]{.sub} [tnc]{.lit} 

set parser \[expat\]

tnc \$parser enable
:::

# BESCHREIBUNG

*tnc* fügt einem Tcl-expat-Parserobjekt die C-Handler-Menge "tnc" hinzu. Diese Handler-Menge ist ein einfacher DTD-Prüfer. Erkennt der Prüfer einen Prüffehler, setzt er das Interpreter-Ergebnis, meldet einen Fehler und beendet das Lesen. Eine Wiederaufnahme nach einem Prüffehler gibt es nicht. Deshalb werden nur gültige Dokumente vollständig gelesen.

Diese Handler-Menge hat nur drei Methoden:

**tnc** *parserObj* **enable**
: 


Fügt einem Tcl-expat-Parserobjekt die C-Handler-Menge tnc hinzu.

**tnc** *parserObj* **remove**
: 


Entfernt den tnc-Prüfer vom Parser *parserObj* und gibt alle von ihm gespeicherten Angaben frei.

**tnc** *parserObj* **getValidateCmd** **?validateCmdName?**
: 


Gibt einen neu angelegten Prüfbefehl zurück, wenn der Parserbefehl einen bereithält, sonst wird ein Fehler gemeldet. Der Name des Prüfbefehls ist *validateCmdName*, wenn dieses optionale Argument angegeben ist, sonst ein zufällig gewählter Name. Ein Prüfbefehl steht in einem Parserbefehl zur Verfügung, wenn der Parser mit eingeschaltetem tnc zuvor ein XML-Dokument gelesen hat, das eine gültige Doctype-Deklaration hat, eine gültige externe Teilmenge, falls die Doctype-Deklaration eine angibt, und eine gültige interne Teilmenge. Das übrige Dokument muss nicht gültig sein, damit der Prüfbefehl zur Verfügung steht. Der Prüfbefehl lässt sich vom Parserbefehl nur einmal empfangen. Der angelegte Prüfbefehl hat diese Syntax:

```
validationCmd method ?args?
```

Die gültigen Methoden sind:

**validateDocument** *domDocument* *?varName?*
: Prüft, ob das angegebene domDocument gegen die DTD-Angaben gültig ist, die der Prüfbefehl darstellt. Gibt 1 zurück, wenn das Dokument gültig ist, sonst 0. Ist das Argument *varName* angegeben, wird die Variable dieses Namens auf den erkannten Grund des Prüffehlers gesetzt oder bei einem gültigen Dokument auf die leere Zeichenkette.

**validateTree** *elementNode* *?varName?*
: Prüft, ob der angegebene Teilbaum mit *domNode* als Wurzelelement ein möglicher gültiger Teilbaum eines Dokuments ist, das den DTD-Angaben des Prüfbefehls entspricht. IDREF lässt sich bei der Prüfung nur eines Teilbaums nicht prüfen, aber es wird geprüft, dass jedes bekannte ID-Attribut im Teilbaum eindeutig ist. Gibt 1 zurück, wenn der Teilbaum in Ordnung ist, sonst 0. Ist das Argument *varName* angegeben, wird die Variable dieses Namens auf den erkannten Grund des Prüffehlers gesetzt oder bei einem gültigen Teilbaum auf die leere Zeichenkette.

**validateAttributes** *elementNode* *?varName?*
: Prüft, ob es in der vom Prüfbefehl dargestellten DTD eine Elementdeklaration für den Namen des *elementNode* gibt und, wenn ja, ob die Attribute des *elementNode* den ATTLIST-Deklarationen für dieses Element in der DTD entsprechen. Gibt 1 zurück, wenn die Attribute und ihre Werttypen in Ordnung sind, sonst 0. Ist das Argument *varName* angegeben, wird die Variable dieses Namens auf den erkannten Grund des Prüffehlers gesetzt oder auf die leere Zeichenkette, wenn das Element alle erforderlichen Attribute hat, nur deklarierte Attribute und die Attributwerte ihrem Typ entsprechen.

**delete**
: Löscht den Prüfbefehl und gibt den von ihm belegten Speicher frei. Gibt die leere Zeichenkette zurück.


# BUGS

Die Meldungen von Prüffehlern könnten deutlich informativer und benutzerfreundlicher sein.

Der Prüfer erkennt mehrdeutige Inhaltsmodelle nicht, siehe XML-Empfehlung Abschnitt 3.2.1 und Anhang E. Die meisten Java-Prüfer erkennen sie ebenfalls nicht, behandeln solche Inhaltsmodelle aber dennoch richtig. Tnc tut das nicht. Hat die DTD solche mehrdeutigen Inhaltsmodelle, lässt sich tnc nicht zur Prüfung von Dokumenten gegen solche, nicht vollständig der XML-Spezifikation entsprechenden DTDs verwenden.

XML-Dokumente mit standalone="yes" in der XML-Deklaration lassen sich nicht prüfen.

Verstöße gegen die Gültigkeitseinschränkungen Proper Group/PE Nesting und Proper Conditional Section/PE Nesting werden nicht erkannt. Solche Verstöße können nur innerhalb einer ungültigen DTD auftreten, nicht im Inhalt eines Dokuments.
