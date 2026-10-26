*NAME*
: **StatusBar** - status bar widget 


*CREATION*
: StatusBar *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

|   |   |
| --- | --- |
|   [-background or -bg](options.md) |   [-borderwidth or -bd](options.md) |
|   [-foreground or -fg](options.md) |   [-orient](options.md) |
|   [-relief](options.md) |
|   [-troughcolor](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: 

|   |
| --- |
|   -height |
|   -showresize |
|   -ipad |
|   -pad |
|   -width  |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

DESCRIPTION

 StatusBar widget is a simple container widget with a corner resize control, meant to be placed at the bottom of a toplevel dialog. 

---

WIDGET-SPECIFIC OPTIONS

**-height**
:  Specifies the desired height for the widget. 


**-showresize**
:  Specifies whether to show the corner resize control. 


**-pad**
:  The spacing to place around the status bar. 


**-ipad**
:  The spacing to place around individual status bar items. 


**-width**
:  Specifies the desired width for the widget. 


---

WIDGET COMMAND

*pathName* **add** **widget** ?*option* *value* *option* *value* ...? 
: Add a widget to the status bar. Possible options are:

**-weight**
: Weighting of this item for resizing (passed to **grid**).

**-separator**
: Whether to use a separator for this item.

**-sticky**
: Passed on to grid.

**-pad**
: Override of the widget's **-ipad** option for this item.



*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **delete** **widget** ?*widget* ...? 
:  Delete a widget and associated state from the status bar.


*pathName* **getframe** 
:  Get the frame widget for the status bar in which status bar items should be created.


*pathName* **items** 
: List of items in the status bar.
