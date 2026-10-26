---
CommandName: clay
title: clay
ManualSection: n
Version: 0.8.8
TclPart: tcllib
TclDescription: Clay Framework
Keywords:
 - TclOO
 - oo
Copyright:
 - Copyright (c) 2018 Sean Woods <yoda@etoyoc.com>
---

# Name

clay - A minimalist framework for large scale OO Projects

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [uuid]{.lit}
[package]{.cmd} [require]{.sub} [oo::dialect]{.lit}
:::

proc **clay::PROC** *name* *arglist* *body* ?*ninja* ?

proc **clay::\_ancestors** *resultvar* *class*

proc **clay::ancestors** ?*args*?

proc **clay::args\_to\_dict** ?*args*?

proc **clay::args\_to\_options** ?*args*?

proc **clay::dynamic\_arguments** *ensemble* *method* *arglist* ?*args*?

proc **clay::dynamic\_wrongargs\_message** *arglist*

proc **clay::is\_dict** *d*

proc **clay::is\_null** *value*

proc **clay::leaf** ?*args*?

proc **clay::K** *a* *b*

proc **clay::noop** ?*args*?

proc **clay::cleanup**

proc **clay::object\_create** *objname* ?*class* ?

proc **clay::object\_rename** *object* *newname*

proc **clay::object\_destroy** ?*args*?

proc **clay::path** ?*args*?

proc **clay::putb** ?*map*? *text*

proc **clay::script\_path**

proc **clay::NSNormalize** *qualname*

proc **clay::uuid\_generate** ?*args*?

proc **clay::uuid::generate\_tcl\_machinfo**

proc **clay::uuid::tostring** *uuid*

proc **clay::uuid::fromstring** *uuid*

proc **clay::uuid::equal** *left* *right*

proc **clay::uuid** *cmd* ?*args*?

proc **clay::tree::sanitize** *dict*

proc **clay::tree::\_sanitizeb** *path* *varname* *dict*

proc **clay::tree::storage** *rawpath*

proc **clay::tree::dictset** *varname* ?*args*?

proc **clay::tree::dictmerge** *varname* ?*args*?

proc **clay::tree::merge** ?*args*?

proc **dictargs::proc** *name* *argspec* *body*

proc **dictargs::method** *name* *argspec* *body*

proc **clay::dialect::Push** *class*

proc **clay::dialect::Peek**

proc **clay::dialect::Pop**

proc **clay::dialect::create** *name* ?*parent* ?

proc **clay::dialect::NSNormalize** *namespace* *qualname*

proc **clay::dialect::DefineThunk** *target* ?*args*?

proc **clay::dialect::Canonical** *namespace* *NSpace* *class*

proc **clay::dialect::Define** *namespace* *class* ?*args*?

proc **clay::dialect::Aliases** *namespace* ?*args*?

proc **clay::dialect::SuperClass** *namespace* ?*args*?

proc **clay::dynamic\_methods** *class*

proc **clay::dynamic\_methods\_class** *thisclass*

proc **clay::define::Array** *name* ?*values* ?

proc **clay::define::Delegate** *name* *info*

proc **clay::define::constructor** *arglist* *rawbody*

proc **clay::define::Class\_Method** *name* *arglist* *body*

proc **clay::define::class\_method** *name* *arglist* *body*

proc **clay::define::clay** ?*args*?

proc **clay::define::destructor** *rawbody*

proc **clay::define::Dict** *name* ?*values* ?

proc **clay::define::Option** *name* ?*args*?

proc **clay::define::Method** *name* *argstyle* *argspec* *body*

proc **clay::define::Option\_Class** *name* ?*args*?

proc **clay::define::Variable** *name* ?*default* ?

proc **clay::ensemble\_methodbody** *ensemble* *einfo*

proc **clay::define::Ensemble** *rawmethod* ?*args*?

proc **clay::event::cancel** *self* ?*task* **\***?

proc **clay::event::generate** *self* *event* ?*args*?

proc **clay::event::nextid**

