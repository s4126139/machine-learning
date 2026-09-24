# Introduction to Multiple Linear Regression

## Intuition

Multiple linear regression extends the one-feature line to use several predictors. It estimates each feature's contribution while holding the other modeled features fixed. With one feature the fit is a line; with two it is a plane; with more it is a hyperplane.

## Model and objective

For *p* predictors,

$$\hat{y}=\theta_0+\theta_1x_1+\theta_2x_2+\cdots+\theta_px_p=\theta_0+\mathbf{x}^{\mathsf T}\boldsymbol{\theta}.$$

The intercept is **θ₀**; **θⱼ** is the predicted change in *y* for a one-unit increase in feature *xⱼ*, holding the other included features fixed. OLS estimates coefficients by minimizing

$$\mathrm{MSE}=\frac{1}{n}\sum_{i=1}^{n}(y_i-\hat{y}_i)^2.$$

In matrix form, predictions are **ŷ = Xθ**, where the intercept can be represented by a column of ones. Inference about coefficients needs more care than this equation suggests: scaling, omitted variables, and correlated predictors affect interpretation.

## When to use it

Use it when several measured features plausibly contribute to a continuous outcome and you want an additive, interpretable baseline. For example, car emissions may depend on engine size, cylinders, and fuel consumption; a student score may depend on study time, attendance, and other factors.

A “what-if” prediction changes one or more inputs and evaluates the fitted equation. Such a scenario is credible only when the input combination is plausible and represented by the training data. If predictors move together in reality, holding one fixed while changing another may describe an impossible case.

## Concrete example

Consider a toy house-price model (price in thousands of dollars):

$$\widehat{price}=40+0.18\,area+12\,bedrooms.$$

For a 100 m² house with 3 bedrooms, the estimate is **40 + 0.18 × 100 + 12 × 3 = 94** (thousand dollars). This is an example of substitution into a model, not a claim that each additional bedroom causes a fixed price increase in every market.

## Scikit-learn pattern

For mixed numeric and categorical data, encode categories using a preprocessing pipeline so the same transformation is applied at fit and prediction time:

```python
from sklearn.compose import ColumnTransformer
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import OneHotEncoder

preprocess = ColumnTransformer(
    [("transmission", OneHotEncoder(handle_unknown="ignore"), ["TRANSMISSION"])],
    remainder="passthrough",
)
model = make_pipeline(preprocess, LinearRegression())
model.fit(X_train, y_train)
predictions = model.predict(X_test)
```

A binary category can be represented by 0/1. For a category with more than two values, one-hot encoding is a safe default. For inference and explanation, define the reference category and interpret coefficients relative to it.

## Assumptions and common pitfalls

- The expected target is linear in the coefficients; predictors may be transformed, but the coefficient relationship must match the chosen model.
- For standard coefficient inference, errors should be independent with roughly constant variance; normality matters for classical finite-sample tests.
- **Multicollinearity:** strongly correlated predictors can make individual coefficients unstable and difficult to interpret. Predictions may still be reasonable, but “importance” from coefficient magnitude becomes unreliable.
- Too many predictors, interactions, or polynomial terms can overfit. Evaluate on held-out data and use regularization or feature selection when appropriate.
- Encode categorical predictors; do not assign arbitrary numeric order to nominal categories.
- A coefficient is conditional on the other included features and their units. Standardize before comparing coefficient magnitudes across differently scaled features, and do not treat those magnitudes as causal importance.
- Do not build a what-if scenario that combines feature values in ways absent or impossible in the data.

## Active recall

1. What does a multiple-regression coefficient mean when other predictors are held fixed?
2. Why can collinearity make a “what-if” scenario or coefficient interpretation unreliable?
3. How should a three-category nominal feature be represented for a typical scikit-learn model?