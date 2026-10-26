---
CommandName: html
title: html
ManualSection: n
Version: 1.6
TclPart: tcllib
TclDescription: HTML Generation
Links:
 - htmlparse
 - ncgi
Keywords:
 - checkbox
 - checkbutton
 - form
 - html
 - radiobutton
 - table
Copyright:
---

# Name

html – Prozeduren zur Erstellung von HTML-Strukturen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [html]{.lit} [1.6]{.optlit}
[::html::author]{.cmd} [author]{.arg}
[::html::bodyTag]{.cmd} [args]{.arg}
[::html::cell]{.cmd} [param]{.arg} [value]{.arg} [tag]{.optarg}
[::html::checkbox]{.cmd} [name]{.arg} [value]{.arg}
[::html::checkSet]{.cmd} [key]{.arg} [sep]{.arg} [list]{.arg}
[::html::checkValue]{.cmd} [name]{.arg} [value]{.optarg}
[::html::closeTag]{.cmd}
[::html::default]{.cmd} [key]{.arg} [param]{.optarg}
[::html::description]{.cmd} [description]{.arg}
[::html::end]{.cmd}
[::html::eval]{.cmd} [arg]{.arg} [args]{.optarg}
[::html::extractParam]{.cmd} [param]{.arg} [key]{.arg} [varName]{.optarg}
[::html::font]{.cmd} [args]{.arg}
[::html::for]{.cmd} [start]{.arg} [test]{.arg} [next]{.arg} [body]{.arg}
[::html::foreach]{.cmd} [varlist1]{.arg} [list1]{.arg} [varlist2 list2]{.optdot} [body]{.arg}
[::html::formValue]{.cmd} [name]{.arg} [defvalue]{.optarg}
[::html::getFormInfo]{.cmd} [args]{.arg}
[::html::getTitle]{.cmd}
[::html::h]{.cmd} [level]{.arg} [string]{.arg} [param]{.optarg}
[::html::h1]{.cmd} [string]{.arg} [param]{.optarg}
[::html::h2]{.cmd} [string]{.arg} [param]{.optarg}
[::html::h3]{.cmd} [string]{.arg} [param]{.optarg}
[::html::h4]{.cmd} [string]{.arg} [param]{.optarg}
[::html::h5]{.cmd} [string]{.arg} [param]{.optarg}
[::html::h6]{.cmd} [string]{.arg} [param]{.optarg}
[::html::hdrRow]{.cmd} [args]{.arg}
[::html::head]{.cmd} [title]{.arg}
[::html::headTag]{.cmd} [string]{.arg}
[::html::html\_entities]{.cmd} [string]{.arg}
[::html::if]{.cmd} [expr1]{.arg} [body1]{.arg} [[elseif]{.lit} [expr2]{.arg} body2]{.optdot} [[else]{.lit} [bodyN]{.arg}]{.optarg}
[::html::init]{.cmd} [list]{.optarg}
[::html::keywords]{.cmd} [args]{.arg}
[::html::mailto]{.cmd} [email]{.arg} [subject]{.optarg}
[::html::meta]{.cmd} [args]{.arg}
[::html::meta\_name]{.cmd} [args]{.arg}
[::html::meta\_equiv]{.cmd} [args]{.arg}
[::html::meta\_charset]{.cmd} [charset]{.arg}
[::html::css]{.cmd} [href]{.arg}
[::html::css-clear]{.cmd}
[::html::js]{.cmd} [href]{.arg}
[::html::js-clear]{.cmd}
[::html::minorList]{.cmd} [list]{.arg} [ordered]{.optarg}
[::html::minorMenu]{.cmd} [list]{.arg} [sep]{.optarg}
[::html::nl2br]{.cmd} [string]{.arg}
[::html::openTag]{.cmd} [tag]{.arg} [param]{.optarg}
[::html::paramRow]{.cmd} [list]{.arg} [rparam]{.optarg} [cparam]{.optarg}
[::html::passwordInput]{.cmd} [name]{.optarg}
[::html::passwordInputRow]{.cmd} [label]{.arg} [name]{.optarg}
[::html::quoteFormValue]{.cmd} [value]{.arg}
[::html::radioSet]{.cmd} [key]{.arg} [sep]{.arg} [list]{.arg}
[::html::radioValue]{.cmd} [name]{.arg} [value]{.arg}
[::html::refresh]{.cmd} [seconds]{.arg} [url]{.arg}
[::html::row]{.cmd} [args]{.arg}
[::html::select]{.cmd} [name]{.arg} [param]{.arg} [choices]{.arg} [current]{.optarg}
[::html::selectPlain]{.cmd} [name]{.arg} [param]{.arg} [choices]{.arg} [current]{.optarg}
[::html::set]{.cmd} [var]{.arg} [val]{.arg}
[::html::submit]{.cmd} [label]{.arg} [name]{.optarg} [title]{.optarg}
[::html::tableFromArray]{.cmd} [arrname]{.arg} [param]{.optarg} [pat]{.optarg}
[::html::tableFromList]{.cmd} [querylist]{.arg} [param]{.optarg}
[::html::textarea]{.cmd} [name]{.arg} [param]{.optarg} [current]{.optarg}
[::html::textInput]{.cmd} [name]{.arg} [value]{.arg} [args]{.arg}
[::html::textInputRow]{.cmd} [label]{.arg} [name]{.arg} [value]{.arg} [args]{.arg}
[::html::varEmpty]{.cmd} [name]{.arg}
[::html::while]{.cmd} [test]{.arg} [body]{.arg}
[::html::doctype]{.cmd} [id]{.arg}
[::html::wrapTag]{.cmd} [tag]{.arg} [text]{.optarg} [args]{.optarg}
:::

# Beschreibung

Das Paket **html** stellt Befehle zur Verfügung, die HTML generieren. Diese Befehle geben in der Regel eine HTML-Zeichenkette als Ergebnis zurück. Insbesondere geben sie ihr Ergebnis nicht über **stdout** aus.

Der Befehl **::html::init** sollte frühzeitig aufgerufen werden, um das Modul zu initialisieren. Mit dieser Prozedur können Sie auch Standardwerte für HTML-Tag-Parameter festlegen.

**::html::author** *author*
: *Nur als Nebeneffekt*.  Rufen Sie diese Funktion vor **::html::head** auf, um einen Autor für die Seite festzulegen.  Der Autor wird in einem Hinweis im HEAD-Bereich vermerkt.

**::html::bodyTag** *args*
: Erzeugt ein *body*-Tag. Die Tag-Parameter werden aus *args* oder aus dem Text des *body*-Tags übernommen. Die Attribute sind mit **::html::init** definiert.

**::html::cell** *param value* ?*tag*?
: Erzeugt ein *td*- (oder *th*-)Tag, einen Wert und ein schließendes *td*- (oder *th*-)Tag. Die Tag-Parameter stammen aus *param* oder aus TD.\*-Attributen, die mit **::html::init** definiert wurden.  Hierbei wird **::html::font** verwendet, um ein Standard-*Schriftart*-Tag in die Tabellenzelle einzufügen. Das Argument *tag* ist standardmäßig auf „td“ gesetzt.

**::html::checkbox** *name value*
: Erzeugt ein *Checkbox*-Formularelement mit dem angegebenen Name und Wert. Dabei wird **::html::checkValue** verwendet.

**::html::checkSet** *key sep list*
: Erstellt eine Reihe von *Checkbox*-Formularelementen und zugehörigen Beschriftungen. Die *Liste* sollte abwechselnd Beschriftungen und Werte enthalten. Dabei wird **::html::checkbox** verwendet. Alle *Checkbox*-Schaltflächen haben denselben *key* als Name. Das *sep* ist Text, der zur Trennung der Elemente verwendet wird.

**::html::checkValue** *name* ?*value*?
: Erzeugt den Eintrag „name=*name* value=*value*“ für ein *Checkbox*-Formularelement. Wenn die CGI-Variable *name* den Wert *value* hat, wird dem Rückgabewert „SELECTED“ hinzugefügt. Der Standardwert für *value* ist „1“.

