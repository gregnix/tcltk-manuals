

Im Aufbau ...

*NAME*
: **Widget** - die Basisklasse Widget 


*BEFEHL*
: Widget::addmap *class* *subclass* *subpath* *options* 

: Widget::bwinclude *class* *subclass* *subpath* ?*arg...*? 

: Widget::cget *path* *option* 

: Widget::configure *path* *options* 

: Widget::create *class* *path* ?*rename*? 

: Widget::declare *class* *optlist* 

: Widget::define *class* *filename* ?*class ...*? 

: Widget::destroy *path* 

: Widget::focusNext *w* 

: Widget::focusOK *w* 

: Widget::focusPrev *w* 

: Widget::generate-doc *dir* *widgetlist* 

: Widget::generate-widget-doc *class* *iscmd* *file* 

: Widget::getoption *path* *option* 

: Widget::getVariable *path* *varName* *?myVarName?* 

: Widget::hasChanged *path* *option* *pvalue* 

: Widget::init *class* *path* *options* 

: Widget::setoption *path* *option* *value* 

: Widget::subcget *path* *subwidget* 

: Widget::syncoptions *class* *subclass* *subpath* *options* 

: Widget::tkinclude *class* *tkwidget* *subpath* ?*arg...*? 


---

BESCHREIBUNG

 Der Namespace **Widget** verwaltet die Daten, die zu allen BWidgets gehören, und stellt Befehle bereit, mit denen ein BWidget leicht definiert wird.   
Zum Definieren eines BWidget können die Befehle **tkinclude**, **bwinclude**, **declare**, **addmap** und **syncoptions** verwendet werden. Hier ist die Definition des Widgets [ComboBox](ComboBox.md):   
  
  

```
namespace eval ComboBox {
    # ArrowButton, Entry und LabelFrame werden verwendet
    ArrowButton::use
    Entry::use
    LabelFrame::use

    # Ressourcen von LabelFrame aufnehmen
    Widget::bwinclude ComboBox LabelFrame .labf \ 
        rename     {-text -label} \ 
        remove     {-focus} \ 
        prefix     {label -justify -width -anchor -height -font} \ 
        initialize {-relief sunken -borderwidth 2}

    # Ressourcen von Entry aufnehmen
    Widget::bwinclude ComboBox Entry .e \ 
        remove {-relief -bd -borderwidth -bg -fg} \ 
        rename {-foreground -entryfg -background -entrybg}

    # Neue Ressourcen deklarieren
    Widget::declare ComboBox {
        {-height      TkResource 0  0 listbox}
        {-values      String     "" 0}
        {-modifycmd   String     "" 0}
        {-postcommand String     "" 0}
    }

    # Ressourcen auf das Unterwidget abbilden
    Widget::addmap ComboBox "" :cmd {-background {}}
    Widget::addmap ComboBox ArrowButton .a \ 
        {-foreground {} -background {} -disabledforeground {} -state {}}

    # Optionen des Unterwidgets abgleichen
    Widget::syncoptions ComboBox Entry .e {-text {}}
    Widget::syncoptions ComboBox LabelFrame .labf {-label -text -underline {}}

    proc use {} {}
}
```

---

BEFEHL

Widget::**addmap** *class* *subclass* *subpath* *options* 
: Dieser Befehl bildet einige Ressourcen auf ein Unterwidget ab. Abgebildete Ressourcen konfigurieren das Unterwidget automatisch, wenn das Widget konfiguriert wird.

  - *class* ist die Klasse des neuen BWidget 
  - *subclass* ist die Klasse des Unterwidgets (BWidget-Klasse, zum Beispiel Entry, oder leer für ein Tk-Widget) 
  - *subpath* ist der Pfad des Unterwidgets 
  - *options* ist die Liste *{option realres ...}* der Optionen, die auf das Unterwidget abgebildet werden 


Widget::**bwinclude** *class* *subclass* *subpath* ?*arg...*? 
: Dieser Befehl nimmt in ein neues BWidget die Ressourcen eines anderen BWidget auf. Die Argumente sind:

  - *class* Klasse des neuen Widgets 
  - *subclass* Klassenname des aufzunehmenden BWidget 
  - *subpath* Pfad des Widgets, das konfiguriert wird, wenn das BWidget konfiguriert wird 
  - *options* ist: 

    - *include {option option ...}*   
  Liste der aufzunehmenden Optionen (alle, wenn nicht definiert) 
    - *remove {option option ...}*   
   Liste der zu entfernenden Optionen 
    - *rename {option name option name ...}*   
  Liste der umzubenennenden Optionen 
    - *prefix {prefix option option ...}*   
  stellt allen *option* das *prefix* voran 
    - *initialize {option value option value ...}*   
  Vorgabewert der Optionen 
    - *readonly {option value option value ...}*   
  neues Kennzeichen nur-lesbar 


Widget::**cget** *path* *option* 
:  Gibt den Wert von *option* des BWidget *path* zurück. **cget** prüft, ob die Option existiert, und gleicht sie mit dem Unterwidget ab. Wird gewöhnlich vom Befehl **cget** des BWidget aufgerufen. 


Widget::**configure** *path* *options* 
:  Beschreibungstext 


Widget::**create** *class* *path* ?*rename*? 
: Die Standardmethode, um ein BWidget zu erzeugen. Der wirkliche Widget-Pfad wird in \$path:cmd umbenannt, und eine neue Prozedur wird erzeugt, die den Pfad ersetzt und auf die Befehle des BWidget zeigt.

 Wenn *rename* false ist, wird der Pfad nicht umbenannt, die Prozedur wird aber trotzdem erzeugt. Das ist nützlich, wenn ein anderes BWidget geerbt wird, das das Widget bereits umbenannt hat.

 Der Befehl gibt den Widget-Pfad zurück. Dieser Befehl ist gewöhnlich der letzte Befehl, der im Befehl ::create des Widgets ausgeführt wird.


Widget::**declare** *class* *optlist* 
: Dieser Befehl deklariert neue Ressourcen für ein BWidget.

  - *class* ist die Klasse des neuen Widgets 
  - *options* ist die Liste, die neue Optionen beschreibt. Jede neue Option ist eine Liste **{option type value ro ?args?}**, wobei: 

    - *option* der Name der Option ist 
    - *type* der Typ der Option ist 
    - *value* der Vorgabewert der Option ist 
    - *ro* das Kennzeichen nur-lesbar der Option ist 
    - *args* vom Typ abhängt 

  
 *type* kann sein:   


**TkResource**
:  *value* von *option* bezeichnet eine Ressource eines Tk-Widgets. *args* muss *class* oder *{class realoption}* sein. *class* ist der Erzeugungsbefehl des Tk-Widgets, zum Beispiel **entry**. Die zweite Form muss verwendet werden, wenn *option* im Tk-Widget nicht denselben Namen hat, sondern *realoption*.   
  Wenn *value* leer ist, wird es mit dem Vorgabewert des Tk-Widgets initialisiert. 

**BwResource**
:  *value* von *option* bezeichnet eine Ressource eines BWidget. *args* muss *class* oder *{class realoption}* sein. *class* ist der Name des Namespace des BWidget, zum Beispiel **LabelFrame**. Die zweite Form muss verwendet werden, wenn *option* im BWidget nicht denselben Namen hat, sondern *realoption*.   
  Wenn *value* leer ist, wird es mit dem Vorgabewert des BWidget initialisiert. 

**Int**
: *value* von *option* ist eine ganze Zahl. *args* kann *{?min? ?max?}* sein, um sie in einen Bereich zu zwingen. Die Prüfung ist *\[expr \$option > \$min\] && \[expr \$option < \$max\]*, wenn args also *{0 10}* ist, muss der Wert zwischen 0 und 10 liegen, die Grenzen ausgeschlossen, wenn *args* *{=0 =10}* ist, muss der Wert zwischen 0 und 10 liegen, die Grenzen eingeschlossen. 

**Boolean**
: *value* von *option* ist ein boolescher Wert. Wahre Werte können **1**, **true** oder **yes** sein. Falsche Werte können **0**, **false** oder **no** sein. **Widget::cget** gibt immer 0 oder 1 zurück. 

**Enum**
:  *value* von *option* ist ein Element einer Aufzählung. *args* muss die Liste der Aufzählung sein, zum Beispiel *{top left bottom right}*. 

**Flag**
:  *value* von *option* ist eine Kombination aus einer Menge von Zeichen. *args* muss eine Zeichenkette sein, die die Menge definiert. 

**String**
:  

: *value* von *option* ist eine beliebige ungeprüfte Zeichenkette. 

**Synonym**
:  

: *option* ist ein Synonym der Option *args*. *value* hat hier keine Wirkung. 



Widget::**define** *class* *filename* ?*class ...*? 
:  Dieser Befehl definiert eine neue BWidget-Klasse. Er ist gewöhnlich der erste Befehl, der in einer neuen Widget-Definition ausgeführt wird. 

  - *class* ist der Name der neuen Widget-Klasse.
  - *filename* ist der Name der Datei (ohne Erweiterung) in der BWidget-Distribution, die diese Klasse definiert.

 Jede Klasse, die nach dem Dateinamen definiert wird, ist eine Klasse, von der dieses Widget abhängt. Der Befehl ::use wird für jede dieser Klassen aufgerufen, nachdem das neue Widget definiert wurde. 

 Dieser Befehl richtet die neue Klasse in mehreren Schritten ein. Zuerst erzeugt er im globalen Namespace einen Alias für den Namen der Klasse, der auf den Unterbefehl ::create der Klasse zeigt. Danach definiert er einen Unterbefehl ::use für die Klasse, mit dem andere Klassen diese Klasse bei Bedarf laden können. Zuletzt erzeugt er eine Vorgabebindung an das Ereignis \<Destroy> für die Klasse, die Widget::destroy für den Pfad aufruft. Das ist die Vorgabeeinrichtung für fast alle Widgets im Paket BWidget. 


Widget::**destroy** *path* 
:  Beschreibungstext 


Widget::**focusNext** *w* 
:  Beschreibungstext 


Widget::**focusOK** *w* 
:  Beschreibungstext 


Widget::**focusPrev** *w* 
:  Beschreibungstext 


Widget::**generate-doc** *dir* *widgetlist* 
:  Beschreibungstext 


Widget::**generate-widget-doc** *class* *iscmd* *file* 
:  Beschreibungstext 


Widget::**getoption** *path* *option* 
:  Gibt den Wert von *option* des BWidget *path* zurück. Dieser Befehl prüft nicht, ob die Option existiert, behandelt kein Synonym und gleicht nicht mit dem Unterwidget ab. 


Widget::**getVariable** *path* *varName* *?myVarName?* 
:  Macht die Variable *varName*, die zu *path* gehört, in der aktuellen Prozedur zugänglich. Die Variable wird im Widget-Namespace für *path* erzeugt und kann widgetspezifische Angaben speichern. Wenn *path* zerstört wird, wird jede so verwendete Variable mit ihm zerstört.

 Wenn *myVarName* angegeben ist, ist die Variable in der aktuellen Prozedur unter diesem Namen zugänglich.


Widget::**hasChanged** *path* *option* *pvalue* 
:  Beschreibungstext 


Widget::**init** *class* *path* *options* 
:  Beschreibungstext 


Widget::**setoption** *path* *option* *value* 
:  Setzt den Wert von *option* des BWidget *path* ohne Optionsprüfung, ohne Abbildung auf ein Unterwidget, ohne Synonymbehandlung, und setzt das Änderungskennzeichen nicht. 


Widget::**subcget** *path* *subwidget* 
:  Gibt die Liste aller Optionen und Werte des BWidget *path* zurück, die auf *subwidget* abgebildet sind. 


Widget::**syncoptions** *class* *subclass* *subpath* *options* 
: Dieser Befehl gleicht die Optionswerte eines Unterwidgets ab. Er wird verwendet, wenn eine Option eines Unterwidgets außerhalb des Befehls **configure** des BWidget geändert wird.

  - *class* ist die Klasse des neuen BWidget 
  - *subclass* ist die Klasse des Unterwidgets (BWidget-Klasse, zum Beispiel Entry, oder leer für ein Tk-Widget) 
  - *subpath* ist der Pfad des Unterwidgets 
  - *options* ist die Liste *{option realres ...}* der Optionen, die mit dem Unterwidget abgeglichen werden 


Widget::**tkinclude** *class* *tkwidget* *subpath* ?*arg...*? 
: Dieser Befehl nimmt in ein neues BWidget die Ressourcen eines Tk-Widgets auf. Die Argumente sind:

  - *class* Klasse des neuen Widgets 
  - *tkwidger* Befehlsname des aufzunehmenden Tk-Widgets 
  - *subpath* Pfad des Widgets, das konfiguriert wird, wenn das BWidget konfiguriert wird 
  - *options* ist: 

    - *include {option option ...}*   
  Liste der aufzunehmenden Optionen (alle, wenn nicht definiert) 
    - *remove {option option ...}*   
  list of options to remove 
    - *rename {option name option name ...}*   
  Liste der umzubenennenden Optionen 
    - *prefix {prefix option option ...}*   
  stellt allen *option* das *prefix* voran 
    - *initialize {option value option value ...}*   
  Vorgabewert der Optionen 
    - *readonly {option value option value ...}*   
  new readonly flag
