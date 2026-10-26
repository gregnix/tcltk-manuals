---
CommandName: chan
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

# NAME

chan - Lesen, Schreiben und Manipulieren von Kanälen

# ÜBERSICHT

::: {.synopsis} :::
[chan]{.cmd} [option]{.arg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Dieser Befehl bietet mehrere Operationen zum Lesen von, Schreiben auf und sonstigen Manipulieren geöffneter Kanäle (wie sie mit den Befehlen **open** und **socket** erzeugt wurden oder wie die Standardkanäle **stdin**, **stdout** und **stderr**, die den Standard-Eingabe-, Ausgabe- und Fehlerströmen des Prozesses entsprechen). *Option* gibt an, was mit dem Kanal geschehen soll; jede eindeutige Abkürzung von *option* ist zulässig. Gültige Optionen sind:

**chan blocked** *channelId*
: Prüft, ob die letzte Eingabeoperation auf dem Kanal *channelId* fehlgeschlagen ist, weil der Prozess sonst blockiert worden wäre, und gibt in diesem Fall 1 zurück. Andernfalls gibt der Befehl 0 zurück. Beachten Sie, dass 1 nur dann zurückgegeben wird, wenn der Kanal auf nicht-blockierend konfiguriert ist; bei allen Tcl-Kanälen ist Blockieren standardmäßig eingeschaltet.

**chan close** *channelId* ?*direction*?
: Schließt und zerstört den Kanal *channelId*. Dabei werden alle auf dem Kanal registrierten Datei-Ereignisse gelöscht. Ist das Argument *direction* angegeben (es muss **read** oder **write** oder eine eindeutige Abkürzung davon sein), wird der Kanal nur halb geschlossen, sodass er von Lese-Schreib- auf nur-Schreib- bzw. nur-Lese-Modus wechseln kann. Wird ein nur-Lese-Kanal zum Lesen geschlossen, entspricht das einem vollständigen Schließen; analog für nur-Schreib-Kanäle beim Schreiben. Ohne *direction* wird der Kanal für Lesen und Schreiben geschlossen (aber nur, wenn diese Richtungen derzeit geöffnet sind). Es ist ein Fehler, einen nur-Lese-Kanal zum Schreiben oder einen nur-Schreib-Kanal zum Lesen zu schließen.
    Beim Schließen wird die gesamte gepufferte Ausgabe auf das Ausgabegerät des Kanals geschrieben (nur wenn der Kanal nicht mehr beschreibbar wird), gepufferte Eingabe verworfen (nur wenn der Kanal nicht mehr lesbar wird), die zugrunde liegende Betriebssystemressource freigegeben und *channelId* steht nicht mehr zur Verfügung (jeweils nur bei vollständigem Schließen).
    Ist der Kanal blockierend und wird er nicht mehr beschreibbar, kehrt der Befehl erst zurück, wenn die gesamte Ausgabe geschrieben wurde. Ist der Kanal nicht-blockierend und liegt ungeschriebene Ausgabe vor, bleibt der Kanal geöffnet und der Befehl kehrt sofort zurück; die Ausgabe wird im Hintergrund geschrieben und der Kanal wird geschlossen, sobald alles geschrieben ist.
    Ist *channelId* ein blockierender Kanal einer Befehlspipeline, wartet **chan close** auf das Ende der Kindprozesse.
    Wird der Kanal zwischen Interpretern geteilt, macht **chan close** *channelId* im aufrufenden Interpreter unverfügbar, hat aber sonst keine Wirkung, bis alle teilenden Interpreter den Kanal geschlossen haben. Ruft der letzte Interpreter, in dem der Kanal registriert ist, **chan close** (oder **close**) auf, erfolgen die oben beschriebenen Aufräumarbeiten. Beim Halbschließen gilt das Halbschließen nur für die Sicht des aktuellen Interpreters, bis alle Interpreter den Kanal in dieser Richtung (oder vollständig) geschlossen haben. Siehe den Befehl **interp** zur Kanal-Freigabe.
    Kanäle werden beim Zerstören eines Interpreters und beim Beenden des Prozesses automatisch vollständig geschlossen. Kanäle werden in den blockierenden Modus geschaltet, damit vor Prozessende die gesamte Ausgabe korrekt geschrieben wird.
    Der Befehl gibt eine leere Zeichenkette zurück und kann einen Fehler erzeugen, wenn beim Schreiben der Ausgabe ein Fehler auftritt. Liefert ein Befehl in einer mit **open** erzeugten Befehlspipeline einen Fehler, erzeugt **chan close** einen Fehler (ähnlich dem Befehl **exec**).

::: {.info -version="8.6"}
Beachten Sie, dass Halbschließen von Sockets und Befehlspipelines wichtige Nebenwirkungen haben kann, weil dabei shutdown() oder close() auf der zugrunde liegenden Systemressource ausgeführt wird, was das Verhalten anderer Prozesse oder Systeme gegenüber dem Tcl-Programm ändern kann.
:::

**chan configure** *channelId* ?*optionName*? ?*value*? ?*optionName value*?...
: Abfragen oder Setzen der Konfigurationsoptionen des Kanals *channelId*.
    Werden weder *optionName* noch *value* angegeben, gibt der Befehl eine Liste mit abwechselnd Optionsnamen und Werten für den Kanal zurück. Ist nur *optionName* angegeben, gibt er den aktuellen Wert dieser Option zurück. Werden ein oder mehrere Paare *optionName* und *value* übergeben, setzt der Befehl jede genannte Option auf den zugehörigen *value*; der Rückgabewert ist dann eine leere Zeichenkette.
    Die folgenden Optionen werden für alle Kanäle unterstützt. Zusätzlich kann jeder Kanaltyp eigene Optionen anbieten. Siehe die Manpage des Befehls, der den jeweiligen Kanaltyp erzeugt; z. B. die Manpage von **socket** für Socket-Optionen und **open** für serielle Geräte.

**-blocking** *boolean*
: Die Option **-blocking** legt fest, ob E/A-Operationen auf dem Kanal den Prozess unbegrenzt blockieren können. Der Wert der Option muss ein gültiger boolescher Wert sein. Kanäle sind normalerweise im blockierenden Modus; wird ein Kanal in den nicht blockierenden Modus versetzt, beeinflusst das die Operationen der Befehle **chan gets**, **chan read**, **chan puts**, **chan flush** und **chan close**; Einzelheiten finden sich in deren Dokumentation. Damit der nicht blockierende Modus korrekt funktioniert, muss die Anwendung die Tcl-Ereignisschleife verwenden (z. B. durch Aufruf von **Tcl_DoOneEvent** oder den Befehl **vwait**).

**-buffering** *newValue*
: Ist *newValue* **full**, puffert das E/A-System die Ausgabe, bis der interne Puffer voll ist oder **chan flush** aufgerufen wird. Ist *newValue* **line**, wird die Ausgabe automatisch geschrieben, sobald ein Zeilenumbruch ausgegeben wird. Ist *newValue* **none**, wird nach jeder Ausgabeoperation geschrieben. Standard ist **full**, außer bei terminalähnlichen Geräten; dort ist der Anfangswert **line**. Zusätzlich sind **stdin** und **stdout** anfangs **line**, **stderr** ist **none**.

**-buffersize** *newSize*
: *newSize* muss eine Ganzzahl sein; ihr Wert wird verwendet, um die Größe der für diesen Kanal anschließend zugewiesenen Ein- oder Ausgabepuffer in Bytes festzulegen. *newSize* darf höchstens eine Million sein, sodass Puffer bis zu einer Million Bytes groß sein können.

**-encoding** *name*
: Diese Option legt die Kanal-Kodierung als eine der von **encoding names** zurückgegebenen Kodierungen oder den Sonderwert **binary** fest, damit Daten für Tcl in Unicode umgewandelt werden können. Soll Tcl z. B. Zeichen aus einer japanischen Datei in **shiftjis** lesen und verarbeiten, wird die Kodierung auf **shiftjis** gesetzt; beim Lesen werden die Bytes in Unicode umgewandelt. Beim Schreiben werden Tcl-Zeichenketten beim Ausgeben in die gewählte Kodierung umgewandelt.
    Enthält eine Datei reine Binärdaten (z. B. ein JPEG), sollte die Kodierung **binary** sein. Tcl interpretiert die Daten dann nicht und liest oder schreibt rohe Bytes. Der Befehl **binary** kann diese byteorientierten Daten bearbeiten. Oft ist **-translation** **binary** beim Übertragen von Binärdaten besser, weil damit weitere automatische Interpretationen der Bytes abgeschaltet werden.
    Die Standard-Kodierung neu geöffneter Kanäle ist die plattform- und locale-abhängige Systemkodierung von **encoding system**.

**-eofchar** *char*
: ...siehe nächstes...

**-eofchar** **{**_inChar outChar_**}**
: Diese Option unterstützt DOS-Dateisysteme, die Control-z (\x1A) als Dateiende-Marker verwenden. Ist *char* nicht die leere Zeichenkette, signalisiert dieses Zeichen beim Lesen Dateiende. Beim Schreiben wird das Dateiende-Zeichen beim Schließen des Kanals ausgegeben. Ist *char* leer, gibt es keinen speziellen Dateiende-Marker. Bei Lese-Schreib-Kanälen legt eine zweielementige Liste getrennte Marker für Eingabe und Ausgabe fest. Beim Setzen für Lese-Schreib-Kanäle kann ein einzelner Wert für beide Richtungen angegeben werden. Beim Abfragen wird stets eine zweielementige Liste zurückgegeben. Standard für **-eofchar** ist die leere Zeichenkette, außer unter Windows: dort ist **-eofchar** beim Lesen Control-z (\x1A) und beim Schreiben leer. Zulässig sind Werte von \x01 - \x7f; Werte außerhalb dieses Bereichs erzeugen einen Fehler.

**-translation** *translation*
: ...siehe nächstes...

**-translation** **{**_inTranslation outTranslation_**}**
: In Tcl-Skripten steht das Zeilenende stets als ein einzelnes Newline (\n). In Dateien und Geräten kann es je nach Plattform oder Gerät unterschiedlich dargestellt sein (z. B. unter UNIX Newlines in Dateien, in Netzwerkverbindungen oft Wagenrücklauf-Zeilenvorschub). Beim Lesen (**chan gets**, **chan read**) wandelt das Tcl-E/A-System die externe Darstellung in Newlines um; beim Schreiben (**chan puts**) umgekehrt. Der Standardmodus **auto** behandelt die üblichen Fälle; **-translation** erlaubt explizite Steuerung.
    Der Wert von **-translation** ist bei Nur-Lese- und Nur-Schreib-Kanälen ein einzelnes Element, bei Lese-Schreib-Kanälen eine zweielementige Liste (Lesen, dann Schreiben). Beim Setzen für Lese-Schreib-Kanäle kann ein Wert für beide Richtungen gelten; beim Abfragen wird stets eine Liste zurückgegeben. Unterstützt werden derzeit:

**auto**
: Als Eingabeübersetzungsmodus behandelt **auto** jedes von Newline (**lf**), Wagenrücklauf (**cr**) oder Wagenrücklauf gefolgt von einem Zeilenvorschub (**crlf**) als Zeilenende-Darstellung. Die Zeilenende-Darstellung kann sogar von Zeile zu Zeile wechseln; alle Fälle werden in ein Newline übersetzt. Als Ausgabeübersetzungsmodus wählt **auto** eine plattformspezifische Darstellung; für Sockets auf allen Plattformen wählt Tcl **crlf**, für alle Unix-Varianten **lf** und für die verschiedenen Windows-Varianten **crlf**. Die Standardeinstellung für **-translation** ist **auto** sowohl für Eingabe als auch Ausgabe.

**binary**
: Wie **lf** ohne Zeilenende-Übersetzung; setzt zusätzlich **-eofchar** auf die leere Zeichenkette (deaktiviert) und **-encoding** auf **iso8859-1**. Damit ist der Kanal für binäre Ein- und Ausgabe vollständig konfiguriert: Jedes gelesene Byte wird zum Unicode-Zeichen gleichen Werts, jedes geschriebene Zeichen zu einem Byte. So lassen sich Binärdaten nahtlos bearbeiten, solange jedes Zeichen im Bereich 0–255 bleibt. Ein JPEG-Bild kann z. B. gelesen, bearbeitet und wieder geschrieben werden.

**cr**
: Das Zeilenende in der zugrunde liegenden Datei oder dem Gerät ist ein Wagenrücklauf. Im Eingabemodus **cr** werden Wagenrückläufe in Newlines umgewandelt; im Ausgabemodus werden Newlines in Wagenrückläufe umgewandelt.

**crlf**
: Das Zeilenende ist Wagenrücklauf gefolgt von Zeilenvorschub. Im Eingabemodus **crlf** werden solche Sequenzen in Newlines umgewandelt; im Ausgabemodus werden Newlines in Wagenrücklauf-Zeilenvorschub umgewandelt. Typisch unter Windows und in Netzwerkverbindungen.

**lf**
: Das Zeilenende ist ein einzelnes Newline (Zeilenvorschub). Es erfolgt keine Übersetzung bei Eingabe oder Ausgabe. Typisch unter UNIX.


**chan copy** *inputChan outputChan* ?**-size** *size*? ?**-command** *callback*?
: Kopiert Daten vom zum Lesen geöffneten Kanal *inputChan* in den zum Schreiben geöffneten Kanal *outputChan*. **chan copy** nutzt das Puffern des Tcl-E/A-Systems, um zusätzliche Kopien und übermäßiges Puffern großer Dateien bei langsamen Zielen (z. B. Netzwerk-Sockets) zu vermeiden.
    Es werden Daten von *inputChan* gelesen, bis Dateiende erreicht ist oder *size* Bytes bzw. Zeichen übertragen wurden; *size* ist in Bytes, wenn beide Kanäle dieselbe Kodierung verwenden, sonst in Zeichen. Ohne **-size** wird bis Dateiende kopiert. Alles Gelesene wird nach *outputChan* geschrieben. Ohne **-command** blockiert **chan copy** bis zum Ende und gibt die Anzahl geschriebener Bytes oder Zeichen zurück (gleiche Regeln wie bei **-size**).
    Mit **-command** arbeitet **chan copy** im Hintergrund: sofortige Rückkehr, *callback* wird nach Abschluss aufgerufen mit ein oder zwei zusätzlichen Argumenten zur Anzahl geschriebener Bytes; bei Fehler im Hintergrundkopieren ist das zweite Argument die Fehlermeldung. Im Hintergrundmodus müssen *inputChan* und *outputChan* nicht manuell nicht-blockierend gesetzt werden; **chan copy** erledigt das. Die Ereignisschleife muss laufen (**vwait** oder Tk).
    Während eines Hintergrund-**chan copy** sind andere E/A-Operationen auf *inputChan* oder *outputChan* nicht erlaubt. Wird einer der Kanäle während des Kopiervorgangs geschlossen, stoppt das Kopieren und der Callback wird *nicht* aufgerufen. Wird *inputChan* geschlossen, wird die für *outputChan* bereits eingereihte Ausgabe noch geschrieben.
    *inputChan* kann während eines Hintergrundkopierens lesbar werden. **chan event**- oder **fileevent**-Handler sollten dann abgeschaltet werden, damit sie das Kopieren nicht stören; E/A in solchen Handlern liefert „channel busy“.
    **Chan copy** übersetzt Zeilenenden in *inputChan* und *outputChan* gemäß **-translation** (siehe **chan configure**). Die gelesene Byteanzahl kann von der geschriebenen abweichen; gemeldet wird nur die geschriebene Menge (Rückgabewert oder Callback-Argument).
    **Chan copy** beachtet Kodierung und Zeichenübersetzungen der Kanäle: eingehende Zeichen werden intern zuerst nach UTF-8 und dann in die Ausgabekodierung umgewandelt (siehe **-encoding** und **-translation** unter **chan configure**). Keine Umwandlung, wenn beide Kanäle **binary** mit passenden Übersetzungen haben. Ist nur der Ausgabekanal **binary**, schreibt das System die interne UTF-8-Darstellung. Ist nur der Eingabekanal **binary**, werden eingehende Bytes als gültige UTF-8-Zeichen behandelt und gemäß Ausgabekodierung umgewandelt. Das Verhalten bei ungültigen UTF-8-Bytes ist in diesem Fall undefiniert.

**chan create** *mode cmdPrefix*
: Dieser Unterbefehl erzeugt einen neuen Kanal auf Skriptebene mit dem Befehlspräfix *cmdPrefix* als Handler. Solche Kanäle heißen **reflektierte** Kanäle. *cmdPrefix* muss eine nicht-leere Liste sein und die in der Manpage **refchan** beschriebene API bereitstellen. Der Handle des neuen Kanals ist der Rückgabewert von **chan create**; der Kanal ist geöffnet. Entfernen mit **close** oder **chan close**.
    *mode* gibt an, ob der Kanal zum Lesen, Schreiben oder beides geöffnet ist: eine Liste mit **read** und/oder **write**; mindestens ein Element ist nötig. Der Handler muss den gewählten Modus unterstützen, sonst tritt ein Fehler auf.
    Das Befehlspräfix wird im globalen Namespace am oberen Ende des Aufrufstapels ausgeführt, mit den in **refchan** beschriebenen angehängten Argumenten. Die Auflösung erfolgt zum Aufrufzeitpunkt; Umbenennen oder Zerstören des Befehls kann den nächsten Handler-Aufruf fehlschlagen lassen, was den aufrufenden Kanalbefehl ebenfalls fehlschlagen lässt; die Fehlermeldung erklärt den Grund ggf. nicht.
    Jeder so erzeugte Kanal kennt den Interpreter, in dem er erstellt wurde, und führt seinen Handler nur dort aus, auch wenn der Kanal geteilt oder in einen anderen Interpreter verschoben wurde. Er kennt auch den Erstellungs-Thread und führt den Handler nur dort aus. Aufrufe werden per Ereignisse an den Original-Thread weitergeleitet. Der Original-Thread (der **chan create** ausführte) braucht daher eine aktive Ereignisschleife; sonst kann der sendende Thread *unbegrenzt blockieren*. Deadlocks sind möglich.
    Damit lassen sich Kanäle erzeugen, deren Endpunkte in verschiedenen Threads liegen – ein streamorientierter Kanal zwischen Threads statt nur Befehlsübermittlung.
    Wird ein Thread oder Interpreter gelöscht, werden alle mit diesem Unterbefehl erzeugten Kanäle dieses Threads/Interpreters ebenfalls in allen Interpretern und Threads entfernt, in denen sie geteilt oder verschoben waren. Die Nutzung solcher Kanäle führt dann zu Fehlern über unbekannte Kanal-Handles.
    Dieser Unterbefehl ist **safe** und für sichere Interpreter zugänglich. Er kann beliebigen Tcl-Code ausführen, aber stets nur innerhalb des sicheren Interpreters.

**chan eof** *channelId*
: Prüft, ob die letzte Eingabeoperation auf *channelId* fehlgeschlagen ist, weil das Datenende erreicht wurde; gibt 1 bei Dateiende, sonst 0 zurück.

**chan event** *channelId event* ?*script*?
: Richtet das Tcl-Skript *script* als *Datei-Ereignis-Handler* ein, der aufgerufen wird, wenn *channelId* den durch *event* beschriebenen Zustand erreicht (**readable** oder **writable**); pro Ereignis und Kanal ist höchstens ein Handler möglich. Ist *script* leer, wird der aktuelle Handler gelöscht (auch beim Schließen des Kanals oder Löschen des Interpreters). Fehlt *script*, wird das installierte Skript zurückgegeben (oder eine leere Zeichenkette). Der Callback läuft nur, wenn die Ereignisschleife bedient wird (**vwait**, **update**).
    Ein Datei-Ereignis-Handler verknüpft Kanal und Skript, sodass das Skript ausgewertet wird, wenn der Kanal lesbar oder beschreibbar wird. Häufig empfängt man so ereignisgesteuert Daten von anderen Prozessen, ohne den Rest der Anwendung zu blockieren. **chan gets** oder **chan read** auf einem blockierenden Kanal ohne Daten blockieren den Prozess; mit **chan event** weiß man, wann Daten da sind, und ruft **chan gets**/**chan read** nur dann auf, wenn sie nicht blockieren.
    Ein Kanal ist lesbar, wenn auf dem Gerät ungelesene Daten liegen oder im Eingabepuffer (außer wenn der letzte Leseversuch **chan gets** war und keine vollständige Zeile im Puffer war – damit ist zeilenweises nicht-blockierendes Lesen per Ereignisse möglich). Lesbar ist er auch bei Dateiende oder Fehler auf dem Gerät. *script* sollte diese Fälle prüfen; ohne Dateiende-Prüfung kann eine Endlosschleife entstehen.
    Beschreibbar ist ein Kanal, wenn mindestens ein Byte ohne Blockieren geschrieben werden kann oder ein Fehler vorliegt. Client-Sockets im asynchronen Modus werden beschreibbar, wenn die Verbindung steht oder fehlschlägt.
    Ereignisgesteuerte E/A funktioniert am besten mit nicht-blockierenden Kanälen (**chan configure**). Im blockierenden Modus können **chan puts**, **chan gets** und **chan read** blockieren, ohne dass Ereignisse verarbeitet werden; im nicht-blockierenden Modus blockieren sie nicht.
    Das Skript wird auf globaler Ebene im Interpreter ausgeführt, in dem **chan event** aufgerufen wurde. Tritt ein Fehler auf, meldet **interp bgerror** ihn; der Handler wird bei Fehlerrückkehr gelöscht, um Endlosschleifen durch fehlerhafte Handler zu vermeiden.

**chan flush** *channelId*
: Stellt sicher, dass die gesamte ausstehende Ausgabe für *channelId* geschrieben wird.
    Im blockierenden Modus kehrt der Befehl erst zurück, wenn alles geschrieben ist. Im nicht-blockierenden Modus kann er früher zurückkehren; der Rest wird im Hintergrund geschrieben, sobald das Gerät Daten aufnimmt.

**chan gets** *channelId* ?*varName*?
: Liest die nächste Zeile von *channelId*. Ohne *varName* ist das Ergebnis die gelesene Zeile ohne abschließendes Newline oder eine leere Zeichenkette bei Dateiende bzw. erschöpften Daten im nicht-blockierenden Modus. Mit *varName* wird die Zeile in die Variable geschrieben; der Rückgabewert ist die Zeichenanzahl oder -1 bei Dateiende bzw. erschöpften Daten im nicht-blockierenden Modus.
    Wird Dateiende mitten in einer Zeile erreicht, wird die Teilzeile zurückgegeben bzw. in *varName* geschrieben. Ohne *varName* unterscheidet **chan eof** Dateiende von einer leeren Zeile; **chan blocked** den Fall unvollständiger Zeile im nicht-blockierenden Modus.

**chan names** ?*pattern*?
: Liefert eine Liste aller Kanalnamen. Mit *pattern* nur Namen, die gemäß **string match** passen.

**chan pending** *mode channelId*
: Gibt je nach *mode* (**input** oder **output**) die Anzahl der für *channelId* intern gepufferten Eingabe- bzw. Ausgabebytes zurück (nützlich in lesbaren Ereignis-Callbacks, um Zeilenlängen zu begrenzen und Denial-of-Service durch extrem lange Zeilen zu vermeiden). Gibt -1 zurück, wenn der Kanal nicht für den gefragten Modus geöffnet wurde.

**chan pipe**
: Erzeugt eine eigenständige Pipe; Rückgabe ist eine 2-Element-Liste (Leseseite, Schreibseite). Nützlich z. B. um **stderr** und **stdout** eines Subprozesses getrennt umzuleiten: Subprozess mit „2>@“ oder „>@“ auf die Schreibseite starten und sie im Elternprozess sofort schließen, damit auf der Leseseite EOF kommt, wenn das Kind seine Ausgabe schließt.

::: {.info -version="8.6"}
Die Puffersemantik kann je nach Betriebssystem stark variieren; man darf nicht annehmen, dass jeder Schreibvorgang sofort auf der Leseseite sichtbar ist. Tcl kann das nicht vollständig verbergen; blockierendes Lesen/Schreiben bleibt weitgehend kompatibel, Details wann genau geschrieben wird, können abweichen – bei Tests auf Pipelines Deadlocks und kurze Lesevorgänge beachten.
:::

**chan pop** *channelId*
: Entfernt die oberste Transformation von *channelId*, falls vorhanden. Gibt es keine, entspricht das **chan close** für diesen Kanal. Rückgabe ist normalerweise die leere Zeichenkette, kann in manchen Situationen ein Fehler sein.

**chan postevent** *channelId eventSpec*
: Wird von Handlern von mit **chan create** erzeugten Kanälen verwendet. Meldet dem Kanal *channelId*, dass die in *eventSpec* genannten Ereignisse eingetreten sind – eine Liste mit **read** und/oder **write**, mindestens ein Element.
    Nur für mit **chan create** erzeugte Kanäle; andere Kanäle melden einen Fehler.
    Nur der Interpreter, der den Kanal erstellt hat, darf Ereignisse melden; von anderen Interpretern aus ist das nicht erlaubt.
    Es können keine Ereignisse gemeldet werden, für die der E/A-Kern kein Interesse registriert hat; sonst Fehler. Siehe **watch** in **refchan**.
    Der Befehl ist **safe** und kann **chan event**-Handler im gleichen oder anderen Interpretern/Threads auslösen, auch von einem sicheren Interpreter zu einem vertrauenswürdigen. Handler laufen stets im Interpreter, der sie registriert hat.

**chan push** *channelId cmdPrefix*
: Fügt eine neue Transformation über *channelId* hinzu. *cmdPrefix* ist eine Liste von Wörtern als Handler gemäß Manpage **transchan**. Rückgabe ist ein Handle zur Transformation. Die Transformation muss den Kanalmodus unterstützen, sonst kann der Kanal weder lesbar noch beschreibbar werden.

**chan puts** ?**-nonewline**? ?*channelId*? *string*
: Schreibt *string* in *channelId* gefolgt von einem Newline, sofern **-nonewline** nicht gesetzt ist. Fehlt *channelId*, wird nach **stdout** geschrieben.
    Newlines werden gemäß **-translation** in plattformspezifische Zeilenenden umgewandelt (siehe **chan configure**).
    Tcl puffert intern; mit **chan flush** kann sofort geschrieben werden.
    Ist der Ausgabepuffer voll, blockiert **chan puts** normalerweise. Im nicht-blockierenden Modus blockiert er nicht; Daten werden im Hintergrund geschrieben. Die Ereignisschleife ist nötig. Es kann viel Speicher gepuffert werden – nicht-blockierende E/A sollte ereignisgesteuert mit **chan event** erfolgen (**chan puts** nur nach Benachrichtigung, dass der Kanal mehr Daten annimmt).

**chan read** *channelId* ?*numChars*?
: ...siehe nächstes...

**chan read** ?**-nonewline**? *channelId*
: In der ersten Form liefert der Befehl die nächsten *numChars* Zeichen von *channelId*; fehlt *numChars*, alle Zeichen bis zu einem Fehler (Dateiende, blockiert oder anderer Fehler). In der zweiten Form (ohne *numChars*) kann **-nonewline** ein abschließendes Newline am Ende entfernen.
    Im nicht-blockierenden Modus liest **chan read** ggf. weniger als angefordert und gibt verfügbare Daten zurück. Bei Mehrbyte-Kodierung können Bytes im Puffer verbleiben, bis ein vollständiges Zeichen oder Dateiende vorliegt. **-nonewline** wird ignoriert, wenn vor Dateiende zurückgekehrt wird.
    **Chan read** wandelt Zeilenenden gemäß **-translation** um (siehe **chan configure**).
    Beim Lesen von einem seriellen Port sollte der Kanal meist nicht-blockierend konfiguriert werden:

    ```
    chan configure channelId \-blocking 0.
    ```
    Dann verhält sich **chan read** wie oben beschrieben. Beachten Sie, dass die meisten seriellen Ports vergleichsweise langsam sind; es ist durchaus möglich, für jedes vom Port gelesene Zeichen ein **readable**-Ereignis zu erhalten. Vorsicht ist geboten bei **chan read** auf blockierenden seriellen Ports:

**chan read** *channelId numChars*
: In dieser Form blockiert **chan read**, bis *numChars* vom seriellen Port empfangen wurden.

**chan read** *channelId*
: In dieser Form blockiert **chan read**, bis das Dateiende-Zeichen empfangen wurde (siehe **chan configure -eofchar**). Ist keines konfiguriert, blockiert **chan read** unbegrenzt.


**chan seek** *channelId offset* ?*origin*?
: Setzt die aktuelle Zugriffsposition im Datenstrom von *channelId* auf *offset* Bytes relativ zu *origin*. *offset* ist eine Ganzzahl (auch negativ), *origin* einer der folgenden Werte:

**start**
: Die neue Position liegt *offset* Bytes vom Anfang der Datei oder des Geräts entfernt.

**current**
: Die neue Position liegt *offset* Bytes von der aktuellen Position; negatives *offset* bewegt rückwärts.

**end**
: Die neue Position liegt *offset* Bytes vom Dateiende; negatives *offset* davor, positives danach.

    *origin* ist standardmäßig **start**.
    **Chan seek** schreibt die gesamte gepufferte Ausgabe vor der Rückkehr, auch im nicht-blockierenden Modus, und verwirft ungelesene Eingabe. Rückgabe ist die leere Zeichenkette. Fehler, wenn das Gerät kein Suchen unterstützt.
    *offset* bezieht sich auf Bytes, nicht Zeichen; **chan seek** und **chan tell** arbeiten in Bytes, anders als **chan read**.

**chan tell** *channelId*
: Gibt die aktuelle Zugriffsposition in Bytes im Datenstrom von *channelId* zurück (für **chan seek**). Nicht in Zeichen wie **chan read**. Für Kanäle ohne Suchen wird -1 zurückgegeben.

**chan truncate** *channelId* ?*length*?
: Setzt die Bytelänge des Datenstroms von *channelId* auf *length* (oder auf die aktuelle Byteposition, wenn *length* fehlt). Der Kanal wird vor dem Kürzen geschrieben.


# BEISPIELE

## Einfache Beispiele für Kanaloperationen

Weisen Sie Tcl an, Ausgabe auf **stdout** sofort zu senden, unabhängig davon, ob es an ein Terminal geht:

```
chan configure stdout -buffering none
```

Im folgenden Beispiel wird eine Datei mit der unter Windows üblichen Kodierung CP1252 geöffnet, nach einer Zeichenkette gesucht, dieser Teil neu geschrieben und die Datei zwei Zeilen später gekürzt.

```
set f [open somefile.txt r+]
chan configure $f -encoding cp1252
set offset 0

# Nach Zeichenkette "FOOBAR" in der Datei suchen
while {[chan gets $f line] >= 0} {
    set idx [string first FOOBAR $line]
    if {$idx >= 0} {
        # Gefunden; Zeile umschreiben

        chan seek $f [expr {$offset + $idx}]
        chan puts -nonewline $f BARFOO

        # Zum Ende der folgenden Zeile springen und kürzen
        chan gets $f
        chan gets $f
        chan truncate $f

        # Suche in der Datei beenden
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

# Wird aufgerufen, wenn mindestens ein Byte Eingabedaten verfügbar ist
# oder der Client den Kanal geschlossen hat.
proc echoLine {chan clientName} {
    chan gets $chan line
    if {[chan eof $chan]} {
        log "finishing connection from $clientName"
        chan close $chan
    } elseif {![chan blocked $chan]} {
        # Kein Blockieren beim Warten auf Zeilenende
        log "$clientName - $line"
        chan puts $chan $line
    }
}

# Server-Socket erstellen und Ereignisschleife starten, um
# auf eingehende Verbindungen zu warten...
socket -server connect 12345
vwait forever
```
