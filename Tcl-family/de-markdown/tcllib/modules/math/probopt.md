---
CommandName: math::probopt
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - mathematics
 - optimisation
 - probabilistic calculations
Copyright:
---

# NAME

math::probopt – Probabilistische Optimierungsmethoden

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [math::probopt]{.lit} [1.1]{.lit} 
[::math::probopt::pso]{.cmd} [function]{.arg} [bounds]{.arg} [args]{.arg} 
[::math::probopt::sce]{.cmd} [function]{.arg} [bounds]{.arg} [args]{.arg} 
[::math::probopt::diffev]{.cmd} [function]{.arg} [bounds]{.arg} [args]{.arg} 
[::math::probopt::lipoMax]{.cmd} [function]{.arg} [bounds]{.arg} [args]{.arg} 
[::math::probopt::adaLipoMax]{.cmd} [function]{.arg} [bounds]{.arg} [args]{.arg} 
:::

# BESCHREIBUNG

Der Zweck des Pakets **math::probopt** besteht darin, verschiedene Optimierungsalgorithmen bereitzustellen, die auf probabilistischen Verfahren basieren. Die Ergebnisse dieser Algorithmen können daher von einem Durchlauf zum nächsten variieren. Die Algorithmen sind allesamt bekannt und gut beschrieben, und ihre Befürworter behaupten im Allgemeinen, dass sie effizient und zuverlässig sind.

Da die meisten dieser Algorithmen über einen oder mehrere einstellbare Parameter oder sogar Varianten verfügen, bietet die jeweilige Schnittstelle Optionen zur Einstellung dieser Parameter bzw. zur Auswahl der Variante. Diese werden in Form von Schlüssel-Wert-Paaren angegeben, beispielsweise *-iterations 100*.

Dieses Handbuch enthält weder Empfehlungen zu diesen Algorithmen noch umfassende Leitlinien für die Parameter. Hierzu verweisen wir auf Online-Artikel zu den betreffenden Algorithmen.

Ein paar Hinweise jedoch:

**•**
: Mit Ausnahme von LIPO sind die Algorithmen in der Lage, unregelmäßige (nicht glatte) und sogar diskontinuierliche Funktionen zu verarbeiten.

**•**
: Die Ergebnisse hängen vom Startwert (Seed) des Zufallszahlengenerators ab und sind wahrscheinlich nicht sehr genau, insbesondere wenn sich die Funktion in der Nähe des Optimums nur langsam ändert. Sie bieten jedoch einen guten Ausgangspunkt für einen deterministischen Algorithmus. Die Sammlung umfasst die folgenden Algorithmen:

**•**
: PSO – Partikelschwarm-Optimierung

**•**
: SCE – Shuffled Complexes Evolution (Evolution gemischter Komplexe)

**•**
: DE – Differentialevolution

**•**
: LIPO – Lipschitz-Optimierung Die verschiedenen Prozeduren verfügen über eine einheitliche Schnittstelle:


```
   set result [::math::probopt::algorithm function bounds args]
```

Die Argumente haben folgende Bedeutung:

**•**
: Das Argument *function* ist der Name der Prozedur, die die Funktion auswertet. Ihre Schnittstelle lautet:


```
    set value [function coords]
```

: wobei *coords* eine Liste von Koordinaten ist, an denen die Auswertung der Funktion durchgeführt werden soll. Sie muss den Funktionswert zurückgeben.

**•**
: Das Argument *bounds* ist eine Liste von Paaren aus Minimal- und Maximalwerten für jede Koordinate. Diese Liste bestimmt implizit die Dimension des Koordinatenraums, in dem das Optimum gesucht werden soll; beispielsweise können Sie für eine Funktion wie *x\*\*2 + (y-1)\*\*4* die Grenzen als *{{-1 1} {-1 1}}* festlegen, d. h. zwei Paare für die beiden Koordinaten.

**•**
: Der Rest (*args*) besteht aus null oder mehr Schlüssel-Wert-Paaren, die die Optionen festlegen. Welche Optionen von welchem Algorithmus unterstützt werden, ist im Folgenden dokumentiert. Das Ergebnis der verschiedenen Optimierungsprozeduren ist ein Dictionary, das mindestens die folgenden Elemente enthält:

**•**
: *optimum-coordinates* ist eine Liste, die die Koordinaten des gefundenen Optimums enthält.

