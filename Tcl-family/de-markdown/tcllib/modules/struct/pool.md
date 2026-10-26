---
CommandName: struct::pool
ManualSection: n
Version: 1.2.4
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - discrete items
 - finite
 - pool
 - struct
Copyright:
 - Copyright (c) 2002, Erik Leunissen <e.leunissen@hccnet.nl>
---

# NAME

struct::pool – Pool-Objekte (aus einzelnen Elementen) anlegen und bearbeiten

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [struct::pool]{.lit} [1.2.4]{.optlit} 
[::struct::pool]{.cmd} [poolName]{.optarg} [maxsize]{.optarg} 
[poolName]{.cmd} [option]{.arg} [arg arg]{.optdot} 
[poolName]{.ins} [add]{.sub} [itemName1]{.arg} [itemName2 itemName3]{.optdot} 
[poolName]{.ins} [clear]{.sub} [-force]{.optlit} 
[poolName]{.ins} [destroy]{.sub} [-force]{.optlit} 
[poolName]{.ins} [info]{.sub} [type]{.arg} [arg]{.optarg} 
[poolName]{.ins} [maxsize]{.sub} [maxsize]{.optarg} 
[poolName]{.ins} [release]{.sub} [itemName]{.arg} 
[poolName]{.ins} [remove]{.sub} [itemName]{.arg} [-force]{.optlit} 
[poolName]{.ins} [request]{.sub} itemVar [options]{.optarg} 
:::

# BESCHREIBUNG

Dieses Paket stellt Pool-Objekte bereit, mit denen sich endliche Sammlungen diskreter Elemente verwalten lassen.

**::struct::pool** ?*poolName*? ?*maxsize*?
: Erstellt ein neues Pool-Objekt. Wird kein *poolName* angegeben, erhält der neue Pool den Namen „pool**X**“, wobei X eine positive ganze Zahl ist. Das optionale zweite Argument *maxsize* muss eine positive ganze Zahl sein, die die maximale Größe des Pools angibt; dies ist die maximale Anzahl von Elementen, die der Pool enthalten darf. Der Standardwert hierfür lautet **10**. Dem Pool-Objekt ist ein globaler Tcl-Befehl zugeordnet, dessen Name *poolName* lautet. Mit diesem Befehl lassen sich verschiedene Konfigurationsoperationen auf dem Pool aufrufen. Er hat die folgende allgemeine Form:


**poolName** *option* ?*arg arg ...*?
: *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Eine detaillierte Auflistung der Optionen und ihrer Funktionsweise finden Sie im Abschnitt **POOL-OBJEKTBEFEHL**.


# POOLS UND ZUTEILUNG

Der Befehl pool und der von ihm erzeugte Pool-Objektbefehl dienen dazu, Pools aus einzelnen Elementen zu verwalten. Beispiele für einen Pool aus einzelnen Elementen sind:

**•**
: die Plätze in einem Kino, Theater, Zug usw., die Besucher bzw. Reisende reservieren können;

**•**
: die dynamischen IP-Adressen, die ein Internetdienstanbieter an seine Kunden vergeben kann;

**•**
: die Fahrzeugflotte eines Autovermieters, die von Kunden gemietet werden kann;

**•**
: die Klassenräume in einem Schulgebäude, die eingeplant werden müssen;

**•**
: die Datenbankverbindungen, die den Client-Threads einer Webserver-Anwendung zur Verfügung stehen;

**•**
: die Bücher in einer Bibliothek, die die Kunden ausleihen können;

**•**
: usw. … Der gemeinsame Nenner dieser Beispiele besteht darin, dass es eine mehr oder weniger feste Anzahl von Elementen (Sitzplätze, IP-Adressen, Autos, …) gibt, die mehr oder weniger regelmäßig zugewiesen werden sollen. Ein Element kann jeweils nur einmal zugewiesen sein. Ein zugewiesenes Element muss freigegeben werden, bevor es erneut zugewiesen werden kann. Während laufend Elemente eines Pools zugewiesen und freigegeben werden, bleibt die Gesamtzahl der Elemente im Pool konstant. Festzuhalten, welche Elemente zugewiesen sind und an wen, ist der Zweck des Befehls pool und der ihm untergeordneten Befehle. *Pool-Fachsprache*: Wenn wir sagen, dass ein Element *zugewiesen* ist, bedeutet dies, dass das Element *belegt*, *im Besitz* oder *besetzt* ist; es steht nicht mehr zur Verfügung. Wenn ein Element *frei* ist, ist es *verfügbar*. Ein Element freizugeben (deallocate) heißt dasselbe wie es freizusetzen oder zurückzugeben. Von der Person oder Stelle, der das Element zugeteilt wurde, sagt man, sie besitze das Element.


