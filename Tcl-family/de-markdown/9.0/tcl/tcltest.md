---
CommandName: tcltest
title: tcltest
ManualSection: n
Version: 2.5
TclPart: tcltest
TclDescription: Tcl Bundled Packages
Keywords:
 - test
 - test harness
 - test suite
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
 - Copyright (c) 1998-1999 Scriptics Corporation
 - Copyright (c) 2000 Ajuba Solutions
---

# Name

tcltest - Unterstützungscode und Hilfsbefehle für Test-Harness

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcltest]{.lit} [2.5]{.optlit}

[tcltest::test]{.cmd} [name]{.arg} [description]{.arg} [-option value]{.optdot}
[tcltest::test]{.cmd} [name]{.arg} [description]{.arg} [constraints]{.optarg} [body]{.arg} [result]{.arg}

[tcltest::loadTestedCommands]{.cmd}
[tcltest::makeDirectory]{.cmd} [name]{.arg} [directory]{.optarg}
[tcltest::removeDirectory]{.cmd} [name]{.arg} [directory]{.optarg}
[tcltest::makeFile]{.cmd} [contents]{.arg} [name]{.arg} [directory]{.optarg}
[tcltest::removeFile]{.cmd} [name]{.arg} [directory]{.optarg}
[tcltest::viewFile]{.cmd} [name]{.arg} [directory]{.optarg}
[tcltest::cleanupTests]{.cmd} [runningMultipleTests]{.optarg}
[tcltest::runAllTests]{.cmd}

[tcltest::configure]{.cmd}
[tcltest::configure]{.cmd} [-option]{.arg}
[tcltest::configure]{.cmd} [-option]{.arg} [value]{.arg} [-option value]{.optdot}
[tcltest::customMatch]{.cmd} [mode]{.arg} [command]{.arg}
[tcltest::testConstraint]{.cmd} [constraint]{.arg} [value]{.optarg}
[tcltest::outputChannel]{.cmd} [channel]{.optarg}
[tcltest::errorChannel]{.cmd} [channel]{.optarg}
[tcltest::interpreter]{.cmd} [interp]{.optarg}

[tcltest::debug]{.cmd} [level]{.optarg}
[tcltest::errorFile]{.cmd} [filename]{.optarg}
[tcltest::limitConstraints]{.cmd} [boolean]{.optarg}
[tcltest::loadFile]{.cmd} [filename]{.optarg}
[tcltest::loadScript]{.cmd} [script]{.optarg}
[tcltest::match]{.cmd} [patternList]{.optarg}
[tcltest::matchDirectories]{.cmd} [patternList]{.optarg}
[tcltest::matchFiles]{.cmd} [patternList]{.optarg}
[tcltest::outputFile]{.cmd} [filename]{.optarg}
[tcltest::preserveCore]{.cmd} [level]{.optarg}
[tcltest::singleProcess]{.cmd} [boolean]{.optarg}
[tcltest::skip]{.cmd} [patternList]{.optarg}
[tcltest::skipDirectories]{.cmd} [patternList]{.optarg}
[tcltest::skipFiles]{.cmd} [patternList]{.optarg}
[tcltest::temporaryDirectory]{.cmd} [directory]{.optarg}
[tcltest::testsDirectory]{.cmd} [directory]{.optarg}
[tcltest::verbose]{.cmd} [level]{.optarg}

[tcltest::test]{.cmd} [name]{.arg} [description]{.arg} [optionList]{.arg}
[tcltest::normalizeMsg]{.cmd} [msg]{.arg}
[tcltest::normalizePath]{.cmd} [pathVar]{.arg}
[tcltest::workingDirectory]{.cmd} [dir]{.optarg}
:::

# Beschreibung

Das Paket **tcltest** stellt mehrere Hilfsbefehle bereit, die beim Aufbau von Test-Suites für Code nützlich sind, der durch Auswertung von Tcl-Befehlen getestet werden soll. Insbesondere werden die eingebauten Befehle der Tcl-Bibliothek selbst mit einer Test-Suite getestet, die das Paket tcltest verwendet.

Alle vom Paket **tcltest** bereitgestellten Befehle sind im Namespace **::tcltest** definiert und werden von dort exportiert, wie in der [Übersicht] oben angegeben. In den folgenden Abschnitten werden alle Befehle der Kürze halber mit ihren einfachen Namen beschrieben.

Der zentrale Befehl von **tcltest** ist **test**, der einen Test definiert und ausführt. Tests mit **test** umfassen die Auswertung eines Tcl-Skripts und den Vergleich des Ergebnisses mit einem erwarteten Ergebnis, wie durch zahlreiche Optionen konfiguriert und gesteuert. Weitere Befehle von **tcltest** steuern die Konfiguration von **test** und das Zusammenfassen vieler **test**-Befehle zu Test-Suites.

Siehe [Test-Suites mit tcltest erstellen] unten für ein ausführliches Beispiel, wie die Befehle von **tcltest** zum Erzeugen von Test-Suites für Tcl-basierten Code verwendet werden.

# Befehle

[test]{.cmd} [name]{.arg} [description]{.arg} [-option value]{.optdot}
: Definiert und führt gegebenenfalls einen Test mit dem Namen *name* und der Beschreibung *description* aus. Name und Beschreibung eines Tests werden in von **test** während des Tests gemeldeten Meldungen verwendet, wie durch die Optionen von **tcltest** konfiguriert. Die übrigen *option value*-Argumente von **test** definieren den Test, einschließlich der auszuführenden Skripte, der Bedingungen für deren Ausführung, des erwarteten Ergebnisses und der Art, wie erwartete und tatsächliche Ergebnisse verglichen werden sollen. Siehe [Tests] unten für eine vollständige Beschreibung der gültigen Optionen und wie sie einen Test definieren. Der Befehl **test** gibt einen leeren String zurück.

[test]{.cmd} [name]{.arg} [description]{.arg} [constraints]{.optarg} [body]{.arg} [result]{.arg}
: Diese Form von **test** unterstützt Test-Suites, die für Version 1 des Pakets **tcltest** geschrieben wurden, und bietet außerdem eine einfachere Schnittstelle für häufige Verwendung. Sie entspricht „**test** *name description* **-constraints** *constraints* **-body** *body* **-result** *result*“. Alle anderen Optionen von **test** behalten ihre Standardwerte. Wenn *constraints* weggelassen wird, lässt sich diese Form von **test** von der ersten unterscheiden, weil alle *option*-Namen mit „-“ beginnen.

