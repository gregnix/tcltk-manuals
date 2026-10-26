---
CommandName: Tk_ConfigureWidget
title: Tk_ConfigureWidget
ManualSection: 3
Version: 4.1
TclPart: Tk
TclDescription: Tk Library Procedures
Links:
 - Tk_SetOptions(3)
Keywords:
 - anchor
 - bitmap
 - boolean
 - border
 - cap style
 - color
 - configuration options
 - cursor
 - custom
 - double
 - font
 - integer
 - join style
 - justify
 - millimeters
 - pixels
 - relief
 - synonym
 - uid
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_ConfigureWidget, Tk\_ConfigureInfo, Tk\_ConfigureValue, Tk\_FreeOptions - process configuration options for widgets

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_ConfigureWidget]{.ccmd} [interp, tkwin, specs, objc, objv, widgRec, flags]{.cargs}
[int]{.ret} [Tk\_ConfigureInfo]{.ccmd} [interp, tkwin, specs, widgRec, argvName, flags]{.cargs}
[int]{.ret} [Tk\_ConfigureValue]{.ccmd} [interp, tkwin, specs, widgRec, argvName, flags]{.cargs}
[Tk\_FreeOptions]{.ccmd} [specs, widgRec, display, flags]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for returning error messages.

[tkwin]{.carg .in type="Tk_Window"}
: Window used to represent widget (needed to set up X resources).

[\*specs]{.carg .in type="const Tk_ConfigSpec"}
: Pointer to table specifying legal configuration options for this widget.

[objc]{.carg .in type="Tcl_Size"}
: Number of arguments in *objv*.

[objv]{.carg .in type="Tcl_Obj *const *"}
: Command-line options for configuring widget.

[\*widgRec]{.carg .in/out type="char"}
: Points to widget record structure.  Fields in this structure get modified by **Tk\_ConfigureWidget** to hold configuration information.

[flags]{.carg .in type="int"}
: If non-zero, then it specifies an OR-ed combination of flags that control the processing of configuration information. **TK\_CONFIG\_ARGV\_ONLY** causes the option database and defaults to be ignored, and flag bits **TK\_CONFIG\_USER\_BIT** and higher are used to selectively disable entries in *specs*.

[type]{.carg .in type="type name"}
: The name of the type of a widget record.

[field]{.carg .in type="field name"}
: The name of a field in records of type *type*.

[\*argvName]{.carg .in type="const char"}
: The name used on Tcl command lines to refer to a particular option (e.g. when creating a widget or invoking the **configure** widget command).  If non-NULL, then information is returned only for this option.  If NULL, then information is returned for all available options.

[\*display]{.carg .in type="Display"}
: Display containing widget whose record is being freed;  needed in order to free up resources.

:::

# Description

Note that **Tk\_ConfigureWidget** should be replaced with the new [Tcl\_Obj][Object] based API, [Tk\_SetOptions][SetOptions].  The old interface is retained for backward compatibility.

**Tk\_ConfigureWidget** is called to configure various aspects of a widget, such as colors, fonts, border width, etc. It is intended as a convenience procedure to reduce the amount of code that must be written in individual widget managers to handle configuration information. It is typically invoked when widgets are created, and again when the **configure** command is invoked for a widget. Although intended primarily for widgets, **Tk\_ConfigureWidget** can be used in other situations where *objc-objv* information is to be used to fill in a record structure, such as configuring graphical elements for a canvas widget or entries of a menu.

**Tk\_ConfigureWidget** processes a table specifying the configuration options that are supported (*specs*) and a collection of command-line arguments (*objc* and *objv*) to fill in fields of a record (*widgRec*). It uses the option database and defaults specified in *specs* to fill in fields of *widgRec* that are not specified in *objv*. **Tk\_ConfigureWidget** normally returns the value [TCL\_OK][catch]; in this case it does not modify *interp*. If an error occurs then [TCL\_ERROR][catch] is returned and **Tk\_ConfigureWidget** will leave an error message in interpreter *interp*'s result in the standard Tcl fashion. In the event of an error return, some of the fields of *widgRec* could already have been set, if configuration information for them was successfully processed before the error occurred. The other fields will be set to reasonable initial values so that **Tk\_FreeOptions** can be called for cleanup.

The *specs* array specifies the kinds of configuration options expected by the widget.  Each of its entries specifies one configuration option and has the following structure:

