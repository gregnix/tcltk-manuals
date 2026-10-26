---
CommandName: math::PCA
title: math::PCA
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Principal Components Analysis
Keywords:
 - PCA
 - math
 - statistics
 - tcl
Copyright:
---

# Name

math::PCA - Package for Principal Component Analysis

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6 9]{.optlit}
[package]{.cmd} [require]{.sub} [math::linearalgebra]{.lit} [1.1]{.lit}
[::math::PCA::createPCA]{.cmd} [data]{.arg} [args]{.optarg}
[$pca]{.cmd} [using]{.sub} ?number?|?-minproportion value?
[$pca]{.cmd} [eigenvectors]{.sub} [option]{.optarg}
[$pca]{.cmd} [eigenvalues]{.sub} [option]{.optarg}
[$pca]{.cmd} [proportions]{.sub} [option]{.optarg}
[$pca]{.cmd} [approximate]{.sub} [observation]{.arg}
[$pca]{.cmd} [approximatOriginal]{.sub}
[$pca]{.cmd} [scores]{.sub} [observation]{.arg}
[$pca]{.cmd} [distance]{.sub} [observation]{.arg}
[$pca]{.cmd} [qstatistic]{.sub} [observation]{.arg} [option]{.optarg}
:::

# Description

The PCA package provides a means to perform principal components analysis in Tcl, using an object-oriented technique as facilitated by TclOO. It actually defines a single public method, *::math::PCA::createPCA*, which constructs an object based on the data that are passed to perform the actual analysis.

The methods of the PCA objects that are created with this command allow one to examine the principal components, to approximate (new) observations using all or a selected number of components only and to examine the properties of the components and the statistics of the approximations.

The package has been modelled after the PCA example provided by the original linear algebra package by Ed Hume.

# Commands

The *math::PCA* package provides one public command:

**::math::PCA::createPCA** *data* ?args?
: Create a new object, based on the data that are passed via the *data* argument. The principal components may be based on either correlations or covariances. All observations will be normalised according to the mean and standard deviation of the original data.

    list *data*
    : - A list of observations (see the example below).

    list *args*
    : - A list of key-value pairs defining the options. Currently there is only one key: *-covariances*. This indicates if covariances are to be used (if the value is 1) or instead correlations (value is 0). The default is to use correlations.



The PCA object that is created has the following methods:

**$pca using** ?number?|?-minproportion value?
: Set the number of components to be used in the analysis (the number of retained components). Returns the number of components, also if no argument is given.

    int *number*
    : - The number of components to be retained

    double *value*
    : - Select the number of components based on the minimum proportion of variation that is retained by them. Should be a value between 0 and 1.


**$pca eigenvectors** ?option?
: Return the eigenvectors as a list of lists.

    string *option*
    : - By default only the *retained* components are returned. If all eigenvectors are required, use the option *-all*.


**$pca eigenvalues** ?option?
: Return the eigenvalues as a list of lists.

    string *option*
    : - By default only the eigenvalues of the *retained* components are returned. If all eigenvalues are required, use the option *-all*.


**$pca proportions** ?option?
: Return the proportions for all components, that is, the amount of variations that each components can explain.

**$pca approximate** *observation*
: Return an approximation of the observation based on the retained components

    list *observation*
    : - The values for the observation.


**$pca approximatOriginal**
: Return an approximation of the original data, using the retained components. It is a convenience method that works on the complete set of original data.

**$pca scores** *observation*
: Return the scores per retained component for the given observation.

    list *observation*
    : - The values for the observation.


**$pca distance** *observation*
: Return the distance between the given observation and its approximation. (Note: this distance is based on the normalised vectors.)

    list *observation*
    : - The values for the observation.


**$pca qstatistic** *observation* ?option?
: Return the Q statistic, basically the square of the distance, for the given observation.

    list *observation*
    : - The values for the observation.

    string *option*
    : - If the observation is part of the original data, you may want to use the corrected Q statistic. This is achieved with the option "-original".



# Example

TODO: NIST example

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *PCA* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics
