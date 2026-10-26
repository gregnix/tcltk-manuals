---
CommandName: textutil::expander
title: textutil::expander
ManualSection: n
Version: 1.3.2
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - http://www.wjduquette.com/expand
 - regexp
 - split
 - string
Keywords:
 - string
 - template processing
 - text expansion
Copyright:
 - Copyright (c) William H. Duquette https://github.com/wjduquette
---

# Name

textutil::expander – Prozeduren zur Bearbeitung von Vorlagen und zum Erweitern von Text.

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil::expander]{.lit} [1.3.2]{.optlit}
[::textutil::expander]{.cmd} [expanderName]{.arg}
[expanderName]{.ins} [cappend]{.sub} [text]{.arg}
[expanderName]{.ins} [cget]{.sub} [varname]{.arg}
[expanderName]{.ins} [cis]{.sub} [cname]{.arg}
[expanderName]{.ins} [cname]{.sub}
[expanderName]{.ins} [cpop]{.sub} [cname]{.arg}
[expanderName]{.ins} [ctopandclear]{.sub}
[expanderName]{.ins} [cpush]{.sub} [cname]{.arg}
[expanderName]{.ins} [cset]{.sub} [varname]{.arg} [value]{.arg}
[expanderName]{.ins} [cvar]{.sub} [varname]{.arg}
[expanderName]{.ins} [errmode]{.sub} [newErrmode]{.arg}
[expanderName]{.ins} [evalcmd]{.sub} [newEvalCmd]{.optarg}
[expanderName]{.ins} [expand]{.sub} [string]{.arg} [brackets]{.optarg}
[expanderName]{.ins} [lb]{.sub} [newbracket]{.optarg}
[expanderName]{.ins} [rb]{.sub} [newbracket]{.optarg}
[expanderName]{.ins} [reset]{.sub}
[expanderName]{.ins} [setbrackets]{.sub} [lbrack]{.arg} [rbrack]{.arg}
[expanderName]{.ins} [textcmd]{.sub} [newTextCmd]{.optarg}
[expanderName]{.ins} [where]{.sub}
:::

# Beschreibung

