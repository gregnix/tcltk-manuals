---
CommandName: tcllib_devguide
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription: 
Copyright:
---

# NAME

tcllib_devguide – Tcllib – Das Entwicklerhandbuch

# ÜBERSICHT

::: {.synopsis} :::
[Module]{.cmd} [name]{.arg} [code-action]{.arg} [doc-action]{.arg} [example-action]{.arg} 
[Application]{.cmd} [name]{.arg} 
[Exclude]{.cmd} [name]{.arg} 
:::

# BESCHREIBUNG

Willkommen bei Tcllib, der Tcl-Standardbibliothek. Beachten Sie, dass Tcllib selbst kein Paket ist. Es handelt sich um eine Sammlung von (teilweise unabhängigen) *Tcl*-Paketen, die Hilfsfunktionen bereitstellen, die für eine große Zahl von Tcl-Programmierern nützlich sind.

Dieses Dokument dient als Leitfaden für Entwickler, die an Tcllib arbeiten, d. h. für Betreuer, die Fehler beheben, den Funktionsumfang der Bibliothek erweitern usw.

Bitte lesen Sie

**\[1\]**
: *Tcllib – So erhalten Sie die Quelltexte* und

**\[2\]**
: Lesen Sie zunächst *Tcllib – Das Installationshandbuch*, wenn Sie dies noch nicht getan haben. Wir gehen hier davon aus, dass die Quelltexte bereits in einem Verzeichnis Ihrer Wahl verfügbar sind und dass Sie nicht nur wissen, wie man sie kompiliert und installiert, sondern auch über alle notwendigen Voraussetzungen verfügen, um dies tatsächlich zu tun. Insbesondere die Anleitung zu den Quelltexten erläutert auch, welches Quellcode-Verwaltungssystem verwendet wird, wo Sie es finden, wie Sie es einrichten usw.


# VERPFLICHTUNGEN

## Mitwirkender

Als Mitwirkender bei Tcllib verpflichten Sie sich zu Folgendem:

**\[1\]**
: Behalten Sie die in *Tcl Community – Freundliche Kommunikation* festgehaltenen Richtlinien im Hinterkopf. Der wichtigste Punkt, den Sie daraus mitnehmen sollten, ist, *freundlich miteinander umzugehen*.

**\[2\]**
: Ihre Beiträge werden unter einer BSD-/MIT-Lizenz veröffentlicht. Einzelheiten finden Sie unter *Tcllib – Lizenz*. Beiträge können Sie leisten, indem Sie Tickets in unseren Tracker eingeben, Patches, Code-Bundles oder Code-Zweige zur Einbindung bereitstellen oder Beiträge in den Tcllib-bezogenen Mailinglisten veröffentlichen.


## Betreuer

Wenn Sie ein oder mehrere Pakete zur vollständigen Aufnahme in Tcllib beisteuern, verpflichten Sie sich dazu,

**\[1\]**
: Behalten Sie die in *Tcl Community – Freundliche Kommunikation* (wie jeder Mitwirkende) festgehaltenen Richtlinien im Hinterkopf. Der wichtigste Punkt, den Sie daraus mitnehmen sollten, ist, *freundlich miteinander umzugehen*.

**\[2\]**
: Ihre Pakete werden unter einer BSD-/MIT-Lizenz verbreitet. Einzelheiten finden Sie unter *Tcllib – Lizenz*

**\[3\]**
: Wartung der neuen Pakete über einen Zeitraum von zwei Jahren gemäß den folgenden Regeln und Zuständigkeiten:


**\[1\]**
: Ein Betreuer kann nach Ablauf der vorgeschriebenen Frist nach eigenem Ermessen zurücktreten.

**\[2\]**
: Ein Betreuer kann vor Ablauf der vorgeschriebenen Amtszeit zurücktreten, sofern ein Nachfolger sofort zur Verfügung steht und sich bereit erklärt hat, die verbleibende Amtszeit sowie seine eigene vorgeschriebene Amtszeit (siehe unten) zu übernehmen.

**\[3\]**
: Wenn Sie Ihr Amt niederlegen, ohne dass ein Nachfolger die Betreuung übernimmt, müssen die betreffenden Pakete mit dem Kennzeichen **unmaintained** versehen werden.

**\[4\]**
: Wenn für ein Paket ein Ersatzbetreuer hinzugezogen wird, wird dieses (erneut) mit der Kennzeichnung **maintained** versehen. Ein Ersatzbetreuer unterliegt denselben Regeln wie der ursprüngliche Betreuer, mit der Ausnahme, dass die vorgeschriebene Betreuungsdauer auf ein Jahr verkürzt wird.

**\[5\]**
: Für jedes **unmaintained**-Paket kann ein Mitwirkender, der daran interessiert ist, dessen Betreuer zu werden, diese Rolle übernehmen, indem er das Paket unter Angabe seines Namens und seiner Kontaktdaten als **maintained** kennzeichnet und sich zur Einhaltung der Regeln für einen neuen Betreuer verpflichtet (siehe vorheriger Punkt).

**\[6\]**
: Bei jedem bereits vorhandenen **maintained**-Paket kann ein Mitwirkender, der daran interessiert ist, Mitbetreuer zu werden, diese Rolle mit Zustimmung des bzw. der bestehenden Betreuer übernehmen, wobei er sich zur Einhaltung der Regeln für einen neuen Betreuer verpflichtet (siehe die beiden vorangegangenen Punkte).


Zu den Aufgaben eines Betreuers gehören:

**\[1\]**
: Beobachtung des Ticket-Trackers von Tcllib hinsichtlich Fehlermeldungen, Fehlerbehebungen und Funktionswünschen im Zusammenhang mit den neuen Paketen.

**\[2\]**
: Prüfung der oben genannten Tickets, deren Ablehnung oder Bearbeitung

**\[3\]**
: Abstimmung und Austausch mit dem Einreicher des Tickets während der Entwicklung und/oder Umsetzung von Fehlerbehebungen.


