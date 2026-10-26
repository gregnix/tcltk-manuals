---
CommandName: struct::disjointset
title: struct::disjointset
ManualSection: n
Version: 1.2
TclPart: tcllib
TclDescription: Tcl Data Structures
Links:
 - http://en.wikipedia.org/wiki/Disjoint_set_data_structure
Keywords:
 - disjoint set
 - equivalence class
 - find
 - merge find
 - partition
 - partitioned set
 - union
Copyright:
---

# Name

struct::disjointset - Disjoint set data structure

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::disjointset]{.lit} [1.2]{.optlit}
[::struct::disjointset]{.cmd} [aDisjointSet]{.arg}
[aDisjointSet]{.ins} [add-element]{.sub} [element]{.arg}
[aDisjointSet]{.ins} [add-partition]{.sub} [elements]{.arg}
[aDisjointSet]{.ins} [partitions]{.sub}
[aDisjointSet]{.ins} [num-partitions]{.sub}
[aDisjointSet]{.ins} [equal]{.sub} [a]{.arg} [b]{.arg}
[aDisjointSet]{.ins} [merge]{.sub} [a]{.arg} [b]{.arg}
[aDisjointSet]{.ins} [find]{.sub} [element]{.arg}
[aDisjointSet]{.ins} [exemplars]{.sub}
[aDisjointSet]{.ins} [find-exemplar]{.sub} [element]{.arg}
[aDisjointSet]{.ins} [destroy]{.sub}
:::

# Description

This package provides a command for handling [disjoint sets](http://en.wikipedia.org/wiki/Disjoint_set_data_structure). Alternative names for this kind of data structure are *union-find* and *merge-find*.

A common use case for ordinary sets is to be able to answer the question, “does set S contain element E?”. The answer is a simple Boolean.

One common use case for disjoint sets is to be able to answer the question, “which of sets S₁, S₂, …, Sₙ contains element E?”. The answer is a set—or nothing, if none of the sets contains E.

Another common use case for disjoint sets is to be able to quickly merge two sets into one, with the resultant set still fast for finding elements. Hence the term *merge-find*.

The reason this data structure is called a *disjoint set* is because it can be perceived as being a *single* set with *partitions*. In other words a disjoint set is:

- a finite *set* S, containing

- a number of *elements* E₁, E₂, …, Eₙ, grouped into

- a set of *partitions* P₁, P₂, …, Pₙ. The latter term applies because the intersection of each pair Pᵢ, Pⱼ of partitions is empty, i.e.,  ∅ = Pᵢ ∩ Pⱼ, with the set itself equal to the union of all the partitions, i.e., S = P₁ ∪ P₂ ∪ … ∪ Pₙ.


An alternative name for the *partitions* would be *equivalence classes*, where all elements in the same class are considered equal. Here is a pictorial representation of the concepts listed above:

```
	+-----------------+ The outer lines are the boundaries of the set S.
	|           /     | The inner regions delineated by the diagonal
	|  *       /   *  | lines are the partitions P₁, P₂, …, Pₙ.
	|      *  / \     | The *’s denote the elements E₁, E₂, …, Eₙ in
	|*       /   \    | the set, each in a single partition, their
	|       /  *  \   | equivalence class.
	|      / *   /    |
	| *   /\  * /     |
	|    /  \  /      |
	|   /    \/  *    |
	|  / *    \       |
	| /     *  \      |
	+-----------------+
```

# API

The package provides a single command, **::struct::disjointset**, which provides all its functionality using methods.

**::struct::disjointset** *aDisjointSet*
: Creates a new disjoint set object with an associated global Tcl command whose name is *aDisjointSet*. This command may be used to invoke disjoint set methods which all have the the following general form:

    *aDisjointSet* *method* ?*arg ...*?

    The *method* and the *arg*s specify what operation to perform.


## Methods

*aDisjointSet* **add-element** *element*
: Creates a new partition in the *aDisjointSet*, and adds the single *element* to the new partition. The command maintains the integrity of the disjoint set, i.e., if *element* is already in the disjoint set—no matter in which partition—this method will throw an error.

    This method returns the empty string.

    This method runs in constant time, *O(1)*.

*aDisjointSet* **add-partition** *elements*
: Creates a new partition in the *aDisjointSet*, and adds all the given *elements* to the new partition. The command maintains the integrity of the disjoint set, i.e., if any of the elements in *elements* is already in the disjoint set—no matter in which partition—this method will throw an error.

    This method returns the empty string.

    This method runs in time proportional to the size of *elements*, *O(N)*, where *N* is the number of *elements*.

*aDisjointSet* **partitions**
: Returns the *aDisjointSet*’s set of partitions as a list of lists. The outer lists are the partitions, the inner lists contain each partition’s elements.

    This method runs in *O(N × α(N))* time, where *N* is the number of elements in the disjoint set, and the *α* function is the inverse Ackermann function.

*aDisjointSet* **num-partitions**
: Returns the number of partitions in the *aDisjointSet*.

    This method runs in constant time.

*aDisjointSet* **equal** *a* *b*
: Returns **1** (true) if elements *a* and *b* in the *aDisjointSet* are in the same partition; otherwise returns **0** (false).

    If one or both arguments are not in the disjoint set at all, this method will throw an error.

    This method runs in amortized time *O(α(N))*, where *N* is the number of elements in the larger partition, and the *α* function is the inverse Ackermann function.

*aDisjointSet* **merge** *a* *b*
: Determines the partitions in the *aDisjointSet* that elements *a* and *b* are contained in, and merges these partitions into a single partition. If the two elements were already contained in the same partition the disjoint set is left unchanged.

    If one or both arguments are not in the disjoint set at all, this method will throw an error.

    This method returns the empty string.

    This method runs in amortized time *O(α(N))*, where *N* is the number of elements in the larger of the partitions being merged, and the *α* function is the inverse Ackermann function. The worst case time is *O(N)*.

*aDisjointSet* **find** *element*
: Returns a list of the members of the partition of the *aDisjointSet* which contains the given *element*; or an empty string if *element* is not in the disjoint set.

    This method runs in *O(N × α(N))* time, where *N* is the total number of elements in the disjoint set, and the *α* function is the inverse Ackermann function. See **find-exemplar** for a faster method, if all that is needed is a unique partition identifier, rather than a list of its elements.

*aDisjointSet* **exemplars**
: Returns a list containing an exemplar—an arbitrarily chosen member—of each partition in the *aDisjointSet*.

    Note that the only operation that will change the exemplar chosen for any particular partition is **merge**.

    This method runs in *O(N × α(N))* time, where *N* is the total number of elements in the disjoint set, and the *α* function is the inverse Ackermann function.

*aDisjointSet* **find-exemplar** *element*
: Returns an exemplar—an arbitrarily chosen member—of the partition of the *aDisjointSet* that contains the given *element*.

    If *element* is not in the disjoint set at all, this method will throw an error.

    Note that the only operation that will change the exemplar chosen for any particular partition is **merge**.

    This method runs in *O(α(N))* time, where *N* is the number of elements in the partition containing *element*, and the *α* function is the inverse Ackermann function.

*aDisjointSet* **destroy**
: Destroys the *aDisjointSet* object, including the global command *aDisjointSet*, and all its associated memory.


# Examples

The examples make use of the following **proc** to show their results:

```
proc dump_disjointset name {
    puts "$name:"
    foreach partition [$name partitions] {
        puts -nonewline "  partition "
        set sep "{"
        foreach element $partition {
            puts -nonewline $sep$element
            set sep " "
        }
        puts "}"
    }
}
```

This example creates a new disjoint set called *colors* and adds one partition with the single element *black* and another partition with the elements *cyan*, *magenta*, *yellow*.

```
struct::disjointset colors
colors add-element black
puts "colors num-partitions=[colors num-partitions]"
colors add-partition {cyan magenta yellow}
puts "colors num-partitions=[colors num-partitions]"
dump_disjointset colors
=>
colors num-partitions=1
colors num-partitions=2
colors:
  partition {black}
  partition {cyan magenta yellow}
```

This example explores some of the disjoint set API on the *colors* disjoint set created above.

```
puts "colors equal black yellow=[colors equal black yellow]"
puts "colors equal cyan yellow=[colors equal cyan yellow]"
puts "colors equal cyan magenta=[colors equal cyan magenta]"
colors merge black cyan
puts "colors equal black yellow=[colors equal black yellow]"
dump_disjointset colors
=>
colors equal black yellow=0
colors equal cyan yellow=1
colors equal cyan magenta=1
colors merge black cyan
colors equal black yellow=1
colors:
  partition {black cyan magenta yellow}
```

This example continues to explore some of the disjoint set API on the *colors* disjoint set created above.

```
colors add-partition {red green blue}
dump_disjointset colors
puts "[colors find-exemplar blue] [colors find-exemplar yellow]"
colors destroy
=>
colors:
  partition {black cyan magenta yellow}
  partition {red green blue}
red cyan
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *struct :: disjointset* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Data structures
