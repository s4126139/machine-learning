# K-Means and Choosing K

## Intuition and objective

K-Means partitions observations into K non-overlapping clusters. Each point is assigned to its nearest centroid, and each centroid is the arithmetic mean of its assigned points. The algorithm tries to minimize the **within-cluster sum of squared distances**:

    J = sum over clusters k, then points x in cluster k, of ||x - centroid_k||^2

A centroid is a mean vector; it need not be an observed data point. K must be chosen before fitting.

## Algorithm

1. Choose K and initialize K centroids (K-Means++ is the common robust initialization).
2. Assign every observation to its nearest centroid under the selected distance.
3. Recompute each centroid as the mean of assigned observations.
4. Repeat assignment and update until assignments/centroids stop changing or the iteration limit is reached.
5. Because the objective can reach different local minima, run multiple initializations and compare their inertia.

Each iteration lowers or preserves the objective, but the final answer is not guaranteed to be the globally best partition.

## Assumptions, scaling, and failure cases

K-Means works best when groups are compact, roughly convex, and separated under Euclidean distance. It favors partitions around centers and is sensitive to outliers because squared distances give far-away points large influence. It struggles with interlocking or strongly non-convex shapes, unequal cluster sizes or densities, and features measured on very different scales.

Scale numeric features before fitting when units should contribute comparably. Do not scale identifiers or encode arbitrary categories as numeric distances. High-dimensional sparse data can make Euclidean distances less informative. If scaling, PCA, or feature selection is part of a predictive workflow, fit it inside each training fold.

## Choosing K

No metric can tell you the “true” K without task assumptions. Use several forms of evidence:

- **Elbow / inertia:** plot within-cluster sum of squares against K. Inertia always decreases as K increases; look for a useful bend, not the absolute minimum.
- **Silhouette:** compares a point’s average distance to its own cluster with its distance to the nearest other cluster. Values range from -1 to 1; higher is better separated on average. A negative value can indicate a poor assignment.
- **Davies–Bouldin index:** compares within-cluster spread with separation from other clusters; lower is better.
- Also check cluster sizes, stability across seeds or samples, and whether groups make practical sense.

A blob example illustrates the model’s geometry. With three compact, separated blobs and K=3, K-Means can recover the groups. If two blobs overlap heavily, increasing K cannot recover class information that the features do not contain. If K=2 for three blobs, one pair must be merged; if K is too large, a genuine group is split into smaller partitions.

## scikit-learn pattern

    from sklearn.cluster import KMeans
    from sklearn.pipeline import make_pipeline
    from sklearn.preprocessing import StandardScaler

    model = make_pipeline(
        StandardScaler(),
        KMeans(n_clusters=3, init="k-means++", n_init=10, random_state=42),
    )
    labels = model.fit_predict(X)

n_init runs independent initializations and keeps the best objective. random_state makes initialization reproducible. Select K by comparing candidates on training data or in a validation process; do not tune it against the final test set.

## Strengths and limitations

**Strengths:** simple objective, fast iterations, easy assignment to centers, useful for compact segments, and scalable to many samples.

**Limitations:** K is required; outliers and scale can dominate; the result depends on initialization; it forces every point into a cluster; and the geometry is poorly suited to curved or variable-density groups.

## Pitfalls and recall

Do not interpret cluster numbers as ordered categories. Do not compare raw inertia across datasets or different preprocessing. A lower inertia alone favors larger K.

1. What is the difference between a centroid and a medoid?
2. Why does inertia always improve when K increases?
3. How would scaling change a distance-based partition?
4. Which observed shape would make you try DBSCAN instead?