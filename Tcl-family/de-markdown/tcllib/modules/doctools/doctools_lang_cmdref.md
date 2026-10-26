---
CommandName: doctools_lang_cmdref
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - doctools_intro
 - doctools_lang_faq
 - doctools_lang_intro
 - doctools_lang_syntax
Keywords:
 - doctools commands
 - doctools language
 - doctools markup
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007-2010 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools_lang_cmdref – Referenz zu den Befehlen der Sprache „doctools“

# ÜBERSICHT

::: {.synopsis} :::
[arg]{.cmd} [text]{.arg} 
[arg_def]{.cmd} [type]{.arg} [name]{.arg} [mode]{.optarg} 
[bullet]{.cmd} [(deprecated]{.arg} [—]{.arg} [use]{.arg} [item)]{.lit} 
[call]{.cmd} [args]{.arg} 
[category]{.cmd} [text]{.arg} 
[class]{.cmd} [text]{.arg} 
[cmd]{.cmd} [text]{.arg} 
[cmd_def]{.cmd} [command]{.arg} 
[comment]{.cmd} [plaintext]{.arg} 
[const]{.cmd} [text]{.arg} 
[copyright]{.cmd} [text]{.arg} 
[def]{.cmd} [text]{.arg} 
[description]{.cmd} 
[enum]{.cmd} 
[emph]{.cmd} [text]{.arg} 
[example]{.cmd} [text]{.arg} 
[example_begin]{.cmd} 
[example_end]{.cmd} 
[file]{.cmd} [text]{.arg} 
[fun]{.cmd} [text]{.arg} 
[image]{.cmd} [name]{.arg} [label]{.optarg} 
[include]{.cmd} [filename]{.arg} 
[item]{.cmd} 
[keywords]{.cmd} [args]{.arg} 
[lb]{.cmd} 
[list_begin]{.cmd} [what]{.arg} 
[list_end]{.cmd} 
[lst_item]{.cmd} [text]{.arg} [(deprecated]{.arg} [—]{.arg} [use]{.arg} [def)]{.lit} 
[manpage_begin]{.cmd} [command]{.arg} [section]{.arg} [version]{.arg} 
[manpage_end]{.cmd} 
[method]{.cmd} [text]{.arg} 
[moddesc]{.cmd} [text]{.arg} 
[namespace]{.cmd} [text]{.arg} 
[nl]{.cmd} [(deprecated]{.arg} [—]{.arg} [use]{.arg} [para)]{.lit} 
[opt]{.cmd} [text]{.arg} 
[opt_def]{.cmd} [name]{.arg} [arg]{.optarg} 
[option]{.cmd} [text]{.arg} 
[package]{.cmd} [text]{.arg} 
[para]{.cmd} 
[rb]{.cmd} 
[require]{.cmd} [package]{.arg} [version]{.optdot} 
[section]{.cmd} [name]{.arg} 
[sectref]{.cmd} [id]{.arg} [text]{.optarg} 
[sectref-external]{.cmd} [text]{.arg} 
[see_also]{.cmd} [args]{.arg} 
[strong]{.cmd} [text]{.arg} [(deprecated]{.arg} [—]{.arg} [use]{.arg} [emph)]{.lit} 
[subsection]{.cmd} [name]{.arg} 
[syscmd]{.cmd} [text]{.arg} 
[term]{.cmd} [text]{.arg} 
[titledesc]{.cmd} [desc]{.arg} 
[tkoption_def]{.cmd} [name]{.arg} [dbname]{.arg} [dbclass]{.arg} 
[type]{.cmd} [text]{.arg} 
[uri]{.cmd} [text]{.arg} [text]{.optarg} 
[usage]{.cmd} [args]{.arg} 
[var]{.cmd} [text]{.arg} 
[vset]{.cmd} [varname]{.arg} [value]{.arg} 
[vset]{.cmd} [varname]{.arg} 
[widget]{.cmd} [text]{.arg} 
:::

# BESCHREIBUNG

Dieses Dokument legt sowohl die Namen als auch die Syntax aller Befehle fest, die zusammen die doctools-Markup-Sprache, Version 1, bilden. Da dieses Dokument als Nachschlagewerk gedacht ist, sind die Befehle in alphabetischer Reihenfolge aufgeführt, und die Beschreibungen sind relativ kurz gehalten. Anfängern wird empfohlen, zunächst die wesentlich informeller verfasste *Einleitung in die doctools-Sprache* zu lesen.

