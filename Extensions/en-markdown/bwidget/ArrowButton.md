*NAME*
: **ArrowButton** - Button widget with an arrow shape. 


*CREATION*
: ArrowButton *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

|   |   |
| --- | --- |
|   [-activebackground](options.md) |
|   [-activeforeground](options.md) |
|   [-background or -bg](options.md) |   [-borderwidth or -bd](options.md) |
|   [-disabledforeground](options.md) |
|   [-foreground or -fg](options.md) |
|   [-highlightbackground](options.md) |
|   [-highlightcolor](options.md) |
|   [-highlightthickness](options.md) |
|   [-relief](options.md) |
|   [-repeatdelay](options.md) |
|   [-repeatinterval](options.md) |
|   [-takefocus](options.md) |
|   [-troughcolor](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: 

|   |
| --- |
|   -armcommand |
|   -arrowbd |
|   -arrowrelief |
|   -clean |
|   -command |
|   -dir |
|   -disarmcommand |
|   -height |
|   -helptext |
|   -helptype |
|   -helpvar |
|   -ipadx |
|   -ipady |
|   -state |
|   -type |
|   -width |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* invoke 


---

DESCRIPTION

 ArrowButton can be of two types following **type** option: for **button** type, it is standard button with an arrow drawn on it; for **arrow** type, it is an arrow like scrollbar's arrow. 

---

WIDGET-SPECIFIC OPTIONS

**-armcommand**
:  Specifies a Tcl command to associate with the ArrowButton when mouse button 1 is pressed over the ArrowButton. When **repeatdelay** or **repeatinterval** option is positive integer, this command is repeatedly called if mouse pointer is over the button and until mouse button 1 is released. 


**-arrowbd**
:  When ArrowButton **type** is *arrow*, specifies the border width of the arrow. Must be 1 or 2. 


**-arrowrelief**
:  When ArrowButton **type** is *arrow*, specifies the relief of the arrow. Must be **raised** or **sunken**. 


**-clean**
:  Specifies a level of quality, between 0 and 2, for the arrow. If 0, the arrow is drawn with its maximum width and height. If 1, the base of arrow is arranged to be odd to have same edges. If 2, the base of arrow is arranged to be odd and the orthogonal to be (base+1)/2 to have 'straight' diagonal for edges. 


**-command**
:  Specifies a Tcl command to associate with the ArrowButton. This command is typically invoked when mouse button 1 is released over the ArrowButton window. 


**-dir**
:  Specifies the direction of the arrow: **top**, **bottom**, **left** or **right**. 


**-disarmcommand**
:  Specifies a Tcl command to associate with the ArrowButton when mouse button 1 is released. This command is called even if pointer is not over the ArrowButton, and always before the command specified by **command** option. It is typically used in conjuntion with **armcommand**, **repeatdelay** and **repeatinterval**. 


**-height**
:  Specifies a desired height for the ArrowButton. The value is in screen units. 


**-helptext**
:  Text for dynamic help. If empty, no help is available for this widget. See also [DynamicHelp](DynamicHelp.md). 


**-helptype**
:  Type of dynamic help. Use *balloon* or *variable*. See also [DynamicHelp](DynamicHelp.md). 


**-helpvar**
:  Variable to use when **helptype** option is *variable*. See also [DynamicHelp](DynamicHelp.md). 


**-ipadx**
:  Specifies a minimun pad between the ArrowButton border and the right and left side of the arrow. The value is in screen units. 


**-ipady**
:  Specifies a minimun pad between the ArrowButton border and the top and bottom side of the arrow. The value is in screen units. 


**-state**
: Specifies one of three states for the ArrowButton: **normal**, **active**, or **disabled**.

If ArrowButton **type** is *button*:
: In normal state the ArrowButton is displayed using the **foreground** and **background** options. The active state is typically used when the pointer is over the ArrowButton. In active state the ArrowButton is displayed using the **activeforeground** and **activebackground** options. In disabled state the **disabledforeground** and **background** options determine how the ArrowButton is displayed. 

If ArrowButton **type** is *arrow*:
: Only colors of arrow change. The background of ArrowButton is always displayed using **troughcolor** option. In normal state the ArrowButton is displayed using the **background** option. The active state is typically used when the pointer is over the ArrowButton. In active state the ArrowButton is displayed using the **activebackground** option. In disabled state the ArrowButton is displayed with a dark stipple. 


Disabled state means that the ArrowButton should be insensitive: the default bindings will refuse to activate the widget and will ignore mouse button presses.


**-type**
:  Determines the type of the ArrowButton: **button** for standard button look, or **arrow** scrollbar's arrow look. 


**-width**
:  Specifies a desired width for the ArrowButton. The value is in screen units. 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **invoke** 
: If ArrowButton **state** is not disabled, this invoke the commands of the button. ArrowButton is redisplayed with active color and sunken relief, and **armcommand** is called. Then ArrowButton is redisplayed with normal color and its defined relief, and **disarmcommand** then **command** are called.

**invoke** is called when ArrowButton has input focus and user press the space bar.
