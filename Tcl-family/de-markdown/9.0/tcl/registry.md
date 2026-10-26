---
CommandName: registry
title: registry
ManualSection: n
Version: 1.1
TclPart: registry
TclDescription: Tcl Bundled Packages
Keywords:
 - registry
Copyright:
 - Copyright (c) 1997 Sun Microsystems, Inc.
 - Copyright (c) 2002 ActiveState Corporation.
---

# Name

registry - Windows-Registrierung manipulieren

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [registry]{.lit} [1.3]{.lit}

[registry]{.cmd} [-mode]{.optarg} [option]{.arg} [keyName]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Das Paket **registry** stellt einen allgemeinen Satz von Operationen zum Manipulieren der Windows-Registrierung bereit. Das Paket implementiert den Tcl-Befehl **registry**. Dieser Befehl wird nur auf der Windows-Plattform unterstützt. Warnung: Dieser Befehl sollte mit Vorsicht verwendet werden, da eine beschädigte Registrierung das System unbrauchbar machen kann.

*KeyName* ist der Name eines Registrierungsschlüssels. Registrierungsschlüssel müssen eine der folgenden Formen haben:

**\\\\**_hostname_**\\**_rootname_**\\**_keypath_

*rootname*__\\__*keypath*

*rootname*

*Hostname* gibt den Namen eines beliebigen gültigen Windows-Hosts an, der seine Registrierung exportiert. Die Komponente *rootname* muss eine von **HKEY\_LOCAL\_MACHINE**, **HKEY\_USERS**, **HKEY\_CLASSES\_ROOT**, **HKEY\_CURRENT\_USER**, **HKEY\_CURRENT\_CONFIG**, **HKEY\_PERFORMANCE\_DATA** oder **HKEY\_DYN\_DATA** sein. Der *keypath* kann aus einem oder mehreren Registrierungsschlüsselnamen bestehen, die durch Backslash-Zeichen (**\\**) getrennt sind.

Das optionale Argument *-mode* gibt an, mit welcher Registrierung gearbeitet werden soll; bei **-32bit** wird die 32-Bit-Registrierung verwendet, bei **-64bit** die 64-Bit-Registrierung. Wenn dieses Argument weggelassen wird, ist die Standard-Registrierung des Systems Gegenstand der angeforderten Operation.

*Option* gibt an, was mit dem Registrierungsschlüsselnamen geschehen soll. Jede eindeutige Abkürzung für *option* ist zulässig. Die gültigen Optionen sind:

[registry]{.cmd} [broadcast]{.sub} [keyName]{.arg} [[-timeout]{.lit} [milliseconds]{.arg}]{.optarg}
: Sendet eine Broadcast-Nachricht an das System und laufende Programme, um sie über bestimmte Aktualisierungen zu informieren. Dies ist notwendig, um Änderungen an wichtigen Registrierungsschlüsseln wie Environment zu propagieren. Der Timeout gibt die Wartezeit in Millisekunden an, bis Anwendungen auf die Broadcast-Nachricht reagieren. Standardwert ist 3000. Das folgende Beispiel zeigt, wie ein Pfad zur globalen Umgebungsvariable hinzugefügt und Anwendungen über die Änderung informiert werden kann, ohne Ab- und Anmelden zu erfordern (setzt Administratorrechte voraus):

    ```
    set regPath [join {
        HKEY_LOCAL_MACHINE
        SYSTEM
        CurrentControlSet
        Control
        {Session Manager}
        Environment
    } "\\"]
    set curPath [registry get $regPath "Path"]
    registry set $regPath "Path" "$curPath;$addPath"
    registry broadcast "Environment"
    ```

[registry]{.cmd} [delete]{.sub} [keyName]{.arg} [valueName]{.optarg}
: Wenn das optionale Argument *valueName* angegeben ist, wird der angegebene Wert unter *keyName* aus der Registrierung gelöscht. Wenn das optionale *valueName* weggelassen wird, werden der angegebene Schlüssel sowie alle Unterschlüssel oder Werte darunter in der Registrierungshierarchie gelöscht. Wenn der Schlüssel nicht gelöscht werden konnte, wird ein Fehler erzeugt. Wenn der Schlüssel nicht existierte, hat der Befehl keine Wirkung.

[registry]{.cmd} [get]{.sub} [keyName]{.arg} [valueName]{.arg}
: Gibt die mit dem Wert *valueName* unter dem Schlüssel *keyName* verknüpften Daten zurück. Wenn entweder der Schlüssel oder der Wert nicht existiert, wird ein Fehler erzeugt. Weitere Details zum Format der zurückgegebenen Daten siehe [Unterstützte Typen] weiter unten.

[registry]{.cmd} [keys]{.sub} [keyName]{.arg} [pattern]{.optarg}
: Wenn *pattern* nicht angegeben ist, gibt eine Liste der Namen aller Unterschlüssel von *keyName* zurück. Wenn *pattern* angegeben ist, werden nur die Namen zurückgegeben, die auf *pattern* passen. Die Übereinstimmung wird nach denselben Regeln wie bei [string match][string] bestimmt. Wenn der angegebene *keyName* nicht existiert, wird ein Fehler erzeugt.

