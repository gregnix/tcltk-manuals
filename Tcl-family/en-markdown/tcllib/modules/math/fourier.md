---
CommandName: math::fourier
ManualSection: n
Version: 1.0.3
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - FFT
 - Fourier transform
 - complex numbers
 - mathematics
Copyright:
---

# Name

math::fourier - Discrete and fast fourier transforms

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math::fourier]{.lit} [1.0.3]{.lit} 
[::math::fourier::dft]{.cmd} [in_data]{.arg} 
[::math::fourier::inverse_dft]{.cmd} [in_data]{.arg} 
[::math::fourier::lowpass]{.cmd} [cutoff]{.arg} [in_data]{.arg} 
[::math::fourier::highpass]{.cmd} [cutoff]{.arg} [in_data]{.arg} 
:::

# Description

The **math::fourier** package uses the fast Fourier transform, if applicable, or the ordinary transform to implement the discrete Fourier transform. It also provides a few simple filter procedures as an illustration of how such filters can be implemented.

The purpose of this document is to describe the implemented procedures and provide some examples of their usage. As there is ample literature on the algorithms involved, we refer to relevant text books for more explanations. We also refer to the original Wiki page on the subject which describes some of the considerations behind the current implementation.

# General information

The two top-level procedures defined are

**•**
: dft data-list

**•**
: inverse_dft data-list Both take a list of *complex numbers* and apply a Discrete Fourier Transform (DFT) or its inverse respectively to these lists of numbers. A "complex number" in this case is either (i) a pair (two element list) of numbers, interpreted as the real and imaginary parts of the complex number, or (ii) a single number, interpreted as the real part of a complex number whose imaginary part is zero. The return value is always in the first format. (The DFT generally produces complex results even if the input is purely real.) Applying first one and then the other of these procedures to a list of complex numbers will (modulo rounding errors due to floating point arithmetic) return the original list of numbers. If the input length N is a power of two then these procedures will utilize the O(N log N) Fast Fourier Transform algorithm. If input length is not a power of two then the DFT will instead be computed using the naive quadratic algorithm. Some examples:


```
    % dft {1 2 3 4}
    {10 0.0} {-2.0 2.0} {-2 0.0} {-2.0 -2.0}
    % inverse_dft {{10 0.0} {-2.0 2.0} {-2 0.0} {-2.0 -2.0}}
    {1.0 0.0} {2.0 0.0} {3.0 0.0} {4.0 0.0}
    % dft {1 2 3 4 5}
    {15.0 0.0} {-2.5 3.44095480118} {-2.5 0.812299240582} {-2.5 -0.812299240582} {-2.5 -3.44095480118}
    % inverse_dft {{15.0 0.0} {-2.5 3.44095480118} {-2.5 0.812299240582} {-2.5 -0.812299240582} {-2.5 -3.44095480118}}
    {1.0 0.0} {2.0 8.881784197e-17} {3.0 4.4408920985e-17} {4.0 4.4408920985e-17} {5.0 -8.881784197e-17}
```

In the last case, the imaginary parts <1e-16 would have been zero in exact arithmetic, but aren't here due to rounding errors.

Internally, the procedures use a flat list format where every even index element of a list is a real part and every odd index element is an imaginary part. This is reflected in the variable names by Re\_ and Im\_ prefixes.

The package includes two simple filters. They have an analogue equivalent in a simple electronic circuit, a resistor and a capacitance in series. Using these filters requires the **math::complexnumbers** package.

# Procedures

The public Fourier transform procedures are:

**::math::fourier::dft** *in_data*
: Determine the *Fourier transform* of the given list of complex numbers. The result is a list of complex numbers representing the (complex) amplitudes of the Fourier components.


list *in_data*
: List of data


**::math::fourier::inverse_dft** *in_data*
: Determine the *inverse Fourier transform* of the given list of complex numbers (interpreted as amplitudes). The result is a list of complex numbers representing the original (complex) data


list *in_data*
: List of data (amplitudes)


**::math::fourier::lowpass** *cutoff* *in_data*
: Filter the (complex) amplitudes so that high-frequency components are suppressed. The implemented filter is a first-order low-pass filter, the discrete equivalent of a simple electronic circuit with a resistor and a capacitance.


float *cutoff*
: Cut-off frequency

list *in_data*
: List of data (amplitudes)


**::math::fourier::highpass** *cutoff* *in_data*
: Filter the (complex) amplitudes so that low-frequency components are suppressed. The implemented filter is a first-order low-pass filter, the discrete equivalent of a simple electronic circuit with a resistor and a capacitance.


float *cutoff*
: Cut-off frequency

list *in_data*
: List of data (amplitudes)


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: fourier* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics
