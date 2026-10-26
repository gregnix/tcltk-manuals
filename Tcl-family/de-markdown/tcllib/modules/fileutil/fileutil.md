---
CommandName: fileutil
ManualSection: n
Version: 1.16.4
TclPart: tcllib
TclDescription: file utilities
Keywords:
 - cat
 - file utilities
 - grep
 - temp file
 - test
 - touch
 - type
Copyright:
---

# NAME

fileutil – Prozeduren zur Implementierung einiger Dateidienste

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} [1.16.4]{.optlit} 
[::fileutil::lexnormalize]{.cmd} [path]{.arg} 
[::fileutil::fullnormalize]{.cmd} [path]{.arg} 
[::fileutil::test]{.cmd} [path]{.arg} [codes]{.arg} [msgvar]{.optarg} [label]{.optarg} 
[::fileutil::cat]{.cmd} (?options? [file)...]{.arg} 
[::fileutil::writeFile]{.cmd} [options]{.optarg} [file]{.arg} [data]{.arg} 
[::fileutil::appendToFile]{.cmd} [options]{.optarg} [file]{.arg} [data]{.arg} 
[::fileutil::insertIntoFile]{.cmd} [options]{.optarg} [file]{.arg} [at]{.arg} [data]{.arg} 
[::fileutil::removeFromFile]{.cmd} [options]{.optarg} [file]{.arg} [at]{.arg} [n]{.arg} 
[::fileutil::replaceInFile]{.cmd} [options]{.optarg} [file]{.arg} [at]{.arg} [n]{.arg} [data]{.arg} 
[::fileutil::updateInPlace]{.cmd} [options]{.optarg} [file]{.arg} [cmd]{.arg} 
[::fileutil::fileType]{.cmd} [filename]{.arg} 
[::fileutil::find]{.cmd} [basedir ?filtercmd]{.optarg} 
[::fileutil::findByPattern]{.cmd} [basedir]{.arg} [-regexp|-glob]{.optlit} [--]{.optlit} [patterns]{.arg} 
[::fileutil::foreachLine]{.cmd} [var]{.arg} [filename]{.arg} [cmd]{.arg} 
[::fileutil::grep]{.cmd} [pattern]{.arg} [files]{.optarg} 
[::fileutil::install]{.cmd} [-m mode]{.optarg} [source]{.arg} [destination]{.arg} 
[::fileutil::stripN]{.cmd} [path]{.arg} [n]{.arg} 
[::fileutil::stripPwd]{.cmd} [path]{.arg} 
[::fileutil::stripPath]{.cmd} [prefix]{.arg} [path]{.arg} 
[::fileutil::jail]{.cmd} [jail]{.arg} [path]{.arg} 
[::fileutil::touch]{.cmd} [-a]{.optlit} [-c]{.optlit} [-m]{.optlit} [-r ref_file]{.optarg} [-t time]{.optarg} [filename]{.arg} [...]{.optdot} 
[::fileutil::tempdir]{.cmd} 
[::fileutil::tempdir]{.cmd} [path]{.arg} 
[::fileutil::tempdirReset]{.cmd} 
[::fileutil::tempfile]{.cmd} [prefix]{.optarg} 
[::fileutil::maketempdir]{.cmd} [-prefix str]{.optarg} [-suffix str]{.optarg} [-dir str]{.optarg} 
[::fileutil::relative]{.cmd} [base]{.arg} [dst]{.arg} 
[::fileutil::relativeUrl]{.cmd} [base]{.arg} [dst]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Implementierungen von Standard-Unix-Dienstprogrammen.

**::fileutil::lexnormalize** *path*
: Dieser Befehl führt eine rein lexikalische Normalisierung des *Pfads* durch und gibt den geänderten Pfad als Ergebnis zurück. Symbolische Links im Pfad werden *nicht* aufgelöst. Beispiele:


```
    fileutil::lexnormalize /foo/./bar
    => /foo/bar

    fileutil::lexnormalize /foo/../bar
    => /bar
```