proc **clay::event::Notification\_list** *self* *event* ?*stackvar* ?

proc **clay::event::notify** *rcpt* *sender* *event* *eventinfo*

proc **clay::event::process** *self* *handle* *script*

proc **clay::event::schedule** *self* *handle* *interval* *script*

proc **clay::event::subscribe** *self* *who* *event*

proc **clay::event::unsubscribe** *self* ?*args*?

proc **clay::singleton** *name* *script*

method **clay ancestors**

method **clay dump**

method **clay find** *path* ?**path...**?

method **clay get** *path* ?**path...**?

method **clay GET** *path* ?**path...**?

method **clay merge** *dict* ?**dict...**?

method **clay replace** *dictionary*

method **clay search** *path* ?**path...**?

method **clay set** *path* ?**path...**? *value*

method **clay ancestors**

method **clay cache** *path* *value*

method **clay cget** *field*

method **clay delegate** ?*stub*? ?*object*?

method **clay dump**

method **clay ensemble\_map**

method **clay eval** *script*

method **clay evolve**

method **clay exists** *path* ?**path...**?

method **clay flush**

method **clay forward** *method* *object*

method **clay get** *path* ?**path...**?

method **clay leaf** *path* ?**path...**?

method **clay merge** *dict* ?**dict...**?

method **clay mixin** *class* ?**class...**?

method **clay mixinmap** ?*stub*? ?*classes*?

method **clay provenance** *path* ?**path...**?

method **clay replace** *dictionary*

method **clay search** *path* *valuevar* *isleafvar*

method **clay source** *filename*

method **clay set** *path* ?**path...**? *value*

method **InitializePublic**

# Description

Clay introduces a method ensemble to both **oo::class** and **oo::object** called clay. This ensemble handles all of the high level interactions within the framework. Clay stores structured data. Clan manages method delegation. Clay has facilities to manage the complex interactions that come about with mixins.

The central concept is that inside of every object and class (which are actually objects too) is a dict called clay. What is stored in that dict is left to the imagination. But because this dict is exposed via a public method, we can share structured data between object, classes, and mixins.

## Structured data

Clay uses a standardized set of method interactions and introspection that TclOO already provides to perform on-the-fly searches. On-the-fly searches mean that the data is never stale, and we avoid many of the sorts of collisions that would arise when objects start mixing in other classes during operation.

The **clay** methods for both classes and objects have a get and a set method. For objects, get will search through the local clay dict. If the requested leaf is not found, or the query is for a branch, the system will then begin to poll the clay methods of all of the class that implements the object, all of that classes’ ancestors, as well as all of the classes that have been mixed into this object, and all of their ancestors.

Intended branches on a tree end with a directory slash (/). Intended leaves are left unadorned. This is a guide for the tool that builds the search results to know what parts of a dict are intended to be branches and which are intended to be leaves. For simple cases, branch marking can be ignored:

```
::oo::class create ::foo { }
::foo clay set property/ color blue
::foo clay set property/ shape round

set A [::foo new]
$A clay get property/
{color blue shape round}

$A clay set property/ shape square
$A clay get property/
{color blue shape square}
```

But when you start storing blocks of text, guessing what field is a dict and what isn’t gets messy:

```
::foo clay set description {A generic thing of designated color and shape}

$A clay get description
{A generic thing of designated color and shape}

Without a convention for discerning branches for leaves what should have been a value can be accidentally parsed as a dictionary, and merged with all of the other values that were never intended to be merge. Here is an example of it all going wrong:
::oo::class create ::foo { }
# Add description as a leaf
::foo clay set description  {A generic thing of designated color and shape}
# Add description as a branch
::foo clay set description/  {A generic thing of designated color and shape}

::oo::class create ::bar {
  superclass foo
}
# Add description as a leaf
::bar clay set description  {A drinking establishment of designated color and shape and size}
# Add description as a branch
::bar clay set description/  {A drinking establishment of designated color and shape and size}

set B [::bar new]
# As a leaf we get the value verbatim from he nearest ancestor
$B clay get description
  {A drinking establishment of designated color and shape and size}
# As a branch we get a recursive merge
$B clay get description/
{A drinking establishment of designated color and size thing of}
```

