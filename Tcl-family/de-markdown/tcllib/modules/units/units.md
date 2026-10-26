---
CommandName: units
title: units
ManualSection: n
Version: 2.2.3
TclPart: tcllib
TclDescription: Convert and manipulate quantities with units
Keywords:
 - angle
 - constants
 - conversion
 - distance
 - radians
 - unit
Copyright:
 - Copyright (c) 2000-2005 Mayo Foundation
---

# Name

units – Einheitenumrechnung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [units]{.lit} [2.2.3]{.optlit}
[::units::convert]{.cmd} [value]{.arg} [targetUnits]{.arg}
[::units::reduce]{.cmd} [unitString]{.arg}
[::units::new]{.cmd} [name]{.arg} [baseUnits]{.arg}
:::

# Beschreibung

Diese Bibliothek bietet eine Funktion zur Umwandlung verschiedener wissenschaftlicher und technischer Kurzschreibweisen in Gleitkommazahlen. Dadurch können Anwendungsentwickler Werte mit unterschiedlichen Einheiten problemlos in einheitlich skalierte Zahlen umwandeln.

Die Funktion zur Einheitenumrechnung ist zudem in der Lage, zwischen kompatiblen Einheiten umzurechnen.  Wenn beispielsweise eine Anwendung einen Wert in *Ohm* (Widerstand) erwartet und der Benutzer die Einheiten *Milliwebers/Femtocoulomb* legt, wird dies von der Umrechnungsroutine entsprechend verarbeitet. Bei dem Versuch einer falschen Umrechnung wird eine Fehlermeldung ausgegeben.

Werte werden mittels Dimensionsanalyse von einem Einheitensystem in ein anderes umgerechnet. Sowohl die Ausgangseinheiten als auch die Zieleinheiten werden in Elementareinheiten und einen Skalierungsfaktor zerlegt. Die Einheiten werden auf Kompatibilität geprüft, und die Skalierungsfaktoren werden durch Multiplikation und Division angewendet. Diese Methode ist äußerst flexibel und sehr robust.

Neue Einheiten und neue Einheitenabkürzungen können anhand bestehender Einheiten und Abkürzungen definiert werden. Es ist auch möglich, eine neue Grundeinheit zu definieren, obwohl dies wahrscheinlich nicht erforderlich sein wird. Neue Einheiten werden in der Regel definiert, um Nicht-SI-Maßsysteme zu berücksichtigen, beispielsweise die Definition der Einheit *Zoll* als *2,54 cm*.

# Befehle

**::units::convert** *value* *targetUnits*
: Wandelt die Zeichenfolge *value* in eine Gleitkommazahl um, die auf die angegebenen *targetUnits* skaliert wird. Die Zeichenfolge *value* kann eine Zahl und Einheiten enthalten.  Wenn Einheiten festgelegt werden, müssen diese mit den *targetUnits* kompatibel sein.  Werden für den *value* keine Einheiten festgelegt, wird er auf die Zieleinheiten skaliert.  Beispielsweise:

    ```
    % ::units::convert "2.3 miles" km
    3.7014912
    % ::units::convert 300m/s miles/hour
    671.080887616
    % ::units::convert "1.0 m kg/s^2" newton
    1.0
    % ::units::convert 1.0 millimeter
    1000.0
    ```

**::units::reduce** *unitString*
: Gibt eine Einheitenzeichenfolge zurück, die aus einem Skalierungsfaktor und einer durch Leerzeichen getrennten Liste sortierter und reduzierter Grundeinheiten besteht. Die reduzierte Einheitenzeichenfolge kann einen Schrägstrich enthalten (der durch Leerzeichen von den umgebenden Grundeinheiten getrennt ist), der angibt, dass sich die verbleibenden Untereinheiten im Nenner befinden.  Löst einen Fehler aus, wenn die *unitString* ungültig ist.

    ```
    % ::units::reduce pascal
    1000.0 gram / meter second second
    ```

**::units::new** *name* *baseUnits*
: Erstellt eine neue Einheitenumrechnung mit dem festgelegten Namen. Der neue Name *name* darf ausschließlich aus Buchstaben (Groß- oder Kleinbuchstaben) bestehen. Die Zeichenfolge *baseUnits* kann aus jeder gültigen Zeichenfolge für eine Einheitenumrechnung bestehen, einschließlich konstanter Faktoren, Zähler- und Nenneranteile, Einheiten mit Vorsätzen und Exponenten. Die *baseUnits* dürfen eine beliebige Anzahl von Untereinheiten enthalten, müssen sich jedoch auf primitive Einheiten zurückführen lassen.  *BaseUnits* könnte auch die Zeichenfolge *-primitive* sein, um eine neue Art von Größe darzustellen, die sich nicht aus anderen Einheiten ableiten lässt. Dies würden Sie jedoch wahrscheinlich nur tun, wenn Sie eine neue universelle Eigenschaft entdeckt hätten.

    ```
    % ::units::new furlong "220 yards"
    % ::units::new fortnight "14 days"
    % ::units::convert 100m/s furlongs/fortnight
    601288.475303
    ```


