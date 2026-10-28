*NAME*
: **ScrollView** - Display the visible area of a scrolled window 


*CREATION*
: ScrollView *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   [-background or -bg](options.md) |   [-borderwidth or -bd](options.md) |
    |   [-cursor](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |
    | --- |
    |   -fill |
    |   -height |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

DESCRIPTION

 ScrollView displays the visible area of a scrolled window within its scroll region. 

---

WIDGET-SPECIFIC OPTIONS

**-fill**
:  Specifies the fill color of the rectangle. 


**-foreground**
:  Specifies the color of the border of the rectangle. 


**-height**
:  Specifies the desired height for the ScrollView. 


**-width**
:  Specifies the desired width for the ScrollView. 


**-window**
:  Specifies the window to view. This widget must have **-xscrollcommand** and **-yscrollcommand** options, and respond to **xview** and **yview** command. In order to make ScrollView working with other scrollbar, **-xscrollcommand** and **-yscrollcommand** options of the widget must be set before the widget is passed to the **-window** option of the ScrollView (for example, if the widget is handled by a ScrolledWindow, call **setwidget** before setting **-window** option). 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


---

BINDINGS