# BEFEHLE

**arg** *text*
: Textauszeichnung. Der Argumenttext wird als *Argument* eines Befehls markiert. Zu den Hauptanwendungsbereichen zählen die Hervorhebung von Befehlsargumenten in Freitext sowie die Argumentparameter der Auszeichnungsbefehle **call** und **usage**.

**arg_def** *type* *name* ?*mode*?
: Textstruktur. Listenelement. Argumentliste. Schließt automatisch das vorherige Listenelement. Legt den Daten-*type* des beschriebenen Arguments eines Befehls, dessen *name* und dessen E/A-*mode* fest. Letzterer ist optional.

**bullet** *(deprecated — use* **item**_)_
: *Veraltet*. Textstruktur. Listenelement. Aufzählung. Den kanonischen Befehl zum Öffnen eines Listenelements in einer Aufzählung finden Sie unter **item**.

**call** *args*
: Textstruktur. Listenelement. Definitionsliste. Schließt automatisch das vorherige Listenelement. Definiert den Begriff als Befehl und dessen Argumente. Das erste Argument ist der Name des Befehls, der durch den folgenden Freitext beschrieben wird, und alle darauf folgenden Argumente sind Beschreibungen der Befehlsargumente. Es wird erwartet, dass die Argumente passend mit **arg**, **method**, **option** usw. gekennzeichnet sind und dass der Befehl selbst mit **cmd** gekennzeichnet ist. Es wird erwartet, dass der formatierte Begriff nicht nur an der entsprechenden Stelle ausgegeben wird, sondern je nach Ausgabeformat auch im Inhaltsverzeichnis des Dokuments oder in der Übersicht erscheint.

**category** *text*
: Dokumentinformationen. Überall. Dieser Befehl registriert seine Argumente im Klartext als die Kategorie, zu der dieses Dokument gehört. Wird dieser Befehl mehrfach verwendet, wird der zuletzt angegebene Wert herangezogen.

**class** *text*
: Textmarkierung. Das Argument wird als Name einer *Klasse* markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung von Klassennamen in Freitext.

**cmd** *text*
: Textmarkierung. Der Text wird als Name eines *Tcl-Befehls* markiert. Der Text kann bereits andere Markierungen enthalten. Zu den Hauptanwendungsbereichen zählen die Hervorhebung von Befehlen in Freitext sowie die Befehlsparameter der Markierungsbefehle **call** und **usage**.

**cmd_def** *command*
: Textstruktur. Listenelement. Befehlsliste. Schließt automatisch das vorherige Listenelement. Das Argument legt den Namen des *Tcl-Befehls* fest, der durch das Listenelement beschrieben werden soll. Es wird erwartet, dass dies in der Ausgabe so markiert wird, als wäre es mit **cmd** formatiert worden.

**comment** *plaintext*
: Textmarkierung. Der Text wird als Kommentar markiert, der außerhalb des eigentlichen Dokumenttextes steht. Diese Funktion wird vor allem bei frei formatiertem Text verwendet.

**const** *text*
: Textmarkierung. Das Argument wird als *konstanter* Wert markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung von Konstanten in Freitext.

**copyright** *text*
: Dokumentinformationen. Überall. Der Befehl registriert das Argument im Klartext als Urheberrechtsabtretung für die Manpage. Bei mehrmaliger Ausführung werden die Abtretungen kumuliert.

**def** *text*
: Textstruktur. Listenelement. Definitionsliste. Schließt automatisch das vorherige Listenelement. Der Argumenttext ist der Begriff, der durch das neue Listenelement definiert wird. Darauf kann Textauszeichnung angewendet werden.

**description**
: Dokumentstruktur. Dieser Befehl trennt den Kopf vom Hauptteil des Dokuments. Er leitet implizit einen Abschnitt mit dem Namen „DESCRIPTION“ ein (siehe Befehl **section**).

**enum**
: Textstruktur. Listenelement. Nummerierte Liste. Schließt automatisch das vorherige Listenelement.

**emph** *text*
: Textauszeichnung. Der Text wird als hervorgehoben formatiert. Diese Funktion dient in erster Linie dazu, beliebige Textstücke allgemein hervorzuheben, ohne diesen Stücken eine besondere Bedeutung beizumessen.

