# K-Means: The Algorithm

Let $x^{(i)}\in\mathbb{R}^n$ be example $i$, and let $\mu_k$ be the centroid
for cluster $k$. K-means alternates between assigning examples and updating
centroids.

## 1. Assign each example

For each example, find the nearest centroid:

$$
c^{(i)}=\underset{k\in\{1,\ldots,K\}}{\arg\min}\;
\left\|x^{(i)}-\mu_k\right\|^2.
$$

The cluster assignment $c^{(i)}$ is an integer from $1$ to $K$.

## 2. Recompute each centroid

For cluster $k$, average all examples assigned to it:

$$
\mu_k=\frac{1}{|C_k|}\sum_{i:c^{(i)}=k}x^{(i)},
$$

where $C_k$ is the set of examples currently assigned to $k$. The centroid is
an average feature vector; it need not be an actual training example.

Repeat the assignment and update steps until the assignments stop changing or
the centroids move very little. In practice, a maximum iteration count is also
used to guarantee that the loop ends.

## Edge cases

If no example is assigned to a centroid, its mean is undefined. Implementations
must decide how to handle an empty cluster, for example by reinitializing its
center or leaving it out of that update. The lesson is that a mathematically
simple algorithm still needs explicit handling for degenerate data and bad
initializations.

The algorithm is sensitive to feature scale and initialization. Standardize
features when their units differ substantially, and compare repeated runs
rather than trusting one random start.
