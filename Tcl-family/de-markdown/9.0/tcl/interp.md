---
CommandName: interp
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - bgerror(n)
 - load(n)
 - safe(n)
 - Tcl_CreateChild(3)
 - Tcl_Eval(3)
 - Tcl_BackgroundException(3)
Keywords:
 - alias
 - parent interpreter
 - safe interpreter
 - child interpreter
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
 - Copyright (c) 2004 Donal K. Fellows
 - Copyright (c) 2006-2008 Joe Mistachkin.
---

# NAME

interp - Erstellt und manipuliert Tcl-Interpreter

# ÜBERSICHT

::: {.synopsis} :::
[interp]{.cmd} [subcommand]{.arg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Dieser Befehl ermöglicht das Erstellen eines oder mehrerer neuer Tcl-Interpreter, die zusammen mit dem erstellenden Interpreter in derselben Anwendung koexistieren. Der erstellende Interpreter heißt *parent* (Eltern-Interpreter) und der neue Interpreter heißt *child* (Kind-Interpreter). Ein Eltern-Interpreter kann beliebig viele Kinder erstellen, und jedes Kind kann selbst weitere Kinder erstellen, für die es Eltern-Interpreter ist — so entsteht eine Hierarchie von Interpretern.

Jeder Interpreter ist unabhängig von den anderen: Er hat seinen eigenen Namensraum für Befehle, Prozeduren und globale Variablen. Ein Eltern-Interpreter kann Verbindungen zwischen seinen Kindern und sich selbst über einen Mechanismus namens *Alias* herstellen. Ein *Alias* ist ein Befehl in einem Kind-Interpreter, der bei Aufruf dazu führt, dass ein Befehl im Eltern-Interpreter oder in einem anderen Kind-Interpreter aufgerufen wird. Die einzigen weiteren Verbindungen zwischen Interpretern bestehen über Umgebungsvariablen (die Variable **env**), die normalerweise von allen Interpretern in der Anwendung gemeinsam genutzt werden, sowie über Callbacks bei überschrittenen Ressourcenlimits. Beachten Sie, dass der Namensraum für Dateien (wie die von **open** zurückgegebenen Namen) zwischen Interpretern nicht mehr gemeinsam genutzt wird. Explizite Befehle ermöglichen das Teilen von Dateien und das Übertragen von Referenzen auf geöffnete Dateien von einem Interpreter zu einem anderen.

Der Befehl **interp** unterstützt auch *sichere* Interpreter. Ein sicherer Interpreter ist ein Kind, dessen Funktionen stark eingeschränkt sind, sodass nicht vertrauenswürdige Skripte ausgeführt werden können, ohne dass andere Interpreter oder die Umgebung der Anwendung beschädigt werden. Beispielsweise sind alle Befehle zur Erstellung von IO-Kanälen und zur Erstellung von Unterprozessen für sichere Interpreter nicht zugänglich. Siehe **SICHERE INTERPRETER** unten für weitere Informationen, welche Funktionen in einem sicheren Interpreter vorhanden sind. Die gefährliche Funktionalität wird nicht aus dem sicheren Interpreter entfernt; stattdessen wird sie *verborgen*, sodass nur vertrauenswürdige Interpreter Zugriff darauf erhalten. Eine ausführliche Erklärung verborgener Befehle finden Sie unter **VERBORGENE BEFEHLE** unten. Der Alias-Mechanismus kann für geschützte Kommunikation (analog zu einem Kernel-Aufruf) zwischen einem Kind-Interpreter und seinem Eltern-Interpreter verwendet werden. Siehe **ALIAS-AUFRUF** unten für Details zum Alias-Mechanismus.

Ein qualifizierter Interpretername ist eine wohlgeformte Tcl-Liste, die eine Teilmenge seiner Vorfahren in der Interpreter-Hierarchie enthält, abgeschlossen durch die Zeichenkette, die den Interpreter in seinem unmittelbaren Eltern-Interpreter benennt. Interpreter-Namen sind relativ zum Interpreter, in dem sie verwendet werden. Wenn beispielsweise „**a**“ ein Kind des aktuellen Interpreters ist und ein Kind „**a1**“ hat, das wiederum ein Kind „**a11**“ hat, ist der qualifizierte Name von „**a11**“ in „**a**“ die Liste „**a1 a11**“.

Der unten beschriebene Befehl **interp** akzeptiert qualifizierte Interpreter-Namen als Argumente; der Interpreter, in dem der Befehl ausgewertet wird, kann stets als **{}** (die leere Liste oder Zeichenkette) bezeichnet werden. Beachten Sie, dass es unmöglich ist, in einem Kind-Interpreter per Name auf einen Eltern- (Vorfahren-)Interpreter zu verweisen, außer über Aliase. Außerdem gibt es keinen globalen Namen, mit dem man auf den ersten in einer Anwendung erstellten Interpreter verweisen kann. Beide Einschränkungen dienen Sicherheitszwecken.

# Der interp-Befehl

Der Befehl **interp** dient zum Erstellen, Löschen und Manipulieren von Kind-Interpretern sowie zum Teilen oder Übertragen von Kanälen zwischen Interpretern. Je nach dem Argument *subcommand* kann er mehrere Formen annehmen:

**interp alias** *srcPath srcToken*
: Gibt eine Tcl-Liste zurück, deren Elemente *targetCmd* und *arg* des durch *srcToken* repräsentierten Alias sind (dies ist der Wert, der bei Erstellung des Alias zurückgegeben wurde; der Name des Quellbefehls im Kind kann von *srcToken* abweichen).

**interp alias** *srcPath srcToken* **{}**
: Löscht den Alias für *srcToken* im Kind-Interpreter, der durch *srcPath* identifiziert wird. *srcToken* bezieht sich auf den bei Erstellung des Alias zurückgegebenen Wert; wurde der Quellbefehl umbenannt, wird der umbenannte Befehl gelöscht.

**interp alias** *srcPath srcCmd targetPath targetCmd* ?*arg arg ...*?
: Dieser Befehl erstellt einen Alias zwischen zwei Kind-Interpretern (siehe den Child-Befehl **alias** unten für Aliase zwischen einem Kind und seinem Eltern-Interpreter). In diesem Befehl kann jeder der Kind-Interpreter beliebig in der Hierarchie der Interpreter unter dem aufrufenden Interpreter stehen. *SrcPath* und *srcCmd* identifizieren die Quelle des Alias. *SrcPath* ist eine Tcl-Liste, deren Elemente einen bestimmten Interpreter auswählen. Beispielsweise identifiziert „**a b**“ einen Interpreter „**b**“, der Kind des Interpreters „**a**“ ist, der wiederum Kind des aufrufenden Interpreters ist. Eine leere Liste bezeichnet den aufrufenden Interpreter. *srcCmd* gibt den Namen eines neuen Befehls an, der im Quell-Interpreter erstellt wird. *TargetPath* und *targetCmd* geben Ziel-Interpreter und -Befehl an; die *arg*-Argumente, falls vorhanden, legen zusätzliche Argumente für *targetCmd* fest, die den bei Aufruf von *srcCmd* angegebenen Argumenten vorangestellt werden. *TargetCmd* kann zum Zeitpunkt dieses Aufrufs undefiniert sein oder bereits existieren; er wird durch diesen Befehl nicht erstellt. Der Alias sorgt dafür, dass der angegebene Zielbefehl im Ziel-Interpreter aufgerufen wird, sobald der angegebene Quellbefehl im Quell-Interpreter aufgerufen wird. Siehe **ALIAS-AUFRUF** unten für weitere Details. Der Befehl gibt ein Token zurück, das den erstellten Befehl *srcCmd* eindeutig identifiziert, auch wenn der Befehl später umbenannt wird. Das Token kann, muss aber nicht gleich *srcCmd* sein.

**interp aliases** ?*path*?
: Dieser Befehl gibt eine Tcl-Liste der Tokens aller Quellbefehle für im Interpreter *path* definierte Aliase zurück. Die Tokens entsprechen den bei Erstellung der Aliase zurückgegebenen Werten (die von den aktuellen Befehlsnamen abweichen können).

**interp bgerror** *path* ?*cmdPrefix*?
: Dieser Befehl liest oder setzt den aktuellen Handler für Hintergrund-Ausnahmen des durch *path* identifizierten Interpreters. Fehlt *cmdPrefix*, wird der aktuelle Handler zurückgegeben; ist er vorhanden, ist es eine Liste von Wörtern (mindestens Länge eins), die beschreibt, womit der Hintergrund-Ausnahme-Handler des Interpreters gesetzt werden soll. Siehe den Abschnitt **HINTERGRUND-AUSNAHMEBEHANDLUNG** für weitere Details.

**interp cancel** ?**-unwind**? ?**-\|-**? ?*path*? ?*result*?
: Bricht die Auswertung des Skripts im durch *path* identifizierten Interpreter ab. Ohne den Schalter **-unwind** wird der Auswertungsstack des Interpreters entladen, bis ein umschließender **catch**-Befehl gefunden wird oder keine weiteren Aufrufe des Interpreters auf dem Call-Stack verbleiben. Mit **-unwind** wird der Auswertungsstack ohne Rücksicht auf zwischenliegende **catch**-Befehle entladen, bis keine weiteren Aufrufe des Interpreters auf dem Call-Stack verbleiben. Der Schalter **-\|-** markiert das Ende der Schalter; er kann nötig sein, wenn *path* ein unüblicher Wert wie **-safe** ist. Ist *result* angegeben, wird es als Fehlermeldung verwendet; andernfalls eine Standard-Fehlermeldung.

**interp children** ?*path*?
: Gibt eine Tcl-Liste der Namen aller Kind-Interpreter zurück, die mit dem durch *path* identifizierten Interpreter verknüpft sind. Fehlt *path*, wird der aufrufende Interpreter verwendet.

**interp create** ?**-safe**? ?**-\|-**? ?*path*?
: Erstellt einen Kind-Interpreter *path* und einen neuen Befehl, den *Child-Befehl*. Der Name des Child-Befehls ist die letzte Komponente von *path*. Der neue Kind-Interpreter und der Child-Befehl werden im Interpreter erstellt, der durch den Pfad identifiziert wird, der durch Entfernen der letzten Komponente von *path* entsteht. Ist *path* beispielsweise **a b c**, werden ein neuer Kind-Interpreter und ein Child-Befehl **c** im Interpreter mit Pfad **a b** erstellt. Der Child-Befehl kann den neuen Interpreter wie unten beschrieben steuern. Fehlt *path*, erzeugt Tcl einen eindeutigen Namen der Form **interp***x*, wobei *x* eine Ganzzahl ist, und verwendet ihn für Interpreter und Child-Befehl. Ist der Schalter **-safe** gesetzt (oder ist der Eltern-Interpreter ein sicherer Interpreter), wird der neue Kind-Interpreter als sicherer Interpreter mit eingeschränkter Funktionalität erstellt; andernfalls enthält das Kind den vollen Satz Tcl-Builtin-Befehle und -Variablen. **-\|-** markiert das Ende der Schalter; nötig, wenn *path* ein unüblicher Wert wie **-safe** ist. Das Ergebnis ist der Name des neuen Interpreters. Der Name eines Kind-Interpreters muss unter allen Kindern seines Eltern-Interpreters eindeutig sein; existiert bereits ein Kind mit diesem Namen, tritt ein Fehler auf. Das anfängliche Rekursionslimit des Kind-Interpreters entspricht dem aktuellen Rekursionslimit seines Eltern-Interpreters.

**interp debug** *path* ?**-frame** ?*bool*??
: Steuert, ob Frame-Level-Stack-Informationen im durch *path* identifizierten Kind-Interpreter erfasst werden. Ohne Argumente werden Option und aktuelle Einstellung zurückgegeben. Mit **-frame** wird die Debug-Einstellung auf den angegebenen booleschen Wert gesetzt (falls angegeben) und die aktuelle Einstellung zurückgegeben. Dies betrifft nur die Ausgabe von **info frame**: exakte Frame-Level-Informationen für Befehlsaufrufe auf Bytecode-Ebene werden nur mit dieser Einstellung erfasst.
    Beispielsweise liefert bei Code wie

    ```
    proc mycontrol {... script} {
      ...
      uplevel 1 $script
      ...
    }
    
    proc dosomething {...} {
      ...
      mycontrol {
        somecode
      }
    }
    ```
    die Standardeinstellung eine relative Zeilennummer für **somecode** und der relevante Frame ist vom Typ **eval**. Ist Frame-Debug aktiv, reicht die Verfolgung so weit, dass Datei und absolute Zeilennummer des Befehls bestimmt werden können und ein Frame vom Typ **source** zurückgegeben wird. Diese genauere Information kostet langsamere Ausführung aller Befehle.
    Beachten Sie: Ist das Flag einmal gesetzt, kann es nicht wieder deaktiviert werden; solche Versuche werden still ignoriert. Das dient der Konsistenz des Zustands des zugrunde liegenden Interpreters.

**interp delete** ?*path ...*?
: Löscht null oder mehr Interpreter gemäß den optionalen *path*-Argumenten; für jeden Interpreter werden auch seine Kinder gelöscht. Der Befehl löscht außerdem den Child-Befehl jedes gelöschten Interpreters. Existiert für ein *path*-Argument kein Interpreter mit diesem Namen, löst der Befehl einen Fehler aus.

**interp eval** *path arg* ?*arg ...*?
: Dieser Befehl verkettet alle *arg*-Argumente wie **concat** und wertet die resultierende Zeichenkette als Tcl-Skript im durch *path* identifizierten Kind-Interpreter aus. Das Ergebnis (einschließlich aller **return**-Optionen wie **-errorinfo** und **-errorcode** bei Fehlern) wird an den aufrufenden Interpreter zurückgegeben.
    Das Skript wird im aktuellen Kontext-Stack-Frame des *path*-Interpreters ausgeführt; so können Implementierungen (im Eltern-Interpreter) von Aliasen in einem Kind-Interpreter Skripte im Kind ausführen, die Informationen über aktuellen Zustand und Stack-Frame des Kindes ermitteln.

**interp exists** *path*
: Gibt **1** zurück, wenn ein Kind-Interpreter mit dem angegebenen *path* in diesem Eltern-Interpreter existiert, sonst **0**. Fehlt *path*, wird der aufrufende Interpreter verwendet.

**interp expose** *path hiddenName* ?*exposedCmdName*?
: Macht den verborgenen Befehl *hiddenName* sichtbar und stellt ihn gegebenenfalls unter dem neuen Namen *exposedCmdName* wieder her (dieser Name wird derzeit nur akzeptiert, wenn er ein gültiger globaler Namensraumname ohne :: ist), im durch *path* bezeichneten Interpreter. Existiert bereits ein sichtbarer Befehl mit dem Zielnamen, schlägt der Befehl fehl. Verborgene Befehle werden unter **VERBORGENE BEFEHLE** unten ausführlicher erklärt.

**interp hide** *path exposedCmdName* ?*hiddenCmdName*?
: Macht den sichtbaren Befehl *exposedCmdName* verborgen, benennt ihn in *hiddenCmdName* um oder behält den Namen bei, wenn *hiddenCmdName* fehlt, im durch *path* bezeichneten Interpreter. Existiert bereits ein verborgener Befehl mit dem Zielnamen, schlägt der Befehl fehl. Derzeit dürfen weder *exposedCmdName* noch *hiddenCmdName* Namespace-Qualifizierer enthalten, sonst wird ein Fehler ausgelöst. Von **interp hide** zu verbergende Befehle werden im globalen Namespace gesucht, auch wenn der aktuelle Namespace nicht der globale ist. Das verhindert, dass Kinder einen Eltern-Interpreter dazu bringen, den falschen Befehl zu verbergen, indem sie den aktuellen Namespace vom globalen unterscheiden. Verborgene Befehle werden unter **VERBORGENE BEFEHLE** unten ausführlicher erklärt.

**interp hidden** *path*
: Gibt eine Liste der Namen aller verborgenen Befehle im durch *path* identifizierten Interpreter zurück.

**interp invokehidden** *path* ?*-option ...*? *hiddenCmdName* ?*arg ...*?
: Ruft den verborgenen Befehl *hiddenCmdName* mit den übergebenen Argumenten im durch *path* bezeichneten Interpreter auf. Auf die Argumente werden keine Substitutionen oder Auswertungen angewendet. Drei *-option*en werden unterstützt, alle beginnend mit **-**: **-namespace** (mit einem folgenden Argument *nsName*), **-global** und **-\|-**. Ist **-namespace** gesetzt, wird der verborgene Befehl im Namespace *nsName* im Ziel-Interpreter aufgerufen. Ist **-global** gesetzt, wird er auf globaler Ebene im Ziel-Interpreter aufgerufen; andernfalls im aktuellen Call-Frame mit Zugriff auf lokale Variablen in diesem und äußeren Frames. **-\|-** erlaubt, dass *hiddenCmdName* mit „-“ beginnt, und ist sonst unnötig. Sind **-namespace** und **-global** gesetzt, wird **-namespace** ignoriert.
    Der verborgene Befehl wird (standardmäßig) im aktuellen Kontext-Stack-Frame des *path*-Interpreters ausgeführt.
    Verborgene Befehle werden unter **VERBORGENE BEFEHLE** unten ausführlicher erklärt.

**interp issafe** ?*path*?
: Gibt **1** zurück, wenn der durch *path* identifizierte Interpreter sicher ist, sonst **0**.

**interp limit** *path limitType* ?*-option*? ?*value ...*?
: Richtet die Konfiguration des Ressourcenlimits *limitType* für den durch *path* bezeichneten Interpreter ein, manipuliert und abfragt sie. Ist keine *-option* angegeben, wird die aktuelle Konfiguration zurückgegeben. Ist *-option* das einzige Argument, der Wert dieser Option. Andernfalls muss eine Liste von *-option*/*value*-Paaren angegeben werden. Siehe **RESSOURCENLIMITS** unten für Limits und Optionen.

**interp marktrusted** *path*
: Markiert den durch *path* identifizierten Interpreter als vertrauenswürdig. Macht verborgene Befehle nicht sichtbar. Der Befehl kann nur aus einem vertrauenswürdigen Interpreter aufgerufen werden. Hat keine Wirkung, wenn der Interpreter bereits vertrauenswürdig ist.

**interp recursionlimit** *path* ?*newlimit*?
: Gibt die maximal zulässige Verschachtelungstiefe für den durch *path* angegebenen Interpreter zurück. Ist *newlimit* gesetzt, wird das Rekursionslimit so gesetzt, dass mehr als *newlimit* Aufrufe von **Tcl_Eval** und verwandten Prozeduren in diesem Interpreter einen Fehler ergeben. *newlimit* wird ebenfalls zurückgegeben. *newlimit* muss eine positive Ganzzahl zwischen 1 und dem Maximum eines non-long-Integer auf der Plattform sein.
    Der Befehl begrenzt nur die Größe des Tcl-Call-Stacks. Er verhindert allein keine Stack-Überläufe auf dem vom Programm genutzten C-Stack. Hat Ihr System ein Limit für die C-Stack-Größe, können Überläufe auftreten, bevor das durch den Befehl gesetzte Limit erreicht ist. Prüfen Sie in diesem Fall, ob sich die maximale C-Stack-Größe erhöhen lässt.

**interp share** *srcPath channel destPath*
: Bewirkt, dass der IO-Kanal *channel* zwischen dem durch *srcPath* und *destPath* identifizierten Interpreter geteilt wird. Beide haben dieselben Berechtigungen auf dem Kanal. Beide müssen schließen, um den zugrunde liegenden Kanal zu schließen; in einem Interpreter zugängliche Kanäle werden beim Zerstören des Interpreters automatisch geschlossen.

**interp target** *path alias*
: Gibt eine Tcl-Liste zurück, die den Ziel-Interpreter für einen Alias beschreibt. Der Alias wird wie bei **interp alias** oben durch Interpreter-Pfad und Quellbefehlsname angegeben. Der Ziel-Interpreter-Name wird als Interpreter-Pfad relativ zum aufrufenden Interpreter zurückgegeben. Ist der Ziel-Interpreter der aufrufende Interpreter, wird eine leere Liste zurückgegeben. Ist er weder der aufrufende noch einer seiner Nachkommen, wird ein Fehler erzeugt. Der Zielbefehl muss zum Zeitpunkt des Aufrufs nicht definiert sein.

**interp transfer** *srcPath channel destPath*
: Bewirkt, dass der IO-Kanal *channel* im durch *destPath* identifizierten Interpreter verfügbar und im durch *srcPath* identifizierten Interpreter nicht mehr verfügbar ist.


# Child-Befehl

Für jeden mit **interp** erstellten Kind-Interpreter wird im Eltern-Interpreter ein neuer Tcl-Befehl mit demselben Namen wie der Interpreter erstellt. Dieser Befehl steuert verschiedene Operationen am Interpreter. Allgemeine Form:

```
child command ?arg arg ...?
```

*Child* ist der Interpretername; *command* und die *arg*s bestimmen das Verhalten. Gültige Formen:

*child* **aliases**
: Gibt eine Tcl-Liste der Tokens aller Aliase in *child* zurück. Die Tokens entsprechen den bei Erstellung zurückgegebenen Werten (die von den aktuellen Befehlsnamen abweichen können).

*child* **alias** *srcToken*
: Gibt eine Tcl-Liste zurück, deren Elemente *targetCmd* und *arg* des durch *srcToken* repräsentierten Alias sind (Wert bei Erstellung; der tatsächliche Quellbefehl im Kind kann von *srcToken* abweichen).

*child* **alias** *srcToken* **{}**
: Löscht den Alias für *srcToken* im Kind-Interpreter. *srcToken* bezieht sich auf den bei Erstellung zurückgegebenen Wert; wurde der Quellbefehl umbenannt, wird der umbenannte Befehl gelöscht.

*child* **alias** *srcCmd targetCmd* ?*arg ..*?
: Erstellt einen Alias: wird *srcCmd* in *child* aufgerufen, wird *targetCmd* im Eltern-Interpreter aufgerufen. Die *arg*-Argumente werden *targetCmd* vorangestellt, vor den Argumenten des *srcCmd*-Aufrufs. Siehe **ALIAS-AUFRUF** unten. Der Befehl gibt ein Token zurück, das den erstellten Befehl *srcCmd* eindeutig identifiziert, auch nach Umbenennung. Das Token kann, muss aber nicht gleich *srcCmd* sein.

*child* **bgerror** ?*cmdPrefix*?
: Liest oder setzt den Handler für Hintergrund-Ausnahmen des *child*-Interpreters. Fehlt *cmdPrefix*, wird der aktuelle Handler zurückgegeben; ist er vorhanden, eine Liste von Wörtern (mindestens Länge eins) für die neue Konfiguration. Siehe **HINTERGRUND-AUSNAHMEBEHANDLUNG**.

*child* **eval** *arg* ?*arg ..*?
: Verkettet alle *arg*-Argumente wie **concat** und wertet die Zeichenkette als Tcl-Skript in *child* aus. Das Ergebnis (einschließlich **return**-Optionen wie **-errorinfo** und **-errorcode** bei Fehlern) geht an den aufrufenden Interpreter zurück.
    Das Skript läuft im aktuellen Kontext-Stack-Frame von *child*; so können Alias-Implementierungen im Eltern-Interpreter Skripte im Kind ausführen, die Zustand und Stack-Frame des Kindes ermitteln.

*child* **expose** *hiddenName* ?*exposedCmdName*?
: Macht den verborgenen Befehl *hiddenName* in *child* sichtbar und stellt ihn gegebenenfalls unter *exposedCmdName* wieder her (nur gültiger globaler Namensraumname ohne ::). Existiert bereits ein sichtbarer Befehl mit dem Zielnamen, schlägt der Befehl fehl. Siehe **VERBORGENE BEFEHLE** unten.

*child* **hide** *exposedCmdName* ?*hiddenCmdName*?
: Verbirgt *exposedCmdName* in *child*, benennt ihn in *hiddenCmdName* um oder behält den Namen. Existiert bereits ein verborgener Befehl mit dem Zielnamen, schlägt der Befehl fehl. Derzeit dürfen weder *exposedCmdName* noch *hiddenCmdName* Namespace-Qualifizierer enthalten. Zu verbergende Befehle werden im globalen Namespace gesucht, auch wenn der aktuelle Namespace nicht global ist — damit Kinder den Eltern-Interpreter nicht zum Verbergen des falschen Befehls verleiten. Siehe **VERBORGENE BEFEHLE** unten.

*child* **hidden**
: Gibt eine Liste aller verborgenen Befehlsnamen in *child* zurück.

*child* **invokehidden** ?*-option ...*? *hiddenName* ?*arg ..*?
: Ruft *hiddenName* in *child* mit den übergebenen Argumenten auf. Keine Substitutionen oder Auswertungen auf den Argumenten. Drei *-option*en: **-namespace** (mit *nsName*), **-global**, **-\|-**. Mit **-namespace** Aufruf im angegebenen Namespace im Kind; mit **-global** auf globaler Ebene; sonst im aktuellen Call-Frame mit Zugriff auf lokale Variablen. **-\|-** erlaubt Befehlsnamen mit führendem „-“. Sind **-namespace** und **-global** gesetzt, wird **-namespace** ignoriert.
    Der verborgene Befehl läuft (standardmäßig) im aktuellen Kontext-Stack-Frame von *child*.
    Siehe **VERBORGENE BEFEHLE** unten.

*child* **issafe**
: Gibt **1** zurück, wenn der Kind-Interpreter sicher ist, sonst **0**.

*child* **limit** *limitType* ?*-option*? ?*value ...*?
: Richtet die Konfiguration des Ressourcenlimits *limitType* für *child* ein, manipuliert und abfragt sie. Ohne *-option* die aktuelle Konfiguration; nur *-option* der Optionswert; sonst *-option*/*value*-Paare. Siehe **RESSOURCENLIMITS** unten.

*child* **marktrusted**
: Markiert den Kind-Interpreter als vertrauenswürdig. Nur aus vertrauenswürdigem Interpreter aufrufbar. Macht keine verborgenen Befehle sichtbar. Keine Wirkung, wenn das Kind bereits vertrauenswürdig ist.

*child* **recursionlimit** ?*newlimit*?
: Gibt die maximal zulässige Verschachtelungstiefe für *child* zurück. Mit *newlimit* wird das Rekursionslimit so gesetzt, dass mehr als *newlimit* Aufrufe von **Tcl_Eval()** und verwandten Prozeduren in *child* einen Fehler ergeben. *newlimit* wird zurückgegeben; muss eine positive Ganzzahl zwischen 1 und dem Plattform-Maximum sein.
    Begrenzt nur den Tcl-Call-Stack, nicht C-Stack-Überläufe. Bei C-Stack-Limits des Systems können Überläufe vor Erreichen des gesetzten Limits auftreten; prüfen Sie dann eine Erhöhung der maximalen C-Stack-Größe.


# Sichere Interpreter

Ein sicherer Interpreter hat eingeschränkte Funktionalität, sodass beliebige Skripte selbst von nicht vertrauenswürdigen Quellen ausgeführt werden können, ohne die umschließende Anwendung oder die übrige Umgebung zu beschädigen. Um einen Interpreter sicher zu machen, werden bestimmte Befehle und Variablen entfernt. Beispielsweise entfallen Befehle zum Anlegen von Dateien auf der Platte und der Befehl **exec**, da er über Unterprozesse Schaden anrichten könnte. Eingeschränkter Zugriff kann über Aliase zum Eltern-Interpreter bereitgestellt werden, die Argumente prüfen und nur eine sichere Teilmenge erlauben — z. B. Dateierstellung nur in einem Unterverzeichnis oder Unterprozessaufrufe nur für eine fest definierte Programmliste.

Ein sicherer Interpreter entsteht durch den Schalter **-safe** bei **interp create**. Jedes von einem sicheren Interpreter erzeugte Kind ist ebenfalls sicher.

Ein sicherer Interpreter wird mit genau folgendem Satz Builtin-Befehle erstellt:

```
after append apply array
binary break catch chan
clock close concat continue
dict  eof   error eval
expr  fblocked fcopy fileevent
flush for   foreach format
gets  global if   incr
info  interp join lappend
lassign ledit lindex linsert
list  llength lrange lrepeat
lreplace lsearch lseq      lset
lsort     namespace package pid
proc      puts read regexp
regsub rename return scan
seek  set   split string
subst switch tell time
trace unset update uplevel
upvar variable vwait while
zlib
```

Folgende Befehle verbirgt **interp create** beim Erzeugen eines sicheren Interpreters:

```
cd    encoding exec exit
fconfigure file glob load
open  pwd   socket source
unload zipfs
```

Diese Befehle können später als Tcl-Prozeduren oder Aliase neu erstellt oder mit **interp expose** wieder sichtbar gemacht werden.

Folgende Befehle aus Tcl's Bibliothek von Hilfsprozeduren fehlen in einem sicheren Interpreter:

```
auto_exec_ok auto_import auto_load
auto_load_index auto_qualify unknown
```

Insbesondere haben sichere Interpreter keinen Standard-**unknown**-Befehl; Tcl's Autoload-Funktionen stehen nicht zur Verfügung. Autoload-Zugriff auf normalerweise per Autoload geladene Tcl-Befehle:

```
auto_mkindex   auto_mkindex_old
auto_reset     history
parray         pkg_mkIndex
::pkg::create  ::safe::interpAddToAccessPath
::safe::interpCreate ::safe::interpConfigure
::safe::interpDelete ::safe::interpFindInAccessPath
::safe::interpInit ::safe::setLogCmd
tcl_endOfWord  tcl_findLibrary
tcl_startOfNextWord tcl_startOfPreviousWord
tcl_wordBreakAfter tcl_wordBreakBefore
```

ist nur durch explizite Definition eines **unknown**-Befehls im sicheren Interpreter möglich — dazu muss **source** sichtbar gemacht werden. Am einfachsten durch Erstellung des sicheren Interpreters mit Tcl's **Safe-Tcl**-Mechanismus; **Safe-Tcl** liefert sichere Varianten von **source**, **load** und weiteren Befehlen für Autoload und Paketladen.

Außerdem fehlt die Variable **env** im sicheren Interpreter; Umgebungsvariablen können nicht mit anderen Interpretern geteilt werden. **env** birgt ein Sicherheitsrisiko, da Nutzer sensible Daten in Umgebungsvariablen ablegen können — z. B. empfiehlt das PGP-Handbuch das Passwort zum Schutz des privaten Schlüssels in *PGPPASS*. Diese Variable für nicht vertrauenswürdigen Code in einem sicheren Interpreter verfügbar zu machen, wäre ein Sicherheitsrisiko.

Werden Erweiterungen in einen sicheren Interpreter geladen, können sie ihre Funktionalität ebenfalls einschränken, um unsichere Befehle zu entfernen. Zur Verwaltung von Erweiterungen im Hinblick auf Sicherheit siehe **Safe-Tcl** und den Tcl-Befehl **load**.

Ein sicherer Interpreter darf das Rekursionslimit keines Interpreters ändern, auch nicht seines eigenen.

# Alias-Aufruf

Der Alias-Mechanismus ist so ausgelegt, dass er sicher in nicht vertrauenswürdigen Skripten in einem sicheren Interpreter verwendet werden kann, selbst wenn das Alias-Ziel kein sicherer Interpreter ist. Entscheidend für die Sicherheit ist, dass vom Kind an den Eltern übergebene Informationen im Eltern-Interpreter nie ausgewertet oder substituiert werden; sonst könnte ein bösartiges Kind-Skript beliebige Funktionen im Eltern aufrufen und die Sicherheit gefährden.

Wird die Alias-Quelle im Kind-Interpreter aufgerufen, erfolgen beim Parsen die üblichen Tcl-Substitutionen im Quell-Interpreter wie bei jedem anderen Befehl. Die Befehlsprozedur der Quelle führt ihre Argumente mit *targetCmd* und *arg* des Alias zu einem neuen Argumentarray zusammen. Waren die Wörter von *srcCmd* „*srcCmd arg1 arg2 ... argN*“, lautet die neue Wortfolge „*targetCmd arg arg ... arg arg1 arg2 ... argN*“, wobei *targetCmd* und *arg* die bei Alias-Erstellung gesetzten Werte sind. *TargetCmd* wird verwendet, um die Befehlsprozedur im Ziel-Interpreter zu finden; diese wird mit den neuen Argumenten aufgerufen. Fehlt ein Befehl *targetCmd* im Ziel-Interpreter, tritt ein Fehler auf. Auf den Wörtern erfolgen keine weiteren Substitutionen: Die Zielbefehlsprozedur wird direkt aufgerufen, ohne den normalen Tcl-Auswertungsmechanismus. Jede Substitutionsrunde erfolgt genau einmal: *targetCmd* und *args* beim Parsen des Alias-Erstellungsbefehls, *arg1* bis *argN* beim Parsen des Alias-Quellbefehls im Quell-Interpreter.

Beim Schreiben von *targetCmd* für Aliase in sicheren Interpretern dürfen die Argumente dieses Befehls nie ausgewertet oder substituiert werden — sonst entstünde ein Ausweg, über den das Kind beliebigen Code im Eltern ausführen könnte und die Systemsicherheit gefährdet wäre.

# Verborgene Befehle

Sichere Interpreter schränken die für Tcl-Programme verfügbare Funktionalität stark ein. Direkter Zugriff für nicht vertrauenswürdige Skripte wäre unsicher und ermöglicht Angriffe auf die Umgebung. Trotzdem gibt es legitime Gründe, gefährliche Funktionen im Kontext des sicheren Interpreters zu nutzen — z. B. muss manchmal ein Programm per **source** in den Interpreter geladen werden. Bei Tk sind Fenster an die Fensterhierarchie eines Interpreters gebunden; potenziell gefährliche Funktionen wie Fensterverwaltung müssen im Interpreter-Kontext auf diesen Fenstern ausgeführt werden.

Der Befehl **interp** löst das mit *verborgenen Befehlen*. Statt gefährliche Befehle vollständig zu entfernen, werden sie verborgen und sind Tcl-Skripten im Interpreter nicht verfügbar. Vertrauenswürdige Vorfahren des sicheren Interpreters können sie jedoch im Kontext des sicheren Interpreters mit **interp invoke** aufrufen. Verborgene und sichtbare Befehle liegen in getrennten Namensräumen; im selben Interpreter können verborgener und sichtbarer Befehl denselben Namen tragen.

Verborgene Befehle in einem Kind können im Rumpf von Prozeduren im Eltern während Alias-Aufrufen ausgeführt werden. Beispiel: Alias für **source** im Kind — beim Aufruf prüft eine Prozedur im Eltern, ob die Operation erlaubt ist (z. B. ob die Datei für das Kind zugänglich ist), und ruft dann den verborgenen **source**-Befehl im Kind auf, um den Inhalt zu laden. Im Kind existieren zwei Befehle **source**: der Alias und der verborgene Befehl.

Da der Eltern-Interpreter verborgene Befehle beim Alias-Handling aufrufen kann, dürfen über den Alias übergebene Argumente nicht ausgewertet werden — sonst könnten bösartige Kinder vertrauenswürdige Eltern zu gefährlichen Befehlen verleiten. Siehe **ALIAS-AUFRUF**. Zur Vermeidung werden auf Argumente von **interp invokehidden** keine Substitutionen oder Auswertungen angewendet.

Sichere Interpreter dürfen verborgene Befehle weder in sich selbst noch in Nachkommen aufrufen — kein Zugriff auf verborgene Funktionalität in sich oder Nachfahren.

Die Menge verborgener Befehle kann von einem vertrauenswürdigen Interpreter mit **interp expose** und **interp hide** geändert werden. **interp expose** verschiebt einen verborgenen Befehl in die sichtbaren Befehle des durch *path* identifizierten Interpreters, ggf. mit Umbenennung; existiert bereits ein sichtbarer Befehl mit dem Zielnamen, schlägt die Operation fehl. **interp hide** verschiebt einen sichtbaren Befehl in die verborgenen. Sichere Interpreter dürfen Befehle weder bei sich noch bei Nachkommen zwischen verborgen und sichtbar verschieben.

Derzeit dürfen Namen verborgener Befehle keine Namespace-Qualifizierer enthalten; ein Befehl in einem Namespace muss zuerst in den globalen Namespace umbenannt werden, bevor er verborgen werden kann. Von **interp hide** gesuchte Befehle werden im globalen Namespace aufgelöst, auch wenn der aktuelle Namespace nicht global ist — damit Kinder den Eltern nicht zum Verbergen des falschen Befehls verleiten.

# Ressourcenlimits

Jeder Interpreter hat zwei Arten von Ressourcenlimits, die ein Eltern-Interpreter seinen Kindern auferlegen kann. Befehlslimits (Typ **command**) begrenzen die Gesamtzahl ausführbarer Tcl-Befehle (prüfbar mit **info cmdcount**); Zeitlimits (Typ **time**) legen fest, bis wann die Ausführung im Interpreter abgeschlossen sein muss. Zeitlimits sind *absolute* Zeiten (wie **clock seconds**), nicht relative (wie **after**), da sie nach Erstellung geändert werden können.

Wird ein Limit überschritten, werden zuerst Handler-Callbacks der Eltern-Interpreter aufgerufen. Erhöhen oder entfernen diese das Limit, läuft die Ausführung im (zuvor) limitierten Interpreter weiter. Bleibt das Limit aktiv, wird ein Fehler erzeugt und die normale Fehlerbehandlung im Interpreter (durch **catch**) deaktiviert; der Fehler breitet sich nach außen aus (mit Stack-Trace) bis zum Punkt, an dem der limitierte Interpreter aufgerufen wurde (z. B. **interp eval**), wo der aufrufende Code fangen und behandeln muss.

## Limit-Optionen

Jedes Limit hat Optionen — einige für alle Limittypen, andere typspezifisch.

**-command**
: Diese Option (für alle Limittypen) legt (falls nicht leer) ein Tcl-Skript fest, das im globalen Namespace des Interpreters ausgeführt wird, der die Option liest/schreibt, wenn das jeweilige Limit im limitierten Interpreter überschritten wird. Der Callback kann das Limit ändern, damit der limitierte Interpreter weiterläuft. Erzeugt der Callback eine Ausnahme, wird sie über den Hintergrund-Ausnahme-Mechanismus gemeldet (siehe **HINTERGRUND-AUSNAHMEBEHANDLUNG**).
    Callbacks eines Interpreters sind von denen eines anderen isoliert; die Aufrufreihenfolge ist undefiniert.

**-granularity**
: Diese Option (für alle Limittypen) legt fest, wie häufig (an Punkten konsistenten Interpreter-Zustands, an denen Limits geprüft werden können) das Limit tatsächlich geprüft wird. Damit lässt sich die Prüfhäufigkeit und der Prüf-Overhead (bei Zeitlimits ggf. erheblich) abstimmen.

**-milliseconds**
: Anzahl Millisekunden nach dem in **-seconds** definierten Zeitpunkt, zu dem das Zeitlimit auslöst. Nur zusammen mit **-seconds** anzugeben (ob zuvor gesetzt oder in diesem Aufruf).

**-seconds**
: Sekunden seit der Epoche (siehe **clock seconds**), zu deren Beginn das Zeitlimit auslöst — am Sekundenanfang, sofern nicht mit **-milliseconds** sub-sekundengenau gesetzt. Kann die leere Zeichenkette sein (kein Zeitlimit).

**-value**
: Anzahl Befehle, die der Interpreter ausführen darf, bevor das Befehlslimit auslöst. Kann die leere Zeichenkette sein (kein Befehlslimit).


Erzeugt ein Interpreter mit gesetztem Ressourcenlimit ein Kind, erhält dieses mindestens so restriktive Limits wie der erzeugende Eltern-Interpreter. Will der Eltern-Interpreter des limitierten Eltern die Bedingungen lockern, soll er **interp** im Kind verbergen und über Aliase sowie **interp invokehidden** den limitierten Eltern den gewünschten **interp**-Zugriff geben.

# Hintergrund-Ausnahmebehandlung

Tritt eine Ausnahme auf, die nicht direkt den Stack hinauf gemeldet werden kann (z. B. bei Event-Verarbeitung in **update** oder **vwait**), erfolgt die Meldung über den Mechanismus für Hintergrund-Ausnahmen. Jeder Interpreter hat einen registrierten Handler; der Standard ruft **bgerror** im globalen Namespace auf, andere Handler können Hintergrund-Ausnahmen anders verarbeiten.

Ein Hintergrund-Ausnahme-Handler ist eine nicht leere Wortliste, der beim Aufruf zwei weitere Wörter angehängt werden: das Interpreter-Ergebnis zum Zeitpunkt der Ausnahme (typischerweise eine Fehlermeldung) und das Dictionary der Return-Optionen — dieselben Werte, die **catch** in Nicht-Hintergrund-Situationen erfassen kann. Die resultierende Liste wird im globalen Namespace ohne weitere Substitutionen ausgeführt.

# DANKSAGUNGEN

Der Mechanismus sicherer Interpreter basiert auf dem Safe-Tcl-Prototyp von Nathaniel Borenstein und Marshall Rose.

# BEISPIELE

Alias für einen Befehl im aktuellen Interpreter erstellen und verwenden:

```
interp alias {} getIndex {} lsearch {alpha beta gamma delta}
set idx [getIndex delta]
```

Beliebiges Skript in einem sicheren Interpreter ausführen, wobei jeder Aufruf von **lappend** protokolliert wird:

```
set i [interp create -safe]
interp hide $i lappend
interp alias $i lappend {} loggedLappend $i
proc loggedLappend {i args} {
    puts "logged invocation of lappend $args"
    interp invokehidden $i lappend {*}$args
}
interp eval $i $someUntrustedScript
```

Ressourcenlimit auf einem Interpreter setzen, damit eine Endlosschleife abbricht:

```
set i [interp create]
interp limit $i command -value 1000
interp eval $i {
    set x 0
    while {1} {
        puts "Counting up... [incr x]"
    }
}
```

