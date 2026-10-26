# Befehle zu Tile-Themen

## Für Mentry Version 4.5

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Der Befehl mentry::setTheme](#der-befehl-mentry-settheme)
- [Der Befehl mentry::getCurrentTheme](#der-befehl-mentry-getcurrenttheme)
- [Der Befehl mentry::getThemes](#der-befehl-mentry-getthemes)
- [Der Befehl mentry::setThemeDefaults](#der-befehl-mentry-setthemedefaults)

[Startseite](index.md)

---

## Überblick

Die auf dieser Referenzseite beschriebenen Befehle sollten nur bei Verwendung des Pakets „Mentry_tile“ aufgerufen werden. Mit ihnen können Sie das aktuelle Thema festlegen und abfragen, eine Liste der verfügbaren Themen abrufen und sicherstellen, dass Ihre Widgets ein themenspezifisches Erscheinungsbild erhalten.

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::setTheme`

**NAME**
: `mentry::setTheme` – Aktuelles Thema festlegen

**ÜBERSICHT**
: 

```
mentry::setTheme theme
```

**BESCHREIBUNG**
: Dieser Befehl legt das aktuelle Thema auf `theme` fest und lädt es gegebenenfalls. Es handelt sich dabei lediglich um einen Alias für `ttk::setTheme` oder `tile::setTheme`, je nachdem, welche Tile-Version in den Interpreter geladen wurde.  (Der Befehl `tile::setTheme` wurde in der Tile-Version 0.8 in `ttk::setTheme` umbenannt.)

: Da es sich lediglich um einen Alias für eine Prozedur der Tile-Bibliothek handelt, führt der Befehl `mentry::setTheme` genau dasselbe aus wie der ursprüngliche Befehl: Er lädt bei Bedarf das Paket, das das angegebene Thema implementiert, legt das angegebene Thema fest und speichert dieses je nach aktueller Tile-Version in der Variable `ttk::currentTheme` oder `tile::currentTheme`.

**SCHLÜSSELWÖRTER**
: mentry, theme, tile


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::getCurrentTheme`

**NAME**
: `mentry::getCurrentTheme` – Aktuelles Thema abrufen

**ÜBERSICHT**
: 

```
mentry::getCurrentTheme
```

**BESCHREIBUNG**
: Dieser Befehl gibt den Namen des aktuellen Themas zurück, indem er den Befehl `ttk::style theme use` aufruft.  Wird eine ältere Tile-Version verwendet, die diese Methode noch nicht unterstützt, gibt der Befehl je nach Tile-Version den Wert der Variablen `ttk::currentTheme` oder `tile::currentTheme` zurück.  (Der Namespace, der die Variable `currentTheme` enthält, wurde in der Tile-Version 0.8 von `tile` in `ttk` geändert.)

**SCHLÜSSELWÖRTER**
: mentry, theme, tile


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::getThemes`

**NAME**
: `mentry::getThemes` – Die in der Paketdatenbank registrierten Themen abrufen

**ÜBERSICHT**
: 

```
mentry::getThemes
```

**BESCHREIBUNG**
: Dieser Befehl gibt eine Liste der in der Paketdatenbank registrierten Themen zurück. Es handelt sich dabei lediglich um einen Alias für `ttk::themes` oder `tile::availableThemes`, je nachdem, welche Tile-Version in den Interpreter geladen wurde.  (Der Befehl `tile::availableThemes` wurde in der Tile-Version 0.8 in `ttk::themes` umbenannt.)

**SCHLÜSSELWÖRTER**
: mentry, theme, tile


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::setThemeDefaults`

**NAME**
: `mentry::setThemeDefaults` – Festlegen themenspezifischer Standardwerte für bestimmte Mentry-Konfigurationsoptionen

**ÜBERSICHT**
: 

```
mentry::setThemeDefaults
```

**BESCHREIBUNG**
: Dieser Befehl füllt das Array `mentry::themeDefaults` mit themenspezifischen Standardwerten für eine Reihe von Mentry-Konfigurationsoptionen. Die Array-Namen entsprechen den Befehlszeilennamen der Optionen, und die zugehörigen Array-Werte sind die Standardwerte dieser Konfigurationsoptionen für das aktuell festgelegte Tile-Thema.

: Die Optionen, deren Namen und Werte in das Array `mentry::themeDefaults` geschrieben werden, sind: `-background`, `-foreground` und `-font`.  Darüber hinaus setzt der Befehl einige weitere Array-Elemente auf themenspezifische Standardwerte, die für interne Zwecke benötigt werden, wie beispielsweise die Aktualisierung der Hintergrund- und Vordergrundfarben der Beschriftungskomponenten eines Mentry-Widgets im Zustand `disabled` oder `readonly`; die entsprechenden Array-Namen lauten: `-disabledbackground`, `-disabledforeground` und `-readonlybackground`.  Schließlich werden die Array-Werte, die den Namen `-selectbackground`, `-selectforeground` und `-selectborderwidth` zugeordnet sind, von Mentry_tile nicht verwendet, könnten sich jedoch, wie im Folgenden beschrieben, für andere Zwecke als nützlich erweisen.

: Der Befehl `mentry::setThemeDefaults` wird von Mentry_tile automatisch beim Start der Anwendung sowie dann aufgerufen, wenn das virtuelle Ereignis `<<ThemeChanged>>` an das Hauptfenster gesendet wird.  Er wird außerdem unter macOS 10.14 (Mojave) und höher immer dann aufgerufen, wenn das Hauptfenster ein virtuelles Ereignis vom Typ `<<LightAppearance>>` (früher: `<<LightAqua>>`) oder `<<DarkAppearance>>` (früher: `<<DarkAqua>>`) erhält, wenn das aktuelle Thema `aqua` ist. In diesen Fällen sendet Mentry_tile nach dem Aufruf des Befehls `mentry::setThemeDefaults` das virtuelle Ereignis `<<MentryThemeDefaultsChanged>>` an das Hauptfenster und konfiguriert alle Mentry-Widgets der Anwendung neu, wobei die neuen Standardwerte jener Optionen verwendet werden, die nicht explizit auf andere Werte als die entsprechenden Standardwerte gesetzt wurden.

: Unter macOS 10.14 (Mojave) und höher werden die virtuellen Ereignisse `<<LightAppearance>>` und `<<DarkAppearance>>` (bzw. `<<LightAqua>>` und `<<DarkAqua>>`) von Tk 8.6.10 und höher an alle Toplevel-Fenster gesendet, sobald das Systemdesign zwischen hellem und dunklem Modus wechselt oder sich die Akzentfarbe in den allgemeinen Einstellungen ändert.  Tk-Versionen ab 8.6.11 senden diese Ereignisse unter macOS 10.15 (Catalina) und höher auch wenn die Hervorhebungsfarbe in den allgemeinen Einstellungen geändert wird.

: Dieser Befehl wird nicht nur von Mentry_tile verwendet, sondern kann auch im Anwendungscode aufgerufen werden, obwohl es bei den aktuellen Mentry_tile-Versionen nicht notwendig ist, ihn explizit aufzurufen.

: Durch die Verwendung der im Array `mentry::themeDefaults` enthaltenen Standardwerte können Sie sicherstellen, dass klassische Tk-Widgets, zum Beispiel text, genau wie die Tile-Widgets ein themenspezifisches Erscheinungsbild erhalten. So können Sie beispielsweise einige gängige Konfigurationsoptionen wie folgt zur Optionsdatenbank hinzufügen:


```
if {[tk windowingsystem] eq "x11"} {
    option add *Text.background   $mentry::themeDefaults(-background)
    option add *Text.foreground   $mentry::themeDefaults(-foreground)
    option add *selectBackground  $mentry::themeDefaults(-selectbackground)
    option add *selectForeground  $mentry::themeDefaults(-selectforeground)
}
option add *selectBorderWidth     $mentry::themeDefaults(-selectborderwidth)
option add *Font                  $mentry::themeDefaults(-font)
```

: Sie können außerdem das virtuelle Ereignis `<<MentryThemeDefaultsChanged>>` nutzen, um das Erscheinungsbild Ihrer Tk-Widgets entsprechend den neuen Werten im Array `mentry::themeDefaults` anzupassen, indem Sie eine Bindung an das dafür vorgesehene Bindungs-Tag `MentryMain` herstellen, das dem Hauptfenster zugeordnet ist:


```
bind MentryMain <<MentryThemeDefaultsChanged>> ...
```

: Das Bindungs-Tag `MentryMain` wird vom Mentry_tile dem Hauptfenster zugewiesen und intern zur Verarbeitung der virtuellen Ereignisse `<<ThemeChanged>>`, `<<LightAppearance>>` (oder `<<LightAqua>>`) sowie `<<DarkAppearance>>` (oder `<<DarkAqua>>`).  Wie oben gezeigt, können Anwendungen davon Gebrauch machen, z. B. zur Verarbeitung des virtuellen Ereignisses `<<MentryThemeDefaultsChanged>>`.

**SCHLÜSSELWÖRTER**
: mentry, theme, tile


[Inhalt](#inhalt)     [Startseite](index.md)
