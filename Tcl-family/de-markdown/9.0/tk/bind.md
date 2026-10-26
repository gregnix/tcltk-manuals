---
CommandName: bind
title: bind
ManualSection: n
Version: 8.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bgerror(n)
 - bindtags(n)
 - event(n)
 - focus(n)
 - grab(n)
 - keysyms(n)
Keywords:
 - binding
 - event
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 1998 Scriptics Corporation.
---

# Name

bind - Verknüpft X-Ereignisse mit Tcl-Scripten

# Übersicht

::: {.synopsis} :::
[bind]{.cmd} [tag]{.arg} [sequence]{.optarg} [+]{.optlit} [script]{.optarg}
:::

# Einleitung

Der Befehl **bind** verknüpft Tcl-Scripte mit X-Ereignissen. Wenn alle drei Argumente angegeben sind, sorgt **bind** dafür, dass *script* (ein Tcl-Script, das "Binding-Script" genannt wird) ausgewertet wird, wann immer das/die durch *sequence* gegebene(n) Ereignis(se) in dem/den durch *tag* identifizierten Fenster(n) auftreten. Wenn *script* mit einem "+" vorangestellt ist, wird es an ein vorhandenes Binding für *sequence* angehängt; andernfalls ersetzt *script* ein vorhandenes Binding. Wenn *script* ein leerer String ist, wird das aktuelle Binding für *sequence* zerstört, sodass *sequence* ungebunden bleibt. In allen Fällen, in denen ein *script*-Argument bereitgestellt wird, gibt **bind** einen leeren String zurück.

Wenn *sequence* ohne *script* angegeben ist, wird das aktuell an *sequence* gebundene Script zurückgegeben, oder ein leerer String wird zurückgegeben, wenn es kein Binding für *sequence* gibt. Wenn weder *sequence* noch *script* angegeben ist, ist der Rückgabewert eine Liste, deren Elemente alle Sequenzen sind, für die Bindings für *tag* existieren.

Das *tag*-Argument bestimmt, auf welche(s) Fenster das Binding angewendet wird. Wenn *tag* mit einem Punkt beginnt, wie in **.a.b.c**, muss es der Pfadname für ein Fenster sein; andernfalls kann es ein beliebiger String sein. Jedes Fenster hat eine zugeordnete Liste von Tags, und ein Binding gilt für ein bestimmtes Fenster, wenn sein Tag zu denen gehört, die für das Fenster angegeben sind. Obwohl der Befehl [bindtags] verwendet werden kann, um einem Fenster eine beliebige Menge von Binding-Tags zuzuweisen, bieten die Standard-Binding-Tags folgendes Verhalten:

- Wenn ein Tag der Name eines internen Fensters ist, gilt das Binding für dieses Fenster.

- Wenn der Tag der Name einer Widget-Klasse ist, wie z.B. **Button**, gilt das Binding für alle Widgets in dieser Klasse.

- Wenn der Tag der Name eines Toplevel-Fensters ist, gilt das Binding für das Toplevel-Fenster und alle seine internen Fenster.

- Wenn *tag* den Wert **all** hat, gilt das Binding für alle Fenster in der Anwendung.


Tk legt selbst einige Bindings für den Tag **all** an, zum Beispiel für die Tastaturnavigation von Menüs. Unter Windows geben die Bindings für **<Alt-Key>**, **<Alt-KeyRelease>**, **<F10>**, **<KeyRelease-F10>** und die Alt-Tasten die Taste an Windows weiter; Windows bedient damit die native Menüleiste und Systemtasten wie Alt-F4. Wer diese Bindings ersetzt, schaltet das ab; erweitern Sie sie, indem Sie dem Skript **+** voranstellen.

# Ereignismuster (Event Patterns)

