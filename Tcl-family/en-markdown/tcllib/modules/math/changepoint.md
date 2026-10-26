---
CommandName: math::changepoint
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - control
 - statistics
Copyright:
 - Copyright (c) 2020 by Arjen Markus
---

# Name

math::changepoint - Change point detection methods

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [math::statistics]{.lit} 
[package]{.cmd} [require]{.sub} [math::changepoint]{.lit} [0.2]{.optlit} 
[::math::changepoint::cusum-detect]{.cmd} [data]{.arg} [args]{.optarg} 
[::math::changepoint::cusum-online]{.cmd} [args]{.optarg} 
[\$cusumObj]{.cmd} examine [value]{.arg} 
[\$cusumObj]{.cmd} reset 
[::math::changepoint::binary-segmentation]{.cmd} [data]{.arg} [args]{.optarg} 
:::

# Description

The **math::changepoint** package implements a number of well-known methods to determine if a series of data contains a shift in the mean or not. Note that these methods only indicate if a shift in the mean is probably. Due to the stochastic nature of the data that will be analysed, false positives are possible. The CUSUM method is implemented in both an "offline" and an "online" version, so that it can be used either for a complete data series or for detecting changes in data that come in one by one. The implementation has been based on these websites mostly:

**•**
: *https://www.itl.nist.gov/div898/handbook/pmc/section3/pmc323.htm*

**•**
: *https://en.wikipedia.org/wiki/CUSUM* Basically, the deviation of the data from a given target value is accumulated and when the total deviation becomes too large, a change point is reported. A second method, binary segmentation, is implemented only as an "offline" method, as it needs to examine the data series as a whole. In the variant contained here the following ideas have been used:

**•**
: The segments in which the data series may be separated shold not be too short, otherwise the ultimate result could be segments of only one data point long. So a minimum length is used.

**•**
: To make the segmentation worthwhile there should be a minimum gain in reducing the cost function (the sum of the squared deviations from the mean for each segment). This may not be in agreement with the descriptions of the method found in various publications, but it is simple to understand and intuitive. One publication that provides more information on the method in general is "Selective review of offline change point detection methods" by Truong et al. *https://arxiv.org/abs/1801.00718*.


# Procedures

The package defines the following public procedures:

**::math::changepoint::cusum-detect** *data* ?args?
: Examine a given data series and return the location of the first change (if any)


double *data*
: Series of data to be examined

list *args*
: Optional list of key-value pairs:


**-target** *value*
: The target (or mean) for the time series

**-tolerance** *value*
: The tolerated standard deviation

**-kfactor** *value*
: The factor by which to multiply the standard deviation (defaults to 0.5, typically between 0.5 and 1.0)

**-hfactor** *value*
: The factor determining the limits betweem which the "cusum" statistic is accepted (typicaly 3.0-5.0, default 4.0)


**::math::changepoint::cusum-online** ?args?
: Class to examine data passed in against expected properties. At least the keywords *-target* and *-tolerance* must be given.


list *args*
: List of key-value pairs:


**-target** *value*
: The target (or mean) for the time series

**-tolerance** *value*
: The tolerated standard deviation

**-kfactor** *value*
: The factor by which to multiply the standard deviation (defaults to 0.5, typically between 0.5 and 1.0)

**-hfactor** *value*
: The factor determining the limits betweem which the "cusum" statistic is accepted (typicaly 3.0-5.0, default 4.0)


**\$cusumObj** examine *value*
: Pass a value to the *cusum-online* object and examine it. If, with this new value, the cumulative sum remains within the bounds, zero (0) is returned, otherwise one (1) is returned.


double *value*
: The new value


**\$cusumObj** reset
: Reset the cumulative sum, so that the examination can start afresh.

**::math::changepoint::binary-segmentation** *data* ?args?
: Apply the binary segmentation method recursively to find change points. Returns a list of indices of potential change points


list *data*
: Data to be examined

list *args*
: Optional key-value pairs:


**-minlength** *number*
: Minimum number of points in each segment (default: 5)

**-threshold** *value*
: Factor applied to the standard deviation functioning as a threshold for accepting the change in cost function as an improvement (default: 1.0)


# Category

Mathematics

# Copyright

```
Copyright (c) 2020 by Arjen Markus
```
