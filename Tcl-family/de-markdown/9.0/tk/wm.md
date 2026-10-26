---
CommandName: wm
title: wm
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - toplevel(n)
 - winfo(n)
Keywords:
 - aspect ratio
 - deiconify
 - focus model
 - geometry
 - grid
 - group
 - icon
 - iconify
 - increments
 - position
 - size
 - title
 - top-level window
 - units
 - window manager
Copyright:
 - Copyright (c) 1991-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

wm - Kommunikation mit dem Fenstermanager

# Übersicht

::: {.synopsis} :::
[wm]{.cmd} [option]{.arg} [window]{.arg} [args]{.optarg}
:::

# Beschreibung

Der **wm**-Befehl dient der Interaktion mit Fenstermanagern, um Eigenschaften wie den Titel eines Fensters, seine Geometrie oder die Schritte, in denen es skaliert werden darf, zu steuern. Der **wm**-Befehl kann je nach dem *option*-Argument viele verschiedene Formen annehmen. Alle Formen erwarten mindestens ein weiteres Argument, *window*, das der Pfadname eines Toplevel-Fensters sein muss.

Die gültigen Formen des **wm**-Befehls sind:

[wm]{.cmd} [aspect]{.sub} [window]{.arg} [minNumer minDenom maxNumer maxDenom]{.optarg}
: Wenn *minNumer*, *minDenom*, *maxNumer* und *maxDenom* alle angegeben sind, werden sie an den Fenstermanager übergeben; der Fenstermanager soll sie nutzen, um einen zulässigen Bereich von Seitenverhältnissen für *window* durchzusetzen. Das Seitenverhältnis von *window* (Breite/Länge) wird so eingeschränkt, dass es zwischen *minNumer*/*minDenom* und *maxNumer*/*maxDenom* liegt. Wenn *minNumer* usw. alle als leere Strings angegeben sind, werden bestehende Seitenverhältnis-Beschränkungen entfernt. Wenn *minNumer* usw. angegeben sind, gibt der Befehl einen leeren String zurück. Andernfalls gibt er eine Tcl-Liste mit vier Elementen zurück, die die aktuellen Werte von *minNumer*, *minDenom*, *maxNumer* und *maxDenom* sind (wenn keine Seitenverhältnis-Beschränkungen gelten, wird ein leerer String zurückgegeben).

[wm]{.cmd} [attributes]{.sub} [window]{.arg}
: ...siehe nächstes...

[wm]{.cmd} [attributes]{.sub} [window]{.arg} [option]{.optlit}
: ...siehe nächstes...

