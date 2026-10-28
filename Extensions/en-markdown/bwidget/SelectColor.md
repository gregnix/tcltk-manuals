*NAME*
: **SelectColor** - Color selection widget 


*CREATION*
: SelectColor *pathName* ?*option value...*?


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   -color |   -parent |
    |   -placement |   -title |
    |   -type |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: SelectColor::dialog *pathName* *?option value ...?* 

: SelectColor::menu *pathName* *placement* *?option value ...?* 

: SelectColor::setcolor *index* *color* 


---

DESCRIPTION

 SelectColor provides a simple way to select color. It can be displayed as a dialog box or as a menubutton. 

---

WIDGET-SPECIFIC OPTIONS

**-color**
:  Specifies the color value of the widget. 


**-parent**
:  Parent of the Dialog. Dialog is centered in its parent. If empty, it is centered in root window. 


**-placement**
:  Where to place the *popup* color dialog when displaying it. Must be any of: **at**, **center**, **left**, **right**, **above**, or **below**. If *-parent* is specified, placement will be in relation to the parent widget. 


**-title**
:  Title of the Dialog toplevel. 


**-type (read-only)**
:  Specifies the type of the SelectColor widget. Must be **dialog** or **popup**.   
  If **type** option is *dialog*, SelectColor::**create** directly creates the dialog, displays it and return an empty string if cancel button is pressed or if dialog is destroyed, and the selected color if ok button is pressed. In all cases, dialog is destroyed.   
  If **type** option is *popup*, SelectColor::**create** creates a small, popup dialog with a small set of predefined colors and a button to activate a full color dialog. 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


SelectColor::**dialog** *pathName* *?option value ...?* 
:  Creates a dialog for the user to select a custom color. 


SelectColor::**menu** *pathName* *placement* *?option value ...?* 
: Creates a small, popup dialog for the user to select from a predefined list of colors with an additional button to display a full color dialog.

     *placement* can be any of **at**, **center**, **left**, **right**, **above**, or **below**. If *-parent* is specified, placement will be in relation to the parent widget. 


SelectColor::**setcolor** *index* *color* 
:  Set the value of user predefined color at index *index* to *color*. *index* must be between 0 and 10.
