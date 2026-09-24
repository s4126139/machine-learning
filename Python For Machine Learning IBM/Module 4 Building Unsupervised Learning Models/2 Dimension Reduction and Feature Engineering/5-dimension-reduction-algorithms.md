# Dimensionality Reduction Algorithms: PCA, t-SNE, and UMAP

## Purpose

Dimensionality reduction maps data with many features into fewer coordinates. The new coordinates may support compression, denoising, faster modeling, or visualization. Every method trades off information: inspect what it preserves and what it distorts.

![How to read and use common dimensionality-reduction methods](../../assets/module-4-clustering-and-dimensionality-roadmap.svg)

## PCA: linear variance compression

Principal Component Analysis (PCA) finds orthogonal directions that capture the largest variance. The first component captures the most variance, the next captures the most remaining variance subject to orthogonality, and so on. Keeping the first few components yields a compact linear projection.

- **Objective:** retain as much total variance as possible in a lower-dimensional linear subspace.
- **Assumption / fit:** useful when important structure is approximately linear. PCA is unsupervised and does not know which directions predict a target.
- **Scale:** standardize features when units or ranges should contribute comparably. If variance magnitude is meaningful and units are comparable, scaling may change the intended analysis.
- **Choose dimension:** inspect individual and cumulative explained_variance_ratio_; validate the downstream task and reconstruction quality.
- **Strengths:** often fast, compresses correlated features, and offers interpretable variance accounting. Full SVD is deterministic; randomized SVD uses randomness, so set `random_state` when repeatability matters.
- **Limitations:** only linear projections; maximum variance may not equal maximum task relevance; components are combinations of original variables.

    from sklearn.decomposition import PCA
    from sklearn.preprocessing import StandardScaler

    X_scaled = StandardScaler().fit_transform(X)
    pca = PCA(n_components=0.95, svd_solver="full")
    X_pca = pca.fit_transform(X_scaled)
    print(pca.explained_variance_ratio_.sum())

## t-SNE: local-neighborhood visualization

t-distributed Stochastic Neighbor Embedding (t-SNE) maps nearby high-dimensional samples to nearby points in a small space, commonly 2D. It emphasizes local neighborhoods and is often useful for exploring images, text embeddings, or other complex data.

- perplexity, initialization, learning rate, and random seed affect the result; compare multiple plausible settings.
- Global distances, apparent cluster sizes, and gaps between separate islands are not reliable measures of original-space distances.
- It is relatively expensive and sensitive to tuning. Standard scikit-learn t-SNE is primarily a visualization tool and does not provide a general out-of-sample transform for new points.

    from sklearn.manifold import TSNE

    embedding = TSNE(
        n_components=2, perplexity=30, init="pca",
        learning_rate="auto", random_state=42
    ).fit_transform(X_scaled)

## UMAP: graph-based manifold embedding

Uniform Manifold Approximation and Projection (UMAP) constructs a weighted graph of neighboring observations and seeks a lower-dimensional graph with similar local relationships. It often preserves local neighborhoods and some broader structure while scaling well in many practical settings.

- n_neighbors controls the neighborhood scale: smaller values emphasize local structure; larger values consider broader neighborhoods.
- min_dist controls how tightly points can pack in the embedding; it changes visual compactness, not proof of cluster separation.
- Results depend on preprocessing and parameters. Use the same feature representation when comparing embeddings. UMAP is commonly provided by the separate umap-learn package (import umap), not by scikit-learn itself.

    import umap

    embedding = umap.UMAP(
        n_components=2, n_neighbors=15, min_dist=0.1, random_state=42
    ).fit_transform(X_scaled)

## Choosing among them

| Need | A reasonable first choice | Why / caveat |
| --- | --- | --- |
| Linear compression, denoising, variance accounting | PCA | Records explained variance; can miss nonlinear manifolds. |
| Inspect local neighborhoods in 2D | t-SNE | Strong local emphasis; global map geometry is unreliable. |
| Explore local structure at scale and broader arrangement | UMAP | Flexible graph embedding; visual distances still need care. |

A simulated blob dataset may separate well under PCA when its main differences are linear mean shifts. t-SNE can make nearby groups look like separated islands, while UMAP may preserve more of their connected arrangement. Such a plot compares embeddings, not the discovery of known labels. Color by known labels only after keeping those labels out of the unsupervised fit.

## Official references

- [scikit-learn PCA API](https://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html)
- [scikit-learn t-SNE API](https://scikit-learn.org/stable/modules/generated/sklearn.manifold.TSNE.html)
- [UMAP parameter guide](https://umap-learn.readthedocs.io/en/latest/parameters.html)

## Evaluation and pitfalls

- For PCA, report cumulative explained variance or reconstruction error.
- For t-SNE / UMAP, assess neighborhood preservation, stability across seeds/settings, and usefulness for the intended visualization.
- If clustering is the goal, compare clustering in the original scaled space and in the reduced space; validate the resulting groups independently.
- Fit the reducer on training data only in a predictive workflow. Do not fit on the whole dataset before splitting.

## Recall questions

1. Which information does PCA optimize, and what does it ignore?
2. Why can’t the distance between t-SNE islands be interpreted like the original distance?
3. What do UMAP n_neighbors and min_dist influence?
4. Which evaluation would you use to decide how many PCA components to keep?
