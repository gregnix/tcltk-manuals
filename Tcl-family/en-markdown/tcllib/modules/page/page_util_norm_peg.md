---
CommandName: page_util_norm_peg
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - PEG
 - graph walking
 - normalization
 - page
 - parser generator
 - text processing
 - tree walking
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page_util_norm_peg - page AST normalization, PEG

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [page::util::norm_peg]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[::page::util::norm::peg]{.cmd} [tree]{.arg} 
:::

# Description

This package provides a single utility command which takes an AST for a parsing expression grammar and normalizes it in various ways. The result is called a *Normalized PE Grammar Tree*.

*Note* that this package can only be used from within a plugin managed by the package **page::pluginmgr**.

# Api

**::page::util::norm::peg** *tree*
: This command assumes the *tree* object contains for a parsing expression grammar. It normalizes this tree in place. The result is called a  *Normalized PE Grammar Tree*. The following operations are performd


**\[1\]**
: The data for all terminals is stored in their grandparental nodes. The terminal nodes and their parents are removed. Type information is dropped.

**\[2\]**
: All nodes which have exactly one child are irrelevant and are removed, with the exception of the root node. The immediate child of the root is irrelevant as well, and removed as well.

**\[3\]**
: The name of the grammar is moved from the tree node it is stored in to an attribute of the root node, and the tree node removed. The node keeping the start expression separate is removed as irrelevant and the root node of the start expression tagged with a marker attribute, and its handle saved in an attribute of the root node for quick access.

**\[4\]**
: Nonterminal hint information is moved from nodes into attributes, and the now irrelevant nodes are deleted. *Note:* This transformation is dependent on the removal of all nodes with exactly one child, as it removes the all 'Attribute' nodes already. Otherwise this transformation would have to put the information into the grandparental node. The default mode given to the nonterminals is **value**. Like with the global metadata definition specific information is moved out out of nodes into attributes, the now irrelevant nodes are deleted, and the root nodes of all definitions are tagged with marker attributes. This provides us with a mapping from nonterminal names to their defining nodes as well, which is saved in an attribute of the root node for quick reference. At last the range in the input covered by a definition is computed. The left extent comes from the terminal for the nonterminal symbol it defines. The right extent comes from the rightmost child under the definition. While this not an expression tree yet the location data is sound already.

**\[5\]**
: The remaining nodes under all definitions are transformed into proper expression trees. First character ranges, followed by unary operations, characters, and nonterminals. At last the tree is flattened by the removal of superfluous inner nodes. The order matters, to shed as much nodes as possible early, and to avoid unnecessary work later.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *page* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Page Parser Generator

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