**example** *text*
: Textstruktur, Textmarkierung. Dieser Befehl markiert sein Argument als *Beispiel*. Er dient in erster Linie der einfachen Einbettung von Beispielen in frei formatierten Text. Er sollte verwendet werden, wenn das Beispiel *keine* eigene spezielle Markierung benötigt. Andernfalls verwenden Sie eine Folge von **example_begin** … **example_end**.

**example_begin**
: Textstruktur. Dieser Befehl leitet ein Beispiel ein. Der gesamte Text bis zum nächsten **example_end** gehört zum Beispiel. Zeilenumbrüche, Leerzeichen und Tabulatoren müssen wortgetreu beibehalten werden. Beispiele dürfen nicht verschachtelt werden.

**example_end**
: Textstruktur. Dieser Befehl schließt das Beispiel, das mit dem letzten Befehl „**example_begin**“ begonnen wurde.

**file** *text*
: Textmarkierung. Das Argument wird als *Datei* oder *Verzeichnis* markiert, d. h. im Allgemeinen als *Pfad*. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung von Pfaden in Freitext.

**fun** *text*
: Textmarkierung. Das Argument wird als Name einer *Funktion* markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung von Funktionsnamen in Freitext.

**image** *name* ?*label*?
: Textmarkierung. Das Argument ist der symbolische Name eines *Bildes* und wird durch das Bild selbst ersetzt, sofern das Backend eine passende Variante findet. Das zweite Argument, sofern vorhanden, wird als für Menschen lesbare Beschreibung des Bildes interpretiert und an geeigneter Stelle in die Ausgabe eingefügt, sofern dies vom Format unterstützt wird. Das HTML-Format kann diese Beschreibung beispielsweise in das *alt*-Attribut von Bildverweisen einfügen.

**include** *filename*
: Templating. Der Inhalt der genannten Datei wird als Text im doctools-Markup interpretiert und anstelle des Include-Befehls verarbeitet. Das Markup in der Datei muss in sich geschlossen sein. Ein Markup-Befehl darf die Dateigrenzen nicht überschreiten.

**item**
: Textstruktur. Listenelement. Aufzählung. Schließt automatisch das vorherige Listenelement.

**keywords** *args*
: Dokumentinformationen. Überall. Dieser Befehl registriert alle seine Argumente im Klartext als Schlüsselwörter, die für dieses Dokument gelten. Jedes Argument ist ein einzelnes Schlüsselwort. Wird dieser Befehl mehrfach verwendet, werden alle Argumente kumuliert.

**lb**
: Text. Der Befehl wird durch eine linke Klammer ersetzt. Verwendung in frei formatiertem Text. Erforderlich, um zu verhindern, dass eine linke Klammer als Beginn eines Markup-Befehls interpretiert wird.

**list_begin** *what*
: Textstruktur. Dieser Befehl leitet eine Liste ein. Die genaue Art der Liste wird durch das Argument *what* des Befehls bestimmt. Dies legt wiederum fest, welche Befehle zum Einleiten der Listenelemente verwendet werden müssen. Listen können verschachtelt werden, d. h., es ist zulässig, innerhalb eines Listenelements eine neue Liste zu beginnen. Die zulässigen Typen (und die ihnen zugeordneten Elementbefehle) sind:


**arguments**
: **arg_def**.

**commands**
: **cmd_def**.

**definitions**
: **def** und **call**.

**enumerated**
: **enum**

**itemized**
: **item**

**options**
: **opt_def**

**tkoptions**
: **tkoption_def**


Darüber hinaus werden die folgenden Namen als Kurzformen für einige der regulären Typen erkannt:

**args**
: Abkürzung für **arguments**.

**cmds**
: Abkürzung für **commands**.

**enum**
: Abkürzung für **enumerated**.

**item**
: Abkürzung für **itemized**.

**opts**
: Abkürzung für **options**.


Zuletzt werden die folgenden Namen zwar aus Gründen der Kompatibilität weiterhin erkannt, gelten aber ansonsten als *deprecated*.

**arg**
: *Veraltet*. Siehe **arguments**.

**bullet**
: *Veraltet*. Siehe **itemized**.

**cmd**
: *Veraltet*. Siehe **commands**.

**opt**
: *Veraltet*. Siehe **options**.

**tkoption**
: *Veraltet*. Siehe **tkoptions**.


