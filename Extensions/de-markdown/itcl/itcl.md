---
CommandName: itcl
title: itcl
ManualSection: n
Version: 3.0
TclPart: itcl
TclDescription: "[incr Tcl]"
Keywords:
 - class
 - object
 - object-oriented
 - namespace
 - mega-widget
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

itcl - objektorientierte Erweiterungen für Tcl

# Beschreibung

**\[incr Tcl\]** stellt objektorientierte Erweiterungen für Tcl bereit, so wie C++ objektorientierte Erweiterungen für C bereitstellt. Der Schwerpunkt dieser Arbeit liegt jedoch nicht darin, eine aufsehenerregende Umgebung für objektorientierte Programmierung zu schaffen. Es geht vielmehr darum, in Tcl stärker strukturierte Programmierweisen zu unterstützen, ohne den Charakter der Sprache zu ändern. Vor allem anderen bietet **\[incr Tcl\]** ein Mittel, zusammengehörige Prozeduren samt ihren gemeinsamen Daten in einem Namespace zu kapseln, der vor der Außenwelt verborgen ist. Es fördert besseres Programmieren, indem es die objektorientierte Denkweise einer „Bibliothek“ nahelegt. Außerdem erlaubt es die Wiederverwendung von Code durch Vererbung.

# Klassen

Das grundlegende Konstrukt in **\[incr Tcl\]** ist die Klassendefinition. Jede Klasse dient als Vorlage für tatsächliche Objekte, die erzeugt werden können. Jedes Objekt hat sein eigenes Datenbündel, das Instanzen der in der Klasse definierten „variables“ enthält. Spezielle Prozeduren, „methods“ genannt, dienen dazu, einzelne Objekte zu bearbeiten. Methoden gleichen den Operationen, mit denen Tk-Widgets bedient werden. Das Widget „**button**“ hat zum Beispiel Methoden wie „flash“ und „invoke“, die eine bestimmte Schaltfläche blinken lassen und ihren Befehl auslösen.

Innerhalb des Rumpfes einer Methode stehen die in der Klasse definierten „variables“ automatisch zur Verfügung. Sie müssen nicht mit etwas wie dem Befehl **global** deklariert werden. Innerhalb einer anderen Klassenmethode lässt sich eine Methode wie jeder andere Befehl aufrufen, einfach über ihren Namen. Aus jedem anderen Zusammenhang muss dem Methodennamen ein Objektname vorangestellt werden, der den Zusammenhang für die Daten liefert, auf die die Methode zugreifen kann.

Jede Klasse hat ihren eigenen Namespace mit dem, was allen Objekten gemeinsam ist, die zur Klasse gehören. „common“-Datenelemente werden zum Beispiel von allen Objekten der Klasse geteilt. Es sind globale Variablen, die im Namespace der Klasse existieren; da sie in der Klassendefinition stehen, müssen sie nicht mit dem Befehl **global** deklariert werden. Sie stehen jedem Code automatisch zur Verfügung, der im Klassenkontext ausgeführt wird. Eine Klasse kann auch gewöhnliche globale Variablen anlegen, diese müssen aber bei jeder Verwendung mit dem Befehl **global** deklariert werden.

Klassen können auch gewöhnliche Prozeduren haben, die als „procs“ deklariert sind. Innerhalb einer anderen Klassenmethode oder eines proc lässt sich ein proc wie jeder andere Befehl aufrufen, einfach über seinen Namen. Aus jedem anderen Zusammenhang sollte der Prozedurname mit dem Namespace der Klasse qualifiziert werden, wie „*className*__::__*proc*“. Klassen-procs werden im Klassenkontext ausgeführt und haben deshalb automatischen Zugriff auf alle „common“-Datenelemente. Auf objektspezifische „variables“ können sie jedoch nicht zugreifen, weil sie ohne Bezug auf ein bestimmtes Objekt aufgerufen werden. Sie dienen gewöhnlich dazu, allgemeine Operationen auszuführen, die alle zur Klasse gehörenden Objekte betreffen.

Jedes der Elemente einer Klasse kann als „public“, „protected“ oder „private“ deklariert werden. Auf öffentliche Elemente können die Klasse, abgeleitete Klassen (andere Klassen, die diese Klasse erben) und externe Aufrufer zugreifen, die die Klasse verwenden. Auf geschützte Elemente können die Klasse und abgeleitete Klassen zugreifen. Private Elemente sind nur in der Klasse zugänglich, in der sie definiert sind.

