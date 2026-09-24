# Introduction to Logistic Regression

## Intuition

Despite its name, logistic regression is commonly used for **classification**. It first estimates the probability of a binary outcome, then a decision threshold turns that probability into a class. In a churn example, the model can estimate the probability that a customer leaves; a business rule then decides which customers to flag.

## Core equations

A linear score is

$$z=\theta_0+\theta_1x_1+\cdots+\theta_px_p.$$

The sigmoid (logistic) function maps any real score into a probability:

$$\sigma(z)=\frac{1}{1+e^{-z}},\qquad \hat{p}=P(y=1\mid\mathbf{x})=\sigma(z).$$

The probability of class 0 is **1 − p̂**. With threshold *t*, predict class 1 when **p̂ ≥ t** and class 0 otherwise. The default threshold is often 0.5, but it is a decision choice, not a law. At *t*=0.5, the boundary is **z=0**; changing the threshold changes the boundary and the balance between false positives and false negatives.

The **logit** is the inverse of the sigmoid: **log(p/(1−p)) = z**. In a standard logistic model, a coefficient is a change in log-odds per unit increase in a feature, conditional on the other features. **exp(θⱼ)** is the corresponding odds multiplier. Logistic regression can produce useful probabilities, but coefficient size alone is not a reliable feature-importance ranking when units, scaling, or collinearity differ.

## When to use it

Use it for a binary label when you need a baseline with interpretable probability estimates, such as churn/no churn, failure/no failure, or disease/no disease. The model assumes that the log-odds are a linear combination of the chosen features unless you add transformations or interactions. It is a good first classifier when that assumption is reasonable and a linear decision boundary is suitable.

## Concrete example

If a customer has estimated churn probability **0.8**, the estimated probability of staying is **1 − 0.8 = 0.2**. At a threshold of 0.5, classify this customer as a churn risk. A retention team with limited capacity could raise the threshold; an application where missing a likely churner is costly could lower it. Choose a threshold based on validation data and the consequences of each error.

## Scikit-learn pattern

Scale numeric features inside a pipeline, fit only on training data, and inspect probabilities separately from class labels:

```python
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler

model = make_pipeline(StandardScaler(), LogisticRegression(max_iter=1000))
model.fit(X_train, y_train)
churn_probability = model.predict_proba(X_test)[:, 1]
churn_class = (churn_probability >= 0.5).astype(int)
```

For mixed numeric and categorical inputs, use a ColumnTransformer with OneHotEncoder as in the multiple-regression note, then place it before the classifier in the pipeline. Scikit-learn also supports multiclass logistic regression; the binary probability interpretation above is for two classes.

## Assumptions and common pitfalls

- The basic formulation expects two target classes; define which class is positive before interpreting probability column 1.
- Numeric predictors should have an approximately linear relationship with log-odds, unless transformed or combined with interactions.
- Strongly correlated features can destabilize coefficient interpretation. Complete class separation and very small data sets can also cause unstable estimates.
- A probability is not a class until a threshold is chosen. Accuracy alone can hide poor performance on imbalanced data; inspect precision, recall, the confusion matrix, and the precision-recall or ROC curve as relevant.
- The default 0.5 threshold is not necessarily suitable, and a predicted probability is not automatically well calibrated.
- The coefficient describes conditional association in the model, not causation.

## Active recall

1. What does the sigmoid add to the linear score, and why is the output useful?
2. How does changing the probability threshold alter classification decisions?
3. How should you interpret a logistic coefficient, and why is that not a causal claim?