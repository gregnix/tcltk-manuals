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

Der Befehl **clock** führt mehrere Operationen aus, die Werte ermitteln und bearbeiten, welche Zeitpunkte darstellen. Der Befehl unterstützt mehrere Unterbefehle, die festlegen, welche Aktion der Befehl ausführt.

[clock]{.cmd} [add]{.sub} [timeVal]{.arg} [count unit...]{.optarg} [-option value]{.optarg}
: Addiert einen (möglicherweise negativen) Offset zu einer Zeit, die als ganzzahlige Sekundenanzahl ausgedrückt ist. Eine vollständige Beschreibung finden Sie unter [Uhrzeit-Arithmetik].

[clock]{.cmd} [clicks]{.sub} [-option]{.optarg}
: Wird kein *-option*-Argument angegeben, gibt der Befehl einen hochauflösenden Zeitwert als systemabhängige Ganzzahl zurück. Die Einheit des Werts ist systemabhängig, sollte aber dem Takt mit der höchsten auf dem System verfügbaren Auflösung entsprechen, etwa einem CPU-Zykluszähler. Eine vollständige Beschreibung finden Sie unter [Hochauflösende Zeitmesser].

    Ist das *-option*-Argument **-milliseconds**, ist der Befehl gleichbedeutend mit **clock milliseconds** (siehe unten). Diese Verwendung ist obsolet; **clock milliseconds** ist als bevorzugter Weg anzusehen, eine Anzahl von Millisekunden zu ermitteln.

    Ist das *-option*-Argument **-microseconds**, ist der Befehl gleichbedeutend mit **clock microseconds** (siehe unten). Diese Verwendung ist obsolet; **clock microseconds** ist als bevorzugter Weg anzusehen, eine Anzahl von Mikrosekunden zu ermitteln.

[clock]{.cmd} [format]{.sub} [timeVal]{.arg} [-option value]{.optdot}
: Formatiert eine als ganzzahlige Sekundenanzahl ausgedrückte Zeit in ein Format, das für Benutzer oder externe Programme bestimmt ist. Eine vollständige Beschreibung finden Sie unter [Zeiten formatieren].

[clock]{.cmd} [microseconds]{.sub}
: Gibt die aktuelle Zeit als ganzzahlige Mikrosekundenanzahl zurück. Eine vollständige Beschreibung finden Sie unter [Hochauflösende Zeitmesser].

[clock]{.cmd} [milliseconds]{.sub}
: Gibt die aktuelle Zeit als ganzzahlige Millisekundenanzahl zurück. Eine vollständige Beschreibung finden Sie unter [Hochauflösende Zeitmesser].

[clock]{.cmd} [scan]{.sub} [inputString]{.arg} [-option value]{.optdot}
: Liest eine als Zeichenkette ausgedrückte Zeit ein und erzeugt daraus eine ganzzahlige Sekundenanzahl. Eine vollständige Beschreibung finden Sie unter [Zeiten einlesen].

[clock]{.cmd} [seconds]{.sub}
: Gibt die aktuelle Zeit als ganzzahlige Sekundenanzahl zurück.


## Parameter

*count*
: Eine Ganzzahl, die eine Anzahl einer Zeiteinheit darstellt. Einzelheiten finden Sie unter [Uhrzeit-Arithmetik].

*timeVal*
: Ein an den Befehl **clock** übergebener ganzzahliger Wert, der einen absoluten Zeitpunkt als Anzahl von Sekunden seit der *Epoche* am 1. Januar 1970, 00:00 UTC darstellt. Beachten Sie, dass die Sekundenanzahl keine Schaltsekunden enthält; Sekunden werden so gezählt, als hätte jeder UTC-Tag genau 86400 Sekunden. Tcl reagiert auf Schaltsekunden, indem es seine Uhr einige Minuten lang um einen winzigen Bruchteil beschleunigt oder verlangsamt, bis sie wieder mit UTC übereinstimmt; sein Datenmodell kann keine Minuten mit 59 oder 61 Sekunden darstellen.

*now*
: Anstelle von *timeVal* kann der nicht ganzzahlige Wert **now** als Ersatz für „heute“ verwendet werden; er wird zur Laufzeit einfach als Wert von **clock seconds** eingesetzt. Zum Beispiel:

    **clock format now -f %a; # aktueller Wochentag**

    **clock add now 1 month; # nächster Monat**

*unit*
: Eines der Wörter **seconds**, **minutes**, **hours**, **days**, **weekdays**, **weeks**, **months** oder **years**. Wird zusammen mit *count* verwendet, um ein Zeitintervall anzugeben, zum Beispiel *3 seconds* oder *1 year*.


## Optionen

[-base]{.lit} time
: Legt fest, dass alle relativen Zeiten in einem **clock scan**-Befehl relativ zu *time* angegeben werden. *time* muss als Anzahl nominaler Sekunden seit der Epoche am 1. Januar 1970, 00:00 UTC ausgedrückt sein.

[-format]{.lit} format
: Legt das gewünschte Ausgabeformat für **clock format** oder das erwartete Eingabeformat für **clock scan** fest. Die Zeichenkette *format* besteht aus beliebig vielen Zeichen außer dem Prozentzeichen („**%**“), durchsetzt mit beliebig vielen *Formatgruppen*; das sind Folgen aus zwei oder drei Zeichen, die mit dem Prozentzeichen beginnen. Die zulässigen Formatgruppen und ihre Interpretation sind unter [Formatgruppen] beschrieben.

    Bei **clock format** lautet das Standardformat

    ```
    %a %b %d %H:%M:%S %Z %Y
    ```

    Bei **clock scan** bedeutet das Fehlen der Option **-format**, dass ein „Freiform-Scan“ angefordert wird; was dabei geschieht, ist unter [Freiform-Scan] beschrieben.

[-gmt]{.lit} boolean
: Ist *boolean* wahr, legt die Option fest, dass eine an **clock add**, **clock format** oder **clock scan** übergebene Zeit in UTC verarbeitet wird. Ist *boolean* falsch, erfolgt die Verarbeitung standardmäßig in der lokalen Zeitzone. Diese Verwendung ist obsolet; die korrekte heutige Verwendung besteht darin, die Zeitzone UTC mit „**-timezone** *:UTC*“ oder einer der gleichwertigen Angaben festzulegen.

[-locale]{.lit} localeName
: Legt fest, dass locale-abhängiges Einlesen und Formatieren (sowie Datumsarithmetik für Daten vor der Einführung des Gregorianischen Kalenders) in der durch *localeName* bezeichneten Locale erfolgt. Der Locale-Name kann jede Locale sein, die das Paket [msgcat] akzeptiert, oder der Sondername *system*, der die aktuelle Locale des Prozesses darstellt, oder die leere Zeichenkette, die Tcls Standard-Locale darstellt.

    Der Einfluss der Locale auf Einlesen und Formatieren wird bei den einzelnen Formatgruppen unter [Formatgruppen] erläutert. Der Einfluss der Locale auf die Uhrzeit-Arithmetik wird unter [Uhrzeit-Arithmetik] erläutert.

[-timezone]{.lit} zoneName
: Legt fest, dass Uhrzeit-Arithmetik, Formatierung und Einlesen nach den Regeln der durch *zoneName* angegebenen Zeitzone erfolgen. Die zulässigen Werte und ihre Interpretation sind unter [Zeitzonen] erläutert. Bei Unterbefehlen, die ein **-timezone**-Argument erwarten, wird standardmäßig die *aktuelle Zeitzone* verwendet. Die aktuelle Zeitzone wird, in absteigender Priorität, bestimmt durch:

    1. die Umgebungsvariable **TCL\_TZ**.

    2. die Umgebungsvariable **TZ**.

    3. auf Windows-Systemen die Zeitzoneneinstellungen der Systemsteuerung.


[-validate]{.lit} boolean
: Ist *boolean* wahr (Standard), löst **clock scan** einen Fehler aus, wenn die Eingabe ungültige Werte enthält, z. B. einen Tag des Monats, der größer ist als die Anzahl der Tage im Monat. Wird false angegeben, passt der Befehl die Werte so an, dass sie im zulässigen Bereich liegen. Einzelheiten finden Sie unter [Zeiten einlesen].


Ist keine dieser Angaben vorhanden, werden die C-Funktionen **localtime** und **mktime** verwendet, um zu versuchen, Zeiten zwischen Ortszeit und Greenwich-Zeit umzurechnen. Auf 32-Bit-Systemen ist dieser Ansatz wahrscheinlich fehlerbehaftet, besonders für Zeiten außerhalb des Bereichs (ungefähr die Jahre 1902 bis 2037), der sich in einer 32-Bit-Ganzzahl darstellen lässt.

# Uhrzeit-Arithmetik

Der Befehl **clock add** führt Uhrzeit-Arithmetik auf einem Wert aus, der als erstes Argument übergeben wird (ausgedrückt als nominale Sekunden seit der Epoche am 1. Januar 1970, 00:00 UTC). Die übrigen Argumente (außer den möglichen Optionen **-timezone**, **-locale** und **-gmt**) sind abwechselnd Ganzzahlen und Schlüsselwörter, wobei die Schlüsselwörter aus **seconds**, **minutes**, **hours**, **days**, **weekdays**, **weeks**, **months** oder **years** gewählt werden.

Das Addieren von Sekunden, Minuten und Stunden ist recht einfach: Der angegebene Zeitzuwachs (mal sechzig für Minuten oder mal 3600 für Stunden) wird einfach zu dem an **clock add** übergebenen *timeVal* addiert. Das Ergebnis wird als nominale Anzahl von Sekunden seit der Epoche interpretiert.

Überraschende Ergebnisse können entstehen, wenn ein Zeitpunkt überschritten wird, an dem eine Schaltsekunde eingefügt oder entfernt wird; der Befehl **clock add** ignoriert Schaltsekunden einfach und nimmt daher an, dass die Zeiten in der Folge 23:59:58, 23:59:59, 00:00:00 aufeinander folgen. Diese Annahme wird dadurch aufgefangen, dass Tcls Zeitmodell auf Schaltsekunden reagiert, indem es die Uhr um einen winzigen Betrag beschleunigt oder verlangsamt, bis Tcls Zeit wieder mit der Welt übereinstimmt.

Da das Addieren und Subtrahieren von Stunden über die absolute Zeit definiert ist, werden in Zeitzonen mit Sommerzeit (Daylight Saving Time) feste Zeitbeträge addiert. Zum Beispiel setzt der folgende Code den Wert von **x** auf **04:00:00**, weil die Uhr im betreffenden Intervall umgestellt wurde.

```
set s [clock scan {2004-10-30 05:00:00} \
           -format {%Y-%m-%d %H:%M:%S} \
           -timezone :America/New_York]
set a [clock add $s 24 hours -timezone :America/New_York]
set x [clock format $a \
           -format {%H:%M:%S} -timezone :America/New_York]
```

Das Addieren und Subtrahieren von Tagen und Wochen erfolgt, indem die angegebene Zeit in einen Kalendertag und eine Tageszeit in der passenden Zeitzone und Locale umgewandelt wird. Die erforderliche Anzahl von Tagen (Wochen werden durch Multiplikation mit sieben in Tage umgerechnet) wird zum Kalendertag addiert, und Datum und Uhrzeit werden anschließend wieder in eine Anzahl von Sekunden seit der Epoche umgewandelt. Das Schlüsselwort **weekdays** ähnelt **days**, mit dem einzigen Unterschied, dass Wochenenden – Samstage und Sonntage – übersprungen werden.

Wird eine bestimmte Anzahl von Tagen über den Zeitpunkt hinweg addiert oder subtrahiert, an dem die Uhr zu Beginn oder Ende der Sommerzeit (Daylight Saving Time) umgestellt wird, ergibt sich am betreffenden Tag dieselbe *lokale Uhrzeit*. Zum Beispiel setzt der folgende Code den Wert von **x** auf **05:00:00**.

```
set s [clock scan {2004-10-30 05:00:00} \
           -format {%Y-%m-%d %H:%M:%S} \
           -timezone :America/New_York]
set a [clock add $s 1 day -timezone :America/New_York]
set x [clock format $a \
           -format {%H:%M:%S} -timezone :America/New_York]
```

Bei Mehrdeutigkeit, wenn dieselbe lokale Uhrzeit am selben Tag zweimal vorkommt, wird die frühere Zeit verwendet. Ergibt die Umrechnung eine unmögliche Zeit (etwa 02:30 während der Umstellung auf Sommerzeit im Frühjahr nach US-Regeln), wird die Zeit so umgerechnet, als wäre die Uhr nicht umgestellt worden. Der folgende Code setzt daher den Wert von **x** auf **03:30:00**.

```
set s [clock scan {2004-04-03 02:30:00} \
           -format {%Y-%m-%d %H:%M:%S} \
           -timezone :America/New_York]
set a [clock add $s 1 day -timezone :America/New_York]
set x [clock format $a \
           -format {%H:%M:%S} -timezone :America/New_York]
```

Das Addieren einer bestimmten Anzahl von Tagen oder Wochen funktioniert auch über den Wechsel vom julianischen zum gregorianischen Kalender hinweg korrekt; die ausgelassenen Tage werden übersprungen. Der folgende Code setzt **z** auf **1752-09-14**.

```
set x [clock scan 1752-09-02 -format %Y-%m-%d -locale en_US]
set y [clock add $x 1 day -locale en_US]
set z [clock format $y -format %Y-%m-%d -locale en_US]
```

Im kuriosen Fall, dass das Addieren der angegebenen Anzahl von Tagen ein Datum ergibt, das nicht existiert, weil es in die beim Wechsel vom julianischen zum gregorianischen Kalender ausgelassenen Tage fällt, wird das Datum so umgerechnet, als läge es im julianischen Kalender.

Das Addieren einer Anzahl von Monaten oder Jahren funktioniert ähnlich: Die angegebene Zeit wird in ein Kalenderdatum und eine Tageszeit umgewandelt. Dann wird die erforderliche Anzahl von Monaten oder Jahren addiert, und das resultierende Datum samt Tageszeit wird wieder in eine absolute Zeit umgerechnet.

