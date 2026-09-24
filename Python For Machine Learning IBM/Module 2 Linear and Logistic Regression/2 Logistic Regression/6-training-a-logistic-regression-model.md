# Training a Logistic Regression Model

## Training loop in plain language

Training searches for coefficients **θ** that give high probabilities to the observed classes and low probabilities to the opposite classes. Conceptually, the process is:

1. Start from an initial parameter vector.
2. Compute a score and probability for each training row.
3. Measure how well predicted probabilities match labels.
4. Update the parameters to reduce that loss.
5. Repeat until the optimizer converges or reaches its iteration limit.

A first pass with arbitrary coefficients is not necessarily a good model. The optimization step is what finds useful parameters.

## Log loss

For binary labels **yᵢ ∈ {0,1}** and predicted probabilities **p̂ᵢ**, binary cross-entropy (log loss) is

$$L(\theta)=-\frac{1}{n}\sum_{i=1}^{n}\left[y_i\log(\hat{p}_i)+(1-y_i)\log(1-\hat{p}_i)\right].$$

A correct, confident prediction contributes little loss. A confident, incorrect prediction contributes a large penalty: for a true class 0, predicting p̂=0.8 costs **−log(0.2) ≈ 1.61**, while predicting p̂=0.2 costs **−log(0.8) ≈ 0.22**. Log loss evaluates probabilities; accuracy evaluates thresholded labels, so they answer different questions.

## Gradient descent and stochastic updates

Gradient descent moves parameters opposite the loss gradient:

$$\theta \leftarrow \theta - \eta\nabla_\theta L,$$

where **η** is the learning rate. A step that is too large can overshoot or diverge; one that is too small can make progress very slowly. In unregularized logistic regression the gradient has the form **Xᵀ(p̂ − y)/n** (with an intercept term handled consistently).

- **Batch gradient descent** calculates each update from all training rows. The gradient is stable but each step can be expensive on a large data set.
- **Stochastic gradient descent (SGD)** estimates an update from one randomly selected example; mini-batch methods use a small subset. These updates are cheaper and noisy, so loss may fluctuate around a minimum.
- Reducing the learning rate or increasing the batch size can make later updates steadier. Do not increase the learning rate blindly to speed convergence.

## Scikit-learn patterns

For most small to medium tabular problems, start with LogisticRegression; scikit-learn optimizes its objective using the selected solver (the default solver is lbfgs, not the SGD algorithm):

```python
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler

model = make_pipeline(
    StandardScaler(),
    LogisticRegression(C=1.0, max_iter=1000, random_state=42),
)
model.fit(X_train, y_train)
probabilities = model.predict_proba(X_test)[:, 1]
```

For an explicitly incremental stochastic method, SGDClassifier(loss="log_loss") supports logistic loss and partial_fit. Scale features, select the learning settings, and check convergence and validation performance. C in LogisticRegression is inverse regularization strength: smaller values mean stronger regularization.

## Assumptions, stopping, and pitfalls

- Scale numeric features when using gradient-based optimization, especially when units differ substantially; keep scaling in a pipeline to prevent leakage.
- Check the convergence warning and increase max_iter or reconsider scaling/solver settings when needed. An iteration limit is not itself proof of convergence.
- Regularization changes the objective by penalizing coefficient size; it helps control overfitting, but its strength should be validated.
- SGD can be cheaper per update on large data but has noisier steps; it does not guarantee lower validation log loss, and its convergence depends on the step-size schedule and data scaling.
- Class imbalance may require class weights, resampling within training folds, threshold selection, and metrics beyond accuracy.
- Select hyperparameters and decision thresholds using training/validation data. Keep the test set for final evaluation.

## Active recall

1. Why does log loss penalize a confident wrong probability more than an uncertain one?
2. What role does the learning rate play in gradient descent, and what happens if it is too large?
3. How do batch gradient descent and SGD differ in the data used for each update?