 

## NAME

 mclistbox::mclistbox - Create and manipulate a multi-column listbox 

 

## SYNOPSIS

 **package require mclistbox ?1.02** 

 **mclistbox::mclistbox** *pathName* *?options?* 

 

## EXPORTS

 mclistbox 

 

## STANDARD OPTIONS

 **-background** **-borderwidth** **-cursor** **-exportselection** **-font** **-foreground** **-height** **-highlightbackground** **-highlightcolor** **-highlightthickness** **-relief** **-selectbackground** **-selectborderwidth** **-selectforeground** **-setgrid** **-takefocus** **-width** **-xscrollcommand** **-yscrollcommand** 

 See the *options* manual entry for detailed descriptions of the above options. 

 

## WIDGET-SPECIFIC OPTIONS

 Command-Line Name: **-columnborderwidth**   
 Database Name: **columnBorderWidth**  
 Database Class: **BorderWidth** 

 Specifies a non-negative value indicating the width of the 3-D border to draw around the outside of the column (if such a border is being drawn; the **columnrelief** option typically determines this). The value may also be used when drawing 3-D effects in the interior of the widget. The value may have any of the forms acceptable to Tk_GetPixels. 

 Command-Line Name: **-columnrelief**   
 Database Name: **columnRelief**   
 Database Class: **Relief** 

 Specifies the 3-D effect desired for the column. Acceptable values are raised, **sunken**, **flat**, **ridge**, **solid**, and **groove**. The value indicates how the interior of the column should appear relative to its exterior; for example, raised means the interior of the column should appear to protrude from the screen, relative to the exterior of the column. 

 Command-Line Name: **-fillcolumn**   
 Database Name: **fillColumn**  
 Database Class: **FillColumn** 

 Specifies which column should grow or shrink such that all columns exactly fill the listbox widget. 

 Command-Line Name: **-labelanchor**   
 Database Name: **labelAnchor**  
 Database Class: **Anchor** 

 Specifies how the information in the column label is to be displayed. Must be one of the values **n**, **ne**, **e**, **se**, **s**, **sw**, **w**, **nw**, or **center**. For example, nw means display the information such that its top-left corner is at the top-left corner of the column label. 

 Command-Line Name: **-labelbackground** or **-labelbg**  
 Database Name: **labelBackground**   
 Database Class: **Background** 

 Specifies the normal background color to use when displaying the label. 

 Command-Line Name: **-labelborderwidth or -labelbd**   
 Database Name: **labelBorderWidth**   
 Database Class: **BorderWidth** 

 Specifies a non-negative value indicating the width of the 3-D border to draw around the outside of the column label (if such a border is being drawn; the relief option typically determines this). The value may also be used when drawing 3-D effects in the interior of the column label. The value may have any of the forms acceptable to Tk_GetPixels. 

 Command-Line Name: **-labelfont**   
 Database Name: **labelFont**   
 Database Class: **Font** 

 Specifies the font to use when drawing text inside the column label. 

 Command-Line Name: **-labelforeground**   
 Database Name: **labelForeground**   
 Database Class: **Foreground** 

 Specifies the normal foreground color to use when displaying the column label. 

 Command-Line Name: **-labelheight**   
 Database Name: **labelHeight**  
 Database Class: **Height** 

 Specifies a desired height for the label. If an image or bitmap is being displayed in the label then the value is in screen units (i.e. any of the forms acceptable to Tk_GetPixels); for text it is in lines of text. If this option isn't specified, the label's desired height is computed from the size of the image or bitmap or text being displayed in it. 

 Command-Line Name: **-labelrelief**   
 Database Name: **labelRelief**  
 Database Class: **Relief** 

 Specifies the 3-D effect desired for the column label. Acceptable values are **raised**, **sunken**, **flat**, **ridge**, **solid**, and **groove**. The value indicates how the interior of the column label should appear relative to its exterior; for example, raised means the interior of the column label should appear to protrude from the screen, relative to the exterior of the column label. 

 Command-Line Name: **-labels**   
 Database Name: **labels**  
 Database Class: **Labels** 

 A boolean value which determines whether column labels are shown or not. 

 Command-Line Name: **-selectcommand** *command*   
 Database Name: **selectCommand**  
 Database Class: **Command** 

 Specifies a Tcl command to be run whenever the selection in the mclistbox changes. The command will be called with the result of the curselection command. 

 Command-Line Name: **-resizablecolumns**   
 Database Name: **resizableColumns**   
 Database Class: **ResizableColumns** 

 Specifies whether the columns can be resized interactively. If set to true, mouse bindings will be defined to allow the columns to be resized. See **DEFAULT BINDINGS** for more information. 

 Command-Line Name: **-selectmode**   
 Database Name: **selectMode**  
 Database Class: **SelectMode** 

 Specifies one of several styles for manipulating the selection. The value of the option may be arbitrary, but the default bindings expect it to be either **single**, **browse**, **multiple**, or **extended**; the default value is browse. 

 

