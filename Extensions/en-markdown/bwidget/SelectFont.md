*NAME*
: **SelectFont** - Font selection widget 


*CREATION*
: SelectFont *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

|   |   |
| --- | --- |
|   [-background or -bg](options.md) |   [-font](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: -command


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: SelectFont::loadfont 


---

DESCRIPTION

 SelectFont provides a simple way to choose font. It can be displayed as a dialog box or as a toolbar.   
Textual items in Dialog box uses **-name** options so they can be translated to any language. Symbolic name used are **ok**, **cancel**, **font**, **size**, **style**, **bold**, **italic**, **underline** and **overstrike**. 

---

WIDGET-SPECIFIC OPTIONS

**-command**
:  Specifies a command to call when user select a new font when SelectFont **type** option is *toolbar*. 


**-initialcolor**
:  If specified, add an additional button that lets the user pick a color. This option is ignored if **type** is *toolbar*. 


**-nosizes**
:  If true, don't show the listbox containing valid font sizes. This option is ignored if **type** is *toolbar*. 


**-parent**
:  Parent of the Dialog. Dialog is centered in its parent. If empty, it is centered in root window. 


**-sampletext**
:  Specifies the text displayed in the preview area. 


**-title**
:  Title of the Dialog toplevel. 


**-type**
:  Specifies the type of the SelectFont widget. Must be **dialog** or **toolbar**.   
  If **type** option is *dialog*, SelectFont::**create** directly creates the dialog, displays it and return an empty string if cancel button is pressed or if dialog is destroyed, and the selected font (and color if **initialcolor**) if ok button is pressed. In all cases, dialog is destroyed.   
  If **type** option is *toolbar*, SelectFont::**create** returns the pathname of the widget created. 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


SelectFont::**loadfont** 
:  Load the font available in the system.
