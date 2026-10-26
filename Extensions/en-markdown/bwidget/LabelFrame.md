*NAME*
: **LabelFrame** - Frame with a Label 


*CREATION*
: LabelFrame *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

|   |   |
| --- | --- |
|   [-borderwidth or -bd](options.md) |   [-relief](options.md) |


*OPTIONS from Label*
: 

|   |   |
| --- | --- |
|   -anchor |   -background or -bg |
|   -bitmap |   -disabledforeground |
|   -focus |   -font |
|   -foreground or -fg |   -height |
|   -helptext |   -helptype |
|   -helpvar |   -image |
|   -justify |   -name |
|   -padx |   -pady |
|   -state |   -text |
|   -textvariable |   -underline |
|   -width |   -wraplength |


*WIDGET-SPECIFIC OPTIONS*
: -side


*WIDGET COMMAND*
: LabelFrame::align ?*arg...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe 


---

DESCRIPTION

 LabelFrame enables user to create a frame with a [Label](Label.md) positionned at any side. LabelFrame is used by [ComboBox](ComboBox.md) and [SpinBox](SpinBox.md). 

---

WIDGET-SPECIFIC OPTIONS

**-side (read-only)**
:  Specifies where to position the Label relative to the user frame: **top**, **bottom**, **left** or **right**. 


---

WIDGET COMMAND

LabelFrame::**align** ?*arg...*? 
:  This command align label of all widget given by *args* of class LabelFrame (or "derived") by setting their width to the max one +1 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **getframe** 
:  Return the frame where the user can create any other widget.