**::fileutil::fullnormalize** *path*
: Dieser Befehl löst alle symbolischen Links im *Pfad* auf und gibt den geänderten Pfad als Ergebnis zurück. Im Gegensatz zum integrierten Befehl **file normalize** löst dieser Befehl auch einen symbolischen Link im letzten Element des Pfads auf.

**::fileutil::test** *path* *codes* ?*msgvar*? ?*label*?
: Ein Befehl zum Testen verschiedener Eigenschaften eines *Pfads*. Die zu testenden Eigenschaften werden in *codes* angegeben, entweder als Liste von Schlüsselwörtern, die die Eigenschaften beschreiben, oder als Zeichenkette, in der jeder Buchstabe eine Abkürzung für eine zu testende Eigenschaft darstellt. Die erkannten Schlüsselwörter, Abkürzungen und die zugehörigen Eigenschaften sind in der folgenden Liste aufgeführt. Die Tests werden in der Reihenfolge ausgeführt, in der sie dem Befehl übergeben wurden. Das Ergebnis des Befehls ist ein boolescher Wert. Er ist genau dann wahr, wenn der *Pfad* alle angegebenen Tests besteht. Falls der *Pfad* einen oder mehrere Tests nicht besteht, hinterlässt der erste fehlgeschlagene Test eine Meldung in der Variable, auf die *msgvar* verweist, wenn diese festgelegt ist. Der Meldung wird *label* vorangestellt, wenn dieses festgelegt ist. *Hinweis*: Die Variable, auf die *msgvar* verweist, wird überhaupt nicht verändert, wenn alle Tests bestanden werden.


*r*ead
: **file readable**

*sch*reiben
: **file writable**

*e*xistiert
: **file exists**

e*x*ec
: **file executable**

*D*atei
: **file isfile**

*d*ir
: **file isdirectory**


**::fileutil::cat** (?*options*? *file*)...
: Eine Tcl-Implementierung des UNIX-Befehls **cat**. Gibt den Inhalt der angegebenen Datei(en) zurück. Die Argumente sind die zu lesenden Dateien, dazwischen stehen Optionen zur Konfiguration des Prozesses. Sollten beim Lesen einer der Dateien Probleme auftreten, wird ein Fehler ausgegeben und es werden keine Daten zurückgegeben. Die zulässigen Optionen sind **-encoding**, **-translation**, **-eofchar** und **--**. Mit Ausnahme der letzten Option nehmen alle Optionen einen einzelnen Wert als Argument entgegen, wie durch den Tcl-Befehl **fconfigure** festgelegt. Die Option **--** muss verwendet werden, um die Optionsverarbeitung vor einer Datei zu beenden, wenn der Name dieser Datei mit einem Bindestrich beginnt. Jede Datei kann ihre eigenen Optionen vorangestellt haben, und für alles, was nicht direkt angegeben ist, werden die Standardwerte aus den Optionen der vorherigen Datei übernommen. Die erste Datei übernimmt die Systemstandardwerte für nicht angegebene Optionen.

**::fileutil::writeFile** ?*options*? *file* *data*
: Der Befehl ersetzt den aktuellen Inhalt der angegebenen *Datei* durch *Daten*, wobei der Prozess durch die Optionen konfiguriert wird. Der Befehl akzeptiert dieselben Optionen wie **::fileutil::cat**. Die Angabe einer nicht vorhandenen Datei ist zulässig und bewirkt, dass der Befehl die Datei (sowie alle erforderlichen, aber fehlenden Verzeichnisse) erstellt.

**::fileutil::appendToFile** ?*options*? *file* *data*
: Dieser Befehl verhält sich ähnlich wie **::fileutil::writeFile**, mit dem Unterschied, dass der bisherige Inhalt von *file* nicht ersetzt, sondern angehängt wird. Der Befehl akzeptiert dieselben Optionen wie **::fileutil::cat**.

