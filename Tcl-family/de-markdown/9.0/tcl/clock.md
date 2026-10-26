---
CommandName: clock
title: clock
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - msgcat(n)
Keywords:
 - clock
 - date
 - time
Copyright:
 - Copyright (c) 2004 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
---

# Name

clock - Datum und Uhrzeit ermitteln und manipulieren

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit}

[clock]{.cmd} [add]{.sub} [timeVal]{.arg} [count unit]{.optdot} [-option value]{.optarg}
[clock]{.cmd} [clicks]{.sub} [-option]{.optarg}
[clock]{.cmd} [format]{.sub} [timeVal]{.arg} [-option value]{.optdot}
[clock]{.cmd} [microseconds]{.sub}
[clock]{.cmd} [milliseconds]{.sub}
[clock]{.cmd} [scan]{.sub} [inputString]{.arg} [-option value]{.optdot}
[clock]{.cmd} [seconds]{.sub}
:::

# Beschreibung

Der Befehl **clock** führt mehrere Operationen aus, die Werte ermitteln und manipulieren, die Zeitpunkte repräsentieren. Der Befehl unterstützt mehrere Unterbefehle, die festlegen, welche Aktion ausgeführt wird.

[clock]{.cmd} [add]{.sub} [timeVal]{.arg} [count unit...]{.optarg} [-option value]{.optarg}
: Addiert einen (möglicherweise negativen) Offset zu einer Zeit, die als ganzzahlige Sekundenanzahl ausgedrückt ist. Siehe [Uhrzeit-Arithmetik] für eine vollständige Beschreibung.

[clock]{.cmd} [clicks]{.sub} [-option]{.optarg}
: Liefert ohne *-option*-Argument einen hochauflösenden Zeitwert als systemabhängigen Ganzzahlwert. Die Einheit des Werts ist systemabhängig, sollte aber die höchste verfügbare Auflösung des System-Takts sein, z. B. ein CPU-Zyklenzähler. Siehe [Hochauflösende Zeitmesser] für eine vollständige Beschreibung.

    Ist das *-option*-Argument **-milliseconds**, ist der Befehl synonym mit **clock milliseconds** (siehe unten). Diese Verwendung ist veraltet; **clock milliseconds** gilt als bevorzugte Methode, eine Millisekundenanzahl zu erhalten.

    Ist das *-option*-Argument **-microseconds**, ist der Befehl synonym mit **clock microseconds** (siehe unten). Diese Verwendung ist veraltet; **clock microseconds** gilt als bevorzugte Methode, eine Mikrosekundenanzahl zu erhalten.

[clock]{.cmd} [format]{.sub} [timeVal]{.arg} [-option value]{.optdot}
: Formatiert eine als ganzzahlige Sekundenanzahl ausgedrückte Zeit in ein für Benutzer oder externe Programme bestimmtes Format. Siehe [Zeiten formatieren] für eine vollständige Beschreibung.

[clock]{.cmd} [microseconds]{.sub}
: Gibt die aktuelle Zeit als ganzzahlige Mikrosekundenanzahl zurück. Siehe [Hochauflösende Zeitmesser] für eine vollständige Beschreibung.

[clock]{.cmd} [milliseconds]{.sub}
: Gibt die aktuelle Zeit als ganzzahlige Millisekundenanzahl zurück. Siehe [Hochauflösende Zeitmesser] für eine vollständige Beschreibung.

[clock]{.cmd} [scan]{.sub} [inputString]{.arg} [-option value]{.optdot}
: Liest eine als Zeichenkette ausgedrückte Zeit ein und erzeugt eine ganzzahlige Sekundenanzahl. Siehe [Zeiten einlesen] für eine vollständige Beschreibung.

[clock]{.cmd} [seconds]{.sub}
: Gibt die aktuelle Zeit als ganzzahlige Sekundenanzahl zurück.


## Parameter

*count*
: Eine Ganzzahl, die eine Anzahl einer Zeiteinheit darstellt. Siehe [Uhrzeit-Arithmetik] für die Details.

*timeVal*
: Ein an den Befehl **clock** übergebener Ganzzahlwert, der einen absoluten Zeitpunkt als Sekundenanzahl ab der *Epoche* vom 1. Januar 1970, 00:00 UTC darstellt. Die Sekundenanzahl enthält keine Schaltsekunden; Sekunden werden gezählt, als ob jeder UTC-Tag genau 86400 Sekunden hätte. Tcl reagiert auf Schaltsekunden, indem es die Uhr einige Minuten lang minimal beschleunigt oder verlangsamt, bis sie wieder mit UTC übereinstimmt; das Datenmodell stellt keine Minuten mit 59 oder 61 Sekunden dar.

*now*
: Statt *timeVal* kann der nicht-ganzzahlige Wert **now** als Ersatz für „heute“ verwendet werden; er wird zur Laufzeit durch den Wert von **clock seconds** ersetzt. Beispiel:
    **clock format now -f %a; # aktueller Wochentag**
    **clock add now 1 month; # nächster Monat**



*unit*
: Eines der Wörter **seconds**, **minutes**, **hours**, **days**, **weekdays**, **weeks**, **months** oder **years**. Zusammen mit *count* zur Angabe eines Zeitintervalls, z. B. *3 seconds* oder *1 year*.


## Optionen

[-base]{.lit} time
: Legt fest, dass relative Zeiten in einem **clock scan**-Befehl relativ zu *time* angegeben werden. *time* muss als nominale Sekundenanzahl ab der Epoche vom 1. Januar 1970, 00:00 UTC ausgedrückt sein.

