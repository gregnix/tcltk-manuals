---
CommandName: chan
title: chan
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - close(n)
 - eof(n)
 - fblocked(n)
 - fconfigure(n)
 - fcopy(n)
 - file(n)
 - fileevent(n)
 - flush(n)
 - gets(n)
 - open(n)
 - puts(n)
 - read(n)
 - seek(n)
 - socket(n)
 - tell(n)
 - refchan(n)
 - transchan(n)
 - Tcl_StandardChannels(3)
Keywords:
 - blocking
 - channel
 - end of file
 - events
 - input
 - non-blocking
 - offset
 - output
 - readable
 - seek
 - stdio
 - tell
 - writable
Copyright:
 - Copyright (c) 2005-2006 Donal K. Fellows
---

# Name

chan - Lesen, Schreiben und Manipulieren von Kanälen

# Übersicht

::: {.synopsis} :::
[chan]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Dieser Befehl bietet mehrere Operationen zum Lesen von, Schreiben auf und sonstigen Manipulieren geöffneter Kanäle (wie sie mit den Befehlen [open] und [socket] erzeugt wurden oder wie die Standardkanäle **stdin**, **stdout** und **stderr**, die den Standard-Eingabe-, Ausgabe- und Fehlerströmen des Prozesses entsprechen). *Option* gibt an, was mit dem Kanal geschehen soll; jede eindeutige Abkürzung von *option* ist zulässig. Gültige Optionen sind:

[chan]{.cmd} [blocked]{.sub} [channelId]{.arg}
: Prüft, ob die letzte Eingabeoperation auf dem Kanal *channelId* fehlgeschlagen ist, weil sie den Prozess sonst hätte blockieren lassen, und gibt 1 zurück, wenn das der Fall war. Andernfalls gibt sie 0 zurück. Beachten Sie, dass hier nur dann 1 zurückgegeben wird, wenn der Kanal für den nicht blockierenden Modus konfiguriert ist; alle Tcl-Kanäle haben standardmäßig Blockierung eingeschaltet.

[chan]{.cmd} [close]{.sub} [channelId]{.arg} [direction]{.optarg}
: Schließt und zerstört den Kanal *channelId*. Beachten Sie, dass dabei alle auf dem Kanal registrierten Datei-Ereignisse gelöscht werden. [Ist das Argument *direction* (das **read** oder **write** oder eine eindeutige Abkürzung davon sein muss) angegeben, wird der Kanal nur halb geschlossen, sodass er von Lese-Schreib- auf nur-Schreib- bzw. nur-Lese-Modus wechseln kann. Wird ein nur-Lese-Kanal zum Lesen geschlossen, entspricht das einem vollständigen Schließen des Kanals; analog für nur-Schreib-Kanäle. Ohne das Argument *direction* wird der Kanal sowohl zum Lesen als auch zum Schreiben geschlossen (aber nur, wenn diese Richtungen derzeit geöffnet sind). Es ist ein Fehler, einen nur-Lese-Kanal zum Schreiben oder einen nur-Schreib-Kanal zum Lesen zu schließen.]{version="8.6"}

    Beim Schließen des Kanals wird die gesamte gepufferte Ausgabe auf das Ausgabegerät des Kanals geschrieben (nur wenn der Kanal nicht mehr beschreibbar wird), gepufferte Eingabe verworfen (nur wenn der Kanal nicht mehr lesbar wird), die zugrunde liegende Betriebssystemressource geschlossen und *channelId* für künftige Verwendung ungültig (jeweils nur wenn der Kanal vollständig geschlossen wird).

    Ist der Kanal blockierend und wird er nicht mehr beschreibbar, kehrt der Befehl erst zurück, wenn die gesamte Ausgabe geleert wurde. Ist der Kanal nicht blockierend und gibt es noch nicht geleerte Ausgabe, bleibt der Kanal geöffnet und der Befehl kehrt sofort zurück; die Ausgabe wird im Hintergrund geleert und der Kanal wird geschlossen, wenn das Leeren abgeschlossen ist.

    Ist *channelId* ein blockierender Kanal einer Befehlspipeline, wartet **chan close**, bis die Kindprozesse beendet sind.

    Wird der Kanal zwischen Interpretern geteilt, macht **chan close** *channelId* im aufrufenden Interpreter unverfügbar, hat aber keine weiteren Auswirkungen, bis alle teilenden Interpreter den Kanal geschlossen haben. Wenn der letzte Interpreter, in dem der Kanal registriert ist, **chan close** (oder [close]) aufruft, erfolgen die oben beschriebenen Aufräumarbeiten. Beim Halbschließen gilt das Halbschließen des Kanals nur für die Sicht des aktuellen Interpreters, bis alle Interpreter ihn in dieser Richtung (oder vollständig) geschlossen haben. Siehe den Befehl [interp] für eine Beschreibung der Kanalfreigabe.

    Kanäle werden automatisch vollständig geschlossen, wenn ein Interpreter zerstört wird und wenn der Prozess beendet wird. Kanäle werden in den blockierenden Modus geschaltet, um sicherzustellen, dass die gesamte Ausgabe vor Prozessende korrekt geleert wird.

    Der Befehl gibt eine leere Zeichenkette zurück und kann einen Fehler erzeugen, wenn beim Leeren der Ausgabe ein Fehler auftritt. Gibt ein Befehl in einer mit [open] erzeugten Befehlspipeline einen Fehler zurück, erzeugt **chan close** einen Fehler (ähnlich dem Befehl [exec]).

    [Beachten Sie, dass Halbschließen von Sockets und Befehlspipelines wichtige Nebenwirkungen haben kann, weil dabei **shutdown()** oder **close()** der zugrunde liegenden Systemressource ausgelöst wird, was das Verhalten anderer Prozesse oder Systeme gegenüber dem Tcl-Programm ändern kann.]{version="8.6"}

