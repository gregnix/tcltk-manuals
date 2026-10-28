---
CommandName: html
title: html
ManualSection: n
Version: 1.6
TclPart: tcllib
TclDescription: HTML Generation
Links:
 - htmlparse
 - ncgi
Keywords:
 - checkbox
 - checkbutton
 - form
 - html
 - radiobutton
 - table
Copyright:
---

# Name

html - Procedures to generate HTML structures

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [html]{.lit} [1.6]{.optlit}
[::html::author]{.cmd} [author]{.arg}
[::html::bodyTag]{.cmd} [args]{.arg}
[::html::cell]{.cmd} [param]{.arg} [value]{.arg} [tag]{.optarg}
[::html::checkbox]{.cmd} [name]{.arg} [value]{.arg}
[::html::checkSet]{.cmd} [key]{.arg} [sep]{.arg} [list]{.arg}
[::html::checkValue]{.cmd} [name]{.arg} [value]{.optarg}
[::html::closeTag]{.cmd}
[::html::default]{.cmd} [key]{.arg} [param]{.optarg}
[::html::description]{.cmd} [description]{.arg}
[::html::end]{.cmd}
[::html::eval]{.cmd} [arg]{.arg} [args]{.optarg}
[::html::extractParam]{.cmd} [param]{.arg} [key]{.arg} [varName]{.optarg}
[::html::font]{.cmd} [args]{.arg}
[::html::for]{.cmd} [start]{.arg} [test]{.arg} [next]{.arg} [body]{.arg}
[::html::foreach]{.cmd} [varlist1]{.arg} [list1]{.arg} [varlist2 list2]{.optdot} [body]{.arg}
[::html::formValue]{.cmd} [name]{.arg} [defvalue]{.optarg}
[::html::getFormInfo]{.cmd} [args]{.arg}
[::html::getTitle]{.cmd}
[::html::h]{.cmd} [level]{.arg} [string]{.arg} [param]{.optarg}
[::html::h1]{.cmd} [string]{.arg} [param]{.optarg}
[::html::h2]{.cmd} [string]{.arg} [param]{.optarg}
[::html::h3]{.cmd} [string]{.arg} [param]{.optarg}
[::html::h4]{.cmd} [string]{.arg} [param]{.optarg}
[::html::h5]{.cmd} [string]{.arg} [param]{.optarg}
[::html::h6]{.cmd} [string]{.arg} [param]{.optarg}
[::html::hdrRow]{.cmd} [args]{.arg}
[::html::head]{.cmd} [title]{.arg}
[::html::headTag]{.cmd} [string]{.arg}
[::html::html\_entities]{.cmd} [string]{.arg}
[::html::if]{.cmd} [expr1]{.arg} [body1]{.arg} [[elseif]{.lit} [expr2]{.arg} [body2]{.arg}]{.optdot} [[else]{.lit} [bodyN]{.arg}]{.optarg}
[::html::init]{.cmd} [list]{.optarg}
[::html::keywords]{.cmd} [args]{.arg}
[::html::mailto]{.cmd} [email]{.arg} [subject]{.optarg}
[::html::meta]{.cmd} [args]{.arg}
[::html::meta\_name]{.cmd} [args]{.arg}
[::html::meta\_equiv]{.cmd} [args]{.arg}
[::html::meta\_charset]{.cmd} [charset]{.arg}
[::html::css]{.cmd} [href]{.arg}
[::html::css-clear]{.cmd}
[::html::js]{.cmd} [href]{.arg}
[::html::js-clear]{.cmd}
[::html::minorList]{.cmd} [list]{.arg} [ordered]{.optarg}
[::html::minorMenu]{.cmd} [list]{.arg} [sep]{.optarg}
[::html::nl2br]{.cmd} [string]{.arg}
[::html::openTag]{.cmd} [tag]{.arg} [param]{.optarg}
[::html::paramRow]{.cmd} [list]{.arg} [rparam]{.optarg} [cparam]{.optarg}
[::html::passwordInput]{.cmd} [name]{.optarg}
[::html::passwordInputRow]{.cmd} [label]{.arg} [name]{.optarg}
[::html::quoteFormValue]{.cmd} [value]{.arg}
[::html::radioSet]{.cmd} [key]{.arg} [sep]{.arg} [list]{.arg}
[::html::radioValue]{.cmd} [name]{.arg} [value]{.arg}
[::html::refresh]{.cmd} [seconds]{.arg} [url]{.arg}
[::html::row]{.cmd} [args]{.arg}
[::html::select]{.cmd} [name]{.arg} [param]{.arg} [choices]{.arg} [current]{.optarg}
[::html::selectPlain]{.cmd} [name]{.arg} [param]{.arg} [choices]{.arg} [current]{.optarg}
[::html::set]{.cmd} [var]{.arg} [val]{.arg}
[::html::submit]{.cmd} [label]{.arg} [name]{.optarg} [title]{.optarg}
[::html::tableFromArray]{.cmd} [arrname]{.arg} [param]{.optarg} [pat]{.optarg}
[::html::tableFromList]{.cmd} [querylist]{.arg} [param]{.optarg}
[::html::textarea]{.cmd} [name]{.arg} [param]{.optarg} [current]{.optarg}
[::html::textInput]{.cmd} [name]{.arg} [value]{.arg} [args]{.arg}
[::html::textInputRow]{.cmd} [label]{.arg} [name]{.arg} [value]{.arg} [args]{.arg}
[::html::varEmpty]{.cmd} [name]{.arg}
[::html::while]{.cmd} [test]{.arg} [body]{.arg}
[::html::doctype]{.cmd} [id]{.arg}
[::html::wrapTag]{.cmd} [tag]{.arg} [text]{.optarg} [args]{.optarg}
:::

