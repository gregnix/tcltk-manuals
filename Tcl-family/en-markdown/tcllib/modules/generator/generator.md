---
CommandName: generator
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Tcl Generator Commands
Keywords:
 - control structure
 - coroutine
 - filter
 - foldl
 - foldr
 - foreach
 - generator
 - iterator
 - map
 - reduce
 - scanl
Copyright:
---

# Name

generator - Procedures for creating and using generators.

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [generator]{.lit} [0.3]{.optlit} 
[generator]{.cmd} [define]{.sub} [name]{.arg} [params]{.arg} [body]{.arg} 
[generator]{.cmd} [yield]{.sub} [arg]{.arg} [args..]{.optarg} 
[generator]{.cmd} [foreach]{.sub} [varList]{.arg} [generator]{.arg} [varList]{.arg} [generator]{.arg} [...]{.optdot} [body]{.arg} 
[generator]{.cmd} [next]{.sub} [generator]{.arg} [varName..]{.optarg} 
[generator]{.cmd} [exists]{.sub} [generator]{.arg} 
[generator]{.cmd} [names]{.sub} 
[generator]{.cmd} [destroy]{.sub} [generator..]{.optarg} 
[generator]{.cmd} [finally]{.sub} [cmd]{.arg} [arg..]{.optarg} 
[generator]{.cmd} [from]{.sub} [format]{.arg} [value]{.arg} 
[generator]{.cmd} [to]{.sub} [format]{.arg} [generator]{.arg} 
[generator]{.cmd} [map]{.sub} [function]{.arg} [generator]{.arg} 
[generator]{.cmd} [filter]{.sub} [predicate]{.arg} [generator]{.arg} 
[generator]{.cmd} [reduce]{.sub} [function]{.arg} [zero]{.arg} [generator]{.arg} 
[generator]{.cmd} [foldl]{.sub} [function]{.arg} [zero]{.arg} [generator]{.arg} 
[generator]{.cmd} [foldr]{.sub} [function]{.arg} [zero]{.arg} [generator]{.arg} 
[generator]{.cmd} [all]{.sub} [predicate]{.arg} [generator]{.arg} 
[generator]{.cmd} [and]{.sub} [generator]{.arg} 
[generator]{.cmd} [any]{.sub} [generator]{.arg} 
[generator]{.cmd} [concat]{.sub} [generator]{.arg} [generator..]{.optarg} 
[generator]{.cmd} [concatMap]{.sub} [function]{.arg} [generator]{.arg} 
[generator]{.cmd} [drop]{.sub} [n]{.arg} [generator]{.arg} 
[generator]{.cmd} [dropWhile]{.sub} [predicate]{.arg} [generator]{.arg} 
[generator]{.cmd} [contains]{.sub} [element]{.arg} [generator]{.arg} 
[generator]{.cmd} [foldl1]{.sub} [function]{.arg} [generator]{.arg} 
[generator]{.cmd} [foldli]{.sub} [function]{.arg} [zero]{.arg} [generator]{.arg} 
[generator]{.cmd} [foldri]{.sub} [function]{.arg} [zero]{.arg} [generator]{.arg} 
[generator]{.cmd} [head]{.sub} [generator]{.arg} 
[generator]{.cmd} [tail]{.sub} [generator]{.arg} 
[generator]{.cmd} [init]{.sub} [generator]{.arg} 
[generator]{.cmd} [takeList]{.sub} [n]{.arg} [generator]{.arg} 
[generator]{.cmd} [take]{.sub} [n]{.arg} [generator]{.arg} 
[generator]{.cmd} [iterate]{.sub} [function]{.arg} [init]{.arg} 
[generator]{.cmd} [last]{.sub} [generator]{.arg} 
[generator]{.cmd} [length]{.sub} [generator]{.arg} 
[generator]{.cmd} [or]{.sub} [predicate]{.arg} [generator]{.arg} 
[generator]{.cmd} [product]{.sub} [generator]{.arg} 
[generator]{.cmd} [repeat]{.sub} [n]{.arg} [value..]{.arg} 
[generator]{.cmd} [sum]{.sub} [generator]{.arg} 
[generator]{.cmd} [takeWhile]{.sub} [predicate]{.arg} [generator]{.arg} 
[generator]{.cmd} [splitWhen]{.sub} [predicate]{.arg} [generator]{.arg} 
[generator]{.cmd} [scanl]{.sub} [function]{.arg} [zero]{.arg} [generator]{.arg} 
:::

# Description

The **generator** package provides commands to define and iterate over generator expressions. A *generator* is a command that returns a sequence of values. However, unlike an ordinary command that returns a list, a generator *yields* each value and then suspends, allowing subsequent values to be fetched on-demand. As such, generators can be used to efficiently iterate over a set of values, without having to generate all answers in-memory. Generators can be used to iterate over elements of a data structure, or rows in the result set of a database query, or to decouple producer/consumer software designs such as parsers and tokenizers, or to implement sophisticated custom control strategies such as backtracking search. Generators reduce the need to implement custom control structures, as many such structures can be recast as generators, leading to both a simpler implementation and a more standardised interface. The generator mechanism is built on top of the Tcl 8.6 coroutine mechanism.

The package exports a single ensemble command, **generator**. All functionality is provided as subcommands of this command. The core subcommands of the package are **define**, **yield**, and **foreach**. The **define** command works like Tcl's **proc** command, but creates a generator procedure; that is, a procedure that returns a generator when called. The generator itself is a command that can be called multiple times: each time it returns the next value in the generated series. When the series has been exhausted, the generator command returns an empty list and then destroys itself. Rather than manually call a generator, however, the package also provides a flexible **foreach** command that loops through the values of one or more generators. This loop construct mimicks the functionality of the built-in Tcl **foreach** command, including handling multiple return values and looping over multiple generators at once. Writing a generator is also a simple task, much like writing a normal procedure: simply use the **define** command to define the generator, and then call **yield** instead of **return**. For example, we can define a generator for looping through the integers in a particular range:

```
    generator define range {n m} {
        for {set i $n} {$i <= $m} {incr i} { generator yield $i }
    }
    generator foreach x [range 1 10] {
        puts "x = $x"
    }
```

The above example will print the numbers from 1 to 10 in sequence, as you would expect. The difference from a normal loop over a list is that the numbers are only generated as they are needed. If we insert a break into the loop then any remaining numbers in the sequence would never be generated. To illustrate, we can define a generator that produces the sequence of natural numbers: an infinite series. A normal procedure would never return trying to produce this series as a list. By using a generator we only have to generate those values which are actually used:

```
    generator define nats {} {
        while 1 { generator yield [incr nat] }
    }
    generator foreach n [nats] {
        if {$n > 100} { break }
    }
```

# Commands

**generator** **define** *name* *params* *body*
: Creates a new generator procedure. The arguments to the command are identical to those for **proc**: a *name*, a list of parameters, and a body. The parameter list format is identical to a procedure. In particular, default values and the ?args? syntax can be used as usual. Each time the resulting generator procedure is called it creates a new generator command (coroutine) that will yield a list of values on each call. Each result from a generator is guaranteed to be a non-empty list of values. When a generator is exhausted it returns an empty list and then destroys itself to free up resources. It is an error to attempt to call an exhausted generator as the command no longer exists.

**generator** **yield** *arg* ?*args..*?
: Used in the definition of a generator, this command returns the next set of values to the consumer. Once the **yield** command has been called the generator will suspend to allow the consumer to process that value. When the next value is requested, the generator will resume as if the yield command had just returned, and can continue processing to yield the next result. The **yield** command must be called with at least one argument, but can be called with multiple arguments, in which case this is equivalent to calling **yield** once for each argument.

**generator** **foreach** *varList* *generator* *varList* *generator* ?...? *body*
: Loops through one or more generators, assigning the next values to variables and then executing the loop body. Works much like the built-in **foreach** command, but working with generators rather than lists. Multiple generators can be iterated over in parallel, and multiple results can be retrieved from a single generator at once.  Like the built-in **foreach**, the loop will continue until all of the generators have been exhausted: variables for generators that are exhausted early will be set to the empty string. The **foreach** command will automatically clean-up all of the generators at the end of the loop, regardless of whether the loop terminated early or not. This behaviour is provided as a convenience to avoid having to explicitly clean up a generator in the usual cases. Generators can however be destroyed before the end of the loop, in which case the loop will continue as normal until all the other generators have been destroyed or exhausted. The **foreach** command does not take a snapshot of the generator. Any changes in the state of the generator made inside the loop or by other code will affect the state of the loop. In particular, if the code in the loop invokes the generator to manually retrieve the next element, this element will then be excluded from the loop, and the next iteration will continue from the element after that one. Care should be taken to avoid concurrent updates to generators unless this behaviour is required (e.g., in argument processing).

**generator** **next** *generator* ?*varName..*?
: Manually retrieves the next values from a generator. One value is retrieved for each variable supplied and assigned to the corresponding variable. If the generator becomes exhausted at any time then any remaining variables are set to the empty string.

**generator** **exists** *generator*
: Returns 1 if the generator (still) exists, or 0 otherwise.

**generator** **names**
: Returns a list of all currently existing generator commands.

**generator** **destroy** ?*generator..*?
: Destroys one or more generators, freeing any associated resources.

**generator** **finally** *cmd* ?*arg..*?
: Used in the definition of a generator procedure, this command arranges for a resource to be cleaned up whenever the generator is destroyed, either explicitly or implicitly when the generator is exhausted. This command can be used like a **finally** block in the **try** command, except that it is tied to the life-cycle of the generator rather than to a particular scope. For example, if we create a generator to iterate over the lines in a text file, we can use **finally** to ensure that the file is closed whenever the generator is destroyed:


```
    generator define lines file {
        set in [open $file]
        # Ensure file is always closed
        generator finally close $in
        while {[gets $in line] >= 0} {
            generator yield $line
        }
    }
    generator foreach line [lines /etc/passwd] {
        puts "[incr count]: $line"
        if {$count > 10} { break }
    }
    # File will be closed even on early exit
```

If you create a generator that consumes another generator (such as the standard **map** and **filter** generators defined later), then you should use a **finally** command to ensure that this generator is destroyed when its parent is. For example, the **map** generator is defined as follows:

```
    generator define map {f xs} {
        generator finally generator destroy $xs
        generator foreach x $xs { generator yield [{*}$f $x] }
    }
```

**generator** **from** *format* *value*
: Creates a generator from a data structure. Currently, supported formats are **list**, **dict**, or **string**. The list format yields each element in turn. For dictionaries, each key and value are yielded separately. Finally, strings are yielded a character at a time.

**generator** **to** *format* *generator*
: Converts a generator into a data structure. This is the reverse operation of the **from** command, and supports the same data structures. The two operations obey the following identity laws (where **=** is interpreted appropriately):


```
    [generator to $fmt [generator from $fmt $value]] = $value
    [generator from $fmt [generator to $fmt $gen]]   = $gen
```

# Prelude

The following commands are provided as a standard library of generator combinators and functions that perform convenience operations on generators. The functions in this section are loosely modelled on the equivalent functions from the Haskell Prelude. *Warning:* most of the functions in this prelude destroy any generator arguments they are passed as a side-effect. If you want to have persistent generators, see the streams library.

**generator** **map** *function* *generator*
: Apply a function to every element of a generator, returning a new generator of the results. This is the classic map function from functional programming, applied to generators. For example, we can generate all the square numbers using the following code (where **nats** is defined as earlier):


```
    proc square x { expr {$x * $x} }
    generator foreach n [generator map square [nats]] {
        puts "n = $n"
        if {$n > 1000} { break }
    }
```

**generator** **filter** *predicate* *generator*
: Another classic functional programming gem. This command returns a generator that yields only those items from the argument generator that satisfy the predicate (boolean function). For example, if we had a generator **employees** that returned a stream of dictionaries representing people, we could filter all those whose salaries are above 100,000 dollars (or whichever currency you prefer) using a simple filter:


```
    proc salary> {amount person} { expr {[dict get $person salary] > $amount} }
    set fat-cats [generator filter {salary> 100000} $employees]
```

**generator** **reduce** *function* *zero* *generator*
: This is the classic left-fold operation. This command takes a function, an initial value, and a generator of values. For each element in the generator it applies the function to the current accumulator value (the *zero* argument initially) and that element, and then uses the result as the new accumulator value. This process is repeated through the entire generator (eagerly) and the final accumulator value is then returned. If we consider the function to be a binary operator, and the zero argument to be the left identity element of that operation, then we can consider the **reduce** command as *folding* the operator between each successive pair of values in the generator in a left-associative fashion. For example, the sum of a sequence of numbers can be calculated by folding a **+** operator between them, with 0 as the identity:


```
    # sum xs          = reduce + 0 xs
    # sum [range 1 5] = reduce + 0 [range 1 5]
    #                 = reduce + [+ 0 1] [range 2 5]
    #                 = reduce + [+ 1 2] [range 3 5]
    #                 = ...
    #                 = reduce + [+ 10 5] <empty>
    #                 = ((((0+1)+2)+3)+4)+5
    #                 = 15
    proc + {a b} { expr {$a + $b} }
    proc sum gen { generator reduce + 0 $gen }
    puts [sum [range 1 10]]
```

The **reduce** operation is an extremely useful one, and a great variety of different operations can be defined using it. For example, we can define a factorial function as the product of a range using generators. This definition is both very clear and also quite efficient (in both memory and running time):

