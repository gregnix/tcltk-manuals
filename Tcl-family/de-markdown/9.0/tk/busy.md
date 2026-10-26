---
CommandName: busy
title: busy
ManualSection: n
Version: unknown
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - grab(n)
Keywords:
 - busy
 - keyboard events
 - pointer events
 - window
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
 - Copyright (c) 2008 Jos Decoster
---

# Name

busy - Tk-Widgets vorübergehend als beschäftigt markieren und Benutzerinteraktionen blockieren

# Übersicht

::: {.synopsis} :::
[tk]{.cmd} [busy]{.sub} [window]{.arg} [options]{.optarg}
[tk]{.cmd} [busy]{.sub} [busywindow]{.lit} [window]{.arg}
[tk]{.cmd} [busy]{.sub} [hold]{.lit} [window]{.arg} [options]{.optarg}
[tk]{.cmd} [busy]{.sub} [configure]{.lit} [window]{.arg} [option value]{.optdot}
[tk]{.cmd} [busy]{.sub} [forget]{.lit} [window]{.arg} [window]{.optdot}
[tk]{.cmd} [busy]{.sub} [current]{.lit} [pattern]{.optarg}
[tk]{.cmd} [busy]{.sub} [status]{.lit} [window]{.arg}
:::

# Beschreibung

Der Befehl [tk busy][tk] bietet ein einfaches Mittel, Mauszeiger-Ereignisse von Tk-Widgets zu blockieren und dabei den Cursor des Widgets durch einen konfigurierbaren Busy-Cursor zu ersetzen. Dieser Befehl verhindert nicht, dass Tastaturereignisse an die als beschäftigt markierten Widgets gesendet werden.

# Einleitung

In Anwendungen gibt es oft Situationen, in denen Sie die Aktionen des Benutzers vorübergehend einschränken möchten. Eine Anwendung könnte beispielsweise einen „Run“-Button haben, dessen Drücken eine Verarbeitung auslöst. Während die Anwendung jedoch mit der Verarbeitung beschäftigt ist, möchten Sie wahrscheinlich nicht, dass der Benutzer den „Run“-Button erneut anklicken kann. Sie möchten den Benutzer möglicherweise auch von anderen Aufgaben abhalten, etwa dem Anklicken eines „Print“-Buttons.

Der Befehl [tk busy][tk] ermöglicht es, Tk-Widgets als beschäftigt zu markieren. Das bedeutet, dass Benutzerinteraktionen wie Button-Klicks, Mausbewegungen, Tastatureingaben usw. vom Widget ignoriert werden. Sie können einen speziellen Cursor (z. B. eine Uhr) setzen, der den normalen Cursor des Widgets überschreibt und Rückmeldung gibt, dass die Anwendung (das Widget) vorübergehend beschäftigt ist.

Wenn ein Widget als beschäftigt markiert ist, ignorieren das Widget und alle seine Nachkommen Zeigerereignisse. Es ist einfach, ein ganzes Panel von Widgets als beschäftigt zu markieren: Machen Sie einfach das Toplevel-Widget (z. B. „.“) beschäftigt. Das ist einfacher und weitaus effizienter, als die Widget-Hierarchie rekursiv zu durchlaufen, jedes Widget zu deaktivieren und seinen Cursor neu zu konfigurieren.

Oft kann der Befehl [tk busy][tk] anstelle des Tk-Befehls [grab] verwendet werden. Im Gegensatz zu [grab], das alle Benutzerinteraktionen auf ein Widget beschränkt, können mit [tk busy][tk] mehrere Widgets gleichzeitig aktiv sein (z. B. ein „Cancel“-Dialog und ein „Help“-Button).

## Beispiel

Sie können mehrere Widgets als beschäftigt markieren, indem Sie einfach ihr Vorfahren-Widget mit der Operation **hold** als beschäftigt markieren.

```
frame .top
button .top.button; canvas .top.canvas
pack .top.button .top.canvas
pack .top
# . . .
tk busy hold .top
update
```

Alle Widgets innerhalb von **.top** (einschließlich **.top**) sind jetzt beschäftigt. [update] stellt sicher, dass der Befehl [tk busy][tk] wirksam wird, bevor andere Benutzerereignisse auftreten können.

Wenn die Anwendung nicht mehr mit der Verarbeitung beschäftigt ist, können Sie Benutzerinteraktionen wieder zulassen und mit der Operation **forget** alle von ihr belegten Ressourcen freigeben.

```
tk busy forget .top
```

Das Busy-Fenster hat einen konfigurierbaren Cursor. Sie können den Busy-Cursor mit der Operation **configure** ändern.

```
tk busy configure .top -cursor "watch"
```

Das Zerstören des Widgets räumt auch alle vom Befehl [tk busy][tk] belegten Ressourcen auf.

# Operationen

Für den Befehl [tk busy][tk] stehen folgende Operationen zur Verfügung:

**tk busy** *window* ?*option value*?...
: Kurzform für den Befehl **tk busy hold**.

[tk]{.cmd} [busy]{.sub} [busywindow]{.lit} [window]{.arg}
: Gibt den Pfadnamen des Busy-Fensters zurück (d. h. des transparenten Fensters, das das als beschäftigt erscheinende Widget abschirmt), das der Befehl **tk busy hold** für *window* erzeugt hat, oder die leere Zeichenkette, wenn *window* nicht beschäftigt ist.

[tk]{.cmd} [busy]{.sub} [cget]{.lit} [window]{.arg} [option]{.arg}
: Fragt die Konfigurationsoptionen des Befehls [tk busy][tk] für *window* ab. *Window* muss der Pfadname eines Widgets sein, das zuvor durch die Operation **hold** als beschäftigt markiert wurde. Der Befehl gibt den aktuellen Wert der angegebenen *option* zurück. *Option* kann einen der von der Operation **hold** akzeptierten Werte haben.

[tk]{.cmd} [busy]{.sub} [configure]{.lit} [window]{.arg} [option value]{.optdot}
: Fragt die Konfigurationsoptionen des Befehls [tk busy][tk] für *window* ab oder ändert sie. *Window* muss der Pfadname eines Widgets sein, das zuvor durch die Operation **hold** als beschäftigt markiert wurde. Sind keine Optionen angegeben, wird eine Liste aller verfügbaren Optionen für *window* zurückgegeben (siehe [Tk\_ConfigureInfo][ConfigWidg] zum Format dieser Liste). Ist *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Rückgabewerts, wenn keine *option* angegeben ist). Sind ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Widget-Option(en) auf die angegebenen Werte; in diesem Fall gibt der Befehl die leere Zeichenkette zurück. *Option* kann einen der von der Operation **hold** akzeptierten Werte haben.

    Beachten Sie, dass die Optionsdatenbank über *window* referenziert wird. Soll beispielsweise das Widget **.frame** als beschäftigt markiert werden, kann der Busy-Cursor dafür mit einem der folgenden [option]-Befehle festgelegt werden:

    ```
    option add *frame.busyCursor gumby
    option add *Frame.BusyCursor gumby
    ```

[tk]{.cmd} [busy]{.sub} [current]{.lit} [pattern]{.optarg}
: Gibt die Pfadnamen aller Widgets zurück, die derzeit als beschäftigt markiert sind. Ist ein *pattern* angegeben, werden nur die Pfadnamen beschäftigter Widgets zurückgegeben, die *pattern* entsprechen.

[tk]{.cmd} [busy]{.sub} [forget]{.lit} [window]{.arg} [window?...]{.optarg}
: Gibt die vom Befehl [tk busy][tk] für *window* belegten Ressourcen frei, einschließlich des transparenten Fensters. *Window* empfängt wieder Benutzerereignisse. Ressourcen werden auch freigegeben, wenn *window* zerstört wird. *Window* muss der Name eines in der Operation **hold** angegebenen Widgets sein, andernfalls wird ein Fehler gemeldet.

