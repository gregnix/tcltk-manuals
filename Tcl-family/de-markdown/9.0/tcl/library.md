---
CommandName: library
title: library
ManualSection: n
Version: 8.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - env(n)
 - info(n)
 - re_syntax(n)
Keywords:
 - auto-exec
 - auto-load
 - library
 - unknown
 - word
 - whitespace
Copyright:
 - Copyright (c) 1991-1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

auto\_execok, auto\_import, auto\_load, auto\_mkindex, auto\_qualify, auto\_reset, foreachLine, parray, readFile, tcl\_findLibrary, tcl\_endOfWord, tcl\_nonwordchars, tcl\_startOfNextWord, tcl\_startOfPreviousWord, tcl\_wordBreakAfter, tcl\_wordBreakBefore, tcl\_wordchars, writeFile - Standardbibliothek von Tcl-Prozeduren

# Übersicht

::: {.synopsis} :::
[auto\_execok]{.cmd} [cmd]{.arg}
[auto\_import]{.cmd} [pattern]{.arg}
[auto\_load]{.cmd} [cmd]{.arg}
[auto\_mkindex]{.cmd} [dir]{.arg} [pattern]{.arg} [pattern]{.arg} [...]{.arg}
[auto\_qualify]{.cmd} [command]{.arg} [namespace]{.arg}
[auto\_reset]{.cmd}
[tcl\_findLibrary]{.cmd} [basename]{.arg} [version]{.arg} [patch]{.arg} [initScript]{.arg} [enVarName]{.arg} [varName]{.arg}
[parray]{.cmd} [arrayName]{.arg} [pattern]{.optarg}
[tcl\_endOfWord]{.cmd} [str]{.arg} [start]{.arg}
[tcl\_startOfNextWord]{.cmd} [str]{.arg} [start]{.arg}
[tcl\_startOfPreviousWord]{.cmd} [str]{.arg} [start]{.arg}
[tcl\_wordBreakAfter]{.cmd} [str]{.arg} [start]{.arg}
[tcl\_wordBreakBefore]{.cmd} [str]{.arg} [start]{.arg}
[foreachLine]{.cmd version="TIP670"} [filename]{.arg} [varName]{.arg} [body]{.arg}
[readFile]{.cmd version="TIP670"} [filename]{.arg} [text|binary]{.optlit}
[writeFile]{.cmd version="TIP670"} [filename]{.arg} [text|binary]{.optlit} [contents]{.arg}
:::

# Einleitung

Tcl enthält eine Bibliothek von Tcl-Prozeduren für häufig benötigte Funktionen. Die in der Tcl-Bibliothek definierten Prozeduren sind allgemeine Prozeduren, die von vielen verschiedenen Anwendungen genutzt werden können. Der Speicherort der Tcl-Bibliothek wird vom Befehl [info library][info] zurückgegeben. Zusätzlich zur Tcl-Bibliothek verfügt jede Anwendung in der Regel über eine eigene Bibliothek unterstützender Prozeduren; der Speicherort dieser Bibliothek wird normalerweise durch den Wert der globalen Variable **$***app***\_library** angegeben, wobei *app* der Name der Anwendung ist. Beispielsweise wird der Speicherort der Tk-Bibliothek in der Variable [tk\_library][tkvars] gehalten.

Um auf die Prozeduren in der Tcl-Bibliothek zuzugreifen, sollte eine Anwendung die Datei **init.tcl** in der Bibliothek sourcen, beispielsweise mit dem Tcl-Befehl

```
source [file join [info library] init.tcl]
```

Wird die Bibliotheksprozedur [Tcl\_Init][Init] aus der [Tcl\_AppInit][AppInit]-Prozedur einer Anwendung aufgerufen, geschieht dies automatisch. Der Code in **init.tcl** definiert die Prozedur [unknown] und sorgt dafür, dass die übrigen Prozeduren bei Bedarf über den unten beschriebenen Auto-Load-Mechanismus geladen werden.

# Befehlsprozeduren

Die folgenden Prozeduren werden in der Tcl-Bibliothek bereitgestellt:

[auto\_execok]{.cmd} [cmd]{.arg}
: Ermittelt, ob es eine ausführbare Datei oder ein Shell-Builtin mit dem Namen *cmd* gibt. Falls ja, gibt sie eine Liste von Argumenten zurück, die an [exec] übergeben werden, um die ausführbare Datei oder das Shell-Builtin namens *cmd* auszuführen. Andernfalls gibt sie eine leere Zeichenkette zurück. Dieser Befehl durchsucht bei der Suche nach einer ausführbaren Datei namens *cmd* die Verzeichnisse im aktuellen Suchpfad (angegeben durch die Umgebungsvariable PATH). Auf Windows-Plattformen wird die Suche mit denselben Verzeichnissen und Dateierweiterungen erweitert, die auch [exec] verwendet. **Auto\_execok** merkt sich Informationen über frühere Suchen in einem Array namens **auto\_execs**; dies vermeidet die Pfadsuche bei künftigen Aufrufen für dasselbe *cmd*. Der Befehl **auto\_reset** kann verwendet werden, um **auto\_execok** zum Vergessen der zwischengespeicherten Informationen zu zwingen.

    Beispielsweise würde man auf Linux das Shell-Builtin *umask* so ausführen:

    ```
    exec {*}[auto_execok umask]
    ```

    Um das Shell-Builtin *DIR* unter Windows auszuführen, würde man Folgendes tun:

    ```
    exec {*}[auto_execok dir]
    ```

    Um festzustellen, ob sich ein *frobnicate*-Binary im PATH des Benutzers befindet, würde man Folgendes tun:

    ```
    set mayFrob [expr {[llength [auto_execok frobnicate]] > 0}]
    ```

[auto\_import]{.cmd} [pattern]{.arg}
: **Auto\_import** wird während [namespace import][namespace] aufgerufen, um zu prüfen, ob die durch *pattern* angegebenen importierten Befehle in einer per Auto-Load geladenen Bibliothek liegen. Falls ja, werden die Befehle geladen, damit sie dem Interpreter zum Erstellen der Import-Links zur Verfügung stehen. Liegen die Befehle nicht in einer per Auto-Load geladenen Bibliothek, tut **auto\_import** nichts. Der Mustervergleich erfolgt gemäß den Abgleichregeln von [namespace import][namespace].

    Es ist normalerweise nicht erforderlich, diesen Befehl direkt aufzurufen.

[auto\_load]{.cmd} [cmd]{.arg}
: Dieser Befehl versucht, die Definition für einen Tcl-Befehl namens *cmd* zu laden. Dazu durchsucht er einen *Auto-Load-Pfad*, eine Liste aus einem oder mehreren Verzeichnissen. Der Auto-Load-Pfad wird durch die globale Variable [auto\_path][tclvars] angegeben, falls diese existiert. Gibt es keine Variable [auto\_path][tclvars], wird die Umgebungsvariable **TCLLIBPATH** verwendet, falls sie existiert. Andernfalls besteht der Auto-Load-Pfad nur aus dem Tcl-Bibliotheksverzeichnis. In jedem Verzeichnis im Auto-Load-Pfad muss eine Datei **tclIndex** vorhanden sein, die einen oder mehrere in diesem Verzeichnis definierte Befehle beschreibt sowie ein Skript zum Auswerten, um jeden der Befehle zu laden. Die Datei **tclIndex** sollte mit dem Befehl **auto\_mkindex** erzeugt werden. Wird *cmd* in einer Indexdatei gefunden, wird das entsprechende Skript ausgewertet, um den Befehl zu erstellen. Der Befehl **auto\_load** gibt 1 zurück, wenn *cmd* erfolgreich erstellt wurde. Der Befehl gibt 0 zurück, wenn es keinen Indexeintrag für *cmd* gab oder wenn das Skript *cmd* nicht tatsächlich definiert hat (z. B. weil die Indexinformationen veraltet sind). Tritt beim Verarbeiten des Skripts ein Fehler auf, wird dieser Fehler zurückgegeben. **Auto\_load** liest die Indexinformationen nur einmal und speichert sie im Array **auto\_index**; künftige Aufrufe von **auto\_load** prüfen *cmd* im Array, anstatt die Indexdateien erneut zu lesen. Die zwischengespeicherten Indexinformationen können mit dem Befehl **auto\_reset** gelöscht werden. Dies zwingt den nächsten **auto\_load**-Befehl, die Indexdatenbank von der Festplatte neu zu laden.

    Es ist normalerweise nicht erforderlich, diesen Befehl direkt aufzurufen; der Standard-[unknown]-Handler erledigt dies.

[auto\_mkindex]{.cmd} [dir]{.arg} [pattern]{.arg} [pattern]{.arg} [...]{.arg}
: Erzeugt einen Index, der für **auto\_load** geeignet ist. Der Befehl durchsucht *dir* nach allen Dateien, deren Namen einem der *pattern*-Argumente entsprechen (der Abgleich erfolgt mit dem Befehl [glob]), erzeugt einen Index aller in allen passenden Dateien definierten Tcl-Befehlsprozeduren und speichert die Indexinformationen in einer Datei namens **tclIndex** in *dir*. Wird kein Muster angegeben, wird ein Muster von **\*.tcl** angenommen. Beispielsweise liest der Befehl

    ```
    auto_mkindex foo *.tcl
    ```

    alle **.tcl**-Dateien im Unterverzeichnis **foo** und erzeugt eine neue Indexdatei **foo/tclIndex**.

    **Auto\_mkindex** parst die Tcl-Skripte, indem es sie in einen Kind-Interpreter sourcet und die ausgeführten proc- und namespace-Befehle überwacht. Erweiterungen können das (undokumentierte) Paket auto\_mkindex\_parser verwenden, um andere Befehle zu registrieren, die zum Auto-Load-Index beitragen können. Wie dies funktioniert, muss man in auto.tcl nachlesen.

    **Auto\_mkindex\_old** (mit derselben Syntax wie **auto\_mkindex**) parst die Tcl-Skripte auf relativ einfache Weise: Enthält eine Zeile das Wort „[proc]“ als erste Zeichen, wird angenommen, dass es sich um eine Prozedurdefinition handelt, und das nächste Wort der Zeile wird als Name der Prozedur genommen. Prozedurdefinitionen, die nicht in dieser Form erscheinen (z. B. mit Leerzeichen vor [proc]), werden nicht indiziert. Enthält Ihr Skript „gefährlichen“ Code, etwa globalen Initialisierungscode oder Prozedurnamen mit Sonderzeichen wie **$**, **\***, **\[** oder **\]**, ist die Verwendung von **auto\_mkindex\_old** sicherer.

[auto\_reset]{.cmd}
: Löscht alle von **auto\_execok** und **auto\_load** zwischengespeicherten Informationen. Diese Informationen werden beim nächsten Bedarf von der Festplatte neu gelesen. **Auto\_reset** löscht außerdem alle im Auto-Load-Index aufgeführten Prozeduren, sodass beim nächsten Gebrauch frische Kopien geladen werden.

[auto\_qualify]{.cmd} [command]{.arg} [namespace]{.arg}
: Berechnet eine Liste vollständig qualifizierter Namen für *command*. Diese Liste spiegelt den Pfad wider, den ein Standard-Tcl-Interpreter bei der Befehlssuche verfolgt: Zuerst sucht er den Befehl im aktuellen Namespace, dann im globalen Namespace. Entsprechend hat die zurückgegebene Liste zwei Elemente, wenn *command* relativ ist und *namespace* nicht **::** ist: *command* im Gültigkeitsbereich von *namespace*, als wäre es ein Befehl im Namespace *namespace*; und *command*, als wäre es ein Befehl im globalen Namespace. Andernfalls, wenn entweder *command* absolut ist (mit **::** beginnt) oder *namespace* **::** ist, enthält die Liste nur *command*, als wäre es ein Befehl im globalen Namespace.

    **Auto\_qualify** wird von den Auto-Load-Einrichtungen in Tcl verwendet, sowohl zum Erzeugen von Auto-Load-Indizes wie *pkgIndex.tcl* als auch zum tatsächlichen Auto-Load von Funktionen zur Laufzeit.

[tcl\_findLibrary]{.cmd} [basename]{.arg} [version]{.arg} [patch]{.arg} [initScript]{.arg} [enVarName]{.arg} [varName]{.arg}
: Dies ist eine Standard-Suchprozedur für Erweiterungen während ihrer Initialisierung. Sie rufen diese Prozedur auf, um ihre Skriptbibliothek in mehreren Standardverzeichnissen zu suchen. Die letzte Komponente des Namens des Bibliotheksverzeichnisses ist normalerweise *basenameversion* (z. B. tk8.0), kann aber in Build-Hierarchien „library“ sein. Die Datei *initScript* wird in den Interpreter gesourcet, sobald sie gefunden wurde. Das Verzeichnis, in dem diese Datei gefunden wurde, wird in der globalen Variable *varName* gespeichert. Ist diese Variable bereits definiert (z. B. durch C-Code während der Anwendungsinitialisierung), wird nicht gesucht. Andernfalls erfolgt die Suche in diesen Verzeichnissen: dem durch die Umgebungsvariable *enVarName* benannten Verzeichnis; relativ zum Tcl-Bibliotheksverzeichnis; relativ zur ausführbaren Datei im Standard-Installationsverzeichnis bin oder bin/*arch*; relativ zur ausführbaren Datei im aktuellen Build-Baum; relativ zur ausführbaren Datei in einem parallelen Build-Baum.

[parray]{.cmd} [arrayName]{.arg} [pattern]{.optarg}
: Gibt auf der Standardausgabe die Namen und Werte aller Elemente im Array *arrayName* aus, oder nur die Namen, die auf *pattern* passen (gemäß den Abgleichregeln von [string match][string]), und deren Werte, falls *pattern* angegeben ist. *ArrayName* muss ein Array sein, das dem Aufrufer von **parray** zugänglich ist. Es kann lokal oder global sein. Das Ergebnis dieses Befehls ist die leere Zeichenkette.

    Beispielsweise gibt man zum Ausgeben des Inhalts des Arrays [tcl\_platform][tclvars] Folgendes ein:

    ```
    parray tcl_platform
    ```


## Hilfsprozeduren für Wortgrenzen

Diese Prozeduren werden hauptsächlich intern von Tk verwendet.

[tcl\_endOfWord]{.cmd} [str]{.arg} [start]{.arg}
: Gibt den Index der ersten Wortende-Position zurück, die nach einem Startindex *start* in der Zeichenkette *str* auftritt. Eine Wortende-Position ist definiert als das erste Nicht-Wort-Zeichen, das auf das erste Wort-Zeichen nach dem Startpunkt folgt. Gibt -1 zurück, wenn nach dem Startpunkt keine weiteren Wortende-Positionen vorhanden sind. Siehe die Beschreibung von **tcl\_wordchars** und **tcl\_nonwordchars** unten für weitere Details, wie Tcl bestimmt, welche Zeichen Wort-Zeichen sind.

[tcl\_startOfNextWord]{.cmd} [str]{.arg} [start]{.arg}
: Gibt den Index der ersten Wortanfang-Position zurück, die nach einem Startindex *start* in der Zeichenkette *str* auftritt. Eine Wortanfang-Position ist definiert als das erste Wort-Zeichen, das auf ein Nicht-Wort-Zeichen folgt. Gibt -1 zurück, wenn nach dem Startpunkt keine weiteren Wortanfang-Positionen vorhanden sind.

    Beispielsweise gibt man zum Ausgeben der Indizes der Wortanfänge in einer Zeichenkette gemäß Plattformregeln Folgendes aus:

    ```
    set theString "The quick brown fox"
    for {set idx 0} {$idx >= 0} {
            set idx [tcl_startOfNextWord $theString $idx]} {
        puts "Word start index: $idx"
    }
    ```

[tcl\_startOfPreviousWord]{.cmd} [str]{.arg} [start]{.arg}
: Gibt den Index der ersten Wortanfang-Position zurück, die vor einem Startindex *start* in der Zeichenkette *str* auftritt. Gibt -1 zurück, wenn vor dem Startpunkt keine weiteren Wortanfang-Positionen vorhanden sind.

[tcl\_wordBreakAfter]{.cmd} [str]{.arg} [start]{.arg}
: Gibt den Index der ersten Wortgrenze nach dem Startindex *start* in der Zeichenkette *str* zurück. Gibt -1 zurück, wenn in der angegebenen Zeichenkette nach dem Startpunkt keine weiteren Grenzen vorhanden sind. Der zurückgegebene Index bezieht sich auf das zweite Zeichen des Paares, das eine Grenze bildet.

[tcl\_wordBreakBefore]{.cmd} [str]{.arg} [start]{.arg}
: Gibt den Index der ersten Wortgrenze vor dem Startindex *start* in der Zeichenkette *str* zurück. Gibt -1 zurück, wenn in der angegebenen Zeichenkette vor dem Startpunkt keine weiteren Grenzen vorhanden sind. Der zurückgegebene Index bezieht sich auf das zweite Zeichen des Paares, das eine Grenze bildet.


## Hilfsprozeduren für Dateizugriff

[foreachLine]{.cmd} [varName]{.arg} [filename]{.arg} [body]{.arg}
: [Liest die Textdatei namens *filename* zeilenweise ein (unter Verwendung der Systemvorgaben zum Lesen von Textdateien). Sie schreibt diese Zeile in die Variable namens *varName* und führt anschließend *body* für diese Zeile aus. Der Ergebniswert von *body* wird ignoriert, aber [error], [return], [break] und [continue] können darin verwendet werden, um einen Fehler zu erzeugen, aus dem aufrufenden Kontext zurückzukehren, die Schleife zu beenden bzw. zur nächsten Zeile zu gehen. Das Gesamtergebnis von **foreachLine** ist die leere Zeichenkette (vorausgesetzt, keine Fehler durch E/A oder durch Auswerten des Schleifenkörpers); die Datei wird vor dem Zurückkehren der Prozedur geschlossen.]{version="TIP670"}

[readFile]{.cmd} [filename]{.arg} [text|binary]{.optlit}
: [Liest die in *filename* benannte Datei ein und gibt deren Inhalt zurück. Das zweite Argument legt fest, wie die Datei eingelesen wird, entweder als **text** (unter Verwendung der Systemvorgaben zum Lesen von Textdateien) oder als [binary] (als uninterpretierte Bytes). Standard ist **text**. Beim Lesen als Text ist eine abschließende Newline enthalten. Die Datei wird vor dem Zurückkehren der Prozedur geschlossen.]{version="TIP670"}

[writeFile]{.cmd} [filename]{.arg} [text|binary]{.optlit} [contents]{.arg}
: [Schreibt *contents* in die in *filename* benannte Datei. Das optionale zweite Argument legt fest, wie in die Datei geschrieben wird, entweder als **text** (unter Verwendung der Systemvorgaben zum Schreiben von Textdateien) oder als [binary] (als uninterpretierte Bytes). Standard ist **text**. Ist eine abschließende Newline erforderlich, muss sie in *contents* bereitgestellt werden. Das Ergebnis dieses Befehls ist die leere Zeichenkette; die Datei wird vor dem Zurückkehren der Prozedur geschlossen.]{version="TIP670"}


# Variablen

Die folgenden globalen Variablen werden von den Prozeduren in der Tcl-Bibliothek definiert oder verwendet. Sie fallen in zwei große Kategorien: Umgang mit unbekannten Befehlen und Paketen sowie Bestimmung dessen, was Wörter sind.

## Variablen für Auto-Load und Paketverwaltung

**auto\_execs**
: Wird von **auto\_execok** verwendet, um Informationen darüber zu speichern, ob bestimmte Befehle als ausführbare Dateien existieren.

    Wird normalerweise nicht sinnvoll direkt durch Benutzercode angesprochen.

**auto\_index**
: Wird von **auto\_load** verwendet, um die von der Festplatte gelesenen Indexinformationen zu speichern.

    Wird normalerweise nicht sinnvoll direkt durch Benutzercode angesprochen.

**auto\_noexec**
: Ist sie auf einen beliebigen Wert gesetzt, versucht [unknown] nicht, Befehle per Auto-Exec auszuführen.

**auto\_noload**
: Ist sie auf einen beliebigen Wert gesetzt, versucht [unknown] nicht, Befehle per Auto-Load zu laden.

[auto\_path][tclvars]
: Ist sie gesetzt, muss sie eine gültige Tcl-Liste mit Verzeichnissen enthalten, die während Auto-Load-Operationen durchsucht werden (einschließlich Paketindexdateien bei Verwendung des Standard-[package unknown][package]-Handlers). Diese Variable wird beim Start initialisiert und enthält der Reihe nach: die in der Umgebungsvariable **TCLLIBPATH** aufgeführten Verzeichnisse, das durch die globale Variable [tcl\_library][tclvars] benannte Verzeichnis, das übergeordnete Verzeichnis von [tcl\_library][tclvars], die in der Variable [tcl\_pkgPath][tclvars] aufgeführten Verzeichnisse. Zusätzliche Speicherorte für Dateien und Paketindizes sollten normalerweise mit [lappend] zu dieser Variable hinzugefügt werden.

    Beispielsweise würde man zum Hinzufügen des Verzeichnisses *lib* neben dem laufenden Skript Folgendes tun:

    ```
    lappend auto_path [file dirname [info script]]/lib
    ```

    Nutzt das Skript [cd], sollten die Einträge auf [auto\_path][tclvars] mit [file normalize][file] normalisiert werden.

**env(TCL\_LIBRARY)**
: Ist sie gesetzt, legt sie den Ort des Verzeichnisses mit Bibliotheksskripten fest (der Wert dieser Variable wird der Variable [tcl\_library][tclvars] zugewiesen und daher vom Befehl [info library][info] zurückgegeben). Ist diese Variable nicht gesetzt, wird ein Standardwert verwendet.

    Die Verwendung dieser Umgebungsvariable wird außerhalb von Tests nicht empfohlen. Tcl-Installationen sollten bereits wissen, wo ihre eigenen Skriptdateien zu finden sind, da der Wert beim Build oder bei der Installation fest eingebaut wird.

**env(TCLLIBPATH)**
: Ist sie gesetzt, muss sie eine gültige Tcl-Liste mit Verzeichnissen enthalten, die bei Auto-Load-Vorgängen durchsucht werden. Verzeichnisse müssen im Tcl-Format angegeben werden, mit „/“ als Pfadtrenner, unabhängig von der Plattform. Diese Variable wird nur bei der Initialisierung der Variable [auto\_path][tclvars] verwendet.

    Eine wichtige Folge dieser Variable ist, dass sie dem Benutzer eines Skripts eine Möglichkeit gibt, die Liste der Orte anzugeben, von denen aus dieses Skript mit [package require][package] Pakete laden darf. Sie ist normalerweise nicht sinnvoll innerhalb eines Tcl-Skripts selbst setzbar, *außer* um zu beeinflussen, von wo andere Interpreter laden (ob mit [interp create][interp] erstellt oder als eigene Threads oder Subprozesse gestartet).


## Variablen zur Bestimmung von Wortgrenzen

Diese Variablen werden nur in den Befehlen **tcl\_endOfWord**, **tcl\_startOfNextWord**, **tcl\_startOfPreviousWord**, **tcl\_wordBreakAfter** und **tcl\_wordBreakBefore** verwendet.

**tcl\_nonwordchars**
: Diese Variable enthält einen regulären Ausdruck, der von Routinen wie **tcl\_endOfWord** verwendet wird, um zu ermitteln, ob ein Zeichen Teil eines Wortes ist oder nicht. Passt das Muster auf ein Zeichen, gilt das Zeichen als Nicht-Wort-Zeichen. Der Standardwert ist **\\W**.

**tcl\_wordchars**
: Diese Variable enthält einen regulären Ausdruck, der von Routinen wie **tcl\_endOfWord** verwendet wird, um zu ermitteln, ob ein Zeichen Teil eines Wortes ist oder nicht. Passt das Muster auf ein Zeichen, gilt das Zeichen als Wort-Zeichen. Der Standardwert ist **\\w**.


[AppInit]: ../tcl-c/AppInit.md
[binary]: binary.md
[break]: break.md
[cd]: cd.md
[continue]: continue.md
[error]: error.md
[exec]: exec.md
[file]: file.md
[glob]: glob.md
[info]: info.md
[Init]: ../tcl-c/Init.md
[interp]: interp.md
[lappend]: lappend.md
[namespace]: namespace.md
[package]: package.md
[proc]: proc.md
[return]: return.md
[string]: string.md
[tclvars]: tclvars.md
[tkvars]: ../tk/tkvars.md
[unknown]: unknown.md
