*NAME*
: **ProgressDlg** - Progress indicator dialog box 


*CREATION*
: ProgressDlg *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

|   |
| --- |
|   [-font](options.md) |
|   [-textvariable](options.md) |


*OPTIONS from Dialog*
: 

|   |   |
| --- | --- |
|   -background or -bg |   -parent |
|   -separator |   -title |


*OPTIONS from ProgressBar*
: 

|   |   |
| --- | --- |
|   -background or -bg |   -borderwidth or -bd |
|   -foreground or -fg |   -maximum |
|   -relief |   -troughcolor |
|   -type |   -variable |


*WIDGET-SPECIFIC OPTIONS*
: 

|   |
| --- |
|   -command |
|   -height |
|   -stop |
|   -width |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

DESCRIPTION

 ProgressDlg provides a simple way to display a progress indicator dialog. ProgressDlg::**create** creates the dialog, displays it, set a local grab to it and immediatly return. The dialog is updated by modifying the value of the variable of options **-textvariable** and **-variable**. You have to destroy the dialog after use. 

---

WIDGET-SPECIFIC OPTIONS

**-command**
:  Specifies a command to call when user press stop button. Note that it is the program's responsibility to periodically call **update** so that button press events can be generated. 


**-height**
:  Specifies a desired height for the label in lines of text. 


**-stop**
:  Specifies the text of the button typically used to stop process. If empty, no button will be drawn. This can be a symbolic name. 


**-width**
:  Specifies a desired width for the label in characters. 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified.
