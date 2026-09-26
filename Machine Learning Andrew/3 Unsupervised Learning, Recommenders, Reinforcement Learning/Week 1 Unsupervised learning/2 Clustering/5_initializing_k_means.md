# Initializing K-Means

K-means needs starting centroids before it can assign points. A simple strategy
is to choose $K$ different training examples at random and use them as the
initial centers. The algorithm then alternates assignments and mean updates.

Different starts can produce different final clusters because the objective
has local minima. A practical approach is:

1. Run K-means from several random initializations.
2. Compute the within-cluster objective $J$ for each run.
3. Keep the run with the smallest $J$.

This is particularly useful when $K$ is small or moderate and rerunning the
algorithm is inexpensive. For very large datasets, the runtime cost of many
restarts may be significant, so use a smaller number of careful attempts.

Reproducibility also matters. Fix the random seed while debugging so that a
code change can be compared against the same initial centers. Once the
implementation is stable, test multiple seeds to see how much the result varies.

Repeated initialization reduces the chance of a poor solution; it does not
prove that the selected clusters are correct. Inspect the groups and validate
them against the task they are meant to support.
