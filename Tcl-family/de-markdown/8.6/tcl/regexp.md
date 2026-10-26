---
CommandName: regexp
ManualSection: n
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - re_syntax(n)
 - regsub(n)
 - string(n)
Keywords:
 - match
 - parsing
 - pattern
 - regular expression
 - splitting
 - string
Copyright:
 - Copyright (c) 1998 Sun Microsystems, Inc.
---

# NAME

regexp - Regulären Ausdruck gegen eine Zeichenkette prüfen

# ÜBERSICHT

::: {.synopsis} :::
[regexp]{.cmd} [switches]{.optarg} [exp]{.arg} [string]{.arg} [matchVar]{.optarg} [subMatchVar subMatchVar]{.optdot} 
:::

# BESCHREIBUNG

Prüft, ob der reguläre Ausdruck *exp* einen Teil oder die gesamte *string* trifft, und gibt 1 zurück, wenn ja, sonst 0 — außer **-inline** ist angegeben (siehe unten). (Reguläre Ausdrücke werden auf der Referenzseite **re_syntax** beschrieben.)

Werden nach *string* weitere Argumente angegeben, gelten sie als Namen von Variablen, in denen Informationen darüber zurückgegeben wird, welche Teil(e) von *string* zu *exp* passten. *matchVar* erhält den Bereich von *string*, der ganz zu *exp* passte. Die erste *subMatchVar* enthält die Zeichen in *string*, die zur linken geklammerten Unterausdrucks in *exp* passten, die nächste *subMatchVar* die zum nächsten geklammerten Unterausdruck rechts davon usw.

Beginnen die ersten Argumente von **regexp** mit **-**, werden sie als Schalter behandelt. Unterstützt werden:

**-about**
: Statt zu matchen wird eine Liste mit Informationen über den regulären Ausdruck zurückgegeben. Erstes Element: Anzahl der Unterausdrücke. Zweites: Liste von Eigenschaftsnamen zu Attributen des Ausdrucks. Vor allem für Debugging.

**-expanded**
: Erweiterte RE-Syntax: Leerraum und Kommentare werden ignoriert. Entspricht der eingebetteten Option **(?x)** (siehe **re_syntax**).

**-indices**
: Ändert, was in *matchVar* und *subMatchVar* gespeichert wird: statt der passenden Zeichen je zwei Dezimalstrings mit den Indizes des ersten und letzten Zeichens des Trefferbereichs in *string*.

**-line**
: Zeilenumbruch-sensitives Matching. Standard: Zeilenumbruch ist ein normales Zeichen. Mit diesem Flag: „[^“-Klammerausdrücke und „.“ treffen keinen Zeilenumbruch; „^“ zusätzlich leere Zeichenkette nach jedem Zeilenumbruch; „$“ zusätzlich davor. Entspricht **-linestop** und **-lineanchor** zusammen oder **(?n)** (siehe **re_syntax**).

**-linestop**
: „[^“ und „.“ stoppen an Zeilenumbrüchen. Wie **(?p)** (siehe **re_syntax**).

**-lineanchor**
: „^“ und „$“ (Anker) treffen Zeilenanfang bzw. -ende. Wie **(?w)** (siehe **re_syntax**).

**-nocase**
: Großbuchstaben in *string* werden beim Matching wie Kleinbuchstaben behandelt.

**-all**
: So oft wie möglich matchen; Rückgabe der Gesamtzahl der Treffer. Mit Match-Variablen: nur Informationen zum letzten Treffer.

**-inline**
: Gibt als Liste die Daten zurück, die sonst in Match-Variablen landen würden. Mit **-inline** keine Match-Variablen. Mit **-all** wird die Liste pro Iteration angehängt (flache Liste). Pro Treffer: Gesamttreffer plus je ein Element pro Unterausdruck. Beispiele:

    ```
    regexp -inline -- {\w(\w)} " inlined "
          → in n
    regexp -all -inline -- {\w(\w)} " inlined "
          → in n li i ne e
    ```

**-start** *index*
: Zeichenindex-Offset in *string*, ab dem gematcht wird (wie **string index**). Mit diesem Schalter trifft „^“ nicht den Zeilenanfang; \A trifft weiter den Stringanfang bei *index*. Mit **-indices** Indizes relativ zum absoluten Anfang von *string*. *index* wird auf die Stringgrenzen beschränkt.

**-|-**
: Ende der Schalter; das folgende Argument gilt als *exp*, auch wenn es mit **-** beginnt.


Gibt es mehr *subMatchVar* als geklammerte Unterausdrücke in *exp*, oder trifft ein Unterausdruck nicht (weil er in einem nicht gematchten Teil lag), wird die *subMatchVar* auf „**-1 -1**“ gesetzt bei **-indices**, sonst auf leeren String.

# BEISPIELE

Erstes Vorkommen eines Worts, das mit **foo** beginnt, aber kein **foobar** ist; Buchstaben danach bis Wortende in eine Variable:

```
regexp {\mfoo(?!bar\M)(\w*)} $string \-> restOfWord
```

Die gesamte Trefferzeichenkette liegt in „**->**“ — ein Name, der gut aussieht, obwohl der Inhalt uninteressant ist.

Index des Worts **badger** (beliebige Schreibweise) in *location*:

```
regexp \-indices {(?i)\mbadger\M} $string location
```

Als *basic* regular expression (statt Standard *advanced*):

```
regexp \-indices {(?ib)\<badger\>} $string location
```

Anzahl der Oktalziffern in einer Zeichenkette:

```
regexp \-all {[0\-7]} $string
```

Alle Wörter (Nicht-Leerzeichen-Sequenzen) als Liste — mächtigere Variante von **split**:

```
regexp \-all \-inline {\S+} $string
```
