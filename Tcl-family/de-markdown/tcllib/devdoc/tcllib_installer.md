---
CommandName: tcllib_install_guide
title: tcllib_install_guide
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription:
Copyright:
---

# Name

tcllib\_install\_guide – Tcllib – Anleitung für Installateure

# Beschreibung

Willkommen bei Tcllib, der Tcl-Standardbibliothek. Beachten Sie, dass Tcllib selbst kein Paket ist. Es handelt sich um eine Sammlung von (teilweise unabhängigen) *Tcl*-Paketen, die Hilfsfunktionen bereitstellen, die für eine große Zahl von Tcl-Programmierern nützlich sind.

Dieses Dokument richtet sich an alle, die die in Tcllib enthaltenen Pakete kompilieren und installieren möchten – sei es für sich selbst oder für andere.

Darüber hinaus bieten wir Folgendes an:

1. *Tcllib – Das Entwicklerhandbuch*.


Für Entwickler, die selbst an den Paketen arbeiten möchten.

Bitte lesen Sie zunächst *Tcllib – So erhalten Sie die Quellcodes*, falls das noch nicht geschehen ist. Hier wird davon ausgegangen, dass die Quelltexte bereits in einem Verzeichnis der Wahl vorliegen.

# Voraussetzungen

Bevor Tcllib kompiliert und verwendet werden kann, müssen einige Voraussetzungen installiert werden. Diese sind:

1. Die Skriptsprache Tcl. Weitere Informationen finden Sie unter [Tcl].

2. Optional das Paket [Critcl] (C-Einbettung) für [Tcl]. Einzelheiten finden Sie unter **CriTcl**.


Diese Liste geht davon aus, dass der Rechner, auf dem Tcllib installiert werden soll, im Wesentlichen leer ist. Wenn Teile der unten aufgeführten Abhängigkeiten bereits installiert sind, können die entsprechenden Schritte natürlich übersprungen werden. Es wird jedoch weiterhin empfohlen, die entsprechenden Abschnitte zu lesen, um sicherzustellen, dass die dort genannten Abhängigkeiten tatsächlich installiert sind.

## Tcl

Da wir eine Reihe von Tcl-Paketen und -Anwendungen installieren, dürfte es ziemlich offensichtlich sein, dass eine funktionierende Installation von Tcl selbst erforderlich ist, und ich werde nicht weiter darauf eingehen.

Wählen Sie aus den zahlreichen Möglichkeiten diejenige aus, mit der Sie am besten zurechtkommen, solange sie mindestens Tcl 8.2 oder höher bereitstellt. Dabei kann es sich um eine Tcl-Installation handeln, die von Ihrer Betriebssystemdistribution bereitgestellt wird, von einem distributionsunabhängigen Anbieter stammt oder von Ihnen selbst erstellt wurde.

*Beachten Sie*, dass die Pakete in Tcllib mittlerweile die Versionen 8.4, 8.5 und sogar 8.6 erfordern. Ältere Tcl-Versionen können solche Pakete nicht verwenden. Der Versuch, sie zu nutzen, führt zu Fehlern der Art *Paket nicht gefunden*, da ihre Indexdateien diese Pakete in Kernversionen, die sie nicht unterstützen, nicht registrieren.