[loadTestedCommands]{.cmd}
: Wertet im Kontext des Aufrufers das von **configure -load** oder **configure -loadfile** angegebene Skript aus. Gibt das Ergebnis dieser Skriptauswertung zurück, einschließlich jedes vom Skript ausgelösten Fehlers. Verwenden Sie diesen Befehl und die zugehörigen Konfigurationsoptionen, um die zu testenden Befehle dem Interpreter bereitzustellen, der die Test-Suite ausführt.

[makeFile]{.cmd} [contents]{.arg} [name]{.arg} [directory]{.optarg}
: Erstellt eine Datei namens *name* relativ zum Verzeichnis *directory* und schreibt *contents* mit der Kodierung [encoding system][encoding] in diese Datei. Endet *contents* nicht mit einem Zeilenumbruch, wird einer angehängt, sodass die Datei *name* mit einem Zeilenumbruch endet. Da die Systemkodierung verwendet wird, eignet sich dieser Befehl nur zum Erzeugen von Textdateien. Die Datei wird bei der nächsten Auswertung von **cleanupTests** entfernt, sofern sie nicht zuvor mit **removeFile** gelöscht wurde. Der Standardwert von *directory* ist das Verzeichnis **configure -tmpdir**. Gibt den vollständigen Pfad der erstellten Datei zurück. Verwenden Sie diesen Befehl, um beliebige vom Test benötigte Textdateien mit passendem Inhalt zu erzeugen.

[removeFile]{.cmd} [name]{.arg} [directory]{.optarg}
: Erzwingt das Entfernen der durch *name* referenzierten Datei. Der Dateiname sollte relativ zu *directory* sein. Der Standardwert von *directory* ist das Verzeichnis **configure -tmpdir**. Gibt einen leeren String zurück. Verwenden Sie diesen Befehl, um mit **makeFile** erstellte Dateien zu löschen.

[makeDirectory]{.cmd} [name]{.arg} [directory]{.optarg}
: Erstellt ein Verzeichnis namens *name* relativ zum Verzeichnis *directory*. Das Verzeichnis wird bei der nächsten Auswertung von **cleanupTests** entfernt, sofern es nicht zuvor mit **removeDirectory** gelöscht wurde. Der Standardwert von *directory* ist das Verzeichnis **configure -tmpdir**. Gibt den vollständigen Pfad des erstellten Verzeichnisses zurück. Verwenden Sie diesen Befehl, um alle von einem Test benötigten Verzeichnisse zu erzeugen.

[removeDirectory]{.cmd} [name]{.arg} [directory]{.optarg}
: Erzwingt das Entfernen des durch *name* referenzierten Verzeichnisses. Das Verzeichnis sollte relativ zu *directory* sein. Der Standardwert von *directory* ist das Verzeichnis **configure -tmpdir**. Gibt einen leeren String zurück. Verwenden Sie diesen Befehl, um mit **makeDirectory** erstellte Verzeichnisse zu löschen.

[viewFile]{.cmd} [file]{.arg} [directory]{.optarg}
: Gibt den Inhalt von *file* zurück, ohne einen abschließenden Zeilenumbruch, wie [read -nonewline][read] ihn liefern würde. Der Dateiname sollte relativ zu *directory* sein. Der Standardwert von *directory* ist das Verzeichnis **configure -tmpdir**. Verwenden Sie diesen Befehl, um den Inhalt einer vom Test erzeugten Datei bequem als Testergebnis für den Abgleich mit einem erwarteten Ergebnis zu verwenden. Der Dateiinhalt wird mit der Systemkodierung gelesen; die Nützlichkeit beschränkt sich daher auf Textdateien.

[cleanupTests]{.cmd}
: Dient dazu, nach mehreren ausgeführten Tests aufzuräumen und zusammenzufassen. Wird typischerweise einmal pro Testdatei am Ende der Datei aufgerufen, nachdem alle Tests abgeschlossen sind. Damit er zuverlässig wirkt, sollte **cleanupTests** auch dann ausgewertet werden, wenn zuvor bei der Auswertung der Testdatei ein Fehler auftrat.

    Gibt Statistiken über die ausgeführten Tests aus und entfernt Dateien, die seit dem letzten **cleanupTests** mit **makeDirectory** und **makeFile** erstellt wurden. Namen von Dateien und Verzeichnissen im Verzeichnis **configure -tmpdir**, die seit dem letzten **cleanupTests** entstanden, aber nicht mit **makeFile** oder **makeDirectory** erzeugt wurden, werden auf **outputChannel** ausgegeben. Der Befehl stellt außerdem die ursprüngliche Shell-Umgebung wieder her, wie im globalen Array [env][tclvars] beschrieben. Gibt einen leeren String zurück.

[runAllTests]{.cmd}
: Hauptbefehl zum Ausführen einer gesamten Test-Suite über mehrere Dateien und/oder Verzeichnisse, gesteuert durch die konfigurierbaren Optionen von **tcltest**. Siehe [Alle Tests ausführen] unten für eine vollständige Beschreibung der vielen Varianten mit **runAllTests**.


## Konfigurationsbefehle

[configure]{.cmd}
: Gibt die Liste der von **tcltest** unterstützten konfigurierbaren Optionen zurück. Siehe [Konfigurierbare Optionen] unten für die vollständige Liste der Optionen, ihrer gültigen Werte und ihrer Wirkung auf **tcltest**-Operationen.

[configure]{.cmd} [option]{.arg}
: Gibt den aktuellen Wert der unterstützten konfigurierbaren Option *option* zurück. Löst einen Fehler aus, wenn *option* keine unterstützte konfigurierbare Option ist.

[configure]{.cmd} [option]{.arg} [value]{.arg} [-option value]{.optdot}
: Setzt den Wert jeder konfigurierbaren Option *option* der Reihe nach auf den entsprechenden Wert *value*. Löst einen Fehler aus, wenn eine *option* keine unterstützte konfigurierbare Option ist, wenn *value* kein gültiger Wert für die entsprechende *option* ist oder wenn kein *value* angegeben wurde. Bei einem Fehler wird die Operation von **configure** abgebrochen; nachfolgende *option value*-Argumente werden nicht verarbeitet.

    Existiert die Umgebungsvariable **::env(TCLTEST\_OPTIONS)**, wenn das Paket **tcltest** geladen wird (durch [package require][package] **tcltest**), wird deren Wert als Argumentliste für **configure** verwendet. So können Standardwerte der Konfigurationsoptionen über die Umgebung gesetzt werden.

[customMatch]{.cmd} [mode]{.arg} [script]{.arg}
: Registriert *mode* als neuen gültigen Wert der **-match**-Option von **test**. Wird die Option **-match** *mode* an **test** übergeben, wird das Skript *script* ausgewertet, um das tatsächliche Ergebnis der Auswertung des Testkörpers mit dem erwarteten Ergebnis zu vergleichen. Für den Abgleich wird das *script* um zwei zusätzliche Wörter ergänzt — das erwartete und das tatsächliche Ergebnis — und das vollständige Skript im globalen Namespace ausgewertet. Das vollständige Skript soll einen booleschen Wert zurückgeben, der angibt, ob die Ergebnisse übereinstimmen. Die eingebauten Abgleichsmodi von **test** sind **exact**, [glob] und [regexp].

[testConstraint]{.cmd} [constraint]{.arg} [boolean]{.optarg}
: Setzt oder gibt den booleschen Wert zurück, der der benannten *constraint* zugeordnet ist. Siehe [Test-Einschränkungen] unten für weitere Informationen.

[interpreter]{.cmd} [executableName]{.optarg}
: Setzt oder gibt den Namen der ausführbaren Datei zurück, die von **runAllTests** per [exec] gestartet wird, um jede Testdatei auszuführen, wenn **configure -singleproc** false ist. Der Standardwert für **interpreter** ist der Name des aktuell laufenden Programms, wie von [info nameofexecutable][info] zurückgegeben.

[outputChannel]{.cmd} [channel]{.optarg}
: Setzt oder gibt den Ausgabekanal zurück. Standard ist **stdout**. Jeder Test, der testbezogene Ausgabe erzeugt, sollte diese an **outputChannel** senden, statt sie standardmäßig nach **stdout** zu leiten.

[errorChannel]{.cmd} [channel]{.optarg}
: Setzt oder gibt den Fehlerkanal zurück. Standard ist **stderr**. Jeder Test, der Fehlermeldungen ausgibt, sollte diese an **errorChannel** senden, statt direkt nach **stderr** zu schreiben.


## Kurzbefehle für die Konfiguration

[debug]{.cmd} [level]{.optarg}
: Entspricht „**configure -debug** ?*level*?“.

**errorFile** ?*filename*?
: Entspricht „**configure -errfile** ?*filename*?“.

[limitConstraints]{.cmd} [boolean]{.optarg}
: Entspricht „**configure -limitconstraints** ?*boolean*?“.

[loadFile]{.cmd} [filename]{.optarg}
: Entspricht „**configure -loadfile** ?*filename*?“.

[loadScript]{.cmd} [script]{.optarg}
: Entspricht „**configure -load** ?*script*?“.

[match]{.cmd} [patternList]{.optarg}
: Entspricht „**configure -match** ?*patternList*?“.

[matchDirectories]{.cmd} [patternList]{.optarg}
: Entspricht „**configure -relateddir** ?*patternList*?“.

[matchFiles]{.cmd} [patternList]{.optarg}
: Entspricht „**configure -file** ?*patternList*?“.

[outputFile]{.cmd} [filename]{.optarg}
: Entspricht „**configure -outfile** ?*filename*?“.

[preserveCore]{.cmd} [level]{.optarg}
: Entspricht „**configure -preservecore** ?*level*?“.

[singleProcess]{.cmd} [boolean]{.optarg}
: Entspricht „**configure -singleproc** ?*boolean*?“.

[skip]{.cmd} [patternList]{.optarg}
: Entspricht „**configure -skip** ?*patternList*?“.

[skipDirectories]{.cmd} [patternList]{.optarg}
: Entspricht „**configure -asidefromdir** ?*patternList*?“.

[skipFiles]{.cmd} [patternList]{.optarg}
: Entspricht „**configure -notfile** ?*patternList*?“.

[temporaryDirectory]{.cmd} [directory]{.optarg}
: Entspricht „**configure -tmpdir** ?*directory*?“.

[testsDirectory]{.cmd} [directory]{.optarg}
: Entspricht „**configure -testdir** ?*directory*?“.

[verbose]{.cmd} [level]{.optarg}
: Entspricht „**configure -verbose** ?*level*?“.


## Weitere Befehle

Die übrigen von **tcltest** bereitgestellten Befehle haben bessere Alternativen in **tcltest** oder **Tcl** selbst. Sie bleiben zur Unterstützung bestehender Test-Suites erhalten, sollten in neuem Code aber vermieden werden.

**test** *name description optionList*
: Diese Form von **test** ermöglichte, viele über mehrere Zeilen verteilte Optionen als ein einziges in geschweiften Klammern gesetztes Argument an **test** zu übergeben, statt Zeilenumbrüche zwischen Argumenten mit Backslash zu quoten. Das Argument *optionList* soll eine Liste mit gerader Elementanzahl sein, die *option*- und *value*-Argumente für **test** darstellt. Diese Werte werden jedoch nicht direkt übergeben, wie bei den alternativen Formen von [switch]. Stattdessen versucht diese Form leider, Tcls Ersetzungsregeln zu umgehen, indem auf einigen Listenelementen Ersetzungen vorgenommen werden, um eine „mach-was-ich-meine“-Interpretation eines in Klammern gesetzten „Blocks“ zu implementieren. Das Ergebnis ist nahezu undokumentierbar; diese Form wird daher nicht empfohlen. Die Beispiele in [Test-Suites mit tcltest erstellen] unten zeigen, dass diese Form wirklich nicht nötig ist, um Backslash-quotierte Zeilenumbrüche zu vermeiden. Wenn Sie diese Form dennoch verwenden wollen, untersuchen Sie den Quellcode von **tcltest** für Ersetzungsdetails, oder setzen Sie das dritte bis letzte Argument von **test** in Klammern und hoffen Sie auf das Beste.

[workingDirectory]{.cmd} [directoryName]{.optarg}
: Setzt oder gibt das aktuelle Arbeitsverzeichnis während der Ausführung der Test-Suite zurück. Der Standardwert für workingDirectory ist das Verzeichnis, in dem die Test-Suite gestartet wurde. Die Tcl-Befehle [cd] und [pwd] sind ausreichende Ersatzlösungen.

[normalizeMsg]{.cmd} [msg]{.arg}
: Gibt das Ergebnis zurück, *msg* von „überflüssigen“ Zeilenumbrüchen zu befreien — wobei „überflüssig“ recht unpräzise ist. Tcl bietet zahlreiche String-Befehle zur beliebigen Modifikation von Strings, und **customMatch** ermöglicht flexiblen Abgleich tatsächlicher und erwarteter Ergebnisse.

[normalizePath]{.cmd} [pathVar]{.arg}
: Löst symbolische Links in einem Pfad auf und erzeugt so einen Pfad ohne interne Umleitungen. Es wird angenommen, dass *pathVar* absolut ist. *pathVar* wird an Ort und Stelle geändert. Der Tcl-Befehl [file normalize][file] ist eine ausreichende Ersatzlösung.


# Tests

Der Befehl **test** ist das Herzstück des Pakets **tcltest**. Seine wesentliche Funktion ist die Auswertung eines Tcl-Skripts und der Vergleich des Ergebnisses mit einem erwarteten Ergebnis. Die Optionen von **test** definieren das Testskript, die Umgebung für die Auswertung, das erwartete Ergebnis und die Art des Vergleichs zwischen tatsächlichem und erwartetem Ergebnis. Einige Konfigurationsoptionen von **tcltest** beeinflussen ebenfalls das Verhalten von **test**.

Die gültigen Optionen von **test** sind zusammengefasst:

```
test name description
        ?-constraints keywordList|expression?
        ?-setup setupScript?
        ?-body testScript?
        ?-cleanup cleanupScript?
        ?-result expectedAnswer?
        ?-output expectedOutput?
        ?-errorOutput expectedError?
        ?-returnCodes codeList?
        ?-errorCode expectedErrorCode?
        ?-match mode?
```

Der *name* kann ein beliebiger String sein. Üblich ist die Wahl eines *name* nach dem Muster:

```
target-majorNum.minorNum
```

Bei White-Box-(Regressions-)Tests sollte das Ziel der Name der getesteten C-Funktion oder Tcl-Prozedur sein. Bei Black-Box-Tests sollte das Ziel der Name des getesteten Merkmals sein. Einige Konventionen verlangen für Black-Box-Tests das Suffix **\_bb**. Verwandte Tests sollten dieselbe Hauptnummer teilen. Mit der Entwicklung einer Test-Suite ist es am besten, wenn derselbe Testname weiterhin demselben Test entspricht, sodass Aussagen wie „Test foo-1.3 bestand in allen Versionen bis 3.4, schlug aber ab Version 3.5 fehl“ sinnvoll bleiben.

Bei der Auswertung von **test** wird der *name* mit den von **configure -match** und **configure -skip** zurückgegebenen Listen von String-Abgleichmustern verglichen. Der Test wird nur ausgeführt, wenn *name* mindestens einem Muster von **configure -match** entspricht und keinem Muster von **configure -skip**.

Die *description* sollte eine kurze textuelle Beschreibung des Tests sein. Die *description* erscheint in der vom Test erzeugten Ausgabe, typischerweise in Fehlermeldungen bei Testfehlern. Gute *description*-Werte erklären Nutzern einer Test-Suite kurz den Zweck des Tests. Bei Regressions-Tests sollte der Name der getesteten Tcl- oder C-Funktion in der Beschreibung stehen. Existiert der Testfall, um einen Fehler zu reproduzieren, gehört die Fehler-ID in die Beschreibung.

Gültige Attribute und zugehörige Werte sind:

[-constraints]{.lit} [keywordList|expression]{.arg}
: Das optionale Attribut **-constraints** kann eine Liste aus einem oder mehreren Schlüsselwörtern oder ein Ausdruck sein. Ist der **-constraints**-Wert eine Schlüsselwortliste, sollte jedes Schlüsselwort der Name einer durch **testConstraint** definierten Einschränkung sein. Ist eine der gelisteten Einschränkungen false oder existiert nicht, wird der Test übersprungen. Ist der **-constraints**-Wert ein Ausdruck, wird dieser ausgewertet. Wertet der Ausdruck zu true aus, wird der Test ausgeführt.

    Beachten Sie, dass die Ausdrucksform von **-constraints** mit **configure -constraints** und **configure -limitconstraints** interferieren kann und nicht empfohlen wird.

    Tests, die nicht immer laufen sollen, sollten passende Einschränkungen erhalten. Bedingte Ausführung eines Tests soll über die Option **-constraints** erfolgen, nicht durch bedingte Auswertung von **test**. So meldet die Test-Suite stets dieselbe Anzahl Tests; die Zahl übersprungener Tests kann je nach Testumgebung variieren. Standardwert ist eine leere Liste. Siehe [Test-Einschränkungen] unten für eingebaute Einschränkungen und das Hinzufügen eigener Einschränkungen.

[-setup]{.lit} [script]{.arg}
: Das optionale Attribut **-setup** gibt ein *script* an, das vor dem durch **-body** angegebenen Skript ausgeführt wird. Löst die Auswertung von *script* einen Fehler aus, schlägt der Test fehl. Standardwert ist ein leeres Skript.

[-body]{.lit} [script]{.arg}
: Das Attribut **-body** gibt das *script* an, das den Test ausführt und ein auf Korrektheit prüfbares Ergebnis zurückgeben muss. Löst die Auswertung von *script* einen Fehler aus, schlägt der Test fehl (es sei denn, **-returnCodes** legt fest, dass ein Fehler erwartet wird). Standardwert ist ein leeres Skript.

[-cleanup]{.lit} [script]{.arg}
: Das optionale Attribut **-cleanup** gibt ein *script* an, das nach dem durch **-body** angegebenen Skript ausgeführt wird. Löst die Auswertung von *script* einen Fehler aus, schlägt der Test fehl. Standardwert ist ein leeres Skript.

[-match]{.lit} [mode]{.arg}
: Das Attribut **-match** legt fest, wie die von **-result**, **-output** und **-errorOutput** gelieferten erwarteten Antworten verglichen werden. Gültige Werte für *mode* sind [regexp], [glob], **exact** und jeder durch einen früheren Aufruf von **customMatch** registrierte Wert. Standardwert ist **exact**.

[-result]{.lit} [expectedValue]{.arg}
: Das Attribut **-result** liefert den *expectedValue*, mit dem der Rückgabewert des Skripts verglichen wird. Standardwert ist ein leerer String.

[-output]{.lit} [expectedValue]{.arg}
: Das Attribut **-output** liefert den *expectedValue*, mit dem jede während der Auswertung der Skripte an **stdout** oder **outputChannel** gesendete Ausgabe verglichen wird. Beachten Sie, dass nur Ausgabe des globalen Befehls [puts] zum Vergleich verwendet wird. Ist **-output** nicht angegeben, wird an **stdout** und **outputChannel** gesendete Ausgabe nicht zum Vergleich verarbeitet.

[-errorOutput]{.lit} [expectedValue]{.arg}
: Das Attribut **-errorOutput** liefert den *expectedValue*, mit dem jede während der Auswertung der Skripte an **stderr** oder **errorChannel** gesendete Ausgabe verglichen wird. Beachten Sie, dass nur Ausgabe des globalen Befehls [puts] zum Vergleich verwendet wird. Ist **-errorOutput** nicht angegeben, wird an **stderr** und **errorChannel** gesendete Ausgabe nicht zum Vergleich verarbeitet.

[-returnCodes]{.lit} [expectedCodeList]{.arg}
: Das optionale Attribut **-returnCodes** liefert *expectedCodeList*, eine Liste von Rückgabecodes, die bei der Auswertung des **-body**-Skripts akzeptiert werden dürfen. Liefert die Auswertung des **-body**-Skripts einen Code außerhalb von *expectedCodeList*, schlägt der Test fehl. Alle [return] bekannten Rückgabecodes in numerischer und symbolischer Form, einschließlich erweiterter Rückgabecodes, sind zulässige Elemente in *expectedCodeList*. Standardwert ist „**ok return**“.

[-errorCode]{.lit} [expectedErrorCode]{.arg}
: Das optionale Attribut **-errorCode** liefert *expectedErrorCode*, ein Glob-Muster, das zum bei der Auswertung des **-body**-Skripts gemeldeten Fehlercode passen soll. Liefert die Auswertung des **-body**-Skripts keinen zu *expectedErrorCode* passenden Code, schlägt der Test fehl. Standardwert ist „**\***“. Enthält **-returnCodes** nicht **error**, wird es auf **error** gesetzt.


Damit ein Test besteht, müssen **-setup**, **-body** und **-cleanup** erfolgreich ausgewertet werden. Rückgabecode und Ergebnis des **-body**-Skripts müssen den erwarteten Werten entsprechen; sind angegeben, müssen Ausgabe- und Fehlerdaten des Tests den erwarteten **-output**- und **-errorOutput**-Werten entsprechen. Ist eine dieser Bedingungen nicht erfüllt, schlägt der Test fehl. Beachten Sie, dass alle Skripte im Kontext des Aufrufers von **test** ausgewertet werden.

Solange **test** mit gültiger Syntax und legalen Werten für alle Attribute aufgerufen wird, löst es keinen Fehler aus. Testfehler werden stattdessen als Ausgabe auf **outputChannel** gemeldet. Im Standardbetrieb erzeugt ein erfolgreicher Test keine Ausgabe. Die von **test** erzeugten Meldungen werden durch **configure -verbose** gesteuert, wie in [Konfigurierbare Optionen] unten beschrieben. Ausgabe der Testskripte selbst sollte mit [puts] nach **outputChannel** oder **errorChannel** erfolgen, damit Nutzer der Test-Suite Ausgabe leicht mit **configure -outfile** und **configure -errfile** erfassen können und die Attribute **-output** und **-errorOutput** korrekt funktionieren.

## Test-Einschränkungen

Einschränkungen bestimmen, ob ein Test übersprungen werden soll. Jede Einschränkung hat einen Namen (beliebiger String) und einen booleschen Wert. Jeder **test** hat einen **-constraints**-Wert als Liste von Einschränkungsnamen. Es gibt zwei Modi der Einschränkungssteuerung. Am häufigsten wird der Standardmodus verwendet, angezeigt durch **configure -limitconstraints** false. Der Test läuft nur, wenn alle Einschränkungen in der Liste true sind. Die **-constraints**-Option von **test** ist daher eine bequeme, symbolische Möglichkeit, Bedingungen für einen sinnvollen oder möglichen Test zu definieren. Ein **test** mit **-constraints unix** läuft nur, wenn die Einschränkung **unix** true ist, was anzeigt, dass die Test-Suite auf einer Unix-Plattform läuft.

Jeder **test** sollte die **-constraints** enthalten, die ihn auf passende Umgebungen beschränken. Mehrere Einschränkungen sind im Paket **tcltest** vordefiniert (unten aufgelistet). Benutzerdefinierte Einschränkungen werden mit **testConstraint** registriert. Sie können in einer Testdatei oder im Skript von **configure -load** bzw. **configure -loadfile** stehen.

Folgende Einschränkungen sind im Paket **tcltest** selbst vordefiniert:

*singleTestInterp*
: Dieser Test kann nur ausgeführt werden, wenn alle Testdateien in einen einzigen Interpreter geladen werden.

*unix*
: Dieser Test kann nur auf einer Unix-Plattform ausgeführt werden.

*win*
: Dieser Test kann nur auf einer Windows-Plattform ausgeführt werden.

*nt*
: Dieser Test kann nur auf einer Windows-NT-Plattform ausgeführt werden.

*mac*
: Dieser Test kann nur auf einer Mac-Plattform ausgeführt werden.

*unixOrWin*
: Dieser Test kann nur auf Unix oder Windows ausgeführt werden.

*macOrWin*
: Dieser Test kann nur auf Mac oder Windows ausgeführt werden.

*macOrUnix*
: Dieser Test kann nur auf Mac oder Unix ausgeführt werden.

*tempNotWin*
: Dieser Test kann unter Windows nicht ausgeführt werden. Dieses Flag dient zum vorübergehenden Deaktivieren.

*tempNotMac*
: Dieser Test kann auf dem Mac nicht ausgeführt werden. Dieses Flag dient zum vorübergehenden Deaktivieren.

*unixCrash*
: Dieser Test stürzt unter Unix ab. Dieses Flag dient zum vorübergehenden Deaktivieren.

*winCrash*
: Dieser Test stürzt unter Windows ab. Dieses Flag dient zum vorübergehenden Deaktivieren.

*macCrash*
: Dieser Test stürzt auf dem Mac ab. Dieses Flag dient zum vorübergehenden Deaktivieren.

*emptyTest*
: Dieser Test ist leer und lohnt sich nicht, bleibt aber als Platzhalter für einen späteren Test. Diese Bedingung ist false, damit Tests übersprungen werden, sofern der Nutzer nichts anderes angibt.

*knownBug*
: Dieser Test ist als fehlschlagend bekannt; der Fehler ist noch nicht behoben. Diese Bedingung ist false, damit Tests übersprungen werden, sofern der Nutzer nichts anderes angibt.

*nonPortable*
: Dieser Test kann nur in einer bekannten Entwicklungsumgebung ausgeführt werden. Manche Tests sind von Natur aus nicht portabel (Wortlänge, Dateisystem, Window-Manager usw.). Diese Bedingung ist false, damit Tests übersprungen werden, sofern der Nutzer nichts anderes angibt.

*userInteraction*
: Dieser Test erfordert Benutzerinteraktion. Diese Bedingung ist false, damit Tests übersprungen werden, sofern der Nutzer nichts anderes angibt.

*interactive*
: Dieser Test kann nur ausgeführt werden, wenn der Interpreter im interaktiven Modus ist (wenn die globale Variable **::tcl\_interactive** auf 1 gesetzt ist).

*nonBlockFiles*
: Dieser Test kann nur ausgeführt werden, wenn die Plattform Dateien im nicht-blockierenden Modus setzen kann.

*asyncPipeClose*
: Dieser Test kann nur ausgeführt werden, wenn die Plattform asynchrones Leeren und Schließen von Pipes unterstützt.

*unixExecs*
: Dieser Test kann nur ausgeführt werden, wenn auf dieser Maschine Unix-Befehle **cat**, **echo**, **sh**, **wc**, **rm**, **sleep**, **fgrep**, **ps**, **chmod** und **mkdir** verfügbar sind.

*hasIsoLocale*
: Dieser Test kann nur ausgeführt werden, wenn zu einer ISO-Locale gewechselt werden kann.

*root*
: Dieser Test kann nur ausgeführt werden, wenn der Unix-Benutzer root ist.

*notRoot*
: Dieser Test kann nur ausgeführt werden, wenn der Unix-Benutzer nicht root ist.

*eformat*
: Dieser Test kann nur ausgeführt werden, wenn die Anwendung eine funktionierende sprintf-Version für das "e"-Format von Gleitkommazahlen hat.

*stdio*
: Dieser Test kann nur ausgeführt werden, wenn **interpreter** als Pipe [open] werden kann.


Der alternative Modus wird mit **configure -limitconstraints** true aktiviert. Dann werden alle Bedingungen außer denen in der von **configure -constraints** zurückgegebenen Liste auf false gesetzt. Beim Setzen von **configure -constraints** werden diese Bedingungen auf true gesetzt. Mit beiden Optionen laufen nur Tests, deren Bedingungen ausschließlich aus der **configure -constraints**-Liste stammen; alle anderen werden übersprungen. Beispielkonfiguration:

```
configure -constraints knownBug \
          -limitconstraints true \
          -verbose pass
```

um genau die Tests mit bekannten Fehlern auszuführen und zu prüfen, ob einer besteht — was auf eine Behebung hindeutet.

## Alle Tests ausführen

Der Befehl **runAllTests** führt eine gesamte Test-Suite über viele Dateien und Verzeichnisse aus. Die Konfigurationsoptionen von **tcltest** steuern die genauen Abläufe. **runAllTests** gibt zuerst eine Zusammenfassung der Konfiguration auf **outputChannel** aus.

Zu auswertende Testdateien werden in **configure -testdir** gesucht. Es wird eine sortierte Liste der Dateien erzeugt, die **configure -file** treffen und **configure -notfile** nicht. Jede Datei wird nacheinander ausgewertet. Bei **configure -singleproc** true wird jede Datei im Kontext des Aufrufers [source]d. Bei false startet eine Kopie von **interpreter** per [exec] je Datei. Der Mehrprozess-Modus hilft, wenn Tests Prozesse beenden können: Der Hauptprozess setzt die Suite fort. Die **tcltest**-Konfiguration des Hauptprozesses wird als Kommandozeilenargumente an Kindprozesse übergeben, außer **configure -outfile**. **runAllTests** im Hauptprozess sammelt Kindausgaben zu einem Gesamtbericht. Einzelne Fehlermeldungen oder **configure -verbose**-Meldungen gehen direkt an **outputChannel**.

Nach allen ausgewählten Testdateien folgt eine Zusammenfassung auf **outputChannel**: Gesamtzahl der **test**-Auswertungen, aufgeteilt in übersprungene, bestandene und fehlgeschlagene; Anzahl der Dateien; Namen fehlerhafter Dateien; Bedingungen mit Übersprungszahlen; Hinweise, wenn Testdateien temporäre Dateien in **configure -tmpdir** hinterlassen haben.

Nach Abschluss wertet **runAllTests** Unterverzeichnisse von **configure -testdir** rekursiv aus. Unterverzeichnisse, die **configure -relateddir** treffen und **configure -asidefromdir** nicht, werden untersucht. Enthält ein Verzeichnis **all.tcl**, wird es im Kontext des Aufrufers [source]d. Mit oder ohne **all.tcl** werden Unterverzeichnisse weiter geprüft. So kann ein **runAllTests**-Aufruf Testdateien in vielen Verzeichnissen eines Baums auswerten.

# Konfigurierbare Optionen

Der Befehl **configure** setzt und fragt die konfigurierbaren Optionen von **tcltest** ab. Gültige Optionen:

[-singleproc]{.lit} [boolean]{.arg}
: Steuert, ob **runAllTests** je Testdatei einen Kindprozess erzeugt. Kein Spawnen bei *boolean* true. Standardwert ist false.

[-debug]{.lit} [level]{.arg}
: Setzt die Debug-Stufe *level* (Ganzzahl) für die Menge an Debug-Informationen auf **stdout**. Debug-Meldungen gehen stets nach **stdout**, unabhängig von **configure -outfile**. Standardwert ist 0. Stufen:

    0
    : Keine Debug-Informationen anzeigen.

    1
    : Informationen, ob ein Test wegen **configure -match** (userSpecifiedNonMatch) oder **configure -skip** (userSpecifiedSkip) übersprungen wird; Warnungen zu fehlendem Aufräumen oder Ungleichgewicht in Testdateien; Warnungen bei Wiederverwendung von Testnamen.

    2
    : Flag-Array des Kommandozeilenprozessors, Inhalt des globalen [env][tclvars]-Arrays und alle benutzerdefinierten Variablen im aktuellen Namespace bei Verwendung.

    3
    : Informationen, was einzelne Procs im Test-Harness tun.


[-verbose]{.lit} [level]{.arg}
: Setzt die gewünschte Ausgabeausführlichkeit *level* als Liste aus null oder mehr Elementen **body**, **pass**, **skip**, **start**, **error**, **line**, **msec** und **usec**. Standardwert ist "**body error**". Stufen:

    body (**b**)
    : Körper fehlgeschlagener Tests anzeigen

    pass (**p**)
    : Ausgabe, wenn ein Test besteht

    skip (**s**)
    : Ausgabe, wenn ein Test übersprungen wird

    start (**t**)
    : Ausgabe beim Start jedes Tests

    error (**e**)
    : errorInfo und errorCode ausgeben, falls vorhanden, wenn der Rückgabecode nicht dem erwarteten entspricht

    line (**l**)
    : Zeileninformationen fehlgeschlagener Tests ausgeben

    msec (**m**)
    : Ausführungszeit jedes Tests in Millisekunden ausgeben

    usec (**u**)
    : Ausführungszeit jedes Tests in Mikrosekunden ausgeben


    Die Stufen **msec** und **usec** sind nur indikative Maße. Sie lösen nicht das Problem der Wiederholbarkeit bei Performance-Tests oder Benchmarks. Für gründliche Verfolgung von Leistungseinbußen Testkörper mit [time] umschließen.

    Die Einbuchstaben-Abkürzungen gelten ebenfalls, sodass "**configure -verbose pt**" dasselbe ist wie "**configure -verbose {pass start}**".

[-preservecore]{.lit} [level]{.arg}
: Setzt die Core-Erhaltungsstufe *level*, die bestimmt, wie streng Core-Dateien geprüft werden. Standardwert ist 0. Stufen:

    0
    : Keine Prüfung — keine Core-Dateien am Ende jedes Testbefehls; Prüfung in **runAllTests** nach allen Testdateien.

    1
    : Zusätzlich Core-Dateien am Ende jedes **test**-Befehls prüfen.

    2
    : Core-Dateien in allen oben genannten Fällen prüfen und eine Kopie jeder Core-Datei in **configure -tmpdir** speichern.


[-limitconstraints]{.lit} [boolean]{.arg}
: Setzt den Modus, in dem **test** Bedingungen wie in [Tests] oben beschrieben berücksichtigt. Standardwert ist false.

[-constraints]{.lit} [list]{.arg}
: Setzt alle Bedingungen in *list* auf true. Zusammen mit **configure -limitconstraints true** für den alternativen Modus in [Tests] oben. Standardwert ist eine leere Liste.

[-tmpdir]{.lit} [directory]{.arg}
: Setzt das temporäre Verzeichnis für **makeFile**, **makeDirectory**, **viewFile**, **removeFile** und **removeDirectory** als Standardort für temporäre Dateien und Verzeichnisse aus Testdateien. Standardwert ist **workingDirectory**.

[-testdir]{.lit} [directory]{.arg}
: Setzt das von **runAllTests** durchsuchte Verzeichnis für Testdateien und Unterverzeichnisse. Standardwert ist **workingDirectory**.

[-file]{.lit} [patternList]{.arg}
: Setzt die Musterliste, mit der **runAllTests** Testdateien zur Auswertung bestimmt. Standardwert ist "**\*.test**".

[-notfile]{.lit} [patternList]{.arg}
: Setzt die Musterliste für von **runAllTests** zu überspringende Testdateien. Standardwert ist "**l.\*.test**", damit SCCS-Sperrdateien übersprungen werden.

[-relateddir]{.lit} [patternList]{.arg}
: Setzt die Musterliste für Unterverzeichnisse, in denen **runAllTests** nach **all.tcl** sucht. Standardwert ist "**\***".

[-asidefromdir]{.lit} [patternList]{.arg}
: Setzt die Musterliste für zu überspringende Unterverzeichnisse bei der **all.tcl**-Suche. Standardwert ist eine leere Liste.

[-match]{.lit} [patternList]{.arg}
: Setzt die Musterliste, mit der **test** bestimmt, ob ein Test ausgeführt wird. Standardwert ist "**\***".

[-skip]{.lit} [patternList]{.arg}
: Setzt die Musterliste, mit der **test** bestimmt, ob ein Test übersprungen wird. Standardwert ist eine leere Liste.

[-load]{.lit} [script]{.arg}
: Setzt ein von **loadTestedCommands** auszuwertendes Skript. Standardwert ist ein leeres Skript.

[-loadfile]{.lit} [filename]{.arg}
: Setzt den Dateinamen für ein von **loadTestedCommands** auszuwertendes Skript. Alternative zu **-load**; nicht gemeinsam verwendbar.

[-outfile]{.lit} [filename]{.arg}
: Setzt die Datei für alle von tcltest erzeugten Ausgaben. Die Datei *filename* wird zum Schreiben [open]et; der Kanal wird als **outputChannel** gesetzt.

[-errfile]{.lit} [filename]{.arg}
: Setzt die Datei für alle Fehlerausgaben von tcltest. Die Datei *filename* wird zum Schreiben [open]et; der Kanal wird als **errorChannel** gesetzt.


# Test-Suites mit tcltest erstellen

Das grundlegende Element einer Test-Suite ist der einzelne Befehl **test**. Wir beginnen mit mehreren Beispielen.

1. Test eines Skripts mit normalem Rückgabewert.

    ```
    test example-1.0 {normal return} {
        format %s value
    } value
    ```

2. Test eines Skripts mit Kontext-Setup und -Aufräumen. Beachten Sie Klammerung und Einrückung ohne Zeilenfortsetzung.

    ```
    test example-1.1 {test file existence} -setup {
        set file [makeFile {} test]
    } -body {
        file exists $file
    } -cleanup {
        removeFile test
    } -result 1
    ```

3. Test eines Skripts, das einen Fehler auslöst.

    ```
    test example-1.2 {error return} -body {
        error message
    } -returnCodes error -result message
    ```

4. Test mit einer Bedingung.

    ```
    test example-1.3 {user owns created files} -constraints {
        unix
    } -setup {
        set file [makeFile {} test]
    } -body {
        file attributes $file -owner
    } -cleanup {
        removeFile test
    } -result $::tcl_platform(user)
    ```


Auf der nächsten Organisationsebene werden mehrere **test**-Befehle in einer Testdatei zusammengefasst. Testdateien sollten die Endung "**.test**" haben — das Standardmuster von **runAllTests**. Als Faustregel gilt: eine Testdatei pro Quellcodedatei. Test- und Quelldatei gemeinsam bearbeiten, Tests mit Codeänderungen synchron halten.

Der Großteil einer Testdatei sollte **test**-Befehle sein. Tests per Bedingungen überspringen, nicht durch bedingte Auswertung von **test**.

5. Empfohlenes System für bedingte Tests mit Bedingungen als Schutz:

    ```
    testConstraint X [expr $myRequirement]
    test goodConditionalTest {} X {
        # body
    } result
    ```

6. Nicht empfohlenes System mit [if] als Schutz:

    ```
    if $myRequirement {
        test badConditionalTest {} {
            #body
        } result
    }
    ```


Verwenden Sie **-setup** und **-cleanup**, um den Kontext des Testkörpers herzustellen und freizugeben. Tests nicht von vorherigen Tests in der Datei abhängig machen — diese können übersprungen sein. Benötigen mehrere Tests denselben Kontext, können Setup- und Cleanup-Skripte in Variablen für **-setup** und **-cleanup** jedes Tests gespeichert werden. Besser als Setup außerhalb von **test**: Setup nur bei Bedarf; Setup-Fehler werden gemeldet und brechen die Datei nicht ab.

Eine Testdatei sollte sich mit anderen kombinieren lassen, ohne sie zu stören — auch wenn **configure -singleproc 1** alle Dateien in einem Interpreter auswertet. Definieren Sie Befehle und Variablen in einem Namespace, der nach der Testdatei gelöscht wird. Geeignet ist ein Kind-Namespace **test** des Modul-Namespaces.

Eine Testdatei sollte auch direkt als Skript auswertbar sein, ohne **runAllTests**. Jede Testdatei sollte Kommandozeilenargumente verarbeiten, damit der Tester die volle **tcltest**-Konfiguration hat.

Nach allen **test**-Befehlen in einer Testdatei sollte **cleanupTests** aufgerufen werden.

7. Skizze einer Beispiel-Testdatei:

    ```
    package require tcltest 2.5
    ::tcltest::configure {*}$::argv
    package require example
    namespace eval ::example::test {
        namespace import ::tcltest::*
        testConstraint X [expr {...}]
        variable SETUP {#common setup code}
        variable CLEANUP {#common cleanup code}
        test example-1 {} -setup $SETUP -body {
            # First test
        } -cleanup $CLEANUP -result {...}
        test example-2 {} -constraints X -setup $SETUP -body {
            # Second test; constrained
        } -cleanup $CLEANUP -result {...}
        test example-3 {} {
            # Third test; no context required
        } {...}
        cleanupTests
    }
    namespace delete ::example::test
    ```


Die nächste Ebene ist eine vollständige Test-Suite aus mehreren Testdateien. Ein Skript steuert die Suite und ruft nach Setup **runAllTests** auf. Üblicher Name: **all.tcl** — Standardname von **runAllTests** beim Zusammenfassen mehrerer Suites.

8. Skizze eines Hauptskripts einer Test-Suite:

    ```
    package require tcltest 2.5
    package require example
    ::tcltest::configure -testdir \
            [file dirname [file normalize [info script]]]
    ::tcltest::configure {*}$::argv
    ::tcltest::runAllTests
    ```


# Kompatibilität

Einige Befehle und Variablen im Namespace **::tcltest** früherer **tcltest**-Versionen sind hier nicht dokumentiert. Sie gehören nicht mehr zur unterstützten öffentlichen Schnittstelle und sollten in neuen Test-Suites nicht verwendet werden. Zur Unterstützung bestehender Suites funktionieren viele veraltete Befehle und Variablen noch. So wird **configure** oft kurz nach erfolgreichen [package require][package] **tcltest 2.1** automatisch mit Argumenten aus **::argv** aufgerufen — für Suites, die auf automatische Konfiguration aus Kommandozeilenargumenten angewiesen sind. Neue Testdateien sollten das nicht voraussetzen, sondern explizit enthalten:

```
::tcltest::configure {*}$::argv
```

um eine Konfiguration aus Kommandozeilenargumenten herzustellen.

# Bekannte Probleme

Es gibt zwei bekannte Probleme bei verschachtelten **test**-Auswertungen. Das erste betrifft die Stack-Ebene der Testskripte. Verschachtelte Tests können auf derselben Stack-Ebene wie der äußerste Test laufen. Beispiel:

```
test level-1.1 {level 1} {
    -body {
        test level-2.1 {level 2} {
        }
    }
}
```

jedes in level-2.1 ausgeführte Skript kann auf derselben Stack-Ebene wie das Skript für level-1.1 laufen.

Zudem meldet **cleanupTests** nach zwei **test**-Läufen Ergebnisse nur für Tests auf derselben Ebene wie level-1.1. Ergebnisse aller Tests vor level-1.1 sind verfügbar, wenn level-2.1 läuft. Beim Zugriff auf Ergebnisse von level-2.1 kann stehen, dass „m“ Tests liefen, „n“ übersprungen, „o“ bestanden und „p“ fehlschlugen — wobei m, n, o und p Tests auf derselben Ebene wie level-1.1 meinen.

Ausgabe- und Fehlervergleich in **test** hängen von [puts] in der Anwendung ab. Ausgabe wird abgefangen, indem [puts] global neu definiert wird. Von C-Prozeduren geworfene oder direkt gedruckte Fehler erfasst **test** nicht. **-output** und **-errorOutput** sind daher nur für reine Tcl-Anwendungen mit [puts]-Ausgabe sinnvoll.


[cd]: cd.md
[encoding]: encoding.md
[exec]: exec.md
[file]: file.md
[glob]: glob.md
[if]: if.md
[info]: info.md
[open]: open.md
[package]: package.md
[puts]: puts.md
[pwd]: pwd.md
[read]: read.md
[regexp]: regexp.md
[return]: return.md
[source]: source.md
[switch]: switch.md
[tclvars]: tclvars.md
[time]: time.md
