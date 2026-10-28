*NAME*
: **PanelFrame** - Frame with a boxed title area 


*CREATION*
: PanelFrame *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   [-background or -bg](options.md) |   [-borderwidth or -bd](options.md) |
    |   [-text](options.md) |
    |   [-textvariable](options.md) |
    |   [-font](options.md) |   [-relief](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   -height |
    |   -width |
    |   -panelbackground |   -panelforeground |
    |   -ipad |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

DESCRIPTION

 PanelFrame creates a frame area with a boxed title area. The boxed title area contains a label ands allows for other items to be placed in it. This can serve like a mini-toolbar. 

---

WIDGET-SPECIFIC OPTIONS

**-height**
:  Specifies the desired height for the widget. 

**-ipad**
:  The spacing to place around individual panel area items. 

**-panelbackground**
:  The color for the panel area background. Defaults to the selection highlight background color. 

**-panelforeground**
:  The color for the title text. Defaults to the selection highlight foreground color. 

**-width**
:  Specifies the desired width for the widget. 


---

WIDGET COMMAND

*pathName* **add** **widget** ?*option* *value* *option* *value* ...? 
: Add a widget to the panel. Widgets are **pack**ed in. Possible options are:

    **-side**
    : Side to place item on (defaults to **right**).

    **-fill**
    : Whether to fill space (defaults to **none**).

    **-expand**
    : Whether to expand space (defaults to **0**).

    **-pad**
    : Override of the widget's **-ipad** option for this item.


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **delete** **widget** ?*widget* ...? 
:  Delete a widget and associated state from the panel.


*pathName* **getframe** 
:  Get the frame widget for the status bar in which status bar items should be created.


*pathName* **items** 
: List of items in the status bar.
