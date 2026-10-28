*NAME*
: **ScrollableFrame** - Scrollable frame containing widget 


*CREATION*
: ScrollableFrame *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   [-background or -bg](options.md) |   [-xscrollcommand](options.md) |
    |   [-yscrollcommand](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |
    | --- |
    |   -areaheight |
    |   -areawidth |
    |   -constrainedheight |
    |   -constrainedwidth |
    |   -height |
    |   -width |
    |   -xscrollincrement |
    |   -yscrollincrement |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe 

: *pathName* see *widget* ?*vert*? ?*horz*? 

: *pathName* xview ?*arg...*? 

: *pathName* yview ?*arg...*? 


---

DESCRIPTION

 ScrollableFrame widget containing widget. 

---

WIDGET-SPECIFIC OPTIONS

**-areaheight**
:  Specifies the height for the scrollable area. If zero, then the height of the scrollable area is made just large enough to hold all its children. 


**-areawidth**
:  Specifies the width for the scrollable area. If zero, then the width of the scrollable area window is made just large enough to hold all its children. 


**-constrainedheight**
:  Specifies whether or not the scrollable area should have the same height of the scrolled window. If true, vertical scrollbar is not needed. 


**-constrainedwidth**
:  Specifies whether or not the scrollable area should have the same width of the scrolled window. If true, horizontal scrollbar is not needed. 


**-height**
:  Specifies the desired height for the window in pixels. 


**-width**
:  Specifies the desired width for the window in pixels. 


**-xscrollincrement**
:  See **xscrollincrement** option of **canvas** widget. 


**-yscrollincrement**
:  See **yscrollincrement** option of **canvas** widget. 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **getframe** 
:  Return the pathname of the scrolled frame where widget should be created. 


*pathName* **see** *widget* ?*vert*? ?*horz*? 
:  Arrange scrollable area to make *widget* visible in the window. *vert* and *horz* specify which part of *widget* must be preferably visible, in case where *widget* is too tall or too large to be entirely visible. *vert* must be **top** (the default) or **bottom**, and *horz* must be **left** (the default) or **right**. If *vert* or *horz* is not a valid value, area is not scrolled in this direction. 


*pathName* **xview** ?*arg...*? 
:  Standard command to enable horizontal scrolling of *pathName*. 


*pathName* **yview** ?*arg...*? 
:  Standard command to enable vertical scrolling of *pathName*.
