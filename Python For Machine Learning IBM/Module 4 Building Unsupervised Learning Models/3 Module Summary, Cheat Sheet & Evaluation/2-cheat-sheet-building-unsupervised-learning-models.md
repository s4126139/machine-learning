# Cheat Sheet: Building Unsupervised Learning Models

![Quick map of clustering families and dimensionality-reduction tools](../../assets/module-4-clustering-and-dimensionality-roadmap.svg)

## Choose a method

| Method | Set first | Best fit | Main caution |
| --- | --- | --- | --- |
| K-Means | n_clusters | Compact, convex groups with comparable scale | Sensitive to outliers, scaling, and K |
| DBSCAN | eps, min_samples | Irregular shapes, noise, similar densities | One radius can fail for varied densities |
| HDBSCAN | min_cluster_size, optional min_samples | Unequal densities and explicit noise handling | Still parameter-sensitive; groups can be labeled noise |
| Agglomerative | linkage, metric, cluster count / cut | Nested structure and dendrogram exploration | Linkage changes the tree; larger datasets cost more |

## Compact decision rules

- Need a center-based partition and can justify K? Try K-Means.
- Expect curved groups or meaningful outliers? Try DBSCAN.
- Expect substantial density variation? Try HDBSCAN.
- Need to inspect nested merging? Try agglomerative clustering.
- Need fewer linear coordinates with variance accounting? Try PCA.
- Need a 2D local-neighborhood view? Compare t-SNE and UMAP; don't infer global distances from either.

## Useful checks

- Scale features when units otherwise dominate distance.
- K-Means: compare inertia plus silhouette / Davies–Bouldin, and inspect cluster sizes.
- Density methods: report noise fraction and cluster sizes; vary settings and inspect stability.
- Hierarchical: inspect dendrogram with a documented linkage.
- Dimensionality reduction: use PCA explained variance / reconstruction; use neighborhood checks and repeated embeddings for nonlinear visualization.
- Validate usefulness with domain profiles and resampling, not appearance alone.

## Common API pattern

    labels = estimator.fit_predict(X_preprocessed)

For a prediction workflow, put scaling, reduction, feature selection, and the downstream estimator inside a pipeline fitted independently in each cross-validation fold.