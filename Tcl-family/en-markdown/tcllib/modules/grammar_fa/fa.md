---
CommandName: grammar::fa
title: grammar::fa
ManualSection: n
Version: 0.6
TclPart: tcllib
TclDescription: Finite automaton operations and usage
Keywords:
 - automaton
 - finite automaton
 - grammar
 - parsing
 - regular expression
 - regular grammar
 - regular languages
 - state
 - transducer
Copyright:
 - Copyright (c) 2004-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

grammar::fa - Create and manipulate finite automatons

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.3]{.lit}
[package]{.cmd} [require]{.sub} [struct::list]{.lit}
[package]{.cmd} [require]{.sub} [struct::set]{.lit}
[package]{.cmd} [require]{.sub} [grammar::fa::op]{.lit} [0.3]{.optlit}
[package]{.cmd} [require]{.sub} [grammar::fa]{.lit} [0.6]{.optlit}
[::grammar::fa]{.cmd} [faName]{.arg} [[=|:=|<--|as|deserialize]{.lit} [src|fromRegex]{.arg} [re]{.arg} [over]{.optarg}]{.optarg}
[faName]{.cmd} [option]{.arg} [arg arg]{.optdot}
[faName]{.ins} [destroy]{.sub}
[faName]{.ins} [clear]{.sub}
[faName]{.ins} [=]{.sub} [srcFA]{.arg}
[faName]{.ins} [-->]{.sub} [dstFA]{.arg}
[faName]{.ins} [serialize]{.sub}
[faName]{.ins} [deserialize]{.sub} [serialization]{.arg}
[faName]{.ins} [states]{.sub}
[faName]{.ins} [state]{.sub} [add]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [state]{.sub} [delete]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [state]{.sub} [exists]{.lit} [s]{.arg}
[faName]{.ins} [state]{.sub} [rename]{.lit} [s]{.arg} [snew]{.arg}
[faName]{.ins} [startstates]{.sub}
[faName]{.ins} [start]{.sub} [add]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [start]{.sub} [remove]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [start?]{.sub} [s]{.arg}
[faName]{.ins} [start?set]{.sub} [stateset]{.arg}
[faName]{.ins} [finalstates]{.sub}
[faName]{.ins} [final]{.sub} [add]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [final]{.sub} [remove]{.lit} [s1]{.arg} [s2]{.optdot}
[faName]{.ins} [final?]{.sub} [s]{.arg}
[faName]{.ins} [final?set]{.sub} [stateset]{.arg}
[faName]{.ins} [symbols]{.sub}
[faName]{.ins} [symbols@]{.sub} [s]{.arg} [d]{.optarg}
[faName]{.ins} [symbols@set]{.sub} [stateset]{.arg}
[faName]{.ins} [symbol]{.sub} [add]{.lit} [sym1]{.arg} [sym2]{.optdot}
[faName]{.ins} [symbol]{.sub} [delete]{.lit} [sym1]{.arg} [sym2]{.optdot}
[faName]{.ins} [symbol]{.sub} [rename]{.lit} [sym]{.arg} [newsym]{.arg}
[faName]{.ins} [symbol]{.sub} [exists]{.lit} [sym]{.arg}
[faName]{.ins} [next]{.sub} [s]{.arg} [sym]{.arg} [[-->]{.lit} [next]{.arg}]{.optarg}
[faName]{.ins} [!next]{.sub} [s]{.arg} [sym]{.arg} [[-->]{.lit} [next]{.arg}]{.optarg}
[faName]{.ins} [nextset]{.sub} [stateset]{.arg} [sym]{.arg}
[faName]{.ins} [is]{.sub} [deterministic]{.lit}
[faName]{.ins} [is]{.sub} [complete]{.lit}
[faName]{.ins} [is]{.sub} [useful]{.lit}
[faName]{.ins} [is]{.sub} [epsilon-free]{.lit}
[faName]{.ins} [reachable\_states]{.sub}
[faName]{.ins} [unreachable\_states]{.sub}
[faName]{.ins} [reachable]{.sub} [s]{.arg}
[faName]{.ins} [useful\_states]{.sub}
[faName]{.ins} [unuseful\_states]{.sub}
[faName]{.ins} [useful]{.sub} [s]{.arg}
[faName]{.ins} [epsilon\_closure]{.sub} [s]{.arg}
[faName]{.ins} [reverse]{.sub}
[faName]{.ins} [complete]{.sub}
[faName]{.ins} [remove\_eps]{.sub}
[faName]{.ins} [trim]{.sub} [what]{.optarg}
[faName]{.ins} [determinize]{.sub} [mapvar]{.optarg}
[faName]{.ins} [minimize]{.sub} [mapvar]{.optarg}
[faName]{.ins} [complement]{.sub}
[faName]{.ins} [kleene]{.sub}
[faName]{.ins} [optional]{.sub}
[faName]{.ins} [union]{.sub} [fa]{.arg} [mapvar]{.optarg}
[faName]{.ins} [intersect]{.sub} [fa]{.arg} [mapvar]{.optarg}
[faName]{.ins} [difference]{.sub} [fa]{.arg} [mapvar]{.optarg}
[faName]{.ins} [concatenate]{.sub} [fa]{.arg} [mapvar]{.optarg}
[faName]{.ins} [fromRegex]{.sub} [regex]{.arg} [over]{.optarg}
:::

# Description

This package provides a container class for *finite automatons* (Short: FA). It allows the incremental definition of the automaton, its manipulation and querying of the definition. While the package provides complex operations on the automaton (via package **grammar::fa::op**), it does not have the ability to execute a definition for a stream of symbols. Use the packages **grammar::fa::dacceptor** and **grammar::fa::dexec** for that. Another package related to this is **grammar::fa::compiler**. It turns a FA into an executor class which has the definition of the FA hardwired into it. The output of this package is configurable to suit a large number of different implementation languages and paradigms.

For more information about what a finite automaton is see section [Finite automatons].

# API

The package exports the API described here.

**::grammar::fa** *faName* ?**=**|**:=**|**<--**|**as**|**deserialize** *src*|**fromRegex** *re* ?*over*??
: Creates a new finite automaton with an associated global Tcl command whose name is *faName*. This command may be used to invoke various operations on the automaton. It has the following general form:

    **faName** *option* ?*arg arg ...*?
    : *Option* and the *arg*s determine the exact behavior of the command. See section [FA methods] for more explanations. The new automaton will be empty if no *src* is specified. Otherwise it will contain a copy of the definition contained in the *src*. The *src* has to be a FA object reference for all operators except **deserialize** and **fromRegex**. The **deserialize** operator requires *src* to be the serialization of a FA instead, and **fromRegex** takes a regular expression in the form a of a syntax tree. See [::grammar::fa::op::fromRegex][faop] for more detail on that.



# FA methods

All automatons provide the following methods for their manipulation:

*faName* **destroy**
: Destroys the automaton, including its storage space and associated command.

*faName* **clear**
: Clears out the definition of the automaton contained in *faName*, but does *not* destroy the object.

*faName* **=** *srcFA*
: Assigns the contents of the automaton contained in *srcFA* to *faName*, overwriting any existing definition. This is the assignment operator for automatons. It copies the automaton contained in the FA object *srcFA* over the automaton definition in *faName*. The old contents of *faName* are deleted by this operation.

    This operation is in effect equivalent to

    ```
        faName deserialize [srcFA serialize]
    ```

*faName* **-->** *dstFA*
: This is the reverse assignment operator for automatons. It copies the automation contained in the object *faName* over the automaton definition in the object *dstFA*. The old contents of *dstFA* are deleted by this operation.

    This operation is in effect equivalent to

    ```
        dstFA deserialize [faName serialize]
    ```

*faName* **serialize**
: This method serializes the automaton stored in *faName*. In other words it returns a tcl *value* completely describing that automaton. This allows, for example, the transfer of automatons over arbitrary channels, persistence, etc. This method is also the basis for both the copy constructor and the assignment operator.

    The result of this method has to be semantically identical over all implementations of the **grammar::fa** interface. This is what will enable us to copy automatons between different implementations of the same interface.

    The result is a list of three elements with the following structure:

    1. The constant string **grammar::fa**.

    2. A list containing the names of all known input symbols. The order of elements in this list is not relevant.

    3. The last item in the list is a dictionary, however the order of the keys is important as well. The keys are the states of the serialized FA, and their order is the order in which to create the states when deserializing. This is relevant to preserve the order relationship between states.

        The value of each dictionary entry is a list of three elements describing the state in more detail.

        1. A boolean flag. If its value is **true** then the state is a start state, otherwise it is not.

        2. A boolean flag. If its value is **true** then the state is a final state, otherwise it is not.

        3. The last element is a dictionary describing the transitions for the state. The keys are symbols (or the empty string), and the values are sets of successor states.



    Assuming the following FA (which describes the life of a truck driver in a very simple way :)

    ```
        Drive -- yellow --> Brake -- red --> (Stop) -- red/yellow --> Attention -- green --> Drive
        (...) is the start state.
    ```

    a possible serialization is

    ```
        grammar::fa \
        {yellow red green red/yellow} \
        {Drive     {0 0 {yellow     Brake}} \
         Brake     {0 0 {red        Stop}} \
         Stop      {1 0 {red/yellow Attention}} \
         Attention {0 0 {green      Drive}}}
    ```

    A possible one, because I did not care about creation order here

*faName* **deserialize** *serialization*
: This is the complement to **serialize**. It replaces the automaton definition in *faName* with the automaton described by the *serialization* value. The old contents of *faName* are deleted by this operation.

*faName* **states**
: Returns the set of all states known to *faName*.

*faName* **state** **add** *s1* ?*s2* ...?
: Adds the states *s1*, *s2*, et cetera to the FA definition in *faName*. The operation will fail any of the new states is already declared.

*faName* **state** **delete** *s1* ?*s2* ...?
: Deletes the state *s1*, *s2*, et cetera, and all associated information from the FA definition in *faName*. The latter means that the information about in- or outbound transitions is deleted as well. If the deleted state was a start or final state then this information is invalidated as well. The operation will fail if the state *s* is not known to the FA.

*faName* **state** **exists** *s*
: A predicate. It tests whether the state *s* is known to the FA in *faName*. The result is a boolean value. It will be set to **true** if the state *s* is known, and **false** otherwise.

*faName* **state** **rename** *s* *snew*
: Renames the state *s* to *snew*. Fails if *s* is not a known state. Also fails if *snew* is already known as a state.

*faName* **startstates**
: Returns the set of states which are marked as *start* states, also known as *initial* states. See [Finite automatons] for explanations what this means.

*faName* **start** **add** *s1* ?*s2* ...?
: Mark the states *s1*, *s2*, et cetera in the FA *faName* as *start* (aka *initial*).

*faName* **start** **remove** *s1* ?*s2* ...?
: Mark the states *s1*, *s2*, et cetera in the FA *faName* as *not start* (aka *not accepting*).

*faName* **start?** *s*
: A predicate. It tests if the state *s* in the FA *faName* is *start* or not. The result is a boolean value. It will be set to **true** if the state *s* is *start*, and **false** otherwise.

*faName* **start?set** *stateset*
: A predicate. It tests if the set of states *stateset* contains at least one start state. They operation will fail if the set contains an element which is not a known state. The result is a boolean value. It will be set to **true** if a start state is present in *stateset*, and **false** otherwise.

*faName* **finalstates**
: Returns the set of states which are marked as *final* states, also known as *accepting* states. See [Finite automatons] for explanations what this means.

*faName* **final** **add** *s1* ?*s2* ...?
: Mark the states *s1*, *s2*, et cetera in the FA *faName* as *final* (aka *accepting*).

*faName* **final** **remove** *s1* ?*s2* ...?
: Mark the states *s1*, *s2*, et cetera in the FA *faName* as *not final* (aka *not accepting*).

*faName* **final?** *s*
: A predicate. It tests if the state *s* in the FA *faName* is *final* or not. The result is a boolean value. It will be set to **true** if the state *s* is *final*, and **false** otherwise.

*faName* **final?set** *stateset*
: A predicate. It tests if the set of states *stateset* contains at least one final state. They operation will fail if the set contains an element which is not a known state. The result is a boolean value. It will be set to **true** if a final state is present in *stateset*, and **false** otherwise.

*faName* **symbols**
: Returns the set of all symbols known to the FA *faName*.

*faName* **symbols@** *s* ?*d*?
: Returns the set of all symbols for which the state *s* has transitions. If the empty symbol is present then *s* has epsilon transitions. If two states are specified the result is the set of symbols which have transitions from *s* to *t*. This set may be empty if there are no transitions between the two specified states.

*faName* **symbols@set** *stateset*
: Returns the set of all symbols for which at least one state in the set of states *stateset* has transitions. In other words, the union of \[*faName* **symbols@** **s**\] for all states **s** in *stateset*. If the empty symbol is present then at least one state contained in *stateset* has epsilon transitions.

*faName* **symbol** **add** *sym1* ?*sym2* ...?
: Adds the symbols *sym1*, *sym2*, et cetera to the FA definition in *faName*. The operation will fail any of the symbols is already declared. The empty string is not allowed as a value for the symbols.

*faName* **symbol** **delete** *sym1* ?*sym2* ...?
: Deletes the symbols *sym1*, *sym2* et cetera, and all associated information from the FA definition in *faName*. The latter means that all transitions using the symbols are deleted as well. The operation will fail if any of the symbols is not known to the FA.

*faName* **symbol** **rename** *sym* *newsym*
: Renames the symbol *sym* to *newsym*. Fails if *sym* is not a known symbol. Also fails if *newsym* is already known as a symbol.

*faName* **symbol** **exists** *sym*
: A predicate. It tests whether the symbol *sym* is known to the FA in *faName*. The result is a boolean value. It will be set to **true** if the symbol *sym* is known, and **false** otherwise.

*faName* **next** *s* *sym* ?**-->** *next*?
: Define or query transition information.

    If *next* is specified, then the method will add a transition from the state *s* to the *successor* state *next* labeled with the symbol *sym* to the FA contained in *faName*. The operation will fail if *s*, or *next* are not known states, or if *sym* is not a known symbol. An exception to the latter is that *sym* is allowed to be the empty string. In that case the new transition is an *epsilon transition* which will not consume input when traversed. The operation will also fail if the combination of (*s*, *sym*, and *next*) is already present in the FA.

    If *next* was not specified, then the method will return the set of states which can be reached from *s* through a single transition labeled with symbol *sym*.

*faName* **!next** *s* *sym* ?**-->** *next*?
: Remove one or more transitions from the Fa in *faName*.

    If *next* was specified then the single transition from the state *s* to the state *next* labeled with the symbol *sym* is removed from the FA. Otherwise *all* transitions originating in state *s* and labeled with the symbol *sym* will be removed.

    The operation will fail if *s* and/or *next* are not known as states. It will also fail if a non-empty *sym* is not known as symbol. The empty string is acceptable, and allows the removal of epsilon transitions.

*faName* **nextset** *stateset* *sym*
: Returns the set of states which can be reached by a single transition originating in a state in the set *stateset* and labeled with the symbol *sym*.

    In other words, this is the union of \[*faName* next **s** *symbol*\] for all states **s** in *stateset*.

*faName* **is** **deterministic**
: A predicate. It tests whether the FA in *faName* is a deterministic FA or not. The result is a boolean value. It will be set to **true** if the FA is deterministic, and **false** otherwise.

*faName* **is** **complete**
: A predicate. It tests whether the FA in *faName* is a complete FA or not. A FA is complete if it has at least one transition per state and symbol. This also means that a FA without symbols, or states is also complete. The result is a boolean value. It will be set to **true** if the FA is deterministic, and **false** otherwise.

    Note: When a FA has epsilon-transitions transitions over a symbol for a state S can be indirect, i.e. not attached directly to S, but to a state in the epsilon-closure of S. The symbols for such indirect transitions count when computing completeness.

*faName* **is** **useful**
: A predicate. It tests whether the FA in *faName* is an useful FA or not. A FA is useful if all states are *reachable* and *useful*. The result is a boolean value. It will be set to **true** if the FA is deterministic, and **false** otherwise.

*faName* **is** **epsilon-free**
: A predicate. It tests whether the FA in *faName* is an epsilon-free FA or not. A FA is epsilon-free if it has no epsilon transitions. This definition means that all deterministic FAs are epsilon-free as well, and epsilon-freeness is a necessary pre-condition for deterministic'ness. The result is a boolean value. It will be set to **true** if the FA is deterministic, and **false** otherwise.

*faName* **reachable\_states**
: Returns the set of states which are reachable from a start state by one or more transitions.

*faName* **unreachable\_states**
: Returns the set of states which are not reachable from any start state by any number of transitions. This is

    ```
    	 [faName states] - [faName reachable_states]
    ```

*faName* **reachable** *s*
: A predicate. It tests whether the state *s* in the FA *faName* can be reached from a start state by one or more transitions. The result is a boolean value. It will be set to **true** if the state can be reached, and **false** otherwise.

*faName* **useful\_states**
: Returns the set of states which are able to reach a final state by one or more transitions.

*faName* **unuseful\_states**
: Returns the set of states which are not able to reach a final state by any number of transitions. This is

    ```
    	 [faName states] - [faName useful_states]
    ```

*faName* **useful** *s*
: A predicate. It tests whether the state *s* in the FA *faName* is able to reach a final state by one or more transitions. The result is a boolean value. It will be set to **true** if the state is useful, and **false** otherwise.

*faName* **epsilon\_closure** *s*
: Returns the set of states which are reachable from the state *s* in the FA *faName* by one or more epsilon transitions, i.e transitions over the empty symbol, transitions which do not consume input. This is called the *epsilon closure* of *s*.

*faName* **reverse**
: see below ...

*faName* **complete**
: see below ...

*faName* **remove\_eps**
: see below ...

*faName* **trim** ?*what*?
: see below ...

*faName* **determinize** ?*mapvar*?
: see below ...

*faName* **minimize** ?*mapvar*?
: see below ...

*faName* **complement**
: see below ...

*faName* **kleene**
: see below ...

*faName* **optional**
: see below ...

*faName* **union** *fa* ?*mapvar*?
: see below ...

*faName* **intersect** *fa* ?*mapvar*?
: see below ...

*faName* **difference** *fa* ?*mapvar*?
: see below ...

*faName* **concatenate** *fa* ?*mapvar*?
: see below ...

*faName* **fromRegex** *regex* ?*over*?
: These methods provide more complex operations on the FA.  Please see the same-named commands in the package **grammar::fa::op** for descriptions of what they do.


# Examples

# Finite automatons

For the mathematically inclined, a FA is a 5-tuple (S,Sy,St,Fi,T) where

- S is a set of *states*,

- Sy a set of *input symbols*,

- St is a subset of S, the set of *start* states, also known as *initial* states.

- Fi is a subset of S, the set of *final* states, also known as *accepting*.

- T is a function from S x (Sy + epsilon) to {S}, the *transition function*. Here **epsilon** denotes the empty input symbol and is distinct from all symbols in Sy; and {S} is the set of subsets of S. In other words, T maps a combination of State and Input (which can be empty) to a set of *successor states*.


In computer theory a FA is most often shown as a graph where the nodes represent the states, and the edges between the nodes encode the transition function: For all n in S' = T (s, sy) we have one edge between the nodes representing s and n resp., labeled with sy. The start and accepting states are encoded through distinct visual markers, i.e. they are attributes of the nodes.

FA's are used to process streams of symbols over Sy.

A specific FA is said to *accept* a finite stream sy\_1 sy\_2 ... sy\_n if there is a path in the graph of the FA beginning at a state in St and ending at a state in Fi whose edges have the labels sy\_1, sy\_2, etc. to sy\_n. The set of all strings accepted by the FA is the *language* of the FA. One important equivalence is that the set of languages which can be accepted by an FA is the set of *regular languages*.

Another important concept is that of deterministic FAs. A FA is said to be *deterministic* if for each string of input symbols there is exactly one path in the graph of the FA beginning at the start state and whose edges are labeled with the symbols in the string. While it might seem that non-deterministic FAs to have more power of recognition, this is not so. For each non-deterministic FA we can construct a deterministic FA which accepts the same language (--> Thompson's subset construction).

While one of the premier applications of FAs is in *parsing*, especially in the *lexer* stage (where symbols == characters), this is not the only possibility by far.

Quite a lot of processes can be modeled as a FA, albeit with a possibly large set of states. For these the notion of accepting states is often less or not relevant at all. What is needed instead is the ability to act to state changes in the FA, i.e. to generate some output in response to the input. This transforms a FA into a *finite transducer*, which has an additional set OSy of *output symbols* and also an additional *output function* O which maps from "S x (Sy + epsilon)" to "(Osy + epsilon)", i.e a combination of state and input, possibly empty to an output symbol, or nothing.

For the graph representation this means that edges are additional labeled with the output symbol to write when this edge is traversed while matching input. Note that for an application "writing an output symbol" can also be "executing some code".

Transducers are not handled by this package. They will get their own package in the future.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *grammar\_fa* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Grammars and finite automata

# Copyright

```
Copyright (c) 2004-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[faop]: faop.md
