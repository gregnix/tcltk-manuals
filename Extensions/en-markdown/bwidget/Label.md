*NAME*
: **Label** - Label widget with **state** option, dynamic help and drag and drop facilities 


*CREATION*
: Label *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

|   |
| --- |
|   [-anchor](options.md) |
|   [-background or -bg](options.md) |
|   [-bitmap](options.md) |
|   [-borderwidth or -bd](options.md) |
|   [-cursor](options.md) |
|   [-disabledforeground](options.md) |
|   [-font](options.md) |
|   [-foreground or -fg](options.md) |
|   [-highlightbackground](options.md) |
|   [-highlightcolor](options.md) |
|   [-highlightthickness](options.md) |
|   [-image](options.md) |
|   [-justify](options.md) |
|   [-padx](options.md) |
|   [-pady](options.md) |
|   [-relief](options.md) |
|   [-takefocus](options.md) |
|   [-text](options.md) |
|   [-textvariable](options.md) |
|   [-wraplength](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: 

|   |
| --- |
|   -dragenabled |
|   -dragendcmd |
|   -dragevent |
|   -draginitcmd |
|   -dragtype |
|   -dropcmd |
|   -dropenabled |
|   -dropovercmd |
|   -droptypes |
|   -focus |
|   -height |
|   -helptext |
|   -helptype |
|   -helpvar |
|   -name |
|   -state |
|   -underline |
|   -width |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* setfocus 


---

DESCRIPTION

 The **Label** widget extends the default Tk label. Options have been added to provide visual effect depending on the state of the Label, [DynamicHelp](DynamicHelp.md) options, and [Drag ](DragSite.md) and [Drop](DropSite.md). 

---

WIDGET-SPECIFIC OPTIONS

**-dragenabled**
:  A boolean specifying if drag is enabled. 


**-dragendcmd**
:  Specifies a command to be called when drag ended. **dragendcmd** must be a command conforming to the description of the option **dragendcmd** of **DragSite::register**. 


**-dragevent**
:  Specifies the number of the mouse button associated to the drag. Must be **1**, **2** or **3**. 


**-draginitcmd**
: Specifies a command to be called when **dragevent** occurs on widget. **draginitcmd** must be a command conforming to the description of the option **draginitcmd** of **DragSite::register**.   
  If **draginitcmd** is empty, the internal **draginitcmd** command is used instead and returns:


|   |   |
| --- | --- |
| *IMAGE {copy} \<image name>*  | if an image is displayed.  |


Note that if **dragtype** option is not empty, its value is used instead of those above.


**-dragtype**
:  Specifies an alternate type of dragged object. 


**-dropcmd**
: Specifies a command to be called when drop occurs on the widget. **dropcmd** must be a command conforming to the description of the option **dropcmd** of **DropSite::register**.   
  If **dropcmd** is empty, the command updates the label following the type of the data:


|   |   |
| --- | --- |
| *COLOR* or *FGCOLOR* | reconfigure the **foreground** of the Label. |
| *BGCOLOR* | reconfigure the **background** of the Label. |
| *IMAGE* | reconfigure the Label to display the associated image. |
| *BITMAP* | reconfigure the Label to display the associated bitmap. **image** option is set to empty. |
| *TEXT*,   or any other tag | reconfigure the Label to display the associated string. **image** and **bitmap** options are set to empty. |


and returns 1.


**-dropenabled**
:  A boolean specifying if drop is enabled. 


**-dropovercmd**
:  Specifies a command to be called when drag icon is over the widget. **dropovercmd** must be a command conforming to the description of the option **dropovercmd** of **DropSite::register**.   
  If **dropovercmd** is empty, Label always accepts the drop if data type is *FGCOLOR*, *COLOR*, *BGCOLOR*, and accepts all other data type only if **state** is normal. 


**-droptypes**
:  Specifies a list of accepted dropped object/operation. See option **droptypes** of **DropSite::register**. for more infromation. Default accepts *FGCOLOR*, *COLOR*, *BGCOLOR*, *TEXT*, *BITMAP* and *IMAGE*, all with **copy** and **move** operations. 


**-focus**
:  Specifies a pathname to set the focus on for Label::**setfocus** command. 


**-height**
:  Specifies a desired height for the label. If an image or bitmap is being displayed in the label then the value is in screen units, for text it is in lines of text. If this option isn't specified, the label's desired height is computed from the size of the image or bitmap or text being displayed in it. 


**-helptext**
:  Text for dynamic help. If empty, no help is available for this widget. See also [DynamicHelp](DynamicHelp.md). 


**-helptype**
:  Type of dynamic help. Use *balloon* or *variable*. See also [DynamicHelp](DynamicHelp.md). 


**-helpvar**
:  Variable to use when **helptype** option is *variable*. See also [DynamicHelp](DynamicHelp.md). 


**-name**
:  Specifies a standard name for the label. If the option **\*nameName** is found in the resource database, then **text** and **underline** options are extracted from its value. 


**-state**
:  Specifies one of two states for the Label: **normal** or **disabled**. In normal state the text of the Label is displayed using the **foreground** option. In disabled state the text of the Label is displayed using the **disabledforeground** option. 


**-underline**
:  Specifies the integer index of a character to underline in the label. 0 corresponds to the first character of the text displayed, 1 to the next character, and so on.   
  The binding **\<Alt-char>** is automatically set on the toplevel of the Label to call Label::**setfocus**. 


**-width**
:  Specifies a desired width for the label. If an image or bitmap is being displayed in the label then the value is in screen units, for text it is in characters. If this option isn't specified, the label's desired width is computed from the size of the image or bitmap or text being displayed in it. 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **setfocus** 
:  Set the focus on the pathname given by **-focus** option if **-state** is *normal*.