Ist das resultierende Datum unmöglich, weil der Monat zu wenige Tage hat (zum Beispiel beim Addieren von 1 Monat zum 31. Januar), wird stattdessen der letzte Tag des Monats verwendet. Das Addieren von 1 Monat zum 31. Januar ergibt also in einem Gemeinjahr den 28. Februar und in einem Schaltjahr den 29. Februar.

Für Anomalien im Zusammenhang mit der Sommerzeit und dem Gregorianischen Kalender gelten beim Addieren und Subtrahieren von Monaten und Jahren dieselben Regeln wie beim Addieren und Subtrahieren von Tagen und Wochen.

Sind im Befehl mehrere *count unit*-Paare vorhanden, werden sie nacheinander von links nach rechts ausgewertet.

# Hochauflösende Zeitmesser

Die meisten Unterbefehle des Befehls **clock** arbeiten mit Zeiten, die als Anzahl von Sekunden seit der Epoche dargestellt sind; diese Darstellung gibt auch **clock seconds** zurück. Es gibt drei Ausnahmen, die alle für Fälle gedacht sind, in denen Zeiten mit höherer Auflösung benötigt werden. **clock milliseconds** gibt die Anzahl der Millisekunden seit der Epoche zurück, und **clock microseconds** gibt die Anzahl der Mikrosekunden seit der Epoche zurück. Außerdem gibt es den Befehl **clock clicks**, der einen plattformabhängigen hochauflösenden Timer zurückgibt. Anders als bei **clock seconds** und **clock milliseconds** ist nicht garantiert, dass der Wert von **clock clicks** an eine feste Epoche gebunden ist; er soll lediglich der genaueste verfügbare Intervall-Timer sein und ist nur für relative Zeitmessungen wie Benchmarks gedacht.

# Zeiten formatieren

Der Befehl **clock format** erzeugt Zeiten zur Anzeige für einen Benutzer oder zum Schreiben auf ein externes Medium. Der Befehl akzeptiert Zeiten, die in Sekunden seit der Epoche am 1. Januar 1970, 00:00 UTC ausgedrückt sind, wie sie von **clock seconds**, **clock scan**, **clock add**, [file atime][file] oder [file mtime][file] zurückgegeben werden.

Ist eine Option **-format** vorhanden, ist das folgende Argument eine Zeichenkette, die festlegt, wie Datum und Uhrzeit formatiert werden. Die Zeichenkette besteht aus beliebig vielen Zeichen außer dem Prozentzeichen („**%**“), durchsetzt mit beliebig vielen *Formatgruppen*; das sind Folgen aus zwei Zeichen, die mit dem Prozentzeichen beginnen. Die zulässigen Formatgruppen und ihre Interpretation sind unter [Formatgruppen] beschrieben.

Ist eine Option **-timezone** vorhanden, ist das folgende Argument eine Zeichenkette, die die Zeitzone festlegt, in der Datum und Uhrzeit formatiert werden. Als Alternative zu „**-timezone** *:UTC*“ kann die obsolete Verwendung „**-gmt** *true*“ eingesetzt werden. Die zulässigen Varianten für die Zeitzone finden Sie unter [Zeitzonen].

Ist eine Option **-locale** vorhanden, ist das folgende Argument eine Zeichenkette, die die Locale festlegt, in der die Zeit formatiert wird, und zwar im selben Format wie beim Paket [msgcat]. Beachten Sie, dass ohne Angabe von **-locale** standardmäßig die Root-Locale **{}** gilt und nicht die aktuelle Locale. Die aktuelle Locale erhalten Sie mit **-locale current**. Außerdem unterstützen einige Plattformen eine Locale **system**, die die aktuellen Einstellungen des Benutzers widerspiegelt. Unter Windows zum Beispiel erhalten Sie mit der Locale **system** das Format, das der Benutzer in der Systemsteuerung für Datum und Uhrzeit ausgewählt hat. Auf Plattformen, die keine von **LC\_TIME** getrennte Benutzerauswahl von Datums- und Zeitformaten kennen, ist **-locale system** gleichbedeutend mit **-locale current**.

# Zeiten einlesen

Der Befehl **clock scan** akzeptiert Zeiten, die als Zeichenketten formatiert sind, und wandelt sie in Sekundenanzahlen seit der Epoche am 1. Januar 1970, 00:00 UTC um. Normalerweise erhält er eine Option **-format**, auf die eine Zeichenkette folgt, die das erwartete Format der Eingabe beschreibt. (Wie sich **clock scan** ohne ein solches Argument verhält, ist unter [Freiform-Scan] beschrieben.) Die Zeichenkette besteht aus beliebig vielen Zeichen außer dem Prozentzeichen („**%**“), durchsetzt mit beliebig vielen *Formatgruppen*; das sind Folgen aus zwei Zeichen, die mit dem Prozentzeichen beginnen. Die zulässigen Formatgruppen und ihre Interpretation sind unter [Formatgruppen] beschrieben.

Ist eine Option **-timezone** vorhanden, ist das folgende Argument eine Zeichenkette, die die Zeitzone festlegt, in der Datum und Uhrzeit interpretiert werden. Als Alternative zu **-timezone** *:UTC* kann die obsolete Verwendung **-gmt** *true* eingesetzt werden. Die zulässigen Varianten für die Zeitzone finden Sie unter [Zeitzonen].

Ist eine Option **-locale** vorhanden, ist das folgende Argument eine Zeichenkette, die die Locale festlegt, in der die Zeit interpretiert wird, und zwar im selben Format wie beim Paket [msgcat]. Beachten Sie, dass ohne Angabe von **-locale** standardmäßig die Root-Locale **{}** gilt und nicht die aktuelle Locale. Die aktuelle Locale erhalten Sie mit **-locale current**. Außerdem unterstützen einige Plattformen eine Locale **system**, die die aktuellen Einstellungen des Benutzers widerspiegelt. Unter Windows zum Beispiel erhalten Sie mit der Locale **system** das Format, das der Benutzer in der Systemsteuerung für Datum und Uhrzeit ausgewählt hat. Auf Plattformen, die keine von **LC\_TIME** getrennte Benutzerauswahl von Datums- und Zeitformaten kennen, ist **-locale system** gleichbedeutend mit **-locale current**.

Ist eine Option **-base** vorhanden, ist das folgende Argument eine Zeit (ausgedrückt in Sekunden seit der Epoche), die als *Basiszeit* für die Interpretation relativer Zeiten dient. Ist keine Option **-base** vorhanden, ist die Basiszeit die aktuelle Zeit.

Das Einlesen von Zeiten in festem Format bestimmt drei Dinge: das Datum, die Tageszeit und die Zeitzone. Diese drei werden dann zu einem Zeitpunkt kombiniert, der als Anzahl von Sekunden seit der Epoche zurückgegeben wird.

Bevor das Einlesen beginnt, wird die Formatzeichenkette vorverarbeitet: Die Formatgruppen **%c**, **%Ec**, **%x**, **%Ex**, **%X**, **%Ex**, **%r**, **%R**, **%T**, **%D**, **%EY** und **%+** werden durch Entsprechungen ersetzt, die zur aktuellen Locale passen und keine der genannten Gruppen enthalten. Zum Beispiel wird **%D** (in der Locale **en\_US**) durch **%m/%d/%Y** ersetzt.

