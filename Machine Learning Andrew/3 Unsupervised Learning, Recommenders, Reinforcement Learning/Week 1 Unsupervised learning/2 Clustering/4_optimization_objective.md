# K-Means: The Optimization Objective

K-means aims to make each example close to the centroid of its assigned
cluster. Its within-cluster squared error is

$$
J(c^{(1)},\ldots,c^{(m)},\mu_1,\ldots,\mu_K)
=\frac{1}{m}\sum_{i=1}^{m}
\left\|x^{(i)}-\mu_{c^{(i)}}\right\|^2.
$$

Here $c^{(i)}$ selects the centroid for example $i$, and $m$ is the number of
examples. A smaller $J$ means the points lie closer to their assigned centers.

## Why the two steps reduce error

If the centroids are fixed, assigning each point to its nearest centroid gives
the smallest available distance for that point. If assignments are fixed,
setting each centroid to the mean of its assigned points minimizes the sum of
squared distances for that group. Thus each alternating step does not increase
the objective.

This does not guarantee the globally best clustering. The objective is
non-convex because assignments are discrete; different initial centers can
lead to different local minima. Run several initializations and retain the
valid result with the lowest objective.

## Interpreting the score

The value of $J$ depends on the units and number of features. It is useful for
comparing runs on the same transformed dataset, but it is not a universal score
for whether the groups are meaningful. Also, $J$ almost always drops when $K$
increases: with enough clusters, points can be made very close to a center.
That is why a low objective alone cannot choose $K$.
