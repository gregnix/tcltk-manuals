*NAME*
: **PasswdDlg** - Login/Password dialog box 


*CREATION*
: PasswdDlg *pathName* ?*option value...*?


*OPTIONS from Dialog*
: 

|   |   |
| --- | --- |
|   -anchor |   -background or -bg |
|   -homogeneous |   -modal |
|   -padx |   -pady |
|   -parent |   -spacing |
|   -title |


*OPTIONS from LabelEntry*
: 

|   |   |
| --- | --- |
|   -background or -bg |   -borderwidth or -bd |
|   -disabledforeground |   -entrybg |
|   -entryfg |   -exportselection |
|   -font |   -foreground or -fg |
|   -helptype |   -highlightbackground |
|   -highlightcolor |   -highlightthickness |
|   -insertbackground |   -insertborderwidth |
|   -insertofftime |   -insertontime |
|   -insertwidth |   -labelanchor |
|   -labelfont |   -labelheight |
|   -labeljustify |   -labelwidth |
|   -loginhelptext (see **-helptext**) |   -loginhelpvar (see **-helpvar**) |
|   -loginlabel (see **-label**) |   -logintext (see **-text**) |
|   -logintextvariable (see **-textvariable**) |   -loginunderline (see **-underline**) |
|   -passwdeditable (see **-editable**) |   -passwdhelptext (see **-helptext**) |
|   -passwdhelpvar (see **-helpvar**) |   -passwdlabel (see **-label**) |
|   -passwdstate (see **-state**) |   -passwdtext (see **-text**) |
|   -passwdtextvariable (see **-textvariable**) |   -passwdunderline (see **-underline**) |
|   -relief |   -selectbackground |
|   -selectborderwidth |   -selectforeground |
|   -wraplength |


*WIDGET-SPECIFIC OPTIONS*
: 

|   |
| --- |
|   -command |
|   -type |


*WIDGET COMMAND*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

DESCRIPTION

 PasswdDlg provides a simple way to display a login/password dialog. PasswdDlg::**create** creates the dialog, displays it, and return the value of login and password in a list, or an empty list if it is destroyed or user press cancel. When returning, the dialog no longer exists.   
Additionnal resources can be set to modify other text: 

```
    *loginName     Label for login LabelEntry
    *passwordName  Label for password LabelEntry
```

---

WIDGET-SPECIFIC OPTIONS

**-command**
:  Specifies a command to call when user press ok button. 


**-type**
:  Specifies a set of buttons to be displayed. The following values are possible: 

:  

 **ok** 
: Displays one button whose symbolic name is **ok**.

 

okcancel

Displays two buttons whose symbolic names are **ok** and **cancel**.

 



---

WIDGET COMMAND

*pathName* **cget** *option* 
:  Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the creation command. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName*. If *option* is specified with no *value*, then the command returns a list describing the one named *option* (this list will be identical to the corresponding sublist of the value returned if no *option* is specified). If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the command returns an empty string. *Option* may have any of the values accepted by the creation command. Read-only options are not be modified. 


---

Stephane Lavirotte

(Stephane.Lavirotte@sophia.inria.fr)