Ich selbst habe während der Entwicklung die [ActiveState's](http://www.activestate.com) ActiveTcl 8.5-Distribution verwendet (und tue dies nach wie vor), da ich mit dieser am besten vertraut bin.

*(Offenlegung: Ich, Andreas Kupries, war bis 2016 bei ActiveState beschäftigt und habe dort die Pflege von ActiveTcl und TclDevKit übernommen).*. Derzeit bin ich bei SUSE Software Canada ULC tätig, allerdings nicht in Bereichen, die mit Tcl zu tun haben.

Diese Distribution finden Sie unter <http://www.activestate.com/activetcl>. Laden Sie das Archiv von ActiveTcl 8.5 (oder höher) für Ihre Plattform herunter und installieren Sie es gemäß den Anweisungen von ActiveState.

Für diejenigen, die Tcl selbst kompilieren und installieren möchten, finden Sie die entsprechenden Quelldateien unter

Tcl
: <http://core.tcl-lang.org/tcl/>


zusammen mit den erforderlichen Anweisungen zur Kompilierung.

Wenn Probleme beim Kompilieren, Installieren oder Verwenden von Tcl auftreten, reichen Sie bitte ein Ticket bei *Tcl* oder beim Anbieter Ihrer Distribution ein, *nicht* bei *Tcllib*.

## Critcl

Das Tool **critcl** ist eine *optionale* Abhängigkeit.

Dies ist nur erforderlich, wenn Sie versuchen, die C-basierten *Beschleuniger* für eine Reihe von Paketen zu erstellen, wie unter [Critcl und Beschleuniger] erläutert.

*Vorsicht*: Die C-Beschleuniger werden *standardmäßig gebaut*.

Unter Unix sucht das Build-System von Tcllib (**sak.tcl**) unter dem Namen **critcl**.

Unter Windows hingegen ist die Suche komplexer. Das Build-System sucht zunächst nach einer geeigneten Anwendung **critcl.exe**. Wird diese nicht gefunden, sucht es stattdessen nach einer Kombination aus Interpreter (**tclkitsh.exe**, **tclsh.exe**) und Starkit (**critcl.kit**, **critcl**). *Beachten Sie*, dass die Auswahl des Starkits über die Umgebungsvariable überschrieben werden kann.

Für Tcllib 1.21 und ältere Versionen ist Critcl Version 2 oder höher eine Anforderung.

Tcllib 2.0 und neuere Versionen haben hingegen die Anforderung an Critcl Version 3.3 oder höher.

[Critcl](https://andreas-kupries.github.io/critcl) stellt diese Veröffentlichungen und die zugehörigen Quellen bereit.

Es kann jeder Zweig des Repositorys verwendet werden (wenn nicht das vorgefertigte „starkit“ oder „starpack“ zum Einsatz kommt), wobei die Verwendung des stabilen Zweigs *master* empfohlen wird.

Unter der oben genannten URL finden Sie zudem eine Anleitung zum Kompilieren und Installieren von Critcl, einschließlich einer Liste der erforderlichen Abhängigkeiten.

Die Anleitung dazu wird hier nicht wiederholt. Wenn bei dieser Anleitung Probleme auftreten, reichen Sie bitte ein Ticket für das Projekt *Critcl* ein, nicht für Tcllib.

# Bau- und Installationsanleitung

Da es sich bei Tcllib im Wesentlichen um eine Sammlung von Paketen handelt, die in reinem Tcl geschrieben sind, entspricht das Erstellen derselben der Installation. Die Ausnahmen hiervon werden später in einem eigenen Unterabschnitt, [Critcl und Beschleuniger], behandelt.

Zuvor gilt jedoch der Standardfall, der sich je nach Plattform durch wesentliche Unterschiede in der Anleitung auszeichnet, d. h. *Unix*-like im Vergleich zu *Windows*.

In Bezug auf Letzteres gibt es zudem einen Hinweis: Es ist möglich, eine *Unix*-like-Umgebung mithilfe von Projekten wie *MSYS*, *Cygwin* und anderen einzurichten. In diesem Fall hat der Benutzer die Wahl, welche Anweisungen er befolgen möchte.

Unabhängig von der Umgebung oder der Plattform muss ein geeignetes *Tcl* installiert sein, und dessen **tclsh** sollte (*Unix*) im Suchpfad liegen oder mit „*.tcl*“-Dateien (*Windows*) verknüpft sein.

## Installation unter Unix

In *Unix*-like-Umgebungen wird Tcllib mit dem Standard-Dateisatz ausgeliefert, um

```
  ./configure
  make install
  # or just
  make
```

eine geeignete Methode zur Installation. Hierbei handelt es sich um eine standardmäßige, nicht-interaktive Installation, bei der automatisch ermittelt wird, wo alles platziert werden soll, d. h. Pakete, Anwendungen und die Manpages.

*Dies umfasst das Tcllibc-Paket*. Daher ist eine Installation von Critcl erforderlich.

Um nur bestimmte Teile des Projekts zu installieren, verwenden Sie

```
  make install-binaries      # Tcllibc. Requires an installation of Critcl.
  make install-tcl           # Tcl packages and applications.
  make install-libraries     # Tcl packages alone.
  make install-applications  # Applications alone.
  make install-doc           # Nroff manpages.
```

Für ein grafisches Installationsprogramm stattdessen:

```
  ./installer.tcl
```

*Beachten Sie* jedoch, dass dieses Installationsprogramm lediglich die Tcl-Pakete, Anwendungen und die Dokumentation abdeckt. Die binäre Tcllibc deckt es *nicht* ab.

## Installation unter Windows

In einer Windows-Umgebung steht das Skript „**installer.tcl**“ zur Durchführung der Installation zur Verfügung.

Wenn die „*.tcl*“-Dateien dem gewünschten **tclsh** zugeordnet sind, reicht ein Doppelklick bzw. das Öffnen von **installer.tcl** aus, um das Programm im grafischen Modus zu starten. Dies setzt voraus, dass *Tk* ebenfalls installiert und verfügbar ist.

Ohne *Tk* besteht die einzige Möglichkeit, das Installationsprogramm aufzurufen, darin, ein DOS-Fenster zu öffnen, d. h. **cmd.exe**, und anschließend folgenden Befehl auszuführen:

```
  ./installer.tcl
```

darin. *Beachten Sie*, dass dieses Installationsprogramm ausschließlich die Tcl-Pakete, Anwendungen und die Dokumentation verwaltet. Die binäre Tcllibc wird *nicht* berücksichtigt.

## Critcl und Beschleuniger

Zwar besteht der Großteil von Tcllib aus Paketen, die in reinem Tcl geschrieben sind, doch gibt es auch eine Reihe von Paketen, denen sogenannte *Beschleuniger* zugeordnet sind.

Es handelt sich hierbei um auf **critcl** basierende C-Pakete, deren Verwendung die Leistung der Pakete, die sie nutzen, steigert. Sie werden zwar unter Unix standardmäßig kompiliert (siehe *make install*), sind jedoch nicht erforderlich, sondern *optional*.

Beim Erstellen der Beschleuniger wird die normalerweise optionale Abhängigkeit von **critcl** zur Anforderung. Wenn diese gemäß den nachstehenden Anweisungen erstellt werden, werden sie zudem ebenfalls installiert.

Um Tcllib mit den Beschleunigern in einer Unix-ähnlichen Umgebung zu kompilieren und zu installieren, führen Sie folgenden Befehl aus:

```
  ./configure
  make
  # or
  make install
  # or
  make install-binaries
```

Das zugrunde liegende Tool ist „*sak.tcl*“ im Toplevel-Verzeichnis von Tcllib, und das Ziel „**make install-binaries**“ ist lediglich eine Hülle um

```
  ./sak.tcl critcl
```

Rufen Sie daher in einer Windows-Umgebung stattdessen folgenden Befehl auf:

```
  ./sak.tcl critcl
  ./installer.tcl
```

aus einem DOS-Fenster heraus, d. h. **cmd.exe**.

*Vorsicht*: Die durch diese Befehlsfolge erzeugte Verzeichnisstruktur unterscheidet sich von der durch **make install** und dessen Varianten erzeugten.

**make install** erstellt zwei Verzeichnisse für Pakete, eines für Tcllib und das andere für Tcllibc.

Die oben genannte Folge legt „Tcllibc“ hingegen in ein Unterverzeichnis des Tcllib-Paketverzeichnisses.

## Werkzeuge

Das Herzstück des Build-Systems von Tcllib ist das Skript „*installer.tcl*“, das sich im Toplevel-Verzeichnis eines Checkouts oder einer Version befindet.

Die den Entwicklern auf Unix-ähnlichen Systemen zur Verfügung stehende Einrichtung

```
         configure ; make install
```

ist lediglich eine Hülle um dieses Skript. Um über die in dieser Hülle festgelegten Standards hinauszugehen, ist es erforderlich, dieses Skript direkt aufzurufen.

Auf Windows-Systemen ist die direkte Verwendung die einzige Möglichkeit, das Programm aufzurufen.

Um grundlegende Hilfe zu erhalten, rufen Sie das Programm wie folgt auf:

```
         ./installer.tcl -help
```

Dadurch wird eine kurze Liste aller verfügbaren Optionen auf den Standard-Ausgabekanal ausgegeben.

Die Befehle, die den verschiedenen *install*-Zielen im *Makefile.in* für Unix zugeordnet sind, können ebenfalls als weitere Beispiele für die Verwendung dieses Tools herangezogen werden.

Das Installationsprogramm kann im GUI- und im CLI-Modus ausgeführt werden. Standardmäßig wählt es den Modus automatisch aus, wenn das Tcl-Paket **Tk** verwendet werden kann oder nicht. Mit der Option **-no-gui** können Sie den CLI-Modus erzwingen.

Beachten Sie, dass Optionen über die Befehlszeile festgelegt werden können, selbst wenn das Installationsprogramm am Ende den GUI-Modus wählt. In diesem Fall bestimmen die fest vorgegebenen Standardwerte und die Optionen, welche Daten dem Benutzer zur Bearbeitung angezeigt werden.

Das Installationsprogramm führt eine Auswahl der Standardeinstellungen für die Speicherorte von Paketen, Beispielen und der Dokumentation sowie für das Format der Dokumentation durch. Der Benutzer kann diese Standardeinstellungen über die grafische Benutzeroberfläche oder durch Angabe zusätzlicher Optionen überschreiben. Die Standardeinstellungen hängen von der erkannten Plattform (Unix/Windows) sowie von der ausführbaren Datei „**tclsh**“ ab, die zum Ausführen des Installationsprogramms verwendet wird.

*Optionen*

**-help**
: Zeigt die Liste der hier erläuterten Optionen auf dem Standardausgabekanal an und beendet das Programm.

**+excluded**
: Veraltete Pakete in die Installation einbeziehen.

**-no-gui**
: Den Befehlszeilenbetrieb des Installationsprogramms erzwingen

**-no-wait**
: Im CLI-Modus fordert das Installationsprogramm den Benutzer standardmäßig auf, zu bestätigen, dass die gewählte Konfiguration (Zielpfade, zu installierende Komponenten) korrekt ist, bevor es weitere Schritte ausführt. Mit dieser Option überspringt das Installationsprogramm diese Abfrage und beginnt sofort mit der Installation.

**-app-path** *path*
: siehe unten ...

**-example-path** *path*
: siehe unten ...

**-html-path** *path*
: siehe unten ...

**-nroff-path** *path*
: siehe unten ...

**-pkg-path** *path*
: Legt die Zielpfade für die Anwendungen, Beispiele, die HTML-Dokumentation, die nroff-Manpages und die Pakete fest. Die Standardwerte leiten sich aus dem Speicherort der Datei „**tclsh**“ ab, die zum Ausführen des Installationsprogramms verwendet wurde.

**-dry-run**
: siehe unten ...

**-simulate**
: Führt das Installationsprogramm aus, ohne die Zielverzeichnisse zu ändern.

**-apps**
: siehe unten ...

**-no-apps**
: siehe unten ...

**-examples**
: siehe unten ...

**-no-examples**
: siehe unten ...

**-pkgs**
: siehe unten ...

**-no-pkgs**
: siehe unten ...

**-html**
: siehe unten ...

**-no-html**
: siehe unten ...

**-nroff**
: siehe unten ...

**-no-nroff**
: Schaltet die Installation von Anwendungen, Beispielen, Paketen, der HTML-Dokumentation und der nroff-Manpages aus oder ein.

    Anwendungen, Beispiele und Pakete werden standardmäßig installiert.

    Unter Windows wird die HTML-Dokumentation standardmäßig installiert.

    Unter Unix werden die nroff-Manpages standardmäßig installiert.