**•**
: *optimum-value* ist der Wert der Funktion an diesen Koordinaten.

**•**
: *evaluations* bezeichnet die Anzahl der Funktionsauswertungen.

**•**
: *best-values* ist eine Liste aufeinanderfolgender bester Werte, die im Rahmen der Iterationen ermittelt wurden.


# EINZELHEITEN ZU DEN ALGORITHMEN

Das Paket enthält folgende Algorithmen:

**::math::probopt::pso** *function* *bounds* *args*
: Der Algorithmus der „Partikelschwarm-Optimierung“ basiert auf dem Prinzip, dass die potenziellen Optimumpunkte um den bisher besten Punkt herumschwärmen sollten, wobei Abweichungen zulässig sind, um Verbesserungen zu ermöglichen. Er unterstützt die folgenden Optionen:


**•**
: *-swarmsize number*: Anzahl der zu berücksichtigenden Partikel (Standard: 50)

**•**
: *-vweight    value*: Gewichtungsfaktor für die aktuelle „Geschwindigkeit“ (0–1, Standardwert: 0,5)

**•**
: *-pweight    value*: Gewicht für die beste Position des einzelnen Partikels (0–1, Standardwert: 0,3)

**•**
: *-gweight    value*: Gewicht für die „beste“ Gesamtposition pro Partikel (0–1, Standardwert: 0,3)

**•**
: *-type       local/global*: Art der Optimierung

**•**
: *-neighbours number*: Größe der Nachbarschaft (Standardwert: 5, wird bei „local“ verwendet)

**•**
: *-iterations number*: Maximale Anzahl von Iterationen

**•**
: *-tolerance  value*: Absolute minimale Verbesserung des Minimalwerts


**::math::probopt::sce** *function* *bounds* *args*
: Der Algorithmus „Shuffled Complex Evolution“ ist eine Erweiterung des Nelder-Mead-Algorithmus, der mehrere Komplexe verwendet und diese neu anordnet, um das „globale“ Optimum zu finden. Er unterstützt die folgenden Optionen:


**•**
: *-complexes           number*: Anzahl der zu berücksichtigenden Partikel (Standard: 2)

**•**
: *-mincomplexes        number*: Mindestanzahl an Komplexen (Standard: 2; wird derzeit nicht verwendet)

**•**
: *-newpoints           number*: Anzahl der neu zu generierenden Punkte (Standard: 1)

**•**
: *-shuffle             number*: Anzahl der Iterationen, nach denen die Komplexe neu gemischt werden sollen (bei der Standardeinstellung 0 wird ein Wert anhand der Anzahl der Dimensionen berechnet)

**•**
: *-pointspercomplex    number*: Anzahl der Punkte pro Komplex (wenn auf 0 gesetzt – dies ist die Standardeinstellung –, wird die Zahl anhand der Anzahl der Dimensionen berechnet)

**•**
: *-pointspersubcomplex number*: Anzahl der Punkte pro Teilkomplex (dient zur Auswahl der besten Punkte in jedem Komplex; bei der Standardeinstellung 0 wird ein Wert anhand der Anzahl der Dimensionen berechnet)

**•**
: *-iterations          number*: Maximale Anzahl von Iterationen (Standard: 100)

**•**
: *-maxevaluations      number*: Maximale Anzahl der Funktionsauswertungen (wenn diese Zahl erreicht ist, wird die Iteration abgebrochen. Standardwert: 1.000 Millionen)

**•**
: *-abstolerance        value*: Absolute minimale Verbesserung des Minimalwerts (Standardwert: 0,0)

**•**
: *-reltolerance        value*: Relative minimale Verbesserung des Minimalwerts (Standardwert: 0,001)


**::math::probopt::diffev** *function* *bounds* *args*
: Der Algorithmus der „Differentialevolution“ verwendet eine Reihe von Startpunkten, die anschließend anhand zufällig ausgewählter Punkte aktualisiert werden. Er ähnelt mehr oder weniger genetischen Algorithmen. Er wird durch zwei Parameter gesteuert, nämlich factor und lambda, wobei der erste die Aktualisierung anhand zufälliger Punkte und der zweite die Aktualisierung anhand des bisher besten gefundenen Punktes bestimmt. Er unterstützt die folgenden Optionen:


**•**
: *-iterations          number*: Maximale Anzahl von Iterationen (Standard: 100)

**•**
: *-number              number*: Anzahl der zu verarbeitenden Punkte (bei der Standardeinstellung 0 wird diese aus der Anzahl der Dimensionen berechnet)

**•**
: *-factor              value*: Gewichtung zufällig ausgewählter Punkte bei der Aktualisierung (0–1, Standardwert: 0,6)

**•**
: *-lambda              value*: Gewicht des bisher besten gefundenen Punktes bei der Aktualisierung (0–1, Standardwert: 0,0)

**•**
: *-crossover           value*: Anteil der neuen Punkte, die beim Ersetzen der alten Punkte berücksichtigt werden sollen (0–1, Standardwert: 0,5)

**•**
: *-maxevaluations      number*: Maximale Anzahl der Funktionsauswertungen (wenn diese Zahl erreicht ist, wird die Iteration abgebrochen. Standardwert: 1.000 Millionen)

**•**
: *-abstolerance value*: Absolute minimale Verbesserung des Minimalwerts (Standardwert: 0,0)

**•**
: *-reltolerance value*: Relative minimale Verbesserung des Minimalwerts (Standardwert: 0,001)


**::math::probopt::lipoMax** *function* *bounds* *args*
: Der Algorithmus „Lipschitz-Optimierung“ nutzt die „Lipschitz“-Eigenschaft der gegebenen Funktion, um ein *Maximum* innerhalb des vorgegebenen Begrenzungsrahmens zu finden. Es gibt zwei Varianten: *lipoMax* geht von einer festen Schätzung für den Lipschitz-Parameter aus. Er unterstützt die folgenden Optionen:


**•**
: *-iterations          number*: Anzahl der Iterationen (entspricht der tatsächlichen Anzahl der Funktionsauswertungen, Standardwert: 100)

**•**
: *-lipschitz           value*: Schätzung des Lipschitz-Parameters (Standardwert: 10,0)


**::math::probopt::adaLipoMax** *function* *bounds* *args*
: Der Algorithmus der „adaptiven Lipschitz-Optimierung“ nutzt die „Lipschitz“-Eigenschaft der gegebenen Funktion, um ein *Maximum* innerhalb des vorgegebenen Begrenzungsrahmens zu finden. Die adaptive Variante nutzt tatsächlich zwei Phasen, um eine geeignete Schätzung für den Lipschitz-Parameter zu ermitteln. Dies wird durch den „Bernoulli“-Parameter gesteuert. Wenn Sie eine große Anzahl von Iterationen festlegen, kann die Ausführung des Algorithmus sehr lange dauern, da er versucht, den Lipschitz-Parameter zu verfeinern, und die Wahrscheinlichkeit, eine bessere Schätzung zu finden, schnell abnimmt. Er unterstützt die folgenden Optionen:


**•**
: *-iterations          number*: Anzahl der Iterationen (entspricht der tatsächlichen Anzahl der Funktionsauswertungen, Standardwert: 100)

**•**
: *-bernoulli           value*: Parameter für zufällige Entscheidungen (Exploration versus Exploitation, Standardwert: 0,1)


# LITERATUR

Die verschiedenen Algorithmen wurden in Online-Veröffentlichungen beschrieben. Hier sind einige davon:

**•**
: *PSO*: Maurice Clerc, Standard Particle Swarm Optimisation (2012) *https://hal.archives-ouvertes.fr/file/index/docid/764996/filename/SPSO_descriptions.pdf* Alternativ: *https://en.wikipedia.org/wiki/Particle_swarm_optimization*

**•**
: *SCE*: Qingyuan Duan, Soroosh Sorooshian, Vijai K. Gupta, Optimal use of the SCE-UA global optimization method for calibrating watershed models (1994), Journal of Hydrology 158, S. 265–284 *https://www.researchgate.net/publication/223408756_Optimal_Use_of_the_SCE-UA_Global_Optimization_Method_for_Calibrating_Watershed_Models*

**•**
: *DE*: Rainer Storn und Kenneth Price, Differential Evolution – A simple and efficient adaptive scheme for global optimization over continuous spaces (1996) *http://www1.icsi.berkeley.edu/~storn/TR-95-012.pdf*

**•**
: *LIPO*: Cedric Malherbe und Nicolas Vayatis, Global optimization of Lipschitz functions, (Juni 2017) *https://arxiv.org/pdf/1703.02628.pdf*


# KATEGORIE

Mathematik
