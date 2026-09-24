# Regularization in Regression and Classification

## Why regularize?

An overly flexible model can fit random fluctuations in training data and perform poorly on new data. Regularization adds a penalty for large coefficients to the training objective. It trades some training fit for a simpler, more stable model.

For linear regression with coefficient vector beta, a common objective is:

    mean_squared_error(y, X beta) + lambda * penalty(beta)

The intercept is normally not penalized. The strength lambda is selected using validation or cross-validation.

## Ridge and Lasso

- **Ordinary least squares:** minimizes squared error with no coefficient penalty. It can have high variance when features are numerous, correlated, or noisy.
- **Ridge (L2):** adds lambda × sum(beta_j squared). It shrinks coefficients toward zero, usually without making them exactly zero. It is useful when many features contribute small or shared effects and often behaves well with correlated predictors.
- **Lasso (L1):** adds lambda × sum(abs(beta_j)). It can set coefficients exactly to zero, producing a sparse model and acting as a form of feature selection. With strongly correlated features, which member survives can be unstable.
- **Elastic Net:** combines L1 and L2 penalties; useful when sparsity is wanted but correlated predictors should be treated more stably.

The course simulation compared sparse and non-sparse coefficients under high and low signal-to-noise conditions. Lasso recovered zero coefficients in sparse cases more readily; ridge often retained groups of smaller correlated effects. With low signal-to-noise ratio, ordinary least squares could overreact to noise. These are tendencies, not guarantees that Lasso always wins.

## Scaling and tuning

Regularization penalizes coefficient magnitudes, so feature units affect the penalty. Standardize numeric predictors inside the training fold, then tune alpha / lambda using a validation set or cross-validation. Larger penalties shrink more and can underfit; smaller penalties approach unregularized fitting.

For scikit-learn’s Ridge and Lasso estimators, alpha is the penalty strength: larger alpha means stronger regularization. In LogisticRegression, C has the inverse relationship: smaller C means stronger regularization. Check the estimator’s solver and supported penalty for the installed scikit-learn version.

## scikit-learn patterns

    from sklearn.linear_model import Lasso, Ridge
    from sklearn.pipeline import make_pipeline
    from sklearn.preprocessing import StandardScaler

    ridge = make_pipeline(StandardScaler(), Ridge(alpha=1.0))
    lasso = make_pipeline(StandardScaler(), Lasso(alpha=0.05, max_iter=10000))
    ridge.fit(X_train, y_train)
    lasso.fit(X_train, y_train)

For classification, LogisticRegression applies regularization to a classification loss. Compare candidate C values through cross-validation rather than choosing them from final test performance.

## Strengths, limits, and interpretation

Regularization reduces coefficient size and can improve generalization; L1 can yield a compact model. It does not remove the need for sound feature design or validation. L1 selection among correlated features may be unstable, and a zero coefficient is not evidence that a feature has no causal effect. Standardize in a pipeline and inspect validation performance, coefficient stability, and residual or classification errors.

## Recall questions

1. How do L1 and L2 penalties differ?
2. Why should features be scaled before coefficient regularization?
3. How does alpha in Ridge differ from C in LogisticRegression?
4. When might Elastic Net be preferable to pure Lasso?