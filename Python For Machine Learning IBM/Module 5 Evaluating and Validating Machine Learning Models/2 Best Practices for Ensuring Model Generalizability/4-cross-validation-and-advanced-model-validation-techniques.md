# Cross-Validation and Advanced Model Validation

![Validation workflow and metric-selection quick guide](../../assets/module-5-evaluation-and-validation-workflow.svg)

## Keep tuning separate from final evaluation

A test set estimates performance after model choices are complete. If you repeatedly compare settings against test scores, you indirectly tune to the test set—data snooping—and the score becomes optimistic.

Use training data for fitting, validation data or cross-validation for choices, and a held-out test set for a final check. When data is limited, cross-validation lets each part of the training set serve as validation in turn.

## K-fold cross-validation

1. Split the training portion into K folds.
2. For each hyperparameter setting and each fold, fit on K−1 folds and score on the held-out fold.
3. Aggregate the K scores (mean plus variation) and select settings using the validation results.
4. Refit the selected pipeline on all available training data.
5. Evaluate once on a separate test set, if one was reserved.

Five- or ten-fold CV is common, but the right choice depends on data size and dependence structure. CV reduces dependence on one arbitrary split; it does not guarantee independence if observations are related or the split design is wrong.

## Match the split to the data

- **StratifiedKFold:** classification where each fold should preserve class proportions, especially with imbalance.
- **GroupKFold / GroupShuffleSplit:** repeated observations from the same person, household, device, or site must stay in one side of a split.
- **TimeSeriesSplit:** training observations precede validation observations. Do not shuffle ordered time series or let future data enter past features.
- For very small datasets, consider nested cross-validation when you need an estimate of the entire model-selection process without a large untouched test set. Inner folds tune; outer folds estimate the selected process.

A skewed regression target may benefit from log or Box–Cox transformation, but the transform must be fit within each training fold. A transformed-scale score answers a different question from error measured in original target units.

## Put preprocessing inside the fold

Any learned operation—imputation, scaling, feature selection, PCA, target encoding, or resampling—must be fit only on that fold’s training rows. A scikit-learn Pipeline helps enforce this boundary.

    from sklearn.decomposition import PCA
    from sklearn.model_selection import GridSearchCV, StratifiedKFold
    from sklearn.neighbors import KNeighborsClassifier
    from sklearn.pipeline import Pipeline
    from sklearn.preprocessing import StandardScaler

    pipe = Pipeline([
        ("scale", StandardScaler()),
        ("pca", PCA()),
        ("model", KNeighborsClassifier()),
    ])
    cv = StratifiedKFold(n_splits=5, shuffle=True, random_state=42)
    search = GridSearchCV(
        pipe,
        {"pca__n_components": [2, 3], "model__n_neighbors": [3, 5, 9]},
        cv=cv, scoring="f1_macro",
    )
    search.fit(X_train, y_train)
    test_predictions = search.best_estimator_.predict(X_test)

Choose scoring based on the task’s error costs, not convenience. GridSearchCV refits the best pipeline on all rows passed to fit; the test rows must not be passed there.

## Report uncertainty, not just a winner

Report the metric, split strategy, fold mean and spread, final test score, and class or group breakdowns when relevant. A small mean-score difference with high fold variation may not justify a more complex model.

## Recall questions

1. Why is choosing hyperparameters on the test set a form of leakage?
2. When is stratification useful? When is it insufficient?
3. Which steps must be inside each CV fold?
4. When should the training data precede validation data?