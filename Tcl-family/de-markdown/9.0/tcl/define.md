---
CommandName: define
ManualSection: n
Version: 0.3
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - next(n)
 - oo::class(n)
 - oo::object(n)
Keywords:
 - class
 - definition
 - method
 - object
 - slot
Copyright:
 - Copyright (c) 2007-2018 Donal K. Fellows
---

# NAME

oo::define, oo::objdefine, oo::Slot - Klassen und Objekte definieren und konfigurieren

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl::oo]{.lit} 

[oo::define]{.cmd} [class]{.arg} [defScript]{.arg} 
[oo::define]{.cmd} [class]{.arg} [subcommand]{.arg} [arg]{.arg} [arg]{.optdot} 
[oo::objdefine]{.cmd} [object]{.arg} [defScript]{.arg} 
[oo::objdefine]{.cmd} [object]{.arg} [subcommand]{.arg} [arg]{.arg} [arg]{.optdot} 

[oo::Slot]{.cmd} [arg...]{.arg} 
:::

# KLASSENHIERARCHIE

```
oo::object
   → oo::Slot
```

# BESCHREIBUNG

Der Befehl **oo::define** steuert die Konfiguration von Klassen, und der Befehl **oo::objdefine** steuert die Konfiguration von Objekten (einschließlich Klassen als Instanzobjekte). Die Konfiguration wird auf die Entität angewendet, die im Argument *class* bzw. *object* benannt ist. Die Konfiguration einer Klasse aktualisiert auch die Konfiguration aller Unterklassen der Klasse und aller Objekte, die Instanzen dieser Klasse sind oder sie eingemischt haben (modifiziert durch jede instanzspezifische Konfiguration). Die Art der Konfiguration wird entweder durch das Argument *defScript* oder durch *subcommand* und die folgenden *arg*-Argumente gesteuert; ist Letzteres vorhanden, entspricht es genau dem Fall, dass alle Argumente ab *subcommand* zu einer Liste zusammengefasst und diese Liste als *defScript*-Argument verwendet wird.

Beachten Sie, dass der Konstruktor von **oo::class** **oo::define** mit dem übergebenen Skriptargument aufruft. Das ist ein bequemer Weg, eine Klasse in einem Schritt zu erzeugen und zu definieren.

# Konfigurieren von Klassen

Die folgenden Befehle werden im *defScript* für **oo::define** unterstützt; jeder kann auch in der *subcommand*-Form verwendet werden:

**classmethod** *name* ?*argList bodyScrip*?
: Erzeugt eine Klassenmethode oder (wenn *argList* und *bodyScript* weggelassen werden) befördert eine vorhandene Methode des Klassenobjekts zur Klassenmethode. Die Argumente *name*, *argList* und *bodyScript* entsprechen der **method**-Definition unten.

::: {.info -version="TIP478"}
Klassenmethoden können sowohl auf der Klasse selbst als auch auf Instanzen dieser Klasse aufgerufen werden. Beim Aufruf ist das aktuelle Objekt (siehe die Befehle **self** und **my**) die Klasse, auf der sie aufgerufen werden, bzw. die Klasse der Instanz, auf der sie aufgerufen werden — je nachdem, ob der Aufruf auf der Klasse oder einer Instanz der Klasse erfolgt. Wird auf einer Unterklasse oder Instanz der Unterklasse aufgerufen, ist das aktuelle Objekt die Unterklasse.

In einem privaten Definitionskontext sind die Methoden bei Aufruf auf Klassen *nicht* privat, die Methoden bei Aufruf auf Instanzen von Klassen jedoch schon.
:::

**constructor** *argList bodyScript*
: Erzeugt oder aktualisiert den Konstruktor einer Klasse. Die formalen Argumente des Konstruktors (definiert im gleichen Format wie beim Tcl-Befehl **proc**) sind *argList*, und der Rumpf des Konstruktors ist *bodyScript*. Wird der Rumpf des Konstruktors ausgewertet, ist der aktuelle Namespace des Konstruktors ein Namespace, der für das zu konstruierende Objekt eindeutig ist. Innerhalb des Konstruktors sollte der Befehl **next** verwendet werden, um die Konstruktoren der Superklassen aufzurufen. Ist *bodyScript* die leere Zeichenkette, wird der Konstruktor gelöscht.

Klassen müssen keinen Konstruktor definieren. Ist keiner angegeben, wird stattdessen der Konstruktor der Superklasse verwendet.

**destructor** *bodyScript*
: Erzeugt oder aktualisiert den Destruktor einer Klasse. Destruktoren nehmen keine Argumente entgegen, und der Rumpf des Destruktors ist *bodyScript*. Der Destruktor wird aufgerufen, wenn Objekte der Klasse gelöscht werden; beim Aufruf ist der eindeutige Namespace des Objekts der aktuelle Namespace. Destruktoren sollten den Befehl **next** verwenden, um die Destruktoren der Superklassen aufzurufen. Beachten Sie, dass Destruktoren nicht in allen Situationen aufgerufen werden (z. B. wenn der Interpreter zerstört wird). Ist *bodyScript* die leere Zeichenkette, wird der Destruktor gelöscht. Beachten Sie, dass Fehler während der Auswertung eines Destruktors *nicht* an den Code zurückgegeben werden, der die Zerstörung eines Objekts verursacht. Stattdessen werden sie an den aktuell definierten **bgerror**-Handler weitergegeben.

**export** *name* ?*name ...*?
: Legt fest, dass jede der benannten Methoden *name* von der definierten Klasse exportiert wird (d. h. außerhalb einer Instanz über den Befehl des Instanzobjekts nutzbar). Beachten Sie, dass die Methoden selbst tatsächlich von einer Superklasse definiert sein können; Exporte von Unterklassen überschreiben die Sichtbarkeit der Superklasse und können wiederum von Instanzen überschrieben werden.

**forward** *name cmdName* ?*arg ...*?
: Erzeugt oder aktualisiert eine weitergeleitete Methode namens *name*. Die Methode wird an den Befehl *cmdName* weitergeleitet; zusätzliche Argumente *arg* usw. werden vor den vom Aufrufer der Methode angegebenen Argumenten eingefügt. *cmdName* wird stets nach den Regeln der Namespaces der aufrufenden Objekte aufgelöst, d. h. wenn *cmdName* nicht voll qualifiziert ist, wird der Befehl im Namespace jedes Objekts gesucht — über den Namespace-Pfad der Instanz oder im globalen Namespace. Die Methode wird exportiert, wenn *name* mit einem Kleinbuchstaben beginnt, andernfalls nicht exportiert.

::: {.info -version="TIP500"}
In einem privaten Definitionskontext (siehe den Definitionsbefehl **private** unten) erzeugt dieser Befehl private weitergeleitete Methoden.
:::

**initialise** *script*
: ...siehe nächstes...

**initialize** *script*
: Wertet *script* in einem Kontext aus, der lokale Variablen unterstützt und in dem der aktuelle Namespace der Instanz-Namespace des Klassenobjekts selbst ist. Das ist nützlich zum Einrichten von z. B. klassenweiten Variablen.

**method** *name* ?*option*? *argList bodyScript*
: Erzeugt oder aktualisiert eine Methode, die als prozedurähnliches Skript implementiert ist. Der Name der Methode ist *name*, die formalen Argumente der Methode (definiert im gleichen Format wie beim Tcl-Befehl **proc**) sind *argList*, und der Rumpf der Methode ist *bodyScript*. Wird der Rumpf der Methode ausgewertet, ist der aktuelle Namespace der Methode ein Namespace, der für das aktuelle Objekt eindeutig ist. Die Methode wird exportiert, wenn *name* mit einem Kleinbuchstaben beginnt, andernfalls nicht exportiert; dieses Verhalten kann über **export** und **unexport** oder durch Angabe von **-export**, **-private** oder **-unexport** im optionalen Parameter *option* überschrieben werden.

::: {.info -version="TIP500"}
In einem privaten Definitionskontext (siehe den Definitionsbefehl **private** unten) oder wenn für *option* das Flag **-private** gesetzt ist, erzeugt dieser Befehl private prozedurähnliche Methoden.
:::

**private** *cmd arg...*
: ...siehe nächstes...

**private** *script*
: Wertet das *script* (oder die Liste aus Befehl und Argumenten, gegeben durch *cmd* und *arg*s) in einem Kontext aus, in dem die am aktuellen Objekt vorgenommenen Definitionen private Definitionen sind.

::: {.info -version="TIP500"}
Die folgenden Klassendefinitionsbefehle sind von **private** betroffen: **forward**, **method**, **self** und **variable**. Verschachteltes **private** innerhalb von **private** hat keinen kumulativen Effekt; der innerste Definitionskontext ist lediglich ein privater Definitionskontext. Alle anderen Definitionsbefehle verhalten sich in einem privaten Definitionskontext nicht anders.
:::

**self** *subcommand arg ...*
: ...siehe nächstes...

**self** *script*
: ...siehe nächstes...

**self**
: Dieser Befehl entspricht dem Aufruf von **oo::objdefine** auf der gerade definierten Klasse (siehe **KONFIGURIEREN VON OBJEKTEN** unten für eine Beschreibung der unterstützten Werte von *subcommand*). Er folgt dem gleichen allgemeinen Muster der Argumentverarbeitung wie die Befehle **oo::define** und **oo::objdefine**, und „**oo::define** *cls* **self** *subcommand ...*“ wirkt identisch zu „**oo::objdefine** *cls subcommand ...*“.

::: {.info -version="TIP470"}
Werden überhaupt keine Argumente verwendet, liefert er den Namen der gerade konfigurierten Klasse.
:::

::: {.info -version="TIP500"}
In einem privaten Definitionskontext (siehe den Definitionsbefehl **private** unten) werden die Definitionen am Klassenobjekt ebenfalls in einem privaten Definitionskontext vorgenommen.
:::

**superclass** ?*-slotOperation*? ?*className ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) ermöglicht die Änderung der Superklassen der definierten Klasse. Jedes Argument *className* benennt eine Klasse, die Superklasse der definierten Klasse sein soll. Beachten Sie, dass Objekte nicht von Klassen zu Nicht-Klassen oder umgekehrt geändert werden dürfen, dass eine leere Elternklasse **oo::object** entspricht und dass die Elternklassen von **oo::object** und **oo::class** nicht geändert werden dürfen. Standardmäßig arbeitet dieser Slot durch Ersetzung.

**unexport** *name* ?*name ...*?
: Legt fest, dass jede der benannten Methoden *name* von der definierten Klasse nicht exportiert wird (d. h. nicht außerhalb der Instanz über den Befehl des Instanzobjekts nutzbar, sondern nur über den in jedem Objektkontext sichtbaren Befehl **my**). Beachten Sie, dass die Methoden selbst tatsächlich von einer Superklasse definiert sein können; Unexporte von Unterklassen überschreiben die Sichtbarkeit der Superklasse und können von Instanz-Unexporten überschrieben werden.

**variable** ?*-slotOperation*? ?*name ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) sorgt dafür, dass jede der benannten Variablen in den von der definierten Klasse deklarierten Methoden, im Konstruktor und im Destruktor automatisch verfügbar gemacht wird. Jeder Variablenname darf keine Namespace-Trenner enthalten und darf nicht wie ein Array-Zugriff aussehen. Alle Variablen sind tatsächlich im Namespace des Instanzobjekts vorhanden, auf dem die Methode ausgeführt wird. Beachten Sie, dass die von einer Super- oder Unterklasse deklarierten Variablenlisten vollständig disjunkt sind, ebenso wie von Instanzen deklarierte Variablenlisten; die Liste der Variablennamen gilt nur für von dieser Klasse deklarierte Methoden (sowie Konstruktoren und Destruktoren). Standardmäßig arbeitet dieser Slot durch Anhängen.

::: {.info -version="TIP500"}
In einem privaten Definitionskontext (siehe den Definitionsbefehl **private** unten) verwaltet dieser Slot die Liste der privaten Variablenbindungen für diese Klasse. Bei einer privaten Variablenbindung unterscheidet sich der Name der Variable im Instanzobjekt vom in der Definition angegebenen Namen; der in der Definition verwendete Name ist der Name, mit dem Sie in den Methoden dieser Klasse auf die Variable zugreifen, und der Name der Variable im Instanz-Namespace hat ein eindeutiges Präfix, das versehentliche Verwendung aus anderen Klassen extrem unwahrscheinlich macht.
:::


## Erweiterte Konfigurationsoptionen für Klassen

Die folgenden Definitionen werden ebenfalls unterstützt, sind in einfachen Programmen aber nicht erforderlich:

**definitionnamespace** ?*kind*? *namespaceName*
: Ermöglicht die Steuerung, welcher Namespace von den Befehlen **oo::define** und **oo::objdefine** zum Nachschlagen der verwendeten Definitionsbefehle genutzt wird. Wird an einem Objekt eine Definitionsoperation ausgeführt, wird *die Klasse, deren Instanz es ist* (und deren Superklassen und Mixins) konsultiert, welcher Definitions-Namespace zu verwenden ist. **oo::define** erhält den Klassen-Definitions-Namespace, und **::oo::objdefine** den Instanz-Definitions-Namespace; ansonsten ist die Nachschlageoperation identisch.

::: {.info -version="TIP524"}
Setzt den Definitions-Namespace der Art *kind*, bereitgestellt von der aktuellen Klasse, auf *namespaceName*. *namespaceName* muss auf einen existierenden Namespace verweisen oder die leere Zeichenkette sein (damit die aktuelle Klasse keinen solchen Namespace mehr verbunden hat). *kind*, falls angegeben, muss entweder **-class** (Standard) oder **-instance** sein, um festzulegen, ob der Namespace für **oo::define** bzw. **oo::objdefine** gesetzt wird.
:::
Die Klasse **oo::object** hat ihren Instanz-Namespace auf **::oo::objdefine** festgelegt, und die Klasse **oo::class** hat ihren Klassen-Namespace auf **::oo::define** festgelegt. Eine Folge davon ist, dass die effektive Nutzung dieses Merkmals für Klassen die Definition einer Metaklasse erfordert.

**deletemethod** *name* ?*name ...*?
: Löscht jede der Methoden namens *name* aus einer Klasse. Die Methoden müssen zuvor in dieser Klasse existiert haben. Beeinflusst nicht die Superklassen der Klasse, noch Unterklassen oder Instanzen der Klasse (außer wenn sie eine Aufrufkette durch die geänderte Klasse haben) oder das Klassenobjekt selbst.

**filter** ?*-slotOperation*? ?*methodName ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) setzt oder aktualisiert die Liste von Methodennamen, die steuern, ob Methodenaufrufe an Instanzen der Klasse durchgeführt werden dürfen und welche Ergebnisse die Methoden liefern. Jedes *methodName* benennt eine einzelne Filtermethode (exportiert oder nicht exportiert); es ist kein Fehler, eine nicht existierende Methode zu benennen, da sie von Unterklassen definiert sein kann. Standardmäßig arbeitet dieser Slot durch Anhängen.

**mixin** ?*-slotOperation*? ?*className ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) setzt oder aktualisiert die Liste zusätzlicher Klassen, die in alle Instanzen der definierten Klasse eingemischt werden sollen. Jedes Argument *className* benennt eine einzelne einzumischende Klasse. Standardmäßig arbeitet dieser Slot durch Ersetzung.

**renamemethod** *fromName toName*
: Benennt die in einer Klasse *fromName* genannte Methode in *toName* um. Die Methode muss zuvor in der Klasse existiert haben, und *toName* darf zuvor nicht auf eine Methode in dieser Klasse verweisen. Beeinflusst nicht die Superklassen der Klasse, noch Unterklassen oder Instanzen der Klasse (außer wenn sie eine Aufrufkette durch die geänderte Klasse haben) oder das Klassenobjekt selbst. Ändert nicht den Exportstatus der Methode; war sie zuvor exportiert, ist sie es danach auch.


# Konfigurieren von Objekten

Die folgenden Befehle werden im *defScript* für **oo::objdefine** unterstützt; jeder kann auch in der *subcommand*-Form verwendet werden:

**export** *name* ?*name ...*?
: Legt fest, dass jede der benannten Methoden *name* von dem definierten Objekt exportiert wird (d. h. außerhalb des Objekts über den Befehl des Objekts nutzbar). Beachten Sie, dass die Methoden selbst tatsächlich von einer Klasse oder Superklasse definiert sein können; Objekt-Exporte überschreiben die Klassensichtbarkeit.

**forward** *name cmdName* ?*arg ...*?
: Erzeugt oder aktualisiert eine weitergeleitete Objekt-Methode namens *name*. Die Methode wird an den Befehl *cmdName* weitergeleitet; zusätzliche Argumente *arg* usw. werden vor den vom Aufrufer der Methode angegebenen Argumenten eingefügt. Weitergeleitete Methoden sollten mit dem Unterbefehl **method** gelöscht werden. Die Methode wird exportiert, wenn *name* mit einem Kleinbuchstaben beginnt, andernfalls nicht exportiert.

::: {.info -version="TIP500"}
In einem privaten Definitionskontext (siehe den Definitionsbefehl **private** unten) erzeugt dieser Befehl private weitergeleitete Methoden.
:::

**method** *name* ?*option*? *argList bodyScript*
: Erzeugt, aktualisiert oder löscht eine Objekt-Methode. Der Name der Methode ist *name*, die formalen Argumente der Methode (definiert im gleichen Format wie beim Tcl-Befehl **proc**) sind *argList*, und der Rumpf der Methode ist *bodyScript*. Wird der Rumpf der Methode ausgewertet, ist der aktuelle Namespace der Methode ein Namespace, der für das Objekt eindeutig ist. Die Methode wird exportiert, wenn *name* mit einem Kleinbuchstaben beginnt, andernfalls nicht exportiert; dies kann durch Angabe von **-export**, **-private** oder **-unexport** im optionalen Parameter *option* oder über die Definitionen **export** und **unexport** überschrieben werden.

::: {.info -version="TIP500"}
In einem privaten Definitionskontext (siehe den Definitionsbefehl **private** unten) oder wenn für *option* das Flag **-private** gesetzt ist, erzeugt dieser Befehl private prozedurähnliche Methoden.
:::

**mixin** ?*-slotOperation*? ?*className ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) setzt oder aktualisiert eine pro Objekt geltende Liste zusätzlicher Klassen, die in das Objekt eingemischt werden sollen. Jedes Argument *className* benennt eine einzelne einzumischende Klasse. Standardmäßig arbeitet dieser Slot durch Ersetzung.

**private** *cmd arg...*
: ...siehe nächstes...

**private** *script*
: Wertet das *script* (oder die Liste aus Befehl und Argumenten, gegeben durch *cmd* und *arg*s) in einem Kontext aus, in dem die am aktuellen Objekt vorgenommenen Definitionen private Definitionen sind.

::: {.info -version="TIP500"}
Die folgenden Klassendefinitionsbefehle sind von **private** betroffen: **forward**, **method** und **variable**. Verschachteltes **private** innerhalb von **private** hat keinen kumulativen Effekt; der innerste Definitionskontext ist lediglich ein privater Definitionskontext. Alle anderen Definitionsbefehle verhalten sich in einem privaten Definitionskontext nicht anders.
:::

**unexport** *name* ?*name ...*?
: Legt fest, dass jede der benannten Methoden *name* von dem definierten Objekt nicht exportiert wird (d. h. nicht außerhalb des Objekts über den Befehl des Objekts nutzbar, sondern nur über den im Objektkontext sichtbaren Befehl **my**). Beachten Sie, dass die Methoden selbst tatsächlich von einer Klasse definiert sein können; Instanz-Unexporte überschreiben die Klassensichtbarkeit.

**variable** ?*-slotOperation*? ?*name ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) sorgt dafür, dass jede der benannten Variablen in den von dem definierten Objekt deklarierten Methoden automatisch verfügbar gemacht wird. Jeder Variablenname darf keine Namespace-Trenner enthalten und darf nicht wie ein Array-Zugriff aussehen. Alle Variablen sind tatsächlich im Namespace des Objekts vorhanden, auf dem die Methode ausgeführt wird. Beachten Sie, dass die von den Klassen und Mixins, deren Instanz das Objekt ist, deklarierten Variablenlisten vollständig disjunkt sind; die Liste der Variablennamen gilt nur für von diesem Objekt deklarierte Methoden. Standardmäßig arbeitet dieser Slot durch Anhängen.

::: {.info -version="TIP500"}
In einem privaten Definitionskontext (siehe den Definitionsbefehl **private** unten) verwaltet dieser Slot die Liste der privaten Variablenbindungen für dieses Objekt. Bei einer privaten Variablenbindung unterscheidet sich der Name der Variable im Instanzobjekt vom in der Definition angegebenen Namen; der in der Definition verwendete Name ist der Name, mit dem Sie in den Methoden dieses Instanzobjekts auf die Variable zugreifen, und der Name der Variable im Instanz-Namespace hat ein eindeutiges Präfix, das versehentliche Verwendung aus Superklassen-Methoden extrem unwahrscheinlich macht.
:::


## Erweiterte Konfigurationsoptionen für Objekte

Die folgenden Definitionen werden ebenfalls unterstützt, sind in einfachen Programmen aber nicht erforderlich:

**class** *className*
: Ermöglicht die Änderung der Klasse eines Objekts nach der Erstellung. Beachten Sie, dass die Konstruktoren der Klasse dabei nicht aufgerufen werden; das Objekt kann daher in einem inkonsistenten Zustand sein, sofern keine zusätzliche Konfigurationsarbeit erfolgt.

**deletemethod** *name* ?*name ...*
: Löscht jede der Methoden namens *name* aus einem Objekt. Die Methoden müssen zuvor in diesem Objekt existiert haben (z. B. weil sie durch **oo::objdefine method** erzeugt wurden). Beeinflusst nicht die Klassen, deren Instanz das Objekt ist, und entfernt nicht die Sichtbarkeit der von diesen Klassen bereitgestellten Methoden in der Instanz dieser Klasse.

**filter** ?*-slotOperation*? ?*methodName ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) setzt oder aktualisiert die Liste von Methodennamen, die steuern, ob ein Methodenaufruf an das Objekt durchgeführt werden darf und welche Ergebnisse die Methode liefert. Jedes *methodName* benennt eine einzelne Filtermethode (exportiert oder nicht exportiert); es ist kein Fehler, eine nicht existierende Methode zu benennen. Beachten Sie, dass die tatsächliche Filterliste auch von den Filtern abhängt, die für Klassen gesetzt sind, deren Instanz das Objekt ist. Standardmäßig arbeitet dieser Slot durch Anhängen.

**renamemethod** *fromName toName*
: Benennt die in einem Objekt *fromName* genannte Methode in *toName* um. Die Methode muss zuvor im Objekt existiert haben, und *toName* darf zuvor nicht auf eine Methode in diesem Objekt verweisen. Beeinflusst nicht die Klassen, deren Instanz das Objekt ist, und kann in einem Instanzobjekt nicht die von diesen Klassen bereitgestellten Methoden umbenennen (eine per **oo::objdefine forward** weitergeleitete Methode kann jedoch eine gleichwertige Fähigkeit bieten). Ändert nicht den Exportstatus der Methode; war sie zuvor exportiert, ist sie es danach auch.

**self**
: Liefert den Namen des gerade konfigurierten Objekts.


# Private Methoden

::: {.info -version="TIP500"}
Hat eine Klasse oder Instanz eine private Methode, kann diese private Methode nur innerhalb von Methoden dieser Klasse bzw. Instanz aufgerufen werden. Andere Aufrufer der Methoden des Objekts *können* private Methoden nicht aufrufen; es ist, als ob die privaten Methoden nicht existieren. Eine private Methode einer Klasse *kann* jedoch aus den Methoden der Klasse aufgerufen werden, wenn diese Methoden auf einem anderen Instanzobjekt verwendet werden; das bedeutet, dass eine Klasse sie nutzen kann, um das Verhalten mehrerer Instanzen von sich selbst zu koordinieren, ohne zu beeinträchtigen, wie andere Klassen (insbesondere Unter- oder Superklassen) interagieren. Private Methoden stehen in der Methodenaufrufreihenfolge (wie von **self call** gemeldet) vor allen eingemischten Klassen.
:::

# Slot-Definitionen

Einige der konfigurierbaren Definitionen einer Klasse oder eines Objekts sind *Slot-Definitionen*. Das bedeutet, die Konfiguration wird durch ein Slot-Objekt implementiert — eine Instanz der Klasse **oo::Slot** —, das eine Liste von Werten (Klassennamen, Variablennamen usw.) verwaltet, die den Inhalt des Slots bilden.

Die Klasse **oo::Slot** definiert sechs Operationen (als Methoden), die am Slot ausgeführt werden können:

*slot* **-append** ?*member ...*?
: Hängt die angegebenen *member*-Elemente an die Slot-Definition an.

*slot* **-appendifnew** ?*member ...*?
: Hängt die angegebenen *member*-Elemente an die Slot-Definition an, sofern sie noch nicht existieren.

*slot* **-clear**
: Setzt die Slot-Definition auf die leere Liste.

*slot* **-prepend** ?*member ...*?
: Fügt die angegebenen *member*-Elemente der Slot-Definition voran.

*slot* **-remove** ?*member ...*?
: Entfernt die angegebenen *member*-Elemente aus der Slot-Definition.

*slot* **-set** ?*member ...*?
: Ersetzt die Slot-Definition durch die angegebenen *member*-Elemente.


Eine Folge davon ist, dass jede Verwendung der Standardoperation eines Slots, bei der das erste *member*-Argument mit einem Bindestrich beginnt, ein Fehler ist. In diesen Fällen sollte eine der obigen Operationen explizit verwendet werden.

Eine Instanz von **oo::Slot** muss nur erzeugt werden, wenn ein eigener Slot definiert wird, der sich wie ein Standard-Slot verhält.

## Slot-Implementierung

Intern definieren Slot-Objekte auch eine Methode **--default-operation**, die an die Standardoperation des Slots weitergeleitet wird (für den Klassen-„**variable**“-Slot also an „**my -append**“), sowie diese Methoden, die die Implementierungsschnittstelle bereitstellen:

*slot* **Get**
: Gibt eine Liste zurück, die den aktuellen Inhalt des Slots ist, modifiziert den Slot aber nicht. Diese Methode muss stets aus einem Stack-Frame aufgerufen werden, der durch einen Aufruf von **oo::define** oder **oo::objdefine** erzeugt wurde. Diese Methode *sollte* keinen Fehler zurückgeben, außer wenn sie außerhalb eines Definitionskontexts oder mit falscher Argumentanzahl aufgerufen wird.

