---
CommandName: pt::param
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
 - LL(k)
 - PEG
 - TDPL
 - context-free languages
 - expression
 - grammar
 - matching
 - parser
 - parsing expression
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - state
 - top-down parsing languages
 - transducer
 - virtual machine
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

pt::param – Spezifikation der PackRat-Maschine

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
:::

# BESCHREIBUNG

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Willkommen bei der PackRat Machine (kurz: *PARAM*), einer virtuellen Maschine, die speziell auf die Unterstützung rekursiver Abstiegsparser, insbesondere von Packrat-Parsern, ausgerichtet ist. Zu diesem Zweck verfügt sie über Funktionen wie das Zwischenspeichern und die Wiederverwendung von Teilergebnissen, das Zwischenspeichern der gelesenen Eingabe sowie die Möglichkeit, sowohl bei der Eingabe als auch bei der Erstellung des AST zurückzuspringen.

Dieses Dokument legt den Architekturzustand und den Befehlssatz der Maschine fest.

# ARCHITEKTURZUSTAND

Jede PARAM-Implementierung muss mindestens den folgenden Zustand verwalten:

*Eingabe* (IN)
: Dies ist der Kanal, aus dem die zu verarbeitenden Zeichen gelesen werden. Dieser Teil des Maschinenzustands wird von den im Abschnitt **Eingabeverarbeitung** definierten Befehlen verwendet und verändert.

*Aktuelles Zeichen* (CC)
: Das Zeichen aus der *Eingabe*, das gerade gegen seine möglichen Alternativen geprüft wird. Dieser Teil des Maschinenzustands wird von den im Abschnitt **Zeichenverarbeitung** definierten Befehlen verwendet und verändert.

*Aktuelle Position* (CL)
: Die Position des *aktuellen Zeichens* in der *Eingabe*, ausgedrückt als Versatz relativ zum Anfang der Eingabe. Zeichen-Offsets werden ab **0** gezählt. Dieser Teil des Maschinenzustands wird von den Befehlen verwendet und verändert, die in den Abschnitten **Zeichenverarbeitung**, **Positionsverwaltung** und **Ausführung von Nichtterminalen** definiert sind.

*Positionsstapel* (LS)
: Ein Stapel von Positionen in der *Eingabe*, gespeichert für mögliches Backtracking. Dieser Teil des Maschinenzustands wird von den Befehlen verwendet und verändert, die in den Abschnitten **Zeichenverarbeitung**, **Positionsverwaltung** und **Ausführung von Nichtterminalen** definiert sind.

*Status* (ST)
: Der Status des letzten Versuchs, die *Eingabe* zu prüfen, der entweder Erfolg oder Fehlschlag anzeigt. Dieser Teil des Maschinenzustands wird von den Befehlen verwendet und verändert, die in den Abschnitten **Statussteuerung**, **Zeichenverarbeitung** und **Ausführung von Nichtterminalen** definiert sind.

*Semantischer Wert* (SV)
: Der aktuelle semantische Wert, der entweder leer ist oder einen Knoten des aus der Eingabe konstruierten AST darstellt. Dieser Teil des Maschinenzustands wird von den in den Abschnitten **Aufbau von Werten** und **AST-Aufbau** definierten Anweisungen verwendet und verändert.

*AST-Reduktionsstapel* (ARS)
: Der Stapel aus Teil-ASTs, der während des Prozesses der Verarbeitung von nichtterminalen Symbolen aufgebaut wird. Dieser Teil des Maschinenzustands wird durch die in den Abschnitten **Aufbau von Werten** und **AST-Aufbau** definierten Befehle verwendet und verändert.

*AST-Stapel* (AS)
: Der Stapel der Reduktionsstapel, der für ein eventuelles Zurückverfolgen gespeichert wird. Dieser Teil des Maschinenzustands wird von den Befehlen verwendet und verändert, die in den Abschnitten **Aufbau von Werten** und **AST-Aufbau** definiert sind.

*Fehlerstatus* (ER)
: Der aktuelle Fehlerzustand der Maschine. Dieser ist entweder leer oder auf ein Paar aus einer Position in der Eingabe und der Menge der Meldungen für diese Position gesetzt. *Hinweis*: Dieser Teil des Maschinenzustands kann auch dann gesetzt werden, wenn der letzte Test des *aktuellen Zeichens* erfolgreich war. Beispielsweise ist der Operator \* (er passt auf einen Teilausdruck null- oder mehrmals) in einer PEG immer erfolgreich, selbst wenn weiter hinten in der Eingabe ein Problem auftritt und zurückgesetzt werden muss. Solche Probleme dürfen beim Fortsetzen des Parsens nicht vergessen werden. Dieser Teil des Maschinenzustands wird durch die in den Abschnitten **Fehlerbehandlung**, **Zeichenverarbeitung** und **Ausführung von Nichtterminalen** definierten Anweisungen verwendet und verändert.

*Fehlerstapel* (ES)
: Der Stapel der Fehler-Stati, der für das Backtracking gespeichert wird. Dies ermöglicht es der Maschine, aktuelle und ältere Fehler-Stati zusammenzuführen, wenn sie nach einem fehlgeschlagenen Abgleich ein Backtracking bei Auswahlmöglichkeiten durchführt. Dieser Teil des Maschinenzustands wird von den Anweisungen verwendet und verändert, die in den Abschnitten **Fehlerbehandlung**, **Zeichenverarbeitung** und **Ausführung von Nichtterminalen** definiert sind.

*Nichtterminal-Cache* (NC)
: Ein Cache mit Maschinenzuständen, die durch Paare aus dem Namen eines nichtterminalen Symbols und einer Position in der Eingabe indiziert sind. Jedem Paar (N, L) ist ein 4-Tupel zugeordnet, das die Werte für CL, ST, SV und ER enthält, die zu verwenden sind, nachdem das Nichtterminal N ab der Position L geparst wurde. Es hilft Backtracking-Parsern bei der Leistung und ermöglicht es ihnen, ein aufwendiges erneutes Parsen komplexer Nichtterminale zu vermeiden, wenn diese an einer gegebenen Position schon einmal vorgekommen sind. Die Schlüsselposition ist die Stelle, an der die Maschine den Versuch begann, das genannte nichtterminale Symbol abzugleichen, und die Position im gespeicherten 4-Tupel ist die Stelle, an der die Maschine nach Abschluss des Versuchs endete, unabhängig vom Erfolg des Versuchs. Dieser Teil des Maschinenzustands wird von den im Abschnitt **Ausführung von Nichtterminalen** definierten Anweisungen verwendet und modifiziert.

*Terminal-Cache* (TC)
: Ein Cache mit aus IN gelesenen Zeichen, deren Position in IN als Paar aus Zeile und Spalte angegeben ist, indiziert nach der Position in IN, diesmal als Zeichenversatz vom Anfang von IN. Es hilft Backtracking-Parsern, ein möglicherweise aufwendiges erneutes Lesen von Zeichen aus IN zu vermeiden, und ermöglicht sogar Backtracking, wenn IN nicht wahlfrei positionierbar ist. Dieser Teil des Maschinenzustands wird von den im Abschnitt **Eingabeverarbeitung** definierten Befehlen verwendet und modifiziert.


# BEFEHLSSATZ

Nachdem der Architekturzustand der Maschine festgelegt ist, ist es nun möglich, den Befehlssatz zu definieren, der auf diesen Zustand einwirkt und von jeder Implementierung des PARAM ausgeführt werden soll. Die 37 Befehle sind grob nach dem Zustand gruppiert, auf den sie während ihrer Ausführung einwirken und/oder den sie abfragen.

## Eingabeverarbeitung

Die Befehle in diesem Abschnitt greifen hauptsächlich auf IN zu und holen die zu verarbeitenden Zeichen in die Maschine.

**input_next** *msg*
: Diese Methode liest das nächste Zeichen, d. h. das Zeichen nach CL, aus IN. Bei Erfolg wird dieses Zeichen zu CC, CL wird um eins erhöht, ES wird gelöscht und der Vorgang wird in ST als erfolgreich vermerkt. Der Vorgang kann das Zeichen aus IN lesen, falls das nächste Zeichen TC noch nicht bekannt ist. Bei Erfolg wird das neue Zeichen zusammen mit seiner Position (Zeile, Spalte) in TC gespeichert; ansonsten verhält sich die Operation wie oben beschrieben. Zukünftige Lesevorgänge von derselben Position – die aufgrund von Backtracking möglich sind – werden dann aus TC statt aus IN bedient. Wenn hingegen das Ende von IN erreicht wurde, wird der Vorgang in ST als fehlgeschlagen vermerkt, CL bleibt unverändert, und das Paar aus CL und *msg* wird zum neuen ES.


## Zeichenverarbeitung

Die Befehle in diesem Abschnitt greifen hauptsächlich auf CC zu und prüfen es anhand von Zeichenklassen, Zeichenbereichen und einzelnen Zeichen.

**test_alnum**
: Diese Anweisung implementiert den speziellen PE-Operator „alnum“, der prüft, ob CC in die gleichnamige Zeichenklasse fällt oder nicht. Sowohl der Erfolg als auch das Scheitern der Tests werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (mit Kodierung als Blatt-Parsing-Ausdruck) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_alpha**
: Diese Anweisung implementiert den speziellen PE-Operator „alpha“, der prüft, ob CC in die gleichnamige Zeichenklasse fällt oder nicht. Sowohl der Erfolg als auch das Scheitern der Prüfung werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (bei der die Kodierung als Blatt-Parsing-Ausdruck erfolgt) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_ascii**
: Diese Anweisung implementiert den speziellen PE-Operator „ascii“, der prüft, ob CC zur gleichnamigen Zeichenklasse gehört oder nicht. Sowohl der Erfolg als auch das Scheitern der Tests werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (mit Kodierung als Blatt-Parsing-Ausdruck) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgesetzt wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_char** *char*
: Diese Anweisung implementiert den Operator zur Zeichenübereinstimmung, d. h., sie prüft, ob CC gleich *char* ist. Sowohl der Erfolg als auch das Scheitern der Tests werden direkt in ST protokolliert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (bei der die Kodierung als Blatt-Parsing-Ausdruck erfolgt) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_ddigit**
: Diese Anweisung implementiert den speziellen PE-Operator „ddigit“, der prüft, ob CC zur gleichnamigen Zeichenklasse gehört oder nicht. Sowohl der Erfolg als auch das Scheitern der Tests werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (mit Kodierung als Blatt-Parsing-Ausdruck) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_digit**
: Diese Anweisung implementiert den speziellen PE-Operator „digit“, der prüft, ob CC zur gleichnamigen Zeichenklasse gehört oder nicht. Sowohl der Erfolg als auch das Scheitern der Prüfung werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (bei der die Kodierung als Blatt-Parsing-Ausdruck erfolgt) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_graph**
: Diese Anweisung implementiert den speziellen PE-Operator „graph“, der prüft, ob CC in die gleichnamige Zeichenklasse fällt oder nicht. Sowohl der Erfolg als auch das Scheitern der Prüfung werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (mit Kodierung als Blatt-Parsing-Ausdruck) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_lower**
: Diese Anweisung implementiert den speziellen PE-Operator „lower“, der prüft, ob CC zur gleichnamigen Zeichenklasse gehört oder nicht. Sowohl der Erfolg als auch das Scheitern der Tests werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (in Form eines Blatt-Parsing-Ausdrucks) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_print**
: Diese Anweisung implementiert den speziellen PE-Operator „print“, der prüft, ob CC zur gleichnamigen Zeichenklasse gehört oder nicht. Sowohl der Erfolg als auch das Scheitern der Prüfung werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (mit Kodierung als Blatt-Parsing-Ausdruck) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_punct**
: Diese Anweisung implementiert den speziellen PE-Operator „punct“, der prüft, ob CC in die gleichnamige Zeichenklasse fällt oder nicht. Sowohl der Erfolg als auch das Scheitern der Prüfung werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (bei der die Kodierung als Blatt-Parsing-Ausdruck erfolgt) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_range** *chars* *chare*
: Diese Anweisung implementiert den Bereichsabgleichsoperator, d. h., sie prüft, ob CC in das Zeichenintervall fällt, das von den beiden Zeichen *chars* bis *chare* (beide eingeschlossen) gebildet wird. Sowohl der Erfolg als auch das Scheitern der Tests werden direkt in ST protokolliert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (mit Kodierung als Blatt-Parsing-Ausdruck) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_space**
: Diese Anweisung implementiert den speziellen PE-Operator „space“, der prüft, ob CC in die gleichnamige Zeichenklasse fällt oder nicht. Sowohl der Erfolg als auch das Scheitern der Prüfung werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (mit Kodierung als Blatt-Parsing-Ausdruck) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_upper**
: Diese Anweisung implementiert den speziellen PE-Operator „upper“, der prüft, ob CC zur gleichnamigen Zeichenklasse gehört oder nicht. Sowohl der Erfolg als auch das Scheitern der Tests werden direkt in ST vermerkt. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (mit Kodierung als Blatt-Parsing-Ausdruck) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_wordchar**
: Diese Anweisung implementiert den speziellen PE-Operator „wordchar“, der prüft, ob CC zur gleichnamigen Zeichenklasse gehört oder nicht. Sowohl der Erfolg als auch das Scheitern der Tests werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (mit Kodierung als Blatt-Parsing-Ausdruck) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.

**test_xdigit**
: Diese Anweisung implementiert den speziellen PE-Operator „xdigit“, der prüft, ob CC zur gleichnamigen Zeichenklasse gehört oder nicht. Sowohl der Erfolg als auch das Scheitern der Prüfung werden direkt in ST gespeichert. Bei Erfolg wird ES gelöscht, während bei Scheitern das Paar aus CL und der erwarteten Eingabe (bei der die Kodierung als Blatt-Parsing-Ausdruck erfolgt) als neuer ES gesetzt wird und CL anschließend um ein Zeichen zurückgespult wird, um die Maschine auf einen weiteren Parsing-Versuch mit einer möglichen Alternative vorzubereiten.


## Fehlerbehandlung

Die Anweisungen in diesem Abschnitt greifen hauptsächlich auf ER und ES zu.

**error_clear**
: Dieser Befehl löscht ER.

**error_push**
: Dieser Befehl erstellt eine Kopie von ER und legt diese auf ES ab.

**error_pop_merge**
: Dieser Befehl nimmt den obersten Eintrag von ES und führt den darin enthaltenen Fehlerstatus mit ER zusammen; das Ergebnis wird der neue ER. Die Zusammenführung unterliegt vier Regeln, wobei das Ergebnis der Zusammenführung


**\[1\]**
: Leer, wenn beide Zustände leer sind.

**\[2\]**
: Der nicht leere Zustand, wenn nur einer der beiden Zustände nicht leer ist.

**\[3\]**
: Der Zustand mit der größeren Position, wenn die beiden Zustände verschiedene Positionen angeben.

**\[4\]**
: Das Paar aus der beiden Zuständen gemeinsamen Position und der Vereinigungsmenge ihrer Meldungen, wenn die Zustände dieselbe Position haben.


**error_nonterminal** *symbol*
: Dies ist ein bewachter Befehl. Er führt keine Aktion aus, wenn ES leer ist oder die Position in ES nicht unmittelbar hinter der zuletzt in LS gespeicherten Position liegt. Andernfalls legt er das Paar aus dieser Position und dem Nichtterminal *symbol* als neues ES fest. *Hinweis*: Im obigen Zusammenhang bedeutet „unmittelbar danach“ „diese Position plus eins“ oder auch „die Position des nächsten Zeichens nach dieser Position“.


## Statussteuerung

Die Anweisungen in diesem Abschnitt greifen direkt auf ST zu.

**status_ok**
: Dieser Befehl setzt ST auf **true** und protokolliert den Erfolg.

**status_fail**
: Dieser Befehl setzt ST auf **false** und protokolliert dabei einen Fehler.

**status_negate**
: Dieser Befehl kehrt den Wert von ST um und verwandelt damit einen Fehlschlag in einen Erfolg und umgekehrt.


## Positionsverwaltung

Die Befehle in diesem Abschnitt greifen auf CL und LS zu.

**loc_push**
: Dieser Befehl erstellt eine Kopie von CL und schiebt diese auf LS.

**loc_pop_discard**
: Dieser Befehl nimmt die zuletzt gespeicherte Position von LS herunter.

**loc_pop_rewind**
: Dieser Befehl nimmt die zuletzt gespeicherte Position von LS und stellt sie als CL wieder her.


## Ausführung von Nichtterminalen

Die Befehle in diesem Abschnitt dienen dem Zugriff auf und der Bearbeitung von NC.

**symbol_restore** *symbol*
: Dieser Befehl prüft, ob NC Daten für das Nichtterminal *symbol* an CL enthält oder nicht. Das Ergebnis des Befehls ist ein boolescher Flag, wobei **True** anzeigt, dass Daten im Cache gefunden wurden. In diesem Fall hat der Befehl den Architekturzustand der Maschine mit den zwischengespeicherten Informationen – nämlich CL, ST, ER und SV – weiter aktualisiert. Die Methode, mit der das Ergebnis des Befehls in den Kontrollfluss transformiert wird, bleibt undefiniert und liegt in der Verantwortung der Implementierung.

**symbol_save** *symbol*
: Dieser Befehl speichert die aktuellen Einstellungen von CL, ST, ER und SV in NC, wobei das Paar aus dem Nichtterminal *symbol* und der zuletzt in LS gespeicherten Position als Schlüssel verwendet wird.


