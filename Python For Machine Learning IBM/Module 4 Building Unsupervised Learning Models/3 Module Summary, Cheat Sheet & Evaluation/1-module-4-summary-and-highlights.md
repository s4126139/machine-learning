# Module 4 Summary and Highlights

## Core ideas

- Clustering explores unlabeled observations by grouping them under a chosen feature representation and distance measure. The answer depends on those choices.
- **K-Means** minimizes within-cluster squared distance around K centroids. It is efficient for compact, similarly scaled groups but needs K and assigns all observations.
- **DBSCAN** grows clusters from dense neighborhoods and marks sparse observations as noise. It handles curved shapes but needs a suitable eps and works best when densities are comparable.
- **HDBSCAN** examines density across scales and selects stable groups. It can handle varying density better than a single DBSCAN radius, while still requiring meaningful minimum-size and density settings.
- **Agglomerative** clustering merges small groups into a hierarchy; **divisive** clustering splits larger groups. A dendrogram shows nested relationships, and linkage defines what “closest groups” means.
- **PCA** compresses along linear directions of high variance. **t-SNE** emphasizes local neighbors for visualization. **UMAP** builds a neighborhood graph and produces a low-dimensional embedding. None should be mistaken for cluster labels.
- Feature clustering can expose redundant columns; inspect groups and fit selection only on training data when it supports prediction.

![Clustering and dimensionality-reduction decision map](../../assets/module-4-clustering-and-dimensionality-roadmap.svg)

## Practical order of work

1. State what counts as similarity and exclude targets, IDs, and future information.
2. Clean, encode, and scale the feature matrix appropriately.
3. Choose candidate algorithms from data geometry and whether noise / cluster count matters.
4. Tune only on training data; compare internal metrics, stability, group profiles, and domain usefulness.
5. Record preprocessing, parameters, noise handling, limitations, and how the result will be used.

## Questions to revisit

- What does an unsupervised algorithm actually optimize?
- Are cluster shapes, densities, and scales plausible for the chosen method?
- Would a different distance or feature set change the interpretation?
- Is a low-dimensional picture being used only as a diagnostic?