Das Paket **textutil::expander** bietet eine Funktion zur Erstellung von Zeichenfolgenvorlagen, die leistungsfähiger und flexibler ist als der integrierte Befehl [subst](https://www.tcl-lang.org/man/tcl/TclCmd/subst.html).

Im Abschnitt [Anleitung] erfahren Sie mehr über das Paket, und im Abschnitt [API] finden Sie alle Einzelheiten.

# Expander vs. subst

Der Tcl-Befehl **subst** wird häufig zur Unterstützung einer Art von Vorlagenverarbeitung verwendet. Bei einer Zeichenkette mit eingebetteten Variablen oder Funktionsaufrufen fügt **subst** die Werte der Variablen und Funktionen ein und gibt die neue Zeichenkette zurück:

```
    % set greeting "Howdy"
    Howdy
    % proc place {} {return "World"}
    % subst {$greeting, [place]!}
    Howdy, World!
    %
```

Durch die Definition einer geeigneten Reihe von Tcl-Befehlen lässt sich mit **subst** eine Markup-Sprache implementieren, die HTML ähnelt.

Der Befehl **subst** ist zwar effizient, weist jedoch bei dieser Art der Vorlagenverarbeitung drei Nachteile auf:

- Es gibt keine Möglichkeit, den Klartext zwischen zwei eingebetteten Tcl-Befehlen zu identifizieren und zu verarbeiten; das erschwert den kontextsensitiven Umgang mit Klartext.

- Eingebettete Befehle müssen zwingend zwischen **\[** und **\]** stehen; in besonderen Fällen ist es praktisch, verschiedene Klammern wählen zu können.  Wer Seiten erstellt, die eine große Menge an Tcl-Code-Beispielen enthalten, wird möglicherweise lieber **<<** und **>>** als Begrenzer für den eingebetteten Code verwenden.

- Es gibt keine einfache Möglichkeit, inkrementelle Eingaben zu verarbeiten, wie Sie es beispielsweise beim Einlesen von Daten aus einem Socket tun möchten.


Derzeit löst „expander“ die ersten beiden Probleme.

Im folgenden Abschnitt wird die API von „expander“ beschrieben; darauf folgen die Abschnitte zum Tutorial, siehe [Anleitung].

# API

Das Paket **textutil::expander** enthält nur einen Befehl, der im Folgenden beschrieben wird. Der Rest dieses Abschnitts befasst sich mit einer Beschreibung der Methoden für die durch diesen Befehl erstellten Expander-Objekte.

**::textutil::expander** *expanderName*
: Der Befehl erstellt ein neues Expander-Objekt mit einem zugehörigen Tcl-Befehl, dessen Name *expanderName* lautet. Mit diesem Befehl können verschiedene Methoden aufgerufen werden. Wenn *expanderName* nicht vollständig qualifiziert ist, wird er als relativ zum aktuellen Namespace interpretiert. Die Methodenaufrufe haben die folgende allgemeine Form:

    ```
    expanderName method ?arg ...?
    ```


Expander-Objekte unterstützen die folgenden Methoden:

*expanderName* **cappend** *text*
: Fügt im aktuellen Kontext eine Zeichenkette an die Ausgabe an. Dieser Befehl sollte von Makros oder Anwendungscode nur selten verwendet werden.

*expanderName* **cget** *varname*
: Gibt den Wert der im aktuellen Kontext definierten Variablen *varname* zurück.

*expanderName* **cis** *cname*
: Gibt **1** (wahr) zurück, wenn der Name des aktuellen Kontexts *cname* lautet; andernfalls gibt es **0** (falsch) zurück. *cname*.

*expanderName* **cname**
: Gibt den Namen des aktuellen Kontexts zurück.

*expanderName* **cpop** *cname*
: Entnimmt einen Kontext aus dem Kontextstapel und gibt die gesamte in diesem Kontext gesammelte Ausgabe zurück. Der Kontext muss *cname* heißen, andernfalls wird ein Fehler ausgelöst.

*expanderName* **ctopandclear**
: Gibt die aktuell im obersten Kontext erfasste Ausgabe zurück und leert diesen Puffer. Dies entspricht in etwa einer Kombination aus **cpop** und anschließendem **cpush**, mit dem Unterschied, dass hier der interne Zustand (Klammern) beibehalten wird.

*expanderName* **cpush** *cname*
: Fügt einen Kontext namens *cname* auf den Kontextstapel ein. Der Kontext muss vor Ende der Erweiterung mit **cpop** vom Stapel entfernt werden, andernfalls wird ein Fehler ausgelöst.

*expanderName* **cset** *varname* *value*
: Setzt die Variable *varname* im aktuellen Kontext auf den Wert *value*.

*expanderName* **cvar** *varname*
: Gibt den internen Variablennamen der Kontextvariablen *varname* zurück; dadurch kann die Variable an Befehle wie **lappend** übergeben werden.

*expanderName* **errmode** *newErrmode*
: Legt den Fehlermodus für die Makroauswertung auf einen der Werte **nothing**, **macro**, **error** oder **fail** fest; der Standardwert ist **fail**. Der Wert bestimmt, wie der Expander reagiert, wenn bei der Auswertung eines Makros ein Fehler festgestellt wird.

    **fail**
    : Der Fehler wird wie üblich weitergeleitet (d. h., er wird ausgelöst) und kann von der Anwendung abgefangen oder ignoriert werden.

    **error**
    : Das Makro wird zu einer detaillierten Fehlermeldung erweitert, und die Erweiterung wird fortgesetzt.

    **macro**
    : Das Makro wird zu sich selbst erweitert; das heißt, es wird unverändert an die Ausgabe weitergegeben.

    **nothing**
    : Das Makro wird zu einer leeren Zeichenkette erweitert und somit praktisch ignoriert.


*expanderName* **evalcmd** ?*newEvalCmd*?
: Gibt den aktuellen Befehl für die Auswertung zurück, der standardmäßig **uplevel #0** lautet. Wenn festgelegt, wird *newEvalCmd* für die spätere Verwendung gespeichert und anschließend zurückgegeben; es muss sich um einen Tcl-Befehl handeln, der ein zusätzliches Argument erwartet: das auszuwertende Makro.

*expanderName* **expand** *string* ?*brackets*?
: Erweitert die Eingabezeichenkette, ersetzt darin enthaltene Makros durch ihre expandierten Werte und gibt die expandierte Zeichenkette zurück.

    Hinweis: Diese Methode während ihrer Ausführung einen neuen (leeren) Kontext auf den Kontextstapel schiebt und ihn bei der Rückkehr wieder entfernt.

    Wenn *brackets* angegeben wird, muss es sich um eine Liste aus zwei Zeichenketten handeln; die Elemente werden ausschließlich für diese Erweiterung als linke und rechte Klammersequenz für die Makroerweiterung verwendet.

*expanderName* **lb** ?*newbracket*?
: Gibt den aktuellen Wert der linken Makroauswertungsklammer zurück; dies dient zur Verwendung als oder innerhalb eines Makros, wenn die Klammer in den Ausgabetext aufgenommen werden soll. Wenn *newbracket* festgelegt wird, wird dies zur neuen Klammer und zurückgegeben.

*expanderName* **rb** ?*newbracket*?
: Gibt den aktuellen Wert der rechten Klammer der Makroauswertung zurück; dies dient zur Verwendung als oder innerhalb eines Makros, wenn die Klammer in den Ausgabetext aufgenommen werden soll. Wenn *newbracket* festgelegt wird, wird dies zur neuen Klammer und zurückgegeben.

*expanderName* **reset**
: Setzt alle Expander-Einstellungen auf ihre Ausgangswerte zurück. Es ist mit unerwarteten Ergebnissen zu rechnen, wenn dieser Befehl innerhalb eines Aufrufs von **expand** aufgerufen wird.

*expanderName* **setbrackets** *lbrack rbrack*
: Legt die linken und rechten Klammern für die Makroauswertung fest. Dieser Befehl ist zur Verwendung als oder innerhalb eines Makros vorgesehen oder dient dazu, die Klammerdefinitionen dauerhaft zu ändern.  Standardmäßig lauten die Klammern **\[** und **\]**, es kann jedoch jede nicht leere Zeichenkette verwendet werden; zum Beispiel **<** und **>** oder **(\*** und **\*)** oder sogar **Hello,** und **World!**.

*expanderName* **textcmd** ?*newTextCmd*?
: Gibt den aktuellen Befehl zur Verarbeitung von Klartext zurück, der standardmäßig die leere Zeichenkette ist, was *identity* bedeutet. Wenn angegeben, wird *newTextCmd* für die spätere Verwendung gespeichert und anschließend zurückgegeben; es muss sich um einen Tcl-Befehl handeln, der ein zusätzliches Argument erwartet: den zu verarbeitenden Text. Das Expander-Objekt verwendet diesen Befehl für jeden antreffenden Klartext, wodurch der Benutzer des Objekts die Möglichkeit erhält, den gesamten Klartext auf eine einheitliche Weise zu verarbeiten, bevor er in die Ausgabe geschrieben wird. Das Objekt erwartet, dass der Befehl den verarbeiteten Klartext gibt.

    *Hinweis*: Die Kombination „**textcmd** *plaintext*“ wird zur tatsächlichen Auswertung durch den *evalcmd* geleitet. Mit anderen Worten: Der *textcmd* wird als spezielles Makro behandelt, das implizit den gesamten Klartext in der Vorlage umschließt.

*expanderName* **where**
: Gibt eine Liste mit drei Elementen zurück, die die aktuelle Zeichenposition, Zeile und Spalte enthält, die der Expander bei der Verarbeitung der aktuellen Eingabezeichenfolge erreicht hat.


# Anleitung

## Grundlagen

Erstellen Sie zunächst ein Expander-Objekt:

```
    % package require textutil::expander
    1.2
    % ::textutil::expander myexp
    ::myexp
    %
```

Das erstellte **::myexp**-Objekt kann verwendet werden, um Textzeichenfolgen zu erweitern, die eingebettete Tcl-Befehle enthalten. Standardmäßig werden eingebettete Befehle durch eckige Klammern begrenzt. Beachten Sie, dass der Expander nicht versucht, Variablen zu interpolieren, da Variablen von eingebetteten Befehlen referenziert werden können:

```
    % set greeting "Howdy"
    Howdy
    % proc place {} {return "World"}
    % ::myexp expand {[set greeting], [place]!}
    Howdy, World!
    %
```

## Makros einbetten

Ein Expander-Makro ist einfach ein in eine Textzeichenfolge eingebettetes Tcl-Skript. Expander führt das Skript im globalen Kontext aus und ersetzt es durch die resultierende Zeichenfolge. Zum Beispiel:

```
    % set greetings {Howdy Hi "What's up"}
    Howdy Hi "What's up"
    % ::myexp expand {There are many ways to say "Hello, World!":
    [set result {}
    foreach greeting $greetings {
	append result "$greeting, World!\\n"
    }
    set result]
    And that's just a small sample!}
    There are many ways to say "Hello, World!":
    Howdy, World!
    Hi, World!
    What's up, World!

    And that's just a small sample!
    %
```

## Makrobefehle schreiben

In der Regel werden *Makrobefehle* zur Erstellung einer Auszeichnungssprache verwendet. Ein Makrobefehl ist lediglich ein Tcl-Befehl, der eine Ausgabekette gibt. Mit dem Befehl „expand“ lässt sich beispielsweise eine generische Dokumentauszeichnungssprache implementieren, die auf HTML oder ein beliebiges anderes Ausgabeformat angepasst werden kann:

```
    % proc bold {} {return "<b>"}
    % proc /bold {} {return "</b>"}
    % ::myexp expand {Some of this text is in [bold]boldface[/bold]}
    Some of this text is in <b>boldface</b>
    %
```

Die oben genannten Definitionen von **bold** und **/bold** geben HTML zurück, doch solche Befehle können beliebig komplex gestaltet werden; sie könnten beispielsweise je nach gewünschtem Ausgabeformat entscheiden, was zurückgegeben wird.

## Expansionsklammern ändern

Standardmäßig werden eingebettete Makros in eckige Klammern, **\[** und **\]**, gesetzt.  Wenn eckige Klammern in der Ausgabe enthalten sein müssen, können in der Eingabe die Befehle **lb** und **rb** verwendet werden.  Alternativ oder wenn eckige Klammern aus einem anderen Grund unerwünscht sind, können die Klammern für die Makroauswertung durch ein beliebiges Paar nichtleerer Zeichenfolgen ersetzt werden.

Die Methode **setbrackets** ändert die Klammern für alle nachfolgenden Erweiterungen, die auf das aktuelle Erweiterungsobjekt angewendet werden. Sie können beispielsweise Pseudo-HTML schreiben, indem Sie sie in **<** und **>** ändern:

```
    % ::myexp setbrackets < >
    % ::myexp expand {<bold>This is boldface</bold>}
    <b>This is boldface</b>
```

Alternativ können Sie die Expansionsklammern vorübergehend ändern, indem Sie die gewünschten Klammern an die Methode **expand** übergeben:

```
    % ::myexp setbrackets "\\[" "\\]"
    % ::myexp expand {<bold>This is boldface</bold>} {< >}
    <b>This is boldface</b>
    %
```

## Individuelle Makroauswertung

Standardmäßig werden Makros mit dem Tcl-Befehl **uplevel #0** ausgewertet, sodass der eingebettete Code im globalen Kontext ausgeführt wird. Die Anwendung kann über die Methode **evalcmd** einen anderen Befehl für die Auswertung bereitstellen; dies ermöglicht es der Anwendung beispielsweise, einen sicheren Interpreter zu verwenden oder sogar etwas anderes als Tcl-Code auszuwerten.  Es gibt jedoch eine Einschränkung: Um als gültig erkannt zu werden, muss ein Makro den Wert **1** (wahr) geben, wenn es an den Tcl-Unterbefehl [info complete](https://www.tcl-lang.org/man/tcl9.0/TclCmd/info.html) übergeben wird.

Beispielsweise erfolgt bei jedem Makro eine Auswertung, bei der der Makrotext selbst zurückgegeben wird.

```
    proc identity {macro} {return $macro}
    ::myexp evalcmd identity
```

## Verwendung des Kontextstapels

Oft ist es wünschenswert, ein Makro-Paar zu definieren, das in irgendeiner Weise auf den Klartext zwischen den beiden Makros einwirkt. Betrachten wir eine Reihe von Makros zum Hinzufügen von Fußnoten zu einer Seite: Sie hätten etwa Folgendes implementieren können:

```
    Dr. Pangloss, however, thinks that this is the best of all
    possible worlds.[footnote "See Candide, by Voltaire"]
```

Das Makro **footnote** würde dieser Fußnote vermutlich eine Nummer zuweisen und den Text speichern, um ihn später zu formatieren. Diese Lösung ist jedoch unschön, wenn der Fußnotentext lang ist oder zusätzliche Markups enthalten soll. Ziehen Sie stattdessen Folgendes in Betracht:

```
    Dr. Pangloss, however, thinks that this is the best of all
    possible worlds.[footnote]See [bookTitle "Candide"], by
    [authorsName "Voltaire"], for more information.[/footnote]
```

Hier steht der Fußnotentext zwischen den Makros **footnote** und **/footnote**, setzt sich in einer zweiten Zeile fort und enthält selbst mehrere Makros. Das ist sowohl übersichtlicher als auch flexibler; mit den bisher vorgestellten Funktionen gibt es jedoch keine einfache Möglichkeit, dies umzusetzen.  Dafür ist der Kontextstapel gedacht.

Jede Makro-Erweiterung findet in einem bestimmten Kontext statt. Hier fügt das Makro **footnote** einen neuen Kontext auf den Kontextstapel. Anschließend wird der gesamte erweiterte Text in diesen neuen Kontext eingefügt. **/footnote** ruft ihn ab, indem es den Kontext vom Stapel nimmt. Hier ist eine grobe Implementierung dieser beiden Makros:

```
    proc footnote {} {
        ::myexp cpush footnote
    }

    proc /footnote {} {
        set footnoteText [::myexp cpop footnote]

        # Save the footnote text, and return an appropriate footnote
        # number and link.
    }
```

Die Methode **cpush** schiebt einen neuen Kontext auf den Stack; das Argument ist der Name des Kontexts.  Dies kann eine beliebige Zeichenkette sein, ist jedoch in der Regel der Name des Makros selbst. Anschließend überprüft **cpop**, ob der aktuelle Kontext den erwarteten Name trägt, entfernt ihn vom Stack und gibt den gesammelten Text zurück.

Expand bietet mehrere weitere Werkzeuge im Zusammenhang mit dem Kontextstapel. Angenommen, das erste Makro in einem Kontextpaar nimmt Argumente entgegen oder berechnet Werte, die das zweite Makro in diesem Paar benötigt. Nach dem Aufruf von **cpush** kann das erste Makro eine oder mehrere Kontextvariablen definieren; das zweite Makro kann deren Werte jederzeit vor dem Aufruf von **cpop** abrufen.  Nehmen wir beispielsweise an, das Dokument müsse die Fußnotennummer explizit angeben:

```
    proc footnote {footnoteNumber} {
        ::myexp cpush footnote
        ::myexp csave num $footnoteNumber
        # Return an appropriate link
    }

    proc /footnote {} {
        set footnoteNumber [::myexp cget num]
        set footnoteText [::myexp cpop footnote]

        # Save the footnote text and its footnoteNumber for future
        # output.
    }
```

Manchmal kann es wünschenswert sein, Makros zu definieren, die nur innerhalb eines bestimmten Kontextpaares gültig sind; solche Makros sollten mithilfe von **cis** oder **cname** überprüfen, ob sie nur im richtigen Kontext aufgerufen werden.

# Geschichte

Das **expander**-Paket wurde von William H. Duquette geschrieben; es handelt sich um eine Neuauflage des zentralen Algorithmus des Makroverarbeitungsprogramms „expand“.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dokumentationswerkzeuge

# Copyright

```
Copyright (c) William H. Duquette https://github.com/wjduquette
```