[-format]{.lit} format
: Legt das gewünschte Ausgabeformat für **clock format** oder das erwartete Eingabeformat für **clock scan** fest. Die Zeichenkette *format* besteht aus beliebig vielen Zeichen außer dem Prozentzeichen **%**, durchsetzt mit beliebig vielen *Formatgruppen*, also zwei- oder dreistelligen Folgen, die mit dem Prozentzeichen beginnen. Die zulässigen Formatgruppen und ihre Interpretation sind unter [Formatgruppen] beschrieben.

    Bei **clock format** ist das Standardformat

    ```
    %a %b %d %H:%M:%S %Z %Y
    ```

    Bei **clock scan** bedeutet das Fehlen von **-format**, dass ein *Freiform-Scan* angefordert wird; siehe [Freiform-Scan] für eine Beschreibung des Verhaltens.

[-gmt]{.lit} boolean
: Ist *boolean* wahr, wird festgelegt, dass eine an **clock add**, **clock format** oder **clock scan** übergebene Zeit in UTC verarbeitet wird. Ist *boolean* falsch, gilt standardmäßig die lokale Zeitzone. Diese Verwendung ist veraltet; korrekt ist die Angabe der UTC-Zeitzone mit **-timezone** *:UTC* oder einem gleichwertigen Weg.

[-locale]{.lit} localeName
: Legt fest, dass locale-abhängiges Einlesen und Formatieren (sowie Datumsarithmetik für Daten vor Einführung des Gregorianischen Kalenders) in der von *localeName* bezeichneten Locale erfolgt. Der Locale-Name kann jede von [msgcat] akzeptierte Locale sein, der Sondername *system* (aktuelle Locale des Prozesses) oder die leere Zeichenkette (Tcls Standard-Locale).

    Der Einfluss der Locale auf Einlesen und Formatieren wird bei den einzelnen Formatgruppen unter [Formatgruppen] erläutert. Der Einfluss auf die Uhrzeit-Arithmetik unter [Uhrzeit-Arithmetik].

[-timezone]{.lit} zoneName
: Legt fest, dass Uhrzeit-Arithmetik, Formatierung und Einlesen nach den Regeln der von *zoneName* bezeichneten Zeitzone erfolgen. Zulässige Werte und ihre Interpretation unter [Zeitzonen]. Bei Unterbefehlen mit **-timezone** ist standardmäßig die *aktuelle Zeitzone* gemeint. Sie wird in dieser Reihenfolge ermittelt:

    1. der Umgebungsvariable **TCL\_TZ**.

    2. der Umgebungsvariable **TZ**.

    3. unter Windows den Zeitzoneneinstellungen der Systemsteuerung.


[-validate]{.lit} boolean
: Ist *boolean* wahr (Standard), meldet **clock scan** einen Fehler bei ungültigen Werten, z. B. Tag des Monats größer als die Monatslänge. Bei false passt der Befehl Werte in den zulässigen Bereich an. Siehe [Zeiten einlesen].


Sind keine dieser Quellen vorhanden, versuchen die C-Funktionen **localtime** und **mktime**, Zeiten zwischen lokaler Zeit und Greenwich umzurechnen. Auf 32-Bit-Systemen ist dieser Ansatz fehleranfällig, besonders für Zeiten außerhalb des in einer 32-Bit-Ganzzahl darstellbaren Bereichs (etwa 1902 bis 2037).

# Uhrzeit-Arithmetik

Der Befehl **clock add** führt Uhrzeit-Arithmetik auf einem Wert aus (ausgedrückt als nominale Sekunden ab der Epoche vom 1. Januar 1970, 00:00 UTC), der als erstes Argument übergeben wird. Die übrigen Argumente (außer den möglichen Optionen **-timezone**, **-locale** und **-gmt**) sind abwechselnd Ganzzahlen und Schlüsselwörter aus **seconds**, **minutes**, **hours**, **days**, **weekdays**, **weeks**, **months** oder **years**.

Das Addieren von Sekunden, Minuten und Stunden ist unmittelbar: Der gegebene Zeitzuwachs (×60 für Minuten, ×3600 für Stunden) wird zum an **clock add** übergebenen *timeVal* addiert. Das Ergebnis gilt als nominale Sekundenanzahl ab der Epoche.

Beim Überschreiten eines Schaltsekunden-Einfüge- oder -Entfernungspunkts können überraschende Ergebnisse entstehen; **clock add** ignoriert Schaltsekunden und nimmt eine fortlaufende Folge 23:59:58, 23:59:59, 00:00:00 an. Tcl gleicht Schaltsekunden durch minimale Beschleunigung oder Verlangsamung der Uhr aus, bis die Zeit wieder mit der Welt übereinstimmt.

Weil Stundenaddition in absoluter Zeit definiert ist, werden in Zonen mit Sommerzeit feste Zeitbeträge addiert. Das folgende Beispiel setzt **x** auf **04:00:00**, weil die Uhr im betrachteten Intervall umgestellt wurde.

```
set s [clock scan {2004-10-30 05:00:00} \
           -format {%Y-%m-%d %H:%M:%S} \
           -timezone :America/New_York]
set a [clock add $s 24 hours -timezone :America/New_York]
set x [clock format $a \
           -format {%H:%M:%S} -timezone :America/New_York]
```

Tage und Wochen werden addiert/subtrahiert, indem die Zeit in Kalendertag und Tageszeit der passenden Zeitzone und Locale umgewandelt, die nötige Tagesanzahl (Wochen ×7) zum Kalendertag addiert und Datum und Zeit wieder in Sekunden ab der Epoche zurückgerechnet werden. Das Schlüsselwort **weekdays** entspricht **days**, überspringt aber Wochenenden (Samstag und Sonntag).

Addiert/subtrahiert man über den Sommerzeit-Umstellungspunkt hinweg eine gegebene Tagesanzahl, ergibt sich am betreffenden Tag dieselbe *lokale Uhrzeit*. Das folgende Beispiel setzt **x** auf **05:00:00**.

```
set s [clock scan {2004-10-30 05:00:00} \
           -format {%Y-%m-%d %H:%M:%S} \
           -timezone :America/New_York]
set a [clock add $s 1 day -timezone :America/New_York]
set x [clock format $a \
           -format {%H:%M:%S} -timezone :America/New_York]
```

Bei Mehrdeutigkeit, wenn dieselbe lokale Uhrzeit am selben Tag zweimal vorkommt, gilt die frühere. Liefert die Umrechnung eine unmögliche Zeit (z. B. 02:30 bei der Frühjahrs-Sommerzeitumstellung nach US-Regeln), wird gerechnet, als ob die Uhr nicht umgestellt worden wäre. **x** wird dann **03:30:00**.

```
set s [clock scan {2004-04-03 02:30:00} \
           -format {%Y-%m-%d %H:%M:%S} \
           -timezone :America/New_York]
set a [clock add $s 1 day -timezone :America/New_York]
set x [clock format $a \
           -format {%H:%M:%S} -timezone :America/New_York]
```

Eine gegebene Tages- oder Wochenanzahl funktioniert auch über den julianisch-gregorianischen Kalenderwechsel; ausgelassene Tage werden übersprungen. **z** wird **1752-09-14**.

```
set x [clock scan 1752-09-02 -format %Y-%m-%d -locale en_US]
set y [clock add $x 1 day -locale en_US]
set z [clock format $y -format %Y-%m-%d -locale en_US]
```

Führt das Addieren der Tage zu einem nicht existierenden Datum in den ausgelassenen Tagen der julianisch-gregorianischen Umstellung, wird gerechnet, als läge das Datum im julianischen Kalender.

Monate oder Jahre werden ähnlich addiert: Umwandlung in Kalenderdatum und Tageszeit, Addition der Monats- oder Jahresanzahl, Rückumwandlung in absolute Zeit.

Ist das Ergebnis unmöglich, weil der Monat zu wenige Tage hat (z. B. 1 Monat zu 31. Januar), wird der letzte Tag des Monats genommen: 1 Monat zu 31. Januar ergibt 28. bzw. 29. Februar.

Die Regeln für Sommerzeit und den Gregorianischen Kalender gelten bei Monaten und Jahren wie bei Tagen und Wochen.

Stehen mehrere *count unit*-Paare auf dem Befehl, werden sie nacheinander von links nach rechts ausgewertet.

# Hochauflösende Zeitmesser

Die meisten Unterbefehle von **clock** arbeiten mit Zeiten als Sekundenanzahl ab der Epoche; so liefert **clock seconds**. Drei Ausnahmen dienen höherer Auflösung: **clock milliseconds** und **clock microseconds** liefern Milli- bzw. Mikrosekunden ab der Epoche. **clock clicks** liefert einen plattformabhängigen Hochauflösungs-Timer. Im Gegensatz zu **clock seconds** und **clock milliseconds** ist **clock clicks** nicht an eine feste Epoche gebunden, sondern der präziseste verfügbare Intervall-Timer für relative Messungen wie Benchmarks.

# Zeiten formatieren

Der Befehl **clock format** erzeugt Zeiten zur Anzeige oder für externe Medien. Er akzeptiert Zeiten als Sekunden ab der Epoche vom 1. Januar 1970, 00:00 UTC, wie von **clock seconds**, **clock scan**, **clock add**, [file atime][file] oder [file mtime][file].

Ist **-format** gesetzt, legt das folgende Argument fest, wie Datum und Uhrzeit formatiert werden. Die Zeichenkette besteht aus Zeichen außer **%**, durchsetzt mit *Formatgruppen* (zweistellige Folgen ab **%**). Sie sind unter [Formatgruppen] beschrieben.

Ist **-timezone** gesetzt, legt das folgende Argument die Zeitzone für die Formatierung fest. Statt **-timezone** *:UTC* ist die veraltete Verwendung **-gmt** *true* möglich. Zulässige Varianten unter [Zeitzonen].

Ist **-locale** gesetzt, legt das folgende Argument die Locale im Format von [msgcat] fest. Ohne **-locale** gilt die Root-Locale **{}**, nicht die aktuelle; die aktuelle erhält man mit **-locale** **current**. Einige Plattformen bieten die Locale **system** (Benutzerauswahl). Unter Windows entspricht **system** den Datums-/Zeitformaten der Systemsteuerung. Wo keine Benutzerauswahl getrennt von **LC\_TIME** existiert, ist **-locale** **system** gleichbedeutend mit **-locale** **current**.

# Zeiten einlesen

