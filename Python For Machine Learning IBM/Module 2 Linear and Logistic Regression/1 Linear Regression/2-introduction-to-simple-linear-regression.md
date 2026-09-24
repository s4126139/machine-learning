# Introduction to Simple Linear Regression

## Intuition

Simple linear regression uses one feature, **x**, to estimate a continuous response, **y**. It places a straight line through the training data so that the squared vertical prediction errors are as small as possible. The line describes an average trend; individual observations can sit above or below it.

## Model and fitting objective

The model is

$$\hat{y} = \theta_0 + \theta_1 x,$$

where **θ₀** is the intercept and **θ₁** is the slope. Increasing *x* by one unit changes the model's predicted response by **θ₁** units, within the range where this linear relationship is reasonable.

For observation *i*, the residual is **eᵢ = yᵢ − ŷᵢ**. Ordinary least squares (OLS) chooses coefficients to minimize mean squared error:

$$\mathrm{MSE} = \frac{1}{n}\sum_{i=1}^{n}(y_i-\hat{y}_i)^2.$$

With one feature, the closed-form slope and intercept are

$$\theta_1 = \frac{\sum_i (x_i-\bar{x})(y_i-\bar{y})}{\sum_i (x_i-\bar{x})^2},\qquad \theta_0=\bar{y}-\theta_1\bar{x}.$$

Squaring makes positive and negative residuals unable to cancel and gives larger errors more weight. OLS minimizes MSE (equivalently, sum of squared errors for fixed *n*); it does not minimize the average absolute residual.

## When to use it

Use it as an interpretable baseline when one predictor has an approximately straight-line relationship with a continuous target. It is quick to fit and its slope is easy to explain. It is less suitable when the pattern is curved, important predictors are omitted, or a few extreme points dominate the fit.

## Concrete CO₂ example

A course example uses the fitted line **CO₂ = 108.05 + 39 × engine size**. At 2.4 L, the predicted emission is **108.05 + 39 × 2.4 = 201.65**. For another car with an actual value of 250 and a prediction of 340, the residual is **250 − 340 = −90** (an absolute error of 90). That observation contributes **8,100** to the sum of squared errors. The numeric line is illustrative; coefficients depend on the exact dataset and training sample.

## Scikit-learn pattern

The LinearRegression estimator fits an intercept by default and uses OLS:

```python
import pandas as pd
from sklearn.linear_model import LinearRegression

X = cars[["ENGINESIZE"]]  # keep X two-dimensional
model = LinearRegression().fit(X, cars["CO2EMISSIONS"])
model.intercept_, model.coef_[0]
model.predict(pd.DataFrame({"ENGINESIZE": [2.4]}))
```

For honest performance estimates, fit on training rows and score on held-out rows. MAE communicates a typical absolute miss; RMSE is in the target's units and emphasizes large misses.

## Assumptions and pitfalls

- For the usual interpretation, the conditional mean of *y* changes linearly with *x* and residuals are independent with roughly constant variance.
- Normal residuals are mainly needed for classical small-sample confidence intervals and tests, not to calculate OLS predictions.
- A scatter plot and residual plot help expose curvature, unequal spread, and influential outliers.
- OLS is sensitive to outliers because it squares residuals.
- Do not infer that *x* causes *y* from a fitted slope alone.
- The line can be misleading outside the observed range; avoid unsupported extrapolation.

## Active recall

1. In the CO₂ example, what does the slope 39 mean, and what does the intercept represent?
2. Why does an error of −90 contribute 8,100 to squared error?
3. Which residual-plot patterns would make you question a straight-line model?