# Cheat Sheet: Linear and Logistic Regression

## Quick choice

| Question | Start here |
| --- | --- |
| Is the target a numeric quantity? | Regression; begin with LinearRegression |
| Does one feature show a roughly straight trend? | Simple linear regression |
| Do several features help predict the value? | Multiple linear regression; encode categories in a pipeline |
| Is there a smooth curve? | Try low-degree polynomial/feature transforms; validate degree |
| Is the target binary and do you need probabilities? | LogisticRegression; then choose a threshold for the decision |

![Regression-family decision flow](../../assets/module-2-regression-decision-flow.svg)

## Equations to remember

| Concept | Equation | Meaning |
| --- | --- | --- |
| Linear prediction | **ŷ = θ₀ + Σⱼ θⱼxⱼ** | Numeric estimate from an intercept and weighted features |
| Residual | **eᵢ = yᵢ − ŷᵢ** | Actual minus predicted value |
| Mean squared error | **MSE = (1/n)Σᵢeᵢ²** | OLS fit objective; heavily penalizes large residuals |
| Sigmoid | **σ(z)=1/(1+e⁻ᶻ)** | Maps a real-valued score to (0,1) |
| Logistic probability | **p̂=P(y=1|x)=σ(θ₀+xᵀθ)** | Estimated class-1 probability |
| Binary log loss | **−(1/n)Σᵢ[yᵢlog(p̂ᵢ)+(1−yᵢ)log(1−p̂ᵢ)]** | Penalizes incorrect probabilities, especially confident ones |
| Gradient step | **θ ← θ − η∇L** | Move parameters downhill; η is the learning rate |

## Minimal scikit-learn patterns

**Continuous target:**

```python
from sklearn.linear_model import LinearRegression

model = LinearRegression().fit(X_train, y_train)
y_pred = model.predict(X_test)
```

**Binary target with probabilities:**

```python
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler

model = make_pipeline(StandardScaler(), LogisticRegression(max_iter=1000))
model.fit(X_train, y_train)
p1 = model.predict_proba(X_test)[:, 1]
y_pred = (p1 >= 0.5).astype(int)  # pick threshold using validation evidence
```

For categories, use a ColumnTransformer with OneHotEncoder(handle_unknown="ignore"). Fit all preprocessing only on training data by keeping it inside a scikit-learn pipeline.

## Interpretation and evaluation reminders

- Linear coefficient: expected change in *y* per feature unit, holding other included features fixed; units and collinearity matter.
- Logistic coefficient: change in log-odds per feature unit; exp(coef) is an odds multiplier, not a probability increment.
- Regression metrics: MAE is easy to interpret; RMSE emphasizes large errors; compare with a baseline.
- Classification: inspect a confusion matrix, precision/recall, and ROC-AUC or PR-AUC as appropriate; accuracy alone can mislead on imbalanced data.
- A 0.5 threshold is a default, not a requirement. Select a threshold using task costs and validation data.

## Common mistakes

- Treating a binary label as an ordinary continuous target without a reason.
- Evaluating on training rows or tuning repeatedly against the test set.
- Letting preprocessing learn from test rows.
- Assuming correlation implies causation or that feature coefficients are universal importance scores.
- Using polynomial degree high enough to memorize noise, then trusting extrapolated predictions.
- Ignoring outliers in OLS, collinearity in multiple regression, or class imbalance in logistic regression.