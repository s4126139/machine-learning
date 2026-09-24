# Cheat Sheet: Evaluating and Validating Machine Learning Models

![Compact reference for validation splits, metrics and leakage safeguards](../../assets/module-5-evaluation-and-validation-workflow.svg)

## Metric reference

| Task | Metric | Meaning / trade-off |
| --- | --- | --- |
| Classification | Accuracy = correct / total | Overall correctness; can hide rare-class failure. |
| Classification | Precision = TP / (TP + FP) | Reliability of positive predictions; penalizes false alarms. |
| Classification | Recall = TP / (TP + FN) | Fraction of positives found; penalizes misses. |
| Classification | F1 = 2PR / (P + R) | Harmonic balance of precision and recall; ignores TN. |
| Regression | MAE = mean(abs(error)) | Typical absolute miss in target units. |
| Regression | RMSE = sqrt(mean(error²)) | Same units; gives large errors extra weight. |
| Regression | R² = 1 − SSE/SST | Compared with a mean baseline; can be negative on test data. |
| Clustering | Silhouette | Higher tends to mean stronger cohesion/separation; geometry matters. |
| Clustering | Davies–Bouldin | Lower tends to mean compact, distinct groups. |
| Dimensionality reduction | PCA explained variance / reconstruction | Variance retained and reconstruction loss; neither proves task utility. |

For binary classification: TP = correctly predicted positive; FP = false alarm; FN = missed positive; TN = correctly predicted negative.

## Select the split

| Data structure | Validation approach |
| --- | --- |
| Independent classification, including imbalanced classes | Stratified train/test split and StratifiedKFold |
| Repeated records per person, site or device | Group-aware split; keep each group on one side |
| Ordered time series or future prediction | Chronological holdout and TimeSeriesSplit; never shuffle future into past |

## Keep the test set honest

- Fit imputation, scaling, encoding, feature selection, PCA, and the estimator inside one pipeline.
- Use cross-validation on training data to choose model, regularization, features, and classification threshold.
- Use nested CV if the dataset is too small for an untouched test set and an unbiased estimate of the whole tuning procedure is needed.
- Refit the selected pipeline on all training data; evaluate once on the reserved test set.
- Report the metric, split design, fold variation, test score, and important subgroup results.

## Regularization reminder

- Ridge: squared coefficient penalty; shrinks weights, usually keeps them nonzero.
- Lasso: absolute coefficient penalty; can set weights to zero, but correlated-feature selection can be unstable.
- Standardize predictors inside CV. In Ridge/Lasso, larger alpha means stronger penalty. In LogisticRegression, smaller C means stronger penalty.

## Leakage and interpretation checks

- Could every input feature be known at prediction time?
- Did test or future labels affect feature construction?
- Can the same entity or a duplicate cross the split?
- Did preprocessing see validation/test rows?
- Was the final test result used to choose anything afterward?
- Does feature importance describe predictive association only, or is a causal claim being made?

## Reporting template

- **Split:** [strategy and why]
- **Selection:** [cross-validation and pipeline steps]
- **Metric:** [name, positive class or units, and reason]
- **Result:** [fold mean/spread and final test score]
- **Limits:** [leakage risks, subgroup gaps, uncertainty, deployment assumptions]