[wm]{.cmd} [attributes]{.sub} [window]{.arg} [option value option value...]{.optlit}
: Dieser Unterbefehl gibt plattformspezifische Attribute eines Fensters zurück oder setzt sie. Die erste Form gibt eine Liste der plattformspezifischen Flags und ihrer Werte zurück. Die zweite Form gibt den Wert der angegebenen Option zurück. Die dritte Form setzt einen oder mehrere Werte. Die Werte sind wie folgt:

    Alle Plattformen unterstützen die folgenden Attribute (X11-Nutzer sollten jedoch die Hinweise unten beachten):

    [-alpha]{.lit}
    : Legt die Alpha-Transparenzstufe des Toplevel-Fensters fest. Es wird ein Wert von **0.0** (vollständig transparent) bis **1.0** (undurchsichtig) akzeptiert. Werte außerhalb dieses Bereichs werden eingeschränkt. Wo nicht unterstützt, bleibt der **-alpha**-Wert bei **1.0**.

    [-fullscreen]{.lit}
    : Platziert das Fenster in einem Modus, der den gesamten Bildschirm einnimmt, keine Rahmen hat und den allgemeinen Nutzungsbereich abdeckt (z. B. Startmenü und Taskleiste unter Windows, Dock und Menüleiste unter macOS, allgemeine Fensterdekorationen unter X11).

    [-topmost]{.lit}
    : Legt fest, ob dies ein Topmost-Fenster ist (wird über allen anderen Fenstern angezeigt).


    Unter Windows können die folgenden Attribute gesetzt werden.

    [-disabled]{.lit}
    : Legt fest, ob das Fenster deaktiviert ist.

    [-toolwindow]{.lit}
    : Legt ein Toolwindow-Stil-Fenster fest (wie in der MSDN definiert).

    [-transparentcolor]{.lit}
    : Legt den transparenten Farbindex des Toplevel-Fensters fest. Es wird jeder von [Tk\_GetColor][GetColor] akzeptierte Farbwert genommen. Wenn der leere String angegeben wird (Standard), wird keine transparente Farbe verwendet. Unterstützt unter Windows 2000/XP+. Wo nicht unterstützt, bleibt der **-transparentcolor**-Wert bei **{}**.


    Unter macOS können die folgenden Attribute gesetzt werden.

    [-appearance]{.lit}
    : Legt fest, ob das Fenster im „Dark Mode“ dargestellt wird. Zulässige Werte sind **auto**, **aqua** und **darkaqua**. Bei der Einstellung **auto** wird das Erscheinungsbild des Fensters durch die Systemeinstellungen gesteuert.

    [-class]{.lit}
    : Legt fest, ob das zugrunde liegende Aqua-Fenster eines Toplevel-Fensters ein Objekt der Klasse NSWindow oder NSPanel ist. Die beiden zulässigen Werte sind **nswindow** und **nspanel**. Die Klasse des zugrunde liegenden Aqua-Fensters kann nicht mehr geändert werden, sobald das Fenster instanziiert wurde; der Versuch ist ein Fehler. Es ist jedoch erlaubt, diese Option für einen Pfadnamen zu setzen, der keinem bestehenden Fenster entspricht. Dann wird der Klassenname für die spätere Verwendung zwischengespeichert. Wenn später ein Toplevel-Fenster mit diesem Pfadnamen erstellt wird, bestimmt der zwischengespeicherte Klassenname, welche Klasse für das zugrunde liegende Aqua-Fenster verwendet wird.

    [-isdark]{.lit}
    : Gibt einen booleschen Wert zurück, der **true** ist, wenn das Fenster derzeit im Dark Mode ist.

    [-modified]{.lit}
    : Legt den Änderungszustand des Fensters fest (bestimmt, ob das Schließen-Widget den Änderungsindikator enthält und ob das Proxy-Icon ziehbar ist).

    [-notify]{.lit}
    : Legt den Prozess-Benachrichtigungszustand fest (Springen des Anwendungs-Dock-Icons).

    [-stylemask]{.lit}
    : Legt eine Ganzzahl fest, die als styleMask des zugrunde liegenden Aqua-Fensters zugewiesen wird. (Siehe die Apple-Dokumentation zur styleMask-Eigenschaft der NSWindow-Klasse.) Der Wert dieser Option sollte eine Liste von Bitnamen sein. Jedes in der Liste genannte Bit wird auf 1 gesetzt, alle anderen auf 0. Zulässige Bitnamen sind: **titled**, **closable**, **miniaturizable**, **resizable**, **fullsizecontentview**, **docmodal**, **utility**, **nonactivatingpanel** und **HUDwindow**. Beachten Sie, dass das Setzen des Bits **fullsizecontentview** zur Folge hat, dass die Titelleiste des Fensters transparent wird.

    [-tabbingid]{.lit}
    : Steuert, wie tabbed Toplevel-Fenster gruppiert werden. Zwei Tabs in derselben Gruppe müssen Toplevel-Fenstern mit derselben tabbingid entsprechen, die eine beliebige UTF-8-Zeichenkette sein kann. In der Tk-Implementierung führt das Ändern der tabbingid eines Toplevel-Fensters in einer Tab-Gruppe dazu, dass es in eine andere Gruppe verschoben wird, in der alle Tabs die neue tabbingid haben, oder — wenn die neue tabbingid eindeutig ist — zu einem normalen, nicht getabten Toplevel-Fenster wird. Es ist erlaubt, die tabbingid zu setzen, bevor das Toplevel-Fenster erstellt wird. Entspricht der im Befehl angegebene Pfadname keinem Toplevel-Fenster, wird der Wert zwischengespeichert und später verwendet, wenn das Toplevel-Fenster tatsächlich erstellt wird.

    [-tabbingmode]{.lit}
    : Steuert, ob ein Toplevel-Fenster als Tab innerhalb einer Tab-Gruppe geöffnet werden kann. Zulässige Werte sind **auto**, **preferred** oder **disallowed**. Ein Toplevel-Fenster kann genau in zwei Situationen als Tab geöffnet werden: wenn sein tabbingmode **preferred** ist; oder wenn sein tabbingmode **auto** ist und der Benutzer in den Systemeinstellungen unter Desktop und Dock „Beim Öffnen von Dokumenten Tabs bevorzugen“ gewählt hat. Es ist erlaubt, den tabbingmode zu setzen, bevor das Toplevel-Fenster erstellt wird. Entspricht der im Befehl angegebene Pfadname keinem Toplevel-Fenster, wird der Wert zwischengespeichert und später verwendet, wenn das Toplevel-Fenster tatsächlich erstellt wird.

    [-titlepath]{.lit}
    : Legt den Pfad der Datei fest, die als Proxy-Icon des Fensters referenziert wird (das anstelle des Finder-Icons der Datei gezogen und abgelegt werden kann).

    [-transparent]{.lit}
    : Macht den Inhaltsbereich des Fensters transparent und schaltet den Fensterschatten aus. Damit die Transparenz wirksam ist, muss der Toplevel-Hintergrund auf eine Farbe mit Alpha gesetzt werden, z. B. „systemTransparent“.


    Unter X11 können die folgenden Attribute gesetzt werden. Nicht alle Fenstermanager unterstützen sie; bei älteren WMs haben sie keine Wirkung.

    [-type]{.lit}
    : [Fordert an, dass der Fenstermanager das Fenster als den angegebenen Typ bzw. die angegebenen Typen interpretiert. Das kann zu anderer Dekoration oder anderer Verwaltung führen; was genau passiert, liegt vollständig beim Fenstermanager. Eine Typenliste kann in Reihenfolge der Präferenz verwendet werden. Die folgenden Werte werden auf in der EWMH-Spezifikation definierte Konstanten abgebildet (andere sind möglich, aber nicht empfohlen):]{version="8.6"}

        [**desktop**]{version="8.6"}
        : [kennzeichnet eine Desktop-Funktion,]{version="8.6"}

        [**dock**]{version="8.6"}
        : [kennzeichnet eine Dock-/Panel-Funktion,]{version="8.6"}

        [**toolbar**]{version="8.6"}
        : [kennzeichnet ein Toolbar-Fenster, das im Auftrag eines anderen Fensters handeln soll, wie mit **wm transient** angegeben,]{version="8.6"}

        [**menu**]{version="8.6"}
        : [kennzeichnet ein abgetrenntes Menü, das im Auftrag eines anderen Fensters handeln soll, wie mit **wm transient** angegeben,]{version="8.6"}

        [**utility**]{version="8.6"}
        : [kennzeichnet ein Hilfsfenster (z. B. Palette oder Werkzeugkasten), das im Auftrag eines anderen Fensters handeln soll, wie mit **wm transient** angegeben,]{version="8.6"}

        [**splash**]{version="8.6"}
        : [kennzeichnet einen Splash-Screen beim Anwendungsstart,]{version="8.6"}

        [**dialog**]{version="8.6"}
        : [kennzeichnet ein allgemeines Dialogfenster, das im Auftrag eines anderen Fensters handeln soll, wie mit **wm transient** angegeben,]{version="8.6"}

        [**dropdown\_menu**]{version="8.6"}
        : [kennzeichnet ein aus einer Menüleiste aufgerufenes Menü, das üblicherweise auch override-redirected gesetzt sein sollte (mit **wm overrideredirect**),]{version="8.6"}

        [**popup\_menu**]{version="8.6"}
        : [kennzeichnet ein Popup-Menü, das üblicherweise auch override-redirected gesetzt sein sollte (mit **wm overrideredirect**),]{version="8.6"}

        [**tooltip**]{version="8.6"}
        : [kennzeichnet ein Tooltip-Fenster, das üblicherweise auch override-redirected gesetzt sein sollte (mit **wm overrideredirect**),]{version="8.6"}

        [**notification**]{version="8.6"}
        : [kennzeichnet ein Fenster mit Hintergrundbenachrichtigung über ein Ereignis, das üblicherweise auch override-redirected gesetzt sein sollte (mit **wm overrideredirect**),]{version="8.6"}

        [**combo**]{version="8.6"}
        : [kennzeichnet die Dropdown-Liste eines Combobox-Widgets, die üblicherweise auch override-redirected gesetzt sein sollte (mit **wm overrideredirect**),]{version="8.6"}

        [**dnd**]{version="8.6"}
        : [kennzeichnet ein Fenster, das etwas Ziehbares darstellt, das üblicherweise auch override-redirected gesetzt sein sollte (mit **wm overrideredirect**),]{version="8.6"}

        [**normal**]{version="8.6"}
        : [kennzeichnet ein Fenster ohne besondere Interpretation.]{version="8.6"}


    [-zoomed]{.lit}
    : Fordert an, dass das Fenster maximiert wird. Entspricht unter Windows und macOS **wm state zoomed**.


    Unter X11 werden Änderungen an Fensterattributen asynchron ausgeführt. Das Abfragen eines Attributwerts liefert den aktuellen Zustand, der nicht mit dem zuletzt gesetzten Wert übereinstimmen muss, wenn der Fenstermanager die Anfrage noch nicht verarbeitet hat oder das Attribut nicht unterstützt.

[wm]{.cmd} [client]{.sub} [window]{.arg} [name]{.optarg}
: Wenn *name* angegeben ist, speichert dieser Befehl *name* (der Name des Rechners, auf dem die Anwendung läuft) in der **WM\_CLIENT\_MACHINE**-Eigenschaft von *window* für den Fenstermanager oder Sitzungsmanager und gibt in diesem Fall einen leeren String zurück. Wenn *name* nicht angegeben ist, gibt der Befehl den zuletzt in einem **wm client**-Befehl für *window* gesetzten Namen zurück. Wenn *name* als leerer String angegeben wird, löscht der Befehl die **WM\_CLIENT\_MACHINE**-Eigenschaft von *window*.

[wm]{.cmd} [colormapwindows]{.sub} [window]{.arg} [windowList]{.optarg}
: Dieser Befehl manipuliert die **WM\_COLORMAP\_WINDOWS**-Eigenschaft, die Fenstermanagern Informationen über Fenster mit privaten Farbtabellen liefert.

    Wenn *windowList* nicht angegeben ist, gibt der Befehl eine Liste zurück, deren Elemente die Namen der Fenster in der **WM\_COLORMAP\_WINDOWS**-Eigenschaft sind. Wenn *windowList* angegeben ist, besteht sie aus einer Liste von Fensterpfadnamen; der Befehl überschreibt die **WM\_COLORMAP\_WINDOWS**-Eigenschaft mit den angegebenen Fenstern und gibt einen leeren String zurück. Die **WM\_COLORMAP\_WINDOWS**-Eigenschaft sollte normalerweise eine Liste der internen Fenster innerhalb von *window* enthalten, deren Farbtabellen sich von denen ihrer Eltern unterscheiden.

    Die Reihenfolge der Fenster in der Eigenschaft gibt eine Prioritätsreihenfolge an: Der Fenstermanager versucht, so viele Farbtabellen wie möglich vom Anfang dieser Liste zu installieren, wenn *window* den Colormap-Fokus erhält. Wenn *window* nicht in *windowList* enthalten ist, fügt Tk es implizit am Ende der **WM\_COLORMAP\_WINDOWS**-Eigenschaft hinzu, sodass seine Farbtabelle die niedrigste Priorität hat. Wenn **wm colormapwindows** nicht aufgerufen wird, setzt Tk die Eigenschaft für jedes Toplevel-Fenster automatisch auf alle internen Fenster, deren Farbtabellen sich von denen ihrer Eltern unterscheiden, gefolgt vom Toplevel-Fenster selbst; die Reihenfolge der internen Fenster ist undefiniert. Siehe die ICCCM-Dokumentation zur **WM\_COLORMAP\_WINDOWS**-Eigenschaft.

[wm]{.cmd} [command]{.sub} [window]{.arg} [value]{.optarg}
: Wenn *value* angegeben ist, speichert dieser Befehl *value* in der **WM\_COMMAND**-Eigenschaft von *window* für den Fenstermanager oder Sitzungsmanager und gibt einen leeren String zurück. *Value* muss eine gültige Listenstruktur haben; die Elemente sollten die Wörter des Befehls enthalten, mit dem die Anwendung gestartet wurde. Wenn *value* nicht angegeben ist, gibt der Befehl den zuletzt in einem **wm command**-Befehl für *window* gesetzten Wert zurück. Wenn *value* als leerer String angegeben wird, löscht der Befehl die **WM\_COMMAND**-Eigenschaft von *window*.

[wm]{.cmd} [deiconify]{.sub} [window]{.arg}
: Sorgt dafür, dass *window* in normaler (nicht iconifizierter) Form angezeigt wird. Dies geschieht durch das Mapping des Fensters. Wenn das Fenster noch nie gemappt wurde, mappt dieser Befehl das Fenster nicht, stellt aber sicher, dass es beim ersten Mapping de-iconifiziert angezeigt wird. Unter Windows wird ein de-iconifiziertes Fenster außerdem in den Vordergrund geholt und erhält den Fokus (wird zum aktiven Fenster). Gibt einen leeren String zurück.

[wm]{.cmd} [focusmodel]{.sub} [window]{.arg} [active|passive]{.optlit}
: Wenn **active** oder **passive** als optionales Argument übergeben wird, legt es das Fokusmodell für *window* fest; der Befehl gibt dann einen leeren String zurück. Wenn kein weiteres Argument übergeben wird, gibt der Befehl das aktuelle Fokusmodell für *window* zurück.

    Ein **active**-Fokusmodell bedeutet, dass *window* den Eingabefokus für sich oder seine Nachkommen beansprucht, auch wenn der Fokus gerade in einer anderen Anwendung liegt. **Passive** bedeutet, dass *window* den Fokus nie für sich beansprucht: Der Fenstermanager soll *window* zu passenden Zeiten den Fokus geben. Sobald der Fokus *window* oder einem seiner Nachkommen gegeben wurde, kann die Anwendung den Fokus unter den Nachkommen von *window* neu zuweisen. Das Fokusmodell ist standardmäßig **passive**; Tks [focus]-Befehl setzt ein passives Fokusmodell voraus.

