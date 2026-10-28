*NAME*
: **Dialog** - Dialog abstraction with custom buttons 


*CREATION*
: Dialog *pathName* ?*option value...*?


*OPTIONS from ButtonBox*
: 

    |   |   |
    | --- | --- |
    |   -background or -bg |   -homogeneous |
    |   -padx |   -pady |
    |   -spacing |


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |
    | --- |
    |   -anchor |
    |   -bitmap |
    |   -cancel |
    |   -default |
    |   -geometry |
    |   -image |
    |   -modal |
    |   -parent |
    |   -place |
    |   -separator |
    |   -side |
    |   -title |
    |   -transient |


*WIDGET COMMAND*
: *pathName* add ?*arg...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* draw ?*focus*? 

: *pathName* enddialog *result* 

: *pathName* getframe 

: *pathName* invoke *index* 

: *pathName* itemcget *index* *option* 

: *pathName* itemconfigure *index* ?*option*? ?*value* *option* *value* ...? 

: *pathName* setfocus *index* 

: *pathName* withdraw 


---

DESCRIPTION

 Dialog widget enables the user to create a dialog box. Some commands take an *index* as argument indicating on which Button it work. This index is the same specified for equivalent ButtonBox command: 

 

 *number* 
:  Specifies the Button numerically, where 0 corresponds to the first added Button, 1 to the next, and so on. 

 **end** or **last** 
:  Indicates the last item added. 

**default** 
:  Indicates the default Button. 


---

WIDGET-SPECIFIC OPTIONS

**-anchor (read-only)**
:  Specifies the anchor point of the ButtonBox. Must be one of **w**, **e**, **n**, **s** or **c**. If **side** option is set to *top* or *bottom*, **anchor** values *n*, *s* and *c* have the same effect. If **side** option is set to *left* or *right*, **anchor** values *w*, *e* and *c* have the same effect. 


**-bitmap (read-only)**
:  Specifies a bitmap to display at the left of the user frame. **image** option override **bitmap**. 


**-cancel**
:  Specifies the number of the cancel button of the Dialog. When user presses Esc or the windows close button, this button is invoked.  
   If set to **-1**, Esc does not invoke anything. The window close button *destroys* the dialog in this case and returns **-1**. 


**-default**
:  Specifies the number of the default button of the Dialog. When user press Return in the Dialog, this button is invoked. 


**-geometry**
:  Set the **geometry** used when method **draw** is called. See **wm geometry** for a parameter description. 


**-image (read-only)**
:  Specifies an image to display at the left of the user frame. **image** option override **bitmap**. 


**-modal**
:  This option must be **none**, **local** or **global**. The value of this option specifies the grab mode of the dialog and how works Dialog::**draw**. 


**-parent**
:  Parent of the Dialog. Dialog is placed relative to its parent. If empty, it is placed relative to the root window. Also see **place** option. 


**-place**
:  Specifies where to draw the Dialog toplevel relative to the dialog's parent. Must be one of **none**, **center**, **left**, **right**, **above**, **below**. Default value of **place** is *center*. 


**-separator (read-only)**
:  Specifies wether or not to draw a separator between the user frame and the ButtonBox. 


**-side (read-only)**
:  Specifies where to draw the ButtonBox relative to the user frame. Must be one of **top**, **left**, **bottom** or **right**. 


**-title**
:  Title of the Dialog toplevel. 


**-transient (read-only)**
:  Specifies if the Dialog Toplevel should be a transient window or not. Default value of **transient** is *true*. 


---

WIDGET COMMAND

*pathName* **add** ?*arg...*? 
:  Add a button to the button box of the dialog box. Default -command option is *Dialog::enddialog \$path index* where *index* is number of button added. 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **draw** ?*focus*? 
: This command draw the Dialog, and set grab to it following **modal** option. If **modal** option is set to *none*, the command returns immediatly an empty string. In all other case, the command returns when Dialog::**enddialog** is called or when Dialog is destroyed. The return value is the result argument of Dialog::**enddialog** or -1 if it is destroyed.

     By default, the focus is set to the default button referenced by **default** option, or to the toplevel of Dialog if no default button has been set. If *focus* is present, it must be a pathname, or an index to a button. Initial focus is set on this pathname or corresponding button. 


*pathName* **enddialog** *result* 
:  This command is typically called within a command of a button to make Dialog::**draw** return. 


*pathName* **getframe** 
:  Returns the pathname of the user window. 


*pathName* **invoke** *index* 
:  Invoke the Button given by *index*. 


*pathName* **itemcget** *index* *option* 
:  Returns the current value of a configuration option for the item. *Option* may have any of the values accepted by the item creation command. 


*pathName* **itemconfigure** *index* ?*option*? ?*value* *option* *value* ...? 
:  This command is similar to the **configure** command, except that it applies to the options for an individual item, whereas **configure** applies to the options for the widget as a whole. **Options** may have any of the values accepted by the item creation widget command. If options are specified, options are modified as indicated in the command and the command returns an empty string. If no options are specified, returns a list describing the current options for the item. Read-only options are not be modified. 


*pathName* **setfocus** *index* 
:  Set the focus to the Button given by *index*. 


*pathName* **withdraw** 
:  Call this command to hide the dialog box.