**::html::closeTag**
: Entnimmt ein Tag aus dem von **::html::openTag** erstellten Stapel und generiert das entsprechende schließende Tag (z. B. </BODY>).

**::html::default** *key* ?*param*?
: Diese Prozedur wird von **::html::tagParam** verwendet, um den Namen und die Werteliste der Parameter für einen Tag zu generieren. Die Prozedur **::html::default** dient dazu, Standardwerte für diejenigen Elemente zu generieren, die noch nicht in *param* enthalten sind.  Wenn der durch *key* identifizierte Wert mit einem Wert in *param* übereinstimmt, gibt diese Prozedur die leere Zeichenkette zurück. Andernfalls gibt sie eine Zeichenkette im Format „parameter=value“ für ein durch *key* identifiziertes Formularelement zurück. Der *key* hat die Form „tag.parameter“ (z. B. body.bgcolor).  Verwenden Sie **::html::init**, um Standardwerte zu registrieren. *param* ist standardmäßig die leere Zeichenkette.

**::html::description** *description*
: *Nur als Nebeneffekt*. Rufen Sie diese Funktion vor **::html::head** auf, um ein *Meta*-Tag mit einer Beschreibung für die Seite zu definieren.  Dieses Tag wird später beim Aufruf von **::html::head** generiert.

**::html::end**
: Alle offenen Tags aus dem Stapel entfernen und die entsprechenden schließenden HTML-Tags generieren (z. B. </BODY></HTML>).

**::html::eval** *arg* ?*args*?
: Diese Prozedur ähnelt dem integrierten Tcl-Befehl **eval**. Der einzige Unterschied besteht darin, dass sie „“ gibt zurück, sodass sie aus einer HTML-Vorlagendatei aufgerufen werden kann, ohne dass unerwünschte Ergebnisse angehängt werden.

**::html::extractParam** *param key* ?*varName*?
: Dies ist eine Parsing-Prozedur, die den Wert von *key* aus *param* extrahiert, wobei es sich um eine Liste im HTML-Stil vom Typ „name=quotedvalue“ handelt. *varName* wird als Name einer Tcl-Variablen verwendet, deren Wert auf den in den Parametern gefundenen Wert gesetzt wird. Die Funktion gibt 1 zurück, wenn der Parameter in *param* gefunden wurde, andernfalls gibt sie 0 zurück. Wenn *varName* nicht angegeben ist, wird *key* als Variablenname verwendet.

**::html::font** *args*
: Erzeugt ein Standard-*Schriftart*-Tag. Die Parameter für das Tag werden aus *args* und den mit **::html::init** definierten HTML-Standardwerten übernommen.

**::html::for** *start test next body*
: Diese Prozedur ähnelt der integrierten Tcl-Kontrollstruktur **for**. Anstatt den Körper auszuwerten, gibt sie den durch „subst“ ersetzten *Körper* zurück. Bei jeder Iteration der Schleife wird eine weitere Zeichenkette an den Wert angehängt.

**::html::foreach** *varlist1 list1* ?*varlist2 list2 ...*? *body*
: Diese Prozedur ähnelt der integrierten Tcl-Kontrollstruktur **foreach**. Anstatt die Auswertung des Körpers durchzuführen, gibt sie den durch „subst“ bearbeiteten *Körper* zurück. Bei jeder Iteration der Schleife wird eine weitere Zeichenkette an den Wert angehängt.

**::html::formValue** *name* ?*defvalue*?
: Gibt ein Name-Wert-Paar zurück, wobei der Wert – sofern vorhanden – anhand vorhandener CGI-Daten initialisiert wird. Das Ergebnis hat folgende Form:

    ```
      name="fred" value="freds value"
    ```

**::html::getFormInfo** *args*
: Erzeugt versteckte Felder, um Formularwerte zu erfassen. Wenn *args* leer ist, werden für alle CGI-Werte versteckte Felder erzeugt. Andernfalls ist *args* eine Liste von Zeichenfolgenmustern, die mit den Namen von Formularelementen übereinstimmen sollen.

**::html::getTitle**
: Gibt die Titelzeichenfolge ohne das umgebende *title*-Tag zurück, das durch einen vorherigen Aufruf von **::html::title** gesetzt wurde.

**::html::h** *level string* ?*param*?
: Erzeugt einen Überschriften-Tag (z. B. *h*__level__). Der *string* wird in die Überschrift eingebettet, und *param* wird für die Tag-Parameter verwendet.

**::html::h1** *string* ?*param*?
: Erstellt ein *h1*-Tag. Siehe **::html::h**.

**::html::h2** *string* ?*param*?
: Erzeugt ein *h2*-Tag. Siehe **::html::h**.

**::html::h3** *string* ?*param*?
: Erzeugt ein *h3*-Tag. Siehe **::html::h**.

**::html::h4** *string* ?*param*?
: Erzeugt ein *h4*-Tag. Siehe **::html::h**.

**::html::h5** *string* ?*param*?
: Erstellt ein *h5*-Tag. Siehe **::html::h**.

**::html::h6** *string* ?*param*?
: Erzeugt ein *h6*-Tag. Siehe **::html::h**.

**::html::hdrRow** *args*
: Erzeugt eine Tabellenzeile einschließlich der *tr*- und *th*-Tags. Jeder Wert in *args* wird in eine eigene Tabellenzelle eingefügt. Dabei wird **::html::cell** verwendet.

**::html::head** *title*
: Erstellt den *head*-Abschnitt, der den *Titel* der Seite enthält. Wenn zuvor Aufrufe an **::html::author**, **::html::keywords**, **::html::description** oder **::html::meta** aufgerufen wurden, werden zusätzliche Tags in den *head*-Bereich eingefügt. Dadurch verbleibt ein offener *html*-Tag, der mit **::html::openTag** auf den Stack geschoben wurde.

**::html::headTag** *string*
: Speichert einen Tag zur Einbindung in den von **::html::head** generierten *head*-Abschnitt. Der *String* umfasst den gesamten Inhalt des Tags mit Ausnahme der umschließenden spitzen Klammern < >.

**::html::html\_entities** *string*
: Dieser Befehl ersetzt alle Sonderzeichen in der *Zeichenkette* durch ihre HTML-Entitäten und gibt den geänderten Text zurück.

**::html::if** *expr1 body1* ?**elseif** *expr2 body2 ...*? ?**else** *bodyN*?
: Diese Prozedur ähnelt der integrierten Tcl-Kontrollstruktur **if**. Anstatt den Hauptteil des tatsächlich ausgeführten Zweigs zu bewerten, gibt sie den durch „subst“ ersetzten *Hauptteil* zurück. Hinweis: Die Syntax ist etwas restriktiver als die der integrierten Tcl-Kontrollstruktur **if**.

**::html::init** ?*list*?
: **::html::init** akzeptiert eine Name-Wert-Liste im Tcl-Stil, die Werte für Elemente mit einem Namen der Form „tag.parameter“ definiert. Ein Standardwert mit dem Schlüssel „body.bgcolor“ definiert beispielsweise die Hintergrundfarbe für das *body*-Tag.

**::html::keywords** *args*
: *Nur als Nebeneffekt*. Rufen Sie diese Funktion vor **::html::head** auf, um einen *Meta*-Tag mit Schlüsselwörtern für die Seite zu definieren.  Der *Meta*-Tag wird in das Ergebnis von **::html::head** aufgenommen.

**::html::mailto** *email* ?*subject*?
: Erstellt einen Hypertext-Link zu einer „mailto:“-URL.

**::html::meta** *args*
: Name der Kompatibilität für **html::meta\_name**.

**::html::meta\_name** *args*
: *Nur als Nebeneffekt*. Rufen Sie diese Funktion vor **::html::head** auf, um ein *meta*-Tag für die Seite zu definieren. Die Argumente (*args*) sind eine Liste aus Namen und Werten im Tcl-Stil, die für die Attribute **name=** und **content=** des *meta*-Tags verwendet wird. Das *meta*-Tag wird in das Ergebnis von **::html::head** eingebunden.

