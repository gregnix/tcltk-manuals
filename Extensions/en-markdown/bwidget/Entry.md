*NAME*
: **Entry** - Entry widget with **state** option, dynamic help and drag and drop facilities 


*CREATION*
: Entry *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   [-background or -bg](options.md) |   [-borderwidth or -bd](options.md) |
    |   [-disabledbackground](options.md) |   [-disabledforeground](options.md) |
    |   [-exportselection](options.md) |   [-font](options.md) |
    |   [-foreground or -fg](options.md) |   [-highlightbackground](options.md) |
    |   [-highlightcolor](options.md) |   [-highlightthickness](options.md) |
    |   [-insertbackground](options.md) |   [-insertborderwidth](options.md) |
    |   [-insertofftime](options.md) |   [-insertontime](options.md) |
    |   [-insertwidth](options.md) |   [-justify](options.md) |
    |   [-relief](options.md) |   [-selectbackground](options.md) |
    |   [-selectborderwidth](options.md) |   [-selectforeground](options.md) |
    |   [-takefocus](options.md) |   [-text](options.md) |
    |   [-textvariable](options.md) |   [-xscrollcommand](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   -command |   -dragenabled |
    |   -dragendcmd |   -dragevent |
    |   -draginitcmd |   -dragtype |
    |   -dropcmd |   -dropenabled |
    |   -dropovercmd |   -droptypes |
    |   -editable |   -helptext |
    |   -helptype |   -helpvar |
    |   -show |   -state |
    |   -width |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* invoke 


---

DESCRIPTION

 The **Entry** widget extends the default Tk entry. Options have been added to provide visual effect depending on the state of the Entry, [DynamicHelp](DynamicHelp.md) options, and [Drag](DragSite.md) and [Drop](DropSite.md). Entry behaves much like a Label, with **text** option to set its contents.   
Tk entry command can also be used on Entry widget. 

---

WIDGET-SPECIFIC OPTIONS

**-command**
:  Specifies a command when user press \<Return> in the Entry. 


**-dragenabled**
:  A boolean specifying if drag is enabled. 


**-dragendcmd**
:  Specifies a command to be called when drag ended. **dragendcmd** must be a command conforming to the description of the option **dragendcmd** of **DragSite::register**.   
  If **dragendcmd** is empty, the internal *dragend* command updates the entry following the operation (**move** or **copy**) and the dragged data (whole or selected part of the entry). 


**-dragevent**
:  Specifies the number of the mouse button associated to the drag. Must be **1**, **2** or **3**. 


**-draginitcmd**
: Specifies a command to be called when **dragevent** occurs on widget. **draginitcmd** must be a command conforming to the description of the option **draginitcmd** of **DragSite::register**.   
  if **draginitcmd** is empty, the command refuse the drag if entry is empty or if portion of text is selected and event doesn't occur above the selection. In all other cases, the command returns:

      - as the data type, the value of option **dragtype** or *TEXT* if empty, 
      - as the operations, *{copy move}* if **state** is normal and **editable** is true, or *{copy}* only in other cases, 
      - as the data, the whole content or the selected portion of the entry. 


**-dragtype**
:  Specifies an alternate type of dragged object. 


**-dropcmd**
: Entry has a command wrapper for *drop* events. This command stops auto scrolling and extract current position.   
  If **dropcmd** is not empty, it is called with the following arguments:

      - the pathname of the Entry, 
      - the pathname of the drag source, 
      - the numeric index in the entry designated by the cursor, 
      - the current operation, 
      - the data type, 
      - the data. 

    and must return a value conforming to **dropcmd** option described in **DropSite::register**. If **dropcmd** is empty, the wrapper updates the entry following the type of data:

    : 

        |   |   |
        | --- | --- |
        | *COLOR* or *FGCOLOR* | reconfigure the **foreground** of the Entry |
        | *BGCOLOR* | reconfigure the **background** of the Entry |
        | *TEXT*,   or any other tag | reconfigure the Entry to display the associated string. |

    and returns 1.


**-dropenabled**
:  A boolean specifying if drop is enabled. 


**-dropovercmd**
: Entry has a command wrapper for *drag-over* events. This command enables auto scrolling and position extraction during the *drag-over*.   
  If **dropovercmd** is empty, the wrapper accepts the drop if **editable** option is true and **state** option is normal.   
  If **dropovercmd** is not empty, it is called with the following arguments:

      - the pathname of the Entry, 
      - the pathname of the drag source, 
      - the event, 
      - the numeric index in the entry designated by the cursor, 
      - the current operation, 
      - the data type, 
      - the data. 

    and must return a value conforming to **dropovercmd** option described in **DropSite::register**.


**-droptypes**
:  Specifies a list of accepted dropped object/operation. See option **droptypes** of **DropSite::register**. for more infromation. Default accepts *FGCOLOR*, *COLOR*, *BGCOLOR* and *TEXT*, all with **copy** and **move** operations. 


**-editable**
:  Specifies whether the Entry is editable by the user. Equivalent to the **state** option of the Tk entry widget. 


**-helptext**
:  Text for dynamic help. If empty, no help is available for this widget. See also [DynamicHelp](DynamicHelp.md). 


**-helptype**
:  Type of dynamic help. Use *balloon* or *variable*. See also [DynamicHelp](DynamicHelp.md). 


**-helpvar**
:  Variable to use when **helptype** option is *variable*. See also [DynamicHelp](DynamicHelp.md). 


**-show**
:  If this option is specified, then the true contents of the entry are not displayed in the window. Instead, each character in the entry's value will be displayed as the first character in the value of this option, such as \`\`\*''. This is useful, for example, if the entry is to be used to enter a password. If characters in the entry are selected and copied elsewhere, the information copied will be what is displayed, not the true contents of the entry. 


**-state**
:  Specifies one of two states for the Entry: **normal** or **disabled**. In normal state the text of the Entry is displayed using the **foreground** option. In disabled state the text of the Entry is displayed using the **disabledforeground** option. If the entry is disabled then the value may not be changed by user input and no insertion cursor will be displayed, even if the input focus is in the widget. Disabled state is the same as not editable with visual effect. 


**-width**
:  Specifies an integer value indicating the desired width of the entry window, in average-size characters of the widget's font. If the value is less than or equal to zero, the widget picks a size just large enough to hold its current text. 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **invoke** 
:  Calls the command specified by the option **-command**.