[chan]{.cmd} [configure]{.sub} [channelId]{.arg} [optionName]{.optarg} [value]{.optarg} [optionName value]{.optdot}
: Abfragen oder Setzen der Konfigurationsoptionen des Kanals *channelId*.

    Werden keine Argumente *optionName* oder *value* angegeben, gibt der Befehl eine Liste mit abwechselnden Optionsnamen und Werten für den Kanal zurück. Ist *optionName* angegeben, aber kein *value*, gibt der Befehl den aktuellen Wert der angegebenen Option zurück. Werden ein oder mehrere Paare *optionName* und *value* angegeben, setzt der Befehl jede benannte Option auf den entsprechenden *value*; in diesem Fall ist der Rückgabewert eine leere Zeichenkette.

    Die unten beschriebenen Optionen werden für alle Kanäle unterstützt. Zusätzlich kann jeder Kanaltyp eigene Optionen hinzufügen. Siehe den Manpage-Eintrag des Befehls, der den jeweiligen Kanaltyp erzeugt, für die von diesem Typ unterstützten Optionen. Beispielsweise enthält der Manpage-Eintrag zum Befehl [socket] zusätzliche Optionen für Sockets und der Befehl [open] zusätzliche Optionen für serielle Geräte.

[-blocking]{.lit} [boolean]{.arg}
: Die Option **-blocking** legt fest, ob E/A-Operationen auf dem Kanal den Prozess unbegrenzt blockieren können. Der Wert der Option muss ein gültiger boolescher Wert sein. Kanäle sind normalerweise im blockierenden Modus; wird ein Kanal in den nicht blockierenden Modus versetzt, beeinflusst das die Operationen der Befehle **chan gets**, **chan read**, **chan puts**, **chan flush** und **chan close**; Einzelheiten finden sich in deren Dokumentation. Damit der nicht blockierende Modus korrekt funktioniert, muss die Anwendung die Tcl-Ereignisschleife verwenden (z. B. durch Aufruf von [Tcl\_DoOneEvent][DoOneEvent] oder den Befehl [vwait]).

[-buffering]{.lit} [newValue]{.arg}
: Ist *newValue* **full**, puffert das E/A-System die Ausgabe, bis der interne Puffer voll ist oder der Befehl **chan flush** aufgerufen wird. Ist *newValue* **line**, leert das E/A-System die Ausgabe für den Kanal automatisch, sobald ein Zeilenumbruch ausgegeben wird. Ist *newValue* **none**, leert das E/A-System nach jeder Ausgabeoperation automatisch. Standardmäßig ist **-buffering** auf **full** gesetzt, außer bei Kanälen, die mit terminalähnlichen Geräten verbunden sind; für diese Kanäle ist die Anfangseinstellung **line**. Zusätzlich sind **stdin** und **stdout** anfänglich auf **line** gesetzt, **stderr** auf **none**.

[-buffersize]{.lit} [newSize]{.arg}
: *newSize* muss eine Ganzzahl sein; ihr Wert wird verwendet, um die Größe der für diesen Kanal anschließend zugewiesenen Ein- oder Ausgabepuffer in Bytes festzulegen. *newSize* darf höchstens eine Million sein, sodass Puffer bis zu einer Million Bytes groß sein können.

[-encoding]{.lit} [name]{.arg}
: Diese Option legt die Kodierung des Kanals als eine der von [encoding names][encoding] zurückgegebenen benannten Kodierungen oder als den Sonderwert [binary] fest, damit die Daten für die Verwendung in Tcl nach Unicode und zurück konvertiert werden können. Damit Tcl beispielsweise Zeichen aus einer japanischen Datei in **shiftjis** liest und den Inhalt korrekt verarbeitet und anzeigt, würde die Kodierung auf **shiftjis** gesetzt. Beim Lesen vom Kanal werden die Bytes in der japanischen Datei beim Lesen nach Unicode konvertiert. Schreiben wird ebenfalls unterstützt — Tcl-Zeichenketten werden beim Schreiben auf den Kanal automatisch in die angegebene Kodierung konvertiert.

    Enthält eine Datei reine Binärdaten (z. B. ein JPEG-Bild), sollte die Kodierung des Kanals auf [binary] gesetzt werden. Tcl weist den Daten in der Datei dann keine Interpretation zu und liest oder schreibt einfach rohe Bytes. Der Tcl-Befehl [binary] kann zur Bearbeitung dieser byteorientierten Daten verwendet werden. In der Regel ist es besser, die Option **-translation** auf [binary] zu setzen, wenn Binärdaten übertragen werden sollen, da damit auch die anderen automatischen Interpretationen der Bytes im Strom abgeschaltet werden.

    Die Standardkodierung für neu geöffnete Kanäle ist dieselbe plattform- und localeabhängige Systemkodierung, die für die Schnittstelle zum Betriebssystem verwendet wird, wie von [encoding system][encoding] zurückgegeben.

[-eofchar]{.lit} [char]{.arg}
: ...siehe nächstes...

[-eofchar]{.lit} [{inChar outChar}]{.arg}
: Diese Option unterstützt DOS-Dateisysteme, die Control-z (\\x1A) als Dateiende-Markierung verwenden. Ist *char* keine leere Zeichenkette, signalisiert dieses Zeichen beim Lesen das Dateiende. Bei der Ausgabe wird das Dateiende-Zeichen beim Schließen des Kanals ausgegeben. Ist *char* die leere Zeichenkette, gibt es keine spezielle Dateiende-Zeichenmarkierung. Bei Lese-Schreib-Kanälen legt eine Liste mit zwei Elementen die Dateiende-Markierung für Eingabe bzw. Ausgabe fest. Der Einfachheit halber kann beim Setzen des Dateiende-Zeichens für einen Lese-Schreib-Kanal ein einzelner Wert angegeben werden, der für Lesen und Schreiben gilt. Beim Abfragen des Dateiende-Zeichens eines Lese-Schreib-Kanals wird immer eine Liste mit zwei Elementen zurückgegeben. Der Standardwert für **-eofchar** ist in allen Fällen die leere Zeichenkette, außer bei Dateien unter Windows. Dort ist **-eofchar** beim Lesen Control-z (\\x1A) und beim Schreiben die leere Zeichenkette. Der zulässige Bereich für **-eofchar**-Werte ist \\x01 - \\x7f; der Versuch, **-eofchar** auf einen Wert außerhalb dieses Bereichs zu setzen, erzeugt einen Fehler.

[-translation]{.lit} [translation]{.arg}
: ...siehe nächstes...

