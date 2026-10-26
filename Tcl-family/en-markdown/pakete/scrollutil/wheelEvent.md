# Commands Related to Mouse Wheel and `<TouchpadScroll>` Event Handling

## For Scrollutil Version 2.11

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [The scrollutil::addMouseWheelSupport Command](#the-scrollutil-addmousewheelsupport-command)
- [The scrollutil::createWheelEventBindings Command](#the-scrollutil-createwheeleventbindings-command)
- [The scrollutil::enableScrollingByWheel Command](#the-scrollutil-enablescrollingbywheel-command)
- [The scrollutil::disableScrollingByWheel Command](#the-scrollutil-disablescrollingbywheel-command)
- [The scrollutil::adaptWheelEventHandling Command](#the-scrollutil-adaptwheeleventhandling-command)
- [The scrollutil::prepareScrollingByWheel Command](#the-scrollutil-preparescrollingbywheel-command)
- [The scrollutil::setFocusCheckWindow Command](#the-scrollutil-setfocuscheckwindow-command)
- [The scrollutil::focusCheckWindow Command](#the-scrollutil-focuscheckwindow-command)

[Start page](index.md)

---

## The `scrollutil::addMouseWheelSupport` Command

**NAME**
: `scrollutil::addMouseWheelSupport` – Add mouse wheel event support to (ttk::)menubutton, (ttk::)scale, or scrollable widgets

**SYNOPSIS**
: 

```
scrollutil::addMouseWheelSupport tag ?axes?
```

**REQUIRED TK VERSION**
: 8.4 or higher.

**DESCRIPTION**
: Adds mouse wheel and `<TouchpadScroll>` event support to the widgets having the specified binding tag by creating bindings for the mouse wheel and `<TouchpadScroll>` events along the axes given by the optional `axes` argument, which must be `xy` (the default, meaning both the x and y axes), `x` (meaning the x axis only), or `y` (meaning the y axis only).

  - If `tag` is the path name of a menubutton or ttk::menubutton widget, or the class name `Menubutton` or `TMenubutton`, then `axes` is ignored and the binding scripts created by this command will activate the cyclically next or previous entry of the menu associated with the widget given by the `%W` event field and invoke the action of that menu entry, provided that its type is not `cascade` or `tearoff`.
  - If `tag` is the path name of a scale or ttk::scale widget, or the class name `Scale` or `TScale`, then `axes` is ignored and the binding scripts created by this command will increment or decrement the value of the widget given by the `%W` event field and move its slider accordingly.
  - Otherwise the binding scripts will scroll the window given by the `%W` event field with the aid of the  `xview scroll number units`  and/or  `yview scroll number units`  subcommands of the associated Tcl command, depending on `axes`.

: **REMARK 1:**  If `tag` is the path name of a window then the binding scripts created by this command are terminated by an invocation of the `break` command, in order to prevent the processing of the mouse wheel or `<TouchpadScroll>` events by further binding scripts.  For example, if `tag` is the path name of a text widget then the terminating `break` command makes sure that the mouse wheel or `<TouchpadScroll>` events will not *additionally* be processed by the class bindings (associated with the binding tag `Text`), which in Tk 8.5 and later trigger a scrolling by *pixels*, unlike the bindings created by this command, which scroll the widget by *units* (i.e., lines and characters).

: **REMARK 2:**  The canvas widget has no built-in bindings, but you can use this command to add mouse wheel and `<TouchpadScroll>` event support to the widget class `Canvas` or individual canvas widgets.

: **REMARK 3:**  *In Tk versions prior to 8.7a4*, the set of mouse wheel events depends on the windowing system:

  - The mouse wheel events along the vertical axis are `<MouseWheel>` on Windows, `<MouseWheel>` and `<Option-MouseWheel>` on Mac OS X/11+, and `<MouseWheel>`, `<Button-4>` and `<Button-5>` on X11 (where `<MouseWheel>` is not triggered by the X server, but can be produced using  `event generate`).
  - The mouse wheel events along the horizontal axis are `<Shift-MouseWheel>` on Windows, `<Shift-MouseWheel>` and `<Shift-Option-MouseWheel>` on Mac OS X/11+, and `<Shift-MouseWheel>`, `<Shift-Button-4>` and `<Shift-Button-5>` on X11 (where `<Shift-MouseWheel>` is not triggered by the X server, but can be produced using  `event generate`).  On X11, when using Tk 8.7a3, there are two more mouse wheel events along the horizontal axis: `<Button-6>` and `<Button-7>`, which are handled just like `<Shift-Button-4>` and `<Shift-Button-5>`, respectively.  These events are commonly triggered by left/right tilting the scroll wheel of a mouse having one or two additional (thumb) buttons.  (In Tk versions 8.6.x, with x >= 10, left/right tilting the scroll wheel of such a mouse gives rise to `<Shift-MouseWheel>` events on Windows and Mac OS X/11+, and to `<Shift-Button-4>` and `<Shift-Button-5>` events on X11.)

**REMARK 4:**  *In Tk versions 8.7a4 and later*, the set of mouse wheel events is the same on all windowing systems:

  - The mouse wheel events along the vertical axis are `<MouseWheel>` and `<Option-MouseWheel>`, where the `Option` modifier is bound to the `Option` key on Mac OS X/11+ and to the `Alt` key on Windows and X11.
  - The mouse wheel events along the horizontal axis are `<Shift-MouseWheel>` and `<Shift-Option-MouseWheel>`, where the `Option` modifier is bound to the `Option` key on Mac OS X/11+ and to the `Alt` key on Windows and X11.  In these Tk versions, left/right tilting the scroll wheel of a mouse having one or two additional (thumb) buttons gives rise to `<Shift-MouseWheel>` (and `<Shift-Option-MouseWheel>`) events on all windowing systems.

**KEYWORDS**
: mouse wheel event, binding, menubutton, scale widget, scrolling


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::createWheelEventBindings` Command

**NAME**
: `scrollutil::createWheelEventBindings` – Create mouse wheel event bindings for toplevel widgets or the binding tag `all`

**SYNOPSIS**
: 

```
scrollutil::createWheelEventBindings ?tag tag ...?
```

**REQUIRED TK VERSION**
: 8.4 or higher on X11 and Mac OS X/11+; 8.6b2 or later on Windows.

**DESCRIPTION**
: Creates mouse wheel and `<TouchpadScroll>` event bindings for the specified binding tags such that if the widget under the pointer is (a descendant of) one of the scrollable widget containers having the same toplevel as the widget and registered via `scrollutil::enableScrollingByWheel` then these events will trigger a scrolling of that widget container.  In case of several nested registered scrollable widget containers fulfilling these conditions the innermost one will be scrolled.  Each `tag` argument must be `all` or the path name of an existing toplevel widget (including `.`).

: **REMARK:**  The reason for restricting the `tag` arguments to `all` and path names of existing toplevel widgets rather than supporting also tags like `"Scrollableframe"` (for scrollutil::scrollableframe), `"BwScrollableFrame"` (for BWidget ScrollableFrame) or `"Scrolledframe"` (for iwidgets::scrolledframe) is that the mouse wheel and `<TouchpadScroll>` events should trigger a scrolling of the widget container under the pointer not only if the widget under the pointer is the widget container itself but also if it is a descendant of the latter (recall that for each window, the path name of its nearest toplevel ancestor and the tag `all` are contained in the window's default list of binding tags).

**KEYWORDS**
: mouse wheel event, binding, scrolling, scrollable widget container


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::enableScrollingByWheel` Command

**NAME**
: `scrollutil::enableScrollingByWheel` – Register scrollable widget containers for scrolling by the mouse wheel

**SYNOPSIS**
: 

```
scrollutil::enableScrollingByWheel ?scrollableWidgetContainer scrollableWidgetContainer ...?
```

**REQUIRED TK VERSION**
: 8.4 or higher on X11 and Mac OS X/11+; 8.6b2 or later on Windows.

**DESCRIPTION**
: Adds the specified scrollable widget containers to the internal list of widget containers that are registered for scrolling by the mouse wheel and `<TouchpadScroll>` event bindings created by the `scrollutil::createWheelEventBindings` command.

: **REMARK 1:**  When a scrollable widget container whose path name was passed to this command gets destroyed, it is automatically removed from the above-mentioned internal list of registered widget containers.

: **REMARK 2:**  The `scrollutil::scrollableframe` command automatically invokes this command for the scrollableframe widget it creates.

**KEYWORDS**
: mouse wheel event, binding, scrolling, scrollable widget container


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::disableScrollingByWheel` Command

**NAME**
: `scrollutil::disableScrollingByWheel` – Deregister scrollable widget containers for scrolling by the mouse wheel

**SYNOPSIS**
: 

```
scrollutil::disableScrollingByWheel ?scrollableWidgetContainer scrollableWidgetContainer ...?
```

**REQUIRED TK VERSION**
: 8.4 or higher on X11 and Mac OS X/11+; 8.6b2 or later on Windows.

**DESCRIPTION**
: Removes the specified scrollable widget containers from the internal list of widget containers that are registered for scrolling by the mouse wheel and `<TouchpadScroll>` event bindings created by the `scrollutil::createWheelEventBindings` command.

**KEYWORDS**
: mouse wheel event, binding, scrolling, scrollable widget container


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::adaptWheelEventHandling` Command

**NAME**
: `scrollutil::adaptWheelEventHandling` – Adapt mouse wheel event handling

**SYNOPSIS**
: 

```
scrollutil::adaptWheelEventHandling ?-ignorefocus? ?widget widget ...?
```

**REQUIRED TK VERSION**
: 8.4 or higher on X11 and Mac OS X/11+; 8.6b2 or later on Windows.

**DESCRIPTION**
: If the optional `-ignorefocus` switch is *not* present then, for each `widget` argument, the command performs the following actions:


  -  If `widget` is the path name of a [tablelist](https://www.nemethi.de/tablelist/) widget then it sets the latter's `-xmousewheelwindow` and `-ymousewheelwindow` options to the path name of the containing toplevel window, provided that the Tablelist version is 6.4 or later (for earlier Tablelist versions the command silently ignores any tablelist widget passed to it as argument).  As a result, a mouse wheel or `<TouchpadScroll>` event over the tablelist's body or edit window (more precisely, a mouse wheel or `<TouchpadScroll>` event sent to any component of the tablelist having the binding tag `TablelistBody` or `TablelistEdit`) will be handled as follows:  
  -  Otherwise it locates the (first) binding tag that has mouse wheel or `<TouchpadScroll>` event bindings and is different from both the path name of the containing toplevel window and `all`.  If the search for this tag was successful then the command modifies the widget's list of binding tags by prepending the tag `WheeleventRedir` and appending the tag `WheeleventBreak` to this binding tag.  As a result, a mouse wheel or `<TouchpadScroll>` event sent to this widget will be handled as follows:  

    - If the focus is inside the tablelist widget then the event will scroll the tablelist or its edit window and no further processing of the event will take place.
    - If the focus is outside the tablelist widget then no scrolling of the tablelist's body or edit window will happen.  Instead, the event will be redirected to the containing toplevel window via  `event generate`.  This in turn will trigger a scrolling of the (innermost) widget container that is an ancestor of `widget` and has the same toplevel (if there is such a scrollable widget container), provided that the path name of the containing toplevel widget or the binding tag `all` was passed to the `scrollutil::createWheelEventBindings` command and this widget container was registered for scrolling via `scrollutil::enableScrollingByWheel`.

    - If the focus is on or inside the window  `[focusCheckWindow widget]`  then the event will be handled by the binding script associated with this tag and no further processing of the event will take place.
    - If the focus is outside the window  `[focusCheckWindow widget]`  then the event will be redirected to the containing toplevel window via  `event generate`  rather than being handled by the binding script associated with the above-mentioned tag.  This in turn will trigger a scrolling of the (innermost) widget container that is an ancestor of `widget` and has the same toplevel (if there is such a scrollable widget container), provided that the path name of the containing toplevel widget or the binding tag `all` was passed to the `scrollutil::createWheelEventBindings` command and this widget container was registered for scrolling via `scrollutil::enableScrollingByWheel`.

: If the `-ignorefocus` option is specified then, for each `widget` argument, the command performs the following actions:


  - If `widget` is the path name of a [tablelist](https://www.nemethi.de/tablelist/) widget then it resets the latter's `-xmousewheelwindow` and `-ymousewheelwindow` options to `""`, provided that the Tablelist version is 6.4 or later (for earlier Tablelist versions the command silently ignores any tablelist widget passed to it as argument).  As a result, if the Tablelist version is 6.16 or later, a mouse wheel or `<TouchpadScroll>` event over the tablelist's body or edit window will scroll the tablelist or its edit window and no further processing of the event will take place.
  - Otherwise it locates the (first) binding tag that has mouse wheel or `<TouchpadScroll>` event bindings and is different from both the path name of the containing toplevel window and `all`.  If the search for this tag was successful then the command modifies the widget's list of binding tags by appending the tag `WheeleventBreak` to this binding tag.  As a result, a mouse wheel or `<TouchpadScroll>` event sent to this widget will be handled by the binding script associated with this tag and no further processing of the event will take place.

: **REMARK 1:**  This command is designed to be invoked for widgets that have mouse wheel or `<TouchpadScroll>` event bindings and are descendants of a scrollable widget container.  The Tk and tile widgets having class bindings for mouse wheel and `<TouchpadScroll>` events are: listbox, text, Tk core scrollbar, ttk::scrollbar, ttk::combobox, ttk::spinbox, ttk::entry, ttk::notebook, and ttk::treeview.  Examples of widgets with binding tags other than their class names that have mouse wheel and `<TouchpadScroll>` event bindings are ctext and tablelist widgets, as well as the entry components of [mentry](https://www.nemethi.de/mentry/) widgets of type `"Date"`, `"Time"`, `"DateTime"`, `"IPAddr"`, and `"IPv6Addr"` (for Mentry versions 3.2 and above).  (In case of a ctext widget `w`, the binding tags mentioned in the description above refer to the widget's main text widget child `w.t` rather than to the widget itself.)

: **REMARK 2:**  As mentioned above, Tk core scrollbar and ttk::scrollbar widgets have class bindings for mouse wheel and `<TouchpadScroll>` events, hence this command should be invoked for them in case they are descendants of a scrollable widget container.  Since this task can become tedious, Scrollutil makes sure that if you pass a widget to this command and that widget is embedded into a [scrollarea](scrollarea.md) via the latter's `setwidget` subcommand, then this command will automatically be invoked for the scrollbars of that scrollarea, too.

: **REMARK 3:**  When handling a mouse wheel or `<TouchpadScroll>` event sent to a Tk core or tile scrollbar whose path name was passed to this command without the `-ignorefocus` option, if the focus is on or inside the associated widget then the event will be processed by the scrollbar rather than being redirected to the containing toplevel, just as if the focus were on the scrollbar itself.

: **REMARK 4:**  The mouse wheel event class bindings for the Tk core scrollbar on Windows and X11 were added in Tk 8.6.  Prior to this Tk version there were such bindings only for the windowing system `aqua` on the Macintosh.  Scrollutil eliminates this discrepancy by automatically creating the `Scrollbar` class bindings for mouse wheel events on Windows and X11.  Note also that in Tk versions prior to 8.7a4 the ttk::scrollbar widget had no *built-in* class bindings for mouse wheel events, but Scrollutil automatically creates the missing bindings by copying the mouse wheel event bindings of the widget class `Scrollbar` to the binding tag `TScrollbar`.

: **REMARK 5:**  The mouse wheel event class bindings for the ttk::entry widget were added in Tk 9.1a1, but Scrollutil automatically creates them for all Tk versions starting with 8.4.

: **REMARK 6:**  The mouse wheel event class bindings for the ttk::notebook widget were added in Tk 8.7a4, but Scrollutil automatically creates them for all Tk versions starting with 8.4.  These bindings implement the navigation between the tabs of a ttk::notebook or [scrollutil::scrollednotebook](scrollednotebook.md) widget via the mouse wheel.

: **REMARK 7:**  The recommended invocation of this command is without the `-ignorefocus` option, because it significantly reduces the probability that the user will inadvertently scroll a window within a widget container containing many scrollable widgets.

**KEYWORDS**
: mouse wheel event, binding, event handling, scrolling, scrollable widget container, focus


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::prepareScrollingByWheel` Command

**NAME**
: `scrollutil::prepareScrollingByWheel` – Prepare scrollable widget containers for scrolling by the mouse wheel

**SYNOPSIS**
: 

```
scrollutil::prepareScrollingByWheel ?-ignorefocus? ?scrollableWidgetContainer scrollableWidgetContainer ...?
```

**REQUIRED TK VERSION**
: 8.4 or higher on X11 and Mac OS X/11+; 8.6b2 or later on Windows.

**DESCRIPTION**
: For each scrollable widget container specified as argument, this command prepares the scrolling with the mouse wheel and touchpad, by passing its descendants located in the same toplevel and having bindings for mouse wheel or `<TouchpadScroll>` events to `scrollutil::adaptWheelEventHandling`.

: **REMARK:**  If a scrollable widget container has many descendants then it is much safer to invoke this command than to manually pass a lot of widgets to `scrollutil::adaptWheelEventHandling`, because deciding which descendants to process can become tedious and error-prone.

**KEYWORDS**
: mouse wheel event, binding, scrollable widget container


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::setFocusCheckWindow` Command

**NAME**
: `scrollutil::setFocusCheckWindow` – Set the "focus check window"

**SYNOPSIS**
: 

```
scrollutil::setFocusCheckWindow widget ?widget ...? otherWidget
```

**REQUIRED TK VERSION**
: 8.4 or higher.

**DESCRIPTION**
: For each `widget` argument, the command sets the associated "focus check window" to `otherWidget`.  This is the window to be used in the binding scripts for the tags `WheeleventRedir` and `Btn2EventRedir` instead of the widget when checking whether the focus is on/inside or outside that window.  For each `widget` argument, `otherWidget` must be an ancestor of or identical to `widget`.

: **REMARK 1:**  When a widget whose path name was passed to this command as one of its `widget` arguments gets destroyed, the association between the widget and its "focus check window" is automatically removed.

: **REMARK 2:**  This command comes in handy if for some widgets you want to make the focus check within the binding scripts for the tags `WheeleventRedir` and `Btn2EventRedir` less restrictive.  For example, if the widget under the pointer is an entry component of a [mentry](https://www.nemethi.de/mentry/) `me` of type `"Date"`, `"Time"`, `"DateTime"`, `"IPAddr"`, or `"IPv6Addr"` and the focus is on any of its siblings, then the mouse wheel and `<TouchpadScroll>` events sent to this entry should be handled by the entry widget itself rather than scrolling the widget container that is an ascendant of the mentry.  You can achieve this by invoking


```
set entryList [$me entries]
eval scrollutil::adaptWheelEventHandling $entryList
eval scrollutil::setFocusCheckWindow     $entryList [list $me]
```

: With Tcl/Tk 8.5 or above, you can use the more compact form


```
set entryList [$me entries]
scrollutil::adaptWheelEventHandling {*}$entryList
scrollutil::setFocusCheckWindow     {*}$entryList $me
```

: **REMARK 3:**  As a similar example, suppose that `ss` is a [scrollsync](scrollsync.md) widget that was populated via its `setwidgets` subcommand with child widgets.  Then, if the widget under the pointer is one of these children and the focus is on any of the other children passed to that subcommand, then the mouse wheel and `<TouchpadScroll>` events sent to the child under the pointer should be handled by that child widget itself rather than scrolling the widget container that is an ascendant of the scrollsync.  You can achieve this with the following code:


```
set widgetList [$ss widgets]
eval scrollutil::adaptWheelEventHandling $widgetList
eval scrollutil::setFocusCheckWindow     $widgetList [list $ss]
```

: Again, with Tcl/Tk 8.5 or above, you can use the more compact form


```
set widgetList [$ss widgets]
scrollutil::adaptWheelEventHandling {*}$widgetList
scrollutil::setFocusCheckWindow     {*}$widgetList $ss
```

**KEYWORDS**
: binding, focus, "focus check window"


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::focusCheckWindow` Command

**NAME**
: `scrollutil::focusCheckWindow` – Query the "focus check window"

**SYNOPSIS**
: 

```
scrollutil::focusCheckWindow widget
```

**REQUIRED TK VERSION**
: 8.4 or higher.

**DESCRIPTION**
: Returns the path name of the "focus check window" associated with the `widget` argument.  This is the window that is used in the binding scripts for the tags `WheeleventRedir` and `Btn2EventRedir` instead of the widget when checking whether the focus is on/inside or outside that window.  If the command `scrollutil::setFocusCheckWindow` was not invoked for `widget` then the return value is `widget` itself.

**KEYWORDS**
: binding, focus, "focus check window"


[Contents](#contents)     [Start page](index.md)

---
