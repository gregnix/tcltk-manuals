*NAME*
: **LabelEntry** - LabelFrame containing an Entry widget. 


*CREATION*
: LabelEntry *pathName* ?*option value...*?


*OPTIONS from Entry*
: 

|   |   |
| --- | --- |
|   -borderwidth or -bd |   -command |
|   -disabledforeground |   -dragenabled |
|   -dragendcmd |   -dragevent |
|   -draginitcmd |   -dragtype |
|   -dropcmd |   -dropenabled |
|   -dropovercmd |   -droptypes |
|   -editable |   -entrybg (see **-background**) |
|   -entryfg (see **-foreground**) |   -exportselection |
|   -font |   -helptext |
|   -helptype |   -helpvar |
|   -highlightbackground |   -highlightcolor |
|   -highlightthickness |   -insertbackground |
|   -insertborderwidth |   -insertofftime |
|   -insertontime |   -insertwidth |
|   -justify |   -relief |
|   -selectbackground |   -selectborderwidth |
|   -selectforeground |   -show |
|   -state |   -takefocus |
|   -text |   -textvariable |
|   -width |   -xscrollcommand |


*OPTIONS from LabelFrame*
: 

|   |   |
| --- | --- |
|   -background or -bg |   -disabledforeground |
|   -foreground or -fg |   -helptext |
|   -helptype |   -helpvar |
|   -label (see **-text**) |   -labelanchor (see **-anchor**) |
|   -labelfont (see **-font**) |   -labelheight (see **-height**) |
|   -labeljustify (see **-justify**) |   -labelwidth (see **-width**) |
|   -name |   -padx |
|   -pady |   -side |
|   -state |   -underline |
|   -wraplength |


*WIDGET COMMAND*
: *pathName* bind ?*arg...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

DESCRIPTION

 LabelEntry is a widget composed of [LabelFrame](LabelFrame.md) widget containing an [Entry](Entry.md) widget. Tk entry command can also be used on LabelEntry widget. 

---

WIDGET COMMAND

*pathName* **bind** ?*arg...*? 
:  Set bindings on the entry widget. 


*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified.
