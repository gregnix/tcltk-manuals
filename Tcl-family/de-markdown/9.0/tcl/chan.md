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

[chan]{.cmd} [blocked]{.sub} [channel]{.arg}
: Prüft, ob die letzte Eingabeoperation auf dem Kanal *channel* fehlgeschlagen ist, weil sie den Prozess sonst hätte blockieren lassen, und gibt 1 zurück, wenn das der Fall war. Andernfalls gibt sie 0 zurück. Beachten Sie, dass hier nur dann 1 zurückgegeben wird, wenn der Kanal für den nicht blockierenden Modus konfiguriert ist; alle Tcl-Kanäle haben standardmäßig Blockierung eingeschaltet.

[chan]{.cmd} [close]{.sub} [channel]{.arg} [direction]{.optarg}
: Schließt und zerstört den Kanal *channel*. Beachten Sie, dass dabei alle auf dem Kanal registrierten Datei-Ereignisse gelöscht werden. Ist das Argument *direction* (das **read** oder **write** oder eine eindeutige Abkürzung davon sein muss) angegeben, wird der Kanal nur halb geschlossen, sodass er von Lese-Schreib- auf nur-Schreib- bzw. nur-Lese-Modus wechseln kann. Wird ein nur-Lese-Kanal zum Lesen geschlossen, entspricht das einem vollständigen Schließen des Kanals; analog für nur-Schreib-Kanäle. Ohne das Argument *direction* wird der Kanal sowohl zum Lesen als auch zum Schreiben geschlossen (aber nur, wenn diese Richtungen derzeit geöffnet sind). Es ist ein Fehler, einen nur-Lese-Kanal zum Schreiben oder einen nur-Schreib-Kanal zum Lesen zu schließen.

    Beim Schließen des Kanals wird die gesamte gepufferte Ausgabe auf das Ausgabegerät des Kanals geschrieben (nur wenn der Kanal nicht mehr beschreibbar wird), gepufferte Eingabe verworfen (nur wenn der Kanal nicht mehr lesbar wird), die zugrunde liegende Betriebssystemressource geschlossen und *channel* für künftige Verwendung ungültig (jeweils nur wenn der Kanal vollständig geschlossen wird).

    Ist der Kanal blockierend und wird er nicht mehr beschreibbar, kehrt der Befehl erst zurück, wenn die gesamte Ausgabe geleert wurde. Ist der Kanal nicht blockierend und gibt es noch nicht geleerte Ausgabe, bleibt der Kanal geöffnet und der Befehl kehrt sofort zurück; die Ausgabe wird im Hintergrund geleert und der Kanal wird geschlossen, wenn das Leeren abgeschlossen ist.

    Ist *channel* ein blockierender Kanal einer Befehlspipeline, wartet **chan close**, bis die Kindprozesse beendet sind.

    Wird der Kanal zwischen Interpretern geteilt, macht **chan close** *channel* im aufrufenden Interpreter unverfügbar, hat aber keine weiteren Auswirkungen, bis alle teilenden Interpreter den Kanal geschlossen haben. Wenn der letzte Interpreter, in dem der Kanal registriert ist, **chan close** (oder [close]) aufruft, erfolgen die oben beschriebenen Aufräumarbeiten. Beim Halbschließen gilt das Halbschließen des Kanals nur für die Sicht des aktuellen Interpreters, bis alle Interpreter ihn in dieser Richtung (oder vollständig) geschlossen haben. Siehe den Befehl [interp] für eine Beschreibung der Kanalfreigabe.

    Kanäle werden automatisch vollständig geschlossen, wenn ein Interpreter zerstört wird und wenn der Prozess beendet wird. Kanäle werden in den blockierenden Modus geschaltet, um sicherzustellen, dass die gesamte Ausgabe vor Prozessende korrekt geleert wird.

    Der Befehl gibt eine leere Zeichenkette zurück und kann einen Fehler erzeugen, wenn beim Leeren der Ausgabe ein Fehler auftritt. Gibt ein Befehl in einer mit [open] erzeugten Befehlspipeline einen Fehler zurück, erzeugt **chan close** einen Fehler (ähnlich dem Befehl [exec]).

    Beachten Sie, dass Halbschließen von Sockets und Befehlspipelines wichtige Nebenwirkungen haben kann, weil dabei **shutdown()** oder **close()** der zugrunde liegenden Systemressource ausgelöst wird, was das Verhalten anderer Prozesse oder Systeme gegenüber dem Tcl-Programm ändern kann.

    Kanäle werden automatisch geschlossen, wenn ein Interpreter zerstört wird und wenn der Prozess beendet wird. Nicht blockierende Kanäle werden beim Beenden nicht in den blockierenden Modus geschaltet; das garantiert ein zeitnahes Beenden auch dann, wenn der Peer oder ein Kommunikationskanal hängt. Um das ordnungsgemäße Leeren hängender nicht blockierender Kanäle beim Beenden sicherzustellen, muss man sie entweder (a) aktiv wieder in den blockierenden Modus schalten oder (b) die Umgebungsvariable **TCL\_FLUSH\_NONBLOCKING\_ON\_EXIT** verwenden.

[chan]{.cmd} [configure]{.sub} [channel]{.arg} [optionName]{.optarg} [value]{.optarg} [optionName value]{.optdot}
: Abfragen oder Setzen der Konfigurationsoptionen des Kanals *channel*.

    Werden keine Argumente *optionName* oder *value* angegeben, gibt der Befehl eine Liste mit abwechselnden Optionsnamen und Werten für den Kanal zurück. Ist *optionName* angegeben, aber kein *value*, gibt der Befehl den aktuellen Wert der angegebenen Option zurück. Werden ein oder mehrere Paare *optionName* und *value* angegeben, setzt der Befehl jede benannte Option auf den entsprechenden *value*; in diesem Fall ist der Rückgabewert eine leere Zeichenkette.

    Die unten beschriebenen Optionen werden für alle Kanäle unterstützt. Zusätzlich kann jeder Kanaltyp eigene Optionen hinzufügen. Siehe den Manpage-Eintrag des Befehls, der den jeweiligen Kanaltyp erzeugt, für die von diesem Typ unterstützten Optionen. Beispielsweise enthält der Manpage-Eintrag zum Befehl [socket] zusätzliche Optionen für Sockets und der Befehl [open] zusätzliche Optionen für serielle Geräte.

