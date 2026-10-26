---
CommandName: practcl
title: practcl
ManualSection: n
Version: 0.16.6
TclPart: tcllib
TclDescription: The The Proper Rational API for C to Tool Command Language Module
Keywords:
 - practcl
Copyright:
 - Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
---

# Name

practcl – Das Practcl-Modul

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [TclOO]{.lit} [1.0]{.lit}
:::

proc **practcl::cat** *fname*

proc **practcl::docstrip** *text*

proc **putb** ?*map*? *text*

proc **Proc** *name* *arglist* *body*

proc **noop** ?*args*?

proc **practcl::debug** ?*args*?

proc **practcl::doexec** ?*args*?

proc **practcl::doexec\_in** *path* ?*args*?

proc **practcl::dotclexec** ?*args*?

proc **practcl::domake** *path* ?*args*?

proc **practcl::domake.tcl** *path* ?*args*?

proc **practcl::fossil** *path* ?*args*?

proc **practcl::fossil\_status** *dir*

proc **practcl::os**

proc **practcl::mkzip** *exename* *barekit* *vfspath*

proc **practcl::sort\_dict** *list*

proc **practcl::local\_os**

proc **practcl::config.tcl** *path*

proc **practcl::read\_configuration** *path*

proc **practcl::tcllib\_require** *pkg* ?*args*?

proc **practcl::platform::tcl\_core\_options** *os*

proc **practcl::platform::tk\_core\_options** *os*

proc **practcl::read\_rc\_file** *filename* ?*localdat* ?

proc **practcl::read\_sh\_subst** *line* *info*

proc **practcl::read\_sh\_file** *filename* ?*localdat* ?

proc **practcl::read\_Config.sh** *filename*

proc **practcl::read\_Makefile** *filename*

proc **practcl::cputs** *varname* ?*args*?

proc **practcl::tcl\_to\_c** *body*

proc **practcl::\_tagblock** *text* ?*style* **tcl**? ?*note* ?

proc **practcl::de\_shell** *data*

proc **practcl::grep** *pattern* ?*files* ?

proc **practcl::file\_lexnormalize** *sp*

proc **practcl::file\_relative** *base* *dst*

proc **practcl::findByPattern** *basedir* *patterns*

proc **practcl::log** *fname* *comment*

proc **practcl::\_pkgindex\_simpleIndex** *path*

proc **practcl::\_pkgindex\_directory** *path*

proc **practcl::\_pkgindex\_path\_subdir** *path*

proc **practcl::pkgindex\_path** ?*args*?

proc **practcl::installDir** *d1* *d2*

proc **practcl::copyDir** *d1* *d2* ?*toplevel* **1**?

proc **practcl::buildModule** *modpath*

proc **practcl::installModule** *modpath* *DEST*

proc **practcl::trigger** ?*args*?

proc **practcl::depends** ?*args*?

proc **practcl::target** *name* *info* ?*action* ?

method **constructor**

method **argspec** *argspec*

method **comment** *block*

method **keyword.Annotation** *resultvar* *commentblock* *type* *name* *body*

method **keyword.Class** *resultvar* *commentblock* *name* *body*

method **keyword.class** *resultvar* *commentblock* *name* *body*

method **keyword.Class\_Method** *resultvar* *commentblock* *name* ?*args*?

method **keyword.method** *resultvar* *commentblock* *name* ?*args*?

method **keyword.proc** *commentblock* *name* *argspec*

method **reset**

method **Main**

method **section.method** *keyword* *method* *minfo*

method **section.annotation** *type* *name* *iinfo*

method **section.class** *class\_name* *class\_info*

method **section.command** *procinfo*

method **manpage** ?**header** *value*? ?**footer** *value*? ?**authors** *list*?

method **scan\_text** *text*

method **scan\_file** *filename*

method **\_MorphPatterns**

method **define** *submethod* ?*args*?

method **graft** ?*args*?

method **initialize**

method **link** *command* ?*args*?

method **morph** *classname*

method **script** *script*

method **select**

method **source** *filename*

classmethod **select** *object*

method **config.sh**

method **BuildDir** *PWD*

method **MakeDir** *srcdir*

method **read\_configuration**

method **build-cflags** *PROJECT* *DEFS* *namevar* *versionvar* *defsvar*

method **critcl** ?*args*?

method **Autoconf**

method **BuildDir** *PWD*

method **ConfigureOpts**

method **MakeDir** *srcdir*

method **make {} autodetect**

method **make {} clean**

method **make {} compile**

method **make {} install** *DEST*

method **build-compile-sources** *PROJECT* *COMPILE* *CPPCOMPILE* *INCLUDES*

method **build-Makefile** *path* *PROJECT*

method **build-library** *outfile* *PROJECT*

method **build-tclsh** *outfile* *PROJECT* ?*path* **auto**?

method **BuildDir** *PWD*

method **make {} autodetect**

method **make {} clean**

method **make {} compile**

method **make {} install** *DEST*

method **MakeDir** *srcdir*

method **NmakeOpts**

method **constructor** *module\_object* *name* *info* ?*action\_body* ?

method **do**

method **check**

method **output**

method **reset**

method **triggers**

method **constructor** *parent* ?*args*?

method **child** *method*

method **go**

method **cstructure** *name* *definition* ?*argdat* ?

method **include** *header*

method **include\_dir** ?*args*?

method **include\_directory** ?*args*?

method **c\_header** *body*

method **c\_code** *body*

method **c\_function** *header* *body* ?*info* ?

method **c\_tcloomethod** *name* *body* ?*arginfo* ?

method **cmethod** *name* *body* ?*arginfo* ?

method **c\_tclproc\_nspace** *nspace*

method **c\_tclcmd** *name* *body* ?*arginfo* ?

method **c\_tclproc\_raw** *name* *body* ?*arginfo* ?

method **tcltype** *name* *argdat*

method **project-compile-products**

method **implement** *path*

method **initialize**

method **linktype**

method **generate-cfile-constant**

method **generate-cfile-header**

method **generate-cfile-tclapi**

method **generate-loader-module**

method **Collate\_Source** *CWD*

method **select**

classmethod **select** *object*

method **code** *section* *body*

method **Collate\_Source** *CWD*

method **project-compile-products**

method **generate-debug** ?*spaces* ?

method **generate-cfile-constant**

method **generate-cfile-public-structure**

method **generate-cfile-header**

method **generate-cfile-global**

