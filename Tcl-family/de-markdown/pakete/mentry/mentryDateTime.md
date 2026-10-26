# Mehrfeld-Eingabe-Widgets für Datum und Uhrzeit

## Für Mentry Version 4.5

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Der Befehl mentry::dateMentry](#der-befehl-mentry-datementry)
- [Der Befehl mentry::timeMentry](#der-befehl-mentry-timementry)
- [Der Befehl mentry::dateTimeMentry](#der-befehl-mentry-datetimementry)
- [Der Befehl mentry::putClockVal](#der-befehl-mentry-putclockval)
- [Der Befehl mentry::getClockVal](#der-befehl-mentry-getclockval)

[Startseite](index.md)

---

## Der Befehl `mentry::dateMentry`

**NAME**
: `mentry::dateMentry` – Mentry-Widgets für Datumsangaben erstellen und bearbeiten

**ÜBERSICHT**
: 

```
mentry::dateMentry pathName format separator ?options?
```

**BESCHREIBUNG**
: Dieser Befehl erstellt ein neues Mentry-Widget `pathName` zur Anzeige und Bearbeitung eines Datums gemäß dem Argument `format`, bei dem es sich um eine Zeichenkette der Länge 3 handeln muss, bestehend aus den Buchstaben `"d"` für den Tag (`01` – `31`), `"m"` für den Monat (`01` – `12`) sowie `"y"` oder `"Y"` für das Jahr ohne Jahrhundertangabe (`00` – `99`) oder mit Jahrhundertangabe (z. B. `2008`) in beliebiger Reihenfolge.  Diese Feldbeschreibungszeichen haben dieselbe Bedeutung wie im Befehl `clock format`. Das Argument `separator` legt den Text fest, der in den Beschriftungen angezeigt werden soll, die die drei Eingabekomponenten des mentry-Widgets voneinander trennen (die gängigsten Werte sind die Zeichen `"/"`, `"-"` und `"."`).  Die unterstützten `options` entsprechen denen des Befehls `mentry::mentry`.

: Der Befehl setzt das Attribut `type` des Widgets auf den Wert `"Date"`, speichert den Wert von `format` in dessen Attribut `format` und gibt den Namen des neu erstellten Widgets zurück.

**VORGABEBINDUNGEN**
: Der Befehl `mentry::dateMentry` definiert vier neue Bindungen für die Eingabekomponenten des von ihm erstellten „mentry“-Widgets: Die Taste `Up` erhöht den Wert der Eingabe um 1, wenn dieser unter dem für diese Komponente zulässigen Höchstwert liegt.  Ebenso verringert die Taste `Down` den Wert des Eingabefelds um 1, wenn dieser größer ist als der zulässige Mindestwert für diese Komponente.  Die Taste `Prior` erhöht den Wert des Eintrags um höchstens 10, wenn dieser kleiner als das für diese Komponente zulässige Maximum ist.  Ebenso verringert die Taste `Next` den Wert des Eintrags um höchstens 10, wenn dieser größer ist als der zulässige Mindestwert für diese Komponente. Ist der Eintrag leer, fügen alle diese Tasten den komponenten-spezifischen Mindestwert in den Eintrag ein.

: Die von den Tasten `Up` und `Down` ausgeführten Aktionen können auch mithilfe des Mausrads oder einer Zwei-Finger-Geste auf dem Touchpad ausgelöst werden.  Darüber hinaus werden unter Mac OS X/11+ Aqua die von den Tasten `Prior` und `Next` ausgeführten Aktionen auch durch das Ereignis `<Option-MouseWheel>` ausgelöst.  Das Gleiche gilt für alle Fenstersysteme, wenn die Tk-Version 8.7a4 oder höher ist, wobei der Modifikator `Option` unter Mac OS X/11+ der Taste `Option` und unter Windows sowie X11 der Taste `Alt` zugeordnet ist.

**SCHLÜSSELWÖRTER**
: mentry, widget, date


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::timeMentry`

**NAME**
: `mentry::timeMentry` – Mentry-Widgets für die Zeit erstellen und bearbeiten

**ÜBERSICHT**
: 

```
mentry::timeMentry pathName format separator ?options?
```

**BESCHREIBUNG**
: Dieser Befehl erstellt ein neues Mentry-Widget `pathName` zur Anzeige und Bearbeitung einer Uhrzeit gemäß dem Argument `format`, bei dem es sich um eine Zeichenkette der Länge 2 oder 3 handeln muss, bestehend aus den folgenden Feldbeschreibungszeichen des Befehls `clock format`: `"H"` oder `"I"`, gefolgt von `"M"` und optional dem Buchstaben `"S"`.  Ein `"H"` als erstes Zeichen legt das Zeitformat `"%H:%M"` oder `"%H:%M:%S"` fest (d. h. mit der Stunde zwischen `0` und `23`), während der Buchstabe `"I"` für `"%I:%M %p"` oder `"%I:%M:%S %p"` steht (d. h. mit AM/PM-Angabe).  Das Argument `separator` legt den Text fest, der in den Beschriftungen angezeigt werden soll, die die Eingabekomponenten des mentry-Widgets voneinander trennen (dies ist in der Regel das Zeichen `":"`).  Die `options` entsprechen denen des Befehls `mentry::mentry`.

: Der Befehl setzt das Attribut `type` des Widgets auf den Wert `"Time"`, speichert den Wert von `format` in dessen Attribut `format` und gibt den Namen des neu erstellten Widgets zurück.

**VORGABEBINDUNGEN**
: Der Befehl `mentry::timeMentry` definiert vier neue Tastaturbindungen für die Eingabekomponenten des von ihm erstellten „mentry“-Widgets: Die Taste `Up` erhöht den Wert der Eingabe um 1, wenn dieser unter dem für diese Komponente zulässigen Höchstwert liegt.  Ebenso verringert die Taste `Down` den Wert des Eingabefelds um 1, wenn dieser größer ist als der zulässige Mindestwert für diese Komponente.  Die Taste `Prior` erhöht den Wert des Eintrags um höchstens 10, wenn dieser kleiner als der zulässige Höchstwert für diese Komponente ist.  Ebenso verringert die Taste `Next` den Wert des Eintrags um höchstens 10, wenn dieser größer ist als der zulässige Mindestwert für diese Komponente. Ist der Eintrag leer, fügen alle diese Tasten den komponentenbezogenen Mindestwert in den Eintrag ein.

: Die von den Tasten `Up` und `Down` ausgeführten Aktionen können auch mithilfe des Mausrads oder einer Zwei-Finger-Geste auf dem Touchpad ausgelöst werden.  Darüber hinaus werden unter Mac OS X/11+ Aqua die von den Tasten `Prior` und `Next` ausgeführten Aktionen auch durch das Ereignis `<Option-MouseWheel>` ausgelöst.  Das Gleiche gilt für alle Fenstersysteme, wenn die Tk-Version 8.7a4 oder höher ist, wobei der Modifikator `Option` unter Mac OS X/11+ der Taste `Option` und unter Windows sowie X11 der Taste `Alt` zugeordnet ist.

**SCHLÜSSELWÖRTER**
: mentry, widget, time


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::dateTimeMentry`

**NAME**
: `mentry::dateTimeMentry` – Mentry-Widgets für Datum und Uhrzeit erstellen und bearbeiten

**ÜBERSICHT**
: 

```
mentry::dateTimeMentry pathName format dateSeparator timeSeparator ?options?
```

**BESCHREIBUNG**
: Dieser Befehl erstellt ein neues Mentry-Widget `pathName` zur Anzeige und Bearbeitung von Datum und Uhrzeit gemäß dem Argument `format`, das eine Zeichenkette mit einer Länge von 5 oder 6 Zeichen sein muss, wobei die ersten 3 Zeichen aus den Buchstaben `"d"` für den Tag (`01` – `31`), `"m"` für den Monat (`01` – `12`) sowie `"y"` oder `"Y"` für das Jahr ohne Jahrhundertangabe (`00` – `99`) oder mit Jahrhundertangabe (z. B. `2008`), in beliebiger Reihenfolge, gefolgt von 2 oder 3 weiteren Feldbeschreibungszeichen des Befehls `clock format`, die wie folgt lauten müssen: `"H"` oder `"I"`, dann `"M"` und optional der Buchstabe `"S"`.  Ein `"H"` legt das Zeitformat `"%H:%M"` oder `"%H:%M:%S"` fest (d. h. mit der Stunde zwischen `0` und `23`), während der Buchstabe `"I"` für `"%I:%M %p"` oder `"%I:%M:%S %p"` steht (d. h. mit AM/PM-Angabe).  Das Argument `dateSeparator` legt den Text fest, der in den Beschriftungen angezeigt werden soll, die die Eingabekomponenten im Datumsbereich des Eingabe-Widgets voneinander trennen (die gängigsten Werte sind die Zeichen `"/"`, `"-"` und `"."`).  Ebenso steht das Argument `timeSeparator` für den Text, der in den Beschriftungen angezeigt werden soll, die die Eingabekomponenten im Zeitteil des mentry-Widgets trennen (dies ist in der Regel das Zeichen `":"`).  Der Datums- und der Zeitteil sind wiederum durch ein Leerzeichen voneinander getrennt. Die unterstützten `options` entsprechen denen des Befehls `mentry::mentry`.

: Der Befehl setzt das Attribut `type` des Widgets auf den Wert `"DateTime"`, speichert den Wert von `format` in dessen Attribut `format` und gibt den Namen des neu erstellten Widgets zurück.

**VORGABEBINDUNGEN**
: Der Befehl `mentry::dateTimeMentry` definiert vier neue Bindungen für die Eingabekomponenten des von ihm erstellten „mentry“-Widgets: Die Taste `Up` erhöht den Wert der Eingabe um 1, wenn dieser unter dem für diese Komponente zulässigen Höchstwert liegt.  Ebenso verringert die Taste `Down` den Wert des Eingabefelds um 1, wenn dieser größer ist als der zulässige Mindestwert für diese Komponente.  Die Taste `Prior` erhöht den Wert des Eintrags um höchstens 10, wenn dieser kleiner als der zulässige Höchstwert für diese Komponente ist.  Ebenso verringert die Taste `Next` den Wert des Eintrags um höchstens 10, wenn dieser größer als das zulässige Minimum für diese Komponente ist. Wenn der Eintrag leer ist, fügen alle diese Tasten den komponentenbezogenen Mindestwert in den Eintrag ein.

: Die von den Tasten `Up` und `Down` ausgeführten Aktionen können auch mithilfe des Mausrads oder einer Zwei-Finger-Geste auf dem Touchpad ausgelöst werden.  Darüber hinaus werden unter Mac OS X/11+ Aqua die von den Tasten `Prior` und `Next` ausgeführten Aktionen auch durch das Ereignis `<Option-MouseWheel>` ausgelöst.  Das Gleiche gilt für alle Fenstersysteme, wenn die Tk-Version 8.7a4 oder höher ist, wobei der Modifikator `Option` unter Mac OS X/11+ der Taste `Option` und unter Windows sowie X11 der Taste `Alt` zugeordnet ist.

**SCHLÜSSELWÖRTER**
: mentry, widget, date, time


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::putClockVal`

**NAME**
: `mentry::putClockVal` – Ausgabe eines Werts für Datum, Uhrzeit oder Datum und Uhrzeit

**ÜBERSICHT**
: 

```
mentry::putClockVal clockValue pathName ?-gmt boolean?
```

**BESCHREIBUNG**
: Dieser Befehl gibt das Datum, die Uhrzeit oder Datum und Uhrzeit aus, die der Ganzzahl `clockValue` entsprechen, und überträgt sie an das Mentry-Widget `pathName`, das zuvor mit dem Befehl `mentry::dateMentry`, `mentry::timeMentry` oder `mentry::dateTimeMentry` erstellt worden sein muss (dies wird durch Überprüfung des Attributs `type` des Widgets überprüft, das den Wert `"Date"`, `"Time"` oder `"DateTime"` haben muss).

: Wie beim Befehl  `clock format` legt das optionale Argumentpaar  `-gmt boolean` fest, ob der Wert der Zeit als Greenwich Mean Time oder gemäß der von der Betriebsumgebung definierten lokalen Zeitzone formatiert werden soll.

**SCHLÜSSELWÖRTER**
: mentry, widget, date, time, clock


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::getClockVal`

**NAME**
: `mentry::getClockVal` – Den Wert der Uhrzeit aus einem Datums-, Zeit- oder Datums- und Zeit-Eintrag abrufen

**ÜBERSICHT**
: 

```
mentry::getClockVal pathName ?-base clockValue? ?-gmt boolean?
```

**BESCHREIBUNG**
: Dieser Befehl gibt den Uhrzeitwert zurück, der dem Datum, der Uhrzeit oder dem Datum und der Uhrzeit entspricht, die im Mentry-Widget `pathName` enthalten sind, das mit dem Befehl `mentry::dateMentry`, `mentry::timeMentry` oder `mentry::dateTimeMentry` erstellt worden sein muss (dies wird durch Überprüfung des Attributs `type` des Widgets überprüft, das den Wert `"Date"`, `"Time"` oder `"DateTime"` haben muss).

: Wie beim Befehl  `clock scan`  gilt: legt das optionale Argumentpaar  `-base clockValue` fest, dass das in `clockValue` enthaltene Datum verwendet werden soll, wenn der Uhrzeitwert aus dem angegebenen Mentry-Widget abgerufen wird, und das optionale Argumentpaar  `-gmt boolean` legt fest, ob der Uhrzeitwert relativ zur Greenwich Mean Time oder gemäß der von der Betriebsumgebung definierten lokalen Zeitzone berechnet werden soll.

: Tritt während der Konvertierung ein Fehler auf, setzt der Befehl den Fokus auf die erste fehlerhafte Eingabekomponente, löst einen Fehler aus und gibt einen der in der folgenden Tabelle aufgeführten Werte zurück:


| Rückgabewert | Bedeutung |
| --- | --- |
| `"EMPTY"` | Jede Eingabekomponente (mit Ausnahme derjenigen, die die Sekunden enthält) ist leer. |
| `"BAD"` | Der Wert für den Tag, den Monat oder die Stunde (letzteres nur, wenn die AM/PM-Angabe vorhanden ist) lautet `0`. |
| `"BAD_DATE"` | Das Tripel \<Jahr, Monat, Tag> ist ungültig (beachten Sie, dass der Befehl Schaltjahre berücksichtigt). |
| `"BAD_YEAR"` | Das obige Tripel ist gültig, aber die Konvertierung (die mit Hilfe des Befehls  `clock scan`  durchgeführt wurde) ist aufgrund eines nicht unterstützten Werts für das Jahr fehlgeschlagen (z. B. zwischen `38` und `70`). |

**SCHLÜSSELWÖRTER**
: mentry, widget, date, time, clock


[Inhalt](#inhalt)     [Startseite](index.md)
