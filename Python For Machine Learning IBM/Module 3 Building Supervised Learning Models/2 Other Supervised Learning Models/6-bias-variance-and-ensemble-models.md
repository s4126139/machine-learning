# Bias, Variance, and Ensemble Models

## The bias–variance picture

**Bias** is systematic error from a model that is too simple or makes restrictive assumptions. A high-bias model misses real structure and tends to underfit. **Variance** is sensitivity to the particular training sample: a high-variance model changes substantially when trained on another sample and tends to overfit. The dartboard intuition is useful: bias is distance from the center on average; variance is the spread of repeated results.

As model flexibility increases, training error usually falls. Validation error often falls at first, then rises when extra flexibility starts fitting noise. The best practical complexity is the region with good performance on unseen data, not necessarily the lowest training error. Some error is irreducible because observations contain noise or missing information.

![Model selection starting points for classification and regression](../../assets/module-3-model-selection.svg)

## Ensembles: combine learners to improve generalization

### Bagging and random forests

**Bootstrap aggregating (bagging)** trains multiple models on bootstrap samples (samples drawn with replacement) and averages numeric predictions or votes on classes. Training members can happen in parallel. Averaging diverse, high-variance learners—especially decision trees—usually reduces variance without dramatically increasing bias.

**Random forests** add random feature subsets to the bootstrap variation: at each split, a tree considers only a subset of features. This decorrelates trees, so their errors are less alike and averaging helps more. Trees can grow fairly deep; useful controls include `n_estimators`, `max_features`, `max_depth`, and `min_samples_leaf`. More trees reduce Monte Carlo noise but eventually add little benefit, while tree depth and leaf size affect fit and cost.

### Boosting

**Boosting** adds weak learners sequentially. Each stage concentrates on the current model's residual errors or loss gradient, and the final prediction is an additive combination. AdaBoost reweights difficult examples; gradient boosting follows the loss gradient. Boosting often reduces bias by building a richer predictor, though too many complex stages can overfit noisy data.

Useful controls include `n_estimators` (number of stages), `learning_rate` (contribution of each stage), and base learner complexity such as `max_depth` or `max_leaf_nodes`. A lower learning rate usually needs more stages. Tune these together with validation; “more estimators” is not always better.

## Scikit-learn pattern

```python
from sklearn.ensemble import RandomForestClassifier

forest = RandomForestClassifier(
    n_estimators=300,
    max_features="sqrt",
    min_samples_leaf=2,
    class_weight="balanced",
    random_state=42,
    n_jobs=-1,
)
forest.fit(X_train, y_train)
predictions = forest.predict(X_test)
```

Use `RandomForestRegressor` for continuous targets. For boosting, scikit-learn provides estimators such as `HistGradientBoostingClassifier` and `HistGradientBoostingRegressor`; gradient boosting implementations and exact controls differ. Include all preprocessing and tuning inside cross-validation so validation data does not influence training transforms.

## Example: choosing a remedy

Imagine a deep tree that scores almost perfectly on training rows but performs much worse on held-out rows. The gap suggests overfitting/high variance: limit tree depth, increase minimum leaf size, or replace it with a random forest. If both training and validation scores are poor, the model may have high bias or the features may not contain enough signal; improve useful inputs, permit more complexity, or test a boosting model. Confirm every adjustment with the same validation scheme.

## When each approach helps

| Symptom or need | Reasonable next experiment |
| --- | --- |
| Training and validation performance are both weak | Check labels/features and underfitting; test a more expressive model or informative features. |
| Training is strong but validation is weak | Reduce complexity, add regularization, gather data, or compare a bagged ensemble. |
| A single tree is unstable but nonlinear interactions matter | Try a random forest and inspect held-out performance. |
| A stronger additive fit is needed and tuning capacity is available | Try gradient boosting with a controlled learning rate and validation-based stopping/tuning. |

These are diagnostic hints, not guarantees. Bias and variance are properties of model plus data and evaluation setup, not labels permanently attached to an algorithm.

## Common pitfalls

- A “weak learner” is a learner only modestly better than a baseline under the relevant loss; weak does not automatically mean safe or unbiased.
- Bagging primarily reduces variance when the base models are diverse. Identical, highly correlated learners gain little from averaging.
- Boosting can focus excessively on mislabeled points or outliers; use robust losses, restrained learners, and validation.
- Ensemble feature importance describes predictive association, not causal influence.
- Do not tune complexity against the final test set. Use cross-validation or a validation split, and evaluate once on an untouched test set.

## Active recall

1. How do bias and variance show up in training versus validation performance?
2. Why does averaging bootstrap-trained trees help a random forest generalize?
3. How do `learning_rate` and `n_estimators` interact in boosting?
