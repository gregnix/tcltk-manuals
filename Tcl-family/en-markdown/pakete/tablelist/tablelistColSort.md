# Commands for Interactive Sorting by One or More Columns

## For Tablelist Version 7.12

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [The tablelist::sortByColumn Command](#the-tablelist-sortbycolumn-command)
- [The tablelist::addToSortColumns Command](#the-tablelist-addtosortcolumns-command)

[Start page](index.md)

---

## Overview

The commands described in this reference page enable the user to sort the items of a tablelist widget based on one or more of its columns, with the aid of the left mouse button.

If the `tablelist::sortByColumn` command was specified as the value of the `-labelcommand` configuration option, then by pressing mouse button 1 over one of the header labels and later releasing it over the same label, the items will be sorted based on the elements of the corresponding column.

If the `tablelist::addToSortColumns` command was specified as the value of the `-labelcommand2` configuration option, then by pressing mouse button 1 together with the `Shift` key over one of the header labels and later releasing it over the same label, the corresponding column will be appended to the list of sort columns, or (if it was already contained in that list) the corresponding sort order will be toggled; in both cases, the items will be sorted based on the updated lists of sort columns and sort orders.

[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::sortByColumn` Command

**NAME**
: `tablelist::sortByColumn` – Sort the items of a tablelist widget based on one of its columns

**SYNOPSIS**
: 

```
tablelist::sortByColumn pathName columnIndex
```

**DESCRIPTION**
: This command sorts the items of the [tablelist](tablelistWidget.md) widget `pathName` based on the elements of the column specified by `columnIndex`.  This is done by invoking the `sortbycolumn` subcommand of the Tcl command associated with the given tablelist widget.  If the items were last sorted in increasing order, based on the same column given by `columnIndex`, and no subsequent invocation of the `resetsortinfo` subcommand was made, then the last argument passed to `sortbycolumn` will be `-decreasing`, otherwise `-increasing`.

: After sorting the items, the virtual event `<<TablelistColumnSorted>>` is generated.  For Tk versions 8.5 or higher, this virtual event is generated with its `-data` option set to a list consisting of the numerical column index and the sort order (`decreasing` or `increasing`).  The command returns the sort order, as `decreasing` or `increasing`.

: If the specified column's `-showlinenumbers` option has been set to true, then the actions described above are not performed and the return value is an empty string.

: `tablelist::sortByColumn` is usually specified as the value of the `-labelcommand` configuration option for a tablelist widget.

**KEYWORDS**
: tablelist, sort, column, widget


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addToSortColumns` Command

**NAME**
: `tablelist::addToSortColumns` – Add a column index to the list of sort columns and perform the multi-column sorting

**SYNOPSIS**
: 

```
tablelist::addToSortColumns pathName columnIndex
```

**DESCRIPTION**
: This command adds the column index specified by `columnIndex` to the list of sort columns of the [tablelist](tablelistWidget.md) widget `pathName` and sorts the items based on the elements of the columns indicated by the modified list.  This is done by invoking the `sortbycolumnlist` subcommand of the Tcl command associated with the given tablelist widget.  The two arguments passed to `sortbycolumnlist` are built as follows: (a) if the given column index is already contained in the widget's list of sort columns (returned by the `sortcolumnlist` subcommand) then this list is left unchanged and the sort order list (returned by the `sortorderlist` subcommand) is updated by toggling its corresponding element from `increasing` to `decreasing` and vice-versa; (b) otherwise the column index is appended to the list of sort columns and the value `increasing` is appended to the list of sort orders.

: After sorting the items by passing the two updated lists to the `sortbycolumnlist` subcommand, the virtual event `<<TablelistColumnsSorted>>` (note the plural form!) is generated.  For Tk versions 8.5 or higher, this virtual event is generated with its `-data` option set to a list consisting of the two above-mentioned updated lists passed to `sortbycolumnlist` as arguments.  The command returns the new sort order corresponding to the given column, as `decreasing` or `increasing`.

: If the specified column's `-showlinenumbers` option has been set to true, then the actions described above are not performed and the return value is an empty string.

: `tablelist::addToSortColumns` is usually specified as the value of the `-labelcommand2` configuration option for a tablelist widget.

**KEYWORDS**
: tablelist, sort, column list, widget


[Contents](#contents)     [Start page](index.md)
