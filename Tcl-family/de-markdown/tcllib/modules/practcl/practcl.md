---
CommandName: practcl
ManualSection: n
Version: 0.16.6
TclPart: tcllib
TclDescription: The The Proper Rational API for C to Tool Command Language Module
Keywords:
 - practcl
Copyright:
 - Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
---

# NAME

practcl – Das Practcl-Modul

# ÜBERSICHT

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

proc **practcl::doexec_in** *path* ?*args*?

proc **practcl::dotclexec** ?*args*?

proc **practcl::domake** *path* ?*args*?

proc **practcl::domake.tcl** *path* ?*args*?

proc **practcl::fossil** *path* ?*args*?

proc **practcl::fossil_status** *dir*

proc **practcl::os**

proc **practcl::mkzip** *exename* *barekit* *vfspath*

proc **practcl::sort_dict** *list*

proc **practcl::local_os**

proc **practcl::config.tcl** *path*

proc **practcl::read_configuration** *path*

proc **practcl::tcllib_require** *pkg* ?*args*?

proc **practcl::platform::tcl_core_options** *os*

proc **practcl::platform::tk_core_options** *os*

proc **practcl::read_rc_file** *filename* ?*localdat* ?

proc **practcl::read_sh_subst** *line* *info*

proc **practcl::read_sh_file** *filename* ?*localdat* ?

proc **practcl::read_Config.sh** *filename*

proc **practcl::read_Makefile** *filename*

proc **practcl::cputs** *varname* ?*args*?

proc **practcl::tcl_to_c** *body*

proc **practcl::\_tagblock** *text* ?*style* **tcl**? ?*note* ?

proc **practcl::de_shell** *data*

proc **practcl::grep** *pattern* ?*files* ?

proc **practcl::file_lexnormalize** *sp*

proc **practcl::file_relative** *base* *dst*

proc **practcl::findByPattern** *basedir* *patterns*

proc **practcl::log** *fname* *comment*

proc **practcl::\_pkgindex_simpleIndex** *path*

proc **practcl::\_pkgindex_directory** *path*

proc **practcl::\_pkgindex_path_subdir** *path*

proc **practcl::pkgindex_path** ?*args*?

proc **practcl::installDir** *d1* *d2*

proc **practcl::copyDir** *d1* *d2* ?*toplevel* **1**?

proc **practcl::buildModule** *modpath*

proc **practcl::installModule** *modpath* *DEST*

proc **practcl::trigger** ?*args*?

proc **practcl::depends** ?*args*?

proc **practcl::target** *name* *info* ?*action* ?

Methode **constructor**

Methode **argspec** *argspec*

Methode **comment** *block*

Methode **keyword.Annotation** *resultvar* *commentblock* *type* *name* *body*

Methode **keyword.Class** *resultvar* *commentblock* *name* *body*

Methode **keyword.class** *resultvar* *commentblock* *name* *body*

Methode **keyword.Class_Method** *resultvar* *commentblock* *name* ?*args*?

Methode **keyword.method** *resultvar* *commentblock* *name* ?*args*?

Methode **keyword.proc** *commentblock* *name* *argspec*

Methode **reset**

Methode **Main**

Methode **section.method** *keyword* *method* *minfo*

Methode **section.annotation** *type* *name* *iinfo*

Methode **section.class** *class_name* *class_info*

Methode **section.command** *procinfo*

Methode **manpage** ?**header** *value*? ?**footer** *value*? ?**authors** *list*?

Methode **scan_text** *text*

Methode **scan_file** *filename*

Methode **\_MorphPatterns**

Methode **define** *submethod* ?*args*?

Methode **graft** ?*args*?

Methode **initialize**

Methode **link** *command* ?*args*?

Methode **morph** *classname*

Methode **script** *script*

Methode **select**

Methode **source** *filename*

classmethod **select** *object*

Methode **config.sh**

Methode **BuildDir** *PWD*

Methode **MakeDir** *srcdir*

Methode **read_configuration**

Methode **build-cflags** *PROJECT* *DEFS* *namevar* *versionvar* *defsvar*

Methode **critcl** ?*args*?

Methode **Autoconf**

Methode **BuildDir** *PWD*

Methode **ConfigureOpts**

Methode **MakeDir** *srcdir*

Methode **make {} autodetect**

Methode **make {} clean**

Methode **make {} compile**

Methode **make {} install** *DEST*

Methode **build-compile-sources** *PROJECT* *COMPILE* *CPPCOMPILE* *INCLUDES*

Methode **build-Makefile** *path* *PROJECT*

Methode **build-library** *outfile* *PROJECT*

Methode **build-tclsh** *outfile* *PROJECT* ?*path* **auto**?

Methode **BuildDir** *PWD*

Methode **make {} autodetect**

Methode **make {} clean**

Methode **make {} compile**

Methode **make {} install** *DEST*

Methode **MakeDir** *srcdir*

Methode **NmakeOpts**

Methode **constructor** *module_object* *name* *info* ?*action_body* ?

Methode **do**

Methode **check**

Methode **output**

Methode **reset**

Methode **triggers**

Methode **constructor** *parent* ?*args*?

Methode **child** *method*

Methode **go**

Methode **cstructure** *name* *definition* ?*argdat* ?

Methode **include** *header*

Methode **include_dir** ?*args*?

Methode **include_directory** ?*args*?

Methode **c_header** *body*

Methode **c_code** *body*

Methode **c_function** *header* *body* ?*info* ?

Methode **c_tcloomethod** *name* *body* ?*arginfo* ?

Methode **cmethod** *name* *body* ?*arginfo* ?

Methode **c_tclproc_nspace** *nspace*

Methode **c_tclcmd** *name* *body* ?*arginfo* ?

Methode **c_tclproc_raw** *name* *body* ?*arginfo* ?

Methode **tcltype** *name* *argdat*

Methode **project-compile-products**

Methode **implement** *path*

Methode **initialize**

Methode **linktype**

Methode **generate-cfile-constant**

Methode **generate-cfile-header**

Methode **generate-cfile-tclapi**

Methode **generate-loader-module**

Methode **Collate_Source** *CWD*

Methode **select**

classmethod **select** *object*

Methode **code** *section* *body*

Methode **Collate_Source** *CWD*

Methode **project-compile-products**

Methode **generate-debug** ?*spaces* ?

Methode **generate-cfile-constant**

Methode **generate-cfile-public-structure**

Methode **generate-cfile-header**

Methode **generate-cfile-global**

Methode **generate-cfile-private-typedef**

Methode **generate-cfile-private-structure**

Methode **generate-cfile-functions**

Methode **generate-cfile-tclapi**

Methode **generate-hfile-public-define**

Methode **generate-hfile-public-macro**

Methode **generate-hfile-public-typedef**

Methode **generate-hfile-public-structure**

Methode **generate-hfile-public-headers**

Methode **generate-hfile-public-function**

Methode **generate-hfile-public-includes**

Methode **generate-hfile-public-verbatim**

Methode **generate-loader-external**

Methode **generate-loader-module**

Methode **generate-stub-function**

Methode **IncludeAdd** *headervar* ?*args*?

Methode **generate-tcl-loader**

Methode **generate-tcl-pre**

Methode **generate-tcl-post**

Methode **linktype**

Methode **Ofile** *filename*

Methode **project-static-packages**

Methode **toolset-include-directory**

Methode **target** *method* ?*args*?

Methode **project-compile-products**

Methode **generate-loader-module**

Methode **project-compile-products**

Methode **linker-products** *configdict*

Methode **initialize**

Variable **make_object**

Methode **\_MorphPatterns**

Methode **add** ?*args*?

Methode **install-headers** ?*args*?

Methode **make {} \_preamble**

Methode **make {} pkginfo**

Methode **make {} objects**

Methode **make {} object** *name*

Methode **make {} reset**

Methode **make {} trigger** ?*args*?

Methode **make {} depends** ?*args*?

Methode **make {} filename** *name*

Methode **make {} target** *name* *Info* *body*

Methode **make {} todo**

Methode **make {} do**

Methode **child** *which*

Methode **generate-c**

Methode **generate-h**

Methode **generate-loader**

Methode **initialize**

Methode **implement** *path*

Methode **linktype**

Methode **\_MorphPatterns**

Methode **constructor** ?*args*?

Methode **add_object** *object*

Methode **add_project** *pkg* *info* ?*oodefine* ?

Methode **add_tool** *pkg* *info* ?*oodefine* ?

Methode **build-tclcore**

Methode **child** *which*

Methode **linktype**

Methode **project** *pkg* ?*args*?

Methode **tclcore**

Methode **tkcore**

Methode **tool** *pkg* ?*args*?

Methode **clean** *PATH*

Methode **project-compile-products**

Methode **go**

Methode **generate-decls** *pkgname* *path*

Methode **implement** *path*

Methode **generate-make** *path*

Methode **linktype**

Methode **package-ifneeded** ?*args*?

Methode **shared_library** ?*filename* ?

Methode **static_library** ?*filename* ?

Methode **build-tclkit_main** *PROJECT* *PKG_OBJS*

Methode **Collate_Source** *CWD*

Methode **wrap** *PWD* *exename* *vfspath* ?*args*?

Klassenmethode **Sandbox** *object*

classmethod **select** *object*

Klassenmethode **claim_option**

Klassenmethode **claim_object** *object*

classmethod **claim_path** *path*

Methode **scm_info**

Methode **DistroMixIn**

Methode **Sandbox**

Methode **SrcDir**

Methode **ScmTag**

Methode **ScmClone**

Methode **ScmUnpack**

Methode **ScmUpdate**

Methode **Unpack**

classmethod **claim_object** *object*

Klassenmethode **claim_option**

classmethod **claim_path** *path*

Methode **ScmUnpack**

classmethod **claim_object** *obj*

Klassenmethode **claim_option**

classmethod **claim_path** *path*

Methode **scm_info**

Methode **ScmClone**

Methode **ScmTag**

Methode **ScmUnpack**

Methode **ScmUpdate**

classmethod **claim_object** *obj*

Klassenmethode **claim_option**

classmethod **claim_path** *path*

Methode **ScmTag**

Methode **ScmUnpack**

Methode **ScmUpdate**

Methode **\_MorphPatterns**

Methode **BuildDir** *PWD*

Methode **child** *which*

Methode **compile**

Methode **go**

Methode **install** ?*args*?

Methode **linktype**

Methode **linker-products** *configdict*

Methode **linker-external** *configdict*

Methode **linker-extra** *configdict*

Methode **env-bootstrap**

Methode **env-exec**

Methode **env-install**

Methode **env-load**

Methode **env-present**

Methode **sources**

Methode **update**

Methode **unpack**

Methode **env-bootstrap**

Methode **env-present**

Methode **linktype**

Methode **env-bootstrap**

Methode **env-install**

Methode **env-present**

Methode **install** *DEST*

Methode **kettle** *path* ?*args*?

Methode **install** *DEST*

Methode **install** *DEST*

Methode **env-bootstrap**

Methode **env-install**

Methode **env-present**

Methode **install** *DEST*

Methode **install-module** *DEST* ?*args*?

Methode **env-bootstrap**

Methode **env-install**

Methode **install** *DEST*

Methode **install-module** *DEST* ?*args*?

Methode **clean**

Methode **env-install**

Methode **project-compile-products**

Methode **ComputeInstall**

Methode **go**

Methode **linker-products** *configdict*

Methode **project-static-packages**

Methode **BuildDir** *PWD*

Methode **compile**

Methode **Configure**

Methode **install** *DEST*

Methode **install** *DEST*

Methode **install** *DEST*

Methode **env-bootstrap**

Methode **env-present**

Methode **env-install**

Methode **go**

Methode **linktype**

# BESCHREIBUNG

Das Modul „Practcl“ ist ein Werkzeug zur Integration umfangreicher Module für C-API-Tcl-Code, der benutzerdefinierte Tcl-Typen und TclOO-Objekte erfordert.

Das Konzept von Practcl besteht darin, dass es sich um ein Paket aus einer einzigen Datei handelt, das jedes Tcl-basierte Projekt bei der Verteilung, Kompilierung, Verknüpfung, VFS-Vorbereitung, Erstellung der ausführbaren Datei und Installation unterstützen kann. Practcl ermöglicht es zudem, das Build-System eines Projekts von einem anderen Projekt aus aufzurufen, wodurch komplexe Projekte wie beispielsweise ein statisch verknüpftes Basekit relativ einfach erstellt werden können.

Practcl wird als einzelne Datei ausgeliefert und weist, abgesehen von einem Tcl 8.6-Interpreter, keine externen Abhängigkeiten auf.

Ein praxisorientiertes Projekt erstellen

# BEFEHLE

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
: ...siehe nächstes...

proc **practcl::doexec** ?*args*?
: Fügt eine statische Kopie von Tcl ein

proc **practcl::doexec_in** *path* ?*args*?
: ...siehe nächstes...

proc **practcl::dotclexec** ?*args*?
: ...siehe nächstes...

proc **practcl::domake** *path* ?*args*?
: ...siehe nächstes...

proc **practcl::domake.tcl** *path* ?*args*?
: ...siehe nächstes...

proc **practcl::fossil** *path* ?*args*?
: ...siehe nächstes...

proc **practcl::fossil_status** *dir*
: ...siehe nächstes...

proc **practcl::os**
: ...siehe nächstes...

proc **practcl::mkzip** *exename* *barekit* *vfspath*
: Erstellt eine ZIP-Datei. Unter Tcl 8.6 wird dabei die native ZIP-Implementierung aufgerufen; bei älteren Interpretern wird ZIP über „exec“ aufgerufen.

proc **practcl::sort_dict** *list*
: Sortieren einer Schlüssel-Wert-Liste nach Dictionary-Reihenfolge. Dies ist erforderlich, da Tcl-Versionen vor 8.6 nicht über *lsort -stride 2*

proc **practcl::local_os**
: Gibt ein Dictionary zurück, das das lokale Betriebssystem beschreibt. Zu den zurückgegebenen Feldern gehören:


**•**
: download – Dateisystempfad, in den Fossil-Repositorys und Quellcode-Tarballs für den aktuellen Benutzer heruntergeladen werden

**•**
: EXEEXT – Die Erweiterung, die ausführbaren Dateien zuweisen soll. (z. B. .exe unter Windows)

**•**
: fossil_mirror – Eine URI für einen Webserver im lokalen Netzwerk, der als Spiegel eines Fossil-Repositorys fungiert

**•**
: local_install – Pfad zum Dateisystem, in dem Pakete für die lokale Nutzung durch den aktuellen Benutzer installiert werden

**•**
: Präfix – Das Präfix, das dem Tcl-Kern/TEA bei der Installation in „local_install“ in „./configure“ angegeben wurde

**•**
: Sandbox – Der Speicherort, an dem dieses Projekt externe Projekte entpackt

**•**
: TEACUP_PROFILE – Der kanonische Name von ActiveState/Teacup für diese Plattform (d. h. win32-ix86 macosx10.5-i386-x86_84)

**•**
: TEACUP_OS – Das lokale Betriebssystem (Windows, macOS, OpenBSD usw.). Liefert dieselbe Antwort wie „tcl.m4“, mit der Ausnahme, dass „macOS“ anstelle von „Darwin“ angegeben wird.

**•**
: TEA_PLATFORM – Die von „uname“ zurückgegebene Plattform: -s-uname, -r (unter Unix) oder „windows“ unter Windows

**•**
: TEACUP_ARCH – Die Prozessorarchitektur für das lokale Betriebssystem (d. h. ix86, x86_64)

**•**
: TEACUP_ARCH – Die Prozessorarchitektur für das lokale Betriebssystem (d. h. ix86, x86_64)

**•**
: teapot – Dateisystempfad, in den die Dateien des teapot-Pakets für den aktuellen Benutzer heruntergeladen werden

**•**
: userhome – Pfad zum Speichern lokalisierter Einstellungen, von Cache-Dateien aus Downloads usw. für den aktuellen Benutzer


: Dieser Befehl nutzt eine Kombination aus lokalen Prüfungen mit „Exec“, allen vorhandenen „tclConfig.sh“-Dateien, bereits berechneten autoconf-Daten sowie Daten, die aus einer Datei namens „practcl.rc“ im Benutzerverzeichnis stammen. Der Speicherort des Benutzerverzeichnisses variiert je nach Plattform und Betriebssystem:


**•**
: Windows: ::env(LOCALAPPDATA)/Tcl

**•**
: MacOS: ~/Library/Application Support/Tcl

**•**
: Sonstiges: ~/tcl


proc **practcl::config.tcl** *path*
: Ein transparenter Aufruf von ::practcl::read_configuration zur Wahrung der Abwärtskompatibilität mit älteren Versionen von Practcl

proc **practcl::read_configuration** *path*
: Lokale Plattform ermitteln. Dieser Befehl sucht in dem angegebenen Pfad nach Daten, die von „autoconf“ oder „autosetup“ erfasst wurden, oder führt eigene Logiktests durch, falls keines der beiden Programme ausgeführt wurde. Das Vorhandensein einer Datei namens „config.site“ an diesem Speicherort weist darauf hin, dass es sich bei diesem Projekt um eine Cross-Kompilierung handelt, und die in dieser Datei gespeicherten Daten werden für den Compiler und den Linker verwendet. Dieser Befehl sucht in der folgenden Reihenfolge nach Informationen aus den folgenden Dateien:


**•**
: config.tcl – Eine Datei, die von autoconf/configure in neueren Versionen von TEA generiert wird und durch Kodierung als Tcl-Skript dargestellt ist.

**•**
: config.site – Eine Datei, die Informationen zum Cross-Compiler enthält und durch Kodierung als SH-Skript dargestellt wird

**•**
: ::env(VisualStudioVersion) – Unter Windows ein Wert der Umgebungsvariablen, der angibt, dass MS Visual Studio installiert ist


Dieser Befehl gibt ein Dictionary zurück, das alle aus den oben genannten Quellen bereinigten Daten enthält. Sofern keine weiteren Angaben gemacht werden, liefert dieser Befehl dieselbe Ausgabe wie ::practcl::local_os. In diesem Modus stellt dieser Befehl, wenn die Umgebungsvariable „VisualStudioVersion“ vorhanden ist, eine Vorlage mit Feldern bereit, die für die Kompilierung unter Windows mit Microsoft Visual Studio geeignet sind. Das USEMSVC-Flag im Dictionary ist ein boolesches Flag, das angibt, ob dies tatsächlich der Fall ist.

proc **practcl::tcllib_require** *pkg* ?*args*?
: Versucht, ein Paket zu laden, und ruft bei einem Fehlschlag „tcllib“ ab.

proc **practcl::platform::tcl_core_options** *os*
: Gibt die Zeichenkette zurück, die an ./configure übergeben werden soll, um den Tcl-Kern für das angegebene Betriebssystem zu kompilieren.


**•**
: Windows: --with-tzdata --with-encoding utf-8

**•**
: macosx: --enable-corefoundation=yes  --enable-framework=no --with-tzdata --with-encoding utf-8

**•**
: Sonstiges: --with-tzdata --with-encoding utf-8


proc **practcl::platform::tk_core_options** *os*
: ...siehe nächstes...

proc **practcl::read_rc_file** *filename* ?*localdat* ?
: Liest eine in einer Datei gespeicherte, stilisierte Schlüssel-Wert-Liste ein

proc **practcl::read_sh_subst** *line* *info*
: Wandelt eine XXX.sh-Datei in eine Reihe von Tcl-Variablen um

proc **practcl::read_sh_file** *filename* ?*localdat* ?
: ...siehe nächstes...

proc **practcl::read_Config.sh** *filename*
: Eine vereinfachte Version von „read_sh_file“, die speziell auf das Abrufen von Daten aus der Datei „(tcl|tk)Config.sh“ zugeschnitten ist

proc **practcl::read_Makefile** *filename*
: Eine vereinfachte Version von „read_sh_file“, die speziell auf das Abrufen von Daten aus einer Makefile-Datei zugeschnitten ist

proc **practcl::cputs** *varname* ?*args*?
: Argumente an einen Puffer anhängen. Der Befehl funktioniert ähnlich wie „puts“, da bei jedem Aufruf zusätzlich ein Zeilenvorschub eingefügt wird. Im Gegensatz zu „puts“ werden jedoch Leerzeichen im Zwischentext unterdrückt.

proc **practcl::tcl_to_c** *body*
: ...siehe nächstes...

proc **practcl::\_tagblock** *text* ?*style* **tcl**? ?*note* ?
: ...siehe nächstes...

proc **practcl::de_shell** *data*
: ...siehe nächstes...

proc **practcl::grep** *pattern* ?*files* ?
: Sucht nach dem Muster *pattern* in \$files

proc **practcl::file_lexnormalize** *sp*
: ...siehe nächstes...

proc **practcl::file_relative** *base* *dst*
: Berechnet einen relativen Pfad zwischen „base“ und „dst“. Beispiele:


```
  ::practcl::file_relative ~/build/tcl/unix ~/build/tcl/library
  > ../library
```

proc **practcl::findByPattern** *basedir* *patterns*
: ...siehe nächstes...

proc **practcl::log** *fname* *comment*
: Ein Ereignis im Praxisprotokoll eintragen

proc **practcl::\_pkgindex_simpleIndex** *path*
: ...siehe nächstes...

proc **practcl::\_pkgindex_directory** *path*
: Gibt „true“ zurück, wenn die pkgindex-Datei eine andere Anweisung als „package ifneeded“ enthält und/oder wenn ein „package ifneeded“ eine DLL lädt

proc **practcl::\_pkgindex_path_subdir** *path*
: Hilfsfunktion für ::practcl::pkgindex_path

proc **practcl::pkgindex_path** ?*args*?
: Alle angegebenen Pfade so indizieren, als würden sie im selben virtuellen Dateisystem enden

proc **practcl::installDir** *d1* *d2*
: Löscht den Inhalt von *d2* und kopiert anschließend den Inhalt von *d1* rekursiv in *d2*.

proc **practcl::copyDir** *d1* *d2* ?*toplevel* **1**?
: Kopiert den Inhalt von *d1* rekursiv nach *d2*

proc **practcl::buildModule** *modpath*
: ...siehe nächstes...

proc **practcl::installModule** *modpath* *DEST*
: Installiert ein Modul aus MODPATH in das angegebene Verzeichnis. Es wird davon ausgegangen, dass *dpath* der vollständig qualifizierte Pfad ist, in dem das Modul platziert werden soll. Alle bereits vorhandenen Dateien unter diesem Pfad werden gelöscht. Wenn es sich bei dem Pfad um einen symbolischen Link handelt, gibt der Prozess ohne Fehlermeldung und ohne weitere Aktion zurück. Enthält das Modul im Verzeichnis build/ Inhalte, die neuer sind als die .tcl-Dateien im Quellverzeichnis des Moduls, und existiert eine Datei build/build.tcl, wird diese Datei ausgeführt. Wenn das Quellverzeichnis eine Datei mit dem Namen „index.tcl“ enthält, wird davon ausgegangen, dass es sich um ein Modul im TAO-Stil handelt, und das gesamte Verzeichnis (sowie alle Unterverzeichnisse) wird unverändert kopiert. Wenn keine Datei „index.tcl“ vorhanden ist, werden alle .tcl-Dateien aus dem Modul-Quellverzeichnis kopiert, und es wird eine Datei „pkgIndex.tcl“ generiert, sofern diese noch nicht existiert. Existiert im Quellverzeichnis ein Verzeichnis namens „htdocs“, wird dieses Verzeichnis unverändert in das Zielverzeichnis kopiert.

proc **practcl::trigger** ?*args*?
: Build-Ziele auslösen und Abhängigkeiten neu berechnen – Interne Abläufe:


```
  ::practcl::LOCAL make trigger {*}$args
  foreach {name obj} [::practcl::LOCAL make objects] {
    set ::make($name) [$obj do]
  }
```

proc **practcl::depends** ?*args*?
: Berechnet, ob eine Abhängigkeit für eines der Argumente erfüllt oder neu erstellt werden muss. Interne Abläufe:


```
  ::practcl::LOCAL make depends {*}$args
```

proc **practcl::target** *name* *info* ?*action* ?
: Ein Build-Produkt deklarieren. Diese Prozedur ist lediglich eine Kurzform für *::practcl::LOCAL make task \$name \$info \$action* Durch die Registrierung eines Build-Produkts mit diesem Befehl wird ein Eintrag im globalen Array erstellt und ein Wert in das globale Array eingetragen. Interne Details:


```
  set obj [::practcl::LOCAL make task $name $info $action]
  set ::make($name) 0
  set filename [$obj define get filename]
  if {$filename ne {}} {
    set ::target($name) $filename
  }
```

# KLASSEN

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

**Methods**

Methode **constructor**
: ...siehe nächstes...

Methode **argspec** *argspec*
: Verarbeitet eine Argumentliste zu einem Informationswörterbuch. Diese Methode versteht auch nicht-positionale Argumente, die in der Notation von Tipp 471 *https://core.tcl-lang.org/tips/doc/trunk/tip/479.md* ausgedrückt werden. Die Ausgabe ist ein Dictionary, das alle Felder enthält und angibt, ob es sich bei den Feldern um **positional**, **mandatory**, and whether they have a **default** aufweisen. Beispiele:


```
   my argspec {a b {c 10}}

   > a {positional 1 mandatory 1} b {positional 1 mandatory 1} c {positional 1 mandatory 0 default 10}
```

Methode **comment** *block*
: Wandelt einen Kommentarblock in ein InformationsDictionary um. Wenn Zeilen im Kommentar mit einem einzelnen Wort beginnen, das mit einem Doppelpunkt endet, werden alle nachfolgenden Zeilen an ein Dictionary-Feld mit diesem Namen angehängt. Wenn keine Felder angegeben sind, wird der gesamte Text an das Feld **description** angehängt. Beispiel:


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

Methode **keyword.Annotation** *resultvar* *commentblock* *type* *name* *body*
: ...siehe nächstes...

Methode **keyword.Class** *resultvar* *commentblock* *name* *body*
: Verarbeitet einen oo::objdefine-Aufruf, der das Objekt der Klasse selbst ändert

Methode **keyword.class** *resultvar* *commentblock* *name* *body*
: Verarbeitet die Anweisungen oo::define, clay::define usw.

Methode **keyword.Class_Method** *resultvar* *commentblock* *name* ?*args*?
: Eine Anweisung für eine Methode der Klasse im Clay-Stil verarbeiten

Methode **keyword.method** *resultvar* *commentblock* *name* ?*args*?
: Den Prozess für eine Anweisung für eine Objektmethode im TCLOO-Stil durchführen

Methode **keyword.proc** *commentblock* *name* *argspec*
: Eine PROC-Anweisung ausführen

Methode **reset**
: Den Zustand des Objekts und seiner eingebetteten Coroutine zurücksetzen

Methode **Main**
: Hauptteil der eingebetteten Coroutine für das Objekt

Methode **section.method** *keyword* *method* *minfo*
: Den Text der Handbuchseite für eine Methode oder Prozedur generieren

Methode **section.annotation** *type* *name* *iinfo*
: ...siehe nächstes...

Methode **section.class** *class_name* *class_info*
: Den Text der Handbuchseite für eine Klasse generieren

Methode **section.command** *procinfo*
: Erstellt den Text für die Handbuchseite im Abschnitt „Befehle“

Methode **manpage** ?**header** *value*? ?**footer** *value*? ?**authors** *list*?
: Erstellt die Handbuchseite. Gibt den fertigen Text zurück, der zum Speichern in einer .man-Datei geeignet ist. Das Argument „header“ ist ein Block aus Doctools-Text, der vor dem maschinell generierten Abschnitt eingefügt werden soll. „footer“ ist ein Block aus Doctools-Text, der nach dem maschinell generierten Abschnitt eingefügt werden soll. „authors“ ist eine Liste einzelner Autoren und E-Mail-Adressen im Format AUTOR E-MAIL ?AUTOR E-MAIL?...

Methode **scan_text** *text*
: Einen Textblock scannen

Methode **scan_file** *filename*
: Eine Textdatei einscannen


## Klasse practcl::metaclass

Die Metaklasse für alle „practcl“-Objekte

**Methods**

Methode **\_MorphPatterns**
: ...siehe nächstes...

Methode **define** *submethod* ?*args*?
: ...siehe nächstes...

Methode **graft** ?*args*?
: ...siehe nächstes...

Methode **initialize**
: ...siehe nächstes...

Methode **link** *command* ?*args*?
: ...siehe nächstes...

Methode **morph** *classname*
: ...siehe nächstes...

Methode **script** *script*
: ...siehe nächstes...

Methode **select**
: ...siehe nächstes...

Methode **source** *filename*
: 


## Klasse practcl::toolset

Eine Klasse ohne übergeordnete Klasse, die als Mixin konzipiert ist und eine Reihe von Verhaltensweisen im Zusammenhang mit dem Build definiert, die angepasst werden, je nachdem, ob gcc oder msvc als Zielkompilierer ausgewählt wird.

**Class Methods**

classmethod **select** *object*
: Führt die Auswahl für das Toolset-Mixin **Methods** durch

Methode **config.sh**
: Sucht eine Schlüssel-Wert-Liste, die dieses Projekt beschreibt, oder erstellt eine solche.

Methode **BuildDir** *PWD*
: Ermittelt den Standort, an dem das Produkt hergestellt werden soll

Methode **MakeDir** *srcdir*
: Gibt den Pfad zurück, an dem sich das Makefile relativ zu *srcdir* befindet. Bei dieser Implementierung ist MakeDir immer srcdir.

Methode **read_configuration**
: Liest die Informationen zum Erstellungs-Prozess für dieses Paket. Bei dieser Implementierung werden Daten an den folgenden Speicherorten in der folgenden Reihenfolge gesucht: config.tcl (von practcl generiert), PKGConfig.sh und das Makefile. Wenn das Makefile herangezogen werden muss, aber nicht vorhanden ist, wird die Methode „Configure“ aufgerufen.

Methode **build-cflags** *PROJECT* *DEFS* *namevar* *versionvar* *defsvar*
: Methode DEFS Diese Methode füllt vier Variablen: name – Der Name des Pakets version – Die Version des Pakets defs – An den Compiler übergebene C-Flags includedir – Eine Liste von Pfaden, die dem Compiler zum Auffinden von Header-Dateien übergeben werden sollen

Methode **critcl** ?*args*?
: Aufruf von „critcl“ in einem externen Prozess


## Klasse practcl::toolset.gcc

*ancestors*: **practcl::toolset**

**Methods**

Methode **Autoconf**
: ...siehe nächstes...

Methode **BuildDir** *PWD*
: ...siehe nächstes...

Methode **ConfigureOpts**
: ...siehe nächstes...

Methode **MakeDir** *srcdir*
: Ermittelt, in welchem Verzeichnis sich die Makefile-Vorlage befindet

Methode **make {} autodetect**
: ...siehe nächstes...

Methode **make {} clean**
: ...siehe nächstes...

Methode **make {} compile**
: ...siehe nächstes...

Methode **make {} install** *DEST*
: ...siehe nächstes...

Methode **build-compile-sources** *PROJECT* *COMPILE* *CPPCOMPILE* *INCLUDES*
: ...siehe nächstes...

Methode **build-Makefile** *path* *PROJECT*
: ...siehe nächstes...

Methode **build-library** *outfile* *PROJECT*
: Erstellt eine statische oder dynamische Bibliothek

Methode **build-tclsh** *outfile* *PROJECT* ?*path* **auto**?
: Erstellt eine statische ausführbare Datei


## Klasse practcl::toolset.msvc

*ancestors*: **practcl::toolset**

**Methods**

Methode **BuildDir** *PWD*
: MSVC führt die Kompilierung stets im Quellverzeichnis durch

Methode **make {} autodetect**
: Nichts tun

Methode **make {} clean**
: ...siehe nächstes...

Methode **make {} compile**
: ...siehe nächstes...

Methode **make {} install** *DEST*
: ...siehe nächstes...

Methode **MakeDir** *srcdir*
: Ermittelt, in welchem Verzeichnis sich die Makefile-Vorlage befindet

Methode **NmakeOpts**
: 


## Klasse practcl::make_obj

*ancestors*: **practcl::metaclass**

Ein Objekt, das im Rahmen des Build-Prozesses bereitgestellt wird. In der Regel handelt es sich dabei um eine Objektdatei, eine Header-Datei oder ein TCL-Skript, das auf irgendeine Weise kompiliert oder generiert werden muss.

