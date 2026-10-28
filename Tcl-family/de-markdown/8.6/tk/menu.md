---
CommandName: menu
title: menu
ManualSection: n
Version: 4.1
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bind(n)
 - menubutton(n)
 - ttk::menubutton(n)
 - toplevel(n)
Keywords:
 - menu
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

menu, tk\_menuSetFocus - Erstellt und manipuliert 'Menu'-Widgets und Menüleisten

# Übersicht

::: {.synopsis} :::
[menu]{.cmd} [pathName]{.arg} [options]{.optarg}
[tk\_menuSetFocus]{.cmd} [pathName]{.arg}
:::

# Standardoptionen

**-activebackground**, **-borderwidth**, **-foreground**, **-activeborderwidth**, **-cursor**, **-relief**, **-activeforeground**, **-disabledforeground**, **-takefocus**, **-background**, **-font**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-postcommand** (**postCommand**/**Command**)
: Wenn diese Option angegeben ist, stellt sie einen Tcl-Befehl bereit, der jedes Mal ausgeführt wird, wenn das Menü gepostet wird. Der Befehl wird vom Widget-Befehl **post** aufgerufen, bevor das Menü gepostet wird. Beachten Sie, dass in Tk 8.0 auf Macintosh und Windows alle Post-Befehle in einem Menüsystem ausgeführt werden, bevor eines dieser Menüs gepostet wird. Dies liegt an den Einschränkungen der Menü-Manager der einzelnen Plattformen.

**-selectcolor** (**selectColor**/**Background**)
: Für Menüeinträge, die Checkbuttons oder Radiobuttons sind, legt diese Option die Farbe fest, die im Indikator angezeigt wird, wenn der Checkbutton oder Radiobutton ausgewählt ist.

**-tearoff** (**tearOff**/**TearOff**)
: Diese Option muss einen gültigen booleschen Wert haben und legt fest, ob das Menü oben einen Tear-off-Eintrag enthalten soll. Wenn ja, existiert er als Eintrag 0 des Menüs und die anderen Einträge werden ab 1 nummeriert. Die Standard-Menü-Bindings richten ein, dass das Menü abgerissen wird, wenn der Tear-off-Eintrag aufgerufen wird. Diese Option wird unter Aqua/macOS ignoriert, wo Menüs nicht abgerissen werden können.

**-tearoffcommand** (**tearOffCommand**/**TearOffCommand**)
: Wenn diese Option einen nicht-leeren Wert hat, legt sie einen Tcl-Befehl fest, der aufgerufen wird, wann immer das Menü abgerissen wird. Der tatsächliche Befehl besteht aus dem Wert dieser Option, gefolgt von einem Leerzeichen, gefolgt vom Namen des Menüfensters, gefolgt von einem Leerzeichen, gefolgt vom Namen des abgerissenen Menüfensters. Wenn der Optionswert beispielsweise "**a b**" ist und das Menü **.x.y** abgerissen wird, um ein neues Menü **.x.tearoff1** zu erzeugen, wird der Befehl "**a b .x.y .x.tearoff1**" aufgerufen. Diese Option wird unter Aqua/macOS ignoriert, wo Menüs nicht abgerissen werden können.

**-title** (**title**/**Title**)
: Der String wird als Titel für das Fenster verwendet, das erzeugt wird, wenn dieses Menü abgerissen wird. Wenn der Titel NULL ist, hat das Fenster den Titel des Menubuttons oder den Text des Cascade-Eintrags, von dem aus dieses Menü aufgerufen wurde.

**-type** (**type**/**Type**)
: Diese Option kann einer von **menubar**, **tearoff** oder **normal** sein und wird beim Erzeugen des Menüs gesetzt. Obwohl sich der von der Konfigurationsdatenbank zurückgegebene String ändert, wenn diese Option geändert wird, beeinflusst dies das Verhalten des Menü-Widgets nicht. Dies wird vom Klon-Mechanismus verwendet und wird normalerweise nicht außerhalb der Tk-Bibliothek gesetzt.


# Einleitung

Der Befehl **menu** erstellt ein neues Toplevel-Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Menu-Widget. Dieses Menu-Widget kann entweder als Pop-up-Fenster verwendet oder auf ein [toplevel] (mit dessen Option **-menu**) angewendet werden, um es zur Menüleiste für dieses Toplevel zu machen. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des Menüs wie Farben und Schriftart zu konfigurieren. Der Befehl **menu** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Ein Menü ist ein Widget, das eine Sammlung einzeiliger Einträge anzeigt, die in einer oder mehreren Spalten angeordnet sind. Es gibt mehrere verschiedene Eintragstypen, jeweils mit unterschiedlichen Eigenschaften. Einträge verschiedener Typen können in einem einzigen Menü kombiniert werden. Menüeinträge sind nicht dasselbe wie Entry-Widgets. Tatsächlich sind Menüeinträge nicht einmal separate Widgets; das gesamte Menü ist ein Widget.

Menüeinträge werden mit bis zu drei getrennten Feldern angezeigt. Das Hauptfeld ist eine Beschriftung in Form eines Textstrings, eines Bitmaps oder eines Bildes, gesteuert durch die Optionen **-label**, **-bitmap** und **-image** für den Eintrag. Wenn für einen Eintrag die Option **-accelerator** angegeben ist, wird rechts neben der Beschriftung ein zweites Textfeld angezeigt. Der Accelerator beschreibt typischerweise eine Tastenkombination, die in der Anwendung verwendet werden kann, um dasselbe Ergebnis wie beim Aufrufen des Menüeintrags zu erzielen. Dies ist eine Anzeigeoption; sie legt das entsprechende Binding nicht tatsächlich fest (was mit dem Befehl [bind] erreicht werden kann). Das dritte Feld ist ein *Indikator*. Der Indikator ist nur bei Checkbutton- oder Radiobutton-Einträgen vorhanden. Er zeigt an, ob der Eintrag ausgewählt ist oder nicht, und wird links vom String des Eintrags angezeigt.

Bei normaler Verwendung wird ein Eintrag aktiv (stellt sich anders dar), sobald der Mauszeiger über dem Eintrag ist. Wenn eine Maustaste über dem Eintrag losgelassen wird, wird der Eintrag *aufgerufen*. Die Wirkung des Aufrufs ist für jeden Eintragstyp unterschiedlich; diese Wirkungen werden unten in den Abschnitten zu den einzelnen Einträgen beschrieben.

Einträge können *deaktiviert* werden, wodurch ihre Beschriftungen und Accelerators mit gedimmteren Farben angezeigt werden. Die Standard-Menü-Bindings erlauben nicht, dass ein deaktivierter Eintrag aktiviert oder aufgerufen wird. Deaktivierte Einträge können wieder aktiviert werden; dann ist es wieder möglich, sie zu aktivieren und aufzurufen.

Wann immer sich der aktive Eintrag eines Menüs ändert, wird ein virtuelles Event <<MenuSelect>> an das Menü gesendet. Der aktive Eintrag kann dann vom Menü abgefragt werden, und es kann eine Aktion ausgeführt werden, z. B. das Setzen kontextsensitiver Hilfetexte für den Eintrag.

# Eintragstypen

## Befehlseinträge

Die häufigste Art von Menüeintrag ist ein Befehlseintrag, der sich ähnlich wie ein Button-Widget verhält. Wenn ein Befehlseintrag aufgerufen wird, wird ein Tcl-Befehl ausgeführt. Der Tcl-Befehl wird mit der Option **-command** angegeben.

## Trenner-Einträge

Ein Trenner ist ein Eintrag, der als horizontale Trennlinie angezeigt wird. Ein Trenner kann nicht aktiviert oder aufgerufen werden und hat kein Verhalten außer seinem Erscheinungsbild.

## Checkbutton-Einträge

Ein Checkbutton-Menüeintrag verhält sich ähnlich wie ein Checkbutton-Widget. Wenn er aufgerufen wird, schaltet er zwischen ausgewähltem und abgewähltem Zustand hin und her. Wenn der Eintrag ausgewählt ist, wird ein bestimmter Wert in einer bestimmten globalen Variable gespeichert (wie durch die Optionen **-onvalue** und **-variable** für den Eintrag festgelegt); wenn der Eintrag abgewählt wird, wird ein anderer Wert (festgelegt durch die Option **-offvalue**) in der globalen Variable gespeichert. Links von der Beschriftung wird bei einem Checkbutton-Eintrag ein Indikator-Kästchen angezeigt. Wenn der Eintrag ausgewählt ist, wird die Mitte des Indikators in der durch die Option **-selectcolor** für den Eintrag angegebenen Farbe angezeigt; andernfalls wird die Mitte des Indikators in der Hintergrundfarbe des Menüs angezeigt. Wenn für einen Checkbutton-Eintrag eine Option **-command** angegeben ist, wird ihr Wert bei jedem Aufruf des Eintrags als Tcl-Befehl ausgewertet; dies geschieht nach dem Umschalten des ausgewählten Zustands des Eintrags.

## Radiobutton-Einträge

Ein Radiobutton-Menüeintrag verhält sich ähnlich wie ein Radiobutton-Widget. Radiobutton-Einträge sind in Gruppen organisiert, von denen jeweils nur ein Eintrag gleichzeitig ausgewählt sein kann. Wann immer ein bestimmter Eintrag ausgewählt wird, speichert er einen bestimmten Wert in einer bestimmten globalen Variable (wie durch die Optionen **-value** und **-variable** für den Eintrag festgelegt). Diese Aktion bewirkt, dass sich jeder zuvor ausgewählte Eintrag in derselben Gruppe selbst abwählt. Sobald ein Eintrag ausgewählt wurde, führt jede Änderung an der zugehörigen Variable des Eintrags dazu, dass der Eintrag sich selbst abwählt. Die Gruppierung von Radiobutton-Einträgen wird durch ihre zugehörigen Variablen bestimmt: Haben zwei Einträge dieselbe zugehörige Variable, gehören sie zur selben Gruppe. Links von der Beschriftung wird bei jedem Radiobutton-Eintrag ein Indikator in Rautenform angezeigt. Wenn der Eintrag ausgewählt ist, wird die Mitte des Indikators in der durch die Option **-selectcolor** für den Eintrag angegebenen Farbe angezeigt; andernfalls wird die Mitte des Indikators in der Hintergrundfarbe des Menüs angezeigt. Wenn für einen Radiobutton-Eintrag eine Option **-command** angegeben ist, wird ihr Wert bei jedem Aufruf des Eintrags als Tcl-Befehl ausgewertet; dies geschieht nach der Auswahl des Eintrags.

## Cascade-Einträge

Ein Cascade-Eintrag ist ein Eintrag mit einem zugehörigen Menü (festgelegt durch die Option **-menu**). Cascade-Einträge ermöglichen den Aufbau kaskadierender Menüs. Der Widget-Befehl **postcascade** kann verwendet werden, um das zugehörige Menü direkt neben dem Cascade-Eintrag zu posten und wieder zu entfernen. Das zugehörige Menü muss ein Kind des Menüs sein, das den Cascade-Eintrag enthält (dies ist nötig, damit die Menü-Traversierung korrekt funktioniert).

Ein Cascade-Eintrag postet sein zugehöriges Menü, indem er einen Tcl-Befehl der Form

```
menu post x y
```

aufruft, wobei *menu* der Pfadname des zugehörigen Menüs ist und *x* und *y* die Root-Fenster-Koordinaten der oberen rechten Ecke des Cascade-Eintrags sind. Unter Unix wird das untergeordnete Menü durch Ausführen eines Tcl-Befehls der Form

```
menu unpost
```

wieder entfernt, wobei *menu* der Name des zugehörigen Menüs ist. Auf anderen Plattformen kümmert sich der native Plattformcode um das Entfernen des Menüs.

Wenn für einen Cascade-Eintrag eine Option **-command** angegeben ist, wird sie bei jedem Aufruf des Eintrags als Tcl-Befehl ausgewertet. Dies wird unter Windows nicht unterstützt.

## Tear-off-Einträge

Ein Tear-off-Eintrag erscheint oben im Menü, wenn er mit der Option **-tearoff** aktiviert ist. Er ist nicht wie andere Menüeinträge: Er kann nicht mit dem Widget-Befehl **add** erzeugt und nicht mit dem Widget-Befehl **delete** gelöscht werden. Wenn ein Tear-off-Eintrag erzeugt wird, erscheint er als gestrichelte Linie oben im Menü. Unter den Standard-Bindings bewirkt der Aufruf des Tear-off-Eintrags, dass eine abgerissene Kopie des Menüs und all seiner Untermenüs erstellt wird.

# Menüleisten

Jedes Menü kann als Menüleiste für ein Toplevel-Fenster gesetzt werden (siehe Befehl [toplevel] für die Syntax). Auf dem Macintosh erscheinen die Cascade-Einträge dieses Menüs in der Menüleiste am oberen Rand des Hauptmonitors, sobald das Toplevel im Vordergrund ist. Unter Windows und Unix werden die Einträge dieses Menüs in einer Menüleiste am oberen Rand des Fensters angezeigt. Diese Menüs verhalten sich gemäß den Schnittstellenrichtlinien ihrer Plattformen. Für jedes als Menüleiste gesetzte Menü wird ein Klon-Menü erstellt. Siehe Abschnitt [Klone] für weitere Informationen.

Wie erwähnt, können Menüleisten auf verschiedenen Plattformen unterschiedlich wirken. Ein Beispiel betrifft die Behandlung von Checkbuttons und Radiobuttons innerhalb des Menüs. Obwohl es erlaubt ist, diese Menüelemente in Menüleisten zu verwenden, werden sie auf einigen Plattformen aufgrund von Systembeschränkungen möglicherweise nicht mit Indikatoren gezeichnet.

## Spezielle Menüs in Menüleisten

Bestimmte Menüs in einer Menüleiste werden speziell behandelt. Auf dem Macintosh wird Zugriff auf die speziellen Menüs Application, Window und Help bereitgestellt. Unter Windows wird Zugriff auf das Windows-Systemmenü in jedem Fenster bereitgestellt. Unter X Windows kann ein spezielles rechtsbündiges Hilfe-Menü bereitgestellt werden, wenn Motif-Menü-Kompatibilität aktiviert ist. In allen Fällen müssen diese Menüs mit dem Befehlsnamen des Menüleisten-Menüs erstellt werden, an den der spezielle Name angehängt ist. Für eine Menüleiste namens .menubar wären auf dem Macintosh die speziellen Menüs .menubar.apple, .menubar.window und .menubar.help; unter Windows .menubar.system; unter X Windows .menubar.help.

Wenn Tk auf dem Macintosh ein .menubar.apple-Menü als erstes Menü in einer Menüleiste sieht, bilden die Inhalte dieses Menüs die ersten Einträge des Application-Menüs, sobald das Fenster mit der Menüleiste im Vordergrund ist. Nach allen von Tk definierten Einträgen folgt im Menü ein Trenner und danach alle Standard-Einträge des Application-Menüs. Ein solches .apple-Menü muss vorhanden sein, wenn das Menü erstmals als Menüleiste eines Toplevel konfiguriert wird; andernfalls wird zu diesem Zeitpunkt ein Standard-Application-Menü (vor Tk verborgen) in die Menüleiste eingefügt, und ein später hinzugefügtes .apple-Menü wird nicht mehr zum Application-Menü.

Wenn Tk auf dem Macintosh ein .menubar.window-Menü sieht, werden die Inhalte des Menüs in das Standard-Window-Menü der Benutzer-Menüleiste eingefügt, sobald die Menüleiste des Fensters im Vordergrund ist. Die ersten Einträge im Menü stammen von macOS; die Namen der aktuellen Toplevels werden automatisch nach allen von Tk definierten Einträgen und einem Trenner angehängt. Das Window-Menü auf dem Mac erlaubt auch das Umschalten des Fensters in einen Vollbildzustand und die Verwaltung einer Tab-Fenster-Oberfläche (mehrere Fenster in einem Fenster gruppiert), sofern die Betriebssystemversion dies unterstützt.

Wenn Tk auf dem Macintosh ein .menubar.help-Menü sieht, werden die Inhalte des Menüs an das Standard-Hilfe-Menü der Benutzer-Menüleiste angehängt, sobald die Menüleiste des Fensters im Vordergrund ist. Die ersten Einträge im Menü stammen von macOS.

Wenn Tk unter Windows ein System-Menü sieht, werden seine Einträge an das Systemmenü angehängt, an das die Menüleiste gebunden ist. Dieses Menü ist mit dem Anwendungssymbol verknüpft und kann mit der Maus oder durch Alt+Leertaste aufgerufen werden. Aufgrund von Einschränkungen in der Windows-API erscheinen Schriftänderungen, Farben, Bilder, Bitmaps oder Tear-off-Bilder nicht im Systemmenü.

Wenn Tk unter X Windows ein Hilfe-Menü sieht und Motif-Menü-Kompatibilität aktiviert ist, wird das Menü ans Ende der Menüleiste verschoben und rechtsbündig ausgerichtet. Motif-Menü-Kompatibilität wird aktiviert, indem die Tk-Option **\*Menu.useMotifHelp** auf true gesetzt oder **tk::classic::restore menu** aufgerufen wird.

# Klone

Wenn ein Menü als Menüleiste für ein Toplevel-Fenster gesetzt wird oder wenn ein Menü abgerissen wird, wird ein Klon des Menüs erstellt. Dieser Klon ist ein Menu-Widget für sich, ist aber ein Kind des Originals. Änderungen an der Konfiguration des Originals werden im Klon widergespiegelt. Zusätzlich werden alle angesprochenen Cascades ebenfalls geklont, damit die Menü-Traversierung korrekt funktioniert. Klone werden zerstört, wenn entweder der Tear-off oder die Menüleiste verschwindet oder wenn das ursprüngliche Menü zerstört wird.

# Widget-Befehl

Der Befehl **menu** erstellt einen neuen Tcl-Befehl, dessen Name *pathName* ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls.

Viele Widget-Befehle für ein Menü nehmen als ein Argument einen Indikator dafür an, auf welchen Eintrag des Menüs gearbeitet werden soll. Diese Indikatoren heißen *Index*e und können in einer der folgenden Formen angegeben werden:

**active**
: Bezeichnet den Eintrag, der derzeit aktiv ist. Wenn kein Eintrag aktiv ist, ist diese Form äquivalent zu **none**. Diese Form darf nicht abgekürzt werden.

**end**
: Bezeichnet den untersten Eintrag im Menü. Wenn das Menü keine Einträge hat, ist diese Form äquivalent zu **none**. Diese Form darf nicht abgekürzt werden.

**last**
: Entspricht **end**.

**none**
: Bezeichnet „überhaupt keinen Eintrag“; wird am häufigsten mit der Option **activate** verwendet, um alle Einträge im Menü zu deaktivieren. In den meisten Fällen bewirkt die Angabe von **none**, dass im Widget-Befehl nichts passiert. Diese Form darf nicht abgekürzt werden.

**@**_x_**,**_y_
: Bezeichnet den Eintrag, der den im Menüfenster durch *x* und *y* angegebenen Punkt (in Pixelkoordinaten) abdeckt. Deckt kein Eintrag diesen Punkt ab, ist diese Form äquivalent zu **none**. Wird nur eine einzelne Zahl angegeben, wird sie als y-Koordinate behandelt.

*number*
: Bezeichnet den Eintrag numerisch, wobei 0 dem obersten Eintrag des Menüs entspricht, 1 dem darunter und so weiter.

*pattern*
: Wenn der Index keine der obigen Formen erfüllt, wird diese Form verwendet. *Pattern* wird mit der Beschriftung jedes Eintrags im Menü von oben nach unten abgeglichen, bis ein passender Eintrag gefunden wird. Es gelten die Regeln von [string match][string].


Wenn der Index mehr als eine der obigen Formen treffen könnte, hat die früher in der obigen Liste stehende Form Vorrang.

Folgende Widget-Befehle sind für Menu-Widgets möglich:

[pathName]{.ins} [activate]{.sub} [index]{.arg}
: Ändert den Zustand des durch *index* angegebenen Eintrags auf **active** und zeigt ihn mit seinen aktiven Farben neu an. Jeder zuvor aktive Eintrag wird deaktiviert. Wenn *index* als **none** angegeben ist oder der angegebene Eintrag deaktiviert ist, endet das Menü ohne aktiven Eintrag. Gibt einen leeren String zurück.

[pathName]{.ins} [add]{.sub} [type]{.arg} [option value option value]{.optdot}
: Fügt einen neuen Eintrag am Ende des Menüs hinzu. Der Typ des neuen Eintrags wird durch *type* angegeben und muss einer von **cascade**, **checkbutton**, **command**, **radiobutton** oder **separator** sein oder eine eindeutige Abkürzung davon. Sind weitere Argumente vorhanden, legen sie die unten im Abschnitt [Menüeintrags-Optionen] aufgeführten Optionen fest. Der Widget-Befehl **add** gibt einen leeren String zurück.

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **menu** akzeptierten Werte haben.

[pathName]{.ins} [clone]{.sub} [newPathname]{.arg} [cloneType]{.optarg}
: Erstellt einen Klon des aktuellen Menüs mit dem Namen *newPathName*. Dieser Klon ist ein Menü für sich, aber Änderungen am Klon werden auf das ursprüngliche Menü und umgekehrt übertragen. *cloneType* kann **normal**, **menubar** oder **tearoff** sein. Sollte normalerweise nicht außerhalb der Tk-Bibliothek aufgerufen werden. Siehe Abschnitt [Klone] für weitere Informationen.

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe [Tk\_ConfigureInfo][ConfigWidg] für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **menu** akzeptierten Werte haben.

[pathName]{.ins} [delete]{.sub} [index1]{.arg} [index2]{.optarg}
: Löscht alle Menüeinträge zwischen *index1* und *index2* einschließlich. Wenn *index2* weggelassen wird, entspricht es *index1*. Versuche, einen Tear-off-Menüeintrag zu löschen, werden ignoriert (stattdessen sollte die Option **-tearoff** geändert werden, um den Tear-off-Eintrag zu entfernen).

[pathName]{.ins} [entrycget]{.sub} [index]{.arg} [option]{.arg}
: Gibt den aktuellen Wert einer Konfigurationsoption für den durch *index* gegebenen Eintrag zurück. *Option* kann einen der unten im Abschnitt [Menüeintrags-Optionen] beschriebenen Namen haben.

[pathName]{.ins} [entryconfigure]{.sub} [index]{.arg} [options...]{.optarg}
: Dieser Befehl ähnelt dem Befehl **configure**, gilt jedoch für die Optionen eines einzelnen Eintrags, während **configure** für die Optionen des Menüs als Ganzes gilt. *Options* kann jeden der im Abschnitt [Menüeintrags-Optionen] beschriebenen Werte haben. Wenn *options* angegeben sind, werden die Optionen wie im Befehl angegeben geändert und der Befehl gibt einen leeren String zurück. Wenn keine *options* angegeben sind, gibt eine Liste zurück, die die aktuellen Optionen für Eintrag *index* beschreibt (siehe [Tk\_ConfigureInfo][ConfigWidg] für Informationen über das Format dieser Liste).

[pathName]{.ins} [index]{.sub} [index]{.arg}
: Gibt den numerischen Index zurück, der *index* entspricht, oder **none**, wenn *index* als **none** angegeben wurde.

[pathName]{.ins} [insert]{.sub} [index]{.arg} [type]{.arg} [option value option value]{.optdot}
: Entspricht dem Widget-Befehl **add**, fügt den neuen Eintrag jedoch unmittelbar vor dem durch *index* gegebenen Eintrag ein, statt ans Ende des Menüs anzuhängen. Die Argumente *type*, *option* und *value* haben dieselbe Bedeutung wie beim Widget-Befehl **add**. Es ist nicht möglich, neue Menüeinträge vor dem Tear-off-Eintrag einzufügen, falls das Menü einen hat.

[pathName]{.ins} [invoke]{.sub} [index]{.arg}
: Ruft die Aktion des Menüeintrags auf. Siehe die Abschnitte zu den einzelnen Einträgen oben für Details. Wenn der Menüeintrag deaktiviert ist, passiert nichts. Hat der Eintrag einen zugehörigen Befehl, wird das Ergebnis dieses Befehls als Ergebnis des Widget-Befehls **invoke** zurückgegeben. Andernfalls ist das Ergebnis ein leerer String. Hinweis: Das Aufrufen eines Menüeintrags entfernt das Menü nicht automatisch; die Standard-Bindings kümmern sich normalerweise darum, bevor **invoke** ausgeführt wird.

[pathName]{.ins} [post]{.sub} [x]{.arg} [y]{.arg} [index]{.optarg}
: Sorgt dafür, dass das Menü an den Root-Fenster-Koordinaten *x* und *y* auf dem Bildschirm angezeigt wird. Wenn ein Index angegeben ist, wird das Menü so positioniert, dass der Eintrag mit diesem Index an dem Punkt angezeigt wird. Diese Koordinaten werden bei Bedarf angepasst, damit das gesamte Menü auf dem Bildschirm sichtbar ist. Dieser Befehl gibt normalerweise einen leeren String zurück. Wurde die Option **-postcommand** angegeben, wird ihr Wert als Tcl-Script vor dem Posten des Menüs ausgeführt und das Ergebnis dieses Scripts als Ergebnis des Widget-Befehls **post** zurückgegeben. Tritt beim Ausführen des Befehls ein Fehler auf, wird der Fehler zurückgegeben, ohne das Menü zu posten.

[pathName]{.ins} [postcascade]{.sub} [index]{.arg}
: Postet das Untermenü, das dem durch *index* gegebenen Cascade-Eintrag zugeordnet ist, und entfernt jedes zuvor gepostete Untermenü. Entspricht *index* keinem Cascade-Eintrag oder ist *pathName* nicht gepostet, hat der Befehl keine Wirkung außer das Entfernen eines aktuell geposteten Untermenüs.

[pathName]{.ins} [type]{.sub} [index]{.arg}
: Gibt den Typ des durch *index* gegebenen Menüeintrags zurück. Dies ist das *type*-Argument, das beim Erzeugen des Eintrags an **add** oder **insert** übergeben wurde, z. B. **command** oder **separator**, oder **tearoff** für einen Tear-off-Eintrag.

[pathName]{.ins} [unpost]{.sub}
: Entfernt die Zuordnung des Fensters, sodass es nicht mehr angezeigt wird. Ist ein kaskadiertes Untermenü auf niedrigerer Ebene gepostet, wird dieses entfernt. Gibt einen leeren String zurück. Dieser Unterbefehl funktioniert unter Windows und auf dem Macintosh nicht, da diese Plattformen ihr eigenes Entfernen von Menüs haben.

[pathName]{.ins} [xposition]{.sub} [index]{.arg}
: Gibt einen Dezimalstring zurück mit der x-Koordinate im Menüfenster des linken Pixel des durch *index* angegebenen Eintrags.

[pathName]{.ins} [yposition]{.sub} [index]{.arg}
: Gibt einen Dezimalstring zurück mit der y-Koordinate im Menüfenster des obersten Pixel des durch *index* angegebenen Eintrags.


# Menüeintrags-Optionen

Die folgenden Optionen sind für Menüeinträge erlaubt. Die meisten Optionen werden nicht von allen Eintragstypen unterstützt.

[-activebackground]{.lit} [value]{.arg}
: Legt eine Hintergrundfarbe fest, die für die Anzeige dieses Eintrags verwendet wird, wenn er aktiv ist. Diese Option wird unter Aqua/macOS ignoriert. Ist sie als leerer String angegeben (Standard), wird die Option **-activebackground** für das gesamte Menü verwendet. Wurde die Variable [tk\_strictMotif][tkvars] gesetzt, um strikte Motif-Konformität zu verlangen, wird diese Option ignoriert und stattdessen die Option **-background** verwendet. Diese Option ist für Trenner- oder Tear-off-Einträge nicht verfügbar.

[-activeforeground]{.lit} [value]{.arg}
: Legt eine Vordergrundfarbe fest, die für die Anzeige dieses Eintrags verwendet wird, wenn er aktiv ist. Diese Option wird unter Aqua/macOS ignoriert. Ist diese Option als leerer String angegeben (Standard), wird die Option **-activeforeground** für das gesamte Menü verwendet. Diese Option ist für Trenner- oder Tear-off-Einträge nicht verfügbar.

[-accelerator]{.lit} [value]{.arg}
: Legt einen String fest, der rechts vom Menüeintrag angezeigt wird. Beschreibt normalerweise eine Accelerator-Tastenkombination, mit der dieselbe Funktion wie der Menüeintrag aufgerufen werden kann. Dies ist eine Anzeigeoption; sie legt das entsprechende Binding nicht tatsächlich fest (was mit dem Befehl [bind] erreicht werden kann). Diese Option ist für Trenner- oder Tear-off-Einträge nicht verfügbar.

[-background]{.lit} [value]{.arg}
: Legt eine Hintergrundfarbe fest, die für die Anzeige dieses Eintrags im normalen Zustand (weder aktiv noch deaktiviert) verwendet wird. Diese Option wird unter Aqua/macOS ignoriert. Ist sie als leerer String angegeben (Standard), wird die Option **-background** für das gesamte Menü verwendet. Diese Option ist für Trenner- oder Tear-off-Einträge nicht verfügbar.

[-bitmap]{.lit} [value]{.arg}
: Legt ein Bitmap fest, das im Menü statt einer Textbeschriftung angezeigt wird, in einer von [Tk\_GetBitmap][GetBitmap] akzeptierten Form. Diese Option überschreibt die Option **-label** (gesteuert durch **-compound**), kann aber auf einen leeren String zurückgesetzt werden, um eine Textbeschriftung anzuzeigen. Wurde eine Option **-image** angegeben, überschreibt sie **-bitmap**. Diese Option ist für Trenner- oder Tear-off-Einträge nicht verfügbar.

[-columnbreak]{.lit} [value]{.arg}
: Ist diese Option null, erscheint der Eintrag unter dem vorherigen Eintrag. Ist sie eins, erscheint der Eintrag oben in einer neuen Spalte im Menü. Diese Option wird unter Aqua/macOS ignoriert, wo Menüs immer eine Spalte haben.

[-command]{.lit} [value]{.arg}
: Legt einen Tcl-Befehl fest, der ausgeführt wird, wenn der Menüeintrag aufgerufen wird. Nicht verfügbar für Trenner- oder Tear-off-Einträge.

[-compound]{.lit} [value]{.arg}
: Legt fest, ob der Menüeintrag sowohl ein Bild als auch Text anzeigen soll und falls ja, wo das Bild relativ zum Text platziert wird. Gültige Werte sind **bottom**, **center**, **left**, **none**, **right** und **top**. Der Standardwert ist **none**, d. h. es wird entweder ein Bild oder Text angezeigt, je nach den Werten der Optionen **-image** und **-bitmap**.

[-font]{.lit} [value]{.arg}
: Legt die Schriftart fest, mit der die Beschriftung oder der Accelerator-String in diesem Eintrag gezeichnet wird. Ist diese Option als leerer String angegeben (Standard), wird die Option **-font** für das gesamte Menü verwendet. Diese Option ist für Trenner- oder Tear-off-Einträge nicht verfügbar.

[-foreground]{.lit} [value]{.arg}
: Legt eine Vordergrundfarbe fest, die für die Anzeige dieses Eintrags im normalen Zustand verwendet wird. Diese Option wird unter Aqua/macOS ignoriert. Ist sie als leerer String angegeben (Standard), wird die Option **-foreground** für das gesamte Menü verwendet. Diese Option ist für Trenner- oder Tear-off-Einträge nicht verfügbar.

[-hidemargin]{.lit} [value]{.arg}
: Legt fest, ob die Standardränder für diesen Menüeintrag gezeichnet werden sollen. Nützlich beim Erzeugen von Paletten mit Bildern, z. B. Farb- oder Musterpaletten. 1 bedeutet, dass der Rand für den Eintrag verborgen ist; 0 bedeutet, dass der Rand verwendet wird.

[-image]{.lit} [value]{.arg}
: Legt ein Bild fest, das im Menü statt eines Textstrings oder Bitmaps angezeigt wird. Das Bild muss durch einen früheren Aufruf von [image create][image] erzeugt worden sein. Diese Option überschreibt die Optionen **-label** und **-bitmap** (gesteuert durch **-compound**), kann aber auf einen leeren String zurückgesetzt werden, um eine Text- oder Bitmap-Beschriftung anzuzeigen. Diese Option ist für Trenner- oder Tear-off-Einträge nicht verfügbar.

[-indicatoron]{.lit} [value]{.arg}
: Nur für Checkbutton- und Radiobutton-Einträge verfügbar. *Value* ist ein boolescher Wert, der festlegt, ob der Indikator angezeigt werden soll.

[-label]{.lit} [value]{.arg}
: Legt einen String fest, der als identifizierende Beschriftung im Menüeintrag angezeigt wird. Nicht verfügbar für Trenner- oder Tear-off-Einträge.

[-menu]{.lit} [value]{.arg}
: Nur für Cascade-Einträge verfügbar. Legt den Pfadnamen des mit diesem Eintrag verknüpften Untermenüs fest. Das Untermenü muss ein Kind des Menüs sein.

[-offvalue]{.lit} [value]{.arg}
: Nur für Checkbutton-Einträge verfügbar. Legt den Wert fest, der in der zugehörigen Variable des Eintrags gespeichert wird, wenn der Eintrag abgewählt wird.

[-onvalue]{.lit} [value]{.arg}
: Nur für Checkbutton-Einträge verfügbar. Legt den Wert fest, der in der zugehörigen Variable des Eintrags gespeichert wird, wenn der Eintrag ausgewählt wird.

[-selectcolor]{.lit} [value]{.arg}
: Nur für Checkbutton- und Radiobutton-Einträge verfügbar. Legt die Farbe fest, die im Indikator angezeigt wird, wenn der Eintrag ausgewählt ist. Ist der Wert ein leerer String (Standard), bestimmt die Option **-selectcolor** des Menüs die Indikatorfarbe.

[-selectimage]{.lit} [value]{.arg}
: Nur für Checkbutton- und Radiobutton-Einträge verfügbar. Legt ein Bild fest, das im Eintrag angezeigt wird (anstelle der Option **-image**), wenn er ausgewählt ist. *Value* ist der Name eines Bildes, das durch einen früheren Aufruf von [image create][image] erzeugt worden sein muss. Diese Option wird ignoriert, sofern die Option **-image** nicht angegeben wurde.

[-state]{.lit} [value]{.arg}
: Legt einen von drei Zuständen für den Eintrag fest: **normal**, **active** oder **disabled**. Im normalen Zustand wird der Eintrag mit der Option **-foreground** des Menüs und der Option **-background** des Eintrags oder des Menüs angezeigt. Der aktive Zustand wird typischerweise verwendet, wenn der Zeiger über dem Eintrag ist. Im aktiven Zustand werden **-activeforeground** des Menüs und **-activebackground** des Eintrags verwendet. Der deaktivierte Zustand bedeutet, dass der Eintrag unempfindlich sein soll: Die Standard-Bindings weigern sich, ihn zu aktivieren oder aufzurufen. In diesem Zustand werden **-disabledforeground** des Menüs und **-background** des Eintrags verwendet. Diese Option ist für Trenner-Einträge nicht verfügbar.

[-underline]{.lit} [value]{.arg}
: Legt den ganzzahligen Index eines zu unterstreichenden Zeichens im Eintrag fest. Diese Option wird auch von den Standard-Bindings abgefragt und für die Tastatur-Traversierung verwendet. 0 entspricht dem ersten Zeichen des im Eintrag angezeigten Textes, 1 dem nächsten und so weiter. Wird im Eintrag ein Bitmap oder Bild angezeigt, wird diese Option ignoriert. Diese Option ist für Trenner- oder Tear-off-Einträge nicht verfügbar.

[-value]{.lit} [value]{.arg}
: Nur für Radiobutton-Einträge verfügbar. Legt den Wert fest, der in der zugehörigen Variable des Eintrags gespeichert wird, wenn der Eintrag ausgewählt ist. Wird ein leerer String angegeben, wird die Option **-label** des Eintrags als in der Variable zu speichernder Wert verwendet.

[-variable]{.lit} [value]{.arg}
: Nur für Checkbutton- und Radiobutton-Einträge verfügbar. Legt den Namen einer globalen Variable fest, die gesetzt wird, wenn der Eintrag ausgewählt wird. Bei Checkbutton-Einträgen wird die Variable auch gesetzt, wenn der Eintrag abgewählt wird. Bei Radiobutton-Einträgen bewirkt eine Änderung der Variable, dass sich der aktuell ausgewählte Eintrag abwählt.

    Bei Checkbutton-Einträgen wird der Standardwert dieser Option aus der Option **-label** übernommen; bei Radiobutton-Einträgen wird ein einzelner fester Wert verwendet. Es wird empfohlen, die Option **-variable** beim Erzeugen eines Checkbuttons oder Radiobuttons immer zu setzen.


# Menü-Konfigurationen

Die Standard-Bindings unterstützen vier verschiedene Arten der Menüverwendung:

**Pulldown-Menüs in der Menüleiste**
: Dies ist der häufigste Fall. Sie erzeugen ein Menu-Widget, das die Menüleiste wird. Sie fügen diesem Menü Cascade-Einträge hinzu und geben die Pulldown-Menüs an, die Sie in der Menüleiste verwenden möchten. Anschließend erzeugen Sie alle Pulldowns. Danach geben Sie das Menü mit der Option **-menu** des Widget-Befehls des Toplevel an. Siehe die Manpage [toplevel] für Details.

**Pulldown-Menüs in Menubuttons**
: Dies ist der kompatible Weg für Menüleisten. Sie erzeugen ein Menubutton-Widget für jedes Top-Level-Menü und ordnen typischerweise eine Reihe von Menubuttons in einem Menüleisten-Fenster an. Sie erzeugen auch die Top-Level-Menüs und kaskadierten Untermenüs und verknüpfen sie mit **-menu**-Optionen in Menubuttons und Cascade-Menüeinträgen. Das Top-Level-Menü muss ein Kind des Menubuttons sein, und jedes Untermenü muss ein Kind des Menüs sein, das darauf verweist. Danach erlauben die Standard-Bindings den Benutzern, den Menübaum über den Menubutton zu traversieren und aufzurufen; siehe die Manpage [menubutton] für Details.

**Pop-up-Menüs**
: Pop-up-Menüs werden typischerweise als Reaktion auf einen Mausklick oder Tastendruck gepostet. Sie erzeugen die Pop-up-Menüs und kaskadierten Untermenüs und rufen zur passenden Zeit [tk\_popup][popup] auf, um das Top-Level-Menü zu posten.

**Optionsmenüs**
: Ein Optionsmenü besteht aus einem Menubutton mit einem zugehörigen Menü, mit dem einer von mehreren Werten ausgewählt werden kann. Der aktuelle Wert wird im Menubutton angezeigt und in einer globalen Variable gespeichert. Verwenden Sie die Prozedur [tk\_optionMenu][optionMenu], um Options-Menubuttons und ihre Menüs zu erzeugen.

**Abgerissene Menüs**
: Ein abgerissenes Menü erzeugen Sie, indem Sie den Tear-off-Eintrag oben in einem bestehenden Menü aufrufen. Die Standard-Bindings erzeugen ein neues Menü als Kopie des Originals und lassen es dauerhaft als Toplevel-Fenster gepostet. Das abgerissene Menü verhält sich wie das Originalmenü.


# Standard-Bindings

Tk erstellt automatisch Klassen-Bindings für Menüs, die folgendes Standardverhalten geben:

1. Wenn die Maus ein Menü betritt, wird der Eintrag unter dem Mauszeiger aktiviert; bewegt sich die Maus im Menü, ändert sich der aktive Eintrag entsprechend.

2. Wenn die Maus ein Menü verlässt, werden alle Einträge im Menü deaktiviert, außer im Spezialfall, wenn die Maus von einem Menü zu einem kaskadierten Untermenü wechselt.

3. Wird eine Taste über einem Menü losgelassen, wird der aktive Eintrag (falls vorhanden) aufgerufen. Das Menü wird auch entfernt, sofern es kein abgerissenes Menü ist.

4. Die Tasten Leertaste und Return rufen den aktiven Eintrag auf und entfernen das Menü.

5. Haben Einträge im Menü mit der Option **-underline** unterstrichene Buchstaben, ruft das Drücken eines dieser Buchstaben (oder der Groß-/Kleinschreibungsvariante) den Eintrag auf und entfernt das Menü.

6. Die Escape-Taste bricht eine laufende Menüauswahl ab, ohne einen Eintrag aufzurufen. Sie entfernt das Menü auch, sofern es kein abgerissenes Menü ist.

7. Die Tasten Auf und Ab aktivieren den nächsthöheren bzw. nächsttieferen Eintrag im Menü. Am Ende des Menüs springt der aktive Eintrag zum anderen Ende.

8. Die linke Pfeiltaste wechselt zum nächsten Menü links. Ist das aktuelle Menü ein kaskadiertes Untermenü, wird das Untermenü entfernt und der aktuelle Menüeintrag wird zum Cascade-Eintrag im Eltern-Menü. Ist das aktuelle Menü ein von einem Menubutton gepostetes Top-Level-Menü, wird der aktuelle Menubutton entfernt und der nächste Menubutton links gepostet. Andernfalls hat die Taste keine Wirkung. Die Links-Rechts-Reihenfolge der Menubuttons folgt ihrer Stapelreihenfolge: Tk nimmt an, dass der unterste Menubutton (standardmäßig der zuerst erzeugte) links ist.

9. Die rechte Pfeiltaste wechselt zum nächsten Menü rechts. Ist der aktuelle Eintrag ein Cascade-Eintrag, wird das Untermenü gepostet und der aktuelle Menüeintrag wird zum ersten Eintrag im Untermenü. War das aktuelle Menü von einem Menubutton gepostet, wird der aktuelle Menubutton entfernt und der nächste Menubutton rechts gepostet.


Deaktivierte Menüeinträge reagieren nicht: Sie werden nicht aktiviert und ignorieren Mausklicks.

Mehrere Bindings verwenden den Befehl **tk\_menuSetFocus**. Er speichert den aktuellen Fokus und setzt den Fokus auf sein *pathName*-Argument, ein Menu-Widget.

Das Verhalten von Menüs kann geändert werden, indem neue Bindings für einzelne Widgets definiert oder die Klassen-Bindings neu definiert werden.

# Bugs

Derzeit ist es nicht möglich, die Optionsdatenbank zu verwenden, um Werte für die Optionen einzelner Einträge festzulegen.


[bind]: bind.md
[ConfigWidg]: ../tk-c/ConfigWidg.md
[GetBitmap]: ../tk-c/GetBitmap.md
[image]: image.md
[menubutton]: menubutton.md
[optionMenu]: optionMenu.md
[options]: options.md
[popup]: popup.md
[string]: ../tcl/string.md
[tkvars]: tkvars.md
[toplevel]: toplevel.md
