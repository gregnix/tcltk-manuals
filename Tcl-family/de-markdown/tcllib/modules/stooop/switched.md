---
CommandName: switched
title: switched
ManualSection: n
Version: 2.2.2
TclPart: tcllib
TclDescription: Simple Tcl Only Object Oriented Programming
Keywords:
 - C++
 - class
 - object
 - object oriented
Copyright:
---

# Name

switched – Verwaltung von Schaltern und Optionen.

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [switched]{.lit} [2.2.2]{.optlit}
[<switched>]{.lit} [complete]{.lit} [this]{.arg}
[<switched>]{.lit} [options]{.lit} [this]{.arg}
[<switched>]{.lit} [set-option]{.lit} [this]{.arg} [value]{.arg}
:::

# Beschreibung

Die Klasse „**switched**“ dient als Basisklasse für Benutzerklassen mit Prozeduren für Schalter und Optionen. Sie bietet Funktionen zur Verwaltung von Optionen über eine einfache Schnittstelle.

Beispiel:

```
set vehicle [new car -length 4.5 -width 2 -power 100 -fuel diesel]
puts "my car was running on [switched::cget $vehicle -fuel]"
switched::configure $vehicle -power 40 -fuel electricity
puts "but is now running on clean [switched::cget $vehicle -fuel]"
```

Wie Sie vielleicht bereits vermutet haben, leitet sich die Klasse „**car**“ natürlich von der Klasse „**switched**“ ab. Sehen wir uns einmal an, wie die Funktionsweise dieser abgeleiteten Klasse aussieht:

```
class car {
    proc car {this args} switched {$args} {
        # car specific initialization code here
        switched::complete $this
    }
    ...
}
```

Der Konstruktor der Klasse switched nimmt die optionalen Paare aus Konfigurationsoption und Wert als Parameter entgegen. Die Switched-Schicht verwaltet die Switched-Optionen dann vollständig: Sie prüft ihre Gültigkeit, speichert ihre Werte und stellt eine klare Schnittstelle zu den Konfigurationsprozeduren der Benutzerschicht bereit.

Dem Programmierer stehen diese Member der Klasse **switched** zur Verfügung:

**<switched>** **complete** *this*
: Diese Prozedur teilt der Switched-Schicht mit, dass das Objekt der abgeleiteten Klasse (in den Beispielen ein Auto) vollständig aufgebaut ist. Dann erfolgt die Erstkonfiguration des Switched-Objekts mit den Standardwerten der Optionen (siehe Prozedur **options**), gegebenenfalls überschrieben durch Werte aus der Konstruktion, die beim Aufruf des Operators **new** übergeben wurden. Diese Prozedur darf nur einmal aufgerufen werden, üblicherweise am Ende oder kurz vor dem Ende des Konstruktors der abgeleiteten Klasse. (*Hinweis*: auch das Daten-Member **complete** weiter unten in diesem Abschnitt).

**<switched>** **options** *this*
: Diese Prozedur muss die Konfigurationsbeschreibung für *alle* Optionen zurückgeben, die das Switched-Objekt akzeptiert. Sie ist eine rein virtuelle Member-Prozedur, ihre Implementierung in der abgeleiteten Klasse ist daher *obligatorisch*. Die Prozedur muss eine Liste von Listen zurückgeben. Jede Liste gehört zu einer einzelnen Option und besteht aus dem Schalternamen, dem Standardwert der Option und einem optionalen Anfangswert. Zum Beispiel:

    ```
    class car {
        ...
        proc options {this} {
            return [list [list -fuel petrol petrol] [list -length {} {}] [list -power {} {}] [list -width {} {}] ]
        }
        proc set-fuel {this value} {
            ...
        }
        ...
    }
    ```

    In diesem Fall werden vier Optionen festgelegt: **fuel**, **length**, **power** und **width**. Die Standard- und Anfangswerte für die Option **fuel** sind identisch und auf **petrol** festgelegt. Bei den übrigen Optionen sind alle Werte leer.

    Für jede Option muss in der abgeleiteten Klasse eine entsprechende Prozedur **set-option** definiert sein. Da beispielsweise eine Option **fuel** definiert wurde, gibt es in der Klasse car eine Prozedur **set-fuel**. Die Parameter sind stets der Objektbezeichner (es handelt sich nicht um eine statische, sondern um eine dynamisch definierte virtuelle Prozedur), gefolgt vom neuen Wert der Option. Eine Prozedur **set-option** wird nur aufgerufen, wenn der neue Wert vom aktuellen abweicht (ein Cache zur Beschleunigung) oder wenn in der Prozedur **options** für diese Option kein Anfangswert gesetzt ist.

    Weicht in dieser Prozedur der Anfangswert vom Standardwert ab oder wird er weggelassen, wird die Erstkonfiguration erzwungen, und die entsprechende Prozedur **set-option** wird von der Switched-Prozedur **complete** am Ende des Konstruktors der abgeleiteten Klasse aufgerufen. Zum Beispiel:

    ```
    class car {
        ...
        proc options {this} {
            return [list [list -fuel petrol] [list -length {} {}] [list -power 100 50] [list -width {} {}] ]
        }
        ...
    }
    ```

    In diesem Fall wird die Konfiguration der Optionen **fuel** und **power** erzwungen, das heißt, die entsprechenden Prozeduren **set-option** werden beim Erzeugen des Switched-Objekts aufgerufen (siehe die Beschreibung der Prozeduren **set-option** weiter unten).

    Da für **fuel** kein Anfangswert vorhanden ist, wird **set-fuel** mit dem Standardwert (**petrol**) als Argument aufgerufen. Bei **power** wird **set-power** mit dem Anfangswert als Argument (**50**) aufgerufen, weil der Anfangswert vom Standardwert abweicht.

    Bei den übrigen Optionen werden die entsprechenden Prozeduren **set-option** nicht aufgerufen, weil die Anfangswerte (die letzten Elemente der Optionslisten) mit den Standardwerten übereinstimmen. Der Programmierer muss dafür sorgen, dass die Anfangswerte der Optionen korrekt sind.

**<switched>** **set-option** *this* *value*
: Diese Prozeduren lassen sich als dynamische virtuelle Funktionen betrachten. Für jede unterstützte Option muss es eine Implementierung geben, wie sie die Prozedur **options** zurückgibt. Zum Beispiel:

    ```
    class car {
        ...
        proc options {this} {
            return [list ...
                [list -width {} {}] ]
        }
        ...
        proc set-width {this value} {
            ...
        }
        ...
    }
    ```

    Da die Option **-width** in der Prozedur **options** aufgeführt wurde, gibt es eine Implementierung von **set-width**, die die Breite des Autos setzen würde (und zum Beispiel das Aussehen einer grafischen Darstellung anpassen würde).

    Wird ein unterstütztes **option** in die von **options** zurückgegebene Liste aufgenommen, kann die entsprechende Prozedur **set-option** aufgerufen werden, sobald das Switched-Objekt vollständig ist; das ist der Fall, wenn die Prozedur **complete** der Switched-Ebene aufgerufen wird. Zum Beispiel:

    ```
    class car {
        proc car {this args} switched {args} {
            ...
            switched::complete $this
       }
        ...
        proc options {this} {
            return [list [list -fuel petrol] [list -length 4.5] [list -power 350] [list -width 1.8] ]
        }
        proc set-fuel {this value} {
            ...
        }
        proc set-length {this value} {
            ...
        }
        proc set-power {this value} {
            ...
        }
        proc set-width {this value} {
            ...
        }
    }

    new car
    ```

    In diesem Fall wird mit **new car** ein neues Auto ohne Optionen erzeugt. Dadurch wird der Konstruktor von car aufgerufen, der nach der vollständigen Initialisierung der car-Schicht wiederum die Prozedur **complete** der Switched-Ebene aufruft. Da zu diesem Zeitpunkt in keiner Optionsliste der Prozedur **options** Anfangswerte stehen, wird **set-fuel** mit dem Standardwert **petrol** als Parameter aufgerufen, danach **set-length** mit **4.5**, **set-power** mit **350** und schließlich **set-width** mit **1.8**. So lassen sich die Prozeduren **set-option** beim Debuggen prüfen; anschließend werden die Anfangswerte der Optionen eingetragen.

    Die Switched-Schicht prüft, ob eine Option gültig ist (also in der Prozedur **options** aufgeführt ist), prüft aber nicht die Gültigkeit des an **set-option** übergebenen Werts. Die Prozedur soll einen Fehler auslösen (zum Beispiel mit dem Tcl-Befehl **error**), wenn der Wert ungültig ist.

    Die Switched-Schicht merkt sich außerdem die aktuellen Werte der Optionen, sodass **set-option** nur aufgerufen wird, wenn der als Parameter übergebene Wert vom aktuellen Wert abweicht (siehe die Beschreibung der Daten-Member **-option**).

**-option**
: Das Daten-Member **-option** hält den aktuellen Wert der Option. Für jede in der Prozedur **options** aufgeführte Option gibt es eines. Es ist ein nur lesbarer Wert, den die Switched-Schicht bei einer Änderung der Option zum Vergleich heranzieht. In der von switched abgeleiteten Schicht wird es selten verwendet, außer in wenigen Fällen wie dem folgenden Beispiel:

    ```
    ...
    proc car::options {this} {
        return {
            ...
            {-manufacturer {} {}}
            ...
        }
    }

    proc car::set-manufacturer {this value} {}

    proc car::printData {this} {
        puts "manufacturer: $switched::($this,-manufacturer)"
        ...
    }
    ```

    In diesem Fall wird der Name des Herstellers auf der Switched-Schicht gespeichert (deshalb hat die Prozedur **set-manufacturer** nichts zu tun) und später in der Prozedur **printData** gelesen.

**complete**
: Das Daten-Member **complete** (nicht zu verwechseln mit der Prozedur **complete**) ist ein boolescher Wert. Sein Anfangswert ist **false**, und er wird ganz am Ende der Switched-Prozedur **complete** auf **true** gesetzt. Es ist nützlich, wenn bestimmte Optionen nur bei der Erzeugung und nicht dynamisch gesetzt werden sollen, wie das folgende Beispiel zeigt:

    ```
    proc car::set-width {this value} {
        if {$switched::($this,complete)} {
            error {option -width cannot be set dynamically}
        }
        ...
    }
    ```


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *stooop* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge
