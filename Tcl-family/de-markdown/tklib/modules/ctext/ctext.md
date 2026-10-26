---
CommandName: ctext
ManualSection: n
Version: 3.3
TclPart: tklib
TclDescription: Ctext a text widget with highlighting support
Links:
 - re_syntax
 - text
Keywords:
 - syntax highlighting
 - text
 - widget
Copyright:
 - Copyright (c) George Peter Staplin <GeorgePS@XMission.com>
---

# NAME

ctext – Ctext, ein Text-Widget mit Unterstützung für Hervorhebungen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tk]{.lit} 
[package]{.cmd} [require]{.sub} [ctext]{.lit} [3.3]{.optlit} 
[ctext]{.cmd} [pathName]{.arg} [options]{.optarg} 
[::ctext::addHighlightClass]{.cmd} [pathName]{.arg} [class]{.arg} [color]{.arg} [keywordlist]{.arg} 
[::ctext::addHighlightClassWithOnlyCharStart]{.cmd} [pathName]{.arg} [class]{.arg} [color]{.arg} [char]{.arg} 
[::ctext::addHighlightClassForSpecialChars]{.cmd} [pathName]{.arg} [class]{.arg} [color]{.arg} [charstring]{.arg} 
[::ctext::addHighlightClassForRegexp]{.cmd} [pathName]{.arg} [class]{.arg} [color]{.arg} [pattern]{.arg} 
[::ctext::clearHighlightClasses]{.cmd} [pathName]{.arg} 
[::ctext::getHighlightClasses]{.cmd} [pathName]{.arg} 
[::ctext::deleteHighlightClass]{.cmd} [pathName]{.arg} [class]{.arg} 
[::ctext::enableComments]{.cmd} [enable]{.arg} 
[::ctext::disableComments]{.cmd} [enable]{.arg} 
[pathName]{.ins} [highlight]{.sub} [startIndex]{.arg} [endIndex]{.arg} 
[pathName]{.ins} [fastdelete]{.sub} [index1]{.arg} [index2]{.optarg} 
[pathName]{.ins} [fastinsert]{.sub} 
[pathName]{.ins} [copy]{.sub} 
[pathName]{.ins} [cut]{.sub} 
[pathName]{.ins} [paste]{.sub} 
[pathName]{.ins} [append]{.sub} 
[pathName]{.ins} [configure]{.sub} [option]{.arg} [value]{.arg} [...]{.optdot} 
:::

# BESCHREIBUNG

Das Paket **ctext** stellt das ctext-Widget bereit, ein erweitertes Text-Widget mit konfigurierbarer Syntaxhervorhebung und einigen zusätzlichen Befehlen.

Ctext überlädt das Text-Widget und stellt neue Befehle bereit, nämlich **highlight**, **copy**, **paste**, **cut**, **append** und **edit**.  Außerdem gibt es mehrere Befehle, mit denen sich Klassen definieren lassen. Jede Klasse entspricht einem Tag im Widget.

# BEFEHLE

**ctext** *pathName* ?*options*?
: Erstellt und konfiguriert ein ctext-Widget.


# HERVORHEBUNG

Die Hervorhebung steuern Tags des Text-Widgets. Diese Tags heißen Hervorhebungsklassen. *class* ist ein Tag-Name und lässt sich wie jedes Tag eines Text-Widgets konfigurieren. Vier Arten von Hervorhebungsklassen werden unterstützt. Die Methode **highlight** des Widgets verwendet alle Hervorhebungsklassen automatisch.

**::ctext::addHighlightClass** *pathName* *class* *color* *keywordlist*
: Fügt dem ctext-Widget *pathName* die Hervorhebungsklasse *class* hinzu. Hervorgehoben wird mit der Farbe *color*. Alle Wörter in *keywordlist* werden hervorgehoben.


```
	# highlight some tcl keywords
	::ctext::addHighlightClass .t tclkeywords red [list set info interp uplevel upvar]
```

**::ctext::addHighlightClassWithOnlyCharStart** *pathName* *class* *color* *char*
: Fügt dem ctext-Widget *pathName* die Hervorhebungsklasse *class* hinzu. Hervorgehoben wird mit der Farbe *color*. Alle Wörter, die mit *char* beginnen, werden hervorgehoben.


```
	::ctext::addHighlightClassWithOnlyCharStart .t vars blue \$
```

**::ctext::addHighlightClassForSpecialChars** *pathName* *class* *color* *charstring*
: Fügt dem ctext-Widget *pathName* die Hervorhebungsklasse *class* hinzu. Hervorgehoben wird mit der Farbe *color*. Alle Zeichen in *charstring* werden hervorgehoben.

**::ctext::addHighlightClassForRegexp** *pathName* *class* *color* *pattern*
: Fügt dem ctext-Widget *pathName* die Hervorhebungsklasse *class* hinzu. Hervorgehoben wird mit der Farbe *color*. Alle Textteile, die zum regulären Ausdruck *pattern* passen, werden hervorgehoben.

**::ctext::clearHighlightClasses** *pathName*
: Entfernt alle Hervorhebungsklassen aus dem Widget *pathName*.

**::ctext::getHighlightClasses** *pathName*
: Listet alle Hervorhebungsklassen des Widgets *pathName* auf.

**::ctext::deleteHighlightClass** *pathName* *class*
: Löscht die Hervorhebungsklasse *class* aus dem Widget *pathName*.

**::ctext::enableComments** *enable*
: Schaltet die Hervorhebung von C-Kommentaren ein. *class* für Kommentare im C-Stil ist **\_cComment**. Die Hervorhebung von C-Kommentaren ist standardmäßig aus.

**::ctext::disableComments** *enable*
: Schaltet die Hervorhebung von C-Kommentaren aus.


# WIDGET-BEFEHLE

Jedes mit dem obigen Befehl erzeugte ctext-Widget unterstützt zusätzlich zu den Befehlen und Optionen des üblichen Text-Widgets die folgenden Befehle und Optionen.

*pathName* **highlight** *startIndex* *endIndex*
: Hebt den Text zwischen *startIndex* und *endIndex* hervor.

*pathName* **fastdelete** *index1* ?*index2*?
: Löscht den Textbereich, ohne die Hervorhebung zu aktualisieren. Die Argumente stimmen mit dem Befehl *pathName* **delete** überein, der vom üblichen Text-Widget geerbt wird.

*pathName* **fastinsert**
: Fügt Text ein, ohne die Hervorhebung zu aktualisieren. Die Argumente stimmen mit dem Befehl *pathName* **insert** überein, der vom üblichen Text-Widget geerbt wird.

*pathName* **copy**
: Ruft **tk_textCopy** für die ctext-Instanz auf.

*pathName* **cut**
: Ruft **tk_textCut** für die ctext-Instanz auf.

*pathName* **paste**
: Ruft **tk_textPaste** für die ctext-Instanz auf.

*pathName* **append**
: Hängt die aktuelle Auswahl an die Zwischenablage an.

*pathName* **configure** *option* *value* ?...?
: Setzt die Optionen des ctext-Widgets. Auf jeden Optionsnamen folgt der neue Wert.


# WIDGET-OPTIONEN

```
Command-Line Switch:    -linemap
Database Name:          
Database Class:         
```

: Erzeugt (-linemap 1) oder entfernt (-linemap 0) links neben dem Widget eine Zeilennummernliste. Voreingestellt wird die Linemap angezeigt.


```
Command-Line Switch:    -linemapfg
Database Name:          
Database Class:         
```

: Ändert den Vordergrund der Linemap. Voreingestellt ist dieselbe Farbe wie beim Haupt-Text-Widget.


```
Command-Line Switch:    -linemapbg
Database Name:          
Database Class:         
```

: Ändert den Hintergrund der Linemap. Voreingestellt ist dieselbe Farbe wie beim Haupt-Text-Widget.


```
Command-Line Switch:    -linemap_select_fg
Database Name:          
Database Class:         
```

: Ändert den Vordergrund der ausgewählten Zeile. Voreingestellt ist schwarz.


```
Command-Line Switch:    -linemap_select_bg
Database Name:          
Database Class:         
```

: Ändert den Hintergrund der ausgewählten Zeile. Voreingestellt ist gelb.


```
Command-Line Switch:    -linemap_mark_command
Database Name:          
Database Class:         
```

: Ruft eine Prozedur oder einen Befehl auf. Argumente sind der *pathName* des ctext-Fensters, der *type* (**marked** oder **unmarked**) und die gewählte Zeilennummer. Der Prozedurprototyp lautet:


```
proc linemark_cmd {win type line}.
```

: Siehe auch ctext_test_interactive.tcl


```
Command-Line Switch:    -highlight
Database Name:          
Database Class:         
```

: Boolescher Wert. Legt fest, ob eingefügter oder gelöschter Text hervorgehoben wird. Voreingestellt ist 1.


```
Command-Line Switch:    -linemap_markable
Database Name:          
Database Class:         
```

: Boolescher Wert. Legt fest, ob Zeilen in der Linemap mit der Maus markierbar sind. Voreingestellt ist 1.


# BEISPIEL

```
                        package require Tk
                        package require ctext

                        proc main {} {
                        pack [frame .f] -fill both -expand 1
                        pack [scrollbar .f.s -command {.f.t yview}] -side right -fill y

                        pack [ctext .f.t -bg black -fg white -insertbackground yellow  -yscrollcommand {.f.s set}] -fill both -expand 1

                        ctext::addHighlightClass .f.t widgets purple  [list ctext button label text frame toplevel  scrollbar checkbutton canvas listbox menu menubar menubutton  radiobutton scale entry message tk_chooseDir tk_getSaveFile  tk_getOpenFile tk_chooseColor tk_optionMenu]

                        ctext::addHighlightClass .f.t flags orange  [list -text -command -yscrollcommand  -xscrollcommand -background -foreground -fg -bg  -highlightbackground -y -x -highlightcolor -relief -width  -height -wrap -font -fill -side -outline -style -insertwidth  -textvariable -activebackground -activeforeground -insertbackground  -anchor -orient -troughcolor -nonewline -expand -type -message  -title -offset -in -after -yscroll -xscroll -forward -regexp -count  -exact -padx -ipadx -filetypes -all -from -to -label -value -variable  -regexp -backwards -forwards -bd -pady -ipady -state -row -column  -cursor -highlightcolors -linemap -menu -tearoff -displayof -cursor  -underline -tags -tag]

                        ctext::addHighlightClass .f.t stackControl red  {proc uplevel namespace while for foreach if else}
                        ctext::addHighlightClassWithOnlyCharStart .f.t vars mediumspringgreen "\$"
                        ctext::addHighlightClass .f.t variable_funcs gold {set global variable unset}
                        ctext::addHighlightClassForSpecialChars .f.t brackets green {[]{}}
                        ctext::addHighlightClassForRegexp .f.t paths lightblue {\.[a-zA-Z0-9\_\-]+}
                        ctext::addHighlightClassForRegexp .f.t comments khaki {#[^\n\r]*}
                        .f.t fastinsert end [info body main]

                        pack [frame .f1] -fill x

                        .f.t highlight 1.0 end

                        pack [button .f1.exit -text Exit -command exit] -side left

                        pack [entry .e] -side bottom -fill x
                        .e insert end "ctext::deleteHighlightClass .f.t "
                        bind .e <Return> {eval [.e get]}
                        }
                        main
```

Weitere Beispiele liegen im Quellpaket von ctext.

# DANK

Kevin Kenny, Neil Madden, Jeffrey Hobbs, Richard Suchenwirth, Johan Bengtsson, Mac Cody, Günther, Andreas Sievers und Michael Schlenker.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *ctext* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# COPYRIGHT

```
Copyright (c) George Peter Staplin <GeorgePS@XMission.com>
```
