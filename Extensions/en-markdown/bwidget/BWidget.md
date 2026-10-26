

Under construction ...

*NAME*
: **BWidget** - Description text 


*COMMAND*
: BWidget::XLFDfont *cmd* ?*arg...*? 

: BWidget::assert *exp* ?*msg*? 

: BWidget::badOptionString *type* *value* *list* 

: BWidget::bindMouseWheel *widget* 

: BWidget::classes *class* 

: BWidget::clonename *menu* 

: BWidget::focus *option* *path* 

: BWidget::get3dcolor *path* *bgcolor* 

: BWidget::getname *name* 

: BWidget::grab *option* *path* 

: BWidget::inuse *class* 

: BWidget::library *class* ?*class ...*? 

: BWidget::lreorder *list* *neworder* 

: BWidget::parsetext *text* 

: BWidget::place *path* *w* *h* ?*arg...*? 

: BWidget::write *filename* ?*mode*? 

: BWidget::wrongNumArgsString *string* 


---

DESCRIPTION

 Description text 

---

COMMAND

BWidget::**XLFDfont** *cmd* ?*arg...*? 
:  Description text 


BWidget::**assert** *exp* ?*msg*? 
:  Description text 


BWidget::**badOptionString** *type* *value* *list* 
:  Return a proper error string for a *value* of *type* that doesn't match *list*. 


BWidget::**bindMouseWheel** *widget* 
:  Bind the given *widget* with the standard mouse wheel bindings. 


BWidget::**classes** *class* 
:  Returns a list of classes needed by the given *class*. 


BWidget::**clonename** *menu* 
:  Description text 


BWidget::**focus** *option* *path* 
:  Description text 


BWidget::**get3dcolor** *path* *bgcolor* 
:  Description text 


BWidget::**getname** *name* 
:  Description text 


BWidget::**grab** *option* *path* 
:  Description text 


BWidget::**inuse** *class* 
:  Returns true or false if the given *class* is being used by the current running program. 


BWidget::**library** *class* ?*class ...*? 
:  Returns a string of code that contains all the libraries needed to use the widgets given by *class*. Each class's code and the code of its dependent classes is appended to the string and returned. This is mostly useful for saving BWidgets to another project. 


BWidget::**lreorder** *list* *neworder* 
:  Description text 


BWidget::**parsetext** *text* 
:  Description text 


BWidget::**place** *path* *w* *h* ?*arg...*? 
: Used to position and resize the widget specified by *path*. *w* and *h* are used to specify the requested width and height of the *path* widget for use by **wm geometry** (set to 0 to use current values). The placement of the widget relative to other widgets or the screen is controlled by additional arguments:

**at** *x* *y*
: Place the widget specified by the *path* argument at screen position x,y. See **wm geometry** for information about window placement values.

**center** *?widget?*
: Place the *path* widget centered against *widget* or against the root widget if *widget* is not given.

**right** *?widget?*
: Place the *path* widget either left or right of the reference widget (or the root widget if *widget* is not specified). If the reference widget's position is such that the newly placed window might be obscured then the opposite side will be tried.

**below** *?widget?*
: As for left/right above, this option causes the widget to be placed either above or below the reference widget with the opposite placement being attempted if the newly placed widget will not be visible. 



BWidget::**write** *filename* ?*mode*? 
:  Writes the currently used set of BWidget class code to the given *filename*. All the code necessary to run the BWidgets currently in use is written to the file. This is mostly useful for saving BWidget code to another project as a single file instead of the entire BWidget package. 


BWidget::**wrongNumArgsString** *string* 
:  Returns a standard error string for the wrong number of arguments. *string* is appended to the standard string.