method **generate-cfile-private-typedef**

method **generate-cfile-private-structure**

method **generate-cfile-functions**

method **generate-cfile-tclapi**

method **generate-hfile-public-define**

method **generate-hfile-public-macro**

method **generate-hfile-public-typedef**

method **generate-hfile-public-structure**

method **generate-hfile-public-headers**

method **generate-hfile-public-function**

method **generate-hfile-public-includes**

method **generate-hfile-public-verbatim**

method **generate-loader-external**

method **generate-loader-module**

method **generate-stub-function**

method **IncludeAdd** *headervar* ?*args*?

method **generate-tcl-loader**

method **generate-tcl-pre**

method **generate-tcl-post**

method **linktype**

method **Ofile** *filename*

method **project-static-packages**

method **toolset-include-directory**

method **target** *method* ?*args*?

method **project-compile-products**

method **generate-loader-module**

method **project-compile-products**

method **linker-products** *configdict*

method **initialize**

variable **make\_object**

method **\_MorphPatterns**

method **add** ?*args*?

method **install-headers** ?*args*?

method **make {} \_preamble**

method **make {} pkginfo**

method **make {} objects**

method **make {} object** *name*

method **make {} reset**

method **make {} trigger** ?*args*?

method **make {} depends** ?*args*?

method **make {} filename** *name*

method **make {} target** *name* *Info* *body*

method **make {} todo**

method **make {} do**

method **child** *which*

method **generate-c**

method **generate-h**

method **generate-loader**

method **initialize**

method **implement** *path*

method **linktype**

method **\_MorphPatterns**

method **constructor** ?*args*?

method **add\_object** *object*

method **add\_project** *pkg* *info* ?*oodefine* ?

method **add\_tool** *pkg* *info* ?*oodefine* ?

method **build-tclcore**

method **child** *which*

method **linktype**

method **project** *pkg* ?*args*?

method **tclcore**

method **tkcore**

method **tool** *pkg* ?*args*?

method **clean** *PATH*

method **project-compile-products**

method **go**

method **generate-decls** *pkgname* *path*

method **implement** *path*

method **generate-make** *path*

method **linktype**

method **package-ifneeded** ?*args*?

method **shared\_library** ?*filename* ?

method **static\_library** ?*filename* ?

method **build-tclkit\_main** *PROJECT* *PKG\_OBJS*

method **Collate\_Source** *CWD*

method **wrap** *PWD* *exename* *vfspath* ?*args*?

classmethod **Sandbox** *object*

classmethod **select** *object*

classmethod **claim\_option**

classmethod **claim\_object** *object*

classmethod **claim\_path** *path*

method **scm\_info**

method **DistroMixIn**

method **Sandbox**

method **SrcDir**

method **ScmTag**

method **ScmClone**

method **ScmUnpack**

method **ScmUpdate**

method **Unpack**

classmethod **claim\_object** *object*

classmethod **claim\_option**

classmethod **claim\_path** *path*

method **ScmUnpack**

classmethod **claim\_object** *obj*

classmethod **claim\_option**

classmethod **claim\_path** *path*

method **scm\_info**

method **ScmClone**

method **ScmTag**

method **ScmUnpack**

method **ScmUpdate**

classmethod **claim\_object** *obj*

classmethod **claim\_option**

classmethod **claim\_path** *path*

method **ScmTag**

method **ScmUnpack**

method **ScmUpdate**

method **\_MorphPatterns**

method **BuildDir** *PWD*

method **child** *which*

method **compile**

method **go**

method **install** ?*args*?

method **linktype**

method **linker-products** *configdict*

method **linker-external** *configdict*

method **linker-extra** *configdict*

method **env-bootstrap**

method **env-exec**

method **env-install**

method **env-load**

method **env-present**

method **sources**

method **update**

method **unpack**

method **env-bootstrap**

method **env-present**

method **linktype**

method **env-bootstrap**

method **env-install**

method **env-present**

method **install** *DEST*

method **kettle** *path* ?*args*?

method **install** *DEST*

method **install** *DEST*

method **env-bootstrap**

method **env-install**

method **env-present**

method **install** *DEST*

method **install-module** *DEST* ?*args*?

method **env-bootstrap**

method **env-install**

method **install** *DEST*

method **install-module** *DEST* ?*args*?

method **clean**

method **env-install**

method **project-compile-products**

method **ComputeInstall**

method **go**

method **linker-products** *configdict*

method **project-static-packages**

method **BuildDir** *PWD*

method **compile**

method **Configure**

method **install** *DEST*

method **install** *DEST*

method **install** *DEST*

method **env-bootstrap**

method **env-present**

method **env-install**

method **go**

method **linktype**

# Beschreibung

Das Modul „Practcl“ ist ein Werkzeug zur Integration umfangreicher Module für C-API-Tcl-Code, der benutzerdefinierte Tcl-Typen und TclOO-Objekte erfordert.

Das Konzept von Practcl besteht darin, dass es sich um ein Paket aus einer einzigen Datei handelt, das jedes Tcl-basierte Projekt bei der Verteilung, Kompilierung, Verknüpfung, VFS-Vorbereitung, Erstellung der ausführbaren Datei und Installation unterstützen kann. Practcl ermöglicht es zudem, das Build-System eines Projekts von einem anderen Projekt aus aufzurufen, wodurch komplexe Projekte wie beispielsweise ein statisch verknüpftes Basekit relativ einfach erstellt werden können.

Practcl wird als einzelne Datei ausgeliefert und weist, abgesehen von einem Tcl 8.6-Interpreter, keine externen Abhängigkeiten auf.

Ein praxisorientiertes Projekt erstellen

# Befehle

proc **practcl::cat** *fname*
: Eine Datei zusammenfügen

proc **practcl::docstrip** *text*
: Entfernt die globalen Kommentare aus dem Tcl-Code. Dies dient dazu, zu verhindern, dass die Kommentare zur Dokumentation Dateien überladen, die für die Verbreitung in einem maschinenlesbaren Format vorgesehen sind.

proc **putb** ?*map*? *text*
: Fügt einer Variable eine Textzeile hinzu. Wendet optional eine Zeichenfolgenzuordnung an.

proc **Proc** *name* *arglist* *body*
: Erstellt eine Prozedur, falls noch kein Befehl mit diesem Namen vorhanden ist

proc **noop** ?*args*?
: Ein Befehl, der nichts bewirkt. Eine praktische Möglichkeit, eine Anweisung zu negieren, ohne sie vollständig auskommentieren zu müssen. Außerdem ist er ein praktischer Anknüpfungspunkt für ein Objekt, das später benannt werden soll.

proc **practcl::debug** ?*args*?
: siehe unten ...

proc **practcl::doexec** ?*args*?
: Fügt eine statische Kopie von Tcl ein

proc **practcl::doexec\_in** *path* ?*args*?
: siehe unten ...

proc **practcl::dotclexec** ?*args*?
: siehe unten ...

proc **practcl::domake** *path* ?*args*?
: siehe unten ...

proc **practcl::domake.tcl** *path* ?*args*?
: siehe unten ...

proc **practcl::fossil** *path* ?*args*?
: siehe unten ...

proc **practcl::fossil\_status** *dir*
: siehe unten ...

proc **practcl::os**
: siehe unten ...

proc **practcl::mkzip** *exename* *barekit* *vfspath*
: Erstellt eine ZIP-Datei. Unter Tcl 8.6 wird dabei die native ZIP-Implementierung aufgerufen; bei älteren Interpretern wird ZIP über „exec“ aufgerufen.

proc **practcl::sort\_dict** *list*
: Sortieren einer Schlüssel-Wert-Liste nach Dictionary-Reihenfolge. Dies ist erforderlich, da Tcl-Versionen vor 8.6 nicht über *lsort -stride 2*

proc **practcl::local\_os**
: Gibt ein Dictionary zurück, das das lokale Betriebssystem beschreibt. Zu den zurückgegebenen Feldern gehören:

    - download – Dateisystempfad, in den Fossil-Repositorys und Quellcode-Tarballs für den aktuellen Benutzer heruntergeladen werden

    - EXEEXT – Die Erweiterung, die ausführbaren Dateien zuweisen soll. (z. B. .exe unter Windows)

    - fossil\_mirror – Eine URI für einen Webserver im lokalen Netzwerk, der als Spiegel eines Fossil-Repositorys fungiert

    - local\_install – Pfad zum Dateisystem, in dem Pakete für die lokale Nutzung durch den aktuellen Benutzer installiert werden

    - Präfix – Das Präfix, das dem Tcl-Kern/TEA bei der Installation in „local\_install“ in „./configure“ angegeben wurde

    - Sandbox – Der Speicherort, an dem dieses Projekt externe Projekte entpackt

    - TEACUP\_PROFILE – Der kanonische Name von ActiveState/Teacup für diese Plattform (d. h. win32-ix86 macosx10.5-i386-x86\_84)

    - TEACUP\_OS – Das lokale Betriebssystem (Windows, macOS, OpenBSD usw.). Liefert dieselbe Antwort wie „tcl.m4“, mit der Ausnahme, dass „macOS“ anstelle von „Darwin“ angegeben wird.

    - TEA\_PLATFORM – Die von „uname“ zurückgegebene Plattform: -s-uname, -r (unter Unix) oder „windows“ unter Windows

    - TEACUP\_ARCH – Die Prozessorarchitektur für das lokale Betriebssystem (d. h. ix86, x86\_64)

    - TEACUP\_ARCH – Die Prozessorarchitektur für das lokale Betriebssystem (d. h. ix86, x86\_64)

    - teapot – Dateisystempfad, in den die Dateien des teapot-Pakets für den aktuellen Benutzer heruntergeladen werden

    - userhome – Pfad zum Speichern lokalisierter Einstellungen, von Cache-Dateien aus Downloads usw. für den aktuellen Benutzer


    Dieser Befehl nutzt eine Kombination aus lokalen Prüfungen mit „Exec“, allen vorhandenen „tclConfig.sh“-Dateien, bereits berechneten autoconf-Daten sowie Daten, die aus einer Datei namens „practcl.rc“ im Benutzerverzeichnis stammen. Der Speicherort des Benutzerverzeichnisses variiert je nach Plattform und Betriebssystem:

    - Windows: ::env(LOCALAPPDATA)/Tcl

    - MacOS: ~/Library/Application Support/Tcl

    - Sonstiges: ~/tcl


proc **practcl::config.tcl** *path*
: Ein transparenter Aufruf von ::practcl::read\_configuration zur Wahrung der Abwärtskompatibilität mit älteren Versionen von Practcl

proc **practcl::read\_configuration** *path*
: Lokale Plattform ermitteln. Dieser Befehl sucht in dem angegebenen Pfad nach Daten, die von „autoconf“ oder „autosetup“ erfasst wurden, oder führt eigene Logiktests durch, falls keines der beiden Programme ausgeführt wurde. Das Vorhandensein einer Datei namens „config.site“ an diesem Speicherort weist darauf hin, dass es sich bei diesem Projekt um eine Cross-Kompilierung handelt, und die in dieser Datei gespeicherten Daten werden für den Compiler und den Linker verwendet.

    Dieser Befehl sucht in der folgenden Reihenfolge nach Informationen aus den folgenden Dateien:

    - config.tcl – Eine Datei, die von autoconf/configure in neueren Versionen von TEA generiert wird und durch Kodierung als Tcl-Skript dargestellt ist.

    - config.site – Eine Datei, die Informationen zum Cross-Compiler enthält und durch Kodierung als SH-Skript dargestellt wird

    - ::env(VisualStudioVersion) – Unter Windows ein Wert der Umgebungsvariablen, der angibt, dass MS Visual Studio installiert ist


    Dieser Befehl gibt ein Dictionary zurück, das alle aus den oben genannten Quellen bereinigten Daten enthält. Sofern keine weiteren Angaben gemacht werden, liefert dieser Befehl dieselbe Ausgabe wie ::practcl::local\_os. In diesem Modus stellt dieser Befehl, wenn die Umgebungsvariable „VisualStudioVersion“ vorhanden ist, eine Vorlage mit Feldern bereit, die für die Kompilierung unter Windows mit Microsoft Visual Studio geeignet sind. Das USEMSVC-Flag im Dictionary ist ein boolesches Flag, das angibt, ob dies tatsächlich der Fall ist.

proc **practcl::tcllib\_require** *pkg* ?*args*?
: Versucht, ein Paket zu laden, und ruft bei einem Fehlschlag „tcllib“ ab.

proc **practcl::platform::tcl\_core\_options** *os*
: Gibt die Zeichenkette zurück, die an ./configure übergeben werden soll, um den Tcl-Kern für das angegebene Betriebssystem zu kompilieren.

    - Windows: --with-tzdata --with-encoding utf-8

    - macosx: --enable-corefoundation=yes  --enable-framework=no --with-tzdata --with-encoding utf-8

    - Sonstiges: --with-tzdata --with-encoding utf-8


proc **practcl::platform::tk\_core\_options** *os*
: siehe unten ...

proc **practcl::read\_rc\_file** *filename* ?*localdat* ?
: Liest eine in einer Datei gespeicherte, stilisierte Schlüssel-Wert-Liste ein

proc **practcl::read\_sh\_subst** *line* *info*
: Wandelt eine XXX.sh-Datei in eine Reihe von Tcl-Variablen um

proc **practcl::read\_sh\_file** *filename* ?*localdat* ?
: siehe unten ...

proc **practcl::read\_Config.sh** *filename*
: Eine vereinfachte Version von „read\_sh\_file“, die speziell auf das Abrufen von Daten aus der Datei „(tcl|tk)Config.sh“ zugeschnitten ist

proc **practcl::read\_Makefile** *filename*
: Eine vereinfachte Version von „read\_sh\_file“, die speziell auf das Abrufen von Daten aus einer Makefile-Datei zugeschnitten ist

proc **practcl::cputs** *varname* ?*args*?
: Argumente an einen Puffer anhängen. Der Befehl funktioniert ähnlich wie „puts“, da bei jedem Aufruf zusätzlich ein Zeilenvorschub eingefügt wird. Im Gegensatz zu „puts“ werden jedoch Leerzeichen im Zwischentext unterdrückt.

proc **practcl::tcl\_to\_c** *body*
: siehe unten ...

proc **practcl::\_tagblock** *text* ?*style* **tcl**? ?*note* ?
: siehe unten ...

proc **practcl::de\_shell** *data*
: siehe unten ...

proc **practcl::grep** *pattern* ?*files* ?
: Sucht nach dem Muster *pattern* in $files

proc **practcl::file\_lexnormalize** *sp*
: siehe unten ...

proc **practcl::file\_relative** *base* *dst*
: Berechnet einen relativen Pfad zwischen „base“ und „dst“.

    Beispiele:

    ```
      ::practcl::file_relative ~/build/tcl/unix ~/build/tcl/library
      > ../library
    ```

proc **practcl::findByPattern** *basedir* *patterns*
: siehe unten ...

proc **practcl::log** *fname* *comment*
: Ein Ereignis im Praxisprotokoll eintragen

proc **practcl::\_pkgindex\_simpleIndex** *path*
: siehe unten ...

proc **practcl::\_pkgindex\_directory** *path*
: Gibt „true“ zurück, wenn die pkgindex-Datei eine andere Anweisung als „package ifneeded“ enthält und/oder wenn ein „package ifneeded“ eine DLL lädt

proc **practcl::\_pkgindex\_path\_subdir** *path*
: Hilfsfunktion für ::practcl::pkgindex\_path

proc **practcl::pkgindex\_path** ?*args*?
: Alle angegebenen Pfade so indizieren, als würden sie im selben virtuellen Dateisystem enden

proc **practcl::installDir** *d1* *d2*
: Löscht den Inhalt von *d2* und kopiert anschließend den Inhalt von *d1* rekursiv in *d2*.

proc **practcl::copyDir** *d1* *d2* ?*toplevel* **1**?
: Kopiert den Inhalt von *d1* rekursiv nach *d2*

proc **practcl::buildModule** *modpath*
: siehe unten ...

proc **practcl::installModule** *modpath* *DEST*
: Installiert ein Modul aus MODPATH in das angegebene Verzeichnis. Es wird davon ausgegangen, dass *dpath* der vollständig qualifizierte Pfad ist, in dem das Modul platziert werden soll. Alle bereits vorhandenen Dateien unter diesem Pfad werden gelöscht. Wenn es sich bei dem Pfad um einen symbolischen Link handelt, gibt der Prozess ohne Fehlermeldung und ohne weitere Aktion zurück. Enthält das Modul im Verzeichnis build/ Inhalte, die neuer sind als die .tcl-Dateien im Quellverzeichnis des Moduls, und existiert eine Datei build/build.tcl, wird diese Datei ausgeführt. Wenn das Quellverzeichnis eine Datei mit dem Namen „index.tcl“ enthält, wird davon ausgegangen, dass es sich um ein Modul im TAO-Stil handelt, und das gesamte Verzeichnis (sowie alle Unterverzeichnisse) wird unverändert kopiert. Wenn keine Datei „index.tcl“ vorhanden ist, werden alle .tcl-Dateien aus dem Modul-Quellverzeichnis kopiert, und es wird eine Datei „pkgIndex.tcl“ generiert, sofern diese noch nicht existiert. Existiert im Quellverzeichnis ein Verzeichnis namens „htdocs“, wird dieses Verzeichnis unverändert in das Zielverzeichnis kopiert.

proc **practcl::trigger** ?*args*?
: Build-Ziele auslösen und Abhängigkeiten neu berechnen

    Interne Abläufe:

    ```
      ::practcl::LOCAL make trigger {*}$args
      foreach {name obj} [::practcl::LOCAL make objects] {
        set ::make($name) [$obj do]
      }
    ```

proc **practcl::depends** ?*args*?
: Berechnet, ob eine Abhängigkeit für eines der Argumente erfüllt oder neu erstellt werden muss.

    Interne Abläufe:

    ```
      ::practcl::LOCAL make depends {*}$args
    ```

proc **practcl::target** *name* *info* ?*action* ?
: Ein Build-Produkt deklarieren. Diese Prozedur ist lediglich eine Kurzform für *::practcl::LOCAL make task $name $info $action*

    Durch die Registrierung eines Build-Produkts mit diesem Befehl wird ein Eintrag im globalen Array erstellt und ein Wert in das globale Array eingetragen.

    Interne Details:

    ```
      set obj [::practcl::LOCAL make task $name $info $action]
      set ::make($name) 0
      set filename [$obj define get filename]
      if {$filename ne {}} {
        set ::target($name) $filename
      }
    ```


# Klassen

## Klasse practcl::doctool

```
{ set authors {
   {John Doe} {jdoe@illustrious.edu}
   {Tom RichardHarry} {tomdickharry@illustrius.edu}
 }
 # Create the object
 ::practcl::doctool create AutoDoc
 set fout [open [file join $moddir module.tcl] w]
 foreach file [glob [file join $srcdir *.tcl]] {
   set content [::practcl::cat [file join $srcdir $file]]
    # Scan the file
    AutoDoc scan_text $content
    # Strip the comments from the distribution
    puts $fout [::practcl::docstrip $content]
 }
 # Write out the manual page
 set manout [open [file join $moddir module.man] w]
 dict set args header [string map $modmap [::practcl::cat [file join $srcdir manual.txt]]]
 dict set args footer [string map $modmap [::practcl::cat [file join $srcdir footer.txt]]]
 dict set args authors $authors
 puts $manout [AutoDoc manpage {*}$args]
 close $manout


}
```

Tool für Build-Skripte zur dynamischen Generierung von Dokumentationsdateien aus Kommentaren in Quellcode-Dateien

**Methoden**

method **constructor**
: siehe unten ...

method **argspec** *argspec*
: Verarbeitet eine Argumentliste zu einem Informationswörterbuch. Diese Methode versteht auch nicht-positionale Argumente, die in der Notation von Tipp 471 <https://core.tcl-lang.org/tips/doc/trunk/tip/479.md> ausgedrückt werden.

    Die Ausgabe ist ein Dictionary, das alle Felder enthält und angibt, ob es sich bei den Feldern um **positional**, **mandatory**, and whether they have a **default** aufweisen.

    Beispiele:

    ```
       my argspec {a b {c 10}}

       > a {positional 1 mandatory 1} b {positional 1 mandatory 1} c {positional 1 mandatory 0 default 10}
    ```

method **comment** *block*
: Wandelt einen Kommentarblock in ein InformationsDictionary um. Wenn Zeilen im Kommentar mit einem einzelnen Wort beginnen, das mit einem Doppelpunkt endet, werden alle nachfolgenden Zeilen an ein Dictionary-Feld mit diesem Namen angehängt. Wenn keine Felder angegeben sind, wird der gesamte Text an das Feld **description** angehängt.

    Beispiel:

    ```
     my comment {Does something cool}
     > description {Does something cool}

     my comment {
     title : Something really cool
     author : Sean Woods
     author : John Doe
     description :
     This does something really cool!
     }
     > description {This does something really cool!}
       title {Something really cool}
       author {Sean Woods
       John Doe}
    ```

method **keyword.Annotation** *resultvar* *commentblock* *type* *name* *body*
: siehe unten ...

method **keyword.Class** *resultvar* *commentblock* *name* *body*
: Verarbeitet einen oo::objdefine-Aufruf, der das Objekt der Klasse selbst ändert

method **keyword.class** *resultvar* *commentblock* *name* *body*
: Verarbeitet die Anweisungen oo::define, clay::define usw.

method **keyword.Class\_Method** *resultvar* *commentblock* *name* ?*args*?
: Eine Anweisung für eine Methode der Klasse im Clay-Stil verarbeiten

method **keyword.method** *resultvar* *commentblock* *name* ?*args*?
: Den Prozess für eine Anweisung für eine Objektmethode im TCLOO-Stil durchführen

method **keyword.proc** *commentblock* *name* *argspec*
: Eine PROC-Anweisung ausführen

method **reset**
: Den Zustand des Objekts und seiner eingebetteten Coroutine zurücksetzen

method **Main**
: Hauptteil der eingebetteten Coroutine für das Objekt

method **section.method** *keyword* *method* *minfo*
: Den Text der Handbuchseite für eine Methode oder Prozedur generieren

method **section.annotation** *type* *name* *iinfo*
: siehe unten ...

method **section.class** *class\_name* *class\_info*
: Den Text der Handbuchseite für eine Klasse generieren

method **section.command** *procinfo*
: Erstellt den Text für die Handbuchseite im Abschnitt „Befehle“

method **manpage** ?**header** *value*? ?**footer** *value*? ?**authors** *list*?
: Erstellt die Handbuchseite. Gibt den fertigen Text zurück, der zum Speichern in einer .man-Datei geeignet ist. Das Argument „header“ ist ein Block aus Doctools-Text, der vor dem maschinell generierten Abschnitt eingefügt werden soll. „footer“ ist ein Block aus Doctools-Text, der nach dem maschinell generierten Abschnitt eingefügt werden soll. „authors“ ist eine Liste einzelner Autoren und E-Mail-Adressen im Format AUTOR E-MAIL ?AUTOR E-MAIL?...

method **scan\_text** *text*
: Einen Textblock scannen

method **scan\_file** *filename*
: Eine Textdatei einscannen


## Klasse practcl::metaclass

Die Metaklasse für alle „practcl“-Objekte

**Methoden**

- Methode **\_MorphPatterns**
- Methode **define** *submethod* ?*args*?
- Methode **graft** ?*args*?
- Methode **initialize**
- Methode **link** *command* ?*args*?
- Methode **morph** *classname*
- Methode **script** *script*
- Methode **select**
- Methode **source** *filename*


## Klasse practcl::toolset

Eine Klasse ohne übergeordnete Klasse, die als Mixin konzipiert ist und eine Reihe von Verhaltensweisen im Zusammenhang mit dem Build definiert, die angepasst werden, je nachdem, ob gcc oder msvc als Zielkompilierer ausgewählt wird.

**Klassenmethoden**

classmethod **select** *object*
: Führt die Auswahl für das Toolset-Mixin


**Methods** durch

method **config.sh**
: Sucht eine Schlüssel-Wert-Liste, die dieses Projekt beschreibt, oder erstellt eine solche.

method **BuildDir** *PWD*
: Ermittelt den Standort, an dem das Produkt hergestellt werden soll

method **MakeDir** *srcdir*
: Gibt den Pfad zurück, an dem sich das Makefile relativ zu *srcdir* befindet. Bei dieser Implementierung ist MakeDir immer srcdir.

method **read\_configuration**
: Liest die Informationen zum Erstellungs-Prozess für dieses Paket. Bei dieser Implementierung werden Daten an den folgenden Speicherorten in der folgenden Reihenfolge gesucht: config.tcl (von practcl generiert), PKGConfig.sh und das Makefile.

    Wenn das Makefile herangezogen werden muss, aber nicht vorhanden ist, wird die Methode „Configure“ aufgerufen.

method **build-cflags** *PROJECT* *DEFS* *namevar* *versionvar* *defsvar*
: Methode DEFS Diese Methode füllt vier Variablen: name – Der Name des Pakets version – Die Version des Pakets defs – An den Compiler übergebene C-Flags includedir – Eine Liste von Pfaden, die dem Compiler zum Auffinden von Header-Dateien übergeben werden sollen