[wm]{.cmd} [forget]{.sub} [window]{.arg}
: *window* wird vom Bildschirm unmappt und nicht mehr von **wm** verwaltet. Mit dem [toplevel]-Befehl erstellte Fenster werden wie [frame]-Fenster behandelt, sobald sie nicht mehr von **wm** verwaltet werden; die **-menu**-Konfiguration wird jedoch gemerkt, und die Menüs kehren zurück, sobald das Widget wieder verwaltet wird.

[wm]{.cmd} [frame]{.sub} [window]{.arg}
: Wenn *window* vom Fenstermanager in einen dekorativen Rahmen umgeparentet wurde, gibt der Befehl die plattformspezifische Fensterkennung des äußersten Rahmens zurück, der *window* enthält (das Fenster, dessen Eltern das Root- oder virtuelle Root-Fenster ist). Wenn *window* nicht umgeparentet wurde, gibt der Befehl die plattformspezifische Fensterkennung für *window* zurück.

[wm]{.cmd} [geometry]{.sub} [window]{.arg} [newGeometry]{.optarg}
: Wenn *newGeometry* angegeben ist, wird die Geometrie von *window* geändert und ein leerer String zurückgegeben. Andernfalls wird die aktuelle Geometrie von *window* zurückgegeben (die zuletzt durch manuelles Skalieren oder einen **wm geometry**-Befehl gesetzte Geometrie). *NewGeometry* hat die Form **=***width***x***height***±***x***±***y*; **=**, *width***x***height* oder **±***x***±***y* können weggelassen werden. *Width* und *height* sind positive Ganzzahlen für die gewünschten Abmessungen von *window*. Ist *window* gitterbasiert (siehe [Gitterbasierte Geometrieverwaltung] unten), sind die Abmessungen in Gittereinheiten angegeben; sonst in Pixeln.

    *X* und *y* legen die gewünschte Position von *window* auf dem Bildschirm in Pixeln fest. Steht *x* vor **+**, ist es der Abstand zwischen dem linken Bildschirmrand und dem linken Rand von *window*; bei **-** der Abstand zwischen dem rechten Bildschirmrand und dem rechten Rand von *window*. Steht *y* vor **+**, ist es der Abstand zwischen dem oberen Bildschirmrand und dem oberen Rand von *window*; bei **-** der Abstand zwischen dem unteren Rand von *window* und dem unteren Bildschirmrand.

    Wird *newGeometry* als leerer String angegeben, werden benutzerdefinierte Geometrie-Vorgaben für *window* aufgehoben; das Fenster kehrt zur intern von seinen Widgets angeforderten Größe zurück.

    Beachten Sie den Zusammenhang mit [winfo geometry][winfo], der aber nicht identisch ist: **winfo geometry** kann nur abfragen und spiegelt stets Tks aktuelles Verständnis der tatsächlichen Größe und Position von *window* wider, während **wm geometry** sowohl setzen als auch die *Fenstermanager*-Sicht auf Größe und Position abfragen kann. Das kann deutlich abweichen, z. B. durch Titelleisten; Fenstermanager müssen Anfragen über diesen Befehl nicht exakt befolgen.

[wm]{.cmd} [grid]{.sub} [window]{.arg} [baseWidth baseHeight widthInc heightInc]{.optarg}
: Dieser Befehl legt fest, dass *window* als gitterbasiertes Fenster verwaltet wird, und gibt das Verhältnis zwischen Gitter- und Pixeleinheiten an. *BaseWidth* und *baseHeight* sind die Gittereinheiten, die den intern per [Tk\_GeometryRequest][GeomReq] angeforderten Pixelabmessungen von *window* entsprechen. *WidthInc* und *heightInc* sind die Pixel pro horizontaler bzw. vertikaler Gittereinheit. Diese vier Werte bestimmen einen zulässigen Größenbereich für *window* (nicht-negative ganzzahlige Gitterbreiten und -höhen). Tk übergibt diese Information an den Fenstermanager; beim manuellen Skalieren beschränkt der Fenstermanager die Größe auf zulässige Werte.

    Beim manuellen Skalieren zeigt der Fenstermanager die aktuelle Größe in Gittereinheiten statt in Pixeln. Wenn *baseWidth* usw. alle als leere Strings angegeben sind, wird *window* nicht mehr gitterbasiert verwaltet. Wenn *baseWidth* usw. angegeben sind, ist der Rückgabewert ein leerer String.

    Andernfalls ist der Rückgabewert eine Tcl-Liste mit vier Elementen für die aktuellen *baseWidth*, *baseHeight*, *widthInc* und *heightInc*; ist *window* derzeit nicht gitterbasiert, ein leerer String.

    Dieser Befehl wird selten benötigt, da [Tk\_SetGrid][SetGrid] und die **setGrid**-Option einfacheren Zugang bieten.

[wm]{.cmd} [group]{.sub} [window]{.arg} [pathName]{.optarg}
: Wenn *pathName* angegeben ist, ist es der Pfadname des Leaders einer Gruppe verwandter Fenster. Der Fenstermanager kann diese Information nutzen, z. B. um alle Fenster einer Gruppe zu unmapen, wenn der Leader iconifiziert wird. *PathName* kann als leerer String angegeben werden, um *window* aus jeder Gruppenzuordnung zu entfernen. Wenn *pathName* angegeben ist, gibt der Befehl einen leeren String zurück; sonst den Pfadnamen des aktuellen Gruppenleaders von *window* oder einen leeren String, wenn *window* zu keiner Gruppe gehört.

[wm]{.cmd} [iconbadge]{.sub} [window]{.arg} [badge]{.arg}
: Setzt ein Badge für das Icon von *window*. Das Badge kann eine positive Ganzzahl sein, z. B. die Anzahl neuer oder ungelesener Nachrichten, oder ein Ausrufezeichen für erforderliche Aufmerksamkeit. Ist das Badge ein leerer String, wird das Badge-Bild vom Anwendungsicon entfernt. Die Verwaltung solcher Änderungen über Bindings wie <FocusIn> liegt beim Entwickler.

    Unter X11 muss für diesen Befehl die Variable **::tk::icons::base\_icon($window)** auf das Bild gesetzt sein, das als Fenstericon von $window verwendet wird. Unter Windows und X11 funktionieren iconphoto-Bilder am besten bei 32×32 oder ähnlichen Abmessungen, da Tk die Badge-Bilder bereitstellt und per nativer API (Windows) oder Tk-Rendering über die Icons legt. Unter macOS rendert das System-API das Icon-Badge; Tk stellt es nicht bereit. Das Icon selbst sollte höher aufgelöst sein, vorzugsweise 512 Pixel, um Unschärfe zu vermeiden.

    Das Icon-Badge ist für Dock (macOS), Taskleiste (Windows) oder App-Panel (X11) gedacht. Unter macOS wird das zuletzt gesetzte Badge im Dock angezeigt, unabhängig davon, wie viele verschiedene Icon-Badges verschiedenen Fenstern zugewiesen sind. Unter Windows hängt die Taskleistenanzeige davon ab, ob Taskleisten-Schaltflächen kombiniert sind (OS-Einstellung): kombiniert wie unter macOS, sonst zeigt jede Schaltfläche ihr zugewiesenes Badge. Die Badge-Anzeige unter macOS wird in den Systemeinstellungen konfiguriert. Unter X11 hängt das Verhalten vom Fenstermanager und/oder der Desktop-Umgebung ab.

[wm]{.cmd} [iconbitmap]{.sub} [window]{.arg} [bitmap]{.optarg}
: Wenn *bitmap* angegeben ist, benennt es ein Bitmap in den von Tk akzeptierten Standardformen (siehe [Tk\_GetBitmap][GetBitmap]). Dieses Bitmap wird dem Fenstermanager für das Icon von *window* übergeben; der Befehl gibt einen leeren String zurück. Bei leerem *bitmap* wird ein bestehendes Icon-Bitmap für *window* aufgehoben. Wenn *bitmap* angegeben ist, gibt der Befehl einen leeren String zurück; sonst den Namen des aktuellen Icon-Bitmaps von *window* oder einen leeren String, wenn keines gesetzt ist. Unter Windows wird zusätzlich unterstützt:

    [wm]{.cmd} [iconbitmap]{.sub} [window]{.arg} [-default]{.optlit} [image]{.optarg}
    : Mit dem Flag **-default** gilt das Icon für alle Toplevel-Fenster (bestehende und künftige), denen noch kein anderes spezifisches Icon zugewiesen wurde. Neben Bitmap-Typen wird auch ein vollständiger Pfad zu einer Datei mit gültigem Windows-Icon akzeptiert (üblicherweise .ico oder .icr) oder zu einer Datei, der die Shell ein Icon zugewiesen hat. Tcl prüft zuerst, ob die Datei ein Icon enthält, dann ob ein Icon zugewiesen ist, und schließlich, ob es ein Bitmap ist.


[wm]{.cmd} [iconify]{.sub} [window]{.arg}
: Sorgt dafür, dass *window* iconifiziert wird. Wenn *window* noch nie zum ersten Mal gemappt wurde, wird es beim späteren Mapping im iconifizierten Zustand erscheinen.

[wm]{.cmd} [iconmask]{.sub} [window]{.arg} [bitmap]{.optarg}
: Wenn *bitmap* angegeben ist, benennt es ein Bitmap in den von Tk akzeptierten Standardformen (siehe [Tk\_GetBitmap][GetBitmap]). Dieses Bitmap wird dem Fenstermanager als Maske zur **iconbitmap**-Option übergeben: wo die Maske Nullen hat, wird kein Icon angezeigt; wo Einsen, die Bits des Icon-Bitmaps. Bei leerem *bitmap* wird eine bestehende Icon-Maske für *window* aufgehoben (entspricht einem Bitmap aus lauter Einsen). Wenn *bitmap* angegeben ist, gibt der Befehl einen leeren String zurück; sonst den Namen der aktuellen Icon-Maske von *window* oder einen leeren String, wenn keine Maske gilt.

[wm]{.cmd} [iconname]{.sub} [window]{.arg} [newName]{.optarg}
: Wenn *newName* angegeben ist, wird es an den Fenstermanager übergeben; der Fenstermanager soll *newName* im mit *window* verknüpften Icon anzeigen. In diesem Fall ist das Ergebnis ein leerer String. Wenn *newName* nicht angegeben ist, gibt der Befehl den aktuellen Icon-Namen von *window* zurück oder einen leeren String, wenn keiner gesetzt wurde (dann zeigt der Fenstermanager üblicherweise den mit **wm title** gesetzten Fenstertitel).

[wm]{.cmd} [iconphoto]{.sub} [window]{.arg} [-default]{.optlit} [image1]{.arg} [image2]{.optdot}
: Setzt das Titelleisten-Icon für *window* anhand der genannten Foto-Images. Mit **-default** gilt dies auch für alle künftig erstellten Toplevel-Fenster. Die Bilddaten werden zum Zeitpunkt des Aufrufs als Momentaufnahme genommen; spätere Änderungen an den Images wirken sich nicht auf die Titelleisten-Icons aus. Mehrere Images erlauben verschiedene Größen (z. B. 16×16 und 32×32). Der Fenstermanager kann Icons auf eine passende Größe skalieren.

    Unter Windows werden die Images in eine Windows-Icon-Struktur gepackt. Das überschreibt ein per **wm iconbitmap** gesetztes .ico und umgekehrt. Dieser Befehl setzt auch das Taskleisten-Icon des Fensters.

    Unter X werden die Images in die X-Eigenschaft \_NET\_WM\_ICON gelegt, die die meisten modernen Fenstermanager unterstützen. Ein **wm iconbitmap** kann gleichzeitig existieren. Es wird empfohlen, nicht mehr als zwei Icons zu verwenden und das größere zuerst anzugeben. Dieser Befehl setzt auch das Panel-Icon der Anwendung, wenn der Fenstermanager oder die Desktop-Umgebung das unterstützt.

    Unter Macintosh wird das erste aufgerufene Image in ein natives OS-Icon-Format geladen und wird Anwendungsicon in Dialogen, im Dock und in anderen Kontexten. Auf Skriptebene akzeptiert der Befehl nur das erste übergebene Image, da Mehrfachgrößen/-auflösungen unter macOS außerhalb des Tk-Bereichs liegen. Entwickler sollten das größtmögliche unterstützte Icon verwenden (vorzugsweise 512 Pixel).

[wm]{.cmd} [iconposition]{.sub} [window]{.arg} [x y]{.optarg}
: Wenn *x* und *y* angegeben sind, werden sie dem Fenstermanager als Hinweis für die Icon-Position von *window* übergeben; der Befehl gibt einen leeren String zurück. Als leere Strings werden bestehende Icon-Positionshinweise aufgehoben. Wenn weder *x* noch *y* angegeben sind, gibt der Befehl eine Tcl-Liste mit zwei Werten zurück (aktuelle Icon-Positionshinweise; ohne Hinweise ein leerer String).

[wm]{.cmd} [iconwindow]{.sub} [window]{.arg} [pathName]{.optarg}
: Wenn *pathName* angegeben ist, ist es der Pfadname eines Fensters, das als Icon für *window* dient: bei Iconifizierung von *window* wird *pathName* gemappt; bei De-Iconifizierung wieder unmappt. Als leerer String wird eine bestehende Icon-Fenster-Zuordnung für *window* aufgehoben. Wenn *pathName* angegeben ist, gibt der Befehl einen leeren String zurück; sonst den Pfadnamen des aktuellen Icon-Fensters von *window* oder einen leeren String. Button-Press-Ereignisse sind für *window* deaktiviert, solange es ein Icon-Fenster ist, damit Fenstermanager diese Ereignisse „besitzen“ können. Nicht alle Fenstermanager unterstützen Icon-Fenster; auf Nicht-X11-Plattformen ist das Konzept bedeutungslos.

[wm]{.cmd} [manage]{.sub} [widget]{.arg}
: Das angegebene *widget* wird ein eigenständiges Toplevel-Fenster. Es wird mit Titelleiste usw. des Fenstermanagers dekoriert. Nur *frame*-, *labelframe*- und *toplevel*-Widgets sind zulässig; andere Widget-Typen lösen einen Fehler aus. Ein *toplevel*-Widget zu verwalten ist harmlos und bewirkt nichts. Siehe auch [Geometrieverwaltung].

[wm]{.cmd} [maxsize]{.sub} [window]{.arg} [width height]{.optarg}
: Wenn *width* und *height* angegeben sind, legen sie die maximal zulässigen Abmessungen von *window* fest. Bei gitterbasierten Fenstern in Gittereinheiten, sonst in Pixeln. Der Fenstermanager beschränkt die Abmessungen auf höchstens *width* und *height*. Bei Angabe gibt der Befehl einen leeren String zurück; sonst eine Tcl-Liste mit den aktuell geltenden Maximalbreite und -höhe. Standard ist die Bildschirmgröße. Siehe die Abschnitte zur Geometrieverwaltung unten.

[wm]{.cmd} [minsize]{.sub} [window]{.arg} [width height]{.optarg}
: Wenn *width* und *height* angegeben sind, legen sie die minimal zulässigen Abmessungen von *window* fest. Bei gitterbasierten Fenstern in Gittereinheiten, sonst in Pixeln. Der Fenstermanager beschränkt die Abmessungen auf mindestens *width* und *height*. Bei Angabe gibt der Befehl einen leeren String zurück; sonst eine Tcl-Liste mit Minimalbreite und -höhe. Standard ist ein Pixel pro Dimension. Siehe die Abschnitte zur Geometrieverwaltung unten.

[wm]{.cmd} [overrideredirect]{.sub} [window]{.arg} [boolean]{.optarg}
: Wenn *boolean* angegeben ist, muss es eine gültige boolesche Form haben; das Override-Redirect-Flag von *window* wird gesetzt. Ohne *boolean* wird **1** oder **0** zurückgegeben. Das Setzen des Override-Redirect-Flags bewirkt, dass der Fenstermanager das Fenster ignoriert; u. a. wird es nicht vom Root-Fenster in einen dekorativen Rahmen umgeparentet, und der Benutzer kann es nicht mit den üblichen Fenstermanager-Mechanismen manipulieren.

    Der Fenstermanager gibt einem solchen Fenster auch nicht den Tastaturfokus. Unter X11 muss eine Anwendung, die darin Tastenereignisse braucht, den Fokus mit [focus -force][focus] anfordern.

    Das Override-Redirect-Flag wird garantiert beim ersten Mapping oder beim Mapping nach Wechsel von withdrawn zu normal beachtet. Einige, aber nicht alle Plattformen beachten es auch zu anderen Zeiten.

[wm]{.cmd} [positionfrom]{.sub} [window]{.arg} [who]{.optarg}
: Wenn *who* angegeben ist, muss es **program** oder **user** sein (oder eine Abkürzung). Es gibt an, ob die aktuelle Position von *window* vom Programm oder vom Benutzer angefordert wurde. Viele Fenstermanager ignorieren programmgesteuerte Anfangspositionen; bei **user** soll der Fenstermanager das Fenster an der angegebenen Stelle platzieren, ohne den Benutzer zu fragen. Als leerer String wird die aktuelle Positionsquelle aufgehoben. Bei Angabe von *who* gibt der Befehl einen leeren String zurück; sonst **user** oder **program** oder einen leeren String, wenn noch keine Quelle gesetzt wurde. Die meisten Fenstermanager werten „keine Quelle“ wie **program**. Tk setzt die Positionsquelle beim Aufruf von **wm geometry** automatisch auf **user**, sofern sie nicht explizit **program** ist.

[wm]{.cmd} [protocol]{.sub} [window]{.arg} [name]{.optarg} [command]{.optarg}
: Dieser Befehl verwaltet Fenstermanager-Protokolle. Das *name*-Argument in **wm protocol** ist der Name eines Atoms, das einem Fenstermanager-Protokoll entspricht. Beispiele: **WM\_DELETE\_WINDOW**, **WM\_SAVE\_YOURSELF** oder **WM\_TAKE\_FOCUS**.

    Ein *Fenstermanager-Protokoll* ist eine Klasse von Nachrichten vom Fenstermanager an eine Tk-Anwendung außerhalb des normalen Ereignisverarbeitungssystems. Das Hauptbeispiel ist **WM\_DELETE\_WINDOW**; diese Nachrichten werden gesendet, wenn der Benutzer das Schließen-Widget in der Titelleiste anklickt. Handler werden mit **wm protocol** installiert. Regelmäßig werden alle Nachrichten eines Protokolls ignoriert, wenn kein Handler per **wm protocol** installiert wurde. **WM\_DELETE\_WINDOW** ist eine Ausnahme: Beim Start installiert Tk einen Handler, der das Fenster zerstört. **wm protocol** kann diesen Standard-Handler ersetzen.

    Die verfügbaren Protokolle hängen vom Fenstermanager ab; alle von Tk unterstützten Fenstermanager bieten **WM\_DELETE\_WINDOW**. Unter Windows wird bei Abmeldung oder Neustart **WM\_SAVE\_YOURSELF** gesendet.

    Wenn *name* und *command* angegeben sind, wird *command* zum Handler für das Protokoll *name*. Das Atom für *name* wird der **WM\_PROTOCOLS**-Eigenschaft von *window* hinzugefügt; *command* wird aufgerufen, wenn der Fenstermanager eine Nachricht dieses Protokolls sendet. **wm protocol** gibt dann einen leeren String zurück. Wenn nur *name* angegeben ist, wird der aktuelle Handler für *name* zurückgegeben oder ein leerer String (der Standard-Handler für **WM\_DELETE\_WINDOW** wird nicht zurückgegeben). Ist *command* ein leerer String, wird das Atom für *name* aus **WM\_PROTOCOLS** entfernt und der Handler zerstört; Rückgabe leerer String. Wenn weder *name* noch *command* angegeben sind, gibt **wm protocol** eine Liste aller Protokolle zurück, für die Handler für *window* definiert sind.

[wm]{.cmd} [resizable]{.sub} [window]{.arg} [width height]{.optarg}
: Dieser Befehl steuert, ob der Benutzer ein Toplevel-Fenster interaktiv skalieren darf. Wenn *width* und *height* angegeben sind, sind es boolesche Werte, ob Breite und Höhe von *window* geändert werden dürfen; der Befehl gibt einen leeren String zurück. Ohne *width* und *height* eine Liste mit zwei 0/1-Elementen. Standardmäßig sind Fenster in beiden Dimensionen skalierbar. Ist Skalierung deaktiviert, gilt die Größe der letzten interaktiven Skalierung oder des letzten **wm geometry**-Befehls; sonst die natürliche Größe.

[wm]{.cmd} [sizefrom]{.sub} [window]{.arg} [who]{.optarg}
: Wenn *who* angegeben ist, muss es **program** oder **user** sein (oder eine Abkürzung). Es gibt an, ob die aktuelle Größe von *window* vom Programm oder vom Benutzer angefordert wurde. Einige Fenstermanager ignorieren programmgesteuerte Größen; bei **user** soll der Fenstermanager die angegebene Größe setzen, ohne den Benutzer zu fragen. Als leerer String wird die aktuelle Größenquelle aufgehoben. Bei Angabe von *who* gibt der Befehl einen leeren String zurück; sonst **user** oder **window** oder einen leeren String. Die meisten Fenstermanager werten „keine Quelle“ wie **program**.

[wm]{.cmd} [stackorder]{.sub} [window]{.arg} [[isabove|isbelow]{.lit} [window]{.arg}]{.optarg}
: Der **stackorder**-Befehl gibt eine Liste von Toplevel-Fenstern in Stapelreihenfolge zurück, von unten nach oben. Bei einem einzelnen Toplevel-Fenster enthält die Liste rekursiv alle Toplevel-Nachkommen des Fensters. Nur derzeit auf dem Bildschirm gemappte Toplevels werden zurückgegeben. Mit zwei Fensterargumenten, getrennt durch **isabove** oder **isbelow**, liefert ein boolesches Ergebnis, ob das erste Fenster über oder unter dem zweiten in der Stapelreihenfolge liegt.

[wm]{.cmd} [state]{.sub} [window]{.arg} [newstate]{.optarg}
: Wenn *newstate* angegeben ist, wird das Fenster in den neuen Zustand versetzt; sonst gibt der Befehl den aktuellen Zustand von *window* zurück: **normal**, **iconic**, **withdrawn**, **icon** oder (nur Windows und macOS) **zoomed**. Der Unterschied zwischen **iconic** und **icon**: **iconic** bezeichnet ein iconifiziertes Fenster (z. B. per **wm iconify**), **icon** ein Fenster, das nur als Icon für ein anderes dient (per **wm iconwindow**). Der Zustand **icon** kann nicht gesetzt werden.

[wm]{.cmd} [title]{.sub} [window]{.arg} [string]{.optarg}
: Wenn *string* angegeben ist, wird er dem Fenstermanager als Titel für *window* übergeben (Anzeige in der Titelleiste). Der Befehl gibt einen leeren String zurück. Ohne *string* gibt er den aktuellen Titel von *window* zurück. Standard ist der Name des Fensters.

[wm]{.cmd} [transient]{.sub} [window]{.arg} [container]{.optarg}
: Wenn *container* angegeben ist, wird der Fenstermanager informiert, dass *window* ein transientes Fenster ist (z. B. Pull-down-Menü), das im Auftrag von *container* arbeitet (*container* ist der Pfadname eines Toplevel-Fensters). Als leerer String wird *window* nicht mehr als transient markiert. Sonst gibt der Befehl den Pfadnamen des aktuellen Containers von *window* zurück oder einen leeren String. Ein transientes Fenster spiegelt Zustandsänderungen des Containers und erbt beim ersten Mapping dessen Zustand. Der gerichtete Graph mit einer Kante von jedem Transienten zu seinem Container muss azyklisch sein; ein Fenster darf nicht transient von sich selbst sein. Der Fenstermanager kann transiente Fenster anders dekorieren (z. B. ohne Minimieren/Maximieren), nach eigenem Ermessen.

[wm]{.cmd} [withdraw]{.sub} [window]{.arg}
: Sorgt dafür, dass *window* vom Bildschirm zurückgezogen wird. Das Fenster wird unmappt und vom Fenstermanager nicht mehr berücksichtigt. Wenn es noch nie gemappt wurde, wird es im withdrawn-Zustand gemappt. Nicht alle Fenstermanager scheinen zu wissen, wie mit Fenstern umzugehen ist, die im withdrawn-Zustand gemappt sind. Manchmal muss ein Fenster zurückgezogen und neu gemappt werden (z. B. mit **wm deiconify**), damit Fenstermanager auf Änderungen an Fensterattributen wie **group** reagieren.


# Geometrieverwaltung

Standardmäßig erscheint ein Toplevel-Fenster in seiner *natürlichen Größe*, die intern von seinen Widgets und Geometriemanagern bestimmt wird. Ändert sich die natürliche Größe, passt sich die Fenstergröße an. Eine andere Größe ist auf zwei Wegen möglich: der Benutzer skaliert manuell (z. B. Griffe des Fenstermanagers) oder die Anwendung fordert eine Größe per **wm geometry** an. Tk behandelt beide Fälle gleich; die angeforderte Größe setzt die natürliche Größe außer Kraft. Zurück zur natürlichen Größe: **wm geometry** mit leerer *geometry*-Zeichenkette.

Normalerweise kann ein Toplevel-Fenster von einem Pixel pro Dimension bis zur Bildschirmgröße skaliert werden. Mit **wm minsize** und **wm maxsize** lässt sich der zulässige Bereich begrenzen. Der Bereich gilt für alle Skalierungsarten, einschließlich natürlicher Größe, manueller Skalierung und **wm geometry**. Jeder von [Tk\_GetPixels][GetPixels] akzeptierte Wert ist möglich. Mit **wm resizable** kann interaktive Skalierung in einer oder beiden Dimensionen vollständig deaktiviert werden.

Die Befehle **wm manage** und **wm forget** können zum Abdocken und Andocken von Fenstern verwendet werden. Nach **wm manage** können alle anderen **wm**-Unterbefehle mit dem Widget verwendet werden. Nur mit dem toplevel-Befehl erstellte Widgets können ein Menü über die **-menu**-Konfigurationsoption haben. Ein Toplevel-Widget kann nach **wm forget** wie ein Frame mit anderen Geometriemanagern verwaltet werden. Ein mit einem Toplevel verknüpftes Menü wird verborgen, wenn ein anderer Geometriemanager verwendet wird; es erscheint wieder, sobald das Fenster von **wm** verwaltet wird. Alle angepassten bindtags für Widgets in einem Teilbaum, deren Toplevel per **wm manage** oder **wm forget** geändert wurde, müssen neu gesetzt werden, um Toplevel-Pfade in den bindtags anzupassen. Nicht angepasste bindtags müssen nicht neu gesetzt werden.

# Gitterbasierte Geometrieverwaltung

Gitterbasierte Geometrieverwaltung tritt auf, wenn ein Widget der Anwendung einen Bereich sinnvoller Größen unterstützt, z. B. in einem Texteditor mit festen Scrollleisten und Menüs, während das Bearbeitungs-Widget beliebig viele Zeilen oder Zeichen pro Zeile erlaubt. Dann soll der Benutzer Zeilen- oder Zeichen-pro-Zeile-Anzahl per **wm geometry** oder interaktiver Skalierung wählen können. Oft sind nur diskrete Fenstergrößen sinnvoll (ganzzahlige Zeilen und Zeichen pro Zeile); beliebige Pixelgrößen sind nicht nützlich.

Gitterbasierte Geometrieverwaltung unterstützt solche Anwendungen. Tk (und der Fenstermanager) gehen von einem Gitter in der Anwendung aus und skalieren in *Gittereinheiten* statt in Pixeln. Typischerweise durch Einschalten der **setGrid**-Option eines Widgets; auch per **wm grid** oder [Tk\_SetGrid][SetGrid]. Das Widget (oder Anwendungscode) legt das Verhältnis zwischen ganzzahligen Gittergrößen und Pixeln fest. Zurück zur nicht gitterbasierten Geometrieverwaltung: **wm grid** mit leeren Argumentstrings.

Ist gitterbasierte Geometrieverwaltung aktiv, gelten alle in **wm minsize**, **wm maxsize** und **wm geometry** angegebenen Abmessungen als Gittereinheiten. Interaktive Skalierung erfolgt in geraden Vielfachen von Gittereinheiten.

# Fehler

Die meisten bestehenden Fenstermanager scheinen Fehler zu haben, die den **wm**-Befehl betreffen. Einige Änderungen wirken nicht, wenn das Fenster bereits aktiv ist: Das Fenster muss zurückgezogen und de-iconifiziert werden, damit die Änderung greift.

# Beispiele

Ein Fenster fester Größe, das dies auch angibt:

```
toplevel .fixed
wm title     .fixed "Fixed-size Window"
wm resizable .fixed 0 0
```

Ein einfaches dialogähnliches Fenster, zentriert auf dem Bildschirm:

```
# Dialoginhalt erstellen und anordnen.
toplevel .msg
label  .msg.l  -text "This is a very simple dialog demo."
button .msg.ok -text OK -default active -command {destroy .msg}
pack .msg.ok -side bottom -fill x
pack .msg.l  -expand 1    -fill both

# Widget als zentrierten Dialog einrichten.

# Zuerst müssen die Geometriemanager den Dialog-Innenraum
# fertig einrichten; dazu die Ereignisschleife laufen lassen,
# während das Widget vollständig verborgen ist...
wm withdraw .msg
update
set x [expr {([winfo screenwidth .] - [winfo width .msg]) / 2}]
set y [expr {([winfo screenheight .] - [winfo height .msg]) / 2}]
wm geometry  .msg +$x+$y
wm transient .msg .
wm title     .msg "Dialog demo"
wm deiconify .msg
```


[focus]: focus.md
[frame]: frame.md
[GeomReq]: ../tk-c/GeomReq.md
[GetBitmap]: ../tk-c/GetBitmap.md
[GetColor]: ../tk-c/GetColor.md
[GetPixels]: ../tk-c/GetPixels.md
[SetGrid]: ../tk-c/SetGrid.md
[toplevel]: toplevel.md
[winfo]: winfo.md
