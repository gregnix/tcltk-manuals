---
CommandName: math::statistics
title: math::statistics
ManualSection: n
Version: 1.6.1
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - data analysis
 - mathematics
 - statistics
Copyright:
---

# Name

math::statistics - Basic statistical functions and procedures

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [math::statistics]{.lit} [1.6.1]{.lit}
[::math::statistics::mean]{.cmd} [data]{.arg}
[::math::statistics::min]{.cmd} [data]{.arg}
[::math::statistics::max]{.cmd} [data]{.arg}
[::math::statistics::number]{.cmd} [data]{.arg}
[::math::statistics::stdev]{.cmd} [data]{.arg}
[::math::statistics::var]{.cmd} [data]{.arg}
[::math::statistics::pstdev]{.cmd} [data]{.arg}
[::math::statistics::pvar]{.cmd} [data]{.arg}
[::math::statistics::median]{.cmd} [data]{.arg}
[::math::statistics::basic-stats]{.cmd} [data]{.arg}
[::math::statistics::histogram]{.cmd} [limits]{.arg} [values]{.arg} [weights]{.optarg}
[::math::statistics::histogram-alt]{.cmd} [limits]{.arg} [values]{.arg} [weights]{.optarg}
[::math::statistics::corr]{.cmd} [data1]{.arg} [data2]{.arg}
[::math::statistics::interval-mean-stdev]{.cmd} [data]{.arg} [confidence]{.arg}
[::math::statistics::t-test-mean]{.cmd} [data]{.arg} [est\_mean]{.arg} [est\_stdev]{.arg} [alpha]{.arg}
[::math::statistics::test-normal]{.cmd} [data]{.arg} [significance]{.arg}
[::math::statistics::lillieforsFit]{.cmd} [data]{.arg}
[::math::statistics::test-Duckworth]{.cmd} [list1]{.arg} [list2]{.arg} [significance]{.arg}
[::math::statistics::test-anova-F]{.cmd} [alpha]{.arg} [args]{.arg}
[::math::statistics::test-Tukey-range]{.cmd} [alpha]{.arg} [args]{.arg}
[::math::statistics::test-Dunnett]{.cmd} [alpha]{.arg} [control]{.arg} [args]{.arg}
[::math::statistics::quantiles]{.cmd} [data]{.arg} [confidence]{.arg}
[::math::statistics::quantiles]{.cmd} [limits]{.arg} [counts]{.arg} [confidence]{.arg}
[::math::statistics::autocorr]{.cmd} [data]{.arg}
[::math::statistics::crosscorr]{.cmd} [data1]{.arg} [data2]{.arg}
[::math::statistics::mean-histogram-limits]{.cmd} [mean]{.arg} [stdev]{.arg} [number]{.arg}
[::math::statistics::minmax-histogram-limits]{.cmd} [min]{.arg} [max]{.arg} [number]{.arg}
[::math::statistics::linear-model]{.cmd} [xdata]{.arg} [ydata]{.arg} [intercept]{.arg}
[::math::statistics::linear-residuals]{.cmd} [xdata]{.arg} [ydata]{.arg} [intercept]{.arg}
[::math::statistics::test-2x2]{.cmd} [n11]{.arg} [n21]{.arg} [n12]{.arg} [n22]{.arg}
[::math::statistics::print-2x2]{.cmd} [n11]{.arg} [n21]{.arg} [n12]{.arg} [n22]{.arg}
[::math::statistics::control-xbar]{.cmd} [data]{.arg} [nsamples]{.optarg}
[::math::statistics::control-Rchart]{.cmd} [data]{.arg} [nsamples]{.optarg}
[::math::statistics::test-xbar]{.cmd} [control]{.arg} [data]{.arg}
[::math::statistics::test-Rchart]{.cmd} [control]{.arg} [data]{.arg}
[::math::statistics::test-Kruskal-Wallis]{.cmd} [confidence]{.arg} [args]{.arg}
[::math::statistics::analyse-Kruskal-Wallis]{.cmd} [args]{.arg}
[::math::statistics::test-Levene]{.cmd} [groups]{.arg}
[::math::statistics::test-Brown-Forsythe]{.cmd} [groups]{.arg}
[::math::statistics::group-rank]{.cmd} [args]{.arg}
[::math::statistics::test-Wilcoxon]{.cmd} [sample\_a]{.arg} [sample\_b]{.arg}
[::math::statistics::spearman-rank]{.cmd} [sample\_a]{.arg} [sample\_b]{.arg}
[::math::statistics::spearman-rank-extended]{.cmd} [sample\_a]{.arg} [sample\_b]{.arg}
[::math::statistics::kernel-density]{.cmd} [data]{.arg} opt [-option]{.arg} [value]{.arg} ...
[::math::statistics::bootstrap]{.cmd} [data]{.arg} [sampleSize]{.arg} [numberSamples]{.optarg}
[::math::statistics::wasserstein-distance]{.cmd} [prob1]{.arg} [prob2]{.arg}
[::math::statistics::kl-divergence]{.cmd} [prob1]{.arg} [prob2]{.arg}
[::math::statistics::logistic-model]{.cmd} [xdata]{.arg} [ydata]{.arg}
[::math::statistics::logistic-probability]{.cmd} [coeffs]{.arg} [x]{.arg}
[::math::statistics::tstat]{.cmd} [dof]{.arg} [alpha]{.optarg}
[::math::statistics::mv-wls]{.cmd} [weights\_and\_values]{.arg}
[::math::statistics::mv-ols]{.cmd} [values]{.arg}
[::math::statistics::pdf-normal]{.cmd} [mean]{.arg} [stdev]{.arg} [value]{.arg}
[::math::statistics::pdf-lognormal]{.cmd} [mean]{.arg} [stdev]{.arg} [value]{.arg}
[::math::statistics::pdf-exponential]{.cmd} [mean]{.arg} [value]{.arg}
[::math::statistics::pdf-uniform]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg}
[::math::statistics::pdf-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg}
[::math::statistics::pdf-symmetric-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg}
[::math::statistics::pdf-gamma]{.cmd} [alpha]{.arg} [beta]{.arg} [value]{.arg}
[::math::statistics::pdf-poisson]{.cmd} [mu]{.arg} [k]{.arg}
[::math::statistics::pdf-chisquare]{.cmd} [df]{.arg} [value]{.arg}
[::math::statistics::pdf-student-t]{.cmd} [df]{.arg} [value]{.arg}
[::math::statistics::pdf-gamma]{.cmd} [a]{.arg} [b]{.arg} [value]{.arg}
[::math::statistics::pdf-beta]{.cmd} [a]{.arg} [b]{.arg} [value]{.arg}
[::math::statistics::pdf-weibull]{.cmd} [scale]{.arg} [shape]{.arg} [value]{.arg}
[::math::statistics::pdf-gumbel]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg}
[::math::statistics::pdf-pareto]{.cmd} [scale]{.arg} [shape]{.arg} [value]{.arg}
[::math::statistics::pdf-cauchy]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg}
[::math::statistics::pdf-laplace]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg}
[::math::statistics::pdf-kumaraswamy]{.cmd} [a]{.arg} [b]{.arg} [value]{.arg}
[::math::statistics::pdf-negative-binomial]{.cmd} [r]{.arg} [p]{.arg} [value]{.arg}
[::math::statistics::cdf-normal]{.cmd} [mean]{.arg} [stdev]{.arg} [value]{.arg}
[::math::statistics::cdf-lognormal]{.cmd} [mean]{.arg} [stdev]{.arg} [value]{.arg}
[::math::statistics::cdf-exponential]{.cmd} [mean]{.arg} [value]{.arg}
[::math::statistics::cdf-uniform]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg}
[::math::statistics::cdf-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg}
[::math::statistics::cdf-symmetric-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [value]{.arg}
[::math::statistics::cdf-students-t]{.cmd} [degrees]{.arg} [value]{.arg}
[::math::statistics::cdf-gamma]{.cmd} [alpha]{.arg} [beta]{.arg} [value]{.arg}
[::math::statistics::cdf-poisson]{.cmd} [mu]{.arg} [k]{.arg}
[::math::statistics::cdf-beta]{.cmd} [a]{.arg} [b]{.arg} [value]{.arg}
[::math::statistics::cdf-weibull]{.cmd} [scale]{.arg} [shape]{.arg} [value]{.arg}
[::math::statistics::cdf-gumbel]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg}
[::math::statistics::cdf-pareto]{.cmd} [scale]{.arg} [shape]{.arg} [value]{.arg}
[::math::statistics::cdf-cauchy]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg}
[::math::statistics::cdf-F]{.cmd} [nf1]{.arg} [nf2]{.arg} [value]{.arg}
[::math::statistics::cdf-laplace]{.cmd} [location]{.arg} [scale]{.arg} [value]{.arg}
[::math::statistics::cdf-kumaraswamy]{.cmd} [a]{.arg} [b]{.arg} [value]{.arg}
[::math::statistics::cdf-negative-binomial]{.cmd} [r]{.arg} [p]{.arg} [value]{.arg}
[::math::statistics::empirical-distribution]{.cmd} [values]{.arg}
[::math::statistics::random-normal]{.cmd} [mean]{.arg} [stdev]{.arg} [number]{.arg}
[::math::statistics::random-lognormal]{.cmd} [mean]{.arg} [stdev]{.arg} [number]{.arg}
[::math::statistics::random-exponential]{.cmd} [mean]{.arg} [number]{.arg}
[::math::statistics::random-uniform]{.cmd} [xmin]{.arg} [xmax]{.arg} [number]{.arg}
[::math::statistics::random-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [number]{.arg}
[::math::statistics::random-symmetric-triangular]{.cmd} [xmin]{.arg} [xmax]{.arg} [number]{.arg}
[::math::statistics::random-gamma]{.cmd} [alpha]{.arg} [beta]{.arg} [number]{.arg}
[::math::statistics::random-poisson]{.cmd} [mu]{.arg} [number]{.arg}
[::math::statistics::random-chisquare]{.cmd} [df]{.arg} [number]{.arg}
[::math::statistics::random-student-t]{.cmd} [df]{.arg} [number]{.arg}
[::math::statistics::random-beta]{.cmd} [a]{.arg} [b]{.arg} [number]{.arg}
[::math::statistics::random-weibull]{.cmd} [scale]{.arg} [shape]{.arg} [number]{.arg}
[::math::statistics::random-gumbel]{.cmd} [location]{.arg} [scale]{.arg} [number]{.arg}
[::math::statistics::random-pareto]{.cmd} [scale]{.arg} [shape]{.arg} [number]{.arg}
[::math::statistics::random-cauchy]{.cmd} [location]{.arg} [scale]{.arg} [number]{.arg}
[::math::statistics::random-laplace]{.cmd} [location]{.arg} [scale]{.arg} [number]{.arg}
[::math::statistics::random-kumaraswamy]{.cmd} [a]{.arg} [b]{.arg} [number]{.arg}
[::math::statistics::random-negative-binomial]{.cmd} [r]{.arg} [p]{.arg} [number]{.arg}
[::math::statistics::histogram-uniform]{.cmd} [xmin]{.arg} [xmax]{.arg} [limits]{.arg} [number]{.arg}
[::math::statistics::incompleteGamma]{.cmd} [x]{.arg} [p]{.arg} [tol]{.optarg}
[::math::statistics::incompleteBeta]{.cmd} [a]{.arg} [b]{.arg} [x]{.arg} [tol]{.optarg}
[::math::statistics::estimate-pareto]{.cmd} [values]{.arg}
[::math::statistics::estimate-exponential]{.cmd} [values]{.arg}
[::math::statistics::estimate-laplace]{.cmd} [values]{.arg}
[::math::statistics::estimante-negative-binomial]{.cmd} [r]{.arg} [values]{.arg}
[::math::statistics::filter]{.cmd} [varname]{.arg} [data]{.arg} [expression]{.arg}
[::math::statistics::map]{.cmd} [varname]{.arg} [data]{.arg} [expression]{.arg}
[::math::statistics::samplescount]{.cmd} [varname]{.arg} [list]{.arg} [expression]{.arg}
[::math::statistics::subdivide]{.cmd}
[::math::statistics::plot-scale]{.cmd} [canvas]{.arg} [xmin]{.arg} [xmax]{.arg} [ymin]{.arg} [ymax]{.arg}
[::math::statistics::plot-xydata]{.cmd} [canvas]{.arg} [xdata]{.arg} [ydata]{.arg} [tag]{.arg}
[::math::statistics::plot-xyline]{.cmd} [canvas]{.arg} [xdata]{.arg} [ydata]{.arg} [tag]{.arg}
[::math::statistics::plot-tdata]{.cmd} [canvas]{.arg} [tdata]{.arg} [tag]{.arg}
[::math::statistics::plot-tline]{.cmd} [canvas]{.arg} [tdata]{.arg} [tag]{.arg}
[::math::statistics::plot-histogram]{.cmd} [canvas]{.arg} [counts]{.arg} [limits]{.arg} [tag]{.arg}
:::

# Description

The **math::statistics** package contains functions and procedures for basic statistical data analysis, such as:

- Descriptive statistical parameters (mean, minimum, maximum, standard deviation)

- Estimates of the distribution in the form of histograms and quantiles

- Basic testing of hypotheses

- Probability and cumulative density functions


It is meant to help in developing data analysis applications or doing ad hoc data analysis, it is not in itself a full application, nor is it intended to rival with full (non-)commercial statistical packages.

The purpose of this document is to describe the implemented procedures and provide some examples of their usage. As there is ample literature on the algorithms involved, we refer to relevant text books for more explanations. The package contains a fairly large number of public procedures. They can be distinguished in three sets: general procedures, procedures that deal with specific statistical distributions, list procedures to select or transform data and simple plotting procedures (these require Tk). *Note:* The data that need to be analyzed are always contained in a simple list. Missing values are represented as empty list elements. *Note:* With version 1.0.1 a mistake in the procs *pdf-lognormal*, *cdf-lognormal* and *random-lognormal* has been corrected. In previous versions the argument for the standard deviation was actually used as if it was the variance.

# General procedures

The general statistical procedures are:

**::math::statistics::mean** *data*
: Determine the *mean* value of the given list of data.

    list *data*
    : - List of data


**::math::statistics::min** *data*
: Determine the *minimum* value of the given list of data.

    list *data*
    : - List of data


**::math::statistics::max** *data*
: Determine the *maximum* value of the given list of data.

    list *data*
    : - List of data


**::math::statistics::number** *data*
: Determine the *number* of non-missing data in the given list

    list *data*
    : - List of data


**::math::statistics::stdev** *data*
: Determine the *sample standard deviation* of the data in the given list

    list *data*
    : - List of data


**::math::statistics::var** *data*
: Determine the *sample variance* of the data in the given list

    list *data*
    : - List of data


**::math::statistics::pstdev** *data*
: Determine the *population standard deviation* of the data in the given list

    list *data*
    : - List of data


**::math::statistics::pvar** *data*
: Determine the *population variance* of the data in the given list

    list *data*
    : - List of data


**::math::statistics::median** *data*
: Determine the *median* of the data in the given list (Note that this requires sorting the data, which may be a costly operation)

    list *data*
    : - List of data


**::math::statistics::basic-stats** *data*
: Determine a list of all the descriptive parameters: mean, minimum, maximum, number of data, sample standard deviation, sample variance, population standard deviation and population variance.

    (This routine is called whenever either or all of the basic statistical parameters are required. Hence all calculations are done and the relevant values are returned.)

    list *data*
    : - List of data


**::math::statistics::histogram** *limits* *values* ?weights?
: Determine histogram information for the given list of data. Returns a list consisting of the number of values that fall into each interval. (The first interval consists of all values lower than the first limit, the last interval consists of all values greater than the last limit. There is one more interval than there are limits.)

    Optionally, you can use weights to influence the histogram.

    list *limits*
    : - List of upper limits (in ascending order) for the intervals of the histogram.

    list *values*
    : - List of data

    list *weights*
    : - List of weights, one weight per value


**::math::statistics::histogram-alt** *limits* *values* ?weights?
: Alternative implementation of the histogram procedure: the open end of the intervals is at the lower bound instead of the upper bound.

    list *limits*
    : - List of upper limits (in ascending order) for the intervals of the histogram.

    list *values*
    : - List of data

    list *weights*
    : - List of weights, one weight per value


**::math::statistics::corr** *data1* *data2*
: Determine the correlation coefficient between two sets of data.

    list *data1*
    : - First list of data

    list *data2*
    : - Second list of data


**::math::statistics::interval-mean-stdev** *data* *confidence*
: Return the interval containing the mean value and one containing the standard deviation with a certain level of confidence (assuming a normal distribution)

    list *data*
    : - List of raw data values (small sample)

    float *confidence*
    : - Confidence level (0.95 or 0.99 for instance)


**::math::statistics::t-test-mean** *data* *est\_mean* *est\_stdev* *alpha*
: Test whether the mean value of a sample is in accordance with the estimated normal distribution with a certain probability. Returns 1 if the test succeeds or 0 if the mean is unlikely to fit the given distribution.

    list *data*
    : - List of raw data values (small sample)

    float *est\_mean*
    : - Estimated mean of the distribution

    float *est\_stdev*
    : - Estimated stdev of the distribution

    float *alpha*
    : - Probability level (0.95 or 0.99 for instance)


**::math::statistics::test-normal** *data* *significance*
: Test whether the given data follow a normal distribution with a certain level of significance. Returns 1 if the data are normally distributed within the level of significance, returns 0 if not. The underlying test is the Lilliefors test. Smaller values of the significance mean a stricter testing.

    list *data*
    : - List of raw data values

    float *significance*
    : - Significance level (one of 0.01, 0.05, 0.10, 0.15 or 0.20). For compatibility reasons the values "1-significance", 0.80, 0.85, 0.90, 0.95 or 0.99 are also accepted.


    Compatibility issue: the original implementation and documentation used the term "confidence" and used a value 1-significance (see ticket 2812473fff). This has been corrected as of version 0.9.3.

**::math::statistics::lillieforsFit** *data*
: Returns the goodness of fit to a normal distribution according to Lilliefors. The higher the number, the more likely the data are indeed normally distributed. The test requires at least *five* data points.

    list *data*
    : - List of raw data values


**::math::statistics::test-Duckworth** *list1* *list2* *significance*
: Determine if two data sets have the same median according to the Tukey-Duckworth test. The procedure returns 0 if the medians are unequal, 1 if they are equal, -1 if the test can not be conducted (the smallest value must be in a different set than the greatest value). # # Arguments: #     list1           Values in the first data set #     list2           Values in the second data set #     significance    Significance level (either 0.05, 0.01 or 0.001) # # Returns: Test whether the given data follow a normal distribution with a certain level of significance. Returns 1 if the data are normally distributed within the level of significance, returns 0 if not. The underlying test is the Lilliefors test. Smaller values of the significance mean a stricter testing.

    list *list1*
    : - First list of data

    list *list2*
    : - Second list of data

    float *significance*
    : - Significance level (either 0.05, 0.01 or 0.001)


**::math::statistics::test-anova-F** *alpha* *args*
: Determine if two or more groups with normally distributed data have the same means. The procedure returns 0 if the means are likely unequal, 1 if they are. This is a one-way ANOVA test. The groups may also be stored in a nested list: The procedure returns a list of the comparison results for each pair of groups. Each element of this list contains: the index of the first group and that of the second group, whether the means are likely to be different (1) or not (0) and the confidence interval the conclusion is based on. The groups may also be stored in a nested list:

    ```
        test-anova-F 0.05 $A $B $C
        #
        # Or equivalently:
        #
        test-anova-F 0.05 [list $A $B $C]
    ```

    float *alpha*
    : - Significance level

    list *args*
    : - Two or more groups of data to be checked


**::math::statistics::test-Tukey-range** *alpha* *args*
: Determine if two or more groups with normally distributed data have the same means, using Tukey's range test. It is complementary to the ANOVA test. The procedure returns a list of the comparison results for each pair of groups. Each element of this list contains: the index of the first group and that of the second group, whether the means are likely to be different (1) or not (0) and the confidence interval the conclusion is based on. The groups may also be stored in a nested list, just as with the ANOVA test.

    float *alpha*
    : - Significance level - either 0.05 or 0.01

    list *args*
    : - Two or more groups of data to be checked


**::math::statistics::test-Dunnett** *alpha* *control* *args*
: Determine if one or more groups with normally distributed data have the same means as the group of control data, using Dunnett's test. It is complementary to the ANOVA test. The procedure returns a list of the comparison results for each group with the control group. Each element of this list contains: whether the means are likely to be different (1) or not (0) and the confidence interval the conclusion is based on. The groups may also be stored in a nested list, just as with the ANOVA test.

    Note: some care is required if there is only one group to compare the control with:

    ```
        test-Dunnett-F 0.05 $control [list $A]
    ```

    Otherwise the group A is split up into groups of one element - this is due to an ambiguity.

    float *alpha*
    : - Significance level - either 0.05 or 0.01

    list *args*
    : - One or more groups of data to be checked


**::math::statistics::quantiles** *data* *confidence*
: Return the quantiles for a given set of data

    list *data*
    : - List of raw data values

    float *confidence*
    : - Confidence level (0.95 or 0.99 for instance) or a list of confidence levels.


**::math::statistics::quantiles** *limits* *counts* *confidence*
: Return the quantiles based on histogram information (alternative to the call with two arguments)

    list *limits*
    : - List of upper limits from histogram

    list *counts*
    : - List of counts for for each interval in histogram

    float *confidence*
    : -  Confidence level (0.95 or 0.99 for instance) or a list of confidence levels.


**::math::statistics::autocorr** *data*
: Return the autocorrelation function as a list of values (assuming equidistance between samples, about 1/2 of the number of raw data)

    The correlation is determined in such a way that the first value is always 1 and all others are equal to or smaller than 1. The number of values involved will diminish as the "time" (the index in the list of returned values) increases

    list *data*
    : - Raw data for which the autocorrelation must be determined


**::math::statistics::crosscorr** *data1* *data2*
: Return the cross-correlation function as a list of values (assuming equidistance between samples, about 1/2 of the number of raw data)

    The correlation is determined in such a way that the values can never exceed 1 in magnitude. The number of values involved will diminish as the "time" (the index in the list of returned values) increases.

    list *data1*
    : - First list of data

    list *data2*
    : - Second list of data


**::math::statistics::mean-histogram-limits** *mean* *stdev* *number*
: Determine reasonable limits based on mean and standard deviation for a histogram Convenience function - the result is suitable for the histogram function.

    float *mean*
    : - Mean of the data

    float *stdev*
    : - Standard deviation

    int *number*
    : - Number of limits to generate (defaults to 8)


**::math::statistics::minmax-histogram-limits** *min* *max* *number*
: Determine reasonable limits based on a minimum and maximum for a histogram

    Convenience function - the result is suitable for the histogram function.

    float *min*
    : - Expected minimum

    float *max*
    : - Expected maximum

    int *number*
    : - Number of limits to generate (defaults to 8)


**::math::statistics::linear-model** *xdata* *ydata* *intercept*
: Determine the coefficients for a linear regression between two series of data (the model: Y = A + B\*X). Returns a list of parameters describing the fit

    list *xdata*
    : - List of independent data

    list *ydata*
    : - List of dependent data to be fitted

    boolean *intercept*
    : - (Optional) compute the intercept (1, default) or fit to a line through the origin (0)

        The result consists of the following list:

        - (Estimate of) Intercept A

        - (Estimate of) Slope B

        - Standard deviation of Y relative to fit

        - Correlation coefficient R2

        - Number of degrees of freedom df

        - Standard error of the intercept A

        - Significance level of A

        - Standard error of the slope B

        - Significance level of B



**::math::statistics::linear-residuals** *xdata* *ydata* *intercept*
: Determine the difference between actual data and predicted from the linear model.

    Returns a list of the differences between the actual data and the predicted values.

    list *xdata*
    : - List of independent data

    list *ydata*
    : - List of dependent data to be fitted

    boolean *intercept*
    : - (Optional) compute the intercept (1, default) or fit to a line through the origin (0)


**::math::statistics::test-2x2** *n11* *n21* *n12* *n22*
: Determine if two set of samples, each from a binomial distribution, differ significantly or not (implying a different parameter).

    Returns the "chi-square" value, which can be used to the determine the significance.

    int *n11*
    : - Number of outcomes with the first value from the first sample.

    int *n21*
    : - Number of outcomes with the first value from the second sample.

    int *n12*
    : - Number of outcomes with the second value from the first sample.

    int *n22*
    : - Number of outcomes with the second value from the second sample.


**::math::statistics::print-2x2** *n11* *n21* *n12* *n22*
: Determine if two set of samples, each from a binomial distribution, differ significantly or not (implying a different parameter).

    Returns a short report, useful in an interactive session.

    int *n11*
    : - Number of outcomes with the first value from the first sample.

    int *n21*
    : - Number of outcomes with the first value from the second sample.

    int *n12*
    : - Number of outcomes with the second value from the first sample.

    int *n22*
    : - Number of outcomes with the second value from the second sample.


**::math::statistics::control-xbar** *data* ?nsamples?
: Determine the control limits for an xbar chart. The number of data in each subsample defaults to 4. At least 20 subsamples are required.

    Returns the mean, the lower limit, the upper limit and the number of data per subsample.

    list *data*
    : - List of observed data

    int *nsamples*
    : - Number of data per subsample


**::math::statistics::control-Rchart** *data* ?nsamples?
: Determine the control limits for an R chart. The number of data in each subsample (nsamples) defaults to 4. At least 20 subsamples are required.

    Returns the mean range, the lower limit, the upper limit and the number of data per subsample.

    list *data*
    : - List of observed data

    int *nsamples*
    : - Number of data per subsample


**::math::statistics::test-xbar** *control* *data*
: Determine if the data exceed the control limits for the xbar chart.

    Returns a list of subsamples (their indices) that indeed violate the limits.

    list *control*
    : - Control limits as returned by the "control-xbar" procedure

    list *data*
    : - List of observed data


**::math::statistics::test-Rchart** *control* *data*
: Determine if the data exceed the control limits for the R chart.

    Returns a list of subsamples (their indices) that indeed violate the limits.

    list *control*
    : - Control limits as returned by the "control-Rchart" procedure

    list *data*
    : - List of observed data


**::math::statistics::test-Kruskal-Wallis** *confidence* *args*
: Check if the population medians of two or more groups are equal with a given confidence level, using the Kruskal-Wallis test.

    float *confidence*
    : - Confidence level to be used (0-1)

    list *args*
    : - Two or more lists of data


**::math::statistics::analyse-Kruskal-Wallis** *args*
: Compute the statistical parameters for the Kruskal-Wallis test. Returns the Kruskal-Wallis statistic and the probability that that value would occur assuming the medians of the populations are equal.

    list *args*
    : - Two or more lists of data


**::math::statistics::test-Levene** *groups*
: Compute the Levene statistic to determine if groups of data have the same variance (are homoscadastic) or not. The data are organised in groups. This version uses the mean of the data as the measure to determine the deviations. The statistic is equivalent to an F statistic with degrees of freedom k-1 and N-k, k being the number of groups and N the total number of data.

    list *groups*
    : - List of groups of data


**::math::statistics::test-Brown-Forsythe** *groups*
: Compute the Brown-Forsythe statistic to determine if groups of data have the same variance (are homoscadastic) or not. Like the Levene test, but this version uses the median of the data.

    list *groups*
    : - List of groups of data


**::math::statistics::group-rank** *args*
: Rank the groups of data with respect to the complete set. Returns a list consisting of the group ID, the value and the rank (possibly a rational number, in case of ties) for each data item.

    list *args*
    : - Two or more lists of data


**::math::statistics::test-Wilcoxon** *sample\_a* *sample\_b*
: Compute the Wilcoxon test statistic to determine if two samples have the same median or not. (The statistic can be regarded as standard normal, if the sample sizes are both larger than 10.) Returns the value of this statistic.

    list *sample\_a*
    : - List of data comprising the first sample

    list *sample\_b*
    : - List of data comprising the second sample


**::math::statistics::spearman-rank** *sample\_a* *sample\_b*
: Return the Spearman rank correlation as an alternative to the ordinary (Pearson's) correlation coefficient. The two samples should have the same number of data.

    list *sample\_a*
    : - First list of data

    list *sample\_b*
    : - Second list of data


**::math::statistics::spearman-rank-extended** *sample\_a* *sample\_b*
: Return the Spearman rank correlation as an alternative to the ordinary (Pearson's) correlation coefficient as well as additional data. The two samples should have the same number of data. The procedure returns the correlation coefficient, the number of data pairs used and the z-score, an approximately standard normal statistic, indicating the significance of the correlation.

    list *sample\_a*
    : - First list of data

    list *sample\_b*
    : - Second list of data


**::math::statistics::kernel-density** *data* opt *-option value* ...
: Return the density function based on kernel density estimation. The procedure is controlled by a small set of options, each of which is given a reasonable default.

    The return value consists of three lists: the centres of the bins, the associated probability density and a list of computational parameters (begin and end of the interval, mean and standard deviation and the used bandwidth). The computational parameters can be used for further analysis.

    list *data*
    : - The data to be examined

    list *args*
    : - Option-value pairs:

        **-weights** *weights*
        : Per data point the weight (default: 1 for all data)

        **-bandwidth** *value*
        : Bandwidth to be used for the estimation (default: determined from standard deviation)

        **-number** *value*
        : Number of bins to be returned (default: 100)

        **-interval** *{begin end}*
        : Begin and end of the interval for which the density is returned (default: mean +/- 3\*standard deviation)

        **-kernel** *function*
        : Kernel to be used (One of: gaussian, cosine, epanechnikov, uniform, triangular, biweight, logistic; default: gaussian)



**::math::statistics::bootstrap** *data* *sampleSize* ?numberSamples?
: Create a subsample or subsamples from a given list of data. The data in the samples are chosen from this list - multiples may occur. If there is only one subsample, the sample itself is returned (as a list of "sampleSize" values), otherwise a list of samples is returned.

    list *data*
    : List of values to chose from

    int *sampleSize*
    : Number of values per sample

    int *numberSamples*
    : Number of samples (default: 1)


**::math::statistics::wasserstein-distance** *prob1* *prob2*
: Compute the Wasserstein distance or earth mover's distance for two equidstantly spaced histograms or probability densities. The histograms need not to be normalised to sum to one, but they must have the same number of entries.

    Note: the histograms are assumed to be based on the same equidistant intervals. As the bounds are not passed, the value is expressed in the length of the intervals.

    list *prob1*
    : List of values for the first histogram/probability density

    list *prob2*
    : List of values for the second histogram/probability density


**::math::statistics::kl-divergence** *prob1* *prob2*
: Compute the Kullback-Leibler (KL) divergence for two equidstantly spaced histograms or probability densities. The histograms need not to be normalised to sum to one, but they must have the same number of entries.

    Note: the histograms are assumed to be based on the same equidistant intervals. As the bounds are not passed, the value is expressed in the length of the intervals.

    Note also that the KL divergence is not symmetric and that the second histogram should not contain zeroes in places where the first histogram has non-zero values.

    list *prob1*
    : List of values for the first histogram/probability density

    list *prob2*
    : List of values for the second histogram/probability density


**::math::statistics::logistic-model** *xdata* *ydata*
: Estimate the coefficients of the logistic model that fits the data best. The data consist of independent x-values and the outcome 0 or 1 for each of the x-values. The result can be used to estimate the probability that a certain x-value gives 1.

    list *xdata*
    : List of values for which the success (1) or failure (0) is known

    list *ydata*
    : List of successes or failures corresponding to each value in *xdata*.


**::math::statistics::logistic-probability** *coeffs* *x*
: Calculate the probability of success for the value *x* given the coefficients of the logistic model.

    list *coeffs*
    : List of coefficients as determine by the **logistic-model** command

    float *x*
    : X-value for which the probability needs to be determined



# Multivariate linear regression

Besides the linear regression with a single independent variable, the statistics package provides two procedures for doing ordinary least squares (OLS) and weighted least squares (WLS) linear regression with several variables. They were written by Eric Kemp-Benedict.

In addition to these two, it provides a procedure (tstat) for calculating the value of the t-statistic for the specified number of degrees of freedom that is required to demonstrate a given level of significance.

Note: These procedures depend on the math::linearalgebra package.

*Description of the procedures*

**::math::statistics::tstat** *dof* ?alpha?
: Returns the value of the t-distribution t\* satisfying

    ```
        P(t*)  =  1 - alpha/2
        P(-t*) =  alpha/2
    ```

    for the number of degrees of freedom dof.

    Given a sample of normally-distributed data x, with an estimate xbar for the mean and sbar for the standard deviation, the alpha confidence interval for the estimate of the mean can be calculated as

    ```
          ( xbar - t* sbar , xbar + t* sbar)
    ```

    The return values from this procedure can be compared to an estimated t-statistic to determine whether the estimated value of a parameter is significantly different from zero at the given confidence level.

    int *dof*
    : Number of degrees of freedom

    float *alpha*
    : Confidence level of the t-distribution. Defaults to 0.05.


**::math::statistics::mv-wls** *weights\_and\_values*
: Carries out a weighted least squares linear regression for the data points provided, with weights assigned to each point.

    The linear model is of the form

    ```
        y = b0 + b1 * x1 + b2 * x2 ... + bN * xN + error
    ```

    and each point satisfies

    ```
        yi = b0 + b1 * xi1 + b2 * xi2 + ... + bN * xiN + Residual_i
    ```

    The procedure returns a list with the following elements:

    - The r-squared statistic

    - The adjusted r-squared statistic

    - A list containing the estimated coefficients b1, ... bN, b0 (The constant b0 comes last in the list.)

    - A list containing the standard errors of the coefficients

    - A list containing the 95% confidence bounds of the coefficients, with each set of bounds returned as a list with two values


    Arguments:

    list *weights\_and\_values*
    : A list consisting of: the weight for the first observation, the data for the first observation (as a sublist), the weight for the second observation (as a sublist) and so on. The sublists of data are organised as lists of the value of the dependent variable y and the independent variables x1, x2 to xN.


    *Example of the use:* The weight factors are quite simple: 0.2 for negative values to indicate we put less trust in these observations and 1.0 for all positive values.

    ```
    # Store the value of the unicode value for the "+/-" character
    set pm "\u00B1"

    # Provide some data
    set data { 0.2 {  -.67  14.18  60.03 -7.5  }
               1.0 { 36.97  15.52  34.24 14.61 }
               0.2 {-29.57  21.85  83.36 -7.   }
               0.2 {-16.9   11.79  51.67 -6.56 }
               1.0 { 14.09  16.24  36.97 -12.84}
               1.0 { 31.52  20.93  45.99 -25.4 }
               1.0 { 24.05  20.69  50.27  17.27}
               1.0 { 22.23  16.91  45.07  -4.3 }
               1.0 { 40.79  20.49  38.92  -.73 }
               0.2 {-10.35  17.24  58.77  18.78}}

    # Call the ols routine
    set results [::math::statistics::mv-ols $data]

    # Pretty-print the results
    puts "R-squared: [lindex $results 0]"
    puts "Adj R-squared: [lindex $results 1]"
    puts "Coefficients $pm s.e. -- \[95% confidence interval\]:"
    foreach val [lindex $results 2] se [lindex $results 3] bounds [lindex $results 4] {
        set lb [lindex $bounds 0]
        set ub [lindex $bounds 1]
        puts "   $val $pm $se -- \[$lb to $ub\]"
    }
    ```

**::math::statistics::mv-ols** *values*
: Carries out an ordinary least squares linear regression for the data points provided.

    This procedure simply calls ::mvlinreg::wls with the weights set to 1.0, and returns the same information.


*Example of the use:*

```
# Store the value of the unicode value for the "+/-" character
set pm "\u00B1"

# Provide some data
set data {{  -.67  14.18  60.03 -7.5  }
          { 36.97  15.52  34.24 14.61 }
          {-29.57  21.85  83.36 -7.   }
          {-16.9   11.79  51.67 -6.56 }
          { 14.09  16.24  36.97 -12.84}
          { 31.52  20.93  45.99 -25.4 }
          { 24.05  20.69  50.27  17.27}
          { 22.23  16.91  45.07  -4.3 }
          { 40.79  20.49  38.92  -.73 }
          {-10.35  17.24  58.77  18.78}}

# Call the ols routine
set results [::math::statistics::mv-ols $data]

# Pretty-print the results
puts "R-squared: [lindex $results 0]"
puts "Adj R-squared: [lindex $results 1]"
puts "Coefficients $pm s.e. -- \[95% confidence interval\]:"
foreach val [lindex $results 2] se [lindex $results 3] bounds [lindex $results 4] {
    set lb [lindex $bounds 0]
    set ub [lindex $bounds 1]
    puts "   $val $pm $se -- \[$lb to $ub\]"
}
```

# Statistical distributions

In the literature a large number of probability distributions can be found. The statistics package supports:

- The normal or Gaussian distribution as well as the log-normal distribution

- The uniform distribution - equal probability for all data within a given interval

- The exponential distribution - useful as a model for certain extreme-value distributions.

- The gamma distribution - based on the incomplete Gamma integral

- The beta distribution

- The chi-square distribution

- The student's T distribution

- The Poisson distribution

- The Pareto distribution

- The Gumbel distribution

- The Weibull distribution

- The Cauchy distribution

- The F distribution (only the cumulative density function)

- PM - binomial.


In principle for each distribution one has procedures for:

- The probability density (pdf-\*)

- The cumulative density (cdf-\*)

- Quantiles for the given distribution (quantiles-\*)

- Histograms for the given distribution (histogram-\*)

- List of random values with the given distribution (random-\*)


The following procedures have been implemented:

**::math::statistics::pdf-normal** *mean* *stdev* *value*
: Return the probability of a given value for a normal distribution with given mean and standard deviation.

    float *mean*
    : - Mean value of the distribution

    float *stdev*
    : - Standard deviation of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-lognormal** *mean* *stdev* *value*
: Return the probability of a given value for a log-normal distribution with given mean and standard deviation.

    float *mean*
    : - Mean value of the distribution

    float *stdev*
    : - Standard deviation of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-exponential** *mean* *value*
: Return the probability of a given value for an exponential distribution with given mean.

    float *mean*
    : - Mean value of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-uniform** *xmin* *xmax* *value*
: Return the probability of a given value for a uniform distribution with given extremes.

    float *xmin*
    : - Minimum value of the distribution

    float *xmin*
    : - Maximum value of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-triangular** *xmin* *xmax* *value*
: Return the probability of a given value for a triangular distribution with given extremes. If the argument min is lower than the argument max, then smaller values have higher probability and vice versa. In the first case the probability density function is of the form *f(x) = 2(1-x)* and the other case it is of the form *f(x) = 2x*.

    float *xmin*
    : - Minimum value of the distribution

    float *xmin*
    : - Maximum value of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-symmetric-triangular** *xmin* *xmax* *value*
: Return the probability of a given value for a symmetric triangular distribution with given extremes.

    float *xmin*
    : - Minimum value of the distribution

    float *xmin*
    : - Maximum value of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-gamma** *alpha* *beta* *value*
: Return the probability of a given value for a Gamma distribution with given shape and rate parameters

    float *alpha*
    : - Shape parameter

    float *beta*
    : - Rate parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-poisson** *mu* *k*
: Return the probability of a given number of occurrences in the same interval (k) for a Poisson distribution with given mean (mu)

    float *mu*
    : - Mean number of occurrences

    int *k*
    : - Number of occurences


**::math::statistics::pdf-chisquare** *df* *value*
: Return the probability of a given value for a chi square distribution with given degrees of freedom

    float *df*
    : - Degrees of freedom

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-student-t** *df* *value*
: Return the probability of a given value for a Student's t distribution with given degrees of freedom

    float *df*
    : - Degrees of freedom

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-gamma** *a* *b* *value*
: Return the probability of a given value for a Gamma distribution with given shape and rate parameters

    float *a*
    : - Shape parameter

    float *b*
    : - Rate parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-beta** *a* *b* *value*
: Return the probability of a given value for a Beta distribution with given shape parameters

    float *a*
    : - First shape parameter

    float *b*
    : - Second shape parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-weibull** *scale* *shape* *value*
: Return the probability of a given value for a Weibull distribution with given scale and shape parameters

    float *location*
    : - Scale parameter

    float *scale*
    : - Shape parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-gumbel** *location* *scale* *value*
: Return the probability of a given value for a Gumbel distribution with given location and shape parameters

    float *location*
    : - Location parameter

    float *scale*
    : - Shape parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-pareto** *scale* *shape* *value*
: Return the probability of a given value for a Pareto distribution with given scale and shape parameters

    float *scale*
    : - Scale parameter

    float *shape*
    : - Shape parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-cauchy** *location* *scale* *value*
: Return the probability of a given value for a Cauchy distribution with given location and shape parameters. Note that the Cauchy distribution has no finite higher-order moments.

    float *location*
    : - Location parameter

    float *scale*
    : - Shape parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-laplace** *location* *scale* *value*
: Return the probability of a given value for a Laplace distribution with given location and shape parameters. The Laplace distribution consists of two exponential functions, is peaked and has heavier tails than the normal distribution.

    float *location*
    : - Location parameter (mean)

    float *scale*
    : - Shape parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-kumaraswamy** *a* *b* *value*
: Return the probability of a given value for a Kumaraswamy distribution with given parameters a and b. The Kumaraswamy distribution is related to the Beta distribution, but has a tractable cumulative distribution function.

    float *a*
    : - Parameter a

    float *b*
    : - Parameter b

    float *value*
    : - Value for which the probability is required


**::math::statistics::pdf-negative-binomial** *r* *p* *value*
: Return the probability of a given value for a negative binomial distribution with an allowed number of failures and the probability of success.

    int *r*
    : - Allowed number of failures (at least 1)

    float *p*
    : - Probability of success

    int *value*
    : - Number of successes for which the probability is to be returned


**::math::statistics::cdf-normal** *mean* *stdev* *value*
: Return the cumulative probability of a given value for a normal distribution with given mean and standard deviation, that is the probability for values up to the given one.

    float *mean*
    : - Mean value of the distribution

    float *stdev*
    : - Standard deviation of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-lognormal** *mean* *stdev* *value*
: Return the cumulative probability of a given value for a log-normal distribution with given mean and standard deviation, that is the probability for values up to the given one.

    float *mean*
    : - Mean value of the distribution

    float *stdev*
    : - Standard deviation of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-exponential** *mean* *value*
: Return the cumulative probability of a given value for an exponential distribution with given mean.

    float *mean*
    : - Mean value of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-uniform** *xmin* *xmax* *value*
: Return the cumulative probability of a given value for a uniform distribution with given extremes.

    float *xmin*
    : - Minimum value of the distribution

    float *xmin*
    : - Maximum value of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-triangular** *xmin* *xmax* *value*
: Return the cumulative probability of a given value for a triangular distribution with given extremes. If xmin < xmax, then lower values have a higher probability and vice versa, see also *pdf-triangular*

    float *xmin*
    : - Minimum value of the distribution

    float *xmin*
    : - Maximum value of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-symmetric-triangular** *xmin* *xmax* *value*
: Return the cumulative probability of a given value for a symmetric triangular distribution with given extremes.

    float *xmin*
    : - Minimum value of the distribution

    float *xmin*
    : - Maximum value of the distribution

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-students-t** *degrees* *value*
: Return the cumulative probability of a given value for a Student's t distribution with given number of degrees.

    int *degrees*
    : - Number of degrees of freedom

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-gamma** *alpha* *beta* *value*
: Return the cumulative probability of a given value for a Gamma distribution with given shape and rate parameters.

    float *alpha*
    : - Shape parameter

    float *beta*
    : - Rate parameter

    float *value*
    : - Value for which the cumulative probability is required


**::math::statistics::cdf-poisson** *mu* *k*
: Return the cumulative probability of a given number of occurrences in the same interval (k) for a Poisson distribution with given mean (mu).

    float *mu*
    : - Mean number of occurrences

    int *k*
    : - Number of occurences


**::math::statistics::cdf-beta** *a* *b* *value*
: Return the cumulative probability of a given value for a Beta distribution with given shape parameters

    float *a*
    : - First shape parameter

    float *b*
    : - Second shape parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-weibull** *scale* *shape* *value*
: Return the cumulative probability of a given value for a Weibull distribution with given scale and shape parameters.

    float *scale*
    : - Scale parameter

    float *shape*
    : - Shape parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-gumbel** *location* *scale* *value*
: Return the cumulative probability of a given value for a Gumbel distribution with given location and scale parameters.

    float *location*
    : - Location parameter

    float *scale*
    : - Scale parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-pareto** *scale* *shape* *value*
: Return the cumulative probability of a given value for a Pareto distribution with given scale and shape parameters

    float *scale*
    : - Scale parameter

    float *shape*
    : - Shape parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-cauchy** *location* *scale* *value*
: Return the cumulative probability of a given value for a Cauchy distribution with given location and scale parameters.

    float *location*
    : - Location parameter

    float *scale*
    : - Scale parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-F** *nf1* *nf2* *value*
: Return the cumulative probability of a given value for an F distribution with nf1 and nf2 degrees of freedom.

    float *nf1*
    : - Degrees of freedom for the numerator

    float *nf2*
    : - Degrees of freedom for the denominator

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-laplace** *location* *scale* *value*
: Return the cumulative probability of a given value for a Laplace distribution with given location and shape parameters. The Laplace distribution consists of two exponential functions, is peaked and has heavier tails than the normal distribution.

    float *location*
    : - Location parameter (mean)

    float *scale*
    : - Shape parameter

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-kumaraswamy** *a* *b* *value*
: Return the cumulative probability of a given value for a Kumaraswamy distribution with given parameters a and b. The Kumaraswamy distribution is related to the Beta distribution, but has a tractable cumulative distribution function.

    float *a*
    : - Parameter a

    float *b*
    : - Parameter b

    float *value*
    : - Value for which the probability is required


**::math::statistics::cdf-negative-binomial** *r* *p* *value*
: Return the cumulative probability of a given value for a negative binomial distribution with an allowed number of failures and the probability of success.

    int *r*
    : - Allowed number of failures (at least 1)

    float *p*
    : - Probability of success

    int *value*
    : - Greatest number of successes


**::math::statistics::empirical-distribution** *values*
: Return a list of values and their empirical probability. The values are sorted in increasing order. (The implementation follows the description at the corresponding Wikipedia page)

    list *values*
    : - List of data to be examined


**::math::statistics::random-normal** *mean* *stdev* *number*
: Return a list of "number" random values satisfying a normal distribution with given mean and standard deviation.

    float *mean*
    : - Mean value of the distribution

    float *stdev*
    : - Standard deviation of the distribution

    int *number*
    : - Number of values to be returned


**::math::statistics::random-lognormal** *mean* *stdev* *number*
: Return a list of "number" random values satisfying a log-normal distribution with given mean and standard deviation.

    float *mean*
    : - Mean value of the distribution

    float *stdev*
    : - Standard deviation of the distribution

    int *number*
    : - Number of values to be returned


**::math::statistics::random-exponential** *mean* *number*
: Return a list of "number" random values satisfying an exponential distribution with given mean.

    float *mean*
    : - Mean value of the distribution

    int *number*
    : - Number of values to be returned


**::math::statistics::random-uniform** *xmin* *xmax* *number*
: Return a list of "number" random values satisfying a uniform distribution with given extremes.

    float *xmin*
    : - Minimum value of the distribution

    float *xmax*
    : - Maximum value of the distribution

    int *number*
    : - Number of values to be returned


**::math::statistics::random-triangular** *xmin* *xmax* *number*
: Return a list of "number" random values satisfying a triangular distribution with given extremes. If xmin < xmax, then lower values have a higher probability and vice versa (see also *pdf-triangular*.

    float *xmin*
    : - Minimum value of the distribution

    float *xmax*
    : - Maximum value of the distribution

    int *number*
    : - Number of values to be returned


**::math::statistics::random-symmetric-triangular** *xmin* *xmax* *number*
: Return a list of "number" random values satisfying a symmetric triangular distribution with given extremes.

    float *xmin*
    : - Minimum value of the distribution

    float *xmax*
    : - Maximum value of the distribution

    int *number*
    : - Number of values to be returned


**::math::statistics::random-gamma** *alpha* *beta* *number*
: Return a list of "number" random values satisfying a Gamma distribution with given shape and rate parameters.

    float *alpha*
    : - Shape parameter

    float *beta*
    : - Rate parameter

    int *number*
    : - Number of values to be returned


**::math::statistics::random-poisson** *mu* *number*
: Return a list of "number" random values satisfying a Poisson distribution with given mean.

    float *mu*
    : - Mean of the distribution

    int *number*
    : - Number of values to be returned


**::math::statistics::random-chisquare** *df* *number*
: Return a list of "number" random values satisfying a chi square distribution with given degrees of freedom.

    float *df*
    : - Degrees of freedom

    int *number*
    : - Number of values to be returned


**::math::statistics::random-student-t** *df* *number*
: Return a list of "number" random values satisfying a Student's t distribution with given degrees of freedom.

    float *df*
    : - Degrees of freedom

    int *number*
    : - Number of values to be returned


**::math::statistics::random-beta** *a* *b* *number*
: Return a list of "number" random values satisfying a Beta distribution with given shape parameters.

    float *a*
    : - First shape parameter

    float *b*
    : - Second shape parameter

    int *number*
    : - Number of values to be returned


**::math::statistics::random-weibull** *scale* *shape* *number*
: Return a list of "number" random values satisfying a Weibull distribution with given scale and shape parameters.

    float *scale*
    : - Scale parameter

    float *shape*
    : - Shape parameter

    int *number*
    : - Number of values to be returned


**::math::statistics::random-gumbel** *location* *scale* *number*
: Return a list of "number" random values satisfying a Gumbel distribution with given location and scale parameters.

    float *location*
    : - Location parameter

    float *scale*
    : - Scale parameter

    int *number*
    : - Number of values to be returned


**::math::statistics::random-pareto** *scale* *shape* *number*
: Return a list of "number" random values satisfying a Pareto distribution with given scale and shape parameters.

    float *scale*
    : - Scale parameter

    float *shape*
    : - Shape parameter

    int *number*
    : - Number of values to be returned


**::math::statistics::random-cauchy** *location* *scale* *number*
: Return a list of "number" random values satisfying a Cauchy distribution with given location and scale parameters.

    float *location*
    : - Location parameter

    float *scale*
    : - Scale parameter

    int *number*
    : - Number of values to be returned


**::math::statistics::random-laplace** *location* *scale* *number*
: Return a list of "number" random values satisfying a Laplace distribution with given location and shape parameters. The Laplace distribution consists of two exponential functions, is peaked and has heavier tails than the normal distribution.

    float *location*
    : - Location parameter (mean)

    float *scale*
    : - Shape parameter

    int *number*
    : - Number of values to be returned


**::math::statistics::random-kumaraswamy** *a* *b* *number*
: Return a list of "number" random values satisying a Kumaraswamy distribution with given parameters a and b. The Kumaraswamy distribution is related to the Beta distribution, but has a tractable cumulative distribution function.

    float *a*
    : - Parameter a

    float *b*
    : - Parameter b

    int *number*
    : - Number of values to be returned


**::math::statistics::random-negative-binomial** *r* *p* *number*
: Return a list of "number" random values satisying a negative binomial distribution.

    int *r*
    : - Allowed number of failures (at least 1)

    float *p*
    : - Probability of success

    int *number*
    : - Number of values to be returned


**::math::statistics::histogram-uniform** *xmin* *xmax* *limits* *number*
: Return the expected histogram for a uniform distribution.

    float *xmin*
    : - Minimum value of the distribution

    float *xmax*
    : - Maximum value of the distribution

    list *limits*
    : - Upper limits for the buckets in the histogram

    int *number*
    : - Total number of "observations" in the histogram


**::math::statistics::incompleteGamma** *x* *p* ?tol?
: Evaluate the incomplete Gamma integral

    ```
                        1       / x               p-1
          P(p,x) =  --------   |   dt exp(-t) * t
                    Gamma(p)  / 0
    ```

    float *x*
    : - Value of x (limit of the integral)

    float *p*
    : - Value of p in the integrand

    float *tol*
    : - Required tolerance (default: 1.0e-9)


**::math::statistics::incompleteBeta** *a* *b* *x* ?tol?
: Evaluate the incomplete Beta integral

    float *a*
    : - First shape parameter

    float *b*
    : - Second shape parameter

    float *x*
    : - Value of x (limit of the integral)

    float *tol*
    : - Required tolerance (default: 1.0e-9)


**::math::statistics::estimate-pareto** *values*
: Estimate the parameters for the Pareto distribution that comes closest to the given values. Returns the estimated scale and shape parameters, as well as the standard error for the shape parameter.

    list *values*
    : - List of values, assumed to be distributed according to a Pareto distribution


**::math::statistics::estimate-exponential** *values*
: Estimate the parameter for the exponential distribution that comes closest to the given values. Returns an estimate of the one parameter and of the standard error.

    list *values*
    : - List of values, assumed to be distributed according to an exponential distribution


**::math::statistics::estimate-laplace** *values*
: Estimate the parameters for the Laplace distribution that comes closest to the given values. Returns an estimate of respectively the location and scale parameters, based on maximum likelihood.

    list *values*
    : - List of values, assumed to be distributed according to an exponential distribution


**::math::statistics::estimante-negative-binomial** *r* *values*
: Estimate the probability of success for the negative binomial distribution that comes closest to the given values. The allowed number of failures must be given.

    int *r*
    : - Allowed number of failures (at least 1)

    int *number*
    : - List of values, assumed to be distributed according to a negative binomial distribution.



TO DO: more function descriptions to be added

# Data manipulation

The data manipulation procedures act on lists or lists of lists:

**::math::statistics::filter** *varname* *data* *expression*
: Return a list consisting of the data for which the logical expression is true (this command works analogously to the command **foreach**).

    string *varname*
    : - Name of the variable used in the expression

    list *data*
    : - List of data

    string *expression*
    : - Logical expression using the variable name


**::math::statistics::map** *varname* *data* *expression*
: Return a list consisting of the data that are transformed via the expression.

    string *varname*
    : - Name of the variable used in the expression

    list *data*
    : - List of data

    string *expression*
    : - Expression to be used to transform (map) the data


**::math::statistics::samplescount** *varname* *list* *expression*
: Return a list consisting of the *counts* of all data in the sublists of the "list" argument for which the expression is true.

    string *varname*
    : - Name of the variable used in the expression

    list *data*
    : - List of sublists, each containing the data

    string *expression*
    : - Logical expression to test the data (defaults to "true").


**::math::statistics::subdivide**
: Routine *PM* - not implemented yet


# Plot procedures

The following simple plotting procedures are available:

**::math::statistics::plot-scale** *canvas* *xmin* *xmax* *ymin* *ymax*
: Set the scale for a plot in the given canvas. All plot routines expect this function to be called first. There is no automatic scaling provided.

    widget *canvas*
    : - Canvas widget to use

    float *xmin*
    : - Minimum x value

    float *xmax*
    : - Maximum x value

    float *ymin*
    : - Minimum y value

    float *ymax*
    : - Maximum y value


**::math::statistics::plot-xydata** *canvas* *xdata* *ydata* *tag*
: Create a simple XY plot in the given canvas - the data are shown as a collection of dots. The tag can be used to manipulate the appearance.

    widget *canvas*
    : - Canvas widget to use

    float *xdata*
    : - Series of independent data

    float *ydata*
    : - Series of dependent data

    string *tag*
    : - Tag to give to the plotted data (defaults to xyplot)


**::math::statistics::plot-xyline** *canvas* *xdata* *ydata* *tag*
: Create a simple XY plot in the given canvas - the data are shown as a line through the data points. The tag can be used to manipulate the appearance.

    widget *canvas*
    : - Canvas widget to use

    list *xdata*
    : - Series of independent data

    list *ydata*
    : - Series of dependent data

    string *tag*
    : - Tag to give to the plotted data (defaults to xyplot)


**::math::statistics::plot-tdata** *canvas* *tdata* *tag*
: Create a simple XY plot in the given canvas - the data are shown as a collection of dots. The horizontal coordinate is equal to the index. The tag can be used to manipulate the appearance. This type of presentation is suitable for autocorrelation functions for instance or for inspecting the time-dependent behaviour.

    widget *canvas*
    : - Canvas widget to use

    list *tdata*
    : - Series of dependent data

    string *tag*
    : - Tag to give to the plotted data (defaults to xyplot)


**::math::statistics::plot-tline** *canvas* *tdata* *tag*
: Create a simple XY plot in the given canvas - the data are shown as a line. See plot-tdata for an explanation.

    widget *canvas*
    : - Canvas widget to use

    list *tdata*
    : - Series of dependent data

    string *tag*
    : - Tag to give to the plotted data (defaults to xyplot)


**::math::statistics::plot-histogram** *canvas* *counts* *limits* *tag*
: Create a simple histogram in the given canvas

    widget *canvas*
    : - Canvas widget to use

    list *counts*
    : - Series of bucket counts

    list *limits*
    : - Series of upper limits for the buckets

    string *tag*
    : - Tag to give to the plotted data (defaults to xyplot)



# Things to do

The following procedures are yet to be implemented:

- F-test-stdev

- interval-mean-stdev

- histogram-normal

- histogram-exponential

- test-histogram

- test-corr

- quantiles-\*

- fourier-coeffs

- fourier-residuals

- onepar-function-fit

- onepar-function-residuals

- plot-linear-model

- subdivide


# Examples

The code below is a small example of how you can examine a set of data:

```
# Simple example:
# - Generate data (as a cheap way of getting some)
# - Perform statistical analysis to describe the data
#
package require math::statistics

#
# Two auxiliary procs
#
proc pause {time} {
   set wait 0
   after [expr {$time*1000}] {set ::wait 1}
   vwait wait
}

proc print-histogram {counts limits} {
   foreach count $counts limit $limits {
      if { $limit != {} } {
         puts [format "<%12.4g\t%d" $limit $count]
         set prev_limit $limit
      } else {
         puts [format ">%12.4g\t%d" $prev_limit $count]
      }
   }
}

#
# Our source of arbitrary data
#
proc generateData { data1 data2 } {
   upvar 1 $data1 _data1
   upvar 1 $data2 _data2

   set d1 0.0
   set d2 0.0
   for { set i 0 } { $i < 100 } { incr i } {
      set d1 [expr {10.0-2.0*cos(2.0*3.1415926*$i/24.0)+3.5*rand()}]
      set d2 [expr {0.7*$d2+0.3*$d1+0.7*rand()}]
      lappend _data1 $d1
      lappend _data2 $d2
   }
   return {}
}

#
# The analysis session
#
package require Tk
console show
canvas .plot1
canvas .plot2
pack   .plot1 .plot2 -fill both -side top

generateData data1 data2

puts "Basic statistics:"
set b1 [::math::statistics::basic-stats $data1]
set b2 [::math::statistics::basic-stats $data2]
foreach label {mean min max number stdev var} v1 $b1 v2 $b2 {
   puts "$label\t$v1\t$v2"
}
puts "Plot the data as function of \"time\" and against each other"
::math::statistics::plot-scale .plot1  0 100  0 20
::math::statistics::plot-scale .plot2  0 20   0 20
::math::statistics::plot-tline .plot1 $data1
::math::statistics::plot-tline .plot1 $data2
::math::statistics::plot-xydata .plot2 $data1 $data2

puts "Correlation coefficient:"
puts [::math::statistics::corr $data1 $data2]

pause 2
puts "Plot histograms"
.plot2 delete all
::math::statistics::plot-scale .plot2  0 20 0 100
set limits         [::math::statistics::minmax-histogram-limits 7 16]
set histogram_data [::math::statistics::histogram $limits $data1]
::math::statistics::plot-histogram .plot2 $histogram_data $limits

puts "First series:"
print-histogram $histogram_data $limits

pause 2
set limits         [::math::statistics::minmax-histogram-limits 0 15 10]
set histogram_data [::math::statistics::histogram $limits $data2]
::math::statistics::plot-histogram .plot2 $histogram_data $limits d2
.plot2 itemconfigure d2 -fill red

puts "Second series:"
print-histogram $histogram_data $limits

puts "Autocorrelation function:"
set  autoc [::math::statistics::autocorr $data1]
puts [::math::statistics::map $autoc {[format "%.2f" $x]}]
puts "Cross-correlation function:"
set  crossc [::math::statistics::crosscorr $data1 $data2]
puts [::math::statistics::map $crossc {[format "%.2f" $x]}]

::math::statistics::plot-scale .plot1  0 100 -1  4
::math::statistics::plot-tline .plot1  $autoc "autoc"
::math::statistics::plot-tline .plot1  $crossc "crossc"
.plot1 itemconfigure autoc  -fill green
.plot1 itemconfigure crossc -fill yellow

puts "Quantiles: 0.1, 0.2, 0.5, 0.8, 0.9"
puts "First:  [::math::statistics::quantiles $data1 {0.1 0.2 0.5 0.8 0.9}]"
puts "Second: [::math::statistics::quantiles $data2 {0.1 0.2 0.5 0.8 0.9}]"
```

If you run this example, then the following should be clear:

- There is a strong correlation between two time series, as displayed by the raw data and especially by the correlation functions.

- Both time series show a significant periodic component

- The histograms are not very useful in identifying the nature of the time series - they do not show the periodic nature.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: statistics* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics
