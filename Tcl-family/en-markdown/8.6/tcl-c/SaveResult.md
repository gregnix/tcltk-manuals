---
CommandName: Tcl_SaveResult
title: Tcl_SaveResult
ManualSection: 3
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Library Procedures
Keywords:
 - result
 - state
 - interp
Copyright:
 - Copyright (c) 1997 Sun Microsystems, Inc.
---

# Name

Tcl\_SaveInterpState, Tcl\_RestoreInterpState, Tcl\_DiscardInterpState, Tcl\_SaveResult, Tcl\_RestoreResult, Tcl\_DiscardResult - save and restore an interpreter's state

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
[Tcl\_InterpState]{.ret} [Tcl\_SaveInterpState]{.ccmd} [interp, status]{.cargs}
[int]{.ret} [Tcl\_RestoreInterpState]{.ccmd} [interp, state]{.cargs}
[Tcl\_DiscardInterpState]{.ccmd} [state]{.cargs}
[Tcl\_SaveResult]{.ccmd} [interp, savedPtr]{.cargs}
[Tcl\_RestoreResult]{.ccmd} [interp, savedPtr]{.cargs}
[Tcl\_DiscardResult]{.ccmd} [savedPtr]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter for which state should be saved.

[status]{.carg .in type="int"}
: Return code value to save as part of interpreter state.

[state]{.carg .in type="Tcl_InterpState"}
: Saved state token to be restored or discarded.

[\*savedPtr]{.carg .in type="Tcl_SavedResult"}
: Pointer to location where interpreter result should be saved or restored.

:::

# Description

These routines allows a C procedure to take a snapshot of the current state of an interpreter so that it can be restored after a call to [Tcl\_Eval][Eval] or some other routine that modifies the interpreter state.  There are two triplets of routines meant to work together.

The first triplet stores the snapshot of interpreter state in an opaque token returned by **Tcl\_SaveInterpState**.  That token value may then be passed back to one of **Tcl\_RestoreInterpState** or **Tcl\_DiscardInterpState**, depending on whether the interp state is to be restored.  So long as one of the latter two routines is called, Tcl will take care of memory management.

The second triplet stores the snapshot of only the interpreter result (not its complete state) in memory allocated by the caller. These routines are passed a pointer to **Tcl\_SavedResult** that is used to store enough information to restore the interpreter result. **Tcl\_SavedResult** can be allocated on the stack of the calling procedure.  These routines do not save the state of any error information in the interpreter (e.g. the **-errorcode** or **-errorinfo** return options, when an error is in progress).

Because the routines **Tcl\_SaveInterpState**, **Tcl\_RestoreInterpState**, and **Tcl\_DiscardInterpState** perform a superset of the functions provided by the other routines, any new code should only make use of the more powerful routines. The older, weaker routines **Tcl\_SaveResult**, **Tcl\_RestoreResult**, and **Tcl\_DiscardResult** continue to exist only for the sake of existing programs that may already be using them.

**Tcl\_SaveInterpState** takes a snapshot of those portions of interpreter state that make up the full result of script evaluation. This include the interpreter result, the return code (passed in as the *status* argument, and any return options, including **-errorinfo** and **-errorcode** when an error is in progress. This snapshot is returned as an opaque token of type **Tcl\_InterpState**. The call to **Tcl\_SaveInterpState** does not itself change the state of the interpreter.  Unlike **Tcl\_SaveResult**, it does not reset the interpreter.

**Tcl\_RestoreInterpState** accepts a **Tcl\_InterpState** token previously returned by **Tcl\_SaveInterpState** and restores the state of the interp to the state held in that snapshot.  The return value of **Tcl\_RestoreInterpState** is the status value originally passed to **Tcl\_SaveInterpState** when the snapshot token was created.

**Tcl\_DiscardInterpState** is called to release a **Tcl\_InterpState** token previously returned by **Tcl\_SaveInterpState** when that snapshot is not to be restored to an interp.

The **Tcl\_InterpState** token returned by **Tcl\_SaveInterpState** must eventually be passed to either **Tcl\_RestoreInterpState** or **Tcl\_DiscardInterpState** to avoid a memory leak.  Once the **Tcl\_InterpState** token is passed to one of them, the token is no longer valid and should not be used anymore.

**Tcl\_SaveResult** moves the string and value results of *interp* into the location specified by *statePtr*. **Tcl\_SaveResult** clears the result for *interp* and leaves the result in its normal empty initialized state.

**Tcl\_RestoreResult** moves the string and value results from *statePtr* back into *interp*.  Any result or error that was already in the interpreter will be cleared.  The *statePtr* is left in an uninitialized state and cannot be used until another call to **Tcl\_SaveResult**.

**Tcl\_DiscardResult** releases the saved interpreter state stored at **statePtr**.  The state structure is left in an uninitialized state and cannot be used until another call to **Tcl\_SaveResult**.

Once **Tcl\_SaveResult** is called to save the interpreter result, either **Tcl\_RestoreResult** or **Tcl\_DiscardResult** must be called to properly clean up the memory associated with the saved state.


[Eval]: Eval.md