method **critcl** ?*args*?
: Aufruf von „critcl“ in einem externen Prozess


## Klasse practcl::toolset.gcc

*ancestors*: **practcl::toolset**

**Methoden**

method **Autoconf**
: siehe unten ...

method **BuildDir** *PWD*
: siehe unten ...

method **ConfigureOpts**
: siehe unten ...

method **MakeDir** *srcdir*
: Ermittelt, in welchem Verzeichnis sich die Makefile-Vorlage befindet

method **make {} autodetect**
: siehe unten ...

method **make {} clean**
: siehe unten ...

method **make {} compile**
: siehe unten ...

method **make {} install** *DEST*
: siehe unten ...

method **build-compile-sources** *PROJECT* *COMPILE* *CPPCOMPILE* *INCLUDES*
: siehe unten ...

method **build-Makefile** *path* *PROJECT*
: siehe unten ...

method **build-library** *outfile* *PROJECT*
: Erstellt eine statische oder dynamische Bibliothek

method **build-tclsh** *outfile* *PROJECT* ?*path* **auto**?
: Erstellt eine statische ausführbare Datei


## Klasse practcl::toolset.msvc

*ancestors*: **practcl::toolset**

**Methoden**

method **BuildDir** *PWD*
: MSVC führt die Kompilierung stets im Quellverzeichnis durch

method **make {} autodetect**
: Nichts tun

method **make {} clean**
: siehe unten ...

method **make {} compile**
: siehe unten ...

method **make {} install** *DEST*
: siehe unten ...

method **MakeDir** *srcdir*
: Ermittelt, in welchem Verzeichnis sich die Makefile-Vorlage befindet


- Methode **NmakeOpts**


## Klasse practcl::make_obj

*ancestors*: **practcl::metaclass**

Ein Objekt, das im Rahmen des Build-Prozesses bereitgestellt wird. In der Regel handelt es sich dabei um eine Objektdatei, eine Header-Datei oder ein TCL-Skript, das auf irgendeine Weise kompiliert oder generiert werden muss.

**Methoden**

- Methode **constructor** *module\_object* *name* *info* ?*action\_body* ?
- Methode **do**
- Methode **check**
- Methode **output**
- Methode **reset**
- Methode **triggers**


## Klasse practcl::object

*ancestors*: **practcl::metaclass**

Ein generisches „Practcl“-Objekt

**Methoden**

- Methode **constructor** *parent* ?*args*?
- Methode **child** *method*
- Methode **go**


## Klasse practcl::dynamic

Dynamische Blöcke erzeugen keine eigenen .c-Dateien, sondern tragen zur Zusammenführung der Datei der Hauptbibliothek bei.

**Methoden**

method **cstructure** *name* *definition* ?*argdat* ?
: Parser-Funktionen

method **include** *header*
: siehe unten ...

method **include\_dir** ?*args*?
: siehe unten ...

method **include\_directory** ?*args*?
: siehe unten ...

method **c\_header** *body*
: siehe unten ...

method **c\_code** *body*
: siehe unten ...

method **c\_function** *header* *body* ?*info* ?
: siehe unten ...

method **c\_tcloomethod** *name* *body* ?*arginfo* ?
: siehe unten ...

method **cmethod** *name* *body* ?*arginfo* ?
: Alias für den klassischen Namen

method **c\_tclproc\_nspace** *nspace*
: siehe unten ...

method **c\_tclcmd** *name* *body* ?*arginfo* ?
: siehe unten ...

method **c\_tclproc\_raw** *name* *body* ?*arginfo* ?
: Alias für den klassischen Namen

method **tcltype** *name* *argdat*
: siehe unten ...

method **project-compile-products**
: Wechselwirkungen zwischen Modulen

method **implement** *path*
: siehe unten ...

method **initialize**
: Praktische Grundlagen

method **linktype**
: siehe unten ...

method **generate-cfile-constant**
: siehe unten ...

method **generate-cfile-header**
: siehe unten ...

method **generate-cfile-tclapi**
: Erstellt Code, der Tcl-API-Aufrufe implementiert

method **generate-loader-module**
: Erstellt Code, der ausgeführt wird, wenn das Paket/Modul im Interpreter initialisiert wird

method **Collate\_Source** *CWD*
: siehe unten ...

method **select**
: Sobald sich ein Objekt als eine Form von „dynamisch“ kennzeichnet, sollten Sie nicht länger versuchen, es in etwas anderes umzuwandeln.


## Klasse practcl::product

Ein Ergebnis für das Build-System

**Klassenmethoden**

- classmethod **select** *object*


**Methoden**

method **code** *section* *body*
: siehe unten ...

method **Collate\_Source** *CWD*
: siehe unten ...

method **project-compile-products**
: siehe unten ...

method **generate-debug** ?*spaces* ?
: siehe unten ...

method **generate-cfile-constant**
: siehe unten ...

method **generate-cfile-public-structure**
: Konstante statische Datenstrukturen mit Werten füllen

method **generate-cfile-header**
: siehe unten ...

method **generate-cfile-global**
: siehe unten ...

method **generate-cfile-private-typedef**
: siehe unten ...

method **generate-cfile-private-structure**
: siehe unten ...

method **generate-cfile-functions**
: Erstellt Code, der Unterprogramme bereitstellt, die von Tcl-API-Methoden aufgerufen werden

method **generate-cfile-tclapi**
: Erstellt Code, der Tcl-API-Aufrufe implementiert

method **generate-hfile-public-define**
: siehe unten ...

method **generate-hfile-public-macro**
: siehe unten ...

method **generate-hfile-public-typedef**
: siehe unten ...

method **generate-hfile-public-structure**
: siehe unten ...

method **generate-hfile-public-headers**
: siehe unten ...

method **generate-hfile-public-function**
: siehe unten ...

method **generate-hfile-public-includes**
: siehe unten ...

method **generate-hfile-public-verbatim**
: siehe unten ...

method **generate-loader-external**
: siehe unten ...

method **generate-loader-module**
: siehe unten ...

method **generate-stub-function**
: siehe unten ...

method **IncludeAdd** *headervar* ?*args*?
: siehe unten ...

method **generate-tcl-loader**
: siehe unten ...

