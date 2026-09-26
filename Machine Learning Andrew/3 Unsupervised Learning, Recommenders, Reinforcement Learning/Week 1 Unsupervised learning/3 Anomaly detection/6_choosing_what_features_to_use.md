# Choosing Features for Anomaly Detection

The quality of an anomaly detector depends heavily on its features. A feature
should vary in a way that helps distinguish normal behavior from an unusual
event. If every normal device has similar temperature but failures produce
extreme temperature, temperature can be informative. A feature that has nearly
the same distribution for both groups adds little signal.

## Inspect the distributions

Plot each feature for normal training examples. A Gaussian model works best
when the feature distribution is reasonably bell-shaped. Strong skew can make
the model assign scores poorly. A transform such as $\log(x)$ or $\sqrt{x}$
may make a positive, right-skewed measurement more symmetric; the transform
must also be applied consistently to validation, test, and future data.

## Use error analysis to improve the representation

Look at false negatives and false positives on validation data. Ask what
measurements, ratios, or combinations would make the unusual behavior visible.
For example, a raw count may be normal for a large machine but suspicious for
a small one; a rate or size-normalized feature may separate them better.

Adding a useful feature can help the independent Gaussian model identify
examples that were previously assigned a high score. Adding irrelevant or
strongly redundant features can instead add noise or violate the independence
approximation.

After changing features, refit all Gaussian parameters and retune $\epsilon$
on validation data. Do not repeatedly tune against the test set.