**::fileutil::insertIntoFile** ?*options*? *file* *at* *data*
: Dieser Befehl ähnelt **::fileutil::appendToFile**, mit dem Unterschied, dass die neuen Daten nicht am Ende angehängt, sondern an einer bestimmten Stelle innerhalb der Datei eingefügt werden. Außerdem muss bei diesem Befehl der Pfad zu einer vorhandenen Datei angegeben werden. Eine nicht vorhandene Datei wird nicht erstellt, sondern es wird stattdessen eine Fehlermeldung ausgegeben. Die angegebene Position *at* muss eine ganze Zahl im Bereich von **0** bis \[Dateigröße *Datei*\] sein. **0** bewirkt das Einfügen der neuen Daten vor dem ersten Zeichen des vorhandenen Inhalts, während \[Dateigröße *Datei*\] das Einfügen nach dem letzten Zeichen des vorhandenen Inhalts bewirkt, d. h. das Anhängen. Der Befehl akzeptiert dieselben Optionen wie **::fileutil::cat**.

**::fileutil::removeFromFile** ?*options*? *file* *at* *n*
: Dieser Befehl ist das Gegenstück zu **::fileutil::insertIntoFile** und entfernt *n* Zeichen aus der *Datei*, beginnend an der Position *at*. Die angegebene Position *at* muss eine ganze Zahl im Bereich von **0** bis \[Dateigröße *Datei*\] sein - *n*. Bei **0** beginnt das Entfernen der neuen Daten mit dem ersten Zeichen des vorhandenen Inhalts, während \[Dateigröße *Datei*\] - *n* das Entfernen des Endes des vorhandenen Inhalts bewirkt, d. h. das Kürzen der Datei. Der Befehl akzeptiert dieselben Optionen wie **::fileutil::cat**.

**::fileutil::replaceInFile** ?*options*? *file* *at* *n* *data*
: Dieser Befehl ist eine Kombination aus **::fileutil::removeFromFile** und **::fileutil::insertIntoFile**. Er entfernt zunächst den durch die Argumente *at* und *n* festgelegten Teil des Inhalts und fügt dann *data* an der angegebenen Stelle ein, wodurch der entfernte Inhalt effektiv durch *data* ersetzt wird. Alle durch **::fileutil::removeFromFile** und **::fileutil::insertIntoFile** auferlegten Constraints für *at* und *n* werden beachtet. Der Befehl akzeptiert dieselben Optionen wie **::fileutil::cat**.

**::fileutil::updateInPlace** ?*options*? *file* *cmd*
: Dieser Befehl kann als die allgemeine Kernfunktionalität von **::fileutil::replaceInFile** betrachtet werden. Er liest zunächst den Inhalt der angegebenen *Datei*, führt dann den Befehl *cmd* aus, wobei diese Daten angehängt werden, und schreibt schließlich das Ergebnis dieses Aufrufs als neuen Inhalt der Datei zurück. Wenn der ausgeführte Befehl einen Fehler auslöst, wird die *Datei* nicht verändert. Der Befehl akzeptiert dieselben Optionen wie **::fileutil::cat**.

**::fileutil::fileType** *filename*
: Eine Implementierung des UNIX-Befehls **file**, die verschiedene Heuristiken verwendet, um den Dateityp zu ermitteln.  Gibt eine Liste zurück, die so viele Typinformationen wie möglich über die Datei enthält, von den allgemeinsten (z. B. „binary“ oder „text“) bis zu den spezifischsten (z. B. „gif“). Der Rückgabewert für eine GIF-Datei wäre beispielsweise „binary graphic gif“.  Der Befehl erkennt die folgenden Dateitypen: Verzeichnis, leer, binär, Text, Skript (mit Interpreter), ausführbare ELF-Datei, ausführbare DOS-Datei, ausführbare NE-Datei, ausführbare PE-Datei, Grafik-GIF, Grafik-JPEG, Grafik-PNG, Grafik-TIFF, Grafik-Bitmap, HTML, XML (mit Doctype, wenn verfügbar), PGP-Nachricht, binäres PDF, Text-PS, Text-EPS, binäres Gravity_Wave_Data_Frame, komprimiertes Bzip, komprimiertes Gzip, komprimiertes Zip, komprimiertes Tar, Audio-Wave, Audio-MPEG und Link. Außerdem erkennt es „doctools“, „doctoc“ und „docidx“-Dokumentationsdateien sowie „tklib“-Diagramme.