**Methods**

Methode **constructor** *module_object* *name* *info* ?*action_body* ?
: ...siehe nächstes...

Methode **do**
: ...siehe nächstes...

Methode **check**
: ...siehe nächstes...

Methode **output**
: ...siehe nächstes...

Methode **reset**
: ...siehe nächstes...

Methode **triggers**
: 


## Klasse practcl::object

*ancestors*: **practcl::metaclass**

Ein generisches „Practcl“-Objekt

**Methods**

Methode **constructor** *parent* ?*args*?
: ...siehe nächstes...

Methode **child** *method*
: ...siehe nächstes...

Methode **go**
: 


## Klasse practcl::dynamic

Dynamische Blöcke erzeugen keine eigenen .c-Dateien, sondern tragen zur Zusammenführung der Datei der Hauptbibliothek bei.

**Methods**

Methode **cstructure** *name* *definition* ?*argdat* ?
: Parser-Funktionen

Methode **include** *header*
: ...siehe nächstes...

Methode **include_dir** ?*args*?
: ...siehe nächstes...

Methode **include_directory** ?*args*?
: ...siehe nächstes...

Methode **c_header** *body*
: ...siehe nächstes...

Methode **c_code** *body*
: ...siehe nächstes...

Methode **c_function** *header* *body* ?*info* ?
: ...siehe nächstes...

Methode **c_tcloomethod** *name* *body* ?*arginfo* ?
: ...siehe nächstes...

Methode **cmethod** *name* *body* ?*arginfo* ?
: Alias für den klassischen Namen

Methode **c_tclproc_nspace** *nspace*
: ...siehe nächstes...

Methode **c_tclcmd** *name* *body* ?*arginfo* ?
: ...siehe nächstes...

Methode **c_tclproc_raw** *name* *body* ?*arginfo* ?
: Alias für den klassischen Namen

Methode **tcltype** *name* *argdat*
: ...siehe nächstes...

Methode **project-compile-products**
: Wechselwirkungen zwischen Modulen

Methode **implement** *path*
: ...siehe nächstes...

Methode **initialize**
: Praktische Grundlagen

Methode **linktype**
: ...siehe nächstes...

Methode **generate-cfile-constant**
: ...siehe nächstes...

Methode **generate-cfile-header**
: ...siehe nächstes...

Methode **generate-cfile-tclapi**
: Erstellt Code, der Tcl-API-Aufrufe implementiert

Methode **generate-loader-module**
: Erstellt Code, der ausgeführt wird, wenn das Paket/Modul im Interpreter initialisiert wird

Methode **Collate_Source** *CWD*
: ...siehe nächstes...

Methode **select**
: Sobald sich ein Objekt als eine Form von „dynamisch“ kennzeichnet, sollten Sie nicht länger versuchen, es in etwas anderes umzuwandeln.


## Klasse practcl::product

Ein Ergebnis für das Build-System

**Class Methods**

classmethod **select** *object*
: **Methods**

Methode **code** *section* *body*
: ...siehe nächstes...

Methode **Collate_Source** *CWD*
: ...siehe nächstes...

Methode **project-compile-products**
: ...siehe nächstes...

Methode **generate-debug** ?*spaces* ?
: ...siehe nächstes...

Methode **generate-cfile-constant**
: ...siehe nächstes...

Methode **generate-cfile-public-structure**
: Konstante statische Datenstrukturen mit Werten füllen

Methode **generate-cfile-header**
: ...siehe nächstes...

Methode **generate-cfile-global**
: ...siehe nächstes...

Methode **generate-cfile-private-typedef**
: ...siehe nächstes...

Methode **generate-cfile-private-structure**
: ...siehe nächstes...

Methode **generate-cfile-functions**
: Erstellt Code, der Unterprogramme bereitstellt, die von Tcl-API-Methoden aufgerufen werden

Methode **generate-cfile-tclapi**
: Erstellt Code, der Tcl-API-Aufrufe implementiert

Methode **generate-hfile-public-define**
: ...siehe nächstes...

Methode **generate-hfile-public-macro**
: ...siehe nächstes...

Methode **generate-hfile-public-typedef**
: ...siehe nächstes...

Methode **generate-hfile-public-structure**
: ...siehe nächstes...

Methode **generate-hfile-public-headers**
: ...siehe nächstes...

Methode **generate-hfile-public-function**
: ...siehe nächstes...

Methode **generate-hfile-public-includes**
: ...siehe nächstes...

Methode **generate-hfile-public-verbatim**
: ...siehe nächstes...

Methode **generate-loader-external**
: ...siehe nächstes...

Methode **generate-loader-module**
: ...siehe nächstes...

Methode **generate-stub-function**
: ...siehe nächstes...

Methode **IncludeAdd** *headervar* ?*args*?
: ...siehe nächstes...

Methode **generate-tcl-loader**
: ...siehe nächstes...

Methode **generate-tcl-pre**
: Diese Methode generiert eine beliebige Tcl-Skriptdatei, die zur Vorinitialisierung der C-Bibliothek erforderlich ist.

Methode **generate-tcl-post**
: ...siehe nächstes...

Methode **linktype**
: ...siehe nächstes...

Methode **Ofile** *filename*
: ...siehe nächstes...

Methode **project-static-packages**
: Vom Hauptprojekt aufgerufene Methoden

Methode **toolset-include-directory**
: Vom Toolset aufgerufene Methoden

Methode **target** *method* ?*args*?
: 


## Klasse practcl::product.cheader

*ancestors*: **practcl::product**

Ein Produkt, das aus einer C-Header-Datei generiert wurde. Das heißt: gar nichts.

**Methods**

Methode **project-compile-products**
: ...siehe nächstes...

Methode **generate-loader-module**
: 


## Klasse practcl::product.csource

*ancestors*: **practcl::product**

Ein Produkt, das aus einer C-Quelldatei generiert wurde. In der Regel handelt es sich dabei um eine Objektdatei (.o).

**Methods**

Methode **project-compile-products**
: 


## Klasse practcl::product.clibrary

*ancestors*: **practcl::product**

Ein Produkt, das aus einer kompilierten C-Bibliothek generiert wird. In der Regel handelt es sich dabei um eine .a- oder eine .dylib-Datei; in komplexen Fällen kann es sich jedoch lediglich um ein Mittel handeln, mit dem ein Projekt den Quellcode eines anderen Projekts integriert.

**Methods**

Methode **linker-products** *configdict*
: 


## Klasse practcl::product.dynamic

*ancestors*: **practcl::dynamic** **practcl::product**