## Aufbau von Werten

Die Anweisungen in diesem Abschnitt dienen der Bearbeitung von SV.

**value_clear**
: Dieser Befehl löscht SV.

**value_leaf** *symbol*
: Diese Anweisung erstellt einen AST-Knoten für *symbol*, der den Bereich von IN ab dem ersten Zeichen nach der zuletzt in LS gespeicherten Position bis hin zu CL abdeckt, und speichert ihn in SV. ...

**value_reduce** *symbol*
: Diese Anweisung verhält sich im Allgemeinen wie **value_nonterminal_leaf**, mit dem Unterschied, dass sie alle auf ARS vorhandenen AST-Knoten – wenn vorhanden – übernimmt und sie zu Kindknoten des neuen Knotens macht, wobei der zuletzt auf ARS gespeicherte Knoten zum rechtesten bzw. letzten Kindknoten wird. Hinweis: ARS wird durch diesen Vorgang nicht verändert.


## AST-Aufbau

Die Anweisungen in diesem Abschnitt dienen der Bearbeitung von ARS und AS.

**ast_value_push**
: Dieser Befehl erstellt eine Kopie von SV und legt diese auf ARS ab.

**ast_push**
: Dieser Befehl legt den aktuellen Zustand von ARS auf AS und löscht ARS anschließend.

**ast_pop_rewind**
: Dieser Befehl nimmt den zuletzt auf AS gespeicherten Eintrag herunter und stellt ihn als neuen Zustand von ARS wieder her.

**ast_pop_discard**
: Dieser Befehl nimmt den zuletzt auf AS gespeicherten Eintrag von AS herunter.


## Ablaufsteuerung

Normalerweise würde dieser Abschnitt die Spezifikationen der Anweisungen zur Kontrollflusssteuerung des PARAM enthalten, d. h. (un)bedingte Sprünge und Ähnliches. Dieser Teil des PARAM wurde jedoch bewusst nicht spezifiziert. Dies ermöglicht es den Implementierungen, frei zu entscheiden, wie der Kontrollfluss umgesetzt werden soll.

Die Implementierung dieser Maschine in den Parser-Tools, d. h. im Paket **pt::rde**, ist nicht nur in Tcl programmiert, sondern stützt sich auch auf Tcl-Befehle, um die Ablaufsteuerung (Anweisungen) zu gewährleisten.

# WECHSELWIRKUNG DER BEFEHLE MIT DEM ARCHITEKTURZUSTAND

```
Instruction		Inputs				Outputs
======================= =======================		====================
ast_pop_discard		AS			->	AS
ast_pop_rewind		AS			->	AS, ARS
ast_push		ARS, AS			->	AS
ast_value_push		SV, ARS			->	ARS
======================= =======================		====================
error_clear		-			->	ER
error_nonterminal sym	ER, LS			->	ER
error_pop_merge   	ES, ER			->	ER
error_push		ES, ER			->	ES
======================= =======================		====================
input_next msg		IN			->	TC, CL, CC, ST, ER
======================= =======================		====================
loc_pop_discard		LS			->	LS
loc_pop_rewind		LS			->	LS, CL
loc_push		CL, LS			->	LS
======================= =======================		====================
status_fail		-			->	ST
status_negate		ST			->	ST
status_ok		-			->	ST
======================= =======================		====================
symbol_restore sym	NC			->	CL, ST, ER, SV
symbol_save    sym	CL, ST, ER, SV LS	->	NC
======================= =======================		====================
test_alnum  		CC			->	ST, ER
test_alpha		CC			->	ST, ER
test_ascii		CC			->	ST, ER
test_char char		CC			->	ST, ER
test_ddigit		CC			->	ST, ER
test_digit		CC			->	ST, ER
test_graph		CC			->	ST, ER
test_lower		CC			->	ST, ER
test_print		CC			->	ST, ER
test_punct		CC			->	ST, ER
test_range chars chare	CC			->	ST, ER
test_space		CC			->	ST, ER
test_upper		CC			->	ST, ER
test_wordchar		CC			->	ST, ER
test_xdigit		CC			->	ST, ER
======================= =======================		====================
value_clear		-			->	SV
value_leaf symbol	LS, CL			->	SV
value_reduce symbol	ARS, LS, CL		->	SV
======================= =======================		====================
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pt* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Parser und Grammatiken

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
