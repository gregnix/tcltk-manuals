---
CommandName: msgcat
title: msgcat
ManualSection: n
Version: 1.5
TclPart: msgcat
TclDescription: Tcl Bundled Packages
Links:
 - format(n)
 - scan(n)
 - namespace(n)
 - package(n)
 - oo::class(n)
 - oo::object
Keywords:
 - internationalization
 - i18n
 - localization
 - l10n
 - message
 - text
 - translation
 - class
 - object
Copyright:
 - Copyright (c) 1998 Mark Harrison.
---

# Name

msgcat - Tcl-Message-Katalog

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl]{.lit} [9.0]{.lit}
[package]{.cmd} [require]{.sub} [msgcat]{.lit} [1.7]{.lit}

[::msgcat::mc]{.cmd} [src-string]{.arg} [arg arg]{.optdot}
[::msgcat::mcmax]{.cmd} [src-string src-string]{.optdot}
[::msgcat::mcexists]{.cmd} [-exactnamespace]{.optlit} [-exactlocale]{.optlit} [src-string]{.arg}
[::msgcat::mcpackagenamespaceget]{.cmd version="TIP490"}
[::msgcat::mclocale]{.cmd} [newLocale]{.optarg}
[::msgcat::mcpreferences]{.cmd version="TIP499"} [locale preference]{.optarg} ...
[::msgcat::mcloadedlocales]{.cmd} [subcommand]{.sub}
[::msgcat::mcload]{.cmd} [dirname]{.arg}
[::msgcat::mcset]{.cmd} [locale]{.arg} [src-string]{.arg} [translate-string]{.optarg}
[::msgcat::mcmset]{.cmd} [locale]{.arg} [src-trans-list]{.arg}
[::msgcat::mcflset]{.cmd} [src-string]{.arg} [translate-string]{.optarg}
[::msgcat::mcflmset]{.cmd} [src-trans-list]{.arg}
[::msgcat::mcunknown]{.cmd} [locale]{.arg} [src-string]{.arg} [arg arg]{.optdot}
[::msgcat::mcpackagelocale]{.cmd} [subcommand]{.sub} [locale]{.optarg}
[::msgcat::mcpackageconfig]{.cmd} [subcommand]{.sub} [option]{.arg} [value]{.optarg}
[::msgcat::mcforgetpackage]{.cmd}
[::msgcat::mcutil]{.cmd version="TIP499"} [subcommand]{.sub} [locale]{.optarg}
:::

# Beschreibung

Das Paket **msgcat** stellt eine Reihe von Funktionen bereit, mit denen mehrsprachige Benutzeroberflächen verwaltet werden können. Textzeichenketten werden in einem Message-Katalog definiert, der unabhängig von der Anwendung ist und bearbeitet oder lokalisiert werden kann, ohne den Anwendungsquellcode zu ändern. Neue Sprachen oder Locales können durch Hinzufügen einer neuen Datei zum Message-Katalog bereitgestellt werden.

**msgcat** unterscheidet Pakete anhand ihres Namespace. Jedes Paket hat seinen eigenen Message-Katalog und seine Konfigurationseinstellungen in **msgcat**.

Ein *locale* ist eine Spezifikationszeichenkette, die eine Benutzersprache beschreibt, z. B. **de\_ch** für Schweizerdeutsch. In **msgcat** gibt es ein globales Locale, das anhand des System-Locale des aktuellen Systems initialisiert wird. Jedes Paket kann entscheiden, das globale Locale oder ein paketspezifisches Locale zu verwenden.

Das globale Locale kann bei Bedarf geändert werden, z. B. durch eine vom Benutzer ausgelöste Sprachumschaltung oder in einer Mehrbenutzer-Anwendung wie einem Web-Server.

[Objektorientierte Programmierung wird durch die Verwendung eines Paket-Namespace unterstützt.]{version="TIP490"}

# Befehle

[::msgcat::mc]{.cmd} [src-string]{.arg} [arg arg]{.optdot}
: Gibt eine Übersetzung von *src-string* gemäß dem aktuellen Locale zurück. Wenn nach *src-string* weitere Argumente angegeben werden, wird der Befehl [format] verwendet, um die zusätzlichen Argumente in die Übersetzung von *src-string* einzusetzen.

    **::msgcat::mc** durchsucht die im aktuellen Namespace definierten Meldungen nach einer Übersetzung von *src-string*; wird keine gefunden, wird im übergeordneten Namespace des aktuellen Namespace gesucht und so weiter, bis der globale Namespace erreicht ist. Existiert keine Übersetzungszeichenkette, wird **::msgcat::mcunknown** aufgerufen und die von **::msgcat::mcunknown** zurückgegebene Zeichenkette wird zurückgegeben.

    **::msgcat::mc** ist die Hauptfunktion zur Lokalisierung einer Anwendung. Statt eine englische Zeichenkette direkt zu verwenden, kann eine Anwendung die englische Zeichenkette durch **::msgcat::mc** leiten und das Ergebnis nutzen. Wird eine Anwendung auf diese Weise für eine einzige Sprache geschrieben, lässt sich später leicht Unterstützung für weitere Sprachen hinzufügen, indem einfach neue Message-Katalog-Einträge definiert werden.

[::msgcat::mcn]{.cmd} [namespace]{.arg} [src-string]{.arg} [arg arg]{.optdot}
: [Wie **::msgcat::mc**, jedoch mit dem Message-Namespace als erstem Argument.]{version="TIP490"}

    **mcn** kann verwendet werden, wenn der Paket-Namespace nicht der Namespace des Aufrufers ist. Ein Beispiel steht in der Beschreibung des Befehls **::msgcat::mcpackagenamespaceget** weiter unten.

[::msgcat::mcmax]{.cmd} [src-string src-string]{.optdot}
: Bei mehreren Quellzeichenketten gibt **::msgcat::mcmax** die Länge der längsten übersetzten Zeichenkette zurück. Das ist nützlich beim Entwurf lokalisierter GUIs, die z. B. erfordern können, dass alle Schaltflächen eine feste Breite haben (nämlich die Breite der breitesten Schaltfläche).

[::msgcat::mcexists]{.cmd} [-exactnamespace]{.optlit} [-exactlocale]{.optlit} [[-namespace]{.lit} [namespace]{.arg}]{.optarg} [src-string]{.arg}
: Gibt **true** zurück, wenn eine Übersetzung für die angegebene *src-string* existiert.

    Die Suche kann mit der Option **-exactnamespace** auf den aktuellen Namespace beschränkt werden, ohne übergeordnete Namespaces zu prüfen.

    Sie kann auch mit der Option **-exactlocale** auf das erste bevorzugte Locale beschränkt werden (z. B. das erste Element von **::msgcat::mcpreferences**, wenn das globale Locale verwendet wird).

    [Ein expliziter Paket-Namespace kann mit der Option **-namespace** angegeben werden. Wird er nicht explizit angegeben, wird der Namespace des Aufrufers verwendet.]{version="TIP490"}


[::msgcat::mcpackagenamespaceget]{.cmd}
: [Gibt den Paket-Namespace des Aufrufers zurück. Dieser Befehl behandelt alle in Abschnitt [Objektorientierte Programmierung] beschriebenen Fälle.]{version="TIP490"}

    Beispiel: Ein Tooltip-Paket speichert den Paket-Namespace des Aufrufers, um die Übersetzung bei jedem Anzeigen des Tooltips zu aktualisieren:

    ```
    proc ::tooltip::tooltip {widget message} {
        ...
        set messagenamespace [uplevel 1 {::msgcat::mcpackagenamespaceget}]
        ...
        bind $widget  [list ::tooltip::show $widget $messagenamespace $message]
    }

    proc ::tooltip::show {widget messagenamespace message} {
        ...
        set message [::msgcat::mcn $messagenamespace $message]
        ...
    }
    ```


[::msgcat::mclocale]{.cmd} [newLocale]{.optarg}
: Wenn *newLocale* weggelassen wird, wird das aktuelle Locale zurückgegeben, andernfalls wird das aktuelle Locale auf *newLocale* gesetzt.

    Wird das neue Locale auf *newLocale* gesetzt, werden die zugehörigen Präferenzen berechnet und gesetzt. Wenn das aktuelle Locale z. B. en\_US\_funky ist, gibt **::msgcat::mcpreferences** **{en\_us\_funky en\_us en {}}** zurück.

    Dasselbe Ergebnis lässt sich mit **::msgcat::mcpreferences** {\*}\[**::msgcat::mcutil getpreferences** *newLocale*\] erzielen.

    Das aktuelle Locale ist immer das erste Element der von **mcpreferences** zurückgegebenen Liste.

    msgcat speichert und vergleicht das Locale ohne Berücksichtigung der Groß-/Kleinschreibung und gibt Locales in Kleinbuchstaben zurück. Das anfängliche Locale wird durch das in der Umgebung des Benutzers angegebene Locale bestimmt. Siehe [Locale-Spezifikation] weiter unten für das Locale-Zeichenkettenformat.

    Wenn das Locale gesetzt wird, wird die Präferenzliste der Locales ausgewertet. Locales in dieser Liste werden jetzt geladen, falls sie noch nicht geladen sind.

[::msgcat::mcpreferences]{.cmd} [locale preference]{.optarg} ...
: Ohne Argumente gibt dieser Befehl eine geordnete Liste der vom Benutzer bevorzugten Locales zurück. Die Liste ist von der spezifischsten zur geringsten Präferenz geordnet.

    [Es kann eine Menge von Locale-Präferenzen angegeben werden, um die Liste der Locale-Präferenzen zu setzen. Das aktuelle Locale wird ebenfalls gesetzt; es ist das erste Element der Locale-Präferenzliste.]{version="TIP499"}

    Locale-Präferenzen werden jetzt geladen, falls sie noch nicht geladen sind.

    Beispiel: Der Benutzer bevorzugt französischen oder englischen Text. Das lässt sich so konfigurieren:

    ```
    ::msgcat::mcpreferences fr en {}
    ```


[::msgcat::mcloadedlocales]{.cmd} [subcommand]{.sub}
: [Diese Gruppe von Befehlen verwaltet die Liste der geladenen Locales für Pakete, die kein Paket-Locale setzen.]{version="TIP499"}

    Der Unterbefehl **loaded** gibt die Liste der aktuell geladenen Locales zurück.

    Der Unterbefehl **clear** entfernt alle Locales und ihre Daten, die nicht in der aktuellen Präferenzliste stehen.

[::msgcat::mcload]{.cmd} [dirname]{.arg}
: Durchsucht das angegebene Verzeichnis nach Dateien, die den von **::msgcat::mcloadedlocales loaded** zurückgegebenen Sprachspezifikationen entsprechen (oder **msgcat::mcpackagelocale preferences**, wenn ein Paket-Locale gesetzt ist) (diese sind alle in Kleinbuchstaben), erweitert um die Dateierweiterung ".msg". Jede passende Datei wird der Reihe nach gelesen, unter Annahme einer UTF-8-Kodierung. Der Dateiinhalt wird dann als Tcl-Skript ausgewertet. Das bedeutet, dass Unicode-Zeichen in der Message-Datei entweder direkt in UTF-8-kodierter Form oder durch von der Tcl-Auswertung erkanntes Backslash-u-Quoting vorhanden sein können. Die Anzahl der Message-Dateien, die der Spezifikation entsprachen und geladen wurden, wird zurückgegeben.

    Zusätzlich wird der angegebene Ordner in der Paketkonfigurationsoption *mcfolder* von **msgcat** gespeichert, um bei einer Locale-Änderung gegebenenfalls benötigte Message-Katalog-Dateien zu laden.

[::msgcat::mcset]{.cmd} [locale]{.arg} [src-string]{.arg} [translate-string]{.optarg}
: Legt die Übersetzung für *src-string* auf *translate-string* im angegebenen *locale* und im aktuellen Namespace fest. Wenn *translate-string* nicht angegeben ist, wird *src-string* für beides verwendet. Die Funktion gibt *translate-string* zurück.

[::msgcat::mcmset]{.cmd} [locale]{.arg} [src-trans-list]{.arg}
: Legt die Übersetzung für mehrere Quellzeichenketten in *src-trans-list* im angegebenen *locale* und im aktuellen Namespace fest. *src-trans-list* muss eine gerade Anzahl von Elementen haben und hat die Form {*src-string translate-string* ?*src-string translate-string ...*?} **::msgcat::mcmset** kann deutlich schneller sein als mehrere Aufrufe von **::msgcat::mcset**. Die Funktion gibt die Anzahl der gesetzten Übersetzungen zurück.

[::msgcat::mcflset]{.cmd} [src-string]{.arg} [translate-string]{.optarg}
: Legt die Übersetzung für *src-string* auf *translate-string* im aktuellen Namespace für das Locale fest, das sich aus dem Namen des über **::msgcat::mcload** geladenen Message-Katalogs ergibt. Wenn *translate-string* nicht angegeben ist, wird *src-string* für beides verwendet. Die Funktion gibt *translate-string* zurück.

[::msgcat::mcflmset]{.cmd} [src-trans-list]{.arg}
: Legt die Übersetzung für mehrere Quellzeichenketten in *src-trans-list* im aktuellen Namespace für das Locale fest, das sich aus dem Namen des über **::msgcat::mcload** geladenen Message-Katalogs ergibt. *src-trans-list* muss eine gerade Anzahl von Elementen haben und hat die Form {*src-string translate-string* ?*src-string translate-string ...*?} **::msgcat::mcflmset** kann deutlich schneller sein als mehrere Aufrufe von **::msgcat::mcflset**. Die Funktion gibt die Anzahl der gesetzten Übersetzungen zurück.

[::msgcat::mcunknown]{.cmd} [locale]{.arg} [src-string]{.arg} [arg arg]{.optdot}
: Diese Routine wird von **::msgcat::mc** aufgerufen, wenn für *src-string* im aktuellen Locale keine Übersetzung definiert ist. Die Standardaktion ist, *src-string* per format zurückzugeben, wenn Argumente vorhanden sind. Diese Prozedur kann von der Anwendung neu definiert werden, z. B. um Fehlermeldungen für jede unbekannte Zeichenkette zu protokollieren. Die Prozedur **::msgcat::mcunknown** wird im gleichen Stack-Kontext wie der Aufruf von **::msgcat::mc** ausgeführt. Der Rückgabewert von **::msgcat::mcunknown** wird als Rückgabewert für den Aufruf von **::msgcat::mc** verwendet.

    Hinweis: Diese Routine wird nur aufgerufen, wenn das betreffende Paket keinen paketspezifischen Unknown-Befehl gesetzt hat.

[::msgcat::mcforgetpackage]{.cmd}
: Das aufrufende Paket löscht seinen gesamten Zustand innerhalb des Pakets **msgcat** einschließlich aller Einstellungen und Übersetzungen.


[::msgcat::mcutil]{.cmd version="TIP499"} [getpreferences]{.sub} [locale]{.arg}
: [Gibt die Präferenzliste des angegebenen Locale zurück, wie im Abschnitt [Locale-Spezifikation] beschrieben. Ein Beispiel ist die Zusammensetzung einer Präferenzliste für die zweisprachige Region „Biel/Bienne“ als Verkettung von Schweizerdeutsch und Schweizerfranzösisch:]{version="TIP499"}

    ```
    % concat [lrange [msgcat::mcutil getpreferences fr_CH] 0 end-1] [msgcat::mcutil getpreferences de_CH]
    fr_ch fr de_ch de {}
    ```

[::msgcat::mcutil]{.cmd version="TIP499"} [getsystemlocale]{.sub}
: [Gibt das System-Locale zurück, wie im Abschnitt [Locale-Spezifikation] beschrieben.]{version="TIP499"}


# Locale-Spezifikation

Das Locale wird **msgcat** durch eine an **::msgcat::mclocale** übergebene Locale-Zeichenkette mitgeteilt. Die Locale-Zeichenkette besteht aus einem Sprachcode, einem optionalen Ländercode und einem optionalen systemspezifischen Code, jeweils getrennt durch "\_". Die Länder- und Sprachcodes sind in den Standards ISO-639 und ISO-3166 festgelegt. Zum Beispiel legt das Locale "en" Englisch fest und "en\_US" U.S.-Englisch.

Wenn das Paket msgcat zum ersten Mal geladen wird, wird das Locale gemäß der Umgebung des Benutzers initialisiert. Die Variablen **env(LC\_ALL)**, **env(LC\_MESSAGES)** und **env(LANG)** werden der Reihe nach geprüft. Der erste von ihnen mit nicht leerem Wert wird zur Bestimmung des anfänglichen Locale verwendet. Der Wert wird gemäß dem XPG4-Muster

```
language[_country][.codeset][@modifier]
```

zerlegt. Das anfängliche Locale wird dann gesetzt, indem **::msgcat::mclocale** mit folgendem Argument aufgerufen wird:

```
language[_country][_modifier]
```

Unter Windows und Cygwin versucht msgcat, falls keine dieser Umgebungsvariablen gesetzt ist, Locale-Informationen aus der Registry zu extrahieren. Der RFC4747-Locale-Name "lang-script-country-options" wird in das Locale als "lang\_country\_script" umgewandelt (Beispiel: sr-Latn-CS -> sr\_cs\_latin). Schlagen alle Versuche fehl, ein anfängliches Locale aus der Umgebung des Benutzers zu ermitteln, verwendet msgcat standardmäßig ein anfängliches Locale von "C".

Wenn der Benutzer ein Locale angibt, wird bei der Zeichenkettenübersetzung eine "best match"-Suche durchgeführt. Gibt ein Benutzer z. B. en\_GB\_Funky an, werden die Locales "en\_gb\_funky", "en\_gb", "en" und "" (die leere Zeichenkette) der Reihe nach durchsucht, bis eine passende Übersetzungszeichenkette gefunden wird. Ist keine Übersetzungszeichenkette verfügbar, wird der Unknown-Handler aufgerufen.

# Namespaces und Message-Kataloge

Im Message-Katalog gespeicherte Zeichenketten werden relativ zum Namespace gespeichert, aus dem sie hinzugefügt wurden. Das ermöglicht mehreren Paketen, dieselben Zeichenketten zu verwenden, ohne Kollisionen mit anderen Paketen zu befürchten. Außerdem können Quellzeichenketten kürzer und weniger fehleranfällig bei Tippfehlern sein.

Zum Beispiel gibt die Ausführung des Codes

```
::msgcat::mcset en hello "hello from ::"
namespace eval foo {
    ::msgcat::mcset en hello "hello from ::foo"
}
puts [::msgcat::mc hello]
namespace eval foo {puts [::msgcat::mc hello]}
```

aus

```
hello from ::
hello from ::foo
```

Bei der Suche nach einer Übersetzung einer Meldung durchsucht der Message-Katalog zuerst den aktuellen Namespace, dann den übergeordneten des aktuellen Namespace und so weiter, bis der globale Namespace erreicht ist. Das ermöglicht Kind-Namespaces, Meldungen vom übergeordneten Namespace zu übernehmen.

Zum Beispiel gibt die Ausführung (im Locale "en") des Codes

```
::msgcat::mcset en m1 ":: message1"
::msgcat::mcset en m2 ":: message2"
::msgcat::mcset en m3 ":: message3"
namespace eval ::foo {
    ::msgcat::mcset en m2 "::foo message2"
    ::msgcat::mcset en m3 "::foo message3"
}
namespace eval ::foo::bar {
    ::msgcat::mcset en m3 "::foo::bar message3"
}
namespace import ::msgcat::mc
puts "[mc m1]; [mc m2]; [mc m3]"
namespace eval ::foo {puts "[mc m1]; [mc m2]; [mc m3]"}
namespace eval ::foo::bar {puts "[mc m1]; [mc m2]; [mc m3]"}
```

aus

```
:: message1; :: message2; :: message3
:: message1; ::foo message2; ::foo message3
:: message1; ::foo message2; ::foo::bar message3
```

# Speicherort und Format von Message-Dateien

Message-Dateien können in jedem Verzeichnis liegen, vorbehaltlich der folgenden Bedingungen:

1. Alle Message-Dateien eines Pakets liegen im selben Verzeichnis.

2. Der Dateiname ist ein msgcat-Locale-Spezifizierer (alles Kleinbuchstaben) gefolgt von ".msg". Zum Beispiel:


```
es.msg    — spanish
en_gb.msg — United Kingdom English
```

*Ausnahme:* Die Message-Datei für das Root-Locale "" heißt "**ROOT.msg**". Diese Ausnahme verhindert ungewöhnliches Verhalten, z. B. dass die Message-Datei als "hidden" auf Unix-Dateisystemen markiert wird.

3. Die Datei enthält eine Reihe von Aufrufen von **mcflset** und **mcflmset**, die die nötigen Übersetzungszeichenketten für die Sprache setzen, typischerweise in einem [namespace eval][namespace], damit alle Quellzeichenketten an den Namespace des Pakets gebunden sind. Eine kurze **es.msg** könnte z. B. enthalten:


```
namespace eval ::mypackage {
    ::msgcat::mcflset "Free Beer" "Cerveza Gratis"
}
```

# Empfohlene Message-Einrichtung für Pakete

Wenn ein Paket in ein Unterverzeichnis von [tcl\_pkgPath][tclvars] installiert und über [package require][package] geladen wird, empfiehlt sich folgendes Vorgehen.

1. Erstellen Sie bei der Paketinstallation ein Unterverzeichnis **msgs** unter Ihrem Paketverzeichnis.

2. Kopieren Sie Ihre \*.msg-Dateien in dieses Verzeichnis.

3. Fügen Sie den folgenden Befehl in Ihr Paket-Initialisierungsskript ein:


```
# Sprachdateien laden, gespeichert im Unterverzeichnis msgs
::msgcat::mcload [file join [file dirname [info script]] msgs]
```

# Positionale Platzhalter für Format- und Scan-Befehle

Es ist möglich, dass eine als Argument für [format] verwendete Message-Zeichenkette positionsabhängige Parameter hat, die beim Übersetzen umgestellt werden müssen. Zum Beispiel kann es syntaktisch sinnvoll sein, die Satzstruktur umzuordnen.

```
format "We produced %d units in location %s" $num $city
format "In location %s we produced %d units" $city $num
```

Das lässt sich mit positionalen Parametern handhaben:

```
format "We produced %1\$d units in location %2\$s" $num $city
format "In location %2\$s we produced %1\$d units" $num $city
```

Analog können positionale Parameter mit [scan] verwendet werden, um Werte aus internationalisierten Zeichenketten zu extrahieren. Hinweis: Es ist nicht nötig, die Ausgabe von **::msgcat::mc** direkt an [format] zu übergeben; durch Übergabe der einzusetzenden Werte als Argumente erfolgt die Format-Ersetzung direkt.

```
msgcat::mc {Produced %1$d at %2$s} $num $city
# ... wobei dieser Schlüssel durch msgcat::mcset auf eine der
# menschenlesbaren Versionen abgebildet wird
```

# Paketprivate Locale

Ein Paket, das **msgcat** verwendet, kann ein eigenes paketprivates Locale und eine eigene Menge geladener Locales verwenden, unabhängig vom globalen Locale, das durch **::msgcat::mclocale** gesetzt wird.

So kann ein Paket sein Locale ändern, ohne Locales in anderen Paketen zu laden oder zu entfernen und ohne den globalen Locale-Änderungs-Rückruf aufzurufen (siehe unten).

Dieses Verhalten wird durch folgendes Ensemble gesteuert:

[::msgcat::mcpackagelocale]{.cmd} [set]{.sub} [locale]{.optarg}
: Setzt oder ändert ein paketprivates Locale. Das paketprivate Locale wird auf das angegebene *locale* gesetzt, wenn *locale* angegeben ist. Wenn die Option *locale* nicht angegeben ist, wird das Paket in den Modus paketprivates Locale versetzt, aber kein Locale geändert (z. B. wenn das globale Locale zuvor für das Paket gültig war, wird es ins paketprivate Locale kopiert).

    Dieser Befehl kann das Laden von Locales auslösen.

[::msgcat::mcpackagelocale]{.cmd} [get]{.sub}
: Gibt das paketprivate Locale oder das globale Locale zurück, wenn kein paketprivates Locale gesetzt ist.

[::msgcat::mcpackagelocale]{.cmd} [preferences]{.sub} [locale preference]{.optarg} ...
: Ohne Parameter gibt dieser Befehl die paketprivaten Präferenzen oder die globalen Präferenzen zurück, wenn kein paketprivates Locale gesetzt ist. Der Paket-Locale-Zustand (gesetzt oder nicht) wird nicht geändert (im Gegensatz zu **::msgcat::mcpackagelocale set**).

    [Wird eine Menge von Locale-Präferenzen angegeben, wird sie als paketlocale Präferenzliste gesetzt. Das Paket-Locale wird auf das erste Element der Präferenzliste gesetzt. Ein Paket-Locale wird aktiviert, falls es bisher nicht gesetzt war.]{version="TIP499"}

    Locale-Präferenzen werden für das Paket jetzt geladen, falls noch nicht geladen.


[::msgcat::mcpackagelocale]{.cmd} [loaded]{.sub}
: Gibt die Liste der für dieses Paket geladenen Locales zurück.

[::msgcat::mcpackagelocale]{.cmd} [isset]{.sub}
: Gibt **true** zurück, wenn ein paketprivates Locale gesetzt ist.

[::msgcat::mcpackagelocale]{.cmd} [unset]{.sub}
: Hebt das paketprivate Locale auf und verwendet das globale Locale. Lädt und entfernt Locales, um die Liste der geladenen Locales des Pakets an die globale Liste geladener Locales anzupassen.

[::msgcat::mcpackagelocale]{.cmd} [present]{.sub} [locale]{.arg}
: Gibt **true** zurück, wenn das angegebene Locale für das Paket geladen ist.

[::msgcat::mcpackagelocale]{.cmd} [clear]{.sub}
: Entfernt alle geladenen Locales des Pakets, die nicht in den Paket-Präferenzen enthalten sind.


# Änderung der Paketoptionen

Jedes Paket, das msgcat verwendet, hat eine Menge von Optionen innerhalb von **msgcat**. Die Paketoptionen werden im nächsten Abschnitt [Paketoptionen] beschrieben. Jede Paketoption kann einzeln mit folgendem Ensemble gesetzt oder zurückgesetzt werden:

[::msgcat::mcpackageconfig]{.cmd} [get]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der angegebenen *option* zurück. Dieser Aufruf meldet einen Fehler, wenn die Option für das Paket nicht gesetzt ist.

[::msgcat::mcpackageconfig]{.cmd} [isset]{.sub} [option]{.arg}
: Gibt 1 zurück, wenn die angegebene *option* für das Paket gesetzt ist, sonst 0.

[::msgcat::mcpackageconfig]{.cmd} [set]{.sub} [option]{.arg} [value]{.arg}
: Setzt die angegebene *option* auf den angegebenen *value*. Das kann je nach *option* weitere Aktionen auslösen. Der Rückgabewert ist 0 oder die Anzahl geladener Pakete für die Option **mcfolder**.

[::msgcat::mcpackageconfig]{.cmd} [unset]{.sub} [option]{.arg}
: Setzt die angegebene *option* für das Paket zurück. Es erfolgt keine Aktion, wenn die *option* für das Paket nicht gesetzt ist. Die leere Zeichenkette wird zurückgegeben.


## Paketoptionen

Folgende Paketoptionen stehen für jedes Paket zur Verfügung:

**mcfolder**
: Dies ist der Message-Ordner des Pakets. Diese Option wird durch mcload und den Unterbefehl set gesetzt. Beides ist identisch und gibt die Anzahl geladener Message-Katalog-Dateien zurück.

    Das Setzen oder Ändern dieses Werts lädt alle Locales, die in den für das Paket gültigen Präferenzen enthalten sind. Das impliziert auch den Aufruf eines gesetzten loadcmd (siehe unten).

    Das Zurücksetzen dieses Werts deaktiviert das Laden von Message-Dateien für das Paket.

**loadcmd**
: Dieser Rückruf wird aufgerufen, bevor eine Menge von Message-Katalog-Dateien für das Paket geladen wird, das diese Eigenschaft gesetzt hat.

    Dieser Rückruf kann Vorbereitungsarbeiten für das Laden von Message-Dateien leisten oder Message-Daten aus einer anderen Quelle wie einer Datenbank holen. In diesem Fall werden keine Message-Dateien verwendet (mcfolder ist nicht gesetzt).

    Siehe Abschnitt [Rückruf-Aufruf] unten. Die an diesen Rückruf angehängte Parameterliste ist die Liste der zu ladenden Locales.

    Wird dieser Rückruf geändert, wird er mit den für das Paket gültigen Präferenzen aufgerufen.

**changecmd**
: Dieser Rückruf wird aufgerufen, wenn eine Standard-Locale-Änderung durchgeführt wurde. Er soll einem Paket erlauben, Abhängigkeiten vom Standard-Locale zu aktualisieren, z. B. die GUI in einer anderen Sprache anzuzeigen.

    Siehe den Abschnitt Rückruf-Aufruf unten. Die angehängte Parameterliste ist **mcpreferences**. Die registrierten Rückrufe werden in beliebiger Reihenfolge aufgerufen.

**unknowncmd**
: Verwendet eine paketlocale mcunknown-Prozedur statt der von msgcat bereitgestellten Standardversion (**msgcat::mcunknown**).

    Die aufgerufene Prozedur muss die formatierte Meldung zurückgeben, die schließlich von **msgcat::mc** zurückgegeben wird.

    Ein generischer Unknown-Handler wird verwendet, wenn auf die leere Zeichenkette gesetzt. Dieser gibt den Schlüssel zurück, wenn keine Argumente übergeben werden. Mit Argumenten wird der Befehl [format] zur Verarbeitung verwendet.

    Siehe Abschnitt [Rückruf-Aufruf] unten. Die angehängten Argumente sind identisch zu **msgcat::mcunknown**.


# Rückruf-Aufruf

Ein Paket kann einen oder mehrere Rückrufe registrieren, wie oben beschrieben.

Rückrufe werden aufgerufen, wenn:

1. der Rückrufbefehl gesetzt ist,

2. der Befehl nicht die leere Zeichenkette ist,

3. der registrierende Namespace existiert.

Schlägt eine aufgerufene Routine mit einem Fehler fehl, wird nach Befehlsende die [bgerror]-Routine des Interpreters aufgerufen. Ausnahme ist der Rückruf **unknowncmd**, bei dem ein Fehler den aufrufenden **mc**-Befehl mit diesem Fehler fehlschlagen lässt.

# Objektorientierte Programmierung

**msgcat** unterstützt Pakete, die objektorientiert implementiert sind. Objekte und Klassen sollten innerhalb eines Paket-Namespace definiert werden.

Es gibt drei unterstützte Fälle, in denen paketnamespace-sensitive Befehle von msgcat (**mc**, **mcexists**, **mcpackagelocale**, **mcforgetpackage**, **mcpackagenamespaceget**, **mcpackageconfig**, **mcset** und **mcmset**) aufgerufen werden können:

**1) Im Klassendefinitionsskript**
: Ein **msgcat**-Befehl wird innerhalb eines Klassendefinitionsskripts aufgerufen.

    ```
    namespace eval ::N2 {
        mcload $dir/msgs
        oo::class create C1 {puts [mc Hi!]}
    }
    ```


**2) Methode in einer Klasse**
: Ein **msgcat**-Befehl wird aus einer Methode in einem Objekt aufgerufen, und die Methode ist in einer Klasse definiert.

    ```
    namespace eval ::N3Class {
        mcload $dir/msgs
        oo::class create C1
        oo::define C1 method m1 {
            puts [mc Hi!]
        }
    }
    ```


**3) Methode in einem klassenlosen Objekt**
: Ein **msgcat**-Befehl wird aus einer Methode eines klassenlosen Objekts aufgerufen.

    ```
    namespace eval ::N4 {
        mcload $dir/msgs
        oo::object create O1
        oo::objdefine O1 method m1 {} {
            puts [mc Hi!]
        }
    }
    ```


# Beispiele

Pakete mit GUI können ihre Widgets aktualisieren, wenn sich das globale Locale ändert. Zur Registrierung eines Rückrufs:

```
namespace eval gui {
    msgcat::mcpackageconfig changecmd updateGUI

    proc updateGUI args {
        puts "New locale is '[lindex $args 0]'."
    }
}
% msgcat::mclocale fr
fr
% New locale is 'fr'.
```

Liegen Locales (oder zusätzliche Locales) in einer anderen Quelle wie einer Datenbank, kann ein Paket den Lade-Rückruf statt **mcload** verwenden:

```
namespace eval db {
    msgcat::mcpackageconfig loadcmd loadMessages

    proc loadMessages args {
        foreach locale $args {
            if {[LocaleInDB $locale]} {
                msgcat::mcmset $locale [GetLocaleList $locale]
            }
        }
    }
}
```

Die [clock]-Befehlsimplementierung nutzt **msgcat** mit einem Paket-Locale für den Befehlszeilenparameter **-locale**. Skizzen der Implementierung:

Zuerst wird ein Paket-Locale initialisiert und die generische Unknown-Funktion deaktiviert:

```
msgcat::mcpackagelocale set
msgcat::mcpackageconfig unknowncmd ""
```

Als Beispiel benötigt der Benutzer den Wochentag in einem bestimmten Locale:

```
clock format [clock seconds] -format %A -locale fr
```

[clock] setzt das Paket-Locale auf **fr** und sucht den Tagesnamen wie folgt:

```
msgcat::mcpackagelocale set $locale
return [lindex [msgcat::mc DAYS_OF_WEEK_FULL] $day]
### Gibt "mercredi" zurück
```

Innerhalb von [clock] sind einige Message-Katalog-Einträge rechenintensiv und werden daher dynamisch gecacht:

```
proc ::tcl::clock::LocalizeFormat { locale format } {
    set key FORMAT_$format
    if { [::msgcat::mcexists -exactlocale -exactnamespace $key] } {
        return [mc $key]
    }
    # ... aufwendige Berechnung des Formats gekürzt ...
    mcset $locale $key $format
    return $format
}
```

# Danksagungen

Der Message-Katalog-Code wurde von Mark Harrison entwickelt.


[bgerror]: bgerror.md
[clock]: clock.md
[format]: format.md
[namespace]: namespace.md
[package]: package.md
[scan]: scan.md
[tclvars]: tclvars.md