Das Datum wird anhand der Felder bestimmt, die in der vorverarbeiteten Formatzeichenkette vorhanden sind. In absteigender Priorität:

1. Enthält die Zeichenkette eine Formatgruppe **%s**, die Sekunden seit der Epoche darstellt, wird diese Gruppe zur Bestimmung des Datums verwendet.

2. Enthält die Zeichenkette die Formatgruppen **%J**, **%EJ** oder **%Ej**, die die kalendarische oder astronomische Julianische Tageszahl darstellen, werden diese Gruppen zur Bestimmung des Datums verwendet. Beachten Sie, dass die Formatgruppen **%EJ** und **%Ej**, die das Julianische Datum mit Tagesbruchteil darstellen, zur Bestimmung von Datum und Uhrzeit verwendet werden können.

3. Enthält die Zeichenkette einen vollständigen Satz von Formatgruppen, der Jahrhundert, Jahr, Monat und Tag des Monats angibt, oder Jahrhundert, Jahr und Tag des Jahres, oder ISO8601-Wochenjahr, Woche des Jahres und Wochentag, werden diese Gruppen kombiniert und zur Bestimmung des Datums verwendet. Ist mehr als ein vollständiger Satz vorhanden, wird derjenige verwendet, der in der Zeichenkette am weitesten rechts steht.

4. Fehlt in der Zeichenkette das Jahrhundert, enthält sie aber einen Satz von Formatgruppen, der Jahr des Jahrhunderts, Monat und Tag des Monats angibt, oder Jahr des Jahrhunderts und Tag des Jahres, oder zweistelliges ISO8601-Wochenjahr, Woche des Jahres und Wochentag, werden diese Gruppen kombiniert und zur Bestimmung des Datums verwendet. Ist mehr als ein vollständiger Satz vorhanden, wird derjenige verwendet, der in der Zeichenkette am weitesten rechts steht. Es wird angenommen, dass das Jahr im Bereich von 1938 bis einschließlich 2037 liegt.

5. Fehlt in der Zeichenkette jede Angabe des Jahres (oder enthält sie das Jahr nur im alternativen Kalender der Locale) und enthält sie einen Satz von Formatgruppen, der Monat und Tag des Monats, Tag des Jahres oder Woche des Jahres und Wochentag angibt, werden diese Gruppen kombiniert und zur Bestimmung des Datums verwendet. Ist mehr als ein vollständiger Satz vorhanden, wird derjenige verwendet, der in der Zeichenkette am weitesten rechts steht. Das Jahr wird bestimmt, indem die Basiszeit in der angegebenen Zeitzone interpretiert wird.

6. Enthält die Zeichenkette keinen der obigen Sätze, aber einen Tag des Monats oder einen Wochentag, werden diese zur Bestimmung des Datums verwendet: Die Basiszeit wird in der angegebenen Zeitzone interpretiert, und der angegebene Tag der aktuellen Woche oder des aktuellen Monats wird zurückgegeben. (Die Woche läuft nach ISO8601 von Montag bis Sonntag.) Sind sowohl Tag des Monats als auch Wochentag vorhanden, hat der Tag des Monats Vorrang.

7. Ergibt keine der obigen Regeln ein brauchbares Datum, wird das Datum der Basiszeit in der angegebenen Zeitzone verwendet.


Auch die Uhrzeit wird anhand der Felder bestimmt, die in der vorverarbeiteten Formatzeichenkette vorhanden sind. In absteigender Priorität:

1. Enthält die Zeichenkette eine Formatgruppe **%s**, die Sekunden seit der Epoche darstellt, bestimmt diese Gruppe die Tageszeit.

2. Enthält die Zeichenkette entweder eine Stunde im 24-Stunden-Format oder eine Stunde im 12-Stunden-Format zusammen mit einer AM/PM-Angabe, bestimmt diese Stunde die Stunde des Tages. Enthält die Zeichenkette außerdem eine Gruppe für die Minute der Stunde, wird diese Gruppe mit der Stunde kombiniert. Enthält die Zeichenkette außerdem eine Gruppe für die Sekunde der Minute, wird diese Gruppe mit Stunde und Minute kombiniert.

3. Enthält die Zeichenkette weder eine Formatgruppe **%s** noch eine Gruppe für die Stunde des Tages, wird Mitternacht (**00:00**, der Beginn des angegebenen Datums) verwendet. Die Zeitzone wird entweder durch die Option **-timezone** oder **-gmt** bestimmt oder durch die aktuelle Zeitzone.


Fehlt in einer Formatzeichenkette eine Formatgruppe **%z** oder **%Z**, kann die Uhrzeit mehrdeutig sein, weil sie am selben Tag zweimal vorkommt, einmal ohne und einmal mit Sommerzeit. Tritt dieser Fall ein, wird das erste Vorkommen der Uhrzeit gewählt. (Aus diesem Grund ist es ratsam, dass die Eingabezeichenkette beim Umrechnen lokaler Zeiten die Zeitzone enthält. Für UTC-Zeiten gilt diese Einschränkung nicht.)

Ergibt die Interpretation der Gruppen eine unmögliche Zeit, weil ein Feld außerhalb seines Bereichs liegt, wird eine Ausnahme ausgelöst, wenn die Option **-validate** fehlt oder als true übergeben wird. Wird sie als false übergeben, wird so viel von der Einheit dieses Feldes zur Zeit addiert oder von ihr subtrahiert, dass der Wert wieder im Bereich liegt. Wird also versucht, Tag 0 des Monats einzulesen oder zu formatieren, wird ein Tag vom Tag 1 des Monats subtrahiert, was den letzten Tag des Vormonats ergibt.

Ergibt die Interpretation der Gruppen eine unmögliche Zeit, weil eine Sommerzeitumstellung diese Zeit überspringt, oder eine mehrdeutige Zeit, weil eine Sommerzeitumstellung zurückspringt, sodass die Uhr die angegebene Zeit zweimal durchläuft, und ist im Format kein Zeitzonen-Spezifizierer (**%z** oder **%Z**) vorhanden, wird die Zeit so interpretiert, als wäre die Uhr nicht umgestellt worden.

# Formatgruppen

Die folgenden Formatgruppen werden von **clock scan** und **clock format** erkannt.

**%a**
: Erzeugt bei der Ausgabe eine Abkürzung (*z. B.* **Mon**) für den Wochentag in der angegebenen Locale. Passt bei der Eingabe auf den Namen des Wochentags in der angegebenen Locale (in abgekürzter oder voller Form oder auf ein beliebiges eindeutiges Präfix einer der beiden Formen).

**%A**
: Erzeugt bei der Ausgabe den vollständigen Namen (*z. B.* **Monday**) des Wochentags in der angegebenen Locale. Passt bei der Eingabe auf den Namen des Wochentags in der angegebenen Locale (in abgekürzter oder voller Form oder auf ein beliebiges eindeutiges Präfix einer der beiden Formen).

**%b**
: Erzeugt bei der Ausgabe eine Abkürzung (*z. B.* **Jan**) für den Namen des Monats in der angegebenen Locale. Passt bei der Eingabe auf den Namen des Monats in der angegebenen Locale (in abgekürzter oder voller Form oder auf ein beliebiges eindeutiges Präfix einer der beiden Formen).

**%B**
: Erzeugt bei der Ausgabe den vollständigen Namen (*z. B.* **January**) des Monats in der angegebenen Locale. Passt bei der Eingabe auf den Namen des Monats in der angegebenen Locale (in abgekürzter oder voller Form oder auf ein beliebiges eindeutiges Präfix einer der beiden Formen).

**%c**
: Erzeugt bei der Ausgabe eine lokalisierte Darstellung von Datum und Tageszeit; von der lokalisierten Darstellung wird erwartet, dass sie den Gregorianischen Kalender verwendet. Passt bei der Eingabe auf alles, was **%c** erzeugt.

**%C**
: Erzeugt bei der Ausgabe die Nummer des Jahrhunderts in indisch-arabischen Ziffern. Passt bei der Eingabe auf eine oder zwei Ziffern, möglicherweise mit vorangestelltem Leerraum, die als Nummer des Jahrhunderts erwartet werden.

**%d**
: Erzeugt bei der Ausgabe die Nummer des Tages im Monat als zwei Dezimalziffern. Passt bei der Eingabe auf eine oder zwei Ziffern, möglicherweise mit vorangestelltem Leerraum, die als Nummer des Tages im Monat erwartet werden.

**%D**
: Diese Formatgruppe ist gleichbedeutend mit **%m/%d/%Y**. Sie sollte nur für den Datenaustausch innerhalb der Locale **en\_US** verwendet werden, da andere Locales für die Felder des Datums typischerweise nicht diese Reihenfolge verwenden.

**%e**
: Erzeugt bei der Ausgabe die Nummer des Tages im Monat als eine oder zwei Dezimalziffern (bei einstelligen Tagen mit vorangestelltem Leerzeichen). Passt bei der Eingabe auf eine oder zwei Ziffern, möglicherweise mit vorangestelltem Leerraum, die als Nummer des Tages im Monat erwartet werden.

**%Ec**
: Erzeugt bei der Ausgabe eine locale-abhängige Darstellung von Datum und Tageszeit im alternativen Kalender der Locale. Passt bei der Eingabe auf alles, was **%Ec** erzeugt. Der alternative Kalender der Locale muss nicht der Gregorianische Kalender sein.

**%EC**
: Erzeugt bei der Ausgabe einen locale-abhängigen Namen einer Ära im alternativen Kalender der Locale. Passt bei der Eingabe auf den Namen der Ära oder ein beliebiges eindeutiges Präfix.

**%EE**
: Erzeugt bei der Ausgabe die Zeichenkette **B.C.E.** oder **C.E.** oder eine Zeichenkette gleicher Bedeutung in der Locale, um anzugeben, ob sich **%Y** auf Jahre vor oder nach dem Jahr 1 unserer Zeitrechnung bezieht. Akzeptiert bei der Eingabe die Zeichenkette **B.C.E.**, **B.C.**, **C.E.**, **A.D.** oder die für die aktuelle Locale passende Abkürzung und legt damit fest, ob sich **%Y** auf Jahre vor oder nach dem Jahr 1 unserer Zeitrechnung bezieht.

**%Ej**
: Erzeugt bei der Ausgabe eine Ziffernfolge, die das astronomische Julianische Datum oder die astronomische Julianische Tageszahl (JDN/JD) angibt. Im Gegensatz zum kalendarischen Julianischen Tag **%J** beginnt der Tag hier um Mittag. Akzeptiert bei der Eingabe eine Ziffernfolge (oder eine Gleitkommazahl mit Tagesbruchteil) und interpretiert sie als astronomische Julianische Tageszahl (JDN/JD). Das astronomische Julianische Datum ist die Anzahl der Kalendertage, die seit dem 1. Januar 4713 v. u. Z. des proleptischen julianischen Kalenders vergangen sind, und enthält zusätzlich den Tagesbruchteil (nach dem Dezimalpunkt). Die Epoche am 1. Januar 1970 entspricht der astronomischen JDN 2440587,5. Dieser Wert entspricht dem Julianischen Tag in SQLite-Datenbanken und ist identisch mit dem Ergebnis von **select julianday(:seconds, 'unixepoch')**.

**%EJ**
: Erzeugt bei der Ausgabe eine Ziffernfolge, die das kalendarische Julianische Datum angibt. Im Gegensatz zur Formatgruppe **%J** für den Julianischen Tag erzeugt sie eine Gleitkommazahl. Im Gegensatz zur Gruppe **%Ej** für den astronomischen Julianischen Tag beginnt der Tag um Mitternacht. Akzeptiert bei der Eingabe eine Ziffernfolge (oder eine Gleitkommazahl mit Tagesbruchteil) und interpretiert sie als kalendarische Julianische Tageszahl. Das kalendarische Julianische Datum ist die Anzahl der Kalendertage, die seit dem 1. Januar 4713 v. u. Z. des proleptischen julianischen Kalenders vergangen sind, und enthält zusätzlich den Tagesbruchteil (nach dem Dezimalpunkt). Die Epoche am 1. Januar 1970 entspricht der astronomischen JDN 2440588.

**%Es**
: Wirkt ähnlich wie **%s**, liest oder formatiert aber im Gegensatz zu **%s** lokale Sekunden (nicht die POSIX-Sekunden). Da **%s** dieselbe Priorität hat wie **%s** (einen Zeitpunkt eindeutig festlegt), setzt es alle anderen Eingabeformate außer Kraft.

**%Ex**
: Erzeugt bei der Ausgabe eine locale-abhängige Darstellung des Datums im alternativen Kalender der Locale. Passt bei der Eingabe auf alles, was **%Ex** erzeugt. Der alternative Kalender der Locale muss nicht der Gregorianische Kalender sein.

**%EX**
: Erzeugt bei der Ausgabe eine locale-abhängige Darstellung der Tageszeit in den alternativen Ziffern der Locale. Passt bei der Eingabe auf alles, was **%EX** erzeugt.

**%Ey**
: Erzeugt bei der Ausgabe eine locale-abhängige Zahl für das Jahr der Ära im alternativen Kalender und in den alternativen Ziffern der Locale. Passt bei der Eingabe auf eine solche Zahl.

**%EY**
: Erzeugt bei der Ausgabe eine Darstellung des Jahres im alternativen Kalender und in den alternativen Ziffern der Locale. Passt bei der Eingabe auf das, was **%EY** erzeugt. Oft gleichbedeutend mit **%EC%Ey**.

**%g**
: Erzeugt bei der Ausgabe eine zweistellige Jahreszahl, die sich für den wochenbasierten ISO8601-Kalender eignet; das heißt, die Jahreszahl gehört zu der Wochennummer, die **%V** erzeugt. Akzeptiert bei der Eingabe eine solche zweistellige Jahreszahl, möglicherweise mit vorangestelltem Leerraum.