# ELEMENTE

*Diskrete Elemente*

Der Befehl **pool** ist *ausschließlich für diskrete Elemente* vorgesehen. Beachten Sie, dass es Pools gibt, bei denen die Zuweisung auf nicht-diskreter Basis erfolgt, beispielsweise beim Computerspeicher. Es gibt zudem Pools, aus denen die zugeteilten Anteile voraussichtlich nicht zurückgegeben werden, wie beispielsweise ein Wohltätigkeitsfonds oder eine Suppenschüssel, aus der Sie eine Portion erhalten können. Schließlich gibt es sogar Pools, aus denen niemals etwas zugeteilt oder zurückgegeben wird, wie beispielsweise ein Schwimmbecken oder eine Klärgrube.

*Eindeutige Elementnamen*

Ein Pool kann keine doppelten Namen für Elemente verarbeiten. Daher müssen die Elemente in einem Pool eindeutige Namen haben.

*Gleichwertigkeit der Elemente*

Aus Sicht des Verwalters eines Pools sind die Elemente gleichwertig. Dem Verwalter eines Pools ist es gleichgültig, welche Entität bzw. Person ein bestimmtes Element belegt. Kunden können jedoch aufgrund einer ihnen bekannten Eigenschaft des Elements Präferenzen für ein bestimmtes Element haben.

*Präferenzen*

Ein künftiger Besitzer bevorzugt möglicherweise ein bestimmtes Element. Eine Zuweisung nach Präferenz wird unterstützt (siehe die Option **-prefer** des Unterbefehls request). Eine Präferenz für ein bestimmtes Element ergibt sich meist daraus, dass sich die Merkmale der Elemente unterscheiden. Beachten Sie, dass die Pool-Befehle selbst nicht dafür ausgelegt sind, solche Elementeigenschaften zu verwalten. Wenn Elementeigenschaften in einer Anwendung eine Rolle spielen, sollten sie separat verwaltet werden.

# POOL-OBJEKTBEFEHL

Die folgenden Unterbefehle und die dazugehörigen Argumente stehen für jeden Pool-Objektbefehl zur Verfügung.

*poolName* **add** *itemName1* ?*itemName2 itemName3 ...*?
: Dieser Befehl fügt die in der Befehlszeile angegebenen Elemente dem Pool hinzu. Sollten in der Befehlszeile doppelte Elementnamen vorkommen, wird ein Fehler ausgelöst. Sollten eines oder mehrere der Elemente bereits im Pool vorhanden sein, wird dies ebenfalls als Fehler gewertet.

*poolName* **clear** ?**-force**?
: Entfernt alle Elemente aus dem Pool. Sollten zum Zeitpunkt der Ausführung des Befehls bereits Elemente zugewiesen sein, wird ein Fehler ausgelöst. Dieses Verhalten kann über das Argument **-force** geändert werden. Wird dieses Argument in der Befehlszeile angegeben, wird der Pool unabhängig vom Zuweisungsstatus seiner Elemente geleert.

*poolName* **destroy** ?**-force**?
: Löscht die Pool-Datenstruktur, alle zugehörigen Variablen sowie den zugehörigen Pool-Objektbefehl. Standardmäßig prüft der Befehl, ob noch Elemente zugewiesen sind, und löst in diesem Fall einen Fehler aus. Dieses Verhalten kann über das Argument **-force** geändert werden. Wenn dieses Argument in der Befehlszeile angegeben wird, wird die Pool-Datenstruktur unabhängig vom Zuweisungsstatus ihrer Elemente zerstört.

*poolName* **info** *type* ?*arg*?
: Gibt verschiedene Informationen zum Pool für die weitere programmatische Verwendung zurück. Das Argument *type* gibt die Art der angeforderten Informationen an. Lediglich der Typ **allocID** verwendet ein zusätzliches Argument.


**allocID** *itemName*
: gibt die allocID des Elements mit dem Namen *itemName* zurück. Freie Elemente haben die Zuweisungs-ID **-1**.

**allitems**
: gibt eine Liste aller Elemente im Pool zurück.

**allocstate**
: Gibt eine Liste von Schlüssel-Wert-Paaren zurück; die Schlüssel sind die Elemente, die Werte die zugehörigen Zuweisungs-IDs. Freie Elemente haben die Zuweisungs-ID **-1**.