```
typedef struct {
    int type;
    const char *argvName;
    const char *dbName;
    const char *dbClass;
    const char *defValue;
    Tcl_Size offset;
    int specFlags;
    const Tk_CustomOption *customPtr;
} Tk_ConfigSpec;
```

The *type* field indicates what type of configuration option this is (e.g. **TK\_CONFIG\_COLOR** for a color value, or **TK\_CONFIG\_INT** for an integer value).  The *type* field indicates how to use the value of the option (more on this below). The *argvName* field is a string such as "-font" or "-bg", which is compared with the values in *objv* (if *argvName* is NULL it means this is a grouped entry;  see [Grouped entries] below).  The *dbName* and *dbClass* fields are used to look up a value for this option in the option database.  The *defValue* field specifies a default value for this configuration option if no value is specified in either *objv* or the option database. *Offset* indicates where in *widgRec* to store information about this option, and *specFlags* contains additional information to control the processing of this configuration option (see FLAGS below). The last field, *customPtr*, is only used if *type* is **TK\_CONFIG\_CUSTOM**;  see CUSTOM OPTION TYPES below.

**Tk\_ConfigureWidget** first processes *objv* to see which (if any) configuration options are specified there.  *Argv* must contain an even number of fields;  the first of each pair of fields must match the *argvName* of some entry in *specs* (unique abbreviations are acceptable), and the second field of the pair contains the value for that configuration option.  If there are entries in *spec* for which there were no matching entries in *objv*, **Tk\_ConfigureWidget** uses the *dbName* and *dbClass* fields of the *specs* entry to probe the option database;  if a value is found, then it is used as the value for the option. Finally, if no entry is found in the option database, the *defValue* field of the *specs* entry is used as the value for the configuration option.  If the *defValue* is NULL, or if the **TK\_CONFIG\_DONT\_SET\_DEFAULT** bit is set in *flags*, then there is no default value and this *specs* entry will be ignored if no value is specified in *objv* or the option database.

Once a string value has been determined for a configuration option, **Tk\_ConfigureWidget** translates the string value into a more useful form, such as a color if *type* is **TK\_CONFIG\_COLOR** or an integer if *type* is **TK\_CONFIG\_INT**.  This value is then stored in the record pointed to by *widgRec*.  This record is assumed to contain information relevant to the manager of the widget;  its exact type is unknown to **Tk\_ConfigureWidget**.  The *offset* field of each *specs* entry indicates where in *widgRec* to store the information about this configuration option.  You should use the **offsetof** macro to generate *offset* values.  The location indicated by *widgRec* and *offset* will be referred to as the "target" in the descriptions below.

The *type* field of each entry in *specs* determines what to do with the string value of that configuration option.  The legal values for *type*, and the corresponding actions, are:

**TK\_CONFIG\_ACTIVE\_CURSOR**
: The value must be an ASCII string identifying a cursor in a form suitable for passing to [Tk\_GetCursor][GetCursor]. The value is converted to a **Tk\_Cursor** by calling [Tk\_GetCursor][GetCursor] and the result is stored in the target. In addition, the resulting cursor is made the active cursor for *tkwin* by calling **XDefineCursor**. If **TK\_CONFIG\_NULL\_OK** is specified in *specFlags* then the value may be an empty string, in which case the target and *tkwin*'s active cursor will be set to **None**. If the previous value of the target was not **None**, then it is freed by passing it to [Tk\_FreeCursor][GetCursor].

**TK\_CONFIG\_ANCHOR**
: The value must be an ASCII string identifying an anchor point in one of the ways accepted by [Tk\_GetAnchor][GetAnchor]. The string is converted to a **Tk\_Anchor** by calling [Tk\_GetAnchor][GetAnchor] and the result is stored in the target.

**TK\_CONFIG\_BITMAP**
: The value must be an ASCII string identifying a bitmap in a form suitable for passing to [Tk\_GetBitmap][GetBitmap].  The value is converted to a **Pixmap** by calling [Tk\_GetBitmap][GetBitmap] and the result is stored in the target. If **TK\_CONFIG\_NULL\_OK** is specified in *specFlags* then the value may be an empty string, in which case the target is set to **None**. If the previous value of the target was not **None**, then it is freed by passing it to [Tk\_FreeBitmap][GetBitmap].

