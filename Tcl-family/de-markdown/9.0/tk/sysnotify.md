---
CommandName: tk
ManualSection: sysnotify
Version: n
TclPart: 
TclDescription: Tk
Keywords:
 - notify
 - alert
Copyright:
 - Copyright (c) 2020 Kevin Walzer
---

# NAME

sysnotify - Erstellt ein Benachrichtigungsfenster mit Titel und Nachricht

# ÜBERSICHT

::: {.synopsis} :::
[tk]{.cmd} [sysnotify]{.sub} [title]{.arg} [message]{.arg} 
:::

# BESCHREIBUNG

Der Befehl **tk sysnotify** erzeugt eine plattformspezifische Systembenachrichtigung. Er soll dem Benutzer eine kurze, unaufdringliche Meldung liefern, indem kurz ein Fenster in einer Bildschirmecke erscheint.

# BEISPIEL

Beispiel für **tk sysnotify**:

```
tk sysnotify "Alert" \
      "This is just a test of the Tk System Notification Code."
```

# PLATTFORMHINWEISE

Die Versionen für macOS und Windows sind native Implementierungen mit System-APIs. Die X11-Version hängt optional von libnotify ab und fällt auf eine reine Tcl-Implementierung zurück, wenn libnotify nicht installiert ist. Auf jeder Plattform enthält die Benachrichtigung ein plattformspezifisches Standardbild zum Text.

**macOS**
: Unter macOS wird der Benutzer um Berechtigung für Benachrichtigungen gebeten. Das muss in den Systemeinstellungen von Apple unter „Mitteilungen“ aktiviert werden.
    Beim Einsatz einer Anwendung mit der eigenständigen Wish.app-Version scheint die Bundle-ID in der Info.plist der Anwendung mit „**com**“ zu beginnen, damit Benachrichtigungen funktionieren. Eine andere Präfix-Variante der Bundle-ID (z. B. „**tk.tcl.tkchat**“) führt dazu, dass Benachrichtigungen still fehlschlagen.

**Windows**
: Das Bild stammt aus der Systemleiste; **sysnotify** kann nur aufgerufen werden, wenn ein **systray** eingerichtet wurde.

