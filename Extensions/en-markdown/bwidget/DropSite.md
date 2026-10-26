*NAME*
: **DropSite** - Commands set for Drop facilities 


*COMMAND*
: DropSite::include *class* *types* 

: DropSite::register *path* ?*option value...*? 

: DropSite::setcursor *cursor* 

: DropSite::setdrop *path* *subpath* *dropover* *drop* ?*force*? 

: DropSite::setoperation *op* 


---

DESCRIPTION

 Commands of this namespace enable user to define a BWidget or a Tk widget as a drop site. A drop site is composed of the type of object that can be dropped and associated operation, a command called when drop occurs, and a command when an object is dragged over the widget. A drop site must have at least one type of acceptable object and a drop command. 

---

COMMAND

DropSite::**include** *class* *types* 
: This command provides a simple way to include options relatives to a drop site into BWidget resources definition. It includes the options needed for **register**, *-dropovercmd* and *-dropcmd*, initialized to empty string, and *-droptypes*, initialized to *types*, and one new option:

|   |   |
| --- | --- |
| *-dropenabled* | Specifies wether or not drop is active (initialized to 0)  |


DropSite::**register** *path* ?*option value...*? 
: This command is used to declare *path* as a drop site. Options are:

 

**-dropcmd**
: This command is called when user release the drag icon over a valid drop target widget. Arguments passed to the command are:

    - pathname of the drop target (the widget itself), 
    - pathname of the drag source, 
    - root x-coordinate of the pointer, 
    - root y-coordinate of the pointer, 
    - operation, 
    - type of the dragged data, 
    - dragged data. 

Its return values is passed as a result to the **-dragendcmd** command of the drag source widget.


**-dropovercmd**
: This command can be used to provide a dynamic drag while *drag-over* events. While a drag occurs, the events \<Enter>, \<Motion> and \<Leave> are caught and handled internally. Arguments passed to the command are:

    - pathname of the drop target (the widget itself), 
    - pathname of the drag source, 
    - event over the drop target: *enter*, *motion* or *leave*, 
    - root x-coordinate of the pointer, 
    - root y-coordinate of the pointer, 
    - operation, 
    - type of the dragged data, 
    - dragged data. 

Command must the new status of the drag:

    - 0 if widget refuse this drag. Command will not be recalled on motion/leave event. 
    - 1 if widget accept this drag. Command will not be recalled on motion/leave event. 
    - 2 if widget refuse this drag. Command will be recalled on each motion event to reevaluate. 
    - 3 if widget accept this drag. Command will be recalled on each motion event to reevaluate. 

Here is a list of events and associated actions on a DropSite widget. This example assumes that dragged data type is valid for the drop target. **status** is the status of the drag on a DropSite. Its value is:   
  


|   |   |   |   |
| --- | --- | --- | --- |
| Event | Old status | Action | New status |
|  \<Enter> |  - |  if DropSite has dropovercmd, call it with enter |  result of dropovercmd |
|  else |  1 |
|  \<Motion> |  0 or 1 |   |  unchanged |
|  2 or 3 |  call dropovercmd with motion |  result of dropovercmd |
|  \<Leave>  |  0 or 1 |   |  - |
|  2 or 3 |  call dropovercmd with leave |  - |
|  \<Drop> |  0 |  call dragendcmd of drag source |  - |
|  1 |  call dropcmd and call dragendcmd of drag source |
|  2 |  call dropovercmd with leave and call dragendcmd of drag source |
|  3 |  call dropcmd and call dragendcmd of drag source |


**-droptypes**
: Specifies a list {*type* *oplist* ?*type* *oplist*? ...} of acceptable types and associated operations for the drop target. For each type, *oplist* is a list {*descops* *mod* ?*descops* *mod*? ...} describing operations and modifier keys for these operations. *descops* describe an operation. It can be a predefined operations (**copy**, **move** or **link**) or a new user defined operation, of the form {*subop* **baseop** ?*bitmap*?}. *subop* is the name given to the sub operation, *baseop* is the name of the base operation (**copy**, **move** or **link**) and *bitmap* is a bitmap to display for the operation.   
  If *bitmap* is empty, the default bitmap of the base operation is used for the sub operation.   
  *subop* can be a base operation, in order to change the bitmap of a base operation. In this case, *baseop* must be empty or equal to *subop*.   
  *mod* is the modifer key for the operation. It can be:

    - **none** to specify that no modifier key is pressed. This modifier can only be used with a sub operation named **default** (and vice versa), which has the behaviour of not display any bitmap operation. For all type, if the modifier **none** is not given, it is automatically associated to the **default** sub operation of a **copy** base operation. 
    - **program** to specifies a sub operation accessible only by **DropSite::setoperation**. 
    - A list combining **shift**, **control** and **alt**, which means their corresponding key. 



DropSite::**setcursor** *cursor* 
:  This command can be used within the script **dragovercmd**. It is usefull to provide visual effect about the state of the drag. 


DropSite::**setdrop** *path* *subpath* *dropover* *drop* ?*force*? 
: This command provides a simple way to call **register** during a BWidget creation or configuration.

  - *path* is the pathname of the BWidget, 
  - *subpath* is the pathname of the tk widget where drag event occurs, 
  - *dropover* is a command for *drag-over* event, 
  - *drop* is a command for *drop* event, 
  - *force* specifies wether or not to call **register** whenever no option value has changed (0 by default - for BWidget configuration, use 1 for BWidget creation). 

**setdrop** verifies the modification flag of options **dropenabled** and **droptypes** and calls **register** if needed according to the options values and *dropover* and *drop* arguments. **dropovercmd** and **dropcmd** are not taken from options of widget because they are considered as user command, called by BWidget implementation of *drag-over* and *drop* events.


DropSite::**setoperation** *op* 
:  Description text