[registry]{.cmd} [set]{.sub} [keyName]{.arg} [valueName data ?type]{.optarg}
: Wenn *valueName* nicht angegeben ist, wird der Schlüssel *keyName* erstellt, falls er noch nicht existiert. Wenn *valueName* angegeben ist, werden der Schlüssel *keyName* und der Wert *valueName* bei Bedarf erstellt. Der Inhalt von *valueName* wird auf *data* mit dem durch *type* angegebenen Typ gesetzt. Wenn *type* nicht angegeben ist, wird der Typ **sz** angenommen. Weitere Details zu den Argumenten *data* und *type* siehe [Unterstützte Typen] weiter unten.

[registry]{.cmd} [type]{.sub} [keyName]{.arg} [valueName]{.arg}
: Gibt den Typ des Werts *valueName* im Schlüssel *keyName* zurück. Weitere Informationen zu den möglichen Typen siehe [Unterstützte Typen] weiter unten.

[registry]{.cmd} [values]{.sub} [keyName]{.arg} [pattern]{.optarg}
: Wenn *pattern* nicht angegeben ist, gibt eine Liste der Namen aller Werte von *keyName* zurück. Wenn *pattern* angegeben ist, werden nur die Namen zurückgegeben, die auf *pattern* passen. Die Übereinstimmung wird nach denselben Regeln wie bei [string match][string] bestimmt.


# Unterstützte Typen

Jeder Wert unter einem Schlüssel in der Registrierung enthält Daten eines bestimmten Typs in einer typspezifischen Darstellung. Der Befehl **registry** konvertiert zwischen dieser internen Darstellung und einer, die von Tcl-Skripten manipuliert werden kann. In den meisten Fällen werden die Daten einfach als Tcl-String zurückgegeben. Der Typ gibt die beabsichtigte Verwendung der Daten an, ändert aber nicht die Darstellung selbst. Für einige Typen gibt der Befehl **registry** die Daten in einer anderen Form zurück, um die Manipulation zu erleichtern. Die folgenden Typen werden vom Befehl **registry** erkannt:

[binary]
: Der Registrierungswert enthält beliebige Binärdaten. Die Daten werden in Tcl exakt dargestellt, einschließlich eingebetteter Nullen.

**none**
: Der Registrierungswert enthält beliebige Binärdaten ohne definierten Typ. Die Daten werden in Tcl exakt dargestellt, einschließlich eingebetteter Nullen.

**sz**
: Der Registrierungswert enthält eine nullterminierte Zeichenkette. Die Daten werden in Tcl als String dargestellt.

**expand\_sz**
: Der Registrierungswert enthält eine nullterminierte Zeichenkette mit nicht expandierten Verweisen auf Umgebungsvariablen im üblichen Windows-Stil (zum Beispiel „%PATH%“). Die Daten werden in Tcl als String dargestellt.

**dword**
: Der Registrierungswert enthält eine 32-Bit-Zahl in Little-Endian-Darstellung. Die Daten werden in Tcl als Dezimalstring dargestellt.

**dword\_big\_endian**
: Der Registrierungswert enthält eine 32-Bit-Zahl in Big-Endian-Darstellung. Die Daten werden in Tcl als Dezimalstring dargestellt.

[link]
: Der Registrierungswert enthält einen symbolischen Link. Die Daten werden in Tcl exakt dargestellt, einschließlich eingebetteter Nullen.

**multi\_sz**
: Der Registrierungswert enthält ein Array nullterminierter Zeichenketten. Die Daten werden in Tcl als Liste von Strings dargestellt.

**resource\_list**
: Der Registrierungswert enthält eine Gerätetreiber-Ressourcenliste. Die Daten werden in Tcl exakt dargestellt, einschließlich eingebetteter Nullen.


Zusätzlich zu den oben symbolisch benannten Typen werden unbekannte Typen durch eine 32-Bit-Ganzzahl identifiziert, die dem von den System-Schnittstellen zurückgegebenen Typcode entspricht. In diesem Fall werden die Daten in Tcl exakt dargestellt, einschließlich eingebetteter Nullen.

# Portabilität

Der Befehl **registry** ist nur unter Windows verfügbar.

# Beispiele

Gibt aus, wie durch Doppelklick auf eine Tcl-Skriptdatei ein Tcl-Interpreter aufgerufen wird:

```
package require registry
set ext .tcl

# Typnamen lesen
set type [registry get HKEY_CLASSES_ROOT\\$ext {}]
# Ermitteln, wo der Befehl zu finden ist
set path HKEY_CLASSES_ROOT\\$type\\Shell\\Open\\command
# Befehl lesen!
set command [registry get $path {}]

puts "$ext opens with $command"
```


[binary]: binary.md
[link]: link.md
[string]: string.md