[-translation]{.lit} [{inTranslation outTranslation}]{.arg}
: In Tcl-Skripten wird das Ende einer Zeile immer durch ein einzelnes Newline-Zeichen (\\n) dargestellt. In tatsächlichen Dateien und Geräten kann das Zeilenende jedoch auf verschiedenen Plattformen oder sogar für verschiedene Geräte auf derselben Plattform unterschiedlich dargestellt sein. Unter UNIX werden in Dateien beispielsweise Newlines verwendet, während in Netzwerkverbindungen normalerweise Wagenrücklauf-Zeilenvorschub-Sequenzen verwendet werden. Bei der Eingabe (d. h. mit **chan gets** und **chan read**) übersetzt das Tcl-E/A-System die externe Zeilenende-Darstellung automatisch in Newline-Zeichen. Bei der Ausgabe (d. h. mit **chan puts**) übersetzt das E/A-System Newlines in die externe Zeilenende-Darstellung. Der Standardübersetzungsmodus **auto** behandelt alle gängigen Fälle automatisch, aber die Option **-translation** bietet explizite Kontrolle über die Zeilenende-Übersetzungen.

    Der mit **-translation** verknüpfte Wert ist ein einzelnes Element für Nur-Lese- und Nur-Schreib-Kanäle. Für Lese-Schreib-Kanäle ist der Wert eine Liste mit zwei Elementen; der Leseübersetzungsmodus ist das erste Element der Liste, der Schreibübersetzungsmodus das zweite. Der Einfachheit halber kann beim Setzen des Übersetzungsmodus für einen Lese-Schreib-Kanal ein einzelner Wert angegeben werden, der für Lesen und Schreiben gilt. Beim Abfragen des Übersetzungsmodus eines Lese-Schreib-Kanals wird immer eine Liste mit zwei Elementen zurückgegeben. Derzeit werden folgende Werte unterstützt:

    **auto**
    : Als Eingabeübersetzungsmodus behandelt **auto** jedes von Newline (**lf**), Wagenrücklauf (**cr**) oder Wagenrücklauf gefolgt von einem Zeilenvorschub (**crlf**) als Zeilenende-Darstellung. Die Zeilenende-Darstellung kann sogar von Zeile zu Zeile wechseln; alle Fälle werden in ein Newline übersetzt. Als Ausgabeübersetzungsmodus wählt **auto** eine plattformspezifische Darstellung; für Sockets auf allen Plattformen wählt Tcl **crlf**, für alle Unix-Varianten **lf** und für die verschiedenen Windows-Varianten **crlf**. Die Standardeinstellung für **-translation** ist **auto** sowohl für Eingabe als auch Ausgabe.

    [binary]
    : Wie **lf** wird keine Zeilenende-Übersetzung durchgeführt, setzt aber zusätzlich **-eofchar** auf die leere Zeichenkette, um es zu deaktivieren, und **-encoding** auf **iso8859-1**. Mit dieser einen Einstellung ist ein Kanal vollständig für binäre Ein- und Ausgabe konfiguriert: Jedes vom Kanal gelesene Byte wird zum Unicode-Zeichen mit demselben Wert wie dieses Byte, und jedes in den Kanal geschriebene Zeichen wird zu einem einzelnen Byte in der Ausgabe. So kann nahtlos mit Binärdaten gearbeitet werden, solange jedes Zeichen in den Daten im Bereich 0 bis 255 bleibt, sodass kein Unterschied zwischen Binärdaten und Text besteht. Beispielsweise kann ein JPEG-Bild von einem solchen Kanal gelesen, bearbeitet und wieder auf einen solchen Kanal geschrieben werden.

    **cr**
    : Das Ende einer Zeile in der zugrunde liegenden Datei oder dem Gerät wird durch ein einzelnes Wagenrücklauf-Zeichen dargestellt. Als Eingabeübersetzungsmodus konvertiert der Modus **cr** Wagenrückläufe in Newline-Zeichen. Als Ausgabeübersetzungsmodus übersetzt **cr** Newline-Zeichen in Wagenrückläufe.

    **crlf**
    : Das Ende einer Zeile in der zugrunde liegenden Datei oder dem Gerät wird durch ein Wagenrücklauf-Zeichen gefolgt von einem Zeilenvorschub dargestellt. Als Eingabeübersetzungsmodus konvertiert der Modus **crlf** Wagenrücklauf-Zeilenvorschub-Sequenzen in Newline-Zeichen. Als Ausgabeübersetzungsmodus übersetzt **crlf** Newline-Zeichen in Wagenrücklauf-Zeilenvorschub-Sequenzen. Dieser Modus wird typischerweise auf Windows-Plattformen und für Netzwerkverbindungen verwendet.

    **lf**
    : Das Ende einer Zeile in der zugrunde liegenden Datei oder dem Gerät wird durch ein einzelnes Newline- (Zeilenvorschub-)Zeichen dargestellt. In diesem Modus erfolgen weder bei der Eingabe noch bei der Ausgabe Übersetzungen. Dieser Modus wird typischerweise auf UNIX-Plattformen verwendet.