[-blocking]{.lit} [boolean]{.arg}
: Die Option **-blocking** legt fest, ob E/A-Operationen auf dem Kanal den Prozess unbegrenzt blockieren können. Der Wert der Option muss ein gültiger boolescher Wert sein. Kanäle sind normalerweise im blockierenden Modus; wird ein Kanal in den nicht blockierenden Modus versetzt, beeinflusst das die Operationen der Befehle **chan gets**, **chan read**, **chan puts**, **chan flush** und **chan close**; Einzelheiten finden sich in deren Dokumentation. Damit der nicht blockierende Modus korrekt funktioniert, muss die Anwendung die Tcl-Ereignisschleife verwenden (z. B. durch Aufruf von [Tcl\_DoOneEvent][DoOneEvent] oder den Befehl [vwait]).

[-buffering]{.lit} [newValue]{.arg}
: Ist *newValue* **full**, puffert das E/A-System die Ausgabe, bis der interne Puffer voll ist oder der Befehl **chan flush** aufgerufen wird. Ist *newValue* **line**, leert das E/A-System die Ausgabe für den Kanal automatisch, sobald ein Zeilenumbruch ausgegeben wird. Ist *newValue* **none**, leert das E/A-System nach jeder Ausgabeoperation automatisch. Standardmäßig ist **-buffering** auf **full** gesetzt, außer bei Kanälen, die mit terminalähnlichen Geräten verbunden sind; für diese Kanäle ist die Anfangseinstellung **line**. Zusätzlich sind **stdin** und **stdout** anfänglich auf **line** gesetzt, **stderr** auf **none**.

[-buffersize]{.lit} [newSize]{.arg}
: *newSize* muss eine Ganzzahl sein; ihr Wert wird verwendet, um die Größe der für diesen Kanal anschließend zugewiesenen Ein- oder Ausgabepuffer in Bytes festzulegen. *newSize* darf höchstens eine Million sein, sodass Puffer bis zu einer Million Bytes groß sein können.

[-encoding]{.lit} [name]{.arg}
: Diese Option legt die Kodierung des Kanals als eine der von [encoding names][encoding] zurückgegebenen benannten Kodierungen fest, damit die Daten für die Verwendung in Tcl nach Unicode konvertiert werden können. Damit Tcl beispielsweise Zeichen aus einer japanischen Datei in **shiftjis** liest und den Inhalt korrekt verarbeitet und anzeigt, würde die Kodierung auf **shiftjis** gesetzt. Beim Lesen vom Kanal werden die Bytes in der japanischen Datei beim Lesen nach Unicode konvertiert. Schreiben wird ebenfalls unterstützt — Tcl-Zeichenketten werden beim Schreiben auf den Kanal automatisch in die angegebene Kodierung konvertiert.

    Enthält eine Datei reine Binärdaten (z. B. ein JPEG-Bild), sollte die Kodierung des Kanals auf **iso8859-1** gesetzt werden. Tcl weist den Daten in der Datei dann keine Interpretation zu und liest oder schreibt einfach rohe Bytes. Der Tcl-Befehl [binary] kann zur Bearbeitung dieser byteorientierten Daten verwendet werden. In der Regel ist es besser, die Option **-translation** auf [binary] zu setzen, wenn Binärdaten übertragen werden sollen, da damit auch die anderen automatischen Interpretationen der Bytes im Strom abgeschaltet werden.

    Die Standardkodierung für neu geöffnete Kanäle ist dieselbe plattform- und localeabhängige Systemkodierung, die für die Schnittstelle zum Betriebssystem verwendet wird, wie von [encoding system][encoding] zurückgegeben.

[-eofchar]{.lit} [char]{.arg}
: Diese Option unterstützt DOS-Dateisysteme, die Control-z (\\x1A) als Dateiende-Markierung verwenden. Ist *char* keine leere Zeichenkette, signalisiert dieses Zeichen beim Lesen das Dateiende. Andernfalls (Standard) gibt es keine spezielle Dateiende-Zeichenmarkierung. Der zulässige Bereich für **-eofchar**-Werte ist \\x01 - \\x7f; der Versuch, **-eofchar** auf einen Wert außerhalb dieses Bereichs zu setzen, erzeugt einen Fehler.

[-profile]{.lit} [profile]{.arg}
: [Legt das für den Kanal zu verwendende Kodierungsprofil fest. Die für Ein- und Ausgabe des Kanals verwendeten Kodierungstransformationen unterliegen dann den Regeln dieses Profils. Fehler führen zu einem Kanalfehler. Siehe **PROFILE** in der Dokumentation zu **encoding(n)** für Einzelheiten zu Kodierungsprofilen.]{version="TIP656"}

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
: Liest Zeichen von *inputChan* und schreibt sie nach *outputChan*, bis alle Zeichen kopiert sind, blockiert bis der Kopiervorgang abgeschlossen ist und gibt die Anzahl der kopierten Zeichen zurück. Nutzt interne Puffer, um zusätzliche Kopien zu vermeiden und zu verhindern, dass beim Kopieren großer Dateien auf langsame Ziele wie Netzwerk-Sockets zu viele Daten im Hauptspeicher gepuffert werden.

    **-size** begrenzt die Anzahl der zu kopierenden Zeichen.

    Ist **-command** angegeben, kehrt **chan copy** sofort zurück, arbeitet im Hintergrund und ruft *callback* nach Abschluss des Kopiervorgangs auf, wobei als zusätzliches Argument die Anzahl der nach *outputChan* geschriebenen Zeichen übergeben wird. Tritt während des Hintergrundkopierens ein Fehler auf, liefert ein weiteres Argument die Fehlermeldung. *inputChan* und *outputChan* werden bei Bedarf automatisch für den nicht blockierenden Modus konfiguriert. Hintergrundkopieren funktioniert nur korrekt, wenn Ereignisse verarbeitet werden, z. B. über [vwait] oder Tk.

    Während eines Hintergrundkopierens darf auf *inputChan* keine andere Leseoperation und auf *outputChan* keine Schreiboperation ausgeführt werden. Schreiboperationen auf *inputChan* und Leseoperationen auf *outputChan* sind jedoch möglich, wie im bidirektionalen Kopierbeispiel unten gezeigt.

    Wird entweder *inputChan* oder *outputChan* während des Kopiervorgangs geschlossen, bricht das Kopieren ab und es wird **kein** Callback aufgerufen. Wird *inputChan* geschlossen, wird die gesamte bereits in der Warteschlange befindliche Ausgabe nach *outputChan* geschrieben.

    Für *inputChan* sollte kein Ereignishandler eingerichtet sein, da er während eines Hintergrundkopierens lesbar werden kann. Ein Lese- oder Schreibversuch aus einem Ereignishandler führt zum Fehler „channel busy“. Jede falsch gerichtete E/A (durch einen **chan event**-Handler oder anderweitig) führt zu einem Fehler „channel busy“.

