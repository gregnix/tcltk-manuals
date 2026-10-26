---
CommandName: grammar::me_vm
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - grammar
 - parsing
 - virtual machine
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

grammar::me_vm – Virtuelle Maschine zur Analyse von Token-Strömen

# BESCHREIBUNG

Bitte lesen Sie zunächst das Dokument **grammar::me_intro**, um eine Einleitung in die verschiedenen Dokumente und deren Zusammenhänge zu erhalten.

Dieses Dokument legt eine virtuelle Maschine für das kontrollierte Abgleichen und Parsen von Token-Strömen fest, wobei ein *abstrakter Syntaxbaum* (kurz *AST*) erstellt wird, der die Struktur der Eingabe widerspiegelt. Zu den besonderen Merkmalen der Maschine zählen das Zwischenspeichern und die Wiederverwendung von Teilergebnissen, das Zwischenspeichern der erfassten Eingabe sowie die Möglichkeit, sowohl bei der Eingabe als auch bei der Erstellung des AST zurückzuspringen.

Diese Eigenschaften machen die angegebene virtuelle Maschine besonders nützlich für „Packrat“-Parser, die auf Parsing Expression Grammars basieren. Sie ist jedoch nicht auf diese Art von Parsern beschränkt. Auch herkömmliche LL- und LR-Parser lassen sich damit implementieren.

In den folgenden Abschnitten wird zunächst der abstrakte Zustand der virtuellen ME-Maschinen behandelt und anschließend deren Befehlssatz.

# MASCHINENSTATUS

Eine virtuelle ME-Maschine verwaltet den folgenden Zustand:

*Current token* CT
: Das Token aus der Eingabe, das gerade von der Maschine verarbeitet wird. Diese Information wird von den im Abschnitt **Abgleich von Terminalen** definierten Anweisungen verwendet und verändert.

*Current location* CL
: Die Position des *aktuellen Tokens* im Eingabestrom, ausgedrückt als Offset relativ zum Anfang des Stroms. Das erste Token befindet sich am Offset **0**. Diese Information wird implizit von den in den Abschnitten **Abgleich von Terminalen** und **Abgleich von Nichtterminalen** definierten Anweisungen verwendet und verändert; sie kann zudem durch die in Abschnitt **Verwaltung der Eingabeposition** definierten Anweisungen direkt abgefragt und verändert werden.

*Location stack* LS
: Zusätzlich zu den oben genannten Elementen gibt es einen Stapel mit Positionen für das Zurückverfolgen. Positionen können auf den Stapel gelegt, von diesem entfernt und durch Festlegen der aktuellen Position entfernt werden. Diese Informationen werden implizit durch die in den Abschnitten **Abgleich von Terminalen** und **Abgleich von Nichtterminalen** definierten Anweisungen verwendet und verändert und können durch die im Abschnitt **Verwaltung der Eingabeposition** definierten Anweisungen direkt abgefragt und verändert werden.

*Match status* OK
: Ein boolescher Wert, der das Ergebnis des letzten Versuchs zur Abgleichung der Eingabe darstellt. Er wird auf **true** gesetzt, wenn dieser Versuch erfolgreich war, andernfalls auf **false**. Diese Information wird durch die in den Abschnitten **Abgleich von Terminalen**, **Abgleich von Nichtterminalen** und **Unbedingter Abgleich** definierten Anweisungen beeinflusst. Sie wird durch die im Abschnitt **Ablaufsteuerung** definierten Anweisungen abgefragt.

*Semantic value* SV
: Der semantische Wert, der mit dem letzten Versuch, die Eingabe abzugleichen, verbunden ist (bzw. durch diesen erzeugt wird). Enthält entweder die leere Zeichenkette oder einen Knoten des aus der Eingabe konstruierten abstrakten Syntaxbaums. Diese Information wird durch die in den Abschnitten **Semantische Werte** und **AST-Stack-Verwaltung** definierten Anweisungen beeinflusst.

*AST stack* AS
: Ein Stapel partieller abstrakter Syntaxbäume, die von der Maschine während des Abgleichs erstellt wurden. Diese Informationen werden durch die in den Abschnitten **Semantische Werte** und **AST-Stack-Verwaltung** definierten Anweisungen beeinflusst.

