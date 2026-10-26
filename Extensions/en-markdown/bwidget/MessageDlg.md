*NAME*
: **MessageDlg** - Message dialog box 


*CREATION*
: MessageDlg *pathName* ?*option value...*?


*STANDARD OPTIONS*
: 

|   |   |
| --- | --- |
|   [-anchor](options.md) |   [-font](options.md) |
|   [-foreground or -fg](options.md) |   [-padx](options.md) |
|   [-pady](options.md) |


*OPTIONS from Dialog*
: 

|   |   |
| --- | --- |
|   -background or -bg |   -cancel |
|   -default |   -parent |


*WIDGET-SPECIFIC OPTIONS*
: 

|   |   |
| --- | --- |
|   -aspect |   -buttons |
|   -buttonwidth |   -icon |
|   -justify |   -message |
|   -title |   -type |
|   -width |


---

DESCRIPTION

 MessageDlg provides a simple way to display a message dialog. MessageDlg::**create** creates the message dialog, displays it and return the index of the pressed button, or -1 if it is destroyed. When returning, the dialog no longer exists. 

---

WIDGET-SPECIFIC OPTIONS

**-aspect**
:  Specifies a non-negative integer value indicating desired aspect ratio for the text. The aspect ratio is specified as 100\*width/height. 100 means the text should be as wide as it is tall, 200 means the text should be twice as wide as it is tall, 50 means the text should be twice as tall as it is wide, and so on. Used to choose line length for text if **width** option isn't specified. Defaults to 150. 


**-buttons**
:  Specifies a list of buttons to display when **type** option is *user*. If a button has a symbolic name, its associated text will be displayed. 


**-buttonwidth**
:  Specifies the standard width of the buttons in the dialog. 


**-icon**
:  Specifies an icon to display. Must be one of the following: **error**, **info**, **question** or **warning**. 


**-justify**
:  Specifies how to justify lines of text. Must be one of **left**, **center**, or **right**. Defaults to **left**. This option works together with the **anchor**, **aspect**, **padx**, **pady**, and **width** options to provide a variety of arrangements of the text within the window. The **aspect** and **width** options determine the amount of screen space needed to display the text. The **anchor**, **padx**, and **pady** options determine where this rectangular area is displayed within the widget's window, and the **justify** option determines how each line is displayed within that rectangular region. For example, suppose **anchor** is **e** and **justify** is **left**, and that the message window is much larger than needed for the text. The the text will displayed so that the left edges of all the lines line up and the right edge of the longest line is **padx** from the right side of the window; the entire text block will be centered in the vertical span of the window. 


**-message**
:  Specifies the message to display in this message box. 


**-title**
: Specifies a string to display as the title of the message box. If the value is empty (the default), a default title will be set corresponding to the **icon** option. The default associated title is in english, and can be modified to set it in another language by specifying the resource:

```
    *MessageDlg.nameTitle:   value
```

or the equivalent tcl command:

```
    option add *MessageDlg.nameTitle value
```

where *name* is the name of an icon as defined in the **icon** option.   
For example, for french language, you can specify for a warning dialog:

```
    option add *MessageDlg.warningTitle  "Attention"
```


**-type**
:  Specifies a set of buttons to be displayed. The following values are possible: 

:  

 **abortretryignore** 
: Displays three buttons whose symbolic names are **abort**, **retry** and **ignore**.

 

ok

Displays one button whose symbolic name is **ok**.

 

okcancel

Displays two buttons whose symbolic names are **ok** and **cancel**.

 

retrycancel

Displays two buttons whose symbolic names are **retry** and **cancel**.

 

yesno

Displays two buttons whose symbolic names are **yes** and **no**.

 

yesnocancel

Displays three buttons whose symbolic names are **yes**, **no** and **cancel**.

 

user

Displays buttons of **-buttons** option.

 



**-width**
:  Specifies the length of lines in the window. If this option has a value greater than zero then the **aspect** option is ignored and the **width** option determines the line length. If this option has a value less than or equal to zero, then the **aspect** option determines the line length.
