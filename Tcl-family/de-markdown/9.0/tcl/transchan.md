---
CommandName: transchan
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - chan(n)
 - refchan(n)
Keywords:
 - API
 - channel
 - ensemble
 - prefix
 - transformation
Copyright:
 - Copyright (c) 2008 Donal K. Fellows
---

# NAME

transchan - API des Befehlshandlers für in Tcl-Code implementierte Kanaltransformationen

# ÜBERSICHT

::: {.synopsis} :::
[chan]{.cmd} [push]{.sub} [channel]{.arg} [cmdPrefix]{.arg} 

[cmdPrefix]{.ins} [clear]{.sub} [handle]{.arg} 
[cmdPrefix]{.ins} [drain]{.sub} [handle]{.arg} 
[cmdPrefix]{.ins} [finalize]{.sub} [handle]{.arg} 
[cmdPrefix]{.ins} [flush]{.sub} [handle]{.arg} 
[cmdPrefix]{.ins} [initialize]{.sub} [handle]{.arg} [mode]{.arg} 
[cmdPrefix]{.ins} [limit?]{.sub} [handle]{.arg} 
[cmdPrefix]{.ins} [read]{.sub} [handle]{.arg} [buffer]{.arg} 
[cmdPrefix]{.ins} [write]{.sub} [handle]{.arg} [buffer]{.arg} 
:::

# BESCHREIBUNG

Der Tcl-Ebenen-Handler für eine Kanaltransformation muss ein Befehl mit Unterbefehlen sein (als *Ensemble* bezeichnet, ohne dass er mit **namespace ensemble create** erzeugt sein muss; dieser Mechanismus ist in keiner Weise an **namespace ensemble** gebunden). *cmdPrefix* ist das, was beim Aufruf von **chan push** angegeben wurde, und kann aus mehreren Argumenten bestehen; es wird an Stelle des Präfixes zu mehreren Wörtern expandiert.

Von allen möglichen Unterbefehlen muss der Handler **initialize** und **finalize** unterstützen. Transformationen für beschreibbare Kanäle müssen außerdem **write** unterstützen, Transformationen für lesbare Kanäle müssen **read** unterstützen.

Beachten Sie, dass *cmdPrefix* in den Beschreibungen unten aus mehr als einem Wort bestehen kann und *handle* der von **chan push** beim Erzeugen der Transformation zurückgegebene Wert ist.

## Allgemeine Unterbefehle

Die folgenden Unterbefehle sind für alle Kanaltypen relevant.

*cmdPrefix* **clear** *handle*
: Dieser optionale Unterbefehl wird aufgerufen, um der Transformation mitzuteilen, dass alle in internen Puffern gespeicherten Daten (eingehend oder ausgehend) geleert werden müssen. Er wird aufgerufen, wenn auf dem transformierten Kanal ein **chan seek** ausgeführt wird.

*cmdPrefix* **finalize** *handle*
: Dieser Pflicht-Unterbefehl wird zuletzt für den angegebenen *handle* aufgerufen und danach nie wieder; er dient dazu, alle mit der Transformation verbundenen Tcl-Ebenen-Datenstrukturen freizugeben. *Warnung!* Alle von diesem Unterbefehl geworfenen Fehler werden ignoriert. Es ist nicht garantiert, dass er aufgerufen wird, wenn der Interpreter gelöscht wird.

*cmdPrefix* **initialize** *handle mode*
: Dieser Pflicht-Unterbefehl wird zuerst aufgerufen und danach nie wieder (für den angegebenen *handle*). Er ist dafür verantwortlich, alle Teile der Transformation auf Tcl-Ebene zu initialisieren. *mode* ist eine Liste, die beliebig **read** und **write** enthalten kann.

**write**
: bedeutet, dass der Kanal beschreibbar ist.

**read**
: bedeutet, dass der Kanal lesbar ist.

    Der Rückgabewert des Unterbefehls soll eine Liste mit den Namen aller von diesem Handler unterstützten Unterbefehle sein. Jeder vom Unterbefehl geworfene Fehler verhindert die Erzeugung der Transformation. Der geworfene Fehler erscheint als vom Befehl **chan push** geworfener Fehler.


## Lesebezogene Unterbefehle

Diese Unterbefehle werden für Transformationen auf lesbaren Kanälen verwendet; streng genommen ist **read** optional, muss aber unterstützt werden, wenn einer der anderen unterstützt wird, sonst wird der Kanal nicht lesbar gemacht.

