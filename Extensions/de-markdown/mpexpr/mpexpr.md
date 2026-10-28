Inhaltsverzeichnis

## NAME 

mpexpr - Einen Ausdruck mit Mehrfachgenauigkeit auswerten

## ÜBERSICHT 

 **package require Mpexpr**    
 **mpexpr arg** ?*arg arg ...* ?   
 **mpformat formatString** ?*arg arg ...* ?   
 **global mp_precision**  

## BESCHREIBUNG 

 Mpexpr beruht auf dem Tcl-Befehl *expr* und hat mit *expr* viel gemeinsam. Alle Rechnungen laufen über ein Paket für Arithmetik mit beliebiger Genauigkeit. 

 Mpexpr hängt die Argumente *arg* aneinander, mit Leerzeichen dazwischen, wertet das Ergebnis als Tcl-Ausdruck aus und gibt den Wert zurück. Die Operatoren in Tcl-Ausdrücken sind eine Teilmenge der Operatoren in C-Ausdrücken, mit derselben Bedeutung und derselben Vorrangstufe. Ausdrücke liefern fast immer Zahlen, ganze Zahlen oder Gleitkommawerte. Zum Beispiel der Ausdruck 

 **mpexpr 8.2 + 6**  

 ergibt 14.2. Tcl-Ausdrücke unterscheiden sich von C-Ausdrücken darin, wie Operanden angegeben werden. Tcl-Ausdrücke erlauben außerdem Operanden, die keine Zahlen sind, und Vergleiche von Zeichenketten. 

