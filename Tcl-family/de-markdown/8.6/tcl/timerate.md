---
CommandName: timerate
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - time(n)
Keywords:
 - performance measurement
 - script
 - time
Copyright:
 - Copyright (c) 2005 Sergey Brester aka sebres.
---

# NAME

timerate - Kalibrierte Messung der Ausführungszeit eines Skripts

# ÜBERSICHT

::: {.synopsis} :::
[timerate]{.cmd} [script]{.arg} [time]{.optarg} [max-count]{.optarg} 
[timerate]{.cmd} [-direct]{.optlit} [-overhead double]{.optarg} [script]{.arg} [time]{.optarg} [max-count]{.optarg} 
[timerate]{.cmd} [-calibrate]{.optlit} [-direct]{.optlit} [script]{.arg} [time]{.optarg} [max-count]{.optarg} 
:::

# BESCHREIBUNG

Der Befehl **timerate** misst kalibriert die Leistung eines Tcl-Befehls oder Skripts *script*. *script* soll so geschrieben sein, dass es während der Messung mehrfach ausgeführt werden kann. Gemessen wird die verstrichene Zeit mit der feinsten verfügbaren Auflösung des Zeitgebers, nicht die CPU-Zeit; interagiert *script* mit dem Betriebssystem, ist dieser Aufwand enthalten. Der Befehl zeigt, wie gut ein Skript oder Tcl-Befehl läuft, und hilft, Engpässe zu finden und die Anwendungsleistung zu justieren.

Die erste und die zweite Form werten *script* aus, bis das Intervall *time* in Millisekunden verstrichen ist, oder 1000 Millisekunden (1 Sekunde), wenn *time* fehlt.

Der Parameter *max-count* kann zusätzlich die Höchstzahl der Auswertungen begrenzen. Ist *max-count* angegeben, stoppt die Auswertung, wenn diese Zahl der Durchläufe erreicht ist oder die Zeit überschritten wird.

Danach kommt eine kanonische tcl-Liste dieser Form zurück:

```
0.095977 [mc]s/# 52095836 # 10419167 #/sec 5000.000 net-ms
```

Sie bedeutet:

**•**
: die durchschnittliche Zeit je Durchlauf in Mikrosekunden (\[**lindex** \$result 0\])

**•**
: wie oft das Skript ausgeführt wurde (\[**lindex** \$result 2\])

**•**
: die geschätzte Rate je Sekunde (\[**lindex** \$result 4\])

**•**
: die geschätzte echte Ausführungszeit ohne Messaufwand (\[**lindex** \$result 6\])

Folgende Optionen kann **timerate** erhalten:

**-calibrate**
: Um sehr schnelle Skripte so genau wie möglich zu messen, kann eine Kalibrierung nötig sein. **-calibrate** kalibriert **timerate** selbst und berechnet den geschätzten Aufwand des angegebenen Skripts als Standardaufwand für spätere Aufrufe von **timerate**. Fehlt *time*, läuft die Kalibrierung bis zu 10 Sekunden.

Die Kalibrierung ist in der derzeitigen Implementierung nicht thread-sicher.

**-overhead** *double*
: **-overhead** gibt eine Schätzung (in Mikrosekunden) des Messaufwands je Durchlauf des getesteten Skripts an. Der übergebene Wert ersetzt für diesen Aufruf von **timerate** den durch eine frühere Kalibrierung geschätzten Aufwand. Solche Ersetzungen lassen sich selbst mit **timerate** messen, wie ein späteres Beispiel zeigt.

**-direct**
: **-direct** führt das angegebene Skript direkt aus, ohne Kompilierung, ähnlich dem Befehl **time**. Damit lässt sich der Aufwand von **Tcl_EvalObjEx**, des Aufrufs kanonischer Listen und der unkompilierten Fassungen bytecodierter Befehle messen. Anders als **time**, das das getestete Skript eine feste Zahl von Durchläufen ausführt, lässt **timerate** es eine feste Zeit laufen. Zusätzlich wird während der gesamten Messung die kompilierte Fassung des Skripts verwendet, als wäre das Skript Teil einer kompilierten Prozedur, wenn **-direct** nicht angegeben ist. Die feste Zeitspanne und die mögliche Kompilierung ergeben genauere Ergebnisse und verhindern sehr lange Läufe langsamer Skripte; das eignet sich für Skripte mit stark schwankender Ausführungszeit.

# BEISPIELE

Schätzen, wie schnell eine einfache Tcl-Schleife **for** (einschließlich der Operationen an der Variable *i*) bis zehn zählt:

```
# kalibrieren
timerate -calibrate {}

# messen
timerate { for {set i 0} {$i<10} {incr i} {} } 5000
```

Schätzen, wie schnell eine einfache Tcl-Schleife **for** ist, ohne den Aufwand der Verwaltung der Schleifenvariable:

```
# Aufwand der Variablenoperationen kalibrieren
set i 0; timerate -calibrate {expr {$i<10}; incr i} 1000

# messen
timerate {
    for {set i 0} {$i<10} {incr i} {}
} 5000
```

Die Geschwindigkeit schätzen, mit der **clock format** nur die Stunde des Tages berechnet, ohne den Aufwand des Skriptteils, der die Zeit dafür vorbereitet:

```
# kalibrieren
timerate -calibrate {}

# Aufwand schätzen
set tm 0
set ovh [lindex [timerate -overhead 0 {
    incr tm [expr {24*60*60}]
}] 0]

# mit geschätztem Aufwand messen
set tm 0
timerate -overhead $ovh {
    clock format $tm -format %H
    incr tm [expr {24*60*60}]; # dieser Aufwand wird ignoriert
} 5000
```

Im letzten Beispiel wird der Aufwand selbst mit **timerate** und **-overhead 0** gemessen. Das ist nötig, weil ausdrückliche Aufwandswerte als absolute Werte gelten und nicht als Zuschlag auf den kalibrierten Standardaufwand. Der kalibrierte Aufwand muss also aus der Messung des Aufwandswerts selbst herausbleiben. Dazu wird beim Messen des Aufwands **-overhead 0** übergeben.
