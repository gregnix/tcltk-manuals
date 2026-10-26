---
CommandName: ntp_time
ManualSection: n
Version: 1.2.2
TclPart: tcllib
TclDescription: Network Time Facilities
Links:
 - ntp
Keywords:
 - NTP
 - SNTP
 - rfc 2030
 - rfc 868
 - time
Copyright:
 - Copyright (c) 2002, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# NAME

ntp_time – Tcl-Zeitdienst-Client

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [time]{.lit} [1.2.2]{.optlit} 
[::time::gettime]{.cmd} [options]{.optarg} [timeserver]{.arg} [port]{.optarg} 
[::time::getsntp]{.cmd} [options]{.optarg} [timeserver]{.arg} [port]{.optarg} 
[::time::configure]{.cmd} [options]{.optarg} 
[::time::cget]{.cmd} [name]{.arg} 
[::time::unixtime]{.cmd} [token]{.arg} 
[::time::status]{.cmd} [token]{.arg} 
[::time::error]{.cmd} [token]{.arg} 
[::time::reset]{.cmd} [token]{.arg} [reason]{.optarg} 
[::time::wait]{.cmd} [token]{.arg} 
[::time::cleanup]{.cmd} [token]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket implementiert einen Client für das RFC 868 TIME-Protokoll (*http://www.rfc-editor.org/rfc/rfc868.txt*) sowie einen Minimal-Client für das RFC 2030 Simple Network Time Protocol (*http://www.rfc-editor.org/rfc/rfc2030.txt*). RFC 868 gibt die Zeit in Sekunden seit dem 1. Januar 1900 entweder an TCP- oder an UDP-Clients zurück. RFC 2030 liefert ebenfalls diese Zeit, dazu einen Bruchteil, den dieser Client nicht verwendet.

# BEFEHLE

**::time::gettime** ?*options*? *timeserver* ?*port*?
: Holt die Zeit von *timeserver*. Hier dürfen die Optionen stehen, die der Befehl **configure** kennt. Der Befehl gibt ein Token zurück; die übrigen Befehle dieses Pakets brauchen es. Danach gibt **cleanup** alle Ressourcen frei. Der voreingestellte Port ist **37**.

**::time::getsntp** ?*options*? *timeserver* ?*port*?
: Holt die Zeit von einem SNTP-Server. Dieser Befehl akzeptiert genau dieselben Argumente wie **::time::gettime**, nur ist der voreingestellte Port **123**. Das Ergebnis ist ein Token wie bei **::time::gettime** und wird genauso verwendet. Es ist unwahrscheinlich, dass ein SNTP-Server über tcp antwortet; Sie brauchen dafür das Paket **tcludp** oder **ceptcl**. Lässt sich ein passendes Paket laden, wird standardmäßig udp verwendet.

**::time::configure** ?*options*?
: Ohne Argumente gibt dieser Befehl alle aktuellen Konfigurationsoptionen und ihre Werte zurück. Sonst ist er mit Paaren aus Optionsname und Wert aufzurufen.


**-protocol** *number*
: Legt das voreingestellte Netzwerkprotokoll fest. Voreingestellt ist udp, wenn das Paket tcludp verfügbar ist. Sonst wird tcp verwendet.

**-port** *number*
: Legt den voreingestellten Port fest. RFC 868 verwendet Port **37**, RFC 2030 Port **123**.

**-timeout** *number*
: Legt den voreingestellten Timeout in Millisekunden fest. Die Vorgabe ist 10 Sekunden.

**-command** *number*
: Legt eine Befehlsprozedur fest, die bei einer Antwort läuft. Die Prozedur wird aufgerufen, das Zeit-Token hängt an der Argumentliste.

**-loglevel** *number*
: Legt die Protokollierungsstufe fest. Die Vorgabe ist 'warning'.


**::time::cget** *name*
: Gibt den aktuellen Wert der benannten Konfigurationsoption zurück.

**::time::unixtime** *token*
: Formatiert die zurückgegebene Zeit für die Unix-Epoche. RFC 868 setzt den Zeitpunkt 0 auf den 1. Januar 1900, die Unix-Zeit setzt ihn auf den 1. Januar 1970. Dieser Befehl rechnet die Antwort in die Unix-Zeit um.

**::time::status** *token*
: Gibt das Statusflag zurück. Nach einer erfolgreich abgeschlossenen Abfrage ist es *ok*. Es kann auch *error*, *timeout* oder *eof* sein. Siehe auch **::time::error**

**::time::error** *token*
: Gibt die Fehlermeldung zu Anfragen mit dem Status *error* zurück. Liegt keine Fehlermeldung vor, kommt eine leere Zeichenkette zurück.

**::time::reset** *token* *?reason?*
: Setzt die Abfrage zurück oder bricht sie ab. Optional lässt sich der Grund angeben, den der Befehl **error** festhält.

**::time::wait** *token*
: Wartet, bis eine Abfrage abgeschlossen ist, und gibt danach den Status zurück.

**::time::cleanup** *token*
: Entfernt alle Zustandsvariablen, die zu der Anfrage gehören.


```
% set tok [::time::gettime ntp2a.mcc.ac.uk]
% set t [::time::unixtime $tok]
% ::time::cleanup $tok
```

```
% set tok [::time::getsntp pool.ntp.org]
% set t [::time::unixtime $tok]
% ::time::cleanup $tok
```

```
proc on_time {token} {
   if {[time::status $token] eq "ok"} {
      puts [clock format [time::unixtime $token]]
   } else {
      puts [time::error $token]
   }
   time::cleanup $token
}
time::getsntp -command on_time pool.ntp.org
```

# AUTOREN

Pat Thoyts

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *ntp* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2002, Pat Thoyts <patthoyts@users.sourceforge.net>
```