[chan]{.cmd} [copy]{.sub} [inputChan]{.arg} [outputChan]{.arg} [[-size]{.lit} [size]{.arg}]{.optarg} [[-command]{.lit} [callback]{.arg}]{.optarg}
: Kopiert Daten vom Kanal *inputChan*, der zum Lesen geöffnet sein muss, in den Kanal *outputChan*, der zum Schreiben geöffnet sein muss. Der Befehl **chan copy** nutzt die Pufferung des Tcl-E/A-Systems, um zusätzliche Kopien zu vermeiden und zu verhindern, dass beim Kopieren großer Dateien auf langsame Ziele wie Netzwerk-Sockets zu viele Daten im Hauptspeicher gepuffert werden.

    Der Befehl **chan copy** überträgt Daten von *inputChan*, bis das Dateiende erreicht ist oder *size* Bytes bzw. Zeichen übertragen wurden; *size* wird in Bytes gezählt, wenn beide Kanäle dieselbe Kodierung verwenden, andernfalls in Zeichen. Ist kein Argument **-size** angegeben, wird bis zum Dateiende kopiert. Alle von *inputChan* gelesenen Daten werden nach *outputChan* kopiert. Ohne die Option **-command** blockiert **chan copy**, bis der Kopiervorgang abgeschlossen ist, und gibt die Anzahl der nach *outputChan* geschriebenen Bytes bzw. Zeichen zurück (nach denselben Regeln wie bei der Option **-size**).

    Das Argument **-command** lässt **chan copy** im Hintergrund arbeiten. In diesem Fall kehrt der Befehl sofort zurück, und *callback* wird später aufgerufen, wenn der Kopiervorgang abgeschlossen ist. *callback* wird mit einem oder zwei zusätzlichen Argumenten aufgerufen, die angeben, wie viele Bytes nach *outputChan* geschrieben wurden. Ist während des Hintergrundkopierens ein Fehler aufgetreten, ist das zweite Argument die zugehörige Fehlermeldung. Beim Hintergrundkopieren müssen *inputChan* und *outputChan* nicht in den nicht blockierenden Modus versetzt werden; das erledigt der Befehl **chan copy** automatisch. Allerdings muss die Ereignisschleife betreten werden, mit dem Befehl [vwait] oder durch Verwendung von Tk.

    Während eines Hintergrund-**chan copy** dürfen keine anderen E/A-Operationen auf *inputChan* oder *outputChan* ausgeführt werden. Wird *inputChan* oder *outputChan* während des Kopiervorgangs geschlossen, wird das laufende Kopieren abgebrochen, und der Callback wird *nicht* aufgerufen. Wird *inputChan* geschlossen, werden alle bereits für *outputChan* eingereihten Daten noch geschrieben.

    Beachten Sie, dass *inputChan* während eines Hintergrundkopierens lesbar werden kann. Während eines Hintergrundkopierens sollten alle **chan event**- oder [fileevent]-Handler abgeschaltet werden, damit sie das Kopieren nicht stören. Jeder E/A-Versuch eines **chan event**- oder [fileevent]-Handlers führt zum Fehler „channel busy“.

    **Chan copy** übersetzt Zeilenende-Sequenzen in *inputChan* und *outputChan* gemäß der Option **-translation** dieser Kanäle (siehe **chan configure** oben). Durch die Übersetzungen kann die Anzahl der von *inputChan* gelesenen Bytes von der Anzahl der nach *outputChan* geschriebenen Bytes abweichen. Gemeldet wird nur die Anzahl der nach *outputChan* geschriebenen Bytes, entweder als Rückgabewert eines synchronen **chan copy** oder als Argument des Callbacks eines asynchronen **chan copy**.

    **Chan copy** beachtet die für die Kanäle konfigurierten Kodierungen und Zeichenübersetzungen. Das heißt, die eingehenden Zeichen werden intern zuerst nach UTF-8 und dann in die Kodierung des Kanals konvertiert, auf den **chan copy** schreibt (Einzelheiten zu den Optionen **-encoding** und **-translation** siehe **chan configure** oben). Es findet keine Konvertierung statt, wenn beide Kanäle auf die Kodierung [binary] gesetzt sind und übereinstimmende Übersetzungen haben. Ist nur der Ausgabekanal auf die Kodierung [binary] gesetzt, schreibt das System die interne UTF-8-Darstellung der eingehenden Zeichen. Ist nur der Eingabekanal auf die Kodierung [binary] gesetzt, nimmt das System an, dass die eingehenden Bytes gültige UTF-8-Zeichen sind, und konvertiert sie gemäß der Ausgabekodierung. Das Verhalten des Systems bei Bytes, die keine gültigen UTF-8-Zeichen sind, ist in diesem Fall undefiniert.

[chan]{.cmd} [create]{.sub} [mode]{.arg} [cmdPrefix]{.arg}
: Dieser Unterbefehl erzeugt einen neuen Kanal auf Skriptebene, der das Befehlspräfix *cmdPrefix* als Handler verwendet. Ein solcher Kanal heißt **reflektierter** Kanal. Das angegebene Befehlspräfix **cmdPrefix** muss eine nicht leere Liste sein und sollte die in der Manpage [refchan] beschriebene API bereitstellen. Der Bezeichner des neuen Kanals wird als Ergebnis des Befehls **chan create** zurückgegeben, und der Kanal ist geöffnet. Verwenden Sie [close] oder **chan close**, um den Kanal zu entfernen.

    Das Argument *mode* gibt an, ob der neue Kanal zum Lesen, Schreiben oder beidem geöffnet ist. Es muss eine Liste sein, die beliebige der Zeichenketten „**read**“ oder „**write**“ enthält. Die Liste muss mindestens ein Element haben, da ein Kanal, auf den man weder schreiben noch lesen kann, keinen Sinn ergibt. Der Handler-Befehl für den neuen Kanal muss den gewählten Modus unterstützen, sonst wird ein Fehler ausgelöst.

    Das Befehlspräfix wird im globalen Namespace am oberen Ende des Aufrufstapels ausgeführt, nach Anhängen der Argumente wie in der Manpage [refchan] beschrieben. Die Befehlsauflösung erfolgt zum Zeitpunkt des Aufrufs. Das Umbenennen oder Zerstören des Befehls bedeutet, dass der nächste Aufruf einer Handler-Methode fehlschlagen kann und damit auch der den Handler aufrufende Kanalbefehl; je nach aufgerufenem Unterbefehl kann die Fehlermeldung den Grund dafür nicht erklären.

    Jeder mit diesem Unterbefehl erzeugte Kanal kennt den Interpreter, in dem er erzeugt wurde, und führt seinen Handler-Befehl nur in diesem Interpreter aus, auch wenn der Kanal geteilt und/oder in einen anderen Interpreter verschoben wurde. Jeder reflektierte Kanal kennt auch den Thread, in dem er erzeugt wurde, und führt seinen Handler-Befehl nur in diesem Thread aus, auch wenn der Kanal in einen anderen Thread verschoben wurde. Zu diesem Zweck werden alle Handler-Aufrufe durch Posten spezieller Ereignisse an den ursprünglichen Thread weitergeleitet. Das bedeutet, dass der ursprüngliche Thread (d. h. der Thread, der **chan create** ausgeführt hat) eine aktive Ereignisschleife haben muss, d. h. er muss solche Ereignisse verarbeiten können. Andernfalls blockiert der sendende Thread *unbegrenzt*. Es kann zu einer Deadlock-Situation kommen.

    Beachten Sie, dass damit ein Kanal erzeugt werden kann, dessen beiden Endpunkte in zwei verschiedenen Threads leben und eine streamorientierte Brücke zwischen diesen Threads bildet. Mit anderen Worten: reguläre Stream-Kommunikation zwischen Threads statt Befehle senden zu müssen.

    Wird ein Thread oder Interpreter gelöscht, werden alle mit diesem Unterbefehl erzeugten Kanäle, die diesen Thread/Interpreter als Rechenbasis verwenden, ebenfalls in allen Interpretern gelöscht, mit denen sie geteilt oder in die sie verschoben wurden, und in jedem Thread, in den sie übertragen wurden. Obwohl das den anderen Thread(s) und/oder Interpreter(n) den Boden entzieht, lässt sich das nicht vermeiden. Der Versuch, einen solchen Kanal zu verwenden, führt zu einem regulären Fehler über unbekannte Kanalbezeichner.

    Dieser Unterbefehl ist **safe** und für sichere Interpreter zugänglich. Obwohl er die Ausführung beliebigen Tcl-Codes veranlasst, stellt das System sicher, dass der Code immer innerhalb des sicheren Interpreters ausgeführt wird.