**::fileutil::find** ?*basedir* ?*filtercmd*??
: Eine Implementierung des Unix-Befehls **find**. Adaptiert aus dem Tcler-Wiki. Nimmt höchstens zwei Argumente entgegen: den Pfad zu dem Verzeichnis, in dem die Suche beginnen soll, und einen Befehl, mit dem die Auswertung des Interesses an jeder Datei durchgeführt wird. Der Pfad ist standardmäßig „*.*“, d. h. das aktuelle Verzeichnis. Der Befehl ist standardmäßig die leere Zeichenkette, was bedeutet, dass alle Dateien von Interesse sind. Der Befehl sorgt dafür, dass er sich bei zirkulären Verknüpfungsstrukturen *nicht* in Endlosschleifen verliert. Das Ergebnis des Befehls ist eine Liste, die die Pfade zu den relevanten Dateien enthält. Der *filtercmd* wird, wenn er angegeben ist, als Befehlspräfix interpretiert, und ihm wird ein Argument hinzugefügt: der Name der Datei oder des Verzeichnisses, das find gerade prüft. Hinweis: Dieser Name ist *nicht* vollständig qualifiziert. Er muss mit dem Ergebnis von **pwd** verknüpft werden, um einen absoluten Dateinamen zu erhalten. Das Ergebnis von *filtercmd* ist ein boolescher Wert, der angibt, ob die aktuelle Datei in die Liste der relevanten Dateien aufgenommen werden soll. Beispiele:


```
    # find .tcl files
    package require fileutil
    proc is_tcl {name} {return [string match *.tcl $name]}
    set tcl_files [fileutil::find . is_tcl]
```

**::fileutil::findByPattern** *basedir* ?**-regexp**|**-glob**? ?**--**? *patterns*
: Dieser Befehl basiert auf dem **TclX**-Befehl **recursive_glob**, mit dem Unterschied, dass er keine Rekursion über mehr als ein Verzeichnis gleichzeitig zulässt. Er nutzt intern **::fileutil::find** und ist daher in der Lage, symbolische Links zu verfolgen – was der **TclX**-Befehl nicht tut. Das erste Argument ist das Verzeichnis, in dem die Suche beginnen soll, das zweite Argument ist eine Liste von *Mustern*. Der Befehl gibt eine Liste aller Dateien zurück, die über *basedir* erreichbar sind und deren Namen mit mindestens einem der Muster übereinstimmen. Die Optionen vor der Musterliste legen den Abgleichstil fest, entweder reguläre Ausdrücke (regexp) oder Glob-Muster. Der Glob-Abgleich ist die Standardeinstellung, wenn keine Optionen angegeben werden. Die Verwendung der Option **--** beendet den Optionsprozess. Dies ermöglicht die Verwendung eines führenden „-“ in den Mustern.

**::fileutil::foreachLine** *var filename cmd*
: Der Befehl liest die Datei *Dateiname* ein und führt für jede Zeile in der Datei das Skript *cmd* aus. Während der Ausführung des Skripts wird die Variable *var* auf den Inhalt der aktuellen Zeile gesetzt. Der Wert dieses Befehls ist das Ergebnis des letzten Aufrufs des Skripts *cmd* oder die leere Zeichenkette, wenn die Datei leer war.

**::fileutil::grep** *pattern* ?*files*?
: Implementierung von **grep**. Adaptiert aus dem Tcler-Wiki. Das erste Argument definiert das *Muster*, nach dem gesucht werden soll. Darauf folgt eine Liste der *Dateien*, die durchsucht werden sollen. Die Liste ist optional; fehlt sie, wird **stdin** verwendet. Das Ergebnis der Prozedur ist eine Liste, die die Treffer enthält. Jeder Treffer ist ein einzelnes Element der Liste und enthält den Dateinamen, die Nummer und den Inhalt der übereinstimmenden Zeile, getrennt durch Doppelpunkte.

