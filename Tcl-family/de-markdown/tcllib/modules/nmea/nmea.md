---
CommandName: nmea
ManualSection: n
Version: 1.1.0
TclPart: tcllib
TclDescription: NMEA protocol implementation
Keywords:
 - gps
 - nmea
Copyright:
 - Copyright (c) 2006-2009, Aaron Faupell <afaupell@users.sourceforge.net>
---

# NAME

nmea – NMEA-Daten verarbeiten

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [nmea]{.lit} [1.1.0]{.optlit} 
[::nmea::input]{.cmd} [sentence]{.arg} 
[::nmea::open_port]{.cmd} [port]{.arg} [speed]{.optarg} 
[::nmea::close_port]{.cmd} 
[::nmea::configure_port]{.cmd} [settings]{.arg} 
[::nmea::open_file]{.cmd} [file]{.arg} [rate]{.optarg} 
[::nmea::close_file]{.cmd} 
[::nmea::do_line]{.cmd} 
[::nmea::rate]{.cmd} 
[::nmea::log]{.cmd} [file]{.optarg} 
[::nmea::checksum]{.cmd} [data]{.arg} 
[::nmea::write]{.cmd} [sentence]{.arg} [data]{.arg} 
[::nmea::event]{.cmd} [setence]{.arg} [command]{.optarg} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine einheitliche Schnittstelle bereit, um Software zu schreiben, die Eingaben nach dem NMEA-Standard empfängt. Daten kommen von COM-Schnittstellen, aus Dateien oder aus dem Programm. Es bildet Prüfsummen und protokolliert eingehende Daten. Nach dem Parsen gehen die Eingaben an vom Benutzer festgelegte Handler-Befehle. Einen Handler legt der Befehl **event** fest. Das Paket enthält keine GPS-spezifischen Funktionen. NMEA-Daten bestehen aus einem Satztyp und einer darauffolgenden Datenliste.

# BEFEHLE

**::nmea::input** *sentence*
: Verarbeitet den übergebenen Satz und gibt ihn weiter. Enthält *sentence* keine Kommas, gilt er als Tcl-Liste. Sonst müssen es die üblichen, durch Kommas getrennten NMEA-Daten sein, mit optionaler Prüfsumme und vorangestelltem **\$**.


```
nmea::input {$GPGSA,A,3,04,05,,09,12,,,24,,,,,2.5,1.3,2.1*39}
nmea::input [list GPGSA A 3 04 05  09 12 "" "" 24 "" "" ""  2.5 1.3 2.1]
```

**::nmea::open_port** *port* ?speed?
: Öffnet die angegebene COM-Schnittstelle und liest NMEA-Sätze, sobald welche anliegen. Die Geschwindigkeit ist 4800 bps oder *speed*.

**::nmea::close_port**
: Schließt die COM-Verbindung, wenn eine offen ist.

**::nmea::configure_port** *settings*
: Ändert die aktuellen Porteinstellungen. *settings* hat dasselbe Format wie fconfigure -mode.

**::nmea::open_file** *file* ?rate?
: Öffnet die Datei *file* und liest NMEA-Sätze, einen je Zeile, im Abstand von *rate* Millisekunden. Das Dateiformat darf das vorangestellte **\$** und die Prüfsumme weglassen. Ist *rate* <= 0 (die Vorgabe), werden Zeilen nur verarbeitet, wenn **do_line** aufgerufen wird.

**::nmea::close_file**
: Schließt die offene Datei, falls eine vorhanden ist.

**::nmea::do_line**
: Wenn derzeit eine Datei geöffnet ist, liest dieser Befehl eine einzelne Zeile daraus und verarbeitet sie. Gibt die Anzahl der gelesenen Zeilen zurück.

**::nmea::rate**
: Legt fest, in welchem Abstand in Millisekunden Zeilen aus der offenen Datei verarbeitet werden. Der Abstand gilt über Dateien hinweg; es muss keine Datei offen sein. 0 schaltet die automatische Zeilenverarbeitung aus.

**::nmea::log** ?file?
: Startet oder beendet die Protokollierung der Eingabe. Ist ein Dateiname angegeben, werden alle an der offenen Schnittstelle empfangenen NMEA-Daten im Anhängemodus in *file* geschrieben. Ist *file* eine leere Zeichenkette, endet die Protokollierung. Ohne Datei gibt der Befehl einen booleschen Wert zurück, ob die Protokollierung gerade läuft. Daten, die **write** an die Schnittstelle schreibt, Daten aus Dateien und Eingaben über **input** werden nicht protokolliert.

**::nmea::checksum** *data*
: Gibt die Prüfsumme der übergebenen Daten zurück.

**::nmea::write** *sentence* *data*
: Wenn derzeit ein Port geöffnet ist, schreibt dieser Befehl den angegebenen Satz und die Daten im korrekten NMEA-Format mit Prüfsumme an den Port.

**::nmea::event** *setence* ?command?
: Registriert eine Handler-Prozedur für einen gegebenen NMEA-*sentence*. Je Satz gibt es höchstens einen Handler; ein vorhandener wird ersetzt. Ohne Befehl gibt er den Namen des aktuellen Handlers für den gegebenen *setence* zurück, oder eine leere Zeichenkette, wenn keiner existiert. Neben den eingehenden Sätzen gibt es zwei eingebaute Typen, EOF und DEFAULT. Der Handler für den DEFAULT-*setence* läuft, wenn es für diesen Satz keinen eigenen Handler gibt. Der EOF-Handler läuft, wenn an der offenen Datei oder Schnittstelle das Dateiende erreicht ist. Die Handler-Prozeduren, mit Ausnahme der eingebauten Typen, müssen genau ein Argument nehmen, eine Liste der Datenwerte. Der DEFAULT-Handler soll zwei Argumente haben, den Satztyp und die Datenwerte. Der EOF-Handler hat keine Argumente.


```
nmea::event gpgsa parse_sat_detail
nmea::event default handle_unknown

proc parse_sat_detail {data} {
    puts [lindex $data 1]
}

proc handle_unknown {name data} {
    puts "unknown data type $name"
}
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *nmea* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2006-2009, Aaron Faupell <afaupell@users.sourceforge.net>
```
