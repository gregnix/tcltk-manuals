*NAME*
: **Tree** - Tree widget 


*CREATION*
: Tree *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   [-background or -bg](options.md) |   [-borderwidth or -bd](options.md) |
    |   [-cursor](options.md) |   [-highlightbackground](options.md) |
    |   [-highlightcolor](options.md) |   [-highlightthickness](options.md) |
    |   [-relief](options.md) |   [-selectbackground](options.md) |
    |   [-selectforeground](options.md) |   [-takefocus](options.md) |
    |   [-xscrollcommand](options.md) |   [-yscrollcommand](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   -closecmd |   -crossfill |
    |   -crossclosebitmap |   -crosscloseimage |
    |   -crossopenbitmap |   -crossopenimage |
    |   -deltax |   -deltay |
    |   -dragenabled |   -dragendcmd |
    |   -dragevent |   -draginitcmd |
    |   -dragtype |   -dropcmd |
    |   -dropenabled |   -dropovercmd |
    |   -dropovermode |   -droptypes |
    |   -height |   -linesfill |
    |   -linestipple |   -opencmd |
    |   -padx |   -redraw |
    |   -selectcommand |   -selectfill |
    |   -showlines |   -width |


*WIDGET COMMAND*
: *pathName* bindArea *event* *script* 

: *pathName* bindImage *event* *script* 

: *pathName* bindText *event* *script* 

: *pathName* cget *option* 

: *pathName* closetree *node* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* delete ?*arg...*? 

: *pathName* edit *node* *text* ?*verifycmd*? ?*clickres*? ?*select*? 

: *pathName* exists *node* 

: *pathName* find *findinfo* ?*confine*? 

: *pathName* index *node* 

: *pathName* insert *index* *parent* *node* ?*option value...*? 

: *pathName* itemcget *node* *option* 

: *pathName* itemconfigure *node* ?*option*? ?*value* *option* *value* ...? 

: *pathName* line *node* 

: *pathName* move *parent* *node* *index* 

: *pathName* nodes *node* ?*first*? ?*last*? 

: *pathName* opentree *node* 

: *pathName* parent *node* 

: *pathName* reorder *node* *neworder* 

: *pathName* see *node* 

: *pathName* selection *cmd* ?*arg...*? 

: *pathName* toggle *node* 

: *pathName* visible *node* 

: *pathName* xview ?*arg...*? 

: *pathName* yview ?*arg...*? 


---

DESCRIPTION

 **Tree** widget uses canvas to display a hierarchical list of items (called nodes). Each node is composed of a label with its own font and foreground attributes, and an optional image or window. Each node can have a list of subnodes, which can be collapsed or expanded. Each node is drawn in a single line, whose height is defined by the **deltay** option, so they must have at most this height. A node is uniquely identified by a string given at creation (by the **insert** command). The node named *root* is the root of the tree and is not drawn. The tree structure is directly maintained by the widget. 

---

WIDGET-SPECIFIC OPTIONS

**-closecmd**
:  Specifies a command to be called when user close a node. The closed node is appended to the command. 


**-crossfill**
:  Specifies a foreground color for the cross bitmap. 


**-crossclosebitmap**
:  Specifies a bitmap to be displayed in place of the standard cross when a node is closed. 


**-crosscloseimage**
:  Specifies an image to be displayed in place of the standard cross when a node is closed. Overrides the -crossclosebitmap option. 


**-crossopenbitmap**
:  Specifies a bitmap to be displayed in place of the standard cross when a node is open. 


**-crossopenimage**
:  Specifies an image to be displayed in place of the standard cross when a node is open. Overrides the -crossopenbitmap option. 


**-deltax**
:  Specifies horizontal indentation between a node and its children. 


**-deltay**
:  Specifies vertical size of the nodes. 


**-dragenabled**
:  A boolean specifying if drag is enabled. 


**-dragendcmd**
:  Specifies a command to be called when drag ended. **dragendcmd** must be a command conforming to the description of the option **dragendcmd** of **DragSite::register**. 


**-dragevent**
:  Specifies the number of the mouse button associated to the drag. Must be **1**, **2** or **3**. 


**-draginitcmd**
: Tree has a command wrapper for *drag-init* events. This command refused the drag if no node is designated. In other cases:   
  If **draginitcmd** is empty, it returns:

      - the value of option **dragtype** or *TREE_NODE* if empty as the data type, 
      - *{copy move link}* as the operations, 
      - the node identifier as the data. 

    If **draginitcmd** is not empty, it is called with the following arguments:

      - the pathname of the tree, 
      - the identifier of the dragged node, 
      - the toplevel created to represent dragged data. 

    and must return a value conforming to **draginitcmd** option described in **DragSite::register**.


**-dragtype**
:  Specifies an alternate type of dragged object. 


**-dropcmd**
: Tree has a command wrapper for *drop* events. This command stops auto scrolling and extract node and position.   
  If **dropcmd** is not empty, it is called with the following arguments:

      - the pathname of the tree, 
      - the pathname of the drag source, 
      - a list describing where the drop occurs. It can be:  
      - the current operation, 
      - the data type, 
      - the data. 

        - *{*__widget__*}*, 
        - *{*__node__ *node}* or 
        - *{*__position__ *node index}*. 


**-dropenabled**
:  A boolean specifying if drop is enabled. 


**-dropovercmd**
: Tree has a command wrapper for *drag-over* events. This command enables auto scrolling and position extraction during the *drag-over*. If **dropovercmd** is not empty, the command is called with the following aguments:

      - the pathname of the tree, 
      - the pathname of the drag source, 
      - a list describing where the drop can occur, whose elements are:  
      - the current operation, 
      - the data type, 
      - the data. 

        - the string *widget* if **dropovertype** option contains *w*, else empty string. 
        - the targeted node if drag icon points a node and **dropovertype** option contains *n*, else empty string. 
        - a list containing a node and the position within the children of the node where drag icon points to if **dropovertype** option contains *p*, else empty string. 
        - optionally, the preferred method if drop can occur both inside a node and between two nodes. The value is *position* or *node*. 

    The command must return a list with two elements:

      - the drop status, conforming to those described in **dropovercmd** option of **DropSite::register**, 
      - the choosen method: *widget*, *node* or *position*. 


**-dropovermode**
:  Specifies the type of *drop-over* interaction. Must be a combination of **w**, which specifies that drop can occurs everywhere on widget, **p**, which specifies that drop can occurs between two nodes, and **n**, which specifies that drop occurs inside nodes. 


**-droptypes**
:  Specifies a list of accepted dropped object/operation. See option **droptypes** of **DropSite::register**. for more infromation.   
  Default is *TREE_NODE* with operations **copy** and **move**. 


**-height**
:  Specifies the desired height for the tree in units of **deltay** pixels. 


**-linesfill**
:  Specifies a foreground color for the lines between nodes. 


**-linestipple**
:  Specifies a stipple bitmap for the lines between nodes. 


**-opencmd**
:  Specifies a command to be called when the user opens a node. The name of the opened node is appended to the command. 


**-padx**
:  Specifies distance between image or window and text of the nodes. 


**-redraw**
:  Specifies wether or not the tree should be redrawn when entering idle. Set it to false if you call **update** while modifying the tree. 


**-selectcommand**
:  Specifies a command to be called when the selection is changed. The path of the tree widget and the selected nodes are appended to the command. 


**-selectfill**
:  If true, the selection box will be drawn across the entire tree from left-to-right instead of just around the item text. 


**-showlines**
:  Specifies whether or not lines should be drawn between nodes. 


**-width**
:  Specifies the desired width for the tree in units of 8 pixels. 


---

NODE NAMES

 Certain special characters in node names are automatically substituted by the tree during operation. These characters are **& | ^ !**. They are all substituted with a **\_** character. This is only to avoid errors because the characters are special to the tree widget. 

WIDGET COMMAND

*pathName* **bindArea** *event* *script* 
:  This command associates a command to execute whenever the event sequence given by *event* occurs anywhere within the Tree area. 


*pathName* **bindImage** *event* *script* 
: This command associates a command to execute whenever the event sequence given by *event* occurs on the image of a node. The node idenfier on which the event occurs is appended to the command and may be used to manipulate the tree (e.g. don't use **%W**).

     If **-selectfill** is given, an eventual binding of the background box by **bindText** is overwritten. 


*pathName* **bindText** *event* *script* 
: This command associates a command to execute whenever the event sequence given by *event* occurs on the label of a node. The node idenfier on which the event occurs is appended to the command and may be used to manipulate the tree (e.g. don't use **%W**).

     If **-selectfill** is given, an eventual binding of the background box by **bindImage** is overwritten. 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **closetree** *node* ?*recurse*? 
:  This command close all the subtree given by *node*. Recurse through the tree starting at *node* and set **open** option to 0 depending on *recurse*. Default value of *recurse* is *true*. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **delete** ?*arg...*? 
:  Deletes all nodes (and children of them) in *arg*. *arg* can be a list of nodes or a list of list of nodes. To delete all the tree, do *\$pathName delete \[\$pathName nodes root\]*. 


*pathName* **edit** *node* *text* ?*verifycmd*? ?*clickres*? ?*select*? 
:  Provides a way for the user to edit in place the label of a node. This is possible only if *node* is visible (all its parents are open).   
  The command takes the initial text as argument and does not modify the label of the edited node, but returns an empty string if edition is canceled, or the typed text if edition is accepted.   
  When editing, the user can cancel by pressing Escape, or accept by pressing Return.   
  *clickres* specifies what to do if the user click outside the editable area. If *clickres* is 0 (the default), the edition is canceled. If *clickres* is 1, the edition is accepted. In all other case, the edition continues.   
  If edition is accepted and *modifycmd* is not empty, then it is called with the new text as argument and must return 1 to accept the new text, 0 to refuse it and continue edition.   
  *select* specifies wether or not the initial text should be selected. Default is 1. 


*pathName* **exists** *node* 
:  Returns whether or not *node* exists in the tree. 


*pathName* **find** *findinfo* ?*confine*? 
:  Returns the node given by the position *findinfo*. *findinfo* can take the form of a pixel position *@x,y* or of the line number of a currently visible Tree node. The first line of the Tree has the value of zero. 

     If *confine* is non-empty, then confine *findinfo* to only match pixel positions for the area consumed by Tree labels, not just anywhere on their lines. (*confine* has no effect if *findinfo* is a line number.) 


*pathName* **index** *node* 
:  Returns the position of *node* in its parent. 


*pathName* **insert** *index* *parent* *node* ?*option value...*? 
:  Inserts a new node identified by *node* in the children list of *parent* at position *index*. 

     Any instance of *#auto* within the node name will be replaced by the number of the item in the order of insertion. The non-printable characters \\1 to \\5 are reserved for internal use and should not be present in node names. 

     

    **-anchor**
    :  Specifies the anchor of the image or window of the node. Defaults to w. 

    **-data**
    :  User data associated to the node. 

    **-deltax**
    :  Specifies the horizontal indentation of the node. If the value is -1, the node will be drawn with the deltax for the entire tree. 

    **-drawcross**
    :  Specifies how the cross used to expand or collapse the children of a node should be drawn. Must be one of **auto**, **always** or **never**.   
      If **auto**, the cross is drawn only if the node has children. If **always**, the cross is always drawn. If **never**, the cross is never drawn. To maintain compatibility with older versions of this widget, **allways** is a deprecated synonym to **always**. 

    **-fill**
    :  Specifies the foreground color of the label of the node. 

    **-font**
    :  Specifies a font for the label of the node. 

    **-helpcmd**
    :  If specified, refers to a command to execute to get the help text to display. The command must return a string to display. If the command returns an empty string, no help is displayed. See also [DynamicHelp](DynamicHelp.md). 

    **-helptext**
    :  Text for dynamic help. See also [DynamicHelp](DynamicHelp.md). 

    **-helptype**
    :  Type of dynamic help. Use *balloon* or *variable*. See also [DynamicHelp](DynamicHelp.md). 

    **-helpvar**
    :  Variable to use when **helptype** option is *variable*. See also [DynamicHelp](DynamicHelp.md). 

    **-image**
    :  Specifies an image to display at the left of the label of the node. **window** option override **image**. 

    **-open**
    :  Specifies wether or not the children of the node should be drawn. 

    **-padx**
    :  Specifies the distance between image or window and the text of the node. If the value is -1, the node will be drawn with the padx for the entire tree. 

    **-selectable**
    :  Specifies if the node can be selected or not. 

    **-text**
    :  Specifies the label of the node. 

    **-window**
    :  Specifies a pathname to display at the left of the label of the node. **window** option override **image**. 


*pathName* **itemcget** *node* *option* 
:  Returns the current value of a configuration option for the item. *Option* may have any of the values accepted by the item creation command. 


*pathName* **itemconfigure** *node* ?*option*? ?*value* *option* *value* ...? 
:  This command is similar to the **configure** command, except that it applies to the options for an individual item, whereas **configure** applies to the options for the widget as a whole. **Options** may have any of the values accepted by the item creation widget command. If options are specified, options are modified as indicated in the command and the command returns an empty string. If no options are specified, returns a list describing the current options for the item. Read-only options are not be modified. 


*pathName* **line** *node* 
:  Returns the line number where *node* was drawn. If the node is not visible then return -1. The first line of the tree has the value of 0. 


*pathName* **move** *parent* *node* *index* 
:  Moves *node* to the children list of *parent* at position *index*. *parent* can not be a descendant of *node*. 


*pathName* **nodes** *node* ?*first*? ?*last*? 
:  Returns parts of the children of *node*, following *first* and *last*.  
   If *first* and *last* are omitted, returns the list of all children. If *first* is specified and *last* omitted, returns the child at index *first*, or an empty string if *first* refers to a non-existent element. If *first* and *last* are specified, the command returns a list whose elements are all of the children between *first* and *last*, inclusive. Both *first* and *last* may have any of the standard forms for indices. 


*pathName* **opentree** *node* ?*recurse*? 
:  This command open all the subtree given by *node*. Recurse through the tree starting at *node* and set **open** option to 1 depending on value of *recurse*. Default value of *recurse* is *true*. 


*pathName* **parent** *node* 
:  Returns the parent of *node*. 


*pathName* **reorder** *node* *neworder* 
:  Modifies the order of children of *node* given by *neworder*. Children of *node* that do not appear in *neworder* are no moved. 


*pathName* **see** *node* 
:  Arrange the scrolling area to make *node* visible. 


*pathName* **selection** *cmd* ?*arg...*? 
: Modifies the list of selected nodes following *cmd*:

    **add** 
    : Adds all nodes in *arg* to the selection. 

    **clear** 
    : Removes all nodes from the selection. 

    **get** 
    : Returns a list containing the indices of current selected nodes. 

    **includes** 
    : Tests if the specified node is selected. Returns true if the answer is yes, and false else. 

    **range** 
    : Sets the selection to all nodes between the two specified ones. 

    **remove** 
    : Removes all nodes in *arg* from the selection. 

    **set** 
    : Sets the selection to all nodes in *arg*. 

    **toggle** 
    : Toggles the selection status of all nodes in *arg*. 

    The subcommands **add**, **range**, and **set** silently ignore nodes which are declared unselectable. See the node option -selectable to influence this.


*pathName* **toggle** *node* 
:  Toggle the open/close status of the given *node*. 


*pathName* **visible** *node* 
:  Returns whether or not *node* is visible (all its parents are open). 


*pathName* **xview** ?*arg...*? 
:  Standard command to enable horizontal scrolling of *pathName*. 


*pathName* **yview** ?*arg...*? 
:  Standard command to enable vertical scrolling of *pathName*. 


BINDINGS

 A **<\<TreeSelect>>** virtual event is generated any time the selection in the tree changes. This is the default behavior of an item in the tree, but it can be overridden with the bindText or bindImage command. If the button 1 binding is overridden, this event may not be generated. 

 The tree has all the standard mouse wheel bindings when it has focus.
