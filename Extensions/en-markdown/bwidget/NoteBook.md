*NAME*
: **NoteBook** - Notebook manager widget 


*CREATION*
: NoteBook *pathName* ?*option value...*?


*STANDARD OPTIONS*
: [-font](options.md)


*OPTIONS from ArrowButton*
: 

    |   |   |
    | --- | --- |
    |   -activebackground |   -activeforeground |
    |   -background or -bg |   -borderwidth or -bd |
    |   -disabledforeground |   -foreground or -fg |
    |   -repeatdelay |   -repeatinterval |


*WIDGET-SPECIFIC OPTIONS*
: 

    |   |   |
    | --- | --- |
    |   -arcradius |   -height |
    |   -homogeneous |   -side |
    |   -tabbevelsize |   -tabpady |
    |   -width |


*WIDGET COMMAND*
: *pathName* bindtabs *event* *script* 

: *pathName* cget *option* 

: *pathName* compute_size 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* delete *page* ?*destroyframe*? 

: *pathName* getframe *page* 

: *pathName* index *page* 

: *pathName* insert *index* *page* ?*option value...*? 

: *pathName* itemcget *page* *option* 

: *pathName* itemconfigure *page* ?*option*? ?*value* *option* *value* ...? 

: *pathName* move *page* *index* 

: *pathName* page *first* ?*last*? 

: *pathName* pages ?*first*? ?*last*? 

: *pathName* raise ?*page*? 

: *pathName* see *page* 


---

DESCRIPTION

 NoteBook widget manage a set of pages and displays one of them. 

---

WIDGET-SPECIFIC OPTIONS

**-arcradius**
:  Specifies the amount of rounding effect at the corners of a tab. This value can be adjusted from 0 to 8 pixels with the default being 2 pixels. Usually, small values are preferable. 


**-height**
:  Specifies the desired height for the pages. If this option is equal to zero (the default) then the window will not request any size at all. In this case, user may want to call NoteBook::**compute_size** to make NoteBook larger enough to contains the largest page. 


**-homogeneous**
:  Specifies wether or not the label of the pages must have the same width. 


**-side**
:  Specifies the side where to place the label of the pages. Must be one of **top** or **bottom**. 


**-tabbevelsize**
:  Specifies the amount of bevel the tabs should have. This value can be adjusted from 0 to 8 pixels with the default being 0 pixels. A zero pixel bevel is essentially rectangular while non-zero bevel size will look trapezoidal. 


**-tabpady**
:  Specifies the padding between the text in the tab and the top and bottom of the tab. Padding may be a list of two values to specify padding for top and bottom separately. Padding defaults to {0 6}. 


**-width**
:  Specifies the desired width for the pages. If this option is equal to zero (the default) then the window will not request any size at all. In this case, user may want to call NoteBook::**compute_size** to make NoteBook larger enough to contains the largest page. 


---

WIDGET COMMAND

*pathName* **bindtabs** *event* *script* 
:  This command associates a command to execute whenever the event sequence given by *event* occurs on a tab. The page identifier on which the event occurs is appended to the command. 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **compute_size** 
:  This command can be called to make the NoteBook large enough to contain the largest page. Note that if all pages use -createcmd, they will have no requested size. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **delete** *page* ?*destroyframe*? 
:  Deletes the page *page*. If *destroyframe* is 1 (the default), the frame associated to *page* is destroyed. If *destroyframe* is 0, the frame is not destroyed and is reused by further call to **insert** with the same *page*. 


*pathName* **getframe** *page* 
:  Returns the pathname of the page *page*. 


*pathName* **index** *page* 
:  Return the numerical index corresponding to the item. 


*pathName* **insert** *index* *page* ?*option value...*? 
: Insert a new page idendified by *page* at position *index* in the pages list. *index* must be numeric or **end**. The pathname of the new page is returned.

    **-createcmd**
    :  Specifies a command to be called the first time the page is raised. 

    **-image**
    :  Specifies an image to display for the page at the left of the label 

    **-leavecmd**
    :  Specifies a command to be called when a page is about to be leaved. The command must return 0 if the page can not be leaved, or 1 if it can. 

    **-raisecmd**
    :  Specifies a command to be called each time the page is raised. 

    **-state**
    :  Specifies the state of the page. Must be **normal** or **disabled**. 

    **-text**
    :  Specifies a label to display for the page. 


*pathName* **itemcget** *page* *option* 
:  Returns the current value of a configuration option for the item. *Option* may have any of the values accepted by the item creation command. 


*pathName* **itemconfigure** *page* ?*option*? ?*value* *option* *value* ...? 
:  This command is similar to the **configure** command, except that it applies to the options for an individual item, whereas **configure** applies to the options for the widget as a whole. **Options** may have any of the values accepted by the item creation widget command. If options are specified, options are modified as indicated in the command and the command returns an empty string. If no options are specified, returns a list describing the current options for the item. Read-only options are not be modified. 


*pathName* **move** *page* *index* 
:  Moves *page* tab to index *index*. 


*pathName* **page** *first* ?*last*? 
:  **Its use is deprecated. Use pages instead.**  
   If *last* is omitted, returns the page at index *first*, or an empty string if *first* refers to a non-existent element. If *last* is specified, the command returns a list whose elements are all of the pages between *first* and *last*, inclusive. Both *first* and *last* may have any of the standard forms for indices. 


*pathName* **pages** ?*first*? ?*last*? 
:  If *first* and *last* are omitted, returns the list of all pages. If *first* is specified and *last* omitted, returns the page at index *first*, or an empty string if *first* refers to a non-existent element. If *first* and *last* are specified, the command returns a list whose elements are all of the pages between *first* and *last*, inclusive. Both *first* and *last* may have any of the standard forms for indices. 


*pathName* **raise** ?*page*? 
:  Raise the page *page*, or return the raised page if *page* is omitted. 


*pathName* **see** *page* 
:  Scrolls labels to make the label of the page *page* visible.
