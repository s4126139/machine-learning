# Module 2 Summary and Highlights

## What the module connects

The central choice is the kind of target you need to estimate. A continuous target leads to regression; a binary target leads naturally to a probability model and a classification threshold. Within regression, the number of predictors and the shape of the relationship are independent decisions.

![Decision flow for choosing a regression family](../../assets/module-2-regression-decision-flow.svg)

## Model map

| Model | Target | Main idea | Watch for |
| --- | --- | --- | --- |
| Simple linear regression | Continuous | One feature predicts a numeric response with a line | Curvature, outliers, extrapolation |
| Multiple linear regression | Continuous | Several features contribute through a linear combination | Collinearity, leakage, implausible what-if inputs |
| Polynomial regression | Continuous | Powers/interactions create a curve while coefficients stay linear | High-degree overfit and unstable extrapolation |
| Other nonlinear regressors | Continuous | A functional form or flexible algorithm captures a more complex pattern | Validate model complexity and respect target constraints |
| Logistic regression | Binary | Sigmoid turns a linear score into a class-1 probability | Threshold choice, imbalance, calibration, log-odds interpretation |

## Key equations

- Linear prediction: **ŷ = θ₀ + θ₁x₁ + … + θₚxₚ**
- OLS objective: **MSE = (1/n) Σ(yᵢ − ŷᵢ)²**
- Logistic probability: **p̂ = 1 / (1 + e⁻ᶻ)**, where **z = θ₀ + xᵀθ**
- Binary log loss: **−(1/n) Σ[yᵢ log(p̂ᵢ) + (1−yᵢ) log(1−p̂ᵢ)]**
- Threshold rule: predict 1 when **p̂ ≥ t**; choose *t* for the decision costs and validation evidence.

## A practical modeling sequence

1. Define the target and prediction-time information; remove leakage.
2. Plot the data and establish a simple baseline.
3. Choose a model family consistent with target and likely relationship shape.
4. Split data before fitting; put preprocessing inside a pipeline.
5. Use validation or cross-validation to compare model and hyperparameter choices.
6. Evaluate the final choice on untouched test data with metrics tied to the task.
7. For classification, choose a threshold separately from fitting and report probability and class metrics.

## Active recall

1. Which decisions describe target type, predictor count, and relationship shape?
2. Why can a high-degree polynomial fit have worse test performance than a line?
3. Why are logistic probability estimation and choosing a classification threshold separate steps?