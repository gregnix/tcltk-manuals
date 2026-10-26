---
CommandName: snitfaq
title: snitfaq
ManualSection: n
Version: 2.2
TclPart: tcllib
TclDescription: Snit's Not Incr Tcl, OO system
Keywords:
 - BWidget
 - C++
 - Incr Tcl
 - adaptors
 - class
 - mega widget
 - object
 - object oriented
 - widget
 - widget adaptors
Copyright:
 - Copyright (c) 2003-2006, by William H. Duquette
---

# Name

snitfaq – Häufig gestellte Fragen zu Snit

# Beschreibung

# Überblick

## Was ist dieses Dokument?

Dies ist eine ungewöhnliche FAQ-Liste, da nur wenige der darin aufgeführten Fragen tatsächlich häufig gestellt werden. Vielmehr handelt es sich hierbei um Fragen, die meiner Meinung nach ein Neuling bei Snit stellen sollte. Diese Datei stellt jedoch keine vollständige Referenz zu Snit dar; diese Informationen finden Sie auf der Seite **snit**.

## Was ist „snit“?

Snit ist ein Rahmen zur Definition abstrakter Datentypen und Megawidgets in reinem Tcl. Der Name „Snit“ steht für „Snit’s Not Incr Tcl“ und verdeutlicht, dass Snit bei der Definition von Objekten einen anderen Ansatz verfolgt als Incr Tcl, der bekannteste Objekt-Rahmen für Tcl.  Hätte ich geahnt, dass Snit überhaupt populär werden würde, hätte ich mir wahrscheinlich einen anderen Namen ausgesucht.

Der Hauptzweck von Snit besteht darin, als *Objekt-Bindeglied* zu fungieren – also Ihnen dabei zu helfen, verschiedene Objekte aus unterschiedlichen Quellen zu Typen und Megawidgets mit übersichtlichen, benutzerfreundlichen Schnittstellen zusammenzustellen, damit Sie Ihre Anwendung einfacher erstellen können.

Bei Snit geht es nicht um theoretische Reinheit oder minimalistisches Design; es geht darum, Wirkungsvolles einfach und konsistent tun zu können, ohne darüber nachdenken zu müssen – sodass Sie sich ganz auf die Entwicklung Ihrer Anwendung konzentrieren können.

Bei Snit geht es nicht darum, Tausende von nahezu identischen, sorgfältig festgelegten, leichtgewichtigen Dingern zu implementieren – jedenfalls nicht als einzelne Snit-Objekte.  Herkömmliche Tcl-Methoden sind wesentlich schneller und nicht wesentlich komplizierter. Bei Snit geht es jedoch *darum*, eine übersichtliche Schnittstelle zur Verwaltung einer Sammlung von Tausenden nahezu identischer, sorgfältig spezifizierter, schlanker „Dinger“ zu implementieren (denken Sie beispielsweise an das Text-Widget und Text-Tags oder das Canvas-Widget und Canvas-Objekte).  Mit Snit können Sie die Details darüber verbergen, wie genau diese „Dinger“ gespeichert werden – sodass Sie diese ignorieren und sich ganz auf die Entwicklung Ihrer Anwendung konzentrieren können.

Snit ist weder eine Lebensphilosophie noch ein Wundermittel noch der Jungbrunnen. Es ist lediglich eine Methode, um Komplexität zu bewältigen – und einen Teil der Komplexität beim Bewältigen von Komplexität –, damit Sie sich auf die Entwicklung Ihrer Anwendung konzentrieren können.

## Welche Tcl-Version benötigt snit?

Snit 1.3 benötigt Tcl 8.3 oder höher; Snit 2.2 benötigt Tcl 8.5 oder höher. Die Unterschiede zwischen Snit 1.3 und Snit 2.2 finden Sie im Abschnitt [Snit-Versionen].

## Wo kann ich Snit herunterladen?

Snit ist Teil von Tcllib, der Standardbibliothek von Tcl; möglicherweise verfügen Sie also bereits darüber. Es ist außerdem auf der Snit-Homepage unter <http://www.wjduquette.com/snit> verfügbar.

## Welche Ziele verfolgt snit?

