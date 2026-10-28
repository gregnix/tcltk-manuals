*NAME*
: **ListBox** - ListBox widget 


*CREATION*
: ListBox *pathName* ?*option value...*?


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

    |   |   |   |
    | --- | --- | --- |
    |   -autofocus |   -deltax |   -deltay |
    |   -dragenabled |   -dragendcmd |
    |   -dragevent |   -draginitcmd |
    |   -dragtype |   -dropcmd |
    |   -dropenabled |   -dropovercmd |
    |   -dropovermode |   -droptypes |
    |   -height |   -multicolumn |
    |   -padx |   -redraw |
    |   -selectfill |   -selectmode |   -width |


*WIDGET COMMAND*
: *pathName* bindImage *event* *script* 

: *pathName* bindText *event* *script* 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* delete ?*arg...*? 

: *pathName* edit *item* *text* ?*verifycmd*? ?*clickres*? ?*select*? 

: *pathName* exists *item* 

: *pathName* index *item* 

: *pathName* insert *index* *item* ?*option value...*? 

: *pathName* item *first* ?*last*? 

: *pathName* itemcget *item* *option* 

: *pathName* itemconfigure *item* ?*option*? ?*value* *option* *value* ...? 

: *pathName* items ?*first*? ?*last*? 

: *pathName* move *item* *index* 

: *pathName* reorder *neworder* 

: *pathName* see *item* 

: *pathName* selection *cmd* ?*arg...*? 

: *pathName* xview ?*arg...*? 

: *pathName* yview ?*arg...*? 


---

DESCRIPTION

 **ListBox** widget uses canvas to display a list of items. Each item is composed of a label with its own font and foreground attributes, and an optional image or window. Each item is drawn in a single line, whose height is defined by the **deltay** option, so they must have at most this height. A item is uniquely identified by a string given at creation (by the **insert** command). The ListBox can have one or more columns, depending on **multicolumn** option. The user do not handle columns; the number of columns is determined following the height of the ListBox in order to see each item vertically. 

---

WIDGET-SPECIFIC OPTIONS

**-autofocus**
:  If this option is true, the listbox will take focus any time the user clicks in it. Without focus, the listbox's mouse wheel bindings will not work properly. The default is true. 


**-deltax**
:  Specifies horizontal pad between each columns. 


**-deltay**
:  Specifies vertical size of the items. 


**-dragenabled**
:  A boolean specifying if drag is enabled. 


**-dragendcmd**
:  Specifies a command to be called when drag ended. **dragendcmd** must be a command conforming to the description of the option **dragendcmd** of **DragSite::register**. 


**-dragevent**
:  Specifies the number of the mouse button associated to the drag. Must be **1**, **2** or **3**. 


**-draginitcmd**
: ListBox has a command wrapper for *drag-init* events. This command refused the drag if no item is designated. In other cases:   
  If **draginitcmd** is empty, it returns:

      - the value of option **dragtype** or *LISTBOX_ITEM* if empty as the data type, 
      - *{move copy link}* as the operations, 
      - the item identifier as the data. 

    If **draginitcmd** is not empty, it is called with the following arguments:

      - the pathname of the listbox, 
      - the identifier of the dragged item, 
      - the toplevel created to represent dragged data. 

    and must return a value conforming to **draginitcmd** option described in **DragSite::register**.


**-dragtype**
:  Specifies an alternate type of dragged object. 


**-dropcmd**
: ListBox has a command wrapper for *drop* events. This command stops auto scrolling and extract item and position.   
  If **dropcmd** is not empty, it is called with the following arguments:

      - the pathname of the listbox, 
      - the pathname of the drag source, 
      - a list describing where the drop occurs. It can be:  
      - the current operation, 
      - the data type, 
      - the data. 

        - *{*__widget__*}*, 
        - *{*__item__ *item}* or 
        - *{*__position__ *index}*. 

     The default drop command allows for drag-and-drop within the listbox but not to or from other widgets. 


**-dropenabled**
:  A boolean specifying if drop is enabled. 


**-dropovercmd**
: LsitBox has a command wrapper for *drag-over* events. This command enables auto scrolling and position extraction during the *drag-over*. If **dropovercmd** is not empty, the command is called with the following aguments:

      - the pathname of the listbox, 
      - the pathname of the drag source, 
      - a list describing where the drop can occur, whose elements are:  
      - the current operation, 
      - the data type, 
      - the data. 

        - the string *widget* if **dropovertype** option contains *w*, else empty string. 
        - the targeted item if drag icon points an item and **dropovertype** option contains *i*, else empty string. 
        - an index within two items where drag icon points to if **dropovertype** option contains *p*, else empty string. 
        - optionally, the preferred method if drop can occur both inside an item and between two items. The value is *position* or *item*. 

    The command must return a list with two elements:

      - the drop status, conforming to those described in **dropovercmd** option of **DropSite::register**, 
      - the choosen method: *widget*, *item* or *position*. 


**-dropovermode**
:  Specifies the type of *drop-over* interaction. Must be a combination of **w**, which specifies that drop can occurs everywhere on widget, **p**, which specifies that drop can occurs between two items, and **i**, which specifies that drop occurs inside items. 


**-droptypes**
:  Specifies a list of accepted dropped object/operation. See option **droptypes** of **DropSite::register**. for more infromation.   
  Default is *LISTBOX_ITEM* with operations **copy** and **move**. 


**-height**
:  Specifies the desired height for the listbox in units of **deltay** pixels. 


**-multicolumn**
:  Specifies wether or not ListBox layouts items in order to see each one vertically. 


**-padx**
:  Specifies distance between image or window and text of the items. 


