---
CommandName: my
ManualSection: n
Version: 0.1
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - next(n)
 - oo::object(n)
 - self(n)
Keywords:
 - method
 - method visibility
 - object
 - private method
 - public method
Copyright:
 - Copyright (c) 2007 Donal K. Fellows
---

# Name

my - invoke any method of current object

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 

[my]{.cmd} [methodName]{.arg} [arg]{.optdot} 
:::

# Description

The **my** command is used to allow methods of objects to invoke any method of the object (or its class). In particular, the set of valid values for *methodName* is the set of all methods supported by an object and its superclasses, including those that are not exported. The object upon which the method is invoked is always the one that is the current context of the method (i.e. the object that is returned by **self object**) from which the **my** command is invoked.

Each object has its own **my** command, contained in its instance namespace.

# Examples

This example shows basic use of **my** to use the **variables** method of the **oo::object** class, which is not publicly visible by default:

```
oo::class create c {
    method count {} {
        my variable counter
        puts [incr counter]
    }
}
c create o
o count              → prints "1"
o count              → prints "2"
o count              → prints "3"
```