**\[4\]**
: Befolgen Sie die **VERZWEIGUNGEN UND ARBEITSABLAUF** dieses Leitfadens.


# VERZWEIGUNGEN UND ARBEITSABLAUF

## Paketabhängigkeiten

Was Pakete und die Abhängigkeiten zwischen ihnen betrifft, nimmt Tcllib eine mittlere Position zwischen zwei Extremen ein:

**\[1\]**
: Auf der einen Seite eine Gruppe stark miteinander verknüpfter Pakete, die in der Regel von einem einzigen Autor für ein einzelnes Projekt erstellt wurden. Betrachtet man meine (Andreas Kupries) eigenen Arbeiten, so sind Beispiele hierfür [Marpa](https://core.tcl.tk/akupries/marpa/index), [CRIMP](https://core.tcl.tk/akupries/crimp/index), [Kinetcl](https://core.tcl.tk/akupries/kinetcl/index) usw. Bei jeder Änderung kümmert sich der Autor des Projekts um alle Anpassungen, die sich aus etwaigen durch diese Änderung verursachten Inkompatibilitäten im System ergeben.

**\[2\]**
: Auf der anderen Seite steht die Welt der halbunabhängigen Projekte zahlreicher verschiedener Autoren, in der die Autoren zwar wissen, von welchen Paketen ihre eigenen Entwicklungen abhängen, jedoch in der Regel nicht wissen, wer sonst noch von diesen Paketen abhängig ist. Das Beste, was ein Autor tun kann, der eine (inkompatible) Änderung an seinem Projekt vornimmt, ist erstens, solche Änderungen in irgendeiner Form anzukündigen, und zweitens, mithilfe der Versionsverwaltung den Code vor und nach der Änderung zu unterscheiden. Es obliegt dann der Community, sich anzupassen, sei es durch die Aktualisierung der eigenen Projekte auf die neue Version oder durch das Festhalten an der alten. Wie bereits erwähnt, befindet sich Tcllib genau in der Mitte dieses Spektrums. Während wir als Betreuer nicht alle Nutzer der Tcllib-Pakete kennen können und uns daher in dieser Hinsicht auf die in Punkt 2 oben angesprochenen Mechanismen verlassen müssen, stellen die Abhängigkeiten zwischen den in Tcllib enthaltenen Paketen eine andere Sache dar. Da wir gemeinsam für die Nutzbarkeit von Tcllib in seiner Gesamtheit gegenüber der Außenwelt verantwortlich sind, ist es unsere Pflicht, auch auf Tcllib-Pakete zu achten, die wir nicht direkt betreuen, wenn diese von Paketen abhängen, für deren Betreuung wir zuständig sind. Dies kann so einfach sein wie die Abstimmung mit den Betreuern der betroffenen Pakete. Es kann aber auch erfordern, dass wir entscheiden, wie wir betroffene Pakete ohne Betreuer anpassen – d. h. sie so ändern, dass sie unser geändertes Paket ordnungsgemäß nutzen, oder sie so ändern, dass sie ordnungsgemäß von der unveränderten Version unseres Pakets abhängen. Hinweise: Das oben Genannte ist nicht nur eine lästige Pflicht, sondern auch eine Chance. Zusätzliche Erkenntnisse lassen sich gewinnen, wenn wir uns zwingen, unser Paket und die geplanten Änderungen aus einer Außenperspektive zu betrachten und die Auswirkungen unseres Handelns auf andere im Allgemeinen sowie auf abhängige Pakete im Besonderen zu berücksichtigen.


## Trunk

Die Verwaltung und Nutzung von Zweigen ist ein wichtiger Bestandteil der Arbeit mit einem *verteilten Versionskontrollsystem* (*DVCS*) wie [fossil](https://www.fossil-scm.org/).

Bei Tcllib ist der Hauptzweig der Sammlung *trunk*. In *git* würde dieser Zweig *master* heißen, und genau dies ist im [GitHub-Mirror ](https://github.com/tcltk/tcllib/) von Tcllib der Fall.

Um das Debugging angemessen zu unterstützen, *muss jeder einzelne Commit* in diesem Zweig *die gesamte Testsuite* der Sammlung bestehen. Die Verwendung der Bisektionsmethode zur Ermittlung des Zeitpunkts, zu dem ein Problem aufgetreten ist, ist ein Beispiel für eine Maßnahme, die durch diese Constraint vereinfacht wird.

Dies ist Teil unserer gemeinsamen Verantwortung für die allgemeine Nutzbarkeit von Tcllib gegenüber der Außenwelt. Da *fossil* über keinen Mechanismus verfügt, um diese Bedingung durchzusetzen, beruht dies auf dem Vertrauensprinzip seitens der Entwickler und Betreuer.

Um Ihnen die Arbeit zu erleichtern, enthält Tcllib ein Tool („*sak.tcl*“), das eine Reihe von Befehlen zur Unterstützung bereitstellt. Diese Befehle werden in den folgenden Abschnitten dieses Leitfadens erläutert.

Zwar ist es möglich und zulässig, direkt in den Trunk zu Committen, doch beachten Sie bitte die oben genannte Constraint bezüglich der Testsuite sowie die nachfolgenden Hinweise zu weiteren möglichen Problemen bei einem Commit.

## Zweige

Angesichts der Constraints, die für den *trunk*-Zweig des Repositorys gelten, wird (dringend) empfohlen, alle Entwicklungsarbeiten, die über geringfügige Änderungen hinausgehen, in einem anderen Zweig als dem *trunk*-Zweig durchzuführen.

Außerhalb des Trunks ist es Entwicklern gestattet, Zwischenzustände ihrer Arbeit, die noch Fehler enthalten, zu Committen. Erst am Ende eines Entwicklungszyklus, wenn der betreffende Branch als bereit für die Zusammenführung angesehen wird, ist es erforderlich, alle Validierungen durchzuführen, um sicherzustellen, dass die bevorstehende Zusammenführung zu einem fehlerfreien Commit im Trunk führt.

Hinweis: Eine Überprüfung durch einen zweiten Entwickler ist zwar keine zwingende Anforderung für das Zusammenführen eines Zweigs, es ist jedoch empfehlenswert, eine solche unabhängige Meinung einzuholen, um die Arbeit einer Gegenprüfung zu unterziehen.

Außerdem wurde empfohlen, jedem neuen Zweig einen Namen zu geben, der dabei hilft, weitere Details darüber zu ermitteln. Beispiele für geeignete Angaben, die in einen Zweignamen aufgenommen werden sollten, wären

**•**
: (Spitz-)Name des Entwicklers

**•**
: Ticket-Hash/Referenz

**•**
: Ein oder zwei Schlüsselwörter, die auf das Werk zutreffen

**•**
: ... Darüber hinaus sind die meisten Entwicklungszweige zwar wahrscheinlich von relativ kurzer Dauer, doch gibt es kein Verbot, auch länger bestehende Zweige anzulegen. Die Ersteller sollten sich jedoch bewusst sein, dass solche Zweige umso stärker vom Stammzweig abweichen, je länger sie ohne Zusammenführung bestehen bleiben, was mit einem entsprechenden Anstieg des Aufwands einhergeht, der entweder für die Zusammenführung aus dem Zweig in den Stammzweig oder umgekehrt aufgewendet werden muss.


## Arbeiten mit Zweigen

In der Hoffnung, gute Arbeitspraktiken zu fördern, folgen nun einige Beispiele, die Verzweigungen erzeugen, sowie die dazugehörigen „fossil“-Befehle (Sequenzen).

*Awareness*
: Bei der Entwicklung müssen wir uns stets des Kontexts unserer Arbeit bewusst sein. Auf welchem Zweig befinden wir uns? Welche Dateien haben wir geändert? Welche neuen Dateien sind dem Repository noch nicht bekannt? Was ist auf dem Server geschehen, seit wir unseren Checkout verwendet haben? Die Antworten auf diese Fragen sind besonders wichtig, wenn Sie einen langfristig genutzten Checkout verwenden und nach einer längeren Pause wieder darauf zurückkommen. Befehle zur Beantwortung solcher Fragen sind:


**fossil pull**
: Führen Sie alle Änderungen durch, die seit dem letzten Abruf oder der letzten Synchronisierung vom Remote-Repository vorgenommen wurden. Dies muss zuerst erfolgen, bevor Sie einen der folgenden Befehle ausführen. Selbst wenn sich der Commit in unserem Checkout auf den gewünschten Zweig bezieht, könnten durch am Remote-Repository vorgenommene Commits die Situation hinter unserem Rücken verändert haben.

**fossil info | grep tags**
: ...siehe nächstes...

**fossil branch list | grep '\\\*'**
: Zwei verschiedene Möglichkeiten, den Zweig zu ermitteln, auf dem sich unser Checkout befindet.

**fossil timeline**
: Was haben wir (und andere) in letzter Zeit unternommen? *Achtung*, diese Informationen sind höchstwahrscheinlich veraltet, und zwar umso mehr, je länger wir diesen Checkout nicht mehr genutzt haben. Führen Sie zunächst **fossil pull** aus, um die aktuellsten Informationen aus dem Remote-Repository des Projekts abzurufen.

**fossil timeline current**
: Place the Commit, on which our checkout is based, at the top of the timeline.

**fossil changes**
: Listet die Dateien auf, die wir im Vergleich zu dem Commit, auf dem der Checkout basiert, geändert haben.

**fossil extra**
: Listet die Dateien auf, die sich in unserem Checkout befinden, die dem Repository jedoch nicht bekannt sind. Dabei kann es sich um Überbleibsel unserer Arbeit handeln oder um etwas, das wir noch nicht mit **fossil add** in das Repository übernommen haben.


*Clean checkouts*
: Achten Sie darauf, wo Sie sich befinden (siehe erste Definition). Für nahezu alle der nachfolgend aufgeführten Vorgehensweisen ist ein sauberer Checkout zumindest wünschenswert, oft sogar erforderlich. Um zu überprüfen, ob ein Checkout sauber ist, führen Sie folgenden Befehl aus:


```
    fossil changes
    fossil extra
```

: Wie Sie vorgehen sollten, wenn nicht festgeschriebene Änderungen jeglicher Art festgestellt werden, hängt vom jeweiligen Kontext ab und liegt außerhalb des Geltungsbereichs dieses Leitfadens.


*Starting a new branch*
: Achten Sie darauf, wo Sie sich befinden (siehe erste Definition). Stellen Sie sicher, dass Ihr Checkout sauber ist (siehe zweite Definition). Dies ist *eine Anforderung*. In den meisten Fällen sollten Sie sich auf dem Zweig *trunk* befinden und den neuesten Commit dieses Zweigs verwenden. Um dorthin zu gelangen, verwenden Sie


```
    fossil pull
    fossil update trunk
```

: Wenn Sie einen anderen Zweig als Ausgangspunkt für die bevorstehenden Arbeiten wünschen, ersetzen Sie *trunk* in den obigen Befehlen durch den Namen dieses Zweigs. Nachdem die Basis nun festgelegt ist, stehen uns zwei Möglichkeiten zur Erstellung des neuen Zweigs zur Verfügung, die jeweils unterschiedliche Vor- und Nachteile aufweisen. Der einfachere Weg besteht darin,


```
    fossil branch new NAME_OF_NEW_BRANCH
```

: und mit der Entwicklung beginnen. Der Vorteil dabei ist, dass Sie nicht vergessen können, den Zweig anzulegen. Die Nachteile bestehen darin, dass wir einen Commit im Zweig haben, der gegenüber dem Ausgangspunkt unverändert ist, und dass wir drastische Maßnahmen wie das Ausblenden oder Ignorieren ergreifen müssen, um den Commit zu entfernen, sollten wir beschließen, die Arbeit vor dem ersten tatsächlichen Commit in diesem Zweig aufzugeben. Die andere Möglichkeit, den Zweig zu erstellen, besteht darin, mit der Entwicklung zu beginnen und dann beim ersten Commit die Option **--branch** zu verwenden, um **fossil** mitzuteilen, dass wir nun einen Zweig starten. Führen Sie also folgenden Befehl aus:


```
    fossil commit --branch NAME_OF_NEW_BRANCH ...
```

: wobei *...* für beliebige weitere Optionen steht, die zur Angabe der Commit-Meldung, der zu übergebenden Dateien usw. verwendet werden. Die (Vor-) und Nachteile sind nun umgekehrt. Wir haben keinen überflüssigen Commit, sondern nur das, was tatsächlich entwickelt wurde. Die Arbeit bleibt verborgen, bis wir unseren ersten Commit durchführen. Es kann vorkommen, dass wir vergessen, **--branch NAME_OF_NEW_BRANCH** zu verwenden, und dieses Versehen dann über die Fossil-Weboberfläche korrigieren müssen (mir sind derzeit keine Möglichkeiten bekannt, dies über die Befehlszeile zu bewerkstelligen, obwohl eine „magische Formel“ wie **fossil tag create** möglicherweise funktionieren könnte). Es ist hilfreich, stets aufmerksam zu bleiben, beispielsweise indem man vor jedem Commit überprüft, ob man sich auf dem gewünschten Branch befindet.


*Merging a branch into trunk*
: Achten Sie darauf, wo Sie sich befinden (siehe erste Definition). Stellen Sie sicher, dass Ihr Checkout sauber ist (siehe zweite Definition). In der vollständigen Abfolge (Zickzack) ist dies aufgrund der Zusammenführung aus dem Trunk *eine Anforderung*. In der kürzeren Abfolge ist es lediglich wünschenswert. Dennoch halte ich es für eine gute Angewohnheit, den Checkout vor größeren Vorgängen sauber zu halten. Die vollständige Abfolge mit durchgehenden Überprüfungen dient dazu,


**\[1\]**
: Überprüfen Sie den Checkout, d. h. den letzten Commit in Ihrem Branch. Führen Sie die vollständige Testsuite sowie weitere Validierungen durch und beheben Sie alle aufgetretenen Probleme.

**\[2\]**
: Fügen Sie den aktuellen Stand des *Trunk* ein (siehe folgende Definition).

**\[3\]**
: Führen Sie die Validierung des Checkouts erneut durch. Die eingehenden Änderungen aus dem Trunk könnten inzwischen zu Fehlern geführt haben. Nehmen Sie gegebenenfalls die erforderlichen Korrekturen vor.

**\[4\]**
: Führen Sie nun die Zusammenführung in den Trunk durch, indem Sie Folgendes verwenden:


```
    fossil update trunk
    fossil merge --integrate YOUR_BRANCH
```

**\[5\]**
: Zu diesem Zeitpunkt sollte sich der Checkout im gleichen Zustand befinden wie am Ende des obigen Punktes (3), da wir etwaige Probleme mit dem Trunk bereits behoben haben. Daher reicht ein einfaches


```
    fossil commit ...
```

: Dies sollte nun ausreichen, um den Merge zurückzuentfernen und den Branch zu schließen (aufgrund des **--integrate**, den wir beim Merge verwendet haben). Wer besonders vorsichtig ist, kann den Checkout vor dem Commit ein drittes Mal validieren.


Ich bezeichne dies als *Zick-Zack-Zusammenführung*, da die Pfeile in der Zeitleiste so aussehen: Bei der ersten Zusammenführung verlaufen sie vom Trunk zum Feature-Zweig und bei der abschließenden Zusammenführung wieder zurück.

Wer weniger paranoid ist, kann das tun, was ich als *einfache Zusammenführung* bezeichne, bei der Schritt (2) hinter Schritt (4) verschoben und Schritt (3) vollständig übersprungen wird. Die daraus resultierende kürzere Abfolge lautet

**\[1\]**
: Validierung

**\[2\]**
: In den Trunk zusammenführen

**\[3\]**
: Erneut validieren

**\[4\]**
: In den Trunk einpflegen


: Der letzte Schritt nach einer Zickzack- oder einer einfachen Zusammenführung besteht darin,


```
    fossil sync
```

: Dadurch werden unsere Änderungen auf dem Remote-Server gespeichert, und wir erhalten zudem alle weiteren Änderungen, die während unseres Merge-Vorgangs vorgenommen wurden. Dies ermöglicht es uns insbesondere zu überprüfen, ob es zu einem Wettlauf mit einem anderen Entwickler gekommen ist, der zu einer Aufspaltung des Trunks geführt hat. In einem solchen Fall sollten wir uns mit dem anderen Entwickler abstimmen, wer die Aufspaltung behebt, um sicherzustellen, dass es nicht erneut zu einem Wettlauf kommt.


*Merging from trunk*
: Achten Sie darauf, wo Sie sich befinden (siehe erste Definition). Stellen Sie sicher, dass Ihr Checkout sauber ist (siehe zweite Definition). Dies ist *eine Anforderung*. In den meisten Fällen möchten Sie den neuesten Commit des Zweigs *trunk* (oder eines anderen Ursprungs) importieren. Um diesen zu erhalten, verwenden Sie


```
    fossil pull
```

Nachdem dies erledigt ist, können wir diesen Commit nun mit folgendem Befehl in unseren aktuellen Zweig importieren:

```
    fossil merge trunk
```

Auch wenn **fossil** keine Konflikte meldet, ist es ratsam zu überprüfen, ob der Vorgang die neuen und/oder geänderten Funktionen, an denen wir gerade arbeiten, beeinträchtigt hat.

Nachdem wir eine korrekte Zusammenführung erstellt haben, speichern wir den Zustand mit

```
    fossil commit ...
```

: bevor die Entwicklung fortgesetzt wird.


## Versionsnummern

In Tcllib müssen alle Änderungen an einem Paket mit einer Erhöhung der Versionsnummern einhergehen. Welcher Teil erhöht wird (Patch-Level, Minor- oder Major-Version), hängt von der Art der vorgenommenen Änderung ab. Bei mehreren Änderungen in einem Commit „gewinnt“ diejenige mit der höchsten Versionsnummer.

Wenn man in einem Entwicklungszweig arbeitet, kann die Versionsänderung bis zum Zeitpunkt des Zusammenführens aufgeschoben werden; dann muss sie alle Änderungen in diesem Zweig abdecken.

Nachfolgend finden Sie eine Liste der verschiedenen Arten von Änderungen und der damit verbundenen Versionserhöhungen:

*D - documentation*
: Keine Erhöhung

*T - testsuite*
: Keine Erhöhung

*B - bugfix*
: Patch-Level

*I - implementation tweak*
: Patch-Level

*P - performance tweak*
: Patch-Level

*E - backward-compatible extension*
: Minderjähriger

*API - incompatible change*
: Wichtig: Beachten Sie, dass ein Commit, das eine Versionserhöhung enthält, in seiner Commit-Meldung sowohl die neue Versionsnummer als auch die Art der Änderung, die dazu geführt hat, angeben muss. Beachten Sie ferner, dass die Versionsnummer eines Pakets derzeit an drei Stellen vorhanden ist. Bei einer Versionserhöhung müssen alle diese Stellen aktualisiert werden:


**\[1\]**
: Die Implementierung des Pakets.

**\[2\]**
: Der Paket-Index („*pkgIndex.tcl*“)

**\[3\]**
: Die Paketdokumentation. Der Befehl „*sak.tcl*“ **validate version** hilft dabei, Abweichungen zwischen den beiden erstgenannten zu erkennen. Auch alle anderen **validate**-Methoden sind für jeden Entwickler von Interesse. Rufen Sie ihn auf mit


```
 sak.tcl help validate
```

um deren Dokumentation einzusehen.

# AUFBAU IM ÜBERBLICK

## Hauptverzeichnisse

Die wichtigsten Verzeichnisse im Toplevel-Fenster von „Tcllib“, die für Entwickler von Interesse sind, lauten:

"*modules*"
: Jedes Verzeichnis steht für ein oder mehrere Pakete. Im letzteren Fall stehen die Pakete in der Regel in irgendeiner Weise miteinander in Zusammenhang. Beispiele hierfür sind „*base64*“, „*math*“ und „*struct*“, wobei die Beziehungen zwischen den Paketen in dem jeweiligen Verzeichnis von locker (base64) bis eng (math) reichen.

"*apps*"
: Dieses Verzeichnis enthält alle installierbaren Anwendungen samt ihrer Dokumentation. Es gibt derzeit keine Unterverzeichnisse in diesem Verzeichnis.

"*examples*"
: Jedes Verzeichnis „*foo*“ enthält eine oder mehrere Beispiele für die Pakete in „*modules/foo*“. Diese Beispiele sind in der Regel noch nicht ausgereift genug, um für eine Installation in Betracht gezogen zu werden.


## Weitere Verzeichnisse

"*config*"
: Dieses Verzeichnis enthält Dateien zur Unterstützung des Unix-Build-Systems, d. h. „*configure*“ und „*Makefile.in*“.

"*devdoc*"
: Dieses Verzeichnis enthält die DocTools-Quelldateien für die allgemeine Dokumentation, wie beispielsweise dieses Dokument und die dazugehörigen Anleitungen.

"*embedded*"
: Dieses Verzeichnis enthält die gesamte Dokumentation, die für *HTML* formatiert und so gestaltet ist, dass sie sich nahtlos in die von Fossil für das Repository generierte Website einfügt. Es handelt sich hierbei um die Dokumentation, auf die Sie vom Tcllib-Stammverzeichnis aus zugreifen können und die im Repository als „*embedded/index.md*“ vorliegt.

"*idoc*"
: Dieses Verzeichnis enthält die gesamte Dokumentation, formatiert für *nroff* und *HTML*, wobei letztere ohne jegliche Formatierung vorliegt. Dies ist die Dokumentation, die installiert wird.

"*support*"
: Dieses Verzeichnis enthält die Quellcodes der internen Pakete und Dienstprogramme, die bei der Implementierung der Skripte bzw. Tools „*installer.tcl*“ und „*sak.tcl*“ verwendet werden.


## Dateien auf oberster Ebene

"*aclocal.m4*"
: ...siehe nächstes...

"*configure*"
: ...siehe nächstes...

"*configure.in*"
: ...siehe nächstes...

"*Makefile.in*"
: Diese vier Dateien bilden das Unix-Build-System, das auf dem Skript „*installer.tcl*“ aufbaut.

"*installer.tcl*"
: Das auf Tcl basierende Installationsskript bzw. -tool.

"*project.shed*"
: Konfiguration für das Build-System **PracTcl** von *Sean Wood*.

"*sak.tcl*"
: Dies ist das wichtigste Werkzeug für Entwickler und Release-Manager, das *Schweizer Taschenmesser* für Verwaltungsaufgaben im Zusammenhang mit der Sammlung.

"*ChangeLog*"
: Das Protokoll der Änderungen am globalen Support, wenn die Quelltexte noch in *CVS* verwaltet wurden. Mit der Umstellung auf das SCM *fossil* nicht mehr relevant.

"*license.terms*"
: Die Lizenz im einfachen ASCII-Format. Siehe auch *Tcllib – Lizenz* für die übersichtliche Darstellung. Der Text ist identisch.

"*README.md*"
: ...siehe nächstes...

"*.github/CONTRIBUTING.md*"
: ...siehe nächstes...

"*.github/ISSUE_TEMPLATE.md*"
: ...siehe nächstes...

"*.github/PULL_REQUEST_TEMPLATE.md*"
: Diese im Markdown-Format verfassten Dokumente werden vom GitHub-Mirror dieser Quellen verwendet und angezeigt, wobei die Nutzer auf die offizielle Website und die Issue-Tracker weitergeleitet werden.

"*DESCRIPTION.txt*"
: ...siehe nächstes...

"*STATUS*"
: ...siehe nächstes...

"*tcllib.spec*"
: ...siehe nächstes...

"*tcllib.tap*"
: ...siehe nächstes...

"*tcllib.yml*"
: ????


## Dateitypen

Die gängigsten Dateiformate, geordnet nach Erweiterung, sind:

"*.tcl*"
: Tcl-Code für ein Paket, eine Anwendung oder Beispiele.

"*.man*"
: Mit Doctools formatierte Dokumentation, in der Regel für ein Paket.

"*.test*"
: Testsuite für ein Paket oder einen Teil davon. Basierend auf **tcltest**.

"*.bench*"
: Leistungs-Benchmarks für ein Paket oder einen Teil davon. Basierend auf „*modules/bench*“.

"*.pcx*"
: Syntaxregeln für *TclDevKit*s **tclchecker**. Durch die Anwendung dieser Regeln kann der Prüfer die Verwendung von Befehlen eines Tcllib-Pakets **foo** validieren, ohne die „*.tcl*“-Dateien, in denen diese implementiert sind, durchsuchen zu müssen.


# TOOLS FÜR TESTSUITEN

Die Testsuiten in Tcllib basieren auf dem Tcl-Standardtestpaket **tcltest** sowie auf Dienstprogrammen, die sich im Verzeichnis „*modules/devtools*“ befinden.

Die Entwickler von Tcllib rufen die Testsuiten über die Methode **test run** des Tools „*sak.tcl*“ auf, während andere Methoden von **test** Verwaltungsfunktionen bereitstellen, beispielsweise das Festlegen einer Liste der zu verwendenden Standard-Tcl-Shells.

## Die Testsuiten eines bestimmten Moduls aufrufen

Rufen Sie entweder

```
  ./sak.tcl test run foo
```

or

```
  ./sak.tcl test run modules/foo
```

um die Testsuiten aufzurufen, die sich in einem bestimmten Modul „*foo*“ befinden.

## Die Testsuiten aller Module aufrufen

Rufen Sie das Tool ohne Modulnamen auf, d. h.

```
  ./sak.tcl test run
```

um die Testsuiten aller Module auszuführen.

## Detaillierte Testprotokolle

In allen bisherigen Beispielen gibt der Testausführer eine Kombination aus Fortschrittsanzeige und Testsuite-Protokoll an die Standardausgabe aus, wobei für jedes Modul nur die Tests angezeigt werden, die bestanden oder fehlgeschlagen sind, und am Ende in einer Zusammenfassung angegeben wird, wie viele davon jeweils vorhanden sind.

Um ein detailliertes Protokoll zu erhalten, müssen Sie den Testausführer mit zusätzlichen Optionen aufrufen.

Zum einen:

```
   ./sak.tcl test run --log LOG foo
```

Zwar wird dabei wie zuvor derselbe kurze Protokollauszug auf dem Terminal angezeigt, doch wird zudem ein detailliertes Protokoll in die Datei „*LOG.log*“ geschrieben und Auszüge in weitere Dateien („*LOG.summary*“, „*LOG.failures*“ usw.) ausgegeben.

Für zwei Personen:

```
  ./sak.tcl test run -v foo
```

Dadurch wird das detaillierte Protokoll anstelle des Kurzprotokolls in die Standardausgabe geschrieben.

Unabhängig von der Form enthält das detaillierte Protokoll eine Auflistung aller ausgeführten Tests, der fehlgeschlagenen Tests sowie der Art und Weise, wie diese fehlgeschlagen sind (erwartete Ergebnisse im Vergleich zu den tatsächlichen Ergebnissen).

## Auswahl der Shell

Standardmäßig verwendet der Testausführer alle über **test add** festgelegten Tcl-Shells, um die festgelegten Testsuiten aufzurufen, sofern solche vorhanden sind. Wenn keine angegeben sind, greift er auf die Tcl-Shell zurück, die zur Ausführung des Tools selbst verwendet wird.

Verwenden Sie die Option **--shell**, um die zu verwendende Tcl-Shell explizit anzugeben, beispielsweise

```
  ./sak.tcl test run --shell /path/to/tclsh ...
```

## Hilfe

Rufen Sie das Tool wie folgt auf:

```
  ./sak.tcl help test
```

um die ausführliche Hilfe zu allen Methoden von **test** sowie die zugehörigen Optionen einzusehen.

# DOKUMENTATIONSWERKZEUGE

Das Standardformat für die Dokumentation von Paketen und anderen Elementen in Tcllib ist *doctools*. Die dazugehörigen Pakete sind Teil von Tcllib; siehe die Verzeichnisse „*modules/doctools*“ und „*modules/dtplite*“. Letzteres ist ein Paket, wobei die eigentliche Anwendung „*apps/dtplite*“ einen schlanken Wrapper darum bildet.

Tcllib-Entwickler erhalten über die Methode **doc** des Tools „*sak.tcl*“ Zugriff darauf; dabei handelt es sich um einen weiteren (internen) Wrapper um das Paket „*modules/dtplite*“.

## Dokumentation für ein bestimmtes Modul erstellen

Rufen Sie entweder

```
  ./sak.tcl doc html foo
```

or

```
  ./sak.tcl doc html modules/foo
```

um HTML für die Dokumentation im Modul „*foo*“ zu generieren. Anstelle von **html** kann hier natürlich jedes andere unterstützte Format verwendet werden.

Die generierte, formatierte Dokumentation wird im Verzeichnis „*doc*“ im aktuellen Arbeitsverzeichnis platziert.

## Dokumentation für alle Module erstellen

Rufen Sie das Tool ohne Modulnamen auf, d. h.

```
  ./sak.tcl doc html
```

um HTML-Code für die Dokumentation aller Module zu generieren. Anstelle von **html** kann hier natürlich jedes andere unterstützte Format verwendet werden.

Die generierte, formatierte Dokumentation wird im Verzeichnis „*doc*“ im aktuellen Arbeitsverzeichnis platziert.

## Verfügbare Ausgabeformate, Hilfe

Rufen Sie das Tool wie folgt auf:

```
  ./sak.tcl help doc
```

um die gesamte Liste der unterstützten Ausgabeformate anzuzeigen, die generiert werden können.

## Validierung ohne Ausgabe

Hinweis: Bitte beachten Sie das spezielle Format **validate**.

Wenn Sie diesen Wert als Namen des zu generierenden Formats verwenden, wird das Tool dazu veranlasst, lediglich zu prüfen, ob die Dokumentation syntaktisch korrekt ist, ohne dabei eine tatsächliche Ausgabe zu erzeugen.

Rufen Sie es entweder wie folgt auf:

```
  ./sak.tcl doc validate (modules/)foo
```

or

```
  ./sak.tcl doc validate
```

um entweder die Pakete eines bestimmten Moduls oder alle Pakete zu überprüfen.

# HINWEISE ZUM ERSTELLEN EINER TESTSUITE

Während in den vorangegangenen Abschnitten die Ausführung der Testsuiten für ein Modul und die darin enthaltenen Pakete behandelt wurde, hat dies keinerlei Bedeutung, wenn das betreffende Modul überhaupt keine Testsuiten enthält.

Dieser Abschnitt bietet eine sehr grundlegende Einleitung zu möglichen Methoden zum Erstellen von Tests und Testsuiten.

Zunächst gibt es sogenannte „Routinetests“. Diese dienen dazu, absolut grundlegende Annahmen zu überprüfen, die unter keinen Umständen fehlschlagen dürfen.

Beispielsweise für einen Befehl FOO, der zwei Argumente erwartet: drei Tests, bei denen er mit null, einem bzw. drei Argumenten aufgerufen wird. Dabei wird grundsätzlich geprüft, ob der Befehl fehlschlägt, wenn er nicht genügend oder zu viele Argumente erhält.

Danach folgen die Tests, die anhand unseres Wissens über den Befehl dessen Eigenschaften und Annahmen überprüfen. Einige Beispiele, die auf den im Rahmen des „Google Summer of Code 2009“ hinzugefügten Graphoperationen basieren, sind:

**•**
: Der Befehl „BellmanFord“ in struct::graph::ops nimmt einen *Startknoten* als Argument entgegen, und dieser Knoten sollte ein Knoten des Graphen sein. Dies entspricht einem Testfall, der das Verhalten überprüft, wenn der angegebene Knoten kein Knoten des Graphen ist. Dies führt in der Implementierung häufig dazu, dass Code geschrieben wird, der diese Annahme explizit überprüft und einen nachvollziehbaren Fehler auslöst, anstatt zuzulassen, dass der Algorithmus später auf seltsame, nicht deterministische Weise fehlschlägt. Es ist jedoch nicht immer möglich, solche Überprüfungen durchzuführen. Das Argument „graph“ ist beispielsweise selbst ein Befehl, und obwohl wir erwarten, dass es eine bestimmte Schnittstelle aufweist, d. h. eine Reihe von Unterbefehlen, auch bekannt als Methoden, können wir nicht überprüfen, ob es über diese verfügt, es sei denn, wir versuchen tatsächlich, sie zu verwenden. Dies wird ohnehin vom Algorithmus erledigt, sodass eine explizite Überprüfung lediglich einen Mehraufwand darstellt, auf den wir verzichten können.

**•**
: Soweit ich mich erinnere, besteht eines der charakteristischen Merkmale von Bellman-Ford und/oder Johnson darin, dass sie mit negativen Gewichten umgehen können. Dijkstra hingegen erfordert positive Gewichte. Daraus ergeben sich (mindestens) drei Testfälle … ein Graph mit ausschließlich positiven Gewichten, einer mit ausschließlich negativen Gewichten und einer mit einer Mischung aus positiven und negativen Gewichten. Wenn man weiter darüber nachdenkt: Kann der Algorithmus auch das Gewicht **0** verarbeiten? Ein weiterer Testfall – oder mehrere –, wenn wir Null mit positiven und negativen Gewichten mischen.

**•**
: Bei den beiden Algorithmen, über die wir derzeit nachdenken, geht es um Abstände zwischen Knoten, wobei der Abstand „unendlich“ sein kann, d. h., Knoten haben möglicherweise keine Verbindung zueinander. Das bedeutet, dass gute Testfälle folgende sind:


**\[1\]**
: Stark verbundener Graph

**\[2\]**
: Verbundener Graph

**\[3\]**
: Nicht zusammenhängender Graph.


An den Extremen der Kategorien „stark verbunden“ und „nicht verbunden“ finden wir die vollständig verbundenen Graphen und Graphen ohne Kanten, die nur Knoten enthalten, d. h. vollständig unverbunden sind.

**•**
: Soweit ich mich erinnere, nehmen beide Algorithmen gewichtete Kanten entgegen und füllen einen Standardwert ein, falls Kanten im Eingabegraphen ungewichtet bleiben. Daraus ergeben sich zudem drei Testfälle:


**\[1\]**
: Graph mit allen Kanten und expliziten Gewichten.

**\[2\]**
: Ein Graph ohne jegliche Gewichte.

**\[3\]**
: Graph mit einer Mischung aus gewichteten und ungewichteten Graphen.


Was oben anhand von Beispielen beschrieben wurde, wird als *Black-Box*-Test bezeichnet. Testfälle werden auf der Grundlage des Wissens des Entwicklers über die Eigenschaften des Algorithmus und dessen Eingaben entworfen und geschrieben, ohne Bezug auf eine bestimmte Implementierung zu nehmen.

Darüber hinaus bildet das *White-Box*-Testen eine Ergänzung zum *Black-Box*-Testen. Dabei kennen wir die Implementierung des Algorithmus, untersuchen diese und entwerfen unsere Tests so, dass sie den Code durch alle möglichen Pfade der Implementierung führen. Überall dort, wo eine Entscheidung getroffen wird, verfügen wir über einen Testfall, der eine bestimmte Richtung der Entscheidung erzwingt – und zwar für alle möglichen Kombinationen und Richtungen. Dabei kann es leicht zu einer kombinatorischen Explosion bei der Anzahl der benötigten Tests kommen.

In der Praxis hoffe ich oft, dass die von mir durchgeführten Black-Box-Tests ausreichen, um alle Pfade abzudecken, sodass White-Box-Tests entfallen.

Das oben Gesagte sollte ausreichen, um deutlich zu machen, dass das Schreiben von Tests für einen Algorithmus mindestens genauso viel Zeit in Anspruch nimmt wie das Programmieren des Algorithmus selbst – oft sogar noch mehr Zeit. Viel mehr Zeit. Siehe hierzu beispielsweise auch *http://sqlite.org/testing.html*, einen Bericht darüber, wie die SQLite-Datenbank-Engine getestet wird. Ein weiterer interessanter Artikel könnte *https://www.researchgate.net/publication/298896236* sein. Obwohl er sich auf einen bestimmten numerischen Algorithmus bezieht, zeigt er dennoch, dass selbst ein auf den ersten Blick einfacher Algorithmus zu einer unglaublichen Anzahl von Tests führen kann.

Eine interessante Verbindung besteht zur Dokumentation. Einerseits sind die Eigenschaften, die im Rahmen von Black-Box-Tests überprüft werden, genau jene Eigenschaften, die in der Man-Seite des Algorithmus dokumentiert sein sollten. Und umgekehrt bietet die Dokumentation der Eigenschaften eines Algorithmus eine gute Grundlage für die Gestaltung der Black-Box-Tests.

In der Praxis werden Testfälle und Dokumentation oft gleichzeitig verfasst, wobei sie sich gegenseitig beeinflussen. Und das eigentliche Verfassen von Testfällen ist eine Mischung aus Black-Box- und White-Box-Ansatz, was möglicherweise bereits während des Schreibens der Tests Einfluss auf die Implementierung nimmt. Ein Beispiel hierfür ist das Verfassen eines Tests für eine Bedingung wie *Startknoten nicht im Eingabegraphen*, der als Erinnerung dient, eine Überprüfung dieser Bedingung in den Code einzubauen.

# INSTALLATIONSWERKZEUGE

Ein letzter Punkt, den man berücksichtigen sollte, wenn ein neues Paket zur Sammlung hinzukommt, ist die Installation.

Die *Verwendung* des Skripts „*installer.tcl*“ ist in *Tcllib – Anleitung für Installateure* dokumentiert.

Hier beschreiben wir, wie Sie das genannte Installationsprogramm so erweitern können, dass es neue Pakete und/oder Anwendungen installieren kann.

In den meisten Fällen muss lediglich eine einzige Datei geändert werden, nämlich die Datei „*support/installation/modules.tcl*“, die je nach zu installierendem Modul und Anwendung jeweils einen Befehl enthält.

Die entsprechenden Befehle lauten:

**Module** *name* *code-action* *doc-action* *example-action*
: Installieren Sie die Pakete des Moduls *name*, die sich unter „*modules/name*“ befinden. Die *code-action* ist für die Installation der Pakete und ihres Indexes zuständig. Das System stellt derzeit Folgendes bereit:


**\_tcl**
: Kopiert alle im Verzeichnis „*modules/name*“ gefundenen „*.tcl*“-Dateien in das Installationsverzeichnis.

**\_tcr**
: Kopieren Sie ebenso wie bei **\_tcl** die „*.tcl*“-Dateien, die sich in den Unterverzeichnissen von „*modules/Name*“ befinden.

**\_tci**
: Nennen Sie die Datei „**\_tcl**“ und kopieren Sie außerdem die Datei „*tclIndex.tcl*“.

**\_msg**
: Als **\_tcl**, und kopieren Sie bitte auch das Unterverzeichnis „*msgs*“.

**\_doc**
: Geben Sie „**\_tcl**“ ein und kopieren Sie zudem das Unterverzeichnis „*mpformats*“.

**\_tex**
: Als **\_tcl** und kopieren Sie zudem die „*.tex*“-Dateien.


Die *doc-action* ist für die Installation der Paketdokumentation zuständig. Das System stellt derzeit Folgendes bereit:

**\_null**
: Es liegt keine Dokumentation vor; bitte unternehmen Sie nichts.

**\_man**
: Verarbeiten Sie die im Verzeichnis „*modules/name*“ befindlichen „*.man*“-Dateien und installieren Sie die Ergebnisse (nroff und/oder HTML) an dem dem Installationsprogramm angegebenen Speicherort. Hierbei handelt es sich eigentlich um eine Ausweichlösung; normalerweise verwendet das Installationsprogramm die vorgefertigte, formatierte Dokumentation, die sich unter „*idoc*“ befindet.


Die *example-action* ist für die Installation der Beispiele zuständig. Das System stellt derzeit Folgendes bereit:

**\_null**
: Es sind keine Beispiele verfügbar; bitte unternehmen Sie nichts.

**\_exa**
: Kopieren Sie das Verzeichnis „*examples/Name*“ rekursiv in den Installationsordner für die Beispiele.


**Application** *name*
: Installieren Sie die Anwendung mit dem Namen *name*, die sich im Ordner „*apps*“ befindet.

**Exclude** *name*
: Dieser Befehl teilt dem Installationsprogramm mit, welche der aufgeführten Module *nicht* installiert werden sollen. Das heißt, er nennt die veralteten Module von Tcllib. Nur wenn die oben genannten Aktionen für das neue Modul nicht geeignet sind, muss eine zweite Datei geändert werden: „*support/installation/actions.tcl*“. Diese Datei enthält die Implementierungen der verfügbaren Aktionen und ist der Ort, an dem jede benutzerdefinierte Aktion hinzugefügt werden muss, die zur Bewältigung der besonderen Umstände des Moduls erforderlich ist.