**-redraw**
:  Specifies wether or not the listbox should be redrawn when entering idle. Set it to false if you call **update** while modifying the listbox. 


**-selectfill**
:  If true, the listbox will draw a selection rectangle that fills the listbox from left-to-right instead of just drawing a box around the selected item. This more closely mimics the standard Tk listbox. 


**-selectmode**
:  Specifies the desired selection-mode for the listbox. Must be one of **none**, **single** or **multiple**. **selectmode** *single* allows to select 1 item by its text or image. **selectmode** *multiple* allows to select multiple items by their text or image. For more info on selectmodes *single* or *multiple*, see the Tk **listbox** command. Default value for **selectmode** is *none*. 


**-width**
:  Specifies the desired width for the listbox in units of 8 pixels. 


---

WIDGET COMMAND

*pathName* **bindImage** *event* *script* 
: This command associates a command to execute whenever the event sequence given by *event* occurs on the image of a item. The item idenfier on which the event occurs is appended to the command.

     Any occurrence of **%W** in *script* is substituted with the path of the listbox. 


*pathName* **bindText** *event* *script* 
: This command associates a command to execute whenever the event sequence given by *event* occurs on the label of a item. The item idenfier on which the event occurs is appended to the command.

     Any occurrence of **%W** in *script* is substituted with the path of the listbox. 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **delete** ?*arg...*? 
:  Deletes all items in *arg*. *arg* can be a list of items or a list of list of items. To delete all items, do *\$pathName delete \[\$pathName items\]*. 


*pathName* **edit** *item* *text* ?*verifycmd*? ?*clickres*? ?*select*? 
:  Provides a way for the user to edit in place the label of an item.   
  The command takes the initial text as argument and does not modify the label of the edited node, but returns an empty string if edition is canceled, or the typed text if edition is accepted.   
  When editing, the user can cancel by pressing Escape, or accept by pressing Return.   
  *clickres* specifies what to do if the user click outside the editable area. If *clickres* is 0 (the default), the edition is canceled. If *clickres* is 1, the edition is accepted. In all other case, the edition continues.   
  If edition is accepted and *modifycmd* is not empty, then it is called with the new text as argument and must return 1 to accept the new text, 0 to refuse it and continue edition.   
  *select* specifies wether or not the initial text should be selected. Default is 1. 


*pathName* **exists** *item* 
:  Returns 1 if *item* exists in the listbox, else 0. 


*pathName* **index** *item* 
:  Returns the position of *item* in the list. 


*pathName* **insert** *index* *item* ?*option value...*? 
:  Inserts a new item identified by *item* in the list at position *index*. 

     Any instance of *#auto* within the item name will be replaced by the number of the item in the order of insertion. 

     

    **-data**
    :  User data associated to the item. 

    **-fill**
    :  Specifies the foreground color of the label of the item. 

    **-font**
    :  Specifies a font for the label of the item. 

    **-image**
    :  Specifies an image to display at the left of the label of the item. **window** option override **image**. 

    **-indent**
    :  Specifies the amount of extra space in pixels at the left of the item. 

    **-text**
    :  Specifies the label of the item. 

    **-window**
    :  Specifies a pathname to display at the left of the label of the item. **window** option override **image**. 


*pathName* **item** *first* ?*last*? 
:  **Its use is deprecated. Use items instead.**  
   If *last* is omitted, returns the item at index *first* in the list, or an empty string if *first* refers to a non-existent element. If *last* is specified, the command returns a list whose elements are all of the items between *first* and *last*, inclusive. Both *first* and *last* may have any of the standard forms for indices. 


*pathName* **itemcget** *item* *option* 
:  Returns the current value of a configuration option for the item. *Option* may have any of the values accepted by the item creation command. 


*pathName* **itemconfigure** *item* ?*option*? ?*value* *option* *value* ...? 
:  This command is similar to the **configure** command, except that it applies to the options for an individual item, whereas **configure** applies to the options for the widget as a whole. **Options** may have any of the values accepted by the item creation widget command. If options are specified, options are modified as indicated in the command and the command returns an empty string. If no options are specified, returns a list describing the current options for the item. Read-only options are not be modified. 


*pathName* **items** ?*first*? ?*last*? 
:  If *first* and *last* are omitted, returns the list of all items. If *first* is specified and *last* omitted, returns the item at index *first*, or an empty string if *first* refers to a non-existent element. If *first* and *last* are specified, the command returns a list whose elements are all of the items between *first* and *last*, inclusive. Both *first* and *last* may have any of the standard forms for indices. 


*pathName* **move** *item* *index* 
:  Moves *item* at position *index* in the list. 


*pathName* **reorder** *neworder* 
:  Modifies the order of items in the listbox given by *neworder*. Items that do not appear in *neworder* are no moved. 


*pathName* **see** *item* 
:  Arrange the scrolling area to make *item* visible. 


*pathName* **selection** *cmd* ?*arg...*? 
: Modifies the list of selected items following *cmd*:

    **clear** 
    : remove all items of the selection. 

    **set** 
    : set the selection to all items in *arg* 

    **add** 
    : add all items of *arg* in the selection 

    **remove** 
    : remove all items of *arg* of the selection 

    **get** 
    : return the current selected items 


*pathName* **xview** ?*arg...*? 
:  Standard command to enable horizontal scrolling of *pathName*. 


*pathName* **yview** ?*arg...*? 
:  Standard command to enable vertical scrolling of *pathName*. 


BINDINGS

 A **<\<ListboxSelect>>** virtual event is generated any time the selection in the listbox changes. 

 The listbox has all the standard mouse wheel bindings when it has focus.
