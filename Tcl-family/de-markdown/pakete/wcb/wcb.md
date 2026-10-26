# Wcb-Programmierhandbuch

## Für Wcb Version 4.2

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

#### Überblick

- [Einige häufige Probleme](#einige-h-ufige-probleme)
- [Das Paket Wcb](#das-paket-wcb)
- [Woher bekomme ich es?](#woher-bekomme-ich-es)
- [Wie installiere ich es?](#wie-installiere-ich-es)
- [Wie verwende ich es?](#wie-verwende-ich-es)

#### Beispiele

- [Einige before-insert-Rückruffunktionen für entry-Widgets](#einige-before-insert-r-ckruffunktionen-f-r-entry-widgets)
- [Eine selset-Rückruffunktion für ein listbox-Widget](#eine-selset-r-ckruffunktion-f-r-ein-listbox-widget)
- [Eine activate-Rückruffunktion für ein listbox-Widget](#eine-activate-r-ckruffunktion-f-r-ein-listbox-widget)
- [Sieben Rückruffunktionen für ein text-Widget](#sieben-r-ckruffunktionen-f-r-ein-text-widget)

[Startseite](index.md)

---

## Überblick

### Einige häufige Probleme

Viele, die mit Tcl/Tk programmieren, stehen vor Fragen wie diesen:

- Wie schränkt man die Menge der Zeichen ein, die der Benutzer in ein Tk- oder Ttk-entry, ein BWidget Entry, eine Tk- oder Ttk-spinbox, eine Ttk-combobox, ein text- oder ein ctext-Widget tippen oder einfügen kann?
- Wie bearbeitet man die eingegebenen Zeichen, bevor sie in eines dieser Widgets eingefügt werden? Bei einem text- oder ctext-Widget: Wie ändert man Schrift, Farben oder andere Attribute der eingegebenen Zeichen?
- Wie setzt man eine Obergrenze für die Anzahl der Zeichen, die in ein Tk- oder Ttk-entry, ein BWidget Entry, eine Tk- oder Ttk-spinbox oder eine Ttk-combobox getippt oder eingefügt werden können?
- Wie schützt man Teile des Textes in einem Tk- oder Ttk-entry, einem BWidget Entry, einer Tk- oder Ttk-spinbox, einer Ttk-combobox, einem text- oder einem ctext-Widget davor, vom Benutzer geändert zu werden?
- Wie legt man Benachrichtigungen fest, die automatisch ausgelöst werden, nachdem Text in eines dieser Widgets eingefügt oder daraus gelöscht wurde?
- Wie legt man Aktionen fest, die automatisch aufgerufen werden, sobald die Einfügemarke in einem Tk- oder Ttk-entry, einem BWidget Entry, einer Tk- oder Ttk-spinbox, einer Ttk-combobox, einem text- oder einem ctext-Widget verschoben wird?
- Wie legt man einen Befehl fest, der automatisch aufgerufen wird, wenn ein listbox-Element, eine Tablelist-Zeile oder -Zelle, ein Ttk-treeview-Element oder ein Zeichenbereich in einem text- oder ctext-Widget ausgewählt wird?
- Wie schützt man beliebige oder alle Einträge eines listbox-, tablelist- oder Ttk-treeview-Widgets oder einen Zeichenbereich in einem text- oder ctext-Widget davor, ausgewählt zu werden?

In den meisten Büchern, FAQs, Newsgruppen-Beiträgen und Widget-Sammlungen finden Sie *einzelne* Lösungen für einige dieser Probleme über Widget-Bindungen. Dieser Weg fügt neue Bindungs-Tags hinzu oder ändert vorhandene, und er erweist sich recht oft als unvollständig.

Der Tk-Kern behandelt nur wenige dieser Probleme: In Tk 8.1 kam das virtuelle Ereignis `<<ListboxSelect>>` für listbox-Widgets hinzu, Tk ab Version 8.3 unterstützt Widget-Optionen zur Prüfung von entry-Widgets, und das spinbox-Widget (seit Tk 8.4) bietet dieselbe Prüfmöglichkeit. Tk ab Version 8.4 unterstützt außerdem den Zustand `disabled` für listbox-Widgets sowie das Kennzeichen `modified`, die virtuellen Ereignisse `<<Modified>>` und `<<Selection>>` und einen Rückgängig-/Wiederholen-Mechanismus für text-Widgets. Auch diese Verbesserungen sind aber *einzelner* Art.

### Das Paket Wcb

Das Paket Wcb (**W**idget **c**all**b**ack, Widget-Rückruffunktion) bietet eine ganz andere, *allgemeine* Lösung für die genannten Probleme: Es definiert den Tcl-Befehl des Widgets neu. Die zentrale Prozedur `wcb::callback` lässt Sie beliebige Befehle mit bestimmten Operationen von Tk-entry-, Ttk-entry-, BWidget-Entry-, Tk-spinbox-, Ttk-spinbox-, Ttk-combobox-, listbox-, tablelist-, Ttk-treeview-, text- und ctext-Widgets verbinden. Diese Befehle werden automatisch im globalen Geltungsbereich aufgerufen, sobald die jeweilige Widget-Operation ausgeführt wird. Sie können verlangen, dass die Befehle vor oder nach der Widget-Operation laufen, Sie können also **before-** und **after-Rückruffunktionen** festlegen. Aus einer before-Rückruffunktion können Sie den Widget-Befehl mit der Prozedur `wcb::cancel` abbrechen oder seine Argumente mit `wcb::extend` oder `wcb::replace` ändern.

Neben diesen und vier weiteren allgemeinen Befehlen stellt das Paket Wcb vier Hilfsprozeduren für Tk-entry-, Ttk-entry-, BWidget-Entry-, Tk-spinbox-, Ttk-spinbox- und Ttk-combobox-Widgets bereit, außerdem einige before-`insert`-Rückruffunktionen für [Tk-entry-, Ttk-entry-, BWidget-Entry-, Tk-spinbox-, Ttk-spinbox- und Ttk-combobox-Widgets](wcbRef.md#before-insert-r-ckruffunktionen-f-r-entry-spinbox-und-combobox-widgets) sowie für [text- und ctext-Widgets](wcbRef.md#before-insert-r-ckruffunktionen-f-r-text-und-ctext-widgets). Sie können sie unverändert verwenden oder an Ihren Bedarf anpassen. Wie das geht, steht im Abschnitt [Beispiele](#beispiele) unten.

Das Paket Wcb ist in reinem Tcl/Tk geschrieben. Es ist dadurch vollständig plattformunabhängig und sehr einfach zu installieren. Es braucht Tcl und Tk in Version 8.4 oder höher.

### Woher bekomme ich es?

Wcb steht auf dieser Webseite zum freien Herunterladen:

https://www.nemethi.de

Die Distributionsdatei heißt `wcb4.2.tar.gz` für UNIX und `wcb4_2.zip` für Windows. Beide Dateien enthalten dieselben Angaben, abgesehen von dem zusätzlichen Wagenrücklaufzeichen vor dem Zeilenvorschub am Ende jeder Zeile in den Textdateien für Windows.

Wcb ist auch in tklib enthalten, unter der Adresse

https://core.tcl.tk/tklib

### Wie installiere ich es?

Installieren Sie das Paket als Unterverzeichnis eines der Verzeichnisse, die durch die Variable `auto_path` angegeben sind. Sie können es beispielsweise als Unterverzeichnis des Verzeichnisses `lib` innerhalb Ihrer Tcl/Tk-Installation installieren.

Um Wcb *unter UNIX* zu installieren, wechseln Sie mit `cd` in das gewünschte Verzeichnis und packen die Distributionsdatei `wcb4.2.tar.gz` aus:

```
gunzip -c wcb4.2.tar.gz | tar -xf -
```

Auf den meisten UNIX-Systemen kann dies durch Folgendes ersetzt werden:

```
tar -zxf wcb4.2.tar.gz
```

Beide Befehle legen ein Verzeichnis namens `wcb4.2` an, mit den Unterverzeichnissen `demos`, `doc` und `scripts`.

*Unter Windows* packen Sie die Distributionsdatei `wcb4_2.zip` mit WinZip oder einem anderen geeigneten Programm in das Verzeichnis `wcb4.2` aus, mit den Unterverzeichnissen `demos`, `doc` und `scripts`.

Beachten Sie, dass tklib das Wcb-Verzeichnis `demos` durch das Unterverzeichnis `wcb` des Verzeichnisses `examples` ersetzt. Bitte berücksichtigen Sie das, wenn Sie die [Beispiele](#beispiele) unten lesen.

### Wie verwende ich es?

Damit Ihre Skripte auf die Befehle und Variablen des Pakets Wcb zugreifen können, müssen sie eine dieser Zeilen enthalten:

```
package require wcb ?version?
package require Wcb ?version?
```

Sie können jede der beiden Anweisungen verwenden, weil die Datei `wcb.tcl` beide Zeilen enthält:

```
package provide wcb ...
package provide Wcb ...
```

Sie können eine der beiden Zeilen aus `wcb.tcl` entfernen, wenn das Paket sich nicht unter zwei verschiedenen Namen bekannt machen soll. Damit beschränken Sie das Argument von `package require` natürlich auf einen einzigen Namen.

Weil das Paket Wcb in einem eigenen Namensraum namens `wcb` liegt, müssen Sie entweder den Befehl

```
namespace import wcb::pattern ?wcb::pattern ...?
```

aufrufen, um die benötigten *Prozeduren* zu importieren, oder qualifizierte Namen wie `wcb::callback` verwenden. In den Beispielen unten ist der zweite Weg gewählt.

Auf Wcb-*Variablen* müssen Sie mit qualifizierten Namen zugreifen. Nur zwei Wcb-Variablen sind dafür gedacht, außerhalb des Namensraums `wcb` gelesen zu werden:

- Die Variable `wcb::version` enthält die aktuelle Versionsnummer des Pakets Wcb.
- Die Variable `wcb::library` enthält den Ort des Wcb-Installationsverzeichnisses.

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Beispiele

### Einige before-`insert`-Rückruffunktionen für entry-Widgets

Das Skript `entrytest.tcl` im Verzeichnis `demos` erzeugt drei entry-Widgets mit den Einschränkungen der folgenden Abbildung:

![entrytest](entrytest.png)

Für das oberste entry-Widget `.e1` legen wir zwei before-`insert`-Rückruffunktionen aus dem Paket Wcb fest:

```
wcb::callback .e1 before insert wcb::checkStrForAlnum \
                                wcb::convStrToUpper
```

Damit das zweite entry-Widget `.e2` nur ganze Zahlen mit höchstens 10 Zeichen annimmt, verwenden wir wieder zwei before-`insert`-Rückruffunktionen aus Wcb:

```
wcb::callback .e2 before insert {wcb::checkEntryLen 10} \
                                 wcb::checkEntryForInt
```

Und schließlich die beiden Rückruffunktionen für das dritte entry-Widget `.e3`:

```
wcb::callback .e3 before insert {wcb::checkEntryLen 10} \
                                 checkNumber

#
# Callback procedure checkNumber
#
proc checkNumber {w idx str} {
    set newText [wcb::postInsertEntryText $w $idx $str]
    if {![regexp {^[0-9]*\.?[0-9]?[0-9]?$} $newText]} {
        wcb::cancel
    }
}
```

Dieses letzte Beispiel zeigt auch die Argumente der Rückruffunktionen, die mit dem Befehl `wcb::callback` festgelegt werden: Wird eine Rückruffunktion aufgerufen, werden der neue Name des ursprünglichen Tcl-Befehls des Widgets (also der Name des Proxy-Befehls) und die Argumente der jeweiligen Widget-Operation automatisch als Parameter angehängt. Weil wir `checkNumber` als before-Rückruffunktion für den Unterbefehl `insert` festgelegt haben, müssen seine letzten drei Argumente sein: der Name des Proxy-Widget-Befehls (`w`, hier `::_.e3`), der Index (`idx`) und die Zeichenkette (`str`), die unmittelbar vor dem Zeichen eingefügt werden soll, das der Index bezeichnet.

Beachten Sie, dass in der Argumentliste einer Wcb-Rückruffunktion dem Namen des Proxy-Widget-Befehls beliebig viele zusätzliche Argumente vorangestellt sein können. Die Prozedur `wcb::checkEntryLen` ist ein Beispiel für eine solche Rückruffunktion.

Der Befehl `wcb::postInsertEntryText`, den die Prozedur `checkNumber` aufruft, gibt den Text zurück, den das entry-Widget `w` enthielte, nachdem die Zeichenkette `str` vor dem Zeichen eingefügt wurde, das der Index `idx` bezeichnet. Ist dieser Text nicht der Anfang einer vorzeichenlosen reellen Zahl mit höchstens zwei Stellen nach dem Dezimalpunkt, rufen wir die Prozedur `wcb::cancel` auf, die den Befehl `insert` abbricht.

Ohne die Einschränkung, dass der Inhalt des dritten entry-Widgets nicht mit einem Vorzeichen beginnen darf, hätten wir statt `checkNumber` die Rückruffunktion `wcb::checkEntryForFixed` verwenden können:

```
wcb::callback .e3 before insert {wcb::checkEntryLen 10} \
                                {wcb::checkEntryForFixed 2}
```

### Eine `selset`-Rückruffunktion für ein listbox-Widget

Bei einer listbox werden Sie wahrscheinlich am häufigsten eine Rückruffunktion für den Widget-Unterbefehl `selection set` festlegen wollen. Meist ist es egal, ob das eine before- oder eine after-Rückruffunktion ist. Der Befehl `wcb::callback` erwartet als Parameter die Kurzform `selset`. Entsprechend müssen Sie `selclear` übergeben, wenn Sie eine Rückruffunktion für die listbox-Operation `selection clear` festlegen.

Im folgenden Beispiel bauen wir eine listbox `.lb` mit den Namen der Bitmap-Dateien im Unterverzeichnis `images` des Wcb-Verzeichnisses `demos`. Das Verzeichnis `images` ist eine Kopie des gleichnamigen Unterverzeichnisses des Tk-8.6-Verzeichnisses `demos`. Wird ein Eintrag ausgewählt, zeigt die Rückruffunktion `showBitmap` die zugehörige Bitmap in der Beschriftung `.picture`.

![listboxtest1](listboxtest1.png)

Hier der maßgebliche Ausschnitt aus dem Skript `listboxtest1.tcl` im Verzeichnis `demos`:

```
set dirName [file join [file dirname [info script]] images]

#
# Frame .spacer and listbox .lb
#
frame .spacer -width 7p
listbox .lb -height 0 -width 0 -background white
set pattern [file join $dirName *.xbm]
foreach pathName [lsort [glob $pattern]] {
    .lb insert end [file tail $pathName]
}

#
# Label .picture
#
label .picture -relief sunken -background white

#
# Define a before-selset callback for .lb
#
wcb::callback .lb before selset showBitmap

#
# Callback procedure showBitmap
#
proc showBitmap {w first args} {
    global dirName
    set pathName [file join $dirName [$w get $first]]
    .picture configure -bitmap @$pathName
}
```

Zur Erinnerung: Die listbox-Operation `selection set` nimmt ein oder zwei Indizes als Argumente. Sie werden der Rückruffunktion automatisch als Parameter übergeben, zusammen mit dem neuen Namen des ursprünglichen Tcl-Befehls des listbox-Widgets, also dem Namen des Proxy-Befehls. Deshalb sind die Argumente der Rückruffunktion `showBitmap`: der Name des Proxy-Widget-Befehls (`w`, hier `::_.lb`), der erste Index (`first`) und das Schlüsselwort `args`, das für die leere Liste oder den optionalen zweiten Index steht, der an `selection set` übergeben wurde.

### Eine `activate`-Rückruffunktion für ein listbox-Widget

Die listbox des vorigen Beispiels hat den Vorgabe-Auswahlmodus `browse`. Die before-`selset`-Rückruffunktion `showBitmap` läuft deshalb jedes Mal, wenn die Maus bei gedrückter Taste 1 von einem Element zu einem anderen gezogen wird. Was aber, wenn wir nicht nur die Bitmaps anzeigen wollen, sondern auch die Fotobilder im Unterverzeichnis `images` des Wcb-Verzeichnisses `demos`? Ein Fotobild zu laden ist deutlich aufwendiger als eine Bitmap zu laden. Einige Bilder lassen sich dann nicht schnell genug anzeigen, um der Maus zu folgen, wenn man mit ihr in der listbox blättert.

![listboxtest2](listboxtest2.png)

Um das zu lösen, können wir den Auswahlmodus auf den selteneren Wert `single` setzen oder dafür sorgen, dass die Bilder nicht beim Blättern mit der Maus angezeigt werden, sondern beim Loslassen der Taste 1. Der zweite Weg lässt sich mit einer `activate`-Rückruffunktion umsetzen, wie der folgende Ausschnitt aus dem Skript `listboxtest2.tcl` im Verzeichnis `demos` zeigt:

```
set dirName [file join [file dirname [info script]] images]
image create photo photoImage

#
# Frame .spacer and listbox .lb
#
frame .spacer -width 7p
listbox .lb -height 0 -width 0 -background white
set pattern [file join $dirName *]
foreach pathName [lsort [glob $pattern]] {
    .lb insert end [file tail $pathName]
}

#
# Label .picture
#
label .picture -relief sunken -background white

#
# Define a before-activate callback for .lb
#
wcb::callback .lb before activate showPicture

#
# Callback procedure showPicture
#
proc showPicture {w idx} {
    set leafName [$w get $idx]

    #
    # When traversing the listbox with the arrow keys, the value
    # of idx can become -1 or the number of listbox elements,
    # hence the value of leafName can be an empty string:
    #
    if {$leafName eq ""} {
        return ""
    }

    global dirName
    set pathName [file join $dirName $leafName]
    if {[regexp {^\.(bmp|xbm)$} [file extension $pathName]]} {
        .picture configure -bitmap @$pathName -image ""
    } else {
        .picture configure -bitmap "" -image ""
        catch {
            photoImage configure -file $pathName
            .picture configure -bitmap "" -image photoImage
        }
    }
}
```

### Sieben Rückruffunktionen für ein text-Widget

Das Skript `texttest1.tcl` im Verzeichnis `demos` erzeugt das text-Widget der folgenden Abbildung:

![texttest1](texttest1.png)

Hier der maßgebliche Ausschnitt:

```
#
# Text .txt
#
set width 50
text .txt -width $width -height 12 -setgrid true -wrap none -background white \
          -font TkFixedFont
.txt tag configure prog -foreground red
.txt tag configure user -foreground DarkGreen
.txt insert end "Everything you type or paste into this window will\n"  prog
.txt insert end "be displayed in dark green.  You cannot make any\n"    prog
.txt insert end "changes or selections in this red area, and will\n"    prog
.txt insert end "not be able to send the message as long as any\n"      prog
.txt insert end "line contains more than $width characters.\n"          prog
.txt insert end "--------------------------------------------------\n"  prog
set limit [.txt index insert]

#
# Label .pos displaying the current cursor position
#
label .pos -textvariable pos

#
# Button .send (actually, it does not send anything)
#
button .send -text Send -command exit

#
# Define 5 before- and 2 after-callbacks for .txt
#
wcb::callback .txt before insert protectRedArea changeColor
wcb::callback .txt before delete protectRedArea
wcb::callback .txt before selset protectRedArea
wcb::callback .txt before motion displayPos
wcb::callback .txt  after insert "checkLines $width"
wcb::callback .txt  after delete "checkLines $width"

#
# Callback procedure protectRedArea
#
# The parameters following w can be interpreted either as
# "index string ?tagList string tagList ...?" (for an insert
# callback), or as "from ?to?" (for a delete callback),
# or as "from ?to from to ...?" (for a selset callback).
#
proc protectRedArea {w idx args} {
    global limit
    if {[$w compare $idx < $limit]} {
        wcb::cancel
    }
}

#
# Callback procedure changeColor
#
proc changeColor {w args} {
    wcb::extend user
}

#
# Callback procedure displayPos
#
proc displayPos {w idx} {
    set index [$w index $idx]
    scan $index "%d.%d" line column
    incr column

    global pos
    set pos [format "Line: %d   Column: %d" $line $column]
}

#
# Callback procedure checkLines
#
# The parameter args can be interpreted both as "index
# string ?tagList string tagList ...?" (for an insert
# callback) and as "from ?to?" (for a delete callback).
#
proc checkLines {maxCharsPerLine w args} {
    #
    # Display the new cursor position
    #
    displayPos $w insert

    #
    # Disable or enable the .send button
    #
    scan [$w index end] "%d" lastLine
    for {set line 1} {$line < $lastLine} {incr line} {
        scan [$w index $line.end] "%d.%d" dummy charsInLine
        if {$charsInLine > $maxCharsPerLine} {
            .send configure -state disabled
            return ""
        }
    }
    .send configure -state normal
}

. . .

displayPos .txt insert
focus .txt
```

Die Prozedur `protectRedArea` ist eine before-`insert`-, before-`delete`- und before-`selset`-Rückruffunktion. Sie prüft, ob die versuchte Änderung den rot dargestellten Textbereich beträfe. Ist das der Fall, ruft sie die Prozedur `wcb::cancel` auf, die den Befehl `insert`, `delete` bzw. `tag add sel` abbricht.

Die before-`insert`-Rückruffunktion `changeColor` ruft den Befehl `wcb::extend` auf, um das Tag `user` an die Argumentliste des Befehls `insert` anzuhängen. Die Vordergrundfarbe der vom Benutzer eingegebenen Zeichen wird dadurch `DarkGreen`.

Die Prozedur `displayPos` zeigt Zeile und Spalte zu dem Index, der ihr als zweites Argument übergeben wird. Dieser Index ist die Zielposition der Einfügemarke, wenn die Prozedur automatisch als before-`motion`-Rückruffunktion ausgelöst wird. Wie die unten besprochene Prozedur `checkLines` zeigt, wird sie auch nach einer `insert`- oder `delete`-Operation aufgerufen. Dann ist ihr zweites Argument die neue Position der Einfügemarke nach der Ausführung von `insert` oder `delete`. So lässt sich die Position der Einfügemarke vollständig verfolgen.

Es ist aufschlussreich, was geschieht, wenn wir `displayPos` als after- statt als before-`motion`-Rückruffunktion eintragen. In dem Fall müsste die Prozedur ihr zweites Argument ignorieren, und wir müssten die Zeile

```
set index [$w index $idx]
```

ersetzen durch

```
set index [$w index insert]
```

Der Grund: Der Wert des Arguments `idx`, das an `displayPos` übergeben wird, kann zum Beispiel `insert+1c` sein. Dabei meint `insert` die Position der Einfügemarke, *bevor* sie um ein Zeichen nach vorn rückt. Die after-`motion`-Rückruffunktion wird aber *nach* dem Verschieben der Einfügemarke ausgelöst, und dann zeigt die Marke `insert` bereits auf die neue Cursorposition. Deshalb reicht `[$w index $idx]` in einer after-`motion`-Rückruffunktion nicht, um die Position der Einfügemarke zu ermitteln.

Unsere letzte Prozedur `checkLines` ist sowohl eine after-`insert`- als auch eine after-`delete`-Rückruffunktion. Nach dem Aufruf von `displayPos`, der die neue Cursorposition anzeigt, schaltet sie die Schaltfläche `.send` aus oder ein, je nachdem, ob irgendeine Zeile des text-Widgets mehr als `$maxCharsPerLine` Zeichen enthält.

Beachten Sie, dass wir auch before-`replace`- und after-`replace`-Rückruffunktionen für den text-Widget-Unterbefehl `replace` hätten festlegen können, der in Tk 8.6 hinzukam. Das ist aber nicht nötig, weil die Vorgabebindungen des text-Widgets diesen Unterbefehl derzeit nicht verwenden.

Statt die Schaltfläche `.send` nur auszuschalten, wenn irgendeine Zeile mehr als `$maxCharsPerLine` Zeichen hat, können wir den Benutzer sogar daran hindern, längere Zeilen einzugeben, als erlaubt sind. Das Skript `texttest2.tcl` im Verzeichnis `demos` zeigt, wie das gelingt, wenn Widget-Rückruffunktionen mit dem Rückgängig-Mechanismus für text-Widgets verbunden werden. Dieses Skript erzeugt das text-Widget der folgenden Abbildung:

![texttest2](texttest2.png)

Der größte Teil des Codes in `texttest2.tcl` ist mit dem vorigen Beispiel identisch. Der wesentliche Unterschied ist eine neue Zeile, die den Rückgängig-Mechanismus für das text-Widget `.txt` einschaltet, und eine neue Fassung der Rückruffunktion `checkLines`:

```
. . .

.txt configure -undo yes

. . .

proc checkLines {maxCharsPerLine w args} {
    #
    # Undo the last insert or delete action if necessary
    #
    scan [$w index end] "%d" lastLine
    for {set line 1} {$line < $lastLine} {incr line} {
        scan [$w index $line.end] "%d.%d" dummy charsInLine
        if {$charsInLine > $maxCharsPerLine} {
            $w edit undo
            bell
            break
        }
    }

    #
    # Clear the undo and redo stacks, and display the new cursor position
    #
    $w edit reset
    displayPos $w insert
}

. . .
```

Diese Fassung der Rückruffunktion `checkLines` macht die letzte Bearbeitungsaktion rückgängig, wenn irgendeine Textzeile mehr Zeichen enthält als das erlaubte Maximum. Deshalb mussten wir den Aufruf der Prozedur `displayPos` ans Ende der Rückruffunktion verschieben, weil der Befehl `edit undo` die Position der Einfügemarke ändern kann.

Dieses Beispiel ließe sich auch ohne den Rückgängig-Mechanismus für text-Widgets umsetzen, indem man den zuletzt angenommenen Inhalt des Widgets zusammen mit der Cursorposition speichert und beides wiederherstellt, falls eine Zeile länger wird als erlaubt.

[Inhalt](#inhalt)     [Startseite](index.md)