[chan]{.cmd} [create]{.sub} [mode]{.arg} [cmdPrefix]{.arg}
: Dieser Unterbefehl erzeugt einen neuen Kanal auf Skriptebene, der das Befehlspräfix *cmdPrefix* als Handler verwendet. Ein solcher Kanal heißt **reflektierter** Kanal. Das angegebene Befehlspräfix **cmdPrefix** muss eine nicht leere Liste sein und sollte die in der Manpage [refchan] beschriebene API bereitstellen. Der Bezeichner des neuen Kanals wird als Ergebnis des Befehls **chan create** zurückgegeben, und der Kanal ist geöffnet. Verwenden Sie [close] oder **chan close**, um den Kanal zu entfernen.

    Das Argument *mode* gibt an, ob der neue Kanal zum Lesen, Schreiben oder beidem geöffnet ist. Es muss eine Liste sein, die beliebige der Zeichenketten „**read**“ oder „**write**“ enthält. Die Liste muss mindestens ein Element haben, da ein Kanal, auf den man weder schreiben noch lesen kann, keinen Sinn ergibt. Der Handler-Befehl für den neuen Kanal muss den gewählten Modus unterstützen, sonst wird ein Fehler ausgelöst.

    Das Befehlspräfix wird im globalen Namespace am oberen Ende des Aufrufstapels ausgeführt, nach Anhängen der Argumente wie in der Manpage [refchan] beschrieben. Die Befehlsauflösung erfolgt zum Zeitpunkt des Aufrufs. Das Umbenennen oder Zerstören des Befehls bedeutet, dass der nächste Aufruf einer Handler-Methode fehlschlagen kann und damit auch der den Handler aufrufende Kanalbefehl; je nach aufgerufenem Unterbefehl kann die Fehlermeldung den Grund dafür nicht erklären.

    Jeder mit diesem Unterbefehl erzeugte Kanal kennt den Interpreter, in dem er erzeugt wurde, und führt seinen Handler-Befehl nur in diesem Interpreter aus, auch wenn der Kanal geteilt und/oder in einen anderen Interpreter verschoben wurde. Jeder reflektierte Kanal kennt auch den Thread, in dem er erzeugt wurde, und führt seinen Handler-Befehl nur in diesem Thread aus, auch wenn der Kanal in einen anderen Thread verschoben wurde. Zu diesem Zweck werden alle Handler-Aufrufe durch Posten spezieller Ereignisse an den ursprünglichen Thread weitergeleitet. Das bedeutet, dass der ursprüngliche Thread (d. h. der Thread, der **chan create** ausgeführt hat) eine aktive Ereignisschleife haben muss, d. h. er muss solche Ereignisse verarbeiten können. Andernfalls blockiert der sendende Thread *unbegrenzt*. Es kann zu einer Deadlock-Situation kommen.

    Beachten Sie, dass damit ein Kanal erzeugt werden kann, dessen beiden Endpunkte in zwei verschiedenen Threads leben und eine streamorientierte Brücke zwischen diesen Threads bildet. Mit anderen Worten: reguläre Stream-Kommunikation zwischen Threads statt Befehle senden zu müssen.

    Wird ein Thread oder Interpreter gelöscht, werden alle mit diesem Unterbefehl erzeugten Kanäle, die diesen Thread/Interpreter als Rechenbasis verwenden, ebenfalls in allen Interpretern gelöscht, mit denen sie geteilt oder in die sie verschoben wurden, und in jedem Thread, in den sie übertragen wurden. Obwohl das den anderen Thread(s) und/oder Interpreter(n) den Boden entzieht, lässt sich das nicht vermeiden. Der Versuch, einen solchen Kanal zu verwenden, führt zu einem regulären Fehler über unbekannte Kanalbezeichner.

    Dieser Unterbefehl ist **safe** und für sichere Interpreter zugänglich. Obwohl er die Ausführung beliebigen Tcl-Codes veranlasst, stellt das System sicher, dass der Code immer innerhalb des sicheren Interpreters ausgeführt wird.

[chan]{.cmd} [eof]{.sub} [channel]{.arg}
: Prüft, ob die letzte Eingabeoperation auf dem Kanal *channel* fehlgeschlagen ist, weil das Ende des Datenstroms erreicht wurde; gibt 1 zurück, wenn Dateiende erreicht wurde, und 0 andernfalls.

