# Polynomial Regression

## Core idea

Polynomial regression extends multiple linear regression by creating transformed features such as `x²` and `x³`. The model remains linear in its parameters, but it can fit a curved relationship between the original input and the target.

## Why use polynomial features?

A straight line may not fit a dataset well. For house-price prediction, the relationship between house size `x` and price may be curved.

A quadratic model uses `x` and `x²`:

```text
f(x) = w1*x + w2*x² + b
```

This can fit a curve, but a quadratic curve may eventually turn downward. That behaviour may not make sense if larger houses are generally expected to cost more.

A cubic model adds `x³`:

```text
f(x) = w1*x + w2*x² + w3*x³ + b
```

The cubic form can produce a different curved shape that rises again as house size increases.

Both are polynomial regression because the original feature is raised to different powers and each transformed value is treated as another input feature.

## Polynomial regression as feature engineering

For the cubic model, one original feature creates three model inputs:

| Model input | Constructed feature |
|---|---|
| First feature | `x` |
| Second feature | `x²` |
| Third feature | `x³` |

Multiple linear regression can then learn a separate coefficient for each constructed feature.

## Feature scaling becomes more important

Polynomial powers can create extremely different numeric ranges.

If the original house-size feature ranges from `1` to `1,000`:

| Feature | Range |
|---|---:|
| `x` | `1` to `1,000` |
| `x²` | `1` to `1,000,000` |
| `x³` | `1` to `1,000,000,000` |

When gradient descent is used, these features should be scaled to comparable ranges.

## Other possible transformations

Polynomial powers are not the only choice. Another model could use the square root of the original feature:

```text
f(x) = w1*x + w2*sqrt(x) + b
```

The square-root curve becomes less steep as `x` increases, but it does not flatten completely or turn downward.

## Choosing features

There is no single transformation that must be used for every dataset. Possible choices include:

- the original feature `x`;
- a quadratic term `x²`;
- a cubic term `x³`;
- a square-root term `sqrt(x)`.

Different feature and model choices can be compared by measuring how well the resulting models perform. The lesson emphasises that feature engineering and polynomial functions can produce a much better fit than a straight line.

## Main takeaway

Polynomial regression fits non-linear curves by applying feature engineering to the inputs and then using multiple linear regression on the transformed features.

## ML lifecycle phase

**Primary phase: Phase 05 — Preprocessing and Feature Engineering.**

Creating `x²`, `x³`, or `sqrt(x)` is a feature-transformation task.

The choice between different polynomial forms also connects to **Phase 08 — Validation and Hyperparameter Tuning**, where alternative feature/model choices are compared.

