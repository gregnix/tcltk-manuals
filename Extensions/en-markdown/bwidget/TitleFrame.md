*NAME*
: **TitleFrame** - Frame with a title 


*CREATION*
: TitleFrame *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

|   |   |
| --- | --- |
|   [-background or -bg](options.md) |   [-borderwidth or -bd](options.md) |
|   [-font](options.md) |
|   [-relief](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: -baseline


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe 


---

DESCRIPTION

 TitleFrame enables user to create a frame with a title like XmFrame Motif widget. 

---

WIDGET-SPECIFIC OPTIONS

**-baseline**
:  Specifies the vertical alignment of the title: **top**, **center** or **bottom**. 


**-ipad**
:  Specifies a pad between the border of the frame and the user frame. The value is in screen units. 


**-side**
:  Specifies the horizontal alignment of the title: **left**, **center** or **right**. 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **getframe** 
:  Return the frame where the user can create any other widget.