**list_end**
: Textstruktur. Dieser Befehl schließt die Liste, die durch den letzten, ihm vorausgehenden **list_begin**-Befehl geöffnet wurde.

**lst_item** *text* *(deprecated — use* **def**_)_
: *Veraltet*. Textstruktur. Listenelement. Definitionsliste. Der kanonische Befehl zum Öffnen eines allgemeinen Listenelements in einer Definitionsliste befindet sich unter **def**.

**manpage_begin** *command* *section* *version*
: Dokumentstruktur. Der Befehl zum Beginnen einer Manpage. Die Argumente sind der Name des in der Manpage beschriebenen *command*, der *section* der Manpages, in der diese Manpage steht, sowie die *version* des Moduls, das den Befehl enthält. Alle Argumente müssen aus reinem Text bestehen, ohne Markup.

**manpage_end**
: Dokumentstruktur. Befehl zum Beenden einer Manpage bzw. eines Dokuments. Alles, was im Dokument nach diesem Befehl folgt, ist ein Fehler.

**method** *text*
: Textmarkierung. Der Argumenttext wird als Name einer *Objekt*-*Methode* markiert, d. h. als Unterbefehl eines Tcl-Befehls. Der Text kann bereits andere Markierungen enthalten. Zu den Hauptanwendungsbereichen zählen die Hervorhebung der Namen von Methoden in Freitext sowie die Befehlsparameter der Markierungsbefehle **call** und **usage**.

**moddesc** *text*
: Dokumentinformationen. Kopf. Registriert das Argument im Klartext als Kurzbeschreibung des Moduls, in dem die Manpage steht.

**namespace** *text*
: Textmarkierung. Der Text wird als Namespace-Name markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung von Namespace-Namen in Freitext.

**nl** *(deprecated — use* **para**_)_
: *Veraltet*. Textstruktur. Den kanonischen Befehl zum Einfügen von Absatzumbrüchen in den Text finden Sie unter **para**.

**opt** *text*
: Textauszeichnung. Der Argumenttext wird als *optional* markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung optionaler Argumente; siehe den Befehl arg **arg**.

**opt_def** *name* ?*arg*?
: Textstruktur. Listenelement. Optionsliste. Schließt automatisch das vorherige Listenelement. Legt *name* und die Argumente der durch das Listenelement beschriebenen *option* fest. Es wird erwartet, dass der Name mit **option** markiert ist.

**option** *text*
: Textmarkierung. Das Argument wird als *Option* markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung von Optionen, auch als Befehlsschalter bezeichnet, entweder in Freitext oder in den Argumenten der Befehle **call** und **usage**.

**package** *text*
: Textauszeichnung. Das Argument wird als Name eines *package* markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung von Paketnamen in Freitext.

**para**
: Textstruktur. Dieser Befehl unterteilt Freitext in Absätze. Jeder Befehl schließt den ihm vorausgehenden Absatz ab und leitet einen neuen Absatz für den darauf folgenden Text ein. Höherliegende Strukturformen sind Abschnitte und Unterabschnitte.

**rb**
: Text. Der Befehl wird durch eine rechte Klammer ersetzt. Verwendung in frei formatiertem Text. Erforderlich, um zu verhindern, dass eine rechte Klammer als Ende eines Markup-Befehls interpretiert wird.

**require** *package* ?*version*...?
: Dokumentinformationen. Kopf. Dieser Befehl registriert sein Argument *package* als Namen eines Pakets oder einer Anwendung, das bzw. die von dem beschriebenen Paket oder der beschriebenen Anwendung benötigt wird. Zudem kann eine Reihe von erforderlichen Versionen angegeben werden. Dieses Argument kann mit Markup versehen werden. Das übliche Markup lautet **opt**.

**section** *name*
: Textstruktur. Dieser Befehl leitet einen neuen, benannten Dokumentabschnitt ein. Das Argument muss aus reinem Text bestehen. Er schließt implizit den letzten ihm vorausgehenden Absatz und eröffnet ebenfalls implizit den ersten Absatz des neuen Abschnitts.

**sectref** *id* ?*text*?
: Textmarkierung. Formatiert einen Verweis auf den durch *id* gekennzeichneten Abschnitt. Wenn kein *text* festgelegt wird, wird in der Ausgabe der Titel des betreffenden Abschnitts verwendet; andernfalls wird *text* verwendet.