*AST Marker stack* MS
: Zusätzlich zu den oben genannten Elementen gibt es einen „Stack der Stacks“ für das Backtracking. Dabei handelt es sich eigentlich um einen Stack von Markern im AST-Stack, wodurch implizit zu einem bestimmten Zeitpunkt ein Snapshot des Zustands des AST-Stacks erstellt wird. Marker können auf den Stapel gesetzt, von ihm entfernt und dazu verwendet werden, den AST-Stapel auf einen früheren Zustand zurückzusetzen. Diese Informationen werden durch die in den Abschnitten **Semantische Werte** und **AST-Stack-Verwaltung** definierten Anweisungen beeinflusst.

*Error status* ER
: Fehlerinformationen im Zusammenhang mit dem letzten Versuch, die Eingabe abzugleichen. Enthält entweder die leere Zeichenkette oder eine Liste mit zwei Elementen: eine Position in der Eingabe und eine Liste der damit verbundenen Fehlermeldungen, in dieser Reihenfolge. *Hinweis*: Fehlerinformationen werden auch dann gesetzt, wenn der letzte Versuch, die Eingabe abzugleichen, erfolgreich war. Beispielsweise ist der Ausdruck \*-operator (der nullmal oder mehrmals auf einen Teilausdruck passt) in einer Parsing-Ausdrucksgrammatik stets erfolgreich, selbst wenn weiter hinten in der Eingabe ein Problem auftritt und ein Rückwärtsablauf erforderlich wird. Solche Probleme dürfen bei der Fortsetzung des Abgleichs nicht außer Acht gelassen werden. Diese Informationen werden durch die in den Abschnitten **Abgleich von Terminalen**, **Abgleich von Nichtterminalen** und **Fehlerbehandlung** definierten Anweisungen abgefragt und beeinflusst.

*Error stack* ES
: Zusätzlich zu den oben genannten Informationen wird ein Stapel mit Informationen zu Fehlern bereitgestellt, um bei der Rückverfolgung in Auswahlmöglichkeiten nach einem erfolglosen Abgleich die Zusammenführung aktueller und älterer Informationen zu Fehlern zu ermöglichen. Diese Informationen werden anhand der in den Abschnitten **Abgleich von Terminalen**, **Abgleich von Nichtterminalen** und **Fehlerbehandlung** definierten Anweisungen abgefragt und beeinflusst.

*Return stack* RS
: Ein Stapel von Programmzählern, d. h. Speicherorte im Code, die die virtuelle Maschine steuern, zur Verwaltung von Unterprogrammaufrufen, d. h. zum Abgleich von nichtterminalen Symbolen. Diese Informationen werden durch die im Abschnitt **Abgleich von Nichtterminalen** definierten Befehle abgefragt und beeinflusst.

*Nonterminal cache* NC
: Ein Cache mit Maschinenzuständen (ein 4-Tupel, das eine Position im Eingabestrom, den Übereinstimmungsstatus *OK*, den semantischen Wert *SV* und den Fehlerstatus *ER* enthält), der anhand des Namens des nichtterminalen Symbols und der Position im Eingabestrom indiziert ist. Die Schlüsselposition ist die Stelle, an der die Maschine den Versuch gestartet hat, das benannte nichtterminale Symbol abzugleichen, und die Position im Wert ist die Stelle, an der die Maschine nach Abschluss des Versuchs gelandet ist, unabhängig vom Erfolg des Versuchs. Dieser Status wird durch die im Abschnitt **Abgleich von Nichtterminalen** definierten Anweisungen abgefragt und beeinflusst.


# MASCHINENBEFEHLE

Nachdem der Maschinenzustand festgelegt wurde, lässt sich nun der Befehlssatz der virtuellen ME-Maschinen erläutern. Diese sind grob nach dem Maschinenzustand gruppiert, den sie beeinflussen und/oder abfragen.

## Abgleich von Terminalen