[tk]{.cmd} [busy]{.sub} [hold]{.lit} [window]{.arg} [option value]{.optdot}
: Lässt das angegebene *window* (und seine Nachkommen in der Tk-Fensterhierarchie) als beschäftigt erscheinen. *Window* muss ein gültiger Pfadname eines Tk-Widgets sein. Vor dem angegebenen Fenster wird ein transparentes Fenster platziert. Dieses transparente Fenster wird beim nächsten Abarbeiten von Idle-Aufgaben abgebildet, und das angegebene Fenster sowie seine Nachkommen werden für Benutzerinteraktionen blockiert. Normalerweise sollte unmittelbar danach [update] aufgerufen werden, damit die Operation **hold** wirksam ist, bevor die Anwendung mit ihrer Verarbeitung beginnt. Der Befehl gibt den Pfadnamen des erzeugten Busy-Fensters zurück (d. h. des transparenten Fensters, das das als beschäftigt erscheinende Widget abschirmt). Folgende Konfigurationsoptionen sind gültig:

    [-cursor]{.lit} [cursorName]{.arg}
    : Legt den Cursor fest, der angezeigt wird, wenn das Widget als beschäftigt markiert ist. *CursorName* kann in jeder von [Tk\_GetCursor][GetCursor] akzeptierten Form angegeben werden. Der Standardcursor ist unter Windows **wait** und auf anderen Plattformen **watch**.


[tk]{.cmd} [busy]{.sub} [status]{.lit} [window]{.arg}
: Gibt den Status eines Widgets *window* zurück. Kann *window* derzeit keine Benutzerinteraktionen empfangen, wird **1** zurückgegeben, andernfalls **0**.


# Ereignisbehandlung

## Bindings

Die Ereignisblockierung wird implementiert, indem ein transparentes Fenster erzeugt und abgebildet wird, das das Widget vollständig abdeckt. Wenn das Busy-Fenster abgebildet ist, schirmt es das Widget und seine Hierarchie unsichtbar von allen möglicherweise gesendeten Ereignissen ab. Wie Tk-Widgets haben Busy-Fenster Widget-Namen in der Tk-Fensterhierarchie. Das bedeutet, dass Sie den Befehl [bind] verwenden können, um Ereignisse im Busy-Fenster zu behandeln:

```
tk busy hold .frame.canvas
bind [tk busy busywindow .frame.canvas] <Enter> { ... }
```

oder

```
set busyWin [tk busy hold .frame.canvas]
bind $busyWin <Enter> { ... }
```

## Enter/Leave-Ereignisse

Das Abbilden und Entfernen von Busy-Fenstern erzeugt Enter/Leave-Ereignisse für alle von ihnen abgedeckten Widgets. Beachten Sie dies, wenn Sie Enter/Leave-Ereignisse in Widgets verfolgen.

## Tastaturereignisse

Wenn ein Widget als beschäftigt markiert ist, verhindert das Busy-Fenster, dass der Benutzer durch Anklicken den Tastaturfokus auf das Widget setzen kann. Hatte das Widget jedoch bereits den Fokus, kann es weiterhin Tastaturereignisse empfangen. Das Widget kann den Fokus auch weiterhin per Tastatur-Traversal erhalten. Um das zu verhindern, müssen Sie den Fokus auf ein anderes Fenster verschieben und sicherstellen, dass der Fokus nicht zu den als beschäftigt markierten Widgets zurückkehren kann (z. B. durch Beschränkung des Fokus auf einen Abbrechen-Button).

```
pack [frame .frame]
pack [text .frame.text]
tk busy hold .frame
pack [button .cancel -text "Cancel" -command exit]
focus .cancel
bind .cancel <Tab> {break}
bind .cancel <Shift-Tab> {break}
update
```

Das obige Beispiel verschiebt den Fokus von .frame unmittelbar nach dem Aufruf von **hold**, sodass keine Tastaturereignisse an **.frame** oder seine Nachkommen gesendet werden. Es stellt außerdem sicher, dass der Button **.cancel** per Tastatur nicht verlassen werden kann.

# Portierbarkeit

Beachten Sie, dass der Befehl [tk busy][tk] unter macOS derzeit keine Wirkung hat, wenn Tk mit Aqua-Unterstützung gebaut wurde.


[bind]: bind.md
[ConfigWidg]: ../tk-c/ConfigWidg.md
[GetCursor]: ../tk-c/GetCursor.md
[grab]: grab.md
[option]: option.md
[tk]: tk.md
[update]: ../tcl/update.md