# Format der Einheitenzeichenfolge

Das Format für Werte und Einheitenzeichenfolgen ist sehr flexibel. Es ist möglich, praktisch jede Kombination aus Einheiten, Präfixen und Potenzen zu definieren. Gültige Einheitenzeichenfolgen müssen diesen Regeln entsprechen.

- Eine Einheitenfolge besteht aus einem optionalen Skalierungsfaktor, gefolgt von null oder mehr Untereinheiten. Der Skalierungsfaktor muss eine gültige Gleitkommazahl sein und kann von den Untereinheiten getrennt sein oder auch nicht. Der Skalierungsfaktor kann negativ sein.

- Untereinheiten werden durch ein oder mehrere Trennzeichen voneinander getrennt; dabei handelt es sich um Leerzeichen („ “), Bindestrich („-“), Sternchen („\*“) und Schrägstrich („/“).  Sicher, beschweren Sie sich ruhig darüber, dass das Minuszeichen („-“) zur Darstellung der Multiplikation verwendet wird. Das ist mathematisch gesehen einfach nicht korrekt, und eigentlich sollten wir von jedem die Anforderung stellen, das Sternchen („\*“) zur Trennung aller Einheiten zu verwenden.  Letztendlich sind jedoch komplexe Einheitenfolgen wie *m-kg/s^2* angenehm lesbar.

- Das Schrägstrich-Trennzeichen („/“) zeigt an, dass sich die nachfolgenden Untereinheiten im Nenner befinden. Es darf höchstens ein Schrägstrich-Trennzeichen vorhanden sein.

- Untereinheiten können Skalierungsfaktoren mit Gleitkommazahlen sein, müssen jedoch – mit Ausnahme des führenden Skalierungsfaktors – von gültigen Trennzeichen umgeben sein. Skalierungsfaktoren von Untereinheiten dürfen nicht negativ sein. (Beachten Sie, dass der Bindestrich ein Einheitentrennzeichen ist.)

- Untereinheiten können gültige Einheiten oder Abkürzungen sein. Sie können ein Präfix enthalten. Sie können die Pluralendungen „s“ oder „es“ enthalten.  Sie können außerdem eine Potenzangabe enthalten, die durch ein Zirkumflex („^“) gekennzeichnet ist, gefolgt von einer ganzen Zahl, die hinter dem Namen der Einheit (oder dem Plural-Suffix, falls vorhanden) steht. Negative Exponenten sind nicht zulässig.  (Beachten Sie, dass der Bindestrich als Einheitstrennzeichen dient.)


## Beispiele für gültige Einheitenangaben

```
Unit String              Reduced Unit String
------------------------------------------------------------
meter                    1.0 meter
kilometer                1000.0 meter
km                       1000.0 meter
km/s                     1000.0 meter / second
/microsecond             1000000.0 / second
/us                      1000000.0 / second
kg-m/s^2                 1000.0 gram meter / second second
30second                 30.0 second
30 second                30.0 second
30 seconds               30.0 second
200*meter/20.5*second    9.75609756098 meter / second
```

# SI-Einheiten

Die SI-Standardeinheiten sind gemäß der *NIST Special Publication 330* vordefiniert. Die Standardeinheiten sowohl für die SI-Basiseinheiten (Tabelle 1) als auch für die abgeleiteten SI-Einheiten mit speziellen Namen (Tabellen 3a und 3b) sind hier als Referenz enthalten.  Jeder Name und jede Abkürzung einer Standardeinheit sind in diesem Paket enthalten.

## SI-Basiseinheiten

```
Quantity                Unit Name    Abbr.
---------------------------------------------
Length                  meter        m
Mass                    kilogram     kg
Time                    second       s
Current                 ampere       A
Temperature             kelvin       K
Amount                  mole         mol
Luminous Intensity      candela      cd
```

## Abgeleitete SI-Einheiten mit besonderen Namen

```
Quantity                Unit Name    Abbr.   Units     Base Units
--------------------------------------------------------------------
plane angle             radian      rad     m/m       m/m
solid angle             steradian   sr      m^2/m^2   m^2/m^2
frequency               hertz       Hz                /s
force                   newton      N                 m-kg/s^2
pressure                pascal      Pa      N/m^2     kg/m-s^2
energy, work            joule       J       N-m       m^2-kg/s^2
power, radiant flux     watt        W       J/s       m^2-kg/s^3
electric charge         coulomb     C                 s-A
electric potential      volt        V       W/A       m^2-kg/s^3-A
capacitance             farad       F       C/V       s^4-A^2/m^2-kg
electric resistance     ohm                 V/A       m^2-kg/s^3-A^2
electric conductance    siemens     S       A/V       s^3-A^2/m^2-kg
magnetic flux           weber       Wb      V-s       m^2-kg/s^2-A
magnetic flux density   tesla       T       Wb/m^2    kg/s^2-A
inductance              henry       H       Wb/A      m^2-kg/s^2-A^2
luminous flux           lumen       lm                cd-sr
illuminance             lux         lx      lm/m^2    cd-sr/m^2
activity (of a
radionuclide)           becquerel   Bq                /s
absorbed dose           gray        Gy      J/kg      m^2/s^2
dose equivalent         sievert     Sv      J/kg      m^2/s^2
```

Hinweis: Die SI-Einheit Kilogramm wird tatsächlich als Gramm umgesetzt, da 1e-6 Kilogramm = 1 Milligramm und nicht 1 Mikrokilogramm entspricht. Die Abkürzung für den elektrischen Widerstand (Ohm), nämlich das Omega-Zeichen, wird nicht unterstützt.

Außerdem ist zu beachten: Es besteht keine Unterstützung für Temperaturen in Celsius oder Fahrenheit. Die Routinen zur Einheitenumrechnung können Werte lediglich durch Multiplikation und Division skalieren, sodass es nicht möglich ist, thermodynamische Temperaturen (Kelvin) in absolute Grad Celsius oder Fahrenheit umzurechnen.  Die Umrechnung thermodynamischer Größen, wie beispielsweise der thermischen Ausdehnung (pro Temperatureinheit), lässt sich jedoch problemlos in die Bibliothek der Einheiten integrieren.

SI-Einheiten können ein Vorzeichen für ein Vielfaches oder ein Bruchteil einer Einheit tragen. Das Vorzeichen oder dessen Abkürzung sollte ohne Leerzeichen vor der Einheit stehen. Zusammengesetzte Vorzeichen sind nicht zulässig, und ein Vorzeichen sollte niemals allein verwendet werden. Diese Vorzeichen sind in Tabelle 5 der *Special Publication 330* definiert.

## SI-Präfixe

```
Prefix Name     Abbr.   Factor
---------------------------------------
yotta           Y       1e24
zetta           Z       1e21
exa             E       1e18
peta            P       1e15
tera            T       1e12
giga            G       1e9
mega            M       1e6
kilo            k       1e3
hecto           h       1e2
deka            da      1e1
deca                    1e1

deci            d       1e-1
centi           c       1e-2
milli           m       1e-3
micro           u       1e-6
nano            n       1e-9
pico            p       1e-12
femto           f       1e-15
atto            a       1e-18
zepto           z       1e-21
yocto           y       1e-24
```

Hinweis: Wir definieren das gleiche Präfix sowohl in der US-amerikanischen Schreibweise („deka“) als auch in der nicht-US-amerikanischen Schreibweise („deca“). Hinweis: Wir nehmen die Freiheit, die Schreibweise von „micro“ mit einem „u“ anstelle des griechischen Buchstabens Mu zuzulassen.

In der Praxis werden häufig Nicht-SI-Einheiten verwendet.  Anhang B.8 der *NIST Special Publication 811* listet zahlreiche Umrechnungsfaktoren für Nicht-SI-Einheiten auf.  Es ist nicht möglich, alle möglichen Definitionen der Einheiten in dieses Paket aufzunehmen.  In einigen Fällen gibt es für eine bestimmte Einheit je nach Kontext viele verschiedene Umrechnungsfaktoren. (Der Anhang listet über 40 Umrechnungen für britische Wärmeeinheiten auf!)  Anwendungsspezifische Umrechnungen können jederzeit mit dem Befehl **new** hinzugefügt werden, doch einige bekannte und häufig verwendete Umrechnungen sind bereits in diesem Paket enthalten.

## Nicht-SI-Einheiten