**%G**
: Erzeugt bei der Ausgabe eine vierstellige Jahreszahl, die sich für den wochenbasierten ISO8601-Kalender eignet; das heißt, die Jahreszahl gehört zu der Wochennummer, die **%V** erzeugt. Akzeptiert bei der Eingabe eine solche vierstellige Jahreszahl, möglicherweise mit vorangestelltem Leerraum.

**%h**
: Diese Formatgruppe ist gleichbedeutend mit **%b**.

**%H**
: Erzeugt bei der Ausgabe eine zweistellige Zahl, die die Stunde des Tages (00-23) im 24-Stunden-Format angibt. Akzeptiert bei der Eingabe eine solche Zahl.

**%I**
: Erzeugt bei der Ausgabe eine zweistellige Zahl, die die Stunde des Tages (12-11) im 12-Stunden-Format angibt. Akzeptiert bei der Eingabe eine solche Zahl.

**%j**
: Erzeugt bei der Ausgabe eine dreistellige Zahl, die den Tag des Jahres (001-366) angibt. Akzeptiert bei der Eingabe eine solche Zahl.

**%J**
: Erzeugt bei der Ausgabe eine Ziffernfolge, die die Julianische Tageszahl angibt. Akzeptiert bei der Eingabe eine Ziffernfolge und interpretiert sie als Julianische Tageszahl. Die Julianische Tageszahl ist die Anzahl der Kalendertage, die seit dem 1. Januar 4713 v. u. Z. des proleptischen julianischen Kalenders vergangen sind. Die Epoche am 1. Januar 1970 entspricht der Julianischen Tageszahl 2440588.

**%k**
: Erzeugt bei der Ausgabe eine ein- oder zweistellige Zahl, die die Stunde des Tages (0-23) im 24-Stunden-Format angibt. Akzeptiert bei der Eingabe eine solche Zahl.

**%l**
: Erzeugt bei der Ausgabe eine ein- oder zweistellige Zahl, die die Stunde des Tages (12-11) im 12-Stunden-Format angibt. Akzeptiert bei der Eingabe eine solche Zahl.

**%m**
: Erzeugt bei der Ausgabe die Nummer des Monats (01-12) mit genau zwei Ziffern. Akzeptiert bei der Eingabe zwei Ziffern und interpretiert sie als Nummer des Monats.

**%M**
: Erzeugt bei der Ausgabe die Nummer der Minute in der Stunde (00-59) mit genau zwei Ziffern. Akzeptiert bei der Eingabe zwei Ziffern und interpretiert sie als Nummer der Minute in der Stunde.

**%N**
: Erzeugt bei der Ausgabe die Nummer des Monats (1-12) mit einer oder zwei Ziffern, bei einstelligen Werten mit vorangestelltem Leerzeichen. Akzeptiert bei der Eingabe eine oder zwei Ziffern, möglicherweise mit vorangestelltem Leerraum, und interpretiert sie als Nummer des Monats.

**%Od**, **%Oe**, **%OH**, **%OI**, **%Ok**, **%Ol**, **%Om**, **%OM**, **%OS**, **%Ou**, **%Ow**, **%Oy**
: Alle diese Formatgruppen sind gleichbedeutend mit ihren Entsprechungen ohne das „**O**“, nur dass die Zeichenkette in den locale-abhängigen alternativen Ziffern erzeugt und gelesen wird.

**%p**
: Erzeugt bei der Ausgabe eine zur angegebenen Locale passende Angabe für den Tagesabschnitt, **AM** oder **PM**. Unterstützt die Schrift der angegebenen Locale mehrere Buchstabenformen, werden Kleinbuchstaben bevorzugt. Passt bei der Eingabe auf die Darstellung von **AM** oder **PM** in der angegebenen Locale, in Groß- oder Kleinschreibung.

**%P**
: Erzeugt bei der Ausgabe eine zur angegebenen Locale passende Angabe für den Tagesabschnitt, **am** oder **pm**. Unterstützt die Schrift der angegebenen Locale mehrere Buchstabenformen, werden Großbuchstaben bevorzugt. Passt bei der Eingabe auf die Darstellung von **AM** oder **PM** in der angegebenen Locale, in Groß- oder Kleinschreibung.

**%Q**
: Diese Formatgruppe ist für den internen Gebrauch in der Tcl-Bibliothek reserviert.

**%r**
: Erzeugt bei der Ausgabe eine locale-abhängige Darstellung der Tageszeit im 12-Stunden-Format. Akzeptiert bei der Eingabe alles, was **%r** erzeugt.

**%R**
: Erzeugt bei der Ausgabe die Uhrzeit in 24-Stunden-Notation (%H:%M). Eine Variante mit Sekunden finden Sie unter **%T** weiter unten. Akzeptiert bei der Eingabe alles, was **%R** erzeugt.

**%s**
: Formatiert bei der Ausgabe einfach das Argument *timeVal* als dezimale Ganzzahl und fügt es in die Ausgabezeichenkette ein. Akzeptiert bei der Eingabe eine dezimale Ganzzahl und verwendet sie ohne weitere Verarbeitung als Zeitwert. Da **%s** einen Zeitpunkt eindeutig festlegt, setzt es alle anderen Eingabeformate außer Kraft.

**%S**
: Erzeugt bei der Ausgabe eine zweistellige Zahl für die Sekunde der Minute (00-59). Akzeptiert bei der Eingabe zwei Ziffern und verwendet sie als Sekunde der Minute.

**%t**
: Erzeugt bei der Ausgabe ein TAB-Zeichen. Passt bei der Eingabe auf ein TAB-Zeichen.

**%T**
: Gleichbedeutend mit **%H:%M:%S**.

**%u**
: Erzeugt bei der Ausgabe die Nummer des Wochentags (**1**→Montag, **7**→Sonntag). Akzeptiert bei der Eingabe eine einzelne Ziffer und interpretiert sie als Wochentag. Sonntag kann entweder **0** oder **7** sein.

**%U**
: Erzeugt bei der Ausgabe die Ordnungszahl der Woche im Jahr (00-53). Der erste Sonntag des Jahres ist der erste Tag der Woche 01. Akzeptiert bei der Eingabe zwei Ziffern, die ansonsten ignoriert werden. Diese Formatgruppe wird nie zur Bestimmung eines Eingabedatums verwendet. Diese Deutung der Woche des Jahres war früher im US-Bankwesen verbreitet, ist heute aber weitgehend obsolet. Zur ISO8601-Wochennummer siehe **%V**.

**%V**
: Erzeugt bei der Ausgabe die Nummer der ISO8601-Woche als zweistellige Zahl (01-53). Woche 01 ist die Woche, die den 4. Januar enthält; oder die erste Woche des Jahres, die mindestens 4 Tage enthält; oder die Woche, die den ersten Donnerstag des Jahres enthält (die drei Aussagen sind gleichwertig). Jede Woche beginnt an einem Montag. Akzeptiert bei der Eingabe die ISO8601-Wochennummer.

**%w**
: Erzeugt bei der Ausgabe die Ordnungszahl des Wochentags (Sonntag==0; Samstag==6). Akzeptiert bei der Eingabe eine einzelne Ziffer und interpretiert sie als Wochentag; Sonntag kann entweder als 0 oder als 7 dargestellt werden. Beachten Sie, dass **%w** nicht die ISO8601-Wochentagsnummer ist; diese wird von **%u** erzeugt und akzeptiert.