Zunächst die Anweisungen zum Abgleichen von Tokens aus dem Eingabestrom und damit auch aller Terminalsymbole als Erweiterung.

Diese Befehle sind die einzigen, die ein neues Token aus dem Eingabestrom abrufen können. Es handelt sich hierbei um ein „können“ und nicht um ein „werden“, da die Befehle ein neues Token genau dann abrufen, wenn sich die aktuelle Position *CL* an der Spitze des Stroms befindet. Wenn die Maschine einen Rücklauf durchgeführt hat (siehe **icl_rewind**), holen die Befehle das zu vergleichende Token aus dem internen Cache.

**ict_advance** *message*
: Diese Anweisung versucht, zum nächsten Token im Eingabestrom zu springen, d. h. zu dem Token, das auf die aktuelle Position *CL* folgt. Die Anweisung schlägt genau dann fehl, wenn das Ende des Eingabestroms erreicht ist, d. h., wenn kein nächstes Token vorhanden ist. Der Erfolg bzw. Misserfolg der Anweisung wird im Übereinstimmungsstatus *OK* gespeichert. Im Falle eines Fehlers wird der Fehlerstatus *ER* auf die aktuelle Position gesetzt und die Meldung *message* hinterlegt. Im Erfolgsfall wird der Fehlerstatus *ER* gelöscht, das neue Token wird zum aktuellen Token *CT* und die neue Position wird zur aktuellen Position *CL*. Das Argument *message* ist ein Verweis auf die Zeichenkette, die bei Bedarf in den Fehlerstatus *ER* gesetzt werden soll.

**ict_match_token** *tok* *message*
: Diese Anweisung führt Tests durch, um zu prüfen, ob das aktuelle Token *CT* mit dem Argument *tok* übereinstimmt, und speichert das Ergebnis im Übereinstimmungsstatus *OK*. Die Anweisung schlägt fehl, wenn das aktuelle Token nicht mit *tok* übereinstimmt. Im Falle eines Fehlers wird der Fehlerstatus *ER* auf die aktuelle Position *CL* und die Meldung *message* gesetzt, und die aktuelle Position *CL* wird um ein Token zurückversetzt. Andernfalls, d. h. bei Erfolg, wird der Fehlerstatus *ER* gelöscht und die aktuelle Position *CL* bleibt unverändert.

**ict_match_tokrange** *tokbegin* *tokend* *message*
: Diese Anweisung führt Tests durch, um zu prüfen, ob sich das aktuelle Token *CT* im Bereich der Token von *tokbegin* bis *tokend* (einschließlich) befindet, und speichert das Ergebnis im Übereinstimmungsstatus *OK*. Die Anweisung schlägt fehl, wenn sich das aktuelle Token nicht innerhalb dieses Bereichs befindet. Im Falle eines Fehlers wird der Fehlerstatus *ER* auf die aktuelle Position *CL* und die Meldung *message* gesetzt, und die aktuelle Position *CL* wird um ein Token zurückversetzt. Andernfalls, d. h. bei Erfolg, wird der Fehlerstatus *ER* gelöscht und die aktuelle Position *CL* bleibt unverändert.

**ict_match_tokclass** *code* *message*
: Diese Anweisung testet, ob das aktuelle Token *CT* zur Tokenklasse *code* gehört, und speichert das Ergebnis im Übereinstimmungsstatus *OK*. Die Anweisung schlägt fehl, wenn das aktuelle Token nicht zur angegebenen Klasse gehört. Im Falle eines Fehlers wird der Fehlerstatus *ER* auf die aktuelle Position *CL* und die Meldung *message* gesetzt, und die aktuelle Position *CL* wird um ein Token zurückversetzt. Andernfalls, d. h. bei Erfolg, wird der Fehlerstatus *ER* gelöscht und die aktuelle Position *CL* bleibt unverändert. Derzeit sind folgende Klassen zulässig:


**alnum**
: Ein Token wird akzeptiert, wenn es sich um ein alphabetisches Unicode-Zeichen oder eine Ziffer handelt.

**alpha**
: Ein Token wird akzeptiert, wenn es sich um ein alphabetisches Unicode-Zeichen handelt.