::: {.info -version="TIP516"}
Die Elemente der Liste sollten vollständig aufgelöst sein, sofern das für den Slot ein sinnvoller Begriff ist.
:::

*slot* **Resolve** *slotElement*
: Gibt *slotElement* mit einer Auflösungsoperation angewendet zurück, modifiziert den Slot aber nicht. Bei Slots einfacher Zeichenketten ist dies eine Operation ohne Wirkung, bei Slots von Klassen wird ein Klassenname auf seinen voll qualifizierten Klassennamen abgebildet. Diese Methode muss stets aus einem Stack-Frame aufgerufen werden, der durch einen Aufruf von **oo::define** oder **oo::objdefine** erzeugt wurde. Diese Methode *sollte* keinen Fehler zurückgeben, außer wenn sie außerhalb eines Definitionskontexts oder mit falscher Argumentanzahl aufgerufen wird; nicht auflösbare Argumente sollten unverändert zurückgegeben werden (da nicht alle Slot-Operationen zwingend auflösbare Werte erfordern).

::: {.info -version="TIP516"}
Implementierungen *sollten* in dieser Methode keine Eindeutigkeits- und Sortierungsbeschränkungen erzwingen; das ist Aufgabe der Methode **Set**. Eine Standardimplementierung dieser Methode (sie gibt nur ihr Argument *slotElement* zurück) stellt die Klasse **oo::Slot** bereit.
:::

*slot* **Set** *elementList*
: Setzt den Inhalt des Slots auf die Liste *elementList* und gibt die leere Zeichenkette zurück. Diese Methode muss stets aus einem Stack-Frame aufgerufen werden, der durch einen Aufruf von **oo::define** oder **oo::objdefine** erzeugt wurde. Diese Methode kann einen Fehler zurückgeben, wenn sie die Änderung des Slot-Inhalts ablehnt (z. B. wegen ungültiger Werte), sowie wenn sie außerhalb eines Definitionskontexts oder mit falscher Argumentanzahl aufgerufen wird.

Diese Methode *kann* die Elemente neu sortieren und filtern, wenn das nötig ist, um die zugrunde liegenden Beschränkungen des Slots zu erfüllen. (Slots von Klassen erzwingen z. B. eine Eindeutigkeitsbeschränkung, die jedes Element an der frühestmöglichen Position im Slot platziert.)


Die Implementierung dieser Methoden hängt vom Slot ab (und ist dafür verantwortlich, auf den richtigen Teil der Klassen- oder Objektdefinition zuzugreifen). Slots haben auch einen Unknown-Methoden-Handler, der all diese Teile zusammenführt, und verbergen ihre Methode **destroy**, damit sie nicht versehentlich aufgerufen wird. Es wird *empfohlen*, Benutzeränderungen am Slot-Mechanismus selbst auf die Definition neuer Operationen zu beschränken, deren Namen mit einem Bindestrich beginnen.

Beachten Sie, dass Slot-Instanzen nicht erwartungsgemäß den Speicher für den von ihnen verwalteten Slot enthalten; der befindet sich in oder ist an die verwaltete Klasse bzw. das verwaltete Objekt angehängt. Diese Instanzen sollten eigene Implementierungen der Methoden **Get** und **Set** bereitstellen (optional **Resolve**; standardmäßig eine durchreichende No-Op-Implementierung).

::: {.info -version="TIP516"}
Die meisten Slot-Operationen wenden zunächst **Resolve** auf ihre Argumentliste an, kombinieren das Ergebnis mit den Ergebnissen der Methode **Get** und rufen anschließend **Set** auf. Manche Operationen lassen einen oder beide der ersten Schritte weg; das Weglassen des dritten würde zu einer idempotenten schreibgeschützten Operation führen (der Standardmechanismus zum Lesen von Slots erfolgt über **info class** und **info object**).
:::

# BEISPIELE

Dieses Beispiel zeigt die Verwendung beider Formen der Befehle **oo::define** und **oo::objdefine** (sie funktionieren gleich) und veranschaulicht vier ihrer Unterbefehle.

```
oo::class create c
c create o
oo::define c method foo {} {
    puts "world"
}
oo::objdefine o {
    method bar {} {
        my Foo "hello "
        my foo
    }
    forward Foo ::puts -nonewline
    unexport foo
}
o bar                → prints "hello world"
o foo                → error "unknown method foo"
o Foo Bar            → error "unknown method Foo"
oo::objdefine o renamemethod bar lollipop
o lollipop           → prints "hello world"
```