- Ein Snit-Objekt sollte mindestens ebenso effizient sein wie ein manuell programmiertes Tcl-Objekt (siehe <http://www.wjduquette.com/tcl/objects.html>).

- Die Tatsache, dass Snit bei der Implementierung eines Objekts verwendet wurde, sollte für die Klienten dieses Objekts nicht erkennbar (und unerheblich) sein.

- Snit sollte in der Lage sein, Objekte aus anderen Quellen, insbesondere Tk-Widgets, zu kapseln.

- Snit-Megawidgets sollten sich in ihrer Schnittstelle (soweit möglich) nicht von Tk-Widgets unterscheiden.

- Snit sollte „Tcl-ähnlich“ sein – das heißt, es sollte nicht versuchen, C++, Smalltalk oder irgendetwas anderes nachzuahmen, sondern vielmehr Tcl selbst nachzuahmen.

- Es sollte eine einfache, benutzerfreundliche und leicht zu merkende Syntax aufweisen.


## Inwiefern unterscheidet sich snit von anderen OO-Rahmen?

Snit ist unter den Tcl-Objektsystemen insofern einzigartig, als es nicht auf Vererbung, sondern auf Weiterleitung basiert. Objektsysteme, die auf Vererbung beruhen, erlauben es Ihnen lediglich, von Klassen zu erben, die mit demselben System definiert wurden, und das ist bedauerlich. In Tcl ist ein Objekt alles, was sich wie ein Objekt verhält; es sollte keine Rolle spielen, wie das Objekt implementiert wurde.  Ich habe Snit entwickelt, um mir dabei zu helfen, Anwendungen aus den vorhandenen Bausteinen zu erstellen; daher ist Snit so konzipiert, dass es jedes Objekt einbinden und darauf aufbauen kann, sei es ein handcodiertes Objekt, ein Tk-Widget, ein Incr-Tcl-Objekt, ein BWidget oder fast alles andere.

Hinweis: Sie können den Effekt der Vererbung mithilfe von [Komponenten] und [Weiterleitung] erzielen – und dabei von allem erben, was wie ein Tcl-Objekt aussieht.

## Was kann ich mit snit machen?

Mit Snit kann ein Programmierer:

- abstrakte Datentypen und Tk-Megawidgets erstellen.

- Instanzvariablen, Typvariablen und Optionen im Tk-Stil definieren.

- Konstruktoren, Destruktoren, Instanzmethoden, Typmethoden und Prozeduren definieren.

- einen Typ aus Komponententypen zusammensetzen. Instanzmethoden und Optionen können automatisch an die Komponententypen weitergeleitet werden.


# Snit-Versionen

## Welche Version von snit sollte ich verwenden?

Die aktuelle Snit-Distribution enthält zwei Versionen: Snit 1.3 und Snit 2.2.  Der Grund dafür, dass beide Versionen enthalten sind, liegt darin, dass Snit 2.2 eine Reihe neuer Funktionen von Tcl 8.5 nutzt, um die Laufzeiteffizienz zu verbessern; als Nebeneffekt sind die Fehlermeldungen und Stack-Traces von Snit deutlich weniger hässlich geworden.  Der Nachteil bei der Verwendung von Snit 2.2 besteht natürlich darin, dass Sie Tcl 8.5 als Zielplattform wählen müssen.

Snit 1.3 verfügt hingegen nicht über die Optimierungen von Snit 2.2, erfordert jedoch lediglich Tcl 8.3 oder höher.

Kurz gesagt: Wenn Sie Tcl 8.3 oder 8.4 als Zielplattform verwenden, sollten Sie Snit 1.3 nutzen. Wenn Sie Tcl 8.5 als Zielplattform in Betracht ziehen können, sollten Sie auf jeden Fall Snit 2.2 verwenden. Wenn Sie beide Versionen als Zielplattform nutzen wollen, können Sie entweder ausschließlich Snit 1.3 verwenden oder – sofern Ihr Code von den geringfügigen Inkompatibilitäten zwischen den beiden Versionen nicht betroffen ist – Snit 1.3 für Tcl 8.4 und Snit 2.2 für Tcl 8.5 einsetzen.

## Wie wähle ich die Snit-Version aus, die ich verwenden möchte?

Um stets Snit 1.3 (oder eine neuere Version von Snit 1.x) zu verwenden, rufen Sie Snit wie folgt auf:

```
package require snit 1.3
```

Um stets Snit 2.2 (oder eine neuere Version von Snit 2.x) zu verwenden, geben Sie stattdessen Folgendes ein:

```
package require snit 2.2
```

Hinweis: Wenn Sie Snit 2.2 ausdrücklich anfordern, bricht Ihre Anwendung unter Tcl 8.4 ab, da Snit 2.2 für Tcl 8.4 nicht verfügbar ist.

Wenn Sie möchten, dass Ihre Anwendung stets die aktuellste verfügbare Version von Snit verwendet, legen Sie bitte keine Versionsnummer fest:

```
package require snit
```

Tcl sucht und lädt die aktuellste Version, die für die von Ihnen verwendete Tcl-Version verfügbar ist.  Achten Sie in diesem Fall darauf, keine inkompatiblen Funktionen zu verwenden.

## Inwiefern sind snit 1.3 und snit 2.2 nicht miteinander kompatibel?

Snit 2.2 ist soweit wie möglich als direkter Ersatz für Snit 1.3 gedacht. Leider waren einige Inkompatibilitäten unvermeidbar, da Snit 2.2 den neuen Mechanismus „**namespace ensemble**“ von Tcl 8.5 zur Implementierung der Verteilung der Unterbefehle nutzt. Dieser Ansatz ist wesentlich schneller als der in Snit 1.3 verwendete Mechanismus und führt zudem zu deutlich besseren Fehlermeldungen; allerdings bringt er auch neue Einschränkungen für die Implementierung mit sich.

Es gibt vier konkrete Inkompatibilitäten zwischen Snit 1.3 und Snit 2.2.

- Snit 1.3 unterstützt die implizite Benennung von Objekten. Angenommen, Sie definieren einen neuen [snit::type][snit] mit dem Namen **dog**. Sie können Instanzen von **dog** auf drei verschiedene Arten erstellen:

    ```
    dog spot               ;# Explicit naming
    set obj1 [dog %AUTO%]  ;# Automatic naming
    set obj2 [dog]         ;# Implicit naming
    ```

- In Snit 2.2 werden Typbefehle mithilfe des Mechanismus **namespace ensemble** definiert; und **namespace ensemble** erlaubt es nicht, einen Ensemble-Befehl ohne Unterbefehl aufzurufen.  Kurz gesagt: Bei Verwendung von **namespace ensemble** gibt es keine Möglichkeit, implizite Namen zu unterstützen.

    Es ist jedoch noch nicht alles verloren. Wenn der Typ keine Typmethoden besitzt, handelt es sich bei dem Typbefehl um einen einfachen Befehl und nicht um ein Ensemble, sodass **namespace ensemble** nicht verwendet wird. In diesem Fall ist implizite Benennung weiterhin möglich.

    Kurz gesagt: Sie können implizite Benennung nutzen, wenn Sie bereit sind, auf Typmethoden (einschließlich der Standard-Typmethoden wie **$type info**) zu verzichten. Verwenden Sie dazu das Pragma **-hastypemethods**:

    ```
    pragma -hastypemethods 0
    ```

- Hierarchische Methoden und Typmethoden werden in Snit 2.2 unterschiedlich implementiert.

    Eine hierarchische Methode ist eine Instanzmethode, die Unterbefehle besitzt; diese Unterbefehle sind ihrerseits Methoden. Der Befehl **tag** des Tk-Text-Widgets und seine Unterbefehle sind Beispiele für hierarchische Methoden.  Sie können solche Unterbefehle in Snit einfach implementieren, indem Sie mehrere Wörter in die Namen der Methoden einfügen:

    ```
    method {tag configure} {tag args} { ... }

    method {tag cget} {tag option} {...}
    ```

- Hier haben wir implizit eine Methode namens „**tag**“ definiert, die zwei Unterbefehle enthält: „**configure**“ und „**cget**“.

    In Snit 1.3 konnten hierarchische Methoden auf zwei Arten aufgerufen werden:

    ```
    $obj tag cget -myoption      ;# The good way
    $obj {tag cget} -myoption    ;# The weird way
    ```

- Im zweiten Aufruf sehen wir, dass eine hierarchische Methode oder Typmethode schlichtweg eine solche ist, deren Name aus mehreren Wörtern besteht.

    In Snit 2.2 ist dies nicht mehr der Fall, und die „seltsame“ Art, hierarchische Methoden und Typmethoden aufzurufen, funktioniert nicht mehr.

- Die dritte Inkompatibilität ergibt sich aus der zweiten. In Snit 1.3 waren hierarchische Methoden ebenfalls einfache Methoden, deren Name aus mehreren Wörtern bestand. Infolgedessen gab **$obj info methods** die vollständigen Namen aller hierarchischen Methoden zurück.  Im obigen Beispiel würde die von **$obj info methods** zurückgegebene Liste **tag configure** und **tag cget** enthalten, jedoch nicht **tag**, da **tag** nur implizit definiert ist.

    In Snit 2.2 sind hierarchische Methoden und Typmethoden nicht mehr einfach solche, deren Name mehrere Wörter enthält; im obigen Beispiel würde die von **$obj info methods** zurückgegebene Liste **tag** enthalten, jedoch nicht **tag configure** oder **tag cget**.

- Die vierte Inkompatibilität ist auf eine neue Funktion zurückzuführen. Snit 2.2 verwendet den neuen Befehl **namespace path**, sodass der Code eines Typs jeden im übergeordneten Namespace des Typs definierten Befehl ohne Qualifizierung oder Import aufrufen kann.  Nehmen wir beispielsweise an, Sie haben ein Paket namens **mypackage**, das eine Reihe von Befehlen definiert, darunter einen Typ namens **::mypackage::mytype**.  Dank **namespace path** kann der Code des Typs jeden der anderen Befehle aufrufen, die in **::mypackage::** definiert sind.

    Dies ist äußerst praktisch. Es bedeutet jedoch auch, dass Befehle, die im übergeordneten Namespace „**::mypackage::**“ definiert sind, den Zugriff des Typs auf gleichnamige Befehle im globalen Namespace blockieren können. Dies kann zu Fehlern führen.  Beispielsweise enthält Tcllib einen Typ namens **::tie::std::file**.  Der Code dieses Typs ruft den Standard-Befehl **file** auf. Bei der Ausführung mit Snit 2.2 kam es zu einem Fehler – der Befehl des Typs, **::tie::std::file**, ist selbst ein Befehl im übergeordneten Namespace des Typs; statt also den Standardbefehl „**file**“ aufzurufen, rief der Typ sich selbst auf.


## Gibt es weitere Unterschiede zwischen snit 1.x und snit 2.2?

Ja.

- Der Aufruf von Methoden erfolgt deutlich schneller.

- Viele Fehlermeldungen und Stack-Traces sind übersichtlicher.

- Das Pragma **-simpledispatch** ist veraltet und wird, falls angegeben, ignoriert. In Snit 1.x ersetzt **-simpledispatch** den Methodenaufruf durch einen schnelleren Mechanismus, wofür bestimmte Funktionen entfallen. Der Methodenaufruf in Snit 2.2 ist in allen Fällen noch schneller, sodass **-simpledispatch** nicht mehr benötigt wird.

- In Snit 2.2 kann der Code eines Typs (Methoden, Typmethoden, usw.) Befehle aus dem übergeordneten Namespace des Typs aufrufen, ohne diese zu qualifizieren oder zu importieren; das heißt, der Code des Typs **::parentns::mytype** kann **::parentns::someproc** einfach als **someproc** aufrufen.

    Dies ist äußerst nützlich, wenn ein Typ als Teil eines größeren Pakets definiert ist und sich den übergeordneten Namespace mit dem Rest des Pakets teilt; es bedeutet, dass der Typ andere, vom Paket definierte Befehle ohne zusätzlichen Aufwand aufrufen kann.

    Diese Funktion basiert auf dem neuen Tcl 8.5-Befehl **namespace path**, weshalb sie für V1.x nicht implementiert wurde. In V1.x-Code lässt sich ein ähnliches Ergebnis erzielen, indem man

    ```
    namespace import [namespace parent]::*
    ```

- in einem Typkonstruktor. Dies ist jedoch weniger nützlich, da dabei nur jene Befehle erfasst werden, die zum Zeitpunkt der Typdefinition bereits vom übergeordneten Namespace exportiert wurden.


# Objekte

## Was ist ein Objekt?

Eine vollständige Beschreibung der objektorientierten Programmierung würde den Rahmen dieser FAQ natürlich sprengen. Vereinfacht ausgedrückt ist ein Objekt eine Instanz eines abstrakten Datentyps – ein zusammenhängendes Bündel aus Code und Daten. Es gibt viele Möglichkeiten, Objekte in Tcl/Tk darzustellen; die bekanntesten Beispiele sind die Tk-Widgets.

Ein Tk-Widget ist ein Objekt; es wird durch einen Tcl-Befehl dargestellt. Die Methoden des Objekts sind Unterbefehle des Tcl-Befehls. Die Eigenschaften des Objekts sind Optionen, auf die über die Methoden **configure** und **cget** zugegriffen wird. Snit verwendet dieselben Konventionen wie Tk-Widgets.

## Was ist ein abstrakter Datentyp?

In der Informatik ist ein abstrakter Datentyp eine komplexe Datenstruktur zusammen mit einer Reihe von Operationen – ein Stapel, eine Warteschlange, ein binärer Baum usw. –, d. h., in moderner Terminologie ein Objekt.  In Systemen, die eine Form der Vererbung beinhalten, wird üblicherweise das Wort *Klasse* anstelle von *abstraktem Datentyp* verwendet; da Snit jedoch Vererbung nicht im herkömmlichen Sinne implementiert, erscheint das ältere Wort passender. Manchmal wird dies als *objektbasierte* Programmierung im Gegensatz zur objektorientierten Programmierung bezeichnet.  Hinweis: Sie können den Effekt der Vererbung mithilfe von [Komponenten] und [Weiterleitung] auf einfache Weise erzielen.

In Snit ist ein *Typ* – ebenso wie in Tk – ein Befehl, der Instanzen – also Objekte – erstellt, die zu diesem Typ gehören. Die meisten Typen definieren eine Reihe von *Optionen*, die bei der Erstellung festgelegt werden können und in der Regel später geändert werden können.

Darüber hinaus ist eine *Instanz* ebenfalls ein Tcl-Befehl – ein Befehl, der Zugriff auf die für diesen abstrakten Datentyp definierten Operationen gewährt.  Üblicherweise werden die Operationen als Unterbefehle des Instanz-Befehls definiert.  Um beispielsweise Text in ein Tk-Text-Widget einzufügen, verwenden Sie den Unterbefehl **insert** des Text-Widgets:

```
    # Create a text widget and insert some text in it.
    text .mytext -width 80 -height 24
    .mytext insert end "Howdy!"
```

In diesem Beispiel ist „**text**“ der *Typ*-Befehl und „**.mytext**“ der *Instanz*-Befehl.

In Snit werden Objekt-Unterbefehle im Allgemeinen als [Instanzmethoden] bezeichnet.

## Welche Arten von abstrakten Datentypen bietet snit an?

Mit Snit können Sie drei Arten von abstrakten Datentypen definieren:

- [snit::type][snit]

- [snit::widget][snit]

- [snit::widgetadaptor][snit]


## Was ist ein snit::type?

Ein [snit::type][snit] ist ein abstrakter Datentyp ohne grafische Benutzeroberfläche, z. B. ein Stapel oder eine Warteschlange. [snit::type][snit]s werden mit dem Befehl [snit::type][snit] definiert.  Wenn Sie beispielsweise ein Zwingerverwaltungssystem für einen Hundezüchter entwerfen würden, bräuchten Sie einen Typ „Hund“.

```
% snit::type dog {
    # ...
}
::dog
%
```

Diese Definition legt einen neuen Befehl fest (in diesem Fall **::dog**), mit dem „Hund“-Objekte definiert werden können.

Eine Instanz von [snit::type][snit] kann [Instanzmethoden], [Instanzvariablen], [Optionen] und [Komponenten] besitzen. Der Typ selbst kann [Typmethoden], [Typvariablen], [Typkomponenten] und [Prozeduren] besitzen.

## Was ist ein snit::widget? Die Kurzfassung

Ein [snit::widget][snit] ist ein mit Snit erstelltes Tk-Megawidget; es ist einem [snit::type][snit] sehr ähnlich.  Siehe [Widgets].

## Was ist ein snit::widgetadaptor? Die Kurzfassung

Ein [snit::widgetadaptor][snit] nutzt Snit, um einen bestehenden Widget-Typ (z. B. ein Tk-Label) zu umschließen und dessen Schnittstelle in geringerem oder größerem Umfang anzupassen. Es ist einem [snit::widget][snit] sehr ähnlich. Siehe [Widget-Adapter].

## Wie erstelle ich eine Instanz von snit::type?

Sie erstellen eine Instanz von „[snit::type][snit]“, indem Sie den Namen der neuen Instanz an die create-Methode des Typs übergeben. Im folgenden Beispiel erstellen wir ein „**dog**“-Objekt mit dem Namen „**spot**“.

```
% snit::type dog {
    # ....
}
::dog
% dog create spot
::spot
%
```

Im Allgemeinen kann der Name der Methode „**create**“ weggelassen werden, solange der Name der Instanz nicht mit einer der definierten [Typmethoden] in Konflikt steht. (Siehe [Typkomponenten] für den Sonderfall, in dem dies nicht funktioniert.) Das folgende Beispiel ist daher identisch mit dem vorherigen Beispiel:

```
% snit::type dog {
    # ....
}
::dog
% dog spot
::spot
%
```

In diesem Dokument wird in der Regel die kürzere Form verwendet.

Wenn der Typ **dog** [Optionen] definiert, können diesen in der Regel bei der Erstellung Standardwerte zugewiesen werden:

```
% snit::type dog {
    option -breed mongrel
    option -color brown

    method bark {} { return "$self barks." }
}
::dog
% dog create spot -breed dalmation -color spotted
::spot
% spot cget -breed
dalmation
% spot cget -color
spotted
%
```

Nach der Erstellung bezeichnet der Instanzname nun einen neuen Tcl-Befehl, mit dem das Objekt gesteuert wird. Der folgende Code lässt beispielsweise den Hund bellen:

```
% spot bark
::spot barks.
%
```

## Wie kann ich indirekt auf ein Objekt verweisen?

Manche Programmierer ziehen es vor, den Namen des Objekts in einer Variablen zu speichern und auf diese Weise darauf zu verweisen. Zum Beispiel:

```
% snit::type dog { ... }
::dog
% set d [dog spot -breed dalmation -color spotted]
::spot
% $d cget -breed
dalmation
% $d bark
::spot barks.
%
```

Falls Ihnen dieser Stil besser gefällt, ziehen Sie es vielleicht vor, dass Snit den Namen der Instanz automatisch generiert.

## Wie kann ich den Namen des Objekts automatisch generieren?

Wenn Sie möchten, dass Snit einen Namen für ein Objekt generiert, verwenden Sie das Schlüsselwort **%AUTO%** als gewünschten Namen:

```
% snit::type dog { ... }
::dog
% set d [dog %AUTO%]
::dog2
% $d bark
::dog2 barks.
%
```

Das Schlüsselwort „**%AUTO%**“ kann in eine längere Zeichenfolge eingebettet werden:

```
% set d [dog obj_%AUTO%]
::obj_dog4
% $d bark
::obj_dog4 barks.
%
```

## Können Typen umbenannt werden?

Der Tcl-Befehl „**rename**“ benennt andere Befehle um. Es ist in Tcl eine gängige Vorgehensweise, einen bestehenden Befehl zu ändern, indem man ihn umbenennt und einen neuen Befehl mit dem ursprünglichen Namen definiert; der neue Befehl ruft in der Regel den umbenannten Befehl auf.

Befehle vom Typ „[snit::type][snit]“ sollten jedoch niemals umbenannt werden; dies würde die Verbindung zwischen dem Typ und seinen Objekten unterbrechen.

## Können Objekte umbenannt werden?

Der Tcl-Befehl „**rename**“ benennt andere Befehle um. Es ist in Tcl eine gängige Vorgehensweise, einen bestehenden Befehl zu ändern, indem man ihn umbenennt und einen neuen Befehl mit dem ursprünglichen Namen definiert; der neue Befehl ruft in der Regel den umbenannten Befehl auf.

Alle Snit-Objekte (einschließlich *Widgets* und *Widgetadapter*) können umbenannt werden, doch diese Flexibilität hat einige Konsequenzen:

- In einer Instanzmethode enthält das implizite Argument **self** stets den aktuellen Namen des Objekts, sodass Instanzmethoden andere Instanzmethoden stets über **$self** aufrufen können.

- Wenn das Objekt umbenannt wird, ändert sich der Wert von **$self**. Verwenden Sie daher **$self** nicht für etwas, das bei einer Änderung von **$self** nicht mehr funktionieren würde. Übergeben Sie beispielsweise keinen Rückrufbefehl wie folgt an ein anderes Objekt:

    ```
        .btn configure -command [list $self ButtonPress]
    ```

- Es wird eine Fehlermeldung angezeigt, wenn **.btn** Ihren Befehl aufruft, nachdem Ihr Objekt umbenannt wurde.

- Stattdessen sollte Ihr Objekt seinen Rückrufbefehl wie folgt definieren:

    ```
        .btn configure -command [mymethod ButtonPress]
    ```

- Der Befehl [mymethod][snit] gibt einen Code zurück, der die gewünschte Methode sicher aufruft; der Aufrufer der Rückruffunktion kann wie gewohnt zusätzliche Argumente an das Ende des Befehls anhängen.

- Jedes Objekt verfügt über einen privaten Namespace; der Name dieses Namespaces steht in Methodenkörpern usw. als Wert des impliziten Arguments **selfns** zur Verfügung. Dieser Wert bleibt während der gesamten Lebensdauer des Objekts konstant.  Verwenden Sie **$selfns** anstelle von **$self**, wenn Sie ein eindeutiges Kennzeichen zur Identifizierung des Objekts benötigen.

- Wenn der Befehl einer „[snit::widget][snit]“-Instanz umbenannt wird, bleibt der Name seines Tk-Fensters unverändert – und ist nach wie vor von großer Bedeutung. Folglich steht der Name des Tk-Fensters in Methoden als Wert des impliziten Arguments „**win**“ zur Verfügung. Dieser Wert bleibt während der gesamten Lebensdauer des Objekts konstant. Beim Erstellen von untergeordneten Fenstern empfiehlt es sich, **$win.child** anstelle von **$self.child** als Namen für das untergeordnete Fenster zu verwenden.


## Wie kann ich ein Snit-Objekt löschen?

Jedes Snit-Objekt beliebigen Typs kann gelöscht werden, indem man es mithilfe des Tcl-Befehls **rename** in die leere Zeichenfolge umbenennt.

Snit-Megawidgets (d. h. Instanzen von [snit::widget][snit] und [snit::widgetadaptor][snit]) können wie jedes andere Widget zerstört werden: durch Verwendung des Tk-Befehls **destroy** auf das Widget selbst oder auf eines seiner übergeordneten Elemente in der Fensterhierarchie.

Jede Instanz von [snit::type][snit] verfügt über eine Methode namens **destroy**:

```
% snit::type dog { ... }
::dog
% dog spot
::spot
% spot bark
::spot barks.
% spot destroy
% spot barks
invalid command name "spot"
%
```

Schließlich verfügt jeder Snit-Typ über eine Typmethode namens **destroy**; deren Aufruf löscht den Typ und alle seine Instanzen:

```
% snit::type dog { ... }
::dog
% dog spot
::spot
% spot bark
::spot barks.
% dog destroy
% spot bark
invalid command name "spot"
% dog fido
invalid command name "dog"
%
```

# Instanzmethoden

## Was ist eine Instanzmethode?

Eine Instanzmethode ist eine Prozedur, die einem bestimmten Objekt zugeordnet ist und als Unterbefehl des Befehls dieses Objekts aufgerufen wird. Sie hat uneingeschränkten Zugriff auf alle Typvariablen, Instanzvariablen usw. des Objekts.

## Wie definiere ich eine Instanzmethode?

Instanzmethoden werden in der Typdefinition mithilfe der Anweisung **method** definiert. Betrachten Sie den folgenden Code, der möglicherweise dazu verwendet wird, Hunde zu einer Computersimulation hinzuzufügen:

```
% snit::type dog {
    method bark {} {
        return "$self barks."
    }

    method chase {thing} {
        return "$self chases $thing."
    }
}
::dog
%
```

Ein Hund kann bellen und er kann Dinge jagen.

Die Anweisung „**method**“ sieht genauso aus wie ein normales Tcl-„[proc][snit]“, mit dem Unterschied, dass sie in einer „[snit::type][snit]“-Definition vorkommt.  Beachten Sie, dass jede Instanzmethode ein implizites Argument namens **self** erhält; dieses Argument enthält den Namen des Objekts.  (Weitere Informationen zu impliziten Methodenargumenten finden Sie weiter unten.)

## Wie ruft ein Client eine Instanzmethode auf?

Der Name der Methode wird zu einem Unterbefehl des Objekts. Lassen Sie uns beispielsweise einen simulierten Hund auf Herz und Nieren prüfen:

```
% dog spot
::spot
% spot bark
::spot barks.
% spot chase cat
::spot chases cat.
%
```

## Wie ruft eine Instanzmethode eine andere Instanzmethode auf?

Wenn Methode A die Methode B für dasselbe Objekt aufrufen muss, tut sie dies genau wie ein Client: Sie ruft Methode B als Unterbefehl des Objekts selbst auf und verwendet dabei den im impliziten Argument **self** gespeicherten Objektnamen.

Nehmen wir zum Beispiel an, dass unsere Hunde niemals etwas jagen, ohne dabei zu bellen:

```
% snit::type dog {
    method bark {} {
        return "$self barks."
    }

    method chase {thing} {
        return "$self chases $thing.  [$self bark]"
    }
}
::dog
% dog spot
::spot
% spot bark
::spot barks.
% spot chase cat
::spot chases cat.  ::spot barks.
%
```

## Gibt es Einschränkungen hinsichtlich der Namen von Instanzmethoden?

Nicht wirklich, solange Sie die Namen der Standard-Instanzmethoden vermeiden: **configure**, **configurelist**, **cget**, **destroy** und **info**.  Außerdem definieren Namen von Methoden, die aus mehreren Wörtern bestehen, hierarchische Methoden.

## Was ist eine hierarchische Methode?

Die Methoden eines Objekts sind Unterbefehle des Instanzbefehls des Objekts. Hierarchische Methoden erlauben es, dass die Methoden eines Objekts eigene Unterbefehle haben; diese können wiederum Unterbefehle haben und so weiter. So kann der Programmierer eine baumförmige Befehlsstruktur definieren, wie sie viele Tk-Widgets verwenden – die Unterbefehle der Methode **tag** des Tk-Widgets **text** sind hierarchische Methoden.

## Wie definiere ich eine hierarchische Methode?

Definieren Sie Methoden, deren Namen aus mehreren Wörtern bestehen. Diese Wörter legen implizit die Hierarchie fest. Der folgende Code definiert beispielsweise eine Methode namens „**tag**“ mit den Unterbefehlen „**cget**“ und „**configure**“:

```
snit::widget mytext {
    method {tag configure} {tag args} { ... }

    method {tag cget} {tag option} {...}
}
```

Hinweis: Es gibt keine explizite Definition für die Methode **tag**; sie ist implizit in den Definitionen von **tag configure** und **tag cget** enthalten.  Wenn Sie in diesem Beispiel versuchen würden, „**tag**“ explizit zu definieren, würden Sie eine Fehlermeldung erhalten.

## Wie rufe ich hierarchische Methoden auf?

Als Unterbefehle von Unterbefehlen.

```
% mytext .text
.text
% .text tag configure redtext -foreground red -background black
% .text tag cget redtext -foreground
red
%
```

## Wie kann ich eine Instanzmethode als „private“ kennzeichnen?

Häufig ist es sinnvoll, private Methoden zu definieren, d. h. Instanzmethoden, die ausschließlich von anderen Methoden desselben Objekts aufgerufen werden sollen.

Snit implementiert keine Zugriffskontrolle für Instanzmethoden, sodass alle Methoden *de facto* öffentlich sind. Üblicherweise beginnen die Namen öffentlicher Methoden jedoch mit einem Kleinbuchstaben, während die Namen privater Methoden mit einem Großbuchstaben beginnen.

Nehmen wir beispielsweise an, unsere simulierten Hunde bellen ausschließlich als Reaktion auf andere Reize; sie bellen niemals einfach nur zum Spaß. Daher wird aus der Methode „**bark**“ die Methode „**Bark**“, um anzuzeigen, dass es sich um eine private Methode handelt:

```
% snit::type dog {
    # Private by convention: begins with uppercase letter.
    method Bark {} {
        return "$self barks."
    }

    method chase {thing} {
        return "$self chases $thing. [$self Bark]"
    }
}
::dog
% dog fido
::fido
% fido chase cat
::fido chases cat. ::fido barks.
%
```

## Gibt es Einschränkungen hinsichtlich der Argumente von Instanzmethoden?

Argumentlisten von Methoden werden genauso definiert wie normale Argumentlisten von Tcl-[proc][snit]s; insbesondere können sie Argumente mit Standardwerten und das Argument **args** enthalten.

Jede Methode verfügt jedoch zusätzlich zu den explizit definierten Argumenten über eine Reihe impliziter Argumente, die von Snit bereitgestellt werden. Die Namen dieser impliziten Argumente dürfen nicht zur Benennung expliziter Argumente verwendet werden.

## Welche impliziten Argumente werden an jede Instanzmethode übergeben?

Die Argumente, die implizit an jede Methode übergeben werden, lauten **type**, **selfns**, **win** und **self**.

## Was ist $type?

Das implizite Argument **type** enthält den vollqualifizierten Namen des Objekttyps:

```
% snit::type thing {
    method mytype {} {
        return $type
    }
}
::thing
% thing something
::something
% something mytype
::thing
%
```

## Was ist $self?

Das implizite Argument **self** enthält den vollqualifizierten Namen des Objekts.

Wenn der Befehl des Objekts umbenannt wird, ändert sich „**$self**“ bei nachfolgenden Aufrufen entsprechend. Daher sollten Sie in Ihrem Code nicht davon ausgehen, dass „**$self**“ eine Konstante ist, es sei denn, Sie wissen mit Sicherheit, dass das Objekt niemals umbenannt wird.

```
% snit::type thing {
    method myself {} {
        return $self
    }
}
::thing
% thing mutt
::mutt
% mutt myself
::mutt
% rename mutt jeff
% jeff myself
::jeff
%
```

## Was ist $selfns?

Jedes Snit-Objekt verfügt über einen privaten Namespace, in dem seine [Instanzvariablen] und [Optionen] gespeichert werden.  Das implizite Argument **selfns** enthält den Namen dieses Namespaces; sein Wert ändert sich nie und bleibt während der gesamten Lebensdauer des Objekts konstant, selbst wenn sich der Name des Objekts ändert:

```
% snit::type thing {
    method myNameSpace {} {
        return $selfns
    }
}
::thing
% thing jeff
::jeff
% jeff myNameSpace
::thing::Snit_inst3
% rename jeff mutt
% mutt myNameSpace
::thing::Snit_inst3
%
```

Das obige Beispiel verdeutlicht, wie Snit den privaten Namespace einer Instanz benennt; Sie sollten jedoch keinen Code schreiben, der von dieser spezifischen Namenskonvention abhängt, da sich diese in zukünftigen Versionen ändern könnte.

## Was ist $win?

Das implizite Argument **win** ist für alle Snit-Methoden definiert, obwohl es eigentlich nur für die Methoden von Widgets und Widget-Adaptern sinnvoll ist (siehe [Widgets] und [Widget-Adapter]).  **$win** ist schlichtweg der ursprüngliche Name des Objekts, unabhängig davon, ob es umbenannt wurde oder nicht. Bei Widgets und Widget-Adaptern ist es daher auch der Name eines Tk-Fensters.

Wenn ein [snit::widgetadaptor][snit] verwendet wird, um die Schnittstelle eines Widgets oder Megawidgets anzupassen, muss es den ursprünglichen Befehl des Widgets umbenennen und durch einen eigenen ersetzen.

Wenn Sie also **win** verwenden, wann immer der Name des Tk-Fensters benötigt wird, bedeutet dies, dass ein [snit::widget][snit] oder [snit::widgetadaptor][snit] durch einen [snit::widgetadaptor][snit] angepasst werden kann.  Weitere Informationen finden Sie unter [Widgets].

## Wie übergebe ich eine Instanzmethode als Rückruffunktion?

Das hängt vom Kontext ab.

Angenommen, ich habe in meiner Anwendung ein **dog**-Objekt mit dem Namen **fido**, und ich möchte, dass „**fido**“ bellt, wenn eine Tk-Schaltfläche namens „**.bark**“ gedrückt wird. In diesem Fall erstelle ich den Rückrufbefehl wie gewohnt unter Verwendung von „**list**“:

```
    button .bark -text "Bark!" -command [list fido bark]
```

Im typischen Tcl-Stil verwenden wir eine Rückruffunktion, um zwei unabhängige Komponenten miteinander zu verknüpfen.  Angenommen jedoch, das Objekt **dog** verfügt über eine grafische Benutzeroberfläche und besitzt die Schaltfläche selbst? In diesem Fall muss **dog** eine seiner eigenen Instanzmethoden an die Schaltfläche übergeben, die es besitzt. Die naheliegende Vorgehensweise ist folgende:

```
% snit::widget dog {
    constructor {args} {
        #...
        button $win.barkbtn -text "Bark!" -command [list $self bark]
        #...
    }
}
::dog
%
```

(Hinweis: In diesem Beispiel wird aus unserem **dog** ein [snit::widget][snit], da es über GUI-Funktionen verfügt. Weitere Informationen finden Sie unter [Widgets].)  Wenn wir also ein **dog** mit dem Namen **.spot** erstellen, wird dadurch eine Tk-Schaltfläche mit dem Namen **.spot.barkbtn** erstellt; beim Drücken ruft die Schaltfläche **$self bark** auf.

Nun, das wird funktionieren – vorausgesetzt, **.spot** wird niemals umbenannt.  Aber ist das Umbenennen von Widgets nicht ungewöhnlich? In der Tat – es sei denn, **.spot** ist die Hull-Komponente eines [snit::widgetadaptor][snit].  Wenn dies der Fall ist, wird es umbenannt, und „**.spot**“ wird zum Namen des Objekts „[snit::widgetadaptor][snit]“.  Wenn die Schaltfläche gedrückt wird, wird der Befehl **$self bark** von [snit::widgetadaptor][snit] verarbeitet, was möglicherweise das Richtige bewirkt – oder auch nicht.

Es gibt eine sicherere Vorgehensweise, und die sieht folgendermaßen aus:

```
% snit::widget dog {
    constructor {args} {
        #...
        button $win.barkbtn -text "Bark!" -command [mymethod bark]
        #...
    }
}
::dog
%
```

Der Befehl [mymethod][snit] akzeptiert eine beliebige Anzahl von Argumenten und kann wie **list** zum Erstellen eines Rückrufbefehls verwendet werden; der einzige Unterschied besteht darin, dass [mymethod][snit] eine Form des Befehls zurückgibt, die sich auch dann nicht ändert, wenn sich der Name der Instanz ändert.

Andererseits möchten Sie vielleicht lieber zulassen, dass ein Widget-Adapter eine Methode überschreibt, sodass Ihr umbenanntes Widget die Methode des Widget-Adapters anstelle seiner eigenen aufruft.  In diesem Fall wird die Verwendung von **\[list $self bark\]** das gewünschte Ergebnis erzielen … allerdings handelt es sich hierbei um eine Technik, die nur unter sorgfältig kontrollierten Umständen angewendet werden sollte.

## Wie leite ich Instanzmethoden an eine Komponente weiter?

Siehe [Weiterleitung].

# Instanzvariablen

## Was ist eine Instanzvariable?

Eine Instanzvariable ist eine private Variable, die einem bestimmten Snit-Objekt zugeordnet ist. Instanzvariablen können Skalare oder Arrays sein.

## Wie wird eine skalare Instanzvariable definiert?

Skalare Instanzvariablen werden in der Typdefinition mithilfe der Anweisung [variable][snit] definiert. Sie können ihnen einfach einen Namen geben oder sie mit einem Wert initialisieren:

```
snit::type mytype {
    # Define variable "greeting" and initialize it with "Howdy!"
    variable greeting "Howdy!"
}
```

## Wie wird eine Array-Instanzvariable definiert?

Array-Instanzvariablen werden ebenfalls in der Typdefinition mithilfe des Befehls [variable][snit] definiert. Sie können diese gleichzeitig initialisieren, indem Sie die Option **-array** angeben:

```
snit::type mytype {
    # Define array variable "greetings"
    variable greetings -array {
        formal "Good Evening"
        casual "Howdy!"
    }
}
```

## Was geschieht, wenn ich eine Instanzvariable nicht initialisiere?

Variablen existieren erst dann wirklich, wenn ihnen Werte zugewiesen wurden. Wenn Sie eine Variable bei ihrer Definition nicht initialisieren, müssen Sie darauf achten, ihr einen Wert zuzuweisen (beispielsweise im Konstruktor oder in einer Methode), bevor Sie darauf zugreifen.

## Gibt es Einschränkungen hinsichtlich der Namen von Instanzvariablen?

Nur ein paar.

Erstens verfügt jedes Snit-Objekt über eine integrierte Instanzvariable namens **options**, die niemals neu definiert werden sollte.

Zweitens sind alle Namen, die mit „Snit\_“ beginnen, für die Verwendung durch den internen Code von Snit reserviert.

Drittens dürften Instanzvariablennamen, die das Namespace-Trennzeichen enthalten (**::**), große Verwirrung stiften.

## Muss ich meine Instanzvariablen in meinen Methoden deklarieren?

Nein. Sobald Sie eine Instanzvariable in der Typdefinition definiert haben, kann diese in jedem Instanzcode (Instanzmethoden, Konstruktor und Destruktor) ohne separate Deklaration verwendet werden. Dies weicht von der üblichen Tcl-Praxis ab, bei der alle nicht-lokalen Variablen in einer Prozedur deklariert werden müssen.

Die Tatsache, dass alle Instanzvariablen implizit im gesamten Instanzcode verfügbar sind, geht mit einem Geschwindigkeitsverlust einher. Auch wenn Sie die Variablen in Ihrem Code nicht explizit deklarieren müssen, muss Snit sie dennoch deklarieren, und das kostet Zeit.  Wenn Sie zehn Instanzvariablen haben, muss eine Methode, die keine davon verwendet, dennoch den Deklarationsaufwand für alle zehn tragen. In den meisten Fällen sind die zusätzlichen Laufzeitkosten vernachlässigbar. In Extremfällen möchten Sie sie möglicherweise vermeiden; dafür gibt es zwei Möglichkeiten.

Die erste Möglichkeit besteht darin, eine einzige Instanzvariable – ein Array – zu definieren und alle Ihre Instanzdaten in diesem Array zu speichern. Auf diese Weise entsteht Ihnen nur der Deklarationsaufwand für eine einzige Variable – und diese benötigen Sie wahrscheinlich ohnehin die meiste Zeit.  Diese Methode versagt jedoch, wenn Ihre Instanzvariablen mehrere Arrays enthalten; in Tcl 8.5 könnte Ihnen der Befehl **dict** jedoch Abhilfe schaffen.

Die zweite Methode besteht darin, Ihre Instanzvariablen explizit in Ihrem Instanzcode zu deklarieren, sie jedoch *nicht* in die Typdefinition aufzunehmen:

```
snit::type dog {
    constructor {} {
        variable mood

        set mood happy
    }

    method setmood {newMood} {
        variable mood

        set mood $newMood
    }

    method getmood {} {
        variable mood

        return $mood
    }
}
```

Auf diese Weise können Sie sicherstellen, dass in jeder Methode nur die erforderlichen Variablen enthalten sind – allerdings auf Kosten von längerem Code und Laufzeitfehlern, falls Sie vergessen sollten, eine benötigte Variable zu deklarieren.

## Wie übergebe ich den Namen einer Instanzvariablen an ein anderes Objekt?

In Tk ist es üblich, einem Widget einen Namen einer Variablen zu übergeben; beispielsweise verfügen Tk-Label-Widgets über die Option „**-textvariable**“, die den Namen der Variablen angibt, die den Text des Widgets enthält.  Dadurch kann das Programm den Wert des Labels aktualisieren, indem es der Variable einfach einen neuen Wert zuweist.

Wenn Sie den Namen der Instanzvariablen naiv an das Label-Widget übergeben, wird Sie das Ergebnis verwirren; Tk geht davon aus, dass der Name eine globale Variable bezeichnet. Stattdessen müssen Sie einen vollqualifizierten Variablennamen angeben.  Innerhalb einer Instanzmethode oder eines Konstruktors können Sie den Namen der Variablen mithilfe des Befehls [myvar][snit] vollständig qualifizieren:

```
snit::widget mywidget {
    variable labeltext ""

    constructor {args} {
        # ...

        label $win.label -textvariable [myvar labeltext]

        # ...
    }
}
```

## Wie mache ich eine Instanzvariable öffentlich?

In der Praxis tun Sie das nicht. Stattdessen implementieren Sie öffentliche Variablen als [Optionen]. Alternativ können Sie [Instanzmethoden] schreiben, um den Wert der Variablen festzulegen und abzurufen.

# Optionen

## Was ist eine Option?

Die Optionen eines Typs entsprechen dem, was in anderen objektorientierten Sprachen als öffentliche Membervariablen oder Eigenschaften bezeichnet wird: Es handelt sich um Werte, die von den Clients eines Objekts abgerufen und (in der Regel) gesetzt werden können.

Die Implementierung von Optionen in Snit folgt ziemlich genau dem Tk-Modell, mit der Ausnahme, dass [snit::type][snit]-Objekte in der Regel nicht mit der [Tk-Optionsdatenbank] interagieren; Objekte vom Typ [snit::widget][snit] und [snit::widgetadaptor][snit] hingegen tun dies stets.

## Wie definiere ich eine Option?

Optionen werden in der Typdefinition mithilfe der Anweisung **option** definiert. Betrachten Sie den folgenden Typ, der in einer Anwendung verwendet werden soll, die eine Liste von Hunden für eine Tierhandlung verwaltet:

```
snit::type dog {
    option -breed -default mongrel
    option -color -default brown
    option -akc   -default 0
    option -shots -default 0
}
```

Demnach weist ein Hund vier wesentliche Merkmale auf: eine Rasse, eine Farbe, ein Kennzeichen, das angibt, ob er beim American Kennel Club als reinrassig registriert ist, sowie ein weiteres Kennzeichen, das angibt, ob er geimpft wurde. Der Standardhund ist offenbar ein brauner Mischling.

Beim Definieren einer Option können Sie eine Reihe von Optionen angeben; ist **-default** die einzige, können Sie das Wort **-default** wie folgt weglassen:

```
snit::type dog {
    option -breed mongrel
    option -color brown
    option -akc   0
    option -shots 0
}
```

Wenn kein Wert für „**-default**“ festgelegt wird, ist der Standardwert der Option eine leere Zeichenkette (siehe jedoch [Tk-Optionsdatenbank]).

In der Snit-Manpage werden Optionen wie diese als „lokal definierte“ Optionen bezeichnet.

## Wie kann ein Client bei der Erstellung eines Objekts Optionen festlegen?

Es ist üblich, dass der Client bei der Erstellung eines Objekts nach dem Namen des Objekts eine beliebige Anzahl von Optionen und deren Werte übergeben kann. So kann beispielsweise der in der vorherigen Antwort definierte Befehl „**::dog**“ nun zum Erstellen einzelner Hunde verwendet werden. Bei der Erstellung können einzelne oder alle Optionen festgelegt werden.

```
% dog spot -breed beagle -color "mottled" -akc 1 -shots 1
::spot
% dog fido -shots 1
::fido
%
```

**::spot** ist also ein reinrassiger Beagle; **::fido** ist ein typischer Mischling, doch seine Besitzer kümmern sich offensichtlich gut um ihn, da er geimpft ist.

*Hinweis:* Wenn der Typ einen Konstruktor definiert, kann er eine andere Syntax zur Objekterstellung festlegen. Weitere Informationen finden Sie unter [Konstruktoren].

## Wie kann ein Client den Wert einer Option abrufen?

Rufen Sie die Werte der Optionen mithilfe der Methode **cget** ab:

```
% spot cget -color
mottled
% fido cget -breed
mongrel
%
```

## Wie kann ein Client Optionen nach dem Erzeugen des Objekts setzen?

Mit der Instanzmethode **configure** können beliebig viele Optionen gleichzeitig festgelegt werden. Nehmen wir an, bei genauerer Betrachtung stellt sich heraus, dass ::fido kein brauner Mischling ist, sondern ein seltener Arctic Boar Hound mit einer wunderschönen graubraunen Farbe:

```
% fido configure -color dun -breed "Arctic Boar Hound"
% fido cget -color
dun
% fido cget -breed
Arctic Boar Hound
```

Alternativ akzeptiert die Methode **configurelist** eine Liste mit Optionen und Werten; gelegentlich ist dies praktischer:

```
% set features [list -color dun -breed "Arctic Boar Hound"]
-color dun -breed {Arctic Boar Hound}
% fido configurelist $features
% fido cget -color
dun
% fido cget -breed
Arctic Boar Hound
%
```

In Tcl 8.5 kann das Schlüsselwort **\*** in diesem Fall zusammen mit **configure** verwendet werden:

```
% set features [list -color dun -breed "Arctic Boar Hound"]
-color dun -breed {Arctic Boar Hound}
% fido configure {*}$features
% fido cget -color
dun
% fido cget -breed
Arctic Boar Hound
%
```

Die Ergebnisse sind dieselben.

## Wie sollte eine Instanzmethode auf einen Wert einer Option zugreifen?

Es gibt zwei Möglichkeiten, wie eine Instanzmethode den Wert einer Option festlegen und abrufen kann. Eine davon besteht darin, die Methoden **configure** und **cget** zu verwenden, wie im Folgenden dargestellt.

```
% snit::type dog {
    option -weight 10

    method gainWeight {} {
        set wt [$self cget -weight]
        incr wt
        $self configure -weight $wt
    }
}
::dog
% dog fido
::fido
% fido cget -weight
10
% fido gainWeight
% fido cget -weight
11
%
```

Alternativ stellt Snit eine integrierte Array-Instanzvariable namens **options** zur Verfügung. Die Indizes entsprechen den Namen der Optionen; die Werte entsprechen den Werten der Optionen. Die Methode **gainWeight** lässt sich somit wie folgt umschreiben:

```
    method gainWeight {} {
        incr options(-weight)
    }
```

Wie Sie sehen können, erfordert die Verwendung der Variablen **options** deutlich weniger Tipparbeit und ist die übliche Vorgehensweise. Sollten Sie jedoch **-configuremethod** oder **-cgetmethod** (in den folgenden Antworten beschrieben) verwenden, möchten Sie möglicherweise dennoch die Methoden **configure** und **cget** verwenden, um sicherzustellen, dass alle von Ihnen implementierten speziellen Verarbeitungsschritte auch tatsächlich ausgeführt werden.  Wenn die Option zudem an eine Komponente weitergeleitet wurde, sind **configure** und **cget** die einzige Möglichkeit, darauf zuzugreifen, ohne direkt auf die Komponente zuzugreifen. Weitere Informationen finden Sie unter [Weiterleitung].

## Wie kann ich eine Option auf „Nur-Lesen“ setzen?

Definieren Sie die Option mit **-readonly yes**.

Angenommen, Sie verfügen über eine Option, die festlegt, wie Instanzen Ihres Typs erstellt werden; diese muss zum Zeitpunkt der Erstellung festgelegt werden und ist danach unveränderlich.  Beispielsweise ändert ein Hund niemals seine Rasse; er kann geimpft sein oder auch nicht, und falls nicht, kann er die Impfungen zu einem späteren Zeitpunkt erhalten.  **-breed** sollte schreibgeschützt sein, **-shots** hingegen nicht.

```
% snit::type dog {
    option -breed -default mongrel -readonly yes
    option -shots -default no
}
::dog
% dog fido -breed retriever
::fido
% fido configure -shots yes
% fido configure -breed terrier
option -breed can only be set at instance creation
%
```

## Wie kann ich Zugriffe auf den Wert einer Option erfassen?

Definieren Sie für die Option eine **-cgetmethod**.

## Was ist eine -cgetmethod?

„**-cgetmethod**“ ist eine Methode, die immer dann aufgerufen wird, wenn der Wert der zugehörigen Option über die Instanzmethode „**cget**“ abgefragt wird.  Der Handler kann den Wert der Option berechnen, ihn aus einer Datenbank abrufen oder jede andere von Ihnen gewünschte Aktion ausführen.

So würde das Standardverhalten aussehen, wenn es unter Verwendung von **-cgetmethod** geschrieben würde:

```
snit::type dog {
    option -color -default brown -cgetmethod GetOption

    method GetOption {option} {
        return $options($option)
    }
}
```

Es kann jede Instanzmethode verwendet werden, sofern sie ein Argument akzeptiert, nämlich den Namen der Option, deren Wert abgerufen werden soll.

## Wie kann ich Änderungen am Wert einer Option erfassen?

Definieren Sie für die Option eine **-configuremethod**.

## Was ist eine -configuremethod?

„**-configuremethod**“ ist eine Methode, die immer dann aufgerufen wird, wenn der zugehörigen Option über die Instanzmethoden „**configure**“ oder „**configurelist**“ ein neuer Wert zugewiesen wird. Die Methode kann den Wert an ein anderes Objekt weiterleiten, ihn in einer Datenbank speichern oder jede andere von Ihnen gewünschte Aktion ausführen.

So würde das Standard-Verhalten der Konfiguration aussehen, wenn es unter Verwendung von **-configuremethod** geschrieben würde:

```
snit::type dog {
    option -color -default brown -configuremethod SetOption

    method SetOption {option value} {
        set options($option) $value
    }
}
```

Es kann jede Instanzmethode verwendet werden, sofern sie zwei Argumente entgegennimmt: den Namen der Option und den neuen Wert.

Hinweis: Wenn Ihre Methode den Wert nicht im Array „**options**“ speichert, wird das Array „**options**“ nicht aktualisiert.

## Wie kann ich den Wert einer Option validieren?

Definieren Sie eine **-validatemethod**.

## Was ist eine -validatemethod?

„**-validatemethod**“ ist eine Methode, die immer dann aufgerufen wird, wenn der zugehörigen Option über die Instanzmethoden „**configure**“ oder „**configurelist**“ ein neuer Wert zugewiesen wird.  Es ist Aufgabe der Methode, zu prüfen, ob der neue Wert gültig ist, und andernfalls einen Fehler auszulösen.  Die Methode **-validatemethod** wird, sofern vorhanden, aufgerufen, bevor der Wert im Array **options** gespeichert wird; insbesondere wird sie vor der Methode **-configuremethod** aufgerufen, sofern diese vorhanden ist.

Nehmen wir beispielsweise an, eine Option nimmt stets einen booleschen Wert an. Sie können wie folgt sicherstellen, dass der Wert tatsächlich ein gültiger boolescher Wert ist:

```
% snit::type dog {
    option -shots -default no -validatemethod BooleanOption

    method BooleanOption {option value} {
        if {![string is boolean -strict $value]} {
            error "expected a boolean value, got \"$value\""
        }
    }
}
::dog
% dog fido
% fido configure -shots yes
% fido configure -shots NotABooleanValue
expected a boolean value, got "NotABooleanValue"
%
```

Hinweis: Dieselbe **-validatemethod** kann zur Validierung einer beliebigen Anzahl von booleschen Optionen verwendet werden.

Jede Methode kann als **-validatemethod** fungieren, sofern sie zwei Argumente entgegennimmt: den Namen der Option und den neuen Wert der Option.

# Typvariablen

## Was ist eine Typvariable?

Eine Typvariable ist eine private Variable, die einem Snit-Typ und nicht einer bestimmten Instanz dieses Typs zugeordnet ist. In C++ und Java wird für dasselbe Konzept der Begriff *statische Membervariable* (*static member variable*) verwendet. Typvariablen können Skalare oder Arrays sein.

## Wie wird eine skalare Typvariable definiert?

Skalare Typvariablen werden in der Typdefinition mithilfe der Anweisung [typevariable][snit] definiert. Sie können ihnen einfach einen Namen geben oder sie mit einem Wert initialisieren:

```
snit::type mytype {
    # Define variable "greeting" and initialize it with "Howdy!"
    typevariable greeting "Howdy!"
}
```

Jedes Objekt vom Typ **mytype** hat nun Zugriff auf eine einzelne Variable namens **greeting**.

## Wie wird eine Typvariable mit Array-Wert definiert?

Typvariablen mit Array-Wert werden ebenfalls mit dem Befehl [typevariable][snit] definiert; um sie zu initialisieren, fügen Sie die Option **-array** hinzu:

```
snit::type mytype {
    # Define typearray variable "greetings"
    typevariable greetings -array {
        formal "Good Evening"
        casual "Howdy!"
    }
}
```

## Was geschieht, wenn ich eine Typvariable nicht initialisiere?

Variablen existieren erst dann wirklich, wenn ihnen Werte zugewiesen werden. Wenn Sie eine Variable bei ihrer Definition nicht initialisieren, müssen Sie darauf achten, ihr (beispielsweise im Typkonstruktor) einen Wert zuzuweisen, bevor Sie darauf verweisen.

## Gibt es Einschränkungen hinsichtlich der Namen von Typvariablen?

Für Namen von Typvariablen gelten dieselben Einschränkungen wie für Namen von [Instanzvariablen].

## Muss ich meine Typvariablen in meinen Methoden deklarieren?

Nein. Sobald Sie eine Typvariable in der Typdefinition definiert haben, kann diese in [Instanzmethoden] oder [Typmethoden] ohne Deklaration verwendet werden. Dies weicht von der üblichen Tcl-Praxis ab, bei der alle nicht-lokalen Variablen in einer Prozedur deklariert werden müssen.

Typvariablen unterliegen denselben Kompromissen zwischen Geschwindigkeit und Lesbarkeit wie Instanzvariablen; siehe [Muss ich meine Instanzvariablen in meinen Methoden deklarieren?]

## Wie übergebe ich den Namen einer Typvariablen an ein anderes Objekt?

In Tk ist es üblich, einem Widget einen Namen einer Variablen zu übergeben; beispielsweise verfügen Tk-Label-Widgets über die Option „**-textvariable**“, die den Namen der Variablen angibt, die den Text des Widgets enthält.  Dadurch kann das Programm den Wert des Labels aktualisieren, indem es der Variable einfach einen neuen Wert zuweist.

Wenn Sie dem Label-Widget naiv einen Typvariablennamen übergeben, wird Sie das Ergebnis verwirren; Tk geht davon aus, dass der Name eine globale Variable bezeichnet. Stattdessen müssen Sie einen vollständig qualifizierten Variablennamen angeben.  Innerhalb einer Instanzmethode oder eines Konstruktors können Sie den Namen der Typvariablen mithilfe des Befehls [mytypevar][snit] vollständig qualifizieren:

```
snit::widget mywidget {
    typevariable labeltext ""

    constructor {args} {
        # ...

        label $win.label -textvariable [mytypevar labeltext]

        # ...
    }
}
```

## Wie mache ich eine Typvariable öffentlich?

Dafür gibt es zwei Möglichkeiten. Die bevorzugte Vorgehensweise besteht darin, zwei [Typmethoden] zu schreiben, um den Wert der Typvariablen festzulegen und abzufragen.

Typvariablen werden im Namespace des Typs gespeichert, der denselben Namen wie der Typ selbst trägt. Daher können Sie den Namen der Typvariablen auch in Ihrer Dokumentation veröffentlichen, damit Clients direkt darauf zugreifen können. Zum Beispiel:

```
snit::type mytype {
    typevariable myvariable
}

set ::mytype::myvariable "New Value"
```

# Typmethoden

## Was ist eine Typmethode?

Eine Typmethode ist eine Prozedur, die nicht mit einer bestimmten Instanz des Typs, sondern mit dem Typ selbst verknüpft ist und als Unterbefehl des Typbefehls aufgerufen wird.

## Wie definiere ich eine Typmethode?

Typmethoden werden in der Typdefinition mithilfe der Anweisung **typemethod** definiert:

```
snit::type dog {
    # List of pedigreed dogs
    typevariable pedigreed

    typemethod pedigreedDogs {} {
        return $pedigreed
    }
}
```

Angenommen, der Typ „**dog**“ verwaltet eine Liste mit den Namen der Hunde, die über einen Stammbaum verfügen. Die Typmethode **pedigreedDogs** gibt diese Liste zurück.

Die Anweisung „**typemethod**“ sieht genauso aus wie eine normale Tcl-Anweisung „[proc][snit]“, mit dem Unterschied, dass sie in einer [snit::type][snit]-Definition vorkommt. Beachten Sie, dass jede Typmethode ein implizites Argument namens **type** erhält, das den vollqualifizierten Typnamen enthält.

## Wie ruft ein Client eine Typmethode auf?

Der Name der Typmethode wird zu einem Unterbefehl des Typbefehls. Nehmen wir beispielsweise an, dass der Konstruktor jeden Rassehund zur Liste von **pedigreedDogs** hinzufügt,

```
snit::type dog {
    option -pedigreed 0

    # List of pedigreed dogs
    typevariable pedigreed

    typemethod pedigreedDogs {} {
        return $pedigreed
    }

    # ...
}

dog spot -pedigreed 1
dog fido

foreach dog [dog pedigreedDogs] { ... }
```

## Gibt es Einschränkungen hinsichtlich der Namen von Typmethoden?

Nicht wirklich, solange Sie die Namen der Standard-Typmethoden vermeiden: **create**, **destroy** und **info**.

## Wie kann ich eine Typmethode als privat deklarieren?

Manchmal ist es sinnvoll, private Typmethoden zu definieren, d. h. Typmethoden, die ausschließlich von anderen Typ- oder Instanzmethoden desselben Objekts aufgerufen werden sollen.

Snit sieht keine Zugriffskontrolle für Typmethoden vor; gemäß Konvention beginnen die Namen öffentlicher Methoden mit einem Kleinbuchstaben, während die Namen privater Methoden mit einem Großbuchstaben beginnen.

Alternativ kann ein Snit [proc][snit] als private Typmethode verwendet werden; siehe [Prozeduren].

## Gibt es Einschränkungen hinsichtlich der Argumente von Typmethoden?

Argumentlisten für Methoden werden genau wie normale Argumentlisten für Tcl-Prozeduren definiert; insbesondere können sie Argumente mit Standardwerten sowie das Argument **args** enthalten.

Jede Typmethode wird jedoch mit einem impliziten Argument namens **type** aufgerufen, das den Namen des Typbefehls enthält. Darüber hinaus sollten Typmethoden gemäß der Konvention die Verwendung von Namen vermeiden, die implizit für [Instanzmethoden] definiert sind.

## Wie ruft eine Instanz- oder Typmethode eine Typmethode auf?

Wenn eine Instanz- oder Typmethode eine Typmethode aufrufen muss, sollte sie hierfür **$type** verwenden:

```
snit::type dog {

    typemethod pedigreedDogs {} { ... }

    typemethod printPedigrees {} {
        foreach obj [$type pedigreedDogs] { ... }
    }
}
```

## Wie übergebe ich eine Typmethode als Rückruffunktion?

In Tcl ist es üblich, einen Codeausschnitt an ein anderes Objekt zu übergeben, damit dieses ihn später aufruft. Da Typen nicht umbenannt werden können, können Sie einfach den Typnamen verwenden oder – wenn die Rückruffunktion aus einer Typmethode heraus registriert wird – **type**.  Nehmen wir beispielsweise an, wir möchten eine Liste von Rassehunden ausgeben, wenn eine Tk-Schaltfläche gedrückt wird:

```
button .btn -text "Pedigrees" -command [list dog printPedigrees]
pack .btn
```

Alternativ können Sie aus einer Methode oder einer Typmethode den Befehl [mytypemethod][snit] verwenden, genauso wie Sie [mymethod][snit] verwenden würden, um einen Rückrufbefehl für [Instanzmethoden] zu definieren.

## Können Typmethoden hierarchisch sein?

Ja, Sie können hierarchische Typmethoden auf genau dieselbe Weise definieren wie hierarchische Instanzmethoden. Weitere Informationen finden Sie unter [Instanzmethoden].

# Prozeduren

## Was ist eine Prozedur?

Ein „Snit [proc][snit]“ ist im Grunde nichts anderes als eine Tcl-Prozedur, die innerhalb des Namespaces des Typs definiert ist. Sie können Prozeduren für privaten Code verwenden, der nicht mit einer bestimmten Instanz in Verbindung steht.

## Wie definiere ich eine Prozedur?

Prozeduren werden definiert, indem eine [proc][snit]-Anweisung in die Typdefinition aufgenommen wird:

```
snit::type mytype {
    # Pops and returns the first item from the list stored in the
    # listvar, updating the listvar
   proc pop {listvar} { ... }

   # ...
}
```

## Gibt es Einschränkungen hinsichtlich der Namen von Prozeduren?

Es kann jeder beliebige Name verwendet werden, solange er nicht mit „**Snit\_**“ beginnt; Namen, die mit „**Snit\_**“ beginnen, sind für die eigene Verwendung durch Snit reserviert. Der umsichtige Programmierer wird jedoch [proc][snit]-Namen (**set**, **list**, **if** usw.) vermeiden, die Standardbefehle von Tcl verdecken würden.

Da [proc][snit]s privat sind, sollten ihre Namen gemäß der Konvention mit einem Großbuchstaben beginnen; da es jedoch in der Regel keine öffentlichen [proc][snit]s im Namespace des Typs gibt, spielt dies letztlich keine große Rolle.

## Wie ruft eine Methode eine Prozedur auf?

Genau wie beim Aufruf eines beliebigen Tcl-Befehls.  Zum Beispiel:

```
snit::type mytype {
    # Pops and returns the first item from the list stored in the
    # listvar, updating the listvar
    proc pop {listvar} { ... }

    variable requestQueue {}

    # Get one request from the queue and process it.
    method processRequest {} {
        set req [pop requestQueue]
    }
}
```

## Wie kann ich eine Prozedur als Rückruffunktion an ein anderes Objekt übergeben?

Der Befehl [myproc][snit] gibt einen Rückrufbefehl für die [proc][snit] zurück, genau wie [mymethod][snit] dies für eine Methode tut.

# Typkonstruktoren

## Was ist ein Typkonstruktor?

Ein Typkonstruktor ist ein Codeabschnitt, der den Typ als Ganzes initialisiert, ähnlich wie ein statischer Initialisierer in C++. Der Codeabschnitt eines Typkonstruktors wird einmalig bei der Definition des Typs ausgeführt und danach nie wieder.

Ein Typ kann höchstens einen Typkonstruktor haben.

## Wie definiere ich einen Typkonstruktor?

Ein Typkonstruktor wird durch die Verwendung der Anweisung [typeconstructor][snit] in der Typdefinition definiert. Nehmen wir beispielsweise an, der Typ verwendet eine Typvariable mit Array-Wert als Nachschlagetabelle, und die Werte im Array müssen beim Programmstart berechnet werden.

```
% snit::type mytype {
    typevariable lookupTable

    typeconstructor {
        array set lookupTable {key value...}
    }
}
```

# Konstruktoren

## Was ist ein Konstruktor?

In der objektorientierten Programmierung ist der Konstruktor eines Objekts dafür zuständig, das Objekt bei seiner Erstellung vollständig zu initialisieren. Der Konstruktor erhält die Liste der Optionen, die an die Methode **create** des Befehls [snit::type][snit] übergeben wurden, und kann anschließend beliebige Aktionen ausführen.  Dazu können beispielsweise die Berechnung von Werten für Instanzvariablen, das Einlesen von Daten aus Dateien, das Anlegen weiterer Objekte, die Aktualisierung von Typ- und Instanzvariablen sowie weitere Vorgänge gehören.

Der Rückgabewert des Konstruktors wird ignoriert (es sei denn, es handelt sich natürlich um einen Fehler).

## Wie definiere ich einen Konstruktor?

Ein Konstruktor wird mithilfe der Anweisung [constructor][snit] in der Typdefinition definiert.  Angenommen, es soll eine Liste aller Rassehunde geführt werden. Diese Liste kann in einer Typvariablen verwaltet und über eine Typmethode abgerufen werden. Immer wenn ein Hund angelegt wird, kann er sich selbst in die Liste eintragen – vorausgesetzt, er ist beim American Kennel Club registriert.

```
% snit::type dog {
    option -akc 0

    typevariable akcList {}

    constructor {args} {
        $self configurelist $args

        if {$options(-akc)} {
            lappend akcList $self
        }
    }

    typemethod akclist {} {
        return $akcList
    }
}
::dog
% dog spot -akc 1
::spot
% dog fido
::fido
% dog akclist
::spot
%
```

## Was bewirkt der Standard-Konstruktor?

Wenn Sie keinen Konstruktor explizit angeben, wird der Standardkonstruktor verwendet, der mit dem hier gezeigten, explizit definierten Konstruktor identisch ist:

```
snit::type dog {
    constructor {args} {
        $self configurelist $args
    }
}
```

Wenn der Konstruktor aufgerufen wird, wird **args** auf die Liste der Argumente gesetzt, die dem Namen des Objekts folgen.  Der Konstruktor darf diese Liste nach eigenem Ermessen interpretieren; üblicherweise wird davon ausgegangen, dass es sich um eine Liste von Namen und Werten für Optionen handelt, wie im obigen Beispiel gezeigt. Wenn Sie lediglich die Werte für Optionen speichern möchten, sollten Sie die Methode **configurelist** verwenden, wie dargestellt.

## Kann ich für den Konstruktor andere Argumente auswählen?

Ja, das ist möglich. Nehmen wir beispielsweise an, wir möchten sicherstellen, dass die Rasse für jeden Hund zum Zeitpunkt der Erstellung ausdrücklich angegeben wird und danach nicht mehr geändert werden kann. Eine Möglichkeit, dies zu erreichen, ist folgende:

```
% snit::type dog {
    variable breed

    option -color brown
    option -akc 0

    constructor {theBreed args} {
        set breed $theBreed
        $self configurelist $args
    }

    method breed {} { return $breed }
}
::dog
% dog spot dalmatian -color spotted -akc 1
::spot
% spot breed
dalmatian
```

Der Nachteil besteht darin, dass diese Syntax nicht den Standards entspricht und die Kompatibilität Ihres neuen Typs mit dem Code anderer Entwickler einschränken könnte. Snit geht beispielsweise davon aus, dass es [Komponenten] mithilfe der Standard-Erstellungssyntax erstellen kann.

## Gibt es Einschränkungen hinsichtlich der Argumente des Konstruktors?

Für Argumentlisten von Konstruktoren gelten dieselben Einschränkungen wie für Argumentlisten von Instanzmethoden. Sie weisen dieselben impliziten Argumente auf und können Standardwerte sowie das Argument **args** enthalten.

## Gibt es beim Schreiben des Konstruktors etwas Besonderes zu beachten?

Ja. Das Schreiben des Konstruktors kann schwierig sein, wenn Sie Optionen an Komponenten weiterleiten, und es gibt spezifische Probleme im Zusammenhang mit [snit::widget][snit]s und [snit::widgetadaptor][snit]s.  Siehe [Weiterleitung], [Widgets], [Widget-Adapter] und [Tk-Optionsdatenbank].

# Destruktoren

## Was ist ein Destruktor?

Ein Destruktor ist eine besondere Art von Methode, die aufgerufen wird, wenn ein Objekt zerstört wird. Er ist dafür zuständig, alle notwendigen Aufräumarbeiten durchzuführen, wenn das Objekt entfernt wird: [Komponenten] zu zerstören, Dateien zu schließen und so weiter.

## Wie definiere ich einen Destruktor?

Destruktoren werden mithilfe der Anweisung [destructor][snit] in der Typdefinition definiert.

Nehmen wir an, wir führen eine Liste mit Rassehunden; dann möchten wir Hunde aus dieser Liste entfernen, wenn sie zerstört werden.

```
snit::type dog {
    option -akc 0

    typevariable akcList {}

    constructor {args} {
        $self configurelist $args

        if {$options(-akc)} {
            lappend akcList $self
        }
    }

    destructor {
        set ndx [lsearch $akcList $self]

        if {$ndx != -1} {
            set akcList [lreplace $akcList $ndx $ndx]
        }
    }

    typemethod akclist {} {
        return $akcList
    }
}
```

## Gibt es Einschränkungen hinsichtlich der Argumente von Destruktoren?

Ja; ein Destruktor hat keine expliziten Argumente.

## Welche impliziten Argumente werden an den Destruktor übergeben?

Der Destruktor erhält dieselben impliziten Argumente, die an **INSTANZMETHODEN** übergeben werden: **type**, **selfns**, **win** und **self**.

## Müssen Komponenten explizit zerstört werden?

Ja und nein.

Alle Tk-Widgets, die von einem [snit::widget][snit] oder [snit::widgetadaptor][snit] erstellt wurden, werden von Tk automatisch zerstört, wenn das Megawidget zerstört wird – dies entspricht dem üblichen Tk-Verhalten (die Zerstörung eines übergeordneten Widgets führt zur Zerstörung des gesamten Baums).

Komponenten normaler **snit::types** hingegen werden niemals automatisch zerstört, ebenso wenig wie Nicht-Widget-Komponenten von Snit-Megawidgets. Wenn Ihr Objekt diese in seinem Konstruktor erstellt, sollte es sie in der Regel in seinem Destruktor wieder löschen.

## Gibt es etwas Besonderes beim Schreiben eines Destruktors zu beachten?

Ja. Wenn der Konstruktor eines Objekts einen Fehler auslöst, wird der Destruktor des Objekts zur Bereinigung aufgerufen; dies bedeutet, dass das Objekt zum Zeitpunkt des Aufrufs des Destruktors möglicherweise noch nicht vollständig instanziiert ist. Dies kann dazu führen, dass der Destruktor einen eigenen Fehler auslöst; das Ergebnis ist in der Regel irreführend, verwirrend und wenig hilfreich.  Daher ist es wichtig, Ihren Destruktor so zu schreiben, dass er ausfallsicher ist.

Beispielsweise könnte ein **dog** eine **tail**-Komponente erstellen; diese Komponente muss dann gelöscht werden.  Angenommen jedoch, bei der Verarbeitung der Erstellungsoptionen tritt ein Fehler auf – dann wird der Destruktor aufgerufen, und es gibt kein **tail**, das zerstört werden könnte. Die einfachste Lösung besteht in der Regel darin, etwaige Fehler beim Zerstören von Komponenten abzufangen und zu ignorieren.

```
snit::type dog {
    component tail

    constructor {args} {
        $self configurelist $args

        set tail [tail %AUTO%]
    }

    destructor {
        catch {$tail destroy}
    }
}
```

# Komponenten

## Was ist eine Komponente?

Häufig erstellt und verwaltet ein Objekt eine Reihe weiterer Objekte. Ein Snit-Megawidget erstellt beispielsweise oft eine Reihe von Tk-Widgets. Diese Objekte sind Teil des Hauptobjekts; es setzt sich aus ihnen zusammen, weshalb sie als Komponenten des Objekts bezeichnet werden.

Snit verwendet **COMPONENT** jedoch auch in einer genaueren Bedeutung. Die Komponenten eines Snit-Objekts sind jene Objekte, an die Methoden oder Optionen weitergeleitet werden können. (Weitere Informationen zur Weiterleitung finden Sie unter [Weiterleitung].)

## Wie deklariere ich eine Komponente?

Zunächst müssen Sie festlegen, welche Rolle eine Komponente innerhalb Ihres Objekts spielt, und dieser Rolle einen Namen geben. Anschließend deklarieren Sie die Komponente unter Verwendung ihres Rollennamens und der Anweisung [component][snit].  Die Anweisung [component][snit] deklariert eine *Instanzvariable*, in der der Name des Befehls der Komponente gespeichert wird, wenn die Komponente angelegt wird.

Nehmen wir beispielsweise an, Ihr Objekt „**dog**“ erstellt ein Objekt „**tail**“ (zweifellos, um damit besser herumwedeln zu können):

```
snit::type dog {
    component mytail

    constructor {args} {
        # Create and save the component's command
        set mytail [tail %AUTO% -partof $self]
        $self configurelist $args
    }

    method wag {} {
        $mytail wag
    }
}
```

Wie hier zu sehen ist, spielt es keine Rolle, wie der tatsächliche Name des Objekts „**tail**“ lautet; das Objekt „**dog**“ verweist über den Komponentennamen darauf.

Das obige Beispiel zeigt eine Möglichkeit, die Methode **wag** an die Komponente **mytail** weiterzuleiten; eine einfachere Vorgehensweise finden Sie unter [Weiterleitung].

## Wie wird eine Komponente benannt?

Eine Komponente hat zwei Namen. Der erste Name ist der der Komponentenvariablen; dieser steht für die Rolle, die das Komponentenobjekt innerhalb des Snit-Objekts spielt. Dies ist der eigentliche Komponentenname und der Name, mit dem im Snit-Code auf die Komponente Bezug genommen wird.  Der zweite Name ist der Name des eigentlichen Komponentenobjekts, das vom Konstruktor des Snit-Objekts erstellt wurde. Dieser zweite Name ist stets ein Tcl-Befehlsname und wird als Objektname der Komponente bezeichnet.

Im Beispiel der vorherigen Frage lautet der Name der Komponente „**mytail**“; der Objektname der Komponente **mytail** wird von Snit automatisch gewählt, da beim Erstellen des Komponentenobjekts **%AUTO%** verwendet wurde.

## Gibt es Einschränkungen hinsichtlich der Namen von Komponenten?

Ja.  [snit::widget][snit]- und [snit::widgetadaptor][snit]-Objekte verfügen über eine spezielle Komponente, die **hull**-Komponente; daher sollte der Name **hull** für keinen anderen Zweck verwendet werden.

Da es sich bei den Namen der Komponenten im Übrigen tatsächlich um Namen von Instanzvariablen handelt, müssen sie den Regeln für [Instanzvariablen] entsprechen.

## Was ist eine eigene Komponente?

Eine *eigene* Komponente ist eine Komponente, deren Objektbefehl in seiner Lebensdauer von dem [snit::type][snit] oder [snit::widget][snit] gesteuert wird.

Wie oben bereits erwähnt, ist eine Komponente ein Objekt, an das unser Objekt Methoden oder Optionen weiterleiten kann. Nach dieser Definition erstellt unser Objekt in der Regel seine eigenen Komponentenobjekte, was jedoch nicht zwingend erforderlich ist. Betrachten Sie folgendes Beispiel: Ein Hundeobjekt verfügt über eine Schwanzkomponente; die Schwanzkomponente weiß jedoch, dass sie Teil des Hundes ist:

```
snit::type dog {
    component mytail

    constructor {args} {
        set mytail [tail %AUTO% -partof $self]
        $self configurelist $args
    }

    destructor {
        catch {$mytail destroy}
    }

    delegate method wagtail to mytail as wag

    method bark {} {
        return "$self barked."
    }
}

 snit::type tail {
     component mydog
     option -partof -readonly yes

     constructor {args} {
         $self configurelist $args
         set mydog $options(-partof)
     }

     method wag {} {
         return "Wag, wag."
     }

     method pull {} {
         $mydog bark
     }
 }
```

Wenn Sie also einen Hund auffordern, mit dem Schwanz zu wedeln, weist er seinen Schwanz an, zu wedeln; und wenn Sie am Schwanz des Hundes ziehen, weist der Schwanz den Hund an, zu bellen. In diesem Szenario ist der Schwanz eine Komponente des Hundes und der Hund eine Komponente des Schwanzes, doch der Hund besitzt den Schwanz und nicht umgekehrt.

## Was bewirkt der Befehl „install“?

Der Befehl [install][snit] erstellt mithilfe eines angegebenen Befehls eine eigene Komponente und weist das Ergebnis der Instanzvariablen der Komponente zu. Beispiel:

```
snit::type dog {
    component mytail

    constructor {args} {
        # set mytail [tail %AUTO% -partof $self]
        install mytail using tail %AUTO% -partof $self
        $self configurelist $args
    }
}
```

Im Code eines [snit::type][snit] entspricht der oben gezeigte Befehl [install][snit] dem Befehl **set mytail**, der auskommentiert ist.  Im Code von „[snit::widget][snit]“ oder „[snit::widgetadaptor][snit]“ hingegen fragt der Befehl [install][snit] zusätzlich die [Tk-Optionsdatenbank] ab und initialisiert die Optionen der neuen Komponente entsprechend.  Aus Gründen der Konsistenz empfiehlt es sich, sich anzugewöhnen, für alle eigenen Komponenten den Befehl [install][snit] zu verwenden.

## Müssen eigene Komponenten im Konstruktor angelegt werden?

Nein, nicht unbedingt. Tatsächlich gibt es keinen Grund, warum ein Objekt eine Komponente im Laufe seiner eigenen Lebensdauer nicht mehrfach zerstören und neu erstellen sollte.

## Gibt es Einschränkungen hinsichtlich der Namen von Komponentenobjekten?

Ja.

Komponentenobjekte, bei denen es sich um Tk-Widgets oder Megawidgets handelt, müssen gültige Tk-Fensternamen aufweisen.

Komponentenobjekte, die keine Widgets oder Megawidgets sind, müssen über vollständig qualifizierte Befehlsnamen verfügen, d. h. Namen, die den vollständigen Namespace des Befehls enthalten. Beachten Sie, dass Snit Objekte stets mit vollständig qualifizierten Namen erstellt.

Außerdem müssen die Objektnamen der Komponenten, die sich im Besitz Ihres Objekts befinden, eindeutig sein. Für Widget-Komponenten stellt dies kein Problem dar, da Widget-Namen stets eindeutig sind; betrachten Sie jedoch den folgenden Code:

```
snit::type tail { ... }

snit::type dog {
    delegate method wag to mytail

    constructor {} {
        install mytail using tail mytail
    }
}
```

Dieser Code verwendet den Namen der Komponente „**mytail**“ als Namen des Objekts der Komponente. Dies ist nicht sinnvoll, und zwar aus folgendem Grund: Der Code einer Snit-Instanz wird im Namespace des Snit-Typs ausgeführt.  In diesem Fall wird die Komponente „**mytail**“ im Namespace „**::dog::**“ erstellt und erhält somit den Namen „**::dog::mytail**“.

Nehmen wir nun an, Sie erstellen zwei Hunde. Beide Hunde werden versuchen, einen Schwanz namens **::dog::mytail** zu erstellen. Der erste wird dabei erfolgreich sein, der zweite hingegen nicht, da Snit die Erstellung eines Objekts nicht zulässt, wenn dessen Name bereits ein Befehl ist. Hier sind zwei Möglichkeiten, diese Situation zu vermeiden:

Erstens: Wenn es sich bei dem Komponententyp um „[snit::type][snit]“ handelt, können Sie „**%AUTO%**“ als Namen festlegen und haben so die Gewissheit, einen eindeutigen Namen zu erhalten. Dies ist die sicherste Vorgehensweise:

```
    install mytail using tail %AUTO%
```

Wenn der Komponententyp nicht „[snit::type][snit]“ lautet, können Sie die Komponente im Namespace der Instanz des Objekts anlegen:

```
    install mytail using tail ${selfns}::mytail
```

Achten Sie darauf, einen eindeutigen Namen innerhalb des Namespaces der Instanz zu wählen.

## Muss ich meine eigenen Komponenten zerstören?

Das hängt davon ab. Wenn ein übergeordnetes Widget zerstört wird, werden alle untergeordneten Widgets automatisch zerstört. Wenn Ihr Objekt also ein [snit::widget][snit] oder [snit::widgetadaptor][snit] ist, müssen Sie keine Komponenten-Widgets löschen, da diese in der Regel Kinder oder Nachkommen Ihres Megawidgets sind.

Sollte Ihr Objekt jedoch eine Instanz von [snit::type][snit] sein, wird keine seiner eigenen Komponenten automatisch zerstört; ebenso wenig werden Nicht-Widget-Komponenten eines [snit::widget][snit] automatisch zerstört.  Alle derartigen eigenen Komponenten müssen explizit zerstört werden, andernfalls werden sie überhaupt nicht zerstört.

## Kann ich den Objektbefehl einer Komponente als Teil meiner Schnittstelle verfügbar machen?

Ja, und es gibt zwei Möglichkeiten, dies zu bewerkstelligen. Die geeignetste Vorgehensweise ist in der Regel die Weiterleitung (siehe [Weiterleitung]). Durch Weiterleitung können Sie die von Ihnen festgelegten Optionen und Methoden an bestimmte Komponenten weitergeben. Dadurch werden die Komponenten für die Nutzer Ihres Typs effektiv verborgen, was eine gute Kapselung gewährleistet.

Es gibt jedoch Fälle, in denen es angebracht – und obendrein einfacher – ist, die gesamte Komponente einfach zum Teil der öffentlichen Schnittstelle Ihres Typs zu machen.

## Wie kann ich den Objektbefehl einer Komponente verfügbar machen?

Geben Sie bei der Deklaration der Komponente die Option „**-public**“ der Anweisung „[component][snit]“ an. Der Wert dieser Option ist der Name einer Methode, die an den Objektbefehl Ihrer Komponente weitergeleitet wird.

Nehmen wir beispielsweise an, Sie haben ein Combobox-Megawidget erstellt, das ein listbox-Widget enthält, und Sie möchten die gesamte Schnittstelle der Listbox öffentlich machen. Das können Sie wie folgt bewerkstelligen:

```
snit::widget combobox {
     component listbox -public listbox

     constructor {args} {
         install listbox using listbox $win.listbox ....
     }
}

combobox .mycombo
.mycombo listbox configure -width 30
```

Ihr Combobox-Widget „**.mycombo**“ verfügt nun über die Methode „**listbox**“, die dieselben Unterbefehle wie das listbox-Widget selbst enthält. Der obige Code legt somit die Breite der Listbox-Komponente auf 30 fest.

In der Regel wählen Sie als Namen der Methode denselben Namen wie den der Komponente; Sie können die Methode jedoch beliebig benennen.

# Typkomponenten

## Was ist eine Typkomponente?

Eine Typkomponente ist eine Komponente, die nicht zu einer bestimmten Instanz des Typs, sondern zum Typ selbst gehört. Die Beziehung zwischen Komponenten und Typkomponenten entspricht der Beziehung zwischen [Instanzvariablen] und [Typvariablen].  Sowohl [Instanzmethoden] als auch [Typmethoden] können an Typkomponenten weitergeleitet werden.

Sobald Sie [Komponenten] und [Weiterleitung] verstanden haben, sind Typkomponenten im Grunde nichts Neues.

## Wie deklariere ich eine Typkomponente?

Deklarieren Sie eine Typkomponente mithilfe der Anweisung [typecomponent][snit].  Sie akzeptiert dieselben Optionen (**-inherit** und **-public**) wie die Anweisung [component][snit] und definiert eine Typvariable, die den Objektbefehl der Typkomponente enthält.

Angenommen, in Ihrem Modell gibt es viele Hunde, aber nur einen Tierarzt. Sie könnten den Tierarzt als Typkomponente definieren.

```
snit::type veterinarian { ... }

snit::type dog {
    typecomponent vet

    # ...
}
```

## Wie installiere ich eine Typkomponente?

Verwenden Sie einfach den Befehl **set**, um den Objektbefehl der Komponente der Typkomponente zuzuweisen.  Da Typen (auch [snit::widget][snit]-Typen) keine Widgets sind und ohnehin keine Optionen besitzen, werden die zusätzlichen Funktionen des Befehls [install][snit] nicht benötigt.

In der Regel installieren Sie Typkomponenten im Typkonstruktor, wie hier gezeigt:

```
snit::type veterinarian { ... }

snit::type dog {
    typecomponent vet

    typeconstructor {
        set vet [veterinarian %AUTO%]
    }
}
```

## Gibt es Einschränkungen hinsichtlich der Namen von Typkomponenten?

Ja, genau wie bei [Instanzvariablen], [Typvariablen] und normalen [Komponenten].

# Weiterleitung

## Was ist Weiterleitung?

Einfach ausgedrückt bedeutet Weiterleitung, dass Sie eine Ihnen übertragene Aufgabe an einen Ihrer Assistenten weitergeben. (Sie haben doch Assistenten, oder?) Snit-Objekte können dasselbe tun.  Das folgende Beispiel zeigt eine Möglichkeit, wie das Objekt „**dog**“ seine Methode „**wag**“ und seine Option „**-taillength**“ an seine Komponente „**tail**“ weiterleiten kann.

```
snit::type dog {
    variable mytail

    option -taillength -configuremethod SetTailOption -cgetmethod GetTailOption

    method SetTailOption {option value} {
         $mytail configure $option $value
    }

    method GetTailOption {option} {
         $mytail cget $option
    }

    method wag {} {
        $mytail wag
    }

    constructor {args} {
        install mytail using tail %AUTO% -partof $self
        $self configurelist $args
    }

}
```

Dies ist zwar der umständliche Weg, verdeutlicht jedoch, worum es bei der Weiterleitung eigentlich geht. Die einfache Vorgehensweise finden Sie in den folgenden Antworten.

Hinweis: Der Konstruktor ruft die Methode **configurelist** erst auf, **nachdem** er sein **tail** angelegt hat; andernfalls würde ein Fehler auftreten, wenn „**-taillength**“ in der Liste von „**args**“ enthalten wäre.

## Wie leite ich eine Methode an ein Komponentenobjekt weiter?

Da die Weiterleitung so häufig vorkommt, macht Snit sie Ihnen leicht. Jede Methode kann an jede Komponente oder Typkomponente weitergeleitet werden, indem eine einzige [delegate][snit]-Anweisung in die Typdefinition aufgenommen wird. (Weitere Informationen zu Komponentennamen finden Sie unter [Komponenten] und [Typkomponenten].)

Hier ist beispielsweise eine viel bessere Möglichkeit, die Methode „**wag**“ des Objekts „**dog**“ weiterzuleiten:

```
% snit::type dog {
    delegate method wag to mytail

    constructor {} {
        install mytail using tail %AUTO%
    }
}
::dog
% snit::type tail {
    method wag {} { return "Wag, wag, wag."}
}
::tail
% dog spot
::spot
% spot wag
Wag, wag, wag.
```

Dieser Code hat dieselbe Wirkung wie der unter der vorherigen Frage gezeigte Code: Wenn die Methode **wag** eines **dog** aufgerufen wird, werden der Aufruf und seine Argumente automatisch an das Objekt **tail** weitergeleitet.

Hinweis: Wenn eine Komponente in einer [delegate][snit]-Anweisung erwähnt wird, wird die Instanzvariable der Komponente implizit definiert. Es empfiehlt sich jedoch weiterhin, diese mithilfe der [component][snit]-Anweisung explizit zu deklarieren.

Hinweis: Sie können den Namen einer Methode entweder mit der Anweisung **method** oder mit [delegate][snit] definieren; Sie können nicht beides tun.

## Kann ich an eine Methode mit anderem Namen weiterleiten?

Angenommen, Sie möchten die Methode „**wagtail**“ von „**dog**“ an die Methode „**wag**“ von „**tail**“ weiterleiten.  Schließlich wedeln Sie mit dem Schwanz, nicht mit dem Hund. Das ist ganz einfach:

```
snit::type dog {
    delegate method wagtail to mytail as wag

    constructor {args} {
        install mytail using tail %AUTO% -partof $self
        $self configurelist $args
    }
}
```

## Kann ich an eine Methode mit zusätzlichen Argumenten weiterleiten?

Angenommen, die Methode **wag** von **tail** nimmt als Argument entgegen, wie oft der Schwanz wedeln soll.  Sie möchten die Methode „**wagtail**“ von „**dog**“ an die Methode „**wag**“ von „**tail**“ weiterleiten, wobei Sie festlegen möchten, dass der Schwanz genau dreimal wedeln soll. Auch dies ist ganz einfach:

```
snit::type dog {
    delegate method wagtail to mytail as {wag 3}
    # ...
}

snit::type tail {
    method wag {count} {
        return [string repeat "Wag " $count]
    }
    # ...
}
```

## Kann ich eine Methode an etwas anderes als ein Objekt weiterleiten?

Bei der normalen Weiterleitung einer Methode wird davon ausgegangen, dass Sie eine Methode (einen Unterbefehl eines Objektbefehls) an eine Methode eines anderen Objekts (einen Unterbefehl eines anderen Objektbefehls) weiterleiten. Allerdings folgen nicht alle Tcl-Objekte den Tk-Konventionen, und nicht alles, an das Sie eine Methode weiterleiten möchten, ist zwangsläufig ein Objekt.  Daher ermöglicht Snit es Ihnen, mithilfe der Klausel **using** der Anweisung [delegate][snit] eine Methode ganz einfach an nahezu alles weiterzuleiten, was Sie möchten.

Angenommen, Ihre Hundesimulation speichert Hunde in einer Datenbank, wobei jeder Hund als einzelner Datensatz vorliegt. Die von Ihnen verwendete Datenbank-API stellt eine Reihe von Befehlen zur Verwaltung von Datensätzen bereit; jeder davon nimmt die Datensatz-ID (eine von Ihnen gewählte Zeichenfolge) als erstes Argument entgegen. Beispielsweise speichert der Befehl „**saverec**“ einen Datensatz.  Wenn Sie die Datensatz-ID als Namen des Hundeobjekts verwenden, können Sie die Methode **save** des Hundes wie folgt an den Befehl **saverec** weiterleiten:

```
snit::type dog {
    delegate method save using {saverec %s}
}
```

Wenn die Methode „**save**“ aufgerufen wird, wird „**%s**“ durch den Namen der Instanz ersetzt; etwaige zusätzliche Argumente werden dem resultierenden Befehl angehängt.

Die Klausel **using** versteht eine Reihe weiterer %-Ersetzungen; neben dem Namen der Instanz können Sie den Namen der Methode (**%m**), den Namen des Typs (**%t**), den Namespace der Instanz (**%n**), den Tk-Fensternamen (**%w**) sowie – wenn in der Anweisung [delegate][snit] ein Name einer Komponente oder einer Typkomponente angegeben wurde – den Objektbefehl der Komponente (**%c**) einsetzen.

## Wie leite ich eine Methode an ein Typkomponenten-Objekt weiter?

Genau so, wie Sie es bei einer Komponente tun würden. Die Anweisung [delegate method][snit] akzeptiert in ihrer Klausel **to** sowohl Namen von Komponenten als auch Namen von Typkomponenten.

## Wie leite ich eine Typmethode an ein Typkomponenten-Objekt weiter?

Verwenden Sie die Anweisung [delegate typemethod][snit].  Sie funktioniert wie [delegate method][snit], weist jedoch folgende Unterschiede auf: Erstens definiert sie eine Typmethode anstelle einer Instanzmethode; zweitens ignoriert die Klausel **using** die %-Ersetzungen **%s**, **%n** und **%w**.

Selbstverständlich können Sie eine Typmethode nicht an eine Instanzkomponente weiterleiten … Snit wüsste nicht, welche Instanz sie erhalten soll.

## Wie leite ich eine Option an ein Komponentenobjekt weiter?

Die erste Frage in diesem Abschnitt (siehe [Weiterleitung]) zeigt eine Möglichkeit, eine Option an eine Komponente weiterzuleiten; da dieses Muster jedoch häufig vorkommt, erleichtert Snit die Umsetzung.  Beispielsweise verfügt jedes **tail**-Objekt über eine **-length**-Option; wir möchten dem Ersteller eines **dog**-Objekts ermöglichen, die Länge des Schwanzes festzulegen. Dies können wir wie folgt umsetzen:

```
% snit::type dog {
    delegate option -length to mytail

    constructor {args} {
        install mytail using tail %AUTO% -partof $self
        $self configurelist $args
    }
}
::dog
% snit::type tail {
    option -partof
    option -length 5
}
::tail
% dog spot -length 7
::spot
% spot cget -length
7
```

Dies führt zu nahezu demselben Ergebnis wie die unter der ersten Frage in diesem Abschnitt gezeigten Methoden **-configuremethod** und **-cgetmethod**: Immer wenn die Option **-length** eines **dog**-Objekts gesetzt oder abgerufen wird, wird die Option des zugrunde liegenden **tail**-Objekts ebenfalls gesetzt bzw. abgerufen.

Hinweis: Sie können einen Namen für eine Option entweder mit der Anweisung **option** oder mit [delegate][snit] definieren; Sie können nicht beides tun.

## Kann ich an eine Option mit anderem Namen weiterleiten?

In der vorherigen Antwort haben wir die Option „**-length**“ von „**dog**“ an dessen „**tail**“ weitergeleitet.  Das ist natürlich falsch. Der Hund hat eine Länge, und der Schwanz hat eine Länge, und diese unterscheiden sich voneinander. Was wir eigentlich tun möchten, ist, dem **dog** eine **-taillength**-Option zu geben, diese jedoch an die Option „**-length**“ von „**tail**“ weiterzuleiten:

```
snit::type dog {
    delegate option -taillength to mytail as -length

    constructor {args} {
        set mytail [tail %AUTO% -partof $self]
        $self configurelist $args
    }
}
```

## Wie leite ich jede unbekannte Methode oder Option an ein Komponentenobjekt weiter?

Es kann vorkommen, dass ein Snit-Objekt den Großteil seines Verhaltens von einer seiner Komponenten bezieht. Dies ist beispielsweise häufig bei **snit::widgetadaptors** der Fall, wo wir das Verhalten eines bestehenden Widgets geringfügig anpassen möchten.  Um unser Beispiel mit **dog** fortzusetzen, nehmen wir jedoch an, dass wir einen [snit::type][snit] namens **animal** haben, der eine Vielzahl von Tierverhalten – Fortbewegung, Fressen, Schlafen und so weiter – implementiert. Wir möchten, dass unsere **dog**-Objekte dieselben Verhaltensweisen erben und gleichzeitig eigene, hundeähnliche Verhaltensweisen hinzufügen. So können wir einem **dog** eigene Methoden und Optionen zuweisen und gleichzeitig alle anderen Methoden und Optionen an seine **animal**-Komponente weiterleiten:

```
snit::type dog {
    delegate option * to animal
    delegate method * to animal

    option -akc 0

    constructor {args} {
        install animal using animal %AUTO% -name $self
        $self configurelist $args
    }

    method wag {} {
        return "$self wags its tail"
    }
}
```

Das war’s. Ein **dog** ist nun ein **animal**, das über eine **-akc**-Option verfügt und mit dem Schwanz wedeln (**wag**) kann.

Hinweis: Wir müssen nicht die vollständige Liste der Namen der Methoden oder der Optionen angeben, die **animal** erhalten wird. Es übernimmt alles, was **dog** nicht erkennt – und erkennt es das ebenfalls nicht, löst es einfach einen Fehler aus, genau wie es sein soll.

Sie können zudem alle unbekannten Typmethoden mithilfe von **delegate typemethod \*** an eine Typkomponente weiterleiten.

## Wie leite ich alle Methoden oder Optionen bis auf bestimmte an eine Komponente weiter?

In der vorherigen Antwort haben wir erklärt, dass jedes **dog** ein **animal** ist, indem alle unbekannten Methoden und Optionen an die Komponente **animal** weitergeleitet werden. Was aber, wenn der Typ **animal** einige Methoden oder Optionen enthält, die wir unterdrücken möchten?

Eine Lösung besteht darin, alle Optionen und Methoden explizit weiterzuleiten und auf die Annehmlichkeiten von **delegate method \*** und **delegate option \*** zu verzichten. Wenn wir jedoch nur einige wenige Optionen oder Methoden unterdrücken möchten, gibt es einen einfacheren Weg:

```
snit::type dog {
    delegate option * to animal except -numlegs
    delegate method * to animal except {fly climb}

    # ...

    constructor {args} {
        install animal using animal %AUTO% -name $self -numlegs 4
        $self configurelist $args
    }

    # ...
}
```

Hunde haben vier Beine; daher legen wir dies bei der Erstellung der Komponente **animal** ausdrücklich fest und schließen **-numlegs** ausdrücklich aus der Menge der weitergeleiteten Optionen aus.  Ebenso können Hunde weder **fly** noch **climb** ausführen; daher schließen wir diese **animal**-Methoden wie dargestellt aus.

## Kann eine hierarchische Methode weitergeleitet werden?

Ja; legen Sie einfach mehrere Wörter im Namen der weitergeleiteten Methode an:

```
snit::type tail {
    method wag {} {return "Wag, wag"}
    method droop {} {return "Droop, droop"}
}

snit::type dog {
    delegate method {tail wag} to mytail
    delegate method {tail droop} to mytail

    # ...

    constructor {args} {
        install mytail using tail %AUTO%
        $self configurelist $args
    }

    # ...
}
```

Auch nicht erkannte hierarchische Methoden können weitergeleitet werden; der folgende Code leitet alle Unterbefehle der Methode „tail“ an die Komponente „mytail“ weiter:

```
snit::type dog {
    delegate method {tail *} to mytail

    # ...
}
```

# Widgets

## Was ist ein snit::widget?

Ein [snit::widget][snit] ist die Snit-Version dessen, was Tcl-Programmierer üblicherweise als *Megawidget* bezeichnen: ein widgetähnliches Objekt, das in der Regel aus einem oder mehreren Tk-Widgets besteht, die alle in einem Tk-Frame enthalten sind.

Ein [snit::widget][snit] ist ebenfalls eine besondere Art von [snit::type][snit]. Nahezu alle Angaben in dieser FAQ-Liste, die sich auf **snit::types** beziehen, gelten auch für **snit::widgets**.

## Wie definiere ich ein snit::widget?

**snit::widgets** werden mit dem Befehl [snit::widget][snit] definiert, ebenso wie **snit::types** mit dem Befehl [snit::type][snit] definiert werden.

Der Hauptteil der Definition kann dieselben Arten von Anweisungen enthalten sowie einige weitere, auf die im Folgenden eingegangen wird.

## Inwiefern unterscheiden sich snit::widgets von snit::types?

- Der Name einer Instanz von [snit::type][snit] kann ein beliebiger gültiger Tcl-Befehlsname in einem beliebigen Namespace sein. Der Name einer Instanz von [snit::widget][snit] muss ein gültiger Tk-Widget-Name sein, und das übergeordnete Widget muss bereits vorhanden sein.

- Eine Instanz von [snit::type][snit] kann durch Aufruf ihrer Methode **destroy** zerstört werden.  Instanzen von [snit::widget][snit] verfügen über keine „destroy“-Methode; verwenden Sie stattdessen den Tk-Befehl **destroy**.

- Jede Instanz eines [snit::widget][snit] verfügt über eine vordefinierte Komponente, die als **hull**-Komponente bezeichnet wird. Der Hull ist in der Regel ein Tk-Widget vom Typ „**frame**“ oder „**toplevel**“; alle anderen Widgets, die als Teil des „[snit::widget][snit]“ erstellt wurden, sind in der Regel im Hull enthalten.

- Bei [snit::widget][snit]s können die Optionen Standardwerte aus der [Tk-Optionsdatenbank] erhalten.


## Was ist die Hull-Komponente?

Snit kann kein Tk-Widget-Objekt erstellen; dies ist nur Tk möglich. Daher muss jede Instanz von [snit::widget][snit] um ein echtes Tk-Widget herumgelegt werden; dieses Tk-Widget wird als *Hull-Komponente* bezeichnet. Snit setzt das von Ihnen definierte Verhalten (Methoden, Optionen usw.) gewissermaßen huckepack auf die Hull-Komponente, sodass sich das Ganze wie ein Standard-Tk-Widget verhält.

Bei [snit::widget][snit]s muss die Hull-Komponente ein Tk-Widget sein, das die Option **-class** definiert.

[snit::widgetadaptor][snit]s unterscheiden sich von [snit::widget][snit]s vor allem dadurch, dass jede Art von Widget als Hull-Komponente verwendet werden kann; siehe [Widget-Adapter].

## Wie lege ich den Hull-Typ eines snit::widget fest?

Die Hull-Komponente eines [snit::widget][snit] ist in der Regel ein Tk-Widget vom Typ **frame**; es kann sich jedoch um jedes beliebige Tk-Widget handeln, das die Option **-class** definiert.  Sie können den gewünschten Hull-Typ explizit festlegen, indem Sie den Befehl [hulltype][snit] in die Widget-Definition aufnehmen:

```
snit::widget mytoplevel {
    hulltype toplevel

    # ...
}
```

Wenn der Befehl „[hulltype][snit]“ nicht vorkommt, ist der Hull ein „**frame**“.

Standardmäßig erkennt Snit die folgenden Hull-Typen: die Tk-Widgets **frame**, **labelframe**, **toplevel** sowie die Tile-Widgets **ttk::frame**, **ttk::labelframe** und **ttk::toplevel**.  Um die Verwendung eines anderen Widget-Typs als Hull-Typ zu ermöglichen, können Sie den Widget-Befehl mit **lappend** an die Variable **snit::hulltypes** anhängen (immer vorausgesetzt, das Widget definiert die Option **-class**.  Nehmen wir beispielsweise an, Tk erhält einen neuen Widget-Typ namens **prettyframe**:

```
lappend snit::hulltypes prettyframe

snit::widget mywidget {
    hulltype prettyframe

    # ...
}
```

## Wie soll ich Widgets benennen, die Komponenten eines snit::widget sind?

Jedes Widget – sei es ein echtes Tk-Widget oder ein Snit-Megawidget – muss über einen gültigen Tk-Fensternamen verfügen. Wenn ein [snit::widget][snit] erstmals erstellt wird, ist sein Instanzname, **self**, ein Tk-Fenstername; wird das [snit::widget][snit] jedoch von einem [snit::widgetadaptor][snit] als Hull-Komponente verwendet, ändert sich sein Instanzname.  Aus diesem Grund wird jeder Methode, jedem Konstruktor, jedem Destruktor usw. von [snit::widget][snit] ein weiteres implizites Argument übergeben, nämlich **win**, der Fenstername des Megawidgets.  Alle Kindfenster sollten mit „**win**“ als Wurzel benannt werden.

Nehmen wir also an, Sie erstellen ein Toolbar-Widget, einen Frame, der aus mehreren nebeneinander angeordneten Schaltflächen besteht.  Das könnte in etwa so aussehen:

```
snit::widget toolbar {
    delegate option * to hull

    constructor {args} {
        button $win.open -text Open -command [mymethod open]
        button $win.save -text Save -command [mymethod save]

        # ....

        $self configurelist $args

    }
}
```

Siehe auch die Frage zur Umbenennung von Objekten weiter oben in dieser Datei.

# Widget-Adapter

## Was ist ein snit::widgetadaptor?

Ein [snit::widgetadaptor][snit] ist eine Art von [snit::widget][snit]. Während der Hull eines [snit::widget][snit] automatisch erstellt wird und stets ein Tk-Frame ist, kann ein [snit::widgetadaptor][snit] auf einem beliebigen Tk-Widget – oder auf einem beliebigen Snit-Megawidget oder sogar (mit etwas Glück) auf Megawidgets basieren, die mithilfe eines anderen Pakets definiert wurden.

Es wird als *Widget-Adapter* bezeichnet, da es Ihnen ermöglicht, ein vorhandenes Widget zu übernehmen und dessen Verhalten anzupassen.

## Wie definiere ich ein snit::widgetadaptor?

Verwenden Sie den Befehl [snit::widgetadaptor][snit].  Die Definition für [snit::widgetadaptor][snit] entspricht genau der für [snit::type][snit] oder [snit::widget][snit], mit der Ausnahme, dass der Konstruktor die Hull-Komponente erstellen und installieren muss.

Der folgende Code erstellt beispielsweise ein schreibgeschütztes Text-Widget, indem die Methoden **insert** und **delete** auf einfache Weise in No-Ops umgewandelt werden.  Anschließend definieren wir neue Methoden, **ins** und **del**, die als **insert** und **delete** an die Hull-Komponente weitergeleitet werden.  Auf diese Weise haben wir das Text-Widget angepasst und ihm ein neues Verhalten verliehen, wobei es im Grunde genommen weiterhin ein Text-Widget bleibt.

```
::snit::widgetadaptor rotext {

    constructor {args} {
        # Create the text widget; turn off its insert cursor
        installhull using text -insertwidth 0

        # Apply any options passed at creation time.
        $self configurelist $args
    }

    # Disable the text widget's insert and delete methods, to
    # make this readonly.
    method insert {args} {}
    method delete {args} {}

    # Enable ins and del as synonyms, so the program can insert and
    # delete.
    delegate method ins to hull as insert
    delegate method del to hull as delete

    # Pass all other methods and options to the real text widget, so
    # that the remaining behavior is as expected.
    delegate method * to hull
    delegate option * to hull
}
```

Der wichtigste Teil befindet sich im Konstruktor. Während [snit::widget][snit] den Hull für Sie erstellt, ist [snit::widgetadaptor][snit] dazu nicht in der Lage – es weiß nicht, welche Art von Widget Sie wünschen.  Daher erstellt der Konstruktor zunächst die Hull-Komponente (in diesem Fall ein Tk-Text-Widget) und installiert diese anschließend mit dem Befehl [installhull][snit].

*Hinweis:* Es gibt keinen Instanzbefehl, bis Sie durch die Installation einer Hull-Komponente einen solchen erstellen. Jeder Versuch, Methoden an **$self** zu übergeben, bevor [installhull][snit] aufgerufen wird, schlägt fehl.

## Kann ich ein Widget anpassen, das an anderer Stelle im Programm erstellt wurde?

Ja.

Manchmal kann es praktisch sein, ein bereits vorhandenes Widget anzupassen, anstatt ein eigenes zu erstellen. Beispielsweise verwaltet das Bwidget „**PagesManager**“ eine Reihe von „**frame**“-Widgets, von denen jeweils nur eines sichtbar ist. Die Anwendung entscheidet, welches „**frame**“ sichtbar ist.  Alle diese **frame**-Instanzen werden vom **PagesManager** selbst mithilfe seiner **add**-Methode erstellt. Es ist praktisch, diese Frames so anzupassen, dass sie die gewünschten Funktionen erfüllen.

In einem solchen Fall existiert das Tk-Widget bereits, wenn „[snit::widgetadaptor][snit]“ erstellt wird. Snit stellt zu diesem Zweck eine alternative Form des Befehls „[installhull][snit]“ bereit:

```
snit::widgetadaptor pageadaptor {
    constructor {args} {
        # The widget already exists; just install it.
        installhull $win

        # ...
    }
}
```

## Kann ich ein anderes Megawidget anpassen?

Möglicherweise. Wenn es sich bei dem anderen Megawidget um ein [snit::widget][snit] oder [snit::widgetadaptor][snit] handelt, dann ja. Ist dies nicht der Fall, dann wiederum möglicherweise. Sie müssen es ausprobieren und sehen, ob es funktioniert.  Am ehesten werden Sie Probleme mit der Zerstörung von Widgets haben – Sie müssen sicherstellen, dass Ihr Megawidget-Code das Ereignis **<Destroy>** erhält, bevor das von Ihnen angepasste Megawidget dieses Ereignis erhält.

# Tk-Optionsdatenbank

## Was ist die Tk-Optionsdatenbank?

Die Tk-Optionsdatenbank ist eine Datenbank mit Standardwerten für Optionen, die von Tk selbst verwaltet wird; jede Tk-Anwendung verfügt über eine solche Datenbank.  Das Konzept der Optionsdatenbank leitet sich von der sogenannten X-Windows-Ressourcendatenbank ab; die Optionsdatenbank ist jedoch in jeder Tk-Implementierung verfügbar, auch in solchen, die das X-Windows-System nicht verwenden (z. B. Microsoft Windows).

Eine ausführliche Beschreibung der Tk-Optionsdatenbank würde den Rahmen dieses Dokuments sprengen; sowohl *Practical Programming in Tcl and Tk* von Welch, Jones und Hobbs als auch *Effective Tcl/Tk Programming* von Harrison und McClennan enthalten gute Einführungen zu diesem Thema.

Snit ist so implementiert, dass es in den meisten Fällen im Hinblick auf die Optionsdatenbank einfach das Richtige tut, vorausgesetzt, der Widget-Entwickler hält sich an die Vorgaben von Snit. Im Hauptteil dieses Abschnitts wird ausführlich darauf eingegangen, welche Anforderungen Snit stellt. Im Folgenden finden Sie zur Orientierung eine kurze Zusammenfassung dieser Anforderungen.

- Wenn die Standard-Widget-Klasse des Widgets nicht Ihren Vorstellungen entspricht, legen Sie diese explizit mithilfe der Anweisung [widgetclass][snit] in der Widget-Definition fest.

- Wenn Sie Optionen definieren oder weiterleiten, legen Sie die Namen der Ressourcen und Klassen bei Bedarf ausdrücklich fest.

- Verwenden Sie den Befehl [installhull using][snit], um den Hull für [snit::widgetadaptor][snit]s zu erstellen und zu installieren.

- Verwenden Sie den Befehl [install][snit], um alle Komponenten, bei denen es sich um Widgets handelt, zu erstellen und zu installieren.

- Verwenden Sie den Befehl [install][snit], um Komponenten zu erstellen und zu installieren, bei denen es sich nicht um Widgets handelt, falls Sie möchten, dass diese Optionswerte aus der Optionsdatenbank erhalten.


Das Zusammenspiel von Tk-Widgets mit der Optionsdatenbank ist komplex; das Zusammenspiel von Snit mit der Optionsdatenbank ist dies noch mehr und erfordert daher besondere Sorgfalt.

## Verwenden snit::types die Tk-Optionsdatenbank?

Nein, das tun sie nicht; für die Abfrage der Optionsdatenbank ist ein Tk-Fenstername erforderlich, und [snit::type][snit]s verfügen nicht über einen solchen.

Wenn Sie eine Instanz von [snit::type][snit] als Komponente von [snit::widget][snit] oder [snit::widgetadaptor][snit] anlegen, und wenn Optionen an die Komponente weitergeleitet werden und Sie diese mit [install][snit] erstellen und installieren, dann fragt das Megawidget die Optionsdatenbank im Auftrag von [snit::type][snit] ab.  Dies entspricht möglicherweise Ihren Vorstellungen, möglicherweise aber auch nicht; seien Sie daher bitte vorsichtig.

## Wie lautet die Widget-Klasse meines snit::widget?

Jedes Tk-Widget verfügt über eine „Widget-Klasse“: einen Namen, der beim Hinzufügen von Optionseinstellungen zur Datenbank verwendet wird. Bei Tk-Widgets entspricht die Widget-Klasse dem Namen des Widget-Befehls mit einem Großbuchstaben am Anfang.  Beispielsweise lautet die Widget-Klasse des Tk-Widgets „**button**“ „**Button**“.

Ebenso ist die Widget-Klasse eines [snit::widget][snit] standardmäßig der unqualifizierte Typname mit großem Anfangsbuchstaben. Beispielsweise lautet die Widget-Klasse von

```
snit::widget ::mylibrary::scrolledText { ... }
```

is **ScrolledText**.

Die Widget-Klasse kann auch explizit mithilfe der Anweisung [widgetclass][snit] innerhalb der Definition von [snit::widget][snit] festgelegt werden:

```
snit::widget ::mylibrary::scrolledText {
    widgetclass Text

    # ...
}
```

Die obige Definition besagt, dass ein „**scrolledText**“-Megawidget dieselbe Widget-Klasse aufweist wie ein gewöhnliches „**text**“-Widget.  Ob dies eine gute Idee ist oder nicht, hängt davon ab, wie der Rest des Megawidgets definiert ist und wie dessen Optionen weitergeleitet werden.

## Wie lautet die Widget-Klasse meines snit::widgetadaptor?

Die Widget-Klasse eines [snit::widgetadaptor][snit] entspricht lediglich der Widget-Klasse seines Hull-Widgets; Snit hat hierauf keinen Einfluss.

Hinweis: Die Widget-Klasse kann nur für die Widgets **frame** und **toplevel** geändert werden; aus diesem Grund sind dies die zulässigen Hull-Typen für [snit::widget][snit]s.

Versuchen Sie, [snit::widgetadaptor][snit]s nur zu verwenden, um geringfügige Änderungen am Verhalten eines anderen Widgets vorzunehmen. In diesem Fall ist es in der Regel ohnehin nicht sinnvoll, die Klasse des Widgets zu ändern.

## Was sind Ressourcen- und Klassennamen von Optionen?

Jede Tk-Widget-Option hat drei Namen: den Optionsnamen, den Ressourcennamen und den Namen der Klasse. Der Optionsname beginnt mit einem Bindestrich und besteht ausschließlich aus Kleinbuchstaben; er wird beim Erstellen von Widgets sowie bei den Befehlen **configure** und **cget** verwendet.

Die Ressourcen- und Klassennamen werden verwendet, um Standardwerte für Optionen durch Abfrage der Optionsdatenbank zu initialisieren. Der Ressourcenname besteht in der Regel lediglich aus dem Optionsnamen ohne Bindestrich, kann jedoch an Wortgrenzen Großbuchstaben enthalten; der Klassenname besteht in der Regel lediglich aus dem Ressourcennamen mit einem Großbuchstaben am Anfang, was jedoch nicht immer der Fall ist.  Hier sind beispielsweise die Namen der Optionen, Ressourcen und Klassen für verschiedene Optionen des Tk-Widgets **text**:

```
    -background         background         Background
    -borderwidth        borderWidth        BorderWidth
    -insertborderwidth  insertBorderWidth  BorderWidth
    -padx               padX               Pad
```

Wie leicht zu erkennen ist, lassen sich die Namen der Ressourcen und Klassen manchmal aus dem Namen der Option ableiten, jedoch nicht immer.

## Wie lauten die Ressourcen- und Klassennamen für die Optionen meines Megawidgets?

Bei Optionen, die implizit mithilfe von **delegate option \*** an eine Komponente weitergeleitet werden, entsprechen die Ressourcen- und Klassennamen genau den von der Komponente definierten Bezeichnungen. Die Methode **configure** gibt diese Namen zusammen mit den Standard- und aktuellen Werten der Option zurück:

```
% snit::widget mytext {
    delegate option * to text

    constructor {args} {
        install text using text .text
        # ...
    }

    # ...
}
::mytext
% mytext .text
.text
% .text configure -padx
-padx padX Pad 1 1
%
```

Bei allen anderen Optionen (unabhängig davon, ob sie lokal definiert oder explizit weitergeleitet wurden) können die Namen der Ressourcen und Klassen explizit festgelegt werden oder es kann zugelassen werden, dass sie Standardwerte annehmen.

Standardmäßig entspricht der Name der Ressource lediglich dem Namen der Option ohne Bindestrich; der Name der Klasse entspricht hingegen dem Namen der Option mit einem Großbuchstaben am Anfang. Nehmen wir beispielsweise an, wir leiten explizit „-padx“ weiter:

```
% snit::widget mytext {
    option -myvalue 5

    delegate option -padx to text
    delegate option * to text

    constructor {args} {
        install text using text .text
        # ...
    }

    # ...
}
::mytext
% mytext .text
.text
% .text configure -myvalue
-myvalue myvalue Myvalue 5 5
% .text configure -padx
-padx padx Padx 1 1
%
```

Hier werden die Ressourcen- und Klassennamen anhand der Standardregeln ausgewählt. Oftmals reichen diese Regeln aus, doch im Fall von „-padx“ würden wir es höchstwahrscheinlich vorziehen, wenn die Ressourcen- und Klassennamen der Option mit denen der integrierten Tk-Widgets übereinstimmen. Dies lässt sich leicht bewerkstelligen:

```
% snit::widget mytext {
    delegate option {-padx padX Pad} to text

    # ...
}
::mytext
% mytext .text
.text
% .text configure -padx
-padx padX Pad 1 1
%
```

## Wie initialisiert snit die lokal definierten Optionen meines Megawidgets?

Die Optionsdatenbank wird für jede der lokal definierten Optionen des Megawidgets unter Verwendung des Ressourcen- und Klassennamens der Option abgefragt. Wenn das Ergebnis nicht „“ ist, ersetzt es den in der Widget-Definition angegebenen Standardwert. In beiden Fällen kann der Standardwert vom Aufrufer überschrieben werden. Zum Beispiel:

```
option add *Mywidget.texture pebbled

snit::widget mywidget {
    option -texture smooth
    # ...
}

mywidget .mywidget -texture greasy
```

Hier würde **-texture** normalerweise standardmäßig auf „smooth“ gesetzt werden, doch aufgrund des Eintrags, der der Optionsdatenbank hinzugefügt wurde, ist die Standardeinstellung „pebbled“. Der Aufrufer hat die Standardeinstellung jedoch ausdrücklich überschrieben, sodass das neue Widget „greasy“ sein wird.

## Wie initialisiert snit weitergeleitete Optionen?

Das hängt davon ab, ob die Optionen an den Hull oder an eine andere Komponente weitergeleitet werden.

## Wie initialisiert snit Optionen, die an den Hull weitergeleitet werden?

Der Hull eines [snit::widget][snit] ist ein Widget, und da seine Klasse festgelegt wurde, wird erwartet, dass er die Optionsdatenbank für sich selbst abfragt. Die einzige Ausnahme betrifft Optionen, die an ihn unter einem anderen Namen weitergeleitet werden. Betrachten Sie den folgenden Code:

```
option add *Mywidget.borderWidth 5
option add *Mywidget.relief sunken
option add *Mywidget.hullbackground red
option add *Mywidget.background green

snit::widget mywidget {
    delegate option -borderwidth to hull
    delegate option -hullbackground to hull as -background
    delegate option * to hull
    # ...
}

mywidget .mywidget

set A [.mywidget cget -relief]
set B [.mywidget cget -hullbackground]
set C [.mywidget cget -background]
set D [.mywidget cget -borderwidth]
```

Die Frage lautet: Welche Werte haben die Variablen A, B, C und D?

Der Wert von A ist „sunken“.  Der Hull ist ein Tk-Frame, dem die Widget-Klasse **Mywidget** zugewiesen wurde; er fragt automatisch die Optionsdatenbank ab und übernimmt diesen Wert. Da die Option **-relief** implizit an den Hull weitergeleitet wird, unternimmt Snit nichts.

Der Wert von B lautet „red“. Der Hull übernimmt automatisch den Wert „green“ für seine Option **-background**, genau wie er zuvor den Wert für **-relief** übernommen hat.  Snit weiß jedoch, dass **-hullbackground** der Option **-background** des Hulls zugeordnet ist; daher fragt es die Optionsdatenbank nach **-hullbackground** ab, erhält den Wert „red“ und aktualisiert den Hull entsprechend.

Der Wert von C ist ebenfalls „red“, da **-background** implizit an den Hull weitergeleitet wird; daher entspricht das Abrufen dieses Werts dem Abrufen von **-hullbackground**.  Beachten Sie, dass dieser Fall ungewöhnlich ist; die Option **-background** hätte wahrscheinlich mithilfe der Klausel **except** der delegate-Anweisung ausgeschlossen oder (was wahrscheinlicher ist) an eine andere Komponente weitergeleitet werden sollen.

Der Wert von D lautet „5“, jedoch nicht aus dem Grund, den Sie vermuten.  Hinweis: Gemäß der obigen Definition lautet der Ressourcenname für **-borderwidth** standardmäßig **borderwidth**, während der Eintrag in der Optionsdatenbank **borderWidth** lautet, entsprechend der standardmäßigen Tk-Namenskonvention für diese Option.  Wie bei **-relief** übernimmt der Hull seine eigene Option **-borderwidth**, bevor Snit irgendetwas unternimmt. Da die Option unter ihrem eigenen Namen weitergeleitet wird, geht Snit davon aus, dass alles korrekt abgelaufen ist, und befasst sich nicht weiter damit.  Um Verwechslungen zu vermeiden, hätte die Option **-borderwidth** wie folgt weitergeleitet werden sollen:

```
    delegate option {-borderwidth borderWidth BorderWidth} to hull
```

Bei [snit::widgetadaptor][snit]s stellt sich die Situation etwas anders dar.  Widget-Adapter behalten die Widget-Klasse ihres Hulls bei, und der Hull wird nicht automatisch von Snit erstellt. Stattdessen muss [snit::widgetadaptor][snit] in seinem Konstruktor [installhull][snit] aufrufen. Dies geschieht üblicherweise wie folgt:

```
snit::widgetadaptor mywidget {
    # ...
    constructor {args} {
        # ...
        installhull using text -foreground white
        # ...
    }
    # ...
}
```

In diesem Fall erstellt der Befehl [installhull][snit] den Hull mithilfe eines Befehls wie dem folgenden:

```
    set hull [text $win -foreground white]
```

Der Hull ist ein **text**-Widget, daher lautet seine Widget-Klasse **Text**.  Genau wie bei [snit::widget][snit]-Hulls geht Snit davon aus, dass er alle normalen Werte für Optionen automatisch übernimmt, ohne dass ein Eingreifen seitens Snit erforderlich ist. Optionen, die unter einem anderen Namen weitergeleitet werden, werden auf dieselbe Weise wie oben beschrieben aus der Optionsdatenbank initialisiert.

In früheren Versionen von Snit wurde erwartet, dass [snit::widgetadaptor][snit]s den Befehl [installhull][snit] wie folgt aufrufen:

```
    installhull [text $win -foreground white]
```

Diese Form funktioniert weiterhin – aber Snit fragt dann die Optionsdatenbank nicht wie oben beschrieben ab.

## Wie initialisiert snit Optionen, die an andere Komponenten weitergeleitet werden?

Bei Hull-Komponenten geht Snit davon aus, dass Tk den Großteil der Arbeit automatisch erledigt. Bei anderen Komponenten ist die Sache etwas komplizierter, da diese zweimal mit der Optionsdatenbank abgeglichen werden.

Ein Komponenten-Widget bleibt weiterhin ein Widget und wird daher wie gewohnt aus der Optionsdatenbank initialisiert. Ein **text**-Widget bleibt ein **text**-Widget, unabhängig davon, ob es Bestandteil eines Megawidgets ist oder nicht, und wird als solches erstellt.

Anschließend wird die Optionsdatenbank nach allen an die Komponente weitergeleiteten Optionen abgefragt, und die Komponente wird entsprechend initialisiert – vorausgesetzt, sie wird mit dem Befehl [install][snit] erstellt.

Bevor die Unterstützung für die Optionsdatenbank in Snit integriert wurde, bestand die übliche Vorgehensweise beim Erstellen einer Komponente darin, diese einfach im Konstruktor zu erstellen und ihren Befehlsnamen der Komponentenvariablen zuzuweisen:

```
snit::widget mywidget {
    delegate option -background to myComp

    constructor {args} {
        set myComp [text $win.text -foreground black]
    }
}
```

Der Nachteil dieser Methode besteht darin, dass Snit keine Möglichkeit hat, die Komponente ordnungsgemäß zu initialisieren. Daher wird nun folgender Ansatz verwendet:

```
snit::widget mywidget {
    delegate option -background to myComp

    constructor {args} {
        install myComp using text $win.text -foreground black
    }
}
```

Der Befehl [install][snit] führt Folgendes aus:

- Erstellt eine Liste der Optionen, die explizit im Befehl [install][snit] enthalten sind – in diesem Fall **-foreground**.

- Fragt die Optionsdatenbank nach allen Optionen, die explizit an die genannte Komponente weitergeleitet wurden.

- Erstellt die Komponente mithilfe des angegebenen Befehls, nachdem eine Liste von Optionen und Werten, die aus der Optionsdatenbank ausgelesen wurden, in diesen Befehl eingefügt wurde. Somit haben die explizit angegebenen Optionen (wie **-foreground**) Vorrang vor allen aus der Optionsdatenbank ausgelesenen Werten.

- Wenn die Widget-Definition Optionen implizit mithilfe von **delegate option \*** an die Komponente weiterleitet, ruft Snit die Methode **configure** der neu erstellten Komponente auf, um eine Liste aller Optionen der Komponente zu erhalten.  Daraus erstellt Snit eine Liste der implizit an die Komponente weitergeleiteten Optionen, die nicht explizit im Befehl [install][snit] enthalten waren. Für alle diese Optionen fragt Snit die Optionsdatenbank ab und konfiguriert die Komponente entsprechend.


Sie müssen all dies nicht unbedingt wissen; verwenden Sie einfach [install][snit], um Ihre Komponenten zu installieren, und Snit wird versuchen, das Richtige zu tun.

## Was geschieht, wenn ich ein Nicht-Widget als Komponente eines Widgets installiere?

Ein [snit::type][snit] fragt niemals die Optionsdatenbank ab. Ein [snit::widget][snit] kann jedoch Komponenten enthalten, die keine Widgets sind.  Wenn Optionen an diese Komponenten weitergeleitet werden und der Befehl [install][snit] zur Installation dieser Komponenten verwendet wird, werden sie ebenso wie Widget-Komponenten aus der Optionsdatenbank initialisiert.

Bei der Verwendung innerhalb eines Megawidgets geht [install][snit] jedoch davon aus, dass die erstellte Komponente eine weitgehend standardmäßige, widgetähnliche Erstellungssyntax verwendet. Wenn dies nicht der Fall ist, verwenden Sie [install][snit] bitte nicht.

# Ensemble-Befehle

## Was ist ein Ensemble-Befehl?

Ein Ensemble-Befehl ist ein Befehl mit Unterbefehlen.  Snit-Objekte sind allesamt Ensemble-Befehle; der Begriff bezieht sich jedoch in der Regel eher auf Befehle wie die Standard-Tcl-Befehle **string**, **file** und **clock**.  In gewisser Weise handelt es sich hierbei um Singleton-Objekte – es gibt jeweils nur eine Instanz davon.

## Wie kann ich mit snit einen Ensemble-Befehl erstellen?

Es gibt zwei Möglichkeiten – als [snit::type][snit] oder als Instanz eines [snit::type][snit].

## Wie kann ich einen Ensemble-Befehl unter Verwendung einer Instanz von snit::type erstellen?

Definieren Sie einen Typ, dessen [Instanzmethoden] die Unterbefehle Ihres Ensemble-Befehls sind. Erstellen Sie anschließend eine Instanz dieses Typs mit dem gewünschten Namen.

Der folgende Code nutzt beispielsweise [Weiterleitung], um eine Entsprechung zum Standardbefehl **string** zu erstellen:

```
snit::type ::mynamespace::mystringtype {
    delegate method * to stringhandler

    constructor {} {
        set stringhandler string
    }
}

::mynamespace::mystringtype mystring
```

Wir definieren den Typ in einem Namespace, sodass der Typbefehl verborgen ist; anschließend erstellen wir eine einzelne Instanz mit dem gewünschten Namen – in diesem Fall **mystring**.

Diese Methode weist zwei Nachteile auf. Erstens bleibt der Typbefehl ungenutzt herumliegen. Noch schwerwiegender ist jedoch, dass Ihr brandneuer Ensemble-Befehl die Unterbefehle „**info**“ und „**destroy**“ enthält, für die Sie wahrscheinlich keine Verwendung haben. Lesen Sie jedoch weiter.

## Wie kann ich mithilfe von snit::type einen Ensemble-Befehl erstellen?

Definieren Sie einen Typ, dessen [Typmethoden] die Unterbefehle Ihres Ensemble-Befehls sind.

Der folgende Code nutzt beispielsweise [Weiterleitung], um eine Entsprechung zum Standardbefehl **string** zu erstellen:

```
snit::type mystring {
    delegate typemethod * to stringhandler

    typeconstructor {
        set stringhandler string
    }
}
```

Nun ist der Typbefehl selbst Ihr Ensemble-Befehl.

Diese Methode hat nur einen Nachteil, und obwohl dieser erheblich ist, lässt er sich dennoch überwinden.  Ihr neuer Ensemble-Befehl wird die Unterbefehle **create**, **info** und **destroy** enthalten, die Sie nicht wünschen.  Und was noch schlimmer ist: Da die Methode **create** implizit sein kann, werden Benutzer Ihres Befehls versehentlich Instanzen Ihres Typs **mystring** erstellen, sollten sie einen der Unterbefehle falsch schreiben.  Der Befehl wird erfolgreich sein – beim ersten Mal –, aber nicht das gewünschte Ergebnis liefern. Das ist sehr schlecht.

Die Abhilfe besteht darin, einige [Pragmas] festzulegen, wie hier gezeigt:

```
snit::type mystring {
    pragma -hastypeinfo    no
    pragma -hastypedestroy no
    pragma -hasinstances   no

    delegate typemethod * to stringhandler

    typeconstructor {
        set stringhandler string
    }
}
```

Hier haben wir die Anweisung [pragma][snit] verwendet, um Snit mitzuteilen, dass wir weder die Typmethode **info** noch die Typmethode **destroy** wünschen und dass unser Typ keine Instanzen hat; dadurch werden die Typmethode **create** und der gesamte zugehörige Code entfernt.  Infolgedessen verhält sich unser Ensemble-Befehl wie vorgesehen, ohne unerwartete Unterbefehle.

# Pragmas

## Was ist ein Pragma?

Ein Pragma ist eine Option, die Sie in Ihren Typdefinitionen festlegen können und die Einfluss darauf hat, wie der Typ definiert wird und wie er nach seiner Definition funktioniert.

## Wie setze ich ein Pragma?

Verwenden Sie die Anweisung [pragma][snit]. Jedes Pragma ist eine Option mit einem Wert; bei jeder Verwendung der Anweisung [pragma][snit] können Sie eine oder mehrere davon festlegen.

## Wie werde ich die Typmethode „info“ los?

Setzen Sie das Pragma **-hastypeinfo** auf **no**:

```
snit::type dog {
    pragma -hastypeinfo no
    # ...
}
```

Snit wird davon absehen, die Typmethode **info** zu definieren.

## Wie werde ich die Typmethode „destroy“ los?

Setzen Sie das Pragma **-hastypedestroy** auf **no**:

```
snit::type dog {
    pragma -hastypedestroy no
    # ...
}
```

Snit wird davon absehen, die Typmethode **destroy** zu definieren.

## Wie werde ich die Typmethode „create“ los?

Setzen Sie das Pragma **-hasinstances** auf **no**:

```
snit::type dog {
    pragma -hasinstances no
    # ...
}
```

Snit verzichtet darauf, die Typmethode **create** zu definieren; wenn Sie den Typbefehl mit einem unbekannten Methodennamen aufrufen, erhalten Sie eine Fehlermeldung anstelle einer neuen Instanz des Typs.

Dies ist nützlich, wenn Sie einen [snit::type][snit] verwenden möchten, um einen Ensemble-Befehl zu definieren, anstatt einen Typ mit Instanzen.

Die Pragmas **-hastypemethods** und **-hasinstances** können nicht beide falsch sein (sonst bliebe nichts mehr übrig).

## Wie werde ich Typmethoden ganz los?

Die Typbefehle normaler Tk-Widgets haben keine Unterbefehle; sie dienen lediglich dazu, Widgets zu erstellen – in der Sprache von Snit: Der Typbefehl ruft direkt die Typmethode **create** auf.  Um dasselbe Verhalten in Snit zu erzielen, setzen Sie das Pragma **-hastypemethods** auf **no**:

```
snit::type dog {
    pragma -hastypemethods no
    #...
}

# Creates ::spot
dog spot

# Tries to create an instance called ::create
dog create spot
```

Die Pragmas **-hastypemethods** und **-hasinstances** können nicht beide falsch sein (sonst bliebe nichts mehr übrig).

## Warum kann ich kein Objekt erstellen, das ein altes Objekt mit demselben Namen ersetzt?

Bis zur Version 0.95 von Snit konnten Sie für eine Instanz von [snit::type][snit] einen beliebigen Namen verwenden, selbst wenn dieser Name bereits von einem anderen Objekt oder Befehl verwendet wurde. Sie konnten beispielsweise Folgendes tun:

```
snit::type dog { ... }

dog proc
```

Sie haben nun einen neuen Hund mit dem Namen „proc“, was wahrscheinlich nicht ganz das ist, was Sie eigentlich beabsichtigt hatten.  Infolgedessen gibt Snit nun eine Fehlermeldung aus, wenn der von Ihnen gewählte Name der Instanz mit einem bereits vorhandenen Befehl übereinstimmt. Um das alte Verhalten wiederherzustellen, setzen Sie das Pragma **-canreplace** auf **yes**:

```
snit::type dog {
    pragma -canreplace yes
    # ...
}
```

## Wie mache ich meinen einfachen Typ schneller?

In Snit 1.x können Sie das Pragma **-simpledispatch** auf **yes** setzen.

Der Methodenaufruf in Snit 1.x ist sowohl flexibel als auch schnell, doch diese Flexibilität hat ihren Preis. Wenn Ihr Typ diese Flexibilität nicht benötigt, können Sie mithilfe des Pragmas **-simpledispatch** einen einfacheren Aufrufmechanismus einsetzen, der deutlich schneller läuft. Die Einschränkungen lauten wie folgt:

- Methoden können nicht weitergeleitet werden.

- **uplevel** und **upvar** funktionieren nicht wie erwartet: Der Geltungsbereich des Aufrufers liegt zwei Ebenen höher statt einer.

- Die Methoden zur Verarbeitung von Optionen (**cget**, **configure** und **configurelist**) sind geringfügig langsamer.


In Snit 2.2 ist das Pragma **-simpledispatch** veraltet und wird ignoriert; jeder Methodenaufruf in Snit 2.2 ist schneller als **-simpledispatch** in Snit 1.x.

# Makros

## Was ist ein Makro?

Ein Snit-Makro ist nichts anderes als eine Tcl-Prozedur, die im Tcl-Interpreter definiert ist, der zum Kompilieren von Snit-Typdefinitionen verwendet wird.

## Wozu sind Makros gut?

Mit Snit-Makros können Sie eine neue Syntax für Typdefinitionen festlegen und die bedingte Kompilierung unterstützen.

## Wie führe ich eine bedingte Kompilierung durch?

Angenommen, Sie möchten, dass Ihr Typ eine schnelle C-Erweiterung verwendet, wenn diese verfügbar ist; andernfalls greifen Sie auf eine langsamere Tcl-Implementierung zurück. Sie möchten im ersten Fall einen Satz von Methoden definieren und im zweiten Fall einen anderen. Doch wie kann Ihre Typdefinition erkennen, ob die schnelle C-Erweiterung verfügbar ist oder nicht?

Das ist ganz einfach. Definieren Sie außerhalb einer Typdefinition ein Makro, das 1 zurückgibt, wenn die Erweiterung verfügbar ist, und andernfalls 0:

```
if {$gotFastExtension} {
    snit::macro fastcode {} {return 1}
} else {
    snit::macro fastcode {} {return 0}
}
```

Verwenden Sie anschließend Ihr Makro in Ihrer Typdefinition:

```
snit::type dog {

    if {[fastcode]} {
        # Fast methods
        method bark {} {...}
        method wagtail {} {...}
    } else {
        # Slow methods
        method bark {} {...}
        method wagtail {} {...}
    }
}
```

## Wie definiere ich eine neue Syntax für Typdefinitionen?

Verwenden Sie ein Makro.  Beispielsweise soll die Option **-background** Ihres [snit::widget][snit] auf eine Reihe von Komponenten-Widgets übertragen werden.  Sie könnten dies wie folgt umsetzen:

```
snit::widget mywidget {
    option -background -default white -configuremethod PropagateBackground

    method PropagateBackground {option value} {
        $comp1 configure $option $value
        $comp2 configure $option $value
        $comp3 configure $option $value
    }
}
```

Für eine einzige Option ist dies in Ordnung; wenn Sie jedoch mehrere Optionen haben, wird es mühsam und fehleranfällig.  Verpacken Sie es daher in ein Makro:

```
snit::macro propagate {option "to" components} {
    option $option -configuremethod Propagate$option

    set body "\n"

    foreach comp $components {
        append body "\$$comp configure $option \$value\n"
    }

    method Propagate$option {option value} $body
}
```

Dann können Sie es wie folgt verwenden:

```
snit::widget mywidget {
    option -background default -white
    option -foreground default -black

    propagate -background to {comp1 comp2 comp3}
    propagate -foreground to {comp1 comp2 comp3}
}
```

## Gibt es Einschränkungen hinsichtlich der Namen von Makros?

Ja, die gibt es. Sie dürfen keine Standard-Tcl-Befehle oder Snit-Typdefinitionsanweisungen neu definieren. Sie können jeden beliebigen anderen Befehlsnamen verwenden, einschließlich des Namens eines zuvor definierten Makros.

Wenn Sie Snit-Makros in Ihrer Anwendung verwenden, können Sie diese wie oben gezeigt im globalen Namespace benennen.  Wenn Sie sie jedoch verwenden, um Typen oder Widgets zu definieren, die von anderen genutzt werden sollen, sollten Sie Ihre Makros im selben Namespace wie Ihre Typen oder Widgets definieren. Auf diese Weise kommt es zu keinen Konflikten mit den Makros anderer Entwickler.

Wenn mein raffiniertes [snit::widget][snit] beispielsweise **::mylib::mywidget** heißt, dann sollte ich mein Makro „**propagate**“ als „**::mylib::propagate**“ definieren:

```
snit::macro mylib::propagate {option "to" components} { ... }

snit::widget ::mylib::mywidget {
    option -background default -white
    option -foreground default -black

    mylib::propagate -background to {comp1 comp2 comp3}
    mylib::propagate -foreground to {comp1 comp2 comp3}
}
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *snit* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge

# Copyright

```
Copyright (c) 2003-2006, by William H. Duquette
```


[snit]: snit.md