Die „public“-Elemente einer Klasse legen ihre Schnittstelle zur Außenwelt fest. Öffentliche Methoden legen die Operationen fest, mit denen sich ein Objekt bedienen lässt. Öffentliche Variablen erkennen die Methoden „configure“ und „cget“, die in jede Klasse eingebaut sind, als Konfigurationsoptionen. Die öffentliche Schnittstelle sagt, *was* ein Objekt tun wird, aber nicht, *wie* es das tun wird. Geschützte und private Mitglieder liefern zusammen mit den Rümpfen der Klassenmethoden und procs die Einzelheiten der Umsetzung. Wenn der Anwendungsentwickler von diesen Einzelheiten abgeschirmt ist, kann der Entwerfer der Klasse sie jederzeit ohne Vorwarnung ändern, ohne Programme zu beeinträchtigen, die sich auf die Klasse stützen. Genau diese Kapselung macht objektorientierte Programme leichter zu verstehen und zu warten.

Dass Objekte von **\[incr Tcl\]** wie Tk-Widgets aussehen, ist kein Zufall. **\[incr Tcl\]** wurde so entworfen, dass es sich natürlich in eine Tcl/Tk-Anwendung einfügt. **\[incr Tcl\]** erweitert das Paradigma von Tk aber davon, nur objektbasiert zu sein, dahin, vollständig objektorientiert zu sein. Ein objektorientiertes System unterstützt die Vererbung und erlaubt Klassen, gemeinsames Verhalten zu teilen, indem sie es von einer Vorfahrenklasse oder Basisklasse erben. Eine Basisklasse als gemeinsame Abstraktion erlaubt es, verwandte Klassen auf ähnliche Weise zu behandeln. Ein Toaster und ein Mixer erfüllen zum Beispiel verschiedene (spezialisierte) Funktionen, teilen aber die Abstraktion, Geräte zu sein. Wenn gemeinsames Verhalten in eine Basisklasse gezogen wird, lässt sich Code *teilen* statt *kopieren*. Die entstehende Anwendung ist leichter zu verstehen und zu warten, und abgeleitete Klassen (zum Beispiel spezialisierte Geräte) lassen sich leichter hinzufügen oder entfernen.

Diese Beschreibung war nur ein kurzer Überblick über objektorientierte Programmierung und **\[incr Tcl\]**. Eine stärker Lehrbuch-artige Einführung steht in dem Papier, das dieser Distribution beiliegt. Weitere Einzelheiten zum Erzeugen und Verwenden von Klassen stehen beim Befehl **class**.

# Namespaces

**\[incr Tcl\]** enthält inzwischen eine vollständige Einrichtung für Namespaces. Ein Namespace ist eine Sammlung von Befehlen und globalen Variablen, die vom gewöhnlichen globalen Geltungsbereich getrennt gehalten wird. Dadurch lassen sich Bibliotheken mit Tcl-Code auf festgelegte Weise als Paket fassen, und unerwünschte Wechselwirkungen mit anderen Bibliotheken werden verhindert. Ein Namespace kann auch Kind-Namespaces in sich enthalten, sodass eine Bibliothek ihre eigene private Kopie vieler anderer Bibliotheken enthalten kann. Ein Namespace kann auch eine Gruppe verwandter Klassen zusammenfassen. Der globale Geltungsbereich (namens "**::**") ist der Wurzel-Namespace eines Interpreters; alle anderen Namespaces sind in ihm enthalten.

Einzelheiten zum Erzeugen und Verwenden von Namespaces stehen beim Befehl **namespace**.

# Megawidgets

Megawidgets sind Widgets auf hoher Ebene, die aus Tk-Widgets als Komponenten gebaut werden, gewöhnlich ohne C-Code. Eine Dateiauswahlbox kann zum Beispiel einige Listboxen, einige Entry-Widgets und einige Steuerschaltflächen enthalten. Diese einzelnen Widgets werden so zusammengesetzt, dass sie wie ein großes Widget wirken.

**\[incr Tk\]** ist ein Rahmen für den Bau von Megawidgets. Es verwendet **\[incr Tcl\]**, um das Objektparadigma zu unterstützen, und fügt Basisklassen hinzu, die das voreingestellte Widget-Verhalten liefern. Weitere Einzelheiten stehen auf der Handbuchseite von **itk**.

**\[incr Widgets\]** ist eine Bibliothek von Megawidgets, die mit **\[incr Tk\]** gebaut ist. Sie enthält mehr als 30 verschiedene Widget-Klassen, die sich sofort einsetzen lassen, um Tcl/Tk-Anwendungen zu bauen. Jede Widget-Klasse hat eine eigene Handbuchseite, die die verfügbaren Merkmale beschreibt.