**::fileutil::install** ?**-m** *mode*? *source* *destination*
: Der Befehl **install** ähnelt in seiner Funktionsweise dem Befehl **install**, der auf vielen Unix-Systemen zu finden ist, oder dem Shell-Skript, das mit vielen Quellcode-Distributionen mitgeliefert wird (beispielsweise „unix/install-sh“ in den Tcl-Quellcodes).  Er kopiert *Quelle* – bei der es sich entweder um eine Datei oder ein Verzeichnis handeln kann – nach *Ziel*, das ein Verzeichnis sein sollte, es sei denn, *Quelle* ist ebenfalls eine einzelne Datei.  Mit der Option „-m“ kann der Benutzer einen Modus im Unix-Stil festlegen (entweder oktal oder symbolisch – siehe **file attributes**).

**::fileutil::stripN** *path* *n*
: Entfernt die ersten *n* Elemente aus dem angegebenen *Pfad* und gibt den geänderten Pfad zurück. Wenn *n* größer ist als die Anzahl der Komponenten in *Pfad*, wird eine leere Zeichenkette gegeben. Die Anzahl der Komponenten in einem bestimmten Pfad lässt sich ermitteln, indem Sie die Funktion **llength** auf die von **file split** zurückgegebene Liste anwendet.

**::fileutil::stripPwd** *path*
: Genau dann, wenn sich der *Pfad* innerhalb des von \[**pwd**\] gegebenen Verzeichnisses (oder des aktuellen Arbeitsverzeichnisses selbst) befindet, wird er relativ zu diesem Verzeichnis umgewandelt. Mit anderen Worten: Das aktuelle Verzeichnis wird aus dem *Pfad* entfernt. Der gegebenenfalls modifizierte Pfad wird als Ergebnis des Befehls zurückgegeben. Wenn das aktuelle Verzeichnis selbst für *Pfad* festgelegt wurde, gibt der Befehl die Zeichenkette „**.**“ zurück.

**::fileutil::stripPath** *prefix* *path*
: Nur wenn sich der *Pfad* innerhalb des Verzeichnisses „*Präfix*“ (oder im Präfixverzeichnis selbst) befindet, wird er relativ zu diesem Verzeichnis umgewandelt. Mit anderen Worten: Das Präfixverzeichnis wird aus dem *Pfad* entfernt. Der gegebenenfalls geänderte Pfad wird als Ergebnis des Befehls zurückgegeben. Wenn das Präfixverzeichnis selbst für *Pfad* festgelegt wurde, gibt der Befehl die Zeichenkette „**.**“ zurück.

**::fileutil::jail** *jail* *path*
: Dieser Befehl stellt sicher, dass der *Pfad* nicht aus dem Verzeichnis *jail* herausführt. Er gibt stets einen absoluten Pfad zurück, der aus *Pfad* abgeleitet wurde und sich innerhalb von *jail* befindet. Ist *Pfad* ein absoluter Pfad und befindet er sich bereits innerhalb von *jail*, wird er unverändert zurückgegeben. Ein absoluter Pfad außerhalb von *jail* wird um sein Stammverzeichnis gekürzt und dann in *jail* eingefügt, indem ihm dieses vorangestellt wird. Dasselbe geschieht, wenn *path* relativ ist, mit dem Unterschied, dass in diesem Fall nichts davon entfernt wird. Vor dem Hinzufügen des Präfixes *jail* wird *Pfad* lexikalisch normalisiert, um zu verhindern, dass der Aufrufer **..**-Segmente in *Pfad* verwendet, um aus dem *jail* zu entkommen.

**::fileutil::touch** ?**-a**? ?**-c**? ?**-m**? ?**-r** *ref_file*? ?**-t** *time*? *filename* ?*...*?
: Implementierung von **touch**. Ändert die atime und mtime der angegebenen Dateien. Wenn **-c** gesetzt ist, werden keine Dateien erstellt, sofern diese nicht bereits vorhanden sind. Wenn **-r**, werden die atime- und mtime-Werte aus *ref_file* verwendet. Wenn **-t** verwendet wird, wird der ganzzahlige Wert *time* verwendet. Es ist unzulässig, sowohl **-r** als auch **-t** festzulegen. Wenn **-a** erreicht wird, wird nur die atime geändert. Wenn **-m** erreicht wird, wird nur die mtime geändert. *Dieser Befehl ist für Tcl-Versionen unter 8.3 nicht verfügbar.*

**::fileutil::tempdir**
: Der Befehl gibt den Pfad eines Verzeichnisses zurück, in dem der Aufrufer temporäre Dateien ablegen kann, beispielsweise „*/tmp*“ auf Unix-Systemen. Der Algorithmus, den wir zur Ermittlung des richtigen Verzeichnisses verwenden, lautet wie folgt:


**\[1\]**
: Das Verzeichnis, das durch einen Aufruf von **::fileutil::tempdir** mit einem Argument festgelegt wurde. Wenn dieses vorhanden ist, wird ausschließlich dieses Verzeichnis geprüft, und keines der folgenden Elemente wird berücksichtigt.

**\[2\]**
: Das Verzeichnis, das in der Variable TMPDIR angegeben ist.

**\[3\]**
: Das Verzeichnis, das in der Variable TEMP angegeben ist.

**\[4\]**
: Das Verzeichnis, das in der Umgebungsvariablen TMP angegeben ist.

**\[5\]**
: Ein plattformspezifischer Speicherort:


**Windows**
: „*C:\\TEMP*“, „*C:\\TMP*“, „*\\TEMP*“ und „*\\TMP*“ werden in dieser Reihenfolge geprüft.

**(classic) Macintosh**
: Es wird die Variable TRASH_FOLDER verwendet. Dies ist höchstwahrscheinlich nicht korrekt.

**Unix**
: Die Verzeichnisse „*/tmp*“, „*/var/tmp*“ und „*/usr/tmp*“ werden in dieser Reihenfolge geprüft.


Der verwendete Algorithmus entspricht im Wesentlichen dem in der Python-Standardbibliothek verwendeten. Die einzige Ausnahme bildet der erste Punkt, nämlich die Möglichkeit, die Suche durch ein benutzerdefiniertes Verzeichnis zu überschreiben.

**::fileutil::tempdir** *path*
: In diesem Modus legt der Befehl den *Pfad* als erstes und einziges Verzeichnis fest, das als temporäres Verzeichnis verwendet werden soll. Informationen zur Verwendung des Verzeichnisses „set“ finden Sie im vorherigen Punkt. Der Befehl gibt die leere Zeichenkette zurück.

**::fileutil::tempdirReset**
: Durch die Ausführung dieses Befehls werden die Informationen gelöscht, die beim letzten Aufruf von \[**::fileutil::tempdir** *Pfad*\] festgelegt wurden. Siehe auch den letzten Punkt.

**::fileutil::tempfile** ?*prefix*?
: Der Befehl generiert einen Namen für eine temporäre Datei, in die geschrieben werden kann, sowie die zugehörige Datei. Der Dateiname ist eindeutig, die Datei ist beschreibbar und befindet sich im entsprechenden systemspezifischen temporären Verzeichnis. Der Name der Datei wird als Ergebnis des Befehls zurückgegeben. Der Code stammt aus *http://wiki.tcl.tk/772* und wird Igor Volobouev und einem anonymen Autor zugeschrieben.

**::fileutil::maketempdir** ?**-prefix** *str*? ?**-suffix** *str*? ?**-dir** *str*?
: Der Befehl erstellt ein temporäres Verzeichnis, in das geschrieben werden kann. Der Name des Verzeichnisses ist eindeutig, das Verzeichnis ist beschreibbar und befindet sich im entsprechenden systemspezifischen temporären Verzeichnis. Der Name des Verzeichnisses wird als Ergebnis des Befehls zurückgegeben. Mit den drei Optionen lässt sich das Verhalten des Befehls anpassen:


**-prefix** str
: Der anfängliche, feste Teil des Verzeichnisnamens. Wenn nicht angegeben, lautet der Standardwert **tmp**.

**-suffix** str
: Der feste Abschluss des Verzeichnisses. Wenn nichts angegeben wird, ist der Standardwert eine leere Zeichenkette.

**-dir** str
: Das Verzeichnis, in dem das neue Verzeichnis platziert werden soll. Wenn nichts angegeben wird, wird standardmäßig das Ergebnis von **fileutil::tempdir** verwendet.