**cursize**
: gibt die aktuelle Poolgröße zurück, d. h. die Anzahl der Elemente im Pool.

**freeitems**
: gibt eine Liste von Elementen zurück, die derzeit nicht zugewiesen sind.

**maxsize**
: gibt die maximale Größe des Pools zurück.


*poolName* **maxsize** ?*maxsize*?
: Legt die maximale Größe des Pools fest oder fragt diese ab, je nachdem, ob das Argument *maxsize* angegeben wird oder nicht. Wird *maxsize* angegeben, wird die maximale Größe des Pools auf diesen Wert gesetzt. Wird kein Argument angegeben, gibt der Befehl die aktuelle maximale Größe des Pools zurück. In dieser Variante ist der Befehl ein Alias für: **poolName info maxsize**. Das Argument *maxsize* muss eine positive ganze Zahl sein.

*poolName* **release** *itemName*
: Gibt das zuvor zugewiesene Element mit dem Namen *itemName* frei. Es wird ein Fehler ausgelöst, wenn das Element zum Zeitpunkt der Befehlsausführung nicht zugewiesen war.

*poolName* **remove** *itemName* ?**-force**?
: Entfernt das Element mit dem Namen *itemName* aus dem Pool. War das Element zum Zeitpunkt der Ausführung des Befehls zugewiesen, wird ein Fehler ausgelöst. Dieses Verhalten kann über das optionale Argument **-force** geändert werden. Wird dieses Argument in der Befehlszeile angegeben, wird das Element unabhängig von seinem Zuweisungsstatus entfernt.

*poolName* **request** itemVar ?options?
: Bearbeitet eine Anforderung eines Elements und berücksichtigt dabei eine mögliche Präferenz für ein bestimmtes Element. Je nach Verfügbarkeit der Elemente gibt es zwei mögliche Ergebnisse:


**\[1\]**
: Die Anforderung wird erfüllt, ein Element wird zugewiesen, und die Variable, deren Name mit dem Argument *itemVar* übergeben wird, wird auf den Namen des zugewiesenen Elements gesetzt. Der Befehl gibt den Wert 1 zurück.

**\[2\]**
: Die Anforderung wird abgelehnt. Es wird kein Element zugewiesen. Die Variable mit dem Namen itemVar wird nicht gesetzt. Versuche, *itemVar* zu lesen, können einen Fehler auslösen, wenn die Variable vor der Anforderung nicht definiert war. Der Befehl gibt den Wert 0 zurück.


Die Werte, die dieser Befehl zurückgibt, sind zur Überprüfung vorgesehen. Die folgenden Beispiele zeigen, wie dies geschieht. Wird der Wert nicht überprüft, kann dies zu fehlerhaftem Verhalten führen. Wird über die Option **-prefer** (siehe unten) keine Präferenz für ein bestimmtes Element angegeben, werden alle Anforderungen erfüllt, solange Elemente verfügbar sind.

Folgende Optionen werden unterstützt:

**-allocID** *allocID*
: Wird die Anforderung erfüllt, wird ein Element der durch allocID bezeichneten Stelle zugewiesen. Wird der Zuweisungsstatus eines Elements abgefragt, wird diese Zuweisungs-ID zurückgegeben. Fehlt die Option **-allocID**, wird das Element an **dummyID** vergeben und gehört dann diesem. Zuweisungs-IDs können beliebige Werte sein, außer dem Wert -1, der für freie Elemente reserviert ist.

**-prefer** *preferredItem*
: Diese Option ändert die Zuweisungsstrategie wie folgt: Wenn das Element mit dem Namen *preferredItem* zum Zeitpunkt der Ausführung des Befehls nicht zugewiesen ist, wird die Anforderung erfüllt (Rückgabewert ist 1). Wenn das Element zum Zeitpunkt der Ausführung des Befehls bereits zugewiesen war, wird die Anforderung abgelehnt (Rückgabewert ist 0).


# BEISPIELE

Es werden zwei Beispiele vorgestellt. Das erste Beispiel simuliert eine schrittweise interaktive tclsh-Sitzung, in der jeder Schritt erläutert wird. Das zweite Beispiel veranschaulicht die Verwendung in einer Serveranwendung, die mit einer Backend-Anwendung kommuniziert.

*Beispiel 1*

