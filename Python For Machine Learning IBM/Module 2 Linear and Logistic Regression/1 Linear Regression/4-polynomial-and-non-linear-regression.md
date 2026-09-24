# Polynomial and Nonlinear Regression

## Intuition

A straight line can miss a curved trend. Polynomial regression adds powers of a feature so a linear fitting method can trace a curve. More generally, regression can use transformed features or flexible models to represent nonlinear patterns such as growth, saturation, or seasonality.

The word **linear** is used in two ways. A polynomial curve is nonlinear in *x*, but it is linear in its coefficients, so OLS can fit it after expanding the features. A model such as **y = a e^(b x)** is nonlinear in parameter *b* and generally requires nonlinear optimization (or a carefully justified transformation).

## Core equations

A quadratic model is

$$\hat{y}=\theta_0+\theta_1x+\theta_2x^2,$$

and a cubic model adds **θ₃x³**. By defining new predictors **x₁=x**, **x₂=x²**, and **x₃=x³**, these become ordinary multiple linear regression in the coefficients. A transformed model such as **ŷ = θ₀ + θ₁ log(1+x)** is also linear in its coefficients, even though it is curved as a function of *x*.

Other patterns call for a suitable functional form or model:

- **Exponential or compound growth:** for example, investment growth; a simple exponential model is **y = a e^(b x)**.
- **Logarithmic diminishing returns:** early increases in an input can bring larger gains than later increases.
- **Periodic behavior:** seasonal rainfall or temperature can be represented with sine/cosine terms or seasonal features.
- **Flexible models:** trees, random forests, support-vector regression, nearest neighbors, boosting, or neural networks can capture patterns without specifying one polynomial curve.

## When to use it

Inspect a scatter plot of the target against each important feature and residual plots from a simple baseline. Try a low-degree polynomial or meaningful transformation when a smooth curve is visible and the relationship is plausible. Use a more flexible model when the shape is complex or involves interactions that a hand-specified equation cannot capture.

## Concrete example

Suppose productivity increases quickly with consecutive hours worked, then each additional hour contributes less. A line may underpredict the early gains and overpredict the later ones. A concave curve such as **ŷ = 20 + 15 log(1 + hours)** illustrates diminishing returns: its slope decreases as hours increase. The function is only a candidate; it must be checked against observed data and should not be extrapolated beyond the hours studied.

## Scikit-learn pattern: polynomial features

```python
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import PolynomialFeatures, StandardScaler

model = make_pipeline(
    PolynomialFeatures(degree=2, include_bias=False),
    StandardScaler(),
    LinearRegression(),
)
model.fit(X_train, y_train)
predictions = model.predict(X_test)
```

Keep feature generation inside a pipeline, and choose degree using cross-validation on the training set. PolynomialFeatures creates the powers and optional interactions. Standardization is especially useful for higher powers and optimization-based models.

## Assumptions and common pitfalls

- Polynomial regression is still linear in its coefficients, so it can be fit by linear regression after feature expansion.
- A high-degree polynomial can pass close to every training point yet model noise rather than the underlying trend. Prefer the simplest degree that validates well.
- Polynomial values can grow rapidly beyond the observed range; extrapolation is especially risky.
- With multiple inputs, polynomial expansion creates many interaction terms and can quickly increase model complexity.
- A curved residual pattern suggests the straight-line model is inadequate, but it does not identify which curve is correct. Compare candidates using held-out data.
- Some relationships are not polynomial. Select a model that matches the problem and respect constraints such as nonnegative targets or saturation.

## Active recall

1. Why can a polynomial curve be fitted by ordinary linear regression?
2. How does a high polynomial degree lead to overfitting and unreliable extrapolation?
3. What pattern would make a logarithmic model plausible, and what data should you use to choose it?