*cmdPrefix* **drain** *handle*
: Dieser optionale Unterbefehl wird aufgerufen, wenn Daten im Eingabe- (d. h. Lese-)Puffer der Transformation nach oben, d. h. zum Benutzer oder Skript, erzwungen werden müssen. Das von der Methode zurückgegebene Ergebnis wird als die *binären* Daten interpretiert, die nach oben an die Ebene über dieser Transformation (den Leser oder eine Transformation höherer Ebene) weitergereicht werden.
    Mit anderen Worten: Wenn diese Methode aufgerufen wird, kann die Transformation die eigentliche Transformationsoperation nicht mehr aufschieben und muss alle in ihren internen Lesepuffern wartenden Daten transformieren und das Ergebnis dieser Aktion zurückgeben.

*cmdPrefix* **limit?** *handle*
: Dieser optionale Unterbefehl wird aufgerufen, damit die Tcl-E/A-Engine bestimmen kann, wie weit sie vorauslesen soll. Ist er vorhanden, soll er eine Ganzzahl größer als null zurückgeben, die angibt, wie viele Bytes vorausgelesen werden sollen, oder eine Ganzzahl kleiner als null, um anzuzeigen, dass die E/A-Engine beliebig weit vorauslesen darf.

*cmdPrefix* **read** *handle buffer*
: Dieser Unterbefehl, der vorhanden sein muss, wenn die Transformation mit lesbaren Kanälen arbeiten soll, wird aufgerufen, wenn der Basiskanal oder eine Transformation unterhalb dieser Transformation Daten nach oben weitergibt. *buffer* enthält die von unten übergebenen binären Daten. Es ist Aufgabe dieses Unterbefehls, die Daten tatsächlich zu transformieren. Der Rückgabewert des Unterbefehls wird als die binären Daten interpretiert, die weiter nach oben an die Transformation über dieser Transformation weitergereicht werden. Das kann auch der Benutzer oder das Skript sein, das ursprünglich vom Kanal gelesen hat.
    Beachten Sie, dass das Ergebnis leer sein darf oder sogar weniger als die empfangenen Daten; die Transformation muss nicht alles, was ihr jetzt übergeben wird, sofort transformieren. Sie darf eingehende Daten in internen Puffern speichern und die eigentliche Transformation aufschieben, bis sie mehr Daten hat.


## Schreibbezogene Unterbefehle

Diese Unterbefehle werden für Transformationen auf beschreibbaren Kanälen verwendet; streng genommen ist **write** optional, muss aber unterstützt werden, wenn einer der anderen unterstützt wird, sonst wird der Kanal nicht beschreibbar gemacht.

*cmdPrefix* **flush** *handle*
: Dieser optionale Unterbefehl wird aufgerufen, wenn Daten im Schreibpuffer der Transformation nach unten, d. h. zum Basiskanal, erzwungen werden müssen. Der Rückgabewert des Unterbefehls wird als die binären Daten interpretiert, die an die Transformation unterhalb der aktuellen Transformation geschrieben werden. Das kann auch der Basiskanal sein.
    Mit anderen Worten: Wenn dieser Unterbefehl aufgerufen wird, kann die Transformation die eigentliche Transformationsoperation nicht mehr aufschieben und muss alle in ihren internen Schreibpuffern wartenden Daten transformieren und das Ergebnis dieser Aktion zurückgeben.

*cmdPrefix* **write** *handle buffer*
: Dieser Unterbefehl, der vorhanden sein muss, wenn die Transformation mit beschreibbaren Kanälen arbeiten soll, wird aufgerufen, wenn der Benutzer oder eine Transformation über dieser Transformation Daten nach unten schreibt. *buffer* enthält die an uns geschriebenen binären Daten. Es ist Aufgabe dieses Unterbefehls, die Daten tatsächlich zu transformieren.
    Der Rückgabewert des Unterbefehls wird als die binären Daten interpretiert, die an die Transformation unterhalb dieser Transformation geschrieben werden. Das kann auch der Basiskanal sein. Beachten Sie, dass das Ergebnis leer sein darf oder weniger als die empfangenen Daten; die Transformation muss nicht alles, was ihr jetzt geschrieben wird, sofort transformieren. Sie darf diese Daten in internen Puffern speichern und die eigentliche Transformation aufschieben, bis sie mehr Daten hat.