# Description

The package **html** provides commands that generate HTML. These commands typically return an HTML string as their result. In particular, they do not output their result to **stdout**.

The command **::html::init** should be called early to initialize the module.  You can also use this procedure to define default values for HTML tag parameters.

**::html::author** *author*
: *Side effect only*.  Call this before **::html::head** to define an author for the page.  The author is noted in a comment in the HEAD section.

**::html::bodyTag** *args*
: Generate a *body* tag.  The tag parameters are taken from *args* or from the body.\* attributes define with **::html::init**.

**::html::cell** *param value* ?*tag*?
: Generate a *td* (or *th*) tag, a value, and a closing *td* (or *th*) tag. The tag parameters come from *param* or TD.\* attributes defined with **::html::init**.  This uses **::html::font** to insert a standard *font* tag into the table cell. The *tag* argument defaults to "td".

**::html::checkbox** *name value*
: Generate a *checkbox* form element with the specified name and value. This uses **::html::checkValue**.

**::html::checkSet** *key sep list*
: Generate a set of *checkbox* form elements and associated labels.  The *list* should contain an alternating list of labels and values. This uses **::html::checkbox**. All the *checkbox* buttons share the same *key* for their name. The *sep* is text used to separate the elements.

**::html::checkValue** *name* ?*value*?
: Generate the "name=*name* value=*value*" for a *checkbox* form element.  If the CGI variable *name* has the value *value*, then SELECTED is added to the return value. *value* defaults to "1".

**::html::closeTag**
: Pop a tag off the stack created by **::html::openTag** and generate the corresponding close tag (e.g., </body>).

**::html::default** *key* ?*param*?
: This procedure is used by **::html::tagParam** to generate the name, value list of parameters for a tag.  The **::html::default** procedure is used to generate default values for those items not already in *param*.  If the value identified by *key* matches a value in *param* then this procedure returns the empty string. Otherwise, it returns a "parameter=value" string for a form element identified by *key*.  The *key* has the form "tag.parameter" (e.g., body.bgcolor).  Use **::html::init** to register default values. *param* defaults to the empty string.

**::html::description** *description*
: *Side effect only*.  Call this before **::html::head** to define a description *meta* tag for the page.  This tag is generated later in the call to **::html::head**.