[chan]{.cmd} [eof]{.sub} [channelId]{.arg}
: Prüft, ob die letzte Eingabeoperation auf dem Kanal *channelId* fehlgeschlagen ist, weil das Ende des Datenstroms erreicht wurde; gibt 1 zurück, wenn Dateiende erreicht wurde, und 0 andernfalls.

[chan]{.cmd} [event]{.sub} [channelId]{.arg} [event]{.arg} [script]{.optarg}
: Richtet ein, dass das Tcl-Skript *script* als *Datei-Ereignishandler* installiert wird, der aufgerufen wird, sobald der Kanal *channelId* in den von *event* beschriebenen Zustand wechselt (*event* muss **readable** oder **writable** sein); pro Ereignis und Kanal kann jeweils nur ein solcher Handler installiert sein. Ist *script* die leere Zeichenkette, wird der aktuelle Handler gelöscht (das geschieht auch beim Schließen des Kanals oder Löschen des Interpreters). Wird *script* weggelassen, wird das aktuell installierte Skript zurückgegeben (oder eine leere Zeichenkette, wenn kein solcher Handler installiert ist). Der Callback wird nur ausgeführt, wenn die Ereignisschleife bedient wird (z. B. über [vwait] oder [update]).

    Ein Datei-Ereignishandler ist eine Bindung zwischen einem Kanal und einem Skript, sodass das Skript ausgewertet wird, sobald der Kanal lesbar oder beschreibbar wird. Datei-Ereignishandler werden am häufigsten verwendet, um Daten ereignisgesteuert von einem anderen Prozess zu empfangen, sodass der Empfänger weiter mit dem Benutzer oder anderen Kanälen interagieren kann, während auf die Daten gewartet wird. Ruft eine Anwendung **chan gets** oder **chan read** auf einem blockierenden Kanal auf, wenn keine Eingabedaten verfügbar sind, blockiert der Prozess; bis die Eingabedaten eintreffen, kann er keine anderen Ereignisse bedienen, sodass er für den Benutzer „einfriert“ wirkt. Mit **chan event** kann der Prozess erkennen, wann Daten vorhanden sind, und **chan gets** oder **chan read** nur aufrufen, wenn sie nicht blockieren.

    Ein Kanal gilt als lesbar, wenn auf dem zugrunde liegenden Gerät ungelesene Daten verfügbar sind. Ein Kanal gilt auch als lesbar, wenn ungelesene Daten in einem Eingabepuffer liegen, außer im Sonderfall, dass der letzte Leseversuch vom Kanal ein **chan gets**-Aufruf war, der keine vollständige Zeile im Eingabepuffer finden konnte. Diese Eigenschaft ermöglicht das zeilenweise Lesen einer Datei im nicht blockierenden Modus mit Ereignissen. Ein Kanal gilt auch als lesbar, wenn auf der zugrunde liegenden Datei oder dem Gerät ein Dateiende- oder Fehlerzustand vorliegt. Es ist wichtig, dass *script* diese Zustände prüft und angemessen behandelt; fehlt eine spezielle Prüfung auf Dateiende, kann eine Endlosschleife entstehen, in der *script* keine Daten liest, zurückkehrt und sofort erneut aufgerufen wird.

    Ein Kanal gilt als beschreibbar, wenn mindestens ein Byte auf die zugrunde liegende Datei oder das Gerät ohne Blockieren geschrieben werden kann oder ein Fehlerzustand auf der zugrunde liegenden Datei oder dem Gerät vorliegt. Beachten Sie, dass Client-Sockets im asynchronen Modus beschreibbar werden, wenn die Verbindung hergestellt ist oder die Verbindung fehlschlägt.

    Ereignisgesteuerte E/A funktioniert am besten für Kanäle, die mit **chan configure** in den nicht blockierenden Modus versetzt wurden. Im blockierenden Modus kann **chan puts** blockieren, wenn mehr Daten übergeben werden, als die zugrunde liegende Datei oder das Gerät aufnehmen kann, und **chan gets** oder **chan read** blockieren, wenn mehr Daten gelesen werden sollen als bereitstehen; während die Befehle blockieren, werden keine Ereignisse verarbeitet. Im nicht blockierenden Modus blockieren **chan puts**, **chan read** und **chan gets** nie.

    Das Skript für ein Datei-Ereignis wird auf globaler Ebene (außerhalb des Kontexts einer Tcl-Prozedur) in dem Interpreter ausgeführt, in dem **chan event** aufgerufen wurde. Tritt beim Ausführen des Skripts ein Fehler auf, wird der mit [interp bgerror][interp] registrierte Befehl zur Fehlermeldung verwendet. Zusätzlich wird der Datei-Ereignishandler gelöscht, wenn er jemals einen Fehler zurückgibt; das verhindert Endlosschleifen durch fehlerhafte Handler.

