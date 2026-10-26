*NAME*
: **PagesManager** - Pages manager widget 


*CREATION*
: PagesManager *pathName* ?*option value...*?


*STANDARD OPTIONS*
: [-background](options.md)


*WIDGET-SPECIFIC OPTIONS*
: -height


*WIDGET COMMAND*
: *pathName* add *page* 

: *pathName* cget *option* 

: *pathName* compute_size 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* delete *page* 

: *pathName* getframe *page* 

: *pathName* page *first* ?*last*? 

: *pathName* pages ?*first*? ?*last*? 

: *pathName* raise ?*page*? 


---

DESCRIPTION

 PagesManager widget manages a set of pages and displays one of them. PagesManager does not provide any user access method, as NoteBook does, so it can be done through a listbox, a menu, radiobutton, or whatever. The widget shows no pages during creation; there must be an explicit call to **raise** to display one. 

---

WIDGET-SPECIFIC OPTIONS

**-height**
:  Specifies the desired height for the pages. If this option is equal to zero (the default) then the window will not request any size at all. In this case, user may want to call PagesManager::**compute_size** to make PagesManager larger enough to contains the largest page. 


**-width**
:  Specifies the desired width for the pages. If this option is equal to zero (the default) then the window will not request any size at all. In this case, user may want to call PagesManager::**compute_size** to make PagesManager larger enough to contains the largest page. 


---

WIDGET COMMAND

*pathName* **add** *page* 
:  Add a new page identified by *page*, which is an arbitrary identifier. The pathname of the new page is returned and widgets for the page should be created with this as the parent or ancestor. However, PagesManager manages its own geometry. **pack**, **grid** or an equivalent should not be used with the pathname returned by **add**. 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **compute_size** 
:  This command can be called to make the PagesManager large enough to contain the largest page. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **delete** *page* 
:  Deletes the page *page*. 


*pathName* **getframe** *page* 
:  Returns the pathname of the page *page*. 


*pathName* **page** *first* ?*last*? 
:  **Its use is deprecated. Use pages instead.**  
   If *last* is omitted, returns the page at index *first*, or an empty string if *first* refers to a non-existent element. If *last* is specified, the command returns a list whose elements are all of the pages between *first* and *last*, inclusive. Both *first* and *last* may have any of the standard forms for indices. 


*pathName* **pages** ?*first*? ?*last*? 
:  If *first* and *last* are omitted, returns the list of all pages. If *first* is specified and *last* omitted, returns the page at index *first*, or an empty string if *first* refers to a non-existent element. If *first* and *last* are specified, the command returns a list whose elements are all of the pages between *first* and *last*, inclusive. Both *first* and *last* may have any of the standard forms for indices. 


*pathName* **raise** ?*page*? 
:  Raise the page *page*, or return the raised page if *page* is omitted.