Ein Produkt, das aus C-Code generiert wird, der wiederum von „practcl“ oder auf andere Weise erzeugt wurde. Diese C-Datei erzeugt möglicherweise eine eigene .o-Datei, möglicherweise aber auch nicht – je nachdem, ob sie für die Einbindung in eine Zusammenführung in Frage kommt.

**Methods**

Methode **initialize**
: 


## Klasse practcl::product.critcl

*ancestors*: **practcl::dynamic** **practcl::product**

Ein von critcl erstelltes Binärprodukt. Hinweis: Die Implementierung wurde noch nicht geschrieben; diese Klasse führt keine Funktionen aus.

## Klasse practcl::module

*ancestors*: **practcl::object** **practcl::product.dynamic**

Letztendlich muss der gesamte C-Code in ein Modul geladen werden. Dabei handelt es sich entweder um eine dynamisch geladene Bibliothek, die eine Tcl-Erweiterung implementiert, oder um einen fest kompilierten Abschnitt einer benutzerdefinierten Shell bzw. Anwendung.

**Variable**

Variable **make_object**
: **Methods**

Methode **\_MorphPatterns**
: ...siehe nächstes...

Methode **add** ?*args*?
: ...siehe nächstes...

Methode **install-headers** ?*args*?
: ...siehe nächstes...

Methode **make {} \_preamble**
: ...siehe nächstes...

Methode **make {} pkginfo**
: ...siehe nächstes...

Methode **make {} objects**
: Gibt ein Dictionary mit allen Handles und den zugehörigen Objekten zurück

Methode **make {} object** *name*
: Gibt das Objekt zurück, das mit dem Handle *name* verknüpft ist.

Methode **make {} reset**
: Alle untergeordneten Objekte zurücksetzen

Methode **make {} trigger** ?*args*?
: Wendet die „triggers“-Methode auf alle aufgeführten Handles an

Methode **make {} depends** ?*args*?
: Führt die Prüfmethode für alle aufgeführten Handles durch

Methode **make {} filename** *name*
: Gibt den Namen des Build-Produkts für das angegebene Handle zurück

Methode **make {} target** *name* *Info* *body*
: ...siehe nächstes...

Methode **make {} todo**
: Gibt eine Liste von Handles für Objekte zurück, die bei der Methode „do“ den Wert „true“ zurückgeben

Methode **make {} do**
: Für jede Zielübung wird die in der *action*-Definition angegebene Aktion ausgeführt, wenn die *do*-Methode den Wert „true“ gibt.

Methode **child** *which*
: ...siehe nächstes...

Methode **generate-c**
: Diese Methode generiert den Inhalt einer zusammengeführten .c-Datei, die den Loader für eine Reihe von Tools implementiert

Methode **generate-h**
: Diese Methode generiert den Inhalt einer zusammengeführten .h-Datei, die die öffentliche API dieses Moduls beschreibt

Methode **generate-loader**
: ...siehe nächstes...

Methode **initialize**
: ...siehe nächstes...

Methode **implement** *path*
: ...siehe nächstes...

Methode **linktype**
: 


## Klasse practcl::project

*ancestors*: **practcl::module**

Ein Toplevel-Projekt, das eine Sammlung anderer Projekte darstellt

**Methods**

Methode **\_MorphPatterns**
: ...siehe nächstes...

Methode **constructor** ?*args*?
: ...siehe nächstes...

Methode **add_object** *object*
: ...siehe nächstes...

Methode **add_project** *pkg* *info* ?*oodefine* ?
: ...siehe nächstes...

Methode **add_tool** *pkg* *info* ?*oodefine* ?
: ...siehe nächstes...

Methode **build-tclcore**
: Kompiliert den Tcl-Kern. Wenn die Definition *tk* wahr ist, wird auch der Tk-Kern kompiliert.

Methode **child** *which*
: ...siehe nächstes...

Methode **linktype**
: ...siehe nächstes...

Methode **project** *pkg* ?*args*?
: Die Methoden eines Unterobjekts aufrufen

Methode **tclcore**
: ...siehe nächstes...

Methode **tkcore**
: ...siehe nächstes...

Methode **tool** *pkg* ?*args*?
: 


## Klasse practcl::library

*ancestors*: **practcl::project**

Ein Toplevel-Projekt, das eine Bibliothek erstellt

**Methods**

Methode **clean** *PATH*
: ...siehe nächstes...

Methode **project-compile-products**
: ...siehe nächstes...

Methode **go**
: ...siehe nächstes...

Methode **generate-decls** *pkgname* *path*
: ...siehe nächstes...

Methode **implement** *path*
: ...siehe nächstes...

Methode **generate-make** *path*
: Abwärtskompatibler Aufruf

Methode **linktype**
: ...siehe nächstes...

Methode **package-ifneeded** ?*args*?
: Erstellt ein „Paket ifneeded“. Die Argumente sind eine Liste von Aliasen, auf die dieses Paket reagieren soll.

Methode **shared_library** ?*filename* ?
: ...siehe nächstes...

Methode **static_library** ?*filename* ?
: 


## Klasse practcl::tclkit

*ancestors*: **practcl::library**

Ein Toplevel-Projekt, das eine eigenständige ausführbare Datei erzeugt

**Methods**

Methode **build-tclkit_main** *PROJECT* *PKG_OBJS*
: ...siehe nächstes...

Methode **Collate_Source** *CWD*
: ...siehe nächstes...

Methode **wrap** *PWD* *exename* *vfspath* ?*args*?
: Eine ausführbare Datei verpacken


## Klasse practcl::distribution

Eigenständige Klasse zur Verwaltung der Code-Verteilung. Diese Klasse ist dafür vorgesehen, in eine andere Klasse eingebunden zu werden (daher das Fehlen von Oberklassen).

**Class Methods**

classmethod **Sandbox** *object*
: ...siehe nächstes...

classmethod **select** *object*
: ...siehe nächstes...

Klassenmethode **claim_option**
: ...siehe nächstes...

classmethod **claim_object** *object*
: ...siehe nächstes...

classmethod **claim_path** *path*
: **Methods**

Methode **scm_info**
: ...siehe nächstes...

Methode **DistroMixIn**
: ...siehe nächstes...

Methode **Sandbox**
: ...siehe nächstes...

Methode **SrcDir**
: ...siehe nächstes...

Methode **ScmTag**
: ...siehe nächstes...

Methode **ScmClone**
: ...siehe nächstes...

Methode **ScmUnpack**
: ...siehe nächstes...

Methode **ScmUpdate**
: ...siehe nächstes...

Methode **Unpack**
: 


## Klasse practcl::distribution.snapshot