**::html::end**
: Pop all open tags from the stack and generate the corresponding close HTML tags, (e.g., </body></html>).

**::html::eval** *arg* ?*args*?
: This procedure is similar to the built-in Tcl **eval** command.  The only difference is that it returns "" so it can be called from an HTML template file without appending unwanted results.

**::html::extractParam** *param key* ?*varName*?
: This is a parsing procedure that extracts the value of *key* from *param*, which is a HTML-style "name=quotedvalue" list. *varName* is used as the name of a Tcl variable that is changed to have the value found in the parameters.  The function returns 1 if the parameter was found in *param*, otherwise it returns 0.  If the *varName* is not specified, then *key* is used as the variable name.

**::html::font** *args*
: Generate a standard *font* tag.  The parameters to the tag are taken from *args* and the HTML defaults defined with **::html::init**.

**::html::for** *start test next body*
: This procedure is similar to the built-in Tcl **for** control structure.  Rather than evaluating the body, it returns the subst'ed *body*. Each iteration of the loop causes another string to be concatenated to the result value.

**::html::foreach** *varlist1 list1* ?*varlist2 list2 ...*? *body*
: This procedure is similar to the built-in Tcl **foreach** control structure.  Rather than evaluating the body, it returns the subst'ed *body*.  Each iteration of the loop causes another string to be concatenated to the result value.

**::html::formValue** *name* ?*defvalue*?
: Return a name and value pair, where the value is initialized from existing CGI data, if any.  The result has this form:

    ```
      name="fred" value="freds value"
    ```

**::html::getFormInfo** *args*
: Generate hidden fields to capture form values.  If *args* is empty, then hidden fields are generated for all CGI values.  Otherwise args is a list of string match patterns for form element names.

**::html::getTitle**
: Return the title string, with out the surrounding *title* tag, set with a previous call to **::html::title**.

**::html::h** *level string* ?*param*?
: Generate a heading (e.g., *h***level**) tag.  The *string* is nested in the heading, and *param* is used for the tag parameters.

**::html::h1** *string* ?*param*?
: Generate an *h1* tag.  See **::html::h**.

**::html::h2** *string* ?*param*?
: Generate an *h2* tag.  See **::html::h**.

**::html::h3** *string* ?*param*?
: Generate an *h3* tag.  See **::html::h**.

**::html::h4** *string* ?*param*?
: Generate an *h4* tag.  See **::html::h**.

**::html::h5** *string* ?*param*?
: Generate an *h5* tag.  See **::html::h**.

**::html::h6** *string* ?*param*?
: Generate an *h6* tag.  See **::html::h**.

**::html::hdrRow** *args*
: Generate a table row, including *tr* and *th* tags. Each value in *args* is place into its own table cell. This uses **::html::cell**.

**::html::head** *title*
: Generate the *head* section that includes the page *title*. If previous calls have been made to **::html::author**, **::html::keywords**, **::html::description**, or **::html::meta** then additional tags are inserted into the *head* section. This leaves an open *html* tag pushed on the stack with **::html::openTag**.

**::html::headTag** *string*
: Save a tag for inclusion in the *head* section generated by **::html::head**.  The *string* is everything in the tag except the enclosing angle brackets, < >.

**::html::html\_entities** *string*
: This command replaces all special characters in the *string* with their HTML entities and returns the modified text.

**::html::if** *expr1 body1* ?**elseif** *expr2 body2 ...*? ?**else** *bodyN*?
: This procedure is similar to the built-in Tcl **if** control structure.  Rather than evaluating the body of the branch that is taken, it returns the subst'ed *body*.  Note that the syntax is slightly more restrictive than that of the built-in Tcl **if** control structure.

**::html::init** ?*list*?
: **::html::init** accepts a Tcl-style name-value list that defines values for items with a name of the form "tag.parameter".  For example, a default with key "body.bgcolor" defines the background color for the *body* tag.

**::html::keywords** *args*
: *Side effect only*.  Call this before **::html::head** to define a keyword *meta* tag for the page.  The *meta* tag is included in the result of **::html::head**.

**::html::mailto** *email* ?*subject*?
: Generate a hypertext link to a mailto: URL.

**::html::meta** *args*
: Compatibility name for **html::meta\_name**.

**::html::meta\_name** *args*
: *Side effect only*. Call this before **::html::head** to define a *meta* tag for the page. The arguments (*args*) are a Tcl-style name, value list that is used for the **name=** and **content=** attributes of the *meta* tag.  The *meta* tag is included in the result of **::html::head**.

**::html::meta\_equiv** *args*
: *Side effect only*. Call this before **::html::head** to define a *meta* tag for the page. The arguments (*args*) are a Tcl-style name, value list that is used for the **http-equiv=** and **content=** attributes of the *meta* tag.  The *meta* tag is included in the result of **::html::head**.

**::html::meta\_charset** *charset*
: *Side effect only*. Call this before **::html::head** to define a *meta* tag for the page. The *charset* is used with the **charset=** attribute of the *meta* tag.  The *meta* tag is included in the result of **::html::head**.

**::html::css** *href*
: *Side effect only*.  Call this before **::html::head** to define a *link* tag for a linked CSS document.  The *href* value is a HTTP URL to a CSS document. The *link* tag is included in the result of **::html::head**.

    Multiple calls of this command are allowed, enabling the use of multiple CSS document references. In other words, the arguments of multiple calls are accumulated, and do not overwrite each other.

**::html::css-clear**
: *Side effect only*.  Call this before **::html::head** to clear all links to CSS documents.

    Multiple calls of this command are allowed, doing nothing after the first of a sequence with no intervening **::html::css**.

**::html::js** *href*
: *Side effect only*.  Call this before **::html::head** to define a *script* tag for a linked JavaScript document.  The *href* is a HTTP URL to a JavaScript document. The *script* tag is included in the result of **::html::head**.

    Multiple calls of this command are allowed, enabling the use of multiple JavaScript document references. In other words, the arguments of multiple calls are accumulated, and do not overwrite each other.

**::html::js-clear**
: *Side effect only*.  Call this before **::html::head** to clear all links to JavaScript documents.

    Multiple calls of this command are allowed, doing nothing after the first of a sequence with no intervening **::html::js**.

**::html::minorList** *list* ?*ordered*?
: Generate an ordered or unordered list of links.  The *list* is a Tcl-style name, value list of labels and urls for the links. *ordered* is a boolean used to choose between an ordered or unordered list. It defaults to **false**.

**::html::minorMenu** *list* ?*sep*?
: Generate a series of hypertext links.  The *list* is a Tcl-style name, value list of labels and urls for the links.  The *sep* is the text to put between each link. It defaults to " | ".

**::html::nl2br** *string*
: This command replaces all line-endings in the *string* with a *br* tag and returns the modified text.

**::html::openTag** *tag* ?*param*?
: Push *tag* onto a stack and generate the opening tag for *tag*. Use **::html::closeTag** to pop the tag from the stack. The second argument provides any tag arguments, as a list whose elements are formatted to be in the form "**key**=**value**".

**::html::paramRow** *list* ?*rparam*? ?*cparam*?
: Generate a table row, including *tr* and *td* tags. Each value in *list* is placed into its own table cell. This uses **::html::cell**. The value of *rparam* is used as parameter for the *tr* tag. The value of *cparam* is passed to **::html::cell** as parameter for the *td* tags.

**::html::passwordInput** ?*name*?
: Generate an *input* tag of type *password*. The *name* defaults to "password".

**::html::passwordInputRow** *label* ?*name*?
: Format a table row containing a label and an *input* tag of type *password*. The *name* defaults to "password".

**::html::quoteFormValue** *value*
: Quote special characters in *value* by replacing them with HTML entities for quotes, ampersand, and angle brackets.

**::html::radioSet** *key sep list*
: Generate a set of *input* tags of type *radio* and an associated text label.  All the radio buttons share the same *key* for their name. The *sep* is text used to separate the elements.  The *list* is a Tcl-style label, value list.

**::html::radioValue** *name value*
: Generate the "name=*name* value=*value*" for a *radio* form element.  If the CGI variable *name* has the value *value*, then SELECTED is added to the return value.

**::html::refresh** *seconds url*
: Set up a refresh *meta* tag. Call this before **::html::head** and the HEAD section will contain a *meta* tag that causes the document to refresh in *seconds* seconds.  The *url* is optional.  If specified, it specifies a new page to load after the refresh interval.

**::html::row** *args*
: Generate a table row, including *tr* and *td* tags.  Each value in *args* is place into its own table cell. This uses **::html::cell**. Ignores any default information set up via **::html::init**.

**::html::select** *name param choices* ?*current*?
: Generate a *select* form element and nested *option* tags. The *name* and *param* are used to generate the *select* tag. The *choices* list is a Tcl-style name, value list.

**::html::selectPlain** *name param choices* ?*current*?
: Like **::html::select** except that *choices* is a Tcl list of values used for the *option* tags.  The label and the value for each *option* are the same.

**::html::set** *var val*
: This procedure is similar to the built-in Tcl **set** command.  The main difference is that it returns "" so it can be called from an HTML template file without appending unwanted results.  The other difference is that it must take two arguments.

**::html::submit** *label* ?*name*? ?*title*?
: Generate an *input* tag of type *submit*. The *name* defaults to "submit". When a non-empty *title* string is specified the button gains a **title=** attribute with that value.

**::html::tableFromArray** *arrname* ?*param*? ?*pat*?
: Generate a two-column *table* and nested rows to display a Tcl array. The table gets a heading that matches the array name, and each generated row contains a name, value pair. The array names are sorted (**lsort** without special options). The argument *param* is for the *table* tag and has to contain a pre-formatted string. The *pat* is a **string match** pattern used to select the array elements to show in the table. It defaults to **\***, i.e. the whole array is shown.

**::html::tableFromList** *querylist* ?*param*?
: Generate a two-column *table* and nested rows to display *querylist*, which is a Tcl dictionary. Each generated row contains a name, value pair. The information is shown in the same order as specified in the dictionary. The argument *param* is for the *table* tag  and has to contain a pre-formatted string.

**::html::textarea** *name* ?*param*? ?*current*?
: Generate a *textarea* tag wrapped around its current values.

**::html::textInput** *name value args*
: Generate an *input* form tag with type *text*.  This uses **::html::formValue**.  The args is any additional tag attributes you want to put into the *input* tag.

**::html::textInputRow** *label name value args*
: Generate an *input* form tag with type *text* formatted into a table row with an associated label.  The args is any additional tag attributes you want to put into the *input* tag.

**::html::varEmpty** *name*
: This returns 1 if the named variable either does not exist or has the empty string for its value.

**::html::while** *test body*
: This procedure is similar to the built-in Tcl **while** control structure.  Rather than evaluating the body, it returns the subst'ed *body*.  Each iteration of the loop causes another string to be concatenated to the result value.

**::html::doctype** *id*
: This procedure can be used to build the standard DOCTYPE declaration string. It will return the standard declaration string for the id, or throw an error if the id is not known. The following id's are defined:

    1. HTML32

    2. HTML40

    3. HTML40T

    4. HTML40F

    5. HTML401

    6. HTML401T

    7. HTML401F

    8. XHTML10S

    9. XHTML10T

    10. XHTML10F

    11. XHTML11

    12. XHTMLB


**::html::wrapTag** *tag* ?*text*? ?*args*?
: A helper to wrap a *text* in a pair of open/close *tag*s. The arguments (*args*) are a Tcl-style name, value list that is used to provide attributes and associated values to the opening tag. The result is a string with the open *tag* along with the optional attributes, the optional text, and the closed tag.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *html* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

CGI programming