## OPERANDEN 

 Ein Tcl-Ausdruck besteht aus Operanden, Operatoren und Klammern. Zwischen Operanden, Operatoren und Klammern darf Leerraum stehen. Der Ausdrucksprozessor ignoriert ihn. Wo es geht, werden Operanden als ganze Zahlen gelesen. Ganze Zahlen stehen dezimal, das ist der Normalfall, oktal, wenn das erste Zeichen des Operanden **0** ist, oder hexadezimal, wenn die ersten beiden Zeichen **0x** sind. Passt keines dieser Formate, wird der Operand als Gleitkommazahl gelesen, sofern das möglich ist. Gleitkommazahlen dürfen in jeder Form stehen, die ein ANSI-C-Compiler annimmt. Die Endungen \`\`f'', \`\`F'', \`\`l'' und \`\`L'' sind in den meisten Installationen nicht zulässig. Gültige Gleitkommazahlen sind zum Beispiel 2.1, 3., 6e4 und 7.91e+16. Ist keine numerische Lesart möglich, bleibt der Operand eine Zeichenkette, und nur wenige Operatoren gelten für ihn. 

Operanden lassen sich auf eine der folgenden Arten angeben:

1. Als Zahl, ganze Zahl oder Gleitkommazahl. 
2. Als Tcl-Variable in der üblichen Schreibweise **\$**. Der Wert der Variablen ist der Operand. 
3. Als Zeichenkette in doppelten Anführungszeichen. Der Ausdrucksprozessor führt zwischen den Anführungszeichen Backslash-, Variablen- und Befehlsersetzung aus und nimmt den entstandenen Wert als Operanden. 
4. Als Zeichenkette in geschweiften Klammern. Die Zeichen zwischen der öffnenden Klammer und der passenden schließenden Klammer sind der Operand, ohne Ersetzung. 
5. Als Tcl-Befehl in eckigen Klammern. Der Befehl wird ausgeführt, sein Ergebnis ist der Operand. 
6. Als mathematische Funktion, deren Argumente eine der genannten Operandenformen haben, zum Beispiel \`\`**sin(\$x)** ''. Die definierten Funktionen stehen unten. 

 Wo oben Ersetzungen vorkommen, etwa in Zeichenketten in Anführungszeichen, führt sie der Ausdrucksprozessor aus. Eine weitere Ersetzung kann der Befehlsparser schon ausgeführt haben, bevor der Ausdrucksprozessor aufgerufen wird. Wie unten beschrieben, gehören Ausdrücke in der Regel in geschweifte Klammern, damit der Befehlsparser den Inhalt nicht ersetzt. 

 Für einfache Beispiele habe die Variable **a** den Wert 3 und die Variable **b** den Wert 6. Der Befehl links in den folgenden Zeilen liefert den Wert der nächsten Zeile: 

**mpexpr 3.1 + \$a**  
: 6.1 

**mpexpr 2 + "\$a.\$b"**  
: 5.6 

**mpexpr 4\*\[llength "6 2"\]**  
: 8 

**mpexpr {{word one} < "word \$a"}**  
: 0   





## OPERATOREN 

Die gültigen Operatoren stehen unten, nach abnehmender Vorrangstufe:

**- + ~ !**  
: Unäres Minus, unäres Plus, bitweises NOT, logisches NOT. Keiner dieser Operatoren gilt für Zeichenketten, und bitweises NOT gilt nur für ganze Zahlen. 

**\* / %**  
: Multiplizieren, dividieren, Rest. Keiner dieser Operatoren gilt für Zeichenketten, und der Rest gilt nur für ganze Zahlen. Der Rest hat immer das Vorzeichen des Divisors und einen Absolutbetrag, der kleiner ist als der Divisor. 

**+ -**  
: Addieren und subtrahieren. Gilt für alle numerischen Operanden. 

**<< >>**  
: Schieben nach links und nach rechts. Gilt nur für ganzzahlige Operanden. Ganze Zahlen in mpexpr sind nicht auf ein Maschinenwort beschränkt und stehen nicht im Zweierkomplement. Beim Schieben gibt es daher kein Vorzeichenbit. 

**< > <= >=**  
: Boolesches Kleiner, Größer, Kleiner-oder-gleich und Größer-oder-gleich. Jeder Operator liefert 1, wenn die Bedingung wahr ist, sonst 0. Die Operatoren gelten für Zeichenketten und für Zahlen. Bei Zeichenketten wird als Zeichenkette verglichen. 

**== !=**  
: Boolesches Gleich und Ungleich. Jeder Operator liefert null oder eins. Gilt für alle Arten von Operanden. 

**&**  
: Bitweises UND. Gilt nur für ganzzahlige Operanden. 

**^**  
: Bitweises exklusives ODER. Gilt nur für ganzzahlige Operanden. 

**|**  
: Bitweises ODER. Gilt nur für ganzzahlige Operanden. 

**&&**  
: Logisches UND. Liefert 1, wenn beide Operanden ungleich null sind, sonst 0. Gilt nur für numerische Operanden, ganze Zahlen oder Gleitkommazahlen. 

**||**  
: Logisches ODER. Liefert 0, wenn beide Operanden null sind, sonst 1. Gilt nur für numerische Operanden, ganze Zahlen oder Gleitkommazahlen. 

*x?y:z*  
: Wenn-dann-sonst, wie in C. Wertet *x* zu ungleich null aus, ist das Ergebnis der Wert von *y*. Sonst ist das Ergebnis der Wert von *z*. Der Operand *x* muss eine Zahl sein. 


 Das C-Handbuch beschreibt die Ergebnisse der Operatoren genauer. Alle zweistelligen Operatoren derselben Vorrangstufe binden von links nach rechts. Zum Beispiel der Befehl 

 **mpexpr 4\*2 < 7**  

 liefert 0. 

 Die Operatoren **&&**, **||** und **?:** haben wie in C eine \`\`verzögerte Auswertung''. Operanden werden nicht ausgewertet, wenn sie für das Ergebnis nicht nötig sind. Zum Beispiel im Befehl 

 **mpexpr {\$v ? \[a\] : \[b\]}**  

 wird nur eines von **\[a\]** oder **\[b\]** wirklich ausgewertet, je nach dem Wert von **\$v**. Das gilt nur, wenn der ganze Ausdruck in geschweiften Klammern steht. Sonst wertet der Tcl-Parser **\[a\]** und **\[b\]** aus, bevor er den Befehl **expr** aufruft. 

## MATHEMATISCHE FUNKTIONEN 

 Mpexpr kennt in Ausdrücken die folgenden mathematischen Funktionen. *x* und *y* sind ganze Zahlen oder Gleitkommawerte. *i*, *j* und *c* sind ganze Zahlen. 

Mathematische Funktionen, die mit *expr* übereinstimmen:

**acos(x)**  
: Arkuskosinus von *x*. 

**asin(x)**  
: Arkussinus von *x*. 

**atan(x)**  
: Arkustangens von *x*. 

**atan2(x,y)**  
: Arkustangens von *x* / *y*. 

**ceil(x)**  
: Kleinste ganze Zahl, die größer oder gleich *x* ist. 

**cos(x)**  
: Kosinus von *x*. 

**cosh(x)**  
: Hyperbelkosinus von *x*. 

**exp(x)**  
: Exponentialfunktion e \*\* *x*. 

**floor(x)**  
: Größte ganze Zahl, die kleiner oder gleich *x* ist. 

**fmod(x,y)**  
: Rest von *x* geteilt durch *y*. 

**hypot(x,y)**  
: Euklidischer Abstand sqrt( *x* \* *x* + *y* \* *y* ). 

**log(x)**  
: Natürlicher Logarithmus von *x*. 

**log10(x)**  
: Zehnerlogarithmus von *x*. 

**pow(x,y)**  
: *x* hoch *y*. 

**sin(x)**  
: Sinus von *x*. 

**sinh(x)**  
: Hyperbelsinus von *x*. 

**sqrt(x)**  
: Quadratwurzel von *x*. 

**tan(x)**  
: Tangens von *x*. 

**tanh(x)**  
: Hyperbeltangens von *x*. 

**abs(x)**  
: Gibt den Absolutbetrag von *x* zurück. *x* darf eine ganze Zahl oder eine Gleitkommazahl sein. Das Ergebnis hat dieselbe Form. 

**double(x)**  
: Ist *x* eine Gleitkommazahl, kommt *x* zurück. Sonst wird *x* in eine Gleitkommazahl umgewandelt und dieser Wert zurückgegeben. 

**int(x)**  
: Ist *x* eine ganze Zahl, kommt *x* zurück. Sonst wird *x* durch Abschneiden in eine ganze Zahl umgewandelt und dieser Wert zurückgegeben. 

**round(x)**  
: Ist *x* eine ganze Zahl, kommt *x* zurück. Sonst wird *x* durch Runden in eine ganze Zahl umgewandelt und dieser Wert zurückgegeben. 


Weitere Funktionen von *mpexpr*:

**root(x,y)**  
: Die *y*-te Wurzel von *x*. 

**frem(x,y)**  
: Entfernt jedes Vorkommen des Faktors *y* aus der Zahl *x*. 

**minv(x,y)**  
: Inverses von *x* modulo *y*. 

**gcd(x,y)**  
: Größter gemeinsamer Teiler von *x* und *y*. 

**lcm(x,y)**  
: Kleinstes gemeinsames Vielfaches von *x* und *y*. 

**max(x,y)**  
: Maximum von *x* und *y*. 

**min(x,y)**  
: Minimum von *x* und *y*. 

**pi()**  
: Wert von pi. 

**fib(i)**  
: Fibonacci-Zahl der ganzen Zahl *i*. 

**fact(i)**  
: Fakultät der ganzen Zahl *i*. 

**pfact(i)**  
: Produkt der Primzahlen bis zur ganzen Zahl *i*. 

**lfactor(i,c)**  
: Kleinster Primfaktor der ganzen Zahl *i*, mit *c* Versuchen. 

**iroot(i,j)**  
: Ganzzahlige *j*-te Wurzel der ganzen Zahl *i*. 

**gcdrem(i,j)**  
: Relativ prim zum größten gemeinsamen Teiler von *i*, geteilt durch *j*. 

**perm(i,j)**  
: Permutationen von *i* zu je *j*: *i* ! / ( *i* - *j* ) !. 

**comb(i,j)**  
: Kombinationen von *i* zu je *j*: *i* ! / ( *j* ! \* ( *i* - *j* ) ! ). 

**prime(i,c)**  
: Gibt 0 zurück, wenn *i* nicht prim ist, und 1, wenn *i* wahrscheinlich prim ist. Der Primzahltest läuft *c*-mal. Die Chance, dass eine Nicht-Primzahl den Test besteht, ist kleiner als (1/4)^count. Bei einem Zähler von 100 besteht eine Nicht-Primzahl den Test nur in 1 von 10^60 Fällen. 

**relprime(i,j)**  
: Gibt 1 zurück, wenn *i* und *j* teilerfremd sind, sonst 0.




## TYPEN, ÜBERLAUF UND GENAUIGKEIT 

 Gerechnet wird mit Festkomma- und Gleitkommawerten beliebiger Größe. Native Maschinenwerte (*int, long, IEEE 754 Gleitkomma und so weiter*) und Maschinenbefehle werden nicht verwendet. Die Umwandlung zwischen den internen Darstellungen für ganze Zahlen, Gleitkomma und Zeichenketten geschieht bei Bedarf von selbst. In arithmetischen Rechnungen bleiben die Werte ganzzahlig, bis eine Gleitkommazahl vorkommt. Danach wird mit Gleitkomma gerechnet. Zum Beispiel 

 **mpexpr 5 / 4**  

 liefert 1, während 

 **mpexpr 5 / 4.0**    
 **mpexpr 5 / ( \[string length "abcd"\] + 0.0 )**  

 liefern beide 1.25. Gleitkommawerte kommen immer mit einem \`\`.'' oder einem \`\`e'' zurück, damit sie nicht wie ganze Zahlen aussehen. Zum Beispiel 

 **mpexpr 20.0/5.0**  

 liefert \`\`4.0'' und nicht \`\`4''. 

 Die globale Variable **mp_precision** legt fest, wie viele signifikante Stellen bei der Auswertung bleiben. Ist **mp_precision** nicht gesetzt, werden 17 Stellen verwendet. Der größte Wert von **mp_precision** ist 10000. Größere Werte von **mp_precision** brauchen zunehmend längere Laufzeiten. Ein unzulässiger Wert von **mp_precision** erzeugt einen Fehler. 

## ZEICHENKETTENOPERATIONEN 

 Zeichenketten dürfen Operanden der Vergleichsoperatoren sein. Der Auswerter vergleicht trotzdem ganzzahlig oder als Gleitkomma, wo er kann. Ist ein Operand eines Vergleichs eine Zeichenkette und der andere eine Zahl, wird die Zahl mit dem *sprintf*-Format **%d** (ganze Zahlen) bzw. **%g** (Gleitkommawerte) zurück in eine Zeichenkette gewandelt. Zum Beispiel die Befehle 

 **mpexpr {"0x03" > "2"}**  **mpexpr {"0y" < "0x12"}**  

 liefern beide 1. Der erste Vergleich ist ein Vergleich ganzer Zahlen. Der zweite ist ein Zeichenkettenvergleich, nachdem der zweite Operand in die Zeichenkette \`\`18'' gewandelt wurde. Tcl behandelt Werte, wo es geht, als Zahlen. Operatoren wie **==** sind deshalb ungeeignet, wenn wirklich Zeichenketten verglichen werden sollen und die Operanden beliebige Werte haben können. Dann ist der Befehl **string compare** die bessere Wahl. 

 **mpformat** formatiert eine Zeichenkette im Stil des Tcl-Befehls *format*. Mpformat liest numerische Argumente als Zahlen beliebiger Genauigkeit. Mpformat kennt nur einen Teil der %-Angaben. Angegeben werden kann: 

 **% \[-\] \[width\[.precision\]\] formatChar**  

**-**  
: Legt linksbündig fest. Voreingestellt ist rechtsbündig. 

**width.precision**  
: Legt die optionale Breite und Genauigkeit fest. Die voreingestellte Genauigkeit ist 8. Breite und Genauigkeit dürfen als **\*** stehen. Dann liefert das nächste Argument den Wert für Breite oder Genauigkeit. 


**Formatzeichen und Ergebnis** 

**d**  
: Formatiert das nächste Argument als ganze Zahl und schneidet nach dem Dezimalpunkt ab. 

**f**  
: Formatiert das nächste Argument als dezimale Gleitkommazahl. 

**e**  
: Formatiert das nächste Argument in wissenschaftlicher Schreibweise. 

**r** , **R**  
: Formatiert das nächste Argument als rationalen Bruch x / y. 

**N**  
: Formatiert das nächste Argument nur als Zähler des rationalen Bruchs x / y. 

**D**  
: Formatiert das nächste Argument nur als Nenner des rationalen Bruchs x / y. 

**o**  
: Formatiert das nächste Argument oktal, mit führender '0'. Ein Gleitkommaargument wird als oktaler rationaler Bruch x / y formatiert. 

**x**  
: Formatiert das nächste Argument hexadezimal, mit führendem '0x'. Ein Gleitkommaargument wird als hexadezimaler rationaler Bruch x / y formatiert. 

**b**  
: Formatiert das nächste Argument binär, mit führendem '0b'. Ein Gleitkommaargument wird als binärer rationaler Bruch x / y formatiert. 

**s**  
: Formatiert das nächste Argument als Zeichenkette. 

**c**  
: Formatiert das nächste Argument als einzelnes Zeichen. 

**%**  
: Formatiert ein einzelnes wörtliches %. 


**Weitere Zeichen in der Formatzeichenkette** 

**\\n**  
: Formatiert einen ASCII-Zeilenumbruch. 

**\\r**  
: Formatiert einen ASCII-Wagenrücklauf. 

**\\t**  
: Formatiert einen ASCII-Tabulator. 

**\\f**  
: Formatiert einen ASCII-Seitenvorschub. 

**\\v**  
: Formatiert einen vertikalen ASCII-Tabulator. 

**\\b**  
: Formatiert ein ASCII-Rückschrittzeichen.




## ANMERKUNGEN 

 Mpexpr beruht auf 'tclExpr.c' aus Tcl 7.6 und auf dem Programm 'Calc' von David Bell. Diese Handbuchseite und die Testsuite von mpexpr sind zum großen Teil ebenfalls aus Tcl 7.6 übernommen. 

 Weitere Angaben stehen in den Dateien README und INSTALL. 

 Tcl 7.6 steht unter Copyright (c) 1987-1994 The Regents of the University of California und Copyright (c) 1994 Sun Microsystems, Inc. 

 Calc steht unter Copyright (c) 1994 David I. Bell. 

## AUTOR 

Tom Poindexter, tpoindex@nyx.net, Talus Technologies, Inc., Highlands Ranch, CO. [http://www.nyx.net/~tpoindex](http://www.nyx.net/~tpoindex)

 Version 1.0 erschien im November 1998. 

 Copyright 1998 Tom Poindexter. Weitere Copyright- und Lizenzbedingungen stehen in der Datei 'LICENSE.TERMS'. 



---

 **Inhaltsverzeichnis**

- [NAME](#name)
- [ÜBERSICHT](#bersicht)
- [BESCHREIBUNG](#beschreibung)
- [OPERANDEN](#operanden)
- [OPERATOREN](#operatoren)
- [MATHEMATISCHE FUNKTIONEN](#mathematische-funktionen)
- [TYPEN, ÜBERLAUF UND GENAUIGKEIT](#typen-berlauf-und-genauigkeit)
- [ZEICHENKETTENOPERATIONEN](#zeichenkettenoperationen)
- [ANMERKUNGEN](#anmerkungen)
- [AUTOR](#autor)