[chan]{.cmd} [flush]{.sub} [channelId]{.arg}
: Stellt sicher, dass die gesamte ausstehende Ausgabe für den Kanal *channelId* geschrieben wird.

    Ist der Kanal im blockierenden Modus, kehrt der Befehl erst zurück, wenn die gesamte gepufferte Ausgabe an den Kanal geleert wurde. Ist der Kanal im nicht blockierenden Modus, kann der Befehl zurückkehren, bevor die gesamte gepufferte Ausgabe geleert wurde; der Rest wird im Hintergrund so schnell geleert, wie die zugrunde liegende Datei oder das Gerät Daten aufnehmen kann.

[chan]{.cmd} [gets]{.sub} [channelId]{.arg} [varName]{.optarg}
: Liest die nächste Zeile vom Kanal *channelId*. Ist *varName* nicht angegeben, ist das Ergebnis des Befehls die gelesene Zeile (ohne abschließendes Newline-Zeichen) oder eine leere Zeichenkette bei Dateiende oder, im nicht blockierenden Modus, wenn die verfügbaren Daten erschöpft sind. Ist *varName* angegeben, wird die gelesene Zeile in die Variable *varName* geschrieben, und das Ergebnis ist die Anzahl der gelesenen Zeichen oder -1, wenn das Dateiende erreicht wurde oder, im nicht blockierenden Modus, die verfügbaren Daten erschöpft sind.

    Tritt das Dateiende mitten beim Lesen einer Zeile ein, wird die Teilzeile zurückgegeben (bzw. in *varName* geschrieben). Ist *varName* nicht angegeben, lässt sich der Fall des Dateiendes mit dem Befehl **chan eof** von einer leeren Zeile unterscheiden, und der Fall einer Teilzeile im nicht blockierenden Modus mit dem Befehl **chan blocked**.

[chan]{.cmd} [names]{.sub} [pattern]{.optarg}
: Erzeugt eine Liste aller Kanalnamen. Ist *pattern* angegeben, werden nur die Kanalnamen zurückgegeben, die ihm entsprechen (gemäß den Regeln von [string match][string]).

[chan]{.cmd} [pending]{.sub} [mode]{.arg} [channelId]{.arg}
: Gibt je nachdem, ob *mode* **input** oder **output** ist, die Anzahl der Bytes der Eingabe bzw. Ausgabe zurück, die derzeit intern für *channelId* gepuffert sind (besonders nützlich in einem lesbaren Ereignis-Callback, um anwendungsspezifische Grenzen für Eingabezeilenlängen zu setzen und einen potenziellen Denial-of-Service-Angriff zu vermeiden, bei dem ein feindlicher Benutzer eine extrem lange Zeile erzeugt, die den verfügbaren Speicher für den Puffer übersteigt). Gibt -1 zurück, wenn der Kanal nicht für den betreffenden Modus geöffnet wurde.

[chan]{.cmd} [pipe]{.sub}
: [Erzeugt eine eigenständige Pipe, deren Lese- und Schreibseiten-Kanäle als 2-Element-Liste zurückgegeben werden; das erste Element ist die Leseseite, das zweite die Schreibseite. Kann z. B. nützlich sein, um **stderr** und **stdout** eines Unterprozesses getrennt umzuleiten. Dazu den Unterprozess mit den Umleitungsoperatoren „2>@“ oder „>@“ auf die Schreibseite einer Pipe starten und sie im Elternprozess sofort schließen. Das ist nötig, um auf der Leseseite ein EOF zu erhalten, sobald der Kindprozess beendet ist oder seine Ausgabe sonst geschlossen hat.]{version="8.6"}

    Beachten Sie, dass die Puffersemantik auf Betriebssystemebene erheblich variieren kann; man darf nicht annehmen, dass ein Schreibvorgang auf der Ausgabeseite der Pipe sofort auf der Eingabeseite erscheint. Das ist ein grundlegender Unterschied, den Tcl nicht verbergen kann. Die Gesamt-Stream-Semantik *ist* kompatibel, sodass blockierende Lese- und Schreibvorgänge die meisten Unterschiede nicht sehen, aber die Details, was genau wann geschrieben wird, sind es nicht. Das zeigt sich am ehesten bei Pipelines zum Testen; es ist Vorsicht geboten, Deadlocks zu vermeiden und kurze Leseoperationen zuzulassen.

[chan]{.cmd} [pop]{.sub} [channelId]{.arg}
: [Entfernt die oberste Transformation vom Kanal *channelId*, falls vorhanden. Sind dem Kanal *channelId* keine Transformationen hinzugefügt, entspricht das **chan close** dieses Kanals. Das Ergebnis ist normalerweise die leere Zeichenkette, kann in manchen Situationen jedoch ein Fehler sein (z. B. wenn der zugrunde liegende Systemstrom geschlossen wird und das einen Fehler verursacht).]{version="8.6"}

[chan]{.cmd} [postevent]{.sub} [channelId]{.arg} [eventSpec]{.arg}
: Dieser Unterbefehl wird von mit **chan create** angegebenen Befehlshandlern verwendet. Er meldet dem durch den Bezeichner *channelId* dargestellten Kanal, dass die in *eventSpec* aufgeführten Ereignisse eingetreten sind. Das Argument muss eine Liste sein, die beliebige der Zeichenketten **read** und **write** enthält. Die Liste muss mindestens ein Element enthalten, da der Aufruf ohne zu meldende Ereignisse keinen Sinn ergibt.

    Beachten Sie, dass dieser Unterbefehl nur mit Kanalbezeichnern verwendet werden kann, die mit **chan create** erzeugt/geöffnet wurden. Alle anderen Kanäle führen zu einem Fehler dieses Unterbefehls.

    Da nur die Tcl-Ebene eines Kanals, d. h. sein Befehlshandler, Ereignisse an ihn melden sollte, ist die Verwendung auf den Interpreter beschränkt, der den Kanal erzeugt hat. Ereignisse an einen reflektierten Kanal aus einem Interpreter ohne dessen Implementierung zu melden, ist nicht erlaubt. Der Versuch, ein Ereignis aus einem anderen Interpreter zu melden, führt zu einem Fehler dieses Unterbefehls.

    Eine weitere Einschränkung: Es ist nicht möglich, Ereignisse zu melden, für die der E/A-Kern kein Interesse registriert hat. Der Versuch führt zu einer Ausnahme der Methode. Siehe die Handler-Methode **watch** in **refchan**, dem Dokument zur API von Befehlshandlern für reflektierte Kanäle.

    Dieser Befehl ist **safe** und für sichere Interpreter zugänglich. Er kann die Ausführung von **chan event**-Handlern auslösen, ob im aktuellen Interpreter oder in anderen Interpretern oder Threads, auch wenn das Ereignis aus einem sicheren Interpreter gemeldet und von einem vertrauenswürdigen Interpreter abgehört wird. **Chan event**-Handler werden *immer* in dem Interpreter ausgeführt, der sie eingerichtet hat.

