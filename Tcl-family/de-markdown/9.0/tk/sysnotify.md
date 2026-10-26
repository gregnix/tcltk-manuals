---
CommandName: tk sysnotify
title: tk sysnotify
ManualSection: n
Version: unknown
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - notify
 - alert
Copyright:
 - Copyright (c) 2020 Kevin Walzer
---

# Name

sysnotify - Erstellt ein Benachrichtigungsfenster mit Titel und Nachricht

# Übersicht

::: {.synopsis} :::
[tk]{.cmd} [sysnotify]{.sub} [title]{.arg} [message]{.arg}
:::

# Beschreibung

Der Befehl [tk sysnotify][tk] erzeugt eine plattformspezifische Systembenachrichtigung. Er soll dem Benutzer eine kurze, unaufdringliche Meldung liefern, indem kurz ein Fenster in einer Bildschirmecke erscheint.

# Beispiel

Beispiel für [tk sysnotify][tk]:

```
tk sysnotify "Alert" \
      "This is just a test of the Tk System Notification Code."
```

# Plattformhinweise

Die Versionen für macOS und Windows sind native Implementierungen mit System-APIs. Die X11-Version hängt optional von libnotify ab und fällt auf eine reine Tcl-Implementierung zurück, wenn libnotify nicht installiert ist. Auf jeder Plattform enthält die Benachrichtigung ein plattformspezifisches Standardbild zum Text.

**macOS**
: Unter macOS wird der Benutzer um Berechtigung für Benachrichtigungen gebeten. Das muss in den Systemeinstellungen von Apple unter „Mitteilungen“ aktiviert werden.

    Beim Einsatz einer Anwendung mit der eigenständigen Wish.app-Version scheint es nötig zu sein, die Bundle-ID in der Info.plist der Anwendung mit „**com**“ beginnen zu lassen, damit Benachrichtigungen funktionieren. Eine andere Präfix-Variante der Bundle-ID (z. B. „**tk.tcl.tkchat**“) führt dazu, dass Benachrichtigungen still fehlschlagen.

**Windows**
: Das Bild stammt aus der Systemleiste; **sysnotify** kann nur aufgerufen werden, wenn ein [systray] eingerichtet wurde.


[systray]: systray.md
[tk]: tk.md
