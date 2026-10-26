*NAME*
: **ButtonBox** - Set of buttons with horizontal or vertical layout 


*CREATION*
: ButtonBox *pathName* ?*option value...*?


*WIDGET-SPECIFIC OPTIONS*
: 

|   |   |
| --- | --- |
|   -background or -bg |   -default |
|   -homogeneous |
|   -orient |
|   -padx |
|   -pady |
|   -spacing |
|   -state |


*WIDGET COMMAND*
: *pathName* add ?*option value...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* delete *index* 

: *pathName* index *index* 

: *pathName* insert *index* ?*option value...*? 

: *pathName* invoke *index* 

: *pathName* itemcget *index* *option* 

: *pathName* itemconfigure *index* ?*option*? ?*value* *option* *value* ...? 

: *pathName* setfocus *index* 


---

DESCRIPTION

 ButtonBox layouts Button horizontally or vertically. Some commands take an *index* as argument indicating on which Button it work. This index may be specified in any of the following forms: 

 

 *number* 
:  Specifies the Button numerically, where 0 corresponds to the first added Button, 1 to the next, and so on. 

 **end** or **last** 
:  Indicates the last item added. 

**default** 
:  Indicates the default Button. 

 *name* 
:  Indicates the button whose **-name** option is *name*. 

 *text* 
:  Indicates the button whose **-text** option is *text*. 


---

WIDGET-SPECIFIC OPTIONS

**-background**
:  Specifies a default background color for all added buttons and for the frame. 


**-default**
:  Specifies the default button of the button box. The value is an integer referencing the n-th added button, starting from 0. If this value is -1 (the default), all button wil be drawn with their -default option set to disabled, and this value can not be changed.   
  If this value is not -1, the associated button is drawn with -default option set to active and the others are drawn with -default option set to normal. The value can be changed by configure. 


**-homogeneous (read-only)**
:  Specifies wether or not buttons must have the same width for horizontal layout. 


**-orient (read-only)**
:  Specifies the orientation of the button box. If this option is **horizontal** (the default), buttons are added from top to bottom. If this option is **vertical**, buttons are added from left to right. 


**-padx**
:  Specifies a default value for the -padx option of all added buttons. 


**-pady**
:  Specifies a default value for the -pady option of all added buttons. 


**-spacing**
:  Specifies the default spacing between buttons. This value can be changed before each call to **add**. 


**-state**
:  Specifies a state for all the buttons in the button box. Can be any state supported by buttons. 


---

WIDGET COMMAND

*pathName* **add** ?*option value...*? 
: Add a button to the button box.

 See [Button](Button.md) for description of options. 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **delete** *index* 
:  Delete the button at *index* from the button box. 


*pathName* **index** *index* 
:  Return the numerical index corresponding to the item. 


*pathName* **insert** *index* ?*option value...*? 
:  Insert a new button into the button box before the given index. 


*pathName* **invoke** *index* 
:  Invoke the Button given by *index*. 


*pathName* **itemcget** *index* *option* 
:  Returns the current value of a configuration option for the item. *Option* may have any of the values accepted by the item creation command. 


*pathName* **itemconfigure** *index* ?*option*? ?*value* *option* *value* ...? 
:  This command is similar to the **configure** command, except that it applies to the options for an individual item, whereas **configure** applies to the options for the widget as a whole. **Options** may have any of the values accepted by the item creation widget command. If options are specified, options are modified as indicated in the command and the command returns an empty string. If no options are specified, returns a list describing the current options for the item. Read-only options are not be modified. 


*pathName* **setfocus** *index* 
:  Set the focus to the Button given by *index*.
