# Regression Metrics and Evaluation Techniques

## Prediction errors

For each observation, residual = actual value − predicted value. A regression metric summarizes residual magnitude or variation over a dataset. Inspect plots as well as a single number: errors can be biased, heteroscedastic, nonlinear, or concentrated in a subgroup.

## Common metrics

For n observations, actual values y_i and predictions yhat_i:

- **MAE** = (1/n) × sum |y_i − yhat_i|. Average absolute miss in the target’s units. It is easy to explain and less sensitive to extreme errors than squared-error metrics.
- **MSE** = (1/n) × sum (y_i − yhat_i)^2. Squares residuals, so a few large misses can dominate. Units are squared.
- **RMSE** = sqrt(MSE). Same units as the target; still gives large errors extra weight.
- **R-squared** = 1 − [sum (y_i − yhat_i)^2 / sum (y_i − mean(y))^2]. Measures improvement over predicting the evaluation-set target mean baseline. It may be negative when the model is worse than that baseline; it is not restricted to 0–1 on held-out data.
- **Explained variance** compares residual variance with target variance. It can differ from R-squared when residuals have nonzero mean.

Ordinary MSE averages over observations. A degrees-of-freedom correction is used in some statistical estimates of residual variance; it is not the default predictive MSE definition.

## Choose a metric for the decision

| Situation | Useful view | Trade-off |
| --- | --- | --- |
| Typical absolute miss matters | MAE | Gives extreme errors less influence. |
| Large mistakes are especially costly | RMSE / MSE | Penalizes large errors strongly. |
| Compare with a mean-prediction baseline | R-squared | Can be negative; not an error in target units. |
| Need the whole error pattern | Residual and actual-vs-predicted plots | Visuals show bias and subgroup structure that averages hide. |

Compare models on the same held-out observations and target scale. A model can have better R-squared but worse MAE if it fits most points well while making a few large errors.

## scikit-learn pattern

    from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
    import numpy as np

    mae = mean_absolute_error(y_test, predictions)
    rmse = np.sqrt(mean_squared_error(y_test, predictions))
    r2 = r2_score(y_test, predictions)

Then inspect residuals against fitted values and important features. Look for curvature, unequal spread, large outliers, and systematic subgroup errors.

## Skewed targets and transformations

A log or Box–Cox transform can make a strongly right-skewed target easier to model, as in the course example where log-transformed exam-like values lined up more closely with a linear trend. But transformation changes the scale and interpretation of loss. If predictions are used in original units, invert the transformation and evaluate there as well. Fit any learned transformation using training data only; a target-transform wrapper inside cross-validation can manage this safely.

## Pitfalls and recall

- R-squared is not a universal measure of predictive quality and may be negative out of sample.
- The same RMSE can have different practical meaning for different target ranges.
- A few large errors can make RMSE much worse than MAE.
- Plot residuals and define which errors are costly before choosing a metric.

1. Why is RMSE easier to interpret than MSE?
2. What does a negative test R-squared mean?
3. When would MAE be preferable to RMSE?
4. What extra checks are needed after transforming a target?