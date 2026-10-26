# Befehle im Zusammenhang mit Tile-Themen

## Für Tablelist Version 7.12

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Der Befehl tablelist::setTheme](#der-befehl-tablelist-settheme)
- [Der Befehl tablelist::getCurrentTheme](#der-befehl-tablelist-getcurrenttheme)
- [Der Befehl tablelist::getThemes](#der-befehl-tablelist-getthemes)
- [Der Befehl tablelist::setThemeDefaults](#der-befehl-tablelist-setthemedefaults)

[Startseite](index.md)

---

## Überblick

Die auf dieser Referenzseite beschriebenen Befehle sollten nur bei Verwendung des Pakets „Tablelist_tile“ aufgerufen werden. Mit ihnen können Sie das aktuelle Thema festlegen und abfragen, eine Liste der verfügbaren Themen abrufen und sicherstellen, dass Ihre Widgets ein Themen-spezifisches Erscheinungsbild erhalten.

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::setTheme`

**NAME**
: `tablelist::setTheme` – Aktuelles Thema festlegen

**ÜBERSICHT**
: 

```
tablelist::setTheme theme
```

**BESCHREIBUNG**
: Dieser Befehl legt das aktuelle Thema auf `theme` fest und lädt es gegebenenfalls. Es handelt sich dabei lediglich um einen Alias für `ttk::setTheme` oder `tile::setTheme`, je nachdem, welche Tile-Version in den Interpreter geladen wurde.  (Der Befehl `tile::setTheme` wurde in der Tile-Version 0.8 in `ttk::setTheme` umbenannt.)

: Da es sich lediglich um einen Alias für eine Prozedur der Tile-Bibliothek handelt, führt der Befehl `tablelist::setTheme` genau dasselbe aus wie der ursprüngliche Befehl: Er lädt bei Bedarf das Paket, das das angegebene Thema implementiert, legt das angegebene Thema fest und speichert dieses je nach aktueller Tile-Version in der Variable `ttk::currentTheme` oder `tile::currentTheme`.

**SCHLÜSSELWÖRTER**
: tablelist, theme, tile


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::getCurrentTheme`

**NAME**
: `tablelist::getCurrentTheme` – Aktuelles Thema abrufen

**ÜBERSICHT**
: 

```
tablelist::getCurrentTheme
```

**BESCHREIBUNG**
: Dieser Befehl gibt den Namen des aktuellen Themas zurück, indem er den Befehl `ttk::style theme use` aufruft.  Wird eine ältere Tile-Version verwendet, die diese Methode noch nicht unterstützt, gibt der Befehl je nach Tile-Version den Wert der Variablen `ttk::currentTheme` oder `tile::currentTheme` zurück.  (Der Namespace, der die Variable `currentTheme` enthält, wurde in der Tile-Version 0.8 von `tile` in `ttk` geändert.)

**SCHLÜSSELWÖRTER**
: tablelist, theme, tile


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::getThemes`

**NAME**
: `tablelist::getThemes` – Die in der Paketdatenbank registrierten THEMES abrufen

**ÜBERSICHT**
: 

```
tablelist::getThemes
```

**BESCHREIBUNG**
: Dieser Befehl gibt eine Liste der in der Paketdatenbank registrierten Themen zurück. Es handelt sich dabei lediglich um einen Alias für `ttk::themes` oder `tile::availableThemes`, je nachdem, welche Tile-Version in den Interpreter geladen wurde.  (Der Befehl `tile::availableThemes` wurde in der Tile-Version 0.8 in `ttk::themes` umbenannt.)

**SCHLÜSSELWÖRTER**
: tablelist, theme, tile


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::setThemeDefaults`

**NAME**
: `tablelist::setThemeDefaults` – Festlegen themenspezifischer Standardwerte für bestimmte Konfigurationsoptionen der Tablelist

**ÜBERSICHT**
: 

```
tablelist::setThemeDefaults
```

**BESCHREIBUNG**
: Dieser Befehl füllt das Array `tablelist::themeDefaults` mit themenspezifischen Standardwerten für eine Reihe von Tablelist-Konfigurationsoptionen. Die Array-Namen entsprechen den Befehlszeilennamen der Optionen, und die entsprechenden Array-Werte sind die Standardwerte dieser Konfigurationsoptionen für das aktuell eingestellte Tile-Thema.

: Die OPTIONEN, deren Namen und Werte in das Array `tablelist::themeDefaults` geschrieben werden, sind: `-arrowcolor`, `-arrowdisabledcolor`, `-arrowstyle`, `-background`, `-disabledforeground`, `-font`, `-foreground`, `-labelborderwidth`, `-labelfont`, `-labelforeground`, `-labelpady`, `-selectbackground`, `-selectborderwidth`, `-selectforeground`, `-stripebackground` und `-treestyle`.  Darüber hinaus setzt der Befehl einige weitere Array-Elemente auf themenspezifische Standardwerte für die Hintergrund- und Vordergrundfarben der Spaltenbeschriftungen in den Zuständen `normal`, `disabled`, `active` und `pressed`.  (Tablelist benötigt die Beschriftungsfarben für die Darstellung von Sortierpfeilen und BILDERN mit Transparenz in den Spaltenbeschriftungen.)

: Der Befehl `tablelist::setThemeDefaults` wird von Tablelist_tile automatisch beim Start der Anwendung sowie dann aufgerufen, wenn das virtuelle Ereignis `<<ThemeChanged>>` an das Hauptfenster gesendet wird.  Er wird außerdem unter macOS 10.14 (Mojave) und höher immer dann aufgerufen, wenn das Hauptfenster ein virtuelles Ereignis vom Typ `<<LightAppearance>>` (früher: `<<LightAqua>>`) oder `<<DarkAppearance>>` (früher: `<<DarkAqua>>`) erhält, wenn das aktuelle Thema `aqua` ist. In diesen Fällen sendet „Tablelist_tile“ nach dem Aufruf des Befehls `tablelist::setThemeDefaults` das virtuelle Ereignis `<<TablelistThemeDefaultsChanged>>` an das Hauptfenster und konfiguriert alle Tablelist-Widgets der Anwendung neu, wobei die neuen Standardwerte jener Optionen verwendet werden, die nicht explizit auf andere Werte als die entsprechenden Standardwerte gesetzt wurden.

: Unter macOS 10.14 (Mojave) und höher werden die virtuellen Ereignisse `<<LightAppearance>>` und `<<DarkAppearance>>` (bzw. `<<LightAqua>>` und `<<DarkAqua>>`) von Tk 8.6.10 und höher an alle Toplevel-Fenster gesendet, sobald das Systemdesign zwischen hellem und dunklem Modus wechselt oder sich die Akzentfarbe in den allgemeinen Einstellungen ändert.  Tk-Versionen ab 8.6.11 senden diese Ereignisse unter macOS 10.15 (Catalina) und höher auch wenn die Hervorhebungsfarbe in den allgemeinen Einstellungen geändert wird.

: Dieser Befehl wird nicht nur von Tablelist_tile verwendet, sondern kann auch im Anwendungscode aufgerufen werden, obwohl es bei den aktuellen Versionen von Tablelist_tile nicht notwendig ist, ihn explizit aufzurufen.

: Durch die Verwendung der im Array `tablelist::themeDefaults` enthaltenen Standardwerte können Sie sicherstellen, dass klassische Tk-Widgets, zum Beispiel listbox und text, genau wie die Tile-Widgets ein themenspezifisches Erscheinungsbild erhalten.  Beispielsweise können Sie der Optionsdatenbank wie folgt einige gängige Konfigurationsoptionen hinzufügen:


```
if {[tk windowingsystem] eq "x11"} {
    option add *selectBackground  $tablelist::themeDefaults(-selectbackground)
    option add *selectForeground  $tablelist::themeDefaults(-selectforeground)
}
option add *selectBorderWidth     $tablelist::themeDefaults(-selectborderwidth)
```

: Sie können außerdem das virtuelle Ereignis `<<TablelistThemeDefaultsChanged>>` nutzen, um das Erscheinungsbild Ihrer Tk-Widgets entsprechend den neuen Werten im Array `tablelist::themeDefaults` anzupassen, indem Sie eine Bindung an das dafür vorgesehene Bindungs-Tag `TablelistMain` herstellen, das dem Hauptfenster zugeordnet ist:


```
bind TablelistMain <<TablelistThemeDefaultsChanged>> ...
```

: Das Bindungs-Tag `TablelistMain` wird vom Tablelist_tile dem Hauptfenster zugewiesen und intern zur Verarbeitung der VIRTUELLEN EREIGNISSE `<<ThemeChanged>>`, `<<LightAppearance>>` (oder `<<LightAqua>>`) sowie `<<DarkAppearance>>` (oder `<<DarkAqua>>`).  Wie oben gezeigt, können Anwendungen dies nutzen, um beispielsweise das virtuelle Ereignis `<<TablelistThemeDefaultsChanged>>` zu verarbeiten.

**SCHLÜSSELWÖRTER**
: tablelist, theme, tile


[Inhalt](#inhalt)     [Startseite](index.md)