**%W**
: Erzeugt bei der Ausgabe eine Wochennummer (00-53) innerhalb des Jahres; Woche 01 beginnt am ersten Montag des Jahres. Akzeptiert bei der Eingabe zwei Ziffern, die ansonsten ignoriert werden. Diese Formatgruppe wird nie zur Bestimmung eines Eingabedatums verwendet. Sie ist nicht die ISO8601-Wochennummer; diese Woche wird von **%V** erzeugt und akzeptiert.

**%x**
: Erzeugt bei der Ausgabe das Datum in einer locale-abhängigen Darstellung. Akzeptiert bei der Eingabe alles, was **%x** erzeugt, und wird zur Bestimmung des Kalenderdatums verwendet.

**%X**
: Erzeugt bei der Ausgabe die Tageszeit in einer locale-abhängigen Darstellung. Akzeptiert bei der Eingabe alles, was **%X** erzeugt, und wird zur Bestimmung der Tageszeit verwendet.

**%y**
: Erzeugt bei der Ausgabe das zweistellige Jahr des Jahrhunderts. Akzeptiert bei der Eingabe zwei Ziffern und wird zur Bestimmung des Kalenderdatums verwendet. Es wird angenommen, dass das Datum zwischen 1938 und einschließlich 2037 liegt. Beachten Sie, dass **%y** kein Jahr liefert, das sich für die Verwendung mit der ISO8601-Wochennummer **%V** eignet; Programme sollten dafür **%g** verwenden.

**%Y**
: Erzeugt bei der Ausgabe das vierstellige Kalenderjahr. Akzeptiert bei der Eingabe vier Ziffern und kann zur Bestimmung des Kalenderdatums verwendet werden. Beachten Sie, dass **%Y** kein Jahr liefert, das sich für die Verwendung mit der ISO8601-Wochennummer **%V** eignet; Programme sollten dafür **%G** verwenden.

**%z**
: Erzeugt bei der Ausgabe die aktuelle Zeitzone, ausgedrückt in Stunden und Minuten östlich (+hhmm) oder westlich (-hhmm) von Greenwich. Akzeptiert bei der Eingabe einen Zeitzonen-Spezifizierer (siehe [Zeitzonen] unten), der zur Bestimmung der Zeitzone verwendet wird (bei der Eingabe ist dieses Token optional; der Wert ist also nicht zwingend und kann in der Eingabe fehlen).

**%Z**
: Erzeugt bei der Ausgabe den Namen der aktuellen Zeitzone, möglicherweise in die angegebene Locale übersetzt. Akzeptiert bei der Eingabe einen Zeitzonen-Spezifizierer (siehe [Zeitzonen] unten), der zur Bestimmung der Zeitzone verwendet wird (das Token ist wie **%z** bei der Eingabe optional). Diese Option sollte bei der Eingabe im Allgemeinen nur zum Parsen von Datumsangaben nach RFC822 verwendet werden. Andere Verwendungen sind mit Mehrdeutigkeiten behaftet; zum Beispiel kann die Zeichenkette **BST** für British Summer Time oder für Brazilian Standard Time stehen. Für Datums- und Zeitzeichenketten, die von Computern verarbeitet werden, wird empfohlen, stattdessen numerische Zeitzonen zu verwenden.

**%%**
: Erzeugt bei der Ausgabe ein wörtliches „**%**“-Zeichen. Passt bei der Eingabe auf ein wörtliches „**%**“-Zeichen.

**%+**
: Gleichbedeutend mit „**%a %b %e %H:%M:%S %Z %Y**“.


# Zeitzonen

Wenn der Befehl **clock** eine lokale Zeit verarbeitet, stehen ihm mehrere mögliche Quellen für die zu verwendende Zeitzone zur Verfügung. In absteigender Priorität sind dies:

1. Eine Zeitzone, die in einer zu parsenden Zeichenkette angegeben ist und von einer Formatgruppe **%z** oder **%Z** erkannt wird.

2. Eine Zeitzone, die mit der Option **-timezone** des Befehls **clock** angegeben ist (oder gleichwertig mit **-gmt 1**).

3. Eine Zeitzone, die in der Umgebungsvariablen **TCL\_TZ** angegeben ist.

4. Eine Zeitzone, die in der Umgebungsvariablen **TZ** angegeben ist.

5. Die lokale Zeitzone aus der Systemsteuerung auf Windows-Systemen.

6. Die Vorstellung der C-Bibliothek von der lokalen Zeitzone, wie sie durch die Funktionen **mktime** und **localtime** festgelegt ist.


*Nur* im Fall \[1\] wird geprüft, ob die Zeichenkette eine der folgenden Zeichenketten ist:

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

Ist es eine Zeichenkette aus der obigen Liste, bezeichnet sie eine bekannte Zeitzone und wird entsprechend interpretiert.

Für Zeitzonen im Fall \[1\], die keiner der obigen Zeichenketten entsprechen, und stets für die Fälle \[2\]-\[6\] gelten die folgenden Regeln.

Beginnt die Zeitzone mit einem Doppelpunkt, ist sie einer der Namen aus einer standardisierten Liste wie **:America/New\_York**, die die Regeln für verschiedene Orte angeben. Eine vollständige Liste der Ortsnamen ist zu lang, um sie hier aufzuführen. Bei den meisten Tcl-Installationen finden sich die Definitionen der Orte in benannten Dateien im Verzeichnis „*/no\_backup/tools/lib/tcl9.0/clock/tzdata*“. Auf einigen Unix-Systemen fehlen diese Dateien, und die Definitionen werden stattdessen aus Systemdateien in „*/usr/share/zoneinfo*“, „*/usr/share/lib/zoneinfo*“ oder „*/usr/local/etc/zoneinfo*“ bezogen. Als Sonderfall bezeichnet der Name **:localtime** die lokale Zeitzone, wie sie die C-Bibliothek festlegt.

Eine Zeitzonen-Zeichenkette aus einem Plus- oder Minuszeichen, gefolgt von vier oder sechs Dezimalziffern, wird als Offset gegenüber UTC in Stunden, Minuten und (bei sechs Ziffern) Sekunden interpretiert. Das Pluszeichen bezeichnet einen Offset östlich von Greenwich, das Minuszeichen einen westlich von Greenwich.

Eine Zeitzonen-Zeichenkette, die der Posix-Spezifikation der Umgebungsvariablen **TZ** entspricht, wird erkannt. Die Spezifikation finden Sie unter <https://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap08.html>.

