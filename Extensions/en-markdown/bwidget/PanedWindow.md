*NAME*
: **PanedWindow** - Tiled layout manager widget 


*CREATION*
: PanedWindow *pathName* ?*option value...*?


*STANDARD OPTIONS*
: [-background or -bg](options.md)


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   -activator |   -pad |
    |   -side |   -weights |
    |   -width |


*WIDGET COMMAND*
: *pathName* add ?*option value...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe *index* 


---

DESCRIPTION

 PanedWindow is a widget that lays out children in a vertically or horizontally tiled format. The user can adjust the size of the panes, with a pane control sash created between children. 

---

WIDGET-SPECIFIC OPTIONS

**-activator (read-only)**
:  By default, the control sash is either a button or a line depending upon the underlying operating system. This sash may be explicitly set using this option. If set to **line** then the sash consists of just a dividing line. Otherwise if set to **button** then it constists of a knob that can be dragged. 


**-pad (read-only)**
:  Specifies additional space between the button of the sash and children. 


**-side (read-only)**
:  Specifies the side of the sash, which implies the layout: **top** or **bottom** (horizontal layout), **left** or **right** (vertical layout). 


**-weights (read-only)**
:  Specifies how the weights specified when adding panes should be used. Must be **extra** or **available**. When using *extra*, only extra space is devided among the diffferent panes relative to their weight. When using *available*, all space is devided among the diffferent panes relative to their weight. Default value for **weights** is *extra*. 


**-width (read-only)**
:  Specifies the width of the button of the sash. This option is ignored if the activator is set to **line**. 


---

WIDGET COMMAND

*pathName* **add** ?*option value...*? 
: This command add a new pane. The new pane is placed below the previous pane for vertical layout or at right for horizontal layout. This command returns a frame where user can place its widget. Valid options are:

    **-minsize**
    :  Specifies the minimum size requested for the pane. See the **grid** command for more information. 

    **-weight**
    :  Specifies the relative weight for apportioning any extra spaces among panes. See the **grid** command for more information. 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **getframe** *index* 
:  Returns the pathname of the *index*th added pane.
