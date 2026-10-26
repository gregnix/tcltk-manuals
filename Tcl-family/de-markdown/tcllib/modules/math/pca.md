---
CommandName: math::PCA
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Principal Components Analysis
Keywords:
 - PCA
 - math
 - statistics
 - tcl
Copyright:
---

# NAME

math::PCA – Paket für die Hauptkomponentenanalyse

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [?8.6]{.lit} [9?]{.lit} 
[package]{.cmd} [require]{.sub} [math::linearalgebra]{.lit} [1.1]{.lit} 
[::math::PCA::createPCA]{.cmd} [data]{.arg} [args]{.optarg} 
[\$pca]{.cmd} [using]{.sub} [number?|?-minproportion value]{.optarg} 
[\$pca]{.cmd} [eigenvectors]{.sub} [option]{.optarg} 
[\$pca]{.cmd} [eigenvalues]{.sub} [option]{.optarg} 
[\$pca]{.cmd} [proportions]{.sub} [option]{.optarg} 
[\$pca]{.cmd} [approximate]{.sub} [observation]{.arg} 
[\$pca]{.cmd} [approximatOriginal]{.sub} 
[\$pca]{.cmd} [scores]{.sub} [observation]{.arg} 
[\$pca]{.cmd} [distance]{.sub} [observation]{.arg} 
[\$pca]{.cmd} [qstatistic]{.sub} [observation]{.arg} [option]{.optarg} 
:::

# BESCHREIBUNG

Das PCA-Paket bietet die Möglichkeit, eine Hauptkomponentenanalyse in Tcl durchzuführen, wobei eine objektorientierte Technik zum Einsatz kommt, die durch TclOO ermöglicht wird. Es definiert tatsächlich eine einzige öffentliche Methode, *::math::PCA::createPCA*, die auf der Grundlage der übergebenen Daten ein Objekt erstellt, um die eigentliche Analyse durchzuführen.

Die Methoden der mit diesem Befehl erstellten PCA-Objekte ermöglichen es, die Hauptkomponenten zu untersuchen, (neue) Beobachtungen unter Verwendung aller oder nur einer ausgewählten Anzahl von Komponenten zu approximieren sowie die Eigenschaften der Komponenten und die statistischen Merkmale der Approximationen zu untersuchen.

Das Paket orientiert sich am PCA-Beispiel, das im ursprünglichen Linearen-Algebra-Paket von Ed Hume bereitgestellt wurde.

# BEFEHLE

Das Paket *math::PCA* stellt einen öffentlichen Befehl bereit:

**::math::PCA::createPCA** *data* ?args?
: Erzeugt ein neues Objekt auf der Grundlage der Daten, die über das Argument *data* übergeben werden. Die Hauptkomponenten können entweder auf Korrelationen oder auf Kovarianzen basieren. Alle Beobachtungen werden entsprechend dem Mittelwert und der Standardabweichung der Originaldaten normalisiert.


list *data*
: - Eine Liste von Beobachtungen (siehe das Beispiel unten).

list *args*
: - Eine Liste von Schlüssel-Wert-Paaren, die die Optionen definieren. Derzeit gibt es nur einen Schlüssel: *-covariances*. Dieser gibt an, ob Kovarianzen verwendet werden sollen (wenn der Wert 1 ist) oder stattdessen Korrelationen (Wert ist 0). Standardmäßig werden Korrelationen verwendet.


Das erstellte PCA-Objekt verfügt über die folgenden Methoden:

**\$pca using** ?number?|?-minproportion value?
: Legt die Anzahl der Komponenten fest, die bei der Analyse verwendet werden sollen (die Anzahl der beibehaltenen Komponenten). Gibt die Anzahl der Komponenten zurück, auch wenn kein Argument angegeben wird.


int *number*
: - Die Anzahl der zu behaltenden Komponenten

double *value*
: - Wählt die Anzahl der Komponenten anhand des minimalen Anteils der Variation aus, der durch diese Komponenten erhalten bleibt. Der Wert sollte zwischen 0 und 1 liegen.


**\$pca eigenvectors** ?option?
: Gibt die Eigenvektoren als Liste von Listen zurück.


string *option*
: - Standardmäßig werden nur die *beibehaltenen* Komponenten zurückgegeben. Wenn alle Eigenvektoren benötigt werden, verwenden Sie die Option *-all*.


**\$pca eigenvalues** ?option?
: Gibt die Eigenwerte als Liste von Listen zurück.


string *option*
: - Standardmäßig werden nur die Eigenwerte der *beibehaltenen* Komponenten zurückgegeben. Wenn alle Eigenwerte benötigt werden, verwenden Sie die Option *-all*.


**\$pca proportions** ?option?
: Gibt die Anteile für alle Komponenten zurück, d. h. den Anteil der Variation, den jede Komponente erklären kann.

**\$pca approximate** *observation*
: Gibt eine Näherung der Beobachtung auf der Grundlage der beibehaltenen Komponenten zurück


list *observation*
: - Die Werte für die Beobachtung.


**\$pca approximatOriginal**
: Gibt unter Verwendung der beibehaltenen Komponenten eine Näherung der Originaldaten zurück. Es handelt sich um eine Komfortmethode, die auf den vollständigen Satz der Originaldaten angewendet wird.

**\$pca scores** *observation*
: Gibt die Scores (Komponentenwerte) pro beibehaltener Komponente für die angegebene Beobachtung zurück.


list *observation*
: - Die Werte für die Beobachtung.


**\$pca distance** *observation*
: Gibt den Abstand zwischen der angegebenen Beobachtung und ihrer Näherung zurück. (Hinweis: Dieser Abstand basiert auf den normierten Vektoren.)


list *observation*
: - Die Werte für die Beobachtung.


**\$pca qstatistic** *observation* ?option?
: Gibt die Q-Statistik – im Wesentlichen das Quadrat des Abstands – für die angegebene Beobachtung zurück.


list *observation*
: - Die Werte für die Beobachtung.

string *option*
: - Wenn die Beobachtung Teil der Originaldaten ist, möchten Sie möglicherweise die korrigierte Q-Statistik verwenden. Dies erreichen Sie mit der Option „-original“.


# BEISPIEL

TODO: NIST-Beispiel

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *PCA* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik
