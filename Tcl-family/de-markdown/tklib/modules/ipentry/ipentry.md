---
CommandName: ipentry
ManualSection: n
Version: 0.3.2
TclPart: tklib
TclDescription: An IP address entry widget
Keywords:
 - entry
 - ip address
 - network
Copyright:
---

# NAME

ipentry – Ein Widget zur Eingabe von IP-Adressen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [ipentry]{.lit} [0.3.2]{.optlit} 
[::ipentry::ipentry]{.cmd} [pathName]{.arg} [option value]{.optdot} 
[::ipentry::ipentry6]{.cmd} [pathName]{.arg} [option value]{.optdot} 
[pathName]{.ins} [complete]{.sub} 
[pathName]{.ins} [get]{.sub} 
[pathName]{.ins} [insert]{.sub} [iplist]{.arg} 
[pathName]{.ins} [icursor]{.sub} [index]{.arg} 
[pathName]{.ins} [configure]{.sub} [option]{.arg} [value...]{.arg} 
[pathName]{.ins} [cget]{.sub} [option]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält ein Widget zur Eingabe einer IP-Adresse.

**::ipentry::ipentry** *pathName* ?*option* *value*...?
: Erzeugt ein neues IPv4-ipentry-Widget und konfiguriert es mit den angegebenen Optionen und ihren Werten.

**::ipentry::ipentry6** *pathName* ?*option* *value*...?
: Erzeugt ein neues ipentry-Widget zur Eingabe einer IPv6-Adresse. Alle Optionen sind dieselben wie beim IPv4-Widget. Jedes so erzeugte Widget unterstützt die folgenden Methoden:

*pathName* **complete**
: Gibt einen booleschen Wert zurück. true bedeutet, dass das Entry eine vollständige IP-Adresse enthält, also jedes Feld einen Wert hat. In manchen Fällen ist eine IPv6-Adresse auch gültig, wenn Felder fehlen. Das ist gesondert zu prüfen.

*pathName* **get**
: Gibt den Inhalt des Entry als Liste aus 4 oder 8 Elementen zurück.

*pathName* **insert** *iplist*
: IPv4 übernimmt eine Liste von 4 Elementen und fügt der Reihe nach je eines in jedes Quad des Entry ein. Alle Werte der Liste müssen leer oder ganze Zahlen sein. Werte außerhalb des Bereichs 0 bis 255 werden in den Bereich verschoben. IPv6 übernimmt eine Liste von 8 Elementen und fügt der Reihe nach je eines in jedes Quad des Entry ein. Alle Werte der Liste müssen leer oder 1 bis 4 Hexadezimalziffern sein.

*pathName* **icursor** *index*
: Setzt die Position des Einfügecursors des Widgets. Für ipentry gelten nur ganze Zahlen von 0 bis 15, für ipentry6 von 0 bis 31. Das Setzen des icursor wirkt nur, wenn das Widget bereits den Eingabefokus hat.

*pathName* **configure** *option* *value*...
: Ändert die Konfiguration des Widgets. Zu den Optionen und ihrer Bedeutung siehe den Abschnitt **WIDGET-OPTIONEN**.

*pathName* **cget** *option*
: Gibt zur angegebenen Option die aktuelle Konfiguration des Widgets zurück. Zu den Optionen und ihrer Bedeutung siehe den Abschnitt **WIDGET-OPTIONEN**.


# WIDGET-OPTIONEN

```
Command-Line Switch:    -textvariable
Database Name:          textvariable
Database Class:         Variable
```

: Der Name einer Variablen, die den Wert der IP-Adresse enthält. Der Wert muss eine Zeichenkette in der Form NNN.NNN.NNN.NNN für IPv4 oder HHHH:HHHH:HHHH:HHHH:HHHH:HHHH:HHHH:HHHH für IPv6 sein, wobei H für eine Hexadezimalziffer steht. Die Variable wird so angepasst, dass sie eine gültige IP-Adresse darstellt, wenn dies nicht bereits der Fall ist.


```
Command-Line Switch:    -state
Database Name:          state
Database Class:         State
```

: Gibt einen von drei Zuständen des Entry an: **normal**, **disabled** oder **readonly**.


```
Command-Line Switch:    -font
Database Name:          font
Database Class:         Font
```

```
Command-Line Switch:    -bd
Database Name:          borderWidth
Database Class:         BorderWidth
```

```
Command-Line Switch:    -fg
Database Name:          foreground
Database Class:         Foreground
```

```
Command-Line Switch:    -bg
Database Name:          background
Database Class:         Background
```

```
Command-Line Switch:    -relief
Database Name:          relief
Database Class:         Relief
```

```
Command-Line Switch:    -highlightthickness
Database Name:          highlightThickness
Database Class:         HighlightThickness
```

```
Command-Line Switch:    -highlightcolor
Database Name:          highlightColor
Database Class:         HighlightColor
```

```
Command-Line Switch:    -highlightbackground
Database Name:          highlightBackground
Database Class:         HighlightBackground
```

```
Command-Line Switch:    -selectbackground
Database Name:          selectBackground
Database Class:         Background
```

```
Command-Line Switch:    -selectforeground
Database Name:          selectForeground
Database Class:         Foreground
```

```
Command-Line Switch:    -selectborderwidth
Database Name:          selectBorderWidth
Database Class:         BorderWidth
```

```
Command-Line Switch:    -disabledbackground
Database Name:          disabledBackground
Database Class:         DisabledBackground
```

```
Command-Line Switch:    -disabledforeground
Database Name:          disabledForeground
Database Class:         DisabledForeground
```

```
Command-Line Switch:    -readonlybackground
Database Name:          readonlyBackground
Database Class:         ReadonlyBackground
```

```
Command-Line Switch:    -insertbackground
Database Name:          insertBackground
Database Class:         Background
```

: Standard-Optionen für Widgets. Eine Beschreibung ihrer Bedeutungen und Werte finden Sie unter **options**.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *ipentry* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# KATEGORIE

Widget
