# Regression Trees

## Core idea

A regression tree predicts a **continuous numeric target** by dividing feature space into regions. It uses the same rule-based structure as a classification tree, but it chooses splits based on numeric prediction error and returns a numeric summary at each leaf.

## How it learns and predicts

At each node, training considers candidate feature/threshold pairs. A candidate split sends rows to left and right child nodes. With the common squared-error criterion, the tree selects the split with the smallest weighted within-node squared error (equivalently, it seeks to reduce target variance). It continues recursively subject to its stopping rules.

For squared error, a leaf predicts the **mean** target value of its training rows. With absolute-error loss, the leaf prediction is the **median**. Candidate thresholds for a numeric feature lie between observed values; practical tree implementations search efficiently rather than checking every possible partition naively.

## Example: estimating monthly revenue

Suppose a retailer predicts monthly store revenue using store size, promotion status, and local foot traffic. The tree might split first on foot traffic, then split high-traffic stores by promotion status. Every new store follows those tests to a leaf and receives that leaf's typical revenue. Because a tree partitions the feature space into regions with constant predictions, it does not naturally extrapolate a rising trend beyond the values seen in training.

Other targets can include temperature, demand, salary, or a continuous risk estimate. If the task is to assign named risk bands (low/medium/high), that is classification instead.

## Scikit-learn pattern

```python
from sklearn.tree import DecisionTreeRegressor
from sklearn.metrics import mean_absolute_error

tree = DecisionTreeRegressor(
    criterion="squared_error", max_depth=5,
    min_samples_leaf=8, random_state=42
)
tree.fit(X_train, y_train)
predictions = tree.predict(X_test)
print(mean_absolute_error(y_test, predictions))
```

Common controls include `max_depth`, `min_samples_split`, `min_samples_leaf`, `max_leaf_nodes`, and `ccp_alpha`. Scikit-learn supports regression criteria including `squared_error`, `absolute_error`, and `poisson` (the last requires non-negative targets and is intended for count-like outcomes). Trees do not require feature scaling.

## When it works well

- The target changes at meaningful thresholds or depends on interactions among features.
- A piecewise-constant prediction is plausible and easy to communicate.
- The dataset is tabular and feature scales vary.
- A transparent nonlinear baseline is needed before testing ensembles.

## Assumptions, limitations, and pitfalls

- Greedy splits optimize local reductions in error; the full tree is not guaranteed globally optimal.
- Deep leaves with few observations fit noise. Use depth/leaf constraints and validation data.
- Piecewise-constant predictions create abrupt jumps and cannot extrapolate smooth trends beyond training regions.
- Squared error is sensitive to outliers; compare absolute error or transform a strongly skewed target when appropriate.
- A single tree may change substantially when training rows change. Random forests or boosting can improve predictive stability.
- Validate on data that reflects the future use case; random splitting can overstate performance for time-ordered or grouped observations.

## Active recall

1. How does a regression tree choose a split, and how does that differ from a classification tree?
2. Why does the default squared-error tree return a mean at each leaf?
3. What does it mean that a regression tree cannot extrapolate a trend naturally?
