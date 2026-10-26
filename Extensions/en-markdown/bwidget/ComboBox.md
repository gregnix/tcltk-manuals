*NAME*
: **ComboBox** - ComboBox widget 


*CREATION*
: ComboBox *pathName* ?*option value...*?


*OPTIONS from ArrowButton*
: 

|   |   |
| --- | --- |
|   -background or -bg |   -disabledforeground |
|   -foreground or -fg |   -state |


*OPTIONS from Entry*
: 

|   |   |
| --- | --- |
|   -command |   -disabledforeground |
|   -dragenabled |   -dragendcmd |
|   -dragevent |   -draginitcmd |
|   -dragtype |   -dropcmd |
|   -dropenabled |   -dropovercmd |
|   -droptypes |   -editable |
|   -entrybg (see **-background**) |   -entryfg (see **-foreground**) |
|   -exportselection |   -font |
|   -helptext |   -helptype |
|   -helpvar |   -highlightbackground |
|   -highlightcolor |   -highlightthickness |
|   -insertbackground |   -insertborderwidth |
|   -insertofftime |   -insertontime |
|   -insertwidth |   -justify |
|   -selectbackground |   -selectborderwidth |
|   -selectforeground |   -show |
|   -state |   -takefocus |
|   -text |   -textvariable |
|   -width |   -xscrollcommand |


*WIDGET-SPECIFIC OPTIONS*
: 

|   |   |
| --- | --- |
|   -autocomplete |   -autopost |
|   -bwlistbox |   -expand |
|   -height |   -hottrack |
|   -images |   -listboxwidth |
|   -modifycmd |   -postcommand |
|   -values |


*WIDGET COMMAND*
: *pathName* bind ?*arg...*? 

: *pathName* cget *option* 

: *pathName* clearvalue 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* get

: *pathName* getlistbox

: *pathName* getvalue

: *pathName* icursor *index* 

: *pathName* post

: *pathName* setvalue *index* 

: *pathName* unpost


---

DESCRIPTION

 ComboBox widget enables the user to select a value among a list given by the **values** option. The list of possible values can be popped by pressing the ArrowButton or by clicking in the entry when **editable** value of the ComboBox is **false**.  
 If **editable** value of the ComboBox is **true** and the entry has the focus, the user can press the top and bottom arrow keys to modify its value. If the current value exactly match a value in the list, then the previous (for top arrow key) or then next (for bottom arrow key) value in the list is displayed. If the current value match the beginning of a value in the list, then this value is displayed. If the current value doesnt match anything, then the first value is displayed. 

---

WIDGET-SPECIFIC OPTIONS

**-autocomplete**
:  Specifies whether or not the combobox should attempt to auto-complete the value in the entry field as the user types. If true, the combobox will fill in a value that it finds in its value list as the user types into the entry. 


**-autopost**
:  Specifies whether or not the combobox should post the drop down as the user types. If true, the combobox will post and scroll to the entry that most closely matches the user entry. 


**-bwlistbox**
:  Specifies that the combobox should use a BWidget listbox in its drop down instead of the standard Tk option. This option is enabled by default if the **-images** option is not empty. 


**-expand**
:  Specifies the value expansion behavior for the window. It must be **none** (default) or **tab**. If **tab** is specified, then a Tab binding is added to attempt to expand the current value based on the other values in **-values**. 


**-height**
:  Specifies the desired height for the window, in lines. If zero or less, then the desired height for the window is made just large enough to hold all the elements in the listbox. 


**-modifycmd**
:  Specifies a Tcl command called when the user modify the value of the ComboBox by selecting it in the listbox or pressing arrow key. 


**-postcommand**
:  Specifies a Tcl command called before the listbox of the ComboBox is mapped. 


**-values**
:  Specifies the values to display in the listbox of the ComboBox. 


---

WIDGET COMMAND

*pathName* **bind** ?*arg...*? 
:  Set bindings on the entry widget. 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **clearvalue** 
:  Clears the current text of the ComboBox. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **get** 
:  Returns the current contents of the entry. 


*pathName* **getlistbox** 
:  Returns the path to the listbox in the drop down. 


*pathName* **getvalue** 
:  Returns the index of the current text of the ComboBox in the list of values, or -1 if it doesn't match any value. 


*pathName* **icursor** *index* 
:  Arrange for the insertion cursor to be displayed just before the character given by *index*. Returns an empty string. 


*pathName* **post** 
:  Post the drop down. 


*pathName* **setvalue** *index* 
: Set the text of the ComboBox to the value indicated by *index* in the list of values. *index* may be specified in any of the following forms:

 

 **last** 
:  Specifies the last element of the list of values. 

**first** 
:  Specifies the first element of the list of values. 

 **next** 
:  Specifies the element following the current (ie returned by **getvalue**) in the list of values. 

**previous** 
:  Specifies the element preceding the current (ie returned by **getvalue**) in the list of values. 

 @*number* 
:  Specifies the integer index in the list of values. 



*pathName* **unpost** 
:  Unpost the drop down. 


---

BINDINGS

When Entry of the ComboBox has the input focus, it has the following bindings, in addition
to the default Entry bindings:

- Page up set the value of the ComboBox to the first value. 
- Page down set the value of the ComboBox to the last value. 
- Arrow up set the value of the ComboBox to the previous value. 
- Arrow down set the value of the ComboBox to the next value. 
- If **-autopost** is enabled, Escape unposts the listbox. 

If the listbox is not mapped and ComboBox is not editable or disabled,
mouse button 1 on the Entry cause the listbox to popup, as if the user press the ArrowButton.
