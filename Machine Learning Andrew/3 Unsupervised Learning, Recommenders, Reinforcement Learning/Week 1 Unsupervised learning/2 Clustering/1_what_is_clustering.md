# What Is Clustering?

Clustering groups examples by similarity when the training set has no label
such as “cat,” “fraud,” or “customer type.” Each row is a feature vector
$x^{(i)}$; the algorithm proposes groups from the geometry of those vectors.

For example, a store may have customer rows containing annual spend and number
of visits. A clustering algorithm can reveal groups such as frequent shoppers
and occasional high spenders. The algorithm does not know those names; a person
interprets the groups afterward.

~~~mermaid
flowchart LR
  A[Unlabeled examples] --> B[Represent each example with features]
  B --> C[Group nearby examples]
  C --> D[Inspect and interpret the groups]
~~~

## Why this is unsupervised

In supervised learning, a target $y^{(i)}$ tells the model what answer to
predict. In clustering, only $x^{(i)}$ is available. There is therefore no
single “correct” cluster label to score against by default. The result depends
on the selected features, their scales, the chosen number of groups, and the
algorithm.

K-means is one common clustering method. It represents each group by a
centroid, assigns every example to its nearest centroid, and repeatedly moves
the centroids to the means of their assigned examples.

## Practical check

Feature scale matters. If annual spend ranges into the tens of thousands while
visit count ranges only from 0 to 100, raw Euclidean distance may mostly reflect
spend. Scale the features or choose a distance measure that matches the
application before interpreting the groups.