```
    proc * {x y} { expr {$x * $y} }
    proc prod gen { generator reduce * 0 $gen }
    proc fac n { prod [range 1 $n] }
```

However, while the **reduce** operation is efficient for finite generators, care should be taken not to apply it to an infinite generator, as this will result in an infinite loop:

```
    sum [nats]; # Never returns
```

**generator** **foldl** *function* *zero* *generator*
: This is an alias for the **reduce** command.

**generator** **foldr** *function* *zero* *generator*
: This is the right-associative version of **reduce**. This operation is generally inefficient, as the entire generator needs to be evaluated into memory (as a list) before the reduction can commence. In an eagerly evaluated language like Tcl, this operation has limited use, and should be avoided if possible.

**generator** **all** *predicate* *generator*
: Returns true if all elements of the generator satisfy the given predicate.

**generator** **and** *generator*
: Returns true if all elements of the generator are true (i.e., takes the logical conjunction of the elements).

**generator** **any** *generator*
: Returns true if any of the elements of the generator are true (i.e., logical disjunction).

**generator** **concat** *generator* ?*generator..*?
: Returns a generator which is the concatenation of each of the argument generators.

**generator** **concatMap** *function* *generator*
: Given a function which maps a value to a series of values, and a generator of values of that type, returns a generator of all of the results in one flat series. Equivalent to **concat** applied to the result of **map**.

**generator** **drop** *n* *generator*
: Removes the given number of elements from the front of the generator and returns the resulting generator with those elements removed.

**generator** **dropWhile** *predicate* *generator*
: Removes all elements from the front of the generator that satisfy the predicate.

**generator** **contains** *element* *generator*
: Returns true if the generator contains the given element. Note that this will destroy the generator!

**generator** **foldl1** *function* *generator*
: A version of **foldl** that takes the *zero* argument from the first element of the generator. Therefore this function is only valid on non-empty generators.

**generator** **foldli** *function* *zero* *generator*
: A version of **foldl** that supplies the integer index of each element as the first argument to the function. The first element in the generator at this point is given index 0.

**generator** **foldri** *function* *zero* *generator*
: Right-associative version of **foldli**.

**generator** **head** *generator*
: Returns the first element of the generator.

**generator** **tail** *generator*
: Removes the first element of the generator, returning the rest.

**generator** **init** *generator*
: Returns a new generator consisting of all elements except the last of the argument generator.

**generator** **takeList** *n* *generator*
: Returns the next *n* elements of the generator as a list. If not enough elements are left in the generator, then just the remaining elements are returned.

**generator** **take** *n* *generator*
: Returns the next *n* elements of the generator as a new generator. The old generator is destroyed.

**generator** **iterate** *function* *init*
: Returns an infinite generator formed by repeatedly applying the function to the initial argument. For example, the Fibonacci numbers can be defined as follows:


```
    proc fst pair { lindex $pair 0 }
    proc snd pair { lindex $pair 1 }
    proc nextFib ab { list [snd $ab] [expr {[fst $ab] + [snd $ab]}] }
    proc fibs {} { generator map fst [generator iterate nextFib {0 1}] }
```

**generator** **last** *generator*
: Returns the last element of the generator (if it exists).

**generator** **length** *generator*
: Returns the length of the generator, destroying it in the process.

**generator** **or** *predicate* *generator*
: Returns 1 if any of the elements of the generator satisfy the predicate.

**generator** **product** *generator*
: Returns the product of the numbers in a generator.

**generator** **repeat** *n* *value..*
: Returns a generator that consists of *n* copies of the given elements. The special value *Inf* can be used to generate an infinite sequence.

**generator** **sum** *generator*
: Returns the sum of the values in the generator.

**generator** **takeWhile** *predicate* *generator*
: Returns a generator of the first elements in the argument generator that satisfy the predicate.

**generator** **splitWhen** *predicate* *generator*
: Splits the generator into lists of elements using the predicate to identify delimiters. The resulting lists are returned as a generator. Elements matching the delimiter predicate are discarded. For example, to split up a generator using the string "|" as a delimiter:


```
    set xs [generator from list {a | b | c}]
    generator split {string equal "|"} $xs ;# returns a then b then c
```

**generator** **scanl** *function* *zero* *generator*
: Similar to **foldl**, but returns a generator of all of the intermediate values for the accumulator argument. The final element of this generator is equivalent to **foldl** called on the same arguments.


# Bugs, ideas, feedback

Please report any errors in this document, or in the package it describes, to [Neil Madden](mailto:nem@cs.nott.ac.uk).