Enthält die Posix-Zeitzonen-Zeichenkette einen DST-Teil (Daylight Savings Time, Sommerzeit), aber keine Regel, wann die Sommerzeit beginnt oder endet, werden Standardregeln verwendet. Für Zeitzonen mit einem Offset zwischen 0 und +12 werden die aktuellen europäischen/russischen Regeln verwendet, andernfalls die aktuellen US-Regeln. In Europa (Offset +0 bis +2) erfolgt die Umstellung auf Sommerzeit jeweils am letzten Sonntag im März um 1:00 GMT und die Rückumstellung jeweils am letzten Sonntag im Oktober um 2:00 GMT. In Russland (Offset +3 bis +12) sind die Umstellungstage dieselben, nur erfolgt die Umstellung auf Sommerzeit in allen Zeitzonen um 2:00 Ortszeit und die Rückumstellung um 3:00 Ortszeit. In den USA erfolgt die Umstellung auf Sommerzeit jeweils am zweiten Sonntag im März um 2:00 Ortszeit und die Rückumstellung jeweils am ersten Sonntag im November um 3:00 Ortszeit. Diese Standardregeln bedeuten, dass die Sommerzeitberechnungen in allen europäischen, russischen und US-amerikanischen (oder kompatiblen) Zeitzonen für Daten ab 2007 korrekt sind, sofern sich die Regeln künftig nicht erneut ändern.

Jede andere Zeitzonen-Zeichenkette wird verarbeitet, indem ein Doppelpunkt vorangestellt und versucht wird, sie wie oben beschrieben als Ortsnamen zu verwenden.

# Lokalisierung

Entwickler, die die Formatierung und das Parsen von Datum und Uhrzeit lokalisieren möchten, finden eine Spezifikation unter <https://tip.tcl-lang.org/173>.

# Freiform-Scan

Wird der Befehl **clock scan** ohne Option **-format** aufgerufen, fordert er einen *Freiform-Scan* an. *Diese Form des Einlesens ist veraltet.* Der Grund dafür ist, dass es zu viele Mehrdeutigkeiten gibt. (Stellt die Zeichenkette „2000“ ein Jahr, eine Tageszeit oder eine Menge dar?) Es wurde kein Regelwerk für die Interpretation von Datums- und Zeitangaben in freier Form gefunden, das in allen Fällen unüberraschende Ergebnisse liefert.

Beim Freiform-Scan werden nur die Optionen **-base** und **-gmt** akzeptiert. Die Optionen **-timezone** und **-locale** führen zu einem Fehler, wenn **-format** nicht angegeben ist.

Für Benutzer, die Legacy-Code mit Freiform-Scan verstehen müssen, ist hier dokumentiert, wie der Freiform-Scan eine Zeichenkette interpretiert:

Ist nur eine Uhrzeit angegeben, wird das aktuelle Datum angenommen. Enthält *inputString* kein Zeitzonenkürzel, wird die lokale Zeitzone angenommen, es sei denn, das Argument **-gmt** ist wahr; in diesem Fall wird der Uhrzeitwert unter der Annahme berechnet, dass die angegebene Zeit relativ zur Greenwich Mean Time ist. **-gmt** beeinflusst, falls angegeben, nur den berechneten Zeitwert; auf die Interpretation von **-base** wirkt es sich nicht aus.

Ist die Option **-base** angegeben, sollte das nächste Argument einen ganzzahligen Uhrzeitwert enthalten. Von diesem Wert wird nur das Datum verwendet, nicht die Uhrzeit. Das ist nützlich, um die Uhrzeit an einem bestimmten Tag zu bestimmen oder andere datumsbezogene Umrechnungen vorzunehmen.

Das Argument *inputString* besteht aus null oder mehr Angaben der folgenden Form:

*time*
: Eine Tageszeit der Form „*hh*?**:***mm*?**:***ss*?? ?*meridian*? ?*zone*?“ oder „**hhmm** ?**meridian**? ?**zone**?“. Ist kein *meridian* angegeben, wird *hh* im 24-Stunden-Format interpretiert. Die Formate „24:00“ und „24:00:00“ (mit oder ohne Doppelpunkt) werden nur unterstützt, wenn kein *meridian* angegeben ist.

*date*
: Ein bestimmter Monat und Tag mit optionalem Jahr. Zulässige Formate sind „*mm***/***dd*?**/***yy*?“, „*monthname dd*?**,** *yy*?“, „*day***,** *dd monthname* ?*yy*?“, „*dd monthname yy*“, „?*CC*?*yymmdd*“ und „*dd***-***monthname***-**?*CC*?*yy*“. Das Standardjahr ist das aktuelle Jahr. Ist das Jahr kleiner als 100, werden die Jahre 00-68 als 2000-2068 und die Jahre 69-99 als 1969-1999 behandelt. Nicht alle Plattformen können die Jahre 38-70 darstellen; werden diese Jahre verwendet, kann daher ein Fehler auftreten.

*ISO 8601 point-in-time*
: Eine ISO-8601-Zeitpunktangabe wie „*CCyymmdd***T***hhmmss*“, wobei **T** das wörtliche „T“ ist, „*CCyymmdd hhmmss*“, „*CCyymmdd***T***hh:mm:ss*“ oder „*CCyy-mm-dd***T***hh:mm:ss*“. Beachten Sie, dass nur diese vier Formate akzeptiert werden. Der Befehl akzeptiert *nicht* den vollen Umfang der in ISO8601 festgelegten Zeitpunktangaben. Zum Beispiel werden Schaltsekunden nicht unterstützt. Die Formate „24:00“ und „24:00:00“ (mit oder ohne Doppelpunkt) werden unterstützt. Andere Formate lassen sich erkennen, indem Sie dem Befehl **clock scan** eine explizite Option **-format** übergeben.

*relative time*
: Eine Angabe relativ zur aktuellen Zeit. Das Format ist **number unit**. Zulässige Einheiten sind **year**, **fortnight**, **month**, **week**, **day**, **hour**, **minute** (oder **min**) und **second** (oder **sec**). Die Einheit kann im Singular oder Plural angegeben werden, wie in **3 weeks**. Außerdem können diese Modifikatoren angegeben werden: **tomorrow**, **yesterday**, **today**, **now**, **last**, **this**, **next**, **ago**.


Das tatsächliche Datum wird in den folgenden Schritten berechnet.

Zuerst werden alle absoluten Datums- und/oder Zeitangaben verarbeitet und umgewandelt. Mit dieser Zeit als Basis werden die Wochentagsangaben hinzugefügt. Danach werden die relativen Angaben angewendet. Ist ein Datum oder Tag angegeben, aber keine absolute oder relative Uhrzeit, wird Mitternacht verwendet. Schließlich wird eine Korrektur angewendet, damit nach Berücksichtigung von Sommerzeitunterschieden die richtige Stunde des Tages entsteht und beim Übergang vom Ende eines langen Monats zu einem kurzen Monat das richtige Datum herauskommt.

Die Rangfolge, in der einzelne Token angewendet werden, bzw. die Reihenfolge, die bei der Berechnung der Zeit verwendet wird, ist komplex und hängt z. B. stark von der Genauigkeit des Tokentyps ab. Im folgenden Beispiel enthält die zweite Datumszeichenkette „next January“; daher ergibt sich das nächste Jahr, aber im Januar. Die dritte Datumszeichenkette enthält neben „January“ zusätzlich „Fri“; daher ergibt sich der nächstgelegene Freitag. Beide setzen sich also gegen „385 days“ durch bzw. machen die Angabe genauer, weil diese Tokentypen eine höhere Genauigkeit haben.

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