Der Befehl **clock scan** akzeptiert formatierte Zeichenketten und wandelt sie in Sekunden ab der Epoche vom 1. Januar 1970, 00:00 UTC um. Normalerweise folgt auf **-format** eine Zeichenkette mit dem erwarteten Eingabeformat. (Siehe [Freiform-Scan] ohne dieses Argument.) Die Zeichenkette besteht aus Zeichen außer **%**, durchsetzt mit *Formatgruppen* (zweistellige Folgen ab **%**), beschrieben unter [Formatgruppen].

Ist **-timezone** gesetzt, legt das folgende Argument die Zeitzone für die Interpretation fest. Statt **-timezone** *:UTC* ist **-gmt** *true* veraltet möglich. Varianten unter [Zeitzonen].

Ist **-locale** gesetzt, legt das folgende Argument die Locale (wie bei [msgcat]) fest. Standard ohne **-locale** ist **{}**; aktuelle Locale mit **-locale** **current**. **system** spiegelt die Benutzerauswahl (unter Windows die Systemsteuerung). Ohne getrennte Benutzerauswahl von **LC\_TIME** ist **-locale** **system** gleich **-locale** **current**.

Ist **-base** gesetzt, ist das folgende Argument die *Basiszeit* (Sekunden ab der Epoche) für relative Zeiten; sonst die aktuelle Zeit.

Einlesen im festen Format ermittelt Datum, Tageszeit und Zeitzone, kombiniert sie zu einem Zeitpunkt und gibt Sekunden ab der Epoche zurück.

Vor dem Einlesen werden **%c**, **%Ec**, **%x**, **%Ex**, **%X**, **%Ex**, **%r**, **%R**, **%T**, **%D**, **%EY** und **%+** durch locale-gerechte Entsprechungen ohne diese Gruppen ersetzt. **%D** wird z. B. in **en\_US** zu **%m/%d/%Y**.

Das Datum wird nach den Feldern der vorverarbeiteten Formatzeichenkette bestimmt, in dieser Priorität:

1. Enthält die Zeichenkette **%s** (Sekunden ab der Epoche), bestimmt diese Gruppe das Datum.

2. Enthält sie **%J**, **%EJ** oder **%Ej** (Kalender- oder astronomische Julian Day Number), bestimmen diese Gruppen das Datum; bei **%EJ** oder **%Ej** mit Zeitanteil auch die Uhrzeit.

3. Enthält sie ein vollständiges Set aus Jahrhundert, Jahr, Monat und Tag; Jahrhundert, Jahr und Tag des Jahres; oder ISO8601-Geschäftsjahr, Woche und Wochentag, werden diese kombiniert. Bei mehreren Sets gilt das rechteste.

4. Fehlt das Jahrhundert, aber es gibt Jahr-des-Jahrhunderts mit Monat/Tag, Jahr und Tag des Jahres, oder zweistelliges ISO8601-Geschäftsjahr mit Woche und Wochentag, werden diese kombiniert (rechtestes Set). Das Jahr liegt vermutlich zwischen 1938 und 2037.

5. Fehlt jede Jahresangabe (oder nur im alternativen Kalender der Locale) und es gibt Monat/Tag, Tag des Jahres oder Woche und Wochentag, werden diese kombiniert (rechtestes Set). Das Jahr folgt aus der Basiszeit in der gegebenen Zeitzone.

6. Enthält die Zeichenkette keines der obigen Sets, aber Tag des Monats oder Wochentag, wird anhand der Basiszeit in der Zeitzone der passende Tag der aktuellen Woche oder des Monats gewählt (Woche Mo–So nach ISO8601). Bei beiden hat der Monatstag Vorrang.

7. Liefert keine Regel ein brauchbares Datum, gilt das Datum der Basiszeit in der gegebenen Zeitzone.


Die Tageszeit wird nach den Feldern der vorverarbeiteten Zeichenkette bestimmt, in dieser Priorität:

1. Enthält die Zeichenkette **%s**, bestimmt diese Gruppe die Tageszeit.

2. Enthält sie eine Stunde im 24- oder 12-Stunden-Format mit AM/PM, bestimmt diese die Stunde. Mit Minuten- und Sekundengruppe werden diese kombiniert.

3. Enthält sie weder **%s** noch eine Stundenangabe, gilt Mitternacht (**00:00**, Beginn des Datums). Die Zeitzone folgt aus **-timezone**, **-gmt** oder der aktuellen Zeitzone.


Fehlen **%z** und **%Z**, kann die Uhrzeit am selben Tag zweimal vorkommen (mit und ohne Sommerzeit); dann gilt die erste. Bei lokalen Zeiten sollte die Eingabe die Zeitzone enthalten (nicht bei UTC).

Liefert die Interpretation eine unmögliche Zeit wegen eines Feldes außerhalb des Bereichs, wird bei **-validate** true (Standard) eine Ausnahme ausgelöst; bei false wird genug der Einheit addiert oder subtrahiert, bis der Wert passt. Tag 0 des Monats wird z. B. zum letzten Tag des Vormonats.

Bei unmöglicher oder mehrdeutiger Zeit wegen Sommerzeitumstellung ohne **%z** oder **%Z** wird gerechnet, als ob die Uhr nicht umgestellt worden wäre.

# Formatgruppen

Die folgenden Formatgruppen werden von **clock scan** und **clock format** erkannt.

**%a**
: Bei der Ausgabe eine Abkürzung (*z. B.* **Mon**) des Wochentags in der gegebenen Locale. Bei der Eingabe der Wochentagsname (kurz oder voll oder ein eindeutiges Präfix).

**%A**
: Bei der Ausgabe der vollständige Name (*z. B.* **Monday**) des Wochentags in der gegebenen Locale. Bei der Eingabe wie bei **%a**.

**%b**
: Bei der Ausgabe eine Abkürzung (*z. B.* **Jan**) des Monatsnamens in der gegebenen Locale. Bei der Eingabe der Monatsname (kurz oder voll oder ein eindeutiges Präfix).

**%B**
: Bei der Ausgabe der vollständige Monatsname (*z. B.* **January**) in der gegebenen Locale. Bei der Eingabe wie bei **%b**.

**%c**
: Bei der Ausgabe eine locale-abhängige Darstellung von Datum und Tageszeit (Gregorianischer Kalender erwartet). Bei der Eingabe das, was **%c** erzeugt.

**%C**
: Bei der Ausgabe die Jahrhundertzahl in indo-arabischen Ziffern. Bei der Eingabe ein oder zwei Ziffern (ggf. mit führendem Leerzeichen) als Jahrhundertzahl.

**%d**
: Bei der Ausgabe die Tageszahl des Monats mit zwei Dezimalziffern. Bei der Eingabe ein oder zwei Ziffern (ggf. mit führendem Leerzeichen) als Tageszahl.

**%D**
: Synonym mit **%m/%d/%Y**. Nur zum Datenaustausch in der Locale **en\_US** verwenden; andere Locales ordnen die Datumsfelder meist anders.

**%e**
: Bei der Ausgabe die Tageszahl mit ein oder zwei Ziffern (einstellig mit führendem Leerzeichen). Bei der Eingabe wie bei **%d**.

**%Ec**
: Bei der Ausgabe eine locale-abhängige Darstellung von Datum und Tageszeit im alternativen Kalender der Locale. Bei der Eingabe das, was **%Ec** erzeugt. Der alternative Kalender muss nicht gregorianisch sein.

**%EC**
: Bei der Ausgabe ein locale-abhängiger Epochenname im alternativen Kalender. Bei der Eingabe der Epochenname oder ein eindeutiges Präfix.

**%EE**
: Bei der Ausgabe **B.C.E.** oder **C.E.** (oder locale-gleichwertig), ob **%Y** Jahre vor oder nach Jahr 1 der Common Era meint. Bei der Eingabe **B.C.E.**, **B.C.**, **C.E.**, **A.D.** oder die passende Abkürzung der Locale zur Festlegung für **%Y**.

**%Ej**
: Bei der Ausgabe die astronomische Julian Date bzw. Julian Day Number (JDN/JD); im Gegensatz zu **%J** beginnt der Tag um Mittag. Bei der Eingabe Ziffern (oder Gleitkomma mit Zeitanteil). Zählt Kalendertage seit dem 1. Januar 4713 v. Chr. des proleptischen julianischen Kalenders inkl. Zeitanteil. Der 1. Januar 1970 entspricht astronomischem JDN 2440587.5 (wie in SQLite **select julianday(:seconds, \'unixepoch\')**).

**%EJ**
: Bei der Ausgabe die Calendar Julian Date als Gleitkommazahl; im Gegensatz zu **%J** mit Nachkommastellen, im Gegensatz zu **%Ej** ab Mitternacht. Bei der Eingabe wie **%Ej**. Zählt Kalendertage seit dem 1. Januar 4713 v. Chr. inkl. Zeitanteil. Der 1. Januar 1970 entspricht JDN 2440588.

**%Es**
: Wirkt wie **%s**, formatiert oder parst aber lokale Sekunden (nicht POSIX-Sekunden). Hat dieselbe Priorität wie **%s** und setzt alle anderen Eingabeformate außer Kraft.

**%Ex**
: Bei der Ausgabe eine locale-abhängige Datumsdarstellung im alternativen Kalender. Bei der Eingabe das, was **%Ex** erzeugt. Der alternative Kalender muss nicht gregorianisch sein.

**%EX**
: Bei der Ausgabe eine locale-abhängige Tageszeitdarstellung in alternativen Ziffern. Bei der Eingabe das, was **%EX** erzeugt.

**%Ey**
: Bei der Ausgabe eine locale-abhängige Jahreszahl der Epoche im alternativen Kalender und in alternativen Ziffern. Bei der Eingabe eine solche Zahl.

**%EY**
: Bei der Ausgabe eine Jahresdarstellung im alternativen Kalender und in alternativen Ziffern. Bei der Eingabe das, was **%EY** erzeugt. Oft synonym mit **%EC%Ey**.

**%g**
: Bei der Ausgabe eine zweistellige Jahreszahl für den wochenbasierten ISO8601-Kalender, passend zur von **%V** erzeugten Wochennummer. Bei der Eingabe eine solche zweistellige Jahreszahl (ggf. mit führendem Leerzeichen).

**%G**
: Bei der Ausgabe eine vierstellige Jahreszahl für den wochenbasierten ISO8601-Kalender, passend zur von **%V** erzeugten Wochennummer. Bei der Eingabe eine solche vierstellige Jahreszahl (ggf. mit führendem Leerzeichen).

**%h**
: Synonym mit **%b**.

**%H**
: Bei der Ausgabe die Stunde (00-23) im 24-Stunden-Format mit zwei Ziffern. Bei der Eingabe eine solche Zahl.

**%I**
: Bei der Ausgabe die Stunde (12-11) im 12-Stunden-Format mit zwei Ziffern. Bei der Eingabe eine solche Zahl.

**%j**
: Bei der Ausgabe den Tag des Jahres (001-366) mit drei Ziffern. Bei der Eingabe eine solche Zahl.

**%J**
: Bei der Ausgabe die Julian Day Number als Ziffernfolge. Bei der Eingabe eine Ziffernfolge als Julian Day Number — die Anzahl Kalendertage seit dem 1. Januar 4713 v. Chr. des proleptischen julianischen Kalenders. Die Epoche vom 1. Januar 1970 entspricht Julian Day Number 2440588.

**%k**
: Bei der Ausgabe die Stunde (0-23) im 24-Stunden-Format mit ein oder zwei Ziffern. Bei der Eingabe eine solche Zahl.

**%l**
: Bei der Ausgabe die Stunde (12-11) im 12-Stunden-Format mit ein oder zwei Ziffern. Bei der Eingabe eine solche Zahl.

**%m**
: Bei der Ausgabe die Monatszahl (01-12) mit genau zwei Ziffern. Bei der Eingabe zwei Ziffern als Monatszahl.

**%M**
: Bei der Ausgabe die Minute (00-59) mit genau zwei Ziffern. Bei der Eingabe zwei Ziffern als Minute.

**%N**
: Bei der Ausgabe die Monatszahl (1-12) mit ein oder zwei Ziffern (einstellig mit führendem Leerzeichen). Bei der Eingabe ein oder zwei Ziffern (ggf. mit führendem Leerzeichen) als Monatszahl.

**%Od**, **%Oe**, **%OH**, **%OI**, **%Ok**, **%Ol**, **%Om**, **%OM**, **%OS**, **%Ou**, **%Ow**, **%Oy**
: Synonym mit den Entsprechungen ohne **O**, jedoch Ausgabe und Eingabe in den locale-abhängigen alternativen Ziffern.

**%p**
: Bei der Ausgabe **AM** oder **PM** passend zur Locale (bei mehreren Schriftformen bevorzugt Kleinbuchstaben). Bei der Eingabe **AM** oder **PM** der Locale in beliebiger Schreibweise.

**%P**
: Bei der Ausgabe **am** oder **pm** passend zur Locale (bei mehreren Schriftformen bevorzugt Großbuchstaben). Bei der Eingabe **AM** oder **PM** der Locale in beliebiger Schreibweise.

**%Q**
: Diese Formatgruppe ist für den internen Gebrauch in der Tcl-Bibliothek reserviert.

**%r**
: Bei der Ausgabe eine locale-abhängige Tageszeit im 12-Stunden-Format. Bei der Eingabe das, was **%r** erzeugt.

**%R**
: Bei der Ausgabe die Zeit in 24-Stunden-Notation (%H:%M). Mit Sekunden siehe **%T**. Bei der Eingabe das, was **%R** erzeugt.

**%s**
: Bei der Ausgabe wird *timeVal* als Dezimalzahl in die Ausgabe eingefügt. Bei der Eingabe eine Dezimalzahl als Zeitwert ohne weitere Verarbeitung. Da **%s** einen Zeitpunkt eindeutig festlegt, hat es Vorrang vor allen anderen Eingabeformaten.

**%S**
: Bei der Ausgabe die Sekunde (00-59) mit zwei Ziffern. Bei der Eingabe zwei Ziffern als Sekunde.

**%t**
: Bei der Ausgabe ein TAB-Zeichen. Bei der Eingabe ein TAB-Zeichen.

**%T**
: Synonym mit **%H:%M:%S**.

**%u**
: Bei der Ausgabe die Wochentagsnummer (**1**→Montag, **7**→Sonntag). Bei der Eingabe eine Ziffer als Wochentag; Sonntag kann **0** oder **7** sein.

**%U**
: Bei der Ausgabe die Ordinalzahl der Jahrwoche (00-53); der erste Sonntag des Jahres ist Tag 1 der Woche 01. Bei der Eingabe zwei Ziffern, die sonst ignoriert werden. Diese Gruppe bestimmt kein Eingabedatum. Die Deutung war früher im US-Bankwesen üblich, ist heute weitgehend veraltet. ISO8601-Wochennummer: **%V**.

**%V**
: Bei der Ausgabe die ISO8601-Wochennummer (01-53). Woche 01 enthält den 4. Januar, oder ist die erste Woche mit mindestens 4 Tagen, oder enthält den ersten Donnerstag des Jahres (äquivalent). Jede Woche beginnt montags. Bei der Eingabe die ISO8601-Wochennummer.

**%w**
: Bei der Ausgabe die Ordinalzahl des Wochentags (Sonntag==0; Samstag==6). Bei der Eingabe eine Ziffer; Sonntag kann 0 oder 7 sein. **%w** ist nicht die ISO8601-Wochentagsnummer — die liefert **%u**.

**%W**
: Bei der Ausgabe eine Wochennummer (00-53) im Jahr; Woche 01 beginnt am ersten Montag. Bei der Eingabe zwei ignorierte Ziffern. Bestimmt kein Eingabedatum. Nicht die ISO8601-Wochennummer — die liefert **%V**.

**%x**
: Bei der Ausgabe das Datum in locale-abhängiger Darstellung. Bei der Eingabe das, was **%x** erzeugt, zur Bestimmung des Kalenderdatums.

**%X**
: Bei der Ausgabe die Tageszeit in locale-abhängiger Darstellung. Bei der Eingabe das, was **%X** erzeugt, zur Bestimmung der Tageszeit.

**%y**
: Bei der Ausgabe das zweistellige Jahr des Jahrhunderts. Bei der Eingabe zwei Ziffern; das Datum liegt vermutlich zwischen 1938 und 2037. **%y** passt nicht zur ISO8601-Wochennummer **%V** — dafür **%g** verwenden.

**%Y**
: Bei der Ausgabe das vierstellige Kalenderjahr. Bei der Eingabe vier Ziffern zur Datumsbestimmung. **%Y** passt nicht zur ISO8601-Wochennummer **%V** — dafür **%G** verwenden.

**%z**
: Bei der Ausgabe die aktuelle Zeitzone als Offset östlich (+hhmm) oder westlich (-hhmm) von Greenwich. Bei der Eingabe ein Zeitzonen-Spezifizierer (siehe [Zeitzonen]) zur Bestimmung der Zeitzone.

**%Z**
: Bei der Ausgabe den Namen der aktuellen Zeitzone, ggf. in der Locale übersetzt. Bei der Eingabe ein Zeitzonen-Spezifizierer (siehe [Zeitzonen]). Bei der Eingabe im Allgemeinen nur beim Parsen von RFC822-Daten verwenden; sonst mehrdeutig (**BST** z. B. British Summer Time oder Brazilian Standard Time). Für maschinelle Datums-/Zeitstrings numerische Zeitzonen empfohlen.

**%%**
: Bei der Ausgabe ein wörtliches **%**-Zeichen. Bei der Eingabe ein wörtliches **%**-Zeichen.

**%+**
: Synonym mit **%a %b %e %H:%M:%S %Z %Y**.


# Zeitzonen

Verarbeitet der Befehl **clock** eine lokale Zeit, stehen mehrere Quellen für die Zeitzone zur Verfügung, in dieser Reihenfolge:

1. Eine in der zu parsenden Zeichenkette angegebene Zeitzone, erkannt über **%z** oder **%Z**.

2. Eine mit **-timezone** am **clock**-Befehl angegebene Zeitzone (oder gleichwertig **-gmt** **1**).

3. Eine in der Umgebungsvariable **TCL\_TZ** angegebene Zeitzone.

4. Eine in der Umgebungsvariable **TZ** angegebene Zeitzone.

5. Die lokale Zeitzone aus der Systemsteuerung unter Windows.

6. Die Vorstellung der C-Bibliothek über die lokale Zeitzone gemäß **mktime** und **localtime**.


Nur in Fall \[1\] wird geprüft, ob die Zeichenkette eine der folgenden ist:

```
 gmt     ut      utc     bst     wet     wat     at
 nft     nst     ndt     ast     adt     est     edt
 cst     cdt     mst     mdt     pst     pdt     yst
 ydt     hst     hdt     cat     ahst    nt      idlw
 cet     cest    met     mewt    mest    swt     sst
 eet     eest    bt      it      zp4     zp5     ist
 zp6     wast    wadt    jt      cct     jst     cast
 cadt    east    eadt    gst     nzt     nzst    nzdt
 idle
```

Steht die Zeichenkette in dieser Liste, bezeichnet sie eine bekannte Zeitzone.

Für Zeitzonen in Fall \[1\], die nicht in der Liste stehen, und stets in den Fällen \[2\]–\[6\] gelten folgende Regeln.

Beginnt die Zeitzone mit einem Doppelpunkt, ist sie ein standardisierter Name wie **:America/New\_York** mit Regeln für verschiedene Orte. Eine vollständige Liste der Ortsnamen ist hier zu lang. Auf den meisten Tcl-Installationen liegen die Definitionen in benannten Dateien im Verzeichnis „*/no\_backup/tools/lib/tcl9.0/clock/tzdata*“. Auf einigen Unix-Systemen fehlen diese Dateien; die Definitionen stammen dann aus Systemdateien in „*/usr/share/zoneinfo*“, „*/usr/share/lib/zoneinfo*“ oder „*/usr/local/etc/zoneinfo*“. Als Sonderfall bezeichnet **:localtime** die von der C-Bibliothek definierte lokale Zeitzone.

Eine Zeitzone aus Plus- oder Minuszeichen und vier oder sechs Dezimalziffern wird als Offset in Stunden, Minuten und (bei sechs Ziffern) Sekunden von UTC gelesen. Plus bedeutet östlich von Greenwich, Minus westlich.

Eine der Posix-Spezifikation der Umgebungsvariable **TZ** entsprechende Zeichenkette wird erkannt. Die Spezifikation steht unter <https://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap08.html>.

Enthält die Posix-Zeitzone einen DST- (Daylight Saving Time-) Teil ohne Regel für Beginn und Ende der Sommerzeit, gelten Standardregeln. Bei Offsets zwischen 0 und +12 die europäisch/russischen Regeln, sonst die US-Regeln. In Europa (+0 bis +2) Umstellung auf Sommerzeit am letzten Sonntag im März um 1:00 GMT, zurück am letzten Sonntag im Oktober um 2:00 GMT. In Russland (+3 bis +12) gleiche Daten, Umstellung auf Sommerzeit um 2:00 Ortszeit, zurück um 3:00 Ortszeit. In den USA Umstellung auf Sommerzeit am zweiten Sonntag im März um 2:00 Ortszeit, zurück am ersten Sonntag im November um 3:00 Ortszeit. Damit sind DST-Berechnungen in europäischen, russischen und US-(kompatible) Zonen für Daten ab 2007 korrekt, sofern die Regeln sich nicht erneut ändern.

Jede andere Zeitzone wird mit vorangestelltem Doppelpunkt als Ortsname wie oben verarbeitet.

# Lokalisierung

Entwickler, die Datums- und Zeitein-/ausgabe lokalisieren wollen, finden eine Spezifikation unter <https://tip.tcl-lang.org/173>.

# Freiform-Scan

Wird **clock scan** ohne **-format** aufgerufen, wird ein *Freiform-Scan* angefordert. Diese Form ist veraltet, weil zu viele Mehrdeutigkeiten bestehen (bedeutet die Zeichenkette **2000** ein Jahr, eine Tageszeit oder eine Menge?). Keine Regelmenge für Freiform-Daten und -Zeiten liefert in allen Fällen erwartbare Ergebnisse.

Beim Freiform-Scan sind nur **-base** und **-gmt** zulässig. **-timezone** und **-locale** führen ohne **-format** zu einem Fehler.

Für Nutzer von Legacy-Code mit Freiform-Scan folgt die Dokumentation der Interpretation:

Ist nur eine Uhrzeit angegeben, gilt das aktuelle Datum. Enthält *inputString* keine Zeitzonen-Abkürzung, gilt die lokale Zeitzone, außer **-gmt** ist wahr — dann wird die angegebene Zeit relativ zur Greenwich Mean Time gerechnet. **-gmt** beeinflusst nur den berechneten Zeitwert, nicht die Deutung von **-base**.

Ist **-base** gesetzt, muss das nächste Argument ein ganzzahliger Clock-Wert sein; nur das Datum wird verwendet, nicht die Uhrzeit — nützlich für Zeiten an einem bestimmten Tag oder andere datumsrelative Umrechnungen.

*inputString* besteht aus null oder mehr Spezifikationen folgender Form:

*time*
: Eine Tageszeit der Form **hh?:mm?:ss?? ?meridian? ?zone?** oder **hhmm ?meridian? ?zone?**. Ohne Meridian wird **hh** im 24-Stunden-Format interpretiert. Die Formate „24:00“ und „24:00:00“ (mit oder ohne Doppelpunkt) sind nur ohne *meridian* zulässig.

*date*
: Ein bestimmter Monat und Tag mit optionalem Jahr. Zulässige Formate: **mm/dd?/yy?**, **monthname dd?, yy?**, **day, dd monthname ?yy?**, **dd monthname yy**, **?CC?yymmdd** und **dd-monthname-?CC?yy**. Standardjahr ist das aktuelle. Jahre unter 100: 00–68 als 2000–2068, 69–99 als 1969–1999. Nicht alle Plattformen können 38–70 darstellen — Fehler möglich.

*ISO 8601 point-in-time*
: Ein ISO-8601-Zeitpunkt, z. B. **CCyymmddThhmmss**, wobei **T** das wörtliche **T** ist, oder **CCyymmdd hhmmss**, **CCyymmddThh:mm:ss** oder **CCyy-mm-ddThh:mm:ss**. Nur diese vier Formate werden akzeptiert. Der Befehl akzeptiert *nicht* den vollen ISO8601-Umfang. Schaltsekunden werden beispielsweise nicht unterstützt. Die Formate „24:00“ und „24:00:00“ (mit oder ohne Doppelpunkt) werden unterstützt. Andere Formate erkennt **clock scan** mit explizitem **-format**.

*relative time*
: Relativ zur aktuellen Zeit: **number** unit. Einheiten: **year**, **fortnight**, **month**, **week**, **day**, **hour**, **minute** (oder **min**), **second** (oder **sec**), Singular oder Plural wie **3 weeks**. Zusätzlich: **tomorrow**, **yesterday**, **today**, **now**, **last**, **this**, **next**, **ago**.


Das Datum wird in folgenden Schritten berechnet.

Zuerst absolute Datum-/Zeit- Angaben; darauf Wochentags-Spezifikationen; dann relative Angaben. Ist nur ein Datum oder Tag ohne absolute oder relative Zeit angegeben, gilt Mitternacht. Zuletzt Korrektur für Sommerzeit und für den Übergang vom Ende eines langen Monats zu einem kurzen.

Die Rangfolge einzelner Token bzw. die Reihenfolge bei der Berechnung der Zeit ist komplex und hängt stark von der Genauigkeit des Tokentyps ab. Im folgenden Beispiel enthält die zweite Datumszeichenkette „next January“, daher ergibt sich das nächste Jahr, aber im Januar. Die dritte Datumszeichenkette enthält neben „January“ zusätzlich „Fri“, sodass sich der nächste Freitag ergibt. Beide gewinnen daher vor „385 days“ bzw. machen die Angabe genauer, weil diese Tokentypen eine höhere Genauigkeit haben.

```
% clock format [clock scan "5 years 18 months 385 days" -base 0 -gmt 1] -gmt 1
Thu Jul 21 00:00:00 GMT 1977
% clock format [clock scan "5 years 18 months 385 days next January" -base 0 -gmt 1] -gmt 1
Sat Jan 21 00:00:00 GMT 1978
% clock format [clock scan "5 years 18 months 385 days next January Fri" -base 0 -gmt 1] -gmt 1
Fri Jan 27 00:00:00 GMT 1978
```

# Copyright

Copyright © 2004 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.


[file]: file.md
[msgcat]: msgcat.md
