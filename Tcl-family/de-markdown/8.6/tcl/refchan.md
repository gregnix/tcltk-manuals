---
CommandName: refchan
title: refchan
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - chan(n)
 - transchan(n)
Keywords:
 - API
 - channel
 - ensemble
 - prefix
 - reflection
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

refchan - API des Befehlshandlers für reflektierte Kanäle

# Übersicht

::: {.synopsis} :::
[cmdPrefix]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Der Tcl-Ebenen-Handler für einen reflektierten Kanal muss ein Befehl mit Unterbefehlen sein (als *Ensemble* bezeichnet, wie ein Befehl, der durch [namespace ensemble][namespace] **create** erzeugt wird; die Implementierung von Handlern für reflektierte Kanäle ist jedoch in keiner Weise an [namespace ensemble][namespace] gebunden; siehe [Beispiele] unten, wie man eine [oo::class][class] aufbaut, die die API unterstützt). *cmdPrefix* ist das, was beim Aufruf von [chan create][chan] angegeben wurde, und kann aus mehreren Argumenten bestehen; es wird an Stelle des Präfixes zu mehreren Wörtern expandiert.

Von allen möglichen Unterbefehlen muss der Handler **initialize**, **finalize** und **watch** unterstützen. Die Unterstützung der übrigen Unterbefehle ist optional.

## Pflicht-Unterbefehle

*cmdPrefix* **initialize** *channelId mode*
: Ein Aufruf dieses Unterbefehls ist der erste Aufruf, den *cmdPrefix* für den angegebenen neuen *channelId* erhält. Dieser Unterbefehl ist dafür verantwortlich, alle internen Datenstrukturen einzurichten, die zum Verfolgen des Kanals und seines Zustands erforderlich sind.

    Der Rückgabewert der Methode muss eine Liste mit den Namen aller von *cmdPrefix* unterstützten Unterbefehle sein. Damit teilt er dem Tcl-Kern mit, welche Version der API für reflektierte Kanäle von diesem Befehlshandler verwendet wird.

    Jeder von der Methode geworfene Fehler bricht die Erzeugung des Kanals ab, und es wird kein Kanal erzeugt. Der geworfene Fehler erscheint als vom Befehl [chan create][chan] geworfener Fehler. Jede andere Ausnahme als [error] (z. B. [break] usw.) wird als Fehler behandelt (und in einen Fehler umgewandelt).

    **Hinweis:** Wurde die Erzeugung des Kanals hier wegen Fehlern abgebrochen, wird der Unterbefehl **finalize** nicht aufgerufen.

    Das Argument *mode* teilt dem Handler mit, ob der Kanal zum Lesen, Schreiben oder beides geöffnet wurde. Es ist eine Liste, die beliebig die Zeichenketten [read] oder **write** enthalten kann. Die Liste kann leer sein, enthält aber üblicherweise mindestens ein Element.

    Der Unterbefehl muss einen Fehler werfen, wenn der gewählte Modus von *cmdPrefix* nicht unterstützt wird.

*cmdPrefix* **finalize** *channelId*
: Ein Aufruf dieses Unterbefehls ist der letzte Aufruf, den *cmdPrefix* für den angegebenen *channelId* erhält. Er wird unmittelbar vor der Zerstörung der vom Tcl-Kern gehaltenen Datenstrukturen des Kanals erzeugt. Der Befehlshandler darf auf den *channelId* in keiner Weise mehr zugreifen. Wenn dieser Unterbefehl aufgerufen wird, müssen alle diesem Kanal zugeordneten internen Ressourcen freigegeben werden.

    Der Rückgabewert dieses Unterbefehls wird ignoriert.

    Wirft der Unterbefehl einen Fehler, erscheint es, als hätte der Aufruf, der seine Ausführung auslöste (üblicherweise [chan close][chan]), diesen Fehler geworfen. Jede Ausnahme außer [error] (z. B. [break] usw.) wird als Fehler behandelt (und in einen Fehler umgewandelt).

    Dieser Unterbefehl wird nicht aufgerufen, wenn die Erzeugung des Kanals während **initialize** abgebrochen wurde (siehe oben).

*cmdPrefix* **watch** *channelId eventspec*
: Dieser Unterbefehl benachrichtigt *cmdPrefix*, dass der angegebene *channelId* an den in *eventspec* aufgeführten Ereignissen interessiert ist. Dieses Argument ist eine Liste, die beliebig [read] und **write** enthalten kann. Die Liste kann leer sein; das signalisiert, dass der Kanal über keine Ereignisse benachrichtigt werden möchte. In diesem Fall soll der Handler die Ereigniserzeugung vollständig deaktivieren.

    **Warnung:** Jeder Rückgabewert des Unterbefehls wird ignoriert. Das schließt alle vom Unterbefehl geworfenen Fehler, [break], [continue] und benutzerdefinierte Rückgabecodes ein.

    Dieser Unterbefehl interagiert mit [chan postevent][chan]. Der Versuch, ein Ereignis zu melden, das im letzten Aufruf von **watch** nicht aufgeführt war, führt dazu, dass [chan postevent][chan] einen Fehler wirft.


## Optionale Unterbefehle

*cmdPrefix* **read** *channelId count*
: Dieser *optionale* Unterbefehl wird aufgerufen, wenn der Benutzer Daten vom Kanal *channelId* anfordert. *count* gibt an, wie viele *Bytes* angefordert wurden. Wird der Unterbefehl nicht unterstützt, ist ein Lesen vom durch den Befehl verwalteten Kanal nicht möglich.

    Der Rückgabewert dieses Unterbefehls wird als die angeforderten Daten-*Bytes* interpretiert. Enthält die zurückgegebenen Daten mehr Bytes als angefordert, wird ein Fehler signalisiert und später vom Befehl geworfen, der das Lesen ausgeführt hat (üblicherweise [gets] oder [read]). Weniger Bytes als angefordert zurückzugeben ist jedoch zulässig.

    Beachten Sie, dass das Zurückgeben von nichts (0 Bytes) den höheren Schichten signalisiert, dass auf dem Kanal **EOF** erreicht wurde. Um zu signalisieren, dass der Kanal derzeit keine Daten hat, **EOF** aber noch nicht erreicht ist, muss der Fehler „EAGAIN“ geworfen werden, also entweder

    ```
    return -code error EAGAIN
    ```

    oder

    ```
    error EAGAIN
    ```

    Zur Erweiterbarkeit bewirkt jeder Fehler, dessen Wert eine negative Ganzzahl ist, dass die höheren Schichten die C-Variable „**errno**“ auf den Absolutwert dieser Zahl setzen und so einen Systemfehler signalisieren. Beachten Sie jedoch, dass die genaue Zuordnung zwischen diesen Fehlernummern und ihrer Bedeutung vom Betriebssystem abhängt.

    Beispielsweise sind unter Linux sowohl

    ```
    return -code error -11
    ```

    als auch

    ```
    error -11
    ```

    den obigen Beispielen äquivalent, wenn die lesbarere Zeichenkette „EAGAIN“ verwendet wird; unter BSD ist das nicht der Fall, dort ist die äquivalente Zahl -35.

    Die symbolische Zeichenkette ist jedoch systemübergreifend dieselbe und wird intern in die richtige Zahl übersetzt. Kein anderer Fehlerwert hat eine solche Zuordnung zu einer symbolischen Zeichenkette.

    Wirft der Unterbefehl einen anderen Fehler, erscheint es, als hätte der Aufruf, der seine Ausführung auslöste (üblicherweise [gets] oder [read]), diesen Fehler geworfen. Jede Ausnahme außer [error] (z. B. [break] usw.) wird als Fehler behandelt und in einen Fehler umgewandelt.

*cmdPrefix* **write** *channelId data*
: Dieser *optionale* Unterbefehl wird aufgerufen, wenn der Benutzer Daten in den Kanal *channelId* schreibt. Das Argument *data* enthält *Bytes*, keine Zeichen. Jede für den Kanal konfigurierte Transformation (EOL, Kodierung) wurde zu diesem Zeitpunkt bereits angewendet. Wird dieser Unterbefehl nicht unterstützt, ist ein Schreiben in den durch den Befehl verwalteten Kanal nicht möglich.

    Der Rückgabewert des Unterbefehls wird als die vom Kanal geschriebene Byte-Anzahl interpretiert. Jeder nicht numerische Wert führt zu einem Fehler, der später vom Befehl geworfen wird, der das Schreiben ausgeführt hat. Ein negativer Wert bedeutet, dass das Schreiben fehlgeschlagen ist. Ein Wert größer als die dem Handler übergebenen Bytes oder Null ist verboten und führt dazu, dass der Tcl-Kern einen Fehler wirft.

    Um zu signalisieren, dass der Kanal derzeit keine Daten zum Schreiben annehmen kann, muss der Fehler „EAGAIN“ geworfen werden, also entweder

    ```
    return -code error EAGAIN
    ```

    oder

    ```
    error EAGAIN
    ```

    Zur Erweiterbarkeit bewirkt jeder Fehler, dessen Wert eine negative Ganzzahl ist, dass die höheren Schichten die C-Variable „**errno**“ auf den Absolutwert dieser Zahl setzen und so einen Systemfehler signalisieren. Beachten Sie jedoch, dass die genaue Zuordnung zwischen diesen Fehlernummern und ihrer Bedeutung vom Betriebssystem abhängt.

    Beispielsweise sind unter Linux sowohl

    ```
    return -code error -11
    ```

    als auch

    ```
    error -11
    ```

    den obigen Beispielen äquivalent, wenn die lesbarere Zeichenkette „EAGAIN“ verwendet wird; unter BSD ist das nicht der Fall, dort ist die äquivalente Zahl -35.

    Die symbolische Zeichenkette ist jedoch systemübergreifend dieselbe und wird intern in die richtige Zahl übersetzt. Kein anderer Fehlerwert hat eine solche Zuordnung zu einer symbolischen Zeichenkette.

    Wirft der Unterbefehl einen anderen Fehler, erscheint es, als hätte der Aufruf, der seine Ausführung auslöste (üblicherweise [puts]), diesen Fehler geworfen. Jede Ausnahme außer [error] (z. B. [break] usw.) wird als Fehler behandelt und in einen Fehler umgewandelt.

*cmdPrefix* **seek** *channelId offset base*
: Dieser *optionale* Unterbefehl ist für die Bearbeitung von [chan seek][chan]- und [chan tell][chan]-Anfragen auf dem Kanal *channelId* zuständig. Wird er nicht unterstützt, ist Suchen auf dem Kanal nicht möglich.

    Das Argument *base* entspricht dem gleichnamigen Argument des eingebauten [chan seek][chan], nämlich:

    **start**
    : Die Positionierung ist relativ zum Anfang des Kanals.

    **current**
    : Die Positionierung ist relativ zur aktuellen Suchposition.

    **end**
    : Die Positionierung ist relativ zum Ende des Kanals.


    *offset* ist eine Ganzzahl, die angibt, um wie viele **Bytes** vor- oder zurückgesucht werden soll. Eine positive Zahl soll vorwärts suchen, eine negative rückwärts. Ein Kanal kann nur eingeschränktes Suchen anbieten. Sockets können beispielsweise nur vorwärts suchen, nicht rückwärts.

    Der Rückgabewert des Unterbefehls wird als die (neue) Position des Kanals vom Anfang an gezählt genommen. Das muss eine Ganzzahl größer oder gleich null sein. Wirft der Unterbefehl einen Fehler, erscheint es, als hätte der Aufruf, der seine Ausführung auslöste (üblicherweise [chan seek][chan] oder [chan tell][chan]), diesen Fehler geworfen. Jede Ausnahme außer [error] (z. B. [break] usw.) wird als Fehler behandelt und in einen Fehler umgewandelt.

    Die Kombination *offset*/*base* 0/**current** signalisiert eine [chan tell][chan]-Anfrage, d. h. relativ zur aktuellen Position nichts zu suchen, sodass die neue Position mit der aktuellen identisch ist, die dann zurückgegeben wird.

*cmdPrefix* **configure** *channelId option value*
: Dieser *optionale* Unterbefehl dient zum Setzen der typspezifischen Optionen des Kanals *channelId*. Das Argument *option* gibt die zu schreibende Option an, das Argument *value* den Wert, auf den die Option gesetzt werden soll.

    Dieser Unterbefehl versucht niemals, mehr als eine Option gleichzeitig zu aktualisieren; dieses Verhalten ist im Tcl-Kanal-Kern implementiert.

    Der Rückgabewert des Unterbefehls wird ignoriert.

    Wirft der Unterbefehl einen Fehler, erscheint es, als hätte der Befehl, der die (Neu-)Konfiguration oder Abfrage ausgeführt hat (üblicherweise [fconfigure] oder [chan configure][chan]), diesen Fehler geworfen. Jede Ausnahme außer [error] (z. B. [break] usw.) wird als Fehler behandelt und in einen Fehler umgewandelt.

*cmdPrefix* **cget** *channelId option*
: Dieser *optionale* Unterbefehl wird beim Lesen einer einzelnen typspezifischen Option des Kanals *channelId* verwendet. Wird dieser Unterbefehl unterstützt, muss auch der Unterbefehl **cgetall** unterstützt werden.

    Der Unterbefehl soll den Wert der angegebenen *option* zurückgeben.

    Wirft der Unterbefehl einen Fehler, erscheint es, als hätte der Befehl, der die (Neu-)Konfiguration oder Abfrage ausgeführt hat (üblicherweise [fconfigure] oder [chan configure][chan]), diesen Fehler geworfen. Jede Ausnahme außer *error* (z. B. [break] usw.) wird als Fehler behandelt und in einen Fehler umgewandelt.

*cmdPrefix* **cgetall** *channelId*
: Dieser *optionale* Unterbefehl dient zum Lesen aller typspezifischen Optionen des Kanals *channelId*. Wird dieser Unterbefehl unterstützt, muss auch der Unterbefehl **cget** unterstützt werden.

    Der Unterbefehl soll eine Liste aller Optionen und ihrer Werte zurückgeben. Diese Liste muss eine gerade Anzahl von Elementen haben.

    Wirft der Unterbefehl einen Fehler, erscheint es, als hätte der Befehl, der die (Neu-)Konfiguration oder Abfrage ausgeführt hat (üblicherweise [fconfigure] oder [chan configure][chan]), diesen Fehler geworfen. Jede Ausnahme außer [error] (z. B. [break] usw.) wird als Fehler behandelt und in einen Fehler umgewandelt.

*cmdPrefix* **blocking** *channelId mode*
: Dieser *optionale* Unterbefehl behandelt Änderungen am Blockiermodus des Kanals *channelId*. *mode* ist ein boolesches Flag. Ein wahrer Wert bedeutet, dass der Kanal blockierend gesetzt werden muss, ein falscher Wert, dass der Kanal nicht blockierend sein soll.

    Der Rückgabewert des Unterbefehls wird ignoriert.

    Wirft der Unterbefehl einen Fehler, erscheint es, als hätte der Aufruf, der seine Ausführung auslöste (üblicherweise [fconfigure] oder [chan configure][chan]), diesen Fehler geworfen. Jede Ausnahme außer [error] (z. B. [break] usw.) wird als Fehler behandelt und in einen Fehler umgewandelt.


# Hinweise

Einige der in Kanälen unterstützten Funktionen, die in der C-Schnittstelle von Tcl definiert sind, stehen Kanälen, die auf die Tcl-Ebene reflektiert werden, nicht zur Verfügung.

Die Funktion **Tcl\_DriverGetHandleProc** wird nicht unterstützt; d. h. reflektierte Kanäle haben keine betriebssystemspezifischen Handles.

Die Funktion **Tcl\_DriverHandlerProc** wird nicht unterstützt. Diese Treiberfunktion ist nur für gestapelte Kanäle, d. h. Transformationen, relevant. Reflektierte Kanäle sind stets Basiskanäle, keine Transformationen.

Die Funktion **Tcl\_DriverFlushProc** wird nicht unterstützt. Das liegt daran, dass die aktuelle generische E/A-Schicht von Tcl diese Funktion nirgends verwendet. Daher ergibt Unterstützung auf Tcl-Ebene ebenfalls keinen Sinn. Das kann in Zukunft geändert werden (durch Erweiterung der hier definierten API und Änderung ihrer Versionsnummer), falls die Funktion künftig verwendet wird.

# Beispiele

Dies zeigt, wie man einen Kanal erzeugt, der aus einer Zeichenkette liest.

```
oo::class create stringchan {
    variable data pos
    constructor {string {encoding {}}} {
        if {$encoding eq ""} {set encoding [encoding system]}
        set data [encoding convertto $encoding $string]
        set pos 0
    }

    method initialize {ch mode} {
        return "initialize finalize watch read seek"
    }
    method finalize {ch} {
        my destroy
    }
    method watch {ch events} {
        # Muss vorhanden sein, wird aber ignoriert, weil wir
        # keine Ereignisse melden
    }

    # Muss bei einem lesbaren Kanal vorhanden sein
    method read {ch count} {
        set d [string range $data $pos [expr {$pos+$count-1}]]
        incr pos [string length $d]
        return $d
    }

    # Diese Methode ist optional, für das Beispiel unten aber nützlich
    method seek {ch offset base} {
        switch $base {
            start {
                set pos $offset
            }
            current {
                incr pos $offset
            }
            end {
                set pos [string length $data]
                incr pos $offset
            }
        }
        if {$pos < 0} {
            set pos 0
        } elseif {$pos > [string length $data]} {
            set pos [string length $data]
        }
        return $pos
    }
}

# Jetzt erzeugen wir eine Instanz...
set string "The quick brown fox jumps over the lazy dog.\n"
set ch [chan create read [stringchan new $string]]

puts [gets $ch];   # Gibt die ganze Zeichenkette aus

seek $ch -5 end;
puts [read $ch];   # Gibt nur das letzte Wort aus
```


[break]: break.md
[chan]: chan.md
[class]: class.md
[continue]: continue.md
[error]: error.md
[fconfigure]: fconfigure.md
[gets]: gets.md
[namespace]: namespace.md
[puts]: puts.md
[read]: read.md