method **generate-tcl-pre**
: Diese Methode generiert eine beliebige Tcl-Skriptdatei, die zur Vorinitialisierung der C-Bibliothek erforderlich ist.

method **generate-tcl-post**
: siehe unten ...

method **linktype**
: siehe unten ...

method **Ofile** *filename*
: siehe unten ...

method **project-static-packages**
: Vom Hauptprojekt aufgerufene Methoden

method **toolset-include-directory**
: Vom Toolset aufgerufene Methoden


- Methode **target** *method* ?*args*?


## Klasse practcl::product.cheader

*ancestors*: **practcl::product**

Ein Produkt, das aus einer C-Header-Datei generiert wurde. Das heißt: gar nichts.

**Methoden**

- Methode **project-compile-products**
- Methode **generate-loader-module**


## Klasse practcl::product.csource

*ancestors*: **practcl::product**

Ein Produkt, das aus einer C-Quelldatei generiert wurde. In der Regel handelt es sich dabei um eine Objektdatei (.o).

**Methoden**

- Methode **project-compile-products**


## Klasse practcl::product.clibrary

*ancestors*: **practcl::product**

Ein Produkt, das aus einer kompilierten C-Bibliothek generiert wird. In der Regel handelt es sich dabei um eine .a- oder eine .dylib-Datei; in komplexen Fällen kann es sich jedoch lediglich um ein Mittel handeln, mit dem ein Projekt den Quellcode eines anderen Projekts integriert.

**Methoden**

- Methode **linker-products** *configdict*


## Klasse practcl::product.dynamic

*ancestors*: **practcl::dynamic** **practcl::product**

Ein Produkt, das aus C-Code generiert wird, der wiederum von „practcl“ oder auf andere Weise erzeugt wurde. Diese C-Datei erzeugt möglicherweise eine eigene .o-Datei, möglicherweise aber auch nicht – je nachdem, ob sie für die Einbindung in eine Zusammenführung in Frage kommt.

**Methoden**

- Methode **initialize**


## Klasse practcl::product.critcl

*ancestors*: **practcl::dynamic** **practcl::product**

Ein von critcl erstelltes Binärprodukt. Hinweis: Die Implementierung wurde noch nicht geschrieben; diese Klasse führt keine Funktionen aus.

## Klasse practcl::module

*ancestors*: **practcl::object** **practcl::product.dynamic**

Letztendlich muss der gesamte C-Code in ein Modul geladen werden. Dabei handelt es sich entweder um eine dynamisch geladene Bibliothek, die eine Tcl-Erweiterung implementiert, oder um einen fest kompilierten Abschnitt einer benutzerdefinierten Shell bzw. Anwendung.

**Variable**

- Variable **make\_object**


**Methoden**

method **\_MorphPatterns**
: siehe unten ...

method **add** ?*args*?
: siehe unten ...

method **install-headers** ?*args*?
: siehe unten ...

method **make {} \_preamble**
: siehe unten ...

method **make {} pkginfo**
: siehe unten ...

method **make {} objects**
: Gibt ein Dictionary mit allen Handles und den zugehörigen Objekten zurück

method **make {} object** *name*
: Gibt das Objekt zurück, das mit dem Handle *name* verknüpft ist.

method **make {} reset**
: Alle untergeordneten Objekte zurücksetzen

method **make {} trigger** ?*args*?
: Wendet die „triggers“-Methode auf alle aufgeführten Handles an

method **make {} depends** ?*args*?
: Führt die Prüfmethode für alle aufgeführten Handles durch

method **make {} filename** *name*
: Gibt den Namen des Build-Produkts für das angegebene Handle zurück

method **make {} target** *name* *Info* *body*
: siehe unten ...

method **make {} todo**
: Gibt eine Liste von Handles für Objekte zurück, die bei der Methode „do“ den Wert „true“ zurückgeben

method **make {} do**
: Für jede Zielübung wird die in der *action*-Definition angegebene Aktion ausgeführt, wenn die *do*-Methode den Wert „true“ gibt.

method **child** *which*
: siehe unten ...

method **generate-c**
: Diese Methode generiert den Inhalt einer zusammengeführten .c-Datei, die den Loader für eine Reihe von Tools implementiert

method **generate-h**
: Diese Methode generiert den Inhalt einer zusammengeführten .h-Datei, die die öffentliche API dieses Moduls beschreibt


- Methode **generate-loader**
- Methode **initialize**
- Methode **implement** *path*
- Methode **linktype**


## Klasse practcl::project

*ancestors*: **practcl::module**

Ein Toplevel-Projekt, das eine Sammlung anderer Projekte darstellt

**Methoden**

method **\_MorphPatterns**
: siehe unten ...

method **constructor** ?*args*?
: siehe unten ...

method **add\_object** *object*
: siehe unten ...

method **add\_project** *pkg* *info* ?*oodefine* ?
: siehe unten ...

method **add\_tool** *pkg* *info* ?*oodefine* ?
: siehe unten ...

method **build-tclcore**
: Kompiliert den Tcl-Kern. Wenn die Definition *tk* wahr ist, wird auch der Tk-Kern kompiliert.

method **child** *which*
: siehe unten ...

method **linktype**
: siehe unten ...

method **project** *pkg* ?*args*?
: Die Methoden eines Unterobjekts aufrufen


- Methode **tclcore**
- Methode **tkcore**
- Methode **tool** *pkg* ?*args*?


## Klasse practcl::library

*ancestors*: **practcl::project**

Ein Toplevel-Projekt, das eine Bibliothek erstellt

**Methoden**

method **clean** *PATH*
: siehe unten ...

method **project-compile-products**
: siehe unten ...

method **go**
: siehe unten ...

method **generate-decls** *pkgname* *path*
: siehe unten ...

method **implement** *path*
: siehe unten ...

method **generate-make** *path*
: Abwärtskompatibler Aufruf

method **linktype**
: siehe unten ...

method **package-ifneeded** ?*args*?
: Erstellt ein „Paket ifneeded“. Die Argumente sind eine Liste von Aliasen, auf die dieses Paket reagieren soll.


- Methode **shared\_library** ?*filename* ?
- Methode **static\_library** ?*filename* ?


## Klasse practcl::tclkit

*ancestors*: **practcl::library**

Ein Toplevel-Projekt, das eine eigenständige ausführbare Datei erzeugt

**Methoden**

method **build-tclkit\_main** *PROJECT* *PKG\_OBJS*
: siehe unten ...