**TK\_CONFIG\_BOOLEAN**
: The value must be an ASCII string specifying a boolean value.  Any of the values "true", "yes", "on", or "1", or an abbreviation of one of these values, means true; any of the values "false", "no", "off", or "0", or an abbreviation of one of these values, means false. The target is expected to be an integer;  for true values it will be set to 1 and for false values it will be set to 0.

**TK\_CONFIG\_BORDER**
: The value must be an ASCII string identifying a border color in a form suitable for passing to [Tk\_Get3DBorder][3DBorder].  The value is converted to a (**Tk\_3DBorder \***) by calling [Tk\_Get3DBorder][3DBorder] and the result is stored in the target. If **TK\_CONFIG\_NULL\_OK** is specified in *specFlags* then the value may be an empty string, in which case the target will be set to NULL. If the previous value of the target was not NULL, then it is freed by passing it to [Tk\_Free3DBorder][3DBorder].

**TK\_CONFIG\_CAP\_STYLE**
: The value must be an ASCII string identifying a cap style in one of the ways accepted by [Tk\_GetCapStyle][GetCapStyl]. The string is converted to an integer value corresponding to the cap style by calling [Tk\_GetCapStyle][GetCapStyl] and the result is stored in the target.

**TK\_CONFIG\_COLOR**
: The value must be an ASCII string identifying a color in a form suitable for passing to [Tk\_GetColor][GetColor].  The value is converted to an (**XColor \***) by calling [Tk\_GetColor][GetColor] and the result is stored in the target. If **TK\_CONFIG\_NULL\_OK** is specified in *specFlags* then the value may be an empty string, in which case the target will be set to **None**. If the previous value of the target was not NULL, then it is freed by passing it to [Tk\_FreeColor][GetColor].

**TK\_CONFIG\_CURSOR**
: This option is identical to **TK\_CONFIG\_ACTIVE\_CURSOR** except that the new cursor is not made the active one for *tkwin*.

**TK\_CONFIG\_CUSTOM**
: This option allows applications to define new option types. The *customPtr* field of the entry points to a structure defining the new option type. See the section [Custom option types] below for details.

**TK\_CONFIG\_DOUBLE**
: The value must be an ASCII floating-point number in the format accepted by **strtol**.  The string is converted to a **double** value, and the value is stored in the target.

**TK\_CONFIG\_END**
: Marks the end of the table.  The last entry in *specs* must have this type;  all of its other fields are ignored and it will never match any arguments.

**TK\_CONFIG\_FONT**
: The value must be an ASCII string identifying a font in a form suitable for passing to [Tk\_GetFont][GetFont].  The value is converted to a **Tk\_Font** by calling [Tk\_GetFont][GetFont] and the result is stored in the target. If **TK\_CONFIG\_NULL\_OK** is specified in *specFlags* then the value may be an empty string, in which case the target will be set to NULL. If the previous value of the target was not NULL, then it is freed by passing it to [Tk\_FreeFont][GetFont].

**TK\_CONFIG\_INT**
: The value must be an ASCII integer string in the format accepted by **strtol** (e.g. "0" and "0x" prefixes may be used to specify octal or hexadecimal numbers, respectively).  The string is converted to an integer value and the integer is stored in the target.

**TK\_CONFIG\_JOIN\_STYLE**
: The value must be an ASCII string identifying a join style in one of the ways accepted by [Tk\_GetJoinStyle][GetJoinStl]. The string is converted to an integer value corresponding to the join style by calling [Tk\_GetJoinStyle][GetJoinStl] and the result is stored in the target.

**TK\_CONFIG\_JUSTIFY**
: The value must be an ASCII string identifying a justification method in one of the ways accepted by [Tk\_GetJustify][GetJustify]. The string is converted to a **Tk\_Justify** by calling [Tk\_GetJustify][GetJustify] and the result is stored in the target.

**TK\_CONFIG\_MM**
: The value must specify a screen distance in one of the forms acceptable to [Tk\_GetScreenMM][GetPixels]. The string is converted to double-precision floating-point distance in millimeters and the value is stored in the target.

**TK\_CONFIG\_PIXELS**
: The value must specify screen units in one of the forms acceptable to [Tk\_GetPixels][GetPixels]. The string is converted to an integer distance in pixels and the value is stored in the target.