Dieses Beispiel zeigt, wie zusätzliche Klassen in ein Objekt eingemischt werden können. Es zeigt auch, dass **mixin** ein Slot ist, der Anhängen unterstützt:

```
oo::object create inst
inst m1              → error "unknown method m1"
inst m2              → error "unknown method m2"

oo::class create A {
    method m1 {} {
        puts "red brick"
    }
}
oo::objdefine inst {
    mixin A
}
inst m1              → prints "red brick"
inst m2              → error "unknown method m2"

oo::class create B {
    method m2 {} {
        puts "blue brick"
    }
}
oo::objdefine inst {
    mixin -append B
}
inst m1              → prints "red brick"
inst m2              → prints "blue brick"
```

::: {.info -version="TIP478"}
Dieses Beispiel zeigt, wie Klassenvariablen erzeugt und verwendet werden. Es ist eine Klasse, die zählt, wie viele Instanzen von sich selbst erzeugt wurden.
:::

```
oo::class create Counted
oo::define Counted {
    initialise {
        variable count 0
    }

    variable number
    constructor {} {
        classvariable count
        set number [incr count]
    }

    method report {} {
        classvariable count
        puts "This is instance $number of $count"
    }
}

set a [Counted new]
set b [Counted new]
$a report
        → This is instance 1 of 2
set c [Counted new]
$b report
        → This is instance 2 of 3
$c report
        → This is instance 3 of 3
```

::: {.info -version="TIP478"}
Dieses Beispiel zeigt die Verwendung von Klassenmethoden. (Beachten Sie, dass der Konstruktor von **oo::class** **oo::define** auf der Klasse aufruft.)
:::

```
oo::class create DBTable {
    classmethod find {description} {
        puts "DB: locate row from [self] matching $description"
        return [my new]
    }
    classmethod insert {description} {
        puts "DB: create row in [self] matching $description"
        return [my new]
    }
    method update {description} {
        puts "DB: update row [self] with $description"
    }
    method delete {} {
        puts "DB: delete row [self]"
        my destroy; # Nur das Objekt löschen, nicht die DB-Zeile
    }
}

oo::class create Users {
    superclass DBTable
}
oo::class create Groups {
    superclass DBTable
}

set u1 [Users insert "username=abc"]
        → DB: create row from ::Users matching username=abc
set u2 [Users insert "username=def"]
        → DB: create row from ::Users matching username=def
$u2 update "group=NULL"
        → DB: update row ::oo::Obj124 with group=NULL
$u1 delete
        → DB: delete row ::oo::Obj123
set g [Group find "groupname=webadmins"]
        → DB: locate row ::Group with groupname=webadmins
$g update "emailaddress=admins"
        → DB: update row ::oo::Obj125 with emailaddress=admins
```

::: {.info -version="TIP524"}
Dieses Beispiel zeigt, wie eine benutzerdefinierte Definition für eine Klasse erstellt wird. Beachten Sie, dass es ausdrücklich die Delegation an die vorhandenen Definitionsbefehle über **namespace path** einschließt.
:::

```
namespace eval myDefinitions {
    # An vorhandene Definitionen delegieren, wo nicht überschrieben
    namespace path ::oo::define

    # Ein benutzerdefinierter Methodentyp
    proc exprmethod {name arguments body} {
        tailcall method $name $arguments [list expr $body]
    }

    # Ein benutzerdefinierter Weg, einen Konstruktor zu bauen
    proc parameters args {
        uplevel 1 [list variable {*}$args]
        set body [join [lmap a $args {
            string map [list VAR $a] {
                set [my varname VAR] [expr {double($VAR)}]
            }
        }] ";"]
        tailcall constructor $args $body
    }
}

# Den Namespace in eine (sehr einfache) Metaklasse zur Nutzung einbinden
oo::class create exprclass {
    superclass oo::class
    definitionnamespace myDefinitions
}

# Die benutzerdefinierten Definitionen verwenden
exprclass create quadratic {
    parameters a b c
    exprmethod evaluate {x} {
        ($a * $x**2) + ($b * $x) + $c
    }
}

# Die resultierende Klasse und das Objekt in Aktion zeigen
quadratic create quad 1 2 3
for {set x 0} {$x <= 4} {incr x} {
    puts [format "quad(%d) = %.2f" $x [quad evaluate $x]]
}
        → quad(0) = 3.00
        → quad(1) = 6.00
        → quad(2) = 11.00
        → quad(3) = 18.00
        → quad(4) = 27.00
```
