# Anomaly Detection with Gaussian Features

For an example with $n$ features, fit a Gaussian distribution to each feature
using normal training data. With the simplifying assumption that the features
are independent, estimate the joint score as

$$
p(x)=\prod_{j=1}^{n}p(x_j;\mu_j,\sigma_j^2).
$$

The parameters $\mu_j$ and $\sigma_j^2$ are fitted separately for feature $j$.
An example receives a low score if one or more feature values are unusual
under the corresponding distributions. Classify it as anomalous when
$p(x)<\epsilon$.

## Algorithm outline

1. Choose numeric features that describe normal behavior and possible faults.
2. Estimate each feature's mean and variance from normal training examples.
3. Compute the product of feature densities for each validation example.
4. Select $\epsilon$ using labeled validation data, if available.
5. Flag new examples whose score is below the selected threshold.

The independence assumption is an approximation. Correlated features can make
the product model a poor description of the true joint distribution. A
multivariate Gaussian can model some correlations, but it has additional
constraints and is not always practical when the number of features is large
relative to the data.

In code, products of many small floating-point probabilities can underflow to
zero. A log score is numerically safer:

$$
\log p(x)=\sum_{j=1}^{n}\log p(x_j;\mu_j,\sigma_j^2).
$$

The threshold must be expressed on the same scale as the score being used.
