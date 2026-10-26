---
CommandName: nettool
title: nettool
ManualSection: n
Version: 0.5.4
TclPart: tcllib
TclDescription: nettool
Keywords:
 - nettool
 - odie
Copyright:
 - Copyright (c) 2015-2018 Sean Woods <yoda@etoyoc.com>
---

# Name

nettool – Werkzeuge für vernetzte Anwendungen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [nettool]{.lit} [0.5.4]{.optlit}
[package]{.cmd} [require]{.sub} [twapi]{.lit} [3.1]{.lit}
[package]{.cmd} [require]{.sub} [ip]{.lit} [0.2]{.lit}
[package]{.cmd} [require]{.sub} [platform]{.lit} [0.2]{.lit}
[::cat]{.cmd} [filename]{.arg}
[::nettool::allocate\_port]{.cmd} [startingport]{.arg}
[::nettool::arp\_table]{.cmd}
[::nettool::broadcast\_list]{.cmd}
[::nettool::claim\_port]{.cmd} [port]{.arg} [protocol]{.optarg}
[::nettool::cpuinfo]{.cmd} [args]{.arg}
[::nettool::find\_port]{.cmd} [startingport]{.arg}
[::nettool::hwid\_list]{.cmd}
[::nettool::ip\_list]{.cmd}
[::nettool::mac\_list]{.cmd}
[::nettool::network\_list]{.cmd}
[::nettool::port\_busy]{.cmd} [port]{.arg}
[::nettool::release\_port]{.cmd} [port]{.arg} [protocol]{.optarg}
[::nettool::status]{.cmd}
[::nettool::user\_data\_root]{.cmd} [appname]{.arg}
:::

# Beschreibung

Das Paket **nettool** ist eine Sammlung von Werkzeugen in reinem Tcl. Sie führen gängige Netzwerkfunktionen über eine einheitliche Tcl-Schnittstelle aus, für die sonst verschiedene Pakete oder Aufrufe von exec nötig wären. Derzeit hat nettool Referenzimplementierungen für Windows, MacOSX und Linux (debian).

# Befehle

**::cat** *filename*
: Gibt den Inhalt einer Datei als Ergebnis zurück.

**::nettool::allocate\_port** *startingport*
: Versucht, *startingport* zu belegen. Ist der Port belegt, wird die Portnummer der Reihe nach erhöht, bis ein freier Port gefunden ist, und dieser Port wird belegt. Der Befehl nutzt eine eingebaute Datenbank bekannter Ports, damit er keinen Port zurückgibt, der häufig verwendet wird. (Beispiel: http (80))

**::nettool::arp\_table**
: Gibt den Inhalt der ARP-Tabelle (Address Resolution Protocol) dieses Rechners zurück. Das Ergebnis ist eine Liste im Tcl-Format: *macid* *ipaddrlist* ...

**::nettool::broadcast\_list**
: Gibt eine Liste der Broadcast-Adressen (geeignet für UDP-Multicast) zurück, denen dieser Computer zugeordnet ist.

**::nettool::claim\_port** *port* ?*protocol*?
: Markiert *port* als belegt, wahlweise als **tcp** (Vorgabe) oder als **udp**.

**::nettool::cpuinfo** *args*
: Ohne Argumente gibt der Befehl eine Schlüssel-Wert-Liste zurück, die die CPU des aktuellen Rechners beschreibt. Darin stehen die Zahl der Kerne oder Prozessoren für parallele Aufgaben, der eingebaute physische Arbeitsspeicher und die Prozessorfamilie.

    Der genaue Inhalt hängt von der Plattform ab.

    Unter Linux stammen die Angaben aus /proc/cpuinfo und /proc/meminfo.

    Unter MacOSX stammen sie aus sysctl.

    Unter Windows stammen sie aus TWAPI.

    Mit Argumenten ist das Ergebnis eine Schlüssel-Wert-Liste, beschränkt auf die angeforderten Felder.

    Die auf allen Plattformen üblichen Felder:

    cpus
    : Anzahl der CPUs/Kerne/Ausführungseinheiten

    speed
    : Taktfrequenz des/der Prozessoren in MHz

    memory
    : Installierter Arbeitsspeicher (in MB)

    vendor
    : Hersteller


**::nettool::find\_port** *startingport*
: Gibt *startingport* zurück, wenn dieser frei ist, sonst den nächsten freien Port nach *startingport*. Anders als **::nettool::allocate\_port** belegt dieser Befehl den Port nicht.

    Er nutzt eine eingebaute Datenbank bekannter Ports, damit er keinen Port zurückgibt, der häufig verwendet wird. (Beispiel: http (80))

**::nettool::hwid\_list**
: Gibt eine Liste hardwarespezifischer Kennungen dieses Rechners zurück. Quelle und Inhalt hängen von der Plattform ab.

    Unter MacOSX kommen die Seriennummer der Hauptplatine und die MAC-IDs aller Netzwerkgeräte zurück.

    Unter Windows kommen die Volume-Seriennummer von C und die MAC-IDs aller Netzwerkgeräte zurück.

    Unter Linux kommen die MAC-IDs aller Netzwerkgeräte zurück.

**::nettool::ip\_list**
: Gibt eine Liste der diesem Rechner zugeordneten IP-Adressen zurück.

**::nettool::mac\_list**
: Gibt eine Liste der MAC-IDs der Netzwerkkarten dieses Rechners zurück. Die MAC-ID der primären Netzwerkkarte steht an erster Stelle.

**::nettool::network\_list**
: Gibt eine Liste der mit diesem Rechner verbundenen Netzwerke zurück. Die Netzwerke sind mit **ip::nativeToPrefix** formatiert.

**::nettool::port\_busy** *port*
: Gibt true zurück, wenn *port* belegt ist, sonst false.

**::nettool::release\_port** *port* ?*protocol*?
: Markiert *port* als nicht belegt, wahlweise als **tcp** (Vorgabe) oder als **udp**.

**::nettool::status**
: Gibt eine Schlüssel-Wert-Liste zurück, die den Status des Rechners beschreibt. Die Ausgabe ist so angelegt, dass sie auf allen Plattformen mit der Ausgabe von **top** vergleichbar ist.

    Übliche Felder sind:

    load
    : Prozesse pro Verarbeitungseinheit

    memory\_total
    : Physischer Arbeitsspeicher insgesamt (MB)

    memory\_free
    : Ungenutzter physischer Arbeitsspeicher (MB)


**::nettool::user\_data\_root** *appname*
: Gibt einen vollständigen Pfad zu einem Ordner zurück, in dem *appname* seine Daten ablegen soll. Der Befehl legt den Pfad nicht an, er berechnet ihn nur.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *odie* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

System

# Copyright

```
Copyright (c) 2015-2018 Sean Woods <yoda@etoyoc.com>
```
