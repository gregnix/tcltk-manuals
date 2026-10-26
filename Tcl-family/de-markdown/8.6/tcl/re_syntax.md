---
CommandName: re_syntax
title: re_syntax
ManualSection: n
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - RegExp(3)
 - regexp(n)
 - regsub(n)
 - lsearch(n)
 - switch(n)
 - text(n)
Keywords:
 - match
 - regular expression
 - string
Copyright:
 - Copyright (c) 1998 Sun Microsystems, Inc.
 - Copyright (c) 1999 Scriptics Corporation
---

# Name

re\_syntax - Syntax von Tcl-Regulären Ausdrücken

# Beschreibung

Ein *regulärer Ausdruck* beschreibt Zeichenketten. Er ist ein Muster, das bestimmte Zeichenketten trifft und andere nicht.

# Verschiedene Varianten von REs

Reguläre Ausdrücke („RE“s), wie von POSIX definiert, gibt es in zwei Varianten: *erweiterte* REs („ERE“s) und *einfache* REs („BRE“s). EREs entsprechen grob denen des traditionellen *egrep*, BREs grob denen des traditionellen *ed*. Diese Implementierung fügt eine dritte Variante hinzu: *fortgeschrittene* REs („ARE“s), im Wesentlichen EREs mit einigen wesentlichen Erweiterungen.

Diese Manualseite beschreibt vor allem AREs. BREs existieren meist nur zur Abwärtskompatibilität in einigen alten Programmen; sie werden am Ende besprochen. POSIX-EREs sind fast eine exakte Teilmenge von AREs. Merkmale von AREs, die in EREs fehlen, werden gekennzeichnet.

# Syntax regulärer Ausdrücke

Tcl-Reguläre Ausdrücke werden mit dem Paket von Henry Spencer implementiert, basierend auf der Spezifikation 1003.2 und einigen (nicht allen) Perl5-Erweiterungen (danke, Henry!). Vieles der folgenden Beschreibung regulärer Ausdrücke ist wörtlich aus seinem Manual-Eintrag übernommen.

Ein ARE besteht aus einem oder mehreren *Zweigen*, getrennt durch „**|**“, und trifft alles, was irgendeinen der Zweige trifft.

Ein Zweig besteht aus null oder mehr *Einschränkungen* oder *quantifizierten Atomen*, aneinandergereiht. Er trifft eine Übereinstimmung für das erste, gefolgt von einer für das zweite usw.; ein leerer Zweig trifft die leere Zeichenkette.

## Quantifizierer

Ein quantifiziertes Atom ist ein *Atom*, optional gefolgt von einem einzelnen *Quantifizierer*. Ohne Quantifizierer trifft es genau eine Übereinstimmung für das Atom. Die Quantifizierer und was ein so quantifiziertes Atom trifft, sind:

**\***
: eine Folge von 0 oder mehr Übereinstimmungen des Atoms

**+**
: eine Folge von 1 oder mehr Übereinstimmungen des Atoms

**?**
: eine Folge von 0 oder 1 Übereinstimmungen des Atoms

**{***m***}**
: eine Folge von genau *m* Übereinstimmungen des Atoms

**{***m***,}**
: eine Folge von *m* oder mehr Übereinstimmungen des Atoms

**{***m***,***n***}**
: eine Folge von *m* bis *n* (einschließlich) Übereinstimmungen des Atoms; *m* darf *n* nicht überschreiten

**\*?  +?  ??  {***m***}?  {***m***,}?  {***m***,***n***}?**
: *nicht-gierige* Quantifizierer, die dieselben Möglichkeiten treffen, aber die kleinste statt der größten Anzahl von Übereinstimmungen bevorzugen (siehe [Abgleich])


Die Formen mit **{** und **}** heißen *Grenzen*. Die Zahlen *m* und *n* sind vorzeichenlose Dezimalzahlen mit zulässigen Werten von 0 bis 255 einschließlich.

## Atome

Ein Atom ist eines von:

**(***re***)**
: trifft eine Übereinstimmung für *re* (*re* ist ein beliebiger regulärer Ausdruck), wobei die Übereinstimmung für eine mögliche Rückmeldung vermerkt wird

**(?:***re***)**
: wie zuvor, aber ohne Rückmeldung (eine „nicht erfassende“ Klammergruppe)

**()**
: trifft eine leere Zeichenkette, vermerkt für eine mögliche Rückmeldung