Dieses Beispiel zeigt eine interaktive tclsh-Sitzung, die den Fall der Fahrzeugflotte einer Autovermietung behandelt. In zehn Schritten wird die Verwendung chronologisch erläutert, von der Erzeugung des Pools über die wichtigsten Phasen seiner Nutzung bis zur abschließenden Zerstörung.

*Randbemerkung:*

In diesem Beispiel werden Markennamen zur Kennzeichnung der verschiedenen Elemente verwendet. Ein Markenname könnte jedoch als Eigenschaft eines Elements betrachtet werden. Da der Befehl pool nicht für die Verwaltung von Eigenschaften von Elementen ausgelegt ist, müssen diese separat verwaltet werden. In diesem Fall sollten die Elemente neutralere Namen wie car1, car2, car3 usw. erhalten, und eine separate Datenbank oder ein Array sollte die den Auto-Bezeichnungen zugeordneten Markennamen enthalten.

```
     1. Load the package into an interpreter
     % package require pool
     0.1

     2. Create a pool object called `CarPool' with a maximum size of 55 items (cars):
     % pool CarPool 55
     CarPool

     4. Add items to the pool:
     % CarPool add Toyota Trabant Chrysler1 Chrysler2 Volkswagen

     5. Somebody crashed the Toyota. Remove it from the pool as follows:
     % CarPool remove Toyota

     6. Acquired a new car for the pool. Add it as follows:
     % CarPool add Nissan

     7. Check whether the pool was adjusted correctly:
     % CarPool info allitems
     Trabant Chrysler1 Chrysler2 Volkswagen Nissan
```

Hier wird die interaktive Sitzung kurz unterbrochen, um die Verwendung des Unterbefehls request in einem Programm zu zeigen:

```
     # Mrs. Swift needs a car. She doesn't have a preference for a
     # particular car. We'll issue a request on her behalf as follows:
     if { [CarPool request car -allocID "Mrs. Swift"] }  {
         # request was honoured, process the variable `car'
         puts "$car has been allocated to [CarPool info allocID $car]."
     } else {
         # request was denied
          puts "No car available."
     }
```

Beachten Sie, wie der Befehl **if** den vom Unterbefehl **request** zurückgegebenen Wert verwendet.

```
     # Suppose Mr. Wiggly has a preference for the Trabant:
     if { [CarPool request car -allocID "Mr. Wiggly" -prefer Trabant] }  {
         # request was honoured, process the variable `car'
         puts "$car has been allocated to [CarPool info allocID $car]."
     } else {
         # request was denied
          puts "The Trabant was not available."
     }
```

Weiter mit der interaktiven Sitzung:

```
     8. When the car is returned then you can render it available by:
     % CarPool release Trabant

     9. When done, you delete the pool.
     % CarPool destroy
     Couldn't destroy `CarPool' because some items are still allocated.

     Oops, forgot that Mrs. Swift still occupies a car.

     10. We force the destruction of the pool as follows:
     % CarPool destroy -force
```

*Beispiel 2*

Dieses Beispiel beschreibt den Fall, aus dem sich der Bedarf des Autors an einer Poolverwaltung ergab. Es handelt sich um ein Beispiel für eine Serveranwendung, die Anfragen von Client-Anwendungen entgegennimmt. Die Client-Anfragen werden an eine Backend-Anwendung weitergereicht, bevor das Ergebnis an die Client-Anwendung zurückgeht. In vielen Fällen gibt es mehrere gleichwertige Instanzen von Backend-Anwendungen, an die eine Client-Anfrage weitergeleitet werden kann. Die Dateideskriptoren, die die Kanäle zu diesen Backend-Instanzen identifizieren, bilden einen Verbindungspool. Eine bestimmte Verbindung kann jeweils nur einer einzigen Client-Anfrage zugewiesen werden.

```
     # Create the pool of connections (pipes)
     set maxpipes 10
     pool Pipes $maxpipes
     for {set i 0} {$i < $maxpipes} {incr i} {
         set fd [open "|backendApplication" w+]
         Pipes add $fd
     }

     # A client request comes in. The request is identified as `clientX'.
     # Dispatch it onto an instance of a back-end application
     if { [Pipes request fd -allocID clientX] } {
         # a connection was allocated
         # communicate to the back-end application via the variable `fd'
         puts $fd "someInstruction"
         # ...... etc.
     } else {
         # all connections are currently occupied
         # store the client request in a queue for later processing,
         # or return a 'Server busy' message to the client.
     }
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: pool* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Datenstrukturen

# COPYRIGHT

```
Copyright (c) 2002, Erik Leunissen <e.leunissen@hccnet.nl>
```