```
Unit Name            Abbr.    Base Units
--------------------------------------------------
angstrom                      1.0E-10 m
astronomicalUnit     AU       1.495979E11 m
atmosphere                    1.01325E5 Pa
bar                           1.0E5 Pa
calorie                       4.1868 J
curie                         3.7E10 Bq
day                           8.64E4 s
degree                        1.745329E-2 rad
erg                           1.0E-7 J
faraday                       9.648531 C
fermi                         1.0E-15 m
foot                 ft       3.048E-1 m
gauss                         1.0E-4 T
gilbert                       7.957747E-1 A
grain                gr       6.479891E-5 kg
hectare              ha       1.0E4 m^2
hour                 h        3.6E3 s
inch                 in       2.54E-2 m
lightYear                     9.46073E15 m
liter                L        1.0E-3 m^3
maxwell              Mx       1.0E-8 Wb
mho                           1.0 S
micron                        1.0E-6 m
mil                           2.54E-5 m
mile                 mi       1.609344E3 m
minute               min      6.0E1 s
parsec               pc       3.085E16 m
pica                          4.233333E-3 m
pound                lb       4.535924E-1 kg
revolution                    6.283185 rad
revolutionPerMinute  rpm      1.047198E-1 rad/s
yard                 yd       9.144E-1 m
year                          3.1536E7 s
```

## Größen und abgeleitete Einheiten mit besonderen Namen

Dieses Paket zur Einheitenumrechnung beschränkt sich ausschließlich auf die Umrechnung, den Vergleich und die Skalierung von Einheiten. Dieses Paket berücksichtigt keine der Größennamen, weder für Basiseinheiten noch für abgeleitete Einheiten. Eine ähnliche Implementierung oder eine Erweiterung in einer typisierten oder objektorientierten Sprache könnte benutzerdefinierte Typen für die Größen einführen.  Die Überprüfung des Größentyps könnte beispielsweise dazu dienen, sicherzustellen, dass alle *Längen*-Werte ordnungsgemäß auf *Meter* reduziert werden oder dass alle *Geschwindigkeits*-Werte ordnungsgemäß auf *Meter/Sekunde* reduziert werden.

Es wurde eine C-Implementierung dieses Pakets erstellt, die in Verbindung mit dem „Simplified Wrapper Interface Generator“ (<http://www.swig.org/>) funktioniert. Dieses Paket (units.i) nutzt das Typmap-System von SWIG, um Skript-Größenangaben automatisch in Gleitkommagrößen umzuwandeln.  Funktionsargumente werden als Größentypen festgelegt (z. B. *typedef float Length*), und die Ziel-Einheiten (wie sie vom C-Anwendungscode erwartet werden) werden in einem assoziativen Array festgelegt. Für jeden Größentyp sind zudem Standardeinheiten definiert, die auf alle einheitenlosen Größenangaben angewendet werden.

Ein mit einer Mengen-Typprüfung erweitertes Einheitensystem könnte von der Einbeziehung weiterer abgeleiteter Typen profitieren, die in Form spezieller Einheiten zum Ausdruck gebracht werden, wie in Tabelle 2 der *NIST-Veröffentlichung 330* dargestellt.  Die Größe *Fläche* könnte beispielsweise als Einheiten definiert werden, die sich ordnungsgemäß auf *Meter²* zurückführen lassen, obwohl der Nutzen der Definition einer Einheit mit dem Namen *Quadratmeter* fraglich ist.

# Literatur

Die Namen der Einheiten, Abkürzungen und Werte stammen aus den Veröffentlichungen der Technologieverwaltung des US-Handelsministeriums, des National Institute of Standards and Technology (NIST), in *NIST Special Publication 330: Das Internationale Einheitensystem (SI)* und *NIST Special Publication 811: Leitfaden zur Anwendung des Internationalen Einheitensystems (SI)*. Beide Veröffentlichungen sind (Stand: Dezember 2000) unter <http://physics.nist.gov/cuu/Reference/contents.html> erhältlich.

Die Ideen hinter der Umsetzung dieses Pakets basieren zum Teil auf Code, der 1993 von Adrian Mariano geschrieben wurde und der eine Dimensionsanalyse von Einheitenzeichenfolgen unter Verwendung von Tabellen fester Größe aus C-Strukturen durchführte.  Nachdem Adrians Code Ende der 1990er Jahre verschollen war, tauchte er im Programm „GNU Units“ unter <http://www.gnu.org/software/units/> wieder auf.

# Autoren

Robert W. Techentin

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *units* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Copyright

```
Copyright (c) 2000-2005 Mayo Foundation
```