*ancestors*: **practcl::distribution**

Eine Dateiverteilung aus einem ZIP-Archiv, einem Tarball oder einem anderen, nicht auf SCM basierenden Archivformat

**Class Methods**

classmethod **claim_object** *object*
: ...siehe nächstes...

Klassenmethode **claim_option**
: ...siehe nächstes...

classmethod **claim_path** *path*
: **Methods**

Methode **ScmUnpack**
: 


## Klasse practcl::distribution.fossil

*ancestors*: **practcl::distribution**

Eine auf Fossil basierende Dateiverteilung

**Class Methods**

classmethod **claim_object** *obj*
: Überprüft die Metadaten auf Markierungen

Klassenmethode **claim_option**
: ...siehe nächstes...

classmethod **claim_path** *path*
: Überprüft, ob im Quellstamm „**Methods**“ Markierungen vorhanden sind

Methode **scm_info**
: ...siehe nächstes...

Methode **ScmClone**
: Den Quellcode klonen

Methode **ScmTag**
: ...siehe nächstes...

Methode **ScmUnpack**
: ...siehe nächstes...

Methode **ScmUpdate**
: 


## Klasse practcl::distribution.git

*ancestors*: **practcl::distribution**

Eine auf Git basierende Dateiverteilung

**Class Methods**

classmethod **claim_object** *obj*
: ...siehe nächstes...

Klassenmethode **claim_option**
: ...siehe nächstes...

classmethod **claim_path** *path*
: **Methods**

Methode **ScmTag**
: ...siehe nächstes...

Methode **ScmUnpack**
: ...siehe nächstes...

Methode **ScmUpdate**
: 


## Klasse practcl::subproject

*ancestors*: **practcl::module**

Ein Teilprojekt

**Methods**

Methode **\_MorphPatterns**
: ...siehe nächstes...

Methode **BuildDir** *PWD*
: ...siehe nächstes...

Methode **child** *which*
: ...siehe nächstes...

Methode **compile**
: ...siehe nächstes...

Methode **go**
: ...siehe nächstes...

Methode **install** ?*args*?
: Projekt in das lokale Build-System integrieren

Methode **linktype**
: ...siehe nächstes...

Methode **linker-products** *configdict*
: ...siehe nächstes...

Methode **linker-external** *configdict*
: ...siehe nächstes...

Methode **linker-extra** *configdict*
: ...siehe nächstes...

Methode **env-bootstrap**
: Methoden für Pakete/Tools, die heruntergeladen, gegebenenfalls kompiliert und intern von diesem Practcl-Prozess verwendet werden können. Laden Sie die Funktion in den Interpreter.

Methode **env-exec**
: Gibt einen Dateipfad zurück, den „exec“ aufrufen kann

Methode **env-install**
: Installiert das Tool in der lokalen Umgebung

Methode **env-load**
: Tun Sie alles Notwendige, um das Tool in die lokale Umgebung zu integrieren

Methode **env-present**
: Prüft, ob das Werkzeug zum Laden verfügbar ist bzw. bereits geladen wurde

Methode **sources**
: ...siehe nächstes...

Methode **update**
: ...siehe nächstes...

Methode **unpack**
: 


## Klasse practcl::subproject.source

*ancestors*: **practcl::subproject** **practcl::library**

Ein Projekt, bei dem das Kit den Quellcode selbst kompiliert und integriert

**Methods**

Methode **env-bootstrap**
: ...siehe nächstes...

Methode **env-present**
: ...siehe nächstes...

Methode **linktype**
: 


## Klasse practcl::subproject.teapot

*ancestors*: **practcl::subproject**

ein Schluck aus der Teekanne

**Methods**

Methode **env-bootstrap**
: ...siehe nächstes...

Methode **env-install**
: ...siehe nächstes...

Methode **env-present**
: ...siehe nächstes...

Methode **install** *DEST*
: 


## Klasse practcl::subproject.kettle

*ancestors*: **practcl::subproject**

**Methods**

Methode **kettle** *path* ?*args*?
: ...siehe nächstes...

Methode **install** *DEST*
: 


## Klasse practcl::subproject.critcl

*ancestors*: **practcl::subproject**

**Methods**

Methode **install** *DEST*
: 


## Klasse practcl::subproject.sak

*ancestors*: **practcl::subproject**

**Methods**

Methode **env-bootstrap**
: ...siehe nächstes...

Methode **env-install**
: ...siehe nächstes...

Methode **env-present**
: ...siehe nächstes...

Methode **install** *DEST*
: ...siehe nächstes...

Methode **install-module** *DEST* ?*args*?
: 


## Klasse practcl::subproject.practcl

*ancestors*: **practcl::subproject**

**Methods**

Methode **env-bootstrap**
: ...siehe nächstes...

Methode **env-install**
: ...siehe nächstes...

Methode **install** *DEST*
: ...siehe nächstes...

Methode **install-module** *DEST* ?*args*?
: 


## Klasse practcl::subproject.binary

*ancestors*: **practcl::subproject**

Ein untergeordnetes Paket

**Methods**

Methode **clean**
: ...siehe nächstes...

Methode **env-install**
: ...siehe nächstes...

Methode **project-compile-products**
: ...siehe nächstes...

Methode **ComputeInstall**
: ...siehe nächstes...

Methode **go**
: ...siehe nächstes...

Methode **linker-products** *configdict*
: ...siehe nächstes...

Methode **project-static-packages**
: ...siehe nächstes...

Methode **BuildDir** *PWD*
: ...siehe nächstes...

Methode **compile**
: ...siehe nächstes...

Methode **Configure**
: ...siehe nächstes...

Methode **install** *DEST*
: 


## Klasse practcl::subproject.tea

*ancestors*: **practcl::subproject.binary**

Ein untergeordnetes TEA-basiertes Paket

## Klasse practcl::subproject.library

*ancestors*: **practcl::subproject.binary** **practcl::library**

Eine von diesem Projekt erstellte untergeordnete C-Bibliothek

**Methods**

Methode **install** *DEST*
: 


## Klasse practcl::subproject.external

*ancestors*: **practcl::subproject.binary**

Eine untergeordnete externe C-Bibliothek

**Methods**

Methode **install** *DEST*
: 


## Klasse practcl::subproject.core

*ancestors*: **practcl::subproject.binary**

**Methods**

Methode **env-bootstrap**
: ...siehe nächstes...

Methode **env-present**
: ...siehe nächstes...

Methode **env-install**
: ...siehe nächstes...

Methode **go**
: ...siehe nächstes...

Methode **linktype**
: 


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *practcl* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

TclOO

# COPYRIGHT

```
Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
```