method **Collate\_Source** *CWD*
: siehe unten ...

method **wrap** *PWD* *exename* *vfspath* ?*args*?
: Eine ausführbare Datei verpacken


## Klasse practcl::distribution

Eigenständige Klasse zur Verwaltung der Code-Verteilung. Diese Klasse ist dafür vorgesehen, in eine andere Klasse eingebunden zu werden (daher das Fehlen von Oberklassen).

**Klassenmethoden**

- classmethod **Sandbox** *object*
- classmethod **select** *object*
- Klassenmethode **claim\_option**
- classmethod **claim\_object** *object*
- classmethod **claim\_path** *path*


**Methoden**

- Methode **scm\_info**
- Methode **DistroMixIn**
- Methode **Sandbox**
- Methode **SrcDir**
- Methode **ScmTag**
- Methode **ScmClone**
- Methode **ScmUnpack**
- Methode **ScmUpdate**
- Methode **Unpack**


## Klasse practcl::distribution.snapshot

*ancestors*: **practcl::distribution**

Eine Dateiverteilung aus einem ZIP-Archiv, einem Tarball oder einem anderen, nicht auf SCM basierenden Archivformat

**Klassenmethoden**

- classmethod **claim\_object** *object*
- Klassenmethode **claim\_option**
- classmethod **claim\_path** *path*


**Methoden**

- Methode **ScmUnpack**


## Klasse practcl::distribution.fossil

*ancestors*: **practcl::distribution**

Eine auf Fossil basierende Dateiverteilung

**Klassenmethoden**

classmethod **claim\_object** *obj*
: Überprüft die Metadaten auf Markierungen

classmethod **claim\_option**
: siehe unten ...

classmethod **claim\_path** *path*
: Überprüft, ob im Quellstamm Markierungen vorhanden sind


**Methoden**

method **scm\_info**
: siehe unten ...

method **ScmClone**
: Den Quellcode klonen


- Methode **ScmTag**
- Methode **ScmUnpack**
- Methode **ScmUpdate**


## Klasse practcl::distribution.git

*ancestors*: **practcl::distribution**

Eine auf Git basierende Dateiverteilung

**Klassenmethoden**

- classmethod **claim\_object** *obj*
- Klassenmethode **claim\_option**
- classmethod **claim\_path** *path*


**Methoden**

- Methode **ScmTag**
- Methode **ScmUnpack**
- Methode **ScmUpdate**


## Klasse practcl::subproject

*ancestors*: **practcl::module**

Ein Teilprojekt

**Methoden**

method **\_MorphPatterns**
: siehe unten ...

method **BuildDir** *PWD*
: siehe unten ...

method **child** *which*
: siehe unten ...

method **compile**
: siehe unten ...

method **go**
: siehe unten ...

method **install** ?*args*?
: Projekt in das lokale Build-System integrieren

method **linktype**
: siehe unten ...

method **linker-products** *configdict*
: siehe unten ...

method **linker-external** *configdict*
: siehe unten ...

method **linker-extra** *configdict*
: siehe unten ...

method **env-bootstrap**
: Methoden für Pakete/Tools, die heruntergeladen, gegebenenfalls kompiliert und intern von diesem Practcl-Prozess verwendet werden können. Laden Sie die Funktion in den Interpreter.

method **env-exec**
: Gibt einen Dateipfad zurück, den „exec“ aufrufen kann

method **env-install**
: Installiert das Tool in der lokalen Umgebung

method **env-load**
: Tun Sie alles Notwendige, um das Tool in die lokale Umgebung zu integrieren

method **env-present**
: Prüft, ob das Werkzeug zum Laden verfügbar ist bzw. bereits geladen wurde


- Methode **sources**
- Methode **update**
- Methode **unpack**


## Klasse practcl::subproject.source

*ancestors*: **practcl::subproject** **practcl::library**

Ein Projekt, bei dem das Kit den Quellcode selbst kompiliert und integriert

**Methoden**

- Methode **env-bootstrap**
- Methode **env-present**
- Methode **linktype**


## Klasse practcl::subproject.teapot

*ancestors*: **practcl::subproject**

ein Schluck aus der Teekanne

**Methoden**

- Methode **env-bootstrap**
- Methode **env-install**
- Methode **env-present**
- Methode **install** *DEST*


## Klasse practcl::subproject.kettle

*ancestors*: **practcl::subproject**

**Methoden**

- Methode **kettle** *path* ?*args*?
- Methode **install** *DEST*


## Klasse practcl::subproject.critcl

*ancestors*: **practcl::subproject**

**Methoden**

- Methode **install** *DEST*


## Klasse practcl::subproject.sak

*ancestors*: **practcl::subproject**

**Methoden**

- Methode **env-bootstrap**
- Methode **env-install**
- Methode **env-present**
- Methode **install** *DEST*
- Methode **install-module** *DEST* ?*args*?


## Klasse practcl::subproject.practcl

*ancestors*: **practcl::subproject**

**Methoden**

- Methode **env-bootstrap**
- Methode **env-install**
- Methode **install** *DEST*
- Methode **install-module** *DEST* ?*args*?


## Klasse practcl::subproject.binary

*ancestors*: **practcl::subproject**

Ein untergeordnetes Paket

**Methoden**

- Methode **clean**
- Methode **env-install**
- Methode **project-compile-products**
- Methode **ComputeInstall**
- Methode **go**
- Methode **linker-products** *configdict*
- Methode **project-static-packages**
- Methode **BuildDir** *PWD*
- Methode **compile**
- Methode **Configure**
- Methode **install** *DEST*


## Klasse practcl::subproject.tea

*ancestors*: **practcl::subproject.binary**

Ein untergeordnetes TEA-basiertes Paket

## Klasse practcl::subproject.library

*ancestors*: **practcl::subproject.binary** **practcl::library**

Eine von diesem Projekt erstellte untergeordnete C-Bibliothek

**Methoden**

- Methode **install** *DEST*


## Klasse practcl::subproject.external

*ancestors*: **practcl::subproject.binary**

Eine untergeordnete externe C-Bibliothek

**Methoden**

- Methode **install** *DEST*


## Klasse practcl::subproject.core

*ancestors*: **practcl::subproject.binary**

**Methoden**

- Methode **env-bootstrap**
- Methode **env-present**
- Methode **env-install**
- Methode **go**
- Methode **linktype**


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *practcl* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

TclOO

# Copyright

```
Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
```