Das *sequence*-Argument gibt eine Sequenz von einem oder mehreren Ereignismustern an, mit optionalem Leerraum zwischen den Mustern. Jedes Ereignismuster kann eine von drei Formen annehmen. Im einfachsten Fall ist es ein einzelnes druckbares ASCII-Zeichen, wie z.B. **a** oder **\[**. Das Zeichen darf kein Leerzeichen oder das Zeichen **<** sein. Diese Form des Musters passt auf ein **Key**-Ereignis für das bestimmte Zeichen. Die zweite Form des Musters ist länger, aber allgemeiner. Sie hat folgende Syntax:

```
<modifier-modifier-type-detail>
```

Das gesamte Ereignismuster ist von spitzen Klammern umgeben. Innerhalb der spitzen Klammern befinden sich null oder mehr Modifizierer, ein Ereignistyp und eine zusätzliche Information (*detail*), die einen bestimmten Button oder Keysym identifiziert. Jedes der Felder kann weggelassen werden, solange mindestens eines von *type* und *detail* vorhanden ist. Die Felder müssen durch Leerzeichen oder Bindestriche getrennt sein.

Die dritte Form des Musters wird verwendet, um ein benutzerdefiniertes, benanntes virtuelles Ereignis anzugeben. Sie hat folgende Syntax:

```
<<name>>
```

Das gesamte virtuelle Ereignismuster ist von doppelten spitzen Klammern umgeben. Innerhalb der spitzen Klammern befindet sich der benutzerdefinierte Name des virtuellen Ereignisses. Modifizierer wie **Shift** oder **Control** können nicht mit einem virtuellen Ereignis kombiniert werden, um es zu modifizieren. Bindings auf ein virtuelles Ereignis können erstellt werden, bevor das virtuelle Ereignis definiert ist, und wenn sich die Definition eines virtuellen Ereignisses dynamisch ändert, reagieren alle an dieses virtuelle Ereignis gebundenen Fenster sofort auf die neue Definition.

Einige Widgets (z.B. [menu] und [text]) erzeugen virtuelle Ereignisse, wenn ihr interner Zustand auf bestimmte Weise aktualisiert wird. Bitte sehen Sie die Manualseite für jedes Widget für Details.

## Modifizierer

Modifizierer bestehen aus einem der folgenden Werte:

::: {.info DISPLAY="yes"}
**Control**	**Mod1**, **M1**, **Command**\
**Alt**	**Mod2**, **M2**, **Option**\
**Shift**	**Mod3**, **M3**, **Num**\
**Lock**	**Mod4**, **M4**, **Fn**\
**Extended**	**Mod5**, **M5**\
**Button1**, **B1**	**Meta**, **M**\
**Button2**, **B2**	**Double**\
**Button3**, **B3**	**Triple**\
**Button4**, **B4**	**Quadruple**\
**Button5**, **B5**
:::

Wenn mehr als ein Wert aufgeführt ist, getrennt durch Kommas, sind die Werte gleichwertig. Die meisten Modifizierer haben die offensichtliche X-Bedeutung. Zum Beispiel erfordert **Button1**, dass Taste 1 gedrückt ist, wenn das Ereignis auftritt. Damit ein Binding auf ein gegebenes Ereignis passt, müssen die Modifizierer im Ereignis alle diejenigen enthalten, die im Ereignismuster angegeben sind. Ein Ereignis kann auch zusätzliche Modifizierer enthalten, die im Binding nicht angegeben sind. Wenn zum Beispiel Taste 1 gedrückt wird, während die Umschalt- und Steuerungstasten gedrückt sind, passt das Muster **<Control-Button-1>** auf das Ereignis, **<Mod1-Button-1>** jedoch nicht. Wenn keine Modifizierer angegeben sind, kann im Ereignis jede Kombination von Modifizierern vorhanden sein.

**Meta** und **M** beziehen sich auf denjenigen der Modifizierer **M1** bis **M5**, der mit der/den Meta-Taste(n) auf der Tastatur verknüpft ist (keysyms **Meta\_R** und **Meta\_L**). Wenn es keine Meta-Tasten gibt oder wenn sie mit keinen Modifizierern verknüpft sind, passen **Meta** und **M** auf kein Ereignis. Entsprechend bezieht sich der Modifizierer **Alt** auf den Modifizierer, der mit der/den Alt-Taste(n) auf der Tastatur verknüpft ist (keysyms **Alt\_L** und **Alt\_R**).

Die Modifizierer **Double**, **Triple** und **Quadruple** sind eine Bequemlichkeit zur Angabe von Doppelklicks und anderen wiederholten Ereignissen. Sie bewirken, dass ein bestimmtes Ereignismuster 2, 3 oder 4 Mal wiederholt wird, und stellen außerdem eine Zeit- und Abstandsanforderung an die Sequenz: Damit eine Ereignissequenz auf ein **Double**-, **Triple**- oder **Quadruple**-Muster passt, müssen alle Ereignisse zeitlich nahe beieinander auftreten und dazwischen darf keine nennenswerte Mausbewegung stattfinden. Zum Beispiel ist **<Double-Button-1>** äquivalent zu **<Button-1><Button-1>** mit der zusätzlichen Zeit- und Abstandsanforderung.

Die Modifizierer **Command**, **Option**, **Num** und **Fn** sind Äquivalente von **Mod1** bis **Mod4**; sie entsprechen Macintosh-spezifischen Modifizierungstasten.

Der Modifizierer **Extended** ist derzeit Windows-spezifisch. Er tritt bei Ereignissen auf, die mit den Tasten der „erweiterten Tastatur“ verknüpft sind. Auf einer US-Tastatur umfassen die erweiterten Tasten die **Alt**- und **Control**-Tasten rechts auf der Tastatur, die Cursortasten im Block links vom Ziffernblock, die **NumLock**-Taste, die **Break**-Taste, die **PrintScreen**-Taste sowie die **/**- und **Enter**-Tasten im Ziffernblock.

## Ereignistypen

Das Feld *type* kann einer der standardmäßigen X-Ereignistypen sein, mit einigen zusätzlichen Abkürzungen. Das Feld *type* akzeptiert auch einige nicht standardmäßige X-Ereignistypen, die hinzugefügt wurden, um die Macintosh- und Windows-Plattformen besser zu unterstützen. Nachfolgend eine Liste aller gültigen Typen; wenn zwei Namen zusammen erscheinen, sind sie Synonyme.

::: {.info DISPLAY="yes"}
**Activate**	**Destroy**	**Map**\
**Button**, **ButtonPress**	**Enter**	**MapRequest**\
**ButtonRelease**	**Expose**	**Motion**\
**Circulate**	**FocusIn**	**MouseWheel**\
**TouchpadScroll**	**CirculateRequest**	**FocusOut**\
**Property**	**Colormap**	**Gravity**\
**Reparent**	**Configure**	**Key**, **KeyPress**\
**ResizeRequest**	**ConfigureRequest**	**KeyRelease**\
**Unmap**   **Create**	**Leave**	**Visibility**\
**Deactivate**
:::

Die meisten der obigen Ereignisse haben dieselben Felder und Verhaltensweisen wie Ereignisse im X-Windowing-System. Ausführlichere Beschreibungen dieser Ereignisse finden sich in jedem X-Window-Programmierbuch. Einige der Ereignisse sind Erweiterungen des X-Ereignissystems zur Unterstützung von Funktionen, die für die Macintosh- und Windows-Plattformen spezifisch sind. Hier geben wir etwas mehr Detail zu diesen Ereignissen. Dazu gehören:

**Activate**, **Deactivate**
: Diese beiden Ereignisse werden an jedes Unterfenster eines Toplevel gesendet, wenn sich dessen Zustand ändert. Zusätzlich zum Fokus-Fenster kennen die Macintosh- und Windows-Plattformen den Begriff eines aktiven Fensters (das oft, aber nicht zwingend den Fokus hat). Auf dem Macintosh haben Widgets im aktiven Fenster ein anderes Erscheinungsbild als Widgets in inaktiven Fenstern. Das Ereignis **Activate** wird an alle Unterfenster eines Toplevel gesendet, wenn es vom inaktiven zum aktiven Zustand wechselt. Entsprechend wird das Ereignis **Deactivate** gesendet, wenn sich der Fensterzustand von aktiv zu inaktiv ändert. Für Bindings auf diese Ereignisse gibt es keine nützlichen Prozent-Substitutionen.

**MouseWheel**
: Viele moderne Mäuse haben ein Mausrad, mit dem Dokumente ohne Scrollleisten gescrollt werden können. Durch Drehen des Rads erzeugt das System **MouseWheel**-Ereignisse, die die Anwendung zum Scrollen nutzen kann. Das Ereignis wird an das Fenster unter dem Mauszeiger weitergeleitet. Beim Empfang des Ereignisses kann die Substitution **%D** verwendet werden, um das *delta*-Feld des Ereignisses zu erhalten — einen ganzzahligen Wert, der beschreibt, wie weit das Mausrad bewegt wurde. Der kleinste Wert, den das System meldet, ist vom Betriebssystem abhängig. Das Vorzeichen des Werts bestimmt, in welche Richtung das Widget scrollen soll. Positive Werte bedeuten Scrollen nach oben, negative nach unten.

    Horizontales Scrollen verwendet **Shift-MouseWheel**-Ereignisse; eine positive **%D**-*delta*-Substitution bedeutet Scrollen nach links, eine negative nach rechts. Horizontale Scroll-Ereignisse entstehen bei Kipp-Rädern mancher Mäuse. Horizontales Scrollen kann auch emuliert werden, indem Shift gedrückt gehalten und vertikal gescrollt wird.

**TouchpadScroll**
: Auf einigen Plattformen (derzeit Windows und macOS) gibt es Unterstützung für hochauflösende Scroll-Geräte wie Touchpads. Dies wird über **TouchpadScroll**-Ereignisse bereitgestellt. Diese Ereignisse speichern zwei 16-Bit-Delta-Werte in der Ganzzahl, die durch die Substitution **%D** bereitgestellt wird. Das *X*-Delta steht in den höherwertigen 16 Bits, das *Y*-Delta in den niederwertigen 16 Bits. Diese Werte können mit der Hilfsprozedur tk::PreciseScrollDeltas ausgepackt werden. Zum Beispiel:

    ```
    lassign [tk::PreciseScrollDeltas %D] deltaX deltaY
    ```

    Die Substitution **$#** ist ein Zähler für **TouchpadScroll**-Ereignisse, den Widgets nutzen können, die nur Einheiten-Scrolling unterstützen, um einen Teil der Ereignisse zu ignorieren.

**KeyPress**, **KeyRelease**
: Die Ereignisse **KeyPress** und **KeyRelease** werden erzeugt, wann immer eine Taste gedrückt oder losgelassen wird. **KeyPress** und **KeyRelease**

**Key**, **KeyRelease**
: Die Ereignisse **Key** und **KeyRelease** werden erzeugt, wann immer eine Taste gedrückt oder losgelassen wird. **Key**- und **KeyRelease**-Ereignisse werden an das Fenster gesendet, das derzeit den Tastaturfokus hat.

**Button**, **ButtonRelease**, **Motion**
: Die Ereignisse **Button** und **ButtonRelease** werden erzeugt, wenn der Benutzer eine Maustaste drückt oder loslässt. **Motion**-Ereignisse werden erzeugt, wann immer der Zeiger bewegt wird. **Button**-, **ButtonRelease**- und **Motion**-Ereignisse werden normalerweise an das Fenster gesendet, das den Zeiger enthält.

    Wenn eine Maustaste gedrückt wird, erhält das Fenster mit dem Zeiger automatisch einen temporären Pointer-Grab. Nachfolgende **Button**-, **ButtonRelease**- und **Motion**-Ereignisse werden an dieses Fenster gesendet, unabhängig davon, welches Fenster den Zeiger enthält, bis alle Tasten losgelassen wurden.

**Configure**
: Ein **Configure**-Ereignis wird an ein Fenster gesendet, wann immer sich dessen Größe, Position oder Rahmenbreite ändert, und manchmal, wenn sich seine Position in der Stapelreihenfolge geändert hat.

**Map**, **Unmap**
: Die Ereignisse **Map** und **Unmap** werden erzeugt, wann immer sich der Mapping-Zustand eines Fensters ändert.

    Fenster werden im unmapped-Zustand erzeugt. Toplevel-Fenster werden gemappt, wenn sie in den Zustand **normal** wechseln, und unmapped im Zustand **withdrawn** und **iconic**. Andere Fenster werden gemappt, wenn sie unter Kontrolle eines Geometry-Managers (z.B. [pack] oder [grid]) gestellt werden.

    Ein Fenster ist nur dann *sichtbar* (*viewable*), wenn es und alle seine Vorfahren gemappt sind. Geometry-Manager mappen ihre Kinder typischerweise erst, wenn sie selbst gemappt wurden, und unmapen alle Kinder, wenn sie unmapped werden; daher zeigen **Map**- und **Unmap**-Ereignisse in Tk an, ob ein Fenster sichtbar ist oder nicht.

**Visibility**
: Ein Fenster gilt als *verdeckt* (*obscured*), wenn ein anderes Fenster darüber in der Stapelreihenfolge es vollständig oder teilweise überlappt. **Visibility**-Ereignisse werden erzeugt, wann immer sich der Verdeckungszustand eines Fensters ändert; das Feld *state* (**%s**) gibt den neuen Zustand an.

**Expose**
: Ein **Expose**-Ereignis wird erzeugt, wann immer ein Fenster ganz oder teilweise neu gezeichnet werden muss (z.B. wenn ein Fenster erstmals gemappt wird oder wieder sichtbar wird). Client-Anwendungen müssen **Expose**-Ereignisse normalerweise nicht behandeln, da Tk sie intern verarbeitet.

**Destroy**
: Ein **Destroy**-Ereignis wird an ein Fenster geliefert, wenn es zerstört wird.

    Wenn das **Destroy**-Ereignis an ein Widget geliefert wird, befindet es sich in einem „halb-toten“ Zustand: Das Widget existiert noch, aber Operationen, die es betreffen, können ungültige Ergebnisse liefern oder einen Fehler zurückgeben.

**FocusIn**, **FocusOut**
: Die Ereignisse **FocusIn** und **FocusOut** werden erzeugt, wann immer sich der Tastaturfokus ändert. Ein **FocusOut**-Ereignis wird an das alte Fokus-Fenster gesendet, ein **FocusIn**-Ereignis an das neue.

    Wenn die alten und neuen Fokus-Fenster keinen gemeinsamen Parent haben, werden „virtuelle Crossing“-Fokus-Ereignisse an die Zwischenfenster in der Hierarchie gesendet. Ein **FocusIn**-Ereignis zeigt also an, dass das Zielfenster oder einer seiner Nachfahren den Fokus erhalten hat; ein **FocusOut**-Ereignis zeigt an, dass der Fokus auf ein Fenster außerhalb der Hierarchie des Zielfensters gewechselt ist.

    Der Tastaturfokus kann explizit durch einen Aufruf von [focus] oder implizit durch den Window-Manager geändert werden.

**Enter**, **Leave**
: Ein **Enter**-Ereignis wird an ein Fenster gesendet, wenn der Zeiger dieses Fenster betritt; ein **Leave**-Ereignis, wenn er es verlässt.

    Wenn ein Pointer-Grab aktiv ist, werden **Enter**- und **Leave**-Ereignisse nur an das Fenster geliefert, das den Grab besitzt.

    Wenn der Zeiger zwischen zwei Fenstern wechselt, werden **Enter**- und **Leave**-„virtuelle Crossing“-Ereignisse auf dieselbe Weise an Zwischenfenster in der Hierarchie gesendet wie bei **FocusIn** und **FocusOut**.

**Property**
: Ein **Property**-Ereignis wird an ein Fenster gesendet, wann immer eine diesem Fenster gehörende X-Property geändert oder gelöscht wird. **Property**-Ereignisse werden Tk-Anwendungen normalerweise nicht zugestellt, da sie vom Tk-Kern verarbeitet werden.

**Colormap**
: Ein **Colormap**-Ereignis wird erzeugt, wann immer die mit einem Fenster verknüpfte Colormap geändert, installiert oder deinstalliert wurde.

    Widgets können eine private Colormap durch Angabe der Option **-colormap** zugewiesen bekommen; der Window-Manager ist für die Installation und Deinstallation von Colormaps verantwortlich.

    Tk liefert für diesen Ereignistyp keine nützlichen Details.

**MapRequest**, **CirculateRequest**, **ResizeRequest**, **ConfigureRequest**, **Create**
: Diese Ereignisse werden Tk-Anwendungen normalerweise nicht zugestellt. Sie sind der Vollständigkeit halber enthalten, damit X11-Window-Manager in Tk geschrieben werden können. (Diese Ereignisse werden nur zugestellt, wenn ein Client **SubstructureRedirectMask** für ein Fenster gewählt hat; der Tk-Kern verwendet diese Maske nicht.)

**Gravity**, **Reparent**, **Circulate**
: Die Ereignisse **Gravity** und **Reparent** werden Tk-Anwendungen normalerweise nicht zugestellt. Sie sind der Vollständigkeit halber enthalten.

    Ein **Circulate**-Ereignis zeigt an, dass das Fenster infolge einer **XCirculateSubwindows**-Protokollanfrage an den Anfang oder das Ende der Stapelreihenfolge gerückt ist. Die Stapelreihenfolge kann sich auch aus anderen Gründen ändern, die kein **Circulate**-Ereignis erzeugen, und Tk verwendet **XCirculateSubwindows()** intern nicht. Dieser Ereignistyp ist nur der Vollständigkeit halber enthalten; es gibt keine zuverlässige Möglichkeit, Änderungen der Position eines Fensters in der Stapelreihenfolge zu verfolgen.


## Ereignisdetails

Der letzte Teil einer langen Ereignisspezifikation ist *detail*. Bei einem **Button**- oder **ButtonRelease**-Ereignis ist es die Nummer einer Taste (1–9). Wenn eine Tastennummer angegeben ist, passt nur ein Ereignis auf genau diese Taste; wenn keine Tastennummer angegeben ist, passt ein Ereignis auf jede Taste. Hinweis: Eine bestimmte Tastennummer anzugeben unterscheidet sich von der Angabe eines Button-Modifizierers; im ersten Fall bezieht es sich auf eine Taste, die gedrückt oder losgelassen wird, im zweiten auf eine andere Taste, die bereits gedrückt ist, wenn das passende Ereignis auftritt. Wenn eine Tastennummer angegeben ist, kann *type* weggelassen werden; es wird standardmäßig **Button** angenommen. Zum Beispiel ist der Spezifizierer **<1>** äquivalent zu **<Button-1>**.

Wenn der Ereignistyp **Key** oder **KeyRelease** ist, kann *detail* in Form eines X-Keysym angegeben werden. Keysym sind textuelle Spezifikationen für bestimmte Tasten auf der Tastatur; sie umfassen alle alphanumerischen ASCII-Zeichen (z.B. ist „a“ der Keysym für das ASCII-Zeichen „a“), Beschreibungen für nicht-alphanumerische Zeichen („comma“ ist der Keysym für das Kommazeichen) sowie Beschreibungen für alle nicht-ASCII-Tasten (z.B. ist „Shift\_L“ der Keysym für die linke Umschalttaste und „F1“ der Keysym für die F1-Funktionstaste, falls vorhanden). Die vollständige Keysym-Liste wird hier nicht aufgeführt; sie ist in anderer X-Dokumentation verfügbar und kann von System zu System variieren. Bei Bedarf kann die unten beschriebene Notation **%K** verwendet werden, um den Keysym-Namen für eine bestimmte Taste auszugeben. Wenn ein Keysym als *detail* angegeben ist, kann das Feld *type* weggelassen werden; es wird standardmäßig **Key** angenommen. Zum Beispiel ist **<Control-comma>** äquivalent zu **<Control-Key-comma>**.

Unter Windows ist der Keysym des Ereignisses der lateinische Buchstabe oder die Ziffer, die Windows der Taste zuordnet (meist neben dem nicht-lateinischen Zeichen aufgedruckt), wenn **Control** oder **Alt** gedrückt ist und das Zeichen, das die aktuelle Tastaturbelegung einer Buchstaben- oder Zifferntaste zuweist, kein lateinischer Buchstabe und keine Ziffer ist (zum Beispiel bei kyrillischer oder griechischer Belegung). Bindings wie **<Control-c>** oder **<Alt-x>** funktionieren damit unabhängig von der Tastaturbelegung, so wie Tastaturkürzel in anderen Windows-Anwendungen. Die Substitution **%A** bleibt davon unberührt und liefert weiter das Zeichen der aktuellen Belegung.

Unter X11 ist der Keysym des Ereignisses der, den die aktuelle Tastaturbelegung (XKB-Gruppe) der Taste zuweist. Ist **Control** oder **Alt** gedrückt und dieser Keysym kein Latin-1-Zeichen (zum Beispiel bei kyrillischer oder griechischer Belegung), wird stattdessen der Keysym derselben Taste in einer lateinischen Belegung verwendet, sofern die Tastatur eine hat. Bindings wie **<Control-c>** oder **<Alt-x>** funktionieren damit unabhängig von der Tastaturbelegung, so wie Tastaturkürzel in anderen X11-Toolkits. Die Substitution **%A** bleibt davon unberührt.

# Binding-Skripte und Substitutionen

Das *script*-Argument von **bind** ist ein Tcl-Script, das „Binding-Script“ genannt wird und ausgeführt wird, wann immer die gegebene Ereignissequenz auftritt. *Command* wird im selben Interpreter ausgeführt, in dem der Befehl **bind** ausgeführt wurde, und auf globaler Ebene (nur globale Variablen sind zugänglich). Enthält *script* **%**-Zeichen, wird das Script nicht direkt ausgeführt. Stattdessen wird ein neues Script erzeugt, indem jedes **%** und das darauf folgende Zeichen durch Informationen aus dem aktuellen Ereignis ersetzt werden. Die Ersetzung hängt vom Zeichen nach dem **%** ab, wie in der folgenden Liste definiert. Sofern nicht anders angegeben, ist die Ersetzungszeichenkette der Dezimalwert des angegebenen Feldes aus dem aktuellen Ereignis. Einige Substitutionen gelten nur für bestimmte Ereignistypen; werden sie für andere Ereignistypen verwendet, ist der substituierte Wert undefiniert.

**%%**
: Wird durch ein einzelnes Prozentzeichen ersetzt.

**%#**
: Die Nummer der letzten vom Server verarbeiteten Client-Anfrage (das Feld *serial* aus dem Ereignis). Gültig für alle Ereignistypen.

**%a**
: Das Feld *above* aus dem Ereignis, formatiert als hexadezimale Zahl. Nur gültig für **Configure**-Ereignisse. Gibt das Geschwisterfenster unmittelbar unter dem empfangenden Fenster in der Stapelreihenfolge an, oder **0**, wenn das empfangende Fenster unten ist.

**%b**
: Die Nummer der gedrückten oder losgelassenen Taste. Nur gültig für **Button**- und **ButtonRelease**-Ereignisse.

**%c**
: Das Feld *count* aus dem Ereignis. Nur gültig für **Expose**-Ereignisse. Zeigt an, dass *count* ausstehende **Expose**-Ereignisse vorliegen, die dem Fenster noch nicht zugestellt wurden.

**%d**
: Das Feld *detail* oder *user\_data* aus dem Ereignis. **%d** wird durch eine Zeichenkette ersetzt, die das Detail identifiziert. Für **Enter**-, **Leave**-, **FocusIn**- und **FocusOut**-Ereignisse ist die Zeichenkette eine der folgenden:

    ::: {.info DISPLAY="yes"}
    **NotifyAncestor**	**NotifyNonlinearVirtual**\
    **NotifyDetailNone**	**NotifyPointer**\
    **NotifyInferior**	**NotifyPointerRoot**\
    **NotifyNonlinear**	**NotifyVirtual**
    :::

    Für **ConfigureRequest**-Ereignisse ist die Zeichenkette eine von:

    ::: {.info DISPLAY="yes"}
    **Above**	**Opposite**\
    **Below**	**None**\
    **BottomIf**	**TopIf**
    :::

    Bei virtuellen Ereignissen ist die Zeichenkette der Wert, der beim Erzeugen des Ereignisses (typischerweise mit [event generate][event]) im Feld *user\_data* gespeichert wurde, oder der leere String, wenn das Feld NULL ist. Virtuelle Ereignisse, die Tastensequenz-Drücke entsprechen (siehe [event add][event]), setzen *user\_data* auf NULL. Für andere Ereignisse ist die substituierte Zeichenkette undefiniert.

**%f**
: Das Feld *focus* aus dem Ereignis (**0** oder **1**). Nur gültig für **Enter**- und **Leave**-Ereignisse. **1**, wenn das empfangende Fenster das Fokus-Fenster oder ein Nachfahre des Fokus-Fensters ist, sonst **0**.

**%h**
: Das Feld *height* aus dem Ereignis. Gültig für **Configure**-, **ConfigureRequest**-, **Create**-, **ResizeRequest**- und **Expose**-Ereignisse. Gibt die neue oder angeforderte Höhe des Fensters an.

**%i**
: Das Feld *window* aus dem Ereignis, dargestellt als hexadezimale Ganzzahl. Gültig für alle Ereignistypen.

**%k**
: Das Feld *keycode* aus dem Ereignis. Nur gültig für **Key**- und **KeyRelease**-Ereignisse.

**%m**
: Das Feld *mode* aus dem Ereignis. Die substituierte Zeichenkette ist eine von **NotifyNormal**, **NotifyGrab**, **NotifyUngrab** oder **NotifyWhileGrabbed**. Nur gültig für **Enter**-, **FocusIn**-, **FocusOut**- und **Leave**-Ereignisse.

**%o**
: Das Feld *override\_redirect* aus dem Ereignis. Nur gültig für **Map**-, **Reparent**- und **Configure**-Ereignisse.

**%p**
: Das Feld *place* aus dem Ereignis, substituiert als eine der Zeichenketten **PlaceOnTop** oder **PlaceOnBottom**. Nur gültig für **Circulate**- und **CirculateRequest**-Ereignisse.

**%s**
: Das Feld *state* aus dem Ereignis. Für **Button**-, **ButtonRelease**-, **Enter**-, **Key**-, **KeyRelease**-, **Leave**- und **Motion**-Ereignisse wird eine Dezimalzeichenkette substituiert. Für **Visibility** eine von **VisibilityUnobscured**, **VisibilityPartiallyObscured** und **VisibilityFullyObscured**. Für **Property**-Ereignisse entweder **NewValue** (Property wurde erstellt oder geändert) oder **Delete** (Property wurde entfernt).

**%t**
: Das Feld *time* aus dem Ereignis. Dies ist der X-Server-Zeitstempel (typischerweise die Zeit seit dem letzten Server-Reset) in Millisekunden, als das Ereignis auftrat. Gültig für die meisten Ereignisse.

**%w**
: Das Feld *width* aus dem Ereignis. Gibt die neue oder angeforderte Breite des Fensters an. Nur gültig für **Configure**-, **ConfigureRequest**-, **Create**-, **ResizeRequest**- und **Expose**-Ereignisse.

**%x**, **%y**
: Die Felder *x* und *y* aus dem Ereignis. Für **Button**-, **ButtonRelease**-, **Motion**-, **Key**-, **KeyRelease**- und **MouseWheel**-Ereignisse geben **%x** und **%y** die Position des Mauszeigers relativ zum empfangenden Fenster an. Bei Tastenereignissen auf dem Macintosh sind dies die Mauskoordinaten im Moment, in dem ein X11-KeyEvent an Tk gesendet wird, was etwas später als der physische Druck oder das Loslassen sein kann. Für **Enter**- und **Leave**-Ereignisse die Position, an der der Mauszeiger das Fenster gekreuzt hat, relativ zum empfangenden Fenster. Für **Configure**- und **Create**-Anfragen die *x*- und *y*-Koordinaten des Fensters relativ zum Parent-Fenster.

**%A**
: Substitutiert das dem Ereignis entsprechende UNICODE-Zeichen oder den leeren String, wenn das Ereignis keinem UNICODE-Zeichen entspricht (z.B. wenn die Umschalttaste gedrückt wurde). Unter X11 übernimmt **XmbLookupString** (oder **XLookupString**, wenn Input-Method-Unterstützung aus ist) die Übersetzung vom Ereignis zum UNICODE-Zeichen. Unter X11 nur gültig für **Key**-Ereignisse. Unter Windows und macOS/aqua nur gültig für **Key**- und **KeyRelease**-Ereignisse.

**%B**
: Das Feld *border\_width* aus dem Ereignis. Nur gültig für **Configure**-, **ConfigureRequest**- und **Create**-Ereignisse.

**%D**
: Meldet den *delta*-Wert eines **MouseWheel**-Ereignisses. Der *delta*-Wert gibt die Dreheinheiten des Mausrads an. Das Vorzeichen gibt die Scroll-Richtung an.

**%E**
: Das Feld *send\_event* aus dem Ereignis. Gültig für alle Ereignistypen. **0** bedeutet ein „normales“ Ereignis, **1** ein „synthetisches“ Ereignis, erzeugt durch **SendEvent**.

**%K**
: Der dem Ereignis entsprechende Keysym, substituiert als Textzeichenkette. Nur gültig für **Key**- und **KeyRelease**-Ereignisse.

**%M**
: Die Anzahl der bisher für das Ereignis passenden script-basierten Binding-Muster. Gültig für alle Ereignistypen.

**%N**
: Der dem Ereignis entsprechende Keysym, substituiert als Dezimalzahl. Nur gültig für **Key**- und **KeyRelease**-Ereignisse.

**%P**
: Der Name der aktualisierten oder gelöschten Property (kann mit [winfo atom][winfo] in ein XAtom umgewandelt werden). Nur gültig für **Property**-Ereignisse.

**%R**
: Die *root*-Fensterkennung aus dem Ereignis. Nur gültig für Ereignisse mit einem *root*-Feld.

**%S**
: Die *subwindow*-Fensterkennung aus dem Ereignis, formatiert als hexadezimale Zahl. Nur gültig für Ereignisse mit einem *subwindow*-Feld.

**%T**
: Das Feld *type* aus dem Ereignis. Gültig für alle Ereignistypen.

**%W**
: Der Pfadname des Fensters, an das das Ereignis gemeldet wurde (das Feld *window* aus dem Ereignis). Gültig für alle Ereignistypen.

**%X**, **%Y**
: Die Felder *x\_root* und *y\_root* aus dem Ereignis. Bei einem Virtual-Root-Window-Manager sind die substituierten Werte die entsprechenden x- und y-Koordinaten im virtuellen Root. Nur gültig für **Button**-, **ButtonRelease**-, **Enter**-, **Key**-, **KeyRelease**-, **Leave**- und **Motion**-Ereignisse. Dieselbe Bedeutung wie **%x** und **%y**, jedoch relativ zum (virtuellen) Root-Fenster.


Die Ersetzungszeichenkette für eine %-Ersetzung wird als gültiges Tcl-Listenelement formatiert. Leerzeichen oder Sonderzeichen wie **$** und **{** können mit Backslashes versehen werden. So wird sichergestellt, dass die Zeichenkette beim Auswerten des Binding-Scripts durch den Tcl-Parser geht. Die meisten Ersetzungen sind Zahlen oder wohldefinierte Zeichenketten wie **Above**; für diese ist keine spezielle Formatierung nötig. Am häufigsten tritt Neuformatierung bei der Substitution **%A** auf. Wenn *script* zum Beispiel

```
insert %A
```

ist und die eingegebene Taste eine öffnende eckige Klammer ist, wird tatsächlich ausgeführt:

```
insert \[
```

Dadurch erhält **insert** die ursprüngliche Ersetzungszeichenkette (öffnende eckige Klammer) als erstes Argument. Ohne den zusätzlichen Backslash könnte Tcl das Script nicht korrekt parsen.

# Mehrere Treffer

Es ist möglich, dass mehrere Bindings auf ein gegebenes X-Ereignis passen. Sind die Bindings verschiedenen *tag*-Werten zugeordnet, wird jedes Binding der Reihe nach ausgeführt. Standardmäßig wird zuerst ein Binding für das Widget ausgeführt, gefolgt von einem Klassen-Binding, einem Binding für sein Toplevel und einem **all**-Binding. Mit dem Befehl [bindtags] kann diese Reihenfolge für ein bestimmtes Fenster geändert oder zusätzliche Binding-Tags zugeordnet werden.

Die Befehle [continue] und [break] können innerhalb eines Binding-Scripts verwendet werden, um die Verarbeitung passender Scripts zu steuern. Wird [continue] in einem Binding-Script aufgerufen, wird dieses Binding-Script einschließlich aller mit „+“ angehängten Scripts beendet, Tk verarbeitet jedoch weiter Binding-Scripts, die anderen *tag*-Werten zugeordnet sind. Wird [break] in einem Binding-Script aufgerufen, endet dieses Script und es werden keine weiteren Scripts für das Ereignis aufgerufen.

In einem vom Binding-Script aufgerufenen Script kann [return] **-code ok** die Verarbeitung fortsetzen (einschließlich mit „+“ angehängter Scripts), oder [return] **-code break** die Verarbeitung aller anderen Binding-Scripts stoppen.

Passen mehrere Bindings auf ein bestimmtes Ereignis und haben dasselbe *tag*, wird das spezifischste Binding gewählt und dessen Script ausgewertet. Zur Bestimmung, welche von mehreren passenden Sequenzen spezifischer ist, werden nacheinander folgende Tests angewendet:

(a)
: Ein Ereignismuster, das eine bestimmte Maustaste oder Taste angibt, ist spezifischer als eines ohne solche Angabe;

(b)
: Eine Sequenz mit den höchststufigsten Mustern (im Sinne der höchsten Wiederholungsanzahl) ist spezifischer als eine Sequenz mit weniger höchststufigen Mustern;

(c)
: Sind die Modifizierer eines Musters eine Teilmenge der Modifizierer eines anderen Musters, ist das Muster mit mehr Modifizierern spezifischer;

(d)
: Ein virtuelles Ereignis, dessen physisches Muster auf die Sequenz passt, ist weniger spezifisch als dasselbe physische Muster ohne Zuordnung zu einem virtuellen Ereignis;

(e)
: Passt eine Sequenz auf zwei oder mehr virtuelle Ereignisse, wird eines der virtuellen Ereignisse gewählt, die Reihenfolge ist jedoch undefiniert.


Enthalten die passenden Sequenzen mehr als ein Ereignis, werden die Tests (c)–(e) in der Reihenfolge vom jüngsten zum ältesten Ereignis in den Sequenzen angewendet. Bestimmen diese Tests keinen Sieger, gewinnt die zuletzt registrierte Sequenz.

Gibt es zwei (oder mehr) virtuelle Ereignisse, die durch dieselbe Sequenz ausgelöst werden, und sind beide an dasselbe Fenster-Tag gebunden, wird nur eines der virtuellen Ereignisse ausgelöst, und zwar zufällig gewählt:

```
event add <<Paste>> <Control-y>
event add <<Paste>> <Button-2>
event add <<Scroll>> <Button-2>
bind Entry <<Paste>> {puts Paste}
bind Entry <<Scroll>> {puts Scroll}
```

Tippt der Benutzer Control-y, wird das Binding **<<Paste>>** aufgerufen; drückt er Taste 2, wird eines der Bindings **<<Paste>>** oder **<<Scroll>>** aufgerufen — welches genau, ist undefiniert.

Passt ein X-Ereignis auf keines der vorhandenen Bindings, wird es ignoriert. Ein ungebundenes Ereignis gilt nicht als Fehler.

# Mehrere-Ereignis-Sequenzen und ignorierte Ereignisse

Enthält eine in einem **bind**-Befehl angegebene *sequence* mehr als ein Ereignismuster, wird ihr Script ausgeführt, wann immer die jüngsten Ereignisse (bis einschließlich des aktuellen) auf die gegebene Sequenz passen. Das bedeutet z.B., dass bei wiederholtem Klick auf Taste 1 die Sequenz **<Double-Button-1>** auf jeden Tastendruck außer den ersten passt. Treten in der Mitte einer Ereignissequenz überflüssige Ereignisse auf, die eine Übereinstimmung verhindern würden, werden diese ignoriert, es sei denn, es sind **Key**- oder **Button**-Ereignisse. Zum Beispiel passt **<Double-Button-1>** auf eine Folge von Drücken von Taste 1, auch wenn zwischen den **Button**-Ereignissen **ButtonRelease**-Ereignisse (und ggf. **Motion**-Ereignisse) liegen. Außerdem kann ein **Key**-Ereignis von beliebig vielen anderen **Key**-Ereignissen für Modifizierungstasten vorangehen, ohne dass diese eine Übereinstimmung verhindern. Die Ereignissequenz **aB** passt z.B. auf Drücken von **a**, Loslassen von **a**, Drücken von **Shift** und Drücken von **b**: Das Drücken von **Shift** wird ignoriert, weil es eine Modifizierungstaste ist. Treten schließlich mehrere **Motion**-Ereignisse hintereinander auf, wird nur das letzte zum Abgleich von Binding-Sequenzen verwendet.

# Fehler

Tritt beim Ausführen des Scripts für ein Binding ein Fehler auf, wird der Fehler über den Mechanismus [bgerror] gemeldet. Der Befehl [bgerror] wird auf globaler Ebene ausgeführt (außerhalb des Kontexts einer Tcl-Prozedur).

# Beispiele

Beim Doppelklick mit der Maus soll eine Zeichenkette mit der Mausbewegung ausgegeben werden:

```
bind . <Double-1> {
    puts "hi from (%x,%y)"
}
```

Eine kleine GUI, die den Keysym-Namen der zuletzt gedrückten Taste anzeigt:

```
set keysym "Press any key"
pack [label .l -textvariable keysym -padx 2m -pady 1m]
bind . <Key> {
    set keysym "You pressed %K"
}
```


[bgerror]: ../tcl/bgerror.md
[bindtags]: bindtags.md
[break]: ../tcl/break.md
[continue]: ../tcl/continue.md
[event]: event.md
[focus]: focus.md
[grid]: grid.md
[menu]: menu.md
[pack]: pack.md
[return]: ../tcl/return.md
[text]: text.md
[winfo]: winfo.md
