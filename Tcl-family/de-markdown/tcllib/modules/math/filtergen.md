---
CommandName: math::filters
title: math::filters
ManualSection: n
Version: 0.4
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - digital
 - filtering
Copyright:
 - Copyright (c) 2020 by Arjen Markus
---

# Name

math::filters – Digitale Filter

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [math::filters]{.lit} [0.4]{.optlit}
[::math::filters::filterButterworth]{.cmd} [lowpass]{.arg} [order]{.arg} [samplefreq]{.arg} [cutofffreq]{.arg}
[::math::filters::filter]{.cmd} [coeffs]{.arg} [data]{.arg}
[::math::filters::filterChebyshev]{.cmd} [lowpass]{.arg} [order]{.arg} [samplefreq]{.arg} [cutofffreq]{.arg} [epsilon]{.optarg}
[::math::filters::filter]{.cmd} [coeffs]{.arg} [data]{.arg}
[::math::filters::filterObject]{.cmd} [new]{.lit} [coeffs]{.arg} [yinit]{.arg}
[$filterObj]{.cmd} [filter]{.lit} [x]{.arg}
[$filterObj]{.cmd} [reset]{.lit}
:::

# Beschreibung

Das Paket **math::filters** implementiert digitale Filter, insbesondere Butterworth- und Tschebyscheff-Tiefpass- sowie Hochpassfilter. Die Prozeduren ermöglichen es, sowohl eine gesamte Datenreihe als auch einzelne Daten nacheinander zu filtern. Hinweis: <https://en.wikipedia.org/wiki/Digital_filter> und weitere Seiten auf Wikipedia beschreiben die Prinzipien und Entwurfsüberlegungen dieser digitalen Filter. Hinweis: Es handelt sich hierbei um eine Neuimplementierung im Vergleich zur Version 0.3, die auf GPL-lizenziertem Code basierte. Eine mögliche Inkompatibilität mit dieser Version besteht darin, dass die Ordnung nun gerade sein muss.

# Prozeduren

Das Paket definiert die folgenden öffentlichen Prozeduren:

**::math::filters::filterButterworth** *lowpass* *order* *samplefreq* *cutofffreq*
: Ermittelt die Koeffizienten für einen Butterworth-Filter einer vorgegebenen (geraden) Ordnung. Die Koeffizienten werden als verschachtelte Liste zurückgegeben, die für den Befehl oder die Methode *filter* geeignet ist,

    bool *lowpass*
    : Erzeugt einen Tiefpassfilter (1) oder einen Hochpassfilter (0)

    integer *order*
    : Die Ordnung des zu erzeugenden Filters – sie muss gerade sein

    double *samplefreq*
    : Abtastfrequenz der Datenreihe

    double *cutofffreq*
    : Grenzfrequenz des Filters (höchstens die Hälfte der Abtastfrequenz)


**::math::filters::filter** *coeffs* *data*
: Filtert die gesamte Datenreihe anhand der Filterkoeffizienten.

    list *coeffs*
    : Liste der Koeffizienten, wie sie von *filterButterworth* generiert wurde (oder eigentlich jede ähnliche Liste von Koeffizienten)

    list *data*
    : Zu filternde Daten


**::math::filters::filterChebyshev** *lowpass* *order* *samplefreq* *cutofffreq* ?*epsilon*?
: Ermittelt die Koeffizienten für einen Tschebyscheff-Filter einer vorgegebenen (geraden) Ordnung. Die Koeffizienten werden als verschachtelte Liste zurückgegeben, die für den Befehl oder die Methode *filter* geeignet ist. Für diese Art von Filtern kann ein zusätzlicher Parameter angegeben werden, der sogenannte Ripple-Faktor. Dieser steuert die Glätte des Verstärkungsfaktors.

    bool *lowpass*
    : Erzeugt einen Tiefpassfilter (1) oder einen Hochpassfilter (0)

    integer *order*
    : Die Ordnung des zu erzeugenden Filters – sie muss gerade sein

    double *samplefreq*
    : Abtastfrequenz der Datenreihe

    double *cutofffreq*
    : Grenzfrequenz des Filters (muss kleiner als die Hälfte der Abtastfrequenz sein)

    double *epsilon*
    : Ripple-Faktor, Standardwert: 0,1


**::math::filters::filter** *coeffs* *data*
: Filtert die gesamte Datenreihe anhand der Filterkoeffizienten.

    list *coeffs*
    : Liste der Koeffizienten, wie sie von *filterButterworth* generiert wurde (oder eigentlich jede ähnliche Liste von Koeffizienten)

    list *data*
    : Zu filternde Daten


**::math::filters::filterObject** new *coeffs* *yinit*
: Erzeugt ein Filterobjekt. Die anfänglichen x-Werte werden mit Null angenommen. Die anfänglichen y-Werte können vorgegeben werden. Werden sie nicht angegeben, werden sie ebenfalls mit Null angenommen.

    list *coeffs*
    : Liste der Koeffizienten, wie sie von *filterButterworth* generiert wurde (oder eigentlich jede ähnliche Liste von Koeffizienten)

    list *yinit*
    : (Optional) Ausgangsdaten für das Filterergebnis.


**$filterObj** filter *x*
: Filtert einen einzelnen Wert und gibt das Ergebnis zurück.

    double *x*
    : Der zu filternde Wert


**$filterObj** reset
: Setzt das Filterobjekt zurück (Neubeginn)


# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2020 by Arjen Markus
```