**TK\_CONFIG\_RELIEF**
: The value must be an ASCII string identifying a relief in a form suitable for passing to [Tk\_GetRelief][GetRelief].  The value is converted to an integer relief value by calling [Tk\_GetRelief][GetRelief] and the result is stored in the target.

**TK\_CONFIG\_STRING**
: A copy of the value is made by allocating memory space with [Tcl\_Alloc][Alloc] and copying the value into the dynamically-allocated space.  A pointer to the new string is stored in the target. If **TK\_CONFIG\_NULL\_OK** is specified in *specFlags* then the value may be an empty string, in which case the target will be set to NULL. If the previous value of the target was not NULL, then it is freed by passing it to [Tcl\_Free][Alloc].

**TK\_CONFIG\_SYNONYM**
: This *type* value identifies special entries in *specs* that are synonyms for other entries.  If an *objv* value matches the *argvName* of a **TK\_CONFIG\_SYNONYM** entry, the entry is not used directly. Instead, **Tk\_ConfigureWidget** searches *specs* for another entry whose *dbName* is the same as the *dbName* field in the **TK\_CONFIG\_SYNONYM** entry;  this new entry is used just as if its *argvName* had matched the *objv* value.  The synonym mechanism allows multiple *objv* values to be used for a single configuration option, such as "-background" and "-bg".

**TK\_CONFIG\_UID**
: The value is translated to a [Tk\_Uid][GetUid] (by passing it to [Tk\_GetUid][GetUid]).  The resulting value is stored in the target. If **TK\_CONFIG\_NULL\_OK** is specified in *specFlags* and the value is an empty string then the target will be set to NULL.

**TK\_CONFIG\_WINDOW**
: The value must be a window path name.  It is translated to a **Tk\_Window** token and the token is stored in the target.


# Grouped entries

In some cases it is useful to generate multiple resources from a single configuration value.  For example, a color name might be used both to generate the background color for a widget (using **TK\_CONFIG\_COLOR**) and to generate a 3-D border to draw around the widget (using **TK\_CONFIG\_BORDER**).  In cases like this it is possible to specify that several consecutive entries in *specs* are to be treated as a group.  The first entry is used to determine a value (using its *argvName*, *dbName*, *dbClass*, and *defValue* fields).  The value will be processed several times (one for each entry in the group), generating multiple different resources and modifying multiple targets within *widgRec*. Each of the entries after the first must have a NULL value in its *argvName* field;  this indicates that the entry is to be grouped with the entry that precedes it.  Only the *type* and *offset* fields are used from these follow-on entries.

# Flags

The *flags* argument passed to **Tk\_ConfigureWidget** is used in conjunction with the *specFlags* fields in the entries of *specs* to provide additional control over the processing of configuration options.  These values are used in three different ways as described below.

First, if the *flags* argument to **Tk\_ConfigureWidget** has the **TK\_CONFIG\_ARGV\_ONLY** bit set (i.e., *flags* | **TK\_CONFIG\_ARGV\_ONLY** != 0), then the option database and *defValue* fields are not used.  In this case, if an entry in *specs* does not match a field in *objv* then nothing happens: the corresponding target is not modified.  This feature is useful when the goal is to modify certain configuration options while leaving others in their current state, such as when a **configure** widget command is being processed.

Second, the *specFlags* field of an entry in *specs* may be used to control the processing of that entry.  Each *specFlags* field may consists of an OR-ed combination of the following values:

**TK\_CONFIG\_COLOR\_ONLY**
: If this bit is set then the entry will only be considered if the display for *tkwin* has more than one bit plane.  If the display is monochromatic then this *specs* entry will be ignored.

**TK\_CONFIG\_MONO\_ONLY**
: If this bit is set then the entry will only be considered if the display for *tkwin* has exactly one bit plane.  If the display is not monochromatic then this *specs* entry will be ignored.

**TK\_CONFIG\_NULL\_OK**
: This bit is only relevant for some types of entries (see the descriptions of the various entry types above). If this bit is set, it indicates that an empty string value for the field is acceptable and if it occurs then the target should be set to NULL or **None**, depending on the type of the target. This flag is typically used to allow a feature to be turned off entirely, e.g. set a cursor value to **None** so that a window simply inherits its parent's cursor. If this bit is not set then empty strings are processed as strings, which generally results in an error.

**TK\_CONFIG\_DONT\_SET\_DEFAULT**
: If this bit is one, it means that the *defValue* field of the entry should only be used for returning the default value in **Tk\_ConfigureInfo**. In calls to **Tk\_ConfigureWidget** no default will be supplied for entries with this flag set;  it is assumed that the caller has already supplied a default value in the target location. This flag provides a performance optimization where it is expensive to process the default string:  the client can compute the default once, save the value, and provide it before calling **Tk\_ConfigureWidget**.


The **TK\_CONFIG\_MONO\_ONLY** and **TK\_CONFIG\_COLOR\_ONLY** flags are typically used to specify different default values for monochrome and color displays.  This is done by creating two entries in *specs* that are identical except for their *defValue* and *specFlags* fields.  One entry should have the value **TK\_CONFIG\_MONO\_ONLY** in its *specFlags* and the default value for monochrome displays in its *defValue*;  the other entry should have the value **TK\_CONFIG\_COLOR\_ONLY** in its *specFlags* and the appropriate *defValue* for color displays.

Third, it is possible to use *flags* and *specFlags* together to selectively disable some entries.  This feature is not needed very often.  It is useful in cases where several similar kinds of widgets are implemented in one place.  It allows a single *specs* table to be created with all the configuration options for all the widget types.  When processing a particular widget type, only entries relevant to that type will be used.  This effect is achieved by setting the high-order bits (those in positions equal to or greater than **TK\_CONFIG\_USER\_BIT**) in *specFlags* values or in *flags*.  In order for a particular entry in *specs* to be used, its high-order bits must match exactly the high-order bits of the *flags* value passed to **Tk\_ConfigureWidget**.  If a *specs* table is being used for N different widget types, then N of the high-order bits will be used.  Each *specs* entry will have one of more of those bits set in its *specFlags* field to indicate the widget types for which this entry is valid.  When calling **Tk\_ConfigureWidget**, *flags* will have a single one of these bits set to select the entries for the desired widget type.  For a working example of this feature, see the code in tkButton.c.

# Tk\_ConfigureInfo

The **Tk\_ConfigureInfo** procedure may be used to obtain information about one or all of the options for a given widget. Given a token for a window (*tkwin*), a table describing the configuration options for a class of widgets (*specs*), a pointer to a widget record containing the current information for a widget (*widgRec*), and a NULL *argvName* argument, **Tk\_ConfigureInfo** generates a string describing all of the configuration options for the window.  The string is placed in interpreter *interp*'s result.  Under normal circumstances it returns [TCL\_OK][catch];  if an error occurs then it returns [TCL\_ERROR][catch] and the interpreter's result will contain an error message.

If *argvName* is NULL, then the value left in the interpreter's result by **Tk\_ConfigureInfo** consists of a list of one or more entries, each of which describes one configuration option (i.e. one entry in *specs*).  Each entry in the list will contain either two or five values.  If the corresponding entry in *specs* has type **TK\_CONFIG\_SYNONYM**, then the list will contain two values:  the *argvName* for the entry and the *argvName* of the entry it is a synonym for.  Otherwise the list will contain five values:  *argvName*, *dbName*, *dbClass*, *defValue*, and current value.  The current value is computed from the appropriate field of *widgRec* by calling procedures like [Tk\_NameOfColor][GetColor].

If the *argvName* argument to **Tk\_ConfigureInfo** is non-NULL, then it indicates a single option, and information is returned only for that option.  The string placed in the interpreter's result will be a list containing two or five values as described above;  this will be identical to the corresponding sublist that would have been returned if *argvName* had been NULL.

The *flags* argument to **Tk\_ConfigureInfo** is used to restrict the *specs* entries to consider, just as for **Tk\_ConfigureWidget**.

# Tk\_ConfigureValue

**Tk\_ConfigureValue** takes arguments similar to **Tk\_ConfigureInfo**; instead of returning a list of values, it just returns the current value of the option given by *argvName* (*argvName* must not be NULL). The value is returned in interpreter *interp*'s result and [TCL\_OK][catch] is normally returned as the procedure's result. If an error occurs in **Tk\_ConfigureValue** (e.g., *argvName* is not a valid option name), [TCL\_ERROR][catch] is returned and an error message is left in the interpreter's result. This procedure is typically called to implement **cget** widget commands.

# Tk\_FreeOptions

The **Tk\_FreeOptions** procedure may be invoked during widget cleanup to release all of the resources associated with configuration options. It scans through *specs* and for each entry corresponding to a resource that must be explicitly freed (e.g. those with type **TK\_CONFIG\_COLOR**), it frees the resource in the widget record. If the field in the widget record does not refer to a resource (e.g. it contains a null pointer) then no resource is freed for that entry. After freeing a resource, **Tk\_FreeOptions** sets the corresponding field of the widget record to null.

# Custom option types

Applications can extend the built-in configuration types with additional configuration types by writing procedures to parse and print options of the a type and creating a structure pointing to those procedures:

```
typedef struct {
    Tk_OptionParseProc *parseProc;
    Tk_OptionPrintProc *printProc;
    void *clientData;
} Tk_CustomOption;

typedef int Tk_OptionParseProc(
        void *clientData,
        Tcl_Interp *interp,
        Tk_Window tkwin,
        const char *value,
        char *widgRec,
        Tcl_Size offset);

typedef const char *Tk_OptionPrintProc(
        void *clientData,
        Tk_Window tkwin,
        char *widgRec,
        Tcl_Size offset,
        Tcl_FreeProc **freeProcPtr);
```

The Tk\_CustomOption structure contains three fields, which are pointers to the two procedures and a *clientData* value to be passed to those procedures when they are invoked.  The *clientData* value typically points to a structure containing information that is needed by the procedures when they are parsing and printing options.

The *parseProc* procedure is invoked by **Tk\_ConfigureWidget** to parse a string and store the resulting value in the widget record. The *clientData* argument is a copy of the *clientData* field in the Tk\_CustomOption structure. The *interp* argument points to a Tcl interpreter used for error reporting.  *Tkwin* is a copy of the *tkwin* argument to **Tk\_ConfigureWidget**.  The *value* argument is a string describing the value for the option;  it could have been specified explicitly in the call to **Tk\_ConfigureWidget** or it could come from the option database or a default. *Value* will never be a null pointer but it may point to an empty string. *RecordPtr* is the same as the *widgRec* argument to **Tk\_ConfigureWidget**;  it points to the start of the widget record to modify. The last argument, *offset*, gives the offset in bytes from the start of the widget record to the location where the option value is to be placed.  The procedure should translate the string to whatever form is appropriate for the option and store the value in the widget record.  It should normally return [TCL\_OK][catch], but if an error occurs in translating the string to a value then it should return [TCL\_ERROR][catch] and store an error message in interpreter *interp*'s result.

The *printProc* procedure is called by **Tk\_ConfigureInfo** to produce a string value describing an existing option. Its *clientData*, *tkwin*, *widgRec*, and *offset* arguments all have the same meaning as for Tk\_OptionParseProc procedures. The *printProc* procedure should examine the option whose value is stored at *offset* in *widgRec*, produce a string describing that option, and return a pointer to the string. If the string is stored in dynamically-allocated memory, then the procedure must set *\*freeProcPtr* to the address of a procedure to call to free the string's memory;  **Tk\_ConfigureInfo** will call this procedure when it is finished with the string. If the result string is stored in static memory then *printProc* need not do anything with the *freeProcPtr* argument.

Once *parseProc* and *printProc* have been defined and a Tk\_CustomOption structure has been created for them, options of this new type may be manipulated with Tk\_ConfigSpec entries whose *type* fields are **TK\_CONFIG\_CUSTOM** and whose *customPtr* fields point to the Tk\_CustomOption structure.

# Examples

Although the explanation of **Tk\_ConfigureWidget** is fairly complicated, its actual use is pretty straightforward. The easiest way to get started is to copy the code from an existing widget. The library implementation of frames (tkFrame.c) has a simple configuration table, and the library implementation of buttons (tkButton.c) has a much more complex table that uses many of the fancy *specFlags* mechanisms.


[3DBorder]: 3DBorder.md
[Alloc]: ../tcl-c/Alloc.md
[catch]: ../tcl/catch.md
[GetAnchor]: GetAnchor.md
[GetBitmap]: GetBitmap.md
[GetCapStyl]: GetCapStyl.md
[GetColor]: GetColor.md
[GetCursor]: GetCursor.md
[GetFont]: GetFont.md
[GetJoinStl]: GetJoinStl.md
[GetJustify]: GetJustify.md
[GetPixels]: GetPixels.md
[GetRelief]: GetRelief.md
[GetUid]: GetUid.md
[Object]: ../tcl-c/Object.md
[SetOptions]: SetOptions.md