[chan]{.cmd} [event]{.sub} [channel]{.arg} [event]{.arg} [script]{.optarg}
: Richtet ein, dass das Tcl-Skript *script* als *Datei-Ereignishandler* installiert wird, der aufgerufen wird, sobald der Kanal *channel* in den von *event* beschriebenen Zustand wechselt (*event* muss **readable** oder **writable** sein); pro Ereignis und Kanal kann jeweils nur ein solcher Handler installiert sein. Ist *script* die leere Zeichenkette, wird der aktuelle Handler gelöscht (das geschieht auch beim Schließen des Kanals oder Löschen des Interpreters). Wird *script* weggelassen, wird das aktuell installierte Skript zurückgegeben (oder eine leere Zeichenkette, wenn kein solcher Handler installiert ist). Der Callback wird nur ausgeführt, wenn die Ereignisschleife bedient wird (z. B. über [vwait] oder [update]).

    Ein Datei-Ereignishandler ist eine Bindung zwischen einem Kanal und einem Skript, sodass das Skript ausgewertet wird, sobald der Kanal lesbar oder beschreibbar wird. Datei-Ereignishandler werden am häufigsten verwendet, um Daten ereignisgesteuert von einem anderen Prozess zu empfangen, sodass der Empfänger weiter mit dem Benutzer oder anderen Kanälen interagieren kann, während auf die Daten gewartet wird. Ruft eine Anwendung **chan gets** oder **chan read** auf einem blockierenden Kanal auf, wenn keine Eingabedaten verfügbar sind, blockiert der Prozess; bis die Eingabedaten eintreffen, kann er keine anderen Ereignisse bedienen, sodass er für den Benutzer „einfriert“ wirkt. Mit **chan event** kann der Prozess erkennen, wann Daten vorhanden sind, und **chan gets** oder **chan read** nur aufrufen, wenn sie nicht blockieren.

    Ein Kanal gilt als lesbar, wenn auf dem zugrunde liegenden Gerät ungelesene Daten verfügbar sind. Ein Kanal gilt auch als lesbar, wenn ungelesene Daten in einem Eingabepuffer liegen, außer im Sonderfall, dass der letzte Leseversuch vom Kanal ein **chan gets**-Aufruf war, der keine vollständige Zeile im Eingabepuffer finden konnte. Diese Eigenschaft ermöglicht das zeilenweise Lesen einer Datei im nicht blockierenden Modus mit Ereignissen. Ein Kanal gilt auch als lesbar, wenn auf der zugrunde liegenden Datei oder dem Gerät ein Dateiende- oder Fehlerzustand vorliegt. Es ist wichtig, dass *script* diese Zustände prüft und angemessen behandelt; fehlt eine spezielle Prüfung auf Dateiende, kann eine Endlosschleife entstehen, in der *script* keine Daten liest, zurückkehrt und sofort erneut aufgerufen wird.

    Ein Kanal gilt als beschreibbar, wenn mindestens ein Byte auf die zugrunde liegende Datei oder das Gerät ohne Blockieren geschrieben werden kann oder ein Fehlerzustand auf der zugrunde liegenden Datei oder dem Gerät vorliegt. Beachten Sie, dass Client-Sockets im asynchronen Modus beschreibbar werden, wenn die Verbindung hergestellt ist oder die Verbindung fehlschlägt.

    Ereignisgesteuerte E/A funktioniert am besten für Kanäle, die mit **chan configure** in den nicht blockierenden Modus versetzt wurden. Im blockierenden Modus kann **chan puts** blockieren, wenn mehr Daten übergeben werden, als die zugrunde liegende Datei oder das Gerät aufnehmen kann, und **chan gets** oder **chan read** blockieren, wenn mehr Daten gelesen werden sollen als bereitstehen; während die Befehle blockieren, werden keine Ereignisse verarbeitet. Im nicht blockierenden Modus blockieren **chan puts**, **chan read** und **chan gets** nie.

    Das Skript für ein Datei-Ereignis wird auf globaler Ebene (außerhalb des Kontexts einer Tcl-Prozedur) in dem Interpreter ausgeführt, in dem **chan event** aufgerufen wurde. Tritt beim Ausführen des Skripts ein Fehler auf, wird der mit [interp bgerror][interp] registrierte Befehl zur Fehlermeldung verwendet. Zusätzlich wird der Datei-Ereignishandler gelöscht, wenn er jemals einen Fehler zurückgibt; das verhindert Endlosschleifen durch fehlerhafte Handler.

[chan]{.cmd} [flush]{.sub} [channel]{.arg}
: Stellt sicher, dass die gesamte ausstehende Ausgabe für den Kanal *channel* geschrieben wird.

    Ist der Kanal im blockierenden Modus, kehrt der Befehl erst zurück, wenn die gesamte gepufferte Ausgabe an den Kanal geleert wurde. Ist der Kanal im nicht blockierenden Modus, kann der Befehl zurückkehren, bevor die gesamte gepufferte Ausgabe geleert wurde; der Rest wird im Hintergrund so schnell geleert, wie die zugrunde liegende Datei oder das Gerät Daten aufnehmen kann.

[chan]{.cmd} [gets]{.sub} [channel]{.arg} [varName]{.optarg}
: Liest eine Zeile vom Kanal, bestehend aus allen Zeichen bis zur nächsten Zeilenende-Sequenz oder bis Dateiende erreicht ist. Das zur Zeilenende-Sequenz gehörende Zeilenvorschub-Zeichen ist nicht Teil der Zeile. Ist das Argument *varName* angegeben, wird die Zeile in der Variable dieses Namens gespeichert und der Befehl gibt die Länge der Zeile zurück. Ist *varName* nicht angegeben, gibt der Befehl die Zeile selbst als Ergebnis zurück.

    Ist keine vollständige Zeile verfügbar und der Kanal nicht am Dateiende, blockiert der Befehl bei einem blockierenden Kanal. Bei nicht blockierenden Kanälen gibt der Befehl bei nicht angegebenem *varName* die leere Zeichenkette zurück und -1, wenn *varName* angegeben ist.

    Ist ein blockierender Kanal bereits am Dateiende, gibt der Befehl bei nicht angegebenem *varName* eine leere Zeichenkette zurück. Beachten Sie, dass eine leere Zeichenkette auch zurückgegeben werden kann, wenn eine Leerzeile gelesen wurde (keine Zeichen vor der nächsten Zeilenende-Sequenz). Die beiden Fälle lassen sich durch Aufruf von **chan eof** zur Prüfung auf Dateiende unterscheiden. Ist *varName* angegeben, gibt der Befehl bei Dateiende -1 zurück. In diesem Fall gibt es keine Mehrdeutigkeit, da Leerzeilen 0 zurückgeben.

    Ist ein nicht blockierender Kanal bereits am Dateiende, gibt der Befehl bei nicht angegebenem *varName* eine leere Zeile zurück. Das lässt sich von einer leeren Zeile als Rückgabewert unterscheiden, die entweder durch eine Leerzeile oder durch eine nicht verfügbare vollständige Zeile verursacht wurde, mittels **chan eof** und **chan blocked**. Gibt **chan eof** wahr zurück, ist der Kanal am Dateiende. Gibt **chan blocked** wahr zurück, war keine vollständige Zeile verfügbar. Geben beide falsch zurück, wurde eine Leerzeile gelesen. War *varName* für einen nicht blockierenden Kanal am Dateiende angegeben, gibt der Befehl -1 zurück. Das lässt sich von einer nicht verfügbaren vollständigen Zeile wie oben durch **chan eof** oder **chan blocked** unterscheiden. Beachten Sie, dass bei angegebenem *varName* keine Unterscheidung zwischen Dateiende und Leerzeilen nötig ist, da Letztere 0 zurückgeben.

    Ist das Kodierungsprofil **strict** für den Kanal aktiv, löst der Befehl eine Ausnahme mit dem POSIX-Fehlercode **EILSEQ** aus, wenn in den Kanaleingabedaten Kodierungsfehler auftreten. Der Dateizeiger bleibt unverändert, und es ist möglich, durch Änderung der verwendeten Kodierung zu untersuchen und in manchen Fällen wiederherzustellen. Siehe [Beispiele für Kodierungsfehler] weiter unten.

