---
CommandName: ftp
title: ftp
ManualSection: n
Version: 2.4.14
TclPart: tcllib
TclDescription: ftp client
Links:
 - ftpd
 - mime
 - pop3
 - smtp
Keywords:
 - ftp
 - internet
 - net
 - rfc 959
Copyright:
---

# Name

ftp – Clientseitige TCL-Implementierung des FTP-Protokolls

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [ftp]{.lit} [2.4.14]{.optlit}
[::ftp::Open]{.cmd} [server]{.arg} [user]{.arg} [passwd]{.arg} [options]{.optarg}
[::ftp::Close]{.cmd} [handle]{.arg}
[::ftp::Cd]{.cmd} [handle]{.arg} [directory]{.arg}
[::ftp::Pwd]{.cmd} [handle]{.arg}
[::ftp::Type]{.cmd} [handle]{.arg} [ascii|binary|tenex]{.optlit}
[::ftp::List]{.cmd} [handle]{.arg} [pattern]{.optarg}
[::ftp::NList]{.cmd} [handle]{.arg} [directory]{.optarg}
[::ftp::FileSize]{.cmd} [handle]{.arg} [file]{.arg}
[::ftp::ModTime]{.cmd} [handle]{.arg} [file]{.arg}
[::ftp::Delete]{.cmd} [handle]{.arg} [file]{.arg}
[::ftp::Rename]{.cmd} [handle]{.arg} [from]{.arg} [to]{.arg}
[::ftp::Put]{.cmd} [handle]{.arg} ([local]{.arg} | -data [data]{.arg} | -channel [chan]{.arg}) [remote]{.optarg}
[::ftp::Append]{.cmd} [handle]{.arg} ([local]{.arg} | -data [data]{.arg} | -channel [chan]{.arg}) [remote]{.optarg}
[::ftp::Get]{.cmd} [handle]{.arg} [remote]{.arg} ?(local | -variable [varname]{.arg} | -channel [chan)?]{.arg}
[::ftp::Reget]{.cmd} [handle]{.arg} [remote]{.arg} [local]{.optarg} [from]{.optarg} [to]{.optarg}
[::ftp::Newer]{.cmd} [handle]{.arg} [remote]{.arg} [local]{.optarg}
[::ftp::MkDir]{.cmd} [handle]{.arg} [directory]{.arg}
[::ftp::RmDir]{.cmd} [handle]{.arg} [directory]{.arg}
[::ftp::Quote]{.cmd} [handle]{.arg} [arg1]{.arg} [arg2]{.arg} [...]{.arg}
[::ftp::DisplayMsg]{.cmd} [handle]{.arg} [msg]{.arg} [state]{.optarg}
:::

# Beschreibung