**::html::meta\_equiv** *args*
: *Nur als Nebeneffekt*. Rufen Sie diese Funktion vor **::html::head** auf, um ein *meta*-Tag für die Seite zu definieren. Die Argumente (*args*) sind eine Liste aus Namen und Werten im Tcl-Stil, die für die Attribute **http-equiv=** und **content=** des *meta*-Tags verwendet wird. Das *meta*-Tag wird in das Ergebnis von **::html::head** aufgenommen.

**::html::meta\_charset** *charset*
: *Nur als Nebeneffekt*. Rufen Sie dies vor **::html::head** auf, um ein *meta*-Tag für die Seite zu definieren. Der *charset* wird mit dem Attribut **charset=** des *meta*-Tags verwendet. Der *meta*-Tag ist im Ergebnis von **::html::head** enthalten.

**::html::css** *href*
: *Nur als Nebeneffekt*. Rufen Sie diesen Befehl vor **::html::head** auf, um ein *link*-Tag für ein verknüpftes CSS-Dokument zu definieren. Der Wert von *href* ist eine HTTP-URL zu einem CSS-Dokument. Das *link*-Tag wird in das Ergebnis von **::html::head** aufgenommen.

    Mehrere Aufrufe dieses Befehls sind zulässig, wodurch die Verwendung mehrerer Verweise auf CSS-Dokumente ermöglicht wird. Mit anderen Worten: Die Argumente mehrerer Aufrufe werden kumuliert und überschreiben sich nicht gegenseitig.

**::html::css-clear**
: *Nur als Nebenwirkung*. Rufen Sie diesen Befehl vor **::html::head** auf, um alle Verweise auf CSS-Dokumente zu löschen.

    Mehrere Aufrufe dieses Befehls sind zulässig; nach dem ersten Aufruf in einer Folge, in der kein **::html::css** dazwischenliegt, hat dies jedoch keine weitere Auswirkung.

**::html::js** *href*
: *Nur als Nebenwirkung*. Rufen Sie diesen Befehl vor **::html::head** auf, um ein *Skript*-Tag für ein verknüpftes JavaScript-Dokument zu definieren. Das *href* ist eine HTTP-URL zu einem JavaScript-Dokument. Das *script*-Tag wird in das Ergebnis von **::html::head** aufgenommen.

    Mehrere Aufrufe dieses Befehls sind zulässig, wodurch die Verwendung mehrerer Verweise auf JavaScript-Dokumente ermöglicht wird. Mit anderen Worten: Die Argumente mehrerer Aufrufe werden kumuliert und überschreiben sich nicht gegenseitig.

**::html::js-clear**
: *Nur als Nebenwirkung*. Rufen Sie diesen Befehl vor **::html::head** auf, um alle Verweise auf JavaScript-Dokumente zu löschen.

    Mehrere Aufrufe dieses Befehls sind zulässig; nach dem ersten Aufruf in einer Folge, in der kein **::html::js** dazwischenliegt, hat der Befehl jedoch keine weitere Wirkung.

**::html::minorList** *list* ?*ordered*?
: Erzeugt eine nummerierte oder unnummerierte Liste von Links. Der Name der *list* ist eine Liste im Tcl-Stil, bestehend aus Bezeichnungen und URLs für die Links. *ordered* ist ein boolescher Wert, mit dem zwischen einer nummerierten und einer unnummerierten Liste gewählt werden kann. Der Standardwert ist **false**.

**::html::minorMenu** *list* ?*sep*?
: Erzeugt eine Reihe von Hypertext-Links. Die *list* ist eine Liste im Tcl-Stil, bestehend aus Namen und URLs für die Links. *sep* ist der Text, der zwischen den einzelnen Links eingefügt werden soll. Der Standardwert ist „ | “.

**::html::nl2br** *string*
: Dieser Befehl ersetzt alle Zeilenenden in der *Zeichenkette* durch ein *br*-Tag und gibt den geänderten Text zurück.

**::html::openTag** *tag* ?*param*?
: Legt *tag* auf einen Stapel und erzeugt das Eröffnungstag für *tag*. Verwenden Sie **::html::closeTag**, um das Tag vom Stapel zu entfernen. Das zweite Argument liefert alle Tag-Argumente als Liste, deren Elemente im Format „**key**=**value**“ formatiert sind.

**::html::paramRow** *list* ?*rparam*? ?*cparam*?
: Erzeugt eine Tabellenzeile einschließlich der Tags *tr* und *td*. Jeder Wert in *list* wird in eine eigene Tabellenzelle eingefügt. Dabei wird **::html::cell** verwendet. Der Wert von *rparam* wird als Parameter für das *tr*-Tag verwendet. Der Wert von *cparam* wird als Parameter für die *td*-Tags an **::html::cell** übergeben.

**::html::passwordInput** ?*name*?
: Erstellt ein *input*-Tag vom Typ *password*. Der *Name* lautet standardmäßig „password“.

**::html::passwordInputRow** *label* ?*name*?
: Formatiert eine Zeile der Tabelle, die eine Beschriftung und ein *input*-Tag vom Typ *password* enthält. Der *Name* lautet standardmäßig „password“.

**::html::quoteFormValue** *value*
: Setzt Sonderzeichen im Wert in Anführungszeichen, indem er sie durch HTML-Entitäten für Anführungszeichen, das Und-Zeichen und spitze Klammern ersetzt.

**::html::radioSet** *key sep list*
: Erzeugt eine Reihe von *input*-Tags vom Typ *radio* und eine zugehörige Textbeschriftung. Alle Optionsfelder haben denselben *key* als Name. Der *sep* ist der Text, der zur Trennung der Elemente verwendet wird. Die *list* ist eine Liste aus Beschriftung und Wert im Tcl-Stil.

**::html::radioValue** *name value*
: Erzeugt das Format „name=*name* value=*value*“ für ein *Radio*-Formularelement. Wenn die CGI-Variable *name* den Wert *value* hat, wird dem Rückgabewert „SELECTED“ hinzugefügt.

**::html::refresh** *seconds url*
: Richtet einen *Meta*-Tag zum Aktualisieren ein. Rufen Sie diesen vor **::html::head** auf, und der HEAD-Abschnitt enthält einen *Meta*-Tag, der bewirkt, dass das Dokument in *seconds* Sekunden aktualisiert wird. Die *URL* ist optional. Wenn sie angegeben wird, legt sie eine neue Seite fest, die nach Ablauf des Aktualisierungsintervalls geladen werden soll.

**::html::row** *args*
: Erzeugt eine Tabellenzeile einschließlich der Tags *tr* und *td*. Jeder Wert in *args* wird in eine eigene Tabellenzelle eingefügt. Dabei wird **::html::cell** verwendet. Über **::html::init** festgelegte Standardinformationen werden ignoriert.

**::html::select** *name param choices* ?*current*?
: Erzeugt ein *select*-Formularelement und verschachtelte *option*-Tags. Die Attribute *name* und *param* werden zur Erzeugung des *select*-Tags verwendet. Die Liste *choices* ist eine Liste aus Namen und Werten im Tcl-Stil.

**::html::selectPlain** *name param choices* ?*current*?
: Ähnlich wie **::html::select**, mit dem Unterschied, dass *choices* eine Tcl-Liste mit Werten ist, die für die *Option*-Tags verwendet werden. Die Bezeichnung und der Wert für jede *Option* sind identisch.

**::html::set** *var val*
: Diese Prozedur ähnelt dem integrierten Tcl-Befehl **set**. Der Hauptunterschied besteht darin, dass sie „“ gibt, sodass sie aus einer HTML-Vorlagendatei aufgerufen werden kann, ohne dass unerwünschte Ergebnisse angehängt werden. Ein weiterer Unterschied ist, dass sie zwei Argumente benötigt.

