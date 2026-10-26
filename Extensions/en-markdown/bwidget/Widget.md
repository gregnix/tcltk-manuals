

Under construction ...

*NAME*
: **Widget** - The Widget base class 


*COMMAND*
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

DESCRIPTION

 The **Widget** namespace handle data associated to all BWidget and provide commands to easily define BWidget.   
For commands can be used to define a BWidget: **tkinclude**, **bwinclude**, **declare**, **addmap** and **syncoptions**. Here is the definition of [ComboBox](ComboBox.md) widget:   
  
  

```
namespace eval ComboBox {
    # We're using ArrowButton, Entry and LabelFrame
    ArrowButton::use
    Entry::use
    LabelFrame::use

    # Include resources of LabelFrame
    Widget::bwinclude ComboBox LabelFrame .labf \ 
        rename     {-text -label} \ 
        remove     {-focus} \ 
        prefix     {label -justify -width -anchor -height -font} \ 
        initialize {-relief sunken -borderwidth 2}

    # Include resources of Entry
    Widget::bwinclude ComboBox Entry .e \ 
        remove {-relief -bd -borderwidth -bg -fg} \ 
        rename {-foreground -entryfg -background -entrybg}

    # Declare new resources
    Widget::declare ComboBox {
        {-height      TkResource 0  0 listbox}
        {-values      String     "" 0}
        {-modifycmd   String     "" 0}
        {-postcommand String     "" 0}
    }

    # Map resources to subwidget
    Widget::addmap ComboBox "" :cmd {-background {}}
    Widget::addmap ComboBox ArrowButton .a \ 
        {-foreground {} -background {} -disabledforeground {} -state {}}

    # Synchronize subwidget options
    Widget::syncoptions ComboBox Entry .e {-text {}}
    Widget::syncoptions ComboBox LabelFrame .labf {-label -text -underline {}}

    proc use {} {}
}
```

---

COMMAND

Widget::**addmap** *class* *subclass* *subpath* *options* 
: This command map some resources to subwidget. Mapped resources automatically configure subwidget when widget is configured.

  - *class* is the class of the new BWidget 
  - *subclass* is the class the subwidget (BWidget class, e.g Entry, or empty for Tk widget) 
  - *subpath* is the path of the subwidget 
  - *options* is the list *{option realres ...}* of options to map to subwidget 


Widget::**bwinclude** *class* *subclass* *subpath* ?*arg...*? 
: This command includes into a new BWidget the resources of another BWidget. Arguments are:

  - *class* class of the new widget 
  - *subclass* class name of the BWidget to be included 
  - *subpath* path of the widget to configure when BWidget is configured 
  - *options* is: 

    - *include {option option ...}*   
  list of options to include (all if not defined) 
    - *remove {option option ...}*   
   list of options to remove 
    - *rename {option name option name ...}*   
  list of options to rename 
    - *prefix {prefix option option ...}*   
  pefix all *option* by *prefix* 
    - *initialize {option value option value ...}*   
  default value of options 
    - *readonly {option value option value ...}*   
  new readonly flag 


Widget::**cget** *path* *option* 
:  Returns the value of *option* of BWidget *path*. **cget** tests the option existence and takes care of synchronization with subwidget. Typically called by the BWidget **cget** command. 


Widget::**configure** *path* *options* 
:  Description text 


Widget::**create** *class* *path* ?*rename*? 
: The standard method for creating a BWidget. The real widget path is renamed to \$path:cmd, and a new proc is created to replace the path which points to the BWidget's commands.

 If *rename* is false, the path will not be renamed, but the proc will still be created. This is useful when inheriting another BWidget who will already have renamed the widget. 

 The command returns the widget path. This command is usually the last command executed in the ::create command for the widget. 


Widget::**declare** *class* *optlist* 
: This command declare new resources for a BWidget.

  - *class* is class of the new widget 
  - *options* is the list describing new options. Each new option is a list **{option type value ro ?args?}** where: 

    - *option* is the name of the option 
    - *type* is the type of the option 
    - *value* is the default value of the option 
    - *ro* is the readonly flag of the option 
    - *args* depends on type 

  
 *type* can be:   


**TkResource**
:  *value* of *option* denotes a resource of a Tk widget. *args* must be *class* or *{class realoption}*. *class* is the creation command of the Tk widget, e.g. **entry**. The second form must be used if *option* has not the same name in Tk widget, but *realoption*.   
  If *value* is empty, it is initialized to the default value of the Tk widget. 

**BwResource**
:  *value* of *option* denotes a resource of a BWidget. *args* must be *class* or *{class realoption}*. *class* is the name of the namespace of the BWidget, e.g. **LabelFrame**. The second form must be used if *option* has not the same name in BWidget, but *realoption*.   
  If *value* is empty, it is initialized to the default value of the BWidget. 

**Int**
: *value* of *option* is an integer. *args* can be *{?min? ?max?}* to force it to be in a range. The test is *\[expr \$option > \$min\] && \[expr \$option < \$max\]* so if args is *{0 10}*, value must be beetween 0 and 10 exclude, if *args* is *{=0 =10}* , value must be beetween 0 and 10 include. 

**Boolean**
: *value* of *option* is a boolean. True values can be **1**, **true** or **yes**. False values can be **0**, **false** or **no**. **Widget::cget** always return 0 or 1. 

**Enum**
:  *value* of *option* is a element of a enumeration. *args* must be the list of enumeration, e.g. *{top left bottom right}*. 

**Flag**
:  *value* of *option* is a combination of a set of chars. *args* must be a string defining the set. 

**String**
:  

: *value* of *option* is any uncontrolled string. 

**Synonym**
:  

: *option* is a synonym of option *args*. *value* has no effect here. 



Widget::**define** *class* *filename* ?*class ...*? 
:  This command is used to define a new BWidget class. It is usually the first command executed in a new widget definition. 

  - *class* is the name of the new widget class.
  - *filename* is the name of the file (without extension) in the BWidget distribution that defines this class.

 Each class defined after the filename is a class that this widget depends on. The ::use command will be called for each of these classes after the new widget has been defined. 

 This command does several things to setup the new class. First, it creates an alias in the global namespace for the name of the class that points to the class's ::create subcommand. Second, it defines a ::use subcommand for the class which other classes can use to load this class on the fly. Lastly, it creates a default binding to the \<Destroy> event for the class that calls Widget::destroy on the path. This is the default setup for almost all widgets in the BWidget package. 


Widget::**destroy** *path* 
:  Description text 


Widget::**focusNext** *w* 
:  Description text 


Widget::**focusOK** *w* 
:  Description text 


Widget::**focusPrev** *w* 
:  Description text 


Widget::**generate-doc** *dir* *widgetlist* 
:  Description text 


Widget::**generate-widget-doc** *class* *iscmd* *file* 
:  Description text 


Widget::**getoption** *path* *option* 
:  Returns the value of *option* of BWidget *path*. This command does not test option existence, does not handle synonym and does not take care of synchronization with subwidget. 


Widget::**getVariable** *path* *varName* *?myVarName?* 
:  Make the variable *varName* relational to *path* accessible in the current procedure. The variable will be created in the widget namespace for *path* and can be used for storing widget-specific information. When *path* is destroyed, any variable accessed in this manner will be destroyed with it. 

 If *myVarName* is specified, the variable will be accessible in the current procedure as that name. 


Widget::**hasChanged** *path* *option* *pvalue* 
:  Description text 


Widget::**init** *class* *path* *options* 
:  Description text 


Widget::**setoption** *path* *option* *value* 
:  Set the value of *option* of BWidget *path* without option test, subwidget mapping, synonym handling and does not set the modification flag. 


Widget::**subcget** *path* *subwidget* 
:  Returns the list of all option/value of BWidget *path* that are mapped to *subwidget*. 


Widget::**syncoptions** *class* *subclass* *subpath* *options* 
: This command synchronize options value of a subwidget. Used when an option of a subwidget is modified out of the BWidget **configure** command.

  - *class* is the class of the new BWidget 
  - *subclass* is the class the subwidget (BWidget class, e.g Entry, or empty for Tk widget) 
  - *subpath* is the path of the subwidget 
  - *options* is the list *{option realres ...}* of options to synchronize with subwidget 


Widget::**tkinclude** *class* *tkwidget* *subpath* ?*arg...*? 
: This command includes into a new BWidget the resources of a Tk widget. Arguments are:

  - *class* class of the new widget 
  - *tkwidger* command name of the Tk widget to be included 
  - *subpath* path of the widget to configure when BWidget is configured 
  - *options* is: 

    - *include {option option ...}*   
  list of options to include (all if not defined) 
    - *remove {option option ...}*   
  list of options to remove 
    - *rename {option name option name ...}*   
  list of options to rename 
    - *prefix {prefix option option ...}*   
  pefix all *option* by *prefix* 
    - *initialize {option value option value ...}*   
  default value of options 
    - *readonly {option value option value ...}*   
  new readonly flag
