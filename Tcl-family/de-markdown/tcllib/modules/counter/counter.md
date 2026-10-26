---
CommandName: counter
title: counter
ManualSection: n
Version: 2.0.6
TclPart: tcllib
TclDescription: Counters and Histograms
Keywords:
 - counting
 - histogram
 - statistics
 - tallying
Copyright:
---

# Name

counter – Prozeduren für Zähler und Histogramme

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [counter]{.lit} [2.0.6]{.optlit}
[::counter::init]{.cmd} [tag]{.arg} [args]{.arg}
[::counter::count]{.cmd} [tag]{.arg} [delta]{.optarg} [instance]{.optarg}
[::counter::start]{.cmd} [tag]{.arg} [instance]{.arg}
[::counter::stop]{.cmd} [tag]{.arg} [instance]{.arg}
[::counter::get]{.cmd} [tag]{.arg} [args]{.arg}
[::counter::exists]{.cmd} [tag]{.arg}
[::counter::names]{.cmd}
[::counter::histHtmlDisplay]{.cmd} [tag]{.arg} [args]{.arg}
[::counter::reset]{.cmd} [tag]{.arg} [args]{.arg}
:::

# Beschreibung

Das Paket **counter** bietet eine Zählerfunktion und kann Statistiken und Histogramme für die erfassten Daten erstellen.

**::counter::init** *tag args*
: Hiermit wird ein Zähler mit dem Namen *tag* definiert. Die *args* legen die Eigenschaften des Zählers fest. Die *args* sind

    **-group** *name*
    : Hält einen gruppierten Zähler, bei dem der Name des Histogramm-Buckets an **::counter::count** übergeben wird.

    **-hist** *bucketsize*
    : Sammelt den Zählerstand in Histogramm-Bucket mit der Größe *bucketsize*.  Wenn es sich bei den Messwerten beispielsweise um Zeitwerte in Millisekunden handelt und *bucketsize* den Wert 10 hat, dann repräsentiert jedes Histogramm-Intervall Zeitwerte von 0 bis 10 ms, 10 bis 20 ms, 20 bis 30 ms und so weiter.

    **-hist2x** *bucketsize*
    : Sammelt die Statistik in Histogramm-Bucket. Die Größe des ersten Buckets beträgt *bucketsize*, jeder weitere Bucket fasst Werte, deren Umfang doppelt so groß ist wie der des vorherigen Buckets.  Wenn *bucketsize* beispielsweise 10 beträgt, so repräsentiert jedes Histogramm-Intervall Werte von 0 bis 10 ms, 10 bis 20 ms, 20 bis 40 ms, 40 bis 80 ms und so weiter.

    **-hist10x** *bucketsize*
    : Sammelt die Statistik in Histogramm-Bucket. Die Größe des ersten Buckets beträgt *bucketsize*, jeder weitere Bucket umfasst Werte, die das Zehnfache der Größe des vorherigen Buckets betragen.  Wenn beispielsweise *bucketsize* gleich 10 ist, repräsentiert jedes Histogramm-Intervall Werte von 0 bis 10 ms, 10 bis 100 ms, 100 bis 1000 ms und so weiter.

    **-lastn** *N*
    : Speichert die letzten *N* Werte des Zählers, um einen „gleitenden Durchschnitt“ über die letzten *N* Werte zu ermitteln.

    **-timehist** *secsPerMinute*
    : Hält ein zeitbasiertes Histogramm. Der Zählerstand wird entsprechend der aktuellen Uhrzeit in einen Histogramm-Bucket summiert. Es gibt 60 Minuten-Buckets, deren Größe durch *secsPerMinute* bestimmt wird; dieser Wert beträgt normalerweise 60, kann zu Tests jedoch auch kleiner sein.  Jede „Stunde“ (d. h. alle 60 „Minuten“) wird der Inhalt der minutengenauen Buckets in den nächsten stündlichen Bucket summiert. Alle 24 „Stunden“ wird der Inhalt der stündlichen Buckets in den nächsten täglichen Bucket summiert.  Das „counter“-Paket hält alle zeitbasierten Histogramme synchron, sodass der erste vom Paket erfasste *secsPerMinute*-Wert für alle nachfolgenden zeitbasierten Histogramme verwendet wird.


**::counter::count** *tag* ?*delta*? ?*instance*?
: Erhöht den durch *tag* identifizierten Zähler. Die Vorgabe ist 1; mit *delta* lässt sich um einen beliebigen ganzzahligen oder reellen Wert erhöhen. Jeder Zähler wird mit **::counter::init** deklariert, bevor er benutzt wird. Beim Typ **-group** wird der durch *instance* identifizierte Zähler erhöht.

