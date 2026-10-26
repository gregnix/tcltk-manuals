---
CommandName: library
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

# NAME

auto_execok, auto_import, auto_load, auto_mkindex, auto_qualify, auto_reset, parray, tcl_findLibrary, tcl_endOfWord, tcl_nonwordchars, tcl_startOfNextWord, tcl_startOfPreviousWord, tcl_wordBreakAfter, tcl_wordBreakBefore, tcl_wordchars - Standardbibliothek von Tcl-Prozeduren

# ÜBERSICHT

::: {.synopsis} :::
[auto_execok]{.cmd} [cmd]{.arg} 
[auto_import]{.cmd} [pattern]{.arg} 
[auto_load]{.cmd} [cmd]{.arg} 
[auto_mkindex]{.cmd} [dir]{.arg} [pattern]{.arg} [pattern]{.arg} [...]{.arg} 
[auto_qualify]{.cmd} [command]{.arg} [namespace]{.arg} 
[auto_reset]{.cmd} 
[tcl_findLibrary]{.cmd} [basename]{.arg} [version]{.arg} [patch]{.arg} [initScript]{.arg} [enVarName]{.arg} [varName]{.arg} 
[parray]{.cmd} [arrayName]{.arg} [pattern]{.optarg} 
[tcl_endOfWord]{.cmd} [str]{.arg} [start]{.arg} 
[tcl_startOfNextWord]{.cmd} [str]{.arg} [start]{.arg} 
[tcl_startOfPreviousWord]{.cmd} [str]{.arg} [start]{.arg} 
[tcl_wordBreakAfter]{.cmd} [str]{.arg} [start]{.arg} 
[tcl_wordBreakBefore]{.cmd} [str]{.arg} [start]{.arg} 
:::

# EINLEITUNG

Tcl enthält eine Bibliothek von Tcl-Prozeduren für häufig benötigte Funktionen. Die in der Tcl-Bibliothek definierten Prozeduren sind allgemeine Prozeduren, die von vielen verschiedenen Anwendungen genutzt werden können. Der Speicherort der Tcl-Bibliothek wird vom Befehl **info library** zurückgegeben. Zusätzlich zur Tcl-Bibliothek verfügt jede Anwendung in der Regel über eine eigene Bibliothek unterstützender Prozeduren; der Speicherort dieser Bibliothek wird normalerweise durch den Wert der globalen Variable **$***app***_library** angegeben, wobei *app* der Name der Anwendung ist. Beispielsweise wird der Speicherort der Tk-Bibliothek in der Variable **tk_library** gehalten.

Um auf die Prozeduren in der Tcl-Bibliothek zuzugreifen, sollte eine Anwendung die Datei **init.tcl** in der Bibliothek sourcen, beispielsweise mit dem Tcl-Befehl

```
source [file join [info library] init.tcl]
```

Wird die Bibliotheksprozedur **Tcl_Init** aus der **Tcl_AppInit**-Prozedur einer Anwendung aufgerufen, geschieht dies automatisch. Der Code in **init.tcl** definiert die Prozedur **unknown** und sorgt dafür, dass die übrigen Prozeduren bei Bedarf über den unten beschriebenen Auto-Load-Mechanismus geladen werden.

# BEFEHLSPROZEDUREN

Die folgenden Prozeduren werden in der Tcl-Bibliothek bereitgestellt:

**auto_execok** *cmd*
: Ermittelt, ob es eine ausführbare Datei oder ein Shell-Builtin mit dem Namen *cmd* gibt. Falls ja, gibt sie eine Liste von Argumenten zurück, die an **exec** übergeben werden, um die ausführbare Datei oder das Shell-Builtin namens *cmd* auszuführen. Andernfalls gibt sie eine leere Zeichenkette zurück. Dieser Befehl durchsucht bei der Suche nach einer ausführbaren Datei namens *cmd* die Verzeichnisse im aktuellen Suchpfad (angegeben durch die Umgebungsvariable PATH). Auf Windows-Plattformen wird die Suche mit denselben Verzeichnissen und Dateierweiterungen erweitert, die auch **exec** verwendet. **Auto_execok** merkt sich Informationen über frühere Suchen in einem Array namens **auto_execs**; dies vermeidet die Pfadsuche bei künftigen Aufrufen für dasselbe *cmd*. Der Befehl **auto_reset** kann verwendet werden, um **auto_execok** zum Vergessen der zwischengespeicherten Informationen zu zwingen.

Um zum Beispiel das Shell-Builtin *umask* unter Linux auszuführen:

```
exec {*}[auto_execok umask]
```

Um das Shell-Builtin *DIR* unter Windows auszuführen:

```
exec {*}[auto_execok dir]
```

Um festzustellen, ob auf dem PATH des Benutzers eine Binärdatei *frobnicate* liegt:

```
set mayFrob [expr {[llength [auto_execok frobnicate]] > 0}]
```

**auto_import** *pattern*
: **Auto_import** wird während **namespace import** aufgerufen, um zu prüfen, ob die durch *pattern* angegebenen importierten Befehle in einer per Auto-Load geladenen Bibliothek liegen. Falls ja, werden die Befehle geladen, damit sie dem Interpreter zum Erstellen der Import-Links zur Verfügung stehen. Liegen die Befehle nicht in einer per Auto-Load geladenen Bibliothek, tut **auto_import** nichts. Der Mustervergleich erfolgt gemäß den Abgleichregeln von **namespace import**.

Normalerweise ist es nicht nötig, diesen Befehl direkt aufzurufen.

**auto_load** *cmd*
: Dieser Befehl versucht, die Definition für einen Tcl-Befehl namens *cmd* zu laden. Dazu durchsucht er einen *Auto-Load-Pfad*, eine Liste aus einem oder mehreren Verzeichnissen. Der Auto-Load-Pfad wird durch die globale Variable **auto_path** angegeben, falls diese existiert. Gibt es keine Variable **auto_path**, wird die Umgebungsvariable **TCLLIBPATH** verwendet, falls sie existiert. Andernfalls besteht der Auto-Load-Pfad nur aus dem Tcl-Bibliotheksverzeichnis. In jedem Verzeichnis im Auto-Load-Pfad muss eine Datei **tclIndex** vorhanden sein, die einen oder mehrere in diesem Verzeichnis definierte Befehle beschreibt sowie ein Skript zum Auswerten, um jeden der Befehle zu laden. Die Datei **tclIndex** sollte mit dem Befehl **auto_mkindex** erzeugt werden. Wird *cmd* in einer Indexdatei gefunden, wird das entsprechende Skript ausgewertet, um den Befehl zu erstellen. Der Befehl **auto_load** gibt 1 zurück, wenn *cmd* erfolgreich erstellt wurde. Der Befehl gibt 0 zurück, wenn es keinen Indexeintrag für *cmd* gab oder wenn das Skript *cmd* nicht tatsächlich definiert hat (z. B. weil die Indexinformationen veraltet sind). Tritt beim Verarbeiten des Skripts ein Fehler auf, wird dieser Fehler zurückgegeben. **Auto_load** liest die Indexinformationen nur einmal und speichert sie im Array **auto_index**; künftige Aufrufe von **auto_load** prüfen *cmd* im Array, anstatt die Indexdateien erneut zu lesen. Die zwischengespeicherten Indexinformationen können mit dem Befehl **auto_reset** gelöscht werden. Dies zwingt den nächsten **auto_load**-Befehl, die Indexdatenbank von der Festplatte neu zu laden.

Normalerweise ist es nicht nötig, diesen Befehl direkt aufzurufen; der voreingestellte Handler **unknown** tut das.

**auto_mkindex** *dir pattern pattern ...*
: Erzeugt einen Index, der für **auto_load** geeignet ist. Der Befehl durchsucht *dir* nach allen Dateien, deren Namen einem der *pattern*-Argumente entsprechen (der Abgleich erfolgt mit dem Befehl **glob**), erzeugt einen Index aller in allen passenden Dateien definierten Tcl-Befehlsprozeduren und speichert die Indexinformationen in einer Datei namens **tclIndex** in *dir*. Wird kein Muster angegeben, wird ein Muster von ***.tcl** angenommen. Beispielsweise liest der Befehl

    ```
    auto_mkindex foo *.tcl
    ```
    alle **.tcl**-Dateien im Unterverzeichnis **foo** und erzeugt eine neue Indexdatei **foo/tclIndex**.
    **Auto_mkindex** parst die Tcl-Skripte, indem es sie in einen Kind-Interpreter sourcet und die ausgeführten **proc**- und **namespace**-Befehle überwacht. Erweiterungen können das (undokumentierte) Paket auto_mkindex_parser verwenden, um andere Befehle zu registrieren, die zum Auto-Load-Index beitragen können. Wie dies funktioniert, muss man in auto.tcl nachlesen.
    **Auto_mkindex_old** (mit derselben Syntax wie **auto_mkindex**) parst die Tcl-Skripte auf relativ einfache Weise: Enthält eine Zeile das Wort „**proc**“ als erste Zeichen, wird angenommen, dass es sich um eine Prozedurdefinition handelt, und das nächste Wort der Zeile wird als Name der Prozedur genommen. Prozedurdefinitionen, die nicht in dieser Form erscheinen (z. B. mit Leerzeichen vor **proc**), werden nicht indiziert. Enthält Ihr Skript „gefährlichen“ Code, etwa globalen Initialisierungscode oder Prozedurnamen mit Sonderzeichen wie **\$**, **\***, **\[** oder **\]**, ist die Verwendung von **auto_mkindex_old** sicherer.

**auto_reset**
: Löscht alle von **auto_execok** und **auto_load** zwischengespeicherten Informationen. Diese Informationen werden beim nächsten Bedarf von der Festplatte neu gelesen. **Auto_reset** löscht außerdem alle im Auto-Load-Index aufgeführten Prozeduren, sodass beim nächsten Gebrauch frische Kopien geladen werden.

**auto_qualify** *command namespace*
: Berechnet eine Liste vollständig qualifizierter Namen für *command*. Diese Liste spiegelt den Pfad wider, den ein Standard-Tcl-Interpreter bei der Befehlssuche verfolgt: Zuerst sucht er den Befehl im aktuellen Namespace, dann im globalen Namespace. Entsprechend hat die zurückgegebene Liste zwei Elemente, wenn *command* relativ ist und *namespace* nicht **::** ist: *command* im Gültigkeitsbereich von *namespace*, als wäre es ein Befehl im Namespace *namespace*; und *command*, als wäre es ein Befehl im globalen Namespace. Andernfalls, wenn entweder *command* absolut ist (mit **::** beginnt) oder *namespace* **::** ist, enthält die Liste nur *command*, als wäre es ein Befehl im globalen Namespace.
    **Auto_qualify** wird von den Auto-Load-Einrichtungen in Tcl verwendet, sowohl zum Erzeugen von Auto-Load-Indizes wie *pkgIndex.tcl* als auch zum tatsächlichen Auto-Load von Funktionen zur Laufzeit.

**tcl_findLibrary** *basename version patch initScript enVarName varName*
: Dies ist eine Standard-Suchprozedur für Erweiterungen während ihrer Initialisierung. Sie rufen diese Prozedur auf, um ihre Skriptbibliothek in mehreren Standardverzeichnissen zu suchen. Die letzte Komponente des Namens des Bibliotheksverzeichnisses ist normalerweise *basenameversion* (z. B. tk8.0), kann aber in Build-Hierarchien „library“ sein. Das Argument *patch* wird nicht verwendet. Die Datei *initScript* wird in den Interpreter gesourcet, sobald sie gefunden wurde. Das Verzeichnis, in dem diese Datei gefunden wurde, wird in der globalen Variable *varName* gespeichert. Ist diese Variable bereits definiert (z. B. durch C-Code während der Anwendungsinitialisierung), wird nicht gesucht. Andernfalls erfolgt die Suche in diesen Verzeichnissen: dem durch die Umgebungsvariable *enVarName* benannten Verzeichnis; relativ zum Tcl-Bibliotheksverzeichnis; relativ zur ausführbaren Datei im Standard-Installationsverzeichnis bin oder bin/*arch*; relativ zur ausführbaren Datei im aktuellen Build-Baum; relativ zur ausführbaren Datei in einem parallelen Build-Baum.

**parray** *arrayName* ?*pattern*?
: Gibt auf der Standardausgabe die Namen und Werte aller Elemente im Array *arrayName* aus, oder nur die Namen, die auf *pattern* passen (gemäß den Abgleichregeln von **string match**), und deren Werte, falls *pattern* angegeben ist. *ArrayName* muss ein Array sein, das dem Aufrufer von **parray** zugänglich ist. Es kann lokal oder global sein.

Um zum Beispiel den Inhalt des Arrays **tcl_platform** auszugeben:

```
parray tcl_platform
```


## Hilfsprozeduren für Wortgrenzen

Diese Prozeduren werden hauptsächlich intern von Tk verwendet.

**tcl_endOfWord** *str start*
: Gibt den Index der ersten Wortende-Position zurück, die nach einem Startindex *start* in der Zeichenkette *str* auftritt. Eine Wortende-Position ist definiert als das erste Nicht-Wort-Zeichen, das auf das erste Wort-Zeichen nach dem Startpunkt folgt. Gibt -1 zurück, wenn nach dem Startpunkt keine weiteren Wortende-Positionen vorhanden sind. Siehe die Beschreibung von **tcl_wordchars** und **tcl_nonwordchars** unten für weitere Details, wie Tcl bestimmt, welche Zeichen Wort-Zeichen sind.

**tcl_startOfNextWord** *str start*
: Gibt den Index der ersten Wortanfang-Position zurück, die nach einem Startindex *start* in der Zeichenkette *str* auftritt. Eine Wortanfang-Position ist definiert als das erste Wort-Zeichen, das auf ein Nicht-Wort-Zeichen folgt. Gibt -1 zurück, wenn nach dem Startpunkt keine weiteren Wortanfang-Positionen vorhanden sind.

Um zum Beispiel die Indizes der Wortanfänge in einer Zeichenkette nach den Plattformregeln auszugeben:

```
set theString "The quick brown fox"
for {set idx 0} {$idx >= 0} {
        set idx [tcl_startOfNextWord $theString $idx]} {
    puts "Word start index: $idx"
}
```

**tcl_startOfPreviousWord** *str start*
: Gibt den Index der ersten Wortanfang-Position zurück, die vor einem Startindex *start* in der Zeichenkette *str* auftritt. Gibt -1 zurück, wenn vor dem Startpunkt keine weiteren Wortanfang-Positionen vorhanden sind.

**tcl_wordBreakAfter** *str start*
: Gibt den Index der ersten Wortgrenze nach dem Startindex *start* in der Zeichenkette *str* zurück. Gibt -1 zurück, wenn in der angegebenen Zeichenkette nach dem Startpunkt keine weiteren Grenzen vorhanden sind. Der zurückgegebene Index bezieht sich auf das zweite Zeichen des Paares, das eine Grenze bildet.

**tcl_wordBreakBefore** *str start*
: Gibt den Index der ersten Wortgrenze vor dem Startindex *start* in der Zeichenkette *str* zurück. Gibt -1 zurück, wenn in der angegebenen Zeichenkette vor dem Startpunkt keine weiteren Grenzen vorhanden sind. Der zurückgegebene Index bezieht sich auf das zweite Zeichen des Paares, das eine Grenze bildet.


# VARIABLEN

Die folgenden globalen Variablen werden von den Prozeduren in der Tcl-Bibliothek definiert oder verwendet. Sie fallen in zwei große Kategorien: Umgang mit unbekannten Befehlen und Paketen sowie Bestimmung dessen, was Wörter sind.

## Variablen für Auto-Load und Paketverwaltung

**auto_execs**
: Wird von **auto_execok** verwendet, um Informationen darüber zu speichern, ob bestimmte Befehle als ausführbare Dateien existieren.

Anwendercode greift normalerweise nicht sinnvoll direkt darauf zu.

**auto_index**
: Wird von **auto_load** verwendet, um die von der Festplatte gelesenen Indexinformationen zu speichern.

Anwendercode greift normalerweise nicht sinnvoll direkt darauf zu.

**auto_noexec**
: Ist sie auf einen beliebigen Wert gesetzt, versucht **unknown** nicht, Befehle per Auto-Exec auszuführen.

**auto_noload**
: Ist sie auf einen beliebigen Wert gesetzt, versucht **unknown** nicht, Befehle per Auto-Load zu laden.

**auto_path**
: Ist sie gesetzt, muss sie eine gültige Tcl-Liste mit Verzeichnissen enthalten, die während Auto-Load-Operationen durchsucht werden (einschließlich Paketindexdateien bei Verwendung des Standard-**package unknown**-Handlers). Diese Variable wird beim Start initialisiert und enthält der Reihe nach: die in der Umgebungsvariable **TCLLIBPATH** aufgeführten Verzeichnisse, das durch die globale Variable **tcl_library** benannte Verzeichnis, das übergeordnete Verzeichnis von **tcl_library**, die in der Variable **tcl_pkgPath** aufgeführten Verzeichnisse. Zusätzliche Speicherorte für Dateien und Paketindizes sollten normalerweise mit **lappend** zu dieser Variable hinzugefügt werden.

Um zum Beispiel das Verzeichnis *lib* neben dem laufenden Skript hinzuzufügen:

```
lappend auto_path [file dirname [info script]]/lib
```

Nutzt das Skript **cd**, sollten die Einträge auf **auto_path** mit **file normalize** normalisiert werden.

**env(TCL_LIBRARY)**
: Ist sie gesetzt, legt sie den Ort des Verzeichnisses mit Bibliotheksskripten fest (der Wert dieser Variable wird der Variable **tcl_library** zugewiesen und daher vom Befehl **info library** zurückgegeben). Ist diese Variable nicht gesetzt, wird ein Standardwert verwendet.

Von dieser Umgebungsvariable wird außerhalb von Tests abgeraten. Tcl-Installationen sollten bereits wissen, wo ihre eigenen Skriptdateien liegen; der Wert wird beim Bauen oder Installieren festgelegt.

**env(TCLLIBPATH)**
: Ist sie gesetzt, muss sie eine gültige Tcl-Liste mit Verzeichnissen enthalten, die bei Auto-Load-Vorgängen durchsucht werden. Verzeichnisse müssen im Tcl-Format angegeben werden, mit „/“ als Pfadtrenner, unabhängig von der Plattform. Diese Variable wird nur bei der Initialisierung der Variable **auto_path** verwendet.

Eine wesentliche Folge dieser Variable: der Benutzer eines Skripts kann die Orte angeben, von denen das Skript Pakete per **package require** lesen darf. Innerhalb eines Tcl-Skripts lässt sie sich normalerweise nicht sinnvoll setzen, außer um zu beeinflussen, woher andere Interpreter laden (angelegt mit **interp create** oder als eigene Threads oder Unterprozesse gestartet).


## Variablen zur Bestimmung von Wortgrenzen

Diese Variablen werden nur in den Befehlen **tcl_endOfWord**, **tcl_startOfNextWord**, **tcl_startOfPreviousWord**, **tcl_wordBreakAfter** und **tcl_wordBreakBefore** verwendet.

**tcl_nonwordchars**
: Diese Variable enthält einen regulären Ausdruck, der von Routinen wie **tcl_endOfWord** verwendet wird, um zu ermitteln, ob ein Zeichen Teil eines Wortes ist oder nicht. Passt das Muster auf ein Zeichen, gilt das Zeichen als Nicht-Wort-Zeichen. Auf Windows-Plattformen gelten Leerzeichen, Tabulatoren und Zeilenumbrüche als Nicht-Wort-Zeichen. Unter Unix gilt alles außer Ziffern, Buchstaben und Unterstrichen als Nicht-Wort-Zeichen.

**tcl_wordchars**
: Diese Variable enthält einen regulären Ausdruck, der von Routinen wie **tcl_endOfWord** verwendet wird, um zu ermitteln, ob ein Zeichen Teil eines Wortes ist oder nicht. Passt das Muster auf ein Zeichen, gilt das Zeichen als Wort-Zeichen. Auf Windows-Plattformen bestehen Wörter aus jedem Zeichen, das kein Leerzeichen, Tabulator oder Zeilenumbruch ist. Unter Unix bestehen Wörter aus Ziffern, Buchstaben oder Unterstrichen.