**digit**
: Ein Token wird akzeptiert, wenn es sich um ein Unicode-Ziffernzeichen handelt.

**xdigit**
: Ein Token wird akzeptiert, wenn es sich um ein hexadezimales Ziffernzeichen handelt.

**punct**
: Ein Token wird akzeptiert, wenn es sich um ein Unicode-Satzzeichen handelt.

**space**
: Ein Token wird akzeptiert, wenn es sich um ein Unicode-Leerzeichen handelt.


## Abgleich von Nichtterminalen

Die Anweisungen in diesem Abschnitt befassen sich mit der Zuordnung von Nichtterminal-Symbolen. Sie fragen den Nichtterminal-Cache *NC* nach gespeicherten Informationen ab und speichern diese Informationen im Cache.

Die Verwendung des Caches dient als Leistungsoptimierung für Backtracking-Parser und ermöglicht es ihnen, eine aufwendige erneute Überprüfung komplexer nichtterminaler Symbole zu vermeiden, sofern diese bereits zuvor angetroffen wurden.

**inc_restore** *branchlabel* *nt*
: Diese Anweisung prüft, ob der Nichtterminal-Cache *NC* Informationen über das Nichtterminal-Symbol *nt* an der aktuellen Position *CL* enthält. Wenn dies der Fall ist, aktualisiert die Anweisung den Maschinenzustand (aktuelle Position *CL*, Übereinstimmungsstatus *OK*, semantischer Wert *SV* und Fehlerstatus *ER*) mit den gefundenen Informationen und setzt die Ausführung an der durch das *branchlabel* bezeichneten Anweisung fort. Die neue aktuelle Position *CL* ist das letzte Token, das mit dem Nichtterminal-Symbol übereinstimmt, d. h. zu diesem gehört. Wurden keine Informationen gefunden, setzt der Befehl die Ausführung mit dem nächsten Befehl fort. Zusammen mit **icf_ntcall** ist es möglich, Code für memoisiertes und nicht-memoisiertes Abgleichen von Nichtterminalsymbolen zu generieren, entweder als Unterprogrammaufrufe oder inline im Aufrufer.

**inc_save** *nt*
: Dieser Befehl speichert den aktuellen Zustand der Maschine (aktuelle Position *CL*, Übereinstimmungsstatus *OK*, semantischer Wert *SV* und Fehlerstatus *ER*) im Nichtterminal-Cache *NC*. Zudem wird ein Eintrag aus dem Positionsstapel *LS* entfernt und als Startposition der Übereinstimmung gespeichert. Es wird erwartet, dass dieser Befehl am Ende des Abgleichs eines Nichtterminalsymbols aufgerufen wird, wobei *nt* der Name des Nichtterminalsymbols ist, mit dem der Code gerade gearbeitet hat. Dadurch kann die Anweisung **inc_restore** die Daten überprüfen und abrufen, falls wir dieses nichtterminale Symbol während des Backtrackings erneut an derselben Stelle abgleichen müssen.

**icf_ntcall** *branchlabel*
: Diese Anweisung ruft den Code zum Abgleichen des nichtterminalen Symbols *nt* als Unterprogramm auf. Zu diesem Zweck speichert sie den aktuellen Programmzähler *PC* auf dem Rückgabestapel *RS*, die aktuelle Position *CL* auf dem Positionsstapel *LS* und setzt die Ausführung anschließend an der Adresse *branchlabel* fort. Das nächste passende **icf_ntreturn** bewirkt, dass die Ausführung mit dem Befehl fortgesetzt wird, der auf den Aufruf folgt.

**icf_ntreturn**
: Dieser Befehl holt einen Eintrag vom Rückgabestapel *RS* ab, weist ihn dem Programmzähler *PC* zu und setzt die Ausführung anschließend an der neuen Adresse fort.


## Unbedingter Abgleich

Die Anweisungen in diesem Abschnitt beziehen sich auf die übrigen Abgleichoperatoren. Sie ändern den Abgleichstatus *OK* direkt und bedingungslos.

