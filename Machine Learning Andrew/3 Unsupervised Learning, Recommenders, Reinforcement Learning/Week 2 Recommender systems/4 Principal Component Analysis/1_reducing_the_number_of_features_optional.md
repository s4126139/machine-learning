# Reducing the Number of Features (Optional)

High-dimensional data can be expensive to store, visualize, and process. It
may also contain features that move together. Principal Component Analysis
(PCA) compresses the data into a smaller number of directions while preserving
as much variation as possible.

PCA is unsupervised: it uses the feature matrix $X$, not a target label $y$.
For two correlated measurements, many points may lie near a line. One new
coordinate along that line can preserve most of their variation; a second
coordinate perpendicular to it may add little.

Common uses include:

- visualizing data with many features in two or three dimensions;
- compressing data by storing fewer coordinates;
- reducing computation before a later algorithm, when the lost information is
  acceptable.

PCA finds directions of maximum variance. High variance is not automatically
the same as high predictive value, so PCA is not a substitute for
feature-selection reasoning. If labels matter, fit PCA using training data
only, then evaluate the downstream model on held-out data. Do not fit the
projection using validation or test examples.

Scale features before PCA when their units differ significantly. Otherwise,
one large-unit feature can dominate the variance calculation.