[chan]{.cmd} [push]{.sub} [channelId]{.arg} [cmdPrefix]{.arg}
: [Fügt dem Kanal *channelId* eine neue Transformation hinzu. Das Argument *cmdPrefix* beschreibt eine Liste aus einem oder mehreren Wörtern, die einen Handler darstellen, der die Transformation implementiert. Das Befehlspräfix muss die in der Manpage [transchan] beschriebene API bereitstellen. Das Ergebnis dieses Unterbefehls ist ein Bezeichner für die Transformation. Es ist wichtig sicherzustellen, dass die Transformation den Kanalmodus unterstützt, mit dem sie verwendet wird, sonst kann der Kanal weder lesbar noch beschreibbar werden.]{version="8.6"}

[chan]{.cmd} [puts]{.sub} [-nonewline]{.optlit} [channelId]{.optarg} [string]{.arg}
: Schreibt *string* auf den Kanal *channelId* gefolgt von einem Newline-Zeichen. Ein abschließendes Newline wird geschrieben, sofern die optionale Flagge **-nonewline** nicht angegeben ist. Wird *channelId* weggelassen, wird die Zeichenkette auf den Standardausgabekanal **stdout** geschrieben.

    Newline-Zeichen in der Ausgabe werden von **chan puts** gemäß der aktuell konfigurierten Option **-translation** des Kanals in plattformspezifische Zeilenende-Sequenzen übersetzt (auf PCs werden Newlines normalerweise durch Wagenrücklauf-Zeilenvorschub-Sequenzen ersetzt; siehe **chan configure** oben für Einzelheiten).

    Tcl puffert Ausgabe intern, sodass mit **chan puts** geschriebene Zeichen möglicherweise nicht sofort auf der Ausgabedatei oder dem Gerät erscheinen; Tcl verzögert die Ausgabe normalerweise, bis der Puffer voll ist oder der Kanal geschlossen wird. Mit **chan flush** kann die Ausgabe sofort erzwungen werden.

    Wenn der Ausgabepuffer voll ist, blockiert **chan puts** normalerweise, bis das Betriebssystem alle gepufferten Daten zur Ausgabe angenommen hat. Ist *channelId* im nicht blockierenden Modus, blockiert **chan puts** nicht, auch wenn das Betriebssystem die Daten nicht annehmen kann. Stattdessen puffert Tcl weiter und schreibt im Hintergrund so schnell, wie die zugrunde liegende Datei oder das Gerät Daten aufnehmen kann. Die Anwendung muss die Tcl-Ereignisschleife verwenden, damit nicht blockierende Ausgabe funktioniert; sonst erfährt Tcl nie, dass die Datei oder das Gerät bereit für weitere Ausgabedaten ist. Für einen Kanal im nicht blockierenden Modus kann beliebig viel Daten gepuffert werden, was viel Speicher verbrauchen kann. Um Speicherverschwendung zu vermeiden, sollte nicht blockierende E/A normalerweise ereignisgesteuert mit **chan event** verwendet werden (rufen Sie **chan puts** nicht auf, es sei denn, Sie wurden kürzlich per Datei-Ereignis benachrichtigt, dass der Kanal bereit für weitere Ausgabedaten ist).

[chan]{.cmd} [read]{.sub} [channelId]{.arg} [numChars]{.optarg}
: ...siehe nächstes...

[chan]{.cmd} [read]{.sub} [-nonewline]{.optlit} [channelId]{.arg}
: In der ersten Form besteht das Ergebnis aus den nächsten *numChars* Zeichen, die vom Kanal *channelId* gelesen werden; wird *numChars* weggelassen, werden alle Zeichen bis zu dem Punkt gelesen, an dem der Kanal einen Fehler signalisieren würde (ob Dateiende, Blockierung oder anderer Fehlerzustand). In der zweiten Form (d. h. wenn *numChars* weggelassen wurde) kann die Flagge **-nonewline** angegeben werden, um anzuzeigen, dass ein abschließendes Newline in der gelesenen Zeichenkette entfernt werden soll.

    Ist *channelId* im nicht blockierenden Modus, liest **chan read** möglicherweise nicht so viele Zeichen wie angefordert: sobald alle verfügbare Eingabe gelesen ist, gibt der Befehl die verfügbaren Daten zurück, statt auf weitere Eingabe zu blockieren. Ist der Kanal für eine Mehrbyte-Kodierung konfiguriert, können im internen Puffer Bytes verbleiben, die kein vollständiges Zeichen bilden. Diese Bytes werden erst zurückgegeben, wenn ein vollständiges Zeichen verfügbar ist oder Dateiende erreicht ist. Der Schalter **-nonewline** wird ignoriert, wenn der Befehl zurückkehrt, bevor das Dateiende erreicht wird.

    **Chan read** übersetzt Zeilenende-Sequenzen in der Eingabe gemäß der Option **-translation** des Kanals in Newline-Zeichen (siehe **chan configure** oben für eine Diskussion, wie **chan configure** die Eingabe verändert).

    Beim Lesen von einem seriellen Port sollten die meisten Anwendungen den seriellen Port-Kanal auf nicht blockierend setzen, etwa so:

    ```
    chan configure channelId -blocking 0.
    ```

    Dann verhält sich **chan read** wie oben beschrieben. Beachten Sie, dass die meisten seriellen Ports vergleichsweise langsam sind; es ist durchaus möglich, für jedes vom Port gelesene Zeichen ein **readable**-Ereignis zu erhalten. Vorsicht ist geboten bei **chan read** auf blockierenden seriellen Ports:

    [chan]{.cmd} [read]{.sub} [channelId]{.arg} [numChars]{.arg}
    : In dieser Form blockiert **chan read**, bis *numChars* vom seriellen Port empfangen wurden.

    [chan]{.cmd} [read]{.sub} [channelId]{.arg}
    : In dieser Form blockiert **chan read**, bis das Dateiende-Zeichen empfangen wurde; siehe **chan configure -eofchar**. Ist für den Kanal kein Dateiende-Zeichen konfiguriert, blockiert **chan read** für immer.