## Clay dialect

Clay is built using the oo::dialect module from Tcllib. oo::dialect allows you to either add keywords directly to clay, or to create your own metaclass and keyword set using Clay as a foundation. For details on the keywords and what they do, consult the functions in the ::clay::define namespace.

## Method delegation

Method Delegation It is sometimes useful to have an external object that can be invoked as if it were a method of the object. Clay provides a delegate ensemble method to perform that delegation, as well as introspect which methods are delegated in that manner. All delegated methods are marked with html-like tag markings (< >) around them.

```
::clay::define counter {
  Variable counter 0
  method incr {{howmuch 1}} {
    my variable counter
    incr counter $howmuch
  }
  method value {} {
    my variable counter
    return $counter
  }
  method reset {} {
    my variable counter
    set counter 0
  }
}
::clay::define example {
  variable buffer
  constructor {} {
    # Build a counter object
    set obj [namespace current]::counter
    ::counter create $obj
    # Delegate the counter
    my delegate <counter> $obj
  }
  method line {text} {
    my <counter> incr
    append buffer $text
  }
}

set A [example new]
$A line {Who’s line is it anyway?}
$A <counter> value
1
```

# Commands

proc **clay::PROC** *name* *arglist* *body* ?*ninja* ?
: Because many features in this package may be added as commands to future tcl cores, or be provided in binary form by packages, I need a declaritive way of saying *Create this command if there isn't one already*. The *ninja* argument is a script to execute if the command is created by this mechanism.

proc **clay::\_ancestors** *resultvar* *class*
: see below ...

proc **clay::ancestors** ?*args*?
: see below ...

proc **clay::args\_to\_dict** ?*args*?
: see below ...

proc **clay::args\_to\_options** ?*args*?
: see below ...

proc **clay::dynamic\_arguments** *ensemble* *method* *arglist* ?*args*?
: see below ...

proc **clay::dynamic\_wrongargs\_message** *arglist*
: see below ...

proc **clay::is\_dict** *d*
: see below ...

proc **clay::is\_null** *value*
: see below ...

proc **clay::leaf** ?*args*?
: see below ...

proc **clay::K** *a* *b*
: see below ...

proc **clay::noop** ?*args*?
: Perform a noop. Useful in prototyping for commenting out blocks of code without actually having to comment them out. It also makes a handy default for method delegation if a delegate has not been assigned yet.

proc **clay::cleanup**
: Process the queue of objects to be destroyed

proc **clay::object\_create** *objname* ?*class* ?
: see below ...

proc **clay::object\_rename** *object* *newname*
: see below ...

proc **clay::object\_destroy** ?*args*?
: Mark an objects for destruction on the next cleanup

proc **clay::path** ?*args*?
: see below ...

proc **clay::putb** ?*map*? *text*
: Append a line of text to a variable. Optionally apply a string mapping.

proc **clay::script\_path**
: see below ...

proc **clay::NSNormalize** *qualname*
: see below ...

proc **clay::uuid\_generate** ?*args*?
: see below ...

proc **clay::uuid::generate\_tcl\_machinfo**
: see below ...

proc **clay::uuid::tostring** *uuid*
: see below ...

proc **clay::uuid::fromstring** *uuid*
: Convert a string representation of a uuid into its binary format.

proc **clay::uuid::equal** *left* *right*
: Compare two uuids for equality.

proc **clay::uuid** *cmd* ?*args*?
: uuid generate -> string rep of a new uuid uuid equal uuid1 uuid2

proc **clay::tree::sanitize** *dict*
: Output a dictionary removing any . entries added by **clay::tree::merge**

proc **clay::tree::\_sanitizeb** *path* *varname* *dict*
: Helper function for ::clay::tree::sanitize Formats the string representation for a dictionary element within a human readable stream of lines, and determines if it needs to call itself with further indentation to express a sub-branch

proc **clay::tree::storage** *rawpath*
: Return the path as a storage path for clay::tree with all branch terminators removed. This command will also break arguments up if they contain /.

    Example:

    ```
     > clay::tree::storage {foo bar baz bang}
     foo bar baz bang
     > clay::tree::storage {foo bar baz bang/}
     foo bar baz bang
     > clay::tree::storage {foo bar baz bang:}
     foo bar baz bang:
     > clay::tree::storage {foo/bar/baz bang:}
     foo bar baz bang:
     > clay::tree::storage {foo/bar/baz/bang}
     foo bar baz bang
    ```

proc **clay::tree::dictset** *varname* ?*args*?
: Set an element with a recursive dictionary, marking all branches on the way down to the final element. If the value does not exists in the nested dictionary it is added as a leaf. If the value already exists as a branch the value given is merged if the value is a valid dict. If the incoming value is not a valid dict, the value overrides the value stored, and the value is treated as a leaf from then on.

    Example:

    ```
     > set r {}
     > ::clay::tree::dictset r option color default Green
     . {} option {. {} color {. {} default Green}}
     > ::clay::tree::dictset r option {Something not dictlike}
     . {} option {Something not dictlike}
     # Note that if the value is not a dict, and you try to force it to be
     # an error with be thrown on the merge
     > ::clay::tree::dictset r option color default Blue
     missing value to go with key
    ```

proc **clay::tree::dictmerge** *varname* ?*args*?
: A recursive form of dict merge, intended for modifying variables in place.

    Example:

    ```
     > set mydict {sub/ {sub/ {description {a block of text}}}}
     > ::clay::tree::dictmerge mydict {sub/ {sub/ {field {another block of text}}}}]
     > clay::tree::print $mydict
     sub/ {
       sub/ {
         description {a block of text}
         field {another block of text}
       }
     }
    ```

proc **clay::tree::merge** ?*args*?
: A recursive form of dict merge

    A routine to recursively dig through dicts and merge adapted from <http://stevehavelka.com/tcl-dict-operation-nested-merge/>

    Example:

    ```
     > set mydict {sub/ {sub/ {description {a block of text}}}}
     > set odict [clay::tree::merge $mydict {sub/ {sub/ {field {another block of text}}}}]
     > clay::tree::print $odict
     sub/ {
       sub/ {
         description {a block of text}
         field {another block of text}
       }
     }
    ```

proc **dictargs::proc** *name* *argspec* *body*
: Named Procedures as new command

proc **dictargs::method** *name* *argspec* *body*
: see below ...

proc **clay::dialect::Push** *class*
: see below ...

proc **clay::dialect::Peek**
: see below ...

proc **clay::dialect::Pop**
: see below ...

proc **clay::dialect::create** *name* ?*parent* ?
: This proc will generate a namespace, a "mother of all classes", and a rudimentary set of policies for this dialect.

proc **clay::dialect::NSNormalize** *namespace* *qualname*
: Support commands; not intended to be called directly.

proc **clay::dialect::DefineThunk** *target* ?*args*?
: see below ...

proc **clay::dialect::Canonical** *namespace* *NSpace* *class*
: see below ...

proc **clay::dialect::Define** *namespace* *class* ?*args*?
: Implementation of the languages' define command

proc **clay::dialect::Aliases** *namespace* ?*args*?
: see below ...

proc **clay::dialect::SuperClass** *namespace* ?*args*?
: see below ...

proc **clay::dynamic\_methods** *class*
: see below ...

proc **clay::dynamic\_methods\_class** *thisclass*
: see below ...

proc **clay::define::Array** *name* ?*values* ?
: New OO Keywords for clay

proc **clay::define::Delegate** *name* *info*
: An annotation that objects of this class interact with delegated methods. The annotation is intended to be a dictionary, and the only reserved key is *description*, a human readable description.

proc **clay::define::constructor** *arglist* *rawbody*
: see below ...

proc **clay::define::Class\_Method** *name* *arglist* *body*
: Specify the a method for the class object itself, instead of for objects of the class

proc **clay::define::class\_method** *name* *arglist* *body*
: And alias to the new Class\_Method keyword

proc **clay::define::clay** ?*args*?
: see below ...

proc **clay::define::destructor** *rawbody*
: see below ...

proc **clay::define::Dict** *name* ?*values* ?
: see below ...

proc **clay::define::Option** *name* ?*args*?
: Define an option for the class

proc **clay::define::Method** *name* *argstyle* *argspec* *body*
: see below ...

proc **clay::define::Option\_Class** *name* ?*args*?
: Define a class of options All field / value pairs will be be inherited by an option that specify *name* as it class field.

proc **clay::define::Variable** *name* ?*default* ?
: This keyword can also be expressed:

    ```
    property variable NAME {default DEFAULT}
    ```

    Variables registered in the variable property are also initialized (if missing) when the object changes class via the *morph* method.

proc **clay::ensemble\_methodbody** *ensemble* *einfo*
: Produce the body of an ensemble's public dispatch method ensemble is the name of the the ensemble. einfo is a dictionary of methods for the ensemble, and each value is a script to execute on dispatch

    Example:

    ```
     ::clay::ensemble_methodbody foo {
       bar {tailcall my Foo_bar {*}$args}
       baz {tailcall my Foo_baz {*}$args}
       clock {return [clock seconds]}
       default {puts "You gave me $method"}
     }
    ```

proc **clay::define::Ensemble** *rawmethod* ?*args*?
: see below ...

proc **clay::event::cancel** *self* ?*task* **\***?
: Cancel a scheduled event

proc **clay::event::generate** *self* *event* ?*args*?
: Generate an event Adds a subscription mechanism for objects to see who has recieved this event and prevent spamming or infinite recursion

proc **clay::event::nextid**
: see below ...

proc **clay::event::Notification\_list** *self* *event* ?*stackvar* ?
: Called recursively to produce a list of who recieves notifications

proc **clay::event::notify** *rcpt* *sender* *event* *eventinfo*
: Final delivery to intended recipient object

proc **clay::event::process** *self* *handle* *script*
: Evaluate an event script in the global namespace

proc **clay::event::schedule** *self* *handle* *interval* *script*
: Schedule an event to occur later

proc **clay::event::subscribe** *self* *who* *event*
: Subscribe an object to an event pattern

proc **clay::event::unsubscribe** *self* ?*args*?
: Unsubscribe an object from an event pattern

proc **clay::singleton** *name* *script*
: An object which is intended to be it's own class.


# Classes

## Class  clay::class

**Methods**

method **clay ancestors**
: Return this class and all ancestors in search order.

method **clay dump**
: Return a complete dump of this object's clay data, but only this object's clay data.

method **clay find** *path* ?**path...**?
: Pull a chunk of data from the clay system. If the last element of *path* is a branch, returns a recursive merge of all data from this object and it's constituent classes of the data in that branch. If the last element is a leaf, search this object for a matching leaf, or search all  constituent classes for a matching leaf and return the first value found. If no value is found, returns an empty string. If a branch is returned the topmost . entry is omitted.

method **clay get** *path* ?**path...**?
: Pull a chunk of data from the class's clay system. If no value is found, returns an empty string. If a branch is returned the topmost . entry is omitted.

method **clay GET** *path* ?**path...**?
: Pull a chunk of data from the class's clay system. If no value is found, returns an empty string.

method **clay merge** *dict* ?**dict...**?
: Recursively merge the dictionaries given into the object's local clay storage.

method **clay replace** *dictionary*
: Replace the contents of the internal clay storage with the dictionary given.

method **clay search** *path* ?**path...**?
: Return the first matching value for the path in either this class's clay data or one of its ancestors

method **clay set** *path* ?**path...**? *value*
: Merge the conents of **value** with the object's clay storage at **path**.


## Class  clay::object

clay::object This class is inherited by all classes that have options.

**Methods**

method **clay ancestors**
: Return the class this object belongs to, all classes mixed into this object, and all ancestors of those classes in search order.

method **clay cache** *path* *value*
: Store VALUE in such a way that request in SEARCH for PATH will always return it until the cache is flushed

method **clay cget** *field*
: Pull a value from either the object's clay structure or one of its constituent classes that matches the field name. The order of search us:

    1. The as a value in local dict variable config

    2. The as a value in local dict variable clay

    3. As a leaf in any ancestor as a root of the clay tree

    4. As a leaf in any ancestor as **const** *field*

    5. As a leaf in any ancestor as **option** *field* **default**

method **clay delegate** ?*stub*? ?*object*?
: Introspect or control method delegation. With no arguments, the method will return a key/value list of stubs and objects. With just the *stub* argument, the method will return the object (if any) attached to the stub. With a *stub* and an *object* this command will forward all calls to the method *stub* to the *object*.

method **clay dump**
: Return a complete dump of this object's clay data, as well as the data from all constituent classes recursively blended in.

method **clay ensemble\_map**
: Return a dictionary describing the method ensembles to be assembled for this object

method **clay eval** *script*
: Evaluated a script in the namespace of this object

method **clay evolve**
: Trigger the **InitializePublic** private method

method **clay exists** *path* ?**path...**?
: Returns 1 if *path* exists in either the object's clay data. Values greater than one indicate the element exists in one of the object's constituent classes. A value of zero indicates the path could not be found.

method **clay flush**
: Wipe any caches built by the clay implementation

method **clay forward** *method* *object*
: A convenience wrapper for

    ```
    oo::objdefine [self] forward {*}$args
    ```

method **clay get** *path* ?**path...**?
: Pull a chunk of data from the clay system. If the last element of *path* is a branch (ends in a slash /), returns a recursive merge of all data from this object and it's constituent classes of the data in that branch. If the last element is a leaf, search this object for a matching leaf, or search all  constituent classes for a matching leaf and return the first value found. If no value is found, returns an empty string.

method **clay leaf** *path* ?**path...**?
: A modified get which is tailored to pull only leaf elements

method **clay merge** *dict* ?**dict...**?
: Recursively merge the dictionaries given into the object's local clay storage.

method **clay mixin** *class* ?**class...**?
: Perform \[oo::objdefine \[self\] mixin\] on this object, with a few additional rules: Prior to the call, for any class was previously mixed in, but not in the new result, execute the script registered to mixin/ unmap-script (if given.) For all new classes, that were not present prior to this call, after the native TclOO mixin is invoked, execute the script registered to mixin/ map-script (if given.) Fall all classes that are now present and “mixed in”, execute the script registered to mixin/ react-script (if given.)

method **clay mixinmap** ?*stub*? ?*classes*?
: With no arguments returns the map of stubs and classes mixed into the current object. When only stub is given, returns the classes mixed in on that stub. When stub and classlist given, replace the classes currently on that stub with the given classes and invoke clay mixin on the new matrix of mixed in classes.

method **clay provenance** *path* ?**path...**?
: Return either **self** if that path exists in the current object, or return the first class (if any) along the clay search path which contains that element.

method **clay replace** *dictionary*
: Replace the contents of the internal clay storage with the dictionary given.

method **clay search** *path* *valuevar* *isleafvar*
: Return true, and set valuevar to the value and isleafar to true for false if PATH was found in the cache.

method **clay source** *filename*
: Source the given filename within the object's namespace

method **clay set** *path* ?**path...**? *value*
: Merge the conents of **value** with the object's clay storage at **path**.

method **InitializePublic**
: Instantiate variables. Called on object creation and during clay mixin.


# Authors

Sean Woods *mailto:<yoda@etoyoc.com>*

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *oo* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools

# Copyright

```
Copyright (c) 2018 Sean Woods <yoda@etoyoc.com>
```