[chan]{.cmd} [isbinary]{.sub} [channel]{.arg}
: Prüft, ob der Kanal *channel* ein Binärkanal ist; gibt 1 zurück, wenn ja, und 0 andernfalls. Ein Binärkanal ist ein Kanal mit iso8859-1-Kodierung, **-eofchar** auf {} und **-translation** auf lf.

[chan]{.cmd} [names]{.sub} [pattern]{.optarg}
: Erzeugt eine Liste aller Kanalnamen. Ist *pattern* angegeben, werden nur die Kanalnamen zurückgegeben, die ihm entsprechen (gemäß den Regeln von [string match][string]).

[chan]{.cmd} [pending]{.sub} [mode]{.arg} [channel]{.arg}
: Gibt je nachdem, ob *mode* **input** oder **output** ist, die Anzahl der Bytes der Eingabe bzw. Ausgabe zurück, die derzeit intern für *channel* gepuffert sind (besonders nützlich in einem lesbaren Ereignis-Callback, um anwendungsspezifische Grenzen für Eingabezeilenlängen zu setzen und einen potenziellen Denial-of-Service-Angriff zu vermeiden, bei dem ein feindlicher Benutzer eine extrem lange Zeile erzeugt, die den verfügbaren Speicher für den Puffer übersteigt). Gibt -1 zurück, wenn der Kanal nicht für den betreffenden Modus geöffnet wurde.

[chan]{.cmd} [pipe]{.sub}
: Erzeugt eine eigenständige Pipe, deren Lese- und Schreibseiten-Kanäle als 2-Element-Liste zurückgegeben werden; das erste Element ist die Leseseite, das zweite die Schreibseite. Kann z. B. nützlich sein, um **stderr** und **stdout** eines Unterprozesses getrennt umzuleiten. Dazu den Unterprozess mit den Umleitungsoperatoren „2>@“ oder „>@“ auf die Schreibseite einer Pipe starten und sie im Elternprozess sofort schließen. Das ist nötig, um auf der Leseseite ein EOF zu erhalten, sobald der Kindprozess beendet ist oder seine Ausgabe sonst geschlossen hat.

    Beachten Sie, dass die Puffersemantik auf Betriebssystemebene erheblich variieren kann; man darf nicht annehmen, dass ein Schreibvorgang auf der Ausgabeseite der Pipe sofort auf der Eingabeseite erscheint. Das ist ein grundlegender Unterschied, den Tcl nicht verbergen kann. Die Gesamt-Stream-Semantik *ist* kompatibel, sodass blockierende Lese- und Schreibvorgänge die meisten Unterschiede nicht sehen, aber die Details, was genau wann geschrieben wird, sind es nicht. Das zeigt sich am ehesten bei Pipelines zum Testen; es ist Vorsicht geboten, Deadlocks zu vermeiden und kurze Leseoperationen zuzulassen.

[chan]{.cmd} [pop]{.sub} [channel]{.arg}
: Entfernt die oberste Transformation vom Kanal *channel*, falls vorhanden. Sind dem Kanal *channel* keine Transformationen hinzugefügt, entspricht das **chan close** dieses Kanals. Das Ergebnis ist normalerweise die leere Zeichenkette, kann in manchen Situationen jedoch ein Fehler sein (z. B. wenn der zugrunde liegende Systemstrom geschlossen wird und das einen Fehler verursacht).

[chan]{.cmd} [postevent]{.sub} [channel]{.arg} [eventSpec]{.arg}
: Dieser Unterbefehl wird von mit **chan create** angegebenen Befehlshandlern verwendet. Er meldet dem durch den Bezeichner *channel* dargestellten Kanal, dass die in *eventSpec* aufgeführten Ereignisse eingetreten sind. Das Argument muss eine Liste sein, die beliebige der Zeichenketten **read** und **write** enthält. Die Liste muss mindestens ein Element enthalten, da der Aufruf ohne zu meldende Ereignisse keinen Sinn ergibt.

    Beachten Sie, dass dieser Unterbefehl nur mit Kanalbezeichnern verwendet werden kann, die mit **chan create** erzeugt/geöffnet wurden. Alle anderen Kanäle führen zu einem Fehler dieses Unterbefehls.

    Da nur die Tcl-Ebene eines Kanals, d. h. sein Befehlshandler, Ereignisse an ihn melden sollte, ist die Verwendung auf den Interpreter beschränkt, der den Kanal erzeugt hat. Ereignisse an einen reflektierten Kanal aus einem Interpreter ohne dessen Implementierung zu melden, ist nicht erlaubt. Der Versuch, ein Ereignis aus einem anderen Interpreter zu melden, führt zu einem Fehler dieses Unterbefehls.

    Eine weitere Einschränkung: Es ist nicht möglich, Ereignisse zu melden, für die der E/A-Kern kein Interesse registriert hat. Der Versuch führt zu einer Ausnahme der Methode. Siehe die Handler-Methode **watch** in **refchan**, dem Dokument zur API von Befehlshandlern für reflektierte Kanäle.

    Dieser Befehl ist **safe** und für sichere Interpreter zugänglich. Er kann die Ausführung von **chan event**-Handlern auslösen, ob im aktuellen Interpreter oder in anderen Interpretern oder Threads, auch wenn das Ereignis aus einem sicheren Interpreter gemeldet und von einem vertrauenswürdigen Interpreter abgehört wird. **Chan event**-Handler werden *immer* in dem Interpreter ausgeführt, der sie eingerichtet hat.

[chan]{.cmd} [push]{.sub} [channel]{.arg} [cmdPrefix]{.arg}
: Fügt dem Kanal *channel* eine neue Transformation hinzu. Das Argument *cmdPrefix* beschreibt eine Liste aus einem oder mehreren Wörtern, die einen Handler darstellen, der die Transformation implementiert. Das Befehlspräfix muss die in der Manpage [transchan] beschriebene API bereitstellen. Das Ergebnis dieses Unterbefehls ist ein Bezeichner für die Transformation. Es ist wichtig sicherzustellen, dass die Transformation den Kanalmodus unterstützt, mit dem sie verwendet wird, sonst kann der Kanal weder lesbar noch beschreibbar werden.