**iok_ok**
: Dieser Befehl weist **true** den Abgleichstatus *OK* zu, was einen erfolgreichen Abgleich anzeigt.

**iok_fail**
: Mit diesem Befehl wird der Abgleichstatus *OK* auf **false** gesetzt, was einen fehlgeschlagenen Abgleich anzeigt.

**iok_negate**
: Diese Anweisung kehrt den Übereinstimmungsstatus *OK* um, wodurch ein Fehler zu einem Erfolg wird und umgekehrt.


## Ablaufsteuerung

Die Anweisungen in diesem Abschnitt implementieren sowohl bedingte als auch unbedingte Kontrollflüsse. Die bedingten Sprünge fragen den Übereinstimmungsstatus *OK* ab.

**icf_jalways** *branchlabel*
: Dieser Befehl setzt den Programmzähler *PC* auf die durch *branchlabel* angegebene Adresse und setzt die Ausführung von dort aus fort. Hierbei handelt es sich um einen bedingungslosen Sprung.

**icf_jok** *branchlabel*
: Dieser Befehl setzt den Programmzähler *PC* auf die durch *branchlabel* angegebene Adresse. Dies geschieht genau dann, wenn der Übereinstimmungsstatus *OK* einen Erfolg anzeigt. Andernfalls wird die Ausführung einfach mit dem nächsten Befehl fortgesetzt. Hierbei handelt es sich um einen bedingten Sprung.

**icf_jfail** *branchlabel*
: Dieser Befehl setzt den Programmzähler *PC* auf die durch *branchlabel* angegebene Adresse. Dies geschieht genau dann, wenn der Abgleichstatus *OK* einen Fehler anzeigt. Andernfalls wird die Ausführung einfach mit dem nächsten Befehl fortgesetzt. Hierbei handelt es sich um einen bedingten Sprung.

**icf_halt**
: Dieser Befehl hält die Maschine an und unterbricht die weitere Ausführung.


## Verwaltung der Eingabeposition

Die Anweisungen in diesem Abschnitt dienen dem Backtracking; sie manipulieren die aktuelle Position *CL* des Maschinenzustands. Sie ermöglichen es einem Benutzer der Maschine, Positionen in der Eingabe abzufragen und zu speichern sowie die aktuelle Position *CL* auf gespeicherte Positionen zurückzusetzen, wodurch sie zu einer der Komponenten gehören, die die Implementierung von Backtracking-Parsern ermöglichen.

**icl_push**
: Dieser Befehl schiebt eine Kopie der aktuellen Position *CL* auf den Positionsstapel *LS*.

**icl_rewind**
: Dieser Befehl entnimmt dem Positionsstapel *LS* einen Eintrag und versetzt anschließend die aktuelle Position *CL* zurück an diese Stelle in der Eingabe.

**icl_pop**
: Dieser Befehl entnimmt dem Positionsstapel *LS* einen Eintrag und verwirft ihn.


## Fehlerbehandlung

Die Anweisungen in diesem Abschnitt ermöglichen den Lese- und Schreibzugriff auf den Fehlerstatus *ER* der Maschine.

**ier_push**
: Dieser Befehl schiebt eine Kopie des aktuellen Fehlerstatus *ER* auf den Fehlerstapel *ES*.

**ier_clear**
: Dieser Befehl löscht den Fehlerstatus *ER*.

**ier_nonterminal** *message*
: Dieser Befehl prüft, ob der Fehlerstatus *ER* einen Fehler enthält, dessen Position unmittelbar hinter der Position liegt, die im obersten Eintrag des Positionsstapels *LS* gefunden wurde. Wird kein solcher Fehler gefunden, geschieht nichts. Andernfalls wird der gefundene Fehler durch einen Fehler an der im Stapel gefundenen Position ersetzt, der die Meldung *message* aufweist.

