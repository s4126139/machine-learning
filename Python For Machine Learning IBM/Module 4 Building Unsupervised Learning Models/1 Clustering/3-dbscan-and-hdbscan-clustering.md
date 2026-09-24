# DBSCAN and HDBSCAN

## Core idea

Density-based clustering connects regions with many nearby observations. Unlike K-Means, it does not require a cluster count in advance, can find non-convex shapes such as two interlocking moons, and can leave isolated observations as noise.

DBSCAN labels points by local density:

- A **core point** has at least min_samples observations, including itself in scikit-learn, within distance eps.
- A **border point** is within the eps neighborhood of a core point but does not meet the density threshold itself.
- A **noise point** is not density-connected to a cluster. scikit-learn labels noise -1.

Clusters grow by following connected neighborhoods from core points. Border points do not expand the cluster. DBSCAN does not update centroids; its cluster shapes come from reachability through dense regions.

## Parameters and practical tuning

- eps is the neighborhood radius for the chosen distance metric. Too small: many points become noise or clusters fragment. Too large: separate regions merge.
- min_samples is the minimum local density. Larger values demand denser evidence and can classify more points as noise.
- Scale features before using Euclidean neighborhoods when units differ. For geographic coordinates, raw degree distance may be inappropriate over a large area; choose a distance metric and coordinate representation that match the problem.
- A k-distance plot can help suggest an eps range, but it is a diagnostic, not an automatic answer. Validate cluster sizes and domain meaning.

DBSCAN works best when clusters have reasonably similar density. One global eps can merge dense neighborhoods while fragmenting sparse ones.

## HDBSCAN: density across scales

HDBSCAN builds a hierarchy over varying density thresholds and selects persistent, stable groups. It can adapt better than DBSCAN when meaningful clusters have different densities. It still has parameters: min_cluster_size sets the smallest group worth retaining, while min_samples controls how conservative the density estimate is. Higher min_samples generally treats more borderline observations as noise.

The phrase “no eps required” is more accurate than “no parameters required.” HDBSCAN is still sensitive to feature scaling and to what minimum group size is meaningful. In scikit-learn, sklearn.cluster.HDBSCAN is available from version 1.3; older environments can use the separately installed hdbscan package, whose API and parameter conventions may differ.

## Example and strengths / limitations

For interlocking half-moons with a few stray points, K-Means imposes center-based boundaries; DBSCAN can follow each curved dense band and label strays as noise. If a sparse, valid moon is thinner than the chosen density threshold, DBSCAN can incorrectly fragment it. HDBSCAN may recover meaningful groups across a range of density levels, but it can still mark small valid groups as noise if the minimum group size is too high.

**Strengths:** arbitrary shapes, no preset K, explicit noise labeling, intuitive density parameters.

**Limitations:** distance scale is critical; DBSCAN assumes a useful global density threshold; HDBSCAN parameter meaning still requires judgment; high-dimensional distance can become uninformative; and neighborhood search can be memory intensive on dense data.

## scikit-learn patterns

    from sklearn.cluster import DBSCAN
    from sklearn.preprocessing import StandardScaler

    X_scaled = StandardScaler().fit_transform(X)
    dbscan = DBSCAN(eps=0.4, min_samples=6)
    labels = dbscan.fit_predict(X_scaled)

    # Available in scikit-learn 1.3+
    from sklearn.cluster import HDBSCAN
    hdbscan = HDBSCAN(min_cluster_size=8, min_samples=5)
    labels_hdbscan = hdbscan.fit_predict(X_scaled)

For validation, report the number of non-noise clusters, noise fraction, cluster sizes, stability, and domain examples. See the official [scikit-learn DBSCAN](https://scikit-learn.org/stable/modules/generated/sklearn.cluster.DBSCAN.html) and [HDBSCAN](https://scikit-learn.org/stable/modules/generated/sklearn.cluster.HDBSCAN.html) API references for version-specific details. Silhouette scores can be misleading when noise is included as an ordinary cluster; document how noise was handled.

## Recall questions

1. How do core, border, and noise points differ?
2. What failure pattern suggests eps is too small? Too large?
3. How does HDBSCAN help when cluster densities vary?
4. Why should the unit and scale of distance be written down?