**sectref-external** *text*
: Textmarkierung. Wie bei **sectref**, mit dem Unterschied, dass davon ausgegangen wird, dass sich der Abschnitt in einem anderen Dokument befindet und daher weder identifiziert werden muss noch eine Überprüfung auf Vorhandensein erfolgt. Es wird lediglich der zu formatierende Text benötigt.

**see_also** *args*
: Dokumentinformationen. Überall. Der Befehl definiert direkte Querverweise auf andere Dokumente. Jedes Argument ist eine Beschriftung im Klartext, die das referenzierte Dokument identifiziert. Wird dieser Befehl mehrfach verwendet, werden alle Argumente kumuliert.

**strong** *text* *(deprecated — use* **emph**_)_
: *Veraltet*. Textauszeichnung. Den kanonischen Befehl zum Hervorheben von Text finden Sie unter **emph**.

**subsection** *name*
: Textstruktur. Dieser Befehl leitet einen neuen, benannten Unterabschnitt eines Abschnitts ein. Das Argument muss aus reinem Text bestehen. Er schließt implizit den letzten ihm vorausgehenden Absatz und eröffnet ebenfalls implizit den ersten Absatz des neuen Unterabschnitts.

**syscmd** *text*
: Textmarkierung. Der Text wird als Name eines externen Befehls markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung externer Befehle in Freitext.

**term** *text*
: Textmarkierung. Das Argument wird als unspezifische Terminologie markiert. Der Text ist möglicherweise bereits mit anderen Markierungen versehen. Die Hauptanwendung besteht in der Hervorhebung wichtiger Begriffe und Konzepte in Freitext.

**titledesc** *desc*
: Dokumentinformationen. Kopf. Optional. Registriert das Klartext-Argument als Titel der Manpage. Der Vorgabewert entspricht dem durch **moddesc** registrierten Wert.

**tkoption_def** *name* *dbname* *dbclass*
: Textstruktur. Listenelement. Widget-Optionsliste. Schließt das vorherige Listenelement automatisch. Legt den *name* der Option fest, wie er in Skripten verwendet wird, den Namen, der von der Optionsdatenbank (*dbname*) verwendet wird, sowie deren Klasse (*dbclass*), das heißt deren Typ. Es wird erwartet, dass der Name mit **option** markiert ist.

**type** *text*
: Textmarkierung. Das Argument wird als Name eines *Datentyps* markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung von Datentypen in Freitext.

**uri** *text* ?*text*?
: Textmarkierung. Das Argument wird als *URI* (d. h. als *Uniform Resource Identifier*) markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung von URIs in Freitext. Das zweite Argument, sofern vorhanden, wird als die für Menschen lesbare Beschreibung des URIs interpretiert. Mit anderen Worten: als dessen Bezeichnung. Ohne explizite Bezeichnung gilt der URI selbst als seine eigene Bezeichnung.

**usage** *args*
: Textmarkierung. Die vollständige Beschreibung finden Sie unter **call**; dieser Befehl ist syntaktisch identisch und stellt dieselben Anforderungen an die Markierung seiner Argumente. Im Gegensatz zu **call** ist es jedoch nicht zulässig, eine Ausgabe zu erzeugen, in der dieser Befehl im Text vorkommt. Der Befehl ist *still*. Der formatierte Text darf nur in einem anderen Abschnitt der Ausgabe erscheinen, beispielsweise in einem Inhaltsverzeichnis oder einer Übersicht, je nach Ausgabeformat.

**var** *text*
: Textmarkierung. Das Argument wird als Name einer *Variablen* markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung von Variablen in Freitext.

**vset** *varname* *value*
: Vorlagen. In dieser Form setzt der Befehl die benannte Dokumentvariable auf den angegebenen *value*. Es wird keine Ausgabe erzeugt. Das heißt, der Befehl wird durch die leere Zeichenkette ersetzt.

**vset** *varname*
: Vorlagen. In dieser Form wird der Befehl durch den Wert der benannten Dokumentvariablen ersetzt

**widget** *text*
: Textmarkierung. Das Argument wird als Name eines *Widgets* markiert. Der Text kann bereits andere Markierungen enthalten. Die Hauptanwendung besteht in der Hervorhebung von Widget-Namen in Freitext.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2007-2010 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
