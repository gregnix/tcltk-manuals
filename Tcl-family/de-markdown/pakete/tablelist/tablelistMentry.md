# Interaktive Bearbeitung von Tabellenzellen mit dem Mentry-Paket

## Für Tablelist Version 7.12

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Der Befehl tablelist::addDateMentry](#der-befehl-tablelist-adddatementry)
- [Der Befehl tablelist::addTimeMentry](#der-befehl-tablelist-addtimementry)
- [Der Befehl tablelist::addDateTimeMentry](#der-befehl-tablelist-adddatetimementry)
- [Der Befehl tablelist::addFixedPointMentry](#der-befehl-tablelist-addfixedpointmentry)
- [Der Befehl tablelist::addIPAddrMentry](#der-befehl-tablelist-addipaddrmentry)
- [Der Befehl tablelist::addIPv6AddrMentry](#der-befehl-tablelist-addipv6addrmentry)

[Startseite](index.md)

---

## Überblick

Das Multi-Entry-Paket „Mentry“ ist eine Bibliothek-Erweiterung für Tcl/Tk ab Version 8.4, die vollständig in Tcl/Tk geschrieben ist.  Es kann hier heruntergeladen werden:

https://www.nemethi.de

Ab Version 3.0 enthält die Mentry-Distribution nicht nur das Paket „Mentry“, sondern auch dessen kachelbasiertes Pendant „Mentry_tile“, das eine themenspezifische Darstellung der mentry-Widgets ermöglicht; dieses Paket erfordert Tcl/Tk 8.4 oder höher sowie Tile 0.6 oder höher.

Tablelist unterstützt die interaktive Bearbeitung von Zellen mithilfe von Mentry-Widgets der Typen `"Date"`, `"Time"`, `"DateTime`, `"FixedPoint"`, `"IPAddr"` und `"IPv6Addr"`.  Die erforderlichen Schritte zur Verwendung eines dieser Widgets für die Bearbeitung der Zellen einer bestimmten Spalte lauten wie folgt:

1. Registrieren Sie das gewünschte Widget für die interaktive Zellenbearbeitung, indem Sie einen der auf dieser Referenzseite beschriebenen Befehle aufrufen.
2. Verwenden Sie den Unterbefehl `columnconfigure` des Tablelist-Widgets, um die Option `-editable` der angegebenen Spalte auf „true“ und die Option `-editwindow` auf den vom oben genannten Befehl zurückgegebenen Wert zu setzen.  (Diese Optionen werden mithilfe des Unterbefehls `cellconfigure` auch auf Zellenebene unterstützt.)

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addDateMentry`

**NAME**
: `tablelist::addDateMentry` – Registrieren Sie das Mentry-Widget vom Typ `"Date"` für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addDateMentry format separator ?-gmt? ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das mit dem Befehl `mentry::dateMentry` aus dem Paket „Mentry“ (oder „Mentry_tile“) erstellte Widget für die interaktive Zellenbearbeitung in Tablelist-Widgets.  Die Argumente `format` und `separator` haben dieselbe Bedeutung wie im Befehl `mentry::dateMentry`.  Wenn das Argument `-gmt` vorhanden ist, werden sowohl der interne Uhrzeitwert als auch dessen externe Datumsdarstellung im Mentry-Widget als Greenwich-Zeit (GMT) angezeigt, andernfalls als Ortszeit.  Das zweite optionale Argument legt den Namen fest, der für das „mentry“-Widget als Wert der Spalten- oder Zellenkonfigurationsoption `-editwindow` verwendet werden soll. Es kann eine beliebige Zeichenkette sein, die sich von den Namen der Bearbeitungsfenster im [Tk-Kern](tablelistTkCore.md) und in [Tile](tablelistTile.md) unterscheidet. Der Standardwert ist `dateMentry`. Der Befehl gibt sein `name`-Argument zurück.

: Eine Spalte in einer Tablelist, deren Option `-editwindow` den oben genannten Wert `name` aufweist, muss als interne Zellenwerte Datumsangaben in Sekunden enthalten (die mithilfe eines Befehls angezeigt werden, der durch die Konfigurationsoption `-formatcommand` vorgegeben wird).  Der Unterbefehl `finishediting` des mit dem Tablelist-Widget verknüpften Tcl-Befehls ruft den Inhalt des eingebetteten Fensters ab, das für die interaktive Zellenbearbeitung verwendet wird, indem er den Befehl `mentry::getClockVal` aufruft.  Der von diesem Befehl zurückgegebene Wert (ein Zeitwert in Sekunden oder eine der Fehlerzeichenfolgen `"EMPTY"`, `"BAD"`, `"BAD_DATE"` oder `"BAD_YEAR"`) wird als letztes Argument an das Skript übergeben, das der Tablelist-Konfigurationsoption `-editendcommand` entspricht (sofern vorhanden).  Ist dieser Wert eine der oben genannten Fehlerzeichenfolgen, sollte das Skript den Inhalt des Mentry durch Aufruf des Unterbefehls `rejectinput` ablehnen.

**SCHLÜSSELWÖRTER**
: tablelist, editing, Mentry, date


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addTimeMentry`

**NAME**
: `tablelist::addTimeMentry` – Registrieren Sie das Mentry-Widget vom Typ `"Time"` für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addTimeMentry format separator ?-gmt? ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das mit dem Befehl `mentry::timeMentry` aus dem Paket „Mentry“ (oder „Mentry_tile“) erstellte Widget für die interaktive Zellenbearbeitung in Tablelist-Widgets.  Die Argumente `format` und `separator` haben dieselbe Bedeutung wie im Befehl `mentry::timeMentry`.  Wenn das Argument `-gmt` vorhanden ist, werden sowohl der interne Uhrwert als auch dessen externe Zeitdarstellung im Mentry-Widget als Greenwich-Zeit (GMT) angezeigt, andernfalls als Ortszeit.  Das zweite optionale Argument legt den Namen fest, der für das „mentry“-Widget als Wert der Spalten- oder Zellenkonfigurationsoption `-editwindow` verwendet werden soll. Es kann eine beliebige Zeichenkette sein, die sich von den Namen der Bearbeitungsfenster im [Tk-Kern](tablelistTkCore.md) und in [Tile](tablelistTile.md) unterscheidet. Der Standardwert ist `timeMentry`. Der Befehl gibt sein `name`-Argument zurück.

: Eine Spalte in einer Tablelist, deren Option `-editwindow` den oben genannten Wert `name` aufweist, muss als interne Zellenwerte Zeitangaben in Sekunden enthalten (die mithilfe eines durch die Konfigurationsoption `-formatcommand` vorgegebenen Befehls angezeigt werden).  Der Unterbefehl `finishediting` des mit dem Tablelist-Widget verknüpften Tcl-Befehls ruft den Inhalt des eingebetteten Fensters ab, das für die interaktive Zellenbearbeitung verwendet wird, indem er den Befehl `mentry::getClockVal` aufruft.  Der von diesem Befehl zurückgegebene Wert (ein Zeitwert in Sekunden oder eine der Fehlerzeichenfolgen `"EMPTY"` oder `"BAD"`) wird als letztes Argument an das Skript übergeben, das der Tablelist-Konfigurationsoption `-editendcommand` entspricht (sofern vorhanden).  Ist dieser Wert eine der oben genannten Fehlerzeichenfolgen, sollte das Skript den Inhalt des Mentry durch Aufruf des Unterbefehls `rejectinput` ablehnen.

**SCHLÜSSELWÖRTER**
: tablelist, editing, Mentry, time


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addDateTimeMentry`

**NAME**
: `tablelist::addDateTimeMentry` – Registrieren Sie das Mentry-Widget vom Typ `"DateTime"` für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addDateTimeMentry format dateSeparator timeSeparator ?-gmt? ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das vom Befehl `mentry::dateTimeMentry` aus dem Paket „Mentry“ (oder „Mentry_tile“) erstellte Widget für die interaktive Zellbearbeitung in Tablelist-Widgets.  Die Argumente `format`, `dateSeparator` und `timeSeparator` haben dieselbe Bedeutung wie im Befehl `mentry::dateTimeMentry`.  Wenn das Argument `-gmt` vorhanden ist, werden sowohl der Wert der internen Uhr als auch dessen externe Datums- und Zeitdarstellung im Mentry-Widget als Greenwich-Zeit (GMT) betrachtet, andernfalls als Ortszeit.  Das zweite optionale Argument legt den Namen fest, der für das „mentry“-Widget als Wert der Spalten- oder Zellenkonfigurationsoption `-editwindow` verwendet werden soll. Es kann eine beliebige Zeichenkette sein, die sich von den Namen der Bearbeitungsfenster im [Tk-Kern](tablelistTkCore.md) und in [Tile](tablelistTile.md) unterscheidet. Der Standardwert ist `dateTimeMentry`. Der Befehl gibt sein `name`-Argument zurück.

: Eine Spalte in einer Tablelist, deren Option `-editwindow` den oben genannten Wert `name` aufweist, muss als interne Zellenwerte Datums- und Zeitangaben in Sekunden enthalten (die mithilfe eines Befehls angezeigt werden, der durch die Konfigurationsoption `-formatcommand` vorgegeben wird).  Der Unterbefehl `finishediting` des mit dem Tablelist-Widget verknüpften Tcl-Befehls ruft den Inhalt des eingebetteten Fensters ab, das für die interaktive Zellenbearbeitung verwendet wird, indem er den Befehl `mentry::getClockVal` aufruft.  Der von diesem Befehl zurückgegebene Wert (ein Zeitwert in Sekunden oder eine der Fehlerzeichenfolgen `"EMPTY"`, `"BAD"`, `"BAD_DATE"` oder `"BAD_YEAR"`) wird als letztes Argument an das Skript übergeben, das der Tablelist-Konfigurationsoption `-editendcommand` entspricht (sofern vorhanden).  Ist dieser Wert eine der oben genannten Fehlerzeichenfolgen, sollte das Skript den Inhalt des „mentry“ durch Aufruf des Unterbefehls `rejectinput` ablehnen.

**SCHLÜSSELWÖRTER**
: tablelist, editing, Mentry, date, time


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addFixedPointMentry`

**NAME**
: `tablelist::addFixedPointMentry` – Registrieren Sie das Mentry-Widget vom Typ `"FixedPoint"` für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addFixedPointMentry count1 count2 ?-comma? ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das vom Befehl `mentry::fixedPointMentry` aus dem Paket „Mentry“ (oder „Mentry_tile“) erstellte Widget für die interaktive Zellbearbeitung in Tablelist-Widgets.  Die Argumente `count1`, `count2` und `-comma` haben dieselbe Bedeutung wie im Befehl `mentry::fixedPointMentry`.  Das zweite optionale Argument legt den Namen fest, der für das Mentry-Widget als Wert der Spalten- oder Zellenkonfigurationsoption `-editwindow` verwendet werden soll. Es kann eine beliebige Zeichenkette sein, die sich von den Namen der Bearbeitungsfenster im [Tk-Kern](tablelistTkCore.md) und in [Tile](tablelistTile.md) unterscheidet. Der Standardwert ist `fixedPointMentry_count1.count2` (z. B. `fixedPointMentry_6.2`) oder `fixedPointMentry_count1,count2` (z. B. `fixedPointMentry_6,2`), je nachdem, ob das optionale Argument `-comma` vorhanden ist. Der Befehl gibt sein Argument `name` zurück.

: Eine Spalte der Tablelist, deren Option `-editwindow` den oben genannten Wert `name` aufweist, muss reelle Zahlen als interne Zellenwerte enthalten.  Der Unterbefehl `finishediting` des Tcl-Befehls, der dem Tablelist-Widget zugeordnet ist, ruft den Inhalt des eingebetteten Fensters ab, das für die interaktive Zellbearbeitung verwendet wird, indem er den Befehl `mentry::getReal` aufruft.  Der von diesem Befehl zurückgegebene Wert (eine reelle Zahl oder die Fehlerzeichenfolge `"EMPTY"`) wird als letztes Argument an das Skript übergeben, das der Tablelist-Konfigurationsoption `-editendcommand` entspricht (sofern vorhanden).  Ist dieser Wert die oben genannte Fehlerzeichenfolge, sollte das Skript den Inhalt des Mentry durch Aufruf des Unterbefehls `rejectinput` ablehnen.

**SCHLÜSSELWÖRTER**
: tablelist, editing, Mentry, real number


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addIPAddrMentry`

**NAME**
: `tablelist::addIPAddrMentry` – Registrieren Sie das Mentry-Widget vom Typ `"IPAddr"` für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addIPAddrMentry ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das vom Befehl `mentry::ipAddrMentry` aus dem Paket „Mentry“ (oder „Mentry_tile“) erstellte Widget für die interaktive Zellbearbeitung in Tablelist-Widgets.  Das optionale Argument legt den Namen fest, der für das Mentry-Widget als Wert der Spalten- oder Zellenkonfigurationsoption `-editwindow` verwendet werden soll. Es kann eine beliebige Zeichenkette sein, die sich von den Namen der Bearbeitungsfenster im [Tk-Kern](tablelistTkCore.md) und in [Tile](tablelistTile.md) unterscheidet. Der Standardwert ist `ipAddrMentry`. Der Befehl gibt sein `name`-Argument zurück.

: Eine Spalte der Tablelist, deren Option `-editwindow` den oben genannten Wert `name` aufweist, muss IP-Adressen als interne Zellenwerte enthalten.  Der Unterbefehl `finishediting` des Tcl-Befehls, der dem Tablelist-Widget zugeordnet ist, ruft den Inhalt des eingebetteten Fensters ab, das für die interaktive Zellbearbeitung verwendet wird, indem er den Befehl `mentry::getIPAddr` aufruft.  Der von diesem Befehl zurückgegebene Wert (eine IP-Adresse oder die Fehlerzeichenfolge `"EMPTY"`) wird als letztes Argument an das Skript übergeben, das der Tablelist-Konfigurationsoption `-editendcommand` entspricht (sofern vorhanden).  Ist dieser Wert die oben genannte Fehlerzeichenfolge, sollte das Skript den Inhalt des Mentry durch Aufruf des Unterbefehls `rejectinput` ablehnen.

**SCHLÜSSELWÖRTER**
: tablelist, editing, Mentry, IP address


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addIPv6AddrMentry`

**NAME**
: `tablelist::addIPv6AddrMentry` – Registrieren Sie das Mentry-Widget vom Typ `"IPv6Addr"` für die interaktive Bearbeitung von Zellen

**ÜBERSICHT**
: 

```
tablelist::addIPv6AddrMentry ?name?
```

**BESCHREIBUNG**
: Dieser Befehl registriert das mit dem Befehl `mentry::ipv6AddrMentry` aus dem Paket „Mentry“ (oder „Mentry_tile“) erstellte Widget für die interaktive Zellbearbeitung in Tablelist-Widgets.  Das optionale Argument legt den Namen fest, der für das Mentry-Widget als Wert der Spalten- oder Zellenkonfigurationsoption `-editwindow` verwendet werden soll. Es kann eine beliebige Zeichenkette sein, die sich von den Namen der Bearbeitungsfenster im [Tk-Kern](tablelistTkCore.md) und in [Tile](tablelistTile.md) unterscheidet.  Der Standardwert ist `ipv6AddrMentry`.  Der Befehl gibt sein `name`-Argument zurück.

: Eine Spalte der Tablelist, deren Option `-editwindow` den oben genannten Wert `name` aufweist, muss IPv6-Adressen als interne Zellenwerte enthalten.  Der Unterbefehl `finishediting` des mit dem Tablelist-Widget verknüpften Tcl-Befehls ruft den Inhalt des eingebetteten Fensters ab, das für die interaktive Zellenbearbeitung verwendet wird, indem er den Befehl `mentry::getIPv6Addr` aufruft.  Der von diesem Befehl zurückgegebene Wert (eine IPv6-Adresse oder die Fehlerzeichenfolge `"EMPTY"`) wird als letztes Argument an das Skript übergeben, das der Tablelist-Konfigurationsoption `-editendcommand` entspricht (sofern vorhanden).  Ist dieser Wert die oben genannte Fehlerzeichenfolge, sollte das Skript den Inhalt des Mentry durch Aufruf des Unterbefehls `rejectinput` ablehnen.

**SCHLÜSSELWÖRTER**
: tablelist, editing, Mentry, IPv6 address


[Inhalt](#inhalt)     [Startseite](index.md)