Das Paket „ftp“ stellt die Client-Seite des FTP-Protokolls bereit, wie es in RFC 959 (<http://www.rfc-editor.org/rfc/rfc959.txt>) festgelegt ist. Das Paket implementiert sowohl aktive (Standard) als auch passive FTP-Sitzungen.

Mit dem Befehl **::ftp::Open** wird eine neue FTP-Sitzung gestartet. Um eine bestehende FTP-Sitzung zu beenden, verwenden Sie **::ftp::Close**. Alle anderen Befehle dürfen ausschließlich innerhalb einer geöffneten FTP-Sitzung verwendet werden. Werden sie außerhalb dieses Kontexts eingesetzt, führen sie zu Fehlern.  Das FTP-Paket enthält Befehle zur Bearbeitung von Dateien und Verzeichnissen auf Remote-Systemen. Um dieselben Vorgänge auf dem lokalen System durchzuführen, verwenden Sie in den Kern integrierte Befehle wie **cd** oder **file**.

Die Ausgabe des Pakets wird durch zwei Statusvariablen gesteuert: **::ftp::VERBOSE** und **::ftp::DEBUG**. Wenn Sie **::ftp::VERBOSE** auf „1“ setzen, wird das Paket dazu gezwungen, alle Antworten eines Remote-Servers anzuzeigen. Der Standardwert ist „0“. Durch Setzen von **::ftp::DEBUG** auf „1“ wird das Debugging aktiviert und das Paket dazu veranlasst, alle Rückgabecodes, Zustände, Zustandsänderungen und „echte“ FTP-Befehle anzuzeigen. Der Standardwert ist „0“.

Der Befehl **::ftp::DisplayMsg** dient dazu, die verschiedenen Meldungen aus der FTP-Sitzung anzuzeigen. Die Einstellung von **::ftp::VERBOSE** legt fest, ob dieser Befehl aufgerufen wird oder nicht. Die aktuelle Implementierung des Befehls nutzt das Paket **log** von tcllib, um die Meldungen an ihren endgültigen Speicherort zu schreiben. Dies bedeutet, dass das Verhalten von **::ftp::DisplayMsg** angepasst werden kann, ohne dessen Implementierung zu ändern. Für grundlegendere Änderungen ist es natürlich weiterhin möglich, die Implementierung durch die Anwendung zu überschreiben. Beachten Sie, dass die Standardimplementierung die Optionen **-output** bis **::ftp::Open** für einen sitzungsspezifischen Protokollbefehl berücksichtigt.

*Achtung*: Die Standardimplementierung protokolliert Fehlermeldungen wie alle anderen Meldungen auch. Wenn dieses Verhalten dahingehend geändert wird, dass stattdessen ein Fehler ausgelöst wird, ändert sich auch das Verhalten aller Befehle in der API. In einem solchen Fall geben sie keinen Fehlercode, wie unten beschrieben, zurück, sondern leiten den ausgelösten Fehler an den Aufrufer weiter.

# API

**::ftp::Open** *server* *user* *passwd* ?*options*?
: Dieser Befehl dient dazu, eine FTP-Sitzung zu starten, indem eine Steuerverbindung zum FTP-Server hergestellt wird. Für alle vom Aufrufer nicht angegebenen Optionen werden die Standardwerte verwendet.

    Der Befehl nimmt als Parameter einen Hostnamen *server*, einen Benutzernamen *user* und ein Passwort *password* entgegen und gibt ein Sitzungs-Handle zurück, das eine ganze Zahl größer oder gleich „0“ ist, wenn die Verbindung erfolgreich hergestellt wurde. Andernfalls wird „-1“ zurückgegeben. Der Parameter *server* muss den Namen oder die Internetadresse (in Dezimalschreibweise mit Punkten) des FTP-Servers enthalten, mit dem eine Verbindung hergestellt werden soll. Die Parameter *user* und *passwd* müssen einen gültigen Benutzernamen und ein gültiges Passwort enthalten, um den Anmeldevorgang abzuschließen.

    Die Optionen überschreiben einige Standardwerte oder legen spezielle Funktionen fest:

    **-blocksize** *size*
    : Die Blockgröße wird bei der Datenübertragung verwendet. Es werden höchstens *size* Bytes auf einmal übertragen. Der Standardwert für diese Option beträgt 4096. Das Paket führt nach der Übertragung jedes Blocks die Auswertung des **-progress callback** für die jeweilige Sitzung durch.

    **-timeout** *seconds*
    : Wenn *seconds* ungleich Null ist, legt **::ftp::Open** ein Timeout fest, das nach der angegebenen Anzahl von Sekunden eintritt. Der Standardwert beträgt 600.

    **-port** *number*
    : Die Port-*number* legt einen alternativen Remote-Port auf dem FTP-Server fest, auf dem der FTP-Dienst läuft. Die meisten FTP-Dienste warten auf Anfragen für Verbindungen am Standardport 21. Manchmal, meist aus Gründen der Sicherheit, werden für FTP-Verbindungen andere Portnummern als 21 verwendet.

    **-mode** *mode*
    : Die Option „*mode*“ legt fest, ob eine Dateiübertragung im Modus **active** oder **passive** erfolgt. Im passiven Modus fordert der Client den FTP-Server auf, auf einem Datenport zu lauschen und auf die Verbindung zu warten, anstatt den Prozess selbst zu initiieren, wenn eine Datenübertragungsanforderung eingeht. Der passive Modus ist in der Regel eine Anforderung, wenn der Zugriff auf Server über eine Firewall erfolgt. Der Standardmodus ist **active**.

    **-progress** *callback*
    : Die Rückruffunktion *callback* wird jedes Mal ausgeführt, wenn ein Datenblock übertragen wurde. Informationen zur Festlegung der Größe der übertragenen Blöcke finden Sie unter der Option **-blocksize**.

        Bei der Auswertung von *callback* wird dem Skript ein Argument angehängt: die aktuell kumulierte Anzahl der bisher übertragenen Bytes.

    **-command** *callback*
    : Durch die Angabe dieser Option wird die Verbindung in den asynchronen Modus versetzt. Der *callback* wird nach Abschluss eines Vorgangs ausgewertet. Während ein Vorgang ausgeführt wird, dürfen keine weiteren Vorgänge gestartet werden, bis eine Rückruffunktion für den aktuell ausgeführten Vorgang empfangen wurde.

        Bei der Auswertung des *callback* werden dem Callback-Skript mehrere Argumente angehängt, nämlich das Schlüsselwort des abgeschlossenen Vorgangs sowie etwaige zusätzliche, für den Vorgang spezifische Argumente. Sollte während der Ausführung des Vorgangs ein Fehler aufgetreten sein, erhält die Rückruffunktion das Schlüsselwort **error**.

    **-output** *callback*
    : Diese Option hat keinen Standardwert. Wird sie gesetzt, verwendet die Standardimplementierung von **::ftp::DisplayMsg** ihren Wert als Befehlspräfix, um alle internen Meldungen zu protokollieren. Die Rückruffunktion wird vor der Auswertung mit drei Argumenten angehängt: die ID der Sitzung, die Meldung selbst und der Verbindungsstatus, und zwar in dieser Reihenfolge.


**::ftp::Close** *handle*
: Dieser Befehl beendet die angegebene FTP-Sitzung. Wenn gerade keine Dateiübertragung stattfindet, schließt der Server die Steuerverbindung sofort. Findet jedoch gerade eine Dateiübertragung statt, bleibt die Steuerverbindung offen, bis die Übertragung abgeschlossen ist. Sobald dies der Fall ist, schreibt der Server die Ergebnisantwort für die Übertragung in die Verbindung und schließt diese anschließend.

**::ftp::Cd** *handle* *directory*
: Dieser Befehl ändert das aktuelle Arbeitsverzeichnis auf dem FTP-Server in ein festgelegtes Ziel-*directory*. Der Befehl gibt den Wert 1 zurück, wenn das aktuelle Arbeitsverzeichnis erfolgreich in das festgelegte Verzeichnis geändert wurde, oder den Wert 0, falls der Vorgang fehlschlägt. Das festgelegte Verzeichnis kann

    - ein Unterverzeichnis des aktuellen Verzeichnisses,

    - Zwei Punkte, **..**  (als Kennzeichnung für das übergeordnete Verzeichnis des aktuellen Verzeichnisses)

    - oder einen vollqualifizierten Pfad zu einem neuen Verzeichnis.


**::ftp::Pwd** *handle*
: Dieser Befehl gibt den vollständigen Pfad des aktuellen Arbeitsverzeichnisses auf dem FTP-Server zurück oder im Fehlerfall eine leere Zeichenfolge.

**::ftp::Type** *handle* ?**ascii|binary|tenex**?
: Dieser Befehl legt den FTP-Dateiübertragungstyp entweder auf **ascii**, **binary** oder **tenex** fest. Der Befehl gibt stets den aktuell eingestellten Typ zurück. Wird er ohne Angabe eines Typs aufgerufen, erfolgt keine Änderung.

    Derzeit werden nur die Typen **ascii** und **binary** unterstützt. Es besteht eine vorläufige (Alpha-)Unterstützung für den Tenex-Modus. Der Typ **ascii** wird normalerweise verwendet, um Textdateien in ein Format zu konvertieren, das für Texteditoren auf der Plattform des Zielrechners geeignet ist. Dies betrifft hauptsächlich Zeilenendezeichen. Der Typ **binary** hingegen ermöglicht die unverfälschte Übertragung von Nicht-Text-Dateien, wie beispielsweise komprimierte Dateien, Bilder und ausführbare Dateien.

**::ftp::List** *handle* ?*pattern*?
: Dieser Befehl gibt eine für Menschen lesbare Liste von Dateien zurück. Platzhalterausdrücke wie „*\*.tcl*“ sind zulässig.  Wenn *pattern* auf ein bestimmtes Verzeichnis verweist, gibt der Befehl den Inhalt dieses Verzeichnisses zurück. Ist *pattern* kein vollständig qualifizierter Pfadname, listet der Befehl Einträge relativ zum aktuellen Remote-Verzeichnis auf. Wird kein *pattern* festgelegt, gibt der Befehl den Inhalt des aktuellen Remote-Verzeichnisses zurück.

    Die Auflistung enthält alle systemabhängigen Informationen, die der Server bereitstellt. Beispielsweise erzeugen die meisten UNIX-Systeme eine Ausgabe des Befehls **ls -l**. Der Befehl gibt die abgerufenen Informationen als TCL-Liste mit einem Element pro Eintrag zurück. Leere Zeilen und die „Total“-Zeilen von UNIX werden ignoriert und nicht in das von diesem Befehl ausgegebene Ergebnis aufgenommen.

    Wenn der Befehl fehlschlägt, wird eine leere Liste zurückgegeben.

**::ftp::NList** *handle* ?*directory*?
: Dieser Befehl verhält sich genauso wie der Befehl **::ftp::List**, mit dem Unterschied, dass er lediglich eine gekürzte Auflistung gibt. Das bedeutet, dass in einer sortierten Liste ausschließlich Dateinamen angezeigt werden.

**::ftp::FileSize** *handle* *file*
: Dieser Befehl gibt die Größe der angegebenen *file* auf dem FTP-Server zurück. Wenn der Befehl fehlschlägt, wird eine leere Zeichenkette zurückgegeben.

    *ACHTUNG!* Im ASCII-Modus funktioniert dieser Befehl nicht ordnungsgemäß und wird nicht von allen FTP-Server-Implementierungen unterstützt.

**::ftp::ModTime** *handle* *file*
: Dieser Befehl ruft den Zeitpunkt der letzten Änderung der *file* auf dem FTP-Server als systemabhängigen Ganzzahlwert in Sekunden ab oder gibt eine leere Zeichenkette zurück, wenn ein Fehler aufgetreten ist. Verwenden Sie den integrierten Befehl **clock**, um den abgerufenen Wert in andere Formate zu konvertieren.

**::ftp::Delete** *handle* *file*
: Dieser Befehl löscht die angegebene *file* auf dem FTP-Server. Der Befehl gibt den Wert 1 zurück, wenn die angegebene Datei erfolgreich gelöscht wurde, bzw. den Wert 0, wenn der Vorgang fehlgeschlagen ist.

**::ftp::Rename** *handle* *from* *to*
: Dieser Befehl benennt die Datei *from* im aktuellen Verzeichnis des FTP-Servers in den angegebenen neuen Dateinamen *to* um. Dieser neue Dateiname darf nicht mit einem bereits vorhandenen Unterverzeichnis oder Dateinamen übereinstimmen. Der Befehl gibt den Wert 1 zurück, wenn die angegebene Datei erfolgreich umbenannt wurde, oder den Wert 0, wenn der Vorgang fehlgeschlagen ist.

**::ftp::Put** *handle* (*local* | -data *data* | -channel *chan*) ?*remote*?
: Dieser Befehl überträgt eine lokale Datei *local* in eine Remote-Datei *remote* auf dem FTP-Server. Wenn es sich bei den an den Befehl übergebenen Dateiparametern nicht um vollständig qualifizierte Pfadnamen handelt, verwendet der Befehl das aktuelle Verzeichnis auf dem lokalen und dem Remote-Host. Wenn der Name der Remote-Datei nicht angegeben ist, verwendet der Server den Namen der lokalen Datei als Namen der Remote-Datei. Der Befehl gibt 1 zurück, um eine erfolgreiche Übertragung anzuzeigen, und 0 im Falle eines Fehlers.

    Wenn anstelle einer lokalen Datei **-data** *data* festgelegt wird, überträgt das System keine Datei, sondern die an den Befehl übergebenen *data*. In diesem Fall muss der Name der Remote-Datei festgelegt werden.

    Wenn anstelle einer lokalen Datei „**-channel** *chan*“ festgelegt wird, überträgt das System keine Datei, sondern liest den Inhalt des Kanals *chan* und schreibt diesen in die Remote-Datei. In diesem Fall muss der Name der Remote-Datei festgelegt werden. Nach der Übertragung wird *chan* geschlossen.

**::ftp::Append** *handle* (*local* | -data *data* | -channel *chan*) ?*remote*?
: Dieser Befehl verhält sich wie **::ftp::Puts**, fügt die übertragenen Informationen jedoch an die Remote-Datei an. Wenn die Datei auf dem Server noch nicht existierte, wird sie angelegt.

**::ftp::Get** *handle* *remote* ?(*local* | -variable *varname* | -channel *chan*)?
: Dieser Befehl ruft eine Remote-Datei *remote* auf dem FTP-Server ab und speichert deren Inhalt in der lokalen Datei *local*. Wenn die an den Befehl übergebenen Dateiparameter keine vollständig qualifizierten Pfadnamen sind, verwendet der Befehl das aktuelle Verzeichnis auf dem lokalen und dem Remote-Host. Wird der Name der lokalen Datei nicht angegeben, verwendet der Server den Namen der Remote-Datei als Namen der lokalen Datei. Der Befehl gibt 1 zurück, um eine erfolgreiche Übertragung anzuzeigen, und 0 im Falle eines Fehlers. Der Befehl löst einen Fehler aus, wenn das Verzeichnis, in dem die Datei *local* platziert werden soll, nicht existiert.

    Wenn **-variable** *varname* festgelegt wird, speichert das System die abgerufenen Daten in der Variablen *varname* anstelle einer Datei.

    Wenn **-channel** *chan* festgelegt wird, schreibt das System die abgerufenen Daten anstelle einer Datei in den Kanal *chan*. Das System schließt *chan* nach der Übertragung *nicht*; dies liegt in der Verantwortung des Aufrufers von **::ftp::Get**.

**::ftp::Reget** *handle* *remote* ?*local*? ?*from*? ?*to*?
: Dieser Befehl verhält sich wie **::ftp::Get**, mit dem Unterschied, dass, wenn die lokale Datei *local* vorhanden und kleiner als die Remote-Datei *remote* ist, davon ausgegangen wird, dass es sich bei der lokalen Datei um eine teilweise übertragene Kopie der Remote-Datei handelt, und die Übertragung an der Stelle fortgesetzt wird, an der der Fehler offenbar aufgetreten ist.  Der Befehl löst einen Fehler aus, wenn das Verzeichnis, in dem die Datei *local* platziert werden soll, nicht existiert. Dieser Befehl ist nützlich bei der Übertragung sehr großer Dateien über Netzwerke, bei denen es häufig zu Verbindungsabbrüchen kommt.

    Durch die Angabe der zusätzlichen Byte-Offsets *from* und *to* ändert der Befehl sein Verhalten und lädt genau den angegebenen Ausschnitt der Remote-Datei herunter. Dieser Modus ist nur möglich, wenn ein lokales Ziel explizit angegeben wird. Wird *to* weggelassen, wird bis zum Dateiende heruntergeladen.

**::ftp::Newer** *handle* *remote* ?*local*?
: Dieser Befehl verhält sich wie **::ftp::Get**, mit dem Unterschied, dass er die Remote-Datei nur dann abruft, wenn der Änderungszeitstempel der Remote-Datei aktueller ist als der der Datei auf dem lokalen System. Existiert die Datei auf dem lokalen System nicht, wird die Remote-Datei als neuer angesehen. Der Befehl löst einen Fehler aus, wenn das Verzeichnis, in dem die Datei *local* abgelegt werden soll, nicht existiert.

**::ftp::MkDir** *handle* *directory*
: Dieser Befehl erstellt das angegebene *directory* auf dem FTP-Server. Wenn der angegebene Pfad relativ ist, wird das neue Verzeichnis als Unterverzeichnis des aktuellen Arbeitsverzeichnisses angelegt. Andernfalls erhält das erstellte Verzeichnis den angegebenen Pfadnamen. Der Befehl gibt den Wert 1 zurück, um die erfolgreiche Erstellung des Verzeichnisses anzuzeigen, und den Wert 0 im Falle eines Fehlers.

**::ftp::RmDir** *handle* *directory*
: Dieser Befehl löscht das angegebene Verzeichnis auf dem FTP-Server. Das Remote-Verzeichnis muss leer sein, andernfalls schlägt der Befehl fehl. Der Befehl gibt den Wert 1 zurück, um eine erfolgreiche Löschung des Verzeichnisses anzuzeigen, und den Wert 0 im Falle eines Fehlers.

**::ftp::Quote** *handle* *arg1* *arg2* *...*
: Dieser Befehl dient dazu, einen beliebigen FTP-Befehl an den Server zu senden. Er kann nicht zum Abrufen einer Verzeichnisauflistung oder zur Übertragung von Dateien verwendet werden. Er ist enthalten, damit eine Anwendung Befehle auf dem FTP-Server ausführen kann, die von diesem Paket nicht bereitgestellt werden. Die Argumente werden wörtlich, d. h. unverändert, an den Server gesendet.

    Im Gegensatz zu den anderen Befehlen in diesem Paket wertet dieser Befehl die vom FTP-Server erhaltene Antwort nicht aus, sondern gibt sie unverändert an den Aufrufer zurück.

**::ftp::DisplayMsg** *handle* *msg* ?*state*?
: Dieser Befehl wird vom Paket selbst verwendet, um die verschiedenen Meldungen aus den FTP-Sitzungen anzuzeigen. Das Paket selbst implementiert diesen Befehl sehr einfach, indem es die Meldungen in „**stdout**“ schreibt (wenn „**::ftp::VERBOSE**“ gesetzt wurde, siehe unten) und bei Fehlermeldungen TCL-Fehler auslöst. Es liegt in der Verantwortung der Anwendung, diesen Befehl bei Bedarf zu überschreiben. Der Autor empfiehlt die Verwendung einer Variablen für verschiedene Zustände, denen unterschiedliche Farben zugewiesen sind. Das Paket **log** ist hierfür nützlich.

**::ftp::VERBOSE**
: Eine Variable, die die Ausgabe des Pakets steuert. Wenn Sie **::ftp::VERBOSE** auf „1“ setzen, wird das Paket dazu veranlasst, alle Antworten eines Remote-Servers anzuzeigen. Der Standardwert ist „0“.

**::ftp::DEBUG**
: Eine Statusvariable, die die Ausgabe von ftp steuert. Wenn Sie **::ftp::DEBUG** auf „1“ setzen, wird das Debugging aktiviert und das Paket wird dazu veranlasst, alle Rückgabecodes, Zustände, Zustandsänderungen und „echte“ FTP-Befehle anzuzeigen. Der Standardwert ist „0“.


# Bugs

Die korrekte Ausführung vieler Befehle hängt vom ordnungsgemäßen Verhalten des Remote-Servers sowie von der Netzwerk- und Router-Konfiguration ab.

Ein in der Prozedur **::ftp::DisplayMsg** platzierter Update-Befehl kann zu hartnäckigen Fehlern oder Endlosschleifen führen. Die Lösung besteht darin, **update idletasks** anstelle von **update** zu verwenden.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *ftp* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk
