*NAME*
: **MainFrame** - Manage toplevel with menu, toolbar and statusbar 


*CREATION*
: MainFrame *pathName* ?*option value...*?


*OPTIONS from ProgressBar*
: 

|   |   |
| --- | --- |
|   -background or -bg |   -progressfg (see **-foreground**) |
|   -progressmax (see **-maximum**) |   -progresstype (see **-type**) |
|   -progressvar (see **-variable**) |


*WIDGET-SPECIFIC OPTIONS*
: 

|   |
| --- |
|   -height |
|   -menu |
|   -separator |
|   -textvariable |
|   -width |


*WIDGET COMMAND*
: *pathName* addindicator ?*arg...*? 

: *pathName* addtoolbar 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe 

: *pathName* getindicator *index* 

: *pathName* getmenu *menuid* 

: *pathName* gettoolbar *index* 

: *pathName* setmenustate *tag* *state* 

: *pathName* showstatusbar *name* 

: *pathName* showtoolbar *index* *bool* 


---

DESCRIPTION

 MainFrame manage toplevel to have:  
 

- simple menu creation, with automatic accelerator bindings and [DynamicHelp](DynamicHelp.md) association, 
- one or more toolbars that user can hide, 
- a status bar, displaying a user message or a menu description, and optionally a [ProgressBar](ProgressBar.md). 

---

WIDGET-SPECIFIC OPTIONS

**-height**
:  Specifies the desired height for the user frame in any of the forms acceptable to Tk_GetPixels. If this option is less than or equal to zero (the default) then the window will not request any size at all. 


**-menu (read-only)**
: This option describes the menu. This is a list whose each five elements describe one cascade menu. It has the following form: {*menuname* *tags* *menuId* *tearoff* *menuentries*...} where *menuentries* is a list where each element describe one menu entry, which can be:

  - for a separator:  
   {**separator**} 
  - for a command:  
   {**command** *menuname* ?*tags*? ?*description*? ?*accelerator*? ?*option* *value*? ...} 
  - for a check button:  
   {**checkbutton** *menuname* ?*tags*? ?*description*? ?*accelerator*? ?*option* *value*? ...} 
  - for a radio button:  
   {**radiobutton** *menuname* ?*tags*? ?*description*? ?*accelerator* ?*option* *value*? ...} 
  - for a cascade menu:  
   {**cascade** *menuname* *tags* *menuId* *tearoff* *menuentries*} 

where:

  - *menuname* is the name of the menu. If it contains a &, the following character is automatically converted to the corresponding **-underline** option of **menu add** command. 
  - *tags* is the tags list for the entry, used for enabling or disabling menu entries with **MainFrame::setmenustate**. 
  - *menuId* is an id for the menu, from which you can get menu pathname with **MainFrame::getmenu**. 
  - *tearoff* specifies if menu has tearoff entry. 
  - *description* specifies a string for [DynamicHelp](\"DynamicHelp.html\"). 
  - *accelerator* specifies a key sequence. It is a list of two elements, where the first is one of **Ctrl**, **Alt** or **CtrlAlt**, and the second as letter or a digit. An accelerator string is build and corresponding binding set on the toplevel to invoke the menu entry. 
  - *option value* specifies additionnal options for the entry (see **menu add** command). 

Each value enclosed by ? are optional and defaulted to empty string, but must be provided if one or more following options is not empty.   
Example:

```
set descmenu {
    "&File" {} {} 0 {
        {command "&New"     {} "Create a new document"     {Ctrl n} -command Menu::new}
        {command "&Open..." {} "Open an existing document" {Ctrl o} -command Menu::open}
        {command "&Save"    open "Save the document" {Ctrl s} -command Menu::save}
        {cascade  "&Export"  {} export 0 {
            {command "Format &1" open "Export document to format 1" {} -command {Menu::export 1}}
            {command "Format &2" open "Export document to format 2" {} -command {Menu::export 2}}
        }}
        {separator}
        {cascade "&Recent files" {} recent 0 {}}
        {separator}
        {command "E&xit" {} "Exit the application" {} -command Menu::exit}
    }
    "&Options" {} {} 0 {
        {checkbutton "Toolbar" {} "Show/hide toolbar" {} 
            -variable Menu::_drawtoolbar
            -command  {$Menu::_mainframe showtoolbar toolbar $Menu::_drawtoolbar}
        }
    }
}
```


**-separator (read-only)**
:  Specifies if separator should be drawn at the top and/or at the bottom of the user window. Must be one of the values **none**, **top**, **bottom** or **both**. It depends on the relief of subwidgets of user window. 


**-textvariable**
:  Specifies the textvariable option for the label of the status bar. [DynamicHelp](DynamicHelp.md) description of menu entries are mapped to this variable at the creation of the MainFrame. If this variable is changed by MainFrame::configure, menu description will not be available.   
  You change the text of the label by modifying the value of the variable. 


**-width**
:  Specifies the desired width for the user frame in any of the forms acceptable to Tk_GetPixels. If this option is less than or equal to zero (the default) then the window will not request any size at all. 


---

WIDGET COMMAND

*pathName* **addindicator** ?*arg...*? 
:  Add an indicator box at the right of the status bar. Each indicator are added from left to right. An indicator is a Tk label widget configured with option-value pair given by ?*arg...*?. **-relief** and **-borderwidth** options are respetively defaulted to *sunken* and 1. Returns the pathname of the created label. 


*pathName* **addtoolbar** 
:  Add a toolbar to the MainFrame. Returns the pathname of the new window where to place toolbar items. 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **getframe** 
:  Returns the pathname of the user window. 


*pathName* **getindicator** *index* 
:  Returns the pathname of the *index*th added indicator. 


*pathName* **getmenu** *menuid* 
:  Returns the pathname of the menu whose id is *menuid*. 


*pathName* **getmenustate** *tag* *state* 
:  Returns the state of the given menu *tag*. 


*pathName* **gettoolbar** *index* 
:  Returns the pathname of the *index*th added toolbar. 


*pathName* **setmenustate** *tag* *state* 
:  Set the **-state** option value of all the menu entries that have the tag *tag* to *state*. A menu entry is disabled, if one of its associated tags have state **disabled**. 


*pathName* **showstatusbar** *name* 
:  *name* is one of **none**, **status** or **progression**. Use **none** to hide the status bar, **status** to display the label only, or **progression** to display the label and the [ProgressBar](ProgressBar.md). 


*pathName* **showtoolbar** *index* *bool* 
:  Hide if *bool* is 0, or show if *bool* is 1 the *index*th added toolbar. To prevent your toplevel from resizing while hiding/showing toolbar, do \[wm geometry \$top \[wm geometry \$top\]\] when it is managed.