**ier_merge**
: Diese Anweisung entnimmt dem Fehlerstapel *ES* einen Eintrag, führt eine Zusammenführung mit dem aktuellen Fehlerstatus *ER* durch und speichert das Ergebnis dieser Zusammenführung als neuen Fehlerstatus *ER*. Die Zusammenführung erfolgt wie folgt: Ist einer der beiden Fehlerstatus-Einträge leer, wird der andere ausgewählt. Wenn beide Fehlerstatus nicht leer sind und sie sich auf unterschiedliche Stellen beziehen, wird der Fehlerstatus mit der weiter in der Eingabe liegenden Stelle ausgewählt. Wenn beide Fehlerstatus auf dieselbe Stelle verweisen, werden ihre Meldungen zusammengeführt (wobei Duplikate entfernt werden).


## Semantische Werte

Die Anweisungen in diesem Abschnitt beeinflussen den semantischen Wert *SV*.

**isv_clear**
: Dieser Befehl löscht den semantischen Wert *SV*.

**isv_terminal**
: Diese Anweisung erzeugt einen Terminalknoten im AST für das aktuelle Token *CT*, macht ihn zum semantischen Wert *SV* und legt den Knoten außerdem auf den AST-Stapel *AS*.

**isv_nonterminal_leaf** *nt*
: Diese Anweisung erstellt einen nichtterminalen AST-Knoten ohne Kindknoten für das Nichtterminal *nt* und macht ihn zum semantischen Wert *SV*. Diese Anweisung sollte genau dann ausgeführt werden, wenn der Übereinstimmungsstatus *OK* einen Erfolg anzeigt. Im Falle eines Fehlers sollte **isv_clear** aufgerufen werden.

**isv_nonterminal_range** *nt*
: Diese Anweisung erstellt einen nichtterminalen AST-Knoten für das Nichtterminal *nt* mit einem einzelnen Terminalknoten als Kindknoten und macht diesen AST zum semantischen Wert *SV*. Der terminale Knoten bezieht sich auf die Eingabezeichenfolge von der Position, die sich ganz oben auf dem Positionsstapel *LS* befindet, bis zur aktuellen Position *CL* (beide einschließlich). Diese Anweisung sollte genau dann ausgeführt werden, wenn der Übereinstimmungsstatus *OK* einen Erfolg anzeigt. Im Falle eines Fehlers sollte **isv_clear** aufgerufen werden.

**isv_nonterminal_reduce** *nt*
: Diese Anweisung erstellt einen nichtterminalen AST-Knoten für das Nichtterminal *nt* und macht ihn zum semantischen Wert *SV*. Alle Einträge auf dem AST-Stapel *AS*, die über dem Marker liegen, der im obersten Eintrag des AST-Marker-Stapels *MS* gefunden wurde, werden zu Kindern des neuen Knotens, wobei der Eintrag an der Stapelspitze zum Kind ganz rechts wird. Wenn der AST-Marker-Stapel *MS* leer ist, wird der gesamte Stapel verwendet. Der AST-Marker-Stapel *MS* bleibt unverändert. Diese Anweisung sollte genau dann ausgeführt werden, wenn der Übereinstimmungsstatus *OK* einen Erfolg anzeigt. Im Falle eines Fehlers sollte **isv_clear** aufgerufen werden.


## AST-Stack-Verwaltung

Die Anweisungen in diesem Abschnitt bearbeiten den AST-Stapel *AS* und den AST-Marker-Stapel *MS*.

**ias_push**
: Diese Anweisung schiebt den semantischen Wert *SV* auf den AST-Stapel *AS*.

**ias_mark**
: Dieser Befehl schiebt einen Marker für den aktuellen Zustand des AST-Stapels *AS* auf den AST-Marker-Stapel *MS*.

**ias_mrewind**
: Dieser Befehl entnimmt dem AST-Marker-Stack *MS* einen Eintrag und fährt anschließend fort, Einträge aus dem AST-Stack *AS* zu entnehmen, bis der durch den entnommenen Marker dargestellte Zustand erneut erreicht ist. Es erfolgt keine Aktion, wenn der AST-Stack *AS* bereits kleiner ist als durch den entnommenen Marker angegeben.

**ias_mpop**
: Dieser Befehl entnimmt dem AST-Marker-Stack *MS* einen Eintrag und verwirft ihn.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *grammar_me* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Grammatiken und endliche Automaten

# COPYRIGHT

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