[chan]{.cmd} [puts]{.sub} [-nonewline]{.optlit} [channel]{.optarg} [string]{.arg}
: Schreibt *string* auf den Kanal *channel* gefolgt von einem Newline-Zeichen. Ein abschließendes Newline wird geschrieben, sofern die optionale Flagge **-nonewline** nicht angegeben ist. Wird *channel* weggelassen, wird die Zeichenkette auf den Standardausgabekanal **stdout** geschrieben.

    Newline-Zeichen in der Ausgabe werden von **chan puts** gemäß der aktuell konfigurierten Option **-translation** des Kanals in plattformspezifische Zeilenende-Sequenzen übersetzt (auf PCs werden Newlines normalerweise durch Wagenrücklauf-Zeilenvorschub-Sequenzen ersetzt; siehe **chan configure** oben für Einzelheiten).

    Tcl puffert Ausgabe intern, sodass mit **chan puts** geschriebene Zeichen möglicherweise nicht sofort auf der Ausgabedatei oder dem Gerät erscheinen; Tcl verzögert die Ausgabe normalerweise, bis der Puffer voll ist oder der Kanal geschlossen wird. Mit **chan flush** kann die Ausgabe sofort erzwungen werden.

    Wenn der Ausgabepuffer voll ist, blockiert **chan puts** normalerweise, bis das Betriebssystem alle gepufferten Daten zur Ausgabe angenommen hat. Ist *channel* im nicht blockierenden Modus, blockiert **chan puts** nicht, auch wenn das Betriebssystem die Daten nicht annehmen kann. Stattdessen puffert Tcl weiter und schreibt im Hintergrund so schnell, wie die zugrunde liegende Datei oder das Gerät Daten aufnehmen kann. Die Anwendung muss die Tcl-Ereignisschleife verwenden, damit nicht blockierende Ausgabe funktioniert; sonst erfährt Tcl nie, dass die Datei oder das Gerät bereit für weitere Ausgabedaten ist. Für einen Kanal im nicht blockierenden Modus kann beliebig viel Daten gepuffert werden, was viel Speicher verbrauchen kann. Um Speicherverschwendung zu vermeiden, sollte nicht blockierende E/A normalerweise ereignisgesteuert mit **chan event** verwendet werden (rufen Sie **chan puts** nicht auf, es sei denn, Sie wurden kürzlich per Datei-Ereignis benachrichtigt, dass der Kanal bereit für weitere Ausgabedaten ist).

    Der Befehl löst eine Fehlerausnahme mit dem POSIX-Fehlercode **EILSEQ** aus, wenn das Kodierungsprofil **strict** für den Kanal aktiv ist und die Ausgabedaten nicht in der für den Kanal konfigurierten Kodierung kodiert werden können. In diesem Fall können Daten teilweise in den Kanal geschrieben worden sein.

[chan]{.cmd} [read]{.sub} [channel]{.arg} [numChars]{.optarg}
: ...siehe nächstes...

[chan]{.cmd} [read]{.sub} [-nonewline]{.optlit} [channel]{.arg}
: In der ersten Form besteht das Ergebnis aus den nächsten *numChars* Zeichen, die vom Kanal *channel* gelesen werden; wird *numChars* weggelassen, werden alle Zeichen bis zu dem Punkt gelesen, an dem der Kanal einen Fehler signalisieren würde (ob Dateiende, Blockierung oder anderer Fehlerzustand). In der zweiten Form (d. h. wenn *numChars* weggelassen wurde) kann die Flagge **-nonewline** angegeben werden, um anzuzeigen, dass ein abschließendes Newline in der gelesenen Zeichenkette entfernt werden soll.

    Ist *channel* im nicht blockierenden Modus, liest **chan read** möglicherweise nicht so viele Zeichen wie angefordert: sobald alle verfügbare Eingabe gelesen ist, gibt der Befehl die verfügbaren Daten zurück, statt auf weitere Eingabe zu blockieren. Ist der Kanal für eine Mehrbyte-Kodierung konfiguriert, können im internen Puffer Bytes verbleiben, die kein vollständiges Zeichen bilden. Diese Bytes werden erst zurückgegeben, wenn ein vollständiges Zeichen verfügbar ist oder Dateiende erreicht ist. Der Schalter **-nonewline** wird ignoriert, wenn der Befehl zurückkehrt, bevor das Dateiende erreicht wird.

    **Chan read** übersetzt Zeilenende-Sequenzen in der Eingabe gemäß der Option **-translation** des Kanals in Newline-Zeichen (siehe **chan configure** oben für eine Diskussion, wie **chan configure** die Eingabe verändert).

    Beim Lesen von einem seriellen Port sollten die meisten Anwendungen den seriellen Port-Kanal auf nicht blockierend setzen, etwa so:

    ```
    chan configure channel -blocking 0.
    ```

    Dann verhält sich **chan read** wie oben beschrieben. Beachten Sie, dass die meisten seriellen Ports vergleichsweise langsam sind; es ist durchaus möglich, für jedes vom Port gelesene Zeichen ein **readable**-Ereignis zu erhalten. Vorsicht ist geboten bei **chan read** auf blockierenden seriellen Ports:

    [chan]{.cmd} [read]{.sub} [channel]{.arg} [numChars]{.arg}
    : In dieser Form blockiert **chan read**, bis *numChars* vom seriellen Port empfangen wurden.

    [chan]{.cmd} [read]{.sub} [channel]{.arg}
    : In dieser Form blockiert **chan read**, bis das Dateiende-Zeichen empfangen wurde; siehe **chan configure -eofchar**. Ist für den Kanal kein Dateiende-Zeichen konfiguriert, blockiert **chan read** für immer.


    Ist das Kodierungsprofil **strict** für den Kanal aktiv, löst der Befehl eine Ausnahme mit dem POSIX-Fehlercode **EILSEQ** aus, wenn in den Kanaleingabedaten Kodierungsfehler auftreten. Ist der Kanal im blockierenden Modus, wird der Fehler ausgelöst, nachdem der Dateizeiger auf den Anfang der ungültigen Daten gesetzt wurde. Der erfolgreich dekodierte führende Teil der Daten vor der Fehlerposition wird als Wert des Schlüssels **-data** im Fehleroptions-Wörterbuch zurückgegeben. Ist der Kanal im nicht blockierenden Modus, gibt der Befehl den erfolgreich dekodierten Datenteil ohne Fehlerausnahme zurück. Ein nachfolgendes Lesen beginnt bei den ungültigen Daten und löst sofort eine **EILSEQ**-POSIX-Fehlerausnahme aus. Im Gegensatz zum blockierenden Kanal ist der Schlüssel **-data** im Fehleroptions-Wörterbuch nicht vorhanden. Bei einer Ausnahme wegen Kodierungsfehlern ist Untersuchung und in manchen Fällen Wiederherstellung durch Änderung der verwendeten Kodierung möglich. Siehe [Beispiele für Kodierungsfehler] weiter unten.

