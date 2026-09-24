# Clustering, Dimensionality Reduction, and Feature Engineering

![A guide to clustering families and dimensionality-reduction methods](../../assets/module-4-clustering-and-dimensionality-roadmap.svg)

## How the ideas fit together

Clustering, dimensionality reduction, and feature engineering are related but solve different problems:

- **Clustering** assigns observations to groups based on their features.
- **Dimensionality reduction** constructs a smaller representation of those observations.
- **Feature engineering** selects, transforms, or combines variables to make a task’s signal easier to use.

A reduced representation can make distance calculations cheaper and may remove redundant or noisy directions. It can also discard useful information or distort geometry. “Fewer dimensions” is not automatically “better clustering.”

## A safe workflow

1. Define the observation and feature rows. Remove identifiers, target labels, and information unavailable at prediction time.
2. Impute missing values and scale or encode features to suit the distance measure.
3. Optionally fit PCA or another reduction method to training data. Choose dimension count using explained variance plus downstream validation, not a universal cutoff.
4. Cluster the representation and compare with clustering the original, appropriately scaled features.
5. Profile clusters back in original units. Check stability and whether domain experts can explain or use the differences.

PCA is a linear projection that finds directions of maximum variance; it is not a clustering method. t-SNE and UMAP make nonlinear low-dimensional embeddings that are often useful for visualization, but their 2D maps can distort distances. Do not assume visual blobs are robust clusters or cluster the visualization by default.

## Clustering features to identify redundancy

Clustering usually groups **rows (observations)**. For feature selection, instead cluster **columns (features)** using a meaningful feature-to-feature similarity, such as absolute correlation or similarity between standardized feature profiles. Then inspect each feature group and choose representatives based on measurement quality, interpretability, cost, and missingness.

This can reduce duplicated information, but correlated features are not necessarily interchangeable for every model or business use. If feature selection supports a supervised model, learn the groups and choose representatives using only each training fold. Otherwise the held-out data influences the chosen features.

A simple conceptual example is five features whose distributions are simulated from three centers with similar variance. If features 1–3 have nearly identical profiles, clustering columns can reveal a redundant group; features 4 and 5 may stand apart. The analysis must use feature profiles (or a feature-similarity matrix), not blindly run K-Means on the original observation rows and call the result feature selection.

## Case study: eigenfaces

A face-recognition workflow can represent each image as a high-dimensional pixel vector. PCA learns a compact basis of “eigenfaces” from training images; projecting faces onto the leading components reduces the input dimension. In the course example, 150 components were retained from 966 faces, then an SVM used those component scores for supervised identity prediction. PCA provides the compact representation; the SVM performs classification. Accuracy still needs evaluation on faces held out from every PCA fitting step.

## Benefits and cautions

- Fewer dimensions can reduce storage and computation and simplify plots.
- Removing redundant features may help distance-based methods.
- Reduction can discard low-variance directions that carry important target or subgroup information.
- A 2D plot is a diagnostic, not a substitute for quantitative evaluation.
- Refit preprocessing inside training folds to prevent leakage.

## Recall questions

1. How does feature clustering differ from observation clustering?
2. Why can PCA help K-Means, and what information might PCA remove?
3. Why should a 2D t-SNE or UMAP plot not be treated as proof of a true cluster?
4. At what stage should feature selection be fit in cross-validation?