Der ursprüngliche Code hierfür wurde von [Miguel Martinez Lopez](mailto:aplicacionamedida@gmail.com)] bereitgestellt.

**::fileutil::relative** *base* *dst*
: Dieser Befehl nimmt zwei Verzeichnispfade entgegen, die beide entweder absolut oder relativ sind, und berechnet den Pfad von *dst* relativ zu *base*. Dieser relative Pfad wird als Ergebnis des Befehls zurückgegeben. Wie aus dem vorigen Satz hervorgeht, kann der Befehl diese Beziehung zwischen den Argumenten nicht berechnen, wenn einer der Pfade absolut und der andere relativ ist. *Hinweis:* Der Prozess durch diesen Befehl erfolgt rein lexikalisch. Symbolische Verknüpfungen werden *nicht* berücksichtigt.

**::fileutil::relativeUrl** *base* *dst*
: Dieser Befehl nimmt zwei Dateipfade entgegen, die beide entweder absolut oder relativ sind, und berechnet den Pfad von *dst* relativ zu *base*, aus der Perspektive von *base* betrachtet. Dies entspricht dem Algorithmus, mit dem ein Browser einen relativen Link in der aktuell angezeigten Datei auflöst. Der berechnete relative Pfad wird als Ergebnis des Befehls zurückgegeben. Wie aus dem vorangegangenen Satz hervorgeht, kann der Befehl diese Beziehung zwischen den Argumenten nicht berechnen, wenn einer der Pfade absolut und der andere relativ ist. *Hinweis:* Die Verarbeitung durch diesen Befehl erfolgt rein lexikalisch. Symbolische Links werden *nicht* berücksichtigt.


# FEHLER UND INKOMPATIBILITÄTEN

**1.14.9**
: In dieser Version wurde das fehlerhafte System von **fileutil::find** zur Verarbeitung von Symlinks durch ein korrekt funktionierendes System ersetzt, das alle zulässigen, nicht zyklischen Pfade unter einem Basis-Verzeichnis ordnungsgemäß auflistet. Dies ist zwar korrekt, bedeutet jedoch, dass die Aufzählung bestimmter pathologischer Verzeichnishierarchien mit sich gegenseitig verweisenden Symlinks nun etwa O(n\*\*2) Zeit in Anspruch nimmt, während der ursprüngliche fehlerhafte Code aufgrund seiner Fehlerhaftigkeit O(n) schaffte. Ein konkretes Beispiel und Extremfall ist die „*/sys*“-Hierarchie unter Linux, in der einige hundert Geräte sowohl unter „*/sys/devices*“ als auch unter „*/sys/class*“ existieren, wobei die beiden Unterhierarchien miteinander verknüpft sind, was Millionen zulässige Pfade zur Aufzählung erzeugt. Die auf drei Geräte reduzierte Struktur sieht in etwa so aus:


```
	/sys/class/tty/tty0 --> ../../dev/tty0
	/sys/class/tty/tty1 --> ../../dev/tty1
	/sys/class/tty/tty2 --> ../../dev/tty1

	/sys/dev/tty0/bus
	/sys/dev/tty0/subsystem --> ../../class/tty
	/sys/dev/tty1/bus
	/sys/dev/tty1/subsystem --> ../../class/tty
	/sys/dev/tty2/bus
	/sys/dev/tty2/subsystem --> ../../class/tty
```

Der Befehl **fileutil::find** bietet derzeit keine Möglichkeit, dies zu umgehen. Wenn Sie mit einer solchen pathologischen Hierarchie umgehen müssen, empfiehlt es sich, auf das Paket **fileutil::traverse** und den darin enthaltenen gleichnamigen Befehl umzusteigen und anschließend die Option **-prefilter** zu verwenden, um zu verhindern, dass der Traverser symbolischen Links folgt, und zwar wie folgt:

```
    package require fileutil::traverse

    proc NoLinks {fileName} {
        if {[string equal [file type $fileName] link]} {
            return 0
        }
        return 1
    }

    fileutil::traverse T /sys/devices -prefilter NoLinks
    T foreach p {
        puts $p
    }
    T destroy
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *fileutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge
