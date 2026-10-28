*NAME*
: **ProgressBar** - Progress indicator widget 


*CREATION*
: ProgressBar *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   [-background or -bg](options.md) |   [-borderwidth or -bd](options.md) |
    |   [-foreground or -fg](options.md) |   [-orient](options.md) |
    |   [-relief](options.md) |
    |   [-troughcolor](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |
    | --- |
    |   -height |
    |   -maximum |
    |   -type |
    |   -variable |
    |   -width |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

DESCRIPTION

 ProgressBar widget indicates the user the progress of a lengthly operation. It is used by [MainFrame](MainFrame.md) and [ProgressDlg](ProgressDlg.md). 

---

WIDGET-SPECIFIC OPTIONS

**-height**
:  Specifies the desired height for the progress indicator. 


**-maximum**
:  Specifies the maximum value of the variable. This value must be greater than zero. 


**-type**
:  Specifies the type of the ProgressBar. Must be one of **normal**, **incremental**, **infinite** or **nonincremental_infinite**.   
    
  If **type** is *normal*, the progress indicator is drawn proportional to the variable value and **maximum** option each time the variable is set.   
    
  If **type** is *incremental*, the value of the progress indicator is maintained internally, and incremented each time the variable is set by its value. The progress indicator is drawn proportional to the internal value and **maximum** option.   
    
  If **type** is *infinite*, the value of the progress indicator is maintained internally, and incremented each time the variable is set by its value. The progress indicator moves from left to right if internal value (modulo **maximum**) is less than **maximum**/2, and from right to left if internal value is greater than **maximum**/2.   
    
  If **type** is *nonincremental_infinite*, the value of the progress indicator taken from the variable value, The progress indicator moves from left to right if variable value (modulo **maximum**) is less than **maximum**/2, and from right to left if internal value is greater than **maximum**/2.   
    
  See **-variable** option for special case of its value,   
    
  Default value for **type** is *normal*. 


**-variable**
:  Specifies the variable attached to the progress indicator. Progress indicator is updated when the value of the variable changes. If the value of the variable is negative, the progress indicator is not displayed (it is drawn flat with **background** color - usefull for ProgressDlg to make it invisible). If its value 0, progress indicator is reinitialized. 


**-width**
:  Specifies the desired width for the progress indicator. 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified.