**(?:)**
: trifft eine leere Zeichenkette, ohne Rückmeldung

**\[***chars***\]**
: ein *Klammerausdruck*, der genau eines der *chars* trifft (siehe [Klammerausdrücke] für Details)

**.**
: trifft ein beliebiges einzelnes Zeichen

**\\***k*
: trifft das nicht-alphanumerische Zeichen *k* als gewöhnliches Zeichen, z. B. trifft **\\\\** ein Backslash-Zeichen

**\\***c*
: wobei *c* alphanumerisch ist (ggf. von weiteren Zeichen gefolgt), ein *Escape* (nur AREs), siehe [Escapes] unten

**{**
: wenn von einem Zeichen gefolgt, das keine Ziffer ist, trifft es das linke geschweifte Klammerzeichen „**{**“; wenn von einer Ziffer gefolgt, ist es der Beginn einer *Grenze* (siehe oben)

*x*
: wobei *x* ein einzelnes Zeichen ohne weitere Bedeutung ist, trifft dieses Zeichen.


## Einschränkungen

Eine *Einschränkung* trifft eine leere Zeichenkette, wenn bestimmte Bedingungen erfüllt sind. Auf eine Einschränkung darf kein Quantifizierer folgen. Die einfachen Einschränkungen sind wie folgt; weitere Einschränkungen werden später unter [Escapes] beschrieben.

**^**
: trifft am Anfang der Zeichenkette oder einer Zeile (je nachdem, ob der Abgleich zeilenumbruch-sensitiv ist oder nicht, wie unter [Abgleich] unten beschrieben).

**$**
: trifft am Ende der Zeichenkette oder einer Zeile (je nachdem, ob der Abgleich zeilenumbruch-sensitiv ist oder nicht, wie unter [Abgleich] unten beschrieben).

    Der Unterschied zwischen String- und Zeilen-Abgleichmodus ist bedeutungslos, wenn die Zeichenkette kein Zeilenumbruchzeichen enthält. Die Einschränkungs-Escapes **\\A** und **\\Z** haben einen ähnlichen Zweck, sind aber stets Einschränkungen für die gesamte Zeichenkette.

    Die Standard-Zeilenumbruch-Sensitivität hängt vom Befehl ab, der den regulären Ausdruck verwendet, und kann wie unter [Metasyntax] unten überschrieben werden.

**(?=***re***)**
: *positives Lookahead* (nur AREs), trifft an jeder Stelle, an der eine Teilzeichenkette beginnt, die *re* trifft

**(?!***re***)**
: *negatives Lookahead* (nur AREs), trifft an jeder Stelle, an der keine Teilzeichenkette beginnt, die *re* trifft


Die Lookahead-Einschränkungen dürfen keine Rückverweise enthalten (siehe später), und alle Klammern darin gelten als nicht erfassend.

Ein RE darf nicht mit „**\\**“ enden.

# Klammerausdrücke

Ein *Klammerausdruck* ist eine Liste von Zeichen in „**\[\]**“. Er trifft normalerweise ein beliebiges einzelnes Zeichen aus der Liste (siehe unten). Beginnt die Liste mit „**^**“, trifft er ein beliebiges einzelnes Zeichen (siehe unten) *nicht* aus dem Rest der Liste.

Stehen zwei Zeichen in der Liste durch „**-**“ getrennt, ist das eine Abkürzung für den vollen *Bereich* der Zeichen zwischen diesen beiden (einschließlich) in der Sortierfolge, z. B. trifft „**\[0-9\]**“ in Unicode jede übliche Dezimalziffer. Zwei Bereiche dürfen keinen gemeinsamen Endpunkt haben, z. B. ist „**a-c-e**“ unzulässig. Bereiche in Tcl verwenden stets die Unicode-Sortierfolge; andere Programme können andere Sortierfolgen verwenden — das kann zu Inkompatibilitäten zwischen Programmen führen.

Um ein wörtliches **\]** oder **-** in die Liste aufzunehmen, umschließt man es am einfachsten mit **\[.** und **.\]**, um ein Sortierelement daraus zu machen (siehe unten). Alternativ macht man es zum ersten Zeichen (nach einem möglichen „**^**“) oder (nur AREs) setzt „**\\**“ davor. Für „**-**“ alternativ: letztes Zeichen oder zweiter Endpunkt eines Bereichs. Soll „**-**“ wörtlich erster Endpunkt eines Bereichs sein, macht man es ein Sortierelement oder (nur AREs) setzt „**\\**“ davor. Mit Ausnahme dieser Fälle, einiger Kombinationen mit **\[** (siehe nächste Absätze) und Escapes verlieren alle anderen Sonderzeichen in einem Klammerausdruck ihre Sonderbedeutung.

## Zeichenklassen

In einem Klammerausdruck steht der Name einer *Zeichenklasse* in **\[:** und **:\]** für die Liste aller Zeichen (nicht aller Sortierelemente!), die zu dieser Klasse gehören. Standard-Zeichenklassen sind:

**alpha**
: ein Buchstabe.

**upper**
: ein Großbuchstabe.

**lower**
: ein Kleinbuchstabe.

**digit**
: eine Dezimalziffer.

**xdigit**
: eine hexadezimale Ziffer.

**alnum**
: alphanumerisch (Buchstabe oder Ziffer).

**print**
: „druckbar“ (wie graph, zusätzlich Leerzeichen).

**blank**
: Leerzeichen oder Tabulator.

**space**
: ein Zeichen, das in angezeigtem Text Weißraum erzeugt.

**punct**
: ein Interpunktionszeichen.

**graph**
: ein Zeichen mit sichtbarer Darstellung (umfasst **alnum** und **punct**).

**cntrl**
: ein Steuerzeichen.


Ein Gebietsschema kann weitere bereitstellen. Eine Zeichenklasse darf nicht Endpunkt eines Bereichs sein.

(*Hinweis:* die aktuelle Tcl-Implementierung hat nur ein Gebietsschema, das Unicode-Gebietsschema, das genau die obigen Klassen unterstützt.)

## Klammerausdrücke als Einschränkungen

Es gibt zwei Sonderfälle von Klammerausdrücken: die Klammerausdrücke „**\[\[:<:\]\]**“ und „**\[\[:>:\]\]**“ sind Einschränkungen und treffen leere Zeichenketten am Anfang bzw. Ende eines Wortes. Ein Wort ist eine Folge von Wortzeichen, der weder vorher noch nachher Wortzeichen folgen. Ein Wortzeichen ist ein *alnum*-Zeichen oder ein Unterstrich („**\_**“). Diese speziellen Klammerausdrücke sind veraltet; ARE-Nutzer sollten stattdessen Einschränkungs-Escapes verwenden (siehe unten).

## Sortierelemente

In einem Klammerausdruck steht ein Sortierelement (ein Zeichen, eine mehrzeichenige Folge, die wie ein einzelnes Zeichen sortiert, oder ein Sortierfolgen-Name für eines von beiden) in **\[.** und **.\]** für die Zeichenfolge dieses Sortierelements. Die Folge ist ein einzelnes Element der Liste des Klammerausdrucks. Ein Klammerausdruck in einem Gebietsschema mit mehrzeichenigen Sortierelementen kann daher mehr als ein Zeichen treffen. So kann (heimtückisch) ein Klammerausdruck, der mit **^** beginnt, mehrzeichenige Sortierelemente treffen, auch wenn keines in der Liste des Klammerausdrucks vorkommt!

(*Hinweis:* Tcl hat keine mehrzeichenigen Sortierelemente. Diese Information dient nur zur Veranschaulichung.)

Nehmen wir an, die Sortierfolge enthält ein mehrzeicheniges Sortierelement **ch**. Dann trifft der RE „**\[\[.ch.\]\]\*c**“ (null oder mehr „**ch**“, gefolgt von „**c**“) die ersten fünf Zeichen von „**chchcc**“. Außerdem trifft der RE „**\[^c\]b**“ ganz „**chb**“ (weil „**\[^c\]**“ das mehrzeichenige „**ch**“ trifft).

## Äquivalenzklassen

In einem Klammerausdruck ist ein Sortierelement in **\[=** und **=\]** eine Äquivalenzklasse und steht für die Zeichenfolgen aller Sortierelemente, die diesem äquivalent sind, einschließlich es selbst. (Gibt es keine anderen äquivalenten Sortierelemente, wird behandelt, als ob die umschließenden Begrenzer „**\[.**“ und „**.\]**“ wären.) Sind z. B. **o** und **ô** Mitglieder einer Äquivalenzklasse, sind „**\[\[=o=\]\]**“, „**\[\[=ô=\]\]**“ und „**\[oô\]**“ synonym. Eine Äquivalenzklasse darf nicht Endpunkt eines Bereichs sein.

(*Hinweis:* Tcl implementiert nur das Unicode-Gebietsschema. Es definiert keine Äquivalenzklassen. Die Beispiele oben dienen nur zur Veranschaulichung.)

# Escapes

Escapes (nur AREs), die mit **\\** gefolgt von einem alphanumerischen Zeichen beginnen, gibt es in mehreren Arten: Zeicheneingabe, Klassenkurzformen, Einschränkungs-Escapes und Rückverweise. **\\** gefolgt von einem alphanumerischen Zeichen, das kein gültiges Escape bildet, ist in AREs unzulässig. In EREs gibt es keine Escapes: außerhalb eines Klammerausdrucks steht **\\** gefolgt von einem alphanumerischen Zeichen nur für dieses Zeichen als gewöhnliches Zeichen; innerhalb eines Klammerausdrucks ist **\\** ein gewöhnliches Zeichen. (Letzteres ist die einzige echte Inkompatibilität zwischen EREs und AREs.)

## Zeicheneingabe-Escapes

Zeicheneingabe-Escapes (nur AREs) erleichtern die Angabe nicht druckbarer und sonst unhandlicher Zeichen in REs:

**\\a**
: Alarm (Glocke), wie in C

**\\b**
: Rücktaste, wie in C

**\\B**
: Synonym für **\\**, um doppeltes Backslash-Escaping in Anwendungen mit mehreren Ebenen von Backslash-Verarbeitung zu verringern

**\\c***X*
: (wobei *X* ein beliebiges Zeichen ist) das Zeichen, dessen niederwertige 5 Bits mit denen von *X* übereinstimmen und dessen übrige Bits alle null sind

**\\e**
: das Zeichen, dessen Sortierfolgen-Name „**ESC**“ ist, oder andernfalls das Zeichen mit Oktalwert 033

**\\f**
: Seitenvorschub, wie in C

**\\n**
: Zeilenumbruch, wie in C

**\\r**
: Wagenrücklauf, wie in C

**\\t**
: horizontaler Tabulator, wie in C

**\\u***wxyz*
: (wobei *wxyz* ein bis vier hexadezimale Ziffern sind) das Unicode-Zeichen **U+**_wxyz_ in der lokalen Byte-Reihenfolge

**\\U***stuvwxyz*
: (wobei *stuvwxyz* ein bis acht hexadezimale Ziffern sind) reserviert für eine Unicode-Erweiterung bis 21 Bit. Die Ziffern werden gelesen, bis das erste nicht-hexadezimale Zeichen erreicht wird, maximal acht hexadezimale Ziffern erreicht sind oder ein Überlauf beim Maximalwert **U+**_10ffff_ auftreten würde.

**\\v**
: vertikaler Tabulator, wie in C, sind alle verfügbar.

**\\x***hh*
: (wobei *hh* ein oder zwei hexadezimale Ziffern sind) das Zeichen mit hexadezimalem Wert **0x***hh*.

**\\0**
: das Zeichen mit Wert **0**

**\\***xyz*
: (wobei *xyz* genau drei Oktalziffern sind und kein *Rückverweis* (siehe unten)) das Zeichen mit Oktalwert **0***xyz*. Die erste Ziffer muss im Bereich 0–3 liegen, sonst gilt die zweistellige Form.

**\\***xy*
: (wobei *xy* genau zwei Oktalziffern sind und kein *Rückverweis* (siehe unten)) das Zeichen mit Oktalwert **0***xy*


Hexadezimale Ziffern sind „**0**–**9**“, „**a**–**f**“ und „**A**–**F**“. Oktalziffern sind „**0**–**7**“.

Die Zeicheneingabe-Escapes gelten stets als gewöhnliche Zeichen. Z. B. ist **\\135** in Unicode **\]**, aber **\\135** beendet keinen Klammerausdruck. Beachten Sie jedoch, dass manche Anwendungen (z. B. C-Compiler und der Tcl-Interpreter, wenn der reguläre Ausdruck nicht in geschweifte Klammern gesetzt ist) solche Folgen selbst verarbeiten, bevor das Regex-Paket sie sieht — das kann Verdoppelung (Vervierfachung usw.) von „**\\**“ erfordern.

## Klassenkurzformen

Klassenkurzformen (nur AREs) sind Abkürzungen für häufig verwendete Zeichenklassen:

**\\d**
: **\[\[:digit:\]\]**

**\\s**
: **\[\[:space:\]\]**

**\\w**
: **\[\[:alnum:\]\_\\u203F\\u2040\\u2054\\uFE33\\uFE34\\uFE4D\\uFE4E\\uFE4F\\uFF3F\]** (einschließlich Interpunktions-Verbindungszeichen)

**\\D**
: **\[^\[:digit:\]\]**

**\\S**
: **\[^\[:space:\]\]**

**\\W**
: **\[^\[:alnum:\]\_\\u203F\\u2040\\u2054\\uFE33\\uFE34\\uFE4D\\uFE4E\\uFE4F\\uFF3F\]** (einschließlich Interpunktions-Verbindungszeichen)


In Klammerausdrücken verlieren „**\\d**“, „**\\s**“ und „**\\w**“ ihre äußeren Klammern, und „**\\D**“, „**\\S**“ und „**\\W**“ sind unzulässig. (Z. B. ist „**\[a-c\\d\]**“ äquivalent zu „**\[a-c\[:digit:\]\]**“. „**\[a-c\\D\]**“, äquivalent zu „**\[a-c^\[:digit:\]\]**“, ist unzulässig.)

## Einschränkungs-Escapes

Ein Einschränkungs-Escape (nur AREs) ist eine Einschränkung, die die leere Zeichenkette trifft, wenn bestimmte Bedingungen erfüllt sind, geschrieben als Escape:

**\\A**
: trifft nur am Anfang der Zeichenkette (siehe [Abgleich] unten, wie sich das von „**^**“ unterscheidet)

**\\m**
: trifft nur am Anfang eines Wortes

**\\M**
: trifft nur am Ende eines Wortes

**\\y**
: trifft nur am Anfang oder Ende eines Wortes

**\\Y**
: trifft nur an einer Stelle, die weder Wortanfang noch -ende ist

**\\Z**
: trifft nur am Ende der Zeichenkette (siehe [Abgleich] unten, wie sich das von „**$**“ unterscheidet)

**\\***m*
: (wobei *m* eine von Null verschiedene Ziffer ist) ein *Rückverweis*, siehe unten

**\\***mnn*
: (wobei *m* eine von Null verschiedene Ziffer ist, *nn* weitere Ziffern, und der Dezimalwert *mnn* nicht größer ist als die bisher gesehene Anzahl schließender erfassender Klammern) ein *Rückverweis*, siehe unten


Ein Wort ist wie bei „**\[\[:<:\]\]**“ und „**\[\[:>:\]\]**“ oben definiert. Einschränkungs-Escapes sind in Klammerausdrücken unzulässig.

## Rückverweise

Ein Rückverweis (nur AREs) trifft dieselbe Zeichenkette wie der geklammerte Unterausdruck mit der angegebenen Nummer, sodass z. B. „**(\[bc\])\\1**“ „**bb**“ oder „**cc**“, aber nicht „**bc**“ trifft. Der Unterausdruck muss dem Rückverweis im RE vollständig vorausgehen. Unterausdrücke werden in der Reihenfolge ihrer führenden Klammern nummeriert. Nicht erfassende Klammern definieren keine Unterausdrücke.

Es gibt eine historische Mehrdeutigkeit zwischen oktalen Zeicheneingabe-Escapes und Rückverweisen, die heuristisch aufgelöst wird (siehe oben). Eine führende Null bedeutet stets ein Oktal-Escape. Eine einzelne von Null verschiedene Ziffer ohne weitere Ziffer danach ist stets ein Rückverweis. Eine mehrstellige Folge ohne führende Null ist ein Rückverweis, wenn sie auf einen passenden Unterausdruck folgt (d. h. die Nummer liegt im gültigen Bereich), andernfalls Oktal.

# Metasyntax

Zusätzlich zur Hauptsyntax oben gibt es Sonderformen und weitere syntaktische Einrichtungen.

Normalerweise wird die RE-Variante anwendungsabhängig festgelegt. Das kann durch einen *Direktor* überschrieben werden. Beginnt ein RE beliebiger Variante mit „**\*\*\*:**“, ist der Rest ein ARE. Beginnt ein RE beliebiger Variante mit „**\*\*\*=**“, gilt der Rest als wörtliche Zeichenkette; alle Zeichen sind gewöhnliche Zeichen.

Ein ARE kann mit *eingebetteten Optionen* beginnen: eine Folge **(?***xyz***)** (wobei *xyz* ein oder mehr Buchstaben sind) legt Optionen für den Rest des RE fest. Sie ergänzen und können Anwendungsoptionen überschreiben. Verfügbare Optionsbuchstaben:

**b**
: Rest des RE ist ein BRE

**c**
: groß-/kleinschreibungs-sensitiver Abgleich (üblicher Standard)

**e**
: Rest des RE ist ein ERE

**i**
: groß-/kleinschreibungs-insensitiver Abgleich (siehe [Abgleich] unten)

**m**
: historisches Synonym für **n**

**n**
: zeilenumbruch-sensitiver Abgleich (siehe [Abgleich] unten)

**p**
: teilweise zeilenumbruch-sensitiver Abgleich (siehe [Abgleich] unten)

**q**
: Rest des RE ist eine wörtliche („quoted“) Zeichenkette, alle Zeichen gewöhnlich

**s**
: nicht zeilenumbruch-sensitiver Abgleich (üblicher Standard)

**t**
: straffe Syntax (üblicher Standard; siehe unten)

**w**
: invers teilweise zeilenumbruch-sensitiv („weird“) (siehe [Abgleich] unten)

**x**
: erweiterte Syntax (siehe unten)


Eingebettete Optionen gelten ab der **)**, die die Folge beendet. Sie sind nur am Anfang eines ARE verfügbar und dürfen später im ARE nicht verwendet werden.

