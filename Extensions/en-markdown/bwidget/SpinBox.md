*NAME*
: **SpinBox** - SpinBox widget 


*CREATION*
: SpinBox *pathName* ?*option value...*?


*OPTIONS from ArrowButton*
: 

    |   |   |
    | --- | --- |
    |   -background or -bg |   -disabledforeground |
    |   -foreground or -fg |   -repeatdelay |
    |   -repeatinterval |   -state |


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

    |   |
    | --- |
    |   -modifycmd |
    |   -range |
    |   -values |


*WIDGET COMMAND*
: *pathName* bind ?*arg...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getvalue 

: *pathName* setvalue *index* 


---

DESCRIPTION

 SpinBox widget enables the user to select a value among a list given by the **values** option or a set of values defined by a mininum, a maximum and an increment. Notice that **range** option defines a list of values, so **getvalue** and **setvalue** work with both values and range. 

---

WIDGET-SPECIFIC OPTIONS

**-modifycmd**
:  Specifies a Tcl command called when the user modify the value of the SpinBox. 


**-range**
:  Specifies a list of three intergers (or real) describing the minimum, maximum and increment of the SpinBox. 


**-values**
:  Specifies the values accepted by the SpinBox. This option takes precedence over **range** option. 


---

WIDGET COMMAND

*pathName* **bind** ?*arg...*? 
:  Set bindings on the entry widget. 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


*pathName* **getvalue** 
:  Returns the index of the current text of the SpinBox in the list of values, or -1 if it doesn't match any value. 


*pathName* **setvalue** *index* 
: Set the text of the SpinBox to the value indicated by *index* in the list of values. *index* may be specified in any of the following forms:

     

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


---

BINDINGS

When Entry of the SpinBox has the input focus, it has the following bindings, in addition
to the default Entry bindings:

- Page up set the value of the SpinBox to the last value. 
- Page down set the value of the SpinBox to the first value. 
- Arrow up set the value of the SpinBox to the next value. 
- Arrow down set the value of the SpinBox to the previous value.
