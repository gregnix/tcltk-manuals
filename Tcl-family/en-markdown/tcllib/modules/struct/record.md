---
CommandName: struct::record
title: struct::record
ManualSection: n
Version: 1.2.4
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - data structures
 - record
 - struct
Copyright:
 - Copyright (c) 2002, Brett Schwarz <brett_schwarz@yahoo.com>
---

# Name

struct::record - Define and create records (similar to 'C' structures)

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::record]{.lit} [1.2.4]{.optlit}
[record]{.cmd} [define]{.sub} [recordName]{.arg} [recordMembers]{.arg} [instanceName1 instanceName2]{.optdot}
[record]{.cmd} [show]{.sub} [record]{.arg}
[record]{.cmd} [show]{.sub} [instances]{.arg} [recordName]{.arg}
[record]{.cmd} [show]{.sub} [members]{.arg} [recordName]{.arg}
[record]{.cmd} [show]{.sub} [values]{.arg} [instanceName]{.arg}
[record]{.cmd} [exists]{.sub} [record]{.arg} [recordName]{.arg}
[record]{.cmd} [exists]{.sub} [instance]{.arg} [instanceName]{.arg}
[record]{.cmd} [delete]{.sub} [record]{.arg} [recordName]{.arg}
[record]{.cmd} [delete]{.sub} [instance]{.arg} [instanceName]{.arg}
[instanceName]{.ins} [cget]{.sub} -member
[instanceName]{.ins} [cget]{.sub} -member1 -member2
[instanceName]{.ins} [cget]{.sub}
[instanceName]{.ins} [configure]{.sub}
[instanceName]{.ins}
[instanceName]{.ins} [configure]{.sub} -member [value]{.arg}
[instanceName]{.ins} [configure]{.sub} -member1 [value1]{.arg} -member2 [value2]{.arg}
[recordName]{.ins} [instanceName|#auto]{.sub} [-member1 value1 -member2 value2]{.optdot}
[instanceName]{.ins} [cget]{.sub} [-member1 -member2]{.optdot}
[instanceName]{.ins} [configure]{.sub} [-member1 value1 -member2 value2]{.optdot}
:::

# Description

The **::struct::record** package provides a mechanism to group variables together as one data structure, similar to a *C* structure. The members of a record can be variables or other records. However, a record can not contain circular records, i.e. records that contain the same record as a member.

This package was structured so that it is very similar to how Tk objects work. Each record definition creates a record object that encompasses that definition. Subsequently, that record object can create instances of that record. These instances can then be manipulated with the **cget** and **configure** methods.

The package only contains one top level command, but several sub commands (see below). It also obeys the namespace in which the record was defined, hence the objects returned are fully qualified.

*Note: Tcl 9 users may find Tcl's built-in object-oriented functionality is more convenient and versatile than using this package.*

**record define** *recordName* *recordMembers* ?*instanceName1 instanceName2 ...*?
: Defines a record. *recordName* is the name of the record, and is also used as an object command. This object command is used to create instances of the record definition. The *recordMembers* are the members of the record that make up the record definition. These are variables and other records. If optional *instanceName* args are specified, then an instance is generated after the definition is created for each *instanceName*.

**record show** *record*
: Returns a list of records that have been defined.

**record show** *instances* *recordName*
: Returns the instances that have been instantiated by *recordName*.

**record show** *members* *recordName*
: Returns the members that are defined for record *recordName*. It returns the same format as how the records were defined.

**record show** *values* *instanceName*
: Returns a list of values that are set for the instance *instanceName*. The output is a list of key/value pairs. If there are nested records, then the values of the nested records will itself be a list.

**record exists** *record* *recordName*
: Tests for the existence of a *record* with the name *recordName*.

**record exists** *instance* *instanceName*
: Tests for the existence of a *instance* with the name *instanceName*.

**record delete** *record* *recordName*
: Deletes *recordName*, and all instances of *recordName*. It will return an error if the record does not exist.

**record delete** *instance* *instanceName*
: Deletes *instance* with the name of *instanceName*. It will return an error if the instance does not exist. Note that this recursively deletes any nested instances as well.


# Record members

Record members can either be variables, or other records, However, the same record can not be nested witin itself (circular). To define a nested record, you need to specify the **record** keyword, along the with name of the record, and the name of the instance of that nested record (within the container). For example, it would look like this:

```
# this is the nested record
record define mynestedrecord {
    nest1
    nest2
}

# This is the main record
record define myrecord {
    mem1
    mem2
    {record mynestedrecord mem3}
}
```

You can also assign default or initial values to the members of a record, by enclosing the member entry in braces:

```
record define myrecord {
    mem1
    {mem2 5}
}
```

All instances created from this record definition will initially have **5** as the value for member *mem2*. If no default is given, then the value will be the empty string.

## Getting values

To get a value of a member, there are several ways to do this.

*instanceName* **cget** -*member*
: In this form the built-in **cget** instance method returns the value of the specified *member*. Note the leading dash.

    To reach a nested member use *dot notation*:

    ```
    instanceName cget -mem3.nest1
    ```

*instanceName* **cget** -*member1* -*member2*
: In this form the built-in **cget** instance method returns a list containing the values of both specified members, in the order of specification.

*instanceName* **cget**
: see below ...

*instanceName* **configure**
: see below ...

*instanceName*
: These forms are all equivalent. They return a dictionary of all members and the associated values.


## Setting values

To set a value of a member, there are several ways to do this.

*instanceName* **configure** -*member* *value*
: In this form the built-in **configure** instance method sets the specified *member* to the given *value*. Note the leading dash.

    To reach a nested member use *dot notation*:

    ```
    instanceName configure -mem3.nest1 value
    ```

*instanceName* **configure** -*member1* *value1* -*member2* *value2*
: In this form the built-in **configure** instance method sets all specified members to the associated values.


## Alias access

In the original implementation, access was done by using dot notation similar to how *C* structures are accessed. However, there was a concensus to make the interface more Tcl like, which made sense. However, the original alias access still exists. It might prove to be helpful to some.

Basically, for every member of every instance, an alias is created. This alias is used to get and set values for that member. An example will illustrate the point, using the above defined records:

```
% # Create an instance first
% myrecord inst1
::inst1

% # To get a member of an instance, just use the alias. It behaves
% # like a Tcl command:
% inst1.mem1

% # To set a member via the alias, just include a value. And optionally
% # the equal sign - syntactic sugar.
% inst1.mem1 = 5
5

% inst1.mem1
5

% # For nested records, just continue with the dot notation.
% # note, no equal sign.
% inst1.mem3.nest1 10
10

% inst1.mem3.nest1
10

% # just the instance by itself gives all member/values pairs for that
% # instance
% inst1
-mem1 5 -mem2 {} -mem3 {-nest1 10 -nest2 {}}

% # and to get all members within the nested record
% inst1.mem3
-nest1 10 -nest2 {}
```

# Record command

The following subcommands and corresponding arguments are available to any record command:

*recordName* *instanceName*|**#auto** ?*-member1 value1 -member2 value2 ...*?
: Using the *recordName* object command that was created from the record definition, instances of the record definition can be created. Once an instance is created, it inherits the members of the record definition, very similar to how objects work. During instance generation, an object command for the instance is created as well, using *instanceName*.

    This object command is used to access the data members of the instance. During the instantiation, while values for that instance may be given, when done, *all* values must be given, and be given as key/value pairs, like for method **configure**. Nested records have to be in list format.

    Optionally, **#auto** can be used in place of *instanceName*. When **#auto** is used, the instance name will be automatically generated, and of the form **recordNameN**, where **N** is a unique integer (starting at 0) that is generated.


# Instance command

The following subcommands and corresponding arguments are available to any record instance command:

*instanceName* **cget** ?*-member1 -member2 ...*?
: Each instance has the method **cget**. This is very similar to how Tk widget's **cget** command works. It queries the values of the members for that particular instance. If no arguments are given, then a dictionary is returned.

*instanceName* **configure** ?*-member1 value1 -member2 value2 ...*?
: Each instance has the method **configure**. This is very similar to how Tk widget's **configure** command works. It sets the values of the particular members for that particular instance. If no arguments are given, then a dictionary list is returned.


# Examples

Two examples are provided to give a good illustration on how to use this package.

## Example 1 - contact information

Probably the most obvious example would be to hold contact information, such as addresses, phone numbers, comments, etc. Since a person can have multiple phone numbers, multiple email addresses, etc, we will use nested records to define these. So, the first thing we do is define the nested records:

```
##
##  This is an interactive example, to see what is returned by
##  each command as well.
##

% namespace import ::struct::record::*

% # define a nested record. Notice that country has default 'USA'.
% record define locations {
    street
    street2
    city
    state
    zipcode
    {country USA}
    phone
}
::locations
% # Define the main record. Notice that it uses the location record twice.
% record define contacts {
    first
    middle
    last
    {record locations home}
    {record locations work}
}
::contacts
% # Create an instance for the contacts record.
% contacts cont1
::cont1
% # Display some introspection values
% record show records
::contacts ::locations
% #
% record show values cont1
-first {} -middle {} -last {} -home {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}} -work {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}}
% #
% record show instances contacts
::cont1
% #
% cont1 config
-first {} -middle {} -last {} -home {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}} -work {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}}
% #
% cont1 cget
-first {} -middle {} -last {} -home {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}} -work {-street {} -street2 {} -city {} -state {} -zipcode {} -country USA -phone {}}
% # copy one record to another record
% record define contacts2 [record show members contacts]
::contacts2
% record show members contacts2
first middle last {record locations home} {record locations work}
% record show members contacts
first middle last {record locations home} {record locations work}
%
```

## Example 2 - linked list

This next example just illustrates a simple linked list

```
% # define a very simple record for linked list
% record define linkedlist {
    value
    next
}
::linkedlist
% linkedlist lstart
::lstart
% lstart config -value 1 -next [linkedlist #auto]
% [lstart cget -next] config -value 2 -next [linkedlist #auto]
% [[lstart cget -next] cget -next] config -value 3 -next "end"
% set next lstart
lstart
% while 1 {
    lappend values [$next cget -value]
    set next [$next cget -next]
    if {[string match "end" $next]} break
}
% puts "$values"
1 2 3
% # cleanup linked list
% # We could just use delete record linkedlist also
% foreach I [record show instances linkedlist] {
    record delete instance $I
}
% record show instances linkedlist
%
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *struct :: record* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Data structures

# Copyright

```
Copyright (c) 2002, Brett Schwarz <brett_schwarz@yahoo.com>
```