## DESCRIPTION

 The **mclistbox** command creates a new window (given by the *pathName* argument) and makes it into a mclistbox widget. Additional options, described above, may be specified on the command line to configure aspects of the mclistbox such as its colors, font, text, and relief. The mclistbox command returns its pathName argument. At the time this command is invoked, there must not exist a window named pathName, but pathName's parent must exist. 

 A mclistbox is a widget that displays a list of strings, one per line. When first created, a new mclistbox has no elements and no columns. Columns and elementd may be added or deleted using widget commands described below. In addition, one or more elements may be selected as described below. When an element in one column is selected, the elements in all columns are selected. 

 It is not necessary for all the elements to be displayed in the mclistbox window at once; commands described below may be used to change the view in the window. Mclistboxes allow scrolling in both directions using the standard xScrollCommand and yScrollCommand options. They also support scanning, as described below. 

 

## WIDGET COMMAND

 The widget command accepts many of the same arguments as the standard listbox command. The following commands behave identically to the standard listbox commands: 

 **activate** **bbox** **cget** **configure** **curselection** **delete** **index** **nearest** **scan** **see** **selection** **size** **xview** **yview** 

 In addition, there are a few commands unique to the mclistbox: 

**pathName column option args**
: 

**pathName column add name options**
:  Adds a new column with the specified *name*. *options* may be any of the valid column configuration options. 

pathName column cget name option

 Returns the value for the named *option* 

pathName column configure name options

 Configures or queries attributes of the *named* column. 

 Columns may be configured with the standard listbox options (-background, -font, etc). In addition, the following options are available: 

**-background**
:  Specifies the background color for this column. If the value is an empty string the column will be configured with the default background color. 

-bitmap

 Specifies a bitmap to display in the column label. If the bitmap option is specified then it overrides the -label option. the bitmap option may be reset to an empty string to re-enable a text display. 

-font

 Specifies the font for this column. If the value is an empty string the column will be configured with the default font. Note that if fonts with different line heights are used for separate columns, the data in each column will not line up properly. 

-foreground

 Specifies the foreground color for this column. If the value is an empty string the column will be configured with the default foreground color. 

-image

 Specifies an image to display in the column label. If the image option is specified then it overrides other options that specify a bitmap or textual value to display in the column label; the image option may be reset to an empty string to re-enable a bitmap or text display. 

-label

 Specifies the desired text to be used in the column label. 

-position

 Specifies the position of the column. 0 (zero) is the first column, 1 (one) is the second and so on. 

-resizable

 Specifies whether the column is resizable. This only takes effect if the global option **-resizablecolumns** is true. 

-visible

 Specifies whether the column is visible or not. 

-width

 Specifies the desired width of the column in characters. If the font doesn't have a uniform width then the width of the character \`\`0'' is used in translating from character units to screen units. If zero or less, then the desired width for the window is made just large enough to hold all the elements in the listbox. 


pathName column delete name

 Deletes the column identified by *name* 

pathName column names

 Returns a list containing all of the column *names*. The order of the list is the same as the visual order of the columns, and is the same as the order the data is returned by the get command. 

pathName column nearext x

 Given a x-coordinate within the mclistbox window, this command returns the name of the column nearest to that x-coordinate. 


pathName get first ?last?

 If last is omitted, returns a list containing the element from each column of the listbox element indicated by *first*, or an empty list if first refers to a non-existent element. If *last* is specified, the command returns a list of lists. Each of the sublists will contain an element from each column of the mclistbox element. Both first and last may have any of the standard forms for indices. 

 The data will be returned in the order that the columns appear visually, and is the same order as reported by the **column names** command. 

pathName insert index list ?list ...?

 Inserts zero or more new elements in the mclistbox just before the element given by index. If index is specified as end then the new elements are added to the end of the list. Returns an empty string. Each *list* argument becomes one row in the mclistbox. If there are not enough elements to fill all of the columns, blank values will be used to fill in the missing columns. 

pathName label bind name sequence command

 This command associates *command* with a column label such that whenever the event sequence given by *sequence* occurs over the label for the column named *name* the *command* will be invoked. This widget command is similar to the bind command except that it operates on column labels rather than the entire widget. See the bind manual entry for complete details on the syntax of *sequence* and the substitutions performed on *command* before invoking it. 


 

## EXAMPLE

 The following example creates a listbox with three columns: 

 

```
    mclistbox .listbox -width 55
```

 

```
    .listbox column add name -label "First Name"    -width 20
    .listbox column add size -label "Last Name"     -width 20
    .listbox column add mod  -label "Organization"  -width 15
```

 To add items to the list, do the following: 

 

```
    .listbox insert end [list "Bryan" "Oakley" "ChannelPoint"]
    .listbox insert end [list "John"  "Ousterhout" "Ajuba Solutions"]
```

 ... or more concisely: 

 

```
    .listbox insert end \
            [list "Bryan" "Oakley" "ChannelPoint"] \
            [list "John"  "Ousterhout" "Ajuba Solutions"]
```

 To cause a proc to be called when the user clicks on the column label of the column named \`\`date'', use \`\`label bind'' as in the following example: 

 

```
    .listbox label bind date <ButtonPress-1> "sortByDate %W"
```

 

```
    proc sortByDate {w} {
        # code to sort the contents of the mclistbox named $w
    }
```

 

## DEFAULT BINDINGS

 Bindings in the mclistbox widget are the same as for a standard listbox widget. In addition, if **-resizableColumns** is set to true, the following additional bindings are set: 

 **ButtonPress-1** starts a column resize if the cursor is over a column header and within a few pixels of the left or right edge of the label. **B1-Motion** causes the columns on either side of the cursor to be resized based on the amount the cursor has moved. **ButtonRelease-1** ends the column resize. 

 If a binding is set on a label via the **label bind** command and **-resizablecolumns** is set, the binding will not fire the event happens in the few pixels inside the left and right edges of the label where a resize can occur. This is to prevent both the label bindings and resize events to happen with a single button press. 

 

## BUGS

 If you use different fonts for different columns, the data will not line up properly if those fonts don't have the same line height. There is currently no workaround other than to use fonts with the same line height. 

 Mixing labels and images in column headers can produce unevenly sized headers, which in turn will cause the data in the columns not to line up properly. 

 Event bindings that fire while the mouse cursor is over a column return wrong values for %W, `%x` and %y. The returned values represent the internal widgets clicked over rather than relative to the mclistbox widget (there's no way to work around this in tk as of 8.1b2). To convert a value returned for the `%W` keyword, use the function ::mclistbox::convert. Sorry, no real documentation here; see the example (example.tcl) that comes with this distribution 

 The command \`\`\<pathName> xview index'' doesn't work. 

 I'm sure there are others...