[chan]{.cmd} [seek]{.sub} [channel]{.arg} [offset]{.arg} [origin]{.optarg}
: Setzt die aktuelle Zugriffsposition im zugrunde liegenden Datenstrom für den Kanal *channel* auf *offset* Bytes relativ zu *origin*. *Offset* muss eine Ganzzahl sein (kann negativ sein) und *origin* muss eines der folgenden sein:

    **start**
    : Die neue Zugriffsposition liegt *offset* Bytes vom Anfang der zugrunde liegenden Datei oder des Geräts entfernt.

    **current**
    : Die neue Zugriffsposition liegt *offset* Bytes von der aktuellen Zugriffsposition entfernt; ein negatives *offset* verschiebt die Zugriffsposition rückwärts in der zugrunde liegenden Datei oder dem Gerät.

    **end**
    : Die neue Zugriffsposition liegt *offset* Bytes vom Ende der Datei oder des Geräts entfernt. Ein negatives *offset* setzt die Zugriffsposition vor das Dateiende, ein positives *offset* danach.


    Das Argument *origin* ist standardmäßig **start**.

    **Chan seek** leert die gesamte gepufferte Ausgabe für den Kanal, bevor der Befehl zurückkehrt, auch wenn der Kanal im nicht blockierenden Modus ist. Er verwirft auch gepufferte und ungelesene Eingabe. Dieser Befehl gibt eine leere Zeichenkette zurück. Ein Fehler tritt auf, wenn der Befehl auf Kanälen angewendet wird, deren zugrunde liegende Datei oder Gerät kein Suchen unterstützt.

    Beachten Sie, dass *offset*-Werte Byte-Offsets sind, keine Zeichen-Offsets. Sowohl **chan seek** als auch **chan tell** arbeiten in Bytes, nicht in Zeichen, im Gegensatz zu **chan read**.

[chan]{.cmd} [tell]{.sub} [channel]{.arg}
: Gibt eine Zahl zurück, die die aktuelle Zugriffsposition im zugrunde liegenden Datenstrom für den Kanal *channel* angibt. Der zurückgegebene Wert ist ein Byte-Offset, der an **chan seek** übergeben werden kann, um den Kanal auf eine bestimmte Position zu setzen. Beachten Sie, dass dieser Wert in Bytes angegeben ist, nicht in Zeichen wie bei **chan read**. Der zurückgegebene Wert ist -1 für Kanäle, die kein Suchen unterstützen.

[chan]{.cmd} [truncate]{.sub} [channel]{.arg} [length]{.optarg}
: Setzt die Bytelänge des zugrunde liegenden Datenstroms für den Kanal *channel* auf *length* (oder auf den aktuellen Byte-Offset im zugrunde liegenden Datenstrom, wenn *length* weggelassen ist). Der Kanal wird vor dem Kürzen geleert.


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

Dieses Beispiel veranschaulicht das Leeren eines Kanals. Der Benutzer wird nach Informationen gefragt. Da der Standardeingabekanal zeilenweise gepuffert ist, muss er geleert werden, damit der Benutzer die Eingabeaufforderung sieht.

```
chan puts -nonewline "Please type your name: "
chan flush stdout
chan gets stdin name
chan puts "Hello there, $name!"
```

Dieses Beispiel liest eine Datei zeilenweise und gibt sie mit der aktuellen Zeilennummer am Zeilenanfang aus.

```
set chan [open "some.file.txt"]
set lineNumber 0
while {[chan gets $chan line] >= 0} {
    chan puts "[incr lineNumber]: $line"
}
chan close $chan
```

In diesem Beispiel für ereignisgesteuertes Lesen wird **GetData** mit dem Kanal als Argument aufgerufen, sobald $chan lesbar wird. Der **read**-Aufruf liest alle derzeit verfügbaren Binärdaten ohne Blockieren. Hier wird das Datei-Ereignis bei Dateiende vom Kanal entfernt, um wiederholte Aufrufe zu vermeiden (siehe oben). Alternativ kann der Kanal unter dieser Bedingung geschlossen werden.

```
proc GetData {chan} {
    set data [chan read $chan]
    chan puts "[string length $data] $data"
    if {[chan eof $chan]} {
        chan event $chan readable {}
    }
}

chan configure $chan -blocking 0 -translation binary
chan event $chan readable [list GetData $chan]
```

Das nächste Beispiel ist ähnlich, verwendet aber **chan gets** zum Lesen zeilenorientierter Daten.

```
proc GetData {chan} {
    if {[chan gets $chan line] >= 0} {
        chan puts $line
    }
    if {[chan eof $chan]} {
        chan close $chan
    }
}

chan configure $chan -blocking 0 -buffering line -translation crlf
chan event $chan readable [list GetData $chan]
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

Das folgende Beispiel liest ein PPM-Bild aus einer Datei mit gemischtem ASCII- und Binärinhalt.

```
# Datei öffnen und in Unix-ASCII-Modus versetzen
set f [open teapot.ppm]
chan configure $f -encoding ascii -translation lf

# Header lesen
if {[chan gets $f] ne "P6"} {
    error "not a raw-bits PPM"
}

# Zeilen lesen, bis Nicht-Kommentarzeilen
# drei Dezimalwerte liefern.
set words {}
while {[llength $words] < 3} {
    chan gets $f line
    if {[string match "#*" $line]} continue
    lappend words {*}[join [scan $line %d%d%d]]
}

# Diese Wörter liefern Bildgröße und
# Gesamttiefe pro Kanal. Variablen zuweisen.
lassign $words xSize ySize depth

# Jetzt in den Binärmodus wechseln, um die Daten
# ein Byte pro Kanal (rot, grün, blau) pro Pixel zu lesen.
chan configure $f -translation binary
set numDataBytes [expr {3 * $xSize * $ySize}]
set data [chan read $f $numDataBytes]