**::html::submit** *label* ?*name*? ?*title*?
: Erzeugt ein *input*-Tag vom Typ *submit*. Der Standardwert für *name* lautet „submit“. Wenn eine nicht leere *title*-Zeichenkette festgelegt wird, erhält die Schaltfläche ein **title=**-Attribut mit diesem Wert.

**::html::tableFromArray** *arrname* ?*param*? ?*pat*?
: Erzeugt eine zweispaltige *Tabelle* mit verschachtelten Zeilen zur Darstellung eines Tcl-Arrays. Die Tabelle erhält eine Überschrift, die dem Namen des Arrays entspricht, und jede generierte Zeile enthält ein Name-Wert-Paar. Die Array-Namen werden sortiert (**lsort** ohne spezielle Optionen). Das Argument *param* ist für das *table*-Tag vorgesehen und muss eine vorformatierte Zeichenkette enthalten. *pat* ist ein **string match**-Muster, mit dem die Array-Elemente ausgewählt werden, die in der Tabelle angezeigt werden sollen. Der Standardwert ist **\***, d. h., das gesamte Array wird angezeigt.

**::html::tableFromList** *querylist* ?*param*?
: Erzeugt eine zweispaltige *Tabelle* mit verschachtelten Zeilen, um *querylist* anzuzeigen, bei dem es sich um ein Tcl-Dictionary handelt. Jede generierte Zeile enthält ein Name-Wert-Paar. Die Informationen werden in derselben Reihenfolge angezeigt, wie sie im Dictionary angegeben sind. Das Argument *param* ist für das *table*-Tag bestimmt und muss eine vorformatierte Zeichenkette enthalten.

**::html::textarea** *name* ?*param*? ?*current*?
: Erzeugt ein *textarea*-Tag, das die aktuellen Werte umschließt.

**::html::textInput** *name value args*
: Erzeugt ein *input*-Formular-Tag vom Typ *text*. Dabei wird **::html::formValue** verwendet. „args“ bezeichnet alle zusätzlichen Tag-Attribute, die Sie in das *input*-Tag einfügen möchten.

**::html::textInputRow** *label name value args*
: Erzeugt ein *input*-Formular-Tag vom Typ *text*, das als Zeile einer Tabelle mit einer zugehörigen Beschriftung formatiert ist. Bei „args“ handelt es sich um beliebige zusätzliche Tag-Attribute, die Sie in das *input*-Tag einfügen möchten.

**::html::varEmpty** *name*
: Diese Funktion gibt 1 zurück, wenn die angegebene Variable entweder nicht existiert oder als Wert die leere Zeichenkette hat.

**::html::while** *test body*
: Diese Prozedur ähnelt der integrierten Tcl-Kontrollstruktur **while**. Anstatt die Auswertung des Körpers durchzuführen, gibt sie den durch „subst“ ersetzten *Körper* zurück. Bei jeder Iteration der Schleife wird eine weitere Zeichenkette an den Wert angehängt.

**::html::doctype** *id*
: Mit dieser Prozedur lässt sich die Standard-DOCTYPE-Deklarationszeichenfolge erstellen. Sie gibt die Standard-Deklarationszeichenfolge für die jeweilige ID zurück oder löst einen Fehler aus, wenn die ID unbekannt ist. Folgende IDs sind definiert:

    1. HTML32

    2. HTML40

    3. HTML40T

    4. HTML40F

    5. HTML401

    6. HTML401T

    7. HTML401F

    8. XHTML10S

    9. XHTML10T

    10. XHTML10F

    11. XHTML11

    12. XHTMLB


**::html::wrapTag** *tag* ?*text*? ?*args*?
: Eine Hilfsfunktion, um einen *Text* in ein Paar aus öffnendem und schließendem *Tag* einzufassen. Die Argumente (*args*) sind eine Liste aus Namen und Werten im Tcl-Stil, die dazu dient, dem öffnenden Tag Attribute und zugehörige Werte zuzuweisen. Das Ergebnis ist eine Zeichenkette, die aus dem öffnenden *Tag* zusammen mit den optionalen Attributen, dem optionalen Text und dem schließenden Tag besteht.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *html* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

CGI-Programmierung
