# Evaluating Unsupervised Learning Models

## Why evaluation is different

Clustering and dimensionality reduction usually have no target labels to compare with. Evaluation therefore asks whether a discovered structure is compact, separated, stable, useful, and consistent with domain knowledge. No single score proves that clusters are real. Combine metrics, repeated fits, visual inspection, and expert review.

## Internal clustering measures

These use features and assignments, not known class labels.

- **Silhouette coefficient:** for each point, compares average distance to its own cluster (a) with average distance to the nearest other cluster (b): (b − a) / max(a, b). Values range from -1 to 1; higher suggests better separation and cohesion. Negative values suggest questionable assignments. It is most meaningful with distance geometry that supports compact, separated groups and requires at least two clusters.
- **Davies–Bouldin index:** average similarity of each cluster to its most similar other cluster based on within-cluster spread and between-cluster distance. Lower is better.
- **Inertia:** K-Means within-cluster sum of squared distances. Lower means more compact under that objective, but increasing K always lowers it; compare across K rather than minimizing it blindly.

These metrics favor particular geometries. A high silhouette may reward compact, well-separated groups while undervaluing valid curved or varying-density clusters. For DBSCAN/HDBSCAN, explain whether and how noise points were excluded or treated; a noise label should not automatically be interpreted as one ordinary cluster.

## External measures when reference labels exist

Keep known labels out of fitting, then compare clusters to labels only for evaluation:

- **Adjusted Rand index (ARI):** pairwise agreement adjusted for chance. 1 is perfect agreement, about 0 is chance-level, and negative values are worse than chance.
- **Normalized mutual information (NMI):** shared information between assignments and reference labels, normalized to 0–1; higher means stronger association.
- **Fowlkes–Mallows score:** geometric mean of pairwise precision and recall; higher means more pairwise agreement.

Reference labels may not match the structure that matters for the task, so external metrics are evidence, not the final definition of usefulness.

## Stability and domain checks

Refit after changing the random seed, sampling a subset, or making small defensible preprocessing changes. Compare assignments or co-clustering rates; large changes mean the result is fragile. Inspect group sizes, representative examples, feature profiles, and whether a domain expert can explain what each group is used for. For customer segments, ask whether the segments are distinct and actionable—not merely colorful.

## Evaluating dimensionality reduction

- **PCA:** cumulative explained variance indicates variance retained; reconstruction error measures information lost when mapping down and reconstructing.
- **t-SNE / UMAP:** evaluate neighborhood preservation, stability across settings/seeds, and whether the intended visualization remains readable. Do not use apparent island spacing as a global distance measure.
- For downstream prediction or clustering, assess the full downstream task on held-out data. A low reconstruction error or attractive plot alone does not establish usefulness.

## scikit-learn examples

    from sklearn.metrics import (
        adjusted_rand_score, davies_bouldin_score,
        normalized_mutual_info_score, silhouette_score,
    )

    silhouette = silhouette_score(X_scaled, cluster_labels)
    db_index = davies_bouldin_score(X_scaled, cluster_labels)
    ari = adjusted_rand_score(reference_labels, cluster_labels)
    nmi = normalized_mutual_info_score(reference_labels, cluster_labels)

Use ARI/NMI only after fitting clusters without reference labels. Internal metrics require multiple clusters; remove or separately account for noise where appropriate. Scores are conditional on the chosen feature space and distance.

## Recall questions

1. Which metrics need reference labels and which do not?
2. Why does low K-Means inertia not identify the right K?
3. How would you check that a clustering is stable?
4. Why is a domain profile still useful when silhouette is high?