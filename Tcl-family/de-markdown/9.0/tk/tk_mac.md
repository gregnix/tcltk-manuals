---
CommandName: tk::mac
ManualSection: n
Version: 8.6
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bind(n)
 - wm(n)
Keywords:
 - about dialog
 - antialiasing
 - Apple event
 - icon
 - NSImage
Copyright:
 - Copyright (c) 2011 Kevin Walzer.
 - Copyright (c) 2011 Donal K. Fellows.
---

# NAME

tk::mac - Mac-spezifische Funktionen unter macOS aus Tk nutzen

# ÜBERSICHT

::: {.synopsis} :::
[::tk::mac::DoScriptFile]{.cmd} 
[::tk::mac::DoScriptText]{.cmd} 
[::tk::mac::ShowPreferences]{.cmd} 
[::tk::mac::OpenApplication]{.cmd} 
[::tk::mac::ReopenApplication]{.cmd} 
[::tk::mac::OpenDocument]{.cmd} [file...]{.arg} 
[::tk::mac::PrintDocument]{.cmd} [file...]{.arg} 
[::tk::mac::Quit]{.cmd} 
[::tk::mac::OnHide]{.cmd} 
[::tk::mac::OnShow]{.cmd} 
[::tk::mac::ShowHelp]{.cmd} 
[::tk::mac::PerformService]{.cmd} 
[::tk::mac::LaunchURL]{.cmd} [URL...]{.arg} 
[::tk::mac::GetAppPath]{.cmd} 

[::tk::mac::standardAboutPanel]{.cmd} 

[::tk::mac::useCompatibilityMetrics]{.cmd} [boolean]{.arg} 
[::tk::mac::CGAntialiasLimit]{.cmd} [limit]{.arg} 
[::tk::mac::antialiasedtext]{.cmd} [number]{.arg} 
[::tk::mac::useThemedToplevel]{.cmd} [boolean]{.arg} 

[::tk::mac::iconBitmap]{.cmd} [name]{.arg} [width]{.arg} [height]{.arg} [-kind]{.arg} [value]{.arg} 
:::

# EREIGNISBEHANDLER-RÜCKRUFUNGEN

Die Aqua/macOS-Anwendungsumgebung definiert zusätzliche Ereignisse, auf die Anwendungen reagieren sollten. Tk mappt diese Ereignisse auf Aufrufe von Befehlen im Namespace **::tk::mac**; sofern nicht anders angegeben, erfolgt keine Aktion, wenn der Befehl fehlt.

**::tk::mac::DoScriptFile**
: Standard-Apple-Event-Handler für AEDoScriptHandler. Dieser Befehl führt eine Tcl-Datei aus, wenn ein AppleScript einen „do script“-Befehl an Wish mit einem Dateipfad als Parameter sendet.

**::tk::mac::DoScriptText**
: Standard-Apple-Event-Handler für AEDoScriptHandler. Dieser Befehl führt Tcl-Code aus, wenn ein AppleScript einen „do script“-Befehl an Wish mit Tcl-Code oder einer Tcl-Prozedur als Parameter sendet.

**::tk::mac::ShowPreferences**
: Standard-Apple-Event-Handler für kAEShowPreferences, „pref“. Der Menüeintrag „Einstellungen“ im Anwendungsmenü ist nur aktiv, wenn diese Prozedur definiert ist. Typischerweise umschließt der Befehl eine eigene Einstellungsfunktion, die ein Einstellungsfenster öffnet, etwa:

```
    proc ::tk::mac::ShowPreferences {} {
        setPref
    }
```

**::tk::mac::OpenApplication**
: Ist eine Prozedur dieses Namens definiert, wird sie beim ersten Öffnen der Anwendung ausgeführt. Standard-Apple-Event-Handler für kAEOpenApplication, „oapp“.

**::tk::mac::ReopenApplication**
: Ist eine Prozedur dieses Namens definiert, ist sie der Standard-Apple-Event-Handler für kAEReopenApplication, „rapp“, das Apple Event beim Öffnen einer bereits laufenden Anwendung (z. B. Klick auf das Dock-Symbol). Beispiel: minimiertes Fenster wiederherstellen beim Dock-Klick:

```
    proc ::tk::mac::ReopenApplication {} {
        if {[wm state .] eq "withdrawn"} {
            wm state . normal
        } else {
            wm deiconify .
        }
        raise .
    }
```

**::tk::mac::OpenDocument** *file...*
: Ist eine Prozedur dieses Namens definiert, ist sie der Standard-Apple-Event-Handler für kAEOpenDocuments, „odoc“, wenn die Anwendung aufgefordert wird, ein oder mehrere Dokumente zu öffnen (z. B. per Drag & Drop oder durch Öffnen eines dem Programm zugeordneten Dokumenttyps). Die Prozedur soll Pfade der zu öffnenden Dateien als Argumente erhalten, z. B.:

```
    proc ::tk::mac::OpenDocument {args} {
        foreach f $args {my_open_document $f}
    }
```

**::tk::mac::PrintDocument** *file...*
: Ist eine Prozedur dieses Namens definiert, ist sie der Standard-Apple-Event-Handler für kAEPrintDocuments, „pdoc“, wenn die Anwendung zum Drucken eines Dokuments aufgefordert wird. Sie erhält einen absoluten Dateipfad als Argument.

**::tk::mac::Quit**
: Ist eine Prozedur dieses Namens definiert, ist sie der Standard-Apple-Event-Handler für kAEQuitApplication, „quit“, z. B. über Beenden im Anwendungs- oder Dock-Menü oder beim Abmelden/Neustart/Herunterfahren. Ist sie nicht definiert, wird stattdessen **exit** aufgerufen.

**::tk::mac::OnHide**
: Wenn definiert, wird sie bei kEventAppHidden aufgerufen, z. B. über „Ausblenden“ im Anwendungs- oder Dock-Menü.

**::tk::mac::OnShow**
: Wenn definiert, wird sie bei kEventAppShown aufgerufen, z. B. über „Alle einblenden“ im Anwendungsmenü oder durch Klick auf das Dock-Symbol einer ausgeblendeten Anwendung.

**::tk::mac::ShowHelp**
: Passt das Verhalten des Apple-Hilfe-Menüs an; ist die Prozedur nicht definiert, führt der plattformspezifische Hilfeeintrag „YourApp Help“ die Standard-Cocoa-Aktion aus (Hilfebuch aus Info.plist oder Meldung, wenn keines gesetzt ist).

**::tk::mac::PerformService**
: Führt eine aus dem macOS-Menü „Dienste“ im Anwendungsmenü aufgerufene Tcl-Prozedur aus. „Dienste“ ermöglichen Kommunikation zwischen Anwendungen; Daten (z. B. markierter Text) können an eine andere Anwendung gesendet werden, z. B. an Safari als Google-Suche oder an TextEdit zum Anhängen. Beispiel (in der Anwendung anpassen):

```
    proc ::tk::mac::PerformService {} {
        set data [clipboard get]
        $w insert end $data
    }
```
Die Daten werden über die Zwischenablage bezogen; es gibt keinen anderen unterstützten Weg. Sollen Dienste nicht genutzt werden, können die NSServices-Schlüssel aus der Info.plist entfernt werden. Der zugrunde liegende Code erlaubt text-, entry- und ttk::entry-Widgets den Zugriff auf Dienste anderer Anwendungen über das Dienste-Menü. Der NSPortName-Schlüssel in Wishs Info.plist ist derzeit „Wish“; ändert ein Entwickler den Namen der Wish-Ausführungsdatei, sollte dieser Schlüssel entsprechend angepasst werden.

**::tk::mac::LaunchURL** *URL...*
: Wenn definiert, startet eine URL innerhalb von Tk, z. B. wenn die Anwendung eine URL selbst verarbeiten soll (RSS-Anzeige) statt die Standardanwendung zu nutzen — kann aber auch so definiert werden. Wish enthält ein Platzhalter-URL-Schema „foo://“ in CFBundleURLSchemes; das sollte für das gewünschte URL-Schema angepasst werden.

**::tk::mac::GetAppPath**
: Gibt den Dateipfad der aktuellen Anwendung zurück.


# ZUSÄTZLICHE DIALOGE

Aqua/macOS definiert weitere Dialoge, die Anwendungen unterstützen sollten.

**::tk::mac::standardAboutPanel**
: Bringt das Standard-Cocoa-„Über“-Panel nach vorn mit Informationen aus den Bundle-Dateien. Das Panel zeigt das Anwendungssymbol und Werte zu den Info.plist-Schlüsseln CFBundleName, CFBundleShortVersionString, NSAboutPanelOptionVersion und NSHumanReadableCopyright. Existiert *Credits.html* oder *Credits.rtf* im Resources-Verzeichnis des Bundles, wird der Inhalt unten im Dialog in einer scrollbaren Textbox angezeigt. Siehe die Dokumentation zu -[NSApplication orderFrontStandardAboutPanelWithOptions:]. Ein Hook für einen eigenen „Über“-Dialog: Ist im Hauptinterpreter eine Tcl-Prozedur **tkAboutDialog** definiert, wird diese statt **standardAboutPanel** aufgerufen.


# SYSTEMKONFIGURATION

Es gibt globale Konfigurationsoptionen, die steuern, wie Tk standardmäßig rendert.

**::tk::mac::useCompatibilityMetrics** *boolean*
: Erhält Kompatibilität mit älteren Tk/Aqua-Metriken; auf **false** für nativere Abstände setzen.

**::tk::mac::CGAntialiasLimit** *limit*
: Setzt die Antialiasing-Grenze; Linien dünner als *limit* Pixel werden nicht antialiased. Ganzzahl, Standard 0 (alle Linien antialiased).

**::tk::mac::antialiasedtext** *number*
: Steuert Text-Antialiasing. Mögliche Werte für *number*: -1 (Standard, Systemvorgabe), 0 (kein Text-AA), 1 (Text-AA).

**::tk::mac::useThemedToplevel** *boolean*
: Zeichnet Toplevel-Fenster mit dem modernen grauen Mac-Hintergrund. Entspricht **-background systemWindowHeaderBackground** am Toplevel oder der Verwendung eines **ttk::frame**.


# HILFSBEFEHLE

**::tk::mac::iconBitmap** *name width height -kind value*
: Rendert native Symbole und Bitmaps in Tk-Anwendungen (einschließlich jeder von NSImage lesbaren Bilddatei). Ein nativer Bitmap-Name wird (in dieser Reihenfolge) interpretiert als:

-     vordefinierter eingebauter 32×32-Symbolname (**stop**, **caution**, **document** usw.)

-     *name*, wie von **tk::mac::iconBitmap** definiert

-     NSImage-benannter Bildname

-     NSImage-URL-Zeichenkette

-     4-Zeichen-OSType eines IconServices-Symbols

Die Argumente *width* und *height* von **tk::mac::iconBitmap** legen die Bildabmessungen fest; *-kind* muss eines von Folgendem sein:

**-file**
: Symbol der Datei am angegebenen Pfad

**-fileType**
: Symbol des angegebenen Dateityps

**-osType**
: Symbol des angegebenen 4-Zeichen-OSType-Dateityps

**-systemType**
: Symbol für den angegebenen IconServices-4-Zeichen-OSType

**-namedImage**
: benanntes NSImage für den angegebenen Namen

**-imageFile**
: Bild am angegebenen Pfad