Neben der üblichen (*straffen*) RE-Syntax, in der alle Zeichen bedeutsam sind, gibt es eine *erweiterte* Syntax, in allen RE-Varianten mit dem Schalter **-expanded** oder in AREs mit der eingebetteten Option x. In der erweiterten Syntax werden Leerraumzeichen ignoriert und alle Zeichen zwischen **#** und dem folgenden Zeilenumbruch (oder dem Ende des RE) ignoriert — so lassen sich komplexe REs gliedern und kommentieren. Drei Ausnahmen:

- ein Leerraumzeichen oder „**#**“ mit vorangehendem „**\\**“ bleibt erhalten

- Leerraum oder „**#**“ innerhalb eines Klammerausdrucks bleibt erhalten

- Leerraum und Kommentare sind in mehrzeichenigen Symbolen wie dem ARE „**(?:**“ oder dem BRE „**\\(**“ unzulässig


Leerraumzeichen der erweiterten Syntax sind Leerzeichen, Tabulator, Zeilenumbruch und jedes Zeichen der Zeichenklasse *space*.

Schließlich ist in einem ARE außerhalb von Klammerausdrücken die Folge „**(?#***ttt***)**“ (wobei *ttt* beliebiger Text ohne „**)**“ ist) ein Kommentar, der völlig ignoriert wird. Auch das ist nicht zwischen den Zeichen mehrzeicheniger Symbole wie „**(?:**“ erlaubt. Solche Kommentare sind eher historisches Artefakt als nützliche Einrichtung; ihre Verwendung ist veraltet — stattdessen die erweiterte Syntax verwenden.

*Keine* dieser Metasyntax-Erweiterungen ist verfügbar, wenn die Anwendung (oder ein anfänglicher „**\*\*\*=**“-Direktor) festlegt, dass die Eingabe als wörtliche Zeichenkette und nicht als RE behandelt wird.

# Abgleich

Kann ein RE mehr als eine Teilzeichenkette einer gegebenen Zeichenkette treffen, trifft der RE diejenige, die in der Zeichenkette am frühesten beginnt. Können an dieser Stelle mehrere Teilzeichenketten getroffen werden, bestimmt die *Präferenz* die Wahl: entweder die längste oder die kürzeste Teilzeichenkette.

Die meisten Atome und alle Einschränkungen haben keine Präferenz. Ein geklammerter RE hat dieselbe Präferenz (ggf. keine) wie der RE. Ein quantifiziertes Atom mit Quantifizierer **{***m***}** oder **{***m***}?** hat dieselbe Präferenz (ggf. keine) wie das Atom selbst. Ein quantifiziertes Atom mit anderen normalen Quantifizierern (einschließlich **{***m***,***n***}** mit *m* gleich *n*) bevorzugt die längste Übereinstimmung. Ein quantifiziertes Atom mit anderen nicht-gierigen Quantifizierern (einschließlich **{***m***,***n***}?** mit *m* gleich *n*) bevorzugt die kürzeste. Ein Zweig hat dieselbe Präferenz wie das erste quantifizierte Atom darin mit Präferenz. Ein RE aus zwei oder mehr durch **|** verbundenen Zweigen bevorzugt die längste Übereinstimmung.

Unter den Einschränkungen der Regeln für den Abgleich des gesamten RE treffen Unterausdrücke ebenfalls die längstmöglichen oder kürzestmöglichen Teilzeichenketten gemäß ihrer Präferenz; Unterausdrücke, die im RE früher beginnen, haben Vorrang vor späteren. Äußere Unterausdrücke haben damit Vorrang vor ihren Bestandteilen.

Die Quantifizierer **{1,1}** und **{1,1}?** können verwendet werden, um auf einen Unterausdruck oder ein ganzes RE jeweils längste bzw. kürzeste Präferenz zu erzwingen.

**HINWEIS:** Man kann einen RE meist insgesamt nicht-gierig machen, indem man **{1,1}?** nach einem der ersten Nicht-Einschränkungs-Atome oder geklammerten Unterausdrücke setzt. *Es lohnt sich zu experimentieren* mit der Platzierung dieser Nicht-Gierigkeits-Überschreibung an geeigneten Eingabetexten, wenn man einen RE dieser Komplexität schreibt.

Z. B. ist dieser reguläre Ausdruck nicht-gierig und trifft die kürzestmögliche Teilzeichenkette, wobei „**abc**“ so früh wie möglich getroffen wird (der Quantifizierer ändert das nicht):

```
ab{1,1}?c.*x.*cba
```

Das Atom „**a**“ hat keine Gierigkeits-Präferenz; für „**b**“ setzen wir eine explizit; die übrigen Quantifizierer werden durch den vorangehenden nicht-gierigen Quantifizierer auf nicht-gierig überschrieben.

Trefferlängen werden in Zeichen, nicht in Sortierelementen gemessen. Eine leere Zeichenkette gilt als länger als gar kein Treffer. Z. B. trifft „**bb\***“ die drei mittleren Zeichen von „**abbbc**“, „**(week|wee)(night|knights)**“ alle zehn Zeichen von „**weeknights**“, bei „**(.\*).\***“ gegen „**abc**“ trifft der geklammerte Unterausdruck alle drei Zeichen, und bei „**(a\*)\***“ gegen „**bc**“ treffen sowohl der gesamte RE als auch der geklammerte Unterausdruck eine leere Zeichenkette.

Ist groß-/kleinschreibungs-unabhängiger Abgleich angegeben, wirkt es etwa so, als ob alle Groß-/Kleinschreibungs-Unterschiede aus dem Alphabet verschwunden wären. Erscheint ein Buchstabe in mehreren Schreibungen außerhalb eines Klammerausdrucks als gewöhnliches Zeichen, wird er effektiv in einen Klammerausdruck mit beiden Schreibungen verwandelt, sodass **x** zu „**\[xX\]**“ wird. Erscheint er innerhalb eines Klammerausdrucks, werden alle Schreibvarianten hinzugefügt, sodass „**\[x\]**“ zu „**\[xX\]**“ und „**\[^x\]**“ zu „**\[^xX\]**“ wird.

Ist zeilenumbruch-sensitiver Abgleich angegeben, treffen **.** und Klammerausdrücke mit **^** nie das Zeilenumbruchzeichen (Treffer überschreiten Zeilenumbrüche nicht, es sei denn, der RE ordnet es ausdrücklich an), und **^** sowie **$** treffen jeweils die leere Zeichenkette nach bzw. vor einem Zeilenumbruch zusätzlich zu Anfang und Ende der Zeichenkette. ARE **\\A** und **\\Z** treffen weiterhin *nur* Anfang bzw. Ende der Zeichenkette.

Bei teilweise zeilenumbruch-sensitivem Abgleich betrifft das **.** und Klammerausdrücke wie beim zeilenumbruch-sensitiven Abgleich, aber nicht **^** und **$**.

Bei invers teilweise zeilenumbruch-sensitivem Abgleich betrifft das **^** und **$** wie beim zeilenumbruch-sensitiven Abgleich, aber nicht **.** und Klammerausdrücke. Das ist wenig nützlich, wird aber der Symmetrie wegen bereitgestellt.

# Grenzen und Kompatibilität

Für die Länge von REs gibt es keine besondere Grenze. Hoch portable Programme sollten keine REs länger als 256 Byte verwenden, da eine POSIX-konforme Implementierung solche REs ablehnen darf.

Das einzige Merkmal von AREs, das tatsächlich mit POSIX-EREs inkompatibel ist: **\\** verliert in Klammerausdrücken nicht seine Sonderbedeutung. Alle anderen ARE-Merkmale nutzen Syntax, die in POSIX-EREs unzulässig ist oder undefinierte bzw. nicht spezifizierte Wirkung hat; die „**\*\*\***“-Syntax der Direktoren liegt ebenfalls außerhalb der POSIX-Syntax für BREs und EREs.

Viele ARE-Erweiterungen stammen aus Perl; einige wurden bereinigt, einige Perl-Erweiterungen fehlen. Bemerkenswerte Inkompatibilitäten: „**\\b**“, „**\\B**“, fehlende Sonderbehandlung eines abschließenden Zeilenumbruchs, Ergänzung komplementierter Klammerausdrücke bei zeilenumbruch-sensitivem Abgleich, Einschränkungen für Klammern und Rückverweise in Lookahead-Einschränkungen sowie längster/kürzester-Treffer-Semantik (statt erster Treffer).

Die Abgleichregeln für REs mit normalen und nicht-gierigen Quantifizierern haben sich seit frühen Beta-Versionen dieses Pakets geändert. (Die neuen Regeln sind einfacher und klarer, raten aber weniger die wirklichen Absichten des Nutzers.)

Henry Spencers ursprüngliches *regexp*-Paket von 1986, noch weit verbreitet (z. B. in Tcl vor 8.1), implementierte eine frühe Version der heutigen EREs. Es gibt vier Inkompatibilitäten zwischen den nahe-EREs von *regexp* („RREs“) und AREs, in etwa steigender Bedeutung:

- In AREs ist **\\** gefolgt von einem alphanumerischen Zeichen entweder ein Escape oder ein Fehler; in RREs war es nur eine andere Schreibweise des alphanumerischen Zeichens. Das sollte kein Problem sein, da es keinen Grund gab, solche Folgen in RREs zu schreiben.

- **{** gefolgt von einer Ziffer in einem ARE ist der Beginn einer Grenze; in RREs war **{** stets ein gewöhnliches Zeichen. Solche Folgen sollten selten sein und führen oft zu einem Fehler, weil folgende Zeichen nicht wie eine gültige Grenze aussehen.

- In AREs bleibt **\\** innerhalb von „**\[\]**“ ein Sonderzeichen; ein wörtliches **\\** in **\[\]** muss „**\\\\**“ geschrieben werden. **\\\\** liefert in RREs ebenfalls ein wörtliches **\\** in **\[\]**, aber nur wirklich Paranoide verdoppelten routinemäßig den Backslash.

- AREs melden den längsten/kürzesten Treffer für den RE, nicht den ersten in einer festgelegten Suchreihenfolge. Das kann RREs betreffen, die darauf ausgelegt waren, dass der erste Treffer gemeldet wird. (Die sorgfältige Ausgestaltung von RREs zur Optimierung der Suchreihenfolge ist obsolet — AREs prüfen alle möglichen Treffer parallel, ihre Leistung hängt wenig von der Komplexität ab — Fälle, in denen die Suchreihenfolge genutzt wurde, um absichtlich einen Treffer zu finden, der *nicht* der längste/kürzeste ist, müssen umgeschrieben werden.)


# Einfache reguläre Ausdrücke

BREs unterscheiden sich in mehreren Punkten von EREs. „**|**“, „**+**“ und **?** sind gewöhnliche Zeichen; es gibt kein Äquivalent für ihre Funktion. Die Begrenzer für Grenzen sind **\\{** und „**\\}**“, **{** und **}** allein sind gewöhnliche Zeichen. Die Klammern für verschachtelte Unterausdrücke sind **\\(** und „**\\)**“, **(** und **)** allein sind gewöhnliche Zeichen. **^** ist ein gewöhnliches Zeichen außer am Anfang des RE oder am Anfang eines geklammerten Unterausdrucks, **$** außer am Ende des RE oder am Ende eines geklammerten Unterausdrucks, und **\*** ist ein gewöhnliches Zeichen, wenn es am Anfang des RE oder am Anfang eines geklammerten Unterausdrucks steht (nach einem möglichen führenden „**^**“). Schließlich gibt es einstellige Rückverweise, und **\\<** sowie **\\>** sind Synonyme für „**\[\[:<:\]\]**“ bzw. „**\[\[:>:\]\]**“; weitere Escapes gibt es nicht.
