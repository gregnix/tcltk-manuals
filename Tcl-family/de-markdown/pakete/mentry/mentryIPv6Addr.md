# Mehrfeld-Eingabe-Widgets für IPv6-Adressen

## Für Mentry Version 4.5

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Der Befehl mentry::ipv6AddrMentry](#der-befehl-mentry-ipv6addrmentry)
- Der Befehl mentry::putIPv6Addr
- [Der Befehl mentry::getIPv6Addr](#der-befehl-mentry-getipv6addr)

[Startseite](index.md)

---

## Der Befehl `mentry::ipv6AddrMentry`

**NAME**
: `mentry::ipv6AddrMentry` – Erstellen und Bearbeiten von Mentry-Widgets für IPv6-Adressen

**ÜBERSICHT**
: 

```
mentry::ipv6AddrMentry pathName ?options?
```

**BESCHREIBUNG**
: Dieser Befehl erstellt ein neues Mentry-Widget `pathName` zur Anzeige und Bearbeitung von IPv6-Adressen in der standardmäßigen hexadezimalen Notation (wobei die acht Gruppen aus jeweils einer bis vier hexadezimalen Ziffern durch jeweils einen Doppelpunkt voneinander getrennt sind).  Die unterstützten `options` entsprechen denen des Befehls `mentry::mentry`.

: Der Befehl setzt das Attribut `type` des Widgets auf den Wert `"IPv6Addr"` und gibt den Namen des neu erstellten Widgets zurück.

**VORGABEBINDUNGEN**
: Der Befehl `mentry::ipv6AddrMentry` definiert fünf neue Bindungen für die Eingabekomponenten des von ihm erstellten „mentry“-Widgets: Die Taste `Up` erhöht den Wert des Eingabefelds um 1, wenn dieser kleiner als 65535 ist.  Ebenso verringert die Taste `Down` den Wert des Eintrags um 1, wenn dieser größer als 0 ist.  Die Taste `Prior` erhöht den Wert des Eintrags um höchstens 10, wenn dieser kleiner als 65535 ist.  Ebenso verringert die Taste `Next` den Wert des Eintrags um höchstens 10, wenn dieser größer als 0 ist.  Ist der Eintrag leer, fügen alle diese Tasten den Wert `0` in den Eintrag ein.  Schließlich fügt `Control-v` (`Command-v` auf dem Mac) den aktuellen Inhalt der Zwischenablage in den Mentry ein, sofern es sich um eine gültige IPv6-Adresse handelt.

: Die von den Tasten `Up` und `Down` ausgeführten Aktionen können auch mithilfe des Mausrads oder einer Zwei-Finger-Geste auf dem Touchpad ausgelöst werden.  Darüber hinaus werden unter Mac OS X/11+ Aqua die von den Tasten `Prior` und `Next` ausgeführten Aktionen auch durch das Ereignis `<Option-MouseWheel>` ausgelöst.  Das Gleiche gilt für alle Fenstersysteme, wenn die Tk-Version 8.7a4 oder höher ist, wobei der Modifikator `Option` unter Mac OS X/11+ der Taste `Option` und unter Windows sowie X11 der Taste `Alt` zugeordnet ist.

**SCHLÜSSELWÖRTER**
: mentry, widget, IPv6 address


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::putIPv6Addr`

**NAME**
: `mentry::putIPv6Addr` – Eine IPv6-Adresse in ein Mentry des Typs `"IPv6Addr"` ausgeben

**ÜBERSICHT**
: 

```
mentry::putIPv6Addr address pathName
```

**BESCHREIBUNG**
: Dieser Befehl gibt die IPv6-Adresse `address` an das Mentry-Widget `pathName` aus, das zuvor mit dem Befehl `mentry::ipv6AddrMentry` erstellt worden sein muss (dies wird durch Überprüfung des Attributs `type` des Widgets überprüft, das den Wert `"IPv6Addr"` haben muss).

: Die Adresse muss aus bis zu acht durch Doppelpunkte getrennten Gruppen bestehen, jede aus einer bis vier Hexadezimalziffern. Bei weniger als acht Gruppen muss die Adresse genau einmal `::` enthalten (das steht für aufeinanderfolgende Gruppen von Nullen).  Der Befehl löst einen Fehler aus, wenn die Adresse ungültig ist.

**SCHLÜSSELWÖRTER**
: mentry, widget, IPv6 address


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::getIPv6Addr`

**NAME**
: `mentry::getIPv6Addr` – Eine IPv6-Adresse aus einer Mentry vom Typ `"IPv6Addr"` abrufen

**ÜBERSICHT**
: 

```
mentry::getIPv6Addr pathName
```

**BESCHREIBUNG**
: Dieser Befehl gibt die IPv6-Adresse zurück, die im Mentry-Widget `pathName` enthalten ist, das mit dem Befehl `mentry::ipv6AddrMentry` erstellt worden sein muss (dies wird durch Überprüfung des Attributs `type` des Widgets überprüft, das den Wert `"IPv6Addr"` haben muss).

: Ist eine der Eingabekomponenten des Widgets leer, setzt der Befehl den Fokus auf die erste dieser Eingaben, löst einen Fehler aus und gibt die Zeichenfolge `"EMPTY"` zurück.

**SCHLÜSSELWÖRTER**
: mentry, widget, IPv6 address


[Inhalt](#inhalt)     [Startseite](index.md)