[chan]{.cmd} [seek]{.sub} [channelId]{.arg} [offset]{.arg} [origin]{.optarg}
: Setzt die aktuelle Zugriffsposition im zugrunde liegenden Datenstrom für den Kanal *channelId* auf *offset* Bytes relativ zu *origin*. *Offset* muss eine Ganzzahl sein (kann negativ sein) und *origin* muss eines der folgenden sein:

    **start**
    : Die neue Zugriffsposition liegt *offset* Bytes vom Anfang der zugrunde liegenden Datei oder des Geräts entfernt.

    **current**
    : Die neue Zugriffsposition liegt *offset* Bytes von der aktuellen Zugriffsposition entfernt; ein negatives *offset* verschiebt die Zugriffsposition rückwärts in der zugrunde liegenden Datei oder dem Gerät.

    **end**
    : Die neue Zugriffsposition liegt *offset* Bytes vom Ende der Datei oder des Geräts entfernt. Ein negatives *offset* setzt die Zugriffsposition vor das Dateiende, ein positives *offset* danach.


    Das Argument *origin* ist standardmäßig **start**.

    **Chan seek** leert die gesamte gepufferte Ausgabe für den Kanal, bevor der Befehl zurückkehrt, auch wenn der Kanal im nicht blockierenden Modus ist. Er verwirft auch gepufferte und ungelesene Eingabe. Dieser Befehl gibt eine leere Zeichenkette zurück. Ein Fehler tritt auf, wenn der Befehl auf Kanälen angewendet wird, deren zugrunde liegende Datei oder Gerät kein Suchen unterstützt.

    Beachten Sie, dass *offset*-Werte Byte-Offsets sind, keine Zeichen-Offsets. Sowohl **chan seek** als auch **chan tell** arbeiten in Bytes, nicht in Zeichen, im Gegensatz zu **chan read**.

[chan]{.cmd} [tell]{.sub} [channelId]{.arg}
: Gibt eine Zahl zurück, die die aktuelle Zugriffsposition im zugrunde liegenden Datenstrom für den Kanal *channelId* angibt. Der zurückgegebene Wert ist ein Byte-Offset, der an **chan seek** übergeben werden kann, um den Kanal auf eine bestimmte Position zu setzen. Beachten Sie, dass dieser Wert in Bytes angegeben ist, nicht in Zeichen wie bei **chan read**. Der zurückgegebene Wert ist -1 für Kanäle, die kein Suchen unterstützen.

[chan]{.cmd} [truncate]{.sub} [channelId]{.arg} [length]{.optarg}
: Setzt die Bytelänge des zugrunde liegenden Datenstroms für den Kanal *channelId* auf *length* (oder auf den aktuellen Byte-Offset im zugrunde liegenden Datenstrom, wenn *length* weggelassen ist). Der Kanal wird vor dem Kürzen geleert.


# Beispiele

## Einfache Kanaloperations-Beispiele

Weisen Sie Tcl an, Ausgabe auf **stdout** sofort zu senden, unabhängig davon, ob es an ein Terminal geht:

```
chan configure stdout -buffering none
```

Im folgenden Beispiel wird eine Datei mit der unter Windows üblichen Kodierung CP1252 geöffnet, nach einer Zeichenkette gesucht, dieser Teil neu geschrieben und die Datei zwei Zeilen später gekürzt.

```
set f [open somefile.txt r+]
chan configure $f -encoding cp1252
set offset 0

# Nach der Zeichenkette "FOOBAR" in der Datei suchen
while {[chan gets $f line] >= 0} {
    set idx [string first FOOBAR $line]
    if {$idx >= 0} {
        # Gefunden; Zeile umschreiben

        chan seek $f [expr {$offset + $idx}]
        chan puts -nonewline $f BARFOO

        # Zur nächsten Zeile springen und kürzen
        chan gets $f
        chan gets $f
        chan truncate $f

        # Suche in der Datei jetzt beenden
        break
    }

    # Offset des Zeilenanfangs für später merken
    set offset [chan tell $f]
}
chan close $f
```

Ein Netzwerkserver, der seine Eingabe zeilenweise zurückgibt, ohne die gleichzeitige Bedienung anderer Verbindungen zu blockieren:

```
# Sehr einfacher Logger...
proc log {message} {
    chan puts stdout $message
}

# Wird aufgerufen, wenn ein neuer Client sich mit dem Server verbindet
proc connect {chan host port} {
    set clientName [format <%s:%d> $host $port]
    log "connection from $clientName"
    chan configure $chan -blocking 0 -buffering line
    chan event $chan readable [list echoLine $chan $clientName]
}

# Wird aufgerufen, sobald mindestens ein Byte Eingabedaten
# verfügbar ist oder der Kanal vom Client geschlossen wurde.
proc echoLine {chan clientName} {
    chan gets $chan line
    if {[chan eof $chan]} {
        log "finishing connection from $clientName"
        chan close $chan
    } elseif {![chan blocked $chan]} {
        # Hat nicht auf Zeilenende blockiert
        log "$clientName - $line"
        chan puts $chan $line
    }
}

# Server-Socket erzeugen und Ereignisschleife für
# eingehende Verbindungen starten...
socket -server connect 12345
vwait forever
```


[binary]: binary.md
[close]: close.md
[DoOneEvent]: ../tcl-c/DoOneEvent.md
[encoding]: encoding.md
[exec]: exec.md
[fileevent]: fileevent.md
[interp]: interp.md
[open]: open.md
[refchan]: refchan.md
[socket]: socket.md
[string]: string.md
[transchan]: transchan.md
[update]: update.md
[vwait]: vwait.md