close $f
```

## Beispiele für Datei-Suchoperationen

Eine Datei zweimal lesen:

```
set f [open file.txt]
set data1 [chan read $f]
chan seek $f 0
set data2 [chan read $f]
chan close $f
# $data1 eq $data2, wenn die Datei nicht aktualisiert wurde
```

Die letzten 10 Bytes einer Datei lesen:

```
set f [open file.data]
# Garantiert für Binärdaten, kann bei
# anderen Kodierungen fehlschlagen...
chan configure $f -translation binary
chan seek $f -10 end
set data [chan read $f 10]
chan close $f
```

Eine Zeile von einem Dateikanal nur lesen, wenn sie mit **foobar** beginnt:

```
# Offset speichern für den Fall, dass das Lesen rückgängig gemacht werden muss...
set offset [tell $chan]
if {[read $chan 6] eq "foobar"} {
    gets $chan line
} else {
    set line {}
    # Lesen rückgängig machen...
    seek $chan $offset
}
```

## Beispiele für Kodierungsfehler

Das Beispiel unten zeigt den Umgang mit einem beim Kanaleingang aufgetretenen Kodierungsfehler. Zuerst Erzeugung einer Testdatei mit der ungültigen UTF-8-Sequenz (**A \\xC3 B**):

```
% set f [open test_A_195_B.txt wb]; chan puts -nonewline $f A\xC3B; chan close $f
```

Ein Leseversuch der Datei führt zu einem Kodierungsfehler, der dann durch Umschalten des Kanals in den Binärmodus untersucht wird. Beachten Sie im Beispiel, dass bei der Fehlermeldung der Dateizeiger unverändert bleibt, sodass **chan gets** bei der Wiederherstellung die vollständige Zeile zurückgibt.

```
% set f [open test_A_195_B.txt r]
file384b6a8
% chan configure $f -encoding utf-8
% catch {chan gets $f} e d
1
% set d
-code 1 -level 0
-errorstack {INNER {invokeStk1 gets file384b6a8}}
-errorcode {POSIX EILSEQ {invalid or incomplete multibyte or wide character}}
-errorinfo {...} -errorline 1
% chan tell $f
0
% chan configure $f -translation binary
% chan gets $f
AÃB
```

Das folgende Beispiel ist ähnlich, zeigt aber die Wiederherstellung nach einem blockierenden Lesevorgang. Die erfolgreich dekodierten Daten „A“ werden im Fehleroptions-Wörterbuchschlüssel **-data** zurückgegeben. Der Dateizeiger wird bei der Kodierungsfehlerposition 1 fortgeschrieben. Die Daten an der Fehlerposition werden daher vom nächsten **chan read**-Befehl gelesen.

```
% set f [open test_A_195_B.txt r]
file35a65a0
% chan configure $f -encoding utf-8 -blocking 1
% catch {chan read $f} e d
1
% set d
-data A -code 1 -level 0
-errorstack {INNER {invokeStk1 read file35a65a0}}
-errorcode {POSIX EILSEQ {invalid or incomplete multibyte or wide character}}
-errorinfo {...} -errorline 1
% chan tell $f
1
% chan configure $f -translation binary
% chan read $f
ÃB
% chan close $f
```

Schließlich dasselbe Beispiel, diesmal mit einem nicht blockierenden Kanal.

```
% set f [open test_A_195_B.txt r]
file35a65a0
% chan configure $f -encoding utf-8 -blocking 0
% chan read $f
A
% chan tell $f
1
% catch {chan read $f} e d
1
% set d
-code 1 -level 0
-errorstack {INNER {invokeStk1 read file384b228}}
-errorcode {POSIX EILSEQ {invalid or incomplete multibyte or wide character}}
-errorinfo {...} -errorline 1
```

## Beispiele für Kanalkopie

Das erste Beispiel überträgt den Inhalt eines Kanals exakt auf einen anderen. Beim Kopieren einer Datei auf eine andere ist [file copy][file] besser geeignet, da dabei auch Dateimetadaten (z. B. Zugriffsrechte) kopiert werden, wo möglich.

```
chan configure $in -translation binary
chan configure $out -translation binary
chan copy $in $out
```

Das zweite Beispiel zeigt, wie dem Callback die Anzahl der übertragenen Bytes übergeben wird. Es verwendet auch vwait, um die Anwendung in die Ereignisschleife zu bringen. Dieses vereinfachte Beispiel ließe sich natürlich auch ohne Befehls-Callback durchführen.

```
proc Cleanup {in out bytes {error {}}} {
    global total
    set total $bytes
    chan close $in
    chan close $out
    if {$error ne ""} {
        # Fehler während des Kopiervorgangs
    }
}

set in [open $file1]
set out [socket $server $port]
chan copy $in $out -command [list Cleanup $in $out]
vwait total
```

Das dritte Beispiel kopiert in Stücken und prüft im Befehlsrückruf auf Dateiende.

```
proc CopyMore {in out chunk bytes {error {}}} {
    global total done
    incr total $bytes
    if {($error ne "") || [chan eof $in]} {
        set done $total
        chan close $in
        chan close $out
    } else {
        chan copy $in $out -size $chunk \
            -command [list CopyMore $in $out $chunk]
    }
}

set in [open $file1]
set out [socket $server $port]
set chunk 1024
set total 0
chan copy $in $out -size $chunk \
    -command [list CopyMore $in $out $chunk]
vwait done
```

Das vierte Beispiel startet ein asynchrones, bidirektionales Kopieren zwischen zwei Sockets. Das können auch Pipes von zwei bidirektionalen Pipelines sein (z. B. *\[open "|hal 9000" r+\]*); die Kommunikation bleibt für das Skript im Wesentlichen unsichtbar, da alle vier **chan event**-Plätze belegt sind, obwohl alle Transformationen, die mit **chan push** auf die Kanäle gelegt werden, den Datenverkehr beobachten können.

```
proc Done {dir args} {
    global flows done
    chan puts "$dir is over."
    incr flows -1
    if {$flows <= 0} {
        set done 1
    }
}

set flows 2
chan copy $sok1 $sok2 -command [list Done UP]
chan copy $sok2 $sok1 -command [list Done DOWN]
vwait done
```


[binary]: binary.md
[close]: close.md
[DoOneEvent]: ../tcl-c/DoOneEvent.md
[encoding]: encoding.md
[exec]: exec.md
[file]: file.md
[interp]: interp.md
[open]: open.md
[refchan]: refchan.md
[socket]: socket.md
[string]: string.md
[transchan]: transchan.md
[update]: update.md
[vwait]: vwait.md
