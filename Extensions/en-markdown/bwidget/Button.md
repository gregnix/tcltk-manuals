*NAME*
: **Button** - Button widget with enhanced options 


*CREATION*
: Button *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   [-activebackground](options.md) |   [-activeforeground](options.md) |
    |   [-anchor](options.md) |   [-background or -bg](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   -armcommand |   -command |
    |   -default |   -disarmcommand |
    |   -height |   -helptext |
    |   -helptype |   -helpvar |
    |   -name |   -relief |
    |   -state |   -underline |
    |   -width |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* invoke 


---

DESCRIPTION

 Button widget extends the Tk button with new options. [DynamicHelp](DynamicHelp.md) options, a new relief style, callback for **arm**/**disarm**, and **repeatdelay**/**repeatinterval** options has been added. 

---

WIDGET-SPECIFIC OPTIONS

**-armcommand**
:  Specifies a Tcl command to associate with the Button when mouse button 1 is pressed over the Button. When **repeatdelay** or **repeatinterval** option is positive integer, this command is repeatedly called if mouse pointer is over the Button and until mouse button 1 is released. 


**-command**
:  Specifies a Tcl command to associate with the Button. This command is typically invoked when mouse button 1 is released over the Button window. 


**-default**
:  Specifies one of three states for the default ring: **normal**, **active**, or **disabled**. In active state, the button is drawn with the platform specific appearance for a default button. In normal state, the button is drawn with the platform specific appearance for a non-default button, leaving enough space to draw the default button appearance. The normal and active states will result in buttons of the same size. In disabled state, the button is drawn with the non-default button appearance without leaving space for the default appearance. The disabled state may result in a smaller button than the active state. 


**-disarmcommand**
:  Specifies a Tcl command to associate with the Button when mouse button 1 is released. This command is called even if pointer is not over the Button, and always before the command specified by **command** option. It is typically used in conjuntion with **armcommand**, **repeatdelay** and **repeatinterval**. 


**-height**
:  Specifies a desired height for the Button. If an image or bitmap is being displayed in the Button then the value is in screen units; for text it is in lines of text. If this option isn't specified, the Button's desired height is computed from the size of the image or bitmap or text being displayed in it. 


**-helptext**
:  Text for dynamic help. If empty, no help is available for this widget. See also [DynamicHelp](DynamicHelp.md). 


**-helptype**
:  Type of dynamic help. Use *balloon* or *variable*. See also [DynamicHelp](DynamicHelp.md). 


**-helpvar**
:  Variable to use when **helptype** option is *variable*. See also [DynamicHelp](DynamicHelp.md). 


**-name**
:  Specifies a standard name for the button. If the option **\*nameName** is found in the resources database, then **text** and **underline** options are extracted from its value. 


**-relief**
:  Specifies the 3-D effect desired for the widget. Acceptable values are standard values for button relief (**raised**, **sunken**, **flat**, **ridge**, **solid**, and **groove**) and **link**, which specifies that button relief is **flat** when pointer is outside the button and **raised** when pointer is inside. 


**-state**
:  Specifies one of three states for the Button: **normal**, **active**, or **disabled**. In normal state the Button is displayed using the **foreground** and **background** options. The active state is typically used when the pointer is over the Button. In active state the Button is displayed using the **activeforeground** and **activebackground** options. Disabled state means that the Button should be insensitive: the default bindings will refuse to activate the widget and will ignore mouse button presses. In this state the **disabledforeground** and **background** options determine how the Button is displayed. 


**-underline**
:  Specifies the integer index of a character to underline in the label of the button. 0 corresponds to the first character of the text displayed, 1 to the next character, and so on.   
  The binding **\<Alt-char>** is automatically set on the toplevel of the Button to call Button::**setfocus**. 


**-width**
:  If an image or bitmap is being displayed in the Button then the value is in screen units; for text it is in characters. If this option isn't specified, the Button's desired width is computed from the size of the image or bitmap or text being displayed in it. 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **invoke** 
: If Button **state** is not disabled, this invoke the commands of the Button. Button is redisplayed with active color and sunken relief, and **armcommand** is called. Then Button is redisplayed with normal color and its defined relief, and **disarmcommand** then **command** are called.

    **invoke** is called when Button has input focus and user press the space bar.
