*NAME*
: **ScrolledWindow** - Generic scrolled widget 


*CREATION*
: ScrolledWindow *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   [-background or -bg](options.md) |   [-borderwidth or -bd](options.md) |
    |   [-relief](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |
    | --- |
    |   -auto |
    |   -ipad |
    |   -managed |
    |   -scrollbar |
    |   -sides |
    |   -size |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe 

: *pathName* setwidget *widget* 


---

DESCRIPTION

 ScrolledWindow enables user to create easily a widget with its scrollbar. Scrollbars are created by ScrolledWindow and scroll commands are automatically associated to a scrollable widget with **ScrolledWindow::setwidget**. 

---

WIDGET-SPECIFIC OPTIONS

**-auto**
:  Specifies the desired auto managed scrollbar: none means scrollbar are always drawn horizontal means horizontal scrollbar is drawn as needed vertical means vertical scrollbar is drawn as needed both means horizontal and vertical scrollbars are drawn as needed (default value) 


**-ipad (read-only)**
:  Padding in pixels between client widget and scrollbars. Default value: **1**. 


**-managed (read-only)**
:  If true, scrollbar are managed during creation, so their size are included in the requested size of the ScrolledWindow. If false, they are not. Default value: **true**. 


**-scrollbar**
:  Specifies the desired scrollbar: **none**, **horizontal**, **vertical** or **both** (default value). 


**-sides (read-only)**
:  Side of the scrollbars. Possible values are: **ne**, **en**, **nw**, **wn**, **se** (default value), **es**, **sw**, **ws**. 


**-size (read-only)**
:  Size of the scrollbars in pixels. Use 0 for standard size (default value). 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **getframe** 
:  Return the pathname of the frame where the scrolled widget should be created. This command is no longer needed. You can directly create the scrolled widget as the child of *pathName*. 


*pathName* **setwidget** *widget* 
:  Associate *widget* to the the scrollbars. *widget* becomes managed by the ScrolledWindow. The user should not attempt to manage *widget* until it is no longer managed by the ScrolledWindow. *widget* must be a scrollable widget, i.e. have the options **xscrollcommand**/**yscrollcommand** and the command **xview**/**yview**, such as canvas or text.
