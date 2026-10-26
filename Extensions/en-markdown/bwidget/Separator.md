*NAME*
: **Separator** - 3D separator widget 


*CREATION*
: Separator *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

|   |   |
| --- | --- |
|   [-background or -bg](options.md) |   [-orient](options.md) |


*WIDGET-SPECIFIC OPTIONS*
: -relief


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

DESCRIPTION

 Separator is a widget that display an horizontal or vertical 3-D line. 

---

WIDGET-SPECIFIC OPTIONS

**-relief**
:  Specifies the relief of the Separator. Must be **groove** (the default) or **ridge**. 


---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified.
