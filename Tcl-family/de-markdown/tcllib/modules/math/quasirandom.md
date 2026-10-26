---
CommandName: math::quasirandom
title: math::quasirandom
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - mathematics
 - quasi-random
Copyright:
---

# Name

math::quasirandom – Quasizufällige Punkte für Integrations- und Monte-Carlo-Methoden

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [math::quasirandom]{.lit} [1.1]{.lit}
[::math::quasirandom::qrpoint]{.cmd} [create]{.sub} [NAME]{.arg} [DIM]{.arg} [ARGS]{.optarg}
[gen]{.cmd} [next]{.sub}
[gen]{.cmd} [set-start]{.sub} [index]{.arg}
[gen]{.cmd} [set-evaluations]{.sub} [number]{.arg}
[gen]{.cmd} [integral]{.sub} [func]{.arg} [minmax]{.arg} [args]{.arg}
:::

# Beschreibung

In vielen Anwendungsbereichen spielen Pseudozufallszahlen und Pseudozufallspunkte in einem (begrenzten) Stichprobenraum eine wichtige Rolle. Dies gilt beispielsweise für jede Art von Monte-Carlo-Simulation. Pseudozufallszahlen können jedoch zu zufällig sein, sodass eine große Anzahl von Datenpunkten erforderlich ist, um den Fehler oder die Schwankungen in den Ergebnissen auf den gewünschten Wert zu reduzieren.

Als Alternative können Quasizufallszahlen verwendet werden: Anstelle „völlig“ willkürlicher Punkte werden Punkte erzeugt, die so vielfältig sind, dass sie den gesamten Stichprobenraum mehr oder weniger gleichmäßig abdecken. Folglich kann die Konvergenz gegen den Grenzwert wesentlich schneller erfolgen, wenn solche Quasizufallszahlen gut gewählt sind.

Das Paket definiert eine *Klasse* "qrpoint", die einen Befehl zur Erzeugung quasizufälliger Punkte in einer, zwei oder mehreren Dimensionen bereitstellt. Der Befehl kann entweder einzelne Punkte erzeugen, sodass diese in einem benutzerdefinierten Algorithmus verwendet werden können, oder diese Punkte zur Berechnung von Integralen von Funktionen nutzen, die über 1, 2 oder mehr Dimensionen definiert sind. Er enthält zudem mehrere weitere gängige Algorithmen. (Hinweis: Diese sind noch nicht implementiert.)

Ein besonderes Merkmal der Generatoren besteht darin, dass keine Einstellparameter erforderlich sind, was ihre Verwendung besonders einfach macht.

# Befehle

Mithilfe der Klasse *qrpoint* wird ein Generator für quasizufällige Punkte erstellt:

**::math::quasirandom::qrpoint create** *NAME* *DIM* ?ARGS?
: Dieser Befehl akzeptiert die folgenden Argumente:

    string *NAME*
    : Der Name des zu erstellenden Befehls (alternativ erzeugt der Unterbefehl *new* einen eindeutigen Namen)

    integer/string *DIM*
    : Die Anzahl der Dimensionen oder einer der Werte "circle", "disk", "sphere" oder "ball"

    strings *ARGS*
    : Null oder mehr Schlüssel-Wert-Paare. Die unterstützten Optionen sind:

        - *-start index*: Der Index für den nächsten zu erzeugenden Punkt (Standard: 1)

        - *-evaluations number*: Die Anzahl der standardmäßig zu verwendenden Auswertungen (Standard: 100)




Die zurückgegebenen Punkte liegen im Hyperblock \[0,1\[^n (wobei n die Anzahl der Dimensionen ist) oder auf dem Einheitskreis, innerhalb der Einheitskreisscheibe, auf der Einheitssphäre (Kugeloberfläche) oder innerhalb der Einheitskugel.

Jeder Generator unterstützt die folgenden Unterbefehle:

**gen next**
: Gibt die Koordinaten des nächsten quasizufälligen Punktes zurück

**gen set-start** *index*
: Setzt den Index für den nächsten quasizufälligen Punkt neu. Dies ist nützlich, um zu steuern, welche Liste von Punkten zurückgegeben wird. Gibt den neuen oder den aktuellen Wert zurück, wenn kein Wert angegeben wurde.

**gen set-evaluations** *number*
: Setzt die Standardanzahl der Auswertungen in zusammengesetzten Algorithmen neu. Hinweis: Die tatsächliche Anzahl ist das kleinste Vielfache von 4, das größer oder gleich der angegebenen Zahl ist. (Das Vielfache von 4 spielt bei der detaillierten Integrationsroutine eine Rolle.)

**gen integral** *func* *minmax* *args*
: Berechnet das Integral der angegebenen Funktion über den Block (oder den Kreis, die Kugel usw.).

    string *func*
    : Der Name der zu integrierenden Funktion

    list *minmax*
    : Liste von Paaren aus Minimal- und Maximal-Koordinaten. Diese kann verwendet werden, um die quasizufälligen Koordinaten auf den gewünschten Hyperblock abzubilden.

        Wenn es sich bei dem Raum um einen Kreis, eine Kreisscheibe usw. handelt, sollte dieses Argument ein einzelner Wert sein, nämlich der Radius. Der Kreis, die Kreisscheibe usw. ist auf den Ursprung zentriert. Wenn dies nicht den Anforderungen entspricht, sollte innerhalb der Funktion eine Transformation der Koordinaten vorgenommen werden.

    strings *args*
    : Null oder mehr Schlüssel-Wert-Paare. Die folgenden Optionen werden unterstützt:

        - *-evaluations number*: Die Anzahl der zu verwendenden Auswertungen. Wenn nicht anders angegeben, wird der Standardwert des Generator-Objekts verwendet.




# Noch zu tun

Weitere Algorithmen und Varianten implementieren

Weitere Komponententests implementieren.

Vergleich mit Pseudozufallszahlen für die Integration.

# Literatur

Es gibt verschiedene Algorithmen zur Erzeugung von Quasizufallszahlen. Die in diesem Paket erzeugten Generatoren basieren auf: <http://extremelearning.com.au/unreasonable-effectiveness-of-quasirandom-sequences/>

# Kategorie

Mathematik