**::counter::start** *tag instance*
: Erfasst den Startzeitpunkt eines Intervalls. Der *tag* ist der Name des Zählers, der als wertbasiertes Histogramm „**-hist**“ definiert ist. Die *instance* dient dazu, dieses Intervall von anderen Intervallen zu unterscheiden, die sich möglicherweise mit diesem überschneiden.

**::counter::stop** *tag instance*
: Erfasst die Endzeit eines Intervalls. Die seit dem entsprechenden Aufruf von **::counter::start** für *instance* verstrichene Zeit wird in dem durch *tag* gekennzeichneten Histogramm erfasst.

**::counter::get** *tag args*
: Gibt Statistiken zu einem durch *tag* identifizierten Zähler zurück. Die *args* legen fest, welcher Wert zurückgegeben werden soll:

    **-total**
    : Gibt den Wert des Zählers zurück. Dies ist die Standardeinstellung, wenn *args* nicht angegeben wird.

    **-totalVar**
    : Gibt den Namen der Variablen „total“ zurück. Dies ist nützlich, um diese in Verbindung mit -textvariable in einem Tk-Widget festzulegen.

    **-N**
    : Gibt die Anzahl der im Zähler gesammelten Messwerte zurück.

    **-avg**
    : Gibt den Durchschnitt der im Zähler gesammelten Stichproben zurück.

    **-avgn**
    : Gibt den Durchschnitt der letzten *N* erfassten Stichproben zurück. Der Wert *N* wird im Aufruf von **::counter::init** festgelegt.

    **-hist** *bucket*
    : Wenn *bucket* festgelegt wird, gibt es den Wert in diesem Bucket des Histogramms zurück. Andernfalls gibt es das vollständige Histogramm im Array-Get-Format zurück, sortiert nach Buckets.

    **-histVar**
    : Gibt den Namen der Histogramm-Array-Variablen zurück.

    **-histHour**
    : Gibt das vollständige Stundenhistogramm im Array-Format zurück, sortiert nach Zeitfenstern.

    **-histHourVar**
    : Gibt den Namen der Variablen für das Stundenhistogramm-Array zurück.

    **-histDay**
    : Gibt das vollständige Tageshistogramm im Array-Format zurück, sortiert nach Buckets.

    **-histDayVar**
    : Gibt den Namen der Variablen für das Tageshistogramm-Array zurück.

    **-resetDate**
    : Gibt den Wert der Uhrsekunden zurück, der zum Zeitpunkt des letzten Zurücksetzens des Zählers aufgezeichnet wurde.

    **-all**
    : Gibt ein Array zurück, das die Elemente des Arrays enthält, in dem der Zähler gespeichert ist.  Dies umfasst die Gesamtsumme, die Anzahl der Stichproben (N) sowie etwaige typspezifische Informationen.  Das Histogramm-Array ist darin nicht enthalten.


**::counter::exists** *tag*
: Gibt den Wert 1 zurück, wenn der Zähler definiert ist.

**::counter::names**
: Gibt eine Liste aller definierten Zähler zurück.

**::counter::histHtmlDisplay** *tag args*
: Erstellt HTML-Code zur Darstellung eines Histogramms für einen Zähler. Die *args* steuern das Format der Darstellung. Es handelt sich dabei um folgende Parameter:

    **-title** *string*
    : Beschriftung, die über dem Balkendiagramm angezeigt werden soll

    **-unit** *unit*
    : Legt für die zeitbasierten Histogramme **minutes**, **hours** oder **days** fest. Bei wertbasierten Histogrammen wird die *unit* im Titel verwendet.

    **-images** *url*
    : URL des Verzeichnisses „/images“.

    **-gif** *filename*
    : Bild für normale Histogrammbalken. Der *filename* ist relativ zum Verzeichnis „**-images**“.

    **-ongif** *filename*
    : Bild für den aktiven Histogrammbalken. Der *filename* ist relativ zum Verzeichnis „**-images**“.

    **-max** *N*
    : Maximale Anzahl der anzuzeigenden wertbasierten Gruppen.

    **-height** *N*
    : Pixelhöhe des höchsten Balkens.

    **-width** *N*
    : Pixelbreite jedes Balkens.

    **-skip** *N*
    : Zu überspringende Buckets bei der Beschriftung wertbasierter Histogramme.

    **-format** *string*
    : Format, das zur Darstellung der Bezeichnungen von Buckets verwendet wird.

    **-text** *boolean*
    : Wenn der Wert 1 ist, wird eine Textversion des Histogramms ausgegeben; andernfalls wird eine grafische Darstellung erstellt.


**::counter::reset** *tag args*
: Setzt den Zähler mit dem Namen *tag* auf den Ausgangszustand zurück. Die *args* legen die neuen Eigenschaften des Zählers fest. Sie haben dieselbe Bedeutung wie bei **::counter::init** beschrieben.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *counter* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen
