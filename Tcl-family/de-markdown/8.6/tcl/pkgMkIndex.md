---
CommandName: pkg_mkIndex
ManualSection: n
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - package(n)
Keywords:
 - auto-load
 - index
 - package
 - version
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
---

# NAME

pkg_mkIndex - Erstellt einen Index für automatisches Laden von Paketen

# ÜBERSICHT

::: {.synopsis} :::
[pkg_mkIndex]{.cmd} [options]{.optdot} [dir]{.arg} [pattern pattern]{.optdot} 
:::

# BESCHREIBUNG

**Pkg_mkIndex** ist eine Hilfsprozedur der Standard-Tcl-Bibliothek. Sie erstellt Indexdateien, mit denen Pakete automatisch geladen werden, wenn **package require** ausgeführt wird. So verwenden Sie **pkg_mkIndex**:

1. Erstellen Sie die Pakete. Jedes Paket kann aus einer oder mehreren Tcl-Skriptdateien oder Binärdateien bestehen. Binärdateien müssen mit dem Befehl **load** und einem einzigen Argument ladbar sein; ist die Datei beispielsweise **test.so**, muss **load test.so** möglich sein. Jede Skriptdatei muss einen Befehl **package provide** enthalten, der Paket und Versionsnummer deklariert; jede Binärdatei muss einen Aufruf von **Tcl_PkgProvide** enthalten.

2. Erstellen Sie den Index durch Aufruf von **pkg_mkIndex**. Das Argument *dir* gibt ein Verzeichnis an, und jedes Argument *pattern* ist ein **glob**-artiges Muster, das Skript- oder Binärdateien in *dir* auswählt. Standardmuster sind ***.tcl** und **_.[info sharedlibextension]**.
**Pkg_mkIndex** erzeugt in *dir* die Datei **pkgIndex.tcl** mit Paketinformationen zu allen durch die *pattern*-Argumente ausgewählten Dateien. Dazu lädt es jede Datei in einen Kind-Interpreter und prüft, welche Pakete und neuen Befehle erscheinen (daher sind **package provide** bzw. **Tcl_PkgProvide** in den Dateien erforderlich). Ist ein Paket auf Skripte und Binärdateien verteilt oder bestehen Abhängigkeiten zwischen Dateien, müssen Sie ggf. die Option **-load** nutzen oder die Verarbeitungsreihenfolge anpassen. Siehe **KOMPLEXE FÄLLE** unten.

3. Installieren Sie das Paket als Unterverzeichnis eines der Verzeichnisse in der Variable **tcl_pkgPath**. Enthält **$tcl_pkgPath** mehr als ein Verzeichnis, sollten maschinenabhängige Pakete (z. B. mit binären Shared Libraries) normalerweise im ersten Verzeichnis und maschinenunabhängige Pakete (nur Tcl-Skripte) im zweiten installiert werden. Das Unterverzeichnis sollte die Skript- und/oder Binärdateien des Pakets sowie **pkgIndex.tcl** enthalten. Liegt das Paket als Unterverzeichnis eines Verzeichnisses in **$tcl_pkgPath**, wird es bei **package require** automatisch gefunden.
Installieren Sie das Paket anderswo, muss das Paketverzeichnis in der globalen Variable **auto_path** oder in einem unmittelbaren Unterverzeichnis eines Eintrags in **auto_path** liegen. **auto_path** listet Verzeichnisse, die Auto-Loader und Paket-Loader durchsuchen; standardmäßig enthält sie **$tcl_pkgPath**. Der Paket-Loader prüft auch alle Unterverzeichnisse der Einträge in **auto_path**. Sie können ein Verzeichnis in der Anwendung explizit zu **auto_path** hinzufügen oder die Umgebungsvariable **TCLLIBPATH** setzen: ist sie gesetzt, initialisiert Tcl **auto_path** beim Start daraus.

4. Nach diesen Schritten genügt **package require**. Sind die Versionen 2.1, 2.3 und 3.1 von Paket **Test** per **pkg_mkIndex** indexiert, macht **package require Test** Version 3.1 verfügbar und **package require -exact Test 2.1** Version 2.1. In den Indexdateien unter **auto_path** können viele Versionen eines Pakets stehen, aber pro Interpreter wird nur eine geladen — je nach erstem **package require**. Verschiedene Versionen können in verschiedenen Interpretern geladen sein.


# OPTIONEN

Die optionalen Schalter sind:

**-direct**
: Der erzeugte Index lädt das Paket bei **package require** direkt. Das ist die Voreinstellung.

**-lazy**
: Der erzeugte Index verzögert das Laden des Pakets bis zur ersten Verwendung eines vom Paket bereitgestellten Befehls, statt es sofort bei **package require** zu laden. Das ist nicht mit **auto_reset** vereinbar; die Verwendung wird daher nicht empfohlen.

**-load** *pkgPat*
: Beim Indexieren werden alle Pakete, die im aktuellen Interpreter existieren und *pkgPat* entsprechen, in den Kind-Interpreter geladen, der den Index erzeugt. Der Mustervergleich folgt **string match**, ohne Berücksichtigung der Groß-/Kleinschreibung. Siehe **KOMPLEXE FÄLLE** unten.

**-verbose**
: Erzeugt Ausgabe während der Indexierung über die Prozedur **tclLog**, die standardmäßig nach stderr schreibt.

**--**
: Ende der Schalter, falls *dir* mit einem Bindestrich beginnt.


# Pakete und der Auto-Loader

Die Paketverwaltung überschneidet sich etwas mit dem Auto-Loader, da beide Dateien bei Bedarf laden. Die Paketverwaltung ist jedoch eine höhere Ebene und nutzt den Auto-Loader für den letzten Ladeschritt. Pakete sollten eher mit **pkg_mkIndex** als mit **auto_mkindex** indexiert werden, weil die Paketmechanismen Versionskontrolle bieten: mehrere Versionen können in Indexdateien verfügbar sein, und Anwendungen wählen per **package require** die Version. **auto_mkindex** kennt keine Versionen und kann nur eine Version pro Paket verwalten. Ein Paket sollte nicht gleichzeitig mit **pkg_mkIndex** und **auto_mkindex** indexiert werden. Wurde ein Paket mit **pkg_mkIndex** indexiert, sind seine Befehle erst nach **package require** aufrufbar; mit **auto_mkindex** indexierte Pakete sind sofort nutzbar, weil es keine Versionskontrolle gibt.

# Funktionsweise

**Pkg_mkIndex** nutzt **package unknown**, **package ifneeded** und den Auto-Loader. Beim ersten **package require** wird das **package unknown**-Skript ausgeführt, das Tcl beim Start so setzt, dass alle **pkgIndex.tcl** in **auto_path** ausgewertet werden. Diese Dateien enthalten **package ifneeded** für jede Version jedes verfügbaren Pakets; diese rufen **package provide** auf und richten Auto-Loader-Informationen zum Laden der Paketdateien ein. Wurde **pkgIndex.tcl** mit **-lazy** erzeugt, wird eine Datei einer Version eines Pakets erst beim ersten Aufruf eines ihrer Befehle geladen. Nach **package require** sind die Paketbefehle im Interpreter ggf. noch nicht sichtbar, können aber aufgerufen werden und werden dann automatisch geladen.

# Direktes Laden

Manche Pakete — z. B. solche mit Namespaces und exportierten Befehlen oder mit spezieller Initialisierung — sollen ihre Dateien sofort bei **package require** laden, statt das Laden bis zur ersten Befehlsnutzung zu verzögern. Das ist die Voreinstellung beim Erzeugen des Paketindex und kann mit **-lazy** überschrieben werden.

# Komplexe Fälle

Die meisten komplexen Abhängigkeiten zwischen Skripten und Binärdateien sowie aufgeteilte Pakete funktionieren in der Regel. Sie müssen ggf. die Verarbeitungsreihenfolge von **pkg_mkIndex** anpassen. Details folgen.

Enthält jede Skript- oder Datei genau ein Paket und liegt jedes Paket nur in einer Datei, reicht es, alle zu indexierenden Dateien in beliebiger Reihenfolge per Glob-Mustern anzugeben.

Generell dürfen Skripte von anderen Paketen abhängen. Enthalten Skripte **package require**, werden diese im Interpreter zum Verarbeiten der Skripte ausgehängt und verursachen keine Probleme. Rufen Skripte im globalen Code andere Pakete auf, fängt ein Stub-**unknown**-Befehl das ab. Verweisen Skripte im globalen Code auf Variablen anderer Pakete, entstehen Fehler — das ist zudem schlechter Stil.

Haben Binärdateien Abhängigkeiten zu anderen Paketen, wird es schwieriger, weil C-APIs wie **Tcl_PkgRequire** beim Laden einer Binärdatei nicht ausgehängt werden können. Benötigt das BLT-Paket Tk und ruft **Tcl_PkgRequire** in **Blt_Init** auf, muss **pkg_mkIndex** in einem Interpreter mit geladenem Tk laufen. Das erreichen Sie mit **-load** *pkgPat*: **pkg_mkIndex** lädt dann alle von **info loaded** gelisteten Pakete, die *pkgPat* entsprechen, in den Verarbeitungs-Interpreter — in den meisten Fällen genügt das für **Tcl_PkgRequire** in Binärdateien.

Indexieren Sie zwei Binärdateien und hängt eine von der anderen ab, geben Sie die abhängige zuletzt an. So wird die unabhängige zuerst geladen und indexiert, und ihr Paket steht beim Verarbeiten der zweiten Datei bereit. Ggf. müssen Sie das erste Paket mit **-load** in den temporären Interpreter laden; es schadet nicht, Muster für noch nicht geladene Pakete anzugeben.

Ist ein Paket auf Skripte und eine Binärdatei verteilt, vermeiden Sie **-load**. Wird ein Paket vor der Indexberechnung geladen, verdeckt es andere Dateien desselben Pakets. Müssen Sie **-load** verwenden, geben Sie die Skripte zuerst an — sonst kann das aus der Binärdatei geladene Paket das der Skripte verdecken.
