---
CommandName: math::fourier
ManualSection: n
Version: 1.0.3
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - FFT
 - Fourier transform
 - complex numbers
 - mathematics
Copyright:
---

# NAME

math::fourier – Diskrete und schnelle Fourier-Transformationen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math::fourier]{.lit} [1.0.3]{.lit} 
[::math::fourier::dft]{.cmd} [in_data]{.arg} 
[::math::fourier::inverse_dft]{.cmd} [in_data]{.arg} 
[::math::fourier::lowpass]{.cmd} [cutoff]{.arg} [in_data]{.arg} 
[::math::fourier::highpass]{.cmd} [cutoff]{.arg} [in_data]{.arg} 
:::

# BESCHREIBUNG

Das Paket **math::fourier** verwendet zur Implementierung der diskreten Fourier-Transformation gegebenenfalls die schnelle Fourier-Transformation oder die gewöhnliche Transformation. Es enthält zudem einige einfache Filter-Prozeduren, die veranschaulichen, wie solche Filter implementiert werden können.

Ziel dieses Dokuments ist es, die implementierten Prozeduren zu beschreiben und einige Beispiele für ihre Verwendung zu geben. Da es zu den betreffenden Algorithmen umfangreiche Fachliteratur gibt, verweisen wir für weitere Erläuterungen auf einschlägige Lehrbücher. Wir verweisen zudem auf die ursprüngliche Wiki-Seite zu diesem Thema, auf der einige der Überlegungen hinter der aktuellen Implementierung beschrieben werden.

# ALLGEMEINE INFORMATIONEN

Die beiden definierten Prozeduren der obersten Ebene lauten

**•**
: dft data-list

**•**
: inverse_dft data-list Beide nehmen eine Liste von *komplexen Zahlen* entgegen und wenden auf diese Zahlenlisten jeweils eine diskrete Fourier-Transformation (DFT) bzw. deren Umkehrung an. Eine „komplexe Zahl“ ist in diesem Fall entweder (i) ein Paar (eine Liste mit zwei Elementen) von Zahlen, das als Real- und Imaginärteil der komplexen Zahl interpretiert wird, oder (ii) eine einzelne Zahl, die als Realteil einer komplexen Zahl interpretiert wird, deren Imaginärteil Null ist. Der Rückgabewert hat stets das erste Format. (Die DFT liefert im Allgemeinen komplexe Ergebnisse, selbst wenn die Eingabe rein real ist.) Werden nacheinander erst die eine und dann die andere dieser Prozeduren auf eine Liste komplexer Zahlen angewendet, ergibt sich (abgesehen von Rundungsfehlern aufgrund der Gleitkommaarithmetik) wieder die ursprüngliche Zahlenliste. Wenn die Eingabelänge N eine Zweierpotenz ist, verwenden diese Prozeduren den O(N log N)-Algorithmus der schnellen Fourier-Transformation. Wenn die Eingabelänge keine Zweierpotenz ist, wird die DFT stattdessen unter Verwendung des naiven quadratischen Algorithmus berechnet. Einige Beispiele:


```
    % dft {1 2 3 4}
    {10 0.0} {-2.0 2.0} {-2 0.0} {-2.0 -2.0}
    % inverse_dft {{10 0.0} {-2.0 2.0} {-2 0.0} {-2.0 -2.0}}
    {1.0 0.0} {2.0 0.0} {3.0 0.0} {4.0 0.0}
    % dft {1 2 3 4 5}
    {15.0 0.0} {-2.5 3.44095480118} {-2.5 0.812299240582} {-2.5 -0.812299240582} {-2.5 -3.44095480118}
    % inverse_dft {{15.0 0.0} {-2.5 3.44095480118} {-2.5 0.812299240582} {-2.5 -0.812299240582} {-2.5 -3.44095480118}}
    {1.0 0.0} {2.0 8.881784197e-17} {3.0 4.4408920985e-17} {4.0 4.4408920985e-17} {5.0 -8.881784197e-17}
```

Im letztgenannten Fall wären die Imaginärteile <1e-16 bei exakter Arithmetik gleich Null gewesen, sind es hier jedoch aufgrund von Rundungsfehlern nicht.

Intern verwenden die Prozeduren ein flaches Listenformat, bei dem jedes Element mit einem geraden Index einen Realteil und jedes Element mit einem ungeraden Index einen Imaginärteil darstellt. Dies spiegelt sich in den Namen der Variablen durch die Präfixe „Re\_“ und „Im\_“ wider.

Das Paket enthält zwei einfache Filter. Sie haben ein analoges Gegenstück in einer einfachen elektronischen Schaltung, einem Widerstand und einem Kondensator in Reihe. Für die Verwendung dieser Filter ist das Paket **math::complexnumbers** erforderlich.

# PROZEDUREN

Die öffentlichen Prozeduren zur Fourier-Transformation sind:

**::math::fourier::dft** *in_data*
: Berechnet die *Fourier-Transformation* der angegebenen Liste komplexer Zahlen. Das Ergebnis ist eine Liste komplexer Zahlen, die die (komplexen) Amplituden der Fourier-Komponenten darstellen.


list *in_data*
: Liste der Daten


**::math::fourier::inverse_dft** *in_data*
: Ermittelt die *inverse Fourier-Transformation* der angegebenen Liste komplexer Zahlen (die als Amplituden interpretiert werden). Das Ergebnis ist eine Liste komplexer Zahlen, die die ursprünglichen (komplexen) Daten darstellen.


list *in_data*
: Liste der Daten (Amplituden)


**::math::fourier::lowpass** *cutoff* *in_data*
: Filtert die (komplexen) Amplituden so, dass hochfrequente Komponenten unterdrückt werden. Bei dem implementierten Filter handelt es sich um einen Tiefpassfilter erster Ordnung, das diskrete Äquivalent einer einfachen elektronischen Schaltung mit einem Widerstand und einem Kondensator.


float *cutoff*
: Grenzfrequenz

list *in_data*
: Liste der Daten (Amplituden)


**::math::fourier::highpass** *cutoff* *in_data*
: Filtert die (komplexen) Amplituden so, dass niederfrequente Komponenten unterdrückt werden. Bei dem implementierten Filter handelt es sich um einen Tiefpassfilter erster Ordnung, das diskrete Äquivalent einer einfachen elektronischen Schaltung mit einem Widerstand und einem Kondensator.


float *cutoff*
: Grenzfrequenz

list *in_data*
: Liste der Daten (Amplituden)


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: fourier* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik
