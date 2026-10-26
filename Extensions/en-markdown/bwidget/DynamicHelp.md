*NAME*
: **DynamicHelp** - Provide help to Tk widget or BWidget 


*COMMAND*
: DynamicHelp::add *widget* ?*option value ...*? 

: DynamicHelp::configure ?*option*? ?*value* *option* *value* ...? 

: DynamicHelp::delete *widget* 

: DynamicHelp::include *class* *type* 

: DynamicHelp::register *path* *type* ?*arg...*? 

: DynamicHelp::sethelp *path* *subpath* ?*force*? 


---

DESCRIPTION

 Description text 

---

COMMAND

DynamicHelp::**add** ?*option value ...*? 
:  This command adds dynamic help to the given *widget*. 

**-command**
:  If specified, refers to a command to execute to get the help text to display. The command must return a string to display. If the command returns an empty string, no help is displayed. 


**-index**
:  If specified, refers to a menu index to bind the help to instead of a widget. If **-type** is not menu, this option is ignored. 


**-item**
:  If specified, refers to an item or tag on a canvas widget or to a tag in a text widget to bind the help to instead of to a widget. 


**-type**
:  Specifies the type of help. Can be: **balloon**, **variable** or **menu**. Default is **balloon**. 


**-text**
:  The text to be displayed as help. 


**-variable**
:  Specifies a variable name to which the help string will be written. Some other widget (e.g., a status bar) is responsible for displaying this variable. 


 Creating dynamic help for a menu is a two-step process. The menu itself must first be added and then each menu entry must be added separately. Here is a brief example. 

```
    # create menu
    menu .m -type menubar
    # associate menubar to toplevel BEFORE DynamicHelp::register
    # to make it works with menu clone name
    . configure -menu .m
    .m add cascade -label "File" -menu .m.file
    menu .m.file
    .m.file add command -label "Open..."
    .m.file add command -label "Quit"
    # create label for help, using variable varinfo
    label .l -textvariable varinfo
    # associate all entries of menu .m.file to variable varinfo
    DynamicHelp::add .m.file -type menu -variable varinfo
    # then declare entries of .m.file
    DynamicHelp::add .m.file -type menu -index 0 -text "Detach menu"
    DynamicHelp::add .m.file -type menu -index 1 -text "Open a file"
    DynamicHelp::add .m.file -type menu -index 2 -text "Exit demo"
```


DynamicHelp::**configure** ?*option*? ?*value* *option* *value* ...? 
: This command configure the ballon help.

**-borderwidth**
:  Width of the black border around the balloon. 


**-delay**
:  Define the delay in millisecond of mouse inactivity before displaying the balloon. 


**-state**
:  Specifies one of two states for help balloons: **normal** and **disabled**. 

:  If **state** is **disabled**, help balloons will not be displayed for any registered widget. 


**-topbackground**
:  The background color of the toplevel window created for a balloon. 


  
Other standard options are:

|   |   |
| --- | --- |
|   [-background or -bg](options.md) |   [-font](options.md) |
|   [-foreground or -fg](options.md) |   [-justify](options.md) |
|   [-padx](options.md) |   [-pady](options.md) |


DynamicHelp::**delete** *widget* 
:  Delete all dynamic help for the given *widget*. 


DynamicHelp::**include** *class* *type* 
:  Description text 


DynamicHelp::**register** *path* *type* ?*arg...*? 
:  **Its use is deprecated. Use DynamicHelp::add instead.** 

Register a help text to the widget *path*. *type* determines the type of the help or the type of the widget. Depending on *type*, other options must be provided.   


|   |   |
| --- | --- |
|  **type**  |  **options**  |
|  **balloon**  |  *?tagOrItem? text*  |
|  **variable**  |  *?tagOrItem? varName text*  |
|  **menu**  |  *varName*  |
|  **menuentry**  |  *index text*  |

  
If one of the option is missing or is empty, help is removed for this widget.

 If *tagOrItem* is specified, then *path* is a canvas or a text. In case of a canvas, *tagOrItem* is the name of a tag or item on the canvas to which the help will be bound. In case of a text, *tagOrItem* is the name of a tag on the text to which the help will be bound. 

For type other than *balloon*, *varName* is typically a variable linked to a label.   
For menu, balloon type help is not available. To declare a help for menu, you first declare the menu, and then entries of this menu.   
For example:   
  
  # create menu menu .m -type menubar # associate menubar to toplevel BEFORE DynamicHelp::register # to make it works with menu clone name . configure -menu .m .m add cascade -label "File" -menu .m.file menu .m.file .m.file add command -label "Open..." .m.file add command -label "Quit" # create label for help, using variable varinfo label .l -textvariable varinfo # associate all entries of menu .m.file to variable varinfo DynamicHelp::register .m.file menu varinfo # then declare entries of .m.file DynamicHelp::register .m.file menuentry 0 "Detach menu" DynamicHelp::register .m.file menuentry 1 "Open a file" DynamicHelp::register .m.file menuentry 2 "Exit demo"    
   
Notice that if popup menu is owned by a menubar, you must associate first the menubar to its toplevel. In this case, when you create a menu popup, its clone window is also created, and DynamicHelp::register detects the exitence of the clone window and maps events to it.


DynamicHelp::**sethelp** *path* *subpath* ?*force*? 
:  Description text
