*NAME*
: **DragSite** - Commands set for Drag facilities 


*COMMAND*
: DragSite::include *class* *type* *event* 

: DragSite::register *path* ?*option value...*? 

: DragSite::setdrag *path* *subpath* *initcmd* *endcmd* ?*force*? 


---

DESCRIPTION

 Commands of this namespace enable user to define a BWidget or a Tk widget as a drag site. 

---

COMMAND

DragSite::**include** *class* *type* *event* 
: This command provides a simple way to include options relatives to a drag site into BWidget resources definition. It includes the options needed for **register**: *-dragevent*, initialized to *event*, *-draginitcmd* and *-dragendcmd*, initialized to empty string, and two new options:

    |   |   |
    | --- | --- |
    | *-dragenabled* | Specifies wether or not drag is active (initialized to 0)  |


DragSite::**register** *path* ?*option value...*? 
: This command is used to declare *path* as a drag site. Options are:

     

    **-dragendcmd**
    : Command called when drag terminates (ie when user release drag icon). This command is called with the following arguments:

            - the pathname of the drag source (the widget itself), 
            - the pathname of the drop target, 
            - the operation, 
            - the type of the dragged data, 
            - the dragged data, 
            - result of the drop (result of the call to **-dropcmd** of the target), 

        If the drop does not occurs, the target and the operation are empty string and the result is 0.

    **-dragevent**
    :  Specifies the number of the mouse button associated to the drag. Must be **1**, **2** or **3**. 

    **-draginitcmd**
    : Command called when drag initiates. When the event of option **dragevent** occurs on *path*, this command is called with the following arguments:

            - pathname of the drag source (*path*), 
            - root x-coordinate of pointer, 
            - root y-coordinate of pointer, 
            - a toplevel created to represent dragged data. When returning, if it has no children, a bitmap is automatically displayed. 

        If the command returns an empty string, then the drag will be suppressed. Otherwise the command must return a list containing three elements:

            - the type of the data, 
            - the list of acceptable basic operations (**copy**, **move** and **link**) 
            - and the data. 

        Note that even if **copy** does not appear in the list of basic operation, it is considered as an acceptable operation, since **copy** semantic does not modify the drag source.


DragSite::**setdrag** *path* *subpath* *initcmd* *endcmd* ?*force*? 
: This command provides a simple way to call **register** during a BWidget creation or configuration.

      - *path* is the pathname of the BWidget, 
      - *subpath* is the pathname of the tk widget where drag event occurs, 
      - *initcmd* BWidget command for *drag-init* event, 
      - *endcmd* BWidget command for *drag-end* event, 
      - *force* specifies wether or not to call **register** whenever no option value has changed (0 by default - for BWidget configuration, use 1 for BWidget creation). 

    **setdrag** verifies the modification flag of options **dragenabled** and **dragevent** and calls **register** if needed according to the options values and *initcmd* and *endcmd* arguments. **draginitcmd** and **dragendcmd** are not taken from options of widget because they are considered as user command, called by BWidget implementation of *drag-init* and *drag-end* events.
