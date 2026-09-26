# Choosing the Number of Clusters

K-means requires $K$, the number of clusters, as an input. There is no general
formula that always returns the one correct value because “useful groups”
depends on the application.

## Elbow method

Run K-means for several candidate values of $K$ and plot the objective $J$
against $K$. The objective decreases as more clusters are added. Look for a
point where the reduction starts to level off: adding clusters beyond that
point gives much smaller improvements. This bend is called the elbow.

The elbow is a heuristic. Some datasets have no clear bend, and the choice
depends on how much detail the downstream task needs. For customer segments,
for example, a business may prefer a small number of interpretable groups even
if a larger $K$ lowers $J$ further.

## Decide using the purpose

Ask what the clusters will be used for. If the goal is compression, reconstruction
error may matter. If the goal is human-facing segments, stability and
interpretability matter. If the groups feed another model, compare downstream
performance.

Use the elbow to narrow the candidates, then check that the resulting groups
are useful and reasonably stable. Do not choose the largest $K$ simply because
it produces the smallest training objective.
