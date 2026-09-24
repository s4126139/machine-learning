# K-Nearest Neighbors (KNN)

## Core idea

KNN predicts from nearby labeled examples: if two examples are close in feature space, the algorithm assumes they are likely to have similar targets. It can perform **classification** (neighbor vote) or **regression** (neighbor target average or median). KNN is a **lazy learner**: fitting mostly stores the training examples; most work happens when a prediction is requested.

## How it predicts

1. Choose the number of neighbors, `k`, and a distance metric.
2. Measure the query point's distance to training points and select the `k` closest.
3. For classification, return the most common neighbor class. For regression, aggregate neighbor targets. Distance weighting gives closer examples more influence.

A small `k` follows local details and is sensitive to noise; a large `k` smooths boundaries but can wash away small groups. The useful value depends on the data and should be selected using validation, not the test set.

## Scikit-learn pattern

Distance depends on scale, so scale numeric features inside a pipeline. `n_neighbors` is `k`; `weights="distance"` gives closer observations more voting influence; `metric` selects a distance calculation (the default Minkowski metric uses `p=2`, Euclidean distance).

```python
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsClassifier

model = make_pipeline(
    StandardScaler(),
    KNeighborsClassifier(n_neighbors=5, weights="distance")
)
model.fit(X_train, y_train)
predictions = model.predict(X_test)
```

Replace `KNeighborsClassifier` with `KNeighborsRegressor` for a numeric target. Use one-hot or other meaningful encodings for categorical variables: arbitrary integer codes imply a distance and order that may not exist.

## Example: classifying iris species

Represent each flower by measurements such as sepal length and petal width. A query flower is assigned the majority species among its nearest training flowers. With a small `k`, one unusual measurement may change the vote; with a larger `k`, the boundary becomes smoother. Scaling matters because measurements with larger numeric ranges would otherwise dominate the distance.

KNN is also useful as a simple local baseline when similar cases should have similar outcomes and the dataset is small enough that storing and searching the examples is practical.

## When it works well

- There are few to moderate numbers of informative, consistently scaled features.
- Nearby examples genuinely tend to share labels or numeric outcomes.
- The training set is small or moderate and prediction latency/memory are acceptable.
- A simple nonparametric baseline is useful for comparing against more structured models.

## Assumptions and common pitfalls

- Distance is meaningful only with sensible feature representations and scaling.
- Irrelevant or duplicated features distort neighborhoods; in high dimensions, distances become less informative (the curse of dimensionality).
- With imbalanced classes, majority voting can favor the common class; inspect class-wise metrics and consider distance weighting or class-aware approaches.
- A large `k` can underfit; a very small `k` can overfit. Tune it within cross-validation.
- Basic KNN may be expensive at prediction time because queries are compared with stored data; memory grows with training-set size.
- Missing values and categorical fields need preprocessing before distances can be computed.
- Do not choose `k` by repeatedly checking the held-out test score; use validation or cross-validation.

## Active recall

1. Why is KNN described as a lazy learner, and when does most of its computation happen?
2. How do small and large `k` values change the bias/variance behavior?
3. Why can one unscaled or irrelevant feature distort a neighborhood?
