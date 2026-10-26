---
CommandName: math::statistics
ManualSection: n
Version: 1.6.1
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - data analysis
 - mathematics
 - statistics
Copyright:
---

# NAME

math::statistics – Grundlegende statistische Funktionen und Prozeduren

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math::statistics]{.lit} [1.6.1]{.lit} 
[::math::statistics::mean]{.cmd} [data]{.arg} 
[::math::statistics::min]{.cmd} [data]{.arg} 
[::math::statistics::max]{.cmd} [data]{.arg} 
[::math::statistics::number]{.cmd} [data]{.arg} 
[::math::statistics::stdev]{.cmd} [data]{.arg} 
[::math::statistics::var]{.cmd} [data]{.arg} 
[::math::statistics::pstdev]{.cmd} [data]{.arg} 
[::math::statistics::pvar]{.cmd} [data]{.arg} 
[::math::statistics::median]{.cmd} [data]{.arg} 
[::math::statistics::basic-stats]{.cmd} [data]{.arg} 
[::math::statistics::histogram]{.cmd} [limits]{.arg} [values]{.arg} [weights]{.optarg} 
[::math::statistics::histogram-alt]{.cmd} [limits]{.arg} [values]{.arg} [weights]{.optarg} 
[::math::statistics::corr]{.cmd} [data1]{.arg} [data2]{.arg} 
[::math::statistics::interval-mean-stdev]{.cmd} [data]{.arg} [confidence]{.arg} 
[::math::statistics::t-test-mean]{.cmd} [data]{.arg} [est_mean]{.arg} [est_stdev]{.arg} [alpha]{.arg} 
[::math::statistics::test-normal]{.cmd} [data]{.arg} [significance]{.arg} 
[::math::statistics::lillieforsFit]{.cmd} [data]{.arg} 
[::math::statistics::test-Duckworth]{.cmd} [list1]{.arg} [list2]{.arg} [significance]{.arg} 
[::math::statistics::test-anova-F]{.cmd} [alpha]{.arg} [args]{.arg} 
[::math::statistics::test-Tukey-range]{.cmd} [alpha]{.arg} [args]{.arg} 
[::math::statistics::test-Dunnett]{.cmd} [alpha]{.arg} [control]{.arg} [args]{.arg} 
[::math::statistics::quantiles]{.cmd} [data]{.arg} [confidence]{.arg} 
[::math::statistics::quantiles]{.cmd} [limits]{.arg} [counts]{.arg} [confidence]{.arg} 
[::math::statistics::autocorr]{.cmd} [data]{.arg} 
[::math::statistics::crosscorr]{.cmd} [data1]{.arg} [data2]{.arg} 
[::math::statistics::mean-histogram-limits]{.cmd} [mean]{.arg} [stdev]{.arg} [number]{.arg} 
[::math::statistics::minmax-histogram-limits]{.cmd} [min]{.arg} [max]{.arg} [number]{.arg} 
[::math::statistics::linear-model]{.cmd} [xdata]{.arg} [ydata]{.arg} [intercept]{.arg} 
[::math::statistics::linear-residuals]{.cmd} [xdata]{.arg} [ydata]{.arg} [intercept]{.arg} 
[::math::statistics::test-2x2]{.cmd} [n11]{.arg} [n21]{.arg} [n12]{.arg} [n22]{.arg} 
[::math::statistics::print-2x2]{.cmd} [n11]{.arg} [n21]{.arg} [n12]{.arg} [n22]{.arg} 
[::math::statistics::control-xbar]{.cmd} [data]{.arg} [nsamples]{.optarg} 
[::math::statistics::control-Rchart]{.cmd} [data]{.arg} [nsamples]{.optarg} 
[::math::statistics::test-xbar]{.cmd} [control]{.arg} [data]{.arg} 
[::math::statistics::test-Rchart]{.cmd} [control]{.arg} [data]{.arg} 
[::math::statistics::test-Kruskal-Wallis]{.cmd} [confidence]{.arg} [args]{.arg} 
[::math::statistics::analyse-Kruskal-Wallis]{.cmd} [args]{.arg} 
[::math::statistics::test-Levene]{.cmd} [groups]{.arg} 
[::math::statistics::test-Brown-Forsythe]{.cmd} [groups]{.arg} 
[::math::statistics::group-rank]{.cmd} [args]{.arg} 
[::math::statistics::test-Wilcoxon]{.cmd} [sample_a]{.arg} [sample_b]{.arg} 
[::math::statistics::spearman-rank]{.cmd} [sample_a]{.arg} [sample_b]{.arg} 
[::math::statistics::spearman-rank-extended]{.cmd} [sample_a]{.arg} [sample_b]{.arg} 
[::math::statistics::kernel-density]{.cmd} [data]{.arg} opt [-option]{.arg} [value]{.arg} ... 
[::math::statistics::bootstrap]{.cmd} [data]{.arg} [sampleSize]{.arg} [numberSamples]{.optarg} 
[::math::statistics::wasserstein-distance]{.cmd} [prob1]{.arg} [prob2]{.arg} 
[::math::statistics::kl-divergence]{.cmd} [prob1]{.arg} [prob2]{.arg} 
[::math::statistics::logistic-model]{.cmd} [xdata]{.arg} [ydata]{.arg} 
[::math::statistics::logistic-probability]{.cmd} [coeffs]{.arg} [x]{.arg} 
[::math::statistics::tstat]{.cmd} [dof]{.arg} [alpha]{.optarg} 
[::math::statistics::mv-wls]{.cmd} [weights_and_values]{.arg} 
[::math::statistics::mv-ols]{.cmd} [values]{.arg} 
[::math::statistics::pdf-normal]{.cmd} [mean]{.arg} [stdev]{.arg} [value]{.arg} 
[::math::statistics::pdf-lognormal]{.cmd} [mean]{.arg} [stdev]{.arg} [value]{.arg} 
[::math::statistics::pdf-exponential]{.cmd} [mean]{.arg} [value]{.arg} 
[::math::statistics::pdf-uniform]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg} 
[::math::statistics::pdf-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg} 
[::math::statistics::pdf-symmetric-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg} 
[::math::statistics::pdf-gamma]{.cmd} [alpha]{.arg} [beta]{.arg} [value]{.arg} 
[::math::statistics::pdf-poisson]{.cmd} [mu]{.arg} [k]{.arg} 
[::math::statistics::pdf-chisquare]{.cmd} [df]{.arg} [value]{.arg} 
[::math::statistics::pdf-student-t]{.cmd} [df]{.arg} [value]{.arg} 
[::math::statistics::pdf-gamma]{.cmd} [a]{.arg} [b]{.arg} [value]{.arg} 
[::math::statistics::pdf-beta]{.cmd} [a]{.arg} [b]{.arg} [value]{.arg} 
[::math::statistics::pdf-weibull]{.cmd} [scale]{.arg} [shape]{.arg} [value]{.arg} 
[::math::statistics::pdf-gumbel]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg} 
[::math::statistics::pdf-pareto]{.cmd} [scale]{.arg} [shape]{.arg} [value]{.arg} 
[::math::statistics::pdf-cauchy]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg} 
[::math::statistics::pdf-laplace]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg} 
[::math::statistics::pdf-kumaraswamy]{.cmd} [a]{.arg} [b]{.arg} [value]{.arg} 
[::math::statistics::pdf-negative-binomial]{.cmd} [r]{.arg} [p]{.arg} [value]{.arg} 
[::math::statistics::cdf-normal]{.cmd} [mean]{.arg} [stdev]{.arg} [value]{.arg} 
[::math::statistics::cdf-lognormal]{.cmd} [mean]{.arg} [stdev]{.arg} [value]{.arg} 
[::math::statistics::cdf-exponential]{.cmd} [mean]{.arg} [value]{.arg} 
[::math::statistics::cdf-uniform]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg} 
[::math::statistics::cdf-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg} 
[::math::statistics::cdf-symmetric-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg} 
[::math::statistics::cdf-students-t]{.cmd} [degrees]{.arg} [value]{.arg} 
[::math::statistics::cdf-gamma]{.cmd} [alpha]{.arg} [beta]{.arg} [value]{.arg} 
[::math::statistics::cdf-poisson]{.cmd} [mu]{.arg} [k]{.arg} 
[::math::statistics::cdf-beta]{.cmd} [a]{.arg} [b]{.arg} [value]{.arg} 
[::math::statistics::cdf-weibull]{.cmd} [scale]{.arg} [shape]{.arg} [value]{.arg} 
[::math::statistics::cdf-gumbel]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg} 
[::math::statistics::cdf-pareto]{.cmd} [scale]{.arg} [shape]{.arg} [value]{.arg} 
[::math::statistics::cdf-cauchy]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg} 
[::math::statistics::cdf-F]{.cmd} [nf1]{.arg} [nf2]{.arg} [value]{.arg} 
[::math::statistics::cdf-laplace]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg} 
[::math::statistics::cdf-kumaraswamy]{.cmd} [a]{.arg} [b]{.arg} [value]{.arg} 
[::math::statistics::cdf-negative-binomial]{.cmd} [r]{.arg} [p]{.arg} [value]{.arg} 
[::math::statistics::empirical-distribution]{.cmd} [values]{.arg} 
[::math::statistics::random-normal]{.cmd} [mean]{.arg} [stdev]{.arg} [number]{.arg} 
[::math::statistics::random-lognormal]{.cmd} [mean]{.arg} [stdev]{.arg} [number]{.arg} 
[::math::statistics::random-exponential]{.cmd} [mean]{.arg} [number]{.arg} 
[::math::statistics::random-uniform]{.cmd} [xmin]{.arg} [xmax]{.arg} [number]{.arg} 
[::math::statistics::random-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [number]{.arg} 
[::math::statistics::random-symmetric-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [number]{.arg} 
[::math::statistics::random-gamma]{.cmd} [alpha]{.arg} [beta]{.arg} [number]{.arg} 
[::math::statistics::random-poisson]{.cmd} [mu]{.arg} [number]{.arg} 
[::math::statistics::random-chisquare]{.cmd} [df]{.arg} [number]{.arg} 
[::math::statistics::random-student-t]{.cmd} [df]{.arg} [number]{.arg} 
[::math::statistics::random-beta]{.cmd} [a]{.arg} [b]{.arg} [number]{.arg} 
[::math::statistics::random-weibull]{.cmd} [scale]{.arg} [shape]{.arg} [number]{.arg} 
[::math::statistics::random-gumbel]{.cmd} [location]{.arg} [scale]{.arg} [number]{.arg} 
[::math::statistics::random-pareto]{.cmd} [scale]{.arg} [shape]{.arg} [number]{.arg} 
[::math::statistics::random-cauchy]{.cmd} [location]{.arg} [scale]{.arg} [number]{.arg} 
[::math::statistics::random-laplace]{.cmd} [location]{.arg} [scale]{.arg} [number]{.arg} 
[::math::statistics::random-kumaraswamy]{.cmd} [a]{.arg} [b]{.arg} [number]{.arg} 
[::math::statistics::random-negative-binomial]{.cmd} [r]{.arg} [p]{.arg} [number]{.arg} 
[::math::statistics::histogram-uniform]{.cmd} [xmin]{.arg} [xmax]{.arg} [limits]{.arg} [number]{.arg} 
[::math::statistics::incompleteGamma]{.cmd} [x]{.arg} [p]{.arg} [tol]{.optarg} 
[::math::statistics::incompleteBeta]{.cmd} [a]{.arg} [b]{.arg} [x]{.arg} [tol]{.optarg} 
[::math::statistics::estimate-pareto]{.cmd} [values]{.arg} 
[::math::statistics::estimate-exponential]{.cmd} [values]{.arg} 
[::math::statistics::estimate-laplace]{.cmd} [values]{.arg} 
[::math::statistics::estimante-negative-binomial]{.cmd} [r]{.arg} [values]{.arg} 
[::math::statistics::filter]{.cmd} [varname]{.arg} [data]{.arg} [expression]{.arg} 
[::math::statistics::map]{.cmd} [varname]{.arg} [data]{.arg} [expression]{.arg} 
[::math::statistics::samplescount]{.cmd} [varname]{.arg} [list]{.arg} [expression]{.arg} 
[::math::statistics::subdivide]{.cmd} 
[::math::statistics::plot-scale]{.cmd} [canvas]{.arg} [xmin]{.arg} [xmax]{.arg} [ymin]{.arg} [ymax]{.arg} 
[::math::statistics::plot-xydata]{.cmd} [canvas]{.arg} [xdata]{.arg} [ydata]{.arg} [tag]{.arg} 
[::math::statistics::plot-xyline]{.cmd} [canvas]{.arg} [xdata]{.arg} [ydata]{.arg} [tag]{.arg} 
[::math::statistics::plot-tdata]{.cmd} [canvas]{.arg} [tdata]{.arg} [tag]{.arg} 
[::math::statistics::plot-tline]{.cmd} [canvas]{.arg} [tdata]{.arg} [tag]{.arg} 
[::math::statistics::plot-histogram]{.cmd} [canvas]{.arg} [counts]{.arg} [limits]{.arg} [tag]{.arg} 
:::

# BESCHREIBUNG

Das Paket **math::statistics** enthält Funktionen und Prozeduren für die grundlegende statistische Datenanalyse, wie zum Beispiel:

**•**
: Deskriptive statistische Kennzahlen (Mittelwert, Minimalwert, Maximalwert, Standardabweichung)

**•**
: Schätzungen der Verteilung in Form von Histogrammen und Quantilen

**•**
: Grundlegende Hypothesentests

**•**
: Wahrscheinlichkeitsdichten und Verteilungsfunktionen. Das Paket soll bei der Entwicklung von Datenanalyseanwendungen oder bei Ad-hoc-Datenanalysen helfen; es ist selbst keine vollständige Anwendung und soll auch nicht mit vollwertigen (nicht-)kommerziellen Statistikpaketen konkurrieren. Der Zweck dieses Dokuments besteht darin, die implementierten Prozeduren zu beschreiben und einige Beispiele für ihre Verwendung zu geben. Da es umfangreiche Literatur zu den verwendeten Algorithmen gibt, verweisen wir für weitere Erläuterungen auf einschlägige Lehrbücher. Das Paket enthält eine recht große Anzahl öffentlicher Prozeduren. Diese lassen sich in drei Gruppen unterteilen: allgemeine Prozeduren, Prozeduren, die sich mit bestimmten statistischen Verteilungen befassen, Listenprozeduren zur Auswahl oder Transformation von Daten sowie einfache Prozeduren zur grafischen Darstellung (diese erfordern Tk). *Hinweis:* Die zu analysierenden Daten sind stets in einer einfachen Liste enthalten. Fehlende Werte werden als leere Elemente der Liste dargestellt. *Hinweis:* Mit Version 1.0.1 wurde ein Fehler in den Prozeduren *pdf-lognormal*, *cdf-lognormal* und *random-lognormal* behoben. In früheren Versionen wurde das Argument für die Standardabweichung tatsächlich so verwendet, als handele es sich um die Varianz.


# ALLGEMEINE PROZEDUREN

Die allgemeinen statistischen Prozeduren sind:

**::math::statistics::mean** *data*
: Ermittelt den Mittelwert (*mean*) der angegebenen Datenliste.


list *data*
: - Liste der Daten


**::math::statistics::min** *data*
: Ermittelt den *Minimalwert* der angegebenen Datenliste.


list *data*
: - Liste der Daten


**::math::statistics::max** *data*
: Ermittelt den *Maximalwert* der angegebenen Datenliste.


list *data*
: - Liste der Daten


**::math::statistics::number** *data*
: Ermittelt die Anzahl (*number*) der nicht fehlenden Daten in der angegebenen Liste


list *data*
: - Liste der Daten


**::math::statistics::stdev** *data*
: Ermittelt die *Stichprobenstandardabweichung* der Daten in der angegebenen Liste


list *data*
: - Liste der Daten


**::math::statistics::var** *data*
: Ermittelt die *Stichprobenvarianz* der Daten in der angegebenen Liste


list *data*
: - Liste der Daten


**::math::statistics::pstdev** *data*
: Ermittelt die *Standardabweichung der Grundgesamtheit* der Daten in der angegebenen Liste


list *data*
: - Liste der Daten


**::math::statistics::pvar** *data*
: Ermittelt die *Varianz der Grundgesamtheit* der Daten in der angegebenen Liste


list *data*
: - Liste der Daten


**::math::statistics::median** *data*
: Ermittelt den *Median* der Daten in der angegebenen Liste (beachten Sie, dass hierfür eine Sortierung der Daten erforderlich ist, was einen hohen Rechenaufwand verursachen kann)


list *data*
: - Liste der Daten


**::math::statistics::basic-stats** *data*
: Ermittelt eine Liste aller beschreibenden Kennzahlen: Mittelwert, Minimalwert, Maximalwert, Anzahl der Daten, Stichprobenstandardabweichung, Stichprobenvarianz, Standardabweichung der Grundgesamtheit und Varianz der Grundgesamtheit. (Diese Routine wird immer aufgerufen, wenn eine oder alle der grundlegenden statistischen Kennzahlen benötigt werden. Daher werden alle Berechnungen durchgeführt und die betreffenden Werte zurückgegeben.)


list *data*
: - Liste der Daten


**::math::statistics::histogram** *limits* *values* ?weights?
: Ermittelt Histogrammdaten für die angegebene Datenliste. Gibt eine Liste zurück, die aus der Anzahl der Werte besteht, die in jedes Intervall fallen. (Das erste Intervall umfasst alle Werte, die kleiner als die erste Grenze sind; das letzte Intervall umfasst alle Werte, die größer als die letzte Grenze sind. Es gibt ein Intervall mehr als es Grenzwerte gibt.) Optional können Sie Gewichte verwenden, um das Histogramm zu beeinflussen.


Liste *limits*
: - Liste der Obergrenzen (in aufsteigender Reihenfolge) für die Intervalle des Histogramms.

list *values*
: - Liste der Daten

Liste *weights*
: - Liste der Gewichte, jeweils ein Gewicht pro Wert


**::math::statistics::histogram-alt** *limits* *values* ?weights?
: Alternative Umsetzung der Histogramm-Prozedur: Das offene Ende der Intervalle liegt an der unteren Grenze statt an der oberen Grenze.


Liste *limits*
: - Liste der Obergrenzen (in aufsteigender Reihenfolge) für die Intervalle des Histogramms.

list *values*
: - Liste der Daten

Liste *weights*
: - Liste der Gewichte, jeweils ein Gewicht pro Wert


**::math::statistics::corr** *data1* *data2*
: Ermittelt den Korrelationskoeffizienten zwischen zwei Datenreihen.


Liste *data1*
: - Erste Liste mit Daten

Liste *data2*
: - Zweite Liste mit Daten


**::math::statistics::interval-mean-stdev** *data* *confidence*
: Gibt das Intervall zurück, das mit einem bestimmten Konfidenzniveau den Mittelwert enthält, sowie eines, das die Standardabweichung enthält (unter der Annahme einer Normalverteilung)


list *data*
: - Liste der Rohdatenwerte (kleine Stichprobe)

float *confidence*
: - Konfidenzniveau (beispielsweise 0,95 oder 0,99)


**::math::statistics::t-test-mean** *data* *est_mean* *est_stdev* *alpha*
: Prüft, ob der Mittelwert einer Stichprobe mit einer bestimmten Wahrscheinlichkeit der geschätzten Normalverteilung entspricht. Gibt 1 zurück, wenn der Test erfolgreich ist, oder 0, wenn der Mittelwert wahrscheinlich nicht zur angegebenen Verteilung passt.


list *data*
: - Liste der Rohdatenwerte (kleine Stichprobe)

float *est_mean*
: - Geschätzter Mittelwert der Verteilung

float *est_stdev*
: - Geschätzte Standardabweichung der Verteilung

float *alpha*
: - Wahrscheinlichkeitsniveau (beispielsweise 0,95 oder 0,99)


**::math::statistics::test-normal** *data* *significance*
: Prüft, ob die angegebenen Daten unter Berücksichtigung eines bestimmten Signifikanzniveaus einer Normalverteilung folgen. Gibt 1 zurück, wenn die Daten innerhalb des Signifikanzniveaus normalverteilt sind; andernfalls wird 0 zurückgegeben. Der zugrunde liegende Test ist der Lilliefors-Test. Geringere Werte der Signifikanz bedeuten eine strengere Prüfung.


list *data*
: - Liste der Werte der Rohdaten

float *significance*
: - Signifikanzniveau (entweder 0,01, 0,05, 0,10, 0,15 oder 0,20). Aus Gründen der Kompatibilität werden auch die Werte "1-significance", 0,80, 0,85, 0,90, 0,95 oder 0,99 akzeptiert.


Kompatibilitätsproblem: In der ursprünglichen Implementierung und Dokumentation wurde der Begriff „confidence“ (Konfidenz) verwendet und ein Wert 1-significance benutzt (siehe Ticket 2812473fff). Dies wurde ab Version 0.9.3 korrigiert.

**::math::statistics::lillieforsFit** *data*
: Gibt den Anpassungsgrad an eine Normalverteilung nach Lilliefors zurück. Je höher der Wert, desto wahrscheinlicher ist es, dass die Daten tatsächlich normalverteilt sind. Für den Test sind mindestens *fünf* Datenpunkte erforderlich.


list *data*
: - Liste der Werte der Rohdaten


**::math::statistics::test-Duckworth** *list1* *list2* *significance*
: Ermittelt anhand des Tukey-Duckworth-Tests, ob zwei Datensätze denselben Median aufweisen. Die Prozedur gibt 0 zurück, wenn die Mediane ungleich sind, 1, wenn sie gleich sind, und -1, wenn der Test nicht durchgeführt werden kann (der kleinste Wert muss in einem anderen Datensatz liegen als der größte Wert). # # Argumente: #     list1 Werte des ersten Datensatzes #     list2 Werte des zweiten Datensatzes #     significance    Signifikanzniveau (entweder 0,05, 0,01 oder 0,001) # # Gibt zurück: Prüft, ob die angegebenen Daten einer Normalverteilung mit einem bestimmten Signifikanzniveau folgen. Gibt 1 zurück, wenn die Daten innerhalb des Signifikanzniveaus normalverteilt sind, andernfalls 0. Der zugrunde liegende Test ist der Lilliefors-Test. Kleinere Werte des Signifikanzniveaus bedeuten eine strengere Prüfung.


Liste *list1*
: - Erste Liste mit Daten

Liste *list2*
: - Zweite Liste mit Daten

float *significance*
: - Signifikanzniveau (entweder 0,05, 0,01 oder 0,001)


**::math::statistics::test-anova-F** *alpha* *args*
: Ermittelt, ob zwei oder mehr Gruppen mit normalverteilten Daten dieselben Mittelwerte aufweisen. Die Prozedur gibt 0 zurück, wenn die Mittelwerte wahrscheinlich ungleich sind, und 1, wenn sie gleich sind. Hierbei handelt es sich um eine einfaktorielle Varianzanalyse (One-Way-ANOVA). Die Gruppen können auch in einer verschachtelten Liste gespeichert sein: Die Prozedur gibt für jedes Gruppenpaar eine Liste der Vergleichsergebnisse zurück. Jedes Element dieser Liste enthält: den Index der ersten Gruppe und den der zweiten Gruppe, die Angabe, ob die Mittelwerte wahrscheinlich unterschiedlich sind (1) oder nicht (0), sowie das Konfidenzintervall, auf dem die Schlussfolgerung basiert. Die Gruppen können auch in einer verschachtelten Liste gespeichert sein:


```
    test-anova-F 0.05 $A $B $C
    #
    # Or equivalently:
    #
    test-anova-F 0.05 [list $A $B $C]
```

float *alpha*
: - Signifikanzniveau

list *args*
: - Zwei oder mehr zu prüfende Datengruppen


**::math::statistics::test-Tukey-range** *alpha* *args*
: Stellt mithilfe des Tukey-Spannweitentests fest, ob zwei oder mehr Gruppen mit normalverteilten Daten dieselben Mittelwerte aufweisen. Dieser Test ergänzt den ANOVA-Test. Die Prozedur gibt eine Liste der Vergleichsergebnisse für jedes Gruppenpaar zurück. Jedes Element dieser Liste enthält: den Index der ersten Gruppe und den der zweiten Gruppe, die Angabe, ob die Mittelwerte wahrscheinlich unterschiedlich sind (1) oder nicht (0), sowie das Konfidenzintervall, auf dem die Schlussfolgerung basiert. Die Gruppen können ebenso wie beim ANOVA-Test auch in einer verschachtelten Liste gespeichert werden.


float *alpha*
: - Signifikanzniveau – entweder 0,05 oder 0,01

list *args*
: - Zwei oder mehr zu prüfende Datengruppen


**::math::statistics::test-Dunnett** *alpha* *control* *args*
: Stellt mithilfe des Dunnett-Tests fest, ob eine oder mehrere Gruppen mit normalverteilten Daten denselben Mittelwert wie die Kontrollgruppe aufweisen. Dieser Test ergänzt den ANOVA-Test. Die Prozedur gibt eine Liste der Vergleichsergebnisse für jede Gruppe im Vergleich zur Kontrollgruppe zurück. Jedes Element dieser Liste enthält: die Angabe, ob die Mittelwerte wahrscheinlich unterschiedlich sind (1) oder nicht (0), sowie das Konfidenzintervall, auf dem diese Schlussfolgerung basiert. Die Gruppen können ebenso wie beim ANOVA-Test auch in einer verschachtelten Liste gespeichert werden. Hinweis: Besondere Vorsicht ist geboten, wenn nur eine Gruppe zum Vergleich mit der Kontrollgruppe vorhanden ist:


```
    test-Dunnett-F 0.05 $control [list $A]
```

: Ansonsten wird die Gruppe A in Gruppen mit jeweils einem Element aufgeteilt – dies ist auf eine Mehrdeutigkeit zurückzuführen.


float *alpha*
: - Signifikanzniveau – entweder 0,05 oder 0,01

list *args*
: - Eine oder mehrere zu prüfende Datengruppen


**::math::statistics::quantiles** *data* *confidence*
: Gibt die Quantile für einen bestimmten Datensatz zurück


list *data*
: - Liste der Werte der Rohdaten

float *confidence*
: - Konfidenzniveau (beispielsweise 0,95 oder 0,99) oder eine Liste von Konfidenzniveaus.


**::math::statistics::quantiles** *limits* *counts* *confidence*
: Gibt die Quantile auf der Grundlage der Histogrammdaten zurück (Alternative zum Aufruf mit zwei Argumenten)


Liste *limits*
: - Liste der Obergrenzen aus dem Histogramm

Liste *counts*
: - Liste der Häufigkeiten für jedes Intervall im Histogramm

float *confidence*
: -  Konfidenzniveau (beispielsweise 0,95 oder 0,99) oder eine Liste von Konfidenzniveaus.


**::math::statistics::autocorr** *data*
: Gibt die Autokorrelationsfunktion als Liste von Werten zurück (unter der Annahme gleichmäßiger Abstände zwischen den Stichproben, etwa die Hälfte der Anzahl der Rohdaten). Die Korrelation wird so bestimmt, dass der erste Wert stets 1 ist und alle anderen Werte gleich oder kleiner als 1 sind. Die Anzahl der beteiligten Werte nimmt mit zunehmender „Zeit“ (dem Index in der Liste der zurückgegebenen Werte) ab.


list *data*
: - Rohdaten, für die die Autokorrelation bestimmt werden muss


**::math::statistics::crosscorr** *data1* *data2*
: Gibt die Kreuzkorrelationsfunktion als Liste von Werten zurück (unter der Annahme gleichmäßiger Abstände zwischen den Stichproben, etwa die Hälfte der Anzahl der Rohdaten). Die Korrelation wird so berechnet, dass die Werte betragsmäßig niemals größer als 1 sein können. Die Anzahl der beteiligten Werte nimmt mit zunehmender „Zeit“ (dem Index in der Liste der zurückgegebenen Werte) ab.


Liste *data1*
: - Erste Liste mit Daten

Liste *data2*
: - Zweite Liste mit Daten


**::math::statistics::mean-histogram-limits** *mean* *stdev* *number*
: Ermittelt anhand von Mittelwert und Standardabweichung sinnvolle Grenzen für ein Histogramm. Hilfsfunktion – das Ergebnis eignet sich für die Histogrammfunktion.


float *mean*
: - Mittelwert der Daten

float *stdev*
: - Standardabweichung

int *number*
: - Anzahl der zu generierenden Grenzwerte (Standardwert: 8)


**::math::statistics::minmax-histogram-limits** *min* *max* *number*
: Ermittelt anhand eines Minimal- und Maximalwerts sinnvolle Grenzen für ein Histogramm. Hilfsfunktion – das Ergebnis eignet sich für die Histogrammfunktion.


float *min*
: - Erwarteter Mindestwert

float *max*
: - Erwarteter Höchstwert

int *number*
: - Anzahl der zu generierenden Grenzwerte (Standardwert: 8)


**::math::statistics::linear-model** *xdata* *ydata* *intercept*
: Ermittelt die Koeffizienten für eine lineare Regression zwischen zwei Datenreihen (das Modell: Y = A + B\*X). Gibt eine Liste von Parametern zurück, die die Anpassung beschreiben


Liste *xdata*
: - Liste unabhängiger Daten

Liste *ydata*
: - Liste der anzupassenden abhängigen Daten

boolean *intercept*
: - (Optional) Achsenabschnitt berechnen (1, Standard) oder an eine Gerade durch den Ursprung anpassen (0). Das Ergebnis besteht aus der folgenden Liste:


**•**
: (Schätzung des) Achsenabschnitts A

**•**
: (Schätzung der) Steigung B

**•**
: Standardabweichung von Y relativ zur Anpassung

**•**
: Korrelationskoeffizient R²

**•**
: Anzahl der Freiheitsgrade df

**•**
: Standardfehler des Achsenabschnitts A

**•**
: Signifikanzniveau von A

**•**
: Standardfehler der Steigung B

**•**
: Signifikanzniveau von B


**::math::statistics::linear-residuals** *xdata* *ydata* *intercept*
: Ermittelt die Differenz zwischen den Ist-Werten und den vom linearen Modell vorhergesagten Werten. Gibt eine Liste der Differenzen zwischen den Ist-Werten und den vorhergesagten Werten zurück.


Liste *xdata*
: - Liste unabhängiger Daten

Liste *ydata*
: - Liste der anzupassenden abhängigen Daten

boolean *intercept*
: - (Optional) Achsenabschnitt berechnen (1, Standard) oder an eine Gerade durch den Ursprung anpassen (0)


**::math::statistics::test-2x2** *n11* *n21* *n12* *n22*
: Ermittelt, ob sich zwei Stichproben, die jeweils einer Binomialverteilung folgen, signifikant voneinander unterscheiden oder nicht (was auf einen unterschiedlichen Parameter hindeuten würde). Gibt den „Chi-Quadrat“-Wert zurück, anhand dessen die Signifikanz bestimmt werden kann.


int *n11*
: - Anzahl der Ergebnisse mit dem ersten Wert aus der ersten Stichprobe.

int *n21*
: - Anzahl der Ergebnisse mit dem ersten Wert aus der zweiten Stichprobe.

int *n12*
: - Anzahl der Ergebnisse mit dem zweiten Wert aus der ersten Stichprobe.

int *n22*
: - Anzahl der Ergebnisse mit dem zweiten Wert aus der zweiten Stichprobe.


**::math::statistics::print-2x2** *n11* *n21* *n12* *n22*
: Ermittelt, ob sich zwei Stichproben, die jeweils einer Binomialverteilung folgen, signifikant voneinander unterscheiden oder nicht (was auf einen unterschiedlichen Parameter hindeuten würde). Gibt einen kurzen Bericht zurück, der in einer interaktiven Sitzung nützlich ist.


int *n11*
: - Anzahl der Ergebnisse mit dem ersten Wert aus der ersten Stichprobe.

int *n21*
: - Anzahl der Ergebnisse mit dem ersten Wert aus der zweiten Stichprobe.

int *n12*
: - Anzahl der Ergebnisse mit dem zweiten Wert aus der ersten Stichprobe.

int *n22*
: - Anzahl der Ergebnisse mit dem zweiten Wert aus der zweiten Stichprobe.


**::math::statistics::control-xbar** *data* ?nsamples?
: Ermittelt die Kontrollgrenzen für ein xbar-Diagramm. Die Anzahl der Daten in jeder Teilstichprobe beträgt standardmäßig 4. Es sind mindestens 20 Teilstichproben erforderlich. Gibt den Mittelwert, die Untergrenze, die Obergrenze und die Anzahl der Daten pro Teilstichprobe zurück.


list *data*
: - Liste der Beobachtungsdaten

int *nsamples*
: - Anzahl der Daten pro Teilstichprobe


**::math::statistics::control-Rchart** *data* ?nsamples?
: Ermittelt die Kontrollgrenzen für ein R-Diagramm. Die Anzahl der Daten in jeder Teilstichprobe (nsamples) ist standardmäßig auf 4 festgelegt. Es sind mindestens 20 Teilstichproben erforderlich. Gibt die mittlere Spannweite, die untere Grenze, die obere Grenze und die Anzahl der Daten pro Teilstichprobe zurück.


list *data*
: - Liste der Beobachtungsdaten

int *nsamples*
: - Anzahl der Daten pro Teilstichprobe


**::math::statistics::test-xbar** *control* *data*
: Ermittelt, ob die Daten die Kontrollgrenzen für das xbar-Diagramm überschreiten. Gibt eine Liste der Teilstichproben (bzw. deren Indizes) zurück, die tatsächlich die Grenzen überschreiten.


Liste *control*
: - Kontrollgrenzen, wie sie von der Prozedur "control-xbar" zurückgegeben werden

list *data*
: - Liste der Beobachtungsdaten


**::math::statistics::test-Rchart** *control* *data*
: Ermittelt, ob die Daten die Kontrollgrenzen für das R-Diagramm überschreiten. Gibt eine Liste der Teilstichproben (bzw. deren Indizes) zurück, die tatsächlich die Grenzen überschreiten.


Liste *control*
: - Kontrollgrenzen, wie sie von der Prozedur "control-Rchart" zurückgegeben werden

list *data*
: - Liste der Beobachtungsdaten


**::math::statistics::test-Kruskal-Wallis** *confidence* *args*
: Prüft mithilfe des Kruskal-Wallis-Tests, ob die Mediane der Grundgesamtheiten von zwei oder mehr Gruppen bei einem vorgegebenen Konfidenzniveau gleich sind.


float *confidence*
: - Zu verwendendes Konfidenzniveau (0–1)

list *args*
: - Zwei oder mehr Datenlisten


**::math::statistics::analyse-Kruskal-Wallis** *args*
: Berechnet die statistischen Kennzahlen für den Kruskal-Wallis-Test. Gibt die Kruskal-Wallis-Statistik sowie die Wahrscheinlichkeit zurück, mit der dieser Wert auftreten würde, wenn die Mediane der Grundgesamtheiten gleich wären.


list *args*
: - Zwei oder mehr Datenlisten


**::math::statistics::test-Levene** *groups*
: Berechnet die Levene-Statistik, um festzustellen, ob Gruppen von Daten dieselbe Varianz aufweisen (homoskedastisch sind) oder nicht. Die Daten sind in Gruppen organisiert. Bei dieser Version wird der Mittelwert der Daten als Maß zur Bestimmung der Abweichungen herangezogen. Die Statistik entspricht einer F-Statistik mit den Freiheitsgraden k-1 und N-k, wobei k die Anzahl der Gruppen und N die Gesamtzahl der Daten ist.


Liste *groups*
: - Liste der Datengruppen


**::math::statistics::test-Brown-Forsythe** *groups*
: Berechnet die Brown-Forsythe-Statistik, um festzustellen, ob Datengruppen dieselbe Varianz aufweisen (homoskedastisch sind) oder nicht. Ähnlich wie beim Levene-Test, allerdings wird bei dieser Variante der Median der Daten herangezogen.


Liste *groups*
: - Liste der Datengruppen


**::math::statistics::group-rank** *args*
: Bestimmt die Ränge der Daten aller Gruppen bezogen auf die gesamte Datenmenge. Gibt eine Liste zurück, die für jeden Datenpunkt die Gruppen-ID, den Wert und den Rang (im Falle von Gleichständen möglicherweise eine rationale Zahl) enthält.


list *args*
: - Zwei oder mehr Datenlisten


**::math::statistics::test-Wilcoxon** *sample_a* *sample_b*
: Berechnet die Wilcoxon-Teststatistik, um festzustellen, ob zwei Stichproben denselben Median aufweisen oder nicht. (Die Statistik kann als standardnormal angesehen werden, wenn beide Stichprobengrößen größer als 10 sind.) Gibt den Wert dieser Statistik zurück.


Liste *sample_a*
: - Liste der Daten, aus denen sich die erste Stichprobe zusammensetzt

Liste *sample_b*
: - Liste der Daten, aus denen sich die zweite Stichprobe zusammensetzt


**::math::statistics::spearman-rank** *sample_a* *sample_b*
: Gibt als Alternative zum gewöhnlichen (Pearson-)Korrelationskoeffizienten die Spearman-Rangkorrelation zurück. Die beiden Stichproben sollten die gleiche Anzahl an Datenpunkten aufweisen.


Liste *sample_a*
: - Erste Liste mit Daten

Liste *sample_b*
: - Zweite Liste mit Daten


**::math::statistics::spearman-rank-extended** *sample_a* *sample_b*
: Gibt als Alternative zum gewöhnlichen (Pearson-)Korrelationskoeffizienten die Spearman-Rangkorrelation sowie zusätzliche Daten zurück. Die beiden Stichproben sollten die gleiche Anzahl an Datenpunkten aufweisen. Die Prozedur gibt den Korrelationskoeffizienten, die Anzahl der verwendeten Datenpaare und den z-Wert zurück, eine annähernd standardnormalverteilte Statistik, die die Signifikanz der Korrelation angibt.


Liste *sample_a*
: - Erste Liste mit Daten

Liste *sample_b*
: - Zweite Liste mit Daten


**::math::statistics::kernel-density** *data* opt *-option value* ...
: Gibt die Dichtefunktion auf der Grundlage der Kernel-Dichte-Schätzung zurück. Die Prozedur wird durch eine kleine Anzahl von Optionen gesteuert, für die jeweils ein sinnvoller Standardwert vorgegeben ist. Der Rückgabewert besteht aus drei Listen: den Mittelpunkten der Klassen, der zugehörigen Wahrscheinlichkeitsdichte sowie einer Liste von Berechnungsparametern (Anfang und Ende des Intervalls, Mittelwert und Standardabweichung sowie die verwendete Bandbreite). Die Berechnungsparameter können für weitere Analysen verwendet werden.


list *data*
: - Die zu untersuchenden Daten

list *args*
: - Option-Wert-Paare:


**-weights** *weights*
: Gewichtung pro Datenpunkt (Standard: 1 für alle Daten)

**-bandwidth** *value*
: Für die Schätzung zu verwendende Bandbreite (Standard: wird anhand der Standardabweichung ermittelt)

**-number** *value*
: Anzahl der zurückzugebenden Klassen (Standard: 100)

**-interval** *{begin end}*
: Anfang und Ende des Intervalls, für das die Dichte zurückgegeben wird (Standard: Mittelwert +/- 3\*Standardabweichung)

**-kernel** *function*
: Zu verwendender Kernel (einer von: gaussian, cosine, epanechnikov, uniform, triangular, biweight, logistic; Standard: gaussian)


**::math::statistics::bootstrap** *data* *sampleSize* ?numberSamples?
: Erstellt eine Teilstichprobe oder mehrere Teilstichproben aus einer gegebenen Datenliste. Die Daten in den Stichproben werden aus dieser Liste ausgewählt – dabei können Wiederholungen auftreten. Gibt es nur eine Teilstichprobe, wird die Stichprobe selbst zurückgegeben (als Liste von "sampleSize" Werten), andernfalls eine Liste von Stichproben.


list *data*
: Liste der zur Auswahl stehenden Werte

int *sampleSize*
: Anzahl der Werte pro Stichprobe

int *numberSamples*
: Anzahl der Stichproben (Standard: 1)


**::math::statistics::wasserstein-distance** *prob1* *prob2*
: Berechnet den Wasserstein-Abstand oder den Earth-Mover-Abstand für zwei Histogramme oder Wahrscheinlichkeitsdichten mit gleichmäßigen Intervallen. Die Histogramme müssen nicht so normiert sein, dass ihre Summe eins ergibt, sie müssen jedoch die gleiche Anzahl von Einträgen aufweisen. Hinweis: Es wird davon ausgegangen, dass die Histogramme auf denselben äquidistanten Intervallen basieren. Da die Grenzen nicht übergeben werden, wird der Wert in der Länge der Intervalle ausgedrückt.


Liste *prob1*
: Liste der Werte für das erste Histogramm/die erste Wahrscheinlichkeitsdichte

Liste *prob2*
: Liste der Werte für das zweite Histogramm/die zweite Wahrscheinlichkeitsdichte


**::math::statistics::kl-divergence** *prob1* *prob2*
: Berechnet die Kullback-Leibler-Divergenz (KL-Divergenz) für zwei Histogramme oder Wahrscheinlichkeitsdichten mit gleichmäßigen Intervallen. Die Histogramme müssen nicht so normiert sein, dass ihre Summe eins ergibt, sie müssen jedoch die gleiche Anzahl von Einträgen aufweisen. Hinweis: Es wird angenommen, dass die Histogramme auf denselben äquidistanten Intervallen basieren. Da die Grenzwerte nicht übergeben werden, wird der Wert in der Länge der Intervalle ausgedrückt. Beachten Sie außerdem, dass die KL-Divergenz nicht symmetrisch ist und dass das zweite Histogramm an Stellen, an denen das erste Histogramm Werte ungleich Null aufweist, keine Nullen enthalten darf.


Liste *prob1*
: Liste der Werte für das erste Histogramm/die erste Wahrscheinlichkeitsdichte

Liste *prob2*
: Liste der Werte für das zweite Histogramm/die zweite Wahrscheinlichkeitsdichte


**::math::statistics::logistic-model** *xdata* *ydata*
: Schätzt die Koeffizienten des logistischen Modells, das am besten zu den Daten passt. Die Daten bestehen aus unabhängigen x-Werten und dem Ergebnis 0 oder 1 für jeden der x-Werte. Das Ergebnis kann verwendet werden, um die Wahrscheinlichkeit zu schätzen, dass ein bestimmter x-Wert den Wert 1 ergibt.


Liste *xdata*
: Liste der Werte, für die Erfolg (1) oder Misserfolg (0) bekannt ist

Liste *ydata*
: Liste der Erfolge oder Misserfolge, die den einzelnen Werten in *xdata* entsprechen.


**::math::statistics::logistic-probability** *coeffs* *x*
: Berechnet die Erfolgswahrscheinlichkeit für den Wert *x* aus den gegebenen Koeffizienten des logistischen Modells.


list *coeffs*
: Liste der Koeffizienten, wie sie durch den Befehl **logistic-model** ermittelt wurden

float *x*
: X-Wert, für den die Wahrscheinlichkeit zu bestimmen ist


# MULTIVARIATE LINEARE REGRESSION

Neben der linearen Regression mit einer einzigen unabhängigen Variable bietet das Statistikpaket zwei Prozeduren zur Durchführung einer linearen Regression nach der Methode der kleinsten Quadrate (OLS) und der gewichteten kleinsten Quadrate (WLS) mit mehreren Variablen. Diese wurden von Eric Kemp-Benedict entwickelt.

Zusätzlich zu diesen beiden bietet es eine Prozedur (tstat) zur Berechnung des Wertes der t-Statistik für die angegebene Anzahl von Freiheitsgraden, der erforderlich ist, um ein bestimmtes Signifikanzniveau nachzuweisen.

Hinweis: Diese Prozeduren setzen das Paket math::linearalgebra voraus.

*Beschreibung der Prozeduren*

**::math::statistics::tstat** *dof* ?alpha?
: Gibt den Wert der t-Verteilung t\* zurück, der folgende Bedingung erfüllt:


```
    P(t*)  =  1 - alpha/2
    P(-t*) =  alpha/2
```

: für die Anzahl der Freiheitsgrade dof. Bei einer Stichprobe normalverteilter Daten x mit einem Schätzwert xbar für den Mittelwert und sbar für die Standardabweichung lässt sich das Alpha-Konfidenzintervall für den Schätzwert des Mittelwerts wie folgt berechnen:


```
      ( xbar - t* sbar , xbar + t* sbar)
```

: Die Rückgabewerte dieser Prozedur können mit einer geschätzten t-Statistik verglichen werden, um festzustellen, ob der geschätzte Wert eines Parameters sich bei dem angegebenen Konfidenzniveau signifikant von Null unterscheidet.


int *dof*
: Anzahl der Freiheitsgrade

float *alpha*
: Konfidenzniveau der t-Verteilung. Der Standardwert beträgt 0,05.


**::math::statistics::mv-wls** *weights_and_values*
: Führt eine gewichtete lineare Regression nach der Methode der kleinsten Quadrate für die angegebenen Datenpunkte durch, wobei jedem Punkt ein Gewicht zugewiesen wird. Das lineare Modell hat die Form


```
    y = b0 + b1 * x1 + b2 * x2 ... + bN * xN + error
```

: und jeder Punkt erfüllt


```
    yi = b0 + b1 * xi1 + b2 * xi2 + ... + bN * xiN + Residual_i
```

Die Prozedur gibt eine Liste mit den folgenden Elementen zurück:

**•**
: Die R-Quadrat-Statistik

**•**
: Die bereinigte R-Quadrat-Statistik

**•**
: Eine Liste, die die geschätzten Koeffizienten b1, …, bN und b0 enthält (Die Konstante b0 steht an letzter Stelle der Liste.)

**•**
: Eine Liste mit den Standardfehlern der Koeffizienten

**•**
: Eine Liste mit den 95-%-Konfidenzgrenzen der Koeffizienten, wobei jedes Grenzenpaar als Liste mit zwei Werten zurückgegeben wird


: Argumente:


Liste *weights_and_values*
: Eine Liste, bestehend aus: dem Gewicht für die erste Beobachtung, den Daten für die erste Beobachtung (als Unterliste), dem Gewicht für die zweite Beobachtung (als Unterliste) und so weiter. Die Unterlisten mit den Daten sind als Listen der Werte der abhängigen Variable y und der unabhängigen Variablen x1, x2 bis xN organisiert.


: *Beispiel für die Verwendung:* Die Gewichtungsfaktoren sind recht einfach: 0,2 für negative Werte, um anzuzeigen, dass wir diesen Beobachtungen weniger Vertrauen schenken, und 1,0 für alle positiven Werte.


```
# Store the value of the unicode value for the "+/-" character
set pm "\u00B1"

# Provide some data
set data { 0.2 {  -.67  14.18  60.03 -7.5  }
           1.0 { 36.97  15.52  34.24 14.61 }
           0.2 {-29.57  21.85  83.36 -7.   }
           0.2 {-16.9   11.79  51.67 -6.56 }
           1.0 { 14.09  16.24  36.97 -12.84}
           1.0 { 31.52  20.93  45.99 -25.4 }
           1.0 { 24.05  20.69  50.27  17.27}
           1.0 { 22.23  16.91  45.07  -4.3 }
           1.0 { 40.79  20.49  38.92  -.73 }
           0.2 {-10.35  17.24  58.77  18.78}}

# Call the ols routine
set results [::math::statistics::mv-ols $data]

# Pretty-print the results
puts "R-squared: [lindex $results 0]"
puts "Adj R-squared: [lindex $results 1]"
puts "Coefficients $pm s.e. -- \[95% confidence interval\]:"
foreach val [lindex $results 2] se [lindex $results 3] bounds [lindex $results 4] {
    set lb [lindex $bounds 0]
    set ub [lindex $bounds 1]
    puts "   $val $pm $se -- \[$lb to $ub\]"
}
```

**::math::statistics::mv-ols** *values*
: Führt eine lineare Regression nach der Methode der kleinsten Quadrate für die angegebenen Datenpunkte durch. Diese Prozedur ruft lediglich ::mvlinreg::wls mit den Gewichten 1,0 auf und gibt dieselben Informationen zurück. *Beispiel für die Verwendung:*


```
# Store the value of the unicode value for the "+/-" character
set pm "\u00B1"

# Provide some data
set data {{  -.67  14.18  60.03 -7.5  }
          { 36.97  15.52  34.24 14.61 }
          {-29.57  21.85  83.36 -7.   }
          {-16.9   11.79  51.67 -6.56 }
          { 14.09  16.24  36.97 -12.84}
          { 31.52  20.93  45.99 -25.4 }
          { 24.05  20.69  50.27  17.27}
          { 22.23  16.91  45.07  -4.3 }
          { 40.79  20.49  38.92  -.73 }
          {-10.35  17.24  58.77  18.78}}

# Call the ols routine
set results [::math::statistics::mv-ols $data]

# Pretty-print the results
puts "R-squared: [lindex $results 0]"
puts "Adj R-squared: [lindex $results 1]"
puts "Coefficients $pm s.e. -- \[95% confidence interval\]:"
foreach val [lindex $results 2] se [lindex $results 3] bounds [lindex $results 4] {
    set lb [lindex $bounds 0]
    set ub [lindex $bounds 1]
    puts "   $val $pm $se -- \[$lb to $ub\]"
}
```

# STATISTISCHE VERTEILUNGEN

In der Fachliteratur findet sich eine Vielzahl von Wahrscheinlichkeitsverteilungen. Das Statistik-Paket unterstützt:

**•**
: Die Normalverteilung bzw. Gauß-Verteilung sowie die Lognormalverteilung

**•**
: Die Gleichverteilung – gleiche Wahrscheinlichkeit für alle Daten innerhalb eines bestimmten Intervalls

**•**
: Die Exponentialverteilung – nützlich als Modell für bestimmte Extremwertverteilungen.

**•**
: Die Gamma-Verteilung – basierend auf dem unvollständigen Gamma-Integral

**•**
: Die Beta-Verteilung

**•**
: Die Chi-Quadrat-Verteilung

**•**
: Die Studentsche t-Verteilung

**•**
: Die Poisson-Verteilung

**•**
: Die Pareto-Verteilung

**•**
: Die Gumbel-Verteilung

**•**
: Die Weibull-Verteilung

**•**
: Die Cauchy-Verteilung

**•**
: Die F-Verteilung (lediglich die kumulative Verteilungsfunktion)

**•**
: PM – Binomialverteilung. Grundsätzlich gibt es für jede Verteilung Prozeduren für:

**•**
: Die Wahrscheinlichkeitsdichte (pdf-\*)

**•**
: Die Verteilungsfunktion (cdf-\*)

**•**
: Quantile für die angegebene Verteilung (quantiles-\*)

**•**
: Histogramme für die angegebene Verteilung (histogram-\*)

**•**
: Liste von Zufallswerten mit der angegebenen Verteilung (random-\*) Die folgenden Prozeduren wurden implementiert:


**::math::statistics::pdf-normal** *mean* *stdev* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes bei einer Normalverteilung mit gegebenem Mittelwert und gegebener Standardabweichung zurück.


float *mean*
: - Mittelwert der Verteilung

float *stdev*
: - Standardabweichung der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-lognormal** *mean* *stdev* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Lognormalverteilung mit vorgegebenem Mittelwert und vorgegebener Standardabweichung zurück.


float *mean*
: - Mittelwert der Verteilung

float *stdev*
: - Standardabweichung der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-exponential** *mean* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Exponentialverteilung mit einem vorgegebenen Mittelwert zurück.


float *mean*
: - Mittelwert der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-uniform** *xmin* *xmax* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes bei einer Gleichverteilung mit vorgegebenen Extremwerten zurück.


float *xmin*
: - Mindestwert der Verteilung

float *xmin*
: - Maximaler Wert der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-triangular** *xmin* *xmax* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Dreiecksverteilung mit vorgegebenen Extremwerten zurück. Wenn das Argument min kleiner ist als das Argument max, so weisen kleinere Werte eine höhere Wahrscheinlichkeit auf und umgekehrt. Im ersten Fall hat die Wahrscheinlichkeitsdichtefunktion die Form *f(x) = 2(1-x)* und im anderen Fall die Form *f(x) = 2x*.


float *xmin*
: - Mindestwert der Verteilung

float *xmin*
: - Maximaler Wert der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-symmetric-triangular** *xmin* *xmax* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine symmetrische Dreiecksverteilung mit vorgegebenen Extremwerten zurück.


float *xmin*
: - Mindestwert der Verteilung

float *xmin*
: - Maximaler Wert der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-gamma** *alpha* *beta* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Gamma-Verteilung mit vorgegebenen Form- und Ratenparametern zurück


float *alpha*
: - Formparameter

float *beta*
: - Ratenparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-poisson** *mu* *k*
: Gibt die Wahrscheinlichkeit einer bestimmten Anzahl von Ereignissen im gleichen Intervall (k) für eine Poisson-Verteilung mit einem gegebenen Mittelwert (mu) zurück.


float *mu*
: - Durchschnittliche Anzahl der Vorkommen

int *k*
: - Anzahl der Vorkommen


**::math::statistics::pdf-chisquare** *df* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Chi-Quadrat-Verteilung mit vorgegebenen Freiheitsgraden zurück


float *df*
: - Freiheitsgrade

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-student-t** *df* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Student-t-Verteilung mit den angegebenen Freiheitsgraden zurück


float *df*
: - Freiheitsgrade

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-gamma** *a* *b* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Gamma-Verteilung mit vorgegebenen Form- und Ratenparametern zurück


float *a*
: - Formparameter

float *b*
: - Ratenparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-beta** *a* *b* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Beta-Verteilung mit vorgegebenen Formparametern zurück


float *a*
: - Erster Formparameter

float *b*
: - Zweiter Formparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-weibull** *scale* *shape* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Weibull-Verteilung mit vorgegebenen Skalen- und Formparametern zurück


float *location*
: - Skalenparameter

float *scale*
: - Formparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-gumbel** *location* *scale* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Gumbel-Verteilung mit vorgegebenen Lage- und Formparametern zurück


float *location*
: - Lageparameter

float *scale*
: - Formparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-pareto** *scale* *shape* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Pareto-Verteilung mit vorgegebenen Skalen- und Formparametern zurück


float *scale*
: - Skalenparameter

float *shape*
: - Formparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-cauchy** *location* *scale* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Cauchy-Verteilung mit vorgegebenen Lage- und Formparametern zurück. Hinweis: Die Cauchy-Verteilung hat keine endlichen Momente höherer Ordnung.


float *location*
: - Lageparameter

float *scale*
: - Formparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-laplace** *location* *scale* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Laplace-Verteilung mit vorgegebenen Lage- und Formparametern zurück. Die Laplace-Verteilung setzt sich aus zwei Exponentialfunktionen zusammen, hat eine ausgeprägte Spitze und schwerere Ränder als die Normalverteilung.


float *location*
: - Lageparameter (Mittelwert)

float *scale*
: - Formparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-kumaraswamy** *a* *b* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine Kumaraswamy-Verteilung mit den vorgegebenen Parametern a und b zurück. Die Kumaraswamy-Verteilung ist mit der Beta-Verteilung verwandt, weist jedoch eine leicht zu berechnende kumulative Verteilungsfunktion auf.


float *a*
: - Parameter a

float *b*
: - Parameter b

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::pdf-negative-binomial** *r* *p* *value*
: Gibt die Wahrscheinlichkeit eines bestimmten Wertes für eine negative Binomialverteilung mit einer zulässigen Anzahl von Fehlschlägen und der Erfolgswahrscheinlichkeit zurück.


int *r*
: - Zulässige Anzahl von Fehlschlägen (mindestens 1)

float *p*
: - Erfolgswahrscheinlichkeit

int *value*
: - Anzahl der Erfolge, für die die Wahrscheinlichkeit zurückgegeben werden soll


**::math::statistics::cdf-normal** *mean* *stdev* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Normalverteilung mit gegebenem Mittelwert und gegebener Standardabweichung zurück, d. h. die Wahrscheinlichkeit für Werte bis einschließlich des angegebenen Wertes.


float *mean*
: - Mittelwert der Verteilung

float *stdev*
: - Standardabweichung der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-lognormal** *mean* *stdev* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Lognormalverteilung mit gegebenem Mittelwert und gegebener Standardabweichung zurück, d. h. die Wahrscheinlichkeit für Werte bis einschließlich des angegebenen Wertes.


float *mean*
: - Mittelwert der Verteilung

float *stdev*
: - Standardabweichung der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-exponential** *mean* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Exponentialverteilung mit einem vorgegebenen Mittelwert zurück.


float *mean*
: - Mittelwert der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-uniform** *xmin* *xmax* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Gleichverteilung mit vorgegebenen Extremwerten zurück.


float *xmin*
: - Mindestwert der Verteilung

float *xmin*
: - Maximaler Wert der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-triangular** *xmin* *xmax* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Dreiecksverteilung mit vorgegebenen Extremwerten zurück. Wenn xmin < xmax gilt, weisen kleinere Werte eine höhere Wahrscheinlichkeit auf und umgekehrt; siehe auch *pdf-triangular*


float *xmin*
: - Mindestwert der Verteilung

float *xmin*
: - Maximaler Wert der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-symmetric-triangular** *xmin* *xmax* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine symmetrische Dreiecksverteilung mit vorgegebenen Extremwerten zurück.


float *xmin*
: - Mindestwert der Verteilung

float *xmin*
: - Maximaler Wert der Verteilung

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-students-t** *degrees* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Student-t-Verteilung mit einer vorgegebenen Anzahl von Freiheitsgraden zurück.


int *degrees*
: - Anzahl der Freiheitsgrade

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-gamma** *alpha* *beta* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Gamma-Verteilung mit vorgegebenen Form- und Ratenparametern zurück.


float *alpha*
: - Formparameter

float *beta*
: - Ratenparameter

float *value*
: - Wert, für den die kumulative Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-poisson** *mu* *k*
: Gibt die kumulative Wahrscheinlichkeit einer bestimmten Anzahl von Ereignissen im gleichen Intervall (k) für eine Poisson-Verteilung mit einem gegebenen Mittelwert (mu) zurück.


float *mu*
: - Durchschnittliche Anzahl der Vorkommen

int *k*
: - Anzahl der Vorkommen


**::math::statistics::cdf-beta** *a* *b* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Beta-Verteilung mit vorgegebenen Formparametern zurück


float *a*
: - Erster Formparameter

float *b*
: - Zweiter Formparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-weibull** *scale* *shape* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Weibull-Verteilung mit vorgegebenen Skalen- und Formparametern zurück.


float *scale*
: - Skalenparameter

float *shape*
: - Formparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-gumbel** *location* *scale* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Gumbel-Verteilung mit vorgegebenen Lage- und Skalenparametern zurück.


float *location*
: - Lageparameter

float *scale*
: - Skalenparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-pareto** *scale* *shape* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Pareto-Verteilung mit vorgegebenen Skalen- und Formparametern zurück


float *scale*
: - Skalenparameter

float *shape*
: - Formparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-cauchy** *location* *scale* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Cauchy-Verteilung mit vorgegebenen Lage- und Skalenparametern zurück.


float *location*
: - Lageparameter

float *scale*
: - Skalenparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-F** *nf1* *nf2* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine F-Verteilung mit nf1 und nf2 Freiheitsgraden zurück.


float *nf1*
: - Freiheitsgrade für den Zähler

float *nf2*
: - Freiheitsgrade für den Nenner

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-laplace** *location* *scale* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Laplace-Verteilung mit vorgegebenen Lage- und Formparametern zurück. Die Laplace-Verteilung setzt sich aus zwei Exponentialfunktionen zusammen, hat eine ausgeprägte Spitze und schwerere Ränder als die Normalverteilung.


float *location*
: - Lageparameter (Mittelwert)

float *scale*
: - Formparameter

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-kumaraswamy** *a* *b* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine Kumaraswamy-Verteilung mit den vorgegebenen Parametern a und b zurück. Die Kumaraswamy-Verteilung ist mit der Beta-Verteilung verwandt, weist jedoch eine leicht zu berechnende kumulative Verteilungsfunktion auf.


float *a*
: - Parameter a

float *b*
: - Parameter b

float *value*
: - Wert, für den die Wahrscheinlichkeit ermittelt werden soll


**::math::statistics::cdf-negative-binomial** *r* *p* *value*
: Gibt die kumulative Wahrscheinlichkeit eines bestimmten Wertes für eine negative Binomialverteilung mit einer zulässigen Anzahl von Fehlschlägen und der Erfolgswahrscheinlichkeit zurück.


int *r*
: - Zulässige Anzahl von Fehlschlägen (mindestens 1)

float *p*
: - Erfolgswahrscheinlichkeit

int *value*
: - Höchste Anzahl an Erfolgen


**::math::statistics::empirical-distribution** *values*
: Gibt eine Liste mit Werten und deren empirischer Wahrscheinlichkeit zurück. Die Werte sind in aufsteigender Reihenfolge sortiert. (Die Implementierung folgt der Beschreibung auf der entsprechenden Wikipedia-Seite.)


list *values*
: - Liste der zu prüfenden Daten


**::math::statistics::random-normal** *mean* *stdev* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Normalverteilung mit dem angegebenen Mittelwert und der angegebenen Standardabweichung entsprechen.


float *mean*
: - Mittelwert der Verteilung

float *stdev*
: - Standardabweichung der Verteilung

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-lognormal** *mean* *stdev* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Lognormalverteilung mit einem vorgegebenen Mittelwert und einer vorgegebenen Standardabweichung entsprechen.


float *mean*
: - Mittelwert der Verteilung

float *stdev*
: - Standardabweichung der Verteilung

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-exponential** *mean* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Exponentialverteilung mit einem vorgegebenen Mittelwert entsprechen.


float *mean*
: - Mittelwert der Verteilung

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-uniform** *xmin* *xmax* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Gleichverteilung mit den angegebenen Extremwerten entsprechen.


float *xmin*
: - Mindestwert der Verteilung

float *xmax*
: - Maximaler Wert der Verteilung

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-triangular** *xmin* *xmax* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Dreiecksverteilung mit den angegebenen Extremwerten entsprechen. Wenn xmin < xmax gilt, weisen niedrigere Werte eine höhere Wahrscheinlichkeit auf und umgekehrt (siehe auch *pdf-triangular*).


float *xmin*
: - Mindestwert der Verteilung

float *xmax*
: - Maximaler Wert der Verteilung

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-symmetric-triangular** *xmin* *xmax* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer symmetrischen Dreiecksverteilung mit den angegebenen Extremwerten entsprechen.


float *xmin*
: - Mindestwert der Verteilung

float *xmax*
: - Maximaler Wert der Verteilung

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-gamma** *alpha* *beta* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Gamma-Verteilung mit den angegebenen Form- und Ratenparametern entsprechen.


float *alpha*
: - Formparameter

float *beta*
: - Ratenparameter

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-poisson** *mu* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Poisson-Verteilung mit einem vorgegebenen Mittelwert entsprechen.


float *mu*
: - Mittelwert der Verteilung

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-chisquare** *df* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Chi-Quadrat-Verteilung mit den angegebenen Freiheitsgraden entsprechen.


float *df*
: - Freiheitsgrade

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-student-t** *df* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Student-t-Verteilung mit den angegebenen Freiheitsgraden entsprechen.


float *df*
: - Freiheitsgrade

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-beta** *a* *b* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Beta-Verteilung mit den angegebenen Formparametern entsprechen.


float *a*
: - Erster Formparameter

float *b*
: - Zweiter Formparameter

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-weibull** *scale* *shape* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Weibull-Verteilung mit den angegebenen Skalen- und Formparametern entsprechen.


float *scale*
: - Skalenparameter

float *shape*
: - Formparameter

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-gumbel** *location* *scale* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Gumbel-Verteilung mit den angegebenen Lage- und Skalenparametern entsprechen.


float *location*
: - Lageparameter

float *scale*
: - Skalenparameter

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-pareto** *scale* *shape* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Pareto-Verteilung mit den angegebenen Skalen- und Formparametern entsprechen.


float *scale*
: - Skalenparameter

float *shape*
: - Formparameter

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-cauchy** *location* *scale* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Cauchy-Verteilung mit den angegebenen Lage- und Skalenparametern entsprechen.


float *location*
: - Lageparameter

float *scale*
: - Skalenparameter

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-laplace** *location* *scale* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Laplace-Verteilung mit vorgegebenen Lage- und Formparametern entsprechen. Die Laplace-Verteilung setzt sich aus zwei Exponentialfunktionen zusammen, hat eine ausgeprägte Spitze und schwerere Ränder als die Normalverteilung.


float *location*
: - Lageparameter (Mittelwert)

float *scale*
: - Formparameter

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-kumaraswamy** *a* *b* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer Kumaraswamy-Verteilung mit den vorgegebenen Parametern a und b entsprechen. Die Kumaraswamy-Verteilung ist mit der Beta-Verteilung verwandt, weist jedoch eine leicht zu berechnende kumulative Verteilungsfunktion auf.


float *a*
: - Parameter a

float *b*
: - Parameter b

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::random-negative-binomial** *r* *p* *number*
: Gibt eine Liste mit "number" Zufallswerten zurück, die einer negativen Binomialverteilung entsprechen.


int *r*
: - Zulässige Anzahl von Fehlschlägen (mindestens 1)

float *p*
: - Erfolgswahrscheinlichkeit

int *number*
: - Anzahl der zurückzugebenden Werte


**::math::statistics::histogram-uniform** *xmin* *xmax* *limits* *number*
: Gibt das erwartete Histogramm für eine Gleichverteilung zurück.


float *xmin*
: - Mindestwert der Verteilung

float *xmax*
: - Maximaler Wert der Verteilung

Liste *limits*
: - Obergrenzen für die Klassen im Histogramm

int *number*
: - Gesamtzahl der „Beobachtungen“ im Histogramm


**::math::statistics::incompleteGamma** *x* *p* ?tol?
: Wertet das unvollständige Gamma-Integral aus


```
                    1       / x               p-1
      P(p,x) =  --------   |   dt exp(-t) * t
                Gamma(p)  / 0
```

float *x*
: - Wert von x (Grenzwert des Integrals)

float *p*
: - Wert von p im Integranden

float *tol*
: - Erforderliche Toleranz (Standardwert: 1.0e-9)


**::math::statistics::incompleteBeta** *a* *b* *x* ?tol?
: Wertet das unvollständige Beta-Integral aus


float *a*
: - Erster Formparameter

float *b*
: - Zweiter Formparameter

float *x*
: - Wert von x (Grenzwert des Integrals)

float *tol*
: - Erforderliche Toleranz (Standardwert: 1.0e-9)


**::math::statistics::estimate-pareto** *values*
: Schätzt die Parameter der Pareto-Verteilung, die den angegebenen Werten am nächsten kommt. Gibt die geschätzten Skalen- und Formparameter sowie den Standardfehler für den Formparameter zurück.


list *values*
: - Liste von Werten, von denen angenommen wird, dass sie einer Pareto-Verteilung folgen


**::math::statistics::estimate-exponential** *values*
: Schätzt den Parameter der Exponentialverteilung, der den angegebenen Werten am nächsten kommt. Gibt eine Schätzung des einen Parameters sowie des Standardfehlers zurück.


list *values*
: - Liste von Werten, von denen angenommen wird, dass sie einer Exponentialverteilung folgen


**::math::statistics::estimate-laplace** *values*
: Schätzt die Parameter der Laplace-Verteilung, die den angegebenen Werten am nächsten kommt. Gibt eine Schätzung des Lage- bzw. des Skalenparameters zurück, basierend auf der Maximum-Likelihood-Methode.


list *values*
: - Liste von Werten, von denen angenommen wird, dass sie einer Exponentialverteilung folgen


**::math::statistics::estimante-negative-binomial** *r* *values*
: Schätzt die Erfolgswahrscheinlichkeit für die negative Binomialverteilung, die den angegebenen Werten am nächsten kommt. Die zulässige Anzahl von Fehlschlägen muss angegeben werden.


int *r*
: - Zulässige Anzahl von Fehlschlägen (mindestens 1)

int *number*
: - Liste von Werten, von denen angenommen wird, dass sie einer negativen Binomialverteilung folgen.


ZU TUN: Es müssen noch weitere Beschreibungen der Funktionen hinzugefügt werden

# DATENBEARBEITUNG

Die Datenbearbeitungsprozeduren wirken auf Listen oder Listen von Listen:

**::math::statistics::filter** *varname* *data* *expression*
: Gibt eine Liste zurück, die aus den Daten besteht, für die der logische Ausdruck wahr ist (dieser Befehl funktioniert analog zum Befehl **foreach**).


Zeichenkette *varname*
: - Name der in dem Ausdruck verwendeten Variablen

list *data*
: - Liste der Daten

Zeichenkette *expression*
: - Logischer Ausdruck unter Verwendung des Namens der Variablen


**::math::statistics::map** *varname* *data* *expression*
: Gibt eine Liste zurück, die aus den Daten besteht, die mittels des Ausdrucks transformiert wurden.


Zeichenkette *varname*
: - Name der in dem Ausdruck verwendeten Variablen

list *data*
: - Liste der Daten

Zeichenkette *expression*
: - Ausdruck, der zur Transformation (Abbildung) der Daten verwendet werden soll


**::math::statistics::samplescount** *varname* *list* *expression*
: Gibt eine Liste zurück, die aus den Anzahlen (*counts*) aller Daten in den Unterlisten des Arguments "list" besteht, für die der Ausdruck wahr ist.


Zeichenkette *varname*
: - Name der in dem Ausdruck verwendeten Variablen

list *data*
: - Liste von Unterlisten, die jeweils die Daten enthalten

Zeichenkette *expression*
: - Logischer Ausdruck zur Überprüfung der Daten (Standardwert: "true").


**::math::statistics::subdivide**
: Routine *PM* – noch nicht implementiert


# PROZEDUREN ZUR GRAFISCHEN DARSTELLUNG

Es stehen die folgenden einfachen Prozeduren zur grafischen Darstellung zur Verfügung:

**::math::statistics::plot-scale** *canvas* *xmin* *xmax* *ymin* *ymax*
: Legt den Maßstab für eine Darstellung im angegebenen Canvas fest. Alle Darstellungsroutinen erwarten, dass diese Funktion als Erstes aufgerufen wird. Eine automatische Skalierung ist nicht vorgesehen.


Widget *canvas*
: - Zu verwendendes Canvas-Widget

float *xmin*
: - Mindestwert für x

float *xmax*
: - Maximaler x-Wert

float *ymin*
: - Mindestwert für y

float *ymax*
: - Maximaler y-Wert


**::math::statistics::plot-xydata** *canvas* *xdata* *ydata* *tag*
: Erstellt ein einfaches XY-Diagramm im angegebenen Canvas – die Daten werden als Punktwolke dargestellt. Mit dem Tag lässt sich das Erscheinungsbild anpassen.


Widget *canvas*
: - Zu verwendendes Canvas-Widget

float *xdata*
: - Reihe unabhängiger Daten

float *ydata*
: - Reihe abhängiger Daten

Zeichenkette *tag*
: - Tag, der den dargestellten Daten zugewiesen werden soll (Standardwert: xyplot)


**::math::statistics::plot-xyline** *canvas* *xdata* *ydata* *tag*
: Erstellt ein einfaches XY-Diagramm im angegebenen Canvas – die Daten werden als Linie durch die Datenpunkte dargestellt. Mit dem Tag lässt sich das Erscheinungsbild anpassen.


Widget *canvas*
: - Zu verwendendes Canvas-Widget

Liste *xdata*
: - Reihe unabhängiger Daten

Liste *ydata*
: - Reihe abhängiger Daten

Zeichenkette *tag*
: - Tag, der den dargestellten Daten zugewiesen werden soll (Standardwert: xyplot)


**::math::statistics::plot-tdata** *canvas* *tdata* *tag*
: Erstellt ein einfaches XY-Diagramm im angegebenen Canvas – die Daten werden als Punktwolke dargestellt. Die horizontale Koordinate entspricht dem Index. Mit dem Tag lässt sich das Erscheinungsbild anpassen. Diese Darstellungsart eignet sich beispielsweise für Autokorrelationsfunktionen oder zur Untersuchung des zeitabhängigen Verhaltens.


Widget *canvas*
: - Zu verwendendes Canvas-Widget

Liste *tdata*
: - Reihe abhängiger Daten

Zeichenkette *tag*
: - Tag, der den dargestellten Daten zugewiesen werden soll (Standardwert: xyplot)


**::math::statistics::plot-tline** *canvas* *tdata* *tag*
: Erstellt ein einfaches XY-Diagramm im angegebenen Canvas – die Daten werden als Linie dargestellt. Eine Erläuterung finden Sie bei plot-tdata.


Widget *canvas*
: - Zu verwendendes Canvas-Widget

Liste *tdata*
: - Reihe abhängiger Daten

Zeichenkette *tag*
: - Tag, der den dargestellten Daten zugewiesen werden soll (Standardwert: xyplot)


**::math::statistics::plot-histogram** *canvas* *counts* *limits* *tag*
: Erstellt ein einfaches Histogramm im angegebenen Canvas


Widget *canvas*
: - Zu verwendendes Canvas-Widget

Liste *counts*
: - Reihe der Häufigkeiten je Klasse

Liste *limits*
: - Reihe von Obergrenzen für die Klassen

Zeichenkette *tag*
: - Tag, der den dargestellten Daten zugewiesen werden soll (Standardwert: xyplot)


# NOCH ZU TUN

Die folgenden Prozeduren müssen noch umgesetzt werden:

**•**
: F-test-stdev

**•**
: interval-mean-stdev

**•**
: histogram-normal

**•**
: histogram-exponential

**•**
: test-histogram

**•**
: test-corr

**•**
: quantiles-\*

**•**
: fourier-coeffs

**•**
: fourier-residuals

**•**
: onepar-function-fit

**•**
: onepar-function-residuals

**•**
: plot-linear-model

**•**
: subdivide


# BEISPIELE

Der folgende Code ist ein kleines Beispiel dafür, wie Sie einen Datensatz untersuchen können:

```
# Simple example:
# - Generate data (as a cheap way of getting some)
# - Perform statistical analysis to describe the data
#
package require math::statistics

#
# Two auxiliary procs
#
proc pause {time} {
   set wait 0
   after [expr {$time*1000}] {set ::wait 1}
   vwait wait
}

proc print-histogram {counts limits} {
   foreach count $counts limit $limits {
      if { $limit != {} } {
         puts [format "<%12.4g\t%d" $limit $count]
         set prev_limit $limit
      } else {
         puts [format ">%12.4g\t%d" $prev_limit $count]
      }
   }
}

#
# Our source of arbitrary data
#
proc generateData { data1 data2 } {
   upvar 1 $data1 _data1
   upvar 1 $data2 _data2

   set d1 0.0
   set d2 0.0
   for { set i 0 } { $i < 100 } { incr i } {
      set d1 [expr {10.0-2.0*cos(2.0*3.1415926*$i/24.0)+3.5*rand()}]
      set d2 [expr {0.7*$d2+0.3*$d1+0.7*rand()}]
      lappend _data1 $d1
      lappend _data2 $d2
   }
   return {}
}

#
# The analysis session
#
package require Tk
console show
canvas .plot1
canvas .plot2
pack   .plot1 .plot2 -fill both -side top

generateData data1 data2

puts "Basic statistics:"
set b1 [::math::statistics::basic-stats $data1]
set b2 [::math::statistics::basic-stats $data2]
foreach label {mean min max number stdev var} v1 $b1 v2 $b2 {
   puts "$label\t$v1\t$v2"
}
puts "Plot the data as function of \"time\" and against each other"
::math::statistics::plot-scale .plot1  0 100  0 20
::math::statistics::plot-scale .plot2  0 20   0 20
::math::statistics::plot-tline .plot1 $data1
::math::statistics::plot-tline .plot1 $data2
::math::statistics::plot-xydata .plot2 $data1 $data2

puts "Correlation coefficient:"
puts [::math::statistics::corr $data1 $data2]

pause 2
puts "Plot histograms"
.plot2 delete all
::math::statistics::plot-scale .plot2  0 20 0 100
set limits         [::math::statistics::minmax-histogram-limits 7 16]
set histogram_data [::math::statistics::histogram $limits $data1]
::math::statistics::plot-histogram .plot2 $histogram_data $limits

puts "First series:"
print-histogram $histogram_data $limits

pause 2
set limits         [::math::statistics::minmax-histogram-limits 0 15 10]
set histogram_data [::math::statistics::histogram $limits $data2]
::math::statistics::plot-histogram .plot2 $histogram_data $limits d2
.plot2 itemconfigure d2 -fill red

puts "Second series:"
print-histogram $histogram_data $limits

puts "Autocorrelation function:"
set  autoc [::math::statistics::autocorr $data1]
puts [::math::statistics::map $autoc {[format "%.2f" $x]}]
puts "Cross-correlation function:"
set  crossc [::math::statistics::crosscorr $data1 $data2]
puts [::math::statistics::map $crossc {[format "%.2f" $x]}]

::math::statistics::plot-scale .plot1  0 100 -1  4
::math::statistics::plot-tline .plot1  $autoc "autoc"
::math::statistics::plot-tline .plot1  $crossc "crossc"
.plot1 itemconfigure autoc  -fill green
.plot1 itemconfigure crossc -fill yellow

puts "Quantiles: 0.1, 0.2, 0.5, 0.8, 0.9"
puts "First:  [::math::statistics::quantiles $data1 {0.1 0.2 0.5 0.8 0.9}]"
puts "Second: [::math::statistics::quantiles $data2 {0.1 0.2 0.5 0.8 0.9}]"
```

Wenn Sie dieses Beispiel ausführen, sollte Folgendes deutlich werden:

**•**
: Zwischen den beiden Zeitreihen besteht eine starke Korrelation, wie aus den Rohdaten und insbesondere aus den Korrelationsfunktionen hervorgeht.

**•**
: Beide Zeitreihen weisen eine signifikante periodische Komponente auf

**•**
: Die Histogramme sind für die Bestimmung der Eigenschaften der Zeitreihe nicht besonders hilfreich – sie zeigen den periodischen Charakter nicht auf.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: statistics* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik
